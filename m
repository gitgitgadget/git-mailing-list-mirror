Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AA651F404
	for <e@80x24.org>; Fri, 24 Aug 2018 02:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbeHXGV2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 02:21:28 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44532 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbeHXGV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 02:21:28 -0400
Received: by mail-ed1-f66.google.com with SMTP id s10-v6so4852088edb.11
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 19:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jPkS0ZJAli2jNSYtMwYSyYplAKRRr2GY5KFBRVb+d+0=;
        b=DWfkeKk7HNjYb5fYsLG0RcDJ+q6KXTc05vzlchCL+WDXy1Xg/gcugfDaGoHpuErXq9
         gZld/ZZhStKWHeHK61lmu5ARjRg4SJoTZZT0ijE7juUBCg5I24bkv2ODzcf9Vr0hpFMb
         HWohVxfhEW9F0hpAnkItXOhydxoYfV0odAZwM8Dv8u4vNrkFpAO8z1byG81G27K9TUfh
         ylmmpcxDXhbTsdWU1LVlJrnReuGr6dn6hThwtIU1OqqSrfUjdphp7CNrxYO7N1XNjSxK
         rM9V7LfTT2mh893NcA33R41aFyiaQ3B4wRDm0sI0PTxWGlx6sYluhyLOEWcZwX+v/6/b
         z2qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jPkS0ZJAli2jNSYtMwYSyYplAKRRr2GY5KFBRVb+d+0=;
        b=kaBwkJm9cSWb8z5cV15fKXISvQsEja8tXQhqtniiRaQJ5IGezzqenENF9R3wJiw0IW
         hkbhf37oJYd2AiAdMqTu2gVqfwcySKPo4u6a04+2y722axHn5SBW3XeHU0dASTyntCSz
         0JBudPyzMCP/BpeMWvqscuZH4jlOfkNLhUaxoemJWgWZYcrYIUa30SQ+Mf06wnFhth/z
         TJB6TeSEYw24lqp2eBLgDnmGJqJ4tY0bVKIeJEfZNU1ImXtwcfEBM0JVNJfNtr8ofnL+
         egoa96MkAFOnPEqv6OZO8xpnF30CiuGeZiEww6VtTki22JkkCEAA2QipW0dmOaJcnRn7
         p0/A==
X-Gm-Message-State: APzg51BtfXkRkPzEio+u0CSalVKB//wdukvgiv1rJiXC4MC/btzMY8u2
        6j8SGu+o9RQPYewHoWS9jmDRAsJpy0RnE/SZyvg=
X-Google-Smtp-Source: ANB0VdaC+jyQXiIB9PWnvVXn7PQZBLkh3Ll5OfahETOhiZb0u+v5KtGq1S06TarX0WFWvBZSZ88pV53gs0pwPRdDW/8=
X-Received: by 2002:a50:8b65:: with SMTP id l92-v6mr207067edl.44.1535078934078;
 Thu, 23 Aug 2018 19:48:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180822152306.GC32630@sigill.intra.peff.net> <20180823012343.GB92374@aiede.svl.corp.google.com>
 <20180823021618.GA12052@sigill.intra.peff.net> <20180823034707.GD535143@genre.crustytoothpaste.net>
 <20180823050418.GB318@sigill.intra.peff.net> <f854aba0-6d28-7f2b-aad2-858983c4af36@gmail.com>
 <20180823161451.GB29579@sigill.intra.peff.net> <CA+P7+xqbt_BVi9+1-4=ha64LW_07dJB84F0gjKd9TRE1R-Ld7A@mail.gmail.com>
 <20180823234049.GA3855@sigill.intra.peff.net> <20180824000637.GA10847@sigill.intra.peff.net>
 <20180824001643.GA14259@sigill.intra.peff.net>
In-Reply-To: <20180824001643.GA14259@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 23 Aug 2018 19:48:42 -0700
Message-ID: <CA+P7+xpm-gsjCpPOZ=2z03Peb1Jb6axKo2nTp=UUpAFgWNureg@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Paul Smith <paul@mad-scientist.net>,
        Git mailing list <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 23, 2018 at 5:16 PM Jeff King <peff@peff.net> wrote:
>
> On Thu, Aug 23, 2018 at 08:06:37PM -0400, Jeff King wrote:
>
> > This almost works:
> >
> >   @@
> >   expression a, b;
> >   statement s;
> >   @@
> >   - if (oidcmp(a, b)) s
> >   + if (!oideq(a, b)) s
> >
> > [...]
>
> > So I really do want some way of saying "all of the block, no matter what
> > it is". Or of leaving it out as context.
>
> Aha. The magic invocation is:
>
>   @@
>   expression a, b;
>   statement s;
>   @@
>   - if (oidcmp(a, b))
>   + if (!oideq(a, b))
>       s
>
> I would have expected that you could replace "s" with "...", but that
> does not seem to work.
>
> -Peff

Odd...

What about..

- if (oidcmp(a,b))
+ if(!oideq(a,b))
  { ... }

Or maybe you need to use something like

  <...
- if (oidcmp(a,b))
+ if (!oideq(a,b))
  ...>

Hmm. Yea, semantic patches are a bit confusing overall sometimes.

But it looks like you got something which works?

Thanks,
Jake
