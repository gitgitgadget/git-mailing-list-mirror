Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4140E3CF66B
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 17:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773680663; cv=pass; b=u7MQ985eTFUE13yl0UMKPtuCNip1FN1GvAoGno29n0rw+J3gffd0qZnrH60gbHfkNswUaAwk1sTi87wj3mSrsRSiWAz8oSPRtQsJNWh5Zs1y3DSlF9s1s4on4Bd58NratO23VLjJOgvAm4n4Ui5lIbrKAzL44OxT1p6YDBcPC8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773680663; c=relaxed/simple;
	bh=Vf+jGo/C3rg7xHz06Kq0tBpr732on4o/M5PNZ4CV6lw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aKSuAgBZ1ss9LJAxbR0589/rpW0wxe90vZ3eAhPQhUj1rMtjp9WKq+pssHIDyhxDkjXiQCFz5ZnsuYiBbl6STxZYZlQVd3YhD7EMIFIq5XefU5Xg72xqH9GFOw7cWvo2yv05nZI1wUja0On+I62O6GR6tWEgdJMY02/wUcte1aQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8toM5yl; arc=pass smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8toM5yl"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5ffc6a96602so949062137.0
        for <git@vger.kernel.org>; Mon, 16 Mar 2026 10:04:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773680660; cv=none;
        d=google.com; s=arc-20240605;
        b=StU2ICpDjWS8EvLA0SPDdRNT3oNrQpGHqYAFg1GMeJhy7w8DidRCDIEZvGjIv+ANuN
         LkO6fYR5WLRgxhGTWtaQ/552wHSkaTuU1AtMMlYcxNm+aDuK19GUgz4ujHCIQdpVzdwd
         YEJnfZLoX7RQIj4IqsT2N+H7jWrIU7T9a1kB+0yxFj+JwROMZC/H/brL331MiEGGSCxK
         3+KUaQVxAyzG6YOxO9/jhLJNSO4aEOg3FnTsI9mVAncxoXiW4WFcfq4PHckbMRzKhu6y
         va7+SCorgjlQAjxHWJlpAcOyOzGOvVnXAEJznUnYCHXLsRkE/jbqTnbRbJ1FECsDW47L
         eSGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=ieJFBFtS1XcJFSNV4/FueELoPJVOY2Hsm+RYZ4YEKFo=;
        fh=QhjMBNBIlZ/NPTAx3bWaIpzMsABow/tQSpnf5QNbDJY=;
        b=ehmizF+NIyFnbQDTpoYzZ3L1XBKu+Byn5l7POfzKLiKquj25ZNNqUQsj9LxNVdNDv3
         cUD7fNu9/fRKXqSxFPjxfGU21Z9Kkj41UhD7LazEt3e96T1o7Eh2HDHztD2SzFAzXDNX
         1cqfW99y0MZ9kMoKOvKhubdWhSxmGlwtj7Zthw1/spiWl8ugzezFL8U5fAaVRkZiGdSM
         9ZWXcnEF6Ca/CF/9dTyeAxSkS4D0+V41viDkokPLBN6KttcsNDuaUypoouiwijaAC+zV
         vbZI6SiI5Qi7IMMl2PR4n+k96s/8thm/oCnkZipN2bTgJz41E6m+VZyvIHhSOytcy/m/
         BEBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773680660; x=1774285460; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ieJFBFtS1XcJFSNV4/FueELoPJVOY2Hsm+RYZ4YEKFo=;
        b=l8toM5ylDT2sVIc6iv0t4+O7js22AXZN779RIJ1yY7YjwrOtkuhmpJXes0sDwGvG7t
         Nhxmx6TfdslZK/xkxbHQVNnXXSFNjWO+Q4qkl5IvE1tstTbV53T01mWAb0wdr+gRN37s
         VewNc7x1Wx4ljTFmw6vxfhIzNGXXP8eDDeyLPKSIpfBtAahD/YZ6i0gscVgZzl6OJqOb
         97wWXCv3KlylSqUOcYo0zeQvA/bc9z9D699Fe10LZm3tUuq3EhMX9HYEXUSjn1swX2mH
         QMCKWcHDxOp/EORgc5yL1g6JZKnmoZZubzzzw0/5Q6zCEjjxFs+g2Jom+69nLxKHTLuy
         dftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773680660; x=1774285460;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ieJFBFtS1XcJFSNV4/FueELoPJVOY2Hsm+RYZ4YEKFo=;
        b=r0dAhDAtd6haBDWqlax0zIvPGDY30Nx287NSSa9v5Gcslo6kL39Bz8Lys4rQe7bSnx
         y/10RprWohNCHWjCjDqmVSldw1+N7UHfZf8m2JtgTXOtDd9Cb59/NYXL9qo7wldEikD2
         jNSQE1JwvlLeP1m+rXkOi2DD24Y8T6QLlYyZd5UveJll7I3Qol6v/m1dydGWW8apIU/J
         W6ooqy047uodrKZTqDAo4UN+JjgAJkiQ8a/F1VLWLbdEG9yyxwNr/EB5oG5votX70zB+
         UAubmHnhsSv52nKpUszJSH3BZAXUuiMzLdNXQ5FHb5NI9TBIGrxNbNJGksI6QMOjI1Rf
         iLDw==
X-Forwarded-Encrypted: i=1; AJvYcCWamUNjogy7lkWxQXgeNTpQGI/kPmhQUrZgWXZdFFHjWwMFAHT1U8955IrS0A7c5b9SH3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3M3aznTREZC4bjfejDFUUMiMKllC/YVDykWzk5VgXmlqgcICT
	0o3XA+qbIu2H/EnNr8NAjyaV4Oaq1YG0I5ry/bSpk961kCXKC5SMCxIbtl0Wl/b3duSAFdZFICv
	ajkXfgXk1VwH4pz1vkTGLaUWbfv/jawQ=
X-Gm-Gg: ATEYQzwFgL7OHsvdUV7A6Lp9zbOSY9gz/8BJXn0aT3aqU637SpCBFUoaFU1ZrcnOfKC
	o/JNnuwZ3hQ/K2Sc9Pv0/Qu4Ias3PIAMmFLyi8Dg+haH1QUaDRrbZFW3CkJWy8NS6Uw9BDwpTkJ
	zn7ZCUJAoJXSGb7+I/U2S+dJVztnVBQExAem9jJMCTBJ39fidssU4hEs0qcaGMi/HnCcUripzGx
	xCK+rlrPnE8FXPgddcmXaUQnnb6UpwX0TYn/88URUz7fi/SCy0rX4uN9ClA7Wn5W4mAhCOA99Rx
	CxZEOnvAbCYZYcqp5XP6wbEaVS3Q35xmROLn28rw
X-Received: by 2002:a05:6102:d87:b0:5e8:1d93:921a with SMTP id
 ada2fe7eead31-6020e2823b8mr5685974137.15.1773680659971; Mon, 16 Mar 2026
 10:04:19 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 16 Mar 2026 10:04:18 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 16 Mar 2026 10:04:18 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260316133426.117684-1-pabloosabaterr@gmail.com>
References: <20260316133426.117684-1-pabloosabaterr@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 16 Mar 2026 10:04:18 -0700
X-Gm-Features: AaiRm51xlJo_za9XDLGpzsjhvUqxHPMc2BbnozW84yG5EiFh2YBFWsn_WJo62Iw
Message-ID: <CAOLa=ZSsC7zpfpRx8pShcqGEv_2_NMrKzJHCgTSaO=0Dg0xakg@mail.gmail.com>
Subject: Re: [GSoC RFC PATCH] graph: add --graph-max option to limit displayed columns
To: Pablo Sabater <pabloosabaterr@gmail.com>, git@vger.kernel.org
Cc: christian.couder@gmail.com, jltobler@gmail.com, ayu.chandekar@gmail.com, 
	siddharthasthana31@gmail.com, chandrapratap3519@gmail.com
Content-Type: multipart/mixed; boundary="000000000000aef13c064d273503"

--000000000000aef13c064d273503
Content-Type: text/plain; charset="UTF-8"

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> When there are multiple branches, --graph-max modifies the maximum
> amount of columns that will be displayed.
>
> Add "--graph-max=<n>" option to cap how many columns will be shown,
> columns after the limit are replaced with a single '.'. Changes only
> the output rendering.
>

The first sentence seems to talk about the option like it already
exists, when the second para introduces it. It would be nice if the
first para explained the problem we're trying to solve and why and the
second para then dove into the solution space.

Do you think '--graph-max' signifies that we're talking about the
maximum columns to display?

> Define MINIMUM_GRAPH_COLUMNS constant to validate the option value.

What does this mean? Validate how?

> The commit character '*' is always shown no matter what the limit is.

I think overall a little more explanation in the commit message makes it
easier to understand the context and also helps reviewers!

Shouldn't we also talk about the todo and the commit (c12172d2ea (Add
history graph API, 2008-05-04)) in which it was added?

>
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---
>
> This addresses the TODO at graph.c:
>
>   TODO:
>       - Limit the number of columns, similar to the way gitk does.
>         If we reach more than a specified number of columns, omit
>         sections of some columns.
>

One question to ask is, is this even needed anymore and does it really
make sense to add it?

The TODO was added back in 2008, that's ~16 years ago and was not
touched till now. So perhaps no one needs it? If so, maybe the smarter
option is to simply remove the TODO?

Or do you see a usecase where this is useful? If so, it would be nice to
talk about that in the commit message.

> About the design of how this would have to be:
>
> - Should '--graph-max' by itself be enough to implicitly work like '--graph' so
>   'git log --graph-max=3' works without needing to write '--graph'?

My preference would be not to have implicit behavior but also at the
same time guide the user in the right path, so:

     $ git log --graph-max=4
     fatal: --graph-max used without --graph

> - graph_max_columns by default is set to 0, meaning no limit, and any other
>   positive value becomes a limit. Is this a good design? it cannot be negative,
>   shouldn't it be a uint32_t instead, I left it as a int because of the other
>   variables like this that are int. like skip_count, max_count, etc.
> - Is '--graph-max' a good name?

I would argue against it. Perhaps '--graph-col-limit'? It's a bit handy though.

> - Is '.' a good char for truncation?

Trying it out:

$ git log --graph --oneline --graph-max=3

| * ba1c21d343 odb: split `struct odb_source` into separate header
| *   b1af291b4a Merge branch 'ps/object-info-bits-cleanup' into ps/odb-sources
| |\
| * \   703c97519d Merge branch 'ps/odb-for-each-object' into ps/odb-sources
| |\ \
* | \ .   d0413b31dd Merge branch 'hn/status-compare-with-push'
|\ \ \ .
| * | .   68791d7506 status: clarify how status.compareBranches deduplicates
| * | .   3ea95ac9c5 (gitster/hn/status-compare-with-push) status: add
status.compareBranches config for multiple branch comparisons
| * | .   04f47265c1 refactor format_branch_comparison in preparation
| * | .     2aa9b75b43 Merge branch 'jk/remote-tracking-ref-leakfix'
into hn/status-compare-with-push
| |\ \ .
* | \ .       03161747b4 Merge branch 'ds/for-each-repo-w-worktree'
|\ \ \ .
| * | .       e87493b9b4 for-each-repo: simplify passing of parameters
| * | .       2ef539bcee for-each-repo: work correctly in a worktree
| * | .       5f031fe4f1 run-command: extract sanitize_repo_env helper
| * | .       c5e62e1aa0 for-each-repo: test outside of repo context
* | | .       67006b9db8 The 15th batch
* | | .         99da934835 Merge branch 'sp/send-email-validate-charset'
|\ \ \ .
| * | .         c52f085a47 (gitster/sp/send-email-validate-charset)
send-email: validate charset name in 8bit encoding prompt

vs

$ git log --graph --oneline

| * ba1c21d343 odb: split `struct odb_source` into separate header
| *   b1af291b4a Merge branch 'ps/object-info-bits-cleanup' into ps/odb-sources
| |\
| * \   703c97519d Merge branch 'ps/odb-for-each-object' into ps/odb-sources
| |\ \
* | \ \   d0413b31dd Merge branch 'hn/status-compare-with-push'
|\ \ \ \
| * | | | 68791d7506 status: clarify how status.compareBranches deduplicates
| * | | | 3ea95ac9c5 (gitster/hn/status-compare-with-push) status: add
status.compareBranches config for multiple branch comparisons
| * | | | 04f47265c1 refactor format_branch_comparison in preparation
| * | | |   2aa9b75b43 Merge branch 'jk/remote-tracking-ref-leakfix'
into hn/status-compare-with-push
| |\ \ \ \
* | \ \ \ \   03161747b4 Merge branch 'ds/for-each-repo-w-worktree'
|\ \ \ \ \ \
| * | | | | | e87493b9b4 for-each-repo: simplify passing of parameters
| * | | | | | 2ef539bcee for-each-repo: work correctly in a worktree
| * | | | | | 5f031fe4f1 run-command: extract sanitize_repo_env helper
| * | | | | | c5e62e1aa0 for-each-repo: test outside of repo context
* | | | | | | 67006b9db8 The 15th batch
* | | | | | |   99da934835 Merge branch 'sp/send-email-validate-charset'
|\ \ \ \ \ \ \
| * | | | | | | c52f085a47 (gitster/sp/send-email-validate-charset)
send-email: validate charset name in 8bit encoding prompt

So we still keep the spaces, but only remove the column indicator

> - Should '/' to outside branches be shown?
> - What should it be done when a commit is in a column that is truncated?
>
> known limitations:
>
> - Post merge lines have some trouble with the padding.
>
> I added two tests for example, but I will add better test coverage as design
> choices are more clear. testing on the Git repo itself is a good example also.
>
>  graph.c                      | 52 +++++++++++++++++++++++++++------
>  graph.h                      |  2 ++
>  revision.c                   |  7 +++++
>  revision.h                   |  1 +
>  t/t4215-log-skewed-merges.sh | 56 ++++++++++++++++++++++++++++++++++++
>  5 files changed, 109 insertions(+), 9 deletions(-)
>
> diff --git a/graph.c b/graph.c
> index 26f6fbf000..7ae0ab61b7 100644
> --- a/graph.c
> +++ b/graph.c
> @@ -42,14 +42,6 @@ static void graph_padding_line(struct git_graph *graph, struct strbuf *sb);
>  static void graph_show_strbuf(struct git_graph *graph,
>  			      FILE *file,
>  			      struct strbuf const *sb);
> -
> -/*
> - * TODO:
> - * - Limit the number of columns, similar to the way gitk does.
> - *   If we reach more than a specified number of columns, omit
> - *   sections of some columns.
> - */
> -
>  struct column {
>  	/*
>  	 * The parent commit of this column.
> @@ -317,6 +309,12 @@ struct git_graph {
>  	struct strbuf prefix_buf;
>  };
>
> +static int graph_is_truncated(struct git_graph *graph, int col)

Isn't this more of `graphs_needs_truncation()`?

> +{
> +	int max = graph->revs->graph_max_columns;
> +	return max > 0 && col >= max;
> +}
> +
>  static const char *diff_output_prefix_callback(struct diff_options *opt, void *data)
>  {
>  	struct git_graph *graph = data;
> @@ -846,6 +844,10 @@ static void graph_output_padding_line(struct git_graph *graph,
>  	 * Output a padding row, that leaves all branch lines unchanged
>  	 */
>  	for (i = 0; i < graph->num_new_columns; i++) {
> +		if (graph_is_truncated(graph, i)) {
> +			graph_line_addstr(line, ". ");
> +			break;
> +		}
>  		graph_line_write_column(line, &graph->new_columns[i], '|');
>  		graph_line_addch(line, ' ');
>  	}
> @@ -903,6 +905,9 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
>  			seen_this = 1;
>  			graph_line_write_column(line, col, '|');
>  			graph_line_addchars(line, ' ', graph->expansion_row);
> +		} else if (seen_this && graph_is_truncated(graph, i)) {
> +			graph_line_addstr(line, ". ");
> +			break;
>  		} else if (seen_this && (graph->expansion_row == 0)) {
>  			/*
>  			 * This is the first line of the pre-commit output.
> @@ -1013,6 +1018,7 @@ static void graph_output_commit_line(struct git_graph *graph, struct graph_line
>  	 * children that we have already processed.)
>  	 */
>  	seen_this = 0;
> +
>  	for (i = 0; i <= graph->num_columns; i++) {
>  		struct column *col = &graph->columns[i];
>  		struct commit *col_commit;
> @@ -1028,8 +1034,14 @@ static void graph_output_commit_line(struct git_graph *graph, struct graph_line
>  			seen_this = 1;
>  			graph_output_commit_char(graph, line);
>
> +			if (graph_is_truncated(graph, i))
> +				break;
> +
>  			if (graph->num_parents > 2)
>  				graph_draw_octopus_merge(graph, line);
> +		} else if (seen_this && graph_is_truncated(graph, i)) {
> +			graph_line_addstr(line, ". ");
> +			break;
>  		} else if (seen_this && (graph->edges_added > 1)) {
>  			graph_line_write_column(line, col, '\\');
>  		} else if (seen_this && (graph->edges_added == 1)) {
> @@ -1109,9 +1121,15 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct graph_l
>  			int par_column;
>  			int idx = graph->merge_layout;
>  			char c;
> +			int truncated = 0;
>  			seen_this = 1;
>
>  			for (j = 0; j < graph->num_parents; j++) {
> +				if (graph_is_truncated(graph, i + j)) {
> +					graph_line_addstr(line, ". ");
> +					truncated = 1;
> +					break;
> +				}
>  				par_column = graph_find_new_column_by_commit(graph, parents->item);
>  				assert(par_column >= 0);
>
> @@ -1125,10 +1143,15 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct graph_l
>  				}
>  				parents = next_interesting_parent(graph, parents);
>  			}
> +			if (truncated)
> +				break;
>  			if (graph->edges_added == 0)
>  				graph_line_addch(line, ' ');
> -
>  		} else if (seen_this) {
> +			if (graph_is_truncated(graph, i)) {
> +				graph_line_addstr(line, ". ");
> +				break;
> +			}
>  			if (graph->edges_added > 0)
>  				graph_line_write_column(line, col, '\\');
>  			else
> @@ -1279,6 +1302,12 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct graph_l
>  	 */
>  	for (i = 0; i < graph->mapping_size; i++) {
>  		int target = graph->mapping[i];
> +
> +		if (graph_is_truncated(graph, i / 2)) {
> +			graph_line_addstr(line, ". ");
> +			break;
> +		}
> +
>  		if (target < 0)
>  			graph_line_addch(line, ' ');
>  		else if (target * 2 == i)
> @@ -1372,6 +1401,11 @@ static void graph_padding_line(struct git_graph *graph, struct strbuf *sb)
>  	for (i = 0; i < graph->num_columns; i++) {
>  		struct column *col = &graph->columns[i];
>
> +		if (graph_is_truncated(graph, i)) {
> +			graph_line_addch(&line, '.');
> +			break;
> +		}
> +
>  		graph_line_write_column(&line, col, '|');
>
>  		if (col->commit == graph->commit && graph->num_parents > 2) {
> diff --git a/graph.h b/graph.h
> index 3fd1dcb2e9..9a4551dd29 100644
> --- a/graph.h
> +++ b/graph.h
> @@ -262,4 +262,6 @@ void graph_show_commit_msg(struct git_graph *graph,
>  			   FILE *file,
>  			   struct strbuf const *sb);
>
> +#define MINIMUM_GRAPH_COLUMNS 1
> +
>  #endif /* GRAPH_H */
> diff --git a/revision.c b/revision.c
> index 31808e3df0..ba5088be14 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2605,6 +2605,13 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>  	} else if (!strcmp(arg, "--no-graph")) {
>  		graph_clear(revs->graph);
>  		revs->graph = NULL;
> +	} else if (skip_prefix(arg, "--graph-max=", &optarg)) {
> +		revs->graph_max_columns = strtoul(optarg, NULL, 10);
> +		if (revs->graph_max_columns < MINIMUM_GRAPH_COLUMNS) {
> +			die(_("minimum columns is %d, unable to set below %d"),
> +			MINIMUM_GRAPH_COLUMNS,
> +			revs->graph_max_columns);

Shouldn't we allow users to set 0? That combined with an unsigned int
would:
1. remove the need for MINIMUM_GRAPH_COLUMNS
2. allow users to specify that they do not want a column limit

> +		}
>  	} else if (!strcmp(arg, "--encode-email-headers")) {
>  		revs->encode_email_headers = 1;
>  	} else if (!strcmp(arg, "--no-encode-email-headers")) {
> diff --git a/revision.h b/revision.h
> index 69242ecb18..6442129c14 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -304,6 +304,7 @@ struct rev_info {
>
>  	/* Display history graph */
>  	struct git_graph *graph;
> +	int graph_max_columns;
>

I think it makes sense to make this an unsigned int.

>  	/* special limits */
>  	int skip_count;
> diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
> index 28d0779a8c..6266de4e2b 100755
> --- a/t/t4215-log-skewed-merges.sh
> +++ b/t/t4215-log-skewed-merges.sh
> @@ -370,4 +370,60 @@ test_expect_success 'log --graph with multiple tips' '
>  	EOF
>  '
>
> +test_expect_success 'log --graph --graph-max=2 only two columns' '
> +	check_graph --graph-max=2 M_7 <<-\EOF
> +	*-.   7_M4
> +	|\ .
> +	| | * 7_G
> +	| | * 7_F
> +	| * . 7_E
> +	| * . 7_D
> +	* | . 7_C
> +	| |/
> +	|/|
> +	* | 7_B
> +	|/
> +	* 7_A
> +	EOF
> +'
> +
> +test_expect_success 'log --graph --graph-max=3 only three columns' '
> +	check_graph --graph-max=3 M_1 M_3 M_5 M_7 <<-\EOF
> +	*   7_M1
> +	|\
> +	| | *   7_M2
> +	| | |.
> +	| | | * 7_H
> +	| | | | *   7_M3
> +	| | | | .
> +	| | | | | * 7_J
> +	| | | | *   7_I
> +	| | | | | | *   7_M4
> +	| |_|_|_|_|.
> +	|/| | .
> +	| | |_.
> +	| |/|_.
> +	| |/|_.
> +	| |/| .
> +	| | |/.
> +	| | * .     7_G
> +	| | | .
> +	| | |/.
> +	| | |/.
> +	| | * .   7_F
> +	| * | .   7_E
> +	| | |/.
> +	| |/| .
> +	| * | . 7_D
> +	| | |/
> +	| |/|
> +	* | | 7_C
> +	| |/
> +	|/|
> +	* | 7_B
> +	|/
> +	* 7_A
> +	EOF
> +'
> +
>  test_done
> --
> 2.43.0
v

--000000000000aef13c064d273503
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 4ee231e04cb64ca5_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tNE9CQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM1BXQy85VkFXWkNUVnNIaHEvc0F3RVcyYkZVSU5ZZQpmbFVKNFp4OWVy
RnFTSyt6WjliUUFiZEFEWjAzZUlpUjVVZHpzUXhiK2V6RG14NVFiY2t3Y24zVmViMEdJREpnCndT
OVdnb3RZak1qNDFrMVNrVzJCMFlaQjZKQk04SXBuSFMvSGRXWnhXT29HYjFOYUZCT2pUbHV3TzQv
YnQ3M3YKd1UyRzNLdXQxM2JXMDRXYmI5cDRuK2EyWHRIODh6UVVBU3NhdGNwVVRkVE5MV1p2azdH
OU5mUXExeG5QcDNraAoyMkoxYXB6eE9Ba0VlZFh6N2Y2N3RlRDBQS1JBTVc0Qjd2eW1vMGJqTTda
cHpOL1Fqd2c0K2FrcEk3RFN1WVN5CmtGTkROelF2VFQ0ZEt5dlNaOUZpcGwwMmxDRWZXVlVDbEla
VXlESGRWZlZ1V1B3SE9jWFBaSmZ2TVIrT09TNHgKVGt4Vy9mNjJha1h5MHFJL3dOTEV5cVBXVmJh
WFNEWUtJUTgzUXg2TW9BeXlCcHlFd1I5QldVVlhzUHp6R09DUAprNzl2U0ozMUFmTWlzaTFjTVhL
ejlpT1dqSTY4OHZQS005Z3BMRDlGQUtvTm4xZzRpblRMMGM0RjRJQU9zNUlFCjlIanR0OVp5WEJE
QzNsWGdlb2xMZ2FnOCtCRkhzMFJlRXdMVSs2Yz0KPUJEMkgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000aef13c064d273503--
