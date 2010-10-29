From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 31/42] t1510: setup case #28
Date: Fri, 29 Oct 2010 13:48:43 +0700
Message-ID: <1288334934-17216-32-git-send-email-pclouds@gmail.com>
References: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 08:53:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBiq6-0007MO-Gz
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 08:53:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933392Ab0J2GxQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 02:53:16 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64522 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933348Ab0J2GxM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 02:53:12 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so692674pwj.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 23:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=xda+EXk+Ui7Lx1zdSnz9c/DVIABg+7Fvc2mSZv2iljs=;
        b=AO9/er6Y52hnxE2cHNZFp9dHmLxhPWdiXJrkL7e6/KAHeBfuOtTVp5Q4Bx52HXCpY9
         ZMjHERnaTKJnQ1FxeVUBc2eo52eHoMcOiQM+5DuUe0BAPo66b6F/k9k9J5DETlc++le1
         w8+BfYb/HBgytQOEQ9e2pGy/S8UzfY0ePZyeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=oe06kYjwDjTiJnihLW+aZUGYOrUW4SK33x5o83JxP6YpL7SI3LIanQ9O/mC7TjYjYs
         /rkUreMZlN3+el2/dABNsWvjoKUKWUoX6qmoYzZzW1UDRDaFD2Pf9EZew71JdIdynpqa
         wO4N40TgWNOkdebifB3XXuTSRCThjCwDj1fiU=
Received: by 10.142.162.14 with SMTP id k14mr1002363wfe.353.1288335192695;
        Thu, 28 Oct 2010 23:53:12 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id w26sm1031582wfd.9.2010.10.28.23.53.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 23:53:11 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 29 Oct 2010 13:53:12 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160299>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |   49 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index e8e8d82..829e48f 100755
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
