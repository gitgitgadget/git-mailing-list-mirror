Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287F3C433EF
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 05:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236459AbiBYFYK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 00:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236363AbiBYFYI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 00:24:08 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5DC21DF22
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 21:23:23 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id p9so2709366wra.12
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 21:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MuawZ40CnhXHML7tFAJyfFOw3UI22zmSfvmTe20SdDI=;
        b=FDOFn9nvrQ2S12ZTU01iRWIaGU1I76Sx80akssQl1E5+na2fTZHb2d7yE1/hke5Riu
         Q+JW3qIc2h3IP1DpBTBMgavdIFoyAxVZFNnVubIxvu3u+5H2AVQcbHaYn1harBQmnU5x
         GC4yAnEjDeHhrGHA06ju9I7Kx8ONg6mjY8+/QCdmexxPIq1AcJd0DJRxKv5y3QA7Xf9g
         ny+QRUa953gcDxzUBtH3FU+C0TpWlqqaIX8w7gLkYLajmGMmiThveN3gjo8TqheGkSbY
         VY77Rh1uF4RlGWEAmzFefX8T8Z4AACezw0c2Pa+Vwv32ySd/KZp3X+a2DxBy4GFpQzFs
         YWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MuawZ40CnhXHML7tFAJyfFOw3UI22zmSfvmTe20SdDI=;
        b=L1adFVOPpGsRP6TOAKRMkd40zK9FDziEsiSz64RIl4LVa1dOh8g6zptMOHF+Lh2ri7
         9dIZdRF/5zr3Iq4oxvzqPekXg5wSxp7K34g+0hzgp0p0F9WfM/NZYYCACWS1SontR4gJ
         MTVl8Qcq6dl1i7X9ipdwyK6h+UGi2265Npg7MjOU/Drcwej3uRoK4l9TbFscAk8WbFtQ
         9LzpYkrDgRMlfqZgKlc/hlKMnCfUhtZzwFP6Pn/+Nys4KpQFoFMEDg+6iiu+Iusg1JQq
         UPDqtcA5tKmc76X4Lu0eDx88DcxsCkVKVaKRVrNVNb8Tt7Mpi3rrTCKp61fhhnWkkkvz
         gh9A==
X-Gm-Message-State: AOAM530mYmCLH2MiT9phiCkAMmww2BXqEHeD6u3gTNHuWOHfYDx07Q69
        tVImrId4Zj7CeejUv6ZI8gjRQzFtWMQ=
X-Google-Smtp-Source: ABdhPJzFEvY3od3kO/qmwvfBGJcfxWUq3Td/VbU1adBxQAVJTOTVTUCpBWH04oO95wHswakFwdweng==
X-Received: by 2002:a5d:588d:0:b0:1e9:3adc:fec6 with SMTP id n13-20020a5d588d000000b001e93adcfec6mr4600109wrf.125.1645766601621;
        Thu, 24 Feb 2022 21:23:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o18-20020a05600c511200b00352ec3b4c5asm1365859wms.7.2022.02.24.21.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 21:23:21 -0800 (PST)
Message-Id: <dc200d098aefc0a66d6bfc304697a66f6904cc11.1645766599.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1147.v4.git.1645766599.gitgitgadget@gmail.com>
References: <pull.1147.v3.git.1645626455.gitgitgadget@gmail.com>
        <pull.1147.v4.git.1645766599.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Feb 2022 05:23:18 +0000
Subject: [PATCH v4 1/2] amend remaining usage strings according to style guide
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
        Junio C Hamano <gitster@pobox.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>

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

