Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F26F1F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 18:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751538AbdB0SCF (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 13:02:05 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33537 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751344AbdB0SCD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 13:02:03 -0500
Received: by mail-wm0-f68.google.com with SMTP id v77so14620293wmv.0
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 10:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RWGnJGxqJu7Ux35xmwoL09And/gTw3D1PGP0PwbEQ2o=;
        b=WZSzzrtpQf3iu/UppzS7YvmSB08QMM4SKrWUQh04uRErFiLrOsOL5sodXROXC4ynQR
         g5eWNEOVuiNTPu/1uAJ2kGHqsPE52/r/g6j2CVwpMD+EVJfVFPZqHERHmhR1KdUblcOD
         /BkE/xy8IAwyIU49nGLSkqwlP9KAiOz7lICvZemkOTXHcIRx3p2ga5zv6XsIXuWwROeT
         xCcWGc5tH4FNdu+5AB9s76Ah1Ta7P5sFjRrM70SwvRSEBCQshzLB1S1Cg6j0YWtGDbm7
         RfM4E7OfS2Qsid8+UYDPpfmRWY8U/W3CDchx6ukdbTKk3XXFN+XIFaecikwfLLaBGSCZ
         rYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RWGnJGxqJu7Ux35xmwoL09And/gTw3D1PGP0PwbEQ2o=;
        b=m6ITU0ZnpTy5OwAPYeo8kqR7XJzpklRP9PakSm1y5QefSLk322Z22xsy6Hn7XtZkcK
         o2u2loQLwGyZCTQ3I4tQhcc9+gYvF6wJv60PNsJ3aMhlNuvHhEAs6peggf2EIZGbMchd
         dpVQdNWtOqjdroYgfq7NVfVH44c+W0tEK/yX6pMZaCueEiXHNQJyrFYxObHPAZfQsdok
         zDGw6iFn4yxboLRbOMwghVOV5mA3JPWSwPF+INK2vnkxjtglE3zoTzt83pM2Wh+qsJ+o
         RxEoDOHEbRIEGDzHtfcOB/zCirtg6wksPh2EDB0tmqhyTH2ObIlymSzeOgsf9jTKFr+c
         91Ow==
X-Gm-Message-State: AMke39l3q9wz6QWdr3PBn2vKd6nOzEhbSJ5KEDHkZIscGn0Jyb34og5CCNIBBTUvaMcSJw==
X-Received: by 10.28.1.216 with SMTP id 207mr15351758wmb.7.1488218437649;
        Mon, 27 Feb 2017 10:00:37 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id e73sm15226798wmi.32.2017.02.27.10.00.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 10:00:36 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 01/22] config: mark an error message up for translation
Date:   Mon, 27 Feb 2017 18:59:58 +0100
Message-Id: <20170227180019.18666-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.12.0.22.g0672473d40
In-Reply-To: <20170227180019.18666-1-chriscool@tuxfamily.org>
References: <20170227180019.18666-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 config.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index c6b874a7bf..2ac1aa19b0 100644
--- a/config.c
+++ b/config.c
@@ -1728,8 +1728,8 @@ int git_config_get_untracked_cache(void)
 		if (!strcasecmp(v, "keep"))
 			return -1;
 
-		error("unknown core.untrackedCache value '%s'; "
-		      "using 'keep' default value", v);
+		error(_("unknown core.untrackedCache value '%s'; "
+			"using 'keep' default value"), v);
 		return -1;
 	}
 
-- 
2.12.0.22.g0672473d40

