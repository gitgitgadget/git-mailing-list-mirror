From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 56/72] gettextize: git-status "Changes to be committed" message
Date: Sat, 19 Feb 2011 19:24:39 +0000
Message-ID: <1298143495-3681-57-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:29:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsUc-0003dU-Ov
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:29:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756357Ab1BST3U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:29:20 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40522 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756142Ab1BST2O (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:28:14 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so2347071eye.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=PhAEx91is5C5t5lR+8NVXlwgj/WWsJRQ83mTlf2YoRg=;
        b=oak0gkXsE+am6zbWSUu1n7jIMDaPYpwI5Y72RFNtMslXMrumtjcCu6csGB8JfXdlJ1
         paZV0C89L0+yZ0Xawgu6Gcv+sVSYho/S4m+i3uwWCqB7dSsMvdhlUrgAlL34rY95WfK3
         MpIMncb6LKFbEPZAaokBD4DRJVLkw4H2UTjLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=SgJdsmRyDSu3mCc4Zp4a0GGQGkBGknzWdC4no1kxn4ag2B6IylowfKfJKlWEjVtIzT
         vi6Ik1h2z+uQHB/FmyleXRguIzXZgSdfmeqJLCvfnaobueb6n9w/KqNQ3tOOpjLDJUpw
         vlxLWZ/MfHs9vN+szMuufV0MB/O91fdFtaojE=
Received: by 10.213.31.196 with SMTP id z4mr2550371ebc.1.1298143693757;
        Sat, 19 Feb 2011 11:28:13 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.28.13
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:28:13 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167361>

Gettextize the "# Changes to be committed:" messages. Several tests
explicitly checked for this message. Change them to skip under
GETTEXT_POISON=3DYesPlease.

Since these tests didn't check for the rest of the git-status(1)
output this change has been split up from the "git-status basic
messages" patch.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t7502-commit.sh |   20 ++++++++++----------
 wt-status.c       |    2 +-
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index 6586355..d7c4280 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -384,66 +384,66 @@ try_commit () {
=20
 try_commit_status_combo () {
=20
-	test_expect_success 'commit' '
+	test_expect_success NO_GETTEXT_POISON 'commit' '
 		clear_config commit.status &&
 		try_commit "" &&
 		grep "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
=20
-	test_expect_success 'commit' '
+	test_expect_success NO_GETTEXT_POISON 'commit' '
 		clear_config commit.status &&
 		try_commit "" &&
 		grep "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
=20
-	test_expect_success 'commit --status' '
+	test_expect_success NO_GETTEXT_POISON 'commit --status' '
 		clear_config commit.status &&
 		try_commit --status &&
 		grep "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
=20
-	test_expect_success 'commit --no-status' '
+	test_expect_success NO_GETTEXT_POISON 'commit --no-status' '
 		clear_config commit.status &&
 		try_commit --no-status &&
 		! grep "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
=20
-	test_expect_success 'commit with commit.status =3D yes' '
+	test_expect_success NO_GETTEXT_POISON 'commit with commit.status =3D =
yes' '
 		clear_config commit.status &&
 		git config commit.status yes &&
 		try_commit "" &&
 		grep "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
=20
-	test_expect_success 'commit with commit.status =3D no' '
+	test_expect_success NO_GETTEXT_POISON 'commit with commit.status =3D =
no' '
 		clear_config commit.status &&
 		git config commit.status no &&
 		try_commit "" &&
 		! grep "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
=20
-	test_expect_success 'commit --status with commit.status =3D yes' '
+	test_expect_success NO_GETTEXT_POISON 'commit --status with commit.st=
atus =3D yes' '
 		clear_config commit.status &&
 		git config commit.status yes &&
 		try_commit --status &&
 		grep "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
=20
-	test_expect_success 'commit --no-status with commit.status =3D yes' '
+	test_expect_success NO_GETTEXT_POISON 'commit --no-status with commit=
=2Estatus =3D yes' '
 		clear_config commit.status &&
 		git config commit.status yes &&
 		try_commit --no-status &&
 		! grep "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
=20
-	test_expect_success 'commit --status with commit.status =3D no' '
+	test_expect_success NO_GETTEXT_POISON 'commit --status with commit.st=
atus =3D no' '
 		clear_config commit.status &&
 		git config commit.status no &&
 		try_commit --status &&
 		grep "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
=20
-	test_expect_success 'commit --no-status with commit.status =3D no' '
+	test_expect_success NO_GETTEXT_POISON 'commit --no-status with commit=
=2Estatus =3D no' '
 		clear_config commit.status &&
 		git config commit.status no &&
 		try_commit --no-status &&
diff --git a/wt-status.c b/wt-status.c
index fc38ac2..c6295f9 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -74,7 +74,7 @@ static void wt_status_print_cached_header(struct wt_s=
tatus *s)
 {
 	const char *c =3D color(WT_STATUS_HEADER, s);
=20
-	color_fprintf_ln(s->fp, c, "# Changes to be committed:");
+	color_fprintf_ln(s->fp, c, _("# Changes to be committed:"));
 	if (!advice_status_hints)
 		return;
 	if (s->in_merge)
--=20
1.7.2.3
