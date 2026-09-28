Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E646495AD1
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 09:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790589124; cv=none; b=s6JX30VUlKqDIXwP980oatN71KeYgpd7noG3m0e+wXEXcJQHvLMR2ArBs1900JfA3AmibmWejQGRHJoTHjlnyaxItnWq59Hw5THbvktAgO6usxYwYgovUu3pfzCqvehgPYbnWue8Q0QC/gpwt760qMZ5u4SciDeMwDx0xpuFuw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790589124; c=relaxed/simple;
	bh=LpcX86Ub79QvhdEIZXlC03aQZafJGzjj0VESt5iRCSY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JHpJqG04TD3eYrFr4a8I/gy12i9FsHbHOxSyLBxwV/SkRIGKNuiJczNsvhHG5Bm1sErQ1kL9JbCYpi969wt3F0/SMIARTfUIWICk+InR9YdPnPUfukuvKYdtis9OyVrn11n6WS7IeLaErcNG9Or52iao3nqKyCMhA7+2qLYlMZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Xk2t0IkW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uf7Xftr3; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Xk2t0IkW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uf7Xftr3"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 85441140002F;
	Mon, 28 Sep 2026 05:52:02 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 28 Sep 2026 05:52:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790589122;
	 x=1790675522; bh=R4hARm/e5EE8JtVwgLG/1mp8jLVUTPP1BQdd2UA+DpQ=; b=
	Xk2t0IkWVQT+WucxmprCH5LBXlAyUf2PgdzeSQyWOuiwLKTna8Gxl77aw0pkJIGT
	u6b5sOGPqSqAUJD8o/Np6TaRcPlU1xVwTYRx8W2U8w6GDZRt9Php937C2oLvZ41k
	pEaomNxUrf7O/sIwHhk7nFtXig/RKojNTTKX179iHUm4FruxYF24jUJO0Z59Ejpw
	zJnoD8TA89L96zwmOfiW8escv5L+2X227wvV5OIS1V00BTjMxYv4UIdG5FcroVJH
	ZTJZKdQwvGPIaltBgEtrbPz4cvbciWHdl1r5nxjGWDj+JxK+K5A2a8QkY/jdV1ON
	K0i1nRkJGOquKXkutr7tWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790589122; x=
	1790675522; bh=R4hARm/e5EE8JtVwgLG/1mp8jLVUTPP1BQdd2UA+DpQ=; b=u
	f7Xftr3JgOQUW1JFj08IXG9dSbHinU+W0hSeNjkMMUZIhLZ9lj5rX2Ws9XrBbj0W
	utBE2BcTydzCLTcnefkLWKBwpKbgQMxXMobAck2Y7qb7firCaCcEA+2zy98R8pwa
	8U7Ofw+2lppfQImBxh+5LO6FqAGgYaSIbPyaNXCK23giwh9XxarAZPycreUj5OJO
	CZXxO4SghuaSCB0ulxmqo2ngxNtJ/exURMYA0giYdAAyXB4Vv6QQeeecVsUPrJiG
	5OqGUHPa5STa7AwM3nXfE9Djy8x4Lhv/lLOyQMMyslIMU+e/jsZt29Hb1b4URrbq
	JUAQjTMnCneiU0+bIut4Q==
X-ME-Sender: <xms:wji6ai69XBdgKarrp6VWbxzh7C8-a0OC868uER994DR5d_ftbBIOLA>
    <xme:wji6ajXYrUC9Q3TAAhMJbrHHcdiX97afqa1HpLEZ1eJYa43qKcujjN23law6ykTLN
    RI5vy9EU_hxDX5ugEiZO4vt-SdssJaHeuvJ0CxobaMwsfnBGhKYmao>
X-ME-Received: <xmr:wji6au20njU5PMWfQzU2X1LgSSS8NmQn4VuTlSa7M_2EcUypsV_6FQ>
X-ME-Proxy-Cause: dmFkZTFf3wbZ+K2hbzfSgpgETsMz+NBy3J6MpFvFZYdyyTeL1iI2BFDj1IOSxm4OYKC0H3
    1Aperekeoh01XU/Affr9YDGewK0XTpFuAvdOqXRnkn1hAQOMt6Cmug4wAR/cLjxT0+YYyY
    V0ix31kC1wU9qb1Fc8l0wzUB6/ndZQ/KZS4bdHqUX1yu2WFUdfLdGcye3K8VFjVWdme6dj
    VB+FbRki+xZ7UJmHTn7m2FhlNqt4gn7r8JRqnyPx9S2V0Cn7eSTMCsJkqZ9Q8z0sAb/7of
    tUBRJGNrdn5okkLUJRR2FTKTF+T7dMnEgQWAA9cfkQE6WEt+aDQyOttxx4ijBJAJTShyWf
    ibrLC/i7vqa8Kq+kwfRKFK6vEQa/okMiSEeMHo4TAux9Qlg7dgqj2XCJxMT56tfJwJHvX2
    H6AHiSK4dnC8sqbbBG3drGPWUA4yKMcPudgK64DCBLtlu3gQnIRlf1MnS77MSbgCJr8hqM
    xWuTtcH6gXXCABL/MtjilaXlzfAxu+0K6/k/6vIXeB/IAxtNE7ix8CKk4q6juBW6MTHNUh
    F5TPgoF+eMT78DFvnM0BjikQNVuh9XMxOGj+rt5CXphYDF/a7SrgiTNmk2TWt0PfS6rG0b
    V7WLTiZZVxGGcrYwBsIZeaMJiCZSnxH97jV0u1/7NIJ/7eMN8AJ906jcCrLA
X-ME-Proxy: <xmx:wji6ao16ZqRKrI53V6mxnprFIK1lTXYyVgsmTS6fKOgZuulvk8f3Vg>
    <xmx:wji6ap9XGry2ZCO7Di2zWN_faFLqBW6P2gtAb2ncDysh77OfJyy8iw>
    <xmx:wji6at2pFXUMVqYrpkMb_KZRboEd8KOpC30AFZUeN4MGhC5gZJVBeg>
    <xmx:wji6au_qZPxdAk1A68R7aGn-OnBLqJhCxUZMHAyopDjrQYA1_XMpyA>
    <xmx:wji6asxrFRFMTNJC0c5Be7emWixCI3UTufJied06_4fYRMcwCSsOj8gH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 05:52:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6111fcbd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 28 Sep 2026 09:52:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 28 Sep 2026 11:51:07 +0200
Subject: [PATCH v2 6/7] repository: adapt `repo_clear()` to fully reset the
 repository
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-pks-create-repository-stateless-v2-6-a03612f703fa@pks.im>
References: <20260928-pks-create-repository-stateless-v2-0-a03612f703fa@pks.im>
In-Reply-To: <20260928-pks-create-repository-stateless-v2-0-a03612f703fa@pks.im>
To: git@vger.kernel.org
Cc: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

The function `repo_clear()` can be used to clear a repository's state.
The way it's written though it's quite easy for it to accidentally leak
some state because we don't make sure to clear the whole structure.

Refactor the function to set the whole repository to all-zeroes to avoid
any kind of leaking state. Replace calls of `FREE_AND_NULL()` to instead
use free(3p) to avoid zeroing out the data twice.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 repository.c | 37 ++++++++++++++++++-------------------
 repository.h |  2 +-
 2 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/repository.c b/repository.c
index b857e1c580..e67ff00550 100644
--- a/repository.c
+++ b/repository.c
@@ -374,60 +374,57 @@ void repo_clear(struct repository *repo)
 	struct hashmap_iter iter;
 	struct strmap_entry *e;
 
-	FREE_AND_NULL(repo->gitdir);
-	FREE_AND_NULL(repo->commondir);
-	FREE_AND_NULL(repo->prefix);
-	FREE_AND_NULL(repo->graft_file);
-	FREE_AND_NULL(repo->index_file);
-	FREE_AND_NULL(repo->worktree);
-	FREE_AND_NULL(repo->submodule_prefix);
-	FREE_AND_NULL(repo->ref_storage_payload);
+	free(repo->gitdir);
+	free(repo->commondir);
+	free(repo->prefix);
+	free(repo->graft_file);
+	free(repo->index_file);
+	free(repo->worktree);
+	free(repo->submodule_prefix);
+	free(repo->ref_storage_payload);
 
 	odb_free(repo->objects);
-	repo->objects = NULL;
 
 	if (repo->parsed_objects)
 		parsed_object_pool_clear(repo->parsed_objects);
-	FREE_AND_NULL(repo->parsed_objects);
+	free(repo->parsed_objects);
 
 	repo_settings_clear(repo);
 	repo_config_values_clear(&repo->config_values_private_);
 
 	if (repo->config) {
 		git_configset_clear(repo->config);
-		FREE_AND_NULL(repo->config);
+		free(repo->config);
 	}
 
-	if (repo->submodule_cache) {
+	if (repo->submodule_cache)
 		submodule_cache_free(repo->submodule_cache);
-		repo->submodule_cache = NULL;
-	}
 
 	if (repo->index) {
 		discard_index(repo->index);
-		FREE_AND_NULL(repo->index);
+		free(repo->index);
 	}
 
 	if (repo->hook_config_cache) {
 		hook_cache_clear(repo->hook_config_cache);
-		FREE_AND_NULL(repo->hook_config_cache);
+		free(repo->hook_config_cache);
 	}
 	strmap_clear(&repo->event_jobs, 0); /* values are uintptr_t, not heap ptrs */
 	string_list_clear(&repo->disabled_events, 0);
 
 	if (repo->promisor_remote_config) {
 		promisor_remote_clear(repo->promisor_remote_config);
-		FREE_AND_NULL(repo->promisor_remote_config);
+		free(repo->promisor_remote_config);
 	}
 
 	if (repo->remote_state) {
 		remote_state_clear(repo->remote_state);
-		FREE_AND_NULL(repo->remote_state);
+		free(repo->remote_state);
 	}
 
 	if (repo->refs_private) {
 		ref_store_release(repo->refs_private);
-		FREE_AND_NULL(repo->refs_private);
+		free(repo->refs_private);
 	}
 
 	strmap_for_each_entry(&repo->submodule_ref_stores, &iter, e)
@@ -439,6 +436,8 @@ void repo_clear(struct repository *repo)
 	strmap_clear(&repo->worktree_ref_stores, 1);
 
 	repo_clear_path_cache(&repo->cached_paths);
+
+	memset(repo, 0, sizeof(*repo));
 }
 
 int repo_read_index(struct repository *repo)
diff --git a/repository.h b/repository.h
index 11f5c2ed10..2a348012e8 100644
--- a/repository.h
+++ b/repository.h
@@ -258,6 +258,7 @@ void repo_set_ref_storage_format(struct repository *repo,
 void initialize_repository(struct repository *repo);
 RESULT_MUST_BE_USED
 int repo_init(struct repository *r, const char *gitdir, const char *worktree);
+void repo_clear(struct repository *repo);
 
 /*
  * Initialize the repository 'subrepo' as the submodule at the given path. If
@@ -273,7 +274,6 @@ int repo_submodule_init(struct repository *subrepo,
 			struct repository *superproject,
 			const char *path,
 			const struct object_id *treeish_name);
-void repo_clear(struct repository *repo);
 
 /*
  * Populates the repository's index from its index_file, an index struct will

-- 
2.56.0.rc2.329.gd58861e689.dirty

