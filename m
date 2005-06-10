From: Sebastian Kuzminsky <seb@highlab.com>
Subject: do people use the 'git' command?
Date: Fri, 10 Jun 2005 12:53:32 -0600
Message-ID: <E1DgodI-0003ov-Fl@highlab.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 20:47:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgoXH-0002iW-Lf
	for gcvg-git@gmane.org; Fri, 10 Jun 2005 20:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbVFJSvi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Jun 2005 14:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbVFJSvi
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jun 2005 14:51:38 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:15268 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261171AbVFJSvg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2005 14:51:36 -0400
Received: from highlab.com ([24.8.179.27])
          by comcast.net (rwcrmhc12) with ESMTP
          id <2005061018513201400jgcane>; Fri, 10 Jun 2005 18:51:36 +0000
Received: from seb (helo=highlab.com)
	by highlab.com with local-esmtp (Exim 4.50)
	id 1DgodI-0003ov-Fl
	for git@vger.kernel.org; Fri, 10 Jun 2005 12:53:32 -0600
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

What good is the 'git' command?  It's a shortcut to run the
"git-$FUNCTION-script" programs, but it doesnt do the "git-$FUNCTION"
programs.  It just doesnt seem worth its inode, to me.  And it doesnt seem
worth the pain to distribution maintainers (like me) to avoid the naming
conflict with GNU Interactive Tools' /usr/bin/git.


Can we drop the "git" program?


diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -42,7 +42,7 @@ CC?=gcc
 AR?=ar
 INSTALL?=install
 
-SCRIPTS=git git-apply-patch-script git-merge-one-file-script git-prune-script \
+SCRIPTS=git-apply-patch-script git-merge-one-file-script git-prune-script \
 	git-pull-script git-tag-script git-resolve-script git-whatchanged \
 	git-deltafy-script git-fetch-script git-status-script git-commit-script \
 	git-log-script git-shortlog git-cvsimport-script
diff --git a/git b/git
deleted file mode 100755
--- a/git
+++ /dev/null
@@ -1,4 +0,0 @@
-#!/bin/sh
-cmd="git-$1-script"
-shift
-exec $cmd "$@"


-- 
Sebastian Kuzminsky
