Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A85461F404
	for <e@80x24.org>; Tue, 14 Aug 2018 20:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbeHNXbB (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 19:31:01 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:53621 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbeHNXbB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 19:31:01 -0400
Received: by mail-wm0-f45.google.com with SMTP id s9-v6so13568313wmh.3
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 13:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=H1ufvFtCHtH/4QT1ZVCdSagugH0pfqC9reSRhrWQcv4=;
        b=MdOoJ46yldj8LoVXqeyA52QFP+Mj7olEkoGi5us7leArwEJqmas1cNGv0wRjL9Abcp
         S2+oMnz0/P5U8qGlkRQlxD44CZJ5fj2lONVPGnvYb6XWpD8brRHLSlWapM9QXM9epou5
         FUiswGP0xOfczF8Ad9RcPyNbzANvVcq3QxHTWjifp99zYaB9mPXcEkFeoebBJ+5oIhIY
         sucSW+PpgmIwFne9unBa94Z9iX/Y9gtIWhqqrs1yA4a/262UM4RVchCAsSr5V5f0t5mD
         zwGIGmQ9IBAyjZG3CeWDJWRvgG7uJmAsqGhMqNC3c0oshsqr0rNRxmz6FiofDeskpopi
         78Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=H1ufvFtCHtH/4QT1ZVCdSagugH0pfqC9reSRhrWQcv4=;
        b=OoX5ecUf4ECc72LXr7+u2wq9HrK66WGxgeGB1470ICS/EqC9IjArxWBqRpT9z3djZT
         olVyUQ0sDBZj9yWIcBu1QOnQ0colzJX9gJ2mK0fB+dtq0RsL84c9QGAe8nm3g/KXZoHm
         GdmPE8P2PaUQO3OOIrkC6wWVagc6kLexRjlapmRoCnMudMbWe0WaH4+yjImA0JpMUgWM
         I9P4Ub1pJtu3HSEE1GGXOOOBPrgnOwi5wdXDrpRauXJV3AcRqKDaGrhQjBdq1soc9u7X
         pv9Zk0ROkF4PR3guWhzgZ3rZqvnxMLu60wiQ+gJSGsm5pLhqxbjOcWqNAlLwK2XsC8pg
         X11w==
X-Gm-Message-State: AOUpUlHrrEYWEEzXdOR4bKEFLvg28nb3R61orRumQD2rB9UAOgmj3vc6
        oLXyZN0L3yTl0yIbECiqevg=
X-Google-Smtp-Source: AA+uWPwLwnlFnSvVBL2s0bynkvSwxUFHslFZpJF0jCE4fZC9KNAZIm5sefIixOromM6iYCH2x4uyKg==
X-Received: by 2002:a1c:888e:: with SMTP id k136-v6mr12220995wmd.6.1534279324396;
        Tue, 14 Aug 2018 13:42:04 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id m68-v6sm212283wmb.10.2018.08.14.13.42.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 13:42:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: Measuring Community Involvement (was Re: Contributor Summit planning)
References: <20180813163108.GA6731@sigill.intra.peff.net>
        <87h8jyrtj6.fsf@evledraar.gmail.com>
        <xmqqh8jy3sx1.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kbLVoGFEEPHgEJxBFqAMCzjgXK6gxRix__P5PWL8M2MyA@mail.gmail.com>
        <20180813210617.GA19738@sigill.intra.peff.net>
        <CAGZ79kaNa2bo31rQexs4rAH6bAz1rMzpxS3-fSFE6Cj87E8saw@mail.gmail.com>
        <20180813215431.GB16006@sigill.intra.peff.net>
        <3f0da3cd-0929-4aad-2c50-92c9d6c660e5@gmail.com>
        <20180814193646.GC28452@sigill.intra.peff.net>
Date:   Tue, 14 Aug 2018 13:42:02 -0700
In-Reply-To: <20180814193646.GC28452@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 14 Aug 2018 15:36:46 -0400")
Message-ID: <xmqqin4cznmt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Aug 14, 2018 at 01:43:38PM -0400, Derrick Stolee wrote:
>
>> On 8/13/2018 5:54 PM, Jeff King wrote:
>> > So I try not to think too hard on metrics, and just use them to get a
>> > rough view on who is active.
>> 
>> I've been very interested in measuring community involvement, with the
>> knowledge that any metric is flawed and we should not ever say "this metric
>> is how we measure the quality of a contributor". It can be helpful, though,
>> to track some metrics and their change over time.
>> 
>> Here are a few measurements we can make:
>
> Thanks, it was nice to see a more comprehensive list in one spot.
>
> It would be neat to have a tool that presents all of these
> automatically, but I think the email ones are pretty tricky (most people
> don't have the whole list archive sitting around).

I do not think it covered e-mail at all, but there was git stats
project several years ago (perhaps part of GSoC IIRC).

> I think I mentioned "surviving lines" elsewhere, which I do like this
> (and almost certainly stole from Junio a long time ago):

Yeah, I recall that one as part of counting how many of 1244 lines
Linus originally wrote still were in our codebase at around v1.6.0
timeframe (the answer was ~220 IIRC) ;-)

