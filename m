Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51EFF1F461
	for <e@80x24.org>; Mon, 26 Aug 2019 20:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfHZUvn (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 16:51:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:56466 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726345AbfHZUvn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 16:51:43 -0400
Received: (qmail 8769 invoked by uid 109); 26 Aug 2019 20:51:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 26 Aug 2019 20:51:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24113 invoked by uid 111); 26 Aug 2019 20:53:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 26 Aug 2019 16:53:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 26 Aug 2019 16:51:42 -0400
From:   Jeff King <peff@peff.net>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     git@vger.kernel.org
Subject: Re: Missing file in 2.23 (p5302-pack-index.subtests)?
Message-ID: <20190826205142.GC27762@sigill.intra.peff.net>
References: <20190818160317.GA13772@mit.edu>
 <20190826205012.GB27762@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190826205012.GB27762@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 26, 2019 at 04:50:13PM -0400, Jeff King wrote:

> On Sun, Aug 18, 2019 at 12:03:17PM -0400, Theodore Y. Ts'o wrote:
> 
> > I was trying to run "make profile" on the master branch (commit
> > 5fa0f5238b: "Git 2.23") and it died in the
> > 
> > 	$(MAKE) PROFILE=GEN perf
> > 
> > dies with:
> > 
> > 	cannot open test-results/p5302-pack-index.subtests: No such file or directory at ./aggregate.perl line 153.
> > 
> > I presume that's becuase the file t/perf/test-results/p5302-pack-index.subtests is missing?
> 
> That file should be created by running p5302. If you do:

By the way, I tried "make perf" as you specified above, and it worked
fine for me. And I don't think there are any changes in v2.23 that
should touch this area. But certainly it would be interesting to know if
it fails consistently for you, and if so, whether older versions work
(so we can bisect).

-Peff
