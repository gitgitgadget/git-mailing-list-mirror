Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2B6120954
	for <e@80x24.org>; Fri,  8 Dec 2017 05:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751212AbdLHFQj (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 00:16:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:51782 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751195AbdLHFQi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 00:16:38 -0500
Received: (qmail 19650 invoked by uid 109); 8 Dec 2017 05:16:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Dec 2017 05:16:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29441 invoked by uid 111); 8 Dec 2017 05:16:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Fri, 08 Dec 2017 00:16:59 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Dec 2017 00:16:36 -0500
Date:   Fri, 8 Dec 2017 00:16:36 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] docs/pretty-formats: mention commas in %(trailers) syntax
Message-ID: <20171208051636.GA24693@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 84ff053d47 (pretty.c: delimit "%(trailers)" arguments
with ",", 2017-10-01) switched the syntax of the trailers
placeholder, but forgot to update the documentation in
pretty-formats.txt.

There's need to mention the old syntax; it was never in a
released version of Git.

Signed-off-by: Jeff King <peff@peff.net>
---
This should go on top of tb/delimit-pretty-trailers-args-with-comma.

 Documentation/pretty-formats.txt | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index d433d50f81..e664c088a5 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -204,11 +204,13 @@ endif::git-rev-list[]
   than given and there are spaces on its left, use those spaces
 - '%><(<N>)', '%><|(<N>)': similar to '% <(<N>)', '%<|(<N>)'
   respectively, but padding both sides (i.e. the text is centered)
-- %(trailers): display the trailers of the body as interpreted by
-  linkgit:git-interpret-trailers[1]. If the `:only` option is given,
-  omit non-trailer lines from the trailer block.  If the `:unfold`
-  option is given, behave as if interpret-trailer's `--unfold` option
-  was given. E.g., `%(trailers:only:unfold)` to do both.
+- %(trailers[:options]): display the trailers of the body as interpreted
+  by linkgit:git-interpret-trailers[1]. The `trailers` string may be
+  followed by a colon and zero or more comma-separated options. If the
+  `only` option is given, omit non-trailer lines from the trailer block.
+  If the `unfold` option is given, behave as if interpret-trailer's
+  `--unfold` option was given.  E.g., `%(trailers:only,unfold)` to do
+  both.
 
 NOTE: Some placeholders may depend on other options given to the
 revision traversal engine. For example, the `%g*` reflog options will
-- 
2.15.1.659.g8bd2eae3ea
