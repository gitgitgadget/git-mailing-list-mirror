Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6459C07E9D
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 14:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbiI0OI6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 10:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbiI0OIl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 10:08:41 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E421B3481
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 07:08:39 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id x18so15184944wrm.7
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 07:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=M07B3ZQmlwwBE9+tviWQszn8d7FBscBdJa2g3Z44Hu8=;
        b=iyetN1a/g4KdM97qPb9rGDcdms70AiA5BCpjI8eA2lV9DW2sS4tGt9jDwkZOVzjw8Y
         rgQghiu1HIoGX49tK+Rhonk4lnBZPzADqChBeFoYu+4K6hr16ugvF5O5RYYYAT7jllfM
         eMOTIJTYMkvhJKnoOXxe3KfyrGducyL6LKvbAxzQ0n+Nhx8Eifm2LspCQ1SB9cBR4llJ
         hHMx4CLjAaUlrrU+eBwb0pBjCf2UNTT19Zq/MayHxZ+BjOULLKi5YHNOu6Wd6fhDrMw5
         c6HM5H1PR7teR3gwVGHMUiGuY5Ylar1wgS05SLvN0GJfVbPVlHpp1wMzg8vmKs0NrgcX
         D90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=M07B3ZQmlwwBE9+tviWQszn8d7FBscBdJa2g3Z44Hu8=;
        b=Zl5DN3GnlHdjSfmnVezDrmpINFaxXmWmnpM2ZOokv9oUXoMeXsv2a0X8QVZmqc/Tcu
         L4sYo+iTyVZm6Gv9hZK2yjXrMnGyqMP3UPFqMAKNlhTazYEKGw6YRKY48TCD+niP5DpP
         bPjY8oiVrodw+Nk41spI2Otwy4otcXoUJoZ6LaTvUOnNEo96kdcKIhdA+EFL2SON+XOL
         y4XRwnp+cXo0mlnR4fMbEkrlWJO+SUUNhvKdg2V8m0mIWkc5RGrrVh3TFZQMzh0wf1mR
         At6xTvG+NOG07y3oHArKCDRJagBQPyhIAtuF7ldh9c2LPsGeelUftKNQlJcowJAu3hAo
         W7AA==
X-Gm-Message-State: ACrzQf1Bwe/KHJgr7EfCWRnHUZ+QVsFebRT8Crxd7m5Ttf+gG4TWHm/h
        DUEq/OiTYNKML0APSQ17/xS7DKThtQY=
X-Google-Smtp-Source: AMsMyM4EfO7Yu36nXNQxP44KJumCy0LCRdODfi6c5TwBhVfVyPKyHk+I+VY17wAGISa3RKRI1XQDeg==
X-Received: by 2002:a5d:5611:0:b0:228:e1d2:81d with SMTP id l17-20020a5d5611000000b00228e1d2081dmr17431019wrv.210.1664287717313;
        Tue, 27 Sep 2022 07:08:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h7-20020adffd47000000b0022c906ffedasm1854072wrs.70.2022.09.27.07.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 07:08:36 -0700 (PDT)
Message-Id: <e06cb4df081bc2222731f9185a22ed7ad67e3814.1664287711.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1369.git.1664287711.gitgitgadget@gmail.com>
References: <pull.1369.git.1664287711.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Sep 2022 14:08:31 +0000
Subject: [PATCH 5/5] *: expect a non-NULL list of config values
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The previous change altered the multi-valued config API to return an
empty list intead of a NULL list. Update all callers to rely on the
non-NULL result and instead check for an empty list.

Several callers only checked for a NULL list so they could safely call
for_each_string_list_item(), which no-ops on an empty list.

The bitmap_preferred_tips() method is a thin wrapper on the config API,
so its callers are also updated to match this expectation.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/for-each-repo.c     |  8 --------
 builtin/gc.c                | 20 ++++++++------------
 builtin/log.c               | 10 ++++------
 builtin/pack-objects.c      |  3 ---
 builtin/repack.c            | 13 +++++--------
 builtin/submodule--helper.c | 10 ++--------
 config.c                    |  2 +-
 pack-bitmap.c               |  3 ---
 t/helper/test-config.c      |  2 +-
 9 files changed, 21 insertions(+), 50 deletions(-)

diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
index fd86e5a8619..635ea5e15fd 100644
--- a/builtin/for-each-repo.c
+++ b/builtin/for-each-repo.c
@@ -44,14 +44,6 @@ int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
 
 	values = repo_config_get_value_multi(the_repository,
 					     config_key);
-
-	/*
-	 * Do nothing on an empty list, which is equivalent to the case
-	 * where the config variable does not exist at all.
-	 */
-	if (!values)
-		return 0;
-
 	for (i = 0; !result && i < values->nr; i++)
 		result = run_command_on_repo(values->items[i].string, argc, argv);
 
diff --git a/builtin/gc.c b/builtin/gc.c
index 7a585f0b71d..1e9ac2ac7e3 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1493,12 +1493,10 @@ static int maintenance_register(int argc, const char **argv, const char *prefix)
 		git_config_set("maintenance.strategy", "incremental");
 
 	list = git_config_get_value_multi(key);
-	if (list) {
-		for_each_string_list_item(item, list) {
-			if (!strcmp(maintpath, item->string)) {
-				found = 1;
-				break;
-			}
+	for_each_string_list_item(item, list) {
+		if (!strcmp(maintpath, item->string)) {
+			found = 1;
+			break;
 		}
 	}
 
@@ -1550,12 +1548,10 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
 				   options);
 
 	list = git_config_get_value_multi(key);
-	if (list) {
-		for_each_string_list_item(item, list) {
-			if (!strcmp(maintpath, item->string)) {
-				found = 1;
-				break;
-			}
+	for_each_string_list_item(item, list) {
+		if (!strcmp(maintpath, item->string)) {
+			found = 1;
+			break;
 		}
 	}
 
diff --git a/builtin/log.c b/builtin/log.c
index ee19dc5d450..719ef966045 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -182,15 +182,13 @@ static void set_default_decoration_filter(struct decoration_filter *decoration_f
 	int i;
 	char *value = NULL;
 	struct string_list *include = decoration_filter->include_ref_pattern;
+	struct string_list_item *item;
 	const struct string_list *config_exclude =
 			git_config_get_value_multi("log.excludeDecoration");
 
-	if (config_exclude) {
-		struct string_list_item *item;
-		for_each_string_list_item(item, config_exclude)
-			string_list_append(decoration_filter->exclude_ref_config_pattern,
-					   item->string);
-	}
+	for_each_string_list_item(item, config_exclude)
+		string_list_append(decoration_filter->exclude_ref_config_pattern,
+				   item->string);
 
 	/*
 	 * By default, decorate_all is disabled. Enable it if
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 3658c05cafc..d15e1857e67 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3982,9 +3982,6 @@ static void mark_bitmap_preferred_tips(void)
 	const struct string_list *preferred_tips;
 
 	preferred_tips = bitmap_preferred_tips(the_repository);
-	if (!preferred_tips)
-		return;
-
 	for_each_string_list_item(item, preferred_tips) {
 		for_each_ref_in(item->string, mark_bitmap_preferred_tip, NULL);
 	}
diff --git a/builtin/repack.c b/builtin/repack.c
index a5bacc77974..1655747f6e0 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -539,6 +539,7 @@ static int midx_snapshot_ref_one(const char *refname UNUSED,
 static void midx_snapshot_refs(struct tempfile *f)
 {
 	struct midx_snapshot_ref_data data;
+	struct string_list_item *item;
 	const struct string_list *preferred = bitmap_preferred_tips(the_repository);
 
 	data.f = f;
@@ -549,14 +550,10 @@ static void midx_snapshot_refs(struct tempfile *f)
 		 die(_("could not open tempfile %s for writing"),
 		     get_tempfile_path(f));
 
-	if (preferred) {
-		struct string_list_item *item;
-
-		data.preferred = 1;
-		for_each_string_list_item(item, preferred)
-			for_each_ref_in(item->string, midx_snapshot_ref_one, &data);
-		data.preferred = 0;
-	}
+	data.preferred = 1;
+	for_each_string_list_item(item, preferred)
+		for_each_ref_in(item->string, midx_snapshot_ref_one, &data);
+	data.preferred = 0;
 
 	for_each_ref(midx_snapshot_ref_one, &data);
 
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 1ddc08b076c..5a8b6120157 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -531,7 +531,6 @@ static int module_init(int argc, const char **argv, const char *prefix)
 	struct init_cb info = INIT_CB_INIT;
 	struct pathspec pathspec = { 0 };
 	struct module_list list = MODULE_LIST_INIT;
-	const struct string_list *active_modules;
 	int quiet = 0;
 	struct option module_init_options[] = {
 		OPT__QUIET(&quiet, N_("suppress output for initializing a submodule")),
@@ -553,9 +552,7 @@ static int module_init(int argc, const char **argv, const char *prefix)
 	 * If there are no path args and submodule.active is set then,
 	 * by default, only initialize 'active' modules.
 	 */
-	if (!argc &&
-	    (active_modules = git_config_get_value_multi("submodule.active")) &&
-	    active_modules->nr)
+	if (!argc && git_config_get_value_multi("submodule.active")->nr)
 		module_list_active(&list);
 
 	info.prefix = prefix;
@@ -2709,7 +2706,6 @@ static int module_update(int argc, const char **argv, const char *prefix)
 		opt.warn_if_uninitialized = 1;
 
 	if (opt.init) {
-		const struct string_list *active_modules;
 		struct module_list list = MODULE_LIST_INIT;
 		struct init_cb info = INIT_CB_INIT;
 
@@ -2724,9 +2720,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
 		 * If there are no path args and submodule.active is set then,
 		 * by default, only initialize 'active' modules.
 		 */
-		if (!argc &&
-		    (active_modules = git_config_get_value_multi("submodule.active")) &&
-		    active_modules->nr)
+		if (!argc && git_config_get_value_multi("submodule.active")->nr)
 			module_list_active(&list);
 
 		info.prefix = opt.prefix;
diff --git a/config.c b/config.c
index 2d4ca1ae6dc..8bd55688352 100644
--- a/config.c
+++ b/config.c
@@ -2407,7 +2407,7 @@ int git_configset_get_value(struct config_set *cs, const char *key, const char *
 	 */
 	values = git_configset_get_value_multi(cs, key);
 
-	if (!values || !values->nr)
+	if (!values->nr)
 		return 1;
 	*value = values->items[values->nr - 1].string;
 	return 0;
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 9a208abc1fd..77d02c7bbe7 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -2310,9 +2310,6 @@ int bitmap_is_preferred_refname(struct repository *r, const char *refname)
 	const struct string_list *preferred_tips = bitmap_preferred_tips(r);
 	struct string_list_item *item;
 
-	if (!preferred_tips)
-		return 0;
-
 	for_each_string_list_item(item, preferred_tips) {
 		if (starts_with(refname, item->string))
 			return 1;
diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index 62644dd71d7..90810946783 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -96,7 +96,7 @@ int cmd__config(int argc, const char **argv)
 		}
 	} else if (argc == 3 && !strcmp(argv[1], "get_value_multi")) {
 		strptr = git_config_get_value_multi(argv[2]);
-		if (strptr && strptr->nr) {
+		if (strptr->nr) {
 			for (i = 0; i < strptr->nr; i++) {
 				v = strptr->items[i].string;
 				if (!v)
-- 
gitgitgadget
