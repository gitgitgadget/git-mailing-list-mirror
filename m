From: "Pelle Svensson" <pelle2004@gmail.com>
Subject: Re: newbie question - git-pull and local branch merge
Date: Fri, 22 Dec 2006 12:26:50 +0100
Message-ID: <6bb9c1030612220326w6ce88d0ar1ca5ca49b306c71e@mail.gmail.com>
References: <6bb9c1030612220227h2dc83a78u2e31e0f4e6801412@mail.gmail.com>
	 <7vejqs1a3r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 12:27:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxiYP-0006PZ-Qg
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 12:27:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030181AbWLVL0x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 06:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964942AbWLVL0x
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 06:26:53 -0500
Received: from nz-out-0506.google.com ([64.233.162.238]:13490 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964845AbWLVL0u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 06:26:50 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1152973nze
        for <git@vger.kernel.org>; Fri, 22 Dec 2006 03:26:50 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NxLe5FBUr3AZzJrY+vQ65CWVpFSp6r17WCFBxZzW2uZ6pyr8XPcyC276FJZqOBtvTRtxRNvRezVst5bzCUPcJUo1A6qW8VpRMNYbMlJGttq0br7BeSdLnmQaEyNjEIUgDBHFa7EWL7tqJ+1dYQsBziThMydeNx10XF/jjGtFgr0=
Received: by 10.35.38.17 with SMTP id q17mr16973520pyj.1166786810187;
        Fri, 22 Dec 2006 03:26:50 -0800 (PST)
Received: by 10.35.51.20 with HTTP; Fri, 22 Dec 2006 03:26:50 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vejqs1a3r.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35162>

Problem is that git-pull failed to merge closed to what you describe in case 2
and I really like to know hat has been done between the 2 last versions
on the Linus side.

The problematic file is include/asm-arm/system.h

I attached some output below. Last (D) is a file diff between the time when
I first pulled the Linus tree and a copy of that which I'm now working in.
I think the resolve/edit part is easy because Linus tree seem to added
an extern declaration of 'adjust_cr' closed to line 152 and the other
conflict code (++<<<...) should be removed.

But is it not possible to show changes/diff version by version of
what has been done in the Linus tree?

Can you tell me if the last pull of Linus code is in the repository
or not. For me it looks like it is because all related files are touched.

/Thanks

A. git-status output
B. git-diff output
C. And if I do git-pull again
D. diff output between file stamp 12-dec and 21-dec

A. git-status output
============

# On branch refs/heads/ep93xx-pmp
#
# Updated but not checked in:
#   (will commit)
#
#	modified: Documentation/block/biodoc.txt
#	modified: Documentation/kernel-parameters.txt
#	modified: Documentation/powerpc/booting-without-of.txt
#	modified: Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl
#	modified: MAINTAINERS
#	modified: arch/arm/configs/ep93xx_defconfig
#	modified: arch/arm/configs/iop13xx_defconfig
#	modified: arch/arm/configs/iop32x_defconfig
#	modified: arch/arm/configs/iop33x_defconfig
#	modified: arch/arm/configs/ixp2000_defconfig
#	modified: arch/arm/configs/ixp23xx_defconfig
#	modified: arch/arm/configs/lpd270_defconfig
#	modified: arch/arm/configs/onearm_defconfig
#	modified: arch/arm/kernel/calls.S
#	modified: arch/arm/kernel/setup.c
#	modified: arch/arm/kernel/sys_arm.c
#	modified: arch/arm/mach-iop13xx/iq81340mc.c
#	modified: arch/arm/mach-iop13xx/iq81340sc.c
#	modified: arch/arm/mach-iop13xx/irq.c
#	modified: arch/arm/mach-iop13xx/setup.c
#	modified: arch/arm/mach-s3c2410/Kconfig
#	modified: arch/arm/mach-s3c2410/cpu.c
#	modified: arch/arm/mach-s3c2410/devs.c
#	modified: arch/arm/mach-s3c2410/dma.c
#	modified: arch/arm/mach-s3c2410/irq.h
#	modified: arch/arm/mach-s3c2410/mach-anubis.c
#	modified: arch/arm/mach-s3c2410/mach-bast.c
#	modified: arch/arm/mach-s3c2410/mach-h1940.c
#	modified: arch/arm/mach-s3c2410/mach-n30.c
#	modified: arch/arm/mach-s3c2410/mach-nexcoder.c
#	modified: arch/arm/mach-s3c2410/mach-osiris.c
#	modified: arch/arm/mach-s3c2410/mach-otom.c
#	modified: arch/arm/mach-s3c2410/mach-smdk2410.c
#	modified: arch/arm/mach-s3c2410/mach-smdk2413.c
#	modified: arch/arm/mach-s3c2410/mach-smdk2440.c
#	modified: arch/arm/mach-s3c2410/mach-vr1000.c
#	modified: arch/arm/mach-s3c2410/mach-vstms.c
#	modified: arch/arm/mach-s3c2410/pm-simtec.c
#	modified: arch/arm/mach-s3c2410/pm.c
#	modified: arch/arm/mach-s3c2410/s3c2410-clock.c
#	modified: arch/arm/mach-s3c2410/s3c2410-dma.c
#	modified: arch/arm/mach-s3c2410/s3c2410-pm.c
#	modified: arch/arm/mach-s3c2410/s3c2410.c
#	modified: arch/arm/mach-s3c2410/s3c2412-clock.c
#	modified: arch/arm/mach-s3c2410/s3c2412-dma.c
#	modified: arch/arm/mach-s3c2410/s3c2412.c
#	modified: arch/arm/mach-s3c2410/s3c2440-clock.c
#	modified: arch/arm/mach-s3c2410/s3c2440-dma.c
#	modified: arch/arm/mach-s3c2410/s3c2440.c
#	modified: arch/arm/mach-s3c2410/s3c2440.h
#	modified: arch/arm/mach-s3c2410/s3c2442-clock.c
#	modified: arch/arm/mach-s3c2410/s3c2442.c
#	modified: arch/arm/mach-s3c2410/s3c244x.c
#	modified: arch/arm/mach-s3c2410/usb-simtec.h
#	modified: arch/arm/mm/ioremap.c
#	modified: arch/arm/mm/mmu.c
#	modified: arch/arm/mm/proc-xsc3.S
#	modified: arch/i386/pci/fixup.c
#	modified: arch/powerpc/boot/Makefile
#	modified: arch/powerpc/configs/cell_defconfig
#	modified: arch/powerpc/kernel/of_platform.c
#	modified: arch/powerpc/kernel/pci_64.c
#	modified: arch/powerpc/kernel/prom_parse.c
#	modified: arch/powerpc/kernel/signal_32.c
#	modified: arch/powerpc/platforms/Makefile
#	modified: arch/powerpc/platforms/cell/io-workarounds.c
#	modified: arch/powerpc/platforms/cell/spu_priv1_mmio.c
#	modified: arch/powerpc/platforms/iseries/Kconfig
#	modified: arch/powerpc/sysdev/mpic.c
#	modified: arch/x86_64/Kconfig
#	modified: arch/x86_64/kernel/pci-calgary.c
#	modified: block/cfq-iosched.c
#	modified: block/elevator.c
#	modified: block/ll_rw_blk.c
#	modified: block/scsi_ioctl.c
#	modified: drivers/acpi/ibm_acpi.c
#	modified: drivers/ata/ahci.c
#	modified: drivers/ata/libata-scsi.c
#	modified: drivers/ata/pata_cs5530.c
#	modified: drivers/ata/pata_via.c
#	modified: drivers/ata/sata_nv.c
#	modified: drivers/ata/sata_svw.c
#	modified: drivers/ata/sata_vsc.c
#	modified: drivers/block/cciss.c
#	modified: drivers/block/viodasd.c
#	modified: drivers/bluetooth/hci_usb.c
#	modified: drivers/cdrom/cdrom.c
#	modified: drivers/cdrom/viocd.c
#	modified: drivers/char/drm/drmP.h
#	modified: drivers/char/drm/drm_lock.c
#	modified: drivers/char/drm/drm_stub.c
#	modified: drivers/char/drm/drm_sysfs.c
#	modified: drivers/char/drm/i915_irq.c
#	modified: drivers/char/drm/r128_drm.h
#	modified: drivers/char/drm/r128_drv.h
#	modified: drivers/char/drm/r128_state.c
#	modified: drivers/char/drm/r300_cmdbuf.c
#	modified: drivers/char/drm/radeon_drv.h
#	modified: drivers/char/drm/radeon_irq.c
#	modified: drivers/char/drm/radeon_mem.c
#	modified: drivers/char/drm/radeon_state.c
#	modified: drivers/char/drm/savage_bci.c
#	modified: drivers/char/viocons.c
#	modified: drivers/char/viotape.c
#	modified: drivers/ide/pci/atiixp.c
#	modified: drivers/net/iseries_veth.c
#	modified: drivers/pci/hotplug/acpiphp_glue.c
#	modified: drivers/pci/hotplug/rpaphp_slot.c
#	modified: drivers/pci/hotplug/shpchp.h
#	modified: drivers/pci/hotplug/shpchp_core.c
#	modified: drivers/pci/hotplug/shpchp_ctrl.c
#	modified: drivers/pci/hotplug/shpchp_hpc.c
#	modified: drivers/pci/htirq.c
#	modified: drivers/pci/pci-driver.c
#	modified: drivers/pci/pci.c
#	modified: drivers/pci/pcie/portdrv_pci.c
#	modified: drivers/pci/probe.c
#	modified: drivers/pci/quirks.c
#	modified: drivers/pci/search.c
#	modified: drivers/pci/setup-res.c
#	modified: drivers/scsi/scsi_lib.c
#	modified: drivers/usb/class/usblp.c
#	modified: drivers/usb/core/devio.c
#	modified: drivers/usb/gadget/at91_udc.c
#	modified: drivers/usb/gadget/at91_udc.h
#	modified: drivers/usb/gadget/dummy_hcd.c
#	modified: drivers/usb/gadget/file_storage.c
#	modified: drivers/usb/gadget/gmidi.c
#	modified: drivers/usb/gadget/goku_udc.c
#	modified: drivers/usb/gadget/lh7a40x_udc.c
#	modified: drivers/usb/gadget/net2280.c
#	modified: drivers/usb/gadget/omap_udc.c
#	modified: drivers/usb/gadget/pxa2xx_udc.c
#	modified: drivers/usb/gadget/serial.c
#	modified: drivers/usb/host/ohci-at91.c
#	modified: drivers/usb/host/ohci-au1xxx.c
#	modified: drivers/usb/host/ohci-dbg.c
#	modified: drivers/usb/host/ohci-ep93xx.c
#	modified: drivers/usb/host/ohci-hcd.c
#	modified: drivers/usb/host/ohci-hub.c
#	modified: drivers/usb/host/ohci-lh7a404.c
#	modified: drivers/usb/host/ohci-mem.c
#	modified: drivers/usb/host/ohci-omap.c
#	modified: drivers/usb/host/ohci-pci.c
#	modified: drivers/usb/host/ohci-pnx4008.c
#	new file: drivers/usb/host/ohci-pnx8550.c
#	modified: drivers/usb/host/ohci-ppc-soc.c
#	modified: drivers/usb/host/ohci-pxa27x.c
#	modified: drivers/usb/host/ohci-q.c
#	modified: drivers/usb/host/ohci-s3c2410.c
#	modified: drivers/usb/host/ohci-sa1111.c
#	modified: drivers/usb/host/ohci.h
#	modified: drivers/usb/host/u132-hcd.c
#	modified: drivers/usb/host/uhci-hcd.c
#	modified: drivers/usb/host/uhci-hub.c
#	modified: drivers/usb/input/wacom_sys.c
#	modified: drivers/usb/input/wacom_wac.c
#	modified: drivers/usb/misc/auerswald.c
#	modified: drivers/usb/misc/ftdi-elan.c
#	modified: drivers/usb/misc/phidgetservo.c
#	modified: drivers/usb/misc/trancevibrator.c
#	modified: drivers/usb/net/gl620a.c
#	modified: drivers/usb/net/rtl8150.c
#	modified: drivers/usb/serial/airprime.c
#	modified: drivers/usb/serial/cp2101.c
#	modified: drivers/usb/serial/cypress_m8.c
#	modified: drivers/usb/serial/ftdi_sio.c
#	modified: drivers/usb/serial/ftdi_sio.h
#	modified: drivers/usb/serial/funsoft.c
#	modified: drivers/usb/serial/kl5kusb105.c
#	modified: drivers/usb/serial/mos7840.c
#	modified: drivers/usb/serial/option.c
#	modified: drivers/usb/storage/unusual_devs.h
#	modified: drivers/video/pxafb.c
#	modified: drivers/video/sa1100fb.c
#	modified: fs/dlm/lowcomms-tcp.c
#	modified: fs/gfs2/Kconfig
#	modified: fs/pipe.c
#	modified: include/asm-arm/arch-iop13xx/iq81340.h
#	modified: include/asm-arm/arch-ixp23xx/memory.h
#	modified: include/asm-arm/arch-s3c2410/anubis-cpld.h
#	modified: include/asm-arm/arch-s3c2410/anubis-irq.h
#	modified: include/asm-arm/arch-s3c2410/anubis-map.h
#	modified: include/asm-arm/arch-s3c2410/audio.h
#	modified: include/asm-arm/arch-s3c2410/bast-cpld.h
#	modified: include/asm-arm/arch-s3c2410/bast-irq.h
#	modified: include/asm-arm/arch-s3c2410/bast-map.h
#	modified: include/asm-arm/arch-s3c2410/bast-pmu.h
#	modified: include/asm-arm/arch-s3c2410/h1940-latch.h
#	modified: include/asm-arm/arch-s3c2410/hardware.h
#	modified: include/asm-arm/arch-s3c2410/iic.h
#	modified: include/asm-arm/arch-s3c2410/leds-gpio.h
#	modified: include/asm-arm/arch-s3c2410/map.h
#	modified: include/asm-arm/arch-s3c2410/nand.h
#	modified: include/asm-arm/arch-s3c2410/osiris-cpld.h
#	modified: include/asm-arm/arch-s3c2410/regs-serial.h
#	modified: include/asm-arm/arch-s3c2410/system.h
#	modified: include/asm-arm/arch-s3c2410/timex.h
#	modified: include/asm-arm/arch-s3c2410/uncompress.h
#	modified: include/asm-arm/arch-s3c2410/usb-control.h
#	modified: include/asm-arm/arch-s3c2410/vr1000-cpld.h
#	modified: include/asm-arm/arch-s3c2410/vr1000-irq.h
#	modified: include/asm-arm/arch-s3c2410/vr1000-map.h
#	modified: include/asm-arm/elf.h
#	modified: include/asm-arm/unistd.h
#	modified: include/asm-generic/vmlinux.lds.h
#	modified: include/asm-powerpc/spu.h
#	modified: include/linux/Kbuild
#	modified: include/linux/blkdev.h
#	modified: include/linux/device.h
#	modified: include/linux/elevator.h
#	modified: include/linux/ioport.h
#	modified: include/linux/kobject.h
#	modified: include/linux/pci.h
#	modified: include/linux/pci_ids.h
#	modified: include/linux/pci_regs.h
#	modified: include/sound/pcm_oss.h
#	modified: include/sound/version.h
#	modified: include/sound/ymfpci.h
#	modified: init/main.c
#	modified: kernel/irq/chip.c
#	modified: kernel/sched.c
#	modified: kernel/workqueue.c
#	modified: lib/kobject_uevent.c
#	modified: lib/kref.c
#	modified: sound/aoa/codecs/snd-aoa-codec-onyx.h
#	modified: sound/aoa/codecs/snd-aoa-codec-tas.c
#	modified: sound/core/control.c
#	modified: sound/core/oss/pcm_oss.c
#	modified: sound/core/pcm.c
#	modified: sound/core/pcm_lib.c
#	modified: sound/core/rawmidi.c
#	modified: sound/core/seq/seq_memory.c
#	modified: sound/core/sgbuf.c
#	modified: sound/isa/gus/gus_mem.c
#	modified: sound/isa/sb/sb_common.c
#	modified: sound/isa/wavefront/wavefront_synth.c
#	modified: sound/pci/ac97/ac97_codec.c
#	modified: sound/pci/ac97/ac97_patch.c
#	modified: sound/pci/ad1889.c
#	modified: sound/pci/ali5451/ali5451.c
#	modified: sound/pci/als300.c
#	modified: sound/pci/atiixp.c
#	modified: sound/pci/atiixp_modem.c
#	modified: sound/pci/au88x0/au88x0.c
#	modified: sound/pci/azt3328.c
#	modified: sound/pci/bt87x.c
#	modified: sound/pci/ca0106/ca0106.h
#	modified: sound/pci/ca0106/ca0106_main.c
#	modified: sound/pci/cmipci.c
#	modified: sound/pci/cs4281.c
#	modified: sound/pci/cs46xx/cs46xx_lib.c
#	modified: sound/pci/cs5535audio/cs5535audio.c
#	modified: sound/pci/echoaudio/echoaudio.c
#	modified: sound/pci/emu10k1/emu10k1_main.c
#	modified: sound/pci/emu10k1/emu10k1x.c
#	modified: sound/pci/ens1370.c
#	modified: sound/pci/es1938.c
#	modified: sound/pci/es1968.c
#	modified: sound/pci/fm801.c
#	modified: sound/pci/hda/hda_codec.c
#	modified: sound/pci/hda/hda_intel.c
#	modified: sound/pci/hda/hda_proc.c
#	modified: sound/pci/hda/patch_analog.c
#	modified: sound/pci/hda/patch_realtek.c
#	modified: sound/pci/hda/patch_si3054.c
#	modified: sound/pci/ice1712/ice1712.c
#	modified: sound/pci/ice1712/ice1724.c
#	modified: sound/pci/intel8x0.c
#	modified: sound/pci/intel8x0m.c
#	modified: sound/pci/korg1212/korg1212.c
#	modified: sound/pci/maestro3.c
#	modified: sound/pci/mixart/mixart.c
#	modified: sound/pci/nm256/nm256.c
#	modified: sound/pci/pcxhr/pcxhr.c
#	modified: sound/pci/riptide/riptide.c
#	modified: sound/pci/rme32.c
#	modified: sound/pci/rme96.c
#	modified: sound/pci/rme9652/hdsp.c
#	modified: sound/pci/rme9652/hdspm.c
#	modified: sound/pci/rme9652/rme9652.c
#	modified: sound/pci/sonicvibes.c
#	modified: sound/pci/trident/trident_main.c
#	modified: sound/pci/via82xx.c
#	modified: sound/pci/via82xx_modem.c
#	modified: sound/pci/vx222/vx222.c
#	modified: sound/pci/ymfpci/ymfpci.c
#	modified: sound/pci/ymfpci/ymfpci_main.c
#	modified: sound/usb/usbaudio.c
#
#
# Changed but not updated:
#   (use git-update-index to mark for commit)
#
#	unmerged: arch/arm/mach-ep93xx/core.c
#	modified: arch/arm/mach-ep93xx/ep93xx_devices.c
#	modified: drivers/net/arm/ep93xx_eth.c
#	modified: drivers/video/ep93xxfb.c
#	unmerged: include/asm-arm/system.h
#	modified: include/asm-arm/system.h
#
#
# Untracked files:
#   (use "git add" to add to commit)
#
#	build.sh
#	dogit.sh
#	include/asm-arm/arch-ep93xx/not-in-used/
#	log-status


B. git-diff output
==========

diff --cc include/asm-arm/system.h
index 04d6d2c,aa223fc..0000000
--- a/include/asm-arm/system.h
+++ b/include/asm-arm/system.h
@@@ -170,31 -178,6 +178,34 @@@
  	  : : "r" (val) : "cc");
  }

++<<<<<<< HEAD/include/asm-arm/system.h
 +extern unsigned long cr_no_alignment;	/* defined in entry-armv.S */
 +extern unsigned long cr_alignment;	/* defined in entry-armv.S */
 +
 +#include <linux/irqflags.h>
 +
 +#ifndef CONFIG_SMP
 +static inline void adjust_cr(unsigned long mask, unsigned long set)
 +{
 +	unsigned long flags;
 +
 +	mask &= ~CR_A;
 +
 +	set &= mask;
 +
 +	raw_local_irq_save(flags);
 +
 +	cr_no_alignment = (cr_no_alignment & ~mask) | set;
 +	cr_alignment = (cr_alignment & ~mask) | set;
 +
 +	set_cr((get_cr() & ~mask) | set);
 +
 +	raw_local_irq_restore(flags);
 +}
 +#endif
 +
++=======
++>>>>>>> 9bfb18392ef586467277fa25d8f3a7a93611f6df/include/asm-arm/system.h
  #define UDBG_UNDEFINED	(1 << 0)
  #define UDBG_SYSCALL	(1 << 1)
  #define UDBG_BADABORT	(1 << 2)

C. And if I do git-pull again
=================

Trying really trivial in-index merge...
arch/arm/mach-ep93xx/core.c: needs merge
arch/arm/mach-ep93xx/ep93xx_devices.c: needs update
drivers/net/arm/ep93xx_eth.c: needs update
drivers/video/ep93xxfb.c: needs update
include/asm-arm/system.h: needs merge
Nope.
Merging HEAD with 3e67c0987d7567ad666641164a153dca9a43b11d
Merging:
87d627b097b52c47610037bfb890940752fbf4c8 added .orig to gitignore
3e67c0987d7567ad666641164a153dca9a43b11d [PATCH] truncate: clear page
dirtiness before running try_to_free_buffers()
found 1 common ancestor(s):
f238085415c56618e042252894f2fcc971add645 Merge branch 'for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid


D. diff output between file stamp 12-dec and 21-dec
=====================================

--- linux-2.6/include/asm-arm/system.h	2006-12-19 11:31:18.000000000 +0100
+++ linux-2.6-ep93xx/include/asm-arm/system.h	2006-12-21
15:37:18.000000000 +0100
@@ -73,6 +73,7 @@
 #ifndef __ASSEMBLY__

 #include <linux/linkage.h>
+#include <linux/irqflags.h>

 struct thread_info;
 struct task_struct;
@@ -139,6 +140,9 @@
 #define	cpu_is_xscale()	1
 #endif

+extern unsigned long cr_no_alignment;	/* defined in entry-armv.S */
+extern unsigned long cr_alignment;	/* defined in entry-armv.S */
+
 static inline unsigned int get_cr(void)
 {
 	unsigned int val;
@@ -152,6 +156,10 @@
 	  : : "r" (val) : "cc");
 }

+#ifndef CONFIG_SMP
+extern void adjust_cr(unsigned long mask, unsigned long set);
+#endif
+
 #define CPACC_FULL(n)		(3 << (n * 2))
 #define CPACC_SVC(n)		(1 << (n * 2))
 #define CPACC_DISABLE(n)	(0 << (n * 2))
@@ -170,29 +178,34 @@
 	  : : "r" (val) : "cc");
 }

+<<<<<<< HEAD/include/asm-arm/system.h
 extern unsigned long cr_no_alignment;	/* defined in entry-armv.S */
 extern unsigned long cr_alignment;	/* defined in entry-armv.S */

+#include <linux/irqflags.h>
+
 #ifndef CONFIG_SMP
 static inline void adjust_cr(unsigned long mask, unsigned long set)
 {
-	unsigned long flags, cr;
+	unsigned long flags;

 	mask &= ~CR_A;

 	set &= mask;

-	local_irq_save(flags);
+	raw_local_irq_save(flags);

 	cr_no_alignment = (cr_no_alignment & ~mask) | set;
 	cr_alignment = (cr_alignment & ~mask) | set;

 	set_cr((get_cr() & ~mask) | set);

-	local_irq_restore(flags);
+	raw_local_irq_restore(flags);
 }
 #endif

+=======
+>>>>>>> 9bfb18392ef586467277fa25d8f3a7a93611f6df/include/asm-arm/system.h
 #define UDBG_UNDEFINED	(1 << 0)
 #define UDBG_SYSCALL	(1 << 1)
 #define UDBG_BADABORT	(1 << 2)
@@ -248,8 +261,6 @@
 {
 }

-#include <linux/irqflags.h>
-
 #ifdef CONFIG_SMP

 #define smp_mb()		mb()
