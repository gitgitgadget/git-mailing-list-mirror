Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A687E1F6DC
	for <e@80x24.org>; Fri, 27 Jan 2017 10:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932630AbdA0KwP (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 05:52:15 -0500
Received: from mout.gmx.net ([212.227.15.15]:57877 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932755AbdA0Kuy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 05:50:54 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MCLQ1-1cfYQg12Cv-0099fy; Fri, 27
 Jan 2017 11:49:59 +0100
Date:   Fri, 27 Jan 2017 11:49:57 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stefan Beller <sbeller@google.com>
cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH v2 1/1] status: be prepared for not-yet-started interactive
 rebase
In-Reply-To: <CAGZ79kYLFJYPQu5KSv3hG+_eavO9BHkxHjpVOEs63Nn6Hu1gTg@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1701271145260.3469@virtualbox>
References: <99f6de4be107044fdf01ee796f42e124ac147891.1453480067.git.johannes.schindelin@gmx.de> <cover.1485446899.git.johannes.schindelin@gmx.de> <alpine.DEB.2.20.1701261708370.3469@virtualbox>
 <CAGZ79kYLFJYPQu5KSv3hG+_eavO9BHkxHjpVOEs63Nn6Hu1gTg@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Dv9zpbpYvQ868nmjBp70o2BAn09OLtGAH3a4HgOTRKBebN2weuB
 QPKrZhT47lMyg++zAkjdIUHKZg81mMpN3AX+1JBiFXs+io0lqCICq5pJrf6cLO/gmEEYTu9
 zEFYY+9hdxiWpB/ZGIzu5kqW4lOtT6mz7UALzGZfy6/28HeK0p1g7LbnHIlCYdabv8DapBS
 FhqqIgJ5YWQFOS048ZQsw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XLJAG679ChA=:C1F5+XDrH+AK8HErshqA+J
 N83byMndsQU2ajKqmiD7WCDRymEqx6I4wSBfB+NCOhBmZm78s3SdSk6iLy3Npv3vnXQsg1mZD
 LIfOY95HtZ0rxm0CyU7P6e+c6s/8+ldtMtfxkuKSvunlAxj1Km6Xom9mzNf3rnrkyNjLd3UA8
 wOCNayKx/wprzitfm6BH8upiWAciCZfl12d9wtQS/RVhePnEKo0gxedKwo3iD/5Hak7jfi8jb
 4oKGInqsXz86ErwTtJJait1jAkMMNwHoDayw+7p+/Gw5HWHr0+N/8yNbDHI3za/vY53URzVp1
 vyDu+pldoDPE0kH8Eg2GUZUTQnIJqXLnOCPSCJ/xlEOvoVTXsfI2+jizX47k21iXhupNuHqXB
 Az6I4w4pcE825keAEiG5B3N98AOeVTjAOMHKsBD+tLuRSKSI85VvntDHx+YhhDaSpIBUXTouj
 uRaDSwJJFAOnNeiQCVt47GXXm4I7KWa2+3YaPcc+2I/P1iX1arkhewQG50XyQ3agetG9yyCj7
 hFTisDAoBu7aHtSu7ALxZSoQ/xcX+U0Lg3UIk8uq+u890mcWx5AGlKfDdjkHsNJQKHnRI2Ax7
 X28TzojowArpFqPbvzHaWASk6xqZBj6+vODimMoB8Uja1wU8s2WFHC24VX0FvFAyOhoe4KHeS
 U3HRl3kMv/GBP6+P1Z0g+dKvfW6u6afxEjvGMDuZ2yAff5HEGP7uKFIjmTJ7oAYGGpregCV6/
 FXzQTGT64khRVRLPbCRdZv5OyoyL2iNms5089A9rBKuYs680ewrlpi5z2eU5Z6Wfa0ynFgTFk
 0P15UOzG/wtEC0+u8KFcOJp+Oew4A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Thu, 26 Jan 2017, Stefan Beller wrote:

> On Thu, Jan 26, 2017 at 8:08 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > -       if (!f)
> > +       if (!f) {
> > +               if (errno == ENOENT)
> > +                       return -1;
> >                 die_errno("Could not open file %s for reading",
> >                           git_path("%s", fname));
> 
> While at it, fix the translation with die_errno(_(..),..) ?

That is not the purpose of my patch. But feel free to offer a follow-up
patch!

Ciao,
Johannes
