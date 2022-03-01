Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D982CC433FE
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 20:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238389AbiCAU1E (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 15:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiCAU0s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 15:26:48 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C8E8F63E
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 12:24:42 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id m6so5087179wrr.10
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 12:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=H9bNahYcVt/ihTGOw2n84IRXC5Bf/4XszC0K41jHOqQ=;
        b=OgQy4VbtaiqKSLFPQFGfv78dEGb37wNew8ycpwvwqwEWgLorqQ+BstlJ472BfTvNfv
         ygnJ2AkYxQ89PCFXk/7vTpyWK8+MqDk6FIZipnc7scIUpprlB72SUHPiivnI0dy/BdlS
         +cpTs72XZOl7bKmW+ibqegxEx/33mVbZ2NHamQR9R1EVWmIEhlo9e3m/bmzzj4HVP2nu
         2wWxxRgFaJA553zCcz6HmxiwqlvkIdyN6ywc7ezWuAGBKAMK37Y0HmWw0ULDJtE9sMrj
         Hri2rRwg62MbStnzf04kTgTmU5IQnOHUJyiosyT5azab+b+3lrMDs8IdsZGBj+f9nzFW
         iBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=H9bNahYcVt/ihTGOw2n84IRXC5Bf/4XszC0K41jHOqQ=;
        b=DkCvsxUz2q4sn0yXOsjCF9tFqHTNBCBWJuv5gqSDCb4quAehpBcKPczN66cLSIXdTo
         RlZ9zGkZBdHGw99ESE2LxtwgftKZU1DsZj8rok64R74bak4UwJMdU1LIHZS6LRO49+IL
         k+6VjFbv4mB0t7mM6IFt1jJG3DfRHOmQ/RHRRCNX93noU09zE+jNcb1YejvGLzjIWyVC
         rxf+945K34g3M3r3suuPkcWvC14hBV6lqgsO4a7UxMeKqHkSxm0X/tODesravqrCYKdB
         sFRiO4tTd3mtv0tTytS21kkwayizTyMoMDbPuJcRerK400GYLjTkNjwGIXC4wfIDnT9S
         AL0g==
X-Gm-Message-State: AOAM5320x2AlezbiULmn7oSPI7AfCZyCreyf8u5mm+qrQgJeAOLDAnEi
        c7VIrO6WEJvd2PxA6jEQ5TOTfDQSEes=
X-Google-Smtp-Source: ABdhPJw6DttkBEOBuDHrYfgp5faSgrDwxK1gVGOCWntbSwRuSop9lbRxJTERuQ1uet740LBTKfGTZA==
X-Received: by 2002:a05:6000:2c6:b0:1f0:77e:4ed2 with SMTP id o6-20020a05600002c600b001f0077e4ed2mr3778581wry.330.1646166279297;
        Tue, 01 Mar 2022 12:24:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d8-20020adfe888000000b001e060f07236sm14460637wrm.14.2022.03.01.12.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 12:24:38 -0800 (PST)
Message-Id: <6bc11325dd14a67121cf5f5a8e20d83e1d7f4047.1646166271.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1157.v3.git.1646166271.gitgitgadget@gmail.com>
References: <pull.1157.v2.git.1645742073.gitgitgadget@gmail.com>
        <pull.1157.v3.git.1646166271.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Mar 2022 20:24:31 +0000
Subject: [PATCH v3 8/8] read-tree: make three-way merge sparse-aware
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Enable use of 'merged_sparse_dir' in 'threeway_merge'. As with two-way
merge, the contents of each conflicted sparse directory are merged without
referencing the index, avoiding sparse index expansion.

As with two-way merge, the 't/t1092-sparse-checkout-compatibility.sh' test
'read-tree --merge with edit/edit conflicts in sparse directories' confirms
that three-way merges with edit/edit changes (both with and without
conflicts) inside a sparse directory result in the correct index state or
error message. To ensure the index is not unnecessarily expanded, add
three-way merge cases to 'sparse index is not expanded: read-tree'.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/read-tree.c                      |  5 ----
 t/t1092-sparse-checkout-compatibility.sh |  4 ++-
 unpack-trees.c                           | 34 ++++++++++++++++++------
 3 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 9227f07ab15..9f1f33e9546 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -234,11 +234,6 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 			break;
 		case 3:
 		default:
-			/*
-			 * TODO: update threeway_merge to handle edit/edit conflicts in
-			 * sparse directories.
-			 */
-			ensure_full_index(&the_index);
 			opts.fn = threeway_merge;
 			break;
 		}
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 61dc2ea777c..8be8e3c06a6 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1413,7 +1413,9 @@ test_expect_success 'sparse index is not expanded: read-tree' '
 	init_repos &&
 
 	ensure_not_expanded checkout -b test-branch update-folder1 &&
-	for MERGE_TREES in "base update-folder2" \
+	for MERGE_TREES in "base HEAD update-folder2" \
+			   "base HEAD rename-base" \
+			   "base update-folder2" \
 			   "base rename-base" \
 			   "update-folder2"
 	do
diff --git a/unpack-trees.c b/unpack-trees.c
index 0c2a678cd6d..b876caca0d1 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2643,16 +2643,24 @@ int threeway_merge(const struct cache_entry * const *stages,
 	 */
 	/* #14, #14ALT, #2ALT */
 	if (remote && !df_conflict_head && head_match && !remote_match) {
-		if (index && !same(index, remote) && !same(index, head))
-			return reject_merge(index, o);
+		if (index && !same(index, remote) && !same(index, head)) {
+			if (S_ISSPARSEDIR(index->ce_mode))
+				return merged_sparse_dir(stages, 4, o);
+			else
+				return reject_merge(index, o);
+		}
 		return merged_entry(remote, index, o);
 	}
 	/*
 	 * If we have an entry in the index cache, then we want to
 	 * make sure that it matches head.
 	 */
-	if (index && !same(index, head))
-		return reject_merge(index, o);
+	if (index && !same(index, head)) {
+		if (S_ISSPARSEDIR(index->ce_mode))
+			return merged_sparse_dir(stages, 4, o);
+		else
+			return reject_merge(index, o);
+	}
 
 	if (head) {
 		/* #5ALT, #15 */
@@ -2714,11 +2722,21 @@ int threeway_merge(const struct cache_entry * const *stages,
 
 	}
 
-	/* Below are "no merge" cases, which require that the index be
-	 * up-to-date to avoid the files getting overwritten with
-	 * conflict resolution files.
-	 */
+	/* Handle "no merge" cases (see t/t1000-read-tree-m-3way.sh) */
 	if (index) {
+		/*
+		 * If we've reached the "no merge" cases and we're merging
+		 * a sparse directory, we may have an "edit/edit" conflict that
+		 * can be resolved by individually merging directory contents.
+		 */
+		if (S_ISSPARSEDIR(index->ce_mode))
+			return merged_sparse_dir(stages, 4, o);
+
+		/*
+		 * If we're not merging a sparse directory, ensure the index is
+		 * up-to-date to avoid files getting overwritten with conflict
+		 * resolution files
+		 */
 		if (verify_uptodate(index, o))
 			return -1;
 	}
-- 
gitgitgadget
