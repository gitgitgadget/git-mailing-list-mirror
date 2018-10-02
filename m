Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFDA31F453
	for <e@80x24.org>; Tue,  2 Oct 2018 04:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbeJBKwQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 06:52:16 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33356 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeJBKwQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 06:52:16 -0400
Received: by mail-oi1-f193.google.com with SMTP id a203-v6so471194oib.0
        for <git@vger.kernel.org>; Mon, 01 Oct 2018 21:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=73rOT20uOlsymAwLzCLugOTZngiWEcDq318NXjXf51M=;
        b=o6tUII1ZPpQ8kIgA724ktDo0WsY0O2THz4uZyphI1LDc3WxwdI36Zx/J4AEIR9s0e+
         iQRdsgmcE0S/RJk8qVgaS9NI4B+QikMfLF5sdubjUOiwn5tWyOFU5/NvF/GxSwiFHFED
         VZyRZC9tGkADU59TIn8h7LZbcXuCmf3mpt3UgKPizV/+Eia0pKBIrdZhgGu0jEH0s+r8
         jGbqJ+qC9zy4iY6HnHDSNGwcgxUowicv4Z998qQe1seLfArePpHnA2NKGwNT+HJvAosc
         IrVZfDThkMsWad8AVkaIVMrGBGkpQy+ZHWuyI9kK4Paw/sOQvSql161HfXKCs4wjdQK6
         QOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=73rOT20uOlsymAwLzCLugOTZngiWEcDq318NXjXf51M=;
        b=HVyX/kcP6u2Yt9J14pg5yHAlV5lhwkN3+knrc5FXfNUiQAtgvBbFINennqGOiJf6g8
         JeWzr7PdPd09EX3OWr9oL7gT9W1TRRcaS1TQXMWRHnMCpsaZYpfZJHajy6sVewX32EW0
         ypjf6zjx4LYWU/i5BrS+rrf46AEN32v3gQ7eYRKXRzL7ax9DFivqKyqXODUKTTD6EBX9
         q1zNh9cWzXMixh2hFMFCvnNjNotiMIpdOJ2OoEQQUDn5fIAgmflsOwrMdrnnLGuWTRHL
         ZDEQ1Jn8/vMMAukrVibDIdDOBY9n9k7R3kK5n/trsPB+jy83gNxTC61SevReWRoFwf0U
         egUw==
X-Gm-Message-State: ABuFfojLCWe2dVh4aE/iue9v6tHNJOHVqVVB3HnMtsRIHoZMNFHKhZqX
        3O8ciUFhbqSEQSkg8QqG9Oy83Au/hOrhwe09hOo=
X-Google-Smtp-Source: ACcGV63o1Jc6ykt0FHzEQBaQX/IOcinkLJLcHefvoE4WXbhbm4hLw8cshhLEiHvsJ5bnFHhL9ZLIZahIS26cUgjlCjs=
X-Received: by 2002:a54:4618:: with SMTP id p24-v6mr6153502oip.172.1538453465988;
 Mon, 01 Oct 2018 21:11:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAGDaZ_oBpLxD0cutrsNsFBEtH+-Fn2eT40gDsnGZhhU0qm2Ofw@mail.gmail.com>
 <87bm8giapu.fsf@evledraar.gmail.com> <CACsJy8BYr6cVtAcDO9w-tfgEiWnbvQCgSR7p3OFKbqVkPA1Gaw@mail.gmail.com>
 <CAGDaZ_oS4bjzd67T5atJrJ6_x2Cfr8JgnoGWePzA53mb2ObdNg@mail.gmail.com>
 <CAGZ79kYX3ZgmE3S-2cq0F_27Ctq_wwuSo53znRrBquik3ODXew@mail.gmail.com> <CAGDaZ_q30GPWsd-NF1OSOx8m7LwXm4vk_5XcqRD5MxcjDx=GzQ@mail.gmail.com>
In-Reply-To: <CAGDaZ_q30GPWsd-NF1OSOx8m7LwXm4vk_5XcqRD5MxcjDx=GzQ@mail.gmail.com>
From:   Raymond Jennings <shentino@gmail.com>
Date:   Mon, 1 Oct 2018 21:10:29 -0700
Message-ID: <CAGDaZ_q6pWXHajAs+Mp5+skatx6GwiXhpTfbDF+7nXHzfmzJ-Q@mail.gmail.com>
Subject: Re: [BUG] Segfault in "git submodule"
To:     sbeller@google.com
Cc:     pclouds@gmail.com, avarab@gmail.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I instructed downstream to update their repository.
On Mon, Oct 1, 2018 at 2:31 PM Raymond Jennings <shentino@gmail.com> wrote:
>
> Yes, git 2.16.4 to be exact.
>
> I upgraded to 2.19 after ~arch keywording the package on gentoo and
> that fixed it.
> On Mon, Oct 1, 2018 at 12:19 PM Stefan Beller <sbeller@google.com> wrote:
> >
> > On Sat, Sep 29, 2018 at 9:43 AM Raymond Jennings <shentino@gmail.com> w=
rote:
> > >
> > > I have a repo, but it appears to be specific to staging area state.
> > > It only segfaults when I have a certain file deleted.
> > >
> > > Where do you want me to upload it?
> > > On Sat, Sep 29, 2018 at 8:34 AM Duy Nguyen <pclouds@gmail.com> wrote:
> > > >
> > > > On Sat, Sep 29, 2018 at 5:31 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarma=
son
> > > > <avarab@gmail.com> wrote:
> > > > > > #1  refs_resolve_ref_unsafe (refs=3D0x0,
> > > > > > refname=3Drefname@entry=3D0x55e863062253 "HEAD",
> > > > > > resolve_flags=3Dresolve_flags@entry=3D1, oid=3Doid@entry=3D0x7f=
fdc834b1c0,
> > > > > > flags=3Dflags@entry=3D0x7ffdc834b1bc) at refs.c:1493
> > > >
> > > > refs is NULL. It looks like somebody fails to get the right submodu=
le
> > > > ref store (or tries to get it but fails to check if it may return
> > > > NULL)
> >
> > This is spot on.
> >
> > Raymond, are you on Git v2.16.0 by any chance?
> > (and if now which version are you on).
> >
> > I suspect 2.16, as that is a version of Git, in which there happens to =
be
> > a call into the refs subsystem in submodule--helper.c in line 624.
> >
> > Is it possible to upgrade Git (to v2.18.0 or later) or cherry-pick
> > 74b6bda32f (submodule: check for NULL return of get_submodule_ref_store=
(),
> > 2018-03-28) into your copy of Git?
> >
> > Thanks,
> > Stefan
