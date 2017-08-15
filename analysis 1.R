


ggplot(temp, aes(x=temp$INFODT, y=temp$NP3RIGLL)) +geom_point() +
  facet_wrap(~names(measured), scales = "free_x") +geom_smooth(method=lm) + 
  ylim(0,4)

install.packages("lubridate")
library(lubridate)

# change the dates to day of year
temp$INFODT = yday(temp$INFODT)

# make a long version of data --> newtemp only contains the ones relevant mds data
temp2 = temp[,c(1, 6, 9:43)]
newtemp = melt(temp2, id=c("PATNO", "INFODT"))

# make new dataframe
newtemp2 = data.frame()

# loop through and change the dates to day past initial visit
for (patient in levels(factor(newtemp$PATNO))) {
  temp_pat = data.frame()
  temp_pat = newtemp[newtemp$PATNO==patient,]
  
  # find min value of dates
  temp_min = min(temp_pat$INFODT)
  temp_pat$INFODT = (temp_pat$INFODT - temp_min)
  
  newtemp2 = rbind(newtemp2, temp_pat)
}

