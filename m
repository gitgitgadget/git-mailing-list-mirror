Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 818E31F461
	for <e@80x24.org>; Mon, 13 May 2019 17:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731714AbfEMR15 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 13:27:57 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41794 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731611AbfEMR14 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 13:27:56 -0400
Received: by mail-ed1-f65.google.com with SMTP id m4so18674063edd.8
        for <git@vger.kernel.org>; Mon, 13 May 2019 10:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2Jr5J9YPUw9Vk+iV0r0ziaCjhYrjhX9spXFsp48lRs0=;
        b=W1UXll2DcNEdGS85v5v2ir+dzaJ156Xl68QGiMWxVZoDFaNH+jh2TODuQFVJeRtO5F
         wphlqr2lWROM0YsBjZGnaWAW4v5ZRacFQJboVVW1JvUjPTJMDDbfyv4SdZNXIooWYaxs
         ETl4f7GdKfFMHbcypvNvLDmYqZQOuq+1mF8WaQe88wIdnxZoLHg0T7f3f3OCYwBmlDIN
         Bi8Bb7qTHW6X/j0mqXWgs6+8JSYj+pNruPDZhvjImLvNgjzL8sYKfzKA+byMVyvXQd/M
         go3q11TpgyYwjiUgrvYbHYiru2dmGTNcFwZYhLQpHgCJs/43K/qLkToo9B4CQiTQhw3X
         TaAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2Jr5J9YPUw9Vk+iV0r0ziaCjhYrjhX9spXFsp48lRs0=;
        b=piKLC4k9TUztjJhXflP2YtDMQiMWqfVoK9Aj9XNZ6l+hdz4Oy9VYzFXei2kEh8NQa8
         bSB9Z6Z/BBrzZnOORwIFr85Tbp4SiT+asdsmW3agK5MHwWd80Y3HWXAMcCy9pVE3uy7/
         s+sW6ppXH+m3GXtN0+lUhML7OcjEoOlb+CRFmritxxfChal1aBM966whwVP4OQFcOfVw
         wVZ8bpv2n7U8qDrpYHhefDxHWTlnExGI/9ErZKK57V0SFkppeO4b4PPbYzWvYNwOnxIN
         +M641zqUABMnXr8kNYe190O1iP9o/CStE/htlSlMfY+vYTLiK4AD1dSuepkN6hhWo4Oc
         X8ew==
X-Gm-Message-State: APjAAAUTjiCBCh13d9FDgZUjcOouhQ3mjwAeF7G1ELG2T201XbJFkMWD
        dz8Pr1HhFlE5fl4AyWId+P60JgWC
X-Google-Smtp-Source: APXvYqyQqbaa1gs1T5j3HAHNklNjariEhsDywiujNOrRWsvlVQ51SUNKL3WtPR+cnhLLinasT30jkQ==
X-Received: by 2002:a17:906:61c3:: with SMTP id t3mr5004505ejl.273.1557768473597;
        Mon, 13 May 2019 10:27:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x40sm3866876edx.52.2019.05.13.10.27.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 10:27:52 -0700 (PDT)
Date:   Mon, 13 May 2019 10:27:52 -0700 (PDT)
X-Google-Original-Date: Mon, 13 May 2019 17:27:40 GMT
Message-Id: <pull.170.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.git.gitgitgadget@gmail.com>
References: <pull.170.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 00/11] git add -i: add a rudimentary version in C (supporting only status and help 
 so far)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the first leg on the long journey to a fully built-in git add -i 
(next up: parts 2 [https://github.com/gitgitgadget/git/pull/171], 3
[https://github.com/gitgitgadget/git/pull/172], 4
[https://github.com/gitgitgadget/git/pull/173], 5
[https://github.com/gitgitgadget/git/pull/174], and 6
[https://github.com/gitgitgadget/git/pull/175]). Note: the latter PRs are
not necessarily up to date, and will be re-targeted to the appropriate
branches in https://github.com/gitster/git as soon as Junio picks them up.

This here patch series reflects the part that was submitted a couple of
times (see https://github.com/gitgitgadget/git/pull/103) during the
Outreachy project by Slavica Ðukic that continued the journey based on an
initial patch series by Daniel Ferreira.

It only implements the status and the help part, in the interest of making
the review remotely more reviewable.

As I am a heavy user of git add -p myself and use a patched version for
weeks already (it is so nice to not suffer over one second startup until the
MSYS2 Perl finally shows me anything, instead it feels instantaneous), I
integrated these patch series into Git for Windows' master already, as an
opt-in feature guarded by the config variable add.interactive.useBuiltin 
(and Git for Windows' installer is prepared to detect this version and offer
the option in the graphical user interface).

I had planned on submitting this before v2.22.0-rc0, but there was such a
backlog of builds from a big pushout that I had to wait ;-)

Changes since v1:

 * The config machinery was reworked completely, to not use a callback to 
   git_config(), but instead to query the config via the repo_config_get_*() 
   functions. This also prevents a future "Huh???" moment: the internal add
   --interactive API accepts a parameter of type struct repository *r, but
   the previous configuration did not use that to query the config (and
   could in the future be a repository other than the_repository).
   
   
 * As a consequence, the color sequences are no longer stored in file-local
   variables, but passed around via a struct.
   
   
 * Instead of using the magical constant -2 to quit the main loop, it is now
   defined as LIST_AND_CHOOSE_QUIT (and likewise, LIST_AND_CHOOSE_ERROR is
   defined as -1 and used where appropriate).
   
   
 * Improved the add_prefix_item() function by avoiding buffer overruns, not
   reusing the struct that is used for lookup also for adding the new item,
   and by strengthening the bug check.

Daniel Ferreira (2):
  diff: export diffstat interface
  built-in add -i: implement the `status` command

Johannes Schindelin (6):
  Start to implement a built-in version of `git add --interactive`
  built-in add -i: refresh the index before running `status`
  built-in add -i: color the header in the `status` command
  built-in add -i: implement the main loop
  built-in add -i: support `?` (prompt help)
  built-in add -i: implement the `help` command

Slavica Djukic (3):
  Add a function to determine unique prefixes for a list of strings
  built-in add -i: show unique prefixes of the commands
  built-in add -i: use color in the main loop

 Documentation/config/add.txt |   5 +
 Makefile                     |   3 +
 add-interactive.c            | 558 +++++++++++++++++++++++++++++++++++
 add-interactive.h            |   8 +
 builtin/add.c                |  10 +
 diff.c                       |  37 +--
 diff.h                       |  19 ++
 prefix-map.c                 | 109 +++++++
 prefix-map.h                 |  40 +++
 repository.c                 |  19 ++
 repository.h                 |   7 +
 t/README                     |   4 +
 t/helper/test-prefix-map.c   |  58 ++++
 t/helper/test-tool.c         |   1 +
 t/helper/test-tool.h         |   1 +
 t/t0016-prefix-map.sh        |  10 +
 t/t3701-add-interactive.sh   |  24 ++
 17 files changed, 891 insertions(+), 22 deletions(-)
 create mode 100644 add-interactive.c
 create mode 100644 add-interactive.h
 create mode 100644 prefix-map.c
 create mode 100644 prefix-map.h
 create mode 100644 t/helper/test-prefix-map.c
 create mode 100755 t/t0016-prefix-map.sh


base-commit: 8104ec994ea3849a968b4667d072fedd1e688642
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-170%2Fdscho%2Fadd-i-in-c-status-and-help-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-170/dscho/add-i-in-c-status-and-help-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/170

Range-diff vs v1:

  1:  12978dc248 !  1:  ed53346b92 Start to implement a built-in version of `git add --interactive`
     @@ -62,12 +62,6 @@
      @@
      +#include "cache.h"
      +#include "add-interactive.h"
     -+#include "config.h"
     -+
     -+int add_i_config(const char *var, const char *value, void *cb)
     -+{
     -+	return git_default_config(var, value, cb);
     -+}
      +
      +int run_add_i(struct repository *r, const struct pathspec *ps)
      +{
     @@ -82,8 +76,6 @@
      +#ifndef ADD_INTERACTIVE_H
      +#define ADD_INTERACTIVE_H
      +
     -+int add_i_config(const char *var, const char *value, void *cb);
     -+
      +struct repository;
      +struct pathspec;
      +int run_add_i(struct repository *r, const struct pathspec *ps);
     @@ -102,50 +94,28 @@
       static const char * const builtin_add_usage[] = {
       	N_("git add [<options>] [--] <pathspec>..."),
      @@
     - static int patch_interactive, add_interactive, edit_interactive;
     - static int take_worktree_changes;
     - static int add_renormalize;
     -+static int use_builtin_add_i;
     - 
     - struct update_callback_data {
     - 	int flags;
     -@@
     + {
       	int status, i;
       	struct argv_array argv = ARGV_ARRAY_INIT;
     - 
     -+	if (use_builtin_add_i && !patch_mode)
     -+		return !!run_add_i(the_repository, pathspec);
     ++	int use_builtin_add_i =
     ++		git_env_bool("GIT_TEST_ADD_I_USE_BUILTIN", -1);
     ++	if (use_builtin_add_i < 0)
     ++		git_config_get_bool("add.interactive.usebuiltin",
     ++				    &use_builtin_add_i);
      +
     ++	if (use_builtin_add_i == 1 && !patch_mode)
     ++		return !!run_add_i(the_repository, pathspec);
     + 
       	argv_array_push(&argv, "add--interactive");
       	if (patch_mode)
     - 		argv_array_push(&argv, patch_mode);
      @@
       		ignore_add_errors = git_config_bool(var, value);
       		return 0;
       	}
     --	return git_default_config(var, value, cb);
     -+	if (!strcmp(var, "add.interactive.usebuiltin")) {
     -+		use_builtin_add_i = git_config_bool(var, value);
     -+		return 0;
     -+	}
      +
     -+	return add_i_config(var, value, cb);
     + 	return git_default_config(var, value, cb);
       }
       
     - static const char embedded_advice[] = N_(
     -@@
     - 	int require_pathspec;
     - 	char *seen = NULL;
     - 	struct lock_file lock_file = LOCK_INIT;
     -+	int use_builtin_add_i_env =
     -+		git_env_bool("GIT_TEST_ADD_I_USE_BUILTIN", -1);
     - 
     - 	git_config(add_config, NULL);
     -+	if (use_builtin_add_i_env >= 0)
     -+		use_builtin_add_i = use_builtin_add_i_env;
     - 
     - 	argc = parse_options(argc, argv, prefix, builtin_add_options,
     - 			  builtin_add_usage, PARSE_OPT_KEEP_ARGV0);
      
       diff --git a/t/README b/t/README
       --- a/t/README
  2:  06ba1ae344 =  2:  bc99009fbf diff: export diffstat interface
  3:  be9ab904d1 !  3:  5e23c0756b built-in add -i: implement the `status` command
     @@ -30,16 +30,10 @@
      @@
       #include "cache.h"
       #include "add-interactive.h"
     - #include "config.h"
      +#include "diffcore.h"
      +#include "revision.h"
      +#include "refs.h"
     - 
     - int add_i_config(const char *var, const char *value, void *cb)
     - {
     - 	return git_default_config(var, value, cb);
     - }
     - 
     ++
      +struct item {
      +	const char *name;
      +};
     @@ -276,7 +270,7 @@
      +
      +	return 0;
      +}
     -+
     + 
       int run_add_i(struct repository *r, const struct pathspec *ps)
       {
      -	die(_("No commands are available in the built-in `git add -i` yet!"));
  4:  a512e14609 =  4:  8cafc6ae8d built-in add -i: refresh the index before running `status`
  5:  f7c8df058c <  -:  ---------- built-in add -i: color the header in the `status` command
  -:  ---------- >  5:  83d92a9762 built-in add -i: color the header in the `status` command
  6:  93b3151b6c !  6:  3eec219124 built-in add -i: implement the main loop
     @@ -53,8 +53,8 @@
       	void (*print_item)(int i, struct item *item, void *print_item_data);
       	void *print_item_data;
      @@
     - 
     - static void list(struct item **list, size_t nr, struct list_options *opts)
     + static void list(struct item **list, size_t nr,
     + 		 struct add_i_state *s, struct list_options *opts)
       {
      -	int i;
      +	int i, last_lf = 0;
     @@ -85,28 +85,35 @@
      +	const char *prompt;
      +};
      +
     ++#define LIST_AND_CHOOSE_ERROR (-1)
     ++#define LIST_AND_CHOOSE_QUIT  (-2)
     ++
      +/*
      + * Returns the selected index.
     ++ *
     ++ * If an error occurred, returns `LIST_AND_CHOOSE_ERROR`. Upon EOF,
     ++ * `LIST_AND_CHOOSE_QUIT` is returned.
      + */
      +static ssize_t list_and_choose(struct item **items, size_t nr,
     ++			       struct add_i_state *s,
      +			       struct list_and_choose_options *opts)
      +{
      +	struct strbuf input = STRBUF_INIT;
     -+	ssize_t res = -1;
     ++	ssize_t res = LIST_AND_CHOOSE_ERROR;
      +
      +	for (;;) {
      +		char *p, *endp;
      +
      +		strbuf_reset(&input);
      +
     -+		list(items, nr, &opts->list_opts);
     ++		list(items, nr, s, &opts->list_opts);
      +
      +		printf("%s%s", opts->prompt, "> ");
      +		fflush(stdout);
      +
      +		if (strbuf_getline(&input, stdin) == EOF) {
      +			putchar('\n');
     -+			res = -2;
     ++			res = LIST_AND_CHOOSE_QUIT;
      +			break;
      +		}
      +		strbuf_trim(&input);
     @@ -143,7 +150,7 @@
      +			p += sep + 1;
      +		}
      +
     -+		if (res >= 0)
     ++		if (res != LIST_AND_CHOOSE_ERROR)
      +			break;
       	}
      +
     @@ -164,12 +171,13 @@
      +
      +struct command_item {
      +	struct item item;
     -+	int (*command)(struct repository *r, const struct pathspec *ps,
     ++	int (*command)(struct add_i_state *s, const struct pathspec *ps,
      +		       struct file_list *files, struct list_options *opts);
      +};
      +
       int run_add_i(struct repository *r, const struct pathspec *ps)
       {
     + 	struct add_i_state s = { NULL };
      +	struct list_and_choose_options main_loop_opts = {
      +		{ 4, N_("*** Commands ***"), print_command_item, NULL },
      +		N_("What now")
     @@ -192,21 +200,21 @@
      +	ssize_t i;
       	int res = 0;
       
     - 	strbuf_addstr(&header, "      ");
     + 	if (init_add_i_state(r, &s))
      @@
     - 	if (run_status(r, ps, &files, &opts) < 0)
     + 	if (run_status(&s, ps, &files, &opts) < 0)
       		res = -1;
       
      +	for (;;) {
      +		i = list_and_choose((struct item **)commands,
     -+				    ARRAY_SIZE(commands), &main_loop_opts);
     -+		if (i < -1) {
     ++				    ARRAY_SIZE(commands), &s, &main_loop_opts);
     ++		if (i == LIST_AND_CHOOSE_QUIT) {
      +			printf(_("Bye.\n"));
      +			res = 0;
      +			break;
      +		}
     -+		if (i >= 0)
     -+			res = commands[i]->command(r, ps, &files, &opts);
     ++		if (i != LIST_AND_CHOOSE_ERROR)
     ++			res = commands[i]->command(&s, ps, &files, &opts);
      +	}
      +
       	release_file_list(&files);
  7:  db1ede3636 !  7:  e02a52c3ac Add a function to determine unique prefixes for a list of strings
     @@ -92,40 +92,40 @@
      +static void add_prefix_item(struct prefix_map *prefix_map,
      +			    struct prefix_item *item)
      +{
     -+	struct prefix_map_entry *e = xmalloc(sizeof(*e)), *e2;
     ++	struct prefix_map_entry e = { { NULL } }, *e2;
      +	int j;
      +
     -+	e->item = item;
     -+	e->name = e->item->name;
     ++	e.item = item;
     ++	e.name = item->name;
      +
     -+	for (j = prefix_map->min_length; j <= prefix_map->max_length; j++) {
     -+		if (!isascii(e->name[j])) {
     -+			free(e);
     ++	for (j = prefix_map->min_length;
     ++	     j <= prefix_map->max_length && e.name[j]; j++) {
     ++		/* Avoid breaking UTF-8 multi-byte sequences */
     ++		if (!isascii(e.name[j]))
      +			break;
     -+		}
      +
     -+		e->prefix_length = j;
     -+		hashmap_entry_init(e, memhash(e->name, j));
     -+		e2 = hashmap_get(&prefix_map->map, e, NULL);
     ++		e.prefix_length = j;
     ++		hashmap_entry_init(&e, memhash(e.name, j));
     ++		e2 = hashmap_get(&prefix_map->map, &e, NULL);
      +		if (!e2) {
     -+			/* prefix is unique so far */
     -+			e->item->prefix_length = j;
     -+			hashmap_add(&prefix_map->map, e);
     ++			/* prefix is unique at this stage */
     ++			item->prefix_length = j;
     ++			add_prefix_entry(&prefix_map->map, e.name, j, item);
      +			break;
      +		}
      +
      +		if (!e2->item)
      +			continue; /* non-unique prefix */
      +
     -+		if (j != e2->item->prefix_length)
     -+			BUG("unexpected prefix length: %d != %d",
     -+			    (int)j, (int)e2->item->prefix_length);
     ++		if (j != e2->item->prefix_length || memcmp(e.name, e2->name, j))
     ++			BUG("unexpected prefix length: %d != %d (%s != %s)",
     ++			    j, (int)e2->item->prefix_length, e.name, e2->name);
      +
      +		/* skip common prefix */
     -+		for (; j < prefix_map->max_length && e->name[j]; j++) {
     -+			if (e->item->name[j] != e2->item->name[j])
     ++		for (; j < prefix_map->max_length && e.name[j]; j++) {
     ++			if (e.item->name[j] != e2->item->name[j])
      +				break;
     -+			add_prefix_entry(&prefix_map->map, e->name, j + 1,
     ++			add_prefix_entry(&prefix_map->map, e.name, j + 1,
      +					 NULL);
      +		}
      +
     @@ -140,16 +140,14 @@
      +			e2->item->prefix_length = 0;
      +		e2->item = NULL;
      +
     -+		if (j < prefix_map->max_length && e->name[j]) {
     ++		if (j < prefix_map->max_length && e.name[j]) {
      +			/* found a unique prefix for the item */
     -+			e->item->prefix_length = j + 1;
     -+			add_prefix_entry(&prefix_map->map, e->name, j + 1,
     -+					 e->item);
     -+		} else {
     ++			e.item->prefix_length = j + 1;
     ++			add_prefix_entry(&prefix_map->map, e.name, j + 1,
     ++					 e.item);
     ++		} else
      +			/* item has no (short enough) unique prefix */
     -+			e->item->prefix_length = 0;
     -+			free(e);
     -+		}
     ++			e.item->prefix_length = 0;
      +
      +		break;
      +	}
  8:  56acc31e96 !  8:  ced9b6aced built-in add -i: show unique prefixes of the commands
     @@ -22,10 +22,10 @@
       #include "refs.h"
      +#include "prefix-map.h"
       
     - static int use_color = -1;
     - 
     + struct add_i_state {
     + 	struct repository *r;
      @@
     - 	return git_color_default_config(var, value, cb);
     + 	return 0;
       }
       
      -struct item {
     @@ -57,22 +57,22 @@
       	void *print_item_data;
       };
       
     --static void list(struct item **list, size_t nr, struct list_options *opts)
     +-static void list(struct item **list, size_t nr,
      +static void list(struct prefix_item **list, size_t nr,
     -+		 struct list_options *opts)
     + 		 struct add_i_state *s, struct list_options *opts)
       {
       	int i, last_lf = 0;
     - 
      @@
     - /*
     -  * Returns the selected index.
     +  * If an error occurred, returns `LIST_AND_CHOOSE_ERROR`. Upon EOF,
     +  * `LIST_AND_CHOOSE_QUIT` is returned.
        */
      -static ssize_t list_and_choose(struct item **items, size_t nr,
      +static ssize_t list_and_choose(struct prefix_item **items, size_t nr,
     + 			       struct add_i_state *s,
       			       struct list_and_choose_options *opts)
       {
       	struct strbuf input = STRBUF_INIT;
     - 	ssize_t res = -1;
     + 	ssize_t res = LIST_AND_CHOOSE_ERROR;
       
      +	find_unique_prefixes(items, nr, 1, 4);
      +
     @@ -133,8 +133,8 @@
       		return -1;
       
       	if (files->nr)
     --		list((struct item **)files->file, files->nr, opts);
     -+		list((struct prefix_item **)files->file, files->nr, opts);
     +-		list((struct item **)files->file, files->nr, s, opts);
     ++		list((struct prefix_item **)files->file, files->nr, s, opts);
       	putchar('\n');
       
       	return 0;
     @@ -157,7 +157,7 @@
       struct command_item {
      -	struct item item;
      +	struct prefix_item item;
     - 	int (*command)(struct repository *r, const struct pathspec *ps,
     + 	int (*command)(struct add_i_state *s, const struct pathspec *ps,
       		       struct file_list *files, struct list_options *opts);
       };
      @@
     @@ -166,6 +166,6 @@
       	for (;;) {
      -		i = list_and_choose((struct item **)commands,
      +		i = list_and_choose((struct prefix_item **)commands,
     - 				    ARRAY_SIZE(commands), &main_loop_opts);
     - 		if (i < -1) {
     + 				    ARRAY_SIZE(commands), &s, &main_loop_opts);
     + 		if (i == LIST_AND_CHOOSE_QUIT) {
       			printf(_("Bye.\n"));
  9:  ddd0ee51f6 !  9:  7378af60ad built-in add -i: support `?` (prompt help)
     @@ -12,41 +12,35 @@
       --- a/add-interactive.c
       +++ b/add-interactive.c
      @@
     - 
     - enum color_add_i {
     - 	COLOR_HEADER = 0,
     -+	COLOR_HELP,
     - };
     - 
     - static char list_colors[][COLOR_MAXLEN] = {
     - 	GIT_COLOR_BOLD,      /* Header */
     -+	GIT_COLOR_BOLD_RED,  /* Help */
     + 	struct repository *r;
     + 	int use_color;
     + 	char header_color[COLOR_MAXLEN];
     ++	char help_color[COLOR_MAXLEN];
       };
       
     - static const char *get_add_i_color(enum color_add_i ix)
     + static void init_color(struct repository *r, struct add_i_state *s,
      @@
     - {
     - 	if (!strcasecmp(slot, "header"))
     - 		return COLOR_HEADER;
     -+	if (!strcasecmp(slot, "help"))
     -+		return COLOR_HELP;
     + 	s->use_color = want_color(s->use_color);
     + 
     + 	init_color(r, s, "header", s->header_color, GIT_COLOR_BOLD);
     ++	init_color(r, s, "help", s->help_color, GIT_COLOR_BOLD_RED);
       
     - 	return -1;
     + 	return 0;
       }
      @@
       	struct list_options list_opts;
       
       	const char *prompt;
     -+	void (*print_help)(void);
     ++	void (*print_help)(struct add_i_state *s);
       };
       
     - /*
     + #define LIST_AND_CHOOSE_ERROR (-1)
      @@
       		if (!input.len)
       			break;
       
      +		if (!strcmp(input.buf, "?")) {
     -+			opts->print_help();
     ++			opts->print_help(s);
      +			continue;
      +		}
      +
     @@ -57,9 +51,9 @@
       		       struct file_list *files, struct list_options *opts);
       };
       
     -+static void command_prompt_help(void)
     ++static void command_prompt_help(struct add_i_state *s)
      +{
     -+	const char *help_color = get_add_i_color(COLOR_HELP);
     ++	const char *help_color = s->help_color;
      +	color_fprintf_ln(stdout, help_color, "%s", _("Prompt help:"));
      +	color_fprintf_ln(stdout, help_color, "1          - %s",
      +			 _("select a numbered item"));
     @@ -71,6 +65,7 @@
      +
       int run_add_i(struct repository *r, const struct pathspec *ps)
       {
     + 	struct add_i_state s = { NULL };
       	struct list_and_choose_options main_loop_opts = {
       		{ 4, N_("*** Commands ***"), print_command_item, NULL },
      -		N_("What now")
 10:  3e1a88d9c0 ! 10:  36edef85e6 built-in add -i: use color in the main loop
     @@ -12,51 +12,31 @@
       --- a/add-interactive.c
       +++ b/add-interactive.c
      @@
     - enum color_add_i {
     - 	COLOR_HEADER = 0,
     - 	COLOR_HELP,
     -+	COLOR_PROMPT,
     -+	COLOR_ERROR,
     -+	COLOR_RESET,
     + 	int use_color;
     + 	char header_color[COLOR_MAXLEN];
     + 	char help_color[COLOR_MAXLEN];
     ++	char prompt_color[COLOR_MAXLEN];
     ++	char error_color[COLOR_MAXLEN];
     ++	char reset_color[COLOR_MAXLEN];
       };
       
     - static char list_colors[][COLOR_MAXLEN] = {
     - 	GIT_COLOR_BOLD,      /* Header */
     - 	GIT_COLOR_BOLD_RED,  /* Help */
     -+	GIT_COLOR_BOLD_BLUE, /* Prompt */
     -+	GIT_COLOR_BOLD_RED,  /* Error */
     -+	GIT_COLOR_RESET,     /* Reset */
     - };
     - 
     - static const char *get_add_i_color(enum color_add_i ix)
     + static void init_color(struct repository *r, struct add_i_state *s,
      @@
     - 		return COLOR_HEADER;
     - 	if (!strcasecmp(slot, "help"))
     - 		return COLOR_HELP;
     -+	if (!strcasecmp(slot, "prompt"))
     -+		return COLOR_PROMPT;
     -+	if (!strcasecmp(slot, "error"))
     -+		return COLOR_ERROR;
     -+	if (!strcasecmp(slot, "reset"))
     -+		return COLOR_RESET;
       
     - 	return -1;
     - }
     -@@
     - static ssize_t list_and_choose(struct prefix_item **items, size_t nr,
     - 			       struct list_and_choose_options *opts)
     - {
     -+	const char *prompt_color = get_add_i_color(COLOR_PROMPT);
     -+	const char *error_color = get_add_i_color(COLOR_ERROR);
     - 	struct strbuf input = STRBUF_INIT;
     - 	ssize_t res = -1;
     + 	init_color(r, s, "header", s->header_color, GIT_COLOR_BOLD);
     + 	init_color(r, s, "help", s->help_color, GIT_COLOR_BOLD_RED);
     ++	init_color(r, s, "prompt", s->prompt_color, GIT_COLOR_BOLD_BLUE);
     ++	init_color(r, s, "error", s->error_color, GIT_COLOR_BOLD_RED);
     ++	init_color(r, s, "reset", s->reset_color, GIT_COLOR_RESET);
       
     + 	return 0;
     + }
      @@
       
     - 		list(items, nr, &opts->list_opts);
     + 		list(items, nr, s, &opts->list_opts);
       
      -		printf("%s%s", opts->prompt, "> ");
     -+		color_fprintf(stdout, prompt_color, "%s", opts->prompt);
     ++		color_fprintf(stdout, s->prompt_color, "%s", opts->prompt);
      +		fputs("> ", stdout);
       		fflush(stdout);
       
     @@ -66,7 +46,7 @@
       
       			if (index < 0 || index >= nr)
      -				printf(_("Huh (%s)?\n"), p);
     -+				color_fprintf_ln(stdout, error_color,
     ++				color_fprintf_ln(stdout, s->error_color,
      +						 _("Huh (%s)?"), p);
       			else {
       				res = index;
     @@ -96,20 +76,32 @@
       }
       
      @@
     - 
       int run_add_i(struct repository *r, const struct pathspec *ps)
       {
     -+	struct print_command_item_data data = {
     -+		/*
     -+		 * When color was asked for, use the prompt color for
     -+		 * highlighting, otherwise use square brackets.
     -+		 */
     -+		want_color(use_color) ? get_add_i_color(COLOR_PROMPT) : "[",
     -+		want_color(use_color) ? get_add_i_color(COLOR_RESET) : "]"
     -+	};
     + 	struct add_i_state s = { NULL };
     ++	struct print_command_item_data data;
       	struct list_and_choose_options main_loop_opts = {
      -		{ 4, N_("*** Commands ***"), print_command_item, NULL },
      +		{ 4, N_("*** Commands ***"), print_command_item, &data },
       		N_("What now"), command_prompt_help
       	};
       	struct command_item
     +@@
     + 	if (init_add_i_state(r, &s))
     + 		return error("could not parse `add -i` config");
     + 
     ++	/*
     ++	 * When color was asked for, use the prompt color for
     ++	 * highlighting, otherwise use square brackets.
     ++	 */
     ++	if (s.use_color) {
     ++		data.color = s.prompt_color;
     ++		data.reset = s.reset_color;
     ++	} else {
     ++		data.color = "[";
     ++		data.reset = "]";
     ++	}
     ++
     + 	strbuf_addstr(&header, "      ");
     + 	strbuf_addf(&header, print_file_item_data.modified_fmt,
     + 		    _("staged"), _("unstaged"), _("path"));
 11:  481e3316d5 ! 11:  266dbf2a6b built-in add -i: implement the `help` command
     @@ -18,10 +18,10 @@
       	return 0;
       }
       
     -+static int run_help(struct repository *r, const struct pathspec *ps,
     ++static int run_help(struct add_i_state *s, const struct pathspec *ps,
      +		    struct file_list *files, struct list_options *opts)
      +{
     -+	const char *help_color = get_add_i_color(COLOR_HELP);
     ++	const char *help_color = s->help_color;
      +
      +	color_fprintf_ln(stdout, help_color, "status        - %s",
      +			 _("show paths with changes"));

-- 
gitgitgadget
