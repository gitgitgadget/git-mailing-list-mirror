Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51731C433F5
	for <git@archiver.kernel.org>; Thu, 19 May 2022 16:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241991AbiESQ03 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 12:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241098AbiESQ01 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 12:26:27 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987555E74E
        for <git@vger.kernel.org>; Thu, 19 May 2022 09:26:26 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id bg25so3165957wmb.4
        for <git@vger.kernel.org>; Thu, 19 May 2022 09:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lt/vUZ0XFMcRtCAMMiib2k753yfBvnatGiqQvguXEkE=;
        b=kyVaTuPEBpnoNHJXkCWrWCf44ovzn1mvwo6iimU73KPrSOjWdedvU6MD5d+2L9HVNv
         CUlKVF5d34Wtt7c9jrhmK4WBK2SG6edqYMmxQyLQv56S/8mTDosS9V9YuIgKjrBq/eaO
         QL3ZIw6JFoG9xUm3LzCXjwZgihicRpy0ztj0pfkZ/G/bX+ge688nQ8J/je95/VtJ+qku
         23wqyawSM2K/RSlKFCa4qn8Bx61XcaGX+f8zZ3JEW4IUmwirIhTi6/g5rM9no38Q2+MY
         ojDCGfHJkZ8WxMi0AKoeimx1cqxthh/g5Vmz1z4mDMZWyBnO8mR3DHVb0Xl/kMOC54Zt
         ISjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lt/vUZ0XFMcRtCAMMiib2k753yfBvnatGiqQvguXEkE=;
        b=RgXK67yoUlHNSXXL9eFBNnTNKW4oaYyZ1+yBdLAXYX+Xy1Ql1NV4uIopNcNLERMbup
         RtDdkq6fMuubm1jlnS/x1K/tBx8+elnz8Uk42LO3HlgYeBO2dkGNdAd6d/zpjqUJVF31
         YgqmO2hUOfPtU0rDGUsppsYJ1BHQ/mFNAGhOIl4S0lg0ybJzapZT7TIo/9srwM2ImWjs
         cbZ4b9wi0eS21tXFxpiDDDwjq6vcSSdIC776kn4VinPc3HuvMzRugqlglIg7lxvHhOH3
         +UoaEIAMhTdEatkvRJzPQNBIMQ0StEsC+wDvH4s8sHtVF7LCTjpiYD/+jlwLjojFe/70
         is5g==
X-Gm-Message-State: AOAM533vX3caAYuVGTvRT7EMOGF8ydakCMaN5u1cJaF0gzO35OlNQwN/
        sHNo63kwvRehQK8UFP1n4uL8o/NNd+g=
X-Google-Smtp-Source: ABdhPJyEbe+fkm014Q4Yw3QgCA+oPAc7b3bBSTr2YCrUXoP/ZLzxlZxlm5D3FueD4mkTKl3eLt1rWA==
X-Received: by 2002:a05:600c:a4b:b0:37b:ea2b:5583 with SMTP id c11-20020a05600c0a4b00b0037bea2b5583mr5139200wmq.139.1652977584758;
        Thu, 19 May 2022 09:26:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r15-20020a05600c35cf00b003970b2fa72dsm521wmq.22.2022.05.19.09.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 09:26:23 -0700 (PDT)
Message-Id: <042d624b8159364229e95d35e9309f12b67f8173.1652977582.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1231.git.1652977582.gitgitgadget@gmail.com>
References: <pull.1231.git.1652977582.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 May 2022 16:26:21 +0000
Subject: [PATCH 1/2] merge: remove unused variable
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

restore_state() had a local variable sb that is not used, and in fact,
was never used even in the original commit that introduced it,
1c7b76be7d ("Build in merge", 2008-07-07).  Remove it.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index f178f5a3ee1..00de224a2da 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -375,7 +375,6 @@ static void reset_hard(const struct object_id *oid, int verbose)
 static void restore_state(const struct object_id *head,
 			  const struct object_id *stash)
 {
-	struct strbuf sb = STRBUF_INIT;
 	const char *args[] = { "stash", "apply", NULL, NULL };
 
 	if (is_null_oid(stash))
@@ -391,7 +390,6 @@ static void restore_state(const struct object_id *head,
 	 */
 	run_command_v_opt(args, RUN_GIT_CMD);
 
-	strbuf_release(&sb);
 	refresh_cache(REFRESH_QUIET);
 }
 
-- 
gitgitgadget

