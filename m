Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E59476CE9
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 13:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356110; cv=none; b=S/JUJunTg/QugGvaziAabHSGeLB/FMHER3/LbMbDu2QhK4B7a6r3zC56mGc9scgWLKBfqe5Rd2Q945oJrCWyYSx4UBZYF0RbVT6hcLAN2ccISesQ9e0Ldp911/oeBEK8mZDMbBXLmiF7Q+81Su8ZXId+LqItj6tI3Z26GumMPCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356110; c=relaxed/simple;
	bh=IjknhUKwRZZSBpl60o7S7xOWow9+upNUhToeqthxGGY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qqFRcMdDYfeWoImQOABJoDtvgDZL6NByCoSmecUyiC0zAu1sfJFOR0OrBTB60ivSe9j/1dfhVnO5srRZBpjukURNer0wNefolp/Q9A/fgfYdvxZLZhGRTVLtiImrYuu7dBBW5C8tqqSu0Hgmz7B8f+VmcQkS/kOERYLgiaVN9m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WSBCopxA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=clasD5JJ; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WSBCopxA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="clasD5JJ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 860507A0125;
	Wed,  2 Sep 2026 09:35:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 02 Sep 2026 09:35:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788356107;
	 x=1788442507; bh=8H/5iuW99MN7RDRElWk0HsTClBP7eMapnlh4N1mnT/A=; b=
	WSBCopxAXTQZkkyWaYDKWBUU42dELn+JcBKEPp1wbYdKJ9HPdiauesO1wBAxKJjY
	AO2ovP5gYEvGYdq0Z7ezdeeITiia5J2qHX5YIMhLyWbnlCOJ8InQ/AWDwUblDjNp
	EtezFSldv6ZptcJuDO4DLVN1iOxBLaotrWzL9asf5S1fqVaRaSDFjBEwj/BrHxvb
	J+WEMhKAvZDxo2HLx/POO+vBegCmMmX6rC/tgF2Fam9kAnDlYAcuZbn02hS21q8s
	oVzI9bk1yiLQhLYp9G03rQUdFl8WBG10ExSzIJizjOFe5wahnsopDDSmABsD/Ncy
	OMKxxVg3ISTHWGQR7r6LyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788356107; x=
	1788442507; bh=8H/5iuW99MN7RDRElWk0HsTClBP7eMapnlh4N1mnT/A=; b=c
	lasD5JJdHYuMGqthFcOrKhNicruvtvlsxDQKP1kvASkAMutftnqWwrp4BguEldrn
	VQP1SqEkvFTjarh6u+Fe2OYxOv0Ks14yE7w0SxhhkMg360qzKP0oyxj5zURLUkx1
	wSBIX7SYTZoNfSvTkzUDb1Pxk0MVXXNAuEF4CV7SKwxWb8Z1dVlds5jaf+DdWn4K
	6biPe9WyT93tBEOa/WIsRFlf8r1tr0Yg4TffIyd97AEuGXri/AYcPw7Wi+5TPTTB
	ZbF+KoxVCLxdrImTwhg2BSTcutzrQN3klmq6QILLUJa7HZCkdMF/1yqHxkcaj9Z/
	W4dSMwBQtM75WVvfGrntg==
X-ME-Sender: <xms:CyaYahf8RKTB-rr5WRHiZH_P6VJTh9oBlZ4kPZ0VCkpZcFyy29xSTQ>
    <xme:CyaYalOfoxvhErwqlR-LFIEAgR8MZ8n-1RwcgeFaJ58LeMM3NhMh8L7D4TFkd_lHt
    vnkM6YhEAC_m5jgDr0PoTK0U_IIfsO4LUzLPab3i-_kmohDi6px>
X-ME-Received: <xmr:CyaYaoJenNT4c2clVpsnu8ESV31zgUR0e_JlcbBme03j7m9S9LyAEomsRepUgDiIZSofyrI>
X-ME-Proxy-Cause: dmFkZTGGCQDjAoUdmsWxJ1+r0A+U+aOyZ2jbIfcC4gcaiysIaAut4yVA5e/qBfPrHtHW/+
    8SPCEgIRImAOq6VTW9jybjxGeKNu6r04HelwhSrJZ4QB1q15s9pd0gbWS4IZY7t5lqvyTN
    mJ9slVoyZoxY3s9BZ0bxRpSs/P0xDs4frrO24RfKd203T8FZVXmwm23YG1KisWjdzPoOMn
    hfmraGgfFNlS+TSr9yqLLDCd3HzjHaVfRlN1/vf0n5hlsnpiqxa4awwBn8LYRqRxp/y/U9
    Z/NWGC2vrBZWCXyz6j4LDMfbu75qm65vPAJYiUpzvV+5wBBTpOsniC0UHvX2iiv637JfT7
    NFmZ87gvhNnEdt2fJddE20Gnqu4dCMKyoKxPDKPtHE5WfOV+L5c8ef1NScR360/TvpiQ08
    dnNFwGIWyskU7ZhyBZh7GfMpj6HPy6O4zbwV8mqggDJnz8VouL012Qz7sB5foaJAj3ecEh
    CMvgSyqR+gPkkXFY6kg+JvJwCCrSD4w1xx+wXpXrBiq88HBLmFJVImGIgU6xpBGHi3APhl
    hXqs6BOJh3DsW9Gb45FOuxntdlgMBxXDLth4xp+X9g1+yvqYdT2fDN2+x3B17MmmxiJhnK
    eLT72Spdf/agFDO/TYVXZHIQcZj5HdSn7RbZcXMBRYzKb27ntWtA3QihqccQ
X-ME-Proxy: <xmx:CyaYamFSLwcnq61jGVbdYLrrXcS1V5AyHf-iOYE4HZuRN-YlQxpF1A>
    <xmx:CyaYagS3W4wECYmDGDoNh4Ycdc9pXxG1RVFeTxlHydNNX4imOCSCDw>
    <xmx:CyaYaiFwwva78HFuc6FcOcU5IkB2LvIMK9J4y_XDeb4pNMrsarfaDw>
    <xmx:CyaYas8WiJneXhzAnyd32iJNLYw_krdwXniZazXUWnkQtXA2CwfWwA>
    <xmx:CyaYas3hFFhq5dNV2JC8CQgd7DNqwhRLG9IgAwwnjP9HFz20XShC0oRm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 09:35:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 546b9783 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Sep 2026 13:35:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 02 Sep 2026 15:34:51 +0200
Subject: [PATCH v2 03/13] submodule-config: remove uses of `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-pks-odb-registering-in-memory-sources-v2-3-c6ca12fdea4d@pks.im>
References: <20260902-pks-odb-registering-in-memory-sources-v2-0-c6ca12fdea4d@pks.im>
In-Reply-To: <20260902-pks-odb-registering-in-memory-sources-v2-0-c6ca12fdea4d@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

Several functions in the submodule-config subsystem implicitly depend
on `the_repository`. Refactor these to take a `struct repository` as
parameter and adapt callers accordingly.

Note that as usual with these refactorings, callers simply pass
`the_repository` even if they already have a different repository
available in the calling context. This simplifies the migration and
ensures that we don't have a change in behaviour.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c             |  2 +-
 builtin/grep.c              |  2 +-
 builtin/submodule--helper.c |  8 ++++----
 submodule-config.c          | 49 ++++++++++++++++++++++++++-------------------
 submodule-config.h          | 12 +++++++----
 submodule.c                 |  2 +-
 t/helper/test-submodule.c   |  4 ++--
 7 files changed, 45 insertions(+), 34 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index ab7db2be06..533fdfe7d8 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2681,7 +2681,7 @@ int cmd_fetch(int argc,
 		int *rs = config.recurse_submodules == RECURSE_SUBMODULES_DEFAULT
 			  ? &config.recurse_submodules : NULL;
 
-		fetch_config_from_gitmodules(sfjc, rs);
+		fetch_config_from_gitmodules(the_repository, sfjc, rs);
 	}
 
 
diff --git a/builtin/grep.c b/builtin/grep.c
index d3d86abe01..073dfaaf45 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -897,7 +897,7 @@ static int grep_objects(struct grep_opt *opt, const struct pathspec *pathspec,
 		if (recurse_submodules) {
 			submodule_free(opt->repo);
 			obj_read_lock();
-			gitmodules_config_oid(&real_obj->oid);
+			gitmodules_config_oid(the_repository, &real_obj->oid);
 			obj_read_unlock();
 		}
 		if (grep_object(opt, pathspec, real_obj, list->objects[i].name,
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index e7cd3225fa..aaaa963fd8 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3041,7 +3041,7 @@ static int module_update(int argc, const char **argv, const char *prefix,
 		NULL
 	};
 
-	update_clone_config_from_gitmodules(&opt.max_jobs);
+	update_clone_config_from_gitmodules(the_repository, &opt.max_jobs);
 	repo_config(the_repository, git_update_clone_config, &opt.max_jobs);
 
 	argc = parse_options(argc, argv, prefix, module_update_options,
@@ -3255,7 +3255,7 @@ static int module_set_url(int argc, const char **argv, const char *prefix,
 		    path);
 
 	config_name = xstrfmt("submodule.%s.url", sub->name);
-	ret = config_set_in_gitmodules_file_gently(config_name, newurl);
+	ret = config_set_in_gitmodules_file_gently(the_repository, config_name, newurl);
 
 	if (!ret) {
 		repo_read_gitmodules(the_repository, 0);
@@ -3311,7 +3311,7 @@ static int module_set_branch(int argc, const char **argv, const char *prefix,
 		    path);
 
 	config_name = xstrfmt("submodule.%s.branch", sub->name);
-	ret = config_set_in_gitmodules_file_gently(config_name, opt_branch);
+	ret = config_set_in_gitmodules_file_gently(the_repository, config_name, opt_branch);
 
 	free(config_name);
 	return !!ret;
@@ -3510,7 +3510,7 @@ static int config_submodule_in_gitmodules(const char *name, const char *var, con
 		die(_("please make sure that the .gitmodules file is in the working tree"));
 
 	key = xstrfmt("submodule.%s.%s", name, var);
-	ret = config_set_in_gitmodules_file_gently(key, value);
+	ret = config_set_in_gitmodules_file_gently(the_repository, key, value);
 	free(key);
 
 	return ret;
diff --git a/submodule-config.c b/submodule-config.c
index f75997402a..f8c2cf7a93 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -667,19 +667,20 @@ static int parse_config(const char *var, const char *value,
 	return ret;
 }
 
-static int gitmodule_oid_from_commit(const struct object_id *treeish_name,
+static int gitmodule_oid_from_commit(struct repository *repo,
+				     const struct object_id *treeish_name,
 				     struct object_id *gitmodules_oid,
 				     struct strbuf *rev)
 {
 	int ret = 0;
 
 	if (is_null_oid(treeish_name)) {
-		oidclr(gitmodules_oid, the_repository->hash_algo);
+		oidclr(gitmodules_oid, repo->hash_algo);
 		return 1;
 	}
 
 	strbuf_addf(rev, "%s:.gitmodules", oid_to_hex(treeish_name));
-	if (repo_get_oid(the_repository, rev->buf, gitmodules_oid) >= 0)
+	if (repo_get_oid(repo, rev->buf, gitmodules_oid) >= 0)
 		ret = 1;
 
 	return ret;
@@ -689,9 +690,11 @@ static int gitmodule_oid_from_commit(const struct object_id *treeish_name,
  * (key) with on-demand reading of the appropriate .gitmodules from
  * revisions.
  */
-static const struct submodule *config_from(struct submodule_cache *cache,
-		const struct object_id *treeish_name, const char *key,
-		enum lookup_type lookup_type)
+static const struct submodule *config_from(struct repository *repo,
+					   struct submodule_cache *cache,
+					   const struct object_id *treeish_name,
+					   const char *key,
+					   enum lookup_type lookup_type)
 {
 	struct strbuf rev = STRBUF_INIT;
 	size_t config_size;
@@ -718,7 +721,7 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 		return entry->config;
 	}
 
-	if (!gitmodule_oid_from_commit(treeish_name, &oid, &rev))
+	if (!gitmodule_oid_from_commit(repo, treeish_name, &oid, &rev))
 		goto out;
 
 	switch (lookup_type) {
@@ -732,7 +735,7 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 	if (submodule)
 		goto out;
 
-	config = odb_read_object(the_repository->objects, &oid,
+	config = odb_read_object(repo->objects, &oid,
 				 &type, &config_size);
 	if (!config || type != OBJ_BLOB)
 		goto out;
@@ -843,21 +846,22 @@ void repo_read_gitmodules(struct repository *repo, int skip_if_read)
 	repo->submodule_cache->gitmodules_read = 1;
 }
 
-void gitmodules_config_oid(const struct object_id *commit_oid)
+void gitmodules_config_oid(struct repository *repo,
+			   const struct object_id *commit_oid)
 {
 	struct strbuf rev = STRBUF_INIT;
 	struct object_id oid;
 
-	submodule_cache_check_init(the_repository);
+	submodule_cache_check_init(repo);
 
-	if (gitmodule_oid_from_commit(commit_oid, &oid, &rev)) {
+	if (gitmodule_oid_from_commit(repo, commit_oid, &oid, &rev)) {
 		git_config_from_blob_oid(gitmodules_cb, rev.buf,
-					 the_repository, &oid, the_repository,
+					 repo, &oid, repo,
 					 CONFIG_SCOPE_UNKNOWN);
 	}
 	strbuf_release(&rev);
 
-	the_repository->submodule_cache->gitmodules_read = 1;
+	repo->submodule_cache->gitmodules_read = 1;
 }
 
 const struct submodule *submodule_from_name(struct repository *r,
@@ -865,7 +869,7 @@ const struct submodule *submodule_from_name(struct repository *r,
 		const char *name)
 {
 	repo_read_gitmodules(r, 1);
-	return config_from(r->submodule_cache, treeish_name, name, lookup_name);
+	return config_from(r, r->submodule_cache, treeish_name, name, lookup_name);
 }
 
 const struct submodule *submodule_from_path(struct repository *r,
@@ -873,7 +877,7 @@ const struct submodule *submodule_from_path(struct repository *r,
 		const char *path)
 {
 	repo_read_gitmodules(r, 1);
-	return config_from(r->submodule_cache, treeish_name, path, lookup_path);
+	return config_from(r, r->submodule_cache, treeish_name, path, lookup_path);
 }
 
 /**
@@ -980,11 +984,12 @@ int print_config_from_gitmodules(struct repository *repo, const char *key)
 	return 0;
 }
 
-int config_set_in_gitmodules_file_gently(const char *key, const char *value)
+int config_set_in_gitmodules_file_gently(struct repository *repo,
+					 const char *key, const char *value)
 {
 	int ret;
 
-	ret = repo_config_set_in_file_gently(the_repository, GITMODULES_FILE, key, NULL, value);
+	ret = repo_config_set_in_file_gently(repo, GITMODULES_FILE, key, NULL, value);
 	if (ret < 0)
 		/* Maybe the user already did that, don't error out here */
 		warning(_("Could not update .gitmodules entry %s"), key);
@@ -1017,13 +1022,15 @@ static int gitmodules_fetch_config(const char *var, const char *value,
 	return 0;
 }
 
-void fetch_config_from_gitmodules(int *max_children, int *recurse_submodules)
+void fetch_config_from_gitmodules(struct repository *repo,
+				  int *max_children,
+				  int *recurse_submodules)
 {
 	struct fetch_config config = {
 		.max_children = max_children,
 		.recurse_submodules = recurse_submodules
 	};
-	config_from_gitmodules(gitmodules_fetch_config, the_repository, &config);
+	config_from_gitmodules(gitmodules_fetch_config, repo, &config);
 }
 
 static int gitmodules_update_clone_config(const char *var, const char *value,
@@ -1036,7 +1043,7 @@ static int gitmodules_update_clone_config(const char *var, const char *value,
 	return 0;
 }
 
-void update_clone_config_from_gitmodules(int *max_jobs)
+void update_clone_config_from_gitmodules(struct repository *repo, int *max_jobs)
 {
-	config_from_gitmodules(gitmodules_update_clone_config, the_repository, max_jobs);
+	config_from_gitmodules(gitmodules_update_clone_config, repo, max_jobs);
 }
diff --git a/submodule-config.h b/submodule-config.h
index f55d4e3b61..755570d5d1 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -57,7 +57,8 @@ int option_fetch_parse_recurse_submodules(const struct option *opt,
 int parse_update_recurse_submodules_arg(const char *opt, const char *arg);
 int parse_push_recurse_submodules_arg(const char *opt, const char *arg);
 void repo_read_gitmodules(struct repository *repo, int skip_if_read);
-void gitmodules_config_oid(const struct object_id *commit_oid);
+void gitmodules_config_oid(struct repository *repo,
+			   const struct object_id *commit_oid);
 
 /**
  * Same as submodule_from_path but lookup by name.
@@ -80,7 +81,8 @@ const struct submodule *submodule_from_path(struct repository *r,
 void submodule_free(struct repository *r);
 
 int print_config_from_gitmodules(struct repository *repo, const char *key);
-int config_set_in_gitmodules_file_gently(const char *key, const char *value);
+int config_set_in_gitmodules_file_gently(struct repository *repo,
+					 const char *key, const char *value);
 
 /*
  * Returns 0 if the name is syntactically acceptable as a submodule "name"
@@ -100,8 +102,10 @@ int check_submodule_url(const char *url);
  * New helpers to retrieve arbitrary configuration from the '.gitmodules' file
  * should NOT be added.
  */
-void fetch_config_from_gitmodules(int *max_children, int *recurse_submodules);
-void update_clone_config_from_gitmodules(int *max_jobs);
+void fetch_config_from_gitmodules(struct repository *repo,
+				  int *max_children,
+				  int *recurse_submodules);
+void update_clone_config_from_gitmodules(struct repository *repo, int *max_jobs);
 
 /*
  * Submodule entry that contains relevant information about a
diff --git a/submodule.c b/submodule.c
index 5c92575888..6fcb606f7e 100644
--- a/submodule.c
+++ b/submodule.c
@@ -133,7 +133,7 @@ int update_path_in_gitmodules(const char *oldpath, const char *newpath)
 	strbuf_addstr(&entry, "submodule.");
 	strbuf_addstr(&entry, submodule->name);
 	strbuf_addstr(&entry, ".path");
-	ret = config_set_in_gitmodules_file_gently(entry.buf, newpath);
+	ret = config_set_in_gitmodules_file_gently(the_repository, entry.buf, newpath);
 	strbuf_release(&entry);
 	return ret;
 }
diff --git a/t/helper/test-submodule.c b/t/helper/test-submodule.c
index 3c5c4c4a09..ea9bef0904 100644
--- a/t/helper/test-submodule.c
+++ b/t/helper/test-submodule.c
@@ -168,7 +168,7 @@ static int cmd__submodule_config_set(int argc, const char **argv)
 		if (!is_writing_gitmodules_ok())
 			die("please make sure that the .gitmodules file is in the working tree");
 
-		return config_set_in_gitmodules_file_gently(argv[1], argv[2]);
+		return config_set_in_gitmodules_file_gently(the_repository, argv[1], argv[2]);
 	}
 	usage_with_options(usage, options);
 }
@@ -188,7 +188,7 @@ static int cmd__submodule_config_unset(int argc, const char **argv)
 	if (argc == 2) {
 		if (!is_writing_gitmodules_ok())
 			die("please make sure that the .gitmodules file is in the working tree");
-		return config_set_in_gitmodules_file_gently(argv[1], NULL);
+		return config_set_in_gitmodules_file_gently(the_repository, argv[1], NULL);
 	}
 	usage_with_options(usage, options);
 }

-- 
2.55.0.979.g7e5102b832.dirty

