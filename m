From: Brandon Casey <bcasey@nvidia.com>
Subject: [PATCH] Documentation/config.txt: denyDeleteCurrent applies to bare repos too
Date: Tue, 15 Oct 2013 18:26:58 -0700
Message-ID: <1381886818-14337-1-git-send-email-bcasey@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Brandon Casey <drafnel@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 16 03:27:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWFtD-0000jO-9z
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 03:27:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768Ab3JPB1C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Oct 2013 21:27:02 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:16214 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987Ab3JPB1A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Oct 2013 21:27:00 -0400
Received: from hqnvupgp08.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com
	id <B525deb670002>; Tue, 15 Oct 2013 18:27:03 -0700
Received: from hqemhub03.nvidia.com ([172.20.12.94])
  by hqnvupgp08.nvidia.com (PGP Universal service);
  Tue, 15 Oct 2013 18:22:35 -0700
X-PGP-Universal: processed;
	by hqnvupgp08.nvidia.com on Tue, 15 Oct 2013 18:22:35 -0700
Received: from sc-xterm-13.nvidia.com (172.20.144.16) by hqemhub03.nvidia.com
 (172.20.150.15) with Microsoft SMTP Server id 8.3.327.1; Tue, 15 Oct 2013
 18:27:00 -0700
X-Mailer: git-send-email 1.8.4.rc4.6.g5555d19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236228>

From: Brandon Casey <drafnel@gmail.com>

The setting of denyDeleteCurrent applies to both bare and non-bare
repositories.  Correct the description on this point, and expand it to
provide some background justification for the current behavior and
describe the full suite of settings.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 Documentation/config.txt | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c3f7002..3d416ec 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1993,8 +1993,15 @@ receive.denyDeletes::
 	the ref. Use this to prevent such a ref deletion via a push.
 
 receive.denyDeleteCurrent::
-	If set to true, git-receive-pack will deny a ref update that
-	deletes the currently checked out branch of a non-bare repository.
+	If set to true or "refuse", git-receive-pack will deny a ref update
+	that deletes the currently checked out branch of a non-bare repository,
+	or the "default" branch in a bare repository.  i.e. the branch
+	that HEAD refers to.  Deleting the current branch from a remote will
+	cause the HEAD symbolic ref to become dangling and will result in the
+	next clone from it to not check out anything.  If set to "warn",
+	then a warning will be printed to stderr and the deletion will be
+	performed.  If set to false or "ignore", then the deletion will be
+	performed with no warning message.  Defaults to "refuse".
 
 receive.denyCurrentBranch::
 	If set to true or "refuse", git-receive-pack will deny a ref update
-- 
1.8.4.rc4.6.g5555d19


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
