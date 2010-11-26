From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 19/47] t1510: setup case #16
Date: Fri, 26 Nov 2010 22:32:15 +0700
Message-ID: <1290785563-15339-20-git-send-email-pclouds@gmail.com>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 16:40:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM0Pp-0004DR-Vw
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 16:40:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754001Ab0KZPkn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 10:40:43 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:58448 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075Ab0KZPkn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 10:40:43 -0500
Received: by mail-pz0-f46.google.com with SMTP id 6so349380pzk.19
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 07:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=l0JTtTsU6OgAEQ8pymWlYFea0yxd/pNoOPqRqp+uS70=;
        b=JrLF7KojU2k/b8LAYYSJDefEEf2NdrKcdhfzAHobX1va7dkr/jaRhvB06KAHr7Ydm7
         KO50oEJ2c6Sb5wYDvqqvuXMhZaMfVexDClAX2oc7ffQk8IqQevmDm4joMjOGYWGkJZNC
         7sCVRwzmOf5iguisHTd2H/4gLmF8o1wX89NKg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=PqF9FQmISjeVT2heaGq5A5hMKAYkNq8mAGFEx8Wn5iOav71uVtNwL9icJipH+61gtj
         QE4NPq7kOQhOy8P1slnhsIXLhMVKtDN5PzbIv/NtCNSSz8MwrH4FAYmY5IohhXq6cwlN
         WGL3PW3HxqERdCd+x4louW8x2UsYnj2wAumhw=
Received: by 10.142.88.18 with SMTP id l18mr2504521wfb.338.1290786043121;
        Fri, 26 Nov 2010 07:40:43 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.252.168])
        by mx.google.com with ESMTPS id y42sm2682222wfd.10.2010.11.26.07.40.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 07:40:42 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 26 Nov 2010 22:39:31 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
In-Reply-To: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162235>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t1510-repo-setup.sh |  135 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 135 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 732053d..0f7a2d9 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -2225,4 +2225,139 @@ EOF
 	test_repo 15/sub/sub "$TRASH_DIRECTORY/15/.git" "$TRASH_DIRECTORY"
 '
=20
+#
+# case #16.1
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is not set
+#  - GIT_DIR is not set
+#  - core.worktree is not set
+#  - .git is a directory
+#  - cwd is inside .git
+#
+# Output:
+#
+#  - no worktree
+#  - cwd is unchanged
+#  - prefix is NULL
+#  - git_dir is set
+#  - cwd can't be outside worktree
+
+test_expect_success '#16.1: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 16 16/sub &&
+	cd 16 &&
+	git init &&
+	mkdir .git/wt .git/wt/sub &&
+	cd ..
+'
+
+test_expect_success '#16.1: at .git' '
+	cat >16/.git/expected <<EOF &&
+setup: git_dir: .
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/16/.git
+setup: prefix: (null)
+EOF
+	test_repo 16/.git
+'
+
+test_expect_success '#16.1: in .git/wt' '
+	cat >16/.git/wt/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/16/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/16/.git/wt
+setup: prefix: (null)
+EOF
+	test_repo 16/.git/wt
+'
+
+test_expect_success '#16.1: in .git/wt/sub' '
+	cat >16/.git/wt/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/16/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/16/.git/wt/sub
+setup: prefix: (null)
+EOF
+	test_repo 16/.git/wt/sub
+'
+
+#
+# case #16.2
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is not set
+#  - GIT_DIR is not set
+#  - core.worktree is not set
+#  - .git is a directory
+#  - core.bare is set
+#
+# Output:
+#
+#  - no worktree
+#  - cwd is unchanged
+#  - prefix is NULL
+#  - git_dir is set
+#  - cwd can't be outside worktree
+
+test_expect_success '#16.2: setup' '
+	git config --file=3D"$TRASH_DIRECTORY/16/.git/config" core.bare true
+'
+
+test_expect_success '#16.2: at .git' '
+	cat >16/.git/expected <<EOF &&
+setup: git_dir: .
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/16/.git
+setup: prefix: (null)
+EOF
+	test_repo 16/.git
+'
+
+test_expect_success '#16.2: in .git/wt' '
+	cat >16/.git/wt/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/16/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/16/.git/wt
+setup: prefix: (null)
+EOF
+	test_repo 16/.git/wt
+'
+
+test_expect_success '#16.2: in .git/wt/sub' '
+	cat >16/.git/wt/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/16/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/16/.git/wt/sub
+setup: prefix: (null)
+EOF
+	test_repo 16/.git/wt/sub
+'
+
+test_expect_success '#16.2: at root' '
+	cat >16/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/16
+setup: prefix: (null)
+EOF
+	test_repo 16
+'
+
+test_expect_failure '#16.2: in subdir' '
+	cat >16/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/16/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/16/sub
+setup: prefix: (null)
+EOF
+	test_repo 16/sub
+'
+
 test_done
--=20
1.7.3.2.316.gda8b3
