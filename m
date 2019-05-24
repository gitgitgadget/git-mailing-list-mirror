Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C71981F462
	for <e@80x24.org>; Fri, 24 May 2019 10:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390106AbfEXKEb (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 06:04:31 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36571 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389745AbfEXKEb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 06:04:31 -0400
Received: by mail-wm1-f66.google.com with SMTP id v22so1347285wml.1
        for <git@vger.kernel.org>; Fri, 24 May 2019 03:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=+oRMGQUqmVuffMlgN6RBBLulwZinEt8GhLp9US8KLS8=;
        b=WvZblZIYrw8V9vQuRSyRRPQ4M16MA2Ym/nqZVbyigQ07ityt5ixDoygj1UEEP9xKEp
         fFIN/qT9ISnL4miPdBUsh5PAS4k5h/HsroLhOfLSZ5owGVDBa1ZjI13lrfYi8f7ue7M8
         RPMGGBrtITIeouGftJmfQD9W9FckEjvvgiUCnpkIpyr1CuiYX37J5dU+FR1ifv9VZZsy
         AYaJ2STKa0N1CocUY/RNAORuvYEPS/KMjI3r2ckB4j4mNwCD2hCzV4qoauIiK8xZDmNw
         E+0HqSyi3pqgV0w9JmWNs8tyqYsy2w4zvjvUp4fihXdnD4pdr6VvqQzf+DlJOrf5GlVa
         Huig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=+oRMGQUqmVuffMlgN6RBBLulwZinEt8GhLp9US8KLS8=;
        b=JFkbKLFO1NMDdovrmuJFLQ8d7DHkcZeUhByoxxEb+i2jAV8m+xsX9LVC56/cFlfItg
         43MzSRvhUtVN9TstfMbP5AR9gIubijZsg+zcVp9QofQAHP9mdZve19po0Wfy9M7JW3vP
         +kLTqM3TTL7X8o+pkoNwcFDgBonCfYTEX4d2cHLX1mUogiW1R7dZVKl5F0vrmoyPD3bv
         GyCmSDKQWormGzHS0V/Zqct23L2GH6LsyU6NzwFH1dU8w3pLTiCbATcER8r16R7NPTby
         OteOWgRftUkWJh/D+/u8jQeGNjO5FlrvZY4FCtCBR7TOsQ9l3Uu8vhtkbe5ivpQk68Ye
         x2Nw==
X-Gm-Message-State: APjAAAX8G/skcF2koTpyAlM9USN/rOWRvw7OzYdjZRC7l9ZvY3087lzF
        EGgNrUmFQ2VfQaDGNbjXorM=
X-Google-Smtp-Source: APXvYqxOh4wEbthjpn5ofD3n/+zKWwa87ujl2YLO7iXjgkpCwhIorsYVrJWM8o9o2CnWJdnu4t2RQw==
X-Received: by 2002:a1c:6c04:: with SMTP id h4mr8946831wmc.135.1558692268925;
        Fri, 24 May 2019 03:04:28 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (ekn89.neoplus.adsl.tpnet.pl. [83.21.181.89])
        by smtp.gmail.com with ESMTPSA id a9sm2113598wmh.5.2019.05.24.03.04.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 03:04:28 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Adam Roben <aroben@apple.com>,
        Bryan Larsen <bryan.larsen@gmail.com>,
        Matthias Urlichs <smurf@smurf.noris.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/3] hash-object doc: elaborate on -w and --literally promises
References: <20190520215312.10363-1-avarab@gmail.com>
        <20190520215312.10363-3-avarab@gmail.com>
        <20190522050839.GB29933@sigill.intra.peff.net>
Date:   Fri, 24 May 2019 12:04:27 +0200
In-Reply-To: <20190522050839.GB29933@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 22 May 2019 01:08:39 -0400")
Message-ID: <86woigp3ro.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:
> On Mon, May 20, 2019 at 11:53:11PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> Clarify the hash-object docs to explicitly note that the --literally
>> option guarantees that a loose object will be written, but that a
>> normal -w ("write") invocation doesn't.
>
> I had to double-check here: you mean that _when_ we are writing an
> object, "--literally" would always write loose, right?
>
>> At first I thought talking about "loose object" in the docs was a
>> mistake in 83115ac4a8 ("git-hash-object.txt: document --literally
>> option", 2015-05-04), but as is clear from 5ba9a93b39 ("hash-object:
>> add --literally option", 2014-09-11) this was intended all along.
>
> Hmm. After reading both of those, I do think it's mostly an
> implementation detail. I would not be at all surprised to find that the
> test suite relies on this (e.g., cleaning up with rm
> .git/objects/ab/cd1234). But I suspect we also rely on that for the
> non-literal case, too. ;)
>
> So I am on the fence. In some sense it doesn't hurt to document the
> behavior, but I'm not sure I would want to lock us in to any particular
> behavior, even for --literally. The intent of the option (as I recall)
> really is just "let us write whatever trash we want as an object,
> ignoring all quality checks".

I thik that this implemetation detail of `--literally` is here to stay;
how would you otherwise fix the issue if garbage object makes Git crash?

However, I would prefer to have options state _intent_; if there is
legitimate need for a tool that creates loose objects, it would be
better to have separate `--loose` option to `git hash-object` (which
would imply `-w`, otherwise it doesn't have sense).

>>  --literally::
>> -	Allow `--stdin` to hash any garbage into a loose object which might not
>> +	Allow for hashing arbitrary data which might not
>>  	otherwise pass standard object parsing or git-fsck checks. Useful for
>>  	stress-testing Git itself or reproducing characteristics of corrupt or
>> -	bogus objects encountered in the wild.
>> +	bogus objects encountered in the wild. When writing objects guarantees
>> +	that the written object will be a loose object, for ease of debugging.
>
> I had to read this last sentence a few times to parse it. Maybe a comma
> before guarantees would help? Or even:
>
>   When writing objects, this option guarantees that the written object
>   will be a loose object, for ease of debugging.

I agree that this reads better.

Regards,
--
Jakub Nar=C4=99bski
