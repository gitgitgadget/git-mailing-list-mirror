Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BCAC433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 21:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237458AbiF3VT4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 17:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237380AbiF3VTt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 17:19:49 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3004D157
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 14:19:47 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id m6-20020a05600c3b0600b003a0489f412cso2787436wms.1
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 14:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=B/d9zfDBGBH2WfhA15IekN+oYjG+N/9fpuUdJfBvscY=;
        b=ee9tNqYIpXpOZlGq2eTxaf80QmHVeo/OWKontjoeYpJGuPjQ3iDlC5fQTV0UKwTXHG
         HTFL7mnc9fYW7lrJ6foXjnGeiIMgRDss+WNogVxrWRVbRAmshJ0IopTQ6fptC1z2qP1W
         LSeGpLJ4M4ucfxBt5v4oKP1JxWuRllTjwQu6+lHnWWzrCSvD9SZvh322BblmIQtdEPRO
         n5DK9WJCJcWQJCHyi/l4HNcTH+sjB2kYCWbn/VbR9gB2+e6Mbe+HZxuKoUWPG4K8JGmH
         bvargQK1upPWZvGxZmDYaf22OF0/Y+kks9Mg/Jb60T5SoUOKHfMzrXVGG7bH5lovCl3q
         UX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=B/d9zfDBGBH2WfhA15IekN+oYjG+N/9fpuUdJfBvscY=;
        b=wN9qiuTLPcCVk2/sivGzHihi7ARa3/FSFFTDqABzXzVKjam2gdEt0s3X4oQd6CInwQ
         KJQd6GPiEIsun5zZcNn+JcNqM915Xm0e4B9Mm3toab1Nie9YFINJ4c7F6qnG/r5dtpYJ
         YxfVoEsjxRumngjgUaazqlfXBInVYfcUhO4teHUExBOsJXF4DEHqWp5FQm0tPbVkPn6T
         CSKa3PIrcpK6BLMMX8nF357LjnBxp/mk03ioecDf+8E7s8fnyCFobt4+kYw8hjcQ9qNb
         BxIo5JmV02zcbuDVr7ZktpwGBMCvO8gLwtgwxTmx8ZZUYTuFIcxgNqljcW9p68hqXKgt
         x+/A==
X-Gm-Message-State: AJIora+q99YQenPp+Ksq6E4uHo6uX3W/qHKav9IQoawgVFrjP85ciDIZ
        yLr65Xl2ZObBVmJ1G4GUZYCHNPudVmw=
X-Google-Smtp-Source: AGRyM1sxSE9mQiGqdSz1oXo41432CAteo1OlLZ/aZptHo+CxzNqPHnwWZtK1siXcNdp71cQPE7J9Ow==
X-Received: by 2002:a7b:c01a:0:b0:3a1:7ab1:e5dc with SMTP id c26-20020a7bc01a000000b003a17ab1e5dcmr7523731wmb.128.1656623986089;
        Thu, 30 Jun 2022 14:19:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z5-20020adfe545000000b0021b81855c1csm24780322wrm.27.2022.06.30.14.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 14:19:45 -0700 (PDT)
Message-Id: <d9c7f69aaa6b001949e9d2b693c22c595cc9d0d6.1656623978.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1282.v2.git.git.1656623978.gitgitgadget@gmail.com>
References: <pull.1282.git.git.1656372017.gitgitgadget@gmail.com>
        <pull.1282.v2.git.git.1656623978.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Thu, 30 Jun 2022 21:19:25 +0000
Subject: [PATCH v2 05/18] submodule--helper: have --require-init imply --init
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Glen Choo <chooglen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=
 <avarab@gmail.com>

Adjust code added in 0060fd1511b (clone --recurse-submodules: prevent
name squatting on Windows, 2019-09-12) to have the internal
--require-init option imply --init, rather than having
"git-submodule.sh" add it implicitly.

This change doesn't make any difference now, but eliminates another
special-case where "git submodule--helper update"'s behavior was
different from "git submodule update". This will make it easier to
eventually replace the cmd_update() function in git-submodule.sh.

We'll still need to keep the distinction between "--init" and
"--require-init" in git-submodule.sh. Once cmd_update() gets
re-implemented in C we'll be able to change variables and other code
related to that, but not yet.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/submodule--helper.c | 5 ++++-
 git-submodule.sh            | 1 -
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 5c77dfcffee..f0702d0cfa2 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2618,7 +2618,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "progress", &opt.progress,
 			    N_("force cloning progress")),
 		OPT_BOOL(0, "require-init", &opt.require_init,
-			   N_("disallow cloning into non-empty directory")),
+			   N_("disallow cloning into non-empty directory, implies --init")),
 		OPT_BOOL(0, "single-branch", &opt.single_branch,
 			 N_("clone only one branch, HEAD or --branch")),
 		OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
@@ -2642,6 +2642,9 @@ static int module_update(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, module_update_options,
 			     git_submodule_helper_usage, 0);
 
+	if (opt.require_init)
+		opt.init = 1;
+
 	if (filter_options.choice && !opt.init) {
 		usage_with_options(git_submodule_helper_usage,
 				   module_update_options);
diff --git a/git-submodule.sh b/git-submodule.sh
index 20fc1b620fa..5b9683bf766 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -251,7 +251,6 @@ cmd_update()
 			init=1
 			;;
 		--require-init)
-			init=1
 			require_init=1
 			;;
 		--remote)
-- 
gitgitgadget

