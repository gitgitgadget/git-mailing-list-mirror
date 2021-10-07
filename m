Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD02C433EF
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 19:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00700610A1
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 19:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243844AbhJGTJP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 15:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243799AbhJGTJN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 15:09:13 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7C8C061570
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 12:07:18 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e12so22166356wra.4
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 12:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ilc/nRvuMg25WMAr3K7a0o+GOALunAXhdj87ZhMzFes=;
        b=Li3G7AEdJVHlqNmfPB43DiEHomfyQqZvB/Res9/srq0pbTrZ5ObYLvkKnrWlwWfxzT
         b8HCaJRe1exHqNcyIiDZiOrHBKyCD+3MAotJLFiki0PNhdEFy1yccmwIgptm5bBEdvy3
         oMnu+jNFSQuv6CkhboYyxdVvAP7ZInJm2AhnQgtNu3V8At5k5Gs1xAxdqnQdUKakKVU7
         lHjP4hI/LD8FgQFl3e3ewOoCKuH9SM4jLNsHI83Bf2YNWJQYOoLr4tBhY/BtcPvdnoTV
         g7UqxmD2V/RVJom0IHkPJNzFlseWcvDs+N+DIjsck/onfms00XTUFIPAap02Hs9FV6Gr
         d/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ilc/nRvuMg25WMAr3K7a0o+GOALunAXhdj87ZhMzFes=;
        b=k6CX3pO1Wn6Ili5l3GfPBpwNCyjZkh2PboY56Ii3WyRTS9pRFvmBu/v/lHnrFB8YZq
         tK1utgVFi6NEkgXLUvR2+AB82Jiicl+fq9O0XJr7bNB+v5fX63+xiGS7ZyNVr5UShLoJ
         oGKO28TmqXO720KBxiXJcINu3cjwTh88BMtAaKnpKpWvuoebBNSmTID9e7R5jO0lEivd
         PPdf21fbzyFfsz7USr+6Qm0gqdru5ac/86m8qWzaJhIqHWyktYmYN7xBLMpAdfCbij+g
         tEMOD+ZUXp+enJ/7VBxbK5PT05oZ7J0VUqyBH2+NzdAPvslmuO6fZLQfpR3NzvO/a59h
         P8zQ==
X-Gm-Message-State: AOAM530mIkLv/QSdtmQ3FpoXGeILPjcT8SwNJfgv5+KS1Xj4lrO20BCx
        tA/1cLaErxL48cI54+zS+/xxUuHNdhY=
X-Google-Smtp-Source: ABdhPJzrook5eMNJKyxaTHewG0aLXTUv5cNIqXX14QKpKtKNsuk418CdwhCLjR514/e9lCfkMHFqRg==
X-Received: by 2002:a05:600c:3644:: with SMTP id y4mr3904905wmq.125.1633633637390;
        Thu, 07 Oct 2021 12:07:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l21sm223153wmh.31.2021.10.07.12.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 12:07:17 -0700 (PDT)
Message-Id: <f7639a20fcd437d5f50665b5c6f5318c1245b9b5.1633633635.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1103.git.git.1633633635.gitgitgadget@gmail.com>
References: <pull.1103.git.git.1633633635.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Oct 2021 19:07:14 +0000
Subject: [PATCH 1/2] remote: move static variables into struct
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

remote.c only works with the_repository because it stores its state as
static variables. To support non-the_repository, we can use a
per-repository struct for the remotes subsystem.

Prepare for this change by moving the static variables of remote.c into
a static struct remote_state.

This introduces no behavioral or API changes.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 remote.c | 109 ++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 63 insertions(+), 46 deletions(-)

diff --git a/remote.c b/remote.c
index 31e141b01fa..55997210060 100644
--- a/remote.c
+++ b/remote.c
@@ -34,20 +34,24 @@ struct rewrites {
 	int rewrite_nr;
 };
 
-static struct remote **remotes;
-static int remotes_alloc;
-static int remotes_nr;
-static struct hashmap remotes_hash;
+static struct remote_state {
+	struct remote **remotes;
+	int remotes_alloc;
+	int remotes_nr;
+	struct hashmap remotes_hash;
 
-static struct branch **branches;
-static int branches_alloc;
-static int branches_nr;
+	struct branch **branches;
+	int branches_alloc;
+	int branches_nr;
 
-static struct branch *current_branch;
-static const char *pushremote_name;
+	struct branch *current_branch;
+	const char *pushremote_name;
 
-static struct rewrites rewrites;
-static struct rewrites rewrites_push;
+	struct rewrites rewrites;
+	struct rewrites rewrites_push;
+} remotes;
+
+struct remote_state *remote_state = &remotes;
 
 static int valid_remote(const struct remote *remote)
 {
@@ -94,14 +98,14 @@ static void add_pushurl(struct remote *remote, const char *pushurl)
 
 static void add_pushurl_alias(struct remote *remote, const char *url)
 {
-	const char *pushurl = alias_url(url, &rewrites_push);
+	const char *pushurl = alias_url(url, &remote_state->rewrites_push);
 	if (pushurl != url)
 		add_pushurl(remote, pushurl);
 }
 
 static void add_url_alias(struct remote *remote, const char *url)
 {
-	add_url(remote, alias_url(url, &rewrites));
+	add_url(remote, alias_url(url, &remote_state->rewrites));
 	add_pushurl_alias(remote, url);
 }
 
@@ -129,8 +133,9 @@ static int remotes_hash_cmp(const void *unused_cmp_data,
 
 static inline void init_remotes_hash(void)
 {
-	if (!remotes_hash.cmpfn)
-		hashmap_init(&remotes_hash, remotes_hash_cmp, NULL, 0);
+	if (!remote_state->remotes_hash.cmpfn)
+		hashmap_init(&remote_state->remotes_hash, remotes_hash_cmp,
+			     NULL, 0);
 }
 
 static struct remote *make_remote(const char *name, int len)
@@ -147,7 +152,7 @@ static struct remote *make_remote(const char *name, int len)
 	lookup.len = len;
 	hashmap_entry_init(&lookup_entry, memhash(name, len));
 
-	e = hashmap_get(&remotes_hash, &lookup_entry, &lookup);
+	e = hashmap_get(&remote_state->remotes_hash, &lookup_entry, &lookup);
 	if (e)
 		return container_of(e, struct remote, ent);
 
@@ -158,11 +163,12 @@ static struct remote *make_remote(const char *name, int len)
 	refspec_init(&ret->push, REFSPEC_PUSH);
 	refspec_init(&ret->fetch, REFSPEC_FETCH);
 
-	ALLOC_GROW(remotes, remotes_nr + 1, remotes_alloc);
-	remotes[remotes_nr++] = ret;
+	ALLOC_GROW(remote_state->remotes, remote_state->remotes_nr + 1,
+		   remote_state->remotes_alloc);
+	remote_state->remotes[remote_state->remotes_nr++] = ret;
 
 	hashmap_entry_init(&ret->ent, lookup_entry.hash);
-	if (hashmap_put_entry(&remotes_hash, ret, ent))
+	if (hashmap_put_entry(&remote_state->remotes_hash, ret, ent))
 		BUG("hashmap_put overwrote entry after hashmap_get returned NULL");
 	return ret;
 }
@@ -179,15 +185,16 @@ static struct branch *make_branch(const char *name, size_t len)
 	struct branch *ret;
 	int i;
 
-	for (i = 0; i < branches_nr; i++) {
-		if (!strncmp(name, branches[i]->name, len) &&
-		    !branches[i]->name[len])
-			return branches[i];
+	for (i = 0; i < remote_state->branches_nr; i++) {
+		if (!strncmp(name, remote_state->branches[i]->name, len) &&
+		    !remote_state->branches[i]->name[len])
+			return remote_state->branches[i];
 	}
 
-	ALLOC_GROW(branches, branches_nr + 1, branches_alloc);
+	ALLOC_GROW(remote_state->branches, remote_state->branches_nr + 1,
+		   remote_state->branches_alloc);
 	CALLOC_ARRAY(ret, 1);
-	branches[branches_nr++] = ret;
+	remote_state->branches[remote_state->branches_nr++] = ret;
 	ret->name = xstrndup(name, len);
 	ret->refname = xstrfmt("refs/heads/%s", ret->name);
 
@@ -327,12 +334,14 @@ static int handle_config(const char *key, const char *value, void *cb)
 		if (!strcmp(subkey, "insteadof")) {
 			if (!value)
 				return config_error_nonbool(key);
-			rewrite = make_rewrite(&rewrites, name, namelen);
+			rewrite = make_rewrite(&remote_state->rewrites, name,
+					       namelen);
 			add_instead_of(rewrite, xstrdup(value));
 		} else if (!strcmp(subkey, "pushinsteadof")) {
 			if (!value)
 				return config_error_nonbool(key);
-			rewrite = make_rewrite(&rewrites_push, name, namelen);
+			rewrite = make_rewrite(&remote_state->rewrites_push,
+					       name, namelen);
 			add_instead_of(rewrite, xstrdup(value));
 		}
 	}
@@ -342,7 +351,8 @@ static int handle_config(const char *key, const char *value, void *cb)
 
 	/* Handle remote.* variables */
 	if (!name && !strcmp(subkey, "pushdefault"))
-		return git_config_string(&pushremote_name, key, value);
+		return git_config_string(&remote_state->pushremote_name, key,
+					 value);
 
 	if (!name)
 		return 0;
@@ -425,18 +435,24 @@ static int handle_config(const char *key, const char *value, void *cb)
 static void alias_all_urls(void)
 {
 	int i, j;
-	for (i = 0; i < remotes_nr; i++) {
+	for (i = 0; i < remote_state->remotes_nr; i++) {
 		int add_pushurl_aliases;
-		if (!remotes[i])
+		if (!remote_state->remotes[i])
 			continue;
-		for (j = 0; j < remotes[i]->pushurl_nr; j++) {
-			remotes[i]->pushurl[j] = alias_url(remotes[i]->pushurl[j], &rewrites);
+		for (j = 0; j < remote_state->remotes[i]->pushurl_nr; j++) {
+			remote_state->remotes[i]->pushurl[j] =
+				alias_url(remote_state->remotes[i]->pushurl[j],
+					  &remote_state->rewrites);
 		}
-		add_pushurl_aliases = remotes[i]->pushurl_nr == 0;
-		for (j = 0; j < remotes[i]->url_nr; j++) {
+		add_pushurl_aliases = remote_state->remotes[i]->pushurl_nr == 0;
+		for (j = 0; j < remote_state->remotes[i]->url_nr; j++) {
 			if (add_pushurl_aliases)
-				add_pushurl_alias(remotes[i], remotes[i]->url[j]);
-			remotes[i]->url[j] = alias_url(remotes[i]->url[j], &rewrites);
+				add_pushurl_alias(
+					remote_state->remotes[i],
+					remote_state->remotes[i]->url[j]);
+			remote_state->remotes[i]->url[j] =
+				alias_url(remote_state->remotes[i]->url[j],
+					  &remote_state->rewrites);
 		}
 	}
 }
@@ -450,12 +466,13 @@ static void read_config(void)
 		return;
 	loaded = 1;
 
-	current_branch = NULL;
+	remote_state->current_branch = NULL;
 	if (startup_info->have_repository) {
 		const char *head_ref = resolve_ref_unsafe("HEAD", 0, NULL, &flag);
 		if (head_ref && (flag & REF_ISSYMREF) &&
 		    skip_prefix(head_ref, "refs/heads/", &head_ref)) {
-			current_branch = make_branch(head_ref, strlen(head_ref));
+			remote_state->current_branch =
+				make_branch(head_ref, strlen(head_ref));
 		}
 	}
 	git_config(handle_config, NULL);
@@ -493,10 +510,10 @@ const char *pushremote_for_branch(struct branch *branch, int *explicit)
 			*explicit = 1;
 		return branch->pushremote_name;
 	}
-	if (pushremote_name) {
+	if (remote_state->pushremote_name) {
 		if (explicit)
 			*explicit = 1;
-		return pushremote_name;
+		return remote_state->pushremote_name;
 	}
 	return remote_for_branch(branch, explicit);
 }
@@ -534,7 +551,7 @@ static struct remote *remote_get_1(const char *name,
 	if (name)
 		name_given = 1;
 	else
-		name = get_default(current_branch, &name_given);
+		name = get_default(remote_state->current_branch, &name_given);
 
 	ret = make_remote(name, 0);
 	if (valid_remote_nick(name) && have_git_dir()) {
@@ -573,11 +590,11 @@ int for_each_remote(each_remote_fn fn, void *priv)
 {
 	int i, result = 0;
 	read_config();
-	for (i = 0; i < remotes_nr && !result; i++) {
-		struct remote *r = remotes[i];
-		if (!r)
+	for (i = 0; i < remote_state->remotes_nr && !result; i++) {
+		struct remote *remote = remote_state->remotes[i];
+		if (!remote)
 			continue;
-		result = fn(r, priv);
+		result = fn(remote, priv);
 	}
 	return result;
 }
@@ -1685,7 +1702,7 @@ struct branch *branch_get(const char *name)
 
 	read_config();
 	if (!name || !*name || !strcmp(name, "HEAD"))
-		ret = current_branch;
+		ret = remote_state->current_branch;
 	else
 		ret = make_branch(name, strlen(name));
 	set_merge(ret);
-- 
gitgitgadget

