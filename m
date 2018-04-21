Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC4971F404
	for <e@80x24.org>; Sat, 21 Apr 2018 03:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752778AbeDUDuY (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 23:50:24 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35483 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752629AbeDUDuX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 23:50:23 -0400
Received: by mail-wr0-f194.google.com with SMTP id w3-v6so27509698wrg.2
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 20:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Y3oGUFGcSZSibrQSZIzDTaLB82X2VdUHv3zRjBM6hW0=;
        b=Jm7e3E1LvtQM99ViMbFzXBcuwTPuq9ZP0KI3CMCC6vpyl2RS6o38M25g4Hb2Xz2vun
         xU+1XASVTdNg6B3KjZxs20sE+ZBWJFZiM+pvWOI4CAKkKX+7d0I05HdWKi0ii1nxVLEm
         klatVaHzILoQLWDMo4GfFAhvsv6kY/lesXZAk4EjaICl9H6Sy1o27duvZe+xhdN0IDqU
         t4i5Y+cwZzlrkyPvXTVANJc/GOE+gkKgr79+kXkW5hQhix8qNDNdf6luh9Puex1AIvg0
         FPF/FHwqHGLnhMbyCbSqIH95o+mprQ3vuQgcHwMBZS/JI9vqXku2HrZtWNU48L7PZghW
         jRqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Y3oGUFGcSZSibrQSZIzDTaLB82X2VdUHv3zRjBM6hW0=;
        b=PfnBahCQsNB7BAGeIft0iWvRCFV/RzJZDSJw9jGBIfl3IBZVhzmDoWkHE6VxoXXQ69
         Nqk56LpvCw5iQI0WHD32vsIxrPO3WPKgRi2c21NxZ4znLejaJooD36eoPvr0+/lQNiLy
         pyMLcRUpUSnP585+m6S1uEV6DqXrmwuiK3bgAR6ZAevQ3dbPHuY9Y4YC7aneM94l9WL1
         GO/wx28h8A6POdZ9wxUuUR7+Brv9W7hwiV14dCQjGOQzr0GwuOx2+ZUns1/LCV5DgUYV
         ZiMZh3aMzt01Jp3F7sZ7kktdH6JIKgSFCPwWm1KuuPHp2PVWGgKCGJf4JGlDss2y6Mtu
         DHcg==
X-Gm-Message-State: ALQs6tBL2Qm6up5sjX360a6tY7ceudLqc0CQ+yx66Y04cngGsfUtI5rd
        sdC9+w6Q72MxPrncAqN9dAvsryxg
X-Google-Smtp-Source: AIpwx48e1J2T8MLXnCGCTzqfTYVJ4ZY0YTn9Q2AdYkKF8PhigmOKJNciTDGihE7tmVtOkHdHaSLGMw==
X-Received: by 2002:adf:86ed:: with SMTP id 42-v6mr10277727wry.158.1524282622266;
        Fri, 20 Apr 2018 20:50:22 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id f2-v6sm5757274wre.76.2018.04.20.20.50.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Apr 2018 20:50:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v1] perf/aggregate: tighten option parsing
References: <20180420121041.32558-1-chriscool@tuxfamily.org>
        <CAPig+cSDYVGpaV-beNVG57r3YfQ=Ey5zuyHRkk_tf86NNRdY6w@mail.gmail.com>
        <87h8o5ensj.fsf@evledraar.gmail.com>
Date:   Sat, 21 Apr 2018 12:50:21 +0900
In-Reply-To: <87h8o5ensj.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 20 Apr 2018 20:27:24 +0200")
Message-ID: <xmqqd0ytb4le.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> Not necessarily worth a re-roll.
>
> Not that it matters in this case, but just as a bit of Perl rx pedantry,
> yes his is tighter & more correct. You didn't consider how "." interacts
> with newlines:
>
>     $ perl -wE 'my @rx = (qr/^--./, qr/^--.+$/, qr/^--./m, qr/^--.+$/m, qr/^--./s, qr/^--.+$/s); for (@rx) { my $s = "--foo\n--bar"; say $_, "\t", ($s =~ $_ ? 1 : 0) }'
>     (?^u:^--.)      1
>     (?^u:^--.+$)    0
>     (?^um:^--.)     1
>     (?^um:^--.+$)   1
>     (?^us:^--.)     1
>     (?^us:^--.+$)   1
>
> I don't think it matters here, not like someone will pass \n in options
> to aggregate.perl...

Hmph, do we want the command not to barf when "--foo\n--bar" is
given from the command line and we cannot find such an option?

I thought that the location the match under discussion is used does
want to see a hit with any option looking string that begins with
double dashes.  I would have expected "tigher and hence incorrect",
in other words.

Somewhat puzzled...
