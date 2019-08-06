Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E889F1F731
	for <e@80x24.org>; Tue,  6 Aug 2019 14:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732981AbfHFOkc (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 10:40:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:35410 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729535AbfHFOkc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 10:40:32 -0400
Received: (qmail 17901 invoked by uid 109); 6 Aug 2019 14:40:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 06 Aug 2019 14:40:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2425 invoked by uid 111); 6 Aug 2019 14:42:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 06 Aug 2019 10:42:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 6 Aug 2019 10:40:30 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 3/3] gitcli: document --end-of-options
Message-ID: <20190806144030.GC2161@sigill.intra.peff.net>
References: <20190806143829.GA515@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190806143829.GA515@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that --end-of-options is available for any users of
setup_revisions() or parse_options(), which should be effectively
everywhere, we can guide people to use it for all their disambiguating
needs.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/gitcli.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index 1ed3ca33b7..4b32876b6e 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -37,6 +37,12 @@ arguments.  Here are the rules:
    file called HEAD in your work tree, `git diff HEAD` is ambiguous, and
    you have to say either `git diff HEAD --` or `git diff -- HEAD` to
    disambiguate.
+
+ * Because `--` disambiguates revisions and paths in some commands, it
+   cannot be used for those commands to separate options and revisions.
+   You can use `--end-of-options` for this (it also works for commands
+   that do not distinguish between revisions in paths, in which case it
+   is simply an alias for `--`).
 +
 When writing a script that is expected to handle random user-input, it is
 a good practice to make it explicit which arguments are which by placing
-- 
2.23.0.rc1.436.g24d2e81391
