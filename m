Return-Path: <SRS0=27Fn=A3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCEDC433E1
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 09:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67A4420656
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 09:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="IsrAuUyg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgGPJkK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 05:40:10 -0400
Received: from mout.gmx.net ([212.227.15.15]:33703 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbgGPJkJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 05:40:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1594892395;
        bh=yon9e8nVczTTIzEb+om78gYaQDEEQdmcb7D6fyg0PAs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=IsrAuUyg8LSmyEKgbjru00sQD6n/ttB186hVwwCevV5tYPqENrf6DooliFQ71aP2N
         FfiJAl+wDMGx59AA5VXg3JDDnybXZpFs16BNPCgx2C/Sythat3wXcYDWwvxNueMYzm
         NL0I9aqzEAB6IOrdaTIA/7CyRbOLAiVqwfIm0nM0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.237.98] ([213.196.212.102]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MryXH-1kb6Te0l41-00o2eW; Thu, 16
 Jul 2020 11:39:55 +0200
Date:   Thu, 16 Jul 2020 10:13:27 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>, delphij@google.com,
        Huan Huan Chen <huanhuanchen@google.com>
Subject: Re: [PATCH 0/2] extensions.* fixes for 2.28 (Re: [PATCH] setup: warn
 about un-enabled extensions)
In-Reply-To: <20200716062054.GA3242764@google.com>
Message-ID: <nycvar.QRO.7.76.6.2007161011270.54@tvgsbejvaqbjf.bet>
References: <pull.675.git.1594677321039.gitgitgadget@gmail.com> <0bede821-139a-d805-934a-142004abaa4c@gmail.com> <nycvar.QRO.7.76.6.2007141420300.52@tvgsbejvaqbjf.bet> <xmqqzh82ktgm.fsf@gitster.c.googlers.com> <xmqqpn8wkben.fsf@gitster.c.googlers.com>
 <20200716062054.GA3242764@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:mPe8tta6r5MqXzrNTLEq8E+UIi9SgpCgL5HQgAlJmj4pXGXjp2f
 B1A/97gSW1ThAf/LlYmXPY09ILAmUrs9dOrNeYYfUus6g6u7j7eeJ/PKWVpomtp1yMvbBGQ
 ICFHdITu7/WE+VLRruVbZHU9THGmlQHnAS4tiXJUQPn+rTMgd9YGJuJxBfmbuO16bSx6WdP
 2+B7W0TvWxUk6vywkkzUQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qgF9lZCodoU=:DtOOoGEDBbMWWs+c0fmbRV
 PBAe+DApUBoMZ5JI9TSSX7BmDYLU2i8VLfoP5avHsmY9j3+wH/SVCdxPBTTh3xJGfvMON68nL
 WlEzhhxz6xsZ2YTYZ+PesMQb5Iaw+uFURFrA3dyWJRcHCFr76sCAYSQ6A/3tLoZBeDYfMGvMh
 QpRyb0WWEkHMSgbndRzVbyGlf0v8icw0LvE3yZIPz73XUV9IRBIeW2FOozP1Eo5yvB/8hZ2cN
 cDcBFFtP0/NJHj4AE2lmNUuWxWnFWxagyVueENnnbbMF03isE50eyQnTtw50R4syRJRevNBJJ
 A+rO537Ke4emF4BDSJvFmsgtUgMVVxtQzEK8DhJKciD4klEOrPsUp4+CGojhSz90X4rVvIsxD
 vLQbvTFbK8Kh0zCH1nTJkF9kX9fpsGGrWuWhjcz+C/yEYF3gHt4Ow+lEqC1Tq6iKvl60//ltd
 DypERl5AvV+DSlLAHEJVX45AG2aQiJGBXUgT3SAbfsSPOW6PD9tdw4YtnMVSICg3KByEXyUBn
 WwPWIDK2RVo8/QimsfJBuW5GmvmdWdBSGEoExoJ2fqQh45/GYlFWJL7cV4w2GcJT+r5fboio3
 r7KrLRnZH3JWLDo076QlsjgQ3G34qTPAylsO8aNl+5zn4znEFo//C6vNvsq+iPTx8A4Z8INW6
 i2MONjrtcnIKPOxCNqwUSRYtuxdp9O9vUmqMo/EnO9IOmXN7iLVt6NQOybOz6Gk8KXSDYHAW5
 gyCOnviz7NldksB8bjGuNAP4QzGW7YLOunRlrWtv0w4TH4pSmuqH5zEXavecLSJ9pCobR9FOr
 suo8y62/ITPuNMrTEIWE4xsPZZ1994oBToPAl4uD9EBij8YCVBXOsbckrTCTQBntw5jpmJ8pR
 HJGpdA6OE3XAp5ozjaChqIDPgkk9tAIOVrd0mY2LyPuL6yrXB4f1ENev/slJ6hES/GTmWkjUw
 87Ssh2Yd1kXJdUDSXi+7KcSrS+ITZGRYo/cGlckVSPDv7dgqEPl15Nedj/9h6adKxvMf+uIvJ
 /HmGD4F22emWyeK1aeZP66ny+rYw1xf61SNkNZUcr1e/v32iBDpv7/KhO/jIxSh/AnyqvGMHr
 8UxFT7ENwFULD6ffmuyfP8culT7PVS4nD/dK771TaoHV7fZf/YkwrknozIqmtoHJW05PMVGBc
 Pimqb/Hjnl82+0aG/eZIluEYIE8EKCxMMyu5ek8VVfhAN8f/i9ocaidla/RzfvTsyW/ZwyonM
 ixCikSmhtDc8Sg5RkMOy6z/Kj8Z8ArQNKCnlfgw==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Wed, 15 Jul 2020, Jonathan Nieder wrote:

> Junio C Hamano wrote:
>
> > Here is my quick attempt to see how far we can go with the
> > "different endgame" approach, to be applied on top of those two
> > patches.
>
> Here are patches implementing the minimal fix that I'd recommend.
> These apply against "master" without requiring any other patches
> as prerequisites.  Thoughts?

IIUC all of the existing `extensions.*` predate the reverted strict check,
right? And the idea is that future `extensions.*` will only work when
`repositoryFormatVersion` is larger than 1, right?

I would have been fine with Junio's patch on top of Stolee's, and I am
equally fine with this patch series. My main aim is not so much
future-proofing, though, as it is to avoid regressions in existing setups.

Thanks,
Dscho
