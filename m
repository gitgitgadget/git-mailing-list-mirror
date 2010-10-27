From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 04/34] t1510: setup case #1
Date: Wed, 27 Oct 2010 21:49:07 +0700
Message-ID: <1288190977-30875-5-git-send-email-pclouds@gmail.com>
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
	id 1PB7KV-0006Fq-BK
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 16:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759641Ab0J0OuN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 10:50:13 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:60395 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756244Ab0J0OuL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 10:50:11 -0400
Received: by mail-gy0-f174.google.com with SMTP id 4so415888gyg.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 07:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=J2MEx9B02JjV2zfjfko1ZXPYQ2Fkuw8mCdAl5emy9cA=;
        b=jQzMhV4qEFH3oanpFEHP05PcvhHMjDaXr+0ozKZvoVs55nUsnUKPuxNsc8joYcmGl6
         fQArtGqNMxvVN3pciNXqF9zhWtdaFSaBxG7sdGo+eRJcm3mhdI4siCx4MZkRDLJUYxJ2
         H5X0FJRyh/4cz+jqvAr8S6U5oS37dgcVRddhU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=hUM7tIATWQolniRgNcDzEOWn2yAhzVmNWYyUg8WHXKN7yoFQK458eGgVpem8x1VWv2
         K6vzBmtP1SCCn+Dc6dyZbDFWsfV84eZLXBhPqHhI1UdDEoJc1BQx8k8C0B7Dog4CUiSP
         PmqggrTgZpL4SRyvVo+S/s2pSYD55IajM3IOE=
Received: by 10.150.134.21 with SMTP id h21mr2256595ybd.174.1288191010916;
        Wed, 27 Oct 2010 07:50:10 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id q18sm4996707ybk.15.2010.10.27.07.50.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 07:50:09 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 27 Oct 2010 21:50:08 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160042>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |   46 +++++++++++++++++++++++++++++++++++++++++=
+++++
 1 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index d94a2d6..0ff659a 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -103,4 +103,50 @@ EOF
 	test_repo 0/sub
 '
=20
+#
+# case #1
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is set
+#  - GIT_DIR is not set
+#  - core.worktree is not set
+#  - .git is a directory
+#  - core.bare is not set, cwd is outside .git
+#
+# Output:
+#
+# GIT_WORK_TREE is ignored -> #0
+
+test_expect_success '#1: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 1 1/sub 1.wt 1.wt/sub 1/wt 1/wt/sub &&
+	cd 1 &&
+	git init &&
+	export GIT_WORK_TREE=3Dnon-existent &&
+	cd ..
+'
+
+test_expect_failure '#1: at root' '
+	cat >1/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/1
+setup: cwd: $TRASH_DIRECTORY/1
+setup: prefix: (null)
+EOF
+	test_repo 1
+'
+
+test_expect_failure '#1: in subdir' '
+	cat >1/sub/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/1
+setup: cwd: $TRASH_DIRECTORY/1
+setup: prefix: sub/
+EOF
+	test_repo 1/sub
+'
+
 test_done
--=20
1.7.0.2.445.gcbdb3
