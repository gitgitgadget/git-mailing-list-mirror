Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D8E71F597
	for <e@80x24.org>; Fri, 27 Jul 2018 18:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388727AbeG0T2Y (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 15:28:24 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:36016 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388344AbeG0T2X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 15:28:23 -0400
Received: by mail-it0-f66.google.com with SMTP id p81-v6so8549063itp.1
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 11:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fOM7aQ8nZCyPZLLhU8FGlbcovvGTR6BRvATBgWQBKnM=;
        b=aqCJOIKYRFGkatzMeECArL7jarb5TuccmWoAdlzFtnxbFcASet9q5r3JTyZQbfNaLI
         6Pw07eMsoh+/Q/57wqS+wXVGAlgQZlNrFFpuwNWum2/c8zqAc3Avbn4Ruar5cl0iwwqQ
         wirlGqK7aLBYYPBiRWx3dwejq+JOQcNWdVta5iDbwfjkoa/MocggkFnBw5NXCA0EK3jr
         2cW2Wzui5oGZ2wdpw638GJ1ajHvrjzWTg7Wo10+sxXa8KZSNHs0WgijLSC0ACk4m/vll
         TiEv2MDXOOgKg1iLA11wo2++n5KZ+DyLscY4AVBCJAq8rf01pyWm0eACnNH9RpPTWSlk
         ll0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fOM7aQ8nZCyPZLLhU8FGlbcovvGTR6BRvATBgWQBKnM=;
        b=ge/RSIH9cjDSYm49Y4SCyl/kQH76A8xTVBafpYN7tCqX9fXCdKpaMHI0p9V/Ue5mmT
         NY0i4Y0DIhZyOcsrxy3qyC/7OYtMn8/xarlSAfRpAzjKnvxUMBd9Gso5I2EAcVLffhkk
         m/c3Rpm0tlmyqXZqUhyKQPFzlxmXejgVSvwaSoe7fTqKxeMI82TVIJQbtYxQmaN6PgrA
         pX68/go9rl60g7xe8FCacsByp320aMglbjXyQTyhA9BfEIgeE1w1tupRhKijwrMKBej2
         qqFwS3Ee/tye8eTdWQ91sWbmDQmHE48se2uy8E2Czd6Mrt6HjxSohaR1e9/WYD3hKMOh
         Q9OA==
X-Gm-Message-State: AOUpUlGGifDAp+i9Da33Gv/RkuYApD2eMB+gJ9G8tyIS9vnNc1JTcEoF
        6jno8DUOnFf2hC7PDwKSooqcazrDVjqqdJ7SMI21gw==
X-Google-Smtp-Source: AAOMgpdzXwHlkjOz65dTr6JCwX50g78avKfp1d8j/9akEiN9KGKhSOq5/OLMFs3vGmtr4MLSIaJORt3EKOor1nixxjk=
X-Received: by 2002:a02:7e45:: with SMTP id h66-v6mr7239186jac.97.1532714722414;
 Fri, 27 Jul 2018 11:05:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180727003640.16659-1-sbeller@google.com> <20180727003640.16659-3-sbeller@google.com>
 <CACsJy8Ae3sZvOQ3irQM+hv0fCRchGi8995kvLZBadbaphRo-3A@mail.gmail.com>
 <20180727171941.GA109508@google.com> <CAGZ79kZfhSwtNgNk-GRDb6f4Uq7y6fi21HVO7xHv1YiuQoaSvA@mail.gmail.com>
In-Reply-To: <CAGZ79kZfhSwtNgNk-GRDb6f4Uq7y6fi21HVO7xHv1YiuQoaSvA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 27 Jul 2018 20:04:56 +0200
Message-ID: <CACsJy8Cx7u5YtK6sPJ=HbAOUBXCrP7VOgMyoQ58SB6q_s4N7Gg@mail.gmail.com>
Subject: Re: [PATCH 2/3] refs: introduce new API, wrap old API shallowly
 around new API
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 27, 2018 at 7:31 PM Stefan Beller <sbeller@google.com> wrote:
>
> On Fri, Jul 27, 2018 at 10:19 AM Brandon Williams <bmwill@google.com> wrote:
> >
> > On 07/27, Duy Nguyen wrote:
> > > On Fri, Jul 27, 2018 at 2:40 AM Stefan Beller <sbeller@google.com> wrote:
> > > >
> > > > Currently the refs API takes a 'ref_store' as an argument to specify
> > > > which ref store to iterate over; however it is more useful to specify
> > > > the repository instead (or later a specific worktree of a repository).
> > >
> > > There is no 'later'. worktrees.c already passes a worktree specific
> > > ref store. If you make this move you have to also design a way to give
> > > a specific ref store now.
> > >
> > > Frankly I still dislike the decision to pass repo everywhere,
> > > especially when refs code already has a nice ref-store abstraction.
> > > Some people frown upon back pointers. But I think adding a back
> > > pointer in ref-store, pointing back to the repository is the right
> > > move.
> >
> > I don't quite understand why the refs code would need a whole repository
> > and not just the ref-store it self.  I thought the refs code was self
> > contained enough that all its state was based on the passed in
> > ref-store.  If its not, then we've done a terrible job at avoiding
> > layering violations (well actually we're really really bad at this in
> > general, and I *think* we're trying to make this better though the
> > object store/index refactoring).
> >
> > If anything I would expect that the actual ref-store code would remain
> > untouched by any refactoring and that instead the higher-level API that
> > hasn't already been converted to explicitly use a ref-store (and instead
> > just calls the underlying impl with get_main_ref_store()).  Am I missing
> > something here?
>
> Then I think we might want to go with the original in Stolees proposal
> https://github.com/gitgitgadget/git/pull/11/commits/300db80140dacc927db0d46c804ca0ef4dcc1be1
> but there the call to for_each_replace_ref just looks ugly, as it takes the
> repository as both the repository where to obtain the ref store from
> as well as the back pointer.
>
> I anticipate that we need to have a lot of back pointers to the repository
> in question, hence I think we should have the repository pointer promoted
> to not just a back pointer.

I will probably need more time to study that commit and maybe the mail
archive for the history of this series. But if I remember correctly
some of these for_each_ api is quite a pain (perhaps it's the for_each
version of reflog?) and it's probably better to redesign it (again
talking without real understanding of the problem).
-- 
Duy
