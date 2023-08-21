Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC37EE4993
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 14:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbjHUO4w (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 10:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjHUO4v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 10:56:51 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFFDE2
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 07:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1692629791; x=1693234591; i=johannes.schindelin@gmx.de;
 bh=hqLBhs0BA7NjarIpgt0d5BizW8eD14j39hcWhbuJKNc=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=eAd5tq9QQJFLhoSFOrinJt4WiEjnuKm3SmmIBAdVg05i/qM2Oh5bQ33Rf+JENjxPqgzto2R
 Z9BPAoGwaDL8GwdlYQYiZxrUMeYSx3bcFFLF7RwEAQbCCvj9V/UJJ+CpHbR+89orolXrOlKsL
 EKsihxkvVBtXWCx0BFs6nHDvvSyq6xbyRKHkIeyZfHwrKNLpa2zYzSy+3Q05JV+2N00MnIN4H
 OKCHOWlg61IoSbm0SHVjC1UMF3f322DflxdHziaeH8fgeTl4aFVgS+a99g2lUgrA9vjsp+IdN
 ebEpPvxzCMaUHY6+NUN1Qr971DsKABU/rqbWPQSEcBZPfsCq4Pug==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.15]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MoO6C-1pwmVa49iC-00okSt; Mon, 21
 Aug 2023 16:56:31 +0200
Date:   Mon, 21 Aug 2023 16:56:28 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     rsbecker@nexbridge.com, 'Jeff King' <peff@peff.net>,
        'Taylor Blau' <me@ttaylorr.com>,
        'Andy Koppe' <andy.koppe@gmail.com>, git@vger.kernel.org
Subject: Re: main != master at github.com/git/git
In-Reply-To: <xmqqo7j5uqza.fsf@gitster.g>
Message-ID: <15b89f2e-adb8-ea2b-fd74-2cbe95e20501@gmx.de>
References: <20230715103758.3862-1-andy.koppe@gmail.com>        <20230715160730.4046-1-andy.koppe@gmail.com>        <kl6l351j22dr.fsf@chooglen-macbookpro.roam.corp.google.com>        <CAHWeT-ZA8f-TGRwDHixAvi5kddVBbuK8LpVGJ9cjYZMsMk5ODw@mail.gmail.com>     
   <xmqq7cpwjhr1.fsf@gitster.g>        <006574bd-4d53-495e-8cfe-677ede521908@gmail.com>        <xmqq350kjfk8.fsf@gitster.g>        <ce5d20db-2220-45dd-8c39-2a52e0f9f816@gmail.com>        <ZNv5PQlkn6tbUcH7@nand.local>        <20230816022420.GA2248431@coredump.intra.peff.net>
        <000901d9d045$e780f790$b682e6b0$@nexbridge.com> <xmqqo7j5uqza.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:GWg65h7D55JTD9+OzbPV2b9FMc4Qj8YKFCCfE2IHS+o08SNvlQp
 GLHbkyyXuhgZWHM/fDEhqBzACTo4M1eLzWgKC8lxooxGyde+KHQ8o7QPW54soCf4F/yJBmL
 Ex20hSmPJR8+HdymNpaZBgv71KEoc8UKFVblkJtxdoX/kkLXJ1GKAAoulAbLVL5IR2FDeml
 GUoDQY967YLF0ahn8Hc7Q==
UI-OutboundReport: notjunk:1;M01:P0:hS+YkmH68L8=;2QrKRKnjfoGh2BML+UYc52VjAbm
 5AWrW9n8aOj6Nk6tqMFDOmSPwWT8YErhQGaIpmpHnENHnlbJvkOtmCbMk2gmN0hS1e6sYryV4
 La2K+l7BglFlp6PeBOHUPnHfxSkZ78b04/WGYsrMWT0GAWWB4X8YXfUJYdAtBzlP5mo12A4UZ
 pHkcCey5Pk22C140veM2DN+eDUYIC/B0JVIo+lxMADf6hJg6npJ/XdLvhk7icuN/TLEntDtPb
 WhrDIAF85hRTC4epJpV+sn1wXAoCekTPOXGmhpp04yRbKAdP9lf8DPu8kPUNd8P0V2Mtnf0qH
 PnsuWwePgcxC/rvdmxP3f3XlDe9TNV+HYrLXniCxer8KMrbpJX2Nv/eyhW4S+pbhmn17j1xOr
 3XYKJI1T4SoZg9YUkkBRgTxu1mMjlXAZ39mBMbajUWuDJulxr4ta04HQYnm/gij2eZAziTH2O
 uWShEWkTLKBFq1euRnn/qAXBxI8uRRMr4vLzny8CxoglBrc+mYQUlqoNxvqFBTL6nI7JUyinW
 tbQotezBf2e0psi5nl1V+eNGU4Pmds1ALg5Qot2RnsOrxYWGDB1Lf3CBYVs+yxMbV7t9mEBoY
 UmI9shiZKaTq1zcJBwk/lXwKfk5ypHh6IHAFFFSadrBLfjDCmzE4gJFOQsZ6HDQMKkz6Led4h
 XUbo3HcIu3Eg/7pmoL6MI/E6pJtZf/5vdIVREvrtQO1Mj1ULzsKR30PAMqgN9T7t4g/EcBqLr
 tDxQe+nmXGRaBfcS4wW35UXiakP8ACkQmUBvY8TOEgnIBQ6LZwTiB5eBqO0xpCP3v8fHGTpKC
 EajqiQBRP+mllFqhm3hfslY8EsfSoS3NxiBwXn7fLiyzgUE7CDUkTv5KZr+NnZ6YiH/t7YFvt
 SakoqABvtAE6DLzCH9xurna8BV0d6fBLfRTKbQ9COWqduni3kXKCVNuSyhydS1DapxIqzBiPW
 YNVdlVrzfDhb1cMNSNXg+hci5iQ=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 17 Aug 2023, Junio C Hamano wrote:

> <rsbecker@nexbridge.com> writes:
>
> [...] when CI runner sees branches updated to commit that hasn't been
> worked on, a new job is created to work on that commit, and updating two
> branches with the same commit at the same time unfortunately means two
> independent CI jobs work on the same commit in parallel.

My understanding is that the recommended way to handle this via the
`concurrency` key [*1*]. That is, if we changed

    concurrency:
      group: windows-build-${{ github.ref }}
      cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent =3D=
=3D 'yes' }}

to

    concurrency:
      group: windows-build-${{ github.sha }}

then pushing both `master` and `next` pointing at the same commit would
start only one of the workflow runs immediately, keeping the second one
pending until the first run is done. If the first run succeeds, the second
run will pick up that status and avoid running everything all over again,
via `skip-if-redundant`.

Ciao,
Johannes

Footnote *1*:
https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-git=
hub-actions#concurrency
