Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BE0C433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 07:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238826AbiBWHsE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 02:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238771AbiBWHre (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 02:47:34 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DA955765
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 23:47:06 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id y5so2756268wmi.0
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 23:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mmXje3uuaK8BuJfg02GOpB/9+6GTpkr32zp2fn50u18=;
        b=T2Z0Zhj61a1Z1nIaheAvue07k2hrl4p3MelcVhhaPwMLtexGCeIFT/LBt3/T7AbwGI
         UyEk6DuOKLEeGWxF2ZVGncm40tEo3pvxSI4F5u6P8u7AueFxhaqgQeTDW7m1z7FqKWcT
         FBKOYJgN+83MM5pYsDCN0kzzo6Ye1sToZ1SxznDWy6qvigcanNuXd6uVEOdR7fVn2U4Q
         4MLpH+NA0W+yPHTCEbJRkTmD8IKMcksjuZ77lUOaHfLaZKNo0PVlTfuCJwtet3mZSyOA
         62pRTJoEoytvrPYq+lcnXiPTVwMRx/lf5hOCSq9VKCW1N0RZkEHs1Q5iDwsHeHZWwEmW
         oYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mmXje3uuaK8BuJfg02GOpB/9+6GTpkr32zp2fn50u18=;
        b=Wmm1vnn6KKKPj+UpABScGKvIwVVxi5/I6XMcTzo3xcl5ExAJTTqiCkKUDHBKE11MVI
         r55WyN9dwOXyjLJYqIrEU/ZDwJyDBumrdE6odXvWBnqDtLaiA0ff9MNCPJdljFmSwnZw
         CgJsuAxJPfJV9OYJ4wewocavJbHMCLW+mDQfcF2N6eAmtHVFC6x/p0Tn4MuM9Qn7vS/S
         rxIt8gQiMIy4voa2L4iqUhMohKp/ZdWxUhwU90lBBoIJ1D1ZR6iAYhmg/HPjT0I6lphC
         euISxwCwgujCZkXBqcI9oEUf4RpAeD0eCCzlZblnoXx+2NYkEsnKnsKImBX9arIqA0ke
         2t0g==
X-Gm-Message-State: AOAM531ey0JeTQPP3mT8pGROqsV7wtn0AzS0xvOmOGe3vrMUzBpcgLkP
        NdHLbHsUlJzZlWGmjVOSLFS66iJkUJ8=
X-Google-Smtp-Source: ABdhPJxzgn7Cw/ELETK+uKiklgejSJmp2ZphzZ5x2yDJdBv2wropRsReOR1J4spHbGZXZclCtFZDDw==
X-Received: by 2002:a05:600c:1547:b0:37b:c6c4:1000 with SMTP id f7-20020a05600c154700b0037bc6c41000mr6462226wmg.111.1645602425187;
        Tue, 22 Feb 2022 23:47:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c294900b00380f8be8ceesm632638wmd.20.2022.02.22.23.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 23:47:04 -0800 (PST)
Message-Id: <db73c6dd82346b55c46334111e89aefd3d9039a2.1645602413.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v6.git.1645602413.gitgitgadget@gmail.com>
References: <pull.1122.v5.git.1645340082.gitgitgadget@gmail.com>
        <pull.1122.v6.git.1645602413.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 07:46:52 +0000
Subject: [PATCH v6 11/12] merge-tree: add a --allow-unrelated-histories flag
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
index 767892006e3..b4f5c7e0aab 100644
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
 
@@ -499,6 +500,10 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
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
index 22e03f0939c..bd1769c624b 100755
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
@@ -213,4 +219,20 @@ test_expect_success 'NUL terminated conflicted file "lines"' '
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

