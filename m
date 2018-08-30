Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF9521F404
	for <e@80x24.org>; Thu, 30 Aug 2018 12:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbeH3Qby (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 12:31:54 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:32873 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728713AbeH3Qbx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 12:31:53 -0400
Received: by mail-wm0-f50.google.com with SMTP id i134-v6so1726183wmf.0
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 05:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=02KcdmRZlleHMh2iDPco7MlkCqmHeT7KWPkfb6PuAv4=;
        b=m8UcLCHHcWwWtvsZyTPObsHbZw0UFXCTJDAupyLiU1SxW/LzJMRwd0E1cjvc4xVYvh
         peZWEVdl8A2I17kg2N+GrC4Qtr4Y3X5/aSiWsTfvM3ZH7TpVX0azzKSdq1CE1MQPJ78/
         5SqQ04h2Z1CJJa80aZ6DTua7BcThbCzG1QENl4oU5mlyfsbiNk2Xn0I6d9KV5wOr6S1E
         642I/7GsAW8ZcxxoI3i0d8sJezHBR7hmhMz+P2ZMgOPtPJBVrioo7JpQ/JAC7QOJkF8H
         A/loZn/HT7+WBdDXLmD9xjNmPnyVcotFgiB0InQNhMTOKqHvjg0tI1sNThdFKUuBd25k
         gYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=02KcdmRZlleHMh2iDPco7MlkCqmHeT7KWPkfb6PuAv4=;
        b=dYlmndPNtDd+xc4KjQzPbF64EN1XEYsNVRQT3qKeipCYaOJ/EFzhyAIYChTmSwdkDj
         rpu+7vgHaKMFY0MDV6LqUiNzk2ezPp1FoU5+Yl7Ot6oh8TbqZf6EcskSVwVIIEqaFJJl
         Iv5W69J/5yRpff9DjrLp1hRqsQMMW2vsv4mjS2GuwyFQx1rR3gR7POKsoZ70PKlPl4hn
         Na+dJ/TQ5dbgZtnQD9OUQec17n/7yO66/dGo6otK8RPAxZTuQvvCZt/SKyw5atCnJw3X
         0yL89vqklIsuyhwsfGLAXHs3l105puj9TZbMyThdPY+F2K/H+7o6CDuBKcuI49HDIz48
         mSBw==
X-Gm-Message-State: APzg51AC+MFV4posTurVZIRuYXepaTPgnObU/ZR/SLVD2SptpRGDoMeL
        BAYmENc5g3wGd72cZ/ts1lbdMR32
X-Google-Smtp-Source: ANB0VdZqrKeX6dwUxzl+mTzOjHEr2PE7u0n1A0Ck5tN0wKN0ZDYg+6pQTuzMd8y+XxZ4J1oS9CHRjw==
X-Received: by 2002:a1c:b984:: with SMTP id j126-v6mr1598568wmf.25.1535632197216;
        Thu, 30 Aug 2018 05:29:57 -0700 (PDT)
Received: from evledraar ([5.57.21.50])
        by smtp.gmail.com with ESMTPSA id w4-v6sm6731504wro.24.2018.08.30.05.29.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 05:29:56 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ulrich Gemkow <ulrich.gemkow@ikr.uni-stuttgart.de>,
        git@vger.kernel.org
Subject: Re: Trivial enhancement: All commands which require an author should accept --author
References: <201808282305.29407.ulrich.gemkow@ikr.uni-stuttgart.de> <nycvar.QRO.7.76.6.1808291653190.71@tvgsbejvaqbjf.bet> <xmqqpny1at28.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1808301350340.71@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <nycvar.QRO.7.76.6.1808301350340.71@tvgsbejvaqbjf.bet>
Date:   Thu, 30 Aug 2018 14:29:55 +0200
Message-ID: <87r2igca0s.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Aug 30 2018, Johannes Schindelin wrote:

> Hi Junio,
>
> On Wed, 29 Aug 2018, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>> > The `stash` command only incidentally requires that the author is set, as
>> > it calls `git commit` internally (which records the author). As stashes
>> > are intended to be local only, that author information was never meant to
>> > be a vital part of the `stash`.
>> >
>> > I could imagine that an even better enhancement request would ask for `git
>> > stash` to work even if `user.name` is not configured.
>>
>> This would make a good bite-sized microproject, worth marking it as
>> #leftoverbits unless somebody is already working on it ;-)
>
> Right.
>
> What is our currently-favored approach to this, again? Do we have a
> favorite wiki page to list those, or do we have a bug tracker for such
> mini-projects?
>
> Once I know, I will add this, with enough information to get anybody
> interested started.

I believe the "official" way, such as it is, is you just put
#leftoverbits in your E-Mail, then search the list archives,
e.g. https://public-inbox.org/git/?q=%23leftoverbits

So e.g. I've taken to putting this in my own E-Mails where I spot
something I'd like to note as a TODO that I (or someone else) could work
on later:
https://public-inbox.org/git/?q=%23leftoverbits+f%3Aavarab%40gmail.com
