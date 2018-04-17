Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFC721F404
	for <e@80x24.org>; Tue, 17 Apr 2018 18:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752043AbeDQSuv (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 14:50:51 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:38111 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751836AbeDQSuu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 14:50:50 -0400
Received: by mail-qk0-f177.google.com with SMTP id b39so15936812qkb.5
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 11:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=bCRjK6ECpTeZgJFvl74EMjiU3rpCdFpUSlDJX6Kukm0=;
        b=AjeAngojJoGi77zs+wcRx9vAmDuzarWCEExWQ6LDA7zmFmsdYhHCFG36lCDiU6gSxU
         So1OLZUfKvbQAWKi2I3bGEuKBM/1PcvBGUlAMkd1twnE1/8HXANs83yiucZravMt1PDH
         jT2v1aScsrrGvp6LA7898GulvHWZ/hC9p+SBfjzQCEy4sfpMF6ZT3whfiNPNhtrXsDza
         sEMMTkogFSsKNxAUpqxQLKGMz1QFxT+JDdHZt0UORE94fIxt/W6DhhwIDS3kOV3/fC8V
         tLNaNzLkKcDKlnMewOdXkjGgz7PntFro3dd95I1qJ0JcP9f4v2NLYLwIsfABRL2r0tFO
         0qjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=bCRjK6ECpTeZgJFvl74EMjiU3rpCdFpUSlDJX6Kukm0=;
        b=tr/e1/et1XLYheV91+Epr0itMjICVx4y6vRd1LzMdlcb5L389SEvYnUMgouRktI59k
         5DVShOPWfdwUtADknpZZq394LrfcpSIofZdkP2gFtwJpqYxVe/BpJaRfSdgD9rppsBWr
         9XluKkZPmW9QqZkzBlI90jdCHTf7yD9cf5cqOI+r2DEqK/UKbRyZqZPn9gjS+WQIdkmP
         xb4RymnIuYqlRlInuUUWh9BlbQ9U3ep4r82HUWCZhJhPNBcJHwIB6G1o1g9JM2DnO+up
         k33C9APXFrNOsW3K8JDUbV6O92xw7Re7XxL38uUXB21uYDN3g0Iqwca9thBzROJ/RNKR
         XyKg==
X-Gm-Message-State: ALQs6tDog2tqfxoD+cTmPDCipJhJ+TcJDU0k0mVt3czYzg2MTe9myRts
        ALvNkVgdzWfpBOnko+qLC0Lac9dc
X-Google-Smtp-Source: AIpwx4/t6DhS0gNbakcb3YdopyoN6P5ejTT9fRzNxJROhJE0P//iADl7BGs9JMgWmS13287z0ECBWw==
X-Received: by 10.233.193.1 with SMTP id z1mr3338377qki.118.1523991049523;
        Tue, 17 Apr 2018 11:50:49 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:f168:6ce6:8ad9:1b7f? ([2001:4898:8010:0:da9e:6ce6:8ad9:1b7f])
        by smtp.gmail.com with ESMTPSA id f197sm11344966qka.80.2018.04.17.11.50.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Apr 2018 11:50:48 -0700 (PDT)
Subject: Re: [RFC PATCH 00/12] Integrate commit-graph into 'fsck' and 'gc'
To:     Derrick Stolee <dstolee@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>
References: <20180417181028.198397-1-dstolee@microsoft.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ab5777ac-f0e3-e983-185a-f1f8c3f0798a@gmail.com>
Date:   Tue, 17 Apr 2018 14:50:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180417181028.198397-1-dstolee@microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/17/2018 2:10 PM, Derrick Stolee wrote:
> The commit-graph feature is not useful to end users until the
> commit-graph file is maintained automatically by Git during normal
> upkeep operations. One natural place to trigger this write is during
> 'git gc'.
>
> Before automatically generating a commit-graph, we need to be able to
> verify the contents of a commit-graph file. Integrate commit-graph
> checks into 'fsck' that check the commit-graph contents against commits
> in the object database.
>
> Things to think about:
>
> * Are these the right integration points?
>
> * gc.commitGraph defaults to true right now for the purpose of testing,
>    but may not be required to start. The goal is to have this default to
>    true eventually, but we may want to delay that until the feature is
>    stable.
>
> * I implement a "--reachable" option to 'git commit-graph write' that
>    iterates over all refs. This does the same as
>
> 	git show-ref -s | git commit-graph write --stdin-commits
>
>    but I don't know how to pipe two child processes together inside of Git.
>    Perhaps this is a better solution, anyway.
>
> What other things should I be considering in this case? I'm unfamiliar
> with the inner-workings of 'fsck' and 'gc', so this is a new space for me.
>
> This RFC is based on v3 of ds/generation-numbers, and the first commit
> is a fixup! based on a bug in that version that I caught while prepping
> this series.
>
> Thanks,
> -Stolee
>
> Derrick Stolee (12):
>    fixup! commit-graph: always load commit-graph information
>    commit-graph: add 'check' subcommand
>    commit-graph: check file header information
>    commit-graph: parse commit from chosen graph
>    commit-graph: check fanout and lookup table
>    commit: force commit to parse from object database
>    commit-graph: load a root tree from specific graph
>    commit-graph: verify commit contents against odb
>    fsck: check commit-graph
>    commit-graph: add '--reachable' option
>    gc: automatically write commit-graph files
>    commit-graph: update design document
>
>   Documentation/git-commit-graph.txt       |  15 +-
>   Documentation/git-gc.txt                 |   4 +
>   Documentation/technical/commit-graph.txt |   9 --
>   builtin/commit-graph.c                   |  79 +++++++++-
>   builtin/fsck.c                           |  13 ++
>   builtin/gc.c                             |   8 +
>   commit-graph.c                           | 178 ++++++++++++++++++++++-
>   commit-graph.h                           |   2 +
>   commit.c                                 |  14 +-
>   commit.h                                 |   1 +
>   t/t5318-commit-graph.sh                  |  15 ++
>   11 files changed, 311 insertions(+), 27 deletions(-)

This RFC is also available as a GitHub pull request [1]

[1] https://github.com/derrickstolee/git/pull/6

