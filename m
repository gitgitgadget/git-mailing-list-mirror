Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0AF18DF73
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 09:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724924315; cv=none; b=VR2eIO6eII39k9JDMzG2xTaoIHfZn9bCuWGuj84grH5FfeMOzfJIh+RyVVv3pu/xP+05O+M+Ff6ekbpJyn0t/rzvvCPsI72l72WNG3RPwvOMX1EQAlyRNMNvJPZ8vU7GGmAPhhDY5bYhv57a/eLumFWxabu7GJxDzMHuMy1tOZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724924315; c=relaxed/simple;
	bh=qahYXYII+jZVavNixo7RM9/6p9OzUFUxcg7LxlbXBnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZimEddmq/CQVD4QjGlw7HWFKZvCJfQxQxYsR4Sf86GC0Az9xNXp6ZlQ0NavDSpRC1zu1+ySxaWnOB+8MNkNjeyAeCDuVMmVyoHTgHQFib1IjmFclJCGjT8oLeBkgOV0mMKG6kyoB9glNQ0TMVCBxgU3KMar69R9a5GhSxkbEpvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=N8gpQtfp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PzIe979U; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="N8gpQtfp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PzIe979U"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C487E1151CA6;
	Thu, 29 Aug 2024 05:38:32 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 29 Aug 2024 05:38:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724924312; x=1725010712; bh=AGYK57YO5a
	d7Rt2Wd7jwT+5niVTVTXnkVO6SBdpXWqg=; b=N8gpQtfpNoWw/5B3+KRAdcdKnY
	PkFIpyNzeiJwazMzB483MhLwUScm8eeCJoKIWz8MAT0wVK/sYYjHC2oDlBbGIHFy
	yxs6z/HdU7n2Yw54ZnKcK2GnOdr8lRLhM85DOpTosK+lytgtQXVeFG4pO1Pvw3jq
	6gM3EowqzKGhd1kIH8cOQHlFxWSD/gU2Ez8IWN1fbwDFExluTYS588LLk9WJtyT8
	Fkfx6n3XHuIXbHz8wUphwcvWLe9L5TeLIMxFhmAUkVq8EXL8FNjTZWa3WX5cbACB
	Xtjn99n70Bp0p8KXchC1DsygVcOQEs5WcFz3NYOj/xaEDtYQFFj46Sas6gfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724924312; x=1725010712; bh=AGYK57YO5ad7Rt2Wd7jwT+5niVTV
	TXnkVO6SBdpXWqg=; b=PzIe979U8RH/1lPFE1ZSqW2eDCjIi4S21ZZRkaXo3CR2
	jxOV0/nTaw0AvahmChTxeVrjFInM1eZGhEKG6iZWHQx157cYMPHQEFZklbDu9SYf
	PHKRe3tfgl0TyKZ076RToZ7g06+IQeOwclX4gC+FIhqzB1n7OfSVWYXHWhM8JF0d
	34xEAckxXHE/idonLUoNuv2M19kzmowLhXsBzAtGGGdmrfBQmLDQLdzIm9xq5JCc
	SFrtdJMSE2Y5bD5pgkLsfFy4FsZcoUydnkRIuYVkN/j4IpSkO/7AmpVSt1EplR9k
	Y9PbkWynnGTt7+nlzlVPxWRv1fQ6b2ExqUVFYgSaKQ==
X-ME-Sender: <xms:mEHQZkmlvCZsVcqFWnzgsGPX5_iq5Wudu6u_5hTiFfjJ99ZJGf4l5A>
    <xme:mEHQZj0SFPBNEYxDm41Xd94YWpdOah17fFWmjAliShh8Po9MV0g5TzFBHzhVVTvcG
    bGeSyJxwVJ6PdWDrg>
X-ME-Received: <xmr:mEHQZirqiu6kU_HULPM8iiDmZNqo7Xq_Jsv97Xvq-C5U7TF5mWvFeWN4TUP-LkuGRq2wLRAaBOHZ9_QgrgXZh1blABLjYO-MVjTm-AO2YfgoVfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptggrlhhvihhnfigrnhesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:mEHQZgncIu8bj0EPGhVB6tJhsNbd_BCD4V8feBj6koFOaJsy8Kul-A>
    <xmx:mEHQZi2KFwa0wO0GaMJK_s5cacg7-N97RIPLmXhcgAgPWgu5G-OenQ>
    <xmx:mEHQZnvfjKZT7wd0FxS-IYHl5yvFwcHVs2yRU1RwN2LE61cU2odytg>
    <xmx:mEHQZuU6xZwmmLgUs-o4czZmNYpANQQeVhd4Jk2l1P1Lkg2WuOL7kw>
    <xmx:mEHQZgDQJhDN9jEhJ_yhKndmiE2_w0IyRXxzbCmhL7sFk2DsBu1rPZGL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Aug 2024 05:38:31 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id eae01172 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Aug 2024 09:38:23 +0000 (UTC)
Date: Thu, 29 Aug 2024 11:38:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>
Subject: [PATCH 02/21] environment: make `get_git_common_dir()` accept a
 repository
Message-ID: <cdd6dd308c3e1dc0e53fe2d66f8dd0a2b4a9fb22.1724923648.git.ps@pks.im>
References: <cover.1724923648.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724923648.git.ps@pks.im>

The `get_git_common_dir()` function retrieves the path to the common
directory for `the_repository`. Make it accept a `struct repository`
such that it can work on arbitrary repositories and make it part of the
repository subsystem. This reduces our reliance on `the_repository` and
clarifies scope.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c    | 2 +-
 builtin/gc.c        | 2 +-
 builtin/rev-parse.c | 2 +-
 builtin/worktree.c  | 4 ++--
 config.c            | 2 +-
 environment.c       | 7 -------
 environment.h       | 1 -
 repository.c        | 7 +++++++
 repository.h        | 1 +
 setup.c             | 2 +-
 submodule.c         | 2 +-
 trace.c             | 2 +-
 worktree.c          | 8 ++++----
 13 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index c10697a2efb..34a371414e8 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -807,7 +807,7 @@ static void location_options_init(struct config_location_options *opts,
 	else
 		opts->options.respect_includes = opts->respect_includes_opt;
 	if (startup_info->have_repository) {
-		opts->options.commondir = get_git_common_dir();
+		opts->options.commondir = repo_get_common_dir(the_repository);
 		opts->options.git_dir = repo_get_git_dir(the_repository);
 	}
 }
diff --git a/builtin/gc.c b/builtin/gc.c
index 427faf1cfe1..0f3d74f8bd0 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -2132,7 +2132,7 @@ static int schtasks_schedule_task(const char *exec_path, enum schedule_priority
 	get_schedule_cmd(&cmd, NULL);
 
 	strbuf_addf(&tfilename, "%s/schedule_%s_XXXXXX",
-		    get_git_common_dir(), frequency);
+		    repo_get_common_dir(the_repository), frequency);
 	tfile = xmks_tempfile(tfilename.buf);
 	strbuf_release(&tfilename);
 
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 4285dc34a7b..4308a2a8549 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -1042,7 +1042,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--git-common-dir")) {
-				print_path(get_git_common_dir(), prefix, format, DEFAULT_RELATIVE_IF_SHARED);
+				print_path(repo_get_common_dir(the_repository), prefix, format, DEFAULT_RELATIVE_IF_SHARED);
 				continue;
 			}
 			if (!strcmp(arg, "--is-inside-git-dir")) {
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 41e7f6a3271..645b548bf3b 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -219,7 +219,7 @@ static void prune_worktrees(void)
 	}
 	closedir(dir);
 
-	strbuf_add_absolute_path(&main_path, get_git_common_dir());
+	strbuf_add_absolute_path(&main_path, repo_get_common_dir(the_repository));
 	/* massage main worktree absolute path to match 'gitdir' content */
 	strbuf_strip_suffix(&main_path, "/.");
 	string_list_append_nodup(&kept, strbuf_detach(&main_path, NULL));
@@ -492,7 +492,7 @@ static int add_worktree(const char *path, const char *refname,
 	strbuf_addf(&sb, "%s/gitdir", sb_repo.buf);
 	strbuf_realpath(&realpath, sb_git.buf, 1);
 	write_file(sb.buf, "%s", realpath.buf);
-	strbuf_realpath(&realpath, get_git_common_dir(), 1);
+	strbuf_realpath(&realpath, repo_get_common_dir(the_repository), 1);
 	write_file(sb_git.buf, "gitdir: %s/worktrees/%s",
 		   realpath.buf, name);
 	strbuf_reset(&sb);
diff --git a/config.c b/config.c
index 1733ba85dcd..0b87f0f9050 100644
--- a/config.c
+++ b/config.c
@@ -2213,7 +2213,7 @@ void read_early_config(config_fn_t cb, void *data)
 	opts.respect_includes = 1;
 
 	if (have_git_dir()) {
-		opts.commondir = get_git_common_dir();
+		opts.commondir = repo_get_common_dir(the_repository);
 		opts.git_dir = repo_get_git_dir(the_repository);
 	/*
 	 * When setup_git_directory() was not yet asked to discover the
diff --git a/environment.c b/environment.c
index 040b1ff1ba8..7c4a142ca25 100644
--- a/environment.c
+++ b/environment.c
@@ -228,13 +228,6 @@ int have_git_dir(void)
 		|| the_repository->gitdir;
 }
 
-const char *get_git_common_dir(void)
-{
-	if (!the_repository->commondir)
-		BUG("git environment hasn't been setup");
-	return the_repository->commondir;
-}
-
 const char *get_git_namespace(void)
 {
 	if (!git_namespace)
diff --git a/environment.h b/environment.h
index 06d37d5c82b..d778614158f 100644
--- a/environment.h
+++ b/environment.h
@@ -106,7 +106,6 @@ int have_git_dir(void);
 extern int is_bare_repository_cfg;
 int is_bare_repository(void);
 extern char *git_work_tree_cfg;
-const char *get_git_common_dir(void);
 const char *get_object_directory(void);
 char *get_index_file(void);
 char *get_graft_file(struct repository *r);
diff --git a/repository.c b/repository.c
index 6f43f2e8344..acf654d7ab6 100644
--- a/repository.c
+++ b/repository.c
@@ -98,6 +98,13 @@ const char *repo_get_git_dir(struct repository *repo)
 	return repo->gitdir;
 }
 
+const char *repo_get_common_dir(struct repository *repo)
+{
+	if (!repo->commondir)
+		BUG("git environment hasn't been setup");
+	return repo->commondir;
+}
+
 static void repo_set_commondir(struct repository *repo,
 			       const char *commondir)
 {
diff --git a/repository.h b/repository.h
index cf2172c0aa5..404435ad029 100644
--- a/repository.h
+++ b/repository.h
@@ -207,6 +207,7 @@ extern struct repository *the_repository;
 #endif
 
 const char *repo_get_git_dir(struct repository *repo);
+const char *repo_get_common_dir(struct repository *repo);
 
 /*
  * Define a custom repository layout. Any field can be NULL, which
diff --git a/setup.c b/setup.c
index 4a9c60922e7..fe4a5dfc43b 100644
--- a/setup.c
+++ b/setup.c
@@ -2068,7 +2068,7 @@ static void copy_templates(const char *option_template)
 		goto close_free_return;
 	}
 
-	strbuf_addstr(&path, get_git_common_dir());
+	strbuf_addstr(&path, repo_get_common_dir(the_repository));
 	strbuf_complete(&path, '/');
 	copy_templates_1(&path, &template_path, dir);
 close_free_return:
diff --git a/submodule.c b/submodule.c
index 97516b0fec1..c7d164a31ab 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2462,7 +2462,7 @@ void absorb_git_dir_into_superproject(const char *path,
 	} else {
 		/* Is it already absorbed into the superprojects git dir? */
 		char *real_sub_git_dir = real_pathdup(sub_git_dir, 1);
-		char *real_common_git_dir = real_pathdup(get_git_common_dir(), 1);
+		char *real_common_git_dir = real_pathdup(repo_get_common_dir(the_repository), 1);
 
 		if (!starts_with(real_sub_git_dir, real_common_git_dir))
 			relocate_single_git_dir_into_superproject(path, super_prefix);
diff --git a/trace.c b/trace.c
index 988b494a954..2d9ae1c1525 100644
--- a/trace.c
+++ b/trace.c
@@ -314,7 +314,7 @@ void trace_repo_setup(void)
 		prefix = "(null)";
 
 	trace_printf_key(&trace_setup_key, "setup: git_dir: %s\n", quote_crnl(repo_get_git_dir(the_repository)));
-	trace_printf_key(&trace_setup_key, "setup: git_common_dir: %s\n", quote_crnl(get_git_common_dir()));
+	trace_printf_key(&trace_setup_key, "setup: git_common_dir: %s\n", quote_crnl(repo_get_common_dir(the_repository)));
 	trace_printf_key(&trace_setup_key, "setup: worktree: %s\n", quote_crnl(git_work_tree));
 	trace_printf_key(&trace_setup_key, "setup: cwd: %s\n", quote_crnl(cwd));
 	trace_printf_key(&trace_setup_key, "setup: prefix: %s\n", quote_crnl(prefix));
diff --git a/worktree.c b/worktree.c
index 11335c5d9a3..0f032ccedff 100644
--- a/worktree.c
+++ b/worktree.c
@@ -72,7 +72,7 @@ static struct worktree *get_main_worktree(int skip_reading_head)
 	struct worktree *worktree = NULL;
 	struct strbuf worktree_path = STRBUF_INIT;
 
-	strbuf_add_real_path(&worktree_path, get_git_common_dir());
+	strbuf_add_real_path(&worktree_path, repo_get_common_dir(the_repository));
 	strbuf_strip_suffix(&worktree_path, "/.git");
 
 	CALLOC_ARRAY(worktree, 1);
@@ -143,7 +143,7 @@ static struct worktree **get_worktrees_internal(int skip_reading_head)
 
 	list[counter++] = get_main_worktree(skip_reading_head);
 
-	strbuf_addf(&path, "%s/worktrees", get_git_common_dir());
+	strbuf_addf(&path, "%s/worktrees", repo_get_common_dir(the_repository));
 	dir = opendir(path.buf);
 	strbuf_release(&path);
 	if (dir) {
@@ -173,7 +173,7 @@ const char *get_worktree_git_dir(const struct worktree *wt)
 	if (!wt)
 		return repo_get_git_dir(the_repository);
 	else if (!wt->id)
-		return get_git_common_dir();
+		return repo_get_common_dir(the_repository);
 	else
 		return git_common_path("worktrees/%s", wt->id);
 }
@@ -626,7 +626,7 @@ static int is_main_worktree_path(const char *path)
 
 	strbuf_add_real_path(&target, path);
 	strbuf_strip_suffix(&target, "/.git");
-	strbuf_add_real_path(&maindir, get_git_common_dir());
+	strbuf_add_real_path(&maindir, repo_get_common_dir(the_repository));
 	strbuf_strip_suffix(&maindir, "/.git");
 	cmp = fspathcmp(maindir.buf, target.buf);
 
-- 
2.46.0.421.g159f2d50e7.dirty

