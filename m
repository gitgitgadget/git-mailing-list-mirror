From: Mark Allen <mrallen1@yahoo.com>
Subject: [PATCH] release tarball make targets
Date: Tue, 3 May 2005 14:15:27 -0700 (PDT)
Message-ID: <20050503211527.42339.qmail@web41208.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 23:10:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT4e1-0007CD-M5
	for gcvg-git@gmane.org; Tue, 03 May 2005 23:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbVECVPo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 17:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbVECVPo
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 17:15:44 -0400
Received: from web41208.mail.yahoo.com ([66.218.93.41]:17811 "HELO
	web41208.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261712AbVECVPh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2005 17:15:37 -0400
Received: (qmail 42341 invoked by uid 60001); 3 May 2005 21:15:27 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=M0kihaQ/0jXmG5rytDi0q7q3Qqz+9pOUjT9KY4eNrPFRcfjnT1p5SuJhQNWMyoH6MpdSlGuDizHRTYAgLgKvSRYoqC684XW/IqNTBypAg+xDQMGY1zTgNDxeMlyqJi2zTS8nE1nFQwEFYEc+L2CgBStetnPjpGy6B+IqjIeD7Kg=  ;
Received: from [65.173.207.2] by web41208.mail.yahoo.com via HTTP; Tue, 03 May 2005 14:15:27 PDT
To: chrisw@osdl.org, pasky@ucw.cz
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch is to support automating RPM and spec file generation.

Cheers,

--Mark

Signed-off-by: Mark Allen <mrallen1@yahoo.com>

Index: Makefile
===================================================================
--- aa6233be6d1b8bf42797c409a7c23b50593afc99/Makefile  (mode:100644
sha1:6ae0afa0208a8f755d383281a6d049a4ef90fe63)
+++ uncommitted/Makefile  (mode:100644 sha1:181aa6d6c34fb771671a7ee8038f9cf18972713a)
@@ -55,6 +55,10 @@
 
 VERSION= VERSION
 
+DIRS=mozilla-sha1 contrib ppc
+
+DOCS=README README.reference
+
 LIB_OBJS=read-cache.o sha1_file.o usage.o object.o commit.o tree.o blob.o \
 	 tag.o date.o
 LIB_FILE=libgit.a
@@ -136,3 +140,11 @@
 
 backup: clean
 	cd .. ; tar czvf dircache.tar.gz dir-cache
+
+release-tar-gzip: clean
+	tar czf $(shell cat $(VERSION)).tar.gz *.c *.h git.spec Makefile $(DOCS) $(DIRS)
$(SCRIPTS) $(SCRIPT) 
+
+release-tar-bzip2: clean
+	tar cjf $(shell cat $(VERSION)).tar.bz2 *.c *.h git.spec Makefile $(DOCS) $(DIRS)
$(SCRIPTS) $(SCRIPT) 
+
+release-tarballs: release-tar-gzip release-tar-bzip2

