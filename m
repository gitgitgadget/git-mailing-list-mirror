From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/2] Use Linus' show ref in "git-branch.sh".
Date: Sun, 17 Sep 2006 06:32:24 +0200
Message-ID: <20060917063224.0dc298ae.chriscool@tuxfamily.org>
References: <20060917062024.c476e07d.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 17 06:26:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOoF6-0000xT-Aq
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 06:26:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWIQE0V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 00:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWIQE0V
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 00:26:21 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:39054 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750723AbWIQE0V (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Sep 2006 00:26:21 -0400
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g19.free.fr (Postfix) with SMTP id 0EB60481BC;
	Sun, 17 Sep 2006 06:26:20 +0200 (CEST)
To: Junio Hamano <junkio@cox.net>
In-Reply-To: <20060917062024.c476e07d.chriscool@tuxfamily.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.20; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27158>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-branch.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-branch.sh b/git-branch.sh
index e0501ec..2600e9c 100755
--- a/git-branch.sh
+++ b/git-branch.sh
@@ -21,7 +21,7 @@ delete_branch () {
 	,,)
 	    die "What branch are you on anyway?" ;;
 	esac
-	branch=$(cat "$GIT_DIR/refs/heads/$branch_name") &&
+	branch=$(git-show-ref --verify --hash -- "refs/heads/$branch_name") &&
 	    branch=$(git-rev-parse --verify "$branch^0") ||
 		die "Seriously, what branch are you talking about?"
 	case "$option" in
@@ -112,7 +112,7 @@ rev=$(git-rev-parse --verify "$head") ||
 git-check-ref-format "heads/$branchname" ||
 	die "we do not like '$branchname' as a branch name."
 
-if [ -e "$GIT_DIR/refs/heads/$branchname" ]
+if git-show-ref --verify --quiet -- "refs/heads/$branchname"
 then
 	if test '' = "$force"
 	then
-- 
1.4.2.1.gea00f-dirty
