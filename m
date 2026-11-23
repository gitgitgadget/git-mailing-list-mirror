Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795448775;
	b=gjQL3zdrzik6zDm978Sa4QRyIjYU3BhxhltFOS3ah+2edEda+Z5RdMcevMsm8cmQhwcB
	 093aELuNMyh6Q0x2UOsF/jP7fy9OA9VcPlml/3bUrByrCTaDmcx7cdF/Ca3TXZ8Mz2vdh
	 DRDvF6zbNy55uu3z4olSaVSjYnWWgpvUObbOXHofRrR8CBfXm/b2KbW+jcuEVxI7kYQSF
	 0/fypZfIyoWwc188CYAHN/Be48Jn6CHFKvndIjs9+7A72b03hvFspG1BiiRvMt/v5sC7j
	 YzSX1dmF9LxQ+cML4nUVvSYbQ4lQZ6Q0bJfCi8UiAI5e0ytXabP8oXENOt4ZUuZHfHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795448775;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LijFmVN1//UusyzfRssYpgtfs8ge/7b0/v0Om+Z85gg=;
	b=I+mVcc/JH5cECzIkPpZuzBEayY2uZoEw55yRlEgttGkC21oVynG7nIZBDpOzZg1KPDBK
	 7TanIEpr2epn7G2BpV0cHqrBs9AndmVCcI2Y95eT3Pfip69y4AO//OcnQfylWhGt/aYkz
	 abta8nAWRldvYbgw2vWzVTpI+Ziz5CI7tWMbPeZjw7ZwY4lxCKNz/McuYdywJdLCsmcHu
	 zd8SiiYebl43YwFeVU8lwH5ojkRVvpjT+D/ep3NejRBKvFn9rJhF2eBj3FwmmJnhM5UAs
	 c6p+ZDO0RG44fUq8NwfI2QkxcYqNdfRNS1KlgvLho6WiU/ej79mdoO9w5sNyNo+Uc5g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=hnpKUsCb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
Received: from sender5-op-o12.zoho.com (sender5-op-o12.zoho.com [165.173.182.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B6E606A31A
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 15:46:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06B6E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=hnpKUsCb
ARC-Seal: i=1; a=rsa-sha256; t=1795448737; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kBI/F2bvQtslhNuu/ur+jOhRugs3d9X8zSJWncaDA1jhsMKRhJ9C9BIH8P+bGi1MvfniR2xObRu30RmR0FR15d6epWCQpl/jzkaAcubikH1E0rGLY1H+6Gf+I94sjACgWNMCFZfxalJkFs142quKhabbVlTzeJA8C8Nnr6mk/UE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795448737; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=LijFmVN1//UusyzfRssYpgtfs8ge/7b0/v0Om+Z85gg=; 
	b=FhdbRl3aX8JxZsgCDy2u33L7LKesSFgX+AbFIKPpI4BP2yrX8d8r6XcTpOPu1wJrp21tRx5xzOjPLigrWXbbI9tZRVyxiW+YlbTsIj7Gx258XLyn4QgRb9ALjyZqI5dg7FiFdS/eLa3b8Zh4ESeJlKCBGaWqqCKYSfUNTmPtI2Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: a=rsa-sha256; b=hnpKUsCbwbStTYaXWq1pC8wjf5mvFH38jw2uN+Wxijss3PYRRWTlp3zsU9vGxi9C8Ik56pHxiNHNN5Fo2h1fM62CEgQkvQTP92e2ULy82plrW/eq6+ZT8i5zOcRO3EvKwY8+7mF9gDzwe34iK+E/nxd3aD72/5HnMRaijBgqShw=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=LijFmVN1//UusyzfRssYpgtfs8ge/7b0/v0Om+Z85gg=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 179544873104027.714288540372763;
	Mon, 23 Nov 2026 07:45:31 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>,
	Junio C Hamano <gitster@pobox.com>,
	Andreas Wendleder <gonsolo@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/5] submodule: support linked worktrees in recursive checkout
Date: Mon, 23 Nov 2026 17:44:55 +0200
Message-ID: <20261123154500.251056-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118163249.1693361-1-adrian.ratiu@collabora.com>
References: <20261118163249.1693361-1-adrian.ratiu@collabora.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello all,

This fixes a few submodule bugs reported by Andreas at:
https://lore.kernel.org/git/avuJBGlB3pRU3JU0@pampelmuse/

In short: when a submodule is a linked worktree of its repository
("git worktree add" inside the submodule), a recursive checkout in the
superproject either crashes with a BUG() or leaves the submodule broken.

Changes in v2:
 * 1/5: Dropped the added code comment. (Junio)
 * 2/5: Only suggest extensions.submodulePathConfig when it is disabled,
   via a helper used in all three places that refuse a git dir. (Junio)
 * 3/5: New: move the git dir setup out of submodule_move_head() to
   reduce nesting. (Junio)
 * 4/5: New: also validate the git dir after absorbing. (Junio)
 * 5/5: Simplified the worktree check and tests. Added a test for a
   submodule worktree with a nested git dir.

Regards,
Adrian

Adrian Ratiu (5):
  submodule: return an error instead of BUG() for an unexpected git dir
  submodule: only suggest submodulePathConfig when it is disabled
  submodule: move git dir setup out of submodule_move_head()
  submodule: validate the git dir after absorbing it
  submodule: accept a linked worktree as the submodule's git dir

 builtin/submodule--helper.c                |   4 +-
 submodule.c                                | 135 ++++++++++++++-------
 submodule.h                                |   7 ++
 t/t2405-worktree-submodule.sh              |  43 +++++++
 t/t7425-submodule-gitdir-path-extension.sh |  22 ++++
 t/t7450-bad-git-dotfiles.sh                |  49 ++++++++
 6 files changed, 211 insertions(+), 49 deletions(-)

Range-diff against v1:
1:  bddea5403d ! 1:  e3f5412bbd submodule: return an error instead of BUG() for an unexpected git dir
    @@ Commit message
     
      ## submodule.c ##
     @@ submodule.c: static int validate_submodule_legacy_git_dir(char *git_dir, const char *submodul
    - 		BUG("validate_submodule_git_dir() must be called with "
    - 		    "extensions.submodulePathConfig disabled.");
      
    -+	/*
    -+	 * The git dir may come from a gitfile on disk, so a mismatch is
    -+	 * not necessarily a bug in the caller.
    -+	 */
      	if (len <= suffix_len || (p = git_dir + len - suffix_len)[-1] != '/' ||
      	    strcmp(p, submodule_name))
     -		BUG("submodule name '%s' not a suffix of git dir '%s'",
2:  52e37fef11 ! 2:  fde0ceb72e submodule: only suggest submodulePathConfig when it is disabled
    @@ Metadata
      ## Commit message ##
         submodule: only suggest submodulePathConfig when it is disabled
     
    -    When a recursive checkout refuses to use a submodule's git dir, the
    -    error message ends with:
    +    When Git refuses to use a submodule's git dir, it suggests enabling
    +    extensions.submodulePathConfig, sometimes even when the extension is
    +    already enabled.
     
    -      Enabling extensions.submodulePathConfig should fix this.
    -
    -    This is printed even when the extension is already enabled, which is
    -    confusing: the user is told to turn on something that is already on.
    -
    -    Move the suggestion into a separate hint, as submodule_name_to_gitdir()
    -    already does, and only show it when the extension is disabled.
    +    We know whether it is enabled, so only suggest it when it is not. Do
    +    this in a common helper, so that all three places that refuse a git
    +    dir give the same hint and error message.
     
         Reported-by: Andreas Wendleder <gonsolo@gmail.com>
         Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
     
    + ## builtin/submodule--helper.c ##
    +@@ builtin/submodule--helper.c: static int clone_submodule(const struct module_clone_data *clone_data,
    + 		char *head = xstrfmt("%s/HEAD", sm_gitdir);
    + 		unlink(head);
    + 		free(head);
    +-		die(_("refusing to create/use '%s' in another submodule's git dir. "
    +-		      "Enabling extensions.submodulePathConfig should fix this."),
    +-		    sm_gitdir);
    ++		die_refusing_submodule_git_dir(the_repository, sm_gitdir);
    + 	}
    + 
    + 	connect_work_tree_and_git_dir(clone_data_path, sm_gitdir, 0);
    +
      ## submodule.c ##
     @@ submodule.c: int submodule_move_head(const char *path, const char *super_prefix,
    - 
      				free(dotgit);
      				if (validate_submodule_git_dir(git_dir,
    --							       sub->name) < 0)
    -+							       sub->name) < 0) {
    -+					if (!the_repository->repository_format_submodule_path_cfg)
    -+						advise(_("enabling extensions.submodulePathConfig "
    -+							 "might fix the following error."));
    - 					die(_("refusing to create/use '%s' in "
    + 							       sub->name) < 0)
    +-					die(_("refusing to create/use '%s' in "
     -					      "another submodule's git dir. "
     -					      "Enabling extensions.submodulePathConfig "
     -					      "should fix this."), git_dir);
    -+					      "another submodule's git dir."), git_dir);
    -+				}
    ++					die_refusing_submodule_git_dir(the_repository,
    ++								       git_dir);
      				free(git_dir);
      			}
      		} else {
    +@@ submodule.c: int submodule_to_gitdir(struct repository *repo,
    + 	return ret;
    + }
    + 
    ++void die_refusing_submodule_git_dir(struct repository *r, const char *git_dir)
    ++{
    ++	if (!r->repository_format_submodule_path_cfg)
    ++		advise(_("enabling extensions.submodulePathConfig might fix the "
    ++			 "following error."));
    ++
    ++	die(_("refusing to create/use '%s' in another submodule's git dir."), git_dir);
    ++}
    ++
    + void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
    + 			      const char *submodule_name)
    + {
    +@@ submodule.c: void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
    + 	}
    + 
    + 	/* validate because users might have modified the config */
    +-	if (validate_submodule_git_dir(buf->buf, submodule_name)) {
    +-		advise(_("enabling extensions.submodulePathConfig might fix the "
    +-			 "following error, if it's not already enabled."));
    +-		die(_("refusing to create/use '%s' in another submodule's "
    +-		      " git dir."), buf->buf);
    +-	}
    ++	if (validate_submodule_git_dir(buf->buf, submodule_name))
    ++		die_refusing_submodule_git_dir(r, buf->buf);
    + }
    +
    + ## submodule.h ##
    +@@ submodule.h: void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
    +  */
    + int validate_submodule_git_dir(char *git_dir, const char *submodule_name);
    + 
    ++/*
    ++ * Die because "git_dir" failed validate_submodule_git_dir(), suggesting to
    ++ * enable extensions.submodulePathConfig if it is disabled in "r".
    ++ */
    ++NORETURN void die_refusing_submodule_git_dir(struct repository *r,
    ++					     const char *git_dir);
    ++
    + /*
    +  * Make sure that the given submodule path does not follow symlinks.
    +  */
     
      ## t/t7425-submodule-gitdir-path-extension.sh ##
     @@ t/t7425-submodule-gitdir-path-extension.sh: test_expect_success 'submodule gitdir conflicts with previously encoded name (lo
    @@ t/t7425-submodule-gitdir-path-extension.sh: test_expect_success 'submodule gitdi
     +	test_grep "refusing to create/use" err &&
     +	test_grep ! "extensions.submodulePathConfig" err
     +'
    ++
    ++test_expect_success 'rejected submodule gitdir config does not suggest enabling the extension' '
    ++	git clone -c extensions.submodulePathConfig=true nested clone_bad_gitdir_config &&
    ++	git -C clone_bad_gitdir_config config set submodule.hippo.gitdir .git/modules/zoo/hippo &&
    ++	test_must_fail git -C clone_bad_gitdir_config submodule--helper gitdir hippo 2>err &&
    ++	test_grep "refusing to create/use" err &&
    ++	test_grep ! "extensions.submodulePathConfig" err
    ++'
     +
      test_done
     
-:  ---------- > 3:  6ae934f8a1 submodule: move git dir setup out of submodule_move_head()
-:  ---------- > 4:  e272a947d3 submodule: validate the git dir after absorbing it
3:  1507fddb52 ! 5:  02adab3b90 submodule: accept a linked worktree as the submodule's git dir
    @@ Metadata
      ## Commit message ##
         submodule: accept a linked worktree as the submodule's git dir
     
    -    A submodule's working tree can be a linked worktree of the submodule's
    -    repository, created e.g. with:
    +    A submodule can be checked out as a linked worktree of its repository,
    +    created e.g. with:
     
           git -C super/sub worktree add ../../wt/sub
     
         Its .git file then points to "super/.git/modules/sub/worktrees/<id>"
    -    instead of "super/.git/modules/sub". t2405 already creates such a
    -    submodule, but it doesn't test a recursive checkout, and its worktree
    -    id happens to match the submodule name.
    +    instead of "super/.git/modules/sub".
    +
    +    t2405 already creates such a submodule, but it doesn't test a recursive
    +    checkout and its worktree id happens to match the submodule name.
     
         A recursive checkout (--recurse-submodules or submodule.recurse=true)
         has two problems with this setup:
    @@ submodule.c: static void submodule_reset_index(const char *path, const char *sup
      		die(_("could not reset submodule index"));
      }
      
    +-static void setup_submodule_git_dir(const struct submodule *sub,
    +-				    const char *path, const char *super_prefix,
    +-				    const char *old_head, unsigned flags)
     +/*
    -+ * A submodule gitfile may point to a linked worktree of the submodule
    -+ * repository, i.e. "<common-dir>/worktrees/<id>", whose path does not end
    -+ * in the submodule name. Validate the common dir in that case, after making
    -+ * sure that the git dir is where "git worktree add" would have put it, and
    -+ * die if it is not.
    -+ *
    -+ * Returns:
    -+ *   1 if git_dir is a valid linked worktree.
    -+ *   0 if it is a valid submodule git dir.
    -+ *   a negative value otherwise.
    ++ * A linked worktree's git dir is "<common-dir>/worktrees/<id>", which is
    ++ * where "git worktree add" puts it. Die if it is anywhere else.
     + */
    -+static int validate_submodule_gitfile_dir(const char *git_dir,
    -+					  const char *submodule_name)
    ++static void validate_submodule_worktree_dir(const char *git_dir,
    ++					    const char *common_dir)
     +{
    -+	struct strbuf common_dir = STRBUF_INIT;
     +	struct strbuf worktree_dir = STRBUF_INIT;
    -+	int is_worktree, ret;
    -+
    -+	is_worktree = get_common_dir_noenv(&common_dir, git_dir);
    -+	if (is_worktree) {
    -+		const char *id;
    ++	const char *id;
     +
    -+		strbuf_realpath(&worktree_dir, git_dir, 1);
    -+		if (!skip_prefix(worktree_dir.buf, common_dir.buf, &id) ||
    -+		    !skip_prefix(id, "/worktrees/", &id) ||
    -+		    !*id || strchr(id, '/'))
    -+			die(_("submodule git dir '%s' is not a worktree of '%s'"),
    -+			    git_dir, common_dir.buf);
    -+	}
    -+
    -+	ret = validate_submodule_git_dir(common_dir.buf, submodule_name);
    -+	if (!ret)
    -+		ret = is_worktree;
    -+	strbuf_release(&common_dir);
    ++	strbuf_realpath(&worktree_dir, git_dir, 1);
    ++	if (!skip_prefix(worktree_dir.buf, common_dir, &id) ||
    ++	    !skip_prefix(id, "/worktrees/", &id) ||
    ++	    !*id || strchr(id, '/'))
    ++		die(_("submodule git dir '%s' is not a worktree of '%s'"),
    ++		    git_dir, common_dir);
     +	strbuf_release(&worktree_dir);
    -+	return ret;
     +}
     +
    ++/* Returns 1 if the submodule at "path" is a linked worktree, 0 otherwise. */
    ++static int setup_submodule_git_dir(const struct submodule *sub,
    ++				   const char *path, const char *super_prefix,
    ++				   const char *old_head, unsigned flags)
    + {
    ++	int is_worktree = 0;
    ++
    + 	if (old_head) {
    ++		struct strbuf common_dir = STRBUF_INIT;
    + 		char *dotgit, *git_dir;
    + 
    + 		if (!submodule_uses_gitfile(path))
    +@@ submodule.c: static void setup_submodule_git_dir(const struct submodule *sub,
    + 		dotgit = xstrfmt("%s/.git", path);
    + 		git_dir = xstrdup(read_gitfile(dotgit));
    + 		free(dotgit);
    +-		if (validate_submodule_git_dir(git_dir, sub->name) < 0)
    ++
    ++		/* A linked worktree is validated through its common dir. */
    ++		is_worktree = get_common_dir_noenv(&common_dir, git_dir);
    ++		if (is_worktree)
    ++			validate_submodule_worktree_dir(git_dir, common_dir.buf);
    ++		if (validate_submodule_git_dir(common_dir.buf, sub->name) < 0)
    + 			die_refusing_submodule_git_dir(the_repository, git_dir);
    ++		strbuf_release(&common_dir);
    + 		free(git_dir);
    + 	} else {
    + 		struct strbuf gitdir = STRBUF_INIT;
    +@@ submodule.c: static void setup_submodule_git_dir(const struct submodule *sub,
    + 		submodule_reset_index(path, super_prefix);
    + 	}
    + 
    +-	if (old_head && (flags & SUBMODULE_MOVE_HEAD_FORCE)) {
    ++	/*
    ++	 * Do not reconnect a linked worktree to the submodule's main git
    ++	 * dir: that would take over the git dir of another working tree.
    ++	 */
    ++	if (old_head && (flags & SUBMODULE_MOVE_HEAD_FORCE) && !is_worktree) {
    + 		struct strbuf gitdir = STRBUF_INIT;
    + 		submodule_name_to_gitdir(&gitdir, the_repository, sub->name);
    + 		connect_work_tree_and_git_dir(path, gitdir.buf, 1);
    + 		strbuf_release(&gitdir);
    + 	}
    ++
    ++	return is_worktree;
    + }
    + 
      /**
    -  * Moves a submodule at a given path from a given head to another new head.
    -  * For edge cases (a submodule coming into existence or removing a submodule)
     @@ submodule.c: int submodule_move_head(const char *path, const char *super_prefix,
      	struct child_process cp = CHILD_PROCESS_INIT;
      	const struct submodule *sub;
    @@ submodule.c: int submodule_move_head(const char *path, const char *super_prefix,
      	if (!is_submodule_active(the_repository, path))
      		return 0;
     @@ submodule.c: int submodule_move_head(const char *path, const char *super_prefix,
    - 				char *git_dir = xstrdup(read_gitfile(dotgit));
    + 	}
      
    - 				free(dotgit);
    --				if (validate_submodule_git_dir(git_dir,
    --							       sub->name) < 0) {
    -+				is_worktree = validate_submodule_gitfile_dir(git_dir,
    -+									     sub->name);
    -+				if (is_worktree < 0) {
    - 					if (!the_repository->repository_format_submodule_path_cfg)
    - 						advise(_("enabling extensions.submodulePathConfig "
    - 							 "might fix the following error."));
    -@@ submodule.c: int submodule_move_head(const char *path, const char *super_prefix,
    - 			submodule_reset_index(path, super_prefix);
    - 		}
    + 	if (!(flags & SUBMODULE_MOVE_HEAD_DRY_RUN))
    +-		setup_submodule_git_dir(sub, path, super_prefix, old_head, flags);
    ++		is_worktree = setup_submodule_git_dir(sub, path, super_prefix,
    ++						      old_head, flags);
    + 
    + 	prepare_submodule_repo_env(&cp.env);
      
    --		if (old_head && (flags & SUBMODULE_MOVE_HEAD_FORCE)) {
    -+		/*
    -+		 * Do not reconnect a linked worktree to the submodule's
    -+		 * main git dir: that would take over the git dir of another
    -+		 * working tree.
    -+		 */
    -+		if (old_head && (flags & SUBMODULE_MOVE_HEAD_FORCE) &&
    -+		    !is_worktree) {
    - 			struct strbuf gitdir = STRBUF_INIT;
    - 			submodule_name_to_gitdir(&gitdir, the_repository,
    - 						 sub->name);
     @@ submodule.c: int submodule_move_head(const char *path, const char *super_prefix,
      			if (is_empty_dir(path))
      				rmdir_or_warn(path);
    @@ t/t2405-worktree-submodule.sh: test_expect_success 'submodule is checked out aft
      	test_grep "file1 updated" out
      '
      
    ++# Helper to verify "sub" is still the same worktree, checked out at HEAD:sub.
    ++test_submodule_worktree_is_kept () {
    ++	test_cmp expect-gitfile submodule-worktree/sub/.git &&
    ++	git -C submodule-worktree rev-parse HEAD:sub >expect-head &&
    ++	git -C submodule-worktree/sub rev-parse HEAD >actual-head &&
    ++	test_cmp expect-head actual-head
    ++}
    ++
     +test_expect_success 'checkout --recurse-submodules accepts a submodule worktree' '
     +	git -C main worktree add "$base_path/submodule-worktree" "$rev1_hash_main" &&
     +	git -C main/sub worktree add "$base_path/submodule-worktree/sub" "$rev1_hash_sub" &&
     +	cat submodule-worktree/sub/.git >expect-gitfile &&
     +	# the worktree id must not end in the submodule name
     +	test_grep "/worktrees/sub1$" expect-gitfile &&
    -+	git -C main/sub rev-parse HEAD >expect-head-main &&
     +	git -C submodule-worktree checkout --recurse-submodules "$(git -C main rev-parse HEAD)" &&
    -+	git -C submodule-worktree rev-parse HEAD:sub >expect-head &&
    -+	git -C submodule-worktree/sub rev-parse HEAD >actual-head &&
    -+	test_cmp expect-head actual-head &&
    -+	cat submodule-worktree/sub/.git >actual-gitfile &&
    -+	test_cmp expect-gitfile actual-gitfile &&
    -+	git -C main/sub rev-parse HEAD >actual-head-main &&
    -+	test_cmp expect-head-main actual-head-main
    ++	test_submodule_worktree_is_kept
     +'
     +
     +test_expect_success 'checkout --recurse-submodules accepts a submodule worktree with submodulePathConfig' '
    @@ t/t2405-worktree-submodule.sh: test_expect_success 'submodule is checked out aft
     +	test_config -C main extensions.submodulePathConfig true &&
     +	test_config -C main submodule.sub.gitdir .git/modules/sub &&
     +	git -C submodule-worktree checkout --recurse-submodules "$rev1_hash_main" &&
    -+	git -C submodule-worktree/sub rev-parse --short HEAD >actual-head &&
    -+	echo "$rev1_hash_sub" >expect-head &&
    -+	test_cmp expect-head actual-head &&
    -+	cat submodule-worktree/sub/.git >actual-gitfile &&
    -+	test_cmp expect-gitfile actual-gitfile &&
    -+	git -C main/sub rev-parse HEAD >actual-head-main &&
    -+	test_cmp expect-head-main actual-head-main
    ++	test_submodule_worktree_is_kept
    ++'
    ++
    ++test_expect_success 'checkout --recurse-submodules accepts a submodule worktree with a nested git dir' '
    ++	# a nested .git directory makes the checkout absorb it first
    ++	git clone origin/sub submodule-worktree/sub/inner &&
    ++	git -C submodule-worktree/sub submodule add ./inner inner &&
    ++	git -C submodule-worktree checkout -f --recurse-submodules "$(git -C main rev-parse HEAD)" &&
    ++	test_submodule_worktree_is_kept
     +'
     +
     +test_expect_success 'checkout --recurse-submodules removes a submodule worktree' '
    @@ t/t2405-worktree-submodule.sh: test_expect_success 'submodule is checked out aft
     
      ## t/t7450-bad-git-dotfiles.sh ##
     @@ t/t7450-bad-git-dotfiles.sh: test_expect_success 'checkout --recurse-submodules rejects gitfile not matching
    - 	test_grep ! "BUG" err
    + 	test_cmp expect mismatched_absorbed/thing1/.git
      '
      
     +test_expect_success 'checkout --recurse-submodules rejects gitfile pointing to a forged worktree' '

base-commit: e1ec09b23c8e0deb21a0b95ac5996422277395d4
-- 
2.56.1

