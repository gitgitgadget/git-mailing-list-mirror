Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD38C433EF
	for <git@archiver.kernel.org>; Mon, 23 May 2022 13:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236729AbiEWNtN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 09:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236699AbiEWNtC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 09:49:02 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE8F393D4
        for <git@vger.kernel.org>; Mon, 23 May 2022 06:48:56 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id h5so20334652wrb.11
        for <git@vger.kernel.org>; Mon, 23 May 2022 06:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AG+pinYYeC7JqPgv69XRiMK3ws7OFwejY/XATs8rfe4=;
        b=qFuTJ6pQTsXp5zZP06wn0lcUGOTFaAagybNfJ3TYJTE9EWgae1OMoCRzFTEKpJDCvF
         D46+lSGMdtsL440DFP/4eLkRNg3qkqxU7zrQJleKnlEX7EcqkX1u/QwHLzc+19mvcEPj
         evlZPzWV/ymXQeB1MD39Ox0C7PB5G8QdzQPDw3hOK/MWwS34pvb+Ai5UMlKbrhtHc6c8
         bJVLLrh06czWSkvBuMNyV4pRWojCsxUhJDo6OrdRQQ2mv32U6L4+AJcjWIviAWjmLa1I
         GM2J5rw4oejU7QaJv9S+AmZNfJ75manjZnndWc/bWtXam0xZEBDrwnxJsUeud0vYSB+L
         dybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AG+pinYYeC7JqPgv69XRiMK3ws7OFwejY/XATs8rfe4=;
        b=V8CcULHuikdiac2WGlM6AtcEqcqHF/coxZrysc0V1pzcEIbK2rWGqyuyFRNiWQnuHJ
         O1FPhqDKmwCONGNVvmAgzET2mlybWNmXTTsDzKTkbI77Bc+SpBHrqF8tnwBw8LmpltYh
         hojszX8pE+ZUErM83rAE54a9uRBSiodA5E+DKnPDuhsMG13ujRI70+nh3thReSk3ny/0
         3wboUu97PvLiRfLTPObCGZrfBIdsW15VaMKPNxZ/r8R8crFf8gXsnyj1RQZMqL9wAcCJ
         O0NbVAiUjSoXLWck10y46wVF+yXcwWw7TBi5tKyel/F+YaJdVERWLo7vyqyoHHZegEdT
         Xnew==
X-Gm-Message-State: AOAM533kYkmqepkMk2rV03FPOeZC5HHF019w2PxYzFbHK8MDIuKVu9TG
        /2RR2LqVjpd4sXn2Ua3LvMyP+b0XBmQ=
X-Google-Smtp-Source: ABdhPJykQQCV5rAwBZ9WHH+pCXGAlxzxiyb1qF3zVe/1vKH9nv9V37WZjfn0aUc64/MFOm2kqDsxLg==
X-Received: by 2002:a05:6000:1f89:b0:20e:5db3:febf with SMTP id bw9-20020a0560001f8900b0020e5db3febfmr18943138wrb.685.1653313735024;
        Mon, 23 May 2022 06:48:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id az10-20020a05600c600a00b003974860e15esm4104538wmb.40.2022.05.23.06.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 06:48:54 -0700 (PDT)
Message-Id: <9103584ed75cdc3bb3c2afd87df53161e0eef9b1.1653313727.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1208.v3.git.1653313726.gitgitgadget@gmail.com>
References: <pull.1208.v2.git.1652982758.gitgitgadget@gmail.com>
        <pull.1208.v3.git.1653313726.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 May 2022 13:48:41 +0000
Subject: [PATCH v3 05/10] cache-tree: implement cache_tree_find_path()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, shaoxuan.yuan02@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Given a 'struct cache_tree', it may be beneficial to navigate directly
to a node within that corresponds to a given path name. Create
cache_tree_find_path() for this function. It returns NULL when no such
path exists.

The implementation is adapted from do_invalidate_path() which does a
similar search but also modifies the nodes it finds along the way. The
method could be implemented simply using tail-recursion, but this while
loop does the same thing.

This new method is not currently used, but will be in an upcoming
change.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 cache-tree.c | 27 +++++++++++++++++++++++++++
 cache-tree.h |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/cache-tree.c b/cache-tree.c
index 6752f69d515..f42db920d10 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -100,6 +100,33 @@ struct cache_tree_sub *cache_tree_sub(struct cache_tree *it, const char *path)
 	return find_subtree(it, path, pathlen, 1);
 }
 
+struct cache_tree *cache_tree_find_path(struct cache_tree *it, const char *path)
+{
+	const char *slash;
+	int namelen;
+	struct cache_tree_sub it_sub = {
+		.cache_tree = it,
+	};
+	struct cache_tree_sub *down = &it_sub;
+
+	while (down) {
+		slash = strchrnul(path, '/');
+		namelen = slash - path;
+		down->cache_tree->entry_count = -1;
+		if (!*slash) {
+			int pos;
+			pos = cache_tree_subtree_pos(down->cache_tree, path, namelen);
+			if (0 <= pos)
+				return down->cache_tree->down[pos]->cache_tree;
+			return NULL;
+		}
+		down = find_subtree(it, path, namelen, 0);
+		path = slash + 1;
+	}
+
+	return NULL;
+}
+
 static int do_invalidate_path(struct cache_tree *it, const char *path)
 {
 	/* a/b/c
diff --git a/cache-tree.h b/cache-tree.h
index 8efeccebfc9..f75f8e74dcd 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -29,6 +29,8 @@ struct cache_tree_sub *cache_tree_sub(struct cache_tree *, const char *);
 
 int cache_tree_subtree_pos(struct cache_tree *it, const char *path, int pathlen);
 
+struct cache_tree *cache_tree_find_path(struct cache_tree *it, const char *path);
+
 void cache_tree_write(struct strbuf *, struct cache_tree *root);
 struct cache_tree *cache_tree_read(const char *buffer, unsigned long size);
 
-- 
gitgitgadget

