From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 15/34] t1510: setup case #12
Date: Wed, 27 Oct 2010 21:49:18 +0700
Message-ID: <1288190977-30875-16-git-send-email-pclouds@gmail.com>
References: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 27 16:51:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB7Ls-000797-Kc
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 16:51:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933563Ab0J0Ovg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 10:51:36 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:63769 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933408Ab0J0Ovf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 10:51:35 -0400
Received: by mail-gy0-f174.google.com with SMTP id 4so417352gyg.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 07:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=EvtosmtKB4J++ndm7FGGAMSjtYpXr81sf0AaB6h2K7M=;
        b=wSi6uD5SJs/kYUjiZKCOZTWeKbs61kW9j1mWlKyEkjGhVENV5fdZB4jZzwfUXCwY2r
         uYRDPWlkqTNBtYk6zXsCrwN5as5Ar37vW9ILPfkbAYS7UmyuQQL4ZuLvm4/9wZLloml5
         VkZb3BJGy3THqCwc2ARS9wu0zn4WpJJowfat4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=EGvPb/cVwfbK74UEgGqFxHUTssmBpvUYYJgi/eO4cb1yybE1KbNQzo20IeGkubbIae
         CtBifwQqZE4F1zts1Pbsot3Hbxrwhlptm+l81gguGQtPovXZUnO4lxBNi1HwWZE+jMOk
         vTRiNYimTXrqNxoqe4F5sWsUSqxkE2Lp0Mt0k=
Received: by 10.150.146.14 with SMTP id t14mr17644562ybd.421.1288191094815;
        Wed, 27 Oct 2010 07:51:34 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id t9sm8780377ybe.9.2010.10.27.07.51.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 07:51:33 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 27 Oct 2010 21:51:32 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160051>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |   49 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 844d204..22a8894 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -1561,4 +1561,53 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y" test_repo 11/sub/sub
 '
=20
+#
+# case #12
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is not set
+#  - GIT_DIR is not set
+#  - core.worktree is set
+#  - .git is a file
+#  - core.bare is not set, cwd is outside .git
+#
+# Output:
+#
+# #4 except that git_dir is set by .git file
+
+
+test_expect_success '#12: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 12 12/sub 12/sub/sub 12.wt 12.wt/sub 12/wt 12/wt/sub &&
+	cd 12 &&
+	git init &&
+	git config core.worktree non-existent &&
+	mv .git ../12.git &&
+	echo gitdir: ../12.git >.git &&
+	cd ..
+'
+
+test_expect_failure '#12: at root' '
+	cat >12/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/12.git
+setup: worktree: $TRASH_DIRECTORY/12
+setup: cwd: $TRASH_DIRECTORY/12
+setup: prefix: (null)
+EOF
+	test_repo 12
+'
+
+test_expect_failure '#12: in subdir' '
+	cat >12/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/12.git
+setup: worktree: $TRASH_DIRECTORY/12
+setup: cwd: $TRASH_DIRECTORY/12
+setup: prefix: sub/
+EOF
+	test_repo 12/sub
+'
+
 test_done
--=20
1.7.0.2.445.gcbdb3
