Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794484992;
	b=LBryG0wTNhd2lG21Mv+EA3Jl6zx6RUfnZ730eq+v4vxAjmmLpaqKbCLqpsY2tb1wluYf
	 uv6z5WxM1kTK7b61A/0LFslc5DhHzmWuEs26phiYzuFgBud87quDTTrF9B00Q1f867fYh
	 zQ9EEd5XYoiDW15fJhMhtfnrHy4xL0nAkC+LJZGbHkijGjC28Hjzyx7u2pVC/hRKq3ZYc
	 bBS/jjRIUrfzUr/s33fBoUQeFKQjAgCObC5HAA3fD0WxXi1nPopOeeTVx9L+qLLcBkPyI
	 Djn+/dBrFa3jqn7V+ip5BTRQ522RGD2vPcb01YQQeG2JtVad/GtBMCHYMeWEcRlLQ/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794484992;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=/f1Ji/6Ni13YEUgOivQUBvEcoeGcUkH60go3nklEd5E=;
	b=k4j6R/nAFrxWGDTE0HmYL7huGVitSGoMvQAWZZcZm5ZUQK6tZYl1hrHf+Rl2NEwC5VM6
	 6armFWKs//4ZCDKZFKXEfROk6WYSkJLNnJywXNveTlh4G3BOE5ZcE/UCWMKlhU7ijcvl0
	 rGgjNjGJgnM45OHrWTi9+HWBvjym2MIlx1m93tSB23OREOJT8n0i9770OfsYxvKjfOpWl
	 N41xSVpDs3QJaOaZfJNoYXa0DXtp11Lbu9k3VROY3DpQZ7oM9TTDqlYZZ7ffIlsbbLMfy
	 sMJXLDYDq23328lFPAs0z7sqkaSy2ZS8oekZHpA3D9fruynga1FvuynpNvl9rNas3kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="WtYhSX7/";
	arc=none smtp.remote-ip=74.125.224.46
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A261A606A8A7
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 12:03:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A261A606A8A7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WtYhSX7/
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-679a2b5fe87so5015218d50.3
        for <git@vger.kernel.org>; Thu, 12 Nov 2026 04:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794484991; x=1795089791; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/f1Ji/6Ni13YEUgOivQUBvEcoeGcUkH60go3nklEd5E=;
        b=WtYhSX7/9mfHFnd0IU8oyFdyslgfnADQRciGvj0kTT+ESglZ+SpQ5v0PxrHHsKLlIr
         DMIlWA7pYjd/h7yl50z4tRWThRurE92XQLfAA1htv0le1xTYZJSo8J9u43B6oArW9W4T
         KbOipAC9vVecmryQpappI6BNoxUkf9KctbQmHzJ7YUueDaXCRrsxtXNOa8bBnxA4To0s
         9tw5oa4KttwSvhpr929HTsilEDqIPpP2faHFm3uA+B/1XClEtIsbPyv04rauSlV6xlN7
         EKYDfvH9NRp8SJrXpmh/kknEskq1vdZmCKxxMNvUQAxD5BtSzGQLKzgUs5LOGvF+QMpa
         fpbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794484991; x=1795089791;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/f1Ji/6Ni13YEUgOivQUBvEcoeGcUkH60go3nklEd5E=;
        b=YKaHItMPXYem1FUtCjrwnSX6GAzbjkV76X09zS5TGWWsBIwYxrurVcyTwzw6mCYMmH
         ZzK8ab/IkGhKshfCn7nPriWKjGxOMN61xtZuNg4kZyDTO3LbEiTa8Snv9CjYym4LMgjj
         YZyovMWB1fF7dIayJkoBygnyvfTEQfdd1r9S8ggTOLmLm96gx72oNtJxUCSqqo5dp46A
         xzeGy/WHP4etTUmWp642AYyLetqOcu31a961+s58UV3DtSBshofcBmvVaoB2vYKBBlDc
         iTjba/xb94veO5RtlXdngjS2qi8u7ymLHKMxNkXG1fd0FENkRcZoKXc+4wwXxxd5BdI5
         ktJg==
X-Gm-Message-State: APuU4Z92eWsM+pJaHTAHX3fjEmYAO4ltOtMxPIcllaG7qslBI/yDPEEl
	1xUodS/29ODVSFMcKSkO696HRIN0oR4GY9raF5Sb0KNs4QCuDP7fQO3S2Oh0lAX4
X-Gm-Gg: AYBFou0Om03IZU62vXgT9ltr4RJzxn9xxZZSM3dV1Jk1Cr/Xb4y/3vHzQL87q1G4Z3y
	IaKHuzXAocx/gac217UQRv1mQHFwSTpQdkde9XR3kvZVtJ53ByL8F7QmC7//elW7xRyUqmNdOfV
	4UwT2Ul201hXzbdW3+FgNYDxNJrbsb5sDwDtcVEjXbB5KhMCj8fBjAEsk10mcWIYzw1ygga5giu
	pJQwGcZBW9cBYca1jBzyCbZKpMNPe3BMtjnPUNU3Nopu8zdhahuSuV15sX3ZoLRuqT2HtFJER17
	V7osH/qEPdMbnoI0S4KajHn0YaZl7lUQkwxtcp1EsxpRLCQs6LwbbTYDMODk4oHo+Llwp3ONt3s
	8crPfL1J5/A8ehIT0Jnd62sgdK9EYemzQW+5si9hxWD8T2AbW/Fjm5BVJpvadOkZGnEUs9qADal
	itosgjjm5vRKgZer6Hw0f6uFFh3bhSHP0mwJ4IbDgfYx+weqTmREhBlID8OIlqPu72gfiv+mq4M
	wdiZG3UmjKURum/z05A4IBlmMIMuoUrsjBJI6J6z/IkfU9qWhLU2YqaKJfNkqlfxSpXkUSd+3rx
	I6uZKcXB/2HBDyS55TfRqEphlEg1x6iIvSG+
X-Received: by 2002:a05:690e:4295:20b0:67b:fe2a:443 with SMTP id 956f58d0204a3-67c67f81895mr2215007d50.87.1794484990607;
        Thu, 12 Nov 2026 04:03:10 -0800 (PST)
Received: from [127.0.0.1] ([172.206.245.227])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f02df714csm46264366d6.28.2026.11.12.04.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 04:03:09 -0800 (PST)
Message-Id: <14b156bc42c4d6bcfd662d43f07231a3b62f46ef.1794484985.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2306.git.1794484985.gitgitgadget@gmail.com>
References: <pull.2306.git.1794484985.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 12 Nov 2026 12:03:04 +0000
Subject: [PATCH 2/3] submodule: store settings in worktree config when enabled
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

Submodule URLs can differ between branches. For example, one branch
may use the upstream repository while another uses a fork for the same
submodule. When these branches are checked out in separate worktrees,
storing `submodule.<name>.url` in the shared repository config
prevents each worktree from using its own URL.

Store submodule settings such as `submodule.<name>.active` and
`submodule.<name>.url` in the worktree config when
`extensions.worktreeConfig` is enabled.

Settings shared between worktrees can remain in the repository
config. When such a setting exists there, 'git submodule deinit' sets
`submodule.<name>.active` to false in the worktree config to
unregister the submodule.

Unlike other settings, `submodule.<name>.gitdir` should not be shared
between worktrees, so exclude it from the config copied by 'git
worktree add'.

Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
---
 Documentation/config/submodule.adoc        |   3 +-
 builtin/submodule--helper.c                |  43 ++++---
 builtin/worktree.c                         |  23 ++++
 t/t2405-worktree-submodule.sh              | 129 +++++++++++++++++++++
 t/t7425-submodule-gitdir-path-extension.sh |  49 ++++++++
 5 files changed, 227 insertions(+), 20 deletions(-)

diff --git a/Documentation/config/submodule.adoc b/Documentation/config/submodule.adoc
index 4c424017b4..1e294147db 100644
--- a/Documentation/config/submodule.adoc
+++ b/Documentation/config/submodule.adoc
@@ -58,7 +58,8 @@ submodule.<name>.gitdir::
 	respected when `extensions.submodulePathConfig` is enabled, otherwise it
 	has no effect. When enabled, this config becomes the single source of
 	truth for submodule gitdir paths and Git will error if it is missing.
-	See linkgit:git-config[1] for details.
+	When `extensions.worktreeConfig` is enabled, this setting is stored in
+	each worktree's config. See linkgit:git-config[1] for details.
 
 submodule.active::
 	A repeated field which contains a pathspec used to match against a
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 56d7720e93..f249582ca6 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -497,7 +497,7 @@ static int validate_and_set_submodule_gitdir(struct strbuf *gitdir_path,
 		return 0;
 	}
 
-	if (repo_config_set_gently(the_repository, key, gitdir_path->buf)) {
+	if (repo_config_set_worktree_gently(the_repository, key, gitdir_path->buf)) {
 		free(key);
 		return -1;
 	}
@@ -609,15 +609,10 @@ static void init_submodule(const char *path, const char *prefix,
 		die(_("No url found for submodule path '%s' in .gitmodules"),
 			displaypath);
 
-	/*
-	 * NEEDSWORK: In a multi-working-tree world, this needs to be
-	 * set in the per-worktree config.
-	 *
-	 * Set active flag for the submodule being initialized
-	 */
+	/* Set active flag for the submodule being initialized */
 	if (!is_submodule_active(the_repository, path)) {
 		strbuf_addf(&sb, "submodule.%s.active", sub->name);
-		repo_config_set_gently(the_repository, sb.buf, "true");
+		repo_config_set_worktree_gently(the_repository, sb.buf, "true");
 		strbuf_reset(&sb);
 	}
 
@@ -643,7 +638,7 @@ static void init_submodule(const char *path, const char *prefix,
 			free(oldurl);
 		}
 
-		if (repo_config_set_gently(the_repository, sb.buf, url))
+		if (repo_config_set_worktree_gently(the_repository, sb.buf, url))
 			die(_("Failed to register url for submodule path '%s'"),
 			    displaypath);
 		if (!(flags & OPT_QUIET))
@@ -665,7 +660,7 @@ static void init_submodule(const char *path, const char *prefix,
 			upd = submodule_update_type_to_string(sub->update_strategy.type);
 		}
 
-		if (repo_config_set_gently(the_repository, sb.buf, upd))
+		if (repo_config_set_worktree_gently(the_repository, sb.buf, upd))
 			die(_("Failed to register update mode for submodule path '%s'"), displaypath);
 	}
 
@@ -1491,7 +1486,7 @@ static void sync_submodule(const char *path, const char *prefix,
 
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "submodule.%s.url", sub->name);
-	if (repo_config_set_gently(the_repository, sb.buf, super_config_url))
+	if (repo_config_set_worktree_gently(the_repository, sb.buf, super_config_url))
 		die(_("failed to register url for submodule path '%s'"),
 		      displaypath);
 
@@ -1670,17 +1665,31 @@ static void deinit_submodule(const char *path, const char *prefix,
 
 	/* remove the .git/config entries (unless the user already did it) */
 	if (!capture_command(&cp_config, &sb_config, 0) && sb_config.len) {
+		char *file = the_repository->repository_format_worktree_config ?
+		  repo_git_path(the_repository, "config.worktree") :
+		  repo_git_path(the_repository, "config");
 		char *sub_key = xstrfmt("submodule.%s", sub->name);
 
 		/*
 		 * remove the whole section so we have a clean state when
 		 * the user later decides to init this submodule again
 		 */
-		repo_config_rename_section_in_file(the_repository, NULL, sub_key, NULL);
+		repo_config_rename_section_in_file(the_repository, file, sub_key, NULL);
 		if (!(flags & OPT_QUIET))
 			printf(_("Submodule '%s' (%s) unregistered for path '%s'\n"),
 				 sub->name, sub->url, displaypath);
+		free(file);
 		free(sub_key);
+
+		if (the_repository->repository_format_worktree_config) {
+			char *key = xstrfmt("submodule.%s.active", sub->name);
+
+			repo_config_clear(the_repository);
+			if (is_submodule_active(the_repository, sub->name))
+				repo_config_set_worktree_gently(the_repository,
+								key, "false");
+			free(key);
+		}
 	}
 
 cleanup:
@@ -3580,7 +3589,7 @@ static void configure_added_submodule(struct add_data *add_data)
 	int matched = 0;
 
 	key = xstrfmt("submodule.%s.url", add_data->sm_name);
-	repo_config_set_gently(the_repository, key, add_data->realrepo);
+	repo_config_set_worktree_gently(the_repository, key, add_data->realrepo);
 	free(key);
 
 	add_submod.git_cmd = 1;
@@ -3610,10 +3619,6 @@ static void configure_added_submodule(struct add_data *add_data)
 	if (run_command(&add_gitmodules))
 		die(_("Failed to register submodule '%s'"), add_data->sm_path);
 
-	/*
-	 * NEEDSWORK: In a multi-working-tree world this needs to be
-	 * set in the per-worktree config.
-	 */
 	/*
 	 * NEEDSWORK: In the longer run, we need to get rid of this
 	 * pattern of querying "submodule.active" before calling
@@ -3627,7 +3632,7 @@ static void configure_added_submodule(struct add_data *add_data)
 		 * current configured pathspec, set the submodule's active flag
 		 */
 		key = xstrfmt("submodule.%s.active", add_data->sm_name);
-		repo_config_set_gently(the_repository, key, "true");
+		repo_config_set_worktree_gently(the_repository, key, "true");
 		free(key);
 	} else {
 		for (size_t i = 0; i < values->nr; i++) {
@@ -3639,7 +3644,7 @@ static void configure_added_submodule(struct add_data *add_data)
 		}
 		if (!matched) { /* no pattern matched -> force-enable */
 			key = xstrfmt("submodule.%s.active", add_data->sm_name);
-			repo_config_set_gently(the_repository, key, "true");
+			repo_config_set_worktree_gently(the_repository, key, "true");
 			free(key);
 		}
 	}
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 77ecd0f71f..ef03ef979a 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -363,6 +363,9 @@ static void copy_filtered_worktree_config(const char *worktree_git_dir)
 	if (file_exists(from_file)) {
 		struct config_set cs = { { 0 } };
 		int bare;
+		struct string_list keys = STRING_LIST_INIT_DUP;
+		struct string_list_item *item;
+		int i;
 
 		if (safe_create_leading_directories(the_repository, to_file) ||
 			copy_file(the_repository, to_file, from_file, 0666)) {
@@ -386,6 +389,26 @@ static void copy_filtered_worktree_config(const char *worktree_git_dir)
 			error(_("failed to unset '%s' in '%s'"),
 				"core.worktree", to_file);
 
+		/* unset "submodule.*.gitdir" */
+		for (i = 0; i < cs.list.nr; i++) {
+			const char *var = cs.list.items[i].e->key;
+			const char *subsection, *key;
+			size_t subsection_len;
+
+			if (!parse_config_key(var, "submodule",
+					      &subsection, &subsection_len, &key) &&
+			    subsection && !strcmp(key, "gitdir"))
+				string_list_insert(&keys, var);
+		}
+		for_each_string_list_item(item, &keys) {
+			if (repo_config_set_in_file_gently(the_repository,
+							   to_file, item->string,
+							   NULL, NULL))
+				error(_("failed to unset '%s' in '%s'"),
+				      item->string, to_file);
+		}
+		string_list_clear(&keys, 0);
+
 		git_configset_clear(&cs);
 	}
 
diff --git a/t/t2405-worktree-submodule.sh b/t/t2405-worktree-submodule.sh
index f5c94d490b..d46d565ad6 100755
--- a/t/t2405-worktree-submodule.sh
+++ b/t/t2405-worktree-submodule.sh
@@ -91,4 +91,133 @@ test_expect_success 'unsetting core.worktree does not prevent running commands d
 	git -C main/.git/worktrees/checkout-recurse/modules/sub log
 '
 
+test_expect_success 'submodule config in worktree config' '
+	test_when_finished "rm -rf wt-config" &&
+	git clone "$base_path/origin/main" wt-config &&
+	(
+		cd wt-config &&
+		git config extensions.worktreeConfig true &&
+		git worktree add wt &&
+		cat .git/config >.git/expect-config &&
+
+		git submodule update --init &&
+		test_cmp .git/expect-config .git/config &&
+		echo "true" >expect &&
+		git config --worktree submodule.sub.active >actual &&
+		test_cmp expect actual &&
+		echo "$base_path/origin/sub" >expect &&
+		git config --worktree submodule.sub.url >actual &&
+		test_cmp expect actual &&
+
+		git submodule deinit sub &&
+		test_cmp .git/expect-config .git/config &&
+		test_must_be_empty .git/config.worktree &&
+
+		git submodule add ../sub sub2 &&
+		test_cmp .git/expect-config .git/config &&
+		echo "true" >expect &&
+		git config --worktree submodule.sub2.active >actual &&
+		test_cmp expect actual &&
+		echo "$base_path/origin/sub" >expect &&
+		git config --worktree submodule.sub2.url >actual &&
+		test_cmp expect actual &&
+
+		git config --file=.gitmodules submodule.sub2.url new_url &&
+		git submodule sync &&
+		test_cmp .git/expect-config .git/config &&
+		echo "new_url" >expect &&
+		git config --worktree submodule.sub2.url >actual &&
+		test_cmp expect actual &&
+
+		cd wt &&
+
+		git submodule update --init &&
+		test_cmp ../.git/expect-config ../.git/config &&
+		echo "true" >expect &&
+		git config --worktree submodule.sub.active >actual &&
+		test_cmp expect actual &&
+		echo "$base_path/origin/sub" >expect &&
+		git config --worktree submodule.sub.url >actual &&
+		test_cmp expect actual &&
+
+		git submodule deinit sub &&
+		test_cmp ../.git/expect-config ../.git/config &&
+		test_must_be_empty ../.git/worktrees/wt/config.worktree &&
+
+		git submodule add ../sub sub2 &&
+		test_cmp ../.git/expect-config ../.git/config &&
+		echo "true" >expect &&
+		git config --worktree submodule.sub2.active >actual &&
+		test_cmp expect actual &&
+		echo "$base_path/origin/sub" >expect &&
+		git config --worktree submodule.sub2.url >actual &&
+		test_cmp expect actual &&
+
+		git config --file=.gitmodules submodule.sub2.url new_url &&
+		git submodule sync &&
+		test_cmp ../.git/expect-config ../.git/config &&
+		echo "new_url" >expect &&
+		git config --worktree submodule.sub2.url >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'deinit overwrites active config' '
+	test_when_finished "rm -rf repo-wt-config" &&
+	git clone "$base_path/origin/main" repo-wt-config &&
+	(
+		cd repo-wt-config &&
+		git submodule update --init &&
+		git config extensions.worktreeConfig true &&
+		git worktree add wt &&
+		cat .git/config >.git/expect-config &&
+
+		git submodule deinit sub &&
+		test_cmp .git/expect-config .git/config &&
+		echo "false" >expect &&
+		git config --worktree submodule.sub.active >actual &&
+		test_cmp expect actual &&
+
+		cd wt &&
+
+		git submodule deinit sub &&
+		test_cmp ../.git/expect-config ../.git/config &&
+		echo "false" >expect &&
+		git config --worktree submodule.sub.active >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'do not copy gitdir in config.worktree' '
+	test_when_finished "rm -rf copy-wt-config" &&
+	git clone "$base_path/origin/main" copy-wt-config &&
+	(
+		cd copy-wt-config &&
+		git config core.repositoryformatversion 1 &&
+		git config extensions.submodulePathConfig true &&
+		git config extensions.worktreeConfig true &&
+
+		git submodule update --init &&
+		echo "true" >expect &&
+		git config --worktree submodule.sub.active >actual &&
+		test_cmp expect actual &&
+		echo "$base_path/origin/sub" >expect &&
+		git config --worktree submodule.sub.url >actual &&
+		test_cmp expect actual &&
+		echo ".git/modules/sub" >expect &&
+		git config --worktree submodule.sub.gitdir >actual &&
+		test_cmp expect actual &&
+
+		git worktree add wt &&
+		cd wt &&
+		echo "true" >expect &&
+		git config --worktree submodule.sub.active >actual &&
+		test_cmp expect actual &&
+		echo "$base_path/origin/sub" >expect &&
+		git config --worktree submodule.sub.url >actual &&
+		test_cmp expect actual &&
+		test_must_fail git config --worktree submodule.sub.gitdir
+	)
+'
+
 test_done
diff --git a/t/t7425-submodule-gitdir-path-extension.sh b/t/t7425-submodule-gitdir-path-extension.sh
index 02123b8468..3bae4c4ef1 100755
--- a/t/t7425-submodule-gitdir-path-extension.sh
+++ b/t/t7425-submodule-gitdir-path-extension.sh
@@ -78,6 +78,55 @@ test_expect_success 'gitdir config path is relative for both absolute and relati
 	)
 '
 
+test_expect_success 'gitdir for the main worktree is stored in worktree config' '
+	test_when_finished "rm -rf relative-cfg-path-test-main" &&
+	git init -b main relative-cfg-path-test-main &&
+	(
+		cd relative-cfg-path-test-main &&
+		git config core.repositoryformatversion 1 &&
+		git config extensions.submodulePathConfig true &&
+		git config extensions.worktreeConfig true &&
+
+		# Test with absolute URL
+		git submodule add "$TRASH_DIRECTORY/new-sub" sub-abs &&
+		git config --worktree submodule.sub-abs.gitdir >actual &&
+		echo ".git/modules/sub-abs" >expect &&
+		test_cmp expect actual &&
+
+		# Test with relative URL
+		git submodule add ../new-sub sub-rel &&
+		git config --worktree submodule.sub-rel.gitdir >actual &&
+		echo ".git/modules/sub-rel" >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'gitdir for a linked worktree is stored in worktree config' '
+	test_when_finished "rm -rf relative-cfg-path-test-wt" &&
+	git init -b main relative-cfg-path-test-wt &&
+	(
+		cd relative-cfg-path-test-wt &&
+		git config core.repositoryformatversion 1 &&
+		git config extensions.submodulePathConfig true &&
+		git config extensions.worktreeConfig true &&
+
+		git worktree add wt &&
+		cd wt &&
+
+		# Test with absolute URL
+		git submodule add "$TRASH_DIRECTORY/new-sub" sub-abs &&
+		git config --worktree submodule.sub-abs.gitdir >actual &&
+		echo "../.git/worktrees/wt/modules/sub-abs" >expect &&
+		test_cmp expect actual &&
+
+		# Test with relative URL
+		git submodule add ../../new-sub sub-rel &&
+		git config --worktree submodule.sub-rel.gitdir >actual &&
+		echo "../.git/worktrees/wt/modules/sub-rel" >expect &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'clone from repo with both legacy and new-style submodules' '
 	git clone --recurse-submodules main cloned-non-extension &&
 	(
-- 
gitgitgadget

