From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 09/47] t1510: setup case #6
Date: Fri, 26 Nov 2010 22:32:05 +0700
Message-ID: <1290785563-15339-10-git-send-email-pclouds@gmail.com>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 16:37:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM0MY-0002Mx-AL
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 16:37:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753501Ab0KZPhT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 10:37:19 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:33608 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883Ab0KZPhS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 10:37:18 -0500
Received: by pzk6 with SMTP id 6so348973pzk.19
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 07:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=1bPH4AKiTj/TduCuijUXf7wIhda4IK/NwvSmMyGkc+w=;
        b=K7XNcOZHmX6DwYVx3D2/xxmzrNsQW4TtTLXuspjeCujoe0gSjtMCPBoyD7NoRsglJd
         AJPlPeM8H8lO04IgqUgjtblf7TTrqJVn37UaCYJUcUDt5SEe1qGd/KMdJV5H0frj1JMK
         N3ikeh8SPTqDQ+MVmtnz9HQhHFZcv6mG6uHBY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=dxhfeEXy1mX1Q03Zb/BTWeicu/tnCFFJiohIQDMtnexI+fB++hymoQyjXcnqZybJPO
         qvHo3eXNyZ13LfWkJq/lZRRdk+mxxYuNuZPg7/US8TLJ+5xzmS5ZkK6PfET3To0jaVyU
         yIEBLrJIxOyg7TUSh9cCJo1lFqlTNBVE9Pn4M=
Received: by 10.142.237.17 with SMTP id k17mr2490132wfh.416.1290785837554;
        Fri, 26 Nov 2010 07:37:17 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.252.168])
        by mx.google.com with ESMTPS id p8sm2680579wff.4.2010.11.26.07.37.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 07:37:16 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 26 Nov 2010 22:36:05 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
In-Reply-To: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162225>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t1510-repo-setup.sh |  291 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 291 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 369f237..4b2e60e 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -580,4 +580,295 @@ EOF
 	test_repo 5/sub
 '
=20
+#
+# case #6
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is not set
+#  - GIT_DIR is set
+#  - core.worktree is set
+#  - .git is a directory
+#  - core.bare is not set, cwd is outside .git
+#
+# Output:
+#
+#  - worktree is at core.worktree
+#  - cwd is at worktree root
+#  - prefix is calculated
+#  - git_dir is at $GIT_DIR
+#  - cwd can be outside worktree
+
+test_expect_success '#6: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 6 6/sub 6/sub/sub 6.wt 6.wt/sub 6/wt 6/wt/sub &&
+	cd 6 && git init && cd ..
+'
+
+test_expect_success '#6: GIT_DIR(rel), core.worktree=3D.. at root' '
+	cat >6/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/6
+setup: cwd: $TRASH_DIRECTORY/6
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/6/.git/config" core.worktree "$=
TRASH_DIRECTORY/6" &&
+	test_repo 6 .git
+'
+
+test_expect_success '#6: GIT_DIR(rel), core.worktree=3D..(rel) at root=
' '
+	cat >6/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/6
+setup: cwd: $TRASH_DIRECTORY/6
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/6/.git/config" core.worktree ..=
 &&
+	test_repo 6 .git
+'
+
+test_expect_success '#6: GIT_DIR, core.worktree=3D.. at root' '
+	cat >6/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/6/.git
+setup: worktree: $TRASH_DIRECTORY/6
+setup: cwd: $TRASH_DIRECTORY/6
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/6/.git/config" core.worktree "$=
TRASH_DIRECTORY/6" &&
+	test_repo 6 "$TRASH_DIRECTORY/6/.git"
+'
+
+test_expect_success '#6: GIT_DIR, core.worktree=3D..(rel) at root' '
+	cat >6/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/6/.git
+setup: worktree: $TRASH_DIRECTORY/6
+setup: cwd: $TRASH_DIRECTORY/6
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/6/.git/config" core.worktree ..=
 &&
+	test_repo 6 "$TRASH_DIRECTORY/6/.git"
+'
+
+test_expect_failure '#6: GIT_DIR(rel), core.worktree=3D.. in subdir' '
+	cat >6/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/6/.git
+setup: worktree: $TRASH_DIRECTORY/6
+setup: cwd: $TRASH_DIRECTORY/6
+setup: prefix: sub/sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/6/.git/config" core.worktree "$=
TRASH_DIRECTORY/6" &&
+	test_repo 6/sub/sub ../../.git
+'
+
+test_expect_failure '#6: GIT_DIR(rel), core.worktree=3D..(rel) in subd=
ir' '
+	cat >6/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/6/.git
+setup: worktree: $TRASH_DIRECTORY/6
+setup: cwd: $TRASH_DIRECTORY/6
+setup: prefix: sub/sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/6/.git/config" core.worktree ..=
 &&
+	test_repo 6/sub/sub ../../.git
+'
+
+test_expect_success '#6: GIT_DIR, core.worktree=3D.. in subdir' '
+	cat >6/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/6/.git
+setup: worktree: $TRASH_DIRECTORY/6
+setup: cwd: $TRASH_DIRECTORY/6
+setup: prefix: sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/6/.git/config" core.worktree "$=
TRASH_DIRECTORY/6" &&
+	test_repo 6/sub "$TRASH_DIRECTORY/6/.git"
+'
+
+test_expect_success '#6: GIT_DIR, core.worktree=3D..(rel) in subdir' '
+	cat >6/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/6/.git
+setup: worktree: $TRASH_DIRECTORY/6
+setup: cwd: $TRASH_DIRECTORY/6
+setup: prefix: sub/sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/6/.git/config" core.worktree ..=
 &&
+	test_repo 6/sub/sub "$TRASH_DIRECTORY/6/.git"
+'
+
+test_expect_success '#6: GIT_DIR(rel), core.worktree=3D../wt at root' =
'
+	cat >6/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/6/wt
+setup: cwd: $TRASH_DIRECTORY/6
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/6/.git/config" core.worktree "$=
TRASH_DIRECTORY/6/wt" &&
+	test_repo 6 .git
+'
+
+test_expect_success '#6: GIT_DIR(rel), core.worktree=3D../wt(rel) at r=
oot' '
+	cat >6/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/6/wt
+setup: cwd: $TRASH_DIRECTORY/6
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/6/.git/config" core.worktree ..=
/wt &&
+	test_repo 6 .git
+'
+
+test_expect_success '#6: GIT_DIR, core.worktree=3D../wt(rel) at root' =
'
+	cat >6/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/6/.git
+setup: worktree: $TRASH_DIRECTORY/6/wt
+setup: cwd: $TRASH_DIRECTORY/6
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/6/.git/config" core.worktree ..=
/wt &&
+	test_repo 6 "$TRASH_DIRECTORY/6/.git"
+'
+
+test_expect_success '#6: GIT_DIR, core.worktree=3D../wt at root' '
+	cat >6/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/6/.git
+setup: worktree: $TRASH_DIRECTORY/6/wt
+setup: cwd: $TRASH_DIRECTORY/6
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/6/.git/config" core.worktree "$=
TRASH_DIRECTORY/6/wt" &&
+	test_repo 6 "$TRASH_DIRECTORY/6/.git"
+'
+
+test_expect_success '#6: GIT_DIR(rel), core.worktree=3D../wt in subdir=
' '
+	cat >6/sub/sub/expected <<EOF &&
+setup: git_dir: ../../.git
+setup: worktree: $TRASH_DIRECTORY/6/wt
+setup: cwd: $TRASH_DIRECTORY/6/sub/sub
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/6/.git/config" core.worktree "$=
TRASH_DIRECTORY/6/wt" &&
+	test_repo 6/sub/sub ../../.git
+'
+
+test_expect_success '#6: GIT_DIR(rel), core.worktree=3D../wt(rel) in s=
ubdir' '
+	cat >6/sub/sub/expected <<EOF &&
+setup: git_dir: ../../.git
+setup: worktree: $TRASH_DIRECTORY/6/wt
+setup: cwd: $TRASH_DIRECTORY/6/sub/sub
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/6/.git/config" core.worktree ..=
/wt &&
+	test_repo 6/sub/sub ../../.git
+'
+
+test_expect_success '#6: GIT_DIR, core.worktree=3D../wt(rel) in subdir=
' '
+	cat >6/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/6/.git
+setup: worktree: $TRASH_DIRECTORY/6/wt
+setup: cwd: $TRASH_DIRECTORY/6/sub/sub
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/6/.git/config" core.worktree ..=
/wt &&
+	test_repo 6/sub/sub "$TRASH_DIRECTORY/6/.git"
+'
+
+test_expect_success '#6: GIT_DIR, core.worktree=3D../wt in subdir' '
+	cat >6/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/6/.git
+setup: worktree: $TRASH_DIRECTORY/6/wt
+setup: cwd: $TRASH_DIRECTORY/6/sub/sub
+setup: prefix: (null)
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/6/.git/config" core.worktree "$=
TRASH_DIRECTORY/6/wt" &&
+	test_repo 6/sub/sub "$TRASH_DIRECTORY/6/.git"
+'
+
+test_expect_failure '#6: GIT_DIR(rel), core.worktree=3D../.. at root' =
'
+	cat >6/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/6/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 6/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/6/.git/config" core.worktree "$=
TRASH_DIRECTORY" &&
+	test_repo 6 .git
+'
+
+test_expect_failure '#6: GIT_DIR(rel), core.worktree=3D../..(rel) at r=
oot' '
+	cat >6/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/6/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 6/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/6/.git/config" core.worktree ..=
/../ &&
+	test_repo 6 .git
+'
+
+test_expect_success '#6: GIT_DIR, core.worktree=3D../..(rel) at root' =
'
+	cat >6/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/6/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 6/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/6/.git/config" core.worktree ..=
/../ &&
+	test_repo 6 "$TRASH_DIRECTORY/6/.git"
+'
+
+test_expect_success '#6: GIT_DIR, core.worktree=3D../.. at root' '
+	cat >6/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/6/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 6/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/6/.git/config" core.worktree "$=
TRASH_DIRECTORY" &&
+	test_repo 6 "$TRASH_DIRECTORY/6/.git"
+'
+
+test_expect_failure '#6: GIT_DIR(rel), core.worktree=3D../.. in subdir=
' '
+	cat >6/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/6/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 6/sub/sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/6/.git/config" core.worktree "$=
TRASH_DIRECTORY" &&
+	test_repo 6/sub/sub ../../.git
+'
+
+test_expect_failure '#6: GIT_DIR(rel), core.worktree=3D../..(rel) in s=
ubdir' '
+	cat >6/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/6/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 6/sub/sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/6/.git/config" core.worktree ..=
/.. &&
+	test_repo 6/sub/sub ../../.git
+'
+
+test_expect_success '#6: GIT_DIR, core.worktree=3D../..(rel) in subdir=
' '
+	cat >6/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/6/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 6/sub/sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/6/.git/config" core.worktree ..=
/.. &&
+	test_repo 6/sub/sub "$TRASH_DIRECTORY/6/.git"
+'
+
+test_expect_success '#6: GIT_DIR, core.worktree=3D../.. in subdir' '
+	cat >6/sub/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/6/.git
+setup: worktree: $TRASH_DIRECTORY
+setup: cwd: $TRASH_DIRECTORY
+setup: prefix: 6/sub/sub/
+EOF
+	git config --file=3D"$TRASH_DIRECTORY/6/.git/config" core.worktree "$=
TRASH_DIRECTORY" &&
+	test_repo 6/sub/sub "$TRASH_DIRECTORY/6/.git"
+'
+
 test_done
--=20
1.7.3.2.316.gda8b3
