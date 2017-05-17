Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B54762023D
	for <e@80x24.org>; Wed, 17 May 2017 02:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752669AbdEQCDs (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 22:03:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:53123 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751957AbdEQCDj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 22:03:39 -0400
Received: (qmail 24485 invoked by uid 109); 17 May 2017 02:03:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 May 2017 02:03:36 +0000
Received: (qmail 2492 invoked by uid 111); 17 May 2017 02:04:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 May 2017 22:04:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 May 2017 22:03:34 -0400
Date:   Tue, 16 May 2017 22:03:34 -0400
From:   Jeff King <peff@peff.net>
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git-scm.com status report
Message-ID: <20170517020334.ncp3c6meak4mkp2j@sigill.intra.peff.net>
References: <20170202023349.7fopb3a6pc6dkcmd@sigill.intra.peff.net>
 <20170206182754.qxgzl7546i7u5wnw@sigill.intra.peff.net>
 <CAJZjrdXCYwbH4wtY44UiEQii+r47a-coTwLd0qYzhV3VZwyd1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZjrdXCYwbH4wtY44UiEQii+r47a-coTwLd0qYzhV3VZwyd1A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 16, 2017 at 09:56:37PM -0400, Samuel Lijin wrote:

> So I've finally found the time to get everything set up (in the
> process discovering that remote_genbook2 consistently induces a
> segfault in VirtualBox's networking driver, impressively enough) and
> am taking a look at how much work it would take to get the site
> running on AWS EC2/DO or some other hosting provider.
> 
> Some things I'm wondering about:
> 
> - You mentioned a lot of people reaching out off-list about hosting
> options. Do any of them look particularly appealing at the moment?

Yes. I actually have stuff to announce there soon, but was holding off
until the final pieces are in place. But basically, the architecture
would remain largely the same, but hosted on community-owned accounts
(that I can share access to), with sponsorship from various hosting
services.

> - How do I set up the ES service?

I haven't ever tried to do this in the local development environment.
The production site currently just use a cloud-hosted ES (Bonsai). They
have free "Sandbox" plans for testing, so you could probably use that as
a test resource after setting up the relevant environment variables. Or
alternatively, I think ElasticSearch folks produce binary builds you can
try, and you could host locally.

There's a rake job that inserts documents into the search index (see
lib/tasks/search.rake).

-Peff
