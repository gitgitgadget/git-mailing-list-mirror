Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795599505;
	b=RqMF8CX4DbxaXxF6oFlSmZ0BuycTtNyEGlzlhzUlBHiqJilediCz4WNwbok9SWfJpFmH
	 YxTNRI4x9Oy0fHoDqKATZvb2aD9v6g1MF/5y00ZRNXEgNdwpqu0gryyz02p08W1J2GEIY
	 aFY8qxzfVPzntL//oKJkY8X15ucYca3JcQjhGmbF0oYdZp4nb6iztUlYnbxS4H4JFMjfA
	 vr/h2Kdc/9kEzI5oX0R/B5Ybw3aksmNy4iPt3k9H3C8h/qDnuu7JxXM7TvrW6Dgl8+fD7
	 RnK6zgYHfstubuhGb9OyE48UxibFE8unAqHi2DDX6Hej1h2jhZflez6lHfHifBH0Fdg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795599505;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=KrmPaIBrHPa/qQQAa30z7wwsH4vDjRzQJqmEhC0eSHk=;
	b=NbO1Jrf3qxy39SylJ1KfrhMCEsUwZYEZLwPAf+NRtiViA96Z0yDbGhn5TfvUJ79xIDpK
	 PKklIycRWLLuUTvLvDMskUEuGc1zyfnPfjkaL+IuVHTKUQZLuJdAjhsNN0RB5dt0rNhP7
	 PM1QBKdZHh0mUvsSaTnMVAp+vFpdp2NgKqCDCL5lg75qonzweZ6vztxCXPkAxbbZc1166
	 Pki/JWP+YzXD5JPBJtKpZwVccXuXRznwZLxkgFM9aKuQuShYRxQjongnY7FNDVNmEqbbF
	 3qmzlrm7Haq8F5vm+Bgr60at6enhXMFnzYfmD7kiFDgUuH0QCJpjEtKIIrRtcZvce1w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dWJ+0k9C;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.173
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9844D606A321
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 09:38:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9844D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dWJ+0k9C
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5eac01ff101so2007226e0c.2
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 01:38:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795599503; cv=none;
        d=google.com; s=arc-20260327;
        b=kLYsFNt+ZZDmdH3zZlTPJ9pj4KYaXN+iweVPjqSN/49sJ/7BbEl6Bh323oLlunpPXQ
         bLZbU64BGwfkfPxrtPOmb8hkly/cSWCzraIebO/6OeD0RNP91QpMg95jbCfIE6Ov1H9B
         npQbXguuSjEWLxhf+Z92pkx8scDgyDoq5+w+TdHFBFw+UOhaq91G/54v14nVlLtnM+r/
         F6bx9xpyygYc+MLiNrbJOn/bIlPb/Q1QD7qq/wiPdp2TPOHnyUHxkfnbNCUyJcKDEP5A
         KoI7NNaD6kewDZjs4Gl3pe+NLeXUG2jtK1H41bPslaAw/Nqe6Om5Wa5hqpvucQXDZHo4
         Pj2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KrmPaIBrHPa/qQQAa30z7wwsH4vDjRzQJqmEhC0eSHk=;
        fh=EuzTZeHClKMU1eF+pSgnKtda53qXUr4g9Wi36cauPto=;
        b=VYUKKkOFLDGz9H1Nym/ZUMwNa2G4j6OPHrK7/Rs00sUgcaDlEgvEJ8bUGbI8bP5Jbp
         xDnV3jRi92zHCJ0XtUeYjDh1UISpwnncilHE7pYKMyl/xlbQVdFI5+FlAI5O4GwNIbnP
         LvtkECW8zaaPNrszL41a+57rdXJRmaExVzbfzDUid3zJiLumt4RBZGlbeH/cTuGO9Roe
         uw9BEyWHl3x9+UP3eN6vwOaKGTn/VqCnze/ZvGFhAOkD9+vRLxwuK3DUDB3zG1Vgm54Q
         JmQLisw0uQ7uz6ZxqcgZYTbWM5fQ1jnxzny2yopFlDP1uvop1R+K7PZnglXaZ3DF3MWc
         +x2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795599503; x=1796204303; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KrmPaIBrHPa/qQQAa30z7wwsH4vDjRzQJqmEhC0eSHk=;
        b=dWJ+0k9CCIVqqUqWntgDQo2k/KvNl3PKjsGV19KeE2LBzpmjddszSk8k2hOJmdIDSs
         1DHj2XYfWxxBgfiRooFh2WZo6LLy0/mbF8aBXZa4p0f14A7HzMqR9QYU8oBgHe17TCt4
         wVg5hs+/HB3do7LG+EciZqlNUx+LwBLchorucCbeR7XNU0yK7hqyKAEE4rhixdz2OAR5
         jRME0qOWLTUFFoschQI7mZxvho6fYEQPiA5/y+3eb25t+Xo5PvzWahmFdfVWF3bKR829
         PiYyv47Vi4I+OHxQnY47f1zLa7+S0oJE67bXDcjK6wCk6Mg0MwwH1dFKcHqWwQjllr52
         ySPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795599503; x=1796204303;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KrmPaIBrHPa/qQQAa30z7wwsH4vDjRzQJqmEhC0eSHk=;
        b=K0BItQLw9TsFisHEWesOZNcf4XLlY6zSo1pPycIpCxrSsrM4Ccj63bUR+jDmMCBPN6
         kqDy04N2xnQPcgZkuAUJxkuGVNqZd94/5IHfopXIuwNhOVzKUyuaF7eC1X72epCK4bDt
         y7yAfIKEX8LvArcQHLvyDy8wozbXxhZHeOXKl5htCh/UUr0H/p0q7WdHPudd3xSamTxX
         9+zQ9UykEBg3lEBRpFB1BTJsm0P9RFRyZe5MEFj+GGrAlmjX3K9leVZap67r7O8peMKG
         yaLkabnP8J3Xi9vEIjw/n9PN3axoT/dWkKzqAetKA3QTT8aW/Ww4QYVMxO1saZB0HCm5
         LnTw==
X-Gm-Message-State: APuU4Z9ejc7oHkEvJhO9Db2ppIxMDg/b2ZPVEt1eFydi78ODvOihjuQv
	IMv3JhKRsx/7aOC59JWKtbfJvcG1Qv69CJT18ax9JZjlcnfS2RFU2lkhOmYLM2XWUOoDYoh9VSk
	mcfBtDHxRInm2EL0vk1TRCQ9s4FPJuoE=
X-Gm-Gg: AZFdTZdCq/LKS77ksPWLXPEjrd/hSous/9Qfu2kdb2QGdCSz6DSGKQYhz1mL+37mwx1
	LW1OO5CDAfADQ6dwWuCH+/apYipznOW2VEOiUsoo8M9nYA3Pa70P71cuEil2Us1pgrbWOD4JJ3C
	t76Oa5H3VqmNrIdHSm8FIsBCGA01wegIZAy7ZUmPtDStaYcQW+dZ+iJj/n3TtPCMPhkafxqxofq
	Vv4f7urIgNKJn/sZPqcLt5Rx0IY5z/ar8a0xrTBELIVSysVhhq3mTy01SkekSCkwhGTKzP2VMbr
	YQFK5u1gHbXF1nmJAj5yUwQ8OfrO2SAbn1mr7WSf/lUs39KLdD0AJypQgMF49iQmBQtaLAyXT9w
	1w3xN51eF5i+3eB5hUQIMrEwC+d/P+N3udIYN81RJyWbpQGsw1U7RAvWL2dQ1+npRdaRzizei+C
	6AapYmHMKv1TEDMno4qBmDZBA=
X-Received: by 2002:a05:6122:e469:b0:5ea:d14a:ef8f with SMTP id
 71dfb90a1353d-5ee8ae8a1f2mr8999428e0c.4.1795599503343; Wed, 25 Nov 2026
 01:38:23 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119192247.2671852-1-dmnk@google.com> <20261124180557.70212-1-dmnk@google.com>
In-Reply-To: <20261124180557.70212-1-dmnk@google.com>
From: Caspar Duregger <caspar.duregger@gmail.com>
Date: Wed, 25 Nov 2026 10:37:53 +0100
X-Gm-Features: Aa3M54pD9q3sVjJYpHn0aIwG1mWEdM57Yxur00lt9PWLbj8KfSYashX0H3lZ8Ds
Message-ID: <CAFzd1+4aiyNtUxN4YM8HHrcV6qnhOGeyYAR-Ru_pp=jpn1_hMA@mail.gmail.com>
Subject: Re: [PATCH v2] graph: do not fuse merge parents with the column to
 their left
To: Dominik Maier <dmnk@google.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Pablo Sabater <pabloosabaterr@gmail.com>, dmnk+artist@google.com
Content-Type: text/plain; charset="UTF-8"

LGTM

Regards
Caspar

Am Di., 24. Nov. 2026 um 19:06 Uhr schrieb Dominik Maier <dmnk@google.com>:
>
> When a merge is skewed to the left and its second parent is the column
> right next to it, the edge to that parent is lost:
>
>         | | * M                | | *   M
>         | |/|\                 | |/|\
>         |/| |         =>       |/|/ /
>         | | * C                | | * C
>
> With four or more parents it gets worse: the remaining parents shift
> one slot too far left, leaving the last dashed-parent entry in
> graph->mapping[] at -1 and reading before graph->new_columns[0] in
> graph_draw_octopus_merge().
>
> graph_insert_into_new_columns() has a shortcut that lets a column to
> the right of a merge join the merge's last edge right away ("|\|").
> It compares against the last edge added so far. For a left-skewed
> merge, the first parent does not add an edge, so when the second parent
> comes up, that "last edge" is the column to the left of the merge, and
> the shortcut swallows the parent's own edge.
>
> Only take the shortcut for existing non-parent columns (idx < 0), which
> is the case it was written for.
>
> Helped-by: Caspar Duregger <caspar.duregger@gmail.com>
> Signed-off-by: Dominik Maier <dmnk@google.com>
> ---
> Changes in v2:
> - Reword commit message to show the 3-parent missing-edge case alongside
>   the 4+-parent out-of-bounds read, add the 3-parent test, and drop the
>   extra BUG() in graph_draw_octopus_merge() (Caspar Duregger).
>
>  graph.c                      |  3 ++-
>  t/t4215-log-skewed-merges.sh | 52 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 54 insertions(+), 1 deletion(-)
>
> diff --git a/graph.c b/graph.c
> index 95eef3a95e..c55b1fb5aa 100644
> --- a/graph.c
> +++ b/graph.c
> @@ -685,7 +685,8 @@ static void graph_insert_into_new_columns(struct git_graph *graph,
>                 mapping_idx = graph->width + (graph->merge_layout - 1) * shift;
>                 graph->width += 2 * graph->merge_layout;
>
> -       } else if (graph->edges_added > 0 && i == graph->mapping[graph->width - 2]) {
> +       } else if (idx < 0 && graph->edges_added > 0 &&
> +                  i == graph->mapping[graph->width - 2]) {
>                 /*
>                  * If some columns have been added by a merge, but this commit
>                  * was found in the last existing column, then adjust the
> diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
> index eebab71039..359383a8ad 100755
> --- a/t/t4215-log-skewed-merges.sh
> +++ b/t/t4215-log-skewed-merges.sh
> @@ -509,4 +509,56 @@ test_expect_success 'log --graph --graph-lane-limit=7 check if it shows all 3 pa
>         EOF
>  '
>
> +test_expect_success 'log --graph with left-skewed merge into its left neighbor' '
> +       git checkout --orphan 8_p &&
> +       test_commit 8_root &&
> +       git checkout -b 8_pA 8_p && test_commit 8_A &&
> +       git checkout -b 8_pB 8_p && test_commit 8_B &&
> +       git checkout -b 8_pC 8_p && test_commit 8_C &&
> +       TREE=$(git write-tree) &&
> +       test_tick &&
> +       M=$(git commit-tree $TREE -p 8_pA -p 8_pB -p 8_pC -m 8_M) &&
> +       test_tick &&
> +       TOP=$(git commit-tree $TREE -p 8_pA -p 8_pB -p $M -m 8_TOP) &&
> +
> +       lib_test_check_graph $TOP <<-\EOF
> +       *-.   8_TOP
> +       |\ \
> +       | | *   8_M
> +       | |/|\
> +       |/|/ /
> +       | | * 8_C
> +       | * | 8_B
> +       | |/
> +       * / 8_A
> +       |/
> +       * 8_root
> +       EOF
> +'
> +
> +test_expect_success 'log --graph with left-skewed 4-parent octopus into left neighbor' '
> +       git checkout -b 8_pD 8_p && test_commit 8_D &&
> +       TREE=$(git write-tree) &&
> +       test_tick &&
> +       M4=$(git commit-tree $TREE -p 8_pA -p 8_pB -p 8_pC -p 8_pD -m 8_M4) &&
> +       test_tick &&
> +       TOP4=$(git commit-tree $TREE -p 8_pA -p 8_pB -p $M4 -m 8_TOP4) &&
> +
> +       lib_test_check_graph $TOP4 <<-\EOF
> +       *-.   8_TOP4
> +       |\ \
> +       | | *-.   8_M4
> +       | |/|\ \
> +       |/|/ / /
> +       | | | * 8_D
> +       | | * | 8_C
> +       | | |/
> +       | * / 8_B
> +       | |/
> +       * / 8_A
> +       |/
> +       * 8_root
> +       EOF
> +'
> +
>  test_done
>
> Range-diff against v1:
> 1:  e28b8150c7 ! 1:  a2e27b8fa9 graph: do not fuse merge parents into left columns
>     @@ Metadata
>      Author: Dominik Maier <dmnk@google.com>
>
>       ## Commit message ##
>     -    graph: do not fuse merge parents into left columns
>     +    graph: do not fuse merge parents with the column to their left
>
>     -    In graph_insert_into_new_columns(), the branch that coalesces a column
>     -    into graph->mapping[graph->width - 2] and resets graph->edges_added = -1
>     -    is intended for existing columns to the right of a merge commit
>     -    (idx < 0) so that two adjacent edges can join immediately as "|\|".
>     +    When a merge is skewed to the left and its second parent is the column
>     +    right next to it, the edge to that parent is lost:
>
>     -    When a merge commit itself is skewed left (merge_layout == 0), its first
>     -    parent does not advance graph->width, leaving graph->width - 2 pointing
>     -    at the column immediately to the left of the merge commit. If the second
>     -    parent of a 4+-parent octopus merge matches that column while idx >= 0,
>     -    it overwrites graph->mapping[graph->width - 2] without advancing
>     -    graph->width and resets graph->edges_added = -1. Subsequent parents are
>     -    placed one slot too far left, leaving the last dashed-parent slot in
>     -    graph->mapping[] at -1 and indexing graph->new_columns[-1] in
>     -    graph_draw_octopus_merge().
>     +            | | * M                | | *   M
>     +            | |/|\                 | |/|\
>     +            |/| |         =>       |/|/ /
>     +            | | * C                | | * C
>
>     -    Restrict the right-neighbor edge fusion to existing non-merge columns
>     -    (idx < 0) and guard against negative mapping indices in
>     +    With four or more parents it gets worse: the remaining parents shift
>     +    one slot too far left, leaving the last dashed-parent entry in
>     +    graph->mapping[] at -1 and reading before graph->new_columns[0] in
>          graph_draw_octopus_merge().
>
>     +    graph_insert_into_new_columns() has a shortcut that lets a column to
>     +    the right of a merge join the merge's last edge right away ("|\|").
>     +    It compares against the last edge added so far. For a left-skewed
>     +    merge, the first parent does not add an edge, so when the second parent
>     +    comes up, that "last edge" is the column to the left of the merge, and
>     +    the shortcut swallows the parent's own edge.
>     +
>     +    Only take the shortcut for existing non-parent columns (idx < 0), which
>     +    is the case it was written for.
>     +
>     +    Helped-by: Caspar Duregger <caspar.duregger@gmail.com>
>          Signed-off-by: Dominik Maier <dmnk@google.com>
>
>       ## graph.c ##
>     @@ graph.c: static void graph_insert_into_new_columns(struct git_graph *graph,
>                 /*
>                  * If some columns have been added by a merge, but this commit
>                  * was found in the last existing column, then adjust the
>     -@@ graph.c: static void graph_draw_octopus_merge(struct git_graph *graph, struct graph_line
>     -
>     -   for (i = 0; i < dashed_parents; i++) {
>     -           j = graph->mapping[(graph->commit_index + i + 2) * 2];
>     -+          if (j < 0)
>     -+                  BUG("octopus merge mapping uninitialized");
>     -           col = &graph->new_columns[j];
>     -
>     -           graph_line_write_column(line, col, '-');
>
>       ## t/t4215-log-skewed-merges.sh ##
>      @@ t/t4215-log-skewed-merges.sh: test_expect_success 'log --graph --graph-lane-limit=7 check if it shows all 3 pa
>         EOF
>       '
>
>     -+test_expect_success 'log --graph left-skewed 4-parent octopus merge joining adjacent left column' '
>     ++test_expect_success 'log --graph with left-skewed merge into its left neighbor' '
>      +  git checkout --orphan 8_p &&
>      +  test_commit 8_root &&
>      +  git checkout -b 8_pA 8_p && test_commit 8_A &&
>      +  git checkout -b 8_pB 8_p && test_commit 8_B &&
>      +  git checkout -b 8_pC 8_p && test_commit 8_C &&
>     -+  git checkout -b 8_pD 8_p && test_commit 8_D &&
>     -+  git checkout -b 8_M 8_pA &&
>     -+  git merge --no-ff 8_pB 8_pC 8_pD -m 8_M &&
>     -+  git checkout 8_pB && test_commit 8_B2 &&
>     -+  git checkout -b 8_TOP 8_pA &&
>     -+  git merge --no-ff 8_pB 8_M -m 8_TOP &&
>     ++  TREE=$(git write-tree) &&
>     ++  test_tick &&
>     ++  M=$(git commit-tree $TREE -p 8_pA -p 8_pB -p 8_pC -m 8_M) &&
>     ++  test_tick &&
>     ++  TOP=$(git commit-tree $TREE -p 8_pA -p 8_pB -p $M -m 8_TOP) &&
>      +
>     -+  lib_test_check_graph --date-order 8_TOP <<-\EOF
>     ++  lib_test_check_graph $TOP <<-\EOF
>      +  *-.   8_TOP
>      +  |\ \
>     -+  | * | 8_B2
>     -+  | | *-.   8_M
>     ++  | | *   8_M
>     ++  | |/|\
>     ++  |/|/ /
>     ++  | | * 8_C
>     ++  | * | 8_B
>     ++  | |/
>     ++  * / 8_A
>     ++  |/
>     ++  * 8_root
>     ++  EOF
>     ++'
>     ++
>     ++test_expect_success 'log --graph with left-skewed 4-parent octopus into left neighbor' '
>     ++  git checkout -b 8_pD 8_p && test_commit 8_D &&
>     ++  TREE=$(git write-tree) &&
>     ++  test_tick &&
>     ++  M4=$(git commit-tree $TREE -p 8_pA -p 8_pB -p 8_pC -p 8_pD -m 8_M4) &&
>     ++  test_tick &&
>     ++  TOP4=$(git commit-tree $TREE -p 8_pA -p 8_pB -p $M4 -m 8_TOP4) &&
>     ++
>     ++  lib_test_check_graph $TOP4 <<-\EOF
>     ++  *-.   8_TOP4
>     ++  |\ \
>     ++  | | *-.   8_M4
>      +  | |/|\ \
>      +  |/|/ / /
>      +  | | | * 8_D
> --
> 2.56.1.831.g720f3f5937-goog
>
