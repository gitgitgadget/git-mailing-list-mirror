Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 887B81F461
	for <e@80x24.org>; Wed, 15 May 2019 15:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbfEOPZh (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 11:25:37 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:36417 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfEOPZg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 11:25:36 -0400
Received: by mail-ed1-f52.google.com with SMTP id a8so408869edx.3
        for <git@vger.kernel.org>; Wed, 15 May 2019 08:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=/T6K/2VO+JnIzqMz7qoQEurs+i6yaJGZznBcCfgpWlY=;
        b=cifREVH0PN4kuyVUqAP687nj05ixcS3mLWxWuCmhgSteY5XXlrjVCbl7gtIy+hVgDU
         FW7+XWcXg4ngGppGGkIIud/7J9Y1l7RnFQ514DE/PUFdwK3XKbHQCZIiM/phi1xz4D54
         6X0MIkTcjEvS9B2zyl2YKzuA98UlR5OvA2b6eSDORsPx7rP0PnxieOAuW0VEEjIwbgdZ
         +JKA/FJmI9+A+RcaOP60w4Kf7j84UAMvw0CPi+tjg9zlhmEkH7wDHH1+pfLjcUYDBXr7
         i9D28i/yQXbaXgupq0VQnD3YGLzwcInaZPLSVvBF7EkLiylCPxRS2HtGR3pKsqePWlR2
         DIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=/T6K/2VO+JnIzqMz7qoQEurs+i6yaJGZznBcCfgpWlY=;
        b=soLaXAwSTiMDg8Pmu2wvw6652Khd90Q/C83e7R6oeRLdLUT0Wa0/EFpN7tPhD+hd3h
         KYjcAOynir/eG1PhRdfxUO9Lnxajoxbri3bKeTpvrtPzoVmud1abyecycKtwFZBQiOZO
         IE4AxbLaFc5obZ3IrCm5dtguIAZrkal38G1HuUV2YbRtDgOZrDJ4NJXjBUlIK24Y5gwt
         fLyzf/xvCskbRLbgwjDdMArVZ3HUJ4DoG3JI+RxVroL1H5LFl3K32UOprZAwladP5h5N
         k8sjVMq/LpJrGHF1opVdaBZM9al/AcBNpqZzaSnIgKlD8amJGqU23QVGZhdDZ3sTSdHe
         xjQw==
X-Gm-Message-State: APjAAAWlHPSLcAtODSRBVhqVjgKBdChJJ9gMnKiUb5xxd0Sr5AtlOlEM
        s9fcO70xP/lj++Fer1uJpuUx8Gqd
X-Google-Smtp-Source: APXvYqzfq8xkxC8VHM85+Vbv3AYEvW+HvFq8Fr05uK//bhKzYp2zHLn7hVPPZqnujnMFkw4OsE0CyA==
X-Received: by 2002:a05:6402:1358:: with SMTP id y24mr39234666edw.207.1557933934669;
        Wed, 15 May 2019 08:25:34 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id j3sm835625edh.82.2019.05.15.08.25.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 08:25:33 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Merging (joining/stiching/rewriting) history of "unrelated" git repositories
References: <CAA01CsoJf+_-iowdm0EFWd52vOWE1Uo0GGZ55d3RyPJzg6gwgQ@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <CAA01CsoJf+_-iowdm0EFWd52vOWE1Uo0GGZ55d3RyPJzg6gwgQ@mail.gmail.com>
Date:   Wed, 15 May 2019 17:25:31 +0200
Message-ID: <874l5vwxhw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 15 2019, Piotr Krukowiecki wrote:

> Hello,
>
> I'm migrating two repositories from svn. I already did svn->git
> migration (git-svn clone) and now have two git repositories.
>
> I would like to merge them into 1 git repository, but to merge also
> history - branches and tags.
>
> The reason is that the svn repositories in fact represent one
> "project" - you had to download both of then, they are not useful
> separately. Tags were applied to both repositories, also list of
> branches is almost identical for both.
>
> So right now I have:
>
>     - projectA:
>        master: r1, r4, r5, r7
>        branch1: r10, r11, r13
>     - projectB:
>        master: r2, r3, r6
>        branch1: r12, r14
>
> The content of projectA and projectB is different (let's say projectA
> is in subfolder A and projectB is in subfolder B). So revisions on
> projectA branches have only A folder, and revisions on projectB
> branches have only B folder.
>
> But I would like to have:
>
>     - projectAB:
>        master: r1', r2', r3', r4', r5', r6', r7'
>        branch1: r10', r11', r12', r13', r14'
>
> Where all revisions have content from both projects. For example, the
> r5' should have the "A" folder content the same as r5, but also should
> have "B" folder content the same as in r3 (because r3 was the last
> commit to projectB (date-wise) before commit r5 to projectA).
>
> There's additional difficulty of handling merges...
>
>>
> Any suggestions on what's the best way to do it?
>
>
> Currently I'm testing join-git-repos.py script
> (https://github.com/mbitsnbites/git-tools/blob/master/join-git-repos.py)
> but it's slow, memory inefficient and handles "master" branch only...
>
>
> Thanks,

You might be able to use https://github.com/newren/git-filter-repo

But I'd say try something even more stupid first:

 1. Migrate repo A to Git
 2. Migrate repo B to Git
 3. "git subtree add" B's history to A
 4. "git rebase" the history to linear-ize it

At this point you'll have A's history first, then B. Then run some
script to date order the commits, and just "git cherry-pick" those in
the order desired in a loop to a fresh history.

Maybe that sort of stupidity will wreck your merges etc., so you might
need less stupid methods :)
