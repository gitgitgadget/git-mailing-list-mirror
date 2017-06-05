Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7146E1F7D2
	for <e@80x24.org>; Mon,  5 Jun 2017 17:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751239AbdFERn5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 13:43:57 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34833 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751162AbdFERnz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 13:43:55 -0400
Received: by mail-pf0-f169.google.com with SMTP id l89so11909718pfi.2
        for <git@vger.kernel.org>; Mon, 05 Jun 2017 10:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9kIttgjFpa3Uh5yK9OgT5Kc0uaOnBe8pmtcMDbw3Jjg=;
        b=RQcEKOCfBPmvQccDsL3yaRbZWTpPr3bnHSIV7wR3x0CPv4+J8joWS4gAS6mHwTMqU/
         ukJIubGlBh1sZPhZ9mCV5fcLkFwI2ibK2gx6+iMYy5FX9kPByQOMucPlks/ZpLisYUEc
         iFkoBVvX2xDbvNMv47VsRcizjQEK9ldEXPzFIiUlPtjYBvBybryVgttrbr8H9oQDd9+4
         t5N7ipnFEQvlp8qkKIZTxwn+FLNGBpFAKMlTwd2FSE2wGV8dn8q2igSN6DSitWtX7103
         dwtGPfIFhNzSMJyl2E+zqEg+PrtNfoIqtcYn60KAJ4E+aiqAxJuDuLgUvNhpDEMs7zxP
         tVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9kIttgjFpa3Uh5yK9OgT5Kc0uaOnBe8pmtcMDbw3Jjg=;
        b=syhBfsO0yxw3wvNVCL3ItiIqP3goBh9zsHcT7CcDrgzyvQ7A0Q3DLMVE2uB6h75Oi1
         b8PZhVqPMdnKuMY1l6blKf/KuNCHwYsRTfbfOdkkZCblEQYjyGe8dVKJzDdAWRMxmWyH
         +2jmq2MEKgPaAkHucltTyXKDXAgXs56LVLh4SIOZtCuSwQwoh15uQD23F6XsK1OajF5K
         6xCd99dxI6gfVI1azEpJ0fhCq9IAQt5+IZ7GZZckQGTCbvHglxdO/2gtEyNA10FRmriT
         mBQ07dLglQKF7YJ41IK8nqnl/08PKEqwirtvAw28ZXTbvS/glH2fPauyJnaPfNG1NB0K
         nw7A==
X-Gm-Message-State: AODbwcByZ2gD+IlK1mLiS8rdLEPLWji+znw7SYs5WlfP72WfjojKYMjn
        MCcNwUYBzMtktQRZ
X-Received: by 10.84.217.133 with SMTP id p5mr17167128pli.218.1496684635145;
        Mon, 05 Jun 2017 10:43:55 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:b834:3af4:2e37:8db3])
        by smtp.gmail.com with ESMTPSA id n24sm59083078pfb.14.2017.06.05.10.43.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 05 Jun 2017 10:43:54 -0700 (PDT)
Date:   Mon, 5 Jun 2017 10:43:52 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ben Peart <peartben@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 04/31] setup: don't perform lazy initialization of
 repository state
Message-ID: <20170605174352.GA40426@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
 <20170531214417.38857-5-bmwill@google.com>
 <CAGZ79kafXpn+BXdMOVOPSX7eaFgcWBUULGR_PBXpMhjKjLEM-A@mail.gmail.com>
 <20170602183933.pcjfdi4jtkk4epmg@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170602183933.pcjfdi4jtkk4epmg@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/02, Jeff King wrote:
> On Thu, Jun 01, 2017 at 12:23:25PM -0700, Stefan Beller wrote:
> 
> > On Wed, May 31, 2017 at 2:43 PM, Brandon Williams <bmwill@google.com> wrote:
> > > Under some circumstances (bogus GIT_DIR value or the discovered gitdir
> > > is '.git') 'setup_git_directory()' won't initialize key repository
> > > state.  This leads to inconsistent state after running the setup code.
> > > To account for this inconsistent state, lazy initialization is done once
> > > a caller asks for the repository's gitdir or some other piece of
> > > repository state.  This is confusing and can be error prone.
> > >
> > > Instead let's tighten the expected outcome of 'setup_git_directory()'
> > > and ensure that it initializes repository state in all cases that would
> > > have been handled by lazy initialization.
> > 
> > Lazy init is usually there for a reason. (As in: it took too long to perform
> > it at all times, so it has been optimized to only perform the init when needed).
> 
> In the case of setup_git_env(), I think it was less about doing work and
> more that we didn't want to have to do explicit setup in each program.
> But over the years we've moved away from that, and in fact if you hit
> the lazy initialization these days you'll generally BUG() anyway.
> 
> _But_ I suspect there are still some cases you'd need to handle. For
> instance, it's still OK to skip calling setup_git_directory() if you've
> got $GIT_DIR in the environment (which is why we have have_git_dir()
> instead of checking startup_info->have_repository).

Yes there are a couple places that rely on the lazy initialization but
that's not due to setup not being run.  Rather it has to do with GIT_DIR
being set to a bogus directory so when setup is run gently it does
nothing.  Then at a later point in time the command tries to access
files in the gitdir (which triggers lazy init of the git environment).

So I think that explicitly doing the 'lazy init' portion (which ensures
that the env gets setup even if GIT_DIR is bogus) at the end of setup
should be sufficient, least it seems to be so though perhaps we can't
rely on our tests to tell us that.

> 
> I think it would be nice to do away with that, too, but we're not quite
> there yet (and if I am reading this patch correctly, we'd probably hit
> these BUGs in such cases).
> 
> -Peff

-- 
Brandon Williams
