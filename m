From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 32/47] t1510: setup case #29
Date: Fri, 26 Nov 2010 22:32:28 +0700
Message-ID: <1290785563-15339-33-git-send-email-pclouds@gmail.com>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 17:04:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM0mG-00039m-6Y
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 17:04:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752686Ab0KZQDx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 11:03:53 -0500
Received: from mail-pw0-f66.google.com ([209.85.160.66]:43149 "EHLO
	mail-pw0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566Ab0KZQDw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 11:03:52 -0500
Received: by pwj5 with SMTP id 5so472092pwj.1
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 08:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=8CgqRK5mS/sml/0+Yocs33s8EQTL3OAiAK5xHIWO2Q8=;
        b=tEv3GElhheczX6FRXNcOquaCNemckAY3LBm1hBOFk4DuRXk5lZnsQ0jstDXXiVDfeL
         UzVYTtVcnfhrBfokvvaZxTeMmdeAp5hQos0rOANv22ZrUsY7P+zQTfKP9K+Q7YphT85N
         s4WsCcE26kOeCEfbOqbvn+uXCGBKXUgupEwKA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=LsnauEl+b1x5cauEqzo4o65+BZukPPGJqeStqRJrdGdNYshKmr4azX0FtZlpzN/XF8
         jb+JRCQ80ctrbLM7R7rfOskcKsDBmX8dgltKZnca5SQwVzRcllag3fVHlSoqeIJ/M8F7
         dvv7aJDphFprKaAhClXidxJMCJqFjtfkIt95Q=
Received: by 10.143.162.5 with SMTP id p5mr2511547wfo.230.1290786376494;
        Fri, 26 Nov 2010 07:46:16 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.252.168])
        by mx.google.com with ESMTPS id v19sm2686786wfh.12.2010.11.26.07.46.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 07:46:15 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 26 Nov 2010 22:44:58 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
In-Reply-To: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162261>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |   50 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index d845758..2d1982f 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -4171,4 +4171,54 @@ EOF
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
+	GIT_WORK_TREE=3Dnon-existent &&
+	export GIT_WORK_TREE &&
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
1.7.3.2.316.gda8b3
