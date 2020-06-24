Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E449C433DF
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 12:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DD7320836
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 12:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="MJEB1LeN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390819AbgFXMot (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 08:44:49 -0400
Received: from mout.gmx.net ([212.227.17.20]:49131 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388942AbgFXMos (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 08:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593002660;
        bh=DDJlnUkyAHcu+8Q0v45YdzfgikXdhJiow/4mY5y/pZQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=MJEB1LeNb6nk4xBQdj1mmjVyBP5hQ8MRINfQtwDEupSFYjjhSE/mKEA6JaweHbEEr
         HS9UX7Zfw8rRZ5gkVYB4gfk73750ILCd6LRQDK73EIc7/Cb9loat/Ctgsm3r5pHRw1
         J+RfTgEGyr7fCBstWQb8XF+yWfqj4FQUZ2pqtUi4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.227.237] ([89.1.212.7]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MjS9C-1j7tBG2mCI-00kt5c; Wed, 24
 Jun 2020 14:44:20 +0200
Date:   Wed, 24 Jun 2020 14:44:20 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net,
        Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v3 2/8] send-pack/transport-helper: avoid mentioning a
 particular branch
In-Reply-To: <xmqqr1u59u5f.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2006241443200.54@tvgsbejvaqbjf.bet>
References: <pull.656.v2.git.1592225416.gitgitgadget@gmail.com> <pull.656.v3.git.1592951611.gitgitgadget@gmail.com> <a29943d7bbc11a524089348a4abbd33c7514eee9.1592951611.git.gitgitgadget@gmail.com> <xmqqr1u59u5f.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:RCvZ5uUfIA52SJlPy+3WZuA7LQ33g0V7MDppNJZRc/AcmjOx8WT
 3SVS7iAeEoiz+EL3B61hWtDhZ6FAiuyGL/DubTDVPhG6qUxds96ZlYylliYWQrRvdvjC68m
 naynGUIwxsSDnhOSFVgQew4xilVTgeMih1gI9A3KSLD8orttqQ2X1WdxojVawRBDR/JXr7m
 2kUde51It0t2x0MoguhGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qq4rEW53Rdk=:zIvcwQQ8n0SOlKdqydbDga
 edNMS9tOXON4emNjSJrM6uZJDU02dBA2KyiJ56Py38DLs0OKqouyzeUfrV0tfRR6DeWSiFobY
 PPSsMk5pE6hXXlxd6drFvpXMa5GVH+hw8i0DnBs9p//Sg3I7VUubvtSl1fIkX42jnxWKAEaLe
 kGfNkUfGkhYo996Cjtg5wNfrdWl7Jxfv1QGCXA/XkHr1etUKc+G5l8jOoOC1kn2cnm9SuJbo1
 h8bbEVDq9pEfpwj7xz/wBsuuXN3k8Ap0QYX6rjguj5Knw3XVXWU08+3o6er7pAg3bV95Ty7Vv
 zP2vnNCExIMrjddqr2/m7IEVKfb3Fd+hwpBTSDmF3CYvSm9zydCTdGC5Kz0dpFuhOe5tOp//d
 dARMvW10TvaFa5LOfZvzYLA6WuA9Q+a6G3rENF6NYDee5SMO9bHS6OZ2eikIV+FHsYD+r7s4i
 pgghcTDHvG8uyUK3aHnc5g33NBTsr5q2JWCvN4zpJbLIHW9RYINtfkDRvrN9iPNL3DSgxltbP
 /HQNYwiAn4QN2bFGmfLOzsXSbTmC0pDCgdPIFen+bDskjLHEhdIDctN/bUp1w2e1GK3mNSh/A
 Lt8trdYqhUpTO4pIc49s1S5QGlQomjURqLhuF5RR+ngdUHRncNiUl2mpY4Ktoe+H0F9nnQOwB
 VssAiscsDYSM5RuTfgN2Lwo9xE2WOIC8IzRcPS8tAzhV+ov3oc+Hqyx5UXL9EjV9a1r6hYuqO
 5ax9tsvVS3bhwQW1ylepUsJI+pO1xREXeCdvTbNIaN/O7noOPQ87WcrN9wlY0XLZBEF6SBBts
 Qwdhr7R/JF1YKjSRNBEtNdMNxuP3XXVYvGjd6QFjo4PHbk3GN+vsoP07OMyes+/ro8mK2wh3D
 ym8Hfm9xLd+Bzieb/pcyMn/iT4YrRApobZDSOGqVOFPjhelEcMHF797PtfmgfuH0wOt+oliwe
 61IBX3m6G2eBZ1VSV2oE9X2xwPS83RSrlwizmrjXyo/nGU8EiSpXdQ2o/qoYenJQGeOVSodw2
 uUBQp6s/0ON/9RJfoudfBiqcH0E44FbMAW25uDGApWU144ciszd8iS18CzmfEszYBh2DujszR
 aGgDC05RUtD7fbkFk7WE2VAgnHgowxAxw7LCkW4UHZbo4NyaM8O3vv3gyz6sqbtBWitMjS31x
 zhj94yBdMBn7Z88RW1y9OTcI8YRlnJXreMTIVTuk2s5S4q0rjpr9Pz9ShVVnQ3FA6fLoOQEqe
 r35FpTeujKkPhvegK
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 23 Jun 2020, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > @@ -1046,7 +1046,7 @@ static int push_refs(struct transport *transport=
,
> >  	if (!remote_refs) {
> >  		fprintf(stderr,
> >  			_("No refs in common and none specified; doing nothing.\n"
> > -			  "Perhaps you should specify a branch such as 'master'.\n"));
> > +			  "Perhaps you should specify a specific branch.\n"));
>
> Hmph, not just "specify a branch."?  Maybe it is just me, but
> "specify a specific branch" did not roll well on my tongue.

Oh well. "Perhaps you should specify a branch" sounded too judgmental to
me, but I'm not a native speaker, so I simply removed the word "specific".

Ciao,
Dscho
