From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 28/47] t1510: setup case #25
Date: Fri, 26 Nov 2010 22:32:24 +0700
Message-ID: <1290785563-15339-29-git-send-email-pclouds@gmail.com>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 16:45:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM0Ty-0006hh-Mu
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 16:45:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755287Ab0KZPoy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 10:44:54 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:46623 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755279Ab0KZPow (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 10:44:52 -0500
Received: by pwj3 with SMTP id 3so401801pwj.19
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 07:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=1kj3stS7Fp6xvLmpfI4NhoS/PNs1EAr7gm6V/MbyWsY=;
        b=ob41mxNwqSI52HowTyVX41E9gKGCs98YZ1PLiJ0roREtLI7KbwQfC6+BfA77EVY8Ys
         kg+/mXXCh8Irhezjgk6mDWuro9odRyIRkRCGhXAxy4T356tgb0sp1BLNBo89fuMhqX80
         fr7L6RnNjJ+78UEog9yHWIYNspcG17yKxwSEE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=a/xLTqURoIWJxZq5m/8wttx+pzPTlzX+qFq/mbol1Zo/q++OtFKwfFoNdHzTHLm95J
         vf9IBBn1HDV6Xu0GaSUzJw2aWb+CJqYj05a8MexNYJpIulRKfMa1mgjqCRminOQuBQN7
         4ukaTQwAq76b8SbhUfLt56CKFZvr0MRmwfxNk=
Received: by 10.142.216.3 with SMTP id o3mr2503202wfg.296.1290786292464;
        Fri, 26 Nov 2010 07:44:52 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.252.168])
        by mx.google.com with ESMTPS id x18sm2684514wfa.11.2010.11.26.07.44.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 07:44:51 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 26 Nov 2010 22:43:41 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
In-Reply-To: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162244>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |   50 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 1c89366..fa1ffac 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -3736,4 +3736,54 @@ EOF
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
+	GIT_WORK_TREE=3Dnon-existent &&
+	export GIT_WORK_TREE &&
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
1.7.3.2.316.gda8b3
