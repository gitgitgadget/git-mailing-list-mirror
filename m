Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922F7C433EF
	for <git@archiver.kernel.org>; Sat, 29 Jan 2022 18:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353046AbiA2SHj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Jan 2022 13:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353001AbiA2SH1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jan 2022 13:07:27 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18575C061751
        for <git@vger.kernel.org>; Sat, 29 Jan 2022 10:07:26 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id d138-20020a1c1d90000000b0034e043aaac7so8013713wmd.5
        for <git@vger.kernel.org>; Sat, 29 Jan 2022 10:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WUyLCxHvSgoMpE4PVsbUd0YaOkpPQy/P5/Q9dNOZFJs=;
        b=mkzSoj2dBA3QggdXawFMdXC5j6g7QTN20gnCnqvWgbiJV1Phus+ocPArrhZBT+jios
         Y4uY3LYOYtBt5l4/+8QLTL2mbDcfd9KgZFqBs9eLKmgpQyk+6sARxcIzZDjm0P18FuZ1
         vzvVPCRr0JGd7M8TJu0EQcCez4k7ukSQKIrql4AsEPvpzeHv31lyN2gW74erMBLbFnu2
         166bhndAtO0WFgt/GsFSgN5ZEvGqMxjF3kZi2Z6sh2HBVF+9k/ARpGTQb8u8aMJ8Qp8i
         0LkhU9ttmOM2Kh8oH9p+tWSn2D7K1zTFx/zvodxAEv6lchv+EiD6v1FoujvD6KGROX0c
         uMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WUyLCxHvSgoMpE4PVsbUd0YaOkpPQy/P5/Q9dNOZFJs=;
        b=TdRPf2/EC1Zra/Gf7FEfROHBz7MvmpWo0bbfQFxB6PB0VLQfxDr9rRYU5lcXuhR3bs
         Qn65tfZmztUEv0uZzgBv3kIZVMFH6dNVzmOAUDMYTrlf5xhnUiTAzdqCyiTSTfJF7aPB
         a0m8sCiaBdFkXVGEzKEuRz97aMRlbY48Yo/d/JdkTkdIAOfWqOk1V/1mA00Mm68c6HK9
         /UR1G0AZjImKSz6KY1AgXuWlXg0rIGk6nRKr5Y2yk8CMKRTA6IlUyVzKBy6olqrfqvUx
         SUVpLC+lUdilmnyAkgyzbc/Qi+C9ucXiq6pqBR4uwQKl+fBmxbSY05ypVBeEmOACvjk4
         Gcrw==
X-Gm-Message-State: AOAM531an0Hf0jDpBzh33QfXtK6QiFjQH30T5rxq/ybWhE+ST7RNzqfG
        HW7TXoxu4sFHbD+dRRqYmjdP2vX4o/U=
X-Google-Smtp-Source: ABdhPJxiTwZtppfZAZ3pS+Hja5gWJpyx2lmRxZBqFbFgQr3zrVfKRXdNQolR+MmGrjqpuIHXtys2PA==
X-Received: by 2002:a1c:f006:: with SMTP id a6mr20636504wmb.71.1643479644542;
        Sat, 29 Jan 2022 10:07:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g15sm2709702wri.82.2022.01.29.10.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 10:07:24 -0800 (PST)
Message-Id: <25677d5038cab591774eaa1349365871b23aa2fc.1643479633.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
        <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 29 Jan 2022 18:07:12 +0000
Subject: [PATCH v2 12/13] merge-tree: add a --allow-unrelated-histories flag
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Folks may want to merge histories that have no common ancestry; provide
a flag with the same name as used by `git merge` to allow this.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-merge-tree.txt |  5 +++++
 builtin/merge-tree.c             |  7 ++++++-
 t/t4301-merge-tree-write-tree.sh | 24 +++++++++++++++++++++++-
 3 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index 55bb7bc61c1..d35710c81d5 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -49,6 +49,11 @@ OPTIONS
 	default is to include these messages if there are merge
 	conflicts, and to omit them otherwise.
 
+--allow-unrelated-histories::
+	merge-tree will by default error out if the two branches specified
+	share no common history.  This flag can be given to override that
+	check and make the merge proceed anyway.
+
 OUTPUT
 ------
 
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index dc52cd02dce..cca5075d521 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -393,6 +393,7 @@ static int trivial_merge(const char *base,
 
 struct merge_tree_options {
 	int mode;
+	int allow_unrelated_histories;
 	int show_messages;
 	int exclude_modes_oids_stages;
 };
@@ -430,7 +431,7 @@ static int real_merge(struct merge_tree_options *o,
 	 * merge_incore_recursive in merge-ort.h
 	 */
 	common = get_merge_bases(parent1, parent2);
-	if (!common)
+	if (!common && !o->allow_unrelated_histories)
 		die(_("refusing to merge unrelated histories"));
 	for (j = common; j; j = j->next)
 		commit_list_insert(j->item, &merge_bases);
@@ -494,6 +495,10 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 			   &o.exclude_modes_oids_stages,
 			   N_("list conflicted files without modes/oids/stages"),
 			   PARSE_OPT_NONEG),
+		OPT_BOOL_F(0, "allow-unrelated-histories",
+			   &o.allow_unrelated_histories,
+			   N_("allow merging unrelated histories"),
+			   PARSE_OPT_NONEG),
 		OPT_END()
 	};
 
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index 1572f460da0..996bdfaab7d 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -38,7 +38,13 @@ test_expect_success setup '
 	>whatever/empty &&
 	git add numbers greeting whatever/empty &&
 	test_tick &&
-	git commit -m other-modifications
+	git commit -m other-modifications &&
+
+	git switch --orphan unrelated &&
+	>something-else &&
+	git add something-else &&
+	test_tick &&
+	git commit -m first-commit
 '
 
 test_expect_success 'Content merge and a few conflicts' '
@@ -139,4 +145,20 @@ test_expect_success 'Check conflicted oids and modes without messages' '
 	test_cmp conflicted-file-info actual
 '
 
+test_expect_success 'error out by default for unrelated histories' '
+	test_expect_code 128 git merge-tree --write-tree side1 unrelated 2>error &&
+
+	grep "refusing to merge unrelated histories" error
+'
+
+test_expect_success 'can override merge of unrelated histories' '
+	git merge-tree --write-tree --allow-unrelated-histories side1 unrelated >tree &&
+	TREE=$(cat tree) &&
+
+	git rev-parse side1:numbers side1:greeting side1:whatever unrelated:something-else >expect &&
+	git rev-parse $TREE:numbers $TREE:greeting $TREE:whatever $TREE:something-else >actual &&
+
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

