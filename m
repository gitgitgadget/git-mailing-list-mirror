From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 18/47] t1510: setup case #15
Date: Fri, 26 Nov 2010 22:32:14 +0700
Message-ID: <1290785563-15339-19-git-send-email-pclouds@gmail.com>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 16:40:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM0PY-00044F-Fs
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 16:40:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752160Ab0KZPk1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 10:40:27 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:58448 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883Ab0KZPk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 10:40:26 -0500
Received: by pzk6 with SMTP id 6so349380pzk.19
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 07:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=mZW+eOEmZ3JsBCNtpfF1mI4DutXHlHZDdingDxHYV8g=;
        b=H+YZM/QVDvVM24wcMLlSKhxmk24R1Fe8oYHOQDuiWrPS9bdOcVgy8IrGP3tvs0goik
         7DP6rnN5Xhr2wkFFR+DC/KDBNKAb0LOa4oYfOcFrcQdnLjFnU+IuRsOOWrZENwvvIpxL
         X/TfzNs/2+9zdjA+9vzCtZpI9JHdxxjPcw3vo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=GNWeEAzMtBVOm9mPezm7m4dLJ/lq+AY++GdrQ3KtZQ1X3WAllZP8IIkiZlsxVGQCv5
         QT5EkTvuDOxhqwbK+ZPsU2XmvpFIDMkkKuLoHkrsYYyE19yJSzC7OtLhD2MaYQVi6QTS
         OKusNku10BbWWP1o/LeaILlj3+THDfSH70QeU=
Received: by 10.142.114.11 with SMTP id m11mr2502604wfc.143.1290786026127;
        Fri, 26 Nov 2010 07:40:26 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.252.168])
        by mx.google.com with ESMTPS id q13sm2679720wfc.17.2010.11.26.07.40.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 07:40:25 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 26 Nov 2010 22:39:02 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
In-Reply-To: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162234>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |  268 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 268 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 617a14d..732053d 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -1957,4 +1957,272 @@ EOF
 	test_repo 14/sub/sub "$TRASH_DIRECTORY/14/.git"
 '
=20
+#
+# case #15
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is set
+#  - GIT_DIR is set
+#  - core.worktree is set
+#  - .git is a file
+#  - core.bare is not set, cwd is outside .git
+#
+# Output:
+#
+# #7 except that git_dir is set by .git file
+
+test_expect_success '#15: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 15 15/sub 15/sub/sub 15.wt 15.wt/sub 15/wt 15/wt/sub &&
+	cd 15 &&
+	git init &&
+	git config core.worktree non-existent &&
+	mv .git ../15.git &&
+	echo gitdir: ../15.git >.git &&
+	cd ..
+'
+
+test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=3Droot at root' =
'
+	cat >15/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/15.git
+setup: worktree: $TRASH_DIRECTORY/15
+setup: cwd: $TRASH_DIRECTORY/15
+setup: prefix: (null)
+EOF
+	test_repo 15 .git "$TRASH_DIRECTORY/15"
+'
+
+test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=3Droot(rel) at r=
oot' '
+	cat >15/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/15.git
+setup: worktree: $TRASH_DIRECTORY/15
+setup: cwd: $TRASH_DIRECTORY/15
+setup: prefix: (null)
+EOF
+	test_repo 15 .git .
+'
+
+test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=3Droot at root' '
+	cat >15/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/15.git
+setup: worktree: $TRASH_DIRECTORY/15
+setup: cwd: $TRASH_DIRECTORY/15
+setup: prefix: (null)
+EOF
+	test_repo 15 "$TRASH_DIRECTORY/15/.git" "$TRASH_DIRECTORY/15"
+'
+
+test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=3Droot(rel) at root' =
'
+	cat >15/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/15.git
+setup: worktree: $TRASH_DIRECTORY/15
+setup: cwd: $TRASH_DIRECTORY/15
+setup: prefix: (null)
+EOF
+	test_repo 15 "$TRASH_DIRECTORY/15/.git" .
+'
+
+test_expect_failure '#15: GIT_DIR(rel), GIT_WORKTREE=3Droot in subdir'=
 '
+	cat >15/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/15.git
+setup: worktree: $TRASH_DIRECTORY/15
+setup: cwd: $TRASH_DIRECTORY/15
+setup: prefix: sub/sub/
+EOF
+	test_repo 15/sub/sub ../../.git "$TRASH_DIRECTORY/15"
+'
+
+test_expect_failure '#15: GIT_DIR(rel), GIT_WORKTREE=3Droot(rel) in su=
bdir' '
+	cat >15/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/15.git
+setup: worktree: $TRASH_DIRECTORY/15
+setup: cwd: $TRASH_DIRECTORY/15
+setup: prefix: sub/sub/
+EOF
+	test_repo 15/sub/sub ../../.git ../..
+'
+
+test_expect_failure '#15: GIT_DIR, GIT_WORKTREE=3Droot in subdir' '
+	cat >15/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/15.git
+setup: worktree: $TRASH_DIRECTORY/15
+setup: cwd: $TRASH_DIRECTORY/15
+setup: prefix: sub/
+EOF
+	test_repo 15/sub "$TRASH_DIRECTORY/15/.git" "$TRASH_DIRECTORY/15"
+'
+
+test_expect_failure '#15: GIT_DIR, GIT_WORKTREE=3Droot(rel) in subdir'=
 '
+	cat >15/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/15.git
+setup: worktree: $TRASH_DIRECTORY/15
+setup: cwd: $TRASH_DIRECTORY/15
+setup: prefix: sub/sub/
+EOF
+	test_repo 15/sub/sub "$TRASH_DIRECTORY/15/.git" ../..
+'
+
+test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=3Dwt at root' '
+	cat >15/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/15.git
+setup: worktree: $TRASH_DIRECTORY/15/wt
+setup: cwd: $TRASH_DIRECTORY/15
+setup: prefix: (null)
+EOF
+	test_repo 15 .git "$TRASH_DIRECTORY/15/wt"
+'
+
+test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) at roo=
t' '
+	cat >15/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/15.git
+setup: worktree: $TRASH_DIRECTORY/15/wt
+setup: cwd: $TRASH_DIRECTORY/15
+setup: prefix: (null)
+EOF
+	test_repo 15 .git wt
+'
+
+test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) at root' '
+	cat >15/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/15.git
+setup: worktree: $TRASH_DIRECTORY/15/wt
+setup: cwd: $TRASH_DIRECTORY/15
+setup: prefix: (null)
+EOF
+	test_repo 15 "$TRASH_DIRECTORY/15/.git" wt
+'
+
+test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=3Dwt at root' '
+	cat >15/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/15.git
+setup: worktree: $TRASH_DIRECTORY/15/wt
+setup: cwd: $TRASH_DIRECTORY/15
+setup: prefix: (null)
+EOF
+	test_repo 15 "$TRASH_DIRECTORY/15/.git" "$TRASH_DIRECTORY/15/wt"
+'
+
+test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=3Dwt in subdir' =
'
+	cat >15/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/15.git
+setup: worktree: $TRASH_DIRECTORY/15/wt
+setup: cwd: $TRASH_DIRECTORY/15/sub/sub
+setup: prefix: (null)
+EOF
+	test_repo 15/sub/sub ../../.git "$TRASH_DIRECTORY/15/wt"
+'
+
+test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) in sub=
dir' '
+	cat >15/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/15.git
+setup: worktree: $TRASH_DIRECTORY/15/wt
+setup: cwd: $TRASH_DIRECTORY/15/sub/sub
+setup: prefix: (null)
+EOF
+	test_repo 15/sub/sub ../../.git ../../wt
+'
+
+test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) in subdir' =
'
+	cat >15/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/15.git
+setup: worktree: $TRASH_DIRECTORY/15/wt
+setup: cwd: $TRASH_DIRECTORY/15/sub/sub
+setup: prefix: (null)
+EOF
+	test_repo 15/sub/sub "$TRASH_DIRECTORY/15/.git" ../../wt
+'
+
+test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=3Dwt in subdir' '
+	cat >15/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/15.git
+setup: worktree: $TRASH_DIRECTORY/15/wt
+setup: cwd: $TRASH_DIRECTORY/15/sub/sub
+setup: prefix: (null)
+EOF
+	test_repo 15/sub/sub "$TRASH_DIRECTORY/15/.git" "$TRASH_DIRECTORY/15/=
wt"
+'
+
+test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=3D.. at root' '
+	cat >15/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/15.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 15/
+EOF
+	test_repo 15 .git "$TRASH_DIRECTORY"
+'
+
+test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) at roo=
t' '
+	cat >15/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/15.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 15/
+EOF
+	test_repo 15 .git ..
+'
+
+test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=3D..(rel) at root' '
+	cat >15/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/15.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 15/
+EOF
+	test_repo 15 "$TRASH_DIRECTORY/15/.git" ..
+'
+
+test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=3D.. at root' '
+	cat >15/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/15.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 15/
+EOF
+	test_repo 15 "$TRASH_DIRECTORY/15/.git" "$TRASH_DIRECTORY"
+'
+
+test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=3D.. in subdir' =
'
+	cat >15/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/15.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 15/sub/sub/
+EOF
+	test_repo 15/sub/sub ../../.git "$TRASH_DIRECTORY"
+'
+
+test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) in sub=
dir' '
+	cat >15/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/15.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 15/sub/sub/
+EOF
+	test_repo 15/sub/sub ../../.git ../../..
+'
+
+test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=3D..(rel) in subdir' =
'
+	cat >15/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/15.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 15/sub/sub/
+EOF
+	test_repo 15/sub/sub "$TRASH_DIRECTORY/15/.git" ../../../
+'
+
+test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=3D.. in subdir' '
+	cat >15/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/15.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 15/sub/sub/
+EOF
+	test_repo 15/sub/sub "$TRASH_DIRECTORY/15/.git" "$TRASH_DIRECTORY"
+'
+
 test_done
--=20
1.7.3.2.316.gda8b3
