Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 616741F4C0
	for <e@80x24.org>; Thu, 10 Oct 2019 17:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfJJRtY (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 13:49:24 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44713 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfJJRtY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 13:49:24 -0400
Received: by mail-qt1-f196.google.com with SMTP id u40so9886980qth.11
        for <git@vger.kernel.org>; Thu, 10 Oct 2019 10:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Zz1IUN9e9KGlzkR2yj37+M+glA7CzTTX1Tl8rC8cU8w=;
        b=lYKkqhmI81VkU6LdbM+NjHK6ReTz4Bz6lxUPTZKSeAoWl3v5N6yw0VytcI2kk32kci
         FbAIgl/UomG4srPFsMFnj+DpLMIbJPS0ZS1Sgxlv4neqyJOhB+WHMLSxN+KwwbSRAQA/
         BnHxgW8+/xbTQT45hUIZkgQv8pEWbklbYFN1H2FjlRWSy/inPz1y8PQ2I52oUN+vdObd
         f6o5ayoaL345wq0ZwJiEYklwCm1EhQZOnTCSrfAsakVBGathCGjDvOIWqUhGP257K6fA
         R5GlU2kfcZ6bIe3VDAnRZRWuUNSex9C67jslmA7s2KLRFXkJum+3P5GzXZaIER4EpnM3
         KTew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zz1IUN9e9KGlzkR2yj37+M+glA7CzTTX1Tl8rC8cU8w=;
        b=LbmhNAhpJxvfpeFZqNbXCr8gch4KjOxNfo9PUtNhwMahnocyNX+4jhMSVWdmEf+Rnj
         iBR28PUlxZ86K70zBBCZfDMJ0WESdgLYKckeOawmEdDkQ677ZITEHLFLzcS9D0RCtviz
         nd++y8iEaKABYmmg7oghNgsdGxKQO2MVK8oPW2TBtDqf1PsoagDKoZOV2RoQ7XW002qj
         adJHYao3bxE0Q8Q6b9tfFw4m01WlviXxzOgXzQ2fDG2g1FPaNGVOifBUrnSzZHIViYuA
         G7Oh6xrXdJ33kX9JHRdHRAYM2A7ozwTFTV2j3YJJKnMulVhv57V7O36Szui2DHaTI7Hp
         WxBw==
X-Gm-Message-State: APjAAAUHK2yKd8OvYAXlxmwjiD1hyiZz16ImWMRGMe4VNENJ/yBuV/xV
        utGvDmxhQDuQ9QdTsXr6aCw=
X-Google-Smtp-Source: APXvYqzjIXMcfH+zsQWwXa7oTjTR2WdCiU1/6LnQ7z17RuBbiI0iBUWamVd4IZu063VwJlVrzrkxRA==
X-Received: by 2002:a0c:f3c1:: with SMTP id f1mr11641469qvm.165.1570729762655;
        Thu, 10 Oct 2019 10:49:22 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:2da2:a6da:62ea:75d9? ([2001:4898:a800:1010:ded7:a6da:62ea:75d9])
        by smtp.gmail.com with ESMTPSA id g8sm3563382qta.67.2019.10.10.10.49.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2019 10:49:21 -0700 (PDT)
Subject: Re: [PATCH 07/11] graph: commit and post-merge lines for left-skewed
 merges
To:     James Coglan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        James Coglan <jcoglan@gmail.com>
References: <pull.383.git.gitgitgadget@gmail.com>
 <6c173663aac37f1d314db8637cf4a243066b8078.1570724021.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9fe7f2d9-2108-5cf6-dcd7-06d91e74e98b@gmail.com>
Date:   Thu, 10 Oct 2019 13:49:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <6c173663aac37f1d314db8637cf4a243066b8078.1570724021.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/10/2019 12:13 PM, James Coglan via GitGitGadget wrote:
> From: James Coglan <jcoglan@gmail.com>
> 
> Following the introduction of "left-skewed" merges, which are merges
> whose first parent fuses with another edge to its left, we have some
> more edge cases to deal with in the display of commit and post-merge
> lines.
> 
> The current graph code handles the following cases for edges appearing
> to the right of the commit (*) on commit lines. A 2-way merge is usually
> followed by vertical lines:
> 
>         | | |
>         | * |
>         | |\ \
> 
> An octopus merge (more than two parents) is always followed by edges
> sloping to the right:
> 
>         | |  \          | |    \
>         | *-. \         | *---. \
>         | |\ \ \        | |\ \ \ \
> 
> A 2-way merge is followed by a right-sloping edge if the commit line
> immediately follows a post-merge line for a commit that appears in the
> same column as the current commit, or any column to the left of that:
> 
>         | *             | * |
>         | |\            | |\ \
>         | * \           | | * \
>         | |\ \          | | |\ \
> 
> This commit introduces the following new cases for commit lines. If a
> 2-way merge skews to the left, then the edges to its right are always
> vertical lines, even if the commit follows a post-merge line:
> 
>         | | |           | |\
>         | * |           | * |
>         |/| |           |/| |
> 
> A commit with 3 parents that skews left is followed by vertical edges:
> 
>         | | |
>         | * |
>         |/|\ \
> 
> If a 3-way left-skewed merge commit appears immediately after a
> post-merge line, then it may be followed the right-sloping edges, just
> like a 2-way merge that is not skewed.
> 
>         | |\
>         | * \
>         |/|\ \
> 
> Octopus merges with 4 or more parents that skew to the left will always
> be followed by right-sloping edges, because the existing columns need to
> expand around the merge.
> 
>         | |  \
>         | *-. \
>         |/|\ \ \
> 
> On post-merge lines, usually all edges following the current commit
> slope to the right:
> 
>         | * | |
>         | |\ \ \
> 
> However, if the commit is a left-skewed 2-way merge, the edges to its
> right remain vertical. We also need to display a space after the
> vertical line descending from the commit marker, whereas this line would
> normally be followed by a backslash.
> 
>         | * | |
>         |/| | |
> 
> If a left-skewed merge has more than 2 parents, then the edges to its
> right are still sloped as they bend around the edges introduced by the
> merge.
> 
>         | * | |
>         |/|\ \ \
> 
> To handle these new cases, we need to know not just how many parents
> each commit has, but how many new columns it adds to the display; this
> quantity is recorded in the `edges_added` field for the current commit,
> and `prev_edges_added` field for the previous commit.
> 
> Here, "column" refers to visual columns, not the logical columns of the
> `columns` array. This is because even if all the commit's parents end up
> fusing with existing edges, they initially introduce distinct edges in
> the commit and post-merge lines before those edges collapse. For
> example, a 3-way merge whose 2nd and 3rd parents fuse with existing
> edges still introduces 2 visual columns that affect the display of edges
> to their right.
> 
>         | | |  \
>         | | *-. \
>         | | |\ \ \
>         | |_|/ / /
>         |/| | / /
>         | | |/ /
>         | |/| |
>         | | | |
> 
> This merge does not introduce any *logical* columns; there are 4 edges
> before and after this commit once all edges have collapsed. But it does
> initially introduce 2 new edges that need to be accommodated by the
> edges to their right.
> 
> Signed-off-by: James Coglan <jcoglan@gmail.com>
> ---
>  graph.c                      |  63 +++++++++++++--
>  t/t4215-log-skewed-merges.sh | 151 +++++++++++++++++++++++++++++++++++
>  2 files changed, 209 insertions(+), 5 deletions(-)
> 
> diff --git a/graph.c b/graph.c
> index 9136173e03..fb2e42850f 100644
> --- a/graph.c
> +++ b/graph.c
> @@ -197,6 +197,46 @@ struct git_graph {
>  	 * 		|/| | | | |		| | | | | *
>  	 */
>  	int merge_layout;
> +	/*
> +	 * The number of columns added to the graph by the current commit. For
> +	 * 2-way and octopus merges, this is is usually one less than the
> +	 * number of parents:
> +	 *
> +	 * 		| | |			| |    \
> +	 *		| * |			| *---. \
> +	 *		| |\ \			| |\ \ \ \
> +	 *		| | | |         	| | | | | |
> +	 *
> +	 *		num_parents: 2		num_parents: 4
> +	 *		edges_added: 1		edges_added: 3
> +	 *
> +	 * For left-skewed merges, the first parent fuses with its neighbor and
> +	 * so one less column is added:
> +	 *
> +	 *		| | |			| |  \
> +	 *		| * |			| *-. \
> +	 *		|/| |			|/|\ \ \
> +	 *		| | |			| | | | |
> +	 *
> +	 *		num_parents: 2		num_parents: 4
> +	 *		edges_added: 0		edges_added: 2
> +	 *
> +	 * This number determines how edges to the right of the merge are
> +	 * displayed in commit and post-merge lines; if no columns have been
> +	 * added then a vertical line should be used where a right-tracking
> +	 * line would otherwise be used.
> +	 *
> +	 *		| * \			| * |
> +	 *		| |\ \			|/| |
> +	 *		| | * \			| * |
> +	 */
> +	int edges_added;
> +	/*
> +	 * The number of columns added by the previous commit, which is used to
> +	 * smooth edges appearing to the right of a commit in a commit line
> +	 * following a post-merge line.
> +	 */
> +	int prev_edges_added;
>  	/*
>  	 * The maximum number of columns that can be stored in the columns
>  	 * and new_columns arrays.  This is also half the number of entries
> @@ -309,6 +349,8 @@ struct git_graph *graph_init(struct rev_info *opt)
>  	graph->commit_index = 0;
>  	graph->prev_commit_index = 0;
>  	graph->merge_layout = 0;
> +	graph->edges_added = 0;
> +	graph->prev_edges_added = 0;
>  	graph->num_columns = 0;
>  	graph->num_new_columns = 0;
>  	graph->mapping_size = 0;
> @@ -670,6 +712,9 @@ void graph_update(struct git_graph *graph, struct commit *commit)
>  	 */
>  	graph_update_columns(graph);
>  
> +	graph->prev_edges_added = graph->edges_added;
> +	graph->edges_added = graph->num_parents + graph->merge_layout - 2;
> +
>  	graph->expansion_row = 0;
>  
>  	/*
> @@ -943,12 +988,13 @@ static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
>  
>  			if (graph->num_parents > 2)
>  				graph_draw_octopus_merge(graph, sb);
> -		} else if (seen_this && (graph->num_parents > 2)) {
> +		} else if (seen_this && (graph->edges_added > 1)) {
>  			strbuf_write_column(sb, col, '\\');
> -		} else if (seen_this && (graph->num_parents == 2)) {
> +		} else if (seen_this && (graph->edges_added == 1)) {
>  			/*
> -			 * This is a 2-way merge commit.
> -			 * There is no GRAPH_PRE_COMMIT stage for 2-way
> +			 * This is either a right-skewed 2-way merge
> +			 * commit, or a left-skewed 3-way merge.
> +			 * There is no GRAPH_PRE_COMMIT stage for such
>  			 * merges, so this is the first line of output
>  			 * for this commit.  Check to see what the previous
>  			 * line of output was.
> @@ -960,6 +1006,7 @@ static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
>  			 * makes the output look nicer.
>  			 */
>  			if (graph->prev_state == GRAPH_POST_MERGE &&
> +			    graph->prev_edges_added > 0 &&
>  			    graph->prev_commit_index < i)
>  				strbuf_write_column(sb, col, '\\');
>  			else
> @@ -1031,8 +1078,14 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct strbuf
>  				else
>  					idx++;
>  			}
> +			if (graph->edges_added == 0)
> +				strbuf_addch(sb, ' ');
> +
>  		} else if (seen_this) {
> -			strbuf_write_column(sb, col, '\\');
> +			if (graph->edges_added > 0)
> +				strbuf_write_column(sb, col, '\\');
> +			else
> +				strbuf_write_column(sb, col, '|');
>  			strbuf_addch(sb, ' ');
>  		} else {
>  			strbuf_write_column(sb, col, '|');
> diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
> index cfaba40f97..e479d6e676 100755
> --- a/t/t4215-log-skewed-merges.sh
> +++ b/t/t4215-log-skewed-merges.sh
> @@ -39,4 +39,155 @@ test_expect_success 'log --graph with left-skewed merge' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'setup nested left-skewed merge' '
> +	git checkout --orphan 1_p &&
> +	test_commit 1_A &&
> +	test_commit 1_B &&
> +	test_commit 1_C &&
> +	git checkout -b 1_q @^ && test_commit 1_D &&
> +	git checkout 1_p && git merge --no-ff 1_q -m 1_E &&
> +	git checkout -b 1_r @~3 && test_commit 1_F &&
> +	git checkout 1_p && git merge --no-ff 1_r -m 1_G &&
> +	git checkout @^^ && git merge --no-ff 1_p -m 1_H
> +'
> +
> +cat > expect <<\EOF
> +*   1_H
> +|\
> +| *   1_G
> +| |\
> +| | * 1_F
> +| * | 1_E
> +|/| |
> +| * | 1_D
> +* | | 1_C
> +|/ /
> +* | 1_B
> +|/
> +* 1_A
> +EOF
> +
> +test_expect_success 'log --graph with nested left-skewed merge' '
> +	git log --graph --pretty=tformat:%s | sed "s/ *$//" > actual &&
> +	test_cmp expect actual
> +'

I should have noticed in your earlier commits, but why don't you keep
the output inside the test suite? You can start with "cat >expect <<-EOF"
to have it ignore leading whitespace. Sorry if there's something else about
this that is causing issues.

> +
> +test_expect_success 'setup nested left-skewed merge following normal merge' '
> +	git checkout --orphan 2_p &&
> +	test_commit 2_A &&
> +	test_commit 2_B &&
> +	test_commit 2_C &&
> +	git checkout -b 2_q @^^ &&
> +	test_commit 2_D &&
> +	test_commit 2_E &&
> +	git checkout -b 2_r @^ && test_commit 2_F &&
> +	git checkout 2_q &&
> +	git merge --no-ff 2_r -m 2_G &&
> +	git merge --no-ff 2_p^ -m 2_H &&
> +	git checkout -b 2_s @^^ && git merge --no-ff 2_q -m 2_J &&
> +	git checkout 2_p && git merge --no-ff 2_s -m 2_K
> +'
> +
> +cat > expect <<\EOF
> +*   2_K
> +|\
> +| *   2_J
> +| |\
> +| | *   2_H
> +| | |\
> +| | * | 2_G
> +| |/| |
> +| | * | 2_F
> +| * | | 2_E
> +| |/ /
> +| * | 2_D
> +* | | 2_C
> +| |/
> +|/|
> +* | 2_B
> +|/
> +* 2_A
> +EOF
> +
> +test_expect_success 'log --graph with nested left-skewed merge following normal merge' '
> +	git log --graph --pretty=tformat:%s | sed "s/ *$//" > actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'setup nested right-skewed merge following left-skewed merge' '
> +	git checkout --orphan 3_p &&
> +	test_commit 3_A &&
> +	git checkout -b 3_q &&
> +	test_commit 3_B &&
> +	test_commit 3_C &&
> +	git checkout -b 3_r @^ &&
> +	test_commit 3_D &&
> +	git checkout 3_q && git merge --no-ff 3_r -m 3_E &&
> +	git checkout 3_p && git merge --no-ff 3_q -m 3_F &&
> +	git checkout 3_r && test_commit 3_G &&
> +	git checkout 3_p && git merge --no-ff 3_r -m 3_H &&
> +	git checkout @^^ && git merge --no-ff 3_p -m 3_J
> +'
> +
> +cat > expect <<\EOF
> +*   3_J
> +|\
> +| *   3_H
> +| |\
> +| | * 3_G
> +| * | 3_F
> +|/| |
> +| * |   3_E
> +| |\ \
> +| | |/
> +| | * 3_D
> +| * | 3_C
> +| |/
> +| * 3_B
> +|/
> +* 3_A
> +EOF
> +
> +test_expect_success 'log --graph with nested right-skewed merge following left-skewed merge' '
> +	git log --graph --pretty=tformat:%s | sed "s/ *$//" > actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'setup right-skewed merge following a left-skewed one' '
> +	git checkout --orphan 4_p &&
> +	test_commit 4_A &&
> +	test_commit 4_B &&
> +	test_commit 4_C &&
> +	git checkout -b 4_q @^^ && test_commit 4_D &&
> +	git checkout -b 4_r 4_p^ && git merge --no-ff 4_q -m 4_E &&
> +	git checkout -b 4_s 4_p^^ &&
> +	git merge --no-ff 4_r -m 4_F &&
> +	git merge --no-ff 4_p -m 4_G &&
> +	git checkout @^^ && git merge --no-ff 4_s -m 4_H
> +'
> +
> +cat > expect <<\EOF
> +*   4_H
> +|\
> +| *   4_G
> +| |\
> +| * | 4_F
> +|/| |
> +| * |   4_E
> +| |\ \
> +| | * | 4_D
> +| |/ /
> +|/| |
> +| | * 4_C
> +| |/
> +| * 4_B
> +|/
> +* 4_A
> +EOF
> +
> +test_expect_success 'log --graph with right-skewed merge following a left-skewed one' '
> +	git log --graph --date-order --pretty=tformat:%s | sed "s/ *$//" > actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
> 

