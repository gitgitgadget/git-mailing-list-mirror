From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 33/42] t1510: setup case #30
Date: Fri, 29 Oct 2010 13:48:45 +0700
Message-ID: <1288334934-17216-34-git-send-email-pclouds@gmail.com>
References: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 08:53:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBiqG-0007Pc-9S
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 08:53:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933417Ab0J2Gx2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 02:53:28 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64522 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933348Ab0J2Gx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 02:53:26 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so692674pwj.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 23:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=8u/teISmt3x53iZRFYpW8n1PHgaZc1c5KVjoKZVGweg=;
        b=F0NZdQy+7+V1q3jBNgZhgntpAj54wevM7TPMmL7l1WUnwXqvTqV1SGyYBLlYY635w1
         3oxLhWj/3NVipaABtWO5Y6yAPT3QSkEXB/WX1GfeIIouFIRs7LCvm7Q4wuhcQ7npGqvV
         4eE36829A2+hMdyw5mOym+0v0WJYGBZS+j2Vg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=n1fVjfY9SApxh4gfH3raq/MDmruEAj0XnoZKPpUYVbVapQ0iWU8R7QNqLS11v4kYpf
         mRhFl/LC/RF9M5ZbPkYYzwve6hPqCN6ZbarINfJSP6pXKC5LkD/8Tr66zLPJIJ8fOXdL
         lJdvsTK6lICtwCt0zqtGY5udLowK1FKgQDUvs=
Received: by 10.142.215.12 with SMTP id n12mr1063070wfg.34.1288335206624;
        Thu, 28 Oct 2010 23:53:26 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id v19sm1031128wfh.12.2010.10.28.23.53.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 23:53:25 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 29 Oct 2010 13:53:26 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160301>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1510-repo-setup.sh |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index e691d1c..02b8e65 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -4206,4 +4206,41 @@ EOF
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
+	GIT_DIR=3D.git test_must_fail git symbolic-ref HEAD 2>result &&
+	grep "core.bare and core.worktree do not make sense" result
+	)
+'
+
 test_done
--=20
1.7.0.2.445.gcbdb3
