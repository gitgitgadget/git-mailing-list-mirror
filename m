From: Matt Kraai <kraai@ftbfs.org>
Subject: [PATCH] gitweb: make feature_blame return a list
Date: Mon, 15 Dec 2008 06:51:48 -0800
Message-ID: <1229352709-4663-1-git-send-email-kraai@ftbfs.org>
Cc: Matt Kraai <kraai@ftbfs.org>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 15 15:53:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCEpB-0004Vz-M8
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 15:53:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753316AbYLOOwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 09:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753273AbYLOOwO
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 09:52:14 -0500
Received: from neon.ftbfs.org ([83.168.236.214]:52320 "EHLO neon.ftbfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753223AbYLOOwN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 09:52:13 -0500
Received: from pool-71-119-193-199.lsanca.dsl-w.verizon.net ([71.119.193.199] helo=macbookpro.ftbfs.org)
	by neon.ftbfs.org with esmtpa (Exim 4.63)
	(envelope-from <kraai@ftbfs.org>)
	id 1LCEne-0000jd-9x; Mon, 15 Dec 2008 06:52:03 -0800
Received: from kraai by macbookpro.ftbfs.org with local (Exim 4.69)
	(envelope-from <kraai@ftbfs.org>)
	id 1LCEnV-0001EV-ON; Mon, 15 Dec 2008 06:51:49 -0800
X-Mailer: git-send-email 1.5.6.5
X-Spam-Score-Int: -41
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103170>

The feature defaults are expected to be a list, but feature_blame was
returning a scalar.  This change makes it consistent with the other
boolean feature subroutines.

Signed-off-by: Matt Kraai <kraai@ftbfs.org>
---
 gitweb/gitweb.perl |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 6eb370d..145e712 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -367,12 +367,12 @@ sub feature_blame {
 	my ($val) = git_get_project_config('blame', '--bool');
 
 	if ($val eq 'true') {
-		return 1;
+		return (1);
 	} elsif ($val eq 'false') {
-		return 0;
+		return (0);
 	}
 
-	return $_[0];
+	return ($_[0]);
 }
 
 sub feature_snapshot {
-- 
1.5.6.5
