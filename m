Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45CE51F404
	for <e@80x24.org>; Thu, 19 Apr 2018 00:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752326AbeDSAEz (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 20:04:55 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:36916 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752091AbeDSAEx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 20:04:53 -0400
Received: by mail-wr0-f176.google.com with SMTP id f14-v6so9213842wre.4
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 17:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Ozb0i87EomhJJPoaRUe+gs5/EwFPgPWEh+yqO7MA7+E=;
        b=kBXsizK8oEd/ekSm2rUN37tggkdlTiiI1+AMzxeU3JBh9koRg8xCAhwwri7jEYtkvF
         RzUfuKSJ+AVbruUHifCCw8isO6FH6KrZFZKTThf8UjINyY9/37EreUvOMoqXEGAWr6g6
         BsCqYEnfxodbntfuO5YKN9g73yc1xIxsQI//Wgj5HVKZoAsEc30ftXeEHoZ9WNmLfnB9
         Z2tkdOF2Zm33U1iGf230CWUtj0iNVuce9JC/F8GI5sI0XBZEpH2KW9vSnOL8JH5FmH9I
         rtv4ry6eu8uJHsNlP/inbptPv+vwlHXDS0mWYB/4PH9oVCBrev008G1zEi9H81s5UfP7
         FLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=Ozb0i87EomhJJPoaRUe+gs5/EwFPgPWEh+yqO7MA7+E=;
        b=IttBfckL9HOPLD6LrZnN1nNIuQapmJipZCpZjxl7zoUTqS/kP9hFpsQ2LogWGQqgNr
         7RAB+Mpq32OtM30f5nSrK3IZKVV3/TjImNnkZkq2nj/Fat1VvGy/Id/fSIe8fcGWQa/l
         5FH4XIlrsz+BcBSAAPkX81Jc5eMHuM+1ldoFdWpii5iFGDFsLPUx/Ftq7VVAIEsKAxvz
         JTrI8cdflTCh4R1BoxpGIVpYPUZbCER2RC2o0l8bgS9DQ2q3OTk3wQ676Jylz5AYMQ8/
         D+7eurgcvN6VPQB9g/Wo9OFOGkbwxhUAj7JXfva2pIh2cTvjO3IAQ0uPGUkcIqOsxA++
         0nrg==
X-Gm-Message-State: ALQs6tAb/Gig4TiGcWmLNiUruY1aUtEe4ZslX5Fu8ZvgOAifsWURW2T6
        0F2+UXhOds7zjqv9ZLQAmcM=
X-Google-Smtp-Source: AIpwx4+zMWuIrsAmpfwlCPeKZIHct8Dfv6JxNPCYPR82HTxOUGf8tmxwV/7iSKIew2KKfezWNuQAlg==
X-Received: by 2002:adf:c358:: with SMTP id e24-v6mr3094290wrg.86.1524096292598;
        Wed, 18 Apr 2018 17:04:52 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egc153.neoplus.adsl.tpnet.pl. [83.21.66.153])
        by smtp.gmail.com with ESMTPSA id c27-v6sm4041840wrg.75.2018.04.18.17.04.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Apr 2018 17:04:51 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, "peff\@peff.net" <peff@peff.net>,
        "stolee\@gmail.com" <stolee@gmail.com>,
        "avarab\@gmail.com" <avarab@gmail.com>,
        "sbeller\@google.com" <sbeller@google.com>,
        "larsxschneider\@gmail.com" <larsxschneider@gmail.com>,
        "bmwill\@google.com" <bmwill@google.com>,
        "gitster\@pobox.com" <gitster@pobox.com>,
        "sunshine\@sunshineco.com" <sunshine@sunshineco.com>,
        "jonathantanmy\@google.com" <jonathantanmy@google.com>
Subject: Re: [PATCH v3 0/9] Compute and consume generation numbers
References: <20180409164131.37312-1-dstolee@microsoft.com>
        <20180417170001.138464-1-dstolee@microsoft.com>
Date:   Thu, 19 Apr 2018 02:04:50 +0200
In-Reply-To: <20180417170001.138464-1-dstolee@microsoft.com> (Derrick Stolee's
        message of "Tue, 17 Apr 2018 17:00:13 +0000")
Message-ID: <86y3hkf4d9.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> -- >8 --
>
> This is the one of several "small" patches that follow the serialized
> Git commit graph patch (ds/commit-graph) and lazy-loading trees
> (ds/lazy-load-trees).
>
> As described in Documentation/technical/commit-graph.txt, the generation
> number of a commit is one more than the maximum generation number among
> its parents (trivially, a commit with no parents has generation number
> one). This section is expanded to describe the interaction with special
> generation numbers GENERATION_NUMBER_INFINITY (commits not in the commit-graph
> file) and *_ZERO (commits in a commit-graph file written before generation
> numbers were implemented).
>
> This series makes the computation of generation numbers part of the
> commit-graph write process.
>
> Finally, generation numbers are used to order commits in the priority
> queue in paint_down_to_common(). This allows a short-circuit mechanism
> to improve performance of `git branch --contains`.
>
> Further, use generation numbers for 'git tag --contains', providing a
> significant speedup (at least 95% for some cases).
>
> A more substantial refactoring of revision.c is required before making
> 'git log --graph' use generation numbers effectively.
>
> This patch series is build on ds/lazy-load-trees.
>
> Derrick Stolee (9):
>   commit: add generation number to struct commmit

Nice and short patch. Looks good to me.

>   commit-graph: compute generation numbers

Another quite easy to understand patch. LGTM.

>   commit: use generations in paint_down_to_common()

Nice and short patch; minor typo in comment in code.
Otherwise it looks good to me.

>   commit-graph.txt: update design document

I see that diagram got removed in this version; maybe it could be
replaced with relationship table?

Anyway, it looks good to me.

>   ref-filter: use generation number for --contains

A question: how performance looks like after the change if commit-graph
is not available?

>   commit: use generation numbers for in_merge_bases()

Possible typo in the commit message, and stylistic inconsistence in
in_merge_bases() - though actually more clear than existing code.

Short, simple, and gives good performance improvenebts.

>   commit: add short-circuit to paint_down_to_common()

Looks good to me; ignore [mostly] what I have written in response to the
patch in question.

>   commit-graph: always load commit-graph information

Looks all right; question: parameter or one more global variable.

>   merge: check config before loading commits

This looks good to me.

>
>  Documentation/technical/commit-graph.txt | 30 +++++--
>  alloc.c                                  |  1 +
>  builtin/merge.c                          |  5 +-
>  commit-graph.c                           | 99 +++++++++++++++++++-----
>  commit-graph.h                           |  8 ++
>  commit.c                                 | 54 +++++++++++--
>  commit.h                                 |  7 +-
>  object.c                                 |  2 +-
>  ref-filter.c                             | 23 +++++-
>  sha1_file.c                              |  2 +-
>  t/t5318-commit-graph.sh                  |  9 +++
>  11 files changed, 199 insertions(+), 41 deletions(-)
>
>
> base-commit: 7b8a21dba1bce44d64bd86427d3d92437adc4707
