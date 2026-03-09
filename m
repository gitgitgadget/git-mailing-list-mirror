Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11213C3C17
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 13:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773063536; cv=pass; b=Ha2tVbJFCPO9aBKac6ph1Flp1j2rIvZxcHIwQJL/cEUMtbTN6ZLYU3aQiGaZJ1BY2qPnK2PNSHSJUygY8IMKrECaatVJl0RHI696dcAHT9ROQzYxygv77yksSnDWMRwJ7dKkXIO1MQaQnd2fYJf3QOGJJrlH7RQ6Ybtm4QfLfMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773063536; c=relaxed/simple;
	bh=wiSN+8sXMqTsqYxjuHHMMRik7T9S41837AMfJlfbFSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O2ZpWmezHz3QXhw3+vNSaZfyyI3/u8EUSnynGY2n1hXTxsdsfwT5NFdd0bnYqgqUMqyii3n11oPkY+YnLM8VC+vx46K7nZy7N8+EHs9cK0wGCU+P4IE4oHWb0HzYHoOlU4h8/t40jU1bXIlPlXajIxDpm1vk5g4PDsfjzH2XZRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=Vcm8FWWP; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="Vcm8FWWP"
ARC-Seal: i=1; a=rsa-sha256; t=1773063511; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UrFQFuFLW1uDM1CgJH//bCjLwf+LO5trcsLS+Kk1qLleHIkqQIUU+8nM/BphYIP9fT8aguWGBk35vT1gkTCfL26aKh0eOQ+D1A7x1HNNQqFWoWGSUV1Pa28+PLFGO4deToCF/AvWXe8ZecBd219rOMH5MZ7yRkGjYuYOxMP/qWU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773063511; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=qSh5BpS6GRJsgQRHngnuEBuCe+s3m4+IxJNXXfCbMS4=; 
	b=H9LKOXzGANgu8OmMFUad+qN0HKEZDFe2R6o0IGiKhK4kXypeW0AFshYfD/ihsLI86rGtQseviiAuSae1MWNKA1blo8Ph7VKkuntzXaAwyE3nKMCqo9upp86UBkqVz8nwt5/IVeQa2LBNBOROU7d1DvzaonI+JbhH3c6FL+OgoZE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773063511;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=qSh5BpS6GRJsgQRHngnuEBuCe+s3m4+IxJNXXfCbMS4=;
	b=Vcm8FWWPZYUYoKn5dF/zZBAZcNLPAKNEWV/xLU2YI2RzC7cbWFs3nkn9G7ZfrVfe
	OgQGa/4slIP/PnDbZ0aFtW1Sa0TOqUHcMIIp+TNq/HqfAblgXcdV8w6Qds9xTdPA5Gx
	o5/nN6nADSkSqfd9qE4CyykKcGRVJsUT2H+1uNnY=
Received: by mx.zohomail.com with SMTPS id 177306350854971.95144614146079;
	Mon, 9 Mar 2026 06:38:28 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v3 0/9] Run hooks in parallel
Date: Mon,  9 Mar 2026 15:37:30 +0200
Message-ID: <20260309133739.294555-1-adrian.ratiu@collabora.com>
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

Hello everyone,

This series enables running hook commands in parallel and is based on
the latest config hooks cleanup series [1].

v3 is just a small rebase re-roll to fix conflicts and drop a commit which
is now part of the base series. The logic in unchanged since v2.

Branch pushed to GitHub: [2]
Successful CI run: [3]

Many thanks to all who contributed to this effort up to now, including
Emily, AEvar, Junio, Patrick, Phillip, Brian, Peff and many others.

Thank you,
Adrian

1: https://lore.kernel.org/git/20260309005416.2760030-1-adrian.ratiu@collabora.com/T/#m0b740e28d4fd06104777a5ceb645d3205450b9c9
2: https://github.com/10ne1/git/tree/dev/aratiu/parallel-hooks-v3
3: https://github.com/10ne1/git/actions/runs/22854112520

Changes in v3:
* Rebased on the new config cleanup series, fixed minor conflicts (Adrian)
* Dropped refactor commit which is now part of the base series (Adrian)
* Simplified an entry->parallel asignment to remove shorthand if (Adrian)

Range-diff v2 -> v3:
 1:  f28b0270f9 =  1:  6686d92867 repository: fix repo_init() memleak due to missing _clear()
 2:  c7cc106224 =  2:  61250bdd91 config: add a repo_config_get_uint() helper
 3:  2fe5aa34d6 <  -:  ---------- hook: refactor hook_config_cache from strmap to named struct
 4:  23853aa170 !  3:  2c49e2a523 hook: parse the hook.jobs config
    @@ Commit message
         Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
     
      ## Documentation/config/hook.adoc ##
    -@@ Documentation/config/hook.adoc: hook.<name>.enabled::
    +@@ Documentation/config/hook.adoc: hook.<friendly-name>.enabled::
      	configuration. This is particularly useful when a hook is defined
      	in a system or global config file and needs to be disabled for a
      	specific repository. See linkgit:git-hook[1].
    @@ hook.c
     @@ hook.c: struct hook_config_cache_entry {
       * commands: friendly-name to command map.
       * event_hooks: event-name to list of friendly-names map.
    -  * disabled_hooks: set of friendly-names with hook.name.enabled = false.
    +  * disabled_hooks: set of friendly-names with hook.<friendly-name>.enabled = false.
     + * jobs: value of the global hook.jobs key. Defaults to 0 if unset.
       */
      struct hook_all_config_cb {
    @@ hook.c: static void build_hook_config_map(struct repository *r,
      	strmap_for_each_entry(&cb_data.event_hooks, &iter, e) {
     
      ## hook.h ##
    -@@ hook.h: void hook_list_clear(struct string_list *hooks, cb_data_free_fn cb_data_free);
    +@@ hook.h: void hook_free(void *p, const char *str UNUSED);
       */
      struct hook_config_cache {
      	struct strmap hooks; /* maps event name -> string_list of hooks */
 5:  71380942dc !  4:  3c206fac62 hook: allow parallel hook execution
    @@ Commit message
         Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
     
      ## Documentation/config/hook.adoc ##
    -@@ Documentation/config/hook.adoc: hook.<name>.enabled::
    +@@ Documentation/config/hook.adoc: hook.<friendly-name>.enabled::
      	in a system or global config file and needs to be disabled for a
      	specific repository. See linkgit:git-hook[1].
      
    @@ Documentation/config/hook.adoc: hook.<name>.enabled::
     +`hook.<name>.parallel` set to `true`.
     
      ## hook.c ##
    -@@ hook.c: static void unsorted_string_list_remove(struct string_list *list,
    - 
    - /*
    -  * Cache entry stored as the .util pointer of string_list items inside the
    -- * hook config cache. For now carries only the command for the hook. Next
    -- * commits will add more data.
    -+ * hook config cache. Carries both the resolved command and the parallel flag.
    -  */
    - struct hook_config_cache_entry {
    +@@ hook.c: struct hook_config_cache_entry {
      	char *command;
    + 	enum config_scope scope;
    + 	int disabled;
     +	unsigned int parallel:1;
      };
      
    @@ hook.c: static void unsorted_string_list_remove(struct string_list *list,
     @@ hook.c: struct hook_config_cache_entry {
       * commands: friendly-name to command map.
       * event_hooks: event-name to list of friendly-names map.
    -  * disabled_hooks: set of friendly-names with hook.name.enabled = false.
    +  * disabled_hooks: set of friendly-names with hook.<friendly-name>.enabled = false.
     + * parallel_hooks: friendly-name to parallel flag.
       * jobs: value of the global hook.jobs key. Defaults to 0 if unset.
       */
    @@ hook.c: static void build_hook_config_map(struct repository *r,
      	/* Parse all configs in one run, capturing hook.* including hook.jobs. */
      	repo_config(r, hook_config_lookup_all, &cb_data);
     @@ hook.c: static void build_hook_config_map(struct repository *r,
    - 		for (size_t i = 0; i < hook_names->nr; i++) {
    - 			const char *hname = hook_names->items[i].string;
    + 			enum config_scope scope =
    + 				(enum config_scope)(uintptr_t)hook_names->items[i].util;
      			struct hook_config_cache_entry *entry;
     +			void *par = strmap_get(&cb_data.parallel_hooks, hname);
      			char *command;
      
    - 			/* filter out disabled hooks */
    + 			int is_disabled =
     @@ hook.c: static void build_hook_config_map(struct repository *r,
    - 			/* util stores a cache entry; owned by the cache. */
    - 			CALLOC_ARRAY(entry, 1);
    - 			entry->command = xstrdup(command);
    -+			entry->parallel = par ? (int)(uintptr_t)par : 0;
    + 			entry->command = command ? xstrdup(command) : NULL;
    + 			entry->scope = scope;
    + 			entry->disabled = is_disabled;
    ++			entry->parallel = (int)(uintptr_t)par;
      			string_list_append(hooks, hname)->util = entry;
      		}
      
    @@ hook.c: static void build_hook_config_map(struct repository *r,
      	strmap_for_each_entry(&cb_data.event_hooks, &iter, e) {
      		string_list_clear(e->value, 0);
     @@ hook.c: static void list_hooks_add_configured(struct repository *r,
    - 		hook->kind = HOOK_CONFIGURED;
    - 		hook->u.configured.friendly_name = xstrdup(friendly_name);
    - 		hook->u.configured.command = xstrdup(entry->command);
    + 			entry->command ? xstrdup(entry->command) : NULL;
    + 		hook->u.configured.scope = entry->scope;
    + 		hook->u.configured.disabled = entry->disabled;
     +		hook->parallel = entry->parallel;
      
      		string_list_append(list, friendly_name)->util = hook;
    @@ hook.h: struct run_hooks_opt
      	unsigned int jobs;
      
     @@ hook.h: struct run_hooks_opt
    - 	cb_data_free_fn feed_pipe_cb_data_free;
    + 	hook_data_free_fn feed_pipe_cb_data_free;
      };
      
     +/**
 6:  820064f1c9 !  5:  2385cb3bc8 hook: mark non-parallelizable hooks
    @@ builtin/checkout.c: static void branch_info_release(struct branch_info *info)
      static int update_some(const struct object_id *oid, struct strbuf *base,
     
      ## builtin/clone.c ##
    -@@ builtin/clone.c: static int checkout(int submodule_progress, int filter_submodules,
    +@@ builtin/clone.c: static int checkout(int submodule_progress,
      	struct tree *tree;
      	struct tree_desc t;
      	int err = 0;
    @@ builtin/clone.c: static int checkout(int submodule_progress, int filter_submodul
      
      	if (option_no_checkout)
      		return 0;
    -@@ builtin/clone.c: static int checkout(int submodule_progress, int filter_submodules,
    +@@ builtin/clone.c: static int checkout(int submodule_progress,
      	if (write_locked_index(the_repository->index, &lock_file, COMMIT_LOCK))
      		die(_("unable to write new index file"));
      
 7:  b328f3451f !  6:  c4f92834a7 hook: add -j/--jobs option to git hook run
    @@ Documentation/git-hook.adoc: git-hook - Run git hooks
     -'git hook' run [--ignore-missing] [--to-stdin=<path>] <hook-name> [-- <hook-args>]
     +'git hook' run [--ignore-missing] [--to-stdin=<path>] [(-j|--jobs) <n>]
     +	<hook-name> [-- <hook-args>]
    - 'git hook' list [-z] <hook-name>
    + 'git hook' list [-z] [--show-scope] <hook-name>
      
      DESCRIPTION
     @@ Documentation/git-hook.adoc: OPTIONS
    - -z::
    - 	Terminate "list" output lines with NUL instead of newlines.
    + 	in parentheses after the friendly name of each configured hook, to show
    + 	where it was defined. Traditional hooks from the hookdir are unaffected.
      
     +-j::
     +--jobs::
    @@ Documentation/git-hook.adoc: running:
     
      ## builtin/hook.c ##
     @@
    - #include "abspath.h"
    + #include "parse-options.h"
      
      #define BUILTIN_HOOK_RUN_USAGE \
     -	N_("git hook run [--ignore-missing] [--to-stdin=<path>] <hook-name> [-- <hook-args>]")
     +	N_("git hook run [--ignore-missing] [--to-stdin=<path>] [(-j|--jobs) <n>]\n" \
     +	   "<hook-name> [-- <hook-args>]")
      #define BUILTIN_HOOK_LIST_USAGE \
    - 	N_("git hook list [-z] <hook-name>")
    + 	N_("git hook list [-z] [--show-scope] <hook-name>")
      
     @@ builtin/hook.c: static int run(int argc, const char **argv, const char *prefix,
      			 N_("silently ignore missing requested <hook-name>")),
 8:  ff27b34a8d !  7:  7b3ea03bd3 hook: add per-event jobs config
    @@ Documentation/config/hook.adoc: hook.<name>.parallel::
      ## hook.c ##
     @@ hook.c: struct hook_config_cache_entry {
       * event_hooks: event-name to list of friendly-names map.
    -  * disabled_hooks: set of friendly-names with hook.name.enabled = false.
    +  * disabled_hooks: set of friendly-names with hook.<friendly-name>.enabled = false.
       * parallel_hooks: friendly-name to parallel flag.
     + * event_jobs: event-name to per-event jobs count (heap-allocated unsigned int *,
     + *             where NULL == unset).
    @@ hook.c: int run_hooks_opt(struct repository *r, const char *hook_name,
      		.tr2_label = hook_name,
     
      ## hook.h ##
    -@@ hook.h: void hook_list_clear(struct string_list *hooks, cb_data_free_fn cb_data_free);
    +@@ hook.h: void hook_free(void *p, const char *str UNUSED);
       */
      struct hook_config_cache {
      	struct strmap hooks; /* maps event name -> string_list of hooks */
 9:  2bc572e46e =  8:  d5cf01444f hook: introduce extensions.hookStdoutToStderr
10:  35dbc4a6c5 =  9:  1cef7b5e22 hook: allow runtime enabling extensions.hookStdoutToStderr

Adrian Ratiu (6):
  repository: fix repo_init() memleak due to missing _clear()
  config: add a repo_config_get_uint() helper
  hook: parse the hook.jobs config
  hook: add per-event jobs config
  hook: introduce extensions.hookStdoutToStderr
  hook: allow runtime enabling extensions.hookStdoutToStderr

Emily Shaffer (3):
  hook: allow parallel hook execution
  hook: mark non-parallelizable hooks
  hook: add -j/--jobs option to git hook run

 Documentation/config/extensions.adoc |  15 +
 Documentation/config/hook.adoc       |  49 +++
 Documentation/git-hook.adoc          |  18 +-
 builtin/am.c                         |   8 +-
 builtin/checkout.c                   |  19 +-
 builtin/clone.c                      |   6 +-
 builtin/hook.c                       |   5 +-
 builtin/receive-pack.c               |   3 +-
 builtin/worktree.c                   |   2 +-
 commit.c                             |   2 +-
 config.c                             |  28 ++
 config.h                             |  13 +
 hook.c                               | 149 ++++++++-
 hook.h                               |  28 ++
 parse.c                              |   9 +
 parse.h                              |   1 +
 repository.c                         |   2 +
 repository.h                         |   1 +
 setup.c                              |  17 +
 setup.h                              |   1 +
 t/t1800-hook.sh                      | 446 ++++++++++++++++++++++++++-
 transport.c                          |   7 +-
 22 files changed, 792 insertions(+), 37 deletions(-)

-- 
2.52.0.732.gb351b5166d.dirty

