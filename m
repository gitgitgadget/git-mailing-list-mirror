Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7055A1F97E
	for <e@80x24.org>; Fri,  5 Oct 2018 16:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbeJEX6h (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 19:58:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:43304 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728770AbeJEX6h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 19:58:37 -0400
Received: (qmail 19666 invoked by uid 109); 5 Oct 2018 16:59:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 05 Oct 2018 16:59:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13190 invoked by uid 111); 5 Oct 2018 16:58:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 05 Oct 2018 12:58:19 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Oct 2018 12:59:01 -0400
Date:   Fri, 5 Oct 2018 12:59:01 -0400
From:   Jeff King <peff@peff.net>
To:     "Keller, Jacob E" <jacob.e.keller@intel.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v3] coccicheck: process every source file at once
Message-ID: <20181005165901.GE11254@sigill.intra.peff.net>
References: <20181002200710.15721-1-jacob.e.keller@intel.com>
 <CA+P7+xoqKG84n5EMKbajuZoXrOKZMudZ6CT-OKzz8XYyTYaCWQ@mail.gmail.com>
 <CA+P7+xo=cY2nSHk99CETvba-nZ_jOan5YgpDUjaD=cpTs2ub3A@mail.gmail.com>
 <20181005124048.GT23446@localhost>
 <20181005162517.GB11254@sigill.intra.peff.net>
 <02874ECE860811409154E81DA85FBB5884CCBED2@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <02874ECE860811409154E81DA85FBB5884CCBED2@ORSMSX115.amr.corp.intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 05, 2018 at 04:53:35PM +0000, Keller, Jacob E wrote:

> > Are we OK with saying 1.3-1.8GB is necessary to run coccicheck? That
> > doesn't feel like an exorbitant request for a developer-only tool these
> > days, but I have noticed some people on the list tend to have lousier
> > machines than I do. ;)
> > 
> > -Peff
> 
> It's probably not worth trying to make this more complicated and scale
> up how many files we do at once based on the amount of available
> memory on the system...

Yeah, that sounds too complicated. At most I'd give a Makefile knob to
say "spatch in batches of $(N)". But I'd prefer to avoid even that
complexity if we can.

-Peff
