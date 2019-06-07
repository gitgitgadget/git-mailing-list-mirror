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
	by dcvr.yhbt.net (Postfix) with ESMTP id CC65B1F462
	for <e@80x24.org>; Fri,  7 Jun 2019 01:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfFGBJH (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 21:09:07 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:48872 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfFGBJH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jun 2019 21:09:07 -0400
Received: by mail-qk1-f202.google.com with SMTP id w184so246531qka.15
        for <git@vger.kernel.org>; Thu, 06 Jun 2019 18:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=y4HjGDe3bxCzb0W8Y3JckXMbW1dC2Gj31sx9Q1n1qCg=;
        b=KorrtD4hT0k0reQHslBXSmwNLIZQlZGKaReHDpAuxUtOckqeCcOQ2ySEDBPojSbVsD
         DaPsZYQ4YinN7k+Ertg9VPWLo2taAjMuil4S7hzkZbymylyiqmdGZq+nvLy9raQgtqMx
         tZoPWunxfa3wGPGYuHlQeZFi9mlAQhuXF127ciZkyMrY5nXjhUoPgfaRvEwJQkzclNnW
         a8uWKckypfGWxMZNnGKe+1M+Ew8ifJThpACBJWG93F2nM6mN3wBW/EFrtZfGlDQU9UoO
         uZ1IZPo9iK6qpnw0vn92HwkI9zHcDdJZEX8sP9FhZpPT5C6rC67CGy2dMivQ9ZZWnywu
         LyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=y4HjGDe3bxCzb0W8Y3JckXMbW1dC2Gj31sx9Q1n1qCg=;
        b=pk0n/gKH4Aod/S0W4T+7JTJuiI/N/2Dmz22hISGdEod2PYIVVpOgsp763N7mo3q5BT
         8cjznNLi478vFod+z3oELkslKN91HbRFzaCxnmdT9ol+CXiCYJrW1AS/DghD7AOrO9u5
         9uM+cR6FOb7yUZ4E00QpWMQLZCpNSoULGqfqU15qYj+L1OdFwqstFIKnyhLmV5zzzcHi
         pKQwLjqC7exn7wyXRSqGhW5Gu2I29wyeAttyVW2XuMOCIOLsq2o2iKy4ZHRsPw9NhJgD
         hD0o4a+1XbLlvYs6xdkiqY30vXo9JLpKgygaLfhIjvt544o7rWzRea/ayezOp0xh9gFe
         h+ew==
X-Gm-Message-State: APjAAAXffcihgwRFDTbt+WD5BMDsquyWVuv3SDfnGxTETCedRMDIywh4
        GUqVoiOavm7UGQg7TNvYY7ioEq1NwudBjs3sTDAI2Mt1Gh+WVqh3EqtXJTo2vSqKgf9lpoU7zsH
        OdTzDkj1/Rz6MrR/fuUdX4C+fYvdfdf8p1vX3eYyRQc4n6ami8IomaGMFSzSIkQoEfvcnUy70ZA
        ==
X-Google-Smtp-Source: APXvYqyMn9eXPZredAhPY+EI082a0znfbkuJDNim4ssftMjIfxGtltcwb/T4t6qp/mijJ6odwVdBm6VcS8eAkz7X1lY=
X-Received: by 2002:ae9:e842:: with SMTP id a63mr40166454qkg.143.1559869746689;
 Thu, 06 Jun 2019 18:09:06 -0700 (PDT)
Date:   Thu,  6 Jun 2019 18:08:03 -0700
In-Reply-To: <20190607010811.52944-1-emilyshaffer@google.com>
Message-Id: <20190607010811.52944-6-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20190607010708.46654-1-emilyshaffer@google.com> <20190607010811.52944-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [RFC PATCH 05/13] walken: configure rev_info and prepare for walk
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`struct rev_info` is what's used by the struct itself.
`repo_init_revisions()` initializes the struct; then we need to set it
up for the walk we want to perform, which is done in
`final_rev_info_setup()`.

The most important step here is adding the first object we want to walk
to the pending array. Here, we take the easy road and use
`add_head_to_pending()`; there is also a way to do it with
`setup_revision_opt()` and `setup_revisions()` which we demonstrate but
do not use. If we were to forget this step, the walk would do nothing -
the pending queue would be checked, determined to be empty, and the walk
would terminate immediately.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 builtin/walken.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/builtin/walken.c b/builtin/walken.c
index 5d1666a5da..c101db38c7 100644
--- a/builtin/walken.c
+++ b/builtin/walken.c
@@ -6,6 +6,7 @@
 
 #include <stdio.h>
 #include "builtin.h"
+#include "revision.h"
 #include "config.h"
 #include "parse-options.h"
 
@@ -26,6 +27,35 @@ static void init_walken_defaults(void)
 	 */
 }
 
+/*
+ * cmd_log calls a second set of init after the repo_init_revisions call. We'll
+ * mirror those settings in post_repo_init_init.
+ */
+static void final_rev_info_setup(int argc, const char **argv, const char *prefix,
+		struct rev_info *rev)
+{
+	struct setup_revision_opt opt;
+
+	/* setup_revision_opt is used to pass options to the setup_revisions()
+	 * call. It's got some special items for submodules and other types of
+	 * optimizations, but for now, we'll just point it to HEAD and call it
+	 * good. First we should make sure to reset it. TODO: This is useful for
+	 * more complicated stuff revisions, but a decent shortcut for the first
+	 * pass is add_head_to_pending().
+	 */
+	memset(&opt, 0, sizeof(opt));
+	opt.def = "HEAD";
+	opt.revarg_opt = REVARG_COMMITTISH;
+	//setup_revisions(argc, argv, rev, &opt);
+
+	/* Let's force oneline format. */
+	get_commit_format("oneline", rev);
+	rev->verbose_header = 1;
+	
+	/* add the HEAD to pending so we can start */
+	add_head_to_pending(rev);
+}
+
 /*
  * This method will be called back by git_config(). It is used to gather values
  * from the configuration files available to Git.
@@ -54,12 +84,24 @@ int cmd_walken(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
+	struct rev_info rev;
+
 	argc = parse_options(argc, argv, prefix, options, walken_usage, 0);
 
 	init_walken_defaults();
 
 	git_config(git_walken_config, NULL);
 
+	/* Time to set up the walk. repo_init_revisions sets up rev_info with
+	 * the defaults, but then you need to make some configuration settings
+	 * to make it do what's special about your walk.
+	 */
+	repo_init_revisions(the_repository, &rev, prefix);
+
+	/* Before we do the walk, we need to set a starting point. It's not
+	 * coming from opt. */
+	final_rev_info_setup(argc, argv, prefix, &rev);
+
 	printf(_("cmd_walken incoming...\n"));
 	return 0;
 }
-- 
2.22.0.rc1.311.g5d7573a151-goog

