Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA761390219
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 09:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775294675; cv=none; b=OvuLKOmPJVs7MiuuhIHRfX9ShwNJewSS0Mk1JFbcIssQatDhxwJMiYJWayuXYbyVACvPgy15sCVE62UTruLkku6ttWviVlNRiq5VqM955riFcmdweu4PRuuR960R60rR654vS8qhvaKERfH8yvvXN5+3UxmWmKoP8M1Vi1fSDzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775294675; c=relaxed/simple;
	bh=VcacbKh9o151ljo3FiVnMs8DItul7ckh8QYcArLXAQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bWXHJzbKgBJ0NQpDIPkeiLpEBj0rxwMp0EZfUXFX3kbm3hBep2uINlST0QcSuejPokatfZn7HhSORQayX5q90XBejhCAoIY4NPIoxlp6CEQFXYhoqhG5kotzmKLeAU2/BOZ62j+r5DMnv2FN85uHzw56tJjyHd+Gh4gR659caBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lz2jL50P; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lz2jL50P"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43d03db7f87so1364145f8f.3
        for <git@vger.kernel.org>; Sat, 04 Apr 2026 02:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775294671; x=1775899471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYhvdRQrN2q8nAfJnt+AMgjafPCbtVA6rU2HAk2C3ik=;
        b=lz2jL50PDz4qUiXoi0WS0O8mxQ47q766B8j5qtkbZ8eBZI1h8FQkEEoR95Nk7F3Q0U
         35QUVmcNAHw+9X19yODxcq2QLmwcftI8rh7myNGezp0ylq9yb5kmJuZqVFStUzt4WfBW
         vbRxY1ABUzVsj7iSMvuFfbMb3O297gWadQMQ4Sks4cvYC9Gnq6SsCFJ40AxuuuucRsOW
         ItMWaMsay7JYlH7PAHvk3Vz7JGLbPwSFW0k8LY0t0NsGGtgtEU+xtfAhv9Rz6D+FhQjq
         4l6X/IJuhljPgos+6o7rtcmPZYKFiaWDWKsSqe0PmXP9sQaAq+V2SjTVS54TQXaq1vdL
         zExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775294671; x=1775899471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AYhvdRQrN2q8nAfJnt+AMgjafPCbtVA6rU2HAk2C3ik=;
        b=GSnYfPWpCnRHNEy0ALkboG3lIzqNzHyLdGK0ZNC/jWwelkKoWlv7niT8Il6H204IIY
         DNEd/FiHtLRlfntcUfIFbXnPatws+iRArCQmPzpJ4hlVE3lk8P7UDUA18hwNCQBJyNci
         OdFTNTSbh8ly6KmibLpC9Wuv3xNCe40jHyy7mdKgjlR5iHVtoVXxA1yal4cPCw9PERIe
         FX4tCSMWcmCfTGa9474VsDsw80g6PaP3uRzkZ7N7YEaRHSAB7hsrv5s/VrdctbvJjGDD
         wEqtBe5po9L8URSp8d9bMdpi5VsdsS63ha1O5xLKI7UHqUYaPSerkdzO6FWaTgcDRwB3
         y7+A==
X-Gm-Message-State: AOJu0Ywdcb43yuIQ/HKNTr/P11GzvdxjMRcD0e/VMv2GoXDI2FCdCNvp
	AYVRH/5pvg+j8vrVhHbHKmzoXHg8rZ8XambW9cc0y2jcPlof504us+hIZisDtSNAOxU=
X-Gm-Gg: AeBDiev/9D3jCWvZ78pabg6iTujy6e7hNKJTU1jwdDVs1ziWp/bFOt/aGVpGIAolEZW
	Ib1VN0/EipDuBtM2NdQCEKwesOsSzTpzuYGIzZiG8RAlgvLVt1QBmHqlTN5JeZ1K55Jh8lK2FXZ
	n1ZLUZgc2RsLqYaUALagMaxRxPYkgELB/7WJyFQNNfOYdWlnDLCj251yPrmx2eMAEDQp6ksCp26
	C+CtIQCGOrjCPTgZDgXaLSlRg0jOsKjKllo8vekFZxezF2tAKZ6Jn01xZPxigBjXBt2R2Zphd+H
	upamc8SqrgDVqaCCFfR6iQpNFtvg89tixwmLfLExcurLyo0Syt+mcxkRkZE+Gxx5jJXc7pR0kh3
	aCnWemTJMpOH9nCDPZkRFTkKsKoPgB3R1E59nN7Bhaqtlsg6FCVzdDA40x+C1+6Nkw9ngRWntUP
	+82Cz95NUEPqW2cbmfiYl76DhI88YMeCBslxb29Bk+GR1ca5pjsTJr4GlZdDA0odPz0+O+YYHw7
	fSxPy+kQjy0rkotdQT5eJYrDTcEvc/RVurH9u+xKvNvmQfPRXynFv7B0g==
X-Received: by 2002:a05:6000:4313:b0:439:c040:cc8a with SMTP id ffacd0b85a97d-43d292e43d7mr10024426f8f.32.1775294670741;
        Sat, 04 Apr 2026 02:24:30 -0700 (PDT)
Received: from farblopa.localdomain ([84.126.0.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4f1a99sm25488813f8f.32.2026.04.04.02.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 02:24:30 -0700 (PDT)
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
Subject: [GSoC RFC PATCH v2 1/1] graph: add indentation for commits preceded by a parentless commit
Date: Sat,  4 Apr 2026 11:24:25 +0200
Message-ID: <20260404092425.550346-2-pabloosabaterr@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260404092425.550346-1-pabloosabaterr@gmail.com>
References: <20260402211717.3604688-1-pabloosabaterr@gmail.com>
 <20260404092425.550346-1-pabloosabaterr@gmail.com>
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

* parentless-B
* child-A2
* child-A1
* parentless-A

after this patch:

* parentless-B
  * child-A2
 /
* child-A1
* parentless-A

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 graph.c                      |  70 ++++++++++++++++++--
 t/t4215-log-skewed-merges.sh | 124 +++++++++++++++++++++++++++++++++++
 2 files changed, 188 insertions(+), 6 deletions(-)

diff --git a/graph.c b/graph.c
index 26f6fbf000..e2b7516651 100644
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
+	int i, seen_this, is_commit_in_columns, seems_root;
 
 	/*
 	 * Swap graph->columns with graph->new_columns
@@ -654,6 +661,12 @@ static void graph_update_columns(struct git_graph *graph)
 	 */
 	seen_this = 0;
 	is_commit_in_columns = 1;
+	/*
+	 * num_parents == 0 means that there are no parents flagged as
+	 * interesting to being shown.
+	 */
+	seems_root = graph->num_parents == 0 &&
+		     !(graph->commit->object.flags & BOUNDARY);
 	for (i = 0; i <= graph->num_columns; i++) {
 		struct commit *col_commit;
 		if (i == graph->num_columns) {
@@ -688,11 +701,40 @@ static void graph_update_columns(struct git_graph *graph)
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
+			if (seems_root) {
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
+				if (!seen_this && seems_root) {
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
 
@@ -846,7 +888,10 @@ static void graph_output_padding_line(struct git_graph *graph,
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
@@ -1058,7 +1103,13 @@ static void graph_output_commit_line(struct git_graph *graph, struct graph_line
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
@@ -1135,7 +1186,14 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct graph_l
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

