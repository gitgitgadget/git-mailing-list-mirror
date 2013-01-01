From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH 3/4] t4014: do not uese echo -n
Date: Tue, 1 Jan 2013 22:41:15 +0100
Message-ID: <201301012241.17050.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 01 22:41:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tq9ao-0000ZO-Ug
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 22:41:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752512Ab3AAVld convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jan 2013 16:41:33 -0500
Received: from mout.web.de ([212.227.17.12]:62485 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752476Ab3AAVlb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Jan 2013 16:41:31 -0500
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0LvS9z-1Spq8S1PIh-010170; Tue, 01 Jan 2013 22:41:30 +0100
X-Provags-ID: V02:K0:9gT4DGwCpOG9KAtiNvqDZlQ4w0zd3bHkOg25ig25T46
 06/aFU7jE8BIqYzi+HFDmgrEnTN9I/NfAIPkh3DbkvSOeXWSpS
 DIQa/FAoShI2HV+jn4UsxLFn0Hqv1+URkA479a89pxeJqn3RZd
 5o7sdPQwbWzyoMiFgEDEov6wTiPXg/GK4LN+nMdpkDPTNwrfic
 CBTMF0t3xIClsoPjw2NVw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212449>

echo -n is not portable on all systems.
Use printf instead

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/t4014-format-patch.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 6cfad13..f460930 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -993,7 +993,7 @@ EOF
 '
=20
 test_expect_success 'signoff: commit with only subject that does not e=
nd with NL' '
-	echo -n subject | append_signoff >actual &&
+	printf subject | append_signoff >actual &&
 	cat >expected <<\EOF &&
 4:Subject: [PATCH] subject
 8:
--=20
1.8.0.197.g5a90748
