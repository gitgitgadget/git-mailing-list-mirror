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
	by dcvr.yhbt.net (Postfix) with ESMTP id 09F831F4BD
	for <e@80x24.org>; Tue,  1 Oct 2019 18:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfJASpe (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Oct 2019 14:45:34 -0400
Received: from mout.gmx.net ([212.227.15.19]:36519 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbfJASpb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Oct 2019 14:45:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569955524;
        bh=oX1dYrOgnWfFDywz4UYst3ZkEC8I2CJJB6wPgRrr0kA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Wg+O9qIMKkcLkIPwELrzPkmvvblneDXY+QNZEDi/taIQWMl5Qphf/YLe8jCPeFU0U
         EhhuI8gAvzd8EMfFB+m7PoLyM+rzNKYFSLgu5CS3QJ+nxAgyFbaWKBlC8XPEivYT17
         exNoY+VMuZY0ea7q9ol93fbstpg2y4ni3+gZTI/c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGyxN-1iIxnT0Zhz-00E2PQ; Tue, 01
 Oct 2019 20:45:24 +0200
Date:   Tue, 1 Oct 2019 20:45:24 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Denton Liu <liu.denton@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] ci: run `hdr-check` as part of the `Static Analysis`
 job
In-Reply-To: <20191001164258.GA1356@generichostname>
Message-ID: <nycvar.QRO.7.76.6.1910012041550.46@tvgsbejvaqbjf.bet>
References: <pull.368.git.gitgitgadget@gmail.com> <4b3b58ca6ddff476acff6735129049588c0a1f13.1569928584.git.gitgitgadget@gmail.com> <20191001164258.GA1356@generichostname>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:miJFBupYMS+PPxfEvAQkKTXKwGYnPZiv3swZYIT3azP01Kh0x1C
 iiQbtf+o9aQX0Qwe9oufxT1oJxiweQV6eoZanSbWQ8c+DULaeKMtdkxl7+4KHWTyjzOV2Xu
 RW8KhDlHZIjM/l3dbwFs2Itg1HloXbgcn4sXX4stzhb3zQU1uYcYitdhCoShGccJvU/WHFf
 bwcytFlq6l1OKF3SbNfkQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GSSdZbGl174=:FK2Gs7V8PzDmW+VV09/3PJ
 CeSQMF9AvxVYYyAvmo5IGLUJbuWXHfqRuIcEi/vQlklJ9KeGUp0fFPR6Xx8YuYt9g6uZSbyUm
 YRy3ee7dpxieOB/GvCIyaCsJc2FxEqSaI1U0fb+ovq8s+aZl0imbbubNXILqViNuGfB6o83vL
 Z3Es6oepK4uowYrmqH+Us2OpYSWHgX+y3Bfpu4MmqUZfKd5J6YiZ7pJ+YKStg6MHjznqK8+yI
 bbTXKMxdn/JWqhWVkXbUTMOASQoi0NHZ5Qd6Oapfgbs2Id7/RhU61q+F11tgfZgBUbvGZWU9A
 deczax6cj5Opk+Nu3XhtNzoJ86pVkA/yJswriV7FRk8ZuWcXmIdQ3816p3lX2Xu72UJ9Xb9wX
 pDWxvL3kJnFyfDPd8puja3HC7g28HOGI9qxp6/4p+5mKpMp9TjWBodVaHIPeILph5BcdbxxYD
 PKbgRc0czcbcqAF7N3YndEsOcAFQTo5yJjWqUpOGkVCJWWsNEpwC8CEwlxoA0bBxxPVExAiBX
 rh3zwQg6bMCbgTBQaaXqjxuUJewiJzkFjbECnR37+MGrFRi8MFGH3B7p9nAHTMJs9DAdQAYkf
 fnRQrdgBIGa0Pu7YR8nLfPg9rM/xD+K5iLEO8ats6f/DufdZbmrewmS39c+s2m1N+tDnon3nj
 MVcl5xioZcNi+UzIT16tPrTfSEav2vwDUf1Iv9bcLtCP7XHngJcbtwtAfvVYsl004DgI9BhBG
 o4Uu1OB2a18bFujIRfuZj/Q8ytQ1cxGARQ/29AQnKNLIYBAXTWIq3bj8XOiN7RfgVIB/imZWX
 0/FjSbPU6Oe2LVgT9+FHSeuR+EJivycqmNQnsJgdecvxZTQabO1zYVznKATPpX0lbRWZ2p5Up
 YCfshpySNFgzs3Qit9c1kS/DxV28RPwuvZpmMmdpwoFP7yPkoYaMpQ4nBdwNLregPEod1br3/
 pkG/XIj5GBGmi7KVDYPvdHT3fagm8wVqcnQyqM1IIySBy1+ak2OpkIWp2Y+xZJeXcgoRfmZCf
 VOjRgG+CAo30NiJli/2p2dLc6nFVeX1yXSy+vCb6cqvDrp6mM04AcQvRxue1Num99ffmoAEm/
 Vtqn1zZzyuw1ji25T1fHwgx4YYUtsxD6uZC36Tjf+M99WPSGPY43YG7mUa+shNL/KBMyj5xVK
 nOVUdOwlICI3/ptjRIrSjw1oW0baIBwKL6zraTzGnWyFsl2IPl12BtqU7EInkYQvHwvAuGbJi
 u1Vcx27AImV21j2AbkytvQ/INWpKqGSE412ER/LamjFnavDrEJSZPvk8MWbM=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton,

On Tue, 1 Oct 2019, Denton Liu wrote:

> Sorry for not replying or rolling this in earlier, I was waiting for
> my series to hit master before doing this change but I guess it
> doesn't really hurt to do it any earlier.

No worries, thank you for working on this!

I wonder whether it would make sense to add a `hdr-check` to at least
one macOS and on Windows job, too, so that we get some confidence in the
non-Linux contributions. But that I _will_ leave to others ;-)

> On Tue, Oct 01, 2019 at 04:16:26AM -0700, Johannes Schindelin via GitGit=
Gadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  azure-pipelines.yml        | 2 +-
> >  ci/install-dependencies.sh | 3 ++-
> >  ci/run-static-analysis.sh  | 3 +++
> >  3 files changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/azure-pipelines.yml b/azure-pipelines.yml
> > index c329b7218b..15831f6006 100644
> > --- a/azure-pipelines.yml
> > +++ b/azure-pipelines.yml
> > @@ -354,7 +354,7 @@ jobs:
> >         test "$GITFILESHAREPWD" =3D '$(gitfileshare.pwd)' || ci/mount-=
fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare =
"$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
> >
> >         sudo apt-get update &&
> > -       sudo apt-get install -y coccinelle &&
> > +       sudo apt-get install -y coccinelle  coccinelle libcurl4-openss=
l-dev libssl-dev libexpat-dev gettext &&
>
> Seems like you accidentally included coccinelle twice.

Good point (copy-edit fail!). I force-pushed a fixed version, and will
probably send out a new version tomorrow or Friday.

Thanks,
Dscho

>
> Anyway, thanks for picking up where I left off.
>
> -Denton
>
> >
> >         export jobname=3DStaticAnalysis &&
> >
> > diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> > index 8cc72503cb..8ce9ce276e 100755
> > --- a/ci/install-dependencies.sh
> > +++ b/ci/install-dependencies.sh
> > @@ -49,7 +49,8 @@ osx-clang|osx-gcc)
> >  	;;
> >  StaticAnalysis)
> >  	sudo apt-get -q update
> > -	sudo apt-get -q -y install coccinelle
> > +	sudo apt-get -q -y install coccinelle libcurl4-openssl-dev libssl-de=
v \
> > +		libexpat-dev gettext
> >  	;;
> >  Documentation)
> >  	sudo apt-get -q update
> > diff --git a/ci/run-static-analysis.sh b/ci/run-static-analysis.sh
> > index a19aa7ebbc..65bcebda41 100755
> > --- a/ci/run-static-analysis.sh
> > +++ b/ci/run-static-analysis.sh
> > @@ -26,4 +26,7 @@ then
> >  	exit 1
> >  fi
> >
> > +make hdr-check ||
> > +exit 1
> > +
> >  save_good_tree
> > --
> > gitgitgadget
>
