Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FFAF1F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 15:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753719AbcHXP5y (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 11:57:54 -0400
Received: from mout.gmx.net ([212.227.15.18]:55393 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753457AbcHXP5w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 11:57:52 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MN1j6-1bW0yE2LaS-006h1N; Wed, 24 Aug 2016 17:57:18
 +0200
Date:   Wed, 24 Aug 2016 17:57:17 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/15] sequencer: lib'ify read_populate_todo()
In-Reply-To: <CAPig+cSR8BHFdMJz5mFkpJ3UU6w0Xmjav+tu6f3DrkG4Gi-v6A@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1608241754590.4924@virtualbox>
References: <cover.1471968378.git.johannes.schindelin@gmx.de> <0de75bbce8ade0c6e5cf87d3647faa71a89c6275.1471968378.git.johannes.schindelin@gmx.de> <CAPig+cSR8BHFdMJz5mFkpJ3UU6w0Xmjav+tu6f3DrkG4Gi-v6A@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:W8c57Q+2GorNG6J00Jawx1zdnUe5GJ5ERCG8mRwEh7lBJbwT86T
 yO6HAuy+TgKZ1yvfqJfN3M7kHVHCNaayFLD98d1IFmQqtT6qbfOVf5MQKw2tOP+MpBcqMtx
 +ZHRWRVyqAczN9TZHpNJjvR2QBI8x0coEVdrIok4Gl4kZ01WB2oj68eDzMcFOHc63+/1buu
 beffOtw2FeUaiWSC2s7aQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:meagsdeLtGY=:6arh+wROCJzVCft0cMm023
 0aPGr7Zs9qJRxUv2/IuYrEKWE0h19az+C4H/d6PlF0icsQiv8F47OiPCmc/inpIE4ZuGuNaJI
 9U3FSXPKu0SWY/fPoi4IyHwNaT5XhBN3unMqvu17cMtxKqXKvpvBwLwYoSY4jNroWIyf6nXib
 KvW7V3o25Fz6x8ZghN4uuwA4fRHTKPWCwu3fdtFWBLM0eXyHC8a5gHuFe4t6BKLkLBmV+PJOH
 QP0GMpa1/S1QfJ1v2fMFtKfUbfhF0GB0NUaHehKnfxlFJbG8Urh945yAj68EAixE8UQQ9C3hl
 BhCgaJPrrwoXsRpiV0C7LaCFc99rnhhUC2wiCBSesldSASYPtxX9bUgPrYYhEQYGPH4Ft5mq+
 MirlTB/YMRBWF5pjq1hr+J9asEjI1rGNh/5TB6w/2ydxDtLObwtcJz92cz61kY0sxtKy+3WFZ
 umZoot1dQPKv2ySx9uVwfAS48Rsvyldcmhs2zSovJ9rTfTt8uUoRYWu9Jb29ValGo4IrvmPfR
 fQL9n7QBe8xzukLsID1VsQleaX3IbVpCvFlVHhItJqXAvfql2S6mtBdyZMZpiOTtZ6f2Br6+v
 i/ePxDRP3Ao9t1usKgeWnvhG0UQpqly7p7pvAU+N23PSuqaR8zqEUkuhLIEdOF3BCPk2FcVHL
 MidVgGSi01DCQp9Par0DrowVanckm/iPGn78gIBk7bJIy/uovj/0rTzIT1FRItVXbLyloIOMl
 FWyuV3w+laonC9SSpZHdOO2HavtvTjKaqEQMX4sBrFguqiQIB6jVGwNt3BLQcydLLkszhVpPR
 EFMKOZG
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
> > @@ -754,18 +754,21 @@ static void read_populate_todo(struct commit_list **todo_list,
> >
> >         fd = open(git_path_todo_file(), O_RDONLY);
> >         if (fd < 0)
> > -               die_errno(_("Could not open %s"), git_path_todo_file());
> > +               return error(_("Could not open %s (%s)"),
> > +                       git_path_todo_file(), strerror(errno));
> 
> error_errno() perhaps?

Absolutely!

Thanks,
Dscho
