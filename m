Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2028FC5519F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 22:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94CB9246DE
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 22:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="GWJqDXAc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgKRW0E (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 17:26:04 -0500
Received: from mout.gmx.net ([212.227.17.22]:59349 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgKRW0E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 17:26:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605738359;
        bh=gZPx9xYEK7FcTfDPhRlBy+NQRRJy+Ubr/rghge/dxn8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=GWJqDXAcbS01hXtquG+prh/ZjI9bUi0rVuEKVZFZuopuQvHxPIbiGQ5qBwUh6sklq
         WsJhibUQyqWL+7lMWy4TN011bLEOav+xhWHfBbv/jZe2zNw5ya8jcYGYGPZga9D77K
         KeV3t4LiptSoO3Ldp1IEEJqrFxpcxoMYjMFLG640=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.22.105] ([213.196.212.61]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mzyuc-1kIsAj2NZG-00x5wK; Wed, 18
 Nov 2020 23:25:59 +0100
Date:   Wed, 18 Nov 2020 23:25:58 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/3] t2106 vs. the default branch name
In-Reply-To: <xmqqsg96z602.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2011182324370.56@tvgsbejvaqbjf.bet>
References: <pull.792.git.1605710947.gitgitgadget@gmail.com>        <xmqq1rgq1jgf.fsf@gitster.c.googlers.com>        <nycvar.QRO.7.76.6.2011182152580.56@tvgsbejvaqbjf.bet> <xmqqsg96z602.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:+8RGoCZhaVhXVmcAW35ptWdj0kobNLJ5oT6jWXYQaCVslQ6NbIQ
 riHKJxdqvdHGNlNxz89EaJaKB7tcDnOPv+da71+Tq7UXN81FmeNzcwIbjy5OWnOSLBm8Ens
 H0I5xwvniqNB/7M+9eV0hde5DS4vRg8BKVp0lX1CEo3kce6RD//ivlcqh/T6RS8eEvdO4cl
 rt3C9zKW5JgJhmlzp5Sqg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ipv+9GNRNs8=:Ta4JcGLWN+Na21N2YtENPv
 PF6KFohv8koDq1Ymm8IqYPytpXW/TRwAsSRUUl6bLvA0yKiv1njGrbY3yik171raY7IolJo7R
 vd8xPCJ64hWScS0pm0efq42PNEgtOB1jW2nH6nD7o5RcGZvOvxfaAIY5Z8cUYPSEWUUfkfNJ8
 NMHsSdRZgnB9Cm7+zle91k8KTVOGZSVKG+b/d7xQbb5sIljBIbUsIxWDVmHgM//eMXkfKGP2N
 Lci+agsByzV1+MVBo+cIE8fY/Mklwuiqr0VV2G3hTBdsAwocfs82cKIqj8/BRVLQFqnRi9BKZ
 g0x6SGzJwZl3A3YM2VRLwsQD5hFarOFzfwFswILWK94b5qnqQtlysvayRSPVr996HIgucNLYr
 b6Q79oEtcJJ8xa/eXoIRrnKDEApIeR4fbBrnBySFDj8zyxCm1oGD5hcRsGDHPkhtS0S0ue/eq
 TZ9Ia9iQkhaPdETlxLUmcE42DlkpcQ+34bEO+HJAYPzfUuMnmq0xkUvvI+irbEm662YT3CYVx
 98uVJMYo+ihdc2dT7iAOPH491pxu2fyj5dMDwZiJuIcm+exLsjFbxPaM3/osKxwRzLgReI1Vj
 tJeiG28B3YKkZ6PZXOjYdeeHpsd6tCcb6t1v0icg0Ogy79Oq/F2N2qLE3FzU9USXfb++B+XN2
 HcWtMvsCzb9pFOwEYRrE0ARHx1xYHfk5vawddc3gK/4O1NMBxKuF70WJr+xOhH3y/fAmk3pRa
 93YSsL+jurwFgZHPfu0S2jpE4REH4ctmx1YkmsLzL58MP0mVxAwzTt4YHtfkfQskIz+vcE6sE
 RDrspbibZQpNFip6vJiriUO+3hc2jJMCUR8IJCRCnAdSt+uJDHxpucm0scfRXVL6l42cGoeF1
 Xr48oE1VRVPVcZJhCsZ1iRNpjK8H9R5fmsSoaBeAc=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 18 Nov 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>
> > The four test scripts for which I sent patch series in the past hours =
to
> > remove the use of the name `master` won't be touched by v3 of this her=
e
> > patch series at all (because it won't be necessary anymore).
>
> Ah, OK.  I somehow had an impression that the big series was more or
> less done

Me, too. And if I had listened to certain people who claim that lazy
programmers are the best programmers, I would have stopped there, too.

> but rethinking the structure and ejecting these changes to tests that do
> not care what name the "init" uses by default from the series makes a
> lot of sense.

Yep.

Ciao,
Dscho
