Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C92D21F859
	for <e@80x24.org>; Wed, 24 Aug 2016 10:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932673AbcHXKFt (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 06:05:49 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:36444 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932670AbcHXKFq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 06:05:46 -0400
Received: by mail-it0-f44.google.com with SMTP id e63so199980690ith.1
        for <git@vger.kernel.org>; Wed, 24 Aug 2016 03:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FaQghV9sq844wOWZmHbDNLypM02HVsoauTePpM4W81k=;
        b=KauBJaYqbKGOJLasL/aUF5+I1jbnYMAy2tTS8NNa0TXVyUS2saAubQR1cXxlwdtIu3
         1Uif+kGc2Qng4G5RCL5EPAFtlOzm8MZgK4EGTQM2kidX86bUkH5vzfYaMyaEDmABfun9
         KTeQBPnUL0J4VWHCard275HJQQMHSaR0Oi92Nv1aobwv9u/SXgDd7If7jKPRoLO9Proq
         VQQOhz173ZrkUSttFwe/wOgHkIlDM+XBHOdvhZ4QshnWDiBv8sjuaU0HNiXx/9UxDB9b
         d4JtqIdoqnQczQuRNY+28Lii1oBoMn9dT1Q8pBKtpOnohuGvp602I/dUrNnxqEeyXms1
         eajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FaQghV9sq844wOWZmHbDNLypM02HVsoauTePpM4W81k=;
        b=d2Ck7aHqB7cpYmMuZ5nTPz7SUMfwg0vAB3LZOEh4mO/+z+/rFOvSRMB8ZzjtywwS79
         Ik03Z5JwRTqQWpHmqC6dA9Fw/cx3Hi342qiycVa52Rs9P8N9MSkigwxd6AqeHKYeR32p
         IQbaTgHPkVTaoEXJ0BPps1C1qlTNLDF28r+jOxTlVuPSMrkqBLqjQ4w/VxJoKl2Sxy+r
         ncbBod2OXaN0mZVTTWdfVfu3QtpCzAeFoBHjo/XNNMP3ph/JHOe0ZbAmfQV2PiYAmgey
         94yspXL58aWrAgwAD0CeQiL1iavYx9dIJET8prMiFZuN7zpZizDNJp6k4OEJUFNBdvci
         Dd7g==
X-Gm-Message-State: AEkoousWI0Rh3t7yDf/geigtrxP4XfFwm355+NjGQDOfI4hqjyKw+o7OnKPd/3TtZj8pBP4N8i0AptkKXS5hRA==
X-Received: by 10.107.2.78 with SMTP id 75mr3058598ioc.128.1472031484748; Wed,
 24 Aug 2016 02:38:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.54.40 with HTTP; Wed, 24 Aug 2016 02:37:34 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1608231541420.4924@virtualbox>
References: <20160712164216.24072-1-pclouds@gmail.com> <20160714153311.2166-1-pclouds@gmail.com>
 <CACsJy8Bw0ZNu-6SB0P3dBZCLMJWJkbUqb64H_QOcn4UH+_AcNA@mail.gmail.com>
 <20160819135408.ckyw6ruseicvg2jt@sigill.intra.peff.net> <5c131421-ae7f-8a37-76ab-0fd05cbe3530@gmail.com>
 <CACsJy8C30=-LGMYQJ6MO17L8Vv1q=iQGC=R8TDhC5qM1f5Lh5A@mail.gmail.com>
 <vpqr39harit.fsf@anie.imag.fr> <CACsJy8BNP8GDRxDGTQwcYWTovN9o11TCkUJ28=5zav3QnGv9nQ@mail.gmail.com>
 <vpqlgzp9bw1.fsf@anie.imag.fr> <CACsJy8BokiiDbheN1_CqWWgK3xRn8YP30t7ojjVeDnok5_M4Ow@mail.gmail.com>
 <alpine.DEB.2.20.1608231541420.4924@virtualbox>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 24 Aug 2016 16:37:34 +0700
Message-ID: <CACsJy8CY1HqSTtmPw+H1yGXV_tBPt3GVU162ZTVecXFhPTnaYA@mail.gmail.com>
Subject: Re: [PATCH v4] config: add conditional include
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Sebastian Schuberth <sschuberth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 23, 2016 at 8:42 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Duy,
>
> On Mon, 22 Aug 2016, Duy Nguyen wrote:
>
>> On Mon, Aug 22, 2016 at 8:22 PM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> >>> I think the syntax should be design to allow arbitrary boolean
>> >>> expression later if needed.
>> >>
>> >> I would be against that. We may extend it more in future, but it
>> >> should be under control, not full boolean expressions.
>> >
>> > Why?
>> >
>> > I'm not saying we absolutely need it, but if we allow several kinds of
>> > conditions (gitdir-is:... and others in the future), then it's natural
>> > to allow combining them, and arbitrary boolean expression is both simple
>> > and powerful (operators and/or/not and parenthesis and you have
>> > everything you'll ever need).
>>
>> For starter, we don't want another debate "python vs ruby vs lua vs
>> ..." as the scripting language :) (for the record I vote Scheme! maybe
>> with infix syntax)
>
> FWIW I do not think that Matthieu implied that this has to be implemented.
> But it does not make sense to slam the door shut prematurely, either.
>
> Meaning: the more doors you can keep open with the new syntax, the better.

It works for me either way. So I'm going to assume we want
"[include-if "gitdir-is:..."]", unless people think it needs more
discussion (then just write something, anything, so I can put it back
in my backlog)
-- 
Duy
