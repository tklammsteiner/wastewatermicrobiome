library(sf)
library(raster)
library(spData)
library(spDataLarge)
library(readxl)

library(tmap)    # for static and interactive maps
library(leaflet) # for interactive maps
library(ggplot2) # tidyverse data visualization package
library(dplyr)

data <- read_xlsx("C:/Users/Administrator/Dropbox/Master Students/Maria Payr/metadata_15_03.xlsx")

data <- data %>% select(Standort, dcpLatitude, dcpLongitude) %>% rename('Latitude' = 'dcpLatitude', 'Longitude' = 'dcpLongitude')

write.csv(data, "data/wwtp-locations.csv", row.names = )

data <- read.csv("data/wwtp-locations.csv")

wwtp <- makeAwesomeIcon(
  icon = "tint",
  iconColor = "black",
  markerColor = "beige",
  library = "fa"
)


data %>% 
  leaflet() %>% 
  addProviderTiles(providers$Esri.WorldImagery, group = "World Imagery") %>% 
  addProviderTiles(providers$Stamen.TonerLite, group = "Toner Lite") %>% 
  addLayersControl(baseGroups = c('Toner Lite', "World Imagery")) %>% 
  addAwesomeMarkers(data$Longitude,
             data$Latitude, 
             label = data$Standort,
             icon = wwtp, 
             popup = data$Standort) %>% 
  addMiniMap(toggleDisplay = TRUE,
             tiles = providers$Stamen.TonerLite)

