From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2 4/7] Fix tests under GETTEXT_POISON on git-apply
Date: Mon, 27 Aug 2012 13:36:52 +0800
Message-ID: <d20c47e9618f998b84934c0310f3de51d791e83f.1346045253.git.worldhello.net@gmail.com>
References: <cover.1346045253.git.worldhello.net@gmail.com>
 <1b42b555cd785e19e95c730ac00271a2fee64edb.1346045253.git.worldhello.net@gmail.com>
 <08d87cf811ed6ea328303b8ca26f1ab32cacfba9.1346045253.git.worldhello.net@gmail.com>
 <7398781c6d647557954f4a0c7df29fc98aad842b.1346045253.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 07:37:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5s12-00030m-OU
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 07:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053Ab2H0Fh1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Aug 2012 01:37:27 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57439 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996Ab2H0FhY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 01:37:24 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so6802416pbb.19
        for <git@vger.kernel.org>; Sun, 26 Aug 2012 22:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=my9FkvW6uRZeYimmjNV8xLIWafDplMUymxHpcOab28U=;
        b=HSg0Ddh3dI7nTaNMhix3otYeHXsPAL/F2eagJuaovuX7kdADHiORAdf9PnEphvLiJr
         Gn4brHjB0lrmRtdeTn5XVnGowQgVJAWisbJXRiuvw0CtN1V2M67kOwDgWOr6A6P7Bx5p
         dPaT8a837LMqNwtH9wyp6eK7PZy1st0HyiYiRE+LuoKaFz+tenulZUeGT/yX2Peg01DP
         CbuMaZt4d1cLtai1EisVY5igmeRPLPhhQsMDGCP3FRNKT3ryK6LEQ0AXli4zg1N/HpeC
         swMgwqAWwv//FaOIjuVldVmU5sJA2yjxgabYEfIjoh6apYlhVbLeD/Bb5f62iRpRre0m
         wZhQ==
Received: by 10.66.75.201 with SMTP id e9mr27537687paw.54.1346045844725;
        Sun, 26 Aug 2012 22:37:24 -0700 (PDT)
Received: from localhost.foo.bar ([123.116.231.150])
        by mx.google.com with ESMTPS id gf3sm13924207pbc.74.2012.08.26.22.37.20
        (version=SSLv3 cipher=OTHER);
        Sun, 26 Aug 2012 22:37:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.92.gaa91cb5
In-Reply-To: <7398781c6d647557954f4a0c7df29fc98aad842b.1346045253.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1346045253.git.worldhello.net@gmail.com>
References: <1345523464-14586-1-git-send-email-pclouds@gmail.com> <cover.1346045253.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204323>

Use i18n-specific test functions in test scripts for git-apply.
This issue was was introduced in the following commits:

    de373 i18n: apply: mark parseopt strings for translation
    3638e i18n: apply: mark strings for translation

and been broken under GETTEXT_POISON=3DYesPlease since.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t4012-diff-binary.sh     | 4 ++--
 t/t4120-apply-popt.sh      | 4 ++--
 t/t4133-apply-filenames.sh | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
index ec4de..1215a 100755
--- a/t/t4012-diff-binary.sh
+++ b/t/t4012-diff-binary.sh
@@ -63,7 +63,7 @@ test_expect_success 'apply --numstat understands diff=
 --binary format' '
=20
 # apply needs to be able to skip the binary material correctly
 # in order to report the line number of a corrupt patch.
-test_expect_success 'apply detecting corrupt patch correctly' '
+test_expect_success C_LOCALE_OUTPUT 'apply detecting corrupt patch cor=
rectly' '
 	git diff >output &&
 	sed -e "s/-CIT/xCIT/" <output >broken &&
 	test_must_fail git apply --stat --summary broken 2>detected &&
@@ -73,7 +73,7 @@ test_expect_success 'apply detecting corrupt patch co=
rrectly' '
 	test "$detected" =3D xCIT
 '
=20
-test_expect_success 'apply detecting corrupt patch correctly' '
+test_expect_success C_LOCALE_OUTPUT 'apply detecting corrupt patch cor=
rectly' '
 	git diff --binary | sed -e "s/-CIT/xCIT/" >broken &&
 	test_must_fail git apply --stat --summary broken 2>detected &&
 	detected=3D`cat detected` &&
diff --git a/t/t4120-apply-popt.sh b/t/t4120-apply-popt.sh
index a33d5..c5fec 100755
--- a/t/t4120-apply-popt.sh
+++ b/t/t4120-apply-popt.sh
@@ -32,7 +32,7 @@ test_expect_success 'apply git diff with -p2' '
 test_expect_success 'apply with too large -p' '
 	cp file1.saved file1 &&
 	test_must_fail git apply --stat -p3 patch.file 2>err &&
-	grep "removing 3 leading" err
+	test_i18ngrep "removing 3 leading" err
 '
=20
 test_expect_success 'apply (-p2) traditional diff with funny filenames=
' '
@@ -54,7 +54,7 @@ test_expect_success 'apply (-p2) traditional diff wit=
h funny filenames' '
 test_expect_success 'apply with too large -p and fancy filename' '
 	cp file1.saved file1 &&
 	test_must_fail git apply --stat -p3 patch.escaped 2>err &&
-	grep "removing 3 leading" err
+	test_i18ngrep "removing 3 leading" err
 '
=20
 test_expect_success 'apply (-p2) diff, mode change only' '
diff --git a/t/t4133-apply-filenames.sh b/t/t4133-apply-filenames.sh
index 94da9..2ecb4 100755
--- a/t/t4133-apply-filenames.sh
+++ b/t/t4133-apply-filenames.sh
@@ -30,9 +30,9 @@ EOF
=20
 test_expect_success 'apply diff with inconsistent filenames in headers=
' '
 	test_must_fail git apply bad1.patch 2>err &&
-	grep "inconsistent new filename" err &&
+	test_i18ngrep "inconsistent new filename" err &&
 	test_must_fail git apply bad2.patch 2>err &&
-	grep "inconsistent old filename" err
+	test_i18ngrep "inconsistent old filename" err
 '
=20
 test_done
--=20
1.7.12.92.gaa91cb5
