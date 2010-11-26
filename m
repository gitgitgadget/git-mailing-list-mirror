From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 04/47] t1510: setup case #1
Date: Fri, 26 Nov 2010 22:32:00 +0700
Message-ID: <1290785563-15339-5-git-send-email-pclouds@gmail.com>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 16:35:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM0Ky-0001Kw-Rc
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 16:35:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751734Ab0KZPfn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 10:35:43 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:32981 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027Ab0KZPfm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 10:35:42 -0500
Received: by mail-pv0-f174.google.com with SMTP id 4so350820pva.19
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 07:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=CF75aycqRFCXOA1V2tKRpETD/w7sA/TbRG4gRbLED1A=;
        b=NFfSWPqjglcFCtZejDMKuZLTctaPpNcyGN/RS4mmWzpX4ZhdQBGaDcb8PkvGpH0j87
         HUr9bUnqFhbDCzDT0pa1A4xS07KqIhBSuMGD+KCEzmhDP39BaDJnFmEx2qeoFcbIQ2iu
         j2CywmGJh3z3Ugru1sb/Y/gaZpdlh0M3VzDhc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=pNiIxxuvScdIpzIy1FBc/H3BxZ2kF5p8PWiBQ+9H6G84/2Wkwe1IdrAu7FAjh25fNt
         PyOuoa6rj729OX2j49LfrAmtHJ0X2MuwmcfDOvwta3NYDFdnLLBq3crOMKMg9dT1ZNck
         cqjsEer0Yvz9OaXZSSuqhAFWbOPVHsJcLb5OA=
Received: by 10.142.155.2 with SMTP id c2mr2534787wfe.51.1290785742240;
        Fri, 26 Nov 2010 07:35:42 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.252.168])
        by mx.google.com with ESMTPS id f5sm2675356wfg.14.2010.11.26.07.35.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 07:35:41 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 26 Nov 2010 22:34:21 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
In-Reply-To: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162220>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |   47 +++++++++++++++++++++++++++++++++++++++++=
++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 641731c..4e9c425 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -105,4 +105,51 @@ EOF
 	test_repo 0/sub
 '
=20
+#
+# case #1
+#
+############################################################
+#
+# Input:
+#
+#  - GIT_WORK_TREE is set
+#  - GIT_DIR is not set
+#  - core.worktree is not set
+#  - .git is a directory
+#  - core.bare is not set, cwd is outside .git
+#
+# Output:
+#
+# GIT_WORK_TREE is ignored -> #0
+
+test_expect_success '#1: setup' '
+	unset GIT_DIR GIT_WORK_TREE &&
+	mkdir 1 1/sub 1.wt 1.wt/sub 1/wt 1/wt/sub &&
+	cd 1 &&
+	git init &&
+	GIT_WORK_TREE=3Dnon-existent &&
+	export GIT_WORK_TREE &&
+	cd ..
+'
+
+test_expect_failure '#1: at root' '
+	cat >1/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/1
+setup: cwd: $TRASH_DIRECTORY/1
+setup: prefix: (null)
+EOF
+	test_repo 1
+'
+
+test_expect_failure '#1: in subdir' '
+	cat >1/sub/expected <<EOF &&
+setup: git_dir: .git
+setup: worktree: $TRASH_DIRECTORY/1
+setup: cwd: $TRASH_DIRECTORY/1
+setup: prefix: sub/
+EOF
+	test_repo 1/sub
+'
+
 test_done
--=20
1.7.3.2.316.gda8b3
