Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0D041F406
	for <e@80x24.org>; Sun, 24 Dec 2017 11:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752538AbdLXL5H (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Dec 2017 06:57:07 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40745 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752157AbdLXL5G (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Dec 2017 06:57:06 -0500
Received: by mail-wm0-f68.google.com with SMTP id f206so28566035wmf.5
        for <git@vger.kernel.org>; Sun, 24 Dec 2017 03:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=0BuU342BlNX07rGVyE/xbRIM4gwYM71tDMsin4VaTnM=;
        b=FLU7zaRIWM7Jo1/Fkx7o1hc/EfEFTTdDjXxBphWcZV3dxdmJjhbtiviHj3L9s0WWz6
         jdKPKNfF/oh5HuOQwLMpUxB1tjI+A6R7fe8dBv0146fG3Q2LBNZW97+b8NNRpWqdEc5v
         NCKbqe7+TcJD5diIfUi3RxJDcJ3N0UfAxLZvM3P4CvoWwVhNEi+/0T035MVO43HoCac/
         NCO6Hr8yTtGCTofNbU/IQJLLFzdAC6nRiWwr4pkIR6RD3ZN294RLFlH6hqRxI+ldILie
         +zUEu4v/haXSXJZ57c3FwQEawzRULcMRsj47N6pq7Ab/9Mu1pBunucnxexreX3eMhYNM
         omOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=0BuU342BlNX07rGVyE/xbRIM4gwYM71tDMsin4VaTnM=;
        b=lTDlYAtH06NFPos3Z+jSFfLOVeB/q5BuyC0jR9PDwNvKaKbuqL7zaq8slko/c9hQ8W
         wfd1jqDd/++WKMbLBLtPpPvlej3CjX5KXxlL/7zFpJZpKp5jK/XDMmxv57THEGyizklE
         pmLFYfvemKap13x6SB7p8eOE9iNmbHDIh9J2jeA0ytJve6Qu/Jec9fcAx/cwqrD3nI9l
         B1d8He3eMcA/inpVuYYYJHl0DaaVRu9g4CmIOjepCHP+nnFWx4efIAGEMGR515o2rOtI
         MgWBsYUhqUYmjSbbtuNy6vzWLIjFIOTmqljh3CQHRNGEkbgR8088/Zks4GRIsPBR/kPK
         fCLg==
X-Gm-Message-State: AKGB3mLj+SpRMeYEcIxgM+zEcYT/vmD6/c1YglyomYP0csH6Vnz5qVX5
        WmdolO4xz5JvGXnBc9VSYS4=
X-Google-Smtp-Source: ACJfBos1vVvBMRE3Y3Q3QqUKT76JeOp1d0NENsR0kbVHodUNleKaewTD3kTMxvhdrUJN4PBQ1BEL8w==
X-Received: by 10.80.143.163 with SMTP id y32mr22591366edy.167.1514116625177;
        Sun, 24 Dec 2017 03:57:05 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id u21sm20237779edl.54.2017.12.24.03.57.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Dec 2017 03:57:04 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>, Jakub Narebski <jnareb@gmail.com>,
        Petr Baudis <pasky@suse.cz>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [RFC/PATCH] perl: bump the required Perl version to 5.10.0 from 5.8.0
References: <20171223174400.26668-1-avarab@gmail.com> <20171223231742.GF6217@genre.crustytoothpaste.net>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20171223231742.GF6217@genre.crustytoothpaste.net>
Date:   Sun, 24 Dec 2017 12:57:03 +0100
Message-ID: <873740s5io.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Dec 23 2017, brian m. carlson jotted:

> On Sat, Dec 23, 2017 at 05:44:00PM +0000, Ævar Arnfjörð Bjarmason wrote:
>> The reason to do this is to be able to use features released with perl
>> in the last decade, 5.10 was a major feature release including things
>> like new regex features, state variables, the defined-or operator
>> etc.[3]
>>
>> I expect this to be more controversial as since the 5.8 release stayed
>> along for longer in various distributions, e.g. it's the version
>> shipped with RHEL 5, replaced by 5.10 in RHEL 6 released in late 2010,
>> similarly the first Debian release to include 5.10 was 5.0 (Lenny)
>> released in early 2009. The release history for other distributions
>> can be seen on CPAN's "Perl Binaries" page[3].
>
> This is fine by me.  As far as I know, 5.10.1 is the oldest version of
> Perl still security-supported by a major Linux vendor.
>
> Feature-wise, the release I'd much rather see is 5.14, since it provides
> the r modifier to s/// and tr/// and undef-transparent length, but that
> simply won't be possible until RHEL 6 and CentOS 6 go EOL.  Upgrading to
> 5.10 is better than nothing, and it does get us defined-or, which is one
> of the only 5.10 features I ever see used.

Indeed, but as you point out it's not going to happen for some time
given the burden we can reasonably place on downstream packagers.

> I'm curious, though, is there some reason you went with the "v5.10.0"
> syntax other than "5.010"?  I believe the latter provides a better error
> message on older Perls, although I agree the former is more readable.

It would only provide confusing errors on 5.6 and older, which as noted
we haven't supported at all since before 2010, so people are unlikely to
be running it.

I'll note why I did that in a non-RFC commit message, FWIW this wording
was also confusing in perl's own documentation, which I fixed the other
day: https://github.com/Perl/perl5/commit/f1546a83e7
