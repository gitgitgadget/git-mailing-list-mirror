Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C161A208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 15:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732546AbeHFRlP (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 13:41:15 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:35333 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbeHFRlP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 13:41:15 -0400
Received: by mail-lf1-f45.google.com with SMTP id f18-v6so9402120lfc.2
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 08:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KtkGUR99EPBxz/FzR1kwXaF8r4fV59oS96lkxJW9oeQ=;
        b=QjcPZ2v8mF9qce/vJjRNogvDs7MlRqaPLc6KnPN12CHDUaWti1Cq8hz8JsSTFfCPro
         VNRjusdRj+IbiKb8rWSDpi5NPnI9n87DcWkgmBHhAPboqTCA2rnBoBR2LrQInma6IB9h
         6JyUj3rNrpbLWCM2ERNUV5pf5Klkfso70gPIWvf15IS4F25u1tqW8jJasgV/YtrNKWre
         gwKz+yOL/FuABdXm9tXME0rhDBWFK6prk+EPHJPR1eS/RdIRdjTaX9x9di5C/7eMfZoc
         Dzo+4QXcXzYOV5OqHBumdluWYnEGEvGWBXPTJGu0efKfGn35rrJKAD2KG7S/DN4lQmgO
         qESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KtkGUR99EPBxz/FzR1kwXaF8r4fV59oS96lkxJW9oeQ=;
        b=Lr417MJ+e3jVju2DzWe99QrEPtBolO0WRGF1QqHosbLfV40CfVzdXWEWzgyo2I/+Vu
         LItTuUljpqGsP/tV5vN3QMVeCZZIwTnlO6OZALjiFg2KVoC5K1Twkx0TbQtT7cnyc2gF
         gLDEaKWr6IhAYdGhECdqyqSuYXFmLmA1svZhaDDiLGIWlJvVrnBobW6NV518xOg9M/DU
         9tHJyPU5uv+kXmrj6eyUwkcsL4p5AHT1QNlmxftbD1REnetIOYZSPLQA+hJykoYdsQDx
         jFaXSW6oGCRmc+gs0t4AKUa+AAwH5i2yCr3ohmwQHFxOANaWNmd+ENEtXDrpMCr9Lp6a
         thZg==
X-Gm-Message-State: AOUpUlEJhjiULaMwus0PN7iPMa5i53EsmCJ3Mn1Jh4IXzqMylwVUNnFL
        KSIeT9CbAtWA118fXJm//yWZUK1b7R539tjaRdZ76g==
X-Google-Smtp-Source: AAOMgpdjC8OfrUojvv+dvBdo+0O2jQXQXFzJ0NyOcJ0K6swk57f67GKo9afugu7T3ci1D1m+2ZOHID7UmZDD38fLw1o=
X-Received: by 2002:a19:501e:: with SMTP id e30-v6mr11214130lfb.71.1533569495389;
 Mon, 06 Aug 2018 08:31:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAM0VKj=MCS+cmOgzf_XyPeb+qZrFmuMH52-PV_NDMZA9X+rRoA@mail.gmail.com>
In-Reply-To: <CAM0VKj=MCS+cmOgzf_XyPeb+qZrFmuMH52-PV_NDMZA9X+rRoA@mail.gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Mon, 6 Aug 2018 17:31:23 +0200
Message-ID: <CAM0VKjkM-THZALy20VrZ-JSMyZjUXUqp1CAoCPrezXRsBfRJ2A@mail.gmail.com>
Subject: Re: t5570-git-daemon fails with SIGPIPE on OSX
To:     Git mailing list <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Clemens Buchacher <drizzd@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Resending with Clemens' last used email address.
Clemens, please consider sending a patch to update our .mailmap file.]


On Mon, Aug 6, 2018 at 5:11 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wro=
te:
>
> Travis CI changed its default OSX image to use XCode 9.4 on 2018-07-31
> [1].  Since then OSX build jobs fail rather frequently because of a
> SIGPIPE in the tests 'fetch notices corrupt pack' or 'fetch notices
> corrupt idx' in 't5570-git-daemon.sh' [2].  I think this is a symptom
> a real bug in Git affecting other platforms as well, but these tests
> are too lax to catch it.
>
> What it boils down to is this sequence:
>
>   - The test first prepares a repository containing a corrupt pack,
>     ready to be server via 'git daemon'.
>
>   - Then the test runs 'test_must_fail git fetch ....', which connects
>     to 'git daemon', which forks 'git upload-pack', which then
>     advertises refs (only HEAD) and capabilities.  So far so good.
>
>   - 'git fetch' eventually calls fetch-pack.c:find_common().  The
>     first half of this function assembles a request consisting of a
>     want and a flush pkt-line, and sends it via a send_request() call.
>
>     At this point the scheduling becomes important: let's suppose that
>     fetch is slow and upload-pack is fast.
>
>   - 'git upload-pack' receives the request, parses the want line,
>     notices the corrupt pack, responds with an 'ERR upload-pack: not
>     our ref' pkt-line, and die()s right away.
>
>   - 'git fetch' finally approaches the end of the function, where it
>     attempts to send a done pkt-line via another send_request() call
>     through the now closing TCP socket.
>
>   - What happens now seems to depend on the platform:
>
>     - On Linux, both on my machine and on Travis CI, it shows textbook
>       example behaviour: write() returns with error and sets errno to
>       ECONNRESET.  Since it happens in write_or_die(), 'git fetch'
>       die()s with 'fatal: write error: Connection reset by peer', and
>       doesn't show the error send by 'git upload-pack'; how could it,
>       it doesn't even get as far to receive upload-pack's ERR
>       pkt-line.
>
>       The test only checks that 'git fetch' fails, but it doesn't
>       check whether it failed with the right error message, so the
>       test still succeeds.  Had it checked the error message as well,
>       we most likely had noticed this issue already, it doesn't happen
>       all that rarely.
>
>     - On the new OSX images with XCode 9.4 on Travis CI the write()
>       triggers SIGPIPE right away, and 'test_must_fail' notices it and
>       fails the test.  I couldn't see any sign of an ECONNRESET or any
>       other error that we could act upon to avoid the SIGPIPE.
>
>     - On OSX with XCode 9.2 on Travis CI there is neither SIGPIPE, nor
>       ECONNRESET, but sending the request actually succeeds even
>       though there is no process on the other end of the socket
>       anymore.  'git fetch' then simply continues execution, reads and
>       parses the ERR pkt-line, and then dies()s with 'fatal: remote
>       error: upload-pack: not our ref'.  So, on the face of it, it
>       shows the desired behaviour, but I have no idea how that write()
>       could succeed instead of returning error.
>
> I don't know what happens on a real Mac as I don't have access to one;
> I figured out all the above by enabling packet tracing, adding a
> couple of well placed tracing printf() and sleep() calls, running a
> bunch of builds on Travis CI, and looking through their logs.  But
> without access to a debugger and netstat and what not I can't really
> go any further.  So I would now happily pass the baton to those who
> have a Mac and know a thing or two about its porting issues to first
> check whether OSX on a real Mac shows the same behaviour as it does in
> Travis CI's virtualized(?) environment.  And then they can pass the
> baton to those who know all the intricacies of the pack protocol and
> its implementation to decide what to do with this issue.
>
> For a mostly reliable reproduction recipe you might want to fetch this
> branch:
>
>   https://github.com/szeder/git t5570-git-daemon-sigpipe
>
> and then run 'make && cd t && ./t5570-git-daemon.sh -v -x'
>
>
> Have fun! ;)
>
>
> 1 - https://blog.travis-ci.com/2018-07-19-xcode9-4-default-announce
>
> 2 - On git.git's master:
>     https://travis-ci.org/git/git/jobs/411517552#L2717
