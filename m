From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 23/47] t1510: setup case #20
Date: Fri, 26 Nov 2010 22:32:19 +0700
Message-ID: <1290785563-15339-24-git-send-email-pclouds@gmail.com>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 16:42:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM0RZ-0005Ij-Ux
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 16:42:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754786Ab0KZPmd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 10:42:33 -0500
Received: from mail-px0-f174.google.com ([209.85.212.174]:63764 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752240Ab0KZPmd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 10:42:33 -0500
Received: by pxi15 with SMTP id 15so352794pxi.19
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 07:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Uk+//64hpucsWiFq9FkyraVruoxPRE6lFSEluB8ZuXk=;
        b=N37g8djX9TAk/B0rvVvnTyRf5pRjdvH20FopPwqyB1fNaFpWOY8PFwskWAwZwFdpTJ
         QHLpZ+WcEn4ayzacjgoSXzNJkrNmHCEbujv1ku3OernIIbdn03czOYI/cmCJrAncXjAJ
         rHSCOIyaC4eWqeqa+bJ0xcHXDTDGFGfvld8HA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=lcmSQ7qnoDZmvxbc2KZZ0Dz5YvhpD+RPf6FOedM+MxJfx/LLMjQtPZgTu9vnK1U9mD
         cM5mmjAKTJNyFJ5hfHlPV8umRoT33zv8+6J2OXnNplWGWyy/sq3ZJdWpz9nVt8mauh5J
         yikacS0hmv0ZKyuFODeHfkooSc8IxKBmMe2is=
Received: by 10.142.136.3 with SMTP id j3mr2553504wfd.38.1290786152745;
        Fri, 26 Nov 2010 07:42:32 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.252.168])
        by mx.google.com with ESMTPS id w42sm2681225wfh.15.2010.11.26.07.42.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 07:42:31 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 26 Nov 2010 22:41:00 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
In-Reply-To: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162239>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t1510-repo-setup.sh |  128 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 128 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 954e7fe..db52f36 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -2826,4 +2826,132 @@ EOF
 	test_repo 19/sub/sub "$TRASH_DIRECTORY/19/.git" "$TRASH_DIRECTORY"
 '
=20
+#
+# case #20.1
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is not set
+#  - GIT_DIR is not set
+#  - core.worktree is set
+#  - .git is a directory
+#  - cwd is inside .git
+#
+# Output:
+#
+# core.worktree is ignored -> #16.1
+
+test_expect_success '#20.1: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 20 20/sub &&
+	cd 20 &&
+	git init &&
+	git config core.worktree non-existent &&
+	mkdir .git/wt .git/wt/sub &&
+	cd ..
+'
+
+test_expect_failure '#20.1: at .git' '
+	cat >20/.git/expected <<EOF &&
+setup: git_dir: .
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/20/.git
+setup: prefix: (null)
+EOF
+	test_repo 20/.git
+'
+
+test_expect_failure '#20.1: in .git/wt' '
+	cat >20/.git/wt/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/20/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/20/.git/wt
+setup: prefix: (null)
+EOF
+	test_repo 20/.git/wt
+'
+
+test_expect_failure '#20.1: in .git/wt/sub' '
+	cat >20/.git/wt/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/20/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/20/.git/wt/sub
+setup: prefix: (null)
+EOF
+	test_repo 20/.git/wt/sub
+'
+
+#
+# case #20.2
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is not set
+#  - GIT_DIR is not set
+#  - core.worktree is set
+#  - .git is a directory
+#  - core.bare is set
+#
+# Output:
+#
+# core.worktree is ignored -> #16.2
+
+test_expect_success '#20.2: setup' '
+	git config --file=3D"$TRASH_DIRECTORY/20/.git/config" core.bare true
+'
+
+test_expect_success '#20.2: at .git' '
+	cat >20/.git/expected <<EOF &&
+setup: git_dir: .
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/20/.git
+setup: prefix: (null)
+EOF
+	test_repo 20/.git
+'
+
+test_expect_success '#20.2: in .git/wt' '
+	cat >20/.git/wt/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/20/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/20/.git/wt
+setup: prefix: (null)
+EOF
+	test_repo 20/.git/wt
+'
+
+test_expect_success '#20.2: in .git/wt/sub' '
+	cat >20/.git/wt/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/20/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/20/.git/wt/sub
+setup: prefix: (null)
+EOF
+	test_repo 20/.git/wt/sub
+'
+
+test_expect_success '#20.2: at root' '
+	cat >20/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/20
+setup: prefix: (null)
+EOF
+	test_repo 20
+'
+
+test_expect_failure '#20.2: in subdir' '
+	cat >20/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/20/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/20/sub
+setup: prefix: (null)
+EOF
+	test_repo 20/sub
+'
+
 test_done
--=20
1.7.3.2.316.gda8b3
