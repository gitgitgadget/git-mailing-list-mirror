From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 29/42] t1510: setup case #26
Date: Fri, 29 Oct 2010 13:48:41 +0700
Message-ID: <1288334934-17216-30-git-send-email-pclouds@gmail.com>
References: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 08:53:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBipp-0007Fk-Tq
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 08:53:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933358Ab0J2GxA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 02:53:00 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64522 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933348Ab0J2Gw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 02:52:58 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so692674pwj.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 23:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=8Ll8hP6a6Lj5BsGUSOr+PN/gZ5HyGafqfgBMdcyvbKs=;
        b=pAyKrqrcj7xfeMZ+mFIty74SD+TXJNZru8QndWP2MJqXYO0Z54WxPqXYEak1fe7WtK
         jHZqgdjWIHAgYkG1WvtXs2oc/74cq4f3BPV0uw5ip4AgJ0mMFXm+JMVAKujZlUNKAUbQ
         4nTxRbk7kPf0AxAvpXEKNID+z9UqrsoYdkyZY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=juCuTMmsqHl46AjMtrI6Xl7yMoBC+Eg6V2/u4nW9s+d2b07a8KHOLxfMnrjm40013b
         CtZJYclRDh/9jKW3VOBeWTPanj9NuPw5wCUhNJ1GLciwaiWVP9G8cqcWpZWcsbzKhHNz
         bfk2TbfhhozV7vs9RWu8KMwV3qUNv9vrMiByc=
Received: by 10.142.166.20 with SMTP id o20mr989840wfe.382.1288335177887;
        Thu, 28 Oct 2010 23:52:57 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id w42sm1026207wfh.15.2010.10.28.23.52.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 23:52:56 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 29 Oct 2010 13:52:57 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160297>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |   68 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 68 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index a853337..270af69 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -3772,4 +3772,72 @@ EOF
 	test_repo 25/sub
 '
=20
+#
+# case #26
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is not set
+#  - GIT_DIR is set
+#  - core.worktree is not set
+#  - .git is a file
+#  - core.bare is set
+#
+# Output:
+#
+# #18 except git_dir is set according to .git file
+
+test_expect_success '#26: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 26 26/sub &&
+	cd 26 &&
+	git init &&
+	git config core.bare true &&
+	mv .git ../26.git &&
+	echo gitdir: ../26.git >.git &&
+	cd ..
+'
+
+test_expect_failure '#26: (rel) at root' '
+	cat >26/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/26.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/26
+setup: prefix: (null)
+EOF
+	 GIT_DIR=3D.git test_repo 26
+'
+
+test_expect_failure '#26: at root' '
+	cat >26/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/26.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/26
+setup: prefix: (null)
+EOF
+	 GIT_DIR=3D"$TRASH_DIRECTORY/26/.git" test_repo 26
+'
+
+test_expect_failure '#26: (rel) in subdir' '
+	cat >26/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/26.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/26/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D../.git test_repo 26/sub
+'
+
+test_expect_failure '#26: in subdir' '
+	cat >26/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/26.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/26/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/26/.git" test_repo 26/sub
+'
+
 test_done
--=20
1.7.0.2.445.gcbdb3
