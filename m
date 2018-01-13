Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5364E1FADF
	for <e@80x24.org>; Sat, 13 Jan 2018 10:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933657AbeAMKyK (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Jan 2018 05:54:10 -0500
Received: from cloud.peff.net ([104.130.231.41]:43070 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S933432AbeAMKyJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jan 2018 05:54:09 -0500
Received: (qmail 31319 invoked by uid 109); 13 Jan 2018 10:54:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 13 Jan 2018 10:54:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5978 invoked by uid 111); 13 Jan 2018 10:54:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 13 Jan 2018 05:54:43 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Jan 2018 05:54:07 -0500
Date:   Sat, 13 Jan 2018 05:54:07 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] travis-ci: build Git during the 'script' phase
Message-ID: <20180113105407.GA31825@sigill.intra.peff.net>
References: <20180108172214.23615-1-szeder.dev@gmail.com>
 <xmqqvagc6m42.fsf@gitster.mtv.corp.google.com>
 <5DE3FA05-2347-4BE7-8A1A-A6E5FEEC7C2B@gmail.com>
 <CAM0VKjnSzoc+E408ifKCg+qPTaGRNL3e3JVdRN573kdcBSzbHw@mail.gmail.com>
 <20180113103255.GA31117@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180113103255.GA31117@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 13, 2018 at 05:32:56AM -0500, Jeff King wrote:

> According to:
> 
>   https://blog.travis-ci.com/2013-05-22-improving-build-visibility-log-folds
> 
> they auto-fold individual commands _except_ the ones in the script
> section. Is there a way to manually mark folds in the output?
> 
> Hmph. I could not find an answer from travis, but googling seems to turn
> up that something like this would work:
> [...]
> I've queued a CI job to see if this actually works. :)

Indeed it does work:

  https://travis-ci.org/peff/git/jobs/328418291

The rest of the crufty output looks like "set -x" stuff. It might be
worth being less aggressive there.

I think there's also a similar feature to include timings for each fold,
which might be worth pursuing.

-Peff
