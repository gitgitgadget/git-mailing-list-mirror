Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0501FC61DA4
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 17:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbjCORqn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 13:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbjCORqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 13:46:25 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F7214230
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 10:45:53 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id i9so9055336wrp.3
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 10:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678902345;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jBaL5czZVGke0VSikWsI7gufItHvnjhbeyrWj2cUmKE=;
        b=PQm0QLhgbnwMfnQiLisQz3gBLZr2Qr+MJVK7W32EfWROBiwOsxfH++zEqzBSVAik6C
         BJhGA9+R2ekV4fbkx+RRGgJHm05KKOjpDy1TgzKIxYT2CLYuCdzGRM6ClDDWa3nNyf5g
         UQ1FbdLc8iPf/kWAfIr1ZBjTY97PMb0I2cDatbGxnWoevtAmUfM1pddbel+M5FBPbtmu
         L5Yqq21cV1Qmt1DViHKp/chNB2kjw0S2Sbw6Vc593/2HtWFuQQitfmovaIs7RVRE3nK1
         ZDMW6Kb7hiNiyU3cO9nxhTag1FpCa6/jFz0dCjAxhiYYWxow3gAUHI/PvVDn8BRZ7oWg
         B+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678902345;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jBaL5czZVGke0VSikWsI7gufItHvnjhbeyrWj2cUmKE=;
        b=civMHn38XrS762RsWoCYufUoXp4ue1v/cOlVVRwm2SLf/aAqyvm+Arxw7FbusYsqai
         ZlehKSXpckxf8x1cUD5IQjB0RZYk/b62miQCGjVYHiRltnSjHgrnyfF585ZYhIqkmgHc
         wm/1z5SNYmG32XJLE7ojoArYPwOEwutxGKmX+67voLK5ZUzlv6xmqmulhoOw4gMtmG0m
         KhbxWsvZAqQitF67db8Gjk/MpOXVQpmqlyvSKkIg5iGC8M7XGM39xQIHxx/ntsJCa6cD
         5ZqyCHZ9r+xzoU2pEXzU8qLC7GmNqBDSR5hZF3dGa5GnnGhYMeJM5OyeyicOH3KeqQJl
         r/oA==
X-Gm-Message-State: AO0yUKUSriFDYh+C1nO4ZFCNwHBw2Pc/8IpJ+i5Az8q7YBTtDEul9nHl
        /KIUH3wN4IyVIabpbdyZH6q2aNnmOrw=
X-Google-Smtp-Source: AK7set+YrmgvjEaiVWjrE8juhQesVo/c6qecy5OmU/m8xefl+o6RX6cCAwYq7z852PK/6mmZhP9qWQ==
X-Received: by 2002:a5d:5745:0:b0:2ce:a096:b55f with SMTP id q5-20020a5d5745000000b002cea096b55fmr2722306wrw.45.1678902345120;
        Wed, 15 Mar 2023 10:45:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j8-20020a5d5648000000b002c559843748sm5153895wrw.10.2023.03.15.10.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 10:45:44 -0700 (PDT)
Message-Id: <pull.1489.v3.git.1678902343.gitgitgadget@gmail.com>
In-Reply-To: <pull.1489.v2.git.1678468863.gitgitgadget@gmail.com>
References: <pull.1489.v2.git.1678468863.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Mar 2023 17:45:35 +0000
Subject: [PATCH v3 0/8] ref-filter: ahead/behind counting, faster --merged option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At $DAYJOB, we have used a custom 'ahead-behind' builtin in our fork of Git
for lots of reasons. The main goal of the builtin is to compare multiple
references against a common base reference. The comparison is number of
commits that are in each side of the symmtric difference of their reachable
sets. A commit C is "ahead" of a commit B by the number of commits in B..C
(reachable from C but not reachable from B). Similarly, the commit C is
"behind" the commit B by the number of commits in C..B (reachable from B but
not reachable from C).

These numbers can be computed by 'git rev-list --count B..C' and 'git
rev-list --count C..B', but there are common needs that benefit from having
the checks being done in the same process:

 1. Our "branches" page lists ahead/behind counts for each listed branch as
    compared to the repo's default branch. This can be done with a single
    'git ahead-behind' process.
 2. When a branch is updated, a background job checks if any pull requests
    that target that branch should be closed because their branches were
    merged implicitly by that update. These queries can e batched into 'git
    ahead-behind' calls.

In that second example, we don't need the full ahead/behind counts (although
it is sufficient to look for branches that are "zero commits ahead", meaning
they are reachable from the base), and instead reachability is the critical
piece.

This series contributes the custom algorithms we used for our 'git
ahead-behind' builtin, but as extensions to 'git for-each-ref':

 * Add a new "%(ahead-behind:)" format token to for-each-ref which allows
   outputting the ahead/behind values in the format string for a matching
   ref.
 * Add a new algorithm that speeds up the 'git for-each-ref --merged='
   option. This also applies to the 'git branch --merged=' option.

The idea to use 'git for-each-ref' instead of creating a new builtin is from
Junio, and simplifies this series significantly compared to v1. I was
initially concerned about the overhead of 'git for-each-ref' and its
generality and sorting, but I was not able to measure any important
difference between this implementation and our internal 'git ahead-behind'
implementation. In particular, when a pattern is given to 'git for-each-ref'
that looks like an exact ref, it navigates directly to the ref instead of
scanning all references for matches.

However, for our specific uses, we like to batch a list of exact references
that could be very long. We introduce a new --stdin option here.

To keep things close to the v1 outline, I replaced the existing patches with
closely-related ones, when possible.

Patch 1 adds the --stdin option to 'git for-each-ref'. (This is similar to
the boilerplate patch from v1.)

Patch 2 adds a test to explicitly check that 'git for-each-ref' will still
succeed when all input refs are missing. (This is similar to the
--ignore-missing patch from v1.)

Patches 3-5 introduce a new method: ensure_generations_valid(). Patch 3 does
some refactoring of the existing generation number computations to make it
more generic, and patch 4 updates the definition of
commit_graph_generation() slightly, making way for patch 5 to implement the
method. With an existing commit-graph file, the commits that are not present
in the file are considered as having generation number "infinity". This is
useful for most of our reachability queries to this point, since those
commits are "above" the ones tracked by the commit-graph. When these commits
are low in number, then there is very little performance cost and zero
correctness cost. (These patches match v1 exactly.)

However, we will see that the ahead/behind computation requires accurate
generation numbers to avoid overcounting. Thus, ensure_generations_valid()
is a way to specify a list of commits that need generation numbers computed
before continuing. It's a no-op if all of those commits are in the
commit-graph file. It's expensive if the commit-graph doesn't exist.
However, '%(ahead-behind:)' computations are likely to be slow no matter
what without a commit-graph, so assuming an existing commit-graph file is
reasonable. If we find sufficient desire to have an implementation that does
not have this requirement, we could create a second implementation and
toggle to it when generation_numbers_enabled() returns false.

Patch 6 implements the ahead-behind algorithm, but it is not connected to a
builtin. It's a long commit message, so hopefully it explains the algorithm
sufficiently. (The difference from v1 is that it no longer integrates with a
builtin and there are no new tests. It also uses 'unsigned int' and is
correctly co-authored by Taylor.)

Patch 7 integrates the ahead-behind algorithm with the ref-filter code,
including parsing the "ahead-behind" token. This finally adds tests that
check both ahead_behind() and ensure_generations_valid() via
t6600-test-reach.sh. (This patch is essentially completely new in v2.)

Patch 8 implements the tips_reachable_from_base() method, and uses it within
the ref-filter code to speed up 'git for-each-ref --merged' and 'git branch
--merged'. (The interface is slightly different than v1, due to the needs of
the new caller.)


Updates in v3
=============

 * The APIs are modified to take a 'struct repository *' and use them
   appropriately.
 * The --stdin option in 'git for-each-ref' now uses strvec instead of an
   ad-hoc array.

Thanks, -Stolee

Derrick Stolee (7):
  for-each-ref: add --stdin option
  for-each-ref: explicitly test no matches
  commit-graph: combine generation computations
  commit-graph: return generation from memory
  commit-reach: implement ahead_behind() logic
  for-each-ref: add ahead-behind format atom
  commit-reach: add tips_reachable_from_bases()

Taylor Blau (1):
  commit-graph: introduce `ensure_generations_valid()`

 Documentation/git-for-each-ref.txt |  12 +-
 builtin/branch.c                   |   1 +
 builtin/for-each-ref.c             |  24 +++-
 builtin/tag.c                      |   1 +
 commit-graph.c                     | 208 ++++++++++++++++++----------
 commit-graph.h                     |   8 ++
 commit-reach.c                     | 209 +++++++++++++++++++++++++++++
 commit-reach.h                     |  40 ++++++
 ref-filter.c                       |  91 ++++++++++---
 ref-filter.h                       |  26 +++-
 t/perf/p1500-graph-walks.sh        |  50 +++++++
 t/t3203-branch-output.sh           |  14 ++
 t/t5318-commit-graph.sh            |   2 +-
 t/t6300-for-each-ref.sh            |  50 +++++++
 t/t6301-for-each-ref-errors.sh     |  14 ++
 t/t6600-test-reach.sh              | 169 +++++++++++++++++++++++
 t/t7004-tag.sh                     |  28 ++++
 17 files changed, 858 insertions(+), 89 deletions(-)
 create mode 100755 t/perf/p1500-graph-walks.sh


base-commit: 725f57037d81e24eacfda6e59a19c60c0b4c8062
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1489%2Fderrickstolee%2Fstolee%2Fupstream-ahead-behind-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1489/derrickstolee/stolee/upstream-ahead-behind-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1489

Range-diff vs v2:

 1:  a1d9e0f6ff6 ! 1:  f9e80e233f1 for-each-ref: add --stdin option
     @@ Commit message
          list is interpreted as the complete ref set.
      
          When reading from stdin, we populate the filter.name_patterns array
     -    dynamically as opposed to pointing to the 'argv' array directly. This
     -    requires a careful cast while freeing the individual strings,
     -    conditioned on the --stdin option.
     +    dynamically as opposed to pointing to the 'argv' array directly. This is
     +    simple when using a strvec, as it is NULL-terminated in the same way. We
     +    then free the memory directly from the strvec.
      
     +    Helped-by: Phillip Wood <phillip.wood123@gmail.com>
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
       ## Documentation/git-for-each-ref.txt ##
     @@ Documentation/git-for-each-ref.txt: OPTIONS
       	`<pattern>`.  This option makes it stop after showing
      
       ## builtin/for-each-ref.c ##
     +@@
     + #include "object.h"
     + #include "parse-options.h"
     + #include "ref-filter.h"
     ++#include "strvec.h"
     + 
     + static char const * const for_each_ref_usage[] = {
     + 	N_("git for-each-ref [<options>] [<pattern>]"),
      @@ builtin/for-each-ref.c: int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
       	struct ref_format format = REF_FORMAT_INIT;
       	struct strbuf output = STRBUF_INIT;
       	struct strbuf err = STRBUF_INIT;
      +	int from_stdin = 0;
     ++	struct strvec vec = STRVEC_INIT;
       
       	struct option opts[] = {
       		OPT_BIT('s', "shell", &format.quote_style,
     @@ builtin/for-each-ref.c: int cmd_for_each_ref(int argc, const char **argv, const
      -	filter.name_patterns = argv;
      +	if (from_stdin) {
      +		struct strbuf line = STRBUF_INIT;
     -+		size_t nr = 0, alloc = 16;
      +
      +		if (argv[0])
      +			die(_("unknown arguments supplied with --stdin"));
      +
     -+		CALLOC_ARRAY(filter.name_patterns, alloc);
     -+
     -+		while (strbuf_getline(&line, stdin) != EOF) {
     -+			ALLOC_GROW(filter.name_patterns, nr + 1, alloc);
     -+			filter.name_patterns[nr++] = strbuf_detach(&line, NULL);
     -+		}
     ++		while (strbuf_getline(&line, stdin) != EOF)
     ++			strvec_push(&vec, line.buf);
      +
     -+		/* Add a terminating NULL string. */
     -+		ALLOC_GROW(filter.name_patterns, nr + 1, alloc);
     -+		filter.name_patterns[nr + 1] = NULL;
     ++		/* vec.v is NULL-terminated, just like 'argv'. */
     ++		filter.name_patterns = vec.v;
      +	} else {
      +		filter.name_patterns = argv;
      +	}
     @@ builtin/for-each-ref.c: int cmd_for_each_ref(int argc, const char **argv, const
       	free_commit_list(filter.with_commit);
       	free_commit_list(filter.no_commit);
       	ref_sorting_release(sorting);
     -+	if (from_stdin) {
     -+		for (size_t i = 0; filter.name_patterns[i]; i++)
     -+			free((char *)filter.name_patterns[i]);
     -+		free(filter.name_patterns);
     -+	}
     ++	strvec_clear(&vec);
       	return 0;
       }
      
 2:  2f162a2f39f = 2:  f56d6a64d24 for-each-ref: explicitly test no matches
 3:  db28e82d2a6 = 3:  3b15e9df770 commit-graph: combine generation computations
 4:  3cf33801443 = 4:  abd3e7a67be commit-graph: return generation from memory
 5:  34dffd836b1 ! 5:  e197bddcace commit-graph: introduce `ensure_generations_valid()`
     @@ commit-graph.c: static void compute_generation_numbers(struct write_commit_graph
      + * After this method, all commits reachable from those in the given
      + * list will have non-zero, non-infinite generation numbers.
      + */
     -+void ensure_generations_valid(struct commit **commits, size_t nr)
     ++void ensure_generations_valid(struct repository *r,
     ++			      struct commit **commits, size_t nr)
      +{
     -+	struct repository *r = the_repository;
      +	int generation_version = get_configured_generation_version(r);
      +	struct packed_commit_list list = {
      +		.list = commits,
     @@ commit-graph.h: struct commit_graph_data {
      + * After this method, all commits reachable from those in the given
      + * list will have non-zero, non-infinite generation numbers.
      + */
     -+void ensure_generations_valid(struct commit **commits, size_t nr);
     ++void ensure_generations_valid(struct repository *r,
     ++			      struct commit **commits, size_t nr);
      +
       #endif
 6:  9831c23eadb ! 6:  0fb3913810b commit-reach: implement ahead_behind() logic
     @@ commit-reach.c: struct commit_list *get_reachable_subset(struct commit **from, i
      +	*bitmap = NULL;
      +}
      +
     -+void ahead_behind(struct commit **commits, size_t commits_nr,
     ++void ahead_behind(struct repository *r,
     ++		  struct commit **commits, size_t commits_nr,
      +		  struct ahead_behind_count *counts, size_t counts_nr)
      +{
     -+	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
     ++	struct prio_queue queue = { .compare = compare_commits_by_gen_then_commit_date };
      +	size_t width = (commits_nr + BITS_IN_EWORD - 1) / BITS_IN_EWORD;
     -+	size_t i;
      +
      +	if (!commits_nr || !counts_nr)
      +		return;
      +
     -+	for (i = 0; i < counts_nr; i++) {
     ++	for (size_t i = 0; i < counts_nr; i++) {
      +		counts[i].ahead = 0;
      +		counts[i].behind = 0;
      +	}
      +
     -+	ensure_generations_valid(commits, commits_nr);
     ++	ensure_generations_valid(r, commits, commits_nr);
      +
      +	init_bit_arrays(&bit_arrays);
      +
     -+	for (i = 0; i < commits_nr; i++) {
     ++	for (size_t i = 0; i < commits_nr; i++) {
      +		struct commit *c = commits[i];
      +		struct bitmap *bitmap = init_bit_array(c, width);
      +
     @@ commit-reach.c: struct commit_list *get_reachable_subset(struct commit **from, i
      +		struct commit_list *p;
      +		struct bitmap *bitmap_c = init_bit_array(c, width);
      +
     -+		for (i = 0; i < counts_nr; i++) {
     ++		for (size_t i = 0; i < counts_nr; i++) {
      +			int reach_from_tip = !!bitmap_get(bitmap_c, counts[i].tip_index);
      +			int reach_from_base = !!bitmap_get(bitmap_c, counts[i].base_index);
      +
     @@ commit-reach.c: struct commit_list *get_reachable_subset(struct commit **from, i
      +		for (p = c->parents; p; p = p->next) {
      +			struct bitmap *bitmap_p;
      +
     -+			parse_commit(p->item);
     ++			repo_parse_commit(r, p->item);
      +
      +			bitmap_p = init_bit_array(p->item, width);
      +			bitmap_or(bitmap_p, bitmap_c);
     @@ commit-reach.c: struct commit_list *get_reachable_subset(struct commit **from, i
      +	}
      +
      +	/* STALE is used here, PARENT2 is used by insert_no_dup(). */
     -+	repo_clear_commit_marks(the_repository, PARENT2 | STALE);
     ++	repo_clear_commit_marks(r, PARENT2 | STALE);
      +	clear_bit_arrays(&bit_arrays);
      +	clear_prio_queue(&queue);
      +}
     @@ commit-reach.h: struct commit_list *get_reachable_subset(struct commit **from, i
      + * Given an array of commits and an array of ahead_behind_count pairs,
      + * compute the ahead/behind counts for each pair.
      + */
     -+void ahead_behind(struct commit **commits, size_t commits_nr,
     ++void ahead_behind(struct repository *r,
     ++		  struct commit **commits, size_t commits_nr,
      +		  struct ahead_behind_count *counts, size_t counts_nr);
      +
       #endif
 7:  82dd6f44a33 ! 7:  59cf6759e60 for-each-ref: add ahead-behind format atom
     @@ Commit message
          around commits_nr in the second loop of filter_ahead_behind(). Also, the
          test in t7004 is carefully located to avoid being dependent on the GPG
          prereq. It also avoids using the test_commit helper, as that will add
     -    ticks to the time and disrupt the expected timestampes in later tag
     +    ticks to the time and disrupt the expected timestamps in later tag
          tests.
      
          Also add performance tests in a new p1300-graph-walks.sh script. This
     @@ Documentation/git-for-each-ref.txt: worktreepath::
       	out, if it is checked out in any linked worktree. Empty string
       	otherwise.
       
     -+ahead-behind:<ref>::
     ++ahead-behind:<committish>::
      +	Two integers, separated by a space, demonstrating the number of
      +	commits ahead and behind, respectively, when comparing the output
     -+	ref to the `<ref>` specified in the format.
     ++	ref to the `<committish>` specified in the format.
      +
       In addition to the above, for commit and tag objects, the header
       field names (`tree`, `parent`, `object`, `type`, and `tag`) can
     @@ builtin/branch.c: static void print_ref_list(struct ref_filter *filter, struct r
       	if (verify_ref_format(format))
       		die(_("unable to parse format string"));
       
     -+	filter_ahead_behind(format, &array);
     ++	filter_ahead_behind(the_repository, format, &array);
       	ref_array_sort(sorting, &array);
       
       	for (i = 0; i < array.nr; i++) {
      
       ## builtin/for-each-ref.c ##
      @@
     - #include "object.h"
       #include "parse-options.h"
       #include "ref-filter.h"
     + #include "strvec.h"
      +#include "commit-reach.h"
       
       static char const * const for_each_ref_usage[] = {
     @@ builtin/for-each-ref.c: int cmd_for_each_ref(int argc, const char **argv, const
       
       	filter.match_as_path = 1;
       	filter_refs(&array, &filter, FILTER_REFS_ALL);
     -+	filter_ahead_behind(&format, &array);
     ++	filter_ahead_behind(the_repository, &format, &array);
      +
       	ref_array_sort(sorting, &array);
       
     @@ builtin/tag.c: static int list_tags(struct ref_filter *filter, struct ref_sortin
       		die(_("unable to parse format string"));
       	filter->with_commit_tag_algo = 1;
       	filter_refs(&array, filter, FILTER_REFS_TAGS);
     -+	filter_ahead_behind(format, &array);
     ++	filter_ahead_behind(the_repository, format, &array);
       	ref_array_sort(sorting, &array);
       
       	for (i = 0; i < array.nr; i++) {
     @@ ref-filter.c: static void reach_filter(struct ref_array *array,
       	free(to_clear);
       }
       
     -+void filter_ahead_behind(struct ref_format *format,
     ++void filter_ahead_behind(struct repository *r,
     ++			 struct ref_format *format,
      +			 struct ref_array *array)
      +{
      +	struct commit **commits;
     @@ ref-filter.c: static void reach_filter(struct ref_array *array,
      +		commits_nr++;
      +	}
      +
     -+	ahead_behind(commits, commits_nr, array->counts, array->counts_nr);
     ++	ahead_behind(r, commits, commits_nr, array->counts, array->counts_nr);
      +	free(commits);
      +}
      +
     @@ ref-filter.h: struct ref_array_item *ref_array_push(struct ref_array *array,
      + *
      + * If this is not called, then any ahead-behind atoms will be blank.
      + */
     -+void filter_ahead_behind(struct ref_format *format,
     ++void filter_ahead_behind(struct repository *r,
     ++			 struct ref_format *format,
      +			 struct ref_array *array);
      +
       #endif /*  REF_FILTER_H  */
     @@ t/t6301-for-each-ref-errors.sh: test_expect_success 'Missing objects are reporte
      +test_expect_success 'ahead-behind requires an argument' '
      +	test_must_fail git for-each-ref \
      +		--format="%(ahead-behind)" 2>err &&
     -+	grep "expected format: %(ahead-behind:<ref>)" err
     ++	echo "fatal: expected format: %(ahead-behind:<ref>)" >expect &&
     ++	test_cmp expect err
      +'
      +
      +test_expect_success 'missing ahead-behind base' '
      +	test_must_fail git for-each-ref \
      +		--format="%(ahead-behind:refs/heads/missing)" 2>err &&
     -+	grep "failed to find '\''refs/heads/missing'\''" err
     ++	echo "fatal: failed to find '\''refs/heads/missing'\''" >expect &&
     ++	test_cmp expect err
      +'
      +
       test_done
     @@ t/t7004-tag.sh: test_expect_success 'annotations for blobs are empty' '
      +	git commit --allow-empty -m "right" &&
      +	git tag -a -m left tag-right &&
      +
     -+	# Use " !" at the end to demonstrate whitepsace
     ++	# Use " !" at the end to demonstrate whitespace
      +	# around empty ahead-behind token for tag-blob.
      +	cat >expect <<-EOF &&
      +	refs/tags/tag-blob  !
 8:  f3fb6833bd7 ! 8:  7476a39331e commit-reach: add tips_reachable_from_bases()
     @@ Commit message
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
       ## commit-reach.c ##
     -@@ commit-reach.c: void ahead_behind(struct commit **commits, size_t commits_nr,
     +@@ commit-reach.c: void ahead_behind(struct repository *r,
       	clear_bit_arrays(&bit_arrays);
       	clear_prio_queue(&queue);
       }
     @@ commit-reach.c: void ahead_behind(struct commit **commits, size_t commits_nr,
      +	return 0;
      +}
      +
     -+void tips_reachable_from_bases(struct commit_list *bases,
     ++void tips_reachable_from_bases(struct repository *r,
     ++			       struct commit_list *bases,
      +			       struct commit **tips, size_t tips_nr,
      +			       int mark)
      +{
     -+	size_t i;
      +	struct commit_and_index *commits;
     -+	unsigned int min_generation_index = 0;
     ++	size_t min_generation_index = 0;
      +	timestamp_t min_generation;
      +	struct commit_list *stack = NULL;
      +
     @@ commit-reach.c: void ahead_behind(struct commit **commits, size_t commits_nr,
      +
      +	CALLOC_ARRAY(commits, tips_nr);
      +
     -+	for (i = 0; i < tips_nr; i++) {
     ++	for (size_t i = 0; i < tips_nr; i++) {
      +		commits[i].commit = tips[i];
      +		commits[i].index = i;
      +		commits[i].generation = commit_graph_generation(tips[i]);
     @@ commit-reach.c: void ahead_behind(struct commit **commits, size_t commits_nr,
      +	min_generation = commits[0].generation;
      +
      +	while (bases) {
     -+		parse_commit(bases->item);
     ++		repo_parse_commit(r, bases->item);
      +		commit_list_insert(bases->item, &stack);
      +		bases = bases->next;
      +	}
      +
      +	while (stack) {
     -+		unsigned int j;
      +		int explored_all_parents = 1;
      +		struct commit_list *p;
      +		struct commit *c = stack->item;
      +		timestamp_t c_gen = commit_graph_generation(c);
      +
      +		/* Does it match any of our tips? */
     -+		for (j = min_generation_index; j < tips_nr; j++) {
     ++		for (size_t j = min_generation_index; j < tips_nr; j++) {
      +			if (c_gen < commits[j].generation)
      +				break;
      +
     @@ commit-reach.c: void ahead_behind(struct commit **commits, size_t commits_nr,
      +		}
      +
      +		for (p = c->parents; p; p = p->next) {
     -+			parse_commit(p->item);
     ++			repo_parse_commit(r, p->item);
      +
      +			/* Have we already explored this parent? */
      +			if (p->item->object.flags & SEEN)
     @@ commit-reach.c: void ahead_behind(struct commit **commits, size_t commits_nr,
      +
      +done:
      +	free(commits);
     -+	repo_clear_commit_marks(the_repository, SEEN);
     ++	repo_clear_commit_marks(r, SEEN);
      +}
      
       ## commit-reach.h ##
     -@@ commit-reach.h: struct ahead_behind_count {
     - void ahead_behind(struct commit **commits, size_t commits_nr,
     +@@ commit-reach.h: void ahead_behind(struct repository *r,
     + 		  struct commit **commits, size_t commits_nr,
       		  struct ahead_behind_count *counts, size_t counts_nr);
       
      +/*
      + * For all tip commits, add 'mark' to their flags if and only if they
      + * are reachable from one of the commits in 'bases'.
      + */
     -+void tips_reachable_from_bases(struct commit_list *bases,
     ++void tips_reachable_from_bases(struct repository *r,
     ++			       struct commit_list *bases,
      +			       struct commit **tips, size_t tips_nr,
      +			       int mark);
      +
     @@ ref-filter.c: static void reach_filter(struct ref_array *array,
      -	revs.limited = 1;
      -	if (prepare_revision_walk(&revs))
      -		die(_("revision walk setup failed"));
     -+	tips_reachable_from_bases(check_reachable,
     ++	tips_reachable_from_bases(the_repository,
     ++				  check_reachable,
      +				  to_clear, array->nr,
      +				  UNINTERESTING);
       

-- 
gitgitgadget
