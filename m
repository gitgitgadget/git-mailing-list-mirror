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
	by dcvr.yhbt.net (Postfix) with ESMTP id 02CA81F461
	for <e@80x24.org>; Mon,  1 Jul 2019 20:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfGAUU2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 16:20:28 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:42266 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfGAUU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 16:20:27 -0400
Received: by mail-pg1-f202.google.com with SMTP id d3so8197565pgc.9
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 13:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LoEqZ1iDzeBeAA35h06NAHCd6FC0NOIYzWIRpoLwOFk=;
        b=gi+89trHASnIboFXdo9+29brXLKAI7J1TpXImhyqsTJg1YBu56hgk3Yy9D7hICnYdd
         3OAPLoHX11GgzEkz38wZPgOl7dhrZRwflNGq7UicBMIch2NPcQVsC+CgDxM7kzbvXkV+
         JBoa3m/Dp8XxgE44Kp01bE5hasyI06mbBMYFYhr+9v3QWFajhMZixOmLgmO5JevdPrAV
         /t96mdGoiWdrTI7xJXylwpQtRvAdaXAZX8zOpnJ0/xKJFlF8XXOX1RIW4lplXrAq8iYK
         YpXZq3beqxPK5NAwwUHBOWEdv41YjHXQObVKHS1UOMVK4IaBCoayIsnB7ERAYsoMaQqz
         pBOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LoEqZ1iDzeBeAA35h06NAHCd6FC0NOIYzWIRpoLwOFk=;
        b=AdjhjbTbPZrLfApREDzMniR+3M4CPmbpyUNu5frrRg9M0xNMMw2U1x9XxHnZ4eM7iU
         jkfy/UxNcSd26GgcHpBuTwhQ8LiPyUPkwJ3wkxqBlUYhoAA3cU4uiOMbeoDxVi4mzCbY
         dnDavydzwGkODwSjJxlEr52UXLqlNf1rCfOnKZmSKgT6FUf5faUdU9RP+bpvC1Isdzeb
         76+WIfCjNsJ62tZKhfWWxOen+usIJDTzmFZffQcy9vhV/wKqrsGft81LWimlRovHq181
         6kYiadqP0xtKKtCGrGJ8r4CtGE7VayOMXmu+oaCzTL/HUfGiHjVRhJyUdNlMUWzuKzBe
         4Mag==
X-Gm-Message-State: APjAAAUzwE0WXbFURA/dBPNvSFGIjCny4EIaXZZGVYFP9UJ01iYHvEod
        zGEPLiw72atNVMMw2LtM4ZnKhgHpfI6LgIjWJ5uGI4zKTuq67kHzBwUv3efaieRuD+rboBTxvAL
        yGyTrSVrmQ/elIzOWR5voUpzNhr7bSiCGU/B1auOtPmOqSIE0Yzj6KBI9rTPcXAeaaGKEvRD4ag
        ==
X-Google-Smtp-Source: APXvYqz0jgPyOcwb8U8/zqkMcSrCzui8FozqH9uivPlbkj4h/zVMeynwz9Khkew9gBWltTluEbh9CopZzatSXxw57/k=
X-Received: by 2002:a63:2c43:: with SMTP id s64mr26430730pgs.50.1562012426847;
 Mon, 01 Jul 2019 13:20:26 -0700 (PDT)
Date:   Mon,  1 Jul 2019 13:20:03 -0700
In-Reply-To: <20190701202014.34480-1-emilyshaffer@google.com>
Message-Id: <20190701202014.34480-3-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20190701201934.30321-1-emilyshaffer@google.com> <20190701202014.34480-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [RFC PATCH v3 02/13] walken: add usage to enable -h
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
 builtin/walken.c | 21 +++++++++++++++++++++
 git.c            |  1 +
 2 files changed, 22 insertions(+)

diff --git a/builtin/walken.c b/builtin/walken.c
index db3ca50b04..dd55f3b350 100644
--- a/builtin/walken.c
+++ b/builtin/walken.c
@@ -5,9 +5,30 @@
  */
 
 #include "builtin.h"
+#include "parse-options.h"
+
 
 int cmd_walken(int argc, const char **argv, const char *prefix)
 {
+	/*
+	 * All builtins are expected to provide a usage to provide a consistent user
+	 * experience.
+	 */
+	const char * const walken_usage[] = {
+		N_("git walken"),
+		NULL,
+	};
+
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
 	/*
 	 * This line is "human-readable" and we are writing a plumbing command,
 	 * so we localize it and use the trace library to print only when
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

