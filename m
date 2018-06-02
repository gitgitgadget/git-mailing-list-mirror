Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B91531F42D
	for <e@80x24.org>; Sat,  2 Jun 2018 17:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751503AbeFBReo (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 13:34:44 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38921 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750831AbeFBRen (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 13:34:43 -0400
Received: by mail-wm0-f65.google.com with SMTP id p11-v6so7021150wmc.4
        for <git@vger.kernel.org>; Sat, 02 Jun 2018 10:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=T+lCST/D61nO19y6KrD0lBBUHanAxmMeRNmDH3TFHY8=;
        b=gLMW635rjvRDqh54Tgwt6uzIRidB5ywI3kgzlKGDFrEJfQPIrinWRKCoY9AF1PnAcL
         JuTnJPakzcfCWh75BwUI9Lvz5EzsZmSIuw3d5M2paqWkSWKe4M9Ju+xenVof+Ktzo6y4
         64JoKYk54TzNT8OogbZvLzFKQYi6qj1HOaoGUX5vKtzKbHih3V+Gg+lyEqe0kdD15BFQ
         klIR/q5wO/vPb1ZLwaHDfbOGiK6RnkNRw2y+NX5beE2CxcYSgRb+HCIN/n4JnIuZ/aIs
         umJXzemjat2Bn/6pP5SThyHLOTM0kDI3iAKc3OUi+6VgraI6Kfqi02Ov+xN7jMKTrA4M
         eOpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=T+lCST/D61nO19y6KrD0lBBUHanAxmMeRNmDH3TFHY8=;
        b=RFzacxN2ZFICVcoAoQYXOTOBlTHuhfyt+3eDegwHgHaos0O0aFPTGIYarlrO9RNf72
         bQLg6I4O5XCsW6zLBwKvOirTKLfoXkmETrFHmuvHy2c/Pv5SDaMRQsJ5aPS3npw2cQqT
         rAUGqZKW0JkUloo2Ey999TLqlstSHTMsddWia5HYRuHYWlD8UALPqHLoyV6G7tqFHH9M
         S9e2MB17N2zlOsSdL+vI5RFMi2pVubfDwT8S9Ec9BG+8Di4SjObA8CTSRQ/zAH66+XUN
         flGEng72TjQMlN6IDfCZOHEWsZva5pIUx+tV2DZzh0A6irYYv1GCWGIBS0aCRWUO+bz1
         isUw==
X-Gm-Message-State: ALKqPwfyps3pwcdIrMWsok4Fde72rSNkb+aCTbTRqmj4OCjkzT/o3dGf
        xTkWCATg8DTjNaTF4M5c68M=
X-Google-Smtp-Source: ADUXVKIBvVjLZrNMR2BWR9NoEB8G5B8hRnDXTDDLHsRYLgLdqlYu49dIbKUps115uiNzuC+LdvaiAA==
X-Received: by 2002:a1c:48d6:: with SMTP id v205-v6mr5145208wma.36.1527960881731;
        Sat, 02 Jun 2018 10:34:41 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abri204.neoplus.adsl.tpnet.pl. [83.8.102.204])
        by smtp.gmail.com with ESMTPSA id m58-v6sm35870920wrf.61.2018.06.02.10.34.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Jun 2018 10:34:40 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "gitster\@pobox.com" <gitster@pobox.com>,
        "stolee\@gmail.com" <stolee@gmail.com>,
        "avarab\@gmail.com" <avarab@gmail.com>,
        "marten.agren\@gmail.com" <marten.agren@gmail.com>,
        "peff\@peff.net" <peff@peff.net>
Subject: Re: [PATCH v3 18/20] commit-graph: add '--reachable' option
References: <20180511211504.79877-1-dstolee@microsoft.com>
        <20180524162504.158394-1-dstolee@microsoft.com>
        <20180524162504.158394-19-dstolee@microsoft.com>
Date:   Sat, 02 Jun 2018 19:34:37 +0200
In-Reply-To: <20180524162504.158394-19-dstolee@microsoft.com> (Derrick
        Stolee's message of "Thu, 24 May 2018 16:26:06 +0000")
Message-ID: <86k1rhrt1u.fsf@gmail.com>
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
> write_commit_graph_reachable() after performing cleanup of the object
> database.

Nice.

The last sentence of the commit message is a bit long, though, in my
opinion.

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/git-commit-graph.txt |  8 ++++++--
>  builtin/commit-graph.c             | 16 ++++++++++++----
>  commit-graph.c                     | 32 ++++++++++++++++++++++++++++++++
>  commit-graph.h                     |  1 +
>  t/t5318-commit-graph.sh            | 10 ++++++++++
>  5 files changed, 61 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
> index a222cfab08..dececb79d7 100644
> --- a/Documentation/git-commit-graph.txt
> +++ b/Documentation/git-commit-graph.txt
> @@ -38,12 +38,16 @@ Write a commit graph file based on the commits found in packfiles.
>  +
>  With the `--stdin-packs` option, generate the new commit graph by
>  walking objects only in the specified pack-indexes. (Cannot be combined
> -with --stdin-commits.)
> +with `--stdin-commits` or `--reachable`.)
>  +
>  With the `--stdin-commits` option, generate the new commit graph by
>  walking commits starting at the commits specified in stdin as a list
>  of OIDs in hex, one OID per line. (Cannot be combined with
> ---stdin-packs.)
> +`--stdin-packs` or `--reachable`.)
> ++
> +With the `--reachable` option, generate the new commit graph by walking
> +commits starting at all refs. (Cannot be combined with `--stdin-commits`
> +or `--stdin-packs`.)

All right (though I wonder a bit about the restriction).

I think it might be a good idea to describe all of this in the usage
string for the 'git commit-graph write', instead of using '<options>'
placeholder, that is instead of current:

  'git commit-graph write' <options> [--object-dir <dir>]

use

  'git commit-graph write' [--stdin-commits | --stdin-packs | --reachable]
                           [--append] [--object-dir <dir>]

or something like that.

>  +
>  With the `--append` option, include all commits that are present in the
>  existing commit-graph file.
> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index 0433dd6e20..20ce6437ae 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -9,7 +9,7 @@ static char const * const builtin_commit_graph_usage[] = {
>  	N_("git commit-graph [--object-dir <objdir>]"),
>  	N_("git commit-graph read [--object-dir <objdir>]"),
>  	N_("git commit-graph verify [--object-dir <objdir>]"),
> -	N_("git commit-graph write [--object-dir <objdir>] [--append] [--stdin-packs|--stdin-commits]"),
> +	N_("git commit-graph write [--object-dir <objdir>] [--append] [--reachable|--stdin-packs|--stdin-commits]"),

All right, very straightforward.  I guess they are put in [almost]
alphabetical order, or is there some other reasoning behind the ordering
used (which is different from the one in the manpage)?

>  	NULL
>  };
>  
> @@ -24,12 +24,13 @@ static const char * const builtin_commit_graph_read_usage[] = {
>  };
>  
>  static const char * const builtin_commit_graph_write_usage[] = {
> -	N_("git commit-graph write [--object-dir <objdir>] [--append] [--stdin-packs|--stdin-commits]"),
> +	N_("git commit-graph write [--object-dir <objdir>] [--append] [--reachable|--stdin-packs|--stdin-commits]"),

The same.

>  	NULL
>  };
>  
>  static struct opts_commit_graph {
>  	const char *obj_dir;
> +	int reachable;
>  	int stdin_packs;
>  	int stdin_commits;
>  	int append;
> @@ -130,6 +131,8 @@ static int graph_write(int argc, const char **argv)
>  		OPT_STRING(0, "object-dir", &opts.obj_dir,
>  			N_("dir"),
>  			N_("The object directory to store the graph")),
> +		OPT_BOOL(0, "reachable", &opts.reachable,
> +			N_("start walk at all refs")),

Errr... does '--no-reachable' makes sense?  Because if I am right
currently it is supported, isn't it.

>  		OPT_BOOL(0, "stdin-packs", &opts.stdin_packs,
>  			N_("scan pack-indexes listed by stdin for commits")),
>  		OPT_BOOL(0, "stdin-commits", &opts.stdin_commits,
> @@ -143,11 +146,16 @@ static int graph_write(int argc, const char **argv)
>  			     builtin_commit_graph_write_options,
>  			     builtin_commit_graph_write_usage, 0);
>  
> -	if (opts.stdin_packs && opts.stdin_commits)
> -		die(_("cannot use both --stdin-commits and --stdin-packs"));
> +	if (opts.reachable + opts.stdin_packs + opts.stdin_commits > 1)

Nice trick.

> +		die(_("use at most one of --reachable, --stdin-commits, or --stdin-packs"));

It is a pity that parseopt API does not have direct support for mutually
exclusive groups of boolean options, like ArgumentParser.add_mutually_exclusive_group()
in Python's argparse.

Still, you need to use what it is there.

>  	if (!opts.obj_dir)
>  		opts.obj_dir = get_object_directory();
>  
> +	if (opts.reachable) {
> +		write_commit_graph_reachable(opts.obj_dir, opts.append);
> +		return 0;
> +	}

Just using the option.

> +
>  	if (opts.stdin_packs || opts.stdin_commits) {
>  		struct strbuf buf = STRBUF_INIT;
>  		lines_nr = 0;
> diff --git a/commit-graph.c b/commit-graph.c
> index a33600c584..057d734926 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -6,6 +6,7 @@
>  #include "packfile.h"
>  #include "commit.h"
>  #include "object.h"
> +#include "refs.h"
>  #include "revision.h"
>  #include "sha1-lookup.h"
>  #include "commit-graph.h"
> @@ -651,6 +652,37 @@ static void compute_generation_numbers(struct packed_commit_list* commits)
>  	}
>  }
>  
> +struct hex_list {
> +	char **hex_strs;
> +	int hex_nr;
> +	int hex_alloc;
> +};

Is this what git-for-each-ref / git-branch / git-tag uses?

Would it be possible to use for example string-list API (documented in
string-list.h) instead?  Anyway, it looks like the use of allocation
growing API is simple enough... though perhaps it could be made simpler
by noticing that all strings have the same width.

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

Wouldn't it be better to use strdup or xstrdup instead of
xcalloc+strcpy?

> +	list->hex_nr++;
> +	return 0;
> +}
> +
> +void write_commit_graph_reachable(const char *obj_dir, int append)
> +{
> +	struct hex_list list;
> +	list.hex_nr = 0;
> +	list.hex_alloc = 128;
> +	ALLOC_ARRAY(list.hex_strs, list.hex_alloc);
> +
> +	for_each_ref(add_ref_to_list, &list);
> +
> +	write_commit_graph(obj_dir, NULL, 0, (const char **)list.hex_strs, list.hex_nr, append);

Where do we free the allocated data and allocated strings?  If they are
cleaned by process exit, perhaps they need to be UNLEAK-ed?

> +}
> +
>  void write_commit_graph(const char *obj_dir,
>  			const char **pack_indexes,
>  			int nr_packs,
> diff --git a/commit-graph.h b/commit-graph.h
> index 71a39c5a57..9a06a5f188 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -46,6 +46,7 @@ struct commit_graph {
>  
>  struct commit_graph *load_commit_graph_one(const char *graph_file);
>  
> +void write_commit_graph_reachable(const char *obj_dir, int append);
>  void write_commit_graph(const char *obj_dir,
>  			const char **pack_indexes,
>  			int nr_packs,
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index 4941937163..a659620332 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -205,6 +205,16 @@ test_expect_success 'build graph from commits with append' '
>  graph_git_behavior 'append graph, commit 8 vs merge 1' full commits/8 merge/1
>  graph_git_behavior 'append graph, commit 8 vs merge 2' full commits/8 merge/2
>  
> +test_expect_success 'build graph using --reachable' '
> +	cd "$TRASH_DIRECTORY/full" &&
> +	git commit-graph write --reachable &&
> +	test_path_is_file $objdir/info/commit-graph &&
> +	graph_read_expect "11" "large_edges"
> +'

All right, here we check that commit-graph has expected features (11
commits, and large_edges optional chunk).

Perhaps we could also check that different equivalent ways of creating
serialized commit graph file produce byte-for-byte identical file?

> +
> +graph_git_behavior 'append graph, commit 8 vs merge 1' full commits/8 merge/1
> +graph_git_behavior 'append graph, commit 8 vs merge 2' full commits/8 merge/2

All right, this supposedly tests that behavior does not change whether
we are using or we are not using the commit-graph feature... but I have
just noticed that raph_git_two_modes() uses `git -c core.graph=true`;
shouldn't it be `git -c core.commitGraph=true`?

> +
>  test_expect_success 'setup bare repo' '
>  	cd "$TRASH_DIRECTORY" &&
>  	git clone --bare --no-local full bare &&
