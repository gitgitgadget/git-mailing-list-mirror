Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05A3F1F403
	for <e@80x24.org>; Sat,  9 Jun 2018 15:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932700AbeFIPrj (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 11:47:39 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37702 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932673AbeFIPrh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 11:47:37 -0400
Received: by mail-wm0-f66.google.com with SMTP id r125-v6so8864044wmg.2
        for <git@vger.kernel.org>; Sat, 09 Jun 2018 08:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=gtVnUvoHHGPU3/YLr/C1AGtt3qgWny/F8S7H817EYq4=;
        b=WgOjjj7mG25gPd+bNLIqD4ob6SVh65J3eP0p9cDjwXExcvc6oaGjlEYgMXW1Q0JUQ7
         uCe8TQCbKCHAoC67G+/hGEgmcjMi9lutOM9BFjUy8fsDz6vrcOOhpTgtfCv54LY975L+
         GQtIk2wKD5+b6Q8qb3xy90kcsBi8kqZ1++ns8H1bDDLKCkukza2uV6sVpM7iJ1wh2aq/
         iurAGsGw3wpTRiOmXo0tmuRnmTwR4XRz2oUdfJ8BEbbmDH4IujzENpXKgN2IA2z4/LFG
         kzG+LnFb6+4E0iBXXOKah+R/yy88eNmvqyOzFdAvfSHymq0NYyT2PaGAmTRlhXAAKDUZ
         Aqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:message-id
         :user-agent:mime-version;
        bh=gtVnUvoHHGPU3/YLr/C1AGtt3qgWny/F8S7H817EYq4=;
        b=trKrUMcBppIqJcqM2RbtGFkIFe1AtonCAMFUzFnW6r+nBDaCxUlKLL4ya2L1G5WBaF
         PS5PHPBxX0LEqbb+N/2jT1UO+CVooiBZxZ4ObAf+38d4UaY4hNky/Gi09r/jo9Xlraga
         MDqkTynhXE3S8B8ZK+cThvHqoZk/kSPQWzhcaR1ICAcFKOi41Bh633FLR1jrk7UDKa1y
         sZ9aAYX6gsD/5d9czlZjWNubaCTpXlMCoA3GL78GNDcfAaNwwBjrRLrEBJ2gl7LQQxuJ
         xA3Bc5aVMc+rmOml+cowBGglmckJPVlqFLfUydxcaUUgpwyuOjZEtlfHjaYPoBJlWAXe
         1DPQ==
X-Gm-Message-State: APt69E1WmNPiRnMYfj8Gx5mVqfCWviG8Ln33YvxHewlZxBVGvzRsYAAr
        kZenwFGUzx6QhYcSUbS07Pg=
X-Google-Smtp-Source: ADUXVKIHWbWMiddK7niuFH5OT/2NRlemHvDaaCfqAOcn+24jW+6XXQu6zpxnqqzvBoQnvRFOgmeNFw==
X-Received: by 2002:a1c:3fc2:: with SMTP id m185-v6mr4015197wma.37.1528559255458;
        Sat, 09 Jun 2018 08:47:35 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egb232.neoplus.adsl.tpnet.pl. [83.21.65.232])
        by smtp.gmail.com with ESMTPSA id e2-v6sm22794882wro.97.2018.06.09.08.47.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Jun 2018 08:47:33 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [RFC PATCH 3/6] commit-graph: enable replace-object and grafts
References: <20180531174024.124488-1-dstolee@microsoft.com>
        <20180531174024.124488-4-dstolee@microsoft.com>
Date:   Sat, 09 Jun 2018 17:47:30 +0200
Message-ID: <86h8mcynal.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

First, this commit seems to try to do two things at once, and in its
current form it should be split into adding destroy_commit_graph() and
into grafts / replacements check.  Those are separate and unconnected
features, and should be in separate patches, in my opinion.

> Create destroy_commit_graph() method to delete the commit-graph file
> when history is altered by a replace-object call. If the commit-graph
> is rebuilt after that, we will load the correct object while reading
> the commit-graph.

I'm not sure if this is the best solution.  It would work both for
invalidation, and for turning off the feature, but in my opinion there
are better solutions for both:
 - in case of invalidation, wouldn't it be better to re-create the file?
 - in case of turning off, wouldn't it be better to simply set
   core_commit_graph to false?

Nevertheless I think destroy_commit_graph(), however it would be named
at the end, would be a good to have.

> When parsing a commit, first check if the commit was grafted. If so,
> then ignore the commit-graph for that commit and insted use the parents
> loaded by parsing the commit buffer and comparing against the graft
> file.

Unless uyou turn off using generation numbers and other such indices,
this is not enough to prevent from generating incorrect results if
current commit-graph file doesn't agree with current altered view of the
project history.

Take a simple example of joining two histories using replacements
(git-replace) or grafts.  Numbers denote generation numbers:

Original history:

    A<---B<---C             <===  master
    1    2    3


    a<---b<---c<---d<---e   <===  historical
    1    2    3    4    5

Altered view of history:

    a<---b<---c<---d<---e<---[A]<---B<---C   <===  master

In the new view of history, 'e' is reachable from 'C'.  But going by
pre-altering generation numbers, gen_{pre}(e) = 5  >  gen_{pre}(C) = 3.
This means that we don't even arrive at '[A]', where replacement object
or graft changed parents compared to what's loaded from commit-graph
file, isn't it?

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  builtin/replace.c |  3 +++
>  commit-graph.c    | 20 +++++++++++++++++++-
>  commit-graph.h    |  9 +++++++++
>  commit.c          |  5 +++++
>  4 files changed, 36 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/replace.c b/builtin/replace.c
> index 9f01f3fc7f..d553aadcdc 100644
> --- a/builtin/replace.c
> +++ b/builtin/replace.c
> @@ -15,6 +15,7 @@
>  #include "parse-options.h"
>  #include "run-command.h"
>  #include "tag.h"
> +#include "commit-graph.h"
>  
>  static const char * const git_replace_usage[] = {
>  	N_("git replace [-f] <object> <replacement>"),
> @@ -468,6 +469,8 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
>  		usage_msg_opt("--raw only makes sense with --edit",
>  			      git_replace_usage, options);
>  
> +	destroy_commit_graph(get_object_directory());
> +
>  	switch (cmdmode) {
>  	case MODE_DELETE:
>  		if (argc < 1)
> diff --git a/commit-graph.c b/commit-graph.c
> index e9195dfb17..95af4ed519 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -6,6 +6,7 @@
>  #include "pack.h"
>  #include "packfile.h"
>  #include "commit.h"
> +#include "dir.h"
>  #include "object.h"
>  #include "refs.h"
>  #include "revision.h"
> @@ -240,15 +241,22 @@ static struct commit_list **insert_parent_or_die(struct commit_graph *g,
>  {
>  	struct commit *c;
>  	struct object_id oid;
> +	const unsigned char *real;
>  
>  	if (pos >= g->num_commits)
>  		die("invalid parent position %"PRIu64, pos);
>  
>  	hashcpy(oid.hash, g->chunk_oid_lookup + g->hash_len * pos);
> +
> +	real = lookup_replace_object(oid.hash);

So this function returns either original SHA-1 / OID of object, or if
object should be replaced then it returns the replacement object's name
(replaced recursively, if necessary).

This deals with replacements, but not with grafts (from graft file)!

> +
>  	c = lookup_commit(&oid);
>  	if (!c)
>  		die("could not find commit %s", oid_to_hex(&oid));
> -	c->graph_pos = pos;
> +
> +	if (!hashcmp(real, oid.hash))
> +		c->graph_pos = pos;

I don't quite understand this reasoning here.  The serialized
commit-graph file can either follow the current state of altered
history, or not.  In the later case the commit-graph can either follow
original history, or altered but not current view of history.

What does it matter of the object was replaced or not when marking
object as coming from graph at position 'pos'?  If commit is replaced,
it still comes from commit-graph at position 'pos', isn't it?

Also, what if the starting commit was replaced?  Then this logic
wouldn't file, is it?


I don't see how it relates to what's written in the commit message:

DS> When parsing a commit, first check if the commit was grafted. If so,
DS> then ignore the commit-graph for that commit and insted use the parents
DS> loaded by parsing the commit buffer and comparing against the graft
DS> file.

> +
>  	return &commit_list_insert(c, pptr)->next;
>  }
>  
> @@ -1019,3 +1027,13 @@ int verify_commit_graph(struct commit_graph *g)
>  
>  	return verify_commit_graph_error;
>  }
> +
> +void destroy_commit_graph(const char *obj_dir)
> +{
> +	char *graph_name;
> +	close_commit_graph();
> +
> +	graph_name = get_commit_graph_filename(obj_dir);
> +	remove_path(graph_name);
> +	FREE_AND_NULL(graph_name);
> +}

All right, though I onder if it wouldn't be better to first
delete/remove/unlink the graph file, and only then close it.

Otherwise I think you might be introducing subtle race condition here.
But I may be wrong here.

> diff --git a/commit-graph.h b/commit-graph.h
> index 9a06a5f188..1d17da1582 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -56,4 +56,13 @@ void write_commit_graph(const char *obj_dir,
>  
>  int verify_commit_graph(struct commit_graph *g);
>  
> +/*
> + * Delete the commit-graph file in the given object directory.
> + *
> + * WARNING: this deletes data, so should only be used when
> + * performing history-altering actions like replace-object
> + * or grafts.
> + */
> +void destroy_commit_graph(const char *obj_dir);

Why it is not called delete_commit_graph(), then?

> +
>  #endif
> diff --git a/commit.c b/commit.c
> index 6eaed0174c..2fe31cde77 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -403,6 +403,11 @@ int parse_commit_internal(struct commit *item, int quiet_on_missing, int use_com
>  		return -1;
>  	if (item->object.parsed)
>  		return 0;
> +
> +	prepare_commit_graft();
> +	if (commit_graft_pos(item->object.oid.hash) >= 0)
> +		use_commit_graph = 0;

All right, this allegedly handles grafts.

I don't understand why you treat replacement objects in different place
than grafts; I can understand that you might want to treat them
differently (because grafts are deprecated).

> +
>  	if (use_commit_graph && parse_commit_in_graph(item))
>  		return 0;
>  	buffer = read_sha1_file(item->object.oid.hash, &type, &size);
