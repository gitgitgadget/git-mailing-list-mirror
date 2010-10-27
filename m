From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 27/34] t1510: setup case #24
Date: Wed, 27 Oct 2010 21:49:30 +0700
Message-ID: <1288190977-30875-28-git-send-email-pclouds@gmail.com>
References: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 27 16:53:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB7NZ-0008P7-5E
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 16:53:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933575Ab0J0OxI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 10:53:08 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37043 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933578Ab0J0OxG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 10:53:06 -0400
Received: by mail-yw0-f46.google.com with SMTP id 9so445305ywk.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 07:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=6DX8sj/VVf+zbkvyqCZpu5VIAWZFc3GAbACuLx6bXHs=;
        b=m6tcJBKSpcLKH/oacB8mfC9d5nf1tpwlGG7xDGohv/1AhFW5HWRe1y8wRCZdaOEVF7
         rV15nYYH/Jh0Rbj3hRv2XCOvBHHOlnJQmVskvKLopE6pFSaqZN21WO2U/ZSQtfQ4xO2W
         jOA3q5xiebn14rIFoMmMJTRfmDEinJnound3E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=BmGi86/T70cuQVUKo9ZFbRChiVbYDR23fmNgRSG8EAucYjfsoGaA4cLBIoMT7V497v
         eP0VwVL4NFFpMvoRraFB3ISMlv21xgY7MHwLTgxseYIx5+bHr2BIJOCohLXJCrkVH7iU
         nQ3VM3fNSfu9r8hrHHe+AfYTWqY7kSUO9Rmwg=
Received: by 10.151.110.12 with SMTP id n12mr17787599ybm.118.1288191186031;
        Wed, 27 Oct 2010 07:53:06 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id p38sm4997457ybk.16.2010.10.27.07.53.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 07:53:05 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 27 Oct 2010 21:53:03 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160067>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |   48 +++++++++++++++++++++++++++++++++++++++++=
+++++++
 1 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 30743d6..2660e72 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -3675,4 +3675,52 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/23/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y" test_repo 23/sub/sub
 '
=20
+#
+# case #24
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is not set
+#  - GIT_DIR is not set
+#  - core.worktree is not set
+#  - .git is a file
+#  - core.bare is set
+#
+# Output:
+#
+# #16.2 except git_dir is set according to .git file
+
+test_expect_success '#24: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 24 24/sub &&
+	cd 24 &&
+	git init &&
+	git config core.bare true &&
+	mv .git ../24.git &&
+	echo gitdir: ../24.git >.git &&
+	cd ..
+'
+
+test_expect_success '#24: at root' '
+	cat >24/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/24.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/24
+setup: prefix: (null)
+EOF
+	test_repo 24
+'
+
+test_expect_success '#24: in subdir' '
+	cat >24/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/24.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/24/sub
+setup: prefix: (null)
+EOF
+	test_repo 24/sub
+'
+
 test_done
--=20
1.7.0.2.445.gcbdb3
