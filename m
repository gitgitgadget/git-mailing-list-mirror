Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC8931F404
	for <e@80x24.org>; Wed,  5 Sep 2018 07:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbeIELtO (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 07:49:14 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:52131 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbeIELtN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 07:49:13 -0400
Received: by mail-it0-f41.google.com with SMTP id e14-v6so8591054itf.1
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 00:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Hm26dGh/760KJJzbIW32WrgXgQ5OPJrToYDiqGxt+Qw=;
        b=irkSzhZXznmMpLHFClgDkKRKA2Nvw2lP7UFL2U+xUA2CRtfSSD/CYbZJaL9IY5mVuc
         XALUEcNGepkPSwK22zEatjub2jyuRH6N3ruLSigTdL6mozekdZHczct+ez3m5fxG2eqd
         TjvBD2vs9fNGDk1RLGW0dsESI36+uCr7npBceBjiXiKrZEC5DIaD36zMWUGDIPNK7FUm
         8wQwjXL+kM9DK9TN8PWrTF+Lb2Ws7kw1y+CLrnuaxp4o2vTitC4E7rCqLPj19oxN/CYb
         XUlNOOzamvmIuhVL7BTF4mvoQBc4+m0pR8/LL1f/w49C1bBsHeg4yKKfoz7aXatIGAe4
         cKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Hm26dGh/760KJJzbIW32WrgXgQ5OPJrToYDiqGxt+Qw=;
        b=alWCM6qP8wHA0KF2tSYGURq0ZRzv44OXX/RK79NlcSnqmkWcsFN73hMeM6I8k7PtoF
         woyO+as871gZSb8Ps4Xp6zLogwUMp/BHhGPraEIIzPx1b53FRbM01srPRipCg0VjdHWR
         NGD8Tc7nOSpWWY9qItgvQ3+YQlBNeX+fhpUWkjhjvoGz/AJPvkEv7YiBVC520wC/a/D2
         7FH6vl5vXN50bCmxbqg8WrIcngeNgQfsxDReu74NImsZ88FK2XZr4pGOQV2Z+8bHrrKv
         gUeh5p/9eNGUigduR5YJgtZSZUXlQZxxWMDjBPSrX9/jOT9FEbFcBApL8hKyqQVe0nye
         Od3g==
X-Gm-Message-State: APzg51DvtYbpAeTryW812eoLHXqhpeYNX2If2OgOkhKhlSD8YlC3LTz7
        NO5ePgWMPs8+M4suA0YGMNIxmc8IlWyohjOSO5uSD5Ho
X-Google-Smtp-Source: ANB0Vdak003Zq+Bkp1apCeTI6JruCpkL8n1rdrodQhPeNayqrg1n4mgcx4rMGPzKO1LhLpTCQtgKRCMEWh4QIfhpixo=
X-Received: by 2002:a24:e4ca:: with SMTP id o193-v6mr2676030ith.132.1536132024074;
 Wed, 05 Sep 2018 00:20:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:22a7:0:0:0:0:0 with HTTP; Wed, 5 Sep 2018 00:20:23 -0700 (PDT)
In-Reply-To: <CAP8UFD0qk3SkBhuEiG+-qhTjXry1SH0SmoFjSNmPr6WZrLfijw@mail.gmail.com>
References: <20180828151419.GA17467@sigill.intra.peff.net> <CAP8UFD0SYECLk--7JsZkxBdQeJPuG1Ut5GMLsCJHqM+jG7C0jQ@mail.gmail.com>
 <20180901084321.GC25852@sigill.intra.peff.net> <CAP8UFD0qk3SkBhuEiG+-qhTjXry1SH0SmoFjSNmPr6WZrLfijw@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 5 Sep 2018 09:20:23 +0200
Message-ID: <CAP8UFD3DrhA9C0=k-ie_fnpKwmbezQ9ufp1RPHrZ7A-VUjhz0g@mail.gmail.com>
Subject: Re: Git in Outreachy Dec-Mar?
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 3, 2018 at 6:36 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Sat, Sep 1, 2018 at 10:43 AM, Jeff King <peff@peff.net> wrote:
>> On Fri, Aug 31, 2018 at 10:16:49AM +0200, Christian Couder wrote:
>>
>>> >   2. To get our landing page and list of projects in order (and also
>>> >      micro-projects for applicants). This can probably build on the
>>> >      previous round at:
>>> >
>>> >        https://git.github.io/Outreachy-15/
>>> >
>>> >      and on the project/microprojects lists for GSoC (which will need
>>> >      some updating and culling).
>>>
>>> Ok to take a look at that.
>>
>> Thanks. I think sooner is better for this (for you or anybody else who's
>> interested in mentoring). The application period opens on September
>> 10th, but I think the (still growing) list of projects is already being
>> looked at by potential candidates.

Do you know where is this list? On
https://www.outreachy.org/apply/project-selection/ they say
"Information about projects are unavailable until applications open".

> So here is a landing page for the next Outreachy round:
>
> https://git.github.io/Outreachy-17/
>
> about the microprojects I am not sure which page I should create or improve.

Any idea about this? Also any idea about new microprojects would be nice.
