Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 652D51F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 01:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbeJJJDg (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 05:03:36 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34139 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbeJJJDf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 05:03:35 -0400
Received: by mail-wm1-f68.google.com with SMTP id z25-v6so12243941wmf.1
        for <git@vger.kernel.org>; Tue, 09 Oct 2018 18:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jN1OVK1qY3+d4TO0wvEsnv73zJGt5wmUzSG6ViDUgyI=;
        b=ljUOngv5dywyuF+Cbfen34WpwkdmX7gnNdVT5M5x0e9j3VwmgGiFfjAX4sa/vlrTJk
         w4OL5U9x4GfLuKSscuKcBxRy31hGICr+Q7LzF+S8GcMSaHPEY04dKwGV0VpCDGFQ/U8H
         ea5znvvfkIjKfmkLJb3YV6VoPnIhCabtV2lvIw2DjMenXB1ZdwAspotfHFS32K4F7HFd
         g/A1QTupK3hadkfAkHR/Uz/v5TbF0qoC9unaPLimpuZPWUEtpm7kTnvr9wfQEzbbS7FD
         OKahU+CySqClPwEDfAx54tQty4i3VmULLtpG7Kk3tSBvjrEvAIdTVUPV5bVHDy72BLKp
         OUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jN1OVK1qY3+d4TO0wvEsnv73zJGt5wmUzSG6ViDUgyI=;
        b=CSZDwda8nehUiIoZNhqiM+hGhiiXu33U4tSC5gA/CakAZsKvA9ZCYy+9VAKlvSn6r3
         G3Zj+f6ml5lRMCUVUHN0/DwPqhknAIZBPrr8l7VPT0jZy9D3/0UEmwr9OeXJ9X/DBFKT
         CK2XGhfiXbHzIyMZgNNiXtGGsGUI4BSOcMVfW5c6+2nc6L/rGgFGThUzLQnkeAiG4xuA
         l6yVH2SeTMfq96FT2f061zxR2uaPd3Q1DSwkvhN9V/YcVPzmfNKaPgvBt50gri6e+Avu
         Qaj7mo3VNgDFkFREeXMHIsx4NcZj+icF55/MLpHxCyEkVaISGys6X1+BdmORaFevlLVs
         kSWA==
X-Gm-Message-State: ABuFfoiKmwz+SmZRyYnv8cMXDvR7ynarvpl5k51Ak3P3epwS5Ft6YaLa
        l/xrftYQx4+jqderNJD4FwI=
X-Google-Smtp-Source: ACcGV61GcyYtmeU7TIX6yFAPPhWd/jUoNpYN83hnGSAwifha4CsUYCSSDTrQEfGhmtSb2yaK5W4oCA==
X-Received: by 2002:a1c:f313:: with SMTP id q19-v6mr3573389wmq.87.1539135827021;
        Tue, 09 Oct 2018 18:43:47 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g76-v6sm15633972wmd.25.2018.10.09.18.43.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 18:43:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Noam Postavsky <npostavs@users.sourceforge.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v6] log: fix coloring of certain octupus merge shapes
References: <20181010003743.17198-1-npostavs@users.sourceforge.net>
Date:   Wed, 10 Oct 2018 10:43:44 +0900
In-Reply-To: <20181010003743.17198-1-npostavs@users.sourceforge.net> (Noam
        Postavsky's message of "Tue, 9 Oct 2018 20:37:43 -0400")
Message-ID: <xmqqzhvmmv8v.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Noam Postavsky <npostavs@users.sourceforge.net> writes:

> For octopus merges where the first parent edge immediately merges into
> the next column to the left:
>
> | *-.
> | |\ \
> |/ / /
>
> then the number of columns should be one less than the usual case:
>
> | *-.
> | |\ \
> | | | *

I had a bit hard time parsing the above, especially with "then",
which probably would make it easier to read if it is not there.

> Also refactor the code to iterate over columns rather than dashes,
> building from an initial patch suggestion by Jeff King.

s/suggestion/suggested/ perhaps?

>
> Signed-off-by: Noam Postavsky <npostavs@users.sourceforge.net>
> Reviewed-by: Jeff King <peff@peff.net>
> ---

Thanks, both.

>  /*
> + * Draw the horizontal dashes of an octopus merge and return the number of
> + * characters written.
>   */
>  static int graph_draw_octopus_merge(struct git_graph *graph,
>  				    struct strbuf *sb)
>  {
>  	/*
> +	 * Here dashless_parents represents the number of parents which don't
> +	 * need to have dashes (the edges labeled "0" and "1").  And
> +	 * dashful_parents are the remaining ones.

Here "dash" refers to that horizontal line on the same line as the
resulting merge.  A very clearly explained definition.  OK.

> +	 * | *---.
> +	 * | |\ \ \
> +	 * | | | | |
> +	 * x 0 1 2 3
> +	 *
> +	 */
> +	const int dashless_parents = 2;

That counts parent #0 (the first parent) and parent #1.

> +	int dashful_parents = graph->num_parents - dashless_parents;

When a mistaken caller calls this function on a commit that is not
an octopus, this can underflow.  dashful_parents would be -1 for a
non-merge, dashful_parents would be 0 for a normal merge, and then
dashful_parents would be 1 for a merge of three histories.  OK.

> +	/*
> +	 * Usually, each parent gets its own column, like the diagram above, but
> +	 * sometimes the first parent goes into an existing column, like this:
> +	 *
> +	 * | *---.
> +	 * | |\ \ \
> +	 * |/ / / /
> +	 * x 0 1 2
> +	 *
> +	 * In which case there will be more parents than the delta of columns.
> +	 */

It is unclear to me what "delta of columns" means here.  Is this
because I am unfamiliar with the internal of graph.[ch] API (and
'delta of columns' is used elsewhere in the API internals already)?

> +	int delta_cols = (graph->num_new_columns - graph->num_columns);

So in the second picture above, new-columns (which is the columns
used after showing the current line) is narrower (because 'x' reuses
an already allocated column without getting a new one) than columns
(which is the columns for the octopus merge we are showing)?

I am not sure I follow what is going on around here, sorry.

> +	int parent_in_old_cols = graph->num_parents - delta_cols;
> +	/*
> +	 * In both cases, commit_index corresponds to the edge labeled "0".
> +	 */
> +	int first_col = graph->commit_index + dashless_parents
> +	    - parent_in_old_cols;
> +
> +	int i;
> +	for (i = 0; i < dashful_parents; i++) {
> +		strbuf_write_column(sb, &graph->new_columns[i+first_col], '-');
> +		strbuf_write_column(sb, &graph->new_columns[i+first_col],
> +				    i == dashful_parents-1 ? '.' : '-');

Draw a dash-dash for each, except we show dash-dot only for the last
one.  OK.  It is interesting that dashful_parents does not have to
change between the two examples you gave above, and it is
understandable because it only depends on the shape of the graph
near the octopus merge itself (in other words, the placement of the
parent commits does not contribute to it at all).  Makes sense.

>  	}
> -	col_num = (i / 2) + dashless_commits + graph->commit_index;
> -	strbuf_write_column(sb, &graph->new_columns[col_num], '.');
> -	return num_dashes + 1;
> +	return 2 * dashful_parents;

This is natural, as we showed either dash-dash or dash-dot only for
dashful_parents after the merge itself. OK.

Thanks, will queue.

