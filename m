From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 34/47] t1510: setup case #31
Date: Fri, 26 Nov 2010 22:32:30 +0700
Message-ID: <1290785563-15339-35-git-send-email-pclouds@gmail.com>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 17:03:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM0ln-0002sM-S0
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 17:03:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753501Ab0KZQDS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 11:03:18 -0500
Received: from mail-pw0-f66.google.com ([209.85.160.66]:42049 "EHLO
	mail-pw0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473Ab0KZQDR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 11:03:17 -0500
Received: by pwj5 with SMTP id 5so472007pwj.1
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 08:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=A2GuCafdCT0lSS8hdIodtx4zzRqt6EfPtesoRLwnc4c=;
        b=CQJaRZIj9T5cjcHbxfgnC0ka6vGuGw+ycntGLYgmVtaJF/zKR0iYXWYFo6R9CDiREJ
         YCimd2GbUbWOgN3U+mg7XZaA+w917lGRfuuRpUoNKLy9WVucn4wqRHoHiUNqMlXGNkmB
         YmV0RVCdRLUwpFIzqih9za/2OXa0pPdLOTUwM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=vl+EimYT5MfBn6msH9VJaCcH/MrLEgN74S1MU4T2wqFzNyJb9MMKYu8t6VLUxxCvED
         CKLBJmmOobL1JYq5AskuPyD2gfaSVpaN68Up2i6RNxgqRY3MibOnOHC2mZfXtA6+jIIL
         rAPdUEm8cNYqDQjEKQFZhpUJTcBk5HOhM7zdo=
Received: by 10.142.134.13 with SMTP id h13mr2547693wfd.137.1290786417747;
        Fri, 26 Nov 2010 07:46:57 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.252.168])
        by mx.google.com with ESMTPS id b11sm2683760wff.21.2010.11.26.07.46.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 07:46:56 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 26 Nov 2010 22:45:42 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
In-Reply-To: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162260>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |  269 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 269 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 96f7485..d8c181d 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -4260,4 +4260,273 @@ test_expect_failure '#30: at root' '
 	)
 '
=20
+#
+# case #31
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is set
+#  - GIT_DIR is set
+#  - core.worktree is set
+#  - .git is a file
+#  - core.bare is set
+#
+# Output:
+#
+# #23 except git_dir is set according to .git file
+
+test_expect_success '#31: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 31 31/sub 31/sub/sub 31.wt 31.wt/sub 31/wt 31/wt/sub &&
+	cd 31 &&
+	git init &&
+	git config core.bare true &&
+	git config core.worktree non-existent &&
+	mv .git ../31.git &&
+	echo gitdir: ../31.git >.git &&
+	cd ..
+'
+
+test_expect_failure '#31: GIT_DIR(rel), GIT_WORK_TREE=3Droot at root' =
'
+	cat >31/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY/31
+setup: cwd: $TRASH_DIRECTORY/31
+setup: prefix: (null)
+EOF
+	test_repo 31 .git "$TRASH_DIRECTORY/31"
+'
+
+test_expect_failure '#31: GIT_DIR(rel), GIT_WORK_TREE=3Droot(rel) at r=
oot' '
+	cat >31/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY/31
+setup: cwd: $TRASH_DIRECTORY/31
+setup: prefix: (null)
+EOF
+	test_repo 31 .git .
+'
+
+test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3Droot at root' '
+	cat >31/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY/31
+setup: cwd: $TRASH_DIRECTORY/31
+setup: prefix: (null)
+EOF
+	test_repo 31 "$TRASH_DIRECTORY/31/.git" "$TRASH_DIRECTORY/31"
+'
+
+test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3Droot(rel) at root' =
'
+	cat >31/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY/31
+setup: cwd: $TRASH_DIRECTORY/31
+setup: prefix: (null)
+EOF
+	test_repo 31 "$TRASH_DIRECTORY/31/.git" .
+'
+
+test_expect_failure '#31: GIT_DIR(rel), GIT_WORKTREE=3Droot in subdir'=
 '
+	cat >31/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY/31
+setup: cwd: $TRASH_DIRECTORY/31
+setup: prefix: sub/sub/
+EOF
+	test_repo 31/sub/sub ../../.git "$TRASH_DIRECTORY/31"
+'
+
+test_expect_failure '#31: GIT_DIR(rel), GIT_WORKTREE=3Droot(rel) in su=
bdir' '
+	cat >31/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY/31
+setup: cwd: $TRASH_DIRECTORY/31
+setup: prefix: sub/sub/
+EOF
+	test_repo 31/sub/sub ../../.git ../..
+'
+
+test_expect_failure '#31: GIT_DIR, GIT_WORKTREE=3Droot in subdir' '
+	cat >31/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY/31
+setup: cwd: $TRASH_DIRECTORY/31
+setup: prefix: sub/
+EOF
+	test_repo 31/sub "$TRASH_DIRECTORY/31/.git" "$TRASH_DIRECTORY/31"
+'
+
+test_expect_failure '#31: GIT_DIR, GIT_WORKTREE=3Droot(rel) in subdir'=
 '
+	cat >31/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY/31
+setup: cwd: $TRASH_DIRECTORY/31
+setup: prefix: sub/sub/
+EOF
+	test_repo 31/sub/sub "$TRASH_DIRECTORY/31/.git" ../..
+'
+
+test_expect_failure '#31: GIT_DIR(rel), GIT_WORK_TREE=3Dwt at root' '
+	cat >31/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY/31/wt
+setup: cwd: $TRASH_DIRECTORY/31
+setup: prefix: (null)
+EOF
+	test_repo 31 .git "$TRASH_DIRECTORY/31/wt"
+'
+
+test_expect_failure '#31: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) at roo=
t' '
+	cat >31/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY/31/wt
+setup: cwd: $TRASH_DIRECTORY/31
+setup: prefix: (null)
+EOF
+	test_repo 31 .git wt
+'
+
+test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) at root' '
+	cat >31/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY/31/wt
+setup: cwd: $TRASH_DIRECTORY/31
+setup: prefix: (null)
+EOF
+	test_repo 31 "$TRASH_DIRECTORY/31/.git" wt
+'
+
+test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3Dwt at root' '
+	cat >31/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY/31/wt
+setup: cwd: $TRASH_DIRECTORY/31
+setup: prefix: (null)
+EOF
+	test_repo 31 "$TRASH_DIRECTORY/31/.git" "$TRASH_DIRECTORY/31/wt"
+'
+
+test_expect_failure '#31: GIT_DIR(rel), GIT_WORK_TREE=3Dwt in subdir' =
'
+	cat >31/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY/31/wt
+setup: cwd: $TRASH_DIRECTORY/31/sub/sub
+setup: prefix: (null)
+EOF
+	test_repo 31/sub/sub ../../.git "$TRASH_DIRECTORY/31/wt"
+'
+
+test_expect_failure '#31: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) in sub=
dir' '
+	cat >31/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY/31/wt
+setup: cwd: $TRASH_DIRECTORY/31/sub/sub
+setup: prefix: (null)
+EOF
+	test_repo 31/sub/sub ../../.git ../../wt
+'
+
+test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) in subdir' =
'
+	cat >31/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY/31/wt
+setup: cwd: $TRASH_DIRECTORY/31/sub/sub
+setup: prefix: (null)
+EOF
+	test_repo 31/sub/sub "$TRASH_DIRECTORY/31/.git" ../../wt
+'
+
+test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3Dwt in subdir' '
+	cat >31/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY/31/wt
+setup: cwd: $TRASH_DIRECTORY/31/sub/sub
+setup: prefix: (null)
+EOF
+	test_repo 31/sub/sub "$TRASH_DIRECTORY/31/.git" "$TRASH_DIRECTORY/31/=
wt"
+'
+
+test_expect_failure '#31: GIT_DIR(rel), GIT_WORK_TREE=3D.. at root' '
+	cat >31/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 31/
+EOF
+	test_repo 31 .git "$TRASH_DIRECTORY"
+'
+
+test_expect_failure '#31: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) at roo=
t' '
+	cat >31/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 31/
+EOF
+	test_repo 31 .git ..
+'
+
+test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3D..(rel) at root' '
+	cat >31/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 31/
+EOF
+	test_repo 31 "$TRASH_DIRECTORY/31/.git" ..
+'
+
+test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3D.. at root' '
+	cat >31/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 31/
+EOF
+	test_repo 31 "$TRASH_DIRECTORY/31/.git" "$TRASH_DIRECTORY"
+'
+
+test_expect_failure '#31: GIT_DIR(rel), GIT_WORK_TREE=3D.. in subdir' =
'
+	cat >31/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 31/sub/sub/
+EOF
+	test_repo 31/sub/sub ../../.git "$TRASH_DIRECTORY"
+'
+
+test_expect_failure '#31: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) in sub=
dir' '
+	cat >31/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 31/sub/sub/
+EOF
+	test_repo 31/sub/sub ../../.git ../../..
+'
+
+test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3D..(rel) in subdir' =
'
+	cat >31/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 31/sub/sub/
+EOF
+	test_repo 31/sub/sub "$TRASH_DIRECTORY/31/.git" ../../../
+'
+
+test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3D.. in subdir' '
+	cat >31/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 31/sub/sub/
+EOF
+	test_repo 31/sub/sub "$TRASH_DIRECTORY/31/.git" "$TRASH_DIRECTORY"
+'
+
 test_done
--=20
1.7.3.2.316.gda8b3
