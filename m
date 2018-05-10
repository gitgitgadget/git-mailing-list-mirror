Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E78A21F42D
	for <e@80x24.org>; Thu, 10 May 2018 06:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756505AbeEJGnd (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 02:43:33 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:45041 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753497AbeEJGnc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 02:43:32 -0400
Received: by mail-wr0-f169.google.com with SMTP id y15-v6so823664wrg.11
        for <git@vger.kernel.org>; Wed, 09 May 2018 23:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=EAJaZAcAz87SDCHJ4Vt5430+LFk1OqME589mclReBT4=;
        b=Uvm1DqQgas54LrYyamFOmGMk19ROZTH3D2qls5+FDWpNj7HCxInoZy7/UX7hFzlp84
         EstONw8Tmkb1ZNB0rnm26CrF2M06xwd/K3glaYtmDhhXMOoemUeJdgy5RciAZ0vqfRp5
         iDxjtab8KKHT+jzBp8mbl1F2828KkHCI87087/kLvVcoRYiNRhdAb57IhWYBZgX6Ek5S
         h6wcxHgx553egLX8khYDdixEB85vkatXjNULl/b0eJ82sALbgUFWIQ5nDfE6ziMyL3i6
         n3cii8yhpwf8ytPheaMbCTIGZA1K774oRbQ6oFIeL97nzafBVZAKiE3wuowDkxTqK0E1
         dwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=EAJaZAcAz87SDCHJ4Vt5430+LFk1OqME589mclReBT4=;
        b=TMS/AlezfqKOU9tbGaLu7B9NznSDO6oJ5jWS4qdAbBDUPZwpRZNLYWUPDTpQo0kFZu
         z1zQiRkWtA4fkZsYaaDA977clzCoB3YAmjD4g+pCrdks/ZrWAGPEW4t93klwUVeT/3zG
         M921oAxca47ENsqbOakqerQfBWKcUmVxW2oDKgCtUiZ9HykqJPUgk6cQo2mjmGNk8voE
         AbffVSD7LSX+FSsB+8ht1sr5j1IgZeQGP9zx/kb3WMA2aGLxHg4lQ551/e7JZLmwkYRY
         O+SQzlIFlcGuVs2gW9Wjsno6EohJVl/XEpu3uv8qEXHitPFIAWxnHmwmvp3olpDmv1zn
         OyAQ==
X-Gm-Message-State: ALKqPwdUMTdn0Cmp3m0Po4wPiWicSoox+df4R6ZA6sAqhu8K4kEwv3qt
        mbnG1ehXDIbBBJgNVTd6HVk=
X-Google-Smtp-Source: AB8JxZrQk+9hycxI8ld8QtlryHX73e2nG4enmK7KHWb9B9t4cDhePzg47GY9sJuV/oNRPkMd+7baYg==
X-Received: by 2002:adf:98f4:: with SMTP id w107-v6mr178536wrb.209.1525934611520;
        Wed, 09 May 2018 23:43:31 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q7-v6sm197759wrf.49.2018.05.09.23.43.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 May 2018 23:43:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 5/7] builtin/grep.c: add '--column' option to 'git-grep(1)'
References: <20180421034530.GB24606@syl.local>
        <cover.1525831201.git.me@ttaylorr.com>
        <9222f0ee470884a984c1174cf218dece43f77f87.1525831201.git.me@ttaylorr.com>
        <882bdfe8-6caa-dd9c-7752-ee4884f135f9@talktalk.net>
        <CAN0heSpXCajyDKwOrXuQHWRODsVnFewUWTMitOoRQueFV4eSiw@mail.gmail.com>
        <20180509235251.GC68889@syl.local>
        <xmqqefikl6jx.fsf@gitster-ct.c.googlers.com>
        <4640b041-f66c-3c1f-1329-baa4580df5cc@web.de>
Date:   Thu, 10 May 2018 15:43:30 +0900
In-Reply-To: <4640b041-f66c-3c1f-1329-baa4580df5cc@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 10 May 2018 07:58:47 +0200")
Message-ID: <xmqqk1scj9il.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Am 10.05.2018 um 02:04 schrieb Junio C Hamano:
> ...
>>      $ git grep -v second
>>      $ git grep --not -e second
>> 
>> may hit all lines in this message (except for the obvious two
>> lines), but we cannot say which column we found a hit.  I am
>> wondering if it is too grave a sin to report "the whole line is what
>> satisfied the criteria given" and say the match lies at column #1.

And if we are planning to use this to implement '-o', then I'd
suggest that we'd say the matched part of the line is the whole
thing (i.e. so is column #1, eo is at the eol).

>> By doing so, obviously we can sidestep the whole "this mode is
>> sometimes incompatible" and "I need to compute a lot to see if the
>> given expression is compatible or not" issues.
>
> FWIW, Silver Searcher 2.1.0 does just that:
>
> 	$ echo a | ag --column -v b
> 	1:a
>
> ripgrep 0.8.1 as well:
>
> 	$ echo a | rg --column -v b
> 	1:1:a

Thanks for additional datapoints.

