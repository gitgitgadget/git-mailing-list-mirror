Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E675F1F404
	for <e@80x24.org>; Tue, 14 Aug 2018 06:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731300AbeHNJ2z (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 05:28:55 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:46530 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730664AbeHNJ2z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 05:28:55 -0400
Received: by mail-ua1-f65.google.com with SMTP id u11-v6so11980476uan.13
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 23:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rbZSOhLmpqNVuIgNbehCcqTfN3E6XC7mADU20Df7mAw=;
        b=IqpvyLKYeYHwk1LzYLIfR1ZactfI810KguIbDlkvB6IrQVbsqv+/MhGq5lcVKsWWed
         Lqo/53Ucx7X/j5gDSwlabUxN9JsTo6kAbZhr8p18jF6e8zAoZpxTglRyZYQq5CJCkMiq
         IOwOome9dgbjHSOZLEUN6+zxZVRaRi/hHgqpz349ldWkQiLLdv5EY2+6+0e4YaTxjC+Y
         dKnI14WFFIDDVtCq2m3zSx0CdmZagTQzwTBJNWtBZtpzwBHGtviXLkOnlQN01y41/WVk
         4mNPQwjXiOB0THINOEo6xjy9y1SvxK6oKPrg7Ivg/07VgrwrRRQZWWPFQAO5E3Dc+maN
         s1pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rbZSOhLmpqNVuIgNbehCcqTfN3E6XC7mADU20Df7mAw=;
        b=QyyBZtfkGfEnsbAaU8veQOWkkmaZ/3kyHViG8uxG7amxpElZcjyneJ83OUTpxjhhQP
         2panYiFVWf61WZCQUu4bzNEi7jiM7eQA43v74mdoLgBBx97iRg1m8yopHI1knlV7WAud
         LkLB9YY6nYrrL3UnsaKuBdvH3TVdlJ1r7L/t52XDLLCtcUYXtAal7/Em14gimzlVKjXz
         6i3RISml1Ym0dzhqLt9MZOjQOsccLO6d/p4gylRCPfrW9SzwWrcVRZqPdLt91Y7KZtSc
         fSW2krTu527bLVg6GOF6K4hKK5oBJS8bZLIviTP8KyRlG9FvK/s2JlwAko+IFddPon/m
         5NfA==
X-Gm-Message-State: AOUpUlGMkfl8oLlNMB1u3itjEpIPTmIjv/JAvDnTnnbkI2QXQ6ttJMhv
        g01bfwSmjZzXwCVJ3vrQQ7jWV09ZUdGUIu5VhS0=
X-Google-Smtp-Source: AA+uWPwh/lLl0UTEFk1u+xorzMn++v5jJfButtUz7apQBvjQoRzYjXXzOpkavNkpINlWGDYVW1XA+Bg5i5q5965Y4zM=
X-Received: by 2002:a1f:6bc2:: with SMTP id k63-v6mr12691381vki.113.1534228987566;
 Mon, 13 Aug 2018 23:43:07 -0700 (PDT)
MIME-Version: 1.0
References: <20180811043218.31456-1-newren@gmail.com> <87mutts3sz.fsf@evledraar.gmail.com>
 <CABPp-BEADR15gOrH+GBQxKLZR2fCQwhaPWgf3VS--Z0bTNP0rA@mail.gmail.com>
 <20180811173406.GA9119@sigill.intra.peff.net> <xmqqr2j25dlm.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqr2j25dlm.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 13 Aug 2018 23:42:56 -0700
Message-ID: <CABPp-BHZoWn-mZjop+n9PJ0+A4tZFrU6vJE+A7iSeHDXcDc=Yg@mail.gmail.com>
Subject: Re: [PATCH 0/9] Add missing includes and forward declares
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, danshu@microsoft.com,
        marc@marc-stevens.nl
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 13, 2018 at 11:24 AM Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:

> As things are slowly moving out of the so-far kitchen-sink "cache.h"
> into more specific subsystem headers (like object-store.h), we may
> actually want to tighten the "header that includes it first" part a
> bit in the future, so that 'git grep cache.h' would give us a more
> explicit and a better picture of what really depends on knowing what
> the lowest level plumbing API are built around.
>
> > So I think the better test is a two-line .c file with:
> >
> >   #include "git-compat-util.h"
> >   #include $header_to_check
>
> But until that tightening happens, I do not actually mind the
> two-line .c file started with inclusion of cache.h instead of
> git-compat-util.h.  That would limit the scope of this series
> further.

Yes, this removes about 2/3 of patch #1.  But it makes things kind of
odd to me; do we change the relevant paragraph of
Documentation/CodingGuidelines to add an additional sentence so it
reads:

 - The first #include in C files, except in platform specific compat/
   implementations, must be either "git-compat-util.h", "cache.h" or
   "builtin.h".  You do not have to include more than one of these.
   However, note that including any of a few dozen header files
   may result in compilation failures if cache.h is not included first.

That seems annoying to state, but also annoying to leave undocumented.
I'd rather have the various structs (object_id, strbuf, index_state,
cache_entry, etc.) forward declared and/or relevant headers (e.g.
"cache.h", "strbuf.h", or "string-list.h") #include'd.  Are you sure
you really want me to remove these fixes?  Let me know, and if so I'll
do it, even if I'd prefer to leave them in.  Let me know how/if you'd
like that CodingGuidline to be updated too.


Also sha1dc_git.h fails to compile if cache.h is #included before it
(various redefinition errors, such as for "platform_SHA_CTX"); it's
possible that's expected, but it does make things a little weirder to
add implicit assumptions that cache.h is included first.
