Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 020AA1F404
	for <e@80x24.org>; Wed, 15 Aug 2018 15:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbeHOSse (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 14:48:34 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:46979 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729300AbeHOSse (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 14:48:34 -0400
Received: by mail-ua1-f66.google.com with SMTP id u11-v6so1719359uan.13
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 08:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L+O7OsIqsfgEb/Fapl9FkYCuRKaBh9ADnAaMfQDDEpU=;
        b=iTjwhx+xx7EjJ2kk6hpwBFokwEItz0uNVNYQDrkgnwf2/fhDx402+NgPbI5OupLtnX
         Wsj2M+bQ7eyLSLicozymgbAB1QLpjZ01b5Acgnkm8ZAcrG4vSdn42l33nS7L6avJjx1q
         SCEZ0Cn8Bi7XHeRLSVbu7t0hFoZ5Yc0pS749WayjimO5957GhHQoagjZv3vGYXTrDcCt
         vVWPg++IHkb+phvfafhEnnkcV/V+lfCa8P7/d1VJw4ks61k0INA5J5rrx+fqk2D4s8Ct
         LXSFP3G3FxY2BXS6Jwi6ugWw1i8BLMkKrynC9AS3TsgcLQjRVrDUygmmUa3wecgeULaP
         gpSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L+O7OsIqsfgEb/Fapl9FkYCuRKaBh9ADnAaMfQDDEpU=;
        b=uYBUTIUC+c14oFinwgFxHnaBainEe4yinQ4nevzQuG7uQqJZUWgh8dr6/4X1UYezSX
         MF5F4pf+cjS2zYznc5d8NqfOMim0x35NHhgXTEgFAUULLhE6JZkaviaote28M5Tv64vN
         XT/4ei4/elKrzlV8MZoQD2wQu7DsnbBec6ujS7hJL+aPOt+pMdP9QlKUSpRdMv2Et7Rk
         MmL2pj2p498XCsvYRige+PvIcfFMyrl/ckjlwqZAm6MOrf5g/GoTjbJwLA5QTeuuGMDD
         D8CVhLPlfWCytGJfRdhO5Invm55eBWtuWvkR4dEp/EvZSduDImmmRdyUperB8m1vE8xA
         d0hw==
X-Gm-Message-State: AOUpUlEkfD026LCk2d8YMXoXKqmqso2WmcUgFnrykwQ0FFzxVaWGXEg8
        9RJoZjGNer2f6zdBmcNTfUbq6UKUIWV/44kZYgQ=
X-Google-Smtp-Source: AA+uWPxCzzqqAaDEwDm4Kvt+ty+Kn9A0pvCOovFa8eY1X2lzPC032gjUZtshKfOk6At1NuHfYTKLWJAQboGxka26//0=
X-Received: by 2002:ab0:12e2:: with SMTP id o34-v6mr17506769uac.154.1534348551529;
 Wed, 15 Aug 2018 08:55:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180811043218.31456-1-newren@gmail.com> <87mutts3sz.fsf@evledraar.gmail.com>
 <CABPp-BEADR15gOrH+GBQxKLZR2fCQwhaPWgf3VS--Z0bTNP0rA@mail.gmail.com>
 <20180811173406.GA9119@sigill.intra.peff.net> <xmqqr2j25dlm.fsf@gitster-ct.c.googlers.com>
 <CABPp-BHZoWn-mZjop+n9PJ0+A4tZFrU6vJE+A7iSeHDXcDc=Yg@mail.gmail.com>
 <xmqqftzgxjww.fsf@gitster-ct.c.googlers.com> <CABPp-BGtuxmeLTFTmsRvaK6J0jA9Sa3wx3rR0Ov8nJkxL4aqqA@mail.gmail.com>
 <xmqqzhxnmy9m.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqzhxnmy9m.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 15 Aug 2018 08:55:39 -0700
Message-ID: <CABPp-BHLa2vEGHMc28pEAC9tVmQjpsrTKivCNof0MX-fQMOCRg@mail.gmail.com>
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

On Wed, Aug 15, 2018 at 8:43 AM Junio C Hamano <gitster@pobox.com> wrote:
> Elijah Newren <newren@gmail.com> writes:
>
> > On Tue, Aug 14, 2018 at 10:45 PM Junio C Hamano <gitster@pobox.com> wrote:
> >> Elijah Newren <newren@gmail.com> writes:
> >>
> >> > On Mon, Aug 13, 2018 at 11:24 AM Junio C Hamano <gitster@pobox.com> wrote:
> >> >> Jeff King <peff@peff.net> writes:
> >> >
> >> >> As things are slowly moving out of the so-far kitchen-sink "cache.h"
> >> >> into more specific subsystem headers (like object-store.h), we may
> >> >> actually want to tighten the "header that includes it first" part a
> >> >> bit in the future, so that 'git grep cache.h' would give us a more
> >> >> explicit and a better picture of what really depends on knowing what
> >> >> the lowest level plumbing API are built around.
> >> >>
> >> >> > So I think the better test is a two-line .c file with:
> >> >> >
> >> >> >   #include "git-compat-util.h"
> >> >> >   #include $header_to_check
> >> >>
> >> >> But until that tightening happens, I do not actually mind the
> >> >> two-line .c file started with inclusion of cache.h instead of
> >> >> git-compat-util.h.  That would limit the scope of this series
> >> >> further.
> >> >
> >> > Yes, this removes about 2/3 of patch #1.
> >>
> >> Sorry for making a misleading comment.  I should have phrased "I
> >> would not have minded if the series were looser by assuming
> >> cache.h", implying that "but now the actual patch went extra mile to
> >> be more complete, what we have is even better ;-)".
> >
> > Ah, gotcha.  Thanks for the clarification.
>
> But please remind me not to merge this round down to 'next', for the
> "enum" forward decl gotcha.

I'll send out a new round shortly.  Would you like me to squash the
last patch (the one that had two hunks with minor conflicts with other
topics in next and pu) into the first patch, or would you rather I
dropped that patch and waited to submit it until later?
