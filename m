Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2F4ECAAA1
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 16:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiISQYL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 12:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiISQYH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 12:24:07 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61003AB23
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 09:24:06 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id l10so28358185plb.10
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 09:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=jrnETKx0TOhAFCTkGEs4z1u+glBEkbql+1uXQvKmgxw=;
        b=GOQetmeY8MM2i37Y8f5LM2LQavVrqknkvs9ZUHvqOfrEA5luWyRXp/vC+L8PiT1Rm2
         o8J15i3BbHixYhU7ItWbuPM8pB/liNeL/LnoiewQuDgUayBj3xsyrHUPbpEyFsWWPa8Q
         9gj/6A1mavF7QLlZA+vK6907MOVaoxopK95f9IRygtnEvl4T8ewtH3/8Cap5hDGI0YZs
         /jv7uQFvjBbftK7L5wYn6F3tev2n6296k6PJMJT5iCFoDDrQUV2ACsGIqjfje33nuRxn
         YD3N1bIZ5jiRmhyvfPfYfMiTLn6bbSk8m/TlmqAXEmVHU4u1gnps1mM4l6VOmnleanJj
         qeTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=jrnETKx0TOhAFCTkGEs4z1u+glBEkbql+1uXQvKmgxw=;
        b=ncIWXLJlEqc+GDiYFCpWpotDJOmWJIoFKUPIekreu4sdIhomjo4MEc/f5vVSt4xFmW
         7bj1GflImOUKSyjauiw7MBYl1AlyHZ26fCGpLzL/lJPTej2VcyGSQgChTCDhvfn8q0Bn
         XL5ubHUDy6+HrBVzLR7zSACoGKs2hibnvOX3BHSE/1CezGSmoIqCiWSuqCWBv6mvHBGN
         jw8c/0xRHPWIZxp6vO1+qzQ5ehPlM0zKbu0yWXOO8IUaWzS/8fV28YTZitL7hk8DheBy
         PIvgo23bYppb5yePOuuTziJRz2mushAUm8vwyw5r3xQMQEhdp75pWgUnjuRA5Bgz5I6B
         L9mQ==
X-Gm-Message-State: ACrzQf0PNiD7Z3QnX3awq49TVwV1WlPuPyvgGSwHCUBiSGP7+s/tMZCK
        hs0Nfx9wnzH7J1549QbJ2zA=
X-Google-Smtp-Source: AMsMyM78ZN9yqNeGtf14cC3OwMqJuzZ7Z4ZBaHxiBMiK69lMibSJatMsCCt88bIFTRjI6ajsqrSrLQ==
X-Received: by 2002:a17:90a:5996:b0:203:1640:2dbf with SMTP id l22-20020a17090a599600b0020316402dbfmr21173074pji.150.1663604646269;
        Mon, 19 Sep 2022 09:24:06 -0700 (PDT)
Received: from localhost ([113.172.46.62])
        by smtp.gmail.com with ESMTPSA id rv11-20020a17090b2c0b00b001fb3522d53asm6918156pjb.34.2022.09.19.09.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 09:24:05 -0700 (PDT)
Date:   Mon, 19 Sep 2022 23:24:02 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.38.0-rc0
Message-ID: <YyiXojfvwfvmW4Dd@danh.dev>
References: <xmqqczbwkpt8.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqczbwkpt8.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-09-15 19:37:07-0700, Junio C Hamano <gitster@pobox.com> wrote:
> UI, Workflows & Features
> 
>  * "git remote show [-n] frotz" now pays attention to negative
>    pathspec.
> 
>  * "git push" sometimes perform poorly when reachability bitmaps are

I see that most reference to command use third singular form.
Maybe s/perform/&s/

>    used, even in a repository where other operations are helped by
>    bitmaps.  The push.useBitmaps configuration variable is introduced
>    to allow disabling use of reachability bitmaps only for "git push".

[...]

>  * "git format-patch --from=<ident>" can be told to add an in-body
>    "From:" line even for commits that are authored by the given
>    <ident> with "--force-in-body-from"option.

Maybe a space between last double-quote '"' and 'option'

[...]

> Performance, Internal Implementation, Development Support etc.
> 
>  * Apply Coccinelle rule to turn raw memmove() into MOVE_ARRAY() cpp
>    macro, which would improve maintainability and readability.

[...]

>  * A coccinelle rule (in contrib/) to encourage use of COPY_ARRAY
>    macro has been improved.

Maybe title-case 'coccinelle' for consistency.

> Fixes since v2.37
> -----------------

[...]
>  * "git fsck" reads mode from tree objects but canonicalizes the mode
>    before passing it to the logic to check object sanity, which has
>    hid broken tree objects from the checking logic.  This has been
>    corrected, but to help exiting projects with broken tree objects

s/exiting/existing/ perhap?

>    that they cannot fix retroactively, the severity of anomalies this
>    code detects has been demoted to "info" for now.

-- 
Danh
