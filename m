From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 30/34] t1510: setup case #27
Date: Wed, 27 Oct 2010 21:49:33 +0700
Message-ID: <1288190977-30875-31-git-send-email-pclouds@gmail.com>
References: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 27 16:54:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB7OA-0000NW-LM
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 16:54:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933608Ab0J0Oxa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 10:53:30 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37043 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933578Ab0J0Ox2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 10:53:28 -0400
Received: by mail-yw0-f46.google.com with SMTP id 9so445305ywk.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 07:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=/DL44ufg/IURbUGpfivdkupsjcKu8dc5VcNzD1h2Xs0=;
        b=ZOSHgaf6LH4H53Znz6Qx2TOwlPusufmPJVqYn4W8MDQNUQVTozfXhmbuLFBQHWYOlT
         71CSLrZQb6ZlGSePCBCBiWpW38US7GUzrH6J1OhjcgID+YhV8BnC47NcTjJp46NpNQG3
         GcozS8g53LuZBhs/WA5lA52YTdoUqkxBpaAaA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=g7WQhOmQs1Xwpe5rS1xZ1j5QLeZ5nq5Ud5vTAHaMomist8xwDq7F1MSCsbrzz+Kuq5
         aexUfLdJL7BAGJoqi2DzLD5L2G2PfZBU10v3PxRfw+tYne6XhrhLLpDL5RkR+fgB+ATz
         lTFcRRbaO1scicw3D39v1suIGxF+av3ILUGvU=
Received: by 10.91.62.15 with SMTP id p15mr1062549agk.181.1288191208474;
        Wed, 27 Oct 2010 07:53:28 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id b25sm11924973anb.3.2010.10.27.07.53.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 07:53:27 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 27 Oct 2010 21:53:25 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160074>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |  268 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 268 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index b1efec5..b0ba763 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -3840,4 +3840,272 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/26/.git" test_repo 26/sub
 '
=20
+#
+# case #27
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is set
+#  - GIT_DIR is set
+#  - .git is a file
+#  - core.worktree is not set
+#  - core.bare is set
+#
+# Output:
+#
+# #19 except git_dir is set according to .git file
+
+test_expect_success '#27: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 27 27/sub 27/sub/sub 27.wt 27.wt/sub 27/wt 27/wt/sub &&
+	cd 27 &&
+	git init &&
+	git config core.bare true &&
+	mv .git ../27.git &&
+	echo gitdir: ../27.git >.git &&
+	cd ..
+'
+
+test_expect_failure '#27: GIT_DIR(rel), GIT_WORK_TREE=3Droot at root' =
'
+	cat >27/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/27.git
+setup: worktree: $TRASH_DIRECTORY/27
+setup: cwd: $TRASH_DIRECTORY/27
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/27" test_repo 27
+'
+
+test_expect_failure '#27: GIT_DIR(rel), GIT_WORK_TREE=3Droot(rel) at r=
oot' '
+	cat >27/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/27.git
+setup: worktree: $TRASH_DIRECTORY/27
+setup: cwd: $TRASH_DIRECTORY/27
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D. test_repo 27
+'
+
+test_expect_failure '#27: GIT_DIR, GIT_WORK_TREE=3Droot at root' '
+	cat >27/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/27.git
+setup: worktree: $TRASH_DIRECTORY/27
+setup: cwd: $TRASH_DIRECTORY/27
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/27/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/27" test_repo 27
+'
+
+test_expect_failure '#27: GIT_DIR, GIT_WORK_TREE=3Droot(rel) at root' =
'
+	cat >27/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/27.git
+setup: worktree: $TRASH_DIRECTORY/27
+setup: cwd: $TRASH_DIRECTORY/27
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/27/.git" GIT_WORK_TREE=3D. test_repo 27
+'
+
+test_expect_failure '#27: GIT_DIR(rel), GIT_WORKTREE=3Droot in subdir'=
 '
+	cat >27/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/27.git
+setup: worktree: $TRASH_DIRECTORY/27
+setup: cwd: $TRASH_DIRECTORY/27
+setup: prefix: sub/sub/
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/27" test_repo =
27/sub/sub
+'
+
+test_expect_failure '#27: GIT_DIR(rel), GIT_WORKTREE=3Droot(rel) in su=
bdir' '
+	cat >27/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/27.git
+setup: worktree: $TRASH_DIRECTORY/27
+setup: cwd: $TRASH_DIRECTORY/27
+setup: prefix: sub/sub/
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../.. test_repo 27/sub/sub
+'
+
+test_expect_failure '#27: GIT_DIR, GIT_WORKTREE=3Droot in subdir' '
+	cat >27/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/27.git
+setup: worktree: $TRASH_DIRECTORY/27
+setup: cwd: $TRASH_DIRECTORY/27
+setup: prefix: sub/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/27/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/27" test_repo 27/sub
+'
+
+test_expect_failure '#27: GIT_DIR, GIT_WORKTREE=3Droot(rel) in subdir'=
 '
+	cat >27/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/27.git
+setup: worktree: $TRASH_DIRECTORY/27
+setup: cwd: $TRASH_DIRECTORY/27
+setup: prefix: sub/sub/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/27/.git" GIT_WORK_TREE=3D../.. test_repo =
27/sub/sub
+'
+
+test_expect_failure '#27: GIT_DIR(rel), GIT_WORK_TREE=3Dwt at root' '
+	cat >27/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/27.git
+setup: worktree: $TRASH_DIRECTORY/27/wt
+setup: cwd: $TRASH_DIRECTORY/27
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/27/wt" test_repo 27
+'
+
+test_expect_failure '#27: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) at roo=
t' '
+	cat >27/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/27.git
+setup: worktree: $TRASH_DIRECTORY/27/wt
+setup: cwd: $TRASH_DIRECTORY/27
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3Dwt test_repo 27
+'
+
+test_expect_failure '#27: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) at root' '
+	cat >27/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/27.git
+setup: worktree: $TRASH_DIRECTORY/27/wt
+setup: cwd: $TRASH_DIRECTORY/27
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/27/.git" GIT_WORK_TREE=3Dwt test_repo 27
+'
+
+test_expect_failure '#27: GIT_DIR, GIT_WORK_TREE=3Dwt at root' '
+	cat >27/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/27.git
+setup: worktree: $TRASH_DIRECTORY/27/wt
+setup: cwd: $TRASH_DIRECTORY/27
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/27/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/27/wt" test_repo 27
+'
+
+test_expect_failure '#27: GIT_DIR(rel), GIT_WORK_TREE=3Dwt in subdir' =
'
+	cat >27/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/27.git
+setup: worktree: $TRASH_DIRECTORY/27/wt
+setup: cwd: $TRASH_DIRECTORY/27/sub/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/27/wt" test_re=
po 27/sub/sub
+'
+
+test_expect_failure '#27: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) in sub=
dir' '
+	cat >27/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/27.git
+setup: worktree: $TRASH_DIRECTORY/27/wt
+setup: cwd: $TRASH_DIRECTORY/27/sub/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../../wt test_repo 27/sub/sub
+'
+
+test_expect_failure '#27: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) in subdir' =
'
+	cat >27/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/27.git
+setup: worktree: $TRASH_DIRECTORY/27/wt
+setup: cwd: $TRASH_DIRECTORY/27/sub/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/27/.git" GIT_WORK_TREE=3D../../wt test_re=
po 27/sub/sub
+'
+
+test_expect_failure '#27: GIT_DIR, GIT_WORK_TREE=3Dwt in subdir' '
+	cat >27/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/27.git
+setup: worktree: $TRASH_DIRECTORY/27/wt
+setup: cwd: $TRASH_DIRECTORY/27/sub/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/27/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/27/wt" test_repo 27/sub/sub
+'
+
+test_expect_failure '#27: GIT_DIR(rel), GIT_WORK_TREE=3D.. at root' '
+	cat >27/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/27.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 27/
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY" test_repo 27
+'
+
+test_expect_failure '#27: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) at roo=
t' '
+	cat >27/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/27.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 27/
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D.. test_repo 27
+'
+
+test_expect_failure '#27: GIT_DIR, GIT_WORK_TREE=3D..(rel) at root' '
+	cat >27/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/27.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 27/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/27/.git" GIT_WORK_TREE=3D.. test_repo 27
+'
+
+test_expect_failure '#27: GIT_DIR, GIT_WORK_TREE=3D.. at root' '
+	cat >27/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/27.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 27/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/27/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y" test_repo 27
+'
+
+test_expect_failure '#27: GIT_DIR(rel), GIT_WORK_TREE=3D.. in subdir' =
'
+	cat >27/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/27.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 27/sub/sub/
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY" test_repo 27/=
sub/sub
+'
+
+test_expect_failure '#27: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) in sub=
dir' '
+	cat >27/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/27.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 27/sub/sub/
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../../.. test_repo 27/sub/sub
+'
+
+test_expect_failure '#27: GIT_DIR, GIT_WORK_TREE=3D..(rel) in subdir' =
'
+	cat >27/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/27.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 27/sub/sub/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/27/.git" GIT_WORK_TREE=3D../../../ test_r=
epo 27/sub/sub
+'
+
+test_expect_failure '#27: GIT_DIR, GIT_WORK_TREE=3D.. in subdir' '
+	cat >27/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/27.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 27/sub/sub/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/27/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y" test_repo 27/sub/sub
+'
+
 test_done
--=20
1.7.0.2.445.gcbdb3
