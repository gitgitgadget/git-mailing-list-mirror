From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 33/34] t1510: setup case #30
Date: Wed, 27 Oct 2010 21:49:36 +0700
Message-ID: <1288190977-30875-34-git-send-email-pclouds@gmail.com>
References: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 27 16:54:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB7OC-0000NW-Cs
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 16:54:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933623Ab0J0Oxy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 10:53:54 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:56279 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933609Ab0J0Oxw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 10:53:52 -0400
Received: by mail-yx0-f174.google.com with SMTP id 8so67902yxk.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 07:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=FEqdWk2y0UHmx/NzXWWiu37z36b/vRxIzb5Y21zFoL0=;
        b=ZgEx3ssthu6n8dUJkLl6FXDoAjwlevxf6rKjUkUimYpNorWT/hJBl56LrsC6ON2MWg
         hUspxdDV4Z3P9qUoHLwhS9NV6ay6F5nR7jzQrcrWE1NyQwkqCJBYHQV++uZ2d34Hhw7a
         1NRr3OQTfL8mn4oJQQu1ikp7FrvlkOjng0I/8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Fu4566sF/HfndfQYaeqh8oOlnR50riIFNxTcWQvD1QgbM6l83oRaTIDJfnZgiI09bv
         U/2M+co7Irec31IlsfhNYSGEIdZtS8IxAU+ntUlsYyWBU7rNZKUWYrd+zhEVP20M4nr3
         t3Z41hsJGlR8JWNkDKhjeoQngu1glnxyVY2lg=
Received: by 10.150.186.12 with SMTP id j12mr5491193ybf.390.1288191230587;
        Wed, 27 Oct 2010 07:53:50 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id 43sm7707729yhl.37.2010.10.27.07.53.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 07:53:49 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 27 Oct 2010 21:53:48 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160072>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 201761f..b095e24 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -4206,4 +4206,41 @@ EOF
 	test_repo 29/sub
 '
=20
+#
+# case #30
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is not set
+#  - GIT_DIR is set
+#  - core.worktree is set
+#  - .git is a file
+#  - core.bare is set
+#
+# Output:
+#
+# core.worktree and core.bare conflict, won't fly.
+
+test_expect_success '#30: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 30 &&
+	cd 30 &&
+	git init &&
+	git config core.bare true &&
+	git config core.worktree non-existent &&
+	mv .git ../30.git &&
+	echo gitdir: ../30.git >.git &&
+	cd ..
+'
+
+test_expect_failure '#30: at root' '
+	(
+	cd 30 &&
+	GIT_DIR=3D.git test_must_fail git symbolic-ref HEAD 2>result &&
+	grep "core.bare and core.worktree do not make sense" result
+	)
+'
+
 test_done
--=20
1.7.0.2.445.gcbdb3
