Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE569C63777
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 08:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E77320BED
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 08:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbgLCIBA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 03:01:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:49776 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728786AbgLCIBA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 03:01:00 -0500
Received: (qmail 7853 invoked by uid 109); 3 Dec 2020 08:00:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 03 Dec 2020 08:00:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29255 invoked by uid 111); 3 Dec 2020 08:00:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 03 Dec 2020 03:00:18 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 3 Dec 2020 03:00:18 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH] style: indent multiline "if" conditions by 4 spaces
Message-ID: <X8ibEpkel8OMS/hV@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 6dc905d974 (config: split repo scope to local and worktree,
2020-02-10) made some "if" statements multiline, but didn't indent the
second lines in our usual way.

Signed-off-by: Jeff King <peff@peff.net>
---
I just happened to be reading nearby code and saw this.

 remote.c      | 2 +-
 upload-pack.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/remote.c b/remote.c
index 8a6dbbb903..8b9d090ae5 100644
--- a/remote.c
+++ b/remote.c
@@ -355,7 +355,7 @@ static int handle_config(const char *key, const char *value, void *cb)
 	remote = make_remote(name, namelen);
 	remote->origin = REMOTE_CONFIG;
 	if (current_config_scope() == CONFIG_SCOPE_LOCAL ||
-	current_config_scope() == CONFIG_SCOPE_WORKTREE)
+	    current_config_scope() == CONFIG_SCOPE_WORKTREE)
 		remote->configured_in_repo = 1;
 	if (!strcmp(subkey, "mirror"))
 		remote->mirror = git_config_bool(key, value);
diff --git a/upload-pack.c b/upload-pack.c
index 5dc8e1f844..a85d4ec502 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1302,7 +1302,7 @@ static int upload_pack_config(const char *var, const char *value, void *cb_data)
 	}
 
 	if (current_config_scope() != CONFIG_SCOPE_LOCAL &&
-	current_config_scope() != CONFIG_SCOPE_WORKTREE) {
+	    current_config_scope() != CONFIG_SCOPE_WORKTREE) {
 		if (!strcmp("uploadpack.packobjectshook", var))
 			return git_config_string(&data->pack_objects_hook, var, value);
 	}
-- 
2.29.2.896.g080220a959
