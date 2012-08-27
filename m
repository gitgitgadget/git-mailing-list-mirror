From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v3 4/7] Fix tests under GETTEXT_POISON on git-apply
Date: Tue, 28 Aug 2012 06:59:14 +0800
Message-ID: <c7c8ebb234e8bd0771cfd7d2f715f06d86e5c472.1346108242.git.worldhello.net@gmail.com>
References: <cover.1346108242.git.worldhello.net@gmail.com>
 <1954d94a032f1cedee953a7db5da8f6d37e4c7d9.1346108242.git.worldhello.net@gmail.com>
 <4e2f6d25bc4588f478bb3b6866290f2feabc03d0.1346108242.git.worldhello.net@gmail.com>
 <19564c3c4288172ab1cf2c7097a750f5689faba8.1346108242.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 28 00:59:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T68HU-0007sk-SP
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 00:59:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754902Ab2H0W7b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Aug 2012 18:59:31 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:61072 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754896Ab2H0W7a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 18:59:30 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so8239394pbb.19
        for <git@vger.kernel.org>; Mon, 27 Aug 2012 15:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=NBm8oLhwd240aMcKCU+t6aKh+ue7fzo3r8LMyoarGoE=;
        b=Q/lSOMUBaXR+ez6OpTF6QtgGM+6xQYFTwKviFbKDa4ynGdGWvFevcntZZrQQQ59k9F
         +bl4CNbOM7WOMEAGFXEmydpagxPIEwe9DZCsTTmwKAycH9hHj9tIgt6/A3nx5/GhC6Kj
         iNjuW0Tm/JEd9KIYKVIPx+W7NWsJAywJqKKax5f5WAVHIaaIzuvQcRwrpjCZmgynbHxi
         xB9pjO2osAiX48sKMEYqsO3jsMBHDtHfOzjRroZ4+HR4RSw9TkOs6cgnK19DAecySmS4
         X+81MKUL4rOhkpP8oBoWCbFYZ1qdIjvaESv+mWVW8NyOdZh/DSAALOIksp1HtjI4Li91
         fCNw==
Received: by 10.68.234.73 with SMTP id uc9mr37514512pbc.158.1346108370000;
        Mon, 27 Aug 2012 15:59:30 -0700 (PDT)
Received: from localhost.foo.bar ([123.115.151.199])
        by mx.google.com with ESMTPS id qn13sm15577687pbb.71.2012.08.27.15.59.27
        (version=SSLv3 cipher=OTHER);
        Mon, 27 Aug 2012 15:59:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.92.g949df84
In-Reply-To: <19564c3c4288172ab1cf2c7097a750f5689faba8.1346108242.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1346108242.git.worldhello.net@gmail.com>
References: <cover.1346108242.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204381>

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
1.7.12.92.g949df84
