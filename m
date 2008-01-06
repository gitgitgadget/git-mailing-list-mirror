From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] rebase interactive: Add hint how to continue after 'Unknown command' error
Date: Sun,  6 Jan 2008 16:46:25 +0100
Message-ID: <1199634385511-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 06 16:50:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBXli-0001D1-H9
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 16:50:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758982AbYAFPtq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2008 10:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756262AbYAFPtq
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jan 2008 10:49:46 -0500
Received: from mailer.zib.de ([130.73.108.11]:62249 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757912AbYAFPtp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2008 10:49:45 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m06FkPVv015070
	for <git@vger.kernel.org>; Sun, 6 Jan 2008 16:49:43 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m06FkPTY028068;
	Sun, 6 Jan 2008 16:46:25 +0100 (MET)
X-Mailer: git-send-email 1.5.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69733>

rebase interactive asks the user to fix unknown commands but it did not
tell how to continue.

This commits adds a hint how to continue.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 git-rebase--interactive.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index acdcc54..d4bd811 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -310,7 +310,7 @@ do_next () {
 		;;
 	*)
 		warn "Unknown command: $command $sha1 $rest"
-		die_with_patch $sha1 "Please fix this in the file $TODO."
+		die_with_patch $sha1 "Please fix this in the file $TODO. And run 'git rebase --continue'."
 		;;
 	esac
 	test -s "$TODO" && return
-- 
1.5.4.rc2.26.g1deb
