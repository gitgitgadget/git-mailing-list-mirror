From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 57/73] gettextize: git-status "Changes to be committed" message
Date: Tue, 22 Feb 2011 23:42:16 +0000
Message-ID: <1298418152-27789-58-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:45:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1vL-0000K1-80
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:45:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755688Ab1BVXpi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:45:38 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:39209 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755544Ab1BVXo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:44:29 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3866615bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=lQ8DQTyUsOke495OLeTwcPGt4tdMhA7amjxmaxUOITY=;
        b=LniQPxQ3wOKg8iN3sj1iLOBpIpid+88IyPF2RgQvT7Cbv2ZBfqLE0d9QIH0FSCW3Jh
         M0XH1nWPCjyZgmq5FpozVoNqnM1wWd/C/stgs7j7LIbTSJyENCCcnlTpmY8DIYBnE1XS
         7LenF2kxXKXfx9p8LLIts4czan4f7FOhz7jMY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=b3aKwS1eykZheZnCrkKi6YTOwCYTFdoxlfnHGO7TLgN6TacItgtDfbrecwYq4DkSbA
         tDQWYfEPGIM1qHBmqicU4hqYOkTgN8RtWPZszcDecIeXfCGHVz15J0fUWQDYWuM2GjjY
         hlL72yGux+6YmbrlL3vTfg4ky+Ycvw0TFCh+s=
Received: by 10.204.26.200 with SMTP id f8mr3130764bkc.46.1298418269023;
        Tue, 22 Feb 2011 15:44:29 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.44.28
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:44:28 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167625>

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
index 1f29b5c..cfb569e 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -384,66 +384,66 @@ try_commit () {
=20
 try_commit_status_combo () {
=20
-	test_expect_success 'commit' '
+	test_expect_success C_LOCALE_OUTPUT 'commit' '
 		clear_config commit.status &&
 		try_commit "" &&
 		grep "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
=20
-	test_expect_success 'commit' '
+	test_expect_success C_LOCALE_OUTPUT 'commit' '
 		clear_config commit.status &&
 		try_commit "" &&
 		grep "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
=20
-	test_expect_success 'commit --status' '
+	test_expect_success C_LOCALE_OUTPUT 'commit --status' '
 		clear_config commit.status &&
 		try_commit --status &&
 		grep "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
=20
-	test_expect_success 'commit --no-status' '
+	test_expect_success C_LOCALE_OUTPUT 'commit --no-status' '
 		clear_config commit.status &&
 		try_commit --no-status &&
 		! grep "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
=20
-	test_expect_success 'commit with commit.status =3D yes' '
+	test_expect_success C_LOCALE_OUTPUT 'commit with commit.status =3D ye=
s' '
 		clear_config commit.status &&
 		git config commit.status yes &&
 		try_commit "" &&
 		grep "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
=20
-	test_expect_success 'commit with commit.status =3D no' '
+	test_expect_success C_LOCALE_OUTPUT 'commit with commit.status =3D no=
' '
 		clear_config commit.status &&
 		git config commit.status no &&
 		try_commit "" &&
 		! grep "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
=20
-	test_expect_success 'commit --status with commit.status =3D yes' '
+	test_expect_success C_LOCALE_OUTPUT 'commit --status with commit.stat=
us =3D yes' '
 		clear_config commit.status &&
 		git config commit.status yes &&
 		try_commit --status &&
 		grep "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
=20
-	test_expect_success 'commit --no-status with commit.status =3D yes' '
+	test_expect_success C_LOCALE_OUTPUT 'commit --no-status with commit.s=
tatus =3D yes' '
 		clear_config commit.status &&
 		git config commit.status yes &&
 		try_commit --no-status &&
 		! grep "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
=20
-	test_expect_success 'commit --status with commit.status =3D no' '
+	test_expect_success C_LOCALE_OUTPUT 'commit --status with commit.stat=
us =3D no' '
 		clear_config commit.status &&
 		git config commit.status no &&
 		try_commit --status &&
 		grep "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
=20
-	test_expect_success 'commit --no-status with commit.status =3D no' '
+	test_expect_success C_LOCALE_OUTPUT 'commit --no-status with commit.s=
tatus =3D no' '
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
