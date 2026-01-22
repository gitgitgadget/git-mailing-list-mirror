Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5B8392B72
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 15:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769095066; cv=pass; b=ttRYO39y9qPDB4RN3XCvTYVA5mxlsYbphc/3R+Jd2B3nGgMvQZRbj3Robj61hFOKvnN6Zj6gga46+Aouci4dMQoe645S+eT+CW6grVBCn3Re4IQ2/XwsUEaGa0d4ww1XaTp95X2vzgyQz0t7HjLueDqmNYYgbRZFNQK1OejTV3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769095066; c=relaxed/simple;
	bh=YBF9nTcOyeOKXRbT+/xNTQTYbScr9y73s7hvHRlHmIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GnnB4x2uKR+fLqufMdZcl/82hx7zlcq6Ix4gcK90tXPxrk4/RaOcx1vMKOScettXwuc3aASDFqlGTvZi08atnbcG/so3ZcqHT3lvMeyH3NRzwBmCxBKwadwuSdmbHqHiujLoC0pCe4pOUjqjkBxTzj3K8Kz9I6tfat0qhO5CBzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZAX6W3w0; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAX6W3w0"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-11f36012fb2so1808845c88.1
        for <git@vger.kernel.org>; Thu, 22 Jan 2026 07:17:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769095063; cv=none;
        d=google.com; s=arc-20240605;
        b=bJqeLumQiOmuv+myVLHwo1CRi9b5Mkik1bM19NMynUWVN/BcgiV7Ptp4wDcLqCmtGA
         RxEnVaAvHasGk4IKu0GcW8S06qieK6s550CxYyrgJFCcHd8bRCFsr1V4Q+Jj00+mCjQL
         NAwttENE275++2SubMBJj75tvkM184NInFPVpU0ooRaqgph8qQ4p98HJn8Fhfo2TVkPI
         X0499wyvWe0K+YYa8xORmGGzqkbTdfFeV7o7iNvwEET1PGfoyzwLOvJitZ9r6QLSjKZT
         7Hd4ByYNwue21XQIgxIAfZsZUsNMa4VhqTHri1d8iH7Eynui8yFcx5WDcVz900BPCvfb
         iEAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xIeBNaXjWXtY+LyrbXAm0Qw8+wOtRdc/jDmCaYO0Ax0=;
        fh=Oomd9UZxwatfJrvTLtxnKYh6qyfPcZbkPkPBNqnBf4Y=;
        b=ACTHNSS3ZFuClQM23ufj/xKwaWtp2cJUmOp/sBpVNeDFzICYub6wBiW2voqKYSRGgT
         O351M0SNKISp5x3bUSSo626syF4Ns+bLRujbuKePNd2ZUoYbann6zz4rkkmxTf88INeu
         wU+9XnikSpTwG0CmfKHt5l5fXGF9utTq32PQDrrHxyewwLTYOS1ZOPO/vQ1vGoybjpNn
         RSOwNkIS0RssJ3TdqihVM8eX2rawrCYtmoveZRc/etrbtOSnZJMjm5/FT+e4ov74AQFV
         ei8D7DiCcBer/GA3jG/FF4CuFngg1f+X5aMVW6eiQMud6aQtfXFNU7sD8eBLGsAuhDKv
         nvWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769095063; x=1769699863; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xIeBNaXjWXtY+LyrbXAm0Qw8+wOtRdc/jDmCaYO0Ax0=;
        b=ZAX6W3w0lQzdehoOKelWz4jpVZop1U0jaWdbWLTTmctvsMm4GysAGqKD19QEqM1UU1
         AtO+2ODQeJqLusMq17u5rQyY0NJ727ysAOh4ExP8fSv40Lws6bQAPxcTHWzyNH8neYH5
         IdlcDeBMlpXrDrEtGS3oGkekIDOJhUTV5mv+XM/KK3sVAqpngLzFRxgQrYVs/ESEtZ5Q
         n2uAUuavgmro+rSo94MyIbs7KanxhdzbXguoJgGw5MntwPfDcUhE2zDuMLU4wcRezkoN
         Wh8yPWCocC9nPFjf9Yu7GNe7U+K1f/uoVMGVYpMqkZnmt5E9g9FSb/xzGyzo32ii2tJs
         9JlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769095063; x=1769699863;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIeBNaXjWXtY+LyrbXAm0Qw8+wOtRdc/jDmCaYO0Ax0=;
        b=EyGlDSY30QA8gNYoRTveTl6kaZ6FIIVrMQ4cOjo90CEE8pibKommOtiK0hSNyITL9P
         SQJDNFJdaLhon4cjvOYjlwV5IqtFqoFmZrVkWqyXjMj50j2kHQ9NJIu5UaHB55lW3QtT
         WTqqBQ7iQlFvCD7yypTXs6xGUiWsC3DyvUa6Wqi6Uaev1sBGBpRv+C6w9fqOnc81Ymno
         upDgHg1z3KekOw8NOTpe0wvf7pEYDSu2omZywfX5lGF5rtahqTLmbgOidPICZADKDZ5n
         0lNFQe4j0Lx8koUpae6Hf88MUxcLNVitIgROOb0yk03lmKmd7IQ54R2Ig1YjZbu1q/kR
         Tehg==
X-Gm-Message-State: AOJu0YyxZipZxkxfAUa7LlX4dj2AdvTpWY0qsUmDoYxQlbRMFnX8zkPW
	AP56G9WANDlaV0kOnWUY5ySoVpQ25jc07AIz30qCTLK8HWbaaZvgsgdz/lLoxcPqR+QWsBCwyOx
	EyquSa2QtQ8uKCOYK0M2Muj9XPTq1dx8=
X-Gm-Gg: AZuq6aLJIOHb1Vjy3rKNiSorT2Q3wDi1y/ofkuvums7ngYy8RK37+AeJHY8ozjugmeN
	5ODUUu6eL4CkGKdRGrKUPaT+njLunc9MAtpVIp7AziciQOLNlUky5sO9DL/Rt+UbI15iJ5bDy01
	m6r6iqrk6+PF/arwOaht8O1Vr8aYqOQaQ/A3GJfe3xf5s1k9LT4PbnCBLNErjLwzzKnxDXoRNCE
	TLzri0cj7DHjVAkUtgLfhNInaZ3CB65ej3Acy4kOUzHnvulYrS+fo8uGnpmr0P13RAl1HU0qlc=
X-Received: by 2002:a05:7022:f94:b0:11b:99a2:9082 with SMTP id
 a92af1059eb24-1244b32234emr13299664c88.15.1769095063141; Thu, 22 Jan 2026
 07:17:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1768681947.git.belkid98@gmail.com> <fd95169de42891452b430814476d78c706e4a7e2.1768681947.git.belkid98@gmail.com>
 <87zf65j152.fsf@iotcl.com>
In-Reply-To: <87zf65j152.fsf@iotcl.com>
From: Bello Olamide <belkid98@gmail.com>
Date: Thu, 22 Jan 2026 16:17:44 +0100
X-Gm-Features: AZwV_QhMmXt5g9MPK1LX_MGOVPOTGi-TW7zuhTGFKvgbWcS84BhF88lU52FkSoc
Message-ID: <CAD=f0L97wxzgEdo3nDmFVKTdqxMCVRL2aV6kGgEM_Jh=J9cbHg@mail.gmail.com>
Subject: Re: [Outreachy PATCH v3 2/3] environment: environment: stop using
 core.sparseCheckout globally
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, phillip.wood123@gmail.com, gitster@pobox.com, 
	christian.couder@gmail.com, usmanakinyemi202@gmail.com, 
	kaartic.sivaraam@gmail.com, me@ttaylorr.com, karthik.188@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Jan 2026 at 13:13, Toon Claes <toon@iotcl.com> wrote:
>
> Olamide Caleb Bello <belkid98@gmail.com> writes:
>
> It seems you have 'environment:' twice in the title?

Arh! Thank you for spotting it

>
> > The config value `core.sparseCheckout` is parsed in
> > `git_default_core_config()` and stored globally in
> > `core_appy_sparse_checkout`. This could cause unintended behaviours
>
> s/core_appy_sparse_checkout/core_apply_sparse_checkout/ ?

Thank you.

>
> > when different Git repositories running in the same process access this
> > variable.
> >
> > Move the parsed value into `struct repo_config_values` to retains current
> > behaviours while achieving the repository scoped access.
> >
> > Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
> > Mentored-by: Christian Couder <christian.couder@gmail.com>
> > Mentored-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> > Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
> > ---
> >  builtin/backfill.c        |  2 +-
> >  builtin/clone.c           |  2 +-
> >  builtin/grep.c            |  2 +-
> >  builtin/mv.c              |  2 +-
> >  builtin/sparse-checkout.c | 22 +++++++++++-----------
> >  builtin/worktree.c        |  2 +-
> >  dir.c                     |  2 +-
> >  environment.c             |  4 ++--
> >  environment.h             |  2 +-
> >  sparse-index.c            |  6 ++++--
> >  unpack-trees.c            |  2 +-
> >  wt-status.c               |  2 +-
> >  12 files changed, 26 insertions(+), 24 deletions(-)
> >
> > diff --git a/builtin/backfill.c b/builtin/backfill.c
> > index e80fc1b694..5fc8c51ed1 100644
> > --- a/builtin/backfill.c
> > +++ b/builtin/backfill.c
> > @@ -139,7 +139,7 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
> >       repo_config(repo, git_default_config, NULL);
> >
> >       if (ctx.sparse < 0)
> > -             ctx.sparse = core_apply_sparse_checkout;
> > +             ctx.sparse = repo->config_values.sparse_checkout;
> >
> >       result = do_backfill(&ctx);
> >       backfill_context_clear(&ctx);
> > diff --git a/builtin/clone.c b/builtin/clone.c
> > index b19b302b06..b6b19e83d1 100644
> > --- a/builtin/clone.c
> > +++ b/builtin/clone.c
> > @@ -623,7 +623,7 @@ static int git_sparse_checkout_init(const char *repo)
> >        * We must apply the setting in the current process
> >        * for the later checkout to use the sparse-checkout file.
> >        */
> > -     core_apply_sparse_checkout = 1;
> > +     the_repository->config_values.sparse_checkout = 1;
> >
> >       cmd.git_cmd = 1;
> >       if (run_command(&cmd)) {
> > diff --git a/builtin/grep.c b/builtin/grep.c
> > index 53cccf2d25..525edb5e9c 100644
> > --- a/builtin/grep.c
> > +++ b/builtin/grep.c
> > @@ -482,7 +482,7 @@ static int grep_submodule(struct grep_opt *opt,
> >        *      "forget" the sparse-index feature switch. As a result, the index
> >        *      of these submodules are expanded unexpectedly.
> >        *
> > -      * 2. "core_apply_sparse_checkout"
> > +      * 2. "sparse_checkout"
> >        *      When running `grep` in the superproject, this setting is
> >        *      populated using the superproject's configs. However, once
> >        *      initialized, this config is globally accessible and is read by
> > diff --git a/builtin/mv.c b/builtin/mv.c
> > index d43925097b..511620747b 100644
> > --- a/builtin/mv.c
> > +++ b/builtin/mv.c
> > @@ -572,7 +572,7 @@ int cmd_mv(int argc,
> >               rename_index_entry_at(the_repository->index, pos, dst);
> >
> >               if (ignore_sparse &&
> > -                 core_apply_sparse_checkout &&
> > +                 the_repository->config_values.sparse_checkout &&
> >                   core_sparse_checkout_cone) {
> >                       /*
> >                        * NEEDSWORK: we are *not* paying attention to
> > diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> > index 15d51e60a8..1c2c39b968 100644
> > --- a/builtin/sparse-checkout.c
> > +++ b/builtin/sparse-checkout.c
> > @@ -63,7 +63,7 @@ static int sparse_checkout_list(int argc, const char **argv, const char *prefix,
> >       int res;
> >
> >       setup_work_tree();
> > -     if (!core_apply_sparse_checkout)
> > +     if (!the_repository->config_values.sparse_checkout)
> >               die(_("this worktree is not sparse"));
> >
> >       argc = parse_options(argc, argv, prefix,
> > @@ -400,11 +400,11 @@ static int set_config(struct repository *repo,
> >
> >  static enum sparse_checkout_mode update_cone_mode(int *cone_mode) {
> >       /* If not specified, use previous definition of cone mode */
> > -     if (*cone_mode == -1 && core_apply_sparse_checkout)
> > +     if (*cone_mode == -1 && the_repository->config_values.sparse_checkout)
> >               *cone_mode = core_sparse_checkout_cone;
> >
> >       /* Set cone/non-cone mode appropriately */
> > -     core_apply_sparse_checkout = 1;
> > +     the_repository->config_values.sparse_checkout = 1;
> >       if (*cone_mode == 1 || *cone_mode == -1) {
> >               core_sparse_checkout_cone = 1;
> >               return MODE_CONE_PATTERNS;
> > @@ -418,7 +418,7 @@ static int update_modes(struct repository *repo, int *cone_mode, int *sparse_ind
> >       int mode, record_mode;
> >
> >       /* Determine if we need to record the mode; ensure sparse checkout on */
> > -     record_mode = (*cone_mode != -1) || !core_apply_sparse_checkout;
> > +     record_mode = (*cone_mode != -1) || !repo->config_values.sparse_checkout;
> >
> >       mode = update_cone_mode(cone_mode);
> >       if (record_mode && set_config(repo, mode))
> > @@ -699,9 +699,9 @@ static int modify_pattern_list(struct repository *repo,
> >               break;
> >       }
> >
> > -     if (!core_apply_sparse_checkout) {
> > +     if (!repo->config_values.sparse_checkout) {
> >               set_config(repo, MODE_ALL_PATTERNS);
> > -             core_apply_sparse_checkout = 1;
> > +             repo->config_values.sparse_checkout = 1;
> >               changed_config = 1;
> >       }
> >
> > @@ -798,7 +798,7 @@ static int sparse_checkout_add(int argc, const char **argv, const char *prefix,
> >       int ret;
> >
> >       setup_work_tree();
> > -     if (!core_apply_sparse_checkout)
> > +     if (!repo->config_values.sparse_checkout)
> >               die(_("no sparse-checkout to add to"));
> >
> >       repo_read_index(repo);
> > @@ -907,7 +907,7 @@ static int sparse_checkout_reapply(int argc, const char **argv,
> >       };
> >
> >       setup_work_tree();
> > -     if (!core_apply_sparse_checkout)
> > +     if (!repo->config_values.sparse_checkout)
> >               die(_("must be in a sparse-checkout to reapply sparsity patterns"));
> >
> >       reapply_opts.cone_mode = -1;
> > @@ -969,7 +969,7 @@ static int sparse_checkout_clean(int argc, const char **argv,
> >       };
> >
> >       setup_work_tree();
> > -     if (!core_apply_sparse_checkout)
> > +     if (!repo->config_values.sparse_checkout)
> >               die(_("must be in a sparse-checkout to clean directories"));
> >       if (!core_sparse_checkout_cone)
> >               die(_("must be in a cone-mode sparse-checkout to clean directories"));
> > @@ -1035,7 +1035,7 @@ static int sparse_checkout_disable(int argc, const char **argv,
> >       struct pattern_list pl;
> >
> >       /*
> > -      * We do not exit early if !core_apply_sparse_checkout; due to the
> > +      * We do not exit early if !repo->config_values.sparse_checkout; due to the
> >        * ability for users to manually muck things up between
> >        *   direct editing of .git/info/sparse-checkout
> >        *   running read-tree -m u HEAD or update-index --skip-worktree
> > @@ -1061,7 +1061,7 @@ static int sparse_checkout_disable(int argc, const char **argv,
> >       hashmap_init(&pl.recursive_hashmap, pl_hashmap_cmp, NULL, 0);
> >       hashmap_init(&pl.parent_hashmap, pl_hashmap_cmp, NULL, 0);
> >       pl.use_cone_patterns = 0;
> > -     core_apply_sparse_checkout = 1;
> > +     repo->config_values.sparse_checkout = 1;
> >
> >       add_pattern("/*", empty_base, 0, &pl, 0);
> >
> > diff --git a/builtin/worktree.c b/builtin/worktree.c
> > index fbdaf2eb2e..e401b8253e 100644
> > --- a/builtin/worktree.c
> > +++ b/builtin/worktree.c
> > @@ -536,7 +536,7 @@ static int add_worktree(const char *path, const char *refname,
> >        * If the current worktree has sparse-checkout enabled, then copy
> >        * the sparse-checkout patterns from the current worktree.
> >        */
> > -     if (core_apply_sparse_checkout)
> > +     if (wt->repo->config_values.sparse_checkout)
> >               copy_sparse_checkout(sb_repo.buf);
> >
> >       /*
> > diff --git a/dir.c b/dir.c
> > index b00821f294..56b412a6d2 100644
> > --- a/dir.c
> > +++ b/dir.c
> > @@ -1551,7 +1551,7 @@ enum pattern_match_result path_matches_pattern_list(
> >
> >  int init_sparse_checkout_patterns(struct index_state *istate)
> >  {
> > -     if (!core_apply_sparse_checkout)
> > +     if (!istate->repo->config_values.sparse_checkout)
> >               return 1;
> >       if (istate->sparse_checkout_patterns)
> >               return 0;
> > diff --git a/environment.c b/environment.c
> > index 283db0a1a0..6633542750 100644
> > --- a/environment.c
> > +++ b/environment.c
> > @@ -74,7 +74,6 @@ enum push_default_type push_default = PUSH_DEFAULT_UNSPECIFIED;
> >  #endif
> >  enum object_creation_mode object_creation_mode = OBJECT_CREATION_MODE;
> >  int grafts_keep_true_parents;
> > -int core_apply_sparse_checkout;
> >  int core_sparse_checkout_cone;
> >  int sparse_expect_files_outside_of_patterns;
> >  int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
> > @@ -546,7 +545,7 @@ static int git_default_core_config(const char *var, const char *value,
> >       }
> >
> >       if (!strcmp(var, "core.sparsecheckout")) {
> > -             core_apply_sparse_checkout = git_config_bool(var, value);
> > +             cfg->sparse_checkout = git_config_bool(var, value);
> >               return 0;
> >       }
> >
> > @@ -761,4 +760,5 @@ int git_default_config(const char *var, const char *value,
> >  void repo_config_values_init(struct repo_config_values *cfg)
> >  {
> >       cfg->attributes_file_path = NULL;
> > +     cfg->sparse_checkout = 0;
> >  }
> > diff --git a/environment.h b/environment.h
> > index aea73ff25b..3b5ff7094a 100644
> > --- a/environment.h
> > +++ b/environment.h
> > @@ -88,6 +88,7 @@ struct strvec;
> >  struct repo_config_values {
> >       /* core config values */
> >       char *attributes_file_path;
> > +     int sparse_checkout;
> >  };
> >
> >  /*
> > @@ -169,7 +170,6 @@ extern int precomposed_unicode;
> >  extern int protect_hfs;
> >  extern int protect_ntfs;
> >
> > -extern int core_apply_sparse_checkout;
>
> In the field you're adding to 'struct repo_config_values' you have
> dropped the 'core_' prefix, what the reason for that? If I understand it
> correctly also settings from other sections might end up in that struct,
> so wouldn't it be better to keep the prefix?

Okay, noted

>
> >  extern int core_sparse_checkout_cone;
> >  extern int sparse_expect_files_outside_of_patterns;
> >
> > diff --git a/sparse-index.c b/sparse-index.c
> > index 76f90da5f5..6dd8dd679d 100644
> > --- a/sparse-index.c
> > +++ b/sparse-index.c
> > @@ -152,7 +152,8 @@ static int index_has_unmerged_entries(struct index_state *istate)
> >
> >  int is_sparse_index_allowed(struct index_state *istate, int flags)
> >  {
> > -     if (!core_apply_sparse_checkout || !core_sparse_checkout_cone)
> > +     struct repo_config_values *cfg = &istate->repo->config_values;
> > +     if (!cfg->sparse_checkout || !core_sparse_checkout_cone)
> >               return 0;
> >
> >       if (!(flags & SPARSE_INDEX_MEMORY_ONLY)) {
> > @@ -670,7 +671,8 @@ static void clear_skip_worktree_from_present_files_full(struct index_state *ista
> >
> >  void clear_skip_worktree_from_present_files(struct index_state *istate)
> >  {
> > -     if (!core_apply_sparse_checkout ||
> > +     struct repo_config_values *cfg = &istate->repo->config_values;
> > +     if (!cfg->sparse_checkout ||
> >           sparse_expect_files_outside_of_patterns)
> >               return;
> >
> > diff --git a/unpack-trees.c b/unpack-trees.c
> > index f38c761ab9..2bdfa1334c 100644
> > --- a/unpack-trees.c
> > +++ b/unpack-trees.c
> > @@ -1924,7 +1924,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
> >       if (o->prefix)
> >               update_sparsity_for_prefix(o->prefix, o->src_index);
> >
> > -     if (!core_apply_sparse_checkout || !o->update)
> > +     if (!repo->config_values.sparse_checkout || !o->update)
> >               o->skip_sparse_checkout = 1;
> >       if (!o->skip_sparse_checkout) {
> >               memset(&pl, 0, sizeof(pl));
> > diff --git a/wt-status.c b/wt-status.c
> > index e12adb26b9..a2e388606f 100644
> > --- a/wt-status.c
> > +++ b/wt-status.c
> > @@ -1764,7 +1764,7 @@ static void wt_status_check_sparse_checkout(struct repository *r,
> >       int skip_worktree = 0;
> >       int i;
> >
> > -     if (!core_apply_sparse_checkout || r->index->cache_nr == 0) {
> > +     if (!r->config_values.sparse_checkout || r->index->cache_nr == 0) {
> >               /*
> >                * Don't compute percentage of checked out files if we
> >                * aren't in a sparse checkout or would get division by 0.
> > --
> > 2.34.1
> >
> >
>
> --
> Cheers,
> Toon
