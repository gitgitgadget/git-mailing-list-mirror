From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH] Fix t4017-diff-retval for white-space from wc
Date: Sun, 29 Jun 2008 21:26:45 -0400
Message-ID: <1214789205-43490-1-git-send-email-benji@silverinsanity.com>
Cc: Brian Gernhardt <benji@silverinsanity.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 30 03:27:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KD8BF-0001nx-Qq
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 03:27:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753585AbYF3B0s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 21:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753740AbYF3B0s
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 21:26:48 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:44801 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753726AbYF3B0r (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 21:26:47 -0400
Received: from localhost.localdomain (c-75-75-94-94.hsd1.va.comcast.net [75.75.94.94])
	by silverinsanity.com (Postfix) with ESMTP id 3BA8B1FFC023;
	Mon, 30 Jun 2008 01:26:37 +0000 (UTC)
X-Mailer: git-send-email 1.5.6.1.227.gc1de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86857>

Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
---
 t/t4017-diff-retval.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t4017-diff-retval.sh b/t/t4017-diff-retval.sh
index d748d45..60dd201 100755
--- a/t/t4017-diff-retval.sh
+++ b/t/t4017-diff-retval.sh
@@ -123,7 +123,7 @@ test_expect_success 'check detects leftover conflict markers' '
 		git --no-pager diff --cached --check >test.out
 		test $? = 2
 	) &&
-	test "$(grep "conflict marker" test.out | wc -l)" = 3 &&
+	test 3 = $(grep "conflict marker" test.out | wc -l) &&
 	git reset --hard
 '
 
-- 
1.5.6.105.g6f4b
