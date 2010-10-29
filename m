From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 42/42] t1510: all failed tests are now fixed
Date: Fri, 29 Oct 2010 13:48:54 +0700
Message-ID: <1288334934-17216-43-git-send-email-pclouds@gmail.com>
References: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 08:54:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBirM-0007qD-Qp
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 08:54:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933571Ab0J2Gyg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 02:54:36 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64522 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933422Ab0J2Gye (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 02:54:34 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so692674pwj.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 23:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=CKtjfxZXl2T6JoKFRMAtkOyffiSy42bKWbmts2aPPMo=;
        b=HAI3JGbhxoX7/2eL/V67oVjUbpOYibGIWR8lbi4RLFSSCG/34YLI9h9I8AFnxhGFaP
         n0HGZiTS0kKwwOvy9S1uMEMpt2+udeyVha4UYnXKjVcN/FDcIrdDQtu6AWBPvHT/EiNU
         th3c0iycgIVNuM5FAQYhUfmRzgkr6B93uQ2a4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Ner0Eq8SDsJiP+mvaWEx01OgNhjlsSRpzWFVIHJJ6Jwz3uyR32nPuEUKhEwBifT1/t
         apfwTDfiPmmN0iDUyb1NH3NRBGkS4pdERtuEJvDCS5ZHG8wvILsDC8MemUUGQd7XRdwD
         fbBINMyqzEMohh+mSjazUdgznFdBZ5xjY7M28=
Received: by 10.142.53.2 with SMTP id b2mr1070646wfa.61.1288335274120;
        Thu, 28 Oct 2010 23:54:34 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id w42sm1029681wfh.15.2010.10.28.23.54.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 23:54:32 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 29 Oct 2010 13:54:32 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160310>

get_git_work_tree() clean up patch impacts all three setup_* functions
and makes it impossible to mark what patch fixes what tests. But
everything is OK now.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |  356 ++++++++++++++++++++++++-----------------=
-------
 1 files changed, 178 insertions(+), 178 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index fe65a02..3eddc71 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -129,7 +129,7 @@ test_expect_success '#1: setup' '
 	cd ..
 '
=20
-test_expect_failure '#1: at root' '
+test_expect_success '#1: at root' '
 	cat >1/expected <<EOF &&
 setup: git_dir: .git
 setup: worktree: $TRASH_DIRECTORY/1
@@ -139,7 +139,7 @@ EOF
 	test_repo 1
 '
=20
-test_expect_failure '#1: in subdir' '
+test_expect_success '#1: in subdir' '
 	cat >1/sub/expected <<EOF &&
 setup: git_dir: .git
 setup: worktree: $TRASH_DIRECTORY/1
@@ -509,7 +509,7 @@ test_expect_success '#4: setup' '
 	cd ..
 '
=20
-test_expect_failure '#4: at root' '
+test_expect_success '#4: at root' '
 	cat >4/expected <<EOF &&
 setup: git_dir: .git
 setup: worktree: $TRASH_DIRECTORY/4
@@ -519,7 +519,7 @@ EOF
 	test_repo 4
 '
=20
-test_expect_failure '#4: in subdir' '
+test_expect_success '#4: in subdir' '
 	cat >4/sub/expected <<EOF &&
 setup: git_dir: .git
 setup: worktree: $TRASH_DIRECTORY/4
@@ -556,7 +556,7 @@ test_expect_success '#5: setup' '
 	cd ..
 '
=20
-test_expect_failure '#5: at root' '
+test_expect_success '#5: at root' '
 	cat >5/expected <<EOF &&
 setup: git_dir: .git
 setup: worktree: $TRASH_DIRECTORY/5
@@ -566,7 +566,7 @@ EOF
 	test_repo 5
 '
=20
-test_expect_failure '#5: in subdir' '
+test_expect_success '#5: in subdir' '
 	cat >5/sub/expected <<EOF &&
 setup: git_dir: .git
 setup: worktree: $TRASH_DIRECTORY/5
@@ -647,7 +647,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/6/.git" test_repo 6
 '
=20
-test_expect_failure '#6: GIT_DIR(rel), core.worktree=3D.. in subdir' '
+test_expect_success '#6: GIT_DIR(rel), core.worktree=3D.. in subdir' '
 	cat >6/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/6/.git
 setup: worktree: $TRASH_DIRECTORY/6
@@ -658,7 +658,7 @@ EOF
 	GIT_DIR=3D../../.git test_repo 6/sub/sub
 '
=20
-test_expect_failure '#6: GIT_DIR(rel), core.worktree=3D..(rel) in subd=
ir' '
+test_expect_success '#6: GIT_DIR(rel), core.worktree=3D..(rel) in subd=
ir' '
 	cat >6/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/6/.git
 setup: worktree: $TRASH_DIRECTORY/6
@@ -823,7 +823,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/6/.git" test_repo 6
 '
=20
-test_expect_failure '#6: GIT_DIR(rel), core.worktree=3D../.. in subdir=
' '
+test_expect_success '#6: GIT_DIR(rel), core.worktree=3D../.. in subdir=
' '
 	cat >6/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/6/.git
 setup: worktree: $TRASH_DIRECTORY
@@ -834,7 +834,7 @@ EOF
 	GIT_DIR=3D../../.git test_repo 6/sub/sub
 '
=20
-test_expect_failure '#6: GIT_DIR(rel), core.worktree=3D../..(rel) in s=
ubdir' '
+test_expect_success '#6: GIT_DIR(rel), core.worktree=3D../..(rel) in s=
ubdir' '
 	cat >6/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/6/.git
 setup: worktree: $TRASH_DIRECTORY
@@ -1207,7 +1207,7 @@ test_expect_success '#9: setup' '
 	cd ..
 '
=20
-test_expect_failure '#9: at root' '
+test_expect_success '#9: at root' '
 	cat >9/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/9.git
 setup: worktree: $TRASH_DIRECTORY/9
@@ -1217,7 +1217,7 @@ EOF
 	GIT_WORK_TREE=3Dnon-existent test_repo 9
 '
=20
-test_expect_failure '#9: in subdir' '
+test_expect_success '#9: in subdir' '
 	cat >9/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/9.git
 setup: worktree: $TRASH_DIRECTORY/9
@@ -1254,7 +1254,7 @@ test_expect_success '#10: setup' '
 	cd ..
 '
=20
-test_expect_failure '#10: at root' '
+test_expect_success '#10: at root' '
 	cat >10/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/10.git
 setup: worktree: $TRASH_DIRECTORY/10
@@ -1264,7 +1264,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/10/.git" test_repo 10
 '
=20
-test_expect_failure '#10: in subdir' '
+test_expect_success '#10: in subdir' '
 	cat >10/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/10.git
 setup: worktree: $TRASH_DIRECTORY/10/sub
@@ -1274,7 +1274,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/10/.git" test_repo 10/sub
 '
=20
-test_expect_failure '#10: relative GIT_DIR at root' '
+test_expect_success '#10: relative GIT_DIR at root' '
 	cat >10/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/10.git
 setup: worktree: $TRASH_DIRECTORY/10
@@ -1284,7 +1284,7 @@ EOF
 	GIT_DIR=3D.git test_repo 10
 '
=20
-test_expect_failure '#10: relative GIT_DIR in subdir' '
+test_expect_success '#10: relative GIT_DIR in subdir' '
 	cat >10/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/10.git
 setup: worktree: $TRASH_DIRECTORY/10/sub
@@ -1321,7 +1321,7 @@ test_expect_success '#11: setup' '
 	cd ..
 '
=20
-test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3Droot at root' =
'
+test_expect_success '#11: GIT_DIR(rel), GIT_WORK_TREE=3Droot at root' =
'
 	cat >11/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY/11
@@ -1331,7 +1331,7 @@ EOF
 	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/11" test_repo 11
 '
=20
-test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3Droot(rel) at r=
oot' '
+test_expect_success '#11: GIT_DIR(rel), GIT_WORK_TREE=3Droot(rel) at r=
oot' '
 	cat >11/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY/11
@@ -1341,7 +1341,7 @@ EOF
 	GIT_DIR=3D.git GIT_WORK_TREE=3D. test_repo 11
 '
=20
-test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3Droot at root' '
+test_expect_success '#11: GIT_DIR, GIT_WORK_TREE=3Droot at root' '
 	cat >11/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY/11
@@ -1351,7 +1351,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/11" test_repo 11
 '
=20
-test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3Droot(rel) at root' =
'
+test_expect_success '#11: GIT_DIR, GIT_WORK_TREE=3Droot(rel) at root' =
'
 	cat >11/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY/11
@@ -1361,7 +1361,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE=3D. test_repo 11
 '
=20
-test_expect_failure '#11: GIT_DIR(rel), GIT_WORKTREE=3Droot in subdir'=
 '
+test_expect_success '#11: GIT_DIR(rel), GIT_WORKTREE=3Droot in subdir'=
 '
 	cat >11/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY/11
@@ -1371,7 +1371,7 @@ EOF
 	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/11" test_repo =
11/sub/sub
 '
=20
-test_expect_failure '#11: GIT_DIR(rel), GIT_WORKTREE=3Droot(rel) in su=
bdir' '
+test_expect_success '#11: GIT_DIR(rel), GIT_WORKTREE=3Droot(rel) in su=
bdir' '
 	cat >11/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY/11
@@ -1381,7 +1381,7 @@ EOF
 	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../.. test_repo 11/sub/sub
 '
=20
-test_expect_failure '#11: GIT_DIR, GIT_WORKTREE=3Droot in subdir' '
+test_expect_success '#11: GIT_DIR, GIT_WORKTREE=3Droot in subdir' '
 	cat >11/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY/11
@@ -1391,7 +1391,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/11" test_repo 11/sub
 '
=20
-test_expect_failure '#11: GIT_DIR, GIT_WORKTREE=3Droot(rel) in subdir'=
 '
+test_expect_success '#11: GIT_DIR, GIT_WORKTREE=3Droot(rel) in subdir'=
 '
 	cat >11/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY/11
@@ -1401,7 +1401,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE=3D../.. test_repo =
11/sub/sub
 '
=20
-test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3Dwt at root' '
+test_expect_success '#11: GIT_DIR(rel), GIT_WORK_TREE=3Dwt at root' '
 	cat >11/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY/11/wt
@@ -1411,7 +1411,7 @@ EOF
 	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/11/wt" test_repo 11
 '
=20
-test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) at roo=
t' '
+test_expect_success '#11: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) at roo=
t' '
 	cat >11/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY/11/wt
@@ -1421,7 +1421,7 @@ EOF
 	GIT_DIR=3D.git GIT_WORK_TREE=3Dwt test_repo 11
 '
=20
-test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) at root' '
+test_expect_success '#11: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) at root' '
 	cat >11/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY/11/wt
@@ -1431,7 +1431,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE=3Dwt test_repo 11
 '
=20
-test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3Dwt at root' '
+test_expect_success '#11: GIT_DIR, GIT_WORK_TREE=3Dwt at root' '
 	cat >11/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY/11/wt
@@ -1441,7 +1441,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/11/wt" test_repo 11
 '
=20
-test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3Dwt in subdir' =
'
+test_expect_success '#11: GIT_DIR(rel), GIT_WORK_TREE=3Dwt in subdir' =
'
 	cat >11/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY/11/wt
@@ -1451,7 +1451,7 @@ EOF
 	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/11/wt" test_re=
po 11/sub/sub
 '
=20
-test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) in sub=
dir' '
+test_expect_success '#11: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) in sub=
dir' '
 	cat >11/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY/11/wt
@@ -1461,7 +1461,7 @@ EOF
 	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../../wt test_repo 11/sub/sub
 '
=20
-test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) in subdir' =
'
+test_expect_success '#11: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) in subdir' =
'
 	cat >11/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY/11/wt
@@ -1471,7 +1471,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE=3D../../wt test_re=
po 11/sub/sub
 '
=20
-test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3Dwt in subdir' '
+test_expect_success '#11: GIT_DIR, GIT_WORK_TREE=3Dwt in subdir' '
 	cat >11/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY/11/wt
@@ -1481,7 +1481,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/11/wt" test_repo 11/sub/sub
 '
=20
-test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3D.. at root' '
+test_expect_success '#11: GIT_DIR(rel), GIT_WORK_TREE=3D.. at root' '
 	cat >11/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY
@@ -1491,7 +1491,7 @@ EOF
 	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY" test_repo 11
 '
=20
-test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) at roo=
t' '
+test_expect_success '#11: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) at roo=
t' '
 	cat >11/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY
@@ -1501,7 +1501,7 @@ EOF
 	GIT_DIR=3D.git GIT_WORK_TREE=3D.. test_repo 11
 '
=20
-test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3D..(rel) at root' '
+test_expect_success '#11: GIT_DIR, GIT_WORK_TREE=3D..(rel) at root' '
 	cat >11/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY
@@ -1511,7 +1511,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE=3D.. test_repo 11
 '
=20
-test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3D.. at root' '
+test_expect_success '#11: GIT_DIR, GIT_WORK_TREE=3D.. at root' '
 	cat >11/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY
@@ -1521,7 +1521,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y" test_repo 11
 '
=20
-test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3D.. in subdir' =
'
+test_expect_success '#11: GIT_DIR(rel), GIT_WORK_TREE=3D.. in subdir' =
'
 	cat >11/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY
@@ -1531,7 +1531,7 @@ EOF
 	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY" test_repo 11/=
sub/sub
 '
=20
-test_expect_failure '#11: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) in sub=
dir' '
+test_expect_success '#11: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) in sub=
dir' '
 	cat >11/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY
@@ -1541,7 +1541,7 @@ EOF
 	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../../.. test_repo 11/sub/sub
 '
=20
-test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3D..(rel) in subdir' =
'
+test_expect_success '#11: GIT_DIR, GIT_WORK_TREE=3D..(rel) in subdir' =
'
 	cat >11/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY
@@ -1551,7 +1551,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE=3D../../../ test_r=
epo 11/sub/sub
 '
=20
-test_expect_failure '#11: GIT_DIR, GIT_WORK_TREE=3D.. in subdir' '
+test_expect_success '#11: GIT_DIR, GIT_WORK_TREE=3D.. in subdir' '
 	cat >11/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/11.git
 setup: worktree: $TRASH_DIRECTORY
@@ -1590,7 +1590,7 @@ test_expect_success '#12: setup' '
 	cd ..
 '
=20
-test_expect_failure '#12: at root' '
+test_expect_success '#12: at root' '
 	cat >12/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/12.git
 setup: worktree: $TRASH_DIRECTORY/12
@@ -1600,7 +1600,7 @@ EOF
 	test_repo 12
 '
=20
-test_expect_failure '#12: in subdir' '
+test_expect_success '#12: in subdir' '
 	cat >12/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/12.git
 setup: worktree: $TRASH_DIRECTORY/12
@@ -1639,7 +1639,7 @@ test_expect_success '#13: setup' '
 	cd ..
 '
=20
-test_expect_failure '#13: at root' '
+test_expect_success '#13: at root' '
 	cat >13/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/13.git
 setup: worktree: $TRASH_DIRECTORY/13
@@ -1649,7 +1649,7 @@ EOF
 	test_repo 13
 '
=20
-test_expect_failure '#13: in subdir' '
+test_expect_success '#13: in subdir' '
 	cat >13/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/13.git
 setup: worktree: $TRASH_DIRECTORY/13
@@ -1686,7 +1686,7 @@ test_expect_success '#14: setup' '
 	cd ..
 '
=20
-test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D../14 at root'=
 '
+test_expect_success '#14: GIT_DIR(rel), core.worktree=3D../14 at root'=
 '
 	cat >14/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY/14
@@ -1697,7 +1697,7 @@ EOF
 	GIT_DIR=3D.git test_repo 14
 '
=20
-test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D../14(rel) at =
root' '
+test_expect_success '#14: GIT_DIR(rel), core.worktree=3D../14(rel) at =
root' '
 	cat >14/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY/14
@@ -1708,7 +1708,7 @@ EOF
 	GIT_DIR=3D.git test_repo 14
 '
=20
-test_expect_failure '#14: GIT_DIR, core.worktree=3D../14 at root' '
+test_expect_success '#14: GIT_DIR, core.worktree=3D../14 at root' '
 	cat >14/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY/14
@@ -1719,7 +1719,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/14/.git" test_repo 14
 '
=20
-test_expect_failure '#14: GIT_DIR, core.worktree=3D../14(rel) at root'=
 '
+test_expect_success '#14: GIT_DIR, core.worktree=3D../14(rel) at root'=
 '
 	cat >14/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY/14
@@ -1730,7 +1730,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/14/.git" test_repo 14
 '
=20
-test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D../14 in subdi=
r' '
+test_expect_success '#14: GIT_DIR(rel), core.worktree=3D../14 in subdi=
r' '
 	cat >14/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY/14
@@ -1741,7 +1741,7 @@ EOF
 	GIT_DIR=3D../../.git test_repo 14/sub/sub
 '
=20
-test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D../14(rel) in =
subdir' '
+test_expect_success '#14: GIT_DIR(rel), core.worktree=3D../14(rel) in =
subdir' '
 	cat >14/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY/14
@@ -1752,7 +1752,7 @@ EOF
 	GIT_DIR=3D../../.git test_repo 14/sub/sub
 '
=20
-test_expect_failure '#14: GIT_DIR, core.worktree=3D../14 in subdir' '
+test_expect_success '#14: GIT_DIR, core.worktree=3D../14 in subdir' '
 	cat >14/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY/14
@@ -1763,7 +1763,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/14/.git" test_repo 14/sub
 '
=20
-test_expect_failure '#14: GIT_DIR, core.worktree=3D../14(rel) in subdi=
r' '
+test_expect_success '#14: GIT_DIR, core.worktree=3D../14(rel) in subdi=
r' '
 	cat >14/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY/14
@@ -1774,7 +1774,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/14/.git" test_repo 14/sub/sub
 '
=20
-test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D../14/wt at ro=
ot' '
+test_expect_success '#14: GIT_DIR(rel), core.worktree=3D../14/wt at ro=
ot' '
 	cat >14/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY/14/wt
@@ -1785,7 +1785,7 @@ EOF
 	GIT_DIR=3D.git test_repo 14
 '
=20
-test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D../14/wt(rel) =
at root' '
+test_expect_success '#14: GIT_DIR(rel), core.worktree=3D../14/wt(rel) =
at root' '
 	cat >14/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY/14/wt
@@ -1796,7 +1796,7 @@ EOF
 	GIT_DIR=3D.git test_repo 14
 '
=20
-test_expect_failure '#14: GIT_DIR, core.worktree=3D../14/wt(rel) at ro=
ot' '
+test_expect_success '#14: GIT_DIR, core.worktree=3D../14/wt(rel) at ro=
ot' '
 	cat >14/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY/14/wt
@@ -1807,7 +1807,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/14/.git" test_repo 14
 '
=20
-test_expect_failure '#14: GIT_DIR, core.worktree=3D../14/wt at root' '
+test_expect_success '#14: GIT_DIR, core.worktree=3D../14/wt at root' '
 	cat >14/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY/14/wt
@@ -1818,7 +1818,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/14/.git" test_repo 14
 '
=20
-test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D../14/wt in su=
bdir' '
+test_expect_success '#14: GIT_DIR(rel), core.worktree=3D../14/wt in su=
bdir' '
 	cat >14/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY/14/wt
@@ -1829,7 +1829,7 @@ EOF
 	GIT_DIR=3D../../.git test_repo 14/sub/sub
 '
=20
-test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D../14/wt(rel) =
in subdir' '
+test_expect_success '#14: GIT_DIR(rel), core.worktree=3D../14/wt(rel) =
in subdir' '
 	cat >14/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY/14/wt
@@ -1840,7 +1840,7 @@ EOF
 	GIT_DIR=3D../../.git test_repo 14/sub/sub
 '
=20
-test_expect_failure '#14: GIT_DIR, core.worktree=3D../14/wt(rel) in su=
bdir' '
+test_expect_success '#14: GIT_DIR, core.worktree=3D../14/wt(rel) in su=
bdir' '
 	cat >14/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY/14/wt
@@ -1851,7 +1851,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/14/.git" test_repo 14/sub/sub
 '
=20
-test_expect_failure '#14: GIT_DIR, core.worktree=3D../14/wt in subdir'=
 '
+test_expect_success '#14: GIT_DIR, core.worktree=3D../14/wt in subdir'=
 '
 	cat >14/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY/14/wt
@@ -1862,7 +1862,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/14/.git" test_repo 14/sub/sub
 '
=20
-test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D.. at root' '
+test_expect_success '#14: GIT_DIR(rel), core.worktree=3D.. at root' '
 	cat >14/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY
@@ -1873,7 +1873,7 @@ EOF
 	GIT_DIR=3D.git test_repo 14
 '
=20
-test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D..(rel) at roo=
t' '
+test_expect_success '#14: GIT_DIR(rel), core.worktree=3D..(rel) at roo=
t' '
 	cat >14/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY
@@ -1884,7 +1884,7 @@ EOF
 	GIT_DIR=3D.git test_repo 14
 '
=20
-test_expect_failure '#14: GIT_DIR, core.worktree=3D..(rel) at root' '
+test_expect_success '#14: GIT_DIR, core.worktree=3D..(rel) at root' '
 	cat >14/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY
@@ -1895,7 +1895,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/14/.git" test_repo 14
 '
=20
-test_expect_failure '#14: GIT_DIR, core.worktree=3D.. at root' '
+test_expect_success '#14: GIT_DIR, core.worktree=3D.. at root' '
 	cat >14/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY
@@ -1906,7 +1906,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/14/.git" test_repo 14
 '
=20
-test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D.. in subdir' =
'
+test_expect_success '#14: GIT_DIR(rel), core.worktree=3D.. in subdir' =
'
 	cat >14/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY
@@ -1917,7 +1917,7 @@ EOF
 	GIT_DIR=3D../../.git test_repo 14/sub/sub
 '
=20
-test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D..(rel) in sub=
dir' '
+test_expect_success '#14: GIT_DIR(rel), core.worktree=3D..(rel) in sub=
dir' '
 	cat >14/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY
@@ -1928,7 +1928,7 @@ EOF
 	GIT_DIR=3D../../.git test_repo 14/sub/sub
 '
=20
-test_expect_failure '#14: GIT_DIR, core.worktree=3D..(rel) in subdir' =
'
+test_expect_success '#14: GIT_DIR, core.worktree=3D..(rel) in subdir' =
'
 	cat >14/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY
@@ -1939,7 +1939,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/14/.git" test_repo 14/sub/sub
 '
=20
-test_expect_failure '#14: GIT_DIR, core.worktree=3D.. in subdir' '
+test_expect_success '#14: GIT_DIR, core.worktree=3D.. in subdir' '
 	cat >14/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/14.git
 setup: worktree: $TRASH_DIRECTORY
@@ -1978,7 +1978,7 @@ test_expect_success '#15: setup' '
 	cd ..
 '
=20
-test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=3Droot at root' =
'
+test_expect_success '#15: GIT_DIR(rel), GIT_WORK_TREE=3Droot at root' =
'
 	cat >15/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY/15
@@ -1988,7 +1988,7 @@ EOF
 	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/15" test_repo 15
 '
=20
-test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=3Droot(rel) at r=
oot' '
+test_expect_success '#15: GIT_DIR(rel), GIT_WORK_TREE=3Droot(rel) at r=
oot' '
 	cat >15/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY/15
@@ -1998,7 +1998,7 @@ EOF
 	GIT_DIR=3D.git GIT_WORK_TREE=3D. test_repo 15
 '
=20
-test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=3Droot at root' '
+test_expect_success '#15: GIT_DIR, GIT_WORK_TREE=3Droot at root' '
 	cat >15/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY/15
@@ -2008,7 +2008,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/15/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/15" test_repo 15
 '
=20
-test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=3Droot(rel) at root' =
'
+test_expect_success '#15: GIT_DIR, GIT_WORK_TREE=3Droot(rel) at root' =
'
 	cat >15/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY/15
@@ -2018,7 +2018,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/15/.git" GIT_WORK_TREE=3D. test_repo 15
 '
=20
-test_expect_failure '#15: GIT_DIR(rel), GIT_WORKTREE=3Droot in subdir'=
 '
+test_expect_success '#15: GIT_DIR(rel), GIT_WORKTREE=3Droot in subdir'=
 '
 	cat >15/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY/15
@@ -2028,7 +2028,7 @@ EOF
 	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/15" test_repo =
15/sub/sub
 '
=20
-test_expect_failure '#15: GIT_DIR(rel), GIT_WORKTREE=3Droot(rel) in su=
bdir' '
+test_expect_success '#15: GIT_DIR(rel), GIT_WORKTREE=3Droot(rel) in su=
bdir' '
 	cat >15/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY/15
@@ -2038,7 +2038,7 @@ EOF
 	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../.. test_repo 15/sub/sub
 '
=20
-test_expect_failure '#15: GIT_DIR, GIT_WORKTREE=3Droot in subdir' '
+test_expect_success '#15: GIT_DIR, GIT_WORKTREE=3Droot in subdir' '
 	cat >15/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY/15
@@ -2048,7 +2048,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/15/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/15" test_repo 15/sub
 '
=20
-test_expect_failure '#15: GIT_DIR, GIT_WORKTREE=3Droot(rel) in subdir'=
 '
+test_expect_success '#15: GIT_DIR, GIT_WORKTREE=3Droot(rel) in subdir'=
 '
 	cat >15/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY/15
@@ -2058,7 +2058,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/15/.git" GIT_WORK_TREE=3D../.. test_repo =
15/sub/sub
 '
=20
-test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=3Dwt at root' '
+test_expect_success '#15: GIT_DIR(rel), GIT_WORK_TREE=3Dwt at root' '
 	cat >15/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY/15/wt
@@ -2068,7 +2068,7 @@ EOF
 	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/15/wt" test_repo 15
 '
=20
-test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) at roo=
t' '
+test_expect_success '#15: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) at roo=
t' '
 	cat >15/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY/15/wt
@@ -2078,7 +2078,7 @@ EOF
 	GIT_DIR=3D.git GIT_WORK_TREE=3Dwt test_repo 15
 '
=20
-test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) at root' '
+test_expect_success '#15: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) at root' '
 	cat >15/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY/15/wt
@@ -2088,7 +2088,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/15/.git" GIT_WORK_TREE=3Dwt test_repo 15
 '
=20
-test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=3Dwt at root' '
+test_expect_success '#15: GIT_DIR, GIT_WORK_TREE=3Dwt at root' '
 	cat >15/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY/15/wt
@@ -2098,7 +2098,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/15/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/15/wt" test_repo 15
 '
=20
-test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=3Dwt in subdir' =
'
+test_expect_success '#15: GIT_DIR(rel), GIT_WORK_TREE=3Dwt in subdir' =
'
 	cat >15/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY/15/wt
@@ -2108,7 +2108,7 @@ EOF
 	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/15/wt" test_re=
po 15/sub/sub
 '
=20
-test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) in sub=
dir' '
+test_expect_success '#15: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) in sub=
dir' '
 	cat >15/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY/15/wt
@@ -2118,7 +2118,7 @@ EOF
 	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../../wt test_repo 15/sub/sub
 '
=20
-test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) in subdir' =
'
+test_expect_success '#15: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) in subdir' =
'
 	cat >15/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY/15/wt
@@ -2128,7 +2128,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/15/.git" GIT_WORK_TREE=3D../../wt test_re=
po 15/sub/sub
 '
=20
-test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=3Dwt in subdir' '
+test_expect_success '#15: GIT_DIR, GIT_WORK_TREE=3Dwt in subdir' '
 	cat >15/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY/15/wt
@@ -2138,7 +2138,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/15/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/15/wt" test_repo 15/sub/sub
 '
=20
-test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=3D.. at root' '
+test_expect_success '#15: GIT_DIR(rel), GIT_WORK_TREE=3D.. at root' '
 	cat >15/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY
@@ -2148,7 +2148,7 @@ EOF
 	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY" test_repo 15
 '
=20
-test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) at roo=
t' '
+test_expect_success '#15: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) at roo=
t' '
 	cat >15/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY
@@ -2158,7 +2158,7 @@ EOF
 	GIT_DIR=3D.git GIT_WORK_TREE=3D.. test_repo 15
 '
=20
-test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=3D..(rel) at root' '
+test_expect_success '#15: GIT_DIR, GIT_WORK_TREE=3D..(rel) at root' '
 	cat >15/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY
@@ -2168,7 +2168,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/15/.git" GIT_WORK_TREE=3D.. test_repo 15
 '
=20
-test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=3D.. at root' '
+test_expect_success '#15: GIT_DIR, GIT_WORK_TREE=3D.. at root' '
 	cat >15/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY
@@ -2178,7 +2178,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/15/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y" test_repo 15
 '
=20
-test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=3D.. in subdir' =
'
+test_expect_success '#15: GIT_DIR(rel), GIT_WORK_TREE=3D.. in subdir' =
'
 	cat >15/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY
@@ -2188,7 +2188,7 @@ EOF
 	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY" test_repo 15/=
sub/sub
 '
=20
-test_expect_failure '#15: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) in sub=
dir' '
+test_expect_success '#15: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) in sub=
dir' '
 	cat >15/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY
@@ -2198,7 +2198,7 @@ EOF
 	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../../.. test_repo 15/sub/sub
 '
=20
-test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=3D..(rel) in subdir' =
'
+test_expect_success '#15: GIT_DIR, GIT_WORK_TREE=3D..(rel) in subdir' =
'
 	cat >15/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY
@@ -2208,7 +2208,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/15/.git" GIT_WORK_TREE=3D../../../ test_r=
epo 15/sub/sub
 '
=20
-test_expect_failure '#15: GIT_DIR, GIT_WORK_TREE=3D.. in subdir' '
+test_expect_success '#15: GIT_DIR, GIT_WORK_TREE=3D.. in subdir' '
 	cat >15/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/15.git
 setup: worktree: $TRASH_DIRECTORY
@@ -2343,7 +2343,7 @@ EOF
 	test_repo 16
 '
=20
-test_expect_failure '#16.2: in subdir' '
+test_expect_success '#16.2: in subdir' '
 	cat >16/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/16/.git
 setup: worktree: (null)
@@ -2380,7 +2380,7 @@ test_expect_success '#17.1: setup' '
 	cd ..
 '
=20
-test_expect_failure '#17.1: at .git' '
+test_expect_success '#17.1: at .git' '
 	cat >17/.git/expected <<EOF &&
 setup: git_dir: .
 setup: worktree: (null)
@@ -2390,7 +2390,7 @@ EOF
 	test_repo 17/.git
 '
=20
-test_expect_failure '#17.1: in .git/wt' '
+test_expect_success '#17.1: in .git/wt' '
 	cat >17/.git/wt/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/17/.git
 setup: worktree: (null)
@@ -2400,7 +2400,7 @@ EOF
 	test_repo 17/.git/wt
 '
=20
-test_expect_failure '#17.1: in .git/wt/sub' '
+test_expect_success '#17.1: in .git/wt/sub' '
 	cat >17/.git/wt/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/17/.git
 setup: worktree: (null)
@@ -2431,7 +2431,7 @@ test_expect_success '#17.2: setup' '
 	git config --file=3D"$TRASH_DIRECTORY/17/.git/config" core.bare true
 '
=20
-test_expect_failure '#17.2: at .git' '
+test_expect_success '#17.2: at .git' '
 	cat >17/.git/expected <<EOF &&
 setup: git_dir: .
 setup: worktree: (null)
@@ -2441,7 +2441,7 @@ EOF
 	test_repo 17/.git
 '
=20
-test_expect_failure '#17.2: in .git/wt' '
+test_expect_success '#17.2: in .git/wt' '
 	cat >17/.git/wt/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/17/.git
 setup: worktree: (null)
@@ -2451,7 +2451,7 @@ EOF
 	test_repo 17/.git/wt
 '
=20
-test_expect_failure '#17.2: in .git/wt/sub' '
+test_expect_success '#17.2: in .git/wt/sub' '
 	cat >17/.git/wt/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/17/.git
 setup: worktree: (null)
@@ -2461,7 +2461,7 @@ EOF
 	test_repo 17/.git/wt/sub
 '
=20
-test_expect_failure '#17.2: at root' '
+test_expect_success '#17.2: at root' '
 	cat >17/expected <<EOF &&
 setup: git_dir: .git
 setup: worktree: (null)
@@ -2471,7 +2471,7 @@ EOF
 	test_repo 17
 '
=20
-test_expect_failure '#17.2: in subdir' '
+test_expect_success '#17.2: in subdir' '
 	cat >17/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/17/.git
 setup: worktree: (null)
@@ -2845,7 +2845,7 @@ test_expect_success '#20.1: setup' '
 	cd ..
 '
=20
-test_expect_failure '#20.1: at .git' '
+test_expect_success '#20.1: at .git' '
 	cat >20/.git/expected <<EOF &&
 setup: git_dir: .
 setup: worktree: (null)
@@ -2855,7 +2855,7 @@ EOF
 	test_repo 20/.git
 '
=20
-test_expect_failure '#20.1: in .git/wt' '
+test_expect_success '#20.1: in .git/wt' '
 	cat >20/.git/wt/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/20/.git
 setup: worktree: (null)
@@ -2865,7 +2865,7 @@ EOF
 	test_repo 20/.git/wt
 '
=20
-test_expect_failure '#20.1: in .git/wt/sub' '
+test_expect_success '#20.1: in .git/wt/sub' '
 	cat >20/.git/wt/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/20/.git
 setup: worktree: (null)
@@ -2936,7 +2936,7 @@ EOF
 	test_repo 20
 '
=20
-test_expect_failure '#20.2: in subdir' '
+test_expect_success '#20.2: in subdir' '
 	cat >20/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/20/.git
 setup: worktree: (null)
@@ -2974,7 +2974,7 @@ test_expect_success '#21.1: setup' '
 	cd ..
 '
=20
-test_expect_failure '#21.1: at .git' '
+test_expect_success '#21.1: at .git' '
 	cat >21/.git/expected <<EOF &&
 setup: git_dir: .
 setup: worktree: (null)
@@ -2984,7 +2984,7 @@ EOF
 	test_repo 21/.git
 '
=20
-test_expect_failure '#21.1: in .git/wt' '
+test_expect_success '#21.1: in .git/wt' '
 	cat >21/.git/wt/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/21/.git
 setup: worktree: (null)
@@ -2994,7 +2994,7 @@ EOF
 	test_repo 21/.git/wt
 '
=20
-test_expect_failure '#21.1: in .git/wt/sub' '
+test_expect_success '#21.1: in .git/wt/sub' '
 	cat >21/.git/wt/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/21/.git
 setup: worktree: (null)
@@ -3025,7 +3025,7 @@ test_expect_success '#21.2: setup' '
 	git config --file=3D"$TRASH_DIRECTORY/21/.git/config" core.bare true
 '
=20
-test_expect_failure '#21.2: at .git' '
+test_expect_success '#21.2: at .git' '
 	cat >21/.git/expected <<EOF &&
 setup: git_dir: .
 setup: worktree: (null)
@@ -3035,7 +3035,7 @@ EOF
 	test_repo 21/.git
 '
=20
-test_expect_failure '#21.2: in .git/wt' '
+test_expect_success '#21.2: in .git/wt' '
 	cat >21/.git/wt/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/21/.git
 setup: worktree: (null)
@@ -3045,7 +3045,7 @@ EOF
 	test_repo 21/.git/wt
 '
=20
-test_expect_failure '#21.2: in .git/wt/sub' '
+test_expect_success '#21.2: in .git/wt/sub' '
 	cat >21/.git/wt/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/21/.git
 setup: worktree: (null)
@@ -3055,7 +3055,7 @@ EOF
 	test_repo 21/.git/wt/sub
 '
=20
-test_expect_failure '#21.2: at root' '
+test_expect_success '#21.2: at root' '
 	cat >21/expected <<EOF &&
 setup: git_dir: .git
 setup: worktree: (null)
@@ -3065,7 +3065,7 @@ EOF
 	test_repo 21
 '
=20
-test_expect_failure '#21.2: in subdir' '
+test_expect_success '#21.2: in subdir' '
 	cat >21/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/21/.git
 setup: worktree: (null)
@@ -3151,7 +3151,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/22/.git" test_repo 22/.git
 '
=20
-test_expect_failure '#22.1: GIT_DIR(rel), core.worktree=3D. in .git/su=
b' '
+test_expect_success '#22.1: GIT_DIR(rel), core.worktree=3D. in .git/su=
b' '
 	cat >22/.git/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/22/.git
 setup: worktree: $TRASH_DIRECTORY/22/.git
@@ -3162,7 +3162,7 @@ EOF
 	GIT_DIR=3D.. test_repo 22/.git/sub
 '
=20
-test_expect_failure '#22.1: GIT_DIR(rel), core.worktree=3D.(rel) in .g=
it/sub' '
+test_expect_success '#22.1: GIT_DIR(rel), core.worktree=3D.(rel) in .g=
it/sub' '
 	cat >22/.git/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/22/.git
 setup: worktree: $TRASH_DIRECTORY/22/.git
@@ -3283,7 +3283,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/22/.git" test_repo 22/.git/sub
 '
=20
-test_expect_failure '#22.1: GIT_DIR(rel), core.worktree=3D.. at .git' =
'
+test_expect_success '#22.1: GIT_DIR(rel), core.worktree=3D.. at .git' =
'
 	cat >22/.git/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/22/.git
 setup: worktree: $TRASH_DIRECTORY/22
@@ -3294,7 +3294,7 @@ EOF
 	GIT_DIR=3D. test_repo 22/.git
 '
=20
-test_expect_failure '#22.1: GIT_DIR(rel), core.worktree=3D..(rel) at .=
git' '
+test_expect_success '#22.1: GIT_DIR(rel), core.worktree=3D..(rel) at .=
git' '
 	cat >22/.git/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/22/.git
 setup: worktree: $TRASH_DIRECTORY/22
@@ -3327,7 +3327,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/22/.git" test_repo 22/.git
 '
=20
-test_expect_failure '#22.1: GIT_DIR(rel), core.worktree=3D.. in .git/s=
ub' '
+test_expect_success '#22.1: GIT_DIR(rel), core.worktree=3D.. in .git/s=
ub' '
 	cat >22/.git/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/22/.git
 setup: worktree: $TRASH_DIRECTORY/22
@@ -3338,7 +3338,7 @@ EOF
 	GIT_DIR=3D.. test_repo 22/.git/sub
 '
=20
-test_expect_failure '#22.1: GIT_DIR(rel), core.worktree=3D..(rel) in .=
git/sub' '
+test_expect_success '#22.1: GIT_DIR(rel), core.worktree=3D..(rel) in .=
git/sub' '
 	cat >22/.git/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/22/.git
 setup: worktree: $TRASH_DIRECTORY/22
@@ -3392,7 +3392,7 @@ test_expect_success '#22.2: setup' '
 	git config --file=3D"$TRASH_DIRECTORY/22/.git/config" core.bare true
 '
=20
-test_expect_failure '#22.2: at .git' '
+test_expect_success '#22.2: at .git' '
 	(
 	cd 22/.git &&
 	GIT_DIR=3D. test_must_fail git symbolic-ref HEAD 2>result &&
@@ -3400,7 +3400,7 @@ test_expect_failure '#22.2: at .git' '
 	)
 '
=20
-test_expect_failure '#22.2: at root' '
+test_expect_success '#22.2: at root' '
 	(
 	cd 22 &&
 	GIT_DIR=3D.git test_must_fail git symbolic-ref HEAD 2>result &&
@@ -3752,7 +3752,7 @@ test_expect_success '#25: setup' '
 	cd ..
 '
=20
-test_expect_failure '#25: at root' '
+test_expect_success '#25: at root' '
 	cat >25/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/25.git
 setup: worktree: (null)
@@ -3762,7 +3762,7 @@ EOF
 	test_repo 25
 '
=20
-test_expect_failure '#25: in subdir' '
+test_expect_success '#25: in subdir' '
 	cat >25/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/25.git
 setup: worktree: (null)
@@ -3800,7 +3800,7 @@ test_expect_success '#26: setup' '
 	cd ..
 '
=20
-test_expect_failure '#26: (rel) at root' '
+test_expect_success '#26: (rel) at root' '
 	cat >26/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/26.git
 setup: worktree: (null)
@@ -3810,7 +3810,7 @@ EOF
 	 GIT_DIR=3D.git test_repo 26
 '
=20
-test_expect_failure '#26: at root' '
+test_expect_success '#26: at root' '
 	cat >26/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/26.git
 setup: worktree: (null)
@@ -3820,7 +3820,7 @@ EOF
 	 GIT_DIR=3D"$TRASH_DIRECTORY/26/.git" test_repo 26
 '
=20
-test_expect_failure '#26: (rel) in subdir' '
+test_expect_success '#26: (rel) in subdir' '
 	cat >26/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/26.git
 setup: worktree: (null)
@@ -3830,7 +3830,7 @@ EOF
 	GIT_DIR=3D../.git test_repo 26/sub
 '
=20
-test_expect_failure '#26: in subdir' '
+test_expect_success '#26: in subdir' '
 	cat >26/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/26.git
 setup: worktree: (null)
@@ -3868,7 +3868,7 @@ test_expect_success '#27: setup' '
 	cd ..
 '
=20
-test_expect_failure '#27: GIT_DIR(rel), GIT_WORK_TREE=3Droot at root' =
'
+test_expect_success '#27: GIT_DIR(rel), GIT_WORK_TREE=3Droot at root' =
'
 	cat >27/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY/27
@@ -3878,7 +3878,7 @@ EOF
 	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/27" test_repo 27
 '
=20
-test_expect_failure '#27: GIT_DIR(rel), GIT_WORK_TREE=3Droot(rel) at r=
oot' '
+test_expect_success '#27: GIT_DIR(rel), GIT_WORK_TREE=3Droot(rel) at r=
oot' '
 	cat >27/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY/27
@@ -3888,7 +3888,7 @@ EOF
 	GIT_DIR=3D.git GIT_WORK_TREE=3D. test_repo 27
 '
=20
-test_expect_failure '#27: GIT_DIR, GIT_WORK_TREE=3Droot at root' '
+test_expect_success '#27: GIT_DIR, GIT_WORK_TREE=3Droot at root' '
 	cat >27/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY/27
@@ -3898,7 +3898,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/27/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/27" test_repo 27
 '
=20
-test_expect_failure '#27: GIT_DIR, GIT_WORK_TREE=3Droot(rel) at root' =
'
+test_expect_success '#27: GIT_DIR, GIT_WORK_TREE=3Droot(rel) at root' =
'
 	cat >27/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY/27
@@ -3908,7 +3908,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/27/.git" GIT_WORK_TREE=3D. test_repo 27
 '
=20
-test_expect_failure '#27: GIT_DIR(rel), GIT_WORKTREE=3Droot in subdir'=
 '
+test_expect_success '#27: GIT_DIR(rel), GIT_WORKTREE=3Droot in subdir'=
 '
 	cat >27/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY/27
@@ -3918,7 +3918,7 @@ EOF
 	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/27" test_repo =
27/sub/sub
 '
=20
-test_expect_failure '#27: GIT_DIR(rel), GIT_WORKTREE=3Droot(rel) in su=
bdir' '
+test_expect_success '#27: GIT_DIR(rel), GIT_WORKTREE=3Droot(rel) in su=
bdir' '
 	cat >27/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY/27
@@ -3928,7 +3928,7 @@ EOF
 	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../.. test_repo 27/sub/sub
 '
=20
-test_expect_failure '#27: GIT_DIR, GIT_WORKTREE=3Droot in subdir' '
+test_expect_success '#27: GIT_DIR, GIT_WORKTREE=3Droot in subdir' '
 	cat >27/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY/27
@@ -3938,7 +3938,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/27/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/27" test_repo 27/sub
 '
=20
-test_expect_failure '#27: GIT_DIR, GIT_WORKTREE=3Droot(rel) in subdir'=
 '
+test_expect_success '#27: GIT_DIR, GIT_WORKTREE=3Droot(rel) in subdir'=
 '
 	cat >27/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY/27
@@ -3948,7 +3948,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/27/.git" GIT_WORK_TREE=3D../.. test_repo =
27/sub/sub
 '
=20
-test_expect_failure '#27: GIT_DIR(rel), GIT_WORK_TREE=3Dwt at root' '
+test_expect_success '#27: GIT_DIR(rel), GIT_WORK_TREE=3Dwt at root' '
 	cat >27/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY/27/wt
@@ -3958,7 +3958,7 @@ EOF
 	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/27/wt" test_repo 27
 '
=20
-test_expect_failure '#27: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) at roo=
t' '
+test_expect_success '#27: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) at roo=
t' '
 	cat >27/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY/27/wt
@@ -3968,7 +3968,7 @@ EOF
 	GIT_DIR=3D.git GIT_WORK_TREE=3Dwt test_repo 27
 '
=20
-test_expect_failure '#27: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) at root' '
+test_expect_success '#27: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) at root' '
 	cat >27/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY/27/wt
@@ -3978,7 +3978,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/27/.git" GIT_WORK_TREE=3Dwt test_repo 27
 '
=20
-test_expect_failure '#27: GIT_DIR, GIT_WORK_TREE=3Dwt at root' '
+test_expect_success '#27: GIT_DIR, GIT_WORK_TREE=3Dwt at root' '
 	cat >27/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY/27/wt
@@ -3988,7 +3988,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/27/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/27/wt" test_repo 27
 '
=20
-test_expect_failure '#27: GIT_DIR(rel), GIT_WORK_TREE=3Dwt in subdir' =
'
+test_expect_success '#27: GIT_DIR(rel), GIT_WORK_TREE=3Dwt in subdir' =
'
 	cat >27/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY/27/wt
@@ -3998,7 +3998,7 @@ EOF
 	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/27/wt" test_re=
po 27/sub/sub
 '
=20
-test_expect_failure '#27: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) in sub=
dir' '
+test_expect_success '#27: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) in sub=
dir' '
 	cat >27/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY/27/wt
@@ -4008,7 +4008,7 @@ EOF
 	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../../wt test_repo 27/sub/sub
 '
=20
-test_expect_failure '#27: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) in subdir' =
'
+test_expect_success '#27: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) in subdir' =
'
 	cat >27/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY/27/wt
@@ -4018,7 +4018,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/27/.git" GIT_WORK_TREE=3D../../wt test_re=
po 27/sub/sub
 '
=20
-test_expect_failure '#27: GIT_DIR, GIT_WORK_TREE=3Dwt in subdir' '
+test_expect_success '#27: GIT_DIR, GIT_WORK_TREE=3Dwt in subdir' '
 	cat >27/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY/27/wt
@@ -4028,7 +4028,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/27/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/27/wt" test_repo 27/sub/sub
 '
=20
-test_expect_failure '#27: GIT_DIR(rel), GIT_WORK_TREE=3D.. at root' '
+test_expect_success '#27: GIT_DIR(rel), GIT_WORK_TREE=3D.. at root' '
 	cat >27/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY
@@ -4038,7 +4038,7 @@ EOF
 	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY" test_repo 27
 '
=20
-test_expect_failure '#27: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) at roo=
t' '
+test_expect_success '#27: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) at roo=
t' '
 	cat >27/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY
@@ -4048,7 +4048,7 @@ EOF
 	GIT_DIR=3D.git GIT_WORK_TREE=3D.. test_repo 27
 '
=20
-test_expect_failure '#27: GIT_DIR, GIT_WORK_TREE=3D..(rel) at root' '
+test_expect_success '#27: GIT_DIR, GIT_WORK_TREE=3D..(rel) at root' '
 	cat >27/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY
@@ -4058,7 +4058,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/27/.git" GIT_WORK_TREE=3D.. test_repo 27
 '
=20
-test_expect_failure '#27: GIT_DIR, GIT_WORK_TREE=3D.. at root' '
+test_expect_success '#27: GIT_DIR, GIT_WORK_TREE=3D.. at root' '
 	cat >27/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY
@@ -4068,7 +4068,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/27/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y" test_repo 27
 '
=20
-test_expect_failure '#27: GIT_DIR(rel), GIT_WORK_TREE=3D.. in subdir' =
'
+test_expect_success '#27: GIT_DIR(rel), GIT_WORK_TREE=3D.. in subdir' =
'
 	cat >27/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY
@@ -4078,7 +4078,7 @@ EOF
 	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY" test_repo 27/=
sub/sub
 '
=20
-test_expect_failure '#27: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) in sub=
dir' '
+test_expect_success '#27: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) in sub=
dir' '
 	cat >27/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY
@@ -4088,7 +4088,7 @@ EOF
 	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../../.. test_repo 27/sub/sub
 '
=20
-test_expect_failure '#27: GIT_DIR, GIT_WORK_TREE=3D..(rel) in subdir' =
'
+test_expect_success '#27: GIT_DIR, GIT_WORK_TREE=3D..(rel) in subdir' =
'
 	cat >27/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY
@@ -4098,7 +4098,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/27/.git" GIT_WORK_TREE=3D../../../ test_r=
epo 27/sub/sub
 '
=20
-test_expect_failure '#27: GIT_DIR, GIT_WORK_TREE=3D.. in subdir' '
+test_expect_success '#27: GIT_DIR, GIT_WORK_TREE=3D.. in subdir' '
 	cat >27/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/27.git
 setup: worktree: $TRASH_DIRECTORY
@@ -4186,7 +4186,7 @@ test_expect_success '#29: setup' '
 	cd ..
 '
=20
-test_expect_failure '#29: at root' '
+test_expect_success '#29: at root' '
 	cat >29/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/29.git
 setup: worktree: (null)
@@ -4196,7 +4196,7 @@ EOF
 	test_repo 29
 '
=20
-test_expect_failure '#29: in subdir' '
+test_expect_success '#29: in subdir' '
 	cat >29/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/29.git
 setup: worktree: (null)
@@ -4235,7 +4235,7 @@ test_expect_success '#30: setup' '
 	cd ..
 '
=20
-test_expect_failure '#30: at root' '
+test_expect_success '#30: at root' '
 	(
 	cd 30 &&
 	GIT_DIR=3D.git test_must_fail git symbolic-ref HEAD 2>result &&
@@ -4272,7 +4272,7 @@ test_expect_success '#31: setup' '
 	cd ..
 '
=20
-test_expect_failure '#31: GIT_DIR(rel), GIT_WORK_TREE=3Droot at root' =
'
+test_expect_success '#31: GIT_DIR(rel), GIT_WORK_TREE=3Droot at root' =
'
 	cat >31/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY/31
@@ -4282,7 +4282,7 @@ EOF
 	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/31" test_repo 31
 '
=20
-test_expect_failure '#31: GIT_DIR(rel), GIT_WORK_TREE=3Droot(rel) at r=
oot' '
+test_expect_success '#31: GIT_DIR(rel), GIT_WORK_TREE=3Droot(rel) at r=
oot' '
 	cat >31/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY/31
@@ -4292,7 +4292,7 @@ EOF
 	GIT_DIR=3D.git GIT_WORK_TREE=3D. test_repo 31
 '
=20
-test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3Droot at root' '
+test_expect_success '#31: GIT_DIR, GIT_WORK_TREE=3Droot at root' '
 	cat >31/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY/31
@@ -4302,7 +4302,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/31/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/31" test_repo 31
 '
=20
-test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3Droot(rel) at root' =
'
+test_expect_success '#31: GIT_DIR, GIT_WORK_TREE=3Droot(rel) at root' =
'
 	cat >31/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY/31
@@ -4312,7 +4312,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/31/.git" GIT_WORK_TREE=3D. test_repo 31
 '
=20
-test_expect_failure '#31: GIT_DIR(rel), GIT_WORKTREE=3Droot in subdir'=
 '
+test_expect_success '#31: GIT_DIR(rel), GIT_WORKTREE=3Droot in subdir'=
 '
 	cat >31/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY/31
@@ -4322,7 +4322,7 @@ EOF
 	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/31" test_repo =
31/sub/sub
 '
=20
-test_expect_failure '#31: GIT_DIR(rel), GIT_WORKTREE=3Droot(rel) in su=
bdir' '
+test_expect_success '#31: GIT_DIR(rel), GIT_WORKTREE=3Droot(rel) in su=
bdir' '
 	cat >31/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY/31
@@ -4332,7 +4332,7 @@ EOF
 	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../.. test_repo 31/sub/sub
 '
=20
-test_expect_failure '#31: GIT_DIR, GIT_WORKTREE=3Droot in subdir' '
+test_expect_success '#31: GIT_DIR, GIT_WORKTREE=3Droot in subdir' '
 	cat >31/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY/31
@@ -4342,7 +4342,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/31/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/31" test_repo 31/sub
 '
=20
-test_expect_failure '#31: GIT_DIR, GIT_WORKTREE=3Droot(rel) in subdir'=
 '
+test_expect_success '#31: GIT_DIR, GIT_WORKTREE=3Droot(rel) in subdir'=
 '
 	cat >31/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY/31
@@ -4352,7 +4352,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/31/.git" GIT_WORK_TREE=3D../.. test_repo =
31/sub/sub
 '
=20
-test_expect_failure '#31: GIT_DIR(rel), GIT_WORK_TREE=3Dwt at root' '
+test_expect_success '#31: GIT_DIR(rel), GIT_WORK_TREE=3Dwt at root' '
 	cat >31/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY/31/wt
@@ -4362,7 +4362,7 @@ EOF
 	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/31/wt" test_repo 31
 '
=20
-test_expect_failure '#31: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) at roo=
t' '
+test_expect_success '#31: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) at roo=
t' '
 	cat >31/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY/31/wt
@@ -4372,7 +4372,7 @@ EOF
 	GIT_DIR=3D.git GIT_WORK_TREE=3Dwt test_repo 31
 '
=20
-test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) at root' '
+test_expect_success '#31: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) at root' '
 	cat >31/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY/31/wt
@@ -4382,7 +4382,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/31/.git" GIT_WORK_TREE=3Dwt test_repo 31
 '
=20
-test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3Dwt at root' '
+test_expect_success '#31: GIT_DIR, GIT_WORK_TREE=3Dwt at root' '
 	cat >31/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY/31/wt
@@ -4392,7 +4392,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/31/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/31/wt" test_repo 31
 '
=20
-test_expect_failure '#31: GIT_DIR(rel), GIT_WORK_TREE=3Dwt in subdir' =
'
+test_expect_success '#31: GIT_DIR(rel), GIT_WORK_TREE=3Dwt in subdir' =
'
 	cat >31/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY/31/wt
@@ -4402,7 +4402,7 @@ EOF
 	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/31/wt" test_re=
po 31/sub/sub
 '
=20
-test_expect_failure '#31: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) in sub=
dir' '
+test_expect_success '#31: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) in sub=
dir' '
 	cat >31/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY/31/wt
@@ -4412,7 +4412,7 @@ EOF
 	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../../wt test_repo 31/sub/sub
 '
=20
-test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) in subdir' =
'
+test_expect_success '#31: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) in subdir' =
'
 	cat >31/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY/31/wt
@@ -4422,7 +4422,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/31/.git" GIT_WORK_TREE=3D../../wt test_re=
po 31/sub/sub
 '
=20
-test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3Dwt in subdir' '
+test_expect_success '#31: GIT_DIR, GIT_WORK_TREE=3Dwt in subdir' '
 	cat >31/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY/31/wt
@@ -4432,7 +4432,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/31/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/31/wt" test_repo 31/sub/sub
 '
=20
-test_expect_failure '#31: GIT_DIR(rel), GIT_WORK_TREE=3D.. at root' '
+test_expect_success '#31: GIT_DIR(rel), GIT_WORK_TREE=3D.. at root' '
 	cat >31/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY
@@ -4442,7 +4442,7 @@ EOF
 	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY" test_repo 31
 '
=20
-test_expect_failure '#31: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) at roo=
t' '
+test_expect_success '#31: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) at roo=
t' '
 	cat >31/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY
@@ -4452,7 +4452,7 @@ EOF
 	GIT_DIR=3D.git GIT_WORK_TREE=3D.. test_repo 31
 '
=20
-test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3D..(rel) at root' '
+test_expect_success '#31: GIT_DIR, GIT_WORK_TREE=3D..(rel) at root' '
 	cat >31/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY
@@ -4462,7 +4462,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/31/.git" GIT_WORK_TREE=3D.. test_repo 31
 '
=20
-test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3D.. at root' '
+test_expect_success '#31: GIT_DIR, GIT_WORK_TREE=3D.. at root' '
 	cat >31/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY
@@ -4472,7 +4472,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/31/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y" test_repo 31
 '
=20
-test_expect_failure '#31: GIT_DIR(rel), GIT_WORK_TREE=3D.. in subdir' =
'
+test_expect_success '#31: GIT_DIR(rel), GIT_WORK_TREE=3D.. in subdir' =
'
 	cat >31/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY
@@ -4482,7 +4482,7 @@ EOF
 	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY" test_repo 31/=
sub/sub
 '
=20
-test_expect_failure '#31: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) in sub=
dir' '
+test_expect_success '#31: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) in sub=
dir' '
 	cat >31/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY
@@ -4492,7 +4492,7 @@ EOF
 	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../../.. test_repo 31/sub/sub
 '
=20
-test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3D..(rel) in subdir' =
'
+test_expect_success '#31: GIT_DIR, GIT_WORK_TREE=3D..(rel) in subdir' =
'
 	cat >31/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY
@@ -4502,7 +4502,7 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/31/.git" GIT_WORK_TREE=3D../../../ test_r=
epo 31/sub/sub
 '
=20
-test_expect_failure '#31: GIT_DIR, GIT_WORK_TREE=3D.. in subdir' '
+test_expect_success '#31: GIT_DIR, GIT_WORK_TREE=3D.. in subdir' '
 	cat >31/sub/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/31.git
 setup: worktree: $TRASH_DIRECTORY
--=20
1.7.0.2.445.gcbdb3
