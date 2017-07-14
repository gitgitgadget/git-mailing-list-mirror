Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B73120357
	for <e@80x24.org>; Fri, 14 Jul 2017 15:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754452AbdGNPOW (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 11:14:22 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34715 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754177AbdGNPOV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 11:14:21 -0400
Received: by mail-pf0-f169.google.com with SMTP id q85so46903003pfq.1
        for <git@vger.kernel.org>; Fri, 14 Jul 2017 08:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=sEkvj2FdUrRM8ECRL+UJjg8W6k+FLnEynPuaaky+9Dw=;
        b=DfrmyFxD4dH/5oh5BIaULeKl3DD+jRcyu9pDdvD5vb5oJLivwCanKliRVCytsi/ofg
         E+MuLAvvawel8my6qY8CGMd3iDm5flgTTMdxMm41Rcd2IOKPhYmCiy7/AWuf26oFLORU
         sin8HJRWocgv4aQxESqhXEbNxHJ9RLpm2ErIs6yQKgaxxwnGblxcyo3muLD66dvOOkqb
         0K2PFFXZULFsQ0UjUNZdLb6wR723K+vHT6kCBpOSYgwYH/5w7JGRsez0DTp23wbrayE1
         YX/Wdf1HBxcD3KwFhhxT+OsXVCTPcwIvOXGKVk+Z66zIg4Iyry+qq/BZZV/tw40Vs7JN
         yGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=sEkvj2FdUrRM8ECRL+UJjg8W6k+FLnEynPuaaky+9Dw=;
        b=jnh+fpXlztQeg8iTyffDuyKK7vM8HUFn5HHIcIdEBqbIfmPnaUlXC6RTHG56Kk56Y0
         P6GaFfJHCJLDJ6M5APYsIDJxPw6xjemPclvlAxWrt3fqoCmzlKmKYNxAbRyRruhfD9Dh
         M7MZ3M6IrmPp+6teH2NRvE45JJsATWy43NiYOmbi5zbYk+V04thHriTkx6Lpp6qNEjLF
         55k4g0YjtgAhO0vD/FeLLH6de/E2si2sU/z6/226s/Lqand2glza1Sz3eg3xrR2Yr5Fh
         hmS5ZDg2vq1NonN4iaS+BCHh3ekbRLtVzr41S+eLazpTvr4qUkopBuTgXZlTNW91fCdm
         WLOQ==
X-Gm-Message-State: AIVw110MBtGLeqhYOXRNKfcOgVdDinVbf8YxOS8Nk/d5Q21vz7ZXMwqL
        196toDN9Zn8XWsdMcKw=
X-Received: by 10.98.211.89 with SMTP id q86mr5850325pfg.37.1500045260781;
        Fri, 14 Jul 2017 08:14:20 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:d522:5f:8052:2b20])
        by smtp.gmail.com with ESMTPSA id k67sm17115000pfg.37.2017.07.14.08.14.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 14 Jul 2017 08:14:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix regression: CamelCased aliases
References: <cover.1500021526.git.johannes.schindelin@gmx.de>
        <20170714090256.ne4gqgppt2qshtak@sigill.intra.peff.net>
Date:   Fri, 14 Jul 2017 08:14:18 -0700
In-Reply-To: <20170714090256.ne4gqgppt2qshtak@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 14 Jul 2017 05:02:56 -0400")
Message-ID: <xmqq60evrqyd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Jul 14, 2017 at 10:39:24AM +0200, Johannes Schindelin wrote:
>
>> It was possible before v2.13.3 to invoke:
>> 
>> 	git config alias.CamelCased <something>
>> 	git CamelCased
>> 
>> This regressed (due to a stupid mistake of mine that was not caught in
>> patch review, sadly) in v2.13.3.
>
> Interesting. I don't think this was ever intended to work.
> ...
> The patches look obviously correct.

How can something be "(n)ever intended to work" and yet patches to
make it work be "obviously correct"? ;-)

My first/knee-jerk reation to the title of the series also was
"letter cases are not supposed to work in aliases", but that depends
on the definition of "work".  When you add 'alias.Foo', you are not
supposed to be able to make 'git foo' behave differently from that
alias you defined.  In order to make that, which is not supposed to
work, work, we'd need to introduce alias.Foo.commmand, as you said.

But I think that it is still reasonable for an end user to expect
that 'git Foo' would trigger that alias.  And that is what was
recently changed, inadvertently.

So the problem may need to be explained better in this series, but I
think the usage was expected to work and the series is fixing a real
regression.

Do we want to promise to keep the following "working"?

    git config alias.Foo <something>
    git foo

By designing the system in such a way that an alias is created with
a two-level name in our system, we are saying that alias names are
case insensitive to the end users, so I _think_ the above is
intended to work, and we are effectively promising that it will keep
working.

It is a different matter if that design decision was sensible,
though.

> As a meta-comment, I find splitting the tests from the fix like this
> makes review more tedious.

I agree.
