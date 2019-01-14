Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 673D21F62E
	for <e@80x24.org>; Mon, 14 Jan 2019 22:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfANWfD (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Jan 2019 17:35:03 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46222 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbfANWfD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jan 2019 17:35:03 -0500
Received: by mail-pf1-f195.google.com with SMTP id c73so273424pfe.13
        for <git@vger.kernel.org>; Mon, 14 Jan 2019 14:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WCY21BQWhQuNr4x2+HXtyi05VaZ884e+riav1+tEVOk=;
        b=j3UMtRSp6OAvRNNMU4/VXpMP7eEf0gcFJbA3Mwqvf2mpjW6+tp/LFAQrE4sMqikm/a
         FDIkqbZcpCAfi6cb8thXS62r6pYv7rq94sNhbcdmlK3mS2L0am42bygTtHBNuBFlG9eb
         VtzWYS/MbVQcVo8s2ExhmwVi/7rU0GbiJCviqvXoxqsIrfCO9kETfteJiYTsDfAp/FvT
         2Foux7pceeKtZd1sSYKGwswtWUR2Q1feYnaB5mgZY7tMZ/9iybMULxgQEk5HxhV1w+2j
         Uiljsqao1pamM1DecKRzjuHo9fknT8pT3NTP+tFt/hmMO05aw5k8kF6oQ1ZqftRh8s/E
         uqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WCY21BQWhQuNr4x2+HXtyi05VaZ884e+riav1+tEVOk=;
        b=IYlcg9OXLbEYgXvy5jJyxEEI+QKRO7hVOHjMxeJtxpCTpbY5yV1R5oqFw6ZMBAbAgF
         m7s3KCMEcdavdh0PU0wNoVfG31Yf1FqKyTAM7U9WZu0qQRxFIyG7Atjw/3MZRsy5EGx6
         iETdHhwiJvTkRWwemIyes+3aRuOXW6DjkQtyS8zhrTn1KBG8OHzvtlblr54nR2wSN4lt
         PIgw3vRYFArONZOaeRq3HvbsbrAaPjjIkO+LBQhp7RNS/8HKV+nAjnyARPJBS/HpUg3n
         VRo5aB59ctq7xu9HQYTRaIWNaMDvcr2qQuTsp0HIlk8gNdg0+JDynhu5pVjyCBWVRZKL
         Xrvw==
X-Gm-Message-State: AJcUukdhHTQhgPMVMSCs1DElnF5ennaEc1WI2GdJQl2HHU+5PheLFLKq
        S0KQGGkgsTrgTjRtMwhvd/c=
X-Google-Smtp-Source: ALg8bN6tuembFjGrFpb9l9vLpMbAf14Wqmuc/wvRofsaYc3Pc5yJ64eDzrFwHEevPuoO45XkotWQOg==
X-Received: by 2002:a63:e711:: with SMTP id b17mr693516pgi.363.1547505301131;
        Mon, 14 Jan 2019 14:35:01 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id 22sm1567019pgd.85.2019.01.14.14.34.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 14:35:00 -0800 (PST)
Date:   Mon, 14 Jan 2019 14:34:58 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] FYI / RFC: submodules: introduce repo-like workflow
Message-ID: <20190114223458.GF162110@google.com>
References: <20180927221603.148025-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927221603.148025-1-sbeller@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:

> Internally we have rolled out this as an experiment for
> "submodules replacing the repo tool[1]".

Thanks again for writing and explaining it.  Here's an updated
version, basically identical (just rebased).  "git range-diff" shows
mostly context lines affected, so this really is a minor update.

I suspect the *next* time this hits the list will be more interesting,
since we can start making use of the repository API.

Thoughts of all kinds welcome, as always.

-- >8 --
From: Stefan Beller <sbeller@google.com>
Date: Mon, 4 Dec 2017 15:47:40 -0800

Internally we have rolled out this as an experiment for
"submodules replacing the repo tool[1]". The repo tool is described as:

    Repo unifies Git repositories when necessary, performs uploads to the
    Gerrit revision control system, and automates parts of the Android
    development workflow. Repo is not meant to replace Git, only to make
    it easier to work with Git in the context of Android. The repo command
    is an executable Python script that you can put anywhere in your path.

    In working with the Android source files, you use Repo for
    across-network operations. For example, with a single Repo command you
    can download files from multiple repositories into your local working
    directory.

    In most situations, you can use Git instead of Repo, or mix Repo and
    Git commands to form complex commands.

[1] https://source.android.com/setup/develop/

Submodules can also be understood as unifying Git repositories, even more,
in the superproject the submodules have relationships between their
versions, which the repo tool only provides in releases.

The repo tool does not provide these relationships between versions, but
all the repositories (in case of Android think of ~1000 git repositories)
are put in their place without depending on each other.

This comes with a couple of advantages and disadvantages:

* Many users are familiar with Git, but not submodules. Each repository
  can be used independently with Git and there is no need to update the
  superproject or the repo manifest for a change in a repository.
* It is easy to work with repositories with no version-control-dependencies
  if there are dependencies in the code. In case of Android the
  repositories are bound at natural boundaries. For example the linux
  kernel is one repository, as then upstream work is made easy for this
  repository. So it is desirable to keep an easy-as-repo workflow.
* Fetching changes ("repo sync") needs to fetch all repositories, as there
  is no central place that tracks what has changed. In a superproject
  git fetch can determine which submodules need fetching.  In Androids
  case the daily change is only in a few repositories (think 10s), so
  migrating to a superproject would save an order of magnitude in fetch
  traffic for daily updates of developers.
* Sometimes when the dependencies are not on a clear repository boundary
  one would like to have git-bisect available across the different
  repositories, which repo cannot provide due to its design.

Internally we have the Gerrit as a central point, where the source of
truth is found for a given repository.

This patch adds a new mode to submodule handling, where the superproject
controls the existence of the submodule (just as current submodule
handling), but the submodule HEAD is not detached, but following the same
branch name as the superproject.

Current situation visualized:

  superproject
  HEAD -> "<branch name>" -> OID
                              |
  submodule                   v
  HEAD --------------------> OID

The OID in the submodule is controlled via the HEAD in the submodule that
is set accordingly to the gitlink in the superproject. Confusion can arise
when the (detached) HEAD in the submodule doesn't match the superprojects
gitlink.

This patch visualized:

  superproject
  HEAD -> "<branch name>" -> OID
                 |
  submodule      v
  HEAD -> "<branch name>" -> OID

As there is a central point of truth in our setup (our Gerrit installation)
which keeps the superproject and the submodule branches in sync, this
ought to look the same for the user; removing the "detached HEAD" in the
submodule. git-status will still notice if there is an OID mismatch between
the gitlink and the submodules branch, but that is a race condition and
should be caught by Gerrit.

This changes the following commands in the superproject:

  checkout -B/-b create branches in subs, too
  checkout (-f): update branch in submodule (create if needed) and check
                 it out; Pass the argument down literally if it is a branch
                 name (e.g. "checkout -f master" will run a
                            "checkout -f master" in the submodule as well)
  clone: see checkout
  reset --hard: see checkout

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-checkout.txt | 13 +++--
 Makefile                       |  1 +
 branch.c                       | 84 +++++++++++++++++++++++++++++++++
 builtin.h                      |  1 +
 builtin/branch.c               | 35 ++++++++++++++
 builtin/checkout.c             | 76 ++++++++++++++++++++++++------
 builtin/clone.c                | 12 ++++-
 builtin/reset.c                | 41 ++++++++++++++--
 entry.c                        | 51 +++++++++++++-------
 git-submodule.sh               | 24 +++++++++-
 git.c                          |  1 +
 submodule-move-head.c          | 81 ++++++++++++++++++++++++++++++++
 submodule-move-head.h          | 22 +++++++++
 submodule.c                    | 14 ++++++
 submodule.h                    |  8 +++-
 t/lib-submodule-update.sh      | 86 +++++++++++++++++++++++++++++++++-
 t/t1013-read-tree-submodule.sh |  1 +
 t/t2013-checkout-submodule.sh  |  4 ++
 t/t7112-reset-submodule.sh     |  5 ++
 unpack-trees.c                 | 20 ++++++--
 unpack-trees.h                 |  9 ++++
 21 files changed, 536 insertions(+), 53 deletions(-)
 create mode 100644 submodule-move-head.c
 create mode 100644 submodule-move-head.h

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 6acc3d98e7..d9ca9e9e24 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -268,13 +268,12 @@ section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
 	worktree.
 
 --[no-]recurse-submodules::
-	Using --recurse-submodules will update the content of all initialized
-	submodules according to the commit recorded in the superproject. If
-	local modifications in a submodule would be overwritten the checkout
-	will fail unless `-f` is used. If nothing (or --no-recurse-submodules)
-	is used, the work trees of submodules will not be updated.
-	Just like linkgit:git-submodule[1], this will detach the
-	submodules HEAD.
+	Using --recurse-submodules will update the content and current
+	branch of all initialized submodules in addition to the
+	superproject. If local modifications in a submodule would be
+	overwritten, the checkout will fail unless `-f` is used. If
+	nothing (or --no-recurse-submodules) is used, the work trees of
+	submodules will not be updated.
 
 --no-guess::
 	Do not attempt to create a branch if a remote tracking branch
diff --git a/Makefile b/Makefile
index 1a44c811aa..132c336bbf 100644
--- a/Makefile
+++ b/Makefile
@@ -989,6 +989,7 @@ LIB_OBJS += streaming.o
 LIB_OBJS += string-list.o
 LIB_OBJS += submodule.o
 LIB_OBJS += submodule-config.o
+LIB_OBJS += submodule-move-head.o
 LIB_OBJS += sub-process.o
 LIB_OBJS += symlinks.o
 LIB_OBJS += tag.o
diff --git a/branch.c b/branch.c
index 28b81a7e02..9212a0a256 100644
--- a/branch.c
+++ b/branch.c
@@ -1,9 +1,13 @@
 #include "git-compat-util.h"
 #include "cache.h"
 #include "config.h"
+#include "repository.h"
+#include "submodule.h"
 #include "branch.h"
 #include "refs.h"
 #include "refspec.h"
+#include "tree-walk.h"
+#include "run-command.h"
 #include "remote.h"
 #include "commit.h"
 #include "worktree.h"
@@ -242,6 +246,76 @@ N_("\n"
 "will track its remote counterpart, you may want to use\n"
 "\"git push -u\" to set the upstream config as you push.");
 
+static void create_branch_in_submodule(const char *name, const char *start_name,
+		   const char *start_ref, const struct object_id *start_oid,
+		   int force, int reflog, int clobber_head,
+		   int quiet, enum branch_track track,
+		   int checking_out_branch,
+		   const char *sub_path, const struct object_id *entry_oid)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+
+	trace_printf("create_branch_in_submodule %s", sub_path);
+
+	prepare_submodule_repo_env(&cp.env_array);
+	cp.git_cmd = 1;
+	cp.dir = sub_path;
+	argv_array_push(&cp.args, "branch--helper");
+	argv_array_pushf(&cp.args, "--name=%s", name);
+	if (checking_out_branch) {
+		argv_array_pushf(&cp.args, "--start_name=%s",
+				 start_ref);
+	} else {
+		argv_array_pushf(&cp.args, "--start_name=%s",
+				 oid_to_hex(entry_oid));
+	}
+	argv_array_pushf(&cp.args, "--force=%d", force);
+	argv_array_pushf(&cp.args, "--reflog=%d", reflog);
+	argv_array_pushf(&cp.args, "--clobber_head=%d", clobber_head);
+	argv_array_pushf(&cp.args, "--quiet=%d", quiet);
+	argv_array_pushf(&cp.args, "--track=%d", track);
+
+	if (run_command(&cp))
+		fprintf(stderr, "process for submodule '%s' failed", sub_path);
+	child_process_clear(&cp);
+}
+
+static void create_branch_in_submodules(const char *name, const char *start_name,
+		   const char *start_ref, const struct object_id *start_oid,
+		   int force, int reflog, int clobber_head,
+		   int quiet, enum branch_track track, struct strbuf *rec_path)
+{
+
+	int checking_out_branch = start_ref && starts_with(start_ref, "refs/heads/");
+	void *buf;
+	struct tree_desc tree;
+	struct name_entry entry;
+	int rec_path_len = rec_path->len;
+
+	buf = fill_tree_descriptor(&tree, start_oid);
+	if (!buf)
+		die("could not read %s for checkout", start_name);
+
+	while (tree_entry(&tree, &entry)) {
+
+		if (rec_path->len > 0)
+			strbuf_addch(rec_path, '/');
+		strbuf_addstr(rec_path, entry.path);
+
+		trace_printf("create_branch_in_submodules %s %o", rec_path->buf, entry.mode);
+
+		if (S_ISGITLINK(entry.mode) && is_submodule_active(the_repository, rec_path->buf))
+			create_branch_in_submodule(name, start_name, start_ref,
+						start_oid, force, reflog, clobber_head,
+						quiet, track, checking_out_branch, rec_path->buf, entry.oid);
+		else if (S_ISDIR(entry.mode)) {
+			create_branch_in_submodules(name, start_name, start_ref, entry.oid, force, reflog, clobber_head, quiet, track, rec_path);
+		}
+		strbuf_setlen(rec_path, rec_path_len);
+	}
+	free(buf);
+}
+
 void create_branch(struct repository *r,
 		   const char *name, const char *start_name,
 		   int force, int clobber_head_ok, int reflog,
@@ -251,6 +325,7 @@ void create_branch(struct repository *r,
 	struct object_id oid;
 	char *real_ref;
 	struct strbuf ref = STRBUF_INIT;
+	struct strbuf sub_path = STRBUF_INIT;
 	int forcing = 0;
 	int dont_change_ref = 0;
 	int explicit_tracking = 0;
@@ -308,6 +383,14 @@ void create_branch(struct repository *r,
 	if (reflog)
 		log_all_ref_updates = LOG_REFS_NORMAL;
 
+	/*
+	 * NEEDSWORK: Doesn't handle errors part-way through very well.
+	 */
+	trace_printf("create_branch need to update subs: %d", should_update_submodules());
+	if (behave_google_repo_like() && should_update_submodules())
+		create_branch_in_submodules(name, start_name, real_ref, &oid,
+					    force, reflog, clobber_head_ok, quiet, track, &sub_path);
+
 	if (!dont_change_ref) {
 		struct ref_transaction *transaction;
 		struct strbuf err = STRBUF_INIT;
@@ -334,6 +417,7 @@ void create_branch(struct repository *r,
 		setup_tracking(ref.buf + 11, real_ref, track, quiet);
 
 	strbuf_release(&ref);
+	strbuf_release(&sub_path);
 	free(real_ref);
 }
 
diff --git a/builtin.h b/builtin.h
index 6538932e99..68dc715392 100644
--- a/builtin.h
+++ b/builtin.h
@@ -135,6 +135,7 @@ extern int cmd_archive(int argc, const char **argv, const char *prefix);
 extern int cmd_bisect__helper(int argc, const char **argv, const char *prefix);
 extern int cmd_blame(int argc, const char **argv, const char *prefix);
 extern int cmd_branch(int argc, const char **argv, const char *prefix);
+extern int cmd_branch_helper(int argc, const char **argv, const char *prefix);
 extern int cmd_bundle(int argc, const char **argv, const char *prefix);
 extern int cmd_cat_file(int argc, const char **argv, const char *prefix);
 extern int cmd_checkout(int argc, const char **argv, const char *prefix);
diff --git a/builtin/branch.c b/builtin/branch.c
index 1be727209b..6ee45cbbaa 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -36,6 +36,11 @@ static const char * const builtin_branch_usage[] = {
 	NULL
 };
 
+static const char * const builtin_branch_helper_usage[] = {
+	N_("git branch--helper"),
+	NULL
+};
+
 static const char *head;
 static struct object_id head_oid;
 
@@ -578,6 +583,36 @@ static int edit_branch_description(const char *branch_name)
 	return 0;
 }
 
+int cmd_branch_helper(int argc, const char **argv, const char *prefix)
+{
+	const char *name = NULL, *start_name = NULL;
+	int force = 0, reflog = 0, clobber_head = 0, quiet = 0;
+	enum branch_track track = BRANCH_TRACK_NEVER;
+
+	struct option options[] = {
+		OPT_STRING(0, "name", &name, N_(""), N_("")),
+		OPT_STRING(0, "start_name", &start_name, N_(""), N_("")),
+
+		OPT_INTEGER(0, "force", &force, N_("")),
+		OPT_INTEGER(0, "reflog", &reflog, N_("")),
+		OPT_INTEGER(0, "clobber_head", &clobber_head, N_("")),
+		OPT_INTEGER(0, "quiet", &quiet, N_("")),
+
+		/* implicit int -> enum conversion */
+		OPT_INTEGER(0, "track", &track, N_("")),
+		OPT_END(),
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     builtin_branch_helper_usage, 0);
+	if (argc > 0)
+		die (_("branchhelper doesn't know about %s"), argv[0]);
+
+	create_branch(the_repository, name, start_name, force, clobber_head,
+		      reflog, quiet, track);
+	return 0;
+}
+
 int cmd_branch(int argc, const char **argv, const char *prefix)
 {
 	int delete = 0, rename = 0, copy = 0, force = 0, list = 0;
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 08b0ac48f3..5a8a4e200f 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -3,6 +3,7 @@
 #include "checkout.h"
 #include "lockfile.h"
 #include "parse-options.h"
+#include "repository.h"
 #include "refs.h"
 #include "object-store.h"
 #include "commit.h"
@@ -22,6 +23,7 @@
 #include "ll-merge.h"
 #include "resolve-undo.h"
 #include "submodule-config.h"
+#include "submodule-move-head.h"
 #include "submodule.h"
 #include "advice.h"
 
@@ -422,11 +424,24 @@ static void describe_detached_head(const char *msg, struct commit *commit)
 	strbuf_release(&sb);
 }
 
-static int reset_tree(struct tree *tree, const struct checkout_opts *o,
+struct branch_info {
+	const char *name; /* The short name used */
+	const char *path; /* The full name of a real branch */
+	struct commit *commit; /* The named commit */
+	/*
+	 * if not null the branch is detached because it's already
+	 * checked out in this checkout
+	 */
+	char *checkout;
+};
+
+static int reset_tree(struct branch_info *b, const struct checkout_opts *o,
 		      int worktree, int *writeout_error)
 {
 	struct unpack_trees_options opts;
+	struct submodule_move_head_options move_head_opts;
 	struct tree_desc tree_desc;
+	struct tree *tree = get_commit_tree(b->commit);
 
 	memset(&opts, 0, sizeof(opts));
 	opts.head_idx = -1;
@@ -438,6 +453,16 @@ static int reset_tree(struct tree *tree, const struct checkout_opts *o,
 	opts.verbose_update = o->show_progress;
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
+
+	if (behave_google_repo_like()) {
+		opts.move_head = unpack_trees_move_head;
+		memset(&move_head_opts, 0, sizeof(move_head_opts));
+		move_head_opts.force = 1;
+		move_head_opts.new_ref = b->path;
+		move_head_opts.target_ref = o->force_detach ? NULL : b->path;
+		opts.unpack_data = &move_head_opts;
+	}
+
 	parse_tree(tree);
 	init_tree_desc(&tree_desc, tree->buffer, tree->size);
 	switch (unpack_trees(1, &tree_desc, &opts)) {
@@ -457,17 +482,6 @@ static int reset_tree(struct tree *tree, const struct checkout_opts *o,
 	}
 }
 
-struct branch_info {
-	const char *name; /* The short name used */
-	const char *path; /* The full name of a real branch */
-	struct commit *commit; /* The named commit */
-	/*
-	 * if not null the branch is detached because it's already
-	 * checked out in this checkout
-	 */
-	char *checkout;
-};
-
 static void setup_branch_path(struct branch_info *branch)
 {
 	struct strbuf buf = STRBUF_INIT;
@@ -586,7 +600,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 
 	resolve_undo_clear();
 	if (opts->force) {
-		ret = reset_tree(get_commit_tree(new_branch_info->commit),
+		ret = reset_tree(new_branch_info,
 				 opts, 1, writeout_error);
 		if (ret)
 			return ret;
@@ -594,6 +608,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 		struct tree_desc trees[2];
 		struct tree *tree;
 		struct unpack_trees_options topts;
+		struct submodule_move_head_options mopts;
 
 		memset(&topts, 0, sizeof(topts));
 		topts.head_idx = -1;
@@ -609,6 +624,16 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			return 1;
 		}
 
+		if (behave_google_repo_like()) {
+			topts.move_head = unpack_trees_move_head;
+			memset(&mopts, 0, sizeof(mopts));
+			mopts.old_ref = old_branch_info->path;
+			mopts.new_ref = new_branch_info->path;
+			mopts.target_ref = opts->force_detach
+					? NULL : new_branch_info->path;
+			topts.unpack_data = &mopts;
+		}
+
 		/* 2-way merge to the new branch */
 		topts.initial_checkout = is_cache_unborn();
 		topts.update = 1;
@@ -674,7 +699,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			o.verbosity = 0;
 			work = write_tree_from_memory(&o);
 
-			ret = reset_tree(get_commit_tree(new_branch_info->commit),
+			ret = reset_tree(new_branch_info,
 					 opts, 1,
 					 writeout_error);
 			if (ret)
@@ -689,7 +714,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 					  &result);
 			if (ret < 0)
 				exit(128);
-			ret = reset_tree(get_commit_tree(new_branch_info->commit),
+			ret = reset_tree(new_branch_info,
 					 opts, 0,
 					 writeout_error);
 			strbuf_release(&o.obuf);
@@ -724,6 +749,18 @@ static void report_tracking(struct branch_info *new_branch_info)
 	strbuf_release(&sb);
 }
 
+static void create_symref_in_submodules(const char *symref, const char *target, const char *logmsg)
+{
+	int i = 0;
+	for (i = 0; i < active_nr; i++) {
+		const struct cache_entry *ce = active_cache[i];
+		if (!S_ISGITLINK(ce->ce_mode) || !is_submodule_active(the_repository, ce->name))
+			continue;
+
+		create_symref_in_submodule(ce->name, symref, target, logmsg);
+	}
+}
+
 static void update_refs_for_switch(const struct checkout_opts *opts,
 				   struct branch_info *old_branch_info,
 				   struct branch_info *new_branch_info)
@@ -734,6 +771,9 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 		if (opts->new_orphan_branch) {
 			char *refname;
 
+			if (should_update_submodules())
+				die("--orphan --recurse-submodules is not implemented");
+
 			refname = mkpathdup("refs/heads/%s", opts->new_orphan_branch);
 			if (opts->new_branch_log &&
 			    !should_autocreate_reflog(refname)) {
@@ -787,6 +827,12 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 			describe_detached_head(_("HEAD is now at"), new_branch_info->commit);
 		}
 	} else if (new_branch_info->path) {	/* Switch branches. */
+		/*
+		 * NEEDSWORK: We don't handle attachment on checkout <branch>
+		 * yet.
+		 */
+		if (opts->new_branch && should_update_submodules() && behave_google_repo_like())
+			create_symref_in_submodules("HEAD", new_branch_info->path, msg.buf);
 		if (create_symref("HEAD", new_branch_info->path, msg.buf) < 0)
 			die(_("unable to update HEAD"));
 		if (!opts->quiet) {
diff --git a/builtin/clone.c b/builtin/clone.c
index 7c7f98c72c..c91ec0f5f0 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -28,6 +28,7 @@
 #include "run-command.h"
 #include "connected.h"
 #include "packfile.h"
+#include "submodule.h"
 #include "list-objects-filter-options.h"
 #include "object-store.h"
 
@@ -744,7 +745,6 @@ static int checkout(int submodule_progress)
 		if (!starts_with(head, "refs/heads/"))
 			die(_("HEAD not found below refs/heads!"));
 	}
-	free(head);
 
 	/* We need to be in the new work tree for the checkout */
 	setup_work_tree();
@@ -773,8 +773,17 @@ static int checkout(int submodule_progress)
 			   oid_to_hex(&oid), "1", NULL);
 
 	if (!err && (option_recurse_submodules.nr > 0)) {
+		const char *branch;
 		struct argv_array args = ARGV_ARRAY_INIT;
 		argv_array_pushl(&args, "submodule", "update", "--init", "--recursive", NULL);
+		if (behave_google_repo_like()) {
+			if (!strcmp(head, "HEAD"))
+				; /* detach HEAD in submodules, too. */
+			else if (skip_prefix(head, "refs/heads/", &branch))
+				argv_array_pushl(&args, "--checkout-branch", branch, NULL);
+			else
+				BUG("HEAD not found below refs/heads!");
+		}
 
 		if (option_shallow_submodules == 1)
 			argv_array_push(&args, "--depth=1");
@@ -792,6 +801,7 @@ static int checkout(int submodule_progress)
 		argv_array_clear(&args);
 	}
 
+	free(head);
 	return err;
 }
 
diff --git a/builtin/reset.c b/builtin/reset.c
index 59898c972e..108b2b97c7 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -24,6 +24,7 @@
 #include "cache-tree.h"
 #include "submodule.h"
 #include "submodule-config.h"
+#include "submodule-move-head.h"
 
 #define REFRESH_INDEX_DELAY_WARNING_IN_MS (2 * 1000)
 
@@ -44,12 +45,16 @@ static inline int is_merge(void)
 	return !access(git_path_merge_head(the_repository), F_OK);
 }
 
-static int reset_index(const struct object_id *oid, int reset_type, int quiet)
+static int reset_index(const char *rev, const struct object_id *oid, int reset_type, int quiet)
 {
-	int i, nr = 0;
+	int i, nr = 0, flags = 0;
 	struct tree_desc desc[2];
 	struct tree *tree;
 	struct unpack_trees_options opts;
+	struct submodule_move_head_options mopts;
+	char *current_branch = NULL;
+	struct object_id discard;
+	char *new_ref = NULL;
 	int ret = -1;
 
 	memset(&opts, 0, sizeof(opts));
@@ -67,6 +72,31 @@ static int reset_index(const struct object_id *oid, int reset_type, int quiet)
 		break;
 	case HARD:
 		opts.update = 1;
+
+		if (behave_google_repo_like()) {
+			/*
+			 * Submodule handling:
+			 * - unless we are detached, attach HEAD in submodules
+			 * - if rev is a branch name, use that branch instead of oid in
+			 *   submodules.
+			 */
+			current_branch = resolve_refdup("HEAD", 0, NULL, &flags);
+			if (!(flags & REF_ISSYMREF))
+				current_branch = NULL;
+			if (dwim_ref(rev, strlen(rev), &discard, &new_ref) != 1 ||
+			    !starts_with(new_ref, "refs/heads/")) {
+				free(new_ref);
+				new_ref = NULL;
+			}
+
+			opts.move_head = unpack_trees_move_head;
+
+			memset(&mopts, 0, sizeof(mopts));
+			mopts.force = 1;
+			mopts.new_ref = new_ref;
+			mopts.target_ref = current_branch;
+			opts.unpack_data = &mopts;
+		}
 		/* fallthrough */
 	default:
 		opts.reset = 1;
@@ -103,6 +133,8 @@ static int reset_index(const struct object_id *oid, int reset_type, int quiet)
 out:
 	for (i = 0; i < nr; i++)
 		free((void *)desc[i].buffer);
+	free(current_branch);
+	free(new_ref);
 	return ret;
 }
 
@@ -321,6 +353,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		oidcpy(&oid, the_hash_algo->empty_tree);
 	} else if (!pathspec.nr) {
 		struct commit *commit;
+
 		if (get_oid_committish(rev, &oid))
 			die(_("Failed to resolve '%s' as a valid revision."), rev);
 		commit = lookup_commit_reference(the_repository, &oid);
@@ -393,9 +426,9 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 				}
 			}
 		} else {
-			int err = reset_index(&oid, reset_type, quiet);
+			int err = reset_index(rev, &oid, reset_type, quiet);
 			if (reset_type == KEEP && !err)
-				err = reset_index(&oid, MIXED, quiet);
+				err = reset_index(rev, &oid, MIXED, quiet);
 			if (err)
 				die(_("Could not reset index file to revision '%s'."), rev);
 		}
diff --git a/entry.c b/entry.c
index 0a3c451f5f..7943602f13 100644
--- a/entry.c
+++ b/entry.c
@@ -2,11 +2,23 @@
 #include "blob.h"
 #include "object-store.h"
 #include "dir.h"
+#include "unpack-trees.h"
 #include "streaming.h"
 #include "submodule.h"
 #include "progress.h"
 #include "fsmonitor.h"
 
+/* NEEDSWORK: share code with unpack-trees.c */
+static int move_head(const struct unpack_trees_options *o, const char *path, const char *old, const char *new, unsigned flags)
+{
+	if (behave_google_repo_like()) {
+		if (!o || !o->move_head)
+			return submodule_move_head(path, old, new, flags);
+		return o->move_head(o, path, old, new, flags);
+	} else
+		return submodule_move_head(path, old, new, flags);
+}
+
 static void create_directories(const char *path, int path_len,
 			       const struct checkout *state)
 {
@@ -251,7 +263,7 @@ int finish_delayed_checkout(struct checkout *state)
 	return errs;
 }
 
-static int write_entry(struct cache_entry *ce,
+static int write_entry(struct unpack_trees_options *o, struct cache_entry *ce,
 		       char *path, const struct checkout *state, int to_tempfile)
 {
 	unsigned int ce_mode_s_ifmt = ce->ce_mode & S_IFMT;
@@ -357,7 +369,7 @@ static int write_entry(struct cache_entry *ce,
 			return error("cannot create submodule directory %s", path);
 		sub = submodule_from_ce(ce);
 		if (sub)
-			return submodule_move_head(ce->name,
+			return move_head(o, ce->name,
 				NULL, oid_to_hex(&ce->oid),
 				state->force ? SUBMODULE_MOVE_HEAD_FORCE : 0);
 		break;
@@ -427,22 +439,15 @@ static void mark_colliding_entries(const struct checkout *state,
 	}
 }
 
-/*
- * Write the contents from ce out to the working tree.
- *
- * When topath[] is not NULL, instead of writing to the working tree
- * file named by ce, a temporary file is created by this function and
- * its name is returned in topath[], which must be able to hold at
- * least TEMPORARY_FILENAME_LENGTH bytes long.
- */
-int checkout_entry(struct cache_entry *ce,
-		   const struct checkout *state, char *topath)
+int unpack_trees_checkout_entry(struct unpack_trees_options *o,
+				struct cache_entry *ce,
+				const struct checkout *state, char *topath)
 {
 	static struct strbuf path = STRBUF_INIT;
 	struct stat st;
 
 	if (topath)
-		return write_entry(ce, topath, state, 1);
+		return write_entry(o, ce, topath, state, 1);
 
 	strbuf_reset(&path);
 	strbuf_add(&path, state->base_dir, state->base_dir_len);
@@ -466,10 +471,10 @@ int checkout_entry(struct cache_entry *ce,
 				if (!(st.st_mode & S_IFDIR))
 					unlink_or_warn(ce->name);
 
-				return submodule_move_head(ce->name,
+				return move_head(o, ce->name,
 					NULL, oid_to_hex(&ce->oid), 0);
 			} else
-				return submodule_move_head(ce->name,
+				return move_head(o, ce->name,
 					"HEAD", oid_to_hex(&ce->oid),
 					state->force ? SUBMODULE_MOVE_HEAD_FORCE : 0);
 		}
@@ -506,5 +511,19 @@ int checkout_entry(struct cache_entry *ce,
 		return 0;
 
 	create_directories(path.buf, path.len, state);
-	return write_entry(ce, path.buf, state, 0);
+	return write_entry(o, ce, path.buf, state, 0);
+}
+
+/*
+ * Write the contents from ce out to the working tree.
+ *
+ * When topath[] is not NULL, instead of writing to the working tree
+ * file named by ce, a temporary file is created by this function and
+ * its name is returned in topath[], which must be able to hold at
+ * least TEMPORARY_FILENAME_LENGTH bytes long.
+ */
+int checkout_entry(struct cache_entry *ce,
+		   const struct checkout *state, char *topath)
+{
+	return unpack_trees_checkout_entry(NULL, ce, state, topath);
 }
diff --git a/git-submodule.sh b/git-submodule.sh
index 5e608f8bad..1d228c9df7 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -434,6 +434,18 @@ fetch_in_submodule () (
 	esac
 )
 
+# usage: checkout_in_submoodule "$sm_path" "$command" "${branch:-}" "$rev"
+checkout_in_submodule () (
+	sanitize_submodule_env &&
+	cd "$1" &&
+	if test -n "$3"
+	then
+		$2 -B "$3" "$4"
+	else
+		$2 "$4"
+	fi
+)
+
 #
 # Update each submodule path to correct revision, using clone and checkout as needed
 #
@@ -486,6 +498,11 @@ cmd_update()
 		--recursive)
 			recursive=1
 			;;
+		--checkout-branch)
+			update="checkout"
+			checkout_dest=$2
+			shift
+			;;
 		--checkout)
 			update="checkout"
 			;;
@@ -602,6 +619,11 @@ cmd_update()
 				die "$(eval_gettext "Fetched in submodule path '\$displaypath', but it did not contain \$sha1. Direct fetching of that commit failed.")"
 			fi
 
+			if test -n "$checkout_dest" && test "$update_module" != checkout
+			then
+				die "Cannot use --checkout-branch with update mode '$update_module'"
+			fi
+
 			must_die_on_failure=
 			case "$update_module" in
 			checkout)
@@ -631,7 +653,7 @@ cmd_update()
 				die "$(eval_gettext "Invalid update mode '$update_module' for submodule path '$path'")"
 			esac
 
-			if (sanitize_submodule_env; cd "$sm_path" && $command "$sha1")
+			if checkout_in_submodule "$sm_path" "$command" "$checkout_dest" "$sha1"
 			then
 				say "$say_msg"
 			elif test -n "$must_die_on_failure"
diff --git a/git.c b/git.c
index 4d53a3d50d..3f13b4e7cf 100644
--- a/git.c
+++ b/git.c
@@ -450,6 +450,7 @@ static struct cmd_struct commands[] = {
 	{ "bisect--helper", cmd_bisect__helper, RUN_SETUP },
 	{ "blame", cmd_blame, RUN_SETUP },
 	{ "branch", cmd_branch, RUN_SETUP | DELAY_PAGER_CONFIG },
+	{ "branch--helper", cmd_branch_helper, RUN_SETUP },
 	{ "bundle", cmd_bundle, RUN_SETUP_GENTLY | NO_PARSEOPT },
 	{ "cat-file", cmd_cat_file, RUN_SETUP },
 	{ "check-attr", cmd_check_attr, RUN_SETUP },
diff --git a/submodule-move-head.c b/submodule-move-head.c
new file mode 100644
index 0000000000..4c8f49066f
--- /dev/null
+++ b/submodule-move-head.c
@@ -0,0 +1,81 @@
+#include "cache.h"
+#include "submodule-move-head.h"
+#include "repository.h"
+#include "submodule.h"
+#include "refs.h"
+#include "unpack-trees.h"
+#include "run-command.h"
+
+void create_symref_in_submodule(const char *path, const char *symref, const char *target, const char *logmsg)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+
+	/* NEEDSWORK: What about sub-submodules? */
+	prepare_submodule_repo_env(&cp.env_array);
+	cp.git_cmd = 1;
+	cp.dir = path;
+	argv_array_pushl(&cp.args, "symbolic-ref", "-m", logmsg, symref, target, NULL);
+
+	if (run_command(&cp))
+		die("process for submodule '%s' failed", path);
+}
+
+static void create_ref_in_submodule(const char *path, const char *ref, const char *value)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+
+	/* NEEDSWORK: set a reasonable reflog message. */
+	prepare_submodule_repo_env(&cp.env_array);
+	cp.git_cmd = 1;
+	cp.dir = path;
+	argv_array_pushl(&cp.args, "update-ref", ref, value, sha1_to_hex(null_sha1), NULL);
+
+	if (run_command(&cp))
+		die("process for submodule '%s' failed", path);
+}
+
+static int ref_exists_in_submodule(const char *submodule_path, const char *refname)
+{
+	struct ref_store *refs = get_submodule_ref_store(submodule_path);
+	if (!refs)
+		return 0;
+	return refs_resolve_ref_unsafe(refs, refname, RESOLVE_REF_READING, NULL, NULL) != NULL;
+}
+
+int unpack_trees_move_head(const struct unpack_trees_options *opt, const char *path, const char *old, const char *new, unsigned flags)
+{
+	struct submodule_move_head_options *o = opt->unpack_data;
+	const char *new_ref = o->new_ref;
+	const char *target_ref = o->target_ref;
+	const char *old_commit = old;
+	const char *new_commit = new;
+
+	/*
+	 * NEEDSWORK:
+	 * - set log message
+	 * - what about sub-submodules?
+	 */
+
+	if (!is_submodule_active(the_repository, path))
+		return 0;
+
+	if (old) {
+		if (o->force)
+			old_commit = "HEAD";
+		else if (o->old_ref && ref_exists_in_submodule(path, o->old_ref))
+			old_commit = o->old_ref;
+	}
+	if (new_ref && new && ref_exists_in_submodule(path, new_ref))
+		new_commit = new_ref;
+
+	if (target_ref)
+		flags |= SUBMODULE_MOVE_HEAD_SKIP_REF_UPDATE;
+	if (submodule_move_head(path, old_commit, new_commit, flags) < 0)
+		return -1;
+	if (new && target_ref && !(flags & SUBMODULE_MOVE_HEAD_DRY_RUN)) {
+		if (!ref_exists_in_submodule(path, target_ref))
+			create_ref_in_submodule(path, target_ref, new);
+		create_symref_in_submodule(path, "HEAD", target_ref, "msg");
+	}
+	return 0;
+}
diff --git a/submodule-move-head.h b/submodule-move-head.h
new file mode 100644
index 0000000000..80e2679038
--- /dev/null
+++ b/submodule-move-head.h
@@ -0,0 +1,22 @@
+#ifndef SUBMODULE_MOVE_HEAD_H
+#define SUBMODULE_MOVE_HEAD_H
+
+struct unpack_trees_options;
+
+/* NEEDSWORK: document */
+struct submodule_move_head_options {
+	int force;
+	const char *old_ref;
+	const char *new_ref;
+	const char *target_ref;
+};
+
+/*
+ * For use as unpack_trees_options.move_head. Parameters should be a
+ * struct submodule_move_head_options * in unpack_trees_options.unpack_data.
+ */
+extern int unpack_trees_move_head(const struct unpack_trees_options *opt, const char *path, const char *old, const char *new, unsigned flags);
+
+extern void create_symref_in_submodule(const char *path, const char *symref, const char *target, const char *logmsg);
+
+#endif /* SUBMODULE_MOVE_HEAD_H */
diff --git a/submodule.c b/submodule.c
index 6415cc5580..001f5eb364 100644
--- a/submodule.c
+++ b/submodule.c
@@ -30,6 +30,17 @@ static int initialized_fetch_ref_tips;
 static struct oid_array ref_tips_before_fetch;
 static struct oid_array ref_tips_after_fetch;
 
+int behave_google_repo_like(void)
+{
+	static int google_repo_like = -1;
+
+	if (google_repo_like == -1)
+		git_config_get_bool("submodule.repolike", &google_repo_like);
+
+	return google_repo_like;
+}
+
+
 /*
  * Check if the .gitmodules file is unmerged. Parsing of the .gitmodules file
  * will be disabled because we can't guess what might be configured in
@@ -1703,6 +1714,9 @@ int submodule_move_head(const char *path,
 
 	if (!(flags & SUBMODULE_MOVE_HEAD_DRY_RUN)) {
 		if (new_head) {
+			if (flags & SUBMODULE_MOVE_HEAD_SKIP_REF_UPDATE)
+				goto out;
+
 			child_process_init(&cp);
 			/* also set the HEAD accordingly */
 			cp.git_cmd = 1;
diff --git a/submodule.h b/submodule.h
index a680214c01..91ff94b0cb 100644
--- a/submodule.h
+++ b/submodule.h
@@ -124,8 +124,10 @@ int push_unpushed_submodules(struct repository *r,
  */
 int submodule_to_gitdir(struct strbuf *buf, const char *submodule);
 
-#define SUBMODULE_MOVE_HEAD_DRY_RUN (1<<0)
-#define SUBMODULE_MOVE_HEAD_FORCE   (1<<1)
+#define SUBMODULE_MOVE_HEAD_DRY_RUN             (1<<0)
+#define SUBMODULE_MOVE_HEAD_FORCE               (1<<1)
+#define SUBMODULE_MOVE_HEAD_SKIP_REF_UPDATE     (1<<2)
+
 int submodule_move_head(const char *path,
 			const char *old,
 			const char *new_head,
@@ -150,4 +152,6 @@ void absorb_git_dir_into_superproject(const char *prefix,
  */
 const char *get_superproject_working_tree(void);
 
+int behave_google_repo_like(void);
+
 #endif
diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 016391723c..71d5b506de 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -657,7 +657,16 @@ test_submodule_recursing_with_args_common() {
 			test_submodule_content sub1 origin/add_sub1
 		)
 	'
-	test_expect_success "$command: submodule branch is not changed, detach HEAD instead" '
+
+	if test "$KNOWN_FAILURE_SUBMODULE_REFS_NOT_UPDATED" = 1
+	then
+		RESULT=failure
+	else
+		RESULT=success
+	fi
+	if test "$KNOWN_DIFFERENCE_SUBMODULE_REFS_NOT_UPDATED" = "read-tree"
+	then
+	test_expect_$RESULT "$command: submodule branch is not changed, detach HEAD" '
 		prolog &&
 		reset_work_tree_to_interested add_sub1 &&
 		(
@@ -670,9 +679,82 @@ test_submodule_recursing_with_args_common() {
 			test_submodule_content sub1 origin/modify_sub1 &&
 			git -C sub1 rev-parse keep_branch >actual &&
 			test_cmp expect actual &&
-			test_must_fail git -C sub1 symbolic-ref HEAD
+			test_must_fail git -C sub1 symbolic-ref HEAD >actual
 		)
 	'
+	elif test "$KNOWN_DIFFERENCE_SUBMODULE_REFS_NOT_UPDATED" = "checkout -B current"
+	then
+	test_expect_$RESULT "$command: submodule branch is changed to 'current'" '
+		prolog &&
+		reset_work_tree_to_interested add_sub1 &&
+		(
+			cd submodule_update &&
+			git -C sub1 checkout -b keep_branch &&
+			git -C sub1 rev-parse HEAD >expect &&
+			git branch -t modify_sub1 origin/modify_sub1 &&
+			$command modify_sub1 &&
+			test_superproject_content origin/modify_sub1 &&
+			test_submodule_content sub1 origin/modify_sub1 &&
+			git -C sub1 rev-parse keep_branch >actual &&
+			test_cmp expect actual &&
+			echo refs/heads/current >expect &&
+			git -C sub1 symbolic-ref HEAD >actual &&
+			test_cmp expect actual
+		)
+	'
+	elif test "$KNOWN_DIFFERENCE_SUBMODULE_REFS_NOT_UPDATED" = "reset"
+	then
+	test_expect_$RESULT "$command: submodule branch is changed to superproject, resetting to target" '
+		prolog &&
+		reset_work_tree_to_interested add_sub1 &&
+		(
+			cd submodule_update &&
+			git -C sub1 checkout -b keep_branch &&
+			git -C sub1 rev-parse HEAD >expect &&
+			git branch -t modify_sub1 origin/modify_sub1 &&
+			git checkout -b newbranch &&
+			$command modify_sub1 &&
+
+			# we modified the wt
+			test_superproject_content origin/modify_sub1 &&
+			test_submodule_content sub1 origin/modify_sub1 &&
+
+			# keep_branch does not change
+			git -C sub1 rev-parse keep_branch >actual &&
+			test_cmp expect actual &&
+
+			# the submodule is attached to the same branch as the superproject
+			git -C sub1 symbolic-ref HEAD >actual &&
+			echo refs/heads/newbranch >expect &&
+			test_cmp expect actual
+		)
+	'
+	else
+	test_expect_$RESULT "$command: submodule branch is changed" '
+		prolog &&
+		reset_work_tree_to_interested add_sub1 &&
+		(
+			cd submodule_update &&
+			git -C sub1 checkout -b keep_branch &&
+			git -C sub1 rev-parse HEAD >expect &&
+			git branch -t modify_sub1 origin/modify_sub1 &&
+			$command modify_sub1 &&
+
+			# modified wt
+			test_superproject_content origin/modify_sub1 &&
+			test_submodule_content sub1 origin/modify_sub1 &&
+
+			# unrelated keep_branch is fine
+			git -C sub1 rev-parse keep_branch >actual &&
+			test_cmp expect actual &&
+
+			# submodule ref is checked out
+			git -C sub1 symbolic-ref HEAD >actual &&
+			echo refs/heads/modify_sub1 >expect &&
+			test_cmp expect actual
+		)
+	'
+	fi
 
 	# Replacing a tracked file with a submodule produces a checked out submodule
 	test_expect_success "$command: replace tracked file with submodule checks out submodule" '
diff --git a/t/t1013-read-tree-submodule.sh b/t/t1013-read-tree-submodule.sh
index 91a6fafcb4..de59ebd121 100755
--- a/t/t1013-read-tree-submodule.sh
+++ b/t/t1013-read-tree-submodule.sh
@@ -7,6 +7,7 @@ test_description='read-tree can handle submodules'
 
 KNOWN_FAILURE_DIRECTORY_SUBMODULE_CONFLICTS=1
 KNOWN_FAILURE_SUBMODULE_OVERWRITE_IGNORED_UNTRACKED=1
+KNOWN_DIFFERENCE_SUBMODULE_REFS_NOT_UPDATED="read-tree"
 
 test_submodule_switch_recursing_with_args "read-tree -u -m"
 
diff --git a/t/t2013-checkout-submodule.sh b/t/t2013-checkout-submodule.sh
index 8f86b5f4b2..940f0fca20 100755
--- a/t/t2013-checkout-submodule.sh
+++ b/t/t2013-checkout-submodule.sh
@@ -66,6 +66,10 @@ test_expect_success '"checkout <submodule>" honors submodule.*.ignore from .git/
 KNOWN_FAILURE_DIRECTORY_SUBMODULE_CONFLICTS=1
 test_submodule_switch_recursing_with_args "checkout"
 
+KNOWN_DIFFERENCE_SUBMODULE_REFS_NOT_UPDATED="checkout -B current"
+test_submodule_switch_recursing_with_args "checkout -B current"
+unset KNOWN_DIFFERENCE_SUBMODULE_REFS_NOT_UPDATED
+
 test_submodule_forced_switch_recursing_with_args "checkout -f"
 
 test_submodule_switch "git checkout"
diff --git a/t/t7112-reset-submodule.sh b/t/t7112-reset-submodule.sh
index a1cb9ff858..c31acc6578 100755
--- a/t/t7112-reset-submodule.sh
+++ b/t/t7112-reset-submodule.sh
@@ -8,13 +8,18 @@ test_description='reset can handle submodules'
 KNOWN_FAILURE_SUBMODULE_RECURSIVE_NESTED=1
 KNOWN_FAILURE_DIRECTORY_SUBMODULE_CONFLICTS=1
 KNOWN_FAILURE_SUBMODULE_OVERWRITE_IGNORED_UNTRACKED=1
+KNOWN_DIFFERENCE_SUBMODULE_REFS_NOT_UPDATED="reset"
 
+KNOWN_FAILURE_SUBMODULE_REFS_NOT_UPDATED=1
 test_submodule_switch_recursing_with_args "reset --keep"
 
+unset KNOWN_FAILURE_SUBMODULE_REFS_NOT_UPDATED
 test_submodule_forced_switch_recursing_with_args "reset --hard"
 
+KNOWN_FAILURE_SUBMODULE_REFS_NOT_UPDATED=1
 test_submodule_switch "git reset --keep"
 
+unset KNOWN_FAILURE_SUBMODULE_REFS_NOT_UPDATED
 test_submodule_switch "git reset --merge"
 
 test_submodule_forced_switch "git reset --hard"
diff --git a/unpack-trees.c b/unpack-trees.c
index 6d53cbfc86..f721d48f38 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -254,6 +254,16 @@ static void display_error_msgs(struct unpack_trees_options *o)
 		fprintf(stderr, _("Aborting\n"));
 }
 
+static int move_head(const struct unpack_trees_options *o, const char *path, const char *old, const char *new, unsigned flags)
+{
+	if (behave_google_repo_like()) {
+		if (!o->move_head)
+			return submodule_move_head(path, old, new, flags);
+		return o->move_head(o, path, old, new, flags);
+	} else
+		return submodule_move_head(path, old, new, flags);
+}
+
 static int check_submodule_move_head(const struct cache_entry *ce,
 				     const char *old_id,
 				     const char *new_id,
@@ -268,7 +278,7 @@ static int check_submodule_move_head(const struct cache_entry *ce,
 	if (o->reset)
 		flags |= SUBMODULE_MOVE_HEAD_FORCE;
 
-	if (submodule_move_head(ce->name, old_id, new_id, flags))
+	if (move_head(o, ce->name, old_id, new_id, flags))
 		return o->gently ? -1 :
 				   add_rejected_path(o, ERROR_WOULD_LOSE_SUBMODULE, ce->name);
 	return 0;
@@ -304,12 +314,12 @@ static void load_gitmodules_file(struct index_state *index,
  * Unlink the last component and schedule the leading directories for
  * removal, such that empty directories get removed.
  */
-static void unlink_entry(const struct cache_entry *ce)
+static void unlink_entry(const struct unpack_trees_options *o, const struct cache_entry *ce)
 {
 	const struct submodule *sub = submodule_from_ce(ce);
 	if (sub) {
 		/* state.force is set at the caller. */
-		submodule_move_head(ce->name, "HEAD", NULL,
+		move_head(o, ce->name, "HEAD", NULL,
 				    SUBMODULE_MOVE_HEAD_FORCE);
 	}
 	if (!check_leading_path(ce->name, ce_namelen(ce)))
@@ -408,7 +418,7 @@ static int check_updates(struct unpack_trees_options *o)
 		if (ce->ce_flags & CE_WT_REMOVE) {
 			display_progress(progress, ++cnt);
 			if (o->update && !o->dry_run)
-				unlink_entry(ce);
+				unlink_entry(o, ce);
 		}
 	}
 	remove_marked_cache_entries(index);
@@ -450,7 +460,7 @@ static int check_updates(struct unpack_trees_options *o)
 			display_progress(progress, ++cnt);
 			ce->ce_flags &= ~CE_UPDATE;
 			if (o->update && !o->dry_run) {
-				errs |= checkout_entry(ce, &state, NULL);
+				errs |= unpack_trees_checkout_entry(o, ce, &state, NULL);
 			}
 		}
 	}
diff --git a/unpack-trees.h b/unpack-trees.h
index 0135080a7b..ad98157d6e 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -9,12 +9,15 @@
 #define MAX_UNPACK_TREES 8
 
 struct cache_entry;
+struct tree_desc;
 struct unpack_trees_options;
 struct exclude_list;
 
 typedef int (*merge_fn_t)(const struct cache_entry * const *src,
 		struct unpack_trees_options *options);
 
+typedef int (*submodule_move_head_fn)(const struct unpack_trees_options *o, const char *path, const char *old, const char *new, unsigned flags);
+
 enum unpack_trees_error_types {
 	ERROR_WOULD_OVERWRITE = 0,
 	ERROR_NOT_UPTODATE_FILE,
@@ -65,6 +68,7 @@ struct unpack_trees_options {
 	struct dir_struct *dir;
 	struct pathspec *pathspec;
 	merge_fn_t fn;
+	submodule_move_head_fn move_head;
 	const char *msgs[NB_UNPACK_TREES_ERROR_TYPES];
 	struct argv_array msgs_to_free;
 	/*
@@ -86,6 +90,11 @@ struct unpack_trees_options {
 	struct exclude_list *el; /* for internal use */
 };
 
+/* defined in entry.c, for internal use */
+int unpack_trees_checkout_entry(struct unpack_trees_options *o,
+				struct cache_entry *ce,
+				const struct checkout *state, char *topath);
+
 int unpack_trees(unsigned n, struct tree_desc *t,
 		 struct unpack_trees_options *options);
 
-- 
2.20.1.97.g81188d93c3

