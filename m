Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7FA31F454
	for <e@80x24.org>; Mon,  4 Nov 2019 12:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbfKDMPk (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 07:15:40 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54321 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbfKDMPi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 07:15:38 -0500
Received: by mail-wm1-f67.google.com with SMTP id z26so3220802wmi.4
        for <git@vger.kernel.org>; Mon, 04 Nov 2019 04:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=0wCCG89sPFqMbhbV1S++YPhfaljr5COSN+bgK8ZYFME=;
        b=XoLbgmzEku4eDhZNyJ7E2fC1r+KhAR9yd6jKyix8BH3XY6cmpXO0fBiS3Sg0XIJ70J
         RvCpFQPqAhHCOZIRi97W0Ca6Svs0349uGZRHgYcV+HnP+/Ev6dnHXTQbMDW0cMHCez4H
         37gcAU8HTjByneAOgJEbVPJedioldA+IyH50gYMcICbKZVqf2hN+wxnTvJnfkWplEN+Z
         EO0fpoCCRzDTxpMsvCtPB9YI+KrCT/OMo6HvW6JCKyyhH9n/4rMxdUtp/TgFPwWrNVuh
         MuLsHWosav9oDz4TXCQLbEnIsATa55+GFC4Hh409pUNWaOXQLexBgykPZSGVAHvU6Swq
         OtWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=0wCCG89sPFqMbhbV1S++YPhfaljr5COSN+bgK8ZYFME=;
        b=U1Q1wPQwxEm2l3OrMFYBQuPnzvBG/gY3bPoViNv/gGGiA2RoA6+bUvkqP9ArNgXk6s
         5eTeI5VRF9hdmvjnO4cVl3zA3ZZA3UiFsSve1H14lM/3Ikkz1mW5fI8pvpstjZSiRkJO
         y9b5004GI+NqeR9zykFInIf0lgcx0Oloh/ey92ZvA/1VLjes9xz6TJ6INFUhDgUo72M1
         q2jFhlYz3fTgb7URWbc/ymQl5kxMNO4hxBOiR+5FOypfk5i9R+LdyMTR8Lcu52wT/imy
         xC/EolZ6xDtTtP7VedXbH53RlxfieRY40apaM1M1NFy5FJOxMmR5scQeJhQGNxKW9hy0
         dcpw==
X-Gm-Message-State: APjAAAWILOZ9cmVZ5HHBqE8+hE6Y/h5jVrTMpOBFLsf/LTcYNkwGxyDI
        KOiCu3QfrweWUVziibYs8gM2fP89
X-Google-Smtp-Source: APXvYqz1bAbs2tDFIIfKyPpjY3R+HmlxZMpGv9kq8MlVF341BgOKWObxKi2D6r3jxt6QgyY4kP6NGw==
X-Received: by 2002:a1c:26c2:: with SMTP id m185mr6871495wmm.169.1572869731899;
        Mon, 04 Nov 2019 04:15:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b66sm19495259wmh.39.2019.11.04.04.15.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 04:15:31 -0800 (PST)
Message-Id: <pull.170.v5.git.1572869729.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.v4.git.gitgitgadget@gmail.com>
References: <pull.170.v4.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 Nov 2019 12:15:20 +0000
Subject: [PATCH v5 0/9] git add -i: add a rudimentary version in C (supporting only status and help 
 so far)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
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
several months already (it is so nice to not suffer over one second startup
until the MSYS2 Perl finally shows me anything, instead it feels
instantaneous), I integrated these patch series into Git for Windows
already, as an opt-in feature guarded by the config variable 
add.interactive.useBuiltin (and Git for Windows' installer knows to detect
this version and offer the option in the graphical user interface).

Changes since v4:

 * Rebased onto current master to make use of Thomas Gummerer's 
   repo_refresh_and_write_index() as well as to avoid merge conflicts with
   Eric Wong's work on struct hashmap.
 * Instead of rolling a dedicated data struct to simulate a Trie, we now use 
   string-list extensively (an unsorted copy and a sorted one, the latter to
   determine unique prefixes). This had massive ramifications on the rest of
   the patches... For example, the struct command_item structure no longer
   contains the name field, but is intended to be a util in a string_list.
 * Changed the commit messages and author lines to reflect Slavica's name
   correctly.
 * Touched up a couple commit messages.

Changes since v3:

 * Rebased to v2.23.0 to reduce friction.
 * free_diffstat_info() is now made public as well, and used, to avoid a
   memory leak.
 * Prepared the patches for ew/hashmap (which is strict about the hashmap
   entries' type in hashmap_entry_init() and friends).
 * The private data types have been moved from prefix-map.h to prefix-map.c.
 * A lot of int types were converted to more appropriate size_t in 
   prefix-map.c.
 * A misleading parameter name list was renamed to the correct array.
 * The code comment above find_unique_prefixes() was (hopefully) improved.
 * The run_help() function's signature now reflects that most of the
   parameters are actually unused.

Changes since v2:

 * Rebased to master to avoid merge conflicts.
 * Renumbered the prefix-map test to avoid conflicts with two patch series
   that are currently in-flight in pu.

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

Johannes Schindelin (4):
  Start to implement a built-in version of `git add --interactive`
  built-in add -i: implement the main loop
  built-in add -i: show unique prefixes of the commands
  built-in add -i: support `?` (prompt help)

Slavica Đukić (3):
  built-in add -i: color the header in the `status` command
  built-in add -i: use color in the main loop
  built-in add -i: implement the `help` command

 Documentation/config/add.txt |   5 +
 Makefile                     |   1 +
 add-interactive.c            | 650 +++++++++++++++++++++++++++++++++++
 add-interactive.h            |   8 +
 builtin/add.c                |  10 +
 diff.c                       |  39 +--
 diff.h                       |  20 ++
 t/README                     |   4 +
 t/t3701-add-interactive.sh   |  25 ++
 9 files changed, 739 insertions(+), 23 deletions(-)
 create mode 100644 add-interactive.c
 create mode 100644 add-interactive.h


base-commit: 566a1439f6f56c2171b8853ddbca0ad3f5098770
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-170%2Fdscho%2Fadd-i-in-c-status-and-help-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-170/dscho/add-i-in-c-status-and-help-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/170

Range-diff vs v4:

  1:  ad8752eca7 !  1:  ff59d2d0b3 Start to implement a built-in version of `git add --interactive`
     @@ -47,7 +47,7 @@
       --- a/Makefile
       +++ b/Makefile
      @@
     - 	-name '*.h' -print))
     + 	-name '*.h' -print)))
       
       LIB_OBJS += abspath.o
      +LIB_OBJS += add-interactive.o
     @@ -125,7 +125,7 @@
       git-config(1).
       
      +GIT_TEST_ADD_I_USE_BUILTIN=<boolean>, when true, enables the
     -+builtin version of git add -i. See 'add.interactive.useBuiltin' in
     ++built-in version of git add -i. See 'add.interactive.useBuiltin' in
      +git-config(1).
      +
       GIT_TEST_INDEX_THREADS=<n> enables exercising the multi-threaded loading
  2:  38cc04c1d9 !  2:  2fc8cc3546 diff: export diffstat interface
     @@ -12,7 +12,7 @@
          builtin implementation of git-add--interactive's status.
      
          Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
     -    Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
     +    Signed-off-by: Slavica Đukić <slawica92@hotmail.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       diff --git a/diff.c b/diff.c
  3:  ee3e40293c !  3:  6aaa0de4f4 built-in add -i: implement the `status` command
     @@ -3,7 +3,7 @@
          built-in add -i: implement the `status` command
      
          This implements the `status` command of `git add -i`. The data
     -    structures introduced in this commit will be extended as needed later.
     +    structures introduced in this commit will be extended later, as needed.
      
          At this point, we re-implement only part of the `list_and_choose()`
          function of the Perl script `git-add--interactive.perl` and call it
     @@ -16,12 +16,8 @@
          will be used to implement the main loop of the built-in `git add -i`, at
          which point the new `status` command can actually be used.
      
     -    Note that we pass the list of items as a `struct item **` as opposed to
     -    a `struct item *`, to allow for the actual items to contain much more
     -    information than merely the name.
     -
          Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
     -    Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
     +    Signed-off-by: Slavica Đukić <slawica92@hotmail.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       diff --git a/add-interactive.c b/add-interactive.c
     @@ -33,29 +29,35 @@
      +#include "diffcore.h"
      +#include "revision.h"
      +#include "refs.h"
     ++#include "string-list.h"
      +
     -+struct item {
     -+	const char *name;
     ++struct add_i_state {
     ++	struct repository *r;
      +};
      +
     ++static void init_add_i_state(struct add_i_state *s, struct repository *r)
     ++{
     ++       s->r = r;
     ++}
     ++
      +struct list_options {
      +	const char *header;
     -+	void (*print_item)(int i, struct item *item, void *print_item_data);
     ++	void (*print_item)(int i, struct string_list_item *item, void *print_item_data);
      +	void *print_item_data;
      +};
      +
     -+static void list(struct item **list, size_t nr, struct list_options *opts)
     ++static void list(struct string_list *list, struct list_options *opts)
      +{
      +	int i;
      +
     -+	if (!nr)
     ++	if (!list->nr)
      +		return;
      +
      +	if (opts->header)
      +		printf("%s\n", opts->header);
      +
     -+	for (i = 0; i < nr; i++) {
     -+		opts->print_item(i, list[i], opts->print_item_data);
     ++	for (i = 0; i < list->nr; i++) {
     ++		opts->print_item(i, list->items + i, opts->print_item_data);
      +		putchar('\n');
      +	}
      +}
     @@ -65,62 +67,34 @@
      +	unsigned seen:1, binary:1;
      +};
      +
     -+struct file_list {
     -+	struct file_item {
     -+		struct item item;
     -+		struct adddel index, worktree;
     -+	} **file;
     -+	size_t nr, alloc;
     ++struct file_item {
     ++	struct adddel index, worktree;
      +};
      +
     -+static void add_file_item(struct file_list *list, const char *name)
     ++static void add_file_item(struct string_list *files, const char *name)
      +{
     -+	struct file_item *item;
     -+
     -+	FLEXPTR_ALLOC_STR(item, item.name, name);
     ++	struct file_item *item = xcalloc(sizeof(*item), 1);
      +
     -+	ALLOC_GROW(list->file, list->nr + 1, list->alloc);
     -+	list->file[list->nr++] = item;
     -+}
     -+
     -+static void reset_file_list(struct file_list *list)
     -+{
     -+	size_t i;
     -+
     -+	for (i = 0; i < list->nr; i++)
     -+		free(list->file[i]);
     -+	list->nr = 0;
     -+}
     -+
     -+static void release_file_list(struct file_list *list)
     -+{
     -+	reset_file_list(list);
     -+	FREE_AND_NULL(list->file);
     -+	list->alloc = 0;
     -+}
     -+
     -+static int file_item_cmp(const void *a, const void *b)
     -+{
     -+	const struct file_item * const *f1 = a;
     -+	const struct file_item * const *f2 = b;
     -+
     -+	return strcmp((*f1)->item.name, (*f2)->item.name);
     ++	string_list_append(files, name)->util = item;
      +}
      +
      +struct pathname_entry {
      +	struct hashmap_entry ent;
     -+	size_t index;
     -+	char pathname[FLEX_ARRAY];
     ++	const char *name;
     ++	struct file_item *item;
      +};
      +
      +static int pathname_entry_cmp(const void *unused_cmp_data,
     -+			      const void *entry, const void *entry_or_key,
     -+			      const void *pathname)
     ++			      const struct hashmap_entry *he1,
     ++			      const struct hashmap_entry *he2,
     ++			      const void *name)
      +{
     -+	const struct pathname_entry *e1 = entry, *e2 = entry_or_key;
     ++	const struct pathname_entry *e1 =
     ++		container_of(he1, const struct pathname_entry, ent);
     ++	const struct pathname_entry *e2 =
     ++		container_of(he2, const struct pathname_entry, ent);
      +
     -+	return strcmp(e1->pathname,
     -+		      pathname ? (const char *)pathname : e2->pathname);
     ++	return strcmp(e1->name, name ? (const char *)name : e2->name);
      +}
      +
      +struct collection_status {
     @@ -128,7 +102,7 @@
      +
      +	const char *reference;
      +
     -+	struct file_list *list;
     ++	struct string_list *files;
      +	struct hashmap file_map;
      +};
      +
     @@ -149,24 +123,24 @@
      +		const char *name = stat.files[i]->name;
      +		int hash = strhash(name);
      +		struct pathname_entry *entry;
     -+		size_t file_index;
     -+		struct file_item *file;
     ++		struct file_item *file_item;
      +		struct adddel *adddel;
      +
     -+		entry = hashmap_get_from_hash(&s->file_map, hash, name);
     -+		if (entry)
     -+			file_index = entry->index;
     -+		else {
     -+			FLEX_ALLOC_STR(entry, pathname, name);
     ++		entry = hashmap_get_entry_from_hash(&s->file_map, hash, name,
     ++						    struct pathname_entry, ent);
     ++		if (!entry) {
     ++			add_file_item(s->files, name);
     ++
     ++			entry = xcalloc(sizeof(*entry), 1);
      +			hashmap_entry_init(&entry->ent, hash);
     -+			entry->index = file_index = s->list->nr;
     ++			entry->name = s->files->items[s->files->nr - 1].string;
     ++			entry->item = s->files->items[s->files->nr - 1].util;
      +			hashmap_add(&s->file_map, &entry->ent);
     -+
     -+			add_file_item(s->list, name);
      +		}
     -+		file = s->list->file[file_index];
      +
     -+		adddel = s->phase == FROM_INDEX ? &file->index : &file->worktree;
     ++		file_item = entry->item;
     ++		adddel = s->phase == FROM_INDEX ?
     ++			&file_item->index : &file_item->worktree;
      +		adddel->seen = 1;
      +		adddel->add = stat.files[i]->added;
      +		adddel->del = stat.files[i]->deleted;
     @@ -176,7 +150,7 @@
      +	free_diffstat_info(&stat);
      +}
      +
     -+static int get_modified_files(struct repository *r, struct file_list *list,
     ++static int get_modified_files(struct repository *r, struct string_list *files,
      +			      const struct pathspec *ps)
      +{
      +	struct object_id head_oid;
     @@ -184,10 +158,12 @@
      +					     &head_oid, NULL);
      +	struct collection_status s = { FROM_WORKTREE };
      +
     -+	if (repo_read_index_preload(r, ps, 0) < 0)
     ++	if (discard_index(r->index) < 0 ||
     ++	    repo_read_index_preload(r, ps, 0) < 0)
      +		return error(_("could not read index"));
      +
     -+	s.list = list;
     ++	string_list_clear(files, 1);
     ++	s.files = files;
      +	hashmap_init(&s.file_map, pathname_entry_cmp, NULL, 0);
      +
      +	for (s.phase = FROM_WORKTREE; s.phase <= FROM_INDEX; s.phase++) {
     @@ -214,15 +190,15 @@
      +			run_diff_files(&rev, 0);
      +		}
      +	}
     -+	hashmap_free(&s.file_map, 1);
     ++	hashmap_free_entries(&s.file_map, struct pathname_entry, ent);
      +
      +	/* While the diffs are ordered already, we ran *two* diffs... */
     -+	QSORT(list->file, list->nr, file_item_cmp);
     ++	string_list_sort(files);
      +
      +	return 0;
      +}
      +
     -+static void populate_wi_changes(struct strbuf *buf,
     ++static void render_adddel(struct strbuf *buf,
      +				struct adddel *ad, const char *no_changes)
      +{
      +	if (ad->binary)
     @@ -239,34 +215,31 @@
      +	struct strbuf buf, index, worktree;
      +};
      +
     -+static void print_file_item(int i, struct item *item,
     ++static void print_file_item(int i, struct string_list_item *item,
      +			    void *print_file_item_data)
      +{
     -+	struct file_item *c = (struct file_item *)item;
     ++	struct file_item *c = item->util;
      +	struct print_file_item_data *d = print_file_item_data;
      +
      +	strbuf_reset(&d->index);
      +	strbuf_reset(&d->worktree);
      +	strbuf_reset(&d->buf);
      +
     -+	populate_wi_changes(&d->worktree, &c->worktree, _("nothing"));
     -+	populate_wi_changes(&d->index, &c->index, _("unchanged"));
     ++	render_adddel(&d->worktree, &c->worktree, _("nothing"));
     ++	render_adddel(&d->index, &c->index, _("unchanged"));
      +	strbuf_addf(&d->buf, d->modified_fmt,
     -+		    d->index.buf, d->worktree.buf, item->name);
     ++		    d->index.buf, d->worktree.buf, item->string);
      +
      +	printf(" %2d: %s", i + 1, d->buf.buf);
      +}
      +
     -+static int run_status(struct repository *r, const struct pathspec *ps,
     -+		      struct file_list *files, struct list_options *opts)
     ++static int run_status(struct add_i_state *s, const struct pathspec *ps,
     ++		      struct string_list *files, struct list_options *opts)
      +{
     -+	reset_file_list(files);
     -+
     -+	if (get_modified_files(r, files, ps) < 0)
     ++	if (get_modified_files(s->r, files, ps) < 0)
      +		return -1;
      +
     -+	if (files->nr)
     -+		list((struct item **)files->file, files->nr, opts);
     ++	list(files, opts);
      +	putchar('\n');
      +
      +	return 0;
     @@ -275,6 +248,7 @@
       int run_add_i(struct repository *r, const struct pathspec *ps)
       {
      -	die(_("No commands are available in the built-in `git add -i` yet!"));
     ++	struct add_i_state s = { NULL };
      +	struct print_file_item_data print_file_item_data = {
      +		"%12s %12s %s", STRBUF_INIT, STRBUF_INIT, STRBUF_INIT
      +	};
     @@ -282,17 +256,24 @@
      +		NULL, print_file_item, &print_file_item_data
      +	};
      +	struct strbuf header = STRBUF_INIT;
     -+	struct file_list files = { NULL };
     ++	struct string_list files = STRING_LIST_INIT_DUP;
      +	int res = 0;
      +
     ++	init_add_i_state(&s, r);
      +	strbuf_addstr(&header, "      ");
      +	strbuf_addf(&header, print_file_item_data.modified_fmt,
      +		    _("staged"), _("unstaged"), _("path"));
      +	opts.header = header.buf;
      +
     -+	res = run_status(r, ps, &files, &opts);
     ++	if (discard_index(r->index) < 0 ||
     ++	    repo_read_index(r) < 0 ||
     ++	    repo_refresh_and_write_index(r, REFRESH_QUIET, 0, 1,
     ++					 NULL, NULL, NULL) < 0)
     ++		warning(_("could not refresh index"));
     ++
     ++	res = run_status(&s, ps, &files, &opts);
      +
     -+	release_file_list(&files);
     ++	string_list_clear(&files, 1);
      +	strbuf_release(&print_file_item_data.buf);
      +	strbuf_release(&print_file_item_data.index);
      +	strbuf_release(&print_file_item_data.worktree);
  4:  3c855d9fa5 <  -:  ---------- built-in add -i: refresh the index before running `status`
  5:  24737a09f7 !  4:  e405f07110 built-in add -i: color the header in the `status` command
     @@ -1,4 +1,4 @@
     -Author: Johannes Schindelin <johannes.schindelin@gmx.de>
     +Author: Slavica Đukić <slawica92@hotmail.com>
      
          built-in add -i: color the header in the `status` command
      
     @@ -7,7 +7,7 @@
          `git-add--interactive.perl` does.
      
          Original-Patch-By: Daniel Ferreira <bnmvco@gmail.com>
     -    Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
     +    Signed-off-by: Slavica Đukić <slawica92@hotmail.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       diff --git a/add-interactive.c b/add-interactive.c
     @@ -21,13 +21,14 @@
       #include "diffcore.h"
       #include "revision.h"
       #include "refs.h"
     +@@
       
     -+struct add_i_state {
     -+	struct repository *r;
     + struct add_i_state {
     + 	struct repository *r;
      +	int use_color;
      +	char header_color[COLOR_MAXLEN];
     -+};
     -+
     + };
     + 
      +static void init_color(struct repository *r, struct add_i_state *s,
      +		       const char *slot_name, char *dst,
      +		       const char *default_color)
     @@ -44,8 +45,9 @@
      +	free(key);
      +}
      +
     -+static int init_add_i_state(struct repository *r, struct add_i_state *s)
     -+{
     + static void init_add_i_state(struct add_i_state *s, struct repository *r)
     + {
     +-       s->r = r;
      +	const char *value;
      +
      +	s->r = r;
     @@ -58,20 +60,16 @@
      +	s->use_color = want_color(s->use_color);
      +
      +	init_color(r, s, "header", s->header_color, GIT_COLOR_BOLD);
     -+
     -+	return 0;
     -+}
     -+
     - struct item {
     - 	const char *name;
     - };
     + }
     + 
     + struct list_options {
      @@
       	void *print_item_data;
       };
       
     --static void list(struct item **list, size_t nr, struct list_options *opts)
     -+static void list(struct item **list, size_t nr,
     -+		 struct add_i_state *s, struct list_options *opts)
     +-static void list(struct string_list *list, struct list_options *opts)
     ++static void list(struct add_i_state *s, struct string_list *list,
     ++		 struct list_options *opts)
       {
       	int i;
       
     @@ -83,51 +81,14 @@
      +		color_fprintf_ln(stdout, s->header_color,
      +				 "%s", opts->header);
       
     - 	for (i = 0; i < nr; i++) {
     - 		opts->print_item(i, list[i], opts->print_item_data);
     + 	for (i = 0; i < list->nr; i++) {
     + 		opts->print_item(i, list->items + i, opts->print_item_data);
      @@
     - 	printf(" %2d: %s", i + 1, d->buf.buf);
     - }
     - 
     --static int run_status(struct repository *r, const struct pathspec *ps,
     -+static int run_status(struct add_i_state *s, const struct pathspec *ps,
     - 		      struct file_list *files, struct list_options *opts)
     - {
     - 	reset_file_list(files);
     - 
     --	if (get_modified_files(r, files, ps) < 0)
     -+	if (get_modified_files(s->r, files, ps) < 0)
     + 	if (get_modified_files(s->r, files, ps) < 0)
       		return -1;
       
     - 	if (files->nr)
     --		list((struct item **)files->file, files->nr, opts);
     -+		list((struct item **)files->file, files->nr, s, opts);
     +-	list(files, opts);
     ++	list(s, files, opts);
       	putchar('\n');
       
       	return 0;
     -@@
     - 
     - int run_add_i(struct repository *r, const struct pathspec *ps)
     - {
     -+	struct add_i_state s = { NULL };
     - 	struct print_file_item_data print_file_item_data = {
     - 		"%12s %12s %s", STRBUF_INIT, STRBUF_INIT, STRBUF_INIT
     - 	};
     -@@
     - 	struct file_list files = { NULL };
     - 	int res = 0;
     - 
     -+	if (init_add_i_state(r, &s))
     -+		return error("could not parse `add -i` config");
     -+
     - 	strbuf_addstr(&header, "      ");
     - 	strbuf_addf(&header, print_file_item_data.modified_fmt,
     - 		    _("staged"), _("unstaged"), _("path"));
     - 	opts.header = header.buf;
     - 
     - 	repo_refresh_and_write_index(r, REFRESH_QUIET, 1);
     --	if (run_status(r, ps, &files, &opts) < 0)
     -+	if (run_status(&s, ps, &files, &opts) < 0)
     - 		res = -1;
     - 
     - 	release_file_list(&files);
  6:  ac67731cf1 !  5:  25590fbbbe built-in add -i: implement the main loop
     @@ -45,26 +45,26 @@
       --- a/add-interactive.c
       +++ b/add-interactive.c
      @@
     - };
     + }
       
       struct list_options {
      +	int columns;
       	const char *header;
     - 	void (*print_item)(int i, struct item *item, void *print_item_data);
     + 	void (*print_item)(int i, struct string_list_item *item, void *print_item_data);
       	void *print_item_data;
      @@
     - static void list(struct item **list, size_t nr,
     - 		 struct add_i_state *s, struct list_options *opts)
     + static void list(struct add_i_state *s, struct string_list *list,
     + 		 struct list_options *opts)
       {
      -	int i;
      +	int i, last_lf = 0;
       
     - 	if (!nr)
     + 	if (!list->nr)
       		return;
      @@
       
     - 	for (i = 0; i < nr; i++) {
     - 		opts->print_item(i, list[i], opts->print_item_data);
     + 	for (i = 0; i < list->nr; i++) {
     + 		opts->print_item(i, list->items + i, opts->print_item_data);
      +
      +		if ((opts->columns) && ((i + 1) % (opts->columns))) {
      +			putchar('\t');
     @@ -94,8 +94,7 @@
      + * If an error occurred, returns `LIST_AND_CHOOSE_ERROR`. Upon EOF,
      + * `LIST_AND_CHOOSE_QUIT` is returned.
      + */
     -+static ssize_t list_and_choose(struct item **items, size_t nr,
     -+			       struct add_i_state *s,
     ++static ssize_t list_and_choose(struct add_i_state *s, struct string_list *items,
      +			       struct list_and_choose_options *opts)
      +{
      +	struct strbuf input = STRBUF_INIT;
     @@ -106,7 +105,7 @@
      +
      +		strbuf_reset(&input);
      +
     -+		list(items, nr, s, &opts->list_opts);
     ++		list(s, items, &opts->list_opts);
      +
      +		printf("%s%s", opts->prompt, "> ");
      +		fflush(stdout);
     @@ -140,7 +139,7 @@
      +			}
      +
      +			p[sep] = '\0';
     -+			if (index < 0 || index >= nr)
     ++			if (index < 0 || index >= items->nr)
      +				printf(_("Huh (%s)?\n"), p);
      +			else {
      +				res = index;
     @@ -163,17 +162,15 @@
       	return 0;
       }
       
     -+static void print_command_item(int i, struct item *item,
     ++typedef int (*command_t)(struct add_i_state *s, const struct pathspec *ps,
     ++			 struct string_list *files,
     ++			 struct list_options *opts);
     ++
     ++static void print_command_item(int i, struct string_list_item *item,
      +			       void *print_command_item_data)
      +{
     -+	printf(" %2d: %s", i + 1, item->name);
     ++	printf(" %2d: %s", i + 1, item->string);
      +}
     -+
     -+struct command_item {
     -+	struct item item;
     -+	int (*command)(struct add_i_state *s, const struct pathspec *ps,
     -+		       struct file_list *files, struct list_options *opts);
     -+};
      +
       int run_add_i(struct repository *r, const struct pathspec *ps)
       {
     @@ -182,11 +179,13 @@
      +		{ 4, N_("*** Commands ***"), print_command_item, NULL },
      +		N_("What now")
      +	};
     -+	struct command_item
     -+		status = { { "status" }, run_status };
     -+	struct command_item *commands[] = {
     -+		&status
     ++	struct {
     ++		const char *string;
     ++		command_t command;
     ++	} command_list[] = {
     ++		{ "status", run_status },
      +	};
     ++	struct string_list commands = STRING_LIST_INIT_NODUP;
      +
       	struct print_file_item_data print_file_item_data = {
       		"%12s %12s %s", STRBUF_INIT, STRBUF_INIT, STRBUF_INIT
     @@ -196,27 +195,42 @@
      +		0, NULL, print_file_item, &print_file_item_data
       	};
       	struct strbuf header = STRBUF_INIT;
     - 	struct file_list files = { NULL };
     + 	struct string_list files = STRING_LIST_INIT_DUP;
      +	ssize_t i;
       	int res = 0;
       
     - 	if (init_add_i_state(r, &s))
     ++	for (i = 0; i < ARRAY_SIZE(command_list); i++)
     ++		string_list_append(&commands, command_list[i].string)
     ++			->util = command_list[i].command;
     ++
     + 	init_add_i_state(&s, r);
     ++
     + 	strbuf_addstr(&header, "      ");
     + 	strbuf_addf(&header, print_file_item_data.modified_fmt,
     + 		    _("staged"), _("unstaged"), _("path"));
      @@
     - 	if (run_status(&s, ps, &files, &opts) < 0)
     - 		res = -1;
     + 
     + 	res = run_status(&s, ps, &files, &opts);
       
      +	for (;;) {
     -+		i = list_and_choose((struct item **)commands,
     -+				    ARRAY_SIZE(commands), &s, &main_loop_opts);
     ++		i = list_and_choose(&s, &commands, &main_loop_opts);
      +		if (i == LIST_AND_CHOOSE_QUIT) {
      +			printf(_("Bye.\n"));
      +			res = 0;
      +			break;
      +		}
     -+		if (i != LIST_AND_CHOOSE_ERROR)
     -+			res = commands[i]->command(&s, ps, &files, &opts);
     ++		if (i != LIST_AND_CHOOSE_ERROR) {
     ++			command_t command = commands.items[i].util;
     ++			res = command(&s, ps, &files, &opts);
     ++		}
      +	}
      +
     - 	release_file_list(&files);
     + 	string_list_clear(&files, 1);
       	strbuf_release(&print_file_item_data.buf);
       	strbuf_release(&print_file_item_data.index);
     + 	strbuf_release(&print_file_item_data.worktree);
     + 	strbuf_release(&header);
     ++	string_list_clear(&commands, 0);
     + 
     + 	return res;
     + }
  7:  c5a699b6b2 <  -:  ---------- Add a function to determine unique prefixes for a list of strings
  8:  bc7a74f697 !  6:  57fdc01463 built-in add -i: show unique prefixes of the commands
     @@ -1,4 +1,4 @@
     -Author: Slavica Djukic <slawica92@hotmail.com>
     +Author: Johannes Schindelin <johannes.schindelin@gmx.de>
      
          built-in add -i: show unique prefixes of the commands
      
     @@ -7,97 +7,197 @@
          given parameters), and shown in the list, and accepted as a shortcut for
          the command.
      
     -    We use the prefix map implementation that we just added in the previous
     -    commit for that purpose.
     +    To determine the unique prefixes, as well as to look up the command in
     +    question, we use a copy of the list and sort it.
      
     -    Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
     +    While this might seem like overkill for a single command, it will make
     +    much more sense when all the commands are implemented, and when we reuse
     +    the same logic to present a list of files to edit, with convenient
     +    unique prefixes.
     +
     +    At the start of the development of this patch series, a dedicated data
     +    structure was introduced that imitated the Trie that the Perl version
     +    implements. However, this was deemed overkill, and we now simply sort
     +    the list before determining the length of the unique prefixes by looking
     +    at each item's neighbor. As a bonus, we now use the same sorted list to
     +    perform a binary search using the user-provided prefix as search key.
     +
     +    Original-patch-by: Slavica Đukić <slawica92@hotmail.com>
     +    Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
          Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       diff --git a/add-interactive.c b/add-interactive.c
       --- a/add-interactive.c
       +++ b/add-interactive.c
      @@
     - #include "diffcore.h"
     - #include "revision.h"
     - #include "refs.h"
     -+#include "prefix-map.h"
     - 
     - struct add_i_state {
     - 	struct repository *r;
     -@@
     - 	return 0;
     + 	init_color(r, s, "header", s->header_color, GIT_COLOR_BOLD);
       }
       
     --struct item {
     --	const char *name;
     --};
     -+static ssize_t find_unique(const char *string,
     -+			   struct prefix_item **list, size_t nr)
     ++/*
     ++ * A "prefix item list" is a list of items that are identified by a string, and
     ++ * a unique prefix (if any) is determined for each item.
     ++ *
     ++ * It is implemented in the form of a pair of `string_list`s, the first one
     ++ * duplicating the strings, with the `util` field pointing at a structure whose
     ++ * first field must be `size_t prefix_length`.
     ++ *
     ++ * That `prefix_length` field will be computed by `find_unique_prefixes()`; It
     ++ * will be set to zero if no valid, unique prefix could be found.
     ++ *
     ++ * The second `string_list` is called `sorted` and does _not_ duplicate the
     ++ * strings but simply reuses the first one's, with the `util` field pointing at
     ++ * the `string_item_list` of the first `string_list`. It  will be populated and
     ++ * sorted by `find_unique_prefixes()`.
     ++ */
     ++struct prefix_item_list {
     ++	struct string_list items;
     ++	struct string_list sorted;
     ++	size_t min_length, max_length;
     ++};
     ++#define PREFIX_ITEM_LIST_INIT \
     ++	{ STRING_LIST_INIT_DUP, STRING_LIST_INIT_NODUP, 1, 4 }
     ++
     ++static void prefix_item_list_clear(struct prefix_item_list *list)
     ++{
     ++	string_list_clear(&list->items, 1);
     ++	string_list_clear(&list->sorted, 0);
     ++}
     ++
     ++static void extend_prefix_length(struct string_list_item *p,
     ++				 const char *other_string, size_t max_length)
      +{
     -+	ssize_t found = -1, i;
     -+
     -+	for (i = 0; i < nr; i++) {
     -+		struct prefix_item *item = list[i];
     -+		if (!starts_with(item->name, string))
     -+			continue;
     -+		if (found >= 0)
     -+			return -1;
     -+		found = i;
     ++	size_t *len = p->util;
     ++
     ++	if (!*len || memcmp(p->string, other_string, *len))
     ++		return;
     ++
     ++	for (;;) {
     ++		char c = p->string[*len];
     ++
     ++		/*
     ++		 * Is `p` a strict prefix of `other`? Or have we exhausted the
     ++		 * maximal length of the prefix? Or is the current character a
     ++		 * multi-byte UTF-8 one? If so, there is no valid, unique
     ++		 * prefix.
     ++		 */
     ++		if (!c || ++*len > max_length || !isascii(c)) {
     ++			*len = 0;
     ++			break;
     ++		}
     ++
     ++		if (c != other_string[*len - 1])
     ++			break;
      +	}
     ++}
      +
     -+	return found;
     ++static void find_unique_prefixes(struct prefix_item_list *list)
     ++{
     ++	size_t i;
     ++
     ++	if (list->sorted.nr == list->items.nr)
     ++		return;
     ++
     ++	string_list_clear(&list->sorted, 0);
     ++	/* Avoid reallocating incrementally */
     ++	list->sorted.items = xmalloc(st_mult(sizeof(*list->sorted.items),
     ++					     list->items.nr));
     ++	list->sorted.nr = list->sorted.alloc = list->items.nr;
     ++
     ++	for (i = 0; i < list->items.nr; i++) {
     ++		list->sorted.items[i].string = list->items.items[i].string;
     ++		list->sorted.items[i].util = list->items.items + i;
     ++	}
     ++
     ++	string_list_sort(&list->sorted);
     ++
     ++	for (i = 0; i < list->sorted.nr; i++) {
     ++		struct string_list_item *sorted_item = list->sorted.items + i;
     ++		struct string_list_item *item = sorted_item->util;
     ++		size_t *len = item->util;
     ++
     ++		*len = 0;
     ++		while (*len < list->min_length) {
     ++			char c = item->string[(*len)++];
     ++
     ++			if (!c || !isascii(c)) {
     ++				*len = 0;
     ++				break;
     ++			}
     ++		}
     ++
     ++		if (i > 0)
     ++			extend_prefix_length(item, sorted_item[-1].string,
     ++					     list->max_length);
     ++		if (i + 1 < list->sorted.nr)
     ++			extend_prefix_length(item, sorted_item[1].string,
     ++					     list->max_length);
     ++	}
      +}
     - 
     ++
     ++static ssize_t find_unique(const char *string, struct prefix_item_list *list)
     ++{
     ++	int index = string_list_find_insert_index(&list->sorted, string, 1);
     ++	struct string_list_item *item;
     ++
     ++	if (list->items.nr != list->sorted.nr)
     ++		BUG("prefix_item_list in inconsistent state (%"PRIuMAX
     ++		    " vs %"PRIuMAX")",
     ++		    (uintmax_t)list->items.nr, (uintmax_t)list->sorted.nr);
     ++
     ++	if (index < 0)
     ++		item = list->sorted.items[-1 - index].util;
     ++	else if (index > 0 &&
     ++		 starts_with(list->sorted.items[index - 1].string, string))
     ++		return -1;
     ++	else if (index + 1 < list->sorted.nr &&
     ++		 starts_with(list->sorted.items[index + 1].string, string))
     ++		return -1;
     ++	else if (index < list->sorted.nr)
     ++		item = list->sorted.items[index].util;
     ++	else
     ++		return -1;
     ++	return item - list->items.items;
     ++}
     ++
       struct list_options {
       	int columns;
       	const char *header;
     --	void (*print_item)(int i, struct item *item, void *print_item_data);
     -+	void (*print_item)(int i, struct prefix_item *item,
     -+			   void *print_item_data);
     - 	void *print_item_data;
     - };
     - 
     --static void list(struct item **list, size_t nr,
     -+static void list(struct prefix_item **list, size_t nr,
     - 		 struct add_i_state *s, struct list_options *opts)
     - {
     - 	int i, last_lf = 0;
      @@
        * If an error occurred, returns `LIST_AND_CHOOSE_ERROR`. Upon EOF,
        * `LIST_AND_CHOOSE_QUIT` is returned.
        */
     --static ssize_t list_and_choose(struct item **items, size_t nr,
     -+static ssize_t list_and_choose(struct prefix_item **items, size_t nr,
     - 			       struct add_i_state *s,
     +-static ssize_t list_and_choose(struct add_i_state *s, struct string_list *items,
     ++static ssize_t list_and_choose(struct add_i_state *s,
     ++			       struct prefix_item_list *items,
       			       struct list_and_choose_options *opts)
       {
       	struct strbuf input = STRBUF_INIT;
       	ssize_t res = LIST_AND_CHOOSE_ERROR;
       
     -+	find_unique_prefixes(items, nr, 1, 4);
     ++	find_unique_prefixes(items);
      +
       	for (;;) {
       		char *p, *endp;
       
     + 		strbuf_reset(&input);
     + 
     +-		list(s, items, &opts->list_opts);
     ++		list(s, &items->items, &opts->list_opts);
     + 
     + 		printf("%s%s", opts->prompt, "> ");
     + 		fflush(stdout);
      @@
       			}
       
       			p[sep] = '\0';
     +-			if (index < 0 || index >= items->nr)
      +			if (index < 0)
     -+				index = find_unique(p, items, nr);
     ++				index = find_unique(p, items);
      +
     - 			if (index < 0 || index >= nr)
     ++			if (index < 0 || index >= items->items.nr)
       				printf(_("Huh (%s)?\n"), p);
       			else {
     -@@
     - 
     - struct file_list {
     - 	struct file_item {
     --		struct item item;
     -+		struct prefix_item item;
     - 		struct adddel index, worktree;
     - 	} **file;
     - 	size_t nr, alloc;
     + 				res = index;
      @@
       		strbuf_addstr(buf, no_changes);
       }
     @@ -122,50 +222,74 @@
       struct print_file_item_data {
       	const char *modified_fmt;
       	struct strbuf buf, index, worktree;
     - };
     - 
     --static void print_file_item(int i, struct item *item,
     -+static void print_file_item(int i, struct prefix_item *item,
     - 			    void *print_file_item_data)
     - {
     - 	struct file_item *c = (struct file_item *)item;
      @@
     - 		return -1;
     - 
     - 	if (files->nr)
     --		list((struct item **)files->file, files->nr, s, opts);
     -+		list((struct prefix_item **)files->file, files->nr, s, opts);
     - 	putchar('\n');
     + 			 struct string_list *files,
     + 			 struct list_options *opts);
       
     - 	return 0;
     - }
     - 
     --static void print_command_item(int i, struct item *item,
     -+static void print_command_item(int i, struct prefix_item *item,
     ++struct command_item {
     ++	size_t prefix_length;
     ++	command_t command;
     ++};
     ++
     + static void print_command_item(int i, struct string_list_item *item,
       			       void *print_command_item_data)
       {
     --	printf(" %2d: %s", i + 1, item->name);
     -+	if (!item->prefix_length ||
     -+	    !is_valid_prefix(item->name, item->prefix_length))
     -+		printf(" %2d: %s", i + 1, item->name);
     +-	printf(" %2d: %s", i + 1, item->string);
     ++	struct command_item *util = item->util;
     ++
     ++	if (!util->prefix_length ||
     ++	    !is_valid_prefix(item->string, util->prefix_length))
     ++		printf(" %2d: %s", i + 1, item->string);
      +	else
     -+		printf(" %3d: [%.*s]%s", i + 1,
     -+		       (int)item->prefix_length, item->name,
     -+		       item->name + item->prefix_length);
     ++		printf(" %2d: [%.*s]%s", i + 1,
     ++		       (int)util->prefix_length, item->string,
     ++		       item->string + util->prefix_length);
       }
       
     - struct command_item {
     --	struct item item;
     -+	struct prefix_item item;
     - 	int (*command)(struct add_i_state *s, const struct pathspec *ps,
     - 		       struct file_list *files, struct list_options *opts);
     - };
     + int run_add_i(struct repository *r, const struct pathspec *ps)
      @@
     - 		res = -1;
     + 	} command_list[] = {
     + 		{ "status", run_status },
     + 	};
     +-	struct string_list commands = STRING_LIST_INIT_NODUP;
     ++	struct prefix_item_list commands = PREFIX_ITEM_LIST_INIT;
       
     - 	for (;;) {
     --		i = list_and_choose((struct item **)commands,
     -+		i = list_and_choose((struct prefix_item **)commands,
     - 				    ARRAY_SIZE(commands), &s, &main_loop_opts);
     - 		if (i == LIST_AND_CHOOSE_QUIT) {
     - 			printf(_("Bye.\n"));
     + 	struct print_file_item_data print_file_item_data = {
     + 		"%12s %12s %s", STRBUF_INIT, STRBUF_INIT, STRBUF_INIT
     +@@
     + 	ssize_t i;
     + 	int res = 0;
     + 
     +-	for (i = 0; i < ARRAY_SIZE(command_list); i++)
     +-		string_list_append(&commands, command_list[i].string)
     +-			->util = command_list[i].command;
     ++	for (i = 0; i < ARRAY_SIZE(command_list); i++) {
     ++		struct command_item *util = xcalloc(sizeof(*util), 1);
     ++		util->command = command_list[i].command;
     ++		string_list_append(&commands.items, command_list[i].string)
     ++			->util = util;
     ++	}
     + 
     + 	init_add_i_state(&s, r);
     + 
     +@@
     + 			break;
     + 		}
     + 		if (i != LIST_AND_CHOOSE_ERROR) {
     +-			command_t command = commands.items[i].util;
     +-			res = command(&s, ps, &files, &opts);
     ++			struct command_item *util =
     ++				commands.items.items[i].util;
     ++			res = util->command(&s, ps, &files, &opts);
     + 		}
     + 	}
     + 
     +@@
     + 	strbuf_release(&print_file_item_data.index);
     + 	strbuf_release(&print_file_item_data.worktree);
     + 	strbuf_release(&header);
     +-	string_list_clear(&commands, 0);
     ++	prefix_item_list_clear(&commands);
     + 
     + 	return res;
     + }
  9:  74f73e26b4 !  7:  77ad5f333a built-in add -i: support `?` (prompt help)
     @@ -24,9 +24,9 @@
       
       	init_color(r, s, "header", s->header_color, GIT_COLOR_BOLD);
      +	init_color(r, s, "help", s->help_color, GIT_COLOR_BOLD_RED);
     - 
     - 	return 0;
       }
     + 
     + /*
      @@
       	struct list_options list_opts;
       
     @@ -48,8 +48,8 @@
       		for (;;) {
       			size_t sep = strcspn(p, " \t\r\n,");
      @@
     - 		       struct file_list *files, struct list_options *opts);
     - };
     + 		       item->string + util->prefix_length);
     + }
       
      +static void command_prompt_help(struct add_i_state *s)
      +{
     @@ -71,5 +71,5 @@
      -		N_("What now")
      +		N_("What now"), command_prompt_help
       	};
     - 	struct command_item
     - 		status = { { "status" }, run_status };
     + 	struct {
     + 		const char *string;
 10:  88001009bc !  8:  3d0b172a7f built-in add -i: use color in the main loop
     @@ -1,11 +1,11 @@
     -Author: Slavica Djukic <slawica92@hotmail.com>
     +Author: Slavica Đukić <slawica92@hotmail.com>
      
          built-in add -i: use color in the main loop
      
          The error messages as well as the unique prefixes are colored in `git
          add -i` by default; We need to do the same in the built-in version.
      
     -    Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
     +    Signed-off-by: Slavica Đukić <slawica92@hotmail.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       diff --git a/add-interactive.c b/add-interactive.c
     @@ -28,12 +28,12 @@
      +	init_color(r, s, "prompt", s->prompt_color, GIT_COLOR_BOLD_BLUE);
      +	init_color(r, s, "error", s->error_color, GIT_COLOR_BOLD_RED);
      +	init_color(r, s, "reset", s->reset_color, GIT_COLOR_RESET);
     - 
     - 	return 0;
       }
     + 
     + /*
      @@
       
     - 		list(items, nr, s, &opts->list_opts);
     + 		list(s, &items->items, &opts->list_opts);
       
      -		printf("%s%s", opts->prompt, "> ");
      +		color_fprintf(stdout, s->prompt_color, "%s", opts->prompt);
     @@ -42,9 +42,9 @@
       
       		if (strbuf_getline(&input, stdin) == EOF) {
      @@
     - 				index = find_unique(p, items, nr);
     + 				index = find_unique(p, items);
       
     - 			if (index < 0 || index >= nr)
     + 			if (index < 0 || index >= items->items.nr)
      -				printf(_("Huh (%s)?\n"), p);
      +				color_fprintf_ln(stdout, s->error_color,
      +						 _("Huh (%s)?"), p);
     @@ -52,43 +52,46 @@
       				res = index;
       				break;
      @@
     - 	return 0;
     - }
     + 	command_t command;
     + };
       
      +struct print_command_item_data {
      +	const char *color, *reset;
      +};
      +
     - static void print_command_item(int i, struct prefix_item *item,
     + static void print_command_item(int i, struct string_list_item *item,
       			       void *print_command_item_data)
       {
      +	struct print_command_item_data *d = print_command_item_data;
     -+
     - 	if (!item->prefix_length ||
     - 	    !is_valid_prefix(item->name, item->prefix_length))
     - 		printf(" %2d: %s", i + 1, item->name);
     + 	struct command_item *util = item->util;
     + 
     + 	if (!util->prefix_length ||
     + 	    !is_valid_prefix(item->string, util->prefix_length))
     + 		printf(" %2d: %s", i + 1, item->string);
       	else
     --		printf(" %3d: [%.*s]%s", i + 1,
     --		       (int)item->prefix_length, item->name,
     +-		printf(" %2d: [%.*s]%s", i + 1,
     +-		       (int)util->prefix_length, item->string,
     +-		       item->string + util->prefix_length);
      +		printf(" %2d: %s%.*s%s%s", i + 1,
     -+		       d->color, (int)item->prefix_length, item->name, d->reset,
     - 		       item->name + item->prefix_length);
     ++		       d->color, (int)util->prefix_length, item->string,
     ++		       d->reset, item->string + util->prefix_length);
       }
       
     + static void command_prompt_help(struct add_i_state *s)
      @@
       int run_add_i(struct repository *r, const struct pathspec *ps)
       {
       	struct add_i_state s = { NULL };
     -+	struct print_command_item_data data;
     ++	struct print_command_item_data data = { "[", "]" };
       	struct list_and_choose_options main_loop_opts = {
      -		{ 4, N_("*** Commands ***"), print_command_item, NULL },
      +		{ 4, N_("*** Commands ***"), print_command_item, &data },
       		N_("What now"), command_prompt_help
       	};
     - 	struct command_item
     + 	struct {
      @@
     - 	if (init_add_i_state(r, &s))
     - 		return error("could not parse `add -i` config");
     + 
     + 	init_add_i_state(&s, r);
       
      +	/*
      +	 * When color was asked for, use the prompt color for
     @@ -97,9 +100,6 @@
      +	if (s.use_color) {
      +		data.color = s.prompt_color;
      +		data.reset = s.reset_color;
     -+	} else {
     -+		data.color = "[";
     -+		data.reset = "]";
      +	}
      +
       	strbuf_addstr(&header, "      ");
 11:  b27fbe289f !  9:  85e508ef11 built-in add -i: implement the `help` command
     @@ -1,4 +1,4 @@
     -Author: Johannes Schindelin <johannes.schindelin@gmx.de>
     +Author: Slavica Đukić <slawica92@hotmail.com>
      
          built-in add -i: implement the `help` command
      
     @@ -8,7 +8,7 @@
          To make sure that it renders exactly like the Perl version of `git add
          -i`, we also add a test case for that to `t3701-add-interactive.sh`.
      
     -    Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
     +    Signed-off-by: Slavica Đukić <slawica92@hotmail.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       diff --git a/add-interactive.c b/add-interactive.c
     @@ -19,7 +19,7 @@
       }
       
      +static int run_help(struct add_i_state *s, const struct pathspec *unused_ps,
     -+		    struct file_list *unused_files,
     ++		    struct string_list *unused_files,
      +		    struct list_options *unused_opts)
      +{
      +	color_fprintf_ln(stdout, s->help_color, "status        - %s",
     @@ -38,23 +38,17 @@
      +	return 0;
      +}
      +
     - struct print_command_item_data {
     - 	const char *color, *reset;
     - };
     + typedef int (*command_t)(struct add_i_state *s, const struct pathspec *ps,
     + 			 struct string_list *files,
     + 			 struct list_options *opts);
      @@
     - 		N_("What now"), command_prompt_help
     - 	};
     - 	struct command_item
     --		status = { { "status" }, run_status };
     -+		status = { { "status" }, run_status },
     -+		help = { { "help" }, run_help };
     - 	struct command_item *commands[] = {
     --		&status
     -+		&status,
     -+		&help
     + 		command_t command;
     + 	} command_list[] = {
     + 		{ "status", run_status },
     ++		{ "help", run_help },
       	};
     + 	struct prefix_item_list commands = PREFIX_ITEM_LIST_INIT;
       
     - 	struct print_file_item_data print_file_item_data = {
      
       diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
       --- a/t/t3701-add-interactive.sh

-- 
gitgitgadget
