Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FCE71F403
	for <e@80x24.org>; Sat,  9 Jun 2018 15:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932668AbeFIPrX (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 11:47:23 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:32786 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932085AbeFIPrU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 11:47:20 -0400
Received: by mail-pf0-f193.google.com with SMTP id b17-v6so8068096pfi.0
        for <git@vger.kernel.org>; Sat, 09 Jun 2018 08:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=A4HCIBNEXUMVZFgeeZqgI3a4vUbGjBrPGap5Q4k1wRw=;
        b=P7GzX070eLKQlqti0PD1Y0geBT/I4pKRECI9N5PRDjpQ2n7m2K04m/wwu0PBAB6MAn
         dn419Tf77t8YJK7PBlB/hNcCM915zfc4SGweAA85cFZ1WzzcLf+BnSgOUgfW5PFyAmKG
         +okIWhkr93dl9XklX6ZgoOY9pFKp8iYCCBN6GO8+rYG2a7hC6zYKsX0mA0fW8T/z6Wrp
         CdlkajTw2ey2CBpymwhnfJ0DLoDusBuSLmqrgiG9ZWqqqcp4E1fmxDXnrwcFLUMbKQY7
         5nQrjARNfWrYKI9LtUHHihc2FpTiJokxvC7vlJfIHUQq0+vmNbDemcFNQBL6I1Yf+YKh
         J3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=A4HCIBNEXUMVZFgeeZqgI3a4vUbGjBrPGap5Q4k1wRw=;
        b=dBwHv3eHLrKMIVUmfaCkiL7mUSohtONsg/bncqXA/9QP4kvAN+/XKEumnxlZZC36Uc
         Hd0S+fmSsfoG3YnrUkArybJni7IBQyyVy1agAtNG7uCKg40RtGx6xGqK/Os0l0k9wzLk
         08YwEE/HPt1SkRU+TEaMk76HJWWdKHARls8mWNPYuYTaRRvJyHOEVSxYKEotUMEwLqay
         vNnD2/a7WKgkQtQgguQjLxkyY4Xppj71OFhYoOJos9BLKINu0tuqwcwv/jjSHPShQjrf
         K36Z85GGub3kSw1MhWPG88WoEkQjk/bbqm9x/mb8O6xgfB/gneJR02SyS7Wx2M5ZhHYh
         1BsA==
X-Gm-Message-State: APt69E3Ck/6PSmc3B9YGVbdabYoGN2ts4IMTXi2WHvF1Lp1RFEqvdXTP
        WXUQJVg6VuINimVVqVyvNNW5CpPM9bTWJdgWAIQ=
X-Google-Smtp-Source: ADUXVKLhbKnWnvPiTtb+zAmn4LeyGSoU5uuxa6duRO74ujn/QGmBEuXJfyBHZJhNtw6J6JGc9DvVSsuROPtLYa2rENw=
X-Received: by 2002:a65:6290:: with SMTP id f16-v6mr9210892pgv.155.1528559239501;
 Sat, 09 Jun 2018 08:47:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:760e:0:0:0:0 with HTTP; Sat, 9 Jun 2018 08:47:18
 -0700 (PDT)
In-Reply-To: <20180608224136.20220-21-avarab@gmail.com>
References: <20180608224136.20220-1-avarab@gmail.com> <20180608224136.20220-21-avarab@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 9 Jun 2018 17:47:18 +0200
Message-ID: <CAN0heSqo1WSVkYNiFAv4A7x8hG0wEx-iSz7ssLmYYVuen7b-LQ@mail.gmail.com>
Subject: Re: [PATCH 20/20] abbrev: add a core.validateAbbrev setting
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9 June 2018 at 00:41, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gma=
il.com> wrote:

> Instead of trying really hard to find an unambiguous SHA-1 we can with
> core.validateAbbrev=3Dfalse, and preferably combined with the new
> support for relative core.abbrev values (such as +4) unconditionally
> print a short SHA-1 without doing any disambiguation check. I.e. it

This first paragraph read weirdly the first time. On the second attempt
I knew how to structure it and got it right. It might be easier to read
if the part about core.appreb=3D+4 were in a separate second sentence.

That last "it" is "the combination of these two configs", right?

> allows for picking a trade-off between performance, and the odds that
> future or remote (or current and local) short SHA-1 will be ambiguous.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index abf07be7b6..df31d1351f 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -925,6 +925,49 @@ means to add or subtract N characters from the SHA-1=
 that Git would
>  otherwise print, this allows for producing more future-proof SHA-1s
>  for use within a given project, while adjusting the value for the
>  current approximate number of objects.
> ++
> +This is especially useful in combination with the
> +`core.validateAbbrev` setting, or to get more future-proof hashes to
> +reference in the future in a repository whose number of objects is
> +expected to grow.

Maybe s/validateAbbrev/validateAbbrev =3D false/?

> +
> +core.validateAbbrev::
> +       If set to false (true by default) don't do any validation when
> +       printing abbreviated object names to see if they're really
> +       unique. This makes printing objects more performant at the
> +       cost of potentially printing object names that aren't unique
> +       within the current repository.

Good. I understand why I'd want to use it, and why not.

> ++
> +When printing abbreviated object names Git needs to look through the
> +local object store. This is an `O(log N)` operation assuming all the
> +objects are in a single pack file, but `X * O(log N)` given `X` pack
> +files, which can get expensive on some larger repositories.

This might be very close to too much information.

> ++
> +This setting changes that to `O(1)`, but with the trade-off that
> +depending on the value of `core.abbrev` we may be printing abbreviated
> +hashes that collide. Too see how likely this is, try running:
> ++
> +------------------------------------------------------------------------=
-----------------------------------
> +git log --all --pretty=3Dformat:%h --abbrev=3D4 | perl -nE 'chomp; say l=
ength' | sort | uniq -c | sort -nr
> +------------------------------------------------------------------------=
-----------------------------------
> ++
> +This shows how many commits were found at each abbreviation length. On
> +linux.git in June 2018 this shows a bit more than 750,000 commits,
> +with just 4 needing 11 characters to be fully abbreviated, and the
> +default heuristic picks a length of 12.

These last few paragraphs seem like too much to me.

> ++
> +Even without `core.validateAbbrev=3Dfalse` the results abbreviation
> +already a bit of a probability game. They're guaranteed at the moment
> +of generation, but as more objects are added, ambiguities may be
> +introduced. Likewise, what's unambiguous for you may not be for
> +somebody else you're communicating with, if they have their own clone.

This seems more useful.

> ++
> +Therefore the default of `core.validateAbbrev=3Dtrue` may not save you
> +in practice if you're sharing the SHA-1 or noting it now to use after
> +a `git fetch`. You may be better off setting `core.abbrev` to
> +e.g. `+2` to add 2 extra characters to the SHA-1, and possibly combine
> +that with `core.validateAbbrev=3Dfalse` to get a reasonable trade-off
> +between safety and performance.

Makes sense. As before, I'd suggest s/SHA-1/object ID/.

I do wonder if this documentation could be a bit less verbose without
sacrificing too much correctness and clarity. No brilliant suggestions
on how to do that, sorry.

Martin
