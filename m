From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 23/42] t1510: setup case #20
Date: Fri, 29 Oct 2010 13:48:35 +0700
Message-ID: <1288334934-17216-24-git-send-email-pclouds@gmail.com>
References: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 08:52:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBip6-0006u0-L3
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 08:52:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933262Ab0J2GwR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 02:52:17 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:55773 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933180Ab0J2GwP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 02:52:15 -0400
Received: by iwn10 with SMTP id 10so3312184iwn.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 23:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=nllHZ+EyBa3nAwBW+Bi3Q45V/Kg0bwqZh+57nJB8pPE=;
        b=JxJ5czQAhzrZ9UvWRKS/xjLHefYFrBOZ/N3+4eSTQOMEZShNLjcxuOP9lzy6NsT1+D
         Z1RRwSwSXrSZfXVSdZk/NWrsTUAYOsnSVGmGueVKf9PG9Z5koSi5UbwotyUe09S3pgpT
         Hdd6IR+Df9MAcc13OySk03pEKTCdWRecGDdfo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=PMVE3B36dfL3UDza7vaIrN6xWtOtD1O7ypLpCHMSlyowYlS3BHqfHXxQ85l3/EeSn8
         3jPjSip3xAcm8WwMTy9DRVeNP4GqZIB1hJ6xqjE6x43z+Nb4IAbNlefEQwZBUqOV7fBe
         Y4zZ6jDM1p5qM8FNPq48L0yjcECNUXi3EnkFE=
Received: by 10.231.144.74 with SMTP id y10mr1097521ibu.65.1288335134681;
        Thu, 28 Oct 2010 23:52:14 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id 8sm3315321iba.22.2010.10.28.23.52.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 23:52:13 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 29 Oct 2010 13:52:13 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160291>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |  128 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 128 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 8538098..0ace186 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -2818,4 +2818,132 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/19/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y" test_repo 19/sub/sub
 '
=20
+#
+# case #20.1
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is not set
+#  - GIT_DIR is not set
+#  - core.worktree is set
+#  - .git is a directory
+#  - cwd is inside .git
+#
+# Output:
+#
+# core.worktree is ignored -> #16.1
+
+test_expect_success '#20.1: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 20 20/sub &&
+	cd 20 &&
+	git init &&
+	git config core.worktree non-existent &&
+	mkdir .git/wt .git/wt/sub &&
+	cd ..
+'
+
+test_expect_failure '#20.1: at .git' '
+	cat >20/.git/expected <<EOF &&
+setup: git_dir: .
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/20/.git
+setup: prefix: (null)
+EOF
+	test_repo 20/.git
+'
+
+test_expect_failure '#20.1: in .git/wt' '
+	cat >20/.git/wt/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/20/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/20/.git/wt
+setup: prefix: (null)
+EOF
+	test_repo 20/.git/wt
+'
+
+test_expect_failure '#20.1: in .git/wt/sub' '
+	cat >20/.git/wt/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/20/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/20/.git/wt/sub
+setup: prefix: (null)
+EOF
+	test_repo 20/.git/wt/sub
+'
+
+#
+# case #20.2
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is not set
+#  - GIT_DIR is not set
+#  - core.worktree is set
+#  - .git is a directory
+#  - core.bare is set
+#
+# Output:
+#
+# core.worktree is ignored -> #16.2
+
+test_expect_success '#20.2: setup' '
+	git config --file=3D"$TRASH_DIRECTORY/20/.git/config" core.bare true
+'
+
+test_expect_success '#20.2: at .git' '
+	cat >20/.git/expected <<EOF &&
+setup: git_dir: .
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/20/.git
+setup: prefix: (null)
+EOF
+	test_repo 20/.git
+'
+
+test_expect_success '#20.2: in .git/wt' '
+	cat >20/.git/wt/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/20/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/20/.git/wt
+setup: prefix: (null)
+EOF
+	test_repo 20/.git/wt
+'
+
+test_expect_success '#20.2: in .git/wt/sub' '
+	cat >20/.git/wt/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/20/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/20/.git/wt/sub
+setup: prefix: (null)
+EOF
+	test_repo 20/.git/wt/sub
+'
+
+test_expect_success '#20.2: at root' '
+	cat >20/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/20
+setup: prefix: (null)
+EOF
+	test_repo 20
+'
+
+test_expect_failure '#20.2: in subdir' '
+	cat >20/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/20/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/20/sub
+setup: prefix: (null)
+EOF
+	test_repo 20/sub
+'
+
 test_done
--=20
1.7.0.2.445.gcbdb3
