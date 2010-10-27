From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 29/34] t1510: setup case #26
Date: Wed, 27 Oct 2010 21:49:32 +0700
Message-ID: <1288190977-30875-30-git-send-email-pclouds@gmail.com>
References: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 27 16:53:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB7Na-0008P7-60
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 16:53:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933606Ab0J0OxW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 10:53:22 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:56279 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933578Ab0J0OxU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 10:53:20 -0400
Received: by mail-yx0-f174.google.com with SMTP id 8so67902yxk.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 07:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=R10AD3HeK5JphUnJXB0COYlNZRFgsXPeCfDTicOluYw=;
        b=wNCrCYX29FwxZrNG0Axx9Q6osFcxiwjQ04RpVp5Vs4FkVwW8oEji3Or1MYS3XWSQjn
         bfDjG7R7ob6EidramDcFdys6MCZ7wkyEKhhEdEawLC2HyqV7WAf7gFL/g1lUovblf02J
         4Xfu65RRoInzYcDzWQQW9OFw45MWFANRReR2w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ToyEA9eCR0vPLH1+qekkJIbHGu5TTYZjd99jZk7G1LOVMN85c553kDdX0Z4LFeArAa
         1O1F72fL2nIHh/c+6CTNTmvNprLXeKLWUlIzuRJN1GSyaVGb72qCsE8l81+cH+xr0emN
         9Nnqz5ZYX6mbEyDDA2Gp8A0Ji6ky1tEwshIr0=
Received: by 10.150.144.10 with SMTP id r10mr16217558ybd.34.1288191200424;
        Wed, 27 Oct 2010 07:53:20 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id p1sm8781009ybn.5.2010.10.27.07.53.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 07:53:19 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 27 Oct 2010 21:53:18 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160069>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |   68 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 68 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index e53ff90..b1efec5 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -3772,4 +3772,72 @@ EOF
 	test_repo 25/sub
 '
=20
+#
+# case #26
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is not set
+#  - GIT_DIR is set
+#  - core.worktree is not set
+#  - .git is a file
+#  - core.bare is set
+#
+# Output:
+#
+# #18 except git_dir is set according to .git file
+
+test_expect_success '#26: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 26 26/sub &&
+	cd 26 &&
+	git init &&
+	git config core.bare true &&
+	mv .git ../26.git &&
+	echo gitdir: ../26.git >.git &&
+	cd ..
+'
+
+test_expect_failure '#26: (rel) at root' '
+	cat >26/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/26.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/26
+setup: prefix: (null)
+EOF
+	 GIT_DIR=3D.git test_repo 26
+'
+
+test_expect_failure '#26: at root' '
+	cat >26/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/26.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/26
+setup: prefix: (null)
+EOF
+	 GIT_DIR=3D"$TRASH_DIRECTORY/26/.git" test_repo 26
+'
+
+test_expect_failure '#26: (rel) in subdir' '
+	cat >26/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/26.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/26/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D../.git test_repo 26/sub
+'
+
+test_expect_failure '#26: in subdir' '
+	cat >26/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/26.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/26/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/26/.git" test_repo 26/sub
+'
+
 test_done
--=20
1.7.0.2.445.gcbdb3
