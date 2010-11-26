From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 15/47] t1510: setup case #12
Date: Fri, 26 Nov 2010 22:32:11 +0700
Message-ID: <1290785563-15339-16-git-send-email-pclouds@gmail.com>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 16:39:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM0OT-0003QG-K9
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 16:39:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753594Ab0KZPjU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 10:39:20 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:50523 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394Ab0KZPjT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 10:39:19 -0500
Received: by pzk6 with SMTP id 6so349225pzk.19
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 07:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=/ivAvsgK/7TeZrL793Lxqf5eAmiI68JAPMK4/fagxfk=;
        b=qGLxGzPW9/iTsl/TNK9MlBmyChC5er5Qy40LNQJ2YqGekOs5pROA4DHtmvbUo3DRqt
         zIFlnpoRhVAvfrAuiJu2fpeFlAIj8bRbC+g0RXGybqGqKHGJglLe0OAu5Hmjh6hfZ4eI
         57YSoCD/+eG2IPn1QpKy04nhMIS1+sdTVQQls=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=pw2DgP9gOY3JmXtPa9Iy1/g8LCz86GK022wrMU+Wi9G5EwkvSl+yKpbiR9+kj2TQK+
         dCKoqZX1h6P01isRUtPsRQ3OyQBWgGbgvojwYWyZjhK/8Ov0U9/XDVAHj7b6CcAbpjiM
         LBkeaz46EpJB+Vob+Apz/uStM3WNhPlNdRiyM=
Received: by 10.142.169.10 with SMTP id r10mr2513784wfe.216.1290785959081;
        Fri, 26 Nov 2010 07:39:19 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.252.168])
        by mx.google.com with ESMTPS id w22sm2675112wfd.7.2010.11.26.07.39.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 07:39:17 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 26 Nov 2010 22:37:55 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
In-Reply-To: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162231>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t1510-repo-setup.sh |   49 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index ac95808..b86895f 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -1567,4 +1567,53 @@ EOF
 	test_repo 11/sub/sub "$TRASH_DIRECTORY/11/.git" "$TRASH_DIRECTORY"
 '
=20
+#
+# case #12
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is not set
+#  - GIT_DIR is not set
+#  - core.worktree is set
+#  - .git is a file
+#  - core.bare is not set, cwd is outside .git
+#
+# Output:
+#
+# #4 except that git_dir is set by .git file
+
+
+test_expect_success '#12: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 12 12/sub 12/sub/sub 12.wt 12.wt/sub 12/wt 12/wt/sub &&
+	cd 12 &&
+	git init &&
+	git config core.worktree non-existent &&
+	mv .git ../12.git &&
+	echo gitdir: ../12.git >.git &&
+	cd ..
+'
+
+test_expect_failure '#12: at root' '
+	cat >12/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/12.git
+setup: worktree: $TRASH_DIRECTORY/12
+setup: cwd: $TRASH_DIRECTORY/12
+setup: prefix: (null)
+EOF
+	test_repo 12
+'
+
+test_expect_failure '#12: in subdir' '
+	cat >12/sub/expected <<EOF &&
+setup: git_dir: $TRASH_DIRECTORY/12.git
+setup: worktree: $TRASH_DIRECTORY/12
+setup: cwd: $TRASH_DIRECTORY/12
+setup: prefix: sub/
+EOF
+	test_repo 12/sub
+'
+
 test_done
--=20
1.7.3.2.316.gda8b3
