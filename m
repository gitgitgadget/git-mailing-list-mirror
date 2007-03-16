From: Ed Swarthout <Ed.Swarthout@freescale.com>
Subject: [PATCH] gitweb: Fix uninitialized value when commit message is missing.
Date: Thu, 15 Mar 2007 23:55:09 -0500
Message-ID: <11740209091385-git-send-email-Ed.Swarthout@freescale.com>
Cc: Ed Swarthout <Ed.Swarthout@freescale.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 16 05:56:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HS4U7-0006p3-M7
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 05:56:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751861AbXCPE4I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 00:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751850AbXCPE4I
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 00:56:08 -0400
Received: from de01egw01.freescale.net ([192.88.165.102]:38956 "EHLO
	de01egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861AbXCPE4H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 00:56:07 -0400
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id l2G4u4XF011300
	for <git@vger.kernel.org>; Thu, 15 Mar 2007 21:56:04 -0700 (MST)
Received: from petra11.am.freescale.net (petra11.am.freescale.net [10.82.2.111])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l2G4u2TZ020460;
	Thu, 15 Mar 2007 23:56:02 -0500 (CDT)
Received: from swarthou by petra11.am.freescale.net with local (Exim 4.50)
	id 1HS4T7-0006JA-WC; Thu, 15 Mar 2007 23:55:10 -0500
X-Mailer: git-send-email 1.5.0.4.403.g4ee1
X-Brightmail-Tracker: AAAAAQAAAAQ=
X-Whitelist: TRUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42323>


Signed-off-by: Ed Swarthout <Ed.Swarthout@freescale.com>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 27b5970..4771689 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1346,7 +1346,7 @@ sub parse_commit_text {
 			last;
 		}
 	}
-	if ($co{'title'} eq "") {
+	if (!defined($co{'title'}) || $co{'title'} eq "") {
 		$co{'title'} = $co{'title_short'} = '(no commit message)';
 	}
 	# remove added spaces
-- 
1.5.0.4.403.g4ee1
