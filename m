From: Ossi Herrala <oherrala@gmail.com>
Subject: [PATCH] Fix settings in default_user_config template
Date: Fri, 17 Apr 2015 20:08:55 +0300
Message-ID: <1429290535-38647-2-git-send-email-oherrala@gmail.com>
References: <20150417145516.GB2421@peff.net>
 <1429290535-38647-1-git-send-email-oherrala@gmail.com>
Cc: git@vger.kernel.org, Ossi Herrala <oherrala@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Apr 17 19:10:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yj9mS-00029Q-II
	for gcvg-git-2@plane.gmane.org; Fri, 17 Apr 2015 19:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754286AbbDQRKK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2015 13:10:10 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:35949 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966AbbDQRKI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2015 13:10:08 -0400
Received: by lbbqq2 with SMTP id qq2so87970480lbb.3
        for <git@vger.kernel.org>; Fri, 17 Apr 2015 10:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0aRkBrkupRAXvojnWQB6HDLaessXpBTDT5qO9akZVIo=;
        b=kdxJIOLhIFuctqTv6UcRAXbgeOreoLfN8k9ZLdhC8Cm9p9Fb7IPobE/5FWsmWSUSVG
         o6LAo/nbV+/+lxiLr/kL6F9fIXwZGulgg2+yxLf8tzcMV1KJGifNOjS1/ewznNvh83Md
         /caTk4nKLLuPJfbmqVyIhj60eEXuX6fYfNcztAWaVCmiK8QYbyBe7q4D8t+kxTS8MRmo
         dDUT6/8yPo63HS8BD4OgFcYdu0YY5jBl+wQy6M+fPsNlhmOed83t2nY8PvZ2mnPQ9XXG
         knIVI47L9tb1hn0KLHcytaBix45UC0UD668qFGGzs48vPEhR//lzFgS5mAqGHMErfP92
         NEVw==
X-Received: by 10.112.134.167 with SMTP id pl7mr5108054lbb.50.1429290606291;
        Fri, 17 Apr 2015 10:10:06 -0700 (PDT)
Received: from localhost.localdomain (nat4.panoulu.net. [212.50.147.101])
        by mx.google.com with ESMTPSA id oe1sm2529058lbb.23.2015.04.17.10.10.04
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Apr 2015 10:10:05 -0700 (PDT)
X-Mailer: git-send-email 2.3.5
In-Reply-To: <1429290535-38647-1-git-send-email-oherrala@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267368>

The name (not user) and email setting should be in config section
"user" and not in "core" as documented in Documentation/config.txt.
---
 builtin/config.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index d32c532..bfd3016 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -455,9 +455,9 @@ static char *default_user_config(void)
 	struct strbuf buf = STRBUF_INIT;
 	strbuf_addf(&buf,
 		    _("# This is Git's per-user configuration file.\n"
-		      "[core]\n"
+		      "[user]\n"
 		      "# Please adapt and uncomment the following lines:\n"
-		      "#	user = %s\n"
+		      "#	name = %s\n"
 		      "#	email = %s\n"),
 		    ident_default_name(),
 		    ident_default_email());
-- 
2.3.5
