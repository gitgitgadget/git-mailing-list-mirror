Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CA9920357
	for <e@80x24.org>; Mon, 10 Jul 2017 17:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932560AbdGJRdl (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 13:33:41 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34878 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932100AbdGJRdi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 13:33:38 -0400
Received: by mail-pf0-f174.google.com with SMTP id c73so53338870pfk.2
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 10:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6dBzLDaknyKQGhc6sXn7BNcZ+oIhXMPIme8Z8V4kcb8=;
        b=ZzVE4ZkE5IYWiJl5sZhyIELnbf7Tv8b0uKl/bm6/nQ9tGoXVp5Kjahywojvfh6W2Zu
         iXcFSnAz6yLVInY/RErpfkg+qRjpG7og8hzwoZq4vN/IWLLiIEg0E6DN4xandru1Tpne
         rURJNbg7dGyS9DhrCbzy4SLHLpqIdXj0Ad7hwSKJxNpDSuxRRpTErspZ3Zj+wUAjo9WS
         t0aU075sj8GK0VuvT0hWCDmyFGAtwLlNdRbDrL7mlxklrBVPSjazaIS27rRwTDhOUSLv
         /j9waWgDNVQQIunXTmtcrTMOViCOvkXmm8Ev/z9IOacXWlpLX10bAWu8tgqdufS2DVHA
         SVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6dBzLDaknyKQGhc6sXn7BNcZ+oIhXMPIme8Z8V4kcb8=;
        b=mt853QEXCDF05MAye2ZhU72opywEt18Kk6V3QeyY3byAIZ8nsj+iEoBtbqGGcRI5Ae
         sU65AwxySYJVsahzO7ZZKJ44vkveRiMDC5T9icbBd+UXXf/JkhPtfStnt1JwiXTBG4lq
         3ZVGiBQGOBMYGxLFeJe3zHHxLnIR1cegOqp6KkXrM2n29zfnFXW/zw9lTg7q5vLu6TzF
         htRWb5hnDbCDqjJXLeVLzONzs/8c6P0qKLyC5zB9sGvGtawBr3EzT+XQJ68dY5hP0tco
         iaDThT67tY3lcmGTvX3hyee3M80fdulOEAwp+Up4TMYvdVWHQFgufcGMexwhoH+FCEuS
         GghQ==
X-Gm-Message-State: AIVw111N+vlxbAu0aPkohMu1MvVvwFf4HvYU0MP3muLfTYX8SlW/65pJ
        +AVC5n7yQIbgLBsbZQMwiT1NGqwLq9dp
X-Received: by 10.98.112.137 with SMTP id l131mr45730356pfc.194.1499708017973;
 Mon, 10 Jul 2017 10:33:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Mon, 10 Jul 2017 10:33:37 -0700 (PDT)
In-Reply-To: <xmqqr2xo6y2s.fsf@gitster.mtv.corp.google.com>
References: <20170710070342.txmlwwq6gvjkwtw7@sigill.intra.peff.net> <xmqqr2xo6y2s.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 10 Jul 2017 10:33:37 -0700
Message-ID: <CAGZ79kbbqj++1HZVY3gBaghn+knWa+cAgwWUw9Z+zdNkjQHCWg@mail.gmail.com>
Subject: Re: [PATCH] strbuf: use designated initializers in STRBUF_INIT
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 10, 2017 at 9:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>>> That way, we will see if there are people who need pre-C99 soon
>>> enough, and we won't have to scramble reverting too many changes
>>> when it happens.
>>
>> Neat idea. Something like this?
>
> Yes, your log message said everything I wanted to say, including
> possiblity that some compilers may have specific features without
> supporting all of c99.
>
> We accidentally started using "trailing comma at the end of enum
> definition is allowed in c99", and we know it has been safe at least
> for a cycle.  Credits goes to Brandon for 4538eef5 ("grep: add
> submodules as a grep source type", 2016-12-16).

Credit goes to Brandon for spotting it, but the introduction of
"trailing comma at the end of enum definition is allowed in c99"
is e1327023ea (grep: refactor the concept of "grep source" into
an object, 2012-02-02) IMHO, which is more time that proved this
feature being supported on all compilers.

Thanks for getting the ball rolling, just wondering if the patch needs
a comment in the code. The commit message is very thorough though.

Thanks,
Stefan
