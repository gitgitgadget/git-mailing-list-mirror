Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B59F20248
	for <e@80x24.org>; Wed, 27 Mar 2019 10:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732908AbfC0KFc (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Mar 2019 06:05:32 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44799 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731664AbfC0KFb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Mar 2019 06:05:31 -0400
Received: by mail-wr1-f66.google.com with SMTP id y7so13647286wrn.11
        for <git@vger.kernel.org>; Wed, 27 Mar 2019 03:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WvKmnNY5yuJy5wdZCCx5mAJLQU+xUxHMZ/IvfbZL38A=;
        b=mg7CL1SdjcXpRI2QnETTFZne+Ob8/Zx2UThfYJ+cXytbzO44QtToIczsTGm2Duj3cQ
         SPeUL21dcetSxUYE+Oq1KJ8PlGkSpV+Ug+bMOnvX2Woh1sm0l/3z5ZVoLX0y+vf/m7VX
         VNp8F6+eaN8WQpYLa2OR8nI6BRKLgPvN4jTdScRxGUvtK30ehIWTXGyQkFwsuUw3O8gn
         1wbNZfDsjrLfGGkuY9CUiFVrCAdf2NSn6/X3goNtTieyISIau/Waz1ONVQ8GD780Jk2T
         zOsV3anoRYTugEQxRDvRQdkiJUJBJOAFY2gnwItnIN+0LDpzHkP2YCE3vvWjp3GF2DEk
         2E8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WvKmnNY5yuJy5wdZCCx5mAJLQU+xUxHMZ/IvfbZL38A=;
        b=QWAQkudvG74hKps+QKjWoZEgoQiCcqf9SqxDgtkuol6wLyCVTlpWQI3GhS9sfUkMRD
         GF34CKvEdip2opXIlqNjLVKJSyhQ7c2plsFBRU7rjMtHHzTMpXKJpGfNW6fX6kvzf46p
         tcRyi+cYPvK3HbPn7p55NucjEHBpMYEvhXOgCWGtEAF67ULxQK+nDsqBLsjwt99HtU7/
         kWAu7NELBGC8oa2SspFmxv0kVrFx2A32+eb/qFcJI56nVpp8VOPHW+FlK+bzyY7cJJpF
         VqaxFFNldu00MJO1q5GvfLIkb2aKwOndbccbH3lxs49kpXXOcaC/DOn2uTE+NEb8b3W8
         T03g==
X-Gm-Message-State: APjAAAUDNuKaoWVzk4TGHrxdBkweiUGQRb5vfFg/43EtYdFEz4wlddoB
        uEySRqKcCwRw7cI5xLPi+XVP6xeWAZY=
X-Google-Smtp-Source: APXvYqxFPQcJySn8qLtKfmzNnFuvjPy2PFntE3J/L+ps4+frFTYwG0h6Awo3QXP5YycZVsweiz4AQw==
X-Received: by 2002:adf:b612:: with SMTP id f18mr5430129wre.236.1553681129831;
        Wed, 27 Mar 2019 03:05:29 -0700 (PDT)
Received: from szeder.dev (x4d0c7b09.dyn.telefonica.de. [77.12.123.9])
        by smtp.gmail.com with ESMTPSA id v190sm2348751wme.18.2019.03.27.03.05.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 03:05:28 -0700 (PDT)
Date:   Wed, 27 Mar 2019 11:05:22 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] asciidoctor-extensions: provide `<refmiscinfo/>`
Message-ID: <20190327100522.GA32732@szeder.dev>
References: <20190317194431.GY31362@pobox.com>
 <CAN0heSrajiswzpm+au_5nmZMZG9406iZa-CK9p5CaHLTuxm8nw@mail.gmail.com>
 <20190320181715.GJ31362@pobox.com>
 <CAN0heSpJvsPm_qq63VumokmyOG6N=6fwMZRqf_9CzoCeHsdiyQ@mail.gmail.com>
 <20190323192756.GK4047@pobox.com>
 <20190324121619.GD312@sigill.intra.peff.net>
 <20190324162131.GL4047@pobox.com>
 <20190325150633.GC19929@sigill.intra.peff.net>
 <20190325190041.GM4047@pobox.com>
 <20190327010603.GR4047@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190327010603.GR4047@pobox.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 26, 2019 at 09:06:03PM -0400, Todd Zullinger wrote:
> Dan Allen fixed this upstream and released 2.0.2 today.
> It's very good to know that asciidoctor upstream is
> incredibly responsive.  If anyone runs into Dan at a
> conference, please buy him a beer. ;)

I noticed the "Release beer" lines in the Asciidoctor relnotes... :)

> One other issue that crops up with docbook5 is that the
> xmlto toolchain now outputs:
> 
>     Note: namesp. cut : stripped namespace before processing
> 
> as documented at
> 
>     https://docbook.org/docs/howto/howto.html#dbxsl
> 
> It's mostly an annoyance which we either want to strip out,
> or pass an alternate docbook5 xsl, I think.  But I'm not
> very familiar with the guts of the xml/docbook toolchains.

In our documentation CI build jobs we check that nothing is written to
Asciidoc/Asciidoctor's standard error [1].  These "Note:" lines go to
stderr, and will trigger that check and cause the build to fail.  So
wither we should find a way to silence these notes, or filter them out
in the CI builds.


[1] 505ad91304 (travis-ci: check AsciiDoc/AsciiDoctor stderr output,
    2017-04-26), though it never actually worked as intended, but that
    is about to get fixed:

    https://public-inbox.org/git/20190324215534.9495-7-szeder.dev@gmail.com/


