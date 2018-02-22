Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85AA81F404
	for <e@80x24.org>; Thu, 22 Feb 2018 18:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933542AbeBVSOD (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 13:14:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:32818 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S933441AbeBVSOC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 13:14:02 -0500
Received: (qmail 24653 invoked by uid 109); 22 Feb 2018 18:14:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 22 Feb 2018 18:14:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4888 invoked by uid 111); 22 Feb 2018 18:14:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 22 Feb 2018 13:14:49 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Feb 2018 13:14:00 -0500
Date:   Thu, 22 Feb 2018 13:14:00 -0500
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        sbeller@google.com, gitster@pobox.com, jrnieder@gmail.com,
        stolee@gmail.com, git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 04/35] upload-pack: convert to a builtin
Message-ID: <20180222181400.GA19035@sigill.intra.peff.net>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-5-bmwill@google.com>
 <20180221134422.2386e1aca39fe673235590e7@google.com>
 <20180222095833.GC12442@sigill.intra.peff.net>
 <20180222180715.GB185096@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180222180715.GB185096@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 22, 2018 at 10:07:15AM -0800, Brandon Williams wrote:

> On 02/22, Jeff King wrote:
> > On Wed, Feb 21, 2018 at 01:44:22PM -0800, Jonathan Tan wrote:
> > 
> > > On Tue,  6 Feb 2018 17:12:41 -0800
> > > Brandon Williams <bmwill@google.com> wrote:
> > > 
> > > > In order to allow for code sharing with the server-side of fetch in
> > > > protocol-v2 convert upload-pack to be a builtin.
> > > > 
> > > > Signed-off-by: Brandon Williams <bmwill@google.com>
> > > 
> > > As Stefan mentioned in [1], also mention in the commit message that this
> > > means that the "git-upload-pack" invocation gains additional
> > > capabilities (for example, invoking a pager for --help).
> > 
> > And possibly respecting pager.upload-pack, which would violate our rule
> > that it is safe to run upload-pack in untrusted repositories.
> 
> And this isn't an issue with receive-pack because this same guarantee
> doesn't exist?

Yes, exactly (which is confusing and weird, yes, but that's how it is).

-Peff
