From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 03/34] t1510: setup case #0
Date: Wed, 27 Oct 2010 21:49:06 +0700
Message-ID: <1288190977-30875-4-git-send-email-pclouds@gmail.com>
References: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 27 16:50:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB7KU-0006Fq-RD
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 16:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933319Ab0J0OuG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 10:50:06 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:61352 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932499Ab0J0OuE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 10:50:04 -0400
Received: by mail-yx0-f174.google.com with SMTP id 8so64577yxk.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 07:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=FFSQ9f0Us+skLoqKp5iNYXZos7Noa1H/RipxLdexH54=;
        b=SfmZEARPMPi5vZphqxC2hMc2aydA1Sg1hkvRYS7aJfVcFR45fB7whinAsbyVwea3L6
         ePkaA7kJzk4CZjoqAYApnfazxh7VM9qyHK2KkoZZ9JtM+xUad9zOjaIsX5TPCnFJ+0a9
         n7jL5FGqkMIrQ2UsqTNvvDcgCqYLvR8xhCt5o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=tzDp2VklwlQvSfjAvNBC2Et5QXRq4kf4HquDZ6BAQ07zhjyHmofLInBieWB3juiBpG
         Qq1nL3wXhnV4qanAQUFqZdF2eBDfGN1YhF3SC2Us5n+hpDRrai5t7TtcbkndC+hsLNnz
         f/7jmu7zBWMRizd8jWOTow2bD0H4X1wRkPLUY=
Received: by 10.100.137.9 with SMTP id k9mr7953666and.263.1288191003590;
        Wed, 27 Oct 2010 07:50:03 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id w15sm11920734anw.13.2010.10.27.07.50.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 07:50:02 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 27 Oct 2010 21:50:01 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160044>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |   47 +++++++++++++++++++++++++++++++++++++++++=
++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 218eb35..d94a2d6 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -56,4 +56,51 @@ test_repo() {
 # Bit 4 =3D bare repo
 # Case# =3D encoding of the above 5 bits
=20
+#
+# Case #0
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is not set
+#  - GIT_DIR is not set
+#  - core.worktree is not set
+#  - .git is a directory
+#  - core.bare is not set, cwd is outside .git
+#
+# Output:
+#
+#  - worktree is .git's parent directory
+#  - cwd is at worktree root dir
+#  - prefix is calculated
+#  - git_dir is set to ".git"
+#  - cwd can't be outside worktree
+
+test_expect_success '#0: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 0 0/sub &&
+	cd 0 && git init && cd ..
+'
+
+test_expect_success '#0: at root' '
+	cat >0/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/0
+setup: cwd: $TRASH_DIRECTORY/0
+setup: prefix: (null)
+EOF
+	test_repo 0
+'
+
+test_expect_success '#0: in subdir' '
+	cat >0/sub/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/0
+setup: cwd: $TRASH_DIRECTORY/0
+setup: prefix: sub/
+EOF
+	test_repo 0/sub
+'
+
 test_done
--=20
1.7.0.2.445.gcbdb3
