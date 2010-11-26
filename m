From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 33/47] t1510: setup case #30
Date: Fri, 26 Nov 2010 22:32:29 +0700
Message-ID: <1290785563-15339-34-git-send-email-pclouds@gmail.com>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 16:46:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM0VX-0007Zp-HN
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 16:46:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755173Ab0KZPqh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 10:46:37 -0500
Received: from mail-pw0-f66.google.com ([209.85.160.66]:44386 "EHLO
	mail-pw0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752778Ab0KZPqh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 10:46:37 -0500
Received: by pwj5 with SMTP id 5so469454pwj.1
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 07:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=8PWeJNDV/RzqWCTB85oaj+an+I4zAt4ID+8IdPT2gPg=;
        b=MnBq+dO3W8B9efDlIJh2UA4NcNBdAgj61oVaremlZkpVQAjbRjndZETTtIKMNN9LIs
         lFDPVlm7j2aIJuDzsuGkvW3MQGOYvD8YxMNmAz0Z9OX4SuZjecDZDSqkvlNWhvnuJShU
         LUIWz9afIUfFLiyw3ZgEjPU8rft/KUmTG5us4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=EUrjvx9DUXWYtkQ9sP9ySoesg/eYA/dUQNLY7EWX+0WDHKg28yVqwiN7jGTvj0MMnD
         ZHQDdNniYP7RAFN/G4M4WrAbM7dJBP+A6XVUbLC32dH3hNSc+v1OvtgptdoAhm/jXexj
         biKNDmSg7xa+syLiFBh5HozCv7EFAN3Pssods=
Received: by 10.142.217.9 with SMTP id p9mr2532188wfg.212.1290786396057;
        Fri, 26 Nov 2010 07:46:36 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.252.168])
        by mx.google.com with ESMTPS id w22sm2683578wfd.7.2010.11.26.07.46.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 07:46:35 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 26 Nov 2010 22:45:22 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
In-Reply-To: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162248>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |   39 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 2d1982f..96f7485 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -4221,4 +4221,43 @@ EOF
 	test_repo 29/sub
 '
=20
+#
+# case #30
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is not set
+#  - GIT_DIR is set
+#  - core.worktree is set
+#  - .git is a file
+#  - core.bare is set
+#
+# Output:
+#
+# core.worktree and core.bare conflict, won't fly.
+
+test_expect_success '#30: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 30 &&
+	cd 30 &&
+	git init &&
+	git config core.bare true &&
+	git config core.worktree non-existent &&
+	mv .git ../30.git &&
+	echo gitdir: ../30.git >.git &&
+	cd ..
+'
+
+test_expect_failure '#30: at root' '
+	(
+	cd 30 &&
+	GIT_DIR=3D.git &&
+	export GIT_DIR &&
+	test_must_fail git symbolic-ref HEAD 2>result &&
+	grep "core.bare and core.worktree do not make sense" result
+	)
+'
+
 test_done
--=20
1.7.3.2.316.gda8b3
