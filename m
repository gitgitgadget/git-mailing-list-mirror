From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 28/42] t1510: setup case #25
Date: Fri, 29 Oct 2010 13:48:40 +0700
Message-ID: <1288334934-17216-29-git-send-email-pclouds@gmail.com>
References: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 08:52:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBipb-00079f-AN
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 08:52:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933339Ab0J2Gww convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 02:52:52 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64522 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933290Ab0J2Gwv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 02:52:51 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so692674pwj.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 23:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=JD9mECFwsmk8fVGEqcnkt/cCtJFGwTNrTAbA8qtGHrk=;
        b=wYwDisLalCJ2eEzedK8n9wr3lXXjUbDLjg7HGTTlS1Bf4EP1g+bZDATP4EsT85myt4
         ZG9ativ4sS5YGmzCkpO5/aXOgpvFkrIAV3/xZntSx+04MWlf5p6dp4N06fpEgTuZPwXN
         3U8Vzs7LzgVm19Oaue3ShDWxg3GXxC1S33o38=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=nxzWoYxDM6Twy2m4/LKhNlrnvoxO+zaXVZ5hoxXkQl594OavADq5lMoUJ+iHwNpW5G
         /k4KHCdvswWt3RhOAUV9eYr/1rJv12/nZ8MV0VIdR4G7AYHRHyDIB6VbxKr/i+cUySyq
         64K1sMxFrXXVqRTaUs+BsRg7LbuVCJpKzDTzw=
Received: by 10.143.40.1 with SMTP id s1mr994191wfj.379.1288335170958;
        Thu, 28 Oct 2010 23:52:50 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id e36sm1025649wfj.14.2010.10.28.23.52.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 23:52:49 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 29 Oct 2010 13:52:50 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160296>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |   49 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 1965838..a853337 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -3723,4 +3723,53 @@ EOF
 	test_repo 24/sub
 '
=20
+#
+# case #25
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is set
+#  - GIT_DIR is not set
+#  - core.worktree is not set
+#  - .git is a file
+#  - core.bare is set
+#
+# Output:
+#
+# #17.2 except git_dir is set according to .git file
+
+test_expect_success '#25: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 25 25/sub &&
+	cd 25 &&
+	git init &&
+	git config core.bare true &&
+	export GIT_WORK_TREE=3Dnon-existent &&
+	mv .git ../25.git &&
+	echo gitdir: ../25.git >.git &&
+	cd ..
+'
+
+test_expect_failure '#25: at root' '
+	cat >25/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/25.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/25
+setup: prefix: (null)
+EOF
+	test_repo 25
+'
+
+test_expect_failure '#25: in subdir' '
+	cat >25/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/25.git
+setup: worktree: (null)
+setup: cwd: $TRASH_DIRECTORY/25/sub
+setup: prefix: (null)
+EOF
+	test_repo 25/sub
+'
+
 test_done
--=20
1.7.0.2.445.gcbdb3
