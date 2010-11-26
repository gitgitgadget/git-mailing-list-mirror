From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 07/47] t1510: setup case #4
Date: Fri, 26 Nov 2010 22:32:03 +0700
Message-ID: <1290785563-15339-8-git-send-email-pclouds@gmail.com>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 16:36:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM0Lq-0001vN-6z
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 16:36:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752438Ab0KZPgh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 10:36:37 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:50481 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394Ab0KZPgg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 10:36:36 -0500
Received: by pzk6 with SMTP id 6so348886pzk.19
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 07:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=vIQXZVJXS7HhiNEayYNMuvrZLADuO4o6/fYdndstIO8=;
        b=DXXmi+OFWSU4tIHvzCIByTsbIfkd5a7XVwTlFBGaLzui4ocTm4yUHd2COFfWqpcXxn
         yQUa2fG9y47J2OHG6Bz4H0eBi8GyGOym//0OQsKyGuXEY1Z+J2uPEYb2y+SZE1mSmZ7S
         hDRcgakdzKzZm9lFv6QmcRg9n6kKwF7ElIqj8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=p45cjjFME7uwq4swKmzkDDY/sZHPt6zEEjzJWj9C3GTeBrjx/Qmc0GmOBkJ2asjwW6
         Z7e+v6VESrbU0lrgQVba+pOOI0XrE9JLcPG9tm3jpAC9FeFjmdyrZV5iFtiF2ZeQzKi+
         fHZnabuCBDbMOBu9gCdguHZK+ruzJtDkqU82o=
Received: by 10.143.16.20 with SMTP id t20mr2528906wfi.103.1290785796110;
        Fri, 26 Nov 2010 07:36:36 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.252.168])
        by mx.google.com with ESMTPS id p8sm2675122wff.16.2010.11.26.07.36.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 07:36:35 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 26 Nov 2010 22:35:24 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
In-Reply-To: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162223>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t1510-repo-setup.sh |   46 +++++++++++++++++++++++++++++++++++++++++=
+++++
 1 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 9fff0b6..655f603 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -486,4 +486,50 @@ EOF
 	test_repo 3/sub/sub "$TRASH_DIRECTORY/3/.git" "$TRASH_DIRECTORY"
 '
=20
+#
+# case #4
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is not set
+#  - GIT_DIR is not set
+#  - core.worktree is set
+#  - .git is a directory
+#  - core.bare is not set, cwd is outside .git
+#
+# Output:
+#
+# core.worktree is ignored -> #0
+
+test_expect_success '#4: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 4 4/sub &&
+	cd 4 &&
+	git init &&
+	git config core.worktree non-existent &&
+	cd ..
+'
+
+test_expect_failure '#4: at root' '
+	cat >4/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/4
+setup: cwd: $TRASH_DIRECTORY/4
+setup: prefix: (null)
+EOF
+	test_repo 4
+'
+
+test_expect_failure '#4: in subdir' '
+	cat >4/sub/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/4
+setup: cwd: $TRASH_DIRECTORY/4
+setup: prefix: sub/
+EOF
+	test_repo 4/sub
+'
+
 test_done
--=20
1.7.3.2.316.gda8b3
