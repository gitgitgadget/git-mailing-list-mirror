Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E7AB1F404
	for <e@80x24.org>; Tue, 28 Aug 2018 15:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbeH1Sy1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 14:54:27 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36683 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbeH1Sy1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 14:54:27 -0400
Received: by mail-wm0-f43.google.com with SMTP id j192-v6so2384913wmj.1
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 08:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Yt9pGA9Vrau2nFJ6hjlmZJ0XR1NX8uzBx0KjOLMwYcE=;
        b=BS0F0TkctlLXshxeOY89D5llcjSmNuVfNzESBI88cr9LAjJuGB5qIFTl/NVQZm1vKD
         acWqsoCSGr636fx2ICx/LW5BIWAqJcxw0244qgJFCX3X6Ih9rg7EYta2XChSMq9/85N8
         DzFgOVHdASjMxzDV1Km3/IzY7LAxqKXOL+OYB7/tBG87mVqI8o8yyK8ZoHejfK8KDAHy
         qekGHH1qICDNZlvnZXayrVIluUD0EnVNViMcanFBZovj+ARphUH4i8nlqKDBnswc8qe9
         jjGlKhgG2m8P45z/ajRqohBXCiiHZnY0mkQ+SofwQ2jF0jTq8GNFR4miq/Elb5T+36xP
         ilMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Yt9pGA9Vrau2nFJ6hjlmZJ0XR1NX8uzBx0KjOLMwYcE=;
        b=prWU8gRF0PqxqzjU+jt4mebQyK7fOYxAS7FiVG7cr8KCF6hMnK5EXdExuSKqvuUSyV
         mavxGGMlBdteCaSM2dOy7yOPebfIWxTJmBJbMXSqlX8/99U00PDXBFHxDNGPnWahGpwZ
         7dtQiHuKkLUcMJxRaUi+jpQ3Wc+AUSVkYqJOo3dQ2rQjsQGUf4CB4q6BYSDTmsTmlMo8
         uhme7fXVB+ojgOqSU10bxfd+YejH23LEZIeqJS5IOXaUMbg3Vd3HbtMevTMdeDoIpMfV
         yvljmIO5Usz7wBaCjWuSmsiVXm3yBda2yH1BmuSlVQQq6MUljs8gqgnk4UzG2DJc0Bt6
         V0Ww==
X-Gm-Message-State: APzg51AZFkj+Ncfx9Xk2QVdxKbFeKyjHv+LwjOC7X4rlVWmAZUxjjxoz
        D4xIXZa9HThVby3VdBXuNVo=
X-Google-Smtp-Source: ANB0VdYI2pOvIlhLiBift5o0epspUh2rMGS1ckUeUnyRlUyHuKVJpl6HR/u51NoQMlFxSwNreQ3Ldw==
X-Received: by 2002:a1c:1802:: with SMTP id 2-v6mr1587368wmy.81.1535468540011;
        Tue, 28 Aug 2018 08:02:20 -0700 (PDT)
Received: from evledraar ([5.57.21.50])
        by smtp.gmail.com with ESMTPSA id 34-v6sm1974744wra.20.2018.08.28.08.02.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 08:02:19 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Edward Thomson <ethomson@edwardthomson.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: Questions about the hash function transition
References: <878t4xfaes.fsf@evledraar.gmail.com> <87h8jeeh2e.fsf@evledraar.gmail.com> <CA+WKDT1k1SpHQmUKunV+vC+VLBfTBjZBgw+n4NeTE=oKxWL-Sg@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CA+WKDT1k1SpHQmUKunV+vC+VLBfTBjZBgw+n4NeTE=oKxWL-Sg@mail.gmail.com>
Date:   Tue, 28 Aug 2018 17:02:18 +0200
Message-ID: <87ftyyedqd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Aug 28 2018, Edward Thomson wrote:

> On Tue, Aug 28, 2018 at 2:50 PM, Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>> If we instead had something like clean/smudge filters:
>>
>>     [extensions]
>>         objectFilter = sha256-to-sha1
>>         compatObjectFormat = sha1
>>     [objectFilter "sha256-to-sha1"]
>>         clean  = ...
>>         smudge = ...
>>
>> We could apply arbitrary transformations on objects through filters
>> which would accept/return some simple format requesting them to
>> translate such-and-such objects, and would either return object
>> names/types under which to store them, or "nothing to do".
>
> If I'm understanding you correctly, then on the libgit2 side, I'm very much
> opposed to this proposal.  We never execute commands, nor do I want to start
> thinking that we can do so arbitrarily.  We run in environments where that's
> a non-starter

I'm being unclear. I'm suggesting that we slightly amend the syntax of
what we're proposing to put in the .git/config to leave the door open
for *optionally* doing arbitrary mappings.

It would still work exactly the same internally for the common
sha1<->sha256 case, i.e. neither git, libgit, jgit or anyone else would
need to shell out to anything.

They'd just pick up that common case and handle it internally, similar
to how e.g. the crlf filter (v.s. full clean/smudge support) works in
git & libgit2:
https://github.com/libgit2/libgit2/blob/master/tests/filter/crlf.c

So the sha256<->sha1 support would be an implicit built-in like crlf, it
would just leave the door open to having something like git-lfs.

Now what does that really mean? And I admit I may be missing something
here.

Unlike smudge/clean filters we're going to be constrained by having
hashes of length 20 or 32, locally & remotely, since we wouldn't want to
support arbitrary lengths, but with relatively small changes it'll allow
for changing just:

    # local  remote
    sha256<->sha1

To also support:

    # local  remote
    fn(sha1)<->fn(sha1)
    fn(sha1)<->fn(sha256)
    fn(sha256)<->fn(sha1)
    fn(sha256)<->fn(sha256)

Where fn() is some hook you'd provide to hook into the bits where we're
e.g. unpacking SHA-1 objects from the remote, and writing them locally
as SHA-256, except instead of (as we do by default) writing:

    SHA256_map(sha256(content)) = content

You'd write:

    SHA256_map(sha256(fn(content))) = fn(content)

Where fn() would need to be idempotent.

Now, why is this useful or worth considering? As noted in the E-Mail I
linked to it allows for some novel use cases for doing local to remote
object translation.

But really, I'm not suggesting that *that* is something we should
consider. *All* I'm saying is that given the experience of how we
started out with stuff like built-in "crlf", and then grew smudge/clean
filters, that it's worth considering what sort of .git/config key-value
pairs we'd pick that would yield themselves to such future extensions,
should that be something we deem to be a good idea in the future.

Because if we don't we've lost nothing, but if we do we'd need to
support two sets of config syntaxes to do those two related things.

> At present, in libgit2, users can provide their own mechanism for running
> clean/smudge filters.  But hash transformation / compatibility is going to
> be a crucial compatibility component.  So this is not something that we
> could simply opt out of or require users to implement themselves.

Indeed.
