Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 292C8207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 19:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753368AbcJFTSw (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 15:18:52 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:32960 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751230AbcJFTSv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 15:18:51 -0400
Received: by mail-qk0-f182.google.com with SMTP id n189so24873021qke.0
        for <git@vger.kernel.org>; Thu, 06 Oct 2016 12:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PstPhwnYmhn5OeASImBXA25Iq6i6zqRZNWLYX1+BjZM=;
        b=yiLUj6CIOm3NJ/ZkoHc6qVgsOq5o1dUSdv56M9AA0RT6yN0ErOeZt5cXRwrqry39Ch
         hPGN6JbSztAGQbcG1iB2lZmnaMIXzqyZ46aBca4+3mNhRa43jG1hWX/GfzD37St0QoyJ
         AQjpwcTMzfmiwgemr7ia+BN8mNco0vlaTksXaxYxrCCycyJPSLxxlK6N43BcKjj+z6Cw
         BYMcIzEx8eoUfJ2bTSClecTlkHReB1c+Xgd94TjQKaW84bBqD+B+elI0RQgyq/uhes21
         DEfattzQXZtyuVAskiCEyd9fFpxX2wm/gXXab9TaEUCqpWsvuf7LswIbMzPpWE/0RhWd
         WOIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PstPhwnYmhn5OeASImBXA25Iq6i6zqRZNWLYX1+BjZM=;
        b=gGSxGPwRfY9GPnvcjCiVQ9PziajDV0dGoaFSq0C6G5B7/bLJ/jdPBWf2+FPTWlgLUK
         dQMScW7ARO2opopd0qhXeOlHa/fI6i+EmnrMekJEgAXLQ6fhzA8kETV2LC5rdFilhP1g
         OXCy2gK4I9AL8aYUlH+ZiXMdcYEVeGacUAumq1aCATR3PZJJeaR+N/MZDyKGR8AcgrVb
         ZOQxMaOoVm6yIN7Ztez4NtKjAMxv200ioLpCQuydBS+XGVZZTmmJMk8WMkZjH/IhB5SS
         WAVHePGtOT/+C17fbRQY4Q/JpPoLwq0rb2L3US8iZotIm8NRSSC6DcNzUlAqzbG4KClb
         3egA==
X-Gm-Message-State: AA6/9RnMbn8HP1XR4I0moUhocbnJ58LtvKBY4GgfmFmS9LU6HmjkLjh97ee7Xn/123xFRYtgfyA6R4c0TluiiQ==
X-Received: by 10.55.182.4 with SMTP id g4mr15247907qkf.120.1475781530488;
 Thu, 06 Oct 2016 12:18:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.87.133 with HTTP; Thu, 6 Oct 2016 12:18:29 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1610041802310.35196@virtualbox>
References: <20161004150848.GA7949@brightrain.aerifal.cx> <20161004152722.ex2nox43oj5ak4yi@sigill.intra.peff.net>
 <20161004154045.GT19318@brightrain.aerifal.cx> <alpine.DEB.2.20.1610041802310.35196@virtualbox>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 6 Oct 2016 21:18:29 +0200
Message-ID: <CACBZZX4XPqZauD_M_ieOwVauT1fi3MQb4+6taELQaRG9M-Kz_w@mail.gmail.com>
Subject: Re: Regression: git no longer works with musl libc's regex impl
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Rich Felker <dalias@libc.org>, Jeff King <peff@peff.net>,
        Git <git@vger.kernel.org>, musl@lists.openwall.com
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 4, 2016 at 6:08 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> As to making NO_REGEX conditional on REG_STARTEND: you are talking about
> apples and oranges here. NO_REGEX is a Makefile flag, while REG_STARTEND
> is a C preprocessor macro.
>
> Unless you can convince the rest of the Git developers (you would not
> convince me) to simulate autoconf by compiling an executable every time
> `make` is run, to determine whether REG_STARTEND is defined, this is a
> no-go.

But just to clarify, does anyone have any objection to making our
configure.ac compile a C program to check for this sort of thing?
Because that seems like the easiest solution to this class of problem.
