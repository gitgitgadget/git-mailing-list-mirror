Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927BD1E529
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 00:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734482902; cv=none; b=eHa5pPPahe/V6rsUUSvknquNMpnBOQSKHV2bldWiA+d3BxzNSXdu7n4TEoxY/wWzutJ3L1IqREPvbRtWMyH4z42FPvixZi/OV9o8wwhR84nzO+LwYs5AV5rX8PV7hXVle1BnFtyAjby99D+9n98WREopyiN3NG3qDJGj/ispN8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734482902; c=relaxed/simple;
	bh=AKm6Ojnh0n7G2CYr30zHGM5drW+R1r2UnmhKN9Q4cYE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Rvg/1VlS3wrWP+D68S61Yod5uxpkZkBJ+N2c/QHfuqWHQYmim5NOShedHibdVWNWLrY3ZyEQl4Jg1kuA10a6JMXIFK9RdROc61K8VjyhXaKa9Bl+XnVekIEMozKS9ScrrZDeQU8p5u4sGom0qPTRaT59TvVH9bXs/0ACcsN8NVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2253bP+; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2253bP+"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4362bae4d7dso34099715e9.1
        for <git@vger.kernel.org>; Tue, 17 Dec 2024 16:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734482897; x=1735087697; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hk2T5f78d46i5gc8o3R3U1mB3DZlfMMlDMkjwlT2M0Q=;
        b=Z2253bP+Undc7rLnOvPj/jbaYDHtqJiD4aINrjbariNy3y3YnJMAmayYK56orOQMaR
         44C13faMLp0OzX03XzYtAx5Ym7PepRwdrhQmE8L6G9p4QDe/l52OjjlLjRVSTaVfvKRk
         Rkyos2EDCvhl/i9KQU3t6mSNcRDCzwqc0WgV5ZituqaflK01fSa0hfC+eF8zvXVscc+m
         JMYNuwwgvR0QY06d2tnD36VpRn3iMjLmpzsFeIJsqZAjJxjvVNn/rAFtbLFK+wwBxIyr
         sak7i7+zPKI3Dab0OxfzzoOlCuexj87+8itnZs/M9DLAbjP6kYywKfIlmvoVoNCSnMQI
         +RXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734482897; x=1735087697;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hk2T5f78d46i5gc8o3R3U1mB3DZlfMMlDMkjwlT2M0Q=;
        b=DalVpqiFFr/mBg5kwnjvZCVq80wwGcxqAG63sYQ8WluK2HkkWYupBZ8wWl7fxHpEWC
         ovJHAF4AS3QQVQCycx2X5UkAtb4+UL5n49AfAF1Q8qjxvbIQypvlpSKpZJCam9TEa9QE
         zsFtBY8p5IIWvnkULpboZu3I5aLkxOzs/CAM4rzZtRt7HwoUIYFBvQAO2/9e3dfRsn9y
         gkilenyUQF5/4UHWOZn/QngAmkKiV55/gXLiBrSfjaFFdYanVmnNNUkZGy0jcaHj0/HP
         HuNOPnEMM4SOe0ArXahnQtDWinyt/zcH8ThYE4b9+0xdFuoNQ4lUk5LKu+ulVOslOwgk
         4K4g==
X-Gm-Message-State: AOJu0YzgzmbqiLUuU6QZZNdslC9mSi7ZF6AvTCOIKBtXcpb1+SDLyV9c
	FISIU8RGLn7n4L3PjfUQQyQUMc9/VwXp0B5YdZexIBfY2CVIAdcgPNfPMw==
X-Gm-Gg: ASbGncv3v7ULBp+HK4oLNF79RZ1aDHsqrHKEn5YMsxgKvQ8Fk1+sPXNouzslR14STCJ
	TtEP2+2FSZQTsoi+2DmeeQWKqpXMo6aH/Z8ePxCggUGSu9hTCOH5z/StoBPU6opGlfUeQ2xeYhq
	Tdcc9iemcFI88HDRA0C+hnwX8aHzWHSG2zYvynTvjAqmUOXW72QlKYlKOGZAVFREw2+UeBQguVD
	/Mc4BvXL/bo3N1UjWfjWsRUsvIX+jljEQB+7nSKRYjqRyWZjAkmelMkcA==
X-Google-Smtp-Source: AGHT+IFGTqP43M98iG39WbiRmkdgjArdm+IDBGhDA8gfbruZJIzUy80v0m0BIPckujOLEMYsoirr2A==
X-Received: by 2002:a05:600c:4fc5:b0:435:192:63ca with SMTP id 5b1f17b1804b1-436553f4d35mr4911725e9.21.1734482897097;
        Tue, 17 Dec 2024 16:48:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b119d7sm2807875e9.20.2024.12.17.16.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 16:48:16 -0800 (PST)
Message-Id: <pull.1390.v8.git.git.1734482895877.gitgitgadget@gmail.com>
In-Reply-To: <pull.1390.v7.git.git.1734481847156.gitgitgadget@gmail.com>
References: <pull.1390.v7.git.git.1734481847156.gitgitgadget@gmail.com>
From: "AreaZR via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Dec 2024 00:48:15 +0000
Subject: [PATCH v8] git: use calloc instead of malloc where possible
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: "Jeff Hostetler [ ]" <git@jeffhostetler.com>,
    "=?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason [ ]" <avarab@gmail.com>,
    "Bagas Sanjaya [ ]" <bagasdotme@gmail.com>,
    AreaZR <gfunni234@gmail.com>,
    Seija Kijin <doremylover123@gmail.com>

From: Seija Kijin <doremylover123@gmail.com>

We can avoid having to call memset by calling calloc.

Signed-off-by: Seija <doremylover123@gmail.com>
---
    git: use calloc instead of malloc where possible
    
    We can avoid having to call memset by calling calloc
    
    Signed-off-by: Seija doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1390%2FAreaZR%2Fcalloc-v8
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1390/AreaZR/calloc-v8
Pull-Request: https://github.com/git/git/pull/1390

Range-diff vs v7:

 1:  e91cea8dea8 ! 1:  b78f068b3a3 revision: use calloc instead of malloc where possible
     @@ Metadata
      Author: Seija Kijin <doremylover123@gmail.com>
      
       ## Commit message ##
     -    revision: use calloc instead of malloc where possible
     +    git: use calloc instead of malloc where possible
      
     -    We can avoid having to call memset by calling calloc
     +    We can avoid having to call memset by calling calloc.
      
          Signed-off-by: Seija <doremylover123@gmail.com>
      
     - ## builtin/pack-redundant.c ##
     -@@ builtin/pack-redundant.c: static inline struct llist_item *llist_item_get(void)
     - 	return new_item;
     - }
     - 
     --static inline void llist_init(struct llist **list)
     --{
     --	*list = xmalloc(sizeof(struct llist));
     --	(*list)->front = (*list)->back = NULL;
     --	(*list)->size = 0;
     --}
     --
     - static void llist_free(struct llist *list)
     - {
     - 	for (struct llist_item *i = list->front, *next; i; i = next) {
     -@@ builtin/pack-redundant.c: static struct llist * llist_copy(struct llist *list)
     - 	struct llist *ret;
     - 	struct llist_item *new_item, *old_item, *prev;
     - 
     --	llist_init(&ret);
     -+	CALLOC_ARRAY(ret, 1);
     - 
     - 	if ((ret->size = list->size) == 0)
     - 		return ret;
     -@@ builtin/pack-redundant.c: static void load_all_objects(void)
     - 	struct pack_list *pl = local_packs;
     - 	struct llist_item *hint, *l;
     - 
     --	llist_init(&all_objects);
     -+	CALLOC_ARRAY(all_objects, 1);
     - 
     - 	while (pl) {
     - 		hint = NULL;
     -@@ builtin/pack-redundant.c: static void cmp_local_packs(void)
     - 
     - 	/* only one packfile */
     - 	if (!pl->next) {
     --		llist_init(&pl->unique_objects);
     -+		CALLOC_ARRAY(pl->unique_objects, 1);
     - 		return;
     - 	}
     - 
     -@@ builtin/pack-redundant.c: static struct pack_list * add_pack(struct packed_git *p)
     - 		return NULL;
     - 
     - 	l.pack = p;
     --	llist_init(&l.remaining_objects);
     -+	CALLOC_ARRAY(l.remaining_objects, 1);
     - 
     - 	if (open_pack_index(p))
     - 		return NULL;
     -@@ builtin/pack-redundant.c: int cmd_pack_redundant(int argc, const char **argv, const char *prefix UNUSED, s
     - 		scan_alt_odb_packs();
     - 
     - 	/* ignore objects given on stdin */
     --	llist_init(&ignore);
     -+	CALLOC_ARRAY(ignore, 1);
     - 	if (!isatty(0)) {
     - 		struct object_id oid;
     - 		while (fgets(buf, sizeof(buf), stdin)) {
     -
       ## remote.c ##
      @@ remote.c: void apply_push_cas(struct push_cas_option *cas,
       


 remote.c    |  4 ++--
 submodule.c | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/remote.c b/remote.c
index 10104d11e3c..462ff105273 100644
--- a/remote.c
+++ b/remote.c
@@ -2854,9 +2854,9 @@ void apply_push_cas(struct push_cas_option *cas,
 
 struct remote_state *remote_state_new(void)
 {
-	struct remote_state *r = xmalloc(sizeof(*r));
+	struct remote_state *r;
 
-	memset(r, 0, sizeof(*r));
+	CALLOC_ARRAY(r, 1);
 
 	hashmap_init(&r->remotes_hash, remotes_hash_cmp, NULL, 0);
 	hashmap_init(&r->branches_hash, branches_hash_cmp, NULL, 0);
diff --git a/submodule.c b/submodule.c
index 7ec564854d0..7707c6f48f0 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1489,14 +1489,13 @@ struct fetch_task {
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
 
@@ -1536,8 +1535,9 @@ static struct fetch_task *fetch_task_create(struct submodule_parallel_fetch *spf
 					    const char *path,
 					    const struct object_id *treeish_name)
 {
-	struct fetch_task *task = xmalloc(sizeof(*task));
-	memset(task, 0, sizeof(*task));
+	struct fetch_task *task;
+
+	CALLOC_ARRAY(task, 1);
 
 	if (validate_submodule_path(path) < 0)
 		exit(128);

base-commit: 063bcebf0c917140ca0e705cbe0fdea127e90086
-- 
gitgitgadget
