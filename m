Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AAE31FF30
	for <e@80x24.org>; Mon, 22 May 2017 00:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757265AbdEVARx (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 May 2017 20:17:53 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35450 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755073AbdEVARw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 May 2017 20:17:52 -0400
Received: by mail-pf0-f170.google.com with SMTP id n23so65062857pfb.2
        for <git@vger.kernel.org>; Sun, 21 May 2017 17:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=oSijd3E12kr+49SjbQ27c480iRcEEt981X/H1oOG2IQ=;
        b=FooULp0ZsPIEhJGdIBDTyWuwTtaQfjP9yrLqeA509LSnr6VLLDKMMfSs00mfdiq+BU
         t/WBOtEZ0q/dBhq0YhA2u/ZsDbWQWwYoOMF2hqvT1xHoqYvb8xolfSU7hrlruoliSCu0
         ewM+Hjfw8/9RxtTHq0E+pph3tsbZadi5lEJQFu78MEeUwusSkhrjWCWjZevtjF82ffgb
         Gzgt4tZ43r0M6sE4vXS1VNlebAYzPIpno8WPMfaHViPr4/rAk7cPr6TIdZTl29lVNY+1
         NpxRhpAym8FLjhglV87vMrooNCQt5PrFDqLuWst/zM3XGQR2H6HAmQbWOyt/KJwmCDtF
         Nh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=oSijd3E12kr+49SjbQ27c480iRcEEt981X/H1oOG2IQ=;
        b=LsmNvpWvRBqCxRBLiXXXaJ9j/sSJhOnmddGtpSNw99yFxR//pDajaTQGkGdwpPnDgW
         +tr28kM0OorDN464nsfAMLAXdtuHU6s+xorMCryQ00aWyDU2AB7FqDUh+hH+7JjaBvRD
         OeOdD25/oPDOy05Uyw0F/kIbvBdI5AqlDu5WmNqoVW5BRsbjafDuURwcYUkMUu8saJSS
         /yy48wFBNwjZoP3hQGu9NhDDJgPwMj2zPs9doEH5xVdOTj6PToGEOi6vWb5unljy4J+V
         y9savPejiRNwIHSttaQjFJCS9yJvONN68/wvFO0KbxJ8Vw46C5zUMRJ+MgiNpcDl8qLP
         ck3Q==
X-Gm-Message-State: AODbwcDoVwf07mo8gtkNxrW5C0LtkjrMTa30vKXJroJPcKUET1zJw6Ky
        XCnkYG2GkQq/1w==
X-Received: by 10.99.127.26 with SMTP id a26mr22139307pgd.75.1495412272206;
        Sun, 21 May 2017 17:17:52 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4439:f55c:c49b:d0dc])
        by smtp.gmail.com with ESMTPSA id n22sm17190767pfa.123.2017.05.21.17.17.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 21 May 2017 17:17:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v3 05/30] log: make --regexp-ignore-case work with --perl-regexp
References: <20170520214233.7183-1-avarab@gmail.com>
        <20170520214233.7183-6-avarab@gmail.com>
        <xmqqlgprqe9j.fsf@gitster.mtv.corp.google.com>
        <CACBZZX6Hp4Q4TOj_X1fbdCA4twoXF5JemZ5ZbEn7wmkA=1KO2g@mail.gmail.com>
Date:   Mon, 22 May 2017 09:17:50 +0900
In-Reply-To: <CACBZZX6Hp4Q4TOj_X1fbdCA4twoXF5JemZ5ZbEn7wmkA=1KO2g@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun, 21 May
 2017 08:58:24
        +0200")
Message-ID: <xmqqa865rbgx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> Looks good.
>>
>> I however wonder if it is a better approach in the longer term to
>> treat the .ignore_case field just like .extended_regexp_option
>> field, i.e. not committing immediately to .regflags but commit it
>> after config and command line parsing is done, just like we make the
>> "BRE? ERE?" decision in grep_commit_pattern_type().
>
> I started hacking up a patch to fix the root cause of this, i.e. the
> users of the grep API should only set `.ignore_case = 1` and not care
> about setting regflags, but it was more than a trivial change, so I
> didn't include it in this series:

Ah, sorry.  Now I re-read my response, "Looks good.  I however
wonder..." does sound like I am requesting to do something more to
solve the same issue.  I shouldn't have phrased it that way.  It was
more like "while I was staring the context lines of your patch, I
noticed this tangent", nothing more.

> ...
> But an even better solution is to get rid of passing the regflags
> field in grep_opt entirely, this conflicts with some of my later
> patches:

Yes, that may be a good direction to go in longer term, but let's
not push it before the other bits already in flight land safely.

> ...
> But as all this code cleanup isn't needed for fixing this bug, and I'd
> really like to get this series merged into next/master ASAP so I can
> start submitting the grep/pcre patches that are actually interesting,
> let's leave this orthogonal code cleanup for now.

Yes.  Thanks.
