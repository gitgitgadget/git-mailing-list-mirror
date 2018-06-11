Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43B841F403
	for <e@80x24.org>; Mon, 11 Jun 2018 21:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754148AbeFKV62 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 17:58:28 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:36892 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751712AbeFKV61 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 17:58:27 -0400
Received: by mail-yw0-f194.google.com with SMTP id j190-v6so6841933ywe.4
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 14:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JgbHg+sBvN9oA3oSTxugeBuAK+6Qjj7doZtfYtRKQjA=;
        b=Zohp3YWbrxPw4Nu8LRsSAg2s0Zr1eu1GfwPIbhHQmSG9h1gHX4JGSfKw6wef/idPnK
         jfXTnnLNsc8ZVyt974/2nLXpaK1pAbOON4qhFdSOgQSL12Ejy5HzJmU6QOy7ssKfBuOS
         ZAjrFNAU4OrxWwHvs5zel+61V48bjumR9UvAHykTlN34lcb3Wz80LXqM5bY8ZFvqDU3Y
         ymjgg8rWQl6hcTGAIZUH4LyHYLQBwSu4NFERgZZvTX1/dcx/C+HfANiu4eU8r4qL45vy
         VvvjlHuwNMvsW4/blR2hVuNDIyOEh1rghUdPzHi9RZh/LjW8hGypGFUJ+Kx6c0i49vbA
         KyJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JgbHg+sBvN9oA3oSTxugeBuAK+6Qjj7doZtfYtRKQjA=;
        b=EZMqa3F/x4FCCDXKAQbXF5TWuDHsQk6O3BZNwryiSOhtL01s6x0XA6KWi0AGF49k+z
         E5SwZ0fV6kdCDjWz3NzOrF8Fm8j5S/ffaQkxcMwSf5zpbUX7jnOOX85ZcCwlumywdeZP
         TxRHLDAXy2ECjytHCNP6yaO6Axeez+SepUmSXWoMCGnyrg4oaFHWtvEeQpFtluffDhZ9
         gxxPvkYv8eYAtdeS/poHELl2hf1hXcO+yZPOHr8WJjtwC/eKXnFtPmltLWlqI8+SSsns
         rQB46+7lyz9zSL2OeFW1kBwWlMP8uyyQpeliYb2jLnjyI3WOTysATUzAN+IliyMO/z7n
         qOYw==
X-Gm-Message-State: APt69E3ZMsBsZMCA3yGebOCcktrrPSUvbAQt5gDucS87wfFtHaz9nNSF
        hhUSlJxNZf4wD4DQY7aSPpdwWsv17ckKsBN6023Hgg==
X-Google-Smtp-Source: ADUXVKLdPWXqNI+2wfitDI5q9HXX82zIa+mxdYXWe2AcMaIhf6gjF+essOolcIG4prB3IYgC29HCcZZWAHjvJ+6I5fc=
X-Received: by 2002:a81:4d43:: with SMTP id a64-v6mr442513ywb.33.1528754306154;
 Mon, 11 Jun 2018 14:58:26 -0700 (PDT)
MIME-Version: 1.0
References: <74c84bda-4f3d-b2d3-91cf-e80e84fe46b1@gortan.org>
 <3a3eb88e-0d7b-e689-c4e4-207569ebd667@macq.eu> <xmqqd0z61xsv.fsf@gitster-ct.c.googlers.com>
 <CAKPyHN0j0VPcMCN4huVP2Dqsg0g3WmOw304S8dcRbWVtZTphHQ@mail.gmail.com>
In-Reply-To: <CAKPyHN0j0VPcMCN4huVP2Dqsg0g3WmOw304S8dcRbWVtZTphHQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 11 Jun 2018 14:58:15 -0700
Message-ID: <CAGZ79kazAU-=Z0Q+X6_TimMbkyDQZ4c3mAVuGH0rrR_HenqPPw@mail.gmail.com>
Subject: Re: git-gui ignores core.hooksPath
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, chris.maes@macq.eu,
        philipp@gortan.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>, Philip Oakley <philipoakley@iee.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 4, 2018 at 10:48 PM Bert Wesarg <bert.wesarg@googlemail.com> wrote:
>
> On Wed, Apr 11, 2018 at 12:50 AM, Junio C Hamano <gitster@pobox.com> wrote:
> > Chris Maes <chris.maes@macq.eu> writes:
> >
> >> Is there any hope from here that anyone will pick up this / these
> >> changes? Will anyone else be assigned the main responsible for this
> >> git-gui repository?
> >>
> >> Just hoping to revive the discussion here, since the
> >> https://github.com/patthoyts/git-gui/ repository seems quite dead.
> >
> > It indeed does.
> >
> > I've played a patch-monkey in the past for git-gui and have a few
> > topics queued still in my tree, but that serves merely as a bookmark
> > that is slightly better than a pointer to the mailing list archive.
> >
> > We need a volunteer to take over this part of the subsystem;
> > somebody who actually uses it, passionate about improving it, and
> > can speak tcl/tk somewhat fluently (I qualify none of these three
> > criteria myself).
> >
> > Any takers?
>
> the last time this topic came up, Stefan (in Cc) offered to volunteer.
> Stefan, is this offer still open? I would support this.

After I made this offer, I started looking at the code base more and trying
to add a feature just to discover I do not qualify as fluent in tcl/tk.
Also I have some issues managing my time, so I retract that offer.
Though I'd still review the code in this area.
