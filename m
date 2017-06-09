Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01C821FAEB
	for <e@80x24.org>; Fri,  9 Jun 2017 05:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751507AbdFIFVY (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 01:21:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:36936 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751479AbdFIFVY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 01:21:24 -0400
Received: (qmail 32755 invoked by uid 109); 9 Jun 2017 05:21:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 09 Jun 2017 05:21:24 +0000
Received: (qmail 18733 invoked by uid 111); 9 Jun 2017 05:21:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 09 Jun 2017 01:21:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Jun 2017 01:21:21 -0400
Date:   Fri, 9 Jun 2017 01:21:21 -0400
From:   Jeff King <peff@peff.net>
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Clarifying behavior of diff --stat
Message-ID: <20170609052121.f5fudcq6yz5d3r56@sigill.intra.peff.net>
References: <CAJZjrdUHm2JAGsjurcGxONQomAtvV_GMgzqb0pPEovHSySd=KA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZjrdUHm2JAGsjurcGxONQomAtvV_GMgzqb0pPEovHSySd=KA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 08, 2017 at 07:10:00AM -0400, Samuel Lijin wrote:

> I noticed when answering a StackOverflow question that apparently
> --stat modifies the raw diff itself, instead of just adding a diffstat
> to the output. In the linux kernel:

Sort of. Using "--stat" implies "-r", since it only deals with the
actual blobs and would have nothing to show for tree entries.

And since recursive-ness is global to the whole diff, not just one
output format, the --raw output becomes recursive, too.

> Is this intentional? And is there a way to generate a raw version of
> the extended stat without using --stat?

Try "git diff-tree --raw -r".

-Peff
