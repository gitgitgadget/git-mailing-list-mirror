Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3050820248
	for <e@80x24.org>; Mon, 18 Mar 2019 22:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfCRWZG (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 18:25:06 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39462 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfCRWZF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 18:25:05 -0400
Received: by mail-ed1-f66.google.com with SMTP id p27so14920118edc.6
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 15:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=VuX0exx/PzjhHxdhqwNL6R1SmsccIVukImA0GgXLaVw=;
        b=LWSPZbVkgGNjg/OkPWrEYiGgg6tnp3C6Xp7PVIWISXmpQunBBAoVBGB4o/aVNXPmch
         KkGecr6ktc5S5pl4+8quUsIIPSv3TE/QuZYyuCVWFV0GAYhJ0UTzs5eqs+eW+QxJicQu
         gjOp8DQ8Kez5l1a3aiJFsXy9qrR1kbWeWXP1alDRL6HGVjiyoOmLmbw8HOReHzq1aIcn
         Xb6kkID8KxuUd+g2KoE17bNe6WW7eHs6tWNM9rvffwDgUkYTz88Dblrbwp6gGShWWWcc
         f22QP9VfAokFNA965YmZBhg6cY56WLM3B+Tuv3SmjmTZ/YhFDRXj6vkOxGmOF+THcpTO
         e4ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=VuX0exx/PzjhHxdhqwNL6R1SmsccIVukImA0GgXLaVw=;
        b=TgWUJik0sUWBbDBxeA5MSNZpU9tJALRXEVhBt6h/1T1ce36RP5irVgK6mFTFgv5d+Y
         6dqAxminEcv++lH9D4PoBg2KupgUYSFphsqWg9B1ki/QjO8gemHvLxBGs3gCbCsbG5GM
         SME1w37j//TpS0alsE6aQuTuFyzzBiOcEhkBEzg7MZUyM5w5K8avjoIPBoz+PrMNJlWJ
         KgRKOaBxl3EU48m7Kh/BOEBqusMv/iVTp3G4UaFTmHVXMBSP/fy7k7L0QMfk0R04+Rha
         faow50nc1lkLpIta2L+77AAgh75BMFeSZJgB++3x7bx82GbKqRGETYUZ3O0JZJV4heeJ
         kXpQ==
X-Gm-Message-State: APjAAAUDRTBN0tfWEyH4o6ljKMiNBHB9k77YWOrV3jLwyjAqG6RC2+7g
        QkX0t6Nffl1S/ZwXqTChmb4=
X-Google-Smtp-Source: APXvYqyPMQGKFZ4y3TVvI0WEwYIB1+KFlKdC7/4Gy2bSGuGxRUdPyQElIzvWeqgvOnfrDkSKYS1DLA==
X-Received: by 2002:a17:906:4bc8:: with SMTP id x8mr12036450ejv.114.1552947903904;
        Mon, 18 Mar 2019 15:25:03 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id 4sm117034ejr.30.2019.03.18.15.25.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 15:25:03 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Roberto Tyley <roberto.tyley@gmail.com>
Subject: Re: [RFC/PATCH] point pull requesters to Git Git Gadget
References: <20190312213246.GA6252@sigill.intra.peff.net> <xmqqsgvrfsrh.fsf@gitster-ct.c.googlers.com> <20190313193909.GB3400@sigill.intra.peff.net> <20190313201854.GA5530@sigill.intra.peff.net> <xmqqzhps6ghl.fsf@gitster-ct.c.googlers.com> <20190318211215.GB29661@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190318211215.GB29661@sigill.intra.peff.net>
Date:   Mon, 18 Mar 2019 23:25:02 +0100
Message-ID: <87h8bzes75.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 18 2019, Jeff King wrote:

> On Mon, Mar 18, 2019 at 11:52:54AM +0900, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>>
>> > Hmm. I guess it is still an issue in GGG. This thread has identical
>> > timestamps on patches 1 and 2 (and my server received them out of order
>> > by 2 seconds, so mutt orders them wrong):
>> >
>> >   https://public-inbox.org/git/pull.163.git.gitgitgadget@gmail.com/
>> >
>> > I do still think GGG has a more feasible path forward on this particular
>> > bug, though.
>>
>> If the MSA is rewriting the timestamp (but why?  Is the original
>> date "Wed, 13 Mar 2019 19:20:12 GMT" malformed or perhaps in the
>> future or something?), then there isn't much the sending program
>> can---'git send-email' would suffer from the same symptom.
>
> I think this statement from me is mid-way through my discovery of the
> actual issue. Yes, if the mail server is rewriting, the best we can do
> is put in an artificial sleep.
>
> It looks like GitGitGadget just uses normal SMTP to submit the messages.
> I wonder if normal people using gmail as their SMTP server for
> send-email also suffer from this. I've not ever noticed it, but I
> don't know how common that setup is.

It's the got-to setup for those of us using gmail & send-email. In
git-ml.git:

    $ git ls-files | wc -l
    371333
    $ git grep -l '^\s+by smtp.gmail.com with ESMTPSA id ' | wc -l
    35326

Roughly 1/2 of those are patches:

    $ git grep --no-line-number -h -C30 '^\s+by smtp.gmail.com with ESMTPSA id ' |grep "^Subject: \[" | wc -l
    14567
