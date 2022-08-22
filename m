Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB02C28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 13:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbiHVN6g (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 09:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234547AbiHVN6e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 09:58:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5811010FCB
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 06:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661176701;
        bh=O570wLuKh5UFUb3UpIPNgzJTeIP8sZrW9DTiOGbZSlg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=NADcHFOPDkU4J6jk++ASsGjQAxXL3f9BIqh/lb9sNpXdLiR1cAWPqum4N0v7lVasD
         Rc+cAZqSOrs+LOW7IhKSgE7xB/9Lnxx6em+xPDjwB5gyzJN6B5Hgd7aafarZ/vAFic
         5fOwqpxZw5IixCFhfdAtR79Q0lnD1gBHAR6TLm/k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.137.196] ([89.1.212.11]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEm6F-1oejzC1Xul-00GIUV; Mon, 22
 Aug 2022 15:58:21 +0200
Date:   Mon, 22 Aug 2022 15:58:21 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Christian Couder <christian.couder@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Maxwell Bernstein <tekk.nolagi@gmail.com>,
        Max Bernstein via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Max Bernstein <donotemailthisaddress@bernsteinbear.com>,
        Max Bernstein <max@bernsteinbear.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2] trailer: allow spaces in tokens
In-Reply-To: <CAP8UFD2kMXHxvg1tKVNLhY0Gweq2YrD7+tHmZXKwguYzRQ1Qpg@mail.gmail.com>
Message-ID: <p8srs909-19p5-4o24-r245-roq46pp4s6p5@tzk.qr>
References: <pull.1309.git.git.1660806376021.gitgitgadget@gmail.com> <pull.1309.v2.git.git.1660809243298.gitgitgadget@gmail.com> <xmqqk075qyq0.fsf@gitster.g> <CM9DZ4Z18PY9.1T2O8U54X66FD@cedar> <CAP8UFD1304rQh+9jMUkTmTvmNBxm6BNDt3=d07+C8iXSbJb2RA@mail.gmail.com>
 <xmqqa681nsrv.fsf@gitster.g> <xmqqwnb4n98f.fsf@gitster.g> <CAP8UFD2kMXHxvg1tKVNLhY0Gweq2YrD7+tHmZXKwguYzRQ1Qpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:p3Y/RYk9sty9gWhqsdXqel8AerYVYoAPASq29EMiO6jlOu1qvIl
 MJLzz4M0ihDMzHZZE3xiWajCA4B1ppdfTxlYaDceYG/Tzu1mAMmtAD1j8GSghR9xBarIx6q
 e9EhPYIy/FdmnqMszTvqp8WayKBQQ3vWdASKQ51Q2axFY41F98CpohDVFgiri6jh3ZKHS25
 FYJSp+li8PaZliKAoteSg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Izf5u6Jk9l0=:XsOELhTdKFoK0U0JlrlvvY
 msXgyF/bA6oVPejbpCaf9R9wtNccyh6TocZBGfKRMH/3Z4qUI/noH6gPHYuIQpfYt+LXf8x4i
 y9DTvIuybtu/Yz2OagtL5atdpFKP5Gd50LkpluU6a2F9DgKG8xzM+M6gEAT7AgewGizQzrlLh
 tgJgYeTqoHjBxuG0ugHXn2Ep9GwSBfOYc6gEitWa459xcxQRjpokhWRXH34sTGPXts8TSLkSE
 cpiQczP5jJ9QooNHFQY8tcEaHFk4lRUp7q8GnZQH2Zblp9oAUKjMVLmRoQiP7ml3hsqqvGPlj
 7q6eu95rl6zirF6aAZJej0zYgKblnPhltQjLVUZp//ETEv/uus3SkaLQSk6j6XnZAMHj+xoG+
 xNGEomTr/rJGOwod7uTRgIac9FFJn7iKd+kRW85PYYU8yIRlxau8An59pexwnj8ftJ4Tl5i4A
 IstkqXv8J+Yd6IMQ0AcrmzPl3mv0gMKpK63I7/a1VvraZkTIu2PP6pNFFI+8dDgFvfKCByo/X
 aWAzmZcY5ZVrl7H7/CKRgl5etpN8jVGlMO4dPGukHS/3i+o0ZWNOnc6FkfFKnkWbfedPouxtB
 Za+IPtyNazrn3ngFAj1HEzU5aS11FDXsA4nrnDwXM0lRdxv1epJ5oW8MbFxjMYYro9e27ykJj
 /Eh8pDqXYq6vMy7IjPP3r6R34oxe60JVvrYZ/BzDCIKbN3arp2nfc3zqluGcw0F/cOO/XJEFB
 gHXNxFavkDiNPD366skd/aHD4aeSFYl3w70fsQlW5mGtaQ1TdashMdvPXZtSa4aHTQJpm27Ow
 2EaCQw/1WKVusCnQCYPzFpVOt2rJOETs/tW3bxNj3BRupRXNvfmiYZ0dqeBRbrg73MYQm2T94
 WlymyRKrJYb+XsG/TuxyGef7pR9zTlkXBFV3xSIgESeRQ11E2QFici5ygDhYqge5x6urAyhRS
 GGx+gtLzhDDwwenAf1npptrMBUMSDJ/hQ1cVkobwQjI+jYCN5P4ekgA4DxqxSbLkJG6+x3hN0
 PB+w+KGLB8aFKn8exB3O/sxwYtTy2tCoAKMiJoFt63FDGg0zIVM3rXaVJJWYSxSFCjLUX1BIr
 LSQq7qpcnOiTfp5pD8Pjq9f/6PpWZkQLl1TZCX8qlSkVmxJiwmLlzcaDw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

On Fri, 19 Aug 2022, Christian Couder wrote:

> On Fri, Aug 19, 2022 at 6:33 AM Junio C Hamano <gitster@pobox.com> wrote=
:
> >
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> > > but see a room for unrelated improvement from the current code,
> > > namely, to allow exactly one optional space, immediately before the
> > > separator and nowhere else.
> >
> > Ah, no, sorry, I misread the situation.  It's not a room for
> > improvement.  It is very close to what the current code already does,
> > i.e. to allow optional spaces immediately before the separator.  The
> > difference is that the current code allows arbitrary number of
> > optional spaces, not zero or exactly one.
>
> Yeah, I think it makes sense to not change this default behavior, but
> maybe, if people don't like it for some reason, allow options to tweak
> it.

That sounds like a very good compromise to me.

Ciao,
Dscho
