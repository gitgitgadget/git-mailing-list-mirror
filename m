Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E4812021E
	for <e@80x24.org>; Fri, 19 May 2017 15:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753200AbdESPd3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 May 2017 11:33:29 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35788 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751858AbdESPd1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2017 11:33:27 -0400
Received: by mail-qt0-f193.google.com with SMTP id r58so10101547qtb.2
        for <git@vger.kernel.org>; Fri, 19 May 2017 08:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=zckctdzNsjsKrBV7ZpnH2TgTZnM4gYQlrWqUqWFrlbM=;
        b=Fc4AQZ4m8F3CjOqI3bA1YSesMwmp7ap94swvLBjFh+yD+r1zRq4/oDKWvNXaoT4UNH
         1V8OhjTsy2Fg8zNc1TfxtkMUxMHTcshEi4S2B8wfQ0u8T/q8tyYBjaLPyEkMrqwvZjTY
         t/guBTLSRyzIjK1CG1fzE/hEmCAPd5SjlHCuYH6SMSquPpM6eVOtY+RJG9V3bKbWjFh6
         cdYnKRgDldtUKhzwGS5dOAxOY3tQtQh7i4Ca2wiGs2lfzwdBzU6sHG3m2NLwLrCiKErf
         a3ReI2DE+lp/meN6i6jOjvv6Kx/nxLAibXA7BXqBSadMAKlHaxu80oG8NxMdlQPshz/b
         RGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=zckctdzNsjsKrBV7ZpnH2TgTZnM4gYQlrWqUqWFrlbM=;
        b=dl8agv+pv6sLofOl9r8vyM7eoY2mfwlgeEMLkasCOmlxhdUm9NZexIlTgstpCPydo7
         YobIxL3UNZZYKjl1XRfcz+3W0/9yo//vZLK+TgJfYKDgdYuMuJyyQvjYEyL8ePloCAv1
         CCbDY92Spbhgc8w/pdKYBM3y8Uis5KDyPXpKi4K3LP2GkrsrnjI/G5dR/43yyKhmGlBP
         tVxWJNa2xz7six69IzrTTeTAe5v9Vh6jIZufOnxJGo3lev6ZB3Rprn/PiK+WRioLMJoH
         rhvA6wZXSCjxWeriWqoisszu0xy1iXhdB7uFJaVDawXtFEFkmRO3Uyrhredrv9GM3cu0
         xi8A==
X-Gm-Message-State: AODbwcDBc8wvT83tvEmczBggSs3PvepRWrz67CJe6nDA+b26fc68jchk
        K3/FUBmEV74WDA==
X-Received: by 10.200.4.147 with SMTP id s19mr10933577qtg.50.1495208004811;
        Fri, 19 May 2017 08:33:24 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id j204sm6258242qke.27.2017.05.19.08.33.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 May 2017 08:33:24 -0700 (PDT)
Subject: Re: [PATCH v2 3/6] fsmonitor: teach git to optionally utilize a file
 system monitor to speed up detecting new or changed files.
To:     git@vger.kernel.org
References: <20170518201333.13088-1-benpeart@microsoft.com>
 <20170518201333.13088-4-benpeart@microsoft.com>
Cc:     gitster@pobox.com, benpeart@microsoft.com, pclouds@gmail.com,
        johannes.schindelin@gmx.de, David.Turner@twosigma.com,
        peff@peff.net
From:   Ben Peart <peartben@gmail.com>
Message-ID: <41d6939f-0095-cfc5-cde5-2ebdd74a09b2@gmail.com>
Date:   Fri, 19 May 2017 11:33:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170518201333.13088-4-benpeart@microsoft.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After sending this, I noticed that using a different compiler generated 
a couple of warnings I should fix.  I'm assuming I'll need another 
re-roll but if not, here are the changes that will be squashed in.

Ben



diff --git a/dir.c b/dir.c
index da428489e2..37f1c580a5 100644
--- a/dir.c
+++ b/dir.c
@@ -16,6 +16,7 @@
  #include "utf8.h"
  #include "varint.h"
  #include "ewah/ewok.h"
+#include "fsmonitor.h"


diff --git a/fsmonitor.c b/fsmonitor.c
index 6356dc795e..9f08e66db9 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -162,7 +162,7 @@ void process_fsmonitor_extension(struct index_state 
*istate)

  void refresh_by_fsmonitor(struct index_state *istate)
  {
-       static has_run_once = FALSE;
+       static int has_run_once = FALSE;
         struct strbuf query_result = STRBUF_INIT;
         int query_success = 0;
         size_t bol = 0; /* beginning of line */


On 5/18/2017 4:13 PM, Ben Peart wrote:
> When the index is read from disk, the query-fsmonitor index extension is
> used to flag the last known potentially dirty index and untracked cach
> entries.
>
> If git finds out some entries are 'fsmonitor-dirty', but are really
> unchanged (e.g. the file was changed, then reverted back), then Git will
> clear the marking in the extension. If git adds or updates an index
> entry, it is marked 'fsmonitor-dirty' to ensure it is checked for
> changes in the working directory.
>
> Before the 'fsmonitor-dirty' flags are used to limit the scope of the
> files to be checked, the query-fsmonitor hook proc is called with the
> time the index was last updated.  The hook proc returns the list of
> files changed since that last updated time and the list of
> potentially dirty entries is updated to reflect the current state.
>
> refresh_index() and valid_cached_dir() are updated so that any entry not
> flagged as potentially dirty is not checked as it cannot have any
> changes.
>
> Signed-off-by: Ben Peart <benpeart@microsoft.com>
> ---
>  Makefile               |   1 +
>  builtin/update-index.c |   1 +
>  cache.h                |   5 ++
>  config.c               |   5 ++
>  dir.c                  |  13 +++
>  dir.h                  |   2 +
>  entry.c                |   1 +
>  environment.c          |   1 +
>  fsmonitor.c            | 231 +++++++++++++++++++++++++++++++++++++++++++++++++
>  fsmonitor.h            |   9 ++
>  read-cache.c           |  28 +++++-
>  unpack-trees.c         |   1 +
>  12 files changed, 296 insertions(+), 2 deletions(-)
>  create mode 100644 fsmonitor.c
>  create mode 100644 fsmonitor.h
>
> diff --git a/Makefile b/Makefile
> index e35542e631..488a4466cc 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -760,6 +760,7 @@ LIB_OBJS += ewah/ewah_rlw.o
>  LIB_OBJS += exec_cmd.o
>  LIB_OBJS += fetch-pack.o
>  LIB_OBJS += fsck.o
> +LIB_OBJS += fsmonitor.o
>  LIB_OBJS += gettext.o
>  LIB_OBJS += gpg-interface.o
>  LIB_OBJS += graph.o
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index ebfc09faa0..32fd977b43 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -232,6 +232,7 @@ static int mark_ce_flags(const char *path, int flag, int mark)
>  		else
>  			active_cache[pos]->ce_flags &= ~flag;
>  		active_cache[pos]->ce_flags |= CE_UPDATE_IN_BASE;
> +		active_cache[pos]->ce_flags |= CE_FSMONITOR_DIRTY;
>  		cache_tree_invalidate_path(&the_index, path);
>  		active_cache_changed |= CE_ENTRY_CHANGED;
>  		return 0;
> diff --git a/cache.h b/cache.h
> index 188811920c..36423c77cc 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -201,6 +201,7 @@ struct cache_entry {
>  #define CE_ADDED             (1 << 19)
>
>  #define CE_HASHED            (1 << 20)
> +#define CE_FSMONITOR_DIRTY   (1 << 21)
>  #define CE_WT_REMOVE         (1 << 22) /* remove in work directory */
>  #define CE_CONFLICTED        (1 << 23)
>
> @@ -324,6 +325,7 @@ static inline unsigned int canon_mode(unsigned int mode)
>  #define CACHE_TREE_CHANGED	(1 << 5)
>  #define SPLIT_INDEX_ORDERED	(1 << 6)
>  #define UNTRACKED_CHANGED	(1 << 7)
> +#define FSMONITOR_CHANGED	(1 << 8)
>
>  struct split_index;
>  struct untracked_cache;
> @@ -342,6 +344,8 @@ struct index_state {
>  	struct hashmap dir_hash;
>  	unsigned char sha1[20];
>  	struct untracked_cache *untracked;
> +	time_t fsmonitor_last_update;
> +	struct ewah_bitmap *fsmonitor_dirty_bitmap;
>  };
>
>  extern struct index_state the_index;
> @@ -766,6 +770,7 @@ extern int precomposed_unicode;
>  extern int protect_hfs;
>  extern int protect_ntfs;
>  extern int git_db_env, git_index_env, git_graft_env, git_common_dir_env;
> +extern int core_fsmonitor;
>
>  /*
>   * Include broken refs in all ref iterations, which will
> diff --git a/config.c b/config.c
> index bb4d735701..1a8108636d 100644
> --- a/config.c
> +++ b/config.c
> @@ -1232,6 +1232,11 @@ static int git_default_core_config(const char *var, const char *value)
>  		return 0;
>  	}
>
> +	if (!strcmp(var, "core.fsmonitor")) {
> +		core_fsmonitor = git_config_bool(var, value);
> +		return 0;
> +	}
> +
>  	/* Add other config variables here and to Documentation/config.txt. */
>  	return 0;
>  }
> diff --git a/dir.c b/dir.c
> index 1b5558fdf9..da428489e2 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1652,6 +1652,18 @@ static int valid_cached_dir(struct dir_struct *dir,
>  	if (!untracked)
>  		return 0;
>
> +	refresh_by_fsmonitor(&the_index);
> +	if (dir->untracked->use_fsmonitor) {
> +		/*
> +		 * With fsmonitor, we can trust the untracked cache's
> +		 * valid field.
> +		 */
> +		if (untracked->valid)
> +			goto skip_stat;
> +		else
> +			invalidate_directory(dir->untracked, untracked);
> +	}
> +
>  	if (stat(path->len ? path->buf : ".", &st)) {
>  		invalidate_directory(dir->untracked, untracked);
>  		memset(&untracked->stat_data, 0, sizeof(untracked->stat_data));
> @@ -1665,6 +1677,7 @@ static int valid_cached_dir(struct dir_struct *dir,
>  		return 0;
>  	}
>
> +skip_stat:
>  	if (untracked->check_only != !!check_only) {
>  		invalidate_directory(dir->untracked, untracked);
>  		return 0;
> diff --git a/dir.h b/dir.h
> index 9e387551bd..ff6a00abcc 100644
> --- a/dir.h
> +++ b/dir.h
> @@ -139,6 +139,8 @@ struct untracked_cache {
>  	int gitignore_invalidated;
>  	int dir_invalidated;
>  	int dir_opened;
> +	/* fsmonitor invalidation data */
> +	unsigned int use_fsmonitor : 1;
>  };
>
>  struct dir_struct {
> diff --git a/entry.c b/entry.c
> index d2b512da90..c2d3c1079c 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -221,6 +221,7 @@ static int write_entry(struct cache_entry *ce,
>  			lstat(ce->name, &st);
>  		fill_stat_cache_info(ce, &st);
>  		ce->ce_flags |= CE_UPDATE_IN_BASE;
> +		ce->ce_flags |= CE_FSMONITOR_DIRTY;
>  		state->istate->cache_changed |= CE_ENTRY_CHANGED;
>  	}
>  	return 0;
> diff --git a/environment.c b/environment.c
> index 560408953c..1afabbae8c 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -64,6 +64,7 @@ int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
>  unsigned long pack_size_limit_cfg;
>  enum hide_dotfiles_type hide_dotfiles = HIDE_DOTFILES_DOTGITONLY;
>  enum log_refs_config log_all_ref_updates = LOG_REFS_UNSET;
> +int core_fsmonitor;
>
>  #ifndef PROTECT_HFS_DEFAULT
>  #define PROTECT_HFS_DEFAULT 0
> diff --git a/fsmonitor.c b/fsmonitor.c
> new file mode 100644
> index 0000000000..6356dc795e
> --- /dev/null
> +++ b/fsmonitor.c
> @@ -0,0 +1,231 @@
> +#include "cache.h"
> +#include "dir.h"
> +#include "ewah/ewok.h"
> +#include "run-command.h"
> +#include "strbuf.h"
> +#include "fsmonitor.h"
> +
> +static struct untracked_cache_dir *find_untracked_cache_dir(
> +	struct untracked_cache *uc, struct untracked_cache_dir *ucd,
> +	const char *name)
> +{
> +	const char *end;
> +	struct untracked_cache_dir *dir = ucd;
> +
> +	if (!*name)
> +		return dir;
> +
> +	end = strchr(name, '/');
> +	if (end) {
> +		dir = lookup_untracked(uc, ucd, name, end - name);
> +		if (dir)
> +			return find_untracked_cache_dir(uc, dir, end + 1);
> +	}
> +
> +	return dir;
> +}
> +
> +/* This function will be passed to ewah_each_bit() */
> +static void mark_no_fsmonitor(size_t pos, void *is)
> +{
> +	struct index_state *istate = is;
> +	struct untracked_cache_dir *dir;
> +	struct cache_entry *ce = istate->cache[pos];
> +
> +	assert(pos < istate->cache_nr);
> +	ce->ce_flags |= CE_FSMONITOR_DIRTY;
> +
> +	if (!istate->untracked || !istate->untracked->root)
> +		return;
> +
> +	dir = find_untracked_cache_dir(istate->untracked, istate->untracked->root, ce->name);
> +	if (dir)
> +		dir->valid = 0;
> +}
> +
> +int read_fsmonitor_extension(struct index_state *istate, const void *data,
> +	unsigned long sz)
> +{
> +	const char *index = data;
> +	uint32_t hdr_version;
> +	uint32_t ewah_size;
> +	int ret;
> +
> +	if (sz < sizeof(uint32_t) + sizeof(uint64_t) + sizeof(uint32_t))
> +		return error("corrupt fsmonitor extension (too short)");
> +
> +	hdr_version = get_be32(index);
> +	index += sizeof(uint32_t);
> +	if (hdr_version != 1)
> +		return error("bad fsmonitor version %d", hdr_version);
> +
> +	istate->fsmonitor_last_update = (time_t)get_be64(index);
> +	index += sizeof(uint64_t);
> +
> +	ewah_size = get_be32(index);
> +	index += sizeof(uint32_t);
> +
> +	istate->fsmonitor_dirty_bitmap = ewah_new();
> +	ret = ewah_read_mmap(istate->fsmonitor_dirty_bitmap, index, ewah_size);
> +	if (ret != ewah_size) {
> +		ewah_free(istate->fsmonitor_dirty_bitmap);
> +		istate->fsmonitor_dirty_bitmap = NULL;
> +		return error("failed to parse ewah bitmap reading fsmonitor index extension");
> +	}
> +
> +	return 0;
> +}
> +
> +void write_fsmonitor_extension(struct strbuf *sb, struct index_state *istate)
> +{
> +	uint32_t hdr_version;
> +	uint64_t tm;
> +	struct ewah_bitmap *bitmap;
> +	int i;
> +	uint32_t ewah_start;
> +	uint32_t ewah_size = 0;
> +	int fixup = 0;
> +
> +	hdr_version = htonl(1);
> +	strbuf_add(sb, &hdr_version, sizeof(uint32_t));
> +
> +	tm = htonll((uint64_t)istate->fsmonitor_last_update);
> +	strbuf_add(sb, &tm, sizeof(uint64_t));
> +	fixup = sb->len;
> +	strbuf_add(sb, &ewah_size, sizeof(uint32_t)); /* we'll fix this up later */
> +
> +	ewah_start = sb->len;
> +	bitmap = ewah_new();
> +	for (i = 0; i < istate->cache_nr; i++)
> +		if (istate->cache[i]->ce_flags & CE_FSMONITOR_DIRTY)
> +			ewah_set(bitmap, i);
> +	ewah_serialize_strbuf(bitmap, sb);
> +	ewah_free(bitmap);
> +
> +	/* fix up size field */
> +	ewah_size = htonl(sb->len - ewah_start);
> +	memcpy(sb->buf + fixup, &ewah_size, sizeof(uint32_t));
> +}
> +
> +static void mark_file_dirty(struct index_state *istate, const char *name)
> +{
> +	struct untracked_cache_dir *dir;
> +	int pos;
> +
> +	/* find it in the index and mark that entry as dirty */
> +	pos = index_name_pos(istate, name, strlen(name));
> +	if (pos >= 0)
> +		istate->cache[pos]->ce_flags |= CE_FSMONITOR_DIRTY;
> +
> +	/*
> +	 * Find the corresponding directory in the untracked cache
> +	 * and mark it as invalid
> +	 */
> +	if (!istate->untracked || !istate->untracked->root)
> +		return;
> +
> +	dir = find_untracked_cache_dir(istate->untracked, istate->untracked->root, name);
> +	if (dir)
> +		dir->valid = 0;
> +}
> +
> +/*
> + * Call the query-fsmonitor hook passing the time of the last saved results.
> + */
> +static int query_fsmonitor(time_t last_update, struct strbuf *query_result)
> +{
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	char date[64];
> +	const char *argv[3];
> +
> +	if (!(argv[0] = find_hook("query-fsmonitor")))
> +		return -1;
> +
> +	snprintf(date, sizeof(date), "%" PRIuMAX, (uintmax_t)last_update);
> +	argv[1] = date;
> +	argv[2] = NULL;
> +	cp.argv = argv;
> +	cp.out = -1;
> +
> +	return capture_command(&cp, query_result, 1024);
> +}
> +
> +void process_fsmonitor_extension(struct index_state *istate)
> +{
> +	if (!istate->fsmonitor_dirty_bitmap)
> +		return;
> +
> +	ewah_each_bit(istate->fsmonitor_dirty_bitmap, mark_no_fsmonitor, istate);
> +	ewah_free(istate->fsmonitor_dirty_bitmap);
> +	istate->fsmonitor_dirty_bitmap = NULL;
> +}
> +
> +void refresh_by_fsmonitor(struct index_state *istate)
> +{
> +	static has_run_once = FALSE;
> +	struct strbuf query_result = STRBUF_INIT;
> +	int query_success = 0;
> +	size_t bol = 0; /* beginning of line */
> +	time_t last_update;
> +	char *buf, *entry;
> +	int i;
> +
> +	if (!core_fsmonitor || has_run_once)
> +		return;
> +	has_run_once = TRUE;
> +
> +	/*
> +	 * This could be racy so save the date/time now and the hook
> +	 * should be inclusive to ensure we don't miss potential changes.
> +	 */
> +	last_update = time(NULL);
> +
> +	/* If we have a last update time, call query-monitor for the set of changes since that time */
> +	if (istate->fsmonitor_last_update) {
> +		query_success = !query_fsmonitor(istate->fsmonitor_last_update, &query_result);
> +	}
> +
> +	if (query_success) {
> +		/* Mark all entries returned by the monitor as dirty */
> +		buf = entry = query_result.buf;
> +		for (i = 0; i < query_result.len; i++) {
> +			if (buf[i] != '\0')
> +				continue;
> +			mark_file_dirty(istate, buf + bol);
> +			bol = i + 1;
> +		}
> +		if (bol < query_result.len)
> +			mark_file_dirty(istate, buf + bol);
> +
> +		/* Mark all clean entries up-to-date */
> +		for (i = 0; i < istate->cache_nr; i++) {
> +			struct cache_entry *ce = istate->cache[i];
> +			if (ce_stage(ce) || (ce->ce_flags & CE_FSMONITOR_DIRTY))
> +				continue;
> +			ce_mark_uptodate(ce);
> +		}
> +
> +		/*
> +		 * Now that we've marked the invalid entries in the
> +		 * untracked-cache itself, we can mark the untracked cache for
> +		 * fsmonitor usage.
> +		 */
> +		if (istate->untracked) {
> +			istate->untracked->use_fsmonitor = 1;
> +		}
> +	}
> +	else {
> +		/* if we can't update the cache, fall back to checking them all */
> +		for (i = 0; i < istate->cache_nr; i++)
> +			istate->cache[i]->ce_flags |= CE_FSMONITOR_DIRTY;
> +
> +		/* mark the untracked cache as unusable for fsmonitor */
> +		if (istate->untracked)
> +			istate->untracked->use_fsmonitor = 0;
> +	}
> +	strbuf_release(&query_result);
> +
> +	/* Now that we've updated istate, save the last_update time */
> +	istate->fsmonitor_last_update = last_update;
> +	istate->cache_changed |= FSMONITOR_CHANGED;
> +}
> diff --git a/fsmonitor.h b/fsmonitor.h
> new file mode 100644
> index 0000000000..57b061688f
> --- /dev/null
> +++ b/fsmonitor.h
> @@ -0,0 +1,9 @@
> +#ifndef FSMONITOR_H
> +#define FSMONITOR_H
> +
> +int read_fsmonitor_extension(struct index_state *istate, const void *data, unsigned long sz);
> +void write_fsmonitor_extension(struct strbuf *sb, struct index_state *istate);
> +void process_fsmonitor_extension(struct index_state *istate);
> +void refresh_by_fsmonitor(struct index_state *istate);
> +
> +#endif
> diff --git a/read-cache.c b/read-cache.c
> index 3339de8124..5b52f08db2 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -18,6 +18,7 @@
>  #include "varint.h"
>  #include "split-index.h"
>  #include "utf8.h"
> +#include "fsmonitor.h"
>
>  /* Mask for the name length in ce_flags in the on-disk index */
>
> @@ -37,11 +38,12 @@
>  #define CACHE_EXT_RESOLVE_UNDO 0x52455543 /* "REUC" */
>  #define CACHE_EXT_LINK 0x6c696e6b	  /* "link" */
>  #define CACHE_EXT_UNTRACKED 0x554E5452	  /* "UNTR" */
> +#define CACHE_EXT_FSMONITOR 0x46534D4E	  /* "FSMN" */
>
>  /* changes that can be kept in $GIT_DIR/index (basically all extensions) */
>  #define EXTMASK (RESOLVE_UNDO_CHANGED | CACHE_TREE_CHANGED | \
>  		 CE_ENTRY_ADDED | CE_ENTRY_REMOVED | CE_ENTRY_CHANGED | \
> -		 SPLIT_INDEX_ORDERED | UNTRACKED_CHANGED)
> +		 SPLIT_INDEX_ORDERED | UNTRACKED_CHANGED | FSMONITOR_CHANGED)
>
>  struct index_state the_index;
>  static const char *alternate_index_output;
> @@ -61,6 +63,7 @@ static void replace_index_entry(struct index_state *istate, int nr, struct cache
>  	free(old);
>  	set_index_entry(istate, nr, ce);
>  	ce->ce_flags |= CE_UPDATE_IN_BASE;
> +	ce->ce_flags |= CE_FSMONITOR_DIRTY;
>  	istate->cache_changed |= CE_ENTRY_CHANGED;
>  }
>
> @@ -777,6 +780,7 @@ int chmod_index_entry(struct index_state *istate, struct cache_entry *ce,
>  	}
>  	cache_tree_invalidate_path(istate, ce->name);
>  	ce->ce_flags |= CE_UPDATE_IN_BASE;
> +	ce->ce_flags |= CE_FSMONITOR_DIRTY;
>  	istate->cache_changed |= CE_ENTRY_CHANGED;
>
>  	return 0;
> @@ -1344,6 +1348,8 @@ int refresh_index(struct index_state *istate, unsigned int flags,
>  	const char *added_fmt;
>  	const char *unmerged_fmt;
>
> +	refresh_by_fsmonitor(istate);
> +
>  	modified_fmt = (in_porcelain ? "M\t%s\n" : "%s: needs update\n");
>  	deleted_fmt = (in_porcelain ? "D\t%s\n" : "%s: needs update\n");
>  	typechange_fmt = (in_porcelain ? "T\t%s\n" : "%s needs update\n");
> @@ -1380,8 +1386,11 @@ int refresh_index(struct index_state *istate, unsigned int flags,
>  			continue;
>
>  		new = refresh_cache_ent(istate, ce, options, &cache_errno, &changed);
> -		if (new == ce)
> +		if (new == ce) {
> +			ce->ce_flags &= ~CE_FSMONITOR_DIRTY;
>  			continue;
> +		}
> +
>  		if (!new) {
>  			const char *fmt;
>
> @@ -1391,6 +1400,7 @@ int refresh_index(struct index_state *istate, unsigned int flags,
>  				 */
>  				ce->ce_flags &= ~CE_VALID;
>  				ce->ce_flags |= CE_UPDATE_IN_BASE;
> +				ce->ce_flags |= CE_FSMONITOR_DIRTY;
>  				istate->cache_changed |= CE_ENTRY_CHANGED;
>  			}
>  			if (quiet)
> @@ -1549,6 +1559,9 @@ static int read_index_extension(struct index_state *istate,
>  	case CACHE_EXT_UNTRACKED:
>  		istate->untracked = read_untracked_extension(data, sz);
>  		break;
> +	case CACHE_EXT_FSMONITOR:
> +		read_fsmonitor_extension(istate, data, sz);
> +		break;
>  	default:
>  		if (*ext < 'A' || 'Z' < *ext)
>  			return error("index uses %.4s extension, which we do not understand",
> @@ -1721,6 +1734,7 @@ static void post_read_index_from(struct index_state *istate)
>  	check_ce_order(istate);
>  	tweak_untracked_cache(istate);
>  	tweak_split_index(istate);
> +	process_fsmonitor_extension(istate);
>  }
>
>  /* remember to discard_cache() before reading a different cache! */
> @@ -2300,6 +2314,16 @@ static int do_write_index(struct index_state *istate, int newfd,
>  		if (err)
>  			return -1;
>  	}
> +	if (!strip_extensions && istate->fsmonitor_last_update) {
> +		struct strbuf sb = STRBUF_INIT;
> +
> +		write_fsmonitor_extension(&sb, istate);
> +		err = write_index_ext_header(&c, newfd, CACHE_EXT_FSMONITOR, sb.len) < 0
> +			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
> +		strbuf_release(&sb);
> +		if (err)
> +			return -1;
> +	}
>
>  	if (ce_flush(&c, newfd, istate->sha1) || fstat(newfd, &st))
>  		return -1;
> diff --git a/unpack-trees.c b/unpack-trees.c
> index aa15111fef..259e6960b9 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -412,6 +412,7 @@ static int apply_sparse_checkout(struct index_state *istate,
>  		ce->ce_flags &= ~CE_SKIP_WORKTREE;
>  	if (was_skip_worktree != ce_skip_worktree(ce)) {
>  		ce->ce_flags |= CE_UPDATE_IN_BASE;
> +		ce->ce_flags |= CE_FSMONITOR_DIRTY;
>  		istate->cache_changed |= CE_ENTRY_CHANGED;
>  	}
>
>
