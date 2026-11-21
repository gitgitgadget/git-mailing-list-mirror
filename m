Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795273865;
	b=x4iIVk+scGrGOPgOafI4fXfp3gxjpkkQ+U4TZFoeajXzoDZAo02P1ZeZhA1l4So8Uj55
	 RhWYG02A4WTASa1b3NY52adtPvFzIAvcFAVjhSO3wRjAilhwrGJ+pInGC1cXo9vUk4IKw
	 NPb3gcmHVVmqB5EG1cWwyk+7nCBYAgVJ7VM2QGXwrt5O9tWwqBU3B3RARMAtSzPzSP+NN
	 p3+hZbp1VZFC2/9vwjz2K0Z73TyIpEQdMOpsZ8TTFO6S8pof945k78si8mTxd+3cdUwH8
	 ovgvyLr7SK0FaHblMLz+c4icnrSJXloNBRQwJCq7Z/D8ipcPGPr4yAKY9USi5jErh8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795273865;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=l77T5E697LYAr/U356kkdcfoegO4IuerXr1rgGGfgE4=;
	b=hDAHyYhwJ5rKrZoXsFZHNvLZIh8NBZ5JyskpP1ust2g30s+PcVLONxysLjBnCJtjh4o/
	 rMjEs0DYFdIsKvY1sycX2WPwIqeK8bYs5mmmnuQEcmpAgPiU4+FTzNmbmYtXNBmVyYZ9v
	 B0XimneVldTe5bmhGQj5NI127A10Fs0gMyLqtC/WoANn4MRuqZQPj5qZyhQKIiiuSRage
	 MQyI0tfIpWT5BV0TzV2/s81JhVaYUqDu5UiqAkBz7LfSvXgu08NSTjCzrDctAfwo23dId
	 fBnAkyfL4FHzcCuPa4m0uSDBBiqqnuXnKl0hS+eOQKm0deGOVu2cf8Wfy/dTwOiaTLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RgygQOKM;
	arc=none smtp.remote-ip=209.85.161.53
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21271606A33B
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 15:11:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21271606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RgygQOKM
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-71ad1db7e31so2037623eaf.1
        for <git@vger.kernel.org>; Sat, 21 Nov 2026 07:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795273864; x=1795878664; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=l77T5E697LYAr/U356kkdcfoegO4IuerXr1rgGGfgE4=;
        b=RgygQOKM8kZT3lB10/PlDgZ4Cyxr+wcBnRgg9Yg+4Mc5zF8mGdZc3hbaLNi774aCLs
         YWvC15WHop7TFX5Z6p0NxZ/jAfOjFaGrUJ+Dp2PLkabkSobgMDYMRUkgvmPOosjSrGj6
         JIrePsB+QiwTjqMM4K6od/zejTuiURlcasXPvp6dOUm/nMCJp9GK8AIcg3FX0bxJN+7W
         qvyRvRhM3lUN3q3x9zTbfatzWbXurIOzH7/G8Q1D+4na3ryrzfUtYXc7+eC7xfstSrB4
         KvvCfsb2jyAez7OdTavfiFAXK4CNnUjWsW9V7ELJQ0bHu8B8J0qtITWewtihLm4KnlYI
         /ZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795273864; x=1795878664;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l77T5E697LYAr/U356kkdcfoegO4IuerXr1rgGGfgE4=;
        b=uioOQx4LerzpZ+lvMjYCPWcuCrPo5e1neCCCJZp5HP5937wt7u9i7XHalA+r2bsVAv
         H0sobUNdipmgB4RKNoq4jIO1H4YmDIJg9LgeM50NM3J/JA6RW4JMoc6dVlPIfwsMfFBT
         J94466Qgf7r58wDIBETy/oqkzuA2JLtf75F+d9NbITCuF2EKcWGrTzqNtPB6CRdvH+iB
         B3q8c2AZ81uA27DN64jqkQBpG7brLJqskKEx2hav7LmvURp6bLCE6lrJvt9LT4bk8xPd
         njEwOdAw3+myt44PxTIH3iWUpa+G5VrEG+BRAjeL8UHkJvrRjdU0WNS2M2KfXj4/UUVl
         AnqQ==
X-Gm-Message-State: APuU4Z9nAZSeVLK5kzMfVmRjpjOg3gcsGgoNx5/do6aDROX3c1yJ9cxv
	3BUpicIMf0nOWjjURZJgKAmER4zWemDewq1DNbTztA3EXUJGcfxy55Dja/D6wGIO
X-Gm-Gg: AZFdTZeTG/WbCjpcYlsy7CyJbdixm1jbRPTdLYGZkbIQAZCOASb4WMy43ZOp6p8AKP7
	W891ZJgXmyKmSdeUfsgmOGukTx+zQcr1YvsEsl8c0Y33KtKnpyByqCAa2SIDeO0vSLGQUwW7lYx
	eMn6QE7U3rE+605p3Otz5d/n1TYX13WO0QRzRyqG08NU6Ro3YSCa/pBoui4YObSi+KwuCb8dqID
	j3Ctg+TehsR0pjgu9iJxEDgbMnDYMaqDjDIU6thO79yHaaxe/yoAfPTqBG9jRlDLR1HO7em3Rqf
	m1HSnxYni2OT+cYzjfVSGXgC4f3DuwBTqNs2AS1iiiYIc6l4NRSMresLMho6QR2GZv2VO4nxf3A
	S1SVxhbJ0YrSVBJhcAASIXqUhpFJXiOtyNWo7zTkYr/Xmu8XYjCMGk1ZVFJEmFVTWwMKPCCragJ
	hOnwbdH1ENF/PtCgnEpAEkkpxrgkMQveD9lJSD3ro0r/8js0U0qFZu7wlLf0pU/lbzEplpIheCM
	9QHKYN/tr2FfB0ag9ZuAMifjXQfqjalLUlF3HTqFtP5Jxi+cPO+dvy1KG49ZgPNaH6/jCT4tu/r
	RhrlxDTtz9fSyjTybIlbz9qTjShZVA73DLnz/wEQ97pi1gbY0Z9Ixg==
X-Received: by 2002:a05:6820:3405:10b0:71b:1c49:5f1f with SMTP id 006d021491bc7-71b394f940bmr2618101eaf.19.1795273863902;
        Sat, 21 Nov 2026 07:11:03 -0800 (PST)
Received: from [127.0.0.1] ([9.234.15.210])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b3806ef20sm3923520eaf.7.2026.11.21.07.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 07:11:03 -0800 (PST)
Message-Id: <b5d203d0147715dc2b38f13be427ef8d2138321d.1795273853.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2306.v2.git.1795273853.gitgitgadget@gmail.com>
References: <pull.2306.git.1794484985.gitgitgadget@gmail.com>
	<pull.2306.v2.git.1795273853.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 21 Nov 2026 15:10:53 +0000
Subject: [PATCH v2 3/3] submodule init: copy submodule.<name>.gitdir to
 config.worktree
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

When extensions.worktreeConfig is enabled, an existing
`submodule.<name>.gitdir` setting in the repository config may have
been written by 'git submodule init' in another worktree. Reusing
that setting would cause the current worktree to use the submodule
gitdir of the other worktree.

Make 'git submodule init' copy an existing setting to the worktree
config only if it belongs to the current worktree; otherwise, generate
a new setting.

Warn when an existing setting does not match the current worktree and
is not copied to the worktree config.

Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
---
 builtin/submodule--helper.c                | 113 ++++++++++++++++++---
 t/t7425-submodule-gitdir-path-extension.sh |  69 ++++++++++++-
 2 files changed, 168 insertions(+), 14 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 2cd6f58cac..9eba2e3aeb 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -480,10 +480,45 @@ struct init_cb {
 };
 #define INIT_CB_INIT { 0 }
 
+static bool submodule_git_dir_matches_current_worktree(const char *gitdir)
+{
+	struct strbuf tmp = STRBUF_INIT;
+	struct strbuf submodule = STRBUF_INIT;
+	char *super;
+	bool matches;
+
+	if (is_absolute_path(gitdir))
+		strbuf_addstr(&submodule, gitdir);
+	else if (!repo_worktree_path_append(the_repository, &submodule,
+					    "%s", gitdir))
+		return false;
+
+	if (strbuf_normalize_path(&submodule)) {
+		strbuf_release(&submodule);
+		return false;
+	}
+
+	super = absolute_pathdup(repo_get_git_dir(the_repository));
+	matches = starts_with(relative_path(submodule.buf, super, &tmp),
+			      "modules/");
+
+	strbuf_release(&submodule);
+	strbuf_release(&tmp);
+	free(super);
+	return matches;
+}
+
+static const char submodule_mismatch_warning[] = N_(
+"config '%s' exists but was not copied to the worktree config because "
+"it does not point to a gitdir for the current worktree. If you want "
+"to keep using this setting, copy it to the worktree config."
+);
+
 static int validate_and_set_submodule_gitdir(struct strbuf *gitdir_path,
-					     const char *submodule_name)
+					     const char *submodule_name,
+					     struct worktree *wt)
 {
-	const char *value;
+	char *value = NULL;
 	char *key;
 
 	if (validate_submodule_git_dir(gitdir_path->buf, submodule_name))
@@ -491,18 +526,64 @@ static int validate_and_set_submodule_gitdir(struct strbuf *gitdir_path,
 
 	key = xstrfmt("submodule.%s.gitdir", submodule_name);
 
-	/* Nothing to do if the config already exists. */
-	if (!repo_config_get_string_tmp(the_repository, key, &value)) {
-		free(key);
-		return 0;
+	if (the_repository->repository_format_worktree_config) {
+		struct config_set cs = { 0 };
+		const char *filename = worktree_git_path(wt, "config.worktree");
+		char *tmp;
+
+		git_configset_init(&cs);
+		git_configset_add_file(&cs, filename);
+
+		/*
+		 * Nothing to do if the config already exists in the config set
+		 * for the current worktree.
+		 */
+		if (!git_configset_get(&cs, key)) {
+			git_configset_clear(&cs);
+			free(key);
+			return 0;
+		}
+
+		git_configset_clear(&cs);
+
+		/*
+		 * If the worktree config does not have this key, check the
+		 * effective value from lower-priority config scopes and copy
+		 * it to the worktree config if it belongs to the current
+		 * worktree.
+		 */
+		if (!repo_config_get_string(the_repository, key, &tmp)) {
+			bool matches =
+			  submodule_git_dir_matches_current_worktree(tmp);
+
+			if (!matches ||
+			    validate_submodule_git_dir(tmp, submodule_name)) {
+				if (!matches)
+					warning(submodule_mismatch_warning, key);
+				free(tmp);
+			} else {
+				value = tmp;
+			}
+		}
+	} else {
+		const char *value_;
+
+		/* Nothing to do if the config already exists. */
+		if (!repo_config_get_string_tmp(the_repository, key, &value_)) {
+			free(key);
+			return 0;
+		}
 	}
 
-	if (repo_config_set_worktree_gently(the_repository, key, gitdir_path->buf)) {
+	if (repo_config_set_worktree_gently(the_repository, key,
+					    value ? value : gitdir_path->buf)) {
 		free(key);
+		free(value);
 		return -1;
 	}
 
 	free(key);
+	free(value);
 	return 0;
 }
 
@@ -529,7 +610,8 @@ static void create_default_gitdir_config(const char *submodule_name)
 	strbuf_addstr(&gitdir_path, modules_dir);
 	strbuf_addstr(&gitdir_path, submodule_name);
 	if (!validate_and_set_submodule_gitdir(&gitdir_path,
-					       submodule_name))
+					       submodule_name,
+					       wt))
 		goto cleanup;
 
 	/* Case 2.1: Try URI-safe (RFC3986) encoding first, this fixes nested gitdirs */
@@ -537,7 +619,8 @@ static void create_default_gitdir_config(const char *submodule_name)
 	strbuf_addstr(&gitdir_path, modules_dir);
 	strbuf_addstr_urlencode(&gitdir_path, submodule_name, is_rfc3986_unreserved);
 	if (!validate_and_set_submodule_gitdir(&gitdir_path,
-					       submodule_name))
+					       submodule_name,
+					       wt))
 		goto cleanup;
 
 	/* Case 2.2: Try extended uppercase URI (RFC3986) encoding, to fix case-folding */
@@ -545,7 +628,8 @@ static void create_default_gitdir_config(const char *submodule_name)
 	strbuf_addstr(&gitdir_path, modules_dir);
 	strbuf_addstr_urlencode(&gitdir_path, submodule_name, is_casefolding_rfc3986_unreserved);
 	if (!validate_and_set_submodule_gitdir(&gitdir_path,
-					       submodule_name))
+					       submodule_name,
+					       wt))
 		goto cleanup;
 
 	/* Case 2.3: Try some derived gitdir names, see if one sticks */
@@ -555,7 +639,8 @@ static void create_default_gitdir_config(const char *submodule_name)
 		strbuf_addstr_urlencode(&gitdir_path, submodule_name, is_rfc3986_unreserved);
 		strbuf_addch(&gitdir_path, c);
 		if (!validate_and_set_submodule_gitdir(&gitdir_path,
-						       submodule_name))
+						       submodule_name,
+						       wt))
 			goto cleanup;
 
 		strbuf_reset(&gitdir_path);
@@ -563,7 +648,8 @@ static void create_default_gitdir_config(const char *submodule_name)
 		strbuf_addstr_urlencode(&gitdir_path, submodule_name, is_casefolding_rfc3986_unreserved);
 		strbuf_addch(&gitdir_path, c);
 		if (!validate_and_set_submodule_gitdir(&gitdir_path,
-						       submodule_name))
+						       submodule_name,
+						       wt))
 			goto cleanup;
 	}
 
@@ -580,7 +666,8 @@ static void create_default_gitdir_config(const char *submodule_name)
 	strbuf_addstr(&gitdir_path, modules_dir);
 	strbuf_addstr(&gitdir_path, hex_name_hash);
 	if (!validate_and_set_submodule_gitdir(&gitdir_path,
-					       submodule_name))
+					       submodule_name,
+					       wt))
 		goto cleanup;
 
 	/* Case 3: nothing worked, error out */
diff --git a/t/t7425-submodule-gitdir-path-extension.sh b/t/t7425-submodule-gitdir-path-extension.sh
index 3bae4c4ef1..ca55b78c07 100755
--- a/t/t7425-submodule-gitdir-path-extension.sh
+++ b/t/t7425-submodule-gitdir-path-extension.sh
@@ -328,7 +328,49 @@ test_expect_success '`git clone --recurse-submodules` respects init.defaultSubmo
 	)
 '
 
-test_expect_success 'git submodule init make gitdir relative' '
+test_expect_success 'git submodule init inherits related repository config for main' '
+	test_when_finished "rm -rf repo-clone-init-main" &&
+	git clone upstream repo-clone-init-main &&
+	(
+		cd repo-clone-init-main &&
+		git config core.repositoryformatversion 1 &&
+		git config extensions.submodulePathConfig true &&
+		git submodule init &&
+		git config submodule.sub1.gitdir >actual &&
+		echo ".git/modules/sub1" >expect &&
+		test_cmp expect actual &&
+		git config submodule.sub2.gitdir >actual &&
+		echo ".git/modules/sub2" >expect &&
+		test_cmp expect actual &&
+
+		# Modify values so that they can be distinguished from the default
+		git config submodule.sub1.gitdir .git/modules/sub1_custom &&
+		git config submodule.sub2.gitdir .git/modules/sub2_custom &&
+
+		git config extensions.worktreeConfig true &&
+		git submodule init 2>err &&
+		test_must_be_empty err &&
+		git config --worktree submodule.sub1.gitdir >actual &&
+		echo ".git/modules/sub1_custom" >expect &&
+		test_cmp expect actual &&
+		git config --worktree submodule.sub2.gitdir >actual &&
+		echo ".git/modules/sub2_custom" >expect &&
+		test_cmp expect actual &&
+
+		git worktree add wt &&
+		cd wt &&
+		git submodule init 2>err &&
+		test_grep "does not point to a gitdir for the current worktree" err &&
+		git config --worktree submodule.sub1.gitdir >actual &&
+		echo "../.git/worktrees/wt/modules/sub1" >expect &&
+		test_cmp expect actual &&
+		git config --worktree submodule.sub2.gitdir >actual &&
+		echo "../.git/worktrees/wt/modules/sub2" >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'git submodule init inherits related repository config for worktree' '
 	test_when_finished "rm -rf repo-clone-init-wt" &&
 	git clone upstream repo-clone-init-wt &&
 	(
@@ -343,6 +385,31 @@ test_expect_success 'git submodule init make gitdir relative' '
 		test_cmp expect actual &&
 		git config submodule.sub2.gitdir >actual &&
 		echo "../.git/worktrees/wt/modules/sub2" >expect &&
+		test_cmp expect actual &&
+
+		# Modify values so that they can be distinguished from the default
+		git config submodule.sub1.gitdir ../.git/worktrees/wt/modules/sub1_custom &&
+		# Use an absolute path to simulate a value written by older Git
+		git config submodule.sub2.gitdir "$(cd .. && pwd -P)/.git/worktrees/wt/modules/sub2_custom" &&
+
+		git config extensions.worktreeConfig true &&
+		git submodule init 2>err &&
+		test_must_be_empty err &&
+		git config --worktree submodule.sub1.gitdir >actual &&
+		echo "../.git/worktrees/wt/modules/sub1_custom" >expect &&
+		test_cmp expect actual &&
+		git config --worktree submodule.sub2.gitdir >actual &&
+		echo "$(cd .. && pwd -P)/.git/worktrees/wt/modules/sub2_custom" >expect &&
+		test_cmp expect actual &&
+
+		cd .. &&
+		git submodule init 2>err &&
+		test_grep "does not point to a gitdir for the current worktree" err &&
+		git config --worktree submodule.sub1.gitdir >actual &&
+		echo ".git/modules/sub1" >expect &&
+		test_cmp expect actual &&
+		git config --worktree submodule.sub2.gitdir >actual &&
+		echo ".git/modules/sub2" >expect &&
 		test_cmp expect actual
 	)
 '
-- 
gitgitgadget
