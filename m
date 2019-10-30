Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAE241F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 16:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfJ3Qlw (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 12:41:52 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42684 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbfJ3Qlw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Oct 2019 12:41:52 -0400
Received: by mail-ed1-f68.google.com with SMTP id s20so2277434edq.9
        for <git@vger.kernel.org>; Wed, 30 Oct 2019 09:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3ZvmbujV1Am5tI78k8u94sHwB1/PhdcT72NEvY5I3vU=;
        b=DmU9KbRvKc0fhJs+Au3il6ThqLHj+Nqhp19lbUGtb/dkG3XKrazxXcyiAThJxbqWUU
         U4vPJubTA6XsiNsijR+oTFbWHF0nuu0HlkKUnAAhI5t56R8/vDzgZ4gjoRyrBvHuFfQ+
         zCqD+hSDqb59AUhGPXynag6QbFQ4Au9mdMZzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ZvmbujV1Am5tI78k8u94sHwB1/PhdcT72NEvY5I3vU=;
        b=IY1rcnjrP7hm1JGYD47CFgOfya/gnRmZY5biHxzuk5u2f/7ATZWjOio5mpMqxmu2TP
         D7fqA1pN/mDag2LHcsASSX5xqwL9nxwEUZBHFaONIyA316koSgPR35Wingp7BZtyMjm0
         J1mScADeEeHJcwGxV2mMZz8JBClciHZPkwrKYPKOkxxzWOLYxgYTrUWzclpwrCtWO3b8
         coWO2oRMbRFF7DQIeZfueoJm/q+KOqqWmay7vu22DJWyzYYdPGVv6fzjB5XPkyuxCALv
         coCIeovEw7nBmuySxy3JDJ9SVixwXBBJvOL3agUJMvgxAO558rVpDL7oOtfjS2kSDVrQ
         c9Sg==
X-Gm-Message-State: APjAAAWCL/qYMANJhNI27A9hfvHl4eV23UJ+jzDbrl+YP4g0X2whIaeR
        mC4YCTMSZ/tIXTg6WGOmhyvkVGw82tkc3qMg6HAb6A==
X-Google-Smtp-Source: APXvYqx98ebrBJHt/gdTIh5b96PoGq3ItDu/0v50rQchS826EVvkwt30jhdF7879c1PKLWBbHidslFoEN/sOO+mQaJY=
X-Received: by 2002:a17:906:743:: with SMTP id z3mr482774ejb.142.1572453708853;
 Wed, 30 Oct 2019 09:41:48 -0700 (PDT)
MIME-Version: 1.0
References: <pull.424.git.1572017008.gitgitgadget@gmail.com>
 <609c7c5047719a619ba22425dafc6ecd105e2cda.1572017008.git.gitgitgadget@gmail.com>
 <xmqq8sp5a6cd.fsf@gitster-ct.c.googlers.com> <CAPYzU3N9mDfHVogfq=mhJFj6VOjS2z4ui4msnDdK6pOtVBa_QA@mail.gmail.com>
 <BN6PR21MB078676C4FA54391B1954D5F791660@BN6PR21MB0786.namprd21.prod.outlook.com>
 <CAPYzU3NZZ-H_PWcRH_ooXzrYnRNjvF9ayX4_xeMJeMiHB=8fLg@mail.gmail.com>
 <BN6PR21MB078689FFE9ED95A31998F41A91610@BN6PR21MB0786.namprd21.prod.outlook.com>
 <CAPYzU3Mv9fHG_WhCOfsA8KGeegdUCoEzfDCt8-DQ+CEjs=V62Q@mail.gmail.com> <xmqqh83r5bi0.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqh83r5bi0.fsf@gitster-ct.c.googlers.com>
From:   Utsav Shah <utsav@dropbox.com>
Date:   Wed, 30 Oct 2019 09:41:37 -0700
Message-ID: <CAPYzU3MuacmCJoC0pioL4ymyRA7tku8BbNmSTrtZtJWMHpvJNg@mail.gmail.com>
Subject: Re: [PATCH 1/1] unpack-trees: skip lstat based on fsmonitor
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kevin Willford <Kevin.Willford@microsoft.com>,
        Utsav Shah via GitGitGadget <gitgitgadget@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Utsav Shah <ukshah2@illinois.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, that makes a lot of sense. ce_uptodate doesn't have too many
callers either, so modifying it and checking CE_FSMONITOR_VALID there
should not be hard to audit.



On Tue, Oct 29, 2019 at 5:21 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Utsav Shah <utsav@dropbox.com> writes:
>
> > Thanks for testing it out. The unpack_trees bugfix is especially useful.
> >
> > There's tons of places where we're using ce_uptodate(ce) that could be
> > optimized by checking CE_FSMONITOR_VALID. One example is in
> > run_diff_files in diff-lib.c
> >
> > Should we add a check for CE_FSMONITOR_VALID in all of them? Should we
> > do that in this patch? Or should we take the time to refactor and
> > flesh out bugs in unifying it with CE_UPTODATE?
>
> If we rephrase the first question slightly, i.e. "should these
> places all be avoiding lstat() based check when fsmonitor says the
> path is up to date?", I would imagine the answer is absolutely yes.
>
> I would further imagine that the implementation of the interface to
> external fsmonitor itself may have to distinguish "we know/have known
> this path is clean" vs "we just got told by fsmonitor that this path
> is clean", so losing FSMONITOR_VALID bit might not be an easy or
> clean conversion, in which case my earlier "can we perhaps lose it
> and have fsmonitor interfacing code to directly set UPTODATE bit?"
> would lead us in a wrong direction.
>
> But ce_uptodate(ce) being the primary way for the callers that care
> about "is the path known to be up to date?", it is unsatisfying that
> all of them have to ask
>
>         if (!ce_uptodate(ce) && !(ce->ce_flags & CE_FSMONITOR_VALID))
>                 ... process ce that is not up-to-date ...
>
> So I would say that the longer term goal should be to let them ask
> ce_uptodate(ce) and have that macro automatically take FSMONITOR bit
> into account (in other words, those who want to know if ce is fresh
> should not have to even know about what fsmonitor is).
>
> Perhaps we can take a polished version of this "'reset --hard' can
> and should notice paths known-to-be-uptodate via fsmonitor" as an
> independent patch (to reduce the number of things we have to worry
> by one) for now?  Taking this patch means we would now have one more
> place that checks both ce_uptodate() and FSMONITOR_VALID bit, but if
> we would be auditing all such places before we can decide what the
> best way to reach the goal of allowing them to just say ce_uptodate()
> without having to spell FSMONITOR_VALID, that probably is a cost
> worth paying.
>
> Thanks for working on this topic.
>
>
>
