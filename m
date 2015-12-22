From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] push: don't mark options of recurse-submodules for translation
Date: Tue, 22 Dec 2015 18:53:00 +0100
Message-ID: <1450806780-16822-1-git-send-email-ralf.thielow@gmail.com>
Cc: gitster@pobox.com, worldhello.net@gmail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 22 18:53:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBR7g-0005Qd-N0
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 18:53:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933140AbbLVRxM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2015 12:53:12 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34592 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932910AbbLVRxL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2015 12:53:11 -0500
Received: by mail-wm0-f66.google.com with SMTP id l126so22900428wml.1
        for <git@vger.kernel.org>; Tue, 22 Dec 2015 09:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=h46zymRANaBtIQ0P9UfCx1KgTbYW+uAIVrgOVJB2oJI=;
        b=grr/AIeL40RasNXdU433935L4n9eIXnxoL3IngRx5q4BPUQo4jBDU4ybfeI5eqBCVw
         K818qp6IKCdvPuikTsFs0n8b8nnyqD5b66nEQXeRpP3TEWaiuxBjjmBsPNz2+BcZuNHU
         f8yi2rh5mzIIBG+r0Ig+KBJXUEsb8AGyHe45XCHA0GemL6kTr2oo2A7Ozt9o2K7A1dhX
         /IIfQ+N4MZ7GEUL6uj9RGGM4x0SH5dCCC7XET6XWRRWw9OgTVOSfrxmgTU6N2SB7VktZ
         700GMen87SJuTm7w3jKiLjxxEBNTxv7GWvF/1IY5D39VVdOdYjxmHcFizFnLDYyQB4oV
         DWOw==
X-Received: by 10.194.118.36 with SMTP id kj4mr27874276wjb.88.1450806789742;
        Tue, 22 Dec 2015 09:53:09 -0800 (PST)
Received: from localhost (cable-95-168-157-91.cust.telecolumbus.net. [95.168.157.91])
        by smtp.gmail.com with ESMTPSA id gj2sm33922047wjb.40.2015.12.22.09.53.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 22 Dec 2015 09:53:08 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc1.195.g5ee9e94
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282892>

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 builtin/push.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/push.c b/builtin/push.c
index cc29277..8963dbd 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -547,7 +547,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		  0, CAS_OPT_NAME, &cas, N_("refname>:<expect"),
 		  N_("require old value of ref to be at this value"),
 		  PARSE_OPT_OPTARG, parseopt_push_cas_option },
-		{ OPTION_CALLBACK, 0, "recurse-submodules", &recurse_submodules, N_("check|on-demand|no"),
+		{ OPTION_CALLBACK, 0, "recurse-submodules", &recurse_submodules, "check|on-demand|no",
 			N_("control recursive pushing of submodules"),
 			PARSE_OPT_OPTARG, option_parse_recurse_submodules },
 		OPT_BOOL( 0 , "thin", &thin, N_("use thin pack")),
-- 
2.7.0.rc1.195.g5ee9e94
