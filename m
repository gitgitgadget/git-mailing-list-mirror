Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2D69202AE
	for <e@80x24.org>; Sat,  8 Jul 2017 10:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752782AbdGHKfq (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Jul 2017 06:35:46 -0400
Received: from mout.web.de ([212.227.15.4]:55950 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752751AbdGHKfp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jul 2017 06:35:45 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LiaAW-1e69hv099w-00cj0W; Sat, 08
 Jul 2017 12:35:39 +0200
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] use DIV_ROUND_UP
Message-ID: <4d2c274a-f6cb-6ea5-304f-51a3152cc436@web.de>
Date:   Sat, 8 Jul 2017 12:35:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:VAwWieC4PJFAeA812Mujpfvw4tfAUCPxc/gEz+5U8pl4PyWt3Fh
 W39p3AcvEJl2f4lwOhD4xGY34sq6G41otwaiGE6rli9u7+9qMz4mI15TZjfWZi3GnzK1xjm
 PPs0LGWM5PO1lqiMf67EV2YGEGNNx3DW0BBO91xndUhGxePh2JIyNPnXaX/+bPWVue22eqI
 8l7agiZez7CpgF3hMM3fQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YcUy875U/uI=:7rdNQNFlZxLxXfHBnr2lxN
 v1tj3Te2Opzr+zRKkGzaiOY8wcxs19JhoXKzqN0Y298FKB+VK1lHb+k64r3sIfVnc5g87MXPs
 Qvx9/tOGGnKcOcPA5cZXyyFCUAd94Ot0Dats4OLMmurvypgETrqYuA8cr45Uj4zpd2Tg6wjEd
 /BjcUBRXOianxiPqE67W6MLWfb+yt67GXsubf0HXX3kg5/UTtrL5RiZVWjp0G9NTEXhILclE8
 nS1lmswfAoLVMka/MTaJ4q9B/QL6CNAHNkG++WoCdDfYtpMrVeehB7Oeg8EASXms42PDSP16m
 pDLK/P5IKwe4Qhw/t8wsmPldqFEm+o028TV92vHV5TKfWwAAV32pY+la4tU7iEF4Rl9lpJoei
 1aNncfI+3alHXIwPDqxLXZXGtheEjTfLAKloVbfg3ahs3RyaUSbSjBFkJ8H7c4u+fTcefyFPu
 f5UwQibiq0HTKaPjES+1Y1ie6x9X+p621p1Q1FBxcxFmerQoThCidlEvtjFuPhX8+dOhCA7Vd
 0i3CW64SDn/wqxawBHEuiryW4UadyVSMiUk3u9SjUwxCFlKbJ80G3zAIuuhQOOTuZbrrQUJwB
 2U5XI3AIwwsG9aICowy+E4SRqNZ2buSsjbZ3d4xlzmH4calnthf4CoXgZgEsalc0N3HkqUVUu
 qC/rGM4jxsjGL6EQTXsxp/puRlPcYBJwq+L4SArAC0gBheNcZRbpox+XCGoqkdx1Un5Ef7DmQ
 IIu1HhfnR35vULTvyFMjn7NZpJRPMwNzN01jidY4odUPCFDpcWAOnLBx54M3bq7be7WaA3kS9
 bAVaMbD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert code that divides and rounds up to use DIV_ROUND_UP to make the
intent clearer and reduce the number of magic constants.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/gc.c           | 2 +-
 builtin/grep.c         | 2 +-
 builtin/log.c          | 2 +-
 builtin/receive-pack.c | 2 +-
 diff.c                 | 2 +-
 ewah/ewah_bitmap.c     | 4 ++--
 imap-send.c            | 2 +-
 sha1_name.c            | 2 +-
 shallow.c              | 8 ++++----
 9 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index bd91f136fe..2ba50a2873 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -149,7 +149,7 @@ static int too_many_loose_objects(void)
 	if (!dir)
 		return 0;
 
-	auto_threshold = (gc_auto_threshold + 255) / 256;
+	auto_threshold = DIV_ROUND_UP(gc_auto_threshold, 256);
 	while ((ent = readdir(dir)) != NULL) {
 		if (strspn(ent->d_name, "0123456789abcdef") != 38 ||
 		    ent->d_name[38] != '\0')
diff --git a/builtin/grep.c b/builtin/grep.c
index fa351c49f4..0d6e669732 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -543,7 +543,7 @@ static void compile_submodule_options(const struct grep_opt *opt,
 	 * submodule process has its own thread pool.
 	 */
 	argv_array_pushf(&submodule_options, "--threads=%d",
-			 (num_threads + 1) / 2);
+			 DIV_ROUND_UP(num_threads, 2));
 
 	/* Add Pathspecs */
 	argv_array_push(&submodule_options, "--");
diff --git a/builtin/log.c b/builtin/log.c
index 8ca1de9894..c6362cf92e 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1308,7 +1308,7 @@ static struct commit *get_base_commit(const char *base_commit,
 
 		if (rev_nr % 2)
 			rev[i] = rev[2 * i];
-		rev_nr = (rev_nr + 1) / 2;
+		rev_nr = DIV_ROUND_UP(rev_nr, 2);
 	}
 
 	if (!in_merge_bases(base, rev[0]))
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 71c0c768db..cabdc55e09 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1806,7 +1806,7 @@ static const char *unpack_with_sideband(struct shallow_info *si)
 static void prepare_shallow_update(struct command *commands,
 				   struct shallow_info *si)
 {
-	int i, j, k, bitmap_size = (si->ref->nr + 31) / 32;
+	int i, j, k, bitmap_size = DIV_ROUND_UP(si->ref->nr, 32);
 
 	ALLOC_ARRAY(si->used_shallow, si->shallow->nr);
 	assign_shallow_commits_to_refs(si, si->used_shallow, NULL);
diff --git a/diff.c b/diff.c
index 00b4c86698..85e714f6c6 100644
--- a/diff.c
+++ b/diff.c
@@ -2095,7 +2095,7 @@ static void show_dirstat_by_line(struct diffstat_t *data, struct diff_options *o
 			 * bytes per "line".
 			 * This is stupid and ugly, but very cheap...
 			 */
-			damage = (damage + 63) / 64;
+			damage = DIV_ROUND_UP(damage, 64);
 		ALLOC_GROW(dir.files, dir.nr + 1, dir.alloc);
 		dir.files[dir.nr].name = file->name;
 		dir.files[dir.nr].changed = damage;
diff --git a/ewah/ewah_bitmap.c b/ewah/ewah_bitmap.c
index 2dc9c82ecf..06c479f70a 100644
--- a/ewah/ewah_bitmap.c
+++ b/ewah/ewah_bitmap.c
@@ -210,8 +210,8 @@ size_t ewah_add(struct ewah_bitmap *self, eword_t word)
 void ewah_set(struct ewah_bitmap *self, size_t i)
 {
 	const size_t dist =
-		(i + BITS_IN_EWORD) / BITS_IN_EWORD -
-		(self->bit_size + BITS_IN_EWORD - 1) / BITS_IN_EWORD;
+		DIV_ROUND_UP(i + 1, BITS_IN_EWORD) -
+		DIV_ROUND_UP(self->bit_size, BITS_IN_EWORD);
 
 	assert(i >= self->bit_size);
 
diff --git a/imap-send.c b/imap-send.c
index 351e84aea1..b2d0b849bb 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -861,7 +861,7 @@ static char hexchar(unsigned int b)
 	return b < 10 ? '0' + b : 'a' + (b - 10);
 }
 
-#define ENCODED_SIZE(n) (4*((n+2)/3))
+#define ENCODED_SIZE(n) (4 * DIV_ROUND_UP((n), 3))
 static char *cram(const char *challenge_64, const char *user, const char *pass)
 {
 	int i, resp_len, encoded_len, decoded_len;
diff --git a/sha1_name.c b/sha1_name.c
index e7f7b12ceb..8c513dbff6 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -492,7 +492,7 @@ int find_unique_abbrev_r(char *hex, const unsigned char *sha1, int len)
 		 * together we need to divide by 2; but we also want to round
 		 * odd numbers up, hence adding one before dividing.
 		 */
-		len = (len + 1) / 2;
+		len = DIV_ROUND_UP(len, 2);
 		/*
 		 * For very small repos, we stick with our regular fallback.
 		 */
diff --git a/shallow.c b/shallow.c
index ef7ca78993..54359d5490 100644
--- a/shallow.c
+++ b/shallow.c
@@ -443,7 +443,7 @@ struct paint_info {
 
 static uint32_t *paint_alloc(struct paint_info *info)
 {
-	unsigned nr = (info->nr_bits + 31) / 32;
+	unsigned nr = DIV_ROUND_UP(info->nr_bits, 32);
 	unsigned size = nr * sizeof(uint32_t);
 	void *p;
 	if (!info->pool_count || size > info->end - info->free) {
@@ -471,7 +471,7 @@ static void paint_down(struct paint_info *info, const struct object_id *oid,
 {
 	unsigned int i, nr;
 	struct commit_list *head = NULL;
-	int bitmap_nr = (info->nr_bits + 31) / 32;
+	int bitmap_nr = DIV_ROUND_UP(info->nr_bits, 32);
 	size_t bitmap_size = st_mult(sizeof(uint32_t), bitmap_nr);
 	struct commit *c = lookup_commit_reference_gently(oid, 1);
 	uint32_t *tmp; /* to be freed before return */
@@ -611,7 +611,7 @@ void assign_shallow_commits_to_refs(struct shallow_info *info,
 		paint_down(&pi, ref->oid + i, i);
 
 	if (used) {
-		int bitmap_size = ((pi.nr_bits + 31) / 32) * sizeof(uint32_t);
+		int bitmap_size = DIV_ROUND_UP(pi.nr_bits, 32) * sizeof(uint32_t);
 		memset(used, 0, sizeof(*used) * info->shallow->nr);
 		for (i = 0; i < nr_shallow; i++) {
 			const struct commit *c = lookup_commit(&oid[shallow[i]]);
@@ -672,7 +672,7 @@ static void post_assign_shallow(struct shallow_info *info,
 	struct commit *c;
 	uint32_t **bitmap;
 	int dst, i, j;
-	int bitmap_nr = (info->ref->nr + 31) / 32;
+	int bitmap_nr = DIV_ROUND_UP(info->ref->nr, 32);
 	struct commit_array ca;
 
 	trace_printf_key(&trace_shallow, "shallow: post_assign_shallow\n");
-- 
2.13.2

