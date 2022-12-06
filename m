Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3572C352A1
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 17:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbiLFRkZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 12:40:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235151AbiLFRjz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 12:39:55 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBA742F4C
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 09:38:24 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id q7so24553468wrr.8
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 09:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ga3V301CkJyVnITrRtdADHIE+/PNutCinOREuqu+09s=;
        b=OUatTspVZjubKZjOKYzLwjRdtDVw4Wusz+13HFMN/f8QM405RqX5FgFN/3gZntk5zW
         SA3MOmt7+x9uexe6JLMo4DpIHxM+UaqE0k/qY9zFsoiOTeONMjTfPRyDhTfopUK11ppG
         W05LEmrkxfoXau3qodrfVygSBf+Umw7VWb6zCqyrEwW0Ri1zMqjeTqF7PttQfJhet4bT
         ZqsIwRHtLOhPtUPUWW6t5O1qcgRK82KHgqxW0AnqzMsw00kGAvqGUWSv56s16NQ3iXYC
         gYfC56q364PXy++bl8pKkV1GtPXxVevm2yGx0aflx73Ex6CHrJ1C4oKx8upm0jJXxIDw
         YxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ga3V301CkJyVnITrRtdADHIE+/PNutCinOREuqu+09s=;
        b=1CT7zRU1mGc8d0LFHJVpT130e/BzWOOnNqmpgPKeTK4sWR1t+pyI3YfU8OLa6VSGix
         QpnAVR6QFrQUpfpZbs34eRsy96fvUKtT0w6HMGY+7SAThCIL+d/jeqH9hiP1tL8XzEXr
         rXzO+P5OFFWs6MHSi4c0ESvT0o26cA7k/i23jrVaKFvlho1M51PpCLXbeaLIwH0dRCIU
         qMqs1zyX6yniI/x7MW6Xif4ACkSTQCn91Ye/LDGM5lLBcqpJk5BkJV9tohw8iqVJ45sd
         OgdROjlQSusWrZ0de6H1SU7mA5MXbtldL0LLncbSrxPl7rO0f2gwoTErinlC8OwmhgqD
         jDAA==
X-Gm-Message-State: ANoB5pkczgtiwkuPS1wpf6Cf41DhDrPzdgT4doVikewG2INV2TFssAqj
        49ARq1Gpl36+xPTeott7fSrUTEOJjNw=
X-Google-Smtp-Source: AA0mqf4l4k1TXuZfJSfJAkizNr0oDk7fUV8MpWDiwyZKVyY542T7LsTYO1MDWjSpMAlxW2U5F3v8Ew==
X-Received: by 2002:a05:6000:2c9:b0:242:1b0e:5647 with SMTP id o9-20020a05600002c900b002421b0e5647mr23050331wry.683.1670348302760;
        Tue, 06 Dec 2022 09:38:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o29-20020adfa11d000000b0024278304ef6sm2056655wro.13.2022.12.06.09.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 09:38:22 -0800 (PST)
Message-Id: <pull.1390.v5.git.git.1670348301601.gitgitgadget@gmail.com>
In-Reply-To: <pull.1390.v4.git.git.1670256724311.gitgitgadget@gmail.com>
References: <pull.1390.v4.git.git.1670256724311.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 06 Dec 2022 17:38:21 +0000
Subject: [PATCH v5] revision: use calloc instead of malloc where possible
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

We can avoid having to call memset by calling calloc directly

Signed-off-by: Seija doremylover123@gmail.com
---
    revision: use calloc instead of malloc where possible
    
    We can avoid having to call memset by calling calloc directly
    
    Signed-off-by: Seija doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1390%2FAtariDreams%2Fcalloc-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1390/AtariDreams/calloc-v5
Pull-Request: https://github.com/git/git/pull/1390

Range-diff vs v4:

 1:  3cd6b1eab13 ! 1:  8072fa30e4f maintenance: use calloc instead of malloc where possible
     @@ Metadata
      Author: Seija <doremylover123@gmail.com>
      
       ## Commit message ##
     -    maintenance: use calloc instead of malloc where possible
     +    revision: use calloc instead of malloc where possible
      
          We can avoid having to call memset by calling calloc directly
      
     @@ Commit message
      
       ## builtin/pack-redundant.c ##
      @@ builtin/pack-redundant.c: static inline struct llist_item *llist_item_get(void)
     - 		new_item = free_nodes;
     - 		free_nodes = free_nodes->next;
     - 	} else {
     --		int i = 1;
     -+		size_t i = 1;
     - 		ALLOC_ARRAY(new_item, BLKSIZE);
     - 		for (; i < BLKSIZE; i++)
     - 			llist_item_put(&new_item[i]);
     -@@ builtin/pack-redundant.c: static inline struct llist_item *llist_item_get(void)
     + 	return new_item;
     + }
       
     - static inline void llist_init(struct llist **list)
     - {
     +-static inline void llist_init(struct llist **list)
     +-{
      -	*list = xmalloc(sizeof(struct llist));
      -	(*list)->front = (*list)->back = NULL;
      -	(*list)->size = 0;
     -+	CALLOC_ARRAY(*list, 1);
     - }
     - 
     +-}
     +-
       static struct llist * llist_copy(struct llist *list)
     + {
     + 	struct llist *ret;
     + 	struct llist_item *new_item, *old_item, *prev;
     + 
     +-	llist_init(&ret);
     ++	CALLOC_ARRAY(ret, 1);
     + 
     + 	if ((ret->size = list->size) == 0)
     + 		return ret;
     +@@ builtin/pack-redundant.c: static void load_all_objects(void)
     + 	struct pack_list *pl = local_packs;
     + 	struct llist_item *hint, *l;
     + 
     +-	llist_init(&all_objects);
     ++	CALLOC_ARRAY(all_objects, 1);
     + 
     + 	while (pl) {
     + 		hint = NULL;
     +@@ builtin/pack-redundant.c: static void cmp_local_packs(void)
     + 
     + 	/* only one packfile */
     + 	if (!pl->next) {
     +-		llist_init(&pl->unique_objects);
     ++		CALLOC_ARRAY(pl->unique_objects, 1);
     + 		return;
     + 	}
     + 
     +@@ builtin/pack-redundant.c: static struct pack_list * add_pack(struct packed_git *p)
     + 		return NULL;
     + 
     + 	l.pack = p;
     +-	llist_init(&l.remaining_objects);
     ++	CALLOC_ARRAY(l.remaining_objects, 1);
     + 
     + 	if (open_pack_index(p))
     + 		return NULL;
     +@@ builtin/pack-redundant.c: int cmd_pack_redundant(int argc, const char **argv, const char *prefix)
     + 		scan_alt_odb_packs();
     + 
     + 	/* ignore objects given on stdin */
     +-	llist_init(&ignore);
     ++	CALLOC_ARRAY(ignore, 1);
     + 	if (!isatty(0)) {
     + 		while (fgets(buf, sizeof(buf), stdin)) {
     + 			oid = xmalloc(sizeof(*oid));
      
       ## remote.c ##
      @@ remote.c: void apply_push_cas(struct push_cas_option *cas,
     @@ submodule.c: static struct fetch_task *fetch_task_create(struct submodule_parall
       
       	task->sub = submodule_from_path(spf->r, treeish_name, path);
       
     -
     - ## xdiff/xutils.c ##
     -@@ xdiff/xutils.c: void *xdl_cha_alloc(chastore_t *cha) {
     - 	void *data;
     - 
     - 	if (!(ancur = cha->ancur) || ancur->icurr == cha->nsize) {
     --		if (!(ancur = (chanode_t *) xdl_malloc(sizeof(chanode_t) + cha->nsize))) {
     -+		if (!(ancur = (chanode_t *) xdl_calloc(1, sizeof(chanode_t) + cha->nsize))) {
     - 
     - 			return NULL;
     - 		}
     --		ancur->icurr = 0;
     --		ancur->next = NULL;
     - 		if (cha->tail)
     - 			cha->tail->next = ancur;
     - 		if (!cha->head)


 builtin/pack-redundant.c | 17 +++++------------
 remote.c                 |  4 ++--
 submodule.c              | 10 +++++-----
 3 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index ecd49ca268f..ce5be807cf0 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -59,19 +59,12 @@ static inline struct llist_item *llist_item_get(void)
 	return new_item;
 }
 
-static inline void llist_init(struct llist **list)
-{
-	*list = xmalloc(sizeof(struct llist));
-	(*list)->front = (*list)->back = NULL;
-	(*list)->size = 0;
-}
-
 static struct llist * llist_copy(struct llist *list)
 {
 	struct llist *ret;
 	struct llist_item *new_item, *old_item, *prev;
 
-	llist_init(&ret);
+	CALLOC_ARRAY(ret, 1);
 
 	if ((ret->size = list->size) == 0)
 		return ret;
@@ -448,7 +441,7 @@ static void load_all_objects(void)
 	struct pack_list *pl = local_packs;
 	struct llist_item *hint, *l;
 
-	llist_init(&all_objects);
+	CALLOC_ARRAY(all_objects, 1);
 
 	while (pl) {
 		hint = NULL;
@@ -475,7 +468,7 @@ static void cmp_local_packs(void)
 
 	/* only one packfile */
 	if (!pl->next) {
-		llist_init(&pl->unique_objects);
+		CALLOC_ARRAY(pl->unique_objects, 1);
 		return;
 	}
 
@@ -512,7 +505,7 @@ static struct pack_list * add_pack(struct packed_git *p)
 		return NULL;
 
 	l.pack = p;
-	llist_init(&l.remaining_objects);
+	CALLOC_ARRAY(l.remaining_objects, 1);
 
 	if (open_pack_index(p))
 		return NULL;
@@ -620,7 +613,7 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix)
 		scan_alt_odb_packs();
 
 	/* ignore objects given on stdin */
-	llist_init(&ignore);
+	CALLOC_ARRAY(ignore, 1);
 	if (!isatty(0)) {
 		while (fgets(buf, sizeof(buf), stdin)) {
 			oid = xmalloc(sizeof(*oid));
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
 

base-commit: 2e71cbbddd64695d43383c25c7a054ac4ff86882
-- 
gitgitgadget
