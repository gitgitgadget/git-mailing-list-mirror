From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 14/42] t1510: setup case #11
Date: Fri, 29 Oct 2010 13:48:26 +0700
Message-ID: <1288334934-17216-15-git-send-email-pclouds@gmail.com>
References: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 08:51:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBio5-0006Px-S3
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 08:51:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514Ab0J2GvM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 02:51:12 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64522 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932320Ab0J2GvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 02:51:09 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so692674pwj.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 23:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=26z9RciAENLZ5z+U8k3FjgmXVkq/kW527BslB0/JksY=;
        b=luXKqBRQscmZXNsAtOkYUAskSJfvl0opn6Cs8UCdJqhLfvOnYSTTnmK0NYEBBMaikr
         j16kO7gbLggrLsDbHBbWRXqjFFMmgQArme4X53hygH4Kb0rSPAb7ABdEXEhyHMPsyXK6
         TSQWPPcljt7fzc5rZT11G6G1u48oegPsFt2+8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=lD2o8b/A3TOmWysZkxRFgmZcXScGQtKxc7eDNrIAkcpHHAyN+0YGyUW0zQAvgfXfdu
         ycf9TX8HwlUYNPb9Ckb2hDvKqAA0WPxZVjiJFsIFTDwe1BqM5VhqyJNqsBpehXqVE7wW
         3Z2tnZRUZNXbEz5gGYc4UXqDlvnE71m3NlbiY=
Received: by 10.142.253.21 with SMTP id a21mr1121758wfi.219.1288335069236;
        Thu, 28 Oct 2010 23:51:09 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id v19sm1036220wfh.0.2010.10.28.23.51.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 23:51:08 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 29 Oct 2010 13:51:08 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160283>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |  267 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 267 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index a680f4e..09efd9b 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -1294,4 +1294,271 @@ EOF
 	GIT_DIR=3D../.git test_repo 10/sub
 '
=20
+#
+# case #11
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is set
+#  - GIT_DIR is set
+#  - core.worktree is not set
+#  - .git is a file
+#  - core.bare is not set, cwd is outside .git
+#
+# Output:
+#
+# #3 except that git_dir is set by .git file
+
+test_expect_success '#11: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 11 11/sub 11/sub/sub 11.wt 11.wt/sub 11/wt 11/wt/sub &&
+	cd 11 &&
+	git init &&
+	mv .git ../11.git &&
+	echo gitdir: ../11.git >.git &&
+	cd ..
+'
+
+test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3Droot at root' =
'
+	cat >11/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY/11
+setup: cwd: $TRASH_DIRECTORY/11
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/11" test_repo 11
+'
+
+test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3Droot(rel) at r=
oot' '
+	cat >11/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY/11
+setup: cwd: $TRASH_DIRECTORY/11
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D. test_repo 11
+'
+
+test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3Droot at root' '
+	cat >11/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY/11
+setup: cwd: $TRASH_DIRECTORY/11
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/11" test_repo 11
+'
+
+test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3Droot(rel) at root' =
'
+	cat >11/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY/11
+setup: cwd: $TRASH_DIRECTORY/11
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE=3D. test_repo 11
+'
+
+test_expect_failure '#11: GIT_DIR(rel), GIT_WORKTREE=3Droot in subdir'=
 '
+	cat >11/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY/11
+setup: cwd: $TRASH_DIRECTORY/11
+setup: prefix: sub/sub/
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/11" test_repo =
11/sub/sub
+'
+
+test_expect_failure '#11: GIT_DIR(rel), GIT_WORKTREE=3Droot(rel) in su=
bdir' '
+	cat >11/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY/11
+setup: cwd: $TRASH_DIRECTORY/11
+setup: prefix: sub/sub/
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../.. test_repo 11/sub/sub
+'
+
+test_expect_failure '#11: GIT_DIR, GIT_WORKTREE=3Droot in subdir' '
+	cat >11/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY/11
+setup: cwd: $TRASH_DIRECTORY/11
+setup: prefix: sub/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/11" test_repo 11/sub
+'
+
+test_expect_failure '#11: GIT_DIR, GIT_WORKTREE=3Droot(rel) in subdir'=
 '
+	cat >11/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY/11
+setup: cwd: $TRASH_DIRECTORY/11
+setup: prefix: sub/sub/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE=3D../.. test_repo =
11/sub/sub
+'
+
+test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3Dwt at root' '
+	cat >11/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY/11/wt
+setup: cwd: $TRASH_DIRECTORY/11
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/11/wt" test_repo 11
+'
+
+test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) at roo=
t' '
+	cat >11/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY/11/wt
+setup: cwd: $TRASH_DIRECTORY/11
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3Dwt test_repo 11
+'
+
+test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) at root' '
+	cat >11/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY/11/wt
+setup: cwd: $TRASH_DIRECTORY/11
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE=3Dwt test_repo 11
+'
+
+test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3Dwt at root' '
+	cat >11/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY/11/wt
+setup: cwd: $TRASH_DIRECTORY/11
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/11/wt" test_repo 11
+'
+
+test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3Dwt in subdir' =
'
+	cat >11/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY/11/wt
+setup: cwd: $TRASH_DIRECTORY/11/sub/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/11/wt" test_re=
po 11/sub/sub
+'
+
+test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) in sub=
dir' '
+	cat >11/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY/11/wt
+setup: cwd: $TRASH_DIRECTORY/11/sub/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../../wt test_repo 11/sub/sub
+'
+
+test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) in subdir' =
'
+	cat >11/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY/11/wt
+setup: cwd: $TRASH_DIRECTORY/11/sub/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE=3D../../wt test_re=
po 11/sub/sub
+'
+
+test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3Dwt in subdir' '
+	cat >11/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY/11/wt
+setup: cwd: $TRASH_DIRECTORY/11/sub/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/11/wt" test_repo 11/sub/sub
+'
+
+test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3D.. at root' '
+	cat >11/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 11/
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY" test_repo 11
+'
+
+test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) at roo=
t' '
+	cat >11/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 11/
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D.. test_repo 11
+'
+
+test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3D..(rel) at root' '
+	cat >11/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 11/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE=3D.. test_repo 11
+'
+
+test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3D.. at root' '
+	cat >11/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 11/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y" test_repo 11
+'
+
+test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3D.. in subdir' =
'
+	cat >11/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 11/sub/sub/
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY" test_repo 11/=
sub/sub
+'
+
+test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) in sub=
dir' '
+	cat >11/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 11/sub/sub/
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../../.. test_repo 11/sub/sub
+'
+
+test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3D..(rel) in subdir' =
'
+	cat >11/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 11/sub/sub/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE=3D../../../ test_r=
epo 11/sub/sub
+'
+
+test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3D.. in subdir' '
+	cat >11/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/11.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 11/sub/sub/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y" test_repo 11/sub/sub
+'
+
 test_done
--=20
1.7.0.2.445.gcbdb3
