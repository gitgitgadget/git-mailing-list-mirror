From: Brandon Casey <bcasey@nvidia.com>
Subject: [PATCH v2 01/16] contrib/git-credential-gnome-keyring.c: remove unnecessary pre-declarations
Date: Mon, 23 Sep 2013 11:49:02 -0700
Message-ID: <1379962157-1338-2-git-send-email-bcasey@nvidia.com>
References: <1379962157-1338-1-git-send-email-bcasey@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <john@szakmeister.net>, <pah@qo.cx>, <felipe.contreras@gmail.com>,
	Brandon Casey <drafnel@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 23 20:50:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOBCy-0007oY-Il
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 20:50:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753330Ab3IWSt0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 14:49:26 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:9049 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752867Ab3IWStZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 14:49:25 -0400
Received: from hqnvupgp07.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com
	id <B52408d1f0000>; Mon, 23 Sep 2013 11:49:03 -0700
Received: from hqemhub01.nvidia.com ([172.20.12.94])
  by hqnvupgp07.nvidia.com (PGP Universal service);
  Mon, 23 Sep 2013 11:49:24 -0700
X-PGP-Universal: processed;
	by hqnvupgp07.nvidia.com on Mon, 23 Sep 2013 11:49:24 -0700
Received: from sc-xterm-13.nvidia.com (172.20.144.16) by hqemhub01.nvidia.com
 (172.20.150.30) with Microsoft SMTP Server id 8.3.327.1; Mon, 23 Sep 2013
 11:49:24 -0700
X-Mailer: git-send-email 1.8.4.rc4.6.g5555d19
In-Reply-To: <1379962157-1338-1-git-send-email-bcasey@nvidia.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235225>

From: Brandon Casey <drafnel@gmail.com>

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
1.8.4.rc4.6.g5555d19


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
