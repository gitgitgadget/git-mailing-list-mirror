Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2327E1F405
	for <e@80x24.org>; Wed, 19 Dec 2018 08:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbeLSIHu (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Dec 2018 03:07:50 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36038 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbeLSIHu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Dec 2018 03:07:50 -0500
Received: by mail-oi1-f194.google.com with SMTP id x23so937188oix.3
        for <git@vger.kernel.org>; Wed, 19 Dec 2018 00:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UIGeaHFhW9LrD+lJ7rofmM7pBsqa6VoMQeSxyp8F1qg=;
        b=qvAPf1kr/yRZwA3pTGn69EZ4uiR9OY0TuPSOn6L+gAs+X/qAzpuXKxC58BRlU1ufbW
         LBYzJVaGOT1SyC1DWjGgoe9BYY/jfITPIsCk921Xq9EBc37I3E9WZF6DvEfjlAS0TOqi
         pRdo4JKSOp6nJNO9NKnx6/PDrBr6FsU3TmzSZx8Ic6QHGNhFnYq9DVu6jzyih2YrPAgf
         ozfL7hPAAIycpN+mJdoRpsq6iYBgxif+tJQ9XpLZTsN5dR5Rbry1R+jbbQOrFwxcKtBj
         fkTcwJ78HuVULS2SBOXASVlJ9fD2lsLOt4eGbiqZZiqB5MS0FLRvA2tZ0x+HJ5uJIaxz
         fwIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UIGeaHFhW9LrD+lJ7rofmM7pBsqa6VoMQeSxyp8F1qg=;
        b=UYLn8+0B+9W+39wSHxngpbvD6CRjC1Yhrjqy8vSbU+XpObS7Je/a6cjsZv0iftKeNc
         wh2gfvinOVFh9nSYIOFFpDk1xSPIA5o2JhlomomyleQgL/lL/H/XAGmj2Vf6IvxB91EG
         X1EhX9XJzJLa/qAP7T3dAY9b+DHG+SM9k9Q6kIQ42qoCxUbXgtCvWe38CwA0sBtNCcMm
         1u1sz0wbPkgAARfK1b4fr+Vka3foFHC5cN8JSelPPCNmddgPiru28pxgzqQVnzS731pq
         1SZDgKRBhVXk/ljneaXv0djkosQYR8soQIfMrQRC/JK52lGLJoDRw3VMyK1UYqOhEWPe
         V8vg==
X-Gm-Message-State: AA+aEWZf0bMJy4+ZT6Rly+4b3uJao3fwKDIqglLpYLHZp72yqGJx4Y8l
        hH7Xl2sMUQmpO/BgfUv+s4vv1Nw64DK/YKJyEWo=
X-Google-Smtp-Source: AFSGD/XmKr9sbMenjKTYyxTfaDad4s8ZtQpmgAnp3ZYqTmkdgLyf9GBdcm+lYx/ugN8APwbNG6Hi00VCrGn6C+9UlO0=
X-Received: by 2002:aca:a805:: with SMTP id r5mr547769oie.5.1545206868831;
 Wed, 19 Dec 2018 00:07:48 -0800 (PST)
MIME-Version: 1.0
References: <CANdyxMwxPqTMfLsoK-2JT3Wf3hXZnQNCPRS04aSHzsMbYJZo-Q@mail.gmail.com>
 <20181217155915.GA914@sigill.intra.peff.net> <CANdyxMzsf00k44TVkw+9uL4E3G_0rjYNgiMFK2o7MX83fCMPMQ@mail.gmail.com>
 <CANdyxMzOpRRu+B0cq5cbrmYsy47cod8N4mWrGtfOgRRgKVh+xA@mail.gmail.com>
In-Reply-To: <CANdyxMzOpRRu+B0cq5cbrmYsy47cod8N4mWrGtfOgRRgKVh+xA@mail.gmail.com>
From:   Issac Trotts <issac.trotts@gmail.com>
Date:   Wed, 19 Dec 2018 00:07:35 -0800
Message-ID: <CANdyxMzYMc2DGC8JUE7N6Ry7iOLH09SwR5OFQ64c1vtbO388FA@mail.gmail.com>
Subject: Re: [PATCH] log: add %S option (like --source) to log --format
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Noemi Mercado <noemi@sourcegraph.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Travis showed one failure. I'm not sure if it's a flake.
https://travis-ci.org/ijt/git/builds/469843833. Rerunning it.

On Tue, Dec 18, 2018 at 7:47 PM Issac Trotts <issac.trotts@gmail.com> wrote:
>
> On Tue, Dec 18, 2018 at 9:14 AM Issac Trotts <issac.trotts@gmail.com> wrote:
> >
> > Hi Peff, thanks for the feedback. I tried a variant of the command you
> > showed and it yielded a seg fault:
> > ```
> > [ issactrotts ~/git ] ./git diff-tree -s --pretty=tformat:'%S %H %s' HEAD
> > Segmentation fault: 11
> > ```
> > I'll see if I can track it down this evening.
>
> Okay, found it. My solution is to make %S not do anything for commands
> other than `log` since `log` is the only one that has --source defined
> as far as I can tell.
>
> I'm waiting for Travis to run and will post an updated patch if
> everything looks good there.
>
> > Issac
> >
> > On Mon, Dec 17, 2018 at 7:59 AM Jeff King <peff@peff.net> wrote:
> > >
> > > On Sun, Dec 16, 2018 at 10:25:14PM -0800, Issac Trotts wrote:
> > >
> > > > Make it possible to write for example
> > > >
> > > >         git log --format="%H,%S"
> > > >
> > > > where the %S at the end is a new placeholder that prints out the ref
> > > > (tag/branch) for each commit.
> > >
> > > Seems like a reasonable thing to want.
> > >
> > > One curious thing about "--source" is that it requires cooperation from
> > > the actual traversal. So if you did:
> > >
> > >   git rev-list | git diff-tree --format="%H %S"
> > >
> > > we don't have the %S information in the latter command. I think that's
> > > probably acceptable as long as it does something sane when we don't have
> > > that information (e.g., replace it with an empty string). It might also
> > > be worth calling out in the documentation.
> > >
> > > -Peff
