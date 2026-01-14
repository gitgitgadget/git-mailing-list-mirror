Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EE82F5306
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 07:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768376887; cv=none; b=RqS6BYaivW4zgiXHL9ls7LA9QTtvbIynl8XudBH3c3HfpHCeJvd9B4OuvzRyKmME6sv5bgwMpy5C5/alQHx1kBmTjyy1Ly9W2KJ4bqFAOMTroj8bWUAv0nklN9Z/SKOJwynMhZoxUyOE6JJRhAtj7QT1jou4VMxHoEVob5bMgr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768376887; c=relaxed/simple;
	bh=WHHMknR1Scx0+5GijyYBZBTT+ePImuEcpT1oHOzGRH0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tcJeL01LZlLyzAl9GeLNZKwXycd9i4YfsxpAXhCMjO67TjVbYHi6wEnHx4DLr1G5iPdKugbasmx9NQjgeQDalzpFusfYGBd2uGecWGOuTjJfIkWKYlne3PdbhtX+FJebJL9ULfjY4cJoWErekfQ5p1xi0JqkWEfbceRmQFS5UdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=igns0wHq; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igns0wHq"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-11f1fb91996so220236c88.1
        for <git@vger.kernel.org>; Tue, 13 Jan 2026 23:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768376882; x=1768981682; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mXM7mF1HiS0ng3CWKMJvwSu/S+v/C0nAj36+sqS09cM=;
        b=igns0wHqe0vpSzRVnckWb2W4hf3YtuXpgBu+X7n7enGV2BTfNpYNXdHFB0z+tEpxNI
         ZEA4h2gx9ARqKmRarHeVdwSaUw0C8OoWursKb7bChsLr4dG7TFq4HOzjW4QCwC682g19
         nC+TCog0NMoDdcqU42DsXlO0RRyK+JpFOKgil+UPX2sbN0Dw5FZf/QKrE7NQAXqa8OK1
         UZKA1PRHVWIUhrJK43wj9GSL8DQNaalXRumAjqY0hXkq+IAPNwE3KVJlsV4+A5+iay/q
         TwNpK0IpcChA0w2HBixBaRZBK/cxDV9uxPT7UVcFhZFe7pvpVakmnv01aoupruGLcJhE
         pi8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768376882; x=1768981682;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mXM7mF1HiS0ng3CWKMJvwSu/S+v/C0nAj36+sqS09cM=;
        b=WqLcCbo9xCHULlLFM8i+32wf4tm8F4KnNky/vHJ9VBGrUrR6BA0wWRCGatCIVlVvwz
         AfLVtdcD8p0MhYKTsIWgfdH1ld1xCOj0cYApAiteMT5HZPsLI0l6xUyfppygZ9XY79bO
         N+c5BPeBrtAioaEcQIj/dEA3ifRCGEfKCwkDKVrp8GoLt80HdM6y+knctY4ZXCuxsYlK
         52S28Af1enTWUHPLM+fQA1i4ulePFulMEHsi+a1xpUVRbyYFNYMhJizj6dqKR9z7div3
         8RMoy5MQom6m/x+t4t1RLfVcdAiqNrRlNaBqhwqbGIEOdNE8V08+vB4VPtP1gIVcV+St
         bLEA==
X-Gm-Message-State: AOJu0YxWUECANYu4+IALz1PvjiEmNXEF8Uh54kwG+rtP8sZSwuPkYoqb
	Zo4sWpPcJgkef3TLHJMGN1ocSdktR9x+Y+9pmOSWaTouYzObniCenVtUvrVsPw==
X-Gm-Gg: AY/fxX6Gp7T+v3CmB51BV8ebA6OBwrJfvfW1crT1GZnYD78D64wuZp5A7TMmSWLHNe6
	oAk0chzt3/ON8VD0eGsC9gsVrhkZh5QhIxoHj5W9XxjnPKYWPwqmasKURqkJPicQMlGGWajwnAg
	Gx4/s+TtM6ge/oXL4IBq03n5tU4KLdvBUM2XefWObHQ+0cHa6bdjH8zHsbqSOnmUb8QbtjcEp05
	U5vlbJmTcLxoYeqOUaF1SfTn2vEaL0H7324Ir5jr5Cb0SAyb2/dEfd6tzrNIsC1ZLHozt2WFe/L
	kiBFYB6QG//gM3LiyDz/CMBOqaLa6nUmZfv0V+H/SLYMjpnH5c9hFPb2OFTfosuAtu3af1yiAIm
	pkENuagZsD6mGjv5H61V/zVAySkuRGZTVgWiOG8ZXmV1Tntp3thjUz82c0GxQ9LhDn+0szDVOdA
	nbrgPclIvvF9hH2A==
X-Received: by 2002:a05:7022:e803:b0:119:e569:f268 with SMTP id a92af1059eb24-12336a6403fmr1879641c88.17.1768376881269;
        Tue, 13 Jan 2026 23:48:01 -0800 (PST)
Received: from [127.0.0.1] ([128.24.160.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f243421esm30288307c88.2.2026.01.13.23.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 23:48:00 -0800 (PST)
Message-Id: <pull.1987.v3.git.1768376879.gitgitgadget@gmail.com>
In-Reply-To: <pull.1987.v2.git.1763057433.gitgitgadget@gmail.com>
References: <pull.1987.v2.git.1763057433.gitgitgadget@gmail.com>
From: "Claus Schneider via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 14 Jan 2026 07:47:54 +0000
Subject: [PATCH v3 0/5] git-add: Skip submodules with ignore=all unless --force and explicit path
 used
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason <avarab@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    Brandon Williams <bwilliams.eng@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Claus Schneider <claus.schneider@eficode.com>,
    Claus Schneider <claus.schneider@eficode.com>

The ignore=all configuration for submodules is currently honored by status
and diff, but not by add. This inconsistency causes friction when working
with submodules:

 * Developers unintentionally stage submodule updates, leading to conflicts
   and unnecessary changes.
 * Tracking branches in submodule configs causes friction as updates to the
   submodule SHA1 are added without intent.

This patch aligns git add with the behavior of status and diff:

 * Submodules marked ignore=all are skipped by default.
 * Attempting to add such a submodule explicitly now requires --force.

A submodule can frictionless track a branch in the configuration or manually
switched to and use update --update --remote without unintentionally add the
changes to the super-project.

Tests that previously added submodules without --force have been updated
accordingly. A new test is added to test the behavior of git add with and
without --force.

Claus Schneider(Eficode) (5):
  read-cache: update add_files_to_cache take param ignored_too
  read-cache: submodule add need --force given ignore=all configuration
  tests: t2206-add-submodule-ignored: ignore=all and add --force tests
  tests: fix existing tests when add an ignore=all submodule
  Documentation: update add --force option + ignore=all config

 Documentation/config/submodule.adoc |  13 +--
 Documentation/git-add.adoc          |   5 +-
 Documentation/gitmodules.adoc       |   5 +-
 builtin/add.c                       |   2 +-
 builtin/checkout.c                  |   2 +-
 builtin/commit.c                    |   2 +-
 read-cache-ll.h                     |   2 +-
 read-cache.c                        |  80 ++++++++++++++++-
 t/lib-submodule-update.sh           |   6 +-
 t/meson.build                       |   1 +
 t/t2206-add-submodule-ignored.sh    | 134 ++++++++++++++++++++++++++++
 t/t7508-status.sh                   |   2 +-
 12 files changed, 235 insertions(+), 19 deletions(-)
 create mode 100755 t/t2206-add-submodule-ignored.sh


base-commit: 9a2fb147f2c61d0cab52c883e7e26f5b7948e3ed
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1987%2FPraqma%2Frespect-submodule-ignore-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1987/Praqma/respect-submodule-ignore-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1987

Range-diff vs v2:

 1:  5796009122 ! 1:  d2b66286c2 read-cache: update add_files_to_cache take param include_ignored_submodules
     @@ Metadata
      Author: Claus Schneider(Eficode) <claus.schneider@eficode.com>
      
       ## Commit message ##
     -    read-cache: update add_files_to_cache take param include_ignored_submodules
     +    read-cache: update add_files_to_cache take param ignored_too
      
     -    The include_ignored_submodules parameter is added to the function
     +    The ignored_too parameter is added to the function
          add_files_to_cache for usage of explicit updating the index for the updated
          submodule using the explicit patchspec to the submodule.
      
          Signed-off-by: Claus Schneider(Eficode) <claus.schneider@eficode.com>
      
       ## builtin/add.c ##
     -@@ builtin/add.c: N_("The following paths are ignored by one of your .gitignore files:\n");
     - static int verbose, show_only, ignored_too, refresh_only;
     - static int ignore_add_errors, intent_to_add, ignore_missing;
     - static int warn_on_embedded_repo = 1;
     -+static int include_ignored_submodules;
     - 
     - #define ADDREMOVE_DEFAULT 1
     - static int addremove = ADDREMOVE_DEFAULT;
     -@@ builtin/add.c: static struct option builtin_add_options[] = {
     - 	OPT_BOOL( 0 , "ignore-errors", &ignore_add_errors, N_("just skip files which cannot be added because of errors")),
     - 	OPT_BOOL( 0 , "ignore-missing", &ignore_missing, N_("check if - even missing - files are ignored in dry run")),
     - 	OPT_BOOL(0, "sparse", &include_sparse, N_("allow updating entries outside of the sparse-checkout cone")),
     -+    OPT_BOOL(0, "include-ignored-submodules", &include_ignored_submodules, N_("add submodules even if they has configuration ignore=all")),
     - 	OPT_STRING(0, "chmod", &chmod_arg, "(+|-)x",
     - 		   N_("override the executable bit of the listed files")),
     - 	OPT_HIDDEN_BOOL(0, "warn-embedded-repo", &warn_on_embedded_repo,
      @@ builtin/add.c: int cmd_add(int argc,
       	else
       		exit_status |= add_files_to_cache(repo, prefix,
       						  &pathspec, ps_matched,
      -						  include_sparse, flags);
     -+						  include_sparse, flags, include_ignored_submodules);
     ++						  include_sparse, flags, ignored_too);
       
       	if (take_worktree_changes && !add_renormalize && !ignore_add_errors &&
       	    report_path_error(ps_matched, &pathspec))
     @@ builtin/checkout.c: static int merge_working_tree(const struct checkout_opts *op
       
       			add_files_to_cache(the_repository, NULL, NULL, NULL, 0,
      -					   0);
     -+					   0, 0 );
     ++					0, 0);
       			init_ui_merge_options(&o, the_repository);
       			o.verbosity = 0;
       			work = write_in_core_index_as_tree(the_repository);
     @@ read-cache.c: void overlay_tree_on_index(struct index_state *istate,
       	int include_sparse;
       	int flags;
       	int add_errors;
     -+	int include_ignored_submodules;
     ++	int ignored_too;
       };
       
       static int fix_unmerged_status(struct diff_filepair *p,
     @@ read-cache.c: static void update_callback(struct diff_queue_struct *q,
       		case DIFF_STATUS_MODIFIED:
      -		case DIFF_STATUS_TYPE_CHANGED:
      +		case DIFF_STATUS_TYPE_CHANGED: {
     -+			struct stat st;
     -+			if (!lstat(path, &st) && S_ISDIR(st.st_mode)) { // only consider submodule if it is a directory
     -+				const struct submodule *sub = submodule_from_path(data->repo, null_oid(the_hash_algo), path);
     -+				if (sub && sub->name && sub->ignore && !strcmp(sub->ignore, "all")) {
     -+					int pathspec_matches = 0;
     -+					char *norm_pathspec = NULL;
     -+					int ps_i;
     -+					trace_printf("ignore=all %s\n", path);
     -+					trace_printf("pathspec %s\n",
     -+							(data->pathspec && data->pathspec->nr) ? "has pathspec" : "no pathspec");
     -+					/* Safely scan all pathspec items (q->nr may exceed pathspec->nr). */
     -+					if (data->pathspec) {
     -+						for (ps_i = 0; ps_i < data->pathspec->nr; ps_i++) {
     -+							const char *m = data->pathspec->items[ps_i].match;
     -+							if (!m)
     -+								continue;
     -+							norm_pathspec = xstrdup(m);
     -+							strip_dir_trailing_slashes(norm_pathspec);
     -+							if (!strcmp(path, norm_pathspec)) {
     -+								pathspec_matches = 1;
     -+								FREE_AND_NULL(norm_pathspec);
     -+								break;
     -+							}
     -+							FREE_AND_NULL(norm_pathspec);
     -+						}
     -+					}
     -+					if (pathspec_matches) {
     -+						if (data->include_ignored_submodules && data->include_ignored_submodules > 0) {
     -+							trace_printf("Add ignored=all submodule due to --include_ignored_submodules: %s\n", path);
     -+						} else {
     -+							printf(_("Skipping submodule due to ignore=all: %s"), path);
     -+							printf(_("Use --include_ignored_submodules, if you really want to add them.") );
     -+							continue;
     -+						}
     -+					} else {
     -+						/* No explicit pathspec match -> skip silently (or with trace). */
     -+						trace_printf("pathspec does not match %s\n", path);
     -+						continue;
     -+					}
     -+				}
     -+			}
       			if (add_file_to_index(data->index, path, data->flags)) {
       				if (!(data->flags & ADD_CACHE_IGNORE_ERRORS))
       					die(_("updating files failed"));
     @@ read-cache.c: static void update_callback(struct diff_queue_struct *q,
       int add_files_to_cache(struct repository *repo, const char *prefix,
       		       const struct pathspec *pathspec, char *ps_matched,
      -		       int include_sparse, int flags)
     -+		       int include_sparse, int flags, int include_ignored_submodules )
     ++		       int include_sparse, int flags, int ignored_too )
       {
     + 	struct odb_transaction *transaction;
       	struct update_callback_data data;
     - 	struct rev_info rev;
      @@ read-cache.c: int add_files_to_cache(struct repository *repo, const char *prefix,
       	data.index = repo->index;
       	data.include_sparse = include_sparse;
       	data.flags = flags;
      +	data.repo = repo;
     -+	data.include_ignored_submodules = include_ignored_submodules;
     ++	data.ignored_too = ignored_too;
      +	data.pathspec = (struct pathspec *)pathspec;
       
       	repo_init_revisions(repo, &rev, prefix);
 2:  9ec79b9a11 ! 2:  de72bf0a91 read-cache: add/read-cache respect submodule ignore=all
     @@ Metadata
      Author: Claus Schneider(Eficode) <claus.schneider@eficode.com>
      
       ## Commit message ##
     -    read-cache: add/read-cache respect submodule ignore=all
     +    read-cache: submodule add need --force given ignore=all configuration
      
          Submodules configured with ignore=all are now skipped during add operations
     -    unless overridden by --include-ignored-submodules and the submodule path is
     -    explicitly specified.
     +    unless overridden by --force and the submodule path is explicitly specified.
      
          A message is printed (like ignored files) guiding the user to use the
     -    --include-ignored-submodules flag if the user has explicitely want to update
     -    the submodule reference.
     +    --force flag if the user has explicitely want to update the submodule
     +    reference.
      
          The reason for the change is support submodule branch tracking or
     -    similar and git status state nothing and git add should not add either.
     -    The workflow is more logic and similar to regular ignored files even
     -    the submodule is already tracked.
     +    similar and git status states nothing and git add should not add either
     +    as a default behaviour. The workflow is more logic and similar to regular
     +    ignored files even the submodule is already tracked.
      
          The change opens up a lot of possibilities for submodules to be used
          more freely and simular to the repo tool. A submodule can be added for many
     @@ read-cache.c
       #include "hook.h"
      +#include "submodule.h"
      +#include "submodule-config.h"
     ++#include "advice.h"
       
       /* Mask for the name length in ce_flags in the on-disk index */
       
     -@@ read-cache.c: static void update_callback(struct diff_queue_struct *q,
     - 					}
     - 					if (pathspec_matches) {
     - 						if (data->include_ignored_submodules && data->include_ignored_submodules > 0) {
     --							trace_printf("Add ignored=all submodule due to --include_ignored_submodules: %s\n", path);
     -+							trace_printf("Add submodule due to --include_ignored_submodules: %s\n", path);
     - 						} else {
     - 							printf(_("Skipping submodule due to ignore=all: %s"), path);
     - 							printf(_("Use --include_ignored_submodules, if you really want to add them.") );
     -@@ read-cache.c: static void update_callback(struct diff_queue_struct *q,
     - 						}
     - 					} else {
     - 						/* No explicit pathspec match -> skip silently (or with trace). */
     --						trace_printf("pathspec does not match %s\n", path);
     -+						trace_printf("Pathspec to submodule does not match explicitly: %s\n", path);
     - 						continue;
     - 					}
     - 				}
     -@@ read-cache.c: static void update_callback(struct diff_queue_struct *q,
     - 				data->add_errors++;
     - 			}
     - 			break;
     +@@ read-cache.c: static int fix_unmerged_status(struct diff_filepair *p,
     + 		return DIFF_STATUS_MODIFIED;
     + }
     + 
     ++static int skip_submodule(const char *path,
     ++						struct repository *repo,
     ++						struct pathspec *pathspec,
     ++						int ignored_too)
     ++{
     ++    struct stat st;
     ++    const struct submodule *sub;
     ++    int pathspec_matches = 0;
     ++    int ps_i;
     ++    char *norm_pathspec = NULL;
     ++
     ++    /* Only consider if path is a directory */
     ++    if (lstat(path, &st) || !S_ISDIR(st.st_mode))
     ++		return 0;
     ++
     ++    /* Check if it's a submodule with ignore=all */
     ++    sub = submodule_from_path(repo, null_oid(the_hash_algo), path);
     ++    if (!sub || !sub->name || !sub->ignore || strcmp(sub->ignore, "all"))
     ++		return 0;
     ++
     ++    trace_printf("ignore=all: %s\n", path);
     ++    trace_printf("pathspec %s\n", (pathspec && pathspec->nr)
     ++									? "has pathspec"
     ++									: "no pathspec");
     ++
     ++    /* Check if submodule path is explicitly mentioned in pathspec */
     ++    if (pathspec) {
     ++		for (ps_i = 0; ps_i < pathspec->nr; ps_i++) {
     ++			const char *m = pathspec->items[ps_i].match;
     ++			if (!m)
     ++				continue;
     ++			norm_pathspec = xstrdup(m);
     ++			strip_dir_trailing_slashes(norm_pathspec);
     ++			if (!strcmp(path, norm_pathspec)) {
     ++				pathspec_matches = 1;
     ++				FREE_AND_NULL(norm_pathspec);
     ++				break;
     ++			}
     ++			FREE_AND_NULL(norm_pathspec);
      +		}
     - 		case DIFF_STATUS_DELETED:
     - 			if (data->flags & ADD_CACHE_IGNORE_REMOVAL)
     - 				break;
     ++    }
     ++
     ++    /* If explicitly matched and forced, allow adding */
     ++    if (pathspec_matches) {
     ++		if (ignored_too && ignored_too > 0) {
     ++			trace_printf("Add submodule due to --force: %s\n", path);
     ++			return 0;
     ++		} else {
     ++			advise_if_enabled(ADVICE_ADD_IGNORED_FILE,
     ++				_("Skipping submodule due to ignore=all: %s\n"
     ++					"Use --force if you really want to add the submodule."), path);
     ++			return 1;
     ++		}
     ++    }
     ++
     ++    /* No explicit pathspec match -> skip silently */
     ++    trace_printf("Pathspec to submodule does not match explicitly: %s\n", path);
     ++    return 1;
     ++}
     ++
     + static void update_callback(struct diff_queue_struct *q,
     +-			    struct diff_options *opt UNUSED, void *cbdata)
     ++							struct diff_options *opt UNUSED, void *cbdata)
     + {
     + 	int i;
     + 	struct update_callback_data *data = cbdata;
     +@@ read-cache.c: static void update_callback(struct diff_queue_struct *q,
     + 		const char *path = p->one->path;
     + 
     + 		if (!data->include_sparse &&
     +-		    !path_in_sparse_checkout(path, data->index))
     ++			!path_in_sparse_checkout(path, data->index))
     + 			continue;
     + 
     + 		switch (fix_unmerged_status(p, data)) {
     + 		default:
     + 			die(_("unexpected diff status %c"), p->status);
     + 		case DIFF_STATUS_MODIFIED:
     +-		case DIFF_STATUS_TYPE_CHANGED: {
     ++		case DIFF_STATUS_TYPE_CHANGED:
     ++			if (skip_submodule(path, data->repo,
     ++								data->pathspec,
     ++								data->ignored_too))
     ++				continue;
     ++
     + 			if (add_file_to_index(data->index, path, data->flags)) {
     + 				if (!(data->flags & ADD_CACHE_IGNORE_ERRORS))
     + 					die(_("updating files failed"));
 3:  399a153b95 ! 3:  d7b97e12d3 tests: add new t2206-add-submodule-ignored.sh to test ignore=all scenario
     @@ Metadata
      Author: Claus Schneider(Eficode) <claus.schneider@eficode.com>
      
       ## Commit message ##
     -    tests: add new t2206-add-submodule-ignored.sh to test ignore=all scenario
     +    tests: t2206-add-submodule-ignored: ignore=all and add --force tests
      
          The tests verify that the submodule behavior is intact and updating the
          config with ignore=all also behaves as intended with configuration in
          .gitmodules and configuration given on the command line.
      
     -    The usage of --include_ignored_submodules is showcased and tested in the
     -    test suite.
     +    The usage of --force is showcased and tested in the test suite.
      
          The test file is added to meson.build for execution.
      
     @@ t/t2206-add-submodule-ignored.sh (new)
      +# This test covers the behavior of "git add", "git status" and "git log" when
      +# dealing with submodules that have the ignore=all setting in
      +# .gitmodules. It ensures that changes in such submodules are
     -+# ignored by default, but can be staged with "git add --include-ignored-submodules".
     ++# ignored by default, but can be staged with "git add --force".
      +
      +# shellcheck disable=SC1091
      +. ./test-lib.sh
     @@ t/t2206-add-submodule-ignored.sh (new)
      +'
      +
      +#6
     -+# check that 'git add --include-ignored-submodules .' does not stage the change in the submodule
     ++# check that 'git add --force .' does not stage the change in the submodule
      +# and that 'git status' does not show it as modified
     -+test_expect_success 'main: check --include-ignored-submodules add . and status'  '
     ++test_expect_success 'main: check --force add . and status'  '
      +	cd "${base_path}" &&
      +	cd main &&
     -+	GIT_TRACE=1 git add --include-ignored-submodules . &&
     ++	GIT_TRACE=1 git add --force . &&
      +	! git status --porcelain | grep "^M  sub$" &&
      +	echo
      +'
     @@ t/t2206-add-submodule-ignored.sh (new)
      +test_expect_success 'main: check _add sub_ and status'  '
      +	cd "${base_path}" &&
      +	cd main &&
     -+	GIT_TRACE=1 git add sub | grep "Skipping submodule due to ignore=all: sub" &&
     ++	GIT_TRACE=1 git add sub 2>&1 | grep "Skipping submodule due to ignore=all: sub" &&
      +	! git status --porcelain | grep "^M  sub$" &&
      +	echo
      +'
      +
      +#8
     -+# check that 'git add --include-ignored-submodules sub' does stage the change in the submodule
     -+# check that 'git add --include-ignored-submodules ./sub/' does stage the change in the submodule
     ++# check that 'git add --force sub' does stage the change in the submodule
     ++# check that 'git add --force ./sub/' does stage the change in the submodule
      +# and that 'git status --porcelain' does show it as modified
      +# commit it..
      +# check that 'git log --ignore-submodules=none' shows the submodule change
     @@ t/t2206-add-submodule-ignored.sh (new)
      +test_expect_success 'main: check force add sub and ./sub/ and status'  '
      +	cd "${base_path}" &&
      +	cd main &&
     -+	echo "Adding with --include-ignored-submodules should work: git add --include-ignored-submodules sub" &&
     -+	GIT_TRACE=1 git add --include-ignored-submodules sub &&
     ++	echo "Adding with --force should work: git add --force sub" &&
     ++	GIT_TRACE=1 git add --force sub &&
      +	git status --porcelain | grep "^M  sub$" &&
      +	git restore --staged sub &&
      +	! git status --porcelain | grep "^M  sub$" &&
     -+	echo "Adding with --include-ignored-submodules should work: git add --include-ignored-submodules ./sub/" &&
     -+	GIT_TRACE=1 git add --include-ignored-submodules ./sub/ &&
     ++	echo "Adding with --force should work: git add --force ./sub/" &&
     ++	GIT_TRACE=1 git add --force ./sub/ &&
      +	git status --porcelain | grep "^M  sub$" &&
      +	git commit -m "update submodule pointer" &&
      +	! git status --porcelain | grep "^ M sub$" &&
 4:  93c95954f1 ! 4:  6e44ab6804 tests: fix existing tests when add an ignore=all submodule
     @@ Metadata
       ## Commit message ##
          tests: fix existing tests when add an ignore=all submodule
      
     -    There are tests that rely on "git add <submodule>" to add updates in the
     -    parent repository. A new option --include-ignored-submodules is introduced
     -    as it is now needed with this enhancement.
     +    There are tests that rely on "git add <submodule>" to update the in the
     +    reference in the parent repository which have been updated to use the
     +    --force option.
      
          Updated tests:
          - t1013-read-tree-submodule.sh ( fixed in: t/lib-submodule-update.sh )
     @@ t/lib-submodule-update.sh: create_lib_submodule_repo () {
       			git push origin modifications
       		) &&
      -		git add sub1 &&
     -+		git add --include-ignored-submodules sub1 &&
     ++		git add --force sub1 &&
       		git commit -m "Modify sub1" &&
       
       		git checkout -b add_nested_sub modify_sub1 &&
     @@ t/lib-submodule-update.sh: create_lib_submodule_repo () {
       		git -C sub1 submodule add --branch no_submodule ../submodule_update_sub2 sub2 &&
       		git -C sub1 commit -a -m "add a nested submodule" &&
      -		git add sub1 &&
     -+		git add --include-ignored-submodules sub1 &&
     ++		git add --force sub1 &&
       		git commit -a -m "update submodule, that updates a nested submodule" &&
       		git checkout -b modify_sub1_recursively &&
       		git -C sub1 checkout -b modify_sub1_recursively &&
     @@ t/lib-submodule-update.sh: create_lib_submodule_repo () {
       		git -C sub1 add sub2 &&
       		git -C sub1 commit -m "update nested sub" &&
      -		git add sub1 &&
     -+		git add --include-ignored-submodules sub1 &&
     ++		git add --force sub1 &&
       		git commit -m "update sub1, that updates nested sub" &&
       		git -C sub1 push origin modify_sub1_recursively &&
       		git -C sub1/sub2 push origin modify_sub1_recursively &&
     @@ t/t7508-status.sh: test_expect_success 'git commit will commit a staged but igno
       test_expect_success 'git commit --dry-run will show a staged but ignored submodule' '
       	git reset HEAD^ &&
      -	git add sm &&
     -+	git add --include-ignored-submodules sm &&
     ++	git add --force sm &&
       	cat >expect << EOF &&
       On branch main
       Your branch and '\''upstream'\'' have diverged,
 5:  ee84190cd8 ! 5:  37fe7956e0 Documentation: add --include_ignored_submodules + ignore=all config
     @@ Metadata
      Author: Claus Schneider(Eficode) <claus.schneider@eficode.com>
      
       ## Commit message ##
     -    Documentation: add --include_ignored_submodules + ignore=all config
     +    Documentation: update add --force option + ignore=all config
      
     -    - git-add.adoc: Add new documentation for --include_ignored_submodules
     -      option to supress ignore=all and new submodule functionality of not
     -      adding a ignore=all submodule by default.
     +    - git-add.adoc: Update the --force documentation for submodule behaviour
     +      to be added even the given configuration ignore=all.
          - gitmodules.adoc and config/submodule.adoc: The submodule config
     -      ignore=all now need --include_ignored_submodules in order to update
     -      the index.
     +      ignore=all now need --force in order to update the index.
      
          Signed-off-by: Claus Schneider(Eficode) <claus.schneider@eficode.com>
      
     - ## .devcontainer/Dockerfile (new) ##
     -@@
     -+FROM ubuntu:latest
     -+
     -+ARG USER_ID
     -+ARG GROUP_ID
     -+
     -+ENV DEBIAN_FRONTEND=noninteractive
     -+ENV TZ=Europe/Copenhagen
     -+
     -+RUN apt-get update \
     -+    && \
     -+    apt-get install -y \
     -+        sudo \
     -+        build-essential \
     -+        libcurl4-gnutls-dev \
     -+        libexpat1-dev \
     -+        gettext \
     -+        libz-dev \
     -+        libssl-dev \
     -+        asciidoc \
     -+        xmlto \
     -+        docbook-xsl \
     -+        \
     -+        tzdata \
     -+        git \
     -+        coccinelle \
     -+    && \
     -+    ln -fs /usr/share/zoneinfo/$TZ /etc/localtime \
     -+    && \
     -+    dpkg-reconfigure --frontend noninteractive tzdata
     -+
     -+RUN  apt-get update && apt-get install -y autoconf
     -+
     -+RUN addgroup -gid 1001 gituser
     -+RUN adduser --disabled-password -u 1001 -gid 1001 gituser
     -+RUN usermod -aG sudo gituser
     -+RUN echo 'gituser ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/010-gituser
     -+RUN chmod 0440 /etc/sudoers.d/010-gituser
     -+
     -+USER 1001
     -+
     -+#WORKDIR /home/gituser/git-src/
     -+
     -+#RUN  make configure
     -+#RUN ./configure --prefix=${HOME}/.local/
     -+
     -+#RUN make -j$(nproc) gitweb || make gitweb 
     -+#RUN make install-gitweb
     -+
     -+#RUN make -j$(nproc) || make
     -+#RUN make -j$(nproc) gitweb || make gitweb 
     -+#RUN make install-gitweb
     -+#RUN make -j$(nproc) NO_PERL=YesPlease install || make NO_PERL=YesPlease install
     -+#RUN make install
     -+
     -+
     -+RUN mkdir -p  ${HOME}/.local/
     -+#RUN ls -la ${HOME}/.local/bin
     -+#ENV PATH="/home/gituser/.local/bin:${PATH}"
     -+#RUN ls -l $HOME/.local/bin
     -+#RUN echo $PATH $HOME 
     -+
     -+#RUN git --version
     -+#RUN which git 
     -+
     -+RUN git config --global user.email "gituser@example.com"
     -+RUN git config --global user.name "Git User"
     -+
     -+#WORKDIR /home/gituser/git-test/
     -+
     -+#CMD [ "git" ]
     -
     - ## .devcontainer/Dockerfile.standalone (new) ##
     -@@
     -+FROM ubuntu:latest
     -+
     -+ARG USER_ID
     -+ARG GROUP_ID
     -+
     -+ENV DEBIAN_FRONTEND=noninteractive
     -+ENV TZ=Europe/Copenhagen
     -+
     -+RUN apt-get update \
     -+    && \
     -+    apt-get install -y \
     -+        build-essential \
     -+        libcurl4-gnutls-dev \
     -+        libexpat1-dev \
     -+        gettext \
     -+        libz-dev \
     -+        libssl-dev \
     -+        asciidoc \
     -+        xmlto \
     -+        docbook-xsl \
     -+        \
     -+        tzdata \
     -+        \
     -+        nano \
     -+        vim \
     -+    && \
     -+    ln -fs /usr/share/zoneinfo/$TZ /etc/localtime \
     -+    && \
     -+    dpkg-reconfigure --frontend noninteractive tzdata
     -+
     -+RUN  apt-get update && apt-get install -y autoconf
     -+
     -+RUN addgroup -gid ${GROUP_ID} gituser
     -+RUN adduser --disabled-password -u ${USER_ID} -gid ${GROUP_ID} gituser
     -+
     -+
     -+COPY --chown=${USER_ID}:${GROUP_ID} ./git /home/gituser/git-src/
     -+
     -+USER ${USER_ID}
     -+
     -+WORKDIR /home/gituser/git-src/
     -+
     -+RUN  make configure
     -+RUN ./configure --prefix=${HOME}/.local/
     -+
     -+#RUN make -j$(nproc) gitweb || make gitweb 
     -+#RUN make install-gitweb
     -+
     -+#RUN make -j$(nproc) || make
     -+#RUN make -j$(nproc) gitweb || make gitweb 
     -+#RUN make install-gitweb
     -+RUN make -j$(nproc) NO_PERL=YesPlease install || make NO_PERL=YesPlease install
     -+RUN make install
     -+
     -+WORKDIR /home/gituser/git-src/t
     -+RUN ./t2206-add-submodule-ignored.sh -v
     -+
     -+RUN ls -la ${HOME}/.local/
     -+RUN ls -la ${HOME}/.local/bin
     -+ENV PATH="/home/gituser/.local/bin:${PATH}"
     -+RUN ls -l $HOME/.local/bin
     -+RUN echo $PATH $HOME 
     -+
     -+RUN git --version
     -+RUN which git 
     -+
     -+RUN git config --global user.email "gituser@example.com"
     -+RUN git config --global user.name "Git User"
     -+
     -+WORKDIR /home/gituser/git-src/t
     -+RUN pwd && ls -la 
     -+RUN ./t2206-add-submodule-ignored.sh -v
     -+
     -+WORKDIR /home/gituser/git-test/
     -+
     -+CMD [ "git" ]
     -
     - ## .devcontainer/devcontainer.json (new) ##
     -@@
     -+{
     -+  "name": "Git Dev Container",
     -+  "build": {
     -+    "dockerfile": "Dockerfile",
     -+    "context": "",
     -+    "args": {
     -+      "user_id": "1001",
     -+      "group_id": "1001"
     -+    }
     -+  },
     -+  "customizations": {
     -+    "vscode": {
     -+      "settings": {
     -+        "terminal.integrated.shell.linux": "/bin/bash"
     -+      }
     -+    }
     -+  },
     -+  "remoteUser": "gituser",
     -+  "features": {},
     -+  "mounts": [
     -+    "source=${localWorkspaceFolder}/,target=/home/gitusers/git-src,type=bind,consistency=cached",
     -+    "source=${localWorkspaceFolder}/,target=/home/gitusers/git-test,type=bind,consistency=cached"
     -+  ],
     -+  "postCreateCommand": "echo"
     -+}
     -
       ## Documentation/config/submodule.adoc ##
      @@ Documentation/config/submodule.adoc: submodule.<name>.fetchRecurseSubmodules::
       
     @@ Documentation/config/submodule.adoc: submodule.<name>.fetchRecurseSubmodules::
      -	commit when it has been staged), "dirty" will ignore all changes
      -	to the submodule's work tree and
      +	a submodule as modified.
     -+	Set to "all" will never considered the submodule modified. It can
     -+	nevertheless be staged using the option --include_ignored_submodules and
     -+	it will then show up in the output of status.
     ++	Set to "all" will never consider the submodule modified. It can
     ++	nevertheless be staged using the option --force and it will then show up
     ++	in the output of status.
      +	Set to "dirty" will ignore all changes to the submodule's work tree and
       	takes only differences between the HEAD of the submodule and the commit
       	recorded in the superproject into account. "untracked" will additionally
     @@ Documentation/config/submodule.adoc: submodule.<name>.fetchRecurseSubmodules::
      
       ## Documentation/git-add.adoc ##
      @@ Documentation/git-add.adoc: in linkgit:gitglossary[7].
     + 
     + `-f`::
       `--force`::
     - 	Allow adding otherwise ignored files.
     +-	Allow adding otherwise ignored files.
     ++	Allow adding otherwise ignored files. The option is also used when
     ++	`submodule.<name>.ignore=all` is set, but you want to stage an
     ++	update of the submodule. The `path` to the submodule must be explicitly
     ++	specified.
       
     -+`--include_ignored_submodules`::
     -+	The option is also used when `submodule.<name>.ignore=all`
     -+	is set, but you want to stage an update of the submodule. The
     -+	`path` to the submodule must be explicitly specified.
     -+
       `--sparse`::
       	Allow updating index entries outside of the sparse-checkout cone.
     - 	Normally, `git add` refuses to update index entries whose paths do
      
       ## Documentation/gitmodules.adoc ##
      @@ Documentation/gitmodules.adoc: submodule.<name>.ignore::
     @@ Documentation/gitmodules.adoc: submodule.<name>.ignore::
       	    nonetheless show up in the output of status and commit when it has
      -	    been staged).
      +	    been staged). Add `(new commits)` can be overruled using the
     -+	    `git add --include_ignored_submodules <submodule.path>` 
     -+		The setting affects `status`, `update-index`, `diff` and `log`(due 
     ++	    `git add --force <submodule.path>`.
     ++		The setting affects `status`, `update-index`, `diff` and `log`(due
      +		to underlaying `diff`).
       
       	dirty;; All changes to the submodule's work tree will be ignored, only

-- 
gitgitgadget
