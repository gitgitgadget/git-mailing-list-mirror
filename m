Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D83C388F2
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 13:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 708D0223FB
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 13:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="NGI393AL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506460AbgJVNBt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Oct 2020 09:01:49 -0400
Received: from mout.gmx.net ([212.227.15.15]:47205 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440897AbgJVNBt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 09:01:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603371704;
        bh=tNBo/zr9FgoTHgwuOepE09Kk09u+iwqjx6IDtiPxr4I=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=NGI393ALwlbuYh2kSj9aBmuApyAhhHJvqdrgrHkNo/isP452usJsuSnyO1NE52f5C
         zvlrC+C8f3Eih451iAqChSto9irSwCRSYdafeeZ3tE4AfgLmWq1iVwOASD167Ym2eb
         XLC3wsdRgBlRuQ04TVexHiJknAqu2wtKqMN6El+U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.45]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2wL0-1kYtbv3Zls-003PX3; Thu, 22
 Oct 2020 15:01:43 +0200
Date:   Thu, 22 Oct 2020 15:01:44 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 05/10] t6200: adjust suppression pattern to also match
 "main"
In-Reply-To: <xmqqpn5b43lv.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2010221501250.56@tvgsbejvaqbjf.bet>
References: <pull.758.git.1603135902.gitgitgadget@gmail.com> <7860d8d7df43075ad5424d8210d6f6e17c2042db.1603135903.git.gitgitgadget@gmail.com> <xmqqpn5b43lv.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:bai3i/E0a9obwKkwmL12r0PN2CWTg3gYxL0Yb/l+Xp2P0mG5Sbf
 2mmf7JXg5EnnsV+cM9Yy+ZBoItTqI3hJs1+lFILzYkyz+bVHzXAhhfPeVnjehRPAoLz7JtU
 KvZCuGWjeqTngLLl9Gl2/hpXTelL++CqF8Wswn0DIx1kGAg1XXVJrkTizL5z0C8bRPzq7qn
 RAc1ptQS24Nss+NBZmkZw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uCNY1/hk1og=:tVObJNP8cBEfjnhUqDjpJV
 m9ZkJ9EYNllQcJFL3GG3zXBK8KHDwWsytmi80jUgvMrTvjqBElzkDw34yb6E4eNUXZpoFxwT6
 1DPTTmAKdiJHqcBCr83LfsxkR2rjcijMUy8vD3N4GDNtVk8PoCgCXXM33drQvD/9+BJT7h+XK
 l0wH7YVhE75X49w8FKfE6LSQT3i6905aTLeGGrLvYZj8pRrHjjvdyjgESIfq9X2yYSJpQKtKx
 g8BY3bUvkcbSTecXHiSdTHc3v7XxzrYedTgttf9mLDj9kf44rrUhPuY6xSRVhe7NFmFzpriV3
 u25y5N1YhwfA61i/BjiX04g1ncalXj+3ZLbo7WuatjAQlCl267A/MuTBUYiWJ8Znh8DCqlnfI
 grtjKtQg8JG0Nglau0q4V1SXHhSe45GGHpO8jYgLuQB2rQ3uhYZtBzoqAuZqjq5ZNPRCKjyuI
 Mqy5wEZ3ARGmc8APatA966cgxijqSHTCHtff/V5Iu25j7ZNOACnJDuJzram2aF18k1DRbc8a/
 VFGmnZtC+zXhofGV+wr6qfi9yCEtFX+cL7bqsE0N9QNrxpi/2DpDzUeARSI2zS9lnybH40q3D
 nFU+JuqFi5VX5K+1aTBrQEfx6qJTFdBFGaHbeTMwJA9mF+S+2XHjCcXfpntfUl/gVwhHnmkiZ
 YvzEM8Zrj1wHEuXaEZFyEds24jJSLSFnry5eaVxY5Yjj8X2jR/FIoLoSTI4OEPgG6vK7fsNMe
 D6INgEA7ZZSvMxihwyzfwEAjs+xnw13Go21q9RpqP1iXuwVVdHmqUA5FSf9VQMTLXLAXHgDuT
 KutupVNInftf1Bn0QhY/BpOakTV085yBQecOy2GRj4Acn84VA3H21GyPR6OQ0S9bbLbIwMr3F
 f7DmPOifa4u2n8eUvOmk6str0ctebQsQj9LjUdGQw=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 21 Oct 2020, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > -	git -c merge.suppressDest=3D"ma??er" fmt-merge-msg <.git/FETCH_HEAD =
>full.3 &&
> > +	git -c merge.suppressDest=3D"ma*" fmt-merge-msg <.git/FETCH_HEAD >fu=
ll.3 &&
>
> Cute.  IIRC, the point of this test was to ensure that a glob
> pattern works, so we can do a bit better to avoid colliding with
> another common name 'maint' by tightening the pattern to something
> like "ma?*[rn]".

Good idea. I changed it locally.

Ciao,
Dscho
