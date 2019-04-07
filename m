Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02C7220248
	for <e@80x24.org>; Sun,  7 Apr 2019 21:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfDGVrE (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Apr 2019 17:47:04 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34460 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfDGVrD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Apr 2019 17:47:03 -0400
Received: by mail-ed1-f65.google.com with SMTP id x14so9922274eds.1
        for <git@vger.kernel.org>; Sun, 07 Apr 2019 14:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZIlYWJglkDZHXH+X8VPNFj0jrIpuef6rr78ra6vHgIg=;
        b=DM3rkKmjFhoR/IQ7g27hNIjkeXZ4ZOe6jJHOouWuVsesvbOewYE0H3yOHRhIFgEL0v
         Vom8EDuUjbgGuvw9+Ur79NMu3OJcmfjRzssLHnRMtmZwekiLJu2FHJvDLlV0nnRSgUDD
         PcnQxxgZsYTrwn4EpK4aDnDToTVnFRF/Tj8/Evugc5XgvE2/sFsVtkdwpxZIfW5Hy8f3
         f9WTeCyn6d0FV8mTdYMqraT3ptCqVc8YrAbhqeOprQMCesHny9uIRL7yolJMaDEX8xjn
         ov5eUuQSsj/NPAYiwAp7861RSMakB1zGTVLw2j6rlqVpIeyro1APgvcrwQWZ1QjCQu6Y
         DyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ZIlYWJglkDZHXH+X8VPNFj0jrIpuef6rr78ra6vHgIg=;
        b=UTHoDWk5WTtHAB0AUQ6B1p1SG99lYvt8CIbU+gdhqzcyvMY1NJgiAqvejh+C7wGcIJ
         NMUWj+9TiMPso+0YgiKS8ih+NzUKaUplm+F5TBlGkcq+Ud7ffuUT3MF2UO91EBJZgbip
         aUE1vGokP/tNVXe0o3Xy0BJnUuRnNrSMSsGjo92Z7SeKA1vFuhZ5tV8wkIKsGNVGB0LI
         4OYk6+GLp+ssHNJWLhNvBIagsuscxTKPBCF43mLrlzKgmD5vp2gVnjDurMFBsjTAycZa
         MtIRS1mBD06lQsSsWM4+e7yFmNpGDtCYgo7FH0SJnbPQ6fpaCBncDoA3G88bo/XY0Qo6
         xBsQ==
X-Gm-Message-State: APjAAAVi6ZCcTwAWNHcaAja9N/h/382aoE98C62p0asf6vwhS44wUzsP
        tbPPGBYyrvqHt0r7Lz/U76/jpKl7xIaYIA==
X-Google-Smtp-Source: APXvYqwbZQO8zJzZtUffgORiNNaFfDxnbnhwdPDsdd5XHI9DPfIIo+7nGpu3cqEyZyQaHpneJdDUsQ==
X-Received: by 2002:a17:906:18a2:: with SMTP id c2mr5159566ejf.9.1554673620467;
        Sun, 07 Apr 2019 14:47:00 -0700 (PDT)
Received: from localhost.localdomain ([109.236.135.164])
        by smtp.gmail.com with ESMTPSA id e18sm5169001ejf.77.2019.04.07.14.46.58
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 07 Apr 2019 14:46:59 -0700 (PDT)
From:   michael@platin.gs
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Stefan Beller <stefanbeller@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Kastrup <dak@gnu.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Barret Rhoden <brho@google.com>,
        Michael Platings <michael@platin.gs>
Subject: RE: [PATCH v5 6/6] RFC blame: use a fingerprint heuristic to match ignored lines
Date:   Sun,  7 Apr 2019 23:46:35 +0200
Message-Id: <20190407214635.12984-1-michael@platin.gs>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <[PATCH v5 6/6] RFC blame: use a fingerprint heuristic to match ignored lines>
References: <[PATCH v5 6/6] RFC blame: use a fingerprint heuristic to match ignored lines>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Michael Platings <michael@platin.gs>

Hi Barret,
This is the updated fuzzy matching algorithm, sorry for the delay. It does
highlight a bug in the calculation for the number of lines ("int nr_parent_lines
 = e->num_lines - delta;") - if you apply the patch, build it, then try to
./git blame --ignore-rev <the patch commit ID> blame.c then you'll get a segfault
because nr_parent_lines is a negative number. I haven't had time to investigate further
but I have confirmed that the bug is not due to my patch.

The matching algorithm might not be obvious so it could do with more commenting.
In the mean time I hope the tests will make the intent clear. In particular I
want to avoid lines being reordered, because for the interesting use cases
usually sequences are unchanged even if they shift across different lines.

Regarding the existing implementation I've got to say I find it unhelpful
marking "unblameable" lines with a 000000 commit ID. That commit ID already has
a meaning - lines that aren't yet committed. Further, the purpose of ignoring
commits should be to avoid obscuring other useful information, not to absolutely
refuse to show that commit at all. If there's no other commit to show then it's
harmless to show the commit that would otherwise be ignored.

- How about matching *outside* the parent's diff hunk?
I'd like to know what the use case would be for that. For the use case of
looking "through" a reformatting or renaming commit I think it would be unhelpful.

- Fix up this commit + message.  I'd be up for splitting it more,
particularly if Michael wants his contributions/fingerprinting in his
own commit.
Thanks, maybe once we've got things into a robust state.

-Michael
---
 Makefile                           |   1 +
 blame.c                            |  16 +-
 fuzzy.c                            | 346 +++++++++++++++++++++++++++++
 fuzzy.h                            |  18 ++
 t/t8014-blame-ignore-revs-fuzzy.sh | 333 +++++++++++++++++++++++++++
 5 files changed, 712 insertions(+), 2 deletions(-)
 create mode 100644 fuzzy.c
 create mode 100644 fuzzy.h
 create mode 100755 t/t8014-blame-ignore-revs-fuzzy.sh

diff --git a/Makefile b/Makefile
index 3e03290d8f..4725060c54 100644
--- a/Makefile
+++ b/Makefile
@@ -893,6 +893,7 @@ LIB_OBJS += fetch-object.o
 LIB_OBJS += fetch-pack.o
 LIB_OBJS += fsck.o
 LIB_OBJS += fsmonitor.o
+LIB_OBJS += fuzzy.o
 LIB_OBJS += gettext.o
 LIB_OBJS += gpg-interface.o
 LIB_OBJS += graph.o
diff --git a/blame.c b/blame.c
index d20c13e6f8..0a7c231102 100644
--- a/blame.c
+++ b/blame.c
@@ -9,6 +9,7 @@
 #include "blame.h"
 #include "alloc.h"
 #include "commit-slab.h"
+#include "fuzzy.h"
 
 define_commit_slab(blame_suspects, struct blame_origin *);
 static struct blame_suspects blame_suspects;
@@ -928,15 +929,26 @@ static void guess_line_blames(struct blame_entry *e,
 {
 	int nr_parent_lines = e->num_lines - delta;
 
+	int *matching_lines = fuzzy_find_matching_lines(parent->file.ptr,
+							target->file.ptr,
+							parent->line_starts,
+							target->line_starts,
+							e->s_lno + offset,
+							e->s_lno,
+							nr_parent_lines,
+							e->num_lines);
+
 	for (int i = 0; i < e->num_lines; i++) {
-		if (i < nr_parent_lines) {
+		if (matching_lines[i] >= 0) {
 			line_blames[i].is_parent = 1;
-			line_blames[i].s_lno = e->s_lno + i + offset;
+			line_blames[i].s_lno = matching_lines[i];
 		} else {
 			line_blames[i].is_parent = 0;
 			line_blames[i].s_lno = e->s_lno + i;
 		}
 	}
+
+	free(matching_lines);
 }
 
 /*
diff --git a/fuzzy.c b/fuzzy.c
new file mode 100644
index 0000000000..b5ecb921b2
--- /dev/null
+++ b/fuzzy.c
@@ -0,0 +1,346 @@
+#include "fuzzy.h"
+#include <ctype.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+#include "git-compat-util.h"
+#include "hashmap.h"
+
+struct fingerprint {
+	struct hashmap map;
+	struct hashmap_entry *entries;
+};
+
+static void get_fingerprint(struct fingerprint *result,
+			    const char *line_begin,
+			    const char *line_end) {
+	unsigned hash;
+	char c0, c1;
+	int map_entry_count = line_end - line_begin - 1;
+	struct hashmap_entry *entry = malloc(map_entry_count *
+					     sizeof(struct hashmap_entry));
+	hashmap_init(&result->map, NULL, NULL, map_entry_count);
+	result->entries = entry;
+	for (const char *p = line_begin; p + 1 < line_end; ++p, ++entry) {
+		c0 = *p;
+		c1 = *(p + 1);
+		/* Ignore whitespace pairs */
+		if (isspace(c0) && isspace(c1))
+			continue;
+		hash = tolower(c0) | (tolower(c1) << 8);
+		hashmap_entry_init(entry, hash);
+		hashmap_put(&result->map, entry);
+	}
+}
+
+static void free_fingerprint(struct fingerprint *f) {
+	hashmap_free(&f->map, 0);
+	free(f->entries);
+}
+
+static int fingerprint_similarity(struct fingerprint *a,
+				  struct fingerprint *b) {
+	int intersection = 0;
+	struct hashmap_iter iter;
+	struct hashmap_entry *entry;
+	hashmap_iter_init(&b->map, &iter);
+
+	while ((entry = hashmap_iter_next(&iter))) {
+		if (hashmap_get(&a->map, entry, NULL)) {
+			++intersection;
+		}
+	}
+	return intersection;
+}
+
+static void get_line_fingerprints(struct fingerprint *fingerprints,
+				  const char *content,
+				  const int *line_starts,
+				  long chunk_start,
+				  long chunk_length) {
+	int i;
+	const char *linestart, *lineend;
+	line_starts += chunk_start;
+	for (i = 0; i != chunk_length; ++i) {
+		linestart = content + line_starts[i];
+		lineend = content + line_starts[i + 1];
+		get_fingerprint(fingerprints + i, linestart, lineend);
+	}
+}
+
+static int get_closest_line(int start_a,
+			    int chunk_line_b,
+			    int closest_line_calc_offset1,
+			    int closest_line_calc_offset2,
+			    int closest_line_calc_numerator,
+			    int closest_line_calc_denominator) {
+	return ((chunk_line_b + closest_line_calc_offset1) * 2 + 1) *
+		closest_line_calc_numerator /
+		(closest_line_calc_denominator * 2) +
+		closest_line_calc_offset2 - start_a;
+}
+
+#define CERTAIN_NOTHING_MATCHES -2
+#define CERTAINTY_NOT_CALCULATED -1
+
+static void find_best_line_matches(const int max_search_distance,
+				   int start_a,
+				   int length_a,
+				   int chunk_line_b,
+				   const int *similarities,
+				   int *certainties,
+				   int *second_best_result,
+				   int *result,
+				   int closest_line_calc_offset1,
+				   int closest_line_calc_offset2,
+				   int closest_line_calc_numerator,
+				   int closest_line_calc_denominator) {
+
+	int i, search_start, search_end, closest_line_a, similarity,
+		best_similarity = 0, second_best_similarity = 0,
+		best_similarity_index = 0, second_best_similarity_index = 0;
+
+	if (certainties[chunk_line_b] != CERTAINTY_NOT_CALCULATED)
+		return;
+
+	closest_line_a = get_closest_line(start_a,
+					  chunk_line_b,
+					  closest_line_calc_offset1,
+					  closest_line_calc_offset2,
+					  closest_line_calc_numerator,
+					  closest_line_calc_denominator);
+
+	search_start = closest_line_a - max_search_distance;
+	if (search_start < 0)
+		search_start = 0;
+
+	search_end = closest_line_a + max_search_distance + 1;
+	if (search_end > length_a)
+		search_end = length_a;
+
+	for (i = search_start; i < search_end; ++i) {
+		similarity = similarities[(i - closest_line_a) +
+			max_search_distance +
+			chunk_line_b * (max_search_distance * 2 + 1)];
+		if (similarity > best_similarity) {
+			second_best_similarity = best_similarity;
+			second_best_similarity_index = best_similarity_index;
+			best_similarity = similarity;
+			best_similarity_index = i;
+		}
+		else if (similarity > second_best_similarity) {
+			second_best_similarity = similarity;
+			second_best_similarity_index = i;
+		}
+	}
+
+	if (best_similarity == 0) {
+		certainties[chunk_line_b] = CERTAIN_NOTHING_MATCHES;
+		result[chunk_line_b] = -1;
+	}
+	else {
+		certainties[chunk_line_b] = best_similarity * 2 -
+			second_best_similarity;
+		result[chunk_line_b] = start_a + best_similarity_index;
+		second_best_result[chunk_line_b] =
+			start_a + second_best_similarity_index;
+	}
+}
+
+/*
+ * This finds the line that we can match with the most confidence, and
+ * uses it as a partition. It then calls itself on the lines on either side of
+ * that partition. In this way we avoid lines appearing out of order, and
+ * retain a sensible line ordering.
+ */
+static void fuzzy_find_matching_lines_recurse(
+	const int max_search_distance,
+	int start_a, int start_b,
+	int length_a, int length_b,
+	const int *similarities,
+	int *certainties,
+	int *second_best_result,
+	int *result,
+	int closest_line_calc_offset1,
+	int closest_line_calc_offset2,
+	int closest_line_calc_numerator,
+	int closest_line_calc_denominator) {
+
+	int i, barrier, invalidate_extent, offset_b,
+		second_half_start_a, second_half_start_b,
+		second_half_length_a, second_half_length_b,
+		most_certain_line = -1,
+		most_certain_line_certainty = -1;
+
+	for (i = 0; i < length_b; ++i) {
+		find_best_line_matches(max_search_distance,
+				       start_a,
+				       length_a,
+				       i,
+				       similarities,
+				       certainties,
+				       second_best_result,
+				       result,
+				       closest_line_calc_offset1,
+				       closest_line_calc_offset2,
+				       closest_line_calc_numerator,
+				       closest_line_calc_denominator);
+
+		if (certainties[i] > most_certain_line_certainty) {
+			most_certain_line_certainty = certainties[i];
+			most_certain_line = i;
+		}
+	}
+
+	if (most_certain_line == -1) {
+		return;
+	}
+
+	/* Invalidate results that may be affected by the choice of pivot. */
+	barrier = result[most_certain_line];
+	invalidate_extent = most_certain_line - max_search_distance;
+	if (invalidate_extent < 0)
+		invalidate_extent = 0;
+	for (i = most_certain_line - 1; i >= invalidate_extent; --i) {
+		if (certainties[i] >= 0 &&
+		    (result[i] > barrier || second_best_result[i] > barrier)) {
+			    certainties[i] = CERTAINTY_NOT_CALCULATED;
+			    barrier = result[i];
+			    invalidate_extent = i - max_search_distance;
+			    if (invalidate_extent < 0)
+				    invalidate_extent = 0;
+		    }
+	}
+
+	barrier = result[most_certain_line];
+	invalidate_extent = most_certain_line + max_search_distance + 1;
+	if (invalidate_extent > length_b)
+		invalidate_extent = length_b;
+	for (i = most_certain_line + 1; i < invalidate_extent; ++i) {
+		if (certainties[i] >= 0 &&
+		    (result[i] < barrier || second_best_result[i] < barrier)) {
+			    certainties[i] = CERTAINTY_NOT_CALCULATED;
+			    barrier = result[i];
+			    invalidate_extent = i + max_search_distance + 1;
+			    if (invalidate_extent > length_b)
+				    invalidate_extent = length_b;
+		    }
+	}
+
+	if (most_certain_line > 0) {
+		fuzzy_find_matching_lines_recurse(
+			max_search_distance,
+			start_a, start_b,
+			result[most_certain_line] + 1 - start_a,
+			most_certain_line, similarities,
+			certainties, second_best_result, result,
+			closest_line_calc_offset1, closest_line_calc_offset2,
+			closest_line_calc_numerator,
+			closest_line_calc_denominator);
+	}
+	if (most_certain_line + 1 < length_b) {
+		second_half_start_a = result[most_certain_line];
+		offset_b = most_certain_line + 1;
+		second_half_start_b = start_b + offset_b;
+		second_half_length_a =
+			length_a + start_a - second_half_start_a;
+		second_half_length_b =
+			length_b + start_b - second_half_start_b;
+		fuzzy_find_matching_lines_recurse(
+			max_search_distance,
+			second_half_start_a, second_half_start_b,
+			second_half_length_a, second_half_length_b,
+			similarities +
+				offset_b * (max_search_distance * 2 + 1),
+			certainties + offset_b,
+			second_best_result + offset_b, result + offset_b,
+			closest_line_calc_offset1 + offset_b,
+			closest_line_calc_offset2,
+			closest_line_calc_numerator,
+			closest_line_calc_denominator);
+	}
+}
+
+int *fuzzy_find_matching_lines(const char *content_a,
+			       const char *content_b,
+			       const int *line_starts_a,
+			       const int *line_starts_b,
+			       int start_a,
+			       int start_b,
+			       int length_a,
+			       int length_b) {
+
+	int i, j, closest_line_a, line_a, *result, *second_best_result,
+		*certainties, *similarities, *similarity;
+	struct fingerprint *fingerprints_a, fingerprint_b;
+
+	int max_search_distance = 10;
+	if (max_search_distance >= length_a)
+		max_search_distance = length_a - 1;
+
+	result = malloc(sizeof(int) * length_b);
+	second_best_result = malloc(sizeof(int) * length_b);
+	certainties = malloc(sizeof(int) * length_b);
+	similarities = malloc(sizeof(int) * length_b *
+			      (max_search_distance * 2 + 1));
+
+	for (i = 0; i < length_b; ++i) {
+		result[i] = -1;
+		second_best_result[i] = -1;
+		certainties[i] = CERTAINTY_NOT_CALCULATED;
+	}
+
+	fingerprints_a = malloc(sizeof(struct fingerprint) * length_a);
+
+	get_line_fingerprints(fingerprints_a, content_a,
+			      line_starts_a,
+			      start_a, length_a);
+
+	for (i = 0; i < length_b; ++i) {
+		get_fingerprint(&fingerprint_b,
+				content_b + line_starts_b[i + start_b],
+				content_b + line_starts_b[i + start_b + 1]);
+
+		closest_line_a = get_closest_line(start_a, i, 0, start_a,
+						  length_a, length_b);
+
+		for (j = -max_search_distance; j <= max_search_distance; ++j) {
+			similarity = similarities + j + max_search_distance +
+				i * (max_search_distance * 2 + 1);
+			line_a = closest_line_a + j;
+			if (line_a < 0 || line_a >= length_a) {
+				*similarity = -1;
+			}
+			else {
+				*similarity = fingerprint_similarity(
+					&fingerprint_b,
+					fingerprints_a + line_a) *
+					(1000 - abs(j));
+			}
+		}
+
+		free_fingerprint(&fingerprint_b);
+	}
+
+	for (i = 0; i < length_a; ++i) {
+		free_fingerprint(fingerprints_a + i);
+	}
+
+	free(fingerprints_a);
+
+	fuzzy_find_matching_lines_recurse(max_search_distance,
+					  start_a, start_b,
+					  length_a, length_b,
+					  similarities,
+					  certainties,
+					  second_best_result,
+					  result,
+					  0, start_a, length_a, length_b);
+
+	free(similarities);
+	free(certainties);
+	free(second_best_result);
+
+	return result;
+}
+
diff --git a/fuzzy.h b/fuzzy.h
new file mode 100644
index 0000000000..bd6d86ae45
--- /dev/null
+++ b/fuzzy.h
@@ -0,0 +1,18 @@
+#ifndef FUZZY_H
+#define FUZZY_H
+
+/*
+ * Find line numbers in "a" that match with lines in "b"
+ * Returns an array of either line indices or -1 where no match is found.
+ * The returned array must be free()d after use.
+ */
+int *fuzzy_find_matching_lines(const char *content_a,
+			       const char *content_b,
+			       const int *line_starts_a,
+			       const int *line_starts_b,
+			       int start_a,
+			       int start_b,
+			       int length_a,
+			       int length_b);
+
+#endif
diff --git a/t/t8014-blame-ignore-revs-fuzzy.sh b/t/t8014-blame-ignore-revs-fuzzy.sh
new file mode 100755
index 0000000000..1537a2b92c
--- /dev/null
+++ b/t/t8014-blame-ignore-revs-fuzzy.sh
@@ -0,0 +1,333 @@
+#!/bin/sh
+
+test_description='git blame ignore a specific revision'
+. ./test-lib.sh
+
+pick_author='s/^[0-9a-f^]* *(\([^ ]*\) .*/\1/'
+
+file_count=11
+
+# Each test is composed of 4 variables:
+# titleN - the test name
+# aN - the initial content
+# bN - the final content
+# expectedN - the line numbers from aN that we expect git blame
+#             on bN to identify, or "Final" if bN itself should
+#             be identified as the origin of that line.
+
+title1="Expand lines"
+cat <<EOF >a1
+aaa
+bbb
+ccc
+ddd
+eee
+EOF
+cat <<EOF >b1
+aaa
+bbbx
+bbbx
+ccc
+dddx
+dddx
+eee
+EOF
+cat <<EOF >expected1
+1
+2
+2
+3
+4
+4
+5
+EOF
+
+title2="Combine 3 lines into 2"
+cat <<EOF >a2
+if ((maxgrow==0) ||
+	( single_line_field && (field->dcols < maxgrow)) ||
+	(!single_line_field && (field->drows < maxgrow)))
+EOF
+cat <<EOF >b2
+if ((maxgrow == 0) || (single_line_field && (field->dcols < maxgrow)) ||
+	(!single_line_field && (field->drows < maxgrow))) {
+EOF
+cat <<EOF >expected2
+2
+3
+EOF
+
+title3="Add curly brackets"
+cat <<EOF >a3
+	if (rows) *rows = field->rows;
+	if (cols) *cols = field->cols;
+	if (frow) *frow = field->frow;
+	if (fcol) *fcol = field->fcol;
+EOF
+cat <<EOF >b3
+	if (rows) {
+		*rows = field->rows;
+	}
+	if (cols) {
+		*cols = field->cols;
+	}
+	if (frow) {
+		*frow = field->frow;
+	}
+	if (fcol) {
+		*fcol = field->fcol;
+	}
+EOF
+cat <<EOF >expected3
+1
+1
+Final
+2
+2
+Final
+3
+3
+Final
+4
+4
+Final
+EOF
+
+
+title4="Combine many lines and change case"
+cat <<EOF >a4
+for(row=0,pBuffer=field->buf;
+	row<height;
+	row++,pBuffer+=width )
+{
+	if ((len = (int)( After_End_Of_Data( pBuffer, width ) - pBuffer )) > 0)
+	{
+		wmove( win, row, 0 );
+		waddnstr( win, pBuffer, len );
+EOF
+cat <<EOF >b4
+for (Row = 0, PBuffer = field->buf; Row < Height; Row++, PBuffer += Width) {
+	if ((Len = (int)(afterEndOfData(PBuffer, Width) - PBuffer)) > 0) {
+		wmove(win, Row, 0);
+		waddnstr(win, PBuffer, Len);
+EOF
+cat <<EOF >expected4
+1
+5
+7
+8
+EOF
+
+title5="Rename and combine lines"
+cat <<EOF >a5
+bool need_visual_update = ((form != (FORM *)0)      &&
+	(form->status & _POSTED) &&
+	(form->current==field));
+
+if (need_visual_update)
+	Synchronize_Buffer(form);
+
+if (single_line_field)
+{
+	growth = field->cols * amount;
+	if (field->maxgrow)
+		growth = Minimum(field->maxgrow - field->dcols,growth);
+	field->dcols += growth;
+	if (field->dcols == field->maxgrow)
+EOF
+cat <<EOF >b5
+bool NeedVisualUpdate = ((Form != (FORM *)0) && (Form->status & _POSTED) &&
+	(Form->current == field));
+
+if (NeedVisualUpdate) {
+	synchronizeBuffer(Form);
+}
+
+if (SingleLineField) {
+	Growth = field->cols * amount;
+	if (field->maxgrow) {
+		Growth = Minimum(field->maxgrow - field->dcols, Growth);
+	}
+	field->dcols += Growth;
+	if (field->dcols == field->maxgrow) {
+EOF
+cat <<EOF >expected5
+1
+3
+4
+5
+6
+Final
+7
+8
+10
+11
+12
+Final
+13
+14
+EOF
+
+# Both lines match identically so position must be used to tie-break.
+title6="Same line twice"
+cat <<EOF >a6
+abc
+abc
+EOF
+cat <<EOF >b6
+abcd
+abcd
+EOF
+cat <<EOF >expected6
+1
+2
+EOF
+
+title7="Enforce line order"
+cat <<EOF >a7
+abcdef
+ghijkl
+ab
+EOF
+cat <<EOF >b7
+ghijk
+abcd
+EOF
+cat <<EOF >expected7
+2
+3
+EOF
+
+title8="Expand lines and rename variables"
+cat <<EOF >a8
+int myFunction(int ArgumentOne, Thing *ArgTwo, Blah XuglyBug) {
+	Squiggle FabulousResult = squargle(ArgumentOne, *ArgTwo,
+		XuglyBug) + EwwwGlobalWithAReallyLongNameYepTooLong;
+	return FabulousResult * 42;
+}
+EOF
+cat <<EOF >b8
+int myFunction(int argument_one, Thing *arg_asdfgh,
+	Blah xugly_bug) {
+	Squiggle fabulous_result = squargle(argument_one,
+		*arg_asdfgh, xugly_bug)
+		+ g_ewww_global_with_a_really_long_name_yep_too_long;
+	return fabulous_result * 42;
+}
+EOF
+cat <<EOF >expected8
+1
+1
+2
+3
+3
+4
+5
+EOF
+
+title9="Two close matches versus one less close match"
+cat <<EOF >a9
+abcdef
+abcdef
+ghijkl
+EOF
+cat <<EOF >b9
+gh
+abcdefx
+EOF
+cat <<EOF >expected9
+Final
+2
+EOF
+
+# The first line of b matches best with the last line of a, but the overall
+# match is better if we match it with the the first line of a.
+title10="Piggy in the middle"
+cat <<EOF >a10
+abcdefg
+ijklmn
+abcdefgh
+EOF
+cat <<EOF >b10
+abcdefghx
+ijklm
+EOF
+cat <<EOF >expected10
+1
+2
+EOF
+
+title11="No trailing newline"
+printf "abc\ndef" >a11
+printf "abx\nstu" >b11
+cat <<EOF >expected11
+1
+Final
+EOF
+
+test_expect_success setup '
+	{ for ((i=1;i<=$file_count;i++))
+	do
+		# Append each line in a separate commit to make it easy to
+		# check which original line the blame output relates to.
+
+		line_count=0 &&
+		{ while IFS= read line
+		do
+			line_count=$((line_count+1)) &&
+			echo "$line" >>"$i" &&
+			git add "$i" &&
+			test_tick &&
+			GIT_AUTHOR_NAME="$line_count" git commit -m "$line_count"
+		done } <"a$i"
+	done } &&
+
+	{ for ((i=1;i<=$file_count;i++))
+	do
+		# Overwrite the files with the final content.
+		cp b$i $i &&
+		git add $i
+	done } &&
+	test_tick &&
+
+	# Commit the final content all at once so it can all be
+	# referred to with the same commit ID.
+	GIT_AUTHOR_NAME=Final git commit -m Final &&
+
+	IGNOREME=$(git rev-parse HEAD)
+'
+
+for ((i=1;i<=$file_count;i++)); do
+	title="title$i"
+	test_expect_success "${!title}" \
+	"git blame --ignore-rev $IGNOREME $i | sed -e \"$pick_author\" >actual && test_cmp expected$i actual"
+done
+
+# This invoked a null pointer dereference when the chunk callback was called
+# with a zero length parent chunk and there were no more suspects.
+test_expect_success 'Diff chunks with no suspects' '
+	test_write_lines xy1 A B C xy1 >file &&
+	git add file &&
+	test_tick &&
+	GIT_AUTHOR_NAME=1 git commit -m 1 &&
+
+	test_write_lines xy2 A B xy2 C xy2 >file &&
+	git add file &&
+	test_tick &&
+	GIT_AUTHOR_NAME=2 git commit -m 2 &&
+	REV_2=$(git rev-parse HEAD) &&
+
+	test_write_lines xy3 A >file &&
+	git add file &&
+	test_tick &&
+	GIT_AUTHOR_NAME=3 git commit -m 3 &&
+	REV_3=$(git rev-parse HEAD) &&
+
+	test_write_lines 1 1 >expected &&
+
+	git blame --ignore-rev $REV_2 --ignore-rev $REV_3 file | sed -e "$pick_author" >actual &&
+
+	test_cmp expected actual
+	'
+
+test_done
-- 
2.21.0

