Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DCCC433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 14:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241576AbiBWO34 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 09:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241571AbiBWO3w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 09:29:52 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711F3B250B
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 06:29:24 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id n13-20020a05600c3b8d00b0037bff8a24ebso1657770wms.4
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 06:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WKsjhKQh9X+EsJy0g/IlxjZL2l4R2BAcspMe0/TGXqM=;
        b=Y+XqKTBOtRu5uBjfs5ixAE56Hi4/GdpGjqhmMrxqlG+Y4uj8bNjabWfkRcLgxRkSxv
         tLfq2nE37T8NQABLdRhiSMAqbY9+0DIMpywgBkqHcZne2C1V1mfK1s5uOK7cgG8q+Nzj
         HxPRkg5QEWjlqMfFhaIwKyKlRvsKx82RS2XQLPKeO0q1KLEVxPF5udbKDuhwLnHf+4lK
         goNlSYeDyR64MUUNG4b1PeCWm8fPi73IOr0KfCp9DQt2quRCUGUJ/VCZysIWaoQ1wSbu
         vmT+gYbSmLtHtd797WSalin85IM/Q/ZisjfbbyOCN5JbIkzw1QS3chmTcijPco1pW0cN
         tWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WKsjhKQh9X+EsJy0g/IlxjZL2l4R2BAcspMe0/TGXqM=;
        b=GuAdsjPyXXiFk0dMumbC0Tw4ErhPWp7C9cEt3diJUq0XRAtjp0YTaZKK13ueVi9CIx
         zmqGOQ0SDHJG5mcghs4PAGUDsdhBctBLLUw36wLW6zgmxovHCmorP2xdqZBXQt629bUu
         d05ZO3tMQLV1SLyjtP9KiUYl1pNUoKXQeW2SRdb/bUV5RhaUjRI8RlhEIIIMpt3i11vC
         uux9NNcRAPh6N/pAbgwMChTST5ptIWAtOs+P0xVGKXnqL2Pcp9QJmEAgWWl+NLx0iUvl
         vnkgi0c7py0pmxjYnqCcHq6C4w/mnI6/e2PHwgQ/0Vfkj0vAobpSREpGsX2U/gDI6ucr
         lWgA==
X-Gm-Message-State: AOAM531ShbvUwp8NDzhF1bQ/S5odx5MyBBIhXhGC4woMiBaPcd+z1UtT
        v88iHepi7IGsPmVDjKgS68wJzLpchBU=
X-Google-Smtp-Source: ABdhPJwr/FlQNKAPfF7ddA1u5aI7hdFK6cw7BF3xeXk59DDq6hqdAN/Pyz+Y5rRx0u2/MdlekQA2JA==
X-Received: by 2002:a05:600c:215:b0:37c:729:f84d with SMTP id 21-20020a05600c021500b0037c0729f84dmr7802773wmi.131.1645626562766;
        Wed, 23 Feb 2022 06:29:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b16sm6626191wmj.32.2022.02.23.06.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 06:29:22 -0800 (PST)
Message-Id: <f8aa87112a85ee2aa263cb2096232f462e76d06c.1645626559.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1154.v3.git.1645626559.gitgitgadget@gmail.com>
References: <pull.1154.v2.git.1645489080.gitgitgadget@gmail.com>
        <pull.1154.v3.git.1645626559.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 14:29:10 +0000
Subject: [PATCH v3 02/11] worktree: extract copy_filtered_worktree_config()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, gitster@pobox.com, newren@gmail.com,
        jn.avila@free.fr, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

This logic was introduced by 5325591 (worktree: copy sparse-checkout
patterns and config on add, 2022-02-07), but some feedback came in that
the add_worktree() method was already too complex. It is better to
extract this logic into a helper method to reduce this complexity.

Reported-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/worktree.c | 81 ++++++++++++++++++++++++----------------------
 1 file changed, 42 insertions(+), 39 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 7c272078dc9..2771a6dc793 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -236,6 +236,46 @@ static void check_candidate_path(const char *path,
 		die(_("'%s' is a missing but already registered worktree;\nuse '%s -f' to override, or 'prune' or 'remove' to clear"), path, cmd);
 }
 
+static void copy_filtered_worktree_config(const char *worktree_git_dir)
+{
+	char *from_file = git_pathdup("config.worktree");
+	char *to_file = xstrfmt("%s/config.worktree", worktree_git_dir);
+
+	if (file_exists(from_file)) {
+		struct config_set cs = { { 0 } };
+		const char *core_worktree;
+		int bare;
+
+		if (safe_create_leading_directories(to_file) ||
+			copy_file(to_file, from_file, 0666)) {
+			error(_("failed to copy worktree config from '%s' to '%s'"),
+				from_file, to_file);
+			goto worktree_copy_cleanup;
+		}
+
+		git_configset_init(&cs);
+		git_configset_add_file(&cs, from_file);
+
+		if (!git_configset_get_bool(&cs, "core.bare", &bare) &&
+			bare &&
+			git_config_set_multivar_in_file_gently(
+				to_file, "core.bare", NULL, "true", 0))
+			error(_("failed to unset '%s' in '%s'"),
+				"core.bare", to_file);
+		if (!git_configset_get_value(&cs, "core.worktree", &core_worktree) &&
+			git_config_set_in_file_gently(to_file,
+							"core.worktree", NULL))
+			error(_("failed to unset '%s' in '%s'"),
+				"core.worktree", to_file);
+
+		git_configset_clear(&cs);
+	}
+
+worktree_copy_cleanup:
+	free(from_file);
+	free(to_file);
+}
+
 static int add_worktree(const char *path, const char *refname,
 			const struct add_opts *opts)
 {
@@ -360,45 +400,8 @@ static int add_worktree(const char *path, const char *refname,
 	 * values from the current worktree into the new one, that way the
 	 * new worktree behaves the same as this one.
 	 */
-	if (repository_format_worktree_config) {
-		char *from_file = git_pathdup("config.worktree");
-		char *to_file = xstrfmt("%s/config.worktree",
-					sb_repo.buf);
-
-		if (file_exists(from_file)) {
-			struct config_set cs = { { 0 } };
-			const char *core_worktree;
-			int bare;
-
-			if (safe_create_leading_directories(to_file) ||
-			    copy_file(to_file, from_file, 0666)) {
-				error(_("failed to copy worktree config from '%s' to '%s'"),
-				      from_file, to_file);
-				goto worktree_copy_cleanup;
-			}
-
-			git_configset_init(&cs);
-			git_configset_add_file(&cs, from_file);
-
-			if (!git_configset_get_bool(&cs, "core.bare", &bare) &&
-			    bare &&
-			    git_config_set_multivar_in_file_gently(
-					to_file, "core.bare", NULL, "true", 0))
-				error(_("failed to unset '%s' in '%s'"),
-				      "core.bare", to_file);
-			if (!git_configset_get_value(&cs, "core.worktree", &core_worktree) &&
-			    git_config_set_in_file_gently(to_file,
-							  "core.worktree", NULL))
-				error(_("failed to unset '%s' in '%s'"),
-				      "core.worktree", to_file);
-
-			git_configset_clear(&cs);
-		}
-
-worktree_copy_cleanup:
-		free(from_file);
-		free(to_file);
-	}
+	if (repository_format_worktree_config)
+		copy_filtered_worktree_config(sb_repo.buf);
 
 	strvec_pushf(&child_env, "%s=%s", GIT_DIR_ENVIRONMENT, sb_git.buf);
 	strvec_pushf(&child_env, "%s=%s", GIT_WORK_TREE_ENVIRONMENT, path);
-- 
gitgitgadget

