Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795500775;
	b=aSHOUI8TK7Lo6h/YTQTJnxszzQDcV5B/kevyXz0xIbr8j1Tz/dzzMTggjsMvzc/bEB6g
	 FP/Mb7CNxX0a3fVp7vJUe5rKIATQS63422p4gU62MZZuPYQOsFl9x9HBheoiZWxgVzf+q
	 S3fstudHrHR02KY+SsSkVNY5nQde8BO2I1nf2+5VtGByO3LWNv8akisi8HsgICudYeAel
	 g/xxlJMfihyRHZgdKE29LJ/L0aGRorIK1c3jVSNBI+geg9P7iJTuFMuclGlkW2pyS/JZY
	 p9Lrbh9LMwIOdvaiIiKv+nSSNpQo01qecHiLNY4QyhCE5qbS+/1RB3kHIw7P53UU/0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795500775;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=Wil9SFzUUYXCBxEQUTtM3b/bQlxsaUZTQFnygARQLdM=;
	b=pcGS8aJihJL0aEmtuIyghrEhQtmnpVt8GXhm/cNETT7qqE2gg+D3oWXmPzAP7pgnvcdx
	 aRivzqjQCOfMuOgo3NVXkORRTKX5tvIJnavw2AMD+y+2dwku0HRrsGn8FRjGnwi2WhfNg
	 qEYVjTYaBYEk2woka1w37VmkA2KQT9reKSsQnhnrMjN5U/8X2EzoDWVdCNTKTkQRpQ06W
	 EksnSZlKSRPSMqg8mo69+4/bG8Btnu/b5in/cNn2W9NH3yYiEWcVuustuq01B1yDYH7Az
	 fCE+cMKeZ2pk9iv3vL6zDHSknMiC69TbUNK5KTCjcnb2+xMuix/10UnSGaXCrjk1DDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zYjQj8pn;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980C3606A687
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 06:12:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 980C3606A687
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zYjQj8pn
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3282db206d3so1684382eec.0
        for <git@vger.kernel.org>; Mon, 23 Nov 2026 22:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795500769; x=1796105569; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Wil9SFzUUYXCBxEQUTtM3b/bQlxsaUZTQFnygARQLdM=;
        b=zYjQj8pnzpLB0b4YpB06fSNnAEDqNYAw16a7hesnqOH9clx4MWVg4a53ZqTPOXr/fm
         Nwj5gyRQvd9FuXRMHBpciSHI/j1tPe/+bQHW+qn/L9X/53hBu46bVTrrhnFWGwMGREF/
         wEsyYadX7QHXrRmO7fAuyVLpF0L6Z0fsACZdYmCRbKNWnc52zbHMEUd+i95aYRmFEp1L
         aniDjM+vXnNNlRMhWw4EzzCKNkdb2i04outF/zvMRGHW4rPhhEhDlAiV8C3H4cekVNrb
         kOZTptaSha2soKdRIdOSiYN7VXxUjEGJ8sbH/+Dt/+sOaB+evDLv17r4c1RXHGF4wMza
         Uv7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795500769; x=1796105569;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wil9SFzUUYXCBxEQUTtM3b/bQlxsaUZTQFnygARQLdM=;
        b=KqPk3uY1uywY5OCheDw5M8JEOQIPNvOzHxsj279kXhhAWokq8PqdSZuLHyRdPGbnXw
         xOA2Hg8BFA/peKijrjm1YJCRAeYUIna81R0v3NoyjHLBWuaPwfIuR96gnhGJv0WQfwKV
         VEzzr9Zuc+A6IUuUV53aEBy/dv38OyE2+aBZtMyqSKYrcFEjCLv9YpSUG9ASD2jAxhs9
         4gotigIyFNjJBYK4CiPI5OCsw5Jf8TBIL7JAQ8JJAEdl0A2XNng+PBwwwCZUO9011hb4
         PNGRu/uZ+njgD41/mx+u4cy28ZPTiqaW0rkLrtFon4xCEaCXj4J7z3MH5kZHtBSI6KXJ
         80LQ==
X-Gm-Message-State: APuU4Z9d7w3LZuxYpGshQa984HjmELQ6nm5z+hUQSsQHjkzE1o+PO7cu
	L85wwzrveZ+Dv6cIW4xSUUsZZ8B/W6qgOkkonPPUF1uogTOLfUx1Gvo+dJKGLA==
X-Gm-Gg: AZFdTZdKL7HwYt6QRHNtHi6sM0dr7dsZYkiDsMP/mfWhjtWQ3OQDeElSItj+zMUwUkH
	Ev5qhtHvTs08FdX7PexD/MMKUL0fqz236tWeig9f9c2tF4SAn9yAoUkGtGg3eguUdY9cby5TK67
	bgY7oX8aXLDndre/+I3Rb5sTODlEZSCfRISg0+HlR1JNTApQ+tV9KE6fRI+62p8UXKvm2br+rx2
	SXu9vLo5W1mujjWrIn15ttHTSPnoaWz2kjnQaxbJ1OuuWJuI1BnnXGOVnKdD+miR3NUET7Szz+y
	AICY1wiHm/VYyXdaP38X/Y00Jql/THxgohnz2zwrjx6Lfa9VP61p0UR/17O6SaOC1to8vVbAo4V
	i6s0GcgWAcc7P77XrGDTq6sC/Lk5WF78LmhjzjIkHMdVzHeO7bWerT4rzNZfCm3Si+s0AyUr+Y7
	qbCwLGohxwPnJodaC20VJxFCeOV5ph1ozFgrCBNctR7HxQUFi6ezTJCg+07OdjfBviy67JMsWU5
	Qabolzjtf+72ynMzl0pG6wazLWEFYwoBM8DWUzhZ7sNZKgYyLjNtgIyyu0TVUcwTuZZ1S+sBLrT
	6q9dFoJcDY9o85MnYzpI3vvV45ycEMXu1kI+InN/Rd4sy2J/6i4=
X-Received: by 2002:a05:7301:6582:b0:374:e25e:a533 with SMTP id 5a478bee46e88-38570154017mr26382408eec.35.1795500769120;
        Mon, 23 Nov 2026 22:12:49 -0800 (PST)
Received: from [127.0.0.1] ([57.154.4.118])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386aa203267sm16590880eec.0.2026.11.23.22.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 22:12:48 -0800 (PST)
Message-Id: <228b7a690fa99ab2ad33bf16fc62435435160a96.1795500766.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2219.v5.git.1795500766.gitgitgadget@gmail.com>
References: <pull.2219.git.1789385483.gitgitgadget@gmail.com>
	<pull.2219.v5.git.1795500766.gitgitgadget@gmail.com>
From: "Qin ShiCheng via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 24 Nov 2026 06:12:44 +0000
Subject: [PATCH v5 1/3] pack-objects: reset kept-pack cache for cruft walk
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
    qeesung <qeesung@live.com>,
    Qin ShiCheng <qeesung@live.com>

From: Qin ShiCheng <qeesung@live.com>

When writing a cruft pack with an expiration, pack-objects first
collects the recent objects and then walks from them to rescue
whatever they reach, expired or not. A pack the caller did not list is
marked kept while collecting, so that its objects are not copied into
the cruft pack, and unmarked before the walk, so that the walk can go
through it.

The walk does not see the unmarking. Whether an object sits in a kept
pack is answered from a cache that is built on first use and only
dropped when asked about a different kind of kept pack. Collecting
builds it while the unlisted pack is still marked, the walk asks the
same kind of question, and so the unlisted pack stays in it: the walk
stops there, and whatever lies beyond it in an expired pack is left
out of the cruft pack, to go when that pack is deleted. Whether that
happens depends on whether the question changes along the way, which
"--honor-pack-keep" does whenever there is a ".keep" file around.

Drop the cache after unmarking. Only packfile.c is to touch it, so
add repo_invalidate_kept_pack_caches() there, which drops it for every
object directory.

With the cache gone, the walk goes through every pack but the listed
fresh ones, as was intended, including packs borrowed from an
alternate. It has to: an object there may refer to a local one, for
example when two repositories borrow from each other, or when "git
repack --filter-to" has moved some objects to an alternate and left
the ones they refer to behind. Without "--local", whatever the walk
finds there is copied into the cruft pack, as it already is for loose
objects of an alternate; with "--local", nothing is. Either way, the
walk may now go through a history far bigger than the repository's
own, as it already did whenever there was a ".keep" file around.

It also includes packs given with "--keep-pack", whose objects are to
be left out. Turn those into "open" kept packs, as
"--stdin-packs=follow" does for its "!" packs: the walk goes through
them, and their objects are still left out. This is how an unlisted
pack with a ".keep" file is treated under "--honor-pack-keep".

With "--keep-pack", the walk and the check that leaves the objects of
such a pack out ask about different kinds of kept packs, so the cache
is rebuilt each time they take turns, as already happens under
"--honor-pack-keep" whenever there is a ".keep" file around. repack
never gets here with "--keep-pack": it lists the packs it keeps as
fresh ones instead.

The tests walk from a recent commit to an expired one through a pack
pack-objects is not told about, through one given with "--keep-pack",
and through one of an alternate holding trees whose blobs "git repack
--filter-to" left behind, with and without "--local".

Signed-off-by: Qin ShiCheng <qeesung@live.com>
---
 builtin/pack-objects.c        | 18 ++++++-
 odb/source-packed.h           |  3 +-
 packfile.c                    | 18 ++++++-
 packfile.h                    |  7 +++
 t/t5329-pack-objects-cruft.sh | 98 +++++++++++++++++++++++++++++++++++
 5 files changed, 140 insertions(+), 4 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 87c3102e62..c198cd18ab 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4339,10 +4339,18 @@ static void enumerate_and_traverse_cruft_objects(struct string_list *fresh_packs
 	/*
 	 * Re-mark only the fresh packs as kept so that objects in
 	 * unknown packs do not halt the reachability traversal early.
+	 * A pack given with --keep-pack must not halt it either, but as an
+	 * "open" kept pack its objects are still left out. The kept-pack
+	 * cache was built while the packs were still marked, so drop it
+	 * too.
 	 */
-	repo_for_each_pack(the_repository, p)
+	repo_for_each_pack(the_repository, p) {
 		p->pack_keep_in_core = 0;
+		if (p->pack_keep_in_core_open)
+			ignore_packed_keep_in_core_open = 1;
+	}
 	mark_pack_kept_in_core(fresh_packs, 1);
+	repo_invalidate_kept_pack_caches(the_repository);
 
 	if (prepare_revision_walk(&revs))
 		die(_("revision walk setup failed"));
@@ -4388,6 +4396,14 @@ static void read_cruft_objects(void)
 
 		if (item) {
 			item->util = p;
+		} else if (p->pack_keep_in_core) {
+			/*
+			 * Only --keep-pack marks a pack as kept this early.
+			 * Make it an "open" kept pack as well, so that its
+			 * objects are still left out once it is unmarked
+			 * before the traversal; until then this has no effect.
+			 */
+			p->pack_keep_in_core_open = 1;
 		} else {
 			/*
 			 * This pack wasn't mentioned in either the "fresh" or
diff --git a/odb/source-packed.h b/odb/source-packed.h
index e8a7b08fbb..1f216712ce 100644
--- a/odb/source-packed.h
+++ b/odb/source-packed.h
@@ -25,7 +25,8 @@ struct odb_source_packed {
 	 * Should not be accessed directly, but via
 	 * `packfile_store_get_kept_pack_cache()`. The list of packs gets
 	 * invalidated when the stored flags and the flags passed to
-	 * `packfile_store_get_kept_pack_cache()` mismatch.
+	 * `packfile_store_get_kept_pack_cache()` mismatch, or explicitly via
+	 * `repo_invalidate_kept_pack_caches()`.
 	 */
 	struct {
 		struct packed_git **packs;
diff --git a/packfile.c b/packfile.c
index b32b4cd75d..213f930edb 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1881,6 +1881,21 @@ int packfile_fill_entry(struct packed_git *p,
 	return 1;
 }
 
+static void invalidate_kept_pack_cache(struct odb_source_packed *store)
+{
+	FREE_AND_NULL(store->kept_cache.packs);
+	store->kept_cache.flags = 0;
+}
+
+void repo_invalidate_kept_pack_caches(struct repository *r)
+{
+	struct odb_source_files *files =
+		odb_source_files_downcast(r->objects->source);
+
+	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next)
+		invalidate_kept_pack_cache(dir->packed);
+}
+
 static void maybe_invalidate_kept_pack_cache(struct odb_source_packed *store,
 					     unsigned flags)
 {
@@ -1888,8 +1903,7 @@ static void maybe_invalidate_kept_pack_cache(struct odb_source_packed *store,
 		return;
 	if (store->kept_cache.flags == flags)
 		return;
-	FREE_AND_NULL(store->kept_cache.packs);
-	store->kept_cache.flags = 0;
+	invalidate_kept_pack_cache(store);
 }
 
 struct packed_git **packfile_store_get_kept_pack_cache(struct odb_source_packed *store,
diff --git a/packfile.h b/packfile.h
index ed3378c457..0ead9e2821 100644
--- a/packfile.h
+++ b/packfile.h
@@ -143,6 +143,13 @@ enum kept_pack_type {
 struct packed_git **packfile_store_get_kept_pack_cache(struct odb_source_packed *store,
 						       unsigned flags);
 
+/*
+ * Drop every packfile store's cache of kept packs, so that the next call
+ * to `packfile_store_get_kept_pack_cache()` rebuilds it, e.g. after
+ * changing which packs are kept in core.
+ */
+void repo_invalidate_kept_pack_caches(struct repository *r);
+
 struct pack_window {
 	struct pack_window *next;
 	unsigned char *base;
diff --git a/t/t5329-pack-objects-cruft.sh b/t/t5329-pack-objects-cruft.sh
index 12cda06373..4a1056e494 100755
--- a/t/t5329-pack-objects-cruft.sh
+++ b/t/t5329-pack-objects-cruft.sh
@@ -332,6 +332,104 @@ test_expect_success 'cruft trees rescue sub-trees, blobs' '
 	)
 '
 
+# Build the history "packed", "old", "mid", "new" in the current repository:
+# "packed" is in the pack named in "in", "old" has expired, "mid" is in the
+# pack whose hash is in $mid and "new" is recent. The objects of packed..new
+# end up in "all.objects".
+cruft_chain () {
+	test_commit packed &&
+	git repack -Ad &&
+	basename "$(ls $packdir/pack-*.pack)" >in &&
+
+	test_commit old &&
+	test_commit mid &&
+	test_commit new &&
+
+	git rev-list --objects --no-object-names packed..old >old &&
+	while read object
+	do
+		test-tool chmtime -1000 \
+			"$objdir/$(test_oid_to_path $object)" || return 1
+	done <old &&
+	git rev-list --objects --no-object-names old..mid >mid.objects &&
+	mid=$(git pack-objects $packdir/pack <mid.objects) &&
+	git prune-packed &&
+	git rev-list --objects --no-object-names packed..new >all.objects
+}
+
+test_expect_success 'cruft traversal goes through a pack it was not told about' '
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+		cruft_chain &&
+
+		# "old" can only be rescued from "new" by walking through
+		# the "mid" pack.
+		cruft=$(git pack-objects --cruft \
+			--cruft-expiration=750.seconds.ago $packdir/pack <in) &&
+		test-tool pack-mtimes "pack-$cruft.mtimes" >actual.raw &&
+		cut -d" " -f1 <actual.raw | sort >actual &&
+		sort <all.objects >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'cruft traversal goes through a --keep-pack pack' '
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+		cruft_chain &&
+
+		# The same, but with "mid" in a pack given with --keep-pack:
+		# "old" is still rescued, and none of the objects of that
+		# pack are copied.
+		cruft=$(git pack-objects --cruft \
+			--cruft-expiration=750.seconds.ago \
+			--keep-pack=pack-$mid.pack $packdir/pack <in) &&
+		test-tool pack-mtimes "pack-$cruft.mtimes" >actual.raw &&
+		cut -d" " -f1 <actual.raw | sort >actual &&
+		sort <all.objects >all.sorted &&
+		sort <mid.objects >mid.sorted &&
+		comm -23 all.sorted mid.sorted >expect &&
+		test_cmp expect actual
+	)
+'
+
+for opt in "" --local
+do
+	test_expect_success "cruft traversal goes through an alternate${opt:+ ($opt)}" '
+		test_when_finished "rm -fr repo alt.git" &&
+		git init repo &&
+		git init --bare alt.git &&
+		echo "$(pwd)/alt.git/objects" >repo/.git/objects/info/alternates &&
+		test_commit -C repo base &&
+		test_commit -C repo old &&
+		tree=$(git -C repo rev-parse old^{tree}) &&
+		blob=$(git -C repo rev-parse old:old.t) &&
+
+		# Move everything but the blobs to the alternate, then let
+		# "old" expire: its tree is in the alternate, but its blob
+		# is in an old local pack.
+		git -C repo repack -a -d &&
+		git -C repo repack -a -d --filter=object:type=blob \
+			--filter-to="$(pwd)/alt.git/objects/pack/pack" &&
+		git -C repo tag -d old &&
+		git -C repo reset --hard base &&
+		git -C repo reflog expire --all --expire=all &&
+		test-tool chmtime -10000 repo/$packdir/pack-*.pack &&
+
+		# A recent unreachable commit in "repo" keeps the blob, but only
+		# if the traversal goes through the tree in the alternate, which
+		# it has to do even with --local.
+		outer=$(printf "040000 tree %s\tdir\n" $tree | git -C repo mktree) &&
+		git -C repo commit-tree -m recent $outer >/dev/null &&
+		git -C repo repack --cruft --cruft-expiration=1.hour.ago -d $opt &&
+		git -C repo cat-file -e $blob
+	'
+done
+
 test_expect_success 'expired objects are pruned' '
 	git init repo &&
 	test_when_finished "rm -fr repo" &&
-- 
gitgitgadget

