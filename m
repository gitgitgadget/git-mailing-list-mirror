Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19D5A1F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 19:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932866AbeGITqj (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 15:46:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:52492 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932764AbeGITqi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 15:46:38 -0400
Received: (qmail 2027 invoked by uid 109); 9 Jul 2018 19:46:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 09 Jul 2018 19:46:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15128 invoked by uid 111); 9 Jul 2018 19:46:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 09 Jul 2018 15:46:39 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Jul 2018 15:46:36 -0400
Date:   Mon, 9 Jul 2018 15:46:36 -0400
From:   Jeff King <peff@peff.net>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/2] de-confuse git cherry-pick --author behavior
Message-ID: <20180709194636.GB9852@sigill.intra.peff.net>
References: <33d3e45b-1245-9e2f-42ea-a654a593bf10@gmail.com>
 <20180709191607.GA9852@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180709191607.GA9852@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 09, 2018 at 03:16:07PM -0400, Jeff King wrote:

> I agree that having something similar to commit's "--author" (or even
> just "--reset-author") would be useful. When I've had to do this before,
> I usually just cherry-pick and then follow-up with "commit --amend
> --author" (or use "rebase -i" if there are several commits). You can
> also do "cherry-pick -n $commit" followed by "commit -c $commit".

I'll leave adding any options there as an exercise if somebody is
interested. This series just focuses on the inconsistent error behavior
you found.

  [1/2]: sequencer: handle empty-set cases consistently
  [2/2]: sequencer: don't say BUG on bogus input

 sequencer.c                     | 8 +++++---
 t/t3510-cherry-pick-sequence.sh | 7 ++++++-
 2 files changed, 11 insertions(+), 4 deletions(-)

-Peff
