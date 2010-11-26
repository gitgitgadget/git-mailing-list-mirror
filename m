From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 12/47] t1510: setup case #9
Date: Fri, 26 Nov 2010 22:32:08 +0700
Message-ID: <1290785563-15339-13-git-send-email-pclouds@gmail.com>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 16:38:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM0NZ-0002vD-TD
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 16:38:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755017Ab0KZPiN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 10:38:13 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:46786 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754946Ab0KZPiL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 10:38:11 -0500
Received: by mail-pz0-f46.google.com with SMTP id 6so349039pzk.19
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 07:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=KPga0oUCRWC7FldMjdK0vRXwNmcWuw+hV+K4GWfkP4c=;
        b=vGlsdVDeZMx7kuJ49OHANEV94YpBqGKp1ov3tyofbQEsTDNPKRTSdgMnEK5RTabhxp
         OQD4AXHLlF0jPdQjsK8GBQZ4O7T/llXzrzONgi7LRI5U/m+wBmn5ZUNCGcuVabuT5zOC
         VKd3d4WJeoBKOCA/eCHweZQ6Fvg0dF8Zq2hQ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=qqJ6jRNViFMpbKDLy1IeESYWIE0siyzinZUqfZlP28o3gS8c/9iB9T+m9daFwQPh8Y
         TokHdNai8+/Sb24pU6/GRq4IRsP97Yw5kntlKOTrd3W85IMN0hKiAGu0SHm0H+aFuGXJ
         DOEgxd6pHYI8qvHY6dG6RC6udSoTzCnOTwLFM=
Received: by 10.142.98.3 with SMTP id v3mr2510121wfb.191.1290785890786;
        Fri, 26 Nov 2010 07:38:10 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.252.168])
        by mx.google.com with ESMTPS id y42sm2674880wfd.22.2010.11.26.07.38.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 07:38:09 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 26 Nov 2010 22:36:57 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
In-Reply-To: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162228>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |   49 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index d1601e8..e258869 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -1184,4 +1184,53 @@ EOF
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
+	GIT_WORK_TREE=3Dnon-existent &&
+	export GIT_WORK_TREE &&
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
+	test_repo 9
+'
+
+test_expect_failure '#9: in subdir' '
+	cat >9/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/9.git
+setup: worktree: $TRASH_DIRECTORY/9
+setup: cwd: $TRASH_DIRECTORY/9
+setup: prefix: sub/
+EOF
+	test_repo 9/sub
+'
+
 test_done
--=20
1.7.3.2.316.gda8b3
