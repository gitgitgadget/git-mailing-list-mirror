Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70009208E9
	for <e@80x24.org>; Sun, 29 Jul 2018 21:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731016AbeG2WcN (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Jul 2018 18:32:13 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44543 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729062AbeG2WcM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jul 2018 18:32:12 -0400
Received: by mail-wr1-f66.google.com with SMTP id r16-v6so10578853wrt.11
        for <git@vger.kernel.org>; Sun, 29 Jul 2018 14:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fCjQMKtK0Zz64mgJZRenMQ5G2dgooatV5tkVqqzF3cY=;
        b=qSB+2DJEWi7ArsmKM5sWTYBRSUcxZBtBG4x7qrmevAu3FakzEg2/mmH5fpc4akSwtT
         gTKBys1kb/7LKlzzm6XRwIAeBjuCqDfknWnFtngqWMCdv6rThmDxo3fVkTw9+r1Lyt6B
         YaqxPHkxhjPsHLD1sK4qtJRW4TTm8JWQkUu4XA7qZZVZMzNAz/2vo8EPiVmJ64wfiExu
         Jt3WhuRsYZl//j0vYEALSVJfZI/sNbt0XhMQxdUYsIUWjtLBFXfRrmQHDXHBvEFwfZF9
         qBHmlxm3PVueY3Mg9gi5HyheBOb98g5jhNFt2qpzXwzNtD+xcqaPVO7TKPKkZgl8JLrq
         UHCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=fCjQMKtK0Zz64mgJZRenMQ5G2dgooatV5tkVqqzF3cY=;
        b=Sr3NRJ2Rb/x0QrN6Od3CbJagZ+5xlUyEIVpq30Wa2KdLiA0OPwn/YMJvgJTlwtxl4Q
         DpSWbw0zDqoDDrsXngdg15sMlO0uQldFhlBiqlASFBiTynxd8sm4uUCRF6Jvm9FdicyN
         +3uH0ULQR4aZEWA9Uwkz+fckbiyEnyGObACqjy4SoXLiTEBSGYFNQ+OlDNMqysGx0CvU
         jB1SF77xLNNwnMBfsP2M3Gk6/3TzHeDwrsBJHGmvhi+wafpVfkmnlU5Nc2MyssAAd4um
         g2DzTJWkmfN7ZSOd6O8kTTqJISqC5iracUYgDMMC+QCTgaIwmBZAQaYOlXJmvmgoFqx0
         ABCA==
X-Gm-Message-State: AOUpUlGR9Sieu3uq3dvADocVv6jRpPGGKtSyK/jMEBKbSwWj2k9PKwjD
        vgEOpWk408gG0K7dOtALu5/vm4Hl
X-Google-Smtp-Source: AAOMgpfarvip93j1yPv4hxq3CV0/7EdkyvEFt6KMTI+97nQ3DW6bt3jCzsvJXKIB//mWBpYKxywiIA==
X-Received: by 2002:adf:9bc9:: with SMTP id e9-v6mr15182120wrc.240.1532898022379;
        Sun, 29 Jul 2018 14:00:22 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abuo246.neoplus.adsl.tpnet.pl. [83.8.186.246])
        by smtp.gmail.com with ESMTPSA id h5-v6sm11724737wrr.19.2018.07.29.14.00.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Jul 2018 14:00:20 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 5/8] commit-graph: not compatible with replace objects
References: <pull.11.git.gitgitgadget@gmail.com>
        <7f596c1718d35539f02828edbf933c8e660f123b.1531926932.git.gitgitgadget@gmail.com>
Date:   Sun, 29 Jul 2018 23:00:19 +0200
In-Reply-To: <7f596c1718d35539f02828edbf933c8e660f123b.1531926932.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Wed, 18 Jul 2018
        08:15:41 -0700 (PDT)")
Message-ID: <86wotd7o64.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> Create new method commit_graph_compatible(r) to check if a given
> repository r is compatible with the commit-graph feature. Fill the
> method with a check to see if replace-objects exist.

All right, looks sensible.  Did you start with the history-"altering"
feature with simplest detection mechanism?

>                                                       Test this
> interaction succeeds, including ignoring an existing commit-graph and
> failing to write a new commit-graph.

I wonder if we should test the implementation, or just that you get
correct answer when history view is altered after writing commit-graph
file... oh, wait, you do that (well, except for testing that
`git commit-graph write` does not create commit-graph file instead of
testing that the commit-graph file stores correct information even after
the feature is removed (with `git replace --delete`) or turned off (with
`--no-replace-objects` or equivalent).  Good.

Sidenote: the inconsistency between command options and
subcommands... ehh... compare e.g. git-replace and git-remote.

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit-graph.c          | 17 +++++++++++++++++
>  replace-object.c        |  2 +-
>  replace-object.h        |  2 ++
>  t/t5318-commit-graph.sh | 22 ++++++++++++++++++++++
>  4 files changed, 42 insertions(+), 1 deletion(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index b0a55ad12..711099858 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -13,6 +13,8 @@
>  #include "commit-graph.h"
>  #include "object-store.h"
>  #include "alloc.h"
> +#include "hashmap.h"
> +#include "replace-object.h"
>  
>  #define GRAPH_SIGNATURE 0x43475048 /* "CGPH" */
>  #define GRAPH_CHUNKID_OIDFANOUT 0x4f494446 /* "OIDF" */
> @@ -56,6 +58,15 @@ static struct commit_graph *alloc_commit_graph(void)
>  	return g;
>  }
>  
> +static int commit_graph_compatible(struct repository *r)
> +{
> +	prepare_replace_object(r);
> +	if (hashmap_get_size(&r->objects->replace_map->map))

A very minor nitpick, feel free to ignore.  I think that the condition
would be more readable written as

  +	if (hashmap_get_size(&r->objects->replace_map->map) > 0)

Another issue is that the condition may be too strict (but it is also
the easiest to test for).  You might have replacement objects for
non-commit objects (e.g. replacing contents of configuration files with
one with API keys and/or other secrets - not that I know any tool that
does that), or replacing commit-objects without changing their history
(e.g. to fix some annoying error in demo repository, where you want to
show reflog).  But I think that would be rare, so easier if maybe
over-eager test is fine for me.

> +		return 0;
> +
> +	return 1;
> +}
> +
>  struct commit_graph *load_commit_graph_one(const char *graph_file)
>  {
>  	void *graph_map;
> @@ -223,6 +234,9 @@ static int prepare_commit_graph(struct repository *r)
>  		 */
>  		return 0;
>  
> +	if (!commit_graph_compatible(r))
> +		return 0;
> +
>  	obj_dir = r->objects->objectdir;
>  	prepare_commit_graph_one(r, obj_dir);
>  	prepare_alt_odb(r);
> @@ -693,6 +707,9 @@ void write_commit_graph(const char *obj_dir,
>  	int num_extra_edges;
>  	struct commit_list *parent;
>  
> +	if (!commit_graph_compatible(the_repository))
> +		return;
> +

Hmmm... we might want to write commit-graph for immutable history; but
not all history-"altering" feature can be easily turned off.  So if it
is to stay universal, without aadditional complications, it is good
enough.

>  	oids.nr = 0;
>  	oids.alloc = approximate_object_count() / 4;
>  
> diff --git a/replace-object.c b/replace-object.c
> index 017f02f8e..4d2d84cf4 100644
> --- a/replace-object.c
> +++ b/replace-object.c
> @@ -32,7 +32,7 @@ static int register_replace_ref(struct repository *r,
>  	return 0;
>  }
>  
> -static void prepare_replace_object(struct repository *r)
> +void prepare_replace_object(struct repository *r)
>  {
>  	if (r->objects->replace_map)
>  		return;
> diff --git a/replace-object.h b/replace-object.h
> index f996de3d6..c7a99fc35 100644
> --- a/replace-object.h
> +++ b/replace-object.h
> @@ -10,6 +10,8 @@ struct replace_object {
>  	struct object_id replacement;
>  };
>  
> +void prepare_replace_object(struct repository *r);
> +

Hmmm... how it is that this function didn't need to be exported before,
I do wonder?

>  /*
>   * This internal function is only declared here for the benefit of
>   * lookup_replace_object().  Please do not call it directly.
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index 4f17d7701..c90626f5d 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -259,6 +259,28 @@ test_expect_success 'check that gc computes commit-graph' '
>  	test_cmp commit-graph-after-gc $objdir/info/commit-graph
>  '
>  
> +test_expect_success 'replace-objects invalidates commit-graph' '
> +	cd "$TRASH_DIRECTORY" &&
> +	test_when_finished rm -rf replace &&
> +	git clone full replace &&
> +	(
> +		cd replace &&
> +		git commit-graph write --reachable &&
> +		test_path_is_file .git/objects/info/commit-graph &&

All right, this is preparation / setup; create commit-graph file, and
check that it was created.

> +		git replace HEAD~1 HEAD~2 &&

All right, so before replacement the history looks like this:

     ... <--- A <--- B <--- C <--- D     <--- master  <=== HEAD

             ~3     ~2     ~1    HEAD

While after the replacement the history view looks like this, if I
understand it correctly:

     ... <--- A <--- B
               \
                \---[B] <--- D    <--- master  <=== HEAD


Wouldn't it be better (and more similar to the grafts test) to use
`git replace --graft`, e.g.:

  +		git replace --graft HEAD~1 HEAD~3 &&

But that might be just a matter of taste.

> +		git -c core.commitGraph=false log >expect &&
> +		git -c core.commitGraph=true log >actual &&
> +		test_cmp expect actual &&

All right, so instead of testing if the output is what is expected, we
test that the commit-graph feature did not change it.  Good.

> +		git commit-graph write --reachable &&

Is this necessary [see below]?

> +		git -c core.commitGraph=false --no-replace-objects log >expect &&
> +		git -c core.commitGraph=true --no-replace-objects log >actual &&

All right, and here we test the same for `--no-replace-objects` case.
Good.

By the way, is this `git commit-graph write --reachable` preceding this
part of test necessary?

> +		test_cmp expect actual &&
> +		rm -rf .git/objects/info/commit-graph &&
> +		git commit-graph write --reachable &&
> +		test_path_is_missing .git/objects/info/commit-graph

All right, so here we test that we wont write commit-graph file with
altered view of history; which would store wrong information if the
replace feature is turned off or if replace object is deleted (or if
commit graph gets transferred in the furure, but the replacement refs do
not).

Checking that the commit-graph file ws not created might be seen as
testing implementation details, but full test would require testing with
`--no-replace-objects` and after `git replace -d`; the above is simpler,
so good enough.

> +	)
> +'
> +
>  # the verify tests below expect the commit-graph to contain
>  # exactly the commits reachable from the commits/8 branch.
>  # If the file changes the set of commits in the list, then the
