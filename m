From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 14/22] imap-send.c: use the FORMATPRINTF macro to declare the gcc function attribute 'format printf'
Date: Thu, 11 Feb 2016 12:38:51 +0000
Message-ID: <1455194339-859-15-git-send-email-gitter.spiros@gmail.com>
References: <1455194339-859-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 13:40:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTqXh-00009L-3k
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 13:40:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753111AbcBKMkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 07:40:09 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33907 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752870AbcBKMj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 07:39:29 -0500
Received: by mail-wm0-f68.google.com with SMTP id p63so10438725wmp.1
        for <git@vger.kernel.org>; Thu, 11 Feb 2016 04:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Sett6YHzUbWuXXKWGM72hv7tOJL6TB3pIHEwhcTP2Ag=;
        b=qCn69aGNQNhQHrEa7KniZbCFL4DDV2TRbIeqMW1++YlKizj6bqitWcaYBFdEBFSnZQ
         +vseY0NSDhTyCysySIyo6J+Ium0ZB3mmy7ewpLmky0LOtcyYFWDFvM/JofqtPzsz0viS
         P5Ee2cA2MxVOxs2tS758yEbfZZ/fBElyR+baSBPWYxSRORmRIg+VFWBBSIC7rUoGpYAz
         09NFpAlNMN6r4+jluuFQaX01mK2hux//6VapbLKGaHz0ggqhLnBq8Qle2sgaM4EVPDnL
         +w7wLu2OjZwHvyydLiw/gsGR1bB4TrjT5eJU2Q/RtXPJY9erDXxN92AofotFfPI+p4j/
         9lzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Sett6YHzUbWuXXKWGM72hv7tOJL6TB3pIHEwhcTP2Ag=;
        b=dVPBlwg1Ot32FI1YhctyzdZYOIlsI0xB7CsyCmwK2UpYws3VV+/T3u5zR/5NkJm5Je
         x6bYT0NrrIOh9A5zXrJ5WZ4EkAOT1mMwsy+f32Awu4KM1ON/ciSGbQfmAJ+Ik6ccGdCg
         32+yXLNRU0fUFiQRZh1L3Gslkt06iGh754lFmeDrky8Nain3Y5laNdef2NoCf6ru4pYc
         4fElb0m1wxNYY1zrhB4/1MgLpNdomkFB7MPAFHeSf9ebBxnfXSnMFzwA+NuA8QYZBxfF
         R4JsRRb+GcaCfmq5jkEf033o+BT/SBnIjLB4mJr74CNx72+7W3yEpzAChCmPJShCs0it
         s5nQ==
X-Gm-Message-State: AG10YOQEQWVg2XUbVYI2AjunrPxhuuUIms6fINuAluKGrWLawOAfGKJXNa63c/FBu0nM+w==
X-Received: by 10.194.62.179 with SMTP id z19mr16216605wjr.96.1455194368749;
        Thu, 11 Feb 2016 04:39:28 -0800 (PST)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([40.113.119.92])
        by smtp.gmail.com with ESMTPSA id gt7sm7457368wjc.1.2016.02.11.04.39.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Feb 2016 04:39:28 -0800 (PST)
X-Mailer: git-send-email 2.7.0.327.gff4ea60.dirty
In-Reply-To: <1455194339-859-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285974>

Use the new FORMATPRINTF macro (in git-compat-util.h) to declare the gcc function
attribute 'format printf'

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 imap-send.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 4d3b773..6739a7c 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -59,14 +59,14 @@ static struct option imap_send_options[] = {
 #define DRV_BOX_BAD     -2
 #define DRV_STORE_BAD   -3
 
-__attribute__((format (printf, 1, 2)))
+FORMATPRINTF(1,2)
 static void imap_info(const char *, ...);
-__attribute__((format (printf, 1, 2)))
+FORMATPRINTF(1,2)
 static void imap_warn(const char *, ...);
 
 static char *next_arg(char **);
 
-__attribute__((format (printf, 3, 4)))
+FORMATPRINTF(3,4)
 static int nfsnprintf(char *buf, int blen, const char *fmt, ...);
 
 static int nfvasprintf(char **strp, const char *fmt, va_list ap)
@@ -578,7 +578,7 @@ static struct imap_cmd *issue_imap_cmd(struct imap_store *ctx,
 	return cmd;
 }
 
-__attribute__((format (printf, 3, 4)))
+FORMATPRINTF(3,4)
 static int imap_exec(struct imap_store *ctx, struct imap_cmd_cb *cb,
 		     const char *fmt, ...)
 {
@@ -594,7 +594,7 @@ static int imap_exec(struct imap_store *ctx, struct imap_cmd_cb *cb,
 	return get_cmd_result(ctx, cmdp);
 }
 
-__attribute__((format (printf, 3, 4)))
+FORMATPRINTF(3,4)
 static int imap_exec_m(struct imap_store *ctx, struct imap_cmd_cb *cb,
 		       const char *fmt, ...)
 {
-- 
2.5.0
