From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 25/42] t1510: setup case #22
Date: Fri, 29 Oct 2010 13:48:37 +0700
Message-ID: <1288334934-17216-26-git-send-email-pclouds@gmail.com>
References: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 08:52:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBipL-00073z-5r
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 08:52:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933275Ab0J2Gwa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 02:52:30 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64522 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754594Ab0J2Gw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 02:52:29 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so692674pwj.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 23:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=jU2QbTO0Q9H4fbh80J4kCDyIj/oPicdUNi4rDKtZLVI=;
        b=KrI/0FN4qGM4W5kpUskG7Yz5qmIzOnJYJytLsvqP90bUS3mw34KNPR/AWwlI5/T5Du
         sZDC0xWbVQ1v0tNkWOvI/PrbyIONZ/bWvSmyFuVNMtEugrFKDeWpn9v6YsIdWvQgAJ4V
         6gGFHidEjBx8JwYnMNRi295IXO2JFxLHW7yO0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Mb10pyvDd3Fx+MwRyku1B0wI/YMhtBw8Tp22j4ZcsR7dy7lT8Pt41YEF1XCfEmmlrM
         lqa7vP5S5WmucJPu3C8Z1C2vJJAHO6jlazyJ++joayvh7dt7ObbL+2EGUBvri/JreZxW
         V/MwXa51I0OTtj+oj5BHxzMftbrMDxbXOCJ0Y=
Received: by 10.142.112.14 with SMTP id k14mr1001720wfc.420.1288335149490;
        Thu, 28 Oct 2010 23:52:29 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id x35sm1029204wfd.13.2010.10.28.23.52.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 23:52:28 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 29 Oct 2010 13:52:28 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160293>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |  333 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 333 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 8d67514..a7b6833 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -3075,4 +3075,337 @@ EOF
 	test_repo 21/sub
 '
=20
+#
+# case #22.1
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is not set
+#  - GIT_DIR is set
+#  - core.worktree is set
+#  - .git is a directory
+#  - cwd is inside .git
+#
+# Output:
+#
+# bare attribute is ignored
+#
+#  - worktree is at core.worktree
+#  - cwd is at worktree root
+#  - prefix is calculated
+#  - git_dir is at $GIT_DIR
+#  - cwd can be outside worktree
+
+test_expect_success '#22.1: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 22 &&
+	cd 22 &&
+	git init &&
+	mkdir .git/sub .git/wt .git/wt/sub &&
+	cd ..
+'
+
+test_expect_success '#22.1: GIT_DIR(rel), core.worktree=3D. at .git' '
+	cat >22/.git/expected <<EOF &&
+setup: git_dir: .
+setup: worktree: $TRASH_DIRECTORY/22/.git
+setup: cwd: $TRASH_DIRECTORY/22/.git
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/22/.git/config" core.worktree "=
$TRASH_DIRECTORY/22/.git" &&
+	GIT_DIR=3D. test_repo 22/.git
+'
+
+test_expect_success '#22.1: GIT_DIR(rel), core.worktree=3D.(rel) at .g=
it' '
+	cat >22/.git/expected <<EOF &&
+setup: git_dir: .
+setup: worktree: $TRASH_DIRECTORY/22/.git
+setup: cwd: $TRASH_DIRECTORY/22/.git
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/22/.git/config" core.worktree .=
 &&
+	GIT_DIR=3D. test_repo 22/.git
+'
+
+test_expect_success '#22.1: GIT_DIR, core.worktree=3D. at .git' '
+	cat >22/.git/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/22/.git
+setup: worktree: $TRASH_DIRECTORY/22/.git
+setup: cwd: $TRASH_DIRECTORY/22/.git
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/22/.git/config" core.worktree "=
$TRASH_DIRECTORY/22/.git" &&
+	GIT_DIR=3D"$TRASH_DIRECTORY/22/.git" test_repo 22/.git
+'
+
+test_expect_success '#22.1: GIT_DIR, core.worktree=3D.(rel) at root' '
+	cat >22/.git/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/22/.git
+setup: worktree: $TRASH_DIRECTORY/22/.git
+setup: cwd: $TRASH_DIRECTORY/22/.git
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/22/.git/config" core.worktree .=
 &&
+	GIT_DIR=3D"$TRASH_DIRECTORY/22/.git" test_repo 22/.git
+'
+
+test_expect_failure '#22.1: GIT_DIR(rel), core.worktree=3D. in .git/su=
b' '
+	cat >22/.git/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/22/.git
+setup: worktree: $TRASH_DIRECTORY/22/.git
+setup: cwd: $TRASH_DIRECTORY/22/.git
+setup: prefix: sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/22/.git/config" core.worktree "=
$TRASH_DIRECTORY/22/.git" &&
+	GIT_DIR=3D.. test_repo 22/.git/sub
+'
+
+test_expect_failure '#22.1: GIT_DIR(rel), core.worktree=3D.(rel) in .g=
it/sub' '
+	cat >22/.git/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/22/.git
+setup: worktree: $TRASH_DIRECTORY/22/.git
+setup: cwd: $TRASH_DIRECTORY/22/.git
+setup: prefix: sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/22/.git/config" core.worktree .=
 &&
+	GIT_DIR=3D.. test_repo 22/.git/sub/
+'
+
+test_expect_success '#22.1: GIT_DIR, core.worktree=3D. in .git/sub' '
+	cat >22/.git/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/22/.git
+setup: worktree: $TRASH_DIRECTORY/22/.git
+setup: cwd: $TRASH_DIRECTORY/22/.git
+setup: prefix: sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/22/.git/config" core.worktree "=
$TRASH_DIRECTORY/22/.git" &&
+	GIT_DIR=3D"$TRASH_DIRECTORY/22/.git" test_repo 22/.git/sub
+'
+
+test_expect_success '#22.1: GIT_DIR, core.worktree=3D.(rel) in .git/su=
b' '
+	cat >22/.git/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/22/.git
+setup: worktree: $TRASH_DIRECTORY/22/.git
+setup: cwd: $TRASH_DIRECTORY/22/.git
+setup: prefix: sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/22/.git/config" core.worktree .=
 &&
+	GIT_DIR=3D"$TRASH_DIRECTORY/22/.git" test_repo 22/.git/sub
+'
+
+test_expect_success '#22.1: GIT_DIR(rel), core.worktree=3Dwt at .git' =
'
+	cat >22/.git/expected <<EOF &&
+setup: git_dir: .
+setup: worktree: $TRASH_DIRECTORY/22/.git/wt
+setup: cwd: $TRASH_DIRECTORY/22/.git
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/22/.git/config" core.worktree "=
$TRASH_DIRECTORY/22/.git/wt" &&
+	GIT_DIR=3D. test_repo 22/.git
+'
+
+test_expect_success '#22.1: GIT_DIR(rel), core.worktree=3Dwt(rel) at .=
git' '
+	cat >22/.git/expected <<EOF &&
+setup: git_dir: .
+setup: worktree: $TRASH_DIRECTORY/22/.git/wt
+setup: cwd: $TRASH_DIRECTORY/22/.git
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/22/.git/config" core.worktree w=
t &&
+	GIT_DIR=3D. test_repo 22/.git
+'
+
+test_expect_success '#22.1: GIT_DIR, core.worktree=3Dwt(rel) at .git' =
'
+	cat >22/.git/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/22/.git
+setup: worktree: $TRASH_DIRECTORY/22/.git/wt
+setup: cwd: $TRASH_DIRECTORY/22/.git
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/22/.git/config" core.worktree w=
t &&
+	GIT_DIR=3D"$TRASH_DIRECTORY/22/.git" test_repo 22/.git
+'
+
+test_expect_success '#22.1: GIT_DIR, core.worktree=3Dwt at .git' '
+	cat >22/.git/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/22/.git
+setup: worktree: $TRASH_DIRECTORY/22/.git/wt
+setup: cwd: $TRASH_DIRECTORY/22/.git
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/22/.git/config" core.worktree "=
$TRASH_DIRECTORY/22/.git/wt" &&
+	GIT_DIR=3D"$TRASH_DIRECTORY/22/.git" test_repo 22/.git
+'
+
+test_expect_success '#22.1: GIT_DIR(rel), core.worktree=3Dwt in .git/s=
ub' '
+	cat >22/.git/sub/expected <<EOF &&
+setup: git_dir: ..
+setup: worktree: $TRASH_DIRECTORY/22/.git/wt
+setup: cwd: $TRASH_DIRECTORY/22/.git/sub
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/22/.git/config" core.worktree "=
$TRASH_DIRECTORY/22/.git/wt" &&
+	GIT_DIR=3D.. test_repo 22/.git/sub
+'
+
+test_expect_success '#22.1: GIT_DIR(rel), core.worktree=3Dwt(rel) in .=
git/sub' '
+	cat >22/.git/sub/expected <<EOF &&
+setup: git_dir: ..
+setup: worktree: $TRASH_DIRECTORY/22/.git/wt
+setup: cwd: $TRASH_DIRECTORY/22/.git/sub
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/22/.git/config" core.worktree w=
t &&
+	GIT_DIR=3D.. test_repo 22/.git/sub
+'
+
+test_expect_success '#22.1: GIT_DIR, core.worktree=3Dwt(rel) in .git/s=
ub' '
+	cat >22/.git/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/22/.git
+setup: worktree: $TRASH_DIRECTORY/22/.git/wt
+setup: cwd: $TRASH_DIRECTORY/22/.git/sub
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/22/.git/config" core.worktree w=
t &&
+	GIT_DIR=3D"$TRASH_DIRECTORY/22/.git" test_repo 22/.git/sub
+'
+
+test_expect_success '#22.1: GIT_DIR, core.worktree=3Dwt in .git/sub' '
+	cat >22/.git/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/22/.git
+setup: worktree: $TRASH_DIRECTORY/22/.git/wt
+setup: cwd: $TRASH_DIRECTORY/22/.git/sub
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/22/.git/config" core.worktree "=
$TRASH_DIRECTORY/22/.git/wt" &&
+	GIT_DIR=3D"$TRASH_DIRECTORY/22/.git" test_repo 22/.git/sub
+'
+
+test_expect_failure '#22.1: GIT_DIR(rel), core.worktree=3D.. at .git' =
'
+	cat >22/.git/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/22/.git
+setup: worktree: $TRASH_DIRECTORY/22
+setup: cwd: $TRASH_DIRECTORY/22
+setup: prefix: .git/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/22/.git/config" core.worktree "=
$TRASH_DIRECTORY/22" &&
+	GIT_DIR=3D. test_repo 22/.git
+'
+
+test_expect_failure '#22.1: GIT_DIR(rel), core.worktree=3D..(rel) at .=
git' '
+	cat >22/.git/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/22/.git
+setup: worktree: $TRASH_DIRECTORY/22
+setup: cwd: $TRASH_DIRECTORY/22
+setup: prefix: .git/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/22/.git/config" core.worktree .=
=2E &&
+	GIT_DIR=3D. test_repo 22/.git
+'
+
+test_expect_success '#22.1: GIT_DIR, core.worktree=3D..(rel) at .git' =
'
+	cat >22/.git/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/22/.git
+setup: worktree: $TRASH_DIRECTORY/22
+setup: cwd: $TRASH_DIRECTORY/22
+setup: prefix: .git/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/22/.git/config" core.worktree .=
=2E &&
+	GIT_DIR=3D"$TRASH_DIRECTORY/22/.git" test_repo 22/.git
+'
+
+test_expect_success '#22.1: GIT_DIR, core.worktree=3D.. at .git' '
+	cat >22/.git/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/22/.git
+setup: worktree: $TRASH_DIRECTORY/22
+setup: cwd: $TRASH_DIRECTORY/22
+setup: prefix: .git/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/22/.git/config" core.worktree "=
$TRASH_DIRECTORY/22" &&
+	GIT_DIR=3D"$TRASH_DIRECTORY/22/.git" test_repo 22/.git
+'
+
+test_expect_failure '#22.1: GIT_DIR(rel), core.worktree=3D.. in .git/s=
ub' '
+	cat >22/.git/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/22/.git
+setup: worktree: $TRASH_DIRECTORY/22
+setup: cwd: $TRASH_DIRECTORY/22
+setup: prefix: .git/sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/22/.git/config" core.worktree "=
$TRASH_DIRECTORY/22" &&
+	GIT_DIR=3D.. test_repo 22/.git/sub
+'
+
+test_expect_failure '#22.1: GIT_DIR(rel), core.worktree=3D..(rel) in .=
git/sub' '
+	cat >22/.git/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/22/.git
+setup: worktree: $TRASH_DIRECTORY/22
+setup: cwd: $TRASH_DIRECTORY/22
+setup: prefix: .git/sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/22/.git/config" core.worktree .=
=2E &&
+	GIT_DIR=3D.. test_repo 22/.git/sub
+'
+
+test_expect_success '#22.1: GIT_DIR, core.worktree=3D..(rel) in .git/s=
ub' '
+	cat >22/.git/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/22/.git
+setup: worktree: $TRASH_DIRECTORY/22
+setup: cwd: $TRASH_DIRECTORY/22
+setup: prefix: .git/sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/22/.git/config" core.worktree .=
=2E &&
+	GIT_DIR=3D"$TRASH_DIRECTORY/22/.git" test_repo 22/.git/sub
+'
+
+test_expect_success '#22.1: GIT_DIR, core.worktree=3D.. in .git/sub' '
+	cat >22/.git/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/22/.git
+setup: worktree: $TRASH_DIRECTORY/22
+setup: cwd: $TRASH_DIRECTORY/22
+setup: prefix: .git/sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/22/.git/config" core.worktree "=
$TRASH_DIRECTORY/22" &&
+	GIT_DIR=3D"$TRASH_DIRECTORY/22/.git" test_repo 22/.git/sub
+'
+
+#
+# case #22.2
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is not set
+#  - GIT_DIR is set
+#  - core.worktree is set
+#  - .git is a directory
+#  - core.bare is set
+#
+# Output:
+#
+# core.worktree and core.bare conflict, won't fly.
+
+test_expect_success '#22.2: setup' '
+	git config --file=3D"$TRASH_DIRECTORY/22/.git/config" core.bare true
+'
+
+test_expect_failure '#22.2: at .git' '
+	(
+	cd 22/.git &&
+	GIT_DIR=3D. test_must_fail git symbolic-ref HEAD 2>result &&
+	grep "core.bare and core.worktree do not make sense" result
+	)
+'
+
+test_expect_failure '#22.2: at root' '
+	(
+	cd 22 &&
+	GIT_DIR=3D.git test_must_fail git symbolic-ref HEAD 2>result &&
+	grep "core.bare and core.worktree do not make sense" result
+	)
+'
+
 test_done
--=20
1.7.0.2.445.gcbdb3
