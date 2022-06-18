Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2640CCA479
	for <git@archiver.kernel.org>; Sat, 18 Jun 2022 00:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383777AbiFRAVp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jun 2022 20:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383658AbiFRAVc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jun 2022 20:21:32 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F81D6972B
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 17:21:24 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id w17so7500344wrg.7
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 17:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TT74SY4vdwupF7Apj8+pubYOYZb9BPcSsfOpp//NhsM=;
        b=NFJU2y2tHY0TBiITnL/wqnqtAG8uRlLyl6SrIku8fzWPDjX+s4R/ftjTW+mpVb7Krq
         ocTgSrkgwKQ0n07L/9K9mKS9sBHWXIFpbWZKmBNvNMgz0SQmWfpzkUJSrG9A5LavMfyH
         cE+vN37oRqbauWu9PmCxOXFAPim4aQxRC+ERRjylv61X/ylmgzjx2nVLKSXLHrUTjUIg
         mX7SviP6Y/7LyDWDllu0YiP0I4ZRYZttcbhd2HdNLoVXER3Vkpil1f20BdUh98/98OI/
         0BusdLyGMFlTUXSdKhCO9+/HIcBWI1R5JoT6f/1EGuCF7B+f6pet9G7sk2KzBifudOO6
         FeWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TT74SY4vdwupF7Apj8+pubYOYZb9BPcSsfOpp//NhsM=;
        b=e0DeHCiguubIuRXCveIv3AQiZxD3lOn9NaAbEzedcc26mvgktZPfvUX5tqA4fUp/Os
         F3hlxXMqM3PARi2VtV9PXIzC+uCk21NbmRiqaiZhRjH2nueGY5VS6ZBybnxMfZ/esHNF
         QXvcw5JxMCm3LDIAr7DCn3tLcMe/PhFaRnin7397tegEXCQKYgQZdOSqLaGsnA59Ouhf
         kF1QnLbVvOSmAy5kSD4aeZ4huB6Bkw8oi+lbiT9GrheVaxhpfo/YOYtmSNaoEZryamv/
         k6YuiBIusnqsznN6tVw4hlTpqcU2rt5Hw2kyewi2O7JLnhCfT6F746Jg6lKHWq3ksU3q
         1W9Q==
X-Gm-Message-State: AJIora9FnwgW4l2JX/WQb15CvGjuBzJAgfxBNQf3FRN0EcwsWJdJwlBw
        p98QifwIoCVjGgUwvzr+6UxuPQTpw8MzlA==
X-Google-Smtp-Source: AGRyM1vlaKRqKi8NzXeiVhY1sNn9dudTyiQ9zTNMqzK8JFLLomb2FZw6Rz/7M5QrILLg3nQjPoOXfQ==
X-Received: by 2002:a05:6000:18a9:b0:218:891d:815c with SMTP id b9-20020a05600018a900b00218891d815cmr11495623wri.311.1655511682617;
        Fri, 17 Jun 2022 17:21:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z12-20020a05600c220c00b0039c5b4ab1b0sm6562179wml.48.2022.06.17.17.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 17:21:21 -0700 (PDT)
Message-Id: <66df0c2e8379ca10debd403da295a2d6d230d453.1655511660.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v7.git.1655511660.gitgitgadget@gmail.com>
References: <pull.1122.v6.git.1645602413.gitgitgadget@gmail.com>
        <pull.1122.v7.git.1655511660.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 18 Jun 2022 00:20:59 +0000
Subject: [PATCH v7 16/17] merge-tree: add a --allow-unrelated-histories flag
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
        Johannes Sixt <j6t@kdbg.org>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Elijah Newren <newren@gmail.com>,
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
index 75b57f8abab..628324646d3 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -59,6 +59,11 @@ OPTIONS
 	default is to include these messages if there are merge
 	conflicts, and to omit them otherwise.
 
+--allow-unrelated-histories::
+	merge-tree will by default error out if the two branches specified
+	share no common history.  This flag can be given to override that
+	check and make the merge proceed anyway.
+
 [[OUTPUT]]
 OUTPUT
 ------
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index c159e317743..ae5782917b9 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -399,6 +399,7 @@ enum mode {
 
 struct merge_tree_options {
 	int mode;
+	int allow_unrelated_histories;
 	int show_messages;
 	int name_only;
 };
@@ -434,7 +435,7 @@ static int real_merge(struct merge_tree_options *o,
 	 * merge_incore_recursive in merge-ort.h
 	 */
 	merge_bases = get_merge_bases(parent1, parent2);
-	if (!merge_bases)
+	if (!merge_bases && !o->allow_unrelated_histories)
 		die(_("refusing to merge unrelated histories"));
 	merge_bases = reverse_commit_list(merge_bases);
 
@@ -500,6 +501,10 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 			   &o.name_only,
 			   N_("list filenames without modes/oids/stages"),
 			   PARSE_OPT_NONEG),
+		OPT_BOOL_F(0, "allow-unrelated-histories",
+			   &o.allow_unrelated_histories,
+			   N_("allow merging unrelated histories"),
+			   PARSE_OPT_NONEG),
 		OPT_END()
 	};
 
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index 88e75b18cc5..f091259a55e 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -44,7 +44,13 @@ test_expect_success setup '
 	git checkout side3 &&
 	git mv numbers sequence &&
 	test_tick &&
-	git commit -m rename-numbers
+	git commit -m rename-numbers &&
+
+	git switch --orphan unrelated &&
+	>something-else &&
+	git add something-else &&
+	test_tick &&
+	git commit -m first-commit
 '
 
 test_expect_success 'Clean merge' '
@@ -215,4 +221,20 @@ test_expect_success 'NUL terminated conflicted file "lines"' '
 	test_cmp expect actual
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

