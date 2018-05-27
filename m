Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61ED11F51C
	for <e@80x24.org>; Sun, 27 May 2018 10:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936393AbeE0KZL (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 May 2018 06:25:11 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:43086 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935648AbeE0KXy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 May 2018 06:23:54 -0400
Received: by mail-wr0-f196.google.com with SMTP id d2-v6so329549wrm.10
        for <git@vger.kernel.org>; Sun, 27 May 2018 03:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rmoIVbFn0dpUUr44vjKbeXQxqOnW2TGLmbdss/T3mRY=;
        b=VUkxw1O14ciRgtb+ADQF/8SV7V3iDGuCc/rIFCLuoa0Zs2EKICdMqGoBWL0rSDhL4R
         aS3XND6R2aKI4O5BW4MvFDy4L7CVAHPa+krNWxUPwdS9yW6iXtECGAuOToO99wikNJ8l
         vomHlVvx/KHWnFD6JYDsuLSuVcPEnQIUGgqrR/A8M1/0lpxED00pzlYAqIIQNJjUN/kd
         NUkJdycEhinRs/2vRrLux8lqVus1g5tgHcto80t+W9l+iTdWhHErZ29tpRNvdmPFHKvi
         rxSMi8eG62b2Br6wMHy8MYjKLGIp47JkxJM+FF6ilRvKQmmORlBMNuOQtKWpuoqkzEYK
         6fpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=rmoIVbFn0dpUUr44vjKbeXQxqOnW2TGLmbdss/T3mRY=;
        b=V01+jOrI2izRYIqF7B/rp6qoTW+Ddc/8zH/pP6PC5Y2cOLLn93ac8hH/E/I6Cbz96I
         Ij0YQ3yRoxKxo9aaIzDX8M2nGs+Q1sT3MGozZtRPdiscRMhGUSze5cxZwX8JGVArgoyf
         oYLL2yo0zkZ/DQ3GekLbYkCLfEjKJROzW/Br+3fK6YAZhvHIePB7Kv2xSa1U8j72npOt
         cWQUzv/FwKoPGg0z766P21+bNf1zlLrb7+IME2vFzFTbP2ENnoJKstIn//KZlXBeWHSD
         IBLhlFuTAG4M23VH6bB3Vd2OCKS23zUVooiCyqnWrgTSuSdFsXFZcbiWnixJae4Otoga
         xlFw==
X-Gm-Message-State: ALKqPwcqW0kEK3OBeQuc8dPck+ZCzAxkToAWHkHPnmDBQ9aeB49LQ27N
        dPUrEAXbHGY9HXSVzbUbPjI=
X-Google-Smtp-Source: ADUXVKIQJZqWuXvgodo7nMkPHIgN7i4nPNsYRbUZJ3g3iVTInZF9hl6IkFcnv2uACiioiFKwsMmmFQ==
X-Received: by 2002:adf:b710:: with SMTP id l16-v6mr166625wre.115.1527416633346;
        Sun, 27 May 2018 03:23:53 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egg40.neoplus.adsl.tpnet.pl. [83.21.70.40])
        by smtp.gmail.com with ESMTPSA id e7-v6sm28270892wrn.88.2018.05.27.03.23.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 May 2018 03:23:51 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "gitster\@pobox.com" <gitster@pobox.com>,
        "stolee\@gmail.com" <stolee@gmail.com>,
        "avarab\@gmail.com" <avarab@gmail.com>,
        "marten.agren\@gmail.com" <marten.agren@gmail.com>,
        "peff\@peff.net" <peff@peff.net>
Subject: Re: [PATCH v3 03/20] commit-graph: parse commit from chosen graph
References: <20180511211504.79877-1-dstolee@microsoft.com>
        <20180524162504.158394-1-dstolee@microsoft.com>
        <20180524162504.158394-4-dstolee@microsoft.com>
Date:   Sun, 27 May 2018 12:23:50 +0200
In-Reply-To: <20180524162504.158394-4-dstolee@microsoft.com> (Derrick Stolee's
        message of "Thu, 24 May 2018 16:25:31 +0000")
Message-ID: <86y3g5z9ah.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> Before verifying a commit-graph file against the object database, we
> need to parse all commits from the given commit-graph file. Create
> parse_commit_in_graph_one() to target a given struct commit_graph.

If I understand it properly the problem is that when verifying against
the object database we want to check one single commit-graph file, not
concatenation of data from commit-graph file for the repository and
commit-graph files from its alternates -- like prepare_commit_graph()
does; which is called by parse_commit_in_graph().

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

O.K., so you introduce here a layer of indirection; parse_commit_in_graph()
now just uses parse_commit_in_graph_one(), passing core_commit_graph
(or the_commit_graph) to it, after checking that core_commit_graph is set
(which handles the case when feature is not turned off) and loading
commit-graph file.

Nice and simple 'split function' refactoring, with new function taking
over when there is commit graph file prepared.


So, after the changes:
* parse_commit_in_graph() is responsible for checking whether to use
  commit-graph feature and ensuring that data from commit-graph is
  loaded, where it passes the control to parse_commit_in_graph_one()
* parse_commit_in_graph_one() checks whether commit-graph feature is
  turned on, whether commit we are interested in was already parsed,
  and then uses fill_commit_in_graph() to actually get the data
* fill_commit_in_graph() gets data out of commit-graph file, extracting
  it from commit data chunk (and if needed large edges chunk).

All those functions return 1 if they got data from commit-graph, and 0
if they didn't.


One minor nitpick / complaint / question is about naming of global
variables used here, namely:
* static struct commit_graph *commit_graph
  from commit-graph.c for global storage of commit-graph[s] data
* int core_commit_graph
  from environment.c for storing core.commitGraph config

But I see that at least the latter is common convention in Git source
code; I guess that the former maybe follows convention as used for "the
index" and "the repository" - additionally it is static / file-local.

> ---
>  commit-graph.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 82295f0975..78ba0edc80 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -310,7 +310,7 @@ static int find_commit_in_graph(struct commit *item, struct commit_graph *g, uin
>  	}
>  }
>  
> -int parse_commit_in_graph(struct commit *item)
> +static int parse_commit_in_graph_one(struct commit_graph *g, struct commit *item)
>  {
>  	uint32_t pos;
>  
> @@ -318,9 +318,21 @@ static int parse_commit_in_graph_one(struct commit_graph *g, struct commit *item)
>  	if (!core_commit_graph)
>  		return 0;

All right, we check that commit-graph feature is enabled because
parse_commit_in_graph_one() will be used standalone, not by being
invoked from parse_commit_in_graph().

This check is fast.

>  	if (item->object.parsed)
>  		return 1;

Sidenote: I just wonder why object.parsed and not for example
object.graph_pos is used to checck whether the object was filled if
possible with commit-graph data...

> +
> +	if (find_commit_in_graph(item, g, &pos))
> +		return fill_commit_in_graph(item, g, pos);
> +
> +	return 0;
> +}
> +
> +int parse_commit_in_graph(struct commit *item)
> +{
> +	if (!core_commit_graph)
> +		return 0;

All right, this check is here to short-circuit and make it so git does
not even try to lod commit-graph file[s] if the feature is disabled.

> +
>  	prepare_commit_graph();
> -	if (commit_graph && find_commit_in_graph(item, commit_graph, &pos))
> -		return fill_commit_in_graph(item, commit_graph, pos);
> +	if (commit_graph)
> +		return parse_commit_in_graph_one(commit_graph, item);
>  	return 0;
>  }
