From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2 3/7] Fix tests under GETTEXT_POISON on diffstat
Date: Mon, 27 Aug 2012 13:36:51 +0800
Message-ID: <7398781c6d647557954f4a0c7df29fc98aad842b.1346045253.git.worldhello.net@gmail.com>
References: <cover.1346045253.git.worldhello.net@gmail.com>
 <1b42b555cd785e19e95c730ac00271a2fee64edb.1346045253.git.worldhello.net@gmail.com>
 <08d87cf811ed6ea328303b8ca26f1ab32cacfba9.1346045253.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 07:37:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5s0t-0002xl-F4
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 07:37:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752030Ab2H0FhV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Aug 2012 01:37:21 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:47886 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996Ab2H0FhT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 01:37:19 -0400
Received: by dady13 with SMTP id y13so2294471dad.19
        for <git@vger.kernel.org>; Sun, 26 Aug 2012 22:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=fmBK3psaqqL8Qip3tQxbTnb2+u7RnD+8MWa/g89NU90=;
        b=AalKCAhc62lA5XOMQ3in006fZ6CAvfO2mKb4wgKymoUniCILsl8d6CqzUwX3FscaL0
         gN6zt9jeyzaeXIW/2+Pz/IyWYjNtZrirLR2EvL0+Im7EiWPXxbcSOh3z0YkccHg5O+Jl
         N9UdlISGRUkXUxF0AWMUR0O2ckAdfpYzl15F//ghWNOFbDXe4BM/h0TudUbg2ItW7f7I
         IGKsb1NY2bqCegfuWQmlC3bugMDZFgPrT2mAtYxlpn8nEadQBj6KgTCIQwmi5xR9yHR5
         BwtF9O3IPZGOugyqhSKg5x4OyKkBWZh0oepvT3VlnsONC78BLSfsL03rb+ytdmnRZL64
         edAA==
Received: by 10.68.241.72 with SMTP id wg8mr17013576pbc.96.1346045839538;
        Sun, 26 Aug 2012 22:37:19 -0700 (PDT)
Received: from localhost.foo.bar ([123.116.231.150])
        by mx.google.com with ESMTPS id gf3sm13924207pbc.74.2012.08.26.22.37.15
        (version=SSLv3 cipher=OTHER);
        Sun, 26 Aug 2012 22:37:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.92.gaa91cb5
In-Reply-To: <08d87cf811ed6ea328303b8ca26f1ab32cacfba9.1346045253.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1346045253.git.worldhello.net@gmail.com>
References: <1345523464-14586-1-git-send-email-pclouds@gmail.com> <cover.1346045253.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204322>

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
1.7.12.92.gaa91cb5
