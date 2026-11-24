Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795543562;
	b=OAyT2vJ3d5c9mVOty3efIgrJL0oduBxXQXfc5+4hWbkGhIyvGuAH3PRKQAWmCjC/rmIG
	 w1OdxWzkGJZ/H1e2FZa8b5tDj973rfg3Bzl7l1eqZoV8+jz81A6sbXn2L9v1HxrtSXQ6r
	 sWaC+2YySTbU1p+u/CPPE6hpc8/mHcS7qjIE4V6/CtZy0Z0anW/tvkd/yI161cCAbOT9F
	 jTWi4vAO9xKs6fRdEwolAoT6gFq2DJ0TUMtrSyJUGp9f7rIhxtu40XsQAeKlJLZB5sVbZ
	 p3+DkO7V8iqB5b6cD2CIaQwOcTuG/gpkhN4SDs9Lt4qN9Qk4yC3xgl7+GJiSf2akNiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795543562;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=+wVhsUKh2ha8ONgvzWvGq3LaO8Rkz+zM7QYuETKLFTA=;
	b=EbC3js+TN2GixWRxBmW43zBOqNEUwFMsjdYFZQq/RvitNxtCPDBXAcgeics4jrNhX3Mt
	 JcaPXRNyhtH0I6hl4LVakrHOnOdz4ZHvHc+LoAKymjI+HD6IY6IGNOEu8t6Pjci3LtHTv
	 eEv9hG6lqSkmFGeTkMxYRr0YVJ4V0D4CvMSzbzudfC1sQEKYJMx2/ISmyRaH3i0kSHqi5
	 u9yBtxqlhQRGnnYJWYMMqE1uhyzzap6JuZx49CqTQLBZYa4KmWctLaykp84JhL+I/UJxN
	 zrZH7PMm23UECBksSeRvvc8yiFQYClJFRw+2TtsrieV2sWumjYuYi8jORd+xutjfZ5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nhcJrugm;
	arc=none smtp.remote-ip=209.85.221.71
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AC0606A33F
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 18:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53AC0606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nhcJrugm
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48e00f3929bso2947042f8f.0
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 10:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795543561; x=1796148361; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+wVhsUKh2ha8ONgvzWvGq3LaO8Rkz+zM7QYuETKLFTA=;
        b=nhcJrugmJf5tRPWBHGynrpK+sh3vZTfQewvtOOmALTVNzIlbuNjiZBwS1G+1ZvvMyS
         rYb3+hRydJLw7CIULsh5wGmyx8t8Fth1J5+7NDk1p/HOn47UAX8uayXL/g2BbxGB1dkJ
         0GeEEO1K0X6Ue6YO+jTrbq+n4s2hfVyykFYdlF2qoZapEzGj0jm4yJ8JEBz7MiTpwubd
         HBIbkq5rTg/ztK/OKfLsw7XCH3CUT0AZlq8wrwUMczoL3xVQaMWAnyFESMBp16iHzQbH
         Q/DcTl8RsctoVTkXhA6zoFBAQW6PSfHnOaf87609VsZ+5OsHMaBgUGJ8zLSfUunGb4YM
         MXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795543561; x=1796148361;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+wVhsUKh2ha8ONgvzWvGq3LaO8Rkz+zM7QYuETKLFTA=;
        b=NPSBQC2EZ38RokRsL/sx8RfsUOrx2pHbbldhoYSQgRo0mzjdwgsfw98Gt3JORfOqgu
         C4JcrH61INL5zU+qxcg9f0oRtAMJu3OZrAT0Y7AW/WSZZYqiN//QCu2MowBkbTppTOAc
         joFzC2+pK4t3lEd7aCW2k6I2mCt4ZGf5y/j12XccXc6rEzxIDG/pYTsJujPm7vpwVGrU
         jcOCmXR6i+5iWnDGuw1adLivaifYwKt4/8JWNd89Hh7WVHnD5PBWz9R2WNvtA+HKVlfc
         ZhRXVmqsEIGV8Dcb7+D6/UdF2qQIzZtKRF5GUfOt0Y57kFfT81YZClW0ce5PbX+EY/S/
         nMyQ==
X-Gm-Message-State: APuU4Z8j2FE3DVFdbLKhn2unPWQeqCNU9d2+DzMA7Dyaxp0AIGtgz6fN
	c3UNFBzRazNm17iuYQxBLEmGrxW9T+xL4ixzD8ToaI2zOTCuUk/F0oly1lODzar/hLC82qAdC7S
	x9NGm0hHmEKylbdOS/RAxIZ9ny7jwFrElV9Xo8WU2q6ChKMsQ3jagCOUFFREa6L+fchhFumJ/Rg
	m/UbhHHGBcUDhKS0SfdKETRg==
X-Received: from wrmj17.prod.google.com ([2002:adf:e511:0:b0:4a3:d052:79d8])
 (user=dmnk job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:37c6:b0:4a1:88df:8a2a
 with SMTP id 5b1f17b1804b1-4bb88812a84mr316096795e9.13.1795543558699; Tue, 24
 Nov 2026 10:05:58 -0800 (PST)
Date: Tue, 24 Nov 2026 18:05:57 +0000
In-Reply-To: <20261119192247.2671852-1-dmnk@google.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261119192247.2671852-1-dmnk@google.com>
X-Mailer: git-send-email 2.56.1.663.g77904e546d
Message-ID: <20261124180557.70212-1-dmnk@google.com>
Subject: [PATCH v2] graph: do not fuse merge parents with the column to their left
From: Dominik Maier <dmnk@google.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Caspar Duregger <caspar.duregger@gmail.com>, 
	Pablo Sabater <pabloosabaterr@gmail.com>, dmnk+artist@google.com
Content-Type: text/plain; charset="UTF-8"

When a merge is skewed to the left and its second parent is the column
right next to it, the edge to that parent is lost:

	| | * M                | | *   M
	| |/|\                 | |/|\
	|/| |         =>       |/|/ /
	| | * C                | | * C

With four or more parents it gets worse: the remaining parents shift
one slot too far left, leaving the last dashed-parent entry in
graph->mapping[] at -1 and reading before graph->new_columns[0] in
graph_draw_octopus_merge().

graph_insert_into_new_columns() has a shortcut that lets a column to
the right of a merge join the merge's last edge right away ("|\|").
It compares against the last edge added so far. For a left-skewed
merge, the first parent does not add an edge, so when the second parent
comes up, that "last edge" is the column to the left of the merge, and
the shortcut swallows the parent's own edge.

Only take the shortcut for existing non-parent columns (idx < 0), which
is the case it was written for.

Helped-by: Caspar Duregger <caspar.duregger@gmail.com>
Signed-off-by: Dominik Maier <dmnk@google.com>
---
Changes in v2:
- Reword commit message to show the 3-parent missing-edge case alongside
  the 4+-parent out-of-bounds read, add the 3-parent test, and drop the
  extra BUG() in graph_draw_octopus_merge() (Caspar Duregger).

 graph.c                      |  3 ++-
 t/t4215-log-skewed-merges.sh | 52 ++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/graph.c b/graph.c
index 95eef3a95e..c55b1fb5aa 100644
--- a/graph.c
+++ b/graph.c
@@ -685,7 +685,8 @@ static void graph_insert_into_new_columns(struct git_graph *graph,
 		mapping_idx = graph->width + (graph->merge_layout - 1) * shift;
 		graph->width += 2 * graph->merge_layout;
 
-	} else if (graph->edges_added > 0 && i == graph->mapping[graph->width - 2]) {
+	} else if (idx < 0 && graph->edges_added > 0 &&
+		   i == graph->mapping[graph->width - 2]) {
 		/*
 		 * If some columns have been added by a merge, but this commit
 		 * was found in the last existing column, then adjust the
diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
index eebab71039..359383a8ad 100755
--- a/t/t4215-log-skewed-merges.sh
+++ b/t/t4215-log-skewed-merges.sh
@@ -509,4 +509,56 @@ test_expect_success 'log --graph --graph-lane-limit=7 check if it shows all 3 pa
 	EOF
 '
 
+test_expect_success 'log --graph with left-skewed merge into its left neighbor' '
+	git checkout --orphan 8_p &&
+	test_commit 8_root &&
+	git checkout -b 8_pA 8_p && test_commit 8_A &&
+	git checkout -b 8_pB 8_p && test_commit 8_B &&
+	git checkout -b 8_pC 8_p && test_commit 8_C &&
+	TREE=$(git write-tree) &&
+	test_tick &&
+	M=$(git commit-tree $TREE -p 8_pA -p 8_pB -p 8_pC -m 8_M) &&
+	test_tick &&
+	TOP=$(git commit-tree $TREE -p 8_pA -p 8_pB -p $M -m 8_TOP) &&
+
+	lib_test_check_graph $TOP <<-\EOF
+	*-.   8_TOP
+	|\ \
+	| | *   8_M
+	| |/|\
+	|/|/ /
+	| | * 8_C
+	| * | 8_B
+	| |/
+	* / 8_A
+	|/
+	* 8_root
+	EOF
+'
+
+test_expect_success 'log --graph with left-skewed 4-parent octopus into left neighbor' '
+	git checkout -b 8_pD 8_p && test_commit 8_D &&
+	TREE=$(git write-tree) &&
+	test_tick &&
+	M4=$(git commit-tree $TREE -p 8_pA -p 8_pB -p 8_pC -p 8_pD -m 8_M4) &&
+	test_tick &&
+	TOP4=$(git commit-tree $TREE -p 8_pA -p 8_pB -p $M4 -m 8_TOP4) &&
+
+	lib_test_check_graph $TOP4 <<-\EOF
+	*-.   8_TOP4
+	|\ \
+	| | *-.   8_M4
+	| |/|\ \
+	|/|/ / /
+	| | | * 8_D
+	| | * | 8_C
+	| | |/
+	| * / 8_B
+	| |/
+	* / 8_A
+	|/
+	* 8_root
+	EOF
+'
+
 test_done

Range-diff against v1:
1:  e28b8150c7 ! 1:  a2e27b8fa9 graph: do not fuse merge parents into left columns
    @@ Metadata
     Author: Dominik Maier <dmnk@google.com>
     
      ## Commit message ##
    -    graph: do not fuse merge parents into left columns
    +    graph: do not fuse merge parents with the column to their left
     
    -    In graph_insert_into_new_columns(), the branch that coalesces a column
    -    into graph->mapping[graph->width - 2] and resets graph->edges_added = -1
    -    is intended for existing columns to the right of a merge commit
    -    (idx < 0) so that two adjacent edges can join immediately as "|\|".
    +    When a merge is skewed to the left and its second parent is the column
    +    right next to it, the edge to that parent is lost:
     
    -    When a merge commit itself is skewed left (merge_layout == 0), its first
    -    parent does not advance graph->width, leaving graph->width - 2 pointing
    -    at the column immediately to the left of the merge commit. If the second
    -    parent of a 4+-parent octopus merge matches that column while idx >= 0,
    -    it overwrites graph->mapping[graph->width - 2] without advancing
    -    graph->width and resets graph->edges_added = -1. Subsequent parents are
    -    placed one slot too far left, leaving the last dashed-parent slot in
    -    graph->mapping[] at -1 and indexing graph->new_columns[-1] in
    -    graph_draw_octopus_merge().
    +            | | * M                | | *   M
    +            | |/|\                 | |/|\
    +            |/| |         =>       |/|/ /
    +            | | * C                | | * C
     
    -    Restrict the right-neighbor edge fusion to existing non-merge columns
    -    (idx < 0) and guard against negative mapping indices in
    +    With four or more parents it gets worse: the remaining parents shift
    +    one slot too far left, leaving the last dashed-parent entry in
    +    graph->mapping[] at -1 and reading before graph->new_columns[0] in
         graph_draw_octopus_merge().
     
    +    graph_insert_into_new_columns() has a shortcut that lets a column to
    +    the right of a merge join the merge's last edge right away ("|\|").
    +    It compares against the last edge added so far. For a left-skewed
    +    merge, the first parent does not add an edge, so when the second parent
    +    comes up, that "last edge" is the column to the left of the merge, and
    +    the shortcut swallows the parent's own edge.
    +
    +    Only take the shortcut for existing non-parent columns (idx < 0), which
    +    is the case it was written for.
    +
    +    Helped-by: Caspar Duregger <caspar.duregger@gmail.com>
         Signed-off-by: Dominik Maier <dmnk@google.com>
     
      ## graph.c ##
    @@ graph.c: static void graph_insert_into_new_columns(struct git_graph *graph,
      		/*
      		 * If some columns have been added by a merge, but this commit
      		 * was found in the last existing column, then adjust the
    -@@ graph.c: static void graph_draw_octopus_merge(struct git_graph *graph, struct graph_line
    - 
    - 	for (i = 0; i < dashed_parents; i++) {
    - 		j = graph->mapping[(graph->commit_index + i + 2) * 2];
    -+		if (j < 0)
    -+			BUG("octopus merge mapping uninitialized");
    - 		col = &graph->new_columns[j];
    - 
    - 		graph_line_write_column(line, col, '-');
     
      ## t/t4215-log-skewed-merges.sh ##
     @@ t/t4215-log-skewed-merges.sh: test_expect_success 'log --graph --graph-lane-limit=7 check if it shows all 3 pa
      	EOF
      '
      
    -+test_expect_success 'log --graph left-skewed 4-parent octopus merge joining adjacent left column' '
    ++test_expect_success 'log --graph with left-skewed merge into its left neighbor' '
     +	git checkout --orphan 8_p &&
     +	test_commit 8_root &&
     +	git checkout -b 8_pA 8_p && test_commit 8_A &&
     +	git checkout -b 8_pB 8_p && test_commit 8_B &&
     +	git checkout -b 8_pC 8_p && test_commit 8_C &&
    -+	git checkout -b 8_pD 8_p && test_commit 8_D &&
    -+	git checkout -b 8_M 8_pA &&
    -+	git merge --no-ff 8_pB 8_pC 8_pD -m 8_M &&
    -+	git checkout 8_pB && test_commit 8_B2 &&
    -+	git checkout -b 8_TOP 8_pA &&
    -+	git merge --no-ff 8_pB 8_M -m 8_TOP &&
    ++	TREE=$(git write-tree) &&
    ++	test_tick &&
    ++	M=$(git commit-tree $TREE -p 8_pA -p 8_pB -p 8_pC -m 8_M) &&
    ++	test_tick &&
    ++	TOP=$(git commit-tree $TREE -p 8_pA -p 8_pB -p $M -m 8_TOP) &&
     +
    -+	lib_test_check_graph --date-order 8_TOP <<-\EOF
    ++	lib_test_check_graph $TOP <<-\EOF
     +	*-.   8_TOP
     +	|\ \
    -+	| * | 8_B2
    -+	| | *-.   8_M
    ++	| | *   8_M
    ++	| |/|\
    ++	|/|/ /
    ++	| | * 8_C
    ++	| * | 8_B
    ++	| |/
    ++	* / 8_A
    ++	|/
    ++	* 8_root
    ++	EOF
    ++'
    ++
    ++test_expect_success 'log --graph with left-skewed 4-parent octopus into left neighbor' '
    ++	git checkout -b 8_pD 8_p && test_commit 8_D &&
    ++	TREE=$(git write-tree) &&
    ++	test_tick &&
    ++	M4=$(git commit-tree $TREE -p 8_pA -p 8_pB -p 8_pC -p 8_pD -m 8_M4) &&
    ++	test_tick &&
    ++	TOP4=$(git commit-tree $TREE -p 8_pA -p 8_pB -p $M4 -m 8_TOP4) &&
    ++
    ++	lib_test_check_graph $TOP4 <<-\EOF
    ++	*-.   8_TOP4
    ++	|\ \
    ++	| | *-.   8_M4
     +	| |/|\ \
     +	|/|/ / /
     +	| | | * 8_D
-- 
2.56.1.831.g720f3f5937-goog

