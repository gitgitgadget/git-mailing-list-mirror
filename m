Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893BEC433EF
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 06:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237268AbiBTGza (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 01:55:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234587AbiBTGzS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 01:55:18 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4DF36151
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 22:54:54 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id i14so21505182wrc.10
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 22:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IF6VwxFloptfXCro/jr8zO90mvBpOWSHRkH6+N6VUyc=;
        b=aArBjSeuqTEdAJaFEv+e0cs5NSLl7L2jhmYwCTKVdzYfa8Kki3snD48woQh/w5NhUd
         vpJsjDOhE68kcmivgSHh2K7GxN+6RMNQQ+kKmxNSb+S3OfY4upC4FoHN4neyjXxHz9rF
         dP/YzLgUB6R9XsmUcgn2Ow4CBq4jczX2YrTVFTYKAxJLywWJjlcfwqdkKhbr3+Ch+bQa
         mlKde8cwZxz0On0oLafKE2l1fqcznErIHb6W8xAvXzNf4FW3ZHrppBvw6vy3Omze2s81
         OheIDCzDHqn9wEbuLQGBsSos/3h24Jos5LEgaSh6g/wnGWUFtQMqslRJRFytbQWiO50e
         ZS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IF6VwxFloptfXCro/jr8zO90mvBpOWSHRkH6+N6VUyc=;
        b=BNwk75z0l70CtGS6nWr5AsTKiMOdOFPzcLdG/CxYPWMaDKQKMLx80nyxnpODjnZz8+
         2F+fEXcujUUxu5pZBdx8GsH995w3CnbS1KRiArjiik3o3RsEjryQqOXL2mmkdp3W11aO
         RuWLdr8JqA7qkVfDc1uydcfpqp69BZkG5zLW6AfmMQmmkTtT54UO2lN4zsaUgD3JuNAA
         +322H56EhF2jtggDbsR9Mr4ziGBJ67V0AZQyvKJE0yplIpirFb4KBNbAED2lBiu1s9tN
         qu5IdFe9/aoa/Jft5Hl3woPBB5K4qWvqkGlvIb3lhDpb4pvHw/RykMebbmozzlBZl7DR
         OInQ==
X-Gm-Message-State: AOAM532/oHzbPS4oBFc/1TtUrOnsaFdCb0C/e2DPYAFwPn9QXY3uTixY
        GhvYrVe5nUwdYeP0emMP3ZKD6sELgVo=
X-Google-Smtp-Source: ABdhPJztEij7/XY0jTulm2eZUn/EMiotRDe9twRf+hd/dHAOzrCTylfipXq86ieFN2cY12f8NhEjsQ==
X-Received: by 2002:adf:e185:0:b0:1e2:6421:f2d0 with SMTP id az5-20020adfe185000000b001e26421f2d0mr11755919wrb.703.1645340093079;
        Sat, 19 Feb 2022 22:54:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f21-20020a7bcd15000000b0037bf83d99a2sm4100671wmj.1.2022.02.19.22.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 22:54:52 -0800 (PST)
Message-Id: <6ddd5ffde9c406a24f197c6b1a9e00192ce59d53.1645340082.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v5.git.1645340082.gitgitgadget@gmail.com>
References: <pull.1122.v4.git.1644698093.gitgitgadget@gmail.com>
        <pull.1122.v5.git.1645340082.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 20 Feb 2022 06:54:41 +0000
Subject: [PATCH v5 11/12] merge-tree: add a --allow-unrelated-histories flag
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
index 44024b11b1c..d2ff2fa3035 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -69,6 +69,11 @@ OPTIONS
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
index 825255667b1..911504ad694 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -399,6 +399,7 @@ enum mode {
 
 struct merge_tree_options {
 	int mode;
+	int allow_unrelated_histories;
 	int show_messages;
 	int name_only;
 };
@@ -436,7 +437,7 @@ static int real_merge(struct merge_tree_options *o,
 	 * merge_incore_recursive in merge-ort.h
 	 */
 	common = get_merge_bases(parent1, parent2);
-	if (!common)
+	if (!common && !o->allow_unrelated_histories)
 		die(_("refusing to merge unrelated histories"));
 	for (j = common; j; j = j->next)
 		commit_list_insert(j->item, &merge_bases);
@@ -502,6 +503,10 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
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

