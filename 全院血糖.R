
setwd("C:/GITHUB/2021-glucose") 
library(readxl)
# before<-as.character(read.table("clipboard",header=T,sep="\t")[,1])
# after<-as.character(read.table("clipboard",header=T,sep="\t")[,1])
# write.csv(table(before),"before.csv")
# write.csv(table(after),"after.csv")
# gdata_endo<-as.data.frame(read_excel("total2019.xlsx",sheet=1,col_names = T,col_types = NULL ,na="", skip=0))                    
# colnames(gdata_endo)[14]<-"时间点"
# gdata_nei<-as.data.frame(read_excel("total2019.xlsx",sheet=2,col_names = T,col_types = NULL ,na="", skip=0))                    
# colnames(gdata_nei)[14]<-"时间点"
gdata_wai<-as.data.frame(read_excel("total2019.xlsx",sheet=3,col_names = T,col_types = NULL ,na="", skip=0))                    
colnames(gdata_wai)[14]<-"时间点"
# gdata_jian<-as.data.frame(read_excel("total2019.xlsx",sheet=4,col_names = T,col_types = NULL ,na="", skip=0))                    
# colnames(gdata_jian)[14]<-"时间点"

#difftime("2019-01-26 20:29:11 UTC","2019-01-27 06:10:08 UTC",units="hours")   #前-后


#认为原始数据里，已按人-时间排序
r_low<-c()
for (r in c(1:dim(gdata_wai)[1])){
  if (gdata_wai$血糖数值[r]<3.9){
    r_low<-append(r_low,r)
  }
}
r_low

gdata_wai<-gdata_wai[c(1:200),]

r_fuce<-c()
gdata_wai$低血糖复测<-NA
gdata_wai$低血糖复测时间<-NA
for (r in r_low){
  r2<-r+1
  #print(r)
  if (gdata_wai$住院号[r2] != gdata_wai$住院号[r]){ 
    print('2')
  }  else{
           t<-difftime(gdata_wai$采血时间[r2],gdata_wai$采血时间[r],units="mins")   #前-后
           if (t>=5 & t<90){
             gdata_wai$低血糖复测[r]<-1
             gdata_wai$低血糖复测时间[r]<-t
           }else{
             gdata_wai$低血糖复测[r]<-0
           }
       }
}


gdata_wai$姓名


write.csv(table(gdata_wai$低血糖复测),"temp.csv")
