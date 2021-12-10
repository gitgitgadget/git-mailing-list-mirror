Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF629C433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 03:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236563AbhLJD77 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 22:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236537AbhLJD7z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 22:59:55 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B17C0617A1
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 19:56:21 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id i5so12932611wrb.2
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 19:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dz1Hvs/4gEe9bPp4x+0XxQx5T5dK9K9fdQbk9ZaMOc0=;
        b=lxd3ewQ8WGzfQkqRYl3Mrs8kU4MvnbcNkBWPHiH6T9TLjbSJBgmGWMYpnyqKa7hGJC
         JUvDVjrSjphgm5Qd8Pyktg7Bnut/Pxsd/O9ud1pfrLJpE+a5n+ETiuczBIFCi3/ZvyqK
         DwWNXzQxhN862Qp30dVDmOFpf3VGXYEktuGBTcPeG0lbpdR5ZOQF9GkvpLwkAyFyeW1k
         CNPyFH4CiWKXKbjK7a6wV+/W0MxnswtpNj6UbCbmhBqSlHGcqg6Biw0i0fM3FTSFhgs9
         SPjhwC1yTGnphKZhXC3RrfL512XGjGF3cVcFJi5VU3joxOBExZX46CxNwkEppb7k3FHj
         w90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dz1Hvs/4gEe9bPp4x+0XxQx5T5dK9K9fdQbk9ZaMOc0=;
        b=grlPT9xCQvZPOdVcZ7kh4mNesg0GvZX73L6oa1w1KpLV0KWerh2V1p8LeIzsFS1Okq
         6PQFuZxDt8LGr6l6KMiogMKPQG209rwTTVwdnXGau7wqnHE6+zsZDQpfj+TEyfvOZ48E
         vMWsJ996wlmKA5j25VgXntvtuLPDmwGxxlxZ6LCvWoA4ebnCW+T71jQoVNeKitmT6q2t
         25agL05Y/Z62XVL61o/d41ip907ybfVaPXryTgdZRQ71ig9Rbgd9UzJwIlKqgoYlAuUr
         6z3eyyBD4ZuW/CknxiL17QXqLDkXi5cffQH20XNbFWhxe8CYZ6yYzpWCaatjWlQL8Grp
         jDdA==
X-Gm-Message-State: AOAM530ZDZ5fQZXDVEKAAOYtxJxnVbDVk6JA+obpwMOjaP6HK910DaXm
        AcxXppgm/QDGu8RvZ4WM4mIikVFZXLY=
X-Google-Smtp-Source: ABdhPJxp1YRp2R5CD9GcWmN8nwdxLaYvgEcFv4TdIFEBIoX6DmSoN9p9nSfgVnuZxEy3XRNXgIbgwA==
X-Received: by 2002:a5d:628f:: with SMTP id k15mr11649908wru.363.1639108579480;
        Thu, 09 Dec 2021 19:56:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c4sm1288496wrr.37.2021.12.09.19.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 19:56:19 -0800 (PST)
Message-Id: <3687637915f4fdf62d15791f5cf41f9ea7838f4e.1639108573.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1151.v3.git.git.1639108573.gitgitgadget@gmail.com>
References: <pull.1151.v2.git.git.1638908410.gitgitgadget@gmail.com>
        <pull.1151.v3.git.git.1639108573.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Dec 2021 03:56:10 +0000
Subject: [PATCH v3 07/10] sparse-checkout: enable reapply to take
 --[no-]{cone,sparse-index}
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Folks may want to switch to or from cone mode, or to or from a
sparse-index without changing their sparsity paths.  Allow them to do so
using the reapply command.

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
Reviewed-by: Victoria Dye <vdye@github.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/sparse-checkout.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 1ecdc3ddd5a..9d2a05677c4 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -759,13 +759,22 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 }
 
 static char const * const builtin_sparse_checkout_reapply_usage[] = {
-	N_("git sparse-checkout reapply"),
+	N_("git sparse-checkout reapply [--[no-]cone] [--[no-]sparse-index] "),
 	NULL
 };
 
+static struct sparse_checkout_reapply_opts {
+	int cone_mode;
+	int sparse_index;
+} reapply_opts;
+
 static int sparse_checkout_reapply(int argc, const char **argv)
 {
 	static struct option builtin_sparse_checkout_reapply_options[] = {
+		OPT_BOOL(0, "cone", &reapply_opts.cone_mode,
+			 N_("initialize the sparse-checkout in cone mode")),
+		OPT_BOOL(0, "sparse-index", &reapply_opts.sparse_index,
+			 N_("toggle the use of a sparse index")),
 		OPT_END(),
 	};
 
@@ -777,6 +786,13 @@ static int sparse_checkout_reapply(int argc, const char **argv)
 			     builtin_sparse_checkout_reapply_usage, 0);
 
 	repo_read_index(the_repository);
+
+	reapply_opts.cone_mode = -1;
+	reapply_opts.sparse_index = -1;
+
+	if (update_modes(&reapply_opts.cone_mode, &reapply_opts.sparse_index))
+		return 1;
+
 	return update_working_directory(NULL);
 }
 
-- 
gitgitgadget

