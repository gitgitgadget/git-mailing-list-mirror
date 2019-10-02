Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 521B21F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 12:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfJBMG5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 08:06:57 -0400
Received: from mout.gmx.net ([212.227.17.21]:37427 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbfJBMG5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 08:06:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570018008;
        bh=qIXrjUzp1mdzfC0tJiChprwbtz9KKmbZ7d9cJgvPCII=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=iHflnzU9hgIsVTMQjy6fcY/f6QaDbU3epDx7R0rPU1NHyd6TEKTqMRGBatJyx2IGb
         vZJtATMc+h+p3oP0pPNPzsU9AFyTy9N4V3snI70E05F2j8GGZLV+H/4fyP5M3QOlvC
         OvlMQ+a6KCrJPtBAQngWC3GX1iuhqKIaFnuiC94k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8XU1-1i2eva38Wf-014RW1; Wed, 02
 Oct 2019 14:06:48 +0200
Date:   Wed, 2 Oct 2019 14:06:18 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 4/5] rebase: fill `squash_onto' in get_replay_opts()
In-Reply-To: <94dbb49e-2c11-ce30-5d50-05be19ebb3bb@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1910021405391.46@tvgsbejvaqbjf.bet>
References: <20190925201315.19722-1-alban.gruin@gmail.com> <20190925201315.19722-5-alban.gruin@gmail.com> <66fcd66b-fad2-e5a1-cdd8-fd7b37c4abbf@gmail.com> <nycvar.QRO.7.76.6.1910021011010.46@tvgsbejvaqbjf.bet>
 <94dbb49e-2c11-ce30-5d50-05be19ebb3bb@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:kIbbwIF1v8qLVRoknZLv92CQ9nh4MtxTTR+VFjnOohw/WbfE7+a
 dZVo8nwq/XY5hQ6IVMsVmeB+yFeIocN1Yo7ZduUT8xDFKWHrDYvEx+1ZJohSoFyRWgj0U/N
 Re8Jf+cxV0UNrD1pQosiQh3BleBaehOjuiOsLrIkvrlVdDRTbMhVxYFfutf8C6Sjxx0KGXK
 g7xUtus7vQhtPZvjb9TpQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pq9gI3Gcz5E=:WjBOaSmKwUxmygZQKRBzgn
 49k8VPKWii4pdEBxPAlkD8SQP2Xmb/PGDyNYxz8pieiH7CNKc5TJVl/dtV0NZdIaP7NN1znb5
 R9e7vMoZ3PvcIZEUSsRnPtEahEI7goVUMWEuw+ZZM4qOnvYkk/NVV0KyFOT2dTMC5KoRHPVYD
 V+WIrKLmDsHPfZtDWGDy21K6tgm0QufPgeWipxow/5GDrRhKqzlGiP5dBQcDHeQVJbNufVYnl
 DgRfrMDB6PrCNxsQJXO9avQS0OHDi4KBULJ7R7Fe0j8NO3LSg00xHma4+VmgI0ZbOoEYCxfgr
 79JpoyjEH3P84qqo6qX2kCd3xDN8B2IGB7G/BSuOBVlm9ZVki1ixbwE12SKARbDNh3VDVIR9g
 oZoq4WMOu8YRqMAOmI86cIg5L3QT+qNR9rOboP/OMO7M6GGHlacEWt12k/pnFzUDW4LQNavrI
 uR3mXVF3E1NUbuAwIyEmQtkXyZTEe4uNan865Wx+kGPGLZFTqlc6GnmSGQ/1XIIZsqFvBR0Za
 doa/6K9pFf688YNbGxDOOdrSS2roG7GZUQdQu/H40iZu+ElSyLLWa91ay2bI5rjZu8X0hXFM6
 eDOiBCsYYs478vgkY1iZA7OBMXhgyVRp0x3GOkO3+QGwfa4CxUjBztErSShf0iu75BHJx7WtV
 N5LeBpNPmBsdZIZDbj9xFls0zAzIFeQekfoVNLPDYvhoofbk1+8RA4JyFsIuaS/zci41lSuqn
 McLgdbWjQVqGT55I6AdBTxSUH4U6LgZOFtQhH2lbIQ4ytK8MO+inMJ8p7Y/KsVu+oFhgSDHax
 yigiAuHog9YuNzHjaG6K0SRkDD1cs4Ca+kMkHk0pRSa9+bC3T5vaVERaJ007QtIOAAwqtlev/
 WvS8ikPBw4AFeshuQy+NQTOr/I3Trb1uhHxpDHLEEYkVAx+JA2/lbZUZ5f+yh1OLOi36J5Y8F
 N1CzfvegbZb/cvHtUTt5KzhWZNs/ETeUqLU/8VFyIr1ZmDfFIT1F65bBSgJTctVn8ikcogKLP
 d25JRNsFXqBOYJJrzARAlsPzFIcXPiNqYk19KzFJuN3FwxNoFzT/Pb+gglWFhNZEEL3Ly9YMM
 eSFOMsns3pL4brjzsZnOv6Xyt2s584LqN56EcvgQRd9Me4iIJPWJF0c2FgQUO2joeeqswBa3X
 GB16QqSz7DfdqJkk0HL0J1lKDaOERQ37tUcSocPqfGOaraw3WtT6QMUbqsmoGGAcDdmJ1UtTo
 E0WCbhmzQ6qJImJ2vum/cFhoppupOYQkMIlgQG11IfG9TmVksFTKC41tjQJE=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Wed, 2 Oct 2019, Phillip Wood wrote:

> On 02/10/2019 09:16, Johannes Schindelin wrote:
> >
> > On Fri, 27 Sep 2019, Phillip Wood wrote:
> >
> > > Hi Alban
> > >
> > > On 25/09/2019 21:13, Alban Gruin wrote:
> > > > [...]
> > > >    builtin/rebase.c | 5 +++++
> > > >    1 file changed, 5 insertions(+)
> > > >
> > > > diff --git a/builtin/rebase.c b/builtin/rebase.c
> > > > index e8319d5946..2097d41edc 100644
> > > > --- a/builtin/rebase.c
> > > > +++ b/builtin/rebase.c
> > > > @@ -117,6 +117,11 @@ static struct replay_opts get_replay_opts(con=
st
> > > > struct
> > > > rebase_options *opts)
> > > >     if (opts->strategy_opts)
> > > >      parse_strategy_opts(&replay, opts->strategy_opts);
> > > >    +	if (opts->squash_onto) {
> >
> > I guess it does not matter much, but shouldn't this be guarded against
> > the case where `replay.squash_onto` was already initialized? Like, `if
> > (opts->squash_onto && !replay.have_squash_onto)`?
>
> replay is uninitialized as this function takes a `struct rebase_opitons`=
 and
> returns a new `struct replay_options` based on that.

Ooops, you're right. The `.` in `replay.have_squash_onto` should have
been a strong hint, eh?

Thanks,
Dscho

>
> Best Wishes
>
> Phillip
>
> >
> > Other than that, this patch makes sense to me.
> >
> > Ciao,
> > Dscho
> >
> > > > +		oidcpy(&replay.squash_onto, opts->squash_onto);
> > > > +		replay.have_squash_onto =3D 1;
> > > > +	}
> > > > +
> > > >    	return replay;
> > > >    }
> > > >
> > > >
> > >
> > >
>
