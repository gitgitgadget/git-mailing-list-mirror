From: Martin Waitz <tali@admingilde.org>
Subject: [PATCH] git-commit: cleanup unused function.
Date: Tue, 3 Oct 2006 18:38:25 +0200
Message-ID: <20061003163825.GM2871@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Oct 03 18:39:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUnHz-0004pn-Fh
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 18:38:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbWJCQi1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 12:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWJCQi1
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 12:38:27 -0400
Received: from agent.admingilde.org ([213.95.21.5]:15811 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP id S932262AbWJCQi0
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 3 Oct 2006 12:38:26 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GUnHl-0002j9-FJ
	for git@vger.kernel.org; Tue, 03 Oct 2006 18:38:25 +0200
To: git@vger.kernel.org
Content-Disposition: inline
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28277>

The report() function is not used anymore. Kill it.

Signed-off-by: Martin Waitz <tali@admingilde.org>
---
 git-commit.sh |   27 ---------------------------
 1 files changed, 0 insertions(+), 27 deletions(-)

diff --git a/git-commit.sh b/git-commit.sh
index 5a4c659..6f6cbda 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -32,33 +32,6 @@ save_index () {
 	cp -p "$THIS_INDEX" "$NEXT_INDEX"
 }
 
-report () {
-  header="#
-# $1:
-#   ($2)
-#
-"
-  trailer=""
-  while read status name newname
-  do
-    printf '%s' "$header"
-    header=""
-    trailer="#
-"
-    case "$status" in
-    M ) echo "#	modified: $name";;
-    D*) echo "#	deleted:  $name";;
-    T ) echo "#	typechange: $name";;
-    C*) echo "#	copied: $name -> $newname";;
-    R*) echo "#	renamed: $name -> $newname";;
-    A*) echo "#	new file: $name";;
-    U ) echo "#	unmerged: $name";;
-    esac
-  done
-  printf '%s' "$trailer"
-  [ "$header" ]
-}
-
 run_status () {
 	# If TMP_INDEX is defined, that means we are doing
 	# "--only" partial commit, and that index file is used
-- 
1.4.2.1.gbc1a5


-- 
Martin Waitz
