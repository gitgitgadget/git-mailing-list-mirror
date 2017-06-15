Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71C7820401
	for <e@80x24.org>; Thu, 15 Jun 2017 16:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751909AbdFOQaM (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 12:30:12 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38198 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750899AbdFOQaL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 12:30:11 -0400
Received: by mail-wm0-f45.google.com with SMTP id n195so4033296wmg.1
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 09:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=2q8jxR/hGSz3zX3p7Ow0p2AZHN6DACWmqGFOP5YEDw0=;
        b=L/I9C1DIbdAzD7ZbMpMyKIbV+j/31lveFjM/xC42kO6CMrx/z9crr0cWWclm/0sj1/
         YrhR+q02w+Aqf2yluLRMbjlSWEkWjT3DdKyQC+HkEjmVe2OqyK6Er3jEIDbLqBee1Hu1
         ofhSt2AUkxj29IWotj9WqoxUQo0umwmrqvEJFGr/dC4SuX1jNmSG/WUDu/O4XhenSNbx
         NEMhhhKgwBdgh7NvSEQAi8m6xKre6GOUd4HsWZu2E2vJTrskajuQWdm/JInJI22fbJtL
         BjiEY8EdGYP/GW/nFDkpgdIRoB4fPA7pk+PIjvTg7QCAcYdJ09AmioAnxdgbyEs7kOwp
         VnsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=2q8jxR/hGSz3zX3p7Ow0p2AZHN6DACWmqGFOP5YEDw0=;
        b=dgIT0nKgzY2VH3VyFh9il8efeTxpqmPpxeYYMf29H8V1hlPAe4fzyLDog8cktBmdPP
         WxIje8PYHBFCk1ua/zgjuyJ+Z/1QRL4dCxyiTR6mA9Th0V+EtTL4sUnnE1FY1ydQ00xT
         2xQGl2iy4ZvCIbp5dhFJjtBMZZm4ir/SizYYQWJGwcMBdlzxlUMQ8PnmXG0N+XOBOWyl
         u6blWY9M+S/ljrC64Y9WhB+Gxqj24PmbLEn6tIhWkjQx+YmrSFwp7bToiQ5DPsqyj2e9
         KKfq9BDtH/c09bHn8PZFO/XP8iLRz31Zi7DhDBI04dX7pnJw+Fos3qJySwIe7Lt9DJ/T
         N6zA==
X-Gm-Message-State: AKS2vOwfFi8xJ0nDQXGx80ebbWklJHkqs5/yRYTV7QZ+o8UWQt0PsnAE
        0WG1eLQNliiJzQ==
X-Received: by 10.80.148.129 with SMTP id s1mr4116218eda.106.1497544209659;
        Thu, 15 Jun 2017 09:30:09 -0700 (PDT)
Received: from snth ([92.109.130.42])
        by smtp.gmail.com with ESMTPSA id m53sm347618edc.29.2017.06.15.09.30.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Jun 2017 09:30:08 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dLXep-0002GS-Ov; Thu, 15 Jun 2017 18:30:07 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Mike Hommey <mh@glandium.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Brandon Williams <bmwill@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, jonathantanmy@google.com,
        Junio Hamano <gitster@pobox.com>
Subject: Re: Which hash function to use, was Re: RFC: Another proposed hash function transition plan
References: <20170304011251.GA26789@aiede.mtv.corp.google.com> <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com> <20170306002642.xlatomtcrhxwshzn@genre.crustytoothpaste.net> <20170306182423.GB183239@google.com> <alpine.DEB.2.21.1.1706151122180.4200@virtualbox> <20170615110518.ordr43idf2jluips@glandium.org> <20170615130145.stwbtict7q6oel7e@sigill.intra.peff.net>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20170615130145.stwbtict7q6oel7e@sigill.intra.peff.net>
Date:   Thu, 15 Jun 2017 18:30:07 +0200
Message-ID: <87shj1ciy8.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 15 2017, Jeff King jotted:

> On Thu, Jun 15, 2017 at 08:05:18PM +0900, Mike Hommey wrote:
>
>> On Thu, Jun 15, 2017 at 12:30:46PM +0200, Johannes Schindelin wrote:
>> > Footnote *1*: SHA-256, as all hash functions whose output is essentially
>> > the entire internal state, are susceptible to a so-called "length
>> > extension attack", where the hash of a secret+message can be used to
>> > generate the hash of secret+message+piggyback without knowing the secret.
>> > This is not the case for Git: only visible data are hashed. The type of
>> > attacks Git has to worry about is very different from the length extension
>> > attacks, and it is highly unlikely that that weakness of SHA-256 leads to,
>> > say, a collision attack.
>>
>> What do the experts think or SHA512/256, which completely removes the
>> concerns over length extension attack? (which I'd argue is better than
>> sweeping them under the carpet)
>
> I don't think it's sweeping them under the carpet. Git does not use the
> hash as a MAC, so length extension attacks aren't a thing (and even if
> we later wanted to use the same algorithm as a MAC, the HMAC
> construction is a well-studied technique for dealing with it).
>
> That said, SHA-512 is typically a little faster than SHA-256 on 64-bit
> platforms. I don't know if that will change with the advent of hardware
> instructions oriented towards SHA-256.

Quoting my own
CACBZZX7JRA2niwt9wsGAxnzS+gWS8hTUgzWm8NaY1gs87o8xVQ@mail.gmail.com sent
~2 weeks ago to the list:

    On Fri, Jun 2, 2017 at 7:54 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
    [...]
    > 4. When choosing a hash function, people may argue about performance.
    >    It would be useful for run some benchmarks for git (running
    >    the test suite, t/perf tests, etc) using a variety of hash
    >    functions as input to such a discussion.

    To the extent that such benchmarks matter, it seems prudent to heavily
    weigh them in favor of whatever seems to be likely to be the more
    common hash function going forward, since those are likely to get
    faster through future hardware acceleration.

    E.g. Intel announced Goldmont last year which according to one SHA-1
    implementation improved from 9.5 cycles per byte to 2.7 cpb[1]. They
    only have acceleration for SHA-1 and SHA-256[2]

    1. https://github.com/weidai11/cryptopp/issues/139#issuecomment-264283385

    2. https://en.wikipedia.org/wiki/Goldmont

Maybe someone else knows of better numbers / benchmarks, but such a
reduction in CBP likely makes it faster than SHA-512.
