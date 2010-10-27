From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 08/34] t1510: setup case #5
Date: Wed, 27 Oct 2010 21:49:11 +0700
Message-ID: <1288190977-30875-9-git-send-email-pclouds@gmail.com>
References: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 27 16:50:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB7Kz-0006Y9-JY
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 16:50:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933385Ab0J0Oum convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 10:50:42 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:60395 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932499Ab0J0Oul (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 10:50:41 -0400
Received: by mail-gy0-f174.google.com with SMTP id 4so415888gyg.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 07:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=yVSaROwDVVvTDipZ26KxFPn/zsD3iqFsSPApES4HlCQ=;
        b=uG5Xa791QO2fboB6l+rgkAebSsdRekWwCK5dqbgyJRLcmoPvNWYxgVu3igATJv0svb
         zsUUSunav4dyizYk67/j110Qkjqzd/nmeTUHrc5paH2SpWppkOocOUEzamX+pKdf/Mna
         xd4Uki5WYTpjfElrBw4r7IbRZ4cHwM/JCvxFk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Ta9+jDbrcoTG50lzijLp3ZSpfEOpGOQ1FZSHN4kvAElYcvcSW7PV+SFZi1NWXh7jKJ
         bTjfIl0dL4iOloG5ctbDwu/SfsLD4aaw0U7ozL7NMowRVeBUsj8o+Oev0D2VQxuisvHp
         DKZryT9TLdn81w+FnBJkSfkcXzsuTYlmbVY5c=
Received: by 10.150.205.12 with SMTP id c12mr1105325ybg.242.1288191040779;
        Wed, 27 Oct 2010 07:50:40 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id h68sm7714603yha.15.2010.10.27.07.50.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 07:50:40 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 27 Oct 2010 21:50:38 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160047>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |   47 +++++++++++++++++++++++++++++++++++++++++=
++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 6617792..3d0498a 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -529,4 +529,51 @@ EOF
 	test_repo 4/sub
 '
=20
+#
+# case #5
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is set
+#  - GIT_DIR is not set
+#  - core.worktree is set
+#  - .git is a directory
+#  - core.bare is not set, cwd is outside .git
+#
+# Output:
+#
+# GIT_WORK_TREE/core.worktree are ignored -> #0
+
+test_expect_success '#5: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 5 5/sub &&
+	cd 5 &&
+	git init &&
+	git config core.worktree non-existent &&
+	export GIT_WORK_TREE=3Dnon-existent-too &&
+	cd ..
+'
+
+test_expect_failure '#5: at root' '
+	cat >5/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/5
+setup: cwd: $TRASH_DIRECTORY/5
+setup: prefix: (null)
+EOF
+	test_repo 5
+'
+
+test_expect_failure '#5: in subdir' '
+	cat >5/sub/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/5
+setup: cwd: $TRASH_DIRECTORY/5
+setup: prefix: sub/
+EOF
+	test_repo 5/sub
+'
+
 test_done
--=20
1.7.0.2.445.gcbdb3
