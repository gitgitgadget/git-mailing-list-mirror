Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0202C433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 18:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245584AbiCWSTm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 14:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245451AbiCWSTh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 14:19:37 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046F8BC30
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 11:18:05 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id m30so3343490wrb.1
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 11:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RnTrnB0YZMItf5oX2LhTBiW50PgAE/FsbTVw2Bm3ifY=;
        b=IB+a7ujheMf46EeiYbMAw26WsGenYJjwJQaKE8RpuqZ5tBuXW5hSbJXBTt02vr5bw2
         KpfJYHQozFNLIpdTOTr1is+NJHAJsVZAJ+qxKriz8AE7WIF9K+MGyhOv754ccBKopj6g
         wFBK9seYhoyoyDKROTkypPie94kMHx5SthW6ZldNJjO6O5B7ibaFpm+GIQEudiKq/6fM
         TnhK2Dz+HAjUWtSO/G9JRraddORAx4zqgcX1RnjhOl2KZ3qzT9hjdIkvFIqcpkpA2ag1
         3Rkx+brwFLcnijC8fZPMUTkQRC1SCHl/B3qF4TgdXNwezPnHOqnagBc2i9VM24K3SfC2
         BFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RnTrnB0YZMItf5oX2LhTBiW50PgAE/FsbTVw2Bm3ifY=;
        b=a+lpUT341pPVGuhdHIhAR0jjWq/JznoqQ6ZVd8zvqFyi2rBYcghXx2Vt+VX5mw01xd
         9Bof9qYbQBPixQl4lFMVNa33ZvnliiON0q7+Y7pu39GjXRMgYcmwvAdLnxa/ecjJqTbT
         S850aAHkmizp3m+iFMy2BLZ+e68H8Zrmu3i77YPoWpp0yMVfZxnpCbknEBa/qDL9kOev
         N9ivlJFy2iPqIvP+d6WsQYq/mWFxDQRMR8HGWlvXP9EFVM9QFkKdIrnfvrDjhXH19zV4
         CFdh6v2EU2s8YzPU8akxjGJWqhTOdOVAQs822GI8nZzg0Hd0k1dkmXvZv9xR4CPZkhWY
         /7dQ==
X-Gm-Message-State: AOAM533SK2cfTvx1aPWfV+U2Mzujjf4aYKl0UG+hbggXJ0UupU3JrfH/
        5E5b2txqeOj2e9WMxgYLA06KcWzhj3k=
X-Google-Smtp-Source: ABdhPJyoHHTYeyRfsU/VGmPPuNYPuogpi/RPGt0hhDnEXs/pzA+QJDVOQ9pRZWk+bPWuAUHsahYrfw==
X-Received: by 2002:a05:6000:186c:b0:205:3479:ad85 with SMTP id d12-20020a056000186c00b002053479ad85mr1179667wri.54.1648059484038;
        Wed, 23 Mar 2022 11:18:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id az19-20020a05600c601300b0038cadf3aa69sm6296157wmb.36.2022.03.23.11.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 11:18:03 -0700 (PDT)
Message-Id: <597aa82851c77b79bd296f9c3c9bab8907fe0e95.1648059480.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1184.v2.git.1648059480.gitgitgadget@gmail.com>
References: <pull.1184.git.1647894889.gitgitgadget@gmail.com>
        <pull.1184.v2.git.1648059480.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Mar 2022 18:18:00 +0000
Subject: [PATCH v2 3/3] reset: remove 'reset.refresh' config option
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

Remove the 'reset.refresh' option, requiring that users explicitly specify
'--no-refresh' if they want to skip refreshing the index.

The 'reset.refresh' option was introduced in 101cee42dd (reset: introduce
--[no-]refresh option to --mixed, 2022-03-11) as a replacement for the
refresh-skipping behavior originally controlled by 'reset.quiet'.

Although 'reset.refresh=false' functionally served the same purpose as
'reset.quiet=true', it exposed [1] the fact that the existence of a global
"skip refresh" option could potentially cause problems for users. Allowing a
global config option to avoid refreshing the index forces scripts using 'git
reset --mixed' to defensively use '--refresh' if index refresh is expected;
if that option is missing, behavior of a script could vary from user-to-user
without explanation.

Furthermore, globally disabling index refresh in 'reset --mixed' was
initially devised as a passive performance improvement; since the
introduction of the option, other changes have been made to Git (e.g., the
sparse index) with a greater potential performance impact without
sacrificing index correctness. Therefore, we can more aggressively err on
the side of correctness and limit the cases of skipping index refresh to
only when a user specifies the '--no-refresh' option.

[1] https://lore.kernel.org/git/xmqqy2179o3c.fsf@gitster.g/

Signed-off-by: Victoria Dye <vdye@github.com>
---
 Documentation/git-reset.txt |  4 +---
 builtin/reset.c             |  4 +---
 t/t7102-reset.sh            | 14 ++------------
 3 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index f4aca9dd35c..01cb4c9b9c5 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -109,9 +109,7 @@ OPTIONS
 
 --refresh::
 --no-refresh::
-	Proactively refresh the index after a mixed reset. If unspecified, the
-	behavior falls back on the `reset.refresh` config option. If neither
-	`--[no-]refresh` nor `reset.refresh` are set, refresh is enabled.
+	Refresh the index after a mixed reset. Enabled by default.
 
 --pathspec-from-file=<file>::
 	Pathspec is passed in `<file>` instead of commandline args. If
diff --git a/builtin/reset.c b/builtin/reset.c
index 9ce55afd1be..1d89faef5ec 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -423,7 +423,6 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	};
 
 	git_config(git_reset_config, NULL);
-	git_config_get_bool("reset.refresh", &refresh);
 
 	argc = parse_options(argc, argv, prefix, options, git_reset_usage,
 						PARSE_OPT_KEEP_DASHDASH);
@@ -529,8 +528,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 				t_delta_in_ms = (getnanotime() - t_begin) / 1000000;
 				if (!quiet && advice_enabled(ADVICE_RESET_NO_REFRESH_WARNING) && t_delta_in_ms > REFRESH_INDEX_DELAY_WARNING_IN_MS) {
 					advise(_("It took %.2f seconds to refresh the index after reset.  You can use\n"
-						 "'--no-refresh' to avoid this.  Set the config setting reset.refresh to false\n"
-						 "to make this the default."), t_delta_in_ms / 1000.0);
+						 "'--no-refresh' to avoid this."), t_delta_in_ms / 1000.0);
 				}
 			}
 		} else {
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 9e4c4deee35..22477f3a312 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -493,19 +493,9 @@ test_expect_success '--mixed refreshes the index' '
 '
 
 test_expect_success '--mixed --[no-]refresh sets refresh behavior' '
-	# Verify that --[no-]refresh and `reset.refresh` control index refresh
-
-	# Config setting
-	test_reset_refreshes_index "-c reset.refresh=true" &&
-	! test_reset_refreshes_index "-c reset.refresh=false" &&
-
-	# Command line option
+	# Verify that --[no-]refresh controls index refresh
 	test_reset_refreshes_index "" --refresh &&
-	! test_reset_refreshes_index "" --no-refresh &&
-
-	# Command line option overrides config setting
-	test_reset_refreshes_index "-c reset.refresh=false" --refresh &&
-	! test_reset_refreshes_index "-c reset.refresh=true" --no-refresh
+	! test_reset_refreshes_index "" --no-refresh
 '
 
 test_expect_success '--mixed preserves skip-worktree' '
-- 
gitgitgadget
