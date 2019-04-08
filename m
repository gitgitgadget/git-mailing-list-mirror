Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B716D20248
	for <e@80x24.org>; Mon,  8 Apr 2019 09:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbfDHJ4a (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 05:56:30 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45412 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfDHJ4a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 05:56:30 -0400
Received: by mail-ed1-f67.google.com with SMTP id f19so4055562edw.12
        for <git@vger.kernel.org>; Mon, 08 Apr 2019 02:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H53HbC/FZZ+qkafKjsoTPg8kShCgkNjOZO8zVFpfHv0=;
        b=fGwzb4TwOQwjSv/1kH9Mo9bpCg1SsJI6PzTW5+ommbmMq2DOJGSGpKML4SzlaVzF1g
         HcyZGu6ZcioTh7BPXGwxlPJPDczyYX5e5yT0fkypR9LpfCAM+4JzjzeZbXLfZWfLRIXM
         +zo4BI9XRYx544V0iUbz/pz9VeNSleFTfXVtxcSfIT5x2YGgwg6rEbAKSzTnvJpa42Lc
         ZKcQddxCxF/VG8rW5p/moZnClD5L72WfJaojbcc9cQ2BRSkhby+kKH5zofM/svD1meIv
         R3gYmhopEx9X0QCEGPQlQLMOgPJezj/FNbCaTCzAeHByTkuDqTCPXlPT2AH/DkCWmGoK
         ELUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H53HbC/FZZ+qkafKjsoTPg8kShCgkNjOZO8zVFpfHv0=;
        b=JiVSWOrKib10x4ZRkZbYkCcj3XlfYMaEDiFIg0mYTA4XVLfr+7agMk2ZocfZ9I1sKJ
         Dmj8ecS2RvV8nNHU0dB0yt6166KFPktRxph6h50CFy9BDcd0ZI+BS7VgKoE/bvAxAxFt
         BCjJEN6RFkmCn+I6PCFaPu8rZi/dO7ghP0WpdnT+bMaXTGTDnLYbBB4dlCltTNgNh6nA
         So8Z+IU65UBAI+VQOz4szf6iLp72YzfD7DBAkr+0s2sFlEFqQAy10ThfAhOaA3aHNsAv
         wY+Rg3rlMRCry61DRFSoU7CJ9DglQyioi3Cr2z77d/mFg/Vk6Ja/utPZB8v+BFRlYanZ
         gjFw==
X-Gm-Message-State: APjAAAUxaol928TZg7MYnq+rnZ5oy6x1HvXV6hdUn9CEygYpYJPSss62
        MW/2195MJtO3jDBp52sNL9bPWKN9pqhOCsqLnKM=
X-Google-Smtp-Source: APXvYqw39s+Yzt81/1S2dJ3kvjOcJ1CrtCj/asNziCikyvr9NP2xMMtqWO7ZUu8cxIEEUlX72sc4dOX7aWWBlBVMpWE=
X-Received: by 2002:a17:906:d503:: with SMTP id ge3mr16077395ejb.2.1554717388505;
 Mon, 08 Apr 2019 02:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190326220906.111879-1-jonathantanmy@google.com>
 <cover.1553895166.git.jonathantanmy@google.com> <44de02e584f449481e6fb00cf35d74adf0192e9d.1553895166.git.jonathantanmy@google.com>
 <20190404024710.GO32732@szeder.dev> <nycvar.QRO.7.76.6.1904051528130.41@tvgsbejvaqbjf.bet>
 <CAP8UFD1qK61MtJ-XeMuwY4W2V0CdHeZQC9rQap1M+nEeaLmBJQ@mail.gmail.com>
 <xmqqy34lb4vb.fsf@gitster-ct.c.googlers.com> <CAP8UFD0gmaZzfK7taS=1hj=sCEpLFt_Az60TxYeUqp2A7r25JQ@mail.gmail.com>
 <xmqqbm1h7wrj.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqbm1h7wrj.fsf@gitster-ct.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 8 Apr 2019 11:56:16 +0200
Message-ID: <CAP8UFD0u8fd_s5wdsO4B=j7TE1U1=j=R7=v9-=wUy78ResoZBw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] diff: batch fetching of missing blobs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 8, 2019 at 9:59 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > I will at least add something telling that in most cases
> > "repository_format_partial_clone" and fetch_objects() shouldn't be
> > used directly anymore.
>
> Yes, that would be necessary not in the log, but in-code comments
> next to now "by-exception-only" API functions and variables.

Ok, I will add in-code comments then, or ...

> >> Likewise between fetch_objects() and promisor_remote_get_direct().
> >> Shouldn't the underlying fetch_objects be hidden from general
> >> callers?
> >
> > I will see if I can do that, though it has to be used in promisor-remote.c.
>
> Does fetch-objects.[ch] even need to exist after multi-promisor
> world as an external interface?
>
> Wouldn't it become an implementation detail of promisor-remote.[ch]
> API?

... yeah, I will try this.
