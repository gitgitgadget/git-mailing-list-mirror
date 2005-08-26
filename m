From: Tommi Virtanen <tv@debian.org>
Subject: [PATCH] cogito bugfixes and cleanups, mainly Debian things
Date: Fri, 26 Aug 2005 14:01:35 +0300
Message-ID: <1125054095206-git-send-email-tv@debian.org>
References: <11250540952491-git-send-email-tv@debian.org>
Reply-To: Tommi Virtanen <tv@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Tommi Virtanen <tv@debian.org>
X-From: git-owner@vger.kernel.org Fri Aug 26 13:06:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8by4-0006zI-OV
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 13:01:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932557AbVHZLBr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 07:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932554AbVHZLBq
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 07:01:46 -0400
Received: from i1.inoi.fi ([194.100.97.46]:58269 "EHLO mail.srv.inoi.fi")
	by vger.kernel.org with ESMTP id S932557AbVHZLBn (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Aug 2005 07:01:43 -0400
Received: from mail.srv.inoi.fi (localhost.localdomain [127.0.0.1])
	by mail.srv.inoi.fi (Postfix) with ESMTP id A2BB4FEDD2;
	Fri, 26 Aug 2005 14:01:49 +0300 (EEST)
Received: from pooch.inoi.fi (GMMCMXXXIV.dsl.saunalahti.fi [85.76.243.135])
	by mail.srv.inoi.fi (Postfix) with ESMTP id 65776FF9DD;
	Fri, 26 Aug 2005 14:01:49 +0300 (EEST)
Received: from pooch (pooch [127.0.0.1])
	by pooch.inoi.fi (Postfix) with SMTP id EBF24BA06C;
	Fri, 26 Aug 2005 14:01:35 +0300 (EEST)
In-Reply-To: <11250540952491-git-send-email-tv@debian.org>
X-Mailer: git-send-email-script
To: git@vger.kernel.org
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7807>

Make the text format docs too.

Signed-off-by: Tommi Virtanen <tv@debian.org>

---
commit 3a0094e4985bcb5970ecee2d59d0ba5f5a806d2d
tree b4d3b267a4b15d3068727fad080c12f6d10a6cd9
parent 91aeeed108292bb42f7b133da13ec6881cf84a9e
author Tommi Virtanen <tv@debian.org> Fri, 26 Aug 2005 13:34:09 +0300
committer Tommi Virtanen <tv@debian.org> Fri, 26 Aug 2005 13:34:09 +0300

 Documentation/Makefile |    4 +++-
 debian/rules           |    2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -29,7 +29,7 @@ INSTALL=install
 # yourself - yes, all 6 characters of it!
 #
 
-all: html man
+all: html man txt
 
 html: $(DOC_HTML)
 
@@ -38,6 +38,8 @@ man: man1 man7
 man1: $(DOC_MAN1)
 man7: $(DOC_MAN7)
 
+txt: $(MAN1_TXT) $(MAN7_TXT)
+
 install: man
 	$(INSTALL) -m755 -d $(DESTDIR)/$(txtdir)
 	$(INSTALL) $(MAN1_TXT) $(MAN7_TXT) $(DESTDIR)/$(txtdir)
diff --git a/debian/rules b/debian/rules
--- a/debian/rules
+++ b/debian/rules
@@ -48,7 +48,7 @@ build: build-stamp
 build-stamp: configure-stamp 
 	dh_testdir
 	$(MAKE)
-	$(MAKE) -C Documentation html man
+	$(MAKE) -C Documentation all
 	touch build-stamp
 
 clean:
