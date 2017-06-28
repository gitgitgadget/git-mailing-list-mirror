Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C56852023D
	for <e@80x24.org>; Wed, 28 Jun 2017 21:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751629AbdF1VaF (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Jun 2017 17:30:05 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34390 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751817AbdF1VaC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2017 17:30:02 -0400
Received: by mail-wr0-f194.google.com with SMTP id k67so35232498wrc.1
        for <git@vger.kernel.org>; Wed, 28 Jun 2017 14:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=st5NqMzIbPEm/mC7w3+pAWFoUkNOWrtB7P45P/R580E=;
        b=suOrzEnoKgfnW0FRXjrs6Ucj5vc61fvTynkpHAO4cupdi/GRSv5lOblQeCZxaMVmnZ
         7T8Eh1zK3TyGCCBER5d/PQktkagbAuOFDyDjTcO62GomM/tNvc8f0JGps0OPTumMThzW
         K+9/K0QAoNHCXveFtBP5kDLVN256kMhRFY5pbC5dEDkRX8HtzEwz2+54RAGYOCwiVFRu
         3gpOOJmdTKQ/9HLmM4eaAl45EsEeTtZfwTKkOEIhcbt0fOLw3SKBEZnR7Ae54wk6tX6t
         4MlbkVxlMsArCL/6AuOU87fQ3cxyGICm8Db7/cgVzGu2DBKPfPyQ3GFjmichUG79u/6r
         3hpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=st5NqMzIbPEm/mC7w3+pAWFoUkNOWrtB7P45P/R580E=;
        b=Hj1OpyvEIilidGGcLHUCuuRspMib3U7csvKCt8RqH+N8oqakLYgYZB57WrtdxSdzCJ
         dTu56K0vyoM0+T2QbEux+2O1wN3Ua1VQ0Sy2pz/KJgCSp8QQfHwdkjowhNRZKyvddyJx
         Vyglt27CQVfQDstANKvPSaNwRLzP+NafYchc8nP1YmbasDaWojLbbFkbNag0yRHhmOXg
         w/XCsAp6UQJVaxAk+ldC+3q3oZ2RlQn1F46na6c6EGXLbUU3dIEloM2V1hIExz20YBKL
         M/+Xk3yjGvA5LwAue63Av1CKTYuZ3BKlQ/okdUKDJD+6K6/f6XotuwSFWarwvj6U3XBX
         qneg==
X-Gm-Message-State: AKS2vOwOeyGEBp2XdhPVB3NOYwcMX7sh9ZDBaVjLQdeh6Ujh0VDxFD99
        4CQZH/EdlCwLh8kk
X-Received: by 10.223.179.67 with SMTP id k3mr22678321wrd.198.1498685400213;
        Wed, 28 Jun 2017 14:30:00 -0700 (PDT)
Received: from ccsh0hfn32.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id l20sm2581036wre.25.2017.06.28.14.29.59
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 28 Jun 2017 14:29:59 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com, peartben@gmail.com
Subject: [PATCH v8 4/6] convert: put the flags field before the flag itself for consistent style
Date:   Wed, 28 Jun 2017 23:29:50 +0200
Message-Id: <20170628212952.60781-5-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20170628212952.60781-1-larsxschneider@gmail.com>
References: <20170628212952.60781-1-larsxschneider@gmail.com>
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

