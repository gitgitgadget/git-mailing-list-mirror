Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 416351F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 20:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753356AbcIIUeL (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 16:34:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:40999 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751917AbcIIUeK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 16:34:10 -0400
Received: (qmail 5970 invoked by uid 109); 9 Sep 2016 20:34:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 09 Sep 2016 20:34:10 +0000
Received: (qmail 28163 invoked by uid 111); 9 Sep 2016 20:34:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 09 Sep 2016 16:34:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Sep 2016 16:34:06 -0400
Date:   Fri, 9 Sep 2016 16:34:06 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Kevin Willford <kewillf@microsoft.com>,
        Xiaolong Ye <xiaolong.ye@intel.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH v3 0/2] patch-id for merges
Message-ID: <20160909203406.5j5pmom442yoe4su@sigill.intra.peff.net>
References: <20160907075346.z6wtmqnfc6bsunjb@sigill.intra.peff.net>
 <20160907220101.hwwutkiagfottbdd@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160907220101.hwwutkiagfottbdd@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 07, 2016 at 06:01:01PM -0400, Jeff King wrote:

> Here's a re-roll of the series I posted at:
> 
>   http://public-inbox.org/git/20160907075346.z6wtmqnfc6bsunjb@sigill.intra.peff.net/
> 
> Basically, it drops the time for "format-patch --cherry-pick" on a
> particular case from 3 minutes down to 3 seconds, by avoiding diffs
> on merge commits. Compared to v1, it fixes the totally-broken handling
> of commit_patch_id() pointed out by Johannes.
>
>   [1/3]: patch-ids: turn off rename detection
>   [2/3]: diff_flush_patch_id: stop returning error result
>   [3/3]: patch-ids: use commit sha1 as patch-id for merge commits

And here is v3. Besides commit-message fixups, it drops patch 2, and
instead the third patch teaches commit_patch_id() to distinguish between
errors and "no patch id".

Frankly, I still like v2 better, but I do not feel like arguing with
Johannes about it anymore.

  [1/2]: patch-ids: turn off rename detection
  [2/2]: patch-ids: define patch-id of merge commits as "null"

-Peff
