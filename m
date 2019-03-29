Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E085B20248
	for <e@80x24.org>; Fri, 29 Mar 2019 14:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbfC2OGd (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 10:06:33 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:37534 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728713AbfC2OGd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 10:06:33 -0400
Received: by mail-it1-f193.google.com with SMTP id u65so4034322itc.2
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 07:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cD0+dp0m1MQ2Fz4scPjc5P0cEKZX5aCrmGsxFnXoZBs=;
        b=XD0DWvJRnMZy4hHuCz+z2B772EfxQmvgmH3eALH3xLBgSEvz6JN0W/bU0lHJdsnMgX
         LX92nVR6JYcZ1YxxflRBkbxFgR2agiZGOVyagp2B/81gxF2BXAkZtpS49Qk4ofDieLh7
         4N9O3b/Afe64/g8GmWCD0I+Pbtu2RG9d0eOASmWx/1ityINKtJMOoIDVh6PpkS7/2Fis
         l3JImElMDLkgyjuIuc4rx59mmvUpu8xJoB+jg7rtR3E5dQFnyNOiGTHEP1vq76st+TZ6
         V3nMOPLWe28P6/v8Xgp/yLWABeQQdgfNUXHfDRr5L4NlU0oyV5O8m8u19y/nfE8WnX1P
         uknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cD0+dp0m1MQ2Fz4scPjc5P0cEKZX5aCrmGsxFnXoZBs=;
        b=Ov+xXZ71nOUQC8c5co12PPzQP6fadApYvOOPvcINYe6eggwN2oSOu/xsvLDDSDrGte
         MXxfGT/rSMPatDQKp8LPHGt4QSvqCs2TaDgoMWGD163ueQxu7kVV93nljf9Xa3SDm59k
         WlmnoEQ++qRPsF0gBqt0UWpkCvOSZeLcIjFeI77XETUjobbseCeufmTNbFfzInDGMSkG
         cj/cWMBZDEdKmFcMI7Z+V04onb7IddJRAL5yJh+ALdjRlvxJHA8UC7w0tGQeHI8H8Z3N
         PgxQXxIsCNCToS3ASp+WoaGl0sVntQUftKmsIMhwQh899h1uemt5v2HGbdVjVySKVAU/
         Ts7A==
X-Gm-Message-State: APjAAAWFCTyEsmRdsIepRxYwvo2c8poGvA6RVMCcqqsXIRa1Tr2Yoxoc
        C6tK0dHK1oiGQg13ibPZ6hHjxASYD9rtSyz/DLYLkQ==
X-Google-Smtp-Source: APXvYqxEq5n8OV371FExUdHzFD1nhWTknRbY1uPldWP8EMf+GeOF0Cge/hf2BZO4IcXk6f4YpsyNAWviapp3wmXXQgY=
X-Received: by 2002:a24:4755:: with SMTP id t82mr4370504itb.72.1553868392224;
 Fri, 29 Mar 2019 07:06:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190226122829.19178-1-avarab@gmail.com> <20190322232237.13293-1-matheus.bernardino@usp.br>
 <20190322232237.13293-2-matheus.bernardino@usp.br> <20190328214950.GJ32487@hank.intra.tgummerer.com>
In-Reply-To: <20190328214950.GJ32487@hank.intra.tgummerer.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Fri, 29 Mar 2019 11:06:20 -0300
Message-ID: <CAHd-oW70VNgYmX9=5x0CwoSD2a0ik2AoJyd7T3xiO4O030c5yQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH v4 1/7] clone: test for our behavior on odd
 objects/* content
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Kernel USP <kernel-usp@googlegroups.com>,
        Alex Riesen <raa.lkml@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 28, 2019 at 6:49 PM Thomas Gummerer <t.gummerer@gmail.com> wrot=
e:
>
> On 03/22, Matheus Tavares wrote:
> > From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> >
> > Add tests for what happens when we perform a local clone on a repo
> > containing odd files at .git/object directory, such as symlinks to othe=
r
> > dirs, or unknown files.
> >
> > I'm bending over backwards here to avoid a SHA1 dependency. See [1]
> > for an earlier and simpler version that hardcoded a SHA-1s.
> >
> > This behavior has been the same for a *long* time, but hasn't been
> > tested for.
> >
> > There's a good post-hoc argument to be made for copying over unknown
> > things, e.g. I'd like a git version that doesn't know about the
> > commit-graph to copy it under "clone --local" so a newer git version
> > can make use of it.
> >
> > In follow-up commits we'll look at changing some of this behavior, but
> > for now let's just assert it as-is so we'll notice what we'll change
> > later.
> >
> > 1. https://public-inbox.org/git/20190226002625.13022-5-avarab@gmail.com=
/
> >
> > Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> > Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> > Helped-by: Matheus Tavares <matheus.bernardino@usp.br>
>
> The trailers should be in the order things have happened usually.  So
> having =C3=86var's S-o-b first makes sense, but the Helped-by should come
> before your S-o-b, as you made the changes first before sending out
> the patch series.

Ok, thanks for letting me know. I'll fix it.

> When sending someone elses patch in a slightly modified version, it
> may also be useful to add which parts you changed, as it was done in
> e8dfcace31 ("poll: use GetTickCount64() to avoid wrap-around issues",
> 2018-10-31) for example.

Thanks, I didn't know about that! I searched the log and didn't see
many of this on patches with 'Helped-by' tags, is there a particular
case to use it or not?

> Iirc, the test that is added in this patch does not work on some
> platforms, notably MacOS.  That would mean that we would break
> bisectability at this patch on some platforms if we were to introduce
> it here.  Therefore I think it would be better to squash this patch
> into the next one which fixes these inconsistencies.
> Note that I can't test this at the moment, so this concern is only
> based on previous discussions that I remember.  If that's already
> addressed somehow, all the better!

Yes, it is already addressed :) The section of these tests that used
to break on some platforms is now moved to the next patch which also
fixes the platform inconsistencies. Now both patches (this and the
next) work on macOS, NetBSD and GNU/Linux. Also every test and job is
passing at travis-ci, except by the job named "Documentation"[1]. But,
it's weird since these patches don't even touch Documentation/... And
master is failing the same job at my fork as well [2]... Any thoughts
on that?

[1] https://travis-ci.org/MatheusBernardino/git/builds/512713775
[2] https://travis-ci.org/MatheusBernardino/git/builds/513028692
