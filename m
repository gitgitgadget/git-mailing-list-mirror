From: c.shoemaker@cox.net
Subject: [PATCH] Add usage statement for git-reset.sh
Date: Sat, 29 Oct 2005 00:16:20 -0400
Message-ID: <E1EVi8i-0002Tk-UF@localhost>
X-From: git-owner@vger.kernel.org Sat Oct 29 06:20:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVi9T-0003wp-JH
	for gcvg-git@gmane.org; Sat, 29 Oct 2005 06:17:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbVJ2EQW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Oct 2005 00:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbVJ2EQW
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Oct 2005 00:16:22 -0400
Received: from eastrmmtao05.cox.net ([68.230.240.34]:969 "EHLO
	eastrmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751042AbVJ2EQW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Oct 2005 00:16:22 -0400
Received: from localhost ([24.250.31.7]) by eastrmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051029041619.THPB28234.eastrmmtao05.cox.net@localhost>
          for <git@vger.kernel.org>; Sat, 29 Oct 2005 00:16:19 -0400
Received: from chris by localhost with local (Exim 4.43)
	id 1EVi8i-0002Tk-UF
	for git@vger.kernel.org; Sat, 29 Oct 2005 00:16:20 -0400
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10787>

Signed-off-by: Chris Shoemaker <c.shoemaker at cox.net>

---

 git-reset.sh |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

6bce396534f26c05d43bfb42d057465c4e564030
diff --git a/git-reset.sh b/git-reset.sh
--- a/git-reset.sh
+++ b/git-reset.sh
@@ -1,6 +1,10 @@
 #!/bin/sh
 . git-sh-setup || die "Not a git archive"
 
+usage () {
+	die 'Usage: git reset [--mixed] [--soft] [--hard]  [<commit-ish>]'
+}
+
 tmp=/var/tmp/reset.$$
 trap 'rm -f $tmp-*' 0 1 2 3 15
 
@@ -10,6 +14,8 @@ case "$1" in
 	reset_type="$1"
 	shift
 	;;
+-*)
+        usage ;;
 esac
 
 rev=$(git-rev-parse --verify --default HEAD "$@") || exit
