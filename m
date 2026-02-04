Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE08349AF1
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 17:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770226455; cv=pass; b=QxjwabSmbHcqfwbElUIMJliWGPlCwqMw/VISPQVXev9XmvbznUeD7Er+BuXbWEZWO6RmRmUEh82pOL3fIGChIipWSXMNYOU5nYGpkRrmanomstH1gfled7mxZYfjB2EDPmttGBLUiMZ4SLfsiWdsPknkeWFzeTUr/014AnaRNdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770226455; c=relaxed/simple;
	bh=ZStoxLAI5niO65lYMCzemgv0R7jhn7SvTdkDPNc0+aM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IgBZK3AqHT1a10D5hy3Kw0uLCDnkZg7eXXAKK1CQg07FNA7jRTMayaID3jDFzG46FQ2ja9eTmsiQyK8g+gpr1lRnnDmzEwziWMg3S68bJ2V2iXTvBfz7oQe/b9WjI1yR2l2OPu+YsUJy6nmiPT+w4NgTvxLCBdn+L2PtwGJZ71o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=W6vbrcKx; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="W6vbrcKx"
ARC-Seal: i=1; a=rsa-sha256; t=1770226439; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Bq7vJA3p1MhS2MoiaglEykU9S9cAXhZizhPwLAA/pKDJmi4KG26Q3ZBfS8UZdeM/9vVyiPIzLyzxr6REVQhGT8HM0nOWvaxCXc0FeB1IlHOAUWrDCl0ZIWhi8nhiM1cy5+pYAI7uaKpypZPccc1xey7CGn2Ar84LYUlpGkfuyUg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770226439; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=S6///s1jEXpoVAZAYab4TQwOQ1ScWhWUehXwJOrf3JQ=; 
	b=LkkK1PVN9zKEtZNKtSNJFueX/MlUFYxZ+iU7aYRdqOrR3MZU8q65kAulDe64qem3SuuYUMV6y38cMWDeZWCD390GZxCxaNpqbcOgyA8zvfn9yZHZs2VpEJtKcOzlyO3ENqAe6UPjouwBDMrqBzN5xDFkitNoWU4Cco9iSlCAa2o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770226439;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=S6///s1jEXpoVAZAYab4TQwOQ1ScWhWUehXwJOrf3JQ=;
	b=W6vbrcKxqsf5b2vvdeW33ow6b5HuFfcIO8abm4HCK5wrVY7tvAXOTCeWLF6nFx/b
	jS1MhcbrHyKK6UFOWwwmGdHGTmPW5twW9yK8wCsEkqyPCz3hiGx6JTckUTckZNJktBO
	jNILjBjLm6jTr29gJmIIvoOFOYzS6v6Qn88Ik1kY=
Received: by mx.zohomail.com with SMTPS id 1770226436776833.4564757118334;
	Wed, 4 Feb 2026 09:33:56 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH 2/4] hook: allow parallel hook execution
Date: Wed,  4 Feb 2026 19:33:26 +0200
Message-ID: <20260204173328.1601807-3-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Emily Shaffer <emilyshaffer@google.com>

In many cases, there's no reason not to allow hooks to execute in
parallel, if more than one was provided.

hook.c already calls run_processes_parallel() so all we need to do is
allow its job count to be greater than 1.

Serial execution is achieved by setting .jobs == 1 at compile time via
RUN_HOOKS_OPT_INIT_SERIAL or by setting the 'hook.jobs' config to 1.
This matches the behavior prior to this commit.

The compile-time 'struct run_hooks_opt.jobs' parameter has the highest
priority if non-zero, followed by the 'hook.jobs' user config, then the
processor count from online_cpus() is the last fallback.

The above ordering ensures hooks unsafe to run in parallel are always
executed sequentially (RUN_HOOKS_OPT_INIT_SERIAL) while allowing users
to control parallelism with an efficient default.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 Documentation/config/hook.adoc |   5 ++
 Documentation/git-hook.adoc    |  14 ++-
 builtin/am.c                   |  10 ++-
 builtin/checkout.c             |  13 ++-
 builtin/clone.c                |   6 +-
 builtin/hook.c                 |   7 +-
 builtin/receive-pack.c         |   9 +-
 builtin/worktree.c             |   2 +-
 commit.c                       |   2 +-
 hook.c                         |  41 +++++++--
 hook.h                         |  20 ++++-
 refs.c                         |   2 +-
 sequencer.c                    |   4 +-
 t/t1800-hook.sh                | 154 +++++++++++++++++++++++++++++++--
 transport.c                    |   2 +-
 15 files changed, 253 insertions(+), 38 deletions(-)

diff --git a/Documentation/config/hook.adoc b/Documentation/config/hook.adoc
index 49c7ffd82e..c394756328 100644
--- a/Documentation/config/hook.adoc
+++ b/Documentation/config/hook.adoc
@@ -15,3 +15,8 @@ hook.<name>.event::
 	On the specified event, the associated `hook.<name>.command` will be
 	executed. More than one event can be specified if you wish for
 	`hook.<name>` to execute on multiple events. See linkgit:git-hook[1].
+
+hook.jobs::
+	Specifies how many hooks can be run simultaneously during parallelized
+	hook execution. If unspecified, defaults to the number of processors on
+	the current system.
diff --git a/Documentation/git-hook.adoc b/Documentation/git-hook.adoc
index 5f339dc48b..72c6c6d1ee 100644
--- a/Documentation/git-hook.adoc
+++ b/Documentation/git-hook.adoc
@@ -8,7 +8,8 @@ git-hook - Run git hooks
 SYNOPSIS
 --------
 [verse]
-'git hook' run [--ignore-missing] [--to-stdin=<path>] <hook-name> [-- <hook-args>]
+'git hook' run [--ignore-missing] [--to-stdin=<path>] [(-j|--jobs) <n>]
+	<hook-name> [-- <hook-args>]
 'git hook' list <hook-name>
 
 DESCRIPTION
@@ -128,6 +129,16 @@ OPTIONS
 	tools that want to do a blind one-shot run of a hook that may
 	or may not be present.
 
+-j::
+--jobs::
+	Only valid for `run`.
++
+Specify how many hooks to run simultaneously. If this flag is not specified,
+the value of the `hook.jobs` config is used, see linkgit:git-config[1]. If the
+config is not specified, the number of CPUs on the current system is used. Some
+hooks may be ineligible for parallelization: for example, 'commit-msg' hooks
+typically modify the commit message body and cannot be parallelized.
+
 WRAPPERS
 --------
 
@@ -151,6 +162,7 @@ git hook run mywrapper-start-tests \
   # providing something to stdin
   --stdin some-tempfile-123 \
   # execute hooks in serial
+  --jobs 1 \
   # plus some arguments of your own...
   -- \
   --testname bar \
diff --git a/builtin/am.c b/builtin/am.c
index b66a33d8a8..427e137883 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -490,9 +490,11 @@ static int run_applypatch_msg_hook(struct am_state *state)
 
 	assert(state->msg);
 
-	if (!state->no_verify)
-		ret = run_hooks_l(the_repository, "applypatch-msg",
-				  am_path(state, "final-commit"), NULL);
+	if (!state->no_verify) {
+		struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_SERIAL;
+		strvec_push(&opt.args, am_path(state, "final-commit"));
+		ret = run_hooks_opt(the_repository, "applypatch-msg", &opt);
+	}
 
 	if (!ret) {
 		FREE_AND_NULL(state->msg);
@@ -509,7 +511,7 @@ static int run_applypatch_msg_hook(struct am_state *state)
  */
 static int run_post_rewrite_hook(const struct am_state *state)
 {
-	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_PARALLEL;
 
 	strvec_push(&opt.args, "rebase");
 	opt.path_to_stdin = am_path(state, "rewritten");
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 0ba4f03f2e..23833ddfe8 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -31,6 +31,7 @@
 #include "resolve-undo.h"
 #include "revision.h"
 #include "setup.h"
+#include "strvec.h"
 #include "submodule.h"
 #include "symlinks.h"
 #include "trace2.h"
@@ -137,13 +138,17 @@ static void branch_info_release(struct branch_info *info)
 static int post_checkout_hook(struct commit *old_commit, struct commit *new_commit,
 			      int changed)
 {
-	return run_hooks_l(the_repository, "post-checkout",
-			   oid_to_hex(old_commit ? &old_commit->object.oid : null_oid(the_hash_algo)),
-			   oid_to_hex(new_commit ? &new_commit->object.oid : null_oid(the_hash_algo)),
-			   changed ? "1" : "0", NULL);
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_SERIAL;
+
 	/* "new_commit" can be NULL when checking out from the index before
 	   a commit exists. */
+	strvec_pushl(&opt.args,
+		     oid_to_hex(old_commit ? &old_commit->object.oid : null_oid(the_hash_algo)),
+		     oid_to_hex(new_commit ? &new_commit->object.oid : null_oid(the_hash_algo)),
+		     changed ? "1" : "0",
+		     NULL);
 
+	return run_hooks_opt(the_repository, "post-checkout", &opt);
 }
 
 static int update_some(const struct object_id *oid, struct strbuf *base,
diff --git a/builtin/clone.c b/builtin/clone.c
index b40cee5968..2c5ec213a5 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -644,6 +644,7 @@ static int checkout(int submodule_progress, int filter_submodules,
 	struct tree *tree;
 	struct tree_desc t;
 	int err = 0;
+	struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT_SERIAL;
 
 	if (option_no_checkout)
 		return 0;
@@ -694,8 +695,9 @@ static int checkout(int submodule_progress, int filter_submodules,
 	if (write_locked_index(the_repository->index, &lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
 
-	err |= run_hooks_l(the_repository, "post-checkout", oid_to_hex(null_oid(the_hash_algo)),
-			   oid_to_hex(&oid), "1", NULL);
+	strvec_pushl(&hook_opt.args, oid_to_hex(null_oid(the_hash_algo)),
+		     oid_to_hex(&oid), "1", NULL);
+	err |= run_hooks_opt(the_repository, "post-checkout", &hook_opt);
 
 	if (!err && (option_recurse_submodules.nr > 0)) {
 		struct child_process cmd = CHILD_PROCESS_INIT;
diff --git a/builtin/hook.c b/builtin/hook.c
index 4cc6dac45a..cd1f4ebe6a 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -9,7 +9,8 @@
 #include "abspath.h"
 
 #define BUILTIN_HOOK_RUN_USAGE \
-	N_("git hook run [--ignore-missing] [--to-stdin=<path>] <hook-name> [-- <hook-args>]")
+	N_("git hook run [--ignore-missing] [--to-stdin=<path>] [(-j|--jobs) <n>]\n" \
+	   "<hook-name> [-- <hook-args>]")
 #define BUILTIN_HOOK_LIST_USAGE \
 	N_("git hook list <hook-name>")
 
@@ -76,7 +77,7 @@ static int run(int argc, const char **argv, const char *prefix,
 	       struct repository *repo UNUSED)
 {
 	int i;
-	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_PARALLEL;
 	int ignore_missing = 0;
 	const char *hook_name;
 	struct option run_options[] = {
@@ -84,6 +85,8 @@ static int run(int argc, const char **argv, const char *prefix,
 			 N_("silently ignore missing requested <hook-name>")),
 		OPT_STRING(0, "to-stdin", &opt.path_to_stdin, N_("path"),
 			   N_("file to read into hooks' stdin")),
+		OPT_UNSIGNED('j', "jobs", &opt.jobs,
+			    N_("run up to <n> hooks simultaneously")),
 		OPT_END(),
 	};
 	int ret;
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 72fde2207c..6ced7b181c 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -925,7 +925,7 @@ static int run_receive_hook(struct command *commands,
 			    int skip_broken,
 			    const struct string_list *push_options)
 {
-	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_PARALLEL;
 	struct command *iter = commands;
 	struct receive_hook_feed_state feed_state;
 	struct async sideband_async;
@@ -976,7 +976,7 @@ static int run_receive_hook(struct command *commands,
 
 static int run_update_hook(struct command *cmd)
 {
-	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_PARALLEL;
 	struct async sideband_async;
 	int sideband_async_started = 0;
 	int saved_stderr = -1;
@@ -1455,7 +1455,8 @@ static const char *push_to_checkout(unsigned char *hash,
 				    struct strvec *env,
 				    const char *work_tree)
 {
-	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_SERIAL;
+
 	opt.invoked_hook = invoked_hook;
 
 	strvec_pushf(env, "GIT_WORK_TREE=%s", absolute_path(work_tree));
@@ -1670,7 +1671,7 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 
 static void run_update_post_hook(struct command *commands)
 {
-	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_PARALLEL;
 	struct async sideband_async;
 	struct command *cmd;
 	int sideband_async_started = 0;
diff --git a/builtin/worktree.c b/builtin/worktree.c
index fbdaf2eb2e..b30719124c 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -574,7 +574,7 @@ static int add_worktree(const char *path, const char *refname,
 	 * is_junk is cleared, but do return appropriate code when hook fails.
 	 */
 	if (!ret && opts->checkout && !opts->orphan) {
-		struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+		struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_SERIAL;
 
 		strvec_pushl(&opt.env, "GIT_DIR", "GIT_WORK_TREE", NULL);
 		strvec_pushl(&opt.args,
diff --git a/commit.c b/commit.c
index 28bb5ce029..e58c020a51 100644
--- a/commit.c
+++ b/commit.c
@@ -1961,7 +1961,7 @@ size_t ignored_log_message_bytes(const char *buf, size_t len)
 int run_commit_hook(int editor_is_used, const char *index_file,
 		    int *invoked_hook, const char *name, ...)
 {
-	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_SERIAL;
 	va_list args;
 	const char *arg;
 
diff --git a/hook.c b/hook.c
index 9f59ebd0bd..e07e8f4efe 100644
--- a/hook.c
+++ b/hook.c
@@ -250,6 +250,35 @@ static void run_hooks_opt_clear(struct run_hooks_opt *options)
 	strvec_clear(&options->args);
 }
 
+/*
+ * Determines how many jobs to use for hook execution.
+ * The priority is as follows:
+ *   1. Hooks setting jobs=1, either via RUN_HOOKS_OPT_INIT_SERIAL or stdout_to_stderr=0
+ *      are known to be unsafe to parallelize, so their jobs=1 has precedence.
+ *   3. The 'hook.jobs' configuration is used if set.
+ *   4. The number of online CPUs is used as a final fallback.
+ * Returns:
+ *   The number of jobs to use for parallel execution, or 1 for serial.
+ */
+static unsigned int get_hook_jobs(struct repository *r, struct run_hooks_opt *options)
+{
+	unsigned int jobs = options->jobs;
+
+	/*
+	 * Hooks which configure stdout_to_stderr=0 (like pre-push), expect separate
+	 * output streams. Unless extensions.StdoutToStderr is enabled (which forces
+	 * stdout_to_stderr=1), the hook must run sequentially to guarantee output is
+	 * non-interleaved.
+	 */
+	if (!options->stdout_to_stderr)
+		jobs = 1;
+
+	if (!jobs && repo_config_get_uint(r, "hook.jobs", &jobs))
+		jobs = online_cpus(); /* fallback if config is unset */
+
+	return jobs;
+}
+
 int run_hooks_opt(struct repository *r, const char *hook_name,
 		  struct run_hooks_opt *options)
 {
@@ -262,12 +291,13 @@ int run_hooks_opt(struct repository *r, const char *hook_name,
 		.repository = r,
 	};
 	int ret = 0;
+	unsigned int jobs = get_hook_jobs(r, options);
 	const struct run_process_parallel_opts opts = {
 		.tr2_category = "hook",
 		.tr2_label = hook_name,
 
-		.processes = options->jobs,
-		.ungroup = options->jobs == 1,
+		.processes = jobs,
+		.ungroup = jobs == 1,
 
 		.get_next_task = pick_next_hook,
 		.start_failure = notify_start_failure,
@@ -283,9 +313,6 @@ int run_hooks_opt(struct repository *r, const char *hook_name,
 	if (options->path_to_stdin && options->feed_pipe)
 		BUG("options path_to_stdin and feed_pipe are mutually exclusive");
 
-	if (!options->jobs)
-		BUG("run_hooks_opt must be called with options.jobs >= 1");
-
 	/*
 	 * Ensure cb_data copy and free functions are either provided together,
 	 * or neither one is provided.
@@ -337,14 +364,14 @@ int run_hooks_opt(struct repository *r, const char *hook_name,
 
 int run_hooks(struct repository *r, const char *hook_name)
 {
-	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_PARALLEL;
 
 	return run_hooks_opt(r, hook_name, &opt);
 }
 
 int run_hooks_l(struct repository *r, const char *hook_name, ...)
 {
-	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_PARALLEL;
 	va_list ap;
 	const char *arg;
 
diff --git a/hook.h b/hook.h
index cdbe5a9167..3a579c19db 100644
--- a/hook.h
+++ b/hook.h
@@ -22,6 +22,8 @@ struct run_hooks_opt
 	 *
 	 * If > 1, output will be buffered and de-interleaved (ungroup=0).
 	 * If == 1, output will be real-time (ungroup=1).
+	 * If == 0, the 'hook.jobs' config is used or, if the config is unset,
+	 * the number of online cpus on the system.
 	 */
 	unsigned int jobs;
 
@@ -111,13 +113,29 @@ struct run_hooks_opt
 	void (*free_feed_pipe_cb_data)(void *data);
 };
 
-#define RUN_HOOKS_OPT_INIT { \
+/**
+ * Initializer for hooks capable of running only sequentially.
+ * .jobs = 1 forces serial execution.
+ */
+#define RUN_HOOKS_OPT_INIT_SERIAL { \
 	.env = STRVEC_INIT, \
 	.args = STRVEC_INIT, \
 	.stdout_to_stderr = 1, \
 	.jobs = 1, \
 }
 
+/**
+ * Initializer for hooks capable of running in parallel.
+ * .jobs = 0 means online_cpus() will be called to get the number of jobs, if
+ * users did not specify a 'hook.jobs' config which has precedence.
+ */
+#define RUN_HOOKS_OPT_INIT_PARALLEL { \
+	.env = STRVEC_INIT, \
+	.args = STRVEC_INIT, \
+	.stdout_to_stderr = 1, \
+	.jobs = 0, \
+}
+
 struct hook_cb_data {
 	/* rc reflects the cumulative failure state */
 	int rc;
diff --git a/refs.c b/refs.c
index d1a1ace641..9fba8700b3 100644
--- a/refs.c
+++ b/refs.c
@@ -2533,7 +2533,7 @@ static void free_transaction_feed_cb_data(void *data)
 static int run_transaction_hook(struct ref_transaction *transaction,
 				const char *state)
 {
-	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_PARALLEL;
 	struct transaction_feed_cb_data feed_ctx = { 0 };
 	int ret = 0;
 
diff --git a/sequencer.c b/sequencer.c
index cccde58bee..9271a6fa4f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1311,7 +1311,7 @@ static int pipe_from_strbuf(int hook_stdin_fd, void *pp_cb, void *pp_task_cb UNU
 static int run_rewrite_hook(const struct object_id *oldoid,
 			    const struct object_id *newoid)
 {
-	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_PARALLEL;
 	int code;
 	struct strbuf sb = STRBUF_INIT;
 
@@ -5137,7 +5137,7 @@ static int pick_commits(struct repository *r,
 		if (!stat(rebase_path_rewritten_list(), &st) &&
 				st.st_size > 0) {
 			struct child_process child = CHILD_PROCESS_INIT;
-			struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT;
+			struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT_PARALLEL;
 
 			child.in = open(rebase_path_rewritten_list(), O_RDONLY);
 			child.git_cmd = 1;
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 21ff6a68f0..4db1fac862 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -146,10 +146,20 @@ test_expect_success 'git -c core.hooksPath=<PATH> hook run' '
 '
 
 test_hook_tty () {
-	cat >expect <<-\EOF
-	STDOUT TTY
-	STDERR TTY
-	EOF
+	expect_tty=$1
+	shift
+
+	if test "$expect_tty" != "no_tty"; then
+		cat >expect <<-\EOF
+		STDOUT TTY
+		STDERR TTY
+		EOF
+	else
+		cat >expect <<-\EOF
+		STDOUT NO TTY
+		STDERR NO TTY
+		EOF
+	fi
 
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
@@ -167,12 +177,21 @@ test_hook_tty () {
 	test_cmp expect repo/actual
 }
 
-test_expect_success TTY 'git hook run: stdout and stderr are connected to a TTY' '
-	test_hook_tty hook run pre-commit
+test_expect_success TTY 'git hook run -j1: stdout and stderr are connected to a TTY' '
+	# hooks running sequentially (-j1) are always connected to the tty for
+	# optimum real-time performance.
+	test_hook_tty tty hook run -j1 pre-commit
+'
+
+test_expect_success TTY 'git hook run -jN: stdout and stderr are not connected to a TTY' '
+	# Hooks are not connected to the tty when run in parallel, instead they
+	# output to a pipe through which run-command collects and de-interlaces
+	# their outputs, which then gets passed either to the tty or a sideband.
+	test_hook_tty no_tty hook run -j2 pre-commit
 '
 
 test_expect_success TTY 'git commit: stdout and stderr are connected to a TTY' '
-	test_hook_tty commit -m"B.new"
+	test_hook_tty tty commit -m"B.new"
 '
 
 test_expect_success 'git hook list orders by config order' '
@@ -467,4 +486,125 @@ test_expect_success 'server push-to-checkout hook expects stdout redirected to s
 	check_stdout_merged_to_stderr push-to-checkout
 '
 
+test_expect_success 'parallel hook output is not interleaved' '
+	test_when_finished "rm -rf .git/hooks" &&
+
+	write_script .git/hooks/test-hook <<-EOF &&
+	echo "Hook 1 Start"
+	sleep 1
+	echo "Hook 1 End"
+	EOF
+
+	test_config hook.hook-2.event test-hook &&
+	test_config hook.hook-2.command \
+		    "echo \"Hook 2 Start\"; sleep 2; echo \"Hook 2 End\"" &&
+	test_config hook.hook-3.event test-hook &&
+	test_config hook.hook-3.command \
+		    "echo \"Hook 3 Start\"; sleep 3; echo \"Hook 3 End\"" &&
+
+	git hook run -j3 test-hook >out 2>err.parallel &&
+
+	# Verify Hook 1 output is grouped
+	sed -n "/Hook 1 Start/,/Hook 1 End/p" err.parallel >hook1_out &&
+	test_line_count = 2 hook1_out &&
+
+	# Verify Hook 2 output is grouped
+	sed -n "/Hook 2 Start/,/Hook 2 End/p" err.parallel >hook2_out &&
+	test_line_count = 2 hook2_out &&
+
+	# Verify Hook 3 output is grouped
+	sed -n "/Hook 3 Start/,/Hook 3 End/p" err.parallel >hook3_out &&
+	test_line_count = 2 hook3_out
+'
+
+test_expect_success 'git hook run -j1 runs hooks in series' '
+	test_when_finished "rm -rf .git/hooks" &&
+
+	test_config hook.series-1.event "test-hook" &&
+	test_config hook.series-1.command "echo 1" --add &&
+	test_config hook.series-2.event "test-hook" &&
+	test_config hook.series-2.command "echo 2" --add &&
+
+	mkdir -p .git/hooks &&
+	write_script .git/hooks/test-hook <<-EOF &&
+	echo 3
+	EOF
+
+	cat >expected <<-\EOF &&
+	1
+	2
+	3
+	EOF
+
+	git hook run -j1 test-hook 2>actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git hook run -j2 runs hooks in parallel' '
+	test_when_finished "rm -rf .git/hooks" &&
+
+	mkdir -p .git/hooks &&
+	write_script .git/hooks/test-hook <<-EOF &&
+	sleep 2
+	echo "Hook 1"
+	EOF
+
+	test_config hook.hook-2.event test-hook &&
+	test_config hook.hook-2.command "sleep 2; echo Hook 2" &&
+
+	start=$(date +%s) &&
+	git hook run -j2 test-hook >out 2>err &&
+	end=$(date +%s) &&
+
+	duration=$((end - start)) &&
+	# 2 tasks of 2s. Serial >= 4s. Parallel < 4s.
+	test $duration -lt 4
+'
+
+test_expect_success 'hook.jobs=1 config runs hooks in series' '
+	test_when_finished "rm -rf .git/hooks" &&
+
+	mkdir -p .git/hooks &&
+	write_script .git/hooks/test-hook <<-EOF &&
+	sleep 2
+	echo "Hook 1"
+	EOF
+
+	test_config hook.hook-2.event test-hook &&
+	test_config hook.hook-2.command "sleep 2; echo Hook 2" &&
+
+	test_config hook.jobs 1 &&
+
+	start=$(date +%s) &&
+	git hook run test-hook >out 2>err &&
+	end=$(date +%s) &&
+
+	duration=$((end - start)) &&
+	# 2 tasks of 2s. Serial >= 4s. Parallel < 4s.
+	test $duration -ge 4
+'
+
+test_expect_success 'hook.jobs=2 config runs hooks in parallel' '
+	test_when_finished "rm -rf .git/hooks" &&
+
+	mkdir -p .git/hooks &&
+	write_script .git/hooks/test-hook <<-EOF &&
+	sleep 2
+	echo "Hook 1"
+	EOF
+
+	test_config hook.hook-2.event test-hook &&
+	test_config hook.hook-2.command "sleep 2; echo Hook 2" &&
+
+	test_config hook.jobs 2 &&
+
+	start=$(date +%s) &&
+	git hook run test-hook >out 2>err &&
+	end=$(date +%s) &&
+
+	duration=$((end - start)) &&
+	# 2 tasks of 2s. Serial >= 4s. Parallel < 4s.
+	test $duration -lt 4
+'
+
 test_done
diff --git a/transport.c b/transport.c
index 176050e663..477a598eec 100644
--- a/transport.c
+++ b/transport.c
@@ -1379,7 +1379,7 @@ static void free_pre_push_hook_data(void *data)
 static int run_pre_push_hook(struct transport *transport,
 			     struct ref *remote_refs)
 {
-	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_PARALLEL;
 	struct feed_pre_push_hook_data data;
 	int ret = 0;
 
-- 
2.52.0.732.gb351b5166d.dirty

