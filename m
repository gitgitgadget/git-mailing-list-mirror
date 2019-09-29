Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC3561F463
	for <e@80x24.org>; Sun, 29 Sep 2019 00:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbfI2AwA (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Sep 2019 20:52:00 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33169 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728569AbfI2AwA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Sep 2019 20:52:00 -0400
Received: by mail-lf1-f66.google.com with SMTP id y127so4497995lfc.0
        for <git@vger.kernel.org>; Sat, 28 Sep 2019 17:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1pTnW3il0ZhPz6C/UPFiNPnpHcoRjlXR7EEcE84owiQ=;
        b=rFfFHYxLI4VyiQ+rZUhnKJ4eials3noYWh9NnPGTXKQJudSD11tYDtYA4sTgr5T8HA
         3rIjYnX5+jqS/KLPssCKYFL2GIVO0uovqMbkaqgVWl9OtwNtn+wphZ8bKqyC5uvBR3BW
         IbByehwKU4P9URHB44yapPaoGDatr3pt+xt27Jn5YTf0jwlgtVNG7+E/WfsdHfWtsAch
         WxHHuzQHw2adNAcYu0JIr9qtle/xcdcZfhyauHe9niiQ6M/takUAo3cKRFnUtkqnUcdp
         Ea6OQXktV+il9tjB2b9xf0hTvCjQHRQAN1ccvcq76ya1CvTijWTlclgFUOU3GsMDsymQ
         nPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1pTnW3il0ZhPz6C/UPFiNPnpHcoRjlXR7EEcE84owiQ=;
        b=VV9k8Kpv7ZrRvamxFXymZZo8Ls5Q/hBkrpDQr6zVY2UcHhPS+XsmAkOLIRnbmq/y4F
         RsPQ014w6zr9Q+Jy552bz5EEhAm5X5bJ7HaR3paCh5JOWplRtlvtmYyRVJ80Sbc97AVW
         4wBk95M2LTPGVCATx3w1+ki4efryic5yW+hUod1TeCC0+CtY0qRfU4c5CQR1bmDxFKRB
         /OhHwSvkEdeupDwF0oW6DJeZiDyLo2OzzWa3f6eZp504cRTh1/pZIsZZMlyzeB0BSdc+
         W8o3mT4d5ZFrBc6LmozHeMpQFb4KgzdPAQ9o07gpymwUtsQ/0CWe8fSynEdIx4GLX9N5
         6lKg==
X-Gm-Message-State: APjAAAVHKTHhEudqAUx0zf7x5D/lX8c7KwCikIAvQb643hDr6MG3bhOE
        LUlEZk5CGRKLDxnkQbVcSvthSgTGckPFK94DJxs=
X-Google-Smtp-Source: APXvYqwfEQES9f6UjDKpZwNCtP9NOHjw/3uIT9BssLNhZwXn0rwSEnOLbvAOV6uThxm0bAJPl/rA3+UTCblbA8y9UPs=
X-Received: by 2002:ac2:4c2b:: with SMTP id u11mr6881264lfq.179.1569718318006;
 Sat, 28 Sep 2019 17:51:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190925020158.751492-1-alexhenrie24@gmail.com>
 <20190925020158.751492-4-alexhenrie24@gmail.com> <03e509db-942e-4538-4729-4e345df82a7e@gmail.com>
 <nycvar.QRO.7.76.6.1909262155020.15067@tvgsbejvaqbjf.bet> <20190927025000.GD23736@sigill.intra.peff.net>
In-Reply-To: <20190927025000.GD23736@sigill.intra.peff.net>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Sat, 28 Sep 2019 18:51:46 -0600
Message-ID: <CAMMLpeRva+sVxhTE14prMFvZnJhouQO+vDYeze9ZRao-dAfsFA@mail.gmail.com>
Subject: Re: [PATCH 3/3] wrapper: use a loop instead of repetitive statements
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        dstolee@microsoft.com, Junio C Hamano <gitster@pobox.com>,
        davvid@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 26, 2019 at 8:50 PM Jeff King <peff@peff.net> wrote:
>
> On Thu, Sep 26, 2019 at 10:14:17PM +0200, Johannes Schindelin wrote:
>
> > However, I think that this patch should at least be accompanied by a
> > commit message that suggests that some thought was put into it, and that
> > concerns like mine were considered carefully.
>
> ...this I would definitely agree with.

Thanks for the feedback everyone. I am not used to projects requiring
detailed commit messages for small changes. I will send a v3 of the
three patches with the additional explanations you requested.

-Alex
