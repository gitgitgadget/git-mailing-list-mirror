Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9E541FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 17:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933225AbcLSQ7a (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 11:59:30 -0500
Received: from mout.gmx.net ([212.227.15.18]:53739 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932164AbcLSQ73 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 11:59:29 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MOx4J-1cGX6I0DBv-006KQg; Mon, 19
 Dec 2016 17:59:09 +0100
Date:   Mon, 19 Dec 2016 17:59:06 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 07/34] sequencer (rebase -i): add support for the
 'fixup' and 'squash' commands
In-Reply-To: <20161215185630.xxeimack63wqwv2e@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1612191758290.54750@virtualbox>
References: <cover.1472633606.git.johannes.schindelin@gmx.de> <cover.1481642927.git.johannes.schindelin@gmx.de> <ae521f75a105c6b9e54595d68bda3c5b62f313b6.1481642927.git.johannes.schindelin@gmx.de> <xmqqlgvhuj82.fsf@gitster.mtv.corp.google.com>
 <20161215185630.xxeimack63wqwv2e@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:y/2ZwkqQflpwUqRq7pGBm2H1xlYtHicSvD4abhj+3aRRsOAB2pa
 YWwtjHFcR4hr91GJ17TkRqMXf5Jxjm6BDC0wt9PlhOIHS4raKuYUK8YLb5We9Vgy+2yQbgL
 YJZQlIqYCQcWW7+wjgDNoRyLGFaJKz+qGjQIwB14AzqauzUBMP1+9ve5mwrMLK9Spi9pr60
 lvVMjKqC2NdGvOeE3ejWA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+DcjBnonmV8=:hrAV1mUMJqXN9b34kgA78e
 dSJwrpevyRcFQP5QcM1ddDdTzlahrSkw0MZ8WrleN/9TPz+9NcViD9DUVdKhZEX+YhxYjOWiY
 /yR5Jr0cBAUECyAaPlVtyyHmkllYKxNeiLw4ncgoQNc5m9QZ2ShhT6ixWMZE2mguh+RERGDGu
 hEw8X5ShgvoThRcp5o+7AdV4qnBzUxN2Tj8987b0cT+QmJHzB8oxyR6es5fnMnMIncVmEN+q4
 dCHghTu39PINBhDG4BzGkGgW4U74S7p5bkx9a7gfxrzWMZDqRQEB87y1bAUU06jRhyOY9MLJ2
 6tszr4x6m7cQ2MRhJBpAfQw/XvLXbA+msKyweKFt3tNh2oD0CHsh3Rs/rp46HqELiMVNpHvAQ
 RgBfp8uBvQwnjWHh7r2dryQbarEafy4n41cQGqg3r1/L18nRhczews5rqsDi7W2ve++ibYWof
 dEuURaKNYxfk8Xk6WKwvWGNh0Lc6TDcs5AnECeGdXSf18aGVq193XDm4qan59ebb0aFA7jfjl
 AfCLvcp15ZLhswrzHfuTRHi3FDXnBWtm6k00wm3N+F0TGpE4AFgl49w49fznMwgO5+FzIRXF0
 5FkirBUou+HtdKua1H4nG78tjfMKma3tWXZ+CnOXV+9lJ8mDrM8hDd8CWJE7EIhRcy1g+5Ufl
 sZML6P3Qjaqk54SoHZofUfLEJ9dsgI3VL7wRD2sR6XOb1DowdOg7Duh2xw11lwuu3qJeZ0/+w
 aNzb32FcrMLMwJJzlSDefxIOg2z8tgQWiz5iJdiFmZ0j3W04zUZ3y3T8Pa/xLHNvcp6ImPMjN
 JOE8wUg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 15 Dec 2016, Jeff King wrote:

> On Thu, Dec 15, 2016 at 10:42:53AM -0800, Junio C Hamano wrote:
> 
> > > +		sprintf((char *)p, "%d", ++count);
> > 
> > Do we know the area pointed at p (which is inside buf) long enough
> > not to overflow?  If the original were 9 and you incremented to get
> > 10, you would need one extra byte.
> 
> Even if it is enough, I'd ask to please use xsnprintf(). In the off
> chance that there's a programming error, we'd get a nice die("BUG")
> instead of a buffer overflow (and it makes the code base easier to audit
> for other overflows).

I ended up with more verbose, easier-to-read code that does not try to do
things in-place, in favor of being slightly more wasteful with strbufs.

Ciao,
Dscho
