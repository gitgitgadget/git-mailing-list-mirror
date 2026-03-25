Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94BB4070F3
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 17:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774460661; cv=none; b=ka87hyYoYStm24XlC1TXmezxnfTITh8vqEWOT8aSWb6k8Q46FwowyJR617EzCpw5XMncBov3nBcl1zMOZNHkfqUpYV6GrUrBRzEWS1LR6ghoQXJI8olzTfy6G3zBedVwJej8tA60+JP6F+tvGGrTKjzNi3+7jDH6Oe4DwR817X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774460661; c=relaxed/simple;
	bh=H3RmfM/3HYN1HUCMdWAgatfgMFue5ty9mnmnhaoOiyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OM9faYBufViQLOqtpaoSaroJDRzYetWaYoz4++aR1cILJdPcSo4HhL/T0hey0QP57cJvVLrRKU4CUSvVwLel+rCQ03QUQqsGkvWQy3tyZ6SZCblFrpd51DbZ/tvljLCV30Ec3Vx85rgkU/zbqet/jWnjQJesfsAf7muVYjCVXzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o4EseoU+; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o4EseoU+"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-486fb439299so1546705e9.0
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 10:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774460657; x=1775065457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=otRsexOvBthx0OB202QY13B0kF/RugImOdvr258Qjj4=;
        b=o4EseoU+KJ+WnAYlV9gTfJFHmi9UtXLuwqVvuPZaCx99H0b5O46lYLD94Q/tMCW7hz
         8Z4lBBDoRE43fKzf13FAEujBWqyltsPgVgcJoA3E3UUfTnbb1u81BdeBOfRZfmzsjlmO
         7k1aeLChpgamxJIlUU0nUB+FZAGmPVCzg1oCStbUjpjDhgn/gD1RQc5G7myimxagUFuh
         d4Z1OvBxENo0r3XCuzPDWbiLX7823OorTSNOs57ReRY5CjO9dQ4tHAd81LnWHH6S9h6l
         LdoPp2ZesUcsoFBYH2XcCv67jNvdYS0VqdJDo5v9Mxd1F5OP3TULzw0wIaO4f6SLE+3f
         UVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774460657; x=1775065457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=otRsexOvBthx0OB202QY13B0kF/RugImOdvr258Qjj4=;
        b=X798Go4YHLPKA2zkvsYfEe9T3JrmzQtR+N2AqAMJugBFAaBZr/1hJeyENS6WXRfLx4
         H2knJwu6+JHfE15KHXa8gXyT2RBx2UlOKvWRVtD+LwBB+ej2/HPRHj0I7QlrTI04yPi3
         GHfJAK2aHUz84d7Napv8x1xIPB5uyHqRRMpVKvcLa5FXmjQxvxXJi7xCO85mXE2hOkpQ
         EcpER+TcFxbMuivOJhTaAJ7qY9UkJcEsj/Fq6ZpmU5MjEQfsErsB69oLIFwOuCbicFH6
         sRLI71SHiQ3FOWn69lkE62S8bC+AISQy5I2ALAjTkTzsAg+HKGKF14eIXRrvmOIF3OAJ
         mhhA==
X-Gm-Message-State: AOJu0YxcndgjD3B8l33FCYA03IB9vjlUPIsCmpWLgTIwt1CmRcfkTvnt
	OL799hfR/nR9XKSJnn6azOB7BOXPfVOuW8rAQ+ccIXXdHDblLn7QZbggJh4u0ly0biru5Q==
X-Gm-Gg: ATEYQzxRxXIVdFXsZO4rv+mwWX4aB1U8Sx/x8WcC16c3emjCurQJX9AItKb1jvDdBxq
	iVUoH3L4ZpHkfSHFADCwtqkFw3AdC9bDBwGuMVS9cXkW1Bl1XerD29n+k4KMIEuwiAss53WVt0U
	PZTgsH4mI4JmhBvUg5q+Sa0IJqX6eOOnax5ojiDqLuWW+2M8kLIAKe6RImZAHYgnvBgbsxJrYkB
	YaYsgUoubWUpj1A0yZljDpW8ZYu8NAGxtDjtGa2rr+OnyebfLGoYMJNYuG61ZTe69SPxp11Ybof
	5WTxLXpPk0nlWrrbUpG/43aXrDAvwsXJVq6scYO865aOksXpAoz9G7+pNF+w32OA+WCFAc0dcbL
	dmZlp726Kd0k1cZRtxlF/HXA3uM5CYp1JWj6KA1RdKOSGgGs8Ljirocj2QfiqrCWPpZ/6hJugDP
	d3g8zoXsT7fJqpKyz1FdJo4aP+bQh9T5PCyk0LCid+7ttNqXMaNiyuQraeATV1HErjguEKrGy75
	zH8xT1Cm/Z1BI67irRFbwugRRfxVgF2PMlusPyjGEjxvMgxUc98kxoYZV8=
X-Received: by 2002:a05:600c:a41b:b0:486:fbe1:2499 with SMTP id 5b1f17b1804b1-48716043a6cmr40050785e9.22.1774460656584;
        Wed, 25 Mar 2026 10:44:16 -0700 (PDT)
Received: from farblopa.localdomain ([84.126.0.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48716547814sm47106145e9.0.2026.03.25.10.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 10:44:16 -0700 (PDT)
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
Subject: [GSoC PATCH v5 1/2] graph: add --graph-lane-limit option
Date: Wed, 25 Mar 2026 18:44:00 +0100
Message-ID: <20260325174401.217577-2-pabloosabaterr@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325174401.217577-1-pabloosabaterr@gmail.com>
References: <20260323215935.74486-1-pabloosabaterr@gmail.com>
 <20260325174401.217577-1-pabloosabaterr@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Repositories that have many active branches at the same time produce
wide graphs. A lane consists of two columns, the edge and the space
padding, each branch takes a lane in the graph and there is no way
to limit how many can be shown.

Add '--graph-lane-limit=<n>' revision option that caps the number
of visible lanes to n. This option requires '--graph', without it
a limit to the graph has no meaning, in this case error out.

Zero and negative values are valid inputs but silently ignored
treating them as "no limit", the same as not using the option.
This follows what '--max-parents' does with negative values.

When the limit is set, lanes over the limit are not drawn.
Teach each graph state to stop rendering at the lane limit
and print a "~" truncation mark, so users know that
there are hidden lanes. The "~" was chosen because it was not used
elsewhere in the graph and it is discrete.

On the commit line, if the commit lives on a visible lane, show
the normal commit mark and truncate after it, if the commit lives
on the first hidden lane show the "*" instead of the truncation mark
so it is known that this commit sits on the first hidden lane.
Commits on deeper lanes don't leave a mark.

For merges, the post-merge lane is only needed when the commit or
the first parent lives on a visible lane (to draw the connection
between them), when both are on hidden lanes, post-merge carries no
useful information, skip it and go to collapsing or padding state.

Also fix a pre-existing indentation issue.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 graph.c    | 150 +++++++++++++++++++++++++++++++++++++++++++++--------
 revision.c |   6 +++
 revision.h |   1 +
 3 files changed, 134 insertions(+), 23 deletions(-)

diff --git a/graph.c b/graph.c
index 26f6fbf000..2218f00c40 100644
--- a/graph.c
+++ b/graph.c
@@ -317,6 +317,15 @@ struct git_graph {
 	struct strbuf prefix_buf;
 };
 
+static int graph_needs_truncation(struct git_graph *graph, int lane)
+{
+	int max = graph->revs->graph_max_lanes;
+	/*
+	 * Ignore values <= 0, meaning no limit.
+	 */
+	return max > 0 && lane >= max;
+}
+
 static const char *diff_output_prefix_callback(struct diff_options *opt, void *data)
 {
 	struct git_graph *graph = data;
@@ -696,6 +705,18 @@ static void graph_update_columns(struct git_graph *graph)
 		}
 	}
 
+	/*
+	 * If graph_max_lanes is set, cap the padding from the branches
+	 */
+	if (graph->revs->graph_max_lanes > 0) {
+		/*
+		 * width of "| " per lanes plus truncation mark "~ ".
+		 */
+		int max_columns_width = graph->revs->graph_max_lanes * 2 + 2;
+		if (graph->width > max_columns_width)
+			graph->width = max_columns_width;
+	}
+
 	/*
 	 * Shrink mapping_size to be the minimum necessary
 	 */
@@ -846,6 +867,10 @@ static void graph_output_padding_line(struct git_graph *graph,
 	 * Output a padding row, that leaves all branch lines unchanged
 	 */
 	for (i = 0; i < graph->num_new_columns; i++) {
+		if (graph_needs_truncation(graph, i)) {
+			graph_line_addstr(line, "~ ");
+			break;
+		}
 		graph_line_write_column(line, &graph->new_columns[i], '|');
 		graph_line_addch(line, ' ');
 	}
@@ -903,6 +928,9 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
 			seen_this = 1;
 			graph_line_write_column(line, col, '|');
 			graph_line_addchars(line, ' ', graph->expansion_row);
+		} else if (seen_this && graph_needs_truncation(graph, i)) {
+			graph_line_addstr(line, "~ ");
+			break;
 		} else if (seen_this && (graph->expansion_row == 0)) {
 			/*
 			 * This is the first line of the pre-commit output.
@@ -994,6 +1022,12 @@ static void graph_draw_octopus_merge(struct git_graph *graph, struct graph_line
 		col = &graph->new_columns[j];
 
 		graph_line_write_column(line, col, '-');
+
+		if (graph_needs_truncation(graph, j / 2 + i)) {
+			graph_line_addstr(line, "~ ");
+			break;
+		}
+
 		graph_line_write_column(line, col, (i == dashed_parents - 1) ? '.' : '-');
 	}
 
@@ -1028,8 +1062,17 @@ static void graph_output_commit_line(struct git_graph *graph, struct graph_line
 			seen_this = 1;
 			graph_output_commit_char(graph, line);
 
+			if (graph_needs_truncation(graph, i)) {
+				graph_line_addch(line, ' ');
+				break;
+			}
+
 			if (graph->num_parents > 2)
 				graph_draw_octopus_merge(graph, line);
+		} else if (graph_needs_truncation(graph, i)) {
+			graph_line_addstr(line, "~ ");
+			seen_this = 1;
+			break;
 		} else if (seen_this && (graph->edges_added > 1)) {
 			graph_line_write_column(line, col, '\\');
 		} else if (seen_this && (graph->edges_added == 1)) {
@@ -1065,10 +1108,32 @@ static void graph_output_commit_line(struct git_graph *graph, struct graph_line
 
 	/*
 	 * Update graph->state
+	 *
+	 * If the commit is a merge and the first parent is in a visible lane,
+	 * then the GRAPH_POST_MERGE is needed to draw the merge lane.
+	 *
+	 * If the commit is over the truncation limit, but the first parent is on
+	 * a visible lane, then we still need the merge lane but truncated.
+	 *
+	 * If both commit and first parent are over the truncation limit, then
+	 * there's no need to draw the merge lane because it would work as a
+	 * padding lane.
 	 */
-	if (graph->num_parents > 1)
-		graph_update_state(graph, GRAPH_POST_MERGE);
-	else if (graph_is_mapping_correct(graph))
+	if (graph->num_parents > 1) {
+		if (!graph_needs_truncation(graph, graph->commit_index)) {
+			graph_update_state(graph, GRAPH_POST_MERGE);
+		} else {
+			struct commit_list *first_parent = first_interesting_parent(graph);
+			int first_parent_col = graph_find_new_column_by_commit(graph, first_parent->item);
+
+			if (!graph_needs_truncation(graph, first_parent_col))
+				graph_update_state(graph, GRAPH_POST_MERGE);
+			else if (graph_is_mapping_correct(graph))
+				graph_update_state(graph, GRAPH_PADDING);
+			else
+				graph_update_state(graph, GRAPH_COLLAPSING);
+		}
+	} else if (graph_is_mapping_correct(graph))
 		graph_update_state(graph, GRAPH_PADDING);
 	else
 		graph_update_state(graph, GRAPH_COLLAPSING);
@@ -1109,6 +1174,7 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct graph_l
 			int par_column;
 			int idx = graph->merge_layout;
 			char c;
+			int truncated = 0;
 			seen_this = 1;
 
 			for (j = 0; j < graph->num_parents; j++) {
@@ -1117,23 +1183,46 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct graph_l
 
 				c = merge_chars[idx];
 				graph_line_write_column(line, &graph->new_columns[par_column], c);
+				if (graph_needs_truncation(graph, j / 2 + i) &&
+				    j / 2 + i <= graph->num_columns) {
+					if ((j + i * 2) % 2 != 0)
+						graph_line_addch(line, ' ');
+					graph_line_addstr(line, "~ ");
+					truncated = 1;
+					break;
+				}
+
 				if (idx == 2) {
-					if (graph->edges_added > 0 || j < graph->num_parents - 1)
+					if (graph_needs_truncation(graph, (j + 1) / 2 + i) &&
+					    j < graph->num_parents - 1) {
+						graph_line_addstr(line, "~ ");
+						truncated = 1;
+						break;
+					} else if (graph->edges_added > 0 || j < graph->num_parents - 1)
 						graph_line_addch(line, ' ');
 				} else {
 					idx++;
 				}
 				parents = next_interesting_parent(graph, parents);
 			}
+			if (truncated)
+				break;
 			if (graph->edges_added == 0)
 				graph_line_addch(line, ' ');
-
+		} else if (graph_needs_truncation(graph, i)) {
+			graph_line_addstr(line, "~ ");
+			break;
 		} else if (seen_this) {
 			if (graph->edges_added > 0)
 				graph_line_write_column(line, col, '\\');
 			else
 				graph_line_write_column(line, col, '|');
-			graph_line_addch(line, ' ');
+			/*
+			 * If it's between two lanes and next would be truncated,
+			 * don't add space padding.
+			 */
+			if (!graph_needs_truncation(graph, i + 1))
+				graph_line_addch(line, ' ');
 		} else {
 			graph_line_write_column(line, col, '|');
 			if (graph->merge_layout != 0 || i != graph->commit_index - 1) {
@@ -1164,6 +1253,7 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct graph_l
 	short used_horizontal = 0;
 	int horizontal_edge = -1;
 	int horizontal_edge_target = -1;
+	int truncated = 0;
 
 	/*
 	 * Swap the mapping and old_mapping arrays
@@ -1279,26 +1369,35 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct graph_l
 	 */
 	for (i = 0; i < graph->mapping_size; i++) {
 		int target = graph->mapping[i];
-		if (target < 0)
-			graph_line_addch(line, ' ');
-		else if (target * 2 == i)
-			graph_line_write_column(line, &graph->new_columns[target], '|');
-		else if (target == horizontal_edge_target &&
-			 i != horizontal_edge - 1) {
-				/*
-				 * Set the mappings for all but the
-				 * first segment to -1 so that they
-				 * won't continue into the next line.
-				 */
-				if (i != (target * 2)+3)
-					graph->mapping[i] = -1;
-				used_horizontal = 1;
-			graph_line_write_column(line, &graph->new_columns[target], '_');
+
+		if (!truncated && graph_needs_truncation(graph, i / 2)) {
+			graph_line_addstr(line, "~ ");
+			truncated = 1;
+		}
+
+		if (target < 0) {
+			if (!truncated)
+				graph_line_addch(line, ' ');
+		} else if (target * 2 == i) {
+			if (!truncated)
+				graph_line_write_column(line, &graph->new_columns[target], '|');
+		} else if (target == horizontal_edge_target &&
+			   i != horizontal_edge - 1) {
+			/*
+			 * Set the mappings for all but the
+			 * first segment to -1 so that they
+			 * won't continue into the next line.
+			 */
+			if (i != (target * 2)+3)
+				graph->mapping[i] = -1;
+			used_horizontal = 1;
+			if (!truncated)
+				graph_line_write_column(line, &graph->new_columns[target], '_');
 		} else {
 			if (used_horizontal && i < horizontal_edge)
 				graph->mapping[i] = -1;
-			graph_line_write_column(line, &graph->new_columns[target], '/');
-
+			if (!truncated)
+				graph_line_write_column(line, &graph->new_columns[target], '/');
 		}
 	}
 
@@ -1372,6 +1471,11 @@ static void graph_padding_line(struct git_graph *graph, struct strbuf *sb)
 	for (i = 0; i < graph->num_columns; i++) {
 		struct column *col = &graph->columns[i];
 
+		if (graph_needs_truncation(graph, i)) {
+			graph_line_addch(&line, '~');
+			break;
+		}
+
 		graph_line_write_column(&line, col, '|');
 
 		if (col->commit == graph->commit && graph->num_parents > 2) {
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

base-commit: ce74208c2fa13943fffa58f168ac27a76d0eb789
-- 
2.43.0

