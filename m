Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C1AC20248
	for <e@80x24.org>; Sun, 17 Mar 2019 12:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfCQMvz (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 08:51:55 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46991 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfCQMvz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 08:51:55 -0400
Received: by mail-pg1-f196.google.com with SMTP id a22so9472765pgg.13
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 05:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GOx4UoPFCyKiNXT8A/uNJ7sDA6lJz4O11qi75Xdu0+M=;
        b=kTU2b9fAHpDUr2CCxy6YCQqIOYvh2nrzj5/obQhsDrF4pWvOq87G5LVl+bx4I3hj7p
         95SHpJ21prO2eJJpI/VQPnvTGeIHvTCeTH4Vem5W+TZ33Vwua9JJnjxwnDivO6WSFI/H
         cdz5B6mndvtwVkngLfXXSh+ZYl0d3JXppn58WcmpiqvvRVxy45roT0nEmUb05QirrNzj
         NtpQQ184QJDwUCBmLBYJnPsMxLcsGNbtJDB8xQ7Ne1ocyMkUWQOKCXfJJSIcemtcaB2a
         WnVIpoq3mBdNyT7jYf7VsADsXV9wyy8bIplawOj8tTZE3R14x/TSHAdaQr5lR8XEjGlu
         tZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GOx4UoPFCyKiNXT8A/uNJ7sDA6lJz4O11qi75Xdu0+M=;
        b=Ux832LxB2gh1LnUhpPXnmdbmPvfzQsZcGCBxzhy3jqBOK+573wg5wMk311U2R/cx5I
         kPElHSG0gw7Re5NTQn6+qxvkPYbij06hr5N7cGQ9ygbUDAPjPmL9G6dS9bG8YSVISHS7
         84GLL4K7wPX8UGAlwtV1+rKJeUSWpVEZxNtFVffNFHCnDZF/Uh8hfj5PCDZiY47Vzzju
         ohBdo+ZHnOrtS5Y2ydAC+ayXi7oJHcN3SfPIH6YdoatFCwd23nWK2vdX6He6ynL/rmdO
         Lhmltd48jceT0XkXeNLbRC5cIipkbnz/JDqQoVUCY4rb+VenyfBWDTsBv+UE308cIqQL
         SqwQ==
X-Gm-Message-State: APjAAAUmZj9+jBX/AqnEUJggP1jtqM8W7/mX3Dxr44pVlkrRR6uY1Y09
        N1QiB7OmJMU9vOjMOInh1R0=
X-Google-Smtp-Source: APXvYqycXJq0W0zF+CQvx1t8QsekaKO4nQiT7z8OsTCHDXjvEOAp/yTbepVLUREpQzzBy5rRfY6gaQ==
X-Received: by 2002:a62:415d:: with SMTP id o90mr8426222pfa.236.1552827114246;
        Sun, 17 Mar 2019 05:51:54 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id g2sm19151992pfm.144.2019.03.17.05.51.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 05:51:53 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 17 Mar 2019 19:51:48 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com, Elijah Newren <newren@gmail.com>,
        eckhard.s.maass@googlemail.com,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        jacob.keller@gmail.com, phillip.wood123@gmail.com,
        rybak.a.v@gmail.com
Subject: [PATCH v4 22/26] switch: reject if some operation is in progress
Date:   Sun, 17 Mar 2019 19:49:22 +0700
Message-Id: <20190317124926.17137-23-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190317124926.17137-1-pclouds@gmail.com>
References: <20190308095752.8574-1-pclouds@gmail.com>
 <20190317124926.17137-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2aeaac092d..21a585eaa9 100644
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
+		if (state.rebase_in_progress || state.rebase_in_progress)
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
@@ -1514,6 +1536,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	opts.only_merge_on_switching_branches = 0;
 	opts.accept_pathspec = 1;
 	opts.implicit_detach = 1;
+	opts.can_switch_when_in_progress = 1;
 
 	options = parse_options_dup(checkout_options);
 	options = add_common_options(&opts, options);
@@ -1539,6 +1562,8 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 			 N_("second guess 'git switch <no-such-branch>'")),
 		OPT_BOOL(0, "discard-changes", &opts.discard_changes,
 			 N_("throw away local modifications")),
+		OPT_BOOL(0, "ignore-in-progress", &opts.can_switch_when_in_progress,
+			 N_("allow to switch branch when some operation is still in progress")),
 		OPT_END()
 	};
 	int ret;
@@ -1549,6 +1574,7 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 	opts.switch_branch_doing_nothing_is_ok = 0;
 	opts.only_merge_on_switching_branches = 1;
 	opts.implicit_detach = 0;
+	opts.can_switch_when_in_progress = 0;
 
 	options = parse_options_dup(switch_options);
 	options = add_common_options(&opts, options);
-- 
2.21.0.548.gd3c7d92dc2

