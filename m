From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 3/5] git-bisect: use dash-less form on git bisect log
Date: Fri, 11 Jul 2008 02:12:05 +0200
Message-ID: <eb505d0d8f7d2bf50073414baa799a80a9df7453.1215734605.git.vmiklos@frugalware.org>
References: <cover.1215734604.git.vmiklos@frugalware.org>
 <8275a6b4a676d33a1ae80f29f85c52b7bbda9a84.1215734605.git.vmiklos@frugalware.org>
 <9568dd5d03cd0f1da8872fd71f8bb253560e2352.1215734605.git.vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 02:12:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH6Fq-00088A-7S
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 02:12:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754168AbYGKAL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 20:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754074AbYGKAL4
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 20:11:56 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:35018 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754047AbYGKALz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 20:11:55 -0400
Received: from vmobile.example.net (catv-5062e651.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTP id BD7001DDC5D;
	Fri, 11 Jul 2008 02:11:53 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id C49DA1A990B; Fri, 11 Jul 2008 02:12:07 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2.450.g8d367.dirty
In-Reply-To: <9568dd5d03cd0f1da8872fd71f8bb253560e2352.1215734605.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1215734604.git.vmiklos@frugalware.org>
References: <cover.1215734604.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88064>

Given that users are supposed to type 'git bisect' now, make the output
of 'git bisect log' consistent with this.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 git-bisect.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 991b2ef..f4852a9 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -149,7 +149,7 @@ bisect_start() {
 	echo "$start_head" >"$GIT_DIR/BISECT_START" &&
 	sq "$@" >"$GIT_DIR/BISECT_NAMES" &&
 	eval "$eval" &&
-	echo "git-bisect start$orig_args" >>"$GIT_DIR/BISECT_LOG" || exit
+	echo "git bisect start$orig_args" >>"$GIT_DIR/BISECT_LOG" || exit
 	#
 	# Check if we can proceed to the next bisect state.
 	#
@@ -169,7 +169,7 @@ bisect_write() {
 	esac
 	git update-ref "refs/bisect/$tag" "$rev" || exit
 	echo "# $state: $(git show-branch $rev)" >>"$GIT_DIR/BISECT_LOG"
-	test -n "$nolog" || echo "git-bisect $state $rev" >>"$GIT_DIR/BISECT_LOG"
+	test -n "$nolog" || echo "git bisect $state $rev" >>"$GIT_DIR/BISECT_LOG"
 }
 
 bisect_state() {
@@ -426,9 +426,9 @@ bisect_clean_state() {
 bisect_replay () {
 	test -r "$1" || die "cannot read $1 for replaying"
 	bisect_reset
-	while read bisect command rev
+	while read git bisect command rev
 	do
-		test "$bisect" = "git-bisect" || continue
+		test "$git $bisect" = "git bisect" || continue
 		case "$command" in
 		start)
 			cmd="bisect_start $rev"
-- 
1.5.6.2.450.g8d367.dirty
