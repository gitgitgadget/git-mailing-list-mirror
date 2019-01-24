Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C4D21F453
	for <e@80x24.org>; Thu, 24 Jan 2019 19:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfAXTO2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 14:14:28 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35206 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfAXTO2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 14:14:28 -0500
Received: by mail-ed1-f66.google.com with SMTP id x30so5516254edx.2
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 11:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/op1Qcryg11lRj+2XjLhf1zOAZl5MP6oWL56mtNofCQ=;
        b=dUlZfm8uZ/noOIQ5xo1qE7ZwwW55LGXnvCiTvLJ0ZvwnaEo8xz8Vg3FK3kfIAHF/JX
         QV7y/mH07hu7UinUNSilZZrH1jIoBvtCSJfJBZS9M4f1mw/Vx/DIGA2D6gxLRY+wlvrW
         oz7M9XwqP1IH3jewRMregx0E/tQjR4TYPp86baMzoBbqWh27EDjT6wrMhxAAkcYEg3xr
         wn19lUz/SG9uv9TDkhVAEG0SAqeMr+KaYLm4WzEanQ8ciAW8ryBezCZd10G35IitdQ3t
         JPcZz+7NGpdVtDovkRQlyUucQzf2VAoj3H40QAXn6SmgjRH60MLIkMVK5Fn9oyHQap8d
         GJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/op1Qcryg11lRj+2XjLhf1zOAZl5MP6oWL56mtNofCQ=;
        b=DemD5s75K8tjyghgZsmq9S8kwmax2ZNburCNmMI3IfL33vQ8MjrwH/zfGOJNmDu1xt
         /4v1ig+8gHjHEUZUQOQ9nRr60VQqVmvlqxy2Qg5JB8UYW3Q87TCrjMPOr4fKQWOcGv/n
         Migt6ccEzPVh5oVKCNIobQ44GA3pQPPRseGA+Ng8+G+Vexipbb1Ux4wSZS7e3EM2bM3V
         rTroxb0z2b0xLRfpOHmSM/NVeOUL8aOSk4nMso0OBDj1uXLKFUtf2jq1yOD492sMNSTr
         7wQNHqMM4+znnz2X0KHPohMAtSKa1HC3jcfRaSbaKFuyybY3koW19/YoqvfnR6wxCCwP
         XXkg==
X-Gm-Message-State: AJcUukf01JJ2oH/HbyCbkF/yI33LPLgkIPrgBpQrJnH707CsJNGe78yM
        5S50o2b5sLbiqTJ3V3Jm1V+30+aC52jPJL1lwLYIjQ==
X-Google-Smtp-Source: ALg8bN4Uoye9a1FAfF5sIOIAovEY+uOtmmD5Ufqh/M9j6vqSY9Ct3oFXUricBpuCu7k7lQQxwcvyIq3f5/OuoHtKXG4=
X-Received: by 2002:a50:ade7:: with SMTP id b36mr7535037edd.215.1548357266274;
 Thu, 24 Jan 2019 11:14:26 -0800 (PST)
MIME-Version: 1.0
References: <20190124122603.GA10415@sigill.intra.peff.net> <20190124123539.GE11354@sigill.intra.peff.net>
In-Reply-To: <20190124123539.GE11354@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 24 Jan 2019 11:14:15 -0800
Message-ID: <CAGZ79kY-xMDDgLgkWdc9CoZucd4S557NEPQdvPrd2+_LJAretA@mail.gmail.com>
Subject: Re: [PATCH 5/6] combine-diff: treat --summary like --stat
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>, David Turner <novalis@novalis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 24, 2019 at 4:35 AM Jeff King <peff@peff.net> wrote:

> Note that we have to tweak t4013's setup a bit to test this case, as the
> existing merges do not have any --summary results against their first
> parent. But since the merge at the tip of 'master' does add and remove
> files with respect to the second parent, we can just make a reversed
> doppelganger merge where the parents are swapped.

...

> +       # Same merge as master, but with parents reversed. Hide it in a
> +       # pseudo-ref to avoid impacting tests with --all.

There are 2 calls with --all, which may be worth testing for as well
assuming we still have similar bugs as shown in the second patch,
but I guess this would also allow for other tests (how do we list all
pseudo refs for example?) to cover more corner cases.

I am not sure I like this.
