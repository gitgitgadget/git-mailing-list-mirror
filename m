Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C874220401
	for <e@80x24.org>; Wed, 14 Jun 2017 10:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751730AbdFNKDT (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 06:03:19 -0400
Received: from mout.gmx.net ([212.227.17.20]:57390 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750770AbdFNKDS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 06:03:18 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LwW8p-1dthzO0wCl-018OIg; Wed, 14
 Jun 2017 12:03:09 +0200
Date:   Wed, 14 Jun 2017 12:03:07 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH v2 7/8] alias_lookup(): optionally return top-level
 directory
In-Reply-To: <xmqqefun96y6.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1706141158380.171564@virtualbox>
References: <cover.1496951503.git.johannes.schindelin@gmx.de> <aa6601bbfa50c728b7820e0a2991da76288509a5.1496951503.git.johannes.schindelin@gmx.de> <20170610101813.n26wmxcueicecptz@sigill.intra.peff.net> <alpine.DEB.2.21.1.1706131319130.171564@virtualbox>
 <alpine.DEB.2.21.1.1706131339320.171564@virtualbox> <20170613114254.oo6r6oqwtchvjuim@sigill.intra.peff.net> <xmqqefun96y6.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:5wdtOFKBya39vq9MSVNs0MAD7a2JuyU8UlxOIAyZ/uHRS31Vjfx
 puI5DTQDxFs+kEUTxLmBHW/c8ACMsBmBdRY3xP0ULis6hTG1idOWmyFWk/I7XLIN0xL4u7X
 YtiUBh2oZA2KfFDeY2Uoie69uj6FHKePmCsXBYM+rR+qB76HmVDHGdvTt11OmBwA2nByc95
 Fqvw44culmXIKjt454LPg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jkIYjw0+90I=:7zVCFPm9W7Vh46IPA+SLFd
 zFZiY8be0aD6G5FYHTlWzrPTmniYy9p1AuyMufp2cVaXmTTpYT7NMftggAZF140wlF2sV8JN8
 6k6o4T6moUR2dszKh3txSEjzhQ6+CnZqW8nZV0PWikDs7OIXxC/gPpeqxLcsfV5dD3iHQNZEE
 YfzROPUm63PeB+IIWfe3sd9GK2pgHrEMrfyVTXHREg+6uq6qMF9qoydAer1Jgan40B8io4S0s
 xJKIwq4JtFIXnseevxiFzNyDolPmQ03B0TqFng6TqU/9iy3i3j0QZT+8CXknomln0CkXpouL3
 ngkNBOKpz/sSj9aAY2AEmjiSWp5C2okLXTl9xH14PPfsRieEkE5JyXNS2Teyi87QqYR7tOECM
 0gewI6Xr8xxlDRRiJQTs+6xRH1L7UlCmRuItzbSrFzS+bz+4VuoQ1gvjwyifUtgjQslPFW57y
 tOwVdpajOG7QvMnV/tKkHN3NDJlaDsjn7S8/N5t4T/nI/r2xZnTBr5tx154ziiRQdmao/2axm
 VHwtwcPe86XlsNeI/g2RuAtpuL0gsL/05YJGWO36g8nzx9ZV3J/qDg5ZkOX5tdnm/dgZP3j3b
 BvEgSZL7BR8jGGo0Xb72TKjkXbhG/s6zgpUDlhwa0Ropc2kte9n6beYNd/qMt+bk1p8IZZizD
 4okHDwG9ncWACraRAilIcEJ25QI6FoPsxMazaxWIu02oia+xQeztB3G+1TJQTIWsoPPwJxJet
 wQmCpVBTb2NI+LhNxUxGYcc+6pOhniqQKK7hnmODiXnXUrfmn41ib8JiVYDTjXxPcEqC3LRub
 MAXkIWc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 13 Jun 2017, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Tue, Jun 13, 2017 at 01:42:02PM +0200, Johannes Schindelin wrote:
> >
> >> > As you probably guessed, I had tried that first and then figured that if
> >> > I needed to keep the config_key_is_valid() test anyway, I could just as
> >> > well keep the strbuf around for later use.
> >> > 
> >> > Will change the code,
> >> 
> >> Alas, I won't change the code after all.
> >> 
> >> It is really tempting to avoid the extra strbuf, but then the error
> >> message would change from
> >> 
> >> 	error: missing value for 'alias.br'
> >> 
> >> to
> >> 
> >> 	error: missing value for 'br'
> >> 
> >> which is of course no good at all.
> >> 
> >> And since I already have to keep that strbuf, I'll simply keep the
> >> config_key_is_valid() guard, too (because why not).
> >
> > Oof, yeah, that is definitely worse. I'm fine with keeping both parts.
> 
> When you replace Dscho's "compare 'var' with 'alias.br' that is in
> strbuf naively with the "skip-prefix and compare with br" without
> changing anything else, i.e.
> 
>     if (skip_prefix(var, "alias.", &key) && !strcmp(key, data->key))
> 	return git_config_string((const char **)&data->v, key, value);
> 
> it would cause the "br" to be fed to git_config_string() and result
> in problem reported for "br", not "alias.br".  
> 
> But this can be trivially fixed by passing "var" instead of "key" to
> git_config_string(), no?  Am I mistaken?

Oh my. You are right! The `git_config_string()` function uses the `key`
parameter only for reporting, not for anything else.

So all I had to do was to introduce another variable so that the `key`
pointer would not advance beyond the "alias.".

Will fix,
Dscho
