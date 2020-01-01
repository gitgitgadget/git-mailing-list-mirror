Return-Path: <SRS0=Tp/o=2W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315D2C2D0DE
	for <git@archiver.kernel.org>; Wed,  1 Jan 2020 22:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 020102073D
	for <git@archiver.kernel.org>; Wed,  1 Jan 2020 22:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="bIVluzzj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbgAAWKy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jan 2020 17:10:54 -0500
Received: from mout.gmx.net ([212.227.17.21]:43631 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727290AbgAAWKx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jan 2020 17:10:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1577916650;
        bh=qihIGWxCKkZ89kB+ywVq5VWfmZtz3ds+0PcrPvsmtwM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bIVluzzjctPC9wPfqndwcrzTLzDg6sdD7FJ6QHtoYPwrKfWUm/EQy5/xUdCtNOVZF
         8vI+DMQWMEfSvrVG3D+fza6EAWYOEb7Q77UoFdQd3nA0NsczAtCXusHpttqQUpLDfd
         4vnjmLGVavnetNfNArSHrlvTiPiCtJuacuhb7QX0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5wPb-1ipEFF1GG3-007RAK; Wed, 01
 Jan 2020 23:10:50 +0100
Date:   Wed, 1 Jan 2020 23:10:35 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee <stolee@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 9/9] ci: include the built-in `git add -i` in the
 `linux-gcc` job
In-Reply-To: <600bb1f7-b54a-3bf7-40ae-af656768a752@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001012309390.46@tvgsbejvaqbjf.bet>
References: <pull.175.git.1576968120.gitgitgadget@gmail.com> <pull.175.v2.git.1577275020.gitgitgadget@gmail.com> <23a3a47b0193395a280f32c01deaae5bdeeaa051.1577275020.git.gitgitgadget@gmail.com> <600bb1f7-b54a-3bf7-40ae-af656768a752@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:VULmofNQCSJyel1+4ERNENPCaohpycmpvmRZZ5P0SD5fZbLtavC
 LgFGnN8n+1J/RZZ6chwdH7vxSLiMVBasQLgi6oQd2IUWafSbFTTowTt4aL9HGPMgBiGhQKR
 LBZOWdKxnv8I9BLuETzAprxwlwLWi2YHn/B9IsjmvJbt+sbg6k8YOssSzarqsULF6WFEbnJ
 Dv3fnYyFEez44PK/L6/Jg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sRVwIV4kEgU=:Bw340UEoGQXMt+7Cx+dTLR
 LVeYi6aewrddoGx4QLQWIhrj/q4MT3hPsLcrTrqUXWf0gY1BovGoOJzOzDFoQmlFNWGUWtjEP
 kTyr4DiTDSchySubkzTnZ0Oa+dppStmASz4glKZeOm6GNqK6x21jd9GEgiPp4FO6bvTrN9Z4Z
 2VJzzmBpsqoAGhbouLcB9U8rW8HqpZgNFzp3isL0q2nbxdJfH2O2zP2pWKsi44tABHtNP29D5
 DN2lL4GUmnlScD+x5wuWW/ILUzpd1QKTHMDae9nPmTmcp+5U9TZqJtV4s8P/X0xrjzlL9RW1E
 8nO5ZetDkAzOODIkq5zHZy7H/wwWt3OgtdU52DRB+dqPbf0XfQYedQZLnJXHQLZ40aeLEvoiw
 g5Le/uQNEEmnn1OK5rAFXA02do6BBbXaI4bEuqs2QTjnYg5mYNuAQwm/ll6F5I15t+6Cip8sa
 ghbYMe21UAGuARTFNjycX0sPmCyuij3slxOUQL1e/ohIs3viG9G6FqpfxN2YJmXTcmfCrxqE8
 AhUBY7wu3vYrtRG8f3rKvJRXodGUFBlX7iVqhaDI5DqPE18V6YdX1ab4KUeTIAwwoEcNPdY8r
 zYXXoIlnoqCUjMRDJXAakp8llJ0XWmimZxKtTDFPEB53fYRvaqG6E1NLObgj4tkSwKKcaMm3f
 sLscS9Tkd0mcX6KFeHGQTNzkX2IzmGdmW0IwUlKtHjPPoAfHE9G8dlYyPySWtXAT5dozOWoGq
 o5kJrke9l7M4TIKAPC07KWJnyLdahRnf4MqRHHBTwlOsnr6624NCXigJoDykhMNvptoiCCDBx
 ybxSFq9JwLSeJ2psICpfPZNLPi68B7q/7uk27iu+oPs3uO/0r9s/I1akn3oz4Anh6ykYnbSO1
 XsfVNjVzaZzXMeXq+PTtmPW3i1RuRUdFVLCdWjG7+Dda+FKxozlWlqwFl7sI1gN8iVpvrWzYt
 RRMSvjJxsHQRxaBP+reM0ZTrg3RGWQqA3Jl0jx9ALkjKboVcU6oH356HU9o+jk3eGYX5RGrWA
 Ea+h+/0LK8h2zPZh5S49BztkXHs4Nf+rv6e5PowyFI9LowNHGGgs/bSqnIKjRsq83uIGZ7VMX
 C4RAeLR+CP0xrLGPP4F4AF7q+2tJvs0XwbE3CneV17DG3VjMopSHVD1AH6hj8rmbdKpMKP3GB
 7fdGx/4JjKK9zeVZioyi9agacyrYeedAKmAdI087KLc1nqJb3cpodfW0+NaYljQJ1soLsvF9w
 QMZupInrB5rRENQq/Bi5PkxUnT+T9wqq/DKlMAbMZfGgaOpZ+NKBIxRdWbaI=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Thu, 26 Dec 2019, Derrick Stolee wrote:

> On 12/25/2019 6:57 AM, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > This job runs the test suite twice, once in regular mode, and once wit=
h
> > a whole slew of `GIT_TEST_*` variables set.
> >
> > Now that the built-in version of `git add --interactive` is
> > feature-complete, let's also throw `GIT_TEST_ADD_I_USE_BUILTIN` into
> > that fray.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  ci/run-build-and-tests.sh | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> > index ff0ef7f08e..4df54c4efe 100755
> > --- a/ci/run-build-and-tests.sh
> > +++ b/ci/run-build-and-tests.sh
> > @@ -20,6 +20,7 @@ linux-gcc)
> >  	export GIT_TEST_OE_DELTA_SIZE=3D5
> >  	export GIT_TEST_COMMIT_GRAPH=3D1
> >  	export GIT_TEST_MULTI_PACK_INDEX=3D1
> > +	export GIT_TEST_ADD_I_USE_BUILTIN=3D1
> >  	make test
>
> I see that I need to add this to the test-coverage builds.

Thank you for catching this!

It makes me wonder whether the test-coverage builds should use some `sed`
invocation on the `ci/run-build-and-tests.sh` script, though, so that you
do not have to edit the Azure Pipelines definition manually all the time?

Ciao,
Dscho
