Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 336CF20248
	for <e@80x24.org>; Sat, 30 Mar 2019 02:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730236AbfC3Cty (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 22:49:54 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44916 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729885AbfC3Cty (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 22:49:54 -0400
Received: by mail-io1-f68.google.com with SMTP id u12so3328296iop.11
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 19:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mIGJZNEwO/gmurXRw0p/fPenHlGmx8z12bmYweMBSP0=;
        b=MERT2qqAykpxylomDdrQ5xsO8jJmFjwyx8CK8Liky0GA0oSxvBTuOd/YGArPOl+3MR
         wqk+6Jf6CzYgs8h8ar+ZE84Gb+2pPS0Kzl0xfKHOMnV30kn1Ba9gWAqMFru2dX3l4Cc5
         9detkJhk3XW/IaFlkynSMr9GTFKkzOGuRH1s089r2vwsUpLSgZvlGL0VPe3BBQbn2OT+
         TC59Ab18+ImAmRLv/aodNsQi6+TXaLYYGqh6t+RszeFU/2d/7IW3U8lHaJLgd9ELkHQc
         CCErBCwxnCX+7//Rf+TqeiOi89QUhl34gvbztahI4NM/i/Jo3skInWYil1B9Q3XkSSdV
         vqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mIGJZNEwO/gmurXRw0p/fPenHlGmx8z12bmYweMBSP0=;
        b=QHRwsulPJyTiyU+IRktQGqQkcZQxmVqjKTlEvBN59nASeqQi8IDRdZzwz6ZhqORPCi
         ZYtxSL2LCVXtCQXpFOHxE8ewEp3f5HPofdhFDuaiWH/tdzmaRcR0gwCplefybEW92ahH
         2EoiC7p9QzF+fJP7neaY8WT9UcyfrfD2GTSq3jrCbxJs6pm+PmmDWGKT68jNuyqvFAKz
         84s2SGslp5Xmqwu7uI7nLsALyoE1sc8GDXypMuv3M4yX63W4pGlmyxoBcz6Dgq6PLqTS
         z3jwafsLf3NqNv36lKVE5W7ynRxGkSCpc++9d9H583wO6TSe/5q9Kjqk7oID+Gvt0Ch/
         9Xew==
X-Gm-Message-State: APjAAAWwWuouVeRv0ybn+CP8T0L/jkv1C0a5DJHlqrvrFo5g/zCBkb5W
        CLE4o3KhtZVkGaxRqutnV7hwQL+S5ozTnKNFB2xU5g==
X-Google-Smtp-Source: APXvYqy1j3FJGlg25+jvTvXaPr2r2EzahZkwzKiT6gUkz+r9yQhrbaCQw0bXhqEVFCDMblUohxwrRwTZDRK98I8wcq8=
X-Received: by 2002:a6b:e305:: with SMTP id u5mr36327713ioc.262.1553914193552;
 Fri, 29 Mar 2019 19:49:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190226122829.19178-1-avarab@gmail.com> <20190322232237.13293-1-matheus.bernardino@usp.br>
 <20190322232237.13293-2-matheus.bernardino@usp.br> <20190328214950.GJ32487@hank.intra.tgummerer.com>
 <CAHd-oW70VNgYmX9=5x0CwoSD2a0ik2AoJyd7T3xiO4O030c5yQ@mail.gmail.com> <20190329193158.GN32487@hank.intra.tgummerer.com>
In-Reply-To: <20190329193158.GN32487@hank.intra.tgummerer.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Fri, 29 Mar 2019 23:49:42 -0300
Message-ID: <CAHd-oW6HmovFFKEPRCvyD8hfiToV8TNc=YFUKdDhPtzxUeoMdw@mail.gmail.com>
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
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 29, 2019 at 4:32 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
>
> On 03/29, Matheus Tavares Bernardino wrote:
> > On Thu, Mar 28, 2019 at 6:49 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > > When sending someone elses patch in a slightly modified version, it
> > > may also be useful to add which parts you changed, as it was done in
> > > e8dfcace31 ("poll: use GetTickCount64() to avoid wrap-around issues",
> > > 2018-10-31) for example.
> >
> > Thanks, I didn't know about that! I searched the log and didn't see
> > many of this on patches with 'Helped-by' tags, is there a particular
> > case to use it or not?
>
> Helped-by tags are usually used when you want to give someone credit
> for help you got on a patch that you originally authored.  It's up to
> you at which point of involvement you actually want to add the tag, I
> tend to add them whenever someones input significantly
> changes/improves the patch.  I think adding it here might be okay,
> it's just less common when sending a patch that someone else authored
> originally.
>

Ok, got it, thanks!

> > > Iirc, the test that is added in this patch does not work on some
> > > platforms, notably MacOS.  That would mean that we would break
> > > bisectability at this patch on some platforms if we were to introduce
> > > it here.  Therefore I think it would be better to squash this patch
> > > into the next one which fixes these inconsistencies.
> > > Note that I can't test this at the moment, so this concern is only
> > > based on previous discussions that I remember.  If that's already
> > > addressed somehow, all the better!
> >
> > Yes, it is already addressed :) The section of these tests that used
> > to break on some platforms is now moved to the next patch which also
> > fixes the platform inconsistencies. Now both patches (this and the
> > next) work on macOS, NetBSD and GNU/Linux.
>
> Great!
>
> >                                             Also every test and job is
> > passing at travis-ci, except by the job named "Documentation"[1]. But,
> > it's weird since these patches don't even touch Documentation/... And
> > master is failing the same job at my fork as well [2]... Any thoughts
> > on that?
>
> Yeah, this error seems to have nothing to do with your patch series.
> Since the last run of travis on master [*1*] at least the asciidoc
> package doesn't seem to have changed, so from a first look I don't
> quite understand what's going on there.  In any case, I don't think
> you need to worry about that for now, as it hasn't been triggered by
> your changes (I won't discourage you from looking at why it is failing
> and to try and fix that, but I think your time is probably better
> spent looking at this patch series and the proposal for GSoC for
> now).
>

Ok, thanks again.

> *1*: https://travis-ci.org/git/git/builds/508784487
>
> > [1] https://travis-ci.org/MatheusBernardino/git/builds/512713775
> > [2] https://travis-ci.org/MatheusBernardino/git/builds/513028692
