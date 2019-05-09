Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEC791F45F
	for <e@80x24.org>; Thu,  9 May 2019 14:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfEIOWr (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 10:22:47 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40648 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfEIOWk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 10:22:40 -0400
Received: by mail-ed1-f66.google.com with SMTP id j12so1456652eds.7
        for <git@vger.kernel.org>; Thu, 09 May 2019 07:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=b8z93/FWqgWVwgTgqfbO0pDDEkvy23xDqCRgy86Cg5s=;
        b=jrWoeQfF4V3itgsLzq9Iv5YmaY8UrnM3dd99QHwi/13Ek4OYgi3cRDa89sqn2K4O3y
         YkMwNnEIAXcEE2KuidN+Gp6IwlUgaK2NOxg/ZuEOtvCGOtpuR1MLgiuz4vpMKGuOy0Of
         qPNY2PCsoXrbDQFfCj1iOyT96E6Rl2txPequyEbIgHRXxOr0zv07mLDdG6UJ1NBU+pEt
         7uuVs++TX3I2krVl+OUNiwqFjLtHHh8OUUgnqt2RvH+SYYgzMhzyXQ85ogy0PeJzruns
         plZNVItbGkImNCBG8eMENK1J82g0lZkLDKnXM0JxGrqeBsEB0Db59UWeXEW+FGqyD5xQ
         i+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=b8z93/FWqgWVwgTgqfbO0pDDEkvy23xDqCRgy86Cg5s=;
        b=VgOXw5Y4OW+1fP6X+WpqnnDQhmURB6yqsH/0PE+EZj5tTkeEEBDp1G6vb369EWZw2u
         3jUFyDA6kdQI+rVLlVQ80NR+bXPwlYtuNLuHc4l2Pc9K8ZIuxqMyWj9H8GLUK714Cl5l
         hxw+lQI2RPLKCyP69UepaQnFMgfepzNAN03krwXP4ZIJoqnu+BVfHb9TlR6qfg/icp/v
         IT8y0LjrH+pgozhm8d4UZHodRuNZChpN3QXoyw128GN8f0PZHVsEGNbiEMelTlfQUgmh
         dVXhXbQQsHrj9EDgXaU/PaBScQSafwE1n9glNTeKJ3NRewN3uoMcvVLMGaaR4na29fJz
         HnQg==
X-Gm-Message-State: APjAAAWP+iyl9lCBkBkAQe7xHufDo7w8XAjH27Rjc+EW3oYkvni8gTRd
        sZ33AXOxPn3o9883UEisG0iQ6/9Z
X-Google-Smtp-Source: APXvYqzcDtEfOsm/VcctIJiJFeRQ0F/AWS2HY9yYcdUKN5Uo4HC1Ddo/47jGRlaAWdFz709e08RYNw==
X-Received: by 2002:a17:906:7d0f:: with SMTP id u15mr3474377ejo.79.1557411759023;
        Thu, 09 May 2019 07:22:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j1sm608024edc.48.2019.05.09.07.22.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 07:22:38 -0700 (PDT)
Date:   Thu, 09 May 2019 07:22:38 -0700 (PDT)
X-Google-Original-Date: Thu, 09 May 2019 14:22:27 GMT
Message-Id: <a37548745b91cb275c0294aab15abdd2c4d3207a.1557411749.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.112.v4.git.gitgitgadget@gmail.com>
References: <pull.112.v3.git.gitgitgadget@gmail.com>
        <pull.112.v4.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 09/11] commit-graph: extract count_distinct_commits()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, avarab@gmail.com, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The write_commit_graph() method is too complex, so we are
extracting methods one by one.

Extract count_distinct_commits(), which sorts the oids list, then
iterates through to find duplicates.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 730d529815..f7419c919b 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -963,6 +963,27 @@ static void fill_oids_from_all_packs(struct write_commit_graph_context *ctx)
 	stop_progress(&ctx->progress);
 }
 
+static uint32_t count_distinct_commits(struct write_commit_graph_context *ctx)
+{
+	uint32_t i, count_distinct = 1;
+
+	if (ctx->report_progress)
+		ctx->progress = start_delayed_progress(
+			_("Counting distinct commits in commit graph"),
+			ctx->oids.nr);
+	display_progress(ctx->progress, 0); /* TODO: Measure QSORT() progress */
+	QSORT(ctx->oids.list, ctx->oids.nr, commit_compare);
+
+	for (i = 1; i < ctx->oids.nr; i++) {
+		display_progress(ctx->progress, i + 1);
+		if (!oideq(&ctx->oids.list[i - 1], &ctx->oids.list[i]))
+			count_distinct++;
+	}
+	stop_progress(&ctx->progress);
+
+	return count_distinct;
+}
+
 int write_commit_graph(const char *obj_dir,
 		       struct string_list *pack_indexes,
 		       struct string_list *commit_hex,
@@ -1024,19 +1045,7 @@ int write_commit_graph(const char *obj_dir,
 
 	close_reachable(ctx);
 
-	if (ctx->report_progress)
-		ctx->progress = start_delayed_progress(
-			_("Counting distinct commits in commit graph"),
-			ctx->oids.nr);
-	display_progress(ctx->progress, 0); /* TODO: Measure QSORT() progress */
-	QSORT(ctx->oids.list, ctx->oids.nr, commit_compare);
-	count_distinct = 1;
-	for (i = 1; i < ctx->oids.nr; i++) {
-		display_progress(ctx->progress, i + 1);
-		if (!oideq(&ctx->oids.list[i - 1], &ctx->oids.list[i]))
-			count_distinct++;
-	}
-	stop_progress(&ctx->progress);
+	count_distinct = count_distinct_commits(ctx);
 
 	if (count_distinct >= GRAPH_EDGE_LAST_MASK) {
 		error(_("the commit graph format cannot write %d commits"), count_distinct);
-- 
gitgitgadget

