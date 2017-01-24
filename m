Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92E6420A17
	for <e@80x24.org>; Tue, 24 Jan 2017 02:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751355AbdAXCMX (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 21:12:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:43615 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750710AbdAXCMX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 21:12:23 -0500
Received: (qmail 15717 invoked by uid 109); 24 Jan 2017 02:12:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Jan 2017 02:12:22 +0000
Received: (qmail 29219 invoked by uid 111); 24 Jan 2017 02:13:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 23 Jan 2017 21:13:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Jan 2017 21:12:20 -0500
Date:   Mon, 23 Jan 2017 21:12:20 -0500
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/12] reducing resource usage of for_each_alternate_ref
Message-ID: <20170124021220.6xgdcfa4a3punlt4@sigill.intra.peff.net>
References: <20170124003729.j4ygjcgypdq7hceg@sigill.intra.peff.net>
 <20170124013341.GA185930@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170124013341.GA185930@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 23, 2017 at 05:33:41PM -0800, Brandon Williams wrote:

> On 01/23, Jeff King wrote:
> > 
> > A brief overview of the patches:
> > 
> >   [01/12]: for_each_alternate_ref: handle failure from real_pathdup()
> >   [02/12]: for_each_alternate_ref: stop trimming trailing slashes
> >   [03/12]: for_each_alternate_ref: use strbuf for path allocation
> > 
> >     Bugfixes and cleanups (the first one is actually a recent-ish
> >     regression).
> 
> Which is most likely my fault, Sorry! :)
> 
> I think the old behavior was to die and not return NULL.

Yes, it is. :)

But I think it's probably pretty hard to trigger in practice. And on the
plus side, I think the new behavior after my patch is much more sensible
than even the original.

-Peff
