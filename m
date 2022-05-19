Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFECC433EF
	for <git@archiver.kernel.org>; Thu, 19 May 2022 17:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243388AbiESRxy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 13:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243434AbiESRxa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 13:53:30 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E169FE94
        for <git@vger.kernel.org>; Thu, 19 May 2022 10:52:47 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id p189so3299426wmp.3
        for <git@vger.kernel.org>; Thu, 19 May 2022 10:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mgKy/wmfp+WZHTlBuoJS32yn4kSi0zwmpGFlL0Vsrn0=;
        b=UvRqafy4rIqr8yDE+jtANOP38UdRKXUmk6yjQPzy94WNihqmGNHWqkqfM6ag1mW6tn
         /6rr4IxxGw+zIpkCd0blPtIBNQaBm/BIS80I0XIEEd5jcpfvU8O8WGDivj24h/zEmgWX
         /MV/fINQXGF/s0DSbiS/VIHGNSj5iekzxtCVrnKgwljsbTu7uOv/snkZ7XnwKWVAm0zk
         9YlBsCcHnBJEAYs5ty2NK+UyOJLhHvadGzT/auMpfPIMaLehRRLzvq1UYwMfSxksIvcO
         zyudm4h1Is9zyxCgywcuwOT4g6D/U3HmAiaT2dGKmNsk+0K5v0igK7Tu+NdYaAVhpuW8
         jXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mgKy/wmfp+WZHTlBuoJS32yn4kSi0zwmpGFlL0Vsrn0=;
        b=FPhpArYGp3JRElorQh/lU54XKVdvk+hHAmbyAf3yLyMEvRCYMr73Zztw7Gk5HBSyjT
         H4JtDCS8xFGNaFbs6o9khBpsey8kZiSwkPOFjQbYdR2rjZm7j3TMwi6CSEC3uzQtDTBI
         PQa4WvN7SiRiPpG5w3OQrvxYL2iyYpgR2r71v898/wObL3a+oXgGlKX1iV0j6Wxv/+CD
         yxxJaMQUIM8GgWk4y1SnBo7lyATQfO+GKTLW6ZZYFfODs9rrQTA6rhWfgB6khqfm53pH
         /mQIvnEyYmgcGFD4fwzMEcvSFgvAA09xE+LlOOCSNYanrK1JgMO+4jJuZ4v3aHrix8XI
         1kkQ==
X-Gm-Message-State: AOAM531zAxPQl2LsIk5RMmx0OdmSlT2zxbKXYNr2jkh9KyknpXLmUjN6
        MrFaP24ift3IyWX/HymvRbhg7vBQjmM=
X-Google-Smtp-Source: ABdhPJzTrHtNaBUJDQdIIqlMIUGSc4lHkoHDQacTJye1FlYtu6JZcV+Y/m9azfDx/5iB7tGrekMtlw==
X-Received: by 2002:a1c:f314:0:b0:397:10a5:a355 with SMTP id q20-20020a1cf314000000b0039710a5a355mr4875661wmq.176.1652982765983;
        Thu, 19 May 2022 10:52:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s9-20020a7bc389000000b0039482d95ab7sm167878wmj.24.2022.05.19.10.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 10:52:45 -0700 (PDT)
Message-Id: <c977001c033e8689f6d0ca52a6021bde61b1b476.1652982759.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1208.v2.git.1652982758.gitgitgadget@gmail.com>
References: <pull.1208.git.1652724693.gitgitgadget@gmail.com>
        <pull.1208.v2.git.1652982758.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 May 2022 17:52:33 +0000
Subject: [PATCH v2 05/10] cache-tree: implement cache_tree_find_path()
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
similar search but also modifies the nodes it finds along the way.

This new method is not currently used, but will be in an upcoming
change.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 cache-tree.c | 24 ++++++++++++++++++++++++
 cache-tree.h |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/cache-tree.c b/cache-tree.c
index 6752f69d515..23893a7b113 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -100,6 +100,30 @@ struct cache_tree_sub *cache_tree_sub(struct cache_tree *it, const char *path)
 	return find_subtree(it, path, pathlen, 1);
 }
 
+struct cache_tree *cache_tree_find_path(struct cache_tree *it, const char *path)
+{
+	const char *slash;
+	int namelen;
+	struct cache_tree_sub *down;
+
+	if (!it)
+		return NULL;
+	slash = strchrnul(path, '/');
+	namelen = slash - path;
+	it->entry_count = -1;
+	if (!*slash) {
+		int pos;
+		pos = cache_tree_subtree_pos(it, path, namelen);
+		if (0 <= pos)
+			return it->down[pos]->cache_tree;
+		return NULL;
+	}
+	down = find_subtree(it, path, namelen, 0);
+	if (down)
+		return cache_tree_find_path(down->cache_tree, slash + 1);
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

