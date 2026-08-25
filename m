Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335393C98BA
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 19:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787684462; cv=none; b=DMByL2WZZpNTqa0kjHCgGePWm0esUGcf8eiBxJQybKDwr9AWvTVZw9AgWWsmTXx4zHnMnWiOkdU0AfwziXzkl64ZPUWfl2x9YoN12BJtCs9l7hUvks2H4KGWJgvF/vW+lzDdyleaHzrsl9WpRLuyv4nKTWdAx4QYztcuLgKMdQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787684462; c=relaxed/simple;
	bh=PypMskbGZ/O2EqqemP2zAwHx3jdfjAf2+zyw1kICUzA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=n0ivn26ITZDvkuGS/jzBsl0xgRRFJvXx1JSSkKk4xv124ZLSN+sOKIhDOx9Btd9aozg6yvVSOn0+J2dC5hTraIB2WQZ/QsitrnyrRpJkKU/AGM0UBrbTimlPO7y3X3vqM2BKSQfM7O/rl5LFCuCSQbpglWsIrDxh+mGZ/78O9ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HAfQGs3D; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAfQGs3D"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-52b3934af3fso1671981cf.1
        for <git@vger.kernel.org>; Tue, 25 Aug 2026 12:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787684435; x=1788289235; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GuGLWBWQcSTi/Mc0tpLzQ5r2/+JaCvhDf9FqwXR1RbY=;
        b=HAfQGs3DWVS/2JJp3QjBPJ/urr5SwRXOaN5UdbyOVimyo36+lPWJlu7CYAb7DJ2eKF
         nwY7dFIrzRfqV2vlTO1w+GxzS9qnmoud1KNKY8vKoHoajtEvf2A1k+WS9jbUKV6UTqXL
         LKd/0bJ+bG3eTXnqAI4ymxTURJGXiH26yZbw1569FnMnIHJn9Dzhx+MY1JqZI7tc2yJ4
         WLtWdMhgM1Pg2bAXZ8hpIgdkz4Mw7O/nwo5B2rLlvUYJsg4kNX4691kFMOPACqMEe2oj
         zCtat1f+Tt5IN3A5S9LCDf/EXxc5/cmZCwto2sQkIJNSDY45wy72DeROYpT6Ku5YJza/
         70DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787684435; x=1788289235;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GuGLWBWQcSTi/Mc0tpLzQ5r2/+JaCvhDf9FqwXR1RbY=;
        b=JIsdabGqqaiC69iKATfTty4jq3uoAbhv/uE0+9lvWshSkme22mSEOxp3TOMWHfVln8
         GqgpFUHuRQeGk8SLFoiYHJtCqOu38QJdPFbIeLD5zD6z92vV6aecSRHSXerGikePf64x
         Rpf9PjPtkbsjy7bYP2SYgC6GqMHILJf2U2sRCTkLbI2cam6xk6FcUyF4NefjZPWXEW5S
         c41X3HHlGNQqwee71U33CNpT+jBrRTPkxMcRDjmygNaTmhzE3G20IHqzN/60GYeEpRt+
         3ckTXbpIbMngTMGa1YmIUviMn+jMEMNByGJ8matUv2bL2YjERghNi5MdnhDCPZQBbXEL
         kuzw==
X-Gm-Message-State: AFuF++nQ+PvS5wBi7ej3SD7oTp75huLCbstfwOrfhH8bfn6ggxATzs9g
	c6vb14CvsjAWoNkXjh3d5HVbL+Ud3B9e7yu1lX9MHMbJWkayVut7DOLtuj5cSYiz
X-Gm-Gg: AR+sD11tKC+sCXvShOYyWwEzE1vgy7XxbkxRqOwKItdr4UMdsSCkpyGBHnnTLqjJK6V
	XBz3cHmdDLA+gPcxf7jGZJmZI9O7bdTuMGeSJ7+vPmRmAcjZAJb9wsZIR/T2wCr7PhY4JHEqc+E
	bxxm/PgMHlMYxUcMEGWo7RFFGOnP9QUUAUfAKh+a1Znv9ju3cEUPkkuJoJACxQinZ5Uatzizd6z
	CP+dilvmdCsRd5TrxgLwKhvY0kHPNaOzhJ0ct+X8ykb6WZIpT3u61715uNXIIKTH0s4QsoK+9FU
	D/SQYPEwiZfBMn5d9ER1bAtCxiqMTZpL6iJ35X4fJI3Fqv06X6F43xG/+JbVba2dzPc81w+H4RU
	d/nEGjYI0/e4dQ+LKEK/QW3yu/XKm4BaHoht/pj6ABjs6H2dqZGec+egzpltxeC1ZjqplVAJpp7
	igC7b/LFEVIbSv9w4gJ4wx0+7RfqiwDfd2kAj7OilcNuNWhBHWOEMyReDX9p7I4gQ+Rg==
X-Received: by 2002:ac8:5a08:0:b0:51b:fd82:22dd with SMTP id d75a77b69052e-52e422cdea5mr11293901cf.15.1787684434541;
        Tue, 25 Aug 2026 12:00:34 -0700 (PDT)
Received: from [127.0.0.1] ([20.127.245.161])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52e4259b37dsm2125631cf.12.2026.08.25.12.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 12:00:34 -0700 (PDT)
Message-Id: <fc98f48ddb4d46cad66a40ecdd96c139e1397784.1787684429.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2207.v2.git.1787684429.gitgitgadget@gmail.com>
References: <pull.2207.git.1787092446.gitgitgadget@gmail.com>
	<pull.2207.v2.git.1787684429.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 25 Aug 2026 19:00:28 +0000
Subject: [PATCH v2 3/4] packfile: recover object lookups racing a concurrent
 repack
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
    Elijah Newren <newren@gmail.com>,
    Jeff King <peff@peff.net>,
    Derrick Stolee <stolee@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

When a reader opens a pack it discovered on disk, open_packed_git_1()
first mmaps the pack's `.idx`.  A `git repack` running alongside us
consolidates existing packs into a new one and then removes the
redundant packs, deleting each pack's `.idx` before its `.pack` (see the
ordering in unlink_pack_path()).  A reader that had just enumerated one
of those packs -- most easily through a multi-pack-index -- can race with
the removal and find the pack gone.

Two things go wrong in that window:

  1. open_pack_index() fails, so we print

        error: packfile <path> index unavailable

     and report the pack as unusable, even though the object still lives
     in the replacement pack.

  2. A normal lookup recovers: odb_read_object_info_extended() issues a
     second read that reloads the on-disk pack state and finds the object
     in its new home, making the message above mere noise.  But an
     OBJECT_INFO_QUICK lookup deliberately skips that second read to stay
     fast on a genuine miss, so it does *not* recover: it reports the
     object as absent even though it still lives in the replacement pack.
     A resident reader that resolves objects with a QUICK lookup -- such
     as the `git mktree --batch` process the tests below drive -- then
     produces wrong results.  Even where a spurious miss is not fatal it
     is not harmless: `git upload-pack` checks a client's "have" lines
     with a QUICK lookup, and a dropped "have" removes a common object
     from the negotiation, so the client is sent more than it needs.

Recovering without giving up that speed is the trick: we keep QUICK's
fast path for a genuine miss and force the extra read only when a pack
we were already using has provably vanished.

Fix both.  Record that a pack disappeared out from under us by setting
object_database.stale_packs_detected at the three points where a reader
can notice a pack vanish beneath it:

  - In open_packed_git_1(), when open_pack_index() fails because the
    index simply vanished (its open fails with ENOENT).  Here we also
    stay silent instead of printing "index unavailable"; a genuinely
    unreadable index that is still present keeps the error, since that is
    a real problem worth surfacing.

  - In open_packed_git_1() again, from the other side of the race: when
    the `.idx` was already mapped -- so open_pack_index() returns without
    touching the filesystem -- yet opening the `.pack` fails with ENOENT.
    A reader that prepared its pack list before the repack only trips
    over the removal when it finally opens the pack file.

  - In prepare_midx_pack(), when packfile_store_load_pack() cannot open a
    pack the midx still references at all.  If both the `.idx` and the
    `.pack` are already gone -- as happens when the redundant pack is
    removed outright rather than index-first -- we never reach
    open_pack_index(), so this is the only place the vanished pack is
    observed.

Then, in odb_read_object_info_extended(), issue the second read -- which
asks the sources to reload their on-disk state (for packs, a reprepare)
and retry -- not only for non-QUICK lookups but also whenever
stale_packs_detected is set, even under OBJECT_INFO_QUICK.  An ordinary
QUICK miss, with no vanished pack, still skips the second read and stays
fast; we pay for the rescan only when we have positive evidence that the
on-disk pack set changed beneath us.  The flag is reset when the
packfiles are reprepared, in odb_source_packed_prepare().

Add t5336, regression tests that reproduce the race deterministically:
they drive a resident `git mktree --batch` reader -- which resolves each
tree entry with OBJECT_INFO_QUICK -- across both removal windows, one
removing a pack's `.idx` first while a midx routes the lookup to the
doomed pack, the other removing a pack's `.pack` after its `.idx` was
already mapped.  Each confirms the reader recovers the relocated object
instead of dying.

Assisted-by: Claude Opus 4.8 & GPT-5.6 Sol
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 midx.c                        |   6 ++
 odb.c                         |   8 +-
 odb.h                         |  16 +++-
 odb/source-packed.c           |   9 ++-
 packfile.c                    |  39 ++++++++-
 t/meson.build                 |   1 +
 t/t5336-repack-reader-race.sh | 148 ++++++++++++++++++++++++++++++++++
 7 files changed, 221 insertions(+), 6 deletions(-)
 create mode 100755 t/t5336-repack-reader-race.sh

diff --git a/midx.c b/midx.c
index 37f082dbdd..942505ac41 100644
--- a/midx.c
+++ b/midx.c
@@ -475,6 +475,12 @@ int prepare_midx_pack(struct multi_pack_index *m,
 
 	if (!p) {
 		m->packs[pack_int_id] = MIDX_PACK_ERROR;
+		/*
+		 * The midx names a pack we can no longer open (its files
+		 * vanished, e.g. a concurrent repack replaced it).  Record the
+		 * stale pack set (see stale_packs_detected).
+		 */
+		packed->base.odb->stale_packs_detected = 1;
 		return 1;
 	}
 
diff --git a/odb.c b/odb.c
index 6bbea64033..4bb9662c65 100644
--- a/odb.c
+++ b/odb.c
@@ -583,8 +583,14 @@ static enum odb_read_status do_oid_object_info_extended(struct object_database *
 		 * When the object hasn't been found we try a second read and
 		 * tell the sources so. This may cause them to invalidate
 		 * caches or reload on-disk state.
+		 *
+		 * A QUICK lookup normally skips this second read to stay fast
+		 * on a genuine miss, but retry anyway when a pack vanished
+		 * mid-lookup (stale_packs_detected): the object likely just
+		 * moved into its replacement pack.
 		 */
-		if (!(flags & OBJECT_INFO_QUICK)) {
+		if (!(flags & OBJECT_INFO_QUICK) ||
+		    odb->stale_packs_detected) {
 			for (source = odb->sources; source; source = source->next) {
 				ret = odb_source_read_object_info(source, real, oi,
 								  flags | OBJECT_INFO_SECOND_READ,
diff --git a/odb.h b/odb.h
index 1264d4ce7d..8b91e6f8ba 100644
--- a/odb.h
+++ b/odb.h
@@ -93,6 +93,17 @@ struct object_database {
 	unsigned object_count_flags;
 	unsigned object_count_valid : 1;
 
+	/*
+	 * Set when a lookup finds that a pack we already know about has
+	 * vanished -- its ".idx" or ".pack" removed out from under us, the
+	 * signature of a concurrent "git repack".  It tells
+	 * odb_read_object_info_extended() to reprepare and retry even for an
+	 * OBJECT_INFO_QUICK lookup, which normally skips that rescan to stay
+	 * fast on a genuine miss.  Reset when the packfiles are reprepared
+	 * (see odb_source_packed_prepare()).
+	 */
+	unsigned stale_packs_detected : 1;
+
 	/*
 	 * Submodule source paths that will be added as additional sources to
 	 * allow lookup of submodule objects via the main object database.
@@ -423,8 +434,9 @@ enum object_info_flags {
 	 * whether any on-disk state may have changed that may have caused the
 	 * object to appear.
 	 *
-	 * This flag is for internal use, only. The second read only occurs
-	 * when `OBJECT_INFO_QUICK` was not passed.
+	 * This flag is for internal use, only. The second read occurs when
+	 * OBJECT_INFO_QUICK was not passed, or when a vanished pack was
+	 * detected (see stale_packs_detected).
 	 */
 	OBJECT_INFO_SECOND_READ = (1 << 4),
 
diff --git a/odb/source-packed.c b/odb/source-packed.c
index 1a12a605db..b6c1d8fdf4 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -798,8 +798,15 @@ static void odb_source_packed_prepare(struct odb_source *source,
 {
 	struct odb_source_packed *packed = odb_source_packed_downcast(source);
 
-	if (flags & ODB_PREPARE_FLUSH_CACHES)
+	if (flags & ODB_PREPARE_FLUSH_CACHES) {
 		packed->initialized = false;
+		/*
+		 * A reprepare re-scans the on-disk pack set, so any pack we
+		 * previously noticed had vanished is accounted for now; clear
+		 * the flag that forced this rescan (see stale_packs_detected).
+		 */
+		packed->base.odb->stale_packs_detected = 0;
+	}
 	if (packed->initialized)
 		return;
 
diff --git a/packfile.c b/packfile.c
index cd38be088d..bc8587d185 100644
--- a/packfile.c
+++ b/packfile.c
@@ -522,6 +522,21 @@ const char *pack_basename(struct packed_git *p)
 	return ret;
 }
 
+/* Did the pack's ".idx" vanish from disk (ENOENT), e.g. via a repack? */
+static int pack_index_is_missing(struct packed_git *p)
+{
+	char *idx_name;
+	size_t len;
+	int missing;
+
+	if (!strip_suffix(p->pack_name, ".pack", &len))
+		return 0;
+	idx_name = xstrfmt("%.*s.idx", (int)len, p->pack_name);
+	missing = access(idx_name, F_OK) < 0 && errno == ENOENT;
+	free(idx_name);
+	return missing;
+}
+
 /*
  * Do not call this directly as this leaks p->pack_fd on error return;
  * call open_packed_git() instead.
@@ -535,8 +550,20 @@ static int open_packed_git_1(struct packed_git *p)
 	ssize_t read_result;
 	const unsigned hashsz = p->repo->hash_algo->rawsz;
 
-	if (open_pack_index(p))
+	if (open_pack_index(p)) {
+		/*
+		 * A concurrent repack may have removed this pack, deleting its
+		 * ".idx" before its ".pack" (see unlink_pack_path()).  If the
+		 * index simply vanished, note the stale pack set and stay
+		 * quiet; the pack is still reported unusable.  Only a
+		 * still-present but unreadable index is worth an error.
+		 */
+		if (pack_index_is_missing(p)) {
+			p->repo->objects->stale_packs_detected = 1;
+			return -1;
+		}
 		return error("packfile %s index unavailable", p->pack_name);
+	}
 
 	if (!pack_max_fds) {
 		unsigned int max_fds = get_max_fd_limit();
@@ -552,8 +579,16 @@ static int open_packed_git_1(struct packed_git *p)
 		; /* nothing */
 
 	p->pack_fd = git_open(p->pack_name);
-	if (p->pack_fd < 0 || fstat(p->pack_fd, &st))
+	if (p->pack_fd < 0 || fstat(p->pack_fd, &st)) {
+		/*
+		 * A concurrent repack removed this pack, but its ".idx" was
+		 * already mapped (so open_pack_index() above succeeded); the
+		 * removal surfaces only now, when the ".pack" cannot be opened.
+		 */
+		if (p->pack_fd < 0 && errno == ENOENT)
+			p->repo->objects->stale_packs_detected = 1;
 		return -1;
+	}
 	pack_open_fds++;
 
 	/* If we created the struct before we had the pack we lack size. */
diff --git a/t/meson.build b/t/meson.build
index 2133c840da..28b63c486c 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -639,6 +639,7 @@ integration_tests = [
   't5333-pseudo-merge-bitmaps.sh',
   't5334-incremental-multi-pack-index.sh',
   't5335-compact-multi-pack-index.sh',
+  't5336-repack-reader-race.sh',
   't5351-unpack-large-objects.sh',
   't5400-send-pack.sh',
   't5401-update-hooks.sh',
diff --git a/t/t5336-repack-reader-race.sh b/t/t5336-repack-reader-race.sh
new file mode 100755
index 0000000000..63dad5521a
--- /dev/null
+++ b/t/t5336-repack-reader-race.sh
@@ -0,0 +1,148 @@
+#!/bin/sh
+
+test_description='reader recovery when a concurrent repack retires a pack
+
+"git repack" consolidates existing packs into a replacement pack and then
+removes the redundant packs, deleting each pack.idx before its pack.pack (see
+the ordering in unlink_pack_path()).  A reader that discovered one of those
+packs -- most easily through a multi-pack-index -- can look the pack up in the
+window where its .idx is gone but its .pack is not.
+
+For an OBJECT_INFO_QUICK lookup this is not recovered automatically: QUICK
+skips the reprepare-and-retry that a normal lookup performs, so a persistent
+reader whose pack list predates the replacement pack reports the object as
+missing even though it still lives in the replacement pack.  "git mktree
+--batch" is such a persistent QUICK reader: it stays resident across multiple
+trees and resolves each entry with OBJECT_INFO_QUICK, so before this fix it
+produced wrong output in this window.
+
+The removal can also be observed one step later, from the other side: a reader
+that already mmapped a pack.idx (so open_pack_index() succeeds without touching
+the filesystem) but has not yet opened its pack.pack.  If the pack.pack is gone
+by the time the reader opens it, the same QUICK false-negative results unless we
+notice the vanished .pack and reprepare.
+'
+
+. ./test-lib.sh
+
+test_expect_success 'setup repo with a multi-pack-index over per-object packs' '
+	test_commit seed &&
+	a=$(echo A | git hash-object -w --stdin) &&
+	b=$(echo B | git hash-object -w --stdin) &&
+	echo "$a" | git pack-objects .git/objects/pack/pack >pack-a &&
+	echo "$b" | git pack-objects .git/objects/pack/pack >pack-b &&
+
+	# Drop the loose copies so the blobs resolve only through the packs the
+	# multi-pack-index references; otherwise the loose object would satisfy
+	# the lookup and the pack-removal race could never be observed.
+	git prune-packed &&
+	git multi-pack-index write &&
+
+	printf "100644 blob %s\ta\n" "$a" >tree-a-input &&
+	printf "100644 blob %s\tb\n" "$b" >tree-b-input
+'
+
+test_expect_success PIPE 'QUICK reader recovers an object whose pack was retired mid-lookup' '
+	victim=".git/objects/pack/pack-$(cat pack-b)" &&
+	mkfifo in out &&
+	test_when_finished "rm -f in out" &&
+
+	# "git mktree --batch" is a resident OBJECT_INFO_QUICK reader; start it
+	# now so its in-memory pack list / midx predates the replacement pack.
+	(git mktree --batch <in >out 2>err &) &&
+	exec 9>in &&
+	exec 8<out &&
+	test_when_finished "exec 9>&- || :" &&
+	test_when_finished "exec 8<&- || :" &&
+
+	# The first tree forces the reader to prepare its (soon stale) pack view
+	# and gives us a synchronization point.
+	cat tree-a-input >&9 &&
+	echo >&9 &&
+	read tree_a <&8 &&
+
+	# Reproduce the transient state a concurrent repack creates: a
+	# replacement pack holding every object, plus the original pack for b
+	# with its .idx removed but its .pack still present.
+	git cat-file --batch-all-objects --batch-check="%(objectname)" >all-oids &&
+	git pack-objects .git/objects/pack/pack <all-oids >/dev/null &&
+	rm -f "$victim.idx" &&
+	test_path_is_file "$victim.pack" &&
+
+	# The reader (stale pack list) now resolves b.  Without the recovery its
+	# QUICK lookup reports b missing and mktree dies; with it, b is found in
+	# the replacement pack and the misleading "index unavailable" error is
+	# not printed.
+	cat tree-b-input >&9 &&
+	echo >&9 &&
+	read tree_b <&8 &&
+	exec 9>&- &&
+
+	test -n "$tree_b" &&
+	test_grep ! "index unavailable" err
+'
+
+test_expect_success 'setup a second repo with plain (non-midx) packs' '
+	git init nomidx &&
+	(
+		cd nomidx &&
+		test_commit seed &&
+		a=$(echo A | git hash-object -w --stdin) &&
+		b=$(echo B | git hash-object -w --stdin) &&
+		echo "$a" | git pack-objects .git/objects/pack/pack >pack-a &&
+		echo "$b" | git pack-objects .git/objects/pack/pack >pack-b &&
+		git prune-packed &&
+
+		printf "100644 blob %s\ta\n" "$a" >tree-a-input &&
+		printf "100644 blob %s\tb\n" "$b" >tree-b-input
+	)
+'
+
+test_expect_success PIPE 'QUICK reader recovers when a mapped pack loses its .pack mid-lookup' '
+	(
+		cd nomidx &&
+		victim=".git/objects/pack/pack-$(cat pack-b)" &&
+		mkfifo in out &&
+
+		# We run in a subshell, so leaving the fifos and the reader
+		# descriptors open is harmless: they are cleaned up when the
+		# subshell exits (which also lets "git mktree --batch" see EOF
+		# and quit).
+		(git mktree --batch <in >out 2>err &) &&
+		exec 9>in &&
+		exec 8<out &&
+
+		# Resolving the first tree makes the reader prepare its pack
+		# list.  With no multi-pack-index, that scan mmaps every
+		# pack.idx -- including the one for b -- but only opens the
+		# pack.pack it actually reads (the one for a).  b is now in the
+		# exact state we want: its .idx is mapped while its .pack is
+		# still unopened.
+		cat tree-a-input >&9 &&
+		echo >&9 &&
+		read tree_a <&8 &&
+
+		# A concurrent repack writes a replacement pack holding every
+		# object and removes the now-redundant pack for b.  Delete only
+		# its .pack: the reader keeps the mapped .idx for b, so
+		# open_pack_index() still succeeds and the failure surfaces when
+		# we open the vanished .pack.
+		git cat-file --batch-all-objects --batch-check="%(objectname)" >all-oids &&
+		git pack-objects .git/objects/pack/pack <all-oids >/dev/null &&
+		rm -f "$victim.pack" &&
+		test_path_is_file "$victim.idx" &&
+
+		# The reader (stale pack list) now resolves b.  Without the
+		# recovery its QUICK lookup opens the missing .pack, gives up,
+		# and mktree dies; with it, the vanished .pack forces a reprepare
+		# and b is found in the replacement pack.
+		cat tree-b-input >&9 &&
+		echo >&9 &&
+		read tree_b <&8 &&
+		exec 9>&- &&
+
+		test -n "$tree_b"
+	)
+'
+
+test_done
-- 
gitgitgadget

