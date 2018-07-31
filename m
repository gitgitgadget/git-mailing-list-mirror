Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 110A21F597
	for <e@80x24.org>; Tue, 31 Jul 2018 14:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732277AbeGaQGH (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 12:06:07 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33328 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732222AbeGaQGG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 12:06:06 -0400
Received: by mail-ed1-f67.google.com with SMTP id x5-v6so5474858edr.0
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 07:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=M2jUUvidkYAanjupYDljqIVgRkmhbqvNPB1GG+8lovQ=;
        b=Djgl9YR8pMvOCloouDL5hwpZODoPxDVmNF8i2+SSScsoPz5VCZxXNQBRkXMQUKyR5u
         cNhn1Q5gRgU8siFJs/zaR/I+Hl6NJ5rKDZwJR3kt3RTYGadhUHJ1SMrawJAEJY1FP1sb
         iaYZ7kGftfXBv3Ab5UfLudftuH2maBLr9kMPbddfMQvBiv99SRmHgAgFoymfl1QSMuGJ
         0xRoCCoNFZgJi53wrndsHOBQe9W9EYrFZ3mlJSEYp2m2/jP/dlqZqa0aIPhLvQKvFlTA
         Xb7cv8rtQ+5g5Bx7DVqTcr3zag67LKk+XflhkvlpQlaD54U9NwlhFY2GBPsEXkgJya2q
         Jvfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=M2jUUvidkYAanjupYDljqIVgRkmhbqvNPB1GG+8lovQ=;
        b=QwroJ6rwB66bgvdi8TeTnx6h5txesvLFABT1sYdtwKXJihPH95GcAh2WTtOpsQZ6EZ
         qPK6v7BaLpapIyv6opRHgeTfwn6xO9Yn79gbESSeHNeI0b0kDF+chzXHzf7Sv3DAAFku
         1GPQ7bxLVzV9sLKi/VUiFSIpUdffy+yM+tCZapTizEPs4V+sXpEES7pxmOgKiZIicqbM
         HfJOaOhl6kbz2jqjuc+M1hSKO468lC95cveNYXDASuyA8VrH4cRWaBrzBKcZgnLMJYqz
         4KtemqybB9qvrdq0wr0DldZ95CWmpQxNJHB2qFSQegLPjjwJ54XIjzuMny2QYOev9732
         RZVw==
X-Gm-Message-State: AOUpUlGt/3Lphd2SZD1B5s45Zhsv+EgOSv7+hve+ScJf8L5Mru+pebkT
        BMUl86e5LbrKF1WU/zaKHAU=
X-Google-Smtp-Source: AAOMgpd4+UuSGF6P4Om91jJezOaRmhyMeTgGzhGhmF6BlS+m+NM59OIFXiw79+iKcwwjA0UMIK3nrw==
X-Received: by 2002:a50:9182:: with SMTP id g2-v6mr12633991eda.24.1533047131776;
        Tue, 31 Jul 2018 07:25:31 -0700 (PDT)
Received: from evledraar ([5.57.20.50])
        by smtp.gmail.com with ESMTPSA id r11-v6sm2813833edh.32.2018.07.31.07.25.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 07:25:25 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Michael Felt <aixtools@felt.demon.nl>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Dan Shumow <shumow@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: Is detecting endianness at compile-time unworkable?
References: <fb935882-25b1-db5f-d765-50dab297f733@felt.demon.nl>
        <20180729181006.GC945730@genre.crustytoothpaste.net>
        <2309fa7f-c2d8-ee57-aff5-b9e32d2da609@felt.demon.nl>
        <20180729192753.GD945730@genre.crustytoothpaste.net>
        <dfe374bf-d9de-8dad-6ec9-4edfa3e9b12b@felt.demon.nl>
        <20180729200623.GF945730@genre.crustytoothpaste.net>
        <701d9f4b-efbd-c584-4bec-bddb51b11d96@felt.demon.nl>
        <87wotdt649.fsf@evledraar.gmail.com>
        <287cdba8-19c1-2fe8-4aff-d0385b38e92c@felt.demon.nl>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <287cdba8-19c1-2fe8-4aff-d0385b38e92c@felt.demon.nl>
Date:   Tue, 31 Jul 2018 16:25:24 +0200
Message-ID: <87sh3ztrcb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 31 2018, Michael Felt wrote:

> I hope a I have a "leap forward"
>
>
> On 7/30/2018 11:39 AM, Ævar Arnfjörð Bjarmason wrote:
>> Perhaps it's worth taking a step back here and thinking about whether
>> this whole thing is unworkable. It was hard enough to get this to work
>> on the combination of Linux, *BSD and Solaris, but I suspect we'll run
>> into increasingly obscure platforms where this is hard or impossible
>> (AIX, HP/UX etc.)
> While I still cannot say for HP/UX it does seem there is a potential
> solution based on the status for _LITTLE_ENDIAN and _BIG_ENDIAN. At
> least, gcc on POWER and xlc on POWER provides one or the other - and my
> hope is that gcc on other platforms also provides them.

Yeah with GCC this is relatively easy, see
https://github.com/cr-marcstevens/sha1collisiondetection/blame/c3e1304/lib/sha1.c#L29-L115

> For "other" compilers that do not provide them - a modification to
> CFLAGS to define one or the other should make "make" work.
>
> Details (note - I am not a programmer, so by definition at least one of
> my "macros" will be wrong :)
>
> AIX and xlc
> root@x066:[/]xlc -qshowmacros -E /dev/null | grep -i endi
> 1506-297 (S) Unable to open input file null. A file or directory in the
> path name does not exist..
> #define __HHW_BIG_ENDIAN__ 1
> #define __BIG_ENDIAN__ 1
> #define __THW_BIG_ENDIAN__ 1
> #define _BIG_ENDIAN 1
>
> On SLES12 (le) and xlc
> suse12test:~/images/littleEndian/sles # xlc -qshowmacros -dM -E x.c |
> grep -i endi
> #define _LITTLE_ENDIAN 1
> #define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__
> #define __FLOAT_WORD_ORDER__ __ORDER_LITTLE_ENDIAN__
> #define __LITTLE_ENDIAN__ 1
> #define __ORDER_BIG_ENDIAN__ 4321
> #define __ORDER_LITTLE_ENDIAN__ 1234
> #define __ORDER_PDP_ENDIAN__ 3412
> #define __VEC_ELEMENT_REG_ORDER__ __ORDER_LITTLE_ENDIAN__
>
>
> Based on what I can see on gcc on POWER and xlc on POWER I think an
> approach (simplified) can be:
>
> #if undefined(_BIG_ENDIAN) && undef(_LITTLE_ENDIAN)
> #error "one of _BIG_ENDIAN or _LITTLE_ENDIAN must be defined. Try adding
> the correct value to CFLAGS"
> #else defined(_BIG_ENDIAN) && defined(_LITTLE_ENDIAN)
> #error "Only one of _BIG_ENDIAN and _LITTLE_ENDIAN may be defined, not both"
> #endif
>
> And then logic based on the value set.
> This should also make cross-compile possible by unsetting an incorrect
> default and setting the correct value.

...the real trick is using these macros outside of GCC / glibc and on
older GCC versions. See the github link above, you basically end up with
a whitelist of how it looks on different systems / compilers. Sometimes
both are defined, sometimes only both etc.

It can be done, but as that code shows it's somewhat complex macro soup
to get right.

> p.s. Is there a setting I need to set somewhere so I receive a copy of
> the email sent after it is received by the list. I could send myself a
> copy, but I much prefer it comes from the maillist - as verification it
> was received.

You should get that, but maybe your mailer ignores Message-Ids it
already has, but you can go to https://public-inbox.org/git/ and search
for the Message-Id or your name to see E-Mails you've sent that made it
to the list, e.g.:
https://public-inbox.org/git/?q=aixtools%40felt.demon.nl
