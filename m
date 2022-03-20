Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57047C433F5
	for <git@archiver.kernel.org>; Sun, 20 Mar 2022 21:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343778AbiCTV4h (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Mar 2022 17:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343761AbiCTV4Z (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Mar 2022 17:56:25 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BD912A82
        for <git@vger.kernel.org>; Sun, 20 Mar 2022 14:55:01 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b19so18431658wrh.11
        for <git@vger.kernel.org>; Sun, 20 Mar 2022 14:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=FpFxPc+QcmTYNUPNiRVEoOstnUf1weEtg8E6bXT4nYU=;
        b=ZK6H5L/H5ysa0p+EcAopfmGXoZiCw0Tf/r5EKXHG3MSaQ0goJH4tZxcBrPASjmeguK
         mDoSLrev7Wg2Q+6+XIfN1XSBY705uiEJyBFTEUhzq+EJJRz/TgPHBEqHfXbJjNy/pxtl
         R7umsc1Nva2xHYLLV3llhHAKMX2ti+LJ3yZ4mHoneksY3eQBIJ4Ni/kHXy+ErsAf+U1v
         bPdMe6psb+rsJqI876iIKWhkMQXN0y9SM2/oCghXVes76cSO4gX5GOPVxyDioi8+nL39
         wylVk0p2YS9z1u+D9TUpp3CkunNOBCdg39gdz6RSMtivtZSyOF25v++vVM9uhn8cynun
         xBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=FpFxPc+QcmTYNUPNiRVEoOstnUf1weEtg8E6bXT4nYU=;
        b=m/DHNYNKMmTLnkjf/XlhwBWV5fWxmmweX6ZfSlQm8xR2aHuPX0mhXqTlUOmJgINEv0
         JzwIgNoqVyBVbC7xUXJaPY6Xt4TzdfsGZzWaN/9bYi0x5qT8sLGtswkgfCvVtXMCecdk
         rweLRkZF0wD556J78iER60oJSRFPWDe0TokvQbA51ggdXymEfr3EuNyRZnQkhOnz/I5Q
         cOE1Y2XCHBkxvBL8MgQXzJ9o05CxE60SPmb46e5R0GmacuWL6CGmgN76cz+T0kyaDeRr
         q/gNKbs7RY62cNMt5rsJPB/FlNCIdPmSzsmKXyzNT/mqLSVC78Klm1HgZGY4lF1bRzf5
         AJ0Q==
X-Gm-Message-State: AOAM530pDQHYvCb5rVXRYBafcJAxW3Oc7ANlAvhG9tUPFefJKLA2HG6d
        lUWGc34xbrynruE2Hcsz3quvpciYBjI=
X-Google-Smtp-Source: ABdhPJyW/pIQ3ZaSGVKYwF6SlL4iPY6aRq1mXzsZY7dxvOxvW+lhl6T4DfSpJSHivc46SMwmaEviUw==
X-Received: by 2002:adf:e8c9:0:b0:204:116:9e04 with SMTP id k9-20020adfe8c9000000b0020401169e04mr6552435wrn.19.1647813299691;
        Sun, 20 Mar 2022 14:54:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c8-20020a056000184800b002040e925afasm2300907wri.59.2022.03.20.14.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 14:54:59 -0700 (PDT)
Message-Id: <ca52567b201578ef8cfc7dccf2b99cad54dd374c.1647813292.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1181.git.1647813291.gitgitgadget@gmail.com>
References: <pull.1181.git.1647813291.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Sun, 20 Mar 2022 21:54:51 +0000
Subject: [PATCH 7/7] i18n: factorize unrecognized options arguments messages
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 builtin/commit-graph.c | 2 +-
 builtin/config.c       | 2 +-
 builtin/env--helper.c  | 2 +-
 builtin/gc.c           | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 51c4040ea6c..1a4c798f908 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -134,7 +134,7 @@ static int write_option_parse_split(const struct option *opt, const char *arg,
 	else if (!strcmp(arg, "replace"))
 		*flags = COMMIT_GRAPH_SPLIT_REPLACE;
 	else
-		die(_("unrecognized --split argument, %s"), arg);
+		die(_("unrecognized %s argument '%s'"), "--split", arg);
 
 	return 0;
 }
diff --git a/builtin/config.c b/builtin/config.c
index e7b88a9c08d..aaf87761e58 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -106,7 +106,7 @@ static int option_parse_type(const struct option *opt, const char *arg,
 		else if (!strcmp(arg, "color"))
 			new_type = TYPE_COLOR;
 		else
-			die(_("unrecognized --type argument, %s"), arg);
+			die(_("unrecognized %s argument '%s'"), "--type", arg);
 	}
 
 	to_type = opt->value;
diff --git a/builtin/env--helper.c b/builtin/env--helper.c
index 27349098b07..e58e0de9a7b 100644
--- a/builtin/env--helper.c
+++ b/builtin/env--helper.c
@@ -24,7 +24,7 @@ static int option_parse_type(const struct option *opt, const char *arg,
 	else if (!strcmp(arg, "ulong"))
 		*cmdmode = ENV_HELPER_TYPE_ULONG;
 	else
-		die(_("unrecognized --type argument, %s"), arg);
+		die(_("unrecognized %s argument '%s'"), "--type", arg);
 
 	return 0;
 }
diff --git a/builtin/gc.c b/builtin/gc.c
index d512c127b99..1a9ee85a4d3 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -750,7 +750,7 @@ static int maintenance_opt_schedule(const struct option *opt, const char *arg,
 	*priority = parse_schedule(arg);
 
 	if (!*priority)
-		die(_("unrecognized --schedule argument '%s'"), arg);
+		die(_("unrecognized %s argument '%s'"), "--schedule", arg);
 
 	return 0;
 }
@@ -2393,7 +2393,7 @@ static int maintenance_opt_scheduler(const struct option *opt, const char *arg,
 
 	*scheduler = parse_scheduler(arg);
 	if (*scheduler == SCHEDULER_INVALID)
-		return error(_("unrecognized --scheduler argument '%s'"), arg);
+		return error(_("unrecognized %s argument '%s'"), "--scheduler", arg);
 	return 0;
 }
 
-- 
gitgitgadget
