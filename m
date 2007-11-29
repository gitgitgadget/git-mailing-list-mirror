From: Kumar Gala <galak@kernel.crashing.org>
Subject: problem with git detecting proper renames
Date: Thu, 29 Nov 2007 10:57:24 -0600 (CST)
Message-ID: <Pine.LNX.4.64.0711291050440.1711@blarg.am.freescale.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 29 17:59:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxmjJ-0005UI-9o
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 17:59:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758562AbXK2Q6w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 11:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757600AbXK2Q6v
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 11:58:51 -0500
Received: from gate.crashing.org ([63.228.1.57]:48416 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755992AbXK2Q6v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 11:58:51 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id lATGwnFO026217
	for <git@vger.kernel.org>; Thu, 29 Nov 2007 10:58:50 -0600
X-X-Sender: galak@blarg.am.freescale.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66546>

I was wondering if there was a way to ensure that git tracks renames
properly (or maybe its reporting them properly).

I did some git-mv and got the following:

the problem is git seems confused about what file was associated with its
source.

For example:
.../mpc8541cds => freescale/mpc8555cds}/init.S

thanks

- k

---

(the following is the results of a git-format-patch after the git-mv)

 Makefile                                           |    6 +-
 board/cds/mpc8548cds/Makefile                      |   60 -----
 board/cds/mpc8555cds/Makefile                      |   60 -----
 board/cds/mpc8555cds/init.S                        |  255 --------------------
 board/cds/mpc8555cds/u-boot.lds                    |  150 ------------
 board/{cds => freescale}/common/cadmus.c           |    0
 board/{cds => freescale}/common/cadmus.h           |    0
 board/{cds => freescale}/common/eeprom.c           |    0
 board/{cds => freescale}/common/eeprom.h           |    0
 board/{cds => freescale}/common/ft_board.c         |    0
 board/{cds => freescale}/common/via.c              |    0
 board/{cds => freescale}/common/via.h              |    0
 board/{cds => freescale}/mpc8541cds/Makefile       |    0
 board/{cds => freescale}/mpc8541cds/config.mk      |    0
 board/{cds => freescale}/mpc8541cds/init.S         |    0
 board/{cds => freescale}/mpc8541cds/mpc8541cds.c   |    0
 board/{cds => freescale}/mpc8541cds/u-boot.lds     |    4 +-
 .../mpc8541cds => freescale/mpc8548cds}/Makefile   |    0
 board/{cds => freescale}/mpc8548cds/config.mk      |    0
 board/{cds => freescale}/mpc8548cds/init.S         |    0
 board/{cds => freescale}/mpc8548cds/mpc8548cds.c   |    0
 board/{cds => freescale}/mpc8548cds/u-boot.lds     |    4 +-
 .../mpc8541cds => freescale/mpc8555cds}/Makefile   |    0
 board/{cds => freescale}/mpc8555cds/config.mk      |    0
 .../mpc8541cds => freescale/mpc8555cds}/init.S     |    0
 board/{cds => freescale}/mpc8555cds/mpc8555cds.c   |    0
 .../mpc8541cds => freescale/mpc8555cds}/u-boot.lds |    4 +-
 27 files changed, 9 insertions(+), 534 deletions(-)
 delete mode 100644 board/cds/mpc8548cds/Makefile
 delete mode 100644 board/cds/mpc8555cds/Makefile
 delete mode 100644 board/cds/mpc8555cds/init.S
 delete mode 100644 board/cds/mpc8555cds/u-boot.lds
 rename board/{cds => freescale}/common/cadmus.c (100%)
 rename board/{cds => freescale}/common/cadmus.h (100%)
 rename board/{cds => freescale}/common/eeprom.c (100%)
 rename board/{cds => freescale}/common/eeprom.h (100%)
 rename board/{cds => freescale}/common/ft_board.c (100%)
 rename board/{cds => freescale}/common/via.c (100%)
 rename board/{cds => freescale}/common/via.h (100%)
 copy board/{cds => freescale}/mpc8541cds/Makefile (100%)
 rename board/{cds => freescale}/mpc8541cds/config.mk (100%)
 copy board/{cds => freescale}/mpc8541cds/init.S (100%)
 rename board/{cds => freescale}/mpc8541cds/mpc8541cds.c (100%)
 copy board/{cds => freescale}/mpc8541cds/u-boot.lds (97%)
 copy board/{cds/mpc8541cds => freescale/mpc8548cds}/Makefile (100%)
 rename board/{cds => freescale}/mpc8548cds/config.mk (100%)
 rename board/{cds => freescale}/mpc8548cds/init.S (100%)
 rename board/{cds => freescale}/mpc8548cds/mpc8548cds.c (100%)
 rename board/{cds => freescale}/mpc8548cds/u-boot.lds (97%)
 rename board/{cds/mpc8541cds => freescale/mpc8555cds}/Makefile (100%)
 rename board/{cds => freescale}/mpc8555cds/config.mk (100%)
 rename board/{cds/mpc8541cds => freescale/mpc8555cds}/init.S (100%)
 rename board/{cds => freescale}/mpc8555cds/mpc8555cds.c (100%)
 rename board/{cds/mpc8541cds => freescale/mpc8555cds}/u-boot.lds (97%)

diff --git a/Makefile b/Makefile
index 92632b9..a0f35df 100644
--- a/Makefile
+++ b/Makefile
@@ -1945,7 +1945,7 @@ MPC8541CDS_config:	unconfig
 		echo "#define CONFIG_LEGACY" >>$(obj)include/config.h ; \
 		echo "... legacy" ; \
 	fi
-	@$(MKCONFIG) -a MPC8541CDS ppc mpc85xx mpc8541cds cds
+	@$(MKCONFIG) -a MPC8541CDS ppc mpc85xx mpc8541cds freescale

 MPC8544DS_config:	unconfig
 	@$(MKCONFIG) $(@:_config=) ppc mpc85xx mpc8544ds freescale
@@ -1958,7 +1958,7 @@ MPC8548CDS_config:	unconfig
 		echo "#define CONFIG_LEGACY" >>$(obj)include/config.h ; \
 		echo "... legacy" ; \
 	fi
-	@$(MKCONFIG) -a MPC8548CDS ppc mpc85xx mpc8548cds cds
+	@$(MKCONFIG) -a MPC8548CDS ppc mpc85xx mpc8548cds freescale

 MPC8555CDS_legacy_config \
 MPC8555CDS_config:	unconfig
@@ -1968,7 +1968,7 @@ MPC8555CDS_config:	unconfig
 		echo "#define CONFIG_LEGACY" >>$(obj)include/config.h ; \
 		echo "... legacy" ; \
 	fi
-	@$(MKCONFIG) -a MPC8555CDS ppc mpc85xx mpc8555cds cds
+	@$(MKCONFIG) -a MPC8555CDS ppc mpc85xx mpc8555cds freescale

 MPC8568MDS_config:	unconfig
 	@$(MKCONFIG) $(@:_config=) ppc mpc85xx mpc8568mds freescale

[snip]

diff --git a/board/cds/mpc8541cds/u-boot.lds b/board/freescale/mpc8555cds/u-boot.lds
similarity index 97%
rename from board/cds/mpc8541cds/u-boot.lds
rename to board/freescale/mpc8555cds/u-boot.lds
index 7a5daef..df21ea8 100644
--- a/board/cds/mpc8541cds/u-boot.lds
+++ b/board/freescale/mpc8555cds/u-boot.lds
@@ -34,7 +34,7 @@ SECTIONS
   .bootpg 0xFFFFF000 :
   {
     cpu/mpc85xx/start.o	(.bootpg)
-    board/cds/mpc8541cds/init.o (.bootpg)
+    board/freescale/mpc8555cds/init.o (.bootpg)
   } = 0xffff

   /* Read-only sections, merged into text segment: */
@@ -64,7 +64,7 @@ SECTIONS
   .text      :
   {
     cpu/mpc85xx/start.o	(.text)
-    board/cds/mpc8541cds/init.o (.text)
+    board/freescale/mpc8555cds/init.o (.text)
     cpu/mpc85xx/traps.o (.text)
     cpu/mpc85xx/interrupts.o (.text)
     cpu/mpc85xx/cpu_init.o (.text)
-- 
1.5.3.4
