Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F1171F6BF
	for <e@80x24.org>; Tue,  6 Sep 2016 16:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934754AbcIFQEi (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 12:04:38 -0400
Received: from mout.gmx.net ([212.227.15.18]:49223 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934219AbcIFQEa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 12:04:30 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Lh6sJ-1bJmUL2RQF-00oYMk; Tue, 06 Sep 2016 18:04:22
 +0200
Date:   Tue, 6 Sep 2016 18:04:20 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] diff_grep: add assertions verifying that the buffers
 are NUL-terminated
In-Reply-To: <20160906070836.7brjtijxq7nukjkq@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1609061803120.129229@virtualbox>
References: <cover.1473090278.git.johannes.schindelin@gmx.de> <a264f55769cd6cfedb842710791d71b11d830091.1473090278.git.johannes.schindelin@gmx.de> <20160906070836.7brjtijxq7nukjkq@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ZjLuDw9a3/ibLuki8XuK5dGbueyvF1Tpt+EexuJ6dKh36Tbg3MS
 AYccaGtXMTIfPetCwwDIVjMTbMzssfhjpuGtu2SRMZ8TsWTGHNa5/yW/Un+iHsdT+etmKDE
 sxArk9vAqTTLDQjL2DC1Y9vmR4A05be2zU0xraleAGnQ0SObYrT9DA3EJbCnoPUhp98PSCs
 oBLvy/K8oBC/qdJE2IRkQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UetqoQ0IAkc=:EDN6zMmRxZXu7VqhmFkLnU
 kIbU0qURMUSStjFuzctCmoxadCYnb9+NXlVbIO9ofd84bEcFW8HwTQ7kdw/v7/rrDf12jfY7o
 h4hmkMOdjcNO3RZFtHfhyEeU5xeIz+cWPy134l6OVSNShZ63fd8JZzbzqfCzu+Cdf4ahbBOPv
 KWXVC8gnm0oMuidiHTtp7t7OwZoyDJOhKK9JnoIMBZBlkJFyGaU1W8EtfQI2eePSKQK+ex7P9
 XbAkv/ofOuFTuH70/R//2BAfI6MBOOvuVrkDq8EHdLtn4Xv4Dcu9qLYKKObhVKqqpYqy8YAqr
 ToAUnpvmLDBd25qYJFXNwDIHim9sHk9vAm3kJyt6Ttd/fCmRpLgb3Pu51l5va9to6ejUQMg0Q
 Gh43Vgmt/lW2SF7mFuc1iIDdJybFIjR8TFp8E4x9PRqX2bpF4ld0Z2WqsJA/xx9WKhlSmaqMH
 H5FiKi5xNwwmHB7DqgNAUPkCTCslJeNe1SK/EEoPcaMgB5cxppjtjvhtF64l1HwB2CpX2DlDZ
 m2r1t444acRwmlJgWl4GcfkkMEhXlG59YH+TMIg/u71NPVGTDYYMJCfQUWZF4IuaYlW0P9/VM
 rJTer37ZXZmsf3+F9TZgzBYOFUMQrHXG1CEIbHEBMZfJjJCPqY9HNZQD6ka52QoKaXXEtb3l9
 O78oTGOkL23viWQFAkTTA6ECuX+m7hc9xspUZyl8Y+vlJ7dqUB8pLG81BAna5So6Q51RsgpG5
 3Wkk0ISdFw42M8e0Dk67GnODF/MXxr/4VPZd+zmLEVbbeduytjKZprDXn3mIYo6Y77gCbYoNf
 NXTzbTH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 6 Sep 2016, Jeff King wrote:

> On Mon, Sep 05, 2016 at 05:45:09PM +0200, Johannes Schindelin wrote:
> 
> > Before calling regexec() on the file contents, we better be certain that
> > the strings fulfill the contract of C strings assumed by said function.
> 
> If you have a buffer that is exactly "size" bytes and you are worried
> about regexec reading off the end, then...
> 
> > diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
> > index 55067ca..88820b6 100644
> > --- a/diffcore-pickaxe.c
> > +++ b/diffcore-pickaxe.c
> > @@ -49,6 +49,8 @@ static int diff_grep(mmfile_t *one, mmfile_t *two,
> >  	xpparam_t xpp;
> >  	xdemitconf_t xecfg;
> >  
> > +	assert(!one || one->ptr[one->size] == '\0');
> > +	assert(!two || two->ptr[two->size] == '\0');
> >  	if (!one)
> >  		return !regexec(regexp, two->ptr, 1, &regmatch, 0);
> 
> ...don't your asserts also read off the end?

Yes, they would read off the end, *unless* a NUL was somehow appended to
the buffers.

> So you might still segfault, though you do catch a case where we have N
> bytes of junk before the end of the page (and you have a 255/256 chance
> of catching it).

Right. The assertion may fail, or a segfault happen. In both cases,
assumptions are violated and we need to fix the code.

Ciao,
Dscho
