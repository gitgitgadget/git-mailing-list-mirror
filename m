From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH] Fix t4017-diff-retval for white-space from wc
Date: Sun, 29 Jun 2008 16:49:06 -0400
Message-ID: <20080629204906.GB40329@Hermes.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 29 23:06:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KD45e-0006SE-Bf
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 23:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbYF2VEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 17:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751583AbYF2VEI
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 17:04:08 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:58267 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbYF2VEH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 17:04:07 -0400
X-Greylist: delayed 966 seconds by postgrey-1.27 at vger.kernel.org; Sun, 29 Jun 2008 17:04:07 EDT
Received: from localhost.localdomain (c-75-75-94-94.hsd1.va.comcast.net [75.75.94.94])
	by silverinsanity.com (Postfix) with ESMTP id DDE871FFC02C
	for <git@vger.kernel.org>; Sun, 29 Jun 2008 20:49:00 +0000 (UTC)
Received: from Mutt by mutt-smtp-wrapper.pl 1.2  (www.zdo.com/articles/mutt-smtp-wrapper.shtml)
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86834>

Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
---
 t/t4017-diff-retval.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

 	Also: we have t4017-diff-retval and t4017-quiet.  Should one of
 	these be renamed?

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
