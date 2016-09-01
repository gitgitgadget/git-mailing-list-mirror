Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 137811F859
	for <e@80x24.org>; Thu,  1 Sep 2016 04:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750762AbcIAEAc (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 00:00:32 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:35550 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750696AbcIAEAb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 00:00:31 -0400
Received: by mail-qt0-f177.google.com with SMTP id 93so36052917qtg.2
        for <git@vger.kernel.org>; Wed, 31 Aug 2016 21:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vObVAs9sYnDfXZfM8QaFjZ0DcgSaSiWIvOZjum0ovKc=;
        b=gmCH1DI0MskBZbIBlyI34gcfDtrdHF7DPF1tYKHnkfcv2seQ2X2hkA0rNwro4dmSAi
         be/TvNuKxHuIJT26UYyCtivO4nihcam6pwa1fGiRjuanYdvOQWaBLyNHN8yPx09MlODv
         7SspuFO99q4GY/zQuUHWqsTvNWx8CaneDCUVOmuLfYnoG/enGgJG+iWmTjbcf9k/2wkJ
         UIzVioz81gi0CJVCu4hijyGl+WmDvZnn/XfGkGFzTDPPUiPgTjvYO+k3apWRgftUWjoN
         MCvDuiNDfi8sq+0wP2EUeBKED+iui6BWiv27QOKixmpz/DvPKfzhdaDEBW6V2l46I823
         9L5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vObVAs9sYnDfXZfM8QaFjZ0DcgSaSiWIvOZjum0ovKc=;
        b=K5giHS69JnLiPeob0yAkOAiZjQNGs3KkAWa6PcBeN+eMWOf5Z6R+j1GH1AH33jwzJd
         WjzIJV1HStN9mvEGL99ai8rvZmHgVloX8thPtEG4B5+znB8NQSxvbmrThF/7bpROMIyt
         jY/Q3yC1EzsW/V2uEYWcR2irWwZeg5p42WuUMnHfcXj617twMz0accXxNscM65+wQcAK
         09coUE9c0nxZ77D0+toW11F5W9EcWEQMCob3M6kx2C8IEiKGpsccth1jAuHFt1NAalms
         +6BnIQL0Q94mkGaBcli9WHQAjNk+C4X+VRSD8lUx6PM16fss+kof4/8tButJ/39PZQFu
         qQQQ==
X-Gm-Message-State: AE9vXwOyokkRnkUFcc7bnwkadw0o07mOSsMkJiA1FykX6P0yTuepdyyx7vZ8lGK3YHtpmKJUdxkb681/j3F2bg==
X-Received: by 10.200.36.243 with SMTP id t48mr15047380qtt.125.1472702430640;
 Wed, 31 Aug 2016 21:00:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.195.20 with HTTP; Wed, 31 Aug 2016 20:59:50 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1608311233440.129229@virtualbox>
References: <b2d016e44fa04e8a318967c43762d6933faf7956.1467183740.git.johannes.schindelin@gmx.de>
 <0dfa96b17edfe84ba19c7e57fe0b017c77943e0c.1472478285.git.johannes.schindelin@gmx.de>
 <20160830084357.rdmt2ehngrz6rqaq@sigill.intra.peff.net> <xmqq37lm3w6u.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608311233440.129229@virtualbox>
From:   Sverre Rabbelier <srabbelier@gmail.com>
Date:   Wed, 31 Aug 2016 20:59:50 -0700
Message-ID: <CAGdFq_iJeziyXBPL2GVHNXZcjGAwQVN2EhJs4AtJCSx7ghn32Q@mail.gmail.com>
Subject: Re: [PATCH v2] t/Makefile: add a rule to re-run previously-failed tests
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 31, 2016 at 3:36 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Tue, 30 Aug 2016, Junio C Hamano wrote:
> > Jeff King <peff@peff.net> writes:
> > > Hmm, interesting. Your approach seems reasonable, but I have to wonder
> > > if writing the pid in the first place is sane.
> > >
> > > I started to write up my reasoning in this email, but realized it was
> > > rapidly becoming the content of a commit message. So here is that
> > > commit.
> >
> > Sounds sensible; if this makes Dscho's "which ones failed in the
> > previous run" simpler, that is even better ;-)
>
> I did not have the time to dig further before now. There must have been a
> good reason why we append the PID.
>
> Sverre, you added that code in 2d84e9f (Modify test-lib.sh to output stats
> to t/test-results/*, 2008-06-08): any idea why the -<pid> suffix was
> needed?

I can't really recall, but I think it may have been related to me
doing something like this:
1. Make a change, and start running tests (this takes a long time)
2. Notice a failure, start fixing it, leave tests running to find
further failures
3. Finish fix, first tests are still running, start another run in a
new terminal (possibly of just the one failed test I was fixing) to
see if the fix worked.

Without the pid, the second run would clobber the results from the first run.


If only past-me was more rigorous about writing good commit messages :P.
