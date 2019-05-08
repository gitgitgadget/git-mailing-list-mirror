Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92AF81F45F
	for <e@80x24.org>; Wed,  8 May 2019 15:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfEHPyC (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 11:54:02 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35820 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727799AbfEHPyB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 11:54:01 -0400
Received: by mail-ed1-f67.google.com with SMTP id p26so4699079edr.2
        for <git@vger.kernel.org>; Wed, 08 May 2019 08:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7ZBZ9ZHhPFDnhnLHZgorSoeEixTgFOAq3pOtsSYw7+E=;
        b=D4I1dOvYK5lg7Ru7IHbxjPqDaNfoqNElZ+0Ohckaxcbh+YR+r/D6PmagKxKAsSz73D
         V9c3lHyf7qSdCYB9wKikDI3kqBUwJoGMsdZ8gBENipdodJccbo/CfFntCOGaCLNGqGI0
         fmDLNHXOlpVBpduC7HpeN3Y2F88/GB5ek85W6TIKLN5qCR/kGowolF/pWu+pdp8Wv/t3
         /AOuXljoaa1pNKdfMxdAhjkuScpTxyfVL1eNlnzbnRDKrlbPnsdKbO+s76FKXzcNyta3
         XinsntRHPNNQsSzaZWmqzao94b7ghavUmCC8rfU1jWYwYpRuuL2C6mHo8C13xp768ScI
         22YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7ZBZ9ZHhPFDnhnLHZgorSoeEixTgFOAq3pOtsSYw7+E=;
        b=bG9qOIaz2kZtQZOz1RQxxsm/jabR3INgwWCZBeV7b+JmZTSZx8r5VHsbf0f+FZVl5a
         eKlK15G3UXfFu8DG3E1ptq+KS87eWWikMV/QkdzDVqYu3Zpto0rDCjcO0NMfjL+bHjdx
         gp45T6pXPW8fUGkizHlqgKlNwW02ia3BYohohabJtkx1SqXmuXaovxmbjtbIQCDojXVk
         Ti5vo1vk6E3ZlLpYrP91AGU+JGr1nGyBpDeznynTRx86bIhY3OHf6gEJZ/TWTWwZVQ2D
         8uojvaTXsRIKcPWX4T9haYvwXH/cMH19kTsG4UGo5pvX+7fArq1IrTSCbprYqwcGtcJH
         3/bA==
X-Gm-Message-State: APjAAAWNFYlsZqgLNLYObrRHmOGnbf4XxhPBj04qeR7sAy1UzkDE6334
        g1btGmWufgn+A6+GdwMFjUXUldriECI=
X-Google-Smtp-Source: APXvYqyeqYqa9asBCoFkse3Zgb9otMQQ1X1V+nk0aCTOiIIF+Q1pU71pKAh3a9u3pUMbvqsmhpHCpA==
X-Received: by 2002:a17:906:2a94:: with SMTP id l20mr27732433eje.44.1557330840045;
        Wed, 08 May 2019 08:54:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x30sm5245042edd.74.2019.05.08.08.53.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 08:53:59 -0700 (PDT)
Date:   Wed, 08 May 2019 08:53:59 -0700 (PDT)
X-Google-Original-Date: Wed, 08 May 2019 15:53:43 GMT
Message-Id: <4436c8f4f1ebd97b0709a030a85a46221e111cad.1557330827.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.git.gitgitgadget@gmail.com>
References: <pull.184.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 14/17] commit-graph: load split commit-graph files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Starting with commit-graph, load commit-graph files in a
sequence as follows:

  commit-graph
  commit-graph-1
  commit-graph-2
  ...
  commit-graph-N

This creates N + 1 files in order.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index f790f44a9c..5f6193277a 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -45,6 +45,12 @@ char *get_commit_graph_filename(const char *obj_dir)
 	return xstrfmt("%s/info/commit-graph", obj_dir);
 }
 
+static char *get_split_graph_filename(const char *obj_dir,
+				      uint32_t split_count)
+{
+	return xstrfmt("%s/info/commit-graphs/commit-graph-%d", obj_dir, split_count);
+}
+
 static uint8_t oid_version(void)
 {
 	return 1;
@@ -289,15 +295,31 @@ static struct commit_graph *load_commit_graph_one(const char *graph_file)
 static void prepare_commit_graph_one(struct repository *r, const char *obj_dir)
 {
 	char *graph_name;
+	uint32_t split_count = 1;
+	struct commit_graph *g;
 
 	if (r->objects->commit_graph)
 		return;
 
 	graph_name = get_commit_graph_filename(obj_dir);
-	r->objects->commit_graph =
-		load_commit_graph_one(graph_name);
-
+	g = load_commit_graph_one(graph_name);
 	FREE_AND_NULL(graph_name);
+
+	while (g) {
+		g->base_graph = r->objects->commit_graph;
+
+		if (g->base_graph)
+			g->num_commits_in_base = g->base_graph->num_commits +
+						 g->base_graph->num_commits_in_base;;
+
+		r->objects->commit_graph = g;
+
+		graph_name = get_split_graph_filename(obj_dir, split_count);
+		g = load_commit_graph_one(graph_name);
+		FREE_AND_NULL(graph_name);
+
+		split_count++;
+	}
 }
 
 /*
@@ -411,8 +433,15 @@ static struct commit_list **insert_parent_or_die(struct repository *r,
 
 static void fill_commit_graph_info(struct commit *item, struct commit_graph *g, uint32_t pos)
 {
-	const unsigned char *commit_data = g->chunk_commit_data + GRAPH_DATA_WIDTH * pos;
-	item->graph_pos = pos + g->num_commits_in_base;
+	const unsigned char *commit_data;
+
+	if (pos < g->num_commits_in_base) {
+		fill_commit_graph_info(item, g->base_graph, pos);
+		return;
+	}
+
+	commit_data = g->chunk_commit_data + GRAPH_DATA_WIDTH * (pos - g->num_commits_in_base);
+	item->graph_pos = pos;
 	item->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
 }
 
-- 
gitgitgadget

