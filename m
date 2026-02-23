Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E9D155757
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 14:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771856475; cv=none; b=Lqti8UFTfYbCfAf5QYaD4BkihXTD2H21dWyN7iSLXLuUjJ8nc18K5ym7iQXJjskE9Za9cydKFXMtcgFbbUn28FEXf30VW1aeUvG3l74UnJZeN4ojN9xTb9K+7yF+k/moaP8TUFviriWuoP4nVL5lZI4uVDxaxQ8au+pS+gRnhbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771856475; c=relaxed/simple;
	bh=gaL2/u1bkb2pmTDXJQw5isWk4FxG1jtUKVpFf5tlipI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rRu7bWFlvc4qjMNXoswLyv2gCHh05rCDG1CqTzZ8sQnVJcrbzpG69gb+FpFcFwimfZg4XahvitRmGgNL+KtOe20wJkid92JdrcY2yABs/CMoGMSsb4/YX8MAZrb3RwHxs9diRVQMN1hhbuQOnX3EgO9e+tuxtdqHmalHj7CuJ6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSBFcQ2a; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSBFcQ2a"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5033387c80aso70784711cf.0
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 06:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771856472; x=1772461272; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/3kZnHJ29t2yOLIcTXFVvnrlomL7ijBiM69QCuRpSw=;
        b=ZSBFcQ2avuwxVeT1N9uKeorZG0iVx8cfrvQ69qrD8dXakPKANU5NACgDF5y3yPw9xa
         WDusjQfG/Ostmemrn5FMBb/BJuy90fCLR/7W573fKXyf3e5FveeWPWmnxV2ylPmykB/i
         LTI9ykqxiM7PJRuUVFiXdY+BA97NG7oXoDOGo8tL+9+dJyW4lYJNNk39bSguVd9hPUCA
         uHKTyMMPKLgbibE31ivMzxgPnU9CysGIpsIiN1hcGvaQlV3CHWpMKX4yKF+ik85lpujc
         OAP6osdsu8149iqJNLnDwTwDmMDTIrzfvFCAJeTRFY/FORhtoRIqlIhVDQQ9B85qI7nU
         nzvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771856472; x=1772461272;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4/3kZnHJ29t2yOLIcTXFVvnrlomL7ijBiM69QCuRpSw=;
        b=oqbt72asWYEdzC8EXbe6ebTm0g22DncTyaqNb9Gaz0s4P6BbGn1yNYj+fH0jdCpVL5
         fUC+qD0v2uiPbDlpJFHWenuUthYYTzV2O9hI8gZXUmHiDWFwCrVnQ0lanIcf6t9OuQiF
         DDcLWtQb+cZ7VIz2Wvz9K90gEqLr/NS1MUDQLDISp5c4zwW9uP3INqRpNi4ERnlrtJZG
         37KtQjnnUrk4uvWfgVn7IY3HbTV+aPC6CvMC1Ug4Tdmubc1UEs1k3VsyoDopmyb+Q5db
         GQoNT09gHFOiYbqc06+bjwLE+0u6vaq/q0ddK3RNa0JWKx9iINzjKav33JqfpZZvBcKA
         XlEQ==
X-Gm-Message-State: AOJu0YxAIqTAr3qkPeNfqG/s8MxdyCI5rQDYlGxHmXpz7zoPNtjf+AqZ
	kpIoP/ewnVXKzj5+K2VAcFWprSrLmHVxzQJvtvQBI9+iSPPWJBxkW/ikJopg6Crq
X-Gm-Gg: AZuq6aJ1lR8QdnoUH6SY3eidPWi6xtupbkAm/SCkxEZSseuOrrqmvSNHU2Ghgu0PwkX
	m5bYbF/ZfCQjFqyNxbLct1N46pn5UZaL74j1bJhASn1n7g2hqj+sKYl5oiOSDpV/SEAPA5xYCkZ
	X2HI5JZnXZc7oQUOvZR7gElanrqd84UbaeH0j5eUAVNvCsQD35vchVovgks8JtgQvYNWuw6z5k5
	pEA60kz9EldZxPQf9+SiPtnoma3Mn4XwwHe4ePlF40toRmdMw6mBOITEChgWqTnHSmULiexN40A
	z5YfXIg6Agatda3/Q/S9NX2rUzyfMvplzXCZMLVIh07OMXiHkKQpKKY3gekFLOJb3uQEDcGuTGr
	ti+klkJbX+VwiKLIQhI7cBTwmGW/bvd3pVCKITJ7bNFuMkZ7ufQuqCfckJwpQT4uNNY+wFJWVEp
	A6hRCrE722MaNu0oE76/EX06Q=
X-Received: by 2002:ac8:7fc1:0:b0:4ee:1dd0:5a50 with SMTP id d75a77b69052e-5070c2bd60amr116749881cf.17.1771856470857;
        Mon, 23 Feb 2026 06:21:10 -0800 (PST)
Received: from [127.0.0.1] ([20.55.15.231])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d54000fsm68856671cf.10.2026.02.23.06.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 06:21:10 -0800 (PST)
Message-Id: <pull.2208.v2.git.git.1771856469.gitgitgadget@gmail.com>
In-Reply-To: <pull.2208.git.git.1771784936.gitgitgadget@gmail.com>
References: <pull.2208.git.git.1771784936.gitgitgadget@gmail.com>
From: "eslam reda via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Feb 2026 14:21:00 +0000
Subject: [PATCH v2 0/9] repo: extend info path reporting and structure statistics
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
Cc: Karthik Nayak <karthik.188@gmail.com>,
    Justin Tobler <jltobler@gmail.com>,
    Ayush Chandekar <ayu.chandekar@gmail.com>,
    Siddharth Asthana <siddharthasthana31@gmail.com>,
    Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
    eslam reda <eslam.reda.div@gmail.com>


This series improves git repo info and git repo structure with a
================================================================

cleanly split commit history and explicit documentation/tests.

For git repo info, this series:

 * introduces explicit command context plumbing (instead of ad-hoc global
   reliance in this codepath),
 * adds category-key expansion (for example, requesting layout expands to
   layout.* keys),
 * adds path-oriented keys (path.*) that expose repository locations,
 * adds --path-format=(absolute|relative) to control path rendering.

For git repo structure, this series adds richer metrics:

 * maximum inflated object size (overall + per type),
 * maximum on-disk object size (overall + per type),
 * maximum commit parent count,
 * maximum tree entry count,
 * maximum blob path length and path depth,
 * maximum annotated tag chain depth,
 * aggregate keyvalue/nul totals (references.count, objects.count,
   objects.inflated_size, objects.disk_size).

Tests and documentation are updated accordingly.

----------------------------------------------------------------------------


Why this change
===============

The intent is to make git repo more script-friendly and more useful for
repository diagnostics:

 * repo info becomes easier to query programmatically (category keys,
   explicit path formatting).
 * repo structure becomes more actionable by exposing outlier-focused
   metrics (maxima), not only totals.
 * keyvalue/nul output now includes aggregate totals so scripts do not need
   to recompute them externally.

----------------------------------------------------------------------------


Commit structure (v2 rewrite)
=============================

This iteration rewrites history into smaller logical steps (no
“fix-on-fix”):

 1. repo: teach info context and category keys
 2. repo: add path keys to repo info
 3. repo: add --path-format for info path output
 4. repo: add structure max object size metrics
 5. repo: add structure topology and path-depth metrics
 6. repo: add aggregate structure totals to keyvalue output
 7. t1900: cover repo info path keys and path-format
 8. t1901: extend structure metric coverage and portability
 9. docs: describe repo info path keys and structure metrics

All commits are signed off using real-name identity.

----------------------------------------------------------------------------


Changes since v1
================

 * Rewrote series into smaller logical commits.
 * Folded fixes into proper history (no trailing fix-up patches).
 * Unified author/sign-off identity to real name.
 * Addressed portability concerns raised in review:
   * hash-algorithm-sensitive expectations are handled robustly,
   * BSD/macOS wc whitespace behavior is handled in tests.
 * Improved test robustness around keyvalue/nul expectations.
 * Expanded docs to explicitly describe new keys/metrics and behavior.
 * Revalidated in Docker with focused and full test runs.

----------------------------------------------------------------------------


Validation
==========

Focused:

 * t1900-repo.sh
 * GIT_TEST_DEFAULT_REF_FORMAT=reftable t/t1901-repo-structure.sh

Full:

 * make -C t -j4 test in clean Docker environment
 * Result: failed 0

----------------------------------------------------------------------------

Eslam reda ragheb (9):
  repo: teach info context and category keys
  repo: add path keys to repo info
  repo: add --path-format for info path output
  repo: add structure max object size metrics
  repo: add structure topology and path-depth metrics
  repo: add aggregate structure totals to keyvalue output
  t1900: cover repo info path keys and path-format
  t1901: extend structure metric coverage and portability
  docs: describe repo info path keys and structure metrics

 Documentation/git-repo.adoc |  67 ++++-
 builtin/repo.c              | 518 ++++++++++++++++++++++++++++++++++--
 t/t1900-repo.sh             | 196 ++++++++++++++
 t/t1901-repo-structure.sh   | 250 ++++++++++++-----
 4 files changed, 946 insertions(+), 85 deletions(-)


base-commit: 7c02d39fc2ed2702223c7674f73150d9a7e61ba4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2208%2Feslam-reda-div%2Fgsoc-contribute-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2208/eslam-reda-div/gsoc-contribute-v2
Pull-Request: https://github.com/git/git/pull/2208

Range-diff vs v1:

  -:  ---------- >  1:  99c8058298 repo: teach info context and category keys
  -:  ---------- >  2:  6d5b9ff075 repo: add path keys to repo info
  -:  ---------- >  3:  5c438d045b repo: add --path-format for info path output
  -:  ---------- >  4:  504d9cf7a0 repo: add structure max object size metrics
  -:  ---------- >  5:  4b502925c9 repo: add structure topology and path-depth metrics
  -:  ---------- >  6:  1751181950 repo: add aggregate structure totals to keyvalue output
  -:  ---------- >  7:  fd18f28db0 t1900: cover repo info path keys and path-format
  1:  9f2b3a46a4 !  8:  0525ed4cd9 repo: extend info paths and structure statistics
     @@
       ## Metadata ##
     -Author: eslam-reda-div <eslam.reda.div@gmail.com>
     +Author: Eslam reda ragheb <eslam.reda.div@gmail.com>
      
       ## Commit message ##
     -    repo: extend info paths and structure statistics
     +    t1901: extend structure metric coverage and portability
      
     -    Improve git repo info by adding path-oriented keys that match values
     -    users currently obtain from git rev-parse, including common directory,
     -    git directory, top-level, superproject working tree, and additional
     -    git-path based locations.
     +    Expand t1901 to cover additional structure metrics emitted by git
     +    repo structure, including maxima and aggregate keyvalue/nul
     +    checks.
      
     -    Teach git repo info to accept category keys like layout and path,
     -    and add --path-format=(absolute|relative) so scripts can request the
     -    desired path style explicitly. The command now uses repository context
     -    passed to the command path instead of relying on global state.
     +    The test now validates both human-oriented table content and
     +    machine-readable fields for the extended metric set.
      
     -    Extend git repo structure with deeper repository metrics inspired by
     -    git-sizer, including per-type maximum inflated and on-disk object sizes,
     -    maximum commit parent count, maximum tree entry count, longest/deepest
     -    blob path, and deepest annotated tag chain.
     +    Also make expectations more portable across hash algorithms and
     +    platforms by avoiding brittle assumptions.
      
     -    Update documentation and tests to cover new keys, formats, and metrics.
     +    This includes wc output quirks on BSD/macOS and hash-format-
     +    sensitive expectations.
      
     -    Signed-off-by: eslam-reda-div <eslam.reda.div@gmail.com>
     -
     - ## Documentation/git-repo.adoc ##
     -@@ Documentation/git-repo.adoc: git-repo - Retrieve information about the repository
     - SYNOPSIS
     - --------
     - [synopsis]
     --git repo info [--format=(keyvalue|nul) | -z] [--all | <key>...]
     -+git repo info [--format=(keyvalue|nul) | -z] [--path-format=(absolute|relative)] [--all | <key>...]
     - git repo structure [--format=(table|keyvalue|nul) | -z]
     - 
     - DESCRIPTION
     -@@ Documentation/git-repo.adoc: supported:
     - +
     - `-z` is an alias for `--format=nul`.
     - 
     -+`--path-format=(absolute|relative)`:::
     -+	Controls formatting for keys in the `path` category. The default is
     -+	`absolute`. This option may be specified multiple times; the last one
     -+	specified takes effect.
     -+
     - `structure [--format=(table|keyvalue|nul) | -z]`::
     - 	Retrieve statistics about the current repository structure. The
     - 	following kinds of information are reported:
     -@@ Documentation/git-repo.adoc: supported:
     - * Reachable object counts categorized by type
     - * Total inflated size of reachable objects by type
     - * Total disk size of reachable objects by type
     -+* Largest inflated reachable object size by type
     -+* Largest disk size of a reachable object by type
     -+* Largest parent count among reachable commits
     -+* Largest entry count among reachable trees
     -+* Longest and deepest path among reachable blobs
     -+* Deepest annotated tag chain
     - +
     - The output format can be chosen through the flag `--format`. Three formats are
     - supported:
     -@@ Documentation/git-repo.adoc: supported:
     - `keyvalue`:::
     - 	Each line of output contains a key-value pair for a repository stat.
     - 	The '=' character is used to delimit between the key and the value.
     -+	Both aggregate metrics and per-type metrics are included.
     - 	Values containing "unusual" characters are quoted as explained for the
     - 	configuration variable `core.quotePath` (see linkgit:git-config[1]).
     - 
     -@@ Documentation/git-repo.adoc: supported:
     - 
     - INFO KEYS
     - ---------
     --In order to obtain a set of values from `git repo info`, you should provide
     --the keys that identify them. Here's a list of the available keys and the
     --values that they return:
     -+In order to obtain values from `git repo info`, provide either individual keys
     -+or category names. A category returns all keys within that category. For
     -+example, `layout` returns both `layout.bare` and `layout.shallow`.
     -+
     -+Here's a list of the available keys and the values that they return:
     - 
     - `layout.bare`::
     - 	`true` if this is a bare repository, otherwise `false`.
     -@@ Documentation/git-repo.adoc: values that they return:
     - `object.format`::
     - 	The object format (hash algorithm) used in the repository.
     - 
     -+`path.common-dir`::
     -+	The path to the common git directory.
     -+
     -+`path.config-file`::
     -+	The path to the `config` file in the git directory.
     -+
     -+`path.git-dir`::
     -+	The path to the git directory.
     -+
     -+`path.git-prefix`::
     -+	The path of the current working directory relative to the top-level
     -+	directory.
     -+
     -+`path.grafts-file`::
     -+	The path to the `info/grafts` file.
     -+
     -+`path.hooks-directory`::
     -+	The path to the `hooks` directory.
     -+
     -+`path.index-file`::
     -+	The path to the index file.
     -+
     -+`path.logs-directory`::
     -+	The path to the `logs` directory.
     -+
     -+`path.objects-directory`::
     -+	The path to the objects directory.
     -+
     -+`path.packed-refs-file`::
     -+	The path to the `packed-refs` file.
     -+
     -+`path.refs-directory`::
     -+	The path to the `refs` directory.
     -+
     -+`path.shallow-file`::
     -+	The path to the `shallow` file.
     -+
     -+`path.superproject-working-tree`::
     -+	The path to the superproject's working tree root, or an empty string
     -+	when the repository is not used as a submodule.
     -+
     -+`path.toplevel`::
     -+	The path to the top-level working tree directory, or an empty string
     -+	for bare repositories.
     -+
     - `references.format`::
     - 	The reference storage format. The valid values are:
     - +
     -
     - ## builtin/repo.c ##
     -@@
     --#define USE_THE_REPOSITORY_VARIABLE
     --
     - #include "builtin.h"
     --#include "environment.h"
     -+#include "abspath.h"
     - #include "hex.h"
     - #include "odb.h"
     - #include "parse-options.h"
     -+#include "path.h"
     - #include "path-walk.h"
     - #include "progress.h"
     - #include "quote.h"
     -@@
     - #include "revision.h"
     - #include "strbuf.h"
     - #include "string-list.h"
     -+#include "submodule.h"
     - #include "shallow.h"
     -+#include "tree-walk.h"
     - #include "utf8.h"
     - 
     - static const char *const repo_usage[] = {
     --	"git repo info [--format=(keyvalue|nul) | -z] [--all | <key>...]",
     -+	"git repo info [--format=(keyvalue|nul) | -z] [--path-format=(absolute|relative)] [--all | <key>...]",
     - 	"git repo structure [--format=(table|keyvalue|nul) | -z]",
     - 	NULL
     - };
     - 
     --typedef int get_value_fn(struct repository *repo, struct strbuf *buf);
     -+enum path_format {
     -+	PATH_FORMAT_ABSOLUTE,
     -+	PATH_FORMAT_RELATIVE,
     -+};
     -+
     -+struct repo_info {
     -+	struct repository *repo;
     -+	const char *prefix;
     -+	enum path_format path_format;
     -+};
     -+
     -+typedef int get_value_fn(struct repo_info *info, struct strbuf *buf);
     - 
     - enum output_format {
     - 	FORMAT_TABLE,
     -@@ builtin/repo.c: struct field {
     - 	get_value_fn *get_value;
     - };
     - 
     --static int get_layout_bare(struct repository *repo UNUSED, struct strbuf *buf)
     -+static void repo_info_add_path(struct repo_info *info,
     -+			       struct strbuf *buf,
     -+			       const char *path)
     - {
     --	strbuf_addstr(buf, is_bare_repository() ? "true" : "false");
     -+	if (info->path_format == PATH_FORMAT_RELATIVE) {
     -+		char *cwd = xgetcwd();
     -+		struct strbuf rel_path = STRBUF_INIT;
     -+
     -+		strbuf_addstr(buf, relative_path(path, cwd, &rel_path));
     -+		strbuf_release(&rel_path);
     -+		free(cwd);
     -+		return;
     -+	}
     -+
     -+	strbuf_add_absolute_path(buf, path);
     -+}
     -+
     -+static int get_layout_bare(struct repo_info *info, struct strbuf *buf)
     -+{
     -+	struct repository *repo = info->repo;
     -+	strbuf_addstr(buf, repo_get_work_tree(repo) ? "false" : "true");
     - 	return 0;
     - }
     - 
     --static int get_layout_shallow(struct repository *repo, struct strbuf *buf)
     -+static int get_layout_shallow(struct repo_info *info, struct strbuf *buf)
     - {
     -+	struct repository *repo = info->repo;
     - 	strbuf_addstr(buf,
     - 		      is_repository_shallow(repo) ? "true" : "false");
     - 	return 0;
     - }
     - 
     --static int get_object_format(struct repository *repo, struct strbuf *buf)
     -+static int get_object_format(struct repo_info *info, struct strbuf *buf)
     - {
     -+	struct repository *repo = info->repo;
     - 	strbuf_addstr(buf, repo->hash_algo->name);
     - 	return 0;
     - }
     - 
     --static int get_references_format(struct repository *repo, struct strbuf *buf)
     -+static int get_path_common_dir(struct repo_info *info, struct strbuf *buf)
     -+{
     -+	repo_info_add_path(info, buf, repo_get_common_dir(info->repo));
     -+	return 0;
     -+}
     -+
     -+static int get_path_config_file(struct repo_info *info, struct strbuf *buf)
     -+{
     -+	struct strbuf path = STRBUF_INIT;
     -+
     -+	repo_info_add_path(info, buf, repo_git_path_replace(info->repo, &path, "config"));
     -+	strbuf_release(&path);
     -+	return 0;
     -+}
     -+
     -+static int get_path_git_dir(struct repo_info *info, struct strbuf *buf)
     -+{
     -+	repo_info_add_path(info, buf, repo_get_git_dir(info->repo));
     -+	return 0;
     -+}
     -+
     -+static int get_path_git_prefix(struct repo_info *info, struct strbuf *buf)
     -+{
     -+	if (info->prefix)
     -+		strbuf_addstr(buf, info->prefix);
     -+	return 0;
     -+}
     -+
     -+static int get_path_grafts_file(struct repo_info *info, struct strbuf *buf)
     -+{
     -+	repo_info_add_path(info, buf, repo_get_graft_file(info->repo));
     -+	return 0;
     -+}
     -+
     -+static int get_path_hooks_directory(struct repo_info *info, struct strbuf *buf)
     -+{
     -+	struct strbuf path = STRBUF_INIT;
     -+
     -+	repo_info_add_path(info, buf, repo_git_path_replace(info->repo, &path, "hooks"));
     -+	strbuf_release(&path);
     -+	return 0;
     -+}
     -+
     -+static int get_path_index_file(struct repo_info *info, struct strbuf *buf)
     -+{
     -+	repo_info_add_path(info, buf, repo_get_index_file(info->repo));
     -+	return 0;
     -+}
     -+
     -+static int get_path_logs_directory(struct repo_info *info, struct strbuf *buf)
     -+{
     -+	struct strbuf path = STRBUF_INIT;
     -+
     -+	repo_info_add_path(info, buf, repo_git_path_replace(info->repo, &path, "logs"));
     -+	strbuf_release(&path);
     -+	return 0;
     -+}
     -+
     -+static int get_path_objects_directory(struct repo_info *info, struct strbuf *buf)
     -+{
     -+	repo_info_add_path(info, buf, repo_get_object_directory(info->repo));
     -+	return 0;
     -+}
     -+
     -+static int get_path_packed_refs_file(struct repo_info *info, struct strbuf *buf)
     -+{
     -+	struct strbuf path = STRBUF_INIT;
     -+
     -+	repo_info_add_path(info, buf, repo_git_path_replace(info->repo, &path, "packed-refs"));
     -+	strbuf_release(&path);
     -+	return 0;
     -+}
     -+
     -+static int get_path_refs_directory(struct repo_info *info, struct strbuf *buf)
     -+{
     -+	struct strbuf path = STRBUF_INIT;
     -+
     -+	repo_info_add_path(info, buf, repo_git_path_replace(info->repo, &path, "refs"));
     -+	strbuf_release(&path);
     -+	return 0;
     -+}
     -+
     -+static int get_path_shallow_file(struct repo_info *info, struct strbuf *buf)
     -+{
     -+	struct strbuf path = STRBUF_INIT;
     -+
     -+	repo_info_add_path(info, buf, repo_git_path_replace(info->repo, &path, "shallow"));
     -+	strbuf_release(&path);
     -+	return 0;
     -+}
     -+
     -+static int get_path_superproject_working_tree(struct repo_info *info,
     -+					      struct strbuf *buf)
     -+{
     -+	struct strbuf superproject = STRBUF_INIT;
     -+
     -+	if (get_superproject_working_tree(&superproject))
     -+		repo_info_add_path(info, buf, superproject.buf);
     -+
     -+	strbuf_release(&superproject);
     -+	return 0;
     -+}
     -+
     -+static int get_path_toplevel(struct repo_info *info, struct strbuf *buf)
     -+{
     -+	const char *work_tree = repo_get_work_tree(info->repo);
     -+
     -+	if (work_tree)
     -+		repo_info_add_path(info, buf, work_tree);
     -+
     -+	return 0;
     -+}
     -+
     -+static int get_references_format(struct repo_info *info, struct strbuf *buf)
     - {
     -+	struct repository *repo = info->repo;
     - 	strbuf_addstr(buf,
     - 		      ref_storage_format_to_name(repo->ref_storage_format));
     - 	return 0;
     -@@ builtin/repo.c: static const struct field repo_info_fields[] = {
     - 	{ "layout.bare", get_layout_bare },
     - 	{ "layout.shallow", get_layout_shallow },
     - 	{ "object.format", get_object_format },
     -+	{ "path.common-dir", get_path_common_dir },
     -+	{ "path.config-file", get_path_config_file },
     -+	{ "path.git-dir", get_path_git_dir },
     -+	{ "path.git-prefix", get_path_git_prefix },
     -+	{ "path.grafts-file", get_path_grafts_file },
     -+	{ "path.hooks-directory", get_path_hooks_directory },
     -+	{ "path.index-file", get_path_index_file },
     -+	{ "path.logs-directory", get_path_logs_directory },
     -+	{ "path.objects-directory", get_path_objects_directory },
     -+	{ "path.packed-refs-file", get_path_packed_refs_file },
     -+	{ "path.refs-directory", get_path_refs_directory },
     -+	{ "path.shallow-file", get_path_shallow_file },
     -+	{ "path.superproject-working-tree", get_path_superproject_working_tree },
     -+	{ "path.toplevel", get_path_toplevel },
     - 	{ "references.format", get_references_format },
     - };
     - 
     -@@ builtin/repo.c: static get_value_fn *get_value_fn_for_key(const char *key)
     - 	return found ? found->get_value : NULL;
     - }
     - 
     -+static void print_field(enum output_format format, const char *key,
     -+			const char *value);
     -+
     -+static int print_category_fields(const char *category,
     -+				 struct repo_info *info,
     -+				 enum output_format format,
     -+				 struct strbuf *valbuf)
     -+{
     -+	int found = 0;
     -+	size_t category_len = strlen(category);
     -+
     -+	for (size_t i = 0; i < ARRAY_SIZE(repo_info_fields); i++) {
     -+		const struct field *field = &repo_info_fields[i];
     -+
     -+		if (!starts_with(field->key, category) ||
     -+		    field->key[category_len] != '.')
     -+			continue;
     -+
     -+		strbuf_reset(valbuf);
     -+		field->get_value(info, valbuf);
     -+		print_field(format, field->key, valbuf->buf);
     -+		found = 1;
     -+	}
     -+
     -+	return found;
     -+}
     -+
     - static void print_field(enum output_format format, const char *key,
     - 			const char *value)
     - {
     -@@ builtin/repo.c: static void print_field(enum output_format format, const char *key,
     - }
     - 
     - static int print_fields(int argc, const char **argv,
     --			struct repository *repo,
     -+			struct repo_info *info,
     - 			enum output_format format)
     - {
     - 	int ret = 0;
     -@@ builtin/repo.c: static int print_fields(int argc, const char **argv,
     - 
     - 		get_value = get_value_fn_for_key(key);
     - 
     --		if (!get_value) {
     --			ret = error(_("key '%s' not found"), key);
     -+		if (get_value) {
     -+			strbuf_reset(&valbuf);
     -+			get_value(info, &valbuf);
     -+			print_field(format, key, valbuf.buf);
     - 			continue;
     - 		}
     - 
     --		strbuf_reset(&valbuf);
     --		get_value(repo, &valbuf);
     --		print_field(format, key, valbuf.buf);
     -+		if (!print_category_fields(key, info, format, &valbuf))
     -+			ret = error(_("key '%s' not found"), key);
     - 	}
     - 
     - 	strbuf_release(&valbuf);
     - 	return ret;
     - }
     - 
     --static int print_all_fields(struct repository *repo,
     -+static int print_all_fields(struct repo_info *info,
     - 			    enum output_format format)
     - {
     - 	struct strbuf valbuf = STRBUF_INIT;
     -@@ builtin/repo.c: static int print_all_fields(struct repository *repo,
     - 		const struct field *field = &repo_info_fields[i];
     - 
     - 		strbuf_reset(&valbuf);
     --		field->get_value(repo, &valbuf);
     -+		field->get_value(info, &valbuf);
     - 		print_field(format, field->key, valbuf.buf);
     - 	}
     - 
     -@@ builtin/repo.c: static int parse_format_cb(const struct option *opt,
     - 	return 0;
     - }
     - 
     -+static int parse_path_format_cb(const struct option *opt,
     -+				const char *arg, int unset UNUSED)
     -+{
     -+	enum path_format *path_format = opt->value;
     -+
     -+	if (!strcmp(arg, "absolute"))
     -+		*path_format = PATH_FORMAT_ABSOLUTE;
     -+	else if (!strcmp(arg, "relative"))
     -+		*path_format = PATH_FORMAT_RELATIVE;
     -+	else
     -+		die(_("invalid path format '%s'"), arg);
     -+
     -+	return 0;
     -+}
     -+
     - static int cmd_repo_info(int argc, const char **argv, const char *prefix,
     - 			 struct repository *repo)
     - {
     - 	enum output_format format = FORMAT_KEYVALUE;
     -+	struct repo_info info = {
     -+		.repo = repo,
     -+		.prefix = prefix,
     -+		.path_format = PATH_FORMAT_ABSOLUTE,
     -+	};
     - 	int all_keys = 0;
     - 	struct option options[] = {
     - 		OPT_CALLBACK_F(0, "format", &format, N_("format"),
     -@@ builtin/repo.c: static int cmd_repo_info(int argc, const char **argv, const char *prefix,
     - 			       N_("synonym for --format=nul"),
     - 			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
     - 			       parse_format_cb),
     -+		OPT_CALLBACK_F(0, "path-format", &info.path_format,
     -+			       N_("format"), N_("path output format"),
     -+			       PARSE_OPT_NONEG, parse_path_format_cb),
     - 		OPT_BOOL(0, "all", &all_keys, N_("print all keys/values")),
     - 		OPT_END()
     - 	};
     -@@ builtin/repo.c: static int cmd_repo_info(int argc, const char **argv, const char *prefix,
     - 		die(_("--all and <key> cannot be used together"));
     - 
     - 	if (all_keys)
     --		return print_all_fields(repo, format);
     -+		return print_all_fields(&info, format);
     - 	else
     --		return print_fields(argc, argv, repo, format);
     -+		return print_fields(argc, argv, &info, format);
     - }
     - 
     - struct ref_stats {
     -@@ builtin/repo.c: struct object_values {
     - struct object_stats {
     - 	struct object_values type_counts;
     - 	struct object_values inflated_sizes;
     -+	struct object_values max_inflated_sizes;
     - 	struct object_values disk_sizes;
     -+	struct object_values max_disk_sizes;
     -+	size_t max_commit_parent_count;
     -+	size_t max_tree_entry_count;
     -+	size_t max_blob_path_length;
     -+	size_t max_blob_path_depth;
     -+	size_t max_tag_chain_depth;
     - };
     - 
     - struct repo_structure {
     -@@ builtin/repo.c: static inline size_t get_total_object_values(struct object_values *values)
     - 	return values->tags + values->commits + values->trees + values->blobs;
     - }
     - 
     -+static inline size_t get_max_object_value(struct object_values *values)
     -+{
     -+	size_t max = values->commits;
     -+
     -+	if (values->trees > max)
     -+		max = values->trees;
     -+	if (values->blobs > max)
     -+		max = values->blobs;
     -+	if (values->tags > max)
     -+		max = values->tags;
     -+
     -+	return max;
     -+}
     -+
     -+static size_t get_commit_parent_count(struct repository *repo,
     -+				      const struct object_id *oid)
     -+{
     -+	unsigned long size = 0;
     -+	const char *cur;
     -+	const char *end;
     -+	void *buf;
     -+	size_t count = 0;
     -+
     -+	buf = odb_read_object_peeled(repo->objects, oid, OBJ_COMMIT, &size, NULL);
     -+	if (!buf)
     -+		return 0;
     -+
     -+	cur = buf;
     -+	end = cur + size;
     -+	while (cur < end) {
     -+		const char *newline = memchr(cur, '\n', end - cur);
     -+		size_t line_len;
     -+
     -+		if (!newline)
     -+			break;
     -+		line_len = newline - cur;
     -+		if (!line_len)
     -+			break;
     -+
     -+		if (line_len > 7 && !memcmp(cur, "parent ", 7))
     -+			count++;
     -+
     -+		cur = newline + 1;
     -+	}
     -+
     -+	free(buf);
     -+	return count;
     -+}
     -+
     -+static size_t get_tree_entry_count(struct repository *repo,
     -+				   const struct object_id *oid)
     -+{
     -+	struct tree_desc desc;
     -+	struct name_entry entry;
     -+	unsigned long size = 0;
     -+	void *buf;
     -+	size_t count = 0;
     -+
     -+	buf = odb_read_object_peeled(repo->objects, oid, OBJ_TREE, &size, NULL);
     -+	if (!buf)
     -+		return 0;
     -+
     -+	init_tree_desc(&desc, oid, buf, size);
     -+	while (tree_entry(&desc, &entry))
     -+		count++;
     -+
     -+	free(buf);
     -+	return count;
     -+}
     -+
     -+static size_t get_path_depth(const char *path)
     -+{
     -+	size_t depth = 0;
     -+
     -+	if (!path || !*path)
     -+		return 0;
     -+
     -+	depth = 1;
     -+	for (const char *cur = path; *cur; cur++)
     -+		if (*cur == '/')
     -+			depth++;
     -+
     -+	return depth;
     -+}
     -+
     -+static size_t get_tag_chain_depth(struct repository *repo,
     -+				  const struct object_id *oid)
     -+{
     -+	struct object_id current = *oid;
     -+	size_t depth = 0;
     -+
     -+	while (1) {
     -+		enum object_type type;
     -+		unsigned long size = 0;
     -+		struct object_id next;
     -+		const char *p, *end;
     -+		void *buf = odb_read_object(repo->objects, &current, &type, &size);
     -+
     -+		if (!buf)
     -+			break;
     -+		if (type != OBJ_TAG) {
     -+			free(buf);
     -+			break;
     -+		}
     -+
     -+		p = buf;
     -+		if (!skip_prefix(p, "object ", &p) ||
     -+		    parse_oid_hex_algop(p, &next, &end, repo->hash_algo) ||
     -+		    *end != '\n') {
     -+			free(buf);
     -+			break;
     -+		}
     -+
     -+		depth++;
     -+		free(buf);
     -+
     -+		if (oideq(&next, &current))
     -+			break;
     -+		oidcpy(&current, &next);
     -+	}
     -+
     -+	return depth;
     -+}
     -+
     - static void stats_table_setup_structure(struct stats_table *table,
     - 					struct repo_structure *stats)
     - {
     -@@ builtin/repo.c: static void stats_table_setup_structure(struct stats_table *table,
     - 			      "    * %s", _("Blobs"));
     - 	stats_table_size_addf(table, objects->disk_sizes.tags,
     - 			      "    * %s", _("Tags"));
     -+
     -+	stats_table_size_addf(table, objects->max_inflated_sizes.commits,
     -+			      "  * %s", _("Largest commit"));
     -+	stats_table_size_addf(table, objects->max_inflated_sizes.trees,
     -+			      "  * %s", _("Largest tree"));
     -+	stats_table_size_addf(table, objects->max_inflated_sizes.blobs,
     -+			      "  * %s", _("Largest blob"));
     -+	stats_table_size_addf(table, objects->max_inflated_sizes.tags,
     -+			      "  * %s", _("Largest tag"));
     -+
     -+	stats_table_size_addf(table, get_max_object_value(&objects->max_disk_sizes),
     -+			      "  * %s", _("Largest disk size"));
     -+	stats_table_size_addf(table, objects->max_disk_sizes.commits,
     -+			      "    * %s", _("Commits"));
     -+	stats_table_size_addf(table, objects->max_disk_sizes.trees,
     -+			      "    * %s", _("Trees"));
     -+	stats_table_size_addf(table, objects->max_disk_sizes.blobs,
     -+			      "    * %s", _("Blobs"));
     -+	stats_table_size_addf(table, objects->max_disk_sizes.tags,
     -+			      "    * %s", _("Tags"));
     -+
     -+	stats_table_count_addf(table, objects->max_commit_parent_count,
     -+			       "  * %s", _("Largest parent count"));
     -+	stats_table_count_addf(table, objects->max_tree_entry_count,
     -+			       "  * %s", _("Largest tree entries"));
     -+	stats_table_count_addf(table, objects->max_blob_path_length,
     -+			       "  * %s", _("Longest blob path"));
     -+	stats_table_count_addf(table, objects->max_blob_path_depth,
     -+			       "  * %s", _("Deepest blob path"));
     -+	stats_table_count_addf(table, objects->max_tag_chain_depth,
     -+			       "  * %s", _("Deepest tag chain"));
     - }
     - 
     - static void stats_table_print_structure(const struct stats_table *table)
     -@@ builtin/repo.c: static void stats_table_clear(struct stats_table *table)
     - static void structure_keyvalue_print(struct repo_structure *stats,
     - 				     char key_delim, char value_delim)
     - {
     -+	size_t references_count_total = get_total_reference_count(&stats->refs);
     -+	size_t object_count_total = get_total_object_values(&stats->objects.type_counts);
     -+	size_t inflated_size_total = get_total_object_values(&stats->objects.inflated_sizes);
     -+	size_t disk_size_total = get_total_object_values(&stats->objects.disk_sizes);
     -+	size_t max_inflated_size = get_max_object_value(&stats->objects.max_inflated_sizes);
     -+	size_t max_disk_size = get_max_object_value(&stats->objects.max_disk_sizes);
     -+
     -+	printf("references.count%c%" PRIuMAX "%c", key_delim,
     -+	       (uintmax_t)references_count_total, value_delim);
     - 	printf("references.branches.count%c%" PRIuMAX "%c", key_delim,
     - 	       (uintmax_t)stats->refs.branches, value_delim);
     - 	printf("references.tags.count%c%" PRIuMAX "%c", key_delim,
     -@@ builtin/repo.c: static void structure_keyvalue_print(struct repo_structure *stats,
     - 	printf("references.others.count%c%" PRIuMAX "%c", key_delim,
     - 	       (uintmax_t)stats->refs.others, value_delim);
     - 
     -+	printf("objects.count%c%" PRIuMAX "%c", key_delim,
     -+	       (uintmax_t)object_count_total, value_delim);
     - 	printf("objects.commits.count%c%" PRIuMAX "%c", key_delim,
     - 	       (uintmax_t)stats->objects.type_counts.commits, value_delim);
     - 	printf("objects.trees.count%c%" PRIuMAX "%c", key_delim,
     -@@ builtin/repo.c: static void structure_keyvalue_print(struct repo_structure *stats,
     - 	printf("objects.tags.count%c%" PRIuMAX "%c", key_delim,
     - 	       (uintmax_t)stats->objects.type_counts.tags, value_delim);
     - 
     -+	printf("objects.inflated_size%c%" PRIuMAX "%c", key_delim,
     -+	       (uintmax_t)inflated_size_total, value_delim);
     - 	printf("objects.commits.inflated_size%c%" PRIuMAX "%c", key_delim,
     - 	       (uintmax_t)stats->objects.inflated_sizes.commits, value_delim);
     - 	printf("objects.trees.inflated_size%c%" PRIuMAX "%c", key_delim,
     -@@ builtin/repo.c: static void structure_keyvalue_print(struct repo_structure *stats,
     - 	printf("objects.tags.inflated_size%c%" PRIuMAX "%c", key_delim,
     - 	       (uintmax_t)stats->objects.inflated_sizes.tags, value_delim);
     - 
     -+	printf("objects.max_inflated_size%c%" PRIuMAX "%c", key_delim,
     -+	       (uintmax_t)max_inflated_size, value_delim);
     -+	printf("objects.commits.max_inflated_size%c%" PRIuMAX "%c", key_delim,
     -+	       (uintmax_t)stats->objects.max_inflated_sizes.commits, value_delim);
     -+	printf("objects.trees.max_inflated_size%c%" PRIuMAX "%c", key_delim,
     -+	       (uintmax_t)stats->objects.max_inflated_sizes.trees, value_delim);
     -+	printf("objects.blobs.max_inflated_size%c%" PRIuMAX "%c", key_delim,
     -+	       (uintmax_t)stats->objects.max_inflated_sizes.blobs, value_delim);
     -+	printf("objects.tags.max_inflated_size%c%" PRIuMAX "%c", key_delim,
     -+	       (uintmax_t)stats->objects.max_inflated_sizes.tags, value_delim);
     -+
     -+	printf("objects.disk_size%c%" PRIuMAX "%c", key_delim,
     -+	       (uintmax_t)disk_size_total, value_delim);
     -+	printf("objects.max_disk_size%c%" PRIuMAX "%c", key_delim,
     -+	       (uintmax_t)max_disk_size, value_delim);
     -+	printf("objects.commits.max_disk_size%c%" PRIuMAX "%c", key_delim,
     -+	       (uintmax_t)stats->objects.max_disk_sizes.commits, value_delim);
     -+	printf("objects.trees.max_disk_size%c%" PRIuMAX "%c", key_delim,
     -+	       (uintmax_t)stats->objects.max_disk_sizes.trees, value_delim);
     -+	printf("objects.blobs.max_disk_size%c%" PRIuMAX "%c", key_delim,
     -+	       (uintmax_t)stats->objects.max_disk_sizes.blobs, value_delim);
     -+	printf("objects.tags.max_disk_size%c%" PRIuMAX "%c", key_delim,
     -+	       (uintmax_t)stats->objects.max_disk_sizes.tags, value_delim);
     -+
     -+	printf("objects.commits.max_parent_count%c%" PRIuMAX "%c", key_delim,
     -+	       (uintmax_t)stats->objects.max_commit_parent_count, value_delim);
     -+	printf("objects.trees.max_entry_count%c%" PRIuMAX "%c", key_delim,
     -+	       (uintmax_t)stats->objects.max_tree_entry_count, value_delim);
     -+	printf("objects.blobs.max_path_length%c%" PRIuMAX "%c", key_delim,
     -+	       (uintmax_t)stats->objects.max_blob_path_length, value_delim);
     -+	printf("objects.blobs.max_path_depth%c%" PRIuMAX "%c", key_delim,
     -+	       (uintmax_t)stats->objects.max_blob_path_depth, value_delim);
     -+	printf("objects.tags.max_chain_depth%c%" PRIuMAX "%c", key_delim,
     -+	       (uintmax_t)stats->objects.max_tag_chain_depth, value_delim);
     -+
     - 	printf("objects.commits.disk_size%c%" PRIuMAX "%c", key_delim,
     - 	       (uintmax_t)stats->objects.disk_sizes.commits, value_delim);
     - 	printf("objects.trees.disk_size%c%" PRIuMAX "%c", key_delim,
     -@@ builtin/repo.c: struct count_objects_data {
     - 	struct progress *progress;
     - };
     - 
     --static int count_objects(const char *path UNUSED, struct oid_array *oids,
     -+static int count_objects(const char *path, struct oid_array *oids,
     - 			 enum object_type type, void *cb_data)
     - {
     - 	struct count_objects_data *data = cb_data;
     - 	struct object_stats *stats = data->stats;
     - 	size_t inflated_total = 0;
     - 	size_t disk_total = 0;
     -+	size_t max_inflated = 0;
     -+	size_t max_disk = 0;
     - 	size_t object_count;
     - 
     - 	for (size_t i = 0; i < oids->nr; i++) {
     -@@ builtin/repo.c: static int count_objects(const char *path UNUSED, struct oid_array *oids,
     - 
     - 		if (odb_read_object_info_extended(data->odb, &oids->oid[i], &oi,
     - 						  OBJECT_INFO_SKIP_FETCH_OBJECT |
     --						  OBJECT_INFO_QUICK) < 0)
     -+							  OBJECT_INFO_QUICK) < 0)
     -+			continue;
     -+		if (disk < 0)
     - 			continue;
     - 
     - 		inflated_total += inflated;
     --		disk_total += disk;
     -+		disk_total += (size_t)disk;
     -+		if (inflated > max_inflated)
     -+			max_inflated = inflated;
     -+		if ((size_t)disk > max_disk)
     -+			max_disk = (size_t)disk;
     - 	}
     - 
     - 	switch (type) {
     - 	case OBJ_TAG:
     -+		for (size_t i = 0; i < oids->nr; i++) {
     -+			size_t tag_chain_depth = get_tag_chain_depth(data->odb->repo,
     -+								     &oids->oid[i]);
     -+
     -+			if (tag_chain_depth > stats->max_tag_chain_depth)
     -+				stats->max_tag_chain_depth = tag_chain_depth;
     -+		}
     -+
     - 		stats->type_counts.tags += oids->nr;
     - 		stats->inflated_sizes.tags += inflated_total;
     -+		if (max_inflated > stats->max_inflated_sizes.tags)
     -+			stats->max_inflated_sizes.tags = max_inflated;
     - 		stats->disk_sizes.tags += disk_total;
     -+		if (max_disk > stats->max_disk_sizes.tags)
     -+			stats->max_disk_sizes.tags = max_disk;
     - 		break;
     - 	case OBJ_COMMIT:
     -+		for (size_t i = 0; i < oids->nr; i++) {
     -+			size_t parent_count = get_commit_parent_count(data->odb->repo,
     -+								      &oids->oid[i]);
     -+
     -+			if (parent_count > stats->max_commit_parent_count)
     -+				stats->max_commit_parent_count = parent_count;
     -+		}
     -+
     - 		stats->type_counts.commits += oids->nr;
     - 		stats->inflated_sizes.commits += inflated_total;
     -+		if (max_inflated > stats->max_inflated_sizes.commits)
     -+			stats->max_inflated_sizes.commits = max_inflated;
     - 		stats->disk_sizes.commits += disk_total;
     -+		if (max_disk > stats->max_disk_sizes.commits)
     -+			stats->max_disk_sizes.commits = max_disk;
     - 		break;
     - 	case OBJ_TREE:
     -+		for (size_t i = 0; i < oids->nr; i++) {
     -+			size_t entry_count = get_tree_entry_count(data->odb->repo,
     -+								  &oids->oid[i]);
     -+
     -+			if (entry_count > stats->max_tree_entry_count)
     -+				stats->max_tree_entry_count = entry_count;
     -+		}
     -+
     - 		stats->type_counts.trees += oids->nr;
     - 		stats->inflated_sizes.trees += inflated_total;
     -+		if (max_inflated > stats->max_inflated_sizes.trees)
     -+			stats->max_inflated_sizes.trees = max_inflated;
     - 		stats->disk_sizes.trees += disk_total;
     -+		if (max_disk > stats->max_disk_sizes.trees)
     -+			stats->max_disk_sizes.trees = max_disk;
     - 		break;
     - 	case OBJ_BLOB:
     -+		if (path && *path) {
     -+			size_t path_len = strlen(path);
     -+			size_t path_depth = get_path_depth(path);
     -+
     -+			if (path_len > stats->max_blob_path_length)
     -+				stats->max_blob_path_length = path_len;
     -+			if (path_depth > stats->max_blob_path_depth)
     -+				stats->max_blob_path_depth = path_depth;
     -+		}
     -+
     - 		stats->type_counts.blobs += oids->nr;
     - 		stats->inflated_sizes.blobs += inflated_total;
     -+		if (max_inflated > stats->max_inflated_sizes.blobs)
     -+			stats->max_inflated_sizes.blobs = max_inflated;
     - 		stats->disk_sizes.blobs += disk_total;
     -+		if (max_disk > stats->max_disk_sizes.blobs)
     -+			stats->max_disk_sizes.blobs = max_disk;
     - 		break;
     - 	default:
     - 		BUG("invalid object type");
     -
     - ## t/t1900-repo.sh ##
     -@@ t/t1900-repo.sh: REPO_INFO_KEYS='
     - 	layout.bare
     - 	layout.shallow
     - 	object.format
     -+	path.common-dir
     -+	path.config-file
     -+	path.git-dir
     -+	path.git-prefix
     -+	path.grafts-file
     -+	path.hooks-directory
     -+	path.index-file
     -+	path.logs-directory
     -+	path.objects-directory
     -+	path.packed-refs-file
     -+	path.refs-directory
     -+	path.shallow-file
     -+	path.superproject-working-tree
     -+	path.toplevel
     - 	references.format
     - '
     - 
     -+REPO_INFO_PATH_KEYS='
     -+	path.common-dir
     -+	path.config-file
     -+	path.git-dir
     -+	path.git-prefix
     -+	path.grafts-file
     -+	path.hooks-directory
     -+	path.index-file
     -+	path.logs-directory
     -+	path.objects-directory
     -+	path.packed-refs-file
     -+	path.refs-directory
     -+	path.shallow-file
     -+	path.superproject-working-tree
     -+	path.toplevel
     -+'
     -+
     - # Test whether a key-value pair is correctly returned
     - #
     - # Usage: test_repo_info <label> <init command> <repo_name> <key> <expected value>
     -@@ t/t1900-repo.sh: test_expect_success 'values returned in order requested' '
     - 	test_cmp expect actual
     - '
     - 
     -+test_expect_success 'category key returns all matching keys' '
     -+	cat >expect <<-\EOF &&
     -+	layout.bare=false
     -+	layout.shallow=false
     -+	EOF
     -+	git init category-layout &&
     -+	git -C category-layout repo info layout >actual &&
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success 'mixed key/category requests preserve request order' '
     -+	cat >expect <<-\EOF &&
     -+	object.format=sha1
     -+	layout.bare=false
     -+	layout.shallow=false
     -+	EOF
     -+	git init mixed-order &&
     -+	git -C mixed-order repo info object.format layout >actual &&
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success 'path.git-dir matches rev-parse --absolute-git-dir' '
     -+	git init path-git-dir &&
     -+	expected_value=$(git -C path-git-dir rev-parse --absolute-git-dir) &&
     -+	echo "path.git-dir=$expected_value" >expect &&
     -+	git -C path-git-dir repo info path.git-dir >actual &&
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success 'path.common-dir matches rev-parse --git-common-dir' '
     -+	git init path-common-dir &&
     -+	expected_value=$(git -C path-common-dir rev-parse --path-format=absolute --git-common-dir) &&
     -+	echo "path.common-dir=$expected_value" >expect &&
     -+	git -C path-common-dir repo info path.common-dir >actual &&
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success 'path.toplevel matches rev-parse --show-toplevel' '
     -+	git init path-toplevel &&
     -+	expected_value=$(git -C path-toplevel rev-parse --show-toplevel) &&
     -+	echo "path.toplevel=$expected_value" >expect &&
     -+	git -C path-toplevel repo info path.toplevel >actual &&
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success 'path.toplevel is empty in bare repository' '
     -+	git init --bare bare-path-toplevel &&
     -+	echo "path.toplevel=" >expect &&
     -+	git -C bare-path-toplevel repo info path.toplevel >actual &&
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success 'path.git-prefix matches rev-parse --show-prefix' '
     -+	git init path-prefix &&
     -+	mkdir -p path-prefix/a/b &&
     -+	expected_value=$(git -C path-prefix/a/b rev-parse --show-prefix) &&
     -+	echo "path.git-prefix=$expected_value" >expect &&
     -+	git -C path-prefix/a/b repo info path.git-prefix >actual &&
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success 'git-path style keys match rev-parse --git-path' '
     -+	git init path-git-path &&
     -+
     -+	expected_value=$(git -C path-git-path rev-parse --path-format=absolute --git-path info/grafts) &&
     -+	echo "path.grafts-file=$expected_value" >expect &&
     -+	git -C path-git-path repo info path.grafts-file >actual &&
     -+	test_cmp expect actual &&
     -+
     -+	expected_value=$(git -C path-git-path rev-parse --path-format=absolute --git-path index) &&
     -+	echo "path.index-file=$expected_value" >expect &&
     -+	git -C path-git-path repo info path.index-file >actual &&
     -+	test_cmp expect actual &&
     -+
     -+	expected_value=$(git -C path-git-path rev-parse --path-format=absolute --git-path objects) &&
     -+	echo "path.objects-directory=$expected_value" >expect &&
     -+	git -C path-git-path repo info path.objects-directory >actual &&
     -+	test_cmp expect actual &&
     -+
     -+	expected_value=$(git -C path-git-path rev-parse --path-format=absolute --git-path hooks) &&
     -+	echo "path.hooks-directory=$expected_value" >expect &&
     -+	git -C path-git-path repo info path.hooks-directory >actual &&
     -+	test_cmp expect actual &&
     -+
     -+	expected_value=$(git -C path-git-path rev-parse --path-format=absolute --git-path config) &&
     -+	echo "path.config-file=$expected_value" >expect &&
     -+	git -C path-git-path repo info path.config-file >actual &&
     -+	test_cmp expect actual &&
     -+
     -+	expected_value=$(git -C path-git-path rev-parse --path-format=absolute --git-path logs) &&
     -+	echo "path.logs-directory=$expected_value" >expect &&
     -+	git -C path-git-path repo info path.logs-directory >actual &&
     -+	test_cmp expect actual &&
     -+
     -+	expected_value=$(git -C path-git-path rev-parse --path-format=absolute --git-path packed-refs) &&
     -+	echo "path.packed-refs-file=$expected_value" >expect &&
     -+	git -C path-git-path repo info path.packed-refs-file >actual &&
     -+	test_cmp expect actual &&
     -+
     -+	expected_value=$(git -C path-git-path rev-parse --path-format=absolute --git-path refs) &&
     -+	echo "path.refs-directory=$expected_value" >expect &&
     -+	git -C path-git-path repo info path.refs-directory >actual &&
     -+	test_cmp expect actual &&
     -+
     -+	expected_value=$(git -C path-git-path rev-parse --path-format=absolute --git-path shallow) &&
     -+	echo "path.shallow-file=$expected_value" >expect &&
     -+	git -C path-git-path repo info path.shallow-file >actual &&
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success 'path.superproject-working-tree is empty when not a submodule' '
     -+	git init path-superproject &&
     -+	echo "path.superproject-working-tree=" >expect &&
     -+	git -C path-superproject repo info path.superproject-working-tree >actual &&
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success 'path.superproject-working-tree matches rev-parse in submodule' '
     -+	git init path-superproject-origin &&
     -+	echo x >path-superproject-origin/x &&
     -+	git -C path-superproject-origin add x &&
     -+	git -C path-superproject-origin commit -m x &&
     -+
     -+	git init path-superproject-parent &&
     -+	git -C path-superproject-parent -c protocol.file.allow=always submodule add ../path-superproject-origin sm &&
     -+
     -+	expected_value=$(git -C path-superproject-parent/sm rev-parse --show-superproject-working-tree) &&
     -+	echo "path.superproject-working-tree=$expected_value" >expect &&
     -+	git -C path-superproject-parent/sm repo info path.superproject-working-tree >actual &&
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success 'path category returns all path keys' '
     -+	git init path-category &&
     -+	>expect &&
     -+	for key in $REPO_INFO_PATH_KEYS
     -+	do
     -+		git -C path-category repo info "$key" >>expect || return 1
     -+	done &&
     -+	git -C path-category repo info path >actual &&
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success 'path-format=relative matches rev-parse for git-dir' '
     -+	git init path-format-relative &&
     -+	expected_value=$(git -C path-format-relative rev-parse --path-format=relative --git-dir) &&
     -+	echo "path.git-dir=$expected_value" >expect &&
     -+	git -C path-format-relative repo info --path-format=relative path.git-dir >actual &&
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success 'git repo info uses the last requested path format' '
     -+	git init path-format-last &&
     -+	expected_value=$(git -C path-format-last rev-parse --path-format=relative --git-dir) &&
     -+	echo "path.git-dir=$expected_value" >expect &&
     -+	git -C path-format-last repo info --path-format=absolute --path-format=relative path.git-dir >actual &&
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success 'git-repo-info aborts when requesting an invalid path format' '
     -+	echo "fatal: invalid path format ${SQ}foo${SQ}" >expect &&
     -+	test_must_fail git repo info --path-format=foo path.git-dir 2>actual &&
     -+	test_cmp expect actual
     -+'
     -+
     - test_expect_success 'git-repo-info fails if an invalid key is requested' '
     - 	echo "error: key ${SQ}foo${SQ} not found" >expect &&
     - 	test_must_fail git repo info foo 2>actual &&
     +    Signed-off-by: Eslam reda ragheb <eslam.reda.div@gmail.com>
      
       ## t/t1901-repo-structure.sh ##
      @@ t/t1901-repo-structure.sh: object_type_disk_usage() {
     @@ t/t1901-repo-structure.sh: object_type_disk_usage() {
      +		--filter=object:type=tree --filter-provided-objects | cut -d" " -f1)
      +	do
      +		entries=$(git cat-file -p "$oid" | wc -l) || return 1
     -+		test "$entries" -gt "$max" && max=$entries
     ++		test $entries -gt $max && max=$entries
      +	done
      +
     -+	echo "$max"
     ++	echo $max
      +}
      +
      +blob_max_path_length() {
  2:  cb85ee3b48 <  -:  ---------- t1900,t1901: make repo tests hash-agnostic and wc-portable
  3:  3c656bf152 <  -:  ---------- t1900,t1901: fix test portability issues
  -:  ---------- >  9:  f17c0f03e5 docs: describe repo info path keys and structure metrics

-- 
gitgitgadget
