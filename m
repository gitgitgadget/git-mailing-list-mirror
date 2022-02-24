Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6059CC433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 16:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiBXQoY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 11:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiBXQoX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 11:44:23 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0370F141FD9
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 08:43:53 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id g20so3685360edw.6
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 08:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AuMM1r/4Ib1W/wFtepaXYNrwWV86bDZdy7Jlz5E6r4U=;
        b=A0s76mO0VGu2raG0wm9Yon7Gv6pXV9v5/gXQIMnmQJOa2nA1U82RhpuC126roD0dpc
         wO9s4XCISNsZnL4xqi6UPhjPCRWuElRMGrSembGftGec+8jyk460wMg1Du/T/Pf/dkO5
         t0ICW7lcQxA3IU+wpBGOaYGVMZT3aM62Qfv3sTZGu/vZ2rm7I00wAcS5vF4faSIih/ep
         QaELAan8wJOAWifjTDv/smqlUnsA8pACBfAVTeIi1alS3jiTdUOzILfftsTvIwmngakJ
         MQWgrpCBx6jfnmrb76l4I6O+LrawHDnq5LqEU0l6QX2UwyItgDWO7z2P5UQRnO0NIWGy
         IkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AuMM1r/4Ib1W/wFtepaXYNrwWV86bDZdy7Jlz5E6r4U=;
        b=pLHXpm4HOx8/rl2Rlb/G4z3Ej1JkpRW/l+9PYE/cq+Kp3IhYxB5kO0Rhal8jddYNh/
         C0OkDCjasWrfmp/HnkdOZrxsvZ2DIuR5yvkMLGXD1qrNQR9TuWuIuf0t4sejseClL8hG
         O/LF+vz4VXPtB3XTLBAYGGsbyaRaOSfX1gXXeBf5WYvHEnvD08s4X7tde/9NdxeIouFD
         PvCARQwqAPKOIvcrpbveE9Y5UcTnAhwxy6iDZ0Q6+MU5XRepHmKUkOVf8/VrwSy/Ml4p
         4kVOiJbHuHWr+D2a3jMAdYIaOe5J03phKXTDm6Lp8J0LJrpUvgSeacmnfj7AyYqZvdMI
         y3tw==
X-Gm-Message-State: AOAM532xmEKj18j5OI7pjEZqxLonW6ZTJNUVN9qndY/nvU+rigNBt63V
        0mWK32589E0LuVxCsE5X+TlJWxiEYU8=
X-Google-Smtp-Source: ABdhPJxyt0pmFHpJja2G3TYxQc9/vb0A/x6nes4CPkEMMNPIwVuhMVB6snW+YroRhaErx7FQF36K0g==
X-Received: by 2002:a5d:6f0f:0:b0:1e5:78e4:3a7a with SMTP id ay15-20020a5d6f0f000000b001e578e43a7amr2828766wrb.446.1645719225362;
        Thu, 24 Feb 2022 08:13:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 14sm3989716wrb.34.2022.02.24.08.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 08:13:44 -0800 (PST)
Message-Id: <cfa6dca8ef4a64b6233e3b7b6021571447fc5ba9.1645719218.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1138.v2.git.1645719218.gitgitgadget@gmail.com>
References: <pull.1138.git.1643730593.gitgitgadget@gmail.com>
        <pull.1138.v2.git.1645719218.gitgitgadget@gmail.com>
From:   "Robert Coup via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Feb 2022 16:13:36 +0000
Subject: [PATCH v2 6/8] maintenance: add ability to pass config options
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Robert Coup <robert@coup.net.nz>,
        Robert Coup <robert@coup.net.nz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Robert Coup <robert@coup.net.nz>

Make run_auto_maintenance() accept optional config options for a
specific invocation of the auto-maintenance process.

Signed-off-by: Robert Coup <robert@coup.net.nz>
---
 builtin/am.c     | 2 +-
 builtin/commit.c | 2 +-
 builtin/fetch.c  | 2 +-
 builtin/merge.c  | 2 +-
 builtin/rebase.c | 2 +-
 run-command.c    | 8 +++++++-
 run-command.h    | 5 ++++-
 7 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 7de2c89ef22..298c6093bff 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1899,7 +1899,7 @@ next:
 	 */
 	if (!state->rebasing) {
 		am_destroy(state);
-		run_auto_maintenance(state->quiet);
+		run_auto_maintenance(state->quiet, NULL);
 	}
 }
 
diff --git a/builtin/commit.c b/builtin/commit.c
index b9ed0374e30..84e7ab0a4cc 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1844,7 +1844,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	git_test_write_commit_graph_or_die();
 
 	repo_rerere(the_repository, 0);
-	run_auto_maintenance(quiet);
+	run_auto_maintenance(quiet, NULL);
 	run_commit_hook(use_editor, get_index_file(), "post-commit", NULL);
 	if (amend && !no_post_rewrite) {
 		commit_post_rewrite(the_repository, current_head, &oid);
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 8e5e590dd6e..f32b24d182b 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2227,7 +2227,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	}
 
 	if (enable_auto_gc)
-		run_auto_maintenance(verbosity < 0);
+		run_auto_maintenance(verbosity < 0, NULL);
 
  cleanup:
 	string_list_clear(&list, 0);
diff --git a/builtin/merge.c b/builtin/merge.c
index a94a03384ae..8d3e6d0de03 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -472,7 +472,7 @@ static void finish(struct commit *head_commit,
 			 * We ignore errors in 'gc --auto', since the
 			 * user should see them.
 			 */
-			run_auto_maintenance(verbosity < 0);
+			run_auto_maintenance(verbosity < 0, NULL);
 		}
 	}
 	if (new_head && show_diffstat) {
diff --git a/builtin/rebase.c b/builtin/rebase.c
index d858add3fe8..cbab6c05373 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -552,7 +552,7 @@ static int finish_rebase(struct rebase_options *opts)
 	 * We ignore errors in 'git maintenance run --auto', since the
 	 * user should see them.
 	 */
-	run_auto_maintenance(!(opts->flags & (REBASE_NO_QUIET|REBASE_VERBOSE)));
+	run_auto_maintenance(!(opts->flags & (REBASE_NO_QUIET|REBASE_VERBOSE)), NULL);
 	if (opts->type == REBASE_MERGE) {
 		struct replay_opts replay = REPLAY_OPTS_INIT;
 
diff --git a/run-command.c b/run-command.c
index a8501e38ceb..720fd7820c8 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1798,9 +1798,10 @@ int run_processes_parallel_tr2(int n, get_next_task_fn get_next_task,
 	return result;
 }
 
-int run_auto_maintenance(int quiet)
+int run_auto_maintenance(int quiet, const struct strvec *config_opts)
 {
 	int enabled;
+	int i;
 	struct child_process maint = CHILD_PROCESS_INIT;
 
 	if (!git_config_get_bool("maintenance.auto", &enabled) &&
@@ -1809,6 +1810,11 @@ int run_auto_maintenance(int quiet)
 
 	maint.git_cmd = 1;
 	maint.close_object_store = 1;
+
+	if (config_opts)
+		for (i = 0; i<config_opts->nr; i++)
+			strvec_pushl(&maint.args, "-c", config_opts->v[i], NULL);
+
 	strvec_pushl(&maint.args, "maintenance", "run", "--auto", NULL);
 	strvec_push(&maint.args, quiet ? "--quiet" : "--no-quiet");
 
diff --git a/run-command.h b/run-command.h
index 07bed6c31b4..24021abd41f 100644
--- a/run-command.h
+++ b/run-command.h
@@ -222,8 +222,11 @@ int run_command(struct child_process *);
 
 /*
  * Trigger an auto-gc
+ *
+ * config_opts is an optional list of additional config options to
+ * pass to the maintenance process in the form "some.option=value".
  */
-int run_auto_maintenance(int quiet);
+int run_auto_maintenance(int quiet, const struct strvec *config_opts);
 
 #define RUN_COMMAND_NO_STDIN		(1<<0)
 #define RUN_GIT_CMD			(1<<1)
-- 
gitgitgadget

