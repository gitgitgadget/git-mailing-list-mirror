Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB2351F4BD
	for <e@80x24.org>; Thu, 10 Oct 2019 17:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfJJRAg (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 13:00:36 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32864 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfJJRAg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 13:00:36 -0400
Received: by mail-pf1-f195.google.com with SMTP id q10so4304764pfl.0
        for <git@vger.kernel.org>; Thu, 10 Oct 2019 10:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IROP4e62LzR+f0SNsmkQ2F3MON8V8ietgU2m5ypNq+Y=;
        b=pZCwJ4bXWcyphY2gWn6tHFWw99mgR/72rbbkM+jhqQ2irC0RSYtpaAJ7GMUW8x6HmK
         frUUR+ExNRemXN6gO0oQqGvzQDmHZHJh14/ua3HzKklFZAurwEmsPuno1gtNr6ZFJVVV
         RK7k7JeWVxzWnpU2aRC8grNad4B2wuBtrHh4tytqFaH8HjsywYnKcAvAd3gM0u9XupEZ
         ocZ2z4AwUA4P1V755Axd4CfK5MGt4qRC5Gekeqq+R+7UvPPp0JL/yG0cgaP7BOUD8Ca0
         Pw+e/hxHww3vzbQern86E1SMb7OjsQ42fdeTEjUlEEtXGxf1oOOQYrRwK1F5TMK44qPs
         VvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IROP4e62LzR+f0SNsmkQ2F3MON8V8ietgU2m5ypNq+Y=;
        b=I1HLAwC1/sySDdqE7fGKyCoy8f0GRu/QHdZaNA5fOJJ90bRDO2nCninGxqma0FOre9
         U6aDe3GR+qbPmOw2xle44JXy0pTN6MRuPi+oQv5V1Wgq0RVWKHX7/pnvI8459/2Qx7Lj
         zij8EDD7v7AS1Ap60yIaFsvX5iH9VbtnlEOZtplyUEzT3UQApPVxX5eqVdOcsI7u1I8c
         gr9PQ4Dol8RXnFdVXHYViwjn3xKHFMbiMPinudPB+Tbe49HwKBtRu1UVc2U4Pk2SvkrJ
         yC8gdBngFcBW1f/0JsIvocPtagbEY0RB0ttFxrJAe6bcVKUaZVQ8pFDBTEmyA3/wbm2Z
         Zc/Q==
X-Gm-Message-State: APjAAAUTSp8PT03jmdmetenrU1lRcF3mdclA3iSxVRXBEW7b9PR88IbA
        qY4MShEBBVASuU0u0cpqinKmsvEM
X-Google-Smtp-Source: APXvYqx6VURKgWzVlGWm9FEsSrrKtHcUW7AVWPn4wUnyVP+bjWWlnFORmzXFhEx7/biLGAMu6SIfsg==
X-Received: by 2002:aa7:8046:: with SMTP id y6mr11644224pfm.178.1570726835537;
        Thu, 10 Oct 2019 10:00:35 -0700 (PDT)
Received: from generichostname ([204.14.239.137])
        by smtp.gmail.com with ESMTPSA id f14sm9915878pfq.187.2019.10.10.10.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 10:00:34 -0700 (PDT)
Date:   Thu, 10 Oct 2019 10:00:32 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Toon Claes <toon@iotcl.com>, git@vger.kernel.org,
        Zeger-Jan van de Weg <git@zjvandeweg.nl>
Subject: Re: [PATCH 1/1] commit: add support to provide --coauthor
Message-ID: <20191010170032.GA78298@generichostname>
References: <20191008074935.10972-1-toon@iotcl.com>
 <20191009014039.GA10802@szeder.dev>
 <xmqqr23mlkxo.fsf@gitster-ct.c.googlers.com>
 <20191009203105.GA7007@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1910101345120.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1910101345120.46@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 10, 2019 at 01:49:03PM +0200, Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 9 Oct 2019, Jeff King wrote:
> 
> > On Wed, Oct 09, 2019 at 11:19:47AM +0900, Junio C Hamano wrote:
> >
> > > > I wonder how we are supposed to use this trailer in the Git project,
> > > > in particular in combination with Signed-off-by.  Should all
> > > > (co)authors sign off as well?  Or will Co-authored-by imply
> > > > Signed-off-by?
> > >
> > > I think we have been happy with (1) a comment at the end of the log
> > > message that says X worked together with Y and Z to produce this
> > > patch, and (2) the trailer block that has S-o-b: from X, Y and Z,
> > > without any need for Co-authored-by: trailer so far, and I do not
> > > see any reason to change it in this project.
> >
> > One advantage to making a machine-readable version is that tools on the
> > reading side can then count contributions, etc. For instance:
> >
> >   https://github.com/git/git/commit/69f272b922df153c86db520bf9b6018a9808c2a6
> >
> > shows all of the co-author avatars, and you can click through to their
> > pages.

Yep, this is the reason why I raised the suggestion[1] in the
first place. Since special support for this trailer is implemented in
GitHub (and GitLab too, as I recently learned), I think this could be
considered a defacto standard for co-authored commits.

> 
> FWIW I really like this. It bugged me ever since that GitMerge talk
> (https://www.youtube.com/watch?v=usQgAy8YDVA) that we did not have any
> standardized way to document co-authored commits.

Yep, and this isn't the first time this has been brought up. I remember
stumbling on this thread[2] a while back about someone asking for
co-author functionality by default so it would be nice to have a
standard way of doing it.

Thanks,

Denton

[1]: https://github.com/gitgitgadget/git/issues/343
[2]: https://public-inbox.org/git/CAOvwQ4i_HL7XGnxZrVu3oSnsbnTyxbg8Vh6vzi4c1isSrrexYQ@mail.gmail.com/

> 
> > > If other projects wants to use such a footer, that's their choice,
> > > but I am fairly negative to the idea to open the gate to unbounded
> > > number of new options for new trailer lines.  We do not even have
> > > such options like --acked=<acker>, --reported=<reporter>, for the
> > > trailers that are actively used already (and to make sure nobody
> > > misunderstands, I do not think it is a good idea to add such
> > > individual options).
> >
> > Yeah, I'd agree that we should start first with a generic trailer line.
> > There might be some advantage to building trailer-specific intelligence
> > on top of that (for instance, it would be nice for coauthor trailers to
> > expand names the way --author does). But that can come after, and might
> > not even be in the form of specific command-line options. E.g., if the
> > coauthor trailer could be marked in config as "this is an ident", then
> > we we would know to expand it. And the same could apply to acked,
> > reported, etc.
> 
> Yep, and we have to start somewhere. I think this patch is a good start.
> 
> FWIW I would not even mind introducing the synonym `--co-author` for
> `--coauthor`. But that's just a very minor suggestion.
> 
> Ciao,
> Dscho
