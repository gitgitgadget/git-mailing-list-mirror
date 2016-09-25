Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 876301F4F8
	for <e@80x24.org>; Sun, 25 Sep 2016 14:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756202AbcIYOCP (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Sep 2016 10:02:15 -0400
Received: from mout.gmx.net ([212.227.17.21]:55800 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756006AbcIYOCO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Sep 2016 10:02:14 -0400
Received: from virtualbox ([108.198.118.51]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MYwQh-1bRHw212A7-00Vgph; Sun, 25 Sep 2016 16:02:02
 +0200
Date:   Sun, 25 Sep 2016 16:01:54 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Benjamin Kramer <benny.kra@googlemail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH v4 3/3] regex: use regexec_buf()
In-Reply-To: <20160921220310.5wk76qdsjyhvstk4@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1609251600120.129229@virtualbox>
References: <cover.1473321437.git.johannes.schindelin@gmx.de> <cover.1474482164.git.johannes.schindelin@gmx.de> <53f3609d99c865d59d7bfd8219a5334339e9e6bc.1474482164.git.johannes.schindelin@gmx.de> <20160921220310.5wk76qdsjyhvstk4@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:cpZW+oTK2O+ipHwWiNyVVM/UsJlOmDBrzm/7ZpwQIU2GlU1cquQ
 jElMaLNZIl+6PeRWs97ZyBz9wmzq5evu7OFR1pKE1d07Kf/9EcUXQynSrsz/lf4ETmhXpaa
 peCt9FQLY/ETzLYDfdPH/0mnwNqQ46dxGq0/RUSjs20g3NrTIQ359IB0iNR9oIerZA93Rxb
 BrZwoaOzCdZQitkfh/Opw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LGUurQ6iyWs=:DNTidWJzms/csBe8/ZdA7D
 CrRMh3LqjecV5UcSPrMVPnBvKD6iGS9KAxeanX0wm55NBA4jIQ2Wx9Wh8raRQBYHt4izm0Du3
 d235oCW+xIh/eqXun/7L64cuklmlLMdQuuOn6JFrgwMWzLTOAANf7/0gCkih6G/XD5NCAsKn0
 ZTvD7StsBynLoBzFMFhoCC2/p0OR1Ncxn4AMQYEJ8p7Z5y6WlVhxVMAwhLgwKndkWGRD/UfpM
 ZNgpZxGVfZsqLbQLoFPw/jCvKHkQ1ghHZCYft2FtyvhMoFam9iFsIRQK0rHp4wvgV6f14D9u0
 dBUqI8njT1Iff59p6Yj6LPnQ5Ii/eTOBWfqByr8NnR/tkOXYU64OX1EWHjGm1pSH/pIPCsLHK
 lg77EKrSOlnoP35dmGu2OyvzSGIpsekwq2OBjsuGPKcdsZ/BAxFJojaIZWKtV2ReTJ7Z/gEVR
 3HBd1NKkmn4aYlOEsSQuG30JcUM54Q60dH2uvFpJqOMGWpSC+EPAMsn21HW/qmiD6H9ahqCqm
 +FkOJwvs5/iMqNvSHllX5AVZ4eS72lv4YJGIMsWpZh/4rQfH0LWofhNHpnRQkP8nVbkaLNmuP
 1M5c/YGXeGXQ/6E2UGcLtsHKYRApFc90SFvVF5CkrpQh0/AEKk+nlAfcQbSyXCdJfmocmpEFG
 jAwbQCChDMIsmpwi/ZRMtqQT8bca6NEQ+B+hwC+zgRGoDWZFqbHMKBOqAMvdd0KUFEdqq3fNo
 48+QKPhUT1MfAvJcAhfEquls1LVbss9nqgK0eQ1igaG5M0wgqhcdU2JklU+Dh9KhaVe6Xp97a
 pDo4LUQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, 21 Sep 2016, Jeff King wrote:

> On Wed, Sep 21, 2016 at 08:24:14PM +0200, Johannes Schindelin wrote:
> 
> > The new regexec_buf() function operates on buffers with an explicitly
> > specified length, rather than NUL-terminated strings.
> > 
> > We need to use this function whenever the buffer we want to pass to
> > regexec() may have been mmap()ed (and is hence not NUL-terminated).
> > 
> > Note: the original motivation for this patch was to fix a bug where
> > `git diff -G <regex>` would crash. This patch converts more callers,
> > though, some of which explicitly allocated and constructed
> > NUL-terminated strings (or worse: modified read-only buffers to insert
> > NULs).
> 
> Nice. I probably would have split these into their own patch, but I
> think it is OK here.

True. I guess I was a little lazy...

> > @@ -228,18 +227,16 @@ static long ff_regexp(const char *line, long len,
> >  			len--;
> >  	}
> >  
> > -	line_buffer = xstrndup(line, len); /* make NUL terminated */
> > -
> 
> Nice to see this one going away in particular, since it's called quite a
> lot. According to perf, "git log -p" on git.git drops about 1.5 million
> malloc calls (about 9% of the total). And here are best-of-five results
> for that same command:
> 
>   [before]
>   real    0m14.676s
>   user    0m13.988s
>   sys     0m0.676s
> 
>   [after]
>   real    0m14.394s
>   user    0m13.624s
>   sys     0m0.760s
> 
> Not a _huge_ improvement, but more significant than the run-to-run
> noise.

Oh, that's nice! As you guessed, my aim was not to improve performance,
but it is a pretty side effect...

Thanks for testing!
Dscho
