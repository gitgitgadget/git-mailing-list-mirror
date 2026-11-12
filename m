Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794484993;
	b=sSQG/k5zBh3HoLCr5tRBDM14wwx4tnI1WWY4r3RLnFPfoZIcOqjPp8rQxF0ZUuMYhMgV
	 3wqFQ/cHyOi2c1idpI8LUFJdXaGBPEiYQesHNWCdhIQGTeWfTSDGabpCxrdHMK2w3tfdc
	 kW9LK+Azm1y/ekniwaRZczQe10wb9GERQCC2uYx+LHarOwX+gD3oY/Un5IaSSxuqJ0fkv
	 0PWA3F4PLeV/O63pwRWRzwQoU1+XmY7zO49tDdnst7LmpKrIAVc5BNZhkm/LFZBFWnzJg
	 Numb8bevBUn8tIi6mUe55CpVxg+El0FkFJyvGkEI8PQHYTH7gQUCF0jUXS8eZB6PBCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794484993;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=U67roYg+RznMcvVzVXoWc2NIl1At8qpzVg1bJLlVCsM=;
	b=S0NseAxXXUNj1V5ZCJpDBSbeY0Es/XRdXovkg25jdWv2BXdj6jYsDIj0HbYR7mRDFPNf
	 5LqiJzJEFfvLLrqV9gf2kriPOhRNIeWnxztBA+iEsf65JbyxeWBwT7rL9JjeJ4Ib+FzZx
	 0pXxpxHbmf3pHQ8j0hQA8mKZsyGRnnq7gENvkJrX/J8cMqmqwZb0X4l0qjEibb49O7doj
	 X/Bs4sMdRS3vihH+QkJEkQlzayApqZefhLTNuUn3AuykvPxSdKRjX4Lu0ENXoZNERgPF1
	 s9oIGIqB6VIP5L98CLLuwnbgMOMudavEAVBTfVv84R88eCOYGh/GnC+DRhzpDy9hcqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FBLJQFWP;
	arc=none smtp.remote-ip=74.125.224.44
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6E0606A8B0
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 12:03:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A6E0606A8B0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FBLJQFWP
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-67c05273c38so5123082d50.1
        for <git@vger.kernel.org>; Thu, 12 Nov 2026 04:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794484992; x=1795089792; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=U67roYg+RznMcvVzVXoWc2NIl1At8qpzVg1bJLlVCsM=;
        b=FBLJQFWP+Z8o9VZcQOD9auBb8ZJPySWJtgx6nygS4Y8OWRCtu/4xJckr/eNjkCbOph
         7tMxaeGh6UwQQDKX4Q31ArU9fvhP+6JiZbLjyr4JHzLZITJchl/Cm+m+ruK1izWidNAA
         IGQuwcGMczhYhVnhAYAO8ZsCkEfm3Fi2/W2gYub4akQuqrlYNpiMM5pUYdR+iSuG2ea7
         u7Tk8R6NBGdGQKtDvHKQIxVgL9fgdXIxcqwFQa9oz0HhYY+w/CMrzG5qHKZDseNCJNNb
         eFIHQ/16Yn40pjvgEgiA35F4pLRE5TCGfZcXz6MBTKSTPjVYiQHBazwWzt5FrCrM1KSe
         eiKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794484992; x=1795089792;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U67roYg+RznMcvVzVXoWc2NIl1At8qpzVg1bJLlVCsM=;
        b=xyUH8/jfQFOglDRKfCwCHTXQ5Dw5XoabZJUcNZtE6lHW4+r+Im1kvVdd3KrtzqRJzQ
         SiMJYCzItQTfx1WMRC39BBKC+q1dkZKGKCsUdY87QF360+kpEROHZpN6Jf3/JYQEDE9U
         Qk8lMxBsLvScxWKereMszDN3dXiHf0fl9PqBK/EheSqsAA9JTWvlsLth+zpV1LdL9pld
         1u6ZqxduLinXoc8aYCWepskgQkhIgZzKF2tV1+QdIRGvWog+Lt1uVNbdSABQs1lNoXdL
         5GTSawhDBu/Oo3FwJ8iU50ybxILfhoJZuDBeEtDlbf2UFpOd5WBnpT8Y9+9aEvyOhlB3
         2ERA==
X-Gm-Message-State: APuU4Z9NACoJHJvJ9+y/1S+2t9g2V1Bql5KDYJm8iDs55HnxtYUoykzH
	pygP+mfxy/eKTzPg49poiCI0GLE47E7zplUVevncLYKYihk90oTChJcNfykc4I4T
X-Gm-Gg: AYBFou1uN8PU5O6GA5D+fv8AS/LHS2ywnWSr2MUCJmdTytrtdOe0OS+5KriDt4tgkMG
	FP7yBLBfyO3fw+a6cUimHzmZ/891UQF5RgmIUgleNSPlDCqgCS6eDp3v4dI/jeUWp3BouqKLYQd
	FgV+x7gY5BwS16UJPQaeH1fD/czx+6e/dsXOQhIzJ2LLByOJUof4Nk64lcJ5VPTe9Bu+o5CBWT5
	snVCE8kbiFODQGQTNI/M4rwaH0cBg+Jw2c64gK59V4KIH/i4fMg7x21HP6y8rjB/KvQEPqVbP0z
	xFEglDJ0bZonDJ+2W4EO2b4JYfCOWuOTmIYoteNUHK+pM4HINOjvBO2+6kv7bR8tS4UApUHBMJf
	vUfBUJC7FjDvmhwci6+k5zYP9TdjaaSCN5hv8wlRRoI2cEaG+s9fQZDNe8PDd7j9QRKpMaCMwsn
	MLuSyfh7xf43jT9ytAhe3Xz7DNgktjxZiOFQrPprLYedSl1jR66piExa0mFT+yq0QMWWrNzoZbF
	xqscUC+fJIogVUOFxSBSMjb8zA+FkOj4v4u/mIqxyAykLvrPwbBDNPom8OFP1qqVf55MgdKdXX/
	8574+PA5PLR6h2CNgPX6nZyH3SJgwCUZ003ByLJyaX47wgG2H6EHR+SQ
X-Received: by 2002:a05:690e:43c1:b0:67c:2804:fac7 with SMTP id 956f58d0204a3-67c67f7bebbmr2810455d50.74.1794484992343;
        Thu, 12 Nov 2026 04:03:12 -0800 (PST)
Received: from [127.0.0.1] ([172.206.245.227])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f02efa477sm45745326d6.16.2026.11.12.04.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 04:03:11 -0800 (PST)
Message-Id: <cdf089b6355440e6515723a47aacbcc1605ab3f0.1794484985.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2306.git.1794484985.gitgitgadget@gmail.com>
References: <pull.2306.git.1794484985.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 12 Nov 2026 12:03:05 +0000
Subject: [PATCH 3/3] submodule init: copy submodule.<name>.gitdir to
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
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

If a repository already has gitdir settings in its repository config
when extensions.worktreeConfig is enabled, those settings belong to a
particular worktree. Make 'git submodule init' copy an existing
setting to the worktree config if it belongs to the current worktree;
otherwise, generate a new setting.

Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
---
 builtin/submodule--helper.c                | 100 ++++++++++++++++++---
 t/t7425-submodule-gitdir-path-extension.sh |  65 +++++++++++++-
 2 files changed, 151 insertions(+), 14 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f249582ca6..f34a22238f 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -480,10 +480,41 @@ struct init_cb {
 };
 #define INIT_CB_INIT { 0 }
 
+static int validate_submodule_git_dir_with_worktree(const char *gitdir)
+{
+	struct strbuf tmp = STRBUF_INIT;
+	struct strbuf submodule = STRBUF_INIT;
+	char *super;
+	int ret = 1;
+
+	if (is_absolute_path(gitdir))
+		strbuf_addstr(&submodule, gitdir);
+	else if (!repo_worktree_path_append(the_repository, &submodule,
+					    "%s", gitdir))
+		return -1;
+
+	if (strbuf_normalize_path(&submodule)) {
+		strbuf_release(&submodule);
+		return -1;
+	}
+
+	super = absolute_pathdup(repo_get_git_dir(the_repository));
+
+	if (starts_with(relative_path(submodule.buf, super, &tmp), "modules/"))
+		ret = 0;
+
+	strbuf_release(&submodule);
+	strbuf_release(&tmp);
+	free(super);
+	return ret;
+}
+
 static int validate_and_set_submodule_gitdir(struct strbuf *gitdir_path,
-					     const char *submodule_name)
+					     const char *submodule_name,
+					     struct worktree *wt)
 {
-	const char *value;
+	const char *value = gitdir_path->buf;
+	char *value_to_free = NULL;
 	char *key;
 
 	if (validate_submodule_git_dir(gitdir_path->buf, submodule_name))
@@ -491,18 +522,55 @@ static int validate_and_set_submodule_gitdir(struct strbuf *gitdir_path,
 
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
+			if (validate_submodule_git_dir_with_worktree(tmp) ||
+			    validate_submodule_git_dir(tmp, submodule_name))
+				free(tmp);
+			else
+				value = value_to_free = tmp;
+		}
+	} else {
+		/* Nothing to do if the config already exists. */
+		if (!repo_config_get_string_tmp(the_repository, key, &value)) {
+			free(key);
+			return 0;
+		}
 	}
 
-	if (repo_config_set_worktree_gently(the_repository, key, gitdir_path->buf)) {
+	if (repo_config_set_worktree_gently(the_repository, key, value)) {
 		free(key);
+		free(value_to_free);
 		return -1;
 	}
 
 	free(key);
+	free(value_to_free);
 	return 0;
 }
 
@@ -526,7 +594,8 @@ static void create_default_gitdir_config(const char *submodule_name)
 	strbuf_addstr(&gitdir_path, modules_dir);
 	strbuf_addstr(&gitdir_path, submodule_name);
 	if (!validate_and_set_submodule_gitdir(&gitdir_path,
-					       submodule_name))
+					       submodule_name,
+					       wt))
 		goto cleanup;
 
 	/* Case 2.1: Try URI-safe (RFC3986) encoding first, this fixes nested gitdirs */
@@ -534,7 +603,8 @@ static void create_default_gitdir_config(const char *submodule_name)
 	strbuf_addstr(&gitdir_path, modules_dir);
 	strbuf_addstr_urlencode(&gitdir_path, submodule_name, is_rfc3986_unreserved);
 	if (!validate_and_set_submodule_gitdir(&gitdir_path,
-					       submodule_name))
+					       submodule_name,
+					       wt))
 		goto cleanup;
 
 	/* Case 2.2: Try extended uppercase URI (RFC3986) encoding, to fix case-folding */
@@ -542,7 +612,8 @@ static void create_default_gitdir_config(const char *submodule_name)
 	strbuf_addstr(&gitdir_path, modules_dir);
 	strbuf_addstr_urlencode(&gitdir_path, submodule_name, is_casefolding_rfc3986_unreserved);
 	if (!validate_and_set_submodule_gitdir(&gitdir_path,
-					       submodule_name))
+					       submodule_name,
+					       wt))
 		goto cleanup;
 
 	/* Case 2.3: Try some derived gitdir names, see if one sticks */
@@ -552,7 +623,8 @@ static void create_default_gitdir_config(const char *submodule_name)
 		strbuf_addstr_urlencode(&gitdir_path, submodule_name, is_rfc3986_unreserved);
 		strbuf_addch(&gitdir_path, c);
 		if (!validate_and_set_submodule_gitdir(&gitdir_path,
-						       submodule_name))
+						       submodule_name,
+						       wt))
 			goto cleanup;
 
 		strbuf_reset(&gitdir_path);
@@ -560,7 +632,8 @@ static void create_default_gitdir_config(const char *submodule_name)
 		strbuf_addstr_urlencode(&gitdir_path, submodule_name, is_casefolding_rfc3986_unreserved);
 		strbuf_addch(&gitdir_path, c);
 		if (!validate_and_set_submodule_gitdir(&gitdir_path,
-						       submodule_name))
+						       submodule_name,
+						       wt))
 			goto cleanup;
 	}
 
@@ -577,7 +650,8 @@ static void create_default_gitdir_config(const char *submodule_name)
 	strbuf_addstr(&gitdir_path, modules_dir);
 	strbuf_addstr(&gitdir_path, hex_name_hash);
 	if (!validate_and_set_submodule_gitdir(&gitdir_path,
-					       submodule_name))
+					       submodule_name,
+					       wt))
 		goto cleanup;
 
 	/* Case 3: nothing worked, error out */
diff --git a/t/t7425-submodule-gitdir-path-extension.sh b/t/t7425-submodule-gitdir-path-extension.sh
index 3bae4c4ef1..36aac0f578 100755
--- a/t/t7425-submodule-gitdir-path-extension.sh
+++ b/t/t7425-submodule-gitdir-path-extension.sh
@@ -328,7 +328,47 @@ test_expect_success '`git clone --recurse-submodules` respects init.defaultSubmo
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
+		git submodule init &&
+		git config --worktree submodule.sub1.gitdir >actual &&
+		echo ".git/modules/sub1_custom" >expect &&
+		test_cmp expect actual &&
+		git config --worktree submodule.sub2.gitdir >actual &&
+		echo ".git/modules/sub2_custom" >expect &&
+		test_cmp expect actual &&
+
+		git worktree add wt &&
+		cd wt &&
+		git submodule init &&
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
@@ -343,6 +383,29 @@ test_expect_success 'git submodule init make gitdir relative' '
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
+		git submodule init &&
+		git config --worktree submodule.sub1.gitdir >actual &&
+		echo "../.git/worktrees/wt/modules/sub1_custom" >expect &&
+		test_cmp expect actual &&
+		git config --worktree submodule.sub2.gitdir >actual &&
+		echo "$(cd .. && pwd -P)/.git/worktrees/wt/modules/sub2_custom" >expect &&
+		test_cmp expect actual &&
+
+		cd .. &&
+		git submodule init &&
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
