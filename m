Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE267200B9
	for <e@80x24.org>; Thu,  3 May 2018 20:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751229AbeECUcn (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 16:32:43 -0400
Received: from mout.gmx.net ([212.227.17.22]:59385 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750911AbeECUcm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 16:32:42 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MSY2q-1eowFd0xQi-00RXj1; Thu, 03
 May 2018 22:32:37 +0200
Date:   Thu, 3 May 2018 22:32:38 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Duy Nguyen <pclouds@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH 02/18] Add a new builtin: branch-diff
In-Reply-To: <nycvar.QRO.7.76.6.1805032229050.77@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1805032232080.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <8bc517e35d4842f8d9d98f3b99adb9475d6db2d2.1525361419.git.johannes.schindelin@gmx.de> <CACsJy8DF8twvST0tcHfFqYWaV_0dVRCfJj-QuuCK=0h+gjJ0wQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.1805032229050.77@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:jPMwXIOvxzLrRhZKEDdpw4niWqmAV+fVqGk1v4eyg7gH9iVAKln
 m855XU59rUAYbR2hP5elgSLTuPRq3Tz0HV2mb8Cek2Awd9pdn1H2AYVcHbVm0/YVtPmXXve
 bAgu9/p9IzzNSub3+RrEXiuHjwM+CbWYAAqMHHB3q6+ZmILeq5WanhEnTCvXtTN4vrLbzFm
 8uJFN0pm6NyFMuI7HKtFw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:W3M1rGVhmm8=:gMWEpjRW58FdHU3gLtpB2x
 qGnluqanlQd8ZptMXqaj0BwGQJQ4nVeJJ9t22PREZQVDyy2yc+wah7Lw6+eaaQ1y7zBY50dx+
 9kcf5JZPtais51eHAbcRTTx5aMQ1j0fhiF4rivkAWxxe/TaWuUe4vcMS5Yx81JsBODlACkhGk
 M807U/6ksuKtE9YmEIbW8I+bCcfGJbUtKcxpmvxWVmQQ6BO8Xe83fL25oj2BeIld9XUl+mB20
 9FldkxhkxgL8RKaDUMyfa8xO0B4dVX3eGbX+MTKDof2bEFFkDNX59LFsa7x96SI/1ZxW2BiRE
 2ZFgpcOvYbYSCQA8Y1UtiSQ5itLGEcI1I6c+jM15+EQ5pYG2WXStAJcW4yt0lFLsXWhi2GhP8
 2Mumiqmf3bouiz2M0QV6tmJiWJBJJv6HMiQcDzSTg56CQobRLnRJIDMszXhw/I0ds1nF94FaJ
 jUFoCU7QOybAv/r/QL4gBVZTaEM7GIVFwRC9CCGdy8lcSj9UWNkvoouAT0DeykcOeMbsZUePK
 aPJBsXUMmsApCGidnVovEaTDp5CUP0z+MvoEI0Kx9LfVnZ4eAa3vt1BGRkU7kWVFl0qkCn9t0
 ouGS0y2DSR6uaRcFCISe69D5H7d5X1MlrlPOGwVrDW3XkbGbdlQibwUX4wZPNW4Oe15KLJBHf
 9f5hdKKd6uvM7D9vZlQHBRv6gO7x6fcUFCbZE12BN0jjD3HvJHA4OGCaDDveai7hASFKisM5j
 aCqb7gt5Gz0QPkjhAS3e7trXWKs1FcFpnQm+D/DQM44CmvbLnzCUx+Vqp6WDgoaLxhC6j66sp
 swUsToV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

On Thu, 3 May 2018, Johannes Schindelin wrote:

> On Thu, 3 May 2018, Duy Nguyen wrote:
> 
> > On Thu, May 3, 2018 at 5:30 PM, Johannes Schindelin
> > <johannes.schindelin@gmx.de> wrote:
> > > diff --git a/command-list.txt b/command-list.txt
> > > index a1fad28fd82..c89ac8f417f 100644
> > > --- a/command-list.txt
> > > +++ b/command-list.txt
> > > @@ -19,6 +19,7 @@ git-archive                             mainporcelain
> > >  git-bisect                              mainporcelain           info
> > >  git-blame                               ancillaryinterrogators
> > >  git-branch                              mainporcelain           history
> > > +git-branch-diff                         mainporcelain           info
> > 
> > Making it part of "git help" with the info keywords at this stage may
> > be premature. "git help" is about _common_ commands and we don't know
> > (yet) how popular this will be.
> 
> Makes sense. I removed the `mainporcelain` keyword locally.

On second thought, I *think* you meant to imply that I should remove that
line altogether. Will do that now.

Ciao,
Dscho
