Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B522F1F404
	for <e@80x24.org>; Wed, 15 Aug 2018 19:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbeHOWlp (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 18:41:45 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:34805 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727571AbeHOWlp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 18:41:45 -0400
Received: by mail-yw1-f66.google.com with SMTP id j68-v6so1726938ywg.1
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 12:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=i1HG6nwouShLVJ508M6O4Z8GHPkI1FaCRk3vEqdhc8w=;
        b=GCjbXe3m3AMtEsRrw79VOay/pmTuvDleexgiYMZQVLzpuesCiyXIecxwD+Q3/MUhDi
         6sC7PEWVRKr3/NBxvLC05sXBN0bNXqU6H8VYYArTzpzwIQwsw2ZawZmGc6RL0s6rFss8
         VvvPXeOsMdS0s+ylQvOqKF0mx5OGcjU0p9QjkoYaXVnlMbroCmlkRBQe/TKWwP4XnG9f
         GNPJH4f7OE+Hhm8ZxPjcWClH4sGxxTTjTg4Ws+b4OQi13tKsKI2ioYrYfv44z4985wG5
         bVdzglIUK5DX8aqVJokjZv/amho/n///jHzhJ12r5Vb9ngxWb3aBBrTirTvDFWbTf+4R
         DFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=i1HG6nwouShLVJ508M6O4Z8GHPkI1FaCRk3vEqdhc8w=;
        b=Xu996d1UQibPlsVfXkcgpj6K8B/K9FZSvUQJYEqKnI1QvV4AJPnkiORAFpbOUR7Am/
         gPNRwG1+2LiV9RPYXFxR3nPWBAzcnOMjT70wwWp4S9MfIQHWLgpodTfzDBrYyMGMVr4C
         ubIg7OzkD0M1noDF77kUVCrDRAMokNm0EDtQCOkjuDcymcqYeq7dF63sGgETbE7lUcvY
         xYVS3tqeFhnk1gMQ47rm5L42sIUUpEV7qteFI9VuwnCiLXZnFdqAB0rKeEhp8KDwtacA
         pf4M0Xv2rdGFjW/FhhUQwFAZc11bbNGutWLlYA5JEWl5QQRmD3ngn27Wmms2sMiCzeg0
         LSKQ==
X-Gm-Message-State: AOUpUlESv/WtWmqCXRemNi2hVdns5TIxOro32il3z2Ng/oLph2TTVk14
        NkB0M74EFkUK0IS50HGYvV7oaxZY42YIJiWDQLl8rQ==
X-Google-Smtp-Source: AA+uWPxupVP2eHJQIS85HcMpvlkgbslq1eC/RUTF8VAA3o8FEDRLN2gUq2Ew/1aS4ZBUjcEzRFEs63ec1xKPKc9H2/w=
X-Received: by 2002:a25:3c45:: with SMTP id j66-v6mr4403699yba.247.1534362491317;
 Wed, 15 Aug 2018 12:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180813161441.16824-1-pclouds@gmail.com> <20180813172857.GD240194@google.com>
 <xmqqzhxq2c4v.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqzhxq2c4v.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 15 Aug 2018 12:48:00 -0700
Message-ID: <CAGZ79kYm17PFwd+j+sY_oZHNNrdL335rKgBDBvDiq+qPGXvgEw@mail.gmail.com>
Subject: Re: [PATCH 00/24] Kill the_index part3
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Duy Nguyen <pclouds@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 13, 2018 at 2:24 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Brandon Williams <bmwill@google.com> writes:
>
> > On 08/13, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> >> This is the third part of killing the_index (at least outside
> >> builtin/). Part 1 [1] is dropped. Part 2 is nd/no-extern on 'pu'. This
> >> part is built on top of nd/no-extern.
> >>
> >> This series would actually break 'pu' because builtin/stash.c uses
> >> three functions that are updated here. So we would need something like
> >> the following patch to make it build again.
> >>
> >> I don't know if that adds too much work on Junio. If it does, I guess
> >> I'll hold this off for a while until builtin/stash.c gets merged
> >> because reordering these patches, pushing the patches that break
> >> stash.c away, really takes a lot of work.
> >>
> >> [1] https://public-inbox.org/git/20180616054157.32433-1-pclouds@gmail.=
com/
> >
> > I went through and found this to be a pleasant read and hopefully other=
s
> > agree with the approach this series took vs what your part 1 did so tha=
t
> > we can get this change in.
>
> Yeah, I've only finished my first pass (read: I didn't go through
> the patches with fine toothed comb, nor thought about interactions
> with other topics), but this round was quite a pleasnt read so far.
>

I went through this topic with a finer comb and just found nits,
none of which I would deem a complete show stopper.
