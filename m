From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 22/42] t1510: setup case #19
Date: Fri, 29 Oct 2010 13:48:34 +0700
Message-ID: <1288334934-17216-23-git-send-email-pclouds@gmail.com>
References: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 08:52:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBioz-0006pm-N5
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 08:52:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933232Ab0J2GwL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 02:52:11 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64522 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933180Ab0J2GwH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 02:52:07 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so692674pwj.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 23:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=0/OYlOtmEWBiZsdk0DkdriAjLCO2KnWlEfHUzf5lPrU=;
        b=CZMiPBBrYARLgMQyS+tMrnBUHNEiQOgfSe4pMGmzC9OnhQR6JAW8u1kBMuL+4Nbt/z
         mDoQdfVapc6P+ISHUpAQOF7cJBEKlAXYr01WRYckZ36j79BA52gzxVmn5jtm/VhZje8l
         b0nSPeD9ber+6HeCGsnzUJpf5D3hxzFLJjiSg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=nFmcciEbRyVxaPzPBpE7dW3RK8pzFpFCPEVSIiveJ+GVbKkPTyiBzws2wmSrIbK1G9
         RYlQoyDLxCJpzqiY4Sjswmxl6nd+ZD2pkP2sKlEzPpMVvzjYS2zb6zkXSYDqENFuAJim
         0SVuxNwrLm3QQZoTg6235vA2l839cOat57Uck=
Received: by 10.142.164.18 with SMTP id m18mr1065778wfe.375.1288335127200;
        Thu, 28 Oct 2010 23:52:07 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id q13sm1026445wfc.17.2010.10.28.23.52.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 23:52:06 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 29 Oct 2010 13:52:06 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160290>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |  266 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 266 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 13034e5..8538098 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -2552,4 +2552,270 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/18/.git" test_repo 18/sub
 '
=20
+#
+# case #19
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is set
+#  - GIT_DIR is set
+#  - .git is a directory
+#  - core.worktree is not set
+#  - core.bare is set
+#
+# Output:
+#
+# bare repo is overridden by GIT_WORK_TREE -> #3
+
+test_expect_success '#19: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 19 19/sub 19/sub/sub 19.wt 19.wt/sub 19/wt 19/wt/sub &&
+	cd 19 &&
+	git init &&
+	git config core.bare true &&
+	cd ..
+'
+
+test_expect_success '#19: GIT_DIR(rel), GIT_WORK_TREE=3Droot at root' =
'
+	cat >19/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/19
+setup: cwd: $TRASH_DIRECTORY/19
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/19" test_repo 19
+'
+
+test_expect_success '#19: GIT_DIR(rel), GIT_WORK_TREE=3Droot(rel) at r=
oot' '
+	cat >19/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/19
+setup: cwd: $TRASH_DIRECTORY/19
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D. test_repo 19
+'
+
+test_expect_success '#19: GIT_DIR, GIT_WORK_TREE=3Droot at root' '
+	cat >19/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/19/.git
+setup: worktree: $TRASH_DIRECTORY/19
+setup: cwd: $TRASH_DIRECTORY/19
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/19/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/19" test_repo 19
+'
+
+test_expect_success '#19: GIT_DIR, GIT_WORK_TREE=3Droot(rel) at root' =
'
+	cat >19/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/19/.git
+setup: worktree: $TRASH_DIRECTORY/19
+setup: cwd: $TRASH_DIRECTORY/19
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/19/.git" GIT_WORK_TREE=3D. test_repo 19
+'
+
+test_expect_success '#19: GIT_DIR(rel), GIT_WORKTREE=3Droot in subdir'=
 '
+	cat >19/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/19/.git
+setup: worktree: $TRASH_DIRECTORY/19
+setup: cwd: $TRASH_DIRECTORY/19
+setup: prefix: sub/sub/
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/19" test_repo =
19/sub/sub
+'
+
+test_expect_success '#19: GIT_DIR(rel), GIT_WORKTREE=3Droot(rel) in su=
bdir' '
+	cat >19/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/19/.git
+setup: worktree: $TRASH_DIRECTORY/19
+setup: cwd: $TRASH_DIRECTORY/19
+setup: prefix: sub/sub/
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../.. test_repo 19/sub/sub
+'
+
+test_expect_success '#19: GIT_DIR, GIT_WORKTREE=3Droot in subdir' '
+	cat >19/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/19/.git
+setup: worktree: $TRASH_DIRECTORY/19
+setup: cwd: $TRASH_DIRECTORY/19
+setup: prefix: sub/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/19/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/19" test_repo 19/sub
+'
+
+test_expect_success '#19: GIT_DIR, GIT_WORKTREE=3Droot(rel) in subdir'=
 '
+	cat >19/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/19/.git
+setup: worktree: $TRASH_DIRECTORY/19
+setup: cwd: $TRASH_DIRECTORY/19
+setup: prefix: sub/sub/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/19/.git" GIT_WORK_TREE=3D../.. test_repo =
19/sub/sub
+'
+
+test_expect_success '#19: GIT_DIR(rel), GIT_WORK_TREE=3Dwt at root' '
+	cat >19/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/19/wt
+setup: cwd: $TRASH_DIRECTORY/19
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/19/wt" test_repo 19
+'
+
+test_expect_success '#19: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) at roo=
t' '
+	cat >19/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/19/wt
+setup: cwd: $TRASH_DIRECTORY/19
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3Dwt test_repo 19
+'
+
+test_expect_success '#19: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) at root' '
+	cat >19/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/19/.git
+setup: worktree: $TRASH_DIRECTORY/19/wt
+setup: cwd: $TRASH_DIRECTORY/19
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/19/.git" GIT_WORK_TREE=3Dwt test_repo 19
+'
+
+test_expect_success '#19: GIT_DIR, GIT_WORK_TREE=3Dwt at root' '
+	cat >19/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/19/.git
+setup: worktree: $TRASH_DIRECTORY/19/wt
+setup: cwd: $TRASH_DIRECTORY/19
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/19/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/19/wt" test_repo 19
+'
+
+test_expect_success '#19: GIT_DIR(rel), GIT_WORK_TREE=3Dwt in subdir' =
'
+	cat >19/sub/sub/expected <<EOF &&
+setup: git_dir: ../../.git
+setup: worktree: $TRASH_DIRECTORY/19/wt
+setup: cwd: $TRASH_DIRECTORY/19/sub/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/19/wt" test_re=
po 19/sub/sub
+'
+
+test_expect_success '#19: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) in sub=
dir' '
+	cat >19/sub/sub/expected <<EOF &&
+setup: git_dir: ../../.git
+setup: worktree: $TRASH_DIRECTORY/19/wt
+setup: cwd: $TRASH_DIRECTORY/19/sub/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../../wt test_repo 19/sub/sub
+'
+
+test_expect_success '#19: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) in subdir' =
'
+	cat >19/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/19/.git
+setup: worktree: $TRASH_DIRECTORY/19/wt
+setup: cwd: $TRASH_DIRECTORY/19/sub/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/19/.git" GIT_WORK_TREE=3D../../wt test_re=
po 19/sub/sub
+'
+
+test_expect_success '#19: GIT_DIR, GIT_WORK_TREE=3Dwt in subdir' '
+	cat >19/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/19/.git
+setup: worktree: $TRASH_DIRECTORY/19/wt
+setup: cwd: $TRASH_DIRECTORY/19/sub/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/19/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/19/wt" test_repo 19/sub/sub
+'
+
+test_expect_success '#19: GIT_DIR(rel), GIT_WORK_TREE=3D.. at root' '
+	cat >19/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/19/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 19/
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY" test_repo 19
+'
+
+test_expect_success '#19: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) at roo=
t' '
+	cat >19/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/19/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 19/
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D.. test_repo 19
+'
+
+test_expect_success '#19: GIT_DIR, GIT_WORK_TREE=3D..(rel) at root' '
+	cat >19/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/19/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 19/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/19/.git" GIT_WORK_TREE=3D.. test_repo 19
+'
+
+test_expect_success '#19: GIT_DIR, GIT_WORK_TREE=3D.. at root' '
+	cat >19/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/19/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 19/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/19/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y" test_repo 19
+'
+
+test_expect_success '#19: GIT_DIR(rel), GIT_WORK_TREE=3D.. in subdir' =
'
+	cat >19/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/19/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 19/sub/sub/
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY" test_repo 19/=
sub/sub
+'
+
+test_expect_success '#19: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) in sub=
dir' '
+	cat >19/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/19/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 19/sub/sub/
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../../.. test_repo 19/sub/sub
+'
+
+test_expect_success '#19: GIT_DIR, GIT_WORK_TREE=3D..(rel) in subdir' =
'
+	cat >19/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/19/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 19/sub/sub/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/19/.git" GIT_WORK_TREE=3D../../../ test_r=
epo 19/sub/sub
+'
+
+test_expect_success '#19: GIT_DIR, GIT_WORK_TREE=3D.. in subdir' '
+	cat >19/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/19/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 19/sub/sub/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/19/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y" test_repo 19/sub/sub
+'
+
 test_done
--=20
1.7.0.2.445.gcbdb3
