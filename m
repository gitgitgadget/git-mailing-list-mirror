Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A7631F4C0
	for <e@80x24.org>; Thu, 10 Oct 2019 18:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfJJSgx (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 14:36:53 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52303 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbfJJSgx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 14:36:53 -0400
Received: by mail-wm1-f65.google.com with SMTP id r19so7994787wmh.2
        for <git@vger.kernel.org>; Thu, 10 Oct 2019 11:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FIgFkf3vQsjO6QJAlf6Dl+CB3wuo1U1NElt8epvcWNI=;
        b=dd8RsJNslzcbBQ0I9Kn3E63Bg8PQ9iL6jlVhfJErj+piaiQm4chITHpt0xFNabBoix
         P+LOtzwRwsCzzSe7iWmbEX4xWwXGLjnN0aouaVR4H0rgXnTLsgm1sgKfW8RLpXn0ymWY
         sqgzE1QB8XZtQBD0JgII5sTPUi8MSbPnq7n9q+SVdKL4nbWB4iOdGYFVKbOSyojujJFm
         OpxujHLI78XlwooXnZcUGb+M6p4667WKlGRhwLS8e4NAz4NwCgwhqZuJqgLpjc7Vh7Eq
         KQTwMv9I10rYlenXElNWjVcHXzq56t6RdtXqB1j/WrlNf+Aelefu/AZEWjjfA1OgloPq
         ZD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FIgFkf3vQsjO6QJAlf6Dl+CB3wuo1U1NElt8epvcWNI=;
        b=CN4wkEM9fGJFoHUZg8zYpG5oEqaXqbI/yjsi3HdQzegIqYWewrkWXRzhPRCJ8iZv3H
         PbWAfnHuzMJFJ7o6A4ynoDKgNHK2634hoNjGqAUuu4oVrpvGhHPfc1LesSC+E/ao1e9x
         HlDmBdXnnoJcAAwCN3RH/AD4TpinU0YL5+NtqB1iNsSc/IKj/UH+ZccHB4exe8AtW1ah
         NHM2a0Po1rtxrqFA53e4JI3on41yoJCgJdnVNakF5jAk1otzG4wi4unNgkkM8G2yv5lc
         f8RGahHMpAU46oBs+0qP3gT/hwXq0gO37HCt5Rxv82k/u6MSbIDtL8khYvEyTlGd/bGP
         SHqw==
X-Gm-Message-State: APjAAAWAbhpbnGhGMkKaumHbUNcw2fb2ePhxoMw1a+wzMP0sNJ79EWfq
        I6Ys30rfHPPnPuhZZ94LrxUkVGlQ
X-Google-Smtp-Source: APXvYqxD2K5sf7ZL+HBVzZceOq8CvP8I5Ltv62r6BUnLfN3As+rppWCAp4Pp5rolM+WTKubXt0LuSg==
X-Received: by 2002:a7b:c947:: with SMTP id i7mr8901807wml.53.1570732611268;
        Thu, 10 Oct 2019 11:36:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z22sm6379769wmf.2.2019.10.10.11.36.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 11:36:50 -0700 (PDT)
Date:   Thu, 10 Oct 2019 11:36:50 -0700 (PDT)
X-Google-Original-Date: Thu, 10 Oct 2019 18:36:47 GMT
Message-Id: <420ecf442c729878da5219f3c718dd136e4fa2b4.1570732608.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.388.git.gitgitgadget@gmail.com>
References: <pull.388.git.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/3] sequencer: use run_commit_hook()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This simplifies the implementation of run_prepare_commit_msg_hook() and
will be used in the next commit.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/commit.c | 22 ----------------------
 commit.h         |  3 ---
 sequencer.c      | 45 ++++++++++++++++++++++++++++++++++-----------
 sequencer.h      |  2 ++
 4 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 1921401117..d898a57f5d 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1443,28 +1443,6 @@ static int git_commit_config(const char *k, const char *v, void *cb)
 	return git_status_config(k, v, s);
 }
 
-int run_commit_hook(int editor_is_used, const char *index_file, const char *name, ...)
-{
-	struct argv_array hook_env = ARGV_ARRAY_INIT;
-	va_list args;
-	int ret;
-
-	argv_array_pushf(&hook_env, "GIT_INDEX_FILE=%s", index_file);
-
-	/*
-	 * Let the hook know that no editor will be launched.
-	 */
-	if (!editor_is_used)
-		argv_array_push(&hook_env, "GIT_EDITOR=:");
-
-	va_start(args, name);
-	ret = run_hook_ve(hook_env.argv,name, args);
-	va_end(args);
-	argv_array_clear(&hook_env);
-
-	return ret;
-}
-
 int cmd_commit(int argc, const char **argv, const char *prefix)
 {
 	const char *argv_gc_auto[] = {"gc", "--auto", NULL};
diff --git a/commit.h b/commit.h
index f5295ca7f3..37684a35f0 100644
--- a/commit.h
+++ b/commit.h
@@ -389,7 +389,4 @@ void verify_merge_signature(struct commit *commit, int verbose);
 int compare_commits_by_commit_date(const void *a_, const void *b_, void *unused);
 int compare_commits_by_gen_then_commit_date(const void *a_, const void *b_, void *unused);
 
-LAST_ARG_MUST_BE_NULL
-int run_commit_hook(int editor_is_used, const char *index_file, const char *name, ...);
-
 #endif /* COMMIT_H */
diff --git a/sequencer.c b/sequencer.c
index 2adcf5a639..3ce578c40b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1123,28 +1123,51 @@ void commit_post_rewrite(struct repository *r,
 	run_rewrite_hook(&old_head->object.oid, new_head);
 }
 
+int run_commit_hook(int editor_is_used, const char *index_file,
+		    const char *name, ...)
+{
+	struct argv_array hook_env = ARGV_ARRAY_INIT;
+	va_list args;
+	int ret;
+
+	argv_array_pushf(&hook_env, "GIT_INDEX_FILE=%s", index_file);
+
+	/*
+	 * Let the hook know that no editor will be launched.
+	 */
+	if (!editor_is_used)
+		argv_array_push(&hook_env, "GIT_EDITOR=:");
+
+	va_start(args, name);
+	ret = run_hook_ve(hook_env.argv,name, args);
+	va_end(args);
+	argv_array_clear(&hook_env);
+
+	return ret;
+}
+
 static int run_prepare_commit_msg_hook(struct repository *r,
 				       struct strbuf *msg,
 				       const char *commit)
 {
 	struct argv_array hook_env = ARGV_ARRAY_INIT;
-	int ret;
-	const char *name;
+	int ret = 0;
+	const char *name, *arg1 = NULL, *arg2 = NULL;
 
 	name = git_path_commit_editmsg();
 	if (write_message(msg->buf, msg->len, name, 0))
 		return -1;
 
-	argv_array_pushf(&hook_env, "GIT_INDEX_FILE=%s", r->index_file);
-	argv_array_push(&hook_env, "GIT_EDITOR=:");
-	if (commit)
-		ret = run_hook_le(hook_env.argv, "prepare-commit-msg", name,
-				  "commit", commit, NULL);
-	else
-		ret = run_hook_le(hook_env.argv, "prepare-commit-msg", name,
-				  "message", NULL);
-	if (ret)
+	if (commit) {
+		arg1 = "commit";
+		arg2 = commit;
+	} else {
+		arg1 = "message";
+	}
+	if (run_commit_hook(0, r->index_file, "prepare-commit-msg", name,
+			    arg1, arg2, NULL))
 		ret = error(_("'prepare-commit-msg' hook failed"));
+
 	argv_array_clear(&hook_env);
 
 	return ret;
diff --git a/sequencer.h b/sequencer.h
index ac66892d71..b0419d6ddb 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -201,4 +201,6 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
 void sequencer_post_commit_cleanup(struct repository *r);
 int sequencer_get_last_command(struct repository* r,
 			       enum replay_action *action);
+LAST_ARG_MUST_BE_NULL
+int run_commit_hook(int editor_is_used, const char *index_file, const char *name, ...);
 #endif /* SEQUENCER_H */
-- 
gitgitgadget

