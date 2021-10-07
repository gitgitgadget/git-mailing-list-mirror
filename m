Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6A8C433FE
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 19:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DF2160F23
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 19:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243866AbhJGTJQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 15:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233876AbhJGTJN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 15:09:13 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920FEC061755
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 12:07:19 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id o20so22118722wro.3
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 12:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=T7QRi1bZZENDwnxa8hpYfZqSy7+lH4jOe6FRHUraHGc=;
        b=h/0yrZLpYGTQz6DQkFcp/ifN/0pQHfQJaEkdlcCVUiFFKvo+V7PEIaAweWEE17FTl4
         ra0eQAW+i0HKvDYoW3f+X+AtFgtGwqlrcL14teKMFQehfPxRvKrBZRldH06G5Q3nTzxU
         86CzkhIEYVcihoc79o3qXA+bRAsj4DxvR3wOKPhz1LmiqIWRhKBhCLXJzRsvesPk0rZd
         gFT9/MT7lapNLyAfoDYniHeanXN4VauyKVcRCxlXpT3OVrBVnDGm2tnPhDTxDHC8cc0G
         ZeEt9bukCDbk7INKZJzP0xovhb4xYI9FveX7oWgAXiktwqdGtMBnXjTlfU4iVrqBAuwo
         6MNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=T7QRi1bZZENDwnxa8hpYfZqSy7+lH4jOe6FRHUraHGc=;
        b=bWjdCNz+0dWIibUKp2SnNLJ1zyq5qD3sv2VPewnwc5M6XKWHL2qEyT/zhLtcoZ0z/Z
         xQg8ByNgx+UWPxVDU/BBh19MrIdqOwmY2H/no3v7YKG234XiOQnY52b2ox65JgVVHlM0
         zCknv+7yqcw3NlaHaVatmjJDdncpCb9zFLLAVdKgScOnS2YlFst8F+gNNzD1xP6Ejs8d
         2rh09ueFC6eK5HrlXP45sKc6kkkFXY362v3UWgyvDXWeuMNwJl/LTEsjzaf6Z0VrjFQ5
         g1ILJEvZPUQ15p/WKavHgOX28CjNO2ST6QLPKCOB+QYHjTbjA7cdn887Fb3op/LQ707H
         7GEQ==
X-Gm-Message-State: AOAM533Im+NHSNHsToZ4ROtdTzqhfo40i/W+DHLBK1w5EO37lhljhnjR
        LmvUZcbjSjYxxa1NBmUlA8rhE+fqYbM=
X-Google-Smtp-Source: ABdhPJyU4vEA75rZvr3zWqt9gSsive8qrVeeuFGVY0Hlz0JMgy6v2gz76vOehnLNxDAEXzLBZGbbIw==
X-Received: by 2002:a5d:5846:: with SMTP id i6mr3083011wrf.294.1633633638079;
        Thu, 07 Oct 2021 12:07:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 61sm174626wrl.94.2021.10.07.12.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 12:07:17 -0700 (PDT)
Message-Id: <5316ac086d89065cd9bda38bd475f6699adc928e.1633633635.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1103.git.git.1633633635.gitgitgadget@gmail.com>
References: <pull.1103.git.git.1633633635.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Oct 2021 19:07:15 +0000
Subject: [PATCH 2/2] remote: add remote_state to struct repository
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>, Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Add struct remote_state to struct repository and remove the global
struct remote_state from remote.c. In order for remote.c to receive
struct repository, introduce a family of repo_* functions that
accept a struct repository argument.

The existing functions in remote.h that use the_repository are
reimplemented as thin wrappers around their repo_* counterparts.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 remote.c     | 186 ++++++++++++++++++++++++++++++---------------------
 remote.h     |  69 +++++++++++++++++--
 repository.c |   8 +++
 repository.h |   4 ++
 4 files changed, 184 insertions(+), 83 deletions(-)

diff --git a/remote.c b/remote.c
index 55997210060..3a0a130ad2a 100644
--- a/remote.c
+++ b/remote.c
@@ -21,37 +21,6 @@ struct counted_string {
 	size_t len;
 	const char *s;
 };
-struct rewrite {
-	const char *base;
-	size_t baselen;
-	struct counted_string *instead_of;
-	int instead_of_nr;
-	int instead_of_alloc;
-};
-struct rewrites {
-	struct rewrite **rewrite;
-	int rewrite_alloc;
-	int rewrite_nr;
-};
-
-static struct remote_state {
-	struct remote **remotes;
-	int remotes_alloc;
-	int remotes_nr;
-	struct hashmap remotes_hash;
-
-	struct branch **branches;
-	int branches_alloc;
-	int branches_nr;
-
-	struct branch *current_branch;
-	const char *pushremote_name;
-
-	struct rewrites rewrites;
-	struct rewrites rewrites_push;
-} remotes;
-
-struct remote_state *remote_state = &remotes;
 
 static int valid_remote(const struct remote *remote)
 {
@@ -96,17 +65,19 @@ static void add_pushurl(struct remote *remote, const char *pushurl)
 	remote->pushurl[remote->pushurl_nr++] = pushurl;
 }
 
-static void add_pushurl_alias(struct remote *remote, const char *url)
+static void add_pushurl_alias(struct remote_state *remote_state,
+			      struct remote *remote, const char *url)
 {
 	const char *pushurl = alias_url(url, &remote_state->rewrites_push);
 	if (pushurl != url)
 		add_pushurl(remote, pushurl);
 }
 
-static void add_url_alias(struct remote *remote, const char *url)
+static void add_url_alias(struct remote_state *remote_state,
+			  struct remote *remote, const char *url)
 {
 	add_url(remote, alias_url(url, &remote_state->rewrites));
-	add_pushurl_alias(remote, url);
+	add_pushurl_alias(remote_state, remote, url);
 }
 
 struct remotes_hash_key {
@@ -131,14 +102,15 @@ static int remotes_hash_cmp(const void *unused_cmp_data,
 		return strcmp(a->name, b->name);
 }
 
-static inline void init_remotes_hash(void)
+static inline void init_remotes_hash(struct remote_state *remote_state)
 {
 	if (!remote_state->remotes_hash.cmpfn)
 		hashmap_init(&remote_state->remotes_hash, remotes_hash_cmp,
 			     NULL, 0);
 }
 
-static struct remote *make_remote(const char *name, int len)
+static struct remote *make_remote(struct remote_state *remote_state,
+				  const char *name, int len)
 {
 	struct remote *ret;
 	struct remotes_hash_key lookup;
@@ -147,7 +119,7 @@ static struct remote *make_remote(const char *name, int len)
 	if (!len)
 		len = strlen(name);
 
-	init_remotes_hash();
+	init_remotes_hash(remote_state);
 	lookup.str = name;
 	lookup.len = len;
 	hashmap_entry_init(&lookup_entry, memhash(name, len));
@@ -173,6 +145,28 @@ static struct remote *make_remote(const char *name, int len)
 	return ret;
 }
 
+static void remote_clear(struct remote *remote)
+{
+	int i;
+
+	free((char *)remote->name);
+	free((char *)remote->foreign_vcs);
+
+	for (i = 0; i < remote->url_nr; i++) {
+		free((char *)remote->url[i]);
+	}
+	FREE_AND_NULL(remote->pushurl);
+
+	for (i = 0; i < remote->pushurl_nr; i++) {
+		free((char *)remote->pushurl[i]);
+	}
+	FREE_AND_NULL(remote->pushurl);
+	free((char *)remote->receivepack);
+	free((char *)remote->uploadpack);
+	FREE_AND_NULL(remote->http_proxy);
+	FREE_AND_NULL(remote->http_proxy_authmethod);
+}
+
 static void add_merge(struct branch *branch, const char *name)
 {
 	ALLOC_GROW(branch->merge_name, branch->merge_nr + 1,
@@ -180,7 +174,8 @@ static void add_merge(struct branch *branch, const char *name)
 	branch->merge_name[branch->merge_nr++] = name;
 }
 
-static struct branch *make_branch(const char *name, size_t len)
+static struct branch *make_branch(struct remote_state *remote_state,
+				  const char *name, size_t len)
 {
 	struct branch *ret;
 	int i;
@@ -236,7 +231,8 @@ static const char *skip_spaces(const char *s)
 	return s;
 }
 
-static void read_remotes_file(struct remote *remote)
+static void read_remotes_file(struct remote_state *remote_state,
+			      struct remote *remote)
 {
 	struct strbuf buf = STRBUF_INIT;
 	FILE *f = fopen_or_warn(git_path("remotes/%s", remote->name), "r");
@@ -251,7 +247,8 @@ static void read_remotes_file(struct remote *remote)
 		strbuf_rtrim(&buf);
 
 		if (skip_prefix(buf.buf, "URL:", &v))
-			add_url_alias(remote, xstrdup(skip_spaces(v)));
+			add_url_alias(remote_state, remote,
+				      xstrdup(skip_spaces(v)));
 		else if (skip_prefix(buf.buf, "Push:", &v))
 			refspec_append(&remote->push, skip_spaces(v));
 		else if (skip_prefix(buf.buf, "Pull:", &v))
@@ -261,7 +258,8 @@ static void read_remotes_file(struct remote *remote)
 	fclose(f);
 }
 
-static void read_branches_file(struct remote *remote)
+static void read_branches_file(struct remote_state *remote_state,
+			       struct remote *remote)
 {
 	char *frag;
 	struct strbuf buf = STRBUF_INIT;
@@ -293,7 +291,7 @@ static void read_branches_file(struct remote *remote)
 	else
 		frag = (char *)git_default_branch_name(0);
 
-	add_url_alias(remote, strbuf_detach(&buf, NULL));
+	add_url_alias(remote_state, remote, strbuf_detach(&buf, NULL));
 	refspec_appendf(&remote->fetch, "refs/heads/%s:refs/heads/%s",
 			frag, remote->name);
 
@@ -312,10 +310,11 @@ static int handle_config(const char *key, const char *value, void *cb)
 	const char *subkey;
 	struct remote *remote;
 	struct branch *branch;
+	struct remote_state *remote_state = cb;
 	if (parse_config_key(key, "branch", &name, &namelen, &subkey) >= 0) {
 		if (!name)
 			return 0;
-		branch = make_branch(name, namelen);
+		branch = make_branch(remote_state, name, namelen);
 		if (!strcmp(subkey, "remote")) {
 			return git_config_string(&branch->remote_name, key, value);
 		} else if (!strcmp(subkey, "pushremote")) {
@@ -362,7 +361,7 @@ static int handle_config(const char *key, const char *value, void *cb)
 			name);
 		return 0;
 	}
-	remote = make_remote(name, namelen);
+	remote = make_remote(remote_state, name, namelen);
 	remote->origin = REMOTE_CONFIG;
 	if (current_config_scope() == CONFIG_SCOPE_LOCAL ||
 	    current_config_scope() == CONFIG_SCOPE_WORKTREE)
@@ -432,7 +431,7 @@ static int handle_config(const char *key, const char *value, void *cb)
 	return 0;
 }
 
-static void alias_all_urls(void)
+static void alias_all_urls(struct remote_state *remote_state)
 {
 	int i, j;
 	for (i = 0; i < remote_state->remotes_nr; i++) {
@@ -448,7 +447,7 @@ static void alias_all_urls(void)
 		for (j = 0; j < remote_state->remotes[i]->url_nr; j++) {
 			if (add_pushurl_aliases)
 				add_pushurl_alias(
-					remote_state->remotes[i],
+					remote_state, remote_state->remotes[i],
 					remote_state->remotes[i]->url[j]);
 			remote_state->remotes[i]->url[j] =
 				alias_url(remote_state->remotes[i]->url[j],
@@ -457,26 +456,25 @@ static void alias_all_urls(void)
 	}
 }
 
-static void read_config(void)
+static void read_config(struct repository *repo)
 {
-	static int loaded;
 	int flag;
 
-	if (loaded)
+	if (repo->remote_state->config_loaded)
 		return;
-	loaded = 1;
+	repo->remote_state->config_loaded = 1;
 
-	remote_state->current_branch = NULL;
+	repo->remote_state->current_branch = NULL;
 	if (startup_info->have_repository) {
 		const char *head_ref = resolve_ref_unsafe("HEAD", 0, NULL, &flag);
 		if (head_ref && (flag & REF_ISSYMREF) &&
 		    skip_prefix(head_ref, "refs/heads/", &head_ref)) {
-			remote_state->current_branch =
-				make_branch(head_ref, strlen(head_ref));
+			repo->remote_state->current_branch = make_branch(
+				repo->remote_state, head_ref, strlen(head_ref));
 		}
 	}
-	git_config(handle_config, NULL);
-	alias_all_urls();
+	repo_config(repo, handle_config, repo->remote_state);
+	alias_all_urls(repo->remote_state);
 }
 
 static int valid_remote_nick(const char *name)
@@ -503,17 +501,18 @@ const char *remote_for_branch(struct branch *branch, int *explicit)
 	return "origin";
 }
 
-const char *pushremote_for_branch(struct branch *branch, int *explicit)
+const char *repo_pushremote_for_branch(struct repository *repo,
+				       struct branch *branch, int *explicit)
 {
 	if (branch && branch->pushremote_name) {
 		if (explicit)
 			*explicit = 1;
 		return branch->pushremote_name;
 	}
-	if (remote_state->pushremote_name) {
+	if (repo->remote_state->pushremote_name) {
 		if (explicit)
 			*explicit = 1;
-		return remote_state->pushremote_name;
+		return repo->remote_state->pushremote_name;
 	}
 	return remote_for_branch(branch, explicit);
 }
@@ -540,41 +539,43 @@ const char *remote_ref_for_branch(struct branch *branch, int for_push)
 	return NULL;
 }
 
-static struct remote *remote_get_1(const char *name,
-				   const char *(*get_default)(struct branch *, int *))
+static struct remote *remote_get_1(struct repository *repo, const char *name,
+				   const char *(*get_default)(struct branch *,
+							      int *))
 {
 	struct remote *ret;
 	int name_given = 0;
 
-	read_config();
+	read_config(repo);
 
 	if (name)
 		name_given = 1;
 	else
-		name = get_default(remote_state->current_branch, &name_given);
+		name = get_default(repo->remote_state->current_branch,
+				   &name_given);
 
-	ret = make_remote(name, 0);
+	ret = make_remote(repo->remote_state, name, 0);
 	if (valid_remote_nick(name) && have_git_dir()) {
 		if (!valid_remote(ret))
-			read_remotes_file(ret);
+			read_remotes_file(repo->remote_state, ret);
 		if (!valid_remote(ret))
-			read_branches_file(ret);
+			read_branches_file(repo->remote_state, ret);
 	}
 	if (name_given && !valid_remote(ret))
-		add_url_alias(ret, name);
+		add_url_alias(repo->remote_state, ret, name);
 	if (!valid_remote(ret))
 		return NULL;
 	return ret;
 }
 
-struct remote *remote_get(const char *name)
+struct remote *repo_remote_get(struct repository *repo, const char *name)
 {
-	return remote_get_1(name, remote_for_branch);
+	return remote_get_1(repo, name, remote_for_branch);
 }
 
-struct remote *pushremote_get(const char *name)
+struct remote *repo_pushremote_get(struct repository *repo, const char *name)
 {
-	return remote_get_1(name, pushremote_for_branch);
+	return remote_get_1(repo, name, pushremote_for_branch);
 }
 
 int remote_is_configured(struct remote *remote, int in_repo)
@@ -586,12 +587,12 @@ int remote_is_configured(struct remote *remote, int in_repo)
 	return !!remote->origin;
 }
 
-int for_each_remote(each_remote_fn fn, void *priv)
+int repo_for_each_remote(struct repository *repo, each_remote_fn fn, void *priv)
 {
 	int i, result = 0;
-	read_config();
-	for (i = 0; i < remote_state->remotes_nr && !result; i++) {
-		struct remote *remote = remote_state->remotes[i];
+	read_config(repo);
+	for (i = 0; i < repo->remote_state->remotes_nr && !result; i++) {
+		struct remote *remote = repo->remote_state->remotes[i];
 		if (!remote)
 			continue;
 		result = fn(remote, priv);
@@ -1696,15 +1697,15 @@ static void set_merge(struct branch *ret)
 	}
 }
 
-struct branch *branch_get(const char *name)
+struct branch *repo_branch_get(struct repository *repo, const char *name)
 {
 	struct branch *ret;
 
-	read_config();
+	read_config(repo);
 	if (!name || !*name || !strcmp(name, "HEAD"))
-		ret = remote_state->current_branch;
+		ret = repo->remote_state->current_branch;
 	else
-		ret = make_branch(name, strlen(name));
+		ret = make_branch(repo->remote_state, name, strlen(name));
 	set_merge(ret);
 	return ret;
 }
@@ -2602,3 +2603,32 @@ void apply_push_cas(struct push_cas_option *cas,
 			check_if_includes_upstream(ref);
 	}
 }
+
+struct remote_state *remote_state_new(void)
+{
+	struct remote_state *r = xmalloc(sizeof(*r));
+
+	memset(r, 0, sizeof(*r));
+	return r;
+}
+
+void remote_state_clear(struct remote_state *remote_state)
+{
+	int i;
+
+	for (i = 0; i < remote_state->remotes_nr; i++) {
+		remote_clear(remote_state->remotes[i]);
+	}
+	FREE_AND_NULL(remote_state->remotes);
+	remote_state->remotes_alloc = 0;
+	remote_state->remotes_nr = 0;
+
+	hashmap_clear_and_free(&remote_state->remotes_hash, struct remote, ent);
+
+	for (i = 0; i < remote_state->branches_nr; i++) {
+		FREE_AND_NULL(remote_state->branches[i]);
+	}
+	FREE_AND_NULL(remote_state->branches);
+	remote_state->branches_alloc = 0;
+	remote_state->branches_nr = 0;
+}
diff --git a/remote.h b/remote.h
index 5a591982528..3cba8eb8cb6 100644
--- a/remote.h
+++ b/remote.h
@@ -23,6 +23,40 @@ enum {
 	REMOTE_BRANCHES
 };
 
+struct rewrite {
+	const char *base;
+	size_t baselen;
+	struct counted_string *instead_of;
+	int instead_of_nr;
+	int instead_of_alloc;
+};
+struct rewrites {
+	struct rewrite **rewrite;
+	int rewrite_alloc;
+	int rewrite_nr;
+};
+
+struct remote_state {
+	int config_loaded;
+
+	struct remote **remotes;
+	int remotes_alloc;
+	int remotes_nr;
+	struct hashmap remotes_hash;
+
+	struct branch **branches;
+	int branches_alloc;
+	int branches_nr;
+
+	struct branch *current_branch;
+	const char *pushremote_name;
+
+	struct rewrites rewrites;
+	struct rewrites rewrites_push;
+};
+void remote_state_clear(struct remote_state *remote_state);
+struct remote_state *remote_state_new(void);
+
 struct remote {
 	struct hashmap_entry ent;
 
@@ -83,15 +117,29 @@ struct remote {
  * remote_get(NULL) will return the default remote, given the current branch
  * and configuration.
  */
-struct remote *remote_get(const char *name);
+struct remote *repo_remote_get(struct repository *repo, const char *name);
+static inline struct remote *remote_get(const char *name)
+{
+	return repo_remote_get(the_repository, name);
+}
+
+struct remote *repo_pushremote_get(struct repository *repo, const char *name);
+static inline struct remote *pushremote_get(const char *name)
+{
+	return repo_pushremote_get(the_repository, name);
+}
 
-struct remote *pushremote_get(const char *name);
 int remote_is_configured(struct remote *remote, int in_repo);
 
 typedef int each_remote_fn(struct remote *remote, void *priv);
 
 /* iterate through struct remotes */
-int for_each_remote(each_remote_fn fn, void *priv);
+int repo_for_each_remote(struct repository *repo, each_remote_fn fn,
+			 void *priv);
+static inline int for_each_remote(each_remote_fn fn, void *priv)
+{
+	return repo_for_each_remote(the_repository, fn, priv);
+}
 
 int remote_has_url(struct remote *remote, const char *url);
 
@@ -286,9 +334,20 @@ struct branch {
 	const char *push_tracking_ref;
 };
 
-struct branch *branch_get(const char *name);
+struct branch *repo_branch_get(struct repository *repo, const char *name);
+static inline struct branch *branch_get(const char *name)
+{
+	return repo_branch_get(the_repository, name);
+}
 const char *remote_for_branch(struct branch *branch, int *explicit);
-const char *pushremote_for_branch(struct branch *branch, int *explicit);
+const char *repo_pushremote_for_branch(struct repository *repo,
+				       struct branch *branch, int *explicit);
+static inline const char *pushremote_for_branch(struct branch *branch,
+						int *explicit)
+{
+	return repo_pushremote_for_branch(the_repository, branch, explicit);
+}
+
 const char *remote_ref_for_branch(struct branch *branch, int for_push);
 
 /* returns true if the given branch has merge configuration given. */
diff --git a/repository.c b/repository.c
index 710a3b4bf87..47a27c8efb3 100644
--- a/repository.c
+++ b/repository.c
@@ -9,6 +9,7 @@
 #include "config.h"
 #include "object.h"
 #include "lockfile.h"
+#include "remote.h"
 #include "submodule-config.h"
 #include "sparse-index.h"
 #include "promisor-remote.h"
@@ -24,6 +25,7 @@ void initialize_the_repository(void)
 
 	the_repo.index = &the_index;
 	the_repo.objects = raw_object_store_new();
+	the_repo.remote_state = remote_state_new();
 	the_repo.parsed_objects = parsed_object_pool_new();
 
 	repo_set_hash_algo(&the_repo, GIT_HASH_SHA1);
@@ -164,6 +166,7 @@ int repo_init(struct repository *repo,
 
 	repo->objects = raw_object_store_new();
 	repo->parsed_objects = parsed_object_pool_new();
+	repo->remote_state = remote_state_new();
 
 	if (repo_init_gitdir(repo, gitdir))
 		goto error;
@@ -267,6 +270,11 @@ void repo_clear(struct repository *repo)
 		promisor_remote_clear(repo->promisor_remote_config);
 		FREE_AND_NULL(repo->promisor_remote_config);
 	}
+
+	if (repo->remote_state) {
+		remote_state_clear(repo->remote_state);
+		FREE_AND_NULL(repo->remote_state);
+	}
 }
 
 int repo_read_index(struct repository *repo)
diff --git a/repository.h b/repository.h
index 3740c93bc0f..4bcdbc22ed4 100644
--- a/repository.h
+++ b/repository.h
@@ -11,6 +11,7 @@ struct pathspec;
 struct raw_object_store;
 struct submodule_cache;
 struct promisor_remote_config;
+struct remote_state;
 
 enum untracked_cache_setting {
 	UNTRACKED_CACHE_UNSET = -1,
@@ -131,6 +132,9 @@ struct repository {
 	 */
 	struct index_state *index;
 
+	/* Repository's remotes and associated structures. */
+	struct remote_state *remote_state;
+
 	/* Repository's current hash algorithm, as serialized on disk. */
 	const struct git_hash_algo *hash_algo;
 
-- 
gitgitgadget
