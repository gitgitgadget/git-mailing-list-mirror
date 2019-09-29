Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A34B1F463
	for <e@80x24.org>; Sun, 29 Sep 2019 00:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbfI2A4j (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Sep 2019 20:56:39 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36014 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728569AbfI2A4j (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Sep 2019 20:56:39 -0400
Received: by mail-io1-f66.google.com with SMTP id b136so27936322iof.3
        for <git@vger.kernel.org>; Sat, 28 Sep 2019 17:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S6oIHYiMxlfNkY5VI1546fPXuc8nPRRUzqZiiYFQGqE=;
        b=On41YQEaS69Yb3Pjv6rU/8dWCgUcuTqHh0BFuxe5DOgZQ1Voqmioh5DiPdolPIyQet
         vt0HDRzx+bXy3mVQrVK9Pb2oYuOmm6lyaFeVs5imV40KEDhv28eO+H8NQBwTc7XCLnvQ
         b7jpLjHtc5vu7ypXDScefWc2mMuOMo3EBdS2Kq+MTpa09eyjl5fUKwF8is2HXZiWhQ/k
         TWxDc5JMCLZSHt1A/Xdx93rnVhtWuN4fAlFc8fHHFReEUEOlJ6UAYiA8blTKn3WkR6ai
         ciS3f3WZ/EOEUTUfgJGNaH7xt3huIbhXCgwIkwvJko1FqStDDsGX+SxMr+3aqiDvUlHJ
         Hb7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S6oIHYiMxlfNkY5VI1546fPXuc8nPRRUzqZiiYFQGqE=;
        b=QJAax64KycshvDZjqx0ICFIm+mtPeOLlLKfpho/QxqAHj6eiV5rCIROJWdIbqsD1NI
         3N/RCtbaQ3+QXr2eBgQ0+yNqFsooO5xOZIgwmSHSK1be5CgoKkLmPJc/rFNu23rScH7L
         MX7A67JIDn7h2M46wAYpr1wWZDHpAo1mQDm+sXs1BSWp1hj8oitUIr4+nUxZb+ss117S
         T6iP0ddgVMDlHDNRkLuGRwXv4vt3BWpsxDtZIrPR8rdOU2kD/l8NbWu3cdFdDAWdEBs1
         LrG1zXiJGjW93OlKvce58rZ993BhoCX+umxtwig7wJNvmuR1Ex/rLl1NlqxYiwQW/6za
         ywnw==
X-Gm-Message-State: APjAAAWuUVfdPyVJ8kAvcIo5PMxvlfct8EJVMIkraWhSxVM2IMFmecEq
        TxKWPE64thGNHhasJxrx0w4HAEM4UJw=
X-Google-Smtp-Source: APXvYqzS85DC9QofnCLoELv4ANEkEFg0dely2kONXQGPJfUcYzQHvZ4nau96PYlSc4nwOKgS7bE9Cw==
X-Received: by 2002:a92:5e09:: with SMTP id s9mr13968612ilb.139.1569718597948;
        Sat, 28 Sep 2019 17:56:37 -0700 (PDT)
Received: from xavier.hsd1.ut.comcast.net ([2601:681:4100:375e:3837:c90c:13fa:5c01])
        by smtp.gmail.com with ESMTPSA id q22sm576338ilb.12.2019.09.28.17.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2019 17:56:37 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, dstolee@microsoft.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v3] commit-graph: remove a duplicate assignment
Date:   Sat, 28 Sep 2019 18:55:58 -0600
Message-Id: <20190929005558.733699-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The variable g was being set to the same value both at the beginning of
the function and before the loop. The assignment before the loop was
kept because it helps clarify what the loop does, and the redundant
assignment at the beginning of the function was removed.

Reviewed-by: Derrick Stolee <stolee@gmail.com>
Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 commit-graph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index 9b02d2c426..d0e1f9e1f2 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1522,7 +1522,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 
 static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
 {
-	struct commit_graph *g = ctx->r->objects->commit_graph;
+	struct commit_graph *g;
 	uint32_t num_commits = ctx->commits.nr;
 	uint32_t i;
 
-- 
2.23.0

