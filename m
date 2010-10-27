From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 13/34] t1510: setup case #10
Date: Wed, 27 Oct 2010 21:49:16 +0700
Message-ID: <1288190977-30875-14-git-send-email-pclouds@gmail.com>
References: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 27 16:51:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB7Lr-000797-Jh
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 16:51:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933553Ab0J0OvW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 10:51:22 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:61288 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933455Ab0J0OvV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 10:51:21 -0400
Received: by mail-gw0-f46.google.com with SMTP id 21so425242gwj.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 07:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=i+9hHiaqlFMQ4Ab2sZ/Lf1nwv+SfATooSq24yOw+bPc=;
        b=a6jy0a0NwlFi8Iu4py9xnRbAkKd7FqWD1K1AVQC+GV27uAcFm5eThHLLVEnkk7S/9R
         UuEB7/3EBHIAx6UEK58m6lRq7Ep1ZxcbH0fjnRuIxNravMsp6fCQXB8Uh3/oIgaXEs+x
         0cneYKFrvFWmqYooGN9pSauKJ/uD1rD/SqfBU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=qk2CA1VCckycjVmiZt52pD4cMPIIlLYQFiBbpKyOs8jlNoynYC3Tz3JiSjzzJT6NcN
         MA13u10WDYilNEJcrcJMOvpMDqX5XmUA+3WJ3loJJNQqHRD3tCfI74MLv5KNupNRZ6km
         M8O1j2I1WiDSc8Ri7j2B1KPRaDZ0Os2CgEh+U=
Received: by 10.151.147.10 with SMTP id z10mr7769698ybn.270.1288191079403;
        Wed, 27 Oct 2010 07:51:19 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id 25sm11920367anq.28.2010.10.27.07.51.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 07:51:18 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 27 Oct 2010 21:51:17 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160052>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |   67 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 67 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 1406a8d..73b18a2 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -1227,4 +1227,71 @@ EOF
 	GIT_WORK_TREE=3Dnon-existent test_repo 9/sub
 '
=20
+#
+# case #10
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is not set
+#  - GIT_DIR is set
+#  - core.worktree is not set
+#  - .git is a file
+#  - core.bare is not set, cwd is outside .git
+#
+# Output:
+#
+# #2 except that git_dir is set by .git file
+
+test_expect_success '#10: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 10 10/sub &&
+	cd 10 &&
+	git init &&
+	mv .git ../10.git &&
+	echo gitdir: ../10.git >.git &&
+	cd ..
+'
+
+test_expect_failure '#10: at root' '
+	cat >10/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/10.git
+setup: worktree: $TRASH_DIRECTORY/10
+setup: cwd: $TRASH_DIRECTORY/10
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/10/.git" test_repo 10
+'
+
+test_expect_failure '#10: in subdir' '
+	cat >10/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/10.git
+setup: worktree: $TRASH_DIRECTORY/10/sub
+setup: cwd: $TRASH_DIRECTORY/10/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/10/.git" test_repo 10/sub
+'
+
+test_expect_failure '#10: relative GIT_DIR at root' '
+	cat >10/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/10.git
+setup: worktree: $TRASH_DIRECTORY/10
+setup: cwd: $TRASH_DIRECTORY/10
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D.git test_repo 10
+'
+
+test_expect_failure '#10: relative GIT_DIR in subdir' '
+	cat >10/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/10.git
+setup: worktree: $TRASH_DIRECTORY/10/sub
+setup: cwd: $TRASH_DIRECTORY/10/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D../.git test_repo 10/sub
+'
+
 test_done
--=20
1.7.0.2.445.gcbdb3
