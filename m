Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF60D1F453
	for <e@80x24.org>; Wed,  7 Nov 2018 15:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbeKHBB5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 20:01:57 -0500
Received: from mail-it1-f172.google.com ([209.85.166.172]:35301 "EHLO
        mail-it1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbeKHBB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 20:01:57 -0500
Received: by mail-it1-f172.google.com with SMTP id v11so17095008itj.0
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 07:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qCfN8IF7hxh0Y7oDqsqu95GsYLzBRPblJew+4nGrly4=;
        b=MUM5QJ8GBjboPOGpM7RE6Mrga/jAUHgv5S0NqfKwvXHA8RSJqXIEQSv4eOnVcG8Tmh
         cjtbeHYVT+q/5t6HGsjzaD+MyJcp78O3JHwk5QEwb8EqtLe9mY2xg3XVrxKWKGcQ+QQV
         4F2Qs6ieOsUIaVGrQsufefGm4I7ea93YHF6uqY1H5orcBPhmH7B+2s+R3wltPqVndPI2
         /K1qHruI2U9/i+oGqY1yrsCnyRZRII7gTFAUClJamEBmCgAQxinBWcl/tPrQfcrTFJ+l
         hpnOByUDJ6+WvptVpusG2lYTURdq6p+y9ObpOPddCp2iVDZuJV6SFLbsQGPmaYIeDzfp
         dbWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qCfN8IF7hxh0Y7oDqsqu95GsYLzBRPblJew+4nGrly4=;
        b=p4AwJ6SN3UVlIoGl8av3acMULJSS4X1uKME0keqKEHNNQf8Nliaa56zQiDcq/vQAtQ
         WW7ZDmEygIQjGSfQ2H2egxxMBxoL6T+f+1pjjwSvMPirBLSoBPP0nQvGy7+cSyoB47Ua
         RN8b+u+5s7un+MT2aek+97SROxqlsL0CI4gHejTMBNEjF1d9A1y1ervTFGh33nIQTvKS
         m7b4lQQSDX8tUUXQkvaKS1oGV2Vw8gkcvXbzGTv3ACzZOgjukuOZgmoOP9vebadI6P7S
         I4sGltCF6l1BhaM3zHm0r5Pby+Z+6lIwkL48Km9u1HgIBGhr7/jsQwGV+wXs15TwgOMS
         urXA==
X-Gm-Message-State: AGRZ1gJ4xULY0y3EbXwz4cHs5BphtKhOzQh1A1qfE+AtLpbKrTjuZ8Lz
        uZgObU+gRVMW3uOHc5AUR3xYtVoLROa9zvtJxkc=
X-Google-Smtp-Source: AJdET5eGuUvHKA3KkmyIzBMRCyDZx7QMFfBHiEKtzTjl8etcWIUmxOSTkCNh+KkCM4PGpUb9+csFSwdk3jiVl46DmOA=
X-Received: by 2002:a24:ac5c:: with SMTP id m28-v6mr588732iti.123.1541604666327;
 Wed, 07 Nov 2018 07:31:06 -0800 (PST)
MIME-Version: 1.0
References: <20181104181026.8451-1-pclouds@gmail.com> <20181106171637.15562-1-pclouds@gmail.com>
 <871s7y6qs9.fsf@evledraar.gmail.com> <20181106221118.GA9975@sigill.intra.peff.net>
In-Reply-To: <20181106221118.GA9975@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 7 Nov 2018 16:30:38 +0100
Message-ID: <CACsJy8DTdW-P9zG3DBPArjhZU1VwwBmd7qNibyHxYkyjRrdWmw@mail.gmail.com>
Subject: Re: [PATCH/RFC] Support --append-trailer in cherry-pick and revert
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        andals@crustytoothpaste.net, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 6, 2018 at 11:11 PM Jeff King <peff@peff.net> wrote:
>
> On Tue, Nov 06, 2018 at 06:48:22PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
> > The implementation looks fine to me, but as noted in
> > https://public-inbox.org/git/8736se6qyc.fsf@evledraar.gmail.com/ I
> > wonder what the plausible end-game is. That we'll turn this on by
> > default in a few years, and then you can only worry about
> > git-interpret-trailers for repos created as of 2020 or something?
> >
> > Otherwise it seems we'll need to *also* parse out the existing messages
> > we've added.
>
> Could we help the reading scripts by normalizing old and new output via
> interpret-trailers, %(trailers), etc?
>
> I think "(cherry picked from ...)" is already considered a trailer by
> the trailer code. If the caller instructs us to, we could probably
> rewrite it to:
>
>   Cherry-picked-from: ...
>
> in the output. Then the end-game is that scripts should just use
> interpret-trailers, etc, and old and new commits will Just Work.

There is still one thing to settle. "revert -m1" could produce
something like this

    This reverts commit <SHA1>, reversing
    changes made to <SHA2>.

My proposal produces this

    Reverts: <SHA1>^2

And I can't really convert the former to latter without accessing
object database (probably not a good idea?) to check if SHA2 is the
second parent of SHA1. So either

 - I access object database anyway
 - Generate just "Reverts: <SHA1>" (i.e. losing info) with interpret-traile=
rs
 - Change Reverts: tag to a different output format, or maybe use two
tags instead.
--=20
Duy
