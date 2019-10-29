Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB11A1F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 23:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbfJ2XvH (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 19:51:07 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41363 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfJ2XvH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 19:51:07 -0400
Received: by mail-ed1-f67.google.com with SMTP id a21so266782edj.8
        for <git@vger.kernel.org>; Tue, 29 Oct 2019 16:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nDKWiLCp7cJVzOyY+wefr9IlYoVXKvUxaGjeUTPTBdA=;
        b=VKR8yULPLngZOBaZQNJ0HxvCd38Z8csBQ1N0g9sgk5zm9pOw8ypFhUJtpR5+vk/plf
         bbI4CzOTHjM5fDADueVXZuxdaOmTIqtCQO3bDO/bLJiOwkC0HxG9sbDfatnEkfzMPRF8
         0dQkxdHQwtzG1TcVC14jT1qo5axKbRB4vYEGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nDKWiLCp7cJVzOyY+wefr9IlYoVXKvUxaGjeUTPTBdA=;
        b=cFqpJ0xdCJ18z+vys95KgeBC6PuqIHS2Nh592R4cYEFuoEXkh7fAFBfTXCc3yxfIt4
         dKRWNfeHmuGbt4FcsF3P1OIkcle2mm1P1Al9sQwZ9vFfiT5FY7tbUVZpB5S1RfAkQvhY
         m8WQgkjNsLBw68WmwnVuNYOTw0NFMeIU7x+AA2Chpl0R3Neu2B3tq4kWF9WJUseiN2A3
         aoLP6BwopZpi426VzyFJHI3of2+w0e5uhqoZhgWYzo3BTCGPy25XDdPGrtpJaiuOczl6
         n/LLa7oeLo6XmAfXxq99KR/YiaHZQ/Bgi26A+t6P9CipPUkl//iDIQrIcxELjRojKZwv
         cnCg==
X-Gm-Message-State: APjAAAWamMcSY+WqW6QaIjMYZwCduI4KOF0RLuoGY80lowXUwbq+nSPe
        9HkDypyveme/PAIQA2IxAjs6semN1WMU4yo3OnpLmw==
X-Google-Smtp-Source: APXvYqwzeUFogLpputESQ58O8sjA5qxyHag8eJKRSyPMw31J8UvFgDd3yjcRNcNUR8Hu1JEEjEvHlbIWm81OaU8SVA4=
X-Received: by 2002:a17:906:743:: with SMTP id z3mr5987458ejb.142.1572393065648;
 Tue, 29 Oct 2019 16:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <pull.424.git.1572017008.gitgitgadget@gmail.com>
 <609c7c5047719a619ba22425dafc6ecd105e2cda.1572017008.git.gitgitgadget@gmail.com>
 <xmqq8sp5a6cd.fsf@gitster-ct.c.googlers.com> <CAPYzU3N9mDfHVogfq=mhJFj6VOjS2z4ui4msnDdK6pOtVBa_QA@mail.gmail.com>
 <BN6PR21MB078676C4FA54391B1954D5F791660@BN6PR21MB0786.namprd21.prod.outlook.com>
 <CAPYzU3NZZ-H_PWcRH_ooXzrYnRNjvF9ayX4_xeMJeMiHB=8fLg@mail.gmail.com> <BN6PR21MB078689FFE9ED95A31998F41A91610@BN6PR21MB0786.namprd21.prod.outlook.com>
In-Reply-To: <BN6PR21MB078689FFE9ED95A31998F41A91610@BN6PR21MB0786.namprd21.prod.outlook.com>
From:   Utsav Shah <utsav@dropbox.com>
Date:   Tue, 29 Oct 2019 16:50:54 -0700
Message-ID: <CAPYzU3Mv9fHG_WhCOfsA8KGeegdUCoEzfDCt8-DQ+CEjs=V62Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] unpack-trees: skip lstat based on fsmonitor
To:     Kevin Willford <Kevin.Willford@microsoft.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Utsav Shah via GitGitGadget <gitgitgadget@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Utsav Shah <ukshah2@illinois.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for testing it out. The unpack_trees bugfix is especially useful.

There's tons of places where we're using ce_uptodate(ce) that could be
optimized by checking CE_FSMONITOR_VALID. One example is in
run_diff_files in diff-lib.c

Should we add a check for CE_FSMONITOR_VALID in all of them? Should we
do that in this patch? Or should we take the time to refactor and
flesh out bugs in unifying it with CE_UPTODATE? It would be nice to
get more opinions. I've taken a look and believe that it will make
things a little more complicated to merge it with CE_UPTODATE,
especially since it's used in a few places for other reasons like
sparse checkouts. On the other hand, I'm a first time contributor, so
my perspective towards a large refactor like might be too
conservative.


On Tue, Oct 29, 2019 at 1:12 PM Kevin Willford
<Kevin.Willford@microsoft.com> wrote:
>
> > On Tuesday, October 29, 2019 1:07 PM Utsav Shah <utsav@dropbox.com>
> > wrote:
> >
> > I'm getting the same test failures with or without
> > GIT_TEST_FSMONITOR=t/t7519/fsmonitor-all and calling refresh_fsmonitor
> > in tweak_fsmonitor. Could you share your patch? I'm probably messing
> > something up, and I can try taking a look at fixing test cases as well.
>
> I have the tests passing with the following commit.
>
> https://github.com/kewillford/git/commit/3b1fdf5a4b1cd1d654b1733ce058faa4f087f75f
>
> Things to note:
> 1. Not sure if fsmonitor was tested with split index so for now I removed that from the
> check of entries in fsmonitor bitmap vs the number of cache entries
> 2. With these changes update-index was triggering the post-index-change hook with the
> updated_skipworktree flag set which it wasn't before.
> 3. Copied the fsmonitor_last_update to the result index so the fsmonitor data will be
> carried over to the new index in unpack_trees.  This is to make sure that the next call
> to git will have the fsmonitor data to use.  We found that running `git status` after any
> command that ran unpack_trees (checkout, reset --hard, etc.) was very slow the first
> call but and subsequent calls were fast.
>
> I'm still testing and reviewing these changes to make sure there isn't something I
> have missed and that I made the right changes to the tests that were failing.
>
> Kevin
