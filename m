From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH] t4030: Don't use echo -n
Date: Thu, 30 Oct 2008 18:12:56 -0400
Message-ID: <1225404776-51748-1-git-send-email-benji@silverinsanity.com>
Cc: Shawn O Pearce <spearce@spearce.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 30 23:14:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kvfmn-0001Au-Dn
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 23:14:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756383AbYJ3WNW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 18:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755697AbYJ3WNW
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 18:13:22 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:33302 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755409AbYJ3WNU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 18:13:20 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id ADE621FFC18A; Thu, 30 Oct 2008 22:13:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=5.0 tests=AWL,BAYES_00,
	FORGED_RCVD_HELO,RCVD_IN_PBL,RCVD_IN_SORBS_DUL autolearn=no 
	version=3.1.7-deb
Received: from localhost.localdomain (cpe-69-205-127-75.rochester.res.rr.com [69.205.127.75])
	by silverinsanity.com (Postfix) with ESMTP id 91E9D1FFC186;
	Thu, 30 Oct 2008 22:13:04 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.3.523.g304d0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99526>

Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
---
 t/t4030-diff-textconv.sh |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
index 3945731..7ec244f 100755
--- a/t/t4030-diff-textconv.sh
+++ b/t/t4030-diff-textconv.sh
@@ -96,16 +96,15 @@ cat >expect.typechange <<'EOF'
 -1
 diff --git a/file b/file
 new file mode 120000
-index ad8b3d2..67be421
+index ad8b3d2..8e4020b
 --- /dev/null
 +++ b/file
 @@ -0,0 +1 @@
 +frotz
-\ No newline at end of file
 EOF
 # make a symlink the hard way that works on symlink-challenged file systems
 test_expect_success 'textconv does not act on symlinks' '
-	echo -n frotz > file &&
+	echo frotz > file &&
 	git add file &&
 	git ls-files -s | sed -e s/100644/120000/ |
 		git update-index --index-info &&
-- 
1.6.0.3.523.g304d0
