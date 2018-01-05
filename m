Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C9CC1F428
	for <e@80x24.org>; Fri,  5 Jan 2018 21:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752976AbeAEVPS (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 16:15:18 -0500
Received: from mout.gmx.net ([212.227.17.20]:51976 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752902AbeAEVPR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 16:15:17 -0500
Received: from ggw-xinxiao-xx.fareast.corp.microsoft.com ([37.201.193.20]) by
 mail.gmx.com (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0LwGDy-1eyHpC1uwQ-0182Je; Fri, 05 Jan 2018 22:15:00 +0100
Date:   Fri, 5 Jan 2018 22:14:59 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@johannes-schindelin.gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Kim Gybels <kgybels@infogroep.be>,
        "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Subject: Re: [PATCH] rebase -p: fix quoting when calling `git merge`
In-Reply-To: <xmqqvaggaw11.fsf@gitster.mtv.corp.google.com>
Message-ID: <nycvar.QRO.7.76.6.1801052212000.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
References: <8cafe900ce97d885c58f4a7f02e748d2ae3b02a2.1515101305.git.johannes.schindelin@gmx.de> <xmqqvaggaw11.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:1/SZSUvF6PtUFxt74RZHfc521MWu2M4bADEY3UZx3oFTGGSdqve
 5yX5s8CIC6el1tLW5Vq/u26B8kwL6bm9T84/pTpBRocI2BeEs85Rzi72SDNyzWKGFEAOH6g
 6CdNAvjA5RgDwHONnG4p2Y4N6IufrZOoVDZmfDtpu6N2cT1odd3Ws9HDf4QFKf/h8l27JA7
 eRxf6QooUGrBoDpMZ/BsA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IUw6K1S/ZiI=:ri8McOvhdMK41nOX1s+W7G
 w60c6TtuAEAarJSGOkcqP0wH4cpX7vq4neLnf090j+N95iJZ4UUuzbK1T4sYPQQyLC+b5fCMR
 kd3x+Tp0XxSINfsig38LVEOt0N0R/SwwuUhfkL0xA29yDLr2xFXUII22C7YcC4NlKe3xsEFDA
 VGAOI/+2ixcZCr07SMT3uQaC35ljNH5Xh4ve/3CgAQmGKvBsECDLGOWkhv/GPhWXL2FJhmTMO
 PbN9C4zfZR+v0j72lURZBoh0wnQwibnDulR93gfNRbi03d7zJCdxDg4tK72NLbk2eVse/1pHZ
 Pll0Ze7xYLOjf1n/Pdn7QV0C+TmzprT/XfQ0Oi+MbNhL1yQo8bfdStkVsnJyTxkZtR32c0mf2
 Wj8u7EqyBg+PCqR39eEUOzrxslVhAra576Cu/2B0abgYSQr6hse8EvB91MaDXUQLDQlffku1q
 PbGr1PYT1GkOFbfV9zxw6pofjWFR2TmUc5kIj/SdiWrLp4hbuv6KaPb1Jz6nnjkE+Qp5hZ1dh
 EM6jRKcI5eB09gZJ9GshM8o0mO1t220QOfe3uISmTOAQn+a9vgVHilXMmImaD7oW+cDmn5VLd
 HAoyFjscw0MwtiBibAtjsnlfG0fWzR2erGdJlTLm61AkVZD+gV3TbATd+KE32Yhm9jLGgPxMR
 oRKDmz1aE4LlH2DoY5xwTQndrKc17JyOobnroQ1NwbIyl6Zab2DSdxH9zlzqCoZ/j347NqJmL
 7R1HCsldD0cT8kEEVq+FsUaRnQ7G/5516XSgmYMZMyMKsya5HxBUiU0m8xgIR7Y82cFQIHkFW
 3FXb9ZIOVC0X9/xt/9/Lu8dPA+fZ+EFuV6TW2gYX1ezSLwL+GTDD52P02xoxDhrU1pA9OMx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 5 Jan 2018, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> >  git-rebase--interactive.sh |  9 ++++++---
> >  t/t3418-rebase-continue.sh | 14 ++++++++++++++
> >  2 files changed, 20 insertions(+), 3 deletions(-)
> >
> > diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> > index e3f5a0abf3c..085aa068cbb 100644
> > --- a/git-rebase--interactive.sh
> > +++ b/git-rebase--interactive.sh
> > @@ -392,9 +392,12 @@ pick_one_preserving_merges () {
> >  			new_parents=${new_parents# $first_parent}
> >  			merge_args="--no-log --no-ff"
> >  			if ! do_with_author output eval \
> > -			'git merge ${gpg_sign_opt:+"$gpg_sign_opt"} \
> > -				$allow_rerere_autoupdate $merge_args \
> > -				$strategy_args -m "$msg_content" $new_parents'
> > +				git merge ${gpg_sign_opt:+$(git rev-parse \
> > +					--sq-quote "$gpg_sign_opt")} \
> > +				$allow_rerere_autoupdate "$merge_args" \
> > +				"$strategy_args" \
> > +				-m $(git rev-parse --sq-quote "$msg_content") \
> > +				"$new_parents"
> 
> Makes sense.  I should have been more careful when reviewing
> db2b3b820e2.

Don't be so harsh on yourself. This bug was apparently not a big deal for
four years (which can feel like a *very* long time, can't it?).

Besides, the way code review happens in this project is not really
conducive to intense testing of the code: mere patch review will never be
as effective as patch review combined with hands-on testing of code paths
that may look like they could hide some unexpected bugs.

Ciao,
Dscho
