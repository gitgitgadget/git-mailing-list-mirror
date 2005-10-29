From: c.shoemaker@cox.net
Subject: [PATCH] Add usage statement to git-push.sh
Date: Sat, 29 Oct 2005 00:16:33 -0400
Message-ID: <E1EVi8v-0002To-Qx@localhost>
X-From: git-owner@vger.kernel.org Sat Oct 29 06:20:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVi9i-0003wp-0d
	for gcvg-git@gmane.org; Sat, 29 Oct 2005 06:17:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbVJ2EQf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Oct 2005 00:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbVJ2EQf
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Oct 2005 00:16:35 -0400
Received: from eastrmmtao01.cox.net ([68.230.240.38]:31881 "EHLO
	eastrmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751042AbVJ2EQe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Oct 2005 00:16:34 -0400
Received: from localhost ([24.250.31.7]) by eastrmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051029041603.RPXI13165.eastrmmtao01.cox.net@localhost>
          for <git@vger.kernel.org>; Sat, 29 Oct 2005 00:16:03 -0400
Received: from chris by localhost with local (Exim 4.43)
	id 1EVi8v-0002To-Qx
	for git@vger.kernel.org; Sat, 29 Oct 2005 00:16:33 -0400
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10789>

Also clarify failure to push to read-only remote.

Signed-off-by: Chris Shoemaker <c.shoemaker at cox.net>

---

 git-push.sh |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

c312de8ed8aad08a3cfa4b8edce025f30781a1c3
diff --git a/git-push.sh b/git-push.sh
--- a/git-push.sh
+++ b/git-push.sh
@@ -18,7 +18,8 @@ do
 	--exec=*)
 		has_exec="$1" ;;
 	-*)
-		die "Unknown parameter $1" ;;
+		die "Usage: git push [--all] [--force] <repository> <refspec>"
+                ;;
         *)
 		set x "$@"
 		shift
@@ -41,7 +42,7 @@ shift
 
 case "$remote" in
 http://* | https://* | git://* | rsync://* )
-	die "Cannot push to $remote" ;;
+	die "Cannot use READ-ONLY transport to push to $remote" ;;
 esac
 
 set x "$remote" "$@"; shift
