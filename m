From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 12/42] t1510: setup case #9
Date: Fri, 29 Oct 2010 13:48:24 +0700
Message-ID: <1288334934-17216-13-git-send-email-pclouds@gmail.com>
References: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 08:51:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBink-0006Je-Nq
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 08:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257Ab0J2Gu5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 02:50:57 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64522 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756362Ab0J2Guz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 02:50:55 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so692674pwj.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 23:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=xkprcqOHKu5idzWzkhQnmEi9pJZyDt2nT4ZgEn+QOMQ=;
        b=A8jRpqDMDIPmIrIJOfUae0eOFcCz0WNNNd7W1gWuBZfTidnSH3ls06bLVvcCKlGhMn
         sIAl/nLV3lVxmy3oUXXrAQ5BweuPepMMlRNynVfU1r1BDvm8UioWg+kQ8zu/Nuk1DlL6
         YF4ZeCiNRLlx/7yXIeVKYM4GMOylQjZJTDr7g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=XrvOx5nxz/9CHK7QahIUwjpFQZ7bbpfKBi58tWPGKszgNM23PqEVela0e3WSBHrYCX
         OW5kLBtITQtxWlJRNDUa5abtcVwng3CM/coZtburX9uhEWgToseCseO1j4Rw5Zpqf1za
         P71kZJhlvkY0yGY6G+77NTq+AstR05SCfwi3o=
Received: by 10.142.88.8 with SMTP id l8mr993533wfb.245.1288335054975;
        Thu, 28 Oct 2010 23:50:54 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id v19sm1025621wfh.12.2010.10.28.23.50.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 23:50:53 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 29 Oct 2010 13:50:54 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160279>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |   47 +++++++++++++++++++++++++++++++++++++++++=
++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 769009d..aea63ed 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -1180,4 +1180,51 @@ EOF
 	test_repo 8/sub
 '
=20
+#
+# case #9
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is set
+#  - GIT_DIR is not set
+#  - core.worktree is not set
+#  - .git is a file
+#  - core.bare is not set, cwd is outside .git
+#
+# Output:
+#
+# #1 except that git_dir is set by .git file
+
+test_expect_success '#9: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 9 9/sub 9.wt 9.wt/sub 9/wt 9/wt/sub &&
+	cd 9 &&
+	git init &&
+	mv .git ../9.git &&
+	echo gitdir: ../9.git >.git &&
+	cd ..
+'
+
+test_expect_failure '#9: at root' '
+	cat >9/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/9.git
+setup: worktree: $TRASH_DIRECTORY/9
+setup: cwd: $TRASH_DIRECTORY/9
+setup: prefix: (null)
+EOF
+	GIT_WORK_TREE=3Dnon-existent test_repo 9
+'
+
+test_expect_failure '#9: in subdir' '
+	cat >9/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/9.git
+setup: worktree: $TRASH_DIRECTORY/9
+setup: cwd: $TRASH_DIRECTORY/9
+setup: prefix: sub/
+EOF
+	GIT_WORK_TREE=3Dnon-existent test_repo 9/sub
+'
+
 test_done
--=20
1.7.0.2.445.gcbdb3
