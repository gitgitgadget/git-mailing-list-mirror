Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B3C31F5CB
	for <e@80x24.org>; Mon, 22 Apr 2019 22:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729513AbfDVW2Y (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 18:28:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34466 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727336AbfDVW2Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 18:28:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id c6so11788435wrm.1
        for <git@vger.kernel.org>; Mon, 22 Apr 2019 15:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fttA/UQvsYuL48uT41o1tVb5ogFznvdEtmauEW2FT+4=;
        b=puC3rvY28rteasU/EchDV/ps7PMzdVQalryTi+QAV5xUGHWX+jPcRN85Wwv/gtD8L+
         GT/RPdRmgkZ98DXnlf685G6WQFfimsvT+wd9HNJQZWIq0fmU6pFZbQ2l29mJNzfavALN
         maDD6yz8jAwDrgvO0FKW6fbjh69MuVQgvbQXYxVtl74JGa7oa93rIFFup8JGBYX+VPhz
         qVxt4E50H7S10yGSwFTPZBBYxkWnlu2E//aLbNOkoIbg3GXdDMfH0EDM7IRYXCc7LL0v
         GBait6A4U5vBUsdV7InGya/UX5PLuGzIkRyEkVxPdGsWudr/Xfdmrrd7eQ/0XyAqwfma
         wsxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=fttA/UQvsYuL48uT41o1tVb5ogFznvdEtmauEW2FT+4=;
        b=bgT7W/5Ov9TNpqfjKxzYHRU4lzHHi1nppP0IGsPLzsgZmqMrsjutaspvWtaW+2WYTF
         Ufm1nislf1B8nQMW1F8i7+5TCB6NPW8az6Url5vEb+IPRelVSqb8zKA486KXpZnmsqNz
         3V/vgQh/pJ+VfXrcLnXr7wJBpG4XpeoOgQ6EWfwlu0NFnP2cw0c4ucpjvjUbrlBlKNjD
         rPZ+tU/6o3wrJ+ThD+a9BVBobJx9qV9b7g7xlGFvTCqlI5o++rRdpV56Rgif0sOX+8yX
         yaCfFYAD+k1wTB/WZKAnYP8qCN8a0oAkIgZaWPT6mTTaG1pq2gLmyol2rNo9Ax8Xp8Qp
         Ex6g==
X-Gm-Message-State: APjAAAVRCsf1DV/u4KbO+Rvx2MVXbWvyeyzEvJ25YT0HEzlSRvCLmfw8
        XZBhAEEz1+3D33rznyUVy7a377fVeVU=
X-Google-Smtp-Source: APXvYqxKgB8/LNFs3C9O9SY73Rk+Vf4suummWmMUd5ee7GJvcVJ/+9Q2BioY/GV0nIvM5xqnN8udYg==
X-Received: by 2002:a5d:6b46:: with SMTP id x6mr14039373wrw.313.1555972100105;
        Mon, 22 Apr 2019 15:28:20 -0700 (PDT)
Received: from localhost.localdomain (cpc91214-cmbg18-2-0-cust207.5-4.cable.virginm.net. [81.102.75.208])
        by smtp.gmail.com with ESMTPSA id m13sm14294773wmg.42.2019.04.22.15.28.18
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 22 Apr 2019 15:28:18 -0700 (PDT)
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
Subject: RE: [PATCH v6 0/6] blame: add the ability to ignore commits
Date:   Mon, 22 Apr 2019 23:26:47 +0100
Message-Id: <20190422222647.48628-1-michael@platin.gs>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <[PATCH v6 0/6] blame: add the ability to ignore commits>
References: <[PATCH v6 0/6] blame: add the ability to ignore commits>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Michael Platings <michael@platin.gs>

Hi Barret,

This patch is on top of your patch v6 4/6.

Previously I pointed out that my code couldn't handle this case correctly:
Before:

        commit-a 11) Position MyClass::location(Offset O) {
        commit-b 12)    return P + O;
        commit-c 13) }

After:

        commit-a 11) Position MyClass::location(Offset offset) {
        commit-a 12)    return position + offset;
        commit-c 13) }

With this patch, line 12 is now correctly matched to commit-b even though it is
more similar to line 11.

The significant change here is that when a line is matched, its fingerprint is
subtracted from the matched parent line's fingerprint. This prevents two lines
matching the same part of a parent line.

This algorithm is now very good at matching lines *as long as line ordering is
unchanged*. When matching lines in a single diff chunk it makes sense to assume
that lines are ordered because if they're not then there's a good chance the
true match is outside the chunk. I'm very happy with how this algorithm behaves
and I'm struggling to fault it for the refactoring & renaming use cases.

To address reordered lines I suggest a combination of this algorithm and your
algorithm - in the first path my algorithm tries to match lines within a
single chunk, and in the second pass your algorithm tries to find matches for
unblamed lines out of order and outside their chunk.

It would also be possible to adapt my algorithm to not assume that lines are
ordered, but I think that would make it O(n^2) whereas it's typically
O(n log n) right now. But I could dig into that more if you prefer.

Thanks,
-Michael
---
 Makefile |   1 +
 blame.c  |  95 +++++++-----
 blame.h  |   2 +
 fuzzy.c  | 434 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fuzzy.h  |  18 +++
 5 files changed, 515 insertions(+), 35 deletions(-)
 create mode 100644 fuzzy.c
 create mode 100644 fuzzy.h

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
index a98ae00e2c..43cdfcc259 100644
--- a/blame.c
+++ b/blame.c
@@ -9,6 +9,7 @@
 #include "blame.h"
 #include "alloc.h"
 #include "commit-slab.h"
+#include "fuzzy.h"
 
 define_commit_slab(blame_suspects, struct blame_origin *);
 static struct blame_suspects blame_suspects;
@@ -311,12 +312,42 @@ static int diff_hunks(mmfile_t *file_a, mmfile_t *file_b,
 	return xdi_diff(file_a, file_b, &xpp, &xecfg, &ecb);
 }
 
+static const char *get_next_line(const char *start, const char *end)
+{
+	const char *nl = memchr(start, '\n', end - start);
+
+	return nl ? nl + 1 : end;
+}
+
+static int find_line_starts(int **line_starts, const char *buf,
+			    unsigned long len)
+{
+	const char *end = buf + len;
+	const char *p;
+	int *lineno;
+	int num = 0;
+
+	for (p = buf; p < end; p = get_next_line(p, end))
+		num++;
+
+	ALLOC_ARRAY(*line_starts, num + 1);
+	lineno = *line_starts;
+
+	for (p = buf; p < end; p = get_next_line(p, end))
+		*lineno++ = p - buf;
+
+	*lineno = len;
+
+	return num;
+}
+
 /*
  * Given an origin, prepare mmfile_t structure to be used by the
  * diff machinery
  */
 static void fill_origin_blob(struct diff_options *opt,
-			     struct blame_origin *o, mmfile_t *file, int *num_read_blob)
+			     struct blame_origin *o, mmfile_t *file,
+			     int *num_read_blob, int fill_line_starts)
 {
 	if (!o->file.ptr) {
 		enum object_type type;
@@ -340,11 +371,16 @@ static void fill_origin_blob(struct diff_options *opt,
 	}
 	else
 		*file = o->file;
+	if (fill_line_starts && !o->line_starts)
+		o->num_lines = find_line_starts(&o->line_starts, o->file.ptr,
+						o->file.size);
 }
 
 static void drop_origin_blob(struct blame_origin *o)
 {
 	FREE_AND_NULL(o->file.ptr);
+	FREE_AND_NULL(o->line_starts);
+	o->num_lines = 0;
 }
 
 /*
@@ -891,19 +927,27 @@ static void guess_line_blames(struct blame_entry *e,
 			      int offset, int parent_slno, int parent_len,
 			      struct blame_line_tracker *line_blames)
 {
-	int i, parent_idx;
+	int i;
+	int *matching_lines = fuzzy_find_matching_lines(parent->file.ptr,
+							target->file.ptr,
+							parent->line_starts,
+							target->line_starts,
+							e->s_lno + offset,
+							e->s_lno,
+							parent_len,
+							e->num_lines);
 
 	for (i = 0; i < e->num_lines; i++) {
-		parent_idx = e->s_lno + i + offset;
-		if (parent_slno <= parent_idx &&
-		    parent_idx < parent_slno + parent_len) {
+		if (matching_lines[i] >= 0) {
 			line_blames[i].is_parent = 1;
-			line_blames[i].s_lno = parent_idx;
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
@@ -1136,8 +1180,10 @@ static void pass_blame_to_parent(struct blame_scoreboard *sb,
 	d.ignore_diffs = ignore_diffs;
 	d.dstq = &newdest; d.srcq = &target->suspects;
 
-	fill_origin_blob(&sb->revs->diffopt, parent, &file_p, &sb->num_read_blob);
-	fill_origin_blob(&sb->revs->diffopt, target, &file_o, &sb->num_read_blob);
+	fill_origin_blob(&sb->revs->diffopt, parent, &file_p,
+			 &sb->num_read_blob, ignore_diffs);
+	fill_origin_blob(&sb->revs->diffopt, target, &file_o,
+			 &sb->num_read_blob, ignore_diffs);
 	sb->num_get_patch++;
 
 	if (diff_hunks(&file_p, &file_o, blame_chunk_cb, &d, sb->xdl_opts))
@@ -1348,7 +1394,8 @@ static void find_move_in_parent(struct blame_scoreboard *sb,
 	if (!unblamed)
 		return; /* nothing remains for this target */
 
-	fill_origin_blob(&sb->revs->diffopt, parent, &file_p, &sb->num_read_blob);
+	fill_origin_blob(&sb->revs->diffopt, parent, &file_p,
+			 &sb->num_read_blob, 0);
 	if (!file_p.ptr)
 		return;
 
@@ -1477,7 +1524,8 @@ static void find_copy_in_parent(struct blame_scoreboard *sb,
 			norigin = get_origin(parent, p->one->path);
 			oidcpy(&norigin->blob_oid, &p->one->oid);
 			norigin->mode = p->one->mode;
-			fill_origin_blob(&sb->revs->diffopt, norigin, &file_p, &sb->num_read_blob);
+			fill_origin_blob(&sb->revs->diffopt, norigin, &file_p,
+					 &sb->num_read_blob, 0);
 			if (!file_p.ptr)
 				continue;
 
@@ -1816,37 +1864,14 @@ void assign_blame(struct blame_scoreboard *sb, int opt)
 	}
 }
 
-static const char *get_next_line(const char *start, const char *end)
-{
-	const char *nl = memchr(start, '\n', end - start);
-	return nl ? nl + 1 : end;
-}
-
 /*
  * To allow quick access to the contents of nth line in the
  * final image, prepare an index in the scoreboard.
  */
 static int prepare_lines(struct blame_scoreboard *sb)
 {
-	const char *buf = sb->final_buf;
-	unsigned long len = sb->final_buf_size;
-	const char *end = buf + len;
-	const char *p;
-	int *lineno;
-	int num = 0;
-
-	for (p = buf; p < end; p = get_next_line(p, end))
-		num++;
-
-	ALLOC_ARRAY(sb->lineno, num + 1);
-	lineno = sb->lineno;
-
-	for (p = buf; p < end; p = get_next_line(p, end))
-		*lineno++ = p - buf;
-
-	*lineno = len;
-
-	sb->num_lines = num;
+	sb->num_lines = find_line_starts(&sb->lineno, sb->final_buf,
+					 sb->final_buf_size);
 	return sb->num_lines;
 }
 
diff --git a/blame.h b/blame.h
index 53df8b4c5b..f7755920c9 100644
--- a/blame.h
+++ b/blame.h
@@ -51,6 +51,8 @@ struct blame_origin {
 	 */
 	struct blame_entry *suspects;
 	mmfile_t file;
+	int num_lines;
+	int *line_starts;
 	struct object_id blob_oid;
 	unsigned mode;
 	/* guilty gets set when shipping any suspects to the final
diff --git a/fuzzy.c b/fuzzy.c
new file mode 100644
index 0000000000..c5b09a0eb7
--- /dev/null
+++ b/fuzzy.c
@@ -0,0 +1,434 @@
+#include "fuzzy.h"
+#include <ctype.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+#include "git-compat-util.h"
+#include "hashmap.h"
+
+struct fingerprint_entry {
+	struct hashmap_entry entry;
+	int count;
+};
+struct fingerprint {
+	struct hashmap map;
+	struct fingerprint_entry *entries;
+};
+
+static void get_fingerprint(struct fingerprint *result,
+			    const char *line_begin,
+			    const char *line_end) {
+	unsigned hash;
+	char c0, c1;
+	int map_entry_count = line_end - line_begin - 1;
+	struct fingerprint_entry *entry = xcalloc(map_entry_count,
+		sizeof(struct fingerprint_entry));
+	struct fingerprint_entry *found_entry;
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
+
+		if ((found_entry = hashmap_get(&result->map, entry, NULL))) {
+			found_entry->count += 1;
+		}
+		else {
+			entry->count = 1;
+			hashmap_add(&result->map, entry);
+		}
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
+	const struct fingerprint_entry *entry_a, *entry_b;
+	hashmap_iter_init(&b->map, &iter);
+
+	while ((entry_b = hashmap_iter_next(&iter))) {
+		if ((entry_a = hashmap_get(&a->map, entry_b, NULL))) {
+			intersection += entry_a->count < entry_b->count ?
+					entry_a->count : entry_b->count;
+		}
+	}
+	return intersection;
+}
+
+static void fingerprint_subtract(struct fingerprint *a,
+				 struct fingerprint *b) {
+	struct hashmap_iter iter;
+	struct fingerprint_entry *entry_a;
+	const struct fingerprint_entry *entry_b;
+	hashmap_iter_init(&b->map, &iter);
+
+	while ((entry_b = hashmap_iter_next(&iter))) {
+		if ((entry_a = hashmap_get(&a->map, entry_b, NULL))) {
+			if (entry_a->count <= entry_b->count) {
+				hashmap_remove(&a->map, entry_b, NULL);
+			}
+			else {
+				entry_a->count -= entry_b->count;
+			}
+		}
+	}
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
+static int get_closest_local_line(int start_a,
+			    int local_line_b,
+			    int closest_line_calc_offset1,
+			    int closest_line_calc_offset2,
+			    int closest_line_calc_numerator,
+			    int closest_line_calc_denominator) {
+	return ((local_line_b + closest_line_calc_offset1) * 2 + 1) *
+		closest_line_calc_numerator /
+		(closest_line_calc_denominator * 2) +
+		closest_line_calc_offset2 - start_a;
+}
+
+static int *get_similarity(int *similarities, int max_search_distance_a,
+			   int local_line_a, int local_line_b,
+			   int closest_local_line_a) {
+	assert(abs(local_line_a - closest_local_line_a) <= max_search_distance_a);
+	return similarities + local_line_a - closest_local_line_a +
+		max_search_distance_a +
+		local_line_b * (max_search_distance_a * 2 + 1);
+}
+
+#define CERTAIN_NOTHING_MATCHES -2
+#define CERTAINTY_NOT_CALCULATED -1
+
+static void find_best_line_matches(const int max_search_distance_a,
+				   int start_a,
+				   int length_a,
+				   int local_line_b,
+				   struct fingerprint *fingerprints_a,
+				   struct fingerprint *fingerprints_b,
+				   int *similarities,
+				   int *certainties,
+				   int *second_best_result,
+				   int *result,
+				   int closest_line_calc_offset1,
+				   int closest_line_calc_offset2,
+				   int closest_line_calc_numerator,
+				   int closest_line_calc_denominator) {
+
+	int i, search_start, search_end, closest_local_line_a, *similarity,
+		best_similarity = 0, second_best_similarity = 0,
+		best_similarity_index = 0, second_best_similarity_index = 0;
+
+	if (certainties[local_line_b] != CERTAINTY_NOT_CALCULATED)
+		return;
+
+	closest_local_line_a = get_closest_local_line(start_a,
+					  local_line_b,
+					  closest_line_calc_offset1,
+					  closest_line_calc_offset2,
+					  closest_line_calc_numerator,
+					  closest_line_calc_denominator);
+
+	search_start = closest_local_line_a - max_search_distance_a;
+	if (search_start < 0)
+		search_start = 0;
+
+	search_end = closest_local_line_a + max_search_distance_a + 1;
+	if (search_end > length_a)
+		search_end = length_a;
+
+	for (i = search_start; i < search_end; ++i) {
+		similarity = get_similarity(similarities, max_search_distance_a,
+					    i, local_line_b,
+					    closest_local_line_a);
+		if (*similarity == -1) {
+			*similarity = fingerprint_similarity(
+				fingerprints_b + local_line_b,
+				fingerprints_a + i) *
+				(1000 - abs(i - closest_local_line_a));
+		}
+		if (*similarity > best_similarity) {
+			second_best_similarity = best_similarity;
+			second_best_similarity_index = best_similarity_index;
+			best_similarity = *similarity;
+			best_similarity_index = i;
+		}
+		else if (*similarity > second_best_similarity) {
+			second_best_similarity = *similarity;
+			second_best_similarity_index = i;
+		}
+	}
+
+	if (best_similarity == 0) {
+		certainties[local_line_b] = CERTAIN_NOTHING_MATCHES;
+		result[local_line_b] = -1;
+	}
+	else {
+		certainties[local_line_b] = best_similarity * 2 -
+			second_best_similarity;
+		result[local_line_b] = start_a + best_similarity_index;
+		second_best_result[local_line_b] =
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
+	int max_search_distance_a,
+	int max_search_distance_b,
+	int start_a, int start_b,
+	int length_a, int length_b,
+	struct fingerprint *fingerprints_a,
+	struct fingerprint *fingerprints_b,
+	int *similarities,
+	int *certainties,
+	int *second_best_result,
+	int *result,
+	int closest_line_calc_offset1,
+	int closest_line_calc_offset2,
+	int closest_line_calc_numerator,
+	int closest_line_calc_denominator) {
+
+	int i, barrier, invalidate_min, invalidate_max, offset_b,
+		second_half_start_a, second_half_start_b,
+		second_half_length_a, second_half_length_b,
+		most_certain_line_a, most_certain_local_line_b = -1,
+		most_certain_line_certainty = -1,
+		closest_local_line_a;
+
+	for (i = 0; i < length_b; ++i) {
+		find_best_line_matches(max_search_distance_a,
+				       start_a,
+				       length_a,
+				       i,
+				       fingerprints_a,
+				       fingerprints_b,
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
+			most_certain_local_line_b = i;
+		}
+	}
+
+	if (most_certain_local_line_b == -1) {
+		return;
+	}
+
+	most_certain_line_a = result[most_certain_local_line_b];
+
+	/* Subtract the most certain line's fingerprint in b from the
+	 matched fingerprint in a. This means that other lines in b can't also
+	 match the same parts of the line in a. */
+	fingerprint_subtract(fingerprints_a + most_certain_line_a - start_a,
+			     fingerprints_b + most_certain_local_line_b);
+
+
+	/* Invalidate results that may be affected by the choice of pivot. */
+	invalidate_min = most_certain_local_line_b - max_search_distance_b;
+	invalidate_max = most_certain_local_line_b + max_search_distance_b + 1;
+	if (invalidate_min < 0)
+		invalidate_min = 0;
+	if (invalidate_max > length_b)
+		invalidate_max = length_b;
+
+	for (i = invalidate_min; i < invalidate_max; ++i) {
+		closest_local_line_a = get_closest_local_line(
+			start_a, i,
+			closest_line_calc_offset1,
+			closest_line_calc_offset2,
+			closest_line_calc_numerator,
+			closest_line_calc_denominator);
+		*get_similarity(similarities, max_search_distance_a,
+				most_certain_line_a - start_a, i,
+				closest_local_line_a) = -1;
+	}
+
+	barrier = most_certain_line_a;
+
+	for (i = most_certain_local_line_b - 1; i >= invalidate_min; --i) {
+		if (certainties[i] >= 0 &&
+		    (result[i] >= barrier || second_best_result[i] >= barrier)) {
+			    certainties[i] = CERTAINTY_NOT_CALCULATED;
+			    barrier = result[i];
+			    invalidate_min = i - max_search_distance_b;
+			    if (invalidate_min < 0)
+				    invalidate_min = 0;
+		    }
+	}
+
+	barrier = most_certain_line_a;
+
+	for (i = most_certain_local_line_b + 1; i < invalidate_max; ++i) {
+		if (certainties[i] >= 0 &&
+		    (result[i] <= barrier || second_best_result[i] <= barrier)) {
+			    certainties[i] = CERTAINTY_NOT_CALCULATED;
+			    barrier = result[i];
+			    invalidate_max = i + max_search_distance_b + 1;
+			    if (invalidate_max > length_b)
+				    invalidate_max = length_b;
+		    }
+	}
+
+
+	if (most_certain_local_line_b > 0) {
+		fuzzy_find_matching_lines_recurse(
+			max_search_distance_a,
+			max_search_distance_b,
+			start_a, start_b,
+			most_certain_line_a + 1 - start_a,
+			most_certain_local_line_b,
+			fingerprints_a, fingerprints_b, similarities,
+			certainties, second_best_result, result,
+			closest_line_calc_offset1, closest_line_calc_offset2,
+			closest_line_calc_numerator,
+			closest_line_calc_denominator);
+	}
+	if (most_certain_local_line_b + 1 < length_b) {
+		second_half_start_a = most_certain_line_a;
+		offset_b = most_certain_local_line_b + 1;
+		second_half_start_b = start_b + offset_b;
+		second_half_length_a =
+			length_a + start_a - second_half_start_a;
+		second_half_length_b =
+			length_b + start_b - second_half_start_b;
+		fuzzy_find_matching_lines_recurse(
+			max_search_distance_a,
+			max_search_distance_b,
+			second_half_start_a, second_half_start_b,
+			second_half_length_a, second_half_length_b,
+			fingerprints_a + second_half_start_a - start_a,
+			fingerprints_b + offset_b,
+			similarities +
+				offset_b * (max_search_distance_a * 2 + 1),
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
+	int i, *result, *second_best_result,
+		*certainties, *similarities, similarity_count;
+	struct fingerprint *fingerprints_a, *fingerprints_b;
+
+	/* max_search_distance_a means that given a line in `b`, compare it to
+	the line in `a` that is closest to its position, and the lines in `a`
+	that are no greater than max_search_distance_a lines away from the
+	closest line in `a`.
+	max_search_distance_b is an upper bound on the greatest possible
+	distance between lines in `b` such that they will both be compared with
+	the same line in `a` according to max_search_distance_a. */
+	int max_search_distance_a = 10, max_search_distance_b;
+
+	if (max_search_distance_a >= length_a)
+		max_search_distance_a = length_a ? length_a - 1 : 0;
+
+	if (length_a == 0) {
+		max_search_distance_b = 0;
+	}
+	else {
+		max_search_distance_b = ((2 * max_search_distance_a + 1) *
+			length_b - 1) / length_a;
+	}
+
+	result = malloc(sizeof(int) * length_b);
+	second_best_result = malloc(sizeof(int) * length_b);
+	certainties = malloc(sizeof(int) * length_b);
+	similarity_count = length_b * (max_search_distance_a * 2 + 1);
+	similarities = malloc(sizeof(int) * similarity_count);
+
+	for (i = 0; i < length_b; ++i) {
+		result[i] = -1;
+		second_best_result[i] = -1;
+		certainties[i] = CERTAINTY_NOT_CALCULATED;
+	}
+
+	for (i = 0; i < similarity_count; ++i) {
+		similarities[i] = -1;
+	}
+
+	fingerprints_a = xmalloc(sizeof(struct fingerprint) * length_a);
+	fingerprints_b = xmalloc(sizeof(struct fingerprint) * length_b);
+
+	get_line_fingerprints(fingerprints_a, content_a,
+			      line_starts_a,
+			      start_a, length_a);
+	get_line_fingerprints(fingerprints_b, content_b,
+			      line_starts_b,
+			      start_b, length_b);
+
+	fuzzy_find_matching_lines_recurse(max_search_distance_a,
+					  max_search_distance_b,
+					  start_a, start_b,
+					  length_a, length_b,
+					  fingerprints_a,
+					  fingerprints_b,
+					  similarities,
+					  certainties,
+					  second_best_result,
+					  result,
+					  0, start_a, length_a, length_b);
+
+	for (i = 0; i < length_b; ++i) {
+		free_fingerprint(fingerprints_b + i);
+	}
+	for (i = 0; i < length_a; ++i) {
+		free_fingerprint(fingerprints_a + i);
+	}
+	free(fingerprints_b);
+	free(fingerprints_a);
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
-- 
2.21.0

