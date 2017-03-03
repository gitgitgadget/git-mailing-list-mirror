Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35D752023D
	for <e@80x24.org>; Fri,  3 Mar 2017 11:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751737AbdCCLyh (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 06:54:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:37962 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751278AbdCCLyf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 06:54:35 -0500
Received: (qmail 1048 invoked by uid 109); 3 Mar 2017 11:26:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 11:26:12 +0000
Received: (qmail 27369 invoked by uid 111); 3 Mar 2017 11:26:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 06:26:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Mar 2017 06:26:10 -0500
Date:   Fri, 3 Mar 2017 06:26:10 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 2/9] setup_git_directory(): use is_dir_sep() helper
Message-ID: <20170303112610.x6mdh42nd4hmxz2h@sigill.intra.peff.net>
References: <cover.1481211338.git.johannes.schindelin@gmx.de>
 <cover.1488506615.git.johannes.schindelin@gmx.de>
 <d1342d28fd402615f1f94d9190559070ed04b0d7.1488506615.git.johannes.schindelin@gmx.de>
 <20170303033714.5h7qrq57hdqwoi3y@sigill.intra.peff.net>
 <alpine.DEB.2.20.1703031212280.3767@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1703031212280.3767@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 03, 2017 at 12:16:31PM +0100, Johannes Schindelin wrote:

> > What is "dir"? I'm guessing this patch got reordered and it should stay
> > as cwd.buf?
> 
> Oh drats. Usually I do a final `git rebase -x "make test" upstream/master`
> run before submitting, but I was really, really tired by the end of that
> stretch.

I usually do the same, and have done the "too tired" thing, too, only to
have it bite me. That's why I so readily recognized the problem. :)

I've recently switched to using Michael's "git test" program[1], which
caches the test results for each tree in a git-note. That makes the
final "rebase -x" a lot less painful if you've left the early commits
alone.

The python dependency might be a blocker for you, but I suspect the
caching parts would be easy to hack together with shell.

-Peff

[1] https://github.com/mhagger/git-test
