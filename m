Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D489C43334
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 21:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356060AbiFNV2O (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 17:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353898AbiFNV17 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 17:27:59 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F085A31927
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 14:27:58 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id z17so5345363wmi.1
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 14:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=alRx2CpD6UCtMqSiYdRE3shPSPHBMdmw/AvBwMyz424=;
        b=HnNlKR+npqKct923vfZD2lXq4G2ykqw6/8vBAoM7qiy8thcmsMgltFc9KHht/qKFHa
         wrwDrhDMFrqthlOGboENI+ouaPHGpLRT0B0tQENDcjoYHK3HVrtysufkb/m9OxvlRVcm
         NIulk1ZHO2NE8Br6uOhSujajSjIv6knM0RPrhf3FyxcHRHTJsUU/L2w7XpCIMCe7y7QX
         FMnuvIcRM/BhDmo9I2t5eolx0D6AqcXOXQKbnvIQxCGsPBdLQDpRIQ3Yz/HVxWqKjVQW
         ERta2SaQY1igtfF2PVVLTXoO+qVN4YYf7VtjEzr0APEzpFPlCd/XoQO5rRLYOhrfC0Lp
         dp0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=alRx2CpD6UCtMqSiYdRE3shPSPHBMdmw/AvBwMyz424=;
        b=CSvDwPNFiTcc3J/mv/yMY1D74L/dqRToUf9hg6O9ofl59axqpHUTw2ayHr/PmjOaXf
         e30A3HWtXFkNALI7kH8cZAaNexrO3z1WpP3CXO7KjihbVPv97e0piRlkQCVpIf19T0Qw
         /+/SVwlkNuiVoFnK9uICaeUrsRVKdTmkIp15ULNnhzSsHqUHYqfHAjoXB0y3DYOj+RXx
         XPlhFHZzW9F+fZw65zsn3ys9Lmw1TomqV3ds37dgqtl2NAp3/NaBtkeypIZjYybOXTSr
         7kgLb9YzlmN+msaVTwS+/XJPZMhM7tziOSyXJKqRO7rYIpc1T6D0NUiaaXN7v6kKg0Pu
         AJ8A==
X-Gm-Message-State: AOAM532K0hQ7BQ5OmaypKQxb3b9PnKlBgT/LrvYYWhgGHdqp9v7TwYN/
        FqQ4x8cYw99PMG5Cu8UnngoHWGHx1J896A==
X-Google-Smtp-Source: ABdhPJwEdhvJqOAb6emrxLflJBwaorg3B+DYasKLLSDkvYfFR+s2CEhEDNrSwoyNwG327xWPLT95gg==
X-Received: by 2002:a05:600c:1d9b:b0:39c:7e00:6b7c with SMTP id p27-20020a05600c1d9b00b0039c7e006b7cmr6162848wms.50.1655242077148;
        Tue, 14 Jun 2022 14:27:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g16-20020a05600c4ed000b0039c5497deccsm5633148wmq.1.2022.06.14.14.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 14:27:56 -0700 (PDT)
Message-Id: <81d8e2b5fddbc0943f6daa6d8bdb189bb98da57e.1655242070.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1261.git.1655242070.gitgitgadget@gmail.com>
References: <pull.1261.git.1655242070.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Jun 2022 21:27:50 +0000
Subject: [PATCH 4/4] cache-tree: remove cache_tree_find_path()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

This reverts 080ab56a46 (cache-tree: implement cache_tree_find_path(),
2022-05-23). The cache_tree_find_path() method was never actually called
in the topic that added it. I cannot find any reference to it in any of
my forks, so this appears to not be needed at the moment.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 cache-tree.c | 27 ---------------------------
 cache-tree.h |  2 --
 2 files changed, 29 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index ff794d940fa..56db0b5026b 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -101,33 +101,6 @@ struct cache_tree_sub *cache_tree_sub(struct cache_tree *it, const char *path)
 	return find_subtree(it, path, pathlen, 1);
 }
 
-struct cache_tree *cache_tree_find_path(struct cache_tree *it, const char *path)
-{
-	const char *slash;
-	int namelen;
-	struct cache_tree_sub it_sub = {
-		.cache_tree = it,
-	};
-	struct cache_tree_sub *down = &it_sub;
-
-	while (down) {
-		slash = strchrnul(path, '/');
-		namelen = slash - path;
-		down->cache_tree->entry_count = -1;
-		if (!*slash) {
-			int pos;
-			pos = cache_tree_subtree_pos(down->cache_tree, path, namelen);
-			if (0 <= pos)
-				return down->cache_tree->down[pos]->cache_tree;
-			return NULL;
-		}
-		down = find_subtree(it, path, namelen, 0);
-		path = slash + 1;
-	}
-
-	return NULL;
-}
-
 static int do_invalidate_path(struct cache_tree *it, const char *path)
 {
 	/* a/b/c
diff --git a/cache-tree.h b/cache-tree.h
index f75f8e74dcd..8efeccebfc9 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -29,8 +29,6 @@ struct cache_tree_sub *cache_tree_sub(struct cache_tree *, const char *);
 
 int cache_tree_subtree_pos(struct cache_tree *it, const char *path, int pathlen);
 
-struct cache_tree *cache_tree_find_path(struct cache_tree *it, const char *path);
-
 void cache_tree_write(struct strbuf *, struct cache_tree *root);
 struct cache_tree *cache_tree_read(const char *buffer, unsigned long size);
 
-- 
gitgitgadget
