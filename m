Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B1921F454
	for <e@80x24.org>; Wed,  3 Oct 2018 00:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbeJCG4A (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 02:56:00 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:37196 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbeJCG4A (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 02:56:00 -0400
Received: by mail-ot1-f45.google.com with SMTP id o13-v6so3799008otl.4
        for <git@vger.kernel.org>; Tue, 02 Oct 2018 17:10:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jJsvSbKYjcotZmERLHfSq5DIx+bFIc9u6yVa/OnsDvU=;
        b=l0Qydu7bBjTkev6ANzgWzKocghVQf4jgIzU2ogBJegPhTkTrnC6WRMHpj98NjumhAB
         lUxDrjGMhTo9evtU4d7tx2mE2corGc14km+nuyjTV51fujH76FF91f399SVi4wV6dZeX
         QfoR0Nw1zTb/y9aRI3RTCAsGwnrGms0WzDFtwvzCjVX3dz2mUL6pWf8kkwlUgYGOb8uh
         G/iuH3Xrn963c2233ieHt1W/zrh17JLO8bZ0SbVg8HsC9i2Il5pwW6sden1kwjNuxPAJ
         vZ5hT2zaDO8MQmaeFIoUwmULz5tGYO2grAuw0NQNtALibA+wjbg8kc9EiiPfbg6Wth6Q
         PCeg==
X-Gm-Message-State: ABuFfogsNv3l/dUu2/dkBfeAnXDIQD/eDeWLA1vhZxNL64PeFS5zsfze
        6DEoQNnVHtYHku1aiz1ChjbVKMhrQVxA13wU/Leouw==
X-Google-Smtp-Source: ACcGV63J0GTwaln0LXpw/pdCVLWKNvvqw7soJ5649/Nshn8x4FXYtCDjxcH13LbwPOUuLPBWvJ/dn75MhVReQjWHviM=
X-Received: by 2002:a9d:7a7:: with SMTP id 36mr4853237oto.72.1538525404926;
 Tue, 02 Oct 2018 17:10:04 -0700 (PDT)
MIME-Version: 1.0
References: <573B6BF5.1090004@kdbg.org> <20160517194533.GA11289@sigill.intra.peff.net>
 <20160517195136.GB11289@sigill.intra.peff.net> <20160517195541.GC11289@sigill.intra.peff.net>
 <CAM-tV-9gAGBLsEh3=aa-bHT2DmJb=dfahq+kUW+0GLoc7eFq0w@mail.gmail.com>
 <CAM-tV--dHGJbxfWGKrRde+Q2-cnmCXNshQtX4PN7jnMWER_+bg@mail.gmail.com>
 <20180625162308.GA13719@sigill.intra.peff.net> <CAM-tV-8sbbht7NUwf87-gq=+P=LNPyiEcv3zL+1BxfXK+ktmVA@mail.gmail.com>
 <20180806212603.GA21026@sigill.intra.peff.net> <CAM-tV-_=4WuMGemm6RTB902-m8JfMKGp_OkQFuJMagPE8bOOtg@mail.gmail.com>
 <20180908161316.GA326@sigill.intra.peff.net> <CAM-tV-9N36puQHKQ38JxAxNR5Zen=3jM7pG7vHioYvvGTxLHCg@mail.gmail.com>
In-Reply-To: <CAM-tV-9N36puQHKQ38JxAxNR5Zen=3jM7pG7vHioYvvGTxLHCg@mail.gmail.com>
From:   Noam Postavsky <npostavs@users.sourceforge.net>
Date:   Tue, 2 Oct 2018 20:09:46 -0400
Message-ID: <CAM-tV-8PRAPdrQie=Vy8hiRuDr6FaQzsJFuwMtR5PS6Y+Lbo+w@mail.gmail.com>
Subject: Re: [BUG] A part of an edge from an octopus merge gets colored, even
 with --color=never
To:     Jeff King <peff@peff.net>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Hemmo Nieminen <hemmo.nieminen@iki.fi>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 24 Sep 2018 at 20:27, Noam Postavsky
<npostavs@users.sourceforge.net> wrote:
>
> On Sat, 8 Sep 2018 at 12:13, Jeff King <peff@peff.net> wrote:
>
> > Great (and sorry for the delayed response).
>
> No problem, I know it's not the most urgent bug ever :)

Ping. :)

> I managed to recast my script into the framework of the
> other tests (see attached t4299-octopus.sh); it seems like it should
> go into t4202-log.sh, but it's not clear to me how I can do this
> without breaking all the other tests which expect a certain sequence
> of commits.
