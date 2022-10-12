Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02B5C43217
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 09:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbiJLJf0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 05:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiJLJfU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 05:35:20 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED203DBC4
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:35:18 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id r13so25350100wrj.11
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dwSI2JOAV5uK62X0arUbDystpACPly3g4ieSBxPwtSw=;
        b=ARVHxRPAgLH9GM70QVZxJY1RXH8E95CG1q4ZRxrD69+MVyomtPvoAZNxoXYS2FS++t
         FzuvwpTN3hSy5NVclmiU6D2DJTmCD88bLlvLZErYw6jT2bhkikAhW+bpa1JsJ26nghxr
         eS09eB1jkwmuZ4xX1amGa636uxwevoA2rY97Q8Sn6vPalHD96z2sGFU3Dfy07delzdS4
         8HfXUBL+UYbLJgkEEECfWgz7juNmUuexe8gYjNSK2fGeDa1K/5R3c62y53YYo163QeuO
         5QHPNzYQBEdnSD500851chkjNq8PeFh2LeL6hYutcnB0hrRKu/ZSDn/SydwqqMWdFgLE
         0Jyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dwSI2JOAV5uK62X0arUbDystpACPly3g4ieSBxPwtSw=;
        b=wc+hH+DnqGGiVYUtP2aJsNgp/a2mMpJZWOF3LVs62fpIfvyzD1kuVokRwtIYOB/0iW
         cMQ/bPzVXbGXuqJzk9iIawdYvwWjqM+iG8+3qTy623MBTrXLoM5aCccPIh9lsPNqI+fI
         4NHNGlsJl7Uii9VPJ8qfEXxncjEWax2YKRCJnwPakLxLLra2PWF47J7Wvl60jY/EDy9b
         CWx4WmtDoUtJd6awmmVhMDaRaYYoLNPsxf5PiDG8m+OgmpguEFGV1RCBc+x8hXQyT5NV
         9a2lUov98sXzDZ9LzwhgQaQZIScYt+q3cZCFXTjz/nOT85zRdk0NU9E7sU4mSJUMGS0W
         XQnA==
X-Gm-Message-State: ACrzQf0kY6SyY+8TtKZe22Dw3h1+K0rl3UpWBZUaOaRnDHrPXteBSzF5
        QIckbKWtD87w9X+7yCYiC3lwR8Sk2lY=
X-Google-Smtp-Source: AMsMyM7ASxgeFYee9W3SwJLlg+0frdYP8r4xiIeLhAXyVxKwkLNqmdz91nYPK06NUY0/NYwKjPZuaA==
X-Received: by 2002:a5d:588e:0:b0:22e:5601:f6d with SMTP id n14-20020a5d588e000000b0022e56010f6dmr17607041wrf.207.1665567317022;
        Wed, 12 Oct 2022 02:35:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bj4-20020a0560001e0400b0022e0580b7a9sm6380490wrb.17.2022.10.12.02.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 02:35:16 -0700 (PDT)
Message-Id: <ea4da25a19cca80f04fb6b88d46937056406c5b7.1665567312.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1150.v3.git.1665567312.gitgitgadget@gmail.com>
References: <pull.1150.v2.git.1650448612.gitgitgadget@gmail.com>
        <pull.1150.v3.git.1665567312.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 Oct 2022 09:35:07 +0000
Subject: [PATCH v3 3/8] rebase --merge: fix reflog when continuing
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
index 51accb4fd61..488e6bdfd3e 100644
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

