Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E56721F424
	for <e@80x24.org>; Thu, 10 May 2018 00:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965671AbeEJAEj (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 20:04:39 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:39350 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964863AbeEJAEh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 20:04:37 -0400
Received: by mail-wm0-f51.google.com with SMTP id f8-v6so1278041wmc.4
        for <git@vger.kernel.org>; Wed, 09 May 2018 17:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=He0web4WBSgpYUCYSdNKjNlLCn4KoDQAM2HTA15vfJs=;
        b=CFJf/ye0sZyzivrYGFMEZ+saFyQ2nRx62KjsHrnoTPRUmU9M2nYZSlWJCdQb3DifF2
         j1YgPc+hfPIc9iByH4ki/heQilMaBhpCe4Jt3r/T9Pmrs+7ynAfdDZW5g/y+GotL3NoE
         FUh+ktRSYjpRpHiyBdCM2xB4pwU8qtJH+iNMHo18b4Vcrsx4ttkzG/+/Z6kxMU1VVncT
         9iEPi+wd/bPUeKOl5HLooJQAZeqoyfg4U0kRtgtaMI0h9VPMac2DKovn2WiUmmNGAlf8
         iJKjuaISYqRZNieCSVXNv6rzsD2VxkwToRqeM8JBT4bXVUx72cRbOFU9kkRghPM273QK
         DJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=He0web4WBSgpYUCYSdNKjNlLCn4KoDQAM2HTA15vfJs=;
        b=lxAjatOpupKQF1vfGaGmmZbU7/I1w+XFK7QtjSyagG2GFvB5R0QO/nZB5j3avAhrhv
         6SPmOgkBf1Rij+Dl7JrzVL/9hCC6nD3sii3OokMCUwaNBjbGPOrsN1UsoUsxGmkvfsIq
         O3nl5CRVFhPvFy8YnfvFa50fRJYnxQ907MiGxxhTFw1f1NEsrCHt2ZDqU8F+O45GS7/4
         g04KuuPQ5k+sgbQdDQhXOBHe5pabvDupHCp+zatoMuQFC5hJb7l/ELuHwivYIgUT+d1j
         Loe2HDnzH8VbAHUkI1sSVOdDHdBYxBtvOcpFxoBJYtXM2kI34P07YvLc34RGgrnkqHjH
         HmFg==
X-Gm-Message-State: ALKqPwcTThDL0ERIUmmssyA6xD9+u2Q2DradrYjKvvpHa2JBdmxf8hvi
        sj71ggRzrgitYRwZHuwkbf8=
X-Google-Smtp-Source: AB8JxZrTPZzLzXQhu27fHAq1gAo4faYeNZ8IFwBjuSuwuPkNZlZEt/CTxpFX21iN4rRrvDYsI9or/w==
X-Received: by 10.28.130.75 with SMTP id e72mr6834731wmd.64.1525910675981;
        Wed, 09 May 2018 17:04:35 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a69-v6sm10918528wma.7.2018.05.09.17.04.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 May 2018 17:04:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?Tmd1eeG7hW4g?= =?utf-8?B?VGjDoWkgTmfhu41j?= Duy 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 5/7] builtin/grep.c: add '--column' option to 'git-grep(1)'
References: <20180421034530.GB24606@syl.local>
        <cover.1525831201.git.me@ttaylorr.com>
        <9222f0ee470884a984c1174cf218dece43f77f87.1525831201.git.me@ttaylorr.com>
        <882bdfe8-6caa-dd9c-7752-ee4884f135f9@talktalk.net>
        <CAN0heSpXCajyDKwOrXuQHWRODsVnFewUWTMitOoRQueFV4eSiw@mail.gmail.com>
        <20180509235251.GC68889@syl.local>
Date:   Thu, 10 May 2018 09:04:34 +0900
In-Reply-To: <20180509235251.GC68889@syl.local> (Taylor Blau's message of
        "Wed, 9 May 2018 16:52:51 -0700")
Message-ID: <xmqqefikl6jx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> This check we should retain and change the wording to mention '--and',
> '--or', and '--not' specifically.

Why are these problematic in the first place?  If I said

    $ git grep -e first --and -e these
    $ git grep -e first --and --not -e those
    $ git grep -e first --or -e those

I'd expect that the first line of this paragraph will hit, and the
first hit for these three are "these", "first" and "first",
respectively.  Most importantly, in the last one, "--or" can be
omitted and the whole thing stops being "extended", so rejecting
extended as a whole does not make much sense.

    $ git grep -v second
    $ git grep --not -e second

may hit all lines in this message (except for the obvious two
lines), but we cannot say which column we found a hit.  I am
wondering if it is too grave a sin to report "the whole line is what
satisfied the criteria given" and say the match lies at column #1.

By doing so, obviously we can sidestep the whole "this mode is
sometimes incompatible" and "I need to compute a lot to see if the
given expression is compatible or not" issues.
