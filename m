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
	by dcvr.yhbt.net (Postfix) with ESMTP id 5ED9F1F404
	for <e@80x24.org>; Mon, 27 Aug 2018 19:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbeH0XeZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 19:34:25 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37214 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbeH0XeZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 19:34:25 -0400
Received: by mail-wm0-f67.google.com with SMTP id n11-v6so122000wmc.2
        for <git@vger.kernel.org>; Mon, 27 Aug 2018 12:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=sMC845nGQlPeTHWGC+ocdMZaEwTZxd8Mkyh5PhqDfkc=;
        b=SKvpxKSAQfb6di28/ushs/Z2GgPrx42CIRpIIsGq5terW/xUyMJYFlRXchQjCOc2wW
         nb09h5iMTJuLcTJYVnW0QNEBM6K6ahZbTb3k5kgefBDCRtySgBLQu0wu0sAfMg/nMBSc
         5CqAl9b1nhRHfth67tJSrD9/RXiHPpAZpbLpHFMAGmFqt2fvgqh5QjYPx/Kkw/b9SKzf
         1U/KpkFjLQBEKKsYyrQiehb/ExT5p7DOloBplX1QDJtNqTkqxqdWzrOHmp9bpgYCVtdk
         6O8g0PeqsHWVT3ZrYzmOf5C5RVlfkqz6bS9xtxWTHx7ebkLVnb7QwA4npRby0wn/9UE7
         pSKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=sMC845nGQlPeTHWGC+ocdMZaEwTZxd8Mkyh5PhqDfkc=;
        b=IegIWriHdPqimraHgfpQToD+KlsTSvN9iKkZeoeYF0ksGK/ZBkt3lduIWd+9dFkdbA
         b2GyrtDgzwdg7DFw742NrFcRp9Lu15d7GE6JQbCteApzpjx3z18nGqGOHDn9HnnV/cOe
         yRIwqAjZ5vXGw8ww9Dwozx0qZadb7KSm/TeqQoddwHMPt/SU9U6xRLK0B6rzMiWkOeaY
         2UMRZFnBHYvFzk0V9eh3+AEMFy9utB0XAqvhseKoK2L1XcdLf5LpiUJA5ILQVL+tyXAd
         OC9iY4dysCiPUMaLVKGzGWOTQTkmVeRRq+SHPmhSwq8SWNSuAqIJH15JgRuWLywcCIbY
         CcHw==
X-Gm-Message-State: APzg51AcuNqyIL2pTP6Qnaf6PG5M6fY5NyW87kmgX5J5zj6+PglR/Fs2
        qTQk0UI9+vtVoLpcxQrHya0QBwSCXj4=
X-Google-Smtp-Source: ANB0VdbIbGHJ7fo0okJqTHrV2ZR6nziqfF7JsWxKqtL8JqNtvoWMhLahUjUOgSKegC0eADLqeXDImw==
X-Received: by 2002:a1c:908b:: with SMTP id s133-v6mr6625857wmd.69.1535399182839;
        Mon, 27 Aug 2018 12:46:22 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id b2-v6sm115232wmh.3.2018.08.27.12.46.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 12:46:21 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/7] use oidset for skiplist + docs + tests + comment support
References: <20180827194323.17055-1-avarab@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180827194323.17055-1-avarab@gmail.com>
Date:   Mon, 27 Aug 2018 21:46:20 +0200
Message-ID: <87mut7egoj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Aug 27 2018, Ævar Arnfjörð Bjarmason wrote:

> On Mon, Aug 27 2018, René Scharfe wrote:
>
>> Am 27.08.2018 um 09:37 schrieb Ævar Arnfjörð Bjarmason:
>>>
>>> On Sat, Aug 25 2018, René Scharfe wrote:
>>> [...]
>>> Now, I like yours much better. I'm just saying that currently the
>>> patch/commit message combo is confusing about *what* it's
>>> doing. I.e. let's not mix up the correction of docs that were always
>>> wrong with a non-change in the user facing implementation, and some
>>> internal optimization all in one patch.
>>
>> Now you have me confused.  Unsorted lists were always accepted, but the
>> documentation asked for a sorted one anyway, probably to avoid sorting
>> it with every use.  Switching the underlying data structure makes that a
>> moot point -- sortedness is no longer a concern at all -- not in the
>> code, and not for users.
>>
>> Inviting users to run the array implementation with unsorted lists is
>> not incorrect, but it also doesn't help anyone.  We could clarify that
>> sorted lists are preferred or recommended instead of required.  I don't
>> see value in perfecting the documentation of a quirk just before
>> removing it, though.
>
> I think it's easier to clarify step-by-step with code, so here's an my
> version of a v3 which implements what I was suggesting, but then of
> course while doing it I found other stuff to fix, changes since your
> v2:

Sorry for breaking threading, forgot In-Reply-To, which should be
https://public-inbox.org/git/c7cbc289-d86e-09dc-bdb3-b5496cf0b7ce@web.de/

> René Scharfe (2):
>   fsck: use strbuf_getline() to read skiplist file
>
> None to the code.
>
> I changed some docs I add in earlier patches to now describe behavior
> in a past tense (and the s/sorted // change is earlier), and to change
> the docs to say that sorting the list on-disk is now pointless for
> optimization purposes, but did something in the past.
>
>   fsck: use oidset for skiplist
>
> There is now a test for the bug you were fixing in your 1/2.
>
> Ævar Arnfjörð Bjarmason (5):
>   fsck tests: setup of bogus commit object
>
> Fixing some test redundancies while I'm at it.
>
>   fsck tests: add a test for no skipList input
>
> We didn't test the most basic skipList invocation, fixed while I was
> at it...
>
>   fsck: document and test sorted skipList input
>
> Test that sorted & unsorted skipList input, and document that in the
> past we said this was required, but it never was, but what (ever so
> slight) optimization this gives us.
>
>   fsck: document and test commented & empty line skipList input
>
> We don't support comments or empty lines. Add tests for this not
> working, and explicitly document that it doesn't work (I for one tried
> it).
>
>   fsck: support comments & empty lines in skipList
>
> Ignoring comments and empty lines is very useful for a file format
> that might be human-edited (I maintain one such file). Support that,
> and document & test for it.
>
>  Documentation/config.txt        | 22 ++++++++++----
>  fsck.c                          | 48 ++++++++++-------------------
>  fsck.h                          |  8 +++--
>  t/t5504-fetch-receive-strict.sh | 53 ++++++++++++++++++++++++++++++---
>  4 files changed, 86 insertions(+), 45 deletions(-)
