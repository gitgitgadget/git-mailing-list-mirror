From: Brandon Casey <bcasey@nvidia.com>
Subject: [PATCH v2 05/16] contrib/git-credential-gnome-keyring.c: exit non-zero when called incorrectly
Date: Mon, 23 Sep 2013 11:49:06 -0700
Message-ID: <1379962157-1338-6-git-send-email-bcasey@nvidia.com>
References: <1379962157-1338-1-git-send-email-bcasey@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <john@szakmeister.net>, <pah@qo.cx>, <felipe.contreras@gmail.com>,
	Brandon Casey <drafnel@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 23 20:49:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOBCd-0007aR-F2
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 20:49:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753052Ab3IWSta (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 14:49:30 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:2457 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753012Ab3IWStZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 14:49:25 -0400
Received: from hqnvupgp08.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com
	id <B52408d180000>; Mon, 23 Sep 2013 11:48:56 -0700
Received: from hqemhub01.nvidia.com ([172.20.12.94])
  by hqnvupgp08.nvidia.com (PGP Universal service);
  Mon, 23 Sep 2013 11:45:52 -0700
X-PGP-Universal: processed;
	by hqnvupgp08.nvidia.com on Mon, 23 Sep 2013 11:45:52 -0700
Received: from sc-xterm-13.nvidia.com (172.20.144.16) by hqemhub01.nvidia.com
 (172.20.150.30) with Microsoft SMTP Server id 8.3.327.1; Mon, 23 Sep 2013
 11:49:24 -0700
X-Mailer: git-send-email 1.8.4.rc4.6.g5555d19
In-Reply-To: <1379962157-1338-1-git-send-email-bcasey@nvidia.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235220>

From: Brandon Casey <drafnel@gmail.com>

If the correct arguments were not specified, this program should exit
non-zero.  Let's do so.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 contrib/credential/gnome-keyring/git-credential-gnome-keyring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
index 3ff541c..04852d7 100644
--- a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
+++ b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
@@ -396,7 +396,7 @@ int main(int argc, char *argv[])
 
 	if (!argv[1]) {
 		usage(argv[0]);
-		goto out;
+		exit(EXIT_FAILURE);
 	}
 
 	/* lookup operation callback */
-- 
1.8.4.rc4.6.g5555d19


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
