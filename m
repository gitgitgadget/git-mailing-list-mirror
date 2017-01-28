Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3101B1FAAD
	for <e@80x24.org>; Sat, 28 Jan 2017 02:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751098AbdA1CCn (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 21:02:43 -0500
Received: from mail-pg0-f43.google.com ([74.125.83.43]:35610 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750997AbdA1CCi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 21:02:38 -0500
Received: by mail-pg0-f43.google.com with SMTP id 194so85528521pgd.2
        for <git@vger.kernel.org>; Fri, 27 Jan 2017 18:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YNxTeRaXx3D17N4/bq5t+o/JtV4W+EkDn723n5BizPM=;
        b=iZe5ZlxvClv1xSTUu55icBSdxsjeQJVbzUOzwJmfjMEoWErO2+pHqB+zTdbE1bJ3hz
         /DCCSZOwILQTWuxrQDJZN13QzyYU5gYuL8L59towOkAIBDmTiWBI5OxCRqHPUjCqh0qf
         jXODGcQDi8j2YG4jX5Ltx5bqHfomx8EGKA6qt3UUOSB+oRCKRyhdcUMugumqwDvBOVuU
         uc/t7CdeR2o71KqY+xUDlZ5g0aTu3qu/1hz2cJqq9bUGQixd8+xiCdrf/zY+PMPkC9et
         lflIMMUFbsz7WaaaS/DtH+wN8hhh/FvzNW9HHSIrgf0MPA44m2ZObPMSlKBaVpl56mOE
         bvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YNxTeRaXx3D17N4/bq5t+o/JtV4W+EkDn723n5BizPM=;
        b=P6SuTEVtN5IE0E0ACQ/vm2pUIITYp+YqgRHpgT08YSZ1YMOhTXVFxiIflYQfEK94R+
         EBnxDey3ibt+h939CmzOBQqWA5qbubQxTg9oz/3qrZo0Xehyv+8x4F4Ua4o5MxmowePZ
         TcLgl4Yy4a0YD4QB9XhNW+xdcVcR159JF6OGyvBp/KOcjrPaidOGR4FLswejXbjLkp8F
         4Yaq9q5IlO9M/u1dohcf0R+Ba+NlNr3ZnVlhkrNkY6FGkZGGlP8NXDnMGT9KUTefQ3rQ
         vK4MuOQIYvTtNdPutepZtl0/V99HqQ7sFwdVY193jgeoYGQDRHiPs335v0aAElMSnUhH
         UCFw==
X-Gm-Message-State: AIkVDXKJMa4ppgCY6p3r5ATCbvYHAZwubmQisDY7y/DdZ2P2tTg9unYbYwxO4eFf/9u9GmXr
X-Received: by 10.99.47.199 with SMTP id v190mr12435143pgv.26.1485568957328;
        Fri, 27 Jan 2017 18:02:37 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id w76sm14136185pfd.74.2017.01.27.18.02.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Jan 2017 18:02:35 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, sbeller@google.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 06/27] attr.c: mark where #if DEBUG ends more clearly
Date:   Fri, 27 Jan 2017 18:01:46 -0800
Message-Id: <20170128020207.179015-7-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170128020207.179015-1-bmwill@google.com>
References: <20170123203525.185058-1-bmwill@google.com>
 <20170128020207.179015-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 attr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/attr.c b/attr.c
index 9bdf87a6f..17297fffe 100644
--- a/attr.c
+++ b/attr.c
@@ -469,7 +469,7 @@ static void debug_set(const char *what, const char *match, struct git_attr *attr
 #define debug_push(a) do { ; } while (0)
 #define debug_pop(a) do { ; } while (0)
 #define debug_set(a,b,c,d) do { ; } while (0)
-#endif
+#endif /* DEBUG_ATTR */
 
 static void drop_attr_stack(void)
 {
-- 
2.11.0.483.g087da7b7c-goog

