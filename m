Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 907331F4C0
	for <e@80x24.org>; Mon, 14 Oct 2019 13:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbfJNNBw (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 09:01:52 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44440 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfJNNBw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 09:01:52 -0400
Received: by mail-wr1-f68.google.com with SMTP id z9so19625898wrl.11
        for <git@vger.kernel.org>; Mon, 14 Oct 2019 06:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oaNMlDLgiKwctdqtja03GpIOWpYbyMBL8i6xnPBe0nU=;
        b=Lr3us85HoHGmPWW/B9ZSor6wptqLxNrCyBmkAeJHYR0+gQUNH0wHeX3S+Fpf7ITjZO
         vwJ6isfMiJGUyX+a7lLQ0lTtoOMmIK5cJSj4CQMkrj+HpLVaQ3+PCYVBQIY0LC8k3Cnc
         rif6d+aNhm8w7bD/mWJAyrzDF/uvvqlhCWAP1zl0oE6cWeSHFmBn1C5+ihw4R1GtyciX
         1FfwQ5lsqEt8kFjfCg0lM9U/2ulXTEZwwftb+k59vZgkQGc74Ba0vQKj7ttZpCTXVJIY
         G+DEEXPiQ6sM193FlOpbuUCOCUz3DtYHd+srbzxV6PdJ9DTIZjXS1N/7rlYVIH4YpiYF
         DLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oaNMlDLgiKwctdqtja03GpIOWpYbyMBL8i6xnPBe0nU=;
        b=BHHTed8le9HFPK1sbGHy8knSK5k6nGZmFQ53SF8P2ywiZYbClQPp7opS2ch2lVwwY2
         p9A3/CiE67Iji9GQoQY4sSIzrADhPoPgsI/0d51OQt3BYMBrRNBReytNBUhZxk8TrG7L
         QjgkO68YYti+vfm7U2/JWY+aLkLTSdNk6dGd4hmY0D+uM9YYPTlSMiT6sIFTwpn7/bBl
         dGFiKpm6T0sZYnOWeDz87DV9U5IE2Vtd5fr8MZ0dRSJ1+K5TCRhcO/uEQo+FeZ8l6sHh
         ydMwnhXIbKdm9B7CiJioPyF6PSpOYIopoeMG90f9Z6zTAJ/vKRrrk6ohNIgF7gLw44i8
         R++A==
X-Gm-Message-State: APjAAAUlkwDXwDFFeXXdvb1/EpdVZtXxZHT9rIXUAqKxaAMRRwbBJYsf
        9M3yzKYyz7LHBEJsCUcHVvtIisM/vRM=
X-Google-Smtp-Source: APXvYqzAQEkSa5SeykifcNYIlTsNH971BUnuSEIQxQOOielp9CbOnMkAk3aJNfD6DyQ8our0YmwwLg==
X-Received: by 2002:a5d:488f:: with SMTP id g15mr12242329wrq.9.1571058107202;
        Mon, 14 Oct 2019 06:01:47 -0700 (PDT)
Received: from liskov.home (host109-157-47-110.range109-157.btcentralplus.com. [109.157.47.110])
        by smtp.gmail.com with ESMTPSA id a18sm25423329wrs.27.2019.10.14.06.01.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2019 06:01:46 -0700 (PDT)
Subject: Re: [PATCH 01/11] graph: automatically track visible width of
 `strbuf`
From:   James Coglan <jcoglan@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        James Coglan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.383.git.gitgitgadget@gmail.com>
 <4bc0a0596164212aa9d29d6dd0d7a0d8ab1b9dd0.1570724021.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.1910102303330.46@tvgsbejvaqbjf.bet>
 <20191010230550.GA42541@generichostname>
 <xmqq7e5cjbwj.fsf@gitster-ct.c.googlers.com>
 <20191011050111.GA94866@generichostname>
 <nycvar.QRO.7.76.6.1910111800220.46@tvgsbejvaqbjf.bet>
 <79463ee5-a171-53a8-4903-84a825c4e8d8@gmail.com>
 <xmqqo8ymg64c.fsf@gitster-ct.c.googlers.com>
 <66b8ed45-4baa-37d9-c97f-72188ece32eb@gmail.com>
Message-ID: <0dc3a92d-6cc7-fe9e-4d6e-786443621c10@gmail.com>
Date:   Mon, 14 Oct 2019 14:01:45 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <66b8ed45-4baa-37d9-c97f-72188ece32eb@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/10/2019 13:55, James Coglan wrote:
> Thanks! For completeness, here is the current state of this patch after I've been through the feedback up to this point:
> 
> From 241180570fbaae04a2263c5ff1ab3b92f54f8004 Mon Sep 17 00:00:00 2001
> From: James Coglan <jcoglan@gmail.com>
> Date: Thu, 22 Aug 2019 09:30:08 +0100
> Subject: [PATCH] graph: automatically track display width of graph lines
> 
> All the output functions called by `graph_next_line()` currently keep
> track of how many printable chars they've written to the buffer, before
> calling `graph_pad_horizontally()` to pad the line with spaces. Some
> functions do this by incrementing a counter whenever they write to the
> buffer, and others do it by encoding an assumption about how many chars
> are written, as in:
> 
>     graph_pad_horizontally(graph, sb, graph->num_columns * 2);
> 
> This adds a fair amount of noise to the functions' logic and is easily
> broken if one forgets to increment the right counter or update the
> calculations used for padding.
> 
> To make this easier to use, I'm introducing a new struct called
> `graph_line` that wraps a `strbuf` and keeps count of its display width
> implicitly. `graph_next_line()` wraps this around the `struct strbuf *`
> it's given and passes a `struct graph_line *` to the output functions,
> which use its interface.
> 
> The `graph_line` interface wraps the `strbuf_addch()`,
> `strbuf_addchars()` and `strbuf_addstr()` functions, and adds the
> `graph_line_write_column()` function for adding a single character with
> color formatting. The `graph_pad_horizontally()` function can then use
> the `width` field from the struct rather than taking a character count
> as a parameter.
> 
> Signed-off-by: James Coglan <jcoglan@gmail.com>
> ---
>  graph.c | 194 +++++++++++++++++++++++++++++---------------------------
>  1 file changed, 99 insertions(+), 95 deletions(-)
> 
> diff --git a/graph.c b/graph.c
> index f53135485f..2f81a5d23d 100644
> --- a/graph.c
> +++ b/graph.c
> @@ -112,14 +112,42 @@ static const char *column_get_color_code(unsigned short color)
>  	return column_colors[color];
>  }
>  
> -static void strbuf_write_column(struct strbuf *sb, const struct column *c,
> -				char col_char)
> +struct graph_line {
> +	struct strbuf *buf;
> +	size_t width;
> +};
> +
> +static inline void graph_line_addch(struct graph_line *line, int c)
> +{
> +	strbuf_addch(line->buf, c);
> +	line->width++;
> +}
> +
> +static inline void graph_line_addchars(struct graph_line *line, int c, size_t n)
> +{
> +	strbuf_addchars(line->buf, c, n);
> +	line->width += n;
> +}
> +
> +static inline void graph_line_addstr(struct graph_line *line, const char *s)
> +{
> +	strbuf_addstr(line->buf, s);
> +	line->width += strlen(s);
> +}
> +
> +static inline void graph_line_addcolor(struct graph_line *line, unsigned short color)
> +{
> +	strbuf_addstr(line->buf, column_get_color_code(color));
> +}
> +
> +static void graph_line_write_column(struct graph_line *line, const struct column *c,
> +				    char col_char)
>  {
>  	if (c->color < column_colors_max)
> -		strbuf_addstr(sb, column_get_color_code(c->color));
> -	strbuf_addch(sb, col_char);
> +		graph_line_addcolor(line, c->color);
> +	graph_line_addch(line, col_char);
>  	if (c->color < column_colors_max)
> -		strbuf_addstr(sb, column_get_color_code(column_colors_max));
> +		graph_line_addcolor(line, column_colors_max);
>  }
>  
>  struct git_graph {
> @@ -686,8 +714,7 @@ static int graph_is_mapping_correct(struct git_graph *graph)
>  	return 1;
>  }
>  
> -static void graph_pad_horizontally(struct git_graph *graph, struct strbuf *sb,
> -				   int chars_written)
> +static void graph_pad_horizontally(struct git_graph *graph, struct graph_line *line)
>  {
>  	/*
>  	 * Add additional spaces to the end of the strbuf, so that all
> @@ -696,12 +723,12 @@ static void graph_pad_horizontally(struct git_graph *graph, struct strbuf *sb,
>  	 * This way, fields printed to the right of the graph will remain
>  	 * aligned for the entire commit.
>  	 */
> -	if (chars_written < graph->width)
> -		strbuf_addchars(sb, ' ', graph->width - chars_written);
> +	if (line->width < graph->width)
> +		graph_line_addchars(line, ' ', graph->width - line->width);
>  }
>  
>  static void graph_output_padding_line(struct git_graph *graph,
> -				      struct strbuf *sb)
> +				      struct graph_line *line)
>  {
>  	int i;
>  
> @@ -719,11 +746,11 @@ static void graph_output_padding_line(struct git_graph *graph,
>  	 * Output a padding row, that leaves all branch lines unchanged
>  	 */
>  	for (i = 0; i < graph->num_new_columns; i++) {
> -		strbuf_write_column(sb, &graph->new_columns[i], '|');
> -		strbuf_addch(sb, ' ');
> +		graph_line_write_column(line, &graph->new_columns[i], '|');
> +		graph_line_addch(line, ' ');
>  	}
>  
> -	graph_pad_horizontally(graph, sb, graph->num_new_columns * 2);
> +	graph_pad_horizontally(graph, line);
>  }
>  
>  
> @@ -733,14 +760,14 @@ int graph_width(struct git_graph *graph)
>  }
>  
>  
> -static void graph_output_skip_line(struct git_graph *graph, struct strbuf *sb)
> +static void graph_output_skip_line(struct git_graph *graph, struct graph_line *line)
>  {
>  	/*
>  	 * Output an ellipsis to indicate that a portion
>  	 * of the graph is missing.
>  	 */
> -	strbuf_addstr(sb, "...");
> -	graph_pad_horizontally(graph, sb, 3);
> +	graph_line_addstr(line, "...");
> +	graph_pad_horizontally(graph, line);
>  
>  	if (graph->num_parents >= 3 &&
>  	    graph->commit_index < (graph->num_columns - 1))
> @@ -750,11 +777,10 @@ static void graph_output_skip_line(struct git_graph *graph, struct strbuf *sb)
>  }
>  
>  static void graph_output_pre_commit_line(struct git_graph *graph,
> -					 struct strbuf *sb)
> +					 struct graph_line *line)
>  {
>  	int num_expansion_rows;
>  	int i, seen_this;
> -	int chars_written;
>  
>  	/*
>  	 * This function formats a row that increases the space around a commit
> @@ -777,14 +803,12 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
>  	 * Output the row
>  	 */
>  	seen_this = 0;
> -	chars_written = 0;
>  	for (i = 0; i < graph->num_columns; i++) {
>  		struct column *col = &graph->columns[i];
>  		if (col->commit == graph->commit) {
>  			seen_this = 1;
> -			strbuf_write_column(sb, col, '|');
> -			strbuf_addchars(sb, ' ', graph->expansion_row);
> -			chars_written += 1 + graph->expansion_row;
> +			graph_line_write_column(line, col, '|');
> +			graph_line_addchars(line, ' ', graph->expansion_row);
>  		} else if (seen_this && (graph->expansion_row == 0)) {
>  			/*
>  			 * This is the first line of the pre-commit output.
> @@ -797,22 +821,18 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
>  			 */
>  			if (graph->prev_state == GRAPH_POST_MERGE &&
>  			    graph->prev_commit_index < i)
> -				strbuf_write_column(sb, col, '\\');
> +				graph_line_write_column(line, col, '\\');
>  			else
> -				strbuf_write_column(sb, col, '|');
> -			chars_written++;
> +				graph_line_write_column(line, col, '|');
>  		} else if (seen_this && (graph->expansion_row > 0)) {
> -			strbuf_write_column(sb, col, '\\');
> -			chars_written++;
> +			graph_line_write_column(line, col, '\\');
>  		} else {
> -			strbuf_write_column(sb, col, '|');
> -			chars_written++;
> +			graph_line_write_column(line, col, '|');
>  		}
> -		strbuf_addch(sb, ' ');
> -		chars_written++;
> +		graph_line_addch(line, ' ');
>  	}
>  
> -	graph_pad_horizontally(graph, sb, chars_written);
> +	graph_pad_horizontally(graph, line);
>  
>  	/*
>  	 * Increment graph->expansion_row,
> @@ -823,7 +843,7 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
>  		graph_update_state(graph, GRAPH_COMMIT);
>  }
>  
> -static void graph_output_commit_char(struct git_graph *graph, struct strbuf *sb)
> +static void graph_output_commit_char(struct git_graph *graph, struct graph_line *line)
>  {
>  	/*
>  	 * For boundary commits, print 'o'
> @@ -831,22 +851,20 @@ static void graph_output_commit_char(struct git_graph *graph, struct strbuf *sb)
>  	 */
>  	if (graph->commit->object.flags & BOUNDARY) {
>  		assert(graph->revs->boundary);
> -		strbuf_addch(sb, 'o');
> +		graph_line_addch(line, 'o');
>  		return;
>  	}
>  
>  	/*
>  	 * get_revision_mark() handles all other cases without assert()
>  	 */
> -	strbuf_addstr(sb, get_revision_mark(graph->revs, graph->commit));
> +	graph_line_addstr(line, get_revision_mark(graph->revs, graph->commit));
>  }
>  
>  /*
> - * Draw the horizontal dashes of an octopus merge and return the number of
> - * characters written.
> + * Draw the horizontal dashes of an octopus merge.
>   */
> -static int graph_draw_octopus_merge(struct git_graph *graph,
> -				    struct strbuf *sb)
> +static void graph_draw_octopus_merge(struct git_graph *graph, struct graph_line *line)
>  {
>  	/*
>  	 * Here dashless_parents represents the number of parents which don't
> @@ -886,17 +904,16 @@ static int graph_draw_octopus_merge(struct git_graph *graph,
>  
>  	int i;
>  	for (i = 0; i < dashful_parents; i++) {
> -		strbuf_write_column(sb, &graph->new_columns[i+first_col], '-');
> -		strbuf_write_column(sb, &graph->new_columns[i+first_col],
> -				    i == dashful_parents-1 ? '.' : '-');
> +		graph_line_write_column(line, &graph->new_columns[i+first_col], '-');
> +		graph_line_write_column(line, &graph->new_columns[i+first_col],
> +					  i == dashful_parents-1 ? '.' : '-');
>  	}
> -	return 2 * dashful_parents;
>  }
>  
> -static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
> +static void graph_output_commit_line(struct git_graph *graph, struct graph_line *line)
>  {
>  	int seen_this = 0;
> -	int i, chars_written;
> +	int i;
>  
>  	/*
>  	 * Output the row containing this commit
> @@ -906,7 +923,6 @@ static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
>  	 * children that we have already processed.)
>  	 */
>  	seen_this = 0;
> -	chars_written = 0;
>  	for (i = 0; i <= graph->num_columns; i++) {
>  		struct column *col = &graph->columns[i];
>  		struct commit *col_commit;
> @@ -920,15 +936,12 @@ static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
>  
>  		if (col_commit == graph->commit) {
>  			seen_this = 1;
> -			graph_output_commit_char(graph, sb);
> -			chars_written++;
> +			graph_output_commit_char(graph, line);
>  
>  			if (graph->num_parents > 2)
> -				chars_written += graph_draw_octopus_merge(graph,
> -									  sb);
> +				graph_draw_octopus_merge(graph, line);
>  		} else if (seen_this && (graph->num_parents > 2)) {
> -			strbuf_write_column(sb, col, '\\');
> -			chars_written++;
> +			graph_line_write_column(line, col, '\\');
>  		} else if (seen_this && (graph->num_parents == 2)) {
>  			/*
>  			 * This is a 2-way merge commit.
> @@ -945,19 +958,16 @@ static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
>  			 */
>  			if (graph->prev_state == GRAPH_POST_MERGE &&
>  			    graph->prev_commit_index < i)
> -				strbuf_write_column(sb, col, '\\');
> +				graph_line_write_column(line, col, '\\');
>  			else
> -				strbuf_write_column(sb, col, '|');
> -			chars_written++;
> +				graph_line_write_column(line, col, '|');
>  		} else {
> -			strbuf_write_column(sb, col, '|');
> -			chars_written++;
> +			graph_line_write_column(line, col, '|');
>  		}
> -		strbuf_addch(sb, ' ');
> -		chars_written++;
> +		graph_line_addch(line, ' ');
>  	}
>  
> -	graph_pad_horizontally(graph, sb, chars_written);
> +	graph_pad_horizontally(graph, line);
>  
>  	/*
>  	 * Update graph->state
> @@ -981,15 +991,14 @@ static struct column *find_new_column_by_commit(struct git_graph *graph,
>  	return NULL;
>  }
>  
> -static void graph_output_post_merge_line(struct git_graph *graph, struct strbuf *sb)
> +static void graph_output_post_merge_line(struct git_graph *graph, struct graph_line *line)
>  {
>  	int seen_this = 0;
> -	int i, j, chars_written;
> +	int i, j;
>  
>  	/*
>  	 * Output the post-merge row
>  	 */
> -	chars_written = 0;
>  	for (i = 0; i <= graph->num_columns; i++) {
>  		struct column *col = &graph->columns[i];
>  		struct commit *col_commit;
> @@ -1016,29 +1025,25 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct strbuf
>  			par_column = find_new_column_by_commit(graph, parents->item);
>  			assert(par_column);
>  
> -			strbuf_write_column(sb, par_column, '|');
> -			chars_written++;
> +			graph_line_write_column(line, par_column, '|');
>  			for (j = 0; j < graph->num_parents - 1; j++) {
>  				parents = next_interesting_parent(graph, parents);
>  				assert(parents);
>  				par_column = find_new_column_by_commit(graph, parents->item);
>  				assert(par_column);
> -				strbuf_write_column(sb, par_column, '\\');
> -				strbuf_addch(sb, ' ');
> +				graph_line_write_column(line, par_column, '\\');
> +				graph_line_addch(line, ' ');
>  			}
> -			chars_written += j * 2;
>  		} else if (seen_this) {
> -			strbuf_write_column(sb, col, '\\');
> -			strbuf_addch(sb, ' ');
> -			chars_written += 2;
> +			graph_line_write_column(line, col, '\\');
> +			graph_line_addch(line, ' ');
>  		} else {
> -			strbuf_write_column(sb, col, '|');
> -			strbuf_addch(sb, ' ');
> -			chars_written += 2;
> +			graph_line_write_column(line, col, '|');
> +			graph_line_addch(line, ' ');
>  		}
>  	}
>  
> -	graph_pad_horizontally(graph, sb, chars_written);
> +	graph_pad_horizontally(graph, line);
>  
>  	/*
>  	 * Update graph->state
> @@ -1049,7 +1054,7 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct strbuf
>  		graph_update_state(graph, GRAPH_COLLAPSING);
>  }
>  
> -static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf *sb)
> +static void graph_output_collapsing_line(struct git_graph *graph, struct graph_line *line)
>  {
>  	int i;
>  	short used_horizontal = 0;
> @@ -1159,9 +1164,9 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf
>  	for (i = 0; i < graph->mapping_size; i++) {
>  		int target = graph->new_mapping[i];
>  		if (target < 0)
> -			strbuf_addch(sb, ' ');
> +			graph_line_addch(line, ' ');
>  		else if (target * 2 == i)
> -			strbuf_write_column(sb, &graph->new_columns[target], '|');
> +			graph_line_write_column(line, &graph->new_columns[target], '|');
>  		else if (target == horizontal_edge_target &&
>  			 i != horizontal_edge - 1) {
>  				/*
> @@ -1172,16 +1177,16 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf
>  				if (i != (target * 2)+3)
>  					graph->new_mapping[i] = -1;
>  				used_horizontal = 1;
> -			strbuf_write_column(sb, &graph->new_columns[target], '_');
> +			graph_line_write_column(line, &graph->new_columns[target], '_');
>  		} else {
>  			if (used_horizontal && i < horizontal_edge)
>  				graph->new_mapping[i] = -1;
> -			strbuf_write_column(sb, &graph->new_columns[target], '/');
> +			graph_line_write_column(line, &graph->new_columns[target], '/');
>  
>  		}
>  	}
>  
> -	graph_pad_horizontally(graph, sb, graph->mapping_size);
> +	graph_pad_horizontally(graph, line);
>  
>  	/*
>  	 * Swap mapping and new_mapping
> @@ -1199,24 +1204,26 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf
>  
>  int graph_next_line(struct git_graph *graph, struct strbuf *sb)
>  {
> +	struct graph_line line = { .buf = sb, .width = 0 };
> +
>  	switch (graph->state) {
>  	case GRAPH_PADDING:
> -		graph_output_padding_line(graph, sb);
> +		graph_output_padding_line(graph, &line);
>  		return 0;
>  	case GRAPH_SKIP:
> -		graph_output_skip_line(graph, sb);
> +		graph_output_skip_line(graph, &line);
>  		return 0;
>  	case GRAPH_PRE_COMMIT:
> -		graph_output_pre_commit_line(graph, sb);
> +		graph_output_pre_commit_line(graph, &line);
>  		return 0;
>  	case GRAPH_COMMIT:
> -		graph_output_commit_line(graph, sb);
> +		graph_output_commit_line(graph, &line);
>  		return 1;
>  	case GRAPH_POST_MERGE:
> -		graph_output_post_merge_line(graph, sb);
> +		graph_output_post_merge_line(graph, &line);
>  		return 0;
>  	case GRAPH_COLLAPSING:
> -		graph_output_collapsing_line(graph, sb);
> +		graph_output_collapsing_line(graph, &line);
>  		return 0;
>  	}
>  
> @@ -1227,7 +1234,7 @@ int graph_next_line(struct git_graph *graph, struct strbuf *sb)
>  static void graph_padding_line(struct git_graph *graph, struct strbuf *sb)
>  {
>  	int i;
> -	int chars_written = 0;
> +	struct graph_line line = { .buf = sb, .width = 0 };
>  
>  	if (graph->state != GRAPH_COMMIT) {
>  		graph_next_line(graph, sb);
> @@ -1244,20 +1251,17 @@ static void graph_padding_line(struct git_graph *graph, struct strbuf *sb)
>  	for (i = 0; i < graph->num_columns; i++) {
>  		struct column *col = &graph->columns[i];
>  
> -		strbuf_write_column(sb, col, '|');
> -		chars_written++;
> +		graph_line_write_column(&line, col, '|');
>  
>  		if (col->commit == graph->commit && graph->num_parents > 2) {
>  			int len = (graph->num_parents - 2) * 2;
> -			strbuf_addchars(sb, ' ', len);
> -			chars_written += len;
> +			graph_line_addchars(&line, ' ', len);
>  		} else {
> -			strbuf_addch(sb, ' ');
> -			chars_written++;
> +			graph_line_addch(&line, ' ');
>  		}
>  	}
>  
> -	graph_pad_horizontally(graph, sb, chars_written);
> +	graph_pad_horizontally(graph, &line);
>  
>  	/*
>  	 * Update graph->prev_state since we have output a padding line

In addition to this, I'd like to include the following patch that moves the `graph_pad_horizontally()` calls. By the way, what's the best way for me to submit the whole updated patch series after responding to all feedback?

From 97d230c8a8d9b677b331e37482039384589b096a Mon Sep 17 00:00:00 2001
From: James Coglan <jcoglan@gmail.com>
Date: Mon, 14 Oct 2019 12:10:06 +0100
Subject: [PATCH] graph: handle line padding in `graph_next_line()`

Now that the display width of graph lines is implicitly tracked via the
`graph_line` interface, the calls to `graph_pad_horizontally()` no
longer need to be located inside the individual output functions, where
the character counting was previously being done.

All the functions called by `graph_next_line()` generate a line of
output, then call `graph_pad_horizontally()`, and finally change the
graph state if necessary. As padding is the final change to the output
done by all these functions, it can be removed from all of them and done
in `graph_next_line()` instead.

I've also moved the guard in `graph_output_padding_line()` that checks
the graph has a commit; this function is only called by
`graph_next_line()` and we must not pad the `graph_line` if no commit is
set.
---
 graph.c | 49 ++++++++++++++++++++-----------------------------
 1 file changed, 20 insertions(+), 29 deletions(-)

diff --git a/graph.c b/graph.c
index 2f81a5d23d..4c68557b17 100644
--- a/graph.c
+++ b/graph.c
@@ -732,16 +732,6 @@ static void graph_output_padding_line(struct git_graph *graph,
 {
 	int i;
 
-	/*
-	 * We could conceivable be called with a NULL commit
-	 * if our caller has a bug, and invokes graph_next_line()
-	 * immediately after graph_init(), without first calling
-	 * graph_update().  Return without outputting anything in this
-	 * case.
-	 */
-	if (!graph->commit)
-		return;
-
 	/*
 	 * Output a padding row, that leaves all branch lines unchanged
 	 */
@@ -749,8 +739,6 @@ static void graph_output_padding_line(struct git_graph *graph,
 		graph_line_write_column(line, &graph->new_columns[i], '|');
 		graph_line_addch(line, ' ');
 	}
-
-	graph_pad_horizontally(graph, line);
 }
 
 
@@ -767,7 +755,6 @@ static void graph_output_skip_line(struct git_graph *graph, struct graph_line *l
 	 * of the graph is missing.
 	 */
 	graph_line_addstr(line, "...");
-	graph_pad_horizontally(graph, line);
 
 	if (graph->num_parents >= 3 &&
 	    graph->commit_index < (graph->num_columns - 1))
@@ -832,8 +819,6 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
 		graph_line_addch(line, ' ');
 	}
 
-	graph_pad_horizontally(graph, line);
-
 	/*
 	 * Increment graph->expansion_row,
 	 * and move to state GRAPH_COMMIT if necessary
@@ -967,8 +952,6 @@ static void graph_output_commit_line(struct git_graph *graph, struct graph_line
 		graph_line_addch(line, ' ');
 	}
 
-	graph_pad_horizontally(graph, line);
-
 	/*
 	 * Update graph->state
 	 */
@@ -1043,8 +1026,6 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct graph_l
 		}
 	}
 
-	graph_pad_horizontally(graph, line);
-
 	/*
 	 * Update graph->state
 	 */
@@ -1186,8 +1167,6 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct graph_l
 		}
 	}
 
-	graph_pad_horizontally(graph, line);
-
 	/*
 	 * Swap mapping and new_mapping
 	 */
@@ -1204,31 +1183,43 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct graph_l
 
 int graph_next_line(struct git_graph *graph, struct strbuf *sb)
 {
+	int shown_commit_line = 0;
 	struct graph_line line = { .buf = sb, .width = 0 };
 
+	/*
+	 * We could conceivable be called with a NULL commit
+	 * if our caller has a bug, and invokes graph_next_line()
+	 * immediately after graph_init(), without first calling
+	 * graph_update().  Return without outputting anything in this
+	 * case.
+	 */
+	if (!graph->commit)
+		return -1;
+
 	switch (graph->state) {
 	case GRAPH_PADDING:
 		graph_output_padding_line(graph, &line);
-		return 0;
+		break;
 	case GRAPH_SKIP:
 		graph_output_skip_line(graph, &line);
-		return 0;
+		break;
 	case GRAPH_PRE_COMMIT:
 		graph_output_pre_commit_line(graph, &line);
-		return 0;
+		break;
 	case GRAPH_COMMIT:
 		graph_output_commit_line(graph, &line);
-		return 1;
+		shown_commit_line = 1;
+		break;
 	case GRAPH_POST_MERGE:
 		graph_output_post_merge_line(graph, &line);
-		return 0;
+		break;
 	case GRAPH_COLLAPSING:
 		graph_output_collapsing_line(graph, &line);
-		return 0;
+		break;
 	}
 
-	assert(0);
-	return 0;
+	graph_pad_horizontally(graph, &line);
+	return shown_commit_line;
 }
 
 static void graph_padding_line(struct git_graph *graph, struct strbuf *sb)
-- 
2.23.0


