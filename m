Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9AAD207DF
	for <e@80x24.org>; Sat, 10 Sep 2016 06:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753113AbcIJGAS (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Sep 2016 02:00:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:41166 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751464AbcIJGAR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Sep 2016 02:00:17 -0400
Received: (qmail 7507 invoked by uid 109); 10 Sep 2016 06:00:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Sep 2016 06:00:17 +0000
Received: (qmail 31028 invoked by uid 111); 10 Sep 2016 06:00:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Sep 2016 02:00:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Sep 2016 02:00:13 -0400
Date:   Sat, 10 Sep 2016 02:00:13 -0400
From:   Jeff King <peff@peff.net>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        jrnieder@gmail.com, spearce@spearce.org, sbeller@google.com,
        gitster@pobox.com
Subject: Re: [PATCH v4 1/3] tests: move test_lazy_prereq JGIT to test-lib.sh
Message-ID: <20160910060012.rsnpgvk3mag4be5j@sigill.intra.peff.net>
References: <cover.1472836026.git.jonathantanmy@google.com>
 <cover.1473441620.git.jonathantanmy@google.com>
 <37c4e775948b88b2d5af1caee3a70e36f00bc88a.1473441620.git.jonathantanmy@google.com>
 <20160910055119.GA11001@tb-raspi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160910055119.GA11001@tb-raspi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 10, 2016 at 05:51:19AM +0000, Torsten Bögershausen wrote:

> > +test_lazy_prereq JGIT '
> > +	type jgit
> > +'
> > +
> 
> Minor note: 
> Typically the stdout of `which` is suppressed like this:
> 
> if ! type cvs >/dev/null 2>&1

But we don't want to suppress the output here; the test harness
redirects the lazy_prereq output to /dev/null unless you specify "-v".
And there is no need for "if", because what we care about is the exit
code of the commands inside the lazy_prereq.

-Peff

