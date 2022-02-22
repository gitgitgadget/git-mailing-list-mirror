Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B21C433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 00:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237644AbiBVASe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 19:18:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237610AbiBVASb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 19:18:31 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDE125583
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 16:18:05 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d3so14115663wrf.1
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 16:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WKsjhKQh9X+EsJy0g/IlxjZL2l4R2BAcspMe0/TGXqM=;
        b=ceZPFFWcguvSxoRKXjdQRGOxx3HyItdtAoG7A6WPDFrCNMI2Yfl8wMgRUlRZw8pbQ4
         /hTqULCqMTYk1Z2xNzs4FS2w9JY7v8DTa74pZZLxj1O7WyjZiDrrzMvPtHc9MaoihL0f
         6T72xuMG2JrVirSG8uxf2x12c26T6ZnSESKXpVX9Y+9wmj9zhjMTo6Bpu/qUeBUzOVqB
         AzX0BEbo2y+Tsbdr7Z3+CDejm1N9rCrBx0XgSC2xbH2d9kK+VdWPHXf3no6qMmPBmuI3
         mAZO9kvhbmwD4xEHNjWZB+6w8EnOehmbklJwxpDCsRoaAXe+fvTA9k+HjLSc3yOJdItc
         ejDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WKsjhKQh9X+EsJy0g/IlxjZL2l4R2BAcspMe0/TGXqM=;
        b=Y4KhfEFBLfjQO6PRVJSw/69Zz6SSEriV/4IRXWdHPbPyc80c7ib8BnjekJ+BmRiEIV
         Ygp3TDrq3lJJJvd30WDXPCXgEYNVHP028nd2JNnelDnIsV5VTitqlgCfM+O+d1UG33Eq
         OE7lsN1AnETInMEHxGNO8JBZwvcbtyUURFCk64krBZrNmoDMDVhLkyBlJja14wO5sE8y
         7O9ffynkf8TJx+4WE5aEJbdTvz1Y/rEbhcgWMpC3RglQlODEdos8JVS016M1DCcou79D
         gXeOpI7xBMXNcma/CANByvNUGJlYeQFzLX8iIrya1LECFNNZsijpgfLAaMrFqO8cq6zF
         V8XQ==
X-Gm-Message-State: AOAM532MKW1FEivaft7vyLgLmZEbwB+xfqkmgmwVpj3L8/q2zqaFlBxD
        PiZ1rqqUhEl+KfhskCPdOlx0iHN8dzU=
X-Google-Smtp-Source: ABdhPJwbzv02mQbAd8Fwvmu3TsZ+OpL+GcppFbqa29fk2aojTr+xN2jDQOKv+pfSMWhDyEXbNNdzvA==
X-Received: by 2002:a5d:6847:0:b0:1dd:f498:d28e with SMTP id o7-20020a5d6847000000b001ddf498d28emr17241276wrw.609.1645489083776;
        Mon, 21 Feb 2022 16:18:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f10-20020a05600c154a00b0037bbbc15ca7sm1135246wmg.36.2022.02.21.16.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 16:18:03 -0800 (PST)
Message-Id: <f8aa87112a85ee2aa263cb2096232f462e76d06c.1645489080.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1154.v2.git.1645489080.gitgitgadget@gmail.com>
References: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
        <pull.1154.v2.git.1645489080.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Feb 2022 00:17:51 +0000
Subject: [PATCH v2 02/11] worktree: extract copy_filtered_worktree_config()
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

