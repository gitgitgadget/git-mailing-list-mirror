Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795273864;
	b=HtwEme02gNsdVFr1jESIbJNjKEel841rXmSmTpX8DKpPc8+EEIeMJ61apURrbwhHVJa1
	 77zoOvOyGL5//6fAz9SFEMEHk50bftVQqXbeRiE6R2RISueogZRKEi4aiK6zFwcw8OQJX
	 L3ueer0KGyobOO2SsOedzSRopcIH8YlJpumEa+029cEt/CmQDe0WTWyX4ZiM92m488dPF
	 c23HPa4LpoUUZCJ0V/YxDKybLvCvIgDIHN5zKhMTIzOlhu0mTEb+9MgikYYp8WGfOFZkS
	 X+HeMMRHYoxpSLQncFXFkl8I6XxrpMwWm9Q/FYqyQLww1GDQFkS8KjARiUo7qL3pO/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795273864;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=W1eyp3SXxldgueOzm2a2SChTtypPpDvMTly91YTC59c=;
	b=DD8tfWQaT/b6vftVNBpTSa8CduKHDzaTDt2tSlyT0dKQ7hQnYRPSqfId/6+6Y1K/xPHK
	 4PQ3RYdNV066USFYH8Ajw1xk745qxgbFyCML6T6Dv7d8vfUKGSoYJ1DnK6nF0m8qdNYIl
	 d07FsQVqfsw+hjkjYLrxleEcaJxREVhMjl2A8njJJuxXSUIlArQhIOoKN2x3d9uWHZxUh
	 09UimVd7EaiAb0zi0yBKKuArujpJ5Cz+dmdYCHFgz3Et75dRNrtclcoBdcwDPhyTGUvNf
	 Mm8zQjzt4m/gdQSJ5aHv1IolbIDbk/QR+FQ4SL7NESUWpXHIPsSXQkCTP/HKoN0LZBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Xi/d23GX";
	arc=none smtp.remote-ip=209.85.210.46
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F8C606A32C
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 15:11:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37F8C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xi/d23GX
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-862b3a39d0dso1032387a34.3
        for <git@vger.kernel.org>; Sat, 21 Nov 2026 07:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795273862; x=1795878662; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=W1eyp3SXxldgueOzm2a2SChTtypPpDvMTly91YTC59c=;
        b=Xi/d23GXTVZ24OyAROyRBHWoKYMFTkcnPQ9Q4p21Kt7cuSbauqoSrs4ky8L6ee711+
         yddmosk6G9gemdB0tO3EXlmMtvWj4Vtch26Ohgt9q6GjR8A72a+kkAzxUthUUT1zLNeQ
         rA8z9AeQIPeSVLmujYP3oYvZJIwGjrQivpg6HAMCsNM45sOY4OP5XRv0+gmkHk/1GRBY
         Q9+a2/JnilYHyYDxgm67RZ6o79C6O7Jd/UJ6afdrscGeW54MaYNse2n+2a93qbBkq48F
         s/VqypM2IDfxjhgQtOmnviq+QurE8e052yAq/Ko41ncvoiSpitrbgq1+KAzt4EJQjwMk
         2ssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795273862; x=1795878662;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W1eyp3SXxldgueOzm2a2SChTtypPpDvMTly91YTC59c=;
        b=Q9VZRzYjZMBrMU5sLAi6Xr3ONovACjv43g10FJF2BOs1RgwU2EImFxtI1C6qw+NzBH
         Di8wjzp5/MOg0GYc43YcEoj3eevJqr9CiyexjuiDh+lTfs1cvB7psGUpA0s2qnCuwmws
         o868wbRCR+pDN15Ou1tsszw4HQJ9+2Ewr5blOOhO9zypqIZzSWCF71jt9bRFBRDoBgsB
         zVuaO2/6rl6MfrlFsE13p/xrIfG5eUMxbyidW0zgq7UlVGfBIoT4i77BH05Iw/APEQq5
         Omh2H33hHe9Q9QFSfaZbBAEMPyrvGAhqE4DmyVeFC3gkbN0GMbmfGKd4DBqTlbslEATn
         zlyg==
X-Gm-Message-State: APuU4Z8a5RR6pqVng0Hw+rxg4oI22vZ7A9fFanDoV1FuFbT6LUnm0XjC
	0jYDhqcmbRBO2zlGq/isSfJ97YReJzCjbY7r4GB6EMh1BajskFo6cWB6w9OdzdWE
X-Gm-Gg: AZFdTZdTezVx5O/hTbTYetlm9CKEJZKkqpu3wqA7TN+CrKfka+/2vJLPey7v8ip2l7v
	Q26rzle9xsv3IpIfnorz7wYdTfaqn//Fnry2Gaf7AsCAIIuNrqylyU3CKxlE9ZCJfOtXyqNPsS5
	u7E/zQkklgWBtkL2AdC/Xf+zVu5SuboQvvcqdlRQyhProqa0qgf37bmC070aM+RsYIvxjY/eINm
	iq0p09Cr3tbnyfKdflB+Bmq2AHMgTAzkYCP5m2Oip63k2Z0oOiFbc3H23F9e9Do60lC6wBNwKfr
	Fv13MLuzS3t5UihWxrVpGhNEacSJRSQjd2AJXDMxhl1kb6egCRy/Pv4gMB6plmTiHjgQmlU0d6R
	EvlG1/5K2hGzKQCgrrNKfmNj7xYUasORGqznMne5iud5FzptAdEtQ+Yl/46EgtHH1G6TwI6fbjB
	qeODaWWQd/2CR+gZtk+0WJCvI48W2J/m/MIkHSOO1iy65ud/0sZCpxMNHnrpce9aJOwflsmLgBV
	hwlvGHWAjMQekKXpdkDx9CMvibPT12OFEblGpndsoXYev/hYNzBDtN/yLGYbqEBqjWa1Lk0hM9Y
	H+D64juQWCn9aAYfoyo/j5j+mIcmx70=
X-Received: by 2002:a05:6830:b14:b0:81e:a323:f3bc with SMTP id 46e09a7af769-86315963eaemr7147158a34.13.1795273861948;
        Sat, 21 Nov 2026 07:11:01 -0800 (PST)
Received: from [127.0.0.1] ([9.234.15.210])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168bdba0sm4884629a34.7.2026.11.21.07.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 07:11:00 -0800 (PST)
Message-Id: <e816484923b0adb741aec4a36eb5b126ba02a31f.1795273853.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2306.v2.git.1795273853.gitgitgadget@gmail.com>
References: <pull.2306.git.1794484985.gitgitgadget@gmail.com>
	<pull.2306.v2.git.1795273853.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 21 Nov 2026 15:10:52 +0000
Subject: [PATCH v2 2/3] submodule: store settings in worktree config when
 enabled
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
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>,
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

Unlike other settings, `submodule.<name>.gitdir` must not be shared
between worktrees. Different commits in the superproject may record
different commits for the same submodule. If the gitdir is shared, the
submodule worktrees end up sharing the same `HEAD` and index, causing
Git commands to behave incorrectly. Therefore, store this setting in
the worktree config and exclude it from the config copied by 'git
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
index c3b3a2865f..2cd6f58cac 100644
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
@@ -612,15 +612,10 @@ static void init_submodule(const char *path, const char *prefix,
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
 
@@ -646,7 +641,7 @@ static void init_submodule(const char *path, const char *prefix,
 			free(oldurl);
 		}
 
-		if (repo_config_set_gently(the_repository, sb.buf, url))
+		if (repo_config_set_worktree_gently(the_repository, sb.buf, url))
 			die(_("Failed to register url for submodule path '%s'"),
 			    displaypath);
 		if (!(flags & OPT_QUIET))
@@ -668,7 +663,7 @@ static void init_submodule(const char *path, const char *prefix,
 			upd = submodule_update_type_to_string(sub->update_strategy.type);
 		}
 
-		if (repo_config_set_gently(the_repository, sb.buf, upd))
+		if (repo_config_set_worktree_gently(the_repository, sb.buf, upd))
 			die(_("Failed to register update mode for submodule path '%s'"), displaypath);
 	}
 
@@ -1494,7 +1489,7 @@ static void sync_submodule(const char *path, const char *prefix,
 
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "submodule.%s.url", sub->name);
-	if (repo_config_set_gently(the_repository, sb.buf, super_config_url))
+	if (repo_config_set_worktree_gently(the_repository, sb.buf, super_config_url))
 		die(_("failed to register url for submodule path '%s'"),
 		      displaypath);
 
@@ -1673,17 +1668,31 @@ static void deinit_submodule(const char *path, const char *prefix,
 
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
@@ -3583,7 +3592,7 @@ static void configure_added_submodule(struct add_data *add_data)
 	int matched = 0;
 
 	key = xstrfmt("submodule.%s.url", add_data->sm_name);
-	repo_config_set_gently(the_repository, key, add_data->realrepo);
+	repo_config_set_worktree_gently(the_repository, key, add_data->realrepo);
 	free(key);
 
 	add_submod.git_cmd = 1;
@@ -3613,10 +3622,6 @@ static void configure_added_submodule(struct add_data *add_data)
 	if (run_command(&add_gitmodules))
 		die(_("Failed to register submodule '%s'"), add_data->sm_path);
 
-	/*
-	 * NEEDSWORK: In a multi-working-tree world this needs to be
-	 * set in the per-worktree config.
-	 */
 	/*
 	 * NEEDSWORK: In the longer run, we need to get rid of this
 	 * pattern of querying "submodule.active" before calling
@@ -3630,7 +3635,7 @@ static void configure_added_submodule(struct add_data *add_data)
 		 * current configured pathspec, set the submodule's active flag
 		 */
 		key = xstrfmt("submodule.%s.active", add_data->sm_name);
-		repo_config_set_gently(the_repository, key, "true");
+		repo_config_set_worktree_gently(the_repository, key, "true");
 		free(key);
 	} else {
 		for (size_t i = 0; i < values->nr; i++) {
@@ -3642,7 +3647,7 @@ static void configure_added_submodule(struct add_data *add_data)
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

