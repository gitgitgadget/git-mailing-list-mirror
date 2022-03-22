Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4D7C433F5
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 17:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239736AbiCVRaS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 13:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235913AbiCVRaM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 13:30:12 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFD8E39
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 10:28:43 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id m30so14592279wrb.1
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 10:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jm3MEfd6YOUjgSif2gdO+IzGaNt3BFBtqV9gV65PpGI=;
        b=kHgw63AQg3o+9J5pI9exwKxkOjFYC42PgjWhULZPU9KFizuhESr8ZyASEJxpMS7Kvu
         yWcjf1lri834TKjbrmHXmRIBe9ZjSsgnA7q70UJkgdt3xnFwfsoB8z4ZEETW+OsDUC3L
         A+tWvvnfG1snZw5OUvdYB1vZYcdlLugEXDuPYATbbCoNjtpXwy6DTYZt6GTBiKdEj78b
         cAN/1JBwKhiJibSEq8KwJvB8zIfkx1Od1BmtNYAiIwq+wERLSjTr79dqkgQk6D6nH0mY
         6adl2lIVvT4UNJWThl8mHoqmxr7nznNrMhuEG8WzUP86uugaQfOXxwPVcERPyJFTtuC0
         W5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jm3MEfd6YOUjgSif2gdO+IzGaNt3BFBtqV9gV65PpGI=;
        b=HojuyQ7uxEC6c111CxlWmzejY8quRJlkfZzTJSqDWCZbtU3NmJiLBMGXGyJFuuU736
         7Sipc/kUdb3TRjI1Hv0pSHpq+UCLxa60ISWP6fNOBjMKI1bHatqFPPrHt2Vl8DXfngAi
         xzmGp1gzs/Kg2S3ZsKksjGf6FcxPUHSGJzLH0T50qaBLDWIs/HBcY8h5hW3jb2do4/1A
         qM2aY/ZEPIoa1LYQ7DhdpDz0RaqbnV6N4XfGhr+XzwmaNFI3BnZ+pDzvoJ+B/4qu1b7m
         91LH7buYDGVPrEC+hsQRbAiK2Xbq/Aj0ey7X0yJg59kCMTLtGv9OvYKk2AdU5F5W+6XA
         c6Ig==
X-Gm-Message-State: AOAM533ixQQlz7Zgz4hMSTi8ZTErh0WqLVpcTLv/ZhT2a7xEe/Lq7qTX
        /vVV/dQh08qQX7jZSsPR4DWQgBwgyYs=
X-Google-Smtp-Source: ABdhPJxWjf9QJONQd9tAHkoQrPgjYjLLbhEsHki3Blpak2hkHP6IhfyROVlGMZAcW0DRRVmWSL+JqA==
X-Received: by 2002:a05:6000:2a7:b0:205:8031:bfee with SMTP id l7-20020a05600002a700b002058031bfeemr1482220wry.117.1647970121977;
        Tue, 22 Mar 2022 10:28:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v14-20020a7bcb4e000000b0034492fa24c6sm2309173wmj.34.2022.03.22.10.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 10:28:41 -0700 (PDT)
Message-Id: <166d86fd7009a8a1b82a4157cb718a6a4a527a0c.1647970119.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1186.git.1647970119.gitgitgadget@gmail.com>
References: <pull.1186.git.1647970119.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Mar 2022 17:28:35 +0000
Subject: [PATCH 1/5] list-objects-filter: remove CL_ARG__FILTER
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

We have established the command-line interface for the --[no-]filter
options for a while now, so we do not need a helper to make this
editable in the future.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/fetch-pack.c          | 4 ++--
 list-objects-filter-options.h | 5 +----
 revision.c                    | 4 ++--
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index c2d96f4c89a..c4b9104f9b5 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -153,11 +153,11 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 			args.from_promisor = 1;
 			continue;
 		}
-		if (skip_prefix(arg, ("--" CL_ARG__FILTER "="), &arg)) {
+		if (skip_prefix(arg, ("--filter="), &arg)) {
 			parse_list_objects_filter(&args.filter_options, arg);
 			continue;
 		}
-		if (!strcmp(arg, ("--no-" CL_ARG__FILTER))) {
+		if (!strcmp(arg, ("--no-filter"))) {
 			list_objects_filter_set_no_filter(&args.filter_options);
 			continue;
 		}
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index 2eb6c983949..90e4bc96252 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -69,9 +69,6 @@ struct list_objects_filter_options {
 	 */
 };
 
-/* Normalized command line arguments */
-#define CL_ARG__FILTER "filter"
-
 /*
  * Parse value of the argument to the "filter" keyword.
  * On the command line this looks like:
@@ -111,7 +108,7 @@ int opt_parse_list_objects_filter(const struct option *opt,
 				  const char *arg, int unset);
 
 #define OPT_PARSE_LIST_OBJECTS_FILTER(fo) \
-	OPT_CALLBACK(0, CL_ARG__FILTER, fo, N_("args"), \
+	OPT_CALLBACK(0, "filter", fo, N_("args"), \
 	  N_("object filtering"), \
 	  opt_parse_list_objects_filter)
 
diff --git a/revision.c b/revision.c
index 2646b78990e..7d435f80480 100644
--- a/revision.c
+++ b/revision.c
@@ -2691,9 +2691,9 @@ static int handle_revision_pseudo_opt(struct rev_info *revs,
 		revs->no_walk = 0;
 	} else if (!strcmp(arg, "--single-worktree")) {
 		revs->single_worktree = 1;
-	} else if (skip_prefix(arg, ("--" CL_ARG__FILTER "="), &arg)) {
+	} else if (skip_prefix(arg, ("--filter="), &arg)) {
 		parse_list_objects_filter(&revs->filter, arg);
-	} else if (!strcmp(arg, ("--no-" CL_ARG__FILTER))) {
+	} else if (!strcmp(arg, ("--no-filter"))) {
 		list_objects_filter_set_no_filter(&revs->filter);
 	} else {
 		return 0;
-- 
gitgitgadget

