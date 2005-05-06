From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: [PATCH] make INSTALL binary in Makefile configurable via make variable
Date: Fri, 6 May 2005 15:46:54 +0200
Message-ID: <20050506134654.GI11506@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri May 06 15:43:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DU34o-0008JE-Fx
	for gcvg-git@gmane.org; Fri, 06 May 2005 15:41:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbVEFNrN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 09:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbVEFNrN
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 09:47:13 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:58866 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261187AbVEFNq7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2005 09:46:59 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j46DksS8010003
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 6 May 2005 13:46:54 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j46DksU9010002
	for git@vger.kernel.org; Fri, 6 May 2005 15:46:54 +0200 (CEST)
To: GIT <git@vger.kernel.org>
Mail-Followup-To: GIT <git@vger.kernel.org>
Content-Disposition: inline
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

[PATCH] make INSTALL binary in Makefile configurable via make variable

On Solaris machines gnu install called ginstall

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
