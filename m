From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] t/t7003: replace \t with literal tab in sed expression
Date: Thu, 12 Aug 2010 15:55:54 -0500
Message-ID: <vyRoPz25kSrQp37AweDD-cKcfXzNba2fTsjI2-L88U0Eop2pk838tUNy-_QDHaP7IDSTIQsoox8@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 12 22:56:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ojep0-0000M7-4l
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 22:56:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754883Ab0HLU4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 16:56:13 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:37503 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753443Ab0HLU4M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 16:56:12 -0400
Received: by mail.nrlssc.navy.mil id o7CKu7CG010469; Thu, 12 Aug 2010 15:56:08 -0500
X-OriginalArrivalTime: 12 Aug 2010 20:56:07.0752 (UTC) FILETIME=[C93A8C80:01CB3A60]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153416>

From: Brandon Casey <drafnel@gmail.com>

The sed utilities on IRIX and Solaris do not interpret the sequence '\t'
to mean a tab character;  they read a literal character 't'.  So, use a
literal tab instead.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t7003-filter-branch.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index fd7e3a1..2c55801 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -143,7 +143,7 @@ test_expect_success 'more setup' '
 test_expect_success 'use index-filter to move into a subdirectory' '
 	git branch directorymoved &&
 	git filter-branch -f --index-filter \
-		 "git ls-files -s | sed \"s-\\t-&newsubdir/-\" |
+		 "git ls-files -s | sed \"s-	-&newsubdir/-\" |
 	          GIT_INDEX_FILE=\$GIT_INDEX_FILE.new \
 			git update-index --index-info &&
 		  mv \"\$GIT_INDEX_FILE.new\" \"\$GIT_INDEX_FILE\"" directorymoved &&
-- 
1.7.2.1
