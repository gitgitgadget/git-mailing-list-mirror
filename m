Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A92C433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 22:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355336AbiCXWXh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 18:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355296AbiCXWXg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 18:23:36 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3DFA76E1
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 15:22:03 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id d5so10435084lfj.9
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 15:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2HIS0kwboCt4c4hsMnnqqIjVMkt5p8vWNTH4020oGek=;
        b=ME6vD3GI4U81qvHH0nYnXuO6eTOfl9WItYXvyL3CKuv5bCen55myjwo2K8NG0OFQBu
         TcFjvAnuyqmo39R4tJcMhhQF/hXTVRIukozkdn4zhY03ye3fZaymK4HOT8PjZwbKkIn7
         Vb85XCIV58K4yR4FtCIawmcEGBPY6ZFYZJEQZZIbM4fUV9nEdZqCIXXIaj7qjtR6p+Cu
         otL0Eg6nbZuDhFdvR1o+tvpOIwKE+KHt7gAz/Dg3q3CulwNg38/7H5HUO5U0L+LMuRfV
         M+JhpvMuVnwyFOYmfdDBMINfo+IJB79CCOoBjLSZH7LTVzc8shJxdlG4KbHuDuUC7T/Z
         YmTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2HIS0kwboCt4c4hsMnnqqIjVMkt5p8vWNTH4020oGek=;
        b=EiOXwlyTE1LmxMsLqq3k/YzltcAxCtuf+aGYvMy1RdGfor9g8vUUmMsSeW4NcLeOHY
         v/omCSmhuac6qy0xLhCSVLvH8M3O74SyB5WrbTPGaakZdA3EPY7Csdavs27bHMAeMmr4
         wG9bUCG/P39S3IBtICPiNcL3/NJhwN4QswyOaJNPLkEuyLs1Ac6YdUpbwqsJNTxNZ0C7
         E4SimjqDvQiEWI3c/buCPhcu1X9u3EaeOKYGrhjlWPDGDY5bXq82EN5Jxe3uKEmnNAHz
         VbPkqJgus+cI67LsNsSIoA0ty2YlKMO7/5s8q3koapqlxyYUJ8Jpi5B9JZtXk9S4APiJ
         3CFg==
X-Gm-Message-State: AOAM533GoHFku6sgKkeq3NQxsiq2BFWl3e+g41yXSe/Y29AwVhE8NWzT
        IgYkFgwgV7cYpjt/mAMU0Y3GtdQvDUIpoZxR+sY=
X-Google-Smtp-Source: ABdhPJyNUZqXafGdsPmdWp0bLg6jrDWdxy7UZsgZRwirEWipHY2bTPqfM9y32tGxMcZLFLuLC1Y0DLRqBNDH8ujREbI=
X-Received: by 2002:a05:6512:322f:b0:44a:57a0:6950 with SMTP id
 f15-20020a056512322f00b0044a57a06950mr5365571lfe.74.1648160521820; Thu, 24
 Mar 2022 15:22:01 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com>
 <pull.1134.v3.git.1648097906.gitgitgadget@gmail.com> <913ce1b3df9cf273f1572c256dffad1cacc192a6.1648097906.git.gitgitgadget@gmail.com>
 <xmqqfsn7i594.fsf@gitster.g> <CANQDOdcuBRvWx7iMYBvLYEEb6A_=SURLAGumk026ZyDODpfAsQ@mail.gmail.com>
 <xmqq8rszf31t.fsf@gitster.g>
In-Reply-To: <xmqq8rszf31t.fsf@gitster.g>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Thu, 24 Mar 2022 15:21:50 -0700
Message-ID: <CANQDOdeywLXa1UHFq7G51de1+6hDG2r7OWMvQ9tsJAZtajMdZg@mail.gmail.com>
Subject: Re: [PATCH v3 05/11] update-index: use the bulk-checkin infrastructure
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 24, 2022 at 2:34 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Neeraj Singh <nksingh85@gmail.com> writes:
>
> >> IOW, I am not sure end_if_active() should exist in the first place.
> >> Shouldn't end_transaction() do that instead?
> >>
> >
> > Today there's an "assert(bulk_checkin_plugged)" in
> > end_odb_transaction. In principle we could just drop the assert and
> > allow a transaction to be ended multiple times.  But maybe in the long
> > run for composability we'd like to have nested callers to begin/end
> > transaction (e.g. we could have a nested transaction around writing
> > the cache tree to the ODB to minimize fsyncs there).
>
> I am not convinced that "transaction" is a good mental model for
> this mechanism to begin with, in the sense that the sense that it is
> not a bug or failure of the implementation if two or more operations
> in the same <begin,end> bracket did not happen (or not happen)
> atomically, or if 'begin' and 'end' were not properly nested.  With
> the design getting more complex with things like tentative object
> store that needs to be explicitly migrated after the outermost level
> of end-transaction, we may end up _requiring_ that sufficient number
> of 'end' must come once we issued 'begin', which I am not sure is
> necessarily a good thing.

I don't love the tentative object store that keeps things invisble,
but that was the safest way to maintain the invariant that no
loose-object name appears in the ODB without durable contents.  I
think we want the "durability/ordering boundary" part of database
transactions without necessarily needing full abort/commit semantics.
As you say, we don't need full atomicity, but we do need ordering to
ensure that blobs are durable before trees pointing them, and so on up
the merkle chain.  The begin/end pairs help us defer the syncs
required for ordering to the end rather than pessimistically assuming
that every object write is the end.

> In any case, we aspire/envision to have a nested plug/unplug, I
> think it is a good thing.  A helper for one subsystem may have its
> large batch of operations inside plug/unplug pair, another help may
> do the same, and the caller of these two helpers may want to say
>
>         plug
>                 call helper A
>                         A does plug
>                         A does many things
>                         A does unplug
>                 call helper B
>                         B does plug
>                         B does many things
>                         B does unplug
>         unplug
>
> to "cancel" the unplug helper A and B has.
>
> > In that world,
> > having a subsystem not maintain a balanced pairing could be a problem.
>
> And in such a world, you never want to have end-if-active to
> implement what you are doing here, as you may end up being not
> properly nested:
>
>         begin
>                 begin
>                         do many things
>                         if some condtion
>                                 end_if_active
>                         do more things
>                 end
>         end
>
> > An alternative API here could be to have an "flush_odb_transaction"
> > call to make the objects visible at this point.
>
> Yes, what you want is a forced-flush instead, I think.
>
> So I suspect you'd want these three primitives, perhaps?
>
>  * begin increments the nesting level
>    - if outermost, you may have to do real "setup" things
>    - otherwise, you may not have anything other than just counting
>      the nesting level
>
>  * flush implements unplug, fsync, etc. and does so immediately,
>    even when plugged.
>
>  * end decrements the nesting level
>    - if outermost, you'd do "flush".
>    - otherwise, you may only count the nesting level and do nothing else,
>      but doing "flush" when you realize that you've queued too many
>      is not a bug or a crime.
>

Yes, I'll move in this direction. Thanks for the feedback.
