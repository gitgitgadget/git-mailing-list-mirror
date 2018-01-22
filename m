Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 763B31F404
	for <e@80x24.org>; Mon, 22 Jan 2018 15:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751282AbeAVPJb (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 10:09:31 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:43753 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750848AbeAVPJ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 10:09:28 -0500
Received: by mail-wm0-f44.google.com with SMTP id g1so16919499wmg.2;
        Mon, 22 Jan 2018 07:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=nOOOKbqKxNNig5+tfTzk/pEWqLbEgR8hy+yD5MyCYvE=;
        b=lG3yiGHB5kx3FWcE5ay38K6YnGQ+KNS96X1WFhOTeBnzbDkW6cvBrz4Yod1E25GWAp
         /mjab5KlGE3ta7w7boM3j6ZNk3b24E5eL76XUoCCWFiTUNhbPwOJhUwINuxInR08H+9/
         8Q8jIbbRLC4gYOZ4tRE78NNQJonCSncI20dWqKbfbO4xLIBz2Q9CfGfacvhzPc66oX0C
         x7HyiAyfiCSAksCTkrIUeRhX8vhqC9apN6tDgjd8IHh6I6B9UN6Nh6PmhUzZEKwZN1qN
         +EZW9TOOct8Q74Gcx03cQZ6y+Xgu28bx70qvs0JNWloYHI/GeFRaCKfV4Eh7f5lIK7aE
         XfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=nOOOKbqKxNNig5+tfTzk/pEWqLbEgR8hy+yD5MyCYvE=;
        b=h+v0knLwRxXoQ2fFJafb6Aslr/KzSSP3xlQ0gGE48k2hjwDSI8/cXEe/qd1NVDAn0b
         GHscFSUDIkNNS7XF3fhDkIW6Isvxh6UfecoVjoteDc5Sy+vCShsAWy3nA1foSA00DvdQ
         Q/UK+5ztbzcmMq5pDuTvzM9xPlO40L5sHSvvlRoqkiOel6PLKXCMlHUKOc9hVLOPZl1m
         HS+2Q8ojzKJRKnmNXptvnNUn8fSI6W/VT48uK4Z0volUNwW709OFqKRSlQuR0QX0LKd3
         /UUJxTMJBlAQdCX+hPF1Pid9dcaMctjT9GfJqxoFgGVyY5A9yXDbUBmwKz7eoztIb7CI
         GA8g==
X-Gm-Message-State: AKwxytcrl27axh/4mRM1l9IzDygyNrGmtiJa7kWNzNDequgxX2d2fVwk
        U5vqel9uOG2qc69SldSQQs0=
X-Google-Smtp-Source: AH8x226438HG6LcGZDPwXtsWhUagNWpWbA2QO+jl1HONb3LAl0RXUuTqJ1NVWwD/ivveot71zs+ssA==
X-Received: by 10.80.146.240 with SMTP id l45mr13742879eda.125.1516633766895;
        Mon, 22 Jan 2018 07:09:26 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id s26sm2876889eds.49.2018.01.22.07.09.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jan 2018 07:09:24 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] enable core.fsyncObjectFiles by default
References: <20180117184828.31816-1-hch@lst.de> <xmqqd128s3wf.fsf@gitster.mtv.corp.google.com> <87h8rki2iu.fsf@evledraar.gmail.com> <CA+55aFzJ2QO0MH3vgbUd8X-dzg_65A-jKmEBMSVt8ST2bpmzSQ@mail.gmail.com> <20180117235220.GD6948@thunk.org> <CA+55aFxgg6MT5Z+Jox2xyG28g9jNJ4cL3jNZ5AgTOmUODuiBsA@mail.gmail.com> <20180118162721.GA26078@lst.de> <xmqqzi59psxt.fsf@gitster.mtv.corp.google.com> <20180120221445.GA4451@thunk.org> <xmqqefmknp3f.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <xmqqefmknp3f.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 22 Jan 2018 16:09:23 +0100
Message-ID: <871siihqvw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jan 20 2018, Junio C. Hamano jotted:

> Theodore Ts'o <tytso@mit.edu> writes:
>
>> ....  I've never been fond of the "git repack -A" behavior
>> where it can generate huge numbers of loose files.  I'd much prefer it
>> if the other objects ended up in a separate pack file, and then some
>> other provision made for nuking that pack file some time later....
>
> Yes, a "cruft pack" that holds unreachable object has been discussed
> a few times recently on list, and I do agree that it is a desirable
> thing to have in the longer run.
>
> What's tricky is to devise a way to allow us to salvage objects that
> are placed in a cruft pack because they are accessed recently,
> proving themselves to be no longer crufts.  It could be that a good
> way to resurrect them is to explode them to loose form when they are
> accessed out of a cruft pack.  We need to worry about interactions
> with read-only users if we go that route, but with the current
> "explode unreachable to loose, touch their mtime when they are
> accessed" scheme ends up ignoring accesses from read-only users that
> cannot update mtime, so it might not be too bad.

Wouldn't it also make gc pruning more expensive? Now you can repack
regularly and loose objects will be left out of the pack, and then just
rm'd, whereas now it would entail creating new packs (unless the whole
pack was objects meant for removal).

Probably still worth it, but something to keep in mind.
