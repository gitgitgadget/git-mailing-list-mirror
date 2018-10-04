Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 009D81F453
	for <e@80x24.org>; Thu,  4 Oct 2018 21:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbeJEEha (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 00:37:30 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44529 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbeJEEha (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 00:37:30 -0400
Received: by mail-ed1-f67.google.com with SMTP id z21-v6so5479925edb.11
        for <git@vger.kernel.org>; Thu, 04 Oct 2018 14:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=V3NMK2SWCM/1OVfVNUm+SE6ZsysYrUZjziXA1dCq9eo=;
        b=aizHa6b7QEj9g0IksMtwythNrwskMtPP51p5ltS9loZzNLma4+Taw2aWwHHcawhkOw
         1swBeoKRO5DzAEwu+lRylGv4Bdy7O6/lCcc7ALB5+9AF1tr6vemqLTLUDEriaYmXaj/D
         S4AOD7z7twTlNT64HZqpgNZCzE5OVoNtZ2KeH8m2v3jIz5NQ9YwD4M30kltciVFy6yXj
         ZFdGdZXnWenL0KBSZgSWb1RmjBW0F6vrq+9h8UpD2w+DdNMpJ7vYDdBSIoRclyFT86tl
         KbFeayTblzsOxTjBWeCtIzhJRQOCS85yMx2FEBiV/WQ2FI4RM3LZ4mN3UKQZ7IYAtdzX
         7dKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=V3NMK2SWCM/1OVfVNUm+SE6ZsysYrUZjziXA1dCq9eo=;
        b=HWyLdYEpGXD9zOCWoqu1h9kt1QMV+/js6rVYbdpUTVuPIlDTNIvzYztPnUhlFTSbp9
         Z3BzVA3QHWRGvPvmIArv7EkacKcmS1u2QyJoBXDajcxV4Pyc6bfEXJEYcnjPE36yGPan
         Q6EzS2To+SfPZscqO8WEUarIFwdl/VgpBybFeCE9KIdwPBuZbwCUnCjSe6C1HoSjox4P
         rvM6+rozz0875s3EOmk6vYYsk2dbpGvEM+nkPhkHYNZ8THAolOdgHuYQieW0Lx+Lee0E
         dSDBVqLX5nFGEHc33reM+dMEpGoq2ZuZwUqm3ms9N6g4ZHp+5Q1iRxw2uasp5zpTj5pi
         mtBw==
X-Gm-Message-State: ABuFfogjqSmM7c4hnZnDYwLP5qRziurGE1eQKn4JU1dZy+er1XfDrICc
        8XneNumoIZtqHLUY3t2YD6wzwdwv
X-Google-Smtp-Source: ACcGV618XPKbNs+KFcoNXspJb9gEbNHPvH3+9BWgdydFWEbKcjokB+sS2+qk5kePyFk0GJoRwICukQ==
X-Received: by 2002:a50:ad16:: with SMTP id y22-v6mr11246853edc.191.1538689330110;
        Thu, 04 Oct 2018 14:42:10 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id f21-v6sm413448ejc.2.2018.10.04.14.42.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 14:42:09 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>
Subject: [RFC PATCH] We should add a "git gc --auto" after "git clone" due to commit graph
References: <87tvm3go42.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <87tvm3go42.fsf@evledraar.gmail.com>
Date:   Thu, 04 Oct 2018 23:42:08 +0200
Message-ID: <87in2hgzin.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 03 2018, Ævar Arnfjörð Bjarmason wrote:

> Don't have time to patch this now, but thought I'd send a note / RFC
> about this.
>
> Now that we have the commit graph it's nice to be able to set
> e.g. core.commitGraph=true & gc.writeCommitGraph=true in ~/.gitconfig or
> /etc/gitconfig to apply them to all repos.
>
> But when I clone e.g. linux.git stuff like 'tag --contains' will be slow
> until whenever my first "gc" kicks in, which may be quite some time if
> I'm just using it passively.
>
> So we should make "git gc --auto" be run on clone, and change the
> need_to_gc() / cmd_gc() behavior so that we detect that the
> gc.writeCommitGraph=true setting is on, but we have no commit graph, and
> then just generate that without doing a full repack.
>
> As an aside such more granular "gc" would be nice for e.g. pack-refs
> too. It's possible for us to just have one pack, but to have 100k loose
> refs.
>
> It might also be good to have some gc.autoDetachOnClone option and have
> it false by default, so we don't have a race condition where "clone
> linux && git -C linux tag --contains" is slow because the graph hasn't
> been generated yet, and generating the graph initially doesn't take that
> long compared to the time to clone a large repo (and on a small one it
> won't matter either way).
>
> I was going to say "also for midx", but of course after clone we have
> just one pack, so I can't imagine us needing this. But I can see us
> having other such optional side-indexes in the future generated by gc,
> and they'd also benefit from this.

I don't have time to polish this up for submission now, but here's a WIP
patch that implements this, highlights:

 * There's a gc.clone.autoDetach=false default setting which overrides
   gc.autoDetach if 'git gc --auto' is run via git-clone (we just pass a
   --cloning option to indicate this).

 * A clone of say git.git with gc.writeCommitGraph=true looks like:

   [...]
   Receiving objects: 100% (255262/255262), 100.49 MiB | 17.78 MiB/s, done.
   Resolving deltas: 100% (188947/188947), done.
   Computing commit graph generation numbers: 100% (55210/55210), done.

 * The 'git gc --auto' command also knows to (only) run the commit-graph
   (and space is left for future optimization steps) if general GC isn't
   needed, but we need "optimization":

   $ rm .git/objects/info/commit-graph; ~/g/git/git --exec-path=$PWD -c gc.writeCommitGraph=true -c gc.autoDetach=false gc --auto;
   Annotating commits in commit graph: 341229, done.
   Computing commit graph generation numbers: 100% (165969/165969), done.
   $

 * The patch to gc.c looks less scary with -w, most of it is indenting
   the existing pack-refs etc. with a "!auto_gc || should_gc" condition.

 * I added a commit_graph_exists() exists function and only care if I
   get ENOENT for the purposes of this gc mode. This would need to be
   tweaked for the incremental mode Derrick talks about, but if we just
   set "should_optimize" that'll also work as far as gc --auto is
   concerned (e.g. on fetch, am etc.)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1546833213..5759fbb067 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1621,7 +1621,19 @@ gc.autoPackLimit::

 gc.autoDetach::
 	Make `git gc --auto` return immediately and run in background
-	if the system supports it. Default is true.
+	if the system supports it. Default is true. Overridden by
+	`gc.clone.autoDetach` when running linkgit:git-clone[1].
+
+gc.clone.autoDetach::
+	Make `git gc --auto` return immediately and run in background
+	if the system supports it when run via
+	linkgit:git-clone[1]. Default is false.
++
+The reason this defaults to false is because the only time we'll have
+work to do after a 'git clone' is if something like
+`gc.writeCommitGraph` is true, in that case we'd like to compute the
+optimized file before returning, so that say commands that benefit
+from commit graph aren't slow until it's generated in the background.

 gc.bigPackThreshold::
 	If non-zero, all packs larger than this limit are kept when
diff --git a/builtin/clone.c b/builtin/clone.c
index 15b142d646..824c130ba5 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -897,6 +897,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	struct remote *remote;
 	int err = 0, complete_refs_before_fetch = 1;
 	int submodule_progress;
+	const char *argv_gc_auto[]       = {"gc", "--auto", "--cloning", NULL};
+	const char *argv_gc_auto_quiet[] = {"gc", "--auto", "--cloning", "--quiet", NULL};

 	struct refspec rs = REFSPEC_INIT_FETCH;
 	struct argv_array ref_prefixes = ARGV_ARRAY_INIT;
@@ -1245,5 +1247,11 @@ int cmd_clone(int argc, const char **argv, const char *prefix)

 	refspec_clear(&rs);
 	argv_array_clear(&ref_prefixes);
+
+	if (0 <= option_verbosity)
+		run_command_v_opt_cd_env(argv_gc_auto, RUN_GIT_CMD, git_dir, NULL);
+	else
+		run_command_v_opt_cd_env(argv_gc_auto_quiet, RUN_GIT_CMD, git_dir, NULL);
+
 	return err;
 }
diff --git a/builtin/gc.c b/builtin/gc.c
index 6591ddbe83..27be03890a 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -43,6 +43,7 @@ static int gc_auto_threshold = 6700;
 static int gc_auto_pack_limit = 50;
 static int gc_write_commit_graph;
 static int detach_auto = 1;
+static int detach_clone_auto = 0;
 static timestamp_t gc_log_expire_time;
 static const char *gc_log_expire = "1.day.ago";
 static const char *prune_expire = "2.weeks.ago";
@@ -133,6 +134,7 @@ static void gc_config(void)
 	git_config_get_int("gc.autopacklimit", &gc_auto_pack_limit);
 	git_config_get_bool("gc.writecommitgraph", &gc_write_commit_graph);
 	git_config_get_bool("gc.autodetach", &detach_auto);
+	git_config_get_bool("gc.clone.autodetach", &detach_clone_auto);
 	git_config_get_expiry("gc.pruneexpire", &prune_expire);
 	git_config_get_expiry("gc.worktreepruneexpire", &prune_worktrees_expire);
 	git_config_get_expiry("gc.logexpiry", &gc_log_expire);
@@ -157,9 +159,6 @@ static int too_many_loose_objects(void)
 	int num_loose = 0;
 	int needed = 0;

-	if (gc_auto_threshold <= 0)
-		return 0;
-
 	dir = opendir(git_path("objects/17"));
 	if (!dir)
 		return 0;
@@ -369,10 +368,21 @@ static int need_to_gc(void)
 		return 0;

 	if (run_hook_le(NULL, "pre-auto-gc", NULL))
-		return 0;
+		return -1;
 	return 1;
 }

+static int need_to_optimize(void) {
+	if (gc_write_commit_graph) {
+		char *obj_dir = get_object_directory();
+		char *graph_name = get_commit_graph_filename(obj_dir);
+
+		if (commit_graph_exists(graph_name) == 0) /* ENOENT */
+			return 1;
+	}
+	return 0;
+}
+
 /* return NULL on success, else hostname running the gc */
 static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 {
@@ -491,6 +501,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 {
 	int aggressive = 0;
 	int auto_gc = 0;
+	int cloning = 0;
 	int quiet = 0;
 	int force = 0;
 	const char *name;
@@ -498,6 +509,8 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	int daemonized = 0;
 	int keep_base_pack = -1;
 	timestamp_t dummy;
+	int should_gc;
+	int should_optimize;

 	struct option builtin_gc_options[] = {
 		OPT__QUIET(&quiet, N_("suppress progress reporting")),
@@ -507,6 +520,8 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "aggressive", &aggressive, N_("be more thorough (increased runtime)")),
 		OPT_BOOL_F(0, "auto", &auto_gc, N_("enable auto-gc mode"),
 			   PARSE_OPT_NOCOMPLETE),
+		OPT_BOOL_F(0, "cloning", &cloning, N_("enable cloning mode"),
+			   PARSE_OPT_NOCOMPLETE),
 		OPT_BOOL_F(0, "force", &force,
 			   N_("force running gc even if there may be another gc running"),
 			   PARSE_OPT_NOCOMPLETE),
@@ -555,22 +570,27 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		/*
 		 * Auto-gc should be least intrusive as possible.
 		 */
-		if (!need_to_gc())
+		should_gc = need_to_gc();
+		if (should_gc == -1)
+			return 0;
+		should_optimize = need_to_optimize();
+		if (!should_gc && !should_optimize)
 			return 0;
-		if (!quiet) {
+		if (!quiet && should_gc) {
 			if (detach_auto)
 				fprintf(stderr, _("Auto packing the repository in background for optimum performance.\n"));
 			else
 				fprintf(stderr, _("Auto packing the repository for optimum performance.\n"));
 			fprintf(stderr, _("See \"git help gc\" for manual housekeeping.\n"));
 		}
-		if (detach_auto) {
+		if (detach_auto &&
+		    (!cloning || (cloning && detach_clone_auto))) {
 			if (report_last_gc_error())
 				return -1;

 			if (lock_repo_for_gc(force, &pid))
 				return 0;
-			if (gc_before_repack())
+			if (should_gc && gc_before_repack())
 				return -1;
 			delete_tempfile(&pidfile);

@@ -611,45 +631,48 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		atexit(process_log_file_at_exit);
 	}

-	if (gc_before_repack())
-		return -1;
-
-	if (!repository_format_precious_objects) {
-		close_all_packs(the_repository->objects);
-		if (run_command_v_opt(repack.argv, RUN_GIT_CMD))
-			return error(FAILED_RUN, repack.argv[0]);
-
-		if (prune_expire) {
-			argv_array_push(&prune, prune_expire);
-			if (quiet)
-				argv_array_push(&prune, "--no-progress");
-			if (repository_format_partial_clone)
-				argv_array_push(&prune,
-						"--exclude-promisor-objects");
-			if (run_command_v_opt(prune.argv, RUN_GIT_CMD))
-				return error(FAILED_RUN, prune.argv[0]);
+	if (!auto_gc || should_gc) {
+		if (gc_before_repack())
+			return -1;
+
+		if (!repository_format_precious_objects) {
+			close_all_packs(the_repository->objects);
+			if (run_command_v_opt(repack.argv, RUN_GIT_CMD))
+				return error(FAILED_RUN, repack.argv[0]);
+
+			if (prune_expire) {
+				argv_array_push(&prune, prune_expire);
+				if (quiet)
+					argv_array_push(&prune, "--no-progress");
+				if (repository_format_partial_clone)
+					argv_array_push(&prune,
+							"--exclude-promisor-objects");
+				if (run_command_v_opt(prune.argv, RUN_GIT_CMD))
+					return error(FAILED_RUN, prune.argv[0]);
+			}
 		}
-	}

-	if (prune_worktrees_expire) {
-		argv_array_push(&prune_worktrees, prune_worktrees_expire);
-		if (run_command_v_opt(prune_worktrees.argv, RUN_GIT_CMD))
-			return error(FAILED_RUN, prune_worktrees.argv[0]);
-	}

-	if (run_command_v_opt(rerere.argv, RUN_GIT_CMD))
-		return error(FAILED_RUN, rerere.argv[0]);
+		if (prune_worktrees_expire) {
+			argv_array_push(&prune_worktrees, prune_worktrees_expire);
+			if (run_command_v_opt(prune_worktrees.argv, RUN_GIT_CMD))
+				return error(FAILED_RUN, prune_worktrees.argv[0]);
+		}

-	report_garbage = report_pack_garbage;
-	reprepare_packed_git(the_repository);
-	if (pack_garbage.nr > 0)
-		clean_pack_garbage();
+		if (run_command_v_opt(rerere.argv, RUN_GIT_CMD))
+			return error(FAILED_RUN, rerere.argv[0]);
+
+		report_garbage = report_pack_garbage;
+		reprepare_packed_git(the_repository);
+		if (pack_garbage.nr > 0)
+			clean_pack_garbage();
+	}

 	if (gc_write_commit_graph)
 		write_commit_graph_reachable(get_object_directory(), 0,
 					     !quiet && !daemonized);

-	if (auto_gc && too_many_loose_objects())
+	if (auto_gc && should_gc && too_many_loose_objects())
 		warning(_("There are too many unreachable loose objects; "
 			"run 'git prune' to remove them."));

diff --git a/commit-graph.c b/commit-graph.c
index 5908bd4e34..a4a7c94cec 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -57,6 +57,18 @@ static struct commit_graph *alloc_commit_graph(void)
 	return g;
 }

+int commit_graph_exists(const char *graph_file)
+{
+	struct stat st;
+	if (stat(graph_file, &st)) {
+		if (errno == ENOENT)
+			return 0;
+		else
+			return -1;
+	}
+	return 1;
+}
+
 struct commit_graph *load_commit_graph_one(const char *graph_file)
 {
 	void *graph_map;
diff --git a/commit-graph.h b/commit-graph.h
index 5678a8f4ca..a251f1bc32 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -11,6 +11,7 @@
 struct commit;

 char *get_commit_graph_filename(const char *obj_dir);
+int commit_graph_exists(const char *graph_file);

 /*
  * Given a commit struct, try to fill the commit struct info, including:
