Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C4AB1F609
	for <e@80x24.org>; Wed, 29 May 2019 11:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbfE2L5R (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 May 2019 07:57:17 -0400
Received: from mout.gmx.net ([212.227.15.19]:58995 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbfE2L5R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 May 2019 07:57:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559131029;
        bh=i4UV2eKJcBvYk8tNJHssyR3MlmAJXvSauLFeZVcuSOI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hDy2a5ldlu/W+DDKVs6xBx9UgOgod6rM6V4jBRgJeetGcS84dJ9ju8EcHYWSRaS1h
         51Dpa7q7zA1pJyNZmHW13fFeKJSl9NegQXNxhYNVDeOBEsMP30HXKk9Ps0Y1LgYsBg
         FAFi01Y6R4t9HiV6BijTg0iCpGOEcYplxlaj1NQo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N7i8O-1gaDqx2ikk-014ndO; Wed, 29
 May 2019 13:57:09 +0200
Date:   Wed, 29 May 2019 13:56:53 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Alejandro Sanchez <asanchez1987@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 4/4] am: fix --interactive HEAD tree resolution
In-Reply-To: <20190528213529.GG24650@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1905291356240.44@tvgsbejvaqbjf.bet>
References: <20190520120636.GA12634@sigill.intra.peff.net> <20190520121301.GD11212@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1905230858570.46@tvgsbejvaqbjf.bet> <20190524063955.GD25694@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1905281301070.44@tvgsbejvaqbjf.bet>
 <20190528213529.GG24650@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:hdAlRbYXHiwTpyGgI2eGsdQxoQuRxncbbAlWMjJvNHE3zyeM1AS
 8JwUiZE1XlsoXanSIZQBL53Y/ZO16duRPWzQndofVfB1lUNl1mxqdNKGPlRfSI6HUv4/3C9
 X4kOrmqFpCMOr0gdostTBd8eHVn57IigCHIb08p2scsnkWnfEq+2vYNBMeJyruBxDn6YlK+
 Qzz7gx6pXYGcerGPtwLlw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6Tcfi7IMTVI=:CCcXD2OW8uM1t4Nney6lBK
 yQrTv73v46mgKVehidxsBBrn+LngxwJhr2oqY02IW9JkJ4vCXky5LaovC4AgMrDRMRSvPGL9y
 umyCEmHOTAfVy3i9DO14U2YLBkI+rwOdH4uuyE4ekKmmX6wkWbtDVycMDdGg7uVrn0WCW8+hJ
 e45TsflVXFSurlsyBDiRiQh2qpVaKFvELMuynNA3PRWUsNn50Y6qVu+lA8zKTNP1zMkHUJfXB
 0GsdyW8AJcVdziTSX8Gt4Zo4gbYlX9dPYfPmLo8iYnPrEH/0Wye5lfIEmWz1h4mn4xDYJOunU
 5DmBmenMGz+yp0KaO3dVXxwaPy9qDydeSNTVdUccQKCRKQokhLndyucJdWqf9mvMZ7WP8X1d/
 xi6knLpe6yc/gRLRkEouipTVNW9aTmuTD/IuD6st5OZsoBiPurCqh57LWCH1FGQU0kQin0rLd
 Q+GpM4WFgEgcvXDPYZ9t6QrBLgOqomNUClEOAxj9j3sPKMZoo2lStNQDrujD8m1SfjVOHO8pC
 Lbgmx0dpKn6Ri3AzcXjofP+5f8ZmSx0aK8nIRWUpLPXRhZTQb6JtREYUsc34lsDmX5g4Og4tM
 vK6J0s9awpRBcyMUtnLORobLyqbSV+8MIuk0cNgSvLVUPsuFaTjISc24Ns0UtagEV1jWICefJ
 wpcOetf/7fcuAf4/v6lVrTWyUudBCYSMbIlQMKR9c8l9GO8eY3rIPtR9Dl5teVM1v9vaV5Fd6
 p4GUhErPZb0MUv2ZqiuHtkSA5rqetbslTQM6KqA72RUaSWWvGHfBFqY0zxrytLhK1LTqoHj/8
 E8xGYoh3qXjdXjXQxXhGxth8U1ocYsc2F5xpxt8gLXJ7SAFq2pGoxEnAdDdTRaEnOZeQO21IC
 o1tNYY4EMPRYCXEemCzP5QQ5BRMaxtds/5/+mJJJpxfbLZ+Dbb+Z2fkzCV9Jh5tQZKvDTHMxC
 +XIr8Y0zsGTqFDOco1H1Pr3+l82Ls21Ku0lxan3JqRzcdhtRxkZE6
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 28 May 2019, Jeff King wrote:

> On Tue, May 28, 2019 at 01:06:21PM +0200, Johannes Schindelin wrote:
>
> > > Or do you prefer having a one-liner? I'd rather come up with a more
> > > generic helper to cover this case, that can run any command and comp=
are
> > > it to a single argument (or stdin). E.g.,:
> > >
> > >   test_cmp_cmd no-conflict git log -1 --format=3D%s
> > >
> > > or
> > >
> > >   test_cmp_cmd - git foo <<-\EOF
> > >   multi-line
> > >   expectation
> > >   EOF
> >
> > I guess that you and me go into completely opposite directions here. I
> > want something *less* general. Because I want to optimize for the
> > unfortunate times when a test fails and most likely somebody else than=
 the
> > original author of the test case is tasked with figuring out what the =
heck
> > goes wrong.
> >
> > You seem to want to optimize for writing test cases. Which I find -- w=
ith
> > all due respect -- the wrong thing to optimize for. It is already dirt
> > easy to write new test cases. But *good* test cases (i.e. easy to debu=
g
> > ones)? Not so much.
>
> Hmm. I too want the test output to be useful to people other than the
> test author. But I find the output from test_cmp perfectly fine there.
> My first step in digging into a failure is usually to look at what
> commands the test is running, which generally makes it obvious why we
> are expecting one thing and seeing another (or at least, just as obvious
> as a hand-written message).
>
> So to me the two are equal on that front, which makes me want to go with
> the thing that is shorter to write, as it makes it more likely the test
> writer will write it. The _worst_ option IMHO is a straight-up use of
> "test" which provides no output at all in the test log of what value we
> _did_ see. That requires the person looking into the failure to re-run
> the test, which is hard if it's a remote CI, or if the failure does not
> always reproduce.

If you think your version is easier to debug, then I won't object.

Thanks,
Dscho
