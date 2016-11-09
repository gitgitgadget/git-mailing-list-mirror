Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BDAC2021E
	for <e@80x24.org>; Wed,  9 Nov 2016 13:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932867AbcKINrb (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Nov 2016 08:47:31 -0500
Received: from mout.gmx.net ([212.227.17.22]:51470 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932910AbcKINr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2016 08:47:28 -0500
Received: from virtualbox ([37.24.142.46]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Mg0IT-1cRNva16kX-00NTtZ; Wed, 09 Nov 2016 14:47:15
 +0100
Date:   Wed, 9 Nov 2016 14:47:13 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     Andreas Schwab <schwab@suse.de>, Johannes Sixt <j6t@kdbg.org>,
        git@vger.kernel.org
Subject: Re: [PATCH] t6026-merge-attr: don't fail if sleep exits early
In-Reply-To: <20161108200543.7ivo3xoafdl4uw6h@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1611091437280.72596@virtualbox>
References: <mvmtwbhdhvb.fsf@hawking.suse.de> <20161108200543.7ivo3xoafdl4uw6h@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:xWdS5+MEWfjmakF8J3AS7KGLz6lv9v+LbB9wJQw3CFL0UcFPj2A
 VTeLmsnFz8TYc9UIGLdMB9B0fMH3k/MusTgw74qASFPCWaa0p7q23eqLw9uh7IwlFGOVpQ/
 lB4UtVOvfKnt6XyG0I/peP1MMORJGGQFLv1Y3eJc5jnuxl614LDA873Izq19DRuLkk0tdgU
 zNEVtcYOrIr/pEGugCoTA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IMrAeN62n1w=:PWI2x7cfECKYAwjoCmqlTv
 hFRZzj4ymmuMhVVxvV54642khdyfps8Uc+77FsTf4pOoTW/UXreZ23drOkrzujjVjxUlUKiX4
 bcvWnEvLrY145eRrrWlN9aqJtSJd+VUeKOQ+Y+421IsMtKnNq1tPvchIGf/hW8oT53T29omkC
 ItWUI6vl86H1F9uM2XrRQkMhCNbpVsfncO9eTnoi6/wa5wI8r2ZxArnw+5Gs/olT9pKRX+vjo
 PNUi9NFzRo4fVI+5dd1PX9qGZ8isKm4S+QRgkQmqjhm1Hh2YZerx8FRW16L2tOOqdhB1ofwWB
 CSiiLKMxY5gMHaPUjQvNaAzlrrJL6Dzo28mcW4podiSDTya3c1XvlBDkbXtWd2VtgkZop1v60
 uAKNZnJ32M0NiR53xEL6LGU7MgrHjl+z79u2G80/lfT4b9DD41IoySVAmmJxrbdY0ki974qTn
 z0Rz1AJiZX2iOe+K+3JOmrXsD7uQ/Ue7PJSJLSKJkA9KFCrlNsfetc5uX9Aoc36w5rHqHA5sE
 OFPzpisJltcvlUir8UMgQURKZNqbnID73nxKD7oPs+L64xPKL0mCaCjIE40ngydrKoxHfzDkj
 3RNlcWT32wXUUNlTmB58p3eMFL9wxqRmmB+s6au1XJw70+ck0dMhPCHOdGJc3Hu1YDNY2ng4l
 txqsUTMTqpda7lGN5zVLP+bbMmrtVJsswpcVvqn4Wi5pSeHKerweE2CEdMuKGdvxBXuZyGvJm
 JyTBVBdPzZaxGfB7CxyIPlSYtMz84nPBiswjXb9wvzUdVPno716y9xw0vGdyhCq2+A7Vw0dKy
 LDrtiqG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi 

On Tue, 8 Nov 2016, Jeff King wrote:

> On Tue, Nov 08, 2016 at 06:03:04PM +0100, Andreas Schwab wrote:
> 
> > Commit 5babb5bdb3 ("t6026-merge-attr: clean up background process at end
> > of test case") added a kill command to clean up after the test, but this
> > can fail if the sleep command exits before the cleanup is executed.
> > Ignore the error from the kill command.
> > 
> > Signed-off-by: Andreas Schwab <schwab@suse.de>
> > ---
> > The failure can be simulated by adding a sleep after the last command to
> > delay the cleanup.
> 
> Thanks for the reproduction hint. I sometimes run the test suite through
> a "stress" script that sees if a test script racily fails under load,
> but I wasn't able to trigger it here (I guess a full second is just too
> long even under high load). But the extra sleep makes it obvious.
> 
> Looks like the original is in v2.10.1, so this should probably go to
> maint, as well as the upcoming v2.11-rc1.

The reason why we do not ignore kill errors is that we want to make sure
that the script *actually ran*. Otherwise, the thing we need to test here
does not necessarily get tested.

So I would rather go with the patch Hannes hinted at when he said that he
did not want to change the file name (as it would have made the diff less
obvious): increase the number of seconds.

Will send out a superseding patch in a minute,
Dscho
