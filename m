Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9CCC432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56E88610CC
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345243AbhIBOAe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 10:00:34 -0400
Received: from mout.gmx.net ([212.227.15.19]:53141 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234331AbhIBOAd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 10:00:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630591171;
        bh=prGdd5q8IR7MCC6urZwYE/RIcb0q3de9W47LclDoBsA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=RRPKjm0fULjjZFEem0cN0nhaqKrxEeQoJ1BPu+PCCfAUmwraC2CdtSYuGpwMBiM3N
         VvrOnPga0c2b5A1Gs/RUhoKWdXcsLqZYkNNKOuYLj8Sy4FwDgSjj8xe1DFP8zqJ2pN
         4aeanCqcDaa3ws9eWpcTLHTZn1Gq+89zCt6Cqf28=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([213.196.213.44]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MBDnI-1mGsNZ0ykQ-00CmMP; Thu, 02
 Sep 2021 15:59:31 +0200
Date:   Thu, 2 Sep 2021 15:59:39 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Wong <e@80x24.org>
Subject: Re: [PATCH v2 5/7] rebase: drop support for `--preserve-merges`
In-Reply-To: <87tuj4v2q5.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2109021555050.55@tvgsbejvaqbjf.bet>
References: <pull.195.git.1574542242.gitgitgadget@gmail.com> <pull.195.v2.git.1630497435.gitgitgadget@gmail.com> <eb738b1bf05dceb1d119e3adcd732d968407c757.1630497435.git.gitgitgadget@gmail.com> <87tuj4v2q5.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1123083655-1630591181=:55"
X-Provags-ID: V03:K1:+2LmqiSBy735HaWxuP9Zd2SpvvNG46wl/wmM07diOFX/9XOd8/x
 a8XVUVE87LICQd4+NPwCLwj0GyhKBerSursOkoo+NvSYqkewos1cc+OuPctJvHjx0R30ybw
 06hDRmNB1QOJnrAIwMp0eUpTmHxi9STJLw3AqijQ+wjQY7p6iMlKXsUhFCzTuVQFOgZEksp
 TwDcFlkHZse/t+igZEKNw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:v5l44nH6Mus=:JH0H2RJPcaCDbQZEfeIrfB
 ryIfUIw9P0Z6KNT2VoLyMV5fsrOF2xwVpComywgcAAsYLe/mfGjK3rTZ9ADs/MKFWOp61EO7H
 Cp09P/WSVJ1qp+n8Y/DUE9wgoqL5bBjAzAys3u+HuH7fv9ClHA7yp2+xHakQH1VV2AW6u/Q3h
 m8QyogIKOKzz7GMjNlqpc3UzIgdCWckPSSmFEsox/PAcHXTkwdAMi3ZKxf+b6sRFdD3rjpb5V
 wnTznVNIKblgYGDFPsPIQ+LWwAmaB+sBUbFGzWWz9ziHKRPbV2Ln1uLloit9NVVgt7Y1ThTuA
 ZnW6cGDWuaRG+A7ftCgJK4GqfJOJjEon8zHZw+QV7hRzZaODWubjjEhd3yJoxcEhzZPRnEiGD
 BAewBxkLgJ0QjoARl3epyYOjovCCnap5rbb1Zlji3VvS65zQVaCrimk455JjIS//1bwsuAPPR
 KUyFzObsKZiOvexHixrHdjrXurCBbPnFeMsVwsFDROfSbDTFgG5pf1BGdXugnl/wWM7TpkspY
 BotBoFQk+z+9mybX1Ad1Pb9kq25lg5aURKmbL9sNhcclXhMjUp2726LRtHIULe+3rkFw2QlnC
 u5WJM8e94SWvd0QkydbK7HKpC1P8L5R2BQhqPIACpFQ3OXkTV+LORbCnUhwci/GUoOjSx1H6z
 rfGrS+Y1+PT158yjRfk+L3f/Ib9edEm1Tq0EjIR2mfaCLQEKgi/Aev76aENFMV4E1nYuvOhmx
 l3LsC34diZR2/FySrL5OBHxn6Zngj100pXqcKWjAadt2Aklila3o/6utxcH7wuCkBEemMODta
 q1FNB6Et0Fwr2Fe31zyMpmCwo67TLxxAwDpwBeHJIvPP+sjVUFq7+QCH95sMqub0zkcuTrDqJ
 zhfHMtyBHCwuN6Wpg4uFRPVV1URF7Tyy8WlQbhJTfMR/duQiZzSDM6cFJcMLGSr786OtNfATW
 EihS9favYUFr5zAFsLZaA53W8bIzmzsAO37XZWDqn10+9+m5cEal1ddE89c4htJ5vJEdcYHA9
 KjPNk5XoyjLboS3ZNCpoqgc/PnDYM3l/Sf8+BA/Uteh90yWlGcQ5L7cfPgWpXWsG1kC4NOoEG
 gEC7ZDigsZKfqXhWmDRcficp5vc0tWpnOD5wa3I0eOBSF8ZtWsCl4s44g==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1123083655-1630591181=:55
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Wed, 1 Sep 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>
> On Wed, Sep 01 2021, Johannes Schindelin via GitGitGadget wrote:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > This option was deprecated in favor of `--rebase-merges` some time ago=
,
> > and now we retire it.
>
> >  static int is_merge(struct rebase_options *opts)
> >  {
> > -	return opts->type =3D=3D REBASE_MERGE ||
> > -		opts->type =3D=3D REBASE_PRESERVE_MERGES;
> > +	return opts->type =3D=3D REBASE_MERGE;
> >  }
>
> This leaves us with a rather pointless is_merge() function and
> nonsensical control flow in parse_opt_merge().

Thank you for offering your perspective.

=46rom a readability point of view, I disagree with your assessment. Just
because it can be written shorter does not mean that it is clearer. Quite
the contrary, if you ask me. And since _I_ am contributing this patch
series, I will respectfully disagree and keep the version I find more
intuitive.

You could potentially talk me into adding a patch that renames that
function to `is_merge_backend()`, but that's as far as I would go. And I
am not really certain that that would improve things, either.

Ciao,
Dscho

--8323328-1123083655-1630591181=:55--
