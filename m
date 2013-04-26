From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH 1/5] t9020: do not use export X=Y
Date: Fri, 26 Apr 2013 11:18:16 +0200
Message-ID: <201304261118.17130.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 11:18:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVenT-0000Vr-JS
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 11:18:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758918Ab3DZJSX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Apr 2013 05:18:23 -0400
Received: from mout.web.de ([212.227.17.11]:50041 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758893Ab3DZJSX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Apr 2013 05:18:23 -0400
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0LiCbT-1UrZLp0WLT-00nN01 for <git@vger.kernel.org>; Fri,
 26 Apr 2013 11:18:22 +0200
X-Provags-ID: V02:K0:mJ14lcEjVPTnVuuy7cXtopD8bObyBawVE05lslMgd43
 piS0LVpl5iZWTFjmAw7J+4RumaiUdVF94aZLSRBgcyssljz+Fj
 Z9zanuZX+NX5IdOsRzpdrxnFji1U9Rl9W24Qy6etM9DkuTilbp
 vSBB1Ooq1iu2juh7loYOHRIXEFf6r3Mg2gX8eSfyhC/Vy1zOR5
 zzyoPv8kc1tV3wSqO3pLw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222520>

The shell syntax "export X=3DY" is not understood by all shells.
Split the non portable line into separate lines like this:
X=3DY
export X

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/t9020-remote-svn.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t9020-remote-svn.sh b/t/t9020-remote-svn.sh
index 2d2f016..d9f6b73 100755
--- a/t/t9020-remote-svn.sh
+++ b/t/t9020-remote-svn.sh
@@ -74,7 +74,8 @@ test_expect_success REMOTE_SVN 'mark-file regeneratio=
n' '
 '
=20
 test_expect_success REMOTE_SVN 'incremental imports must lead to the s=
ame head' '
-	export SVNRMAX=3D3 &&
+	SVNRMAX=3D3 &&
+	export SVNRMAX &&
 	init_git &&
 	git fetch svnsim &&
 	test_cmp .git/refs/svn/svnsim/master .git/refs/remotes/svnsim/master =
 &&
--=20
1.8.2.1.614.g66d7af5
