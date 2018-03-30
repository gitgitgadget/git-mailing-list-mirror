Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1360E1F404
	for <e@80x24.org>; Fri, 30 Mar 2018 18:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752374AbeC3S60 (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 14:58:26 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:38086 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752121AbeC3S60 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 14:58:26 -0400
Received: by mail-wr0-f173.google.com with SMTP id m13so8704643wrj.5
        for <git@vger.kernel.org>; Fri, 30 Mar 2018 11:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=U8Jq8P0mXO6UUNGGE50R6WrBGloKNoB4zcObZw81fiU=;
        b=n3fzV4F0qcjmFcXoqoGUCY1JsZwr+sX/VQEYaWPyPtVBMhHEvGs9qJR2QzoosXUpHg
         D0gGQpCHTe7y/2kzA/KwIPVW8d+HDqaKLLYcm2VnhTBxOP4vwCWEPC2S75PZwqtEw4aA
         sRNYfz/7MiFp2HF+v0rgyRhVnwDgiNMT9cUWDj5+ntZmtQqlTJko0JPOHuyv5/ndwsAC
         Jz2pQ7j6VSh7MDZbaSrSzIzc8RRrqr41R6CF9NIUN47VgQ4fzyr9gkGEnNhICI0KA/+1
         tqwGCgVO0qGEzNUs56kCqARz9LhhjqRwu9+K6VpXch+lPQHDpsX7Hh9xFm67sPhGvVrr
         YXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=U8Jq8P0mXO6UUNGGE50R6WrBGloKNoB4zcObZw81fiU=;
        b=Sxcf0jRnnqbBUnKRv9ACB8t2xBFZhDNRG0A69tvDKv7khB+TWw73GsGmNvAz1xorj4
         tJDlzLQzxX5zs+fi96JPLUASmvnwBlgKiMf3v90LkBxqT0dp1AA1bsRr/HhtxUa5d4OG
         IxZz9NC6wUpZTnfLW051XPH7aPR49PrNBB7xYWugY9Yb2uSpsonF3wB8/gFZJhhIC97t
         InYat1p8jDNS4GwEFxyZmpxk/IeMq4bHLZzUJj7IgaXSa7aRpu0WcTP1FxG+bTvdfk5q
         7IOH9vyKn2DnYMosnUYeSwJRY4usqvQNG7Ul+ZnpuziqD8+u5yzmjZ5Y0pxV/ivVPDYV
         we1g==
X-Gm-Message-State: AElRT7H4WVT0tUEqbS6DGldjJxyXXOxpZ+4s8wxdceBmKcN0dkJlvpHh
        3Etel/NqsFX8019JwZx4gIA=
X-Google-Smtp-Source: AIpwx4/WKM7020hzJowXSvsXpR0ZuNegQ5IW6T9tfMap0L1OFlDk7msO8jzsO9HNYlIO+5Tjxf/EzQ==
X-Received: by 10.223.128.227 with SMTP id 90mr97253wrl.1.1522436304563;
        Fri, 30 Mar 2018 11:58:24 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 90sm11884491wrl.10.2018.03.30.11.58.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Mar 2018 11:58:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        git <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
        Phil Haack <haacked@gmail.com>, Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: A potential approach to making tests faster on Windows
References: <cover.1522336130.git.johannes.schindelin@gmx.de>
        <899ea23951627426ccd0aac79f824af386c5590c.1522336130.git.johannes.schindelin@gmx.de>
        <CAGZ79kapTWGsYznt7rr0QTNX+uH85TPY8AOA1jtDJ6_q8edX1Q@mail.gmail.com>
        <20180329194159.GB2939@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1803301415240.5026@qfpub.tvgsbejvaqbjf.bet>
        <87fu4hwgfa.fsf@evledraar.gmail.com>
Date:   Fri, 30 Mar 2018 11:58:23 -0700
In-Reply-To: <87fu4hwgfa.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 30 Mar 2018 20:45:45 +0200")
Message-ID: <xmqqk1tt2xww.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Fri, Mar 30 2018, Johannes Schindelin wrote [expressing frustrations
> about Windows test suite slowness]:
>
> I've wondered for a while whether it wouldn't be a viable approach to
> make something like an interpreter for our test suite to get around this
> problem, i.e. much of it's very repetitive and just using a few shell
> functions we've defined, what if we had C equivalents of those?
> ...
>
> I don't have time or interest to work on this now, but thought it was
> interesting to share. This assumes that something in shellscript like:
>
>     while echo foo; do echo bar; done
>
> Is no slower on Windows than *nix, since it's purely using built-ins, as
> opposed to something that would shell out.

That's interesting; it certainly is appreciated to be constructive
to find a usable solution.

