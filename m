Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5396BC433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 18:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245500AbiCWSTh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 14:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244944AbiCWSTf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 14:19:35 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06957BFE
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 11:18:04 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id r64so1449550wmr.4
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 11:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2da9skEclmvTsi3KOJ4k0kUBUQr5+MHZsz1pN9h9QWk=;
        b=KirW+y4yYUCUcrjaD7mDJkQOnaNyfIyS9zDma6xqreDRyRq4w88sRYtNvtDnOSGndU
         BQq5Q07zZ1O6kbNhRZmJcuhKrXj0kOF9vM2IFnz60E5WGo4XqTdIw9tYRW3l+XHLm4hc
         GQVcWAhERCHYSlHbckbrB+B2X4G0ikF5Ivy41iK1uDcSLLeZXUZL8UArrjrJqF96yA4D
         JvJjOwnpPbEzeDxJnwqqixrNo9tdEddFaE51xXXOXchqCjinccfdgwMZ8wz/GO6j8fxl
         OAnOR+mHHcjLK8FUPBSrdZs9MVQy7zNmTWebBL2mgHfgeDKRa8/xQITUySL88PONoBDt
         eWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2da9skEclmvTsi3KOJ4k0kUBUQr5+MHZsz1pN9h9QWk=;
        b=G8/bbwzgabGocLMJRVc5qquo18vdfvGVGVQYHfwnIW0PYdp6gar5s+yBrHcbgE472w
         3WY/ZH1JYfayRtUpQSrlMy/o+i1Yq06YUF6OIOFwQe3zQUSXzpPiDXFk51zPkIsVt//r
         cHQVQQF+wIvc8pfCZ77qQve836nqHUgiL+45kPzHga1yqhGd+L0/EiOjcF55jxeTN+Np
         H/haguOPWczPBeO2/Aw0Vv/7Y0FpTOyEc8KWTmsYH1JnYmLwKVdPJCVruAdqtoXJC8Im
         5ExKTN66j7geKncIDw0mpqaU5b4SYR7ZySI+FJRicVnPiIUd/vPzB4QTSugTYDvwhSZX
         aopQ==
X-Gm-Message-State: AOAM531ApG5GG87JYM0ZAFLvj346L0JQaCJ6S2SUBshvoNOJRbWCswXL
        2KxyI2xg4b0abWBBJvYdIf4dr9hf254=
X-Google-Smtp-Source: ABdhPJykC+gVo5l7uc8mjAcATWT7yGmdE8BzQczD97JSmPPODh2VLH3R0hBCKvV8aL6NKrFOT31PCQ==
X-Received: by 2002:a05:600c:3c9b:b0:380:be98:6204 with SMTP id bg27-20020a05600c3c9b00b00380be986204mr10694418wmb.121.1648059482301;
        Wed, 23 Mar 2022 11:18:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i15-20020adffdcf000000b00203efad1d89sm659724wrs.9.2022.03.23.11.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 11:18:01 -0700 (PDT)
Message-Id: <1b607e0610b6535b2cc2bbda22eb57c4bf2d11e7.1648059480.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1184.v2.git.1648059480.gitgitgadget@gmail.com>
References: <pull.1184.git.1647894889.gitgitgadget@gmail.com>
        <pull.1184.v2.git.1648059480.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Mar 2022 18:17:58 +0000
Subject: [PATCH v2 1/3] reset: do not make '--quiet' disable index refresh
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, phillip.wood123@gmail.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Update '--quiet' to no longer implicitly skip refreshing the index in a
mixed reset. Users now have the ability to explicitly disable refreshing the
index with the '--no-refresh' option, so they no longer need to use
'--quiet' to do so. Moreover, we explicitly remove the refresh-skipping
behavior from '--quiet' because it is completely unrelated to the stated
purpose of the option: "Be quiet, only report errors."

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 Documentation/git-reset.txt |  5 +----
 builtin/reset.c             |  9 +--------
 t/t7102-reset.sh            | 32 +++++---------------------------
 3 files changed, 7 insertions(+), 39 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 89ddc85c2e4..bc1646c3016 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -114,10 +114,7 @@ OPTIONS
 --no-refresh::
 	Proactively refresh the index after a mixed reset. If unspecified, the
 	behavior falls back on the `reset.refresh` config option. If neither
-	`--[no-]refresh` nor `reset.refresh` are set, the default behavior is
-	decided by the `--[no-]quiet` option and/or `reset.quiet` config.
-	If `--quiet` is specified or `reset.quiet` is set with no command-line
-	"quiet" setting, refresh is disabled. Otherwise, refresh is enabled.
+	`--[no-]refresh` nor `reset.refresh` are set, refresh is enabled.
 
 --pathspec-from-file=<file>::
 	Pathspec is passed in `<file>` instead of commandline args. If
diff --git a/builtin/reset.c b/builtin/reset.c
index c8a356ec5b0..1804d0eeb84 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -392,7 +392,7 @@ static int git_reset_config(const char *var, const char *value, void *cb)
 int cmd_reset(int argc, const char **argv, const char *prefix)
 {
 	int reset_type = NONE, update_ref_status = 0, quiet = 0;
-	int refresh = -1;
+	int refresh = 1;
 	int patch_mode = 0, pathspec_file_nul = 0, unborn;
 	const char *rev, *pathspec_from_file = NULL;
 	struct object_id oid;
@@ -430,13 +430,6 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 						PARSE_OPT_KEEP_DASHDASH);
 	parse_args(&pathspec, argv, prefix, patch_mode, &rev);
 
-	/*
-	 * If refresh is completely unspecified (either by config or by command
-	 * line option), decide based on 'quiet'.
-	 */
-	if (refresh < 0)
-		refresh = !quiet;
-
 	if (pathspec_from_file) {
 		if (patch_mode)
 			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--patch");
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 1dc3911a060..8b62bb39b3d 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -485,25 +485,12 @@ test_reset_refreshes_index () {
 }
 
 test_expect_success '--mixed refreshes the index' '
-	# Verify default behavior (with no config settings or command line
-	# options)
-	test_reset_refreshes_index
-'
-test_expect_success '--mixed --[no-]quiet sets default refresh behavior' '
-	# Verify that --[no-]quiet and `reset.quiet` (without --[no-]refresh)
-	# determine refresh behavior
-
-	# Config setting
-	! test_reset_refreshes_index "-c reset.quiet=true" &&
-	test_reset_refreshes_index "-c reset.quiet=false" &&
-
-	# Command line option
-	! test_reset_refreshes_index "" --quiet &&
-	test_reset_refreshes_index "" --no-quiet &&
+	# Verify default behavior (without --[no-]refresh or reset.refresh)
+	test_reset_refreshes_index &&
 
-	# Command line option overrides config setting
-	! test_reset_refreshes_index "-c reset.quiet=false" --quiet &&
-	test_reset_refreshes_index "-c reset.refresh=true" --no-quiet
+	# With --quiet & reset.quiet
+	test_reset_refreshes_index "-c reset.quiet=true" &&
+	test_reset_refreshes_index "" --quiet
 '
 
 test_expect_success '--mixed --[no-]refresh sets refresh behavior' '
@@ -522,15 +509,6 @@ test_expect_success '--mixed --[no-]refresh sets refresh behavior' '
 	! test_reset_refreshes_index "-c reset.refresh=true" --no-refresh
 '
 
-test_expect_success '--mixed --refresh overrides --quiet refresh behavior' '
-	# Verify that *both* --refresh and `reset.refresh` override the
-	# default non-refresh behavior of --quiet
-	test_reset_refreshes_index "" "--quiet --refresh" &&
-	test_reset_refreshes_index "-c reset.quiet=true" --refresh &&
-	test_reset_refreshes_index "-c reset.refresh=true" --quiet &&
-	test_reset_refreshes_index "-c reset.refresh=true -c reset.quiet=true"
-'
-
 test_expect_success '--mixed preserves skip-worktree' '
 	echo 123 >>file2 &&
 	git add file2 &&
-- 
gitgitgadget

