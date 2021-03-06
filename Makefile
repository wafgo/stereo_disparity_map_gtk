RM := rm -rf
CC := gcc

OBJS += \
core.o 

USER_OBJS +=

C_DEPS += $(OBJS:.o=.d)

C_FLAGS += -std=gnu99 -O0 -g3 -Wall -fmessage-length=0

INCLUDE_PATH += -I/usr/include/gtk-3.0 -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -I/usr/include/pango-1.0 -I/usr/include/cairo -I/usr/include/gdk-pixbuf-2.0 -I/usr/include/atk-1.0

%.o: %.c
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C Compiler'
	$(CC) $(INCLUDE_PATH) $(C_FLAGS) -c -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

LIBS := -lglib-2.0 -lgtk-3 -lgobject-2.0 -lgdk-3 -lgdk_pixbuf-2.0 -lc -lm

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS)
endif
endif


all: disp_calc.elf

disp_calc.elf: $(OBJS) $(USER_OBJS)
	@echo 'Building target: $@'
	@echo 'Invoking: GCC C Linker'
	gcc  -o "disp_calc" $(OBJS) $(USER_OBJS) $(LIBS)
	@echo 'Finished building target: $@'
	@echo ' '

clean:
	-$(RM) $(EXECUTABLES)$(OBJS)$(C_DEPS) disp_calc
	-@echo ' '

.PHONY: all clean dependents
.SECONDARY:

