Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421ADC54EBD
	for <git@archiver.kernel.org>; Sun,  8 Jan 2023 19:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjAHTDX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Jan 2023 14:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjAHTDV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2023 14:03:21 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF68DF2F
        for <git@vger.kernel.org>; Sun,  8 Jan 2023 11:03:16 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id bn26so6172776wrb.0
        for <git@vger.kernel.org>; Sun, 08 Jan 2023 11:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/vnWuHPBIoweKaZPZrkfglbeqQPB8/YNAUJVlG195s=;
        b=AZtzBgbdJmg4v31LPSDR5xxLCSL9STeTy96W2I0SHxPi0FCoQ1Hsp32fJNEDBlN0Ps
         6bihtBZXxyLkNmWiABd1QUFYjfuO1GQoE0yUSfvxpMARMVgmBt2iD1RhMC5l5FKt4n9O
         fbNYfRU0yObmi9+g7LlFS33BhAJbI58uSmxF2VugcP/+t+SSwFfKmb52il0w+1ffI7cz
         +c5fHp7U5nfQClrhcL3QYw4jI2ICASiQcA8hiObr0Te/apmONBfkFTE9OxFLuLAUHuGT
         T+ilk8usWzWPXvGqwFr6gKrOIhk/MV3NW5Ow+bpYo+pXHraecFM3hYaPao3NWFd5PBNp
         m+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/vnWuHPBIoweKaZPZrkfglbeqQPB8/YNAUJVlG195s=;
        b=bcLOY5kMrOnWYJ5cuOWe/p/bmxWyZvUgPe7SVPmVcP7mIp+MZ+4XaNTwnSYm2vhbxu
         Z30bfYkT8DKbz74gteSybEDufdY7qRJ7bxQExcda+XkO8UoEL8rnlK1LLb/wNrYFUqaL
         t/zgUadmUv200l8yfUzOllClmdGJJ/6jYRqKUJWbYgPUtNPB7isayhrI9UzwRlEbqXJw
         P/YZOoxN/LnJsxJYyYKi2vsIdHQmpTU6bGznn9ftBF7F20Qys1NhqjPhDeV4yA7rsozw
         TAA94Pb7GM7jNwp/imrzrftvH4qOStDHrBw4M8GWxl09qvzh5VxvFbL0bvGIsOpXWYoo
         r2PQ==
X-Gm-Message-State: AFqh2kqsYYXMLoNzTL8Xa6v3iy6170nz/vSW4xbvJr/lyv+xh1yxWmUz
        5RalmU7ohsDeSYLJBWrq47KE93sYfDk=
X-Google-Smtp-Source: AMrXdXuFsIRH4eRkAwdiqvHfVLkZiAZKtMgiK3O8+Ip6J1tylq9DQF2Hyefp+y10siALZ5/OvCwi7Q==
X-Received: by 2002:a5d:6244:0:b0:2bb:9106:d10 with SMTP id m4-20020a5d6244000000b002bb91060d10mr3162907wrv.10.1673204593544;
        Sun, 08 Jan 2023 11:03:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g8-20020a5d5408000000b0027973315213sm6659999wrv.89.2023.01.08.11.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 11:03:13 -0800 (PST)
Message-Id: <pull.1399.v15.git.git.1673204590945.gitgitgadget@gmail.com>
In-Reply-To: <pull.1399.v14.git.git.1673189530588.gitgitgadget@gmail.com>
References: <pull.1399.v14.git.git.1673189530588.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 08 Jan 2023 19:03:09 +0000
Subject: [PATCH v15] git: change variable types to match what is assigned to
 them
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Seija Kijin <doremylover123@gmail.com>

There are many places where "int len = strlen(foo);" is written,
just for len to be passed as a parameter of size_t.

This causes truncation and then expansion
back from int to size_t. This is poor logic.

As of right now, the current set of changes
is too large to keep going, so future changes
should be in future patches. However, the codebase
works perfectly even if only these changes
were ever to be accepted. I just do not want
to change too much at a time.

Signed-off-by: Seija Kijin <doremylover123@gmail.com
---
    git: change variable types to match what is assigned to them
    
    There are many places where "int len = strlen(foo);" is written, just
    for len to be passed as a parameter of size_t. This causes truncation
    and then expansion back from int to size_t. Not to mention this is poor
    logic and needless truncations can add extra unneeded instructions.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1399%2FAtariDreams%2Ffix-type-v15
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1399/AtariDreams/fix-type-v15
Pull-Request: https://github.com/git/git/pull/1399

Range-diff vs v14:

 1:  2fb578b5668 ! 1:  0fd1aa406a0 git: change variable types to match what is assigned to them
     @@ Commit message
          This causes truncation and then expansion
          back from int to size_t. This is poor logic.
      
     -    Signed-off-by: Seija Kijin <doremylover123@gmail.com>
     +    As of right now, the current set of changes
     +    is too large to keep going, so future changes
     +    should be in future patches. However, the codebase
     +    works perfectly even if only these changes
     +    were ever to be accepted. I just do not want
     +    to change too much at a time.
     +
     +    Signed-off-by: Seija Kijin <doremylover123@gmail.com
      
       ## add-interactive.c ##
     +@@ add-interactive.c: static ssize_t find_unique(const char *string, struct prefix_item_list *list)
     + struct list_options {
     + 	int columns;
     + 	const char *header;
     +-	void (*print_item)(int i, int selected, struct string_list_item *item,
     ++	void (*print_item)(size_t i, int selected,
     ++			   struct string_list_item *item,
     + 			   void *print_item_data);
     + 	void *print_item_data;
     + };
     +@@ add-interactive.c: struct list_options {
     + static void list(struct add_i_state *s, struct string_list *list, int *selected,
     + 		 struct list_options *opts)
     + {
     +-	int i, last_lf = 0;
     ++	size_t i;
     ++	int last_lf = 0;
     + 
     + 	if (!list->nr)
     + 		return;
      @@ add-interactive.c: static void collect_changes_cb(struct diff_queue_struct *q,
       
       	for (i = 0; i < stat.nr; i++) {
     @@ add-interactive.c: static void collect_changes_cb(struct diff_queue_struct *q,
       		struct pathname_entry *entry;
       		struct file_item *file_item;
       		struct adddel *adddel, *other_adddel;
     +@@ add-interactive.c: static int get_modified_files(struct repository *r,
     + 	int is_initial = !resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
     + 					     &head_oid, NULL);
     + 	struct collection_status s = { 0 };
     +-	int i;
     ++	unsigned int i;
     + 
     + 	discard_index(r->index);
     + 	if (repo_read_index_preload(r, ps, 0) < 0)
     +@@ add-interactive.c: struct print_file_item_data {
     + 	unsigned only_names:1;
     + };
     + 
     +-static void print_file_item(int i, int selected, struct string_list_item *item,
     ++static void print_file_item(size_t i, int selected,
     ++			    struct string_list_item *item,
     + 			    void *print_file_item_data)
     + {
     + 	struct file_item *c = item->util;
     + 	struct print_file_item_data *d = print_file_item_data;
     + 	const char *highlighted = NULL;
     ++	unsigned int e = (unsigned int)i + 1;
     + 
     + 	strbuf_reset(&d->index);
     + 	strbuf_reset(&d->worktree);
     +@@ add-interactive.c: static void print_file_item(int i, int selected, struct string_list_item *item,
     + 	}
     + 
     + 	if (d->only_names) {
     +-		printf("%c%2d: %s", selected ? '*' : ' ', i + 1,
     ++		printf("%c%2u: %s", selected ? '*' : ' ', e,
     + 		       highlighted ? highlighted : item->string);
     + 		return;
     + 	}
     +@@ add-interactive.c: static void print_file_item(int i, int selected, struct string_list_item *item,
     + 	strbuf_addf(&d->buf, d->modified_fmt, d->index.buf, d->worktree.buf,
     + 		    highlighted ? highlighted : item->string);
     + 
     +-	printf("%c%2d: %s", selected ? '*' : ' ', i + 1, d->buf.buf);
     ++	printf("%c%2u: %s", selected ? '*' : ' ', e, d->buf.buf);
     + }
     + 
     + static int run_status(struct add_i_state *s, const struct pathspec *ps,
     +@@ add-interactive.c: struct print_command_item_data {
     + 	const char *color, *reset;
     + };
     + 
     +-static void print_command_item(int i, int selected,
     ++static void print_command_item(size_t i, int selected,
     + 			       struct string_list_item *item,
     + 			       void *print_command_item_data)
     + {
     ++	unsigned int e = (unsigned int)(i + 1);
     + 	struct print_command_item_data *d = print_command_item_data;
     + 	struct command_item *util = item->util;
     + 
     + 	if (!util->prefix_length ||
     + 	    !is_valid_prefix(item->string, util->prefix_length))
     +-		printf(" %2d: %s", i + 1, item->string);
     ++		printf(" %2u: %s", e, item->string);
     + 	else
     +-		printf(" %2d: %s%.*s%s%s", i + 1,
     +-		       d->color, (int)util->prefix_length, item->string,
     +-		       d->reset, item->string + util->prefix_length);
     ++		printf(" %2u: %s%.*s%s%s", e, d->color,
     ++		       (int)util->prefix_length, item->string, d->reset,
     ++		       item->string + util->prefix_length);
     + }
     + 
     + static void command_prompt_help(struct add_i_state *s)
     +
     + ## add-patch.c ##
     +@@ add-patch.c: static int is_octal(const char *p, size_t len)
     + 	if (!len)
     + 		return 0;
     + 
     +-	while (len--)
     ++	do {
     + 		if (*p < '0' || *(p++) > '7')
     + 			return 0;
     ++	} while (--len);
     + 	return 1;
     + }
     + 
     +
     + ## advice.c ##
     +@@ advice.c: void advise_if_enabled(enum advice_type type, const char *advice, ...)
     + int git_default_advice_config(const char *var, const char *value)
     + {
     + 	const char *k, *slot_name;
     +-	int i;
     ++	size_t i;
     + 
     + 	if (!strcmp(var, "color.advice")) {
     + 		advice_use_color = git_config_colorbool(var, value);
      
       ## apply.c ##
      @@ apply.c: static int name_terminate(int c, int terminate)
     @@ apply.c: static int parse_range(const char *line, int len, int offset, const cha
       
       		switch (*line) {
       		case ' ': case '\n':
     +@@ apply.c: static void add_name_limit(struct apply_state *state,
     + static int use_patch(struct apply_state *state, struct patch *p)
     + {
     + 	const char *pathname = p->new_name ? p->new_name : p->old_name;
     +-	int i;
     ++	size_t i;
     + 
     + 	/* Paths outside are not touched regardless of "--include" */
     + 	if (state->prefix && *state->prefix) {
      @@ apply.c: static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
       				"Files ",
       				NULL,
     @@ apply.c: static int parse_chunk(struct apply_state *state, char *buffer, unsigne
       				if (len < size - hd &&
       				    !memcmp(binhdr[i], buffer + hd, len)) {
       					state->linenr++;
     +@@ apply.c: static void update_pre_post_images(struct image *preimage,
     + 	if (postlen
     + 	    ? postlen < new_buf - postimage->buf
     + 	    : postimage->len < new_buf - postimage->buf)
     +-		BUG("caller miscounted postlen: asked %d, orig = %d, used = %d",
     +-		    (int)postlen, (int) postimage->len, (int)(new_buf - postimage->buf));
     ++		BUG("caller miscounted postlen: asked %u, orig = %u, used = %u",
     ++		    (unsigned int)postlen, (unsigned int)postimage->len,
     ++		    (unsigned int)(new_buf - postimage->buf));
     + 
     + 	/* Fix the length of the whole thing */
     + 	postimage->len = new_buf - postimage->buf;
      
       ## apply.h ##
      @@ apply.h: int check_apply_state(struct apply_state *state, int force_apply);
     @@ archive-tar.c: static struct archiver tar_archiver = {
       
       	tar_filter_config("tar.tgz.command", internal_gzip_command, NULL);
      
     + ## archive.c ##
     +@@ archive.c: int write_archive_entries(struct archiver_args *args,
     + 	struct strbuf path_in_archive = STRBUF_INIT;
     + 	struct strbuf content = STRBUF_INIT;
     + 	struct object_id fake_oid;
     +-	int i;
     ++	size_t i;
     + 
     + 	oidcpy(&fake_oid, null_oid());
     + 
     +
     + ## attr.c ##
     +@@ attr.c: struct attr_stack {
     + 
     + static void attr_stack_free(struct attr_stack *e)
     + {
     +-	int i;
     ++	unsigned int i, j;
     + 	free(e->origin);
     + 	for (i = 0; i < e->num_matches; i++) {
     + 		struct match_attr *a = e->attrs[i];
     +-		int j;
     + 		for (j = 0; j < a->num_attr; j++) {
     + 			const char *setto = a->state[j].setto;
     + 			if (setto == ATTR__TRUE ||
     +
       ## base85.c ##
      @@ base85.c: static void prep_base85(void)
       	}
     @@ base85.c: void encode_85(char *buf, const unsigned char *data, int bytes)
       			buf[cnt] = en85[val];
       		}
      
     + ## bisect.c ##
     +@@ bisect.c: static void read_bisect_paths(struct strvec *array)
     + static char *join_oid_array_hex(struct oid_array *array, char delim)
     + {
     + 	struct strbuf joined_hexs = STRBUF_INIT;
     +-	int i;
     ++	size_t i;
     + 
     + 	for (i = 0; i < array->nr; i++) {
     + 		strbuf_addstr(&joined_hexs, oid_to_hex(array->oid + i));
     +
       ## blame.c ##
     +@@ blame.c: static void get_line_fingerprints(struct fingerprint *fingerprints,
     + 				  const char *content, const int *line_starts,
     + 				  long first_line, long line_count)
     + {
     +-	int i;
     ++	long i;
     + 	const char *linestart, *lineend;
     + 
     + 	line_starts += first_line;
     +@@ blame.c: static void split_overlap(struct blame_entry *split,
     + 			  struct blame_origin *parent)
     + {
     + 	int chunk_end_lno;
     +-	int i;
     ++	unsigned int i;
     + 	memset(split, 0, sizeof(struct blame_entry [3]));
     + 
     + 	for (i = 0; i < 3; i++) {
     +@@ blame.c: static void split_blame(struct blame_entry ***blamed,
     +  */
     + static void decref_split(struct blame_entry *split)
     + {
     +-	int i;
     ++	unsigned int i;
     + 
     + 	for (i = 0; i < 3; i++)
     + 		blame_origin_decref(split[i].suspect);
     +@@ blame.c: static void copy_split_if_better(struct blame_scoreboard *sb,
     + 				 struct blame_entry *best_so_far,
     + 				 struct blame_entry *potential)
     + {
     +-	int i;
     ++	unsigned int i;
     + 
     + 	if (!potential[1].suspect)
     + 		return;
      @@ blame.c: struct blame_list {
        * and prepare a list of entry and the best split.
        */
     @@ blame.c: static struct commit *dwim_reverse_initial(struct rev_info *revs,
       	const char *name = NULL;
       
      
     + ## block-sha1/sha1.c ##
     +@@ block-sha1/sha1.c: void blk_SHA1_Final(unsigned char hashout[20], blk_SHA_CTX *ctx)
     + {
     + 	static const unsigned char pad[64] = { 0x80 };
     + 	unsigned int padlen[2];
     +-	int i;
     ++	size_t i;
     + 
     + 	/* Pad with a binary 1 (ie 0x80), then zeroes, then length */
     + 	padlen[0] = htonl((uint32_t)(ctx->size >> 29));
     +
     + ## bloom.c ##
     +@@ bloom.c: uint32_t murmur3_seeded(uint32_t seed, const char *data, size_t len)
     + 	const uint32_t r2 = 13;
     + 	const uint32_t m = 5;
     + 	const uint32_t n = 0xe6546b64;
     +-	int i;
     ++	size_t i;
     + 	uint32_t k1 = 0;
     + 	const char *tail;
     + 
     +-	int len4 = len / sizeof(uint32_t);
     ++	size_t len4 = len / sizeof(uint32_t);
     + 
     + 	uint32_t k;
     + 	for (i = 0; i < len4; i++) {
     +@@ bloom.c: void fill_bloom_key(const char *data,
     + 		    struct bloom_key *key,
     + 		    const struct bloom_filter_settings *settings)
     + {
     +-	int i;
     ++	uint32_t i;
     + 	const uint32_t seed0 = 0x293ae76f;
     + 	const uint32_t seed1 = 0x7e646e2c;
     + 	const uint32_t hash0 = murmur3_seeded(seed0, data, len);
     +@@ bloom.c: void add_key_to_filter(const struct bloom_key *key,
     + 		       struct bloom_filter *filter,
     + 		       const struct bloom_filter_settings *settings)
     + {
     +-	int i;
     ++	uint32_t i;
     + 	uint64_t mod = filter->len * BITS_PER_WORD;
     + 
     + 	for (i = 0; i < settings->num_hashes; i++) {
     +@@ bloom.c: int bloom_filter_contains(const struct bloom_filter *filter,
     + 			  const struct bloom_key *key,
     + 			  const struct bloom_filter_settings *settings)
     + {
     +-	int i;
     ++	uint32_t i;
     + 	uint64_t mod = filter->len * BITS_PER_WORD;
     + 
     + 	if (!mod)
     +
     + ## branch.c ##
     +@@ branch.c: static struct strmap current_checked_out_branches = STRMAP_INIT;
     + 
     + static void prepare_checked_out_branches(void)
     + {
     +-	int i = 0;
     ++	size_t i = 0;
     + 	struct worktree **worktrees;
     + 
     + 	if (initialized_checked_out_branches)
     +@@ branch.c: int replace_each_worktree_head_symref(const char *oldref, const char *newref,
     + {
     + 	int ret = 0;
     + 	struct worktree **worktrees = get_worktrees();
     +-	int i;
     ++	size_t i;
     + 
     + 	for (i = 0; worktrees[i]; i++) {
     + 		struct ref_store *refs;
     +
       ## builtin/add.c ##
      @@ builtin/add.c: struct update_callback_data {
       
     @@ builtin/add.c: struct update_callback_data {
       	for (i = 0; i < the_index.cache_nr; i++) {
       		struct cache_entry *ce = the_index.cache[i];
      
     - ## builtin/merge-file.c ##
     -@@ builtin/merge-file.c: int cmd_merge_file(int argc, const char **argv, const char *prefix)
     - 	mmfile_t mmfs[3] = { 0 };
     - 	mmbuffer_t result = { 0 };
     - 	xmparam_t xmp = { 0 };
     --	int ret = 0, i = 0, to_stdout = 0;
     -+	int ret = 0, to_stdout = 0;
     -+	unsigned int i = 0;
     - 	int quiet = 0;
     - 	struct option options[] = {
     - 		OPT_BOOL('p', "stdout", &to_stdout, N_("send results to standard output")),
     + ## builtin/fast-export.c ##
     +@@ builtin/fast-export.c: static struct commit *get_commit(struct rev_cmdline_entry *e, char *full_name)
     + 
     + static void get_tags_and_duplicates(struct rev_cmdline_info *info)
     + {
     +-	int i;
     ++	unsigned int i;
     + 
     + 	for (i = 0; i < info->nr; i++) {
     + 		struct rev_cmdline_entry *e = info->rev + i;
     +@@ builtin/fast-export.c: int cmd_fast_export(int argc, const char **argv, const char *prefix)
     + 		die(_("the option '%s' requires '%s'"), "--anonymize-map", "--anonymize");
     + 
     + 	if (refspecs_list.nr) {
     +-		int i;
     ++		size_t i;
     + 
     + 		for (i = 0; i < refspecs_list.nr; i++)
     + 			refspec_append(&refspecs, refspecs_list.items[i].string);
      
     - ## builtin/submodule--helper.c ##
     -@@ builtin/submodule--helper.c: static int module_list_compute(const char **argv,
     - 			       struct pathspec *pathspec,
     - 			       struct module_list *list)
     + ## builtin/fast-import.c ##
     +@@ builtin/fast-import.c: static void end_packfile(void)
     + 		struct packed_git *new_p;
     + 		struct object_id cur_pack_oid;
     + 		char *idx_name;
     +-		int i;
     ++		unsigned long i;
     + 		struct branch *b;
     + 		struct tag *t;
     + 
     +
     + ## builtin/fetch-pack.c ##
     +@@ builtin/fetch-pack.c: int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
     + 	ref = fetch_pack(&args, fd, ref, sought, nr_sought,
     + 			 &shallow, pack_lockfiles_ptr, version);
     + 	if (pack_lockfiles.nr) {
     +-		int i;
     ++		size_t i;
     + 
     + 		printf("lock %s\n", pack_lockfiles.items[0].string);
     + 		fflush(stdout);
     +
     + ## builtin/fetch.c ##
     +@@ builtin/fetch.c: static int add_oid(const char *refname UNUSED,
     + static void add_negotiation_tips(struct git_transport_options *smart_options)
     + {
     + 	struct oid_array *oids = xcalloc(1, sizeof(*oids));
     +-	int i;
     ++	size_t i;
     + 
     + 	for (i = 0; i < negotiation_tip.nr; i++) {
     + 		const char *s = negotiation_tip.items[i].string;
     +-		int old_nr;
     ++		size_t old_nr;
     + 		if (!has_glob_specials(s)) {
     + 			struct object_id oid;
     + 			if (get_oid(s, &oid))
     +@@ builtin/fetch.c: static int fetch_finished(int result, struct strbuf *out,
     + 
     + static int fetch_multiple(struct string_list *list, int max_children)
       {
      -	int i, result = 0;
     -+	unsigned int i;
     ++	size_t i;
      +	int result = 0;
     - 	char *ps_matched = NULL;
     + 	struct strvec argv = STRVEC_INIT;
       
     - 	parse_pathspec(pathspec, 0,
     + 	if (!append && write_fetch_head) {
      
     - ## cache.h ##
     -@@ cache.h: int repo_interpret_branch_name(struct repository *r,
     + ## builtin/for-each-repo.c ##
     +@@ builtin/for-each-repo.c: static int run_command_on_repo(const char *path, int argc, const char ** argv)
     + int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
     + {
     + 	static const char *config_key = NULL;
     +-	int i, result = 0;
     ++	int result = 0;
     ++	size_t i;
     + 	const struct string_list *values;
       
     - int validate_headref(const char *ref);
     + 	const struct option options[] = {
     +
     + ## builtin/fsck.c ##
     +@@ builtin/fsck.c: static void check_object(struct object *obj)
       
     --int base_name_compare(const char *name1, int len1, int mode1, const char *name2, int len2, int mode2);
     --int df_name_compare(const char *name1, int len1, int mode1, const char *name2, int len2, int mode2);
     -+int base_name_compare(const char *name1, size_t len1, int mode1,
     -+		      const char *name2, size_t len2, int mode2);
     -+int df_name_compare(const char *name1, size_t len1, int mode1,
     -+		    const char *name2, size_t len2, int mode2);
     - int name_compare(const char *name1, size_t len1, const char *name2, size_t len2);
     --int cache_name_stage_compare(const char *name1, int len1, int stage1, const char *name2, int len2, int stage2);
     -+int cache_name_stage_compare(const char *name1, size_t len1, int stage1,
     -+			     const char *name2, size_t len2, int stage2);
     + static void check_connectivity(void)
     + {
     +-	int i, max;
     ++	unsigned int i, max;
       
     - void *read_object_with_reference(struct repository *r,
     - 				 const struct object_id *oid,
     -@@ cache.h: extern const char *askpass_program;
     - extern const char *excludes_file;
     + 	/* Traverse the pending reachable objects */
     + 	traverse_reachable();
     +
     + ## builtin/gc.c ##
     +@@ builtin/gc.c: static struct string_list pack_garbage = STRING_LIST_INIT_DUP;
       
     - /* base85 */
     --int decode_85(char *dst, const char *line, int linelen);
     --void encode_85(char *buf, const unsigned char *data, int bytes);
     -+int decode_85(char *dst, const char *line, size_t linelen);
     -+void encode_85(char *buf, const unsigned char *data, size_t bytes);
     + static void clean_pack_garbage(void)
     + {
     +-	int i;
     ++	size_t i;
     + 	for (i = 0; i < pack_garbage.nr; i++)
     + 		unlink_or_warn(pack_garbage.items[i].string);
     + 	string_list_clear(&pack_garbage, 0);
     +@@ builtin/gc.c: static int compare_tasks_by_selection(const void *a_, const void *b_)
       
     - /* pkt-line.c */
     - void packet_trace_identity(const char *prog);
     -
     - ## color.c ##
     -@@ color.c: struct color {
     -  * "word" is a buffer of length "len"; does it match the NUL-terminated
     -  * "match" exactly?
     -  */
     --static int match_word(const char *word, int len, const char *match)
     -+static int match_word(const char *word, size_t len, const char *match)
     + static int maintenance_run_tasks(struct maintenance_run_opts *opts)
       {
     - 	return !strncasecmp(word, match, len) && !match[len];
     - }
     -@@ color.c: static int get_hex_color(const char *in, unsigned char *out)
     -  * If an ANSI color is recognized in "name", fill "out" and return 0.
     -  * Otherwise, leave out unchanged and return -1.
     -  */
     --static int parse_ansi_color(struct color *out, const char *name, int len)
     -+static int parse_ansi_color(struct color *out, const char *name, size_t len)
     +-	int i, found_selected = 0;
     ++	unsigned int i;
     ++	int found_selected = 0;
     + 	int result = 0;
     + 	struct lock_file lk;
     + 	struct repository *r = the_repository;
     +@@ builtin/gc.c: static void initialize_maintenance_strategy(void)
     + 
     + static void initialize_task_config(int schedule)
       {
     - 	/* Positions in array must match ANSI color codes */
     - 	static const char * const color_names[] = {
     - 		"black", "red", "green", "yellow",
     - 		"blue", "magenta", "cyan", "white"
     - 	};
      -	int i;
      +	unsigned int i;
     - 	int color_offset = COLOR_FOREGROUND_ANSI;
     + 	struct strbuf config_name = STRBUF_INIT;
     + 	gc_config();
       
     - 	if (match_word(name, len, "default")) {
     -@@ color.c: static int parse_ansi_color(struct color *out, const char *name, int len)
     - 	return -1;
     - }
     +@@ builtin/gc.c: static void initialize_task_config(int schedule)
     + static int task_option_parse(const struct option *opt,
     + 			     const char *arg, int unset)
     + {
     +-	int i, num_selected = 0;
     ++	unsigned int i;
     ++	int num_selected = 0;
     + 	struct maintenance_task *task = NULL;
       
     --static int parse_color(struct color *out, const char *name, int len)
     -+static int parse_color(struct color *out, const char *name, size_t len)
     + 	BUG_ON_OPT_NEG(unset);
     +@@ builtin/gc.c: static int task_option_parse(const struct option *opt,
     + 
     + static int maintenance_run(int argc, const char **argv, const char *prefix)
       {
     - 	char *end;
     - 	long val;
     -@@ color.c: int color_parse(const char *value, char *dst)
     -  * already have the ANSI escape code in it. "out" should have enough
     -  * space in it to fit any color.
     -  */
     --static char *color_output(char *out, int len, const struct color *c, int background)
     -+static char *color_output(char *out, size_t len, const struct color *c,
     -+			  int background)
     +-	int i;
     ++	unsigned int i;
     + 	struct maintenance_run_opts opts;
     + 	struct option builtin_maintenance_run_options[] = {
     + 		OPT_BOOL(0, "auto", &opts.auto_flag,
     +@@ builtin/gc.c: static int launchctl_list_contains_plist(const char *name, const char *cmd)
     + 
     + static int launchctl_schedule_plist(const char *exec_path, enum schedule_priority schedule)
       {
     - 	int offset = 0;
     +-	int i, fd;
     +-	const char *preamble, *repeat;
     ++	unsigned int i;
     ++	int fd;
     ++	const char *preamble;
     + 	const char *frequency = get_frequency(schedule);
     + 	char *name = launchctl_service_name(frequency);
     + 	char *filename = launchctl_service_filename(name);
     +@@ builtin/gc.c: static int launchctl_schedule_plist(const char *exec_path, enum schedule_priorit
     + 
     + 	switch (schedule) {
     + 	case SCHEDULE_HOURLY:
     +-		repeat = "<dict>\n"
     +-			 "<key>Hour</key><integer>%d</integer>\n"
     +-			 "<key>Minute</key><integer>0</integer>\n"
     +-			 "</dict>\n";
     + 		for (i = 1; i <= 23; i++)
     +-			strbuf_addf(&plist, repeat, i);
     ++			strbuf_addf(&plist,
     ++				    "<dict>\n"
     ++				    "<key>Hour</key><integer>%u</integer>\n"
     ++				    "<key>Minute</key><integer>0</integer>\n"
     ++				    "</dict>\n",
     ++				    i);
     + 		break;
     + 
     + 	case SCHEDULE_DAILY:
     +-		repeat = "<dict>\n"
     +-			 "<key>Day</key><integer>%d</integer>\n"
     +-			 "<key>Hour</key><integer>0</integer>\n"
     +-			 "<key>Minute</key><integer>0</integer>\n"
     +-			 "</dict>\n";
     + 		for (i = 1; i <= 6; i++)
     +-			strbuf_addf(&plist, repeat, i);
     ++			strbuf_addf(&plist,
     ++				    "<dict>\n"
     ++				    "<key>Day</key><integer>%u</integer>\n"
     ++				    "<key>Hour</key><integer>0</integer>\n"
     ++				    "<key>Minute</key><integer>0</integer>\n"
     ++				    "</dict>\n",
     ++				    i);
     + 		break;
     + 
     + 	case SCHEDULE_WEEKLY:
     +@@ builtin/gc.c: static void validate_scheduler(enum scheduler scheduler)
     + static int update_background_schedule(const struct maintenance_start_opts *opts,
     + 				      int enable)
     + {
     +-	unsigned int i;
     ++	size_t i;
     + 	int result = 0;
     + 	struct lock_file lk;
     + 	char *lock_path = xstrfmt("%s/schedule", the_repository->objects->odb->path);
     +
     + ## builtin/grep.c ##
     +@@ builtin/grep.c: static void work_done(struct work_item *w)
       
     -@@ color.c: static int color_empty(const struct color *c)
     - 	return c->type <= COLOR_NORMAL;
     - }
     + static void free_repos(void)
     + {
     +-	int i;
     ++	size_t i;
       
     --int color_parse_mem(const char *value, int value_len, char *dst)
     -+int color_parse_mem(const char *value, size_t value_len, char *dst)
     + 	for (i = 0; i < repos_to_free_nr; i++) {
     + 		repo_clear(repos_to_free[i]);
     +@@ builtin/grep.c: static void run_pager(struct grep_opt *opt, const char *prefix)
       {
     - 	const char *ptr = value;
     --	int len = value_len;
     -+	size_t len = value_len;
     - 	char *end = dst + COLOR_MAXLEN;
     --	unsigned int has_reset = 0;
     -+	int has_reset = 0;
     - 	unsigned int attr = 0;
     - 	struct color fg = { COLOR_UNSPECIFIED };
     - 	struct color bg = { COLOR_UNSPECIFIED };
     + 	struct string_list *path_list = opt->output_priv;
     + 	struct child_process child = CHILD_PROCESS_INIT;
     +-	int i, status;
     ++	size_t i;
     ++	int status;
       
     --	while (len > 0 && isspace(*ptr)) {
     -+	while (len && isspace(*ptr)) {
     - 		ptr++;
     - 		len--;
     - 	}
     -@@ color.c: int color_parse_mem(const char *value, int value_len, char *dst)
     - 	}
     + 	for (i = 0; i < path_list->nr; i++)
     + 		strvec_push(&child.args, path_list->items[i].string);
     +
     + ## builtin/help.c ##
     +@@ builtin/help.c: static void list_config_help(enum show_config_type type)
     + 	struct string_list keys = STRING_LIST_INIT_DUP;
     + 	struct string_list keys_uniq = STRING_LIST_INIT_DUP;
     + 	struct string_list_item *item;
     +-	int i;
     ++	size_t i;
       
     - 	/* [reset] [fg [bg]] [attr]... */
     --	while (len > 0) {
     -+	while (len) {
     - 		const char *word = ptr;
     - 		struct color c = { COLOR_UNSPECIFIED };
     --		int val, wordlen = 0;
     -+		int val;
     -+		size_t wordlen = 0;
     + 	for (p = config_name_list; *p; p++) {
     + 		const char *var = *p;
     +
     + ## builtin/log.c ##
     +@@ builtin/log.c: static void cmd_log_init_defaults(struct rev_info *rev)
       
     - 		while (len > 0 && !isspace(word[wordlen])) {
     - 			wordlen++;
     -@@ color.c: int color_parse_mem(const char *value, int value_len, char *dst)
     + static void set_default_decoration_filter(struct decoration_filter *decoration_filter)
     + {
     +-	int i;
     ++	size_t i;
     + 	char *value = NULL;
     + 	struct string_list *include = decoration_filter->include_ref_pattern;
     + 	const struct string_list *config_exclude =
     +@@ builtin/log.c: static struct itimerval early_output_timer;
     + 
     + static void log_show_early(struct rev_info *revs, struct commit_list *list)
     + {
     +-	int i = revs->early_output;
     ++	unsigned int i = revs->early_output;
     + 	int show_header = 1;
     + 	int no_free = revs->diffopt.no_free;
     + 
     +
     + ## builtin/ls-files.c ##
     +@@ builtin/ls-files.c: static void show_ru_info(struct index_state *istate)
     + 	for_each_string_list_item(item, istate->resolve_undo) {
     + 		const char *path = item->string;
     + 		struct resolve_undo_info *ui = item->util;
     +-		int i, len;
     ++		unsigned int i;
     ++		int len;
     + 
     + 		len = strlen(path);
     + 		if (len < max_prefix_len)
     +@@ builtin/ls-files.c: static void show_ru_info(struct index_state *istate)
     + 		for (i = 0; i < 3; i++) {
     + 			if (!ui->mode[i])
     + 				continue;
     +-			printf("%s%06o %s %d\t", tag_resolve_undo, ui->mode[i],
     +-			       find_unique_abbrev(&ui->oid[i], abbrev),
     +-			       i + 1);
     ++			printf("%s%06o %s %u\t", tag_resolve_undo, ui->mode[i],
     ++			       find_unique_abbrev(&ui->oid[i], abbrev), i + 1);
     + 			write_name(path);
     + 		}
     + 	}
     +@@ builtin/ls-files.c: static void construct_fullname(struct strbuf *out, const struct repository *repo
     + 
     + static void show_files(struct repository *repo, struct dir_struct *dir)
     + {
     +-	int i;
     ++	unsigned int i;
     + 	struct strbuf fullname = STRBUF_INIT;
     + 
     + 	/* For cached/deleted files we don't need to even do the readdir */
     +@@ builtin/ls-files.c: static void show_files(struct repository *repo, struct dir_struct *dir)
     + 
     + skip_to_next_name:
     + 		{
     +-			int j;
     +-			struct cache_entry **cache = repo->index->cache;
     +-			for (j = i + 1; j < repo->index->cache_nr; j++)
     +-				if (strcmp(ce->name, cache[j]->name))
     +-					break;
     +-			i = j - 1; /* compensate for the for loop */
     ++		unsigned int j;
     ++		struct cache_entry **cache = repo->index->cache;
     ++		for (j = i + 1; j < repo->index->cache_nr; j++)
     ++			if (strcmp(ce->name, cache[j]->name))
     ++				break;
     ++		i = j - 1; /* compensate for the for loop */
     + 		}
     + 	}
     + 
     +@@ builtin/ls-files.c: void overlay_tree_on_index(struct index_state *istate,
     + 	struct object_id oid;
     + 	struct pathspec pathspec;
     + 	struct cache_entry *last_stage0 = NULL;
     +-	int i;
     ++	unsigned int i;
     + 	read_tree_fn_t fn = NULL;
     + 	int err;
     + 
     +
     + ## builtin/ls-remote.c ##
     +@@ builtin/ls-remote.c: int cmd_ls_remote(int argc, const char **argv, const char *prefix)
     + 	packet_trace_identity("ls-remote");
     + 
     + 	if (argc > 1) {
     +-		int i;
     + 		CALLOC_ARRAY(pattern, argc);
     + 		for (i = 1; i < argc; i++) {
     + 			pattern[i - 1] = xstrfmt("*/%s", argv[i]);
     +
     + ## builtin/mailsplit.c ##
     +@@ builtin/mailsplit.c: static int split_maildir(const char *maildir, const char *dir,
     + 	char *file = NULL;
     + 	FILE *f = NULL;
     + 	int ret = -1;
     +-	int i;
     ++	size_t i;
     + 	struct string_list list = STRING_LIST_INIT_DUP;
     + 
     + 	list.cmp = maildir_filename_cmp;
     +
     + ## builtin/merge-file.c ##
     +@@ builtin/merge-file.c: int cmd_merge_file(int argc, const char **argv, const char *prefix)
     + 	mmfile_t mmfs[3] = { 0 };
     + 	mmbuffer_t result = { 0 };
     + 	xmparam_t xmp = { 0 };
     +-	int ret = 0, i = 0, to_stdout = 0;
     ++	int ret = 0, to_stdout = 0;
     ++	size_t i = 0;
     + 	int quiet = 0;
     + 	struct option options[] = {
     + 		OPT_BOOL('p', "stdout", &to_stdout, N_("send results to standard output")),
     +
     + ## builtin/merge.c ##
     +@@ builtin/merge.c: static struct strategy *get_strategy(const char *name)
     + 		memset(&not_strategies, 0, sizeof(struct cmdnames));
     + 		load_command_list("git-merge-", &main_cmds, &other_cmds);
     + 		for (i = 0; i < main_cmds.cnt; i++) {
     +-			int j, found = 0;
     ++			size_t j;
     ++			int found = 0;
     + 			struct cmdname *ent = main_cmds.names[i];
     + 			for (j = 0; j < ARRAY_SIZE(all_strategy); j++)
     + 				if (!strncmp(ent->name, all_strategy[j].name, ent->len)
     +
     + ## builtin/name-rev.c ##
     +@@ builtin/name-rev.c: int cmd_name_rev(int argc, const char **argv, const char *prefix)
     + 		}
     + 		strbuf_release(&sb);
     + 	} else if (all) {
     +-		int i, max;
     ++		unsigned int i, max;
     + 
     + 		max = get_max_object_index();
     + 		for (i = 0; i < max; i++) {
     +@@ builtin/name-rev.c: int cmd_name_rev(int argc, const char **argv, const char *prefix)
     + 				  always, allow_undefined, data.name_only);
     + 		}
     + 	} else {
     +-		int i;
     ++		unsigned int i;
     + 		for (i = 0; i < revs.nr; i++)
     + 			show_name(revs.objects[i].item, revs.objects[i].name,
     + 				  always, allow_undefined, data.name_only);
     +
     + ## builtin/pack-objects.c ##
     +@@ builtin/pack-objects.c: static int want_object_in_pack(const struct object_id *oid,
     + 	if (uri_protocols.nr) {
     + 		struct configured_exclusion *ex =
     + 			oidmap_get(&configured_exclusions, oid);
     +-		int i;
     ++		size_t i;
     + 		const char *p;
     + 
     + 		if (ex) {
     +@@ builtin/pack-objects.c: static void pbase_tree_put(struct pbase_tree_cache *cache)
     + 	free(cache);
     + }
     + 
     +-static int name_cmp_len(const char *name)
     ++static size_t name_cmp_len(const char *name)
     + {
     +-	int i;
     ++	size_t i;
     + 	for (i = 0; name[i] && name[i] != '\n' && name[i] != '/'; i++)
     + 		;
     + 	return i;
     + }
     + 
     +-static void add_pbase_object(struct tree_desc *tree,
     +-			     const char *name,
     +-			     int cmplen,
     +-			     const char *fullname)
     ++static void add_pbase_object(struct tree_desc *tree, const char *name,
     ++			     size_t cmplen, const char *fullname)
     + {
     + 	struct name_entry entry;
     + 	int cmp;
     +@@ builtin/pack-objects.c: static void add_pbase_object(struct tree_desc *tree,
     + 			struct tree_desc sub;
     + 			struct pbase_tree_cache *tree;
     + 			const char *down = name+cmplen+1;
     +-			int downlen = name_cmp_len(down);
     ++			size_t downlen = name_cmp_len(down);
     + 
     + 			tree = pbase_tree_get(&entry.oid);
     + 			if (!tree)
     +@@ builtin/pack-objects.c: static void add_extra_kept_packs(const struct string_list *names)
     + 
     + 	for (p = get_all_packs(the_repository); p; p = p->next) {
     + 		const char *name = basename(p->pack_name);
     +-		int i;
     ++		size_t i;
     + 
     + 		if (!p->pack_local)
     + 			continue;
     +
     + ## builtin/pack-redundant.c ##
     +@@ builtin/pack-redundant.c: static inline struct llist_item *llist_item_get(void)
     + 		new_item = free_nodes;
     + 		free_nodes = free_nodes->next;
     + 	} else {
     +-		int i = 1;
     ++		size_t i;
     + 		ALLOC_ARRAY(new_item, BLKSIZE);
     +-		for (; i < BLKSIZE; i++)
     ++		for (i = 1; i < BLKSIZE; i++)
     + 			llist_item_put(&new_item[i]);
     + 	}
     + 	return new_item;
     +@@ builtin/pack-redundant.c: static int cmp_remaining_objects(const void *a, const void *b)
     + static void sort_pack_list(struct pack_list **pl)
     + {
     + 	struct pack_list **ary, *p;
     +-	int i;
     ++	size_t i;
     + 	size_t n = pack_list_size(*pl);
     + 
     + 	if (n < 2)
     +
     + ## builtin/patch-id.c ##
     +@@ builtin/patch-id.c: static void flush_current_id(int patchlen, struct object_id *id, struct object_i
     + 		printf("%s %s\n", oid_to_hex(result), oid_to_hex(id));
     + }
     + 
     +-static int remove_space(char *line)
     ++static size_t remove_space(char *line)
     + {
     + 	char *src = line;
     + 	char *dst = line;
     +@@ builtin/patch-id.c: static int scan_hunk_header(const char *p, int *p_before, int *p_after)
     + 	return 1;
     + }
     + 
     +-static int get_one_patchid(struct object_id *next_oid, struct object_id *result,
     +-			   struct strbuf *line_buf, int stable, int verbatim)
     ++static size_t get_one_patchid(struct object_id *next_oid,
     ++			      struct object_id *result, struct strbuf *line_buf,
     ++			      int stable, int verbatim)
     + {
     +-	int patchlen = 0, found_next = 0;
     ++	size_t patchlen = 0;
     ++	int found_next = 0;
     + 	int before = -1, after = -1;
     + 	int diff_is_binary = 0;
     + 	char pre_oid_str[GIT_MAX_HEXSZ + 1], post_oid_str[GIT_MAX_HEXSZ + 1];
     +@@ builtin/patch-id.c: static int get_one_patchid(struct object_id *next_oid, struct object_id *result,
     + 	while (strbuf_getwholeline(line_buf, stdin, '\n') != EOF) {
     + 		char *line = line_buf->buf;
     + 		const char *p = line;
     +-		int len;
     ++		size_t len;
     + 
     + 		/* Possibly skip over the prefix added by "log" or "format-patch" */
     + 		if (!skip_prefix(line, "commit ", &p) &&
     +@@ builtin/patch-id.c: static int get_one_patchid(struct object_id *next_oid, struct object_id *result,
     + static void generate_id_list(int stable, int verbatim)
     + {
     + 	struct object_id oid, n, result;
     +-	int patchlen;
     ++	size_t patchlen;
     + 	struct strbuf line_buf = STRBUF_INIT;
     + 
     + 	oidclr(&oid);
     +
     + ## builtin/pull.c ##
     +@@ builtin/pull.c: static int get_can_ff(struct object_id *orig_head,
     + static int already_up_to_date(struct object_id *orig_head,
     + 			      struct oid_array *merge_heads)
     + {
     +-	int i;
     ++	size_t i;
     + 	struct commit *ours;
     + 
     + 	ours = lookup_commit_reference(the_repository, orig_head);
     +
     + ## builtin/read-tree.c ##
     +@@ builtin/read-tree.c: static void debug_stage(const char *label, const struct cache_entry *ce,
     + static int debug_merge(const struct cache_entry * const *stages,
     + 		       struct unpack_trees_options *o)
     + {
     +-	int i;
     ++	unsigned int i;
     + 
     +-	printf("* %d-way merge\n", o->merge_size);
     ++	printf("* %u-way merge\n", o->merge_size);
     + 	debug_stage("index", stages[0], o);
     + 	for (i = 1; i <= o->merge_size; i++) {
     + 		char buf[24];
     +-		xsnprintf(buf, sizeof(buf), "ent#%d", i);
     ++		xsnprintf(buf, sizeof(buf), "ent#%u", i);
     + 		debug_stage(buf, stages[i], o);
     + 	}
     + 	return 0;
     +
     + ## builtin/rebase.c ##
     +@@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
     + 		options.gpg_sign_opt = xstrfmt("-S%s", gpg_sign);
     + 
     + 	if (exec.nr) {
     +-		int i;
     ++		size_t j;
     + 
     + 		imply_merge(&options, "--exec");
     + 
     + 		strbuf_reset(&buf);
     +-		for (i = 0; i < exec.nr; i++)
     +-			strbuf_addf(&buf, "exec %s\n", exec.items[i].string);
     ++		for (j = 0; j < exec.nr; j++)
     ++			strbuf_addf(&buf, "exec %s\n", exec.items[j].string);
     + 		options.cmd = xstrdup(buf.buf);
     + 	}
     + 
     +@@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
     + 	}
     + 
     + 	if (strategy_options.nr) {
     +-		int i;
     ++		size_t j;
     + 
     + 		if (!options.strategy)
     + 			options.strategy = "ort";
     + 
     + 		strbuf_reset(&buf);
     +-		for (i = 0; i < strategy_options.nr; i++)
     ++		for (j = 0; j < strategy_options.nr; j++)
     + 			strbuf_addf(&buf, " --%s",
     +-				    strategy_options.items[i].string);
     ++				    strategy_options.items[j].string);
     + 		options.strategy_opts = xstrdup(buf.buf);
     + 	}
     + 
     +
     + ## builtin/receive-pack.c ##
     +@@ builtin/receive-pack.c: static void hmac_hash(unsigned char *out,
     + 	unsigned char key[GIT_MAX_BLKSZ];
     + 	unsigned char k_ipad[GIT_MAX_BLKSZ];
     + 	unsigned char k_opad[GIT_MAX_BLKSZ];
     +-	int i;
     ++	size_t i;
     + 	git_hash_ctx ctx;
     + 
     + 	/* RFC 2104 2. (1) */
     +@@ builtin/receive-pack.c: static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
     + 	struct oid_array extra = OID_ARRAY_INIT;
     + 	struct check_connected_options opt = CHECK_CONNECTED_INIT;
     + 	uint32_t mask = 1 << (cmd->index % 32);
     +-	int i;
     ++	size_t i;
     + 
     + 	trace_printf_key(&trace_shallow,
     + 			 "shallow: update_shallow_ref %s\n", cmd->ref_name);
     +@@ builtin/receive-pack.c: static const char *unpack_with_sideband(struct shallow_info *si)
     + 
     + static void prepare_shallow_update(struct shallow_info *si)
     + {
     +-	int i, j, k, bitmap_size = DIV_ROUND_UP(si->ref->nr, 32);
     ++	size_t i, j, k;
     ++	size_t bitmap_size = DIV_ROUND_UP(si->ref->nr, 32);
     ++	int l;
     + 
     + 	ALLOC_ARRAY(si->used_shallow, si->shallow->nr);
     + 	assign_shallow_commits_to_refs(si, si->used_shallow, NULL);
     +@@ builtin/receive-pack.c: static void prepare_shallow_update(struct shallow_info *si)
     + 	CALLOC_ARRAY(si->reachable, si->shallow->nr);
     + 	CALLOC_ARRAY(si->shallow_ref, si->ref->nr);
     + 
     +-	for (i = 0; i < si->nr_ours; i++)
     +-		si->need_reachability_test[si->ours[i]] = 1;
     ++	for (l = 0; l < si->nr_ours; l++)
     ++		si->need_reachability_test[si->ours[l]] = 1;
     + 
     + 	for (i = 0; i < si->shallow->nr; i++) {
     + 		if (!si->used_shallow[i])
     +
     + ## builtin/remote.c ##
     +@@ builtin/remote.c: static int add(int argc, const char **argv, const char *prefix)
     + 	struct remote *remote;
     + 	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT;
     + 	const char *name, *url;
     +-	int i;
     ++	size_t i;
     + 
     + 	struct option options[] = {
     + 		OPT_BOOL('f', "fetch", &fetch, N_("fetch the remote branches")),
     +@@ builtin/remote.c: static int rm(int argc, const char **argv, const char *prefix)
     + 	struct string_list branches = STRING_LIST_INIT_DUP;
     + 	struct string_list skipped = STRING_LIST_INIT_DUP;
     + 	struct branches_for_remote cb_data;
     +-	int i, result;
     ++	size_t i;
     ++	int result;
     + 
     + 	memset(&cb_data, 0, sizeof(cb_data));
     + 	cb_data.branches = &branches;
     +@@ builtin/remote.c: static int show_local_info_item(struct string_list_item *item, void *cb_data)
     + 	struct branch_info *branch_info = item->util;
     + 	struct string_list *merge = &branch_info->merge;
     + 	int width = show_info->width + 4;
     +-	int i;
     ++	size_t i;
     + 
     + 	if (branch_info->rebase >= REBASE_TRUE && branch_info->merge.nr > 1) {
     + 		error(_("invalid branch.%s.merge; cannot rebase onto > 1 branch"),
     +@@ builtin/remote.c: static int show_all(void)
     + 	result = for_each_remote(get_one_entry, &list);
     + 
     + 	if (!result) {
     +-		int i;
     ++		size_t i;
     + 
     + 		string_list_sort(&list);
     + 		for (i = 0; i < list.nr; i++) {
     +@@ builtin/remote.c: static int show(int argc, const char **argv, const char *prefix)
     + 
     + static int set_head(int argc, const char **argv, const char *prefix)
     + {
     +-	int i, opt_a = 0, opt_d = 0, result = 0;
     ++	int opt_a = 0, opt_d = 0, result = 0;
     + 	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT;
     + 	char *head_name = NULL;
     + 
     +@@ builtin/remote.c: static int set_head(int argc, const char **argv, const char *prefix)
     + 		if (!states.heads.nr)
     + 			result |= error(_("Cannot determine remote HEAD"));
     + 		else if (states.heads.nr > 1) {
     ++			size_t i;
     + 			result |= error(_("Multiple remote HEAD branches. "
     + 					  "Please choose one explicitly with:"));
     + 			for (i = 0; i < states.heads.nr; i++)
     +
     + ## builtin/repack.c ##
     +@@ builtin/repack.c: static void collect_pack_filenames(struct string_list *fname_nonkept_list,
     + 
     + 	while ((e = readdir(dir)) != NULL) {
     + 		size_t len;
     +-		int i;
     ++		size_t i;
     + 
     + 		if (!strip_suffix(e->d_name, ".pack", &len))
     + 			continue;
     +@@ builtin/repack.c: static struct generated_pack_data *populate_pack_exts(const char *name)
     + 	struct stat statbuf;
     + 	struct strbuf path = STRBUF_INIT;
     + 	struct generated_pack_data *data = xcalloc(1, sizeof(*data));
     +-	int i;
     ++	size_t i;
     + 
     + 	for (i = 0; i < ARRAY_SIZE(exts); i++) {
     + 		strbuf_reset(&path);
     +@@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix)
     + 	struct pack_geometry *geometry = NULL;
     + 	struct strbuf line = STRBUF_INIT;
     + 	struct tempfile *refs_snapshot = NULL;
     +-	int i, ext, ret;
     ++	size_t i;
     ++	int ext, ret;
     + 	FILE *out;
     + 	int show_progress;
     + 
     +
     + ## builtin/rerere.c ##
     +@@ builtin/rerere.c: static int diff_two(const char *file1, const char *label1,
     + int cmd_rerere(int argc, const char **argv, const char *prefix)
     + {
     + 	struct string_list merge_rr = STRING_LIST_INIT_DUP;
     +-	int i, autoupdate = -1, flags = 0;
     ++	size_t i;
     ++	int autoupdate = -1, flags = 0;
     + 
     + 	struct option options[] = {
     + 		OPT_SET_INT(0, "rerere-autoupdate", &autoupdate,
     +
     + ## builtin/reset.c ##
     +@@ builtin/reset.c: static inline int is_merge(void)
     + 
     + static int reset_index(const char *ref, const struct object_id *oid, int reset_type, int quiet)
     + {
     +-	int i, nr = 0;
     ++	unsigned int i, nr = 0;
     + 	struct tree_desc desc[2];
     + 	struct tree *tree;
     + 	struct unpack_trees_options opts;
     +
     + ## builtin/rev-parse.c ##
     +@@ builtin/rev-parse.c: int cmd_rev_parse(int argc, const char **argv, const char *prefix)
     + 
     + 		if (!seen_end_of_options) {
     + 			if (!strcmp(arg, "--local-env-vars")) {
     +-				int i;
     ++				size_t i;
     + 				for (i = 0; local_repo_env[i]; i++)
     + 					printf("%s\n", local_repo_env[i]);
     + 				continue;
     +
     + ## builtin/rm.c ##
     +@@ builtin/rm.c: static void print_error_files(struct string_list *files_list,
     + 			      int *errs)
     + {
     + 	if (files_list->nr) {
     +-		int i;
     ++		size_t i;
     + 		struct strbuf err_msg = STRBUF_INIT;
     + 
     + 		strbuf_addstr(&err_msg, main_msg);
     +@@ builtin/rm.c: static struct option builtin_rm_options[] = {
     + int cmd_rm(int argc, const char **argv, const char *prefix)
     + {
     + 	struct lock_file lock_file = LOCK_INIT;
     +-	int i, ret = 0;
     ++	int i;
     ++	unsigned int j;
     ++	int ret = 0;
     + 	struct pathspec pathspec;
     + 	char *seen;
     + 
     +@@ builtin/rm.c: int cmd_rm(int argc, const char **argv, const char *prefix)
     + 	if (pathspec_needs_expanded_index(&the_index, &pathspec))
     + 		ensure_full_index(&the_index);
     + 
     +-	for (i = 0; i < the_index.cache_nr; i++) {
     +-		const struct cache_entry *ce = the_index.cache[i];
     ++	for (j = 0; j < the_index.cache_nr; j++) {
     ++		const struct cache_entry *ce = the_index.cache[j];
     + 
     + 		if (!include_sparse &&
     + 		    (ce_skip_worktree(ce) ||
     +
     + ## builtin/show-branch.c ##
     +@@ builtin/show-branch.c: static void name_parent(struct commit *commit, struct commit *parent)
     + 			    commit_name->generation + 1);
     + }
     + 
     +-static int name_first_parent_chain(struct commit *c)
     ++static size_t name_first_parent_chain(struct commit *c)
     + {
     +-	int i = 0;
     ++	size_t i = 0;
     + 	while (c) {
     + 		struct commit *p;
     + 		if (!commit_to_name(c))
     +@@ builtin/show-branch.c: static int name_first_parent_chain(struct commit *c)
     + 	return i;
     + }
     + 
     +-static void name_commits(struct commit_list *list,
     +-			 struct commit **rev,
     +-			 char **ref_name,
     +-			 int num_rev)
     ++static void name_commits(struct commit_list *list, struct commit **rev,
     ++			 char **ref_name, size_t num_rev)
     + {
     + 	struct commit_list *cl;
     + 	struct commit *c;
     +-	int i;
     ++	size_t i;
     + 
     + 	/* First give names to the given heads */
     + 	for (cl = list; cl; cl = cl->next) {
     +@@ builtin/show-branch.c: static int mark_seen(struct commit *commit, struct commit_list **seen_p)
     + 	return 0;
     + }
     + 
     +-static void join_revs(struct commit_list **list_p,
     +-		      struct commit_list **seen_p,
     +-		      int num_rev, int extra)
     ++static void join_revs(struct commit_list **list_p, struct commit_list **seen_p,
     ++		      size_t num_rev, int extra)
     + {
     +-	int all_mask = ((1u << (REV_SHIFT + num_rev)) - 1);
     +-	int all_revs = all_mask & ~((1u << REV_SHIFT) - 1);
     ++	size_t all_mask = ((1u << (REV_SHIFT + num_rev)) - 1);
     ++	size_t all_revs = all_mask & ~((1u << REV_SHIFT) - 1);
     + 
     + 	while (*list_p) {
     + 		struct commit_list *parents;
     + 		int still_interesting = !!interesting(*list_p);
     + 		struct commit *commit = pop_commit(list_p);
     +-		int flags = commit->object.flags & all_mask;
     ++		unsigned int flags = commit->object.flags & all_mask;
     + 
     + 		if (!still_interesting && extra <= 0)
     + 			break;
     +@@ builtin/show-branch.c: static int show_merge_base(struct commit_list *seen, int num_rev)
     + 	return exit_status;
     + }
     + 
     +-static int show_independent(struct commit **rev,
     +-			    int num_rev,
     ++static int show_independent(struct commit **rev, size_t num_rev,
     + 			    unsigned int *rev_mask)
     + {
     +-	int i;
     ++	size_t i;
     + 
     + 	for (i = 0; i < num_rev; i++) {
     + 		struct commit *commit = rev[i];
     +@@ builtin/show-branch.c: int cmd_show_branch(int ac, const char **av, const char *prefix)
     + 	char *reflog_msg[MAX_REVS];
     + 	struct commit_list *list = NULL, *seen = NULL;
     + 	unsigned int rev_mask[MAX_REVS];
     +-	int num_rev, i, extra = 0;
     ++	size_t num_rev, i;
     ++	int extra = 0;
     + 	int all_heads = 0, all_remotes = 0;
     + 	int all_mask, all_revs;
     + 	enum rev_sort_order sort_order = REV_SORT_IN_GRAPH_ORDER;
     +@@ builtin/show-branch.c: int cmd_show_branch(int ac, const char **av, const char *prefix)
     + 						msg);
     + 			free(logmsg);
     + 
     +-			nth_desc = xstrfmt("%s@{%d}", *av, base+i);
     ++			nth_desc = xstrfmt("%s@{%lu}", *av,
     ++					   (unsigned long)(base + i));
     + 			append_ref(nth_desc, &oid, 1);
     + 			free(nth_desc);
     + 		}
     +
     + ## builtin/show-index.c ##
     +@@ builtin/show-index.c: static const char *const show_index_usage[] = {
     + 
     + int cmd_show_index(int argc, const char **argv, const char *prefix)
     + {
     +-	int i;
     ++	unsigned int i;
     + 	unsigned nr;
     + 	unsigned int version;
     + 	static unsigned int top_index[256];
     +
     + ## builtin/sparse-checkout.c ##
     +@@ builtin/sparse-checkout.c: static int sparse_checkout_list(int argc, const char **argv, const char *prefix)
     + 	}
     + 
     + 	if (pl.use_cone_patterns) {
     +-		int i;
     ++		size_t i;
     + 		struct pattern_entry *pe;
     + 		struct hashmap_iter iter;
     + 		struct string_list sl = STRING_LIST_INIT_DUP;
     +@@ builtin/sparse-checkout.c: static int sparse_checkout_list(int argc, const char **argv, const char *prefix)
     + 
     + static void clean_tracked_sparse_directories(struct repository *r)
     + {
     +-	int i, was_full = 0;
     ++	unsigned int i;
     ++	int was_full = 0;
     + 	struct strbuf path = STRBUF_INIT;
     + 	size_t pathlen;
     + 	struct string_list_item *item;
     +@@ builtin/sparse-checkout.c: static char *escaped_pattern(char *pattern)
     + 
     + static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
     + {
     +-	int i;
     ++	size_t i;
     + 	struct pattern_entry *pe;
     + 	struct hashmap_iter iter;
     + 	struct string_list sl = STRING_LIST_INIT_DUP;
     +
     + ## builtin/stash.c ##
     +@@ builtin/stash.c: static void diff_include_untracked(const struct stash_info *info, struct diff_op
     + 	struct tree *tree[ARRAY_SIZE(oid)];
     + 	struct tree_desc tree_desc[ARRAY_SIZE(oid)];
     + 	struct unpack_trees_options unpack_tree_opt = { 0 };
     +-	int i;
     ++	size_t i;
     + 
     + 	for (i = 0; i < ARRAY_SIZE(oid); i++) {
     + 		tree[i] = parse_tree_indirect(oid[i]);
     +@@ builtin/stash.c: static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
     + 
     + 	repo_read_index_preload(the_repository, NULL, 0);
     + 	if (!include_untracked && ps->nr) {
     +-		int i;
     ++		unsigned int i;
     + 		char *ps_matched = xcalloc(ps->nr, 1);
     + 
     + 		/* TODO: audit for interaction with sparse-index. */
     +
     + ## builtin/submodule--helper.c ##
     +@@ builtin/submodule--helper.c: static int module_list_compute(const char **argv,
     + 			       struct pathspec *pathspec,
     + 			       struct module_list *list)
     + {
     +-	int i, result = 0;
     ++	unsigned int i;
     ++	int result = 0;
     + 	char *ps_matched = NULL;
     + 
     + 	parse_pathspec(pathspec, 0,
     +@@ builtin/submodule--helper.c: static char *get_up_path(const char *path)
     + 	int i;
     + 	struct strbuf sb = STRBUF_INIT;
     + 
     +-	for (i = count_slashes(path); i; i--)
     ++	for (i = count_slashes(path); i > 0; i--)
     + 		strbuf_addstr(&sb, "../");
     + 
     + 	/*
     +@@ builtin/submodule--helper.c: static void die_on_index_match(const char *path, int force)
     + 		die(_("index file corrupt"));
     + 
     + 	if (ps.nr) {
     +-		int i;
     ++		unsigned int i;
     + 		char *ps_matched = xcalloc(ps.nr, 1);
     + 
     + 		/* TODO: audit for interaction with sparse-index. */
     +
     + ## builtin/unpack-objects.c ##
     +@@ builtin/unpack-objects.c: static void unpack_one(unsigned nr)
     + 
     + static void unpack_all(void)
     + {
     +-	int i;
     ++	unsigned int i;
     + 	struct pack_header *hdr = fill(sizeof(struct pack_header));
     + 
     + 	nr_objects = ntohl(hdr->hdr_entries);
     +
     + ## builtin/update-ref.c ##
     +@@ builtin/update-ref.c: static void update_refs_stdin(void)
     + 	struct strbuf input = STRBUF_INIT, err = STRBUF_INIT;
     + 	enum update_refs_state state = UPDATE_REFS_OPEN;
     + 	struct ref_transaction *transaction;
     +-	int i, j;
     ++	size_t i;
     + 
     + 	transaction = ref_transaction_begin(&err);
     + 	if (!transaction)
     +@@ builtin/update-ref.c: static void update_refs_stdin(void)
     + 		 * error in case there is an early EOF to let the command
     + 		 * handle missing arguments with a proper error message.
     + 		 */
     +-		for (j = 1; line_termination == '\0' && j < cmd->args; j++)
     ++		for (i = 1; line_termination == '\0' && i < cmd->args; i++)
     + 			if (strbuf_appendwholeline(&input, stdin, line_termination))
     + 				break;
     + 
     +
     + ## builtin/worktree.c ##
     +@@ builtin/worktree.c: static int prune_cmp(const void *a, const void *b)
     + 
     + static void prune_dups(struct string_list *l)
     + {
     +-	int i;
     ++	size_t i;
     + 
     + 	QSORT(l->items, l->nr, prune_cmp);
     + 	for (i = 1; i < l->nr; i++) {
     +@@ builtin/worktree.c: static void show_worktree(struct worktree *wt, int path_maxlen, int abbrev_len)
     + 
     + static void measure_widths(struct worktree **wt, int *abbrev, int *maxlen)
     + {
     +-	int i;
     ++	size_t i;
     + 
     + 	for (i = 0; wt[i]; i++) {
     + 		int sha1_len;
     +@@ builtin/worktree.c: static void validate_no_submodules(const struct worktree *wt)
     + {
     + 	struct index_state istate = { NULL };
     + 	struct strbuf path = STRBUF_INIT;
     +-	int i, found_submodules = 0;
     ++	unsigned int i;
     ++	int found_submodules = 0;
     + 
     + 	if (is_directory(worktree_git_path(wt, "modules"))) {
     + 		/*
     +
     + ## bulk-checkin.c ##
     +@@ bulk-checkin.c: static void flush_bulk_checkin_packfile(struct bulk_checkin_packfile *state)
     + {
     + 	unsigned char hash[GIT_MAX_RAWSZ];
     + 	struct strbuf packname = STRBUF_INIT;
     +-	int i;
     ++	uint32_t i;
     + 
     + 	if (!state->f)
     + 		return;
     +@@ bulk-checkin.c: static void flush_batch_fsync(void)
     + 
     + static int already_written(struct bulk_checkin_packfile *state, struct object_id *oid)
     + {
     +-	int i;
     ++	uint32_t i;
     + 
     + 	/* The object may already exist in the repository */
     + 	if (has_object_file(oid))
     +
     + ## bundle.c ##
     +@@ bundle.c: static int parse_capability(struct bundle_header *header, const char *capability
     + 
     + static int parse_bundle_signature(struct bundle_header *header, const char *line)
     + {
     +-	int i;
     ++	size_t i;
     + 
     + 	for (i = 0; i < ARRAY_SIZE(bundle_sigs); i++) {
     + 		if (!strcmp(line, bundle_sigs[i].signature)) {
     +@@ bundle.c: int is_bundle(const char *path, int quiet)
     + 
     + static int list_refs(struct string_list *r, int argc, const char **argv)
     + {
     +-	int i;
     ++	size_t i;
     + 
     + 	for (i = 0; i < r->nr; i++) {
     + 		struct object_id *oid;
     +@@ bundle.c: int verify_bundle(struct repository *r,
     + 	struct rev_info revs = REV_INFO_INIT;
     + 	const char *argv[] = {NULL, "--all", NULL};
     + 	struct commit *commit;
     +-	int i, ret = 0, req_nr;
     ++	size_t i;
     ++	int ret = 0;
     ++	unsigned int req_nr;
     + 	const char *message = _("Repository lacks these prerequisite commits:");
     + 
     + 	if (!r || !r->objects || !r->objects->odb)
     +@@ bundle.c: out:
     + static int write_pack_data(int bundle_fd, struct rev_info *revs, struct strvec *pack_options)
     + {
     + 	struct child_process pack_objects = CHILD_PROCESS_INIT;
     +-	int i;
     ++	unsigned int i;
     + 
     + 	strvec_pushl(&pack_objects.args,
     + 		     "pack-objects",
     +@@ bundle.c: static int write_pack_data(int bundle_fd, struct rev_info *revs, struct strvec *
     +  */
     + static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
     + {
     +-	int i;
     ++	unsigned int i;
     + 	int ref_count = 0;
     + 
     + 	for (i = 0; i < revs->pending.nr; i++) {
     +@@ bundle.c: int create_bundle(struct repository *r, const char *path,
     + 	struct rev_info revs, revs_copy;
     + 	int min_version = 2;
     + 	struct bundle_prerequisites_info bpi;
     +-	int i;
     ++	unsigned int i;
     + 
     + 	/* init revs to list objects for pack-objects later */
     + 	save_commit_buffer = 0;
     +
     + ## cache-tree.c ##
     +@@ cache-tree.c: struct tree* write_in_core_index_as_tree(struct repository *repo) {
     + 
     + 	ret = write_index_as_tree_internal(&o, index_state, was_valid, 0, NULL);
     + 	if (ret == WRITE_TREE_UNMERGED_INDEX) {
     +-		int i;
     ++		unsigned int i;
     + 		bug("there are unmerged index entries:");
     + 		for (i = 0; i < index_state->cache_nr; i++) {
     + 			const struct cache_entry *ce = index_state->cache[i];
     +@@ cache-tree.c: static int verify_one(struct repository *r,
     + 		      struct cache_tree *it,
     + 		      struct strbuf *path)
     + {
     +-	int i, pos, len = path->len;
     ++	int i, pos;
     ++	size_t len = path->len;
     + 	struct strbuf tree_buf = STRBUF_INIT;
     + 	struct object_id new_oid;
     + 
     +@@ cache-tree.c: static int verify_one(struct repository *r,
     + 			 &new_oid);
     + 	if (!oideq(&new_oid, &it->oid))
     + 		BUG("cache-tree for path %.*s does not match. "
     +-		    "Expected %s got %s", len, path->buf,
     +-		    oid_to_hex(&new_oid), oid_to_hex(&it->oid));
     ++		    "Expected %s got %s",
     ++		    (int)len, path->buf, oid_to_hex(&new_oid),
     ++		    oid_to_hex(&it->oid));
     + 	strbuf_setlen(path, len);
     + 	strbuf_release(&tree_buf);
     + 	return 0;
     +
     + ## cache.h ##
     +@@ cache.h: void check_repository_format(struct repository_format *fmt);
     +  */
     + const char *repo_find_unique_abbrev(struct repository *r, const struct object_id *oid, int len);
     + #define find_unique_abbrev(oid, len) repo_find_unique_abbrev(the_repository, oid, len)
     +-int repo_find_unique_abbrev_r(struct repository *r, char *hex, const struct object_id *oid, int len);
     ++unsigned int repo_find_unique_abbrev_r(struct repository *r, char *hex,
     ++				       const struct object_id *oid, int len);
     + #define find_unique_abbrev_r(hex, oid, len) repo_find_unique_abbrev_r(the_repository, hex, oid, len)
     + 
     + /* set default permissions by passing mode arguments to open(2) */
     +@@ cache.h: int repo_interpret_branch_name(struct repository *r,
     + 
     + int validate_headref(const char *ref);
     + 
     +-int base_name_compare(const char *name1, int len1, int mode1, const char *name2, int len2, int mode2);
     +-int df_name_compare(const char *name1, int len1, int mode1, const char *name2, int len2, int mode2);
     ++int base_name_compare(const char *name1, size_t len1, int mode1,
     ++		      const char *name2, size_t len2, int mode2);
     ++int df_name_compare(const char *name1, size_t len1, int mode1,
     ++		    const char *name2, size_t len2, int mode2);
     + int name_compare(const char *name1, size_t len1, const char *name2, size_t len2);
     +-int cache_name_stage_compare(const char *name1, int len1, int stage1, const char *name2, int len2, int stage2);
     ++int cache_name_stage_compare(const char *name1, size_t len1, int stage1,
     ++			     const char *name2, size_t len2, int stage2);
     + 
     + void *read_object_with_reference(struct repository *r,
     + 				 const struct object_id *oid,
     +@@ cache.h: extern const char *askpass_program;
     + extern const char *excludes_file;
     + 
     + /* base85 */
     +-int decode_85(char *dst, const char *line, int linelen);
     +-void encode_85(char *buf, const unsigned char *data, int bytes);
     ++int decode_85(char *dst, const char *line, size_t linelen);
     ++void encode_85(char *buf, const unsigned char *data, size_t bytes);
     + 
     + /* pkt-line.c */
     + void packet_trace_identity(const char *prog);
     +
     + ## chunk-format.c ##
     +@@ chunk-format.c: void add_chunk(struct chunkfile *cf,
     + 
     + int write_chunkfile(struct chunkfile *cf, void *data)
     + {
     +-	int i, result = 0;
     ++	size_t i;
     ++	int result = 0;
     + 	uint64_t cur_offset = hashfile_total(cf->f);
     + 
     + 	trace2_region_enter("chunkfile", "write", the_repository);
     +@@ chunk-format.c: int read_table_of_contents(struct chunkfile *cf,
     + 			   uint64_t toc_offset,
     + 			   int toc_length)
     + {
     +-	int i;
     ++	size_t i;
     + 	uint32_t chunk_id;
     + 	const unsigned char *table_of_contents = mfile + toc_offset;
     + 
     +@@ chunk-format.c: int read_chunk(struct chunkfile *cf,
     + 	       chunk_read_fn fn,
     + 	       void *data)
     + {
     +-	int i;
     ++	size_t i;
     + 
     + 	for (i = 0; i < cf->chunks_nr; i++) {
     + 		if (cf->chunks[i].id == chunk_id)
     +
     + ## color.c ##
     +@@ color.c: struct color {
     +  * "word" is a buffer of length "len"; does it match the NUL-terminated
     +  * "match" exactly?
     +  */
     +-static int match_word(const char *word, int len, const char *match)
     ++static int match_word(const char *word, size_t len, const char *match)
     + {
     + 	return !strncasecmp(word, match, len) && !match[len];
     + }
     +@@ color.c: static int get_hex_color(const char *in, unsigned char *out)
     +  * If an ANSI color is recognized in "name", fill "out" and return 0.
     +  * Otherwise, leave out unchanged and return -1.
     +  */
     +-static int parse_ansi_color(struct color *out, const char *name, int len)
     ++static int parse_ansi_color(struct color *out, const char *name, size_t len)
     + {
     + 	/* Positions in array must match ANSI color codes */
     + 	static const char * const color_names[] = {
     + 		"black", "red", "green", "yellow",
     + 		"blue", "magenta", "cyan", "white"
     + 	};
     +-	int i;
     ++	unsigned int i;
     + 	int color_offset = COLOR_FOREGROUND_ANSI;
     + 
     + 	if (match_word(name, len, "default")) {
     +@@ color.c: static int parse_ansi_color(struct color *out, const char *name, int len)
     + 	return -1;
     + }
     + 
     +-static int parse_color(struct color *out, const char *name, int len)
     ++static int parse_color(struct color *out, const char *name, size_t len)
     + {
     + 	char *end;
     + 	long val;
     +@@ color.c: static int parse_attr(const char *name, size_t len)
     + #undef ATTR
     + 	};
     + 	int negate = 0;
     +-	int i;
     ++	size_t i;
     + 
     + 	if (skip_prefix_mem(name, len, "no", &name, &len)) {
     + 		skip_prefix_mem(name, len, "-", &name, &len);
     +@@ color.c: int color_parse(const char *value, char *dst)
     +  * already have the ANSI escape code in it. "out" should have enough
     +  * space in it to fit any color.
     +  */
     +-static char *color_output(char *out, int len, const struct color *c, int background)
     ++static char *color_output(char *out, size_t len, const struct color *c,
     ++			  int background)
     + {
     + 	int offset = 0;
     + 
     +@@ color.c: static int color_empty(const struct color *c)
     + 	return c->type <= COLOR_NORMAL;
     + }
     + 
     +-int color_parse_mem(const char *value, int value_len, char *dst)
     ++int color_parse_mem(const char *value, size_t value_len, char *dst)
     + {
     + 	const char *ptr = value;
     +-	int len = value_len;
     ++	size_t len = value_len;
     + 	char *end = dst + COLOR_MAXLEN;
     +-	unsigned int has_reset = 0;
     ++	int has_reset = 0;
     + 	unsigned int attr = 0;
     + 	struct color fg = { COLOR_UNSPECIFIED };
     + 	struct color bg = { COLOR_UNSPECIFIED };
     + 
     +-	while (len > 0 && isspace(*ptr)) {
     ++	while (len && isspace(*ptr)) {
     + 		ptr++;
     + 		len--;
     + 	}
     +@@ color.c: int color_parse_mem(const char *value, int value_len, char *dst)
     + 	}
     + 
     + 	/* [reset] [fg [bg]] [attr]... */
     +-	while (len > 0) {
     ++	while (len) {
     + 		const char *word = ptr;
     + 		struct color c = { COLOR_UNSPECIFIED };
     +-		int val, wordlen = 0;
     ++		int val;
     ++		size_t wordlen = 0;
     + 
     + 		while (len > 0 && !isspace(word[wordlen])) {
     + 			wordlen++;
     +@@ color.c: int color_parse_mem(const char *value, int value_len, char *dst)
       
       	if (has_reset || attr || !color_empty(&fg) || !color_empty(&bg)) {
       		int sep = 0;
     @@ column.c: static void display_table(const struct string_list *list,
       	char *empty_cell;
       
       	memset(&data, 0, sizeof(data));
     +@@ column.c: static int parse_option(const char *arg, int len, unsigned int *colopts,
     + 		{ "row",    COL_ROW,      COL_LAYOUT_MASK },
     + 		{ "dense",  COL_DENSE,    0 },
     + 	};
     +-	int i;
     ++	size_t i;
     + 
     + 	for (i = 0; i < ARRAY_SIZE(opts); i++) {
     + 		int set = 1, arg_len = len, name_len;
     +
     + ## combine-diff.c ##
     +@@ combine-diff.c: static struct combine_diff_path *intersect_paths(
     + 
     + 	if (!n) {
     + 		for (i = 0; i < q->nr; i++) {
     +-			int len;
     ++			size_t len;
     + 			const char *path;
     + 			if (diff_unmodified_pair(q->queue[i]))
     + 				continue;
     +@@ combine-diff.c: static struct lline *coalesce_lines(struct lline *base, int *lenbase,
     + 	/* At this point, baseend and newend point to the end of each lists */
     + 	i--;
     + 	j--;
     +-	while (i != 0 || j != 0) {
     ++	while (i > 0 || j > 0) {
     + 		if (directions[i][j] == MATCH) {
     + 			baseend->parent_map |= 1<<parent;
     + 			baseend = baseend->prev;
     +
     + ## commit-graph.c ##
     +@@ commit-graph.c: static struct commit_graph *load_commit_graph_chain(struct repository *r,
     + 	struct strbuf line = STRBUF_INIT;
     + 	struct stat st;
     + 	struct object_id *oids;
     +-	int i = 0, valid = 1, count;
     ++	int i, valid = 1, count;
     + 	char *chain_name = get_commit_graph_chain_filename(odb);
     + 	FILE *fp;
     + 	int stat_res;
     +@@ commit-graph.c: static int write_graph_chunk_fanout(struct hashfile *f,
     + 				    void *data)
     + {
     + 	struct write_commit_graph_context *ctx = data;
     +-	int i, count = 0;
     ++	unsigned int i;
     ++	uint32_t count = 0;
     + 	struct commit **list = ctx->commits.list;
     + 
     + 	/*
     +@@ commit-graph.c: static int write_graph_chunk_generation_data(struct hashfile *f,
     + 					     void *data)
     + {
     + 	struct write_commit_graph_context *ctx = data;
     +-	int i, num_generation_data_overflows = 0;
     ++	size_t i, num_generation_data_overflows = 0;
     + 
     + 	for (i = 0; i < ctx->commits.nr; i++) {
     + 		struct commit *c = ctx->commits.list[i];
     +@@ commit-graph.c: static int write_graph_chunk_generation_data_overflow(struct hashfile *f,
     + 						      void *data)
     + {
     + 	struct write_commit_graph_context *ctx = data;
     +-	int i;
     ++	size_t i;
     + 	for (i = 0; i < ctx->commits.nr; i++) {
     + 		struct commit *c = ctx->commits.list[i];
     + 		timestamp_t offset = commit_graph_data_at(c)->generation - c->date;
     +@@ commit-graph.c: static void add_missing_parents(struct write_commit_graph_context *ctx, struct c
     + 
     + static void close_reachable(struct write_commit_graph_context *ctx)
     + {
     +-	int i;
     ++	size_t i;
     + 	struct commit *commit;
     + 	enum commit_graph_split_flags flags = ctx->opts ?
     + 		ctx->opts->split_flags : COMMIT_GRAPH_SPLIT_UNSPECIFIED;
     +@@ commit-graph.c: static void close_reachable(struct write_commit_graph_context *ctx)
     + 
     + static void compute_topological_levels(struct write_commit_graph_context *ctx)
     + {
     +-	int i;
     ++	size_t i;
     + 	struct commit_list *list = NULL;
     + 
     + 	if (ctx->report_progress)
     +@@ commit-graph.c: static void compute_topological_levels(struct write_commit_graph_context *ctx)
     + 
     + static void compute_generation_numbers(struct write_commit_graph_context *ctx)
     + {
     +-	int i;
     ++	size_t i;
     + 	struct commit_list *list = NULL;
     + 
     + 	if (ctx->report_progress)
     +@@ commit-graph.c: static void trace2_bloom_filter_write_statistics(struct write_commit_graph_conte
     + 
     + static void compute_bloom_filters(struct write_commit_graph_context *ctx)
     + {
     +-	int i;
     ++	size_t i;
     + 	struct progress *progress = NULL;
     + 	struct commit **sorted_commits;
     +-	int max_new_filters;
     ++	size_t max_new_filters;
     + 
     + 	init_bloom_filters();
     + 
     +
     + ## commit-reach.c ##
     +@@ commit-reach.c: int can_all_from_reach_with_flag(struct object_array *from,
     + 				 timestamp_t min_generation)
     + {
     + 	struct commit **list = NULL;
     +-	int i;
     ++	unsigned int i;
     ++	int j;
     + 	int nr_commits;
     + 	int result = 1;
     + 
     +@@ commit-reach.c: int can_all_from_reach_with_flag(struct object_array *from,
     + 
     + 	QSORT(list, nr_commits, compare_commits_by_gen);
     + 
     +-	for (i = 0; i < nr_commits; i++) {
     ++	for (j = 0; j < nr_commits; j++) {
     + 		/* DFS from list[i] */
     + 		struct commit_list *stack = NULL;
     + 
     +-		list[i]->object.flags |= assign_flag;
     +-		commit_list_insert(list[i], &stack);
     ++		list[j]->object.flags |= assign_flag;
     ++		commit_list_insert(list[j], &stack);
     + 
     + 		while (stack) {
     + 			struct commit_list *parent;
     +@@ commit-reach.c: int can_all_from_reach_with_flag(struct object_array *from,
     + 				pop_commit(&stack);
     + 		}
     + 
     +-		if (!(list[i]->object.flags & (with_flag | RESULT))) {
     ++		if (!(list[j]->object.flags & (with_flag | RESULT))) {
     + 			result = 0;
     + 			goto cleanup;
     + 		}
     +
     + ## commit.c ##
     +@@ commit.c: int parse_commit_buffer(struct repository *r, struct commit *item, const void *b
     + 	struct object_id parent;
     + 	struct commit_list **pptr;
     + 	struct commit_graft *graft;
     +-	const int tree_entry_len = the_hash_algo->hexsz + 5;
     +-	const int parent_entry_len = the_hash_algo->hexsz + 7;
     ++	const size_t tree_entry_len = the_hash_algo->hexsz + 5;
     ++	const size_t parent_entry_len = the_hash_algo->hexsz + 7;
     + 	struct tree *tree;
     + 
     + 	if (item->object.parsed)
     +@@ commit.c: int remove_signature(struct strbuf *buf)
     + 		if (in_signature && line[0] == ' ')
     + 			sigp->end = next;
     + 		else if (starts_with(line, "gpgsig")) {
     +-			int i;
     ++			unsigned int i;
     + 			for (i = 1; i < GIT_HASH_NALGOS; i++) {
     + 				const char *p;
     + 				if (skip_prefix(line, gpg_sig_headers[i], &p) &&
      
       ## compat/compiler.h ##
      @@
     @@ compat/compiler.h: static inline void get_compiler_info(struct strbuf *info)
      +		    _MSC_VER % 100, _MSC_FULL_VER % 100000);
       #endif
       
     - 	if (len == info->len)
     -@@ compat/compiler.h: static inline void get_compiler_info(struct strbuf *info)
     + 	if (len == info->len)
     +@@ compat/compiler.h: static inline void get_compiler_info(struct strbuf *info)
     + 
     + static inline void get_libc_info(struct strbuf *info)
     + {
     +-	int len = info->len;
     ++	size_t len = info->len;
     + 
     + #ifdef __GLIBC__
     + 	strbuf_addf(info, "glibc: %s\n", gnu_get_libc_version());
     +
     + ## compat/strcasestr.c ##
     +@@
     + 
     + char *gitstrcasestr(const char *haystack, const char *needle)
     + {
     +-	int nlen = strlen(needle);
     +-	int hlen = strlen(haystack) - nlen + 1;
     +-	int i;
     ++	size_t nlen = strlen(needle);
     ++	size_t hlen = strlen(haystack) - nlen + 1;
     ++	size_t i;
     + 
     + 	for (i = 0; i < hlen; i++) {
     +-		int j;
     ++		size_t j;
     + 		for (j = 0; j < nlen; j++) {
     + 			unsigned char c1 = haystack[i+j];
     + 			unsigned char c2 = needle[j];
     +-			if (toupper(c1) != toupper(c2))
     ++			if (tolower(c1) != tolower(c2))
     + 				goto next;
     + 		}
     + 		return (char *) haystack + i;
     +
     + ## compat/unsetenv.c ##
     +@@ compat/unsetenv.c: int gitunsetenv(const char *name)
     + #if !defined(__MINGW32__)
     +      extern char **environ;
     + #endif
     +-     int src, dst;
     ++     size_t src, dst;
     +      size_t nmln;
     + 
     +      nmln = strlen(name);
     +
     + ## compat/winansi.c ##
     +@@ compat/winansi.c: static void erase_in_line(void)
     + 		&dummy);
     + }
     + 
     +-static void set_attr(char func, const int *params, int paramlen)
     ++static void set_attr(char func, const int *params, size_t paramlen)
     + {
     +-	int i;
     ++	size_t i;
     + 	switch (func) {
     + 	case 'm':
     + 		for (i = 0; i < paramlen; i++) {
     +@@ compat/winansi.c: static DWORD WINAPI console_thread(LPVOID unused)
     + {
     + 	unsigned char buffer[BUFFER_SIZE];
     + 	DWORD bytes;
     +-	int start, end = 0, c, parampos = 0, state = TEXT;
     ++	int start, end = 0, c, state = TEXT;
     ++	size_t parampos = 0;
     + 	int params[MAX_PARAMS];
     + 
     + 	while (1) {
     +
     + ## config.c ##
     +@@ config.c: int git_config_from_parameters(config_fn_t fn, void *data)
     + 	if (env) {
     + 		unsigned long count;
     + 		char *endp;
     +-		int i;
     ++		unsigned long i;
     + 
     + 		count = strtoul(env, &endp, 10);
     + 		if (*endp) {
     +@@ config.c: int git_config_from_parameters(config_fn_t fn, void *data)
     + 		for (i = 0; i < count; i++) {
     + 			const char *key, *value;
     + 
     +-			strbuf_addf(&envvar, "GIT_CONFIG_KEY_%d", i);
     ++			strbuf_addf(&envvar, "GIT_CONFIG_KEY_%lu", i);
     + 			key = getenv_safe(&to_free, envvar.buf);
     + 			if (!key) {
     + 				ret = error(_("missing config key %s"), envvar.buf);
     +@@ config.c: int git_config_from_parameters(config_fn_t fn, void *data)
     + 			}
     + 			strbuf_reset(&envvar);
     + 
     +-			strbuf_addf(&envvar, "GIT_CONFIG_VALUE_%d", i);
     ++			strbuf_addf(&envvar, "GIT_CONFIG_VALUE_%lu", i);
     + 			value = getenv_safe(&to_free, envvar.buf);
     + 			if (!value) {
     + 				ret = error(_("missing config value %s"), envvar.buf);
     +@@ config.c: static enum fsync_component parse_fsync_components(const char *var, const char *
     + 	enum fsync_component positive = 0, negative = 0;
     + 
     + 	while (string) {
     +-		int i;
     ++		size_t i;
     + 		size_t len;
     + 		const char *ep;
     + 		int negated = 0;
     +@@ config.c: int config_with_options(config_fn_t fn, void *data,
     + 
     + static void configset_iter(struct config_set *cs, config_fn_t fn, void *data)
     + {
     +-	int i, value_index;
     ++	unsigned int i;
     ++	size_t value_index;
     + 	struct string_list *values;
     + 	struct config_set_element *entry;
     + 	struct configset_list *list = &cs->list;
     +@@ config.c: static ssize_t write_section(int fd, const char *key,
     + static ssize_t write_pair(int fd, const char *key, const char *value,
     + 			  const struct config_store_data *store)
     + {
     +-	int i;
     ++	size_t i;
     + 	ssize_t ret;
     + 	const char *quote = "";
     + 	struct strbuf sb = STRBUF_INIT;
     +@@ config.c: static ssize_t write_pair(int fd, const char *key, const char *value,
     +  */
     + static void maybe_remove_section(struct config_store_data *store,
     + 				 size_t *begin_offset, size_t *end_offset,
     +-				 int *seen_ptr)
     ++				 unsigned int *seen_ptr)
     + {
     + 	size_t begin;
     +-	int i, seen, section_seen = 0;
     ++	unsigned int i;
     ++	unsigned int seen;
     ++	int section_seen = 0;
     + 
     + 	/*
     + 	 * First, ensure that this is the first key, and that there are no
     + 	 * comments before the entry nor before the section header.
     + 	 */
     + 	seen = *seen_ptr;
     +-	for (i = store->seen[seen]; i > 0; i--) {
     ++	for (i = store->seen[seen]; i; i--) {
     + 		enum config_event_t type = store->parsed[i - 1].type;
     + 
     + 		if (type == CONFIG_EVENT_COMMENT)
     +@@ config.c: int git_config_set_multivar_in_file_gently(const char *config_filename,
     + 	} else {
     + 		struct stat st;
     + 		size_t copy_begin, copy_end;
     +-		int i, new_line = 0;
     ++		unsigned int i;
     ++		int new_line = 0;
     + 		struct config_options opts;
     + 
     + 		if (!value_pattern)
     +@@ config.c: int git_config_set_multivar_in_file_gently(const char *config_filename,
     + 
     + 		for (i = 0, copy_begin = 0; i < store.seen_nr; i++) {
     + 			size_t replace_end;
     +-			int j = store.seen[i];
     ++			unsigned int j = store.seen[i];
     + 
     + 			new_line = 0;
     + 			if (!store.key_seen) {
     +@@ config.c: void git_config_set_multivar(const char *key, const char *value,
     + 					flags);
     + }
     + 
     +-static int section_name_match (const char *buf, const char *name)
     ++static unsigned int section_name_match(const char *buf, const char *name)
     + {
     +-	int i = 0, j = 0, dot = 0;
     ++	unsigned int i = 0, j = 0;
     ++	int dot = 0;
     + 	if (buf[i] != '[')
     + 		return 0;
     + 	for (i = 1; buf[i] && buf[i] != ']'; i++) {
     +
     + ## config.h ##
     +@@ config.h: struct config_set_element {
     + 
     + struct configset_list_item {
     + 	struct config_set_element *e;
     +-	int value_index;
     ++	size_t value_index;
     + };
     + 
     + /*
     +
     + ## connect.c ##
     +@@ connect.c: static int process_ref_v2(struct packet_reader *reader, struct ref ***list,
     + 			  const char **unborn_head_target)
     + {
     + 	int ret = 1;
     +-	int i = 0;
     ++	size_t i;
     + 	struct object_id old_oid;
     + 	struct ref *ref;
     + 	struct string_list line_sections = STRING_LIST_INIT_DUP;
     +@@ connect.c: static int process_ref_v2(struct packet_reader *reader, struct ref ***list,
     + 		goto out;
     + 	}
     + 
     +-	if (!strcmp("unborn", line_sections.items[i].string)) {
     +-		i++;
     ++	if (!strcmp("unborn", line_sections.items[0].string)) {
     + 		if (unborn_head_target &&
     +-		    !strcmp("HEAD", line_sections.items[i++].string)) {
     ++		    !strcmp("HEAD", line_sections.items[1].string)) {
     + 			/*
     + 			 * Look for the symref target (if any). If found,
     + 			 * return it to the caller.
     + 			 */
     +-			for (; i < line_sections.nr; i++) {
     ++			for (i = 2; i < line_sections.nr; i++) {
     + 				const char *arg = line_sections.items[i].string;
     + 
     + 				if (skip_prefix(arg, "symref-target:", &arg)) {
     +@@ connect.c: static int process_ref_v2(struct packet_reader *reader, struct ref ***list,
     + 		}
     + 		goto out;
     + 	}
     +-	if (parse_oid_hex_algop(line_sections.items[i++].string, &old_oid, &end, reader->hash_algo) ||
     ++	if (parse_oid_hex_algop(line_sections.items[0].string, &old_oid, &end,
     ++				reader->hash_algo) ||
     + 	    *end) {
     + 		ret = 0;
     + 		goto out;
     + 	}
     + 
     +-	ref = alloc_ref(line_sections.items[i++].string);
     ++	ref = alloc_ref(line_sections.items[1].string);
     + 
     + 	memcpy(ref->old_oid.hash, old_oid.hash, reader->hash_algo->rawsz);
     + 	**list = ref;
     + 	*list = &ref->next;
     + 
     +-	for (; i < line_sections.nr; i++) {
     ++	for (i = 2; i < line_sections.nr; i++) {
     + 		const char *arg = line_sections.items[i].string;
     + 		if (skip_prefix(arg, "symref-target:", &arg))
     + 			ref->symref = xstrdup(arg);
     +@@ connect.c: struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
     + 			     const struct string_list *server_options,
     + 			     int stateless_rpc)
     + {
     +-	int i;
     ++	size_t i;
     + 	struct strvec *ref_prefixes = transport_options ?
     + 		&transport_options->ref_prefixes : NULL;
     + 	const char **unborn_head_target = transport_options ?
     +
     + ## convert.c ##
     +@@ convert.c: static void trace_encoding(const char *context, const char *path,
     + {
     + 	static struct trace_key coe = TRACE_KEY_INIT(WORKING_TREE_ENCODING);
     + 	struct strbuf trace = STRBUF_INIT;
     +-	int i;
     ++	size_t i;
     + 
     + 	strbuf_addf(&trace, "%s (%s, considered %s):\n", context, path, encoding);
     + 	for (i = 0; i < len && buf; ++i) {
     +-		strbuf_addf(
     +-			&trace, "| \033[2m%2i:\033[0m %2x \033[2m%c\033[0m%c",
     +-			i,
     +-			(unsigned char) buf[i],
     +-			(buf[i] > 32 && buf[i] < 127 ? buf[i] : ' '),
     +-			((i+1) % 8 && (i+1) < len ? ' ' : '\n')
     +-		);
     ++		strbuf_addf(&trace,
     ++			    "| \033[2m%2u:\033[0m %2x \033[2m%c\033[0m%c",
     ++			    (unsigned int)i, (unsigned char)buf[i],
     ++			    (buf[i] > 32 && buf[i] < 127 ? buf[i] : ' '),
     ++			    ((i + 1) % 8 && (i + 1) < len ? ' ' : '\n'));
     + 	}
     + 	strbuf_addchars(&trace, '\n', 1);
     + 
     +@@ convert.c: struct ident_filter {
     + 
     + static int is_foreign_ident(const char *str)
     + {
     +-	int i;
     ++	size_t i;
     + 
     + 	if (!skip_prefix(str, "$Id: ", &str))
     + 		return 0;
     +
     + ## credential.c ##
     +@@ credential.c: static int credential_do(struct credential *c, const char *helper,
     + 
     + void credential_fill(struct credential *c)
     + {
     +-	int i;
     ++	size_t i;
     + 
     + 	if (c->username && c->password)
     + 		return;
     +@@ credential.c: void credential_fill(struct credential *c)
     + 
     + void credential_approve(struct credential *c)
     + {
     +-	int i;
     ++	size_t i;
       
     - static inline void get_libc_info(struct strbuf *info)
     + 	if (c->approved)
     + 		return;
     +@@ credential.c: void credential_approve(struct credential *c)
     + 
     + void credential_reject(struct credential *c)
       {
     --	int len = info->len;
     -+	size_t len = info->len;
     +-	int i;
     ++	size_t i;
     + 
     + 	credential_apply_config(c);
       
     - #ifdef __GLIBC__
     - 	strbuf_addf(info, "glibc: %s\n", gnu_get_libc_version());
      
       ## daemon.c ##
      @@ daemon.c: static struct daemon_service daemon_service[] = {
     @@ daemon.c: static void set_keep_alive(int sockfd)
       	char *addr = getenv("REMOTE_ADDR"), *port = getenv("REMOTE_PORT");
       	struct hostinfo hi = HOSTINFO_INIT;
       	struct strvec env = STRVEC_INIT;
     +@@ daemon.c: static void socksetup(struct string_list *listen_addr, int listen_port, struct s
     + 	if (!listen_addr->nr)
     + 		setup_named_sock(NULL, listen_port, socklist);
     + 	else {
     +-		int i, socknum;
     ++		size_t i;
     ++		int socknum;
     + 		for (i = 0; i < listen_addr->nr; i++) {
     + 			socknum = setup_named_sock(listen_addr->items[i].string,
     + 						   listen_port, socklist);
      @@ daemon.c: static int service_loop(struct socketlist *socklist)
       	signal(SIGCHLD, child_handler);
       
     @@ daemon.c: static int service_loop(struct socketlist *socklist)
       		check_dead_children();
       
      
     + ## date.c ##
     +@@ date.c: static const struct {
     + 
     + static int match_string(const char *date, const char *str)
     + {
     +-	int i = 0;
     ++	int i;
     + 
     + 	for (i = 0; *date; date++, str++, i++) {
     + 		if (*date == *str)
     + 			continue;
     +-		if (toupper(*date) == toupper(*str))
     ++		if (tolower(*date) == tolower(*str))
     + 			continue;
     + 		if (!isalnum(*date))
     + 			break;
     +
     + ## decorate.c ##
     +@@ decorate.c: static void *insert_decoration(struct decoration *n, const struct object *base,
     + 
     + static void grow_decoration(struct decoration *n)
     + {
     +-	int i;
     +-	int old_size = n->size;
     ++	unsigned int i;
     ++	unsigned int old_size = n->size;
     + 	struct decoration_entry *old_entries = n->entries;
     + 
     + 	n->size = (old_size + 1000) * 3 / 2;
     +@@ decorate.c: static void grow_decoration(struct decoration *n)
     + void *add_decoration(struct decoration *n, const struct object *obj,
     + 		void *decoration)
     + {
     +-	int nr = n->nr + 1;
     ++	unsigned int nr = n->nr + 1;
     + 
     + 	if (nr > n->size * 2 / 3)
     + 		grow_decoration(n);
     +
     + ## delta-islands.c ##
     +@@ delta-islands.c: void resolve_tree_islands(struct repository *r,
     + {
     + 	struct progress *progress_state = NULL;
     + 	struct tree_islands_todo *todo;
     +-	int nr = 0;
     +-	int i;
     ++	uint32_t nr = 0;
     ++	uint32_t i;
     + 
     + 	if (!island_marks)
     + 		return;
     +@@ delta-islands.c: static const char *core_island_name;
     + 
     + static void free_config_regexes(struct island_load_data *ild)
     + {
     +-	for (size_t i = 0; i < ild->nr; i++)
     ++	size_t i;
     ++	for (i = 0; i < ild->nr; i++)
     + 		regfree(&ild->rx[i]);
     + 	free(ild->rx);
     + }
     +@@ delta-islands.c: static int find_island_for_ref(const char *refname, const struct object_id *oid,
     + 	 * than we support.
     + 	 */
     + 	regmatch_t matches[16];
     +-	int i, m;
     ++	int i;
     ++	size_t m;
     + 	struct strbuf island_name = STRBUF_INIT;
     + 
     + 	/* walk backwards to get last-one-wins ordering */
     +
     + ## diagnose.c ##
     +@@ diagnose.c: static struct diagnose_option diagnose_options[] = {
     + 
     + int option_parse_diagnose(const struct option *opt, const char *arg, int unset)
     + {
     +-	int i;
     ++	size_t i;
     + 	enum diagnose_mode *diagnose = opt->value;
     + 
     + 	if (!arg) {
     +
     + ## diff-lib.c ##
     +@@ diff-lib.c: static int diff_cache(struct rev_info *revs,
     + 
     + void diff_get_merge_base(const struct rev_info *revs, struct object_id *mb)
     + {
     +-	int i;
     ++	unsigned int i;
     + 	struct commit *mb_child[2] = {0};
     + 	struct commit_list *merge_bases;
     + 
     +
     + ## diff-no-index.c ##
     +@@ diff-no-index.c: int diff_no_index(struct rev_info *revs,
     + 		  int implicit_no_index,
     + 		  int argc, const char **argv)
     + {
     +-	int i, no_index;
     ++	unsigned int i;
     ++	int no_index;
     + 	int ret = 1;
     + 	const char *paths[2];
     + 	char *to_free[ARRAY_SIZE(paths)] = { 0 };
     +
       ## diff.c ##
     +@@ diff.c: static int parse_dirstat_params(struct diff_options *options, const char *params
     + 	char *params_copy = xstrdup(params_string);
     + 	struct string_list params = STRING_LIST_INIT_NODUP;
     + 	int ret = 0;
     +-	int i;
     ++	size_t i;
     + 
     + 	if (*params_copy)
     + 		string_list_split_in_place(&params, params_copy, ',', -1);
     +@@ diff.c: static void emit_hunk_header(struct emit_callback *ecbdata,
     + 
     + static struct diff_tempfile *claim_diff_tempfile(void)
     + {
     +-	int i;
     ++	size_t i;
     + 	for (i = 0; i < ARRAY_SIZE(diff_temp); i++)
     + 		if (!diff_temp[i].name)
     + 			return diff_temp + i;
     +@@ diff.c: static struct diff_tempfile *claim_diff_tempfile(void)
     + 
     + static void remove_tempfile(void)
     + {
     +-	int i;
     ++	size_t i;
     + 	for (i = 0; i < ARRAY_SIZE(diff_temp); i++) {
     + 		if (is_tempfile_active(diff_temp[i].tempfile))
     + 			delete_tempfile(&diff_temp[i].tempfile);
     +@@ diff.c: static void fn_out_diff_words_aux(void *priv,
     + 
     + /* This function starts looking at *begin, and returns 0 iff a word was found. */
     + static int find_word_boundaries(mmfile_t *buffer, regex_t *word_regex,
     +-		int *begin, int *end)
     ++				long *begin, long *end)
     + {
     + 	while (word_regex && *begin < buffer->size) {
     + 		regmatch_t match[1];
     +@@ diff.c: static int find_word_boundaries(mmfile_t *buffer, regex_t *word_regex,
     + static void diff_words_fill(struct diff_words_buffer *buffer, mmfile_t *out,
     + 		regex_t *word_regex)
     + {
     +-	int i, j;
     ++	long i, j;
     + 	long alloc = 0;
     + 
     + 	out->size = 0;
     +@@ diff.c: static void init_diff_words_data(struct emit_callback *ecbdata,
     + 				 struct diff_filespec *one,
     + 				 struct diff_filespec *two)
     + {
     +-	int i;
     ++	size_t i;
     + 	struct diff_options *o = xmalloc(sizeof(struct diff_options));
     + 	memcpy(o, orig_opts, sizeof(struct diff_options));
     + 
      @@ diff.c: static void emit_binary_diff_body(struct diff_options *o,
       	/* emit data encoded in base85 */
       	cp = data;
     @@ diff.c: static void emit_binary_diff_body(struct diff_options *o,
       		char line[71];
       		data_size -= bytes;
       		if (bytes <= 26)
     +@@ diff.c: static void add_formatted_headers(struct strbuf *msg,
     + 				  const char *meta,
     + 				  const char *reset)
     + {
     +-	int i;
     ++	size_t i;
     + 
     + 	for (i = 0; i < more_headers->nr; i++)
     + 		add_formatted_header(msg, more_headers->items[i].string,
     +@@ diff.c: static unsigned int filter_bit['Z' + 1];
     + 
     + static void prepare_filter_bits(void)
     + {
     +-	int i;
     ++	unsigned int i;
     + 
     + 	if (!filter_bit[DIFF_STATUS_ADDED]) {
     + 		for (i = 0; diff_status_letters[i]; i++)
     +@@ diff.c: static int diff_opt_diff_filter(const struct option *option,
     + 				const char *optarg, int unset)
     + {
     + 	struct diff_options *opt = option->value;
     +-	int i, optch;
     ++	size_t i;
     ++	int optch;
     + 
     + 	BUG_ON_OPT_NEG(unset);
     + 	prepare_filter_bits();
     +@@ diff.c: static int diff_opt_patience(const struct option *opt,
     + 			     const char *arg, int unset)
     + {
     + 	struct diff_options *options = opt->value;
     +-	int i;
     ++	size_t i;
     + 
     + 	BUG_ON_OPT_NEG(unset);
     + 	BUG_ON_OPT_ARG(arg);
     +@@ diff.c: static void diff_summary(struct diff_options *opt, struct diff_filepair *p)
     + 
     + struct patch_id_t {
     + 	git_hash_ctx *ctx;
     +-	int patchlen;
     ++	size_t patchlen;
     + };
     + 
     +-static int remove_space(char *line, int len)
     ++static size_t remove_space(char *line, unsigned long len)
     + {
     +-	int i;
     ++	unsigned long i;
     + 	char *dst = line;
     + 	unsigned char c;
     + 
     +@@ diff.c: void flush_one_hunk(struct object_id *result, git_hash_ctx *ctx)
     + static int patch_id_consume(void *priv, char *line, unsigned long len)
     + {
     + 	struct patch_id_t *data = priv;
     +-	int new_len;
     ++	size_t new_len;
     + 
     + 	if (len > 12 && starts_with(line, "\\ "))
     + 		return 0;
     +@@ diff.c: static int diff_get_patch_id(struct diff_options *options, struct object_id *oid
     + 		xdemitconf_t xecfg;
     + 		mmfile_t mf1, mf2;
     + 		struct diff_filepair *p = q->queue[i];
     +-		int len1, len2;
     ++		size_t len1, len2;
     + 
     + 		memset(&xpp, 0, sizeof(xpp));
     + 		memset(&xecfg, 0, sizeof(xecfg));
      
       ## dir.c ##
      @@ dir.c: static void emit_traversal_statistics(struct dir_struct *dir,
     @@ dir.c: static void emit_traversal_statistics(struct dir_struct *dir,
       
       int read_directory(struct dir_struct *dir, struct index_state *istate,
      -		   const char *path, int len, const struct pathspec *pathspec)
     -+		   const char *path, unsigned int len, const struct pathspec *pathspec)
     ++		   const char *path, unsigned int len,
     ++		   const struct pathspec *pathspec)
       {
       	struct untracked_cache_dir *untracked;
       
     @@ fsck.c: static void prepare_msg_ids(void)
       
       		msg_id_info[i].downcased = q;
      
     + ## git.c ##
     +@@ git.c: static void list_builtins(struct string_list *list, unsigned int exclude_option)
     + 
     + static void exclude_helpers_from_list(struct string_list *list)
     + {
     +-	int i = 0;
     ++	size_t i = 0;
     + 
     + 	while (i < list->nr) {
     + 		if (strstr(list->items[i].string, "--"))
     +
       ## list-objects-filter-options.c ##
      @@ list-objects-filter-options.c: void list_objects_filter_copy(
       	struct list_objects_filter_options *dest,
     @@ list-objects-filter-options.c: void list_objects_filter_copy(
       	memcpy(dest, src, sizeof(struct list_objects_filter_options));
      
       ## merge-recursive.c ##
     +@@ merge-recursive.c: static int was_dirty(struct merge_options *opt, const char *path)
     + 
     + static int make_room_for_path(struct merge_options *opt, const char *path)
     + {
     +-	int status, i;
     ++	int status;
     ++	size_t i;
     + 	const char *msg = _("failed to create path '%s'%s");
     + 
     + 	/* Unlink any D/F conflict files that are in the way */
      @@ merge-recursive.c: static struct commit *get_ref(struct repository *repo,
       int merge_recursive_generic(struct merge_options *opt,
       			    const struct object_id *head,
     @@ notes.c: void string_list_add_refs_from_colon_sep(struct string_list *list,
       	string_list_split_in_place(&split, globs_copy, ':', -1);
       	string_list_remove_empty_items(&split, 0);
      
     + ## object-name.c ##
     +@@ object-name.c: static void find_abbrev_len_packed(struct min_abbrev_data *mad)
     + 		find_abbrev_len_for_pack(p, mad);
     + }
     + 
     +-int repo_find_unique_abbrev_r(struct repository *r, char *hex,
     +-			      const struct object_id *oid, int len)
     ++unsigned int repo_find_unique_abbrev_r(struct repository *r, char *hex,
     ++				       const struct object_id *oid, int len)
     + {
     + 	struct disambiguate_state ds;
     + 	struct min_abbrev_data mad;
     +@@ object-name.c: const char *repo_find_unique_abbrev(struct repository *r,
     + 				    const struct object_id *oid,
     + 				    int len)
     + {
     +-	static int bufno;
     ++	static unsigned int bufno;
     + 	static char hexbuffer[4][GIT_MAX_HEXSZ + 1];
     + 	char *hex = hexbuffer[bufno];
     + 	bufno = (bufno + 1) % ARRAY_SIZE(hexbuffer);
     +
       ## range-diff.c ##
      @@ range-diff.c: static int read_patches(const char *range, struct string_list *list,
       	struct patch_util *util = NULL;
     @@ run-command.c: static void pp_buffer_stderr(struct parallel_processes *pp,
       				close(pp->children[i].process.err);
       				pp->children[i].state = GIT_CP_WAIT_CLEANUP;
      
     + ## shallow.c ##
     +@@ shallow.c: static void post_assign_shallow(struct shallow_info *info,
     + }
     + 
     + /* (Delayed) step 7, reachability test at commit level */
     +-int delayed_reachability_test(struct shallow_info *si, int c)
     ++int delayed_reachability_test(struct shallow_info *si, size_t c)
     + {
     + 	if (si->need_reachability_test[c]) {
     + 		struct commit *commit = lookup_commit(the_repository,
     +
     + ## shallow.h ##
     +@@ shallow.h: void remove_nonexistent_theirs_shallow(struct shallow_info *);
     + void assign_shallow_commits_to_refs(struct shallow_info *info,
     + 				    uint32_t **used,
     + 				    int *ref_status);
     +-int delayed_reachability_test(struct shallow_info *si, int c);
     ++int delayed_reachability_test(struct shallow_info *si, size_t c);
     + 
     + extern struct trace_key trace_shallow;
     + 
     +
       ## strbuf.c ##
      @@ strbuf.c: struct strbuf **strbuf_split_buf(const char *str, size_t slen,
       	struct strbuf *t;
     @@ strbuf.c: struct strbuf **strbuf_split_buf(const char *str, size_t slen,
       		if (max <= 0 || nr + 1 < max) {
       			const char *end = memchr(str, terminator, slen);
       			if (end)
     +@@ strbuf.c: void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm,
     + void strbuf_repo_add_unique_abbrev(struct strbuf *sb, struct repository *repo,
     + 				   const struct object_id *oid, int abbrev_len)
     + {
     +-	int r;
     ++	unsigned int r;
     + 	strbuf_grow(sb, GIT_MAX_HEXSZ + 1);
     + 	r = repo_find_unique_abbrev_r(repo, sb->buf + sb->len, oid, abbrev_len);
     + 	strbuf_setlen(sb, sb->len + r);
     +
     + ## string-list.c ##
     +@@ string-list.c: int unsorted_string_list_has_string(struct string_list *list,
     + 	return unsorted_string_list_lookup(list, string) != NULL;
     + }
     + 
     +-void unsorted_string_list_delete_item(struct string_list *list, int i, int free_util)
     ++void unsorted_string_list_delete_item(struct string_list *list, size_t i,
     ++				      int free_util)
     + {
     + 	if (list->strdup_strings)
     + 		free(list->items[i].string);
      
     - ## strvec.h ##
     -@@ strvec.h: extern const char *empty_strvec[];
     + ## string-list.h ##
     +@@ string-list.h: struct string_list_item *unsorted_string_list_lookup(struct string_list *list,
     +  * string_list is set. The third parameter controls if the `util`
     +  * pointer of the items should be freed or not.
        */
     - struct strvec {
     - 	const char **v;
     --	size_t nr;
     -+	int nr;
     - 	size_t alloc;
     - };
     +-void unsorted_string_list_delete_item(struct string_list *list, int i, int free_util);
     ++void unsorted_string_list_delete_item(struct string_list *list, size_t i,
     ++				      int free_util);
     + 
     + /**
     +  * Split string into substrings on character `delim` and append the
     +
     + ## sub-process.c ##
     +@@ sub-process.c: static int handshake_version(struct child_process *process,
     + 			     int *chosen_version)
     + {
     + 	int version_scratch;
     +-	int i;
     ++	size_t i;
     + 	char *line;
     + 	const char *p;
     + 
     +@@ sub-process.c: static int handshake_capabilities(struct child_process *process,
     + 				  struct subprocess_capability *capabilities,
     + 				  unsigned int *supported_capabilities)
     + {
     +-	int i;
     ++	size_t i;
     + 	char *line;
     + 
     + 	for (i = 0; capabilities[i].name; i++) {
     +
     + ## submodule.c ##
     +@@ submodule.c: void add_submodule_odb_by_path(const char *path)
     + 	string_list_insert(&added_submodule_odb_paths, xstrdup(path));
     + }
     + 
     +-int register_all_submodule_odb_as_alternates(void)
     ++size_t register_all_submodule_odb_as_alternates(void)
     + {
     +-	int i;
     +-	int ret = added_submodule_odb_paths.nr;
     ++	size_t i;
     ++	size_t ret = added_submodule_odb_paths.nr;
     + 
     + 	for (i = 0; i < added_submodule_odb_paths.nr; i++)
     + 		add_to_alternates_memory(added_submodule_odb_paths.items[i].string);
     +@@ submodule.c: int is_submodule_populated_gently(const char *path, int *return_error_code)
     + void die_in_unpopulated_submodule(struct index_state *istate,
     + 				  const char *prefix)
     + {
     +-	int i, prefixlen;
     ++	size_t i, prefixlen;
     + 
     + 	if (!prefix)
     + 		return;
     +@@ submodule.c: void die_in_unpopulated_submodule(struct index_state *istate,
     + 
     + 	for (i = 0; i < istate->cache_nr; i++) {
     + 		struct cache_entry *ce = istate->cache[i];
     +-		int ce_len = ce_namelen(ce);
     ++		size_t ce_len = ce_namelen(ce);
     + 
     + 		if (!S_ISGITLINK(ce->ce_mode))
     + 			continue;
     +@@ submodule.c: void die_in_unpopulated_submodule(struct index_state *istate,
     + void die_path_inside_submodule(struct index_state *istate,
     + 			       const struct pathspec *ps)
     + {
     +-	int i, j;
     ++	unsigned int i;
     ++	int j;
     + 
     + 	for (i = 0; i < istate->cache_nr; i++) {
     + 		struct cache_entry *ce = istate->cache[i];
     +@@ submodule.c: int push_unpushed_submodules(struct repository *r,
     + 			     const struct string_list *push_options,
     + 			     int dry_run)
     + {
     +-	int i, ret = 1;
     ++	size_t i;
     ++	int ret = 1;
     + 	struct string_list needs_pushing = STRING_LIST_INIT_DUP;
     + 
     + 	if (!find_unpushed_submodules(r, commits,
     +
     + ## submodule.h ##
     +@@ submodule.h: int bad_to_remove_submodule(const char *path, unsigned flags);
     +  * added as alternates in the_repository.
     +  */
     + void add_submodule_odb_by_path(const char *path);
     +-int register_all_submodule_odb_as_alternates(void);
     ++size_t register_all_submodule_odb_as_alternates(void);
     + 
     + /*
     +  * Checks if there are submodule changes in a..b. If a is the null OID,
     +
     + ## trailer.c ##
     +@@ trailer.c: static int git_trailer_config(const char *conf_key, const char *value,
     + 	struct conf_info *conf;
     + 	char *name = NULL;
     + 	enum trailer_info_type type;
     +-	int i;
     ++	size_t i;
     + 
     + 	if (!skip_prefix(conf_key, "trailer.", &trailer_item))
     + 		return 0;
     +
     + ## transport-helper.c ##
     +@@ transport-helper.c: static int string_list_set_helper_option(struct helper_data *data,
     + 					 struct string_list *list)
     + {
     + 	struct strbuf buf = STRBUF_INIT;
     +-	int i, ret = 0;
     ++	int ret = 0;
     ++	size_t i;
     + 
     + 	for (i = 0; i < list->nr; i++) {
     + 		strbuf_addf(&buf, "option %s ", name);
     +@@ transport-helper.c: static int set_helper_option(struct transport *transport,
     + {
     + 	struct helper_data *data = transport->data;
     + 	struct strbuf buf = STRBUF_INIT;
     +-	int i, ret, is_bool = 0;
     ++	size_t i;
     ++	int ret, is_bool = 0;
     + 
     + 	get_helper(transport);
     + 
     +@@ transport-helper.c: static int get_exporter(struct transport *transport,
     + {
     + 	struct helper_data *data = transport->data;
     + 	struct child_process *helper = get_helper(transport);
     +-	int i;
     ++	size_t i;
     + 
     + 	child_process_init(fastexport);
     + 
     +
     + ## transport.c ##
     +@@ transport.c: static int transport_color_config(void)
     + 		"color.transport.rejected"
     + 	}, *key = "color.transport";
     + 	char *value;
     +-	int i;
     ++	size_t i;
     + 	static int initialized;
     + 
     + 	if (initialized)
     +@@ transport.c: static struct ref *get_refs_from_bundle(struct transport *transport,
     + {
     + 	struct bundle_transport_data *data = transport->data;
     + 	struct ref *result = NULL;
     +-	int i;
     ++	size_t i;
     + 
     + 	if (for_push)
     + 		return NULL;
     +@@ transport.c: void transport_set_verbosity(struct transport *transport, int verbosity,
       
     + static void die_with_unpushed_submodules(struct string_list *needs_pushing)
     + {
     +-	int i;
     ++	size_t i;
     + 
     + 	fprintf(stderr, _("The following submodule paths contain changes that can\n"
     + 			"not be found on any remote:\n"));
     +@@ transport.c: int transport_get_remote_bundle_uri(struct transport *transport)
     + void transport_unlock_pack(struct transport *transport, unsigned int flags)
     + {
     + 	int in_signal_handler = !!(flags & TRANSPORT_UNLOCK_PACK_IN_SIGNAL_HANDLER);
     +-	int i;
     ++	size_t i;
     + 
     + 	for (i = 0; i < transport->pack_lockfiles.nr; i++)
     + 		if (in_signal_handler)
      
       ## unpack-trees.c ##
      @@ unpack-trees.c: static int verify_clean_subdirectory(const struct cache_entry *ce,
     @@ unpack-trees.c: static int verify_clean_subdirectory(const struct cache_entry *c
       
       	memset(&d, 0, sizeof(d));
       	if (o->dir)
     +@@ unpack-trees.c: int twoway_merge(const struct cache_entry * const *src,
     + 	const struct cache_entry *newtree = src[2];
     + 
     + 	if (o->merge_size != 2)
     +-		return error("Cannot do a twoway merge of %d trees",
     ++		return error("Cannot do a twoway merge of %u trees",
     + 			     o->merge_size);
     + 
     + 	if (oldtree == o->df_conflict_entry)
     +@@ unpack-trees.c: int bind_merge(const struct cache_entry * const *src,
     + 	const struct cache_entry *a = src[1];
     + 
     + 	if (o->merge_size != 1)
     +-		return error("Cannot do a bind merge of %d trees",
     ++		return error("Cannot do a bind merge of %u trees",
     + 			     o->merge_size);
     + 	if (a && old)
     + 		return o->quiet ? -1 :
     +@@ unpack-trees.c: int oneway_merge(const struct cache_entry * const *src,
     + 	const struct cache_entry *a = src[1];
     + 
     + 	if (o->merge_size != 1)
     +-		return error("Cannot do a oneway merge of %d trees",
     ++		return error("Cannot do a oneway merge of %u trees",
     + 			     o->merge_size);
     + 
     + 	if (!a || a == o->df_conflict_entry)
     +@@ unpack-trees.c: int stash_worktree_untracked_merge(const struct cache_entry * const *src,
     + 	const struct cache_entry *untracked = src[2];
     + 
     + 	if (o->merge_size != 2)
     +-		BUG("invalid merge_size: %d", o->merge_size);
     ++		BUG("invalid merge_size: %u", o->merge_size);
     + 
     + 	if (worktree && untracked)
     + 		return error(_("worktree and untracked commit have duplicate entries: %s"),
     +
     + ## unpack-trees.h ##
     +@@ unpack-trees.h: struct unpack_trees_options {
     + 	struct string_list unpack_rejects[NB_UNPACK_TREES_WARNING_TYPES];
     + 
     + 	int head_idx;
     +-	int merge_size;
     ++	unsigned merge_size;
     + 
     + 	struct cache_entry *df_conflict_entry;
     + 	void *unpack_data;
     +
     + ## wt-status.c ##
     +@@ wt-status.c: void wt_status_prepare(struct repository *r, struct wt_status *s)
     + 
     + static void wt_longstatus_print_unmerged_header(struct wt_status *s)
     + {
     +-	int i;
     ++	size_t i;
     + 	int del_mod_conflict = 0;
     + 	int both_deleted = 0;
     + 	int not_deleted = 0;
     +@@ wt-status.c: static int add_file_to_list(const struct object_id *oid,
     + static void wt_status_collect_changes_initial(struct wt_status *s)
     + {
     + 	struct index_state *istate = s->repo->index;
     +-	int i;
     ++	unsigned int i;
     + 
     + 	for (i = 0; i < istate->cache_nr; i++) {
     + 		struct string_list_item *it;
     +@@ wt-status.c: static void wt_status_collect_untracked(struct wt_status *s)
     + 
     + static int has_unmerged(struct wt_status *s)
     + {
     +-	int i;
     ++	size_t i;
     + 
     + 	for (i = 0; i < s->change.nr; i++) {
     + 		struct wt_status_change_data *d;
     +@@ wt-status.c: void wt_status_state_free_buffers(struct wt_status_state *state)
     + static void wt_longstatus_print_unmerged(struct wt_status *s)
     + {
     + 	int shown_header = 0;
     +-	int i;
     ++	size_t i;
     + 
     + 	for (i = 0; i < s->change.nr; i++) {
     + 		struct wt_status_change_data *d;
     +@@ wt-status.c: static void wt_longstatus_print_unmerged(struct wt_status *s)
     + static void wt_longstatus_print_updated(struct wt_status *s)
     + {
     + 	int shown_header = 0;
     +-	int i;
     ++	size_t i;
     + 
     + 	for (i = 0; i < s->change.nr; i++) {
     + 		struct wt_status_change_data *d;
     +@@ wt-status.c: static void wt_longstatus_print_updated(struct wt_status *s)
     + static int wt_status_check_worktree_changes(struct wt_status *s,
     + 					     int *dirty_submodules)
     + {
     +-	int i;
     ++	size_t i;
     + 	int changes = 0;
     + 
     + 	*dirty_submodules = 0;
     +@@ wt-status.c: static int wt_status_check_worktree_changes(struct wt_status *s,
     + 
     + static void wt_longstatus_print_changed(struct wt_status *s)
     + {
     +-	int i, dirty_submodules;
     ++	size_t i;
     ++	int dirty_submodules;
     + 	int worktree_changes = wt_status_check_worktree_changes(s, &dirty_submodules);
     + 
     + 	if (!worktree_changes)
     +@@ wt-status.c: static void wt_longstatus_print_other(struct wt_status *s,
     + 				      const char *what,
     + 				      const char *how)
     + {
     +-	int i;
     ++	size_t i;
     + 	struct strbuf buf = STRBUF_INIT;
     + 	static struct string_list output = STRING_LIST_INIT_DUP;
     + 	struct column_options copts;
     +@@ wt-status.c: static void wt_longstatus_print_tracking(struct wt_status *s)
     + 	const char *cp, *ep, *branch_name;
     + 	struct branch *branch;
     + 	char comment_line_string[3];
     +-	int i;
     ++	unsigned int i;
     + 	uint64_t t_begin = 0;
     + 
     + 	assert(s->branch && !s->is_initial);
     +@@ wt-status.c: static int split_commit_in_progress(struct wt_status *s)
     + static void abbrev_oid_in_line(struct strbuf *line)
     + {
     + 	struct strbuf **split;
     +-	int i;
     ++	size_t i;
     + 
     + 	if (starts_with(line->buf, "exec ") ||
     + 	    starts_with(line->buf, "x ") ||
     +@@ wt-status.c: static void show_rebase_information(struct wt_status *s,
     + 				    const char *color)
     + {
     + 	if (s->state.rebase_interactive_in_progress) {
     +-		int i;
     +-		int nr_lines_to_show = 2;
     ++		size_t i;
     ++		const size_t nr_lines_to_show = 2;
     + 
     + 		struct string_list have_done = STRING_LIST_INIT_DUP;
     + 		struct string_list yet_to_do = STRING_LIST_INIT_DUP;
     +@@ wt-status.c: static void wt_status_check_sparse_checkout(struct repository *r,
     + 					    struct wt_status_state *state)
     + {
     + 	int skip_worktree = 0;
     +-	int i;
     ++	unsigned int i;
     + 
     + 	if (!core_apply_sparse_checkout || r->index->cache_nr == 0) {
     + 		/*
     +@@ wt-status.c: static void wt_porcelain_v2_print(struct wt_status *s)
     + {
     + 	struct wt_status_change_data *d;
     + 	struct string_list_item *it;
     +-	int i;
     ++	size_t i;
     + 
     + 	if (s->show_branch)
     + 		wt_porcelain_v2_print_tracking(s);
      
       ## xdiff-interface.c ##
      @@ xdiff-interface.c: static long ff_regexp(const char *line, long len,


 add-interactive.c             | 29 +++++++++-------
 add-patch.c                   |  3 +-
 advice.c                      |  2 +-
 apply.c                       | 64 ++++++++++++++++-------------------
 apply.h                       |  8 ++---
 archive-tar.c                 |  8 ++---
 archive.c                     |  2 +-
 attr.c                        |  3 +-
 base85.c                      | 11 +++---
 bisect.c                      |  2 +-
 blame.c                       | 20 +++++------
 block-sha1/sha1.c             |  2 +-
 bloom.c                       | 10 +++---
 branch.c                      |  4 +--
 builtin/add.c                 |  3 +-
 builtin/fast-export.c         |  4 +--
 builtin/fast-import.c         |  2 +-
 builtin/fetch-pack.c          |  2 +-
 builtin/fetch.c               |  7 ++--
 builtin/for-each-repo.c       |  3 +-
 builtin/fsck.c                |  2 +-
 builtin/gc.c                  | 43 ++++++++++++-----------
 builtin/grep.c                |  5 +--
 builtin/help.c                |  2 +-
 builtin/log.c                 |  4 +--
 builtin/ls-files.c            | 24 ++++++-------
 builtin/ls-remote.c           |  1 -
 builtin/mailsplit.c           |  2 +-
 builtin/merge-file.c          |  3 +-
 builtin/merge.c               |  3 +-
 builtin/name-rev.c            |  4 +--
 builtin/pack-objects.c        | 16 ++++-----
 builtin/pack-redundant.c      |  6 ++--
 builtin/patch-id.c            | 14 ++++----
 builtin/pull.c                |  2 +-
 builtin/read-tree.c           |  6 ++--
 builtin/rebase.c              | 12 +++----
 builtin/receive-pack.c        | 12 ++++---
 builtin/remote.c              | 12 ++++---
 builtin/repack.c              |  7 ++--
 builtin/rerere.c              |  3 +-
 builtin/reset.c               |  2 +-
 builtin/rev-parse.c           |  2 +-
 builtin/rm.c                  | 10 +++---
 builtin/show-branch.c         | 34 +++++++++----------
 builtin/show-index.c          |  2 +-
 builtin/sparse-checkout.c     |  7 ++--
 builtin/stash.c               |  4 +--
 builtin/submodule--helper.c   |  7 ++--
 builtin/unpack-objects.c      |  2 +-
 builtin/update-ref.c          |  4 +--
 builtin/worktree.c            |  7 ++--
 bulk-checkin.c                |  4 +--
 bundle.c                      | 14 ++++----
 cache-tree.c                  | 10 +++---
 cache.h                       | 16 +++++----
 chunk-format.c                |  7 ++--
 color.c                       | 32 ++++++++++--------
 color.h                       |  2 +-
 column.c                      |  9 ++---
 combine-diff.c                |  4 +--
 commit-graph.c                | 19 ++++++-----
 commit-reach.c                | 11 +++---
 commit.c                      |  6 ++--
 compat/compiler.h             |  9 ++---
 compat/strcasestr.c           | 10 +++---
 compat/unsetenv.c             |  2 +-
 compat/winansi.c              |  7 ++--
 config.c                      | 31 ++++++++++-------
 config.h                      |  2 +-
 connect.c                     | 18 +++++-----
 convert.c                     | 16 ++++-----
 credential.c                  |  6 ++--
 daemon.c                      | 14 ++++----
 date.c                        |  4 +--
 decorate.c                    |  6 ++--
 delta-islands.c               | 10 +++---
 diagnose.c                    |  2 +-
 diff-lib.c                    |  2 +-
 diff-no-index.c               |  3 +-
 diff.c                        | 35 +++++++++----------
 dir.c                         |  3 +-
 dir.h                         |  2 +-
 fsck.c                        |  4 +--
 git.c                         |  2 +-
 list-objects-filter-options.c |  2 +-
 merge-recursive.c             |  7 ++--
 merge-recursive.h             |  2 +-
 notes.c                       |  2 +-
 object-name.c                 |  6 ++--
 range-diff.c                  | 15 ++++----
 read-cache.c                  | 49 ++++++++++++++-------------
 run-command.c                 | 11 +++---
 shallow.c                     |  2 +-
 shallow.h                     |  2 +-
 strbuf.c                      |  4 +--
 string-list.c                 |  3 +-
 string-list.h                 |  3 +-
 sub-process.c                 |  4 +--
 submodule.c                   | 16 +++++----
 submodule.h                   |  2 +-
 trailer.c                     |  2 +-
 transport-helper.c            |  8 +++--
 transport.c                   |  8 ++---
 unpack-trees.c                | 16 ++++-----
 unpack-trees.h                |  2 +-
 wt-status.c                   | 29 ++++++++--------
 xdiff-interface.c             |  6 ++--
 108 files changed, 515 insertions(+), 461 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 00a0f6f96f3..5ece4dab996 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -218,7 +218,8 @@ static ssize_t find_unique(const char *string, struct prefix_item_list *list)
 struct list_options {
 	int columns;
 	const char *header;
-	void (*print_item)(int i, int selected, struct string_list_item *item,
+	void (*print_item)(size_t i, int selected,
+			   struct string_list_item *item,
 			   void *print_item_data);
 	void *print_item_data;
 };
@@ -226,7 +227,8 @@ struct list_options {
 static void list(struct add_i_state *s, struct string_list *list, int *selected,
 		 struct list_options *opts)
 {
-	int i, last_lf = 0;
+	size_t i;
+	int last_lf = 0;
 
 	if (!list->nr)
 		return;
@@ -469,7 +471,7 @@ static void collect_changes_cb(struct diff_queue_struct *q,
 
 	for (i = 0; i < stat.nr; i++) {
 		const char *name = stat.files[i]->name;
-		int hash = strhash(name);
+		unsigned int hash = strhash(name);
 		struct pathname_entry *entry;
 		struct file_item *file_item;
 		struct adddel *adddel, *other_adddel;
@@ -528,7 +530,7 @@ static int get_modified_files(struct repository *r,
 	int is_initial = !resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
 					     &head_oid, NULL);
 	struct collection_status s = { 0 };
-	int i;
+	unsigned int i;
 
 	discard_index(r->index);
 	if (repo_read_index_preload(r, ps, 0) < 0)
@@ -617,12 +619,14 @@ struct print_file_item_data {
 	unsigned only_names:1;
 };
 
-static void print_file_item(int i, int selected, struct string_list_item *item,
+static void print_file_item(size_t i, int selected,
+			    struct string_list_item *item,
 			    void *print_file_item_data)
 {
 	struct file_item *c = item->util;
 	struct print_file_item_data *d = print_file_item_data;
 	const char *highlighted = NULL;
+	unsigned int e = (unsigned int)i + 1;
 
 	strbuf_reset(&d->index);
 	strbuf_reset(&d->worktree);
@@ -639,7 +643,7 @@ static void print_file_item(int i, int selected, struct string_list_item *item,
 	}
 
 	if (d->only_names) {
-		printf("%c%2d: %s", selected ? '*' : ' ', i + 1,
+		printf("%c%2u: %s", selected ? '*' : ' ', e,
 		       highlighted ? highlighted : item->string);
 		return;
 	}
@@ -650,7 +654,7 @@ static void print_file_item(int i, int selected, struct string_list_item *item,
 	strbuf_addf(&d->buf, d->modified_fmt, d->index.buf, d->worktree.buf,
 		    highlighted ? highlighted : item->string);
 
-	printf("%c%2d: %s", selected ? '*' : ' ', i + 1, d->buf.buf);
+	printf("%c%2u: %s", selected ? '*' : ' ', e, d->buf.buf);
 }
 
 static int run_status(struct add_i_state *s, const struct pathspec *ps,
@@ -1067,20 +1071,21 @@ struct print_command_item_data {
 	const char *color, *reset;
 };
 
-static void print_command_item(int i, int selected,
+static void print_command_item(size_t i, int selected,
 			       struct string_list_item *item,
 			       void *print_command_item_data)
 {
+	unsigned int e = (unsigned int)(i + 1);
 	struct print_command_item_data *d = print_command_item_data;
 	struct command_item *util = item->util;
 
 	if (!util->prefix_length ||
 	    !is_valid_prefix(item->string, util->prefix_length))
-		printf(" %2d: %s", i + 1, item->string);
+		printf(" %2u: %s", e, item->string);
 	else
-		printf(" %2d: %s%.*s%s%s", i + 1,
-		       d->color, (int)util->prefix_length, item->string,
-		       d->reset, item->string + util->prefix_length);
+		printf(" %2u: %s%.*s%s%s", e, d->color,
+		       (int)util->prefix_length, item->string, d->reset,
+		       item->string + util->prefix_length);
 }
 
 static void command_prompt_help(struct add_i_state *s)
diff --git a/add-patch.c b/add-patch.c
index a86a92e1646..be049301bb1 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -377,9 +377,10 @@ static int is_octal(const char *p, size_t len)
 	if (!len)
 		return 0;
 
-	while (len--)
+	do {
 		if (*p < '0' || *(p++) > '7')
 			return 0;
+	} while (--len);
 	return 1;
 }
 
diff --git a/advice.c b/advice.c
index fd189689437..eb2e2f6b863 100644
--- a/advice.c
+++ b/advice.c
@@ -138,7 +138,7 @@ void advise_if_enabled(enum advice_type type, const char *advice, ...)
 int git_default_advice_config(const char *var, const char *value)
 {
 	const char *k, *slot_name;
-	int i;
+	size_t i;
 
 	if (!strcmp(var, "color.advice")) {
 		advice_use_color = git_config_colorbool(var, value);
diff --git a/apply.c b/apply.c
index 85822280476..22b9c6e4c65 100644
--- a/apply.c
+++ b/apply.c
@@ -443,7 +443,7 @@ static int name_terminate(int c, int terminate)
 /* remove double slashes to make --index work with such filenames */
 static char *squash_slash(char *name)
 {
-	int i = 0, j = 0;
+	size_t i = 0, j = 0;
 
 	if (!name)
 		return NULL;
@@ -654,7 +654,7 @@ static char *find_name_common(struct strbuf *root,
 			      const char *end,
 			      int terminate)
 {
-	int len;
+	size_t len;
 	const char *start = NULL;
 
 	if (p_value == 0)
@@ -685,13 +685,13 @@ static char *find_name_common(struct strbuf *root,
 	 * or "file~").
 	 */
 	if (def) {
-		int deflen = strlen(def);
+		size_t deflen = strlen(def);
 		if (deflen < len && !strncmp(start, def, deflen))
 			return squash_slash(xstrdup(def));
 	}
 
 	if (root->len) {
-		char *ret = xstrfmt("%s%.*s", root->buf, len, start);
+		char *ret = xstrfmt("%s%.*s", root->buf, (int)len, start);
 		return squash_slash(ret);
 	}
 
@@ -790,7 +790,7 @@ static int has_epoch_timestamp(const char *nameline)
 	const char *timestamp = NULL, *cp, *colon;
 	static regex_t *stamp;
 	regmatch_t m[10];
-	int zoneoffset, epoch_hour, hour, minute;
+	long zoneoffset, epoch_hour, hour, minute;
 	int status;
 
 	for (cp = nameline; *cp != '\n'; cp++) {
@@ -1068,7 +1068,7 @@ static int gitdiff_dissimilarity(struct gitdiff_data *state UNUSED,
 				 const char *line,
 				 struct patch *patch)
 {
-	unsigned long val = strtoul(line, NULL, 10);
+	int val = atoi(line);
 	if (val <= 100)
 		patch->score = val;
 	return 0;
@@ -1083,7 +1083,7 @@ static int gitdiff_index(struct gitdiff_data *state,
 	 * and optional space with octal mode.
 	 */
 	const char *ptr, *eol;
-	int len;
+	size_t len;
 	const unsigned hexsz = the_hash_algo->hexsz;
 
 	ptr = strchr(line, '.');
@@ -1125,12 +1125,10 @@ static int gitdiff_unrecognized(struct gitdiff_data *state UNUSED,
  * Skip p_value leading components from "line"; as we do not accept
  * absolute paths, return NULL in that case.
  */
-static const char *skip_tree_prefix(int p_value,
-				    const char *line,
-				    int llen)
+static const char *skip_tree_prefix(int p_value, const char *line, size_t llen)
 {
 	int nslash;
-	int i;
+	size_t i;
 
 	if (!p_value)
 		return (llen && line[0] == '/') ? NULL : line;
@@ -1152,9 +1150,7 @@ static const char *skip_tree_prefix(int p_value,
  * creation or deletion of an empty file.  In any of these cases,
  * both sides are the same name under a/ and b/ respectively.
  */
-static char *git_header_name(int p_value,
-			     const char *line,
-			     int llen)
+static char *git_header_name(int p_value, const char *line, size_t llen)
 {
 	const char *name;
 	const char *second = NULL;
@@ -1302,12 +1298,8 @@ static int check_header_line(int linenr, struct patch *patch)
 	return 0;
 }
 
-int parse_git_diff_header(struct strbuf *root,
-			  int *linenr,
-			  int p_value,
-			  const char *line,
-			  int len,
-			  unsigned int size,
+int parse_git_diff_header(struct strbuf *root, int *linenr, int p_value,
+			  const char *line, size_t len, unsigned int size,
 			  struct patch *patch)
 {
 	unsigned long offset;
@@ -1360,14 +1352,14 @@ int parse_git_diff_header(struct strbuf *root,
 			{ "index ", gitdiff_index },
 			{ "", gitdiff_unrecognized },
 		};
-		int i;
+		size_t i;
 
 		len = linelen(line, size);
 		if (!len || line[len-1] != '\n')
 			break;
 		for (i = 0; i < ARRAY_SIZE(optable); i++) {
 			const struct opentry *p = optable + i;
-			int oplen = strlen(p->str);
+			size_t oplen = strlen(p->str);
 			int res;
 			if (len < oplen || memcmp(p->str, line, oplen))
 				continue;
@@ -1391,7 +1383,7 @@ done:
 				 "%d leading pathname components (line %d)",
 				 parse_hdr_state.p_value),
 			      parse_hdr_state.p_value, *linenr);
-			return -128;
+			return -1;
 		}
 		patch->old_name = xstrdup(patch->def_name);
 		patch->new_name = xstrdup(patch->def_name);
@@ -1400,7 +1392,7 @@ done:
 	    (!patch->old_name && !patch->is_new)) {
 		error(_("git diff header lacks filename information "
 			"(line %d)"), *linenr);
-		return -128;
+		return -1;
 	}
 	patch->is_toplevel_relative = 1;
 	return offset;
@@ -1454,22 +1446,23 @@ static int parse_range(const char *line, int len, int offset, const char *expect
 	return offset + ex;
 }
 
-static void recount_diff(const char *line, int size, struct fragment *fragment)
+static void recount_diff(const char *line, size_t size,
+			 struct fragment *fragment)
 {
 	int oldlines = 0, newlines = 0, ret = 0;
 
-	if (size < 1) {
+	if (size == 0) {
 		warning("recount: ignore empty hunk");
 		return;
 	}
 
 	for (;;) {
-		int len = linelen(line, size);
-		size -= len;
-		line += len;
+		size_t len = linelen(line, size);
 
-		if (size < 1)
+		if (size <= len)
 			break;
+		size -= len;
+		line += len;
 
 		switch (*line) {
 		case ' ': case '\n':
@@ -2086,7 +2079,7 @@ static void add_name_limit(struct apply_state *state,
 static int use_patch(struct apply_state *state, struct patch *p)
 {
 	const char *pathname = p->new_name ? p->new_name : p->old_name;
-	int i;
+	size_t i;
 
 	/* Paths outside are not touched regardless of "--include" */
 	if (state->prefix && *state->prefix) {
@@ -2172,9 +2165,9 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
 				"Files ",
 				NULL,
 			};
-			int i;
+			size_t i;
 			for (i = 0; binhdr[i]; i++) {
-				int len = strlen(binhdr[i]);
+				size_t len = strlen(binhdr[i]);
 				if (len < size - hd &&
 				    !memcmp(binhdr[i], buffer + hd, len)) {
 					state->linenr++;
@@ -2384,8 +2377,9 @@ static void update_pre_post_images(struct image *preimage,
 	if (postlen
 	    ? postlen < new_buf - postimage->buf
 	    : postimage->len < new_buf - postimage->buf)
-		BUG("caller miscounted postlen: asked %d, orig = %d, used = %d",
-		    (int)postlen, (int) postimage->len, (int)(new_buf - postimage->buf));
+		BUG("caller miscounted postlen: asked %u, orig = %u, used = %u",
+		    (unsigned int)postlen, (unsigned int)postimage->len,
+		    (unsigned int)(new_buf - postimage->buf));
 
 	/* Fix the length of the whole thing */
 	postimage->len = new_buf - postimage->buf;
diff --git a/apply.h b/apply.h
index b9f18ce87d1..7e6b6eb5d2d 100644
--- a/apply.h
+++ b/apply.h
@@ -165,12 +165,8 @@ int check_apply_state(struct apply_state *state, int force_apply);
  *
  * Returns -1 on failure, the length of the parsed header otherwise.
  */
-int parse_git_diff_header(struct strbuf *root,
-			  int *linenr,
-			  int p_value,
-			  const char *line,
-			  int len,
-			  unsigned int size,
+int parse_git_diff_header(struct strbuf *root, int *linenr, int p_value,
+			  const char *line, size_t len, unsigned int size,
 			  struct patch *patch);
 
 void release_patch(struct patch *patch);
diff --git a/archive-tar.c b/archive-tar.c
index f8fad2946ef..6d91eb01157 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -352,12 +352,12 @@ static void write_global_extended_header(struct archiver_args *args)
 }
 
 static struct archiver **tar_filters;
-static int nr_tar_filters;
-static int alloc_tar_filters;
+static size_t nr_tar_filters;
+static size_t alloc_tar_filters;
 
 static struct archiver *find_tar_filter(const char *name, size_t len)
 {
-	int i;
+	size_t i;
 	for (i = 0; i < nr_tar_filters; i++) {
 		struct archiver *ar = tar_filters[i];
 		if (!strncmp(ar->name, name, len) && !ar->name[len])
@@ -525,7 +525,7 @@ static struct archiver tar_archiver = {
 
 void init_tar_archiver(void)
 {
-	int i;
+	size_t i;
 	register_archiver(&tar_archiver);
 
 	tar_filter_config("tar.tgz.command", internal_gzip_command, NULL);
diff --git a/archive.c b/archive.c
index 941495f5d78..6042328451b 100644
--- a/archive.c
+++ b/archive.c
@@ -275,7 +275,7 @@ int write_archive_entries(struct archiver_args *args,
 	struct strbuf path_in_archive = STRBUF_INIT;
 	struct strbuf content = STRBUF_INIT;
 	struct object_id fake_oid;
-	int i;
+	size_t i;
 
 	oidcpy(&fake_oid, null_oid());
 
diff --git a/attr.c b/attr.c
index 42ad6de8c7c..e7bb41a05f3 100644
--- a/attr.c
+++ b/attr.c
@@ -447,11 +447,10 @@ struct attr_stack {
 
 static void attr_stack_free(struct attr_stack *e)
 {
-	int i;
+	unsigned int i, j;
 	free(e->origin);
 	for (i = 0; i < e->num_matches; i++) {
 		struct match_attr *a = e->attrs[i];
-		int j;
 		for (j = 0; j < a->num_attr; j++) {
 			const char *setto = a->state[j].setto;
 			if (setto == ATTR__TRUE ||
diff --git a/base85.c b/base85.c
index 5ca601ee14f..ad32ba1411a 100644
--- a/base85.c
+++ b/base85.c
@@ -37,14 +37,15 @@ static void prep_base85(void)
 	}
 }
 
-int decode_85(char *dst, const char *buffer, int len)
+int decode_85(char *dst, const char *buffer, size_t len)
 {
 	prep_base85();
 
-	say2("decode 85 <%.*s>", len / 4 * 5, buffer);
+	say2("decode 85 <%.*s>", (int)(len / 4 * 5), buffer);
 	while (len) {
 		unsigned acc = 0;
-		int de, cnt = 4;
+		int de;
+		size_t cnt = 4;
 		unsigned char ch;
 		do {
 			ch = *buffer++;
@@ -76,7 +77,7 @@ int decode_85(char *dst, const char *buffer, int len)
 	return 0;
 }
 
-void encode_85(char *buf, const unsigned char *data, int bytes)
+void encode_85(char *buf, const unsigned char *data, size_t bytes)
 {
 	say("encode 85");
 	while (bytes) {
@@ -90,7 +91,7 @@ void encode_85(char *buf, const unsigned char *data, int bytes)
 		}
 		say1(" %08x", acc);
 		for (cnt = 4; cnt >= 0; cnt--) {
-			int val = acc % 85;
+			unsigned val = acc % 85;
 			acc /= 85;
 			buf[cnt] = en85[val];
 		}
diff --git a/bisect.c b/bisect.c
index ec7487e6836..a3bdc5eeac7 100644
--- a/bisect.c
+++ b/bisect.c
@@ -494,7 +494,7 @@ static void read_bisect_paths(struct strvec *array)
 static char *join_oid_array_hex(struct oid_array *array, char delim)
 {
 	struct strbuf joined_hexs = STRBUF_INIT;
-	int i;
+	size_t i;
 
 	for (i = 0; i < array->nr; i++) {
 		strbuf_addstr(&joined_hexs, oid_to_hex(array->oid + i));
diff --git a/blame.c b/blame.c
index 8bfeaa1c63a..b050ba7f893 100644
--- a/blame.c
+++ b/blame.c
@@ -493,7 +493,7 @@ static void get_line_fingerprints(struct fingerprint *fingerprints,
 				  const char *content, const int *line_starts,
 				  long first_line, long line_count)
 {
-	int i;
+	long i;
 	const char *linestart, *lineend;
 
 	line_starts += first_line;
@@ -1496,7 +1496,7 @@ static void split_overlap(struct blame_entry *split,
 			  struct blame_origin *parent)
 {
 	int chunk_end_lno;
-	int i;
+	unsigned int i;
 	memset(split, 0, sizeof(struct blame_entry [3]));
 
 	for (i = 0; i < 3; i++) {
@@ -1583,7 +1583,7 @@ static void split_blame(struct blame_entry ***blamed,
  */
 static void decref_split(struct blame_entry *split)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < 3; i++)
 		blame_origin_decref(split[i].suspect);
@@ -2001,7 +2001,7 @@ static void copy_split_if_better(struct blame_scoreboard *sb,
 				 struct blame_entry *best_so_far,
 				 struct blame_entry *potential)
 {
-	int i;
+	unsigned int i;
 
 	if (!potential[1].suspect)
 		return;
@@ -2193,10 +2193,10 @@ struct blame_list {
  * and prepare a list of entry and the best split.
  */
 static struct blame_list *setup_blame_list(struct blame_entry *unblamed,
-					   int *num_ents_p)
+					   size_t *num_ents_p)
 {
 	struct blame_entry *e;
-	int num_ents, i;
+	size_t num_ents, i;
 	struct blame_list *blame_list = NULL;
 
 	for (e = unblamed, num_ents = 0; e; e = e->next)
@@ -2224,9 +2224,9 @@ static void find_copy_in_parent(struct blame_scoreboard *sb,
 				int opt)
 {
 	struct diff_options diff_opts;
-	int i, j;
+	size_t i, j;
 	struct blame_list *blame_list;
-	int num_ents;
+	size_t num_ents;
 	struct blame_entry *unblamed = target->suspects;
 	struct blame_entry *leftover = NULL;
 
@@ -2645,7 +2645,7 @@ static int prepare_lines(struct blame_scoreboard *sb)
 static struct commit *find_single_final(struct rev_info *revs,
 					const char **name_p)
 {
-	int i;
+	unsigned int i;
 	struct commit *found = NULL;
 	const char *name = NULL;
 
@@ -2708,7 +2708,7 @@ static struct commit *dwim_reverse_initial(struct rev_info *revs,
 static struct commit *find_single_initial(struct rev_info *revs,
 					  const char **name_p)
 {
-	int i;
+	unsigned int i;
 	struct commit *found = NULL;
 	const char *name = NULL;
 
diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
index 80cebd27564..a08be63bc63 100644
--- a/block-sha1/sha1.c
+++ b/block-sha1/sha1.c
@@ -214,7 +214,7 @@ void blk_SHA1_Final(unsigned char hashout[20], blk_SHA_CTX *ctx)
 {
 	static const unsigned char pad[64] = { 0x80 };
 	unsigned int padlen[2];
-	int i;
+	size_t i;
 
 	/* Pad with a binary 1 (ie 0x80), then zeroes, then length */
 	padlen[0] = htonl((uint32_t)(ctx->size >> 29));
diff --git a/bloom.c b/bloom.c
index d0730525da5..d38064e257f 100644
--- a/bloom.c
+++ b/bloom.c
@@ -73,11 +73,11 @@ uint32_t murmur3_seeded(uint32_t seed, const char *data, size_t len)
 	const uint32_t r2 = 13;
 	const uint32_t m = 5;
 	const uint32_t n = 0xe6546b64;
-	int i;
+	size_t i;
 	uint32_t k1 = 0;
 	const char *tail;
 
-	int len4 = len / sizeof(uint32_t);
+	size_t len4 = len / sizeof(uint32_t);
 
 	uint32_t k;
 	for (i = 0; i < len4; i++) {
@@ -127,7 +127,7 @@ void fill_bloom_key(const char *data,
 		    struct bloom_key *key,
 		    const struct bloom_filter_settings *settings)
 {
-	int i;
+	uint32_t i;
 	const uint32_t seed0 = 0x293ae76f;
 	const uint32_t seed1 = 0x7e646e2c;
 	const uint32_t hash0 = murmur3_seeded(seed0, data, len);
@@ -147,7 +147,7 @@ void add_key_to_filter(const struct bloom_key *key,
 		       struct bloom_filter *filter,
 		       const struct bloom_filter_settings *settings)
 {
-	int i;
+	uint32_t i;
 	uint64_t mod = filter->len * BITS_PER_WORD;
 
 	for (i = 0; i < settings->num_hashes; i++) {
@@ -310,7 +310,7 @@ int bloom_filter_contains(const struct bloom_filter *filter,
 			  const struct bloom_key *key,
 			  const struct bloom_filter_settings *settings)
 {
-	int i;
+	uint32_t i;
 	uint64_t mod = filter->len * BITS_PER_WORD;
 
 	if (!mod)
diff --git a/branch.c b/branch.c
index d182756827f..bb9c861a9bc 100644
--- a/branch.c
+++ b/branch.c
@@ -375,7 +375,7 @@ static struct strmap current_checked_out_branches = STRMAP_INIT;
 
 static void prepare_checked_out_branches(void)
 {
-	int i = 0;
+	size_t i = 0;
 	struct worktree **worktrees;
 
 	if (initialized_checked_out_branches)
@@ -836,7 +836,7 @@ int replace_each_worktree_head_symref(const char *oldref, const char *newref,
 {
 	int ret = 0;
 	struct worktree **worktrees = get_worktrees();
-	int i;
+	size_t i;
 
 	for (i = 0; worktrees[i]; i++) {
 		struct ref_store *refs;
diff --git a/builtin/add.c b/builtin/add.c
index 0c604022676..5a6686d42dc 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -40,7 +40,8 @@ struct update_callback_data {
 
 static int chmod_pathspec(struct pathspec *pathspec, char flip, int show_only)
 {
-	int i, ret = 0;
+	unsigned int i;
+	int ret = 0;
 
 	for (i = 0; i < the_index.cache_nr; i++) {
 		struct cache_entry *ce = the_index.cache[i];
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 39a890fc005..43da493eb4b 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -906,7 +906,7 @@ static struct commit *get_commit(struct rev_cmdline_entry *e, char *full_name)
 
 static void get_tags_and_duplicates(struct rev_cmdline_info *info)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < info->nr; i++) {
 		struct rev_cmdline_entry *e = info->rev + i;
@@ -1230,7 +1230,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 		die(_("the option '%s' requires '%s'"), "--anonymize-map", "--anonymize");
 
 	if (refspecs_list.nr) {
-		int i;
+		size_t i;
 
 		for (i = 0; i < refspecs_list.nr; i++)
 			refspec_append(&refspecs, refspecs_list.items[i].string);
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 7134683ab93..068c218ca61 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -860,7 +860,7 @@ static void end_packfile(void)
 		struct packed_git *new_p;
 		struct object_id cur_pack_oid;
 		char *idx_name;
-		int i;
+		unsigned long i;
 		struct branch *b;
 		struct tag *t;
 
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index afe679368de..9758d067b73 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -239,7 +239,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	ref = fetch_pack(&args, fd, ref, sought, nr_sought,
 			 &shallow, pack_lockfiles_ptr, version);
 	if (pack_lockfiles.nr) {
-		int i;
+		size_t i;
 
 		printf("lock %s\n", pack_lockfiles.items[0].string);
 		fflush(stdout);
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 7378cafeec9..2a86fe79fc7 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1479,11 +1479,11 @@ static int add_oid(const char *refname UNUSED,
 static void add_negotiation_tips(struct git_transport_options *smart_options)
 {
 	struct oid_array *oids = xcalloc(1, sizeof(*oids));
-	int i;
+	size_t i;
 
 	for (i = 0; i < negotiation_tip.nr; i++) {
 		const char *s = negotiation_tip.items[i].string;
-		int old_nr;
+		size_t old_nr;
 		if (!has_glob_specials(s)) {
 			struct object_id oid;
 			if (get_oid(s, &oid))
@@ -1938,7 +1938,8 @@ static int fetch_finished(int result, struct strbuf *out,
 
 static int fetch_multiple(struct string_list *list, int max_children)
 {
-	int i, result = 0;
+	size_t i;
+	int result = 0;
 	struct strvec argv = STRVEC_INIT;
 
 	if (!append && write_fetch_head) {
diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
index 6aeac371488..ababcbef101 100644
--- a/builtin/for-each-repo.c
+++ b/builtin/for-each-repo.c
@@ -30,7 +30,8 @@ static int run_command_on_repo(const char *path, int argc, const char ** argv)
 int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
 {
 	static const char *config_key = NULL;
-	int i, result = 0;
+	int result = 0;
+	size_t i;
 	const struct string_list *values;
 
 	const struct option options[] = {
diff --git a/builtin/fsck.c b/builtin/fsck.c
index d207bd909b4..3b411735a58 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -359,7 +359,7 @@ static void check_object(struct object *obj)
 
 static void check_connectivity(void)
 {
-	int i, max;
+	unsigned int i, max;
 
 	/* Traverse the pending reachable objects */
 	traverse_reachable();
diff --git a/builtin/gc.c b/builtin/gc.c
index 02455fdcd73..511419ba417 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -68,7 +68,7 @@ static struct string_list pack_garbage = STRING_LIST_INIT_DUP;
 
 static void clean_pack_garbage(void)
 {
-	int i;
+	size_t i;
 	for (i = 0; i < pack_garbage.nr; i++)
 		unlink_or_warn(pack_garbage.items[i].string);
 	string_list_clear(&pack_garbage, 0);
@@ -1288,7 +1288,8 @@ static int compare_tasks_by_selection(const void *a_, const void *b_)
 
 static int maintenance_run_tasks(struct maintenance_run_opts *opts)
 {
-	int i, found_selected = 0;
+	unsigned int i;
+	int found_selected = 0;
 	int result = 0;
 	struct lock_file lk;
 	struct repository *r = the_repository;
@@ -1367,7 +1368,7 @@ static void initialize_maintenance_strategy(void)
 
 static void initialize_task_config(int schedule)
 {
-	int i;
+	unsigned int i;
 	struct strbuf config_name = STRBUF_INIT;
 	gc_config();
 
@@ -1401,7 +1402,8 @@ static void initialize_task_config(int schedule)
 static int task_option_parse(const struct option *opt,
 			     const char *arg, int unset)
 {
-	int i, num_selected = 0;
+	unsigned int i;
+	int num_selected = 0;
 	struct maintenance_task *task = NULL;
 
 	BUG_ON_OPT_NEG(unset);
@@ -1431,7 +1433,7 @@ static int task_option_parse(const struct option *opt,
 
 static int maintenance_run(int argc, const char **argv, const char *prefix)
 {
-	int i;
+	unsigned int i;
 	struct maintenance_run_opts opts;
 	struct option builtin_maintenance_run_options[] = {
 		OPT_BOOL(0, "auto", &opts.auto_flag,
@@ -1810,8 +1812,9 @@ static int launchctl_list_contains_plist(const char *name, const char *cmd)
 
 static int launchctl_schedule_plist(const char *exec_path, enum schedule_priority schedule)
 {
-	int i, fd;
-	const char *preamble, *repeat;
+	unsigned int i;
+	int fd;
+	const char *preamble;
 	const char *frequency = get_frequency(schedule);
 	char *name = launchctl_service_name(frequency);
 	char *filename = launchctl_service_filename(name);
@@ -1843,22 +1846,24 @@ static int launchctl_schedule_plist(const char *exec_path, enum schedule_priorit
 
 	switch (schedule) {
 	case SCHEDULE_HOURLY:
-		repeat = "<dict>\n"
-			 "<key>Hour</key><integer>%d</integer>\n"
-			 "<key>Minute</key><integer>0</integer>\n"
-			 "</dict>\n";
 		for (i = 1; i <= 23; i++)
-			strbuf_addf(&plist, repeat, i);
+			strbuf_addf(&plist,
+				    "<dict>\n"
+				    "<key>Hour</key><integer>%u</integer>\n"
+				    "<key>Minute</key><integer>0</integer>\n"
+				    "</dict>\n",
+				    i);
 		break;
 
 	case SCHEDULE_DAILY:
-		repeat = "<dict>\n"
-			 "<key>Day</key><integer>%d</integer>\n"
-			 "<key>Hour</key><integer>0</integer>\n"
-			 "<key>Minute</key><integer>0</integer>\n"
-			 "</dict>\n";
 		for (i = 1; i <= 6; i++)
-			strbuf_addf(&plist, repeat, i);
+			strbuf_addf(&plist,
+				    "<dict>\n"
+				    "<key>Day</key><integer>%u</integer>\n"
+				    "<key>Hour</key><integer>0</integer>\n"
+				    "<key>Minute</key><integer>0</integer>\n"
+				    "</dict>\n",
+				    i);
 		break;
 
 	case SCHEDULE_WEEKLY:
@@ -2553,7 +2558,7 @@ static void validate_scheduler(enum scheduler scheduler)
 static int update_background_schedule(const struct maintenance_start_opts *opts,
 				      int enable)
 {
-	unsigned int i;
+	size_t i;
 	int result = 0;
 	struct lock_file lk;
 	char *lock_path = xstrfmt("%s/schedule", the_repository->objects->odb->path);
diff --git a/builtin/grep.c b/builtin/grep.c
index f7821c5fbba..75cc21f632e 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -174,7 +174,7 @@ static void work_done(struct work_item *w)
 
 static void free_repos(void)
 {
-	int i;
+	size_t i;
 
 	for (i = 0; i < repos_to_free_nr; i++) {
 		repo_clear(repos_to_free[i]);
@@ -409,7 +409,8 @@ static void run_pager(struct grep_opt *opt, const char *prefix)
 {
 	struct string_list *path_list = opt->output_priv;
 	struct child_process child = CHILD_PROCESS_INIT;
-	int i, status;
+	size_t i;
+	int status;
 
 	for (i = 0; i < path_list->nr; i++)
 		strvec_push(&child.args, path_list->items[i].string);
diff --git a/builtin/help.c b/builtin/help.c
index 53f2812dfb1..fd227be20f1 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -124,7 +124,7 @@ static void list_config_help(enum show_config_type type)
 	struct string_list keys = STRING_LIST_INIT_DUP;
 	struct string_list keys_uniq = STRING_LIST_INIT_DUP;
 	struct string_list_item *item;
-	int i;
+	size_t i;
 
 	for (p = config_name_list; *p; p++) {
 		const char *var = *p;
diff --git a/builtin/log.c b/builtin/log.c
index 057e299c245..5a89440de82 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -179,7 +179,7 @@ static void cmd_log_init_defaults(struct rev_info *rev)
 
 static void set_default_decoration_filter(struct decoration_filter *decoration_filter)
 {
-	int i;
+	size_t i;
 	char *value = NULL;
 	struct string_list *include = decoration_filter->include_ref_pattern;
 	const struct string_list *config_exclude =
@@ -386,7 +386,7 @@ static struct itimerval early_output_timer;
 
 static void log_show_early(struct rev_info *revs, struct commit_list *list)
 {
-	int i = revs->early_output;
+	unsigned int i = revs->early_output;
 	int show_header = 1;
 	int no_free = revs->diffopt.no_free;
 
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index a03b559ecaa..c369e95c30e 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -348,7 +348,8 @@ static void show_ru_info(struct index_state *istate)
 	for_each_string_list_item(item, istate->resolve_undo) {
 		const char *path = item->string;
 		struct resolve_undo_info *ui = item->util;
-		int i, len;
+		unsigned int i;
+		int len;
 
 		len = strlen(path);
 		if (len < max_prefix_len)
@@ -359,9 +360,8 @@ static void show_ru_info(struct index_state *istate)
 		for (i = 0; i < 3; i++) {
 			if (!ui->mode[i])
 				continue;
-			printf("%s%06o %s %d\t", tag_resolve_undo, ui->mode[i],
-			       find_unique_abbrev(&ui->oid[i], abbrev),
-			       i + 1);
+			printf("%s%06o %s %u\t", tag_resolve_undo, ui->mode[i],
+			       find_unique_abbrev(&ui->oid[i], abbrev), i + 1);
 			write_name(path);
 		}
 	}
@@ -385,7 +385,7 @@ static void construct_fullname(struct strbuf *out, const struct repository *repo
 
 static void show_files(struct repository *repo, struct dir_struct *dir)
 {
-	int i;
+	unsigned int i;
 	struct strbuf fullname = STRBUF_INIT;
 
 	/* For cached/deleted files we don't need to even do the readdir */
@@ -449,12 +449,12 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
 
 skip_to_next_name:
 		{
-			int j;
-			struct cache_entry **cache = repo->index->cache;
-			for (j = i + 1; j < repo->index->cache_nr; j++)
-				if (strcmp(ce->name, cache[j]->name))
-					break;
-			i = j - 1; /* compensate for the for loop */
+		unsigned int j;
+		struct cache_entry **cache = repo->index->cache;
+		for (j = i + 1; j < repo->index->cache_nr; j++)
+			if (strcmp(ce->name, cache[j]->name))
+				break;
+		i = j - 1; /* compensate for the for loop */
 		}
 	}
 
@@ -571,7 +571,7 @@ void overlay_tree_on_index(struct index_state *istate,
 	struct object_id oid;
 	struct pathspec pathspec;
 	struct cache_entry *last_stage0 = NULL;
-	int i;
+	unsigned int i;
 	read_tree_fn_t fn = NULL;
 	int err;
 
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 5d5ac038716..2c87b473700 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -87,7 +87,6 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	packet_trace_identity("ls-remote");
 
 	if (argc > 1) {
-		int i;
 		CALLOC_ARRAY(pattern, argc);
 		for (i = 1; i < argc; i++) {
 			pattern[i - 1] = xstrfmt("*/%s", argv[i]);
diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
index 73509f651bd..053c9eecb30 100644
--- a/builtin/mailsplit.c
+++ b/builtin/mailsplit.c
@@ -172,7 +172,7 @@ static int split_maildir(const char *maildir, const char *dir,
 	char *file = NULL;
 	FILE *f = NULL;
 	int ret = -1;
-	int i;
+	size_t i;
 	struct string_list list = STRING_LIST_INIT_DUP;
 
 	list.cmp = maildir_filename_cmp;
diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index c923bbf2abb..e4655e8541c 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -29,7 +29,8 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 	mmfile_t mmfs[3] = { 0 };
 	mmbuffer_t result = { 0 };
 	xmparam_t xmp = { 0 };
-	int ret = 0, i = 0, to_stdout = 0;
+	int ret = 0, to_stdout = 0;
+	size_t i = 0;
 	int quiet = 0;
 	struct option options[] = {
 		OPT_BOOL('p', "stdout", &to_stdout, N_("send results to standard output")),
diff --git a/builtin/merge.c b/builtin/merge.c
index 0f093f2a4f2..4aa3bdb6d16 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -186,7 +186,8 @@ static struct strategy *get_strategy(const char *name)
 		memset(&not_strategies, 0, sizeof(struct cmdnames));
 		load_command_list("git-merge-", &main_cmds, &other_cmds);
 		for (i = 0; i < main_cmds.cnt; i++) {
-			int j, found = 0;
+			size_t j;
+			int found = 0;
 			struct cmdname *ent = main_cmds.names[i];
 			for (j = 0; j < ARRAY_SIZE(all_strategy); j++)
 				if (!strncmp(ent->name, all_strategy[j].name, ent->len)
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 15535e914a6..0a96140d342 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -664,7 +664,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 		}
 		strbuf_release(&sb);
 	} else if (all) {
-		int i, max;
+		unsigned int i, max;
 
 		max = get_max_object_index();
 		for (i = 0; i < max; i++) {
@@ -675,7 +675,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 				  always, allow_undefined, data.name_only);
 		}
 	} else {
-		int i;
+		unsigned int i;
 		for (i = 0; i < revs.nr; i++)
 			show_name(revs.objects[i].item, revs.objects[i].name,
 				  always, allow_undefined, data.name_only);
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 2193f80b897..e539e73e5ce 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1509,7 +1509,7 @@ static int want_object_in_pack(const struct object_id *oid,
 	if (uri_protocols.nr) {
 		struct configured_exclusion *ex =
 			oidmap_get(&configured_exclusions, oid);
-		int i;
+		size_t i;
 		const char *p;
 
 		if (ex) {
@@ -1708,18 +1708,16 @@ static void pbase_tree_put(struct pbase_tree_cache *cache)
 	free(cache);
 }
 
-static int name_cmp_len(const char *name)
+static size_t name_cmp_len(const char *name)
 {
-	int i;
+	size_t i;
 	for (i = 0; name[i] && name[i] != '\n' && name[i] != '/'; i++)
 		;
 	return i;
 }
 
-static void add_pbase_object(struct tree_desc *tree,
-			     const char *name,
-			     int cmplen,
-			     const char *fullname)
+static void add_pbase_object(struct tree_desc *tree, const char *name,
+			     size_t cmplen, const char *fullname)
 {
 	struct name_entry entry;
 	int cmp;
@@ -1743,7 +1741,7 @@ static void add_pbase_object(struct tree_desc *tree,
 			struct tree_desc sub;
 			struct pbase_tree_cache *tree;
 			const char *down = name+cmplen+1;
-			int downlen = name_cmp_len(down);
+			size_t downlen = name_cmp_len(down);
 
 			tree = pbase_tree_get(&entry.oid);
 			if (!tree)
@@ -4085,7 +4083,7 @@ static void add_extra_kept_packs(const struct string_list *names)
 
 	for (p = get_all_packs(the_repository); p; p = p->next) {
 		const char *name = basename(p->pack_name);
-		int i;
+		size_t i;
 
 		if (!p->pack_local)
 			continue;
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index ecd49ca268f..0f6c827faca 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -51,9 +51,9 @@ static inline struct llist_item *llist_item_get(void)
 		new_item = free_nodes;
 		free_nodes = free_nodes->next;
 	} else {
-		int i = 1;
+		size_t i;
 		ALLOC_ARRAY(new_item, BLKSIZE);
-		for (; i < BLKSIZE; i++)
+		for (i = 1; i < BLKSIZE; i++)
 			llist_item_put(&new_item[i]);
 	}
 	return new_item;
@@ -366,7 +366,7 @@ static int cmp_remaining_objects(const void *a, const void *b)
 static void sort_pack_list(struct pack_list **pl)
 {
 	struct pack_list **ary, *p;
-	int i;
+	size_t i;
 	size_t n = pack_list_size(*pl);
 
 	if (n < 2)
diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index f840fbf1c7e..8fed7935e9a 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -10,7 +10,7 @@ static void flush_current_id(int patchlen, struct object_id *id, struct object_i
 		printf("%s %s\n", oid_to_hex(result), oid_to_hex(id));
 }
 
-static int remove_space(char *line)
+static size_t remove_space(char *line)
 {
 	char *src = line;
 	char *dst = line;
@@ -57,10 +57,12 @@ static int scan_hunk_header(const char *p, int *p_before, int *p_after)
 	return 1;
 }
 
-static int get_one_patchid(struct object_id *next_oid, struct object_id *result,
-			   struct strbuf *line_buf, int stable, int verbatim)
+static size_t get_one_patchid(struct object_id *next_oid,
+			      struct object_id *result, struct strbuf *line_buf,
+			      int stable, int verbatim)
 {
-	int patchlen = 0, found_next = 0;
+	size_t patchlen = 0;
+	int found_next = 0;
 	int before = -1, after = -1;
 	int diff_is_binary = 0;
 	char pre_oid_str[GIT_MAX_HEXSZ + 1], post_oid_str[GIT_MAX_HEXSZ + 1];
@@ -72,7 +74,7 @@ static int get_one_patchid(struct object_id *next_oid, struct object_id *result,
 	while (strbuf_getwholeline(line_buf, stdin, '\n') != EOF) {
 		char *line = line_buf->buf;
 		const char *p = line;
-		int len;
+		size_t len;
 
 		/* Possibly skip over the prefix added by "log" or "format-patch" */
 		if (!skip_prefix(line, "commit ", &p) &&
@@ -173,7 +175,7 @@ static int get_one_patchid(struct object_id *next_oid, struct object_id *result,
 static void generate_id_list(int stable, int verbatim)
 {
 	struct object_id oid, n, result;
-	int patchlen;
+	size_t patchlen;
 	struct strbuf line_buf = STRBUF_INIT;
 
 	oidclr(&oid);
diff --git a/builtin/pull.c b/builtin/pull.c
index 1ab4de0005d..115b4bd8819 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -941,7 +941,7 @@ static int get_can_ff(struct object_id *orig_head,
 static int already_up_to_date(struct object_id *orig_head,
 			      struct oid_array *merge_heads)
 {
-	int i;
+	size_t i;
 	struct commit *ours;
 
 	ours = lookup_commit_reference(the_repository, orig_head);
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 3ce75417833..444939c70dc 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -85,13 +85,13 @@ static void debug_stage(const char *label, const struct cache_entry *ce,
 static int debug_merge(const struct cache_entry * const *stages,
 		       struct unpack_trees_options *o)
 {
-	int i;
+	unsigned int i;
 
-	printf("* %d-way merge\n", o->merge_size);
+	printf("* %u-way merge\n", o->merge_size);
 	debug_stage("index", stages[0], o);
 	for (i = 1; i <= o->merge_size; i++) {
 		char buf[24];
-		xsnprintf(buf, sizeof(buf), "ent#%d", i);
+		xsnprintf(buf, sizeof(buf), "ent#%u", i);
 		debug_stage(buf, stages[i], o);
 	}
 	return 0;
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 1481c5b6a5b..38c69a0e0c9 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1423,13 +1423,13 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		options.gpg_sign_opt = xstrfmt("-S%s", gpg_sign);
 
 	if (exec.nr) {
-		int i;
+		size_t j;
 
 		imply_merge(&options, "--exec");
 
 		strbuf_reset(&buf);
-		for (i = 0; i < exec.nr; i++)
-			strbuf_addf(&buf, "exec %s\n", exec.items[i].string);
+		for (j = 0; j < exec.nr; j++)
+			strbuf_addf(&buf, "exec %s\n", exec.items[j].string);
 		options.cmd = xstrdup(buf.buf);
 	}
 
@@ -1462,15 +1462,15 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	}
 
 	if (strategy_options.nr) {
-		int i;
+		size_t j;
 
 		if (!options.strategy)
 			options.strategy = "ort";
 
 		strbuf_reset(&buf);
-		for (i = 0; i < strategy_options.nr; i++)
+		for (j = 0; j < strategy_options.nr; j++)
 			strbuf_addf(&buf, " --%s",
-				    strategy_options.items[i].string);
+				    strategy_options.items[j].string);
 		options.strategy_opts = xstrdup(buf.buf);
 	}
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index a90af303630..c1dc2ceb517 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -536,7 +536,7 @@ static void hmac_hash(unsigned char *out,
 	unsigned char key[GIT_MAX_BLKSZ];
 	unsigned char k_ipad[GIT_MAX_BLKSZ];
 	unsigned char k_opad[GIT_MAX_BLKSZ];
-	int i;
+	size_t i;
 	git_hash_ctx ctx;
 
 	/* RFC 2104 2. (1) */
@@ -1302,7 +1302,7 @@ static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
 	struct oid_array extra = OID_ARRAY_INIT;
 	struct check_connected_options opt = CHECK_CONNECTED_INIT;
 	uint32_t mask = 1 << (cmd->index % 32);
-	int i;
+	size_t i;
 
 	trace_printf_key(&trace_shallow,
 			 "shallow: update_shallow_ref %s\n", cmd->ref_name);
@@ -2303,7 +2303,9 @@ static const char *unpack_with_sideband(struct shallow_info *si)
 
 static void prepare_shallow_update(struct shallow_info *si)
 {
-	int i, j, k, bitmap_size = DIV_ROUND_UP(si->ref->nr, 32);
+	size_t i, j, k;
+	size_t bitmap_size = DIV_ROUND_UP(si->ref->nr, 32);
+	int l;
 
 	ALLOC_ARRAY(si->used_shallow, si->shallow->nr);
 	assign_shallow_commits_to_refs(si, si->used_shallow, NULL);
@@ -2312,8 +2314,8 @@ static void prepare_shallow_update(struct shallow_info *si)
 	CALLOC_ARRAY(si->reachable, si->shallow->nr);
 	CALLOC_ARRAY(si->shallow_ref, si->ref->nr);
 
-	for (i = 0; i < si->nr_ours; i++)
-		si->need_reachability_test[si->ours[i]] = 1;
+	for (l = 0; l < si->nr_ours; l++)
+		si->need_reachability_test[si->ours[l]] = 1;
 
 	for (i = 0; i < si->shallow->nr; i++) {
 		if (!si->used_shallow[i])
diff --git a/builtin/remote.c b/builtin/remote.c
index 729f6f3643a..93f8c9a2fad 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -161,7 +161,7 @@ static int add(int argc, const char **argv, const char *prefix)
 	struct remote *remote;
 	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT;
 	const char *name, *url;
-	int i;
+	size_t i;
 
 	struct option options[] = {
 		OPT_BOOL('f', "fetch", &fetch, N_("fetch the remote branches")),
@@ -862,7 +862,8 @@ static int rm(int argc, const char **argv, const char *prefix)
 	struct string_list branches = STRING_LIST_INIT_DUP;
 	struct string_list skipped = STRING_LIST_INIT_DUP;
 	struct branches_for_remote cb_data;
-	int i, result;
+	size_t i;
+	int result;
 
 	memset(&cb_data, 0, sizeof(cb_data));
 	cb_data.branches = &branches;
@@ -1093,7 +1094,7 @@ static int show_local_info_item(struct string_list_item *item, void *cb_data)
 	struct branch_info *branch_info = item->util;
 	struct string_list *merge = &branch_info->merge;
 	int width = show_info->width + 4;
-	int i;
+	size_t i;
 
 	if (branch_info->rebase >= REBASE_TRUE && branch_info->merge.nr > 1) {
 		error(_("invalid branch.%s.merge; cannot rebase onto > 1 branch"),
@@ -1245,7 +1246,7 @@ static int show_all(void)
 	result = for_each_remote(get_one_entry, &list);
 
 	if (!result) {
-		int i;
+		size_t i;
 
 		string_list_sort(&list);
 		for (i = 0; i < list.nr; i++) {
@@ -1370,7 +1371,7 @@ static int show(int argc, const char **argv, const char *prefix)
 
 static int set_head(int argc, const char **argv, const char *prefix)
 {
-	int i, opt_a = 0, opt_d = 0, result = 0;
+	int opt_a = 0, opt_d = 0, result = 0;
 	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT;
 	char *head_name = NULL;
 
@@ -1394,6 +1395,7 @@ static int set_head(int argc, const char **argv, const char *prefix)
 		if (!states.heads.nr)
 			result |= error(_("Cannot determine remote HEAD"));
 		else if (states.heads.nr > 1) {
+			size_t i;
 			result |= error(_("Multiple remote HEAD branches. "
 					  "Please choose one explicitly with:"));
 			for (i = 0; i < states.heads.nr; i++)
diff --git a/builtin/repack.c b/builtin/repack.c
index c1402ad038f..791b100f799 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -109,7 +109,7 @@ static void collect_pack_filenames(struct string_list *fname_nonkept_list,
 
 	while ((e = readdir(dir)) != NULL) {
 		size_t len;
-		int i;
+		size_t i;
 
 		if (!strip_suffix(e->d_name, ".pack", &len))
 			continue;
@@ -218,7 +218,7 @@ static struct generated_pack_data *populate_pack_exts(const char *name)
 	struct stat statbuf;
 	struct strbuf path = STRBUF_INIT;
 	struct generated_pack_data *data = xcalloc(1, sizeof(*data));
-	int i;
+	size_t i;
 
 	for (i = 0; i < ARRAY_SIZE(exts); i++) {
 		strbuf_reset(&path);
@@ -744,7 +744,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	struct pack_geometry *geometry = NULL;
 	struct strbuf line = STRBUF_INIT;
 	struct tempfile *refs_snapshot = NULL;
-	int i, ext, ret;
+	size_t i;
+	int ext, ret;
 	FILE *out;
 	int show_progress;
 
diff --git a/builtin/rerere.c b/builtin/rerere.c
index 94ffb8c21ab..7a0aeed3323 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -51,7 +51,8 @@ static int diff_two(const char *file1, const char *label1,
 int cmd_rerere(int argc, const char **argv, const char *prefix)
 {
 	struct string_list merge_rr = STRING_LIST_INIT_DUP;
-	int i, autoupdate = -1, flags = 0;
+	size_t i;
+	int autoupdate = -1, flags = 0;
 
 	struct option options[] = {
 		OPT_SET_INT(0, "rerere-autoupdate", &autoupdate,
diff --git a/builtin/reset.c b/builtin/reset.c
index fea20a9ba0b..0e4f3ad104a 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -49,7 +49,7 @@ static inline int is_merge(void)
 
 static int reset_index(const char *ref, const struct object_id *oid, int reset_type, int quiet)
 {
-	int i, nr = 0;
+	unsigned int i, nr = 0;
 	struct tree_desc desc[2];
 	struct tree *tree;
 	struct unpack_trees_options opts;
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index e67999e5ebc..c235e67a099 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -707,7 +707,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 
 		if (!seen_end_of_options) {
 			if (!strcmp(arg, "--local-env-vars")) {
-				int i;
+				size_t i;
 				for (i = 0; local_repo_env[i]; i++)
 					printf("%s\n", local_repo_env[i]);
 				continue;
diff --git a/builtin/rm.c b/builtin/rm.c
index 4a4aec0d00e..db152cf1757 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -49,7 +49,7 @@ static void print_error_files(struct string_list *files_list,
 			      int *errs)
 {
 	if (files_list->nr) {
-		int i;
+		size_t i;
 		struct strbuf err_msg = STRBUF_INIT;
 
 		strbuf_addstr(&err_msg, main_msg);
@@ -258,7 +258,9 @@ static struct option builtin_rm_options[] = {
 int cmd_rm(int argc, const char **argv, const char *prefix)
 {
 	struct lock_file lock_file = LOCK_INIT;
-	int i, ret = 0;
+	int i;
+	unsigned int j;
+	int ret = 0;
 	struct pathspec pathspec;
 	char *seen;
 
@@ -302,8 +304,8 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	if (pathspec_needs_expanded_index(&the_index, &pathspec))
 		ensure_full_index(&the_index);
 
-	for (i = 0; i < the_index.cache_nr; i++) {
-		const struct cache_entry *ce = the_index.cache[i];
+	for (j = 0; j < the_index.cache_nr; j++) {
+		const struct cache_entry *ce = the_index.cache[j];
 
 		if (!include_sparse &&
 		    (ce_skip_worktree(ce) ||
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index c013abaf942..31eaeb2e462 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -109,9 +109,9 @@ static void name_parent(struct commit *commit, struct commit *parent)
 			    commit_name->generation + 1);
 }
 
-static int name_first_parent_chain(struct commit *c)
+static size_t name_first_parent_chain(struct commit *c)
 {
-	int i = 0;
+	size_t i = 0;
 	while (c) {
 		struct commit *p;
 		if (!commit_to_name(c))
@@ -130,14 +130,12 @@ static int name_first_parent_chain(struct commit *c)
 	return i;
 }
 
-static void name_commits(struct commit_list *list,
-			 struct commit **rev,
-			 char **ref_name,
-			 int num_rev)
+static void name_commits(struct commit_list *list, struct commit **rev,
+			 char **ref_name, size_t num_rev)
 {
 	struct commit_list *cl;
 	struct commit *c;
-	int i;
+	size_t i;
 
 	/* First give names to the given heads */
 	for (cl = list; cl; cl = cl->next) {
@@ -213,18 +211,17 @@ static int mark_seen(struct commit *commit, struct commit_list **seen_p)
 	return 0;
 }
 
-static void join_revs(struct commit_list **list_p,
-		      struct commit_list **seen_p,
-		      int num_rev, int extra)
+static void join_revs(struct commit_list **list_p, struct commit_list **seen_p,
+		      size_t num_rev, int extra)
 {
-	int all_mask = ((1u << (REV_SHIFT + num_rev)) - 1);
-	int all_revs = all_mask & ~((1u << REV_SHIFT) - 1);
+	size_t all_mask = ((1u << (REV_SHIFT + num_rev)) - 1);
+	size_t all_revs = all_mask & ~((1u << REV_SHIFT) - 1);
 
 	while (*list_p) {
 		struct commit_list *parents;
 		int still_interesting = !!interesting(*list_p);
 		struct commit *commit = pop_commit(list_p);
-		int flags = commit->object.flags & all_mask;
+		unsigned int flags = commit->object.flags & all_mask;
 
 		if (!still_interesting && extra <= 0)
 			break;
@@ -513,11 +510,10 @@ static int show_merge_base(struct commit_list *seen, int num_rev)
 	return exit_status;
 }
 
-static int show_independent(struct commit **rev,
-			    int num_rev,
+static int show_independent(struct commit **rev, size_t num_rev,
 			    unsigned int *rev_mask)
 {
-	int i;
+	size_t i;
 
 	for (i = 0; i < num_rev; i++) {
 		struct commit *commit = rev[i];
@@ -625,7 +621,8 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 	char *reflog_msg[MAX_REVS];
 	struct commit_list *list = NULL, *seen = NULL;
 	unsigned int rev_mask[MAX_REVS];
-	int num_rev, i, extra = 0;
+	size_t num_rev, i;
+	int extra = 0;
 	int all_heads = 0, all_remotes = 0;
 	int all_mask, all_revs;
 	enum rev_sort_order sort_order = REV_SORT_IN_GRAPH_ORDER;
@@ -789,7 +786,8 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 						msg);
 			free(logmsg);
 
-			nth_desc = xstrfmt("%s@{%d}", *av, base+i);
+			nth_desc = xstrfmt("%s@{%lu}", *av,
+					   (unsigned long)(base + i));
 			append_ref(nth_desc, &oid, 1);
 			free(nth_desc);
 		}
diff --git a/builtin/show-index.c b/builtin/show-index.c
index 0e0b9fb95bc..92d5edcf77d 100644
--- a/builtin/show-index.c
+++ b/builtin/show-index.c
@@ -10,7 +10,7 @@ static const char *const show_index_usage[] = {
 
 int cmd_show_index(int argc, const char **argv, const char *prefix)
 {
-	int i;
+	unsigned int i;
 	unsigned nr;
 	unsigned int version;
 	static unsigned int top_index[256];
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 58a22503f04..09c6e61ecf0 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -78,7 +78,7 @@ static int sparse_checkout_list(int argc, const char **argv, const char *prefix)
 	}
 
 	if (pl.use_cone_patterns) {
-		int i;
+		size_t i;
 		struct pattern_entry *pe;
 		struct hashmap_iter iter;
 		struct string_list sl = STRING_LIST_INIT_DUP;
@@ -106,7 +106,8 @@ static int sparse_checkout_list(int argc, const char **argv, const char *prefix)
 
 static void clean_tracked_sparse_directories(struct repository *r)
 {
-	int i, was_full = 0;
+	unsigned int i;
+	int was_full = 0;
 	struct strbuf path = STRBUF_INIT;
 	size_t pathlen;
 	struct string_list_item *item;
@@ -263,7 +264,7 @@ static char *escaped_pattern(char *pattern)
 
 static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
 {
-	int i;
+	size_t i;
 	struct pattern_entry *pe;
 	struct hashmap_iter iter;
 	struct string_list sl = STRING_LIST_INIT_DUP;
diff --git a/builtin/stash.c b/builtin/stash.c
index bb0fd861434..8b253209158 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -850,7 +850,7 @@ static void diff_include_untracked(const struct stash_info *info, struct diff_op
 	struct tree *tree[ARRAY_SIZE(oid)];
 	struct tree_desc tree_desc[ARRAY_SIZE(oid)];
 	struct unpack_trees_options unpack_tree_opt = { 0 };
-	int i;
+	size_t i;
 
 	for (i = 0; i < ARRAY_SIZE(oid); i++) {
 		tree[i] = parse_tree_indirect(oid[i]);
@@ -1517,7 +1517,7 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 
 	repo_read_index_preload(the_repository, NULL, 0);
 	if (!include_untracked && ps->nr) {
-		int i;
+		unsigned int i;
 		char *ps_matched = xcalloc(ps->nr, 1);
 
 		/* TODO: audit for interaction with sparse-index. */
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 450680fc708..d985f79dca9 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -185,7 +185,8 @@ static int module_list_compute(const char **argv,
 			       struct pathspec *pathspec,
 			       struct module_list *list)
 {
-	int i, result = 0;
+	unsigned int i;
+	int result = 0;
 	char *ps_matched = NULL;
 
 	parse_pathspec(pathspec, 0,
@@ -251,7 +252,7 @@ static char *get_up_path(const char *path)
 	int i;
 	struct strbuf sb = STRBUF_INIT;
 
-	for (i = count_slashes(path); i; i--)
+	for (i = count_slashes(path); i > 0; i--)
 		strbuf_addstr(&sb, "../");
 
 	/*
@@ -3212,7 +3213,7 @@ static void die_on_index_match(const char *path, int force)
 		die(_("index file corrupt"));
 
 	if (ps.nr) {
-		int i;
+		unsigned int i;
 		char *ps_matched = xcalloc(ps.nr, 1);
 
 		/* TODO: audit for interaction with sparse-index. */
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 43789b8ef29..e337ca4129e 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -571,7 +571,7 @@ static void unpack_one(unsigned nr)
 
 static void unpack_all(void)
 {
-	int i;
+	unsigned int i;
 	struct pack_header *hdr = fill(sizeof(struct pack_header));
 
 	nr_objects = ntohl(hdr->hdr_entries);
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index a84e7b47a20..ded6a67a07f 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -393,7 +393,7 @@ static void update_refs_stdin(void)
 	struct strbuf input = STRBUF_INIT, err = STRBUF_INIT;
 	enum update_refs_state state = UPDATE_REFS_OPEN;
 	struct ref_transaction *transaction;
-	int i, j;
+	size_t i;
 
 	transaction = ref_transaction_begin(&err);
 	if (!transaction)
@@ -435,7 +435,7 @@ static void update_refs_stdin(void)
 		 * error in case there is an early EOF to let the command
 		 * handle missing arguments with a proper error message.
 		 */
-		for (j = 1; line_termination == '\0' && j < cmd->args; j++)
+		for (i = 1; line_termination == '\0' && i < cmd->args; i++)
 			if (strbuf_appendwholeline(&input, stdin, line_termination))
 				break;
 
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 591d659faea..c6a5f6ce2ba 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -160,7 +160,7 @@ static int prune_cmp(const void *a, const void *b)
 
 static void prune_dups(struct string_list *l)
 {
-	int i;
+	size_t i;
 
 	QSORT(l->items, l->nr, prune_cmp);
 	for (i = 1; i < l->nr; i++) {
@@ -785,7 +785,7 @@ static void show_worktree(struct worktree *wt, int path_maxlen, int abbrev_len)
 
 static void measure_widths(struct worktree **wt, int *abbrev, int *maxlen)
 {
-	int i;
+	size_t i;
 
 	for (i = 0; wt[i]; i++) {
 		int sha1_len;
@@ -925,7 +925,8 @@ static void validate_no_submodules(const struct worktree *wt)
 {
 	struct index_state istate = { NULL };
 	struct strbuf path = STRBUF_INIT;
-	int i, found_submodules = 0;
+	unsigned int i;
+	int found_submodules = 0;
 
 	if (is_directory(worktree_git_path(wt, "modules"))) {
 		/*
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 855b68ec23b..6bd0a15b671 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -48,7 +48,7 @@ static void flush_bulk_checkin_packfile(struct bulk_checkin_packfile *state)
 {
 	unsigned char hash[GIT_MAX_RAWSZ];
 	struct strbuf packname = STRBUF_INIT;
-	int i;
+	uint32_t i;
 
 	if (!state->f)
 		return;
@@ -121,7 +121,7 @@ static void flush_batch_fsync(void)
 
 static int already_written(struct bulk_checkin_packfile *state, struct object_id *oid)
 {
-	int i;
+	uint32_t i;
 
 	/* The object may already exist in the repository */
 	if (has_object_file(oid))
diff --git a/bundle.c b/bundle.c
index 4ef7256aa11..c2fee8b4eab 100644
--- a/bundle.c
+++ b/bundle.c
@@ -55,7 +55,7 @@ static int parse_capability(struct bundle_header *header, const char *capability
 
 static int parse_bundle_signature(struct bundle_header *header, const char *line)
 {
-	int i;
+	size_t i;
 
 	for (i = 0; i < ARRAY_SIZE(bundle_sigs); i++) {
 		if (!strcmp(line, bundle_sigs[i].signature)) {
@@ -162,7 +162,7 @@ int is_bundle(const char *path, int quiet)
 
 static int list_refs(struct string_list *r, int argc, const char **argv)
 {
-	int i;
+	size_t i;
 
 	for (i = 0; i < r->nr; i++) {
 		struct object_id *oid;
@@ -199,7 +199,9 @@ int verify_bundle(struct repository *r,
 	struct rev_info revs = REV_INFO_INIT;
 	const char *argv[] = {NULL, "--all", NULL};
 	struct commit *commit;
-	int i, ret = 0, req_nr;
+	size_t i;
+	int ret = 0;
+	unsigned int req_nr;
 	const char *message = _("Repository lacks these prerequisite commits:");
 
 	if (!r || !r->objects || !r->objects->odb)
@@ -333,7 +335,7 @@ out:
 static int write_pack_data(int bundle_fd, struct rev_info *revs, struct strvec *pack_options)
 {
 	struct child_process pack_objects = CHILD_PROCESS_INIT;
-	int i;
+	unsigned int i;
 
 	strvec_pushl(&pack_objects.args,
 		     "pack-objects",
@@ -387,7 +389,7 @@ static int write_pack_data(int bundle_fd, struct rev_info *revs, struct strvec *
  */
 static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
 {
-	int i;
+	unsigned int i;
 	int ref_count = 0;
 
 	for (i = 0; i < revs->pending.nr; i++) {
@@ -512,7 +514,7 @@ int create_bundle(struct repository *r, const char *path,
 	struct rev_info revs, revs_copy;
 	int min_version = 2;
 	struct bundle_prerequisites_info bpi;
-	int i;
+	unsigned int i;
 
 	/* init revs to list objects for pack-objects later */
 	save_commit_buffer = 0;
diff --git a/cache-tree.c b/cache-tree.c
index c97111cccf2..84a64498a4c 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -694,7 +694,7 @@ struct tree* write_in_core_index_as_tree(struct repository *repo) {
 
 	ret = write_index_as_tree_internal(&o, index_state, was_valid, 0, NULL);
 	if (ret == WRITE_TREE_UNMERGED_INDEX) {
-		int i;
+		unsigned int i;
 		bug("there are unmerged index entries:");
 		for (i = 0; i < index_state->cache_nr; i++) {
 			const struct cache_entry *ce = index_state->cache[i];
@@ -880,7 +880,8 @@ static int verify_one(struct repository *r,
 		      struct cache_tree *it,
 		      struct strbuf *path)
 {
-	int i, pos, len = path->len;
+	int i, pos;
+	size_t len = path->len;
 	struct strbuf tree_buf = STRBUF_INIT;
 	struct object_id new_oid;
 
@@ -953,8 +954,9 @@ static int verify_one(struct repository *r,
 			 &new_oid);
 	if (!oideq(&new_oid, &it->oid))
 		BUG("cache-tree for path %.*s does not match. "
-		    "Expected %s got %s", len, path->buf,
-		    oid_to_hex(&new_oid), oid_to_hex(&it->oid));
+		    "Expected %s got %s",
+		    (int)len, path->buf, oid_to_hex(&new_oid),
+		    oid_to_hex(&it->oid));
 	strbuf_setlen(path, len);
 	strbuf_release(&tree_buf);
 	return 0;
diff --git a/cache.h b/cache.h
index 21ed9633b2a..e0543135f05 100644
--- a/cache.h
+++ b/cache.h
@@ -1206,7 +1206,8 @@ void check_repository_format(struct repository_format *fmt);
  */
 const char *repo_find_unique_abbrev(struct repository *r, const struct object_id *oid, int len);
 #define find_unique_abbrev(oid, len) repo_find_unique_abbrev(the_repository, oid, len)
-int repo_find_unique_abbrev_r(struct repository *r, char *hex, const struct object_id *oid, int len);
+unsigned int repo_find_unique_abbrev_r(struct repository *r, char *hex,
+				       const struct object_id *oid, int len);
 #define find_unique_abbrev_r(hex, oid, len) repo_find_unique_abbrev_r(the_repository, hex, oid, len)
 
 /* set default permissions by passing mode arguments to open(2) */
@@ -1607,10 +1608,13 @@ int repo_interpret_branch_name(struct repository *r,
 
 int validate_headref(const char *ref);
 
-int base_name_compare(const char *name1, int len1, int mode1, const char *name2, int len2, int mode2);
-int df_name_compare(const char *name1, int len1, int mode1, const char *name2, int len2, int mode2);
+int base_name_compare(const char *name1, size_t len1, int mode1,
+		      const char *name2, size_t len2, int mode2);
+int df_name_compare(const char *name1, size_t len1, int mode1,
+		    const char *name2, size_t len2, int mode2);
 int name_compare(const char *name1, size_t len1, const char *name2, size_t len2);
-int cache_name_stage_compare(const char *name1, int len1, int stage1, const char *name2, int len2, int stage2);
+int cache_name_stage_compare(const char *name1, size_t len1, int stage1,
+			     const char *name2, size_t len2, int stage2);
 
 void *read_object_with_reference(struct repository *r,
 				 const struct object_id *oid,
@@ -1820,8 +1824,8 @@ extern const char *askpass_program;
 extern const char *excludes_file;
 
 /* base85 */
-int decode_85(char *dst, const char *line, int linelen);
-void encode_85(char *buf, const unsigned char *data, int bytes);
+int decode_85(char *dst, const char *line, size_t linelen);
+void encode_85(char *buf, const unsigned char *data, size_t bytes);
 
 /* pkt-line.c */
 void packet_trace_identity(const char *prog);
diff --git a/chunk-format.c b/chunk-format.c
index 0275b74a895..6981c2afd57 100644
--- a/chunk-format.c
+++ b/chunk-format.c
@@ -58,7 +58,8 @@ void add_chunk(struct chunkfile *cf,
 
 int write_chunkfile(struct chunkfile *cf, void *data)
 {
-	int i, result = 0;
+	size_t i;
+	int result = 0;
 	uint64_t cur_offset = hashfile_total(cf->f);
 
 	trace2_region_enter("chunkfile", "write", the_repository);
@@ -101,7 +102,7 @@ int read_table_of_contents(struct chunkfile *cf,
 			   uint64_t toc_offset,
 			   int toc_length)
 {
-	int i;
+	size_t i;
 	uint32_t chunk_id;
 	const unsigned char *table_of_contents = mfile + toc_offset;
 
@@ -172,7 +173,7 @@ int read_chunk(struct chunkfile *cf,
 	       chunk_read_fn fn,
 	       void *data)
 {
-	int i;
+	size_t i;
 
 	for (i = 0; i < cf->chunks_nr; i++) {
 		if (cf->chunks[i].id == chunk_id)
diff --git a/color.c b/color.c
index f05d8a81d72..caff618e9a2 100644
--- a/color.c
+++ b/color.c
@@ -54,7 +54,7 @@ struct color {
  * "word" is a buffer of length "len"; does it match the NUL-terminated
  * "match" exactly?
  */
-static int match_word(const char *word, int len, const char *match)
+static int match_word(const char *word, size_t len, const char *match)
 {
 	return !strncasecmp(word, match, len) && !match[len];
 }
@@ -73,14 +73,14 @@ static int get_hex_color(const char *in, unsigned char *out)
  * If an ANSI color is recognized in "name", fill "out" and return 0.
  * Otherwise, leave out unchanged and return -1.
  */
-static int parse_ansi_color(struct color *out, const char *name, int len)
+static int parse_ansi_color(struct color *out, const char *name, size_t len)
 {
 	/* Positions in array must match ANSI color codes */
 	static const char * const color_names[] = {
 		"black", "red", "green", "yellow",
 		"blue", "magenta", "cyan", "white"
 	};
-	int i;
+	unsigned int i;
 	int color_offset = COLOR_FOREGROUND_ANSI;
 
 	if (match_word(name, len, "default")) {
@@ -119,7 +119,7 @@ static int parse_ansi_color(struct color *out, const char *name, int len)
 	return -1;
 }
 
-static int parse_color(struct color *out, const char *name, int len)
+static int parse_color(struct color *out, const char *name, size_t len)
 {
 	char *end;
 	long val;
@@ -195,7 +195,7 @@ static int parse_attr(const char *name, size_t len)
 #undef ATTR
 	};
 	int negate = 0;
-	int i;
+	size_t i;
 
 	if (skip_prefix_mem(name, len, "no", &name, &len)) {
 		skip_prefix_mem(name, len, "-", &name, &len);
@@ -219,7 +219,8 @@ int color_parse(const char *value, char *dst)
  * already have the ANSI escape code in it. "out" should have enough
  * space in it to fit any color.
  */
-static char *color_output(char *out, int len, const struct color *c, int background)
+static char *color_output(char *out, size_t len, const struct color *c,
+			  int background)
 {
 	int offset = 0;
 
@@ -250,17 +251,17 @@ static int color_empty(const struct color *c)
 	return c->type <= COLOR_NORMAL;
 }
 
-int color_parse_mem(const char *value, int value_len, char *dst)
+int color_parse_mem(const char *value, size_t value_len, char *dst)
 {
 	const char *ptr = value;
-	int len = value_len;
+	size_t len = value_len;
 	char *end = dst + COLOR_MAXLEN;
-	unsigned int has_reset = 0;
+	int has_reset = 0;
 	unsigned int attr = 0;
 	struct color fg = { COLOR_UNSPECIFIED };
 	struct color bg = { COLOR_UNSPECIFIED };
 
-	while (len > 0 && isspace(*ptr)) {
+	while (len && isspace(*ptr)) {
 		ptr++;
 		len--;
 	}
@@ -271,10 +272,11 @@ int color_parse_mem(const char *value, int value_len, char *dst)
 	}
 
 	/* [reset] [fg [bg]] [attr]... */
-	while (len > 0) {
+	while (len) {
 		const char *word = ptr;
 		struct color c = { COLOR_UNSPECIFIED };
-		int val, wordlen = 0;
+		int val;
+		size_t wordlen = 0;
 
 		while (len > 0 && !isspace(word[wordlen])) {
 			wordlen++;
@@ -319,7 +321,7 @@ int color_parse_mem(const char *value, int value_len, char *dst)
 
 	if (has_reset || attr || !color_empty(&fg) || !color_empty(&bg)) {
 		int sep = 0;
-		int i;
+		unsigned int i;
 
 		OUT('\033');
 		OUT('[');
@@ -334,7 +336,7 @@ int color_parse_mem(const char *value, int value_len, char *dst)
 			attr &= ~bit;
 			if (sep++)
 				OUT(';');
-			dst += xsnprintf(dst, end - dst, "%d", i);
+			dst += xsnprintf(dst, end - dst, "%u", i);
 		}
 		if (!color_empty(&fg)) {
 			if (sep++)
@@ -351,7 +353,7 @@ int color_parse_mem(const char *value, int value_len, char *dst)
 	OUT(0);
 	return 0;
 bad:
-	return error(_("invalid color value: %.*s"), value_len, value);
+	return error(_("invalid color value: %.*s"), (int)value_len, value);
 #undef OUT
 }
 
diff --git a/color.h b/color.h
index cfc8f841b23..35c0cf09d08 100644
--- a/color.h
+++ b/color.h
@@ -119,7 +119,7 @@ int want_color_fd(int fd, int var);
  * name ("red"), a RGB code (#0xFF0000) or a 256-color-mode from the terminal.
  */
 int color_parse(const char *value, char *dst);
-int color_parse_mem(const char *value, int len, char *dst);
+int color_parse_mem(const char *value, size_t len, char *dst);
 
 /*
  * Output the formatted string in the specified color (and then reset to normal
diff --git a/column.c b/column.c
index 1261e18a72e..bb3e53e960d 100644
--- a/column.c
+++ b/column.c
@@ -32,7 +32,7 @@ static int item_length(const char *s)
  */
 static void layout(struct column_data *data, int *width)
 {
-	int i;
+	size_t i;
 
 	*width = 0;
 	for (i = 0; i < data->list->nr; i++)
@@ -101,7 +101,7 @@ static void shrink_columns(struct column_data *data)
 static void display_plain(const struct string_list *list,
 			  const char *indent, const char *nl)
 {
-	int i;
+	size_t i;
 
 	for (i = 0; i < list->nr; i++)
 		printf("%s%s%s", indent, list->items[i].string, nl);
@@ -146,7 +146,8 @@ static void display_table(const struct string_list *list,
 			  const struct column_options *opts)
 {
 	struct column_data data;
-	int x, y, i, initial_width;
+	int x, y, initial_width;
+	size_t i;
 	char *empty_cell;
 
 	memset(&data, 0, sizeof(data));
@@ -240,7 +241,7 @@ static int parse_option(const char *arg, int len, unsigned int *colopts,
 		{ "row",    COL_ROW,      COL_LAYOUT_MASK },
 		{ "dense",  COL_DENSE,    0 },
 	};
-	int i;
+	size_t i;
 
 	for (i = 0; i < ARRAY_SIZE(opts); i++) {
 		int set = 1, arg_len = len, name_len;
diff --git a/combine-diff.c b/combine-diff.c
index 1a39b5dde09..83924344964 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -40,7 +40,7 @@ static struct combine_diff_path *intersect_paths(
 
 	if (!n) {
 		for (i = 0; i < q->nr; i++) {
-			int len;
+			size_t len;
 			const char *path;
 			if (diff_unmodified_pair(q->queue[i]))
 				continue;
@@ -251,7 +251,7 @@ static struct lline *coalesce_lines(struct lline *base, int *lenbase,
 	/* At this point, baseend and newend point to the end of each lists */
 	i--;
 	j--;
-	while (i != 0 || j != 0) {
+	while (i > 0 || j > 0) {
 		if (directions[i][j] == MATCH) {
 			baseend->parent_map |= 1<<parent;
 			baseend = baseend->prev;
diff --git a/commit-graph.c b/commit-graph.c
index a7d87559328..d2680533353 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -501,7 +501,7 @@ static struct commit_graph *load_commit_graph_chain(struct repository *r,
 	struct strbuf line = STRBUF_INIT;
 	struct stat st;
 	struct object_id *oids;
-	int i = 0, valid = 1, count;
+	int i, valid = 1, count;
 	char *chain_name = get_commit_graph_chain_filename(odb);
 	FILE *fp;
 	int stat_res;
@@ -1045,7 +1045,8 @@ static int write_graph_chunk_fanout(struct hashfile *f,
 				    void *data)
 {
 	struct write_commit_graph_context *ctx = data;
-	int i, count = 0;
+	unsigned int i;
+	uint32_t count = 0;
 	struct commit **list = ctx->commits.list;
 
 	/*
@@ -1195,7 +1196,7 @@ static int write_graph_chunk_generation_data(struct hashfile *f,
 					     void *data)
 {
 	struct write_commit_graph_context *ctx = data;
-	int i, num_generation_data_overflows = 0;
+	size_t i, num_generation_data_overflows = 0;
 
 	for (i = 0; i < ctx->commits.nr; i++) {
 		struct commit *c = ctx->commits.list[i];
@@ -1219,7 +1220,7 @@ static int write_graph_chunk_generation_data_overflow(struct hashfile *f,
 						      void *data)
 {
 	struct write_commit_graph_context *ctx = data;
-	int i;
+	size_t i;
 	for (i = 0; i < ctx->commits.nr; i++) {
 		struct commit *c = ctx->commits.list[i];
 		timestamp_t offset = commit_graph_data_at(c)->generation - c->date;
@@ -1390,7 +1391,7 @@ static void add_missing_parents(struct write_commit_graph_context *ctx, struct c
 
 static void close_reachable(struct write_commit_graph_context *ctx)
 {
-	int i;
+	size_t i;
 	struct commit *commit;
 	enum commit_graph_split_flags flags = ctx->opts ?
 		ctx->opts->split_flags : COMMIT_GRAPH_SPLIT_UNSPECIFIED;
@@ -1448,7 +1449,7 @@ static void close_reachable(struct write_commit_graph_context *ctx)
 
 static void compute_topological_levels(struct write_commit_graph_context *ctx)
 {
-	int i;
+	size_t i;
 	struct commit_list *list = NULL;
 
 	if (ctx->report_progress)
@@ -1501,7 +1502,7 @@ static void compute_topological_levels(struct write_commit_graph_context *ctx)
 
 static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 {
-	int i;
+	size_t i;
 	struct commit_list *list = NULL;
 
 	if (ctx->report_progress)
@@ -1582,10 +1583,10 @@ static void trace2_bloom_filter_write_statistics(struct write_commit_graph_conte
 
 static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 {
-	int i;
+	size_t i;
 	struct progress *progress = NULL;
 	struct commit **sorted_commits;
-	int max_new_filters;
+	size_t max_new_filters;
 
 	init_bloom_filters();
 
diff --git a/commit-reach.c b/commit-reach.c
index c226ee3da46..4f790441f60 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -723,7 +723,8 @@ int can_all_from_reach_with_flag(struct object_array *from,
 				 timestamp_t min_generation)
 {
 	struct commit **list = NULL;
-	int i;
+	unsigned int i;
+	int j;
 	int nr_commits;
 	int result = 1;
 
@@ -760,12 +761,12 @@ int can_all_from_reach_with_flag(struct object_array *from,
 
 	QSORT(list, nr_commits, compare_commits_by_gen);
 
-	for (i = 0; i < nr_commits; i++) {
+	for (j = 0; j < nr_commits; j++) {
 		/* DFS from list[i] */
 		struct commit_list *stack = NULL;
 
-		list[i]->object.flags |= assign_flag;
-		commit_list_insert(list[i], &stack);
+		list[j]->object.flags |= assign_flag;
+		commit_list_insert(list[j], &stack);
 
 		while (stack) {
 			struct commit_list *parent;
@@ -798,7 +799,7 @@ int can_all_from_reach_with_flag(struct object_array *from,
 				pop_commit(&stack);
 		}
 
-		if (!(list[i]->object.flags & (with_flag | RESULT))) {
+		if (!(list[j]->object.flags & (with_flag | RESULT))) {
 			result = 0;
 			goto cleanup;
 		}
diff --git a/commit.c b/commit.c
index 14538a811ae..e832ead185d 100644
--- a/commit.c
+++ b/commit.c
@@ -423,8 +423,8 @@ int parse_commit_buffer(struct repository *r, struct commit *item, const void *b
 	struct object_id parent;
 	struct commit_list **pptr;
 	struct commit_graft *graft;
-	const int tree_entry_len = the_hash_algo->hexsz + 5;
-	const int parent_entry_len = the_hash_algo->hexsz + 7;
+	const size_t tree_entry_len = the_hash_algo->hexsz + 5;
+	const size_t parent_entry_len = the_hash_algo->hexsz + 7;
 	struct tree *tree;
 
 	if (item->object.parsed)
@@ -1167,7 +1167,7 @@ int remove_signature(struct strbuf *buf)
 		if (in_signature && line[0] == ' ')
 			sigp->end = next;
 		else if (starts_with(line, "gpgsig")) {
-			int i;
+			unsigned int i;
 			for (i = 1; i < GIT_HASH_NALGOS; i++) {
 				const char *p;
 				if (skip_prefix(line, gpg_sig_headers[i], &p) &&
diff --git a/compat/compiler.h b/compat/compiler.h
index 10dbb65937d..33d51f461c9 100644
--- a/compat/compiler.h
+++ b/compat/compiler.h
@@ -10,7 +10,8 @@
 
 static inline void get_compiler_info(struct strbuf *info)
 {
-	int len = info->len;
+	size_t len = info->len;
+
 #ifdef __clang__
 	strbuf_addf(info, "clang: %s\n", __clang_version__);
 #elif defined(__GNUC__)
@@ -18,8 +19,8 @@ static inline void get_compiler_info(struct strbuf *info)
 #endif
 
 #ifdef _MSC_VER
-	strbuf_addf(info, "MSVC version: %02d.%02d.%05d\n",
-		    _MSC_VER / 100, _MSC_VER % 100, _MSC_FULL_VER % 100000);
+	strbuf_addf(info, "MSVC version: %02d.%02d.%05d\n", _MSC_VER / 100,
+		    _MSC_VER % 100, _MSC_FULL_VER % 100000);
 #endif
 
 	if (len == info->len)
@@ -28,7 +29,7 @@ static inline void get_compiler_info(struct strbuf *info)
 
 static inline void get_libc_info(struct strbuf *info)
 {
-	int len = info->len;
+	size_t len = info->len;
 
 #ifdef __GLIBC__
 	strbuf_addf(info, "glibc: %s\n", gnu_get_libc_version());
diff --git a/compat/strcasestr.c b/compat/strcasestr.c
index 26896deca64..a5e69e06ba7 100644
--- a/compat/strcasestr.c
+++ b/compat/strcasestr.c
@@ -2,16 +2,16 @@
 
 char *gitstrcasestr(const char *haystack, const char *needle)
 {
-	int nlen = strlen(needle);
-	int hlen = strlen(haystack) - nlen + 1;
-	int i;
+	size_t nlen = strlen(needle);
+	size_t hlen = strlen(haystack) - nlen + 1;
+	size_t i;
 
 	for (i = 0; i < hlen; i++) {
-		int j;
+		size_t j;
 		for (j = 0; j < nlen; j++) {
 			unsigned char c1 = haystack[i+j];
 			unsigned char c2 = needle[j];
-			if (toupper(c1) != toupper(c2))
+			if (tolower(c1) != tolower(c2))
 				goto next;
 		}
 		return (char *) haystack + i;
diff --git a/compat/unsetenv.c b/compat/unsetenv.c
index b9d34af6136..8a7daff2699 100644
--- a/compat/unsetenv.c
+++ b/compat/unsetenv.c
@@ -5,7 +5,7 @@ int gitunsetenv(const char *name)
 #if !defined(__MINGW32__)
      extern char **environ;
 #endif
-     int src, dst;
+     size_t src, dst;
      size_t nmln;
 
      nmln = strlen(name);
diff --git a/compat/winansi.c b/compat/winansi.c
index 3abe8dd5a27..1cfacb0ceca 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -195,9 +195,9 @@ static void erase_in_line(void)
 		&dummy);
 }
 
-static void set_attr(char func, const int *params, int paramlen)
+static void set_attr(char func, const int *params, size_t paramlen)
 {
-	int i;
+	size_t i;
 	switch (func) {
 	case 'm':
 		for (i = 0; i < paramlen; i++) {
@@ -344,7 +344,8 @@ static DWORD WINAPI console_thread(LPVOID unused)
 {
 	unsigned char buffer[BUFFER_SIZE];
 	DWORD bytes;
-	int start, end = 0, c, parampos = 0, state = TEXT;
+	int start, end = 0, c, state = TEXT;
+	size_t parampos = 0;
 	int params[MAX_PARAMS];
 
 	while (1) {
diff --git a/config.c b/config.c
index 27f38283add..97713244a9e 100644
--- a/config.c
+++ b/config.c
@@ -721,7 +721,7 @@ int git_config_from_parameters(config_fn_t fn, void *data)
 	if (env) {
 		unsigned long count;
 		char *endp;
-		int i;
+		unsigned long i;
 
 		count = strtoul(env, &endp, 10);
 		if (*endp) {
@@ -736,7 +736,7 @@ int git_config_from_parameters(config_fn_t fn, void *data)
 		for (i = 0; i < count; i++) {
 			const char *key, *value;
 
-			strbuf_addf(&envvar, "GIT_CONFIG_KEY_%d", i);
+			strbuf_addf(&envvar, "GIT_CONFIG_KEY_%lu", i);
 			key = getenv_safe(&to_free, envvar.buf);
 			if (!key) {
 				ret = error(_("missing config key %s"), envvar.buf);
@@ -744,7 +744,7 @@ int git_config_from_parameters(config_fn_t fn, void *data)
 			}
 			strbuf_reset(&envvar);
 
-			strbuf_addf(&envvar, "GIT_CONFIG_VALUE_%d", i);
+			strbuf_addf(&envvar, "GIT_CONFIG_VALUE_%lu", i);
 			value = getenv_safe(&to_free, envvar.buf);
 			if (!value) {
 				ret = error(_("missing config value %s"), envvar.buf);
@@ -1372,7 +1372,7 @@ static enum fsync_component parse_fsync_components(const char *var, const char *
 	enum fsync_component positive = 0, negative = 0;
 
 	while (string) {
-		int i;
+		size_t i;
 		size_t len;
 		const char *ep;
 		int negated = 0;
@@ -2221,7 +2221,8 @@ int config_with_options(config_fn_t fn, void *data,
 
 static void configset_iter(struct config_set *cs, config_fn_t fn, void *data)
 {
-	int i, value_index;
+	unsigned int i;
+	size_t value_index;
 	struct string_list *values;
 	struct config_set_element *entry;
 	struct configset_list *list = &cs->list;
@@ -3008,7 +3009,7 @@ static ssize_t write_section(int fd, const char *key,
 static ssize_t write_pair(int fd, const char *key, const char *value,
 			  const struct config_store_data *store)
 {
-	int i;
+	size_t i;
 	ssize_t ret;
 	const char *quote = "";
 	struct strbuf sb = STRBUF_INIT;
@@ -3065,17 +3066,19 @@ static ssize_t write_pair(int fd, const char *key, const char *value,
  */
 static void maybe_remove_section(struct config_store_data *store,
 				 size_t *begin_offset, size_t *end_offset,
-				 int *seen_ptr)
+				 unsigned int *seen_ptr)
 {
 	size_t begin;
-	int i, seen, section_seen = 0;
+	unsigned int i;
+	unsigned int seen;
+	int section_seen = 0;
 
 	/*
 	 * First, ensure that this is the first key, and that there are no
 	 * comments before the entry nor before the section header.
 	 */
 	seen = *seen_ptr;
-	for (i = store->seen[seen]; i > 0; i--) {
+	for (i = store->seen[seen]; i; i--) {
 		enum config_event_t type = store->parsed[i - 1].type;
 
 		if (type == CONFIG_EVENT_COMMENT)
@@ -3257,7 +3260,8 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 	} else {
 		struct stat st;
 		size_t copy_begin, copy_end;
-		int i, new_line = 0;
+		unsigned int i;
+		int new_line = 0;
 		struct config_options opts;
 
 		if (!value_pattern)
@@ -3352,7 +3356,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 
 		for (i = 0, copy_begin = 0; i < store.seen_nr; i++) {
 			size_t replace_end;
-			int j = store.seen[i];
+			unsigned int j = store.seen[i];
 
 			new_line = 0;
 			if (!store.key_seen) {
@@ -3487,9 +3491,10 @@ void git_config_set_multivar(const char *key, const char *value,
 					flags);
 }
 
-static int section_name_match (const char *buf, const char *name)
+static unsigned int section_name_match(const char *buf, const char *name)
 {
-	int i = 0, j = 0, dot = 0;
+	unsigned int i = 0, j = 0;
+	int dot = 0;
 	if (buf[i] != '[')
 		return 0;
 	for (i = 1; buf[i] && buf[i] != ']'; i++) {
diff --git a/config.h b/config.h
index ef9eade6414..a0b9273c8c4 100644
--- a/config.h
+++ b/config.h
@@ -413,7 +413,7 @@ struct config_set_element {
 
 struct configset_list_item {
 	struct config_set_element *e;
-	int value_index;
+	size_t value_index;
 };
 
 /*
diff --git a/connect.c b/connect.c
index 63e59641c0d..218c40df7bf 100644
--- a/connect.c
+++ b/connect.c
@@ -385,7 +385,7 @@ static int process_ref_v2(struct packet_reader *reader, struct ref ***list,
 			  const char **unborn_head_target)
 {
 	int ret = 1;
-	int i = 0;
+	size_t i;
 	struct object_id old_oid;
 	struct ref *ref;
 	struct string_list line_sections = STRING_LIST_INIT_DUP;
@@ -403,15 +403,14 @@ static int process_ref_v2(struct packet_reader *reader, struct ref ***list,
 		goto out;
 	}
 
-	if (!strcmp("unborn", line_sections.items[i].string)) {
-		i++;
+	if (!strcmp("unborn", line_sections.items[0].string)) {
 		if (unborn_head_target &&
-		    !strcmp("HEAD", line_sections.items[i++].string)) {
+		    !strcmp("HEAD", line_sections.items[1].string)) {
 			/*
 			 * Look for the symref target (if any). If found,
 			 * return it to the caller.
 			 */
-			for (; i < line_sections.nr; i++) {
+			for (i = 2; i < line_sections.nr; i++) {
 				const char *arg = line_sections.items[i].string;
 
 				if (skip_prefix(arg, "symref-target:", &arg)) {
@@ -422,19 +421,20 @@ static int process_ref_v2(struct packet_reader *reader, struct ref ***list,
 		}
 		goto out;
 	}
-	if (parse_oid_hex_algop(line_sections.items[i++].string, &old_oid, &end, reader->hash_algo) ||
+	if (parse_oid_hex_algop(line_sections.items[0].string, &old_oid, &end,
+				reader->hash_algo) ||
 	    *end) {
 		ret = 0;
 		goto out;
 	}
 
-	ref = alloc_ref(line_sections.items[i++].string);
+	ref = alloc_ref(line_sections.items[1].string);
 
 	memcpy(ref->old_oid.hash, old_oid.hash, reader->hash_algo->rawsz);
 	**list = ref;
 	*list = &ref->next;
 
-	for (; i < line_sections.nr; i++) {
+	for (i = 2; i < line_sections.nr; i++) {
 		const char *arg = line_sections.items[i].string;
 		if (skip_prefix(arg, "symref-target:", &arg))
 			ref->symref = xstrdup(arg);
@@ -543,7 +543,7 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 			     const struct string_list *server_options,
 			     int stateless_rpc)
 {
-	int i;
+	size_t i;
 	struct strvec *ref_prefixes = transport_options ?
 		&transport_options->ref_prefixes : NULL;
 	const char **unborn_head_target = transport_options ?
diff --git a/convert.c b/convert.c
index 9b676490320..ed7412b8a45 100644
--- a/convert.c
+++ b/convert.c
@@ -313,17 +313,15 @@ static void trace_encoding(const char *context, const char *path,
 {
 	static struct trace_key coe = TRACE_KEY_INIT(WORKING_TREE_ENCODING);
 	struct strbuf trace = STRBUF_INIT;
-	int i;
+	size_t i;
 
 	strbuf_addf(&trace, "%s (%s, considered %s):\n", context, path, encoding);
 	for (i = 0; i < len && buf; ++i) {
-		strbuf_addf(
-			&trace, "| \033[2m%2i:\033[0m %2x \033[2m%c\033[0m%c",
-			i,
-			(unsigned char) buf[i],
-			(buf[i] > 32 && buf[i] < 127 ? buf[i] : ' '),
-			((i+1) % 8 && (i+1) < len ? ' ' : '\n')
-		);
+		strbuf_addf(&trace,
+			    "| \033[2m%2u:\033[0m %2x \033[2m%c\033[0m%c",
+			    (unsigned int)i, (unsigned char)buf[i],
+			    (buf[i] > 32 && buf[i] < 127 ? buf[i] : ' '),
+			    ((i + 1) % 8 && (i + 1) < len ? ' ' : '\n'));
 	}
 	strbuf_addchars(&trace, '\n', 1);
 
@@ -1815,7 +1813,7 @@ struct ident_filter {
 
 static int is_foreign_ident(const char *str)
 {
-	int i;
+	size_t i;
 
 	if (!skip_prefix(str, "$Id: ", &str))
 		return 0;
diff --git a/credential.c b/credential.c
index f6389a50684..f958c52d068 100644
--- a/credential.c
+++ b/credential.c
@@ -333,7 +333,7 @@ static int credential_do(struct credential *c, const char *helper,
 
 void credential_fill(struct credential *c)
 {
-	int i;
+	size_t i;
 
 	if (c->username && c->password)
 		return;
@@ -356,7 +356,7 @@ void credential_fill(struct credential *c)
 
 void credential_approve(struct credential *c)
 {
-	int i;
+	size_t i;
 
 	if (c->approved)
 		return;
@@ -372,7 +372,7 @@ void credential_approve(struct credential *c)
 
 void credential_reject(struct credential *c)
 {
-	int i;
+	size_t i;
 
 	credential_apply_config(c);
 
diff --git a/daemon.c b/daemon.c
index 0ae7d12b5c1..aa5ee229bd1 100644
--- a/daemon.c
+++ b/daemon.c
@@ -517,7 +517,7 @@ static struct daemon_service daemon_service[] = {
 
 static void enable_service(const char *name, int ena)
 {
-	int i;
+	size_t i;
 	for (i = 0; i < ARRAY_SIZE(daemon_service); i++) {
 		if (!strcmp(daemon_service[i].name, name)) {
 			daemon_service[i].enabled = ena;
@@ -529,7 +529,7 @@ static void enable_service(const char *name, int ena)
 
 static void make_service_overridable(const char *name, int ena)
 {
-	int i;
+	size_t i;
 	for (i = 0; i < ARRAY_SIZE(daemon_service); i++) {
 		if (!strcmp(daemon_service[i].name, name)) {
 			daemon_service[i].overridable = ena;
@@ -605,7 +605,7 @@ static void canonicalize_client(struct strbuf *out, const char *in)
 static char *parse_host_arg(struct hostinfo *hi, char *extra_args, int buflen)
 {
 	char *val;
-	int vallen;
+	size_t vallen;
 	char *end = extra_args + buflen;
 
 	if (extra_args < end && *extra_args) {
@@ -751,7 +751,8 @@ static void set_keep_alive(int sockfd)
 static int execute(void)
 {
 	char *line = packet_buffer;
-	int pktlen, len, i;
+	int pktlen, len;
+	size_t i;
 	char *addr = getenv("REMOTE_ADDR"), *port = getenv("REMOTE_PORT");
 	struct hostinfo hi = HOSTINFO_INIT;
 	struct strvec env = STRVEC_INIT;
@@ -1122,7 +1123,8 @@ static void socksetup(struct string_list *listen_addr, int listen_port, struct s
 	if (!listen_addr->nr)
 		setup_named_sock(NULL, listen_port, socklist);
 	else {
-		int i, socknum;
+		size_t i;
+		int socknum;
 		for (i = 0; i < listen_addr->nr; i++) {
 			socknum = setup_named_sock(listen_addr->items[i].string,
 						   listen_port, socklist);
@@ -1149,7 +1151,7 @@ static int service_loop(struct socketlist *socklist)
 	signal(SIGCHLD, child_handler);
 
 	for (;;) {
-		int i;
+		size_t i;
 
 		check_dead_children();
 
diff --git a/date.c b/date.c
index 53bd6a7932e..556591dd9c9 100644
--- a/date.c
+++ b/date.c
@@ -421,12 +421,12 @@ static const struct {
 
 static int match_string(const char *date, const char *str)
 {
-	int i = 0;
+	int i;
 
 	for (i = 0; *date; date++, str++, i++) {
 		if (*date == *str)
 			continue;
-		if (toupper(*date) == toupper(*str))
+		if (tolower(*date) == tolower(*str))
 			continue;
 		if (!isalnum(*date))
 			break;
diff --git a/decorate.c b/decorate.c
index 2036d159671..5654dd435d2 100644
--- a/decorate.c
+++ b/decorate.c
@@ -34,8 +34,8 @@ static void *insert_decoration(struct decoration *n, const struct object *base,
 
 static void grow_decoration(struct decoration *n)
 {
-	int i;
-	int old_size = n->size;
+	unsigned int i;
+	unsigned int old_size = n->size;
 	struct decoration_entry *old_entries = n->entries;
 
 	n->size = (old_size + 1000) * 3 / 2;
@@ -56,7 +56,7 @@ static void grow_decoration(struct decoration *n)
 void *add_decoration(struct decoration *n, const struct object *obj,
 		void *decoration)
 {
-	int nr = n->nr + 1;
+	unsigned int nr = n->nr + 1;
 
 	if (nr > n->size * 2 / 3)
 		grow_decoration(n);
diff --git a/delta-islands.c b/delta-islands.c
index 90c0d6958f4..8b951dadd14 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -243,8 +243,8 @@ void resolve_tree_islands(struct repository *r,
 {
 	struct progress *progress_state = NULL;
 	struct tree_islands_todo *todo;
-	int nr = 0;
-	int i;
+	uint32_t nr = 0;
+	uint32_t i;
 
 	if (!island_marks)
 		return;
@@ -320,7 +320,8 @@ static const char *core_island_name;
 
 static void free_config_regexes(struct island_load_data *ild)
 {
-	for (size_t i = 0; i < ild->nr; i++)
+	size_t i;
+	for (i = 0; i < ild->nr; i++)
 		regfree(&ild->rx[i]);
 	free(ild->rx);
 }
@@ -400,7 +401,8 @@ static int find_island_for_ref(const char *refname, const struct object_id *oid,
 	 * than we support.
 	 */
 	regmatch_t matches[16];
-	int i, m;
+	int i;
+	size_t m;
 	struct strbuf island_name = STRBUF_INIT;
 
 	/* walk backwards to get last-one-wins ordering */
diff --git a/diagnose.c b/diagnose.c
index 8f265698966..9206c271663 100644
--- a/diagnose.c
+++ b/diagnose.c
@@ -25,7 +25,7 @@ static struct diagnose_option diagnose_options[] = {
 
 int option_parse_diagnose(const struct option *opt, const char *arg, int unset)
 {
-	int i;
+	size_t i;
 	enum diagnose_mode *diagnose = opt->value;
 
 	if (!arg) {
diff --git a/diff-lib.c b/diff-lib.c
index dec040c366c..3282895ab18 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -556,7 +556,7 @@ static int diff_cache(struct rev_info *revs,
 
 void diff_get_merge_base(const struct rev_info *revs, struct object_id *mb)
 {
-	int i;
+	unsigned int i;
 	struct commit *mb_child[2] = {0};
 	struct commit_list *merge_bases;
 
diff --git a/diff-no-index.c b/diff-no-index.c
index 05fafd0019b..2019db4a350 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -242,7 +242,8 @@ int diff_no_index(struct rev_info *revs,
 		  int implicit_no_index,
 		  int argc, const char **argv)
 {
-	int i, no_index;
+	unsigned int i;
+	int no_index;
 	int ret = 1;
 	const char *paths[2];
 	char *to_free[ARRAY_SIZE(paths)] = { 0 };
diff --git a/diff.c b/diff.c
index 9b14543e6ed..a55af9776a5 100644
--- a/diff.c
+++ b/diff.c
@@ -124,7 +124,7 @@ static int parse_dirstat_params(struct diff_options *options, const char *params
 	char *params_copy = xstrdup(params_string);
 	struct string_list params = STRING_LIST_INIT_NODUP;
 	int ret = 0;
-	int i;
+	size_t i;
 
 	if (*params_copy)
 		string_list_split_in_place(&params, params_copy, ',', -1);
@@ -1678,7 +1678,7 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
 
 static struct diff_tempfile *claim_diff_tempfile(void)
 {
-	int i;
+	size_t i;
 	for (i = 0; i < ARRAY_SIZE(diff_temp); i++)
 		if (!diff_temp[i].name)
 			return diff_temp + i;
@@ -1687,7 +1687,7 @@ static struct diff_tempfile *claim_diff_tempfile(void)
 
 static void remove_tempfile(void)
 {
-	int i;
+	size_t i;
 	for (i = 0; i < ARRAY_SIZE(diff_temp); i++) {
 		if (is_tempfile_active(diff_temp[i].tempfile))
 			delete_tempfile(&diff_temp[i].tempfile);
@@ -2006,7 +2006,7 @@ static void fn_out_diff_words_aux(void *priv,
 
 /* This function starts looking at *begin, and returns 0 iff a word was found. */
 static int find_word_boundaries(mmfile_t *buffer, regex_t *word_regex,
-		int *begin, int *end)
+				long *begin, long *end)
 {
 	while (word_regex && *begin < buffer->size) {
 		regmatch_t match[1];
@@ -2047,7 +2047,7 @@ static int find_word_boundaries(mmfile_t *buffer, regex_t *word_regex,
 static void diff_words_fill(struct diff_words_buffer *buffer, mmfile_t *out,
 		regex_t *word_regex)
 {
-	int i, j;
+	long i, j;
 	long alloc = 0;
 
 	out->size = 0;
@@ -2188,7 +2188,7 @@ static void init_diff_words_data(struct emit_callback *ecbdata,
 				 struct diff_filespec *one,
 				 struct diff_filespec *two)
 {
-	int i;
+	size_t i;
 	struct diff_options *o = xmalloc(sizeof(struct diff_options));
 	memcpy(o, orig_opts, sizeof(struct diff_options));
 
@@ -3305,8 +3305,8 @@ static void emit_binary_diff_body(struct diff_options *o,
 	/* emit data encoded in base85 */
 	cp = data;
 	while (data_size) {
-		int len;
-		int bytes = (52 < data_size) ? 52 : data_size;
+		size_t len;
+		size_t bytes = (52 < data_size) ? 52 : data_size;
 		char line[71];
 		data_size -= bytes;
 		if (bytes <= 26)
@@ -3415,7 +3415,7 @@ static void add_formatted_headers(struct strbuf *msg,
 				  const char *meta,
 				  const char *reset)
 {
-	int i;
+	size_t i;
 
 	for (i = 0; i < more_headers->nr; i++)
 		add_formatted_header(msg, more_headers->items[i].string,
@@ -4680,7 +4680,7 @@ static unsigned int filter_bit['Z' + 1];
 
 static void prepare_filter_bits(void)
 {
-	int i;
+	unsigned int i;
 
 	if (!filter_bit[DIFF_STATUS_ADDED]) {
 		for (i = 0; diff_status_letters[i]; i++)
@@ -4911,7 +4911,8 @@ static int diff_opt_diff_filter(const struct option *option,
 				const char *optarg, int unset)
 {
 	struct diff_options *opt = option->value;
-	int i, optch;
+	size_t i;
+	int optch;
 
 	BUG_ON_OPT_NEG(unset);
 	prepare_filter_bits();
@@ -5250,7 +5251,7 @@ static int diff_opt_patience(const struct option *opt,
 			     const char *arg, int unset)
 {
 	struct diff_options *options = opt->value;
-	int i;
+	size_t i;
 
 	BUG_ON_OPT_NEG(unset);
 	BUG_ON_OPT_ARG(arg);
@@ -6173,12 +6174,12 @@ static void diff_summary(struct diff_options *opt, struct diff_filepair *p)
 
 struct patch_id_t {
 	git_hash_ctx *ctx;
-	int patchlen;
+	size_t patchlen;
 };
 
-static int remove_space(char *line, int len)
+static size_t remove_space(char *line, unsigned long len)
 {
-	int i;
+	unsigned long i;
 	char *dst = line;
 	unsigned char c;
 
@@ -6208,7 +6209,7 @@ void flush_one_hunk(struct object_id *result, git_hash_ctx *ctx)
 static int patch_id_consume(void *priv, char *line, unsigned long len)
 {
 	struct patch_id_t *data = priv;
-	int new_len;
+	size_t new_len;
 
 	if (len > 12 && starts_with(line, "\\ "))
 		return 0;
@@ -6250,7 +6251,7 @@ static int diff_get_patch_id(struct diff_options *options, struct object_id *oid
 		xdemitconf_t xecfg;
 		mmfile_t mf1, mf2;
 		struct diff_filepair *p = q->queue[i];
-		int len1, len2;
+		size_t len1, len2;
 
 		memset(&xpp, 0, sizeof(xpp));
 		memset(&xecfg, 0, sizeof(xecfg));
diff --git a/dir.c b/dir.c
index fbdb24fc819..9f232ca5364 100644
--- a/dir.c
+++ b/dir.c
@@ -2981,7 +2981,8 @@ static void emit_traversal_statistics(struct dir_struct *dir,
 }
 
 int read_directory(struct dir_struct *dir, struct index_state *istate,
-		   const char *path, int len, const struct pathspec *pathspec)
+		   const char *path, unsigned int len,
+		   const struct pathspec *pathspec)
 {
 	struct untracked_cache_dir *untracked;
 
diff --git a/dir.h b/dir.h
index 8acfc044181..73cdff47c9e 100644
--- a/dir.h
+++ b/dir.h
@@ -374,7 +374,7 @@ int fill_directory(struct dir_struct *dir,
 		   struct index_state *istate,
 		   const struct pathspec *pathspec);
 int read_directory(struct dir_struct *, struct index_state *istate,
-		   const char *path, int len,
+		   const char *path, unsigned int len,
 		   const struct pathspec *pathspec);
 
 enum pattern_match_result {
diff --git a/fsck.c b/fsck.c
index b3da1d68c0b..c51a4aa3d06 100644
--- a/fsck.c
+++ b/fsck.c
@@ -35,7 +35,7 @@ static struct {
 
 static void prepare_msg_ids(void)
 {
-	int i;
+	size_t i;
 
 	if (msg_id_info[0].downcased)
 		return;
@@ -43,7 +43,7 @@ static void prepare_msg_ids(void)
 	/* convert id_string to lower case, without underscores. */
 	for (i = 0; i < FSCK_MSG_MAX; i++) {
 		const char *p = msg_id_info[i].id_string;
-		int len = strlen(p);
+		size_t len = strlen(p);
 		char *q = xmalloc(len);
 
 		msg_id_info[i].downcased = q;
diff --git a/git.c b/git.c
index 32a5be68a17..f8caf5ec9e2 100644
--- a/git.c
+++ b/git.c
@@ -42,7 +42,7 @@ static void list_builtins(struct string_list *list, unsigned int exclude_option)
 
 static void exclude_helpers_from_list(struct string_list *list)
 {
-	int i = 0;
+	size_t i = 0;
 
 	while (i < list->nr) {
 		if (strstr(list->items[i].string, "--"))
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index ee01bcd2cc3..dcb84ee81e9 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -397,7 +397,7 @@ void list_objects_filter_copy(
 	struct list_objects_filter_options *dest,
 	const struct list_objects_filter_options *src)
 {
-	int i;
+	size_t i;
 
 	/* Copy everything. We will overwrite the pointers shortly. */
 	memcpy(dest, src, sizeof(struct list_objects_filter_options));
diff --git a/merge-recursive.c b/merge-recursive.c
index 2fd0aa96875..d41b10f13cc 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -877,7 +877,8 @@ static int was_dirty(struct merge_options *opt, const char *path)
 
 static int make_room_for_path(struct merge_options *opt, const char *path)
 {
-	int status, i;
+	int status;
+	size_t i;
 	const char *msg = _("failed to create path '%s'%s");
 
 	/* Unlink any D/F conflict files that are in the way */
@@ -3805,7 +3806,7 @@ static struct commit *get_ref(struct repository *repo,
 int merge_recursive_generic(struct merge_options *opt,
 			    const struct object_id *head,
 			    const struct object_id *merge,
-			    int num_merge_bases,
+			    unsigned int num_merge_bases,
 			    const struct object_id **merge_bases,
 			    struct commit **result)
 {
@@ -3816,7 +3817,7 @@ int merge_recursive_generic(struct merge_options *opt,
 	struct commit_list *ca = NULL;
 
 	if (merge_bases) {
-		int i;
+		unsigned int i;
 		for (i = 0; i < num_merge_bases; ++i) {
 			struct commit *base;
 			if (!(base = get_ref(opt->repo, merge_bases[i],
diff --git a/merge-recursive.h b/merge-recursive.h
index b88000e3c25..f8d7517dc50 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -118,7 +118,7 @@ int merge_recursive(struct merge_options *opt,
 int merge_recursive_generic(struct merge_options *opt,
 			    const struct object_id *head,
 			    const struct object_id *merge,
-			    int num_merge_bases,
+			    unsigned int num_merge_bases,
 			    const struct object_id **merge_bases,
 			    struct commit **result);
 
diff --git a/notes.c b/notes.c
index f2805d51bb1..e800007434f 100644
--- a/notes.c
+++ b/notes.c
@@ -956,7 +956,7 @@ void string_list_add_refs_from_colon_sep(struct string_list *list,
 {
 	struct string_list split = STRING_LIST_INIT_NODUP;
 	char *globs_copy = xstrdup(globs);
-	int i;
+	size_t i;
 
 	string_list_split_in_place(&split, globs_copy, ':', -1);
 	string_list_remove_empty_items(&split, 0);
diff --git a/object-name.c b/object-name.c
index 2dd1a0f56e1..7aa105f69b4 100644
--- a/object-name.c
+++ b/object-name.c
@@ -758,8 +758,8 @@ static void find_abbrev_len_packed(struct min_abbrev_data *mad)
 		find_abbrev_len_for_pack(p, mad);
 }
 
-int repo_find_unique_abbrev_r(struct repository *r, char *hex,
-			      const struct object_id *oid, int len)
+unsigned int repo_find_unique_abbrev_r(struct repository *r, char *hex,
+				       const struct object_id *oid, int len)
 {
 	struct disambiguate_state ds;
 	struct min_abbrev_data mad;
@@ -818,7 +818,7 @@ const char *repo_find_unique_abbrev(struct repository *r,
 				    const struct object_id *oid,
 				    int len)
 {
-	static int bufno;
+	static unsigned int bufno;
 	static char hexbuffer[4][GIT_MAX_HEXSZ + 1];
 	char *hex = hexbuffer[bufno];
 	bufno = (bufno + 1) % ARRAY_SIZE(hexbuffer);
diff --git a/range-diff.c b/range-diff.c
index 8255ab4349c..fc48c930e41 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -38,7 +38,7 @@ static int read_patches(const char *range, struct string_list *list,
 	struct patch_util *util = NULL;
 	int in_header = 1;
 	char *line, *current_filename = NULL;
-	ssize_t len;
+	size_t len;
 	size_t size;
 	int ret = -1;
 
@@ -117,7 +117,7 @@ static int read_patches(const char *range, struct string_list *list,
 			struct patch patch = { 0 };
 			struct strbuf root = STRBUF_INIT;
 			int linenr = 0;
-			int orig_len;
+			int orig_len, output;
 
 			in_header = 0;
 			strbuf_addch(&buf, '\n');
@@ -126,15 +126,16 @@ static int read_patches(const char *range, struct string_list *list,
 			if (eol)
 				*eol = '\n';
 			orig_len = len;
-			len = parse_git_diff_header(&root, &linenr, 0, line,
-						    len, size, &patch);
-			if (len < 0) {
+			output = parse_git_diff_header(&root, &linenr, 0, line,
+						       len, size, &patch);
+			if (output < 0) {
 				error(_("could not parse git header '%.*s'"),
 				      orig_len, line);
 				FREE_AND_NULL(util);
 				string_list_clear(list, 1);
 				goto cleanup;
 			}
+			len = output;
 			strbuf_addstr(&buf, " ## ");
 			if (patch.is_new > 0)
 				strbuf_addf(&buf, "%s (new)", patch.new_name);
@@ -582,7 +583,7 @@ int is_range_diff_range(const char *arg)
 {
 	char *copy = xstrdup(arg); /* setup_revisions() modifies it */
 	const char *argv[] = { "", copy, "--", NULL };
-	int i, positive = 0, negative = 0;
+	unsigned int i, positive = 0, negative = 0;
 	struct rev_info revs;
 
 	init_revisions(&revs, NULL);
@@ -603,5 +604,5 @@ int is_range_diff_range(const char *arg)
 
 	free(copy);
 	release_revisions(&revs);
-	return negative > 0 && positive > 0;
+	return negative != 0 && positive != 0;
 }
diff --git a/read-cache.c b/read-cache.c
index 1ff518b2a7f..8717dc3b56b 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -109,7 +109,8 @@ static struct mem_pool *find_mem_pool(struct index_state *istate)
 
 static const char *alternate_index_output;
 
-static void set_index_entry(struct index_state *istate, int nr, struct cache_entry *ce)
+static void set_index_entry(struct index_state *istate, unsigned int nr,
+			    struct cache_entry *ce)
 {
 	if (S_ISSPARSEDIR(ce->ce_mode))
 		istate->sparse_index = INDEX_COLLAPSED;
@@ -118,7 +119,8 @@ static void set_index_entry(struct index_state *istate, int nr, struct cache_ent
 	add_name_hash(istate, ce);
 }
 
-static void replace_index_entry(struct index_state *istate, int nr, struct cache_entry *ce)
+static void replace_index_entry(struct index_state *istate, unsigned int nr,
+				struct cache_entry *ce)
 {
 	struct cache_entry *old = istate->cache[nr];
 
@@ -488,11 +490,11 @@ int ie_modified(struct index_state *istate,
 	return 0;
 }
 
-int base_name_compare(const char *name1, int len1, int mode1,
-		      const char *name2, int len2, int mode2)
+int base_name_compare(const char *name1, size_t len1, int mode1,
+		      const char *name2, size_t len2, int mode2)
 {
 	unsigned char c1, c2;
-	int len = len1 < len2 ? len1 : len2;
+	size_t len = len1 < len2 ? len1 : len2;
 	int cmp;
 
 	cmp = memcmp(name1, name2, len);
@@ -517,10 +519,10 @@ int base_name_compare(const char *name1, int len1, int mode1,
  * This is used by routines that want to traverse the git namespace
  * but then handle conflicting entries together when possible.
  */
-int df_name_compare(const char *name1, int len1, int mode1,
-		    const char *name2, int len2, int mode2)
+int df_name_compare(const char *name1, size_t len1, int mode1,
+		    const char *name2, size_t len2, int mode2)
 {
-	int len = len1 < len2 ? len1 : len2, cmp;
+	size_t len = len1 < len2 ? len1 : len2, cmp;
 	unsigned char c1, c2;
 
 	cmp = memcmp(name1, name2, len);
@@ -555,7 +557,8 @@ int name_compare(const char *name1, size_t len1, const char *name2, size_t len2)
 	return 0;
 }
 
-int cache_name_stage_compare(const char *name1, int len1, int stage1, const char *name2, int len2, int stage2)
+int cache_name_stage_compare(const char *name1, size_t len1, int stage1,
+			     const char *name2, size_t len2, int stage2)
 {
 	int cmp;
 
@@ -703,7 +706,7 @@ static int index_name_pos_also_unmerged(struct index_state *istate,
 		return pos;
 
 	/* maybe unmerged? */
-	pos = -1 - pos;
+	pos = -pos - 1;
 	if (pos >= istate->cache_nr ||
 			compare_name((ce = istate->cache[pos]), path, namelen))
 		return -1;
@@ -718,7 +721,7 @@ static int index_name_pos_also_unmerged(struct index_state *istate,
 
 static int different_name(struct cache_entry *ce, struct cache_entry *alias)
 {
-	int len = ce_namelen(ce);
+	unsigned int len = ce_namelen(ce);
 	return ce_namelen(alias) != len || memcmp(ce->name, alias->name, len);
 }
 
@@ -735,7 +738,7 @@ static struct cache_entry *create_alias_ce(struct index_state *istate,
 					   struct cache_entry *ce,
 					   struct cache_entry *alias)
 {
-	int len;
+	unsigned int len;
 	struct cache_entry *new_entry;
 
 	if (alias->ce_flags & CE_ADDED)
@@ -902,7 +905,7 @@ struct cache_entry *make_cache_entry(struct index_state *istate,
 				     unsigned int refresh_options)
 {
 	struct cache_entry *ce, *ret;
-	int len;
+	size_t len;
 
 	if (verify_path_internal(path, mode) == PATH_INVALID) {
 		error(_("invalid path '%s'"), path);
@@ -931,7 +934,7 @@ struct cache_entry *make_transient_cache_entry(unsigned int mode,
 					       struct mem_pool *ce_mem_pool)
 {
 	struct cache_entry *ce;
-	int len;
+	size_t len;
 
 	if (!verify_path(path, mode)) {
 		error(_("invalid path '%s'"), path);
@@ -982,7 +985,7 @@ int chmod_index_entry(struct index_state *istate, struct cache_entry *ce,
 
 int ce_same_name(const struct cache_entry *a, const struct cache_entry *b)
 {
-	int len = ce_namelen(a);
+	unsigned int len = ce_namelen(a);
 	return ce_namelen(b) == len && !memcmp(a->name, b->name, len);
 }
 
@@ -1109,8 +1112,8 @@ static int has_file_name(struct index_state *istate,
 			 const struct cache_entry *ce, int pos, int ok_to_replace)
 {
 	int retval = 0;
-	int len = ce_namelen(ce);
-	int stage = ce_stage(ce);
+	unsigned int len = ce_namelen(ce);
+	unsigned int stage = ce_stage(ce);
 	const char *name = ce->name;
 
 	while (pos < istate->cache_nr) {
@@ -1151,7 +1154,7 @@ int strcmp_offset(const char *s1, const char *s2, size_t *first_change)
 			break;
 
 	*first_change = k;
-	return (unsigned char)s1[k] - (unsigned char)s2[k];
+	return (const unsigned char)s1[k] - (const unsigned char)s2[k];
 }
 
 /*
@@ -1598,7 +1601,7 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 		  const struct pathspec *pathspec,
 		  char *seen, const char *header_msg)
 {
-	int i;
+	unsigned int i;
 	int has_errors = 0;
 	int really = (flags & REFRESH_REALLY) != 0;
 	int allow_unmerged = (flags & REFRESH_UNMERGED) != 0;
@@ -2762,7 +2765,7 @@ static int ce_write_entry(struct hashfile *f, struct cache_entry *ce,
 	size = offsetof(struct ondisk_cache_entry,data) + ondisk_data_size(ce->ce_flags, 0);
 
 	if (!previous_name) {
-		int len = ce_namelen(ce);
+		unsigned int len = ce_namelen(ce);
 		copy_cache_entry_to_ondisk(ondisk, ce);
 		hashwrite(f, ondisk, size);
 		hashwrite(f, ce->name, len);
@@ -2842,8 +2845,8 @@ static int repo_verify_index(struct repository *repo)
 
 int has_racy_timestamp(struct index_state *istate)
 {
-	int entries = istate->cache_nr;
-	int i;
+	unsigned int entries = istate->cache_nr;
+	unsigned int i;
 
 	for (i = 0; i < entries; i++) {
 		struct cache_entry *ce = istate->cache[i];
@@ -3471,7 +3474,7 @@ int repo_read_index_unmerged(struct repository *repo)
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
 		struct cache_entry *new_ce;
-		int len;
+		unsigned int len;
 
 		if (!ce_stage(ce))
 			continue;
diff --git a/run-command.c b/run-command.c
index 756f1839aab..511bed961c3 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1632,9 +1632,9 @@ static void pp_buffer_stderr(struct parallel_processes *pp,
 			     const struct run_process_parallel_opts *opts,
 			     int output_timeout)
 {
-	int i;
+	size_t i;
 
-	while ((i = poll(pp->pfd, opts->processes, output_timeout) < 0)) {
+	while (poll(pp->pfd, opts->processes, output_timeout) < 0) {
 		if (errno == EINTR)
 			continue;
 		pp_cleanup(pp, opts);
@@ -1642,11 +1642,12 @@ static void pp_buffer_stderr(struct parallel_processes *pp,
 	}
 
 	/* Buffer output from all pipes. */
-	for (size_t i = 0; i < opts->processes; i++) {
+	for (i = 0; i < opts->processes; i++) {
 		if (pp->children[i].state == GIT_CP_WORKING &&
 		    pp->pfd[i].revents & (POLLIN | POLLHUP)) {
-			int n = strbuf_read_once(&pp->children[i].err,
-						 pp->children[i].process.err, 0);
+			ssize_t n = strbuf_read_once(
+				&pp->children[i].err,
+				pp->children[i].process.err, 0);
 			if (n == 0) {
 				close(pp->children[i].process.err);
 				pp->children[i].state = GIT_CP_WAIT_CLEANUP;
diff --git a/shallow.c b/shallow.c
index 17f9bcdb5f3..e791c8160a8 100644
--- a/shallow.c
+++ b/shallow.c
@@ -803,7 +803,7 @@ static void post_assign_shallow(struct shallow_info *info,
 }
 
 /* (Delayed) step 7, reachability test at commit level */
-int delayed_reachability_test(struct shallow_info *si, int c)
+int delayed_reachability_test(struct shallow_info *si, size_t c)
 {
 	if (si->need_reachability_test[c]) {
 		struct commit *commit = lookup_commit(the_repository,
diff --git a/shallow.h b/shallow.h
index aba6ff58294..be77c0db079 100644
--- a/shallow.h
+++ b/shallow.h
@@ -76,7 +76,7 @@ void remove_nonexistent_theirs_shallow(struct shallow_info *);
 void assign_shallow_commits_to_refs(struct shallow_info *info,
 				    uint32_t **used,
 				    int *ref_status);
-int delayed_reachability_test(struct shallow_info *si, int c);
+int delayed_reachability_test(struct shallow_info *si, size_t c);
 
 extern struct trace_key trace_shallow;
 
diff --git a/strbuf.c b/strbuf.c
index c383f41a3c5..a6eca686b6d 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -172,7 +172,7 @@ struct strbuf **strbuf_split_buf(const char *str, size_t slen,
 	struct strbuf *t;
 
 	while (slen) {
-		int len = slen;
+		size_t len = slen;
 		if (max <= 0 || nr + 1 < max) {
 			const char *end = memchr(str, terminator, slen);
 			if (end)
@@ -1075,7 +1075,7 @@ void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm,
 void strbuf_repo_add_unique_abbrev(struct strbuf *sb, struct repository *repo,
 				   const struct object_id *oid, int abbrev_len)
 {
-	int r;
+	unsigned int r;
 	strbuf_grow(sb, GIT_MAX_HEXSZ + 1);
 	r = repo_find_unique_abbrev_r(repo, sb->buf + sb->len, oid, abbrev_len);
 	strbuf_setlen(sb, sb->len + r);
diff --git a/string-list.c b/string-list.c
index 42bacaec55b..29208b2f51b 100644
--- a/string-list.c
+++ b/string-list.c
@@ -263,7 +263,8 @@ int unsorted_string_list_has_string(struct string_list *list,
 	return unsorted_string_list_lookup(list, string) != NULL;
 }
 
-void unsorted_string_list_delete_item(struct string_list *list, int i, int free_util)
+void unsorted_string_list_delete_item(struct string_list *list, size_t i,
+				      int free_util)
 {
 	if (list->strdup_strings)
 		free(list->items[i].string);
diff --git a/string-list.h b/string-list.h
index c7b0d5d0008..401d0bc1052 100644
--- a/string-list.h
+++ b/string-list.h
@@ -241,7 +241,8 @@ struct string_list_item *unsorted_string_list_lookup(struct string_list *list,
  * string_list is set. The third parameter controls if the `util`
  * pointer of the items should be freed or not.
  */
-void unsorted_string_list_delete_item(struct string_list *list, int i, int free_util);
+void unsorted_string_list_delete_item(struct string_list *list, size_t i,
+				      int free_util);
 
 /**
  * Split string into substrings on character `delim` and append the
diff --git a/sub-process.c b/sub-process.c
index 6d4232294db..1d380ef0405 100644
--- a/sub-process.c
+++ b/sub-process.c
@@ -116,7 +116,7 @@ static int handshake_version(struct child_process *process,
 			     int *chosen_version)
 {
 	int version_scratch;
-	int i;
+	size_t i;
 	char *line;
 	const char *p;
 
@@ -162,7 +162,7 @@ static int handshake_capabilities(struct child_process *process,
 				  struct subprocess_capability *capabilities,
 				  unsigned int *supported_capabilities)
 {
-	int i;
+	size_t i;
 	char *line;
 
 	for (i = 0; capabilities[i].name; i++) {
diff --git a/submodule.c b/submodule.c
index 3a0dfc417c0..65937c1eaf1 100644
--- a/submodule.c
+++ b/submodule.c
@@ -173,10 +173,10 @@ void add_submodule_odb_by_path(const char *path)
 	string_list_insert(&added_submodule_odb_paths, xstrdup(path));
 }
 
-int register_all_submodule_odb_as_alternates(void)
+size_t register_all_submodule_odb_as_alternates(void)
 {
-	int i;
-	int ret = added_submodule_odb_paths.nr;
+	size_t i;
+	size_t ret = added_submodule_odb_paths.nr;
 
 	for (i = 0; i < added_submodule_odb_paths.nr; i++)
 		add_to_alternates_memory(added_submodule_odb_paths.items[i].string);
@@ -324,7 +324,7 @@ int is_submodule_populated_gently(const char *path, int *return_error_code)
 void die_in_unpopulated_submodule(struct index_state *istate,
 				  const char *prefix)
 {
-	int i, prefixlen;
+	size_t i, prefixlen;
 
 	if (!prefix)
 		return;
@@ -333,7 +333,7 @@ void die_in_unpopulated_submodule(struct index_state *istate,
 
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
-		int ce_len = ce_namelen(ce);
+		size_t ce_len = ce_namelen(ce);
 
 		if (!S_ISGITLINK(ce->ce_mode))
 			continue;
@@ -354,7 +354,8 @@ void die_in_unpopulated_submodule(struct index_state *istate,
 void die_path_inside_submodule(struct index_state *istate,
 			       const struct pathspec *ps)
 {
-	int i, j;
+	unsigned int i;
+	int j;
 
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
@@ -1206,7 +1207,8 @@ int push_unpushed_submodules(struct repository *r,
 			     const struct string_list *push_options,
 			     int dry_run)
 {
-	int i, ret = 1;
+	size_t i;
+	int ret = 1;
 	struct string_list needs_pushing = STRING_LIST_INIT_DUP;
 
 	if (!find_unpushed_submodules(r, commits,
diff --git a/submodule.h b/submodule.h
index c55a25ca37d..a62af231e59 100644
--- a/submodule.h
+++ b/submodule.h
@@ -109,7 +109,7 @@ int bad_to_remove_submodule(const char *path, unsigned flags);
  * added as alternates in the_repository.
  */
 void add_submodule_odb_by_path(const char *path);
-int register_all_submodule_odb_as_alternates(void);
+size_t register_all_submodule_odb_as_alternates(void);
 
 /*
  * Checks if there are submodule changes in a..b. If a is the null OID,
diff --git a/trailer.c b/trailer.c
index 0fd5b142a37..be42417fe04 100644
--- a/trailer.c
+++ b/trailer.c
@@ -518,7 +518,7 @@ static int git_trailer_config(const char *conf_key, const char *value,
 	struct conf_info *conf;
 	char *name = NULL;
 	enum trailer_info_type type;
-	int i;
+	size_t i;
 
 	if (!skip_prefix(conf_key, "trailer.", &trailer_item))
 		return 0;
diff --git a/transport-helper.c b/transport-helper.c
index 3ea7c2bb5ad..20de136f242 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -295,7 +295,8 @@ static int string_list_set_helper_option(struct helper_data *data,
 					 struct string_list *list)
 {
 	struct strbuf buf = STRBUF_INIT;
-	int i, ret = 0;
+	int ret = 0;
+	size_t i;
 
 	for (i = 0; i < list->nr; i++) {
 		strbuf_addf(&buf, "option %s ", name);
@@ -315,7 +316,8 @@ static int set_helper_option(struct transport *transport,
 {
 	struct helper_data *data = transport->data;
 	struct strbuf buf = STRBUF_INIT;
-	int i, ret, is_bool = 0;
+	size_t i;
+	int ret, is_bool = 0;
 
 	get_helper(transport);
 
@@ -459,7 +461,7 @@ static int get_exporter(struct transport *transport,
 {
 	struct helper_data *data = transport->data;
 	struct child_process *helper = get_helper(transport);
-	int i;
+	size_t i;
 
 	child_process_init(fastexport);
 
diff --git a/transport.c b/transport.c
index 77a61a9d7bb..8d949a9bdb5 100644
--- a/transport.c
+++ b/transport.c
@@ -42,7 +42,7 @@ static int transport_color_config(void)
 		"color.transport.rejected"
 	}, *key = "color.transport";
 	char *value;
-	int i;
+	size_t i;
 	static int initialized;
 
 	if (initialized)
@@ -147,7 +147,7 @@ static struct ref *get_refs_from_bundle(struct transport *transport,
 {
 	struct bundle_transport_data *data = transport->data;
 	struct ref *result = NULL;
-	int i;
+	size_t i;
 
 	if (for_push)
 		return NULL;
@@ -1233,7 +1233,7 @@ void transport_set_verbosity(struct transport *transport, int verbosity,
 
 static void die_with_unpushed_submodules(struct string_list *needs_pushing)
 {
-	int i;
+	size_t i;
 
 	fprintf(stderr, _("The following submodule paths contain changes that can\n"
 			"not be found on any remote:\n"));
@@ -1552,7 +1552,7 @@ int transport_get_remote_bundle_uri(struct transport *transport)
 void transport_unlock_pack(struct transport *transport, unsigned int flags)
 {
 	int in_signal_handler = !!(flags & TRANSPORT_UNLOCK_PACK_IN_SIGNAL_HANDLER);
-	int i;
+	size_t i;
 
 	for (i = 0; i < transport->pack_lockfiles.nr; i++)
 		if (in_signal_handler)
diff --git a/unpack-trees.c b/unpack-trees.c
index ea09023b015..6c608a9246c 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2284,8 +2284,8 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
 	 * we are about to extract "ce->name"; we would not want to lose
 	 * anything in the existing directory there.
 	 */
-	int namelen;
-	int i;
+	unsigned int namelen;
+	unsigned int i;
 	struct dir_struct d;
 	char *pathbuf;
 	int cnt = 0;
@@ -2312,7 +2312,7 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
 	     i < o->src_index->cache_nr;
 	     i++) {
 		struct cache_entry *ce2 = o->src_index->cache[i];
-		int len = ce_namelen(ce2);
+		unsigned int len = ce_namelen(ce2);
 		if (len < namelen ||
 		    strncmp(ce->name, ce2->name, namelen) ||
 		    ce2->name[namelen] != '/')
@@ -2332,7 +2332,7 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
 	}
 
 	/* Do not lose a locally present file that is not ignored. */
-	pathbuf = xstrfmt("%.*s/", namelen, ce->name);
+	pathbuf = xstrfmt("%.*s/", (int)namelen, ce->name);
 
 	memset(&d, 0, sizeof(d));
 	if (o->dir)
@@ -2875,7 +2875,7 @@ int twoway_merge(const struct cache_entry * const *src,
 	const struct cache_entry *newtree = src[2];
 
 	if (o->merge_size != 2)
-		return error("Cannot do a twoway merge of %d trees",
+		return error("Cannot do a twoway merge of %u trees",
 			     o->merge_size);
 
 	if (oldtree == o->df_conflict_entry)
@@ -2957,7 +2957,7 @@ int bind_merge(const struct cache_entry * const *src,
 	const struct cache_entry *a = src[1];
 
 	if (o->merge_size != 1)
-		return error("Cannot do a bind merge of %d trees",
+		return error("Cannot do a bind merge of %u trees",
 			     o->merge_size);
 	if (a && old)
 		return o->quiet ? -1 :
@@ -2983,7 +2983,7 @@ int oneway_merge(const struct cache_entry * const *src,
 	const struct cache_entry *a = src[1];
 
 	if (o->merge_size != 1)
-		return error("Cannot do a oneway merge of %d trees",
+		return error("Cannot do a oneway merge of %u trees",
 			     o->merge_size);
 
 	if (!a || a == o->df_conflict_entry)
@@ -3020,7 +3020,7 @@ int stash_worktree_untracked_merge(const struct cache_entry * const *src,
 	const struct cache_entry *untracked = src[2];
 
 	if (o->merge_size != 2)
-		BUG("invalid merge_size: %d", o->merge_size);
+		BUG("invalid merge_size: %u", o->merge_size);
 
 	if (worktree && untracked)
 		return error(_("worktree and untracked commit have duplicate entries: %s"),
diff --git a/unpack-trees.h b/unpack-trees.h
index 3a7b3e5f007..f2d87900c9d 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -88,7 +88,7 @@ struct unpack_trees_options {
 	struct string_list unpack_rejects[NB_UNPACK_TREES_WARNING_TYPES];
 
 	int head_idx;
-	int merge_size;
+	unsigned merge_size;
 
 	struct cache_entry *df_conflict_entry;
 	void *unpack_data;
diff --git a/wt-status.c b/wt-status.c
index 3162241a570..d58fd61bf6d 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -151,7 +151,7 @@ void wt_status_prepare(struct repository *r, struct wt_status *s)
 
 static void wt_longstatus_print_unmerged_header(struct wt_status *s)
 {
-	int i;
+	size_t i;
 	int del_mod_conflict = 0;
 	int both_deleted = 0;
 	int not_deleted = 0;
@@ -700,7 +700,7 @@ static int add_file_to_list(const struct object_id *oid,
 static void wt_status_collect_changes_initial(struct wt_status *s)
 {
 	struct index_state *istate = s->repo->index;
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct string_list_item *it;
@@ -803,7 +803,7 @@ static void wt_status_collect_untracked(struct wt_status *s)
 
 static int has_unmerged(struct wt_status *s)
 {
-	int i;
+	size_t i;
 
 	for (i = 0; i < s->change.nr; i++) {
 		struct wt_status_change_data *d;
@@ -854,7 +854,7 @@ void wt_status_state_free_buffers(struct wt_status_state *state)
 static void wt_longstatus_print_unmerged(struct wt_status *s)
 {
 	int shown_header = 0;
-	int i;
+	size_t i;
 
 	for (i = 0; i < s->change.nr; i++) {
 		struct wt_status_change_data *d;
@@ -877,7 +877,7 @@ static void wt_longstatus_print_unmerged(struct wt_status *s)
 static void wt_longstatus_print_updated(struct wt_status *s)
 {
 	int shown_header = 0;
-	int i;
+	size_t i;
 
 	for (i = 0; i < s->change.nr; i++) {
 		struct wt_status_change_data *d;
@@ -905,7 +905,7 @@ static void wt_longstatus_print_updated(struct wt_status *s)
 static int wt_status_check_worktree_changes(struct wt_status *s,
 					     int *dirty_submodules)
 {
-	int i;
+	size_t i;
 	int changes = 0;
 
 	*dirty_submodules = 0;
@@ -928,7 +928,8 @@ static int wt_status_check_worktree_changes(struct wt_status *s,
 
 static void wt_longstatus_print_changed(struct wt_status *s)
 {
-	int i, dirty_submodules;
+	size_t i;
+	int dirty_submodules;
 	int worktree_changes = wt_status_check_worktree_changes(s, &dirty_submodules);
 
 	if (!worktree_changes)
@@ -1028,7 +1029,7 @@ static void wt_longstatus_print_other(struct wt_status *s,
 				      const char *what,
 				      const char *how)
 {
-	int i;
+	size_t i;
 	struct strbuf buf = STRBUF_INIT;
 	static struct string_list output = STRING_LIST_INIT_DUP;
 	struct column_options copts;
@@ -1164,7 +1165,7 @@ static void wt_longstatus_print_tracking(struct wt_status *s)
 	const char *cp, *ep, *branch_name;
 	struct branch *branch;
 	char comment_line_string[3];
-	int i;
+	unsigned int i;
 	uint64_t t_begin = 0;
 
 	assert(s->branch && !s->is_initial);
@@ -1320,7 +1321,7 @@ static int split_commit_in_progress(struct wt_status *s)
 static void abbrev_oid_in_line(struct strbuf *line)
 {
 	struct strbuf **split;
-	int i;
+	size_t i;
 
 	if (starts_with(line->buf, "exec ") ||
 	    starts_with(line->buf, "x ") ||
@@ -1379,8 +1380,8 @@ static void show_rebase_information(struct wt_status *s,
 				    const char *color)
 {
 	if (s->state.rebase_interactive_in_progress) {
-		int i;
-		int nr_lines_to_show = 2;
+		size_t i;
+		const size_t nr_lines_to_show = 2;
 
 		struct string_list have_done = STRING_LIST_INIT_DUP;
 		struct string_list yet_to_do = STRING_LIST_INIT_DUP;
@@ -1729,7 +1730,7 @@ static void wt_status_check_sparse_checkout(struct repository *r,
 					    struct wt_status_state *state)
 {
 	int skip_worktree = 0;
-	int i;
+	unsigned int i;
 
 	if (!core_apply_sparse_checkout || r->index->cache_nr == 0) {
 		/*
@@ -2487,7 +2488,7 @@ static void wt_porcelain_v2_print(struct wt_status *s)
 {
 	struct wt_status_change_data *d;
 	struct string_list_item *it;
-	int i;
+	size_t i;
 
 	if (s->show_branch)
 		wt_porcelain_v2_print_tracking(s);
diff --git a/xdiff-interface.c b/xdiff-interface.c
index e87950de32e..d4bec9905ff 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -210,8 +210,8 @@ static long ff_regexp(const char *line, long len,
 {
 	struct ff_regs *regs = priv;
 	regmatch_t pmatch[2];
-	int i;
-	int result;
+	size_t i;
+	long result;
 
 	/* Exclude terminating newline (and cr) from matching */
 	if (len > 0 && line[len-1] == '\n') {
@@ -244,7 +244,7 @@ static long ff_regexp(const char *line, long len,
 
 void xdiff_set_find_func(xdemitconf_t *xecfg, const char *value, int cflags)
 {
-	int i;
+	size_t i;
 	struct ff_regs *regs;
 
 	xecfg->find_func = ff_regexp;

base-commit: a38d39a4c50d1275833aba54c4dbdfce9e2e9ca1
-- 
gitgitgadget
