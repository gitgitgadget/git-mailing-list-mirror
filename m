From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 24/42] t1510: setup case #21
Date: Fri, 29 Oct 2010 13:48:36 +0700
Message-ID: <1288334934-17216-25-git-send-email-pclouds@gmail.com>
References: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 08:52:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBipE-0006ze-9h
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 08:52:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933264Ab0J2GwX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 02:52:23 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64522 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754594Ab0J2GwW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 02:52:22 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so692674pwj.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 23:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=g7s4IOvH+1sNh86uXnRjblQVnU9L8t1dQzylynGpYOU=;
        b=c3EcvnHs66LWAu2BEGSGYvRU/TdXPkUAfyoF1QwWrjXQGz1oZB7aCCLQOpovOY4Sbe
         BqY2CxVvVUeC5Qf0TePA0ruWEPe719uZv3PHZzxHR6DIbPtvicLIVMuCqV3rLVHMAxlt
         dD2D6tDurFJBJovDqtmdd4chIrGd7asXnQK1w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=otHcQjooXbKrDKkaI4gcYSM+uraQxHj0VJMvtP4rnZ+g677DTmpa0mL1ObdvL+14gb
         F2MpecwQHMR0gKTpo3Ox2NdAHXkJYZWum9iMU4DK295CAESyo/LUtpjRgRIF/TgE/ZmT
         00wDMPkE4K/M2J1vvnT0QB2Wm2cv4FR0fdkb8=
Received: by 10.142.174.14 with SMTP id w14mr922310wfe.325.1288335142078;
        Thu, 28 Oct 2010 23:52:22 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id x18sm1021858wfa.23.2010.10.28.23.52.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 23:52:21 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 29 Oct 2010 13:52:21 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160292>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |  129 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 129 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 0ace186..8d67514 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -2946,4 +2946,133 @@ EOF
 	test_repo 20/sub
 '
=20
+#
+# case #21.1
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is set
+#  - GIT_DIR is not set
+#  - core.worktree is set
+#  - .git is a directory
+#  - cwd is inside .git
+#
+# Output:
+#
+# GIT_WORK_TREE/core.worktree are ignored -> #20.1
+
+test_expect_success '#21.1: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 21 21/sub &&
+	cd 21 &&
+	git init &&
+	git config core.worktree non-existent &&
+	export GIT_WORK_TREE=3Dnon-existent-too &&
+	mkdir .git/wt .git/wt/sub &&
+	cd ..
+'
+
+test_expect_failure '#21.1: at .git' '
+	cat >21/.git/expected <<EOF &&
+setup: git_dir: .
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/21/.git
+setup: prefix: (null)
+EOF
+	test_repo 21/.git
+'
+
+test_expect_failure '#21.1: in .git/wt' '
+	cat >21/.git/wt/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/21/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/21/.git/wt
+setup: prefix: (null)
+EOF
+	test_repo 21/.git/wt
+'
+
+test_expect_failure '#21.1: in .git/wt/sub' '
+	cat >21/.git/wt/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/21/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/21/.git/wt/sub
+setup: prefix: (null)
+EOF
+	test_repo 21/.git/wt/sub
+'
+
+#
+# case #21.2
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is set
+#  - GIT_DIR is not set
+#  - core.worktree is set
+#  - .git is a directory
+#  - core.bare is set
+#
+# Output:
+#
+# GIT_WORK_TREE/core.worktree are ignored -> #20.2
+
+test_expect_success '#21.2: setup' '
+	git config --file=3D"$TRASH_DIRECTORY/21/.git/config" core.bare true
+'
+
+test_expect_failure '#21.2: at .git' '
+	cat >21/.git/expected <<EOF &&
+setup: git_dir: .
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/21/.git
+setup: prefix: (null)
+EOF
+	test_repo 21/.git
+'
+
+test_expect_failure '#21.2: in .git/wt' '
+	cat >21/.git/wt/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/21/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/21/.git/wt
+setup: prefix: (null)
+EOF
+	test_repo 21/.git/wt
+'
+
+test_expect_failure '#21.2: in .git/wt/sub' '
+	cat >21/.git/wt/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/21/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/21/.git/wt/sub
+setup: prefix: (null)
+EOF
+	test_repo 21/.git/wt/sub
+'
+
+test_expect_failure '#21.2: at root' '
+	cat >21/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/21
+setup: prefix: (null)
+EOF
+	test_repo 21
+'
+
+test_expect_failure '#21.2: in subdir' '
+	cat >21/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/21/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/21/sub
+setup: prefix: (null)
+EOF
+	test_repo 21/sub
+'
+
 test_done
--=20
1.7.0.2.445.gcbdb3
