Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A4BE1F42D
	for <e@80x24.org>; Thu, 31 May 2018 12:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754803AbeEaMTU (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 08:19:20 -0400
Received: from mout.gmx.net ([212.227.15.18]:37063 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754801AbeEaMTT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 08:19:19 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LcSAg-1g4XqZ2mb0-00jqFN; Thu, 31
 May 2018 14:19:05 +0200
Date:   Thu, 31 May 2018 14:19:04 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     Stefan Beller <sbeller@google.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 01/18] Add a function to solve least-cost assignment
 problems
In-Reply-To: <20180530232837.GD671367@genre.crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.1805311414440.82@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <cover.1525448066.git.johannes.schindelin@gmx.de> <3f51970cbc44bfe34133c48c0844ed3723e83808.1525448066.git.johannes.schindelin@gmx.de> <20180530135505.9569-1-szeder.dev@gmail.com>
 <CAGZ79kZ77qBuSDGBJa5b1AvKLBSOOnTad_UXm9EP0aJSrmEohw@mail.gmail.com> <20180530232837.GD671367@genre.crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:s1MObJwuGXPMa2CH7oUJfkbNnCtL1iCNeRnTNX81YP74+4IPXzk
 Fvy5M4vx7/Bn73iTpgvzFf5y5mN4rfWnerf9WoEl3VjrvT6DVB9MHYMxtHwJAWkcuDteiM0
 /iy5e9xhHHUGRSGKrsoYTrU99M7MVdiim/NigvOVaPRlih4cn+h7Q9vyZ0WazCdvBJtuo5q
 WPsifYL0lzIJxY45dcLrA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:w1ypMkU8M5s=:nD5cOaudf0O7fYb9HTmZxI
 X7gfv76RIpQofFeF0KwsMewDR+NGcEIXd21qHDRydyYCgYvg8kCiimchPRK4c2rl8s+Sa3n1A
 MkAYbycdEgOwLJ5KyDjFa1DPhet47EyyMV3Z8K+gOa/xf3rSH+yi/mdzRPu5koBCrTiQIknOn
 TKVAmOgc8UXTDnyS0P1zOeJZ1aASllctkMbuGoqLd564UyPPwl/Ndzis1F3plk2ika1wI+tAf
 /NQJL5TrnJmpN0FjUqrOnIDzBDyOij3XBV0Flby6bHcXKrOCmveDqw4e4H2wGkwN+b4UV/gbe
 VbiKZJfkqwW1YIZyMqP/Ij26BPErbTN09I2FdiRblckmsm01LXAfnPl40seYqsXhyfsjhBExk
 YFIObaJ+i2PILka3MVqaS6eHdQjw28U9g174OL2LXuohoJxIwPsG62X3Oa2I7zwsAS0cHh+kC
 fedZTahW8Yr3hOe0TU3EYk25ziA4nXk1Clsq6sQcdwazbFFEYMdqWRpi6lWu0reV6sJtAx+NY
 mv/yxdPDZG9twUFZ5bfF8nQYkIPy3bKOORfdFEy9D8EPzJAjb4CXnICgkZYX87ZJUTusrNEaq
 FB30IbjI8VhKk//j1kXy7C3IEZfiB56R6XyXTc7AuIELApGaqzFEmJLmMn8YLZ8tza9an1Kcm
 DySSj77XUfAob2x6A8I4ifaJAY0h6vJvSiapFTBMqQ8hUDzq8HmYKgYE+5zuqzwcjavjDsQPV
 TiCDwT66szAGk5gAVI5y1VSlTOHNp02fvr6tzKr0SL+eS0g0io9okN7tcagGhEGNG59LXWsSZ
 ez8FqoE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brian,

On Wed, 30 May 2018, brian m. carlson wrote:

> On Wed, May 30, 2018 at 09:14:06AM -0700, Stefan Beller wrote:
> > Good point. I remember my initial reaction to the file names was
> > expecting some hungarian notation, which totally didn't make sense, so
> > I refrained from commenting. Searching the web for the algorithm,
> > maybe 'lapjv.c' is adequate?  (short for "Linear Assignment Problem
> > Jonker Volgenant") Matlab has a function named lapjv solving the same
> > problem, so it would fall in line with the outside world.
> > 
> > Out of interest, why is it called hungarian in the first place? (I
> > presume that comes from some background of DScho in image processing
> > or such, so the the answer will be interesting for sure:)
> 
> I think it's because tbdiff uses the hungarian Python module, which
> implements the Hungarian method, also known as the Kuhn-Munkres
> algorithm, for solving the linear assignment problem.  This is the
> Jonker-Volgenant algorithm, which solves the same problem.  It's faster,
> but less tolerant.
> 
> At least this is what I just learned after about ten minutes of
> searching.

You learned well.

The Assignment Problem (or "Linear Assignment Problem") is generally
solved by the Hungarian algorithm. I forgot why it is called that way.
Kuhn-Munkres came up with a simplification of the algorithm IIRC but it
still is O(N^4). Then Jonker-Volgenant took a very different approach that
somehow results in O(N^3). It's been *years* since I studied both
implementations, so I cannot really explain what they do, and how the
latter achieves its order-of-magnitude better performance.

And after reading these mails, I agree that the name "hungarian" might be
confusing.

I also think that "lapjv" is confusing. In general, I try to let Matlab
conventions inform on my naming as little as possible, and I find my
naming fu a lot better for it.

So in this case, how about `linear-assignment.c`?

Ciao,
Dscho
