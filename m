Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F51B1F453
	for <e@80x24.org>; Wed, 20 Feb 2019 10:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfBTKrE (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Feb 2019 05:47:04 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36481 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbfBTKrE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Feb 2019 05:47:04 -0500
Received: by mail-wm1-f68.google.com with SMTP id j125so5928455wmj.1
        for <git@vger.kernel.org>; Wed, 20 Feb 2019 02:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=JNmQhUEr6rQHAxCyJZ/TgSoRRe8nq2QF6V6nM6Up/u4=;
        b=D3ORamvvgrhjhF3yTAD8EwVkslINKF1A+lSJHxKAAoQkM5iMzpVN8as29vykfo4HD6
         6b1QH3EFLTIW/huQzbrKx3bybxY6MRxWm7w7AGjIYIunREgs5Qe31y0KbV7oJ5y0Y7a/
         0k7817zy5UDQKQ50L5NhfNPOTmUBaRg2z2unm1d1pFNgXnnMow3QZkVl2SlEGvmJfUTo
         MRPSnXQMRvJxEp7HsHIcGlS6IebAyxMqOamnY8/KwR/W8TCvoJ6VGpACatRi4u1UyI9S
         xtRghGMc9T3zaQOnTsFNy05ZbJm8AqlhL1iF+SLerdBJMbfWaan32iYvXnANhlapU+uH
         eRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=JNmQhUEr6rQHAxCyJZ/TgSoRRe8nq2QF6V6nM6Up/u4=;
        b=LP9pakKgrSYFWyGgwUpnv6sCimlk2IVuNBEoAkTpPvP2d5OajE1akFeMRbKB7zpQ6W
         1VdquF0COvaSC2uG2jKnT2NHDok+fJidAyxEo9g9CQrnz7BdwVdsaYbMJaN/vpzLCU5g
         G+E5u0APWe9lAA2iDsctLoywL7mI/wVIiCANTuqF+Hv/HNV/gJRkVYS3oJNAUhoa8s8L
         D2lk4tiwBklOidlDQ62D2knowAjxb6JBxmwpBKHZypoi21kOMc3owFlFaCTp3tRHUMKY
         S0w9vr8fSrgAwR16W+CjAMYGKF63/5GaKvugC6UrY1lCVfYgb14B3tmGLR9aG7FJ9Fog
         cGEw==
X-Gm-Message-State: AHQUAubJylGIgbxYnTFQrAesuT+ekmbSn0LND2KjNCCibhOsrKsrUCHy
        vv9J8kX5GBPExhveXqo+WCg=
X-Google-Smtp-Source: AHgI3IZXWaYMWTUpp8ANi2zc1fr5yPkh32m3WSXrBEVxXYsjejR8mHqXfMG62Vi0D338t/tPaaK6/w==
X-Received: by 2002:a1c:be09:: with SMTP id o9mr6111672wmf.3.1550659620423;
        Wed, 20 Feb 2019 02:47:00 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id j1sm3636457wme.4.2019.02.20.02.46.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 02:46:58 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Per Lundberg <per.lundberg@hibox.tv>,
        Steffen Jost <jost@tcs.ifi.lmu.de>,
        Joshua Jensen <jjensen@workspacewhiz.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Clemens Buchacher <drizzd@gmx.net>,
        Holger Hellmuth <hellmuth@ira.uka.de>,
        Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH 1/1] Introduce "precious" file concept
References: <20190216114938.18843-1-pclouds@gmail.com>
        <20190216114938.18843-2-pclouds@gmail.com>
        <87wolzo7a1.fsf@evledraar.gmail.com>
        <CACsJy8CR7VGp7htC_wKC9BUCaQsmkp5Zd4+M7bddPL-jKyfDMQ@mail.gmail.com>
        <xmqq8syb3b3j.fsf@gitster-ct.c.googlers.com>
        <87h8cy6cme.fsf@evledraar.booking.com>
        <CACsJy8B15hORnaOdYW8TNE3Gniv9NBJopyLYmHR5iF0U3beq6g@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <CACsJy8B15hORnaOdYW8TNE3Gniv9NBJopyLYmHR5iF0U3beq6g@mail.gmail.com>
Date:   Wed, 20 Feb 2019 11:46:57 +0100
Message-ID: <87ftsi68ke.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 20 2019, Duy Nguyen wrote:

> On Wed, Feb 20, 2019 at 4:19 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> > I personally do not believe in "backup log"; if we can screw up and
>> > can fail to stop an operation that must avoid losing info, then we
>> > can screw up the same way and fail to design and implement "backup"
>> > to save info before an operation loses it.
>>
>> Yes, there could be some unforseen interaction between git commands
>> where we should have such a backup log, but did not think to implement
>> it. I'd hope such cases would be reported, and we could fix them.
>>
>> But those sorts of cases aren't why we started discussing this, rather
>> we *know* what the data shredding command interaction is, but there
>> wasn't a consensus for just not shredding data by default by making
>> users use "checkout -f" or "merge -f" to proceed. I.e. taking some
>> variant of my "trashable" patch[1].
>>
>> > If we do a good job in
>> > supporting "precious" in various operations, we can rely less on
>> > "backup log" and still be safe ;-)
>>
>> Is noted in previous discussions[2] I think that's entirely
>> implausible. I think at best the "precious" facility will be used to
>> mark e.g *.o files as "don't check in, but don't clean (Makefile handles
>> it)".
>>
>> Most git users are at the level of only knowing very basic
>> add/commit/pull/push command interaction. I feel strongly that we need
>> to make our tools safe to use by default, and not require some
>> relatively advanced "precious"/attribute facility to be carefully
>> configured in advance so we don't throw away uncommitted work on the
>> likes of merge/checkout.
>
> There is a trade off somewhere. "new user first" should not come at
> the cost for more experienced users.
>
> Making "git checkout/merge" abort while it's working before breaks
> scripts. And requiring to mark trashable files manually duplicates a
> lot of ignore patterns. Have a look at any .gitignore file, the
> majority of them is for discardable files because "ignored" class was
> created with those in mind (*.o and friends). So now you would need to
> add more or less the same set of ignore rules in .gitattributes to
> mark them trashable, and gitignore/gitattributes rules are not exactly
> compatible, you can't just blindly copy them over. Every time you add
> one more .gitignore rule, there's a good chance you need to add a
> similar rule for trashable attribute.
>
> Maybe we just add a new "newbie" config knob and turn on the safety
> nets on. Leave the knob on by default. And I will turn it off in my
> ~/.gitconfig as soon as it's real.

Oh yes, as noted upthread ("My commentary on this whole thing..."[1] )
my position on what we should do at this point is not that we should
definitely go one way or the other, but that more investigation is
needed.

As my "trashable"[2] patch makes clear we don't even have good tests or
documentation for these cases, which would be a good first step.

The one thing that *is* clear from my digging a few months back is that
the behavior we have now in git is overzealous when we look at the
initial case reported by Shawn way back when it was added.

Specifically, the intention back in 2007 was to fix a case where "git
checkout" ("read-tree -m", but whatever) would barf on a branch switch
where switching needed to replace a *tracked* "smth" with a *tracked*
"smth/file", or the other way around[3].

Does that mean we can just back that behavior out? No, because people
might have come to rely on it, but we should start with seeing exactly
what it *does* do, whether all those things are important or intended,
and maybe we can weight the shredding/backcompat trade-off for some of
those differently than others.

So the obvious thing to try would be to see if we can narrowly keep the
behavior where we end up shredding a file on disk, *but* are switching
between two trees A & B where that have/don't have that file.

Or more generously, try to "git hash-object" arbitrary files we're about
to shred, and check if it's already in the object database. That would
catch case where e.g. the user switching from A->B and would shred a
file, but it (or conflicting dir) is known to neither "A" nor "B", but
exists as a checked-in file in unrelated commit "C", which the user
recently had checked out (and e.g. their editor auto saved it as-is or
something...).

But it's entirely possible that after all that digging we'll come to the
conclusion that we can't change this at all, and we're just going to
live with all the current caveats.

That doesn't mean that having what amounts to a power user feature to
mitigate that damage if you know git well enough that it's going to be a
problem is going to help anything but a small minority of users. So
"dude, where's my data?" problem will still exist.

Even then there room to maneuver, e.g.:

 X. Perhaps after investigating it's not acceptable to change the
    default for script use, but could we require --force if we detect
    that we're connected to a terminal?

 Y. Or if even that is considered too much, we could have something like
    how help.autoCorrect works, where if we detect we're about to eat
    data we wait for 10 seconds, and invite the user to Ctrl+C now
    because we're about to clobber file "xyz".

 Z. It's for whatever reason still unacceptable to do X or Y (or some
    similar mitigation) for all cases of file shredding, but would be OK
    for some specific sub-cases (e.g. the not known to git-hash-object
    case above), and we have reason to suspect that such a narrow
    mitigation strikes the right trade-off between backwards
    compatibility and preventing the "dude, where's my data?" reports we
    get about this periodically.

1. https://public-inbox.org/git/87wolzo7a1.fsf@evledraar.gmail.com/
2. https://public-inbox.org/git/87zhuf3gs0.fsf@evledraar.gmail.com/
3. https://public-inbox.org/git/87wopj3661.fsf@evledraar.gmail.com/
