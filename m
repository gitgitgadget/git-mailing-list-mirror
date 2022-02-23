Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EEBC433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 14:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241562AbiBWO2I (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 09:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241557AbiBWO2G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 09:28:06 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B453FB0D0D
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 06:27:38 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id n25-20020a05600c3b9900b00380f41e51e6so1466617wms.2
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 06:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=w8iGpfrC4gln9yfbTzzdR/UkF31WZul5d8WLQDRWN4o=;
        b=BbDZcRrRoE/4oULozTIxviADKxo6A/6HiW4e1nvEEy2Xrjt0Hh172i34WpRA18Mkxc
         xZmQTSnn3zsBcG0JhN8L6p1qflajEZn73vB26vi/hlyNLj4KTs6JvDvYhti2JboJHhk0
         eMsq64jAUwmXbQVfT+OlkCzzGX1xIfC9RVKvZ/YcvbSjsSlgufMfwvl8rT8Kne6dKZ1Y
         S0DvWw14yRo3NsI7yCPlTiFDWgZSelKIQ1EdRZkIG1qQrvaFaghlDxnqE+t2mJz3nic+
         at9dwWtxuXAaYQSy697bTsu6aGo+kj9ag0oJylc5kY0+C/1CN0TlyXb2CLinz//mIz5O
         t/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=w8iGpfrC4gln9yfbTzzdR/UkF31WZul5d8WLQDRWN4o=;
        b=TpJQ8hDb2az1O7mRhVBAav73dcmgcG9cR3To2T6cH+E+XSKQeip3U7V6fS/w6XFwu+
         s2ZGI9/x1cFw7iy/U715wgkkQTIIuY8Qu9RL3ogWkl2WiTIxEQ2I9oj4oNLfeRnUvJhP
         W1ZJ3moUVJeT1IriXxOLeowK91+pYj9Z5iLbDf0B+4tYibCg3I9vNL4WZksjBiIJtu4H
         03U/XwsMqtCUabMDPpEcnG3pGT1sJkSPCmHDdSEl/LVhV2Uj25/LXpN2F7rsbWYlKAeb
         kqGYDU0Sqzf81CTW+yIGVhJcEEekuGT+hiO6dHV7iWhyyqGruK3NKaR3/Kn0fJx5rjue
         1R4w==
X-Gm-Message-State: AOAM533sTkRwxKbjhZoXXvIsRsmDd/7BlGqFsCfjI54Cqq/F65qMsrRG
        IDGyKPiy4KBwwUYpYS7pdzKJImOmFV0=
X-Google-Smtp-Source: ABdhPJy5fIPClWlmFBDg5F1ec7++ogTTjfq8+ygijY592Q6tZACotPLj1IWh4kBYy87TqHbP3SY70g==
X-Received: by 2002:a05:600c:1c9a:b0:37b:bbbd:b8db with SMTP id k26-20020a05600c1c9a00b0037bbbbdb8dbmr7791396wms.185.1645626457141;
        Wed, 23 Feb 2022 06:27:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f3sm23583453wri.6.2022.02.23.06.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 06:27:36 -0800 (PST)
Message-Id: <f425e36b7ea4a310a8ad93d47ead4c1713117388.1645626455.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1147.v3.git.1645626455.gitgitgadget@gmail.com>
References: <pull.1147.v2.git.1645545507689.gitgitgadget@gmail.com>
        <pull.1147.v3.git.1645626455.gitgitgadget@gmail.com>
From:   "Abhra303 via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 14:27:34 +0000
Subject: [PATCH v3 1/2] amend remaining usage strings according to style guide
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Julia Lawall <julia.lawall@inria.fr>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Abhra303 <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhra303 <chakrabortyabhradeep79@gmail.com>

Usage strings for git (sub)command flags has a style guide that
suggests - first letter should not capitalized (unless required)
and it should skip full-stop at the end of line. But there are
some files where usage-strings do not follow the above mentioned
guide.

Amend the usage strings that don't follow the style convention/guide.

Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
---
 builtin/bisect--helper.c    | 2 +-
 builtin/reflog.c            | 6 +++---
 builtin/submodule--helper.c | 2 +-
 diff.c                      | 2 +-
 t/helper/test-run-command.c | 6 +++---
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 28a2e6a5750..614d95b022c 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1209,7 +1209,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE(0, "bisect-visualize", &cmdmode,
 			 N_("visualize the bisection"), BISECT_VISUALIZE),
 		OPT_CMDMODE(0, "bisect-run", &cmdmode,
-			 N_("use <cmd>... to automatically bisect."), BISECT_RUN),
+			 N_("use <cmd>... to automatically bisect"), BISECT_RUN),
 		OPT_BOOL(0, "no-log", &nolog,
 			 N_("no log for BISECT_WRITE")),
 		OPT_END()
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 85b838720c3..28372c5e2b5 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -600,7 +600,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		OPT_BIT(0, "updateref", &flags,
 			N_("update the reference to the value of the top reflog entry"),
 			EXPIRE_REFLOGS_UPDATE_REF),
-		OPT_BOOL(0, "verbose", &verbose, N_("print extra information on screen.")),
+		OPT_BOOL(0, "verbose", &verbose, N_("print extra information on screen")),
 		OPT_CALLBACK_F(0, "expire", &cmd, N_("timestamp"),
 			       N_("prune entries older than the specified time"),
 			       PARSE_OPT_NONEG,
@@ -613,7 +613,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 			 N_("prune any reflog entries that point to broken commits")),
 		OPT_BOOL(0, "all", &do_all, N_("process the reflogs of all references")),
 		OPT_BOOL(1, "single-worktree", &all_worktrees,
-			 N_("limits processing to reflogs from the current worktree only.")),
+			 N_("limits processing to reflogs from the current worktree only")),
 		OPT_END()
 	};
 
@@ -736,7 +736,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 		OPT_BIT(0, "updateref", &flags,
 			N_("update the reference to the value of the top reflog entry"),
 			EXPIRE_REFLOGS_UPDATE_REF),
-		OPT_BOOL(0, "verbose", &verbose, N_("print extra information on screen.")),
+		OPT_BOOL(0, "verbose", &verbose, N_("print extra information on screen")),
 		OPT_END()
 	};
 
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 33c82c3ab91..6332d305983 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1875,7 +1875,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "depth", &clone_data.depth,
 			   N_("string"),
 			   N_("depth for shallow clones")),
-		OPT__QUIET(&quiet, "Suppress output for cloning a submodule"),
+		OPT__QUIET(&quiet, "suppress output for cloning a submodule"),
 		OPT_BOOL(0, "progress", &progress,
 			   N_("force cloning progress")),
 		OPT_BOOL(0, "require-init", &require_init,
diff --git a/diff.c b/diff.c
index 7d5cfd325ea..387435a4a45 100644
--- a/diff.c
+++ b/diff.c
@@ -5630,7 +5630,7 @@ static void prep_parse_options(struct diff_options *options)
 			       N_("select files by diff type"),
 			       PARSE_OPT_NONEG, diff_opt_diff_filter),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
-		  N_("Output to a specific file"),
+		  N_("output to a specific file"),
 		  PARSE_OPT_NONEG, NULL, 0, diff_opt_output },
 
 		OPT_END()
diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index 913775a14b7..8f370cd89f1 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -221,9 +221,9 @@ static int quote_stress_test(int argc, const char **argv)
 	struct strbuf out = STRBUF_INIT;
 	struct strvec args = STRVEC_INIT;
 	struct option options[] = {
-		OPT_INTEGER('n', "trials", &trials, "Number of trials"),
-		OPT_INTEGER('s', "skip", &skip, "Skip <n> trials"),
-		OPT_BOOL('m', "msys2", &msys2, "Test quoting for MSYS2's sh"),
+		OPT_INTEGER('n', "trials", &trials, "number of trials"),
+		OPT_INTEGER('s', "skip", &skip, "skip <n> trials"),
+		OPT_BOOL('m', "msys2", &msys2, "test quoting for MSYS2's sh"),
 		OPT_END()
 	};
 	const char * const usage[] = {
-- 
gitgitgadget

