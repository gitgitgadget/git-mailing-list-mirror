From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 08/47] t1510: setup case #5
Date: Fri, 26 Nov 2010 22:32:04 +0700
Message-ID: <1290785563-15339-9-git-send-email-pclouds@gmail.com>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 16:37:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM0MG-0002CV-K6
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 16:37:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753499Ab0KZPhA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 10:37:00 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:37908 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249Ab0KZPg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 10:36:59 -0500
Received: by pva4 with SMTP id 4so351043pva.19
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 07:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=dxaoiG2FZy6fokbr9aXztjFDxsNGUJkAQmB6XiOw3Ts=;
        b=DFwDpXFovwAm2v9F0rpSThKo8auf40hYanQABEVSHrvBssiFQqWRf5GcYrLBa0BZXP
         jvdOHOhMKzU0cCC+Be0HuYdOI45lGheWB9tqG9AQkyMPsaXubHU0rsiDt7csIlV/9jnh
         JlLQ9NkvdyKvuWDtjbAFnX4aOfgCcyf4qmjB4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ZuZPheskoFRj0aKHk7DYX2tqDL6CliGk7vh+CTibzDC6R4adQDERL/KHWx2PXsdd0d
         GzKzxMdn/ky8ipR/znDCHuq8HE0nHtKq16wf0T8Pv8TbRyBmwSUP9DFAOBHkR+nDUO+j
         TohNV4n6njS+3ecOR810Y3bzcME2ZmMeLjeMs=
Received: by 10.142.139.5 with SMTP id m5mr2500809wfd.250.1290785819240;
        Fri, 26 Nov 2010 07:36:59 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.252.168])
        by mx.google.com with ESMTPS id f5sm2679529wfg.2.2010.11.26.07.36.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 07:36:58 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 26 Nov 2010 22:35:42 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
In-Reply-To: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162224>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |   48 +++++++++++++++++++++++++++++++++++++++++=
+++++++
 1 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 655f603..369f237 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -532,4 +532,52 @@ EOF
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
+	GIT_WORK_TREE=3Dnon-existent-too &&
+	export GIT_WORK_TREE &&
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
1.7.3.2.316.gda8b3
