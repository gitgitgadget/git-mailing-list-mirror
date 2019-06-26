Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D92F31F461
	for <e@80x24.org>; Wed, 26 Jun 2019 23:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfFZXvB (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 19:51:01 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:52146 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfFZXvA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jun 2019 19:51:00 -0400
Received: by mail-pf1-f201.google.com with SMTP id 145so261223pfv.18
        for <git@vger.kernel.org>; Wed, 26 Jun 2019 16:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EpJK3nyRD/4VLb+i1cnUJMMJENYDbLDvzuMVALAaAd8=;
        b=JN6IUx+Qd23Tl1JLVmjtgptfkxdc21h8pxi9kChh6YPLKqYR7lm7SGguPakM0Sn1AH
         Gmm+AT9oiVS2u+PekQzZ3ESrSlA22ap78ix2J0E5zgv2dXloI1cFt2aFU9cqu3fyvvDv
         MQKNIqaPYv2dRUMDAOBo6BLWoLYLTIK35sn+MJtHPbZJEiKynVWTFZkHW4CQvOmcObaF
         6dtCiQrpPl2ZZFs9qmEoI4tSnhbxlYiDIurVQK0prQEVQFNUWjN0XxfJzv9RIc1hO8XG
         8rebFmOsh0ZZehzfqhKaHqM5ULDE3lrmmqt1yQc/mRWEyAa4fMzqncvAt7D3DSYpRQVs
         wopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EpJK3nyRD/4VLb+i1cnUJMMJENYDbLDvzuMVALAaAd8=;
        b=qnGffyGJL67YxdlQbIyqdnLZ2WhfqiHbplj3JcaeMaG5dkqtmLWc0dvosOIxGKdI7u
         tHjHEgxVdAV+8plYOYnM8Kj8V7slzdLyymO6NMtd22iJQso/Ffzc4Lsl1S83NtL98Ok7
         CRv9gtrR/L4pSdxSLLiZ62M/eOJ4w3Xm7jYmlaW+P1fgZBHPkxdPUP1H7306NCOZGSZY
         4fRsqjydXMY2lvlH0uRaqkHxg0CVHSN40VG1bC2/1xS14crAZirMPzIQgjsMlm3jwIGC
         4/uxRKgY+c3m/TF6YoYZHJVnzV2DFtFvryijmysQz2uKapUl4ePRPL7q4wJaUwIAoGyn
         q0Sg==
X-Gm-Message-State: APjAAAX6oOmDmI7a9tUqRiehqOidLR1SVQZ9FmoZGhVKcJ8SdVmMF/fS
        1qxPyw73EYsWFA2PNJ4o1iuZb9anvLbV6xxdwKQBGIL9hcKsAlXX0ayymGIzpK3j26GHZdn4MZN
        TWXQs3U1pJbhafvufUru/W/fOt2onQsa14q7IGx+yj4WXRGKYq/nGhd9CgK3/txqIIp2NeLDSWQ
        ==
X-Google-Smtp-Source: APXvYqyBmt0467q7Hh4lu3FAIDA2LOespYre5quETy7XUhDi5wrq7O/eQTng22oVPS8BNoLWoJTL7mIMr0usLjIwqZE=
X-Received: by 2002:a65:648e:: with SMTP id e14mr608928pgv.317.1561593059582;
 Wed, 26 Jun 2019 16:50:59 -0700 (PDT)
Date:   Wed, 26 Jun 2019 16:50:21 -0700
In-Reply-To: <20190626235032.177551-1-emilyshaffer@google.com>
Message-Id: <20190626235032.177551-3-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20190626235032.177551-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [RFC PATCH v2 02/13] walken: add usage to enable -h
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's expected that Git commands support '-h' in order to provide a
consistent user experience (and this expectation is enforced by the
test suite). '-h' is captured by parse_options() by default; in order to
support this flag, we add a short usage text to walken.c and invoke
parse_options().

With this change, we can now add cmd_walken to the builtins set and
expect tests to pass, so we'll do so - cmd_walken is now open for
business.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Change-Id: I2919dc1efadb82acb335617ea24371c84b03bbce
---
 builtin/walken.c | 25 +++++++++++++++++++++++++
 git.c            |  1 +
 2 files changed, 26 insertions(+)

diff --git a/builtin/walken.c b/builtin/walken.c
index d2772a0e8f..9eea51ff70 100644
--- a/builtin/walken.c
+++ b/builtin/walken.c
@@ -5,9 +5,34 @@
  */
 
 #include "builtin.h"
+#include "parse-options.h"
+
+/*
+ * All builtins are expected to provide a usage to provide a consistent user
+ * experience.
+ */
+const char * const walken_usage[] = {
+	N_("git walken"),
+	NULL,
+};
 
 int cmd_walken(int argc, const char **argv, const char *prefix)
 {
+	struct option options[] = {
+		OPT_END()
+	};
+
+	/*
+	 * parse_options() handles showing usage if incorrect options are
+	 * provided, or if '-h' is passed.
+	 */
+	argc = parse_options(argc, argv, prefix, options, walken_usage, 0);
+
+	/*
+	 * This line is "human-readable" and we are writing a plumbing command,
+	 * so we localize it and use the trace library to print only when
+	 * the GIT_TRACE environment variable is set.
+	 */
 	trace_printf(_("cmd_walken incoming...\n"));
 	return 0;
 }
diff --git a/git.c b/git.c
index c2eec470c9..2a7fb9714f 100644
--- a/git.c
+++ b/git.c
@@ -601,6 +601,7 @@ static struct cmd_struct commands[] = {
 	{ "verify-pack", cmd_verify_pack },
 	{ "verify-tag", cmd_verify_tag, RUN_SETUP },
 	{ "version", cmd_version },
+	{ "walken", cmd_walken, RUN_SETUP },
 	{ "whatchanged", cmd_whatchanged, RUN_SETUP },
 	{ "worktree", cmd_worktree, RUN_SETUP | NO_PARSEOPT },
 	{ "write-tree", cmd_write_tree, RUN_SETUP },
-- 
2.22.0.410.gd8fdbe21b5-goog

