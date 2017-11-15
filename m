Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F651202A0
	for <e@80x24.org>; Wed, 15 Nov 2017 08:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755259AbdKOIvH (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Nov 2017 03:51:07 -0500
Received: from mail-wr0-f169.google.com ([209.85.128.169]:45473 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752362AbdKOIvG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Nov 2017 03:51:06 -0500
Received: by mail-wr0-f169.google.com with SMTP id w95so950833wrc.2
        for <git@vger.kernel.org>; Wed, 15 Nov 2017 00:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WyTPusDbXtwFZQ+C+VY4j6hZqd7MSWBj0F/FOzbFvVg=;
        b=C5BwtBGlLQ1wjTrNQzND8zgEpKjoiGB7vzu1mZ0LV+EMp4TDg63IaYiYkGDYoI7hMx
         akb3T8TunIqYvHs/f+bwoW5gqZZca3GAuKwqksuYQvEUTMxCRf97t7krnN/TU/oQWfRG
         sKg8MlgIozspPQg5ba4BDYw6ZMKWZse/fFqqMgBwopuQ1MzoXKrNW3/LOhvZP3ABRv8F
         qkyg1vL4Se7lsPjYIFgV2OYWt9Ikw/EtuV+D2erDBCsyTi6btu0DJbrJV+p2OnmgbHyn
         Fw3XzJv5PaQEkDTYBGxSRzZfl4YPNIECDXPxJRLupVDoaIWKjxpNswiO0pMoG6AkpnSZ
         NKHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WyTPusDbXtwFZQ+C+VY4j6hZqd7MSWBj0F/FOzbFvVg=;
        b=Til8UbREyempBhHs9TwPZk9zcgGDnSjvemioEBMppjJjU6X4DfpFYTqPsEauZY7QO5
         7tv3hruJbrhGpWTOrfgp0xjw7+g0EIcH+N0F+OJEYhuCz8E9Ew86jHq8atj+VIWFdK5b
         3JNLfnm3T2LFufyPv18u/fRvg0njpXLy9ZHgPE3v936V5vJbGTlnxPli9N5YhYZmOUq4
         ZhVqXkmd2hdTfVYUmBYpJns0+t7gIjTG/xuIe39+w+zvf+UWf5F6u9idCbma6py7CjBi
         6wPMCP/eUq9+2NHbpN4NllI6hsdktBJ9NAoMWJyxTdVKqewuJW34PnL9G8y6evFFJEsx
         4xJQ==
X-Gm-Message-State: AJaThX5hjSx3qI5qV6yb/beOQeBgkMvtuGKNGv/hnotrlLVA52Di8eoS
        49B9um+KZrJ2Qy/CTNFG9NcRDmzy
X-Google-Smtp-Source: AGs4zMb41jImEfTcTuSiLfuKZvCHW0qLLi5/BOZuo82trny1ZeN0Y47lo+DC8jrj4rRuLVNfin/WJQ==
X-Received: by 10.223.182.81 with SMTP id i17mr11975037wre.224.1510735864858;
        Wed, 15 Nov 2017 00:51:04 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id m37sm23761443wrm.4.2017.11.15.00.51.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Nov 2017 00:51:04 -0800 (PST)
Date:   Wed, 15 Nov 2017 08:52:29 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v1 2/2] worktree: make add dwim
Message-ID: <20171115085229.GB32324@hank>
References: <20171112134305.3949-1-t.gummerer@gmail.com>
 <20171112134305.3949-2-t.gummerer@gmail.com>
 <xmqq1sl2c21g.fsf@gitster.mtv.corp.google.com>
 <20171114084517.GA12097@hank>
 <CAPig+cTYC01Y9-EvyNo9hxQRbT60iqp8MqXEB_zWBi14kPV1Ng@mail.gmail.com>
 <CAPig+cTDMvOWW2xLYfvQsOsfBuCOGDJwH_zRDQyxx1vpfkX4tA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cTDMvOWW2xLYfvQsOsfBuCOGDJwH_zRDQyxx1vpfkX4tA@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/14, Eric Sunshine wrote:
> On Tue, Nov 14, 2017 at 3:14 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> > For my own edification...
> > [...]
> > git worktree add ../topic
> >
> > * Correctly errors out, refusing to create a new branch named "topic",
> > if "topic" is already a branch.
> 
> By the way, there's an additional DWIM that could be done here instead
> of erroring out. Specifically, for "git worktree add ../topic":
> 
> * If branch "topic" exists, check it out (rather than refusing to
> create a new branch named "topic").

I think this would be a good improvement either way as I suspect this
is what users would hope for, and as it currently just dies there are
less backwards compatibility worries.

> * If origin/topic exists, DWIM local "topic" branch into existence.
> 
> * Otherwise, create new local branch "topic".
> 
> > * Creates a new branch named "topic" if no such local branch exists.
> >
> > The desired new DWIMing would change the second bullet point to:
> >
> > * If no local branch named "topic" exists, DWIM it from "origin/topic"
> > if possible, else create a new local branch named "topic".
