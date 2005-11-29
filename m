From: Jan Andres <jandres@gmx.net>
Subject: [PATCH] Fix typo in http-push.c
Date: Tue, 29 Nov 2005 01:51:54 +0100
Message-ID: <20051129005154.GA3076@pitr.home.jan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Nov 29 01:52:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgtjI-0004lK-DO
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 01:52:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbVK2Av5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 19:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbVK2Av5
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 19:51:57 -0500
Received: from mail.gmx.de ([213.165.64.20]:16276 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932295AbVK2Av4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Nov 2005 19:51:56 -0500
Received: (qmail invoked by alias); 29 Nov 2005 00:51:54 -0000
Received: from e182065135.adsl.alicedsl.de (EHLO pitr.home.jan) [85.182.65.135]
  by mail.gmx.net (mp013) with SMTP; 29 Nov 2005 01:51:54 +0100
X-Authenticated: #11648398
Received: by pitr.home.jan (Postfix, from userid 500)
	id B932321DBED; Tue, 29 Nov 2005 01:51:54 +0100 (MET)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12913>

Hi guys,

Please find below the patch for a typo in http-push.c (in the maint
branch), which caused git-http-push to segfault on my Linux i386 box.

Regards,
Jan


diff --git a/http-push.c b/http-push.c
index 76c7886..ad78982 100644
--- a/http-push.c
+++ b/http-push.c
@@ -784,7 +784,7 @@ static void handle_new_lock_ctx(struct x
 					strtol(ctx->cdata + 7, NULL, 10);
 		} else if (!strcmp(ctx->name, DAV_ACTIVELOCK_TOKEN)) {
 			if (!strncmp(ctx->cdata, "opaquelocktoken:", 16)) {
-				lock->token = xmalloc(strlen(ctx->cdata - 15));
+				lock->token = xmalloc(strlen(ctx->cdata) - 15);
 				strcpy(lock->token, ctx->cdata + 16);
 			}
 		}

-- 
Jan Andres <jandres@gmx.net>
