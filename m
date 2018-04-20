Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32E331F404
	for <e@80x24.org>; Fri, 20 Apr 2018 17:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751325AbeDTRRQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 13:17:16 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33669 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751130AbeDTRRP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 13:17:15 -0400
Received: by mail-wr0-f195.google.com with SMTP id z73-v6so24868506wrb.0
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 10:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=tpHTa7WCWrIbC0LqP/KslGNJDYoW/tdyjSydxh6nKMg=;
        b=VYI2sydx6oAfP6asNeLsO1cTrBKGvktwFs0NP7ird/WHXBoRaqbgo4vaOsL85GTDkP
         2uXvnvDz3k3PV4uVl3Xhgy8IPIV+yXOepNMA1iQ7ASy5nHLs4NcZA71xU4X+gwMeig2e
         9NWTh5vJONoC88XzFWfJ5dl7NO+F1bT3srFqjKuLwaTFmlQsP/pp7bgn91dvoBVgyGaC
         954ga+69MQR/PiNoPbq7yRGywm3Q8Lz+MCMORNFi3pzylUnqpJhpSflREtNm81z/4Pg3
         Heya+bRcdrZXWZvkTj2jqaRZcjCS1IpnsB/RvOUi8/q2y2VADL+1+wWQ91sGOqMiHCMp
         0O3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=tpHTa7WCWrIbC0LqP/KslGNJDYoW/tdyjSydxh6nKMg=;
        b=Pp0q3l8A5O0ZhP8An2JwukSI/7SXkqmNQNoX7XbrcL4l8EEh0K/PHz6fVUGcvBE7dx
         B/+UafvPvRBhucyDVsSUq1JfuDrIK4aa2Y2cFQ0FtI/qvq9XJXjZP72F08DuCI8u+E8B
         +0I0jNZ5z0WqIfMRCHN+En7uxV+aTo6P8UCoiSMluBKt0lUMUccQphnR5qoNwDgyC7+p
         YQYmyqmN9TUtVeDbP6/yOMjBOjbvxBkpNh2B10Paf5dEsshmDYMuSzrbD6RTZMVwSIwW
         lOH8yK151Xy0iapUIQBwNOxTO2b6wX6Ybl9fymQtesmVy+2PA8FtAYihQ5Td+eFo2O6R
         WdLw==
X-Gm-Message-State: ALQs6tCmL+9ebwBlOlrcDVFI6TtOFlGHq3NBvp2C6ZBSyUreBK/Z+68x
        qRZs8CLolerysMZ/3EMOHM8ZThq6
X-Google-Smtp-Source: AIpwx48jAUaejbvWo1I+2Bob2aHxPf6gMq99wYi7P5eho1sl5W5aNKD2Br2pYp4Ue/2Mt5wn2D4JMQ==
X-Received: by 2002:adf:884c:: with SMTP id e12-v6mr9129098wre.30.1524244633837;
        Fri, 20 Apr 2018 10:17:13 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egc153.neoplus.adsl.tpnet.pl. [83.21.66.153])
        by smtp.gmail.com with ESMTPSA id p35-v6sm9200652wrb.12.2018.04.20.10.17.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Apr 2018 10:17:12 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH 10/12] commit-graph: add '--reachable' option
References: <20180417181028.198397-1-dstolee@microsoft.com>
        <20180417181028.198397-11-dstolee@microsoft.com>
Date:   Fri, 20 Apr 2018 19:17:12 +0200
In-Reply-To: <20180417181028.198397-11-dstolee@microsoft.com> (Derrick
        Stolee's message of "Tue, 17 Apr 2018 18:10:44 +0000")
Message-ID: <864lk5er1j.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> When writing commit-graph files, it can be convenient to ask for all
> reachable commits (starting at the ref set) in the resulting file. This
> is particularly helpful when writing to stdin is complicated, such as a
> future integration with 'git gc' which will call
> 'git commit-graph write --reachable' after performing cleanup of the
> object database.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

For what it is worth, it looks good to me.

> ---
>  Documentation/git-commit-graph.txt |  8 ++++--
>  builtin/commit-graph.c             | 41 +++++++++++++++++++++++++++---
>  t/t5318-commit-graph.sh            | 10 ++++++++
>  3 files changed, 53 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
> index 93c7841ba2..1b14d40590 100644
> --- a/Documentation/git-commit-graph.txt
> +++ b/Documentation/git-commit-graph.txt
> @@ -37,12 +37,16 @@ Write a commit graph file based on the commits found in packfiles.
>  +
>  With the `--stdin-packs` option, generate the new commit graph by
>  walking objects only in the specified pack-indexes. (Cannot be combined
> -with --stdin-commits.)
> +with --stdin-commits or --reachable.)
>  +
>  With the `--stdin-commits` option, generate the new commit graph by
>  walking commits starting at the commits specified in stdin as a list
>  of OIDs in hex, one OID per line. (Cannot be combined with
> ---stdin-packs.)
> +--stdin-packs or --reachable.)
> ++
> +With the `--reachable` option, generate the new commit graph by walking
> +commits starting at all refs. (Cannot be combined with --stdin-commits
> +or --stind-packs.)

I wonder if this "cannot be combined" is sustainable... ;-)


[...]
> @@ -113,6 +115,25 @@ static int graph_read(int argc, const char **argv)
>  	return 0;
>  }
>  
> +struct hex_list {
> +	char **hex_strs;
> +	int hex_nr;
> +	int hex_alloc;
> +};
> +
> +static int add_ref_to_list(const char *refname,
> +			   const struct object_id *oid,
> +			   int flags, void *cb_data)
> +{
> +	struct hex_list *list = (struct hex_list*)cb_data;
> +
> +	ALLOC_GROW(list->hex_strs, list->hex_nr + 1, list->hex_alloc);
> +	list->hex_strs[list->hex_nr] = xcalloc(GIT_MAX_HEXSZ + 1, 1);
> +	strcpy(list->hex_strs[list->hex_nr], oid_to_hex(oid));
> +	list->hex_nr++;
> +	return 0;
> +}
> +
>  static int graph_write(int argc, const char **argv)
>  {
>  	const char **pack_indexes = NULL;
> @@ -127,6 +148,8 @@ static int graph_write(int argc, const char **argv)
>  		OPT_STRING(0, "object-dir", &opts.obj_dir,
>  			N_("dir"),
>  			N_("The object directory to store the graph")),
> +		OPT_BOOL(0, "reachable", &opts.reachable,
> +			N_("start walk at all refs")),
>  		OPT_BOOL(0, "stdin-packs", &opts.stdin_packs,
>  			N_("scan pack-indexes listed by stdin for commits")),
>  		OPT_BOOL(0, "stdin-commits", &opts.stdin_commits,
> @@ -140,8 +163,8 @@ static int graph_write(int argc, const char **argv)
>  			     builtin_commit_graph_write_options,
>  			     builtin_commit_graph_write_usage, 0);
>  
> -	if (opts.stdin_packs && opts.stdin_commits)
> -		die(_("cannot use both --stdin-commits and --stdin-packs"));
> +	if (opts.reachable + opts.stdin_packs + opts.stdin_commits > 1)
> +		die(_("use at most one of --reachable, --stdin-commits, or --stdin-packs"));

Nice trick, but is it worth it (in place of boolean expression)?  Though
it lines up with the error message, though...

>  	if (!opts.obj_dir)
>  		opts.obj_dir = get_object_directory();
>  
> @@ -164,6 +187,16 @@ static int graph_write(int argc, const char **argv)
>  			commit_hex = lines;
>  			commits_nr = lines_nr;
>  		}
> +	} else if (opts.reachable) {
> +		struct hex_list list;
> +		list.hex_nr = 0;
> +		list.hex_alloc = 128;
> +		ALLOC_ARRAY(list.hex_strs, list.hex_alloc);
> +
> +		for_each_ref(add_ref_to_list, &list);
> +
> +		commit_hex = (const char **)list.hex_strs;
> +		commits_nr = list.hex_nr;

Nice trick!

>  	}
>  
>  	write_commit_graph(opts.obj_dir,
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index e91053271a..ccadd22f57 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -200,6 +200,16 @@ test_expect_success 'build graph from commits with append' '
>  graph_git_behavior 'append graph, commit 8 vs merge 1' full commits/8 merge/1
>  graph_git_behavior 'append graph, commit 8 vs merge 2' full commits/8 merge/2
>  
> +test_expect_success 'build graph using --reachable' '
> +	cd "$TRASH_DIRECTORY/full" &&
> +	git commit-graph write --reachable &&
> +	test_path_is_file $objdir/info/commit-graph &&
> +	graph_read_expect "11" "large_edges"
> +'
> +
> +graph_git_behavior 'append graph, commit 8 vs merge 1' full commits/8 merge/1
> +graph_git_behavior 'append graph, commit 8 vs merge 2' full commits/8 merge/2
> +
>  test_expect_success 'setup bare repo' '
>  	cd "$TRASH_DIRECTORY" &&
>  	git clone --bare --no-local full bare &&
