Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41E5E20705
	for <e@80x24.org>; Wed,  6 Jul 2016 07:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751712AbcGFHH5 (ORCPT <rfc822;e@80x24.org>);
	Wed, 6 Jul 2016 03:07:57 -0400
Received: from mout.gmx.net ([212.227.17.21]:49403 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750780AbcGFHHz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2016 03:07:55 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Lp8h6-1boGW91z2i-00epuS; Wed, 06 Jul 2016 09:07:41
 +0200
Date:	Wed, 6 Jul 2016 09:03:44 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Jeff King <peff@peff.net>
cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revert: clarify seemingly bogus OPT_END repetition
In-Reply-To: <20160705202820.GA14496@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1607060901430.6426@virtualbox>
References: <5b424bad41ca027b39eea4b1fa9d87df0a489e0f.1467719888.git.johannes.schindelin@gmx.de> <20160705202820.GA14496@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:lnDQyaWivVJxje9lP+Dp8c/JLGxU5YyRtG7HIqjUwJAPKwtAPhj
 ZNP9Wj3DPkqMJ/xmamWSoghy/GMRey6lyQu+tAJtWbpuWzj3KcLn4vTaxHvlYjy3QEL9xxz
 VNsBjHQI/IpPii/Y4vSW5Rc3jWrIHVSEoOmlSEyWJ+5zjXFIEQf1MLyZL5c8Y+RV6Sn7vD9
 ac9SGGgp8uCiHPsN/wQgg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:/lP76mKoUzQ=:Ys6ANlGxACLHZ68e+LJzCE
 LjSH4YZHeXgJa7ex9CAC0T6lHVIpQIsOc81VeXxQxjT6KJhIoSfN15M9rksWswnz5fTtpBOzi
 J4hZqAISx/gFpviCS+dXhhLslTLg2OxEYRfY0hl+mbP5ZMI7IASKwrc/i2IgaBnXBsUh5D4cT
 mmqTQnE07NatS4RoTpX+2IMpvq9JxmIhVjZLaPIfDP4HvUCVbZWqYFMeeI7cQThXsWm+5iQEg
 93nSgliVCtTKuSeRlIzN7P72C4ARu9jaPwBrl2i9yDXS6cCy2p0jfzoyE3A6sUvRGyYcthTgs
 bWDilsTIA7w7adD80Pbkq/w+k7ZAcLVTFEkbqSu1gq03wwIOc1lx4ipmASVND0cDTkg1BQC/c
 kRzFry8gyTicaWaAc1bIEkWgyeYMeTFT/RoUk3WEAz4moE1AJzBA+9k23vD6EpdvQZf9aX2Pg
 M8rS8vH9/UjmaLdJAyikCU/1CRJq3ExC562WkmaSacjd+8QW0HoUEdWDEjk48oZ8Dzj/H36BQ
 +o0N24DCm5+m48ZTmIDISROfBNvwgx4BIKl9neX1ToRJP6/012XsPCWt/TzC9U1aC2g5ANblA
 VuZqx3bkH4uY7dg6IqnhI/v9MIlqkz2dD3qeUAXEgSVIP+/HWYkRl2zYiDFO7kRzN3t75+5Nh
 E5CP1d2xbgmwb2fkJeKO/Cz2DlIsM/uFCjbi0kgUs7TvAwpqTLx1KdJmcvA8ev0X4lpA1Ldk9
 57QIzEMYVS/rT9865+8CKdWUqh0Oo0/lm8126aC4JnjavgWfix65VpcAAjavC2xP+Pc1bxn2A
 lDEdowO
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Peff,

On Tue, 5 Jul 2016, Jeff King wrote:

> By the way, I notice that the error message when concat fails is just:
> 
>   if (parse_options_concat(options, ARRAY_SIZE(options), cp_extra))
> 	die(_("program error"));
> 
> Should this become:
> 
>         die("BUG: not enough room to concatenate options");
> 
> as part of your BUG cleanups elsewhere?

Not really. I do not have time for a crusade through all of the die()
statements to determine whether they're really bug reports. You refer to
my clean-up of merge-recursive.c, right? That was a necessary prerequisite
for the patch to stop die()ing in case of errors.

Ciao,
Dscho
