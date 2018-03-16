Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F93B1F404
	for <e@80x24.org>; Fri, 16 Mar 2018 23:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752249AbeCPXAc (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 19:00:32 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:33986 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750915AbeCPXAa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 19:00:30 -0400
Received: by mail-wm0-f44.google.com with SMTP id a20so4620929wmd.1
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 16:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=0L6x0P1Qlxrw1/RJA0In4gDKpEEeDeG1Fyulk4rpKKg=;
        b=taIgwp2qEhjR3HSa6U9vzjug4dvF4jeCnoyn1ljZQFpVZ37rkIug0xfo5lXv+agBeN
         NzS4ywv/gYmO+UI6MxEBVO2HfnYwhDMyQjOiayuY7ThGx1//mMQ1cva9LeCkRYqZ7Je5
         LCrbgzuJm9Rlz2D+P1TdG0uc+V7qw74OFwYKFZNfZ23+6sze0HtfiSeKMlfTNF2ZIinm
         6mzfJVX5L3BcwEkmxfk2buvovPBcSbCFV+X7I0cOdfMsp3mGZS8gOSvTYDQiPXchXSWG
         PnBht+XrPq1ivbsw/RYJs+S43oM9Hbh8bxRO9kzy9qc4ALo58yHJ/nM2kTi62criFoR1
         aGyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=0L6x0P1Qlxrw1/RJA0In4gDKpEEeDeG1Fyulk4rpKKg=;
        b=XMiA5tB89GdixwUulJjfC3suJdkByqx6sZMRHyc+H5emyJSlL1Kt7UCvXdqSgxkQJk
         6SBO6LPMW83c5p2XCCcfoCmnuxtLSBRT5PPr+mEGEdi5slf7xgf42MO73FVbQL4anGgI
         +BwwLtT+jH8w3vym9t9ZGdaVlf1vOoNVqQtusNMk1ioABhyfAlsL0oG1Fb9DMW+fUl61
         N8HN1J4GNsGCuxpR8k2JQ9DsyIC38SnHsuIu/nDubXKxS4iVlzQJvE7QiXjPW0ymKU75
         8Y1jqrQdeHT4lAsqUZMHqxvWR/n9EslBiRw519p6TtHTzuLaCEynoqQH/riTUqEU6vFs
         AZkQ==
X-Gm-Message-State: AElRT7HpMgZ2pbCDm7X6fFs9VeBzkMbG4OPdxTV24RpFV0Rhz1Ir9ZX3
        XFmsxnn9mgETHjbe8m9JHff2+Fkj
X-Google-Smtp-Source: AG47ELuYVPJLbRjI8Mt5Kfpy2GM+rAJXA9aM4/gtDOpqbb+MGA5OHs3XuFsS5gx+Rp5U+jpvjiCVOA==
X-Received: by 10.28.74.16 with SMTP id x16mr2948189wma.36.1521241229556;
        Fri, 16 Mar 2018 16:00:29 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id x17sm9801897wrg.32.2018.03.16.16.00.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Mar 2018 16:00:27 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@jeffhostetler.com, git@vger.kernel.org, gitster@pobox.com,
        lars.schneider@autodesk.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 0/2] routines to generate JSON data
References: <20180316194057.77513-1-git@jeffhostetler.com> <20180316211837.GB12333@sigill.intra.peff.net>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180316211837.GB12333@sigill.intra.peff.net>
Date:   Sat, 17 Mar 2018 00:00:26 +0100
Message-ID: <87tvtfd3sl.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 16 2018, Jeff King jotted:

> I really like the idea of being able to send our machine-readable output
> in some "standard" syntax for which people may already have parsers. But
> one big hangup with JSON is that it assumes all strings are UTF-8.

FWIW It's not UTF-8 but "Unicode characters", i.e. any Unicode encoding
is valid, not that it changes anything you're pointing out, but people
on Win32 could use UTF-16 as-is if their filenames were in that format.

I'm just going to use UTF-8 synonymously with "Unicode encoding" for the
rest of this mail...

> Some possible solutions I can think of:
>
>   1. Ignore the UTF-8 requirement, making a JSON-like output (which I
>      think is what your patches do). I'm not sure what problems this
>      might cause on the parsing side.

Maybe some JSON parsers are more permissive, but they'll commonly just
die on non-Unicode (usually UTF-8) input, e.g.:

    $ (echo -n '{"str ": "'; head -c 3 /dev/urandom ; echo -n '"}') | perl -0666 -MJSON::XS -wE 'say decode_json(<>)->{str}'
    malformed UTF-8 character in JSON string, at character offset 10 (before "\x{fffd}e\x{fffd}"}") at -e line 1, <> chunk 1.

>   2. Specially encode non-UTF-8 bits. I'm not familiar enough with JSON
>      to know the options here, but my understanding is that numeric
>      escapes are just for inserting unicode code points. _Can_ you
>      actually transport arbitrary binary data across JSON without
>      base64-encoding it (yech)?

There's no way to transfer binary data in JSON without it being shoved
into a UTF-8 encoding, so you'd need to know on the other side that
such-and-such a field has binary in it, i.e. you'll need to invent your
own schema.

E.g.:

    head -c 10 /dev/urandom | perl -MDevel::Peek -MJSON::XS -wE 'my $in = <STDIN>; my $roundtrip = decode_json(encode_json({str => $in}))->{str}; utf8::decode($roundtrip) if $ARGV[0]; say Dump [$in, $roundtrip]' 0

You can tweak that trailing "0" to "1" to toggle the ad-hoc schema,
i.e. after we decode the JSON we go and manually UTF-8 decode it to get
back at the same binary data, otherwise we end up with an UTF-8 escaped
version of what we put in.

>   3. Some other similar format. YAML comes to mind. Last time I looked
>      (quite a while ago), it seemed insanely complex, but I think you
>      could implement only a reasonable subset. OTOH, I think the tools
>      ecosystem for parsing JSON (e.g., jq) is much better.

The lack of fast schema-less formats that supported arrays, hashes
etc. and didn't suck when it came to mixed binary/UTF-8 led us to
implementing our own at work: https://github.com/Sereal/Sereal

I think for git's use-case we're probably best off with JSON. It's going
to work almost all of the time, and when it doesn't it's going to be on
someone's weird non-UTF-8 repo, and those people are probably used to
dealing with crap because of that anyway and can just manually decode
their thing after it gets double-encoded.

That sucks, but given that we'll be using this either for just ASCII
(telemetry) or UTF-8 most of the time, and that realistically other
formats either suck more or aren't nearly as ubiquitous...
