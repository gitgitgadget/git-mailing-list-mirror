Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 386711F453
	for <e@80x24.org>; Tue, 22 Jan 2019 21:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfAVVWY (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 16:22:24 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:36656 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfAVVWV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 16:22:21 -0500
Received: by mail-ed1-f46.google.com with SMTP id f23so15319edb.3
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 13:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rQ4GdGkyd4/PsxgqGvgoHLx4Oj+GdfCib9XYaCvyPIo=;
        b=sz1jJAmhTeGtqedRxCE9cIRHqZLWEEnyITpSGDgg8bTq2Zlj/YxKeLx1P10OL5JUOQ
         /Ija2gKNPJ+IOelcplZFzXWfb/CHywPNd9+H8htO7LEv9ckpzyy/IJaa4eNyKuIj8MvL
         l+t6PuQlTLBuCa6w//FgA5bzsw9Y5/dAv3PyoowQPsllF5sukc0BGusNXF1nTY7sUtWF
         7uqaQHfPZFzoUY4fav62mV5BX46v3zhzeo5KdYunCY49eTVetrm/PwDh0Bajfon1EYFj
         jvn3JisTYsjdBcAdWvl4rS6vdHGkRfjVSMXQpwvIcQD//hdWpQAK6OLaYCsgHZiRCAvv
         YV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rQ4GdGkyd4/PsxgqGvgoHLx4Oj+GdfCib9XYaCvyPIo=;
        b=Mp+qBFsZuKrxXF5MBo0IPD+xoGFyuPv7Tp6lMhc58sQoNcTcaLATcdkipndteTlXSv
         T/SnvNtLdD+fiXQUVJ/gtd/trz9InBZZd3BzXxtmk4xvMn51qFItzbseJ0wEFCrIywSD
         I/m100s8ImWivq/xB4FDHuFmlFMslTxEWcevRjnUvCelEnT4TDHY3MFB0gqFcQyhMi/e
         8QFWjH5czhibgTjnI0uDqvpRSBvM1etlYFDPOD0ea4vbYl/LgwJqIdNkKJat2VN0SC0e
         7A9zXxVubwHS5fIBAPFG8u9Je5taXlFowZwFWjPzlm/xFH4SUu611R45EEzextOibaW7
         /zUA==
X-Gm-Message-State: AJcUukclFxMZSEQF7F/y5N2gMff/TUNK+jfQRkieDrGWhxIPg9YfAQas
        nfRPYgViT1+XGG2UOkisqKVY3XWK
X-Google-Smtp-Source: ALg8bN4jMu0Wx43Y39AWDJ43nF2Aa3QS1mKnRqSASQIvLW8bbEBWCPOrPvB+SCG39De5I8L1ymwUEg==
X-Received: by 2002:a17:906:1c5b:: with SMTP id l27-v6mr124948ejg.118.1548192139552;
        Tue, 22 Jan 2019 13:22:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c11-v6sm5419155ejz.70.2019.01.22.13.22.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 13:22:19 -0800 (PST)
Date:   Tue, 22 Jan 2019 13:22:19 -0800 (PST)
X-Google-Original-Date: Tue, 22 Jan 2019 21:22:05 GMT
Message-Id: <0f8f366bbebcb89e794425e4d557c6cf107f6f8a.1548192131.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.git.gitgitgadget@gmail.com>
References: <pull.108.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 08/14] trace2:data: add trace2 hook classification
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Classify certain child processes as hooks.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/am.c           | 1 +
 builtin/receive-pack.c | 4 ++++
 builtin/worktree.c     | 1 +
 sequencer.c            | 2 ++
 transport.c            | 1 +
 5 files changed, 9 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index 95370313b6..a81e61c1bc 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -468,6 +468,7 @@ static int run_post_rewrite_hook(const struct am_state *state)
 
 	cp.in = xopen(am_path(state, "rewritten"), O_RDONLY);
 	cp.stdout_to_stderr = 1;
+	cp.trace2_hook_name = "post-rewrite";
 
 	ret = run_command(&cp);
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 33187bd8e9..6eef8575b9 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -694,6 +694,8 @@ static int run_and_feed_hook(const char *hook_name, feed_fn feed,
 	proc.argv = argv;
 	proc.in = -1;
 	proc.stdout_to_stderr = 1;
+	proc.trace2_hook_name = hook_name;
+
 	if (feed_state->push_options) {
 		int i;
 		for (i = 0; i < feed_state->push_options->nr; i++)
@@ -807,6 +809,7 @@ static int run_update_hook(struct command *cmd)
 	proc.stdout_to_stderr = 1;
 	proc.err = use_sideband ? -1 : 0;
 	proc.argv = argv;
+	proc.trace2_hook_name = "update";
 
 	code = start_command(&proc);
 	if (code)
@@ -1190,6 +1193,7 @@ static void run_update_post_hook(struct command *commands)
 	proc.no_stdin = 1;
 	proc.stdout_to_stderr = 1;
 	proc.err = use_sideband ? -1 : 0;
+	proc.trace2_hook_name = "post-update";
 
 	if (!start_command(&proc)) {
 		if (use_sideband)
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 5e84026177..32e6f1b341 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -401,6 +401,7 @@ static int add_worktree(const char *path, const char *refname,
 			cp.dir = path;
 			cp.env = env;
 			cp.argv = NULL;
+			cp.trace2_hook_name = "post-checkout";
 			argv_array_pushl(&cp.args, absolute_path(hook),
 					 oid_to_hex(&null_oid),
 					 oid_to_hex(&commit->object.oid),
diff --git a/sequencer.c b/sequencer.c
index b68bca0bef..9a6ec7fcd4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1102,6 +1102,7 @@ static int run_rewrite_hook(const struct object_id *oldoid,
 	proc.argv = argv;
 	proc.in = -1;
 	proc.stdout_to_stderr = 1;
+	proc.trace2_hook_name = "post-rewrite";
 
 	code = start_command(&proc);
 	if (code)
@@ -3771,6 +3772,7 @@ static int pick_commits(struct repository *r,
 				hook.in = open(rebase_path_rewritten_list(),
 					O_RDONLY);
 				hook.stdout_to_stderr = 1;
+				hook.trace2_hook_name = "post-rewrite";
 				argv_array_push(&hook.args, post_rewrite_hook);
 				argv_array_push(&hook.args, "rebase");
 				/* we don't care if this hook failed */
diff --git a/transport.c b/transport.c
index 99678153c1..ed5a733c4a 100644
--- a/transport.c
+++ b/transport.c
@@ -1061,6 +1061,7 @@ static int run_pre_push_hook(struct transport *transport,
 
 	proc.argv = argv;
 	proc.in = -1;
+	proc.trace2_hook_name = "pre-push";
 
 	if (start_command(&proc)) {
 		finish_command(&proc);
-- 
gitgitgadget

