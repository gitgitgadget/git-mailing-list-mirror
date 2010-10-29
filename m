From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 20/42] t1510: setup case #17
Date: Fri, 29 Oct 2010 13:48:32 +0700
Message-ID: <1288334934-17216-21-git-send-email-pclouds@gmail.com>
References: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 08:52:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBiom-0006fc-0y
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 08:52:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933178Ab0J2Gvx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 02:51:53 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64522 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932830Ab0J2Gvw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 02:51:52 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so692674pwj.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 23:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=ZAGcr37BK3I2TZ2AdfizcFbWBTS5NFpmKS1nwo5C+bw=;
        b=Gwo72NxUrySvxetjFxpsZqVPBQ5fAcnd+SjopqPFTgVWTH1QEejS2sAnWka79UIvd5
         szZPHoq4S2FBfj6N0P2JKXtDz0th1fx3AzA7Ij/jfQkDGPa91JPKcLKYeJyCV9nTFEAu
         +dqJosiIAmT4fmrEFiSNBIprlX64L8aPAGCWk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=dnZj26OeMI+m4OM6zuC3+tyaKf3XdDor5DyJN4oCqqzsphnjn3FdccRmnTvi1oa+RQ
         UZKCmnaSEW36wvUejE72c+9n9fG/sVS8iqJGggWzBJb0LIzk7C/blUAWtdbvejm48rV3
         wi+QHrYxAlq8ywgmKciwUO3Uv7eAsd/MGiR9I=
Received: by 10.142.199.12 with SMTP id w12mr1024227wff.360.1288335112638;
        Thu, 28 Oct 2010 23:51:52 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id x35sm1027927wfd.13.2010.10.28.23.51.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 23:51:51 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 29 Oct 2010 13:51:52 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160288>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |  128 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 128 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 491bcf6..07abeac 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -2353,4 +2353,132 @@ EOF
 	test_repo 16/sub
 '
=20
+#
+# case #17.1
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is set
+#  - GIT_DIR is not set
+#  - core.worktree is not set
+#  - .git is a directory
+#  - cwd is inside .git
+#
+# Output:
+#
+# GIT_WORK_TREE is ignored -> #16.1 (with warnings perhaps)
+
+test_expect_success '#17.1: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 17 17/sub &&
+	cd 17 &&
+	git init &&
+	mkdir .git/wt .git/wt/sub &&
+	export GIT_WORK_TREE=3Dnon-existent &&
+	cd ..
+'
+
+test_expect_failure '#17.1: at .git' '
+	cat >17/.git/expected <<EOF &&
+setup: git_dir: .
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/17/.git
+setup: prefix: (null)
+EOF
+	test_repo 17/.git
+'
+
+test_expect_failure '#17.1: in .git/wt' '
+	cat >17/.git/wt/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/17/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/17/.git/wt
+setup: prefix: (null)
+EOF
+	test_repo 17/.git/wt
+'
+
+test_expect_failure '#17.1: in .git/wt/sub' '
+	cat >17/.git/wt/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/17/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/17/.git/wt/sub
+setup: prefix: (null)
+EOF
+	test_repo 17/.git/wt/sub
+'
+
+#
+# case #17.2
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is set
+#  - GIT_DIR is not set
+#  - core.worktree is not set
+#  - .git is a directory
+#  - core.bare is set
+#
+# Output:
+#
+# GIT_WORK_TREE is ignored -> #16.2 (with warnings perhaps)
+
+test_expect_success '#17.2: setup' '
+	git config --file=3D"$TRASH_DIRECTORY/17/.git/config" core.bare true
+'
+
+test_expect_failure '#17.2: at .git' '
+	cat >17/.git/expected <<EOF &&
+setup: git_dir: .
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/17/.git
+setup: prefix: (null)
+EOF
+	test_repo 17/.git
+'
+
+test_expect_failure '#17.2: in .git/wt' '
+	cat >17/.git/wt/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/17/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/17/.git/wt
+setup: prefix: (null)
+EOF
+	test_repo 17/.git/wt
+'
+
+test_expect_failure '#17.2: in .git/wt/sub' '
+	cat >17/.git/wt/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/17/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/17/.git/wt/sub
+setup: prefix: (null)
+EOF
+	test_repo 17/.git/wt/sub
+'
+
+test_expect_failure '#17.2: at root' '
+	cat >17/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/17
+setup: prefix: (null)
+EOF
+	test_repo 17
+'
+
+test_expect_failure '#17.2: in subdir' '
+	cat >17/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/17/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/17/sub
+setup: prefix: (null)
+EOF
+	test_repo 17/sub
+'
+
 test_done
--=20
1.7.0.2.445.gcbdb3
