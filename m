From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 11/34] t1510: setup case #8
Date: Wed, 27 Oct 2010 21:49:14 +0700
Message-ID: <1288190977-30875-12-git-send-email-pclouds@gmail.com>
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
	id 1PB7Lp-000797-13
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 16:51:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933501Ab0J0OvH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 10:51:07 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:61288 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933455Ab0J0OvF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 10:51:05 -0400
Received: by gwj21 with SMTP id 21so425242gwj.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 07:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=JwtduspvRRnNFZJD6cx1nlaiIn7WkDn9d2ghMR90cTE=;
        b=Z4Qv/6Farie2pkdE/dhsJOA5QAnuSAYKGJRReITo3+EcsiTF2W4XYhednzKrKNl34l
         nfbRBRxIT+7JNXlDBHAA08wI2U9myloyltMS7dYFC2kl8Czng0l/sg0oOccgnb+q5bUF
         EcGf9r7moTzHfqngJlBD4u1AnGmyZ1DIgzInI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=GKJpRaKcJIhu5c9fx6Km6+Vq6pwzF8ceCYYCLzJgliDqsM2D6DH54UcOBfFc/7Qqco
         gsroZxUflrSRIux+JzGlHnY83WqmOOdd3nMxqdsmnKt+FCJ9eP/UB5CGL+aV3N21/NmW
         190Xe8aOJRMJKrY6xkGf7lS3P+8eZwRuW6s+E=
Received: by 10.150.216.14 with SMTP id o14mr4059349ybg.205.1288191064831;
        Wed, 27 Oct 2010 07:51:04 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id n28sm7710282yha.16.2010.10.27.07.51.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 07:51:04 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 27 Oct 2010 21:51:01 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160050>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |   47 +++++++++++++++++++++++++++++++++++++++++=
++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 968a5b2..5ca9f4a 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -1133,4 +1133,51 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/7/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTORY=
" test_repo 7/sub/sub
 '
=20
+#
+# case #8
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is not set
+#  - GIT_DIR is not set
+#  - core.worktree is not set
+#  - .git is a file
+#  - core.bare is not set, cwd is outside .git
+#
+# Output:
+#
+# #0 except that git_dir is set by .git file
+
+test_expect_success '#8: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 8 8/sub &&
+	cd 8 &&
+	git init &&
+	mv .git ../8.git &&
+	echo gitdir: ../8.git >.git &&
+	cd ..
+'
+
+test_expect_success '#8: at root' '
+	cat >8/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/8.git
+setup: worktree: $TRASH_DIRECTORY/8
+setup: cwd: $TRASH_DIRECTORY/8
+setup: prefix: (null)
+EOF
+	test_repo 8
+'
+
+test_expect_success '#8: in subdir' '
+	cat >8/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/8.git
+setup: worktree: $TRASH_DIRECTORY/8
+setup: cwd: $TRASH_DIRECTORY/8
+setup: prefix: sub/
+EOF
+	test_repo 8/sub
+'
+
 test_done
--=20
1.7.0.2.445.gcbdb3
