From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 05/42] t1510: setup case #2
Date: Fri, 29 Oct 2010 13:48:17 +0700
Message-ID: <1288334934-17216-6-git-send-email-pclouds@gmail.com>
References: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 08:50:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBimz-0005zS-8A
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 08:50:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755583Ab0J2GuF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 02:50:05 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64522 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755522Ab0J2GuD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 02:50:03 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so692674pwj.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 23:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=SHQNWoBy0/8F3xnXABI2na8soHcPSty73jS19c9MOuo=;
        b=YrNEM6KAg1PmRC2q6pK7hINh6RgqMEt8GM3z+KFNy+csTHoFDXXXZYYvyqIYF0+Zln
         Gy2cRdCLb/RB+NA0NHtKb+TJTCvG8q6ycNOliE3DEVGQCdVucq08oQUdpYOWDUfueabe
         BpMDq95brFOe9Qw+VCZYATEadkX0xddfimKPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=uUCz/4kAVATpYIOSmNkGk8HUeEyw0iAKK5ASBga4u2hIex2XI5utnqADyypZMx08yT
         RKqKDh3/7YgbAvj7qbhfdQ2G88b5I2EdyICV9hzmZ5uKCD6Ka5H1WQCQChI1QWslx1bz
         zfaRL+nj2dEqbPQv6X7GQGJUQPsf0eEkPQWvI=
Received: by 10.142.165.20 with SMTP id n20mr956771wfe.200.1288335003044;
        Thu, 28 Oct 2010 23:50:03 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id w42sm1030651wfh.3.2010.10.28.23.49.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 23:50:01 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 29 Oct 2010 13:50:02 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160273>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |   67 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 67 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index e5c366d..9b3ec8f 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -149,4 +149,71 @@ EOF
 	test_repo 1/sub
 '
=20
+#
+# case #2
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is not set
+#  - GIT_DIR is set
+#  - core.worktree is not set
+#  - .git is a directory
+#  - core.bare is not set, cwd is outside .git
+#
+# Output:
+#
+#  - worktree is at original cwd
+#  - cwd is unchanged
+#  - prefix is NULL
+#  - git_dir is set to $GIT_DIR
+#  - cwd can't be outside worktree
+
+test_expect_success '#2: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 2 2/sub &&
+	cd 2 && git init && cd ..
+'
+
+test_expect_success '#2: at root' '
+	cat >2/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/2/.git
+setup: worktree: $TRASH_DIRECTORY/2
+setup: cwd: $TRASH_DIRECTORY/2
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/2/.git" test_repo 2
+'
+
+test_expect_success '#2: in subdir' '
+	cat >2/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/2/.git
+setup: worktree: $TRASH_DIRECTORY/2/sub
+setup: cwd: $TRASH_DIRECTORY/2/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D"$TRASH_DIRECTORY/2/.git" test_repo 2/sub
+'
+
+test_expect_success '#2: relative GIT_DIR at root' '
+	cat >2/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/2
+setup: cwd: $TRASH_DIRECTORY/2
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D.git test_repo 2
+'
+
+test_expect_success '#2: relative GIT_DIR in subdir' '
+	cat >2/sub/expected <<EOF &&
+setup: git_dir: ../.git
+setup: worktree: $TRASH_DIRECTORY/2/sub
+setup: cwd: $TRASH_DIRECTORY/2/sub
+setup: prefix: (null)
+EOF
+	GIT_DIR=3D../.git test_repo 2/sub
+'
+
 test_done
--=20
1.7.0.2.445.gcbdb3
