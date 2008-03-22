From: =?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
Subject: [PATCH] =?utf-8?q?Check=20for=20non=E2=80=90foreign=20commits=20in=20rebase-interactive=20test?=
Date: Sat, 22 Mar 2008 02:19:43 +0100
Message-ID: <1206148785-29466-2-git-send-email-joerg@alea.gnuu.de>
References: <1206148785-29466-1-git-send-email-joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com,
	=?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 22 02:21:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcsQN-0007nL-3q
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 02:21:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754540AbYCVBUj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Mar 2008 21:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754391AbYCVBUg
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 21:20:36 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:3294 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754117AbYCVBUe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 21:20:34 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 75925488025; Sat, 22 Mar 2008 02:20:32 +0100 (CET)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JcsOW-0007W6-BX; Sat, 22 Mar 2008 02:19:36 +0100
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JcsOf-0007fd-Nu; Sat, 22 Mar 2008 02:19:45 +0100
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1206148785-29466-1-git-send-email-joerg@alea.gnuu.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77785>


Signed-off-by: J=C3=B6rg Sommer <joerg@alea.gnuu.de>
---
 t/t3404-rebase-interactive.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive=
=2Esh
index 9cf873f..7d1e469 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -185,7 +185,7 @@ test_expect_success 'retain authorship when squashi=
ng' '
=20
 test_expect_success '-p handles "no changes" gracefully' '
 	HEAD=3D$(git rev-parse HEAD) &&
-	git rebase -i -p HEAD^ &&
+	EXPECT_COUNT=3D1 git rebase -i -p HEAD^ &&
 	test $HEAD =3D $(git rev-parse HEAD)
 '
=20
@@ -205,7 +205,7 @@ test_expect_success 'preserve merges with -p' '
 	test_tick &&
 	git commit -m K file1 &&
 	test_tick &&
-	git rebase -i -p --onto branch1 master &&
+	EXPECT_COUNT=3D3 git rebase -i -p --onto branch1 master &&
 	test $(git rev-parse HEAD^^2) =3D $(git rev-parse to-be-preserved) &&
 	test $(git rev-parse HEAD~3) =3D $(git rev-parse branch1) &&
 	test $(git show HEAD:file1) =3D C &&
--=20
1.5.4.4
