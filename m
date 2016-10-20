Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76E4C20987
	for <e@80x24.org>; Thu, 20 Oct 2016 10:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755896AbcJTKu5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 06:50:57 -0400
Received: from mout.gmx.net ([212.227.17.21]:55662 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752274AbcJTKu4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 06:50:56 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MHrk1-1bwMVz0Fqv-003dhE; Thu, 20 Oct 2016 12:50:34
 +0200
Date:   Thu, 20 Oct 2016 12:50:32 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Drastic jump in the time required for the test suite
In-Reply-To: <20161019205638.m3ytxozzmeh47ml2@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1610201218060.3264@virtualbox>
References: <alpine.DEB.2.20.1610191049040.3847@virtualbox> <xmqqbmygmehv.fsf@gitster.mtv.corp.google.com> <20161019205638.m3ytxozzmeh47ml2@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:23UjxaJov4i2McovPy5IcjzicSPZf0HKdifI1IjwuR/vPjiZyJJ
 P5K2JZsHWAMRf/y6iDBXOYrKTeeF0huxZfWDbsgvNAeb1zaBHvtBw5q/Bm9CJUj2SC9nHdz
 65pgTeigGiKsn2pZmShMRIHb95xUW/3aBbKeru/+8Es0dWTQsrSE90zWiSZimcNYTB25+1s
 qGpg+lGytD4PXJaF1Axeg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LLCPmknGroA=:TZhAXK+6UHuf5ZwAQ8GSIk
 ekvauuQDtbAGaexbbSMYzgVlfViBZEzSpE5l5M1ForxD5mLcElncWwsc3D69DCTeE2/+FmkCG
 PVc20tVbmT35WXKYGtiho6Ug4NlqP+TDF5cgbxRgHyvYxVHON8fxvyNERQB0YRBcBWjVDs/0+
 uh0uT04azr6O/JnJSPC4FXR/27kZnS+SmRK5lnV6QcMjXS3M/ANkSWFJw+5tyiBxwsjP87Van
 MqYW5WxTkYGqeG5z+/SMPX42hxDc0YMRZkcmd+6FN2nnGGUfnJKGXhoiOpjQuPYFAvQSTpDWR
 Bk58sUI2xszIn5AEozdxuWBdp3+V4LaH5+tywlMRSCTUMTu13/B0umoqENjERh3iEjxIeC62Y
 bxtnYUwU2e/y3nrI7sVyiZSsCZ1qzoM99D0wfcdiPEprETmDRMAcj7Mo5I+UV6/6SChdVktTM
 04zA2GIxdRGwHeI+C01zjfDUnZ3aWQlzbNggdnmnJS1TERsmRa5AVr+eWnkzPu+DX2eyx3+A9
 pBvCFpC9hpuz5QJLfNGuAANCqnMNkuFfrrnnzPLcwGz80R5KEzA9oAqFyzdcm6PloJ7T/YHJ0
 Ey5iGpOaI2MNZXar1tmKGEhQxdJYLVI24xFdIm/G4FSt34s104DuRuoTZPxOA2RYU0ZV1sSZd
 2yYaDKaobrnwlPJ6Gp+hPyWarK69Lwkk7Z+UYtb8WHSFy8GkgjHEc5ir9SbwvhP9SsrV6SAaP
 gKy9eK7LcJWztvPqmgCrd7G7rgNbmAm0P1WVKdKOrpRPxYXh0797VkDpeqleG168nZf4FUX0q
 5/xW8lg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi peff,

On Wed, 19 Oct 2016, Jeff King wrote:

> On Wed, Oct 19, 2016 at 10:32:12AM -0700, Junio C Hamano wrote:
> 
> > > Maybe we should start optimizing the tests...
> > 
> > Yup, two things that come to mind are to identify long ones and see if
> > each of them can be split into two halves that can be run in parallel,
> > and to go through the tests with fine toothed comb and remove the ones
> > that test exactly the same thing as another test.  The latter would be
> > very time consuming, though.
> 
> FWIW, I have made attempts at "split long ones into two" before, and
> didn't come up with much. There _are_ some tests that are much longer
> than others[1], but they are not longer than the whole suite takes to
> run. So running in slow-to-fast order means they start first, are run in
> parallel with the other tests, and the CPUs stay relatively full through
> the whole run.

That reflects my findings, too. I want to add that I found preciously
little difference between running slow-to-fast and running in numeric
order, so I gave up on optimizing on that front.

>     43.216765165329 t3404-rebase-interactive.sh
>     30.6568658351898 t3421-rebase-topology-linear.sh
>     27.92564702034 t9001-send-email.sh
>     15.5906939506531 t9500-gitweb-standalone-no-errors.sh
>     15.4882569313049 t6030-bisect-porcelain.sh
>     14.487174987793 t7610-mergetool.sh
>     13.8276169300079 t3425-rebase-topology-merges.sh
>     12.7450480461121 t3426-rebase-submodule.sh
>     12.4915001392365 t3415-rebase-autosquash.sh
>     11.8122401237488 t5572-pull-submodule.sh

That looks very similar to what I found: t3404 on top, followed by t3421.

Further, I found that the Subversion tests (which run at the end) are so
close in their running time that running the tests in parallel with -j5
does not result in any noticeable improvement when reordered.

I guess I will have to bite into the sour apple and try to profile, say,
t3404 somehow, including all the shell scripting stuff, to identify where
exactly all that time is lost. My guess is that it boils down to
gazillions of calls to programs like expr.exe or merely subshells.

Ciao,
Dscho
