Return-Path: <SRS0=xHKm=7B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCE7C433E0
	for <git@archiver.kernel.org>; Tue, 19 May 2020 11:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5EAA20708
	for <git@archiver.kernel.org>; Tue, 19 May 2020 11:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Ul6UOX/T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbgESLQy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 May 2020 07:16:54 -0400
Received: from mout.gmx.net ([212.227.17.21]:34047 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727050AbgESLQx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 May 2020 07:16:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1589887002;
        bh=/MMHmQLPxoHUkQcSCPNXTuMOoTXl5cWBbuykDwu517g=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ul6UOX/T6KyTx4rvi9KFqc/h5NzDc1RqkqivhU9t7UK2EtGkAcSL02uUadWOTNLDG
         QFxlpaWRKAF7zN1/0H19A3LnzRPKtR7GdNsTNR3JY+0orr8efJwRadlG2ejWwCVejv
         QdZ9HeXCB55JI1ShI5s1LYCrE8eA29GWyBuoD3Us=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.143.10] ([213.196.212.243]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MiJZO-1j6dpM26pq-00fSXL; Tue, 19
 May 2020 13:16:42 +0200
Date:   Tue, 19 May 2020 13:16:40 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Bryan Turner <bturner@atlassian.com>
cc:     Git Users <git@vger.kernel.org>,
        git-for-windows <git-for-windows@googlegroups.com>,
        git-packagers@googlegroups.com
Subject: pseudo terminal support, was Re: [git-for-windows] Re: [ANNOUNCE]
 Git for Windows 2.27.0-rc0
In-Reply-To: <nycvar.QRO.7.76.6.2005180503440.55@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.2005191311540.56@tvgsbejvaqbjf.bet>
References: <20200515173242.6154-1-johannes.schindelin@gmx.de> <CAGyf7-HbnCip8WZ9vtc_KW1kXMBUoPZQ8GD7H=1DOAk45Wbjxw@mail.gmail.com> <nycvar.QRO.7.76.6.2005161044580.55@tvgsbejvaqbjf.bet> <CAGyf7-Fkn2uHLCqM-4qfM0YQAXoMgiMwKEaxkGkOtz=pYYKQWg@mail.gmail.com>
 <nycvar.QRO.7.76.6.2005180503440.55@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-134817808-1589887002=:56"
X-Provags-ID: V03:K1:MIvk5gnRdMNVtZVYQNEVHaQOOy1IVlP/pAZKu2TGh1+S9Hdc4WQ
 SEcsXtRL9BIYYHdZ2wRlBA8MmrxYt9ZTT2WrExSUh1c3Tf93trlMn5wZo+PFF3TP86FLfrA
 JZ97sx66oHw7QcjwnT6ptH0RCKBM3GBun9nRj+t48u6ifcIXoRRZTI1DgUh3ANihtBRlv9i
 r8bzlo2rkDns9ct8F1LQQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z6R91zpyvnM=:1KGR33veqrssS3h/F9We0v
 AwwCNsv7DXv7Ad+UozbvlR5GQQGYX55j8n9T2gkdLEFsE0m0Fr5sV16ZH6NtVc1gx+Y1XcnDG
 8TMl7AOYpcFdAQnBYI8XyI0hB8YBXc/CcdsHj8+efGloSwg7L3oWFDMi3ixmDSXVj/4uv9Wx5
 ef2Nl1fnGjf7ErqQRMjON68tP7+jh6F0UMuyZkFDEOuA9IJIyiL35pLblx/HTi6Bl5Ls5IIm9
 4GYFfEzsnSZ2CGsS0+cWKlMtwuzi2AEOsAXwy8s6fUebCjI6gBt+PpAxkc6frl7GPD+zXS/Zg
 5sjy9UsFkZUJUXPSWQxyusVSC8RSUDJHyHU36tA5qSKFgUjNmLcCh1R6TTOt9A+y+KXhHebFX
 ez7bJPqiUvigZsrwE3muJpMbYheg0DCmDCRFxMWrvYcHl6E1TDlN+hmohrpNN6tjSFzUU3wK4
 U2iEocew1poGmIMO5kEtpZ5m/79aHrTnEYh078X4CdeXjjJsq3Quhc5otb44coJB3IIDWWqJM
 W24j2loH0hUCxHTeSIKUkZADl2jpYZsI5GhRPa3bqZI7WxUKB2i1xV0OM2uSnJgfIqlqawC8u
 n7EeiG2kqHlhiFvo4S/56YHG4eum5KuLUtMsarq3PtZcobSVttKDg2FruHiOf5auMf0l6eQ6V
 J90Rb1NY0tBnNgi9gJSvfZl6qqIc/Di0hm1+rg1hIn3LhjRu6oCSDj6g/cqy2vGXI6MKdPRty
 QAZy9wVcIZDeWz9+5S1PmC8y7O4KGbxoZB3Kd3DEY2Ei34UGbHCPq/SyEJ/68BM8n7XmrTKI5
 uSAAFkLLtRl7bEXzUknyWFU+tKzssPPuHRox0eOtbuA/NjRbND8YYAJM8VuD6TBaZ26Q7KzkF
 NcaGourStu9yUF/+NenPJj9Sm8D/2iplx1d3Yleq6cgl0DTNGew5b9P7R2oxQE/8WqKNqWvg3
 590rn+7mfA7IAGpVT2nACL6LpT/ZeTqG6dT1+bxrTTPENHejlPJp6Whotv4fQVeK5UTBrA44w
 8Knm2D4cLAJ4jKgP6nVzjP8wFbwfqZrNyYFyZG7IY/pRdXWw1RAnfnnMxg++6UatOmy3oUvR4
 kA+Ncia8kWd3FMTBT6s++TuYBoLhpD2V5VQXyiM30wZ4x5AdKPVcz8lGUCj+wmJyHerjAEGCo
 Y46GfAa2Wjb//sG/gbjKUohGxnVzGB39s76EMgpctwvgj5SmIXrv6rNlCZE3jrJVjQe4LvZaN
 psFvuTvIky2AzyEWq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-134817808-1589887002=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 18 May 2020, Johannes Schindelin wrote:

> On Sat, 16 May 2020, Bryan Turner wrote:
>
> > On Sat, May 16, 2020 at 7:10 AM Johannes Schindelin <
> > Johannes.Schindelin@gmx.de> wrote:
> >
> > > Hi Bryan,
> > >
> > > On Fri, 15 May 2020, Bryan Turner wrote:
> > >
> > > > On Fri, May 15, 2020 at 10:32 AM Johannes Schindelin
> > > > <johannes.schindelin@gmx.de> wrote:
> > > > >
> > > > > Dear Git users,
> > > > >
> > > > > I hereby announce that Git for Windows 2.27.0-rc0 is available f=
rom:
> > > > >
> > > > >
> > > https://github.com/git-for-windows/git/releases/tag/v2.27.0-rc0.wind=
ows.1
> > > >
> > > > I've added the 2.27.0-rc0 release candidates for Git and Git for
> > > > Windows to Bitbucket Server's test matrix. No failures to report.
> > > >
> > > > Thanks as always for these early release candidates!
> > >
> > > Thank you so much!
> > >
> > > To be honest, this time round I would _really_ like to ask for some =
manual
> > > testing. I upgraded the MSYS2 runtime from being based on Cygwin v3.=
0.7 to
> > > v3.1.4, and the biggest new feature is support for those new-fangled
> > > pseudo terminals that Windows 10 now supports. I did find a couple o=
f
> > > rough edges in my use cases, but I am not exactly a typical Git for
> > > Windows user...
> > >
> > > Could I ask for some manual testing in particular of anything run in=
side
> > > the Git Bash?
> >
> >
> > I=E2=80=99m happy to set it up and use it as my daily driver on one of=
 my
> > workstations, but I don=E2=80=99t want to overpromise how much help I =
can really
> > offer for that sort of testing. I don=E2=80=99t do much of my full-tim=
e development
> > on Windows anymore for a variety of reasons, so even if I install it i=
n my
> > Windows machines I won=E2=80=99t get that much active use in. And when=
 I do use
> > Windows, I keep my workflow pretty simple, so aside from basic adds an=
d
> > commits with an occasional checkout or very rare rebase, I just don=E2=
=80=99t cover
> > that much functionality.

Turns out that I ran into even more issues when trying to do a visual
selection in `vim`: it would frequently "lose" the selection when I moved
via the cursor keys.

So I've come to the conclusion that the pseudo console support code is
still too buggy to unleash onto Git for Windows' users, except as an
experimental option. I will patch it to make the pseudo console feature
opt-in instead of opt-out, and then also offer to configure it in Git for
Windows' installer via an experimental option.

Has anybody else run into issues with console programs (such as `vim`,
interactive Bash, etc)? Or is there anybody with a very different
experience than mine, i.e. _not_ having run into any issues despite using
(interactively) Git Bash extensively?

Ciao,
Dscho

--8323328-134817808-1589887002=:56--
