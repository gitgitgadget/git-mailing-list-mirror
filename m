Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 496B91F576
	for <e@80x24.org>; Sat, 20 Jan 2018 09:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751156AbeATJTY (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Jan 2018 04:19:24 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:46225 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751055AbeATJTV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Jan 2018 04:19:21 -0500
Received: by mail-wm0-f48.google.com with SMTP id 143so7516641wma.5
        for <git@vger.kernel.org>; Sat, 20 Jan 2018 01:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zNsx6KczgZmfZskOLqjjZOvsnGzUNLG/0gYG5DPt5Kg=;
        b=X4CDz8Bj3Lmykrb7yUPQh30wRk4qpCkgi0yKXbZEH07Y63EKTgmM2f241UffxqnyWj
         xVvB45eq1Ah2kkahJnBI1LEHmk7YS0ad/PWjd79PzrvzEMNOYf5gaQEYYlQ3PBsl46Yr
         8WisBSZUB4ZeLrpq2PdCiDbI+W++Ul1uqIcbYSqNhErIynfYl6PZTdfjgrF/QI1eKCUB
         JQjhbXZqvTi2sC/Kfg4CMVvM8yDTb5Kle1xVmH3Ij+Hs72hCJ0Bh07aM9PoC5kh/H0qN
         vSONWa5JjfVsBqa/18x1GCjYOsD1xf2xadNDPnowypL/Fxv06sBAk+lRnfFnC+rs8yMB
         1CZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zNsx6KczgZmfZskOLqjjZOvsnGzUNLG/0gYG5DPt5Kg=;
        b=YrVmMZlDOsEO8k6n1/ucxKCEfB4DeNLocfC9v16gUqT3dj19xENVeughqCsI6AMBe8
         L7oYxBQrRHJhg+BFcNWkDcy9tHg9LYbnhoZVjjibGSzd2bJt4tj8qfdQ9JauuGYR968L
         +2aiTK2ol36vKdDMw6FqRSNMALKVKSDEE9sppMMuBneztbYjR7NLEH0q0O3NoXZ5QPcZ
         vtgVc2eKE0vL8BDTLItx5uGKzXuIMVzz12TnrgXfaLQa82nQAx4BbGRY07e2dsok/kc0
         t4YadDIHn5mzTteTiQs9ye0TawDBwwHFlhxu0Ajru/XfI6B/mKkDrzMr73jSg/rs40Os
         n7Gw==
X-Gm-Message-State: AKwxytfrHYxJgGosj4th/66AqhPGOclThLHV3ow9qsBJu7U0LnkITsq7
        U1qZVJuY0wUP1/3RdroSo290YIsqi+e/SBS+lUA=
X-Google-Smtp-Source: AH8x2264FXY7TKGXq6wIayoyPNr4Rmj0QJIN5M/BxG7aLi3FyImTQcM/CCOo8CUp/lV5grNYYPWDbcxnV2SUK0TARMk=
X-Received: by 10.80.241.89 with SMTP id z25mr2721118edl.104.1516439960070;
 Sat, 20 Jan 2018 01:19:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.177.180 with HTTP; Sat, 20 Jan 2018 01:18:59 -0800 (PST)
In-Reply-To: <b3b37af6-4b65-5a44-a395-6f75a4adc98e@talktalk.net>
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
 <647382ac70bfb7035345304a32d08f4e7b51cd40.1516225925.git.johannes.schindelin@gmx.de>
 <b3b37af6-4b65-5a44-a395-6f75a4adc98e@talktalk.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sat, 20 Jan 2018 01:18:59 -0800
Message-ID: <CA+P7+xr4KtR4q8Y=-+pv2TzvP009zRVR6a_zh2GOZXt_LXrFOg@mail.gmail.com>
Subject: Re: [PATCH 2/8] sequencer: introduce the `merge` command
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 19, 2018 at 6:45 AM, Phillip Wood <phillip.wood@talktalk.net> wrote:
> On 18/01/18 15:35, Johannes Schindelin wrote:
>>
>> This patch is part of the effort to reimplement `--preserve-merges` with
>> a substantially improved design, a design that has been developed in the
>> Git for Windows project to maintain the dozens of Windows-specific patch
>> series on top of upstream Git.
>>
>> The previous patch implemented the `label`, `bud` and `reset` commands
>> to label commits and to reset to a labeled commits. This patch adds the
>> `merge` command, with the following syntax:
>>
>>       merge <commit> <rev> <oneline>
>
> I'm concerned that this will be confusing for users. All of the other
> rebase commands replay the changes in the commit hash immediately
> following the command name. This command instead uses the first commit
> to specify the message which is different to both 'git merge' and the
> existing rebase commands. I wonder if it would be clearer to have 'merge
> -C <commit> <rev> ...' instead so it's clear which argument specifies
> the message and which the remote head to merge. It would also allow for
> 'merge -c <commit> <rev> ...' in the future for rewording an existing
> merge message and also avoid the slightly odd 'merge - <rev> ...'. Where
> it's creating new merges I'm not sure it's a good idea to encourage
> people to only have oneline commit messages by making it harder to edit
> them, perhaps it could take another argument to mean open the editor or
> not, though as Jake said I guess it's not that common.

I actually like the idea of re-using commit message options like -C,
-c,  and -m, so we could do:

merge -C <commit> ... to take message from commit
merge -c <commit> ...  to take the message from commit and open editor to edit
merge -m "<message>" ... to take the message from the quoted test
merge ... to merge and open commit editor with default message

This also, I think, allows us to not need to put the oneline on the
end, meaning we wouldn't have to quote the parent commit arguments
since we could use option semantics?

>
> One thought that just struck me - if a merge or reset command specifies
> an invalid label is it rescheduled so that it's still in the to-do list
> when the user edits it after rebase stops?
>
> In the future it might be nice if the label, reset and merge commands
> were validated when the to-do list is parsed so that the user gets
> immediate feedback if they try to create a label that is not a valid ref
> name or that they have a typo in a name given to reset or merge rather
> than the rebase stopping later.
>
