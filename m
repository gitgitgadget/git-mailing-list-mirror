Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 130361F453
	for <e@80x24.org>; Sat, 10 Nov 2018 13:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbeKJXUg (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Nov 2018 18:20:36 -0500
Received: from mail-lj1-f176.google.com ([209.85.208.176]:38765 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728996AbeKJXUg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Nov 2018 18:20:36 -0500
Received: by mail-lj1-f176.google.com with SMTP id q186-v6so3908206ljb.5
        for <git@vger.kernel.org>; Sat, 10 Nov 2018 05:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gfX+0H44LZQQZt1Y25o8noO5KhwRDjqvwa1lKyWRLzI=;
        b=GT7QCXvTnMqZHs6zcHW4v1spizyGtBkapI5t/QiY+PHch1TioxCZ6P7nRUy1CI8GhT
         95kFsgs4HgMAhu2eeQ1sFhcEx2WAYRZ64UeJOj7/eOh22eDDtMWMv5uQOk3v80FCjX4Q
         sEPdB/uOgJCbwH1zCpNqdDgFZYzAtKC5wO8g3bwbvl4ushXlgOphshC8d+wp2VtopEwq
         PgBl1+Gjn9a5onqeI7oH+8EpzMpgNOdl8cskomq0tuVw+VrQF3yIwcQzWCU80OguMHDT
         h0c88H+8wBF2Hf9dJKK54f944Ss0PDL/mzN2n5y8rokuvpYgS2puyCrGiMltBVorccNk
         Nqgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gfX+0H44LZQQZt1Y25o8noO5KhwRDjqvwa1lKyWRLzI=;
        b=dZeEXjRdOPEiD30x6n8zIkbuNriBI14AIQ8RPDwjWA8Yun0F4DkhfOP5A6uUOQzfj2
         wh4fJInMy/jVB85pu0KuRLgz93O55hYn1MC13xEHGu+XhgCLnaXN6RAyMgj8uHeIAd5L
         kIW3jrEIDwBgfMVqO/L6GpeL5u0jY2lFUDJnaDGkWWXSJuDM4fhyo2z9E+z1bao1wk/q
         FqpJTEZCmYXdkXSl6WSOqFL3QWBBUWdSpA2KeZW6qYQaTTaWUH0QJ/2RWkoARW/NlM5G
         VmZTP6hu8WlkHmU6IK4nDXuAKt6+n/MkKlkV+HCgPvEmKU/lK1chEd3/FDwgGfz+zFmY
         Yi/A==
X-Gm-Message-State: AGRZ1gL6Uu87WbpcoxjBVKnE8X6ickyes7v6B/m1onP+DBzrznVTV7se
        6oFWdEfJqjQuTk4JSVOWOEK8h9ap
X-Google-Smtp-Source: AJdET5c8HOFnjlfKKDz0NHEOTG9316VP4CJRx4GWvresODdRD4+tFoJGGyq9GOvXGeUxfGUiLTpu7g==
X-Received: by 2002:a2e:9a16:: with SMTP id o22-v6mr7911586lji.112.1541856931041;
        Sat, 10 Nov 2018 05:35:31 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id x24-v6sm2238273ljc.54.2018.11.10.05.35.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Nov 2018 05:35:29 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH/RFC] checkout: print something when checking out paths
Date:   Sat, 10 Nov 2018 14:35:25 +0100
Message-Id: <20181110133525.17538-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1231.g84aef82467
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One of the problems with "git checkout" is that it does so many
different things and could confuse people specially when we fail to
handle ambiguation correctly.

One way to help with that is tell the user what sort of operation is
actually carried out. When switching branches, we always print
something [1].  Checking out paths however is silent. Print something
so that if we got the user intention wrong, they won't waste too much
time to find that out.

Since the purpose of printing this is to help disambiguate. Only do it
when "--" is missing (the actual reason though is many tests check
empty stderr to see that no error is raised and I'm too lazy to fix
all the test cases).

[1] Knowing the number of paths updated could also be useful even in
    normal case.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 This is related to another patch in
 
 https://public-inbox.org/git/20181110120707.25846-1-pclouds@gmail.com/T/#u

 While writing that patch I thought printing something would also
 help. But if we get ambiguation right (in that particular case) then
 we don't actually need this. But it still seems a good idea...

 apply.c                  |  3 ++-
 builtin/checkout-index.c |  6 ++++--
 builtin/checkout.c       | 30 ++++++++++++++++++++++--------
 builtin/difftool.c       |  2 +-
 cache.h                  |  4 ++--
 entry.c                  | 10 ++++++----
 unpack-trees.c           |  6 +++---
 7 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/apply.c b/apply.c
index 073d5f0451..5876b02197 100644
--- a/apply.c
+++ b/apply.c
@@ -3352,7 +3352,8 @@ static int checkout_target(struct index_state *istate,
 
 	costate.refresh_cache = 1;
 	costate.istate = istate;
-	if (checkout_entry(ce, &costate, NULL) || lstat(ce->name, st))
+	if (checkout_entry(ce, &costate, NULL, NULL) ||
+	    lstat(ce->name, st))
 		return error(_("cannot checkout %s"), ce->name);
 	return 0;
 }
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 88b86c8d9f..bada491f58 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -67,7 +67,8 @@ static int checkout_file(const char *name, const char *prefix)
 			continue;
 		did_checkout = 1;
 		if (checkout_entry(ce, &state,
-		    to_tempfile ? topath[ce_stage(ce)] : NULL) < 0)
+				   to_tempfile ? topath[ce_stage(ce)] : NULL,
+				   NULL) < 0)
 			errs++;
 	}
 
@@ -111,7 +112,8 @@ static void checkout_all(const char *prefix, int prefix_length)
 				write_tempfile_record(last_ce->name, prefix);
 		}
 		if (checkout_entry(ce, &state,
-		    to_tempfile ? topath[ce_stage(ce)] : NULL) < 0)
+				   to_tempfile ? topath[ce_stage(ce)] : NULL,
+				   NULL) < 0)
 			errs++;
 		last_ce = ce;
 	}
diff --git a/builtin/checkout.c b/builtin/checkout.c
index acdafc6e4c..13ed041dc1 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -44,6 +44,7 @@ struct checkout_opts {
 	int ignore_skipworktree;
 	int ignore_other_worktrees;
 	int show_progress;
+	int count_checkout_paths;
 	/*
 	 * If new checkout options are added, skip_merge_working_tree
 	 * should be updated accordingly.
@@ -165,12 +166,13 @@ static int check_stages(unsigned stages, const struct cache_entry *ce, int pos)
 }
 
 static int checkout_stage(int stage, const struct cache_entry *ce, int pos,
-			  const struct checkout *state)
+			  const struct checkout *state, int *nr_checkouts)
 {
 	while (pos < active_nr &&
 	       !strcmp(active_cache[pos]->name, ce->name)) {
 		if (ce_stage(active_cache[pos]) == stage)
-			return checkout_entry(active_cache[pos], state, NULL);
+			return checkout_entry(active_cache[pos], state,
+					      NULL, nr_checkouts);
 		pos++;
 	}
 	if (stage == 2)
@@ -179,7 +181,7 @@ static int checkout_stage(int stage, const struct cache_entry *ce, int pos,
 		return error(_("path '%s' does not have their version"), ce->name);
 }
 
-static int checkout_merged(int pos, const struct checkout *state)
+static int checkout_merged(int pos, const struct checkout *state, int *nr_checkouts)
 {
 	struct cache_entry *ce = active_cache[pos];
 	const char *path = ce->name;
@@ -242,7 +244,7 @@ static int checkout_merged(int pos, const struct checkout *state)
 	ce = make_transient_cache_entry(mode, &oid, path, 2);
 	if (!ce)
 		die(_("make_cache_entry failed for path '%s'"), path);
-	status = checkout_entry(ce, state, NULL);
+	status = checkout_entry(ce, state, NULL, nr_checkouts);
 	discard_cache_entry(ce);
 	return status;
 }
@@ -257,6 +259,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 	struct commit *head;
 	int errs = 0;
 	struct lock_file lock_file = LOCK_INIT;
+	int nr_checkouts = 0;
 
 	if (opts->track != BRANCH_TRACK_UNSPECIFIED)
 		die(_("'%s' cannot be used with updating paths"), "--track");
@@ -371,17 +374,27 @@ static int checkout_paths(const struct checkout_opts *opts,
 		struct cache_entry *ce = active_cache[pos];
 		if (ce->ce_flags & CE_MATCHED) {
 			if (!ce_stage(ce)) {
-				errs |= checkout_entry(ce, &state, NULL);
+				errs |= checkout_entry(ce, &state,
+						       NULL, &nr_checkouts);
 				continue;
 			}
 			if (opts->writeout_stage)
-				errs |= checkout_stage(opts->writeout_stage, ce, pos, &state);
+				errs |= checkout_stage(opts->writeout_stage,
+						       ce, pos,
+						       &state, &nr_checkouts);
 			else if (opts->merge)
-				errs |= checkout_merged(pos, &state);
+				errs |= checkout_merged(pos, &state,
+							&nr_checkouts);
 			pos = skip_same_name(ce, pos) - 1;
 		}
 	}
-	errs |= finish_delayed_checkout(&state);
+	errs |= finish_delayed_checkout(&state, &nr_checkouts);
+
+	if (opts->count_checkout_paths)
+		fprintf_ln(stderr, Q_("%d path has been updated",
+				      "%d paths have been updated",
+				      nr_checkouts),
+			   nr_checkouts);
 
 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
@@ -1064,6 +1077,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 		has_dash_dash = 1; /* case (3) or (1) */
 	else if (dash_dash_pos >= 2)
 		die(_("only one reference expected, %d given."), dash_dash_pos);
+	opts->count_checkout_paths = !opts->quiet && !has_dash_dash;
 
 	if (!strcmp(arg, "-"))
 		arg = "@{-1}";
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 544b0e8639..71318c26e1 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -323,7 +323,7 @@ static int checkout_path(unsigned mode, struct object_id *oid,
 	int ret;
 
 	ce = make_transient_cache_entry(mode, oid, path, 0);
-	ret = checkout_entry(ce, state, NULL);
+	ret = checkout_entry(ce, state, NULL, NULL);
 
 	discard_cache_entry(ce);
 	return ret;
diff --git a/cache.h b/cache.h
index 8b1ee42ae9..52fb6ba148 100644
--- a/cache.h
+++ b/cache.h
@@ -1540,9 +1540,9 @@ struct checkout {
 #define CHECKOUT_INIT { NULL, "" }
 
 #define TEMPORARY_FILENAME_LENGTH 25
-extern int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *topath);
+extern int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *topath, int *nr_checkouts);
 extern void enable_delayed_checkout(struct checkout *state);
-extern int finish_delayed_checkout(struct checkout *state);
+extern int finish_delayed_checkout(struct checkout *state, int *nr_checkouts);
 
 struct cache_def {
 	struct strbuf path;
diff --git a/entry.c b/entry.c
index 5d136c5d55..5f213c30fe 100644
--- a/entry.c
+++ b/entry.c
@@ -161,7 +161,7 @@ static int remove_available_paths(struct string_list_item *item, void *cb_data)
 	return !available;
 }
 
-int finish_delayed_checkout(struct checkout *state)
+int finish_delayed_checkout(struct checkout *state, int *nr_checkouts)
 {
 	int errs = 0;
 	unsigned delayed_object_count;
@@ -226,7 +226,7 @@ int finish_delayed_checkout(struct checkout *state)
 				ce = index_file_exists(state->istate, path->string,
 						       strlen(path->string), 0);
 				if (ce) {
-					errs |= checkout_entry(ce, state, NULL);
+					errs |= checkout_entry(ce, state, NULL, nr_checkouts);
 					filtered_bytes += ce->ce_stat_data.sd_size;
 					display_throughput(progress, filtered_bytes);
 				} else
@@ -435,8 +435,8 @@ static void mark_colliding_entries(const struct checkout *state,
  * its name is returned in topath[], which must be able to hold at
  * least TEMPORARY_FILENAME_LENGTH bytes long.
  */
-int checkout_entry(struct cache_entry *ce,
-		   const struct checkout *state, char *topath)
+int checkout_entry(struct cache_entry *ce, const struct checkout *state,
+		   char *topath, int *nr_checkouts)
 {
 	static struct strbuf path = STRBUF_INIT;
 	struct stat st;
@@ -506,5 +506,7 @@ int checkout_entry(struct cache_entry *ce,
 		return 0;
 
 	create_directories(path.buf, path.len, state);
+	if (nr_checkouts)
+		(*nr_checkouts)++;
 	return write_entry(ce, path.buf, state, 0);
 }
diff --git a/unpack-trees.c b/unpack-trees.c
index 7570df481b..17f1e601da 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -294,7 +294,7 @@ static void load_gitmodules_file(struct index_state *index,
 			repo_read_gitmodules(the_repository);
 		} else if (state && (ce->ce_flags & CE_UPDATE)) {
 			submodule_free(the_repository);
-			checkout_entry(ce, state, NULL);
+			checkout_entry(ce, state, NULL, NULL);
 			repo_read_gitmodules(the_repository);
 		}
 	}
@@ -450,12 +450,12 @@ static int check_updates(struct unpack_trees_options *o)
 			display_progress(progress, ++cnt);
 			ce->ce_flags &= ~CE_UPDATE;
 			if (o->update && !o->dry_run) {
-				errs |= checkout_entry(ce, &state, NULL);
+				errs |= checkout_entry(ce, &state, NULL, NULL);
 			}
 		}
 	}
 	stop_progress(&progress);
-	errs |= finish_delayed_checkout(&state);
+	errs |= finish_delayed_checkout(&state, NULL);
 	if (o->update)
 		git_attr_set_direction(GIT_ATTR_CHECKIN);
 
-- 
2.19.1.1231.g84aef82467

