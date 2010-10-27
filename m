From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 28/34] t1510: setup case #25
Date: Wed, 27 Oct 2010 21:49:31 +0700
Message-ID: <1288190977-30875-29-git-send-email-pclouds@gmail.com>
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
	id 1PB7NZ-0008P7-Lh
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 16:53:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933599Ab0J0OxP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 10:53:15 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:51568 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933578Ab0J0OxN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 10:53:13 -0400
Received: by mail-gw0-f46.google.com with SMTP id 21so426855gwj.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 07:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=N0xMmGN1gpIgVPk7vXAhVBZwFve6rSNvAF1P0jwYXMg=;
        b=Tv6d4YBnNNJgZNJ0/lORfmFaCQSDnFuqdF7ccF/boI7m+8dPKXT6PKGPiaIF0kcLkA
         g0FOoeei16972HKFwvaM74e2tb1LHbi7mF19aLGz07hcrmmkIJE95Qqv/UnjoQmFhXjc
         fGARL24l6xPowHYpTyO6sGcCyR50ywq5OFtOA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=VLnkchdHxl7Vw2lQidcZjzjoDFzh3EqF+6ZPdniFPIPpLDxPzAnI4OB5TOmV/mHjRT
         DiCe/9Wa3VPON8+VpIRToNeJP/8e20ddY/eLGsh4j+/ZQjDLmwaxndSX6m2zHUyAQOOk
         lTiszdi+u5ojdkATm3WcZpCR0CU1iaPRnSl+U=
Received: by 10.151.111.9 with SMTP id o9mr3322722ybm.259.1288191193296;
        Wed, 27 Oct 2010 07:53:13 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id h1sm8782997yba.14.2010.10.27.07.53.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 07:53:12 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 27 Oct 2010 21:53:11 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160068>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |   49 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 2660e72..e53ff90 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -3723,4 +3723,53 @@ EOF
 	test_repo 24/sub
 '
=20
+#
+# case #25
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is set
+#  - GIT_DIR is not set
+#  - core.worktree is not set
+#  - .git is a file
+#  - core.bare is set
+#
+# Output:
+#
+# #17.2 except git_dir is set according to .git file
+
+test_expect_success '#25: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 25 25/sub &&
+	cd 25 &&
+	git init &&
+	git config core.bare true &&
+	export GIT_WORK_TREE=3Dnon-existent &&
+	mv .git ../25.git &&
+	echo gitdir: ../25.git >.git &&
+	cd ..
+'
+
+test_expect_failure '#25: at root' '
+	cat >25/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/25.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/25
+setup: prefix: (null)
+EOF
+	test_repo 25
+'
+
+test_expect_failure '#25: in subdir' '
+	cat >25/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/25.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/25/sub
+setup: prefix: (null)
+EOF
+	test_repo 25/sub
+'
+
 test_done
--=20
1.7.0.2.445.gcbdb3
