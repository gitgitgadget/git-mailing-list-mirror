Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EECD1F461
	for <e@80x24.org>; Tue,  3 Sep 2019 12:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbfICMTI (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 08:19:08 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51608 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbfICMTI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 08:19:08 -0400
Received: by mail-wm1-f66.google.com with SMTP id k1so17909071wmi.1
        for <git@vger.kernel.org>; Tue, 03 Sep 2019 05:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ckt/c03oX6iz1cfkPIuxRgODSUK2BCEpc0n4yy9mBiM=;
        b=bBmfgRHoe/GKfOra4FVJ0AgyF7E1kRd4Z+wF4TN19Yb9hKHe5CJfsvAeJ9RXGza265
         RfFOx6lS0SnLXdDxQuVJKPT4kSu2t0evIhQbS5DWGicbxc3oHZbNLEM/xjbV2DNly40r
         OO7Gof4QY+ZElz0D0BBCvTubqS82Gcsb6194BU9i44NefjzhF28K1y6hgvTEzF8et4kq
         YqT8RRWx9nYiBZ4hho7yF77cp9nLrMFGPGDGL8Gh0LcRCbMfYi0Evuu7aqRw641wgjf3
         kwgy7X8iq8+4kmsqTQT8km3Q5C1EVVdhZmJnKkbwKdQf0ek5P2Kiu3qRpu/7cEW9pP8p
         IHgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ckt/c03oX6iz1cfkPIuxRgODSUK2BCEpc0n4yy9mBiM=;
        b=Ijuh3BokkMYf+GRPW3Kh9tRmjVQWVpiXkAoMoZEyzRp4OwD48QjWxT1BtiTldB+aRt
         KENsYeJdg+GYd+xHDgW53AxHgsOJJdhfsI0PCTQnEkAfuxt0WVvdrVMrMtEYlCYtIw5I
         4dAEKRLsC3DamdsYJc1avw8isZVQoAX2uZRhS7zmKA29kmYd9J9x4qYWsHwgFnrWH6bu
         YTPwgufgqkkMbHo3dLqHFTmrBVrVam/HxH90sY2z1lBZdvoXUDL0Bc5GvOpaCc4qb/Np
         GaLcXxAKpKBDi1l0+o32/LjbxKN4FIkUFq2UB+EHH5/CIud2pSXlg/3jcZPDxn/RG8P6
         qIMQ==
X-Gm-Message-State: APjAAAXWj7ooM+R0BEXQV+QAiTQyGDQl3M2U1C0ADk93djmimUo2Ehkk
        JNbE4kSKXWmnW9B2Dirg2Q0=
X-Google-Smtp-Source: APXvYqxrHwvA3MR1/akIEm5OSs3cwBXugvQQ+zvjMHdMMxnwCKF+IYBiUhCnlf5QulugVW370lQivg==
X-Received: by 2002:a1c:a546:: with SMTP id o67mr36786638wme.55.1567513146281;
        Tue, 03 Sep 2019 05:19:06 -0700 (PDT)
Received: from [192.168.1.70] (88-110-119-23.dynamic.dsl.as9105.com. [88.110.119.23])
        by smtp.gmail.com with ESMTPSA id v11sm30481224wrv.54.2019.09.03.05.19.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2019 05:19:05 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase: introduce --update-branches option
To:     Warren He <pickydaemon@gmail.com>, git@vger.kernel.org
Cc:     Warren He <wh109@yahoo.com>, Junio C Hamano <gitster@pobox.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>
References: <20190902234109.2922-1-wh109@yahoo.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <713b055b-aaf2-4294-12d3-2941d53eac16@gmail.com>
Date:   Tue, 3 Sep 2019 13:19:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190902234109.2922-1-wh109@yahoo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Warren

On 03/09/2019 00:41, Warren He wrote:
> Sometimes people have to rebase multiple related branches. One way to do that
> quickly, when there are branches pointing to ancestors of a later branch (which
> happens a lot if you try hard to pad your PR count on GitHub--I mean if you try
> to make small, logically separate changes), is to rebase that later branch and
> then reset ancestor branches to the rewritten commits. You just have to work
> out which branches correspond to which of the new commits.
> 
> Here's an automated way to update those ancestor branches.

I think this would be really useful, but as it is implemented here it 
only updates branch heads that are in the todo list. This means that if 
I have a branch structure like

A - B (master)
|
C - E (topic-2)
|
D (topic-1)

and I do `git rebase --update-branches master topic1` Then topic-2 will 
not be updated and if I do `git rebase --update-branches master topic2` 
then topic-1 will not be updated even though C is updated in both cases 
and is a common ancestor of topic-1 and topic-2. Conceptually to update 
all the branches descended from a rewritten commit would require using 
`git for-each-ref --contains $(git merge-base <upstream> <branch>)` and 
then using `git rev-list <upstream>..<branch-head>` on each of those 
refs to get the commits to generate the todo list.

Another case is applying fixup commits. In the example above if I squash 
a fixup for C from either branch I probably want to update both the 
branches descended from it.

One other thing is that if the user aborts the rebase then ideally we 
don't want to update all the branches so it would be better to store the 
updated heads as we go along and then update them all at the end of the 
rebase. Worktrees add another complication as if one of the branches 
that is to be updated is checked out in another worktree then we need 
some way to deal with that. If there are no local changes in that 
worktree then we could just update the local HEAD and working copy.

Best Wishes

Phillip

> 
> It's implemented as a function that processes a todo list, modeled after
> `todo_list_add_exec_commands`. Currently steps are added as `exec git branch -f
> <branchname>`, which comes with the caveat that they're not applied atomically
> when it finishes rebasing.
> 
> If you were to use this feature to rebase `my-dev` onto `master` in this
> situation:
> 
> ```
>   A - B          (master)
>    |\
>    |  E          (feat-e)
>     \   \
>       F  |       (feat-f)
>         \|
>           G      (interim)
>             \
>               H  (my-dev)
> ```
> 
> you'd get a todo list like this:
> 
> ```
> label onto
> 
> # Branch G
> reset onto
> pick 65945ab E
> exec git branch -f feat-e
> label G
> 
> reset onto
> pick 4f0b0ad F
> exec git branch -f feat-f
> merge -C e50066c G # G
> exec git branch -f interim
> pick 539e556 H
> ```
> 
> Warren He (1):
>    rebase: introduce --update-branches option
> 
>   Documentation/git-rebase.txt      |  8 +++++
>   builtin/rebase.c                  | 13 ++++++--
>   sequencer.c                       | 68 ++++++++++++++++++++++++++++++++++++++-
>   sequencer.h                       |  6 ++--
>   t/t3431-rebase-update-branches.sh | 64 ++++++++++++++++++++++++++++++++++++
>   5 files changed, 154 insertions(+), 5 deletions(-)
>   create mode 100755 t/t3431-rebase-update-branches.sh
> 
