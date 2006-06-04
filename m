From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Makefile: make customization of installation locations easier.
Date: Sun, 04 Jun 2006 13:38:58 -0700
Message-ID: <11494535382304-git-send-email-junkio@cox.net>
Reply-To: Junio C Hamano <junkio@cox.net>
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Jun 04 22:39:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmzNK-0006u0-FV
	for gcvg-git@gmane.org; Sun, 04 Jun 2006 22:39:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbWFDUi7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Jun 2006 16:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbWFDUi7
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 16:38:59 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:4552 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932121AbWFDUi7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jun 2006 16:38:59 -0400
Received: from localhost.localdomain ([68.4.9.127]) by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060604203858.GVU11027.fed1rmmtao07.cox.net@localhost.localdomain>;
          Sun, 4 Jun 2006 16:38:58 -0400
To: Jonas Fonseca <fonseca@diku.dk>
X-Mailer: git-send-email 1.3.3.gb266
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21282>

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 Makefile |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index a7ff69b..d20f823 100644
--- a/Makefile
+++ b/Makefile
@@ -1,4 +1,8 @@
-PREFIX	= $(HOME)
+prefix	= $(HOME)
+bindir= $(prefix)/bin
+mandir = $(prefix)/man
+# DESTDIR=
+
 LDLIBS  = -lcurses
 CFLAGS	= -Wall -O2
 DFLAGS	= -g -DDEBUG -Werror
@@ -19,14 +23,15 @@ doc: $(DOCS)
 
 install: all
 	for prog in $(PROGS); do \
-		install $$prog $(PREFIX)/bin; \
+		install $$prog $(DESTDIR)$(bindir); \
 	done
 
 install-doc: doc
+	mkdir -p $(DESTDIR)$(mandir)/man1 $(DESTDIR)$(mandir)/man5
 	for doc in $(DOCS); do \
 		case "$$doc" in \
-		*.1) install $$doc $(PREFIX)/man/man1 ;; \
-		*.5) install $$doc $(PREFIX)/man/man5 ;; \
+		*.1) install $$doc $(DESTDIR)$(mandir)/man1 ;; \
+		*.5) install $$doc $(DESTDIR)$(mandir)/man5 ;; \
 		esac \
 	done
 
-- 
1.3.3.gb266
