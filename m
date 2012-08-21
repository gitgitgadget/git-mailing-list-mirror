From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/7] Fix tests under GETTEXT_POISON on diffstat
Date: Tue, 21 Aug 2012 11:31:00 +0700
Message-ID: <1345523464-14586-4-git-send-email-pclouds@gmail.com>
References: <1345523464-14586-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 21 06:32:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3g8k-0006ui-4G
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 06:32:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432Ab2HUEcQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Aug 2012 00:32:16 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62578 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174Ab2HUEb7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 00:31:59 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so7914089pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 21:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=7qq+6NzPLjcbT1rHMLZV45KoxNT8nYjU6JEgDRSPBwM=;
        b=L4QBF9i0579JLmGZR14ZFHNqubGy0KsV7vqlp6UpL71+vtbihEg519Vkj9P9uPTuZb
         76IMLlC3EMxUW9EbrzgVLvqt9lkLZbSS6QzP22YOZhkvz3XjqUupWgMz74ZExiXLOxWE
         bN7RKg3u2uKBWX4pKva0BxPZM6UW//qqR+AeQlhTXttuRUd0urlwiSJY0N7HzweqHW6H
         9BqPnUAWDxEBvilPWZANOPAn+ppveu8VGLmTav7h2kuNykGCQTOZKzt3fNiMP12mheiv
         icGABHwAzI7HbXJitRpGFLLQP/dKUDkwPE71Iab4o5u1fZux9RlDInDFkGj9diHeyr2y
         4WkQ==
Received: by 10.66.76.165 with SMTP id l5mr9852670paw.79.1345523519095;
        Mon, 20 Aug 2012 21:31:59 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id pj10sm573270pbb.46.2012.08.20.21.31.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 21:31:58 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 21 Aug 2012 11:31:42 +0700
X-Mailer: git-send-email 1.7.12.rc2
In-Reply-To: <1345523464-14586-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203930>

=46rom: Jiang Xin <worldhello.net@gmail.com>

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
index 7a3e1f9..3d4b1ba 100755
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
index 71be59d..31869dc 100755
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
index 4afd778..2c45de7 100755
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
index c206f47..e313ef1 100755
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
1.7.12.rc2
