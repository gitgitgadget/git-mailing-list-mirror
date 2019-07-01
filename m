Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C73AE1F461
	for <e@80x24.org>; Mon,  1 Jul 2019 20:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfGAUUm (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 16:20:42 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:35675 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfGAUUk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 16:20:40 -0400
Received: by mail-ua1-f73.google.com with SMTP id s1so2591165uao.2
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 13:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=c9OZMoGPdDKVD8tl0a0+KZuqPEgrAymzY/dja2wJLR8=;
        b=REFHKiq5vV0RgEqH55RfnK5iirFzEUsHB3b5nxKM3UPdv5QJZ4VyFuj2FoHMk1gSIf
         x6q8ZPTwHqiSrmxbtz5sjUWq5M+UfHLW9YBSCvNyveSBN/sOCSyGCha8llMXsVV26+KT
         samORpdZmiuGGHIGg8XQHEVJhS3LfRUff5vKP0yPQeNu8fEZ2tWpFLKcy5SjETw5WyK5
         vfOzzxMFTt7gyXMVcplxfVbR4mjBjI86/tE+GJCNuvEysrZDIIf8DYZxjn5+QSMOUEmL
         qbku4+dpTib4t3ge959LXUyznZhqoCKh1Q6P3snCfJdVdTu7xPKK7MswEzZ4KB9PGTXY
         gzfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=c9OZMoGPdDKVD8tl0a0+KZuqPEgrAymzY/dja2wJLR8=;
        b=U6vQwT2B5KZl6PQhV2zzU6zuloG4eXZUGMibg39TDzRzY/dJh361rgwDVR1BTnhjYa
         2i0Alm11vd9tSfd/q9RLHOC6f0DtSshGsZz0nmoQZhC5HjFLd/Eu5F6j8IDC/i5/COL1
         95Kam3T40Ad9pc4JUBDSu5fFuKe5uYurTOvLI7BVhZU81PRi7ysgEUVX4k3bZmHFMb1T
         3kFKHxFmr1c/BV598WtgmGjLZTPgCNhL01hGK9Ys4flS1bEUgdORvSfUAm3Bvxz2lX7B
         H1jsW3e2DAXjXOgYEmd6CZgZreYDhUDMLNRQyRERrzpC/vqpvIVEsKqp4g3HNw5ah1Ks
         bhNw==
X-Gm-Message-State: APjAAAVeA6tfiRHzeANYmURSlfoCH7nPReIi++3c6SCdWoJqSBY0OxTc
        /LDlQBf6j6FTvI/wRigFdABDwEF0zt003fJEF6HmpqXdDdCMRwU8QQ6/kXk6cWaGQclECx3DbO3
        eKYmaEOPOs/N7/4WnLShkBkldQ0E/MKOfkGcItlMegLCt7aPgdwi6cIUcfpVXW8enGmFG+CQjFg
        ==
X-Google-Smtp-Source: APXvYqzv0Z0ijQq+L25qDZi1AzUDcFCORYOmSwZjO4XU6FtTi4l+9XMwWWoXoTyttS9OBLKEy229Pq2PW2PzhFxM0Uc=
X-Received: by 2002:ab0:3119:: with SMTP id e25mr14824111ual.96.1562012439698;
 Mon, 01 Jul 2019 13:20:39 -0700 (PDT)
Date:   Mon,  1 Jul 2019 13:20:08 -0700
In-Reply-To: <20190701202014.34480-1-emilyshaffer@google.com>
Message-Id: <20190701202014.34480-8-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20190701201934.30321-1-emilyshaffer@google.com> <20190701202014.34480-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [RFC PATCH v3 07/13] walken: filter for authors from gmail address
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to demonstrate how to create grep filters for revision walks,
filter the walk performed by cmd_walken() to print only commits which
are authored by someone with a gmail address.

This commit demonstrates how to append a grep pattern to a
rev_info.grep_filter, to teach new contributors how to create their own
more generalized grep filters during revision walks.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 builtin/walken.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/walken.c b/builtin/walken.c
index f116bb6fca..a600f88cf6 100644
--- a/builtin/walken.c
+++ b/builtin/walken.c
@@ -11,6 +11,7 @@
 #include "parse-options.h"
 #include "pretty.h"
 #include "line-log.h"
+#include "grep.h"
 
 
 /*
@@ -20,10 +21,8 @@
  */
 static void init_walken_defaults(void)
 {
-	/*
-	 * We don't use any other components or have settings to initialize, so
-	 * leave this empty.
-	 */
+	/* Needed by our grep filter. */
+	init_grep_defaults(the_repository);
 }
 
 /*
@@ -55,6 +54,10 @@ static void final_rev_info_setup(int argc, const char **argv, const char *prefix
 	/* add the HEAD to pending so we can start */
 	add_head_to_pending(rev);
 
+	/* Apply a 'grep' pattern to the 'author' header. */
+	append_header_grep_pattern(&rev->grep_filter, GREP_HEADER_AUTHOR, "gmail");
+	compile_grep_patterns(&rev->grep_filter);
+
 	/* Let's force oneline format. */
 	get_commit_format("oneline", rev);
 	rev->verbose_header = 1;
@@ -78,10 +81,7 @@ static void final_rev_info_setup(int argc, const char **argv, const char *prefix
  */
 static int git_walken_config(const char *var, const char *value, void *cb)
 {
-	/*
-	 * For now, we don't have any custom configuration, so fall back on the
-	 * default config.
-	 */
+	grep_config(var, value, cb);
 	return git_default_config(var, value, cb);
 }
 
-- 
2.22.0.410.gd8fdbe21b5-goog

