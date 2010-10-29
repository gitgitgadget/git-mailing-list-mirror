From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 34/42] t1510: setup case #31
Date: Fri, 29 Oct 2010 13:48:46 +0700
Message-ID: <1288334934-17216-35-git-send-email-pclouds@gmail.com>
References: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 08:53:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBiqM-0007TV-IR
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 08:53:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933436Ab0J2Gxg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 02:53:36 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57125 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933422Ab0J2Gxe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 02:53:34 -0400
Received: by iwn10 with SMTP id 10so3313568iwn.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 23:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=d1xMMxjRn8FymOlsCA04V6peqiW4zBTmcRanXAldy50=;
        b=PPWCGpub0MgGx/5aCHoTspBIYdgM7qWx8ONHYwB5kQ3V58+yygO2Wzne6NyYd641ss
         melRL0IFkOg26fD5tJfLWrsito1iSl0R5oWZ8Nbkmfzk5vSw1oFrEwuu3p7bsrsGd2aM
         uAa3TDSU+2iuJ6gwnliLI85CmxKsWMgUuHKYA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=atrLvPNJKrq+Xc5WNQt1wShPyOd5O8pAMlhwlLBoJK35qqlqR1SlAlwRVevBtek2rY
         tQVUmnOV+1232DY9aFo0aQWPeUQ6L2Wu+auujplCJ2x21FKrc2Z5ZYv1U/dDFFU4cEoc
         bx06g1SiqJsLHpGUfSzLTs5ZPiLBm6S+NB4Ss=
Received: by 10.231.31.6 with SMTP id w6mr2732565ibc.159.1288335214353;
        Thu, 28 Oct 2010 23:53:34 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id d21sm88979ibg.15.2010.10.28.23.53.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 23:53:33 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 29 Oct 2010 13:53:33 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160302>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |  269 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 269 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 02b8e65..fe65a02 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -4243,4 +4243,273 @@ test_expect_failure '#30: at root' '
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
+	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/31" test_repo 31
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
+	GIT_DIR=3D.git GIT_WORK_TREE=3D. test_repo 31
+'
+
+test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3Droot at root' '
+	cat >31/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY/31
+setup: cwd: $TRASH_DIRECTORY/31
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/31/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/31" test_repo 31
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
+	GIT_DIR=3D"$TRASH_DIRECTORY/31/.git" GIT_WORK_TREE=3D. test_repo 31
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
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/31" test_repo =
31/sub/sub
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
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../.. test_repo 31/sub/sub
+'
+
+test_expect_failure '#31: GIT_DIR, GIT_WORKTREE=3Droot in subdir' '
+	cat >31/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY/31
+setup: cwd: $TRASH_DIRECTORY/31
+setup: prefix: sub/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/31/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/31" test_repo 31/sub
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
+	GIT_DIR=3D"$TRASH_DIRECTORY/31/.git" GIT_WORK_TREE=3D../.. test_repo =
31/sub/sub
+'
+
+test_expect_failure '#31: GIT_DIR(rel), GIT_WORK_TREE=3Dwt at root' '
+	cat >31/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY/31/wt
+setup: cwd: $TRASH_DIRECTORY/31
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/31/wt" test_repo 31
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
+	GIT_DIR=3D.git GIT_WORK_TREE=3Dwt test_repo 31
+'
+
+test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) at root' '
+	cat >31/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY/31/wt
+setup: cwd: $TRASH_DIRECTORY/31
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/31/.git" GIT_WORK_TREE=3Dwt test_repo 31
+'
+
+test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3Dwt at root' '
+	cat >31/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY/31/wt
+setup: cwd: $TRASH_DIRECTORY/31
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/31/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/31/wt" test_repo 31
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
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/31/wt" test_re=
po 31/sub/sub
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
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../../wt test_repo 31/sub/sub
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
+	GIT_DIR=3D"$TRASH_DIRECTORY/31/.git" GIT_WORK_TREE=3D../../wt test_re=
po 31/sub/sub
+'
+
+test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3Dwt in subdir' '
+	cat >31/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY/31/wt
+setup: cwd: $TRASH_DIRECTORY/31/sub/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/31/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/31/wt" test_repo 31/sub/sub
+'
+
+test_expect_failure '#31: GIT_DIR(rel), GIT_WORK_TREE=3D.. at root' '
+	cat >31/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 31/
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY" test_repo 31
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
+	GIT_DIR=3D.git GIT_WORK_TREE=3D.. test_repo 31
+'
+
+test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3D..(rel) at root' '
+	cat >31/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 31/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/31/.git" GIT_WORK_TREE=3D.. test_repo 31
+'
+
+test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3D.. at root' '
+	cat >31/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 31/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/31/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y" test_repo 31
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
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY" test_repo 31/=
sub/sub
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
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../../.. test_repo 31/sub/sub
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
+	GIT_DIR=3D"$TRASH_DIRECTORY/31/.git" GIT_WORK_TREE=3D../../../ test_r=
epo 31/sub/sub
+'
+
+test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3D.. in subdir' '
+	cat >31/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/31.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 31/sub/sub/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/31/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y" test_repo 31/sub/sub
+'
+
 test_done
--=20
1.7.0.2.445.gcbdb3
