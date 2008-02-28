From: =?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
Subject: [PATCH] git add --interactive: Autoselect single patch file
Date: Thu, 28 Feb 2008 12:15:36 +0100
Message-ID: <1204197336-615-1-git-send-email-joerg@alea.gnuu.de>
Cc: =?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 28 12:18:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUgmc-00085J-Pb
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 12:18:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755143AbYB1LSB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 06:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755130AbYB1LSA
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 06:18:00 -0500
Received: from banki.eumelnet.de ([83.246.114.63]:4535 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755110AbYB1LSA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 06:18:00 -0500
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 428C548802D; Thu, 28 Feb 2008 12:17:57 +0100 (CET)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JUgjh-0000rF-FK
	for git@vger.kernel.org; Thu, 28 Feb 2008 12:15:37 +0100
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JUgjg-0000AF-VP; Thu, 28 Feb 2008 12:15:36 +0100
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <>
References: <>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75384>

If there's only one file to patch, select it automaticly and don't bother
the user. In the case he didn't want do patching, he can say 'd' at the
patch prompt.
---
 git-add--interactive.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index a0a81f1..77ad6fb 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -778,7 +778,7 @@ sub patch_update_cmd {
 		print STDERR "No changes.\n";
 		return 0;
 	}
-	if ($patch_mode) {
+	if ($patch_mode or @mods == 1) {
 		@them = @mods;
 	}
 	else {
-- 
1.5.4.3
