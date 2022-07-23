Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BC2C433EF
	for <git@archiver.kernel.org>; Sat, 23 Jul 2022 01:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236851AbiGWBxe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 21:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiGWBx1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 21:53:27 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EA173928
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 18:53:26 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id g2so597201wru.3
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 18:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OckJ/WL0sf1z9wtCzqcjwJ+Dbks/MDiyEOPvfc19iN0=;
        b=cpdxAdky/BympLTlrz6g9FDrarP+bgImJshBegDzGf6VHw+ddIKcSpZWtE3H/nbLA5
         bv3IlCQry/lrzIPtx6KO+VwPW4XuWmfzXqb3ngsxadLu+iNwKa0tNCFadXL39ks2Fmhp
         xYh+UzUdc26vREXKpgdJTcF3xG1mTjEn6UAbwcrBMnKJUTA0lpOH5ZbM9nJ4PhDglSv/
         2QFqJU26efwZkfqeQ7n4SkguyUhFGDIO5q9YhiSGvUXawSDuBIQODPu+DM+EECTMDFwM
         RJ8iQMQKATV+aqKdS4XTfWoo081KzqlkrBzwfQggshb14Lw/Pkb8VM3y6Ra2bcKGRHzn
         SVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OckJ/WL0sf1z9wtCzqcjwJ+Dbks/MDiyEOPvfc19iN0=;
        b=nll1SRW6zRsM08FYd4kQXgBND7h3cIHa6739xAAHwZYTQBISjNZHFmvDo8j2m4mir3
         r74b4g7RHDEsdCXpjNw6BmgYZfxjPEQVm07klWNwY/FQaglVU4NlqXwY0xmI98Lg7CH8
         mJ3Nb/PS6aCxPFuxL5IBovJx8gkTvb/ufFQatJYpx4HAYSN0NkJ+Qg6ErdVlVOxBZ9LM
         tAKeCxpogXeU2OhdaIVWg6fj6QrVEW2Nw1TsN5oWUquNFpjERKOHS3VozKHbkYe1Ahac
         y5HBukuSYqj7w0lTLp9JM3CKqX8LMhbOvXjKbTuCYDfDMjD4K8/5jTpN+jee1J2KpT6m
         mksw==
X-Gm-Message-State: AJIora8DRKtA7uPZIQfU6tTaUfayXztdaGvb7LL1tmMZBmXgKS7miXxK
        tIqEdUveQjnehRWKpsxb8N1t4oTQ4os=
X-Google-Smtp-Source: AGRyM1vl2uDFuwxczlYO8wximvvZw+I2mNTqamBZ/ppxmzhECPxuT4UMaRTeR6+NRnaoqk4eL/HZmA==
X-Received: by 2002:adf:fb12:0:b0:20c:79b2:a200 with SMTP id c18-20020adffb12000000b0020c79b2a200mr1490313wrr.617.1658541204769;
        Fri, 22 Jul 2022 18:53:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q5-20020a1ce905000000b003a0323463absm6669250wmc.45.2022.07.22.18.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 18:53:24 -0700 (PDT)
Message-Id: <e7c6de9e0c1c8ea7d759e0cd635a350c980d60a7.1658541198.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1231.v5.git.1658541198.gitgitgadget@gmail.com>
References: <pull.1231.v4.git.1658466942.gitgitgadget@gmail.com>
        <pull.1231.v5.git.1658541198.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 23 Jul 2022 01:53:15 +0000
Subject: [PATCH v5 5/8] merge: fix save_state() to work when there are
 stat-dirty files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When there are stat-dirty files, but no files are modified,
`git stash create` exits with unsuccessful status.  This causes merge
to fail.  Copy some code from sequencer.c's create_autostash to refresh
the index first to avoid this problem.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge.c                          |  8 ++++++++
 t/t6424-merge-unrelated-index-changes.sh | 11 +++++++++++
 2 files changed, 19 insertions(+)

diff --git a/builtin/merge.c b/builtin/merge.c
index c120ad619c4..780b4b9100a 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -313,8 +313,16 @@ static int save_state(struct object_id *stash)
 	int len;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf buffer = STRBUF_INIT;
+	struct lock_file lock_file = LOCK_INIT;
+	int fd;
 	int rc = -1;
 
+	fd = repo_hold_locked_index(the_repository, &lock_file, 0);
+	refresh_cache(REFRESH_QUIET);
+	if (0 <= fd)
+		repo_update_index_if_able(the_repository, &lock_file);
+	rollback_lock_file(&lock_file);
+
 	strvec_pushl(&cp.args, "stash", "create", NULL);
 	cp.out = -1;
 	cp.git_cmd = 1;
diff --git a/t/t6424-merge-unrelated-index-changes.sh b/t/t6424-merge-unrelated-index-changes.sh
index 615061c7af4..2c83210f9fd 100755
--- a/t/t6424-merge-unrelated-index-changes.sh
+++ b/t/t6424-merge-unrelated-index-changes.sh
@@ -275,6 +275,17 @@ test_expect_success 'subtree' '
 	test_path_is_missing .git/MERGE_HEAD
 '
 
+test_expect_success 'avoid failure due to stat-dirty files' '
+	git reset --hard &&
+	git checkout B^0 &&
+
+	# Make "a" be stat-dirty
+	test-tool chmtime =+1 a &&
+
+	# stat-dirty file should not prevent stash creation in builtin/merge.c
+	git merge -s resolve -s recursive D^0
+'
+
 test_expect_success 'with multiple strategies, recursive or ort failure do not early abort' '
 	git reset --hard &&
 	git checkout B^0 &&
-- 
gitgitgadget

