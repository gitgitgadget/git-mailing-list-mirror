Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A089C4332F
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 19:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbiKJTHs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 14:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbiKJTH3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 14:07:29 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA94C45A35
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 11:06:11 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id j15so3648033wrq.3
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 11:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/zicVtu+r7gO5FwNJ/+MUMzuPbt221qJMX9gz8tkU0=;
        b=f7PnUuCKF06LUCuIJoWJkb2zrWrwbV/G/bXkBjlyfra7OiO3QQSyq6/L57PY9VS9AH
         +F+QG/GIML6FWeZzyne0huJCU1NQCs5ElEpelzaKNxuKYfhFWFsVxx/govlKIG/kOJ/a
         9w35mYDFdKvQFexHhwAs8WWyUV5RCWY6fyLahUAt7E4FRJs7td18pYvXS1twfsJeSDFq
         cyk+/pdsq9RbO35cd7KFn5uVDytxautwUyqgWdnCWfYmvbii333Hrkz25s+iHiVKIUCR
         6XXafBJMFjO41aGKrk4Hpenf/TE6sPuIp4hiE6YkUFsm8ulsoI+AQaqtKeu3NZ1tgXb7
         sgrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y/zicVtu+r7gO5FwNJ/+MUMzuPbt221qJMX9gz8tkU0=;
        b=yKRghAdp5215ev36qilwXR0RMNzhGF8lR0fR4hreInxlJipv6qkyJ1KWKfrYvaAhoe
         s7SzXowwQKpeJKRYH6LyneSeOgvkFv7Ssl0ltvEER54l6vjQT20AMuIK0NI7m3Ude35k
         tloSIOhxdQa4mgIk6TJXw1fjj/kDzU4O9ZMNzcLbzgmIyLOwHwjdXOn2tORKZWrJEdDs
         NAgemfVLb8rbLWsYY3+1ImG3zcrF9LpuxzAIqZBSTMt7vHf8tyDvqoBgjjDEfGz8b0Mr
         1gqggIsnOniNne2HCLbCeBPCIlroC7JE4jaqk/9efyoFEXjeQ1jJLZRr0yKJUQovcCld
         Hqtg==
X-Gm-Message-State: ANoB5plHCmPb1NBNsxxKyMiLliWlXC4Y1mCX4XdOhTCNkZESqKsGkzx0
        C2rvBehrsA9Nsjf9fm8TZzoPEzDtunQ=
X-Google-Smtp-Source: AA0mqf7yOz7YuulMqGsGC1I8U+POunzYgbNo/LHUtFPppasqHstszzkHinRQG2iBYpDxxvj/FkUlDA==
X-Received: by 2002:adf:eb0d:0:b0:236:c429:361a with SMTP id s13-20020adfeb0d000000b00236c429361amr1802547wrn.475.1668107170147;
        Thu, 10 Nov 2022 11:06:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bh14-20020a05600c3d0e00b003c5571c27a1sm506038wmb.32.2022.11.10.11.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 11:06:09 -0800 (PST)
Message-Id: <0e03614f0fd7dd717b21ff9395345c06ecdcee04.1668107165.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1411.v3.git.1668107165.gitgitgadget@gmail.com>
References: <pull.1411.v2.git.1668045438.gitgitgadget@gmail.com>
        <pull.1411.v3.git.1668107165.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Nov 2022 19:06:02 +0000
Subject: [PATCH v3 2/5] unpack-trees: add 'skip_cache_tree_update' option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, phillip.wood123@gmail.com,
        derrickstolee@github.com, jonathantanmy@google.com,
        szeder.dev@gmail.com, Taylor Blau <me@ttaylorr.com>,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Add (disabled by default) option to skip the 'cache_tree_update()' at the
end of 'unpack_trees()'. In many cases, this cache tree update is redundant
because the caller of 'unpack_trees()' immediately follows it with
'prime_cache_tree()', rebuilding the entire cache tree from scratch. While
these operations aren't the most expensive part of operations like 'git
reset', the duplicate calls still create a minor unnecessary slowdown.

Introduce an option for callers to skip the 'cache_tree_update()' in
'unpack_trees()' if it is redundant (that is, if 'prime_cache_tree()' is
called afterwards). At the moment, no 'unpack_trees()' callers use the new
option; they will be updated in subsequent patches.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 unpack-trees.c | 3 ++-
 unpack-trees.h | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index bae812156c4..8a762aa0772 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2043,7 +2043,8 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		if (!ret) {
 			if (git_env_bool("GIT_TEST_CHECK_CACHE_TREE", 0))
 				cache_tree_verify(the_repository, &o->result);
-			if (!cache_tree_fully_valid(o->result.cache_tree))
+			if (!o->skip_cache_tree_update &&
+			    !cache_tree_fully_valid(o->result.cache_tree))
 				cache_tree_update(&o->result,
 						  WRITE_TREE_SILENT |
 						  WRITE_TREE_REPAIR);
diff --git a/unpack-trees.h b/unpack-trees.h
index efb9edfbb27..6ab0d74c84d 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -71,7 +71,8 @@ struct unpack_trees_options {
 		     quiet,
 		     exiting_early,
 		     show_all_errors,
-		     dry_run;
+		     dry_run,
+		     skip_cache_tree_update;
 	enum unpack_trees_reset_type reset;
 	const char *prefix;
 	int cache_bottom;
-- 
gitgitgadget

