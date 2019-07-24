Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 988521F461
	for <e@80x24.org>; Wed, 24 Jul 2019 13:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfGXN3J (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jul 2019 09:29:09 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41199 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfGXN3J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jul 2019 09:29:09 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so43792225wrm.8
        for <git@vger.kernel.org>; Wed, 24 Jul 2019 06:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=empjzjbGxu6wSitNXDzNKpHmghjM6v9zYabP2tawVE4=;
        b=J3h4rWFqmFwM1z3u9BIlC5HXysiQF+VYiYqr9BTVxmX785uE9HNCYlxS8H3X08w7Ri
         gxIB8orWjTMmyRKoTqa6FIaaX2axcgsQFIhNq1KIHs55rxkdogpMwmW5Sri3bYsoZXIk
         +rLy1/Po0d48L9Uug108/EgDThbIsCWJWj6uYQaAp0gyz9te4d1COYi1EIQuGkFai8nf
         4uf/FOSTjg817FjD4wv6PLsLe7rVo7GGvDof+gOzIjjy3iRAurcR97L8ZUFZlGHPupc3
         nCwtEv0ZWA4wmJtdsGM0coRrm9jgszW2gnKioEUZRiAyMMndIFgaIur6Xl5jqhX9PJH5
         53AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=empjzjbGxu6wSitNXDzNKpHmghjM6v9zYabP2tawVE4=;
        b=TWY+l7BiaTO0xnV2QvhY6azOkQd4zEh9uote5jaddtQLMAgJIERt3SqykUL8Kp4Z/i
         5Tn1BovmMfQFknsDjCb7UNXOv8sRisaer4DO0ZUj/cqdN0Tl3i25yVbNUex/UbAxlwZY
         zo3rky690DpdPQBZFBtRRJ3v/xkBd3izH838tMKHZXytyw3V996OIaizzD6sy6GCDtJY
         U3mfDhQSz2pB+FHYsc6tF3qb4WdxkC+4bZ3UwIPxMOl+Y7UUwdwl9lhDiuaHYiVS8oGE
         WYh/Zoo9t8ToHsLgcFCVDIhrsKGCxxjpXp65DmIQ8PEe0AiY6oJyx5YDyyKLm3E5awUc
         +zYg==
X-Gm-Message-State: APjAAAX4rbtBnFvFnbSkhaITOM9fofqCMwB0kbHF3MljbH/n2MIV4c1P
        K4L1JSTGtAKk1RKa6amQMwE=
X-Google-Smtp-Source: APXvYqxFe8i7WsYBWCX+p/8RBC9A24yKld8O9BviQWY6gci4Vx6L7ptMqGz/WCO3HrcUviesYoifhQ==
X-Received: by 2002:adf:fdcc:: with SMTP id i12mr8106480wrs.88.1563974947315;
        Wed, 24 Jul 2019 06:29:07 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-12-131.as13285.net. [92.22.12.131])
        by smtp.gmail.com with ESMTPSA id s3sm45444999wmh.27.2019.07.24.06.29.05
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 06:29:06 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 0/9] rebase -i: extend rebase.missingCommitsCheck to
 `--edit-todo' and co.
To:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20190717143918.7406-1-alban.gruin@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <ce6bdffd-0a04-803c-4a1e-0959342db01f@gmail.com>
Date:   Wed, 24 Jul 2019 14:29:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190717143918.7406-1-alban.gruin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban

Thanks for working on this, it's great to see you back on the list and I 
think it would be a useful addition to rebase. Unfortunately I'm not 
sure about this implementation though (although the early bug fix 
patches are useful in their own right)

On 17/07/2019 15:39, Alban Gruin wrote:
> To prevent mistakes when editing a branch, rebase features a knob,
> rebase.missingCommitsCheck, to warn the user if a commit was dropped.
> Unfortunately, this check is only effective for the initial edit, which
> means that if you edit the todo list at a later point of the rebase and
> dropped a commit, no warnings or errors would be issued.
> 
> This adds the ability to check if commits were dropped when resuming a
> rebase (with `rebase --continue'), when editing the todo list (with
> `rebase --edit-todo'), or when reloading the todo list after an `exec'
> command.

I'm not sure if we really need to check the todo list when continuing or 
after an exec command. The official way to edit the todo list is to run 
'git rebase --edit-todo' and I'm not sure if we support scripts writing 
to .git/rebase-merge/git-rebase-todo directly. If we only support the 
check after --edit-todo then I think the implementation can be 
simplified as we can just write a copy of the file before it is edited 
and don't need to check .git/rebase-merge/done. Additionally that would 
catch commits that are added by the user and then deleted in a later 
edit. They wont be in the original list so I don't think this series 
will detect their deletion.

At the extreme I have a script around rebase that runs 'rebase -i HEAD' 
and then fills in the todo list with a fake editor that adds 'reset ...' 
as the first line to set the starting point of the rebase. I think 
dscho's garden-shears script does something similar. Under the proposed 
scheme if I subsequently edit the todo list it will not catch any 
deleted commits as the original list is empty.

Best Wishes

Phillip

> The idea to extend this feature was suggested to me more than a year ago
> by Phillip Wood, if I'm not mistaken.  I postponed this until four month
> ago, when ag/sequencer-reduce-rewriting-todo finally hit master, but I
> had to stop because of other obligations.  I could go back to work one
> month ago, when I did the bulk of this series, but I lacked time to
> polish it, so it waited a bit more.  Now, I think it is in a good shape
> to be sent, although it is still RFC-quality to me.  The advertised
> functionality should work well, but perhaps there is some flaws I
> missed.
> 
> The first two patches are new tests, demonstrating that after the
> initial edit, the check is not done.  The next four are what could be
> qualified as omissions from ag/sequencer-reduce-rewriting-todo, but they
> are quite important (IMHO) for the rest of the series.  The last three
> actually extend rebase.missingCommitsCheck.
> 
> This is based on master (9d418600f4, "The fifth batch").
> 
> The tip of this series is tagged as "edit-todo-drop-rfc" in
> https://github.com/agrn/git.
> 
> Alban Gruin (9):
>    t3404: demonstrate that --edit-todo does not check for dropped commits
>    t3429: demonstrate that rebase exec does not check for dropped commits
>    sequencer: update `total_nr' when adding an item to a todo list
>    sequencer: update `done_nr' when skipping commands in a todo list
>    sequencer: move the code writing total_nr on the disk to a new
>      function
>    sequencer: add a parameter to sequencer_continue() to accept a todo
>      list
>    rebase-interactive: todo_list_check() also uses the done list
>    rebase-interactive: warn if commit is dropped with --edit-todo
>    sequencer: have read_populate_todo() check for dropped commits
> 
>   builtin/rebase.c              |  2 +-
>   builtin/revert.c              |  2 +-
>   rebase-interactive.c          | 67 +++++++++++++++++++++++-----
>   rebase-interactive.h          |  6 ++-
>   sequencer.c                   | 53 ++++++++++++++--------
>   sequencer.h                   |  3 +-
>   t/t3404-rebase-interactive.sh | 82 +++++++++++++++++++++++++++++++++++
>   t/t3429-rebase-edit-todo.sh   | 44 ++++++++++++++++++-
>   8 files changed, 224 insertions(+), 35 deletions(-)
> 
