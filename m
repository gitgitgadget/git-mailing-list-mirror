From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 03/47] t1510: setup case #0
Date: Fri, 26 Nov 2010 22:31:59 +0700
Message-ID: <1290785563-15339-4-git-send-email-pclouds@gmail.com>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 16:35:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM0Ka-00019H-Ue
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 16:35:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754856Ab0KZPfS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 10:35:18 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:32981 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249Ab0KZPfQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 10:35:16 -0500
Received: by pva4 with SMTP id 4so350820pva.19
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 07:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=CFL1PZK2y20tiybilZRL2grJHFzrcRqUchhrFFUPcho=;
        b=pxUXt5O12fqYT85Q3/rNdWcZOxdBaS6uoWE8wEzYRoCBm4eGKbLGn6YtMk0UXh+wMX
         hKiYhuSzxmzAnUShDFWnfrHV3hsZAc+rPs3oujSkCGQk71sc6KQfVh6dSMdaOlZ9cSmc
         D9o0kp1DaHKMBJru51CKbuj7EvlHN0i0QXVbA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=fUrXoGsg/90DKEBIs9v0Br5V2OaZ0qmDWXk2lfsBHI7tNgh4Zc5YxQfvD6JnUm9+tF
         TQkECNS5a69Lw+lXezVNYCANnHa5qFrjwtPtOz0IegDsWtLsHZqhsXPskcrCZozyzPOU
         HYiZeqqyfEoxkFAPhmoKkrk6bcN3etUVsGaLk=
Received: by 10.142.153.7 with SMTP id a7mr2526456wfe.104.1290785716160;
        Fri, 26 Nov 2010 07:35:16 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.252.168])
        by mx.google.com with ESMTPS id p8sm2678007wff.4.2010.11.26.07.35.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 07:35:14 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 26 Nov 2010 22:33:47 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
In-Reply-To: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162219>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |   53 +++++++++++++++++++++++++++++++++++++++++=
++++++-
 1 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 623807d..641731c 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -41,8 +41,10 @@ test_description=3D'Tests of cwd/prefix/worktree/git=
dir setup in all cases'
=20
 test_repo() {
 	(
-	if [ -n "$1" ]; then cd "$1"; fi &&
-	if [ -f trace ]; then rm trace; fi &&
+	cd "$1" &&
+	if [ -n "$2" ]; then GIT_DIR=3D"$2" && export GIT_DIR; fi &&
+	if [ -n "$3" ]; then GIT_WORK_TREE=3D"$3" && export GIT_WORK_TREE; fi=
 &&
+	rm -f trace &&
 	GIT_TRACE=3D"`pwd`/trace" git symbolic-ref HEAD >/dev/null &&
 	grep '^setup: ' trace >result &&
 	test_cmp expected result
@@ -56,4 +58,51 @@ test_repo() {
 # Bit 4 =3D bare repo
 # Case# =3D encoding of the above 5 bits
=20
+#
+# Case #0
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is not set
+#  - GIT_DIR is not set
+#  - core.worktree is not set
+#  - .git is a directory
+#  - core.bare is not set, cwd is outside .git
+#
+# Output:
+#
+#  - worktree is .git's parent directory
+#  - cwd is at worktree root dir
+#  - prefix is calculated
+#  - git_dir is set to ".git"
+#  - cwd can't be outside worktree
+
+test_expect_success '#0: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 0 0/sub &&
+	cd 0 && git init && cd ..
+'
+
+test_expect_success '#0: at root' '
+	cat >0/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/0
+setup: cwd: $TRASH_DIRECTORY/0
+setup: prefix: (null)
+EOF
+	test_repo 0
+'
+
+test_expect_success '#0: in subdir' '
+	cat >0/sub/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/0
+setup: cwd: $TRASH_DIRECTORY/0
+setup: prefix: sub/
+EOF
+	test_repo 0/sub
+'
+
 test_done
--=20
1.7.3.2.316.gda8b3
