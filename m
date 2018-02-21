Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B71FC1FAE2
	for <e@80x24.org>; Wed, 21 Feb 2018 16:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938655AbeBUQxW (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 11:53:22 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41137 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753335AbeBUQxT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 11:53:19 -0500
Received: by mail-wr0-f195.google.com with SMTP id f14so6367926wre.8
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 08:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=GF/dPtkXpCGHm6MleRFmg48sN0KXXfCFw9GBfoz3ykE=;
        b=htPXFhbyFCrrTlKbzozzvJhEiCgX3DmiidoXYlROkJ+n/N+wYiOE4Abcr1e9EHBGbJ
         ULuy/0Tp+Jmp7zZi2SdHxEPc1/BXPt3GtDB5YIVzljfKQPgc1/vLeAD/0eGXhLdUfiJG
         +ppXn38vd0Y+4C//9uSZKwcTHx7M74eLIS4LXyL2gzqwEjSuFkZvwO9Au1++D40EMHXR
         hjMks/F5hb1b0k82y5Mfu/T06UJJuYH76bVgmPGJ2J4NAQPnrfUnkEswz2Fl87LTEa1A
         whH9WCi4fL1E+J+cR5DwaoMXBRjF7etk69UINJ/YcifiLPHu6bMJNbbDrzpfY+Z+1NRw
         wTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=GF/dPtkXpCGHm6MleRFmg48sN0KXXfCFw9GBfoz3ykE=;
        b=axfXce78hYqZiWnumTEmOl3IcNtXMPw8M/kuUaHaEHtu7Cu32a4VKLjg4kGTiMFvd3
         t8duAOcmAqR+4701ZINcCRCtE4bNDOF9JU002t7MpumKWWyT/MCBwNg8LOElTY9tbgvh
         0RccyofM6vCvs76WS/cfeWNrMB+WnIuE8GFMMZBCkhFR2ygH86MPPfoPUKIs+YmxckAU
         iH4nB9zAyNWgj5R2ioh93H33DSFyNhwtD3/by0/Af2FGfyoKl523cB46rOBRVH/IsIDb
         16ySNLs26nwAi2VVkXln9NatA0Cc0HyYlSinFyzQVjZ8cwis436YAwmvmJpc3GbPOUh2
         Pf9w==
X-Gm-Message-State: APf1xPBdWqtgUzIIgWxstrguTYXN13AcXfVbk9cQhE3ZLHN+es8QYqUj
        i1b3N71CgE8XIGkhUMtTJ7M=
X-Google-Smtp-Source: AH8x226XTgNF95nXSh1MVhyqd+T2DvKAbNYQkrW5j6V5mF0BvdhbyjSqG2bmjpYxm6rzVZKgfQfyjw==
X-Received: by 10.223.135.17 with SMTP id a17mr3693031wra.126.1519231997733;
        Wed, 21 Feb 2018 08:53:17 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g52sm3028870wra.20.2018.02.21.08.53.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 08:53:17 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] t/known-leaky: add list of known-leaky test scripts
References: <xmqqo9kro4oq.fsf@gitster-ct.c.googlers.com>
        <20180214215637.6462-1-martin.agren@gmail.com>
        <20180219212937.GB9748@sigill.intra.peff.net>
        <CAN0heSoDJdA3tTVZZ=imj8+z5FeqKy00dA2kWP4CAC4=+7VBiw@mail.gmail.com>
Date:   Wed, 21 Feb 2018 08:53:16 -0800
In-Reply-To: <CAN0heSoDJdA3tTVZZ=imj8+z5FeqKy00dA2kWP4CAC4=+7VBiw@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Tue, 20 Feb 2018 21:44:51
 +0100")
Message-ID: <xmqqa7w21dz7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Ågren <martin.agren@gmail.com> writes:

> On 19 February 2018 at 22:29, Jeff King <peff@peff.net> wrote:
> ...
>> Or alternatively, we could just not bother with checking this into the
>> repository, and it becomes a local thing for people interested in
>> leak-testing. What's the value in having a shared known-leaky list,
>> especially if we don't expect most people to run it.
>
> This sums up my feeling about this.

Even though keeping track of list of known-leaky tests may not be so
interesting, we can still salvage useful pieces from the discussion
and make them available to developers, e.g.  something like

    prove --dry --state=failed |
    perl -lne '/^(t[0-9]{4})-.*\.sh$/ and print $1' | sort >$@+
    if cmp >/dev/null $@ $@+; then rm $@+; else mv $@+ $@; fi

could be made into a target to stash away the list of failing tests
after a test run?

