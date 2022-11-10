Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A126C433FE
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 01:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbiKJB6P (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 20:58:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbiKJB5u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 20:57:50 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506892E68F
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 17:57:23 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id cl5so301311wrb.9
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 17:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/zicVtu+r7gO5FwNJ/+MUMzuPbt221qJMX9gz8tkU0=;
        b=Mlf/LMV9cGa8eOzsIL1+z5TB+5bU8GWETmSvyp7RqBi4ryl4S7ZtgXtf4eMUltEA3G
         Sgct+IxQ7Mvl2jLCmMZ7mcvddOkbYCM+iOmiQhwRSyuMHxB0idxqAvZOQ02N7sr4DvhP
         xgmJqN5fPCcWsKw4RaBAJHO5a57FGylp/LaJNR160BN2khXDXjyBTJBaCQYMVFz/ZyS3
         ZScuQRN+DR46BU9zKy/UPc+SMCJWppNEg04ElwIwyJFNHuC/KdvuNwBk43O6Y/FtKuO5
         6s042rQ3c9gNjm3GVNAb6QIeBw0teLTN8eG9kO5lHSYQdfd/lSsP1HLYgVzgVwn0By7Y
         2YoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y/zicVtu+r7gO5FwNJ/+MUMzuPbt221qJMX9gz8tkU0=;
        b=ATEqEFu+wp0nFuTJghXnS6kbDA6VtRVjZNJyteCyQ6OV4edIyJImtfcItuK19qG1MG
         4knI4kZ82AV8+CwB3wrtmyyyv1/eM1MsYGX+QUK9HZ8oyRrvip4VZbSIYfpJBDNSFXxc
         SPo64ogBu+H6AkHLVrfmQpka1UKwaebv3+OKxK72x4ZKSbJBuP/VW++V7ROF1HwrGzQN
         y1b0DRO5zPquHpWtHINu/UmJnkDoJ6rjQrY9zkaQ1vyH8h44qcqKJT9sAWXBTVgpYk6W
         UIX5F8pz418SMh08PB83I+lO9NjgLWtL1eamOHjBrVrX+erkYNMnNVzSQWklEvZm563A
         sfuA==
X-Gm-Message-State: ACrzQf3f6r42MRT78UFMl7Bvb+MYmGEcXpGch+4XwiX+MVbyvA1VXZIy
        VwwjXZAx+kt86mB0HzEwraNE3WTZNn4=
X-Google-Smtp-Source: AMsMyM4nX14oiPEEvx7/IBSmmVT7cX6MKyEU3JVXTRVVwB2w3V8J6p7+WsbYoJxtlRamnY11rB7cHA==
X-Received: by 2002:a5d:64cd:0:b0:236:6d1c:c1a2 with SMTP id f13-20020a5d64cd000000b002366d1cc1a2mr41676652wri.360.1668045441641;
        Wed, 09 Nov 2022 17:57:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f17-20020a056000129100b002368a6deaf8sm14584531wrx.57.2022.11.09.17.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 17:57:21 -0800 (PST)
Message-Id: <b015a4f531c6f8f25f08c06dcdf3a9d709a00cd3.1668045438.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1411.v2.git.1668045438.gitgitgadget@gmail.com>
References: <pull.1411.git.1667947465.gitgitgadget@gmail.com>
        <pull.1411.v2.git.1668045438.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Nov 2022 01:57:14 +0000
Subject: [PATCH v2 2/5] unpack-trees: add 'skip_cache_tree_update' option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, phillip.wood123@gmail.com,
        derrickstolee@github.com, jonathantanmy@google.com,
        Taylor Blau <me@ttaylorr.com>, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
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

