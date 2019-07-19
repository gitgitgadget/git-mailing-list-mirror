Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65D251F461
	for <e@80x24.org>; Fri, 19 Jul 2019 21:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfGSVyT (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jul 2019 17:54:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:40650 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727344AbfGSVyT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jul 2019 17:54:19 -0400
Received: (qmail 8654 invoked by uid 109); 19 Jul 2019 21:54:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 19 Jul 2019 21:54:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29136 invoked by uid 111); 19 Jul 2019 21:55:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 19 Jul 2019 17:55:16 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Jul 2019 17:54:17 -0400
Date:   Fri, 19 Jul 2019 17:54:17 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: jk/test-commit-bulk, was: What's cooking in git.git (Jul 2019, #05;
 Fri, 19)
Message-ID: <20190719215417.GA31841@sigill.intra.peff.net>
References: <xmqqef2lvkg5.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqef2lvkg5.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 19, 2019 at 01:27:38PM -0700, Junio C Hamano wrote:

> * jk/test-commit-bulk (2019-07-02) 7 commits
>  - SQUASH???
>  - t6200: use test_commit_bulk
>  - t5703: use test_commit_bulk
>  - t5702: use test_commit_bulk
>  - t3311: use test_commit_bulk
>  - t5310: increase the number of bitmapped commits
>  - test-lib: introduce test_commit_bulk
> 
>  A test helper has been introduced to optimize preparation of test
>  repositories with many simple commits, and a handful of test
>  scripts have been updated to use it.
> 
>  Needs a bit more polishing.
>  I think I spotted one unused command, which we may want to remove, though.

I think these comments are out-of-date. The unused command was fixed up
in v2 of the first patch, and then I did a little extra polishing in v3:

  https://public-inbox.org/git/20190702051649.GA16344@sigill.intra.peff.net/

Together with your SQUASH fixup, I think that covers all comments. For
convenience, here's v3 again as a whole series which can replace what
you have already (including the squash).

  [1/6]: test-lib: introduce test_commit_bulk
  [2/6]: t5310: increase the number of bitmapped commits
  [3/6]: t3311: use test_commit_bulk
  [4/6]: t5702: use test_commit_bulk
  [5/6]: t5703: use test_commit_bulk
  [6/6]: t6200: use test_commit_bulk

 t/t3311-notes-merge-fanout.sh      |  10 +--
 t/t5310-pack-bitmaps.sh            |  15 +---
 t/t5702-protocol-v2.sh             |  10 +--
 t/t5703-upload-pack-ref-in-want.sh |   4 +-
 t/t6200-fmt-merge-msg.sh           |   7 +-
 t/test-lib-functions.sh            | 123 +++++++++++++++++++++++++++++
 6 files changed, 136 insertions(+), 33 deletions(-)

-Peff
