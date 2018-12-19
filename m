Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A58F1F405
	for <e@80x24.org>; Wed, 19 Dec 2018 17:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730242AbeLSRJ6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Dec 2018 12:09:58 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38738 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729508AbeLSRJ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Dec 2018 12:09:57 -0500
Received: by mail-ot1-f66.google.com with SMTP id e12so19791294otl.5
        for <git@vger.kernel.org>; Wed, 19 Dec 2018 09:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SB3cXO9v+Yz1SHVDWttMXxIdLAaD6xULEOu8Q8CEw7Y=;
        b=uC2+P9GEzTWB7Z8qhzGHn8lWa/veFWhQ8pKUismO6EeU/4ZgHzjWZC457lBl1xZLJl
         CpLnYlswmhDx7PRH9M3S7G47+wUDsttAWNkvEEz/f92oyQiru9KlPMqBMylZSPfcJqR2
         ecrxMEr327LO/PaobJcxb/7cvCSZL9q41tH8c0PZZhQVi73596oY317GtIiOx8KEh+5D
         ulASTF17bUNk/CxJDCzLUaGrehGRHhCYcVyu4tICma6YiqoMZqmT9fofPokjgyzloLdl
         DauYsF/+ot07ZVXtyMUw2Z6mlFLDgUDx2wOQ7WlJ6y7sho48WvMqqyLICmQKELlzuu6x
         D2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SB3cXO9v+Yz1SHVDWttMXxIdLAaD6xULEOu8Q8CEw7Y=;
        b=uF5bWFtqkHaC6XYo0I2jjr2Xk29TKYBgSbzC9VZsQHiUN+V0XWnHlGfJjg56IHoP7Z
         87GWAawRjrAid/hLFWe6bwwinucBqlmlCwdC48BV5cAZhDgjJv92y1gGk4K5AI13NOFM
         DSp/2F+Tmv764dYIhwMiCRlwKMacerFfmU8G+XJIcX2J8rKOIueXYja3YGT4Us09ZaG5
         kk/tKI64vpfCRzeYa1n7Pf9u+lnV1Kuk17cP8UEFo8H6VGBat6bRhXyaKv98uiR9J4Vs
         8hWF/5Fss0hoiLLTkPQpK7p0HQgLYwz2DG/P1j1MW+M6wZwPi9nbfJ19yrXNbrTO+ZmG
         h7ww==
X-Gm-Message-State: AA+aEWaY2kjyVMNgCBjejqFvDb6ThmbFqbOyw7fb1t0KNMU1pv1eHJGx
        z5kStR30tfy9+908C4gGb/4tto7smfJSTIQ9Xb8=
X-Google-Smtp-Source: AFSGD/U7reY5S5yETPcZ/znvXJLK5U+oeEPoBQn3JBxDqukhTEJssdoZzAaA1ym70Xm42SAN87z4REZJpJC07ncHBU0=
X-Received: by 2002:a9d:4e5:: with SMTP id 92mr16382353otm.199.1545239396646;
 Wed, 19 Dec 2018 09:09:56 -0800 (PST)
MIME-Version: 1.0
References: <CANdyxMwxPqTMfLsoK-2JT3Wf3hXZnQNCPRS04aSHzsMbYJZo-Q@mail.gmail.com>
 <20181217155915.GA914@sigill.intra.peff.net> <CANdyxMzsf00k44TVkw+9uL4E3G_0rjYNgiMFK2o7MX83fCMPMQ@mail.gmail.com>
 <CANdyxMzOpRRu+B0cq5cbrmYsy47cod8N4mWrGtfOgRRgKVh+xA@mail.gmail.com> <CANdyxMzYMc2DGC8JUE7N6Ry7iOLH09SwR5OFQ64c1vtbO388FA@mail.gmail.com>
In-Reply-To: <CANdyxMzYMc2DGC8JUE7N6Ry7iOLH09SwR5OFQ64c1vtbO388FA@mail.gmail.com>
From:   Issac Trotts <issac.trotts@gmail.com>
Date:   Wed, 19 Dec 2018 09:09:45 -0800
Message-ID: <CANdyxMzLRur8Y66-fOhusW+rW=gYaM5pnotRrEwb-iy7Sa29ew@mail.gmail.com>
Subject: Re: [PATCH] log: add %S option (like --source) to log --format
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Noemi Mercado <noemi@sourcegraph.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Looks like that was a flake. Everything passes now.
https://travis-ci.org/ijt/git/builds/469843833

On Wed, Dec 19, 2018 at 12:07 AM Issac Trotts <issac.trotts@gmail.com> wrote:
>
> Travis showed one failure. I'm not sure if it's a flake.
> https://travis-ci.org/ijt/git/builds/469843833. Rerunning it.
>
> On Tue, Dec 18, 2018 at 7:47 PM Issac Trotts <issac.trotts@gmail.com> wrote:
> >
> > On Tue, Dec 18, 2018 at 9:14 AM Issac Trotts <issac.trotts@gmail.com> wrote:
> > >
> > > Hi Peff, thanks for the feedback. I tried a variant of the command you
> > > showed and it yielded a seg fault:
> > > ```
> > > [ issactrotts ~/git ] ./git diff-tree -s --pretty=tformat:'%S %H %s' HEAD
> > > Segmentation fault: 11
> > > ```
> > > I'll see if I can track it down this evening.
> >
> > Okay, found it. My solution is to make %S not do anything for commands
> > other than `log` since `log` is the only one that has --source defined
> > as far as I can tell.
> >
> > I'm waiting for Travis to run and will post an updated patch if
> > everything looks good there.
> >
> > > Issac
> > >
> > > On Mon, Dec 17, 2018 at 7:59 AM Jeff King <peff@peff.net> wrote:
> > > >
> > > > On Sun, Dec 16, 2018 at 10:25:14PM -0800, Issac Trotts wrote:
> > > >
> > > > > Make it possible to write for example
> > > > >
> > > > >         git log --format="%H,%S"
> > > > >
> > > > > where the %S at the end is a new placeholder that prints out the ref
> > > > > (tag/branch) for each commit.
> > > >
> > > > Seems like a reasonable thing to want.
> > > >
> > > > One curious thing about "--source" is that it requires cooperation from
> > > > the actual traversal. So if you did:
> > > >
> > > >   git rev-list | git diff-tree --format="%H %S"
> > > >
> > > > we don't have the %S information in the latter command. I think that's
> > > > probably acceptable as long as it does something sane when we don't have
> > > > that information (e.g., replace it with an empty string). It might also
> > > > be worth calling out in the documentation.
> > > >
> > > > -Peff
