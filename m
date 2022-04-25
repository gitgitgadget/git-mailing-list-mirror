Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA72C433EF
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 18:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244411AbiDYSac (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 14:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244394AbiDYSaZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 14:30:25 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D522494F
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 11:27:21 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id e24so2222868wrc.9
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 11:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kczYCUHw+1nMYj9Cvx/MKSwiYjIGpq6otbGN3aX6VrQ=;
        b=ITQW1MjFGYzepWEImEw3ZJO/Mr1/Xlhni514pO7Y+NAFmEF1aczb3aqp7vaCK2fmh2
         2zvqFDP/6unhoqZPtAy2sf90cPlJhSfkT/2xBhKvTwTakDoIuKHfxHa6C2z3/h7M4ns1
         yrFp+0GG9ZLzJh0G0VSrgmPlnHmMdLyhVKGWdx3u2nkVRT6/Ohtgjk1YoEVPdw2aDP/+
         9OCUlSQ6VU0n0qKpHKfKREnOw2SvizJNZKdFJ/D/Xv5EVdRcoJPNCpG7memUXB136vch
         evugTJDmjwdAi+6CVPVhOFDV5sMdIAfGCD9wtilhsC9y3XDYCRHgBxyfp0tjdasgp4yW
         OpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kczYCUHw+1nMYj9Cvx/MKSwiYjIGpq6otbGN3aX6VrQ=;
        b=OfGwpmuejCMoApcguU0c13aX7vd2soatYFMkLQOwyGMR2cNrjkhSXavUWnUqPbFyGA
         MMn031PaOjALdNIBAOJMVH/J67yWh9ghi0RcC+Ix8gvLB7LQqW7BAy893So2Vuju/qmx
         kp89CTv5/GAt/tJhNtwdA/yfENC/YeRL6cMMUYuBxNQs9NKoN7PrhRHNPVRyuHR623+n
         KhAL2/m8OdrBRm0j/s5pEg/+MVrBoIX0GhcJYWcssXZkAvMfUUYuAfYSChJf6ekEqFRL
         vSExG1U7CfTtvI5PGe7kHbTL3g1LXzm7ndW3kG8bmENzZWgLYeZYYEN8x7TdVlBlmLl/
         7AYQ==
X-Gm-Message-State: AOAM532rNaKZzlqZlS3RC4xgHV6NaHd9Lj58bawinwptBWQ/E1YBLx0e
        dcHlxFhKDOtHC69Qq1/J+dCI7v10daA=
X-Google-Smtp-Source: ABdhPJyC6FYWO02Vk1ZzkXQRPnhMocuxTAUhvCqdhKcSU3Zi9spogqa1vvBM+49PotELo+RJrpep8A==
X-Received: by 2002:adf:fc42:0:b0:20a:c45d:3767 with SMTP id e2-20020adffc42000000b0020ac45d3767mr15335192wrs.486.1650911239316;
        Mon, 25 Apr 2022 11:27:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p2-20020a1c7402000000b0038159076d30sm12004044wmc.22.2022.04.25.11.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 11:27:18 -0700 (PDT)
Message-Id: <c9b13f0e1465f8dd41399bba533b3499fc8c8f5d.1650911234.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1221.v2.git.1650911234.gitgitgadget@gmail.com>
References: <pull.1221.git.1650553069.gitgitgadget@gmail.com>
        <pull.1221.v2.git.1650911234.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Apr 2022 18:27:14 +0000
Subject: [PATCH v2 3/3] cache: use const char * for get_object_directory()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The get_object_directory() method returns the exact string stored at
the_repository->objects->odb->path. The return type of "char *" implies
that the caller must keep track of the buffer and free() it when
complete. This causes significant problems later when the ODB is
accessed.

Use "const char *" as the return type to avoid this confusion. There are
no current callers that care about the non-const definition.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 cache.h       | 2 +-
 environment.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 6226f6a8a53..595582becc8 100644
--- a/cache.h
+++ b/cache.h
@@ -566,7 +566,7 @@ extern char *git_work_tree_cfg;
 int is_inside_work_tree(void);
 const char *get_git_dir(void);
 const char *get_git_common_dir(void);
-char *get_object_directory(void);
+const char *get_object_directory(void);
 char *get_index_file(void);
 char *get_graft_file(struct repository *r);
 void set_git_dir(const char *path, int make_realpath);
diff --git a/environment.c b/environment.c
index 5bff1b386fd..b3296ce7d15 100644
--- a/environment.c
+++ b/environment.c
@@ -273,7 +273,7 @@ const char *get_git_work_tree(void)
 	return the_repository->worktree;
 }
 
-char *get_object_directory(void)
+const char *get_object_directory(void)
 {
 	if (!the_repository->objects->odb)
 		BUG("git environment hasn't been setup");
-- 
gitgitgadget
