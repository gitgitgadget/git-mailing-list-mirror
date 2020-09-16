Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EDBC2BB84
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 21:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 282A8206BE
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 21:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="dN1GrvBU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbgIPVFl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 17:05:41 -0400
Received: from mout.gmx.net ([212.227.17.22]:40189 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbgIPQOy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 12:14:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600272865;
        bh=U/cdYT2lkjnPSrV7Bdpjy1bGEs+Vn9t7sgzBH9oj0+A=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dN1GrvBUsaJbqV1Si08f+u8/tZoEZ85wacYdoASSulbLFFKI8k/R4NDRQUfjQ6x9h
         IVf1vPazL0kt5s5wZVLnJRtpBiSF8hUvOWeOGo4Z5P2u1tli2m6bIQvbO5w6cdZwwO
         hWjUsgzqy1Wgo5p8iKi24QvmFjPTY1xGodlwKLkw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.17.239.213] ([213.196.213.124]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOzSu-1k8i8718Hc-00PQxF; Wed, 16
 Sep 2020 14:47:55 +0200
Date:   Wed, 16 Sep 2020 14:47:56 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 0/7] push: add "--[no-]force-if-includes"
In-Reply-To: <20200913145413.18351-1-shrinidhi.kaushik@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2009161437170.56@tvgsbejvaqbjf.bet>
References: <20200912150459.8282-1-shrinidhi.kaushik@gmail.com> <20200913145413.18351-1-shrinidhi.kaushik@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:WkxIQGjxCWqzWELsHS7c/Bqftdcw8uwP3C3R1Ec0nb006++pQlo
 rpml8S+3fRTaQQlNjP+tCppvTxWc3FWgv3KQoIXk4G999IZFQeV9uJGEM9GIFdW4EionjCO
 Gd/Q1PfAaS1hux/DJeJzV1w7fzCpLVAA7kAmkCLA4U6XP3SPPDADyDvpqrXfXLQNZLSwACj
 IrhrZmFhUVyFIQwa64tfw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4qspvnuTBl0=:aZQY3axNhG9S3Dc1JwsuXM
 f+dmSrZeQTgecBzBMxCGZ3do695rk9hpyDytg0PGYfBzb9n02Gf0ubWerGgceYK+VYAo7UZD1
 d+JzP0hrrvBj3CT1gj6ToM0kbgpSBhOXkx4FMW3sKWCK2YcQ/8qrQ3aXXNSJvdArA35vIkP/d
 oyXc3ftAE1EytZAUA+uD3lIR6TIbjL++bdXrUi73GK2nvT6oz9rghX12vCzojccvTW4DBf5hl
 pIOngbu+mLkhXxWRQHkhf/qAOcOJ917T6+R2Cej4vHw4H0Fx/hPdWLtXFnLl+uK20pK3D0Ad+
 aPbZv8t1xOnFiSbawDUUI1dwp5c9SN4L3fetUm9PR/K3kbi2WpKrg+3o4MBfl63u3JqORp+v+
 L8+Eq6kPbocBHBXseo/8sCFsTgiUOd1HObWPCz1Xq26mvsYomrrSotZPpO7uApsUV3qTjw4GZ
 CYRt8/FuQA1fC6RGFE6FADXaQU7zbwxni6yQxO7nn2maZKTErpTjnqaCeHv4Fd8Gm1Z0ma8vl
 bTy0rOjmKMxo/PgCpEOjVrRNReJkFvYhMgDYTii3zPNRfVYgMLQ/y89aBSIyCUWxUCR35SP3C
 R9c1+k5wLDU4s11jKyUHCJd8H7ig+nfP6L3PLiSM3PJFd63+TsxSdqqc3CkEuESNfHcRgnYEE
 W3N0EcTHrQ+PbvXo939d2nFlFWAPCwwLXkgXK0aXQV2UOG1PU4n0RpnjTvjhOtrsYR/q+/tXy
 blG4FOyh/4vRlJVL2On0qpOrlY88foR0e3dFKfCeQpm2o8owQGinLvyS/bihpFwHA3f2p0AcJ
 tDHWMUm5OFXPI8zoi8fZTLoIqV+8uSCzQG6EuRIQoBFcj+O/tNkwKgpGfd06gtGweI/0MCAe/
 iWx00jn3ZQHhXCpMGULSMDnJEKBlc3FE6j6+hk5antz6GlYeuzmpr6+vya+qGKi5fg+cK+jrB
 +f8XR0Vo8/d46AG6zccGrws3Rh8XD6k2Mf0k4PxDA+FTdqBhybRhbMFvs2r1OZgSQwu1xQ36z
 OaCrZ2pxHgFBjT6ZEqcbyxMQ9/ixSneNFPrEqA53/mLLKlMeEodKF8t2X+R9vGkh30xWq7hxU
 okttUDFqqmS71i4oJBus9WxrETTMRoTUcDYNYoaPIxbtz4QfWGT7CwB9Goh58WFx2HJ0UQ2Ke
 W/B6aKCqpBYBJfyMpbt5/5YRCO9wwj37hPaLMv/pt3fCmVoUMBR1od1RIoWHSS7vW7Mib1AH+
 +Cz1n9rzMVP++3FbH9HhiaxWTFqcy0pxpB2Cxjw==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Srinidhi,

On Sun, 13 Sep 2020, Srinidhi Kaushik wrote:

> Add a new option: "--force-if-includes" to `git-push` where forced
> updates are allowed only if the tip of the remote-tracking ref has
> been integrated locally, by verifying if the tip of the remote-tracking
> ref -- on which a local branch has based on -- is reachable from at
> least one of the "reflog" entries of the branch about to be updated
> by force on the remote.
>
> This option can also be used with `--force-with-lease` with setups
> where the remote-tracking refs of the repository are implicitly
> updated in the background to help prevent unintended remote
> overwrites.
>
> If a local branch is based on a remote ref for a rewrite, and if that
> remote-tracking ref is updated by a push from another repository after
> it has been checked out locally, force updating that branch to remote
> with `--force-with-lease[=3D<refname>[:expect]]` without specifying the
> "<refname>" or "<expect>" values, can cause the update that happened
> in-between the checkout and forced push to be lost.

Thank you for working on this! I gave this an incomplete look-over, and
offered some suggestions that you hopefully find useful.

> Changes since v2:
>   * Removed configuration option for setting "--force-if-includes"
>     with "--force-with-lease".
>   * Broke up the patch into smaller commits.

While the commits all seem to be compiling individually, I am not really a
fan of introducing a function without a caller that shows how it is
supposed to work. I'd rather see some incremental story, and in this case,
I think if _I_ were to submit this patch series, I would probably have
only two commits: one that extends the already-existing code path to turn
that `use_tracking` flag into that `enum`, and the second patch which
wires up the option, adds the documentation and the tests.

However, please do not let my tastes dictate how you want to present the
work, although I hope that my suggestion inspires you ;-)

Ciao,
Dscho
