Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA5D6203E4
	for <e@80x24.org>; Fri, 22 Jul 2016 19:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752928AbcGVTvq (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 15:51:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:48823 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752878AbcGVTvo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 15:51:44 -0400
Received: (qmail 22234 invoked by uid 102); 22 Jul 2016 19:51:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Jul 2016 15:51:44 -0400
Received: (qmail 9320 invoked by uid 107); 22 Jul 2016 19:52:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Jul 2016 15:52:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Jul 2016 15:51:41 -0400
Date:	Fri, 22 Jul 2016 15:51:41 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Cc:	Theodore Ts'o <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/6] doc/pretty-formats: explain shortening of %gd
Message-ID: <20160722195140.GD19648@sigill.intra.peff.net>
References: <20160722195105.GA19542@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160722195105.GA19542@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The actual shortening rules aren't that interesting and
probably not worth getting into (I gloss over them here as
"shortened for human readability"). But the fact that %gD
shows whatever you gave on the command line is subtle and
worth mentioning. Since most people will feed a shortened
refname in the first place, it otherwise makes it hard to
understand the difference between the two.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/pretty-formats.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 36a300a..b95d67e 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -149,9 +149,12 @@ endif::git-rev-list[]
 - '%GK': show the key used to sign a signed commit
 - '%gD': reflog selector, e.g., `refs/stash@{1}` or
   `refs/stash@{2 minutes ago`}; the format follows the rules described
-  for the `-g` option
-- '%gd': shortened reflog selector, e.g., `stash@{1}` or
-  `stash@{2 minutes ago}`
+  for the `-g` option. The portion before the `@` is the refname as
+  given on the command line (so `git log -g refs/heads/master` would
+  yield `refs/heads/master@{0}`).
+- '%gd': shortened reflog selector; same as `%gD`, but the refname
+  portion is shortened for human readability (so `refs/heads/master`
+  becomes just `master`).
 - '%gn': reflog identity name
 - '%gN': reflog identity name (respecting .mailmap, see
   linkgit:git-shortlog[1] or linkgit:git-blame[1])
-- 
2.9.2.512.gc1ef750

