Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97B341F45F
	for <e@80x24.org>; Thu,  9 May 2019 08:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbfEIIHo (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 04:07:44 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42803 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfEIIHo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 04:07:44 -0400
Received: by mail-ed1-f66.google.com with SMTP id l25so1182084eda.9
        for <git@vger.kernel.org>; Thu, 09 May 2019 01:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=KQFI8meK64dE9wInJjIuuKN9i5xHdOlGjrKjeo/iVPg=;
        b=t49PNNj+2iPAO61bdYSATdAqNRGpGzKYppgNYkHT6wDoxj2XG7smP89quspk7n9sUK
         BZEfNIDdvs/9uCDZ7/RihvWMcls1LMlq1a+OcFg1ik9jRgcN/mHteWgc3mf2cCUwrpU6
         NcixeCZ6OWs0spqv5+cpOCPZI2X1nzyxi4boGtptoIfiszN9audesZ6TH1W2xxIYYCAg
         GsMaQagO1RWgTn5nhTF48ScyCiAVwCsygWSOuDKW82G3RSTMq5sVIsdmb+94BxIybLFi
         tG3nqvlTDQtnOJDCVLFikIydQjrartT2zJWcYl45MSiq8t9cxcyIvezDCluAvQx3Tw9D
         lxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=KQFI8meK64dE9wInJjIuuKN9i5xHdOlGjrKjeo/iVPg=;
        b=XdprIRsV4IzQ5s5ODQi/8s8sPjZ66l1JoowKpdx0WJXvVN3PU53tMsW4VRNI1aTlR3
         Xar6pVKW5g0IArJ3qadGHZlXII4k1dvJ/2KvFpWegl1k418RyjrccV6FtKQ5n9tEcq10
         VHu7I1SlyikzABG/4kFRXhUdlheypd1ZIvK4rC633h5gxXjQa6hb6JEcCwNEmh4RGGqi
         QFCgyTGu+td37hhyiENKTUJr/VOzYi2cpJ4KxMzVR/QSSOM+sQ3mpTG0xu2nAK+Ej7dw
         Tmnpt0TMVuxLY5uXnuXvviUh86jY4KzJHyjACBw0GzMXMgmI2/+HGgf4pg8Wcu7jj0+B
         StHg==
X-Gm-Message-State: APjAAAVJvrLyMQC2XsiV3y7KoP4naLaw6IdSUEVwTCHqylDAdAc/Rpi+
        OSykhHfAUPBnGUvJ3u0a71w=
X-Google-Smtp-Source: APXvYqyJiLYzq/iVBQzsFTTXJX72jhTQmuUcFKC4CHzJOslJ16++MxBS4iBZP72ucZgy6nM2C8XOgw==
X-Received: by 2002:a50:89db:: with SMTP id h27mr2286569edh.207.1557389262195;
        Thu, 09 May 2019 01:07:42 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id v16sm385970edm.56.2019.05.09.01.07.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 01:07:41 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 17/17] fetch: add fetch.writeCommitGraph config setting
References: <pull.184.git.gitgitgadget@gmail.com> <3c52385e5696887c40cab4a6b9b7923d60a0567c.1557330827.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <3c52385e5696887c40cab4a6b9b7923d60a0567c.1557330827.git.gitgitgadget@gmail.com>
Date:   Thu, 09 May 2019 10:07:40 +0200
Message-ID: <87imukgier.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 08 2019, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  builtin/fetch.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index b620fd54b4..cf0944bad5 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -23,6 +23,7 @@
>  #include "packfile.h"
>  #include "list-objects-filter-options.h"
>  #include "commit-reach.h"
> +#include "commit-graph.h"
>
>  static const char * const builtin_fetch_usage[] = {
>  	N_("git fetch [<options>] [<repository> [<refspec>...]]"),
> @@ -62,6 +63,7 @@ static const char *submodule_prefix = "";
>  static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
>  static int recurse_submodules_default = RECURSE_SUBMODULES_ON_DEMAND;
>  static int shown_url = 0;
> +static int fetch_write_commit_graph = 0;
>  static struct refspec refmap = REFSPEC_INIT_FETCH;
>  static struct list_objects_filter_options filter_options;
>  static struct string_list server_options = STRING_LIST_INIT_DUP;
> @@ -79,6 +81,11 @@ static int git_fetch_config(const char *k, const char *v, void *cb)
>  		return 0;
>  	}
>
> +	if (!strcmp(k, "fetch.writecommitgraph")) {
> +		fetch_write_commit_graph = 1;
> +		return 0;
> +	}
> +
>  	if (!strcmp(k, "submodule.recurse")) {
>  		int r = git_config_bool(k, v) ?
>  			RECURSE_SUBMODULES_ON : RECURSE_SUBMODULES_OFF;
> @@ -1670,6 +1677,16 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>
>  	string_list_clear(&list, 0);
>
> +	if (fetch_write_commit_graph) {
> +		int commit_graph_flags = COMMIT_GRAPH_SPLIT;
> +
> +		if (progress)
> +			commit_graph_flags |= COMMIT_GRAPH_PROGRESS;
> +
> +		write_commit_graph_reachable(get_object_directory(),
> +					     commit_graph_flags);
> +	}
> +
>  	close_all_packs(the_repository->objects);
>
>  	argv_array_pushl(&argv_gc_auto, "gc", "--auto", NULL);

I'm keen in general to refactor "git gc --auto" a bit so it moves away
from being an all-or-nothing to something where we can do an
"incremental" gc.

I'm happy to do that work, the main thing it's been blocked on is not
having some fast easy-to-lookup heuristic for one of those "incremental"
things.

The two obvious candidates are the commit-graph (I mainly wanted this on
"gc --auto" after clone), and pack-refs (but doing that is more
expensive).

So rather than have this patch I'd like to as noted in 00/17 get the
refactoring bits of the commit-graph in first.

Then some version of my WIP patch in
https://public-inbox.org/git/87lfzprkfc.fsf@evledraar.gmail.com/ where
we'd note the number of objects we had when we did the last commit-graph
in the graph itself.

Then "gc --auto" would look at that, then approximate_object_count(),
and have some percentage threshhold for doing a "do some of the gc"
task, which would just be a small change to need_to_gc() to make it
return/populate a "what needs to be done" rather than "yes/no".

That would give you what you want here, but also be a more general
solution. E.g. we'd write the graph on "clone" once "gc --auto" was
called there, as well as on "fetch".
