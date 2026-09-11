Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F437485957
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 13:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789133273; cv=none; b=PNjIZvfjwwf69WCYNJyUNpXDPsMfm6kwIz7jgYdrKw4reunv+GK9QZa1bnlmxD0Mapu6GbiELwzCvH3Qi/CtKHvTReE4dDTDwVSCO341m/QsP5yl4iaoymKbKbP7KzsdvzdI3UOgJUonETgaZcxCUyiDNnU6o4Kp0xX2NoAxcHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789133273; c=relaxed/simple;
	bh=epvEd9BNX7Q+Wx8kNk7IXgJZ3dpWdo2a6+znqnTdL38=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KblBNQl3jsvhdvDP0/8oxq14x9QxXSwmihHF2s2UBVh9Ibw8Zsgu1WdsNCpJQMHUSZkjm5ypSbCLJ93dyJOtH8mKvQnQY36mOdqrGCyfvMAEOgHEBpi5rwPyTUdRprJLHIGbf7XoxdUavy8AuMuAUSxdoizW+tGstNGm4watZEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qz9rSFJc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oZhOVbqn; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qz9rSFJc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oZhOVbqn"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 26706EC007B;
	Fri, 11 Sep 2026 09:27:50 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 11 Sep 2026 09:27:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1789133270;
	 x=1789219670; bh=KnIvQtscbLGI5S02VOUDyS4urPa741Y4s9Qjf47fQtc=; b=
	qz9rSFJcGQ60GSt5e9CBethMTgvq0Q+qEFHaMEZEVKY3YU2fTRA1+MNQbQjyAzow
	4i07AsZkthzeaGtMdeqtftveBifsXWuKab0StEdSnpZxOXZrbB+8OFcsRx9fsqZP
	C/CtVnAj33fil/FxuTL+vJ6SnBTE3mwzlFuiPXV04isDN2XkyjKdRTlZMv76tZoC
	rpuOWyBDid2n5kHR6zpJWK4gVbTO5DMOVU8ihMyXa584f3jEo+6PIQRgMAaMlheS
	su8lZnnu67dpqc+efephPJIoZiPSF04N2ImsUlgPyNU8k4r33Nbu9xcNFvURjMt+
	TAQxKtlQbSTdogkxn3EElA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789133270; x=
	1789219670; bh=KnIvQtscbLGI5S02VOUDyS4urPa741Y4s9Qjf47fQtc=; b=o
	ZhOVbqn6Zqspsc98/kiEw9LyIiJ8LvEUpyKYeJekiTouPu9QqAE6Mwpe1E076fI5
	dmPYs3T/w7gcOx7UXw54nUKmLlEvX48NfU83Li9ql80+beeGY5LMxcAf1hnC56eh
	crPTnBGxatjLG6sFKkmBe5XhLhXRFYNZo9oLNRxxPEfuJhsVA2RY5bBOynK3u7+n
	qF09actSUDKzrQ9xQ028sjzVymr3VHfceE+pT/Ri4OEYsxWh3LJJdBeALMmQI6yr
	5aRFqdgSpbkEzwhqwoOzCV1hRI8iI8+bWnXMU9UhSO8QbeKvbLg+HGY0zQIVSOHX
	mwH9J87XaLEIE4OFUDZYQ==
X-ME-Sender: <xms:1gGkao4QEa4GbVXemcT8PEaBcQKwg6P9chsGeatUzlFFbbLsMy_tvw>
    <xme:1gGkahWY3YpIQ4XNkDQnyzrK_kUkMlbDp66Fsic_FnB6nGSX-MGlX2Zjradvju2aj
    sQonPk1GmO7is1zZL4uy2GnRrhcx0YHz1m_6dhpzUYyNOFBUSF1ew>
X-ME-Received: <xmr:1gGkak2n1tTTUWC2JAZUTEg2QE3bDufw03Z0_ykYQ1fuTaz2lC6J-7Lt0c5K23QE__qWlw>
X-ME-Proxy-Cause: dmFkZTECg8xxBicj1DZS8ANPYnoLkr6WmqZgUjMjlEg+sGzWjqLplREE0ffvvHBmWPAecg
    q+c7PBkoqu7i3P61nG0ccczl9tex8wqN0uqAIqkscV+NqvEU3KnvXs7k+hFS/VwVVQQ43c
    A5FpjBpUNGQKkA3B3tIA+qB36AOfSLZGPRcOW25ujcTxgOzqUBQduBQyZOZe5kUxdKiaJp
    l/OBoFl3wHXALaR6wymfPNH4IY2Krzm00t/d2XCLL8Dy/KaES604yZutrFoJEyqnQ1FLf9
    Fn5HVsaR+LB9rj6EHr0E8SreONR8SbYOhAQ3KEI0o4NHBdJmhZ3EPoIyEYihr4bhpRbSDe
    5GtxKNZdyH9hu2qCl6O4TMK6NfsOHoMd2PuBVD5UptOOyEmhPG9nSFIaXm1buW8gMMJLPk
    gO/AHnIbi+kODXIuVwBzCNWT3rtqOThnvrKfC6/RuLEC8PPHpI5jgm/tfQ8eaofWAAeo2Y
    tzUDQ1l+bAaFsiyuVleAbTzmh4xj/LMekWRvfSwst6IMij17PSixLswLH4kDEg17gbNyNL
    ow337l8lqH4B7aQv+rskNB/wqWRUNkjRF37CqXwW+9f1PcXtHEkm5l5uTdHxL2FLFTu8nw
    dlaG8YRXy8iANH7uuGFDq2TjRdfcnxf2o9ykERvmAv4oE8odgzn5XBPnNSlg
X-ME-Proxy: <xmx:1gGkam3temPOj0KCarxTw0GZL3-vQYQKpnSyVAAWSXvX1Xeffu2Q4A>
    <xmx:1gGkav-AhJ0tNg9L_hWKhak9qlKhv--n9l_0gwFILuq8zjFlVHGAHg>
    <xmx:1gGkar2H9TR3Ksy3vSlyGqE_kIvPspf40smTTOkfyyPibtjlmUiA0Q>
    <xmx:1gGkak-jjZpFUo_7vbhol5sAfILwVIjIakcDoXRVN3Fi1hnoop4jNw>
    <xmx:1gGkapVOvdGIWIFprvbUsf6yjUAZ9FyiXPaj1eDADE3fgBXGOsP9UKuS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 09:27:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4eacb0d3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Sep 2026 13:27:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 11 Sep 2026 15:27:32 +0200
Subject: [PATCH v3 08/10] builtin/fsck: move bitmap verification into the
 packed source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-pks-odb-source-fsck-v3-8-ef2fdc085e38@pks.im>
References: <20260911-pks-odb-source-fsck-v3-0-ef2fdc085e38@pks.im>
In-Reply-To: <20260911-pks-odb-source-fsck-v3-0-ef2fdc085e38@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.15.2

The checks for bitmaps live in `verify_bitmap_files()`, which is called
by "builtin/fsck.c". These checks are obviously specific to the "packed"
backend.

Move the logic into `odb_source_packed_fsck()`. As in preceding commits,
this means that we now properly honor both "--connectivity-only" and
"--no-full". Furthermore, we drop the dedicated `ERROR_BITMAP` bit and
instead use the generic `ERROR_OBJECT` bit.

Note that this change also adapts `verify_bitmap_files()` to be
focused on a single "packed" source instead of verifying bitmaps from
all sources. This change is required as we already know to loop around
the sources in `odb_fsck()` itself.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c                |  5 -----
 odb/source-packed.c           |  3 +++
 pack-bitmap.c                 | 26 ++++++++++----------------
 pack-bitmap.h                 |  2 +-
 t/t5326-multi-pack-bitmaps.sh | 10 +++++++++-
 5 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 06e72877f3..2f7d29aa56 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -23,7 +23,6 @@
 #include "run-command.h"
 #include "sparse-index.h"
 #include "worktree.h"
-#include "pack-bitmap.h"
 
 #define REACHABLE 0x0001
 #define SEEN      0x0002
@@ -50,7 +49,6 @@ static timestamp_t now;
 #define ERROR_REFS 010
 #define ERROR_COMMIT_GRAPH 020
 #define ERROR_MULTI_PACK_INDEX 040
-#define ERROR_BITMAP 0200
 
 static const char *describe_object(const struct object_id *oid)
 {
@@ -1068,9 +1066,6 @@ int cmd_fsck(int argc,
 		free_worktrees(worktrees);
 	}
 
-	if (verify_bitmap_files(repo))
-		errors_found |= ERROR_BITMAP;
-
 	check_connectivity(repo);
 
 	if (repo->settings.core_commit_graph) {
diff --git a/odb/source-packed.c b/odb/source-packed.c
index e5e69636dd..2b5dc502f5 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -909,6 +909,9 @@ static int odb_source_packed_fsck(struct odb_source *source,
 	if (verify_reverse_indices(packed, opts) < 0)
 		ret = -1;
 
+	if (verify_bitmap_files(packed))
+		ret = -1;
+
 	return ret;
 }
 
diff --git a/pack-bitmap.c b/pack-bitmap.c
index e0fb57d332..3de8e9590c 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -3410,28 +3410,22 @@ static int verify_bitmap_file(const struct git_hash_algo *algop,
 	return res;
 }
 
-int verify_bitmap_files(struct repository *r)
+int verify_bitmap_files(struct odb_source_packed *source)
 {
-	struct odb_source *source;
-	struct packed_git *p;
+	struct packfile_list_entry *e;
+	struct multi_pack_index *m;
 	int res = 0;
 
-	for (source = r->objects->sources; source; source = source->next) {
-		struct odb_source_files *files = odb_source_files_downcast(source);
-		struct multi_pack_index *m = get_multi_pack_index(files->packed);
-		char *midx_bitmap_name;
-
-		if (!m)
-			continue;
-
-		midx_bitmap_name = midx_bitmap_filename(m);
-		res |= verify_bitmap_file(r->hash_algo, midx_bitmap_name);
+	m = get_multi_pack_index(source);
+	if (m) {
+		char *midx_bitmap_name = midx_bitmap_filename(m);
+		res |= verify_bitmap_file(source->base.odb->repo->hash_algo, midx_bitmap_name);
 		free(midx_bitmap_name);
 	}
 
-	repo_for_each_pack(r, p) {
-		char *pack_bitmap_name = pack_bitmap_filename(p);
-		res |= verify_bitmap_file(r->hash_algo, pack_bitmap_name);
+	for (e = packfile_store_get_packs(source); e; e = e->next) {
+		char *pack_bitmap_name = pack_bitmap_filename(e->pack);
+		res |= verify_bitmap_file(source->base.odb->repo->hash_algo, pack_bitmap_name);
 		free(pack_bitmap_name);
 	}
 
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 1385027c1f..847ad4762d 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -205,7 +205,7 @@ int bitmap_is_midx(struct bitmap_index *bitmap_git);
 
 int bitmap_is_preferred_refname(struct repository *r, const char *refname);
 
-int verify_bitmap_files(struct repository *r);
+int verify_bitmap_files(struct odb_source_packed *source);
 
 struct ewah_bitmap *read_bitmap(const unsigned char *map,
 				size_t map_size, size_t *map_pos);
diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index 86beab1dae..8047459b00 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -498,7 +498,15 @@ test_expect_success 'git fsck correctly identifies good and bad bitmaps' '
 	corrupt_file "$packbitmap" &&
 	test_must_fail git fsck 2>err &&
 	test_grep "bitmap file '\''$midxbitmap'\'' has invalid checksum" err &&
-	test_grep "bitmap file '\''$packbitmap'\'' has invalid checksum" err
+	test_grep "bitmap file '\''$packbitmap'\'' has invalid checksum" err &&
+
+	# The bitmap checks are performed with "--no-full", but not with
+	# "--connectivity-only".
+	test_must_fail git fsck --no-full 2>err &&
+	test_grep "bitmap file '\''$midxbitmap'\'' has invalid checksum" err &&
+	test_grep "bitmap file '\''$packbitmap'\'' has invalid checksum" err &&
+	git fsck --connectivity-only 2>err &&
+	test_grep ! "invalid checksum" err
 '
 
 test_expect_success 'corrupt MIDX with bitmap causes fallback' '

-- 
2.55.0.1074.ge7621b4bad.dirty

