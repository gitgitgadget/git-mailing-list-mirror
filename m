Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 260CC2093C
	for <e@80x24.org>; Fri,  9 Dec 2016 04:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932227AbcLIEK0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 23:10:26 -0500
Received: from continuum.iocl.org ([217.140.74.2]:54695 "EHLO
        continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932177AbcLIEK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 23:10:26 -0500
Received: (from krey@localhost)
        by continuum.iocl.org (8.11.3/8.9.3) id uB94AMP13529;
        Fri, 9 Dec 2016 05:10:22 +0100
Date:   Fri, 9 Dec 2016 05:10:21 +0100
From:   Andreas Krey <a.krey@gmx.de>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH] commit: remove 'Clever' message for --only --amend
Message-ID: <20161209041021.GB16292@inner.h.apk.li>
References: <20161202221513.GA5370@inner.h.apk.li> <20161203043254.7ozjyucfn6uivnsh@sigill.intra.peff.net> <xmqqd1h63xqn.fsf@gitster.mtv.corp.google.com> <20161208135029.GA16292@inner.h.apk.li> <xmqq1sxiv051.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1sxiv051.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

That behavior is now documented, and we don't
need a reward afterwards.

Signed-off-by: Andreas Krey <a.krey@gmx.de>
---

> Sorry for making you send an extra round; let's queue the original,
> and if you still are interested, have the "Clever" removal as its
> own patch.

Here you go.

 builtin/commit.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 89b66816f..276c74034 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1208,8 +1208,6 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		die(_("Only one of --include/--only/--all/--interactive/--patch can be used."));
 	if (argc == 0 && (also || (only && !amend && !allow_empty)))
 		die(_("No paths with --include/--only does not make sense."));
-	if (argc == 0 && only && amend)
-		only_include_assumed = _("Clever... amending the last one with dirty index.");
 	if (argc > 0 && !also && !only)
 		only_include_assumed = _("Explicit paths specified without -i or -o; assuming --only paths...");
 	if (!cleanup_arg || !strcmp(cleanup_arg, "default"))
-- 
2.11.0.10.g1e1b186.dirty
