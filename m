Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47FD91F461
	for <e@80x24.org>; Tue, 14 May 2019 12:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfENMCX (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 08:02:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:56808 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725893AbfENMCW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 08:02:22 -0400
Received: (qmail 4183 invoked by uid 109); 14 May 2019 12:02:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 May 2019 12:02:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12222 invoked by uid 111); 14 May 2019 12:03:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 14 May 2019 08:03:01 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 May 2019 08:02:20 -0400
Date:   Tue, 14 May 2019 08:02:20 -0400
From:   Jeff King <peff@peff.net>
To:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
Cc:     git@vger.kernel.org
Subject: [PATCH 0/2] some fixes for help_unknown_ref()
Message-ID: <20190514120220.GA7714@sigill.intra.peff.net>
References: <5CDA9063020000A10003131D@gwsmtp.uni-regensburg.de>
 <20190514112115.GA26957@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190514112115.GA26957@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 14, 2019 at 07:21:15AM -0400, Jeff King wrote:

> But I agree we could be more helpful in the messages.
> 
> The "did you mean?" advice just blindly says "oh, you asked for X and
> refs/remotes/ABC/X exists, so let's suggest ABC/X", without checking for
> ambiguities. It should probably do this:

Here's a patch series to do that.

> I also think the "warning: refname ... is ambiguous" message would
> probably be a bit more helpful if it showed _which_ candidates it found
> (and which one it chose!).

This series doesn't do anything for this problem, which I think is a bit
more involved. I'm not planning to work on it immediately, if somebody
else wants to pick it up (and I see Duy already has a response :) ).

  [1/2]: help_unknown_ref(): duplicate collected refnames
  [2/2]: help_unknown_ref(): check for refname ambiguity

 help.c           |  8 ++++----
 t/t7600-merge.sh | 20 ++++++++++++++++++++
 2 files changed, 24 insertions(+), 4 deletions(-)

-Peff
