From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 08/20] worktree.c: add clear_worktree()
Date: Wed,  3 Feb 2016 16:35:38 +0700
Message-ID: <1454492150-10628-9-git-send-email-pclouds@gmail.com>
References: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 03 10:36:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQtrl-0005Vw-Vt
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 10:36:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751828AbcBCJgn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Feb 2016 04:36:43 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36583 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946AbcBCJgj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 04:36:39 -0500
Received: by mail-pa0-f54.google.com with SMTP id yy13so10731484pab.3
        for <git@vger.kernel.org>; Wed, 03 Feb 2016 01:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=0C1rAbxrOqcX/Idy3O9tBS872gz8sOx58byfXT0xg4c=;
        b=I35jeh9I1CE/2VKBA9Te6hXli3DhwaJjPQ8OzwSOMpENDurM37jvOiEqBRDAh4+PbE
         FDrM/xFJTfrMnBA3FllyzwtXqP4do9ZiyQgQEKN+H+o/PO2BNdq92uWCjcAY+sKNyoCs
         32Yr9XY09txdgPfZ8C2pVOoJwS5Ibil8VRQvH7Y4FlOqVDl02w9vUId0wZ7aActshyG5
         I1vMIlkj0WWJgFfGSteicsQZ3DS3XNhvdJS6ya6VVRO8rVGcfPZvzH22Q5yE1mD2onjW
         JBFwLN7RQNcO7xOMCAo02ZEzAlzvGku32lSl8jY6FS5ZK5YSkit2vzPWOlBN0fHD07eC
         GH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=0C1rAbxrOqcX/Idy3O9tBS872gz8sOx58byfXT0xg4c=;
        b=STn9Z7sdvjGSj4a+s2OCBKyP/EOoMBCnII5yM5MTaGFsOmWobsnZOEmywEeICzN3FF
         THfaBgyhwulbhozDNJLaf7uqQ7m3dSA3WGlSpX2ACYGEGPwj5FiXcLuiuUlzLNGYsy62
         RF5k5j0F5AJMgfHbR14I9xkuVQRrvy4Cl5sGQkZBnJRxUgXH+aV98pOSFFAZdBNhXHlX
         S/uQ/NG472UqHeDgvMfbwaurxJ+2BJ8Fh93VzyaZ+Kcw8j8cK3i8z3afSoqpXxhne1q3
         km8QuCFdKyaFFQSlf491JegijYnDVDXPnRFVH1+lR9bz94dAUB8QfHl4hRGDmocznfYm
         o4/A==
X-Gm-Message-State: AG10YOQluZlDBqsr5M8DZQmZx93H45IAY9yu9CXnCyxQWo/MGj30HGd8ffUw32X6sPJKzQ==
X-Received: by 10.66.147.165 with SMTP id tl5mr729808pab.88.1454492198710;
        Wed, 03 Feb 2016 01:36:38 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id i23sm8359644pfj.68.2016.02.03.01.36.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2016 01:36:37 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 03 Feb 2016 16:36:50 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285351>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 worktree.c | 14 +++++++++++---
 worktree.h |  5 +++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/worktree.c b/worktree.c
index 4c38414..b4e4b57 100644
--- a/worktree.c
+++ b/worktree.c
@@ -4,14 +4,22 @@
 #include "worktree.h"
 #include "dir.h"
=20
+void clear_worktree(struct worktree *wt)
+{
+	if (!wt)
+		return;
+	free(wt->path);
+	free(wt->id);
+	free(wt->head_ref);
+	memset(wt, 0, sizeof(*wt));
+}
+
 void free_worktrees(struct worktree **worktrees)
 {
 	int i =3D 0;
=20
 	for (i =3D 0; worktrees[i]; i++) {
-		free(worktrees[i]->path);
-		free(worktrees[i]->id);
-		free(worktrees[i]->head_ref);
+		clear_worktree(worktrees[i]);
 		free(worktrees[i]);
 	}
 	free (worktrees);
diff --git a/worktree.h b/worktree.h
index e89d423..0ba07ab 100644
--- a/worktree.h
+++ b/worktree.h
@@ -28,6 +28,11 @@ extern struct worktree **get_worktrees(void);
 extern const char *get_worktree_git_dir(const struct worktree *wt);
=20
 /*
+ * Free up the memory for worktree
+ */
+extern void clear_worktree(struct worktree *);
+
+/*
  * Free up the memory for worktree(s)
  */
 extern void free_worktrees(struct worktree **);
--=20
2.7.0.377.g4cd97dd
