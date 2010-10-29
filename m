From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 21/42] t1510: setup case #18
Date: Fri, 29 Oct 2010 13:48:33 +0700
Message-ID: <1288334934-17216-22-git-send-email-pclouds@gmail.com>
References: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 08:52:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBion-0006fc-1R
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 08:52:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933206Ab0J2GwB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 02:52:01 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64522 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932830Ab0J2GwA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 02:52:00 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so692674pwj.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 23:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=O+0UZpVxCDDH/iYvIel7CzD3OspnF9Bn4S/5qEkvwaM=;
        b=HjlgKxnFb4XGTO3houlS09FRBWEPWsDKbtcR8VGAsdCXVSUzQzXGYhRmIe88MJjW6P
         L0TJr62DAvjmKbPANNOTXgiy2LAaYG5o8da3SsBTR3S7vUEwyqjb+u7giqo+hsERVqQ1
         4MpiFqjK/ei3FJKs3RMCtXUTyN4pl8AnYAhaw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=wv5kd0BmwOoOTkkdLrALZLuQNJ18rgwzIOWfgTrkEzfEFb5pGXIh7D8BqKmuuyMQXJ
         6n/LVgytg+v9+x06avT2Xs++1gEADgCRKhu4c0yOchRlFUPc+7lhO0vrTg4a2NkvcYUI
         dWrKAJmO4Tem4JVVCzAyYSge5o6tgcfuN0crQ=
Received: by 10.142.134.13 with SMTP id h13mr1072765wfd.137.1288335119821;
        Thu, 28 Oct 2010 23:51:59 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id p8sm1026022wff.16.2010.10.28.23.51.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 23:51:58 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 29 Oct 2010 13:51:59 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160289>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |   71 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 07abeac..13034e5 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -2481,4 +2481,75 @@ EOF
 	test_repo 17/sub
 '
=20
+#
+# case #18
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is not set
+#  - GIT_DIR is set
+#  - core.worktree is not set
+#  - .git is a directory
+#  - core.bare is set
+#
+# Output:
+#
+#  - no worktree (rule #8)
+#  - cwd is unchanged
+#  - prefix is NULL
+#  - git_dir is set to $GIT_DIR
+#  - cwd can't be outside worktree
+
+test_expect_success '#18: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 18 18/sub &&
+	cd 18 &&
+	git init &&
+	mkdir .git/wt .git/wt/sub &&
+	git config core.bare true &&
+	cd ..
+'
+
+test_expect_success '#18: (rel) at root' '
+	cat >18/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/18
+setup: prefix: (null)
+EOF
+	 GIT_DIR=3D.git test_repo 18
+'
+
+test_expect_success '#18: at root' '
+	cat >18/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/18/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/18
+setup: prefix: (null)
+EOF
+	 GIT_DIR=3D"$TRASH_DIRECTORY/18/.git" test_repo 18
+'
+
+test_expect_success '#18: (rel) in subdir' '
+	cat >18/sub/expected <<EOF &&
+setup: git_dir: ../.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/18/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D../.git test_repo 18/sub
+'
+
+test_expect_success '#18: in subdir' '
+	cat >18/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/18/.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/18/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/18/.git" test_repo 18/sub
+'
+
 test_done
--=20
1.7.0.2.445.gcbdb3
