Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E0C35F191
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 06:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781160302; cv=none; b=klD5Ut3dd91tIKRCH3EfYrVYdzs30ezxsV9s1LSVRp3QbrXTUfkSJmDE5XehO6XWi6uXxbJAOqmWfqT3vCdwUcDpRYWXESr3JK1x3soVQvGtxqv7amoD0a8rWURlehDy/CX8SxJGKol+0LC26pKMpL747OpwY9gBVGUMPyKUrpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781160302; c=relaxed/simple;
	bh=+NcLbjpAX6sbcrUMx9f3+EiBBrxZCumqsKR1aCV7c4k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YI1Pq5KPU2L7IgSdXzMz4HxZ0kvVtToKBrGCa8wiQaAuK0Ei/O60fnm8Ice6KTqbAw7GENuWOh5s8lGfcz72K3QgJbNMvS5Fva5CgXkaUxCVawmnDQR33O+xQAmS1hsPumsxt6N8zIa5pWPrTHY6bag8RhX7A55JUhS/F7FB6D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YtRW/jCq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RxBgzOUv; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YtRW/jCq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RxBgzOUv"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6DED07A00FD;
	Thu, 11 Jun 2026 02:45:00 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 11 Jun 2026 02:45:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781160300;
	 x=1781246700; bh=ZvLcK4bum8MoF1JbRRYQfwrTLOc2KDdxY5tYMZ1obto=; b=
	YtRW/jCqAIF8MZ3a/AcTpsBzMtR826EDUOzJb/Vj9ji/YyndHCEoMOUO0h7kJka/
	qfSjqXNEqzNVBECLHv8OE2tL8wlSBXAe1Mq+vlTV3EvHLbJ81yHyEqjqgdolbLrd
	1fd9xAHU7Qf7eXE+T7rU3fgK2F/MD3JjKJIvRzF/njkUyQfr5CpbKFAzqZULKtz1
	ZJ1svpQKocjeXFixA0SpNcUVZ3jKSrNTuUMV0yR5BuV7/Ivu0LHAtVRedpkJRcuz
	wFneIVHyn8GtfcRUOwmgVZ1kxbHfEgOn++muMFKOa6S5h9erKGd6eMTFSnlDV6ww
	Sv7q3+T5WaFl+au9RbdHBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781160300; x=
	1781246700; bh=ZvLcK4bum8MoF1JbRRYQfwrTLOc2KDdxY5tYMZ1obto=; b=R
	xBgzOUvOkgkQUkrthJ55FArTQzMuLjC6RI4D3pjYUBF/IPsQLyUjY0l8LDcPepyl
	sXoQ6Fwi7Lz7+pSSZNwpK/y05eSNnZ8Swss+RG+shL6pJU9v2zvkTMygeWwJVG0C
	cNIwJkVP5+knnMxM/U5gBezA+89E3DyP6ZhKO8PtRJdR38/v7s3jZ6I4ieF2MbYc
	26HFCFRUZJZWGB5enKyrrBri2v5LQ0PiprFbE9Q3axyCznc6FONwhZKwdUKOTMSM
	ceA1hzFQDMTTH304p4PNJGBTuWaqBm/T/A9phQC9g3sJHqQ2jVhw2hREw2VdF9CC
	fGklEx2eQA0Osd2FPVpqw==
X-ME-Sender: <xms:bFkqaks_kdkNAC36SNKkhfc-t1Bv2abfpTtJN5MfQQI7aym1fnX3HQ>
    <xme:bFkqanf0bF1IW75Wy35bKyxEc9f7i66PvR6apy4tc5eLPQAOlfBZk3EgZlMhStxVJ
    1vZQK-Od4QZgvkJt48I6muOExOjs1u4zZ0rlOqFULeMYWn5tno5>
X-ME-Received: <xmr:bFkqatb2A2-bhJ2YCudZ4tfjSJoFJobYl6FT6OCkJ9tF1yOdWwOPxy87sQdpGI2rR0KXi686YPZ2SlbQfISPiozOpVi89uOsEE5K-kj3hw1P>
X-ME-Proxy-Cause: dmFkZTEB1+/wXIrstN1RxODrElfIL2f6LfPbEmd7DasvHhTabWVEGshHALNDtuwzcnXqjh
    iraf9oWNhgGPKHjQwozX1BToJhNmgmvvOQHtdrVuBZwVEacpWW/0tse4gyN1PVUZ3/Ga8f
    DHvWSt7yPziOd0QmAAqq9ybs75EzVqKwaeefI6K+8Tc91jTDYtIJASGEjCYkWoJOFvJVt8
    2TaxETAWlGZRS7wjVo6BD4FPndrggwmbrqE2mPUUdgrZ0irVXcQRWkIgaebF6uLvVVEQQ4
    UXN0ilh/JhYaqsvdqhkL0r1foTdfEnXNjgm6ykQ08whFjNf2OTgqa8hKdbmxPZ15oOrebt
    fUY0YdE8BeItmJ0QX9+2uqMT4V3dDPysM4/zkNlE4Yq1MYh0cZi2rT0HOf5cSrernUBJFl
    bQgfotj3srshoI9FdlePbxi2iYHK2WVk3Qj8Cvr3b5N6x/vAoqDBdtruuL9n0Y2XN290WT
    jT/E2PZphlnhJtzuoFNt9LdCR42nhRkqtW4zfHIBp9cWulhWfwiJAgrCQMS+sxBry5jbiS
    dP+hGu3yk4+DPI3e74JVPl1wVXYIr31wyzZ5Cb5G0JI4Dkoz19f/aNNo4Ifx9eRz8Rakpn
    XtMcovf6n1k8PYBuvDl4w6lKCzDlARfqYt7TLNbQdmQsJWMBnCxCdYS6gO8Q
X-ME-Proxy: <xmx:bFkqaiWmlh3QQrebY4CCM6aeH4FFCKkKkQ9ulQwxHke_cIyPfymSfg>
    <xmx:bFkqanh5TByIIPDl0KqtXzM5P4yk8a3_EykSrpkzmLePoAvDgEvZDQ>
    <xmx:bFkqaoVz6WmVEq_L4eHgVENVvj93RD9hqeqbjp7Ja2wvL1sECNvqdA>
    <xmx:bFkqamNgYIYAnUhl13RKJsKwnoPOBoADd3iTlY-JgC0k4t2rUXoiWQ>
    <xmx:bFkqavf2VUtWcKaib8_07TQzkWm4v-UTRHI7fW4vMRUGLDUXEwEc3Axz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 02:44:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4db17d3d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Jun 2026 06:44:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 11 Jun 2026 08:44:44 +0200
Subject: [PATCH v2 6/7] environment: stop using `the_repository` in
 `is_bare_repository()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-b4-pks-setup-drop-global-state-v2-6-a6f7269c841d@pks.im>
References: <20260611-b4-pks-setup-drop-global-state-v2-0-a6f7269c841d@pks.im>
In-Reply-To: <20260611-b4-pks-setup-drop-global-state-v2-0-a6f7269c841d@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

Refactor `is_bare_repository()` to take in a repository parameter so
that we no longer depend on `the_repository`. Adjust callers
accordingly.

Furthermore, move the function outside of the declarations that are only
available when `USE_THE_REPOSITORY_VARIABLE` is set, as it no longer
depends on that variable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 attr.c                  | 4 ++--
 builtin/bisect.c        | 2 +-
 builtin/blame.c         | 2 +-
 builtin/check-attr.c    | 2 +-
 builtin/fetch.c         | 2 +-
 builtin/gc.c            | 2 +-
 builtin/history.c       | 2 +-
 builtin/repack.c        | 2 +-
 builtin/repo.c          | 2 +-
 builtin/reset.c         | 2 +-
 builtin/rev-parse.c     | 2 +-
 environment.c           | 4 ++--
 environment.h           | 4 ++--
 mailmap.c               | 4 ++--
 refs/files-backend.c    | 2 +-
 refs/reftable-backend.c | 2 +-
 setup.c                 | 2 +-
 transport.c             | 4 ++--
 worktree.c              | 2 +-
 19 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/attr.c b/attr.c
index 75369547b3..04cb284954 100644
--- a/attr.c
+++ b/attr.c
@@ -681,7 +681,7 @@ static enum git_attr_direction direction;
 
 void git_attr_set_direction(enum git_attr_direction new_direction)
 {
-	if (is_bare_repository() && new_direction != GIT_ATTR_INDEX)
+	if (is_bare_repository(the_repository) && new_direction != GIT_ATTR_INDEX)
 		BUG("non-INDEX attr direction in a bare repo");
 
 	if (new_direction != direction)
@@ -848,7 +848,7 @@ static struct attr_stack *read_attr(struct index_state *istate,
 		res = read_attr_from_index(istate, path, flags);
 	} else if (tree_oid) {
 		res = read_attr_from_blob(istate, tree_oid, path, flags);
-	} else if (!is_bare_repository()) {
+	} else if (!is_bare_repository(the_repository)) {
 		if (direction == GIT_ATTR_CHECKOUT) {
 			res = read_attr_from_index(istate, path, flags);
 			if (!res)
diff --git a/builtin/bisect.c b/builtin/bisect.c
index e7c2d2f3bb..798e28f501 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -724,7 +724,7 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
 	struct object_id oid;
 	const char *head;
 
-	if (is_bare_repository())
+	if (is_bare_repository(the_repository))
 		no_checkout = 1;
 
 	/*
diff --git a/builtin/blame.c b/builtin/blame.c
index ffbd3ce5c5..553f4cb780 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1163,7 +1163,7 @@ int cmd_blame(int argc,
 
 	revs.disable_stdin = 1;
 	setup_revisions(argc, argv, &revs, NULL);
-	if (!revs.pending.nr && is_bare_repository()) {
+	if (!revs.pending.nr && is_bare_repository(the_repository)) {
 		struct commit *head_commit;
 		struct object_id head_oid;
 
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 98f64d5b92..217d83ea7d 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -116,7 +116,7 @@ int cmd_check_attr(int argc,
 	struct object_id initialized_oid;
 	int cnt, i, doubledash, filei;
 
-	if (!is_bare_repository())
+	if (!is_bare_repository(the_repository))
 		setup_work_tree(the_repository);
 
 	repo_config(the_repository, git_default_config, NULL);
diff --git a/builtin/fetch.c b/builtin/fetch.c
index c1d7c672f4..44b8c70da1 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1764,7 +1764,7 @@ static int set_head(const struct ref *remote_refs, struct remote *remote)
 
 	if (!head_name)
 		goto cleanup;
-	baremirror = is_bare_repository() && remote->mirror;
+	baremirror = is_bare_repository(the_repository) && remote->mirror;
 	create_only = follow_remote_head == FOLLOW_REMOTE_ALWAYS ? 0 : !baremirror;
 	if (baremirror) {
 		strbuf_addstr(&b_head, "HEAD");
diff --git a/builtin/gc.c b/builtin/gc.c
index 84a66d3240..61da30de9f 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -902,7 +902,7 @@ int cmd_gc(int argc,
 		die(_("failed to parse gc.logExpiry value %s"), cfg.gc_log_expire);
 
 	if (cfg.pack_refs < 0)
-		cfg.pack_refs = !is_bare_repository();
+		cfg.pack_refs = !is_bare_repository(the_repository);
 
 	argc = parse_options(argc, argv, prefix, builtin_gc_options,
 			     builtin_gc_usage, 0);
diff --git a/builtin/history.c b/builtin/history.c
index 091465a59e..fd83de8265 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -525,7 +525,7 @@ static int cmd_history_fixup(int argc,
 	if (action == REF_ACTION_DEFAULT)
 		action = REF_ACTION_BRANCHES;
 
-	if (is_bare_repository()) {
+	if (is_bare_repository(repo)) {
 		ret = error(_("cannot run fixup in a bare repository"));
 		goto out;
 	}
diff --git a/builtin/repack.c b/builtin/repack.c
index 1524a9c13a..bbc6f51639 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -265,7 +265,7 @@ int cmd_repack(int argc,
 
 	if (write_bitmaps < 0) {
 		if (write_midx == REPACK_WRITE_MIDX_NONE &&
-		    (!(pack_everything & ALL_INTO_ONE) || !is_bare_repository()))
+		    (!(pack_everything & ALL_INTO_ONE) || !is_bare_repository(the_repository)))
 			write_bitmaps = 0;
 	}
 	if (po_args.pack_kept_objects < 0)
diff --git a/builtin/repo.c b/builtin/repo.c
index 71a5c1c29c..34e96514bc 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -58,7 +58,7 @@ struct repo_info_field {
 
 static int get_layout_bare(struct repository *repo UNUSED, struct strbuf *buf)
 {
-	strbuf_addstr(buf, is_bare_repository() ? "true" : "false");
+	strbuf_addstr(buf, is_bare_repository(the_repository) ? "true" : "false");
 	return 0;
 }
 
diff --git a/builtin/reset.c b/builtin/reset.c
index 3be6bd0121..78e69bd84b 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -470,7 +470,7 @@ int cmd_reset(int argc,
 	if (reset_type != SOFT && (reset_type != MIXED || repo_get_work_tree(the_repository)))
 		setup_work_tree(the_repository);
 
-	if (reset_type == MIXED && is_bare_repository())
+	if (reset_type == MIXED && is_bare_repository(the_repository))
 		die(_("%s reset is not allowed in a bare repository"),
 		    _(reset_type_names[reset_type]));
 
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index bb882678fe..090e5cfbb0 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -1084,7 +1084,7 @@ int cmd_rev_parse(int argc,
 				continue;
 			}
 			if (!strcmp(arg, "--is-bare-repository")) {
-				printf("%s\n", is_bare_repository() ? "true"
+				printf("%s\n", is_bare_repository(the_repository) ? "true"
 						: "false");
 				continue;
 			}
diff --git a/environment.c b/environment.c
index 9d7c908c55..bf20953415 100644
--- a/environment.c
+++ b/environment.c
@@ -132,10 +132,10 @@ const char *getenv_safe(struct strvec *argv, const char *name)
 	return argv->v[argv->nr - 1];
 }
 
-int is_bare_repository(void)
+int is_bare_repository(struct repository *repo)
 {
 	/* if core.bare is not 'false', let's see if there is a work tree */
-	return the_repository->bare_cfg && !repo_get_work_tree(the_repository);
+	return repo->bare_cfg && !repo_get_work_tree(repo);
 }
 
 int have_git_dir(void)
diff --git a/environment.h b/environment.h
index afb5bcf197..164a55df2c 100644
--- a/environment.h
+++ b/environment.h
@@ -125,6 +125,8 @@ int git_default_core_config(const char *var, const char *value,
 
 void repo_config_values_init(struct repo_config_values *cfg);
 
+int is_bare_repository(struct repository *repo);
+
 /*
  * TODO: All the below state either explicitly or implicitly relies on
  * `the_repository`. We should eventually get rid of these and make the
@@ -147,8 +149,6 @@ void repo_config_values_init(struct repo_config_values *cfg);
  */
 int have_git_dir(void);
 
-int is_bare_repository(void);
-
 /* Environment bits from configuration mechanism */
 extern int trust_executable_bit;
 extern int trust_ctime;
diff --git a/mailmap.c b/mailmap.c
index 3b2691781d..7d8590cdd6 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -219,10 +219,10 @@ int read_mailmap(struct repository *repo, struct string_list *map)
 	map->strdup_strings = 1;
 	map->cmp = namemap_cmp;
 
-	if (!mailmap_blob && is_bare_repository())
+	if (!mailmap_blob && is_bare_repository(the_repository))
 		mailmap_blob = xstrdup("HEAD:.mailmap");
 
-	if (!startup_info->have_repository || !is_bare_repository())
+	if (!startup_info->have_repository || !is_bare_repository(the_repository))
 		err |= read_mailmap_file(map, ".mailmap",
 					 startup_info->have_repository ?
 					 MAILMAP_NOFOLLOW : 0);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index a4c7858787..2b27091484 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1865,7 +1865,7 @@ static int log_ref_setup(struct files_ref_store *refs,
 	char *logfile;
 
 	if (log_refs_cfg == LOG_REFS_UNSET)
-		log_refs_cfg = is_bare_repository() ? LOG_REFS_NONE : LOG_REFS_NORMAL;
+		log_refs_cfg = is_bare_repository(the_repository) ? LOG_REFS_NONE : LOG_REFS_NORMAL;
 
 	files_reflog_path(refs, &logfile_sb, refname);
 	logfile = strbuf_detach(&logfile_sb, NULL);
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 4ae22922de..101ef29ac8 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -288,7 +288,7 @@ static int should_write_log(struct reftable_ref_store *refs, const char *refname
 {
 	enum log_refs_config log_refs_cfg = refs->log_all_ref_updates;
 	if (log_refs_cfg == LOG_REFS_UNSET)
-		log_refs_cfg = is_bare_repository() ? LOG_REFS_NONE : LOG_REFS_NORMAL;
+		log_refs_cfg = is_bare_repository(the_repository) ? LOG_REFS_NONE : LOG_REFS_NORMAL;
 
 	switch (log_refs_cfg) {
 	case LOG_REFS_NONE:
diff --git a/setup.c b/setup.c
index 32f14a8688..e6db80ab07 100644
--- a/setup.c
+++ b/setup.c
@@ -2610,7 +2610,7 @@ static int create_default_files(struct repository *repo,
 	}
 	repo_config_set(repo, "core.filemode", filemode ? "true" : "false");
 
-	if (is_bare_repository())
+	if (is_bare_repository(the_repository))
 		repo_config_set(repo, "core.bare", "true");
 	else {
 		repo_config_set(repo, "core.bare", "false");
diff --git a/transport.c b/transport.c
index 0f5ec30247..fc144f0aed 100644
--- a/transport.c
+++ b/transport.c
@@ -1482,7 +1482,7 @@ int transport_push(struct repository *r,
 
 	if ((flags & (TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND |
 		      TRANSPORT_RECURSE_SUBMODULES_ONLY)) &&
-	    !is_bare_repository()) {
+	    !is_bare_repository(the_repository)) {
 		struct ref *ref = remote_refs;
 		struct oid_array commits = OID_ARRAY_INIT;
 
@@ -1509,7 +1509,7 @@ int transport_push(struct repository *r,
 	if (((flags & TRANSPORT_RECURSE_SUBMODULES_CHECK) ||
 	     ((flags & (TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND |
 			TRANSPORT_RECURSE_SUBMODULES_ONLY)) &&
-	      !pretend)) && !is_bare_repository()) {
+	      !pretend)) && !is_bare_repository(the_repository)) {
 		struct ref *ref = remote_refs;
 		struct string_list needs_pushing = STRING_LIST_INIT_DUP;
 		struct oid_array commits = OID_ARRAY_INIT;
diff --git a/worktree.c b/worktree.c
index 7d70f2c1da..30125827fd 100644
--- a/worktree.c
+++ b/worktree.c
@@ -124,7 +124,7 @@ static struct worktree *get_main_worktree(int skip_reading_head)
 	worktree->path = strbuf_detach(&worktree_path, NULL);
 	worktree->is_current = is_current_worktree(worktree);
 	worktree->is_bare = (the_repository->bare_cfg == 1) ||
-		is_bare_repository() ||
+		is_bare_repository(the_repository) ||
 		/*
 		 * When in a secondary worktree we have to also verify if the main
 		 * worktree is bare in $commondir/config.worktree.

-- 
2.54.0.1189.g8c84645362.dirty

