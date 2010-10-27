From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 31/34] t1510: setup case #28
Date: Wed, 27 Oct 2010 21:49:34 +0700
Message-ID: <1288190977-30875-32-git-send-email-pclouds@gmail.com>
References: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 27 16:54:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB7OB-0000NW-CE
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 16:54:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933611Ab0J0Oxh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 10:53:37 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:56279 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933609Ab0J0Oxg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 10:53:36 -0400
Received: by mail-yx0-f174.google.com with SMTP id 8so67902yxk.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 07:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=LqqlbNru/nsYI6J2dlP0TOnIzkvaey17CHU/UbDgf2E=;
        b=Rcum4IqStsEYXMo2Su36dSHtBauFbFEE+OO1+cNvpA2LorWavFX7EVCJVjCQ2/sK16
         8i7YdPSUi2/Y7YDJ49EL0hI/8uFCmR6ziZtKEtvXbXejjRQ6a5D8k6gUswr0xs46lMK4
         qN1stXfBFvzLSsMs7aaR5mzsdblz4BnUF2Sf0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=E51YomcjV99l1W0EE4j1YWxYwUR/398gPcDD1Tp2bjM/Z0VL8a5PDg5iTUcwJpZA+R
         rOJV2Ajly0rbYKtOsR92Bus8oG3pFijjTjakzfkEdxiukJpff+fcMbrHSE8qeYusXfhP
         GJX3ooCE8WG+uxmr/WcoJlzT3c2+DxSUvUDFA=
Received: by 10.151.7.12 with SMTP id k12mr17392469ybi.367.1288191215784;
        Wed, 27 Oct 2010 07:53:35 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id y41sm7700670yhc.4.2010.10.27.07.53.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 07:53:35 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 27 Oct 2010 21:53:33 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160071>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |   49 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index b0ba763..9221cd3 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -4108,4 +4108,53 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/27/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y" test_repo 27/sub/sub
 '
=20
+#
+# case #28
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is not set
+#  - GIT_DIR is not set
+#  - core.worktree is set
+#  - .git is a file
+#  - core.bare is set
+#
+# Output:
+#
+# core.worktree is ignored -> #24
+
+test_expect_success '#28: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 28 28/sub &&
+	cd 28 &&
+	git init &&
+	git config core.bare true &&
+	git config core.worktree non-existent &&
+	mv .git ../28.git &&
+	echo gitdir: ../28.git >.git &&
+	cd ..
+'
+
+test_expect_success '#28: at root' '
+	cat >28/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/28.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/28
+setup: prefix: (null)
+EOF
+	test_repo 28
+'
+
+test_expect_success '#28: in subdir' '
+	cat >28/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/28.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/28/sub
+setup: prefix: (null)
+EOF
+	test_repo 28/sub
+'
+
 test_done
--=20
1.7.0.2.445.gcbdb3
