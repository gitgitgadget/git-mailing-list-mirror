Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7019ECAAD4
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 20:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiH2Uyf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 16:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiH2UyZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 16:54:25 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C069AFDD
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 13:54:23 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id h1so4818009wmd.3
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 13:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=jb7GuWyEWZ1RDMEHb244Y7j7VQsv21C4ORtBDFTmJK4=;
        b=PzXwvEwfdLQ7kv+K05u4c4hJcxlrVfvmLNsWWfPjdyQqOHxcOzv+pNtja0l2MCgfzj
         o5NujU1Czws4mxU9933fFSJfcWvFGZn+//kXDK2VoiJ/vjTlkpX2u4NW2zsRWonCbZAj
         0YlbH52c3z228Ho3GwxqX3PcfsThfbIB1ykiZ8VGsLxvCHGJIwCBBmsggUTuzbREky/l
         IppC0rkN20bQx1Z46cVa64f1iwbvjkhcOcq29cC3i2wL0p5SwsZpRB9Gf5F8KiFplYH3
         Qf6JTyk8tuKiVZ57TYAsUsp1/qA24D66fJHxRPP5Gxlp56wK4bjZAFXsPI4EV2sD1kKL
         WPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=jb7GuWyEWZ1RDMEHb244Y7j7VQsv21C4ORtBDFTmJK4=;
        b=EAO4R05jWoO8BxRTHIqBpG1xwN/UUdOV3Drj05vYnw0yT9wqIhIgpwUxJ6WHzvRMy6
         ykHA2qFu8K2FKEzyWRG3oBOncQfFRyatif27m/7sQwB/UIgQyqUjyVP5nkFsnWVyyyQk
         VFAlnsnP27wsFHjU4dRJFfG8D+yC3h+4vgXo59F/JnEO7okOtcyEt0HOQYGKszhY+Kju
         XvFjjSx/YKVTproAzEwXRDBMO8m9Swi6cYhXQ51nQYFnQv2P5Olp6qHlThwpFvz8YBfL
         kvCM/s6CIjr449P7MoQL9vIo5wzbPQuVxEK+qsRRklX/Ba1OcLQlqAAFSL8wO7xvVSiG
         xbPQ==
X-Gm-Message-State: ACgBeo3wjAQJ8NJknEVAdf4SwfHfvwCW2F/ho3t6jTDrlRHy1XiNjuIK
        4olyMxQsvnfFKQWPchAfxBCoPnNo8oE=
X-Google-Smtp-Source: AA6agR5OV97Hebjryruy94jq+N+DIw6rPPDLCva4nJA0iv4D4Uvir74TZcxycl0p/c0+j4DvxfHfbQ==
X-Received: by 2002:a05:600c:2483:b0:3a5:e70c:d5f6 with SMTP id 3-20020a05600c248300b003a5e70cd5f6mr7761318wms.51.1661806462121;
        Mon, 29 Aug 2022 13:54:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r1-20020a5d4e41000000b00226d1711276sm7705197wrt.1.2022.08.29.13.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 13:54:21 -0700 (PDT)
Message-Id: <513d18e56d3b60d1b522af212fb8b7be232992d4.1661806456.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1321.git.git.1661806456.gitgitgadget@gmail.com>
References: <pull.1321.git.git.1661806456.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Aug 2022 20:54:15 +0000
Subject: [PATCH 5/6] submodule--helper: refactor up-to-date criterion
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Refactor builtin/submodule--helper.c:update_submodule() to check if the
submodule is up to date using a variable instead of checking the oids
directly. In a subsequent commit, we will expand the definition of "up
to date" to include checked out branches.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index dd00a0db522..cbf6bda4850 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2455,6 +2455,8 @@ static void update_data_to_args(struct update_data *update_data, struct strvec *
 
 static int update_submodule(struct update_data *update_data)
 {
+	int submodule_up_to_date;
+
 	ensure_core_worktree(update_data->sm_path);
 
 	update_data->displaypath = get_submodule_displaypath(
@@ -2491,7 +2493,8 @@ static int update_submodule(struct update_data *update_data)
 		free(remote_ref);
 	}
 
-	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->force)
+	submodule_up_to_date = oideq(&update_data->oid, &update_data->suboid);
+	if (!submodule_up_to_date || update_data->force)
 		if (run_update_procedure(update_data))
 			return 1;
 
-- 
gitgitgadget

