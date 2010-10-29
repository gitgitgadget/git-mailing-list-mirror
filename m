From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 26/42] t1510: setup case #23
Date: Fri, 29 Oct 2010 13:48:38 +0700
Message-ID: <1288334934-17216-27-git-send-email-pclouds@gmail.com>
References: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 08:52:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBipU-000772-FD
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 08:52:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933284Ab0J2Gwi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 02:52:38 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64522 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754594Ab0J2Gwh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 02:52:37 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so692674pwj.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 23:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=PASBHX6rYwokyAHTWh1dpSLLZY2PT+S1TPfcMNR8U2o=;
        b=lxfv/3BCWPMiANfNO3u4i44SlvlJSE7zgwRl0AnGbrc5N6kegfVZ45XrA4L9bjPfOe
         924atfxx34I1gPcHP9nSXIw7pq2TdTDruAtpvrQXxrOfSWcjutCiIvra+KHM7j2IN4QT
         njsYiYvzTmmSk2oVEUi1Y1dMwXMOYoGU7ASjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=X9XiZVfKeKpNG5ym9cXtlHsjFzSoIXfYFkf3Zkal7KGM2H3Fza/TER9vO6+3aUjET5
         dbM1ENTGnF2+QlOyBvD+3LHbRR7IASsxXBuzllJbM9EQ/lNkf1DHFbTyI/EsNTdXNdnW
         U4+eOnrklgoOaZsLA4ST7YWoypWQWHzAqAm+0=
Received: by 10.142.180.4 with SMTP id c4mr972358wff.146.1288335156947;
        Thu, 28 Oct 2010 23:52:36 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id w26sm1020626wfd.21.2010.10.28.23.52.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 23:52:35 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 29 Oct 2010 13:52:36 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160295>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |  267 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 267 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index a7b6833..f699546 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -3408,4 +3408,271 @@ test_expect_failure '#22.2: at root' '
 	)
 '
=20
+#
+# case #23
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is set
+#  - GIT_DIR is set
+#  - core.worktree is set
+#  - .git is a directory
+#  - core.bare is set
+#
+# Output:
+#
+# core.worktree is overridden by GIT_WORK_TREE -> #19
+
+test_expect_success '#23: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 23 23/sub 23/sub/sub 23.wt 23.wt/sub 23/wt 23/wt/sub &&
+	cd 23 &&
+	git init &&
+	git config core.bare true &&
+	git config core.worktree non-existent &&
+	cd ..
+'
+
+test_expect_success '#23: GIT_DIR(rel), GIT_WORK_TREE=3Droot at root' =
'
+	cat >23/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/23
+setup: cwd: $TRASH_DIRECTORY/23
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/23" test_repo 23
+'
+
+test_expect_success '#23: GIT_DIR(rel), GIT_WORK_TREE=3Droot(rel) at r=
oot' '
+	cat >23/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/23
+setup: cwd: $TRASH_DIRECTORY/23
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D. test_repo 23
+'
+
+test_expect_success '#23: GIT_DIR, GIT_WORK_TREE=3Droot at root' '
+	cat >23/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/23/.git
+setup: worktree: $TRASH_DIRECTORY/23
+setup: cwd: $TRASH_DIRECTORY/23
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/23/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/23" test_repo 23
+'
+
+test_expect_success '#23: GIT_DIR, GIT_WORK_TREE=3Droot(rel) at root' =
'
+	cat >23/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/23/.git
+setup: worktree: $TRASH_DIRECTORY/23
+setup: cwd: $TRASH_DIRECTORY/23
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/23/.git" GIT_WORK_TREE=3D. test_repo 23
+'
+
+test_expect_success '#23: GIT_DIR(rel), GIT_WORKTREE=3Droot in subdir'=
 '
+	cat >23/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/23/.git
+setup: worktree: $TRASH_DIRECTORY/23
+setup: cwd: $TRASH_DIRECTORY/23
+setup: prefix: sub/sub/
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/23" test_repo =
23/sub/sub
+'
+
+test_expect_success '#23: GIT_DIR(rel), GIT_WORKTREE=3Droot(rel) in su=
bdir' '
+	cat >23/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/23/.git
+setup: worktree: $TRASH_DIRECTORY/23
+setup: cwd: $TRASH_DIRECTORY/23
+setup: prefix: sub/sub/
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../.. test_repo 23/sub/sub
+'
+
+test_expect_success '#23: GIT_DIR, GIT_WORKTREE=3Droot in subdir' '
+	cat >23/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/23/.git
+setup: worktree: $TRASH_DIRECTORY/23
+setup: cwd: $TRASH_DIRECTORY/23
+setup: prefix: sub/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/23/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/23" test_repo 23/sub
+'
+
+test_expect_success '#23: GIT_DIR, GIT_WORKTREE=3Droot(rel) in subdir'=
 '
+	cat >23/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/23/.git
+setup: worktree: $TRASH_DIRECTORY/23
+setup: cwd: $TRASH_DIRECTORY/23
+setup: prefix: sub/sub/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/23/.git" GIT_WORK_TREE=3D../.. test_repo =
23/sub/sub
+'
+
+test_expect_success '#23: GIT_DIR(rel), GIT_WORK_TREE=3Dwt at root' '
+	cat >23/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/23/wt
+setup: cwd: $TRASH_DIRECTORY/23
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/23/wt" test_repo 23
+'
+
+test_expect_success '#23: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) at roo=
t' '
+	cat >23/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/23/wt
+setup: cwd: $TRASH_DIRECTORY/23
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3Dwt test_repo 23
+'
+
+test_expect_success '#23: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) at root' '
+	cat >23/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/23/.git
+setup: worktree: $TRASH_DIRECTORY/23/wt
+setup: cwd: $TRASH_DIRECTORY/23
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/23/.git" GIT_WORK_TREE=3Dwt test_repo 23
+'
+
+test_expect_success '#23: GIT_DIR, GIT_WORK_TREE=3Dwt at root' '
+	cat >23/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/23/.git
+setup: worktree: $TRASH_DIRECTORY/23/wt
+setup: cwd: $TRASH_DIRECTORY/23
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/23/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/23/wt" test_repo 23
+'
+
+test_expect_success '#23: GIT_DIR(rel), GIT_WORK_TREE=3Dwt in subdir' =
'
+	cat >23/sub/sub/expected <<EOF &&
+setup: git_dir: ../../.git
+setup: worktree: $TRASH_DIRECTORY/23/wt
+setup: cwd: $TRASH_DIRECTORY/23/sub/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY/23/wt" test_re=
po 23/sub/sub
+'
+
+test_expect_success '#23: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) in sub=
dir' '
+	cat >23/sub/sub/expected <<EOF &&
+setup: git_dir: ../../.git
+setup: worktree: $TRASH_DIRECTORY/23/wt
+setup: cwd: $TRASH_DIRECTORY/23/sub/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../../wt test_repo 23/sub/sub
+'
+
+test_expect_success '#23: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) in subdir' =
'
+	cat >23/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/23/.git
+setup: worktree: $TRASH_DIRECTORY/23/wt
+setup: cwd: $TRASH_DIRECTORY/23/sub/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/23/.git" GIT_WORK_TREE=3D../../wt test_re=
po 23/sub/sub
+'
+
+test_expect_success '#23: GIT_DIR, GIT_WORK_TREE=3Dwt in subdir' '
+	cat >23/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/23/.git
+setup: worktree: $TRASH_DIRECTORY/23/wt
+setup: cwd: $TRASH_DIRECTORY/23/sub/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/23/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y/23/wt" test_repo 23/sub/sub
+'
+
+test_expect_success '#23: GIT_DIR(rel), GIT_WORK_TREE=3D.. at root' '
+	cat >23/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/23/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 23/
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY" test_repo 23
+'
+
+test_expect_success '#23: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) at roo=
t' '
+	cat >23/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/23/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 23/
+EOF
+	GIT_DIR=3D.git GIT_WORK_TREE=3D.. test_repo 23
+'
+
+test_expect_success '#23: GIT_DIR, GIT_WORK_TREE=3D..(rel) at root' '
+	cat >23/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/23/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 23/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/23/.git" GIT_WORK_TREE=3D.. test_repo 23
+'
+
+test_expect_success '#23: GIT_DIR, GIT_WORK_TREE=3D.. at root' '
+	cat >23/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/23/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 23/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/23/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y" test_repo 23
+'
+
+test_expect_success '#23: GIT_DIR(rel), GIT_WORK_TREE=3D.. in subdir' =
'
+	cat >23/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/23/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 23/sub/sub/
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D"$TRASH_DIRECTORY" test_repo 23/=
sub/sub
+'
+
+test_expect_success '#23: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) in sub=
dir' '
+	cat >23/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/23/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 23/sub/sub/
+EOF
+	GIT_DIR=3D../../.git GIT_WORK_TREE=3D../../.. test_repo 23/sub/sub
+'
+
+test_expect_success '#23: GIT_DIR, GIT_WORK_TREE=3D..(rel) in subdir' =
'
+	cat >23/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/23/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 23/sub/sub/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/23/.git" GIT_WORK_TREE=3D../../../ test_r=
epo 23/sub/sub
+'
+
+test_expect_success '#23: GIT_DIR, GIT_WORK_TREE=3D.. in subdir' '
+	cat >23/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/23/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 23/sub/sub/
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/23/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y" test_repo 23/sub/sub
+'
+
 test_done
--=20
1.7.0.2.445.gcbdb3
