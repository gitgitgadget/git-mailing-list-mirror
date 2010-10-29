From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 08/42] t1510: setup case #5
Date: Fri, 29 Oct 2010 13:48:20 +0700
Message-ID: <1288334934-17216-9-git-send-email-pclouds@gmail.com>
References: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 08:50:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBinI-00066q-4e
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 08:50:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756035Ab0J2Gu1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 02:50:27 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64522 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754358Ab0J2GuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 02:50:25 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so692674pwj.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 23:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=yC7plGrZGe46QhFLjVUzBX1jzKVn00gMvPfj1txRjb0=;
        b=vYlTR2lmzIqll/uC9JSu9RrV59KvJoDUzMzyb9RfQksQXQ71Cuj2ewv5vTRwMuoJOa
         mV0cyQ2MqpNDJ18zKXaGDQmFuhsQ53cEmEbXtYCY0m4rpw7kmUJCiENArPQ7ttK8UO6F
         BSu0tTWxFzBEBo1TjZb63rcWpdJc4XZm5IMAE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=holmQ/JQuAKkrOqhWGHO+pkh8y7DlyQ2lGhgllUVagAp1FTKQweSxFkBhZjOcXGi9r
         X4NW0C7m8e5iyxHxuU/GpOaCKx+Mz2Kn8u8/w62731P6ypvYbLEDCCangIjDefQf7Anl
         c2pqIct8ePAQFlmgdZ/ySbonEp+GBSuTF1G8I=
Received: by 10.142.165.4 with SMTP id n4mr796365wfe.121.1288335025025;
        Thu, 28 Oct 2010 23:50:25 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id w22sm1019060wfd.19.2010.10.28.23.50.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 23:50:24 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 29 Oct 2010 13:50:24 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160276>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |   47 +++++++++++++++++++++++++++++++++++++++++=
++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 93cc9fb..a216849 100755
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
