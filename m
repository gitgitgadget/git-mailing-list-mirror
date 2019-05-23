Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE0881F462
	for <e@80x24.org>; Thu, 23 May 2019 00:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730310AbfEWAoP (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 May 2019 20:44:15 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40494 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729506AbfEWAnK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 May 2019 20:43:10 -0400
Received: by mail-wr1-f65.google.com with SMTP id f10so4260121wre.7
        for <git@vger.kernel.org>; Wed, 22 May 2019 17:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=rt7QilW/1NNwK39FufclhSlP0vDq+CnxIV0yTmTTNoo=;
        b=fuqu7eEsHtbHJnh9eYpXXREGskN8ZDpCSIXTtWT3hEqnTLXXN1Xdqoy1KDXT6FK5VG
         vY7XFCAkgSZrc9N4QY+SADyKwEVLbASMw4YaJX2KTrf/m/r3/LGvvfXR6OozxCBRkG7K
         F7V7zU6Gquy0/LR4QdTgdxC9euuaoNlaGKEcXhhRtezJ1UoYuMdQxDKb2y0mnpZ2N4ac
         E2drY1haeH/4aNxAVFoaPHidseWNuTScDK7m/Xlw0gA5yaq5YH9FQw55TzPP3DqbTe0p
         TCNO+mdp5uVrtvM+zVkxlNFwSigkJZv0BO1ozaE0VqK/XkFite3FzHiX0mbpkg0AybY5
         jirA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=rt7QilW/1NNwK39FufclhSlP0vDq+CnxIV0yTmTTNoo=;
        b=P7lUAOSVxjF+gDqHXwFE6Pru59OONDTbC4Oa4bZxqqAp/55xHhvk21vi9DQklZVzQk
         N1jbUJDrcx/w343LOPnSSkqHKqQ+Gpe+xzY8yqPBHnn5MGeycJGi07nzfio34mLvnniZ
         vylU8+iC3xq5joyZAC28Ejt0IpHEkgAZkWcLGXymQrdgQ3DEW7Gh0J9p6A+00NaYLNCB
         xIJOJkvyqZg1Q/ZIa+CPVvgvMa9hFtUOoM3w/GHd1oh68kow6ZmhNE+jsvOjB7Asfz/2
         ms7C0UOWfTK6PILmLlDjH3OW05N2JFhpbwkZMAOr5pZ1VL+F3kXrh5LJ4MQIK1Xl+YsY
         rbfQ==
X-Gm-Message-State: APjAAAVpivrfyeSvY36yORgA4s7PV/L8aRLohMB2Zn/LuLkfa92M/m41
        A3Bc4tTfCZvTI0/54rS903s=
X-Google-Smtp-Source: APXvYqxsSLW41AaGc2XMu/E1+Z+0VCqXNEKzv2XQ82muThhM476CtAgeA8KW/O3Zo6GfbA/UOHtMIA==
X-Received: by 2002:a5d:6406:: with SMTP id z6mr13453294wru.87.1558572188953;
        Wed, 22 May 2019 17:43:08 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id x22sm9007727wmi.4.2019.05.22.17.43.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 17:43:07 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 09/11] commit-graph: merge commit-graph chains
References: <pull.184.git.gitgitgadget@gmail.com> <pull.184.v2.git.gitgitgadget@gmail.com> <9567daa0b88e9fa2e755d9060341c7a39629ea86.1558554800.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <9567daa0b88e9fa2e755d9060341c7a39629ea86.1558554800.git.gitgitgadget@gmail.com>
Date:   Thu, 23 May 2019 02:43:06 +0200
Message-ID: <87zhnet2zp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 22 2019, Derrick Stolee via GitGitGadget wrote:

> To keep lookups fast, but also keep most incremental writes fast, create
> a strategy for merging levels of the commit-graph chain. The strategy is
> detailed in the commit-graph design document, but is summarized by these
> two conditions:
>
>   1. If the number of commits we are adding is more than half the number
>      of commits in the graph below, then merge with that graph.
>
>   2. If we are writing more than 64,000 commits into a single graph,
>      then merge with all lower graphs.
>
> The numeric values in the conditions above are currently constant, but
> can become config options in a future update.
> [...]
> +## Merge Strategy
> +
> +When writing a set of commits that do not exist in the commit-graph stack of
> +height N, we default to creating a new file at level N + 1. We then decide to
> +merge with the Nth level if one of two conditions hold:
> +
> +  1. The expected file size for level N + 1 is at least half the file size for
> +     level N.
> +
> +  2. Level N + 1 contains more than MAX_SPLIT_COMMITS commits (64,0000
> +     commits).
> +
> +This decision cascades down the levels: when we merge a level we create a new
> +set of commits that then compares to the next level.
> +
> +The first condition bounds the number of levels to be logarithmic in the total
> +number of commits.  The second condition bounds the total number of commits in
> +a `graph-{hashN}` file and not in the `commit-graph` file, preventing
> +significant performance issues when the stack merges and another process only
> +partially reads the previous stack.
> +
> +The merge strategy values (2 for the size multiple, 64,000 for the maximum
> +number of commits) could be extracted into config settings for full
> +flexibility.

As noted this can become configurable, so it's no big deal. But is there
any reason for ths 64K limit anymore?

While with the default expiry of 0sec we can still get that race, it
seems unlikely in practice, as the "commit-graph write" process would
write a new manifest at the end, then go and unlink() the old files.

So maybe at this point we could make this even dumber with something
that behaves like gc.autoPackLimit? I.e. keep writing new graphs, and
then coalesce them all (or maybe not the "base" graph, like
gc.bigPackThreshold)?

Also: These docs refer to MAX_SPLIT_COMMITS, but in v2 it's now a
"split_strategy_max_commits" variable instead.
