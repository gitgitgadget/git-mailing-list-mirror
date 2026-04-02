Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0572624BBF4
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 21:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775164647; cv=none; b=ToMS3SY5+2znvNQ8vHrOKj7tHxpQ91p9ftUQhcJuDN14O0jGcHrQsLMRDYIjx03NmbpWDOlYdJUwbNy+3jD7rfWkf85RWkon5hXBPAwkd/OyRmUzWAdP/c9P4M+ZdBRw7DaGwPx6gBoWqdgUNrQJQKcmW7QQoBcyCNy9stPIOx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775164647; c=relaxed/simple;
	bh=vxNQfxNidqkcYiECQraSEf5UPDENHnuYx8bVqsH7uT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jn1FJiB8wwbROGuti9CZ/CrCdnEj5mlIMGWbqzmV07CtN9kr8FaifVE52/+LJ2dHOmBKSIjDAYs20Kf4vaXklBMgQDt9HS3q51KI3ECkq1x0CkRQuapmIPeK68fWyiPjcb6Hhv9lmhxzmBsiOHdV0OPrV8N97RZIfcgtxzTPy20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NCvaKeE5; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCvaKeE5"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-486fb439299so11749605e9.0
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 14:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775164644; x=1775769444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFgd6d9j2J+cHuJU47XTQwVtcOxA35kK737tbJG0uJE=;
        b=NCvaKeE5f3jvQKO/0NPA5pBMmPKIMrAIWzmBMyavbpvY1Xn9CiFG6MCXn9UflDK3Oc
         CFHZjxmsAyC6xEq0DeE2wRL+LvAcG22BnHATGOj3FOtXkB4LC2gIgPLA4ZSS/Wga6PSk
         9/TdHi0NFMvA6J1bQ4dkmgDA60mRIln3fpkYf4bY2N8O4q9cIMfj0bqHkYDj7dHfvgfq
         nO3cPOshsZtK2CaDZB43kpPMFOw+yDoGAIGD1jpO8tdPXFImg9YXBRg09XRBm2a3qI9L
         QEJedwLgzeIA/qAhB4lj1xcX3D5EeYlzIR/edCkVlnDJ5aNqDaJUPhcc20zr33xIoKsM
         ZxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775164644; x=1775769444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZFgd6d9j2J+cHuJU47XTQwVtcOxA35kK737tbJG0uJE=;
        b=CLUMhg4JBvkwWQ3JDa0N7fJzKyJgx+hVlsEIYjv9yw75BmvGgvjzvo6HTg52vzSrrF
         c02vFb5TlsCu2rgZYyHdGejKiU8dHilYDFSMLKG7ETXN8QoGyJOdiqqZA9ZoHLq7kUbI
         WH5PRjrf2CNShUFUu21DpWWKwgBddED4LvaBflubGAGjynM9Kh9LZOGvwVQtZzo3jyLR
         ZsRZTeo5oQFcghXTCuJv7rZMb2+8F1LdOXVboiLejMI+0PM1XUFtMtGKMh1+Ujk4eAgt
         gPvH/RFW3Com8Dm3oOJado856MZNDxcdMBLS0E/Vsrxizz6Bq/S+ooKEdqUL6ggBYBZC
         bsFA==
X-Gm-Message-State: AOJu0YxvYK3Dnd4Gt6nmhIxNLehwa9/HeQtrXCnDfMhkGUjssZn9z8G7
	lC29nzYJPEwdwIh2uMWBOHixLGdlA8q+JLJZ4EcoLNEWmlNGN/Gtn0dPS8B4c2Lnct0=
X-Gm-Gg: ATEYQzyMMlfuTmt7NGHlsqdJ4BkbaEa9BlGQezmOpeRJGVqEX4Rj0xCc3QQTe+Bakto
	FgwyAgxXMuT3lsi2uSgFo1MoNJQAjAxUK5FMYVHszNVO/BI3MnRRh4ayNDmIgFzNLHY/KtzNrau
	fAAwLBYiS667pIgxF3+WOURmTELsTZqsvxf0CtTAMxSlb3HNTUv7eGl8YWutwla+L4nYrYDcM43
	a2z67Kt3Oy8BTQ1el22E05RpMnu+pF3G8Gcra/Da2gA853RwcafkxsyoedHqopA5S/e/QTtBLy8
	A0aJqdN+2vRSBCsKjhV3XgVNhFMvQDCi7e+i6nfy6RNsivHOtHfYRKXMKq0gwBXl87OSFwQZY9R
	ioeVqeH2Z2yEEW8q927WRVUR/UtM6vIRjxJtvEK6lvaZzBdEY5ao9znyBWPJkPX0kCUjTQjZHiE
	5z5IdCuuVUm5m7VudknYeWgKlwIEsLHMf0/TLzrBqqjtcs6mj5YRyS6x+sJnax6ssjP0WCF+64z
	+Iiunn4zDDs3F73biHidygeQIABDA9x4jywYWQ7ZFRl+xQV3oXONhSJwuXSSqK+jb9f
X-Received: by 2002:a05:600d:8454:b0:480:1e40:3d2 with SMTP id 5b1f17b1804b1-488998e39a9mr5105465e9.29.1775164644010;
        Thu, 02 Apr 2026 14:17:24 -0700 (PDT)
Received: from farblopa.localdomain ([84.126.0.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48899d1b12bsm3893915e9.5.2026.04.02.14.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 14:17:22 -0700 (PDT)
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
Subject: [GSoC RFC PATCH 1/1] graph: add indentation for commits preceded by a root
Date: Thu,  2 Apr 2026 23:17:17 +0200
Message-ID: <20260402211717.3604688-2-pabloosabaterr@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402211717.3604688-1-pabloosabaterr@gmail.com>
References: <20260402211717.3604688-1-pabloosabaterr@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When having a history with multiple root commits and
drawing the history near the roots the graphing engine
renders the commit one below the other, seeming that
they are related.

This issue was reported by Junio at:
  https://lore.kernel.org/git/xmqqikaawrpx.fsf@gitster.g/

This happens because the root has no parents thus
for the next row printing, the column becomes free
and the engine prints from the first free columns
left to right.

Keep the root commit at least one row more to avoid
having the column empty but hide it, therefore
making the next unrelated commit to live in the next
column (column means even positions where edges live:
0, 2, 4), then clean that "placeholder" column and let
the unrelated commit to naturally collapse to the column
where the root commit was.

Add is_placeholder to the struct column to mark if a column
is acting as a placeholder for the padding.

When the column is a root, add a column with the root
commit data to prevent segfaults when 'column->commit' and
mark it as a placeholder.

After, unless the next commit is also a root (then we
need to keep cascading the indentation) clean the mapping
and the columns from the placeholder to allow it to
collapse naturally.

Teach rendering functions to print a padding
' ' when a placeholder column is met.

Add tests for different cases.

before this patch:

* root-B
* child-A2
* child-A1
* root-A

after this patch:

* root-B
  * child-A2
 /
* child-A1
* root-A

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 graph.c                      |  68 ++++++++++++++++--
 t/t4215-log-skewed-merges.sh | 136 +++++++++++++++++++++++++++++++++++
 2 files changed, 198 insertions(+), 6 deletions(-)

diff --git a/graph.c b/graph.c
index 26f6fbf000..736c4a0a0c 100644
--- a/graph.c
+++ b/graph.c
@@ -60,6 +60,13 @@ struct column {
 	 * index into column_colors.
 	 */
 	unsigned short color;
+	/*
+	 * A placeholder column keeps the column of the root filled for one
+	 * extra row, avoiding a next unrelated commit to be printed in the
+	 * same column. Placeholder columns don't propagate to the following
+	 * commit.
+	 */
+	unsigned is_placeholder:1;
 };
 
 enum graph_state {
@@ -563,6 +570,7 @@ static void graph_insert_into_new_columns(struct git_graph *graph,
 		i = graph->num_new_columns++;
 		graph->new_columns[i].commit = commit;
 		graph->new_columns[i].color = graph_find_commit_color(graph, commit);
+		graph->new_columns[i].is_placeholder = 0;
 	}
 
 	if (graph->num_parents > 1 && idx > -1 && graph->merge_layout == -1) {
@@ -607,7 +615,7 @@ static void graph_update_columns(struct git_graph *graph)
 {
 	struct commit_list *parent;
 	int max_new_columns;
-	int i, seen_this, is_commit_in_columns;
+	int i, seen_this, is_commit_in_columns, is_root;
 
 	/*
 	 * Swap graph->columns with graph->new_columns
@@ -654,6 +662,9 @@ static void graph_update_columns(struct git_graph *graph)
 	 */
 	seen_this = 0;
 	is_commit_in_columns = 1;
+	is_root = graph->num_parents == 0 &&
+		  !graph->commit->parents &&
+		  !(graph->commit->object.flags & BOUNDARY);
 	for (i = 0; i <= graph->num_columns; i++) {
 		struct commit *col_commit;
 		if (i == graph->num_columns) {
@@ -688,11 +699,40 @@ static void graph_update_columns(struct git_graph *graph)
 			 * least 2, even if it has no interesting parents.
 			 * The current commit always takes up at least 2
 			 * spaces.
+			 *
+			 * Check for the commit to be a root, no parents
+			 * and that it is not a boundary commit. If so, add a
+			 * placeholder to keep that column filled for
+			 * at least one row.
+			 *
+			 * Prevents the next commit from being inserted
+			 * just below and making the graph confusing.
 			 */
-			if (graph->num_parents == 0)
+			if (is_root) {
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
+				 * a root also, making the indentation cascade.
+				 */
+				if (!seen_this && is_root) {
+					graph_insert_into_new_columns(graph,
+							graph->columns[i].commit, i);
+					graph->new_columns[graph->num_new_columns - 1]
+							.is_placeholder = 1;
+				} else if (!seen_this) {
+					graph->mapping[graph->width] = -1;
+					graph->width += 2;
+				}
+			} else {
+				graph_insert_into_new_columns(graph, col_commit, -1);
+			}
 		}
 	}
 
@@ -846,7 +886,10 @@ static void graph_output_padding_line(struct git_graph *graph,
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
@@ -1058,7 +1101,13 @@ static void graph_output_commit_line(struct git_graph *graph, struct graph_line
 			   graph->mapping[2 * i] < i) {
 			graph_line_write_column(line, col, '/');
 		} else {
-			graph_line_write_column(line, col, '|');
+			if (col->is_placeholder) {
+				if (seen_this)
+					continue;
+				graph_line_write_column(line, col, ' ');
+			} else {
+				graph_line_write_column(line, col, '|');
+			}
 		}
 		graph_line_addch(line, ' ');
 	}
@@ -1135,7 +1184,14 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct graph_l
 				graph_line_write_column(line, col, '|');
 			graph_line_addch(line, ' ');
 		} else {
-			graph_line_write_column(line, col, '|');
+			if (col->is_placeholder) {
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
index 28d0779a8c..0333fea95a 100755
--- a/t/t4215-log-skewed-merges.sh
+++ b/t/t4215-log-skewed-merges.sh
@@ -370,4 +370,140 @@ test_expect_success 'log --graph with multiple tips' '
 	EOF
 '
 
+test_expect_success 'log --graph with root commit' '
+	git checkout --orphan 8_a &&
+	test_commit 8_A &&
+	test_commit 8_A1 &&
+	git checkout --orphan 8_b &&
+	test_commit 8_B &&
+
+	check_graph 8_b 8_a <<-\EOF
+	* 8_B
+	  * 8_A1
+	 /
+	* 8_A
+	EOF
+'
+
+test_expect_success 'log --graph with multiple root commits' '
+	test_commit 8_B1 &&
+	git checkout --orphan 8_c &&
+	test_commit 8_C &&
+
+	check_graph 8_c 8_b 8_a <<-\EOF
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
+	git checkout --orphan 9_b &&
+	test_commit 9_B &&
+	git checkout --orphan 9_c &&
+	test_commit 9_C &&
+	git checkout 9_b &&
+	git merge 9_c --allow-unrelated-histories -m 9_M &&
+	git checkout --orphan 9_a &&
+	test_commit 9_A &&
+	test_commit 9_A1 &&
+	test_commit 9_A2 &&
+
+	check_graph 9_a 9_b <<-\EOF
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
+	git checkout --orphan 10_b &&
+	test_commit 10_B &&
+	git checkout --orphan 10_c &&
+	test_commit 10_C &&
+	git checkout --orphan 10_d &&
+	test_commit 10_D &&
+	git checkout 10_b &&
+	TREE=$(git write-tree) &&
+	MERGE=$(git commit-tree $TREE -p 10_b -p 10_c -p 10_d -m 10_M) &&
+	git reset --hard $MERGE &&
+	git checkout --orphan 10_a &&
+	test_commit 10_A &&
+	test_commit 10_A1 &&
+	test_commit 10_A2 &&
+
+	check_graph 10_a 10_b <<-\EOF
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
+	git checkout --orphan 11_b &&
+	test_commit 11_B &&
+	git checkout --orphan 11_c &&
+	test_commit 11_C &&
+	git checkout --orphan 11_d &&
+	test_commit 11_D &&
+	git checkout --orphan 11_e &&
+	test_commit 11_E &&
+	git checkout 11_b &&
+	TREE=$(git write-tree) &&
+	MERGE=$(git commit-tree $TREE -p 11_b -p 11_c -p 11_d -p 11_e -m 11_M) &&
+	git reset --hard $MERGE &&
+	git checkout --orphan 11_a &&
+	test_commit 11_A &&
+	test_commit 11_A1 &&
+	test_commit 11_A2 &&
+
+	check_graph 11_a 11_b <<-\EOF
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
+	git checkout --orphan 12_d &&
+	test_commit 12_D &&
+	test_commit 12_D1 &&
+	git checkout --orphan 12_c &&
+	test_commit 12_C &&
+	git checkout --orphan 12_b &&
+	test_commit 12_B &&
+	git checkout --orphan 12_a &&
+	test_commit 12_A &&
+
+	check_graph 12_a 12_b 12_c 12_d <<-\EOF
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
 test_done
-- 
2.43.0

