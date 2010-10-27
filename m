From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 16/34] t1510: setup case #13
Date: Wed, 27 Oct 2010 21:49:19 +0700
Message-ID: <1288190977-30875-17-git-send-email-pclouds@gmail.com>
References: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 27 16:52:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB7Mk-0007lz-7X
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 16:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933565Ab0J0Ovo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 10:51:44 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:56867 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933408Ab0J0Ovn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 10:51:43 -0400
Received: by ywk9 with SMTP id 9so444465ywk.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 07:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=fn1VRbQ1lBrWFgKIZV3eehPrzIQBPJwndU0flW5h/5Q=;
        b=aRbZdxjoRpUtYfJTrsCOhLOdqb2PP7WXps8hKWvC+buEcqO0qjfCNCWYj5gp3oqrXO
         4jVULvjxnFIwh1Pl2R+t8Pn1mVUx6T4QXjc+PaIHCGWXBBwKPg4nn+HgrVAp32z4KHIZ
         7/YSQ2lxY4sazlHU1K+4XyvSmKKW7ZUzlJz8I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Ez4R2GYrHfQx/4Gx3QOY+l+Sof4qKSUUXsQMQpD5diJEKq2WFqQJzEBlxBKnDrAiqZ
         YRvrwMOGs/WAE8sqW0pWXILvQw9sc97qY9oqUzSkmi0PLhKMkZhCUTiNaoc3NFDhtPM9
         q2x8lbyD2iW2N8mhVy33qzvjipIgPueaAr7FY=
Received: by 10.100.108.8 with SMTP id g8mr7955647anc.17.1288191102199;
        Wed, 27 Oct 2010 07:51:42 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id 6sm11922911anx.12.2010.10.27.07.51.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 07:51:41 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 27 Oct 2010 21:51:39 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160063>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |   49 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 22a8894..ec0a993 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -1610,4 +1610,53 @@ EOF
 	test_repo 12/sub
 '
=20
+#
+# case #13
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is set
+#  - GIT_DIR is not set
+#  - core.worktree is set
+#  - .git is a file
+#  - core.bare is not set, cwd is outside .git
+#
+# Output:
+#
+# #5 except that git_dir is set by .git file
+
+test_expect_success '#13: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 13 13/sub 13/sub/sub 13.wt 13.wt/sub 13/wt 13/wt/sub &&
+	cd 13 &&
+	git init &&
+	git config core.worktree non-existent &&
+	export GIT_WORK_TREE=3Dnon-existent too &&
+	mv .git ../13.git &&
+	echo gitdir: ../13.git >.git &&
+	cd ..
+'
+
+test_expect_failure '#13: at root' '
+	cat >13/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/13.git
+setup: worktree: $TRASH_DIRECTORY/13
+setup: cwd: $TRASH_DIRECTORY/13
+setup: prefix: (null)
+EOF
+	test_repo 13
+'
+
+test_expect_failure '#13: in subdir' '
+	cat >13/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/13.git
+setup: worktree: $TRASH_DIRECTORY/13
+setup: cwd: $TRASH_DIRECTORY/13
+setup: prefix: sub/
+EOF
+	test_repo 13/sub
+'
+
 test_done
--=20
1.7.0.2.445.gcbdb3
