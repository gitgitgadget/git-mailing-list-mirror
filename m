From: Xavier Maillard <zedek@gnu.org>
Subject: [PATCH] Use non-interactive function to byte-compile files
Date: Mon, 5 Mar 2007 09:23:42 +0100
Organization: GNU's Not UNIX!
Message-ID: <200703050823.l258NgT9008266@localhost.localdomain>
Reply-To: Xavier Maillard <zedek@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 05 09:27:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HO8XE-0001ZJ-AM
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 09:27:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbXCEI1F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 03:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932359AbXCEI1E
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 03:27:04 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:57006 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932272AbXCEI1D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 03:27:03 -0500
Received: from localhost.localdomain (chn51-3-88-163-173-156.fbx.proxad.net [88.163.173.156])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 965017D32
	for <git@vger.kernel.org>; Mon,  5 Mar 2007 09:27:01 +0100 (CET)
Received: from localhost.localdomain (IDENT:1001@localhost [127.0.0.1])
	by localhost.localdomain (8.13.8/8.13.8) with ESMTP id l258Ngdl008269
	for <git@vger.kernel.org>; Mon, 5 Mar 2007 09:23:42 +0100
Received: (from zedek@localhost)
	by localhost.localdomain (8.13.8/8.13.8/Submit) id l258NgT9008266;
	Mon, 5 Mar 2007 09:23:42 +0100
X-Authentication-Warning: localhost.localdomain: zedek set sender to zedek@gnu.org using -f
Jabber-ID: zedek@im.lolica.org
User-Agent: Rmail in GNU Emacs 23.0.51.1 on GNU/Linux
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41417>

Hi,

Ihope this one is more closed to what you expect to see in a
commit log.

* contrib/emacs/Makefile: add git-blame as a candidate to the
   	    byte-compilation.  batch-byte-compile is the prefered way
   	    to byte-compile files in batch mode. Use it instead of the
   	    interactive function.

Signed-off-by: Xavier Maillard <zedek@gnu.org>
---
 contrib/emacs/Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/emacs/Makefile b/contrib/emacs/Makefile
index 350846d..8554e39 100644
--- a/contrib/emacs/Makefile
+++ b/contrib/emacs/Makefile
@@ -2,7 +2,7 @@
 
 EMACS = emacs
 
-ELC = git.elc vc-git.elc
+ELC = git.elc vc-git.elc git-blame.elc
 INSTALL ?= install
 INSTALL_ELC = $(INSTALL) -m 644
 prefix ?= $(HOME)
@@ -15,6 +15,6 @@ install: all
 	$(INSTALL_ELC) $(ELC) $(emacsdir)
 
 %.elc: %.el
-	$(EMACS) --batch --eval '(byte-compile-file "$<")'
+	$(EMACS) -batch -f batch-byte-compile $<
 
 clean:; rm -f $(ELC)
-- 
1.5.0
