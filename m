From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH 1/3] git-diff: Usage string clean-up
Date: Thu, 15 Dec 2005 23:47:57 +0100
Message-ID: <20051215224757.GC14388@c165.ib.student.liu.se>
References: <20051215224350.GB14388@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Dec 15 23:48:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1En1tN-0006B9-8S
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 23:48:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbVLOWr7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Dec 2005 17:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbVLOWr7
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Dec 2005 17:47:59 -0500
Received: from [85.8.31.11] ([85.8.31.11]:62677 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1751174AbVLOWr6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Dec 2005 17:47:58 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 7A65F40FD; Thu, 15 Dec 2005 23:58:32 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1En1tF-00049l-00; Thu, 15 Dec 2005 23:47:57 +0100
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20051215224350.GB14388@c165.ib.student.liu.se>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13715>

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>


---

 git-diff.sh |   14 ++++++--------
 1 files changed, 6 insertions(+), 8 deletions(-)

ca73d87d08c8c3702495694cc1080112c4c34ba1
diff --git a/git-diff.sh b/git-diff.sh
index b62e583..4812ae4 100755
--- a/git-diff.sh
+++ b/git-diff.sh
@@ -3,15 +3,14 @@
 # Copyright (c) 2005 Linus Torvalds
 # Copyright (c) 2005 Junio C Hamano
 
+USAGE='[ --diff-options ] <ent>{0,2} [<path>...]'
+SUBDIRECTORY_OK='Yes'
+. git-sh-setup
+
 rev=$(git-rev-parse --revs-only --no-flags --sq "$@") || exit
 flags=$(git-rev-parse --no-revs --flags --sq "$@")
 files=$(git-rev-parse --no-revs --no-flags --sq "$@")
 
-die () {
-    echo >&2 "$*"
-    exit 1
-}
-
 # I often say 'git diff --cached -p' and get scolded by git-diff-files, but
 # obviously I mean 'git diff --cached -p HEAD' in that case.
 case "$rev" in
@@ -40,8 +39,7 @@ esac
 
 case "$rev" in
 ?*' '?*' '?*)
-	echo >&2 "I don't understand"
-	exit 1
+	usage
 	;;
 ?*' '^?*)
 	begin=$(expr "$rev" : '.*^.\([0-9a-f]*\).*') &&
@@ -58,7 +56,7 @@ case "$rev" in
 	cmd="git-diff-files $flags -- $files"
 	;;
 *)
-	die "I don't understand $*"
+	usage
 	;;
 esac
 
-- 
0.99.9.GIT
