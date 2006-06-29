From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/2] Rename man1 and man7 variables to man1dir and man7dir
Date: Thu, 29 Jun 2006 22:13:00 +0200
Message-ID: <200606292213.00726.jnareb@gmail.com>
References: <200606292211.28352.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jun 29 22:13:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw2sm-0001Tn-Jd
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 22:13:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbWF2UM5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 16:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbWF2UM5
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 16:12:57 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:21459 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932403AbWF2UM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 16:12:56 -0400
Received: by ug-out-1314.google.com with SMTP id a2so549202ugf
        for <git@vger.kernel.org>; Thu, 29 Jun 2006 13:12:55 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=JwQn06gAJo/4y4HM62JfQcPw48BMtEadb6uZZr2Cg3EUFUOxQu//R2d3NeeL/1l1smJUYzX9poBNEHuMFc9tCobSrINFcrIgBVmsVEZwfk/oPpsFTEoww0dKPTlG073A2xzo2raYtSjX5zvuy21xWjtCzyrrfESf8/UTrQ++V+k=
Received: by 10.66.219.11 with SMTP id r11mr2311421ugg;
        Thu, 29 Jun 2006 13:12:55 -0700 (PDT)
Received: from host-81-190-27-124.torun.mm.pl ( [81.190.27.124])
        by mx.gmail.com with ESMTP id c1sm823903ugf.2006.06.29.13.12.54;
        Thu, 29 Jun 2006 13:12:55 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200606292211.28352.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22898>

This patch renames man1 and man7 variables to man1dir and man7dir,
according to "Makefile Conventions: Variables for Installation
Directories" in make.info of GNU Make.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---

Depends on the earlier patch in "series" only via context

 Documentation/Makefile   |   10 +++++-----
 contrib/git-svn/Makefile |    4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index ca6b77d..cc83610 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -27,8 +27,8 @@ DOC_MAN7=$(patsubst %.txt,%.7,$(MAN7_TXT
 prefix?=$(HOME)
 bindir?=$(prefix)/bin
 mandir?=$(prefix)/man
-man1=$(mandir)/man1
-man7=$(mandir)/man7
+man1dir=$(mandir)/man1
+man7dir=$(mandir)/man7
 # DESTDIR=
 
 INSTALL?=install
@@ -52,9 +52,9 @@ man1: $(DOC_MAN1)
 man7: $(DOC_MAN7)
 
 install: man
-	$(INSTALL) -d -m755 $(DESTDIR)$(man1) $(DESTDIR)$(man7)
-	$(INSTALL) $(DOC_MAN1) $(DESTDIR)$(man1)
-	$(INSTALL) $(DOC_MAN7) $(DESTDIR)$(man7)
+	$(INSTALL) -d -m755 $(DESTDIR)$(man1dir) $(DESTDIR)$(man7dir)
+	$(INSTALL) $(DOC_MAN1) $(DESTDIR)$(man1dir)
+	$(INSTALL) $(DOC_MAN7) $(DESTDIR)$(man7dir)
 
 
 #
diff --git a/contrib/git-svn/Makefile b/contrib/git-svn/Makefile
index 1a6585e..8cac688 100644
--- a/contrib/git-svn/Makefile
+++ b/contrib/git-svn/Makefile
@@ -3,7 +3,7 @@ all: git-svn
 prefix?=$(HOME)
 bindir?=$(prefix)/bin
 mandir?=$(prefix)/man
-man1=$(mandir)/man1
+man1dir=$(mandir)/man1
 INSTALL?=install
 doc_conf=../../Documentation/asciidoc.conf
 -include ../../config.mak
@@ -17,7 +17,7 @@ install: all
 	$(INSTALL) git-svn $(DESTDIR)$(bindir)
 
 install-doc: doc
-	$(INSTALL) git-svn.1 $(DESTDIR)$(man1)
+	$(INSTALL) git-svn.1 $(DESTDIR)$(man1dir)
 
 doc: git-svn.1
 git-svn.1 : git-svn.xml
-- 
1.4.0
