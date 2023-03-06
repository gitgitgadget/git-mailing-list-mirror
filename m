Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB3DC678D4
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 14:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjCFOIF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 09:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjCFOHT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 09:07:19 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF16303CC
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 06:06:53 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id e13so8908334wro.10
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 06:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678111605;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=effbrmf4qF+w5FU0vpxjS54PIfVYnoX4SH8VIG8UrOY=;
        b=ONGhAMDS18ezs+wD92QJZgoq7UPTkjuUF/RUqJh8ic3XK6+gK9ppipjgTUm6q1Lv/x
         K535Z/t7lx1CYyvrU3D1C+YSgVcrmKK1B9LQCmC0fmYkvseJwoxKNxQHA2F8s6ijB86W
         W9aSxHuy8biXQQOl1dfhSLP9xpVTnQtPIbTuTTdwLZK0r6/7lJpbRnP6oiezW0uh7RPu
         zU8dfG7UmN/emqCDqi0soSIphg/nz2NQnw/7V04dzE9FQBgeDkfV8vYANFR6O6MfzjUk
         imltYioiUGOaZ0dfnF453Ls5O8nzLgZx+jRldtjTk0wxRWNxQjaXbp4XPWIaJYytRryc
         7gIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678111605;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=effbrmf4qF+w5FU0vpxjS54PIfVYnoX4SH8VIG8UrOY=;
        b=TMV6uXnWOint7K5YNrxlHOTrKJxilfK9ARU6wiDJ8b5k4VXsoT2+Wz9YTxeb6gFGC7
         v0V57YoAI/8GiarDr3ESjs9BvyT55Hm+Ydy2xybzmBPlTzcZrzodyq8LlwP4DnsJVpXi
         UzNupvIOn7EJCBLHeEMjDyAAU+afTkFTz/5PvSNl/nlg6u7TGQCAf1jvvoP8Xl96BdIV
         5L/A0cE0PpNgi0tKNyaJo37GQ8OjhIDlvDAa1KB/IhG10eooMntv6ku0dRNRWN9VeRkt
         huAUn9LByAFeykicLxQLa6alLct+Sf5g3mtKlV4Va68qE9cNAz1nBaPIr9nMQHAQwN+9
         oVEQ==
X-Gm-Message-State: AO0yUKVRrqI1dZC/EDfpEkSSM3JnMpL0EFidD0JJ5XNK04TAgzx1yNR1
        gZUmH8qMNcwP0lZwXpRmkwnbMcaNvV8=
X-Google-Smtp-Source: AK7set+fZsgdsEznFZu6aLeQAQKNzKmdmmSobRBM4Yw7CPdfnZOmzKAdO9C38Jw+MO6t/9sZ44QpNg==
X-Received: by 2002:adf:e506:0:b0:2ce:3d6c:9a03 with SMTP id j6-20020adfe506000000b002ce3d6c9a03mr6013569wrm.19.1678111604881;
        Mon, 06 Mar 2023 06:06:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e13-20020adff34d000000b002c53cc7504csm9861716wrp.78.2023.03.06.06.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 06:06:44 -0800 (PST)
Message-Id: <07eb2cbb699c875e5fdca86d675c97d4d434f511.1678111599.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Mar 2023 14:06:38 +0000
Subject: [PATCH 8/8] ahead-behind: add --contains mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The 'git ahead-behind' builtin can answer a list of questions that do
not require the full ahead/behind counts. For example, instead of using
'git branch --contains=<ref>' to get the full list of branches that
contain the commit at <ref>, a list of tips could be passed to 'git
ahead-behind --base=<ref>' and the rows that report a "behind" value of
zero show which tips can reach <ref>.

By contract, the rows that report an "ahead" value of zero show which
tips are reachable from the given base. This type of query does not have
an existing equivalent for batching this request. While extracting the
information from 'git ahead-behind' is not terribly difficult, it does
more work than required to answer this query: it _counts_.

Add a new '--contains' mode to 'git ahead-behind' that removes the
counting behavior and focuses instead on the reachability concern. The
output of the builtin changes in this mode: instead of reporting "<tip>
<ahead> <behind>" for every input tip, it will instead report "<tip>"
for the input tips that are reachable from the specified base.

The algorithm is implemented in commit-reach.c in the method
tips_reachable_from_base(). This method takes a string_list of tips and
assigns the 'util' for each item with the value 1 if the base commit can
reach those tips.

Like other reachability queries in commit-reach.c, the fastest way to
search for "can A reach B?" is to do a depth-first search up to the
generation number of B, preferring to explore first parents before later
parents. While we must walk all reachable commits up to that generation
number when the answer is "no", the depth-first search can answer "yes"
much faster than other approaches in most cases.

This search becomes trickier when there are multiple targets for the
depth-first search. The commits with lower generation number are more
likely to be within the history of the start commit, but we don't want
to waste time searching commits of low generation number if the commit
target with lowest generation number has already been found.

The trick here is to take the input commits and sort them by generation
number in ascending order. Track the index within this order as
min_generation_index. When we find a commit, if its index in the list is
equal to min_generation_index, then we can increase the generation
number boundary of our search to the next-lowest value in the list.

With this mechanism, the number of commits to search is minimized with
respect to the depth-first search heuristic. We will walk all commits up
to the minimum generation number of a commit that is _not_ reachable
from the start, but we will walk only the necessary portion of the
depth-first search for the reachable commits of lower generation.

We can test this completely in the simple repo example in t4218 and more
substantially in the larger repository example in t6600. We can also add
a performance test to demonstrate the speedup relative to the 'git
ahead-behind' builtin without the '--contains' option.

For the Git source code repository, I was able to measure a speedup,
even though both are quite fast.

Test                                                       this tree
--------------------------------------------------------------------------
1500.2: ahead-behind counts: git ahead-behind              0.06(0.06+0.00)
1500.3: ahead-behind counts: git rev-list                  1.08(0.90+0.18)
1500.4: ahead-behind counts: git ahead-behind --contains   0.02(0.02+0.00)

In the Linux kernel repository, the impact is more pronounced:

Test                                                       this tree
--------------------------------------------------------------------------
1500.2: ahead-behind counts: git ahead-behind              0.26(0.25+0.01)
1500.3: ahead-behind counts: git rev-list                  4.58(3.92+0.66)
1500.4: ahead-behind counts: git ahead-behind --contains   0.02(0.00+0.02)

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/git-ahead-behind.txt |  12 +++-
 builtin/ahead-behind.c             |  27 ++++++-
 commit-reach.c                     | 110 +++++++++++++++++++++++++++++
 commit-reach.h                     |   7 ++
 t/perf/p1500-graph-walks.sh        |   4 ++
 t/t4218-ahead-behind.sh            |  62 ++++++++++++++++
 t/t6600-test-reach.sh              |  58 +++++++++++++++
 7 files changed, 277 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-ahead-behind.txt b/Documentation/git-ahead-behind.txt
index 2dd5147f6b2..1652a51d719 100644
--- a/Documentation/git-ahead-behind.txt
+++ b/Documentation/git-ahead-behind.txt
@@ -8,7 +8,7 @@ git-ahead-behind - Count the commits on each side of a revision range
 SYNOPSIS
 --------
 [verse]
-'git ahead-behind' --base=<ref> [ --stdin | <revs> ]
+'git ahead-behind' --base=<ref> [ --contains ] [ --stdin | <revs> ]
 
 DESCRIPTION
 -----------
@@ -39,6 +39,9 @@ reported to stdout one line at a time as follows:
 There will be exactly one line per input revision, but the lines may be
 in an arbitrary order.
 
+If the `--contains` option is provided, then the output will list the
+`<tip>` refs are reachable from the provided `<base>`, one per line.
+
 
 OPTIONS
 -------
@@ -50,6 +53,13 @@ OPTIONS
 	Read revision tips and ranges from stdin instead of from the
 	command-line.
 
+--contains::
+	Specify that instead of counting the ahead/behind values, only
+	indicate whether each tip reference is reachable from the base. In
+	this mode, the output format changes to include only the name of
+	each tip by name, one per line, and only the tips reachable from
+	the base are included in the output.
+
 --ignore-missing::
 	When parsing tip references, ignore any references that are not
 	found. This is useful when operating in an environment where a
diff --git a/builtin/ahead-behind.c b/builtin/ahead-behind.c
index c06b95b5f37..4efd324d5d9 100644
--- a/builtin/ahead-behind.c
+++ b/builtin/ahead-behind.c
@@ -5,7 +5,7 @@
 #include "commit-reach.h"
 
 static const char * const ahead_behind_usage[] = {
-	N_("git ahead-behind --base=<ref> [ --stdin | <revs> ]"),
+	N_("git ahead-behind --base=<ref> [ --contains ] [ --stdin | <revs> ]"),
 	NULL
 };
 
@@ -31,7 +31,7 @@ int cmd_ahead_behind(int argc, const char **argv, const char *prefix)
 {
 	const char *base_ref = NULL;
 	struct commit *base;
-	int from_stdin = 0;
+	int from_stdin = 0, contains = 0;
 	struct string_list tips = STRING_LIST_INIT_DUP;
 	struct commit **commits;
 	struct ahead_behind_count *counts;
@@ -41,6 +41,7 @@ int cmd_ahead_behind(int argc, const char **argv, const char *prefix)
 		OPT_STRING('b', "base", &base_ref, N_("base"), N_("base reference to process")),
 		OPT_BOOL(0 , "stdin", &from_stdin, N_("read rev names from stdin")),
 		OPT_BOOL(0 , "ignore-missing", &ignore_missing, N_("ignore missing tip references")),
+		OPT_BOOL(0 , "contains", &contains, N_("only check that tips are reachable from the base")),
 		OPT_END()
 	};
 
@@ -52,6 +53,10 @@ int cmd_ahead_behind(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 
+	base = lookup_commit_reference_by_name(base_ref);
+	if (!base)
+		die(_("could not resolve '%s'"), base_ref);
+
 	if (from_stdin) {
 		struct strbuf line = STRBUF_INIT;
 
@@ -76,6 +81,24 @@ int cmd_ahead_behind(int argc, const char **argv, const char *prefix)
 	if (!tips.nr)
 		return 0;
 
+	if (contains) {
+		struct string_list_item *item;
+
+		/* clear out */
+		for_each_string_list_item(item, &tips)
+			item->util = NULL;
+
+		tips_reachable_from_base(base, &tips);
+
+		for_each_string_list_item(item, &tips) {
+			if (item->util)
+				printf("%s\n", item->string);
+		}
+
+		return 0;
+	}
+	/* else: not --contains, but normal ahead-behind counting. */
+
 	ALLOC_ARRAY(commits, tips.nr + 1);
 	ALLOC_ARRAY(counts, tips.nr);
 
diff --git a/commit-reach.c b/commit-reach.c
index 87ccc2cd4f5..a7a2c045551 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -1036,3 +1036,113 @@ void ahead_behind(struct commit **commits, size_t commits_nr,
 	clear_bit_arrays(&bit_arrays);
 	clear_prio_queue(&queue);
 }
+
+struct commit_and_index {
+	struct commit *commit;
+	unsigned int index;
+	timestamp_t generation;
+};
+
+static int compare_commit_and_index_by_generation(const void *va, const void *vb)
+{
+	const struct commit_and_index *a = (const struct commit_and_index *)va;
+	const struct commit_and_index *b = (const struct commit_and_index *)vb;
+
+	if (a->generation > b->generation)
+		return 1;
+	if (a->generation < b->generation)
+		return -1;
+	return 0;
+}
+
+void tips_reachable_from_base(struct commit *base,
+			      struct string_list *tips)
+{
+	unsigned int i;
+	struct commit_and_index *commits;
+	unsigned int min_generation_index = 0;
+	timestamp_t min_generation;
+	struct commit_list *stack = NULL;
+
+	if (!base || !tips || !tips->nr)
+		return;
+
+	/*
+	 * Do a depth-first search starting at 'base' to search for the
+	 * tips. Stop at the lowest (un-found) generation number. When
+	 * finding the lowest commit, increase the minimum generation
+	 * number to the next lowest (un-found) generation number.
+	 */
+
+	CALLOC_ARRAY(commits, tips->nr);
+
+	for (i = 0; i < tips->nr; i++) {
+		commits[i].commit = lookup_commit_reference_by_name(tips->items[i].string);
+		commits[i].index = i;
+		commits[i].generation = commit_graph_generation(commits[i].commit);
+	}
+
+	/* Sort with generation number ascending. */
+	QSORT(commits, tips->nr, compare_commit_and_index_by_generation);
+	min_generation = commits[0].generation;
+
+	parse_commit(base);
+	commit_list_insert(base, &stack);
+
+	while (stack) {
+		unsigned int j;
+		int explored_all_parents = 1;
+		struct commit_list *p;
+		struct commit *c = stack->item;
+		timestamp_t c_gen = commit_graph_generation(c);
+
+		/* Does it match any of our bases? */
+		for (j = min_generation_index; j < tips->nr; j++) {
+			if (c_gen < commits[j].generation)
+				break;
+
+			if (commits[j].commit == c) {
+				tips->items[commits[j].index].util = (void *)(uintptr_t)1;
+
+				if (j == min_generation_index) {
+					unsigned int k = j + 1;
+					while (k < tips->nr &&
+					       tips->items[commits[k].index].util)
+						k++;
+
+					/* Terminate early if all found. */
+					if (k >= tips->nr)
+						goto done;
+
+					min_generation_index = k;
+					min_generation = commits[k].generation;
+				}
+			}
+		}
+
+		for (p = c->parents; p; p = p->next) {
+			parse_commit(p->item);
+
+			/* Have we already explored this parent? */
+			if (p->item->object.flags & SEEN)
+				continue;
+
+			/* Is it below the current minimum generation? */
+			if (commit_graph_generation(p->item) < min_generation)
+				continue;
+
+			/* Ok, we will explore from here on. */
+			p->item->object.flags |= SEEN;
+			explored_all_parents = 0;
+			commit_list_insert(p->item, &stack);
+			break;
+		}
+
+		if (explored_all_parents)
+			pop_commit(&stack);
+	}
+
+done:
+	free(commits);
+	repo_clear_commit_marks(the_repository, SEEN);
+}
diff --git a/commit-reach.h b/commit-reach.h
index 1780f9317bf..fa8994f5696 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -134,4 +134,11 @@ struct ahead_behind_count {
 void ahead_behind(struct commit **commits, size_t commits_nr,
 		  struct ahead_behind_count *counts, size_t counts_nr);
 
+/*
+ * Populate the "util" of each string_list item with the boolean value
+ * corresponding to "can 'base' reach this tip?"
+ */
+void tips_reachable_from_base(struct commit *base,
+			      struct string_list *tips);
+
 #endif
diff --git a/t/perf/p1500-graph-walks.sh b/t/perf/p1500-graph-walks.sh
index c9ac4b7e6e2..56de6c5b13d 100755
--- a/t/perf/p1500-graph-walks.sh
+++ b/t/perf/p1500-graph-walks.sh
@@ -22,4 +22,8 @@ test_perf 'ahead-behind counts: git rev-list' '
 	done
 '
 
+test_perf 'ahead-behind counts: git ahead-behind --contains' '
+	git ahead-behind --contains --base=HEAD --stdin <refs
+'
+
 test_done
diff --git a/t/t4218-ahead-behind.sh b/t/t4218-ahead-behind.sh
index 6658c919fdf..c333cb623f8 100755
--- a/t/t4218-ahead-behind.sh
+++ b/t/t4218-ahead-behind.sh
@@ -40,6 +40,19 @@ test_expect_success 'git ahead-behind with broken tip and --ignore-missing' '
 	test_must_be_empty out
 '
 
+test_expect_success 'git ahead-behind --contains with broken tip' '
+	test_must_fail git ahead-behind --contains \
+		--base=HEAD bogus 2>err &&
+	grep "could not resolve '\''bogus'\''" err
+'
+
+test_expect_success 'git ahead-behind --contains with broken tip and --ignore-missing' '
+	git ahead-behind --base=HEAD --contains \
+		--ignore-missing bogus 2>err >out &&
+	test_must_be_empty err &&
+	test_must_be_empty out
+'
+
 test_expect_success 'git ahead-behind without tips' '
 	git ahead-behind --base=HEAD 2>err &&
 	test_must_be_empty err
@@ -97,4 +110,53 @@ test_expect_success 'git ahead-behind --base=merge' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git ahead-behind --contains --base=base' '
+	git ahead-behind --contains --base=base \
+		base left right merge >actual &&
+
+	cat >expect <<-EOF &&
+	base
+	EOF
+
+	test_cmp expect actual
+'
+
+test_expect_success 'git ahead-behind --contains --base=left' '
+	git ahead-behind --contains --base=left \
+		base left right merge >actual &&
+
+	cat >expect <<-EOF &&
+	base
+	left
+	EOF
+
+	test_cmp expect actual
+'
+
+test_expect_success 'git ahead-behind --contains --base=right' '
+	git ahead-behind --contains --base=right \
+		base left right merge >actual &&
+
+	cat >expect <<-EOF &&
+	base
+	right
+	EOF
+
+	test_cmp expect actual
+'
+
+test_expect_success 'git ahead-behind --contains --base=merge' '
+	git ahead-behind --contains --base=merge \
+		base left right merge >actual &&
+
+	cat >expect <<-EOF &&
+	base
+	left
+	right
+	merge
+	EOF
+
+	test_cmp expect actual
+'
+
 test_done
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index 951e07100f6..2fdad7b3619 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -505,4 +505,62 @@ test_expect_success 'ahead-behind:none' '
 	run_all_modes git ahead-behind --base=commit-8-4 --stdin
 '
 
+test_expect_success 'ahead-behind--contains:all' '
+	cat >input <<-\EOF &&
+	commit-1-1
+	commit-2-4
+	commit-4-2
+	commit-4-4
+	EOF
+	cat >expect <<-\EOF &&
+	commit-1-1
+	commit-2-4
+	commit-4-2
+	commit-4-4
+	EOF
+	run_all_modes git ahead-behind --contains --base=commit-5-5 \
+		--stdin --use-bitmap-index
+'
+
+test_expect_success 'ahead-behind--contains:some' '
+	cat >input <<-\EOF &&
+	commit-1-1
+	commit-5-3
+	commit-4-8
+	commit-9-9
+	EOF
+	cat >expect <<-\EOF &&
+	commit-1-1
+	commit-5-3
+	EOF
+	run_all_modes git ahead-behind --contains --base=commit-9-6 \
+		--stdin --use-bitmap-index
+'
+
+test_expect_success 'ahead-behind--contains:some, reordered' '
+	cat >input <<-\EOF &&
+	commit-4-8
+	commit-5-3
+	commit-9-9
+	commit-1-1
+	EOF
+	cat >expect <<-\EOF &&
+	commit-5-3
+	commit-1-1
+	EOF
+	run_all_modes git ahead-behind --contains --base=commit-9-6 \
+		--stdin --use-bitmap-index
+'
+
+test_expect_success 'ahead-behind--contains:none' '
+	cat >input <<-\EOF &&
+	commit-7-5
+	commit-4-8
+	commit-9-9
+	EOF
+	>expect &&
+	run_all_modes git ahead-behind --contains --base=commit-8-4 \
+		--stdin --use-bitmap-index
+'
+
 test_done
-- 
gitgitgadget
