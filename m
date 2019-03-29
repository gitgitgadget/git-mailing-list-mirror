Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D0E520248
	for <e@80x24.org>; Fri, 29 Mar 2019 10:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbfC2KmP (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 06:42:15 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32779 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728737AbfC2KmO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 06:42:14 -0400
Received: by mail-pf1-f194.google.com with SMTP id i19so885753pfd.0
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 03:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7ZcVL7brvqiqFsL2UrpEdJTk/Z9/fjdMgWBg5J+r68o=;
        b=IJhGcPB+QN3DdoizBEzu4jVBcnBSmfehpzt1JVAeH+1bHl/QCfu4Zh26Pat7W+YCkz
         xfXtt2JVt+N8Ldxnmbr61q4JEHSxdrKIjeJbbnywiftVRINuqLN0EDJcUFWkTP8kPJHy
         WTnl7qpt1xJgbf7QwnpcUnu6tczAYxfBdDOicdqGq6jRPM6pzm/8FgGbBmG8Czh/KmI0
         5AGzjz4U3F4ISxFqhtrVASAFGtCnJzqdwd6PGTl6Zxd4ATypyrUhJYAD0bzA44cdU8Pt
         cLftsT0F20Ex8rxABZKtRJGs+eqZA7iIqEboCqKdHRm1jdkWDXuQ59Hw+xkjEkQ6KQMW
         5fRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7ZcVL7brvqiqFsL2UrpEdJTk/Z9/fjdMgWBg5J+r68o=;
        b=Y2HekgJe3pjsoMAfQrCtKf4z9KUQ1Xm+oNkohXor5edH/dCGNXeRKxelTwNdc/4+Hv
         /M0m15fMH1Fh9UKq5PANwUqsWC2kwTr5E71XjE8E/kZJxw+eXsI5bEynVrg4qykmZflT
         raDD2p5ZOfnaWh3AF8CAMRG2oSHSPQidFgikiSbmDwPaF3qQI1Nm9W1AcBagICJ2ZOsv
         vEc681eDBCIcM1iDdwuHfvS6nIN1HJv5IQkfy48MF7hkcJFytb+1/XfTcZ4q1+eQmhh0
         CYE4BJsBRiMR8E0j40cjDFWSXwmSXYBRV1+M09Ce1BN5Mpe7lGKrL5hTiDoXFCeXTYJ2
         zGwQ==
X-Gm-Message-State: APjAAAVXkWP4w9txSVPkKoEcRmxijfk8E/fFuJS6wBQUAHgrQ6zZJnBE
        1xh5IZqtIFYopJS2ybuaf3s=
X-Google-Smtp-Source: APXvYqxpF9NpD79SrjDPUOk4Ypm8t70zMSTKOLr7v5vV2A9+94Mm2A/YwIA35JiXO/kh2pnW2E55Og==
X-Received: by 2002:a65:5249:: with SMTP id q9mr24365128pgp.104.1553856133411;
        Fri, 29 Mar 2019 03:42:13 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id k72sm4328667pfb.122.2019.03.29.03.42.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 03:42:12 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 29 Mar 2019 17:42:07 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     eckhard.s.maass@googlemail.com, git@vger.kernel.org,
        gitster@pobox.com, jacob.keller@gmail.com, martin.agren@gmail.com,
        newren@gmail.com, phillip.wood123@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v6 23/27] switch: reject if some operation is in progress
Date:   Fri, 29 Mar 2019 17:39:15 +0700
Message-Id: <20190329103919.15642-24-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190329103919.15642-1-pclouds@gmail.com>
References: <20190321131655.15249-1-pclouds@gmail.com>
 <20190329103919.15642-1-pclouds@gmail.com>
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

A new option --ignore-in-progress was considered but dropped because it
was not exactly clear what should happen. Sometimes you can switch away
and get back safely and resume the operation. Sometimes not. And the
git-checkout behavior is automatically clear merge/revert/cherry-pick,
which makes it a bit even more confusing [1].

We may revisit and add this option in the future. But for now play it
safe and not allow it (you can't even skip this check with --force). The
user is suggested to cancel the operation by themselves (and hopefully
they do consider the consequences, not blindly type the command), or to
create a separate worktree instead of switching. The third option is
the good old "git checkout", but it's not mentioned.

[1] CACsJy8Axa5WsLSjiscjnxVK6jQHkfs-gH959=YtUvQkWriAk5w@mail.gmail.com

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index f7967cdb7c..5f100c1552 100644
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
@@ -1202,6 +1204,39 @@ static void die_expecting_a_branch(const struct branch_info *branch_info)
 	die(_("a branch is expected, got '%s'"), branch_info->name);
 }
 
+static void die_if_some_operation_in_progress(void)
+{
+	struct wt_status_state state;
+
+	memset(&state, 0, sizeof(state));
+	wt_status_get_state(the_repository, &state, 0);
+
+	if (state.merge_in_progress)
+		die(_("cannot switch branch while merging\n"
+		      "Consider \"git merge --quit\" "
+		      "or \"git worktree add\"."));
+	if (state.am_in_progress)
+		die(_("cannot switch branch in the middle of an am session\n"
+		      "Consider \"git am --quit\" "
+		      "or \"git worktree add\"."));
+	if (state.rebase_interactive_in_progress || state.rebase_in_progress)
+		die(_("cannot switch branch while rebasing\n"
+		      "Consider \"git rebase --quit\" "
+		      "or \"git worktree add\"."));
+	if (state.cherry_pick_in_progress)
+		die(_("cannot switch branch while cherry-picking\n"
+		      "Consider \"git cherry-pick --quit\" "
+		      "or \"git worktree add\"."));
+	if (state.revert_in_progress)
+		die(_("cannot switch branch while reverting\n"
+		      "Consider \"git revert --quit\" "
+		      "or \"git worktree add\"."));
+	if (state.bisect_in_progress)
+		die(_("cannot switch branch while bisecting\n"
+		      "Consider \"git bisect reset HEAD\" "
+		      "or \"git worktree add\"."));
+}
+
 static int checkout_branch(struct checkout_opts *opts,
 			   struct branch_info *new_branch_info)
 {
@@ -1257,6 +1292,9 @@ static int checkout_branch(struct checkout_opts *opts,
 	    !new_branch_info->path)
 		die_expecting_a_branch(new_branch_info);
 
+	if (!opts->can_switch_when_in_progress)
+		die_if_some_operation_in_progress();
+
 	if (new_branch_info->path && !opts->force_detach && !opts->new_branch &&
 	    !opts->ignore_other_worktrees) {
 		int flag;
@@ -1514,6 +1552,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	opts.only_merge_on_switching_branches = 0;
 	opts.accept_pathspec = 1;
 	opts.implicit_detach = 1;
+	opts.can_switch_when_in_progress = 1;
 
 	options = parse_options_dup(checkout_options);
 	options = add_common_options(&opts, options);
@@ -1549,6 +1588,7 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 	opts.switch_branch_doing_nothing_is_ok = 0;
 	opts.only_merge_on_switching_branches = 1;
 	opts.implicit_detach = 0;
+	opts.can_switch_when_in_progress = 0;
 
 	options = parse_options_dup(switch_options);
 	options = add_common_options(&opts, options);
-- 
2.21.0.479.g47ac719cd3

