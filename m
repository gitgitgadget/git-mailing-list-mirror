Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D8514884B
	for <git@vger.kernel.org>; Tue, 21 May 2024 19:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716318158; cv=none; b=WLMIcHcFJ3ofhxqUPGWoYRXNyqN8QA6jpMYnqoBTb5c1UvVDEGA0f7M7zJhdoWLCsy/bBpQU0/boxz4cUsKcHunXq3RWYmC/4WjpEtZ8NOr6KKKdm+bOKg+i/kFRbbwwg3R7ZOgiWAlsl5zZt2D2Pxh7dRrsdjh7GG44QEFYNaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716318158; c=relaxed/simple;
	bh=vWk/sEfgQPIvzCfgQg2bp3QYsFa9ak1EB3QfHq9BDE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+RBiDk2KaUsKd8Y8NWTlRk22JJSjowNNHQOBHlJcK0UnzCb3PNRkRZU/oYuu3UVOHz4G/uELYz62gZ39SZ7i/GjkMHUTCgRJq1mkmHWfnlBLjdZ9KlsbLgbzCcLZvseljtEb/IkZCMYM0xQmKUelQzWLcxgEVec2zkTurJc3SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=PDBbxumt; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="PDBbxumt"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6a3652a732fso2612766d6.3
        for <git@vger.kernel.org>; Tue, 21 May 2024 12:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716318154; x=1716922954; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/EiGYhQfKLO+QHFrbYO3o52QrEoAbeU2UaKTxFFH/sU=;
        b=PDBbxumtuaNuM99zKMzoL23pl7b3o37W5CXbabylWHe+6nxYZY9CG6iY1NJF124WAb
         fcNU5xejJy8EAS3ZXTeecvhFfNAn71drNrsacYw4FTeWD1iIRQRX+7x+H9UdETis9/wx
         Rrva3hq1tFGxowf7vQZoHqkDh/hIJnkfGEydY6rGc8lylEq7p7ItI44yrfjxM/lUSnch
         vlm4QRrdy2LcLI3UoRvAne4dkD8cnOEPRX0RkmLKC8kxc5wDFaGNNPam6UsAKE8j5pHo
         qDlaPUbsmL1/KI7rresrNqpd23dCVCuXRsIq/LXoQka5UKYR3hvBUVmKQN1JW5Gd0nQo
         kohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716318154; x=1716922954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EiGYhQfKLO+QHFrbYO3o52QrEoAbeU2UaKTxFFH/sU=;
        b=oTKfws48l87pkNOrMEcPHsP9MEKj8tcETU4vuOAR0jEoWarRojUrkFBFmIJjJkoFJ1
         S5sztB/DMU+MF0XN7VP59LEMiR1ONG7c7AGXMS7i07VzaKO6XuRUXxBjL4TBPX8RRFiD
         gUHviv3ogY/5RZtvCtFD9l2i5Fjch3oQwcB8kYa09PaZ8EFthrbmHi8U8jITdoZ2Mha1
         FF836/OjEej5YkyJZapCKLOvmZPySMRUtiv90BPHYXK19MDHsOHjoGIT8ziav5CzNhdn
         CxYoNfU3U5z+76//9btqM0yJ90uH0wbhNoJhyWAZuiCRqK2pY6H0z5OGjiuA889Ig1Df
         W7oA==
X-Gm-Message-State: AOJu0Yyjj9HoOkOb2GwGF9zVZQJRa9nVjH/Y+DttR1gRaSaBMPMoX3fn
	hg/FxQ5vRt8fVaEw8WgnEDONVUF9e4EdlrvMufQJk8Ep+DZ0O3MCbm7BMy5tfJfQZkUzNJflGn1
	M
X-Google-Smtp-Source: AGHT+IEIQsQ6fGNfknHxj5FdW9sozQOjC38izDnJDeQgioRcPqba9gEzPJc8A/FdGSTbr2Mgd/SV5A==
X-Received: by 2002:a05:6214:3b87:b0:6a9:7a39:c115 with SMTP id 6a1803df08f44-6ab7067e981mr38100966d6.26.1716318153988;
        Tue, 21 May 2024 12:02:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f1d6f30sm125636386d6.110.2024.05.21.12.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 12:02:33 -0700 (PDT)
Date: Tue, 21 May 2024 15:02:32 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 17/30] pseudo-merge: implement support for selecting
 pseudo-merge commits
Message-ID: <3029473c094b3edf51828b7a1d1acfc8e959ece6.1716318089.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1716318088.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1716318088.git.me@ttaylorr.com>

Teach the new pseudo-merge machinery how to select non-bitmapped commits
for inclusion in different pseudo-merge group(s) based on a handful of
criteria.

Note that the selected pseudo-merge commits aren't actually used or
written anywhere yet. This will be done in the following commit.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config.txt                     |   2 +
 Documentation/config/bitmap-pseudo-merge.txt |  90 ++++
 Documentation/gitpacking.txt                 |  83 ++++
 pack-bitmap-write.c                          |  21 +
 pack-bitmap.h                                |   2 +
 pseudo-merge.c                               | 454 +++++++++++++++++++
 pseudo-merge.h                               |  94 ++++
 7 files changed, 746 insertions(+)
 create mode 100644 Documentation/config/bitmap-pseudo-merge.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6f649c997c0..caa34311214 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -384,6 +384,8 @@ include::config/apply.txt[]
 
 include::config/attr.txt[]
 
+include::config/bitmap-pseudo-merge.txt[]
+
 include::config/blame.txt[]
 
 include::config/branch.txt[]
diff --git a/Documentation/config/bitmap-pseudo-merge.txt b/Documentation/config/bitmap-pseudo-merge.txt
new file mode 100644
index 00000000000..d4a2023b84a
--- /dev/null
+++ b/Documentation/config/bitmap-pseudo-merge.txt
@@ -0,0 +1,90 @@
+NOTE: The configuration options in `bitmapPseudoMerge.*` are considered
+EXPERIMENTAL and may be subject to change or be removed entirely in the
+future.
+
+bitmapPseudoMerge.<name>.pattern::
+	Regular expression used to match reference names. Commits
+	pointed to by references matching this pattern (and meeting
+	the below criteria, like `bitmapPseudoMerge.<name>.sampleRate`
+	and `bitmapPseudoMerge.<name>.threshold`) will be considered
+	for inclusion in a pseudo-merge bitmap.
++
+Commits are grouped into pseudo-merge groups based on whether or not
+any reference(s) that point at a given commit match the pattern, which
+is an extended regular expression.
++
+Within a pseudo-merge group, commits may be further grouped into
+sub-groups based on the capture groups in the pattern. These
+sub-groupings are formed from the regular expressions by concatenating
+any capture groups from the regular expression, with a '-' dash in
+between.
++
+For example, if the pattern is `refs/tags/`, then all tags (provided
+they meet the below criteria) will be considered candidates for the
+same pseudo-merge group. However, if the pattern is instead
+`refs/remotes/([0-9])+/tags/`, then tags from different remotes will
+be grouped into separate pseudo-merge groups, based on the remote
+number.
+
+bitmapPseudoMerge.<name>.decay::
+	Determines the rate at which consecutive pseudo-merge bitmap
+	groups decrease in size. Must be non-negative. This parameter
+	can be thought of as `k` in the function `f(n) = C * n^-k`,
+	where `f(n)` is the size of the `n`th group.
++
+Setting the decay rate equal to `0` will cause all groups to be the
+same size. Setting the decay rate equal to `1` will cause the `n`th
+group to be `1/n` the size of the initial group.  Higher values of the
+decay rate cause consecutive groups to shrink at an increasing rate.
+The default is `1`.
++
+If all groups are the same size, it is possible that groups containing
+newer commits will be able to be used less often than earlier groups,
+since it is more likely that the references pointing at newer commits
+will be updated more often than a reference pointing at an old commit.
+
+bitmapPseudoMerge.<name>.sampleRate::
+	Determines the proportion of non-bitmapped commits (among
+	reference tips) which are selected for inclusion in an
+	unstable pseudo-merge bitmap. Must be between `0` and `1`
+	(inclusive). The default is `1`.
+
+bitmapPseudoMerge.<name>.threshold::
+	Determines the minimum age of non-bitmapped commits (among
+	reference tips, as above) which are candidates for inclusion
+	in an unstable pseudo-merge bitmap. The default is
+	`1.week.ago`.
+
+bitmapPseudoMerge.<name>.maxMerges::
+	Determines the maximum number of pseudo-merge commits among
+	which commits may be distributed.
++
+For pseudo-merge groups whose pattern does not contain any capture
+groups, this setting is applied for all commits matching the regular
+expression. For patterns that have one or more capture groups, this
+setting is applied for each distinct capture group.
++
+For example, if your capture group is `refs/tags/`, then this setting
+will distribute all tags into a maximum of `maxMerges` pseudo-merge
+commits. However, if your capture group is, say,
+`refs/remotes/([0-9]+)/tags/`, then this setting will be applied to
+each remote's set of tags individually.
++
+Must be non-negative. The default value is 64.
+
+bitmapPseudoMerge.<name>.stableThreshold::
+	Determines the minimum age of commits (among reference tips,
+	as above, however stable commits are still considered
+	candidates even when they have been covered by a bitmap) which
+	are candidates for a stable a pseudo-merge bitmap. The default
+	is `1.month.ago`.
++
+Setting this threshold to a smaller value (e.g., 1.week.ago) will cause
+more stable groups to be generated (which impose a one-time generation
+cost) but those groups will likely become stale over time. Using a
+larger value incurs the opposite penalty (fewer stable groups which are
+more useful).
+
+bitmapPseudoMerge.<name>.stableSize::
+	Determines the size (in number of commits) of a stable
+	psuedo-merge bitmap. The default is `512`.
diff --git a/Documentation/gitpacking.txt b/Documentation/gitpacking.txt
index ff18077129b..1ed645ff910 100644
--- a/Documentation/gitpacking.txt
+++ b/Documentation/gitpacking.txt
@@ -93,6 +93,89 @@ can take advantage of the fact that we only care about the union of
 objects reachable from all of those tags, and answer the query much
 faster.
 
+=== Configuration
+
+Reference tips are grouped into different pseudo-merge groups according
+to two criteria. A reference name matches one or more of the defined
+pseudo-merge patterns, and optionally one or more capture groups within
+that pattern which further partition the group.
+
+Within a group, commits may be considered "stable", or "unstable"
+depending on their age. These are adjusted by setting the
+`bitmapPseudoMerge.<name>.stableThreshold` and
+`bitmapPseudoMerge.<name>.threshold` configuration values, respectively.
+
+All stable commits are grouped into pseudo-merges of equal size
+(`bitmapPseudoMerge.<name>.stableSize`). If the `stableSize`
+configuration is set to, say, 100, then the first 100 commits (ordered
+by committer date) which are older than the `stableThreshold` value will
+form one group, the next 100 commits will form another group, and so on.
+
+Among unstable commits, the pseudo-merge machinery will attempt to
+combine older commits into large groups as opposed to newer commits
+which will appear in smaller groups. This is based on the heuristic that
+references whose tip commit is older are less likely to be modified to
+point at a different commit than a reference whose tip commit is newer.
+
+The size of groups is determined by a power-law decay function, and the
+decay parameter roughly corresponds to "k" in `f(n) = C*n^(-k/100)`,
+where `f(n)` describes the size of the `n`-th pseudo-merge group. The
+sample rate controls what percentage of eligible commits are considered
+as candidates. The threshold parameter indicates the minimum age (so as
+to avoid including too-recent commits in a pseudo-merge group, making it
+less likely to be valid). The "maxMerges" parameter sets an upper-bound
+on the number of pseudo-merge commits an individual group
+
+The "stable"-related parameters control "stable" pseudo-merge groups,
+comprised of a fixed number of commits which are older than the
+configured "stable threshold" value and may be grouped together in
+chunks of "stableSize" in order of age.
+
+The exact configuration for pseudo-merges is as follows:
+
+include::config/bitmap-pseudo-merge.txt[]
+
+=== Examples
+
+Suppose that you have a repository with a large number of references,
+and you want a bare-bones configuration of pseudo-merge bitmaps that
+will enhance bitmap coverage of the `refs/` namespace. You may start
+wiht a configuration like so:
+
+    [bitmapPseudoMerge "all"]
+	pattern = "refs/"
+	threshold = now
+	stableThreshold = never
+	sampleRate = 100
+	maxMerges = 64
+
+This will create pseudo-merge bitmaps for all references, regardless of
+their age, and group them into 64 pseudo-merge commits.
+
+If you wanted to separate tags from branches when generating
+pseudo-merge commits, you would instead define the pattern with a
+capture group, like so:
+
+    [bitmapPseudoMerge "all"]
+	pattern = "refs/(heads/tags)/"
+
+Suppose instead that you are working in a fork-network repository, with
+each fork specified by some numeric ID, and whose refs reside in
+`refs/virtual/NNN/` (where `NNN` is the numeric ID corresponding to some
+fork) in the network. In this instance, you may instead write something
+like:
+
+    [bitmapPseudoMerge "all"]
+	pattern = "refs/virtual/([0-9]+)/(heads|tags)/"
+	threshold = now
+	stableThreshold = never
+	sampleRate = 100
+	maxMerges = 64
+
+Which would generate pseudo-merge group identifiers like "1234-heads",
+and "5678-tags" (for branches in fork "1234", and tags in remote "5678",
+respectively).
+
 SEE ALSO
 --------
 linkgit:git-pack-objects[1]
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index bc19b33ad16..d5884ea5e9c 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -17,6 +17,7 @@
 #include "trace2.h"
 #include "tree.h"
 #include "tree-walk.h"
+#include "pseudo-merge.h"
 
 struct bitmapped_commit {
 	struct commit *commit;
@@ -39,11 +40,25 @@ void bitmap_writer_init(struct bitmap_writer *writer, struct repository *r)
 	if (writer->bitmaps)
 		BUG("bitmap writer already initialized");
 	writer->bitmaps = kh_init_oid_map();
+	writer->pseudo_merge_commits = kh_init_oid_map();
+
+	string_list_init_dup(&writer->pseudo_merge_groups);
+
+	load_pseudo_merges_from_config(&writer->pseudo_merge_groups);
+}
+
+static void free_pseudo_merge_commit_idx(struct pseudo_merge_commit_idx *idx)
+{
+	if (!idx)
+		return;
+	free(idx->pseudo_merge);
+	free(idx);
 }
 
 void bitmap_writer_free(struct bitmap_writer *writer)
 {
 	uint32_t i;
+	struct pseudo_merge_commit_idx *idx;
 
 	if (!writer)
 		return;
@@ -55,6 +70,10 @@ void bitmap_writer_free(struct bitmap_writer *writer)
 
 	kh_destroy_oid_map(writer->bitmaps);
 
+	kh_foreach_value(writer->pseudo_merge_commits, idx,
+			 free_pseudo_merge_commit_idx(idx));
+	kh_destroy_oid_map(writer->pseudo_merge_commits);
+
 	for (i = 0; i < writer->selected_nr; i++) {
 		struct bitmapped_commit *bc = &writer->selected[i];
 		if (bc->write_as != bc->bitmap)
@@ -703,6 +722,8 @@ void bitmap_writer_select_commits(struct bitmap_writer *writer,
 	}
 
 	stop_progress(&writer->progress);
+
+	select_pseudo_merges(writer, indexed_commits, indexed_commits_nr);
 }
 
 
diff --git a/pack-bitmap.h b/pack-bitmap.h
index a7e2f56c971..1e730ea1e54 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -110,6 +110,8 @@ struct bitmap_writer {
 	struct bitmapped_commit *selected;
 	unsigned int selected_nr, selected_alloc;
 
+	struct string_list pseudo_merge_groups;
+	kh_oid_map_t *pseudo_merge_commits; /* oid -> pseudo merge(s) */
 	uint32_t pseudo_merges_nr;
 
 	struct progress *progress;
diff --git a/pseudo-merge.c b/pseudo-merge.c
index 37e037ba272..4be730563eb 100644
--- a/pseudo-merge.c
+++ b/pseudo-merge.c
@@ -1,2 +1,456 @@
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
+#define DEFAULT_PSEUDO_MERGE_SAMPLE_RATE 1
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
+	return (uint32_t)((C / gitexp(i + 1, group->decay)) + 0.5);
+}
+
+static void pseudo_merge_group_init(struct pseudo_merge_group *group)
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
+	int ret = 0;
+
+	if (parse_config_key(var, "bitmappseudomerge", &sub, &sub_len, &key))
+		goto done;
+
+	if (!sub_len)
+		goto done;
+
+	strbuf_add(&buf, sub, sub_len);
+
+	item = string_list_lookup(list, buf.buf);
+	if (!item) {
+		item = string_list_insert(list, buf.buf);
+
+		item->util = xmalloc(sizeof(struct pseudo_merge_group));
+		pseudo_merge_group_init(item->util);
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
+		group->decay = git_config_float(var, value, ctx->kvi);
+		if (group->decay < 0) {
+			warning(_("%s must be non-negative, using default"), var);
+			group->decay = DEFAULT_PSEUDO_MERGE_DECAY;
+		}
+	} else if (!strcmp(key, "samplerate")) {
+		group->sample_rate = git_config_float(var, value, ctx->kvi);
+		if (!(0 <= group->sample_rate && group->sample_rate <= 1)) {
+			warning(_("%s must be between 0 and 1, using default"), var);
+			group->sample_rate = DEFAULT_PSEUDO_MERGE_SAMPLE_RATE;
+		}
+	} else if (!strcmp(key, "threshold")) {
+		if (git_config_expiry_date(&group->threshold, var, value)) {
+			ret = -1;
+			goto done;
+		}
+	} else if (!strcmp(key, "maxmerges")) {
+		group->max_merges = git_config_int(var, value, ctx->kvi);
+		if (group->max_merges < 0) {
+			warning(_("%s must be non-negative, using default"), var);
+			group->max_merges = DEFAULT_PSEUDO_MERGE_MAX_MERGES;
+		}
+	} else if (!strcmp(key, "stablethreshold")) {
+		if (git_config_expiry_date(&group->stable_threshold, var, value)) {
+			ret = -1;
+			goto done;
+		}
+	} else if (!strcmp(key, "stablesize")) {
+		group->stable_size = git_config_int(var, value, ctx->kvi);
+		if (group->stable_size <= 0) {
+			warning(_("%s must be positive, using default"), var);
+			group->stable_size = DEFAULT_PSEUDO_MERGE_STABLE_SIZE;
+		}
+	}
+
+done:
+	strbuf_release(&buf);
+
+	return ret;
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
+	struct bitmap_writer *writer = _data;
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
+	has_bitmap = bitmap_writer_has_bitmapped_object_id(writer, oid);
+
+	for (i = 0; i < writer->pseudo_merge_groups.nr; i++) {
+		struct pseudo_merge_group *group;
+		struct pseudo_merge_matches *matches;
+		struct strbuf group_name = STRBUF_INIT;
+		regmatch_t captures[16];
+		size_t j;
+
+		group = writer->pseudo_merge_groups.items[i].util;
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
+	int hash_ret;
+	khiter_t hash_pos = kh_put_oid_map(pseudo_merge_commits, *oid,
+					   &hash_ret);
+
+	if (hash_ret) {
+		CALLOC_ARRAY(pmc, 1);
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
+static void select_pseudo_merges_1(struct bitmap_writer *writer,
+				   struct pseudo_merge_group *group,
+				   struct pseudo_merge_matches *matches)
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
+		/*
+		 * For each pseudo-merge created above, add parents to the
+		 * allocated commit node from the stable set of commits
+		 * (un-bitmapped, newer than the stable threshold).
+		 */
+		do {
+			struct commit *c;
+			struct pseudo_merge_commit_idx *pmc;
+
+			if (j >= matches->stable_nr)
+				break;
+
+			c = matches->stable[j++];
+			/*
+			 * Here and below, make sure that we keep our mapping of
+			 * commits -> pseudo-merge(s) which include the key'd
+			 * commit up-to-date.
+			 */
+			pmc = pseudo_merge_idx(writer->pseudo_merge_commits,
+					       &c->object.oid);
+
+			ALLOC_GROW(pmc->pseudo_merge, pmc->nr + 1, pmc->alloc);
+
+			pmc->pseudo_merge[pmc->nr++] = writer->pseudo_merges_nr;
+			p = commit_list_append(c, p);
+		} while (j % group->stable_size);
+
+		bitmap_writer_push_commit(writer, merge, 1);
+		writer->pseudo_merges_nr++;
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
+		/*
+		 * For each pseudo-merge commit created above, add parents to
+		 * the allocated commit node from the unstable set of commits
+		 * (newer than the stable threshold).
+		 *
+		 * Account for the sample rate, since not every candidate from
+		 * the set of stable commits will be included as a pseudo-merge
+		 * parent.
+		 */
+		for (; j < end && j < matches->unstable_nr; j++) {
+			struct commit *c = matches->unstable[j];
+			struct pseudo_merge_commit_idx *pmc;
+
+			if (j % (uint32_t)(1.0f / group->sample_rate))
+				continue;
+
+			pmc = pseudo_merge_idx(writer->pseudo_merge_commits,
+					       &c->object.oid);
+
+			ALLOC_GROW(pmc->pseudo_merge, pmc->nr + 1, pmc->alloc);
+
+			pmc->pseudo_merge[pmc->nr++] = writer->pseudo_merges_nr;
+			p = commit_list_append(c, p);
+		}
+
+		bitmap_writer_push_commit(writer, merge, 1);
+		writer->pseudo_merges_nr++;
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
+void select_pseudo_merges(struct bitmap_writer *writer,
+			  struct commit **commits, size_t commits_nr)
+{
+	struct progress *progress = NULL;
+	uint32_t i;
+
+	if (!writer->pseudo_merge_groups.nr)
+		return;
+
+	if (writer->show_progress)
+		progress = start_progress("Selecting pseudo-merge commits",
+					  writer->pseudo_merge_groups.nr);
+
+	for_each_ref(find_pseudo_merge_group_for_ref, writer);
+
+	for (i = 0; i < writer->pseudo_merge_groups.nr; i++) {
+		struct pseudo_merge_group *group;
+		struct hashmap_iter iter;
+		struct strmap_entry *e;
+
+		group = writer->pseudo_merge_groups.items[i].util;
+		strmap_for_each_entry(&group->matches, &iter, e) {
+			struct pseudo_merge_matches *matches = e->value;
+
+			sort_pseudo_merge_matches(matches);
+
+			select_pseudo_merges_1(writer, group, matches);
+		}
+
+		display_progress(progress, i + 1);
+	}
+
+	stop_progress(&progress);
+}
diff --git a/pseudo-merge.h b/pseudo-merge.h
index cab8ff6960a..cab54daf14b 100644
--- a/pseudo-merge.h
+++ b/pseudo-merge.h
@@ -2,5 +2,99 @@
 #define PSEUDO_MERGE_H
 
 #include "git-compat-util.h"
+#include "strmap.h"
+#include "khash.h"
+#include "ewah/ewok.h"
+
+struct commit;
+struct string_list;
+struct bitmap_index;
+struct bitmap_writer;
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
+	float sample_rate;
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
+void select_pseudo_merges(struct bitmap_writer *writer,
+			  struct commit **commits, size_t commits_nr);
 
 #endif
-- 
2.45.1.175.gbea44add9db

