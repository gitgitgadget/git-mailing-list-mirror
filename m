Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73B951F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 12:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753094AbdARMeq (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 07:34:46 -0500
Received: from mout.gmx.net ([212.227.15.19]:52405 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751857AbdARMep (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 07:34:45 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LhwLy-1cpOp22kbK-00nBQ0; Wed, 18
 Jan 2017 13:34:30 +0100
Date:   Wed, 18 Jan 2017 13:34:28 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Andrew Arnott <Andrew.Arnott@microsoft.com>
Subject: Re: [PATCH 2/2] Be more careful when determining whether a remote
 was configured
In-Reply-To: <20170117214723.p5rni6wwggei366j@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1701181334040.3469@virtualbox>
References: <cover.1484687919.git.johannes.schindelin@gmx.de> <41c347f22c80e96c54db34baa739b6e37e268b61.1484687919.git.johannes.schindelin@gmx.de> <20170117214723.p5rni6wwggei366j@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:vCNuloip3w4QHhS+A46HcyDo/VWe2YOXiV3Ei+ExXpby3zjjn9u
 Ln9lvKrvR6bhtVgxhs3WPZ742sUwXM961xIDYB09GOIyHaaA+5+D/8NYXkLZ2Us/qXzbE9q
 t04Ld3WBp3z7uANFTSrzMq5NyDK+sDf6eVqBswPjsX30Lx7Yctv2ZevOX2u9LVtbEdQPc90
 C0wPT8qPN0w0QMJtsrMlw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Mivi2EygBao=:dHwLtzYyQ/0QS+ChHZfFvR
 CRYIJTpz2nYY/nJ8UxLf5cFrii8sw8VM1/2tN313aiXZ/rVS3TQtxrIs7+nbq2eBKDwYLOvCR
 JKgfnyzo45QhPw87OjkeHeFX/U3NUrtJTPosdy/AIByDnVfCY+zlRrFf6jrmYTy91iysy7MOX
 H+ftNjb5uvT2+Na6fLB0OQUncwLwXK/oolI7cfss4Rr4TlI/RbOLtUWzLWvv6BPgHifXcF2K0
 Egu96a8YBCYVeIdVJ/UsE13QIfZzg8KNziV0d/ZM7gbZ5UBd9d0TOQTiYQhiDjqI3z+ehrrjJ
 tJ7d0W5Upna3Fvws2Vfar2l5yHdGXX+LnteHtt9q04FfRCfAPrnPpZ4kPEpiUx9P5h3sXAbJ6
 JBr/iclpaqj/4yop+mZ06xKWtALXeaR5DMkKYY5YKvqnvWpJgN46ayY3Aw4YaaeLza+mrVvMJ
 gxReoySd3COvESVpVqHcYnNCs+jX5jkG4+FR6EDullePBLqUha2RRtFsvKVtNcJ8noi4QTBzT
 vHvKVsS2SGrLHpS0FxFqK4f7viAtEHuqkIH/xyvPpMauN/V2JgsFXCZG91OuOTU90zd7r7WJ5
 Q7xIaKP8FVADxFAqPI0Y4jo9NQ64qFCD+0mKTl/JLLarySFUE7Wdz52ITWPg0mgWL9mV/jr0H
 8o7zw+/9yWydp1RERQAQTnCfsrxzEtGq9Cf/50nH2kLnyjmr5AOHrqvp8xP7xD5vwDMp572Wi
 qIOGmcJ6wRRzd5pimSczoRiaY8G0urrGq6ZYaGzY9rlZomjuazUmWr/0qCth7A36xb5Nirk3h
 KIKjg43
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 17 Jan 2017, Jeff King wrote:

> On Tue, Jan 17, 2017 at 10:19:24PM +0100, Johannes Schindelin wrote:
> 
> > One of the really nice features of the ~/.gitconfig file is that users
> > can override defaults by their own preferred settings for all of their
> > repositories.
> > 
> > One such default that some users like to override is whether the
> > "origin" remote gets auto-pruned or not. The user would simply call
> > 
> > 	git config --global remote.origin.prune true
> > 
> > and from now on all "origin" remotes would be pruned automatically when
> > fetching into the local repository.
> > 
> > There is just one catch: now Git thinks that the "origin" remote is
> > configured, as it does not discern between having a remote whose
> > fetch (and/or push) URL and refspec is set, and merely having
> > preemptively-configured, global flags for specific remotes.
> > 
> > Let's fix this by telling Git that a remote is not configured unless any
> > fetch/push URL or refspect is configured explicitly.
> 
> Hmm. Old versions of GitHub for Windows used to set fetch refspecs in
> the system gitconfig, for a similar purpose to what you want to do with
> remote.origin.prune.
> 
> I notice here that setting a refspec _does_ define a remote. Is there a
> reason you drew the line there, and not at, say, whether it has a URL?

I want to err on the side of caution. That's why.

Ciao,
Johannes
