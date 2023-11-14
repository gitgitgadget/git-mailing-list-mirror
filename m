Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3708726AD3
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 19:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvqNDnBW"
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51320102
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 11:54:03 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a822f96aedso71390517b3.2
        for <git@vger.kernel.org>; Tue, 14 Nov 2023 11:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699991642; x=1700596442; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5D0CCOcgrAjmUx92VEauRVvlmRS2UQG8oywPH3N2Yds=;
        b=SvqNDnBWbcFgZo+HjpVCuvQ9h9p5RYpKFZmfSpZAfgBX6U9n1iBSXQ/3fz0uj3Ta2L
         JMFg9GZv4/L5xN2+/lgQSgPadCOuPGOYUFTkdn5zO4hSA5XgOaYnjznuU1mN/r5hh6ou
         7f9NbqE3fEsvuwLvoQN5wDk1QSict95iJuE1V0AH18EBUJjL+sxDJVY1ZxAZs3M7J5YZ
         3mQ1T7GonWD6y1cwsA396UtduKNqZl4KjA4z/sZT5azp/eGvRPvOnOIUKhviCQzB8poP
         KP3KX+PG73jpZhfsDBjMD1r6TSeXIfiyePlP1eiaPoLi2jA1gSZpnQ32lcUixU8NRZ4E
         aGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699991642; x=1700596442;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5D0CCOcgrAjmUx92VEauRVvlmRS2UQG8oywPH3N2Yds=;
        b=Kzih6XL1IHiA+8m2D0eM0h9NrzuWdeTw6/6R6TMAbXf60mZBVFxZRlp3OBd9oy/Frw
         GxjMY8ZTAF8HAxC4CYFCXjvmYTamdhigEIyL2NOrynUnRiloA/93BfXXkXMxkrDNqriq
         hsQ7xUSX0TUaQ6Gnq7usvp0i7irIaSAeFoM/NvassmnH+bkiCjY5UYUMJJaVZgvvlr78
         SVbDC6NmTS1DBL4V6D02686Zxfo54JsJtetarRmhIJ4cbVwCuH4IPOEIm4YXTYRRldJA
         w6RLyt5g/wyIFydXT007ri5wPWq6FLWL4UqDXsyu3ilLD2WoDH/RzmzC4Bp3b+fLXM9p
         UC8g==
X-Gm-Message-State: AOJu0YwRhRJbaVAzATQ5fBA8J3kHy43yqmlstzgoczEeQK/vXH043xfN
	YAglqMJdbg8bu4fJUJqb9nxd+G7dVts=
X-Google-Smtp-Source: AGHT+IFlu5BbJYpYRrcxoHv6bZpC1QszHS8YNwgtvve05ynTBFLc6eh3fak1jD4Z3ZPwKekQEaGJCA==
X-Received: by 2002:a81:6d12:0:b0:5a8:9b88:745c with SMTP id i18-20020a816d12000000b005a89b88745cmr11315170ywc.13.1699991641420;
        Tue, 14 Nov 2023 11:54:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a14-20020a0cc58e000000b0065d89f4d537sm3152324qvj.45.2023.11.14.11.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 11:54:01 -0800 (PST)
Message-ID: <pull.1609.v2.git.1699991638.gitgitgadget@gmail.com>
In-Reply-To: <pull.1609.git.1699320361.gitgitgadget@gmail.com>
References: <pull.1609.git.1699320361.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 14 Nov 2023 19:53:48 +0000
Subject: [PATCH v2 00/10] for-each-ref optimizations & usability improvements
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
Cc: Patrick Steinhardt <ps@pks.im>,
    =?UTF-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Victoria Dye <vdye@github.com>

This series is a bit of an informal follow-up to [1], adding some more
substantial optimizations and usability fixes around ref
filtering/formatting. Some of the changes here affect user-facing behavior,
some are internal-only, but they're all interdependent enough to warrant
putting them together in one series.

[1]
https://lore.kernel.org/git/pull.1594.v2.git.1696888736.gitgitgadget@gmail.com/

Patch 1 changes the behavior of the '--no-sort' option in 'for-each-ref',
'tag', and 'branch'. Currently, it just removes previous sort keys and, if
no further keys are specified, falls back on ascending refname sort (which,
IMO, makes the name '--no-sort' somewhat misleading). Now, '--no-sort'
completely disables sorting (unless subsequent '--sort' options are
provided).

Patches 2-7 incrementally refactor various parts of the ref
filtering/formatting workflows in order to create a
'filter_and_format_refs()' function. If certain conditions are met (sorting
disabled, no reachability filtering or ahead-behind formatting), ref
filtering & formatting is done within a single 'for_each_fullref_in'
callback. Especially in large repositories, this makes a huge difference in
memory usage & runtime for certain usages of 'for-each-ref', since it's no
longer writing everything to a 'struct ref_array' then repeatedly whittling
down/updating its contents.

Patch 8 updates the 'for-each-ref' documentation, making the '--format'
description a bit less jumbled and more clearly explaining the '*' prefix
(to be updated in the next patch)

Patch 9 changes the dereferencing done by the '*' format prefix from a
single dereference to a recursive peel. See [1] + replies for the discussion
that led to this approach (as opposed to a command line option or new format
specifier).

[1] https://lore.kernel.org/git/ZUoWWo7IEKsiSx-C@tanuki/

Finally, patch 10 adds performance tests for 'for-each-ref', showing the
effects of optimizations made throughout the series. Here are some sample
results from my Ubuntu VM (test names shortened for space):

Test                                                         HEAD
----------------------------------------------------------------------------
6300.2: (loose)                                              4.68(0.98+3.64)
6300.3: (loose, no sort)                                     4.65(0.91+3.67)
6300.4: (loose, --count=1)                                   4.50(0.84+3.60)
6300.5: (loose, --count=1, no sort)                          4.24(0.46+3.71)
6300.6: (loose, tags)                                        2.41(0.45+1.93)
6300.7: (loose, tags, no sort)                               2.33(0.48+1.83)
6300.8: (loose, tags, dereferenced)                          3.65(1.66+1.95)
6300.9: (loose, tags, dereferenced, no sort)                 3.48(1.59+1.87)
6300.10: for-each-ref + cat-file (loose, tags)               4.48(2.27+2.22)
6300.12: (packed)                                            0.90(0.68+0.18)
6300.13: (packed, no sort)                                   0.71(0.55+0.06)
6300.14: (packed, --count=1)                                 0.77(0.52+0.16)
6300.15: (packed, --count=1, no sort)                        0.03(0.01+0.02)
6300.16: (packed, tags)                                      0.45(0.33+0.10)
6300.17: (packed, tags, no sort)                             0.39(0.33+0.03)
6300.18: (packed, tags, dereferenced)                        1.83(1.67+0.10)
6300.19: (packed, tags, dereferenced, no sort)               1.42(1.28+0.08)
6300.20: for-each-ref + cat-file (packed, tags)              2.36(2.11+0.29)


 * Victoria


Changes since V1
================

 * Restructured commit message of patch 1 for better readability
 * Re-added 'ref_sorting_release(sorting)' to 'ls-remote'
 * Dropped patch 2 so we don't commit to behavior we don't want in
   'for-each-ref --omit-empty --count'
 * Split patch 6 into one that renames 'ref_filter_handler()' to
   'filter_one()' and another that creates helper functions from existing
   code
 * Added/updated code comments in patch 7, changed ref iteration "break"
   return value from -1 to 1
 * Added a patch to reword 'for-each-ref' documentation in anticipation of
   updating the description of what '*' does in the format
 * Removed command-line option '--full-deref' for peeling tags in '*' format
   fields in favor of simply cutting over from the current single
   dereference to recursive dereference in all cases. Updated tests to match
   new behavior.
 * Added the '--count=1' tests back to p6300 (I must have unintentionally
   removed them before submitting V1)

Victoria Dye (10):
  ref-filter.c: really don't sort when using --no-sort
  ref-filter.h: add max_count and omit_empty to ref_format
  ref-filter.h: move contains caches into filter
  ref-filter.h: add functions for filter/format & format-only
  ref-filter.c: rename 'ref_filter_handler()' to 'filter_one()'
  ref-filter.c: refactor to create common helper functions
  ref-filter.c: filter & format refs in the same callback
  for-each-ref: clean up documentation of --format
  ref-filter.c: use peeled tag for '*' format fields
  t/perf: add perf tests for for-each-ref

 Documentation/git-for-each-ref.txt |  23 +--
 builtin/branch.c                   |  42 +++--
 builtin/for-each-ref.c             |  39 +----
 builtin/ls-remote.c                |  11 +-
 builtin/tag.c                      |  32 +---
 ref-filter.c                       | 272 ++++++++++++++++++++---------
 ref-filter.h                       |  25 +++
 t/perf/p6300-for-each-ref.sh       |  87 +++++++++
 t/t3200-branch.sh                  |  68 +++++++-
 t/t6300-for-each-ref.sh            |  43 +++++
 t/t6302-for-each-ref-filter.sh     |   4 +-
 t/t7004-tag.sh                     |  45 +++++
 12 files changed, 517 insertions(+), 174 deletions(-)
 create mode 100755 t/perf/p6300-for-each-ref.sh


base-commit: bc5204569f7db44d22477485afd52ea410d83743
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1609%2Fvdye%2Fvdye%2Ffor-each-ref-optimizations-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1609/vdye/vdye/for-each-ref-optimizations-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1609

Range-diff vs v1:

  1:  dea8d7d1e86 !  1:  074da1ff3e8 ref-filter.c: really don't sort when using --no-sort
     @@ Metadata
       ## Commit message ##
          ref-filter.c: really don't sort when using --no-sort
      
     -    Update 'ref_sorting_options()' to return a NULL 'struct ref_sorting *' if
     -    the string list provided to it is empty, rather than returning the default
     -    refname sort structure. Also update 'ref_array_sort()' to explicitly skip
     -    sorting if its 'struct ref_sorting *' arg is NULL. Other functions using
     -    'struct ref_sorting *' do not need any changes because they already properly
     -    ignore NULL values.
     +    When '--no-sort' is passed to 'for-each-ref', 'tag', and 'branch', the
     +    printed refs are still sorted by ascending refname. Change the handling of
     +    sort options in these commands so that '--no-sort' to truly disables
     +    sorting.
     +
     +    '--no-sort' does not disable sorting in these commands is because their
     +    option parsing does not distinguish between "the absence of '--sort'"
     +    (and/or values for tag.sort & branch.sort) and '--no-sort'. Both result in
     +    an empty 'sorting_options' string list, which is parsed by
     +    'ref_sorting_options()' to create the 'struct ref_sorting *' for the
     +    command. If the string list is empty, 'ref_sorting_options()' interprets
     +    that as "the absence of '--sort'" and returns the default ref sorting
     +    structure (equivalent to "refname" sort).
      
     -    The goal of this change is to have the '--no-sort' option truly disable
     -    sorting in commands like 'for-each-ref, 'tag', and 'branch'. Right now,
     -    '--no-sort' will still trigger refname sorting by default in 'for-each-ref',
     -    'tag', and 'branch'.
     +    To handle '--no-sort' properly while preserving the "refname" sort in the
     +    "absence of --sort'" case, first explicitly add "refname" to the string list
     +    *before* parsing options. This alone doesn't actually change any behavior,
     +    since 'compare_refs()' already falls back on comparing refnames if two refs
     +    are equal w.r.t all other sort keys.
      
     -    To match existing behavior as closely as possible, explicitly add "refname"
     -    to the list of sort keys in 'for-each-ref', 'tag', and 'branch' before
     -    parsing options (if no config-based sort keys are set). This ensures that
     -    sorting will only be fully disabled if '--no-sort' is provided as an option;
     -    otherwise, "refname" sorting will remain the default. Note: this also means
     -    that even when sort keys are provided on the command line, "refname" will be
     -    the final sort key in the sorting structure. This doesn't actually change
     -    any behavior, since 'compare_refs()' already falls back on comparing
     -    refnames if two refs are equal w.r.t all other sort keys.
     +    Now that the string list is populated by default, '--no-sort' is the only
     +    way to empty the 'sorting_options' string list. Update
     +    'ref_sorting_options()' to return a NULL 'struct ref_sorting *' if the
     +    string list is empty, and add a condition to 'ref_array_sort()' to skip the
     +    sort altogether if the sort structure is NULL. Note that other functions
     +    using 'struct ref_sorting *' do not need any changes because they already
     +    ignore NULL values.
      
          Finally, remove the condition around sorting in 'ls-remote', since it's no
     -    longer necessary. Unlike 'for-each-ref' et. al., it does *not* set any sort
     -    keys by default. The default empty list of sort keys will produce a NULL
     -    'struct ref_sorting *', which causes the sorting to be skipped in
     -    'ref_array_sort()'.
     +    longer necessary. Unlike 'for-each-ref' et. al., it does *not* do any
     +    sorting by default. This default is preserved by simply leaving its sort key
     +    string list empty before parsing options; if no additional sort keys are
     +    set, 'struct ref_sorting *' is NULL and sorting is skipped.
      
          Signed-off-by: Victoria Dye <vdye@github.com>
      
     @@ builtin/ls-remote.c: int cmd_ls_remote(int argc, const char **argv, const char *
       
       	for (i = 0; i < ref_array.nr; i++) {
       		const struct ref_array_item *ref = ref_array.items[i];
     +@@ builtin/ls-remote.c: int cmd_ls_remote(int argc, const char **argv, const char *prefix)
     + 		status = 0; /* we found something */
     + 	}
     + 
     ++	ref_sorting_release(sorting);
     + 	ref_array_clear(&ref_array);
     + 	if (transport_disconnect(transport))
     + 		status = 1;
      
       ## builtin/tag.c ##
      @@ builtin/tag.c: int cmd_tag(int argc, const char **argv, const char *prefix)
  2:  88eba4146cd <  -:  ----------- for-each-ref: clarify interaction of --omit-empty & --count
  3:  2e2f9738205 =  2:  adac101bc60 ref-filter.h: add max_count and omit_empty to ref_format
  4:  6c66445ee31 !  3:  f44c4b42c93 ref-filter.h: move contains caches into filter
     @@ Commit message
          filter struct will support, so they are updated to be internally accessible
          wherever the filter is used.
      
     -    The design used here is mirrors what was introduced in 576de3d956
     +    The design used here mirrors what was introduced in 576de3d956
          (unpack_trees: start splitting internal fields from public API, 2023-02-27)
          for 'unpack_trees_options'.
      
  5:  f5be57eea7d =  4:  187b1d6610f ref-filter.h: add functions for filter/format & format-only
  -:  ----------- >  5:  040d291ca45 ref-filter.c: rename 'ref_filter_handler()' to 'filter_one()'
  6:  8c77452e5dd !  6:  633c0c74c2e ref-filter.c: refactor to create common helper functions
     @@ Commit message
          ref-filter.c: refactor to create common helper functions
      
          Factor out parts of 'ref_array_push()', 'ref_filter_handler()', and
     -    'filter_refs()' into new helper functions ('ref_array_append()',
     -    'apply_ref_filter()', and 'do_filter_refs()' respectively), as well as
     -    rename 'ref_filter_handler()' to 'filter_one()'. In this and later
     -    patches, these helpers will be used by new ref-filter API functions. This
     -    patch does not result in any user-facing behavior changes or changes to
     -    callers outside of 'ref-filter.c'.
     +    'filter_refs()' into new helper functions:
      
     -    The changes are as follows:
     +    * Extract the code to grow a 'struct ref_array' and append a given 'struct
     +      ref_array_item *' to it from 'ref_array_push()' into 'ref_array_append()'.
     +    * Extract the code to filter a given ref by refname & object ID then create
     +      a new 'struct ref_array_item *' from 'filter_one()' into
     +      'apply_ref_filter()'.
     +    * Extract the code for filter pre-processing, contains cache creation, and
     +      ref iteration from 'filter_refs()' into 'do_filter_refs()'.
      
     -    * The logic to grow a 'struct ref_array' and append a given 'struct
     -      ref_array_item *' to it is extracted from 'ref_array_push()' into
     -      'ref_array_append()'.
     -    * 'ref_filter_handler()' is renamed to 'filter_one()' to more clearly
     -      distinguish it from other ref filtering callbacks that will be added in
     -      later patches. The "*_one()" naming convention is common throughout the
     -      codebase for iteration callbacks.
     -    * The code to filter a given ref by refname & object ID then create a new
     -      'struct ref_array_item' is moved out of 'filter_one()' and into
     -      'apply_ref_filter()'. 'apply_ref_filter()' returns either NULL (if the ref
     -      does not match the given filter) or a 'struct ref_array_item *' created
     -      with 'new_ref_array_item()'; 'filter_one()' appends that item to
     -      its ref array with 'ref_array_append()'.
     -    * The filter pre-processing, contains cache creation, and ref iteration of
     -      'filter_refs()' is extracted into 'do_filter_refs()'. 'do_filter_refs()'
     -      takes its ref iterator function & callback data as an input from the
     -      caller, setting it up to be used with additional filtering callbacks in
     -      later patches.
     +    In later patches, these helpers will be used by new ref-filter API
     +    functions. This patch does not result in any user-facing behavior changes or
     +    changes to callers outside of 'ref-filter.c'.
      
          Signed-off-by: Victoria Dye <vdye@github.com>
      
     @@ ref-filter.c: static int filter_ref_kind(struct ref_filter *filter, const char *
      - * A call-back given to for_each_ref().  Filter refs and keep them for
      - * later object processing.
      - */
     --static int ref_filter_handler(const char *refname, const struct object_id *oid, int flag, void *cb_data)
     +-static int filter_one(const char *refname, const struct object_id *oid, int flag, void *cb_data)
      +static struct ref_array_item *apply_ref_filter(const char *refname, const struct object_id *oid,
      +			    int flag, struct ref_filter *filter)
       {
     @@ ref-filter.c: static int filter_ref_kind(struct ref_filter *filter, const char *
       
       	/*
       	 * A merge filter is applied on refs pointing to commits. Hence
     -@@ ref-filter.c: static int ref_filter_handler(const char *refname, const struct object_id *oid,
     +@@ ref-filter.c: static int filter_one(const char *refname, const struct object_id *oid, int flag
       	    filter->with_commit || filter->no_commit || filter->verbose) {
       		commit = lookup_commit_reference_gently(the_repository, oid, 1);
       		if (!commit)
     @@ ref-filter.c: static int ref_filter_handler(const char *refname, const struct ob
       	}
       
       	/*
     -@@ ref-filter.c: static int ref_filter_handler(const char *refname, const struct object_id *oid,
     +@@ ref-filter.c: static int filter_one(const char *refname, const struct object_id *oid, int flag
       	 * to do its job and the resulting list may yet to be pruned
       	 * by maxcount logic.
       	 */
     @@ ref-filter.c: int filter_refs(struct ref_array *array, struct ref_filter *filter
       		 * of filter_ref_kind().
       		 */
       		if (filter->kind == FILTER_REFS_BRANCHES)
     --			ret = for_each_fullref_in("refs/heads/", ref_filter_handler, &ref_cbdata);
     +-			ret = for_each_fullref_in("refs/heads/", filter_one, &ref_cbdata);
      +			ret = for_each_fullref_in("refs/heads/", fn, cb_data);
       		else if (filter->kind == FILTER_REFS_REMOTES)
     --			ret = for_each_fullref_in("refs/remotes/", ref_filter_handler, &ref_cbdata);
     +-			ret = for_each_fullref_in("refs/remotes/", filter_one, &ref_cbdata);
      +			ret = for_each_fullref_in("refs/remotes/", fn, cb_data);
       		else if (filter->kind == FILTER_REFS_TAGS)
     --			ret = for_each_fullref_in("refs/tags/", ref_filter_handler, &ref_cbdata);
     +-			ret = for_each_fullref_in("refs/tags/", filter_one, &ref_cbdata);
      +			ret = for_each_fullref_in("refs/tags/", fn, cb_data);
       		else if (filter->kind & FILTER_REFS_ALL)
     --			ret = for_each_fullref_in_pattern(filter, ref_filter_handler, &ref_cbdata);
     +-			ret = for_each_fullref_in_pattern(filter, filter_one, &ref_cbdata);
      +			ret = for_each_fullref_in_pattern(filter, fn, cb_data);
       		if (!ret && (filter->kind & FILTER_REFS_DETACHED_HEAD))
     --			head_ref(ref_filter_handler, &ref_cbdata);
     +-			head_ref(filter_one, &ref_cbdata);
      +			head_ref(fn, cb_data);
       	}
       
  7:  84db440896c !  7:  91a77c1a834 ref-filter.c: filter & format refs in the same callback
     @@ ref-filter.c: static void free_array_item(struct ref_array_item *item)
      +	strbuf_release(&err);
      +	free_array_item(ref);
      +
     ++	/*
     ++	 * Increment the running count of refs that match the filter. If
     ++	 * max_count is set and we've reached the max, stop the ref
     ++	 * iteration by returning a nonzero value.
     ++	 */
      +	if (ref_cbdata->format->array_opts.max_count &&
      +	    ++ref_cbdata->internal.count >= ref_cbdata->format->array_opts.max_count)
     -+		return -1;
     ++		return 1;
      +
      +	return 0;
      +}
     @@ ref-filter.c: int filter_refs(struct ref_array *array, struct ref_filter *filter
      +					  struct ref_format *format)
      +{
      +	/*
     -+	 * Refs can be filtered and formatted in the same iteration as long
     -+	 * as we aren't filtering on reachability, sorting the results, or
     -+	 * including ahead-behind information in the formatted output.
     ++	 * Filtering & formatting results within a single ref iteration
     ++	 * callback is not compatible with options that require
     ++	 * post-processing a filtered ref_array. These include:
     ++	 * - filtering on reachability
     ++	 * - sorting the filtered results
     ++	 * - including ahead-behind information in the formatted output
      +	 */
      +	return !(filter->reachable_from ||
      +		 filter->unreachable_from ||
  -:  ----------- >  8:  8eb2fc2950c for-each-ref: clean up documentation of --format
  8:  352b5c42ac3 !  9:  48254d8e161 for-each-ref: add option to fully dereference tags
     @@ Metadata
      Author: Victoria Dye <vdye@github.com>
      
       ## Commit message ##
     -    for-each-ref: add option to fully dereference tags
     +    ref-filter.c: use peeled tag for '*' format fields
      
     -    Add a boolean flag '--full-deref' that, when enabled, fills '%(*fieldname)'
     -    format fields using the fully peeled target of tag objects, rather than the
     -    immediate target.
     -
     -    In other builtins ('rev-parse', 'show-ref'), "dereferencing" tags typically
     -    means peeling them down to their non-tag target. Unlike these commands,
     -    'for-each-ref' dereferences only one "level" of tags in '*' format fields
     -    (like "%(*objectname)"). For most annotated tags, one level of dereferencing
     -    is enough, since most tags point to commits or trees. However, nested tags
     -    (annotated tags whose target is another annotated tag) dereferenced once
     -    will point to their target tag, different a full peel to e.g. a commit.
     +    In most builtins ('rev-parse <revision>^{}', 'show-ref --dereference'),
     +    "dereferencing" a tag refers to a recursive peel of the tag object. Unlike
     +    these cases, the dereferencing prefix ('*') in 'for-each-ref' format
     +    specifiers triggers only a single, non-recursive dereference of a given tag
     +    object. For most annotated tags, a single dereference is all that is needed
     +    to access the tag's associated commit or tree; "recursive" and
     +    "non-recursive" dereferencing are functionally equivalent in these cases.
     +    However, nested tags (annotated tags whose target is another annotated tag)
     +    dereferenced once return another tag, where a recursive dereference would
     +    return the commit or tree.
      
          Currently, if a user wants to filter & format refs and include information
     -    about the fully dereferenced tag, they can do so with something like
     +    about a recursively-dereferenced tag, they can do so with something like
          'cat-file --batch-check':
      
              git for-each-ref --format="%(objectname)^{} %(refname)" <pattern> |
                  git cat-file --batch-check="%(objectname) %(rest)"
      
          But the combination of commands is inefficient. So, to improve the
     -    efficiency of this use case, add a '--full-deref' option that causes
     -    'for-each-ref' to fully dereference tags when formatting with '*' fields.
     +    performance of this use case and align the defererencing behavior of
     +    'for-each-ref' with that of other commands, update the ref formatting code
     +    to use the peeled tag (from 'peel_iterated_oid()') to populate '*' fields
     +    rather than the tag's immediate target object (from 'get_tagged_oid()').
     +
     +    Additionally, add a test to 't6300-for-each-ref' to verify new nested tag
     +    behavior and update 't6302-for-each-ref-filter.sh' to print the correct
     +    value for nested dereferenced fields.
      
          Signed-off-by: Victoria Dye <vdye@github.com>
      
       ## Documentation/git-for-each-ref.txt ##
     -@@ Documentation/git-for-each-ref.txt: SYNOPSIS
     - 'git for-each-ref' [--count=<count>] [--shell|--perl|--python|--tcl]
     - 		   [(--sort=<key>)...] [--format=<format>]
     - 		   [ --stdin | <pattern>... ]
     -+		   [--full-deref]
     - 		   [--points-at=<object>]
     - 		   [--merged[=<object>]] [--no-merged[=<object>]]
     - 		   [--contains[=<object>]] [--no-contains[=<object>]]
     -@@ Documentation/git-for-each-ref.txt: OPTIONS
     - 	the specified host language.  This is meant to produce
     - 	a scriptlet that can directly be `eval`ed.
     +@@ Documentation/git-for-each-ref.txt: from the `committer` or `tagger` fields depending on the object type.
     + These are intended for working on a mix of annotated and lightweight tags.
       
     -+--full-deref::
     -+	Populate dereferenced format fields (indicated with an asterisk (`*`)
     -+	prefix before the fieldname) with information about the fully-peeled
     -+	target object of a tag ref, rather than its immediate target object.
     -+	This only affects the output for nested annotated tags, where the tag's
     -+	immediate target is another tag but its fully-peeled target is another
     -+	object type (e.g. a commit).
     -+
     - --points-at=<object>::
     - 	Only list refs which points at the given object.
     + For tag objects, a `fieldname` prefixed with an asterisk (`*`) expands to
     +-the `fieldname` value of object the tag points at, rather than that of the
     +-tag object itself.
     ++the `fieldname` value of the peeled object, rather than that of the tag
     ++object itself.
       
     -
     - ## builtin/for-each-ref.c ##
     -@@ builtin/for-each-ref.c: int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
     - 		OPT_INTEGER( 0 , "count", &format.array_opts.max_count, N_("show only <n> matched refs")),
     - 		OPT_STRING(  0 , "format", &format.format, N_("format"), N_("format to use for the output")),
     - 		OPT__COLOR(&format.use_color, N_("respect format colors")),
     -+		OPT_BOOL(0, "full-deref", &format.full_deref,
     -+			 N_("fully dereference tags to populate '*' format fields")),
     - 		OPT_REF_FILTER_EXCLUDE(&filter),
     - 		OPT_REF_SORT(&sorting_options),
     - 		OPT_CALLBACK(0, "points-at", &filter.points_at,
     + Fields that have name-email-date tuple as its value (`author`,
     + `committer`, and `tagger`) can be suffixed with `name`, `email`,
      
       ## ref-filter.c ##
     -@@ ref-filter.c: static struct used_atom {
     - 		char *head;
     - 	} u;
     - } *used_atom;
     --static int used_atom_cnt, need_tagged, need_symref;
     -+static int used_atom_cnt, need_symref;
     -+
     -+enum tag_dereference_mode {
     -+	NO_DEREF = 0,
     -+	DEREF_ONE,
     -+	DEREF_ALL
     -+};
     -+static enum tag_dereference_mode need_tagged;
     - 
     - /*
     -  * Expand string, append it to strbuf *sb, then return error code ret.
     -@@ ref-filter.c: static int parse_ref_filter_atom(struct ref_format *format,
     - 	memset(&used_atom[at].u, 0, sizeof(used_atom[at].u));
     - 	if (valid_atom[i].parser && valid_atom[i].parser(format, &used_atom[at], arg, err))
     - 		return -1;
     --	if (*atom == '*')
     --		need_tagged = 1;
     -+	if (*atom == '*' && !need_tagged)
     -+		need_tagged = format->full_deref ? DEREF_ALL : DEREF_ONE;
     - 	if (i == ATOM_SYMREF)
     - 		need_symref = 1;
     - 	return at;
      @@ ref-filter.c: static int populate_value(struct ref_array_item *ref, struct strbuf *err)
     - 	 * If it is a tag object, see if we use a value that derefs
     - 	 * the object, and if we do grab the object it refers to.
     + 		return 0;
     + 
     + 	/*
     +-	 * If it is a tag object, see if we use a value that derefs
     +-	 * the object, and if we do grab the object it refers to.
     ++	 * If it is a tag object, see if we use the peeled value. If we do,
     ++	 * grab the peeled OID.
       	 */
      -	oi_deref.oid = *get_tagged_oid((struct tag *)obj);
     -+	if (need_tagged == DEREF_ALL) {
     -+		if (peel_iterated_oid(&obj->oid, &oi_deref.oid))
     -+			die("bad tag");
     -+	} else {
     -+		oi_deref.oid = *get_tagged_oid((struct tag *)obj);
     -+	}
     ++	if (need_tagged && peel_iterated_oid(&obj->oid, &oi_deref.oid))
     ++		die("bad tag");
       
      -	/*
      -	 * NEEDSWORK: This derefs tag only once, which
     @@ ref-filter.c: static int populate_value(struct ref_array_item *ref, struct strbu
       }
       
      
     - ## ref-filter.h ##
     -@@ ref-filter.h: struct ref_format {
     - 	const char *rest;
     - 	int quote_style;
     - 	int use_color;
     -+	int full_deref;
     - 
     - 	/* Internal state to ref-filter */
     - 	int need_color_reset_at_eol;
     -
       ## t/t6300-for-each-ref.sh ##
      @@ t/t6300-for-each-ref.sh: test_expect_success 'git for-each-ref with non-existing refs' '
       	test_must_be_empty actual
     @@ t/t6300-for-each-ref.sh: test_expect_success 'git for-each-ref with non-existing
      +	nest1_tag_oid="$(git rev-parse refs/tags/nested/nest1)" &&
      +	nest2_tag_oid="$(git rev-parse refs/tags/nested/nest2)" &&
      +
     -+	# Without full dereference
     -+	cat >expect <<-EOF &&
     -+	refs/tags/nested/base $base_tag_oid tag $head_oid commit
     -+	refs/tags/nested/nest1 $nest1_tag_oid tag $base_tag_oid tag
     -+	refs/tags/nested/nest2 $nest2_tag_oid tag $nest1_tag_oid tag
     -+	EOF
     -+
     -+	git for-each-ref --format="%(refname) %(objectname) %(objecttype) %(*objectname) %(*objecttype)" \
     -+		refs/tags/nested/ >actual &&
     -+	test_cmp expect actual &&
     -+
     -+	# With full dereference
      +	cat >expect <<-EOF &&
      +	refs/tags/nested/base $base_tag_oid tag $head_oid commit
      +	refs/tags/nested/nest1 $nest1_tag_oid tag $head_oid commit
      +	refs/tags/nested/nest2 $nest2_tag_oid tag $head_oid commit
      +	EOF
      +
     -+	git for-each-ref --full-deref \
     ++	git for-each-ref \
      +		--format="%(refname) %(objectname) %(objecttype) %(*objectname) %(*objecttype)" \
      +		refs/tags/nested/ >actual &&
      +	test_cmp expect actual
     @@ t/t6300-for-each-ref.sh: test_expect_success 'git for-each-ref with non-existing
       GRADE_FORMAT="%(signature:grade)%0a%(signature:key)%0a%(signature:signer)%0a%(signature:fingerprint)%0a%(signature:primarykeyfingerprint)"
       TRUSTLEVEL_FORMAT="%(signature:trustlevel)%0a%(signature:key)%0a%(signature:signer)%0a%(signature:fingerprint)%0a%(signature:primarykeyfingerprint)"
       
     +
     + ## t/t6302-for-each-ref-filter.sh ##
     +@@ t/t6302-for-each-ref-filter.sh: test_expect_success 'check signed tags with --points-at' '
     + 	sed -e "s/Z$//" >expect <<-\EOF &&
     + 	refs/heads/side Z
     + 	refs/tags/annotated-tag four
     +-	refs/tags/doubly-annotated-tag An annotated tag
     +-	refs/tags/doubly-signed-tag A signed tag
     ++	refs/tags/doubly-annotated-tag four
     ++	refs/tags/doubly-signed-tag four
     + 	refs/tags/four Z
     + 	refs/tags/signed-tag four
     + 	EOF
  9:  a409d773057 ! 10:  d51d073aa4a t/perf: add perf tests for for-each-ref
     @@ Commit message
          Add performance tests for 'for-each-ref'. The tests exercise different
          combinations of filters/formats/options, as well as the overall performance
          of 'git for-each-ref | git cat-file --batch-check' to demonstrate the
     -    performance difference vs. 'git for-each-ref --full-deref'.
     +    performance difference vs. 'git for-each-ref' with "%(*fieldname)" format
     +    specifiers.
      
          All tests are run against a repository with 40k loose refs - 10k commits,
          each having a unique:
     @@ t/perf/p6300-for-each-ref.sh (new)
      +run_tests () {
      +	test_for_each_ref "$1"
      +	test_for_each_ref "$1, no sort" --no-sort
     ++	test_for_each_ref "$1, --count=1" --count=1
     ++	test_for_each_ref "$1, --count=1, no sort" --no-sort --count=1
      +	test_for_each_ref "$1, tags" refs/tags/
      +	test_for_each_ref "$1, tags, no sort" --no-sort refs/tags/
     -+	test_for_each_ref "$1, tags, shallow deref" '--format="%(refname) %(objectname) %(*objectname)"' refs/tags/
     -+	test_for_each_ref "$1, tags, shallow deref, no sort" --no-sort '--format="%(refname) %(objectname) %(*objectname)"' refs/tags/
     -+	test_for_each_ref "$1, tags, full deref" --full-deref '--format="%(refname) %(objectname) %(*objectname)"' refs/tags/
     -+	test_for_each_ref "$1, tags, full deref, no sort" --no-sort --full-deref '--format="%(refname) %(objectname) %(*objectname)"' refs/tags/
     ++	test_for_each_ref "$1, tags, dereferenced" '--format="%(refname) %(objectname) %(*objectname)"' refs/tags/
     ++	test_for_each_ref "$1, tags, dereferenced, no sort" --no-sort '--format="%(refname) %(objectname) %(*objectname)"' refs/tags/
      +
     -+	test_perf "for-each-ref ($1, tags) + cat-file --batch-check (full deref)" "
     ++	test_perf "for-each-ref ($1, tags) + cat-file --batch-check (dereferenced)" "
      +		for i in \$(test_seq $test_iteration_count); do
      +			git for-each-ref --format='%(objectname)^{} %(refname) %(objectname)' refs/tags/ | \
      +				git cat-file --batch-check='%(objectname) %(rest)' >/dev/null

-- 
gitgitgadget
