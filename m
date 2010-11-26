From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 06/47] t1510: setup case #3
Date: Fri, 26 Nov 2010 22:32:02 +0700
Message-ID: <1290785563-15339-7-git-send-email-pclouds@gmail.com>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 16:36:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM0LZ-0001kh-IL
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 16:36:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752160Ab0KZPgT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 10:36:19 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:53018 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394Ab0KZPgS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 10:36:18 -0500
Received: by pva4 with SMTP id 4so350945pva.19
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 07:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=4HTyEbMzLsGUjYx+iFBzjbHdqD4EJxVkEfqMK42V3hk=;
        b=kA1iZ1dljZ5hJncJODdEuz4fH6x0goN0G/JiXtwW8Vp8M1NCnZ1PByXBJ01PcATPq7
         UsUcMckF6WfzUXMmd/bEB7j4LrtX4SVxW9XG43/v9citNiN85RXnruG1sSVA1erG7L/b
         RoRVk8s+c9tBn7LOBOc4D8pu6n0pUv+msfgAk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=w5H+ue87Upy4bqHhURVaPMpd1HmJ9JAApGiQOoGAvw4zQUEGlekxUrntbG2D7yuz2B
         Rt0vbV3qDJbIeXWau0dplqb8YnqP6N+b6RUqA2oZTuRZqiHrU8ubMl9Lt8MMI1L6lRIw
         8jvXEI0nM1S+odFQJOCp9H5MnULqOZoFxV0Qs=
Received: by 10.142.51.4 with SMTP id y4mr2494416wfy.378.1290785778301;
        Fri, 26 Nov 2010 07:36:18 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.252.168])
        by mx.google.com with ESMTPS id v19sm2681009wfh.0.2010.11.26.07.36.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 07:36:17 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 26 Nov 2010 22:35:04 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
In-Reply-To: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162222>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |  267 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 267 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index febf9c4..9fff0b6 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -219,4 +219,271 @@ EOF
 	test_repo 2/sub ../.git
 '
=20
+#
+# case #3
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is set
+#  - GIT_DIR is set
+#  - core.worktree is not set
+#  - .git is a directory
+#  - core.bare is not set, cwd is outside .git
+#
+# Output:
+#
+#  - worktree is set to $GIT_WORK_TREE
+#  - cwd is at worktree root
+#  - prefix is calculated
+#  - git_dir is set to $GIT_DIR
+#  - cwd can be outside worktree
+
+test_expect_success '#3: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 3 3/sub 3/sub/sub 3.wt 3.wt/sub 3/wt 3/wt/sub &&
+	cd 3 && git init && cd ..
+'
+
+test_expect_success '#3: GIT_DIR(rel), GIT_WORK_TREE=3Droot at root' '
+	cat >3/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/3
+setup: cwd: $TRASH_DIRECTORY/3
+setup: prefix: (null)
+EOF
+	test_repo 3 .git "$TRASH_DIRECTORY/3"
+'
+
+test_expect_success '#3: GIT_DIR(rel), GIT_WORK_TREE=3Droot(rel) at ro=
ot' '
+	cat >3/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/3
+setup: cwd: $TRASH_DIRECTORY/3
+setup: prefix: (null)
+EOF
+	test_repo 3 .git .
+'
+
+test_expect_success '#3: GIT_DIR, GIT_WORK_TREE=3Droot at root' '
+	cat >3/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/3/.git
+setup: worktree: $TRASH_DIRECTORY/3
+setup: cwd: $TRASH_DIRECTORY/3
+setup: prefix: (null)
+EOF
+	test_repo 3 "$TRASH_DIRECTORY/3/.git" "$TRASH_DIRECTORY/3"
+'
+
+test_expect_success '#3: GIT_DIR, GIT_WORK_TREE=3Droot(rel) at root' '
+	cat >3/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/3/.git
+setup: worktree: $TRASH_DIRECTORY/3
+setup: cwd: $TRASH_DIRECTORY/3
+setup: prefix: (null)
+EOF
+	test_repo 3 "$TRASH_DIRECTORY/3/.git" .
+'
+
+test_expect_success '#3: GIT_DIR(rel), GIT_WORKTREE=3Droot in subdir' =
'
+	cat >3/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/3/.git
+setup: worktree: $TRASH_DIRECTORY/3
+setup: cwd: $TRASH_DIRECTORY/3
+setup: prefix: sub/sub/
+EOF
+	test_repo 3/sub/sub ../../.git "$TRASH_DIRECTORY/3"
+'
+
+test_expect_success '#3: GIT_DIR(rel), GIT_WORKTREE=3Droot(rel) in sub=
dir' '
+	cat >3/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/3/.git
+setup: worktree: $TRASH_DIRECTORY/3
+setup: cwd: $TRASH_DIRECTORY/3
+setup: prefix: sub/sub/
+EOF
+	test_repo 3/sub/sub ../../.git ../..
+'
+
+test_expect_success '#3: GIT_DIR, GIT_WORKTREE=3Droot in subdir' '
+	cat >3/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/3/.git
+setup: worktree: $TRASH_DIRECTORY/3
+setup: cwd: $TRASH_DIRECTORY/3
+setup: prefix: sub/
+EOF
+	test_repo 3/sub "$TRASH_DIRECTORY/3/.git" "$TRASH_DIRECTORY/3"
+'
+
+test_expect_success '#3: GIT_DIR, GIT_WORKTREE=3Droot(rel) in subdir' =
'
+	cat >3/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/3/.git
+setup: worktree: $TRASH_DIRECTORY/3
+setup: cwd: $TRASH_DIRECTORY/3
+setup: prefix: sub/sub/
+EOF
+	test_repo 3/sub/sub "$TRASH_DIRECTORY/3/.git" ../..
+'
+
+test_expect_success '#3: GIT_DIR(rel), GIT_WORK_TREE=3Dwt at root' '
+	cat >3/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/3/wt
+setup: cwd: $TRASH_DIRECTORY/3
+setup: prefix: (null)
+EOF
+	test_repo 3 .git "$TRASH_DIRECTORY/3/wt"
+'
+
+test_expect_success '#3: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) at root=
' '
+	cat >3/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/3/wt
+setup: cwd: $TRASH_DIRECTORY/3
+setup: prefix: (null)
+EOF
+	test_repo 3 .git wt
+'
+
+test_expect_success '#3: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) at root' '
+	cat >3/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/3/.git
+setup: worktree: $TRASH_DIRECTORY/3/wt
+setup: cwd: $TRASH_DIRECTORY/3
+setup: prefix: (null)
+EOF
+	test_repo 3 "$TRASH_DIRECTORY/3/.git" wt
+'
+
+test_expect_success '#3: GIT_DIR, GIT_WORK_TREE=3Dwt at root' '
+	cat >3/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/3/.git
+setup: worktree: $TRASH_DIRECTORY/3/wt
+setup: cwd: $TRASH_DIRECTORY/3
+setup: prefix: (null)
+EOF
+	test_repo 3 "$TRASH_DIRECTORY/3/.git" "$TRASH_DIRECTORY/3/wt"
+'
+
+test_expect_success '#3: GIT_DIR(rel), GIT_WORK_TREE=3Dwt in subdir' '
+	cat >3/sub/sub/expected <<EOF &&
+setup: git_dir: ../../.git
+setup: worktree: $TRASH_DIRECTORY/3/wt
+setup: cwd: $TRASH_DIRECTORY/3/sub/sub
+setup: prefix: (null)
+EOF
+	test_repo 3/sub/sub ../../.git "$TRASH_DIRECTORY/3/wt"
+'
+
+test_expect_success '#3: GIT_DIR(rel), GIT_WORK_TREE=3Dwt(rel) in subd=
ir' '
+	cat >3/sub/sub/expected <<EOF &&
+setup: git_dir: ../../.git
+setup: worktree: $TRASH_DIRECTORY/3/wt
+setup: cwd: $TRASH_DIRECTORY/3/sub/sub
+setup: prefix: (null)
+EOF
+	test_repo 3/sub/sub ../../.git ../../wt
+'
+
+test_expect_success '#3: GIT_DIR, GIT_WORK_TREE=3Dwt(rel) in subdir' '
+	cat >3/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/3/.git
+setup: worktree: $TRASH_DIRECTORY/3/wt
+setup: cwd: $TRASH_DIRECTORY/3/sub/sub
+setup: prefix: (null)
+EOF
+	test_repo 3/sub/sub "$TRASH_DIRECTORY/3/.git" ../../wt
+'
+
+test_expect_success '#3: GIT_DIR, GIT_WORK_TREE=3Dwt in subdir' '
+	cat >3/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/3/.git
+setup: worktree: $TRASH_DIRECTORY/3/wt
+setup: cwd: $TRASH_DIRECTORY/3/sub/sub
+setup: prefix: (null)
+EOF
+	test_repo 3/sub/sub "$TRASH_DIRECTORY/3/.git" "$TRASH_DIRECTORY/3/wt"
+'
+
+test_expect_success '#3: GIT_DIR(rel), GIT_WORK_TREE=3D.. at root' '
+	cat >3/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/3/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 3/
+EOF
+	test_repo 3 .git "$TRASH_DIRECTORY"
+'
+
+test_expect_success '#3: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) at root=
' '
+	cat >3/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/3/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 3/
+EOF
+	test_repo 3 .git ..
+'
+
+test_expect_success '#3: GIT_DIR, GIT_WORK_TREE=3D..(rel) at root' '
+	cat >3/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/3/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 3/
+EOF
+	test_repo 3 "$TRASH_DIRECTORY/3/.git" ..
+'
+
+test_expect_success '#3: GIT_DIR, GIT_WORK_TREE=3D.. at root' '
+	cat >3/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/3/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 3/
+EOF
+	test_repo 3 "$TRASH_DIRECTORY/3/.git" "$TRASH_DIRECTORY"
+'
+
+test_expect_success '#3: GIT_DIR(rel), GIT_WORK_TREE=3D.. in subdir' '
+	cat >3/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/3/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 3/sub/sub/
+EOF
+	test_repo 3/sub/sub ../../.git "$TRASH_DIRECTORY"
+'
+
+test_expect_success '#3: GIT_DIR(rel), GIT_WORK_TREE=3D..(rel) in subd=
ir' '
+	cat >3/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/3/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 3/sub/sub/
+EOF
+	test_repo 3/sub/sub ../../.git ../../..
+'
+
+test_expect_success '#3: GIT_DIR, GIT_WORK_TREE=3D..(rel) in subdir' '
+	cat >3/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/3/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 3/sub/sub/
+EOF
+	test_repo 3/sub/sub "$TRASH_DIRECTORY/3/.git" ../../../
+'
+
+test_expect_success '#3: GIT_DIR, GIT_WORK_TREE=3D.. in subdir' '
+	cat >3/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/3/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 3/sub/sub/
+EOF
+	test_repo 3/sub/sub "$TRASH_DIRECTORY/3/.git" "$TRASH_DIRECTORY"
+'
+
 test_done
--=20
1.7.3.2.316.gda8b3
