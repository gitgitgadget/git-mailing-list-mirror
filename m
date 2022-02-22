Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670BFC433FE
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 16:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbiBVQbS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 11:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234051AbiBVQbH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 11:31:07 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A98D167FA3
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 08:30:38 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id p14-20020a05600c1d8e00b0037f881182a8so2361149wms.2
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 08:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZZyuKkUCfL/8ewV81lWIkbIrT3DSUUuyxciYCR841hA=;
        b=f8F+XxaOElzFXiULqmvZeIl7q+ib77IZIKYz8z+KPrihqHXOM75H8vukygvw8i/UsH
         KkvIMTmqtb6XiTwTLKk5mLbaNZ3GWBzjmcaYcF+rSod5d9GiDu+4rATnnyHffIM7xmFd
         wSamTWCPMM43B5VzIPEuBSYKYiWfSFldMrFTjDHe/miPEoT1bp5/4WL9JRNlLxxdlwdg
         qhPhGpLRtBYYJ0DEx5oStA/FYnphDjtq3JKkJ51pYYVa8q6yhM7hXP//M6pXxiwva78i
         NSNtJUKTqVUbvdwk3TAyF85QWhKOvsV39VmJuGNcieG7GZUozBxruVbTeg9wxMWpaAAn
         1Zvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZZyuKkUCfL/8ewV81lWIkbIrT3DSUUuyxciYCR841hA=;
        b=sI+xTw+Ag1h57/wnSSXkLXcFQ9GizaDZ6qK2IE7caWFYrldyw1XuaxllLjUypPHlYr
         250brt2RhBdC277LDSN/AIhSpjf7TADUiRmP04+3YjNrSzb+bW1kC2LaiwlTwGpVCIm1
         9503R3iHNpLxDLqaTsjD8P2+sL26Pp/DgVZmUbXDfm1UPfRJumKf4fFziit9ijrtcdJq
         7fmuxXnd6uo64+k8wp2/sTB8YoZmPOJ3XShi6pWdyH+teDpxQXG7LjUXinlfZtf9mRdz
         bNpbDBTh2oc8FyXVxEgCVBYILtL/3sr+WnqxTBSeW9WykxH/auoJIk36JBuKI42QYdb7
         cs4Q==
X-Gm-Message-State: AOAM530Lj45t4sknuRdJSrKBoKcY6lnZ4cQ1/Ec/omwuSDN6ek/X/v6M
        /JHmF2Kb7mIJiLckkGsEc1uVrtYP19Y=
X-Google-Smtp-Source: ABdhPJxEfVABhcbb8EkXE7jQIhfe+2TNREx+61hkPaghPZjT/jCTvVsNESAtNkgA0t1IVi9NA85SvA==
X-Received: by 2002:a1c:2785:0:b0:37c:773:5d24 with SMTP id n127-20020a1c2785000000b0037c07735d24mr3991281wmn.155.1645547436650;
        Tue, 22 Feb 2022 08:30:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n15-20020a05600c3b8f00b0037bc64fbd17sm2740686wms.11.2022.02.22.08.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 08:30:36 -0800 (PST)
Message-Id: <e2fa11a819e54ae30be1e18d66113cba24ddc163.1645547423.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
References: <pull.1132.git.1643328752.gitgitgadget@gmail.com>
        <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Feb 2022 16:30:23 +0000
Subject: [PATCH v2 14/14] bisect: no longer try to clean up left-over
 `.git/head-name` files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

As per the code comment, the `.git/head-name` files were cleaned up for
backwards-compatibility: an old version of `git bisect` could have left
them behind.

Now, just how old would such a version be? As of 0f497e75f05 (Eliminate
confusing "won't bisect on seeked tree" failure, 2008-02-23), `git
bisect` does not write that file anymore. Which corresponds to Git
v1.5.4.4.

Even if the likelihood is non-nil that there might still be users out
there who use such an old version to start a bisection, but then decide
to continue bisecting with a current Git version, it is highly
improbable.

So let's remove that code, at long last.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 bisect.c                    | 3 ---
 t/t6030-bisect-porcelain.sh | 1 -
 2 files changed, 4 deletions(-)

diff --git a/bisect.c b/bisect.c
index 888949fba6b..ebd4287c01c 100644
--- a/bisect.c
+++ b/bisect.c
@@ -474,7 +474,6 @@ static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
 static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
 static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
 static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
-static GIT_PATH_FUNC(git_path_head_name, "head-name")
 
 static void read_bisect_paths(struct strvec *array)
 {
@@ -1172,8 +1171,6 @@ int bisect_clean_state(void)
 	unlink_or_warn(git_path_bisect_run());
 	unlink_or_warn(git_path_bisect_terms());
 	unlink_or_warn(git_path_bisect_first_parent());
-	/* Cleanup head-name if it got left by an old version of git-bisect */
-	unlink_or_warn(git_path_head_name());
 	/*
 	 * Cleanup BISECT_START last to support the --no-checkout option
 	 * introduced in the commit 4796e823a.
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 720442de2eb..4f17205c238 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -945,7 +945,6 @@ test_expect_success 'git bisect reset cleans bisection state properly' '
 	test_path_is_missing ".git/BISECT_LOG" &&
 	test_path_is_missing ".git/BISECT_RUN" &&
 	test_path_is_missing ".git/BISECT_TERMS" &&
-	test_path_is_missing ".git/head-name" &&
 	test_path_is_missing ".git/BISECT_HEAD" &&
 	test_path_is_missing ".git/BISECT_START"
 '
-- 
gitgitgadget
