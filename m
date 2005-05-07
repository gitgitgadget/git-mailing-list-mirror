From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: [PATCH] make INSTALL binary in Makefile configurable via make variable
Date: Sat, 7 May 2005 10:41:54 +0200
Message-ID: <20050507084154.GE23680@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat May 07 10:40:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUKrL-0000C1-Cb
	for gcvg-git@gmane.org; Sat, 07 May 2005 10:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262845AbVEGIqd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 May 2005 04:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262850AbVEGImv
	(ORCPT <rfc822;git-outgoing>); Sat, 7 May 2005 04:42:51 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:61628 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262845AbVEGIl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2005 04:41:59 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j478ftS8001771
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 7 May 2005 08:41:55 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j478fso9001770;
	Sat, 7 May 2005 10:41:54 +0200 (CEST)
To: GIT <git@vger.kernel.org>
Mail-Followup-To: GIT <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

[PATCH] make INSTALL binary in Makefile configurable via make variable

On Solaris machines gnu install called ginstall

Signed-Off-by: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>

--- a/Makefile
+++ b/Makefile
@@ -11,6 +11,7 @@
 
 CC=gcc
 AR=ar
+INSTALL=install
 
 SCRIPTS=git-apply-patch-script git-merge-one-file-script git-prune-script \
 	git-pull-script git-tag-script git-resolve-script
@@ -26,7 +27,7 @@
 all: $(PROG)
 
 install: $(PROG) $(SCRIPTS)
-	install $(PROG) $(SCRIPTS) $(HOME)/bin/
+	$(INSTALL) $(PROG) $(SCRIPTS) $(HOME)/bin/
 
 LIB_OBJS=read-cache.o sha1_file.o usage.o object.o commit.o tree.o blob.o \
 	 tag.o date.o
-
To unsubscribe from this list: send the line "unsubscribe git" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
