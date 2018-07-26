Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9ED05208E9
	for <e@80x24.org>; Thu, 26 Jul 2018 16:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732293AbeGZRxW (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 13:53:22 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:38758 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731851AbeGZRxV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 13:53:21 -0400
Received: by mail-io0-f193.google.com with SMTP id v26-v6so1852401iog.5
        for <git@vger.kernel.org>; Thu, 26 Jul 2018 09:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AIq/Ld2l9BsXFxFjVIHLCDf+MAP4jn+lb0b6pqnkDoU=;
        b=Eia8U5aL+xaGD+7qwbbA+KQwbCoWcn7KRVGD0Q5L5DqX+FV9fUfImw7GCnOYCm2G3y
         aBoj7KLQbUmyEYmAIt5p9F+nxoAKiCQI7qhESZgKGcTuOnzGfLZIEf6mTp4AnUphOGE0
         fM6mpFwGjDSRROVY2XRxAn58rOKq73DqqAo/4ZaIeyOvcrE6KTJYFHzf8Fmk6SCe28Wi
         oX0hMOT64BYBCCtbpAszRlbc/ij/rCHQW69jMijB1td7YiseZTjC1yJJGpR1itfPb/EK
         ZlRMlZpHioNxexip+c3R1D11kBp9M2IRD3EyvraVqKomfqP8WXR3Ppu9QM2OUE2JIY6t
         WAVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AIq/Ld2l9BsXFxFjVIHLCDf+MAP4jn+lb0b6pqnkDoU=;
        b=qmueV75/C0UMHoR2/gLsbivE6y31OqFnA1XRVRRqz6cykbjexliZta1UMhdoQC3EPn
         gVBQ3Vm7G0yWuR4fQ7MRziM8VemUdnHyvjlLj/WuY8wZnilZ65ShI8dPefAM6oEjOMon
         QOmbcvaca3BiiQYm3gtw0gsEddaonYMKJ1WOwxBFbfa1rAYT0OSme1wvcOXMKAiiWPWv
         bKYEkL03ymjuXrVVYROrW1cuY42C96GlJ44k2gxmMt3IXi3qvjDUQx3++ESlqfL/uoNT
         4o5a5La6hSRLAyev/LJPsMZpZMs5Ebh2S/9Ifl39ANpp2cqhJ3QClIK55mNRZjyr1o57
         rgdg==
X-Gm-Message-State: AOUpUlF8s0Bix3gs9p7MCt3VepAt1wb914OUJplzVJv/SHijKQpf6NRO
        HnzD0yLKpSV8oOzSX6GkxBX0+WdrDV5tcKYa/AI=
X-Google-Smtp-Source: AAOMgpc5wctDHEZS2284t5O9M9853mYvM+UVvoHrIAVOcDvGFf6G827OJYNMZigKY3mdRsGYQm8rNUKSCg9phTdDgbg=
X-Received: by 2002:a6b:825e:: with SMTP id e91-v6mr2208033iod.118.1532622945525;
 Thu, 26 Jul 2018 09:35:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180718204458.20936-1-benpeart@microsoft.com>
 <20180718213420.GA17291@sigill.intra.peff.net> <a2ad0044-f317-69f7-f2bb-488111c626fb@gmail.com>
 <CACsJy8D-3sSnoyQZKxeLK-2RmpJSGkziAp5Gf4QpUnxwnhchSQ@mail.gmail.com>
 <6ff6fbdc-d9cf-019f-317c-7fdba31105c6@gmail.com> <20180724042017.GA13248@sigill.intra.peff.net>
 <CACsJy8Du28jMyfdyhxpVxyw5+Xh+9eX==3x8YJSnmw6GAoRhTA@mail.gmail.com> <0102d204-8be7-618a-69f4-9f924c4e6731@gmail.com>
In-Reply-To: <0102d204-8be7-618a-69f4-9f924c4e6731@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 26 Jul 2018 18:35:19 +0200
Message-ID: <CACsJy8Af4K=XOcGaZxhbWOD7OYgtW7bXLved_Xv-XgVM_6AQwQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] [RFC] Speeding up checkout (and merge, rebase, etc)
To:     Ben Peart <peartben@gmail.com>
Cc:     Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 25, 2018 at 10:56 PM Ben Peart <peartben@gmail.com> wrote:
>
>
>
> On 7/24/2018 11:33 AM, Duy Nguyen wrote:
> > On Tue, Jul 24, 2018 at 6:20 AM Jeff King <peff@peff.net> wrote:
> >> At least that's my view of it. unpack_trees() has always been a
> >> terrifying beast that I've avoided looking too closely at.
> >
> > /me nods on the terrifying part.
> >
> >>> After a quick look at the code, the only place I can find that tries to use
> >>> cache_tree_matches_traversal() is in unpack_callback() and that only happens
> >>> if n == 1 and in the "git checkout" case, n == 2. Am I missing something?
> >
> > So we do not actually use cache-tree? Big optimization opportunity (if
> > we can make it!).
> >
>
> I agree!  Assuming we can figure out the technical issues around using
> the cache tree to optimize two way merges, another question I'm trying
> to answer is how we can enable this optimization without causing back
> compat issues?

If it works as I expect, then there's no compat issues at all (exactly
like the diff_index_cached optimization we already have). We simply
find a safe shortcut that does not add any side effects.
-- 
Duy
