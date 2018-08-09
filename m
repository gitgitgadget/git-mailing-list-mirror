Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99C971F405
	for <e@80x24.org>; Thu,  9 Aug 2018 23:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbeHJBdG (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 21:33:06 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:46500 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbeHJBdG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 21:33:06 -0400
Received: by mail-ua1-f68.google.com with SMTP id u11-v6so160737uan.13
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 16:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=px+ZKfTtQgVd40wjcOVyoKC+98KcL2k+9xxLhMK/B+Q=;
        b=n2NrB30xhEhKDP0YfoNcsLmFiT4o9G2I8vRcuaEwtV5PiDAOqPwWbROGx0qFTetIeT
         tR95YG6pM9x3WQJLqy8N5I91VMyvw4SrQ50t+qRh6Kp9eAaMhoNucuZNgBI0dobNMpf+
         ZbfQl1Y3mtM8Y1k9VixYS11bMgB4lekuXV3EPCCMYTyVQWsztRsj7yxpkKvcMQwON+Ub
         TgcG/8LqTgDEFYYDX4DA9hAbUssLo07RlLXA9uKVxZTcvJpfWsvjzefxXtivDwTFMv8R
         nwokXRiYXxUzXyyrhHsutD1BpnQP7peS9ubaLMrUap9O/ZUyk19zjaId6F6/vJTRumBC
         Ce/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=px+ZKfTtQgVd40wjcOVyoKC+98KcL2k+9xxLhMK/B+Q=;
        b=ppUFi7GvxdIt6Q5pTgZ5uJYlRZ+usdHAetAllTbYQVOIxcXAU5MI418C89w3HGfcrH
         CQlo5EVCET71LEzEBIdFIq4c5AzRsRQys92DkMwa/EQivt/5+fnk6+L+CMQWKbAlui5B
         7aS4+YEsLD1t4ILjjQ1kXePLtxNcuFpT3HRalf6+Mft2HUPoucSM0ux1o2wJOquUHC6l
         jpBjCraCwtJTw+Z5YBgnlVggqh/C0JOy5YKAjre1+CLck1D9lTbHWUDj+udSQhI6eDD6
         4hyDZY8j5jGpFqXcEGq3elQmnGz8a+7HeXDPcZhgfjJlq00wJxHp9CZoBWBiGtdmj53m
         8XqQ==
X-Gm-Message-State: AOUpUlFMDoGCSBlQq4yE7LlGZewHxUbKvfdREHlbRw5JQuVMu4L0U0BA
        DWbiCicVCTgQ0+3FNKwBPBIqPQliWBM0QfNs7lM=
X-Google-Smtp-Source: AA+uWPyGFZQ7xLXylxyBO+dOde6qemp5GY2vlNHdV3t+kERl3XU/qoCERG9uOFkpzb4YTYBLqdJcO4qg6/auZeoW09w=
X-Received: by 2002:ab0:4c24:: with SMTP id l36-v6mr2782998uaf.199.1533855961672;
 Thu, 09 Aug 2018 16:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180807190110.16216-1-pclouds@gmail.com> <xmqq7el2km82.fsf@gitster-ct.c.googlers.com>
 <fc56d572-e333-2e05-2130-71b53e251a13@jeffhostetler.com> <20180808223139.GA3902@sigill.intra.peff.net>
 <xmqqbmace5i1.fsf@gitster-ct.c.googlers.com> <20180809142333.GB1439@sigill.intra.peff.net>
 <34b22185-a0bc-f712-b5e5-fc5e2697dcc2@jeffhostetler.com> <CABPp-BHiB_gR-dQbpJtSBYPJ5Om4Mv0ymnZFNocyTfbUotyBgw@mail.gmail.com>
 <20180809214430.GE11342@sigill.intra.peff.net> <CABPp-BEAybfJ8sojRwDbDjhcwk4VyQ26F1LnKyNLsg1fYS1fNA@mail.gmail.com>
 <20180809215913.GB12441@sigill.intra.peff.net>
In-Reply-To: <20180809215913.GB12441@sigill.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 9 Aug 2018 16:05:49 -0700
Message-ID: <CABPp-BE+QRpxq1-r_ORhLi3KqaX3EjfpzswzmyP2BUV7uYPiuQ@mail.gmail.com>
Subject: Re: [PATCH v2] clone: report duplicate entries on case-insensitive filesystems
To:     Jeff King <peff@peff.net>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        pawelparuzel95@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 9, 2018 at 2:59 PM Jeff King <peff@peff.net> wrote:
> On Thu, Aug 09, 2018 at 02:53:42PM -0700, Elijah Newren wrote:
>
> > On Thu, Aug 9, 2018 at 2:44 PM Jeff King <peff@peff.net> wrote:
> > > > The error message isn't quite as good, but does the user really need
> > > > all the names of the file?  If so, we gave them enough information to
> > > > figure it out, and this is a really unusual case anyway, right?
> > > > Besides, now we're back to linear performance....
> > >
> > > Well, it's still quadratic when they run O(n) iterations of "git
> > > ls-files -s | grep $colliding_oid". You've just pushed the second linear
> > > search onto the user. ;)
> >
> > Wouldn't that be their own fault for not running
> >   git ls-files -s | grep -e $colliding_oid_1 ... -e $colliding_oid_n | sort -k 2
> > ?   ;-)
>
> Man, this thread is the gift that keeps on giving. :)
>
> That's still quadratic, isn't it? You've just hidden the second
> dimension in the single grep call.

It may depend on the implementation within grep.  If I had remembered
to pass -F, and if wikipedia's claims[1] about the Aho-Corasick
algotihrm being the basis of the original Unix command fgrep, and it's
claims that this algorithm is "linear in the length of the strings
plus the length of the searched text plus the number of output
matches", and I didn't just misunderstand something there, then it
looks like it could be linear.

[1] https://en.wikipedia.org/wiki/Aho%E2%80%93Corasick_algorithm

Of course, the grep implementation could also do something stupid and
provide dramatically worse behavior than running the command N times
specifying one pattern each time.[2]

[2] http://savannah.gnu.org/bugs/?16305

> Now since these are all going to be constant strings, in theory an
> intelligent grep could stick them all in a search trie, and match each
> line with complexity k, the length of the matched strings. And since
> k=40, that's technically still linear overall.

Looks like Aho-Corasick uses "a finite-state machine that resembles a
trie", so definitely along those lines.
