Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B4461F954
	for <e@80x24.org>; Fri, 17 Aug 2018 14:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbeHQRoB (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 13:44:01 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:53995 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbeHQRoB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 13:44:01 -0400
Received: by mail-it0-f46.google.com with SMTP id 72-v6so11551794itw.3
        for <git@vger.kernel.org>; Fri, 17 Aug 2018 07:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VJBXG+G3lffkZsNVgwnNR0i7MQUcdyCXDjNk4VTbIkA=;
        b=OAQpL+95aVP6qqINrCwQy97xPp4ZT4/l9cF1v4u56/GZs67p8VXPeGmA1GNyRqrVLW
         wXES8llbq0N0QUlpeED2LD9aiGanUST4oNcsrYFrz/D9ZNJil1xLnj7vp5fZ/ISW6Uha
         bzDzH52OHku7n3vjPhyV1sZMYdkYv4ZGyBzHIgRA5AOTsC+txmaOiYbwOjNAI94ryqRx
         /2AG4HnMtDVE3NewUhHtP7Ng/5WTsj3lV5qCDOkbkCeaMQmWcaYjqplAN6qXkLaPd5Cc
         m21ArF8x14wMMPyawG2hmJB3WLtWsTz9cAY7OVCULEsqXPkWzU0z0Mnvr+tJ6iKvpTrx
         FIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VJBXG+G3lffkZsNVgwnNR0i7MQUcdyCXDjNk4VTbIkA=;
        b=GyBRdWnQZmlvrTW+d/kWKPFf7pldM3HySj+pU8PBNNT271nE+2EbJQec09qNYMXpNj
         jz6I9+1hvUR8oaLNNMWmlU5t6C5vEXNlKF16p2kX4XcNaWOH+4LM/VeKoqL52T03yX6c
         orgrVx80Qm27iob/6hAXxexrQwAQnzL0siSMFuGzSxt/Zgha1DoiLdN61xN4PiTpRGSZ
         NID0IV0M0HdT2wUpx3Gkj8d3eFo10HPRwO2yA653dZQ55jy7HE4M9oinQuAr60x2iHsu
         aihcw9f4TE5OPbBukdR58JPzE4rVy5Dd+kv6N5YwBaZvIwx3zJGrlxrqtcreXCyl0XyE
         KYcg==
X-Gm-Message-State: AOUpUlEVf2H4nFdDF4MHOhrL5DUnMVI2vJ4+pQK6auD79VUaI4bKyMpd
        x6NvV7lSU7nUmr8JgEmJE+sX0Vuo4J98A9rmVK4=
X-Google-Smtp-Source: AA+uWPzuGPVTI06EclPPWSNmLvGhOPb7TqaiCgbMekIB+yeG2W6ftQ3uHTnEW7O/jIBwo3llKDCPFHUCq37l8uA5bXI=
X-Received: by 2002:a02:c50b:: with SMTP id s11-v6mr31468415jam.61.1534516823536;
 Fri, 17 Aug 2018 07:40:23 -0700 (PDT)
MIME-Version: 1.0
References: <5B751FA1020000A10002CD2F@gwsmtp1.uni-regensburg.de>
 <20180816155714.GA22739@sigill.intra.peff.net> <87bma2qcba.fsf@evledraar.gmail.com>
 <20180816205556.GA8257@sigill.intra.peff.net> <20180816210657.GA9291@sigill.intra.peff.net>
In-Reply-To: <20180816210657.GA9291@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 17 Aug 2018 16:39:56 +0200
Message-ID: <CACsJy8Aycxf3S9zARuv_BeKLyh667ewcB1dr3X9VY3i3meR9hg@mail.gmail.com>
Subject: Re: non-smooth progress indication for git fsck and git gc
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ulrich.Windl@rz.uni-regensburg.de,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 16, 2018 at 11:08 PM Jeff King <peff@peff.net> wrote:
>
> On Thu, Aug 16, 2018 at 04:55:56PM -0400, Jeff King wrote:
>
> > >  * We spend the majority of the ~30s on this:
> > >    https://github.com/git/git/blob/63749b2dea5d1501ff85bab7b8a7f64911d21dea/pack-check.c#L70-L79
> >
> > This is hashing the actual packfile. This is potentially quite long,
> > especially if you have a ton of big objects.
> >
> > I wonder if we need to do this as a separate step anyway, though. Our
> > verification is based on index-pack these days, which means it's going
> > to walk over the whole content as part of the "Indexing objects" step to
> > expand base objects and mark deltas for later. Could we feed this hash
> > as part of that walk over the data? It's not going to save us 30s, but
> > it's likely to be more efficient. And it would fold the effort naturally
> > into the existing progress meter.
>
> Actually, I take it back. That's the nice, modern way we do it in
> git-verify-pack. But git-fsck uses the ancient "just walk over all of
> the idx entries method". It at least sorts in pack order, which is good,
> but:
>
>   - it's not multi-threaded, like index-pack/verify-pack
>
>   - the index-pack way is actually more efficient than pack-ordering for
>     the delta-base cache, because it actually walks the delta-graph in
>     the optimal order
>

I actually tried to make git-fsck use index-pack --verify at one
point. The only thing that stopped it from working was index-pack
automatically wrote the newer index version if I remember correctly,
and that would fail the final hash check. fsck performance was not a
big deal so I dropped it. Just saying it should be possible, if
someone's interested in that direction.
-- 
Duy
