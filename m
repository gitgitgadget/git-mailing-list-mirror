Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B67537FF5A
	for <git@vger.kernel.org>; Sat, 29 Aug 2026 07:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787986840; cv=none; b=PvxDn0yX4OexTyV5R9dQ0VvLJ7aFvW2r3C+uAje8H0iIljSoBxvePHfPJY2f3l6/9KstRWciy2HKzCmHklhVms9qe6dsTvirr3zdlovn2Z9iC83MXZYVlayEhJjhmhhtNBgQsyLWnvmcuyYdcwF9OHPPjfrzlFW/ZilhZbLhqSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787986840; c=relaxed/simple;
	bh=Ax6umax5PhJSzzhPzi/bjD9yrhrNx94VA36skrj5pkk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=i0iPAi1lGh0xlmWlWjqpDd0tlqfDlAHi/wz7NRmG+YR6pqTvyaaakGcSNp5BsLh/5VDkEFMSfL2zh+r4G6CXMlymVTXHS2/ZyBauUgSPN4R0kXJbPWqVCdu5EiMCkmMk7jHYmyu9xsgM6R3ju+mCI5JpV5O3yNdTDFCF0OJUdyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0thpBSM; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0thpBSM"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7f434cc1c5eso1721517a34.0
        for <git@vger.kernel.org>; Sat, 29 Aug 2026 00:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787986834; x=1788591634; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VLNNYExmuuMHK8wlH8pB7IMDvb4MXtKq2yWb47Ghk+A=;
        b=e0thpBSMYYc4lZMSjE0pZZQd3PucXpeDpBskByNpGsfHQ/QL6mxwXM4/6wr9F5xKmJ
         pB1W4M/Bzj7YIbl3dVfOoCm/MA+l3IFbb+Pt7Yva5jmICii/hY85nYs5nUMHbtk/BNLa
         ElYg8rkpFvB53YXodnKuf0SXFW2hWCGdXJfqpo/AtY/SrZFkPFxNKPq43upICkGAiYj/
         B0DdU8G2BNJv2zDT2IxwDljlFngZlRlMQOFz6tDvrEvk0fo5LaP+rjozX54aaPl3OpIC
         mJc/Z7+aa3Il0nfaa0tedYYuzpGeGj0IC9UumR/EtWWgZnaf8Iiixq1nbzcBEgYwHBWT
         PtsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787986834; x=1788591634;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VLNNYExmuuMHK8wlH8pB7IMDvb4MXtKq2yWb47Ghk+A=;
        b=bTPzOFjxojJjzhBSuzoI7P6XNtyY9V0X/0FlAQhKtmoNRysRLxEZfvyhr/k+Orm5mU
         cFZgVl9dN6SaG+aDg5MWXSirnibM150fRobBX5IFqrNpeh8xOE+5xYErG7cg2Vg8mSy2
         JJAM/+uY00Hoe7e9qhh5Oh/FXBQ5ut+AIQFJy3OUjT30+RLKGazndZJLF0QzKPnWSDqS
         ZZpuU/F3OFv51pYoLfVyaVpOmhGs8mZwT81k3UH4kmZk9ku3hk8F7hwzjfKIprX5t9dv
         uIL38yXZO4YgCfAS+SuFjkec/baM944yuimfyg/SdmDUhC/a+gyl9/HsCiApqDLYpTkf
         OCRQ==
X-Gm-Message-State: AFuF++kryZ8B2TkcvMPVCznBQU5Bfi+92i5YiPqXfSmVIK0BcHt1quXM
	zpJKgM3r+YuRTeVH5XVbmXW3yV4d3DfnGa9nGVQrJ3L3gKwyaTpk/GTYvtr6Y+Tk
X-Gm-Gg: AR+sD1189ceTrkUgc9TF5O4Ghz3HB0NtJqkENq36N/5Zpp/fqXJJ/kEKlrrooBKP56G
	E+gtL5BdRPY23lDcK7OR+i3MeN9EWWC28E/tQKKjnZ9Bk3kBa5GTYRof1o4PiQpf/klug/I8QrH
	oBNh8+06PJU5t6dUKKywh28zi/yR2ivZdxhXkmM3F53yih6ZkhMlye4YlmomUApZjhCEZ2kO3/h
	hEktNbZ6vxUxVITioAZc00RXyWUm/4Oq0qc24RYpdujzJcNzF/UYVQtyEEQrKu5v7Da1xZHvSTF
	CiywMzkG04vL/XA21j+iEhvDnu4PXVaaSaiWSqpcDlHK2ZpaEXvk/8cBvvA0RcDvWwk/VxMDJT5
	4D2d7V7GqSDgbBbMHEo6Tt0w4CPCcDeGnberzQnKZfGgey/7pCvmThuSeK7n99dy6UpSkfHNb8w
	xxvF7O/nyeJZsBPxZvcRF/IW/40aUNiX/wVWm+k+oWURE3WgA/qoM4LvfBCsEuHw==
X-Received: by 2002:a4a:d107:0:b0:6ac:a9c6:92c with SMTP id 006d021491bc7-6b1c6437790mr9365010eaf.10.1787986834018;
        Sat, 29 Aug 2026 00:00:34 -0700 (PDT)
Received: from [127.0.0.1] ([52.154.5.228])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b1ce35c529sm3589185eaf.13.2026.08.29.00.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 00:00:32 -0700 (PDT)
Message-Id: <pull.2207.v3.git.1787986831.gitgitgadget@gmail.com>
In-Reply-To: <pull.2207.git.1787092446.gitgitgadget@gmail.com>
References: <pull.2207.git.1787092446.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 29 Aug 2026 07:00:27 +0000
Subject: [PATCH v3 0/4] Objects treated as missing despite being present, due to race with geometric
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

Changes since v2:

 * Ripped out the old 3/4 dealing with QUICK readers; QUICK readers are left
   alone
 * Insert a new 3/4 fixing git mktree --batch to stop passing QUICK (with
   new testcase in t1010)
 * undo bad paragraph comment change
 * renamed fill_midx_entry() -> midx_fill_entry(), so that we catch any
   other new callers and appropriately check their return value (caught one
   in test-read-midx.c)

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

We also fix git mktree --batch to no longer erroneously pass QUICK.

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
  mktree: do not use OBJECT_INFO_QUICK when checking objects
  packfile: recover when a multi-pack-index names a removed pack

 builtin/mktree.c            |  4 +++-
 builtin/pack-objects.c      |  2 +-
 midx.c                      | 20 ++++++++--------
 midx.h                      | 21 ++++++++++++++--
 odb/source-packed.c         | 42 ++++++++++++++++++++++++++++----
 replay.c                    |  7 ++++++
 t/helper/test-read-midx.c   |  2 +-
 t/t1010-mktree.sh           | 48 +++++++++++++++++++++++++++++++++++++
 t/t3650-replay-basics.sh    | 34 ++++++++++++++++++++++++++
 t/t5319-multi-pack-index.sh | 40 +++++++++++++++++++++++++++++++
 10 files changed, 200 insertions(+), 20 deletions(-)


base-commit: 2135b14863642bbcec02996e7f5e54ac1f77b03a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2207%2Fnewren%2Fmidx-removed-pack-recovery-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2207/newren/midx-removed-pack-recovery-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2207

Range-diff vs v2:

 1:  36bf2ce17b = 1:  36bf2ce17b replay: fail gracefully when a merge input is unreadable
 2:  3f3b75690e = 2:  3f3b75690e mktree: plug per-tree leak in --batch mode
 3:  fc98f48ddb < -:  ---------- packfile: recover object lookups racing a concurrent repack
 -:  ---------- > 3:  79ce753c68 mktree: do not use OBJECT_INFO_QUICK when checking objects
 4:  eacf6ba4b1 ! 4:  9b0966df9a packfile: recover when a multi-pack-index names a removed pack
     @@ Commit message
          previous MIDX keeps seeing a removed pack listed as the owner of some
          objects.  Since a MIDX attributes each object to exactly one pack, such
          an object is served only through its recorded owner; if that owner was
     -    just removed, find_pack_entry() cannot serve it -- fill_midx_entry()
     -    routes to the missing pack, and the regular pack fallback deliberately
     -    skips every MIDX-covered pack, so a surviving copy in another covered
     -    pack (e.g. a kept base pack) is never consulted.
     +    just removed, find_pack_entry() cannot serve it -- the MIDX lookup routes
     +    to the missing pack, and the regular pack fallback deliberately skips
     +    every MIDX-covered pack, so a surviving copy in another covered pack
     +    (e.g. a kept base pack) is never consulted.
      
          Unlike the ordinary "a pack's .idx is mapped but its .pack is gone"
     -    race, the second read does not rescue us -- and not only for
     -    OBJECT_INFO_QUICK callers.  Reloading the on-disk pack set does not
     -    reload the borrowed, cached MIDX (freeing it under the code that caches
     -    the "struct multi_pack_index *" would be a use-after-free), so the stale
     -    MIDX keeps routing to the removed pack and the surviving copy stays
     +    race, the second read does not rescue us.  Reloading the on-disk pack set
     +    does not reload the borrowed, cached MIDX (freeing it under the code that
     +    caches the "struct multi_pack_index *" would be a use-after-free), so the
     +    stale MIDX keeps routing to the removed pack and the surviving copy stays
          hidden behind the covered-pack skip.  cat-file, rev-list and pack-objects
          can thus all spuriously fail with "unable to read object".
      
     -    Teach find_pack_entry() to recover.  fill_midx_entry() now returns a
     -    tri-state, distinguishing "absent from the MIDX" from "present but the
     -    owning pack is unavailable"; in the latter case, once the regular
     -    fallback has also missed, scan the MIDX's packs directly for a surviving
     -    copy.
     +    Teach find_pack_entry() to recover.  The MIDX lookup now returns a
     +    tri-state, distinguishing an object absent from the MIDX from one it owns
     +    via a pack that can no longer be opened; in the latter case, once the
     +    regular fallback has also missed, scan the MIDX's packs directly for a
     +    surviving copy.  Because the return value is no longer a boolean, rename
     +    fill_midx_entry() to midx_fill_entry() so callers must reckon with the
     +    new enum rather than silently treat MIDX_FILL_OWNER_UNAVAILABLE as a hit.
      
          Do the scan only on the second read (OBJECT_INFO_SECOND_READ): by then
          the cheaper on-disk reload has run, so an object merely relocated into a
     -    new (non-covered) pack has already been found by the regular fallback,
     -    and only a genuine hidden duplicate reaches the rescan.  QUICK callers
     -    that would skip the second read are steered into it by the preceding
     -    commit's stale_packs_detected flag, which prepare_midx_pack() sets when
     -    it cannot open the owning pack.
     +    new (uncovered) pack has already been found by the regular fallback, and
     +    only a genuine hidden duplicate reaches the rescan.  A QUICK caller that
     +    skips the second read simply accepts the false negative, as QUICK is
     +    designed to.
      
          Reloading the stale MIDX would be a more complete fix but is much more
          involved (the borrowers above need proper invalidation), so leave that
     @@ builtin/pack-objects.c: static int want_object_in_pack_mtime(const struct object
       		struct pack_entry e;
       
      -		if (m && fill_midx_entry(m, oid, &e, NULL)) {
     -+		if (m && fill_midx_entry(m, oid, &e, NULL) == MIDX_FILL_HIT) {
     ++		if (m && midx_fill_entry(m, oid, &e, NULL) == MIDX_FILL_HIT) {
       			want = want_object_in_pack_one(e.p, oid, exclude, found_pack, found_offset, found_mtime);
       			if (want != -1)
       				return want;
     @@ midx.c: uint32_t nth_midxed_pack_int_id(struct multi_pack_index *m, uint32_t pos
      -		    const struct object_id *oid,
      -		    struct pack_entry *e,
      -		    struct packed_git **bad_pack)
     -+enum midx_fill_result fill_midx_entry(struct multi_pack_index *m,
     ++enum midx_fill_result midx_fill_entry(struct multi_pack_index *m,
      +				      const struct object_id *oid,
      +				      struct pack_entry *e,
      +				      struct packed_git **bad_pack)
     @@ midx.c: uint32_t nth_midxed_pack_int_id(struct multi_pack_index *m, uint32_t pos
       
       	if (prepare_midx_pack(m, pack_int_id))
      -		return 0;
     -+		goto owner_unavailable;
     ++		return MIDX_FILL_OWNER_UNAVAILABLE;
       	p = m->packs[pack_int_id - m->num_packs_in_base];
       
     --	/*
     --	* We are about to tell the caller where they can locate the
     --	* requested object.  We better make sure the packfile is
     --	* still here and can be accessed before supplying that
     --	* answer, as it may have been deleted since the MIDX was
     --	* loaded!
     --	*/
     -+	/* Make sure the pack is still present before pointing at it. */
     + 	/*
     +@@ midx.c: int fill_midx_entry(struct multi_pack_index *m,
     + 	* loaded!
     + 	*/
       	if (!is_pack_valid(p))
      -		return 0;
     -+		goto owner_unavailable;
     ++		return MIDX_FILL_OWNER_UNAVAILABLE;
       
       	if (oidset_size(&p->bad_objects) &&
       	    oidset_contains(&p->bad_objects, oid)) {
     @@ midx.c: uint32_t nth_midxed_pack_int_id(struct multi_pack_index *m, uint32_t pos
       
      -	return 1;
      +	return MIDX_FILL_HIT;
     -+
     -+owner_unavailable:
     -+	/*
     -+	 * Re-arm stale_packs_detected on every such lookup, not just the
     -+	 * first: prepare_midx_pack() caches the failure, so without this a
     -+	 * later lookup of the same vanished pack would leave the flag clear
     -+	 * and a QUICK reader would skip its recovering second read.
     -+	 */
     -+	m->source->base.odb->stale_packs_detected = 1;
     -+	return MIDX_FILL_OWNER_UNAVAILABLE;
       }
       
       /* Match "foo.idx" against either "foo.pack" _or_ "foo.idx". */
     @@ midx.c: int verify_midx_file(struct odb_source_packed *source, unsigned flags)
       		nth_midxed_object_oid(&oid, m, pairs[i].pos);
       
      -		if (!fill_midx_entry(m, &oid, &e, NULL)) {
     -+		if (fill_midx_entry(m, &oid, &e, NULL) != MIDX_FILL_HIT) {
     ++		if (midx_fill_entry(m, &oid, &e, NULL) != MIDX_FILL_HIT) {
       			midx_report(_("failed to load pack entry for oid[%d] = %s"),
       				    pairs[i].pos, oid_to_hex(&oid));
       			continue;
     @@ midx.h: uint32_t nth_midxed_pack_int_id(struct multi_pack_index *m, uint32_t pos
      +	MIDX_FILL_OWNER_UNAVAILABLE,
      +};
      +
     -+enum midx_fill_result fill_midx_entry(struct multi_pack_index *m,
     ++enum midx_fill_result midx_fill_entry(struct multi_pack_index *m,
      +				      const struct object_id *oid,
      +				      struct pack_entry *e,
      +				      struct packed_git **bad_pack);
     @@ odb/source-packed.c
      -	if (store->midx && fill_midx_entry(store->midx, oid, e, bad_pack))
      -		return 1;
      +	if (store->midx) {
     -+		midx_result = fill_midx_entry(store->midx, oid, e, bad_pack);
     ++		midx_result = midx_fill_entry(store->midx, oid, e, bad_pack);
      +		if (midx_result == MIDX_FILL_HIT)
      +			return 1;
      +	}
     @@ odb/source-packed.c: static int odb_source_packed_freshen_object(struct odb_sour
       	if (e.p->is_cruft)
       		return 0;
      
     + ## t/helper/test-read-midx.c ##
     +@@ t/helper/test-read-midx.c: static int read_midx_file(const char *object_dir, const char *checksum,
     + 		for (i = 0; i < m->num_objects; i++) {
     + 			nth_midxed_object_oid(&oid, m,
     + 					      i + m->num_objects_in_base);
     +-			fill_midx_entry(m, &oid, &e, NULL);
     ++			midx_fill_entry(m, &oid, &e, NULL);
     + 
     + 			printf("%s %"PRIu64"\t%s\n",
     + 			       oid_to_hex(&oid), e.offset, e.p->pack_name);
     +
       ## t/t5319-multi-pack-index.sh ##
      @@ t/t5319-multi-pack-index.sh: test_expect_success 'pack.preferBitmapTips interprets patterns as hierarchy' '
       	)
     @@ t/t5319-multi-pack-index.sh: test_expect_success 'pack.preferBitmapTips interpre
      +		test_cmp expect actual
      +	)
      +'
     -+
     -+test_expect_success 'repeated QUICK lookups recover after owning pack removed' '
     -+	test_when_finished "rm -fr repo" &&
     -+	git init repo &&
     -+	(
     -+		cd repo &&
     -+
     -+		# Two blobs, each duplicated across packs so the midx must pick
     -+		# an owning pack, and each attributed to the same moderate pack.
     -+		echo one >f1 &&
     -+		echo two >f2 &&
     -+		git add f1 f2 &&
     -+		git commit -m dups &&
     -+		d1=$(git rev-parse HEAD:f1) &&
     -+		d2=$(git rev-parse HEAD:f2) &&
     -+
     -+		# Roll every object, including d1 and d2, into one big pack,
     -+		# then build a moderate pack that also holds both blobs.
     -+		git repack -adq &&
     -+		moderate=$(printf "%s\n%s\n" "$d1" "$d2" |
     -+			git pack-objects --quiet $objdir/pack/pack) &&
     -+
     -+		git multi-pack-index write \
     -+			--preferred-pack="pack-$moderate.idx" &&
     -+
     -+		# Retire the moderate pack; the stale midx still names it as the
     -+		# owner of both blobs, each of which survives in the big pack.
     -+		rm -f $objdir/pack/pack-$moderate.* &&
     -+
     -+		# One resident QUICK reader ("git mktree --batch") resolves both
     -+		# blobs.  The first lookup recovers d1 and caches the owning
     -+		# packs failure; unless that failure keeps re-arming the second
     -+		# read, the lookup of d2 skips its recovering read and the reader
     -+		# dies reporting d2 as missing.
     -+		printf "100644 blob %s\tf1\n\n100644 blob %s\tf2\n\n" \
     -+			"$d1" "$d2" |
     -+			git mktree --batch >trees &&
     -+		test_line_count = 2 trees
     -+	)
     -+'
      +
       test_done

-- 
gitgitgadget
