From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 32/42] t1510: setup case #29
Date: Fri, 29 Oct 2010 13:48:44 +0700
Message-ID: <1288334934-17216-33-git-send-email-pclouds@gmail.com>
References: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 08:53:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBiq7-0007MO-15
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 08:53:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933401Ab0J2GxV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 02:53:21 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64522 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933348Ab0J2GxT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 02:53:19 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so692674pwj.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 23:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=md7UC4pfOFK1O5zfsUxmQK/fBIlyjV4s5k1L+NxxKeo=;
        b=Y9+axyRZhhsKGJZhar8qybKetvtjsVZJwWtyvF39M5tDOGjnD0QsTA4Cf58Dv/BBcM
         5mBeCvkrOvPAx+a5ijTT4tO5AUkBJKduZhP5vHp+QMaUaPCs/9FBRodV/6lSfgoP+GPO
         rlLpTWwqKi/DK0trAaZB95MsDSKNdZ8/ZyqHc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Cf9dM564aPLek5nWcH1e43ifRzRLWs2r2duPunzfBTm4MRexn1FwGOMzqjLFRYCtJP
         0ASeGtZBaugtxK7xNDvurEZmZrUimCDvbGAsXd1Zmo5NhyDokqGtx6SRSuPy0NZoQrug
         SE1YEd7LUcHva5JiqxqVcNoKsxOiO6nbQf9ts=
Received: by 10.142.153.11 with SMTP id a11mr1011994wfe.406.1288335199655;
        Thu, 28 Oct 2010 23:53:19 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id e36sm1026644wfj.14.2010.10.28.23.53.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 23:53:18 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 29 Oct 2010 13:53:19 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160300>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |   49 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 829e48f..e691d1c 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -4157,4 +4157,53 @@ EOF
 	test_repo 28/sub
 '
=20
+#
+# case #29
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is set
+#  - GIT_DIR is not set
+#  - core.worktree is set
+#  - .git is a file
+#  - core.bare is set
+#
+# Output:
+#
+# GIT_WORK_TREE/core.worktree are ignored -> #28
+
+test_expect_success '#29: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 29 29/sub &&
+	cd 29 &&
+	git init &&
+	git config core.bare true &&
+	export GIT_WORK_TREE=3Dnon-existent &&
+	mv .git ../29.git &&
+	echo gitdir: ../29.git >.git &&
+	cd ..
+'
+
+test_expect_failure '#29: at root' '
+	cat >29/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/29.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/29
+setup: prefix: (null)
+EOF
+	test_repo 29
+'
+
+test_expect_failure '#29: in subdir' '
+	cat >29/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/29.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/29/sub
+setup: prefix: (null)
+EOF
+	test_repo 29/sub
+'
+
 test_done
--=20
1.7.0.2.445.gcbdb3
