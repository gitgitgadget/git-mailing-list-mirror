Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 426F51F453
	for <e@80x24.org>; Thu, 21 Feb 2019 22:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfBUWiY (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 17:38:24 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39224 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfBUWiW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 17:38:22 -0500
Received: by mail-wr1-f66.google.com with SMTP id l5so250591wrw.6
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 14:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T0sJfRS9dXupnKNHFtKtzRpAKFcoZwVmcCxoE7dzQ6c=;
        b=LjXrK0SV7UJjmLcbpA/1xJ7c75okC2/EjY+OJPF/LhS6rrUWdolKsCO8XSCc36PPr6
         y9tsiUmxeHAW3R9rXah62AxLJzMuNkqh1UklCnOpN82FZ3XX9VT1pkX8qW7h2hxU1d67
         oofBnI/ndknY23Ny9j5mzi2qeYHYPoKkOR05fdsJDhQGoy1ErzqCS6wRfCMz+w7Gm+e3
         zyw55E2zEg53SxF7eJryo7OZK8aANEzJeZhXm8Yd/dmQDSocrslpCvaxR/gAyGEkUnTa
         NFM1tQyewzocd0cY9mzmK9iaIxA1rQOA1c050kgY6A3CC7HXY8EYtY26f9BdhiTx8048
         zaSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T0sJfRS9dXupnKNHFtKtzRpAKFcoZwVmcCxoE7dzQ6c=;
        b=glH/xUw9g5V5kP700sMWeomq/3TND1uA9j+GCoqR1hfqORMJRR8Nk1TLUW9CoRSpCk
         mnuf98Zh9jpfD8XRJoYtcxOsitdPnxEMOw/XpheT8zHAvt8JWraksqeIzFlwBb+79wLq
         O3E890jPUpugP/X2pxYk0VNppoKkv/Rt+b12A77UdEQ4PzWDD71oP67LvqIagTw4VDiU
         cnjlpoLH6us+v3t0WDgxoEzyhbI0Ya3mjVTjKAaZYC7n2d0SLE/5l7tXDkC06Qha8rty
         ZBm8OhWjqyjC1Ri1v9IiZEQsZ9nG5ukWHcc+S8oyM/Y9ODB5u31iDW21TBFq3pz627qw
         sr2A==
X-Gm-Message-State: AHQUAuYJegq9BORKbIn6TkLBPbuvm9YqQ1Ypqoyd2gdYjx7iSkHfjXbC
        O/mDjr+eDiCBrYjRd6Wu24haiugi8cs=
X-Google-Smtp-Source: AHgI3IaWjFkVJiVQu8QkfC+sj3Z79oSeTZ8bfoGRmPFPCJhX3pVtelCL+7jvpphFY7QwEqa6RvtLlA==
X-Received: by 2002:adf:8224:: with SMTP id 33mr554992wrb.264.1550788699155;
        Thu, 21 Feb 2019 14:38:19 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v196sm110803wmf.15.2019.02.21.14.38.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 21 Feb 2019 14:38:18 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 8/8] commit-graph: improve & i18n error messages
Date:   Thu, 21 Feb 2019 23:37:53 +0100
Message-Id: <20190221223753.20070-9-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e
In-Reply-To: <20190221223753.20070-1-avarab@gmail.com>
References: <20190221223753.20070-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the error emitted when a commit-graph file is corrupt so that
we actually mention the commit-graph, e.g. change errors like:

    error: improper chunk offset 0000000000385e0c

To:

    error: commit-graph improper chunk offset 0000000000385e0c

As discussed in the commits leading up to this one the commit-graph
machinery is now used by common commands like "status". If the graph
was corrupt we'd often emit some error that gave no indication what
was wrong. Now some of them are still cryptic, but they'll at least
mention "commit-graph" to give the user a hint as to where to look.

While I'm at it mark some of the strings that hadn't been marked for
translation. It's clear from the commit history and the code that this
was merely forgotten at the time, and wasn't intentional.p5

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 commit-graph.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 6b3ade9496..4cf7d6c294 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -150,21 +150,21 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 
 	graph_signature = get_be32(data);
 	if (graph_signature != GRAPH_SIGNATURE) {
-		error(_("graph signature %X does not match signature %X"),
+		error(_("commit-graph signature %X does not match signature %X"),
 		      graph_signature, GRAPH_SIGNATURE);
 		return NULL;
 	}
 
 	graph_version = *(unsigned char*)(data + 4);
 	if (graph_version != GRAPH_VERSION) {
-		error(_("graph version %X does not match version %X"),
+		error(_("commit-graph version %X does not match version %X"),
 		      graph_version, GRAPH_VERSION);
 		return NULL;
 	}
 
 	hash_version = *(unsigned char*)(data + 5);
 	if (hash_version != oid_version()) {
-		error(_("hash version %X does not match version %X"),
+		error(_("commit-graph hash version %X does not match version %X"),
 		      hash_version, oid_version());
 		return NULL;
 	}
@@ -187,7 +187,7 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 
 		if (data + graph_size - chunk_lookup <
 		    GRAPH_CHUNKLOOKUP_WIDTH) {
-			error(_("chunk lookup table entry missing; graph file may be incomplete"));
+			error(_("commit-graph chunk lookup table entry missing; file may be incomplete"));
 			free(graph);
 			return NULL;
 		}
@@ -198,7 +198,7 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 		chunk_lookup += GRAPH_CHUNKLOOKUP_WIDTH;
 
 		if (chunk_offset > graph_size - the_hash_algo->rawsz) {
-			error(_("improper chunk offset %08x%08x"), (uint32_t)(chunk_offset >> 32),
+			error(_("commit-graph improper chunk offset %08x%08x"), (uint32_t)(chunk_offset >> 32),
 			      (uint32_t)chunk_offset);
 			free(graph);
 			return NULL;
@@ -235,7 +235,7 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 		}
 
 		if (chunk_repeated) {
-			error(_("chunk id %08x appears multiple times"), chunk_id);
+			error(_("commit-graph chunk id %08x appears multiple times"), chunk_id);
 			free(graph);
 			return NULL;
 		}
@@ -1162,7 +1162,7 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
 		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
 
 		if (i && oidcmp(&prev_oid, &cur_oid) >= 0)
-			graph_report("commit-graph has incorrect OID order: %s then %s",
+			graph_report(_("commit-graph has incorrect OID order: %s then %s"),
 				     oid_to_hex(&prev_oid),
 				     oid_to_hex(&cur_oid));
 
@@ -1172,14 +1172,14 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
 			uint32_t fanout_value = get_be32(g->chunk_oid_fanout + cur_fanout_pos);
 
 			if (i != fanout_value)
-				graph_report("commit-graph has incorrect fanout value: fanout[%d] = %u != %u",
+				graph_report(_("commit-graph has incorrect fanout value: fanout[%d] = %u != %u"),
 					     cur_fanout_pos, fanout_value, i);
 			cur_fanout_pos++;
 		}
 
 		graph_commit = lookup_commit(r, &cur_oid);
 		if (!parse_commit_in_graph_one(r, g, graph_commit))
-			graph_report("failed to parse %s from commit-graph",
+			graph_report(_("failed to parse commit %s from commit-graph"),
 				     oid_to_hex(&cur_oid));
 	}
 
@@ -1187,7 +1187,7 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
 		uint32_t fanout_value = get_be32(g->chunk_oid_fanout + cur_fanout_pos);
 
 		if (g->num_commits != fanout_value)
-			graph_report("commit-graph has incorrect fanout value: fanout[%d] = %u != %u",
+			graph_report(_("commit-graph has incorrect fanout value: fanout[%d] = %u != %u"),
 				     cur_fanout_pos, fanout_value, i);
 
 		cur_fanout_pos++;
@@ -1209,14 +1209,14 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
 		graph_commit = lookup_commit(r, &cur_oid);
 		odb_commit = (struct commit *)create_object(r, cur_oid.hash, alloc_commit_node(r));
 		if (parse_commit_internal(odb_commit, 0, 0)) {
-			graph_report("failed to parse %s from object database",
+			graph_report(_("failed to parse commit %s from object database for commit-graph"),
 				     oid_to_hex(&cur_oid));
 			continue;
 		}
 
 		if (!oideq(&get_commit_tree_in_graph_one(r, g, graph_commit)->object.oid,
 			   get_commit_tree_oid(odb_commit)))
-			graph_report("root tree OID for commit %s in commit-graph is %s != %s",
+			graph_report(_("root tree OID for commit %s in commit-graph is %s != %s"),
 				     oid_to_hex(&cur_oid),
 				     oid_to_hex(get_commit_tree_oid(graph_commit)),
 				     oid_to_hex(get_commit_tree_oid(odb_commit)));
@@ -1226,13 +1226,13 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
 
 		while (graph_parents) {
 			if (odb_parents == NULL) {
-				graph_report("commit-graph parent list for commit %s is too long",
+				graph_report(_("commit-graph parent list for commit %s is too long"),
 					     oid_to_hex(&cur_oid));
 				break;
 			}
 
 			if (!oideq(&graph_parents->item->object.oid, &odb_parents->item->object.oid))
-				graph_report("commit-graph parent for %s is %s != %s",
+				graph_report(_("commit-graph parent for %s is %s != %s"),
 					     oid_to_hex(&cur_oid),
 					     oid_to_hex(&graph_parents->item->object.oid),
 					     oid_to_hex(&odb_parents->item->object.oid));
@@ -1245,16 +1245,16 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
 		}
 
 		if (odb_parents != NULL)
-			graph_report("commit-graph parent list for commit %s terminates early",
+			graph_report(_("commit-graph parent list for commit %s terminates early"),
 				     oid_to_hex(&cur_oid));
 
 		if (!graph_commit->generation) {
 			if (generation_zero == GENERATION_NUMBER_EXISTS)
-				graph_report("commit-graph has generation number zero for commit %s, but non-zero elsewhere",
+				graph_report(_("commit-graph has generation number zero for commit %s, but non-zero elsewhere"),
 					     oid_to_hex(&cur_oid));
 			generation_zero = GENERATION_ZERO_EXISTS;
 		} else if (generation_zero == GENERATION_ZERO_EXISTS)
-			graph_report("commit-graph has non-zero generation number for commit %s, but zero elsewhere",
+			graph_report(_("commit-graph has non-zero generation number for commit %s, but zero elsewhere"),
 				     oid_to_hex(&cur_oid));
 
 		if (generation_zero == GENERATION_ZERO_EXISTS)
@@ -1269,13 +1269,13 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
 			max_generation--;
 
 		if (graph_commit->generation != max_generation + 1)
-			graph_report("commit-graph generation for commit %s is %u != %u",
+			graph_report(_("commit-graph generation for commit %s is %u != %u"),
 				     oid_to_hex(&cur_oid),
 				     graph_commit->generation,
 				     max_generation + 1);
 
 		if (graph_commit->date != odb_commit->date)
-			graph_report("commit date for commit %s in commit-graph is %"PRItime" != %"PRItime,
+			graph_report(_("commit date for commit %s in commit-graph is %"PRItime" != %"PRItime),
 				     oid_to_hex(&cur_oid),
 				     graph_commit->date,
 				     odb_commit->date);
-- 
2.21.0.rc0.258.g878e2cd30e

