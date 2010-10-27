From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 07/34] t1510: setup case #4
Date: Wed, 27 Oct 2010 21:49:10 +0700
Message-ID: <1288190977-30875-8-git-send-email-pclouds@gmail.com>
References: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 27 16:50:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB7Kz-0006Y9-2p
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 16:50:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933380Ab0J0Oug convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 10:50:36 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:54499 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932499Ab0J0Oue (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 10:50:34 -0400
Received: by gxk23 with SMTP id 23so426005gxk.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 07:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Y7IVF6R82DlFHD7qZQnDGx75tgPrRwEHb+ZbCkEA8rM=;
        b=ds0v8K7uPXcOG8TV7P86vr+Ax8lD6QtxqTyidIbaq7aIR8E2/OJcHi7SVot3gXZNEs
         HDNKiYIRSKoZ8gXuySHrSDWzoFUGS9e01/zQucV0HDqXMbV4FK8vh/dA5Jd1tzQqW5+v
         0AOQXHtQV8ruDodR0Hn+xGcilOMne/mGellJI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=j0FCvBn0s5rGTvOfyf8chmGj1CapGSHArtvy6/FHbLZPCGMGpDgwyRGGyTLzB1DexG
         bjCMkKvYsLGFoy6GIU4pRIAyb40eQHIMSHNSlSZEM55OPc6p8bsmilaUIKVbdNyzUrmZ
         v33CHSLyiFxjCUtxhFw4pA2KEyamGm0JuG+8E=
Received: by 10.151.156.19 with SMTP id i19mr17875542ybo.82.1288191033414;
        Wed, 27 Oct 2010 07:50:33 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id z30sm7712119yhc.9.2010.10.27.07.50.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 07:50:32 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 27 Oct 2010 21:50:31 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160048>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |   46 +++++++++++++++++++++++++++++++++++++++++=
+++++
 1 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index e1b8958..6617792 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -483,4 +483,50 @@ EOF
 	GIT_DIR=3D"$TRASH_DIRECTORY/3/.git" GIT_WORK_TREE=3D"$TRASH_DIRECTORY=
" test_repo 3/sub/sub
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
1.7.0.2.445.gcbdb3
