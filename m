From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 17/42] t1510: setup case #14
Date: Fri, 29 Oct 2010 13:48:29 +0700
Message-ID: <1288334934-17216-18-git-send-email-pclouds@gmail.com>
References: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 08:51:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBioL-0006Vy-Fe
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 08:51:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932815Ab0J2Gvc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 02:51:32 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64522 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932320Ab0J2Gvb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 02:51:31 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so692674pwj.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 23:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=WwWoytBYdGmozSCnrqGhwsJGlXr5OhQlK2HLithJEEc=;
        b=nCpOWREqYJsYZiSwmMX7nZw2sOoWlIBsV9tUDLMdmDrw9wyOsMnqaMID9Y3st3WA4M
         pLC+rvwBn2xNO0TphbwTt+1iljoFIPf7Kopup3KGF5iUPnhjPXuB0u7O+shgmXeybrsu
         Xu/RLeDVQovWISakOWURxFq5UQJKJjWTRcV1k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=XQuapXDN2bnCc4JXs1zdiyjjus8e82BxPw4mevR07Fp0h0Q8eY/4GKLIPJjjl2qStk
         +y8HoV6A3td0++E0kAqRwX0FJflJBj+WOSCdV0ICMiMoX70r9C6NQZ0anZUDVk1kSrUh
         uNilY3RdlBKf7tjVdRxjNQ/ME1dDbJmg1mNOY=
Received: by 10.142.217.14 with SMTP id p14mr1044670wfg.334.1288335090907;
        Thu, 28 Oct 2010 23:51:30 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id x35sm1027088wfd.13.2010.10.28.23.51.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 23:51:29 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 29 Oct 2010 13:51:29 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160285>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |  291 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 291 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index fd63ad4..c14ba8a 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -1659,4 +1659,295 @@ EOF
 	test_repo 13/sub
 '
=20
+#
+# case #14
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is not set
+#  - GIT_DIR is set
+#  - core.worktree is set
+#  - .git is a file
+#  - core.bare is not set, cwd is outside .git
+#
+# Output:
+#
+# #6 except that git_dir is set by .git file
+
+test_expect_success '#14: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 14 14/sub 14/sub/sub 14.wt 14.wt/sub 14/wt 14/wt/sub &&
+	cd 14 &&
+	git init &&
+	mv .git ../14.git &&
+	echo gitdir: ../14.git >.git &&
+	cd ..
+'
+
+test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D../14 at root'=
 '
+	cat >14/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY/14
+setup: cwd: $TRASH_DIRECTORY/14
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree "$=
TRASH_DIRECTORY/14" &&
+	GIT_DIR=3D.git test_repo 14
+'
+
+test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D../14(rel) at =
root' '
+	cat >14/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY/14
+setup: cwd: $TRASH_DIRECTORY/14
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree ..=
/14 &&
+	GIT_DIR=3D.git test_repo 14
+'
+
+test_expect_failure '#14: GIT_DIR, core.worktree=3D../14 at root' '
+	cat >14/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY/14
+setup: cwd: $TRASH_DIRECTORY/14
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree "$=
TRASH_DIRECTORY/14" &&
+	GIT_DIR=3D"$TRASH_DIRECTORY/14/.git" test_repo 14
+'
+
+test_expect_failure '#14: GIT_DIR, core.worktree=3D../14(rel) at root'=
 '
+	cat >14/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY/14
+setup: cwd: $TRASH_DIRECTORY/14
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree ..=
/14 &&
+	GIT_DIR=3D"$TRASH_DIRECTORY/14/.git" test_repo 14
+'
+
+test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D../14 in subdi=
r' '
+	cat >14/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY/14
+setup: cwd: $TRASH_DIRECTORY/14
+setup: prefix: sub/sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree "$=
TRASH_DIRECTORY/14" &&
+	GIT_DIR=3D../../.git test_repo 14/sub/sub
+'
+
+test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D../14(rel) in =
subdir' '
+	cat >14/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY/14
+setup: cwd: $TRASH_DIRECTORY/14
+setup: prefix: sub/sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree ..=
/14 &&
+	GIT_DIR=3D../../.git test_repo 14/sub/sub
+'
+
+test_expect_failure '#14: GIT_DIR, core.worktree=3D../14 in subdir' '
+	cat >14/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY/14
+setup: cwd: $TRASH_DIRECTORY/14
+setup: prefix: sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree "$=
TRASH_DIRECTORY/14" &&
+	GIT_DIR=3D"$TRASH_DIRECTORY/14/.git" test_repo 14/sub
+'
+
+test_expect_failure '#14: GIT_DIR, core.worktree=3D../14(rel) in subdi=
r' '
+	cat >14/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY/14
+setup: cwd: $TRASH_DIRECTORY/14
+setup: prefix: sub/sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree ..=
/14 &&
+	GIT_DIR=3D"$TRASH_DIRECTORY/14/.git" test_repo 14/sub/sub
+'
+
+test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D../14/wt at ro=
ot' '
+	cat >14/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY/14/wt
+setup: cwd: $TRASH_DIRECTORY/14
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree "$=
TRASH_DIRECTORY/14/wt" &&
+	GIT_DIR=3D.git test_repo 14
+'
+
+test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D../14/wt(rel) =
at root' '
+	cat >14/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY/14/wt
+setup: cwd: $TRASH_DIRECTORY/14
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree ..=
/14/wt &&
+	GIT_DIR=3D.git test_repo 14
+'
+
+test_expect_failure '#14: GIT_DIR, core.worktree=3D../14/wt(rel) at ro=
ot' '
+	cat >14/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY/14/wt
+setup: cwd: $TRASH_DIRECTORY/14
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree ..=
/14/wt &&
+	GIT_DIR=3D"$TRASH_DIRECTORY/14/.git" test_repo 14
+'
+
+test_expect_failure '#14: GIT_DIR, core.worktree=3D../14/wt at root' '
+	cat >14/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY/14/wt
+setup: cwd: $TRASH_DIRECTORY/14
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree "$=
TRASH_DIRECTORY/14/wt" &&
+	GIT_DIR=3D"$TRASH_DIRECTORY/14/.git" test_repo 14
+'
+
+test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D../14/wt in su=
bdir' '
+	cat >14/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY/14/wt
+setup: cwd: $TRASH_DIRECTORY/14/sub/sub
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree "$=
TRASH_DIRECTORY/14/wt" &&
+	GIT_DIR=3D../../.git test_repo 14/sub/sub
+'
+
+test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D../14/wt(rel) =
in subdir' '
+	cat >14/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY/14/wt
+setup: cwd: $TRASH_DIRECTORY/14/sub/sub
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree ..=
/14/wt &&
+	GIT_DIR=3D../../.git test_repo 14/sub/sub
+'
+
+test_expect_failure '#14: GIT_DIR, core.worktree=3D../14/wt(rel) in su=
bdir' '
+	cat >14/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY/14/wt
+setup: cwd: $TRASH_DIRECTORY/14/sub/sub
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree ..=
/14/wt &&
+	GIT_DIR=3D"$TRASH_DIRECTORY/14/.git" test_repo 14/sub/sub
+'
+
+test_expect_failure '#14: GIT_DIR, core.worktree=3D../14/wt in subdir'=
 '
+	cat >14/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY/14/wt
+setup: cwd: $TRASH_DIRECTORY/14/sub/sub
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree "$=
TRASH_DIRECTORY/14/wt" &&
+	GIT_DIR=3D"$TRASH_DIRECTORY/14/.git" test_repo 14/sub/sub
+'
+
+test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D.. at root' '
+	cat >14/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 14/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree "$=
TRASH_DIRECTORY" &&
+	GIT_DIR=3D.git test_repo 14
+'
+
+test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D..(rel) at roo=
t' '
+	cat >14/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 14/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree ..=
 &&
+	GIT_DIR=3D.git test_repo 14
+'
+
+test_expect_failure '#14: GIT_DIR, core.worktree=3D..(rel) at root' '
+	cat >14/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 14/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree ..=
 &&
+	GIT_DIR=3D"$TRASH_DIRECTORY/14/.git" test_repo 14
+'
+
+test_expect_failure '#14: GIT_DIR, core.worktree=3D.. at root' '
+	cat >14/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 14/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree "$=
TRASH_DIRECTORY" &&
+	GIT_DIR=3D"$TRASH_DIRECTORY/14/.git" test_repo 14
+'
+
+test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D.. in subdir' =
'
+	cat >14/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 14/sub/sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree "$=
TRASH_DIRECTORY" &&
+	GIT_DIR=3D../../.git test_repo 14/sub/sub
+'
+
+test_expect_failure '#14: GIT_DIR(rel), core.worktree=3D..(rel) in sub=
dir' '
+	cat >14/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 14/sub/sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree ..=
 &&
+	GIT_DIR=3D../../.git test_repo 14/sub/sub
+'
+
+test_expect_failure '#14: GIT_DIR, core.worktree=3D..(rel) in subdir' =
'
+	cat >14/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 14/sub/sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree ..=
 &&
+	GIT_DIR=3D"$TRASH_DIRECTORY/14/.git" test_repo 14/sub/sub
+'
+
+test_expect_failure '#14: GIT_DIR, core.worktree=3D.. in subdir' '
+	cat >14/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/14.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 14/sub/sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/14.git/config" core.worktree "$=
TRASH_DIRECTORY" &&
+	GIT_DIR=3D"$TRASH_DIRECTORY/14/.git" test_repo 14/sub/sub
+'
+
 test_done
--=20
1.7.0.2.445.gcbdb3
