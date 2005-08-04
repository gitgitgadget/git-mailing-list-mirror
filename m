From: Petr Baudis <pasky@ucw.cz>
Subject: [PATCH] Use $DESTDIR instead of $dest
Date: Fri, 5 Aug 2005 00:55:29 +0200
Message-ID: <20050804225529.GJ24479@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Aug 05 01:02:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0oic-0001OF-2y
	for gcvg-git@gmane.org; Fri, 05 Aug 2005 01:01:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262781AbVHDW4i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Aug 2005 18:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262717AbVHDW4W
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Aug 2005 18:56:22 -0400
Received: from w241.dkm.cz ([62.24.88.241]:52749 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262772AbVHDWz3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Aug 2005 18:55:29 -0400
Received: (qmail 7146 invoked by uid 2001); 4 Aug 2005 22:55:29 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

$DESTDIR is more usual during the build than $dest and is what is usually
used in the makefiles, so let's use it too.

Signed-off-by: Petr Baudis <pasky@ucw.cz>

---
commit ffc29a11e9be157e2349d431adadf1b6e91a2251
tree fbd1076ed78c609777f81094cb8989b5b32973da
parent aa6f095b0cd57ab424f02695ccfc8168f5c3b981
author Petr Baudis <pasky@suse.cz> Fri, 05 Aug 2005 00:54:52 +0200
committer Petr Baudis <xpasky@machine.sinus.cz> Fri, 05 Aug 2005 00:54:52 +0200

 Makefile |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -41,7 +41,7 @@ prefix=$(HOME)
 bindir=$(prefix)/bin
 etcdir=$(prefix)/etc
 etcgitdir=$(etcdir)/git-core
-# dest=
+# DESTDIR=
 
 CC?=gcc
 AR?=ar
@@ -197,8 +197,8 @@ check:
 ### Installation rules
 
 install: $(PROG) $(SCRIPTS)
-	$(INSTALL) -m755 -d $(dest)$(bindir)
-	$(INSTALL) $(PROG) $(SCRIPTS) $(dest)$(bindir)
+	$(INSTALL) -m755 -d $(DESTDIR)$(bindir)
+	$(INSTALL) $(PROG) $(SCRIPTS) $(DESTDIR)$(bindir)
 	$(MAKE) -C templates install
 
 install-tools:
