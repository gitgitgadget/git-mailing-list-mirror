Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02CDE1F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 15:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbeKUBeh (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 20:34:37 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40992 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727866AbeKUBeh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 20:34:37 -0500
Received: by mail-wr1-f65.google.com with SMTP id x10so2319208wrs.8
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 07:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=inQboS/wXMH4ylbBFHEnE5fsSdQ2qCoBc8ODwtFDtN0=;
        b=IdoD8nCcFeCfHSwcZCr24iFOv+j87e2p54T7YYSc/gMQ3vAxEqbZxwkwxtC3UrU9I0
         Gfm+Ek8sUsKqWk9z04+QiCEMGT+y3sfwQaWi/490RZNGJ8k3etb0KHruEyLkcyEwKpcL
         gUnxVmJvKJiQrcXm5pccUN+jWDLtPCJkHcN2d3Vta8GTjhf7iQhN6ljerLrPbZEK6Hf/
         iU7/AGno66JiWPBNTugbOFs4kt1LBJg3VS7+Oa3WvnTe7WrVkALVXoqzKKsSl1hD4Qoj
         Fz9+5N10hU+meENd7S4A0XDTc5FiVYNO6yAiw7hq4w//z9+ZJnw3LFT+HJFb6S0EHHNS
         bShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=inQboS/wXMH4ylbBFHEnE5fsSdQ2qCoBc8ODwtFDtN0=;
        b=KsNSkS+qK3Xee65Cly4suyuKx6t1tQBuia0/GvNgUfZWQr+HwRdDu1yVUhomhgpE+V
         6VfdxM5OtHubNxbEtg/Y9lM+ETk+laCmKGkZe6I0M/qu+NGA7GNZv+xCHPOBdmzEY9Ud
         DGX1O/Dv+WYazqFeKiV2LZ37TkTNXvZi3jBayWFRXl7oQzNNTEkZlEYMzu4wa5M9QJQt
         HqYFe0dhjEb5q0GGYsLpAgWcOWManRqoRjxEehCBAoFpoMt2w/h2vAbeNkYiBb0taaPx
         Ga4sq5JQx9pIeaYoYRxnvUwuYpJQ52UxFhxWe23YlaQGi5mZIvKLt/4MZhOlp9sEdo3a
         QT5Q==
X-Gm-Message-State: AA+aEWYoeopnafL2t7t16OhLgFoGtpbP1HS00OJLNNDase8TTKtDfiFL
        2Cw8unqM9OAiSThjozTclPzPMe5k0/A=
X-Google-Smtp-Source: AFSGD/XPCGpgFY10RR+m+Jwtd11Pt5txRZCy23JzHIvTMZrYdNyZjpu9DXNOsBnD2F8PRmnIDIXnTA==
X-Received: by 2002:adf:c44a:: with SMTP id a10mr2182765wrg.145.1542726301037;
        Tue, 20 Nov 2018 07:05:01 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id j13sm26378460wrx.5.2018.11.20.07.04.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 07:05:00 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/6] commit-graph write: remove empty line for readability
Date:   Tue, 20 Nov 2018 15:04:42 +0000
Message-Id: <20181120150443.12997-6-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c
In-Reply-To: <20181119225720.GV30222@szeder.dev>
References: <20181119225720.GV30222@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the empty line between a QSORT(...) and the subsequent oideq()
for-loop. This makes it clearer that the QSORT(...) is being done so
that we can run the oideq() loop on adjacent OIDs. Amends code added
in 08fd81c9b6 ("commit-graph: implement write_commit_graph()",
2018-04-02).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 commit-graph.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index a0aea850f1..d0961e89df 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -894,7 +894,6 @@ void write_commit_graph(const char *obj_dir,
 	close_reachable(&oids, report_progress);
 
 	QSORT(oids.list, oids.nr, commit_compare);
-
 	count_distinct = 1;
 	for (i = 1; i < oids.nr; i++) {
 		if (!oideq(&oids.list[i - 1], &oids.list[i]))
-- 
2.20.0.rc0.387.gc7a69e6b6c

