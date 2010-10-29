From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 19/42] t1510: setup case #16
Date: Fri, 29 Oct 2010 13:48:31 +0700
Message-ID: <1288334934-17216-20-git-send-email-pclouds@gmail.com>
References: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 08:51:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBioY-0006ZH-7w
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 08:51:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933026Ab0J2Gvs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 02:51:48 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64522 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932830Ab0J2Gvq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 02:51:46 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so692674pwj.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 23:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Hh0+954ovO2/00EhTno72HhN3aCPS1XrJTC514dNd8c=;
        b=SOfRij9o3CG8VTclFEz4JhUt3QdcX7CXXwabg76E3BJ2l5S/BeJXbaSiqgPBWV8LQI
         h4E1Q43UJUj3kJaqSiTryAiT8k0IUSfGsAp4Ozb5n3sLwV6mcqU8smjm++ZgsXLigBiw
         /wpbAT4+AFHcrE0wu374/putj8UCZHvg8fuXk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=rAVR7xdngG353Hexg9xN5UBDvKyguLkMMWZn597TUT/KNrEVS4d57hgO8hcoe/aesO
         2QjBbT9aOBVjN2I60K2P9EzrRsKyrkmEZ4hw9MVDQWc5ISyoSwELD3wQBUFUc6mLHZG4
         1990jUSIaFbPTPppN4zB3FAyK0aw2i1bZ23fk=
Received: by 10.142.188.17 with SMTP id l17mr1034029wff.35.1288335105708;
        Thu, 28 Oct 2010 23:51:45 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id w14sm1021610wfd.18.2010.10.28.23.51.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 23:51:44 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 29 Oct 2010 13:51:45 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160287>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |  135 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 135 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index d10ab68..491bcf6 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -2218,4 +2218,139 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/15/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y" test_repo 15/sub/sub
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
1.7.0.2.445.gcbdb3
