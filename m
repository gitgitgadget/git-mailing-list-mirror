From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 13/42] t1510: setup case #10
Date: Fri, 29 Oct 2010 13:48:25 +0700
Message-ID: <1288334934-17216-14-git-send-email-pclouds@gmail.com>
References: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 08:51:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBinv-0006NJ-Pt
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 08:51:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406Ab0J2GvF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 02:51:05 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64522 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932320Ab0J2GvC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 02:51:02 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so692674pwj.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 23:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=RCzHIlVOpuP0l3g7IaLptZ6v0X60Bb6PFCfSjsSh74Y=;
        b=DkdEcWGZ6E10mHzY0N9u7Od59WsVlmUKtu47cS4j5Ffr1DrSxaX+AGvgXH3bzl6q9Q
         Qw3uFcC/4a2XUJRof9l1yYV2EL22J0CGbfdTJAyP3QYJga4l4kTVBrq0yaDrjfHjt7Jq
         Hbyh0TaNuaQBpixr0a6aFFzpcz7y8OYwYBl1U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=mbP0TzzfRv00juj4pfbgzdj8ciPAvp5/VrqL7UhoIi+R2JBt8TYqnLcHlY0Kj4JzEg
         cJnLYZZvmkm8REC9cuq6a5mJVm5m/Kl7V/vR2Uo/06qZraKqldv0vo4ZBzzrvNHmyrdO
         cRRCmT29M7YL4uHbUZLh3YaX3pVHeEXQQ7RAk=
Received: by 10.142.126.18 with SMTP id y18mr1040784wfc.223.1288335061896;
        Thu, 28 Oct 2010 23:51:01 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id w42sm1022001wfh.15.2010.10.28.23.50.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 23:51:00 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 29 Oct 2010 13:51:01 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160281>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |   67 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 67 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index aea63ed..a680f4e 100755
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
