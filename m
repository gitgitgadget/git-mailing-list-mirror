From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 07/42] t1510: setup case #4
Date: Fri, 29 Oct 2010 13:48:19 +0700
Message-ID: <1288334934-17216-8-git-send-email-pclouds@gmail.com>
References: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 08:50:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBinH-00066q-KQ
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 08:50:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756135Ab0J2GuU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 02:50:20 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64522 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755673Ab0J2GuS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 02:50:18 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so692674pwj.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 23:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=ORMW+KmNvtB6sgjHd8uYAoNrkoijbhN3Z2Ki2Foi74s=;
        b=gvh4+YS2J8xbNKuOiT95y2a9UHBSFKg/nJLzX2qIW/BZ0Y/5h0J2PP5emrGvpbXXbF
         F7bWOIOcHNPdrmm4oc9l53M3AiPf9zzY44nxG7RK2fZMqWY5AlW8rqbOVoghgIEBKO0g
         NxlwtH7dgsX10w0sVK1ccZv86cCRepn4QjETs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=oHMuBo//NbCQSDGA9aXVAg5VJfE0K6vHXlUG5QXr5mZPtYalN9lsEJV6SCX0Hmyt8M
         5ZmhpWAorNtPOtLCtUncrtmaCz+tenyJI1iIpizzC2CWvPuH5iYCwdzG53U2Epi60MaV
         UY1SD2LUakB2o/dYZjf7b0I9zCgua342IHi+w=
Received: by 10.142.81.2 with SMTP id e2mr1041729wfb.180.1288335017849;
        Thu, 28 Oct 2010 23:50:17 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id x18sm1022704wfa.11.2010.10.28.23.50.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 23:50:16 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 29 Oct 2010 13:50:17 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160275>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |   46 +++++++++++++++++++++++++++++++++++++++++=
+++++
 1 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 3a163d0..93cc9fb 100755
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
