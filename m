From: =?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
Subject: [PATCH] git add --interactive: Autoselect single patch file
Date: Sat, 22 Mar 2008 02:22:40 +0100
Message-ID: <1206148960-29563-1-git-send-email-joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: normalperson@yhbt.net,
	=?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 22 10:31:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jd04p-0005dL-US
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 10:31:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753222AbYCVJbH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Mar 2008 05:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752565AbYCVJbG
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 05:31:06 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:3375 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753042AbYCVJbF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2008 05:31:05 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 63486488030; Sat, 22 Mar 2008 10:31:03 +0100 (CET)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JcsRK-0007Z8-IG; Sat, 22 Mar 2008 02:22:30 +0100
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JcsRU-0007hA-2x; Sat, 22 Mar 2008 02:22:40 +0100
X-Mailer: git-send-email 1.5.4.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77794>

If there's only one file to patch, select it automaticly and don't both=
er
the user. In the case he didn't want do patching, he can say 'd' at the
patch prompt.

Signed-off-by: J=C3=B6rg Sommer <joerg@alea.gnuu.de>
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
+	if ($patch_mode or @mods =3D=3D 1) {
 		@them =3D @mods;
 	}
 	else {
--=20
1.5.4.4
