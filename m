Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B9581F859
	for <e@80x24.org>; Wed,  7 Sep 2016 12:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932705AbcIGMxb (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 08:53:31 -0400
Received: from mout.gmx.net ([212.227.15.15]:61480 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757343AbcIGMx1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 08:53:27 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MH07e-1bmcYA3EbS-00Doq9; Wed, 07 Sep 2016 14:53:16
 +0200
Date:   Wed, 7 Sep 2016 14:53:15 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Kevin Willford <kewillf@microsoft.com>
Subject: Re: [PATCH 1/2] patch-ids: turn off rename detection
In-Reply-To: <20160907075411.cr67cbvmy7gxv2om@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1609071452580.129229@virtualbox>
References: <20160907075346.z6wtmqnfc6bsunjb@sigill.intra.peff.net> <20160907075411.cr67cbvmy7gxv2om@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:b7n+dCQ6IYOj1/TMrQ6bLap7RGZQOIsgZLXzvepojSGmV05Z3MY
 SF8d6vX+zx390/PvyRXxRwyWmVxaBSA7FAGggd6ewtni1hqFtbVH8vXgbwjy5LfPm6SC9Mi
 E57MLdfAqCod1B8/U6pfndeSgYLq8GF2d6qGIrEpiZWM8DdQXW+CQb/XaAfjFhbVaELwDpg
 ex7/a5A1ibrQ+N8nKfFog==
X-UI-Out-Filterresults: notjunk:1;V01:K0:V1u2ovr6ctQ=:GiJZie8Z6HgVWFv5CAty+a
 HDyjywrLHsmsmevpS2cvx/F6ULpHq0P96kEcYkRjhHemlzm/6mJDa82lJ/E5F9qeb7nKv8c1+
 6qtsT1dls6sUa8LtziRnrs4QWosbERuaPMwBQgAjn4prerBaGJsBnz6TWlk+04Eh01TCluvRZ
 QK8MUk5OENO8JdUbVpOncFWn9vT4tkgj9L4KPpE1Y51r/LWB6Q26jNgx1FDwjyrO4IZbkIPFM
 idyDQf0AgTe0QAv7JGp7ZwbxpWpjLd9Lhp9J+x6KYc6NDLGIPa5hMAKEbGSlmAZnJT0Nw/YRV
 3wzXKAl3VphLHojpDMViXURS1/REMtQA6bzjReEgyY31rVSZX23uYzjHzCyrXYzBB46C7GMAf
 Wxt9rWpJyGGB8a5N65HIFbqO+E2G0C4v5khpNGSM4M39LVP6pugOiPEAQgOfYC44sG0ikuoOB
 MSaPHLqxhTXmgWKY6jPeZw+hjy6zJhIp2qLowak66RVOXTCAB3UcMYLd468cUfOMP28bbI4d4
 Y1rJ45hPmLaFqD7M4Qi+bVe2sxasv483QNH1g6srboUuFwESLDGuPw1mQYNqZuNWpPPTf66ui
 fMUKHtznzYfUsgnhjdYtXtrkyIUUyCjlXTH0j/7SSkAVVLN8AB8rhaShq/QSRjt8Kkh0xyBOH
 I6W5SVECG6hMZtLuB2V7OIit9jrJ8gBjB+nz57y7eoiOw+Di3f/4+EXlAefwS75WuV45+FedZ
 TuMkoEsebiDoRHs6/uqFy1fqnPoCtm76obyRc8PjJCFYE1LKa0kbjSAcnetgkNVghHXmKtbuZ
 fmv2l2O
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, 7 Sep 2016, Jeff King wrote:

> The patch-id code may be running inside another porcelain
> like "git log" or "git format-patch", and therefore may have
> set diff_detect_rename_default, either via the diff-ui
> config, or by default since 5404c11 (diff: activate
> diff.renames by default, 2016-02-25). This is the case even
> if a command is run with `--no-renames`, as that is applied
> only to the diff-options used by the command itself.
> 
> Rename detection doesn't help the patch-id results. It
> _may_ actually hurt, as minor differences in the files that
> would be overlooked by patch-id's canonicalization might
> result in different renames (though I'd doubt that it ever
> comes up in practice).
> 
> But mostly it is just a waste of CPU to compute these
> renames.
> 
> Note that we don't have to worry about compatibility here.
> This patch disables renames just for the internal patch-id
> comparison run by "log --cherry-pick", etc. The user-visible
> "git patch-id" output depends on the patch that it is fed
> (so it is up to the diff generator to use --no-renames if
> they wish).

Sounds obviously good to me.

Ciao,
Dscho
