From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 06/14] t9501-*.sh: Fix a test failure on Cygwin
Date: Tue, 14 Dec 2010 18:26:38 +0000
Message-ID: <4D07B6DE.8080400@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>, marada@uwaterloo.ca,
	jnareb@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 14 19:46:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSZst-0004t2-SM
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 19:46:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758133Ab0LNSpu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 13:45:50 -0500
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:52581 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756880Ab0LNSpt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Dec 2010 13:45:49 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1PSZsi-0006ro-Yp; Tue, 14 Dec 2010 18:45:49 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163668>


The first (setup) test attempts to create a file, using the
test_commit function, called 'i can has snapshot?'. On cygwin
(and MinGW) this fails with a "No such file or directory" error.
In order to fix the tests, we simply remove the '?' wildcard
from the name, since the purpose of these tests is not about
creating funny filenames.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 t/t9501-gitweb-standalone-http-status.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501-gitweb-standalone-http-status.sh
index 2487da1..18825af 100755
--- a/t/t9501-gitweb-standalone-http-status.sh
+++ b/t/t9501-gitweb-standalone-http-status.sh
@@ -16,7 +16,7 @@ code and message.'
 # snapshot settings
 
 test_expect_success 'setup' "
-	test_commit 'SnapshotTests' 'i can has snapshot?'
+	test_commit 'SnapshotTests' 'i can has snapshot'
 "
 
 
-- 
1.7.3
