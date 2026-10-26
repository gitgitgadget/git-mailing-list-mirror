Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793005625;
	b=5LNCb4JhQGfu/9nB9yP/kqFle3PJvm/Tfb/kz3zFGWOlhzr70cblrX54vFC2AsDlzt17
	 A99B/z+sIWOrk13KDSKoff3EODeN6QCTuZgivLv6xZVH2DcSpjBl6QIdKzuk54zpIh6Yo
	 rzNsjHTYhU+AjnNMd0YvZ8h5u5iWUraNO7MuRcpqq06F82SkNMQ8lu16WldS63ZtA1gu6
	 4oYb5aOlo1hxhSMdtF9xuXkzgWzk+i8FSn72TEI0iRnUVc8RV1qq3qAEsYp4TPRGoxGbB
	 YtsVVJ1amFjbOPBADpKsdkTDIa/+iSLJ5FHEl8l7VWF4w+ASVbEWP39kMPZXjLe7P9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793005625;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=hAkuDZBZb8T1s8OWsEKQaaWyQNfZ0iEFPMUDMy+e4Wo=;
	b=3au2prbx+XuqH+0L3Iw8IfQAlZ7zK1RESdJGMhdEXQb00TdVPtO1RMGdoQrXFTglCtAU
	 tsGw3nb5M7TBdVFPR4xZxe6svnNgg2TjACI96b+WPjMw2EsEVuNIB9eb8tWoDFQdipz2l
	 ON2QXmWHhZExDupC0rs2mCIYtaS7PbA9nScTieBnVU+VP47ySWBM8tnasd+LBJy5MZmuQ
	 V1yIdXpCOXzvgMkMHJnlVyV8O4ZNVs1Bpmkh3YN/oOXVmZKMHdTQ1zJ7OlZpCCrM2huiV
	 Eknbfkx/Wbi1Bf/geUhgRDocPie8XwqTj+++TEqzKsViKSEMXGLEj4/dCzB4vr1oMFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fPGd288X;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE73606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 09:07:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDE73606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fPGd288X
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ace9e6e1a5so1985897a91.0
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 02:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793005623; x=1793610423; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hAkuDZBZb8T1s8OWsEKQaaWyQNfZ0iEFPMUDMy+e4Wo=;
        b=fPGd288XwPqMLOoYjKmaFlcEf0srJYmCf7BvK9KabgufapySTEMbjKMUfXazlu0DSc
         qSQCvifRzoDgmyyPqvCph4DYunLPkw0QfAKASW4JRcZLFDzB++8x5eN8Md9bC7EC/JHV
         Du9PaMDf/dEAiu34UHUb80YI453I5h2N4dApUn2GwdIh+YJEvXUHPL8V3A+RIelNcg+5
         Ahz4pnhrvrOArorc8ZPMS0NcEcF3t3ltE8zmJRP0mS2+5htxDJKLcDAiVgVuKFk8cb7K
         DjUc39aeQtRCLLKxemKRDUj9N1zJvTrZ27hqSe/CdJoWdxOqMIZxzhiKnY4XrdTufUc0
         BE8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793005623; x=1793610423;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hAkuDZBZb8T1s8OWsEKQaaWyQNfZ0iEFPMUDMy+e4Wo=;
        b=rN8y2MKLZIdPl0/zqI3dfh4sCVLzxSQKMPts4WLFlmtD04dPN7YX8MQTxmFfjNCYYO
         CNKCAbP2idZzALdS8svXEE5sY6n78zU1SywTDZE70E9d24UQJFBUyi/GefAg+5OIoOZ9
         1nMPvxzhW24sRSAr/dS5pAGftHRfR+9kLbZT2LuD+FL5BjjKP3YRChn6IwsxLGJcz+KT
         9TlRw5ljrS9Q2LT9bnKN0J3f8GtGz2QONnb1eP/TT+IB4AYBdvfThNlLW4ZBf4xhDz3V
         HzrNTKeR94gYr9B/2oaFuW3nZ+LH2b17wcFx4Gf13pHsOTe4zXddmjFiJ9MIh/dgC/f8
         20Gw==
X-Gm-Message-State: AFq9FYIqT4UOwst4uKubVA6CPs6CYhH/EZh4eO4sypJ17CqKIEbu/uiP
	9r1hjEPLs5I29Py4YiEgCKqnFv3mbWLEz3HRx3+JFpCFgdJv1h2QaAFVGT5Ux539
X-Gm-Gg: AYBFou2ppXk/83fBo8tZwwrNLnzdr5+K/NJwbBLIuGPgbcrsQULSngN9f+sJl/jZoiP
	nQIKmPF8kDIKOCAV+qwvUdcrAD1fYvSJP5S3FTIIxDhByoItJpPCCKjF6mcZQiDq1Ko3L89PW1K
	nVNY+2JYu7j10AAZACQjd8rVGh69154b6tK5afe2g0sx2zEnkXSlPeQsFbH1COMjVadkqUz0Fb5
	gFRSAWwM+uTRWMJ8wZ89lIr6w/3Ui8+i5FVstGJ55/ToX1kuWG4vHFo/MEyl90q4fBPyIh27ylJ
	eVktHk4GPFCC0gPGK5upUsxKZUWet/Cm2ALsclRkqHfJRs6k6eTX5/GDwEL9WPXRS7n3v9Ws54t
	pcosCjBjAuHOoaMRIqNh9t0iMF4cnppb56ra3Fj3HA3swJ/WqqmArDl/6BNVaiRMFfxv8GdLWUn
	J3jiKMOb42PfpYe7JnH55IzN3aSxaBAU/eJfAcwIHxv89asIv6If00bPdwihtlRHxfTxoxYHlAJ
	hvAP6HaFEeIdWHrgahwo6j5lyj0hLLakUMkZnVb2CbB35pnBHu657dVCyEeflpD01wxBPv8/3mf
	pQ==
X-Received: by 2002:a17:90a:dfc6:b0:3a0:eec6:b065 with SMTP id 98e67ed59e1d1-3adeb550e07mr3601365a91.13.1793005622487;
        Mon, 26 Oct 2026 02:07:02 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.94.86])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebb0667asm7697028a91.14.2026.10.26.02.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 02:07:01 -0700 (PDT)
Message-Id: <pull.2219.v4.git.1793005620.gitgitgadget@gmail.com>
In-Reply-To: <pull.2219.git.1789385483.gitgitgadget@gmail.com>
References: <pull.2219.git.1789385483.gitgitgadget@gmail.com>
From: "qeesung via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 26 Oct 2026 09:06:57 +0000
Subject: [PATCH v4 0/3] repack: don't lose objects to a ".keep" that appears mid-run
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Taylor Blau <ttaylorr@openai.com>,
    Junio C Hamano <gitster@pobox.com>,
    Justin Tobler <jltobler@gmail.com>,
    qeesung <qeesung@live.com>

"git repack -d" could lose objects when a ".keep" file appeared on a pack it
had already decided to delete. repack now tells pack-objects which packs it
may delete, and pack-objects ignores ".keep" files on those packs.

We hit this in production (a ref pointing at a missing commit, on git 2.43),
and it reproduces on master:

 * repack scans for ".keep" files and decides which packs to delete;
   pack-objects scans again when it opens the packs;
 * in between, a fetch or a push brings in a pack identical to one of those,
   and a ".keep" ends up next to it;
 * pack-objects then leaves that pack's objects out, or does not loosen or
   keep them for -A, -k and --cruft, and repack deletes the pack anyway.

v3 passed pack-objects the kept packs repack saw at startup instead of
--honor-pack-keep. That missed -A, -k and --cruft, which skip packs with a
".keep" file regardless of that option. v4 goes the other way:

 * 1/3 fixes a stale kept-pack cache in the cruft walk. It reproduces on
   master, but under --honor-pack-keep any ".keep" file happens to hide it,
   including the one the race leaves; 3/3 takes that one away, so this comes
   first.
 * 2/3 adds "pack-objects --ignore-pack-keep-from=", which treats the packs
   named in the file as having no ".keep".
 * 3/3 makes "repack -d" pass the packs it may delete that way.

Each fix has a test that fails without it; the race is reproduced in t7700
and t7703. The full suite passes.

Known limitations:

 * Unreachable objects of a deleted pack are still dropped by "-a -d" and by
   the expiration options, as before. A pack written again under the same
   name keeps its old mtime, so objects a push brings back that way can
   still expire. Freshening the pack on such a collision would help, but
   that is for a separate series.
 * The cruft walk now goes through the packs of an alternate, as it must
   (see 1/3). On a "clone --shared" fork of git.git this took the walk in
   "repack -d -l --cruft" from about 2ms to about 3.3s, which is what master
   already does when a ".keep" file is around.

This is based on master, now that ps/odb-files-alternates is in. It merges
cleanly with next and seen (with v3 reverted), and the repack tests pass
there. jt/odb-keep-lockfile-fix, Justin's fix for the receive-pack side that
v1 had a patch for, leaves the race as it is.

Changes since v3:

 * Redesigned as above. v3's 1/5, 3/5 and 4/5 are dropped, since nothing
   passes --keep-pack any more; 2/3 and 3/3 are new.
 * 1/3 (v3's 2/5) also lets the walk go through --keep-pack packs while
   still leaving their objects out, and its message explains why the walk
   goes through alternates. There are tests for both.

Qin ShiCheng (3):
  pack-objects: reset kept-pack cache for cruft walk
  pack-objects: add --ignore-pack-keep-from
  repack: tell pack-objects which packs it may delete

 Documentation/git-pack-objects.adoc | 12 ++++
 builtin/pack-objects.c              | 55 +++++++++++++++-
 builtin/repack.c                    | 23 +++++++
 odb/source-packed.h                 |  3 +-
 packfile.c                          | 18 +++++-
 packfile.h                          |  7 +++
 repack.c                            | 26 ++++++++
 repack.h                            | 14 ++++-
 t/t5329-pack-objects-cruft.sh       | 98 +++++++++++++++++++++++++++++
 t/t7700-repack.sh                   | 86 +++++++++++++++++++++++++
 t/t7703-repack-geometric.sh         | 39 ++++++++++++
 11 files changed, 375 insertions(+), 6 deletions(-)


base-commit: 47fdf2208c5b94c8cc01c106b8f7c85efb91c926
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2219%2Fqeesung%2Frepack-kept-packs-snapshot-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2219/qeesung/repack-kept-packs-snapshot-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/2219

Range-diff vs v3:

 1:  8cf72312c5 < -:  ---------- pack-objects: keep --keep-pack open when following
 2:  58019e4983 ! 1:  8cce2b6eb5 pack-objects: reset kept-pack cache for cruft walk
     @@ Commit message
          builds it while the unlisted pack is still marked, the walk asks the
          same kind of question, and so the unlisted pack stays in it: the walk
          stops there, and whatever lies beyond it in an expired pack is left
     -    out of the cruft pack, to go when that pack is deleted.
     +    out of the cruft pack, to go when that pack is deleted. Whether that
     +    happens depends on whether the question changes along the way, which
     +    "--honor-pack-keep" does whenever there is a ".keep" file around.
      
     -    This went unnoticed because of "--honor-pack-keep". repack passes it,
     -    and when there is a ".keep" file it makes the collecting side ask
     -    about on-disk and in-core kept packs together while the walk asks
     -    about in-core ones alone; the cache is rebuilt each time the question
     -    changes, and by accident the walk sees the current marks. Take the
     -    ".keep" file away and the objects are lost today. A later commit stops
     -    repack from passing "--honor-pack-keep" at all, so fix this first.
     +    Drop the cache after unmarking. Only packfile.c is to touch it, so
     +    add repo_invalidate_kept_pack_caches() there, which drops it for every
     +    object directory.
      
     -    Drop the cache after re-marking. The loop over the object sources
     -    that does so lives in packfile.c, as repo_invalidate_kept_pack_caches(),
     -    next to has_object_kept_pack() which reads the cache. Like it, the
     -    loop assumes every source is a files backend; keeping that assumption
     -    in packfile.c rather than adding it to pack-objects means the two can
     -    move together once packfile management is pushed down into that
     -    backend.
     +    With the cache gone, the walk goes through every pack but the listed
     +    fresh ones, as was intended, including packs borrowed from an
     +    alternate. It has to: an object there may refer to a local one, for
     +    example when two repositories borrow from each other, or when "git
     +    repack --filter-to" has moved some objects to an alternate and left
     +    the ones they refer to behind. Without "--local", whatever the walk
     +    finds there is copied into the cruft pack, as it already is for loose
     +    objects of an alternate; with "--local", nothing is. Either way, the
     +    walk may now go through a history far bigger than the repository's
     +    own, as it already did whenever there was a ".keep" file around.
      
     -    The test builds an unreachable chain whose middle commit sits in a
     -    pack pack-objects is not told about and whose oldest objects have
     -    expired; without the fix the cruft pack holds only the recent tip.
     +    It also includes packs given with "--keep-pack", whose objects are to
     +    be left out. Turn those into "open" kept packs, as
     +    "--stdin-packs=follow" does for its "!" packs: the walk goes through
     +    them, and their objects are still left out. This is how an unlisted
     +    pack with a ".keep" file is treated under "--honor-pack-keep".
     +
     +    With "--keep-pack", the walk and the check that leaves the objects of
     +    such a pack out ask about different kinds of kept packs, so the cache
     +    is rebuilt each time they take turns, as already happens under
     +    "--honor-pack-keep" whenever there is a ".keep" file around. repack
     +    never gets here with "--keep-pack": it lists the packs it keeps as
     +    fresh ones instead.
     +
     +    The tests walk from a recent commit to an expired one through a pack
     +    pack-objects is not told about, through one given with "--keep-pack",
     +    and through one of an alternate holding trees whose blobs "git repack
     +    --filter-to" left behind, with and without "--local".
      
          Signed-off-by: Qin ShiCheng <qeesung@live.com>
      
     @@ builtin/pack-objects.c: static void enumerate_and_traverse_cruft_objects(struct
       	/*
       	 * Re-mark only the fresh packs as kept so that objects in
       	 * unknown packs do not halt the reachability traversal early.
     -+	 * The kept-pack cache was built while those packs were still
     -+	 * marked, so drop it too.
     ++	 * A pack given with --keep-pack must not halt it either, but as an
     ++	 * "open" kept pack its objects are still left out. The kept-pack
     ++	 * cache was built while the packs were still marked, so drop it
     ++	 * too.
       	 */
     - 	repo_for_each_pack(the_repository, p)
     +-	repo_for_each_pack(the_repository, p)
     ++	repo_for_each_pack(the_repository, p) {
       		p->pack_keep_in_core = 0;
     ++		if (p->pack_keep_in_core_open)
     ++			ignore_packed_keep_in_core_open = 1;
     ++	}
       	mark_pack_kept_in_core(fresh_packs, 1);
      +	repo_invalidate_kept_pack_caches(the_repository);
       
       	if (prepare_revision_walk(&revs))
       		die(_("revision walk setup failed"));
     +@@ builtin/pack-objects.c: static void read_cruft_objects(void)
     + 
     + 		if (item) {
     + 			item->util = p;
     ++		} else if (p->pack_keep_in_core) {
     ++			/*
     ++			 * Only --keep-pack marks a pack as kept this early.
     ++			 * Make it an "open" kept pack as well, so that its
     ++			 * objects are still left out once it is unmarked
     ++			 * before the traversal; until then this has no effect.
     ++			 */
     ++			p->pack_keep_in_core_open = 1;
     + 		} else {
     + 			/*
     + 			 * This pack wasn't mentioned in either the "fresh" or
      
       ## odb/source-packed.h ##
      @@ odb/source-packed.h: struct odb_source_packed {
     @@ packfile.c: int packfile_fill_entry(struct packed_git *p,
      +
      +void repo_invalidate_kept_pack_caches(struct repository *r)
      +{
     -+	struct odb_source *source;
     ++	struct odb_source_files *files =
     ++		odb_source_files_downcast(r->objects->source);
      +
     -+	for (source = r->objects->sources; source; source = source->next) {
     -+		struct odb_source_files *files = odb_source_files_downcast(source);
     -+		invalidate_kept_pack_cache(files->packed);
     -+	}
     ++	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next)
     ++		invalidate_kept_pack_cache(dir->packed);
      +}
      +
       static void maybe_invalidate_kept_pack_cache(struct odb_source_packed *store,
     @@ t/t5329-pack-objects-cruft.sh: test_expect_success 'cruft trees rescue sub-trees
       	)
       '
       
     -+test_expect_success 'cruft traversal rescues through a pack it was not told about' '
     ++# Build the history "packed", "old", "mid", "new" in the current repository:
     ++# "packed" is in the pack named in "in", "old" has expired, "mid" is in the
     ++# pack whose hash is in $mid and "new" is recent. The objects of packed..new
     ++# end up in "all.objects".
     ++cruft_chain () {
     ++	test_commit packed &&
     ++	git repack -Ad &&
     ++	basename "$(ls $packdir/pack-*.pack)" >in &&
     ++
     ++	test_commit old &&
     ++	test_commit mid &&
     ++	test_commit new &&
     ++
     ++	git rev-list --objects --no-object-names packed..old >old &&
     ++	while read object
     ++	do
     ++		test-tool chmtime -1000 \
     ++			"$objdir/$(test_oid_to_path $object)" || return 1
     ++	done <old &&
     ++	git rev-list --objects --no-object-names old..mid >mid.objects &&
     ++	mid=$(git pack-objects $packdir/pack <mid.objects) &&
     ++	git prune-packed &&
     ++	git rev-list --objects --no-object-names packed..new >all.objects
     ++}
     ++
     ++test_expect_success 'cruft traversal goes through a pack it was not told about' '
      +	git init repo &&
      +	test_when_finished "rm -fr repo" &&
      +	(
      +		cd repo &&
     ++		cruft_chain &&
      +
     -+		test_commit packed &&
     -+		git repack -Ad &&
     -+		keep="$(basename "$(ls $packdir/pack-*.pack)")" &&
     -+
     -+		test_commit old &&
     -+		test_commit mid &&
     -+		test_commit new &&
     ++		# "old" can only be rescued from "new" by walking through
     ++		# the "mid" pack.
     ++		cruft=$(git pack-objects --cruft \
     ++			--cruft-expiration=750.seconds.ago $packdir/pack <in) &&
     ++		test-tool pack-mtimes "pack-$cruft.mtimes" >actual.raw &&
     ++		cut -d" " -f1 <actual.raw | sort >actual &&
     ++		sort <all.objects >expect &&
     ++		test_cmp expect actual
     ++	)
     ++'
      +
     -+		# "old" has expired, "new" is recent, and "mid" sits in a
     -+		# pack that pack-objects is not told about. Rescuing "old"
     -+		# from "new" means walking through that pack.
     -+		git rev-list --objects --no-object-names packed..old >old &&
     -+		while read object
     -+		do
     -+			test-tool chmtime -1000 \
     -+				"$objdir/$(test_oid_to_path $object)" || exit 1
     -+		done <old &&
     -+		git rev-list --objects --no-object-names old..mid |
     -+		git pack-objects $packdir/pack >/dev/null &&
     -+		git prune-packed &&
     ++test_expect_success 'cruft traversal goes through a --keep-pack pack' '
     ++	git init repo &&
     ++	test_when_finished "rm -fr repo" &&
     ++	(
     ++		cd repo &&
     ++		cruft_chain &&
      +
     -+		cruft="$(echo $keep | git pack-objects --cruft \
     ++		# The same, but with "mid" in a pack given with --keep-pack:
     ++		# "old" is still rescued, and none of the objects of that
     ++		# pack are copied.
     ++		cruft=$(git pack-objects --cruft \
      +			--cruft-expiration=750.seconds.ago \
     -+			$packdir/pack)" &&
     ++			--keep-pack=pack-$mid.pack $packdir/pack <in) &&
      +		test-tool pack-mtimes "pack-$cruft.mtimes" >actual.raw &&
     -+
      +		cut -d" " -f1 <actual.raw | sort >actual &&
     -+		git rev-list --objects --no-object-names packed..new >expect.raw &&
     -+		sort <expect.raw >expect &&
     -+
     ++		sort <all.objects >all.sorted &&
     ++		sort <mid.objects >mid.sorted &&
     ++		comm -23 all.sorted mid.sorted >expect &&
      +		test_cmp expect actual
      +	)
      +'
     ++
     ++for opt in "" --local
     ++do
     ++	test_expect_success "cruft traversal goes through an alternate${opt:+ ($opt)}" '
     ++		test_when_finished "rm -fr repo alt.git" &&
     ++		git init repo &&
     ++		git init --bare alt.git &&
     ++		echo "$(pwd)/alt.git/objects" >repo/.git/objects/info/alternates &&
     ++		test_commit -C repo base &&
     ++		test_commit -C repo old &&
     ++		tree=$(git -C repo rev-parse old^{tree}) &&
     ++		blob=$(git -C repo rev-parse old:old.t) &&
     ++
     ++		# Move everything but the blobs to the alternate, then let
     ++		# "old" expire: its tree is in the alternate, but its blob
     ++		# is in an old local pack.
     ++		git -C repo repack -a -d &&
     ++		git -C repo repack -a -d --filter=object:type=blob \
     ++			--filter-to="$(pwd)/alt.git/objects/pack/pack" &&
     ++		git -C repo tag -d old &&
     ++		git -C repo reset --hard base &&
     ++		git -C repo reflog expire --all --expire=all &&
     ++		test-tool chmtime -10000 repo/$packdir/pack-*.pack &&
     ++
     ++		# A recent unreachable commit in "repo" keeps the blob, but only
     ++		# if the traversal goes through the tree in the alternate, which
     ++		# it has to do even with --local.
     ++		outer=$(printf "040000 tree %s\tdir\n" $tree | git -C repo mktree) &&
     ++		git -C repo commit-tree -m recent $outer >/dev/null &&
     ++		git -C repo repack --cruft --cruft-expiration=1.hour.ago -d $opt &&
     ++		git -C repo cat-file -e $blob
     ++	'
     ++done
      +
       test_expect_success 'expired objects are pruned' '
       	git init repo &&
 3:  ff2146d002 < -:  ---------- pack-objects: sort --keep-pack list for lookup
 4:  148175cfa0 ! 2:  91ffbdf4fa pack-objects: add --keep-pack-from-file
     @@ Metadata
      Author: Qin ShiCheng <qeesung@live.com>
      
       ## Commit message ##
     -    pack-objects: add --keep-pack-from-file
     +    pack-objects: add --ignore-pack-keep-from
      
     -    "--keep-pack" names one pack per occurrence, and there is only so much
     -    room on the command line: ARG_MAX is shared with the environment, and
     -    on Windows the whole line is capped at 32,767 characters, which a few
     -    hundred pack names fill. Past that the spawn fails before pack-objects
     -    has started. fetch-pack grew "--stdin" in 078b895fef (fetch-pack: new
     -    --stdin option to read refs from stdin, 2012-04-02) for the same
     -    reason.
     +    repack decides which packs to delete before it runs pack-objects, but
     +    pack-objects looks for ".keep" files on its own when it opens the
     +    packs. A ".keep" that appears in between, for example from a push or
     +    fetch whose index-pack wrote a pack identical to an existing one, makes
     +    pack-objects treat as kept a pack that repack is about to delete. Its
     +    objects are then left out of the new pack, or not loosened, or not
     +    kept as unreachable, and they are gone once repack deletes the pack.
      
     -    stdin is taken here: every mode repack drives pack-objects in already
     -    uses it, for the revision list under "-a", object names for the
     -    promisor pack, and pack lists for "--stdin-packs" and "--cruft". So
     -    read the names from a file instead, one per line, skipping empty
     -    lines. They go into the same list as the "--keep-pack" names and are
     -    treated exactly alike: matched against local packs, ignored when they
     -    match nothing, and kept open under "--stdin-packs=follow". A relative
     -    path is resolved against the directory the user ran from, as
     -    "--refs-snapshot" of "git multi-pack-index write" is.
     +    Not all of that goes through "--honor-pack-keep": loosening objects
     +    for "--unpack-unreachable", and collecting them for
     +    "--keep-unreachable" and "--cruft", skip packs with a ".keep" file
     +    regardless of it.
      
     -    The list now holds strings from two sources, so let it own its copies.
     +    Let the caller name such packs. "--ignore-pack-keep-from=<file>" reads
     +    names of local packs, one per line, given and matched as for
     +    "--keep-pack", and treats them as if they had no ".keep" file. All of
     +    the above go by p->pack_keep, which is read from the disk once, when a
     +    pack is first seen, so clearing it for the named packs before anything
     +    looks at it covers every one of them. Other packs, including any that
     +    show up later, keep whatever their ".keep" files say.
      
     -    repack is about to use this to hand pack-objects its own snapshot of
     -    the packs that have a ".keep" file.
     +    The names come from a file because there can be more of them than fit
     +    on a command line (on Windows, the whole command line is limited to
     +    32767 characters), and the standard input is already taken in every
     +    mode repack uses.
      
          Signed-off-by: Qin ShiCheng <qeesung@live.com>
      
     @@ Documentation/git-pack-objects.adoc: SYNOPSIS
       		   [--no-reuse-delta] [--delta-base-offset] [--non-empty]
       		   [--local] [--incremental] [--window=<n>] [--depth=<n>]
       		   [--revs [--unpacked | --all]] [--keep-pack=<pack-name>]
     -+		   [--keep-pack-from-file=<file>]
     ++		   [--ignore-pack-keep-from=<file>]
       		   [--cruft] [--cruft-expiration=<time>]
       		   [--stdout [--filter=<filter-spec>] | <base-name>]
       		   [--shallow] [--keep-true-parents] [--[no-]sparse]
     @@ Documentation/git-pack-objects.adoc: depth is 4095.
       	leading directory (e.g. `pack-123.pack`). The option could be
       	specified multiple times to keep multiple packs.
       
     -+--keep-pack-from-file=<file>::
     -+	Read names of packs to keep from `<file>`, one per line, and
     -+	treat each of them as if it had been given with `--keep-pack`.
     -+	Empty lines are ignored. This is meant for callers such as
     -+	linkgit:git-repack[1] that may have to name more packs than fit
     -+	on a command line.
     ++--ignore-pack-keep-from=<file>::
     ++	Read names of local packs from `<file>`, one per line in the
     ++	same form as for `--keep-pack`, and treat them as if they had
     ++	no .keep file, both for `--honor-pack-keep` and when deciding
     ++	which objects to loosen or keep with `--unpack-unreachable`,
     ++	`--keep-unreachable` and `--cruft`.
     ++	This is for callers like linkgit:git-repack[1] that are about
     ++	to delete those packs: a .keep file that appears on one of them
     ++	after the caller decided to delete it must not cause its objects
     ++	to be left out.
      +
       --incremental::
       	This flag causes an object already in a pack to be ignored
     @@ builtin/pack-objects.c: static const char *const pack_usage[] = {
       	   "                 [--no-reuse-delta] [--delta-base-offset] [--non-empty]\n"
       	   "                 [--local] [--incremental] [--window=<n>] [--depth=<n>]\n"
       	   "                 [--revs [--unpacked | --all]] [--keep-pack=<pack-name>]\n"
     -+	   "                 [--keep-pack-from-file=<file>]\n"
     ++	   "                 [--ignore-pack-keep-from=<file>]\n"
       	   "                 [--cruft] [--cruft-expiration=<time>]\n"
       	   "                 [--stdout [--filter=<filter-spec>] | <base-name>]\n"
       	   "                 [--shallow] [--keep-true-parents] [--[no-]sparse]\n"
     @@ builtin/pack-objects.c: static void get_object_list(struct rev_info *revs, struc
       }
       
      +/*
     -+ * Read pack names from the file, one per line, as if each of them had
     -+ * been given with "--keep-pack".
     ++ * Treat the local packs named in "path" as if they had no ".keep" file.
     ++ * The names are matched like those given with --keep-pack. This has to
     ++ * happen before anything looks at p->pack_keep, which is read from the
     ++ * disk only once, when the pack is first seen.
      + */
     -+static void read_keep_pack_list(struct string_list *names, const char *path)
     ++static void ignore_pack_keep_from_file(const char *path)
      +{
     ++	struct string_list names = STRING_LIST_INIT_DUP;
      +	struct strbuf buf = STRBUF_INIT;
     ++	struct packed_git *p;
      +	FILE *fp = xfopen(path, "r");
      +
     -+	while (strbuf_getline(&buf, fp) != EOF) {
     -+		if (!buf.len)
     -+			continue;
     -+		string_list_append(names, buf.buf);
     -+	}
     ++	names.cmp = fspathcmp;
     ++	while (strbuf_getline(&buf, fp) != EOF)
     ++		string_list_append(&names, buf.buf);
      +	if (ferror(fp))
      +		die_errno(_("could not read '%s'"), path);
      +	fclose(fp);
     ++	string_list_sort(&names);
     ++
     ++	repo_for_each_pack(the_repository, p)
     ++		if (p->pack_local &&
     ++		    string_list_has_string(&names, pack_basename(p)))
     ++			p->pack_keep = 0;
     ++
     ++	string_list_clear(&names, 0);
      +	strbuf_release(&buf);
      +}
      +
     - static void add_extra_kept_packs(struct string_list *names,
     - 				 enum stdin_packs_mode stdin_packs)
     + static void add_extra_kept_packs(const struct string_list *names)
       {
     + 	struct packed_git *p;
      @@ builtin/pack-objects.c: int cmd_pack_objects(int argc,
       	int rev_list_index = 0;
       	enum stdin_packs_mode stdin_packs = STDIN_PACKS_MODE_NONE;
     - 	struct string_list keep_pack_list = {
     -+		.strdup_strings = 1,
     - 		.cmp = fspathcmp,
     - 	};
     -+	char *keep_pack_from_file = NULL;
     + 	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
     ++	char *ignore_pack_keep_from = NULL;
       	struct list_objects_filter_options filter_options =
       		LIST_OBJECTS_FILTER_INIT;
       	struct repo_config_values *cfg = repo_config_values(the_repository);
     @@ builtin/pack-objects.c: int cmd_pack_objects(int argc,
       			 N_("ignore packs that have companion .keep file")),
       		OPT_STRING_LIST(0, "keep-pack", &keep_pack_list, N_("name"),
       				N_("ignore this pack")),
     -+		OPT_FILENAME(0, "keep-pack-from-file", &keep_pack_from_file,
     -+			     N_("ignore the packs named in <file>")),
     ++		OPT_FILENAME(0, "ignore-pack-keep-from", &ignore_pack_keep_from,
     ++			     N_("ignore .keep files of the packs named in <file>")),
       		OPT_INTEGER(0, "compression", &cfg->pack_compression_level,
       			    N_("pack compression level")),
       		OPT_BOOL(0, "keep-true-parents", &grafts_keep_true_parents,
     @@ builtin/pack-objects.c: int cmd_pack_objects(int argc,
       	if (progress && all_progress_implied)
       		progress = 2;
       
     -+	if (keep_pack_from_file)
     -+		read_keep_pack_list(&keep_pack_list, keep_pack_from_file);
     - 	add_extra_kept_packs(&keep_pack_list, stdin_packs);
     ++	if (ignore_pack_keep_from)
     ++		ignore_pack_keep_from_file(ignore_pack_keep_from);
     + 	add_extra_kept_packs(&keep_pack_list);
       	if (ignore_packed_keep_on_disk) {
       		struct packed_git *p;
      @@ builtin/pack-objects.c: cleanup:
       	clear_packing_data(&to_pack);
       	list_objects_filter_release(&filter_options);
       	string_list_clear(&keep_pack_list, 0);
     -+	free(keep_pack_from_file);
     ++	free(ignore_pack_keep_from);
       	strvec_clear(&rp);
       
       	return 0;
      
     - ## t/t5331-pack-objects-stdin.sh ##
     -@@ t/t5331-pack-objects-stdin.sh: test_expect_success '--stdin-packs with !-delimited pack without follow' '
     - 	)
     + ## t/t7700-repack.sh ##
     +@@ t/t7700-repack.sh: test_expect_success 'objects made unreachable by grafts only are kept' '
     + 	git cat-file -t $H1
       '
       
     -+test_expect_success '--keep-pack-from-file names packs to keep' '
     -+	test_when_finished "rm -fr repo" &&
     -+
     -+	git init repo &&
     ++test_expect_success 'pack-objects --ignore-pack-keep-from' '
     ++	test_when_finished "rm -fr ignore-keep" &&
     ++	git init ignore-keep &&
      +	(
     -+		cd repo &&
     -+		git config set maintenance.auto false &&
     -+
     -+		test_commit A &&
     -+		test_commit B &&
     -+		test_commit C &&
     ++		cd ignore-keep &&
     ++		test_commit base &&
     ++		unreachable=$(git commit-tree -m unreachable HEAD^{tree}) &&
      +
     -+		A="$(echo A | git pack-objects --revs $packdir/pack)" &&
     -+		B="$(echo A..B | git pack-objects --revs $packdir/pack)" &&
     -+		C="$(echo B..C | git pack-objects --revs $packdir/pack)" &&
     ++		git rev-list --objects --all $unreachable >objects &&
     ++		P=$(git pack-objects .git/objects/pack/pack <objects) &&
     ++		test_commit kept &&
     ++		git rev-list --objects base..kept >objects &&
     ++		K=$(git pack-objects .git/objects/pack/pack <objects) &&
      +		git prune-packed &&
     ++		>.git/objects/pack/pack-$P.keep &&
     ++		>.git/objects/pack/pack-$K.keep &&
     ++		echo pack-$P.pack >ignore &&
      +
     -+		# Empty lines and names that match no pack are ignored,
     -+		# as they would be with --keep-pack.
     -+		cat >keep <<-EOF &&
     -+		pack-$A.pack
     -+
     -+		pack-$B.pack
     -+		pack-does-not-exist.pack
     -+		EOF
     -+
     -+		P=$(git pack-objects --all --keep-pack=pack-$A.pack \
     -+			--keep-pack=pack-$B.pack from-argv </dev/null) &&
     -+		packed_objects from-argv-$P.idx >expect &&
     -+
     -+		P=$(git pack-objects --all --keep-pack-from-file=keep \
     -+			from-file </dev/null) &&
     -+		packed_objects from-file-$P.idx >actual &&
     -+		test_cmp expect actual &&
     -+
     -+		objects_in_packs $C >expect &&
     -+		test_cmp expect actual
     ++		# Both packs have a .keep file, but only P is named in
     ++		# "ignore": its reachable objects are packed and the others
     ++		# are loosened, while K is left alone.
     ++		git pack-objects --honor-pack-keep --all --reflog \
     ++			--indexed-objects --unpack-unreachable \
     ++			--ignore-pack-keep-from=ignore \
     ++			.git/objects/pack/pack </dev/null &&
     ++		test-tool find-pack --check-count 2 base &&
     ++		test-tool find-pack --check-count 1 kept &&
     ++		test_path_is_file .git/objects/$(test_oid_to_path $unreachable)
      +	)
      +'
      +
     -+test_expect_success '--keep-pack-from-file with a missing file' '
     ++test_expect_success 'pack-objects --ignore-pack-keep-from with a missing file' '
      +	test_must_fail git pack-objects --stdout \
     -+		--keep-pack-from-file=does-not-exist </dev/null 2>err &&
     ++		--ignore-pack-keep-from=does-not-exist </dev/null 2>err &&
      +	test_grep "could not open .does-not-exist. for reading" err
      +'
      +
     - test_done
     + test_expect_success 'repack --keep-pack' '
     + 	test_create_repo keep-pack &&
     + 	(
 5:  8f3b9d9ee0 ! 3:  001875455b repack: tell pack-objects which packs are kept
     @@ Metadata
      Author: Qin ShiCheng <qeesung@live.com>
      
       ## Commit message ##
     -    repack: tell pack-objects which packs are kept
     +    repack: tell pack-objects which packs it may delete
      
          repack works out which packs are redundant by looking for ".keep"
     -    files when it starts, then passes "--honor-pack-keep" to the
     -    pack-objects it spawns, which looks for them all over again. Two scans
     -    of the same directory, seconds apart, with nothing holding them
     -    together.
     +    files when it starts, then runs pack-objects, which looks for them all
     +    over again when it opens the packs. Two scans of the same directory,
     +    seconds apart, with nothing holding them together.
      
          A ".keep" that turns up in between loses objects. The parent did not
          see it, so the pack is on its list to delete. The child does see it,
     -    so it leaves that pack's objects out of the replacement. The parent
     -    deletes the pack regardless: repack_remove_redundant_pack() passes
     -    force_delete, which skips the ".keep" check in unlink_pack_path(). The
     -    objects are gone and repack exits successfully.
     +    so it leaves that pack to itself: its objects are not copied into the
     +    new pack, not loosened for "-A", not kept for "-k" or "--cruft". The
     +    parent deletes the pack regardless, as repack_remove_redundant_pack()
     +    passes force_delete, which skips the ".keep" check in
     +    unlink_pack_path(). The objects are gone and repack exits successfully.
      
     -    The gap is easy to land in. index-pack writes its ".keep" before it
     -    renames the packfile into place, so a "git fetch" or a push being
     -    migrated out of its quarantine will do it. Checking for the ".keep"
     -    once more right before deleting would not help: a push holds it for a
     -    fraction of a second, and it may well be gone again by the time
     -    pack-objects has finished.
     +    The gap is easy to land in. index-pack names a pack after its contents
     +    and writes its ".keep" before it renames the packfile into place, so a
     +    "git fetch", or a push being migrated out of its quarantine, that
     +    brings in a pack identical to one we already have puts a ".keep" next
     +    to that pack. Checking for the ".keep" once more right before deleting
     +    would not help: a push holds it for a fraction of a second, and it may
     +    well be gone again by the time pack-objects has finished.
      
     -    Hand pack-objects the kept packs we collected at startup and drop
     -    "--honor-pack-keep". Both processes then work from one snapshot, and a
     -    ".keep" appearing or disappearing while we run cannot make them
     -    disagree. An earlier commit made sure a pack kept this way is no more
     -    of a boundary to the traversal than a ".keep" file was.
     +    When we may delete packs, that is with "-d" and either "-a", "-A",
     +    "--cruft" or "--geometric", write the names of the packs we may
     +    delete, the non-kept and cruft packs, to a file next to the refs
     +    snapshot we already write for "git multi-pack-index write", and pass it
     +    to every pack-objects we spawn with "--ignore-pack-keep-from".
     +    pack-objects then never treats those packs as kept, whatever appears
     +    on the disk. Every other pack, whether kept when we started or showing
     +    up later, still goes by its ".keep" file, so "--honor-pack-keep"
     +    stays. Otherwise nothing gets deleted and nothing is passed.
      
     -    The list goes into a file next to the refs snapshot we already write
     -    for "git multi-pack-index write", and is passed with
     -    "--keep-pack-from-file" to every pack-objects we spawn when
     -    "--pack-kept-objects" is not in effect, which is when
     -    "--honor-pack-keep" used to be. The cruft pack-objects already has the
     -    kept packs on its stdin; the file is redundant there, but it sees the
     -    same list as everybody else. With nothing to keep, no file is written
     -    and nothing is passed, which is what "--honor-pack-keep" came down to
     -    when it found no ".keep".
     +    The file has one name per line. A name with a newline in it gets split
     +    there, which at worst makes some other pack not count as kept: its
     +    objects may be copied, but none are lost.
      
     -    The names go one per line, so a name with a newline in it cannot be
     -    passed. "--stdin-packs" and "--cruft" have the same limit and die on a
     -    name they cannot find, but "--keep-pack" ignores such a name, and the
     -    two halves of a garbled one could go on to exclude some other pack;
     -    refuse it up front instead.
     +    Unreachable objects of such a pack are still dropped by "-a -d", or by
     +    "--cruft-expiration" and "--unpack-unreachable" once they are old
     +    enough, as these drop unreachable objects by design, and a pack written
     +    again under the same name does not make them any younger; what changes
     +    is that the objects that are to be kept no longer go with them.
      
     -    The user's own "--keep-pack" arguments keep being forwarded, since
     -    they apply either way. write_filtered_pack() had a loop passing the
     -    kept packs too, but without the ".pack" suffix pack-objects compares
     -    against; it goes. Kept packs borrowed from an alternate object
     -    directory were covered by "--honor-pack-keep" and are not by the
     -    snapshot, which only ever held local packs; repack never deletes
     -    those, so their objects now get packed rather than skipped, which
     -    costs room but cannot lose anything.
     +    The tests have a ".keep" appear on the pack about to be deleted as
     +    pack-objects starts, through a "git" wrapper found via "--exec-path",
     +    for "-a", "-A", "-k", "--cruft" with and without an expiration,
     +    "--pack-kept-objects", "--filter" and "--geometric".
      
          Signed-off-by: Qin ShiCheng <qeesung@live.com>
      
       ## builtin/repack.c ##
      @@ builtin/repack.c: int cmd_repack(int argc,
     - 	struct oidset drop_oids = OIDSET_INIT;
     - 	struct pack_geometry geometry = { 0 };
     - 	struct tempfile *refs_snapshot = NULL;
     -+	struct tempfile *kept_packs_snapshot = NULL;
     - 	int i, ret;
     - 	int show_progress;
     - 
     -@@ builtin/repack.c: int cmd_repack(int argc,
     - 
       	existing.repo = repo;
       	existing_packs_collect(&existing, &keep_pack_list);
     -+	if (existing.kept_packs.nr) {
     + 
     ++	/*
     ++	 * Tell pack-objects which packs we may delete. pack-objects looks
     ++	 * for ".keep" files on its own, and one that appears on such a
     ++	 * pack from now on must not make it leave out objects that would
     ++	 * then be deleted with the pack.
     ++	 */
     ++	if (delete_redundant &&
     ++	    ((pack_everything & ALL_INTO_ONE) || geometry.split_factor) &&
     ++	    existing_packs_has_non_kept(&existing)) {
      +		struct strbuf path = STRBUF_INIT;
     ++		struct tempfile *non_kept_packs;
      +
     -+		strbuf_addf(&path, "%s/%s_XXXXXX",
     -+			    repo_get_object_directory(repo), "kept-packs");
     ++		strbuf_addf(&path, "%s/tmp_non_kept_packs_XXXXXX",
     ++			    repo_get_object_directory(repo));
      +
     -+		kept_packs_snapshot = xmks_tempfile(path.buf);
     -+		existing_packs_snapshot_kept(&existing, kept_packs_snapshot);
     -+		po_args.kept_packs_snapshot =
     -+			get_tempfile_path(kept_packs_snapshot);
     ++		non_kept_packs = xmks_tempfile(path.buf);
     ++		existing_packs_write_non_kept(&existing, non_kept_packs);
     ++		po_args.ignore_pack_keep_from = get_tempfile_path(non_kept_packs);
      +
      +		strbuf_release(&path);
      +	}
     - 
     ++
       	if (geometry.split_factor) {
       		if (pack_everything)
     + 			die(_("options '%s' and '%s' cannot be used together"), "--geometric", "-A/-a");
      @@ builtin/repack.c: int cmd_repack(int argc,
       		cruft_po_args.quiet = po_args.quiet;
       		cruft_po_args.delta_base_offset = po_args.delta_base_offset;
       		cruft_po_args.pack_kept_objects = 0;
     -+		cruft_po_args.kept_packs_snapshot = po_args.kept_packs_snapshot;
     ++		cruft_po_args.ignore_pack_keep_from = po_args.ignore_pack_keep_from;
       
       		ret = write_cruft_pack(&opts, cruft_expiration,
       				       combine_cruft_below_size, &names,
      
     - ## repack-filtered.c ##
     -@@ repack-filtered.c: int write_filtered_pack(const struct write_pack_opts *opts,
     - 
     - 	strvec_push(&cmd.args, "--stdin-packs");
     - 
     --	for_each_string_list_item(item, &existing->kept_packs)
     --		strvec_pushf(&cmd.args, "--keep-pack=%s", item->string);
     --
     - 	cmd.in = -1;
     - 
     - 	ret = start_command(&cmd);
     -
       ## repack.c ##
      @@ repack.c: void prepare_pack_objects(struct child_process *cmd,
     - 		strvec_push(&cmd->args,  "--quiet");
     - 	if (args->delta_base_offset)
       		strvec_push(&cmd->args,  "--delta-base-offset");
     --	if (!args->pack_kept_objects)
     --		strvec_push(&cmd->args,  "--honor-pack-keep");
     -+	if (!args->pack_kept_objects && args->kept_packs_snapshot)
     -+		strvec_pushf(&cmd->args, "--keep-pack-from-file=%s",
     -+			     args->kept_packs_snapshot);
     + 	if (!args->pack_kept_objects)
     + 		strvec_push(&cmd->args,  "--honor-pack-keep");
     ++	if (args->ignore_pack_keep_from)
     ++		strvec_pushf(&cmd->args, "--ignore-pack-keep-from=%s",
     ++			     args->ignore_pack_keep_from);
       	strvec_push(&cmd->args, out);
       	cmd->git_cmd = 1;
       	cmd->out = -1;
     -@@ repack.c: void existing_packs_collect(struct existing_packs *existing,
     - 	strbuf_release(&buf);
     +@@ repack.c: int existing_packs_has_non_kept(const struct existing_packs *existing)
     + 	return existing->non_kept_packs.nr || existing->cruft_packs.nr;
       }
       
     -+void existing_packs_snapshot_kept(const struct existing_packs *existing,
     -+				  struct tempfile *f)
     ++void existing_packs_write_non_kept(const struct existing_packs *existing,
     ++				   struct tempfile *f)
      +{
      +	struct string_list_item *item;
      +	FILE *out = fdopen_tempfile(f, "w");
     @@ repack.c: void existing_packs_collect(struct existing_packs *existing,
      +		die(_("could not open tempfile %s for writing"),
      +		    get_tempfile_path(f));
      +
     -+	for_each_string_list_item(item, &existing->kept_packs) {
     -+		/*
     -+		 * A newline would split the name in two, and pack-objects
     -+		 * quietly keeps whichever packs the halves happen to name.
     -+		 */
     -+		if (strchr(item->string, '\n'))
     -+			die(_("cannot keep pack '%s': its name contains a newline"),
     -+			    item->string);
     ++	for_each_string_list_item(item, &existing->non_kept_packs)
     ++		fprintf(out, "%s.pack\n", item->string);
     ++	for_each_string_list_item(item, &existing->cruft_packs)
      +		fprintf(out, "%s.pack\n", item->string);
     -+	}
      +
      +	if (close_tempfile_gently(f)) {
      +		int save_errno = errno;
      +		delete_tempfile(&f);
      +		errno = save_errno;
     -+		die_errno(_("could not close kept packs snapshot tempfile"));
     ++		die_errno(_("could not close non-kept packs tempfile"));
      +	}
      +}
      +
     - int existing_packs_has_non_kept(const struct existing_packs *existing)
     + static void existing_pack_mark_for_deletion(struct string_list_item *item)
       {
     - 	return existing->non_kept_packs.nr || existing->cruft_packs.nr;
     + 	item->util = (void*)((uintptr_t)item->util | DELETE_PACK);
      
       ## repack.h ##
      @@ repack.h: struct pack_objects_args {
     @@ repack.h: struct pack_objects_args {
       	int delta_base_offset;
       	int pack_kept_objects;
      +	/*
     -+	 * File naming the packs to leave alone, one "<name>.pack" per line;
     -+	 * NULL when there are none. pack-objects reads it rather than
     -+	 * looking for ".keep" files itself, so that a ".keep" created or
     -+	 * removed while we run cannot make the two of us disagree over
     -+	 * which packs are being repacked.
     ++	 * A file naming the packs this repack may delete, for
     ++	 * pack-objects' "--ignore-pack-keep-from"; the path is borrowed.
      +	 */
     -+	const char *kept_packs_snapshot;
     ++	const char *ignore_pack_keep_from;
       	struct list_objects_filter_options filter_options;
       };
       
     @@ repack.h: struct pack_objects_args {
       void prepare_pack_objects(struct child_process *cmd,
       			  const struct pack_objects_args *args,
      @@ repack.h: struct existing_packs {
     -  */
       void existing_packs_collect(struct existing_packs *existing,
       			    const struct string_list *extra_keep);
     + int existing_packs_has_non_kept(const struct existing_packs *existing);
      +/*
     -+ * Writes the names of the kept packs, one "<name>.pack" per line, into
     -+ * the given tempfile, for pack-objects to read with --keep-pack-from-file.
     ++ * Write the names of the non-kept and cruft packs, the ones a repack may
     ++ * delete, to "f", one per line, for pack-objects' "--ignore-pack-keep-from".
      + */
     -+void existing_packs_snapshot_kept(const struct existing_packs *existing,
     -+				  struct tempfile *f);
     - int existing_packs_has_non_kept(const struct existing_packs *existing);
     ++void existing_packs_write_non_kept(const struct existing_packs *existing,
     ++				   struct tempfile *f);
       int existing_pack_is_marked_for_deletion(struct string_list_item *item);
       void existing_packs_retain_cruft(struct existing_packs *existing,
     + 				 struct packed_git *cruft);
      @@ repack.h: void pack_geometry_remove_redundant(struct pack_geometry *geometry,
       				    bool wrote_incremental_midx);
       void pack_geometry_release(struct pack_geometry *geometry);
     @@ repack.h: void pack_geometry_remove_redundant(struct pack_geometry *geometry,
       	REPACK_WRITE_MIDX_DEFAULT,
      
       ## t/t7700-repack.sh ##
     -@@ t/t7700-repack.sh: test_expect_success 'repack --keep-pack' '
     +@@ t/t7700-repack.sh: test_expect_success 'pending objects are repacked appropriately' '
       	)
       '
       
     -+test_expect_success 'repack --keep-pack with --pack-kept-objects' '
     -+	test_create_repo keep-pack-kept-objects &&
     ++# Put a reachable commit and an unreachable one into a single pack X in a
     ++# new repository "keep-race", run "git repack" with the given options and
     ++# have a ".keep" appear on X as pack-objects starts, i.e. after the repack
     ++# has decided to delete X. The unreachable commit is saved in the file
     ++# "keep-race/unreachable".
     ++keep_race_repack () {
     ++	git init keep-race &&
      +	(
     -+		cd keep-pack-kept-objects &&
     -+		git config pack.window 0 &&
     -+		git config maintenance.auto false &&
     -+		P1=$(commit_and_pack 1) &&
     -+		P2=$(commit_and_pack 2) &&
     -+
     -+		# "--pack-kept-objects" is about packs that have a ".keep"
     -+		# file. A pack named with "--keep-pack" stays out of the
     -+		# result regardless, objects included.
     -+		git repack -a -d --pack-kept-objects --keep-pack $P1 &&
     -+		ls .git/objects/pack/*.pack >counts &&
     -+		test_line_count = 2 counts &&
     -+		test-tool find-pack -c 1 HEAD~1 &&
     -+		test-tool find-pack -c 1 HEAD~1: &&
     -+		git fsck
     -+	)
     -+'
     -+
     -+test_expect_success FUNNYNAMES 'a kept pack whose name has a newline is refused' '
     -+	test_create_repo keep-pack-newline &&
     -+	(
     -+		cd keep-pack-newline &&
     -+		git config maintenance.auto false &&
     ++		cd keep-race &&
      +		test_commit base &&
     -+		git repack -ad &&
     ++		git commit-tree -m unreachable HEAD^{tree} >unreachable &&
      +
     -+		# The names pack-objects is told to keep go one per line, so
     -+		# this one would come out as two, and the first of them is
     -+		# the name of the pack holding everything else.
     -+		victim="$(basename "$(ls .git/objects/pack/pack-*.pack)")" &&
     -+		name="$(printf "%s\nother" "$victim")" &&
     -+		P=$(git rev-parse HEAD | git pack-objects ".git/objects/pack/$name") &&
     -+		>".git/objects/pack/$name-$P.keep" &&
     ++		git rev-list --objects --all $(cat unreachable) >objects &&
     ++		X=$(git pack-objects .git/objects/pack/pack <objects) &&
     ++		git prune-packed &&
      +
     -+		test_must_fail git repack -ad 2>err &&
     -+		test_grep "contains a newline" err &&
     ++		mkdir shim &&
     ++		write_script shim/git <<-EOF &&
     ++		test "\$1" = "pack-objects" &&
     ++		>"$(pwd)/.git/objects/pack/pack-$X.keep" &&
     ++		>"$(pwd)/keep-created"
     ++		GIT_EXEC_PATH="$GIT_EXEC_PATH" exec "$GIT_EXEC_PATH/git" "\$@"
     ++		EOF
     ++
     ++		git --exec-path="$(pwd)/shim" repack "$@" &&
     ++		test_path_is_file keep-created &&
     ++		test_path_is_missing .git/objects/pack/pack-$X.pack &&
      +		git fsck
      +	)
     -+'
     ++}
     ++
     ++for args in "-a -d" "-a -d --filter=blob:none"
     ++do
     ++	test_expect_success "a .keep that shows up mid-repack loses nothing: $args" '
     ++		test_when_finished "rm -fr keep-race" &&
     ++		keep_race_repack $args
     ++	'
     ++done
      +
     - test_expect_success 'repacking fails when missing .pack actually means missing objects' '
     - 	test_create_repo idx-without-pack &&
     - 	(
     ++for args in "-A -d" "-A -d --pack-kept-objects" "-a -k -d" "--cruft -d" \
     ++	    "--cruft --cruft-expiration=1.week.ago -d"
     ++do
     ++	test_expect_success "a .keep that shows up mid-repack loses nothing: $args" '
     ++		test_when_finished "rm -fr keep-race" &&
     ++		keep_race_repack $args &&
     ++		git -C keep-race cat-file -e $(cat keep-race/unreachable)
     ++	'
     ++done
     ++
     + test_done
      
       ## t/t7703-repack-geometric.sh ##
      @@ t/t7703-repack-geometric.sh: test_expect_success 'geometric repack works with promisor packs' '
     @@ t/t7703-repack-geometric.sh: test_expect_success 'geometric repack works with pr
      +		git prune-packed &&
      +
      +		# Neither pack is twice the size of the other, so both are
     -+		# redundant and get deleted. Have a ".keep" appear on one of
     -+		# them as pack-objects starts, after the repack has decided
     -+		# to delete it: pack-objects used to notice the ".keep" and
     -+		# leave those objects out of the replacement pack.
     ++		# rolled up and deleted. Have a ".keep" appear on one of them
     ++		# as pack-objects starts, after the repack has decided to
     ++		# delete it; its objects must still end up in the new pack.
      +		mkdir shim &&
      +		write_script shim/git <<-EOF &&
     -+		test "\$1" = "pack-objects" && >"$(pwd)/$packdir/pack-$KEPT.keep"
     ++		test "\$1" = "pack-objects" &&
     ++		>"$(pwd)/$packdir/pack-$KEPT.keep" &&
     ++		>"$(pwd)/keep-created"
      +		GIT_EXEC_PATH="$GIT_EXEC_PATH" exec "$GIT_EXEC_PATH/git" "\$@"
      +		EOF
      +
      +		git --exec-path="$(pwd)/shim" repack --geometric 2 -d &&
     ++		test_path_is_file keep-created &&
     ++		test_path_is_missing $packdir/pack-$KEPT.pack &&
      +
      +		git fsck
      +	)
      +'
     -+
     -+test_expect_success 'a kept pack does not stop the traversal from rescuing objects' '
     -+	test_when_finished "rm -fr kept-open" &&
     -+	git init kept-open &&
     -+	(
     -+		cd kept-open &&
     -+		git config repack.midxMustContainCruft false &&
     -+
     -+		test_commit a &&
     -+		test_commit b &&
     -+		b=$(git rev-parse b) &&
     -+		git repack -ad &&
     -+
     -+		# Make "b" unreachable and sweep it, together with its tree
     -+		# and blob, into a cruft pack.
     -+		git tag -d b &&
     -+		git reset --hard a &&
     -+		git reflog expire --all --expire=all &&
     -+		git repack -ad --cruft &&
     -+
     -+		# Bring the commit back on its own, in a pack marked as kept.
     -+		# Its tree and blob are still only in the cruft pack.
     -+		kept=$(echo $b | git pack-objects $packdir/pack) &&
     -+		>$packdir/pack-$kept.keep &&
     -+
     -+		# Build on top of it, so that the repack has to look through
     -+		# the kept pack to find out what the new commit depends on.
     -+		git update-ref refs/heads/master \
     -+			$(git commit-tree a^{tree} -p $b -m c) &&
     -+
     -+		git repack --geometric 2 -d --write-midx --write-bitmap-index &&
     -+		test_path_is_file $packdir/multi-pack-index &&
     -+		ls $packdir/multi-pack-index-*.bitmap >bitmaps &&
     -+		test_line_count = 1 bitmaps
     -+	)
     -+'
      +
       test_done

-- 
gitgitgadget
