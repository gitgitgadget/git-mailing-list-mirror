Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 589E51F453
	for <e@80x24.org>; Wed,  6 Feb 2019 17:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfBFRZB (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 12:25:01 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39805 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfBFRZA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 12:25:00 -0500
Received: by mail-wr1-f65.google.com with SMTP id t27so8482365wra.6
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 09:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6TofWLLzIdaJLVjZwriwS1yqZ0/yF8EmccGuBscWQeM=;
        b=jGzrBZJNllC/e0BKl5lWhTZZ4wmRuCPCz3tAgzv2JUHwbYrKksG7Bu6aFNSpdxEYIj
         DAqL5BMDDoBp6xTuc3MyBIn/rnY8+uiptRyjnQjkxllKhRIoxzpEqK3nvtTVrCi0+SN9
         4T+/6SjToZQfA913umL42grhh8+7zKav29Dlq38PKwOCHLFtck5zBIb8jVmoRpXaIaOG
         VUQwsAJ1fqRHCPQMM632pchFnsQ1VphZg9CTdi3JEdckcJp/K1jG1uiYmazG2BKPpu+9
         SqO5lp7g0zpTUg6gBZmxbc26Yy7e6yLXIQxEvBHYUzy6bc7SR6QP0i7y07DAa0D49p8L
         RtSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6TofWLLzIdaJLVjZwriwS1yqZ0/yF8EmccGuBscWQeM=;
        b=l6GlnLn3AGmc+QMvbMTeCXKZfR9nfgKsEjsmXpaDFJeg1KmMv3FJDuYf1hCC4YJG62
         +Ke5IvF3N0IipeZL3nbvaIR2P1Pob2JugBE/3yImdTaHS1GQIdF+KWBRgRq02xjNy247
         uSeyjik7++OiUdv0J/6ZsTKOsJOgULk5CLQLmwgBRX+QpGDWBuIFhufC5EZYL0HPCj/4
         j30aiaxGyaxN0Q+912mtQVC4zMRckXAfw0BxhGkSEQv4YJ/aEG3umbGSSJWHWks8gUMT
         mg82eKVQPI/kYhSvrnCIPzXGy3OEHTUtmy/IhiS20TWgepsc31GkcuxARPErOTb6cGDg
         /aMA==
X-Gm-Message-State: AHQUAuaCradW5DHJllyxah/bFFjzLk8X5hTG6XVihQhcYN96fX9ngESm
        6Gu70wLcza0ksZz16gq9mUA=
X-Google-Smtp-Source: AHgI3IZQGKQ6uoga87U4plvAH32rsNCRqk5Z9FL9+EojerCyKOkrHUtKTr3llESfF0B/el80VhM5BQ==
X-Received: by 2002:a5d:4bc7:: with SMTP id l7mr8577752wrt.242.1549473898679;
        Wed, 06 Feb 2019 09:24:58 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q14sm18242425wrw.39.2019.02.06.09.24.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 09:24:57 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] doc-diff: don't `cd_to_toplevel`
References: <20190203230152.GA25608@sigill.intra.peff.net>
        <20190204205037.32143-1-martin.agren@gmail.com>
        <20190204233444.GC2366@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1902051050090.41@tvgsbejvaqbjf.bet>
        <xmqqimxyrs4w.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1902061303570.41@tvgsbejvaqbjf.bet>
Date:   Wed, 06 Feb 2019 09:24:57 -0800
In-Reply-To: <nycvar.QRO.7.76.6.1902061303570.41@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 6 Feb 2019 13:20:47 +0100 (STD)")
Message-ID: <xmqqsgx0rfrq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> For a topic like doc-diff that is primarily meant for developers and
>> documenters, it does not matter much, but for an old but important bug,
>> forking the topic to fix it at a point close to the origin is
>> crucial---that is what would allow people to merge the fix to an older
>> maintenance track, without cherry-picking.  It is especially true when
>> the bug being fixed is more severe than unrelated breakages that have
>> been fixed since then.
>
> As I said, I understand your reasoning.

When I am following-up to the mailing list, not replying directly
and solely to you, I may write things that I know you already know
to help others reading from sidelines.  Just saying I agree, without
sounding as if saying "you do not have to say that", would be better.

>>  - Perhaps find the fork point, run tests to find known breakages
>>    and exclude them?  This would simply be not practical, as it
>>    doubles the number of tests run, for individual topic branches
>>    because there are an order of magnitude more of them than the
>>    primary integration branches.
>
> I saw another strategy in action: accept the base commit chosen by the
> contributor, and ask to back-port it to previous, still supported versions
> (unless an automated rebase managed to back-port already).

It sounds more like "notice the base commit chosen by the
contributor, reject the series and ask to rebase on a fork point of
my choice".  That's not all that different from "notice the base
commit chosen by the contributor, rebase on a more sensible fork
point myself, and double-check the result by merging it to the base
commit chosen by the contributor and make sure there is no
unmanageable conflict".
