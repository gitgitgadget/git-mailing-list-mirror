From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 01/15] contrib/git-credential-gnome-keyring.c: remove unnecessary pre-declarations
Date: Sun, 22 Sep 2013 22:07:57 -0700
Message-ID: <1379912891-12277-2-git-send-email-drafnel@gmail.com>
References: <1379912891-12277-1-git-send-email-drafnel@gmail.com>
Cc: pah@qo.cx, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 23 07:09:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNyOS-0001wD-M2
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 07:09:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753160Ab3IWFJD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 01:09:03 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:42527 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753137Ab3IWFJC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 01:09:02 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa1so3086263pad.5
        for <git@vger.kernel.org>; Sun, 22 Sep 2013 22:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r35CmGSkSUH8As/5Oqr0UHn0pEH8/bbhHxfcY2wIRAE=;
        b=JJql9JHGmqk8gNtt9x9/djvgApReytNE4dlbOKWR3Shy5zDYHF4K22iGopMqG2Eddc
         AuodcErwTbtyKeylk1ZIeaZNckSMXPmb4QHn/RJHOR1UYXw88kWb+g9Yc57+Y0CQXc2l
         O8ra3y6IH1rGkXZuKRHmiIaQ+c5T4BvOwMCDkJazshqg7csuyXajY/DZdPwUmEl88Dfb
         wqAW0Uk8C0gPTuIc8fEcXJ+cQa8Q/LptkBWJSvVhcGnHvqQ0ia89LrOpotwwzcnrOyPR
         +Z+U58baHtAU+bldBPKIjuS+Q6AwMmV0QvwuAvpCuenDiKMj3IcJ8unTnQlGia7EIJxb
         9n4w==
X-Received: by 10.66.136.131 with SMTP id qa3mr22856282pab.77.1379912941026;
        Sun, 22 Sep 2013 22:09:01 -0700 (PDT)
Received: from charliebrown.hsd1.ca.comcast.net (c-98-248-40-161.hsd1.ca.comcast.net. [98.248.40.161])
        by mx.google.com with ESMTPSA id sb9sm31437553pbb.0.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 22 Sep 2013 22:09:00 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.489.g545bc72
In-Reply-To: <1379912891-12277-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235186>

These are all defined before they are used, so it is not necessary to
pre-declare them.  Remove the pre-declarations.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 .../credential/gnome-keyring/git-credential-gnome-keyring.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
index f2cdefe..15b0a1c 100644
--- a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
+++ b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
@@ -46,11 +46,6 @@ struct credential
 #define CREDENTIAL_INIT \
   { NULL,NULL,0,NULL,NULL,NULL }
 
-void credential_init(struct credential *c);
-void credential_clear(struct credential *c);
-int  credential_read(struct credential *c);
-void credential_write(const struct credential *c);
-
 typedef int (*credential_op_cb)(struct credential*);
 
 struct credential_operation
@@ -62,14 +57,6 @@ struct credential_operation
 #define CREDENTIAL_OP_END \
   { NULL,NULL }
 
-/*
- * Table with operation callbacks is defined in concrete
- * credential helper implementation and contains entries
- * like { "get", function_to_get_credential } terminated
- * by CREDENTIAL_OP_END.
- */
-struct credential_operation const credential_helper_ops[];
-
 /* ---------------- common helper functions ----------------- */
 
 static inline void free_password(char *password)
-- 
1.8.4.489.g545bc72
