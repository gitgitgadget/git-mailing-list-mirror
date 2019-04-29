Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D2FF1F453
	for <e@80x24.org>; Mon, 29 Apr 2019 23:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbfD2XRz (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 19:17:55 -0400
Received: from mout.gmx.net ([212.227.15.18]:44271 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729015AbfD2XRy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 19:17:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556579866;
        bh=G2Wz7lICUcMnx+xJzmTrSLQx0wAfC9+4U9Hhx7msBT4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=C18XfpkKlZawZjgDPUQ9b3xaDYF3+SYlsNXT3WgYVJvq/hDxBdbwx2ZKpRwVCACz1
         adm0Zo+jfdiFTz7rKKok90qHMFAG5Gx2DGgriNPD7eKMNuH3b9GrH2Ki6J6Qn/EQpN
         cIbNE7uthNqmkUtcl2pF8YVaahY+lMSDXkN7ov6w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.96.188] ([12.174.135.204]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M6ilI-1gXhJG0rjQ-00wTmk; Tue, 30
 Apr 2019 01:17:46 +0200
Date:   Mon, 29 Apr 2019 19:17:48 -0400 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Thomas Braun via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Braun <thomas.braun@byte-physics.de>
Subject: Re: [PATCH 1/1] mingw: optionally disable side-band-64k for
 transport
In-Reply-To: <CAPig+cT1EP+HC5h4e0NGCu=1i6cZXPxERRgnnAdZJn+XeqpbFw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1904291916510.45@tvgsbejvaqbjf.bet>
References: <pull.137.git.gitgitgadget@gmail.com> <31aa7bfcab834b753cc9f52fc9cc187f65e2d964.1556575475.git.gitgitgadget@gmail.com> <CAPig+cT1EP+HC5h4e0NGCu=1i6cZXPxERRgnnAdZJn+XeqpbFw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Dcllkx7a1BUL56w7bUKaOWAOA7e+1h6CWLGnng7tgGnLRs8ontO
 xvmkDu9sHPYPJHyBLC07AYcP8ikpI/c37rj6LfNJCXWxPsUyn9S0I/c5qEvklzzHgegEhmB
 zdagTu+J37+2wQhDIFJx5brczZmPXiYEnad9ltoMpmGJkpQUKdySbw8zjNI8BPBHY1eEuqT
 Zs6i7mQsA9jLoix1jpc/w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NWdUmufALM8=:PRZSxdh3fQP1lDCE0QAkjD
 UZF863wrVBS8+ZSb0Z/63iR0ikNY8VpYkl/e5pcAR5x217VNiLR83X4xph1ae32jJUZeuBL7L
 R35q9ANptcYgvItwWOj4+Dg26DOX1wXCGe/7Q1SgTuVl3FK+5vrjVbtKlJLZC3rbD71kHniJi
 QADzeYcM/1O0Sx3gho5RqFRW9qLRApldByhbbiPKRnmitieFDCynCWSANtjXz+pxk5caAx6rl
 ZuJl/P35FYCinPwQi48VnUS5Y62UCfQWNZ4PlZPu0PfE08vQ3cFQtXzoXX3UXijSXnuXfzKL6
 Wn92A+vNXnzfsE7wuDJ6z6+PC9vZZPCG+uOp90GXmCsKZuzRfsIbCzsZ0s679WrIt2P1eov1A
 Yv6Dw0k5egrmdrPwUakL8dTZFNyQNH+V/bkIREaZj+8GJn261jI7DlmvJEClU6smtbP2Ok+J7
 a6SJ33w4Idc/+ZSFPEL2Tfw3xJKMJm9GsJKb9oS4Ikmv7fE36PvFYF6VGbV0vgXVGKFIGwG5y
 Mi1qqloS3osXS43rgONjhCQeHtSJx9giYeByDg4bJwIHLtMj2mMMHUje8iUj0B1AaD79xIc9W
 Nwop6QkAw8JsJrxSDC/H+eadDXwjsa+MGxJQWThCxE6dH6+j0ri6Gx5WpBQ6G475G79X0u0U+
 qc6elr4jULi+FvEcuVTslVzlsXQ06UMLnqxdjQqcU0+lX5mL3Bm2/l39sQ3Gw3neS2iEBTyEC
 p0JlYp6+39WC8pFessHNtfKHYdNh8FLpWzpx2qxVDRupofmwL2zpDFY+8A4AciJHvSaj6EWVi
 pnX4vB2P+yNSiowItRIMtg7h3v3U4m5duwrxdY8tkR2Ayv2FEnZl9MBuvCHik/hHA4RtJqiXI
 Soh3jJTMJ9OavQ7ReFFOJ9Y00Gx8A7pOIAgTfdnlJWUb716lcE0ZTUX522IDlqM87CfGqbaB2
 SN2Js9Q+s0Q==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Mon, 29 Apr 2019, Eric Sunshine wrote:

> On Mon, Apr 29, 2019 at 6:04 PM Thomas Braun via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > Since commit 0c499ea60f (send-pack: demultiplex a sideband stream with
> > status data, 2010-02-05) the built-in send-pack uses the side-band-64k
> > capability if advertised by the server.
> >
> > Unfortunately this breaks pushing over the dump git protocol if used
>
> s/dump/dumb/

Of course!

> > over a network connection when using MinGW (but *not* when using
> > mingw-w64).
> > [...]
> > The new config option "sendpack.sideband" allows to override the
> > side-band-64k capability of the server, and thus makes the dump git
> > protocol work.
> > [...]
> > Signed-off-by: Thomas Braun <thomas.braun@byte-physics.de>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > diff --git a/Documentation/config/sendpack.txt b/Documentation/config/=
sendpack.txt
> > @@ -0,0 +1,5 @@
> > +sendpack.sideband::
> > +       Allows to disable the side-band-64k capability for send-pack e=
ven
> > +       when it is advertised by the server. Makes it possible to work
> > +       around a limitation in the git for windows implementation toge=
ther
> > +       with the dump git protocol. Defaults to true.
>
> s/dump/dumb/
>
> For someone who hasn't read the commit message of this patch, "work
> around a limitation in ... git for windows" doesn't mean much. Perhaps
> this documentation could explain in more precise terms under what
> circumstances this option should be used?

You're right, this is confusing, especially since Git for Windows 2.x does
not have that bug.

I simply dropped that sentence.

Thanks!
Dscho
