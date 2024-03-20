Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA7086266
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 22:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710972334; cv=none; b=gIRqh1lOlI5pRT9CA3c8x1HVb5hFCz4BiICnxYGMgsRKjJM8SdHxBtrs47lfORJC8kcgOaX6uacXQwrlCZnF5KgXhJ3f/Gn2+OAuxfBp+5zVfUYo8lpYBI/+lPCrj9JmtOLdEJRMuBsCBWQm32qkqxP5Z8fPEDP6vqcuKKXiLtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710972334; c=relaxed/simple;
	bh=PkULP0RSgQ/PCHN/FzJApfm0DD1IDBfwRvI5xy+g7aI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6+vfRVinFOyXUZMBANKtaj/UzgG3TTvOcQEfKMVNf18v4/BU/7ek6EB5MDZqND50tRgmP2fSueO2RoVd4WiL8bopJ/jU6qFuYjnKWUOHGlpRN0c6RbHwRxJF+2nz/aO7/2WkzRqq+G8qvegUgyEfqqHqpkBFq7fKOhVNQraKQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=1xy/7tq2; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="1xy/7tq2"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-781753f52afso20974885a.2
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 15:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1710972330; x=1711577130; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FzrbCnjda0Uut9anKOhdohLmc7ZhdDsFnjj38jOu35k=;
        b=1xy/7tq2siwwbw7ebkHAb6ziSB8/FLwD6jX3E8EirHsJnHlULVyfq+81JOa1UBKyuq
         DPwmWV5iB8yTuWGmTJlR7kXBCM5hgjXtIF9K0n4+GLLyyXdUOCLaLkOJSp0nvpMZWElq
         mK1HpdOJGv8lPCKsAtSs8VMkqgwcaoFvTFIZd5JDLwmFAokf7C4pB7VF1LDlcqFfHxkj
         kafI99lb0C0cz6Tpt6UV23HzWn6k56MQZmBhuOFmfzgTeHRbjEqk2VgnRGUz8UzG+OnT
         6keWhnhccT4M42cYOOVvLurKDc9GD0RKVC3wRWLijUeNW6wsGgrN9m49GHHtJAonv6Ca
         LS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710972330; x=1711577130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FzrbCnjda0Uut9anKOhdohLmc7ZhdDsFnjj38jOu35k=;
        b=P8LdMDh41PyDzKtLmOqdx+vDf4WDMmLYlXHc/bEQP2p1Ivi8mLbhLxwQi+IEGOyWtp
         L6tP663dqKiDbf40cvFOXOWYmwohcHQsNSjGo+KUMs+zywBk7JIT6xefCc20YKMr9pzp
         XngqLGP65NeiT8OouV3rZmNEDavK+x1H/xJZs69UXq7MpItnjW12RS5nZUPS8sq7KYrR
         LE6SfxMRlOaWfRMHChEQx+rPRJPfZL7A35rU0uUvDzMd/ptjWoSO3lDBF+p6obEwbR1T
         RKu2nkno7uQYF9VcDkxB7UEaQ8rccw/y8EFjzHJgUnHzBNI+QHF6aMIm755LV93XX6CU
         jx8A==
X-Gm-Message-State: AOJu0YyYcyjj8G5HMjGCP6BTrLeZpIxiQA4Pt3Ixn3X2pEygye/MKlJY
	Pzn6f/LQKVlwOs7uaEUWxf+nLkwSuzRY18P9nAP5uvCeWjLhpHwZ2KsNJTmyNEtBgLK3NvpUrQQ
	04HI=
X-Google-Smtp-Source: AGHT+IEYf7Tlw66j+KaNgmj+MZSuW2MNUbk5ODCZJazabOjy/eWuvXPuKPV/UfJFahYiANFuRySABw==
X-Received: by 2002:a05:620a:4951:b0:78a:1e39:2674 with SMTP id vz17-20020a05620a495100b0078a1e392674mr3471384qkn.39.1710972330491;
        Wed, 20 Mar 2024 15:05:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i7-20020a05620a144700b00789e49808ffsm5665876qkl.105.2024.03.20.15.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 15:05:30 -0700 (PDT)
Date: Wed, 20 Mar 2024 18:05:29 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 10/24] pseudo-merge: implement support for selecting
 pseudo-merge commits
Message-ID: <323e1250b247f44212879c37092e1c4cbdc0b310.1710972293.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1710972293.git.me@ttaylorr.com>

Teach the new pseudo-merge machinery how to select non-bitmapped commits
for inclusion in different pseudo-merge group(s) based on a handful of
criteria.

Pseudo-merges are derived first from named pseudo-merge groups (see the
`bitmapPseudoMerge.<name>.*` configuration options). They are
(optionally) further segmented within an individual pseudo-merge group
based on any capture group(s) within the pseudo-merge group's pattern.

For example, a configuration like so:

    [bitmapPseudoMerge "all"]
        pattern = "refs/"
        threshold = now
        stableThreshold = never
        sampleRate = 100
        maxMerges = 64

would group all non-bitmapped commits into up to 64 individual
pseudo-merge commits.

If you wanted to separate tags from branches when generating
pseudo-merge commits, and further segment them by which fork they
originate from (using the same "refs/virtual/" scheme as in the delta
islands documentation), you would instead write something like:

    [bitmapPseudoMerge "all"]
        pattern = "refs/virtual/([0-9]+)/(heads|tags)/"
        threshold = now
        stableThreshold = never
        sampleRate = 100
        maxMerges = 64

Which would generate pseudo-merge group identifiers like "1234-heads",
and "5678-tags" (for branches in fork "1234", and tags in remote "5678",
respectively).

Within pseudo-merge groups, there are a handful of other options used to
control the distribution of matching commits among individual
pseudo-merge commits:

  - bitmapPseudoMerge.<name>.decay
  - bitmapPseudoMerge.<name>.sampleRate
  - bitmapPseudoMerge.<name>.threshold
  - bitmapPseudoMerge.<name>.maxMerges
  - bitmapPseudoMerge.<name>.stableThreshold
  - bitmapPseudoMerge.<name>.stableSize

The decay parameter roughly corresponds to "k" in `f(n) = C*n^(-k/100)`,
where `f(n)` describes the size of the `n`-th pseudo-merge group. The
sample rate controls what percentage of eligible commits are considered
as candidates. The threshold parameter indicates the minimum age (so as
to avoid including too-recent commits in a pseudo-merge group, making it
less likely to be valid). The "maxMerges" parameter sets an upper-bound
on the number of pseudo-merge commits an individual group

The latter two "stable"-related parameters control "stable" pseudo-merge
groups, comprised of a fixed number of commits which are older than the
configured "stable threshold" value and may be grouped together in
chunks of "stableSize" in order of age.

This patch implements the aforementioned selection routine, as well as
parsing the relevant configuration options.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pseudo-merge.c | 441 +++++++++++++++++++++++++++++++++++++++++++++++++
 pseudo-merge.h |  96 +++++++++++
 2 files changed, 537 insertions(+)

diff --git a/pseudo-merge.c b/pseudo-merge.c
index 37e037ba272..caccef942a1 100644
--- a/pseudo-merge.c
+++ b/pseudo-merge.c
@@ -1,2 +1,443 @@
 #include "git-compat-util.h"
 #include "pseudo-merge.h"
+#include "date.h"
+#include "oid-array.h"
+#include "strbuf.h"
+#include "config.h"
+#include "string-list.h"
+#include "refs.h"
+#include "pack-bitmap.h"
+#include "commit.h"
+#include "alloc.h"
+#include "progress.h"
+
+#define DEFAULT_PSEUDO_MERGE_DECAY 1.0f
+#define DEFAULT_PSEUDO_MERGE_MAX_MERGES 64
+#define DEFAULT_PSEUDO_MERGE_SAMPLE_RATE 100
+#define DEFAULT_PSEUDO_MERGE_THRESHOLD approxidate("1.week.ago")
+#define DEFAULT_PSEUDO_MERGE_STABLE_THRESHOLD approxidate("1.month.ago")
+#define DEFAULT_PSEUDO_MERGE_STABLE_SIZE 512
+
+static float gitexp(float base, int exp)
+{
+	float result = 1;
+	while (1) {
+		if (exp % 2)
+			result *= base;
+		exp >>= 1;
+		if (!exp)
+			break;
+		base *= base;
+	}
+	return result;
+}
+
+static uint32_t pseudo_merge_group_size(const struct pseudo_merge_group *group,
+					const struct pseudo_merge_matches *matches,
+					uint32_t i)
+{
+	float C = 0.0f;
+	uint32_t n;
+
+	/*
+	 * The size of pseudo-merge groups decays according to a power series,
+	 * which looks like:
+	 *
+	 *   f(n) = C * n^-k
+	 *
+	 * , where 'n' is the n-th pseudo-merge group, 'f(n)' is its size, 'k'
+	 * is the decay rate, and 'C' is a scaling value.
+	 *
+	 * The value of C depends on the number of groups, decay rate, and total
+	 * number of commits. It is computed such that if there are M and N
+	 * total groups and commits, respectively, that:
+	 *
+	 *   N = f(0) + f(1) + ... f(M-1)
+	 *
+	 * Rearranging to isolate C, we get:
+	 *
+	 *   N = \sum_{n=1}^M C / n^k
+	 *
+	 *   N / C = \sum_{n=1}^M n^-k
+	 *
+	 *   C = N / \sum_{n=1}^M n^-k
+	 *
+	 * For example, if we have a decay rate of 'k' being equal to 1.5, 'N'
+	 * total commits equal to 10,000, and 'M' being equal to 6 groups, then
+	 * the (rounded) group sizes are:
+	 *
+	 *   { 5469, 1934, 1053, 684, 489, 372 }
+	 *
+	 * increasing the number of total groups, say to 10, scales the group
+	 * sizes appropriately:
+	 *
+	 *   { 5012, 1772, 964, 626, 448, 341, 271, 221, 186, 158 }
+	 */
+	for (n = 0; n < group->max_merges; n++)
+		C += 1.0f / gitexp(n + 1, group->decay);
+	C = matches->unstable_nr / C;
+
+	return (int)((C / gitexp(i + 1, group->decay)) + 0.5);
+}
+
+static void init_pseudo_merge_group(struct pseudo_merge_group *group)
+{
+	memset(group, 0, sizeof(struct pseudo_merge_group));
+
+	strmap_init_with_options(&group->matches, NULL, 0);
+
+	group->decay = DEFAULT_PSEUDO_MERGE_DECAY;
+	group->max_merges = DEFAULT_PSEUDO_MERGE_MAX_MERGES;
+	group->sample_rate = DEFAULT_PSEUDO_MERGE_SAMPLE_RATE;
+	group->threshold = DEFAULT_PSEUDO_MERGE_THRESHOLD;
+	group->stable_threshold = DEFAULT_PSEUDO_MERGE_STABLE_THRESHOLD;
+	group->stable_size = DEFAULT_PSEUDO_MERGE_STABLE_SIZE;
+}
+
+static int pseudo_merge_config(const char *var, const char *value,
+			       const struct config_context *ctx,
+			       void *cb_data)
+{
+	struct string_list *list = cb_data;
+	struct string_list_item *item;
+	struct pseudo_merge_group *group;
+	struct strbuf buf = STRBUF_INIT;
+	const char *sub, *key;
+	size_t sub_len;
+
+	if (parse_config_key(var, "bitmappseudomerge", &sub, &sub_len, &key))
+		return 0;
+
+	if (!sub_len)
+		return 0;
+
+	strbuf_add(&buf, sub, sub_len);
+
+	item = string_list_lookup(list, buf.buf);
+	if (!item) {
+		item = string_list_insert(list, buf.buf);
+
+		item->util = xmalloc(sizeof(struct pseudo_merge_group));
+		init_pseudo_merge_group(item->util);
+	}
+
+	group = item->util;
+
+	if (!strcmp(key, "pattern")) {
+		struct strbuf re = STRBUF_INIT;
+
+		free(group->pattern);
+		if (*value != '^')
+			strbuf_addch(&re, '^');
+		strbuf_addstr(&re, value);
+
+		group->pattern = xcalloc(1, sizeof(regex_t));
+		if (regcomp(group->pattern, re.buf, REG_EXTENDED))
+			die(_("failed to load pseudo-merge regex for %s: '%s'"),
+			    sub, re.buf);
+
+		strbuf_release(&re);
+	} else if (!strcmp(key, "decay")) {
+		group->decay = git_config_int(var, value, ctx->kvi);
+		if (group->decay < 0) {
+			warning(_("%s must be non-negative, using default"), var);
+			group->decay = DEFAULT_PSEUDO_MERGE_DECAY;
+		}
+	} else if (!strcmp(key, "samplerate")) {
+		group->sample_rate = git_config_int(var, value, ctx->kvi);
+		if (!(0 <= group->sample_rate && group->sample_rate <= 100)) {
+			warning(_("%s must be between 0 and 100, using default"), var);
+			group->sample_rate = DEFAULT_PSEUDO_MERGE_SAMPLE_RATE;
+		}
+	} else if (!strcmp(key, "threshold")) {
+		if (git_config_expiry_date(&group->threshold, var, value)) {
+			strbuf_release(&buf);
+			return -1;
+		}
+	} else if (!strcmp(key, "maxmerges")) {
+		group->max_merges = git_config_int(var, value, ctx->kvi);
+		if (group->max_merges < 0) {
+			warning(_("%s must be non-negative, using default"), var);
+			group->max_merges = DEFAULT_PSEUDO_MERGE_MAX_MERGES;
+		}
+	} else if (!strcmp(key, "stablethreshold")) {
+		if (git_config_expiry_date(&group->stable_threshold, var, value)) {
+			strbuf_release(&buf);
+			return -1;
+		}
+	} else if (!strcmp(key, "stablesize")) {
+		group->stable_size = git_config_int(var, value, ctx->kvi);
+		if (group->stable_size <= 0) {
+			warning(_("%s must be positive, using default"), var);
+			group->stable_size = DEFAULT_PSEUDO_MERGE_STABLE_SIZE;
+		}
+	}
+
+	strbuf_release(&buf);
+
+	return 0;
+}
+
+void load_pseudo_merges_from_config(struct string_list *list)
+{
+	struct string_list_item *item;
+
+	git_config(pseudo_merge_config, list);
+
+	for_each_string_list_item(item, list) {
+		struct pseudo_merge_group *group = item->util;
+		if (!group->pattern)
+			die(_("pseudo-merge group '%s' missing required pattern"),
+			    item->string);
+		if (group->threshold < group->stable_threshold)
+			die(_("pseudo-merge group '%s' has unstable threshold "
+			      "before stable one"), item->string);
+	}
+}
+
+static int find_pseudo_merge_group_for_ref(const char *refname,
+					   const struct object_id *oid,
+					   int flags UNUSED,
+					   void *_data)
+{
+	struct string_list *list = _data;
+	struct object_id peeled;
+	struct commit *c;
+	uint32_t i;
+	int has_bitmap;
+
+	if (!peel_iterated_oid(oid, &peeled))
+		oid = &peeled;
+
+	c = lookup_commit(the_repository, oid);
+	if (!c)
+		return 0;
+
+	has_bitmap = bitmap_writer_has_bitmapped_object_id(oid);
+
+	for (i = 0; i < list->nr; i++) {
+		struct pseudo_merge_group *group;
+		struct pseudo_merge_matches *matches;
+		struct strbuf group_name = STRBUF_INIT;
+		regmatch_t captures[16];
+		size_t j;
+
+		group = list->items[i].util;
+		if (regexec(group->pattern, refname, ARRAY_SIZE(captures),
+			    captures, 0))
+			continue;
+
+		if (captures[ARRAY_SIZE(captures) - 1].rm_so != -1)
+			warning(_("pseudo-merge regex from config has too many capture "
+				  "groups (max=%"PRIuMAX")"),
+				(uintmax_t)ARRAY_SIZE(captures) - 2);
+
+		for (j = !!group->pattern->re_nsub; j < ARRAY_SIZE(captures); j++) {
+			regmatch_t *match = &captures[j];
+			if (match->rm_so == -1)
+				continue;
+
+			if (group_name.len)
+				strbuf_addch(&group_name, '-');
+
+			strbuf_add(&group_name, refname + match->rm_so,
+				   match->rm_eo - match->rm_so);
+		}
+
+		matches = strmap_get(&group->matches, group_name.buf);
+		if (!matches) {
+			matches = xcalloc(1, sizeof(*matches));
+			strmap_put(&group->matches, strbuf_detach(&group_name, NULL),
+				   matches);
+		}
+
+		if (c->date <= group->stable_threshold) {
+			ALLOC_GROW(matches->stable, matches->stable_nr + 1,
+				   matches->stable_alloc);
+			matches->stable[matches->stable_nr++] = c;
+		} else if (c->date <= group->threshold && !has_bitmap) {
+			ALLOC_GROW(matches->unstable, matches->unstable_nr + 1,
+				   matches->unstable_alloc);
+			matches->unstable[matches->unstable_nr++] = c;
+		}
+
+		strbuf_release(&group_name);
+	}
+
+	return 0;
+}
+
+static struct commit *push_pseudo_merge(struct pseudo_merge_group *group)
+{
+	struct commit *merge;
+
+	ALLOC_GROW(group->merges, group->merges_nr + 1, group->merges_alloc);
+
+	merge = alloc_commit_node(the_repository);
+	merge->object.parsed = 1;
+	merge->object.flags |= BITMAP_PSEUDO_MERGE;
+
+	group->merges[group->merges_nr++] = merge;
+
+	return merge;
+}
+
+static struct pseudo_merge_commit_idx *pseudo_merge_idx(kh_oid_map_t *pseudo_merge_commits,
+							const struct object_id *oid)
+
+{
+	struct pseudo_merge_commit_idx *pmc;
+	khiter_t hash_pos;
+
+	hash_pos = kh_get_oid_map(pseudo_merge_commits, *oid);
+	if (hash_pos == kh_end(pseudo_merge_commits)) {
+		int hash_ret;
+		hash_pos = kh_put_oid_map(pseudo_merge_commits, *oid, &hash_ret);
+
+		CALLOC_ARRAY(pmc, 1);
+
+		kh_value(pseudo_merge_commits, hash_pos) = pmc;
+	} else {
+		pmc = kh_value(pseudo_merge_commits, hash_pos);
+	}
+
+	return pmc;
+}
+
+#define MIN_PSEUDO_MERGE_SIZE 8
+
+static void select_pseudo_merges_1(struct pseudo_merge_group *group,
+				   struct pseudo_merge_matches *matches,
+				   kh_oid_map_t *pseudo_merge_commits,
+				   uint32_t *pseudo_merges_nr)
+{
+	uint32_t i, j;
+	uint32_t stable_merges_nr;
+
+	if (!matches->stable_nr && !matches->unstable_nr)
+		return; /* all tips in this group already have bitmaps */
+
+	stable_merges_nr = matches->stable_nr / group->stable_size;
+	if (matches->stable_nr % group->stable_size)
+		stable_merges_nr++;
+
+	/* make stable_merges_nr pseudo merges for stable commits */
+	for (i = 0, j = 0; i < stable_merges_nr; i++) {
+		struct commit *merge;
+		struct commit_list **p;
+
+		merge = push_pseudo_merge(group);
+		p = &merge->parents;
+
+		do {
+			struct commit *c;
+			struct pseudo_merge_commit_idx *pmc;
+
+			if (j >= matches->stable_nr)
+				break;
+
+			c = matches->stable[j++];
+			pmc = pseudo_merge_idx(pseudo_merge_commits,
+					       &c->object.oid);
+
+			ALLOC_GROW(pmc->pseudo_merge, pmc->nr + 1, pmc->alloc);
+
+			pmc->pseudo_merge[pmc->nr++] = *pseudo_merges_nr;
+			p = commit_list_append(c, p);
+		} while (j % group->stable_size);
+
+		bitmap_writer_push_bitmapped_commit(merge, 1);
+		(*pseudo_merges_nr)++;
+	}
+
+	/* make up to group->max_merges pseudo merges for unstable commits */
+	for (i = 0, j = 0; i < group->max_merges; i++) {
+		struct commit *merge;
+		struct commit_list **p;
+		uint32_t size, end;
+
+		merge = push_pseudo_merge(group);
+		p = &merge->parents;
+
+		size = pseudo_merge_group_size(group, matches, i);
+		end = size < MIN_PSEUDO_MERGE_SIZE ? matches->unstable_nr : j + size;
+
+		for (; j < end && j < matches->unstable_nr; j++) {
+			struct commit *c = matches->unstable[j];
+			struct pseudo_merge_commit_idx *pmc;
+
+			if (j % (100 / group->sample_rate))
+				continue;
+
+			pmc = pseudo_merge_idx(pseudo_merge_commits,
+					       &c->object.oid);
+
+			ALLOC_GROW(pmc->pseudo_merge, pmc->nr + 1, pmc->alloc);
+
+			pmc->pseudo_merge[pmc->nr++] = *pseudo_merges_nr;
+			p = commit_list_append(c, p);
+		}
+
+		bitmap_writer_push_bitmapped_commit(merge, 1);
+		(*pseudo_merges_nr)++;
+		if (end >= matches->unstable_nr)
+			break;
+	}
+}
+
+static int commit_date_cmp(const void *va, const void *vb)
+{
+	timestamp_t a = (*(const struct commit **)va)->date;
+	timestamp_t b = (*(const struct commit **)vb)->date;
+
+	if (a < b)
+		return -1;
+	else if (a > b)
+		return 1;
+	return 0;
+}
+
+static void sort_pseudo_merge_matches(struct pseudo_merge_matches *matches)
+{
+	QSORT(matches->stable, matches->stable_nr, commit_date_cmp);
+	QSORT(matches->unstable, matches->unstable_nr, commit_date_cmp);
+}
+
+void select_pseudo_merges(struct string_list *list,
+			  struct commit **commits, size_t commits_nr,
+			  kh_oid_map_t *pseudo_merge_commits,
+			  uint32_t *pseudo_merges_nr,
+			  unsigned show_progress)
+{
+	struct progress *progress = NULL;
+	uint32_t i;
+
+	if (!list->nr)
+		return;
+
+	if (show_progress)
+		progress = start_progress("Selecting pseudo-merge commits", list->nr);
+
+	for_each_ref(find_pseudo_merge_group_for_ref, list);
+
+	for (i = 0; i < list->nr; i++) {
+		struct pseudo_merge_group *group;
+		struct hashmap_iter iter;
+		struct strmap_entry *e;
+
+		group = list->items[i].util;
+		strmap_for_each_entry(&group->matches, &iter, e) {
+			struct pseudo_merge_matches *matches = e->value;
+
+			sort_pseudo_merge_matches(matches);
+
+			select_pseudo_merges_1(group, matches,
+					       pseudo_merge_commits,
+					       pseudo_merges_nr);
+		}
+
+		display_progress(progress, i + 1);
+	}
+
+	stop_progress(&progress);
+}
diff --git a/pseudo-merge.h b/pseudo-merge.h
index cab8ff6960a..81888731864 100644
--- a/pseudo-merge.h
+++ b/pseudo-merge.h
@@ -2,5 +2,101 @@
 #define PSEUDO_MERGE_H
 
 #include "git-compat-util.h"
+#include "strmap.h"
+#include "khash.h"
+#include "ewah/ewok.h"
+
+struct commit;
+struct string_list;
+struct bitmap_index;
+
+/*
+ * A pseudo-merge group tracks the set of non-bitmapped reference tips
+ * that match the given pattern.
+ *
+ * Within those matches, they are further segmented by separating
+ * consecutive capture groups with '-' dash character capture groups
+ * with '-' dash characters.
+ *
+ * Those groups are then ordered by committer date and partitioned
+ * into individual pseudo-merge(s) according to the decay, max_merges,
+ * sample_rate, and threshold parameters.
+ */
+struct pseudo_merge_group {
+	regex_t *pattern;
+
+	/* capture group(s) -> struct pseudo_merge_matches */
+	struct strmap matches;
+
+	/*
+	 * The individual pseudo-merge(s) that are generated from the
+	 * above array of matches, partitioned according to the below
+	 * parameters.
+	 */
+	struct commit **merges;
+	size_t merges_nr;
+	size_t merges_alloc;
+
+	/*
+	 * Pseudo-merge grouping parameters. See git-config(1) for
+	 * more information.
+	 */
+	float decay;
+	int max_merges;
+	int sample_rate;
+	int stable_size;
+	timestamp_t threshold;
+	timestamp_t stable_threshold;
+};
+
+struct pseudo_merge_matches {
+	struct commit **stable;
+	struct commit **unstable;
+	size_t stable_nr, stable_alloc;
+	size_t unstable_nr, unstable_alloc;
+};
+
+/*
+ * Read the repository's configuration:
+ *
+ *   - bitmapPseudoMerge.<name>.pattern
+ *   - bitmapPseudoMerge.<name>.decay
+ *   - bitmapPseudoMerge.<name>.sampleRate
+ *   - bitmapPseudoMerge.<name>.threshold
+ *   - bitmapPseudoMerge.<name>.maxMerges
+ *   - bitmapPseudoMerge.<name>.stableThreshold
+ *   - bitmapPseudoMerge.<name>.stableSize
+ *
+ * and populates the given `list` with pseudo-merge groups. String
+ * entry keys are the pseudo-merge group names, and the values are
+ * pointers to the pseudo_merge_group structure itself.
+ */
+void load_pseudo_merges_from_config(struct string_list *list);
+
+/*
+ * A pseudo-merge commit index (pseudo_merge_commit_idx) maps a
+ * particular (non-pseudo-merge) commit to the list of pseudo-merge(s)
+ * it appears in.
+ */
+struct pseudo_merge_commit_idx {
+	uint32_t *pseudo_merge;
+	size_t nr, alloc;
+};
+
+/*
+ * Selects pseudo-merges from a list of commits, populating the given
+ * string_list of pseudo-merge groups.
+ *
+ * Populates the pseudo_merge_commits map with a commit_idx
+ * corresponding to each commit in the list. Counts the total number
+ * of pseudo-merges generated.
+ *
+ * Optionally shows a progress meter.
+ */
+void select_pseudo_merges(struct string_list *list,
+			  struct commit **commits, size_t commits_nr,
+			  kh_oid_map_t *pseudo_merge_commits,
+			  uint32_t *pseudo_merges_nr,
+			  unsigned show_progress);
 
 #endif
-- 
2.44.0.303.g1dc5e5b124c

