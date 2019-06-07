Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 828F51F462
	for <e@80x24.org>; Fri,  7 Jun 2019 01:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfFGBI7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 21:08:59 -0400
Received: from mail-ot1-f74.google.com ([209.85.210.74]:49766 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfFGBI7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jun 2019 21:08:59 -0400
Received: by mail-ot1-f74.google.com with SMTP id l7so192922otj.16
        for <git@vger.kernel.org>; Thu, 06 Jun 2019 18:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZngRkZ/rw04VhrmFATe317dWnDm4b+I+GMREhiidOPA=;
        b=PWCNFTo+/MDv/FETQBMPg1k27bhH8LW+jtGc9+4VvOFHh+dInLWaXGL/n98J9kAAWB
         IwvQB2oMEd4vFS+1msNvsb/6fbOqiqqWq8Aq1Xi3SbiKacTtav2V80shb6yRX8sCi0WN
         W5FMnwy84q45dtzyFJbQdgODJjFDmvY8TQ0LS8FZ6kw5n6wulYy8Yo33hLggpjHhp94u
         UWjiDfuuYuXOgXwNVoFM2YjGQYdLiQLeyUonpq6jdzcclDDS+FzCY1xwUS9HVUdFtM4l
         Vw+7ibEdyWJRCrrYaQ8LLPQhzQT/W8zCtf1EyPmdMlwdAXHkJ3Uhr8CsaVVExJgpxZ2n
         l7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZngRkZ/rw04VhrmFATe317dWnDm4b+I+GMREhiidOPA=;
        b=tENs0XPClHVi7sQMoO67YjuPmQiI3Wi4szkX5V3vA6BMLaIh8cPx2pG6Hhwb17FF9G
         mawmm57Zgug8oG3swRYJZC9a8oM8huWblayJvzMvn2S6VOHQs1nsi7RH5TARxLXDtdZv
         Iq5InWkPV3I5endGXO0y03ExxjUruTz98YzsSjzSJVmpwMUDMgKX0IbVyanharZl0Yzt
         TbWE62gI1LZs/IHNCeApsv2vtG97zNFbpTU1kfHcYrpGqyFSxhdBjapHb5D/xFb+dZ74
         mduag7l8m7tZArPOixHUyFeEbqoCLj0KJtNvnghVqlTFgmdejTiZHev8/tnjsV2jU1+T
         LNbQ==
X-Gm-Message-State: APjAAAUhuTS0BZhPu1W/h/s5VwcHsPaAblT2zp+di2+QVIwSr+43Xh2K
        pOAG0XH+A3n3Rl5NL4tOsxZHhcuEz4oUXRyTX6YYnDZR0MIujDySVuis4ZVdExlDGzj5jfn1Q4B
        lHb0Z2gTSOOVkQxgM3vB0o3SdXYaR4iwKjroNqjlhnt7wxUwjGIS7MXTT70yqwRTKQvkiXnCZjA
        ==
X-Google-Smtp-Source: APXvYqwTwMbOtCaw6F/qW0dU5+c5V6/GMEe4SU+sv4xj2oOVrChUTY47+omrZlPDxZJMmTtF/qNCZZ30t3ayK9RuNxw=
X-Received: by 2002:aca:4e16:: with SMTP id c22mr2075840oib.161.1559869738064;
 Thu, 06 Jun 2019 18:08:58 -0700 (PDT)
Date:   Thu,  6 Jun 2019 18:08:00 -0700
In-Reply-To: <20190607010811.52944-1-emilyshaffer@google.com>
Message-Id: <20190607010811.52944-3-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20190607010708.46654-1-emilyshaffer@google.com> <20190607010811.52944-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [RFC PATCH 02/13] walken: add usage to enable -h
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One requirement of the Git test suite is that all commands support '-h',
which is captured by parse_options(). In order to support this flag, add
a short usage text to walken.c and invoke parse_options().

With this change, we can now add cmd_walken to the builtins set and
expect tests to pass, so we'll do so - cmd_walken is now open for
business.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 builtin/walken.c | 12 ++++++++++++
 git.c            |  1 +
 2 files changed, 13 insertions(+)

diff --git a/builtin/walken.c b/builtin/walken.c
index bfeaa5188d..5ae7c7d93f 100644
--- a/builtin/walken.c
+++ b/builtin/walken.c
@@ -6,9 +6,21 @@
 
 #include <stdio.h>
 #include "builtin.h"
+#include "parse-options.h"
+
+static const char * const walken_usage[] = {
+	N_("git walken"),
+	NULL,
+};
 
 int cmd_walken(int argc, const char **argv, const char *prefix)
 {
+	struct option options[] = {
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options, walken_usage, 0);
+
 	printf(_("cmd_walken incoming...\n"));
 	return 0;
 }
diff --git a/git.c b/git.c
index 1bf9c94550..209c42836f 100644
--- a/git.c
+++ b/git.c
@@ -600,6 +600,7 @@ static struct cmd_struct commands[] = {
 	{ "verify-pack", cmd_verify_pack },
 	{ "verify-tag", cmd_verify_tag, RUN_SETUP },
 	{ "version", cmd_version },
+	{ "walken", cmd_walken, RUN_SETUP },
 	{ "whatchanged", cmd_whatchanged, RUN_SETUP },
 	{ "worktree", cmd_worktree, RUN_SETUP | NO_PARSEOPT },
 	{ "write-tree", cmd_write_tree, RUN_SETUP },
-- 
2.22.0.rc1.311.g5d7573a151-goog

