From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 32/34] t1510: setup case #29
Date: Wed, 27 Oct 2010 21:49:35 +0700
Message-ID: <1288190977-30875-33-git-send-email-pclouds@gmail.com>
References: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 27 16:54:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB7OB-0000NW-Sc
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 16:54:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933614Ab0J0Oxp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 10:53:45 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37043 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933609Ab0J0Oxn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 10:53:43 -0400
Received: by mail-yw0-f46.google.com with SMTP id 9so445305ywk.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 07:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=oyYqwI47QN3VMynsmp2y1veZX0bPlEk61S3JflOQuIE=;
        b=I9nLrIE8tFPvuNUrpGCoCgafhxWR+2GNPIB27t5pTnhuTf8UmMT1I7mjioWG++gHVY
         uTCafvGAF2TbEheSRSOCKD6Xy737REAe5gukE0GeDhkD6I1snzHq1bxqFRckcBomp3e7
         Od7/N+eks38RYTqr9AUNHAJTUuftCjUIcmhkU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=X30Xx9V1HI29F+c4CMkLRFcLD6aynLrmCww8ceymAyW83/n6q74DGszH1cRJl6lFRy
         uZ62co5NWxbN8bpZnR0qMcNnUDCGQKpPJokh1VZwdbqTMXt3yByLby7eEBf5eTyIbVzj
         lLpld7h+Sx1NKF3JNckkDAL6WTjhVn1UXAQl8=
Received: by 10.150.157.12 with SMTP id f12mr5976009ybe.360.1288191223473;
        Wed, 27 Oct 2010 07:53:43 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id i69sm102288yha.8.2010.10.27.07.53.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 07:53:42 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 27 Oct 2010 21:53:40 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160073>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |   49 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 9221cd3..201761f 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -4157,4 +4157,53 @@ EOF
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
+	export GIT_WORK_TREE=3Dnon-existent &&
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
1.7.0.2.445.gcbdb3
