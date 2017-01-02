Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACEEA205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 14:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933310AbdABOis (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 09:38:48 -0500
Received: from mout.gmx.net ([212.227.15.15]:49398 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933062AbdABOir (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 09:38:47 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lp3x6-1d2uI20vVk-00epsE; Mon, 02
 Jan 2017 15:38:34 +0100
Date:   Mon, 2 Jan 2017 15:38:31 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 28/34] run_command_opt(): optionally hide stderr when
 the command succeeds
In-Reply-To: <f4a72743-3488-3466-5b9f-0dacec102a54@kdbg.org>
Message-ID: <alpine.DEB.2.20.1701021533220.3469@virtualbox>
References: <cover.1472633606.git.johannes.schindelin@gmx.de> <cover.1481642927.git.johannes.schindelin@gmx.de> <1e82aeabb906a35175362418b2b4957fae50c3b0.1481642927.git.johannes.schindelin@gmx.de> <2637bed1-c36f-32f6-b255-ea32da76d792@kdbg.org>
 <20161214125322.o3naglvyuzgk2pri@sigill.intra.peff.net> <20161214130640.ginadvry7wor3tkc@sigill.intra.peff.net> <f4a72743-3488-3466-5b9f-0dacec102a54@kdbg.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:1RTsMXRP5ceWzkPfbU7/aG2q4lGJlzqnQ4PMnqXadXw6tlXt0Ys
 onBUdgxN27E4r5Yzj4e96ox/MRsLt1JMzERBerbQIT2I9hfNoga6O/JRx6d4yhNFGJs5DX4
 YGLTuKcHFAGfVwbfzgd6CutgaDrj4kLBQYvkgVqcvMTldmo8UNvkOLe19CtVYAb2Bb6+cD3
 X3rCVwMgJ2vniBmqEMiUQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+j+boBEnuU0=:dQx0iAzulAJXiH587OPOLU
 /le8y8DpbzQ710yRSG9duEGMyW5kPIDux6xPD5Tea92JlAUny06VPZbFfqt3Mz+Dcj/aKbanc
 3KDh7Sxddm/PSzcqjoulL2kePC/cBd87t7uSMCkJXUYQsZj4itkXI0cirEalG0hylgXDWjcD0
 8zJeppNB9PvqFVycTvTbxiN7/AdVXFWK1O0qekGN4P7GnUzha2fmuI3Xs1CBIIPQe+Ts39F1e
 xvIxg89/6GNEmy7VI78/Wgy/0vygkuKPTk86qL+C9o8TADW+D3ql7SPud5ZXCBjeiUkpSZK5K
 etOrAeKLpLnQJk1xSMTthgcF0hZDqwWz3wuqxiRe9o0ou9TG+0jOyPTRsGOUYvgsOg4cZB1xn
 h4GvXE7E/WxCdw1gTXMtOXij0kwUd8aT7wbse6tnjPdNLALtwzZOFKNcr9jHoJCqBY5qVVarD
 ncfmpweVg4mlIYAVrftu80JS22Q949ybC+pZknioE9vSMdoNSEliI7c6YwRvqD2lS00sdSTAX
 1LU7hB/sCaCmWBCggpS46UO6uUUonhgtqNwm4dYUOTxhlEQ1p5mw0n23AYe+7q5bm3OAEibhl
 BqI/qssSRxCut8eZd6NEo0eMXwQTXwDmgdxJAljA+s+1WYBJQhzlB2wF58c7smVcsk0F3z9ri
 mSkgihdoBEZvWtkxTegah7nl05TTiS697cXX/4VoU6RGjHkdCxPBAewt1L4x0ha4wlq7jv4Fe
 LUzg/pvlXB/yvds0CqZOH5O3C/K0o3qQ6/4a2E8sRrOQDTo0DXLzstjzXCUH2F4E26AnCqDd0
 +ilHpU3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Wed, 14 Dec 2016, Johannes Sixt wrote:

> Am 14.12.2016 um 14:06 schrieb Jeff King:
> > On Wed, Dec 14, 2016 at 07:53:23AM -0500, Jeff King wrote:
> >
> > > I don't have a strong opinion on the patches under discussion, but
> > > here are a few pointers on the run-command interface:
> > > [...]
> >
> > And here is a patch representing my suggestions, on top of yours. Not
> > tested beyond "make test".
> 
> Thank you, that looks way better.
> 
> If there is agreement that this approach is preferable, I think we can
> have patches on top of the series; they would be orthogonal and do not
> have to take hostage of it. (And it looks like I won't be able to follow
> up until later this week[end].)

Seeing as the original intention was to do away with the
RUN_HIDE_STDERR_ON_SUCCESS flag, and that the sequencer-i branch *must*
include that functionality somehow, it is unfortunately not really
possible to do this on top of the patch series.

I say "unfortunately" because I feel pretty uncomfortable with replacing
something that has been tried and tested by something that still awaits
the test of time.

So the only possible course of action I see is to go the really long
route: incorporate the patches to use pipe_command() instead of
introducing a new RUN_* flag (which means basically munch up your patch
and Peff's and move it somewhere into the middle of the sequencer-i patch
series, which is exactly what I already did locally), cook the patches
beyond recognition in `next`, i.e. cook it really long to give it a really
good testing before moving the patches to `master`.

Ciao,
Johannes
