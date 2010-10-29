From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 10/42] t1510: setup case #7
Date: Fri, 29 Oct 2010 13:48:22 +0700
Message-ID: <1288334934-17216-11-git-send-email-pclouds@gmail.com>
References: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 08:50:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBinZ-0006Do-2Y
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 08:50:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756027Ab0J2Gum convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 02:50:42 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64522 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754423Ab0J2Guk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 02:50:40 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so692674pwj.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 23:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=n0THHkCXk0D0he5BPEV7rjyGFUdSJ9Ay91ECGm4sNA4=;
        b=bjDhqe21pXZQvxHc4xZDRs6CpFuxS4upb3oDuWcpdhJIRfJfETWKEav9ProN2aet9Q
         aq/VLRmeqINh/SZ6VZHqTppDQQRHCzVKWsHbDHyyPSonqELLjVuP3ZQGbXGDy/0ntdJa
         6oQtor7c+uMwzHxCG6NDR/z5lRIomGb7GXFHc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=pZ83Da8h43ujgmTJNSfFxSdWDJg/xpua0CRkcqmRYfbCVqsns+8YD7zz8AyipgBCUS
         40H9NX0uJKRORSeCnaYP28j1ibnPrkdQmnyBoOwEMH9rC+/eJIpcbMxK1oc1lhlzCfzD
         RcwB8Pslrfy/yXb4u3T1zJJHzFEyGTfl0O2q0=
Received: by 10.142.188.10 with SMTP id l10mr496463wff.445.1288335040476;
        Thu, 28 Oct 2010 23:50:40 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id w26sm1016321wfd.21.2010.10.28.23.50.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 23:50:39 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 29 Oct 2010 13:50:39 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160278>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |  266 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 266 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 5957c45..faefd10 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -867,4 +867,270 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/6/.git" test_repo 6/sub/sub
 '
=20
+#
+# case #7
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is set
+#  - GIT_DIR is set
+#  - core.worktree is set
+#  - .git is a directory
+#  - core.bare is not set, cwd is outside .git
+#
+# Output:
+#
+# core.worktree is overridden by GIT_WORK_TREE -> #3
+
+test_expect_success '#7: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 7 7/sub 7/sub/sub 7.wt 7.wt/sub 7/wt 7/wt/sub &&
+	cd 7 &&
+	git init &&
+	git config core.worktree non-existent &&
+	cd ..
+'
+
+test_expect_success '#7: GIT_DIR(rel), GIT_WORK_TREE=3Droot at root' '
+	cat >7/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/7
+setup: cwd: $TRASH_DIRECTORY/7
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/7" test_repo 7
+'
+
+test_expect_success '#7: GIT_DIR(rel), GIT_WORK_TREE=3Droot(rel) at ro=
ot' '
+	cat >7/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/7
+setup: cwd: $TRASH_DIRECTORY/7
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D. test_repo 7
+'
+
+test_expect_success '#7: GIT_DIR, GIT_WORK_TREE=3Droot at root' '
+	cat >7/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/7/.git
+setup: worktree: $TRASH_DIRECTORY/7
+setup: cwd: $TRASH_DIRECTORY/7
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/7/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTORY=
/7" test_repo 7
+'
+
+test_expect_success '#7: GIT_DIR, GIT_WORK_TREE=3Droot(rel) at root' '
+	cat >7/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/7/.git
+setup: worktree: $TRASH_DIRECTORY/7
+setup: cwd: $TRASH_DIRECTORY/7
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/7/.git" GIT_WORK_TREE=3D. test_repo 7
+'
+
+test_expect_success '#7: GIT_DIR(rel), GIT_WORKTREE=3Droot in subdir' =
'
+	cat >7/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/7/.git
+setup: worktree: $TRASH_DIRECTORY/7
+setup: cwd: $TRASH_DIRECTORY/7
+setup: prefix: sub/sub/
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/7" test_repo 7=
/sub/sub
+'
+
+test_expect_success '#7: GIT_DIR(rel), GIT_WORKTREE=3Droot(rel) in sub=
dir' '
+	cat >7/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/7/.git
+setup: worktree: $TRASH_DIRECTORY/7
+setup: cwd: $TRASH_DIRECTORY/7
+setup: prefix: sub/sub/
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../.. test_repo 7/sub/sub
+'
+
+test_expect_success '#7: GIT_DIR, GIT_WORKTREE=3Droot in subdir' '
+	cat >7/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/7/.git
+setup: worktree: $TRASH_DIRECTORY/7
+setup: cwd: $TRASH_DIRECTORY/7
+setup: prefix: sub/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/7/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTORY=
/7" test_repo 7/sub
+'
+
+test_expect_success '#7: GIT_DIR, GIT_WORKTREE=3Droot(rel) in subdir' =
'
+	cat >7/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/7/.git
+setup: worktree: $TRASH_DIRECTORY/7
+setup: cwd: $TRASH_DIRECTORY/7
+setup: prefix: sub/sub/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/7/.git" GIT_WORK_TREE=3D../.. test_repo 7=
/sub/sub
+'
+
+test_expect_success '#7: GIT_DIR(rel), GIT_WORK_TREE=3Dwt at root' '
+	cat >7/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/7/wt
+setup: cwd: $TRASH_DIRECTORY/7
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/7/wt" test_repo 7
+'
+
+test_expect_success '#7: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) at root=
' '
+	cat >7/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/7/wt
+setup: cwd: $TRASH_DIRECTORY/7
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3Dwt test_repo 7
+'
+
+test_expect_success '#7: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) at root' '
+	cat >7/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/7/.git
+setup: worktree: $TRASH_DIRECTORY/7/wt
+setup: cwd: $TRASH_DIRECTORY/7
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/7/.git" GIT_WORK_TREE=3Dwt test_repo 7
+'
+
+test_expect_success '#7: GIT_DIR, GIT_WORK_TREE=3Dwt at root' '
+	cat >7/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/7/.git
+setup: worktree: $TRASH_DIRECTORY/7/wt
+setup: cwd: $TRASH_DIRECTORY/7
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/7/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTORY=
/7/wt" test_repo 7
+'
+
+test_expect_success '#7: GIT_DIR(rel), GIT_WORK_TREE=3Dwt in subdir' '
+	cat >7/sub/sub/expected <<EOF &&
+setup: git_dir: ../../.git
+setup: worktree: $TRASH_DIRECTORY/7/wt
+setup: cwd: $TRASH_DIRECTORY/7/sub/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/7/wt" test_rep=
o 7/sub/sub
+'
+
+test_expect_success '#7: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) in subd=
ir' '
+	cat >7/sub/sub/expected <<EOF &&
+setup: git_dir: ../../.git
+setup: worktree: $TRASH_DIRECTORY/7/wt
+setup: cwd: $TRASH_DIRECTORY/7/sub/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../../wt test_repo 7/sub/sub
+'
+
+test_expect_success '#7: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) in subdir' '
+	cat >7/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/7/.git
+setup: worktree: $TRASH_DIRECTORY/7/wt
+setup: cwd: $TRASH_DIRECTORY/7/sub/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/7/.git" GIT_WORK_TREE=3D../../wt test_rep=
o 7/sub/sub
+'
+
+test_expect_success '#7: GIT_DIR, GIT_WORK_TREE=3Dwt in subdir' '
+	cat >7/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/7/.git
+setup: worktree: $TRASH_DIRECTORY/7/wt
+setup: cwd: $TRASH_DIRECTORY/7/sub/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/7/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTORY=
/7/wt" test_repo 7/sub/sub
+'
+
+test_expect_success '#7: GIT_DIR(rel), GIT_WORK_TREE=3D.. at root' '
+	cat >7/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/7/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 7/
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY" test_repo 7
+'
+
+test_expect_success '#7: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) at root=
' '
+	cat >7/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/7/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 7/
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D.. test_repo 7
+'
+
+test_expect_success '#7: GIT_DIR, GIT_WORK_TREE=3D..(rel) at root' '
+	cat >7/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/7/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 7/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/7/.git" GIT_WORK_TREE=3D.. test_repo 7
+'
+
+test_expect_success '#7: GIT_DIR, GIT_WORK_TREE=3D.. at root' '
+	cat >7/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/7/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 7/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/7/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTORY=
" test_repo 7
+'
+
+test_expect_success '#7: GIT_DIR(rel), GIT_WORK_TREE=3D.. in subdir' '
+	cat >7/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/7/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 7/sub/sub/
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY" test_repo 7/s=
ub/sub
+'
+
+test_expect_success '#7: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) in subd=
ir' '
+	cat >7/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/7/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 7/sub/sub/
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../../.. test_repo 7/sub/sub
+'
+
+test_expect_success '#7: GIT_DIR, GIT_WORK_TREE=3D..(rel) in subdir' '
+	cat >7/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/7/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 7/sub/sub/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/7/.git" GIT_WORK_TREE=3D../../../ test_re=
po 7/sub/sub
+'
+
+test_expect_success '#7: GIT_DIR, GIT_WORK_TREE=3D.. in subdir' '
+	cat >7/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/7/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 7/sub/sub/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/7/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTORY=
" test_repo 7/sub/sub
+'
+
 test_done
--=20
1.7.0.2.445.gcbdb3
