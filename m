From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 16/47] t1510: setup case #13
Date: Fri, 26 Nov 2010 22:32:12 +0700
Message-ID: <1290785563-15339-17-git-send-email-pclouds@gmail.com>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 16:39:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM0Oo-0003aP-Is
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 16:39:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753851Ab0KZPjl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 10:39:41 -0500
Received: from mail-px0-f174.google.com ([209.85.212.174]:55819 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627Ab0KZPjk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 10:39:40 -0500
Received: by pxi15 with SMTP id 15so352417pxi.19
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 07:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=3kC5LjEVUvkIs19iE4zdF66mMn0IEt8TCq2/bbMugDI=;
        b=ig1nPCTmNC7+CcnN1R2CG9dvaTjxWB2307tPUn9Y78F/1huONknswjDwe36F7hqy9x
         /SHTfmynwXlhGrQjJ6FenJmTiDRFKrFidiJVsc1kU9W4Vl3VvXwIhNTLxUOrFthdUq8W
         y2oWi5rxcETQqyrPk5dWJRgmFL2K45//gVBrI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=AMnYYsC1dlIhqeO7gSDVNIYRltWE4O8tFgK5b+09DNbRdjsW4WnlfkFSVw1MhKmslJ
         vi8NHXuVSkGUh9NmzmoiT6DFkAx3dPlGjYNiydHZTauGrcOFK4zO56RTWOkv24SMyBxA
         P+kpG9DR37MB2VxGVVNlrAkS5rjjVVdgR+Ee4=
Received: by 10.142.128.1 with SMTP id a1mr2513204wfd.282.1290785980449;
        Fri, 26 Nov 2010 07:39:40 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.252.168])
        by mx.google.com with ESMTPS id y42sm2676513wfd.22.2010.11.26.07.39.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 07:39:39 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 26 Nov 2010 22:38:24 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
In-Reply-To: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162232>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |   50 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index b86895f..c2cc504 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -1616,4 +1616,54 @@ EOF
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
+	GIT_WORK_TREE=3Dnon-existent-too &&
+	export GIT_WORK_TREE &&
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
1.7.3.2.316.gda8b3
