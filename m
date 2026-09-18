Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17693E4C94
	for <git@vger.kernel.org>; Fri, 18 Sep 2026 03:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789700624; cv=none; b=a9pXlNFiIkzGiXe/UCxcRGoUDSnmkoNlTX2f42p93ECXFxgLE+4ZZdZddSm4so+Nco1aZwHWMj1UXwlQ2t81r3PzIqnj6g9x0WaOkIs+7D3WEqSmuSdnCBYsvqQRUbTq4554U1mMMYRQlaUVScR+0GMVYfVFp/Msk/Qxx3hXB+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789700624; c=relaxed/simple;
	bh=q+uJ1OhAqtCeBDBp4kBCHVzQQ/1S5C9U1LTbSCnZtiU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mw0nBDYpk4FcHrwUsJJQgcfkQqfCjCfSNiUAfLinJEd9TxP63r+vASQS41yViQ84nojvTqObwG4aO1Lp0bv14vKb0ZpQdbol7KDfKb+FVTesJdip4A8rZDtTfShifH4QUM82ZHICuJuWcpuu2fLjF+1LO3zl2nxWsxCfBuN9/yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ea/nKTzd; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ea/nKTzd"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb76906adso3376201cf.0
        for <git@vger.kernel.org>; Thu, 17 Sep 2026 20:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789700620; x=1790305420; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FqzR6FLKYAW5k+P0lpqZZmsje/zCvnN2OdX3CJljM9I=;
        b=Ea/nKTzd5TEnnOqXz2aYx8S/DuTAuzddCxLwxlsKTI051cf+of9DJKsqkDzidHCthA
         wmEAhVUhV8imL1hng3qKzMEOld/ClMjA1PQAfcMrn+kSRBQljsBn+4D4ija0hBe/IjOQ
         HoPzr2iE66Ej/NadXLpLHSC+T6LGN0bL5GJylPiZx+iBNywipdabUFE4ygnkjffDYota
         vGnJDijlO1mjMTuIEhr+b7icWHYj4vL8rJaNMrLp9xrzXRa4/IIUis//7N/ywzqLqb4p
         P0o5QOxP8DYguKBFa8y4NICgM8YE29FYlKMGspUCea950JCV17h1LJ9QB/YT4TpQB3Q2
         tnQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789700620; x=1790305420;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FqzR6FLKYAW5k+P0lpqZZmsje/zCvnN2OdX3CJljM9I=;
        b=cxh1ryJdvfShEXyHAp4NZXozDpEfC4JfUxHyEjeHC7glwnkz1t4XZaeLXa0HKCCDpf
         GbVcpf/ji8iVLADfKUWupPEkFqons5OdJ0eL5nWkITui48Rhp4+2k76+o7VSQbeJEwYO
         9fotWU3d5mSu3UJKiSyVF/454BFB8VUdkATKWMrd311VOzpRR+pQJiDyXSjmJxlcDU9Q
         AlN861Mvoyzt0ZiSgWub8EBZK+TySev8CeBsmhywPOa4JZUP6uWrSFp6E5oZFNcS2KBZ
         WDSnUZxr6LuffrJAsWRMPLiav/StgW6pad6Zb+teN774hkIAlrq8s21jZarvJ3TnrNex
         Zi2g==
X-Gm-Message-State: AFuF++kvyE3OPSwMBKhEMPhd9niebcN8PjImGRJ+UDp6QAnBrgXD7Hy1
	ReneFqHadPLB+HuJd0QRFJA38IzFtTOeHwKj+S02Gxg0GBgyJ+CtB0uNQujrzA==
X-Gm-Gg: AYBFou04c7EDfRTvT9RewDzaC0pUT1pamXqSQ+GJ5lKDUW5mHZoR21PjUie0rY67xuf
	hLa1pqb/21kyDLthbZYwHsrGB39vOk5VmdNYjpB9aeuaITny+b9zFVFBD5/GN79XelC+Q1r09mG
	b3j5I7KEqSPkrrkLoXQVP9fv1OVfifX7+CAVbPDvMO073IpgFhyZxVlg9PNjAaeVDAWj8OW3xd1
	nYyzitg7BtWYJKRuKaKewtzvehMe5awn3hqeT2MQDldzndFM3Z5FNNzPMbgRO6QASCcXaaPU0i1
	8KdE+I7uvZcCJ1SFumTXFk32Cvuob5FnfpbtZiDSTUWL6Ky1qWsLevzej4ks2ViifhJ5cqgc6zJ
	LULgtth+Ns1sPrRRI4suAOoDKQtcxcaziY3t4JK+80UpowttK39miVuC+2cUHc1Kk2Lg00QKGKQ
	tP7x1OBEM7ltNSp1vNQQNwpfNXhauvQAMSITQ+AJkpJKsed0BQ8d8ZXhE34KelhScXaA2MVaRO7
	g==
X-Received: by 2002:a05:620a:4729:b0:939:4a44:5f99 with SMTP id af79cd13be357-93bdc698903mr148937785a.10.1789700619389;
        Thu, 17 Sep 2026 20:03:39 -0700 (PDT)
Received: from [127.0.0.1] ([20.97.198.245])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93be0f0762dsm26725085a.39.2026.09.17.20.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 20:03:38 -0700 (PDT)
Message-Id: <77aec8941f5d17654f58956c7c643b47dd5a8d93.1789700615.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2219.v2.git.1789700615.gitgitgadget@gmail.com>
References: <pull.2219.git.1789385483.gitgitgadget@gmail.com>
	<pull.2219.v2.git.1789700615.gitgitgadget@gmail.com>
From: "Qin ShiCheng via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 18 Sep 2026 03:03:32 +0000
Subject: [PATCH v2 2/5] pack-objects: reset kept-pack cache for cruft walk
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
stops there, and whatever lies beyond it in an expired pack is lost.

This went unnoticed because of "--honor-pack-keep". repack passes it,
and when there is a ".keep" file it makes the collecting side ask
about on-disk and in-core kept packs together while the walk asks
about in-core ones alone; the cache is rebuilt each time the question
changes, and by accident the walk sees the current marks. Take the
".keep" file away and the objects are lost today. A later commit stops
repack from passing "--honor-pack-keep" at all, so fix this first.

Expose the invalidation packfile.c already has and call it after
re-marking. The test builds an unreachable chain whose middle commit
sits in a pack pack-objects is not told about and whose oldest objects
have expired; without the fix the cruft pack holds only the recent tip.

Signed-off-by: Qin ShiCheng <qeesung@live.com>
---
 builtin/pack-objects.c        |  8 +++++++
 odb/source-packed.h           |  3 ++-
 packfile.c                    |  9 ++++++--
 packfile.h                    |  7 ++++++
 t/t5329-pack-objects-cruft.sh | 40 +++++++++++++++++++++++++++++++++++
 5 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 6f579173b0..8ca8255176 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4274,6 +4274,7 @@ static void enumerate_cruft_objects(void)
 static void enumerate_and_traverse_cruft_objects(struct string_list *fresh_packs)
 {
 	struct packed_git *p;
+	struct odb_source *source;
 	struct rev_info revs;
 	int ret;
 
@@ -4301,10 +4302,17 @@ static void enumerate_and_traverse_cruft_objects(struct string_list *fresh_packs
 	/*
 	 * Re-mark only the fresh packs as kept so that objects in
 	 * unknown packs do not halt the reachability traversal early.
+	 * The kept-pack cache was built while those packs were still
+	 * marked, so drop it too.
 	 */
 	repo_for_each_pack(the_repository, p)
 		p->pack_keep_in_core = 0;
 	mark_pack_kept_in_core(fresh_packs, 1);
+	for (source = the_repository->objects->sources; source;
+	     source = source->next) {
+		struct odb_source_files *files = odb_source_files_downcast(source);
+		packfile_store_invalidate_kept_pack_cache(files->packed);
+	}
 
 	if (prepare_revision_walk(&revs))
 		die(_("revision walk setup failed"));
diff --git a/odb/source-packed.h b/odb/source-packed.h
index a0f6b5096d..9e42311916 100644
--- a/odb/source-packed.h
+++ b/odb/source-packed.h
@@ -25,7 +25,8 @@ struct odb_source_packed {
 	 * Should not be accessed directly, but via
 	 * `packfile_store_get_kept_pack_cache()`. The list of packs gets
 	 * invalidated when the stored flags and the flags passed to
-	 * `packfile_store_get_kept_pack_cache()` mismatch.
+	 * `packfile_store_get_kept_pack_cache()` mismatch, or explicitly via
+	 * `packfile_store_invalidate_kept_pack_cache()`.
 	 */
 	struct {
 		struct packed_git **packs;
diff --git a/packfile.c b/packfile.c
index 4fa5fd67c8..90459ec4d7 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1870,6 +1870,12 @@ int packfile_fill_entry(struct packed_git *p,
 	return 1;
 }
 
+void packfile_store_invalidate_kept_pack_cache(struct odb_source_packed *store)
+{
+	FREE_AND_NULL(store->kept_cache.packs);
+	store->kept_cache.flags = 0;
+}
+
 static void maybe_invalidate_kept_pack_cache(struct odb_source_packed *store,
 					     unsigned flags)
 {
@@ -1877,8 +1883,7 @@ static void maybe_invalidate_kept_pack_cache(struct odb_source_packed *store,
 		return;
 	if (store->kept_cache.flags == flags)
 		return;
-	FREE_AND_NULL(store->kept_cache.packs);
-	store->kept_cache.flags = 0;
+	packfile_store_invalidate_kept_pack_cache(store);
 }
 
 struct packed_git **packfile_store_get_kept_pack_cache(struct odb_source_packed *store,
diff --git a/packfile.h b/packfile.h
index 6d30d15a00..493faf0010 100644
--- a/packfile.h
+++ b/packfile.h
@@ -144,6 +144,13 @@ enum kept_pack_type {
 struct packed_git **packfile_store_get_kept_pack_cache(struct odb_source_packed *store,
 						       unsigned flags);
 
+/*
+ * Drop the cache of kept packs so that the next call to
+ * `packfile_store_get_kept_pack_cache()` rebuilds it, e.g. after changing
+ * which packs are kept in core.
+ */
+void packfile_store_invalidate_kept_pack_cache(struct odb_source_packed *store);
+
 struct pack_window {
 	struct pack_window *next;
 	unsigned char *base;
diff --git a/t/t5329-pack-objects-cruft.sh b/t/t5329-pack-objects-cruft.sh
index 12cda06373..6302f60b75 100755
--- a/t/t5329-pack-objects-cruft.sh
+++ b/t/t5329-pack-objects-cruft.sh
@@ -332,6 +332,46 @@ test_expect_success 'cruft trees rescue sub-trees, blobs' '
 	)
 '
 
+test_expect_success 'cruft traversal rescues through a pack it was not told about' '
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		test_commit packed &&
+		git repack -Ad &&
+		keep="$(basename "$(ls $packdir/pack-*.pack)")" &&
+
+		test_commit old &&
+		test_commit mid &&
+		test_commit new &&
+
+		# "old" has expired, "new" is recent, and "mid" sits in a
+		# pack that pack-objects is not told about. Rescuing "old"
+		# from "new" means walking through that pack.
+		git rev-list --objects --no-object-names packed..old >old &&
+		while read object
+		do
+			test-tool chmtime -1000 \
+				"$objdir/$(test_oid_to_path $object)" || exit 1
+		done <old &&
+		git rev-list --objects --no-object-names old..mid |
+		git pack-objects $packdir/pack >/dev/null &&
+		git prune-packed &&
+
+		cruft="$(echo $keep | git pack-objects --cruft \
+			--cruft-expiration=750.seconds.ago \
+			$packdir/pack)" &&
+		test-tool pack-mtimes "pack-$cruft.mtimes" >actual.raw &&
+
+		cut -d" " -f1 <actual.raw | sort >actual &&
+		git rev-list --objects --no-object-names packed..new >expect.raw &&
+		sort <expect.raw >expect &&
+
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'expired objects are pruned' '
 	git init repo &&
 	test_when_finished "rm -fr repo" &&
-- 
gitgitgadget

