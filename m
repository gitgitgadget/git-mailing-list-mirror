From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 13/25] worktree.c: add clear_worktree()
Date: Wed, 13 Apr 2016 20:15:34 +0700
Message-ID: <1460553346-12985-14-git-send-email-pclouds@gmail.com>
References: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 15:17:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqKfW-0004UL-N8
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 15:17:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932949AbcDMNRO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2016 09:17:14 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35027 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760659AbcDMNQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 09:16:58 -0400
Received: by mail-pf0-f195.google.com with SMTP id r187so4127457pfr.2
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 06:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t/D8fvEeTwKJcqHPdPg/WXoC9kM3pp+RY1NJ6gxYLnE=;
        b=smUDFr0OZsQ/hdJM+JQvDqV+/vc/SCMkayp2SilmE/ZSN4LumZ65NryV59S0qoyrip
         91tz+cWFKIUcsfnLQUEVuZrP73QyRH6lYMJwXAwqaTI9Rid+8djY6bJo3mKn7Xb9Xl+z
         X6gfHbKS2DbdvWCAej7D9nw+9+194rmP4WkMxJWRSqVsVbf52lw3gEx5/qbKbM8ZB2IZ
         wjt9tAlDQzNDb8G/LfCtahE6KRzRN/SKerXPz+oSPTrTZk4miMbQVGaMBZPjYQItFjn8
         qSv2tqb0VMmmeedCKlv2DxdkdjatfU/fG6AlwU+wAIUOJdnFrIC8pu9kBJ9AIVWyk9ZQ
         GkbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t/D8fvEeTwKJcqHPdPg/WXoC9kM3pp+RY1NJ6gxYLnE=;
        b=GSeSuZHpx2mj3LvVrSH3h3aWCw9S+uxzV0Lrsg6HZm5fEOfo0zVwn+lkU7fOVHGMcV
         Gn3CcKT3NdRdfafhJraYi/MCxl9inK/4MVbqSKHDHNwFBIxncMEX2MPJzYK6fu7Xpamt
         8A69wE8uX09J5/Ao+A2YXLIfiklCLihUMcs12i4entNpAza2PJ0GOL5L/rm1VppLzCOz
         wemgirEhVRxR1p11DEIpxFq2SrCgnAawyVO5B9r0oe9nT1Ep17qPVy4T2lcoO2o3Onz6
         wRATanlkZkhqI2+waie8TWRG2kEyyHCdu16+cpclvkFJqyaeyBPlrHZKzg5z4Yx40Y3+
         fn5Q==
X-Gm-Message-State: AOPr4FUoVsevLXQUfXEssf9wvz+Lqs9FL82TY5tKB/bhk+wRl+mwMrHNRBPawe55HhYtVA==
X-Received: by 10.98.71.92 with SMTP id u89mr12845347pfa.100.1460553418370;
        Wed, 13 Apr 2016 06:16:58 -0700 (PDT)
Received: from lanh ([115.76.233.41])
        by smtp.gmail.com with ESMTPSA id tn5sm51320964pac.32.2016.04.13.06.16.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2016 06:16:57 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Apr 2016 20:17:04 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291435>

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
2.8.0.rc0.210.gd302cd2
