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
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F7B61F453
	for <e@80x24.org>; Tue, 30 Apr 2019 23:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfD3XT0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Apr 2019 19:19:26 -0400
Received: from mout.gmx.net ([212.227.15.18]:54529 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbfD3XT0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Apr 2019 19:19:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556666362;
        bh=XC4EW/iiT1i41UtGvu5xUrS1CFD/3bK9ivXei2JcBlU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=EUxSppP2Ku8LSEblseySD3aHWpyjofXk+62+a6QC1aJneiL7s97b2PJyyFzOoFOrR
         ruACw9Qb+2gzDqj/Ws/8MnpvuDicZsf+aZDWP6g1DG86+yJKpk3rsYCYEpbUwfrXc1
         /9GGRzwgKBa2MCmnyc5Xf9RiZS92o+moAAlRhitM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.96.188] ([12.174.135.204]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MILxX-1hLL302c6J-004Dyr; Wed, 01
 May 2019 01:19:21 +0200
Date:   Tue, 30 Apr 2019 19:19:19 -0400 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Cameron Steffen <cam.steffen94@gmail.com>, git@vger.kernel.org
Subject: Re: Stage or discard a hunk at a time?
In-Reply-To: <20190422192821.GA22798@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1904301918230.45@tvgsbejvaqbjf.bet>
References: <CAAVFnNminTx_z9Y=jhzDnT0n5_zGD_k2SA84HQqMvKHJSvKcSA@mail.gmail.com> <20190422192821.GA22798@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7wKg7hWPHRjUjV8ZH0Oe+3TAEzpyrdvbBxxeg6CdpbJr4q1gF8O
 dqh3t+XZzmkAbCOxzxtVx6R43UZrqI2Nsdwtfs1kqjxKs+TAU5GsJYRCAc7kaQGoaSvyOM3
 yOb0tXyI8iyw3uU2L5oSFTquGm/irOMOvdLZ8/bzdO6oqm/Ezp+/Bw45LLqMjpo8IlbRp5F
 TsUOObxIsYaGR7HDTMyDA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:N83PFx55q4c=:f88K2kW0+4pPdkVpjHsztJ
 On0krHQZmWUIjmjlyiloB4TqI2HfuyWIP5o9nwICEdfjeTR8XRjABsvVK3vxmpz4hroIVIHVm
 UCLWfqW1lUKVFHPX0K3FWrYC9HzyqANHjNK84wHXo4AHatUGXgL9WwuDkQHoSqYYliKERNsay
 cYrPeLLiTAnfxoRqGYDjnIZp5P8UWEtatz9merwDxaiYpzXVLrub1tQfuVGSoOIzyY5kpXY4l
 EKHKfPf1F2N7dBggy3MkabZSop+WwEKLVYG5hQmj5SBNf3usJP5oa/Us1Ug7ouSz0KZ3MqLz/
 EYjCyoOQEj8/2S+hZwh+uA7c1xmvioK65f7YM4gF/btUF59HQfKTLXeaSRWV1+5eB7kLkT293
 zhQlYDcongj2qY8zU3ojU0JGgTGW14GJNh6UuzbzDZH0uCWvhUOWIUdBAh6qAMBIH2wyZuBNR
 kn4Tl1bJ0jh99WYIAjW0sM3Q85LzPUTR0p7OuBTbm7dcbL5SR2f1ASKwXot7NXnXZaOX2qoIT
 dkuRZYTfE7xDutPnJqoE7SXcSmbycF2Vrid/3Tym6oYcZvW3BOqDeQDgllJFnGeK//gyVtfAp
 Oi/+wpfClppnTVc7eSBIAAsU2m+nUFNscNXMnVG8Cy63GQxSHin6JSlE15XnJZYQSfiK9hb1c
 0LLTge8MRO7l40NzGEq8CsWohpYis0Jnt450C79CMo9efy0GDOMGWQ3iYiTzM1iIP9IfI8hdL
 TnTeAloZFjUIfgSetpIgO8ViG+gyFAdYON677ic7dWnaeZCspNGfTSsqx9E8o61xWqqV3PWvN
 ryQsACIxYafU9gPYnTfmzVc1VeX8ytjxifgRzYXDUbhA9eSRA0WcPt7YpmJdOBWSPN1UMlVxs
 tpzb3bFfrFbtdhAkNMdY1v/TyrZvj8mRnINe/Iu3UCAcjD2Yxnql/J7/S+vCn9W9VMmZwffeo
 3amUl+/0DuA==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 22 Apr 2019, Jeff King wrote:

> On Wed, Jan 16, 2019 at 01:09:03PM -0600, Cameron Steffen wrote:
>
> > I have this feature idea for git. There should be a command that
> > effectively combines git add -p and git checkout -p so that I can
> > navigate changed hunks and either stage or discard them.
> >
> > There is already a SO question asking about this exactly...
> > https://stackoverflow.com/questions/11538650/simultaneously-git-add-p-=
and-git-checkout-p
> >
> > Has this been discussed before? Is this a reasonable request? If so, I
> > might look into contributing the change myself.
>
> This is something I've sometimes wanted, too. I don't think it would be
> _too_ hard to do by modifying the add-interactive code. Both of those
> operations are driven by the same code; see the %patch_modes hash in
> git-add--interactive.perl, which defines the various situations. You
> would need to modify the actual code to handle the tri-state (there is
> not just "yes, apply it" and "no, leave it alone", but now "apply /
> discard / skip"). But it seems do-able.
>
> If you do plan to work on it, be aware that the perl bits of
> add--interactive are being re-written in C. So it might make sense to
> target the new C implementation instead of modifying the perl.

The work on that is tracked in PRs 170-175 on
https://github.com/gitgitgadget/git, i.e.

- https://github.com/gitgitgadget/git/pull/170
- https://github.com/gitgitgadget/git/pull/171
- https://github.com/gitgitgadget/git/pull/172
- https://github.com/gitgitgadget/git/pull/173
- https://github.com/gitgitgadget/git/pull/174
- https://github.com/gitgitgadget/git/pull/175

Ciao,
Johannes
