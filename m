Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CE83AF643
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 10:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777285729; cv=none; b=enot5WjxJ66QnqHdAnYrq4h5wbIamsW3NVszn5u9Z2m4KkT+R43jJkw8++6gL83G1a/ntGb1KfV0w9PsbX+NQOm9yeP1NUEvmbGfnR1ClN0D+csFpOZMG3e3Qtg9YRMA1/iwSGemGP31iLUbrbwm7FYT+E2r3/xu47tEIIKXpI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777285729; c=relaxed/simple;
	bh=IeX9w5r7pUOIu9Uqn0yytmtlpmYBPUDuQiWTul7DpM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JNqzfM0TBH7qKC8DeOipT6hlHMujMIXdm3lXObm1FoRYpK/s1Mv6aQoW+Lgmsr7+fCPB7lYU8x20V4dmlMxnmN7Zy5aWWdIS7MFu9BRw7qCqZWEghltksB9WXDzN4dvfQyFa0AhKVoHbSUgUsGu1bLWDgCSZNi0n582mwlSjmPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRUgx8Ub; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRUgx8Ub"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4890d945eb4so50155655e9.0
        for <git@vger.kernel.org>; Mon, 27 Apr 2026 03:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777285726; x=1777890526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acrUkx8i5m/OHt0hEDnq0TBzcXgp5JJw2wiNYkP5JC8=;
        b=KRUgx8UbSzCjkFA36lmuklIwkZxxC9flL8pm2hAZ0OqMxxS824Nfwv8e1LyhmH2so4
         h/GyHULwYaBOYsp4gkQs3lSN//TbpbJcCSL9JHvjSE22vs5+VLINdzVxgZWt33mVutKX
         Rs/fuH5qwWaBnkBcov+iNx79xT2xd0yAtMTrWH4qeu5fDnnhXLV4XgkD8/yu/T1TPbGM
         0JtSZNRKmwdmX7kjBjJ5LwPKXkxIExn82ugPdx+4E0ZsYULBzjY1o0HS7xNytLoWwT+E
         jTVxe8Cie/s8Nq7hbm15Fw0DKoJCAxXmFf4AfFcAau7wtaeE8TA9ZlR6g1I7nf5aJvAi
         n9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777285726; x=1777890526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=acrUkx8i5m/OHt0hEDnq0TBzcXgp5JJw2wiNYkP5JC8=;
        b=CNmNsB60tkopxiWH52XnBGnrympLWBoIOv+BYTSjDEGggBhuOVL6xgWBgmXwtgSxAh
         c1QZ6GS6tp1zuh5rZ6mVkrx/9hRuO9NfjjxOia006Bk8W/vva4/bksqYovLQreQ5TLiE
         EjaWF1f6aFKpjTEojHhdFXsPLW/pJivc6ovFyLF61DAg9odv5bMCRPC5M+j8p4GszgY3
         WVYKuVPKkcQg96C9QCcRB9EPspwx1K69DzSS+f381cUJBM0y3qi4DfQIMqK1pxqnkRoL
         /eGKCPe7bqulTX8gcKJbzqJMNTUijChq93t+fLUIomIyh+Kq817e3KPaTzBWri0aXxHx
         KR9A==
X-Gm-Message-State: AOJu0YyCshS/2aCOb4pDbUosWl46xw+ICFxZ3brrCpYMLhhf+upsopAH
	2HqDz13slSxPJGFvcac1tYCC1AoqM8SbneLrM6T3VLVuJU1REY8eNDh8rU49Sz7rK/0=
X-Gm-Gg: AeBDievVyObP86sj9msForDvwR/1gkiuHhVsmsi/D83ir6/aGquRjMHZF3SYhkxNyUd
	ZJjbp/7SVb2E6XPRcc/HyqO9GKvQ+6hGC6voKDgUoUvfoOcq/DlC/mueUlsg7NHWc+90spGDr9o
	qIxcdStdBNh0luxS2KrnnfQ2pvGr/ZXD4+1eABFbOM8KUjgsIUaU8yArIqAPdvini9DMwFD9Y0g
	EVGJTVujrURz1WTpv5X4MTlclpVX9iDS8YCPYL+apP2quik0gmVZVrpoX8/XHQ4lsE9RP3jJ+BY
	h0BmNV6KwL/Hvo4gg+VDBg1PGuckf4I2cbmnSd+AKeii6rtRv2AD+dogi4lNnhZXpibiH/7zcgA
	v81G2Hxe07C3Xa98YXCPJ7pxhWLmbim75UIscfrL5UqVvKMr/Z+2Sjvb2oUJDO3c310aA61WokS
	VUb7xJdtG9kNK69V6RN2ySpscU0fGuEjOhMMmdecjH5dYicmOVN4H/WKqPJywhPMI3969NMrzxR
	L0CoB/kN6xy3plfX5IkdLBL26hHcCAaRXLZK9rkvRzUwomD8/nM6tTiPBtQHKU/Uvvl71XIfWe3
	+sUq+8LwjMD37AUWj8kNqxahLaGNa50TSxBxdSOqD190SF+Y9lJETQzsrDkvspE+
X-Received: by 2002:a05:600c:870e:b0:488:aa33:dc8f with SMTP id 5b1f17b1804b1-488fb84ffb8mr570191375e9.0.1777285725352;
        Mon, 27 Apr 2026 03:28:45 -0700 (PDT)
Received: from farblopa.localdomain ([193.125.177.175])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7a06f3sm285517735e9.22.2026.04.27.03.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 03:28:44 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com,
	chandrapratap3519@gmail.com,
	Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [GSoC PATCH v3 1/1] graph: add indentation for commits preceded by a parentless commit
Date: Mon, 27 Apr 2026 12:28:38 +0200
Message-ID: <20260427102838.44867-2-pabloosabaterr@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427102838.44867-1-pabloosabaterr@gmail.com>
References: <20260404092425.550346-1-pabloosabaterr@gmail.com>
 <20260427102838.44867-1-pabloosabaterr@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When having a history with multiple root commits or commits
that act like roots (they have excluded parents), let's call
them parentless, and drawing the history near them, the
graphing engine renders the commits one below the other, seeming
that they are related.

This issue has been attempted multiple times:
  https://lore.kernel.org/git/xmqqwnwajbuj.fsf@gitster.c.googlers.com/

This happens because for these parentless commits, in the next
row the column becomes empty and the engine prints from left
to right from the first empty column, filling the gap below
these parentless commits.

Keep a parentless commit for at least one row more to avoid
having the column empty but hide it as indentation,
therefore making the next unrelated commit live in
the next column (column means even positions where edges live:
0, 2, 4), then clean that "placeholder" column and let
the unrelated commit to naturally collapse to the column
where the parentless commit was.

Add is_placeholder to the struct column to mark if a column
is acting as a placeholder for the padding.

When a column is parentless, add a column with the parentless
commit data to prevent segfaults when 'column->commit' and
mark it as a placeholder.

Teach rendering functions to print a padding ' ' instead of
an edge when a placeholder column is met.

Then, unless the next commit is also parentless (then we
need to keep cascading the indentation) clean the mapping
and columns from the placeholder to allow it to
collapse naturally.

Add tests for different cases.

before this patch:

* parentless A
* child B
* parentless B

after this patch:

* parentless A
  * child B
 /
* parentless B

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 graph.c                      | 115 ++++++++++++++++++++++++++++++--
 t/t4215-log-skewed-merges.sh | 124 +++++++++++++++++++++++++++++++++++
 2 files changed, 233 insertions(+), 6 deletions(-)

diff --git a/graph.c b/graph.c
index 26f6fbf000..97292df998 100644
--- a/graph.c
+++ b/graph.c
@@ -60,6 +60,12 @@ struct column {
 	 * index into column_colors.
 	 */
 	unsigned short color;
+	/*
+	 * A placeholder column keeps the column of a parentless commit filled
+	 * for one extra row, avoiding a next unrelated commit to be printed
+	 * in the same column.
+	 */
+	unsigned is_placeholder:1;
 };

 enum graph_state {
@@ -563,6 +569,7 @@ static void graph_insert_into_new_columns(struct git_graph *graph,
 		i = graph->num_new_columns++;
 		graph->new_columns[i].commit = commit;
 		graph->new_columns[i].color = graph_find_commit_color(graph, commit);
+		graph->new_columns[i].is_placeholder = 0;
 	}

 	if (graph->num_parents > 1 && idx > -1 && graph->merge_layout == -1) {
@@ -607,7 +614,7 @@ static void graph_update_columns(struct git_graph *graph)
 {
 	struct commit_list *parent;
 	int max_new_columns;
-	int i, seen_this, is_commit_in_columns;
+	int i, seen_this, is_commit_in_columns, is_parentless;

 	/*
 	 * Swap graph->columns with graph->new_columns
@@ -654,6 +661,26 @@ static void graph_update_columns(struct git_graph *graph)
 	 */
 	seen_this = 0;
 	is_commit_in_columns = 1;
+	/*
+	 * A commit is "parentless" (is a visual root that starts a new column)
+	 * only if has no visible parents AND it's not a boundary commit.
+	 *
+	 * Boundary commits also have no visible parents, but they are
+	 * NOT a visual root:
+	 *
+	 * 1. A boundary only appears in the output because an included commit
+	 *    is its child. Children are always above, and the renderer draws an
+	 *    edge down to the boundary from that child. Rather than starting
+	 *    a column like a visual root would do, it "inherits" its child
+	 *    column.
+	 *
+	 * 2. Included commit CAN'T appear below a boundary. Boundaries are
+	 *    ancestors of the exclusion point; if an included commit were an
+	 *    ancestor of the boundary it would be excluded and not rendered.
+	 *    Boundaries therefore always sink to the bottom.
+	 */
+	is_parentless = graph->num_parents == 0 &&
+			!(graph->commit->object.flags & BOUNDARY);
 	for (i = 0; i <= graph->num_columns; i++) {
 		struct commit *col_commit;
 		if (i == graph->num_columns) {
@@ -688,11 +715,46 @@ static void graph_update_columns(struct git_graph *graph)
 			 * least 2, even if it has no interesting parents.
 			 * The current commit always takes up at least 2
 			 * spaces.
+			 *
+			 * Check for the commit to seem like a root, no parents
+			 * rendered and that it is not a boundary commit. If so,
+			 * add a placeholder to keep that column filled for
+			 * at least one row.
+			 *
+			 * Prevents the next commit from being inserted
+			 * just below and making the graph confusing.
 			 */
-			if (graph->num_parents == 0)
+			if (is_parentless) {
+				graph_insert_into_new_columns(graph, graph->commit, i);
+				graph->new_columns[graph->num_new_columns - 1]
+							    .is_placeholder = 1;
+			} else if (graph->num_parents == 0) {
 				graph->width += 2;
+			}
 		} else {
-			graph_insert_into_new_columns(graph, col_commit, -1);
+			if (graph->columns[i].is_placeholder) {
+				/*
+				 * Keep the placeholders if the next commit is
+				 * parentless also, making the indentation cascade.
+				 */
+				if (!seen_this && is_parentless) {
+					graph_insert_into_new_columns(graph,
+							graph->columns[i].commit, i);
+					graph->new_columns[graph->num_new_columns - 1]
+							.is_placeholder = 1;
+				} else if (!seen_this) {
+					graph->mapping[graph->width] = -1;
+					graph->width += 2;
+				}
+				/*
+				 * seen_this && is_placeholder means that this
+				 * line is the one after the indented one, the
+				 * placeholder is no longer needed, gets
+				 * dropped and the columns collapses naturally.
+				 */
+			} else {
+				graph_insert_into_new_columns(graph, col_commit, -1);
+			}
 		}
 	}

@@ -846,7 +908,10 @@ static void graph_output_padding_line(struct git_graph *graph,
 	 * Output a padding row, that leaves all branch lines unchanged
 	 */
 	for (i = 0; i < graph->num_new_columns; i++) {
-		graph_line_write_column(line, &graph->new_columns[i], '|');
+		if (graph->new_columns[i].is_placeholder)
+			graph_line_write_column(line, &graph->new_columns[i], ' ');
+		else
+			graph_line_write_column(line, &graph->new_columns[i], '|');
 		graph_line_addch(line, ' ');
 	}
 }
@@ -1058,7 +1123,34 @@ static void graph_output_commit_line(struct git_graph *graph, struct graph_line
 			   graph->mapping[2 * i] < i) {
 			graph_line_write_column(line, col, '/');
 		} else {
-			graph_line_write_column(line, col, '|');
+			if (col->is_placeholder) {
+				/*
+				 * When the indented commit is a merge commit,
+				 * the placeholder column adds unwanted padding
+				 * between the commit and its subject.
+				 *
+				 *   * parentless commit
+				 *     * merge commit
+				 *    /|
+				 *   | * parent A
+				 *   *   parent B
+				 *     ^^ unwanted padding
+				 *
+				 * Once the current commit has been seen, don't
+				 * let placeholder columns to be rendered:
+				 *
+				 *   * parentless commit
+				 *     * merge commit
+				 *    /|
+				 *   | * parent A
+				 *   * parent B
+				 */
+				if (seen_this)
+					continue;
+				graph_line_write_column(line, col, ' ');
+			} else {
+				graph_line_write_column(line, col, '|');
+			}
 		}
 		graph_line_addch(line, ' ');
 	}
@@ -1135,7 +1227,18 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct graph_l
 				graph_line_write_column(line, col, '|');
 			graph_line_addch(line, ' ');
 		} else {
-			graph_line_write_column(line, col, '|');
+			if (col->is_placeholder) {
+				/*
+				 * Same placeholder handling as in
+				 * graph_output_commit_line().
+				 */
+				if (seen_this)
+					continue;
+				graph_line_write_column(line, col, ' ');
+			} else {
+				graph_line_write_column(line, col, '|');
+			}
+
 			if (graph->merge_layout != 0 || i != graph->commit_index - 1) {
 				if (parent_col)
 					graph_line_write_column(
diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
index 28d0779a8c..0f6f95a6b5 100755
--- a/t/t4215-log-skewed-merges.sh
+++ b/t/t4215-log-skewed-merges.sh
@@ -370,4 +370,128 @@ test_expect_success 'log --graph with multiple tips' '
 	EOF
 '

+test_expect_success 'log --graph with root commit' '
+	git checkout --orphan 8_1 && test_commit 8_A && test_commit 8_A1 &&
+	git checkout --orphan 8_2 && test_commit 8_B &&
+
+	check_graph 8_2 8_1 <<-\EOF
+	* 8_B
+	  * 8_A1
+	 /
+	* 8_A
+	EOF
+'
+
+test_expect_success 'log --graph with multiple root commits' '
+	test_commit 8_B1 &&
+	git checkout --orphan 8_3 && test_commit 8_C &&
+
+	check_graph 8_3 8_2 8_1 <<-\EOF
+	* 8_C
+	  * 8_B1
+	 /
+	* 8_B
+	  * 8_A1
+	 /
+	* 8_A
+	EOF
+'
+
+test_expect_success 'log --graph commit from a two parent merge shifted' '
+	git checkout --orphan 9_1 && test_commit 9_B &&
+	git checkout --orphan 9_2 && test_commit 9_C &&
+	git checkout 9_1 &&
+	git merge 9_2 --allow-unrelated-histories -m 9_M &&
+	git checkout --orphan 9_3 &&
+	test_commit 9_A && test_commit 9_A1 && test_commit 9_A2 &&
+
+	check_graph 9_3 9_1 <<-\EOF
+	* 9_A2
+	* 9_A1
+	* 9_A
+	  * 9_M
+	 /|
+	| * 9_C
+	* 9_B
+	EOF
+'
+
+test_expect_success 'log --graph commit from a three parent merge shifted' '
+	git checkout --orphan 10_1 && test_commit 10_B &&
+	git checkout --orphan 10_2 && test_commit 10_C &&
+	git checkout --orphan 10_3 && test_commit 10_D &&
+	git checkout 10_1 &&
+	TREE=$(git write-tree) &&
+	MERGE=$(git commit-tree $TREE -p 10_1 -p 10_2 -p 10_3 -m 10_M) &&
+	git reset --hard $MERGE &&
+	git checkout --orphan 10_4 &&
+	test_commit 10_A && test_commit 10_A1 && test_commit 10_A2 &&
+
+	check_graph 10_4 10_1 <<-\EOF
+	* 10_A2
+	* 10_A1
+	* 10_A
+	  *   10_M
+	 /|\
+	| | * 10_D
+	| * 10_C
+	* 10_B
+	EOF
+'
+
+test_expect_success 'log --graph commit from a four parent merge shifted' '
+	git checkout --orphan 11_1 && test_commit 11_B &&
+	git checkout --orphan 11_2 && test_commit 11_C &&
+	git checkout --orphan 11_3 && test_commit 11_D &&
+	git checkout --orphan 11_4 && test_commit 11_E &&
+	git checkout 11_1 &&
+	TREE=$(git write-tree) &&
+	MERGE=$(git commit-tree $TREE -p 11_1 -p 11_2 -p 11_3 -p 11_4 -m 11_M) &&
+	git reset --hard $MERGE &&
+	git checkout --orphan 11_5 &&
+	test_commit 11_A && test_commit 11_A1 && test_commit 11_A2 &&
+
+	check_graph 11_5 11_1 <<-\EOF
+	* 11_A2
+	* 11_A1
+	* 11_A
+	  *-.   11_M
+	 /|\ \
+	| | | * 11_E
+	| | * 11_D
+	| * 11_C
+	* 11_B
+	EOF
+'
+
+test_expect_success 'log --graph disconnected three roots cascading' '
+	git checkout --orphan 12_1 && test_commit 12_D && test_commit 12_D1 &&
+	git checkout --orphan 12_2 && test_commit 12_C &&
+	git checkout --orphan 12_3 && test_commit 12_B &&
+	git checkout --orphan 12_4 && test_commit 12_A &&
+
+	check_graph 12_4 12_3 12_2 12_1 <<-\EOF
+	* 12_A
+	  * 12_B
+	    * 12_C
+	      * 12_D1
+	   _ /
+	  /
+	 /
+	* 12_D
+	EOF
+'
+
+test_expect_success 'log --graph with excluded parent (not a root)' '
+	git checkout --orphan 13_1 && test_commit 13_X && test_commit 13_Y &&
+	git checkout --orphan 13_2 && test_commit 13_O && test_commit 13_A &&
+
+	check_graph 13_O..13_A 13_1 <<-\EOF
+	* 13_A
+	  * 13_Y
+	 /
+	* 13_X
+	EOF
+'
+
 test_done
--
2.43.0

