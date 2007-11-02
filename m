From: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
Subject: [PATCH 2/4] Remove unecessary hard-coding of EDITOR=':' VISUAL=':' in some test suites.
Date: Fri,  2 Nov 2007 11:33:07 -0400
Message-ID: <1194017589-4669-2-git-send-email-krh@redhat.com>
References: <1194017589-4669-1-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 16:34:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InyX9-0003Av-7u
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 16:34:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753972AbXKBPdk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Nov 2007 11:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753964AbXKBPdk
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 11:33:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57014 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753971AbXKBPdj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 11:33:39 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lA2FXG7V007560;
	Fri, 2 Nov 2007 11:33:16 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lA2FXF2Q020010;
	Fri, 2 Nov 2007 11:33:15 -0400
Received: from localhost.localdomain (dhcp83-9.boston.redhat.com [172.16.83.9])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id lA2FXEIJ006415;
	Fri, 2 Nov 2007 11:33:14 -0400
X-Mailer: git-send-email 1.5.3.4.206.g58ba4
In-Reply-To: <1194017589-4669-1-git-send-email-krh@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63133>

Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
---
 t/t3501-revert-cherry-pick.sh |    4 ++--
 t/t3901-i18n-patch.sh         |    8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick=
=2Esh
index 552af1c..2dbe04f 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -44,7 +44,7 @@ test_expect_success setup '
 test_expect_success 'cherry-pick after renaming branch' '
=20
 	git checkout rename2 &&
-	EDITOR=3D: VISUAL=3D: git cherry-pick added &&
+	git cherry-pick added &&
 	test -f opos &&
 	grep "Add extra line at the end" opos
=20
@@ -53,7 +53,7 @@ test_expect_success 'cherry-pick after renaming branc=
h' '
 test_expect_success 'revert after renaming branch' '
=20
 	git checkout rename1 &&
-	EDITOR=3D: VISUAL=3D: git revert added &&
+	git revert added &&
 	test -f spoo &&
 	! grep "Add extra line at the end" spoo
=20
diff --git a/t/t3901-i18n-patch.sh b/t/t3901-i18n-patch.sh
index 28e9e37..235f372 100755
--- a/t/t3901-i18n-patch.sh
+++ b/t/t3901-i18n-patch.sh
@@ -154,7 +154,7 @@ test_expect_success 'cherry-pick(U/U)' '
 	git reset --hard master &&
 	git cherry-pick side^ &&
 	git cherry-pick side &&
-	EDITOR=3D: VISUAL=3D: git revert HEAD &&
+	git revert HEAD &&
=20
 	check_encoding 3
 '
@@ -169,7 +169,7 @@ test_expect_success 'cherry-pick(L/L)' '
 	git reset --hard master &&
 	git cherry-pick side^ &&
 	git cherry-pick side &&
-	EDITOR=3D: VISUAL=3D: git revert HEAD &&
+	git revert HEAD &&
=20
 	check_encoding 3 8859
 '
@@ -184,7 +184,7 @@ test_expect_success 'cherry-pick(U/L)' '
 	git reset --hard master &&
 	git cherry-pick side^ &&
 	git cherry-pick side &&
-	EDITOR=3D: VISUAL=3D: git revert HEAD &&
+	git revert HEAD &&
=20
 	check_encoding 3
 '
@@ -200,7 +200,7 @@ test_expect_success 'cherry-pick(L/U)' '
 	git reset --hard master &&
 	git cherry-pick side^ &&
 	git cherry-pick side &&
-	EDITOR=3D: VISUAL=3D: git revert HEAD &&
+	git revert HEAD &&
=20
 	check_encoding 3 8859
 '
--=20
1.5.3.4.206.g58ba4
