Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C2BB20133
	for <e@80x24.org>; Fri,  3 Mar 2017 15:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752280AbdCCPif (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 10:38:35 -0500
Received: from mout.gmx.net ([212.227.17.21]:54094 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751722AbdCCPic (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 10:38:32 -0500
Received: from virtualbox ([37.201.194.68]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0McPvw-1d1UYW0gq0-00HcCs; Fri, 03
 Mar 2017 16:31:40 +0100
Date:   Fri, 3 Mar 2017 16:31:37 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 0/9] Fix the early config
In-Reply-To: <20170303051451.elzz2kzumft2iugg@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1703031612210.3767@virtualbox>
References: <cover.1481211338.git.johannes.schindelin@gmx.de> <cover.1488506615.git.johannes.schindelin@gmx.de> <20170303051451.elzz2kzumft2iugg@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ITIIC/FEKTQnqGE1C9LP9Wh27DQUkvoV35bNPmydxAHR4IBlUEy
 4eAoCmraVW7MKmX4L6wHIHYdqQm5329amPNHhjqHfUIr+mZ9+dDL6BO0Ols38O6lVF0KZbk
 as4PW+ynOOvfmQf++KaGLfGacVhP81wweUil4m1lqlf4R7NTICG4GicO4TO0zJtSowExRVh
 i++QI0v53hDYaS7TeILBg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HyR9uokJing=:Hxtwi+e8Dr1rl27B6C2/Eo
 iXwVqlefqQi1KXegWXTvTvCcHHwiFHeMdF/Jcqen6LH5eCm/vf3bSF0upfPUbUkZvoKZ3FoQu
 hEXnvGUs+iMUH03ooHiv7leMLqC+dsSI7f/x0Kwo10uS5fsT0SIrJ8C1MemqPj8QpoDBjJBqi
 TS+80Qzo6AdjZOgEmcOG24SpU1fXEFgIDom52b6HiFWv2aZeL0IQfhvN7eATKI2cfKIXjRK5y
 HlMs7nAEoGL6KQMbJ82FYFIsmsBfrlHgUT5FxdWb3GKNpQHxjcfuMKvBZLkmBCNsIdN3JA85c
 /t7G/aew762tb2AqNcoWq+60mTGDxVZwL631pP0J/9sVgqL1q/eW5aNou99fhY9dKwBogm2pC
 uaVvK/fSIcb05Ms+CppeLMbvfV0E8IyhVxxqKblp4vF5F+0srOgp/4RHgmoLm2GJA0HlX0uv6
 pmszq3gJIGRbfMahk04Yh/M6iUne25AYXRkFFksnsB1Z7xcJLuV03sQcJ6cJOI008/eBcJuGs
 FTeKAChqYugdgZQpAC4f67iAD34yxcguSiV20FzvoyVrD9k1iEdnWTLT+qDxLUtJjMssBPE49
 IBQcPXqtCEzS8jcXNcqVYdnkq4zarvlJTL6V8QwQTZPZsC4PrxvirSbFi0YPYbvkWzzsSr9Zf
 yt2m5js3kaLdurADx6eOP0ff7tJkisrpXxPi+cnAnutQlURUmw+xL6UFgJkEiTUrupxG4nvgt
 GRj9OShyCHWxItJhQsW6sxG5/XQfpHkk+tDjhf2sfOTIyYnu/UpBYoLEmdDin7vqLAzFeS/d9
 eKcwl2K
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 3 Mar 2017, Jeff King wrote:

> On Fri, Mar 03, 2017 at 03:03:56AM +0100, Johannes Schindelin wrote:
> 
> > These patches are an attempt to make Git's startup sequence a bit less
> > surprising.
> > 
> > The idea here is to discover the .git/ directory gently (i.e. without
> > changing the current working directory, or global variables), and to
> > use it to read the .git/config file early, before we actually called
> > setup_git_directory() (if we ever do that).
> 
> Thanks for working on this. I think it's a huge improvement over the
> status quo, and over the earlier attempt. I don't see anything hugely
> wrong with this series, though I did note one bug, along with some minor
> refinements.

Thank you very much for your review. You did point out a couple of things
I overlooked, and while it was a pain in the back to go from v1 to v2
(i.e. avoiding code duplication, which immediately put the changed code to
a huge test by having the very central setup_git_directory() use it), I
really believe that we are better off because the patch series pays off
more technical debt now than it introduces.

> > My dirty little secret is that I actually need this for something else
> > entirely. I need to patch an internal version of Git to gather
> > statistics, and to that end I need to read the config before and after
> > running every Git command. Hence the need for a gentle, and correct
> > early config.
> 
> We do something similar at GitHub, but it falls into two categories:
> 
>   - stat-gathering that's on all the time, so doesn't need to look at
>     config (I'm not sure in your case if you want to trigger the
>     gathering with config, or if config is just one of the things you
>     are gathering).
> 
>   - logging that is turned on selectively for some repos, but which
>     doesn't have to be looked up until we know we are in a repo

You probably guessed what I need to do, anyway: for our GVFS usage, we
need some telemetry (i.e. usage statistics), and I basically want to run a
hook whenever any Git command is called, but only on GVFS-enabled
repositories.

So it is somewhat related, but slightly different from your usage.

> I looked into making something upstream-able, and my approach was to
> allow GIT_TRACE_* variables to be specified in the config. But of course
> that ran into the early-config problem (and I really wanted repo-level
> config there, because I'd like to be able to turn on tracing for just a
> single problematic repo).
> 
> So not really something you need to work on, but maybe food for thought
> as you work on your internal project.

Right, GIT_TRACE_* settings in the config should be doable now.

Ciao,
Dscho
