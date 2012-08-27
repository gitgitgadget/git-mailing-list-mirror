From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v3 3/7] Fix tests under GETTEXT_POISON on diffstat
Date: Tue, 28 Aug 2012 06:59:13 +0800
Message-ID: <19564c3c4288172ab1cf2c7097a750f5689faba8.1346108242.git.worldhello.net@gmail.com>
References: <cover.1346108242.git.worldhello.net@gmail.com>
 <1954d94a032f1cedee953a7db5da8f6d37e4c7d9.1346108242.git.worldhello.net@gmail.com>
 <4e2f6d25bc4588f478bb3b6866290f2feabc03d0.1346108242.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 28 00:59:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T68HU-0007sk-BR
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 00:59:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754900Ab2H0W7a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Aug 2012 18:59:30 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:61072 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753150Ab2H0W70 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 18:59:26 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so8239394pbb.19
        for <git@vger.kernel.org>; Mon, 27 Aug 2012 15:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=vgYAhggK0vJqNxQsxi9QuReqCE7vch3wWsHbxiqraoQ=;
        b=cIGAWbhgwyjQAoZvs2xQp+2oBs1WxKlf/7Q7/GU1RAPO2KYI+KulqEa7L5URoZWAt5
         merk/NMQPys9cbAbbf7xcqefvHet8rDtLkKZM1atxb3DhDGBx8IFhk1h8ZjLE9db3kEB
         ukMArLI33YY0xctUEoDlIlNJgc0Xfm4sr0m5EKj/C+siP6x1aSMWl8UAmFhU7ib4vS8v
         oCThuNbU2YqCzGSUfrWPvBYAmsg9Fktnnr8nIWrc54E1TdCx8Ky+WhWru+OaHeczakMQ
         f3y/FX+4AqDP6+nX0W45PYNSFTpT8M5P1XZZs+2WzG0apZnuucTrxJ0+j96K+o68RgLN
         4DVQ==
Received: by 10.68.221.42 with SMTP id qb10mr37700158pbc.155.1346108366724;
        Mon, 27 Aug 2012 15:59:26 -0700 (PDT)
Received: from localhost.foo.bar ([123.115.151.199])
        by mx.google.com with ESMTPS id qn13sm15577687pbb.71.2012.08.27.15.59.23
        (version=SSLv3 cipher=OTHER);
        Mon, 27 Aug 2012 15:59:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.92.g949df84
In-Reply-To: <4e2f6d25bc4588f478bb3b6866290f2feabc03d0.1346108242.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1346108242.git.worldhello.net@gmail.com>
References: <cover.1346108242.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204382>

Use i18n-specific test functions in test scripts for diffstat.
This issue was was introduced in v1.7.9-1-g7f814:

    7f814 Use correct grammar in diffstat summary line

and been broken under GETTEXT_POISON=3DYesPlease since.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t4006-diff-mode.sh          | 8 ++++----
 t/t4202-log.sh                | 2 +-
 t/t4205-log-pretty-formats.sh | 4 ++--
 t/t7508-status.sh             | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t4006-diff-mode.sh b/t/t4006-diff-mode.sh
index 7a3e1..3d4b1 100755
--- a/t/t4006-diff-mode.sh
+++ b/t/t4006-diff-mode.sh
@@ -36,24 +36,24 @@ test_expect_success '--stat output after text chmod=
' '
 	test_chmod -x rezrov &&
 	echo " 0 files changed" >expect &&
 	git diff HEAD --stat >actual &&
-	test_cmp expect actual
+	test_i18ncmp expect actual
 '
=20
 test_expect_success '--shortstat output after text chmod' '
 	git diff HEAD --shortstat >actual &&
-	test_cmp expect actual
+	test_i18ncmp expect actual
 '
=20
 test_expect_success '--stat output after binary chmod' '
 	test_chmod +x binbin &&
 	echo " 0 files changed" >expect &&
 	git diff HEAD --stat >actual &&
-	test_cmp expect actual
+	test_i18ncmp expect actual
 '
=20
 test_expect_success '--shortstat output after binary chmod' '
 	git diff HEAD --shortstat >actual &&
-	test_cmp expect actual
+	test_i18ncmp expect actual
 '
=20
 test_done
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 71be5..31869 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -803,7 +803,7 @@ sanitize_output () {
 test_expect_success 'log --graph with diff and stats' '
 	git log --graph --pretty=3Dshort --stat -p >actual &&
 	sanitize_output >actual.sanitized <actual &&
-	test_cmp expect actual.sanitized
+	test_i18ncmp expect actual.sanitized
 '
=20
 test_done
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats=
=2Esh
index 4afd77..2c45d 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -88,7 +88,7 @@ test_expect_success 'NUL separation with --stat' '
 	stat1_part=3D$(git diff --stat --root HEAD^) &&
 	printf "add bar\n$stat0_part\n\0initial\n$stat1_part\n" >expected &&
 	git log -z --stat --pretty=3D"format:%s" >actual &&
-	test_cmp expected actual
+	test_i18ncmp expected actual
 '
=20
 test_expect_failure 'NUL termination with --stat' '
@@ -96,7 +96,7 @@ test_expect_failure 'NUL termination with --stat' '
 	stat1_part=3D$(git diff --stat --root HEAD^) &&
 	printf "add bar\n$stat0_part\n\0initial\n$stat1_part\n\0" >expected &=
&
 	git log -z --stat --pretty=3D"tformat:%s" >actual &&
-	test_cmp expected actual
+	test_i18ncmp expected actual
 '
=20
 test_done
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index c206f..e313e 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -80,7 +80,7 @@ test_expect_success 'status --column' '
 #	dir1/untracked dir2/untracked untracked
 #	dir2/modified  output
 EOF
-	test_cmp expect output
+	test_i18ncmp expect output
 '
=20
 cat >expect <<\EOF
--=20
1.7.12.92.g949df84
