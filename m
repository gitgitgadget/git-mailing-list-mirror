Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B640720401
	for <e@80x24.org>; Tue, 13 Jun 2017 00:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753118AbdFMA50 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 20:57:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:38691 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752508AbdFMA50 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 20:57:26 -0400
Received: (qmail 18792 invoked by uid 109); 13 Jun 2017 00:57:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Jun 2017 00:57:26 +0000
Received: (qmail 18545 invoked by uid 111); 13 Jun 2017 00:57:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Jun 2017 20:57:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Jun 2017 20:57:24 -0400
Date:   Mon, 12 Jun 2017 20:57:24 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        gitster@pobox.com, Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH 2/4] config: remove git_config_iter
Message-ID: <20170613005723.fd54nx7fazclutlz@sigill.intra.peff.net>
References: <20170612213406.83247-1-bmwill@google.com>
 <20170612213406.83247-3-bmwill@google.com>
 <20170613004911.GA133952@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170613004911.GA133952@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 12, 2017 at 05:49:11PM -0700, Jonathan Nieder wrote:

> > Since there is no implementation of the function 'git_config_iter' lets
> > stop exporting it and remove the prototype from config.h.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >  config.h | 1 -
> >  1 file changed, 1 deletion(-)
> 
> Good eyes.  Looks like the function never existed.

You can find mention of it on the list[1,2] in early versions of Tanay's
patches. I think it was originally intended to be a variant of
git_config() that used the cache. But in the end, we made git_config()
do that by default (and added git_config_raw as its underlying helper).

I just looked that up to satisfy my curiosity. You are right that its
implementation never actually got committed, and clearly removing the
declaration is the right thing.

-Peff

[1] http://public-inbox.org/git/1404280905-26763-2-git-send-email-tanayabh@gmail.com/

[2] http://public-inbox.org/git/xmqqd2dnitm7.fsf@gitster.dls.corp.google.com/
