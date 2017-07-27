Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF48920899
	for <e@80x24.org>; Thu, 27 Jul 2017 18:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751582AbdG0S5n (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jul 2017 14:57:43 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:38854 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751531AbdG0S5n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jul 2017 14:57:43 -0400
Received: by mail-pg0-f41.google.com with SMTP id k190so35950868pgk.5
        for <git@vger.kernel.org>; Thu, 27 Jul 2017 11:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=h9So+3paEw/7BRKU6NYefME2/tjZ3grLyzHblphHomU=;
        b=Q/aAcD94/dW1sMzxWlHVvsPVow7zeAtRy6bIPNJ1DiVvsr65Fd1V+otaWE7RL4NQM4
         HFgNBI2eeKittsnbluF0Is1G2i6Sm6wqTjAbT7vWT02eyWvX+tP7N9f4q6ulfyYgZkYm
         FLrhRBOD4/IFHvJaKfqI0mQWOv8cSDUQOOhnfW7tUPjTXCGrsaT5NYiHi34qaGL6z0Ry
         8uiYTC7ujR7QOwc8VbQTV42Ihr6VyuMoIbwJfpIguF3qZDnXz8H9BQlPhc7JcE8YBZjd
         dP21zCACpubxWy+03hAo0Xle3nw5dEwTvvh5dFb7TRMB5pzqjw5Gx/ZVEtzVVjx+aTdx
         qzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=h9So+3paEw/7BRKU6NYefME2/tjZ3grLyzHblphHomU=;
        b=r3pGY4oAQR8EcGPDfxebrIvS67uaDuXmPWG4t08ZSBjbPrstB2uaIgXwfQs+sgMNCX
         FnygtPnhT3Duziyr5soOTEVgOoOBhlUNs8eST7/QK2RRVRMvueXB0xSXMv5gllmWrFoN
         vy7dLOzdoL2FtLfwCwwW8TRSJDLYrClz/XACbXbei+kk62OX8om+hy5vX3iVmk6lEDET
         eU1howOynj2xrydgvvprElLYaUUiaqoK04DIgvVkayZfhS1XN8g4TnF6/X37Nq0abUE1
         BCq/2GEKOdo8X0dfo+COXpEROkJqOswKDudB62VLH4+Vah0LpC6UM13pn3hXVZJxsgpO
         BSEQ==
X-Gm-Message-State: AIVw113xjYlcEGmJPry0A/canjF7Dux9cZHof/D+dRvLKs0GU+eUw2zr
        6RjtiXdnT35V7WDKmcW6yHZStvbCWFPk
X-Received: by 10.84.130.9 with SMTP id 9mr2872130plc.388.1501181860629; Thu,
 27 Jul 2017 11:57:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.165.44 with HTTP; Thu, 27 Jul 2017 11:57:40 -0700 (PDT)
In-Reply-To: <xmqq4ltxohv5.fsf@gitster.mtv.corp.google.com>
References: <20170613023151.9688-1-sbeller@google.com> <20170726230425.24307-1-sbeller@google.com>
 <xmqqwp6uojzr.fsf@gitster.mtv.corp.google.com> <CAGZ79kZ5x8p7CE6zGQ2HOJFPV_8_XKsENKt70ETACvvYZYKp2Q@mail.gmail.com>
 <xmqq4ltxohv5.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 27 Jul 2017 11:57:40 -0700
Message-ID: <CAGZ79kY6gnRjmCxsz+yH7DDE4c--=u0UzjmkuZrf-RKpN97BFA@mail.gmail.com>
Subject: Re: [PATCHv2] builtin/blame: highlight interesting things
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 27, 2017 at 11:27 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Well, we could also try a "zebra"  as in sb/diff-color-move to show blocks
>> with the same fancy border detection.
>
> Luckily, blame output has places for metainfo on each line, unlike
> diff output, so there won't be a need for painting border
> differently.

Right.

> For example, if we decide that metainfo is shown only
> for the first line for each block, then by definition, the border
> between blocks is just before a line with metainfo and nowhere else.
> So in that sense, the problem should be a lot easier to solve ;-)

Yes, also the code already provides structured blocks,
so internally it is also easier.

The question is whether we decide that showing the first line
is a good choice. We could also put it at the approximated
middle and draw lines up and down.

In an advanced world, we would not use a dumb pager, but
e.g. ncurses, such that the line displaying meta information
may come along when you scroll down a page.

Maybe the discussion here can also feed back into the
"machine readable move coloring" that Aevar seemed to be
interested in.

>
> Unluckily, a block may span several pages, so "only at the first
> line" might not be very useful.  I wonder if we can print in black
> ink on black background and let selection by mouse or in screen
> still reveal useful information?

This is what the dark color approximates, except you don't
need a mouse selection to read?
