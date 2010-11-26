From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 29/47] t1510: setup case #26
Date: Fri, 26 Nov 2010 22:32:25 +0700
Message-ID: <1290785563-15339-30-git-send-email-pclouds@gmail.com>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 16:45:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM0UC-0006qe-BQ
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 16:45:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755290Ab0KZPpJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 10:45:09 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:46142 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686Ab0KZPpH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 10:45:07 -0500
Received: by pva4 with SMTP id 4so352060pva.19
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 07:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=PZdkp/X29TMiA3+uh3wnkqELwdUUxDF178bGqqk5Zgc=;
        b=UEPfoXGmChpCujIdlPfpnMmgIWm/C3AYigjo0ZuvWMZHBVYf+1FV70m8udD+YrCNvn
         GP21Zl2PRWYjM18SGBiQyNeMB/JjhoxGRADENKvzGc4Lee+ZTKjw8Cq15nT9gtVFSVmt
         Gtc5R8JV0vvVaaUB+ohlOqNHTAp/rAI6KS9Es=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ZMkCeV2oKTfGBS7XKPGGyM6WXyVa+UDPXwgWwFX/kQhtHvI2E3vE+FCs1RAtQdXLd2
         OQ8Sgztcnqdi5B1WoL0b7ACGGt78iqCC5X0Qr8m2jRzo64NdRlgg3iEZizARzdH2VJwq
         9xR/stucelUoAmPWVOfyAsBa141R3Su9FdTto=
Received: by 10.143.41.8 with SMTP id t8mr2523909wfj.89.1290786307389;
        Fri, 26 Nov 2010 07:45:07 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.252.168])
        by mx.google.com with ESMTPS id w22sm2681918wfd.7.2010.11.26.07.45.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 07:45:06 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 26 Nov 2010 22:43:58 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
In-Reply-To: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162245>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |   68 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 68 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index fa1ffac..0ad5e81 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -3786,4 +3786,72 @@ EOF
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
+	 test_repo 26 .git
+'
+
+test_expect_failure '#26: at root' '
+	cat >26/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/26.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/26
+setup: prefix: (null)
+EOF
+	 test_repo 26 "$TRASH_DIRECTORY/26/.git"
+'
+
+test_expect_failure '#26: (rel) in subdir' '
+	cat >26/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/26.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/26/sub
+setup: prefix: (null)
+EOF
+	test_repo 26/sub ../.git
+'
+
+test_expect_failure '#26: in subdir' '
+	cat >26/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/26.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/26/sub
+setup: prefix: (null)
+EOF
+	test_repo 26/sub "$TRASH_DIRECTORY/26/.git"
+'
+
 test_done
--=20
1.7.3.2.316.gda8b3
