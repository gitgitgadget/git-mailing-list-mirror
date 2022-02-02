Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B951C433EF
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 03:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244087AbiBBDmy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 22:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244079AbiBBDmq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 22:42:46 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D967C061714
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 19:42:46 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id v13so35688591wrv.10
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 19:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rgJ1bGWHoX5jLI+AEm7XGvjVUoCRS4eCLowx47sFg3c=;
        b=YQa19jqsRCftiMw53MDUWiDYNE2fFiATTasxff4LLD6m/rAmKJne8278Xbfeufdbut
         rv3eezAP7Az61pDdgwZLNGUp5lDJQrHDgmOEfxjo+KxBZvrmRvIhndSIcdEwTs/ynbDv
         u3hZqqJFLuRxAPoQeReI0k/sS0Fd2F1sqecPg1ZEvflztfI2ACjfR1+Iq5FbANQBzNNH
         NNROfXp70jDY9/htv2PE4ZJovpSdSRhwawn3ZsXKDH9cev6p7MrfeMKurGjndm67GH3P
         d91v3ODRNLA9z8vm+Zrz2pRt22e9n38Are561nIj8X/fKw+Sryw4KQ7H2f6jK+2IJUzC
         poyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rgJ1bGWHoX5jLI+AEm7XGvjVUoCRS4eCLowx47sFg3c=;
        b=2JHJ4ND8lBwCS6eYiI5wX+hvr5nl39xptsOKcvl9EbfTgtWoxwfW5ahfgDAqFBOD4b
         ChlfuVvvzW1O/pyHeu0mbPzWEqNSWXJ3Yx0BXJtn31z9WGWRZKBUVvEJm6152g/e2d3Y
         ZQUogyBmWAdsNpDVxgJdMATtzPEXbodQMC2+IG85rD1enkHyqT7zWLgNtgjxruxBlama
         7JwjS8r9HEEVjblNcxdSIKB/Y4j0ZrA88Hbl9Gie3CXVOUWdcBywnP12129UeczPIC9U
         VgHoxoRruwy6wCsyyVy2LpTzUMAJNmRrO0p4DLRcs43hTnGxEfeXV6f7QFY5Nv/tpkuA
         f3pQ==
X-Gm-Message-State: AOAM531Fg5bZutzVP2VPhqKFNeh3UUXBlj+1V3/2CouYsjij2NhtWLmn
        em2DLDCMds0VJdbX2m5yaDBcj4QwdhQ=
X-Google-Smtp-Source: ABdhPJxVU0JJGOIc1VjmCcgABdNGe1p4PcP62+8+nDjk77PT2tGTcz7dbvbDHeWANSkXi418tAdyNg==
X-Received: by 2002:a05:6000:1c9:: with SMTP id t9mr22772782wrx.401.1643773365010;
        Tue, 01 Feb 2022 19:42:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n10sm20331774wrf.96.2022.02.01.19.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 19:42:44 -0800 (PST)
Message-Id: <7500a4d2e44008b1d8df9cc8b24b67ff973a98ae.1643773361.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1131.v4.git.1643773361.gitgitgadget@gmail.com>
References: <pull.1131.v3.git.1643734828.gitgitgadget@gmail.com>
        <pull.1131.v4.git.1643773361.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 02 Feb 2022 03:42:40 +0000
Subject: [PATCH v4 3/3] repo-settings: rename the traditional default
 fetch.negotiationAlgorithm
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Give the traditional default fetch.negotiationAlgorithm the name
'consecutive'.  Also allow a choice of 'default' to have Git decide
between the choices (currently, picking 'skipping' if
feature.experimental is true and 'consecutive' otherwise).  Update the
documentation accordingly.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/config/fetch.txt | 25 +++++++++++++------------
 fetch-negotiator.c             |  2 +-
 repo-settings.c                |  7 +++++--
 repository.h                   |  2 +-
 t/t5500-fetch-pack.sh          |  2 +-
 5 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch.txt
index 63748c02b72..cd65d236b43 100644
--- a/Documentation/config/fetch.txt
+++ b/Documentation/config/fetch.txt
@@ -56,18 +56,19 @@ fetch.output::
 	OUTPUT in linkgit:git-fetch[1] for detail.
 
 fetch.negotiationAlgorithm::
-	Control how information about the commits in the local repository is
-	sent when negotiating the contents of the packfile to be sent by the
-	server. Set to "skipping" to use an algorithm that skips commits in an
-	effort to converge faster, but may result in a larger-than-necessary
-	packfile; or set to "noop" to not send any information at all, which
-	will almost certainly result in a larger-than-necessary packfile, but
-	will skip the negotiation step.
-	The default is "default" which instructs Git to use the default algorithm
-	that never skips commits (unless the server has acknowledged it or one
-	of its descendants). If `feature.experimental` is enabled, then this
-	setting defaults to "skipping".
-	Unknown values will cause 'git fetch' to error out.
+	Control how information about the commits in the local repository
+	is sent when negotiating the contents of the packfile to be sent by
+	the server.  Set to "consecutive" to use an algorithm that walks
+	over consecutive commits checking each one.  Set to "skipping" to
+	use an algorithm that skips commits in an effort to converge
+	faster, but may result in a larger-than-necessary packfile; or set
+	to "noop" to not send any information at all, which will almost
+	certainly result in a larger-than-necessary packfile, but will skip
+	the negotiation step.  Set to "default" to override settings made
+	previously and use the default behaviour.  The default is normally
+	"consecutive", but if `feature.experimental` is true, then the
+	default is "skipping".  Unknown values will cause 'git fetch' to
+	error out.
 +
 See also the `--negotiate-only` and `--negotiation-tip` options to
 linkgit:git-fetch[1].
diff --git a/fetch-negotiator.c b/fetch-negotiator.c
index 273390229fe..874797d767b 100644
--- a/fetch-negotiator.c
+++ b/fetch-negotiator.c
@@ -18,7 +18,7 @@ void fetch_negotiator_init(struct repository *r,
 		noop_negotiator_init(negotiator);
 		return;
 
-	case FETCH_NEGOTIATION_DEFAULT:
+	case FETCH_NEGOTIATION_CONSECUTIVE:
 		default_negotiator_init(negotiator);
 		return;
 	}
diff --git a/repo-settings.c b/repo-settings.c
index 41e1c30845f..b4fbd16cdcc 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -26,7 +26,7 @@ void prepare_repo_settings(struct repository *r)
 	/* Defaults */
 	r->settings.index_version = -1;
 	r->settings.core_untracked_cache = UNTRACKED_CACHE_KEEP;
-	r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_DEFAULT;
+	r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_CONSECUTIVE;
 
 	/* Booleans config or default, cascades to other settings */
 	repo_cfg_bool(r, "feature.manyfiles", &manyfiles, 0);
@@ -81,12 +81,15 @@ void prepare_repo_settings(struct repository *r)
 	}
 
 	if (!repo_config_get_string(r, "fetch.negotiationalgorithm", &strval)) {
+		int fetch_default = r->settings.fetch_negotiation_algorithm;
 		if (!strcasecmp(strval, "skipping"))
 			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_SKIPPING;
 		else if (!strcasecmp(strval, "noop"))
 			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_NOOP;
+		else if (!strcasecmp(strval, "consecutive"))
+			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_CONSECUTIVE;
 		else if (!strcasecmp(strval, "default"))
-			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_DEFAULT;
+			r->settings.fetch_negotiation_algorithm = fetch_default;
 		else
 			die("unknown fetch negotiation algorithm '%s'", strval);
 	}
diff --git a/repository.h b/repository.h
index 2b5cf97f31e..ca837cb9e91 100644
--- a/repository.h
+++ b/repository.h
@@ -20,7 +20,7 @@ enum untracked_cache_setting {
 };
 
 enum fetch_negotiation_setting {
-	FETCH_NEGOTIATION_DEFAULT,
+	FETCH_NEGOTIATION_CONSECUTIVE,
 	FETCH_NEGOTIATION_SKIPPING,
 	FETCH_NEGOTIATION_NOOP,
 };
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 41ea9f25de6..ee6d2dde9f3 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -968,7 +968,7 @@ test_expect_success 'use ref advertisement to prune "have" lines sent' '
 test_expect_success 'same as last but with config overrides' '
 	test_negotiation_algorithm_default \
 		-c feature.experimental=true \
-		-c fetch.negotiationAlgorithm=default
+		-c fetch.negotiationAlgorithm=consecutive
 '
 
 test_expect_success 'ensure bogus fetch.negotiationAlgorithm yields error' '
-- 
gitgitgadget
