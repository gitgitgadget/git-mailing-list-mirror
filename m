Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0102FFDEA
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 14:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774707146; cv=none; b=cLrLs2lh+ylnGPJV1DX/0dCfvHJm/G5Z+tneCx+00kD1jP7QXS1zYdI69aFvpCe1nRuWSpllGBMoCbLF4FXrV/M6VSNPx9zN+N+NGfKl7mOnDC0uvtWpk2iuFCypf1lgIFE0zsTdgkkExca3OusQmrwAq71NvaHmkZVTKvnObWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774707146; c=relaxed/simple;
	bh=nR4akSGDQccakr7fKup/tcpGWAa3XKZYvSD5I300Hz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f7A4lpMsWGoAc8JHFurj6xFPDkYplHxPizKXP7RU8+2fjJmCKJWh3RwlwpVDBbGFsMTs8ZVAhkm9bVtDZR/t7Po3WOXfy1UTnK/uMLv/h5lLmUhTlBDLsv1jw7EtYzLUv9SMwGpzC1X8JVrYHxJo9b5bsM+mSKTDIj+BK8vMn6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHYb6so4; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHYb6so4"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b0ba3bfe16so25072675ad.1
        for <git@vger.kernel.org>; Sat, 28 Mar 2026 07:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774707144; x=1775311944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQ0CBoq+MyhdQkwgzNhmSTRo4pTlUjqNTRUqfFtOG7Y=;
        b=PHYb6so492+DVpOHzlHmSlps5tKeOCcoKgsJNEqGgiBdTk09vOD7F2ukDHMQdgC2sw
         QDDeqizCFHhCLuZn7MZqEBGm4AX7tN88HDHWtS/lfLHRpdtJ4xu+Q32Gpx9zYSzAL+u2
         1S0qzMkrUztCpboxBhKRRS3QBBHyOKJ7dye19SrFMhcoI9yHusIm9jNRFmMW8apmA2Uw
         Ea6/DjDQr0eDCNtZdxcPy6zvZfJvALudHL6zK2pyb77QVFhobxGAeOyiCdOoRuNyZodN
         sAxjT5LCikfh4NLvGOAR9J1t9pnM4EYtv+/0Cj80Y26XR52dIdvOVtESQG/AekJB0sdj
         EgWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774707144; x=1775311944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cQ0CBoq+MyhdQkwgzNhmSTRo4pTlUjqNTRUqfFtOG7Y=;
        b=n/znpMBzU5+ws97ymz8kuHaxfHjLVnUVB9lyq/rbEumuyg2pEK32gcWqBpC+KfZwgy
         cWqM1EYd1nHgNj+ncwXX57u4CDvTgbybluNYAlSoVScpaz/jr6hJtjdVcP3VpQ0TMVrf
         Ui2aQNY7Ms0WrYii/4KwJ+B8Rz8V9/iiiyTlRL2b5dynxyUhnYK2yFfm7Wlz7FPx+VQh
         1KssRqzZ2WFxWObsH5MtM9UfpjOzcGblbK7WxP67dCCMVkApOWEV1ojDp4kWMsxmsetw
         rILXTaoEm0MpdkkdLPysSlVI7yyEW3KGtOS5F3XLw1y3mqaYv79j55ughym5GA6ZaYxg
         9EcA==
X-Gm-Message-State: AOJu0Ywkq58iET1lUIapY8k4uchAtkXA/XJ2NC6IbGHMt0/RtFjPFtDR
	2aiGU+wI6Z/+cP6Egxov3hLAq5CPam9feUSAlPsHikf6gKH2nqBao/veQwNjpQ==
X-Gm-Gg: ATEYQzzsATKt+AUGdVcRt9fPOpR3g426Uf5stWUhas84L9nR4ZdtZLOsPMVdNJy9fPe
	ZPsRoMiGO5ulthNp3urv35DtAGdmQYp2UHH0bUFFb7sw3lu1ALFc260iiBe8V/mzVYdCEh+w4H6
	tyzNTICmgS7HH8cJxBTLijz5Vk26WIZ5pa7XDRALz61SMnuZBkKgSs2G2CyyzcZcKMmnNi6Az7C
	dVs7vRaymX4bej21Gi9ZZEP/1cThfSktKnM5pFdx6yt1Y+U42FQYUKbiWJlzC64bPm2FBPRHMHD
	M+XRUfZy15mb7EWh1j00gvIyk21/00HodYMjYdaYWP1mHeCB5cg3lHkPX2jNYgjgcNaX6ZOIvHe
	6okD3axww+K2R7dSL4AqXVXsexjFJCw+11E8wH4/bVI8GKQ9B8HaXqDPwBtWSQ8G/Lzt2sJtXsg
	pP6dB0XRYqZYBFAwcyt9yyaus78L9hkNA/BeKwqG4k4A==
X-Received: by 2002:a17:902:f689:b0:2b0:91e6:bc18 with SMTP id d9443c01a7336-2b0ce57c93cmr63550715ad.14.1774707144026;
        Sat, 28 Mar 2026 07:12:24 -0700 (PDT)
Received: from Shreyansh-PC ([2401:4900:88eb:4aec:1b3c:5de4:c8b:1b79])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427a27f2sm33173855ad.67.2026.03.28.07.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 07:12:23 -0700 (PDT)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH v2 0/5] refs: reduce reliance on the_repository global state
Date: Sat, 28 Mar 2026 19:39:31 +0530
Message-ID: <20260328141146.1095115-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325164833.1216577-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260325164833.1216577-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series continues the effort to reduce reliance on the_repository
global state by making repository context explicit across the refs
subsystem. The patches focus on passing struct repository through various
ref helpers and backends, and replacing uses of global state such as
the_repository and the_hash_algo with the appropriate repository instance.

Patch 1/5: Making branch name helper functions (copy_branchname(),
check_branch_ref(), validate_branchname(), and validate_new_branchname())
repository-aware. (built on top of jw/object-name-bitset-to-enum)

Patch 2/5: Updating get_files_ref_lock_timeout_ms() to take a repository
and propagating it through files-backend, including callback paths.

Patch 3/5: Replacing uses of the_hash_algo in refs.c with the hash
algorithm from the appropriate repository.

Patch 4/5: Removing remaining uses of the_repository in reftable-backend.c
where a repository instance is already available.

Patch 5/5: Replacing the single instance of the_repository in
packed-backend.c, thus dropping the USE_THE_REPOSITORY_VARIABLE macro.

Shreyansh Paliwal (5):
  refs: make branchname helpers repository aware
  refs: make get_files_ref_lock_timeout_ms() repostory aware
  refs: remove the_hash_algo global state
  refs/reftable-backend: drop uses of the_repository
  refs/packed-backend: use ref_store->repo instead of the_repository

 branch.c                   | 15 ++++++++-------
 branch.h                   |  5 +++--
 builtin/branch.c           | 14 +++++++-------
 builtin/check-ref-format.c |  3 ++-
 builtin/checkout.c         |  6 +++---
 builtin/merge.c            |  2 +-
 builtin/worktree.c         | 10 +++++-----
 refs.c                     | 27 ++++++++++++---------------
 refs.h                     |  4 ++--
 refs/files-backend.c       | 19 +++++++++++++------
 refs/packed-backend.c      |  3 +--
 refs/refs-internal.h       |  2 +-
 refs/reftable-backend.c    |  6 +++---
 13 files changed, 61 insertions(+), 55 deletions(-)

---
Changes in v2:
 - Made struct repository the first argument in function parameters.

Range-diff against v1:
1:  68ca12412b ! 1:  c0182252c4 refs: make branchname helpers repository aware
    @@ branch.c: int read_branch_desc(struct strbuf *buf, const char *branch_name)
       * Fill ref with the full refname for the branch.
       */
     -int validate_branchname(const char *name, struct strbuf *ref)
    -+int validate_branchname(const char *name, struct strbuf *ref, struct repository *repo)
    ++int validate_branchname(struct repository *repo, const char *name, struct strbuf *ref)
      {
     -	if (check_branch_ref(ref, name)) {
    -+	if (check_branch_ref(ref, name, repo)) {
    ++	if (check_branch_ref(repo, ref, name)) {
      		int code = die_message(_("'%s' is not a valid branch name"), name);
      		advise_if_enabled(ADVICE_REF_SYNTAX,
      				  _("See 'git help check-ref-format'"));
    @@ branch.c: const char *branch_checked_out(const char *refname)
       * Fill ref with the full refname for the branch.
       */
     -int validate_new_branchname(const char *name, struct strbuf *ref, int force)
    -+int validate_new_branchname(const char *name, struct strbuf *ref, int force,
    -+			    struct repository *repo)
    ++int validate_new_branchname(struct repository *repo, const char *name,
    ++			    struct strbuf *ref, int force)
      {
      	const char *path;
     -	if (!validate_branchname(name, ref))
    -+	if (!validate_branchname(name, ref, repo))
    ++	if (!validate_branchname(repo, name, ref))
      		return 0;

      	if (!force)
    @@ branch.c: void create_branch(struct repository *r,
      	if (clobber_head_ok ?
     -			  validate_branchname(name, &ref) :
     -			  validate_new_branchname(name, &ref, force)) {
    -+			  validate_branchname(name, &ref, r) :
    -+			  validate_new_branchname(name, &ref, force, r)) {
    ++			  validate_branchname(r, name, &ref) :
    ++			  validate_new_branchname(r, name, &ref, force)) {
      		forcing = 1;
      	}

    @@ branch.h: const char *branch_checked_out(const char *refname);
       * Fill ref with the full refname for the branch.
       */
     -int validate_branchname(const char *name, struct strbuf *ref);
    -+int validate_branchname(const char *name, struct strbuf *ref, struct repository *repo);
    ++int validate_branchname(struct repository *repo, const char *name, struct strbuf *ref);

      /*
       * Check if a branch 'name' can be created as a new branch; die otherwise.
    @@ branch.h: int validate_branchname(const char *name, struct strbuf *ref);
       * Fill ref with the full refname for the branch.
       */
     -int validate_new_branchname(const char *name, struct strbuf *ref, int force);
    -+int validate_new_branchname(const char *name, struct strbuf *ref, int force,
    -+			    struct repository *repo);
    ++int validate_new_branchname(struct repository *repo, const char *name,
    ++			    struct strbuf *ref, int force);

      /*
       * Remove information about the merge state on the current
    @@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int fo
      		int flags = 0;

     -		copy_branchname(&bname, argv[i], allowed_interpret);
    -+		copy_branchname(&bname, argv[i], allowed_interpret, the_repository);
    ++		copy_branchname(the_repository, &bname, argv[i], allowed_interpret);
      		free(name);
      		name = mkpathdup(fmt, bname.buf);

    @@ builtin/branch.c: static void copy_or_rename_branch(const char *oldname, const c
      	struct worktree **worktrees = get_worktrees();

     -	if (check_branch_ref(&oldref, oldname)) {
    -+	if (check_branch_ref(&oldref, oldname, the_repository)) {
    ++	if (check_branch_ref(the_repository, &oldref, oldname)) {
      		/*
      		 * Bad name --- this could be an attempt to rename a
      		 * ref that we used to allow to be created by accident.
    @@ builtin/branch.c: static void copy_or_rename_branch(const char *oldname, const c
      	 */
      	if (!strcmp(oldname, newname))
     -		validate_branchname(newname, &newref);
    -+		validate_branchname(newname, &newref, the_repository);
    ++		validate_branchname(the_repository, newname, &newref);
      	else
     -		validate_new_branchname(newname, &newref, force);
    -+		validate_new_branchname(newname, &newref, force, the_repository);
    ++		validate_new_branchname(the_repository, newname, &newref, force);

      	reject_rebase_or_bisect_branch(worktrees, oldref.buf);

    @@ builtin/branch.c: int cmd_branch(int argc,
      			branch_name = head;
      		} else if (argc == 1) {
     -			copy_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
    -+			copy_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL, the_repository);
    ++			copy_branchname(the_repository, &buf, argv[0], INTERPRET_BRANCH_LOCAL);
      			branch_name = buf.buf;
      		} else {
      			die(_("cannot edit description of more than one branch"));
    @@ builtin/branch.c: int cmd_branch(int argc,
      			branch = branch_get(NULL);
      		else if (argc == 1) {
     -			copy_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
    -+			copy_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL, the_repository);
    ++			copy_branchname(the_repository, &buf, argv[0], INTERPRET_BRANCH_LOCAL);
      			branch = branch_get(buf.buf);
      		} else
      			die(_("too many arguments to set new upstream"));
    @@ builtin/branch.c: int cmd_branch(int argc,
      			branch = branch_get(NULL);
      		else if (argc == 1) {
     -			copy_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
    -+			copy_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL, the_repository);
    ++			copy_branchname(the_repository, &buf, argv[0], INTERPRET_BRANCH_LOCAL);
      			branch = branch_get(buf.buf);
      		} else
      			die(_("too many arguments to unset upstream"));
    @@ builtin/check-ref-format.c: static int check_ref_format_branch(const char *arg)

      	setup_git_directory_gently(&nongit);
     -	if (check_branch_ref(&sb, arg) ||
    -+	if (check_branch_ref(&sb, arg, the_repository) ||
    ++	if (check_branch_ref(the_repository, &sb, arg) ||
      	    !skip_prefix(sb.buf, "refs/heads/", &name))
      		die("'%s' is not a valid branch name", arg);
      	printf("%s\n", name);
    @@ builtin/checkout.c: static void setup_branch_path(struct branch_info *branch)
      		repo_get_oid_committish(the_repository, branch->name, &branch->oid);

     -	copy_branchname(&buf, branch->name, INTERPRET_BRANCH_LOCAL);
    -+	copy_branchname(&buf, branch->name, INTERPRET_BRANCH_LOCAL, the_repository);
    ++	copy_branchname(the_repository, &buf, branch->name, INTERPRET_BRANCH_LOCAL);
      	if (strcmp(buf.buf, branch->name)) {
      		free(branch->name);
      		branch->name = xstrdup(buf.buf);
    @@ builtin/checkout.c: static int checkout_main(int argc, const char **argv, const

      		if (opts->new_branch_force)
     -			opts->branch_exists = validate_branchname(opts->new_branch, &buf);
    -+			opts->branch_exists = validate_branchname(opts->new_branch, &buf, the_repository);
    ++			opts->branch_exists = validate_branchname(the_repository, opts->new_branch, &buf);
      		else
      			opts->branch_exists =
     -				validate_new_branchname(opts->new_branch, &buf, 0);
    -+				validate_new_branchname(opts->new_branch, &buf, 0, the_repository);
    ++				validate_new_branchname(the_repository, opts->new_branch, &buf, 0);
      		strbuf_release(&buf);
      	}

    @@ builtin/merge.c: static void merge_name(const char *remote, struct strbuf *msg)
      	int len, early;

     -	copy_branchname(&bname, remote, 0);
    -+	copy_branchname(&bname, remote, 0, the_repository);
    ++	copy_branchname(the_repository, &bname, remote, 0);
      	remote = bname.buf;

      	oidclr(&branch_head, the_repository->hash_algo);
    @@ builtin/worktree.c: static int make_worktree_orphan(const char * ref, const stru
      	struct child_process cp = CHILD_PROCESS_INIT;

     -	validate_new_branchname(ref, &symref, 0);
    -+	validate_new_branchname(ref, &symref, 0, the_repository);
    ++	validate_new_branchname(the_repository, ref, &symref, 0);
      	strvec_pushl(&cp.args, "symbolic-ref", "HEAD", symref.buf, NULL);
      	if (opts->quiet)
      		strvec_push(&cp.args, "--quiet");
    @@ builtin/worktree.c: static int add_worktree(const char *path, const char *refnam

      	/* is 'refname' a branch or commit? */
     -	if (!opts->detach && !check_branch_ref(&symref, refname) &&
    -+	if (!opts->detach && !check_branch_ref(&symref, refname, the_repository) &&
    ++	if (!opts->detach && !check_branch_ref(the_repository, &symref, refname) &&
      	    refs_ref_exists(get_main_ref_store(the_repository), symref.buf)) {
      		is_branch = 1;
      		if (!opts->force)
    @@ builtin/worktree.c: static void print_preparing_worktree_line(int detach,
      	} else {
      		struct strbuf s = STRBUF_INIT;
     -		if (!detach && !check_branch_ref(&s, branch) &&
    -+		if (!detach && !check_branch_ref(&s, branch, the_repository) &&
    ++		if (!detach && !check_branch_ref(the_repository, &s, branch) &&
      		    refs_ref_exists(get_main_ref_store(the_repository), s.buf))
      			fprintf_ln(stderr, _("Preparing worktree (checking out '%s')"),
      				  branch);
    @@ builtin/worktree.c: static char *dwim_branch(const char *path, char **new_branch
      	struct strbuf ref = STRBUF_INIT;

     -	branch_exists = !check_branch_ref(&ref, branchname) &&
    -+	branch_exists = !check_branch_ref(&ref, branchname, the_repository) &&
    ++	branch_exists = !check_branch_ref(the_repository, &ref, branchname) &&
      			refs_ref_exists(get_main_ref_store(the_repository),
      					ref.buf);
      	strbuf_release(&ref);
    @@ builtin/worktree.c: static int add(int ac, const char **av, const char *prefix,

      		if (!opts.force &&
     -		    !check_branch_ref(&symref, new_branch) &&
    -+		    !check_branch_ref(&symref, new_branch, the_repository) &&
    ++		    !check_branch_ref(the_repository, &symref, new_branch) &&
      		    refs_ref_exists(get_main_ref_store(the_repository), symref.buf))
      			die_if_checked_out(symref.buf, 0);
      		strbuf_release(&symref);

      ## refs.c ##
     @@ refs.c: static char *substitute_branch_name(struct repository *r,
    + 	return NULL;
      }

    - void copy_branchname(struct strbuf *sb, const char *name,
    --		     enum interpret_branch_kind allowed)
    -+		     enum interpret_branch_kind allowed,
    -+		     struct repository *repo)
    +-void copy_branchname(struct strbuf *sb, const char *name,
    ++void copy_branchname(struct repository *repo, struct strbuf *sb, const char *name,
    + 		     enum interpret_branch_kind allowed)
      {
      	int len = strlen(name);
      	struct interpret_branch_name_options options = {
    @@ refs.c: void copy_branchname(struct strbuf *sb, const char *name,
      }

     -int check_branch_ref(struct strbuf *sb, const char *name)
    -+int check_branch_ref(struct strbuf *sb, const char *name, struct repository *repo)
    ++int check_branch_ref(struct repository *repo, struct strbuf *sb, const char *name)
      {
      	if (startup_info->have_repository)
     -		copy_branchname(sb, name, INTERPRET_BRANCH_LOCAL);
    -+		copy_branchname(sb, name, INTERPRET_BRANCH_LOCAL, repo);
    ++		copy_branchname(repo, sb, name, INTERPRET_BRANCH_LOCAL);
      	else
      		strbuf_addstr(sb, name);


      ## refs.h ##
     @@ refs.h: char *repo_default_branch_name(struct repository *r, int quiet);
    +  * If "allowed" is non-zero, restrict the set of allowed expansions. See
       * repo_interpret_branch_name() for details.
       */
    - void copy_branchname(struct strbuf *sb, const char *name,
    --		     enum interpret_branch_kind allowed);
    -+		     enum interpret_branch_kind allowed,
    -+		     struct repository *repo);
    +-void copy_branchname(struct strbuf *sb, const char *name,
    ++void copy_branchname(struct repository *repo, struct strbuf *sb, const char *name,
    + 		     enum interpret_branch_kind allowed);

      /*
    -  * Like copy_branchname() above, but confirm that the result is
     @@ refs.h: void copy_branchname(struct strbuf *sb, const char *name,
       *
       * The return value is "0" if the result is valid, and "-1" otherwise.
       */
     -int check_branch_ref(struct strbuf *sb, const char *name);
    -+int check_branch_ref(struct strbuf *sb, const char *name, struct repository *repo);
    ++int check_branch_ref(struct repository *repo, struct strbuf *sb, const char *name);

      /*
       * Similar for a tag name in refs/tags/.
2:  9bfbfc38b8 = 2:  857a8c40fe refs: make get_files_ref_lock_timeout_ms() repostory aware
3:  6f9854845e = 3:  46d5272aec refs: remove the_hash_algo global state
4:  1c02f780d1 = 4:  11aa886259 refs/reftable-backend: drop uses of the_repository
5:  33946503e1 = 5:  c763732964 refs/packed-backend: use ref_store->repo instead of the_repository
--
2.53.0

