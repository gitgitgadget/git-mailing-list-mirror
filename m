Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389B13988E1
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 13:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773668079; cv=none; b=qLMzdqVCzwXlkqsjcVg8lwbXL4ajyf6EkVmWNj6BBZKZJNzhTHUJClY9r320FvqXo0Is+pHPceiChsKKYfDm8TuNYw3XGpE7e+JJR1GnBNK6/Z2GJxIZgmlWNB/r/MmgTLyattMLWmw4QRCrfD6jHiVR1xn5UsyY/nVJpBrYvG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773668079; c=relaxed/simple;
	bh=E3OfBjINr7Q1UhzMWAzj+4eJvO238sBEaoGQ+8t8lpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nUIT+qllypXIEnqaVwUEQK6+M8Qv9htScKi+WWY16zyk4ebe4jF5MoXwP3Y+cbd/JySZYpC57IKEmQrl3N8yr4IENg3ex6oNei3UTvXqp5yVj3j9v7QQSyKGpiFoU9JG+jyQGXlMb+5EOZ4nagmNl7IQIPzpLws4PkB1HElKFAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOW8qgEf; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOW8qgEf"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48557c8ad47so26012965e9.0
        for <git@vger.kernel.org>; Mon, 16 Mar 2026 06:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773668076; x=1774272876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WbJV46+sdbmxr+d8AjUeHw40qoB/rsMGioBe5KvBnS0=;
        b=SOW8qgEf6F21izjF+SIth6rxL38ilt2/TWScGz5o2as0cQlu4/4Odn9eHryGVMZTdB
         QfiTp1JCCDwgmBwB4eDrTz47ckBeJC25mfMpGVftOj6IYMfRQdF+yQeQKRL/AWkHjUh+
         uWFp+bdTu6HQhImqdJPGX4xcj8F5VLGj0CFLkkEqHo0L179bNixvciNsTWU6OiRC+kwc
         0DNF8iR+F40DehU/6De9riwH2R+OukdXEkbjf1dx+KoCXeY1pwTbDBw7aHnkQ+UpRNBP
         hdim5lT0ND+XFeD3W3IEYVJonjHoyIsA4YGfRFTbZhGcoXhXVifeb51J5e+nCnKo8Esm
         sscw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773668076; x=1774272876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbJV46+sdbmxr+d8AjUeHw40qoB/rsMGioBe5KvBnS0=;
        b=VnpedpYFSjPpoffMRromwG1Rz19TP7jjnwK/Z7mYe4ceMqAXh8tbfnvajOk2/T4H9u
         XhrBTZ9K0AnQ9MmTeaFDZLoVLDj2qQZWF4GT/Q39nJ59u3d5UAgA7KlzO5bdQOq0Nmeq
         LMOCNorS4CuQ7ZwgRNSIU6uJcOApmspDUNkyTetFsGh5kLf4ssB1j/qA9V699MZ5D/SZ
         iqnGXb+Bid6BSZg1Upo3COQIpjoCBPoLisF6i3R07Zhr7DcKx5ftcdaRYAy9Choe3ifr
         xGgcRTQ0yjBU0HmDV3oxZlLMSe5/g1r7vKRhO70eSh/1duMBBL/zV0x0duwFMZ0LLD1n
         x00g==
X-Gm-Message-State: AOJu0YwbaTyZvEzvhADNPbZZhvDLEYyMksESloYTdpKWUJSO8MJkZSmF
	DzoitnC3jiAdEXdwxZADgobLTj/yq2UrPEk15puhfTPdPW0cLU8W/MHx9b5u3QmEEud6Tw==
X-Gm-Gg: ATEYQzyAX/KyoaOb2hsDW97TS3y+XK7bKXLp3pbhpwCRB61VDG/KF0LUi5aiw+IeCQH
	NmTAXYGme/tGiZhd0Bbx7Ujy/abRbbPfTk5HVSKhvZbByskXz0EYlOxQU3JIvR3+tszdUdw//c/
	5f6hOSeoml+Hwds2Q3jUB7Zy2kvVhq4TERIKr8xHsx30YYawQRoszJvGamtCYV/Zsmo+8IKQN+f
	hXRNvP4mC/mpxU8zdP47Jr4QlfOCMhtuEAFEGhRmQvADErq/KkWhX008ExTS4/9K+wmxBeJOPMa
	+7ErMSFUJ8CtPHmbwYH3N55tnibBJAQN/ILcZWosFkF9Y6upeATwlOSCvEw1tUfedOpPNEzMKeX
	oOELpc786BlH5J9sd5Lxw4kHof4/64Qai5jRNAKkbwbO2UrZJcIWVDF9DYp2nXjawF4eZgf5vYW
	RpHapELl5pSyiFEwHQwBaP3FpvqmZmsdZu0D5IqWuuR3RoSsk8qB+xLFp+SVjXiMvNA5NcqBcEN
	/u7a4+l2Yuc510pJKU02c+dU6tiyDhy2XiRd3/H4wu/B5Ca+ZVMPSK56Esox+oQcNpqNQ==
X-Received: by 2002:a05:600d:8486:20b0:485:30f7:6e88 with SMTP id 5b1f17b1804b1-485567149fbmr156900945e9.31.1773668076133;
        Mon, 16 Mar 2026 06:34:36 -0700 (PDT)
Received: from farblopa.localdomain ([84.126.0.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b66ffe2sm391805945e9.13.2026.03.16.06.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 06:34:35 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com,
	chandrapratap3519@gmail.com,
	Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [GSoC RFC PATCH] graph: add --graph-max option to limit displayed columns
Date: Mon, 16 Mar 2026 14:34:26 +0100
Message-ID: <20260316133426.117684-1-pabloosabaterr@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When there are multiple branches, --graph-max modifies the maximum
amount of columns that will be displayed.

Add "--graph-max=<n>" option to cap how many columns will be shown,
columns after the limit are replaced with a single '.'. Changes only
the output rendering.

Define MINIMUM_GRAPH_COLUMNS constant to validate the option value.

The commit character '*' is always shown no matter what the limit is.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---

This addresses the TODO at graph.c:

  TODO:
      - Limit the number of columns, similar to the way gitk does.
        If we reach more than a specified number of columns, omit
        sections of some columns.

About the design of how this would have to be:

- Should '--graph-max' by itself be enough to implicitly work like '--graph' so 
  'git log --graph-max=3' works without needing to write '--graph'?
- graph_max_columns by default is set to 0, meaning no limit, and any other 
  positive value becomes a limit. Is this a good design? it cannot be negative,
  shouldn't it be a uint32_t instead, I left it as a int because of the other
  variables like this that are int. like skip_count, max_count, etc.
- Is '--graph-max' a good name?
- Is '.' a good char for truncation?
- Should '/' to outside branches be shown?
- What should it be done when a commit is in a column that is truncated?

known limitations:

- Post merge lines have some trouble with the padding.

I added two tests for example, but I will add better test coverage as design 
choices are more clear. testing on the Git repo itself is a good example also.

 graph.c                      | 52 +++++++++++++++++++++++++++------
 graph.h                      |  2 ++
 revision.c                   |  7 +++++
 revision.h                   |  1 +
 t/t4215-log-skewed-merges.sh | 56 ++++++++++++++++++++++++++++++++++++
 5 files changed, 109 insertions(+), 9 deletions(-)

diff --git a/graph.c b/graph.c
index 26f6fbf000..7ae0ab61b7 100644
--- a/graph.c
+++ b/graph.c
@@ -42,14 +42,6 @@ static void graph_padding_line(struct git_graph *graph, struct strbuf *sb);
 static void graph_show_strbuf(struct git_graph *graph,
 			      FILE *file,
 			      struct strbuf const *sb);
-
-/*
- * TODO:
- * - Limit the number of columns, similar to the way gitk does.
- *   If we reach more than a specified number of columns, omit
- *   sections of some columns.
- */
-
 struct column {
 	/*
 	 * The parent commit of this column.
@@ -317,6 +309,12 @@ struct git_graph {
 	struct strbuf prefix_buf;
 };
 
+static int graph_is_truncated(struct git_graph *graph, int col)
+{
+	int max = graph->revs->graph_max_columns;
+	return max > 0 && col >= max;
+}
+
 static const char *diff_output_prefix_callback(struct diff_options *opt, void *data)
 {
 	struct git_graph *graph = data;
@@ -846,6 +844,10 @@ static void graph_output_padding_line(struct git_graph *graph,
 	 * Output a padding row, that leaves all branch lines unchanged
 	 */
 	for (i = 0; i < graph->num_new_columns; i++) {
+		if (graph_is_truncated(graph, i)) {
+			graph_line_addstr(line, ". ");
+			break;
+		}
 		graph_line_write_column(line, &graph->new_columns[i], '|');
 		graph_line_addch(line, ' ');
 	}
@@ -903,6 +905,9 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
 			seen_this = 1;
 			graph_line_write_column(line, col, '|');
 			graph_line_addchars(line, ' ', graph->expansion_row);
+		} else if (seen_this && graph_is_truncated(graph, i)) {
+			graph_line_addstr(line, ". ");
+			break;
 		} else if (seen_this && (graph->expansion_row == 0)) {
 			/*
 			 * This is the first line of the pre-commit output.
@@ -1013,6 +1018,7 @@ static void graph_output_commit_line(struct git_graph *graph, struct graph_line
 	 * children that we have already processed.)
 	 */
 	seen_this = 0;
+
 	for (i = 0; i <= graph->num_columns; i++) {
 		struct column *col = &graph->columns[i];
 		struct commit *col_commit;
@@ -1028,8 +1034,14 @@ static void graph_output_commit_line(struct git_graph *graph, struct graph_line
 			seen_this = 1;
 			graph_output_commit_char(graph, line);
 
+			if (graph_is_truncated(graph, i))
+				break;
+
 			if (graph->num_parents > 2)
 				graph_draw_octopus_merge(graph, line);
+		} else if (seen_this && graph_is_truncated(graph, i)) {
+			graph_line_addstr(line, ". ");
+			break;
 		} else if (seen_this && (graph->edges_added > 1)) {
 			graph_line_write_column(line, col, '\\');
 		} else if (seen_this && (graph->edges_added == 1)) {
@@ -1109,9 +1121,15 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct graph_l
 			int par_column;
 			int idx = graph->merge_layout;
 			char c;
+			int truncated = 0;
 			seen_this = 1;
 
 			for (j = 0; j < graph->num_parents; j++) {
+				if (graph_is_truncated(graph, i + j)) {
+					graph_line_addstr(line, ". ");
+					truncated = 1;
+					break;
+				}
 				par_column = graph_find_new_column_by_commit(graph, parents->item);
 				assert(par_column >= 0);
 
@@ -1125,10 +1143,15 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct graph_l
 				}
 				parents = next_interesting_parent(graph, parents);
 			}
+			if (truncated)
+				break;
 			if (graph->edges_added == 0)
 				graph_line_addch(line, ' ');
-
 		} else if (seen_this) {
+			if (graph_is_truncated(graph, i)) {
+				graph_line_addstr(line, ". ");
+				break;
+			}
 			if (graph->edges_added > 0)
 				graph_line_write_column(line, col, '\\');
 			else
@@ -1279,6 +1302,12 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct graph_l
 	 */
 	for (i = 0; i < graph->mapping_size; i++) {
 		int target = graph->mapping[i];
+
+		if (graph_is_truncated(graph, i / 2)) {
+			graph_line_addstr(line, ". ");
+			break;
+		}
+
 		if (target < 0)
 			graph_line_addch(line, ' ');
 		else if (target * 2 == i)
@@ -1372,6 +1401,11 @@ static void graph_padding_line(struct git_graph *graph, struct strbuf *sb)
 	for (i = 0; i < graph->num_columns; i++) {
 		struct column *col = &graph->columns[i];
 
+		if (graph_is_truncated(graph, i)) {
+			graph_line_addch(&line, '.');
+			break;
+		}
+
 		graph_line_write_column(&line, col, '|');
 
 		if (col->commit == graph->commit && graph->num_parents > 2) {
diff --git a/graph.h b/graph.h
index 3fd1dcb2e9..9a4551dd29 100644
--- a/graph.h
+++ b/graph.h
@@ -262,4 +262,6 @@ void graph_show_commit_msg(struct git_graph *graph,
 			   FILE *file,
 			   struct strbuf const *sb);
 
+#define MINIMUM_GRAPH_COLUMNS 1
+
 #endif /* GRAPH_H */
diff --git a/revision.c b/revision.c
index 31808e3df0..ba5088be14 100644
--- a/revision.c
+++ b/revision.c
@@ -2605,6 +2605,13 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--no-graph")) {
 		graph_clear(revs->graph);
 		revs->graph = NULL;
+	} else if (skip_prefix(arg, "--graph-max=", &optarg)) {
+		revs->graph_max_columns = strtoul(optarg, NULL, 10);
+		if (revs->graph_max_columns < MINIMUM_GRAPH_COLUMNS) {
+			die(_("minimum columns is %d, unable to set below %d"),
+			MINIMUM_GRAPH_COLUMNS,
+			revs->graph_max_columns);
+		}
 	} else if (!strcmp(arg, "--encode-email-headers")) {
 		revs->encode_email_headers = 1;
 	} else if (!strcmp(arg, "--no-encode-email-headers")) {
diff --git a/revision.h b/revision.h
index 69242ecb18..6442129c14 100644
--- a/revision.h
+++ b/revision.h
@@ -304,6 +304,7 @@ struct rev_info {
 
 	/* Display history graph */
 	struct git_graph *graph;
+	int graph_max_columns;
 
 	/* special limits */
 	int skip_count;
diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
index 28d0779a8c..6266de4e2b 100755
--- a/t/t4215-log-skewed-merges.sh
+++ b/t/t4215-log-skewed-merges.sh
@@ -370,4 +370,60 @@ test_expect_success 'log --graph with multiple tips' '
 	EOF
 '
 
+test_expect_success 'log --graph --graph-max=2 only two columns' '
+	check_graph --graph-max=2 M_7 <<-\EOF
+	*-.   7_M4
+	|\ .
+	| | * 7_G
+	| | * 7_F
+	| * . 7_E
+	| * . 7_D
+	* | . 7_C
+	| |/
+	|/|
+	* | 7_B
+	|/
+	* 7_A
+	EOF
+'
+
+test_expect_success 'log --graph --graph-max=3 only three columns' '
+	check_graph --graph-max=3 M_1 M_3 M_5 M_7 <<-\EOF
+	*   7_M1
+	|\
+	| | *   7_M2
+	| | |.
+	| | | * 7_H
+	| | | | *   7_M3
+	| | | | .
+	| | | | | * 7_J
+	| | | | *   7_I
+	| | | | | | *   7_M4
+	| |_|_|_|_|.
+	|/| | .
+	| | |_.
+	| |/|_.
+	| |/|_.
+	| |/| .
+	| | |/.
+	| | * .     7_G
+	| | | .
+	| | |/.
+	| | |/.
+	| | * .   7_F
+	| * | .   7_E
+	| | |/.
+	| |/| .
+	| * | . 7_D
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

