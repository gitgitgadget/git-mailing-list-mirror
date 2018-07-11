Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABFF71F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 21:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733028AbeGKVat (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 17:30:49 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42672 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732356AbeGKVas (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 17:30:48 -0400
Received: by mail-ed1-f65.google.com with SMTP id g12-v6so20227110edi.9
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 14:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=DLdFsV1k7Z+p3Fb350ICMQkyPwSQFCgdGMvywfOZMXs=;
        b=ITWKC2LzRB3UrPTYpUkwmApBa1HxoACgeKZU8WRbKoOGRsmjP7N8l/njCf+xvNjIiL
         6FobYmZ0pAdRMW/1Q5D1OahdlWQ285v+whQbYQeeO9XnqAhS/DCm+lpoTrKOcHAEjNAL
         mOiWsTavT6Aj1LHaVmXqpO3ea8jyn9OTPWniYMORtqT2MZ9yoodkGhxbvk0mN+pEnOyN
         vMHUejwe7sNIqIBcOfV/y2cQlllvoetIZYk0Mh9C7vzMRX6bKo6La+wEZYTmtNxPXWie
         QkqQxjoIFF/ig6jXtQjDvKcrwpWDL4PDBOa4SWzxZOtJJOsKF0vFRPOUVzgqcxKln6rl
         HArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=DLdFsV1k7Z+p3Fb350ICMQkyPwSQFCgdGMvywfOZMXs=;
        b=AbKaaLVaqbfWsiIT2T8MM2+UIYhYv8zmiu9za0P3FMnNkBCSdalv9Bci4U/vLGtnqq
         Rg5EMjPv4g1xQJK+RzB28T2n25xtiXZ9YK73HeqJc0EGr1DjWWhdvk8FElLopSuKobLN
         zV+1kN8r3uHhw18yXB+dxq2rB1HX0aL0ENoSeQxG2MrH2mbl9+lGD5IDGvTbnBXcuCK3
         VputAT5kON89h4JXMh9wG+0Ee+TsLrhJprTv9zoDAjNlG0+sn+EYFsru1FU9M8aog9dq
         qCNNhjaXWNwj4MUJ8NFWhnZTlRMi7BoegamYZyAq46F0r85zGiUrXQJfpFKKc+wa0X9A
         LaHw==
X-Gm-Message-State: AOUpUlGx8XGj2orgYlcP2e6AHN7mFAZobagg8kszutWHGzJ7mwAIWUtk
        X9/XfL4cYQ1EbROMNd37nzU=
X-Google-Smtp-Source: AAOMgpctcI7xqVSIe+JsoWsQ4lYqXjFAUbb2qW1pOAbyE5GwuMAyAv7jgA5YgWQ5By1pDSwb7t7nfQ==
X-Received: by 2002:a50:8c02:: with SMTP id p2-v6mr229177edp.282.1531344271720;
        Wed, 11 Jul 2018 14:24:31 -0700 (PDT)
Received: from evledraar (h98111.upc-h.chello.nl. [62.194.98.111])
        by smtp.gmail.com with ESMTPSA id a5-v6sm10692222edr.47.2018.07.11.14.24.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 14:24:25 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH v2] Add 'human' date format
References: <alpine.LFD.2.21.999.1807071238410.18818@i7.lan> <alpine.LFD.2.21.999.1807071502260.18818@i7.lan>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <alpine.LFD.2.21.999.1807071502260.18818@i7.lan>
Date:   Wed, 11 Jul 2018 23:24:24 +0200
Message-ID: <87h8l5cvp3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jul 07 2018, Linus Torvalds wrote:

I really like where this is going in general. Having a "human" format
would be great.

> For really recent dates (same day), use the relative date stamp, while
> for old dates (year doesn't match), don't bother with time and timezone.
> [...]
> Once you're talking "last year" patches, you don't tend to care about time
> of day or timezone. So the longest date is basically "Thu Oct 19 16:00",
> because if you show the year (four characters), you don't show the time
> (five characters). And the timezone (five characters) is only shown if not
> showing the date (5-6 characters).

Just chiming in on this part, I think it's a worthwile trade-off to
always keep it relatively short, but I'd like to challenge the "you
don't tend to care about time [for really old commits]".

I think that's true for the likes of linux.git & git.git, but a lot of
users of git say work in some corporate setting entirely or mostly in
the same timezone.

In that case, knowing if some commit whose sole message was "fix"[1] was
made at 3am or in the afternoon, even if it's really old, is really
useful information, even years later.

Maybe something like v2 could be a human-lossy and v1 human-short (or
better names...). I.e. (AFAICT) v1 didn't lose any information, just
smartly abbreviated it, but v2 does.

1. Because let's face it, bothering to write good commit messages like
   git.git is the exception.
