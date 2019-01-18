Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D4CF1F453
	for <e@80x24.org>; Fri, 18 Jan 2019 17:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbfARRGF (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 12:06:05 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34950 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727489AbfARRGE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 12:06:04 -0500
Received: by mail-wr1-f65.google.com with SMTP id 96so15955965wrb.2
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 09:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MDugyeIYzQuvlW0r26YogAvc0XwXU8F4RoTwXUxka2g=;
        b=X/dPyBEuKn8981tnSG2GpfM/HaTRQsZhyHSTkcy3nj5ZS/GRH/8RjcK7A0IXieju3F
         P2+ckhb5Hg+2rE6kXt7eITQB5WhQrvubt2LgvMQp4HicjOBih2pJe+nvpXlBLDGtdf2F
         zcvnidy2WgnJcg+SwbkDwy7ZnZPV0maWQM/aQxEI7WwWUmzGUYKgbkqdsDK3NBFhI1Vk
         M80SWJy/Sqq5880ArRwEx3Xm2RK3Nc429RL7kslA+Xl8czfU7rFMtURB4qLKmItOoZKA
         FJmN5RqSkNj0iLhrtXoso5RMxz+0FMpX1VsGBrWmZP5u/VdwMhg1DHMMmHouBEWL7VBr
         cbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MDugyeIYzQuvlW0r26YogAvc0XwXU8F4RoTwXUxka2g=;
        b=qT6Jl/O0iLyI9U+HuPG7TiFzRQ6ZkmAjXQTYXGZ1TZ6RT0fNi2DvLbdgrW6o3P/mMK
         K2SNuFa2PxZHbwJenHXQXLiK/muzjV3xU+qIsdsIQ+zQ+j0mW3j+l6teWPZ+bcbMWd1X
         ce0i4tenwyD42g3npqE4V0w/v8ZTJvN94lUOPvC8WhxBC9yCaOhJ01tFDY6+F/Andy5A
         bKwuv1iqJb4hTlmvvFgJPmW5bomXCXNdy5R0QpO7Qab0mju/ZSTyokecjNDc+kfJMMwY
         kzGqAjdbCLybpDQQiOG7qoS3x3n+Tip2r2ArP+923YILIFCWCqktnfwK5uFBU2LANcHO
         UXvg==
X-Gm-Message-State: AJcUukecnSNqAWRucYVWer9mnZ99peP9SjyxqP3FsJeetWiKl7PgTaIr
        xfPDeIjYKREWsOLclL6vi3k=
X-Google-Smtp-Source: ALg8bN4xsMjaZNsjjq3ZiisrK/Wl9QHnfG+qRpCOfFPqGfHUymFGccmb27Smq33MNg8vCQDEGOKydw==
X-Received: by 2002:a5d:6710:: with SMTP id o16mr17853825wru.152.1547831161744;
        Fri, 18 Jan 2019 09:06:01 -0800 (PST)
Received: from localhost.localdomain (x4dbd9ead.dyn.telefonica.de. [77.189.158.173])
        by smtp.gmail.com with ESMTPSA id x186sm50476023wmg.41.2019.01.18.09.06.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Jan 2019 09:06:01 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 1/2] commit-graph: rename "large edges" to "extra edges"
Date:   Fri, 18 Jan 2019 18:05:48 +0100
Message-Id: <20190118170549.30403-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.20.1.499.gf60de1223c
In-Reply-To: <20190118170549.30403-1-szeder.dev@gmail.com>
References: <a82a2bec-07f5-ccd2-85ab-b9efd406929e@gmail.com>
 <20190118170549.30403-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The optional 'Large Edge List' chunk of the commit graph file stores
parent information for commits with more than two parents, and the
names of most of the macros, variables, struct fields, and functions
related to this chunk contain the term "large edges", e.g.
write_graph_chunk_large_edges().  However, it's not a really great
term, as the edges to the second and subsequent parents stored in this
chunk are not any larger than the edges to the first and second
parents stored in the "main" 'Commit Data' chunk.  It's the number of
edges, IOW number of parents, that is larger compared to non-merge and
"regular" two-parent merge commits.  And indeed, two functions in
'commit-graph.c' have a local variable called 'num_extra_edges' that
refer to the same thing, and this "extra edges" term is much better at
describing these edges.

So let's rename all these references to "large edges" in macro,
variable, function, etc. names to "extra edges".  There is a
GRAPH_OCTOPUS_EDGES_NEEDED macro as well; for the sake of consistency
rename it to GRAPH_EXTRA_EDGES_NEEDED.

We can do so safely without causing any incompatibility issues,
because the term "large edges" doesn't come up in the file format
itself in any form (the chunk's magic is {'E', 'D', 'G', 'E'}, there
is no 'L' in there), but only in the specification text.  The string
"large edges", however, does come up in the output of 'git
commit-graph read' and in tests looking at its input, but that command
is explicitly documented as debugging aid, so we can change its output
and the affected tests safely.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 .../technical/commit-graph-format.txt         |  4 ++--
 builtin/commit-graph.c                        |  4 ++--
 commit-graph.c                                | 24 +++++++++----------
 commit-graph.h                                |  2 +-
 t/t5318-commit-graph.sh                       | 14 +++++------
 5 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/Documentation/technical/commit-graph-format.txt b/Documentation/technical/commit-graph-format.txt
index cc0474ba3e..16452a0504 100644
--- a/Documentation/technical/commit-graph-format.txt
+++ b/Documentation/technical/commit-graph-format.txt
@@ -76,7 +76,7 @@ CHUNK DATA:
       of the ith commit. Stores value 0x7000000 if no parent in that
       position. If there are more than two parents, the second value
       has its most-significant bit on and the other bits store an array
-      position into the Large Edge List chunk.
+      position into the Extra Edge List chunk.
     * The next 8 bytes store the generation number of the commit and
       the commit time in seconds since EPOCH. The generation number
       uses the higher 30 bits of the first 4 bytes, while the commit
@@ -84,7 +84,7 @@ CHUNK DATA:
       2 bits of the lowest byte, storing the 33rd and 34th bit of the
       commit time.
 
-  Large Edge List (ID: {'E', 'D', 'G', 'E'}) [Optional]
+  Extra Edge List (ID: {'E', 'D', 'G', 'E'}) [Optional]
       This list of 4-byte values store the second through nth parents for
       all octopus merges. The second parent value in the commit data stores
       an array position within this list along with the most-significant bit
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index c02a3f1221..4ae502754c 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -110,8 +110,8 @@ static int graph_read(int argc, const char **argv)
 		printf(" oid_lookup");
 	if (graph->chunk_commit_data)
 		printf(" commit_metadata");
-	if (graph->chunk_large_edges)
-		printf(" large_edges");
+	if (graph->chunk_extra_edges)
+		printf(" extra_edges");
 	printf("\n");
 
 	UNLEAK(graph);
diff --git a/commit-graph.c b/commit-graph.c
index 40c855f185..544d6b8b4a 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -21,7 +21,7 @@
 #define GRAPH_CHUNKID_OIDFANOUT 0x4f494446 /* "OIDF" */
 #define GRAPH_CHUNKID_OIDLOOKUP 0x4f49444c /* "OIDL" */
 #define GRAPH_CHUNKID_DATA 0x43444154 /* "CDAT" */
-#define GRAPH_CHUNKID_LARGEEDGES 0x45444745 /* "EDGE" */
+#define GRAPH_CHUNKID_EXTRAEDGES 0x45444745 /* "EDGE" */
 
 #define GRAPH_DATA_WIDTH 36
 
@@ -33,7 +33,7 @@
 #define GRAPH_OID_VERSION GRAPH_OID_VERSION_SHA1
 #define GRAPH_OID_LEN GRAPH_OID_LEN_SHA1
 
-#define GRAPH_OCTOPUS_EDGES_NEEDED 0x80000000
+#define GRAPH_EXTRA_EDGES_NEEDED 0x80000000
 #define GRAPH_PARENT_MISSING 0x7fffffff
 #define GRAPH_EDGE_LAST_MASK 0x7fffffff
 #define GRAPH_PARENT_NONE 0x70000000
@@ -177,11 +177,11 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
 				graph->chunk_commit_data = data + chunk_offset;
 			break;
 
-		case GRAPH_CHUNKID_LARGEEDGES:
-			if (graph->chunk_large_edges)
+		case GRAPH_CHUNKID_EXTRAEDGES:
+			if (graph->chunk_extra_edges)
 				chunk_repeated = 1;
 			else
-				graph->chunk_large_edges = data + chunk_offset;
+				graph->chunk_extra_edges = data + chunk_offset;
 			break;
 		}
 
@@ -346,12 +346,12 @@ static int fill_commit_in_graph(struct commit *item, struct commit_graph *g, uin
 	edge_value = get_be32(commit_data + g->hash_len + 4);
 	if (edge_value == GRAPH_PARENT_NONE)
 		return 1;
-	if (!(edge_value & GRAPH_OCTOPUS_EDGES_NEEDED)) {
+	if (!(edge_value & GRAPH_EXTRA_EDGES_NEEDED)) {
 		pptr = insert_parent_or_die(g, edge_value, pptr);
 		return 1;
 	}
 
-	parent_data_ptr = (uint32_t*)(g->chunk_large_edges +
+	parent_data_ptr = (uint32_t*)(g->chunk_extra_edges +
 			  4 * (uint64_t)(edge_value & GRAPH_EDGE_LAST_MASK));
 	do {
 		edge_value = get_be32(parent_data_ptr);
@@ -507,7 +507,7 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
 		if (!parent)
 			edge_value = GRAPH_PARENT_NONE;
 		else if (parent->next)
-			edge_value = GRAPH_OCTOPUS_EDGES_NEEDED | num_extra_edges;
+			edge_value = GRAPH_EXTRA_EDGES_NEEDED | num_extra_edges;
 		else {
 			edge_value = sha1_pos(parent->item->object.oid.hash,
 					      commits,
@@ -519,7 +519,7 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
 
 		hashwrite_be32(f, edge_value);
 
-		if (edge_value & GRAPH_OCTOPUS_EDGES_NEEDED) {
+		if (edge_value & GRAPH_EXTRA_EDGES_NEEDED) {
 			do {
 				num_extra_edges++;
 				parent = parent->next;
@@ -540,7 +540,7 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
 	}
 }
 
-static void write_graph_chunk_large_edges(struct hashfile *f,
+static void write_graph_chunk_extra_edges(struct hashfile *f,
 					  struct commit **commits,
 					  int nr_commits)
 {
@@ -917,7 +917,7 @@ void write_commit_graph(const char *obj_dir,
 	chunk_ids[1] = GRAPH_CHUNKID_OIDLOOKUP;
 	chunk_ids[2] = GRAPH_CHUNKID_DATA;
 	if (num_extra_edges)
-		chunk_ids[3] = GRAPH_CHUNKID_LARGEEDGES;
+		chunk_ids[3] = GRAPH_CHUNKID_EXTRAEDGES;
 	else
 		chunk_ids[3] = 0;
 	chunk_ids[4] = 0;
@@ -940,7 +940,7 @@ void write_commit_graph(const char *obj_dir,
 	write_graph_chunk_fanout(f, commits.list, commits.nr);
 	write_graph_chunk_oids(f, GRAPH_OID_LEN, commits.list, commits.nr);
 	write_graph_chunk_data(f, GRAPH_OID_LEN, commits.list, commits.nr);
-	write_graph_chunk_large_edges(f, commits.list, commits.nr);
+	write_graph_chunk_extra_edges(f, commits.list, commits.nr);
 
 	close_commit_graph(the_repository);
 	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
diff --git a/commit-graph.h b/commit-graph.h
index 9db40b4d3a..e6aff2c2e1 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -49,7 +49,7 @@ struct commit_graph {
 	const uint32_t *chunk_oid_fanout;
 	const unsigned char *chunk_oid_lookup;
 	const unsigned char *chunk_commit_data;
-	const unsigned char *chunk_large_edges;
+	const unsigned char *chunk_extra_edges;
 };
 
 struct commit_graph *load_commit_graph_one(const char *graph_file);
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 5fe21db99f..f4deb13b1d 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -122,7 +122,7 @@ test_expect_success 'write graph with merges' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git commit-graph write &&
 	test_path_is_file $objdir/info/commit-graph &&
-	graph_read_expect "10" "large_edges"
+	graph_read_expect "10" "extra_edges"
 '
 
 graph_git_behavior 'merge 1 vs 2' full merge/1 merge/2
@@ -157,7 +157,7 @@ test_expect_success 'write graph with new commit' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git commit-graph write &&
 	test_path_is_file $objdir/info/commit-graph &&
-	graph_read_expect "11" "large_edges"
+	graph_read_expect "11" "extra_edges"
 '
 
 graph_git_behavior 'full graph, commit 8 vs merge 1' full commits/8 merge/1
@@ -167,7 +167,7 @@ test_expect_success 'write graph with nothing new' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git commit-graph write &&
 	test_path_is_file $objdir/info/commit-graph &&
-	graph_read_expect "11" "large_edges"
+	graph_read_expect "11" "extra_edges"
 '
 
 graph_git_behavior 'cleared graph, commit 8 vs merge 1' full commits/8 merge/1
@@ -177,7 +177,7 @@ test_expect_success 'build graph from latest pack with closure' '
 	cd "$TRASH_DIRECTORY/full" &&
 	cat new-idx | git commit-graph write --stdin-packs &&
 	test_path_is_file $objdir/info/commit-graph &&
-	graph_read_expect "9" "large_edges"
+	graph_read_expect "9" "extra_edges"
 '
 
 graph_git_behavior 'graph from pack, commit 8 vs merge 1' full commits/8 merge/1
@@ -200,7 +200,7 @@ test_expect_success 'build graph from commits with append' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git rev-parse merge/3 | git commit-graph write --stdin-commits --append &&
 	test_path_is_file $objdir/info/commit-graph &&
-	graph_read_expect "10" "large_edges"
+	graph_read_expect "10" "extra_edges"
 '
 
 graph_git_behavior 'append graph, commit 8 vs merge 1' full commits/8 merge/1
@@ -210,7 +210,7 @@ test_expect_success 'build graph using --reachable' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git commit-graph write --reachable &&
 	test_path_is_file $objdir/info/commit-graph &&
-	graph_read_expect "11" "large_edges"
+	graph_read_expect "11" "extra_edges"
 '
 
 graph_git_behavior 'append graph, commit 8 vs merge 1' full commits/8 merge/1
@@ -231,7 +231,7 @@ test_expect_success 'write graph in bare repo' '
 	cd "$TRASH_DIRECTORY/bare" &&
 	git commit-graph write &&
 	test_path_is_file $baredir/info/commit-graph &&
-	graph_read_expect "11" "large_edges"
+	graph_read_expect "11" "extra_edges"
 '
 
 graph_git_behavior 'bare repo with graph, commit 8 vs merge 1' bare commits/8 merge/1
-- 
2.20.1.499.gf60de1223c

