Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BA3C04A68
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 14:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238840AbiGZOEZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jul 2022 10:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239196AbiGZOEU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jul 2022 10:04:20 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21082A27F
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 07:04:18 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id d8so20209730wrp.6
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 07:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=flNOUpFpQNk5mfo8GE8lZF5pNYZBrO+OeLGye5bTl1g=;
        b=OSxmUkYxPxOdJmCIsLlmY0NGpL0L3/SyrPwXlc0G/DyGdJb4pLLZXnUsFnU/lmVHuh
         XYa+jVgSR/XwU9cmK2ADexeRzDxM0sRgTvYE1J/DWzvxt4EPG/VSHw6pWKU8tUbGaQTh
         GId70/LBfy7eHGc1uRXNPBebX9QO4nUZOxe40m/m7un9ZG/OvL9xfRCmY9ovl2C50OS/
         bP0CdR32MZ57qr+SyVw/cjLTbGzbNWHQVkbmPFDDmO74Rz05d+DQ18ohAoCZa/go+aqc
         snogpdq6iZ86TpsjLyy8crUUsK01ol/55eK9DnYeNfZWDuRGaIvrjp1R94zD3LVZ80jM
         OkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=flNOUpFpQNk5mfo8GE8lZF5pNYZBrO+OeLGye5bTl1g=;
        b=mjp9YZFkMl/ii3tRu2uuWydU3yihKS0/2jwKTpilcV79EF3aOjQxuVZ58hFI2Lq4Lh
         PTwE4S4iLsy8VBSUkLQb+611bRtMpeWPBr0pMaOYvLJ403nK68g/YI9Ax1GOoVrU24LD
         +uftTB1esRSaf+KH6zhv156b9yfkrVJHUySw6QWNFGqlGgcLekAPfMjtpSXo5wSrYDv9
         gvCuPjw2Xkn9u4a1e9OhiqvmYUUxPjBkoFmHZ8Gk2w7N8LmZZgosK2Tc+8BKec1boogM
         QaRN8cQQZZFJPF5kU8R32JocBTK7Ekp2fqfa+OuTcROFxutuf1BAfDUY0Ka0fx5l0HDy
         0KLg==
X-Gm-Message-State: AJIora8CHu10l7OxW3i23yS+X6tSJLJj6r2p9NjUj9+8ciLBMYEIAbJO
        XAMmcBAznXz/F0Ckjf3mEuWiGNj7a9o=
X-Google-Smtp-Source: AGRyM1vpluWnJ18nmGeVLCUgIrCn2QASXCdXx/qXOX1GKxrQlM4cNhn01Cm7GG/EL1MvVfKEMVzwmQ==
X-Received: by 2002:adf:ce0c:0:b0:21d:929e:1522 with SMTP id p12-20020adfce0c000000b0021d929e1522mr10448019wrn.126.1658844256955;
        Tue, 26 Jul 2022 07:04:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j22-20020a05600c485600b003a2c7bf0497sm18080938wmo.16.2022.07.26.07.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 07:04:16 -0700 (PDT)
Message-Id: <84fbf16613daa0ff84e1f07d23654a96bd1a8315.1658844250.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 26 Jul 2022 14:04:10 +0000
Subject: [PATCH 3/3] maintenance: stop writing log.excludeDecoration
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        steadmon@google.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

This reverts commit 96eaffebbf3d0 (maintenance: set
log.excludeDecoration durin prefetch, 2021-01-19).

The previous change created a default decoration filter that does not
include refs/prefetch/, so this modification of the config is no longer
needed.

One issue that can happen from this point on is that users who ran the
prefetch task on previous versions of Git will still have a
log.excludeDecoration value and that will prevent the new default
decoration filter from being active. Thus, when we add the refs/bundle/
namespace as part of the bundle URI feature, those users will see
refs/bundle/ decorations.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/gc.c           |  6 ------
 t/t7900-maintenance.sh | 21 ---------------------
 2 files changed, 27 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index eeff2b760e0..6c222052177 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -910,12 +910,6 @@ static int fetch_remote(struct remote *remote, void *cbdata)
 
 static int maintenance_task_prefetch(struct maintenance_run_opts *opts)
 {
-	git_config_set_multivar_gently("log.excludedecoration",
-					"refs/prefetch/",
-					"refs/prefetch/",
-					CONFIG_FLAGS_FIXED_VALUE |
-					CONFIG_FLAGS_MULTI_REPLACE);
-
 	if (for_each_remote(fetch_remote, opts)) {
 		error(_("failed to prefetch remotes"));
 		return 1;
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 74aa6384755..62ed694a404 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -162,7 +162,6 @@ test_expect_success 'prefetch multiple remotes' '
 	test_cmp_rev refs/remotes/remote1/one refs/prefetch/remotes/remote1/one &&
 	test_cmp_rev refs/remotes/remote2/two refs/prefetch/remotes/remote2/two &&
 
-	test_cmp_config refs/prefetch/ log.excludedecoration &&
 	git log --oneline --decorate --all >log &&
 	! grep "prefetch" log &&
 
@@ -173,26 +172,6 @@ test_expect_success 'prefetch multiple remotes' '
 	test_subcommand git fetch remote2 $fetchargs <skip-remote1.txt
 '
 
-test_expect_success 'prefetch and existing log.excludeDecoration values' '
-	git config --unset-all log.excludeDecoration &&
-	git config log.excludeDecoration refs/remotes/remote1/ &&
-	git maintenance run --task=prefetch &&
-
-	git config --get-all log.excludeDecoration >out &&
-	grep refs/remotes/remote1/ out &&
-	grep refs/prefetch/ out &&
-
-	git log --oneline --decorate --all >log &&
-	! grep "prefetch" log &&
-	! grep "remote1" log &&
-	grep "remote2" log &&
-
-	# a second run does not change the config
-	git maintenance run --task=prefetch &&
-	git log --oneline --decorate --all >log2 &&
-	test_cmp log log2
-'
-
 test_expect_success 'loose-objects task' '
 	# Repack everything so we know the state of the object dir
 	git repack -adk &&
-- 
gitgitgadget
