Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66CF71F7D2
	for <e@80x24.org>; Mon,  5 Jun 2017 18:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751336AbdFESoQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 14:44:16 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:36263 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751077AbdFESoP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 14:44:15 -0400
Received: by mail-pg0-f47.google.com with SMTP id a70so16972056pge.3
        for <git@vger.kernel.org>; Mon, 05 Jun 2017 11:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=62T8NGyBj136h28QjHPdwYrB0hIPw/bWAzeLlX/hBaY=;
        b=oSNNSGORLV3u7L8JqshcF3PPDh+twsNl9pvNoPRL7HJ9JmIS8m8amZXCEIafYOknip
         dWtsYexkDCKGoFSty0EzYl55a1bE7/wTwzJmFy5XOwKDAtHDVNnceP7WnUlNCn/bAIDE
         T8VLJSoT9ocei6OJn5jBItC9Dzqosjm4svVfv1vYxwBoiI80qOMLbRsrwBqbm8r1hYO2
         yrVPBCnUl1hOvW4bxVKyV+xXZ61Nv1sn4//GXxifDEeDVDcZJ2/tqF3AGWir2zEr8b40
         UKOD1Y3BJO830zJJZKv8624MZJaKZBypfagXtFd9c7dfI5nEJC563xhWKejgOMPOUUX2
         LR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=62T8NGyBj136h28QjHPdwYrB0hIPw/bWAzeLlX/hBaY=;
        b=l9hknmwTm+1gWqxtJQWl/8eWbeYZPDK9vK79J8zCHIgVoF914tNBer8e3nTEsMfYQD
         J2d2o5oScb/PrBwF/nyPdX4lqxdLaxcvd8/LL82vlq7UvB4oFnoxkQkdRmRp3i7/ZBwF
         ZPi5wZukKCkQ2bxQaAoyaMAqMiBOfBsHtnkwVQjd/sZJzBG8HY89OIOYrKAZye4VVPK5
         icStQs2SNzGGywupIoeEGC2KD9utD344owtZcTK/aDDS0pG4umIV4Y0ZD/H0hl9KUAuQ
         u5pa/ADhC+fxIAi65Ok7cB3nZe1kV4hEpaTO8jhJ+2tTCKi3yotYdRMKVvyDiEhHkka7
         OOUw==
X-Gm-Message-State: AODbwcBkaAl89FOJd/SM6MoS7oCxHiCT9h1UWn3wm0xzYifWndtPGq70
        xywdBZsk+Cy6e1LT
X-Received: by 10.84.131.1 with SMTP id 1mr16614316pld.232.1496688254697;
        Mon, 05 Jun 2017 11:44:14 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:b834:3af4:2e37:8db3])
        by smtp.gmail.com with ESMTPSA id c67sm59715912pfe.37.2017.06.05.11.44.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 05 Jun 2017 11:44:13 -0700 (PDT)
Date:   Mon, 5 Jun 2017 11:44:12 -0700
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
Message-ID: <20170605184412.GD40426@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
 <20170531214417.38857-5-bmwill@google.com>
 <CAGZ79kafXpn+BXdMOVOPSX7eaFgcWBUULGR_PBXpMhjKjLEM-A@mail.gmail.com>
 <20170602183933.pcjfdi4jtkk4epmg@sigill.intra.peff.net>
 <20170605174352.GA40426@google.com>
 <20170605182007.vvpk3ge73lrojxqw@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170605182007.vvpk3ge73lrojxqw@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/05, Jeff King wrote:
> On Mon, Jun 05, 2017 at 10:43:52AM -0700, Brandon Williams wrote:
> 
> > > In the case of setup_git_env(), I think it was less about doing work and
> > > more that we didn't want to have to do explicit setup in each program.
> > > But over the years we've moved away from that, and in fact if you hit
> > > the lazy initialization these days you'll generally BUG() anyway.
> > > 
> > > _But_ I suspect there are still some cases you'd need to handle. For
> > > instance, it's still OK to skip calling setup_git_directory() if you've
> > > got $GIT_DIR in the environment (which is why we have have_git_dir()
> > > instead of checking startup_info->have_repository).
> > 
> > Yes there are a couple places that rely on the lazy initialization but
> > that's not due to setup not being run.  Rather it has to do with GIT_DIR
> > being set to a bogus directory so when setup is run gently it does
> > nothing.  Then at a later point in time the command tries to access
> > files in the gitdir (which triggers lazy init of the git environment).
> > 
> > So I think that explicitly doing the 'lazy init' portion (which ensures
> > that the env gets setup even if GIT_DIR is bogus) at the end of setup
> > should be sufficient, least it seems to be so though perhaps we can't
> > rely on our tests to tell us that.
> 
> In have_git_dir() we do:
> 
>   int have_git_dir(void)
>   {
> 	  return startup_info->have_repository
> 		  || git_dir
> 		  || getenv(GIT_DIR_ENVIRONMENT);
>   }
> 
> and generally call that right before calling a function that might do
> setup_git_env(). We can assume that if have_repository is set that we
> have an actual git_dir (we can check all of the assignment spots and
> verify that they always set it in tandem with the global git_dir).
> And obviously if git_dir is set, we're good.
> 
> But if that third condition ever triggers, it's because we're relying on
> the lazy setup to copy it into git_dir. And if I understand correctly,
> that would turn into a BUG with your patch.
> 
> I guess my question is: does that third condition actually trigger in
> practice? I added those conditions in b9605bc4f (config: only read
> .git/config from configured repos, 2016-09-12). I remember there being
> some reason for needing those back then, but the commit message doesn't
> say. But if I remove them and just check have_repository (either on top
> of that commit or on top of the current master) the tests all still
> pass.

The only instance I saw the third condition trigger was when GIT_DIR was
set to a bogus gitdir so when reading the early config a bogus
gitdir/config file was attempted to be read resulting in a noop.  If
GIT_DIR is set to a valid gitdir then the other condition in
read_early_config (which does repository discovery itself) would
correctly catch and read from the repository's config.

> 
> So I'm not sure at this point what the case was that motivated it, or if
> it really was just an abundance of caution. But if there is such a case,
> I suspect it's broken by your patch series.
> 
> I'm not sure we have a good way to find out, though. Like the current
> BUG() in setup_git_env, I think we'll just have to cook the patches for
> a long time, see if anybody triggers it, and deal with it on a case by
> case basis.
> 
> I do kind of wonder if we should simplify have_git_dir(), if those other
> conditions aren't actually triggering.

If this ends up being that big of an issue I'm sure that it would be
easy to adapt this and revert to doing lazy-init.  I just saw how
clunky it is and was trying to work to start the process of cleaning it
up so that the code becomes easier to reason about.  It seemed to make
things easier for me to package them in a struct at least (and reason
about how the config system would work once stored in a repository
struct).

-- 
Brandon Williams
