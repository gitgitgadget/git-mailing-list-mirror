Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D363E3C8713
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 19:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787684459; cv=none; b=G5ZKAcLELBYAd5wrxBUBBPtbRU13X3nUxoN95A1RxzDa1qBQYCfqlKKtcLxB4ZzQRtJoXlFN/8FwLp8AdCGSC7zPJ3iUSjuzuQDuwbsOFP4W52Bfv/95V3LazzwDvzwPwA7dHmJmDAr4P3ILzxh4Ce7iOwRLsCFWwBx/jOlCB74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787684459; c=relaxed/simple;
	bh=SDQTgvbGyegb2eY6Tts8PyGXm0oyF+78/5bKpUThXHs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=b3KvHPxsHL82LYLMQKXWOn9cdClKAsbkpzyBlFrgcDY1EVxrbIgCo0KGNtiXjaTFfsb2nJXgu+fp3VOKU876ys5a3XxOoOoPjzrx+JSxMuHudS3GgqNds9Qz/NMlTF4sC0I/K7eZnBytz9p+SLVmRQ1B23AHbV93+iuqRE4uPYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7FVLcIu; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7FVLcIu"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92ed19f4d60so10081085a.0
        for <git@vger.kernel.org>; Tue, 25 Aug 2026 12:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787684432; x=1788289232; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2z1spV+sFNSnmklvl2NZ55YGNPndv6H7cp0SP5P4W3g=;
        b=V7FVLcIuKpw6e2I25oLfhU05kBg4rJCgT4i7AeMCtP/4HkoUHIquBKVvxh/zuemtea
         tzsYP1ygfrwRyKzLOEEVcqTV0VTGTO0TgUvFTt1YPqX5l8Cy3QOhaS/Yo15z7v0ZOg3w
         xehUX3Dq694QrDK4uAFOi77TBTD5zTVKN0R1X3TJtAT2+kLq/b1e7uomstpilyIevW9F
         vNL18b+BlQI13ct0r2ZqU35LK85O8/byiIsx6hb9+OUapR6Od9V+gMMwpYWVORr+UlCd
         VDhpGUmO682q6q8BZn1hCd7Bw+WjvBPwKwbyw8047X5vLqRBhtg9X9gog8BxObmD7nce
         oqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787684432; x=1788289232;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2z1spV+sFNSnmklvl2NZ55YGNPndv6H7cp0SP5P4W3g=;
        b=dqAS7AZYVW3UOR0qJKFXwINwea/bstFN/YdSb9+k7zRneinUoPlkr05DKAVSdMigPV
         OZU+o382TUqSnxdpaGHxcXJRpatcwTzwiD+vz8Rd7QRd7VSmSg+XqzdDwOmFT09EpAXS
         NIsms/TLLj+3zZai7Ihau7LqFthy5+fEJ3MMvfUiywAUTh5VI93eNqLV9LsfQOtKQtw9
         cJHcLAr62F31X/Q2un1/bMTqkskm82/9Iys6dzXdFFQ1gjXjJr7Y3SAE3xoIP+VEOfcw
         Z6+XurF2TDxt82xIw/75MUIgE2lJCQmbTBnpSRdUkPhEtFXm7EFAvD0/0EekvgYXUaUB
         6B8Q==
X-Gm-Message-State: AFuF++lJlj4dUrdarzDBKLJUhfCDeG7Sss12zog8F54j9aPs3a1EQ+YS
	aH5KFbhSNvASlRNKPvfLolwnxBpJFITpm/iR09kJZkNrj0ANbF3AFO790kFXWw==
X-Gm-Gg: AR+sD12UxnhuMmh2sNFIOnC9hZNticdixtW3218YyskjCgar2L05dsQE9vD+m0Dl8s1
	WkIQraDSKCqoeB3QqQh8v62us/NcNp7uDlBDUZHi/kov77gA4OUYH3HWGL+kYFO8KXEjc3q9/9Y
	S+u/ZOyiDknzW/6yiA+1hEnn9B2bCbQnxTDvlGywhmkCz3ACh+WWTuAX01dNGYoV1gntDy3VuEC
	dOUtWKtxrb6ylLUiZh0KCq1gsLpXkfBIj5017Nmf8o+PhK7l809s95NLm3JL42n575rILleearR
	kdd2RTyU9isbjAR+aL2SyhrB4//vAqJJv+Tu3bvIpYP8Bf4PKjxKdI3v63Xw3R8H91WpMSa7QOm
	7MlN/avRn4IJMsbgmT17svJNndRSW+O9ld3a1GAJ7L8PmmoJFy8Mxht+sPgu9saOt1xgMOjiIv7
	yjlqB1zudKh/fvOndnuqBrGMiovMZ5iMvtXhkJ7Dpm/uTeNb/luHO5De+wFUz/xHaJ
X-Received: by 2002:a05:620a:438d:b0:92e:fed1:beba with SMTP id af79cd13be357-9377e7975f9mr171228785a.3.1787684431062;
        Tue, 25 Aug 2026 12:00:31 -0700 (PDT)
Received: from [127.0.0.1] ([20.127.245.161])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9377e680524sm40551385a.40.2026.08.25.12.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 12:00:30 -0700 (PDT)
Message-Id: <pull.2207.v2.git.1787684429.gitgitgadget@gmail.com>
In-Reply-To: <pull.2207.git.1787092446.gitgitgadget@gmail.com>
References: <pull.2207.git.1787092446.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 25 Aug 2026 19:00:25 +0000
Subject: [PATCH v2 0/4] Objects treated as missing despite being present, due to race with geometric
 repacking
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
    Elijah Newren <newren@gmail.com>

Changes since v1:

 * Rebased on top of ps/odb-generic-corrupt-objects, and conflicts with it
   resolved
 * Removed useless test_grep line spotted by Junio in PATCH 1
 * Switched fill_midx_entry() to a tri-state to avoid duplicate
   bsearch_midx(), as suggested by Peff
 * Only do the re-read on SECOND_READ, as suggested by Peff
 * Handle multiple objects shared across multiple packs correctly (issue
   caught & corrected & new testcase by deeper AI review)
 * Inserted two new patches:
   * 2/4: Fix a leak in git mktree --batch since I use it in new testcases
     and don't want the *-leaks jobs failing
   * 3/4: Demonstrate and fix QUICK reader problems, while keeping expected
     QUICK performance for normal cases (we've already been discussing this
     patch in this thread a bunch anyway, and it's logically related)

Cover letter addendum/update:

A geometric repack writes a new pack plus multi-pack-index and then deletes
the packs the new one subsumes. Readers running alongside it can be told an
object is missing when it is in fact still present. The v1 series fixed one
race of this shape (the object didn't move and was in a second pack
referenced by the multi-pack-index); v2 added a new patch fixing others in
the same class but of a different shape (the object moved to a brand new
pack).

Note here that Stolee's suggestion to defer pack deletion via git
multi-pack-index expire seems like a good complementary mitigation; it would
reduce how often we fall into recovery, while this series tries to fix
recovery to work more robustly.

Original cover letter (focused on the final patch):

When an object is found in multiple packs that are in a multi-pack-index,
and a subsequent geometric repacking creates a new multi-pack-index and
removes the pack that was considered the owner of the object in the old
multi-pack-index, then an already-running process that had opened the old
multi-pack-index and hadn't yet opened the removed packfile will not be able
to access the object -- lookups will return it as missing. Additionally,
replay has a separate bug where a missing object causes a SIGSEGV rather
than an error message.

This appears to affect a very small percentage of git operations in
production since it is a tiny window, but I've found evidence of it
occurring in at least eight distinct server-side operations, covering seven
different git commands:

git operation                        symptom
-----------------------------------  -----------------------------
git replay (server-side rebase)      SIGSEGV (this series, 1/2)
git merge-tree                       spurious read-miss failure
git diff (raw and tree-vs-tree)      spurious read-miss failure
git rev-list --count                 spurious read-miss failure
git merge-base                       spurious read-miss failure
object/rev resolution (rev-parse,    spurious read-miss failure
  cat-file)
repository repair (fsck/repack)      spurious read-miss failure


There are also commands that could be changing behavior without throwing an
error -- e.g. object negotiation thinking an object doesn't exist and
instead negotiating based on an older common commit, or cat-file --batch
reporting that some objects don't exist.

This series fixes the replay bug first, since it's simpler; investigating
it, together with my other recent repacking work, is what led me to the
underlying multi-pack-index issue that 2/2 addresses.

Elijah Newren (4):
  replay: fail gracefully when a merge input is unreadable
  mktree: plug per-tree leak in --batch mode
  packfile: recover object lookups racing a concurrent repack
  packfile: recover when a multi-pack-index names a removed pack

 builtin/mktree.c              |   3 +
 builtin/pack-objects.c        |   2 +-
 midx.c                        |  44 ++++++----
 midx.h                        |  21 ++++-
 odb.c                         |   8 +-
 odb.h                         |  16 +++-
 odb/source-packed.c           |  51 ++++++++++--
 packfile.c                    |  39 ++++++++-
 replay.c                      |   7 ++
 t/meson.build                 |   1 +
 t/t3650-replay-basics.sh      |  34 ++++++++
 t/t5319-multi-pack-index.sh   |  80 ++++++++++++++++++
 t/t5336-repack-reader-race.sh | 148 ++++++++++++++++++++++++++++++++++
 13 files changed, 423 insertions(+), 31 deletions(-)
 create mode 100755 t/t5336-repack-reader-race.sh


base-commit: 2135b14863642bbcec02996e7f5e54ac1f77b03a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2207%2Fnewren%2Fmidx-removed-pack-recovery-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2207/newren/midx-removed-pack-recovery-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2207

Range-diff vs v1:

 1:  321af575e0 ! 1:  36bf2ce17b replay: fail gracefully when a merge input is unreadable
     @@ t/t3650-replay-basics.sh: test_expect_success '--onto with --ref rejects multipl
      +
      +		# Ensure replay gracefully handles the missing object
      +		test_must_fail git replay --onto onto base..side 2>err &&
     -+		test_grep ! "[Ss]egmentation" err &&
     -+		test_grep "Could not read\|collecting merge info failed" err
     ++		test_grep -e "Could not read" -e "collecting merge info failed" err
      +	)
      +'
      +
 -:  ---------- > 2:  3f3b75690e mktree: plug per-tree leak in --batch mode
 -:  ---------- > 3:  fc98f48ddb packfile: recover object lookups racing a concurrent repack
 2:  5792c08f4e ! 4:  eacf6ba4b1 packfile: recover when a multi-pack-index names a removed pack
     @@ Metadata
       ## Commit message ##
          packfile: recover when a multi-pack-index names a removed pack
      
     -    When a geometric repack runs concurrently with other git processes, it
     -    can write a new pack and multi-pack-index and then delete older packs
     -    that the new one subsumes.  One or more of those older packs may have
     -    been indexed by the previous multi-pack-index.  A process that already
     -    had the previous multi-pack-index open keeps using it, and that stale
     -    index still records the removed pack(s) as owning some objects.
     +    A geometric repack writes a new pack and multi-pack-index and then
     +    deletes the packs the new one subsumes.  A process still using the
     +    previous MIDX keeps seeing a removed pack listed as the owner of some
     +    objects.  Since a MIDX attributes each object to exactly one pack, such
     +    an object is served only through its recorded owner; if that owner was
     +    just removed, find_pack_entry() cannot serve it -- fill_midx_entry()
     +    routes to the missing pack, and the regular pack fallback deliberately
     +    skips every MIDX-covered pack, so a surviving copy in another covered
     +    pack (e.g. a kept base pack) is never consulted.
      
     -    Because a multi-pack-index attributes each object to exactly one pack,
     -    an object that exists in multiple covered packs is served only through
     -    its recorded owner.  If that owner is the pack a concurrent repack just
     -    removed, find_pack_entry() cannot serve the object: fill_midx_entry()
     -    routes the lookup to the missing pack (prepare_midx_pack() fails), and
     -    the regular pack fallback deliberately skips every multi-pack-index
     -    covered pack.  The object is reported missing even though a perfectly
     -    good copy survives in another covered pack -- for example a large "base"
     -    pack that geometric repacking intentionally kept.
     +    Unlike the ordinary "a pack's .idx is mapped but its .pack is gone"
     +    race, the second read does not rescue us -- and not only for
     +    OBJECT_INFO_QUICK callers.  Reloading the on-disk pack set does not
     +    reload the borrowed, cached MIDX (freeing it under the code that caches
     +    the "struct multi_pack_index *" would be a use-after-free), so the stale
     +    MIDX keeps routing to the removed pack and the surviving copy stays
     +    hidden behind the covered-pack skip.  cat-file, rev-list and pack-objects
     +    can thus all spuriously fail with "unable to read object".
      
     -    The false negative is not limited to one caller.  Any reader
     -    (cat-file, rev-list, pack-objects, ...) can spuriously fail with
     -    "unable to read object", and callers that only ask whether an object
     -    exists get a wrong answer too, since the OBJECT_INFO_QUICK path never
     -    retries.  Writers that merge in-core, such as "git replay", are hit
     -    hardest: merge-ort treats the unreadable tree as a premature abort, sets
     -    result.clean < 0, and returns without a result tree.
     +    Teach find_pack_entry() to recover.  fill_midx_entry() now returns a
     +    tri-state, distinguishing "absent from the MIDX" from "present but the
     +    owning pack is unavailable"; in the latter case, once the regular
     +    fallback has also missed, scan the MIDX's packs directly for a surviving
     +    copy.
      
     -    Teach find_pack_entry() to recover.  After the normal multi-pack-index
     -    lookup and the regular pack fallback both miss, check whether the object
     -    is nonetheless present in a covered multi-pack-index (bsearch_midx()).
     -    If it is, its recorded owner must have become unavailable, so scan that
     -    index's packs directly for a surviving copy.  The bsearch gate keeps
     -    genuine misses (i.e. objects absent from the index) on the fast path, and
     -    because the recovery lives in find_pack_entry() itself it also fixes the
     -    OBJECT_INFO_QUICK callers that never reprepare.
     +    Do the scan only on the second read (OBJECT_INFO_SECOND_READ): by then
     +    the cheaper on-disk reload has run, so an object merely relocated into a
     +    new (non-covered) pack has already been found by the regular fallback,
     +    and only a genuine hidden duplicate reaches the rescan.  QUICK callers
     +    that would skip the second read are steered into it by the preceding
     +    commit's stale_packs_detected flag, which prepare_midx_pack() sets when
     +    it cannot open the owning pack.
      
     -    This recovers the object without touching the multi-pack-index itself.
     -    Reloading the stale index would be a more complete fix but would be much
     -    more involved: other code (pack bitmaps, object name disambiguation)
     -    borrows and caches the "struct multi_pack_index *" across object reads,
     -    so freeing it underneath them would be a use-after-free.  Refreshing the
     -    index with proper invalidation of those borrowers is left for future
     -    work.
     +    Reloading the stale MIDX would be a more complete fix but is much more
     +    involved (the borrowers above need proper invalidation), so leave that
     +    for later.
      
     +    Assisted-by: Claude Opus 4.8 & GPT-5.6 Sol
     +    Helped-by: Jeff King <peff@peff.net>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     + ## builtin/pack-objects.c ##
     +@@ builtin/pack-objects.c: static int want_object_in_pack_mtime(const struct object_id *oid,
     + 		struct multi_pack_index *m = get_multi_pack_index(files->packed);
     + 		struct pack_entry e;
     + 
     +-		if (m && fill_midx_entry(m, oid, &e, NULL)) {
     ++		if (m && fill_midx_entry(m, oid, &e, NULL) == MIDX_FILL_HIT) {
     + 			want = want_object_in_pack_one(e.p, oid, exclude, found_pack, found_offset, found_mtime);
     + 			if (want != -1)
     + 				return want;
     +
     + ## midx.c ##
     +@@ midx.c: uint32_t nth_midxed_pack_int_id(struct multi_pack_index *m, uint32_t pos)
     + 					       (off_t)pos * MIDX_CHUNK_OFFSET_WIDTH);
     + }
     + 
     +-int fill_midx_entry(struct multi_pack_index *m,
     +-		    const struct object_id *oid,
     +-		    struct pack_entry *e,
     +-		    struct packed_git **bad_pack)
     ++enum midx_fill_result fill_midx_entry(struct multi_pack_index *m,
     ++				      const struct object_id *oid,
     ++				      struct pack_entry *e,
     ++				      struct packed_git **bad_pack)
     + {
     + 	uint32_t pos;
     + 	uint32_t pack_int_id;
     + 	struct packed_git *p;
     + 
     + 	if (!bsearch_midx(oid, m, &pos))
     +-		return 0;
     ++		return MIDX_FILL_MISS;
     + 
     + 	midx_for_object(&m, pos);
     + 	pack_int_id = nth_midxed_pack_int_id(m, pos);
     + 
     + 	if (prepare_midx_pack(m, pack_int_id))
     +-		return 0;
     ++		goto owner_unavailable;
     + 	p = m->packs[pack_int_id - m->num_packs_in_base];
     + 
     +-	/*
     +-	* We are about to tell the caller where they can locate the
     +-	* requested object.  We better make sure the packfile is
     +-	* still here and can be accessed before supplying that
     +-	* answer, as it may have been deleted since the MIDX was
     +-	* loaded!
     +-	*/
     ++	/* Make sure the pack is still present before pointing at it. */
     + 	if (!is_pack_valid(p))
     +-		return 0;
     ++		goto owner_unavailable;
     + 
     + 	if (oidset_size(&p->bad_objects) &&
     + 	    oidset_contains(&p->bad_objects, oid)) {
     + 		if (bad_pack && !*bad_pack)
     + 			*bad_pack = p;
     +-		return 0;
     ++		return MIDX_FILL_MISS;
     + 	}
     + 
     + 	e->offset = nth_midxed_offset(m, pos);
     + 	e->p = p;
     + 
     +-	return 1;
     ++	return MIDX_FILL_HIT;
     ++
     ++owner_unavailable:
     ++	/*
     ++	 * Re-arm stale_packs_detected on every such lookup, not just the
     ++	 * first: prepare_midx_pack() caches the failure, so without this a
     ++	 * later lookup of the same vanished pack would leave the flag clear
     ++	 * and a QUICK reader would skip its recovering second read.
     ++	 */
     ++	m->source->base.odb->stale_packs_detected = 1;
     ++	return MIDX_FILL_OWNER_UNAVAILABLE;
     + }
     + 
     + /* Match "foo.idx" against either "foo.pack" _or_ "foo.idx". */
     +@@ midx.c: int verify_midx_file(struct odb_source_packed *source, unsigned flags)
     + 
     + 		nth_midxed_object_oid(&oid, m, pairs[i].pos);
     + 
     +-		if (!fill_midx_entry(m, &oid, &e, NULL)) {
     ++		if (fill_midx_entry(m, &oid, &e, NULL) != MIDX_FILL_HIT) {
     + 			midx_report(_("failed to load pack entry for oid[%d] = %s"),
     + 				    pairs[i].pos, oid_to_hex(&oid));
     + 			continue;
     +
     + ## midx.h ##
     +@@ midx.h: uint32_t nth_midxed_pack_int_id(struct multi_pack_index *m, uint32_t pos);
     + struct object_id *nth_midxed_object_oid(struct object_id *oid,
     + 					struct multi_pack_index *m,
     + 					uint32_t n);
     +-int fill_midx_entry(struct multi_pack_index *m, const struct object_id *oid,
     +-		    struct pack_entry *e, struct packed_git **bad_pack);
     ++/*
     ++ * Result of looking an object up in a multi-pack-index.  MIDX_FILL_HIT means
     ++ * "e was filled in"; the two miss variants distinguish an object the midx does
     ++ * not know about (MIDX_FILL_MISS) from one it does know about but whose owning
     ++ * pack we can no longer open (MIDX_FILL_OWNER_UNAVAILABLE -- the signature of a
     ++ * concurrent repack having removed that pack).  A known-bad (corrupt) object
     ++ * reports MIDX_FILL_MISS but also sets *bad_pack, if provided, to the owning
     ++ * pack so the caller can tell "corrupt" apart from "absent".
     ++ */
     ++enum midx_fill_result {
     ++	MIDX_FILL_MISS = 0,
     ++	MIDX_FILL_HIT,
     ++	MIDX_FILL_OWNER_UNAVAILABLE,
     ++};
     ++
     ++enum midx_fill_result fill_midx_entry(struct multi_pack_index *m,
     ++				      const struct object_id *oid,
     ++				      struct pack_entry *e,
     ++				      struct packed_git **bad_pack);
     + int midx_contains_pack(struct multi_pack_index *m,
     + 		       const char *idx_or_pack_name);
     + int midx_layer_contains_pack(struct multi_pack_index *m,
     +
       ## odb/source-packed.c ##
     +@@
     + static int find_pack_entry(struct odb_source_packed *store,
     + 			   const struct object_id *oid,
     + 			   struct pack_entry *e,
     ++			   enum object_info_flags flags,
     + 			   struct packed_git **bad_pack)
     + {
     + 	struct packfile_list_entry *l;
     ++	enum midx_fill_result midx_result = MIDX_FILL_MISS;
     + 
     + 	odb_source_prepare(&store->base, 0);
     +-	if (store->midx && fill_midx_entry(store->midx, oid, e, bad_pack))
     +-		return 1;
     ++	if (store->midx) {
     ++		midx_result = fill_midx_entry(store->midx, oid, e, bad_pack);
     ++		if (midx_result == MIDX_FILL_HIT)
     ++			return 1;
     ++	}
     + 
     + 	for (l = store->packs.head; l; l = l->next) {
     + 		struct packed_git *p = l->pack;
      @@ odb/source-packed.c: static int find_pack_entry(struct odb_source_packed *store,
       		}
       	}
       
      +	/*
     -+	 * Recovery for a concurrent-repack race: a MIDX can name an owning
     -+	 * pack for an object that a simultaneous repack has since deleted,
     -+	 * even though the object still exists in another pack the same MIDX
     -+	 * covers (e.g. a kept base pack that geometric repack did not rewrite).
     -+	 * If the object is present in a MIDX yet none of the paths above could
     -+	 * serve it, its recorded owning pack has become unavailable.  The
     -+	 * regular fallback above deliberately skips MIDX-covered packs, so
     -+	 * scan this MIDX's packs directly to find the surviving copy.  The
     -+	 * bsearch gate keeps genuine misses (objects absent from the MIDX) on
     -+	 * the fast path.
     ++	 * Recovery for a concurrent-repack race: a stale MIDX may still name a
     ++	 * vanished owning pack even though the object survives in another pack
     ++	 * the same MIDX covers.  The regular fallback above skips MIDX-covered
     ++	 * packs, and repreparing the on-disk pack set does not reload the
     ++	 * borrowed, cached MIDX, so scan its packs directly for the survivor.
     ++	 *
     ++	 * Do this only on the second read, by which point repreparing packs has
     ++	 * already had a chance to find an object merely relocated into a new,
     ++	 * uncovered pack; only a genuine hidden duplicate reaches here.
      +	 */
     -+	if (store->midx) {
     ++	if (midx_result == MIDX_FILL_OWNER_UNAVAILABLE &&
     ++	    (flags & OBJECT_INFO_SECOND_READ)) {
      +		struct multi_pack_index *m = store->midx;
     -+		uint32_t midx_pos, i;
     -+
     -+		if (bsearch_midx(oid, m, &midx_pos)) {
     -+			for (i = 0; i < m->num_packs + m->num_packs_in_base; i++) {
     -+				struct packed_git *p;
     -+
     -+				if (prepare_midx_pack(m, i))
     -+					continue;
     -+				p = nth_midxed_pack(m, i);
     -+				if (p && packfile_fill_entry(p, oid, e))
     -+					return 1;
     -+			}
     ++		uint32_t i;
     ++
     ++		for (i = 0; i < m->num_packs + m->num_packs_in_base; i++) {
     ++			struct packed_git *p;
     ++
     ++			if (prepare_midx_pack(m, i))
     ++				continue;
     ++			p = nth_midxed_pack(m, i);
     ++			if (p && packfile_fill_entry(p, oid, e, bad_pack))
     ++				return 1;
      +		}
      +	}
      +
       	return 0;
       }
       
     +@@ odb/source-packed.c: static enum odb_read_status odb_source_packed_read_object_info(struct odb_source
     + 	if (flags & OBJECT_INFO_SECOND_READ)
     + 		odb_source_prepare(source, ODB_PREPARE_FLUSH_CACHES);
     + 
     +-	if (!find_pack_entry(packed, oid, &e, &bad_pack)) {
     ++	if (!find_pack_entry(packed, oid, &e, flags, &bad_pack)) {
     + 		/*
     + 		 * The lookup may have failed because the object is known to be
     + 		 * corrupt in one of the packfiles. Report the object as
     +@@ odb/source-packed.c: static int odb_source_packed_read_object_stream(struct odb_read_stream **out,
     + 	struct odb_source_packed *packed = odb_source_packed_downcast(source);
     + 	struct pack_entry e;
     + 
     +-	if (!find_pack_entry(packed, oid, &e, NULL))
     ++	if (!find_pack_entry(packed, oid, &e, 0, NULL))
     + 		return -1;
     + 
     + 	return packfile_read_object_stream(out, oid, e.p, e.offset);
     +@@ odb/source-packed.c: static int odb_source_packed_freshen_object(struct odb_source *source,
     + 		timesp = &times;
     + 	}
     + 
     +-	if (!find_pack_entry(packed, oid, &e, NULL))
     ++	if (!find_pack_entry(packed, oid, &e, 0, NULL))
     + 		return 0;
     + 	if (e.p->is_cruft)
     + 		return 0;
      
       ## t/t5319-multi-pack-index.sh ##
      @@ t/t5319-multi-pack-index.sh: test_expect_success 'pack.preferBitmapTips interprets patterns as hierarchy' '
     @@ t/t5319-multi-pack-index.sh: test_expect_success 'pack.preferBitmapTips interpre
      +		test_cmp expect actual
      +	)
      +'
     ++
     ++test_expect_success 'repeated QUICK lookups recover after owning pack removed' '
     ++	test_when_finished "rm -fr repo" &&
     ++	git init repo &&
     ++	(
     ++		cd repo &&
     ++
     ++		# Two blobs, each duplicated across packs so the midx must pick
     ++		# an owning pack, and each attributed to the same moderate pack.
     ++		echo one >f1 &&
     ++		echo two >f2 &&
     ++		git add f1 f2 &&
     ++		git commit -m dups &&
     ++		d1=$(git rev-parse HEAD:f1) &&
     ++		d2=$(git rev-parse HEAD:f2) &&
     ++
     ++		# Roll every object, including d1 and d2, into one big pack,
     ++		# then build a moderate pack that also holds both blobs.
     ++		git repack -adq &&
     ++		moderate=$(printf "%s\n%s\n" "$d1" "$d2" |
     ++			git pack-objects --quiet $objdir/pack/pack) &&
     ++
     ++		git multi-pack-index write \
     ++			--preferred-pack="pack-$moderate.idx" &&
     ++
     ++		# Retire the moderate pack; the stale midx still names it as the
     ++		# owner of both blobs, each of which survives in the big pack.
     ++		rm -f $objdir/pack/pack-$moderate.* &&
     ++
     ++		# One resident QUICK reader ("git mktree --batch") resolves both
     ++		# blobs.  The first lookup recovers d1 and caches the owning
     ++		# packs failure; unless that failure keeps re-arming the second
     ++		# read, the lookup of d2 skips its recovering read and the reader
     ++		# dies reporting d2 as missing.
     ++		printf "100644 blob %s\tf1\n\n100644 blob %s\tf2\n\n" \
     ++			"$d1" "$d2" |
     ++			git mktree --batch >trees &&
     ++		test_line_count = 2 trees
     ++	)
     ++'
      +
       test_done

-- 
gitgitgadget
