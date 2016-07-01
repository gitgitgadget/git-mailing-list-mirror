Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9FDC20FD0
	for <e@80x24.org>; Fri,  1 Jul 2016 14:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752505AbcGAOBU (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 10:01:20 -0400
Received: from mout.gmx.net ([212.227.15.18]:64486 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751793AbcGAOBT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 10:01:19 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LpKKr-1bn4Q52BEL-00fBRb; Fri, 01 Jul 2016 16:01:00
 +0200
Date:	Fri, 1 Jul 2016 16:00:59 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Jeff King <peff@peff.net>
cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/Makefile: add a rule to re-run previously-failed
 tests
In-Reply-To: <20160630063725.GC15380@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1607011558010.12947@virtualbox>
References: <b2d016e44fa04e8a318967c43762d6933faf7956.1467183740.git.johannes.schindelin@gmx.de> <20160630063725.GC15380@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:9fYGf5PFj1VpB/LEZMS5bjYiWSSbk+JutZPtxNY8np9y/lZcz42
 2KZ4aP4o95S3WFz1UrvhBr6iLNL0xqexA2xc4nwNwVN8btVhiglUNfM8wS027BJoutAM5zE
 fjOS8e5uOs4HSrfg0fwrA/bNZvBtPyJ49sHoNLWt7yOuxDAfiFGPy8JHdz1tnbblaQz+PgE
 n8VeUmcMm+e8SolOfx76w==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:iCRIcMRySWc=:IzT1JjXzmNP8PBciyhCB4M
 pArsJ4hJI75eVX3gPc6wZxoPqe//mNp+iPF50TxkRv8BzA6pHCpIIkTMnjUoFlvySgE/fJphb
 dCGoOk7I+a0zq8JDE2YZzltiMKLDDp/P1MnLROzgvb8h3/JGwDydKmuDjN6/i3z499PivUgM6
 3X+bjVxzTTgbo5sle+gohdZGqLAZp5rHe8SfZkq2AUgCMQAMCUicCXNBd9aEU/BHPB6ayoffc
 i4ErsXRRf2RoOJiuzueCunZnWBfs/+B8cKVSdAJeke3snaXfFuQAo5G3Gmsdv6m+NHbzpc0Vw
 Sl1t6TVuqA34cDi4RDDv39WVAg6qDioNBTZIL2dMXV/XnGMJfI7j6mu6HlcvlkbGaSHgLxv+R
 PKJeZvsaEk7SppHn/SWbBJbgGakb0MUTRhFoUmRTWMBlfdZPVendTfWN6HG5n9m3yXMCdB200
 QG6hSpj7wuowx4k9nBvCBJ7Z1/ileJ9sV72364h/E3coOObUrsYK2ECtmxXp6o84FJ6aUhIma
 SPP9VBav1SlwYlUFf0vdhtOUsOQ3mw00Y/cLRzyjhxJMkCMsqDevIGqY53wnUffTL+N3W6S+e
 OrvNp2URkpcux0Bzl3SNiVbhHPfuV7nD01Rh+cbeqksgBz/KGaM/LPhkMJqEQfe3PtF1zk20q
 LabrWjZ0iF03y461OAfyhGlIJoHXsm929PCyJ/dhM8PYOUTWwks+heWNE6n3VIEkAt7hDfDPE
 uxwchpW3t38E2Zoc8tzbrDJ7FPyOVEoSz0ZxUKJPOLVaPRatKMw9BleyOerwKtoZd1yMiImu5
 mvQErs0
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Peff,

On Thu, 30 Jun 2016, Jeff King wrote:

> On Wed, Jun 29, 2016 at 09:02:37AM +0200, Johannes Schindelin wrote:
> 
> > It is the most convenient way to determine which tests failed after
> > running the entire test suite, in parallel, to look for left-over "trash
> > directory.t*" subdirectories in the t/ subdirectory.
> 
> As Junio noted, this doesn't work with --root. I have sometimes used:
> 
>   grep 'failed [^0]' test-results/*
> 
> for this purpose.

True, I could also do that. Looking for directories rather than spawning a
full-fledged grep is more light-weight, though.

> > This patch automates the process of determinig which tests failed
> > previously and re-running them; It turned out to be quite convenient
> > when trying to squash bugs that crept in during rebases.
> 
> I suspect your response will be "perl tools on Windows are too painful
> to use", but the "prove" tool which comes with perl can do this and more
> (e.g., running the failed tests first, and then following up with the
> others to double-check), and our test suite supports it quite well.

It will surprise you to learn that I did use `prove` extensively. There
have been enough problems with it, though, that I stopped it.

Modern Windows does not have too many problems with it, but it appears as
if Windows Server 2008 R2 (which I used for quite some time for my
principal development) requires too many work-arounds for Perl to work
reliably so that every once in a while, `prove` hangs without any real
reason.

That is when I stopped using it.

Ciao,
Dscho
