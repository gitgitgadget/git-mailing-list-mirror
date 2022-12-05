Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD8EC4332F
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 16:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbiLEQBb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 11:01:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiLEQB2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 11:01:28 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE96B19C04
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 08:01:27 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id bs21so19312865wrb.4
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 08:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L30lt26pLxGJQkGxWb26Uf43QBjIQImqfwsAjhDsRw8=;
        b=N39isMXHZ91+CMoHXgPHSSu3716SGYP+b5KOZJ6CL4Afub5aUq8O2OQKSFXYcu7RVz
         luKThN+FP1osqy0QgKNEIB4wbD5BFf5W/annLo3wxJaL8QMpP1UcptOQ6wE6aYY8f1RN
         PRyYJcuV32ew8i6JSRk/8nVMjlD8Q9qhlmhgbbh0E+H9YA9vYY6El8ZIbrmdEuteb2AS
         jJzziPBzYVjj4PMf4o1IVfljQ4iPYFiVlitHUPU1d0a4kZ6htgLe7+bej0JEZe0Au3KZ
         dDG2PW1tu8x4CPY3Knd1V8U3H181m2fUEpmypFVyEPpDed/EKWa+MzdxZFpihgHPQEHB
         NbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L30lt26pLxGJQkGxWb26Uf43QBjIQImqfwsAjhDsRw8=;
        b=25nDfMmfK1GAx7NinTAbXH9coGKKO7+TVf+a9StpXWrzpw+VypqVaTanHpi8LC7GId
         2C7ZTDF6vYyUj7GRIeAsV3pOqosQuTjaQQ8i0X4zIB1Gn1z5dk5z6uUTqoWGgO4RdSzU
         6F7U7LXr5r1+r81wxei7LnRmQ4ArPaghGFYWDvd1wROvmjREa76QGmJbGCzGu/mQBXlp
         Mww1TtnXkljMcc85ng0dinto6O4HIJM/2UH9XLzsFcDLqbJHQUwY8AhWxAjmMEP/+rM/
         ThXtfxu482oGoy+vxhb7rXiK/SQ8GCUVwu83/AoId4RT/XvQ/FDgOTzXh0aA/U5LgbHj
         jWOw==
X-Gm-Message-State: ANoB5plZAPVRmH3CwphZllFRLZZhPvIimSH4ZAuCXvIiH64jfJKwjyDq
        aL31dAQguNcIJsglsH0PX2I4B0nFgw8=
X-Google-Smtp-Source: AA0mqf5SSs+AII8w+2USfeS4RI6dvTteMiClAvraSq6r8TYZvZ4yuAemkZSsTesGMULXLh4FamcbMg==
X-Received: by 2002:adf:d0c6:0:b0:242:1873:bb28 with SMTP id z6-20020adfd0c6000000b002421873bb28mr21498040wrh.485.1670256086013;
        Mon, 05 Dec 2022 08:01:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z2-20020a05600c220200b003cfd10a33afsm21013469wml.11.2022.12.05.08.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 08:01:25 -0800 (PST)
Message-Id: <pull.1390.v3.git.git.1670256084172.gitgitgadget@gmail.com>
In-Reply-To: <pull.1390.v2.git.git.1670254388605.gitgitgadget@gmail.com>
References: <pull.1390.v2.git.git.1670254388605.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 05 Dec 2022 16:01:23 +0000
Subject: [PATCH v3] maintenance: use xcalloc instead of xmalloc where possible
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija <doremylover123@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Seija <doremylover123@gmail.com>

We can avoid having to call memset by calling xcalloc directly

Signed-off-by: Seija doremylover123@gmail.com
---
    maintenance: use xcalloc instead of xmalloc where possible
    
    We can avoid having to call memset by calling xcalloc directly
    
    Signed-off-by: Seija doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1390%2FAtariDreams%2Fcalloc-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1390/AtariDreams/calloc-v3
Pull-Request: https://github.com/git/git/pull/1390

Range-diff vs v2:

 1:  ee8a7af6435 ! 1:  b5cfec60048 maintenance: use xcalloc instead of xmalloc where possible
     @@ Commit message
      
          Signed-off-by: Seija doremylover123@gmail.com
      
     + ## builtin/pack-redundant.c ##
     +@@ builtin/pack-redundant.c: static inline struct llist_item *llist_item_get(void)
     + 		new_item = free_nodes;
     + 		free_nodes = free_nodes->next;
     + 	} else {
     +-		int i = 1;
     ++		size_t i = 1;
     + 		ALLOC_ARRAY(new_item, BLKSIZE);
     + 		for (; i < BLKSIZE; i++)
     + 			llist_item_put(&new_item[i]);
     +@@ builtin/pack-redundant.c: static inline struct llist_item *llist_item_get(void)
     + 
     + static inline void llist_init(struct llist **list)
     + {
     +-	*list = xmalloc(sizeof(struct llist));
     +-	(*list)->front = (*list)->back = NULL;
     +-	(*list)->size = 0;
     ++	CALLOC_ARRAY(*list, 1);
     + }
     + 
     + static struct llist * llist_copy(struct llist *list)
     +
       ## remote.c ##
      @@ remote.c: void apply_push_cas(struct push_cas_option *cas,
       
     @@ submodule.c: struct fetch_task {
       	ret->path = name;
       	ret->name = name;
       
     +@@ submodule.c: static struct fetch_task *fetch_task_create(struct submodule_parallel_fetch *spf
     + 					    const char *path,
     + 					    const struct object_id *treeish_name)
     + {
     +-	struct fetch_task *task = xmalloc(sizeof(*task));
     +-	memset(task, 0, sizeof(*task));
     ++	struct fetch_task *task;
     ++
     ++	CALLOC_ARRAY(task, 1);
     + 
     + 	task->sub = submodule_from_path(spf->r, treeish_name, path);
     + 
     +
     + ## xdiff/xutils.c ##
     +@@ xdiff/xutils.c: void *xdl_cha_alloc(chastore_t *cha) {
     + 	void *data;
     + 
     + 	if (!(ancur = cha->ancur) || ancur->icurr == cha->nsize) {
     +-		if (!(ancur = (chanode_t *) xdl_malloc(sizeof(chanode_t) + cha->nsize))) {
     ++		if (!(ancur = (chanode_t *) xdl_calloc(1, sizeof(chanode_t) + cha->nsize))) {
     + 
     + 			return NULL;
     + 		}
     +-		ancur->icurr = 0;
     +-		ancur->next = NULL;
     + 		if (cha->tail)
     + 			cha->tail->next = ancur;
     + 		if (!cha->head)


 builtin/pack-redundant.c |  6 ++----
 remote.c                 |  4 ++--
 submodule.c              | 10 +++++-----
 xdiff/xutils.c           |  4 +---
 4 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index ecd49ca268f..0e184bb5212 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -51,7 +51,7 @@ static inline struct llist_item *llist_item_get(void)
 		new_item = free_nodes;
 		free_nodes = free_nodes->next;
 	} else {
-		int i = 1;
+		size_t i = 1;
 		ALLOC_ARRAY(new_item, BLKSIZE);
 		for (; i < BLKSIZE; i++)
 			llist_item_put(&new_item[i]);
@@ -61,9 +61,7 @@ static inline struct llist_item *llist_item_get(void)
 
 static inline void llist_init(struct llist **list)
 {
-	*list = xmalloc(sizeof(struct llist));
-	(*list)->front = (*list)->back = NULL;
-	(*list)->size = 0;
+	CALLOC_ARRAY(*list, 1);
 }
 
 static struct llist * llist_copy(struct llist *list)
diff --git a/remote.c b/remote.c
index 60869beebe7..475a1d18af0 100644
--- a/remote.c
+++ b/remote.c
@@ -2741,9 +2741,9 @@ void apply_push_cas(struct push_cas_option *cas,
 
 struct remote_state *remote_state_new(void)
 {
-	struct remote_state *r = xmalloc(sizeof(*r));
+	struct remote_state *r;
 
-	memset(r, 0, sizeof(*r));
+	CALLOC_ARRAY(r, 1);
 
 	hashmap_init(&r->remotes_hash, remotes_hash_cmp, NULL, 0);
 	hashmap_init(&r->branches_hash, branches_hash_cmp, NULL, 0);
diff --git a/submodule.c b/submodule.c
index 8ac2fca855d..015102a83d6 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1458,14 +1458,13 @@ struct fetch_task {
  */
 static const struct submodule *get_non_gitmodules_submodule(const char *path)
 {
-	struct submodule *ret = NULL;
+	struct submodule *ret;
 	const char *name = default_name_or_path(path);
 
 	if (!name)
 		return NULL;
 
-	ret = xmalloc(sizeof(*ret));
-	memset(ret, 0, sizeof(*ret));
+	CALLOC_ARRAY(ret, 1);
 	ret->path = name;
 	ret->name = name;
 
@@ -1504,8 +1503,9 @@ static struct fetch_task *fetch_task_create(struct submodule_parallel_fetch *spf
 					    const char *path,
 					    const struct object_id *treeish_name)
 {
-	struct fetch_task *task = xmalloc(sizeof(*task));
-	memset(task, 0, sizeof(*task));
+	struct fetch_task *task;
+
+	CALLOC_ARRAY(task, 1);
 
 	task->sub = submodule_from_path(spf->r, treeish_name, path);
 
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 9e36f24875d..c19bc441a96 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -98,12 +98,10 @@ void *xdl_cha_alloc(chastore_t *cha) {
 	void *data;
 
 	if (!(ancur = cha->ancur) || ancur->icurr == cha->nsize) {
-		if (!(ancur = (chanode_t *) xdl_malloc(sizeof(chanode_t) + cha->nsize))) {
+		if (!(ancur = (chanode_t *) xdl_calloc(1, sizeof(chanode_t) + cha->nsize))) {
 
 			return NULL;
 		}
-		ancur->icurr = 0;
-		ancur->next = NULL;
 		if (cha->tail)
 			cha->tail->next = ancur;
 		if (!cha->head)

base-commit: 805265fcf7a737664a8321aaf4a0587b78435184
-- 
gitgitgadget
