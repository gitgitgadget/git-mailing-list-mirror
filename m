From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 15/42] t1510: setup case #12
Date: Fri, 29 Oct 2010 13:48:27 +0700
Message-ID: <1288334934-17216-16-git-send-email-pclouds@gmail.com>
References: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 08:51:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBio6-0006Px-Is
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 08:51:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932548Ab0J2GvS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 02:51:18 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64522 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932320Ab0J2GvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 02:51:16 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so692674pwj.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 23:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=xAdkpL2A85Md3Dov5GDRQIRawXYLQMbpckasJg3ppsg=;
        b=bn7sk+WfkWsDxGTsWK9CUG6Bf0rt2RNxbw1unKhsx/lnm92Wt0EfuBdEEfnlQokKdz
         Rm5ETQyO0lcLLbsYLrPA8j0OCc3nPg+C9ZmfAK8usTibz+giSKaKLlfttooNpnhE5xZF
         RHC7EOXloBdYm25HvOuPRKtGJ8iJ/srOEkvzg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=h0dhbq7Bow5AI0cWs8cVmIgByXnee8XoKl4lnMEtxY8RerxGVaYXpHklbhS/A1F4tm
         Mix0EYI5re9jI7ZRFC8Be1vxfCyPF1Y4gId6xHifMxFI2OMBdeBENLyrnyPPbDBH7NqE
         p5rU4GQL1eQIDwBuQNhmxePManFpmAC3Uqwrw=
Received: by 10.142.217.9 with SMTP id p9mr987642wfg.296.1288335076099;
        Thu, 28 Oct 2010 23:51:16 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id w42sm1033327wfh.3.2010.10.28.23.51.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 23:51:15 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 29 Oct 2010 13:51:15 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160282>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |   49 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 09efd9b..4a067ed 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -1561,4 +1561,53 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/11/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTOR=
Y" test_repo 11/sub/sub
 '
=20
+#
+# case #12
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is not set
+#  - GIT_DIR is not set
+#  - core.worktree is set
+#  - .git is a file
+#  - core.bare is not set, cwd is outside .git
+#
+# Output:
+#
+# #4 except that git_dir is set by .git file
+
+
+test_expect_success '#12: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 12 12/sub 12/sub/sub 12.wt 12.wt/sub 12/wt 12/wt/sub &&
+	cd 12 &&
+	git init &&
+	git config core.worktree non-existent &&
+	mv .git ../12.git &&
+	echo gitdir: ../12.git >.git &&
+	cd ..
+'
+
+test_expect_failure '#12: at root' '
+	cat >12/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/12.git
+setup: worktree: $TRASH_DIRECTORY/12
+setup: cwd: $TRASH_DIRECTORY/12
+setup: prefix: (null)
+EOF
+	test_repo 12
+'
+
+test_expect_failure '#12: in subdir' '
+	cat >12/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/12.git
+setup: worktree: $TRASH_DIRECTORY/12
+setup: cwd: $TRASH_DIRECTORY/12
+setup: prefix: sub/
+EOF
+	test_repo 12/sub
+'
+
 test_done
--=20
1.7.0.2.445.gcbdb3
