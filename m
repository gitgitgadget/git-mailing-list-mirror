Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3524E1F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 15:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754602AbcHXP7A (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 11:59:00 -0400
Received: from mout.gmx.net ([212.227.17.22]:49171 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752308AbcHXP67 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 11:58:59 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0M51eM-1bDete0jsM-00zG4U; Wed, 24 Aug 2016 17:58:52
 +0200
Date:   Wed, 24 Aug 2016 17:58:51 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/15] sequencer: lib'ify create_seq_dir()
In-Reply-To: <CAPig+cT7fNsyhk1J0Z6evk8xRxa=g8ygUniBB+EHSRMRFcNLcQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1608241758400.4924@virtualbox>
References: <cover.1471968378.git.johannes.schindelin@gmx.de> <80062be27256704617280fdb479176e0d2afb4d4.1471968378.git.johannes.schindelin@gmx.de> <CAPig+cT7fNsyhk1J0Z6evk8xRxa=g8ygUniBB+EHSRMRFcNLcQ@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:wqBL9lM8wMeLfr8NLDrNH8Cdyj8YaDnVhNe79Al8X5vwildLtO3
 BRe51OAmafA57iLbr2Tj+MsxXYKuOLUGLvyfPbez9NVLuet8wmeYrqBFYetbOFQ+TyCgw0U
 2j4zW+612ZnjHV1/qYT2LrDi7xmFRhAh1gPT3DmHEAI3Dp5jIoCCAGkRdQVw749pjEaEAyO
 dS6sdkIxNhPdFTBAXG4EA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nJ+o1xWJYpU=:x7Cxk4Jqcb2vbwE+nT/NmZ
 vUxmIU4alSUGZD79bq8b/xmyjWdoZiQRQv5oLaK7XbG43mgOFJggRKR3bh98HwcHrU2jI/jPo
 zGJE0Qie02GoSrCrd8BlPLHLdiQf7UNSfDx4to2Ny+V/pPmfxGvQgq5g/a37p3jLRnZVUiCeo
 boWM+OtV8hbk9hrz3eIiWbySGr4bt7qXk3/DgQj0FyGp3xj+R5VS8yrCFX8pokN51Yvrh9bP5
 my07DxnBEdO3wKOYmouBYl/i39Zxb6iRlJ4e+NGtS/6joY3Sh4B+7YV7nK48jUv9aEjNF3VtI
 NpTH6ZPbAkA0eykR929y+/yeMtsgxxePG9WAJGVOIyPjwAzXQGhoAYapJtKRWwk9PW8WvDI4r
 SkbzDQVz+ZZII3SZ1OLbh+CgE/gBkIuW0G82oze8i4hjn/CNumLuwNjzDv02Sxs4aoL0ohsS4
 4EEMXEV/K4Rirv75gVefyMIgUpsxv8lM01ynT462r4zDqfDi5K7xDEebIG28CyrN5JcSXBfZm
 WRca1eZxJnY/EmRjD8m9d2/v2o+D6rizw8VwzAkbXXQFFohs5PLw1RzlB2F3rsN1GMh24NTO2
 oWq7CkgoDII+1494L6JlCd+Iafex+VI6v3Zv76Z4NBSBStrPBOaH0qb2tGczEPyz6vwKRnLG/
 ZErJB4KuogCUk8kGmti5NhvGDT0KQF6Ow4KxGJtNhSXYo02AqhE+0K8ArTmzAz1qGSmhlcS1e
 royNPAwXNuKtPO6f7MWZVRoGU8XeeHaYtRPZRoYlLdQ+tadw7u7qqYLycBg2pozWvIXebAos8
 PB9Jg22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Wed, 24 Aug 2016, Eric Sunshine wrote:

> On Tue, Aug 23, 2016 at 12:07 PM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > To be truly useful, the sequencer should never die() but always return
> > an error.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > diff --git a/sequencer.c b/sequencer.c
> > @@ -839,8 +839,8 @@ static int create_seq_dir(void)
> >                 return -1;
> >         }
> >         else if (mkdir(git_path_seq_dir(), 0777) < 0)
> > -               die_errno(_("Could not create sequencer directory %s"),
> > -                         git_path_seq_dir());
> > +               return error(_("Could not create sequencer directory %s (%s)"),
> > +                         git_path_seq_dir(), strerror(errno));
> 
> error_errno()?

Yep!

Thanks,
Dscho
