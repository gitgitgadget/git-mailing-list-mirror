Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793005624;
	b=bm+WlC9ZcwFPNeqNzNIJ/ADMyWR6VD/2ZqX9ilYETUnIhLmNWxPa5gZsdI6JdsmEACX7
	 RivWMx28THxx/CK8MTlzsx0iQhii0sZPeN79lNjmXb/aNQdI3W7D5Dvt+Hg7jyvO0rYq4
	 y2R9TPRG/x5wljAm1buIJjTxvox73BSkzHx5RiDzn8nvYeCX3x7rnvmxwgEE1Wa89YtAh
	 qrVXPINTYMpEcSnZPzCrwvQ5d7u01VQ43sDTZVXZqop0AEmUTZ9ygSGENNqRh9Ei/7Nuk
	 WA6qjCpEB5FKdRzli4W1mwsBh3QIjdDI36DcbgJw2Mk1J3XK0ei3xGPmVMESohVg1jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793005624;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=ffn+hSI1KsEkRAU+s1fTVNuAV3EAsEAx94NbzvRBedU=;
	b=lJsiy6l86pVSBNJ6Va6iRggP8m6lHnzGs6rtSdURdKg6Wm5P5fgvvNgKj4iz5QrGN/uf
	 CILX0Ubbkq2036viYQldw/E6Ws21Uj09g19gQLHkSfjGX94SMtiIILk7n327BvHNuua8C
	 +dvGkox9Y3LEYM7GAyvAu/AehRLGtFWhVzB9Ue8DNl7Y6LQdsf0bEmuO8zxEfHWFf+3Wq
	 nF3d5s0Ky8c1uwnF0qCmvCulMUJbW0rpnYTUFWRYnojlAzEO7Wd2VrJdsn49CLZWbF5hy
	 vfeWq2BXtkThQulQCMC0ujftEIvH3YX2gT9iUyTUf1q++UfIpY5aMzm/gReKZh5W0qA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="T/T+Sj4m";
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F8E606A31B
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 09:07:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70F8E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=T/T+Sj4m
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e9995ce866so25132185ad.0
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 02:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793005624; x=1793610424; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ffn+hSI1KsEkRAU+s1fTVNuAV3EAsEAx94NbzvRBedU=;
        b=T/T+Sj4mQwulc+7b7LDwjqtlYEoITix3Nzcl1Jl2onUqAeMZsdnSWCue49712b3YaC
         s78qIadX73gysUyJOYVc12jtRU/KphaNogiOo4bGn7Uv3Ryg+bQXZcJv62pb3UyUZJix
         +Hh+jZDoGc9run4yiMFSjpMa+YcZFz8LLpCTqIu8/Q1ItD23bzeBv2n6RGJQ5Elioab6
         pa1qGZ0at1M1CucF6y6LMEJqtgZRduY1wwrCTsBC04LN84OYAHfFWhoNbekZLWO0qjt6
         RBaL5mn6ly4humWNfJSswctYqjg58TdgU6gR7OJCNepDioQjbKkeq5HDG7AZ7k6fe6YO
         F8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793005624; x=1793610424;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ffn+hSI1KsEkRAU+s1fTVNuAV3EAsEAx94NbzvRBedU=;
        b=Z0j3faugv358op7YEjn9VaxObDdqS0nyAqiKh2LmUUfC6Q7VeQgn4ThQsr2NJaTpPM
         pGw1XKJAaKhIRyOt+V9Q4PbrYfZJl7lc/WyUPlVupGkUPsSMg1iKYOr9qF8/V7Bs+XpD
         N46mzKPVzn5bMKk6GgntW2xF2T4YTm4NVVl70pFCOZn1Ah9nh4SJ3xqtaxv3AfMo8qtL
         a6e+zJRH0dytpA5fKeg35dySWyBD8BWHh8xTbBNuD7F35xDTszU5Kphx85wNYesMsJ16
         JvpTg6i74tlCf+N31QatmhAP2VdPJmBD7cfUFM5Ls9WS6iwY+br+30kuWURqo/rkqgSN
         CnCA==
X-Gm-Message-State: AFq9FYKK79zddC0P+rmXYy6e1UsKi/3r4noDQ8kUdDJOVo/BVzLpubPP
	sk2HP1ugh8PTgiqNJQJZ9gOdlmYA+yFImWrlm05exqt9Yf1mF5fPQo0QJwFF8O4W
X-Gm-Gg: AYBFou1bf3RBTm8hCGn3wYBpYZx5STgQD0IdZg0FyyR7RKWeRxeyFPrG4ljVFQOFK7l
	5jcoOqwhUrPuhjzosmxX5b0xJNvG0GooYehVIo/YRxf8JUczbxY3tlEEZqpE/NvX8tP0hqDPKcR
	lEhaaSX+TksS2oK9k8mpVC0fQJVnGA5mmKCSjwf5aNUt+hNVV+fssXYkXbGoVl9KWcP5BDOqMzl
	KPX/HFt33YGhCG2Bf4b7N5ViVLq+sMKbB6DD95mq0kWG7ceSRkJzaFqozSG6pBwtpqYyZfHu4FI
	41IgiBpHiHcJkOME2sfUt2j2wp71pok+5AnbE5tVae8owpFSUqb6Y285XL0wpduJRrWX31oqbnV
	dHfW9Ljw7kDK/zagcuWza1sWTOc8FWEhqcSGrXZLh//94rvffNmGug+XY+/pcU7Fv4aM6CnhSDZ
	p2wcgY9CF4aPIBtdxPxMazviwoSNnxVvHUwrAIvQm4+ru43LR7YiL232Duvmhd7EsgpbpYdyi8I
	XnapBiJDBRNIlc/quyS9nV70OSoz0sjDWTRIHSgfisK7T4EZREnkZ6Y
X-Received: by 2002:a17:903:244b:b0:2e9:7719:40f0 with SMTP id d9443c01a7336-2ea9c6205fcmr53357235ad.19.1793005623727;
        Mon, 26 Oct 2026 02:07:03 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.94.86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b11fc1fsm14295585ad.26.2026.10.26.02.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 02:07:03 -0700 (PDT)
Message-Id: <8cce2b6eb55946c89bd342424a0b1d093850f592.1793005620.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2219.v4.git.1793005620.gitgitgadget@gmail.com>
References: <pull.2219.git.1789385483.gitgitgadget@gmail.com>
	<pull.2219.v4.git.1793005620.gitgitgadget@gmail.com>
From: "Qin ShiCheng via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 26 Oct 2026 09:06:58 +0000
Subject: [PATCH v4 1/3] pack-objects: reset kept-pack cache for cruft walk
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
index ca3a891dfb..5160e76842 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4294,10 +4294,18 @@ static void enumerate_and_traverse_cruft_objects(struct string_list *fresh_packs
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
@@ -4343,6 +4351,14 @@ static void read_cruft_objects(void)
 
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
index a0f6b5096d..c8c6088a69 100644
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

