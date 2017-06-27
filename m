Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDADF20401
	for <e@80x24.org>; Tue, 27 Jun 2017 12:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753101AbdF0MLG (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 08:11:06 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34062 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752883AbdF0MLA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 08:11:00 -0400
Received: by mail-wm0-f66.google.com with SMTP id p204so588729wmg.1
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 05:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=st5NqMzIbPEm/mC7w3+pAWFoUkNOWrtB7P45P/R580E=;
        b=ZRNy16IeeKIGI7l9+NNIpTTorAFBF/3wLEG7g3HwSdl7N6cyEKUYD59XD7kXTbYmrn
         AmxkHR6ZnL6SvsGWE7eSqxWZiazagVqq9CC8fNF1+ptEJvTXdSSAFQZnWmKUxW5pmpXe
         r1mzj7BzuHtbTCs0RCu6h46H8TcJzDLHu/P96iQp8Znk2AFfaurnZ/yz/Yj/w1Y/mjlN
         DccQ8Zb75bg0ESmlhs/vpaLj43GSU8OMu6094HUq60suYD2O3Cj1tsFW0csJT0YoRai9
         WpN9azBANI3xkmfni7MQTBJqmX9q1eD1Vf9qoh+4ClYuB47XSR08fKTMFAEKdUFAtOwn
         a+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=st5NqMzIbPEm/mC7w3+pAWFoUkNOWrtB7P45P/R580E=;
        b=C+p/X1dBtwvZW5XDJKSnKDPKOPgWaIgjU50MYcp6x0uZPsrA9AlUgx+nphUntPKUX3
         vN6XJjaa6p1SvPHrR5QhL8A3lEUGGfbtdLp044I000IfmlxY3pK4Fr7iYlpdpZ03m80S
         xjfGtqOYmTUZgb7pejULTlCNL/8AUY3em11FPwv/2y7JMyeoJiaCn/AvvwNksLjcZxKz
         2EUiGbrzsmP8LUk2C5eZlSPABuDSvlyLbMfhQgAzU8bC7J5szu5I7ON8knebCNUj51Bn
         s9r4ZJ096o2HsJwaqMfLG2u3exkWXwLSK15CTbk8AnJC5uttTIozBxpDdatM0E/N2D5A
         D2dQ==
X-Gm-Message-State: AKS2vOxT7YqbZaUID2Z2zJSIXJGJh5V23QBmOnAfbTDH/SG8WM2v6vko
        ZZ48rcrQ5zGk8G1z
X-Received: by 10.28.17.4 with SMTP id 4mr3244541wmr.63.1498565448271;
        Tue, 27 Jun 2017 05:10:48 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id 32sm17873976wry.31.2017.06.27.05.10.45
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 27 Jun 2017 05:10:47 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com, peartben@gmail.com
Subject: [PATCH v7 4/6] convert: put the flags field before the flag itself for consistent style
Date:   Tue, 27 Jun 2017 14:10:25 +0200
Message-Id: <20170627121027.99209-5-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20170627121027.99209-1-larsxschneider@gmail.com>
References: <20170627121027.99209-1-larsxschneider@gmail.com>
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

