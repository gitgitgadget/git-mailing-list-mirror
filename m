From: Len Brown <lenb@kernel.org>
Subject: warning: no common commits - slow pull
Date: Sun, 10 Feb 2008 20:07:38 -0500
Organization: Intel Open Source Technology Center
Message-ID: <200802102007.38838.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 11 02:08:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JON9o-0005cQ-UW
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 02:08:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755941AbYBKBHx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 20:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755580AbYBKBHx
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 20:07:53 -0500
Received: from hera.kernel.org ([140.211.167.34]:45884 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755421AbYBKBHw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Feb 2008 20:07:52 -0500
Received: from d975xbx2 (c-65-96-213-102.hsd1.ma.comcast.net [65.96.213.102])
	(authenticated bits=0)
	by hera.kernel.org (8.13.8/8.13.8) with ESMTP id m1B17ijq019430
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 11 Feb 2008 01:07:46 GMT
User-Agent: KMail/1.9.5
Content-Disposition: inline
X-Virus-Scanned: ClamAV version 0.88.7, clamav-milter version 0.88.7 on hera.kernel.org
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.0 required=5.0 tests=AWL,BAYES_00,RCVD_IN_PBL,
	RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=no version=3.2.3
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on hera.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73445>

A couple of hours ago I pulled my reference copy of Linux tree,
which brought the tip here:

commit 7cf712db6087342e5e7e259d3883a7b5ac3212d1
Merge: 58a14ee... 30ddb15...
Author: Linus Torvalds <torvalds@woody.linux-foundation.org>
Date:   Sun Feb 10 12:03:57 2008 -0800

    Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-2.6

Then, 10 minutes ago I did a pull to bring the head here:

commit 19af35546de68c872dcb687613e0902a602cb20e
Author: Linus Torvalds <torvalds@woody.linux-foundation.org>
Date:   Sun Feb 10 14:18:14 2008 -0800

    Linux 2.6.25-rc1

But this second pull seems to have re-downloaded 172MB,
when it should have only needed the last few commits.

thanks,
-Len


[lenb@d975xbx2 linus (master)]$ git pull
remote: Counting objects: 447, done.
remote: Compressing objects: 100% (39/39), done.
remote: Total 328 (delta 291), reused 325 (delta 289)
Receiving objects: 100% (328/328), 60.81 KiB, done.
Resolving deltas: 100% (291/291), completed with 97 local objects.
warning: no common commits
remote: Counting objects: 708151, done.
remote: Compressing objects: 100% (124656/124656), done.
remote: Total 708151 (delta 587427), reused 702559 (delta 582537)
Receiving objects: 100% (708151/708151), 172.17 MiB | 1251 KiB/s, done.
Resolving deltas: 100% (587427/587427), done.
From git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
 * [new tag]         v2.6.25-rc1 -> v2.6.25-rc1
Updating 7cf712d..19af355
Fast forward
 Makefile                                  |    4 +-
 arch/arm/configs/omap_h2_1610_defconfig   |  201 +++++---
 arch/arm/configs/omap_osk_5912_defconfig  |  110 ++--
 arch/arm/configs/orion_defconfig          |   93 ++--
 arch/arm/kernel/setup.c                   |    2 +-
 arch/arm/mach-at91/clock.c                |    2 +-
 arch/arm/mach-davinci/clock.c             |    4 +-
 arch/arm/mach-omap1/Makefile              |    6 +-
 arch/arm/mach-omap1/board-ams-delta.c     |    7 +-
 arch/arm/mach-omap1/board-fsample.c       |    6 +-
 arch/arm/mach-omap1/board-generic.c       |   24 +-
 arch/arm/mach-omap1/board-h2-mmc.c        |  110 ++++
 arch/arm/mach-omap1/board-h2.c            |  103 ++---
 arch/arm/mach-omap1/board-h3-mmc.c        |  114 ++++
 arch/arm/mach-omap1/board-h3.c            |   75 +--
 arch/arm/mach-omap1/board-innovator.c     |   19 +-
 arch/arm/mach-omap1/board-nokia770.c      |    3 +-
 arch/arm/mach-omap1/board-osk.c           |   25 +-
 arch/arm/mach-omap1/board-palmte.c        |   84 +--
 arch/arm/mach-omap1/board-palmtt.c        |   15 +-
 arch/arm/mach-omap1/board-palmz71.c       |    3 +-
 arch/arm/mach-omap1/board-perseus2.c      |    8 +-
 arch/arm/mach-omap1/board-sx1-mmc.c       |  124 +++++
 arch/arm/mach-omap1/board-sx1.c           |   64 +--
 arch/arm/mach-omap1/board-voiceblue.c     |    4 +-
 arch/arm/mach-omap1/clock.c               |    7 +-
 arch/arm/mach-omap1/leds-osk.c            |    4 +-
 arch/arm/mach-omap1/mailbox.c             |   14 +-
 arch/arm/mach-omap1/pm.c                  |   27 +-
 arch/arm/mach-omap1/sleep.S               |  161 ------
 arch/arm/mach-orion/addr-map.c            |   14 +-
 arch/arm/mach-orion/common.c              |   84 ++-
 arch/arm/mach-orion/common.h              |    8 +
 arch/arm/mach-orion/db88f5281-setup.c     |    4 +-
 arch/arm/mach-orion/dns323-setup.c        |    8 +-
 arch/arm/mach-orion/kurobox_pro-setup.c   |   17 +-
 arch/arm/mach-orion/pci.c                 |   10 +-
 arch/arm/mach-orion/rd88f5182-setup.c     |   17 +-
 arch/arm/mach-orion/ts209-setup.c         |   20 +-
 arch/arm/mach-pxa/pxa3xx.c                |   10 +-
 arch/arm/plat-omap/Makefile               |    1 +
 arch/arm/plat-omap/dma.c                  |  844 +++++++++++++++++++++++++++--
 arch/arm/plat-omap/dmtimer.c              |  118 +++-
 arch/arm/plat-omap/gpio.c                 |  256 +++++++---
 arch/arm/plat-omap/i2c.c                  |  148 +++++
 arch/arm/plat-omap/mcbsp.c                |   11 +
 arch/ia64/pci/pci.c                       |   25 +-
 arch/ia64/sn/pci/tioce_provider.c         |   16 +-
 arch/x86/kernel/quirks.c                  |    2 +-
 arch/x86/pci/common.c                     |   25 +-
 arch/x86/pci/direct.c                     |    4 +-
 arch/x86/pci/fixup.c                      |    6 +-
 arch/x86/pci/legacy.c                     |    2 +-
 arch/x86/pci/mmconfig-shared.c            |   41 +--
 arch/x86/pci/mmconfig_32.c                |   20 +-
 arch/x86/pci/mmconfig_64.c                |   18 +-
 arch/x86/pci/pci.h                        |   22 +-
 arch/x86/pci/visws.c                      |    3 -
 drivers/acpi/osl.c                        |   25 +-
 include/asm-arm/arch-omap/board-apollon.h |    2 +
 include/asm-arm/arch-omap/board-h2.h      |    3 +
 include/asm-arm/arch-omap/board-h3.h      |    2 +
 include/asm-arm/arch-omap/board-sx1.h     |    8 +-
 include/asm-arm/arch-omap/common.h        |   11 +
 include/asm-arm/arch-omap/cpu.h           |  127 ++++-
 include/asm-arm/arch-omap/dma.h           |  135 ++++--
 include/asm-arm/arch-omap/gpio.h          |    4 +
 include/asm-arm/arch-omap/irqs.h          |    2 +
 include/asm-arm/arch-omap/nand.h          |   24 +
 include/asm-arm/arch-orion/debug-macro.S  |    9 +-
 include/asm-arm/arch-orion/entry-macro.S  |    4 +-
 include/asm-arm/arch-orion/hardware.h     |   13 +-
 include/asm-arm/arch-orion/orion.h        |  102 +++--
 include/asm-arm/arch-orion/uncompress.h   |   14 +-
 include/asm-arm/arch-orion/vmalloc.h      |    2 +-
 include/linux/pci.h                       |   16 +-
 76 files changed, 2581 insertions(+), 1099 deletions(-)
 create mode 100644 arch/arm/mach-omap1/board-h2-mmc.c
 create mode 100644 arch/arm/mach-omap1/board-h3-mmc.c
 create mode 100644 arch/arm/mach-omap1/board-sx1-mmc.c
 create mode 100644 arch/arm/plat-omap/i2c.c
 create mode 100644 include/asm-arm/arch-omap/nand.h
[lenb@d975xbx2 linus (master)]$   
[lenb@d975xbx2 acpi (release)]$ git --version
git version 1.5.4.1.34.g94bf

                                                        
