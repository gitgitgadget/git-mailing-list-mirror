Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45D121F461
	for <e@80x24.org>; Fri, 17 May 2019 23:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbfEQXN3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 May 2019 19:13:29 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:37493 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfEQXN3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 May 2019 19:13:29 -0400
Received: by mail-ot1-f42.google.com with SMTP id r10so8217690otd.4
        for <git@vger.kernel.org>; Fri, 17 May 2019 16:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FNTpBvVMWBJvgXmcSRLQLhyzKFAyzKk9ijeCOxlu3bA=;
        b=Nwjm+1+gpeKNOwLHp5qdYsYOVVgvc3VwFAsLzxG8Lm01BQR+VGFUYvE7EYrbqaSeUX
         naN0k3urdnc501itqulYrHoIFe5slZYIpG5YzOOy/ibU2GVIxNLEbz0Uh7YeU3aCJQTR
         ntlxPFNtDbEfFV0A5n2FpHj5+D0np2iAiXAP/hYp3wlMUhjnYhL0K1kzrwGLXA/hcRpk
         ibA9qf4GMNg2Z3o5cmStJOkVdFvFPvNWB3J8GLfMmBfn292zzLKlBZkEJcHBqxIVMxWu
         snPNJZE7uxd4yA178d8jZyNpXz+mbY3xg6hx8NIXq/lPNWDQRbMeirsSOy18O1X5EitD
         h54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FNTpBvVMWBJvgXmcSRLQLhyzKFAyzKk9ijeCOxlu3bA=;
        b=GDhHNEKdmjLAhyJTU/8ZcCT3a8wcglxwnfVGnyWIf6lkeFESz/uvo8t161ZUycjj9Y
         65zjVDX9qhwvJqSciG3Uyuvpsvq9G70+Zl4y5Usf52tBsJx695cBOJk0B5rkKDDQUib7
         9QLfo+QyLy4AUrAQJYwS9+OLa5Rn79pRw5U/NHXZKnQ04VYKaPZqeDSZcamgOJzpziC+
         hTLwDCkOiKWqROyERdqJmAy9Nm81UOT6JbAcUohroVoWf5oX2l3DpbUoc2ed7LGAl751
         MDwht/K5utOsAWtbcYJehgmShurDZVvWfv0K0/g8Kl34r3orEhtp9IrhLvkcQOr0PxaY
         Tt4A==
X-Gm-Message-State: APjAAAVfozyeolR2CU6+D4croMbDOKGB04W4hmXdAmMHSTaX5nBHD5j6
        QyFYxdcB2HdbuUDY7v2gbgbjBFamBeOBS4ghCxs=
X-Google-Smtp-Source: APXvYqx53jxwbmk8MX4Qa0GGAqm0n4+vffmN9M1stkCqfRVVCWKq4T02oem+rYcw/hrSY4ErMh2nQZDSaiO97WJVVbA=
X-Received: by 2002:a9d:7a85:: with SMTP id l5mr5984191otn.170.1558134808843;
 Fri, 17 May 2019 16:13:28 -0700 (PDT)
MIME-Version: 1.0
References: <CACPiFCJdXsrywra8qPU3ebiiGQP3YPC6g-_Eohbfwu_bQgfyVg@mail.gmail.com>
 <8736lfwnks.fsf@evledraar.gmail.com> <20190516042739.GH4596@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1905172121130.46@tvgsbejvaqbjf.bet> <20190517222031.GA17966@sigill.intra.peff.net>
In-Reply-To: <20190517222031.GA17966@sigill.intra.peff.net>
From:   Martin Langhoff <martin.langhoff@gmail.com>
Date:   Fri, 17 May 2019 19:13:17 -0400
Message-ID: <CACPiFC+=co2-yGwoiKqr1qSu8dLmVQZ5NxfbdwOr7xz=a7xpdA@mail.gmail.com>
Subject: Re: Git ransom campaign incident report - May 2019
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 17, 2019 at 6:20 PM Jeff King <peff@peff.net> wrote:
> I hate the magical-ness of 3b, because credential-store really _isn't_
> the best choice. It's just better than the current behavior. At the same
> time, by doing it automatically, the existing flow they were using just
> works, and is moderately better.

Quite a bit better. It sits in a different directory, and with tight
permissions.

Overall -- thank you! That's the process I was picturing. Even just
scrubbing the credentials -- your "step 1" -- would be a significant
improvement, if a bit unfriendly.

> > Judging from looking at my own automated jobs, it does not appear that you
> > would *ever* need to store such credentials in the Git config, anyway. If
> > you need to, say, push to a repository, you can always store the full URL
> > (or the credentials) in a secret variable.
>
> Yes, that's definitely the way you _should_ do it. I think the problem

The key thing are the credentials, and there are much better solutions
for this -- ssh keys, etc.

This isn't for thoughtful users, this is to save unaware users from
themselves. Maybe they'll and hurt themselves with something else, but
that's part of removing sharp edges from a product.

cheers,


m




--
 martin.langhoff@gmail.com
 - ask interesting questions  ~  http://linkedin.com/in/martinlanghoff
 - don't be distracted        ~  http://github.com/martin-langhoff
   by shiny stuff
