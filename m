Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DA421F462
	for <e@80x24.org>; Thu, 25 Jul 2019 20:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfGYUNB (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 16:13:01 -0400
Received: from mout.gmx.net ([212.227.15.18]:52715 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbfGYUNB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 16:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564085572;
        bh=GG8H4tQfFc0R6o6TBGvQ7LJrt2bHZ8Fyzxk+HwoQPu4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gl0d6PekumkDZx3vLlzMz01yNEhpkJdRL83hu+CPNlC15lXwJIChDIJXN4MOAxiqS
         UKfo+HEvFHdgGmfveCAQiLO7kWBl9uOFhfct3HH6aSFX3jT0NMOV92OMELntYmII8g
         olwa157lAinH6C8b9e9lgweiKx3ulpVVkrk+eaVI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Me86g-1i2MoM2mZq-00PvVQ; Thu, 25
 Jul 2019 22:12:52 +0200
Date:   Thu, 25 Jul 2019 22:12:50 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 15/19] merge-recursive: split internal fields into a
 separate struct
In-Reply-To: <20190725174611.14802-16-newren@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1907252206180.21907@tvgsbejvaqbjf.bet>
References: <20190725174611.14802-1-newren@gmail.com> <20190725174611.14802-16-newren@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:YReXCC2R1yt0Nphf+4WafAsEH7jbZL2Jtre7LFoPB5Cd9i1kamI
 goiHfdYK1CZzQWaSOYvpDGbW/KAOxhLxbH6kXZJ3bqh8ahOrnbZ7kcPTmtGi1JdWXs2deD4
 dUI7U87i+V5+CoiQO0IT/eyhzycUKH3Drisvv+28/f15pS78kJQQpcCPvh8ti+/4TONtM89
 sEWTKDMyp4V3xAThrexfA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3RpNcH9eXT8=:07rlcy9gf5VC2MMazH+7sm
 PO0SUmRTTJ5TH5UfXz4Rgai8MlvsnWvovNybqgZMQeWk7QLGr54Ec4lvBzhpHDucIIGY3pIh2
 2nAs2I93jICpg/wzW9Mw0Dm9wDHPN0Bu0AGrxBKRLUcqFxY6Wf1sTk4wipfAYBTcZQ17IEzL2
 3nONUwZ+7+Rlv44IV7L6fnzfUy4A/U63l2aEFW2PwJLmFunhwylgC0CVWmbUyht8DgEc9oqWy
 1qvLD/vHRjUqickTK5eqn4OYPY4q8S2IzLMJ3T4O6fr+sLEj1b6wJTsgvDjxWaFf1EAa2L8Zk
 JOs3TZERqKDHyC4JVQEaqEochh/4RmO1QDjQBmoSaWYuZ325Oky3imapb82sDoHres+3yGMRh
 +IkL5VnBwnB3EhP4Rs9KytMmcN7AXnAjYrjmodsgWsyjqpw41cXqb4NsPl2PYjxtm7bljYsdp
 lHv8wIpS9aH7LLQXs8f0ocVOEvuDy4GXQ+BFA6/O2OKc+AlT4W9IFaFYrVdg47Hq5jzGhqMY2
 QbYwMb8ekcm0PdeAX7ng+dQEqXTbwSVjnKnOk0YE/fmNHqZ9j17ESNRHbd2lXiSTpJapbFoC1
 vUBtuvaevT73FBBhaosVt7gMQ6BwQDL8H4Aa3/ELBGMtxYrUlq2sDHvEPXddy1ex+BJTBQJTT
 jpuAJ8V0T/n1sRLTZfDwpe5YMVbBRkANvXK2XnhBFOkrqMkXFrR42PlGUgO/jxreAvn/XuIHx
 3TKtCy2q60HRumf/7M18dvqKQYBbufrFIFIJ6iNVR4ZNkg546xB5fySlHoG+gPYCoxmw/90IK
 EUbQEwxlQ0M3kHMIiuolUn5N2pKLZILQGioO6ulw9Sejdio+YHVqFeneR7tn5kxkZoVKL0jUz
 RQfhyCc193PHih11wyjTYCA5a9WUOEUTrcfTOCrebm9ZKZtBHLDLopctI4dP/U0R2Z7CjQI+q
 c5cV/8A/H8YTN/dh9tUs7Avwpujy6MoubGj2XRx7G3l2piFHfiUO0UQR4euLHkoaoVKDZ2eyn
 IVXct9hOQ7dYTeOe6dv4jmnqlzgGBkR7XMCRZSZFsvv2l46ArC6q6mFQqgVQ+lt7Geitmq5C3
 64a40GY2iMiGLA9y54YEJlxdpLIQjjjECRG
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Thu, 25 Jul 2019, Elijah Newren wrote:

> merge_options has several internal fields that should not be set or read
> by external callers.  This just complicates the API.  Move them into an
> opaque merge_options_internal struct that is defined only in
> merge-recursive.c and keep these out of merge-recursive.h.

This method requires an extra `malloc()`/`free()` pair, leaving room for
leaks.

I'd rather keep the definition of that struct in `merge-recursive.h`,
and make the `priv` field a full struct instead of a pointer. That would
save on that extra allocation.

Ciao,
Dscho

>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-recursive.c | 185 +++++++++++++++++++++++++---------------------
>  merge-recursive.h |  17 ++---
>  2 files changed, 106 insertions(+), 96 deletions(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index a5049b06a3..c572d37b21 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -29,6 +29,15 @@
>  #include "revision.h"
>  #include "commit-reach.h"
>
> +struct merge_options_internal {
> +	int call_depth;
> +	int needed_rename_limit;
> +	struct hashmap current_file_dir_set;
> +	struct string_list df_conflict_file_set;
> +	struct unpack_trees_options unpack_opts;
> +	struct index_state orig_index;
> +};
> +
>  struct path_hashmap_entry {
>  	struct hashmap_entry e;
>  	char path[FLEX_ARRAY];
> @@ -309,7 +318,8 @@ static inline void setup_rename_conflict_info(enum r=
ename_type rename_type,
>
>  static int show(struct merge_options *opt, int v)
>  {
> -	return (!opt->call_depth && opt->verbosity >=3D v) || opt->verbosity >=
=3D 5;
> +	return (!opt->priv->call_depth && opt->verbosity >=3D v) ||
> +		opt->verbosity >=3D 5;
>  }
>
>  __attribute__((format (printf, 3, 4)))
> @@ -320,7 +330,7 @@ static void output(struct merge_options *opt, int v,=
 const char *fmt, ...)
>  	if (!show(opt, v))
>  		return;
>
> -	strbuf_addchars(&opt->obuf, ' ', opt->call_depth * 2);
> +	strbuf_addchars(&opt->obuf, ' ', opt->priv->call_depth * 2);
>
>  	va_start(ap, fmt);
>  	strbuf_vaddf(&opt->obuf, fmt, ap);
> @@ -335,7 +345,7 @@ static void output_commit_title(struct merge_options=
 *opt, struct commit *commit
>  {
>  	struct merge_remote_desc *desc;
>
> -	strbuf_addchars(&opt->obuf, ' ', opt->call_depth * 2);
> +	strbuf_addchars(&opt->obuf, ' ', opt->priv->call_depth * 2);
>  	desc =3D merge_remote_util(commit);
>  	if (desc)
>  		strbuf_addf(&opt->obuf, "virtual %s\n", desc->name);
> @@ -403,43 +413,43 @@ static int unpack_trees_start(struct merge_options=
 *opt,
>  	struct tree_desc t[3];
>  	struct index_state tmp_index =3D { NULL };
>
> -	memset(&opt->unpack_opts, 0, sizeof(opt->unpack_opts));
> -	if (opt->call_depth)
> -		opt->unpack_opts.index_only =3D 1;
> +	memset(&opt->priv->unpack_opts, 0, sizeof(opt->priv->unpack_opts));
> +	if (opt->priv->call_depth)
> +		opt->priv->unpack_opts.index_only =3D 1;
>  	else
> -		opt->unpack_opts.update =3D 1;
> -	opt->unpack_opts.merge =3D 1;
> -	opt->unpack_opts.head_idx =3D 2;
> -	opt->unpack_opts.fn =3D threeway_merge;
> -	opt->unpack_opts.src_index =3D opt->repo->index;
> -	opt->unpack_opts.dst_index =3D &tmp_index;
> -	opt->unpack_opts.aggressive =3D !merge_detect_rename(opt);
> -	setup_unpack_trees_porcelain(&opt->unpack_opts, "merge");
> +		opt->priv->unpack_opts.update =3D 1;
> +	opt->priv->unpack_opts.merge =3D 1;
> +	opt->priv->unpack_opts.head_idx =3D 2;
> +	opt->priv->unpack_opts.fn =3D threeway_merge;
> +	opt->priv->unpack_opts.src_index =3D opt->repo->index;
> +	opt->priv->unpack_opts.dst_index =3D &tmp_index;
> +	opt->priv->unpack_opts.aggressive =3D !merge_detect_rename(opt);
> +	setup_unpack_trees_porcelain(&opt->priv->unpack_opts, "merge");
>
>  	init_tree_desc_from_tree(t+0, common);
>  	init_tree_desc_from_tree(t+1, head);
>  	init_tree_desc_from_tree(t+2, merge);
>
> -	rc =3D unpack_trees(3, t, &opt->unpack_opts);
> +	rc =3D unpack_trees(3, t, &opt->priv->unpack_opts);
>  	cache_tree_free(&opt->repo->index->cache_tree);
>
>  	/*
> -	 * Update opt->repo->index to match the new results, AFTER saving a co=
py
> -	 * in opt->orig_index.  Update src_index to point to the saved copy.
> -	 * (verify_uptodate() checks src_index, and the original index is
> -	 * the one that had the necessary modification timestamps.)
> +	 * Update opt->repo->index to match the new results, AFTER saving a
> +	 * copy in opt->priv->orig_index.  Update src_index to point to the
> +	 * saved copy.  (verify_uptodate() checks src_index, and the original
> +	 * index is the one that had the necessary modification timestamps.)
>  	 */
> -	opt->orig_index =3D *opt->repo->index;
> +	opt->priv->orig_index =3D *opt->repo->index;
>  	*opt->repo->index =3D tmp_index;
> -	opt->unpack_opts.src_index =3D &opt->orig_index;
> +	opt->priv->unpack_opts.src_index =3D &opt->priv->orig_index;
>
>  	return rc;
>  }
>
>  static void unpack_trees_finish(struct merge_options *opt)
>  {
> -	discard_index(&opt->orig_index);
> -	clear_unpack_trees_porcelain(&opt->unpack_opts);
> +	discard_index(&opt->priv->orig_index);
> +	clear_unpack_trees_porcelain(&opt->priv->unpack_opts);
>  }
>
>  static int save_files_dirs(const struct object_id *oid,
> @@ -454,7 +464,7 @@ static int save_files_dirs(const struct object_id *o=
id,
>
>  	FLEX_ALLOC_MEM(entry, path, base->buf, base->len);
>  	hashmap_entry_init(entry, path_hash(entry->path));
> -	hashmap_add(&opt->current_file_dir_set, entry);
> +	hashmap_add(&opt->priv->current_file_dir_set, entry);
>
>  	strbuf_setlen(base, baselen);
>  	return (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0);
> @@ -585,7 +595,7 @@ static void record_df_conflict_files(struct merge_op=
tions *opt,
>  	 * If we're merging merge-bases, we don't want to bother with
>  	 * any working directory changes.
>  	 */
> -	if (opt->call_depth)
> +	if (opt->priv->call_depth)
>  		return;
>
>  	/* Ensure D/F conflicts are adjacent in the entries list. */
> @@ -597,7 +607,7 @@ static void record_df_conflict_files(struct merge_op=
tions *opt,
>  	df_sorted_entries.cmp =3D string_list_df_name_compare;
>  	string_list_sort(&df_sorted_entries);
>
> -	string_list_clear(&opt->df_conflict_file_set, 1);
> +	string_list_clear(&opt->priv->df_conflict_file_set, 1);
>  	for (i =3D 0; i < df_sorted_entries.nr; i++) {
>  		const char *path =3D df_sorted_entries.items[i].string;
>  		int len =3D strlen(path);
> @@ -613,7 +623,7 @@ static void record_df_conflict_files(struct merge_op=
tions *opt,
>  		    len > last_len &&
>  		    memcmp(path, last_file, last_len) =3D=3D 0 &&
>  		    path[last_len] =3D=3D '/') {
> -			string_list_insert(&opt->df_conflict_file_set, last_file);
> +			string_list_insert(&opt->priv->df_conflict_file_set, last_file);
>  		}
>
>  		/*
> @@ -680,8 +690,8 @@ static void update_entry(struct stage_data *entry,
>  static int remove_file(struct merge_options *opt, int clean,
>  		       const char *path, int no_wd)
>  {
> -	int update_cache =3D opt->call_depth || clean;
> -	int update_working_directory =3D !opt->call_depth && !no_wd;
> +	int update_cache =3D opt->priv->call_depth || clean;
> +	int update_working_directory =3D !opt->priv->call_depth && !no_wd;
>
>  	if (update_cache) {
>  		if (remove_file_from_index(opt->repo->index, path))
> @@ -724,16 +734,16 @@ static char *unique_path(struct merge_options *opt=
,
>  	add_flattened_path(&newpath, branch);
>
>  	base_len =3D newpath.len;
> -	while (hashmap_get_from_hash(&opt->current_file_dir_set,
> +	while (hashmap_get_from_hash(&opt->priv->current_file_dir_set,
>  				     path_hash(newpath.buf), newpath.buf) ||
> -	       (!opt->call_depth && file_exists(newpath.buf))) {
> +	       (!opt->priv->call_depth && file_exists(newpath.buf))) {
>  		strbuf_setlen(&newpath, base_len);
>  		strbuf_addf(&newpath, "_%d", suffix++);
>  	}
>
>  	FLEX_ALLOC_MEM(entry, path, newpath.buf, newpath.len);
>  	hashmap_entry_init(entry, path_hash(entry->path));
> -	hashmap_add(&opt->current_file_dir_set, entry);
> +	hashmap_add(&opt->priv->current_file_dir_set, entry);
>  	return strbuf_detach(&newpath, NULL);
>  }
>
> @@ -775,7 +785,7 @@ static int dir_in_way(struct index_state *istate, co=
nst char *path,
>  static int was_tracked_and_matches(struct merge_options *opt, const cha=
r *path,
>  				   const struct diff_filespec *blob)
>  {
> -	int pos =3D index_name_pos(&opt->orig_index, path, strlen(path));
> +	int pos =3D index_name_pos(&opt->priv->orig_index, path, strlen(path))=
;
>  	struct cache_entry *ce;
>
>  	if (0 > pos)
> @@ -783,7 +793,7 @@ static int was_tracked_and_matches(struct merge_opti=
ons *opt, const char *path,
>  		return 0;
>
>  	/* See if the file we were tracking before matches */
> -	ce =3D opt->orig_index.cache[pos];
> +	ce =3D opt->priv->orig_index.cache[pos];
>  	return (oid_eq(&ce->oid, &blob->oid) && ce->ce_mode =3D=3D blob->mode)=
;
>  }
>
> @@ -792,7 +802,7 @@ static int was_tracked_and_matches(struct merge_opti=
ons *opt, const char *path,
>   */
>  static int was_tracked(struct merge_options *opt, const char *path)
>  {
> -	int pos =3D index_name_pos(&opt->orig_index, path, strlen(path));
> +	int pos =3D index_name_pos(&opt->priv->orig_index, path, strlen(path))=
;
>
>  	if (0 <=3D pos)
>  		/* we were tracking this path before the merge */
> @@ -849,12 +859,12 @@ static int was_dirty(struct merge_options *opt, co=
nst char *path)
>  	struct cache_entry *ce;
>  	int dirty =3D 1;
>
> -	if (opt->call_depth || !was_tracked(opt, path))
> +	if (opt->priv->call_depth || !was_tracked(opt, path))
>  		return !dirty;
>
> -	ce =3D index_file_exists(opt->unpack_opts.src_index,
> +	ce =3D index_file_exists(opt->priv->unpack_opts.src_index,
>  			       path, strlen(path), ignore_case);
> -	dirty =3D verify_uptodate(ce, &opt->unpack_opts) !=3D 0;
> +	dirty =3D verify_uptodate(ce, &opt->priv->unpack_opts) !=3D 0;
>  	return dirty;
>  }
>
> @@ -864,8 +874,8 @@ static int make_room_for_path(struct merge_options *=
opt, const char *path)
>  	const char *msg =3D _("failed to create path '%s'%s");
>
>  	/* Unlink any D/F conflict files that are in the way */
> -	for (i =3D 0; i < opt->df_conflict_file_set.nr; i++) {
> -		const char *df_path =3D opt->df_conflict_file_set.items[i].string;
> +	for (i =3D 0; i < opt->priv->df_conflict_file_set.nr; i++) {
> +		const char *df_path =3D opt->priv->df_conflict_file_set.items[i].stri=
ng;
>  		size_t pathlen =3D strlen(path);
>  		size_t df_pathlen =3D strlen(df_path);
>  		if (df_pathlen < pathlen &&
> @@ -875,7 +885,7 @@ static int make_room_for_path(struct merge_options *=
opt, const char *path)
>  			       _("Removing %s to make room for subdirectory\n"),
>  			       df_path);
>  			unlink(df_path);
> -			unsorted_string_list_delete_item(&opt->df_conflict_file_set,
> +			unsorted_string_list_delete_item(&opt->priv->df_conflict_file_set,
>  							 i, 0);
>  			break;
>  		}
> @@ -916,7 +926,7 @@ static int update_file_flags(struct merge_options *o=
pt,
>  {
>  	int ret =3D 0;
>
> -	if (opt->call_depth)
> +	if (opt->priv->call_depth)
>  		update_wd =3D 0;
>
>  	if (update_wd) {
> @@ -1001,7 +1011,7 @@ static int update_file(struct merge_options *opt,
>  		       const char *path)
>  {
>  	return update_file_flags(opt, contents, path,
> -				 opt->call_depth || clean, !opt->call_depth);
> +				 opt->priv->call_depth || clean, !opt->priv->call_depth);
>  }
>
>  /* Low level file merging, update and removal */
> @@ -1030,7 +1040,7 @@ static int merge_3way(struct merge_options *opt,
>  	ll_opts.extra_marker_size =3D extra_marker_size;
>  	ll_opts.xdl_opts =3D opt->xdl_opts;
>
> -	if (opt->call_depth) {
> +	if (opt->priv->call_depth) {
>  		ll_opts.virtual_ancestor =3D 1;
>  		ll_opts.variant =3D 0;
>  	} else {
> @@ -1164,7 +1174,7 @@ static int merge_submodule(struct merge_options *o=
pt,
>  	struct object_array merges;
>
>  	int i;
> -	int search =3D !opt->call_depth;
> +	int search =3D !opt->priv->call_depth;
>
>  	/* store a in result in case we fail */
>  	oidcpy(result, a);
> @@ -1385,7 +1395,7 @@ static int handle_rename_via_dir(struct merge_opti=
ons *opt,
>  	int mark_conflicted =3D (opt->detect_directory_renames =3D=3D 1);
>  	assert(ren->dir_rename_original_dest);
>
> -	if (!opt->call_depth && would_lose_untracked(opt, dest->path)) {
> +	if (!opt->priv->call_depth && would_lose_untracked(opt, dest->path)) {
>  		mark_conflicted =3D 1;
>  		file_path =3D unique_path(opt, dest->path, ren->branch);
>  		output(opt, 1, _("Error: Refusing to lose untracked file at %s; "
> @@ -1428,12 +1438,12 @@ static int handle_change_delete(struct merge_opt=
ions *opt,
>  	const char *update_path =3D path;
>  	int ret =3D 0;
>
> -	if (dir_in_way(opt->repo->index, path, !opt->call_depth, 0) ||
> -	    (!opt->call_depth && would_lose_untracked(opt, path))) {
> +	if (dir_in_way(opt->repo->index, path, !opt->priv->call_depth, 0) ||
> +	    (!opt->priv->call_depth && would_lose_untracked(opt, path))) {
>  		update_path =3D alt_path =3D unique_path(opt, path, change_branch);
>  	}
>
> -	if (opt->call_depth) {
> +	if (opt->priv->call_depth) {
>  		/*
>  		 * We cannot arbitrarily accept either a_sha or b_sha as
>  		 * correct; since there is no true "middle point" between
> @@ -1508,14 +1518,14 @@ static int handle_rename_delete(struct merge_opt=
ions *opt,
>  				     opt->branch2 : opt->branch1);
>
>  	if (handle_change_delete(opt,
> -				 opt->call_depth ? orig->path : dest->path,
> -				 opt->call_depth ? NULL : orig->path,
> +				 opt->priv->call_depth ? orig->path : dest->path,
> +				 opt->priv->call_depth ? NULL : orig->path,
>  				 orig, dest,
>  				 rename_branch, delete_branch,
>  				 _("rename"), _("renamed")))
>  		return -1;
>
> -	if (opt->call_depth)
> +	if (opt->priv->call_depth)
>  		return remove_file_from_index(opt->repo->index, dest->path);
>  	else
>  		return update_stages(opt, dest->path, NULL,
> @@ -1552,7 +1562,7 @@ static int handle_file_collision(struct merge_opti=
ons *opt,
>  	/*
>  	 * In the recursive case, we just opt to undo renames
>  	 */
> -	if (opt->call_depth && (prev_path1 || prev_path2)) {
> +	if (opt->priv->call_depth && (prev_path1 || prev_path2)) {
>  		/* Put first file (a->oid, a->mode) in its original spot */
>  		if (prev_path1) {
>  			if (update_file(opt, 1, a, prev_path1))
> @@ -1581,10 +1591,10 @@ static int handle_file_collision(struct merge_op=
tions *opt,
>  	/* Remove rename sources if rename/add or rename/rename(2to1) */
>  	if (prev_path1)
>  		remove_file(opt, 1, prev_path1,
> -			    opt->call_depth || would_lose_untracked(opt, prev_path1));
> +			    opt->priv->call_depth || would_lose_untracked(opt, prev_path1));
>  	if (prev_path2)
>  		remove_file(opt, 1, prev_path2,
> -			    opt->call_depth || would_lose_untracked(opt, prev_path2));
> +			    opt->priv->call_depth || would_lose_untracked(opt, prev_path2));
>
>  	/*
>  	 * Remove the collision path, if it wouldn't cause dirty contents
> @@ -1626,12 +1636,12 @@ static int handle_file_collision(struct merge_op=
tions *opt,
>  	null.mode =3D 0;
>
>  	if (merge_mode_and_contents(opt, &null, a, b, collide_path,
> -				    branch1, branch2, opt->call_depth * 2, &mfi))
> +				    branch1, branch2, opt->priv->call_depth * 2, &mfi))
>  		return -1;
>  	mfi.clean &=3D !alt_path;
>  	if (update_file(opt, mfi.clean, &mfi.blob, update_path))
>  		return -1;
> -	if (!mfi.clean && !opt->call_depth &&
> +	if (!mfi.clean && !opt->priv->call_depth &&
>  	    update_stages(opt, collide_path, NULL, a, b))
>  		return -1;
>  	free(alt_path);
> @@ -1671,7 +1681,7 @@ static int handle_rename_add(struct merge_options =
*opt,
>  				    &ci->ren1->src_entry->stages[other_stage],
>  				    prev_path_desc,
>  				    opt->branch1, opt->branch2,
> -				    1 + opt->call_depth * 2, &mfi))
> +				    1 + opt->priv->call_depth * 2, &mfi))
>  		return -1;
>  	free(prev_path_desc);
>
> @@ -1689,7 +1699,7 @@ static char *find_path_for_conflict(struct merge_o=
ptions *opt,
>  				    const char *branch2)
>  {
>  	char *new_path =3D NULL;
> -	if (dir_in_way(opt->repo->index, path, !opt->call_depth, 0)) {
> +	if (dir_in_way(opt->repo->index, path, !opt->priv->call_depth, 0)) {
>  		new_path =3D unique_path(opt, path, branch1);
>  		output(opt, 1, _("%s is a directory in %s adding "
>  			       "as %s instead"),
> @@ -1720,17 +1730,17 @@ static int handle_rename_rename_1to2(struct merg=
e_options *opt,
>  	       "rename \"%s\"->\"%s\" in \"%s\"%s"),
>  	       o->path, a->path, ci->ren1->branch,
>  	       o->path, b->path, ci->ren2->branch,
> -	       opt->call_depth ? _(" (left unresolved)") : "");
> +	       opt->priv->call_depth ? _(" (left unresolved)") : "");
>
>  	path_desc =3D xstrfmt("%s and %s, both renamed from %s",
>  			    a->path, b->path, o->path);
>  	if (merge_mode_and_contents(opt, o, a, b, path_desc,
>  				    ci->ren1->branch, ci->ren2->branch,
> -				    opt->call_depth * 2, &mfi))
> +				    opt->priv->call_depth * 2, &mfi))
>  		return -1;
>  	free(path_desc);
>
> -	if (opt->call_depth) {
> +	if (opt->priv->call_depth) {
>  		/*
>  		 * FIXME: For rename/add-source conflicts (if we could detect
>  		 * such), this is wrong.  We should instead find a unique
> @@ -1845,12 +1855,12 @@ static int handle_rename_rename_2to1(struct merg=
e_options *opt,
>  				    &ci->ren1->src_entry->stages[ostage1],
>  				    path_side_1_desc,
>  				    opt->branch1, opt->branch2,
> -				    1 + opt->call_depth * 2, &mfi_c1) ||
> +				    1 + opt->priv->call_depth * 2, &mfi_c1) ||
>  	    merge_mode_and_contents(opt, b,
>  				    &ci->ren2->src_entry->stages[ostage2],
>  				    c2, path_side_2_desc,
>  				    opt->branch1, opt->branch2,
> -				    1 + opt->call_depth * 2, &mfi_c2))
> +				    1 + opt->priv->call_depth * 2, &mfi_c2))
>  		return -1;
>  	free(path_side_1_desc);
>  	free(path_side_2_desc);
> @@ -1891,8 +1901,8 @@ static struct diff_queue_struct *get_diffpairs(str=
uct merge_options *opt,
>  	diff_setup_done(&opts);
>  	diff_tree_oid(&o_tree->object.oid, &tree->object.oid, "", &opts);
>  	diffcore_std(&opts);
> -	if (opts.needed_rename_limit > opt->needed_rename_limit)
> -		opt->needed_rename_limit =3D opts.needed_rename_limit;
> +	if (opts.needed_rename_limit > opt->priv->needed_rename_limit)
> +		opt->priv->needed_rename_limit =3D opts.needed_rename_limit;
>
>  	ret =3D xmalloc(sizeof(*ret));
>  	*ret =3D diff_queued_diff;
> @@ -3022,13 +3032,13 @@ static int handle_content_merge(struct merge_fil=
e_info *mfi,
>  		reason =3D _("add/add");
>
>  	assert(o->path && a->path && b->path);
> -	if (ci && dir_in_way(opt->repo->index, path, !opt->call_depth,
> +	if (ci && dir_in_way(opt->repo->index, path, !opt->priv->call_depth,
>  			     S_ISGITLINK(ci->ren1->pair->two->mode)))
>  		df_conflict_remains =3D 1;
>
>  	if (merge_mode_and_contents(opt, o, a, b, path,
>  				    opt->branch1, opt->branch2,
> -				    opt->call_depth * 2, mfi))
> +				    opt->priv->call_depth * 2, mfi))
>  		return -1;
>
>  	/*
> @@ -3044,7 +3054,7 @@ static int handle_content_merge(struct merge_file_=
info *mfi,
>
>  		output(opt, 3, _("Skipped %s (merged same as existing)"), path);
>  		if (add_cacheinfo(opt, &mfi->blob, path,
> -				  0, (!opt->call_depth && !is_dirty), 0))
> +				  0, (!opt->priv->call_depth && !is_dirty), 0))
>  			return -1;
>  		/*
>  		 * However, add_cacheinfo() will delete the old cache entry
> @@ -3052,8 +3062,8 @@ static int handle_content_merge(struct merge_file_=
info *mfi,
>  		 * flag to avoid making the file appear as if it were
>  		 * deleted by the user.
>  		 */
> -		pos =3D index_name_pos(&opt->orig_index, path, strlen(path));
> -		ce =3D opt->orig_index.cache[pos];
> +		pos =3D index_name_pos(&opt->priv->orig_index, path, strlen(path));
> +		ce =3D opt->priv->orig_index.cache[pos];
>  		if (ce_skip_worktree(ce)) {
>  			pos =3D index_name_pos(opt->repo->index, path, strlen(path));
>  			ce =3D opt->repo->index->cache[pos];
> @@ -3074,7 +3084,7 @@ static int handle_content_merge(struct merge_file_=
info *mfi,
>
>  	if (df_conflict_remains || is_dirty) {
>  		char *new_path;
> -		if (opt->call_depth) {
> +		if (opt->priv->call_depth) {
>  			remove_file_from_index(opt->repo->index, path);
>  		} else {
>  			if (!mfi->clean) {
> @@ -3332,7 +3342,7 @@ static int process_entry(struct merge_options *opt=
,
>  			conf =3D _("directory/file");
>  		}
>  		if (dir_in_way(opt->repo->index, path,
> -			       !opt->call_depth && !S_ISGITLINK(a->mode),
> +			       !opt->priv->call_depth && !S_ISGITLINK(a->mode),
>  			       0)) {
>  			char *new_path =3D unique_path(opt, path, add_branch);
>  			clean_merge =3D 0;
> @@ -3341,7 +3351,7 @@ static int process_entry(struct merge_options *opt=
,
>  			       conf, path, other_branch, path, new_path);
>  			if (update_file(opt, 0, contents, new_path))
>  				clean_merge =3D -1;
> -			else if (opt->call_depth)
> +			else if (opt->priv->call_depth)
>  				remove_file_from_index(opt->repo->index, path);
>  			free(new_path);
>  		} else {
> @@ -3406,7 +3416,7 @@ static int merge_trees_internal(struct merge_optio=
ns *opt,
>  	code =3D unpack_trees_start(opt, merge_base, head, merge);
>
>  	if (code !=3D 0) {
> -		if (show(opt, 4) || opt->call_depth)
> +		if (show(opt, 4) || opt->priv->call_depth)
>  			err(opt, _("merging of trees %s and %s failed"),
>  			    oid_to_hex(&head->object.oid),
>  			    oid_to_hex(&merge->object.oid));
> @@ -3425,7 +3435,7 @@ static int merge_trees_internal(struct merge_optio=
ns *opt,
>  		 * opposed to decaring a local hashmap is for convenience
>  		 * so that we don't have to pass it to around.
>  		 */
> -		hashmap_init(&opt->current_file_dir_set, path_hashmap_cmp,
> +		hashmap_init(&opt->priv->current_file_dir_set, path_hashmap_cmp,
>  			     NULL, 512);
>  		get_files_dirs(opt, head);
>  		get_files_dirs(opt, merge);
> @@ -3462,7 +3472,7 @@ static int merge_trees_internal(struct merge_optio=
ns *opt,
>  		string_list_clear(entries, 1);
>  		free(entries);
>
> -		hashmap_free(&opt->current_file_dir_set, 1);
> +		hashmap_free(&opt->priv->current_file_dir_set, 1);
>
>  		if (clean < 0) {
>  			unpack_trees_finish(opt);
> @@ -3474,7 +3484,8 @@ static int merge_trees_internal(struct merge_optio=
ns *opt,
>
>  	unpack_trees_finish(opt);
>
> -	if (opt->call_depth && !(*result =3D write_tree_from_memory(opt->repo)=
))
> +	if (opt->priv->call_depth &&
> +	    !(*result =3D write_tree_from_memory(opt->repo)))
>  		return -1;
>
>  	return clean;
> @@ -3538,7 +3549,7 @@ static int merge_recursive_internal(struct merge_o=
ptions *opt,
>
>  	for (iter =3D merge_bases; iter; iter =3D iter->next) {
>  		const char *saved_b1, *saved_b2;
> -		opt->call_depth++;
> +		opt->priv->call_depth++;
>  		/*
>  		 * When the merge fails, the result contains files
>  		 * with conflict markers. The cleanness flag is
> @@ -3557,14 +3568,14 @@ static int merge_recursive_internal(struct merge=
_options *opt,
>  			return -1;
>  		opt->branch1 =3D saved_b1;
>  		opt->branch2 =3D saved_b2;
> -		opt->call_depth--;
> +		opt->priv->call_depth--;
>
>  		if (!merged_merge_bases)
>  			return err(opt, _("merge returned no commit"));
>  	}
>
>  	discard_index(opt->repo->index);
> -	if (!opt->call_depth)
> +	if (!opt->priv->call_depth)
>  		repo_read_index(opt->repo);
>
>  	opt->ancestor =3D "merged common ancestors";
> @@ -3579,14 +3590,14 @@ static int merge_recursive_internal(struct merge=
_options *opt,
>  		return clean;
>  	}
>
> -	if (opt->call_depth) {
> +	if (opt->priv->call_depth) {
>  		*result =3D make_virtual_commit(opt->repo, result_tree,
>  					      "merged tree");
>  		commit_list_insert(h1, &(*result)->parents);
>  		commit_list_insert(h2, &(*result)->parents->next);
>  	}
>  	flush_output(opt);
> -	if (!opt->call_depth && opt->buffer_output < 2)
> +	if (!opt->priv->call_depth && opt->buffer_output < 2)
>  		strbuf_release(&opt->obuf);
>  	return clean;
>  }
> @@ -3603,6 +3614,8 @@ static int merge_start(struct merge_options *opt, =
struct tree *head)
>  		return -1;
>  	}
>
> +	opt->priv =3D xcalloc(1, sizeof(*opt->priv));
> +	string_list_init(&opt->priv->df_conflict_file_set, 1);
>  	return 0;
>  }
>
> @@ -3610,7 +3623,9 @@ static void merge_finalize(struct merge_options *o=
pt)
>  {
>  	if (show(opt, 2))
>  		diff_warn_rename_limit("merge.renamelimit",
> -				       opt->needed_rename_limit, 0);
> +				       opt->priv->needed_rename_limit, 0);
> +	free(opt->priv);
> +	opt->priv =3D NULL;
>  }
>
>  int merge_trees(struct merge_options *opt,
> @@ -3748,8 +3763,6 @@ void init_merge_options(struct merge_options *opt,
>
>  	opt->renormalize =3D 0;
>
> -	string_list_init(&opt->df_conflict_file_set, 1);
> -
>  	merge_recursive_config(opt);
>  	merge_verbosity =3D getenv("GIT_MERGE_VERBOSITY");
>  	if (merge_verbosity)
> diff --git a/merge-recursive.h b/merge-recursive.h
> index d57fce0daa..a1bb29dc33 100644
> --- a/merge-recursive.h
> +++ b/merge-recursive.h
> @@ -1,13 +1,15 @@
>  #ifndef MERGE_RECURSIVE_H
>  #define MERGE_RECURSIVE_H
>
> -#include "string-list.h"
> -#include "unpack-trees.h"
> +#include "strbuf.h"
>
>  struct commit;
> -
> +struct commit_list;
> +struct object_id;
>  struct repository;
> +struct tree;
>
> +struct merge_options_internal;
>  struct merge_options {
>  	struct repository *repo;
>
> @@ -40,13 +42,8 @@ struct merge_options {
>  	const char *subtree_shift;
>  	unsigned renormalize : 1;
>
> -	/* internal fields used by the implementation (do NOT set these) */
> -	int call_depth;
> -	int needed_rename_limit;
> -	struct hashmap current_file_dir_set;
> -	struct string_list df_conflict_file_set;
> -	struct unpack_trees_options unpack_opts;
> -	struct index_state orig_index;
> +	/* internal fields used by the implementation */
> +	struct merge_options_internal *priv;
>  };
>
>  void init_merge_options(struct merge_options *opt, struct repository *r=
epo);
> --
> 2.22.0.559.g28a8880890.dirty
>
>
