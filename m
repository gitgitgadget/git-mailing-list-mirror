Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69F7C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 21:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237485AbiF3VUN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 17:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237467AbiF3VUC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 17:20:02 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713A945784
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 14:19:58 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v9so377909wrp.7
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 14:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yBfuDF+rpBseJS48i5Zi60kskOodLK+8rhV3oAiV3lk=;
        b=Oo+m+dCLLoHC0rldXLrTKg7hTDqxVErKF9Uz9JJBko6NacK6RAE6EKISz4evbxMgGi
         q/MadDvq2gCXgHV/bfDDytojTQKoJcjRAhWWJFq5+HsNpbnUhwfeEvAc1kAV5kDcYVJg
         t6wMs5Y8FSSV8vD8C0dulLRCOJXGVz049JtSBM+6OMHnN4O7ymG3apd4R1T08PYrqDtK
         IhQd5Btl374cZFsgXkKDravk+P+atD9Ykhxzp1awExgpP+Ob2qLyI8acbXPz0Sq3Exv3
         QpT1ZYjSBjMnJfhQDJYLkKBhXclit6J04svSxh9952vgLhCH3iTiUZXXfqH0QXF7ZrCl
         Ll9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yBfuDF+rpBseJS48i5Zi60kskOodLK+8rhV3oAiV3lk=;
        b=Tx3q1hrVChHuo9AfyF9HJkVjD34bpnl0DhIiQSVziHly7wUWtyY7DdE2HCS0eoHTdb
         Csarld0htcvzsntOONEQSXJRyT4uwrH4Du4BTWBHqVp/3SRm8DogtkNhKLw5yy0n5pv9
         UuJXHtfn56DPvv+Rp6OEDQvD689jtxRHcvBdEEmshN5NpEUy0HkE/HwzkjhbqlsiCYlJ
         g+2QebNZ1FKvNqIcC0Jgebv30427fMMmXCXMHo7RU5ciMsU5iehqQaeXglqjAjabi1UM
         S17dlpF7oxwSL5LmP6DQ1SKjXjWivNX7WnBxZNg8kBs6a3l8kbrRkp6eE6AXC9rWwffx
         jBxg==
X-Gm-Message-State: AJIora+gfCoJjfjDjgFHlXw8qMlFCu6g4UkC9NCCx8VXnkPzX74Krfws
        FP/wD9udcVb/mvC9I8IxtbDGRfSQUqw=
X-Google-Smtp-Source: AGRyM1tgRKGoSvXzc/4g42MbcHNEHTDUWk75EHBG6BysoTpiMCOYgAGaPtXURPZ4yU09ERIjLy8NtQ==
X-Received: by 2002:a5d:614e:0:b0:21b:9736:736f with SMTP id y14-20020a5d614e000000b0021b9736736fmr10125725wrt.200.1656623997780;
        Thu, 30 Jun 2022 14:19:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u2-20020a5d5142000000b0021b966abc19sm20242968wrt.19.2022.06.30.14.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 14:19:57 -0700 (PDT)
Message-Id: <1f7cf6ffaf1086321061d896c4270955d8ed136e.1656623978.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1282.v2.git.git.1656623978.gitgitgadget@gmail.com>
References: <pull.1282.git.git.1656372017.gitgitgadget@gmail.com>
        <pull.1282.v2.git.git.1656623978.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Jun 2022 21:19:35 +0000
Subject: [PATCH v2 15/18] submodule--helper: use correct display path helper
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Replace a chunk of code in update_submodule() with an equivalent
do_get_submodule_displaypath() invocation. This is already tested by
t/t7406-submodule-update.sh:'submodule update --init --recursive from
subdirectory', so no tests are added.

The two are equivalent because:

- Exactly one of recursive_prefix|prefix is non-NULL at a time; prefix
  is set at the superproject level, and recursive_prefix is set when
  recursing into submodules. There is also a BUG() statement in
  get_submodule_displaypath() that asserts that both cannot be non-NULL.

- In get_submodule_displaypath(), get_super_prefix() always returns NULL
  because "--super-prefix" is never passed. Thus calling it is
  equivalent to calling do_get_submodule_displaypath() with super_prefix
  = NULL.

Therefore:

- When recursive_prefix is non-NULL, prefix is NULL, and thus
  get_submodule_displaypath() just returns prefixed_path. This is
  identical to calling do_get_submodule_displaypath() with super_prefix
  = recursive_prefix because the return value is still the concatenation
  of recursive_prefix + update_data->sm_path.

- When prefix is non-NULL, prefixed_path = update_data->sm_path. Thus
  calling get_submodule_displaypath() with prefixed_path is equivalent
  to calling do_get_submodule_displaypath() with update_data->sm_path

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c104b1a0236..aad431f898e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2464,19 +2464,11 @@ static void update_data_to_args(struct update_data *update_data, struct strvec *
 
 static int update_submodule(struct update_data *update_data)
 {
-	char *prefixed_path;
-
 	ensure_core_worktree(update_data->sm_path);
 
-	if (update_data->recursive_prefix)
-		prefixed_path = xstrfmt("%s%s", update_data->recursive_prefix,
-					update_data->sm_path);
-	else
-		prefixed_path = xstrdup(update_data->sm_path);
-
-	update_data->displaypath = get_submodule_displaypath(prefixed_path,
-							     update_data->prefix);
-	free(prefixed_path);
+	update_data->displaypath = do_get_submodule_displaypath(update_data->sm_path,
+								update_data->prefix,
+								update_data->recursive_prefix);
 
 	determine_submodule_update_strategy(the_repository, update_data->just_cloned,
 					    update_data->sm_path, update_data->update_default,
-- 
gitgitgadget

