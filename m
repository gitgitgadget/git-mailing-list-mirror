Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3E5C433F5
	for <git@archiver.kernel.org>; Wed,  5 Oct 2022 15:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiJEPAv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Oct 2022 11:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiJEPAX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 11:00:23 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6FFF4C
        for <git@vger.kernel.org>; Wed,  5 Oct 2022 07:59:36 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u10so26234138wrq.2
        for <git@vger.kernel.org>; Wed, 05 Oct 2022 07:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=qKTQvWXakPNP12xSkIBLt9UiO0sFjkF5RfVLN3poiJM=;
        b=KNnopKTicr9A9Mov8rviK7ReO+5gWPYxukP8BH5tJ5IBYJDY936yBzTUVAxjQucxDC
         WbNsoJ1n1xtIZFeZG+PCins84fT9LutwSNheg8FotQvcoIkiZl7XLDf4vwJ1YFKkgf+M
         QM2N6m0OsG1XHSkfJZzID4ELOR96oO+TaiacO6ouEq6khMndnCf1SWCi/8uiQIMd+Onc
         xvNlML7AL9XRoSGBnyKg6OrJvhW5PsulPQl2siV6FG1tlvxVVM05FDooIQ/yQqlNWjza
         jFwQ7YhNUP0f309zOwpSbRWbqisf9IcrZpheZXPAChEeRJ7baRRpWjpMpRhfy10+Q+tl
         MDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=qKTQvWXakPNP12xSkIBLt9UiO0sFjkF5RfVLN3poiJM=;
        b=ze8pFaLgzqB511hKDQhJlUV88Npad9VUcM2uFj2NEwr8Yt1rf/0XHPJpmwpQAh6k4P
         jgpWV1qYRnLk1VRtlj7/TbeWHAoa6RPC53JYxL7rYoN8SW1lqD38TZrvvdYZ7VpyViTr
         KkmO3k7b8oMuZtuzdODOEJTh9Wfd3guENyNdjf18GuEfo/Z0fgvBl6axDcjXYksu4vLR
         9trTRc2wl50dtEi0HVvEiCPPdo960yMef40Oy1j6W/ZowRP5hSdxZ2SF+bvrlI7LhY9i
         eFDT+NUhSYeDFycgLgaB5rSviSCMTIpyGyqYIBFgZpo1QYigOEbywWBqYZ7IElwH9QFr
         nPUg==
X-Gm-Message-State: ACrzQf2TcOHob+ZkYtIj7vfTmXEz5BRKusKP2c7+7+u9lIFjROMp3Inq
        O6zRp4EI8JsSzdxTlGoRD7q+dz0wpfM=
X-Google-Smtp-Source: AMsMyM6y76z5OYzGG7FLlLrJWkrZbCSlBQtwqJM9ubC1GgXl4Zi91/iJvkMa3OgrtHDWeq3qkprfdA==
X-Received: by 2002:adf:df82:0:b0:22c:dba0:1eff with SMTP id z2-20020adfdf82000000b0022cdba01effmr89466wrl.13.1664981959903;
        Wed, 05 Oct 2022 07:59:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 9-20020a05600c22c900b003b49aa8083esm2067345wmg.42.2022.10.05.07.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 07:59:19 -0700 (PDT)
Message-Id: <pull.1356.v2.git.1664981957.gitgitgadget@gmail.com>
In-Reply-To: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
From:   "Christophe Poucet via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Oct 2022 14:59:07 +0000
Subject: [PATCH v2 00/10] RFC: Git Evolve / Change
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jerry Zhang <jerry@skydio.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Chris Poucet <poucet@google.com>,
        Christophe Poucet <christophe.poucet@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm reviving the original git evolve work that was started by
sxenos@google.com
(https://public-inbox.org/git/20190215043105.163688-1-sxenos@google.com/)

This work is intended to make it easier to deal with stacked changes.

The following set of patches introduces the design doc on the evolve command
as well as the basics of the git change command.

Chris Poucet (5):
  sha1-array: implement oid_array_readonly_contains
  ref-filter: add the metas namespace to ref-filter
  evolve: add delete command
  evolve: add documentation for `git change`
  evolve: add tests for the git-change command

Stefan Xenos (5):
  technical doc: add a design doc for the evolve command
  evolve: add support for parsing metacommits
  evolve: add the change-table structure
  evolve: add support for writing metacommits
  evolve: implement the git change command

 .gitignore                         |    1 +
 Documentation/git-change.txt       |   55 ++
 Documentation/technical/evolve.txt | 1070 ++++++++++++++++++++++++++++
 Makefile                           |    4 +
 builtin.h                          |    1 +
 builtin/change.c                   |  330 +++++++++
 change-table.c                     |  164 +++++
 change-table.h                     |  122 ++++
 commit.c                           |   13 +
 commit.h                           |    5 +
 git.c                              |    1 +
 metacommit-parser.c                |   97 +++
 metacommit-parser.h                |   19 +
 metacommit.c                       |  410 +++++++++++
 metacommit.h                       |   75 ++
 oid-array.c                        |   12 +
 oid-array.h                        |    7 +
 ref-filter.c                       |   10 +-
 ref-filter.h                       |   10 +-
 t/helper/test-oid-array.c          |    6 +
 t/t0064-oid-array.sh               |   22 +
 t/t9990-changes.sh                 |  148 ++++
 22 files changed, 2577 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/git-change.txt
 create mode 100644 Documentation/technical/evolve.txt
 create mode 100644 builtin/change.c
 create mode 100644 change-table.c
 create mode 100644 change-table.h
 create mode 100644 metacommit-parser.c
 create mode 100644 metacommit-parser.h
 create mode 100644 metacommit.c
 create mode 100644 metacommit.h
 create mode 100755 t/t9990-changes.sh


base-commit: 3dcec76d9df911ed8321007b1d197c1a206dc164
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1356%2Fpoucet%2Fevolve-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1356/poucet/evolve-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1356

Range-diff vs v1:

  1:  a0cf68f8ba2 !  1:  a5eb9325419 technical doc: add a design doc for the evolve command
     @@ Documentation/technical/evolve.txt (new)
      +rebase. You can think of rebase -i as a top-down approach and the evolve command
      +as the bottom-up approach to the same problem.
      +
     ++Revup amend (https://github.com/Skydio/revup/blob/main/docs/amend.md)
     ++allows insertion of cached changes into any commit in
     ++the current history, and then reapplies the rest of history on top of
     ++those changes. It uses a "git apply --cached" engine under the hood so
     ++doesn't touch the working directory (although it will soon use the new
     ++git merge-tree). When paired with "revup upload" which creates and
     ++pushes multiple branches in the background for you, its possible to
     ++work on a "graph" of changes on a single branch linearly, then have
     ++the true graph structure created at upload time.
     ++
     ++git-revise (https://github.com/mystor/git-revise) does some very
     ++similar things except it uses "git merge-file" combined with manually
     ++merging the resulting trees. git branchstack
     ++(https://github.com/krobelus/git-branchstack) can also create branches
     ++in the background with the same mechanism.
     ++
     ++These tools don't store any external state, but as such also don't
     ++provide any specific collaboration mechanism for individual changes.
     ++
      +Several patch queue managers have been built on top of git (such as topgit,
      +stgit, and quilt). They address the same user need. However they also rely on
      +state managed outside git that needs to be kept in sync. Such state can be
  2:  84588312c1d =  2:  ed5106d6080 sha1-array: implement oid_array_readonly_contains
  3:  54e559967df !  3:  c59066ebc10 ref-filter: add the metas namespace to ref-filter
     @@ ref-filter.c: int filter_refs(struct ref_array *array, struct ref_filter *filter
      
       ## ref-filter.h ##
      @@
     + #define FILTER_REFS_TAGS           0x0002
       #define FILTER_REFS_BRANCHES       0x0004
       #define FILTER_REFS_REMOTES        0x0008
     - #define FILTER_REFS_OTHERS         0x0010
     -+#define FILTER_REFS_CHANGES        0x0040
     +-#define FILTER_REFS_OTHERS         0x0010
     ++#define FILTER_REFS_CHANGES        0x0010
     ++#define FILTER_REFS_OTHERS         0x0040
       #define FILTER_REFS_ALL            (FILTER_REFS_TAGS | FILTER_REFS_BRANCHES | \
      -				    FILTER_REFS_REMOTES | FILTER_REFS_OTHERS)
      +				    FILTER_REFS_REMOTES | FILTER_REFS_OTHERS | \
  4:  2e9a4a9bd81 !  4:  408941e7400 evolve: add support for parsing metacommits
     @@ Makefile: LIB_OBJS += merge-ort.o
       LIB_OBJS += name-hash.o
       LIB_OBJS += negotiator/default.o
      
     + ## commit.c ##
     +@@ commit.c: struct commit_list *reverse_commit_list(struct commit_list *list)
     + 	return next;
     + }
     + 
     ++struct commit *get_commit_by_index(struct commit_list *to_search, int index)
     ++{
     ++	while (to_search && index) {
     ++		to_search = to_search->next;
     ++		index--;
     ++	}
     ++
     ++	if (!to_search)
     ++		return NULL;
     ++
     ++	return to_search->item;
     ++}
     ++
     + void free_commit_list(struct commit_list *list)
     + {
     + 	while (list)
     +
     + ## commit.h ##
     +@@ commit.h: struct commit_list *copy_commit_list(struct commit_list *list);
     + /* Modify list in-place to reverse it, returning new head; list will be tail */
     + struct commit_list *reverse_commit_list(struct commit_list *list);
     + 
     ++/* Returns the commit at `index` or NULL if the index exceeds the `to_search`
     ++ * list */
     ++struct commit *get_commit_by_index(struct commit_list *to_search, int index);
     ++
     + void free_commit_list(struct commit_list *list);
     + 
     ++
     + struct rev_info; /* in revision.h, it circularly uses enum cmit_fmt */
     + 
     + int has_non_ascii(const char *text);
     +
       ## metacommit-parser.c (new) ##
      @@
      +#include "cache.h"
     @@ metacommit-parser.c (new)
      +	return NULL;
      +}
      +
     -+static struct commit *get_commit_by_index(struct commit_list *to_search, int index)
     -+{
     -+	while (to_search && index) {
     -+		to_search = to_search->next;
     -+		index--;
     -+	}
     -+
     -+	if (!to_search)
     -+		return NULL;
     -+
     -+	return to_search->item;
     -+}
     -+
      +/*
      + * Writes the index of the content parent to "result". Returns the metacommit
      + * type. See the METACOMMIT_TYPE_* constants.
      + */
     -+static int index_of_content_commit(const char *buffer, int *result)
     ++static enum metacommit_type index_of_content_commit(const char *buffer, int *result)
      +{
      +	int index = 0;
      +	int ret = METACOMMIT_TYPE_NONE;
     @@ metacommit-parser.c (new)
      +		char next = *parent_types;
      +		if (next == ' ' || parent_types >= end) {
      +			if (enum_length == 1) {
     -+				char first_char_in_enum = *enum_start;
     -+				if (first_char_in_enum == 'c') {
     ++				char type = *enum_start;
     ++				if (type == 'c') {
      +					ret = METACOMMIT_TYPE_NORMAL;
      +					break;
      +				}
     -+				if (first_char_in_enum == 'a') {
     ++				if (type == 'a') {
      +					ret = METACOMMIT_TYPE_ABANDONED;
      +					break;
      +				}
     @@ metacommit-parser.c (new)
      + * Writes the content parent's object id to "content".
      + * Returns the metacommit type. See the METACOMMIT_TYPE_* constants.
      + */
     -+int get_metacommit_content(struct commit *commit, struct object_id *content)
     ++enum metacommit_type get_metacommit_content(struct commit *commit, struct object_id *content)
      +{
      +	const char *buffer = get_commit_buffer(commit, NULL);
      +	int index = 0;
     -+	int ret = index_of_content_commit(buffer, &index);
     ++	enum metacommit_type ret = index_of_content_commit(buffer, &index);
      +	struct commit *content_parent;
      +
      +	if (ret == METACOMMIT_TYPE_NONE)
     @@ metacommit-parser.h (new)
      +#include "commit.h"
      +#include "hash.h"
      +
     -+/* Indicates a normal commit (non-metacommit) */
     -+#define METACOMMIT_TYPE_NONE 0
     -+/* Indicates a metacommit with normal content (non-abandoned) */
     -+#define METACOMMIT_TYPE_NORMAL 1
     -+/* Indicates a metacommit with abandoned content */
     -+#define METACOMMIT_TYPE_ABANDONED 2
     -+
     -+struct commit;
     ++enum metacommit_type {
     ++	/* Indicates a normal commit (non-metacommit) */
     ++	METACOMMIT_TYPE_NONE = 0,
     ++	/* Indicates a metacommit with normal content (non-abandoned) */
     ++	METACOMMIT_TYPE_NORMAL = 1,
     ++	/* Indicates a metacommit with abandoned content */
     ++	METACOMMIT_TYPE_ABANDONED = 2,
     ++};
      +
     -+extern int get_metacommit_content(
     ++enum metacommit_type get_metacommit_content(
      +	struct commit *commit, struct object_id *content);
      +
      +#endif
  5:  2b3a00a6702 !  5:  48cd92d35ef evolve: add the change-table structure
     @@ change-table.c (new)
      +#include "ref-filter.h"
      +#include "metacommit-parser.h"
      +
     -+void change_table_init(struct change_table *to_initialize)
     ++void change_table_init(struct change_table *table)
      +{
     -+	memset(to_initialize, 0, sizeof(*to_initialize));
     -+	mem_pool_init(&to_initialize->memory_pool, 0);
     -+	to_initialize->memory_pool.block_alloc = 4*1024 - sizeof(struct mp_block);
     -+	oidmap_init(&to_initialize->oid_to_metadata_index, 0);
     -+	string_list_init_dup(&to_initialize->refname_to_change_head);
     ++	memset(table, 0, sizeof(*table));
     ++	mem_pool_init(&table->memory_pool, 0);
     ++	oidmap_init(&table->oid_to_metadata_index, 0);
     ++	strmap_init(&table->refname_to_change_head);
      +}
      +
     -+static void change_list_clear(struct change_list *to_clear) {
     -+	string_list_clear(&to_clear->additional_refnames, 0);
     ++static void change_list_clear(struct change_list *change_list) {
     ++	strset_clear(&change_list->refnames);
      +}
      +
      +static void commit_change_list_entry_clear(
     -+	struct commit_change_list_entry *to_clear) {
     -+	change_list_clear(&to_clear->changes);
     ++	struct commit_change_list_entry *entry) {
     ++	change_list_clear(&entry->changes);
      +}
      +
     -+void change_table_clear(struct change_table *to_clear)
     ++void change_table_clear(struct change_table *table)
      +{
      +	struct oidmap_iter iter;
      +	struct commit_change_list_entry *next;
     -+	for (next = oidmap_iter_first(&to_clear->oid_to_metadata_index, &iter);
     ++	for (next = oidmap_iter_first(&table->oid_to_metadata_index, &iter);
      +		next;
      +		next = oidmap_iter_next(&iter)) {
      +
      +		commit_change_list_entry_clear(next);
      +	}
      +
     -+	oidmap_free(&to_clear->oid_to_metadata_index, 0);
     -+	string_list_clear(&to_clear->refname_to_change_head, 0);
     -+	mem_pool_discard(&to_clear->memory_pool, 0);
     ++	oidmap_free(&table->oid_to_metadata_index, 0);
     ++	strmap_clear(&table->refname_to_change_head, 0);
     ++	mem_pool_discard(&table->memory_pool, 0);
      +}
      +
     -+static void add_head_to_commit(struct change_table *to_modify,
     -+	const struct object_id *to_add, const char *refname)
     ++static void add_head_to_commit(struct change_table *table,
     ++			       const struct object_id *to_add,
     ++			       const char *refname)
      +{
      +	struct commit_change_list_entry *entry;
      +
     -+	/**
     -+	 * Note: the indices in the map are 1-based. 0 is used to indicate a missing
     -+	 * element.
     -+	 */
     -+	entry = oidmap_get(&to_modify->oid_to_metadata_index, to_add);
     ++	entry = oidmap_get(&table->oid_to_metadata_index, to_add);
      +	if (!entry) {
     -+		entry = mem_pool_calloc(&to_modify->memory_pool, 1,
     -+			sizeof(*entry));
     ++		entry = mem_pool_calloc(&table->memory_pool, 1, sizeof(*entry));
      +		oidcpy(&entry->entry.oid, to_add);
     -+		oidmap_put(&to_modify->oid_to_metadata_index, entry);
     -+		string_list_init_nodup(&entry->changes.additional_refnames);
     ++		strset_init(&entry->changes.refnames);
     ++		oidmap_put(&table->oid_to_metadata_index, entry);
      +	}
     -+
     -+	if (!entry->changes.first_refname)
     -+		entry->changes.first_refname = refname;
     -+	else
     -+		string_list_insert(&entry->changes.additional_refnames, refname);
     ++	strset_add(&entry->changes.refnames, refname);
      +}
      +
     -+void change_table_add(struct change_table *to_modify, const char *refname,
     -+	struct commit *to_add)
     ++void change_table_add(struct change_table *table,
     ++		      const char *refname,
     ++		      struct commit *to_add)
      +{
      +	struct change_head *new_head;
     -+	struct string_list_item *new_item;
      +	int metacommit_type;
      +
     -+	new_head = mem_pool_calloc(&to_modify->memory_pool, 1,
     -+		sizeof(*new_head));
     ++	new_head = mem_pool_calloc(&table->memory_pool, 1, sizeof(*new_head));
      +
      +	oidcpy(&new_head->head, &to_add->object.oid);
      +
      +	metacommit_type = get_metacommit_content(to_add, &new_head->content);
     ++	/* If to_add is not a metacommit then the content is to_add itself,
     ++	 * otherwise it will have been set by the call to
     ++	 * get_metacommit_content.
     ++	 */
      +	if (metacommit_type == METACOMMIT_TYPE_NONE)
      +		oidcpy(&new_head->content, &to_add->object.oid);
      +	new_head->abandoned = (metacommit_type == METACOMMIT_TYPE_ABANDONED);
      +	new_head->remote = starts_with(refname, "refs/remote/");
      +	new_head->hidden = starts_with(refname, "refs/hiddenmetas/");
      +
     -+	new_item = string_list_insert(&to_modify->refname_to_change_head, refname);
     -+	new_item->util = new_head;
     -+	/* Use pointers to the copy of the string we're retaining locally */
     -+	refname = new_item->string;
     -+
     -+	if (!oideq(&new_head->content, &new_head->head))
     -+		add_head_to_commit(to_modify, &new_head->content, refname);
     -+	add_head_to_commit(to_modify, &new_head->head, refname);
     -+}
     -+
     -+void change_table_add_all_visible(struct change_table *to_modify,
     -+	struct repository* repo)
     -+{
     -+	struct ref_filter filter;
     -+	const char *name_patterns[] = {NULL};
     -+	memset(&filter, 0, sizeof(filter));
     -+	filter.kind = FILTER_REFS_CHANGES;
     -+	filter.name_patterns = name_patterns;
     ++	strmap_put(&table->refname_to_change_head, refname, new_head);
      +
     -+	change_table_add_matching_filter(to_modify, repo, &filter);
     ++	if (!oideq(&new_head->content, &new_head->head)) {
     ++		/* We also remember to link between refname and the content oid */
     ++		add_head_to_commit(table, &new_head->content, refname);
     ++	}
     ++	add_head_to_commit(table, &new_head->head, refname);
      +}
      +
     -+void change_table_add_matching_filter(struct change_table *to_modify,
     -+	struct repository* repo, struct ref_filter *filter)
     ++static void change_table_add_matching_filter(struct change_table *table,
     ++					     struct repository* repo,
     ++					     struct ref_filter *filter)
      +{
     -+	struct ref_array matching_refs;
      +	int i;
     ++	struct ref_array matching_refs = { 0 };
      +
     -+	memset(&matching_refs, 0, sizeof(matching_refs));
      +	filter_refs(&matching_refs, filter, filter->kind);
      +
     -+	/**
     ++	/*
      +	 * Determine the object id for the latest content commit for each change.
      +	 * Fetch the commit at the head of each change ref. If it's a normal commit,
      +	 * that's the commit we want. If it's a metacommit, locate its content parent
     @@ change-table.c (new)
      +
      +	for (i = 0; i < matching_refs.nr; i++) {
      +		struct ref_array_item *item = matching_refs.items[i];
     -+		struct commit *commit = item->commit;
     ++		struct commit *commit;
      +
     -+		commit = lookup_commit_reference_gently(repo, &item->objectname, 1);
     -+
     -+		if (commit)
     -+			change_table_add(to_modify, item->refname, commit);
     ++		commit = lookup_commit_reference(repo, &item->objectname);
     ++		if (!commit) {
     ++			BUG("Invalid commit for refs/meta: %s", item->refname);
     ++		}
     ++		change_table_add(table, item->refname, commit);
      +	}
      +
      +	ref_array_clear(&matching_refs);
      +}
      +
     ++void change_table_add_all_visible(struct change_table *table,
     ++	struct repository* repo)
     ++{
     ++	struct ref_filter filter = { 0 };
     ++	const char *name_patterns[] = {NULL};
     ++	filter.kind = FILTER_REFS_CHANGES;
     ++	filter.name_patterns = name_patterns;
     ++
     ++	change_table_add_matching_filter(table, repo, &filter);
     ++}
     ++
      +static int return_true_callback(const char *refname, void *cb_data)
      +{
      +	return 1;
      +}
      +
     -+int change_table_has_change_referencing(struct change_table *changes,
     ++int change_table_has_change_referencing(struct change_table *table,
      +	const struct object_id *referenced_commit_id)
      +{
     -+	return for_each_change_referencing(changes, referenced_commit_id,
     ++	return for_each_change_referencing(table, referenced_commit_id,
      +		return_true_callback, NULL);
      +}
      +
      +int for_each_change_referencing(struct change_table *table,
      +	const struct object_id *referenced_commit_id, each_change_fn fn, void *cb_data)
      +{
     -+	const struct change_list *changes;
     -+	int i;
     -+	int retvalue;
     -+	struct commit_change_list_entry *entry;
     ++	int ret;
     ++	struct commit_change_list_entry *ccl_entry;
     ++	struct hashmap_iter iter;
     ++	struct strmap_entry *entry;
      +
     -+	entry = oidmap_get(&table->oid_to_metadata_index,
     -+		referenced_commit_id);
     ++	ccl_entry = oidmap_get(&table->oid_to_metadata_index,
     ++			       referenced_commit_id);
      +	/* If this commit isn't referenced by any changes, it won't be in the map */
     -+	if (!entry)
     ++	if (!ccl_entry)
      +		return 0;
     -+	changes = &entry->changes;
     -+	if (!changes->first_refname)
     -+		return 0;
     -+	retvalue = fn(changes->first_refname, cb_data);
     -+	for (i = 0; retvalue == 0 && i < changes->additional_refnames.nr; i++)
     -+		retvalue = fn(changes->additional_refnames.items[i].string, cb_data);
     -+	return retvalue;
     ++	strset_for_each_entry(&ccl_entry->changes.refnames, &iter, entry) {
     ++		ret = fn(entry->key, cb_data);
     ++		if (ret != 0) break;
     ++	}
     ++	return ret;
      +}
      +
     -+struct change_head* get_change_head(struct change_table *heads,
     ++struct change_head* get_change_head(struct change_table *table,
      +	const char* refname)
      +{
     -+	struct string_list_item *item = string_list_lookup(
     -+		&heads->refname_to_change_head, refname);
     -+
     -+	if (!item)
     -+		return NULL;
     -+
     -+	return (struct change_head *)item->util;
     ++	return strmap_get(&table->refname_to_change_head, refname);
      +}
      
       ## change-table.h (new) ##
     @@ change-table.h (new)
      +#define CHANGE_TABLE_H
      +
      +#include "oidmap.h"
     ++#include "strmap.h"
      +
      +struct commit;
      +struct ref_filter;
      +
      +/**
     -+ * This struct holds a list of change refs. The first element is stored inline,
     -+ * to optimize for small lists.
     ++ * This struct holds a set of change refs.
      + */
      +struct change_list {
      +	/**
     -+	 * Ref name for the first change in the list, or null if none.
     -+	 *
     ++	 * The refnames in this set.
      +	 * This field is private. Use for_each_change_in to read.
      +	 */
     -+	const char* first_refname;
     -+	/**
     -+	 * List of additional change refs. Note that this is empty if the list
     -+	 * contains 0 or 1 elements.
     -+	 *
     -+	 * This field is private. Use for_each_change_in to read.
     -+	 */
     -+	struct string_list additional_refnames;
     ++	struct strset refnames;
      +};
      +
      +/**
     @@ change-table.h (new)
      +};
      +
      +/**
     -+ * Holds information about the heads of each change, and permits effecient
     ++ * Holds information about the heads of each change, and permits efficient
      + * lookup from a commit to the changes that reference it directly.
      + *
      + * All fields should be considered private. Use the change_table functions
     @@ change-table.h (new)
      +	/* Map object_id to commit_change_list_entry structs. */
      +	struct oidmap oid_to_metadata_index;
      +	/**
     -+	 * List of ref names. The util value points to a change_head structure
     -+	 * allocated from memory_pool.
     ++	 * Map of refnames to change_head structure which are allocated from
     ++	 * memory_pool.
      +	 */
     -+	struct string_list refname_to_change_head;
     ++	struct strmap refname_to_change_head;
      +};
      +
     -+extern void change_table_init(struct change_table *to_initialize);
     -+extern void change_table_clear(struct change_table *to_clear);
     ++extern void change_table_init(struct change_table *table);
     ++extern void change_table_clear(struct change_table *table);
      +
      +/* Adds the given change head to the change_table struct */
     -+extern void change_table_add(struct change_table *to_modify,
     -+	const char *refname, struct commit *target);
     ++extern void change_table_add(struct change_table *table,
     ++			     const char *refname,
     ++			     struct commit *target);
      +
      +/**
      + * Adds the non-hidden local changes to the given change_table struct.
      + */
     -+extern void change_table_add_all_visible(struct change_table *to_modify,
     -+	struct repository *repo);
     -+
     -+/*
     -+ * Adds all changes matching the given ref filter to the given change_table
     -+ * struct.
     -+ */
     -+extern void change_table_add_matching_filter(struct change_table *to_modify,
     -+	struct repository* repo, struct ref_filter *filter);
     ++extern void change_table_add_all_visible(struct change_table *table,
     ++					 struct repository *repo);
      +
      +typedef int each_change_fn(const char *refname, void *cb_data);
      +
     -+extern int change_table_has_change_referencing(struct change_table *changes,
     ++extern int change_table_has_change_referencing(
     ++	struct change_table *table,
      +	const struct object_id *referenced_commit_id);
      +
      +/**
     @@ change-table.h (new)
      + * For normal commits, this is the list of changes that have this commit as
      + * their latest content.
      + */
     -+extern int for_each_change_referencing(struct change_table *heads,
     -+	const struct object_id *referenced_commit_id, each_change_fn fn, void *cb_data);
     ++extern int for_each_change_referencing(
     ++	struct change_table *table,
     ++	const struct object_id *referenced_commit_id,
     ++	each_change_fn fn,
     ++	void *cb_data);
      +
      +/**
      + * Returns the change head for the given refname. Returns NULL if no such change
      + * exists.
      + */
     -+extern struct change_head* get_change_head(struct change_table *heads,
     ++extern struct change_head* get_change_head(struct change_table *table,
      +	const char* refname);
      +
      +#endif
  6:  56c6770997b !  6:  353d97d0f38 evolve: add support for writing metacommits
     @@ metacommit.c (new)
      +#include "change-table.h"
      +#include "refs.h"
      +
     -+void init_metacommit_data(struct metacommit_data *state)
     -+{
     -+	memset(state, 0, sizeof(*state));
     -+}
     -+
      +void clear_metacommit_data(struct metacommit_data *state)
      +{
     ++	oidcpy(&state->content, null_oid());
      +	oid_array_clear(&state->replace);
      +	oid_array_clear(&state->origin);
     ++	state->abandoned = 0;
      +}
      +
      +static void compute_default_change_name(struct commit *initial_commit,
     -+	struct strbuf* result)
     ++					struct strbuf* result)
      +{
     -+	struct strbuf default_name;
     ++	struct strbuf default_name = STRBUF_INIT;
      +	const char *buffer;
      +	const char *subject;
      +	const char *eol;
     -+	int len;
     -+	strbuf_init(&default_name, 0);
     ++	size_t len;
      +	buffer = get_commit_buffer(initial_commit, NULL);
      +	find_commit_subject(buffer, &subject);
      +	eol = strchrnul(subject, '\n');
     -+	for (len = 0;subject < eol && len < 10; ++subject, ++len) {
     ++	for (len = 0; subject < eol && len < 10; subject++, len++) {
      +		char next = *subject;
      +		if (isspace(next))
      +			continue;
     @@ metacommit.c (new)
      +		strbuf_addch(&default_name, next);
      +	}
      +	sanitize_refname_component(default_name.buf, result);
     ++	unuse_commit_buffer(initial_commit, buffer);
      +}
      +
     -+/**
     ++/*
      + * Computes a change name for a change rooted at the given initial commit. Good
      + * change names should be memorable, unique, and easy to type. They are not
      + * required to match the commit comment.
      + */
      +static void compute_change_name(struct commit *initial_commit, struct strbuf* result)
      +{
     -+	struct strbuf default_name;
     ++	struct strbuf default_name = STRBUF_INIT;
      +	struct object_id unused;
      +
     -+	strbuf_init(&default_name, 0);
      +	if (initial_commit)
      +		compute_default_change_name(initial_commit, &default_name);
      +	else
     -+		strbuf_addstr(&default_name, "change");
     ++		BUG("initial commit is NULL");
      +	strbuf_addstr(result, "refs/metas/");
      +	strbuf_addbuf(result, &default_name);
      +
      +	/* If there is already a change of this name, append a suffix */
      +	if (!read_ref(result->buf, &unused)) {
      +		int suffix = 2;
     -+		int original_length = result->len;
     ++		size_t original_length = result->len;
      +
      +		while (1) {
      +			strbuf_addf(result, "%d", suffix);
      +			if (read_ref(result->buf, &unused))
      +				break;
     -+			strbuf_remove(result, original_length, result->len - original_length);
     ++			strbuf_remove(result, original_length,
     ++				      result->len - original_length);
      +			++suffix;
      +		}
      +	}
     @@ metacommit.c (new)
      +	strbuf_release(&default_name);
      +}
      +
     -+struct resolve_metacommit_callback_data
     ++struct resolve_metacommit_context
      +{
      +	struct change_table* active_changes;
      +	struct string_list *changes;
     @@ metacommit.c (new)
      +
      +static int resolve_metacommit_callback(const char *refname, void *cb_data)
      +{
     -+	struct resolve_metacommit_callback_data *data = (struct resolve_metacommit_callback_data *)cb_data;
     ++	struct resolve_metacommit_context *data = cb_data;
      +	struct change_head *chhead;
      +
      +	chhead = get_change_head(data->active_changes, refname);
      +
      +	if (data->changes)
     -+		string_list_append(data->changes, refname)->util = &(chhead->head);
     ++		string_list_append(data->changes, refname)->util = &chhead->head;
      +	if (data->heads)
      +		oid_array_append(data->heads, &(chhead->head));
      +
      +	return 0;
      +}
      +
     -+/**
     ++/*
      + * Produces the final form of a metacommit based on the current change refs.
      + */
      +static void resolve_metacommit(
     @@ metacommit.c (new)
      +	struct string_list *to_advance,
      +	int allow_append)
      +{
     -+	int i;
     -+	int len = to_resolve->replace.nr;
     -+	struct resolve_metacommit_callback_data cbdata;
     ++	size_t i;
     ++	size_t len = to_resolve->replace.nr;
     ++	struct resolve_metacommit_context ctx = {
     ++		.active_changes = active_changes,
     ++		.changes = to_advance,
     ++		.heads = &resolved_output->replace
     ++	};
      +	int old_change_list_length = to_advance->nr;
      +	struct commit* content;
      +
      +	oidcpy(&resolved_output->content, &to_resolve->content);
      +
     -+	/* First look for changes that point to any of the replacement edges in the
     ++	/*
     ++	 * First look for changes that point to any of the replacement edges in the
      +	 * metacommit. These will be the changes that get advanced by this
     -+	 * metacommit. */
     ++	 * metacommit.
     ++	 */
      +	resolved_output->abandoned = to_resolve->abandoned;
     -+	cbdata.active_changes = active_changes;
     -+	cbdata.changes = to_advance;
     -+	cbdata.heads = &(resolved_output->replace);
      +
      +	if (allow_append) {
      +		for (i = 0; i < len; i++) {
      +			int old_number = resolved_output->replace.nr;
     -+			for_each_change_referencing(active_changes, &(to_resolve->replace.oid[i]),
     -+				resolve_metacommit_callback, &cbdata);
     ++			for_each_change_referencing(
     ++				active_changes,
     ++				&(to_resolve->replace.oid[i]),
     ++				resolve_metacommit_callback,
     ++				&ctx);
      +			/* If no changes were found, use the unresolved value. */
      +			if (old_number == resolved_output->replace.nr)
     -+				oid_array_append(&(resolved_output->replace), &(to_resolve->replace.oid[i]));
     ++				oid_array_append(&(resolved_output->replace),
     ++						 &(to_resolve->replace.oid[i]));
      +		}
      +	}
      +
     -+	cbdata.changes = NULL;
     -+	cbdata.heads = &(resolved_output->origin);
     ++	ctx.changes = NULL;
     ++	ctx.heads = &(resolved_output->origin);
      +
      +	len = to_resolve->origin.nr;
      +	for (i = 0; i < len; i++) {
      +		int old_number = resolved_output->origin.nr;
     -+		for_each_change_referencing(active_changes, &(to_resolve->origin.oid[i]),
     -+			resolve_metacommit_callback, &cbdata);
     ++		for_each_change_referencing(
     ++			active_changes,
     ++			&(to_resolve->origin.oid[i]),
     ++			resolve_metacommit_callback,
     ++			&ctx);
      +		if (old_number == resolved_output->origin.nr)
     -+			oid_array_append(&(resolved_output->origin), &(to_resolve->origin.oid[i]));
     ++			oid_array_append(&(resolved_output->origin),
     ++					 &(to_resolve->origin.oid[i]));
      +	}
      +
     -+	/* If no changes were advanced by this metacommit, we'll need to create a new
     -+	 * one. */
     ++	/*
     ++	 * If no changes were advanced by this metacommit, we'll need to create
     ++	 * a new one. */
      +	if (to_advance->nr == old_change_list_length) {
      +		struct strbuf change_name;
      +
      +		strbuf_init(&change_name, 80);
     -+		content = lookup_commit_reference_gently(repo, &(to_resolve->content), 1);
     ++
     ++		content = lookup_commit_reference_gently(
     ++			repo, &(to_resolve->content), 1);
      +
      +		compute_change_name(content, &change_name);
      +		string_list_append(to_advance, change_name.buf);
     @@ metacommit.c (new)
      +
      +	while (--i >= 0) {
      +		struct object_id *next = &(to_lookup->oid[i]);
     -+		struct commit *commit = lookup_commit_reference_gently(repo, next, 1);
     ++		struct commit *commit =
     ++			lookup_commit_reference_gently(repo, next, 1);
      +		commit_list_insert(commit, result);
      +	}
      +}
      +
      +#define PARENT_TYPE_PREFIX "parent-type "
      +
     -+/**
     -+ * Creates a new metacommit object with the given content. Writes the object
     -+ * id of the newly-created commit to result.
     -+ */
      +int write_metacommit(struct repository *repo, struct metacommit_data *state,
      +	struct object_id *result)
      +{
      +	struct commit_list *parents = NULL;
      +	struct strbuf comment;
     -+	int i;
     ++	size_t i;
      +	struct commit *content;
      +
      +	strbuf_init(&comment, strlen(PARENT_TYPE_PREFIX)
     @@ metacommit.c (new)
      +		strbuf_addstr(&comment, " o");
      +
      +	/* The parents list will be freed by this call. */
     -+	commit_tree(comment.buf, comment.len, repo->hash_algo->empty_tree, parents,
     -+		result, NULL, NULL);
     ++	commit_tree(
     ++		comment.buf,
     ++		comment.len,
     ++		repo->hash_algo->empty_tree,
     ++		parents,
     ++		result,
     ++		NULL,
     ++		NULL);
      +
      +	strbuf_release(&comment);
      +	return 0;
      +}
      +
     -+/**
     ++/*
      + * Returns true iff the given metacommit is abandoned, has one or more origin
      + * parents, or has one or more replacement parents.
      + */
     @@ metacommit.c (new)
      + * to append to existing changes wherever possible instead of creating new ones.
      + * If override_change is non-null, only the given change ref will be updated.
      + *
     -+ * options is a bitwise combination of the UPDATE_OPTION_* flags.
     -+ */
     -+int record_metacommit(
     -+	struct repository *repo,
     -+	const struct metacommit_data *metacommit, const char *override_change,
     -+	int options, struct strbuf *err)
     -+{
     -+		struct change_table chtable;
     -+		struct string_list changes;
     -+		int result;
     -+
     -+		change_table_init(&chtable);
     -+		change_table_add_all_visible(&chtable, repo);
     -+		string_list_init_dup(&changes);
     -+
     -+		result = record_metacommit_withresult(repo, &chtable, metacommit,
     -+			override_change, options, err, &changes);
     -+
     -+		string_list_clear(&changes, 0);
     -+		change_table_clear(&chtable);
     -+		return result;
     -+}
     -+
     -+/*
     -+ * Records the relationships described by the given metacommit in the
     -+ * repository.
     -+ *
     -+ * If override_change is NULL (the default), an attempt will be made
     -+ * to append to existing changes wherever possible instead of creating new ones.
     -+ * If override_change is non-null, only the given change ref will be updated.
     -+ *
      + * The changes list is filled in with the list of change refs that were updated,
      + * with the util pointers pointing to the old object IDS for those changes.
      + * The object ID pointers all point to objects owned by the change_table and
     @@ metacommit.c (new)
      + *
      + * options is a bitwise combination of the UPDATE_OPTION_* flags.
      + */
     -+int record_metacommit_withresult(
     ++static int record_metacommit_withresult(
      +	struct repository *repo,
      +	struct change_table *chtable,
      +	const struct metacommit_data *metacommit,
      +	const char *override_change,
     -+	int options, struct strbuf *err,
     ++	int options,
     ++	struct strbuf *err,
      +	struct string_list *changes)
      +{
      +	static const char *msg = "updating change";
     -+	struct metacommit_data resolved_metacommit;
     ++	struct metacommit_data resolved_metacommit = METACOMMIT_DATA_INIT;
      +	struct object_id commit_target;
      +	struct ref_transaction *transaction = NULL;
      +	struct change_head *overridden_head;
      +	const struct object_id *old_head;
      +
     -+	int i;
     ++	size_t i;
      +	int ret = 0;
      +	int force = (options & UPDATE_OPTION_FORCE);
      +
     -+	init_metacommit_data(&resolved_metacommit);
     -+
      +	resolve_metacommit(repo, chtable, metacommit, &resolved_metacommit, changes,
      +		(options & UPDATE_OPTION_NOAPPEND) == 0);
      +
      +	if (override_change) {
      +		string_list_clear(changes, 0);
      +		overridden_head = get_change_head(chtable, override_change);
     -+		if (!overridden_head) {
     ++		if (overridden_head) {
      +			/* This is an existing change */
      +			old_head = &overridden_head->head;
      +			if (!force) {
     @@ metacommit.c (new)
      +			/* ...then this is a newly-created change */
      +			old_head = null_oid();
      +
     -+		/* The expected "current" head of the change is stored in the util
     -+		 * pointer. */
     -+		string_list_append(changes, override_change)->util = (void*)old_head;
     ++		/*
     ++		 * The expected "current" head of the change is stored in the
     ++		 * util pointer. Cast required because old_head is const*
     ++		 */
     ++		string_list_append(changes, override_change)->util = (void *)old_head;
      +	}
      +
      +	if (is_nontrivial_metacommit(&resolved_metacommit)) {
     @@ metacommit.c (new)
      +			ret = -1;
      +			goto cleanup;
      +		}
     -+	} else
     -+		/**
     ++	} else {
     ++		/*
      +		 * If the metacommit would only contain a content commit, point to the
      +		 * commit itself rather than creating a trivial metacommit.
      +		 */
      +		oidcpy(&commit_target, &(resolved_metacommit.content));
     ++	}
      +
     -+	/**
     ++	/*
      +	 * If a change already exists with this target and we're not forcing an
      +	 * update to some specific override_change && change, there's nothing to do.
      +	 */
     @@ metacommit.c (new)
      +		for (i = 0; i < changes->nr; i++) {
      +			struct string_list_item *it = &changes->items[i];
      +
     -+			/**
     ++			/*
      +			 * The expected current head of the change is stored in the util pointer.
      +			 * It is null if the change should be newly-created.
      +			 */
     @@ metacommit.c (new)
      +	return ret;
      +}
      +
     -+/**
     -+ * Should be invoked after a command that has "modify" semantics - commands that
     -+ * create a new commit based on an old commit and treat the new one as a
     -+ * replacement for the old one. This method records the replacement in the
     -+ * change graph, such that a future evolve operation will rebase children of
     -+ * the old commit onto the new commit.
     -+ */
     ++int record_metacommit(
     ++	struct repository *repo,
     ++	const struct metacommit_data *metacommit,
     ++	const char *override_change,
     ++	int options,
     ++	struct strbuf *err,
     ++	struct string_list *changes)
     ++{
     ++		struct change_table chtable;
     ++		int result;
     ++
     ++		change_table_init(&chtable);
     ++		change_table_add_all_visible(&chtable, repo);
     ++
     ++		result = record_metacommit_withresult(
     ++			repo,
     ++			&chtable,
     ++			metacommit,
     ++			override_change,
     ++			options,
     ++			err,
     ++			changes);
     ++
     ++		change_table_clear(&chtable);
     ++		return result;
     ++}
     ++
      +void modify_change(
      +	struct repository *repo,
      +	const struct object_id *old_commit,
      +	const struct object_id *new_commit,
      +	struct strbuf *err)
      +{
     -+	struct metacommit_data metacommit;
     ++	struct string_list changes = STRING_LIST_INIT_DUP;
     ++	struct metacommit_data metacommit = METACOMMIT_DATA_INIT;
      +
     -+	init_metacommit_data(&metacommit);
      +	oidcpy(&(metacommit.content), new_commit);
      +	oid_array_append(&(metacommit.replace), old_commit);
      +
     -+	record_metacommit(repo, &metacommit, NULL, 0, err);
     ++	record_metacommit(repo, &metacommit, NULL, 0, err, &changes);
      +
      +	clear_metacommit_data(&metacommit);
     ++	string_list_clear(&changes, 0);
      +}
      
       ## metacommit.h (new) ##
     @@ metacommit.h (new)
      +#include "repository.h"
      +#include "string-list.h"
      +
     -+
     -+struct change_table;
     -+
      +/* If specified, non-fast-forward changes are permitted. */
      +#define UPDATE_OPTION_FORCE     0x0001
      +/**
     @@ metacommit.h (new)
      +	int abandoned;
      +};
      +
     -+extern void init_metacommit_data(struct metacommit_data *state);
     ++#define METACOMMIT_DATA_INIT { 0 }
      +
      +extern void clear_metacommit_data(struct metacommit_data *state);
      +
     -+extern int record_metacommit(struct repository *repo,
     -+	const struct metacommit_data *metacommit,
     -+	const char* override_change, int options, struct strbuf *err);
     -+
     -+extern int record_metacommit_withresult(
     ++/**
     ++ * Records the relationships described by the given metacommit in the
     ++ * repository.
     ++ *
     ++ * If override_change is NULL (the default), an attempt will be made
     ++ * to append to existing changes wherever possible instead of creating new ones.
     ++ * If override_change is non-null, only the given change ref will be updated.
     ++ *
     ++ * options is a bitwise combination of the UPDATE_OPTION_* flags.
     ++ */
     ++int record_metacommit(
      +	struct repository *repo,
     -+	struct change_table *chtable,
      +	const struct metacommit_data *metacommit,
     -+	const char *override_change,
     ++	const char* override_change,
      +	int options,
      +	struct strbuf *err,
      +	struct string_list *changes);
      +
     -+extern void modify_change(struct repository *repo,
     -+	const struct object_id *old_commit, const struct object_id *new_commit,
     ++/**
     ++ * Should be invoked after a command that has "modify" semantics - commands that
     ++ * create a new commit based on an old commit and treat the new one as a
     ++ * replacement for the old one. This method records the replacement in the
     ++ * change graph, such that a future evolve operation will rebase children of
     ++ * the old commit onto the new commit.
     ++ */
     ++void modify_change(
     ++	struct repository *repo,
     ++	const struct object_id *old_commit,
     ++	const struct object_id *new_commit,
      +	struct strbuf *err);
      +
     -+extern int write_metacommit(struct repository *repo, struct metacommit_data *state,
     ++/**
     ++ * Creates a new metacommit object with the given content. Writes the object
     ++ * id of the newly-created commit to result.
     ++ */
     ++int write_metacommit(
     ++	struct repository *repo,
     ++	struct metacommit_data *state,
      +	struct object_id *result);
      +
      +#endif
  7:  91402834184 !  7:  f7a90700e0e evolve: implement the git change command
     @@ builtin/change.c (new)
      +#include "ref-filter.h"
      +#include "parse-options.h"
      +#include "metacommit.h"
     -+#include "change-table.h"
      +#include "config.h"
      +
      +static const char * const builtin_change_usage[] = {
     -+	N_("git change update [--force] [--replace <treeish>...] [--origin <treesih>...] [--content <newtreeish>]"),
     ++	N_("git change list [<pattern>...]"),
     ++	N_("git change update [--force] [--replace <treeish>...] "
     ++	   "[--origin <treeish>...] [--content <newtreeish>]"),
     ++	NULL
     ++};
     ++
     ++static const char * const builtin_list_usage[] = {
     ++	N_("git change list [<pattern>...]"),
      +	NULL
      +};
      +
      +static const char * const builtin_update_usage[] = {
     -+	N_("git change update [--force] [--replace <treeish>...] [--origin <treesih>...] [--content <newtreeish>]"),
     ++	N_("git change update [--force] [--replace <treeish>...] "
     ++	"[--origin <treeish>...] [--content <newtreeish>]"),
      +	NULL
      +};
      +
     ++static int change_list(int argc, const char **argv, const char* prefix)
     ++{
     ++	struct option options[] = {
     ++		OPT_END()
     ++	};
     ++	struct ref_filter filter = { 0 };
     ++	struct ref_sorting *sorting;
     ++	struct string_list sorting_options = STRING_LIST_INIT_DUP;
     ++	struct ref_format format = REF_FORMAT_INIT;
     ++	struct ref_array array = { 0 };
     ++	size_t i;
     ++
     ++	argc = parse_options(argc, argv, prefix, options, builtin_list_usage, 0);
     ++
     ++	setup_ref_filter_porcelain_msg();
     ++
     ++	filter.kind = FILTER_REFS_CHANGES;
     ++	filter.name_patterns = argv;
     ++
     ++	filter_refs(&array, &filter, FILTER_REFS_CHANGES);
     ++
     ++	/* TODO: This causes a crash. It sets one of the atom_value handlers to
     ++	 * something invalid, which causes a crash later when we call
     ++	 * show_ref_array_item. Figure out why this happens and put back the sorting.
     ++	 *
     ++	 * sorting = ref_sorting_options(&sorting_options);
     ++	 * ref_array_sort(sorting, &array); */
     ++
     ++	if (!format.format)
     ++		format.format = "%(refname:lstrip=1)";
     ++
     ++	if (verify_ref_format(&format))
     ++		die(_("unable to parse format string"));
     ++
     ++	sorting = ref_sorting_options(&sorting_options);
     ++	ref_array_sort(sorting, &array);
     ++
     ++
     ++	for (i = 0; i < array.nr; i++) {
     ++		struct strbuf output = STRBUF_INIT;
     ++		struct strbuf err = STRBUF_INIT;
     ++		if (format_ref_array_item(array.items[i], &format, &output, &err))
     ++			die("%s", err.buf);
     ++		fwrite(output.buf, 1, output.len, stdout);
     ++		putchar('\n');
     ++
     ++		strbuf_release(&err);
     ++		strbuf_release(&output);
     ++	}
     ++
     ++	ref_array_clear(&array);
     ++	ref_sorting_release(sorting);
     ++
     ++	return 0;
     ++}
     ++
      +struct update_state {
      +	int options;
      +	const char* change;
     @@ builtin/change.c (new)
      +	struct string_list origin;
      +};
      +
     -+static void init_update_state(struct update_state *state)
     -+{
     -+	memset(state, 0, sizeof(*state));
     -+	state->content = "HEAD";
     -+	string_list_init_nodup(&state->replace);
     -+	string_list_init_nodup(&state->origin);
     ++#define UPDATE_STATE_INIT { \
     ++	.content = "HEAD", \
     ++	.replace = STRING_LIST_INIT_NODUP, \
     ++	.origin = STRING_LIST_INIT_NODUP \
      +}
      +
      +static void clear_update_state(struct update_state *state)
     @@ builtin/change.c (new)
      +{
      +	struct commit *commit;
      +	if (get_oid_committish(committish, result))
     -+		die(_("Failed to resolve '%s' as a valid revision."), committish);
     ++		die(_("failed to resolve '%s' as a valid revision."), committish);
      +	commit = lookup_commit_reference(the_repository, result);
      +	if (!commit)
     -+		die(_("Could not parse object '%s'."), committish);
     ++		die(_("could not parse object '%s'."), committish);
      +	oidcpy(result, &commit->object.oid);
      +	return 0;
      +}
     @@ builtin/change.c (new)
      +static void resolve_commit_list(const struct string_list *commitsish_list,
      +	struct oid_array* result)
      +{
     -+	int i;
     -+	for (i = 0; i < commitsish_list->nr; i++) {
     -+		struct string_list_item *item = &commitsish_list->items[i];
     ++	struct string_list_item *item;
     ++
     ++	for_each_string_list_item(item, commitsish_list) {
      +		struct object_id next;
      +		resolve_commit(item->string, &next);
      +		oid_array_append(result, &next);
     @@ builtin/change.c (new)
      +	const struct update_state *state,
      +	struct strbuf *err)
      +{
     -+	struct metacommit_data metacommit;
     -+	struct change_table chtable;
     -+	struct string_list changes;
     ++	struct metacommit_data metacommit = METACOMMIT_DATA_INIT;
     ++	struct string_list changes = STRING_LIST_INIT_DUP;
      +	int ret;
     -+	int i;
     -+
     -+	change_table_init(&chtable);
     -+	change_table_add_all_visible(&chtable, repo);
     -+	string_list_init_dup(&changes);
     -+
     -+	init_metacommit_data(&metacommit);
     ++	struct string_list_item *item;
      +
      +	get_metacommit_from_command_line(state, &metacommit);
      +
     -+	ret = record_metacommit_withresult(repo, &chtable, &metacommit,
     -+		state->change, state->options, err, &changes);
     ++	ret = record_metacommit(
     ++		repo,
     ++		&metacommit,
     ++		state->change,
     ++		state->options,
     ++		err,
     ++		&changes);
      +
     -+	for (i = 0; i < changes.nr; i++) {
     -+		struct string_list_item *it = &changes.items[i];
     ++	for_each_string_list_item(item, &changes) {
      +
     -+		const char* name = lstrip_ref_components(it->string, 1);
     ++		const char* name = lstrip_ref_components(item->string, 1);
      +		if (!name)
     -+			die(_("Failed to remove `refs/` from %s"), it->string);
     ++			die(_("failed to remove `refs/` from %s"), item->string);
      +
     -+		if (it->util)
     -+			fprintf(stdout, N_("Updated change %s\n"), name);
     ++		if (item->util)
     ++			fprintf(stdout, _("Updated change %s"), name);
      +		else
     -+			fprintf(stdout, N_("Created change %s\n"), name);
     ++			fprintf(stdout, _("Created change %s"), name);
     ++		putchar('\n');
      +	}
      +
      +	string_list_clear(&changes, 0);
     -+	change_table_clear(&chtable);
      +	clear_metacommit_data(&metacommit);
      +
      +	return ret;
     @@ builtin/change.c (new)
      +static int change_update(int argc, const char **argv, const char* prefix)
      +{
      +	int result;
     -+	int force = 0;
     -+	int newchange = 0;
      +	struct strbuf err = STRBUF_INIT;
     -+	struct update_state state;
     ++	struct update_state state = UPDATE_STATE_INIT;
      +	struct option options[] = {
      +		{ OPTION_CALLBACK, 'r', "replace", &state, N_("commit"),
      +			N_("marks the given commit as being obsolete"),
     @@ builtin/change.c (new)
      +		{ OPTION_CALLBACK, 'o', "origin", &state, N_("commit"),
      +			N_("marks the given commit as being the origin of this commit"),
      +			0, update_option_parse_origin },
     -+		OPT_BOOL('F', "force", &force,
     -+			N_("overwrite an existing change of the same name")),
     ++
      +		OPT_STRING('c', "content", &state.content, N_("commit"),
      +				 N_("identifies the new content commit for the change")),
      +		OPT_STRING('g', "change", &state.change, N_("commit"),
      +				 N_("name of the change to update")),
     -+		OPT_BOOL('n', "new", &newchange,
     -+			N_("create a new change - do not append to any existing change")),
     ++		OPT_SET_INT_F('n', "new", &state.options,
     ++			      N_("create a new change - do not append to any existing change"),
     ++			      UPDATE_OPTION_NOAPPEND, 0),
     ++		OPT_SET_INT_F('F', "force", &state.options,
     ++			      N_("overwrite an existing change of the same name"),
     ++			      UPDATE_OPTION_FORCE, 0),
      +		OPT_END()
      +	};
      +
     -+	init_update_state(&state);
     -+
      +	argc = parse_options(argc, argv, prefix, options, builtin_update_usage, 0);
     -+
     -+	if (force) state.options |= UPDATE_OPTION_FORCE;
     -+	if (newchange) state.options |= UPDATE_OPTION_NOAPPEND;
     -+
      +	result = perform_update(the_repository, &state, &err);
      +
      +	if (result < 0) {
     @@ builtin/change.c (new)
      +
      +int cmd_change(int argc, const char **argv, const char *prefix)
      +{
     ++	parse_opt_subcommand_fn *fn = NULL;
      +	/* No options permitted before subcommand currently */
      +	struct option options[] = {
     ++		OPT_SUBCOMMAND("list", &fn, change_list),
     ++		OPT_SUBCOMMAND("update", &fn, change_update),
      +		OPT_END()
      +	};
     -+	int result = 1;
      +
      +	argc = parse_options(argc, argv, prefix, options, builtin_change_usage,
     -+		PARSE_OPT_STOP_AT_NON_OPTION);
     -+
     -+	if (argc < 1)
     -+		usage_with_options(builtin_change_usage, options);
     -+	else if (!strcmp(argv[0], "update"))
     -+		result = change_update(argc, argv, prefix);
     -+	else {
     -+		error(_("Unknown subcommand: %s"), argv[0]);
     -+		usage_with_options(builtin_change_usage, options);
     ++		PARSE_OPT_SUBCOMMAND_OPTIONAL);
     ++
     ++	if (!fn) {
     ++		if (argc) {
     ++			error(_("unknown subcommand: `%s'"), argv[0]);
     ++			usage_with_options(builtin_change_usage, options);
     ++		}
     ++		fn = change_list;
      +	}
      +
     -+	return result ? 1 : 0;
     ++	return !!fn(argc, argv, prefix);
      +}
      
       ## git.c ##
  9:  d087d467e3f !  8:  a0669fa63a1 evolve: add delete command
     @@ Commit message
      
       ## builtin/change.c ##
      @@
     + #include "parse-options.h"
       #include "metacommit.h"
     - #include "change-table.h"
       #include "config.h"
      +#include "refs.h"
       
       static const char * const builtin_change_usage[] = {
       	N_("git change list [<pattern>...]"),
     --	N_("git change update [--force] [--replace <treeish>...] [--origin <treesih>...] [--content <newtreeish>]"),
     -+	N_("git change update [--force] [--replace <treeish>...] [--origin <treeish>...] [--content <newtreeish>]"),
     + 	N_("git change update [--force] [--replace <treeish>...] "
     + 	   "[--origin <treeish>...] [--content <newtreeish>]"),
      +	N_("git change delete <change-name>..."),
       	NULL
       };
       
     -@@ builtin/change.c: static const char * const builtin_list_usage[] = {
     +@@ builtin/change.c: static const char * const builtin_update_usage[] = {
     + 	NULL
       };
       
     - static const char * const builtin_update_usage[] = {
     --	N_("git change update [--force] [--replace <treeish>...] [--origin <treesih>...] [--content <newtreeish>]"),
     -+	N_("git change update [--force] [--replace <treeish>...] [--origin <treeish>...] [--content <newtreeish>]"),
     ++static const char * const builtin_delete_usage[] = {
     ++	N_("git change delete <change-name>..."),
      +	NULL
      +};
      +
     -+static const char * const builtin_delete_usage[] = {
     -+	N_("git change delete <change-name>..."),
     - 	NULL
     - };
     - 
     + static int change_list(int argc, const char **argv, const char* prefix)
     + {
     + 	struct option options[] = {
      @@ builtin/change.c: static int change_update(int argc, const char **argv, const char* prefix)
       	return result;
       }
     @@ builtin/change.c: static int change_update(int argc, const char **argv, const ch
      +
       int cmd_change(int argc, const char **argv, const char *prefix)
       {
     - 	/* No options permitted before subcommand currently */
     + 	parse_opt_subcommand_fn *fn = NULL;
      @@ builtin/change.c: int cmd_change(int argc, const char **argv, const char *prefix)
     - 		result = change_list(argc, argv, prefix);
     - 	else if (!strcmp(argv[0], "update"))
     - 		result = change_update(argc, argv, prefix);
     -+	else if (!strcmp(argv[0], "delete"))
     -+		result = change_delete(argc, argv, prefix);
     - 	else {
     - 		error(_("Unknown subcommand: %s"), argv[0]);
     - 		usage_with_options(builtin_change_usage, options);
     + 	struct option options[] = {
     + 		OPT_SUBCOMMAND("list", &fn, change_list),
     + 		OPT_SUBCOMMAND("update", &fn, change_update),
     ++		OPT_SUBCOMMAND("delete", &fn, change_delete),
     + 		OPT_END()
     + 	};
     + 
 10:  811d516e5d2 =  9:  e67ff668fff evolve: add documentation for `git change`
  8:  b83a79beeb4 ! 10:  37042b58cda evolve: add the git change list command
     @@
       ## Metadata ##
     -Author: Stefan Xenos <sxenos@google.com>
     +Author: Chris Poucet <poucet@google.com>
      
       ## Commit message ##
     -    evolve: add the git change list command
     +    evolve: add tests for the git-change command
      
     -    This command lists the ongoing changes from the refs/metas
     -    namespace.
     -
     -    Signed-off-by: Stefan Xenos <sxenos@google.com>
     +    Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
          Signed-off-by: Chris Poucet <poucet@google.com>
      
     - ## builtin/change.c ##
     + ## t/t9990-changes.sh (new) ##
      @@
     - #include "config.h"
     - 
     - static const char * const builtin_change_usage[] = {
     -+	N_("git change list [<pattern>...]"),
     - 	N_("git change update [--force] [--replace <treeish>...] [--origin <treesih>...] [--content <newtreeish>]"),
     - 	NULL
     - };
     - 
     -+static const char * const builtin_list_usage[] = {
     -+	N_("git change list [<pattern>...]"),
     -+	NULL
     -+};
     ++#!/bin/sh
      +
     - static const char * const builtin_update_usage[] = {
     - 	N_("git change update [--force] [--replace <treeish>...] [--origin <treesih>...] [--content <newtreeish>]"),
     - 	NULL
     - };
     - 
     -+static int change_list(int argc, const char **argv, const char* prefix)
     -+{
     -+	struct option options[] = {
     -+		OPT_END()
     -+	};
     -+	struct ref_filter filter;
     -+	/* TODO: See below
     -+	struct ref_sorting *sorting;
     -+	struct string_list sorting_options = STRING_LIST_INIT_DUP; */
     -+	struct ref_format format = REF_FORMAT_INIT;
     -+	struct ref_array array;
     -+	int i;
     ++test_description='git change - low level meta-commit management'
      +
     -+	argc = parse_options(argc, argv, prefix, options, builtin_list_usage, 0);
     ++. ./test-lib.sh
      +
     -+	setup_ref_filter_porcelain_msg();
     ++. "$TEST_DIRECTORY"/lib-rebase.sh
      +
     -+	memset(&filter, 0, sizeof(filter));
     -+	memset(&array, 0, sizeof(array));
     ++test_expect_success 'setup commits and meta-commits' '
     ++       for c in one two three
     ++       do
     ++               test_commit $c &&
     ++               git change update --content $c >actual 2>err &&
     ++               echo "Created change metas/$c" >expect &&
     ++               test_cmp expect actual &&
     ++               test_must_be_empty err &&
     ++               test_cmp_rev refs/metas/$c $c || return 1
     ++       done
     ++'
      +
     -+	filter.kind = FILTER_REFS_CHANGES;
     -+	filter.name_patterns = argv;
     ++# Check a meta-commit has the correct parents Call with the object
     ++# name of the meta-commit followed by pairs of type and parent
     ++check_meta_commit () {
     ++       name=$1
     ++       shift
     ++       while test $# -gt 0
     ++       do
     ++               printf '%s %s\n' $1 $(git rev-parse --verify $2)
     ++               shift
     ++               shift
     ++       done | sort >expect
     ++       git cat-file commit $name >metacommit &&
     ++       # commit body should consist of parent-type
     ++           types="$(sed -n '/^$/ {
     ++                       :loop
     ++                       n
     ++                       s/^parent-type //
     ++                       p
     ++                       b loop
     ++                   }' metacommit)" &&
     ++       while read key value
     ++       do
     ++               # TODO: don't sort the first parent
     ++               if test "$key" = "parent"
     ++               then
     ++                       type="${types%% *}"
     ++                       test -n "$type" || return 1
     ++                       printf '%s %s\n' $type $value
     ++                       types="${types#?}"
     ++                       types="${types# }"
     ++               elif test "$key" = "tree"
     ++               then
     ++                       test_cmp_rev "$value" $EMPTY_TREE || return 1
     ++               elif test -z "$key"
     ++               then
     ++                       # only parse commit headers
     ++                       break
     ++               fi
     ++       done <metacommit >actual-unsorted &&
     ++       test -z "$types" &&
     ++       sort >actual <actual-unsorted &&
     ++       test_cmp expect actual
     ++}
      +
     -+	filter_refs(&array, &filter, FILTER_REFS_CHANGES);
     ++test_expect_success 'update meta-commits after rebase' '
     ++       (
     ++               set_fake_editor &&
     ++               FAKE_AMEND=edited &&
     ++               FAKE_LINES="reword 1 pick 2 fixup 3" &&
     ++               export FAKE_AMEND FAKE_LINES &&
     ++               git rebase -i --root
     ++       ) &&
      +
     -+	/* TODO: This causes a crash. It sets one of the atom_value handlers to
     -+	 * something invalid, which causes a crash later when we call
     -+	 * show_ref_array_item. Figure out why this happens and put back the sorting.
     -+	 *
     -+	 * sorting = ref_sorting_options(&sorting_options);
     -+	 * ref_array_sort(sorting, &array); */
     ++       # update meta-commits
     ++       git change update --replace tags/one --content HEAD~1 >out 2>err &&
     ++       echo "Updated change metas/one" >expect &&
     ++       test_cmp expect out &&
     ++       test_must_be_empty err &&
     ++       git change update --replace tags/two --content HEAD@{2} &&
     ++       oid=$(git rev-parse --verify metas/two) &&
     ++       git change update --replace HEAD@{2} --replace tags/three \
     ++               --content HEAD &&
      +
     -+	if (!format.format)
     -+		format.format = "%(refname:lstrip=1)";
     ++       # check meta-commits
     ++       check_meta_commit metas/one c HEAD~1 r tags/one &&
     ++       check_meta_commit $oid c HEAD@{2} r tags/two &&
     ++       # NB this checks that "git change update" uses the meta-commit ($oid)
     ++       #    corresponding to the replaces commit (HEAD@2 above) given on the
     ++       #    commandline.
     ++       check_meta_commit metas/two c HEAD r $oid r tags/three &&
     ++       check_meta_commit metas/three c HEAD r $oid r tags/three
     ++'
      +
     -+	if (verify_ref_format(&format))
     -+		die(_("unable to parse format string"));
     ++reset_meta_commits () {
     ++    for c in one two three
     ++    do
     ++       echo "update refs/metas/$c refs/tags/$c^0"
     ++    done | git update-ref --stdin
     ++}
      +
     -+	for (i = 0; i < array.nr; i++) {
     -+		struct strbuf output = STRBUF_INIT;
     -+		struct strbuf err = STRBUF_INIT;
     -+		if (format_ref_array_item(array.items[i], &format, &output, &err))
     -+			die("%s", err.buf);
     -+		fwrite(output.buf, 1, output.len, stdout);
     -+		putchar('\n');
     ++test_expect_success 'override change name' '
     ++       # TODO: builtin/change.c expects --change to be the full refname,
     ++       #       ideally it would prepend refs/metas to the string given by the
     ++       #       user.
     ++       git change update --change refs/metas/another-one --content one &&
     ++       test_cmp_rev metas/another-one one
     ++'
      +
     -+		strbuf_release(&err);
     -+		strbuf_release(&output);
     -+	}
     ++test_expect_success 'non-fast forward meta-commit update refused' '
     ++       test_must_fail git change update --change refs/metas/one --content two \
     ++               >out 2>err &&
     ++       echo "error: non-fast-forward update to ${SQ}refs/metas/one${SQ}" \
     ++               >expect &&
     ++       test_cmp expect err &&
     ++       test_must_be_empty out
     ++'
      +
     -+	ref_array_clear(&array);
     -+	/* TODO: see above
     -+	ref_sorting_release(sorting); */
     ++test_expect_success 'forced non-fast forward update succeeds' '
     ++       git change update --change refs/metas/one --content two --force \
     ++               >out 2>err &&
     ++       echo "Updated change metas/one" >expect &&
     ++       test_cmp expect out &&
     ++       test_must_be_empty err
     ++'
      +
     -+	return 0;
     -+}
     ++test_expect_success 'list changes' '
     ++       cat >expect <<-\EOF &&
     ++metas/another-one
     ++metas/one
     ++metas/three
     ++metas/two
     ++EOF
     ++       git change list >actual &&
     ++       test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'delete change' '
     ++       git change delete metas/one &&
     ++       cat >expect <<-\EOF &&
     ++metas/another-one
     ++metas/three
     ++metas/two
     ++EOF
     ++       git change list >actual &&
     ++       test_cmp expect actual
     ++'
      +
     - struct update_state {
     - 	int options;
     - 	const char* change;
     -@@ builtin/change.c: int cmd_change(int argc, const char **argv, const char *prefix)
     - 
     - 	if (argc < 1)
     - 		usage_with_options(builtin_change_usage, options);
     -+	else if (!strcmp(argv[0], "list"))
     -+		result = change_list(argc, argv, prefix);
     - 	else if (!strcmp(argv[0], "update"))
     - 		result = change_update(argc, argv, prefix);
     - 	else {
     ++test_done

-- 
gitgitgadget
