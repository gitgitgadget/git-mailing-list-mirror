Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE52E40DFA3
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 00:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774656685; cv=none; b=JQjq28qWKsnr2qzQ9Sen+LOJuReXP9TjFfRpLKeIafFhUJA1blZNwIAWddzqg9/BMC5IlIB3ENAEkS89VGgtc7rChibkoHUSSVbkLihFAbfrtA1l0qwMaIjLXOmw4xf3ZO+ctpZvyOm1F8dshUH+Mes/4M97Tq8o3s01emrprjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774656685; c=relaxed/simple;
	bh=LnCQrmwGVCjV4hZoDobZBG2coono/JIpdFpnrS3kjt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l2DR2HDdF6CSCPSEuYIGzv9lNa5Rrxm1pnzFGZXXfdu6jeObv9VoWfxWoc0C8Kc3JiMKpKbQotap1zyut0A6WK+CkE18OGQJE7BnrG79quF6tnDhi8Gd8x845EmXXWwg/XyWVR8FKX6TP420jeKhRlKLYe19UqOwYrVoK52IbWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oeWTUhLI; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oeWTUhLI"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48538c5956bso25893085e9.0
        for <git@vger.kernel.org>; Fri, 27 Mar 2026 17:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774656682; x=1775261482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9uLPWB2fRInSDv8wOZ9EquF8uZ8p4NssAFeGq6NuEQg=;
        b=oeWTUhLIzMYb38k2hb6G7JiUvFE5LtOIMIGwO57hwzW+qEBygSDfMfFcYFVexKCdVC
         1jFrUbdMMliQOgJ+OWNjB8gOaDnEFRjxY+rV1eba1ht/2eLpPneTppVexKkfEZtlM8dz
         NH5pSMj4YpBRMDO/ZCjnqQ6wu2/HWZfU46hdA1+eoN/RsTDaGjbMeAcbtEbj9hBFO1xk
         v+Y1gV0eTxABt6Kqc0XfO1avvtDsYu0HqwuqaA3/M9CVaBuXhI8ky0X8li/crNdCdhMD
         Ir+2V6V37MTckNfCSDhNDV6KzA5hACyA5MNgELlkDlPJQVAmqIBUNj9TFvv6SgrzqKpc
         2XsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774656682; x=1775261482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9uLPWB2fRInSDv8wOZ9EquF8uZ8p4NssAFeGq6NuEQg=;
        b=Ry4USzvYK5q1AQRnKnBfzYLIVSeXglEo0DHJcDcwSlyCqUAdEYjjmc/sEu/bMN8PGg
         UCOTgIH67Juf3PoGy/yM332VlVLVzXaUIpVCYQe6fEaTOMljBXUiC4+WS7Psq0EHl0+t
         KxW5JWMgypPHwb8fUODeHjoMOBZ3joXAOe2hdFG/jIBdUq/TlrwfcYaeHidweQHKpY5U
         MbTHNCLNYcLrLkNlZhXi4QrMybwp1uwOjjhqcoH6n23Pj0DGf8UBdQqAqZR289eeDY3H
         Mg1uIJWatsd1y+M1CIwbKCMKxn6uZ6mnjsICIzrWJ42H8Fw5quk4qJfQtbw3TsZ6Svh1
         M+7g==
X-Gm-Message-State: AOJu0Yz4AC0fdls0R5t6Jgti9YO/6BM16AsTElTRjw2Vrh6zJEsigOkw
	7kHNj43od3tW9W+s7DqEIyOw4+QNiTUgsxAGL0BIDhq4lTTOJZSESlIoU3pRgxlOhxY=
X-Gm-Gg: ATEYQzzfZEaT+oiS81ZOTn/8OCAJuMZi6JvYZyXvh2gkAL4YS8afexU/TJqTCirx4XC
	aVJhbdzFuQXF1c1hDBzElm0/thuo9zh9uPi5jYkF0D8enRpgUagjF2xnLpgaUMWg62OSVGIPV/l
	FKXQOxARj2VqWNOVdOrKrTlfgWZOOzGfinUZkohg40/LzHFhdKyzeb7PSUSG0bLOp9nDI29Gzzv
	N6VWfsJVjtCexOvlfgrbYsAdgBuzxbrUWBoxmSutYu9U3MxW2XB0CAQWnOKtMlFvVyxocNv521W
	IKbtvhNMVGo0gyy5ZwnoimEK82ET4KI5S9d7+ZOrEAfi3NYoeSb3t9VCWCxjsXQQ5U3umqNtA3C
	1icGFAbP9SzsPny/gLKnWQwfReEqrU3yI5QbRyrbR90elYS9TudQDF6CehVWKgdtTb1U6FhL8eY
	GBvYzWb8FmGdkNFgEFkQY3YKDNBq/Qy8I/MMGVhdIhtN09rPYyWY/3pR3y8CEDN4LXBK6wAxH8P
	/415DQpuIO66LLBs8nG1CrhlkquVIRrwwRsfrN6rPz/AQSPwBiS2OQpgks=
X-Received: by 2002:a05:600d:17:b0:486:faa8:9e4 with SMTP id 5b1f17b1804b1-4872911c031mr48938455e9.12.1774656682047;
        Fri, 27 Mar 2026 17:11:22 -0700 (PDT)
Received: from farblopa.localdomain ([84.126.0.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722d2366dsm116147635e9.10.2026.03.27.17.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 17:11:21 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com,
	chandrapratap3519@gmail.com,
	gitster@pobox.com,
	j6t@kdbg.org,
	szeder.dev@gmail.com,
	Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [GSoC PATCH v6 2/3] graph: add --graph-lane-limit option
Date: Sat, 28 Mar 2026 01:11:12 +0100
Message-ID: <20260328001113.1275291-3-pabloosabaterr@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260328001113.1275291-1-pabloosabaterr@gmail.com>
References: <20260325174401.217577-1-pabloosabaterr@gmail.com>
 <20260328001113.1275291-1-pabloosabaterr@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the hard-coded lane limit with a user-facing
option '--graph-lane-limit=<n>'. It caps the number of
visible lanes to n. This option requires '--graph', without
it, limiting the graph has no meaning, in this case error out.

Zero and negative values are valid inputs but silently
ignored treating them as "no limit", the same as not using
the option. This follows what '--max-parents' does with
negative values.

The default is 0, same as not being used.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 Documentation/rev-list-options.adoc |   5 +
 graph.c                             |  53 +++++-----
 revision.c                          |   6 ++
 revision.h                          |   1 +
 t/t4215-log-skewed-merges.sh        | 144 ++++++++++++++++++++++++++++
 5 files changed, 186 insertions(+), 23 deletions(-)

diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
index 2d195a1474..1b6ea89a63 100644
--- a/Documentation/rev-list-options.adoc
+++ b/Documentation/rev-list-options.adoc
@@ -1259,6 +1259,11 @@ This implies the `--topo-order` option by default, but the
 	in between them in that case. If _<barrier>_ is specified, it
 	is the string that will be shown instead of the default one.
 
+`--graph-lane-limit=<n>`::
+	When `--graph` is used, limit the number of graph lanes to be shown.
+	Lanes over the limit are not shown. By default it is set to 0 
+	(no limit), zero and negative values are ignored and treated as no limit.
+
 ifdef::git-rev-list[]
 `--count`::
 	Print a number stating how many commits would have been
diff --git a/graph.c b/graph.c
index 70458cf323..ee1f9e2d2d 100644
--- a/graph.c
+++ b/graph.c
@@ -82,8 +82,6 @@ static void graph_show_line_prefix(const struct diff_options *diffopt)
 static const char **column_colors;
 static unsigned short column_colors_max;
 
-static unsigned int max_lanes = 15;
-
 static void parse_graph_colors_config(struct strvec *colors, const char *string)
 {
 	const char *end, *start;
@@ -319,9 +317,13 @@ struct git_graph {
 	struct strbuf prefix_buf;
 };
 
-static inline int graph_needs_truncation(int lane)
+static inline int graph_needs_truncation(struct git_graph *graph, int lane)
 {
-	return lane >= max_lanes;
+	int max = graph->revs->graph_max_lanes;
+	/*
+	 * Ignore values <= 0, meaning no limit.
+	 */
+	return max > 0 && lane >= max;
 }
 
 static const char *diff_output_prefix_callback(struct diff_options *opt, void *data)
@@ -614,7 +616,7 @@ static void graph_update_columns(struct git_graph *graph)
 {
 	struct commit_list *parent;
 	int max_new_columns;
-	int i, seen_this, is_commit_in_columns, max;
+	int i, seen_this, is_commit_in_columns;
 
 	/*
 	 * Swap graph->columns with graph->new_columns
@@ -704,12 +706,17 @@ static void graph_update_columns(struct git_graph *graph)
 	}
 
 	/*
-	 * Cap to the hard-coded limit.
-	 * Allow commits from merges to align to the merged lane.
+	 *  If graph_max_lanes is set, cap the width
 	 */
-	max = max_lanes * 2 + 2;
-	if (graph->width > max)
-		graph->width = max;
+	if (graph->revs->graph_max_lanes > 0) {
+		/*
+		 * Width is column index while a lane is half that.
+		 * Allow commits from merges to align to the merged lane.
+		 */
+		int max_width = graph->revs->graph_max_lanes * 2 + 2;
+		if (graph->width > max_width)
+			graph->width = max_width;
+	}
 
 	/*
 	 * Shrink mapping_size to be the minimum necessary
@@ -861,7 +868,7 @@ static void graph_output_padding_line(struct git_graph *graph,
 	 * Output a padding row, that leaves all branch lines unchanged
 	 */
 	for (i = 0; i < graph->num_new_columns; i++) {
-		if (graph_needs_truncation(i))
+		if (graph_needs_truncation(graph, i))
 			break;
 		graph_line_write_column(line, &graph->new_columns[i], '|');
 		graph_line_addch(line, ' ');
@@ -920,7 +927,7 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
 			seen_this = 1;
 			graph_line_write_column(line, col, '|');
 			graph_line_addchars(line, ' ', graph->expansion_row);
-		} else if (seen_this && graph_needs_truncation(i)) {
+		} else if (seen_this && graph_needs_truncation(graph, i)) {
 			break;
 		} else if (seen_this && (graph->expansion_row == 0)) {
 			/*
@@ -1018,7 +1025,7 @@ static void graph_draw_octopus_merge(struct git_graph *graph, struct graph_line
 		 * Commit is at commit_index, each iteration move one lane to
 		 * the right from the commit.
 		 */
-		if (graph_needs_truncation(graph->commit_index + 1 + i))
+		if (graph_needs_truncation(graph, graph->commit_index + 1 + i))
 			break;
 
 		graph_line_write_column(line, col, (i == dashed_parents - 1) ? '.' : '-');
@@ -1055,14 +1062,14 @@ static void graph_output_commit_line(struct git_graph *graph, struct graph_line
 			seen_this = 1;
 			graph_output_commit_char(graph, line);
 
-			if (graph_needs_truncation(i)) {
+			if (graph_needs_truncation(graph, i)) {
 				graph_line_addch(line, ' ');
 				break;
 			}
 
 			if (graph->num_parents > 2)
 				graph_draw_octopus_merge(graph, line);
-		} else if (graph_needs_truncation(i)) {
+		} else if (graph_needs_truncation(graph, i)) {
 			seen_this = 1;
 			break;
 		} else if (seen_this && (graph->edges_added > 1)) {
@@ -1112,7 +1119,7 @@ static void graph_output_commit_line(struct git_graph *graph, struct graph_line
 	 * padding lane.
 	 */
 	if (graph->num_parents > 1) {
-		if (!graph_needs_truncation(graph->commit_index)) {
+		if (!graph_needs_truncation(graph, graph->commit_index)) {
 			graph_update_state(graph, GRAPH_POST_MERGE);
 		} else {
 			struct commit_list *p = first_interesting_parent(graph);
@@ -1128,7 +1135,7 @@ static void graph_output_commit_line(struct git_graph *graph, struct graph_line
 
 			lane = graph_find_new_column_by_commit(graph, p->item);
 
-			if (!graph_needs_truncation(lane))
+			if (!graph_needs_truncation(graph, lane))
 				graph_update_state(graph, GRAPH_POST_MERGE);
 			else if (graph_is_mapping_correct(graph))
 				graph_update_state(graph, GRAPH_PADDING);
@@ -1192,7 +1199,7 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct graph_l
 				 * comparable with i. Don't truncate if there are
 				 * no more lanes to print (end of the lane)
 				 */
-				if (graph_needs_truncation(j / 2 + i) &&
+				if (graph_needs_truncation(graph, j / 2 + i) &&
 				    j / 2 + i <= graph->num_columns) {
 					if ((j + i * 2) % 2 != 0)
 						graph_line_addch(line, ' ');
@@ -1205,7 +1212,7 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct graph_l
 					 * Check if the next lane needs truncation
 					 * to avoid having the padding doubled
 					 */
-					if (graph_needs_truncation((j + 1) / 2 + i) &&
+					if (graph_needs_truncation(graph, (j + 1) / 2 + i) &&
 					    j < graph->num_parents - 1) {
 						truncated = 1;
 						break;
@@ -1220,7 +1227,7 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct graph_l
 				break;
 			if (graph->edges_added == 0)
 				graph_line_addch(line, ' ');
-		} else if (graph_needs_truncation(i)) {
+		} else if (graph_needs_truncation(graph, i)) {
 			break;
 		} else if (seen_this) {
 			if (graph->edges_added > 0)
@@ -1231,7 +1238,7 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct graph_l
 			 * If it's between two lanes and next would be truncated,
 			 * don't add space padding.
 			 */
-			if (!graph_needs_truncation(i + 1))
+			if (!graph_needs_truncation(graph, i + 1))
 				graph_line_addch(line, ' ');
 		} else {
 			graph_line_write_column(line, col, '|');
@@ -1380,7 +1387,7 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct graph_l
 	for (i = 0; i < graph->mapping_size; i++) {
 		int target = graph->mapping[i];
 
-		if (!truncated && graph_needs_truncation(i / 2)) {
+		if (!truncated && graph_needs_truncation(graph, i / 2)) {
 			truncated = 1;
 		}
 
@@ -1480,7 +1487,7 @@ static void graph_padding_line(struct git_graph *graph, struct strbuf *sb)
 	for (i = 0; i < graph->num_columns; i++) {
 		struct column *col = &graph->columns[i];
 
-		if (graph_needs_truncation(i))
+		if (graph_needs_truncation(graph, i))
 			break;
 
 		graph_line_write_column(&line, col, '|');
diff --git a/revision.c b/revision.c
index 31808e3df0..81b67682a8 100644
--- a/revision.c
+++ b/revision.c
@@ -2605,6 +2605,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--no-graph")) {
 		graph_clear(revs->graph);
 		revs->graph = NULL;
+	} else if (skip_prefix(arg, "--graph-lane-limit=", &optarg)) {
+		revs->graph_max_lanes = parse_count(optarg);
 	} else if (!strcmp(arg, "--encode-email-headers")) {
 		revs->encode_email_headers = 1;
 	} else if (!strcmp(arg, "--no-encode-email-headers")) {
@@ -3172,6 +3174,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 
 	if (revs->no_walk && revs->graph)
 		die(_("options '%s' and '%s' cannot be used together"), "--no-walk", "--graph");
+
+	if (revs->graph_max_lanes > 0 && !revs->graph)
+		die(_("the option '%s' requires '%s'"), "--graph-lane-limit", "--graph");
+
 	if (!revs->reflog_info && revs->grep_filter.use_reflog_filter)
 		die(_("the option '%s' requires '%s'"), "--grep-reflog", "--walk-reflogs");
 
diff --git a/revision.h b/revision.h
index 69242ecb18..874ccce625 100644
--- a/revision.h
+++ b/revision.h
@@ -304,6 +304,7 @@ struct rev_info {
 
 	/* Display history graph */
 	struct git_graph *graph;
+	int graph_max_lanes;
 
 	/* special limits */
 	int skip_count;
diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
index 28d0779a8c..d7524e9366 100755
--- a/t/t4215-log-skewed-merges.sh
+++ b/t/t4215-log-skewed-merges.sh
@@ -370,4 +370,148 @@ test_expect_success 'log --graph with multiple tips' '
 	EOF
 '
 
+test_expect_success 'log --graph --graph-lane-limit=2 limited to two lanes' '
+	check_graph --graph-lane-limit=2 M_7 <<-\EOF
+	*-.   7_M4
+	|\ \
+	| | * 7_G
+	| | * 7_F
+	| *   7_E
+	| *   7_D
+	* |   7_C
+	| |/
+	|/|
+	* | 7_B
+	|/
+	* 7_A
+	EOF
+'
+
+test_expect_success 'log --graph --graph-lane-limit=1 truncate mid octopus merge' '
+	check_graph --graph-lane-limit=1 M_7 <<-\EOF
+	*-  7_M4
+	|\
+	|   7_G
+	|   7_F
+	| * 7_E
+	| * 7_D
+	*   7_C
+	|
+	|/
+	*   7_B
+	|/
+	* 7_A
+	EOF
+'
+
+test_expect_success 'log --graph --graph-lane-limit=3 limited to three lanes' '
+	check_graph --graph-lane-limit=3 M_1 M_3 M_5 M_7 <<-\EOF
+	*   7_M1
+	|\
+	| | *   7_M2
+	| | |\
+	| | | * 7_H
+	| | |   7_M3
+	| | |   7_J
+	| | |   7_I
+	| | |   7_M4
+	| |_|_
+	|/| |
+	| | |_
+	| |/|
+	| | |
+	| | |/
+	| | *   7_G
+	| | |
+	| | |/
+	| | *   7_F
+	| * |   7_E
+	| | |/
+	| |/|
+	| * |   7_D
+	| | |/
+	| |/|
+	* | | 7_C
+	| |/
+	|/|
+	* | 7_B
+	|/
+	* 7_A
+	EOF
+'
+
+test_expect_success 'log --graph --graph-lane-limit=6 check if it only shows first of 3 parent merge' '
+	check_graph --graph-lane-limit=6 M_1 M_3 M_5 M_7 <<-\EOF
+	*   7_M1
+	|\
+	| | *   7_M2
+	| | |\
+	| | | * 7_H
+	| | | | *   7_M3
+	| | | | |\
+	| | | | | * 7_J
+	| | | | * | 7_I
+	| | | | | | * 7_M4
+	| |_|_|_|_|/
+	|/| | | | |/
+	| | |_|_|/|
+	| |/| | | |/
+	| | | |_|/|
+	| | |/| | |
+	| | * | | | 7_G
+	| | | |_|/
+	| | |/| |
+	| | * | | 7_F
+	| * | | | 7_E
+	| | |/ /
+	| |/| |
+	| * | | 7_D
+	| | |/
+	| |/|
+	* | | 7_C
+	| |/
+	|/|
+	* | 7_B
+	|/
+	* 7_A
+	EOF
+'
+
+test_expect_success 'log --graph --graph-lane-limit=7 check if it shows all 3 parent merge' '
+	check_graph --graph-lane-limit=7 M_1 M_3 M_5 M_7 <<-\EOF
+	*   7_M1
+	|\
+	| | *   7_M2
+	| | |\
+	| | | * 7_H
+	| | | | *   7_M3
+	| | | | |\
+	| | | | | * 7_J
+	| | | | * | 7_I
+	| | | | | | *   7_M4
+	| |_|_|_|_|/|\
+	|/| | | | |/ /
+	| | |_|_|/| /
+	| |/| | | |/
+	| | | |_|/|
+	| | |/| | |
+	| | * | | | 7_G
+	| | | |_|/
+	| | |/| |
+	| | * | | 7_F
+	| * | | | 7_E
+	| | |/ /
+	| |/| |
+	| * | | 7_D
+	| | |/
+	| |/|
+	* | | 7_C
+	| |/
+	|/|
+	* | 7_B
+	|/
+	* 7_A
+	EOF
+'
+
 test_done
-- 
2.43.0

