Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7C6C433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 20:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392287AbiDUUVf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 16:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbiDUUV3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 16:21:29 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609164C794
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 13:18:38 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id v12so1389050wrv.10
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 13:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6stZ5HXFd1+azh7kkuovAqfutfEdm8mOSCsi6uKfItU=;
        b=O7a1RpSZ6qdV0WHk/bFq6Vb7HdiD7748p69yEn3ExHvzYiwoT5HuZZIl1LvT88IWUi
         RaJSU4nRvtc9rIWd/qHNYd3+EgVXiHlZhry3IB0EXpwkCpBhQGYN6B9cxUiRF1SYiya1
         tTEdZCIXPetkLU6ccQ8IeyLUyfH+vFvvhGoZcFpkI8m6vRTERTvBjKquUkz3icmyaQ3x
         wRlgfys/G8/g9m9SIBMZqM1FhOMjqI4rvMWN316ARRAb2AKOzAS9TejGfcsNT/U/v4L+
         VMpLBk9kyE3hUNGz5u6NLTMiJpd9u4GbKlHSBYOqi5t2FXVvpnsmWVGXZ7GKSvdu3D8z
         9efg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6stZ5HXFd1+azh7kkuovAqfutfEdm8mOSCsi6uKfItU=;
        b=rTMIoTytESjY+V+rR7K+Hj9UDqSmjSAOU0IyvPyINQcWnsFUpJPzpC1PyouZc2gVw4
         LG4h1L4hRljYAJl/gtgEGGCRaFXi6KK9IxARfX7JMDgIAgIcD6u7W6eQM/mKNoCRhisZ
         ES4m1bjetxwEfgL358d0dE3MGRnV3GwBu+9TkDTvIBRMGpsZukpOX7C266Djd+uzKrd+
         qs03tfI3Pzq6lvxa5tM2dOGRaRYTjYogKSJUNJ/4pa/IngZK7pIWeSCNgpG3vstveC85
         uGfM28KkxN+IX1HQvAAwYX0XtTowYSpDnzArk4LMbn4ZNzYGvtld/LpAIAwXot/sEIWd
         amxg==
X-Gm-Message-State: AOAM532nCCVDmt43eVaYFZpXGsQLNiMSmQ52xRwY7UrC2/So6Sw/g4Ae
        KsnM6TiU2NVmyP2wuABqWeQvimdbgDs=
X-Google-Smtp-Source: ABdhPJwPvO4G2Ot8SX1xyNOL+IxG3+nO4D0D5ljyyPZ61T2eNJRUdvs3K4fmpZxW/ivacMaUQAQEfg==
X-Received: by 2002:adf:e110:0:b0:205:b611:7a6b with SMTP id t16-20020adfe110000000b00205b6117a6bmr1034833wrz.20.1650572316008;
        Thu, 21 Apr 2022 13:18:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f11-20020a7bcc0b000000b0037e0c362b6dsm13581wmh.31.2022.04.21.13.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 13:18:15 -0700 (PDT)
Message-Id: <94acd9e0a47fcbee91f7759d1556d39fec26dd2d.1650572159.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1256.git.git.1650572159.gitgitgadget@gmail.com>
References: <pull.1256.git.git.1650572159.gitgitgadget@gmail.com>
From:   "Thomas Koutcher via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Apr 2022 20:15:59 +0000
Subject: [PATCH 2/2] diff- family --stat: honour config option to limit graph
 width
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Thomas Koutcher <thomas.koutcher@online.fr>,
        Thomas Koutcher <thomas.koutcher@online.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Thomas Koutcher <thomas.koutcher@online.fr>

Make diff-files, diff-index and diff-tree --stat honour config option
diff.statGraphWidth as, according to git-config(1), it applies to all
commands generating --stat output except format-patch.

Move the parsing of diff.statgraphwidth from git_diff_ui_config() to
git_diff_basic_config() to make it accessible to all commands.

Signed-off-by: Thomas Koutcher <thomas.koutcher@online.fr>
---
 builtin/diff-files.c | 1 +
 builtin/diff-index.c | 1 +
 builtin/diff-tree.c  | 1 +
 diff.c               | 9 +++++----
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index 2265cd256be..e9b96278434 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -30,6 +30,7 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 	repo_init_revisions(the_repository, &rev, prefix);
 	rev.abbrev = 0;
 	rev.diffopt.stat_width = -1; /* use full terminal width */
+	rev.diffopt.stat_graph_width = -1; /* respect statGraphWidth config */
 
 	/*
 	 * Consider "intent-to-add" files as new by default, unless
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index 9cb9555fdeb..10f78180264 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -27,6 +27,7 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 	repo_init_revisions(the_repository, &rev, prefix);
 	rev.abbrev = 0;
 	rev.diffopt.stat_width = -1; /* use full terminal width */
+	rev.diffopt.stat_graph_width = -1; /* respect statGraphWidth config */
 	prefix = precompose_argv_prefix(argc, argv, prefix);
 
 	/*
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 4a2a2744fae..0b783dcbc44 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -123,6 +123,7 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 	opt->abbrev = 0;
 	opt->diff = 1;
 	opt->diffopt.stat_width = -1; /* use full terminal width */
+	opt->diffopt.stat_graph_width = -1; /* respect statGraphWidth config */
 	opt->disable_stdin = 1;
 	memset(&s_r_opt, 0, sizeof(s_r_opt));
 	s_r_opt.tweak = diff_tree_tweak_rev;
diff --git a/diff.c b/diff.c
index ef7159968b6..0923a25d5bb 100644
--- a/diff.c
+++ b/diff.c
@@ -394,10 +394,6 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 		diff_relative = git_config_bool(var, value);
 		return 0;
 	}
-	if (!strcmp(var, "diff.statgraphwidth")) {
-		diff_stat_graph_width = git_config_int(var, value);
-		return 0;
-	}
 	if (!strcmp(var, "diff.external"))
 		return git_config_string(&external_diff_cmd_cfg, var, value);
 	if (!strcmp(var, "diff.wordregex"))
@@ -477,6 +473,11 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "diff.statgraphwidth")) {
+		diff_stat_graph_width = git_config_int(var, value);
+		return 0;
+	}
+
 	if (git_diff_heuristic_config(var, value, cb) < 0)
 		return -1;
 
-- 
gitgitgadget
