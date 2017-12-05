Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 052C720A40
	for <e@80x24.org>; Tue,  5 Dec 2017 17:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753174AbdLERDu (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 12:03:50 -0500
Received: from siwi.pair.com ([209.68.5.199]:15277 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753049AbdLERDP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 12:03:15 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 5B08E844E4;
        Tue,  5 Dec 2017 12:03:14 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id D4B56844DE;
        Tue,  5 Dec 2017 12:03:13 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v6 07/14] fixup: fetch: update error messages from --blob-max-bytes to --filter
Date:   Tue,  5 Dec 2017 17:02:47 +0000
Message-Id: <20171205170254.65293-8-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171205170254.65293-1-git@jeffhostetler.com>
References: <20171205170254.65293-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/fetch.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 05d0b1a..14aab71 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1372,7 +1372,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		deepen = 1;
 
 	if (filter_options.choice && !repository_format_partial_clone)
-		die("--blob-max-bytes can only be used when extensions.partialClone is set");
+		die("--filter can only be used when extensions.partialClone is set");
 
 	if (all) {
 		if (argc == 1)
@@ -1406,11 +1406,11 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	if (remote) {
 		if (filter_options.choice &&
 		    strcmp(remote->name, repository_format_partial_clone))
-			die(_("--blob-max-bytes can only be used with the remote configured in core.partialClone"));
+			die(_("--filter can only be used with the remote configured in core.partialClone"));
 		result = fetch_one(remote, argc, argv);
 	} else {
 		if (filter_options.choice)
-			die(_("--blob-max-bytes can only be used with the remote configured in core.partialClone"));
+			die(_("--filter can only be used with the remote configured in core.partialClone"));
 		result = fetch_multiple(&list);
 	}
 
-- 
2.9.3

