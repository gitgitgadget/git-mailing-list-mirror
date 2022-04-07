Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB48C433EF
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 16:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345764AbiDGQje (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 12:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiDGQj3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 12:39:29 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B403E17ECD2
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 09:37:28 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id m30so8723128wrb.1
        for <git@vger.kernel.org>; Thu, 07 Apr 2022 09:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Zqtjsthut8K8Cn5UbpKqIla74vKiYg8A4Ppw1nqvEY0=;
        b=CZMyz0rJCQYuLDmCIlBA4NKUHXp+p5OSQLNgVR8uRUbhnK9zTYEg+Uc49OOFnz/n5W
         WYDShKw/qGLwoOJ4T9GQm+d2UWZnj9CiMZi7j1jaZQqm1UJDenWVbRRw1SwmxPs22dbp
         V911RIOe5MoMVv1AKbvjQyUplH6cTn+W/2bWzDX0f7nsdUuDdhh4/Ktybz5UDOo6wGIt
         tso25xm/x9Byjxhq7D11hYIGh9jUsJihaOXoY5Lru7kCPji6XBoS0GGeCJ7IOGGuh6e6
         TasO8G1E73pwe3faJx2ahrUj1ENVCcl026uZm1+2LQInQoAwOkE8q9kF7rpgaP0rgxl4
         Uqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Zqtjsthut8K8Cn5UbpKqIla74vKiYg8A4Ppw1nqvEY0=;
        b=dnOjcU+A7ODCp3q8nyvB5tSy5oajQCE4DQH6kbvZu6eRa0Hqh/VU3tUDBcHqtwzVBQ
         LSHcOLFpDN946i1z84cpMY2ZOV4NvJTWbI/41BXiNPq5/Bxp62+EewBwk/gdJ7Tmfc4c
         e7NWxd9JHp/hWjMOO6QqV0Ea0FoC/AoP3mufeAILK8SfRNCZb8qrwGy53tZx/LjpKzD+
         oiqwTbwN/uaFqLln1unb0CBCoUM5ZJh3WXhKnUVZ4g+UQbgA6jPed9r2X2uNPSeVB8ZO
         74Wk42ni8/Bp2zyKUZzwe/DGR9bCdMBwfCH/Kc93s7UxdX/ZNLVHGhf54Kq+MXsLYjye
         vHCw==
X-Gm-Message-State: AOAM533pw/1HLMLaeiR+8/T5XkZFYXngYE8pJfqbnaPaalgi8gQdpwpH
        v+BTCrPujAz2snPIXLoWfOW8CtKIUuM=
X-Google-Smtp-Source: ABdhPJxhQ+kLaYmTrFqxPQNU7D3Lmke9r/i9t78dxoqrl4/gCb58I51XalrBE3TVVCTvNT2ZXKixDA==
X-Received: by 2002:a05:6000:10c7:b0:206:135e:c84e with SMTP id b7-20020a05600010c700b00206135ec84emr11161327wrx.12.1649349446859;
        Thu, 07 Apr 2022 09:37:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r4-20020a1c4404000000b0038e6fb9b4fesm8041341wma.48.2022.04.07.09.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 09:37:26 -0700 (PDT)
Message-Id: <f5da532767367844af7ecc477e1c8434a5454fd1.1649349442.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1207.git.1649349442.gitgitgadget@gmail.com>
References: <pull.1207.git.1649349442.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Apr 2022 16:37:21 +0000
Subject: [PATCH 3/4] object-name: reject trees found in the index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, shaoxuan.yuan02@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The get_oid_with_context_1() method is used when parsing revision
arguments. One particular case is to take a ":<path>" string and search
the index for the given path.

In the case of a sparse index, this might find a sparse directory entry,
in which case the contained object is a tree. In the case of a full
index, this search within the index would fail.

In order to maintain identical return state as in a full index, inspect
the discovered cache entry to see if it is a sparse directory and reject
it. This requires being careful around the only_to_die option to be sure
we die only at the correct time.

This changes the behavior of 'git show :<sparse-dir>', but does not
bring it entirely into alignment with a full index case. It specifically
hits the wrong error message within diagnose_invalid_index_path(). That
error message will be corrected in a future change.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 object-name.c                            | 19 ++++++++++++++++++-
 t/t1092-sparse-checkout-compatibility.sh | 11 ++---------
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/object-name.c b/object-name.c
index f0e327f91f5..2dc5d2549b8 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1881,6 +1881,20 @@ static char *resolve_relative_path(struct repository *r, const char *rel)
 			   rel);
 }
 
+static int reject_tree_in_index(struct repository *repo,
+				int only_to_die,
+				const struct cache_entry *ce,
+				int stage,
+				const char *prefix,
+				const char *cp)
+{
+	if (!S_ISSPARSEDIR(ce->ce_mode))
+		return 0;
+	if (only_to_die)
+		diagnose_invalid_index_path(repo, stage, prefix, cp);
+	return -1;
+}
+
 static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 				  const char *name,
 				  unsigned flags,
@@ -1955,9 +1969,12 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 			    memcmp(ce->name, cp, namelen))
 				break;
 			if (ce_stage(ce) == stage) {
+				free(new_path);
+				if (reject_tree_in_index(repo, only_to_die, ce,
+							 stage, prefix, cp))
+					return -1;
 				oidcpy(oid, &ce->oid);
 				oc->mode = ce->ce_mode;
-				free(new_path);
 				return 0;
 			}
 			pos++;
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index f6a14e08b81..9d32361110d 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1164,15 +1164,8 @@ test_expect_success 'show (cached blobs/trees)' '
 	test_must_fail git -C full-checkout show :folder1/ &&
 	test_must_fail git -C sparse-checkout show :folder1/ &&
 
-	git -C sparse-index show :folder1/ >actual &&
-	git -C full-checkout show HEAD:folder1 >expect &&
-
-	# The output of "git show" includes the way we referenced the
-	# objects, so strip that out.
-	test_line_count = 4 actual &&
-	tail -n 2 actual >actual-trunc &&
-	tail -n 2 expect >expect-trunc &&
-	test_cmp expect-trunc actual-trunc
+	test_must_fail git -C sparse-index show :folder1/ 2>err &&
+	grep "is in the index, but not at stage 0" err
 '
 
 test_expect_success 'submodule handling' '
-- 
gitgitgadget

