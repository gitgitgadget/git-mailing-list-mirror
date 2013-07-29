From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH 2/4] log, format-patch: accept short parameter 'q' for quiet
Date: Mon, 29 Jul 2013 21:49:56 +0200
Message-ID: <1375127398-31904-3-git-send-email-stefanbeller@googlemail.com>
References: <1375127398-31904-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 29 21:50:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3tSB-00015L-10
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 21:49:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754181Ab3G2Ttz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 15:49:55 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:46609 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753966Ab3G2Ttw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 15:49:52 -0400
Received: by mail-wi0-f171.google.com with SMTP id hr7so1835712wib.16
        for <git@vger.kernel.org>; Mon, 29 Jul 2013 12:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=dDaZnPOtzx70b0Pd9PS1uI1VswEtS4g0SwGqZRHQvsc=;
        b=mQ8DqXRTBf6SJRAyC58aNZ7nCnkI3WGViRi1bE3/HS1PXZpciqCKgSHBSeQRsKbU4t
         zbmDYbJkheXkzJDoX+2WPDRZfox9uTFhQCyYcKqyAf/TTEu3HtOyNJ6Lo9htbPVUU8jB
         veGclbwqiXW+K4L46jWy9fkyUY2cIbiyA5hAKSnfoR60YPBuOsr4JadopT8YnOUIGd3J
         BFVkIm0FJMuCeyeKa0ji/4cUKwrydU32CyktEZu/pbsLY80BjKWyM9t31h3erc1eM4nJ
         7AhFHxf33DvhAKBUvQhixAgcnDP4YmMOlpYhrxgeiEfYnrZAMqQjOnSWdDBZUpdACxyd
         2ehg==
X-Received: by 10.195.13.202 with SMTP id fa10mr43720306wjd.14.1375127390816;
        Mon, 29 Jul 2013 12:49:50 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id z2sm24726534wiv.11.2013.07.29.12.49.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 29 Jul 2013 12:49:50 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc0.1.g8f6a3e5
In-Reply-To: <1375127398-31904-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231325>

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 builtin/log.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 9b6c910..5cb968b 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -121,7 +121,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	static struct line_opt_callback_data line_cb = {NULL, NULL, STRING_LIST_INIT_DUP};
 
 	const struct option builtin_log_options[] = {
-		OPT_BOOL(0, "quiet", &quiet, N_("suppress diff output")),
+		OPT_BOOL('q', "quiet", &quiet, N_("suppress diff output")),
 		OPT_BOOL(0, "source", &source, N_("show source")),
 		OPT_BOOL(0, "use-mailmap", &mailmap, N_("Use mail map file")),
 		{ OPTION_CALLBACK, 0, "decorate", NULL, NULL, N_("decorate options"),
@@ -1210,7 +1210,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			    PARSE_OPT_OPTARG, thread_callback },
 		OPT_STRING(0, "signature", &signature, N_("signature"),
 			    N_("add a signature")),
-		OPT_BOOL(0, "quiet", &quiet,
+		OPT_BOOL('q', "quiet", &quiet,
 			 N_("don't print the patch filenames")),
 		OPT_END()
 	};
-- 
1.8.4.rc0.1.g8f6a3e5
