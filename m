Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 578AA1F405
	for <e@80x24.org>; Wed, 19 Dec 2018 03:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbeLSDru (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Dec 2018 22:47:50 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33919 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbeLSDru (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Dec 2018 22:47:50 -0500
Received: by mail-ot1-f65.google.com with SMTP id t5so17933340otk.1
        for <git@vger.kernel.org>; Tue, 18 Dec 2018 19:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TYTyTCi8lK5i2/ByxENP+v6Jyf1g5FRPhSZhrbo29t4=;
        b=p1+l9CLGKAVohuqgIlA+Rn4YWHqSx3zqzSP7UnMJKg9FZjCNgcoEpTh2NXroqpueEb
         FvRLnbI62GFymWU8lwXfIUy5K4uDOTBzwQn3cFuGUVv3rboLmPUdIg6jHIRbltO8paeV
         BwDsd6G+slZ0ARySHp2p84oISQo5LCZkE+ND2XlGcbksa65A+x7sFemAKGrf0SbpTBTx
         C53cpFd+dQ3K7USOKz2Nrd/R/d+grfWPl0/Cc4q8uG53i4Ko8rdu1hO4SjwSshJX+Ive
         odtjF43upd2o4Pgw/CGNwuwyov3KGu6SfK8D8C9vl4ibQtt5SqIu4Oi21JSaeBwu/orA
         A87Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TYTyTCi8lK5i2/ByxENP+v6Jyf1g5FRPhSZhrbo29t4=;
        b=O5FxP/pA3IzhgdpnszGpvHJQYgre63LpXEsWxfVY2BBX1+mhzFugQ4/7yIp9Pyd6Mg
         /0/DzMFQbEhi50mGiterdc19YhwsTkEHwV50sbmzQZIXO4eyzga810sUef1t165y5fFa
         iEzY+Pkd63uQFhkkALw/m+2atC3uc1p1qgTWB9FWPPMtBmbWJkBEK20wdKyE1kSuMTnZ
         OF8xfgGl7e5afiNeoZ/8U+zEVzfD36f7bK+sNdWr8vvjgxDeEHbSvCbK/9VYi2Qr67+1
         8rEa7BBsIxdE2+EvtNca2zM89CXH7mF2uzKZzs6RjOXfalFHksr6tnQxMWs9yMFrxbdh
         eY6g==
X-Gm-Message-State: AA+aEWavGKBC3YeBWVWpwe7MxgIEiGbh+aV7w0vsBHq/EvA1DAC6Y3kc
        JqXZNgwdbuNqggOYSiEi/NF8xhDvgoLNwqLyCgU=
X-Google-Smtp-Source: AFSGD/UzdKaERYmXbo4IrqXcLiF+tjVqp9AfxDPI3QxLytHkzZ9IJKj8DM38qTaWkc73lBtCUKZmHbTXeY2v0dAL72I=
X-Received: by 2002:a9d:724d:: with SMTP id a13mr14757744otk.193.1545191268905;
 Tue, 18 Dec 2018 19:47:48 -0800 (PST)
MIME-Version: 1.0
References: <CANdyxMwxPqTMfLsoK-2JT3Wf3hXZnQNCPRS04aSHzsMbYJZo-Q@mail.gmail.com>
 <20181217155915.GA914@sigill.intra.peff.net> <CANdyxMzsf00k44TVkw+9uL4E3G_0rjYNgiMFK2o7MX83fCMPMQ@mail.gmail.com>
In-Reply-To: <CANdyxMzsf00k44TVkw+9uL4E3G_0rjYNgiMFK2o7MX83fCMPMQ@mail.gmail.com>
From:   Issac Trotts <issac.trotts@gmail.com>
Date:   Tue, 18 Dec 2018 19:47:36 -0800
Message-ID: <CANdyxMzOpRRu+B0cq5cbrmYsy47cod8N4mWrGtfOgRRgKVh+xA@mail.gmail.com>
Subject: Re: [PATCH] log: add %S option (like --source) to log --format
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Noemi Mercado <noemi@sourcegraph.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 18, 2018 at 9:14 AM Issac Trotts <issac.trotts@gmail.com> wrote:
>
> Hi Peff, thanks for the feedback. I tried a variant of the command you
> showed and it yielded a seg fault:
> ```
> [ issactrotts ~/git ] ./git diff-tree -s --pretty=tformat:'%S %H %s' HEAD
> Segmentation fault: 11
> ```
> I'll see if I can track it down this evening.

Okay, found it. My solution is to make %S not do anything for commands
other than `log` since `log` is the only one that has --source defined
as far as I can tell.

I'm waiting for Travis to run and will post an updated patch if
everything looks good there.

> Issac
>
> On Mon, Dec 17, 2018 at 7:59 AM Jeff King <peff@peff.net> wrote:
> >
> > On Sun, Dec 16, 2018 at 10:25:14PM -0800, Issac Trotts wrote:
> >
> > > Make it possible to write for example
> > >
> > >         git log --format="%H,%S"
> > >
> > > where the %S at the end is a new placeholder that prints out the ref
> > > (tag/branch) for each commit.
> >
> > Seems like a reasonable thing to want.
> >
> > One curious thing about "--source" is that it requires cooperation from
> > the actual traversal. So if you did:
> >
> >   git rev-list | git diff-tree --format="%H %S"
> >
> > we don't have the %S information in the latter command. I think that's
> > probably acceptable as long as it does something sane when we don't have
> > that information (e.g., replace it with an empty string). It might also
> > be worth calling out in the documentation.
> >
> > -Peff
