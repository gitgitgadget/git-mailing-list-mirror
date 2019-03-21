Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65ECF20248
	for <e@80x24.org>; Thu, 21 Mar 2019 13:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbfCUNTo (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 09:19:44 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44864 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbfCUNTo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 09:19:44 -0400
Received: by mail-pf1-f196.google.com with SMTP id a3so4252041pff.11
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 06:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t2B50LzTc9t+C/dvMG7Ua8H4kPiJqSPpzv2AB9R6nr4=;
        b=uIzGu9sSpUaWfSjukD1wwwKG21zHWN5JQcEFQ73c577NRScHs56h7EMwe5BDnuRe2u
         IbLrzrI/Tny//WCxRqp9DqrI9ITUkKkHeZf+ddf0ZEE1v0P9QNrJfE1dGmAVwAd2BpMm
         7eR2Gsm1vCvzPYAq1i3XTJEyY491uU6cBOjpCszXSpW5hiTDZTftMKGpimbwt6OhG4N1
         WBFrf1JpqMEr+ctUqDciE4JBnTuphA11UAfnLw2/PiRPAoEgPdyA7hJEwDCLmyCDvZ5L
         DwMM6ctxp6aawUpMhGuOSopicZokMTmNpyBLAf1m6vr58oCLljd/TSM0PZTx9zGmvsKM
         6Fvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t2B50LzTc9t+C/dvMG7Ua8H4kPiJqSPpzv2AB9R6nr4=;
        b=l9gF8dITwj8QXgGC8pfjVEAf5OBrvLTn4FLW+d3pF+YDs6igokVwvAdA/1l8d8Wk5e
         ziUNaZFTkJfcNKQaX637C3+94takdRTYyDOLZ92AG2tUqKX4jvl7j2AcgiegLhuQsW8o
         eoTj4tDfU+EBW1NzY56JAQo1WtljUvjMTwxl2qRmKihqY9/AEC43zv1IEw2Uov/xYY1q
         qNc1asUiis2/9OyDY7SeJcNRU8jtKHjcjdN/v1Bvjb1d0/slA4uhZz0NV+SXz4/nOw6c
         KHNKkvW3S2m/MUnc0yyOhly57rDTW2XJD1pJ2neW5qNlWbhQKDjX3YNlP6kDELSPsZjO
         IyFw==
X-Gm-Message-State: APjAAAXy5zEKlny47JjrJOXPnb7qTCBbisG89pNSOkDyEkCti8P106x/
        llcLbxpLX7BU2u3zJ6FQrW+SfAR1
X-Google-Smtp-Source: APXvYqwGzhdXCKq3CiXKFxhDT2gXhrTg9cy+fIzTur96SK7nNMJ3rHxFyXKpwUHu2C0PKjOFuBCj9g==
X-Received: by 2002:a63:4f43:: with SMTP id p3mr3305266pgl.207.1553174382924;
        Thu, 21 Mar 2019 06:19:42 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id y14sm7306787pgg.6.2019.03.21.06.19.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 06:19:42 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 21 Mar 2019 20:19:36 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     eckhard.s.maass@googlemail.com, git@vger.kernel.org,
        gitster@pobox.com, jacob.keller@gmail.com, martin.agren@gmail.com,
        newren@gmail.com, phillip.wood123@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v5 22/26] switch: reject if some operation is in progress
Date:   Thu, 21 Mar 2019 20:16:51 +0700
Message-Id: <20190321131655.15249-23-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190321131655.15249-1-pclouds@gmail.com>
References: <20190317124926.17137-1-pclouds@gmail.com>
 <20190321131655.15249-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Unless you know what you're doing, switching to another branch to do
something then switching back could be confusing. Worse, you may even
forget that you're in the middle of something. By the time you realize,
you may have done a ton of work and it gets harder to go back.

The new option --ignore-in-progress is added to override this check.
However it's probably just safer to create a separate worktree for
that separate thing you want to work on and leave this worktree
alone (unless of course creating or preparing worktrees are not cheap).

--force is updated to also imply --ignore-in-progress because it is
supposed to be the "just do your things and don't bother me" option.
---
 builtin/checkout.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2aeaac092d..407ed8be94 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -24,6 +24,7 @@
 #include "tree.h"
 #include "tree-walk.h"
 #include "unpack-trees.h"
+#include "wt-status.h"
 #include "xdiff-interface.h"
 
 static const char * const checkout_usage[] = {
@@ -56,6 +57,7 @@ struct checkout_opts {
 	int accept_pathspec;
 	int switch_branch_doing_nothing_is_ok;
 	int only_merge_on_switching_branches;
+	int can_switch_when_in_progress;
 
 	const char *new_branch;
 	const char *new_branch_force;
@@ -1257,6 +1259,26 @@ static int checkout_branch(struct checkout_opts *opts,
 	    !new_branch_info->path)
 		die_expecting_a_branch(new_branch_info);
 
+	if (!opts->can_switch_when_in_progress) {
+		struct wt_status_state state;
+
+		memset(&state, 0, sizeof(state));
+		wt_status_get_state(the_repository, &state, 0);
+
+		if (state.merge_in_progress)
+			die(_("cannot switch branch while merging"));
+		if (state.am_in_progress)
+			die(_("cannot switch branch in the middle of an am session"));
+		if (state.rebase_interactive_in_progress || state.rebase_in_progress)
+			die(_("cannot switch branch while rebasing"));
+		if (state.cherry_pick_in_progress)
+			die(_("cannot switch branch while cherry-picking"));
+		if (state.revert_in_progress)
+			die(_("cannot switch branch while reverting"));
+		if (state.bisect_in_progress)
+			die(_("cannot switch branch while bisecting"));
+	}
+
 	if (new_branch_info->path && !opts->force_detach && !opts->new_branch &&
 	    !opts->ignore_other_worktrees) {
 		int flag;
@@ -1371,8 +1393,10 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 		opts->merge = 1; /* implied */
 		git_xmerge_config("merge.conflictstyle", opts->conflict_style, NULL);
 	}
-	if (opts->force)
+	if (opts->force) {
 		opts->discard_changes = 1;
+		opts->can_switch_when_in_progress = 1;
+	}
 
 	if ((!!opts->new_branch + !!opts->new_branch_force + !!opts->new_orphan_branch) > 1)
 		die(_("-b, -B and --orphan are mutually exclusive"));
@@ -1514,6 +1538,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	opts.only_merge_on_switching_branches = 0;
 	opts.accept_pathspec = 1;
 	opts.implicit_detach = 1;
+	opts.can_switch_when_in_progress = 1;
 
 	options = parse_options_dup(checkout_options);
 	options = add_common_options(&opts, options);
@@ -1539,6 +1564,8 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 			 N_("second guess 'git switch <no-such-branch>'")),
 		OPT_BOOL(0, "discard-changes", &opts.discard_changes,
 			 N_("throw away local modifications")),
+		OPT_BOOL(0, "ignore-in-progress", &opts.can_switch_when_in_progress,
+			 N_("allow to switch branch when some operation is still in progress")),
 		OPT_END()
 	};
 	int ret;
@@ -1549,6 +1576,7 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 	opts.switch_branch_doing_nothing_is_ok = 0;
 	opts.only_merge_on_switching_branches = 1;
 	opts.implicit_detach = 0;
+	opts.can_switch_when_in_progress = 0;
 
 	options = parse_options_dup(switch_options);
 	options = add_common_options(&opts, options);
-- 
2.21.0.548.gd3c7d92dc2

