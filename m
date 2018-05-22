Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 207631F51C
	for <e@80x24.org>; Tue, 22 May 2018 02:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751719AbeEVCI4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 22:08:56 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52092 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751271AbeEVCIz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 22:08:55 -0400
Received: by mail-wm0-f67.google.com with SMTP id j4-v6so28364421wme.1
        for <git@vger.kernel.org>; Mon, 21 May 2018 19:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Zx3No3Jdp8MVD9nZGTluScw3uMCdP5M2A3NiMaGSjcI=;
        b=iE/UnB1uql3C4TCv2r4aAX/dgEog1zBGzaqpj3zkRnZ5QfXPcdp7s+jIZfUdMid4F5
         ANgNCiP79XTzQzsjMKERm45ShsyySFI8Rx4miGnE90W+MDLOOYgaGpjvRiD0w9E5fZX+
         8VHDRGKjoPcvQ1ulo4mqU4KLEKdYrWFhNOkYQpj9xhqvC82SQy1+qhxf+Tw0MAO0XLTg
         S/UzEpgFOOEFPOqyOXu65Ejb5Z3znxoo+7ncTtzKLJLANxZzaG4KFPZNAy0rVVNg4B85
         x8pl91Ac94NMHCJyKJWVPsTQ7M0JppmMU69uhChfKrN/IiF+XbT+1+4rgPcWX8Ig09ol
         fNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Zx3No3Jdp8MVD9nZGTluScw3uMCdP5M2A3NiMaGSjcI=;
        b=Q3KO0w2SPtvDLWuOB4Y3qhS2dhJttW6BQy8ffTQp4D3htZEkgtNiAlmNsc56YR/ZxE
         E9wYIm/NWaGj+hQFKjtzEFoqETQsIdqIr0snfHMNhZaoYebxVEDc5B+Vf8Dmx8YUhvxh
         jbciLfZN9Xz1s027SzbgwzgM1JDdV7fEKo2YsIlFrosI4ILKpMhKjDaIdz+NkDakBVYl
         6Al5wrAL5kLAZjb14S7WsEcTqnt1nijR5ICAlxyeQfbTck/8p/jRR0ETHn75qh5+58FX
         NEH9nfBnO3z0YJ9ENJehvuTMPa2efIyHStqNCMKTtAV/M66hIgGC1P1D45NAM3Z9z6Aq
         YWiA==
X-Gm-Message-State: ALKqPwdfoj9mR4hsYpR3nljT0J42EeKxKdD6pbKTS77VJfBJTYgd9SQw
        6FH9ZI9RF1CICyuP7yiwmxA=
X-Google-Smtp-Source: AB8JxZozA1RywZBhdH7Wgb+PpIIpNDKU/sq/R3uqNNK660wMWYd73w/2DAYHb8QnGhInT9bs1fY0aA==
X-Received: by 2002:a1c:618b:: with SMTP id v133-v6mr638658wmb.75.1526954933631;
        Mon, 21 May 2018 19:08:53 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id r200-v6sm19304410wmb.39.2018.05.21.19.08.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 May 2018 19:08:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v2 02/18] Add a new builtin: branch-diff
References: <xmqqk1shsecd.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1805061419530.77@tvgsbejvaqbjf.bet>
        <CAPig+cS0pvdg78fGUu8m2xspDDMHxi=uAMCkbLuthy7R4p3fQw@mail.gmail.com>
        <nycvar.QRO.7.76.6.1805062155120.77@tvgsbejvaqbjf.bet>
        <20180507074843.GC31170@sigill.intra.peff.net>
        <3cefc6b3-3dbd-9cb1-20d0-193116191726@gmail.com>
        <nycvar.QRO.7.76.6.1805211153370.77@tvgsbejvaqbjf.bet>
        <CAGZ79kYcWuVorfk7eYjUuLi2XeMS8sPrJYE0OQmgiQi2NkuDZA@mail.gmail.com>
        <20180521202414.GA14250@sigill.intra.peff.net>
        <20180521214057.GB125693@google.com>
        <20180521215216.GB16623@sigill.intra.peff.net>
Date:   Tue, 22 May 2018 11:08:52 +0900
In-Reply-To: <20180521215216.GB16623@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 21 May 2018 17:52:16 -0400")
Message-ID: <xmqqin7gzbkb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> I haven't really been following all of the discussion but from what I
>> can tell the point of this command is to generate a diff based on two
>> different versions of a series, so why not call it 'series-diff'? :)
>
> That's OK with me, though I prefer "range" as I think we use that term
> elsewhere ("series" is usually part of "patch series", but many people
> do not use a workflow with that term).

FWIW, I am OK with either, with a bit of preference to "range" over
"series".  As long as this stays to be an independent command (as
opposed to be made into a new mode to existing command) and the
command name is not overly hard to type, I am OK with anything ;-)
