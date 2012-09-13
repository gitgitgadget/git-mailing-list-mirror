From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Revert diffstat back to English
Date: Thu, 13 Sep 2012 21:16:26 +0700
Message-ID: <1347545786-936-1-git-send-email-pclouds@gmail.com>
References: <20120913132847.GD4287@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 13 16:16:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCADj-0000FW-4P
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 16:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757293Ab2IMOQf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Sep 2012 10:16:35 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:33120 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757021Ab2IMOQd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 10:16:33 -0400
Received: by obbuo13 with SMTP id uo13so4538483obb.19
        for <git@vger.kernel.org>; Thu, 13 Sep 2012 07:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=uiPKeK9E+nI8DAn82otRlqFeuRU0TFJQGTq2ahRRZCc=;
        b=jepsmPSRtYvYXBhHUdaVQHA+C7JoIaEfDx+MJsEwKa9sQS2Rwmn90C9HMjKGNadxHb
         EsJG8ISgtZMg7BQS4pLoO7+nnYJVQ+KS+YLIe7hZV8aIPo5IR+8BFUVuU0JIivXzn0YL
         Q0+6WGnoWzY7DVGGfLKGPczu4/wjldse1OxqKug3UTlxNWsHyDIin9az5v2BEY47T86u
         AfrhcKe7cjXHBN3Ef+7tL3T7E2lkdN7Dl2nUEpeEtIjbVQhpgG9V2f+LMM0gc3Pw1npB
         EopsPc83n3o2Y9enpqIqa6OuDNhDDU7Jzr83UoVv4hbh3s58fgOp22TLetn2UHjwQov1
         HE7w==
Received: by 10.182.218.37 with SMTP id pd5mr2468263obc.24.1347545793108;
        Thu, 13 Sep 2012 07:16:33 -0700 (PDT)
Received: from lanh ([115.74.50.72])
        by mx.google.com with ESMTPS id a20sm19499291oei.2.2012.09.13.07.16.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 13 Sep 2012 07:16:29 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 13 Sep 2012 21:16:27 +0700
X-Mailer: git-send-email 1.7.12.289.g0ce9864
In-Reply-To: <20120913132847.GD4287@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205381>

This reverts the i18n part of 7f81463 (Use correct grammar in diffstat
summary line - 2012-02-01) but still keeps the grammar correctness for
English. It also reverts b354f11 (Fix tests under GETTEXT_POISON on
diffstat - 2012-08-27). The result is diffstat always in English
for all commands.

This helps stop users from accidentally sending localized
format-patch'd patches.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 On Thu, Sep 13, 2012 at 8:28 PM, Jeff King <peff@peff.net> wrote:
 >   1. Revert diffstat to always be in English/C locale for now. For a=
ll
 >      commands. People too frequently end up showing the output of th=
ings
 >      besides format-patch. It means they will have to read the Engli=
sh
 >      when they are just running locally, but since format-patch is
 >      generating it, it is something that they would need to
 >      understand anyway.

 The "for now" sounds reasonable. Minimum annoyance is always good
 especially in a (largely?) volunteer-driven development environment
 like git. So I revert the i18n effect. Note that I don't optimize the
 changes for English only. The i18n might come back some day if we
 find a good way to do it.

 Git is still partly i18n-ized, turning a few strings back does not
 seem a big regression.

 >   2. If people on non-English projects find that too cumbersome, the=
n we
 >      can switch the "English/C" above for `i18n.projectlang` or
 >      something. But it should not be per-command, but per-message, a=
nd
 >      should include all output that is not diagnostic and is not
 >      machine-parseable (e.g., what I mentioned above, request-pull
 >      output, etc). If it is the project's language, then the team
 >      members will need to know it anyway, so it should not be too bi=
g a
 >      burden to have a potentially different language there than in t=
he
 >      diagnostic messages.

 If you mean projectlang vs a local language, I looked into that and I
 don't think we could support two non-C languages using standard
 gettext interface. So it's either "C vs another", or make use of
 unofficial gettext features, or roll your own.

 diff.c                        | 10 ++++------
 t/t4006-diff-mode.sh          |  8 ++++----
 t/t4202-log.sh                |  2 +-
 t/t4205-log-pretty-formats.sh |  4 ++--
 t/t7508-status.sh             |  2 +-
 5 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/diff.c b/diff.c
index e6846ca..8c23b9c 100644
--- a/diff.c
+++ b/diff.c
@@ -1398,11 +1398,11 @@ int print_stat_summary(FILE *fp, int files, int=
 insertions, int deletions)
=20
 	if (!files) {
 		assert(insertions =3D=3D 0 && deletions =3D=3D 0);
-		return fprintf(fp, "%s\n", _(" 0 files changed"));
+		return fprintf(fp, "%s\n", " 0 files changed");
 	}
=20
 	strbuf_addf(&sb,
-		    Q_(" %d file changed", " %d files changed", files),
+		    files ? " %d files changed" : " %d file changed",
 		    files);
=20
 	/*
@@ -1419,8 +1419,7 @@ int print_stat_summary(FILE *fp, int files, int i=
nsertions, int deletions)
 		 * do not translate it.
 		 */
 		strbuf_addf(&sb,
-			    Q_(", %d insertion(+)", ", %d insertions(+)",
-			       insertions),
+			    insertions ? ", %d insertions(+)" : ", %d insertion(+)",
 			    insertions);
 	}
=20
@@ -1430,8 +1429,7 @@ int print_stat_summary(FILE *fp, int files, int i=
nsertions, int deletions)
 		 * do not translate it.
 		 */
 		strbuf_addf(&sb,
-			    Q_(", %d deletion(-)", ", %d deletions(-)",
-			       deletions),
+			    deletions ? ", %d deletions(-)" : ", %d deletion(-)",
 			    deletions);
 	}
 	strbuf_addch(&sb, '\n');
diff --git a/t/t4006-diff-mode.sh b/t/t4006-diff-mode.sh
index 3d4b1ba..7a3e1f9 100755
--- a/t/t4006-diff-mode.sh
+++ b/t/t4006-diff-mode.sh
@@ -36,24 +36,24 @@ test_expect_success '--stat output after text chmod=
' '
 	test_chmod -x rezrov &&
 	echo " 0 files changed" >expect &&
 	git diff HEAD --stat >actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
=20
 test_expect_success '--shortstat output after text chmod' '
 	git diff HEAD --shortstat >actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
=20
 test_expect_success '--stat output after binary chmod' '
 	test_chmod +x binbin &&
 	echo " 0 files changed" >expect &&
 	git diff HEAD --stat >actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
=20
 test_expect_success '--shortstat output after binary chmod' '
 	git diff HEAD --shortstat >actual &&
-	test_i18ncmp expect actual
+	test_cmp expect actual
 '
=20
 test_done
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 924ba53..b3ac6be 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -813,7 +813,7 @@ sanitize_output () {
 test_expect_success 'log --graph with diff and stats' '
 	git log --graph --pretty=3Dshort --stat -p >actual &&
 	sanitize_output >actual.sanitized <actual &&
-	test_i18ncmp expect actual.sanitized
+	test_cmp expect actual.sanitized
 '
=20
 test_expect_success 'dotdot is a parent directory' '
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats=
=2Esh
index 2c45de7..4afd778 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -88,7 +88,7 @@ test_expect_success 'NUL separation with --stat' '
 	stat1_part=3D$(git diff --stat --root HEAD^) &&
 	printf "add bar\n$stat0_part\n\0initial\n$stat1_part\n" >expected &&
 	git log -z --stat --pretty=3D"format:%s" >actual &&
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
=20
 test_expect_failure 'NUL termination with --stat' '
@@ -96,7 +96,7 @@ test_expect_failure 'NUL termination with --stat' '
 	stat1_part=3D$(git diff --stat --root HEAD^) &&
 	printf "add bar\n$stat0_part\n\0initial\n$stat1_part\n\0" >expected &=
&
 	git log -z --stat --pretty=3D"tformat:%s" >actual &&
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
=20
 test_done
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index e313ef1..c206f47 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -80,7 +80,7 @@ test_expect_success 'status --column' '
 #	dir1/untracked dir2/untracked untracked
 #	dir2/modified  output
 EOF
-	test_i18ncmp expect output
+	test_cmp expect output
 '
=20
 cat >expect <<\EOF
--=20
1.7.12.396.g87e837f.dirty
