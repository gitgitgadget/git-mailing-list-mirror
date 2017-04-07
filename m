Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9CA9209F2
	for <e@80x24.org>; Fri,  7 Apr 2017 04:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751784AbdDGEaC (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 00:30:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:57867 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751149AbdDGEaC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 00:30:02 -0400
Received: (qmail 20529 invoked by uid 109); 7 Apr 2017 04:29:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 07 Apr 2017 04:29:59 +0000
Received: (qmail 31845 invoked by uid 111); 7 Apr 2017 04:30:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 07 Apr 2017 00:30:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Apr 2017 00:29:56 -0400
Date:   Fri, 7 Apr 2017 00:29:56 -0400
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v1 2/2] p0005-status: time status on very large repo
Message-ID: <20170407042955.i63i6prc3rwi4i6s@sigill.intra.peff.net>
References: <20170405195600.54801-1-git@jeffhostetler.com>
 <20170405195600.54801-3-git@jeffhostetler.com>
 <20170405213355.GH8741@aiede.mtv.corp.google.com>
 <db545f25-b0a7-2359-e6f5-7a89860c4022@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <db545f25-b0a7-2359-e6f5-7a89860c4022@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 06, 2017 at 09:26:15AM -0400, Jeff Hostetler wrote:

> > > +export depth
> > > +export width
> > > +export files
> > 
> > Why are these exported?  test_expect_success code (unlike test_per
> > code) runs in the same shell as outside, so it doesn't seem necessary.
> 
> I'm still trying to grok all of the shell wizardry hidden
> in the test_* functions, so some may be novice mistakes here.
> However, I couldn't get some of the steps to run in an earlier
> draft of it without them.  But I copied this from p0004-read-tree
> that I posted in an earlier patch and this version is much simpler
> so they may not be necessary here.  I'll double check.

It's a subtle but annoying difference between the regular tests and the
perf tests. test_perf() runs in a subshell because of the way the timing
is implemented. There are a few pointers in t/perf/README regarding
this.

-Peff
