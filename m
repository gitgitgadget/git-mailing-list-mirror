Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB301C12002
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 21:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B16E06101D
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 21:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbhGNVlV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 17:41:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:50076 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229657AbhGNVlU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 17:41:20 -0400
Received: (qmail 422 invoked by uid 109); 14 Jul 2021 21:38:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Jul 2021 21:38:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28511 invoked by uid 111); 14 Jul 2021 21:38:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Jul 2021 17:38:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 14 Jul 2021 17:38:27 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     German Lashevich <german.lashevich@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH 3/3] doc/git-config: simplify "override" advice for FILES
 section
Message-ID: <YO9ZU4nO7YOASAHn@coredump.intra.peff.net>
References: <YO9YyTZdU4WadYGg@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YO9YyTZdU4WadYGg@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At the end of the FILES section, we indicate that you can override the
regular lookup rules with --global, etc. But:

  - we're missing the --local option

  - we point to GIT_CONFIG instead of --file, but the latter has much
    better documentation

  - we're vague about how the overrides work; the actual option
    descriptions are much better here

So let's just mention the names and point people back to the OPTIONS
section. We could perhaps even delete this paragraph entirely, but the
presence of the names may give people reading FILES a clue about where
to look for more information.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-config.txt | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 30186812a8..e30edf99c6 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -71,6 +71,7 @@ codes are:
 
 On success, the command returns the exit code 0.
 
+[[OPTIONS]]
 OPTIONS
 -------
 
@@ -331,11 +332,9 @@ All writing options will per default write to the repository specific
 configuration file. Note that this also affects options like `--replace-all`
 and `--unset`. *'git config' will only ever change one file at a time*.
 
-You can override these rules either by command-line options or by environment
-variables. The `--global`, `--system` and `--worktree` options will limit
-the file used to the global, system-wide or per-worktree file respectively.
-The `GIT_CONFIG` environment variable has a similar effect, but you
-can specify any filename you want.
+You can override these rules using the `--global`, `--system`,
+`--local`, `--worktree`, and `--file` command-line options; see
+<<OPTIONS>> above.
 
 
 ENVIRONMENT
-- 
2.32.0.689.gbb74d99cdd
