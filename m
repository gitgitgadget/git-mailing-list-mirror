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
	by dcvr.yhbt.net (Postfix) with ESMTP id 5069D1F462
	for <e@80x24.org>; Mon,  3 Jun 2019 16:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbfFCQDz (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 12:03:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42251 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbfFCQDy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 12:03:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id o12so5554150wrj.9
        for <git@vger.kernel.org>; Mon, 03 Jun 2019 09:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aJoUsfkOI1fhuOMGoTyVXCjVpWEVLD0dftfiT6TBwZs=;
        b=Eie4qzumx8DHED1sWtylGDVOaPzd5W7xQlgRlalgUkLVcD3/AyITePZkehQo/4qb+v
         PeSNWB812piF9qvBvkPKz/AV/0/4FAMdp73WutjfbF9KK4oTJskMNyV1DYaLBowMhPs4
         sJivI+HdSL+XJv+6Ws/kn3ty1ZUVKsQ/cI2hjo5PVLzkTttOrevG+biejB2kXErjFNEr
         QWffN4BVWLYwKuBGji5fsARUGpn9AHcVQqtkjW7+6e5b8sEmEKHliOzgigIog/HuuSFB
         HWmK31cZpN5OpqvASbWEYY9Zn/ovu/SB37BGLjWpov1zbmXn1ca/uzNw7uzjiCT28cd3
         Silg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aJoUsfkOI1fhuOMGoTyVXCjVpWEVLD0dftfiT6TBwZs=;
        b=fbtyhOafzyZwCHZKLa4lQSOZdYNACtGUZX08iTS0Pe8mcBVzSKGnWjpL7v83MN6jyo
         6s2HMsPrXsORyqxFflm5mbsYW92jpY+aNSRP2rBCikw7NHJ2oTbCojkbB6cl8dAoqeGV
         OgAyxi19y37PATLhp4qQObBe8elljsQ9C/z6o787+aQrdqZdfmkv8bOCzTZmJfC1xXqY
         PnpO/9G2XB9PRQ7spWI1sGnZsXkT5xzxLk2KPi7JxtunIHgEA5O5a+2ezZEUPEWSud/U
         WQPdow5wgi3nZKsLdN8kMlWVyL5sovPG4pmd6UaVOO2TxjB05owsE5KlJn8x9OVrgBzT
         321A==
X-Gm-Message-State: APjAAAUBxGWRiaYJEr1JMXs7ogUsT4hnrwMzSfywr9xSl0wQsTSQogc8
        aYtqjMg2IWRWtvDp2B1nT9fh+BAm
X-Google-Smtp-Source: APXvYqwbRIS1nOT3akSmeiahrtWV6Vhnf5HADn76ahSykiHw0PQhhrnZxvCeQuOslTNAW6uM6/VZsg==
X-Received: by 2002:adf:a749:: with SMTP id e9mr17267483wrd.64.1559577832310;
        Mon, 03 Jun 2019 09:03:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a125sm12198659wmf.42.2019.06.03.09.03.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 09:03:50 -0700 (PDT)
Date:   Mon, 03 Jun 2019 09:03:50 -0700 (PDT)
X-Google-Original-Date: Mon, 03 Jun 2019 16:03:34 GMT
Message-Id: <d0dc154a27c80a8113ff47eb60a6b6f98fbeec91.1559577826.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v3.git.gitgitgadget@gmail.com>
References: <pull.184.v2.git.gitgitgadget@gmail.com>
        <pull.184.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 02/14] commit-graph: prepare for commit-graph chains
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

To prepare for a chain of commit-graph files, augment the
commit_graph struct to point to a base commit_graph. As we load
commits from the graph, we may actually want to read from a base
file according to the graph position.

The "graph position" of a commit is given by concatenating the
lexicographic commit orders from each of the commit-graph files in
the chain. This means that we must distinguish two values:

 * lexicographic index : the position within the lexicographic
   order in a single commit-graph file.

 * graph position: the posiiton within the concatenated order
   of multiple commit-graph files

Given the lexicographic index of a commit in a graph, we can
compute the graph position by adding the number of commits in
the lower-level graphs. To find the lexicographic index of
a commit, we subtract the number of commits in lower-level graphs.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 74 ++++++++++++++++++++++++++++++++++++++++++++------
 commit-graph.h |  3 ++
 2 files changed, 69 insertions(+), 8 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 7723156964..3afedcd7f5 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -371,6 +371,25 @@ static int bsearch_graph(struct commit_graph *g, struct object_id *oid, uint32_t
 			    g->chunk_oid_lookup, g->hash_len, pos);
 }
 
+static void load_oid_from_graph(struct commit_graph *g, int pos, struct object_id *oid)
+{
+	uint32_t lex_index;
+
+	if (!g)
+		BUG("NULL commit-graph");
+
+	while (pos < g->num_commits_in_base)
+		g = g->base_graph;
+
+	if (pos >= g->num_commits + g->num_commits_in_base)
+		BUG("position %d is beyond the scope of this commit-graph (%d local + %d base commits)",
+		    pos, g->num_commits, g->num_commits_in_base);
+
+	lex_index = pos - g->num_commits_in_base;
+
+	hashcpy(oid->hash, g->chunk_oid_lookup + g->hash_len * lex_index);
+}
+
 static struct commit_list **insert_parent_or_die(struct repository *r,
 						 struct commit_graph *g,
 						 uint64_t pos,
@@ -379,10 +398,10 @@ static struct commit_list **insert_parent_or_die(struct repository *r,
 	struct commit *c;
 	struct object_id oid;
 
-	if (pos >= g->num_commits)
+	if (pos >= g->num_commits + g->num_commits_in_base)
 		die("invalid parent position %"PRIu64, pos);
 
-	hashcpy(oid.hash, g->chunk_oid_lookup + g->hash_len * pos);
+	load_oid_from_graph(g, pos, &oid);
 	c = lookup_commit(r, &oid);
 	if (!c)
 		die(_("could not find commit %s"), oid_to_hex(&oid));
@@ -392,7 +411,14 @@ static struct commit_list **insert_parent_or_die(struct repository *r,
 
 static void fill_commit_graph_info(struct commit *item, struct commit_graph *g, uint32_t pos)
 {
-	const unsigned char *commit_data = g->chunk_commit_data + GRAPH_DATA_WIDTH * pos;
+	const unsigned char *commit_data;
+	uint32_t lex_index;
+
+	while (pos < g->num_commits_in_base)
+		g = g->base_graph;
+
+	lex_index = pos - g->num_commits_in_base;
+	commit_data = g->chunk_commit_data + GRAPH_DATA_WIDTH * lex_index;
 	item->graph_pos = pos;
 	item->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
 }
@@ -405,10 +431,26 @@ static int fill_commit_in_graph(struct repository *r,
 	uint32_t *parent_data_ptr;
 	uint64_t date_low, date_high;
 	struct commit_list **pptr;
-	const unsigned char *commit_data = g->chunk_commit_data + (g->hash_len + 16) * pos;
+	const unsigned char *commit_data;
+	uint32_t lex_index;
 
-	item->object.parsed = 1;
+	while (pos < g->num_commits_in_base)
+		g = g->base_graph;
+
+	if (pos >= g->num_commits + g->num_commits_in_base)
+		BUG("position %d is beyond the scope of this commit-graph (%d local + %d base commits)",
+		    pos, g->num_commits, g->num_commits_in_base);
+
+	/*
+	 * Store the "full" position, but then use the
+	 * "local" position for the rest of the calculation.
+	 */
 	item->graph_pos = pos;
+	lex_index = pos - g->num_commits_in_base;
+
+	commit_data = g->chunk_commit_data + (g->hash_len + 16) * lex_index;
+
+	item->object.parsed = 1;
 
 	item->maybe_tree = NULL;
 
@@ -452,7 +494,18 @@ static int find_commit_in_graph(struct commit *item, struct commit_graph *g, uin
 		*pos = item->graph_pos;
 		return 1;
 	} else {
-		return bsearch_graph(g, &(item->object.oid), pos);
+		struct commit_graph *cur_g = g;
+		uint32_t lex_index;
+
+		while (cur_g && !bsearch_graph(cur_g, &(item->object.oid), &lex_index))
+			cur_g = cur_g->base_graph;
+
+		if (cur_g) {
+			*pos = lex_index + cur_g->num_commits_in_base;
+			return 1;
+		}
+
+		return 0;
 	}
 }
 
@@ -492,8 +545,13 @@ static struct tree *load_tree_for_commit(struct repository *r,
 					 struct commit *c)
 {
 	struct object_id oid;
-	const unsigned char *commit_data = g->chunk_commit_data +
-					   GRAPH_DATA_WIDTH * (c->graph_pos);
+	const unsigned char *commit_data;
+
+	while (c->graph_pos < g->num_commits_in_base)
+		g = g->base_graph;
+
+	commit_data = g->chunk_commit_data +
+			GRAPH_DATA_WIDTH * (c->graph_pos - g->num_commits_in_base);
 
 	hashcpy(oid.hash, commit_data);
 	c->maybe_tree = lookup_tree(r, &oid);
diff --git a/commit-graph.h b/commit-graph.h
index 70f4caf0c7..f9fe32ebe3 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -48,6 +48,9 @@ struct commit_graph {
 	uint32_t num_commits;
 	struct object_id oid;
 
+	uint32_t num_commits_in_base;
+	struct commit_graph *base_graph;
+
 	const uint32_t *chunk_oid_fanout;
 	const unsigned char *chunk_oid_lookup;
 	const unsigned char *chunk_commit_data;
-- 
gitgitgadget

