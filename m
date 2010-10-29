From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 16/42] t1510: setup case #13
Date: Fri, 29 Oct 2010 13:48:28 +0700
Message-ID: <1288334934-17216-17-git-send-email-pclouds@gmail.com>
References: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 08:51:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBioK-0006Vy-VS
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 08:51:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932700Ab0J2GvY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 02:51:24 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64522 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932320Ab0J2GvX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 02:51:23 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so692674pwj.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 23:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=4AewJl4Pv9U+7jkYcVM5rhWFlOTVjlSpZOJ5lRAxGAs=;
        b=vyvYPuoc/b3M4ZS4bg0Vv7SiGkRZkUkZ1j0DbT/oLbmoxxAxbAWV+J6e1WDiVOWlEU
         7QoxhLfddYJ/1b7n5iL03C2jj9whxF30ZRkEBNCcyO/OFeqyFDmBX00sNXKoU8sauwy7
         TDNIUAdV7GZU2EUEXJlP/u1vx6JyGBJdQHsr8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ov3dT8o6DbcwG3K8lorRX+PNv/6sJGstfBXtaNF6SF0cPUyIZeDmyRaLeJ13B9KAut
         qe8znlC5laV6emOnyktfPZrAKXEilewZgyWFpkvDlDAQikA4ib3IEkIRPMCcoVy7l776
         /m3aaRZRNb8LIvowgmXRb8daVIUH8U2tyyWkM=
Received: by 10.142.191.15 with SMTP id o15mr958136wff.279.1288335083155;
        Thu, 28 Oct 2010 23:51:23 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id e36sm1022399wfj.14.2010.10.28.23.51.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 23:51:22 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 29 Oct 2010 13:51:22 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160284>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |   49 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 4a067ed..fd63ad4 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -1610,4 +1610,53 @@ EOF
 	test_repo 12/sub
 '
=20
+#
+# case #13
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is set
+#  - GIT_DIR is not set
+#  - core.worktree is set
+#  - .git is a file
+#  - core.bare is not set, cwd is outside .git
+#
+# Output:
+#
+# #5 except that git_dir is set by .git file
+
+test_expect_success '#13: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 13 13/sub 13/sub/sub 13.wt 13.wt/sub 13/wt 13/wt/sub &&
+	cd 13 &&
+	git init &&
+	git config core.worktree non-existent &&
+	export GIT_WORK_TREE=3Dnon-existent too &&
+	mv .git ../13.git &&
+	echo gitdir: ../13.git >.git &&
+	cd ..
+'
+
+test_expect_failure '#13: at root' '
+	cat >13/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/13.git
+setup: worktree: $TRASH_DIRECTORY/13
+setup: cwd: $TRASH_DIRECTORY/13
+setup: prefix: (null)
+EOF
+	test_repo 13
+'
+
+test_expect_failure '#13: in subdir' '
+	cat >13/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/13.git
+setup: worktree: $TRASH_DIRECTORY/13
+setup: cwd: $TRASH_DIRECTORY/13
+setup: prefix: sub/
+EOF
+	test_repo 13/sub
+'
+
 test_done
--=20
1.7.0.2.445.gcbdb3
