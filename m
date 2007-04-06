From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH] Distinguish branches by more than case in tests.
Date: Fri, 6 Apr 2007 01:42:04 -0400
Message-ID: <20070406054204.GA13108@Hermes.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 06 07:42:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZhDB-00056j-PO
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 07:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592AbXDFFmK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Apr 2007 01:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751635AbXDFFmK
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 01:42:10 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:34973 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592AbXDFFmI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 01:42:08 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by silverinsanity.com (Postfix) with ESMTP id 2FD061FFC143
	for <git@vger.kernel.org>; Fri,  6 Apr 2007 05:42:08 +0000 (UTC)
Received: from Mutt by mutt-smtp-wrapper.pl 1.2  (www.zdo.com/articles/mutt-smtp-wrapper.shtml)
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43901>

The renaming without config test changed a branch from q to Q, which
fails on non-case sensitive file systems.  Change the test to use q
and q2.
---

Notably, HFS+ is not case sensitive.  IIRC there are others.  This isn't
a flaw of git, just a bad choice of branch names for certain systems.

 t/t3200-branch.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index ce2c5f4..3ca1a32 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -85,9 +85,9 @@ test_expect_failure \
 
 mv .git/config .git/config-saved
 
-test_expect_success 'git branch -m q Q without config should succeed' '
-	git-branch -m q Q &&
-	git-branch -m Q q
+test_expect_success 'git branch -m q q2 without config should succeed' '
+	git-branch -m q q2 &&
+	git-branch -m q2 q
 '
 
 mv .git/config-saved .git/config
-- 
1.5.1.32.gdd6cd
