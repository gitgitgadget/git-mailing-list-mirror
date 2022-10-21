Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873FFC433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 09:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiJUJWF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 05:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiJUJV5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 05:21:57 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D622565FD
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 02:21:56 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id b4so3938086wrs.1
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 02:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNOWMl9EcaK5ZRazLD58gGlH6HzJEyYziWhujACWvKo=;
        b=WBs6Vnwah0g3sZFK+d2z87qKWvsN3XOALxaO0DtP/HdD12BO5/LdrNKICi3ajLH10f
         AOcNM0Emz/LVv+XWuvHy9ohX1VF+9CSC2gkpqVyp7UC3v/eukIbTRaZIRa9QnW5UzEuF
         LwVPFUoPvf7G8kfnijTE146ibrcEkoe4qykoiF7qFT/uM+HewNtGXglDBO4UW4zXc+w5
         fD32TjfukEzQKVbW0AYP32SnPfbUxHO8dd0ptfuA1DMb2BFipppvoPzZBvzdWHqj1OlW
         BzTpRto28q4bQIUCi5KpKGMm1c8WI/YhH7jcfwoXJP/UhMIgsXoqsP3ckEhdctJOu8nQ
         mzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iNOWMl9EcaK5ZRazLD58gGlH6HzJEyYziWhujACWvKo=;
        b=la8wYhUMcWFMLUUS1IrkF9wVFZ2HYPKDF97LKZ8NQLk/cP4oN8HeZSv7OLeLBbwX0g
         WHX/3Yb5TDua+/dUMWOCbk5W+QMzyl2TG5JDWQj9Y/mUlLvKbKWjkZPH8R+SjdupODPi
         Tahaa6r9K7yY/9Jkruo19jTbwwOTeLyjDqyLskVZFjoJBafO5842XWyTqroT2auBzhal
         kPg+SbK83Ch0193tFBenXQCJCEag0FdnJ+gXKY6viltgdI7RI7lnNFvPMmEAWcpgEJnJ
         CMf7sMIND2jwLjHbisXBJ1dGraKfv8/k4Yps/q+rLsKUuShQom36tcnG+RQG6krTLThj
         Ofaw==
X-Gm-Message-State: ACrzQf0a1mxwye4Jge+Sdtw2c0/Rt0+zHkbsNE9lb6O23027WLBdkHcJ
        pmazTPQybThoY/bGQy6IqeAcX4tSLZo=
X-Google-Smtp-Source: AMsMyM7utX4HHyFTmeTAyc/vSkULkagSoQFyuVt0K29kCA5YKb1kl0vkeiVov+58KcACM7ohXAi0Bw==
X-Received: by 2002:adf:dd88:0:b0:236:57e3:fc86 with SMTP id x8-20020adfdd88000000b0023657e3fc86mr327974wrl.493.1666344114236;
        Fri, 21 Oct 2022 02:21:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o14-20020a1c750e000000b003b4cba4ef71sm2127916wmc.41.2022.10.21.02.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 02:21:53 -0700 (PDT)
Message-Id: <2c965f4b97c1773abc6b844b87fa64c5d6d1524c.1666344108.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1150.v4.git.1666344108.gitgitgadget@gmail.com>
References: <pull.1150.v3.git.1665567312.gitgitgadget@gmail.com>
        <pull.1150.v4.git.1666344108.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Oct 2022 09:21:43 +0000
Subject: [PATCH v4 3/8] rebase --merge: fix reflog when continuing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The reflog message for a conflict resolution committed by "rebase
--continue" looks like

	rebase (continue): commit subject line

Unfortunately the reflog message each subsequent pick look like

	rebase (continue) (pick): commit subject line

Fix this by setting the reflog message for "rebase --continue" in
sequencer_continue() so it does not affect subsequent commits. This
introduces a memory leak similar to the one leaking GIT_REFLOG_ACTION
in pick_commits(). Both of these will be fixed in a future series that
stops the sequencer calling setenv().

If we fail to commit the staged changes then we error out so
GIT_REFLOG_ACTION does not need to be reset in that case.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c          | 2 --
 sequencer.c               | 5 +++++
 t/t3406-rebase-message.sh | 9 +++++++--
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index e67020b3586..414526f83a8 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1271,8 +1271,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		int fd;
 
 		options.action = "continue";
-		set_reflog_action(&options);
-
 		/* Sanity check */
 		if (get_oid("HEAD", &head))
 			die(_("Cannot read HEAD"));
diff --git a/sequencer.c b/sequencer.c
index 61a8e0020d5..5790b35d763 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4785,6 +4785,8 @@ int sequencer_continue(struct repository *r, struct replay_opts *opts)
 	if (read_populate_opts(opts))
 		return -1;
 	if (is_rebase_i(opts)) {
+		char *previous_reflog_action;
+
 		if ((res = read_populate_todo(r, &todo_list, opts)))
 			goto release_todo_list;
 
@@ -4795,10 +4797,13 @@ int sequencer_continue(struct repository *r, struct replay_opts *opts)
 			unlink(rebase_path_dropped());
 		}
 
+		previous_reflog_action = xstrdup(getenv(GIT_REFLOG_ACTION));
+		setenv(GIT_REFLOG_ACTION, reflog_message(opts, "continue", NULL), 1);
 		if (commit_staged_changes(r, opts, &todo_list)) {
 			res = -1;
 			goto release_todo_list;
 		}
+		setenv(GIT_REFLOG_ACTION, previous_reflog_action, 1);
 	} else if (!file_exists(get_todo_path(opts)))
 		return continue_single_pick(r, opts);
 	else if ((res = read_populate_todo(r, &todo_list, opts)))
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index 5253dd1551d..3ca2fbb0d59 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -17,6 +17,7 @@ test_expect_success 'setup' '
 
 	git checkout -b conflicts O &&
 	test_commit P &&
+	test_commit conflict-X fileX &&
 	test_commit Q &&
 
 	git checkout -b topic O &&
@@ -107,13 +108,17 @@ test_reflog () {
 			GIT_REFLOG_ACTION="$reflog_action" &&
 			export GIT_REFLOG_ACTION
 		fi &&
-		git rebase $mode main
+		test_must_fail git rebase $mode main &&
+		echo resolved >fileX &&
+		git add fileX &&
+		git rebase --continue
 	) &&
 
-	git log -g --format=%gs -4 >actual &&
+	git log -g --format=%gs -5 >actual &&
 	write_reflog_expect <<-EOF &&
 	${reflog_action:-rebase} (finish): returning to refs/heads/conflicts
 	${reflog_action:-rebase} (pick): Q
+	${reflog_action:-rebase} (continue): conflict-X
 	${reflog_action:-rebase} (pick): P
 	${reflog_action:-rebase} (start): checkout main
 	EOF
-- 
gitgitgadget

