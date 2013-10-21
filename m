From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH 1/2] t5570: Update for symref capability
Date: Mon, 21 Oct 2013 13:54:11 -0400
Message-ID: <1382378052-89929-1-git-send-email-brian@gernhardtsoftware.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 21 20:04:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYJpm-0003PK-1D
	for gcvg-git-2@plane.gmane.org; Mon, 21 Oct 2013 20:04:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754Ab3JUSEB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Oct 2013 14:04:01 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:35812 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501Ab3JUSD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Oct 2013 14:03:59 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id EB7E027361E4; Mon, 21 Oct 2013 17:54:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.5 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.5
Received: from localhost.localdomain (u-of-rochester-128-151-150-17.wireless.rochester.edu [128.151.150.17])
	by silverinsanity.com (Postfix) with ESMTPA id 97B5C273616A;
	Mon, 21 Oct 2013 17:54:18 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.4 (Apple Git-47)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236436>

git-daemon now uses the symref capability to send the correct HEAD
reference, so the test for that in t5570 now passes.

Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
---
 t/t5570-git-daemon.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
index f01edff..dc55e51 100755
--- a/t/t5570-git-daemon.sh
+++ b/t/t5570-git-daemon.sh
@@ -37,7 +37,7 @@ test_expect_success 'fetch changes via git protocol' '
 	test_cmp file clone/file
 '
 
-test_expect_failure 'remote detects correct HEAD' '
+test_expect_success 'remote detects correct HEAD' '
 	git push public master:other &&
 	(cd clone &&
 	 git remote set-head -d origin &&
-- 
1.8.3.4 (Apple Git-47)
