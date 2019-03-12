Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAAF520248
	for <e@80x24.org>; Tue, 12 Mar 2019 21:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfCLVeE (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 17:34:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:47862 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726141AbfCLVeE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 17:34:04 -0400
Received: (qmail 3179 invoked by uid 109); 12 Mar 2019 21:34:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 12 Mar 2019 21:34:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4224 invoked by uid 111); 12 Mar 2019 21:33:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 12 Mar 2019 17:33:07 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Mar 2019 17:32:46 -0400
Date:   Tue, 12 Mar 2019 17:32:46 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Roberto Tyley <roberto.tyley@gmail.com>
Subject: [RFC/PATCH] point pull requesters to Git Git Gadget
Message-ID: <20190312213246.GA6252@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the contributing guide and PR template seen by people who open pull
requests on GitHub, we mention the submitGit tool, which gives an
alternative to figuring out the mailing list. These days we also have
the similar Git Git Gadget tool, and we should make it clear that this
is also an option.

We could continue to mention _both_ tools, but it's probably better to
pick one in order to avoid overwhelming the user with choice. After all,
one of the purposes here is to reduce friction for first-time or
infrequent contributors. And there are a few reasons to prefer GGG:

  1. submitGit seems to still have a few rough edges. E.g., it doesn't
     munge timestamps to help threaded mail readers handled out-of-order
     delivery.

  2. Subjectively, GGG seems to be more commonly used on the list these
     days, especially by list regulars.

  3. GGG seems to be under more active development (likely related to
     point 2).

So let's actually swap out submitGit for GGG. While we're there, let's
put another link to the GGG page in the PR template, because that's
where users who are learning about it for the first time will want to go
to read more.

Signed-off-by: Jeff King <peff@peff.net>
---
I feel a little bad sending this, because I really value the work that
Roberto has done on submitGit. So just dropping it feels a bit
dismissive. But for the reasons above, it seems like GGG is going to be
the path forward, and it doesn't really make much sense to have two
competing systems unless they have really different feature-sets or
approaches (which I don't think is the case).

So I thought I'd mark this RFC and see what people thought. :)

One thing that I think submitGit can do that GGG cannot (yet), is just
take PRs straight on git/git. If we're going to start recommending it,
then I think we'd probably want to configure that, since it's one less
confusing step for first-timers, who right now might have to go re-make
their PR on gitgitgadget/git.

 .github/CONTRIBUTING.md          | 2 +-
 .github/PULL_REQUEST_TEMPLATE.md | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/.github/CONTRIBUTING.md b/.github/CONTRIBUTING.md
index 64e605a02b..7e6df9e429 100644
--- a/.github/CONTRIBUTING.md
+++ b/.github/CONTRIBUTING.md
@@ -5,7 +5,7 @@ Git community does not use github.com for their contributions. Instead, we use
 a mailing list (git@vger.kernel.org) for code submissions, code
 reviews, and bug reports.
 
-Nevertheless, you can use [submitGit](http://submitgit.herokuapp.com/) to
+Nevertheless, you can use [Git Git Gadget](https://gitgitgadget.github.io/) to
 conveniently send your Pull Requests commits to our mailing list.
 
 Please read ["A note from the maintainer"](https://git.kernel.org/pub/scm/git/git.git/plain/MaintNotes?h=todo)
diff --git a/.github/PULL_REQUEST_TEMPLATE.md b/.github/PULL_REQUEST_TEMPLATE.md
index adba13e5ba..85911a44e2 100644
--- a/.github/PULL_REQUEST_TEMPLATE.md
+++ b/.github/PULL_REQUEST_TEMPLATE.md
@@ -1,7 +1,7 @@
 Thanks for taking the time to contribute to Git! Please be advised that the
 Git community does not use github.com for their contributions. Instead, we use
 a mailing list (git@vger.kernel.org) for code submissions, code reviews, and
-bug reports. Nevertheless, you can use submitGit to conveniently send your Pull
-Requests commits to our mailing list.
+bug reports. Nevertheless, you can use Git Git Gadget (https://gitgitgadget.github.io/)
+to conveniently send your Pull Requests commits to our mailing list.
 
 Please read the "guidelines for contributing" linked above!
-- 
2.21.0.539.gcf54785f87
