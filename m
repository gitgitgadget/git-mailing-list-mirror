Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 670BD1F406
	for <e@80x24.org>; Sat, 12 May 2018 05:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750791AbeELFIx (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 01:08:53 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:36247 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbeELFIw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 01:08:52 -0400
Received: by mail-wr0-f170.google.com with SMTP id p4-v6so7150164wrh.3
        for <git@vger.kernel.org>; Fri, 11 May 2018 22:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Lk76BMJpqlvKu/MU2sNqf43Ja0p82NWEHdSnGsKz014=;
        b=ZBinV8eUzuv04oVpryQ+IOZuvKdeB0cWN+LPfiYlMRPFMb0TS7Scti20NVJLLQUIxr
         CNxOY4Z6awawydmRrEua/EMbge2IIXfluj/AuhfDUao8XuGDxFUP0CjpFq/Qe+gZj3K0
         th8PhLH4LjNw6KEqjHJcABOc5DUwegVpYLu1Uh/dSEmKx3TAZYhKYJKn+F8rrjOELWok
         oAMO7ftlj5J7aXNgDVDTwfc3IE6tv+KS4p+p8g74ag21TZLvskO7R7f6VkjorzqsmOq3
         HaDqpnoGPCqzdzu/g57u5J5SIIo1MKINP0K5T3iQ8Yz7dNctg4NQkGGS1QyNFfkk9lrZ
         wLAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Lk76BMJpqlvKu/MU2sNqf43Ja0p82NWEHdSnGsKz014=;
        b=oChkBLaAXt8ffGXE1dPC8Mu2NnJBbMlDOc2Zf10475dqQyuuizAzCGk2LfqOR5WrBV
         Mp0VjL5OmIH1s8sxgOMbV6/D/ZzsJdqGKBFMaTYbzs7O1QWC10nxTijGmtUI0ZBH8t0C
         6B4t86AqrrWc5rrb3WNz9yavoVYgU9g4Krsag2gHpm46XFEcpdJwik3IFC9gRUgTHpvb
         DZO+fYw79Ph8Jjpykh2CsowZRXhNdNINF/SRQqsTmUgVY9DzGzw+oL77AtCTivonHDxa
         l0anA+odvps2XUMEONi5O7T61TbKf+r78ovL0L+ij7G0r8pikkC6yHJ+wD6u+tMZtLRI
         S80A==
X-Gm-Message-State: ALKqPwdNTtU1vSXAsdFXgNSVRzCWWdGIO975OnG8uaIHuTXTu5sYRUdU
        HzKuVankIb1ssljsBlrjgmg=
X-Google-Smtp-Source: AB8JxZqf7YE0/kuut+uN30RESyvTUCOAufRkvDxNu+vYoYZhPDA1JXDxfHpZBHuyxpAdRu0WlhlFOQ==
X-Received: by 2002:adf:e4cc:: with SMTP id v12-v6mr1143237wrm.243.1526101730645;
        Fri, 11 May 2018 22:08:50 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p10-v6sm5297025wre.77.2018.05.11.22.08.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 May 2018 22:08:49 -0700 (PDT)
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
        <xmqqefikl6jx.fsf@gitster-ct.c.googlers.com>
        <20180512032733.GA65308@syl.local>
Date:   Sat, 12 May 2018 14:08:48 +0900
In-Reply-To: <20180512032733.GA65308@syl.local> (Taylor Blau's message of
        "Fri, 11 May 2018 20:27:33 -0700")
Message-ID: <xmqqbmdlfokf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>>     $ git grep -v second
>>     $ git grep --not -e second
>>
>> may hit all lines in this message (except for the obvious two
>> lines), but we cannot say which column we found a hit.  I am
>> wondering if it is too grave a sin to report "the whole line is what
>> satisfied the criteria given" and say the match lies at column #1.
>
> I think that is sensible. I previously was opposed to this because I
> thought that it would be too difficult to script around the 'sometimes
> we have columns but other times not' and 'I gave --column' but have to
> check whether or not they are really there.

I am not sure if you really got what I meant.  I am suggesting that
"git grep -v --column second" should report that the entire line has
hit for each and every line that does not have "second" on it, which
is a good answer and eliminate "sometimes there is column answer (or
answer to -o query) and sometimes not" at the same time.

> In other terms:
>
>   * not giving '--column' will _never_ give a column,
>   * '--column --invert' will _always_ die(), and
>   * '--column --[and | or | not]' will _never_ give a column.

So this is completely opposite from what I would have expected. to
somebody who said "I think that is sensible." over there.


