Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF43C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 21:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237457AbiF3VUK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 17:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237461AbiF3VT6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 17:19:58 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1964D4ED
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 14:19:57 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id t17-20020a1c7711000000b003a0434b0af7so394959wmi.0
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 14:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KW37HpirRMIvOEXY3NYMTI09bimle02oyoeYENKZT/M=;
        b=hd6+Zpe45wKDBQuMrGjCJ5IIntF4e65CiT4HxqCRIsjxltYmBP4vJIKkuIB0lV9ltw
         Eyv2cYsXncJGxisJGuIdNg/Ie/xyz6IhGtt5CpDt7MolOCkubEtF29MyST/Pf5DBdb3J
         qY9kD++K8oJ7fcy5amfjuiAJ545g9EzW8g2Ff7Isg43ruKarbm1d0zjV5/QdDWhkjVpy
         4y4QYmhIOkSJDYbB8i3VS+IOYQkuUsuxT0T8Y+0cnZk4Xh7SIOJ4PrBY88qMgxkDeoWt
         kVCbHxojMweI0yIET8APBA7akgCEuWsmGaXICKnnfEKD8WP2UM9L4VDb3dKk4BuQ2ukD
         ZHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KW37HpirRMIvOEXY3NYMTI09bimle02oyoeYENKZT/M=;
        b=uF3ta9Q/y3OaloRfAr15WuYQO4ycf+xL2BQpQQgAKvQP+hPFvbUdQzoQ2zQmsw0+2r
         5HZuwfQ+htSYLFJ8DmTzLYPkY+b/O6XbhuNKHw5krWCiHDrf/W+RENxho9qgF1mPguDD
         az6cti5D/D2sySUna8ieBaX4GlVxT1KR6hNVotBvC9H8Cc5xdXGRNqeHpzVqPRu8eUok
         zrmXfB1JdfSv0qlKT31LuMaMya/kTzWUTD32EW06nlOCJbPHfan8gEVhhY6GkaOl1g/e
         8O+EoELvJZ/H+lDiHl7/KMjgzGMCDXAxCbhnlJE5rldvudsAxmzLpWUP1s/Qlqf0BQfC
         TbsQ==
X-Gm-Message-State: AJIora+PW/wisYgvHwxBVs9DzsL/YG6OI6QbL6eI16/IxHkpzS+THi9F
        2d7fLt/vhb0WKb0+0bc6MgYjMrghPhY=
X-Google-Smtp-Source: AGRyM1top5qYPUYp3pdKZ6L0MjFJnoZh3I8YbmO680vjmtBXbDxUTHM5D9crzjCDtnrH7M6VO8zcKg==
X-Received: by 2002:a05:600c:4e51:b0:3a0:4e8d:1e44 with SMTP id e17-20020a05600c4e5100b003a04e8d1e44mr12652625wmq.105.1656623995302;
        Thu, 30 Jun 2022 14:19:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c4f5500b003a0502c620dsm3875543wmq.44.2022.06.30.14.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 14:19:54 -0700 (PDT)
Message-Id: <64c138df19670cc615c7bb6cda33f085c17ca837.1656623978.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1282.v2.git.git.1656623978.gitgitgadget@gmail.com>
References: <pull.1282.git.git.1656372017.gitgitgadget@gmail.com>
        <pull.1282.v2.git.git.1656623978.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Jun 2022 21:19:33 +0000
Subject: [PATCH v2 13/18] submodule--helper update: use display path helper
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

There are two locations in prepare_to_clone_next_submodule() that
manually calculate the submodule display path, but should just use
do_get_submodule_displaypath() for consistency.

Do this replacement and reorder the code slightly to avoid computing
the display path twice.

This code was never tested, and adding tests shows that both these sites
have been computing the display path incorrectly ever since they were
introduced in 48308681b0 (git submodule update: have a dedicated helper
for cloning, 2016-02-29) [1]:

- The first hunk puts a "/" between recursive_prefix and ce->name, but
  recursive_prefix already ends with "/".
- The second hunk calls relative_path() on recursive_prefix and
  ce->name, but relative_path() only makes sense when both paths share
  the same base directory. This is never the case here:
  - recursive_prefix is the path from the topmost superproject to the
    current submodule
  - ce->name is the path from the root of the current submodule to its
    submodule.
  so, e.g. recursive_prefix="super" and ce->name="submodule" produces
  displayname="../super" instead of "super/submodule".

While we're fixing the display names, also fix inconsistent quoting of
the submodule name.

[1] I verified this by applying the tests to 48308681b0.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 21 +++++---------
 t/t7406-submodule-update.sh | 56 +++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 14 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 389b900602f..db2d5ab7998 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1947,30 +1947,23 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	const char *update_string;
 	enum submodule_update_type update_type;
 	char *key;
-	struct strbuf displaypath_sb = STRBUF_INIT;
 	struct strbuf sb = STRBUF_INIT;
-	const char *displaypath = NULL;
+	char *displaypath;
 	int needs_cloning = 0;
 	int need_free_url = 0;
 
+	displaypath = do_get_submodule_displaypath(ce->name,
+						   suc->update_data->prefix,
+						   suc->update_data->recursive_prefix);
+
 	if (ce_stage(ce)) {
-		if (suc->update_data->recursive_prefix)
-			strbuf_addf(&sb, "%s/%s", suc->update_data->recursive_prefix, ce->name);
-		else
-			strbuf_addstr(&sb, ce->name);
-		strbuf_addf(out, _("Skipping unmerged submodule %s"), sb.buf);
+		strbuf_addf(out, _("Skipping unmerged submodule %s"), displaypath);
 		strbuf_addch(out, '\n');
 		goto cleanup;
 	}
 
 	sub = submodule_from_path(the_repository, null_oid(), ce->name);
 
-	if (suc->update_data->recursive_prefix)
-		displaypath = relative_path(suc->update_data->recursive_prefix,
-					    ce->name, &displaypath_sb);
-	else
-		displaypath = ce->name;
-
 	if (!sub) {
 		next_submodule_warn_missing(suc, out, displaypath);
 		goto cleanup;
@@ -2060,7 +2053,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 					      "--no-single-branch");
 
 cleanup:
-	strbuf_release(&displaypath_sb);
+	free(displaypath);
 	strbuf_release(&sb);
 	if (need_free_url)
 		free((void*)url);
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 06d804e2131..f0408c5cc4a 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -1116,4 +1116,60 @@ test_expect_success 'submodule update --filter sets partial clone settings' '
 	test_cmp_config -C super-filter/submodule blob:none remote.origin.partialclonefilter
 '
 
+# NEEDSWORK: Clean up the tests so that we can reuse the test setup.
+# Don't reuse the existing repos because the earlier tests have
+# intentionally disruptive configurations.
+test_expect_success 'setup clean recursive superproject' '
+	git init bottom &&
+	test_commit -C bottom "bottom" &&
+	git init middle &&
+	git -C middle submodule add ../bottom bottom &&
+	git -C middle commit -m "middle" &&
+	git init top &&
+	git -C top submodule add ../middle middle &&
+	git -C top commit -m "top" &&
+	git clone --recurse-submodules top top-clean
+'
+
+test_expect_success 'submodule update should skip unmerged submodules' '
+	test_when_finished "rm -fr top-cloned" &&
+	cp -r top-clean top-cloned &&
+
+	# Create an upstream commit in each repo, starting with bottom
+	test_commit -C bottom upstream_commit &&
+	# Create middle commit
+	git -C middle/bottom fetch &&
+	git -C middle/bottom checkout -f FETCH_HEAD &&
+	git -C middle add bottom &&
+	git -C middle commit -m "upstream_commit" &&
+	# Create top commit
+	git -C top/middle fetch &&
+	git -C top/middle checkout -f FETCH_HEAD &&
+	git -C top add middle &&
+	git -C top commit -m "upstream_commit" &&
+
+	# Create a downstream conflict
+	test_commit -C top-cloned/middle/bottom downstream_commit &&
+	git -C top-cloned/middle add bottom &&
+	git -C top-cloned/middle commit -m "downstream_commit" &&
+	git -C top-cloned/middle fetch --recurse-submodules origin &&
+	test_must_fail git -C top-cloned/middle merge origin/main &&
+
+	# Make the update of "middle" a no-op, otherwise we error out
+	# because of its unmerged state
+	test_config -C top-cloned submodule.middle.update !true &&
+	git -C top-cloned submodule update --recursive 2>actual.err &&
+	grep -F "Skipping unmerged submodule middle/bottom" actual.err
+'
+
+test_expect_success 'submodule update --recursive skip submodules with strategy=none' '
+	test_when_finished "rm -fr top-cloned" &&
+	cp -r top-clean top-cloned &&
+
+	test_commit -C top-cloned/middle/bottom downstream_commit &&
+	git -C top-cloned/middle config submodule.bottom.update none &&
+	git -C top-cloned submodule update --recursive 2>actual.err &&
+	grep -F "Skipping submodule ${SQ}middle/bottom${SQ}" actual.err
+'
+
 test_done
-- 
gitgitgadget

