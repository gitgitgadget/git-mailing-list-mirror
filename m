Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 715CD201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 20:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752892AbdF3Ulr (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 16:41:47 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36607 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752885AbdF3Ulq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 16:41:46 -0400
Received: by mail-wr0-f194.google.com with SMTP id 77so39976311wrb.3
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 13:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=st5NqMzIbPEm/mC7w3+pAWFoUkNOWrtB7P45P/R580E=;
        b=gzPsM+AKC+S59Y0jKVkIO3WCnroVrXjamZs9B4/oSpSfV7MYMzt6CY+07gvoYE97S4
         ehXYvCDwj2fgoBDbK9jGjiX1kTUcSOoLJU4mAazKNQed3BqK3VKyaz7FpJ4wTsv0gqz5
         NPzkLYCl3QIrRnK3yvMzeJoKPfC6ZO/qRSRHNIep8G32aMEUMIMighvCTmwRTvxhghrG
         oZm0aDADmB8RHFs849ULnjSjByNuAkWGKP8Ba4t/Oz0Yy+h7xPW57Ny+h3ljmsE8AJVt
         OdS4oF2FjYZBsgUAOjaSWkc4cP9cum8L3bqyT+UP1g+9ZzrPlDFX83haaMXQSowoxIAJ
         Xi+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=st5NqMzIbPEm/mC7w3+pAWFoUkNOWrtB7P45P/R580E=;
        b=L+gpNrsiPCTRVrMHLCz+m9tQuAa9+e7X1Ab1G0irwE1yc/TztS8ek7Z0sAAA8HhHyh
         Cc88g6rt8scbGGJObQ6WeiZdNxvJNM7VW94PYqbNhMEyhwKThrGefGmBFHR5ZUjhoFQO
         TRPSDbsHPNDw2SBBcd0Nw/iuAxzXTu/bRUtAutqCysDpjnV1mcjNSWVC59TUYTDkSkJV
         eCnFYkHuUEwujrDfJSqgv/VPOGemDOwsEAl9nlL5XiGPlY17SWvT3IFhuI1B6dddeGPZ
         WIQNqlkoJ0ph7SwY+vQe+NvPUcCCQiGjbBdSKbXLJr6AwscG0e3/huNRbZEAHXfYUzE3
         xMFA==
X-Gm-Message-State: AKS2vOyhYm7QCx6dCRjkEQVwmOLDlrbqtfUtVaBXCc4+BNPuAM3QnyK2
        HRj+osBb9s5cjofC
X-Received: by 10.223.179.13 with SMTP id j13mr28453129wrd.108.1498855295019;
        Fri, 30 Jun 2017 13:41:35 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB4C89.dip0.t-ipconnect.de. [93.219.76.137])
        by smtp.gmail.com with ESMTPSA id v144sm10648239wmv.27.2017.06.30.13.41.34
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 13:41:34 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com, peartben@gmail.com
Subject: [PATCH v9 4/7] convert: put the flags field before the flag itself for consistent style
Date:   Fri, 30 Jun 2017 22:41:25 +0200
Message-Id: <20170630204128.48708-5-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20170630204128.48708-1-larsxschneider@gmail.com>
References: <20170630204128.48708-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 convert.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/convert.c b/convert.c
index f1e168bc30..9907e3b9ba 100644
--- a/convert.c
+++ b/convert.c
@@ -597,12 +597,12 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 	}
 	process = &entry->subprocess.process;
 
-	if (!(wanted_capability & entry->supported_capabilities))
+	if (!(entry->supported_capabilities & wanted_capability))
 		return 0;
 
-	if (CAP_CLEAN & wanted_capability)
+	if (wanted_capability & CAP_CLEAN)
 		filter_type = "clean";
-	else if (CAP_SMUDGE & wanted_capability)
+	else if (wanted_capability & CAP_SMUDGE)
 		filter_type = "smudge";
 	else
 		die("unexpected filter type");
@@ -703,9 +703,9 @@ static int apply_filter(const char *path, const char *src, size_t len,
 	if (!dst)
 		return 1;
 
-	if ((CAP_CLEAN & wanted_capability) && !drv->process && drv->clean)
+	if ((wanted_capability & CAP_CLEAN) && !drv->process && drv->clean)
 		cmd = drv->clean;
-	else if ((CAP_SMUDGE & wanted_capability) && !drv->process && drv->smudge)
+	else if ((wanted_capability & CAP_SMUDGE) && !drv->process && drv->smudge)
 		cmd = drv->smudge;
 
 	if (cmd && *cmd)
-- 
2.13.2

