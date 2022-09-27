Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292B0C07E9D
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 14:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbiI0OI5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 10:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbiI0OIk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 10:08:40 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371A91B8684
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 07:08:37 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id s14so15280680wro.0
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 07:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=XYbnFDf2MZBD2c52vTp+VH7tcBC2r81gJwGfNwxyf5A=;
        b=feYkJBVbio9d2AqnFQzmJhT3Hcw2TP34MeaXLcG335kepTueb7CyttYYN4spsPz3i3
         +1Nq8YcvMpsCd5JjEWerThl1hkqk+KZmzqtUS8HIZVVXgoKA+CR8s+T86SX/PeMSMbIQ
         QY/VPiQK9ozDlRV2pJLsbm4zEB7SRTIeiTjuXYp6IoVzq76Q2k92bqFQ866I6yhNpBIa
         jnTX1AIcMyCW6T9JWJMsDDVp+pFPArfQxx+4ijiXLMzLpo8G2RiZeAITkK+NrLoe318Z
         gZr0L6E78Vi/wq5oZsgD3QVrfkGqJztiyd1TFA/9OfV6zhksiOJnmWlUSFkZzyXn8X0p
         wFUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XYbnFDf2MZBD2c52vTp+VH7tcBC2r81gJwGfNwxyf5A=;
        b=C245trFpShkErGCbYYaIfk0vL2qcRfNsr6DSwC85g73MTh8b4RnI55WPIOXiTELzTK
         ak+MVPQuAFbqBuGf5/GEZiB/HBwfKEeyI8rdFDSFXwaKScInm/T6v2w3qmzVK37TmQ3A
         KDHQfsPkiRTy0w7jqf35EXHm7qCrSxVcDYTEYJZSV3xae2RHiOp70m2zBQLavZwDQoZP
         7DcgCp8/UAC9zEDerYYo6vxU3AuIk8w+ZHvvk7EhKe2ihZEy4W7dbEv33DhH0F75HcN+
         +HjGgWQiQ69YuiQgCduOPwUvVJC0yfWI63V/CLi7qVWX2JtRWCy0dwaQrqQRqnxeC9ty
         eU8w==
X-Gm-Message-State: ACrzQf1hAQFKCEnIzNemlUpyOXARikhjTGHya7sFC0o/i9J7asnYhnFl
        4vTk5/QGsm2noIsrbIrZE1r/+0QoXS8=
X-Google-Smtp-Source: AMsMyM7H7Sv+hizfEOO+XySwjyQjMMGHprq2ynneX/MAc7pPmJrnlZM6NVhKkZOiiptXgqUe/9LDyg==
X-Received: by 2002:a05:6000:1446:b0:22b:968:446 with SMTP id v6-20020a056000144600b0022b09680446mr16700375wrx.493.1664287714799;
        Tue, 27 Sep 2022 07:08:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t126-20020a1c4684000000b003b505d26776sm13871941wma.5.2022.09.27.07.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 07:08:34 -0700 (PDT)
Message-Id: <af036388d4e5abe35c23acf4210d46cd69b2d264.1664287711.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1369.git.1664287711.gitgitgadget@gmail.com>
References: <pull.1369.git.1664287711.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Sep 2022 14:08:28 +0000
Subject: [PATCH 2/5] *: relax git_configset_get_value_multi result
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

We will change the config API to return an empty list instead of a NULL
list when there are no values in a multi-valued key. Update checks that
look for NULL and have them instead check for NULL or empty lists.

There are other checks that look for NULL, but then do an operation that
would be a no-op on an empty list. These are not modified here but will
be modified after we change the behavior of the config API.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/submodule--helper.c | 10 ++++++++--
 submodule.c                 |  2 +-
 t/helper/test-config.c      |  4 ++--
 versioncmp.c                |  8 ++++----
 4 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 0b4acb442b2..1ddc08b076c 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -531,6 +531,7 @@ static int module_init(int argc, const char **argv, const char *prefix)
 	struct init_cb info = INIT_CB_INIT;
 	struct pathspec pathspec = { 0 };
 	struct module_list list = MODULE_LIST_INIT;
+	const struct string_list *active_modules;
 	int quiet = 0;
 	struct option module_init_options[] = {
 		OPT__QUIET(&quiet, N_("suppress output for initializing a submodule")),
@@ -552,7 +553,9 @@ static int module_init(int argc, const char **argv, const char *prefix)
 	 * If there are no path args and submodule.active is set then,
 	 * by default, only initialize 'active' modules.
 	 */
-	if (!argc && git_config_get_value_multi("submodule.active"))
+	if (!argc &&
+	    (active_modules = git_config_get_value_multi("submodule.active")) &&
+	    active_modules->nr)
 		module_list_active(&list);
 
 	info.prefix = prefix;
@@ -2706,6 +2709,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
 		opt.warn_if_uninitialized = 1;
 
 	if (opt.init) {
+		const struct string_list *active_modules;
 		struct module_list list = MODULE_LIST_INIT;
 		struct init_cb info = INIT_CB_INIT;
 
@@ -2720,7 +2724,9 @@ static int module_update(int argc, const char **argv, const char *prefix)
 		 * If there are no path args and submodule.active is set then,
 		 * by default, only initialize 'active' modules.
 		 */
-		if (!argc && git_config_get_value_multi("submodule.active"))
+		if (!argc &&
+		    (active_modules = git_config_get_value_multi("submodule.active")) &&
+		    active_modules->nr)
 			module_list_active(&list);
 
 		info.prefix = opt.prefix;
diff --git a/submodule.c b/submodule.c
index bf7a2c79183..06230961c80 100644
--- a/submodule.c
+++ b/submodule.c
@@ -275,7 +275,7 @@ int is_tree_submodule_active(struct repository *repo,
 
 	/* submodule.active is set */
 	sl = repo_config_get_value_multi(repo, "submodule.active");
-	if (sl) {
+	if (sl && sl->nr) {
 		struct pathspec ps;
 		struct strvec args = STRVEC_INIT;
 		const struct string_list_item *item;
diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index 4ba9eb65606..62644dd71d7 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -96,7 +96,7 @@ int cmd__config(int argc, const char **argv)
 		}
 	} else if (argc == 3 && !strcmp(argv[1], "get_value_multi")) {
 		strptr = git_config_get_value_multi(argv[2]);
-		if (strptr) {
+		if (strptr && strptr->nr) {
 			for (i = 0; i < strptr->nr; i++) {
 				v = strptr->items[i].string;
 				if (!v)
@@ -160,7 +160,7 @@ int cmd__config(int argc, const char **argv)
 			}
 		}
 		strptr = git_configset_get_value_multi(&cs, argv[2]);
-		if (strptr) {
+		if (strptr && strptr->nr) {
 			for (i = 0; i < strptr->nr; i++) {
 				v = strptr->items[i].string;
 				if (!v)
diff --git a/versioncmp.c b/versioncmp.c
index 069ee94a4d7..8772f869042 100644
--- a/versioncmp.c
+++ b/versioncmp.c
@@ -164,14 +164,14 @@ int versioncmp(const char *s1, const char *s2)
 		initialized = 1;
 		prereleases = git_config_get_value_multi("versionsort.suffix");
 		deprecated_prereleases = git_config_get_value_multi("versionsort.prereleasesuffix");
-		if (prereleases) {
-			if (deprecated_prereleases)
+		if (prereleases && prereleases->nr) {
+			if (deprecated_prereleases && deprecated_prereleases->nr)
 				warning("ignoring versionsort.prereleasesuffix because versionsort.suffix is set");
 		} else
 			prereleases = deprecated_prereleases;
 	}
-	if (prereleases && swap_prereleases(s1, s2, (const char *) p1 - s1 - 1,
-					    &diff))
+	if (prereleases && prereleases->nr &&
+	    swap_prereleases(s1, s2, (const char *) p1 - s1 - 1, &diff))
 		return diff;
 
 	state = result_type[state * 3 + (((c2 == '0') + (isdigit (c2) != 0)))];
-- 
gitgitgadget

