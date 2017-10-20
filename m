Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74A6F202A2
	for <e@80x24.org>; Fri, 20 Oct 2017 22:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752619AbdJTWhM (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 18:37:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:59474 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752469AbdJTWhL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 18:37:11 -0400
Received: (qmail 26390 invoked by uid 109); 20 Oct 2017 22:37:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 20 Oct 2017 22:37:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20700 invoked by uid 111); 20 Oct 2017 22:37:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 20 Oct 2017 18:37:16 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Oct 2017 18:37:09 -0400
Date:   Fri, 20 Oct 2017 18:37:09 -0400
From:   Jeff King <peff@peff.net>
To:     Simon Ruderich <simon@ruderich.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        orgads@gmail.com
Subject: Re: [PATCH 4/5] diff: fix whitespace-skipping with --color-moved
Message-ID: <20171020223709.tlixfgqtr3bzwicw@sigill.intra.peff.net>
References: <20171019202326.grovyfsragl2d7xx@sigill.intra.peff.net>
 <20171019202926.irldca42wqosmxrd@sigill.intra.peff.net>
 <20171020072354.seqloliweseotuos@ruderich.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171020072354.seqloliweseotuos@ruderich.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 20, 2017 at 09:23:54AM +0200, Simon Ruderich wrote:

> On Thu, Oct 19, 2017 at 04:29:26PM -0400, Jeff King wrote:
> > [snip]
> >
> > --- a/t/t4015-diff-whitespace.sh
> > +++ b/t/t4015-diff-whitespace.sh
> > @@ -1463,6 +1463,73 @@ test_expect_success 'move detection ignoring whitespace changes' '
> >  	test_cmp expected actual
> >  '
> >
> > +test_expect_failure 'move detection ignoring whitespace at eol' '
> 
> Shouldn't this be test_expect_success? According to the commit
> message "and a new "--ignore-space-at-eol" shows off the breakage
> we're fixing.". I didn't actually run the code so I don't know if
> the test fails or not.

Thanks, good catch. I had originally added all the tests in a single
commit, with the intent of flipping this failure to success. But when I
shifted it to just get added here, I accidentally lost that flip.

-Peff
