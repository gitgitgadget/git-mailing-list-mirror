Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB680C433E6
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 12:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 878FE64F0B
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 12:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240363AbhCDMK0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 07:10:26 -0500
Received: from mout.gmx.net ([212.227.15.19]:35737 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240346AbhCDMKD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 07:10:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614859708;
        bh=cJ2jTlp+a6nCtRRUctbFQCLZV72oYbGMXxRd1kpetII=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ilSWsW+dJnnRf/WpQwTd4Jq8KU4Dge9xawc+f/JgGJrdQX4CSQxZOCOHXwIhlBUED
         +5QuJyofIsOGg3DGdRdAIG+tR3XutT7kijapc3t+jsg7Bq8pPz6AR3SANnsm+K6nd8
         BSDLD0ybV409Snl9H5zxO9Jk6x6LjfZtid+N8s18=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.162.2] ([89.1.215.248]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mkpav-1m3nAS3TQ7-00mGo1; Thu, 04
 Mar 2021 13:08:27 +0100
Date:   Thu, 4 Mar 2021 11:02:18 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     XonqNopp <xonqnoppp@gmail.com>, git@vger.kernel.org
Subject: =?UTF-8?Q?Re=3A_Proposal=C3=B6_git_push_-F?=
In-Reply-To: <xmqqim68lp20.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2103041045420.57@tvgsbejvaqbjf.bet>
References: <CAJU-ojOhSpGraS=Cwy=kMNxNgN=T=o7Eq-BxcAfSLHMzmtAm9Q@mail.gmail.com> <xmqqim68lp20.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Rv38lo8Z/XUCk3Qva9uKO41+A9V59huCXQcLckqVQ2/w2gaLnlk
 r+Zf3pA2ynnMbMYb6C9UYnJb5SHrY9GlIricnhZNDcfD6yNQok/kN29VyfQwprBRVNsG2sx
 R5be2I7vC8LlXJApXdhUaxt/2WQrv+Vp2uVaGeH7x9faJwHZIB/fdYkyEU4X7BD0JSNYZ76
 snkYxG2iFvtIc8RokZsyQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nVHO/cDrN6Y=:/tSpecvJNSU92kCSD/sP+W
 TXcNJwhP7ncuXn3qCi9jfkABkS63EtBdNsMNcPj7MCyUs9vMNP8xh83UaF5l/xd4NXz1ebh/X
 bzlAMK2zMMcTufBeCGsUuCx9ZwWgrhG8jhStnl9/VLck76YZy5HRviYSyo9B66NUP08R4wQHe
 /HR8FD8hrB99knmF48cnpl6gIJ+MMQKMOiqG9G8Dm+QkLiMlQ3IgNDe3BfaaHWwE7nZWFJr2j
 ETTV3zVdcqeWpLzAuQ1S4Npa7HkHgj5QL1+cN2e2MKhBF3J+SMrBm9m3Ty4BTvEdo3hkhtJyr
 1NMdDsbhGIxyotQEkgrbDHVCkixNXd/l9Hgw2eQhVm1749WCITo3UJpkzTwi2TSAESsFRx+Ml
 TNTEtjCdR7R2ABjL4vFaxQMqhTxklu73xJvdZcOBASRKP9V3JUnveYX8bizMHy/MkqeKPtph7
 Ilol72kFArKVN0IYIG0+sY1/q0PKDcLhEiD1fO/bK22q7rJBf0EAYJ8KVYOKXrZ/AbvgN5F9M
 xMm9MTqgjLvPJiHH08wlozeBC4xVXWA0Qadzwd41uZGJMajx7gGbAG73NJ8A06phQRAGGBabh
 KtrEctedsHayAVoz5mStnZtErLPml81vMldwffkEe2Z83OAvLu1OS0baAxpYyixGYZRxnMGIz
 WlWeE045LcqYcQBdIdfobhkmu9JDHjjmOBQ9rktdefNe9MEF4HNn+2lzkJY/sQOGmftSEJR+a
 idh4FRF+ta0r52Gf991faTHtOjDEp22ryq7W5FRmU5P+mE3x3XFyMLlSQ9y5TljrV0SVZvg+l
 gVnq5c9h6G2htvZgiIUozj1Eu1tsLqxZR3TekrsGvCAfmf3tbQPu8X5wPwZT4T5r6mktsKcZE
 2+zAWGCjjkfgJPkWYYJJDnPA6vTzySPM4Oemk6tl8=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 2 Mar 2021, Junio C Hamano wrote:

> XonqNopp <xonqnoppp@gmail.com> writes:
>
> > I have discovered some months ago that it is more safe to force a push=
 with
> > git push --force-with-lease
> >
> > But since then I keep wondering: why is this not the default?
>
> Because the form "--force-with-lease=3D<this-exact-commit>" is a
> strict improvement over "--force", but the lazy "guess where the
> other end should be" form, i.e. "--force-with-lease" alone, is worse
> than "--force" in that it gives users false sense of security
> without offering the safety the "lease" mechanism gives.

To add to that: some tools helpfully fetch in the background, therefore
remote-tracking branches are updated _without_ the user being aware of it.
In this instance, `--force-with-lease` is very dangerous.

We did introduce the `--force-if-includes` option, but it seems that we
made this option _not_ imply `--force-with-lease`, which makes it an
unwieldy `git push --force-with-lease --force-if-includes <refspec>`,
which admittedly not even _I_ type, and I really would benefit from this
option.

Maybe it is time to admit that `--force-if-includes` should imply
`--force-with-lease`, and then add `-F` as a shortcut?

Ciao,
Johannes
