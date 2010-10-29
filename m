From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 04/42] t1510: setup case #1
Date: Fri, 29 Oct 2010 13:48:16 +0700
Message-ID: <1288334934-17216-5-git-send-email-pclouds@gmail.com>
References: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 08:50:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBimp-0005uP-2r
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 08:50:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755506Ab0J2Gt5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 02:49:57 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64522 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755346Ab0J2Gtz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 02:49:55 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so692674pwj.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 23:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=L16et1AlMzzP8Ii8ty9VTqrJLIbURhmhFoGLz+8dAM4=;
        b=ZaOZiL+IJT2xXYSDxNUzP90xzsMU2PplOePNeKRbAggkV+8yL9sHgTyCzxDDpDAk8l
         HJ/7CawUeBaBndmlwcD9g9Aa6WQ5VDSy7q+ftIloPGlHauBhVrd7UH+L2ytVJNGEDmmc
         I1+Ryohx9PjrKVqCPADXzHG/faa1tDwKaTwvc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=X1CLEKQXhtDTBZieeq8yG3rHcXBYwJZ84gtuyOct/H/GiM62fK8rUIS81zewbKolbh
         NS1lLo+FYMNHgTGgVG6GqPvrtJuDJnz5ddyjGm2Xs48XYAGZWhyG1cCX+6XsgJNCDF1J
         Mqnir2LHa1w1fzPC5gXaN396mD2lEwfR5Blh4=
Received: by 10.143.1.12 with SMTP id d12mr923628wfi.107.1288334995736;
        Thu, 28 Oct 2010 23:49:55 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id w26sm1024406wfd.9.2010.10.28.23.49.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 23:49:54 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 29 Oct 2010 13:49:55 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160272>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |   46 +++++++++++++++++++++++++++++++++++++++++=
+++++
 1 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 288e8a8..e5c366d 100755
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
