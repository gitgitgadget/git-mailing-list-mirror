Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793262429;
	b=ZVNy/cUJILd6N6tjmReeQ9g8isUR0VMtkiHU6Ye6LrKSLn7tIJ2eRMTrsSGBvVuvZ+UB
	 2WO1/8NHcMXy2TePbXvaNVccejRe54VNODQTfOPcXCbVc4R3Ov/udt+ddLZgb9WrQHDZd
	 tep/pFh9nzt4wQzmVRWClR2j49Jrz88QxABngPVLPMJLdlHb2frMsG8goT44PE9RCn88r
	 5JKvXbgFpl6Td3Lby90kw+8gLMqBbLR5BoxRsTmlMuKsocVsrPdqJdLphJD2yEiVUZfN2
	 s7wDe1SQFZyain0ABe3oV/kGlAKDzXVapQ0qUY/mBildNPccHSfpmVmj6ebNpF0kTEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793262429;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=66NSA4fy6fZVNq09DZO5ASEU79fb+2eFe1w97/7TwfI=;
	b=sj7+ZinKy+9aZQTn3jawDSYkq5Rzk2F2FPNwyIAS0HRpRkLS/c6qwtbp4vxdyElIT5Bh
	 /267yOfHJfpuwnKf2mvN8n7zY3sWvS5lSJfTptANt88mV43ihpikakAop/tiOhGlJXXW0
	 ScIibdNmLMsl4S9RMl0UnZEnpBnmb5Uq5g5TRVMtyiC7QN+utp3Js88lcr9uUlg2uJkzm
	 2JyaI/+WQ2bOHORRwcMe7i9hgrQXjecn0G5xrhsFjtWXb0xLzQj3zoatt8e0g+84ZtelR
	 GLR0vyAVbL6RYEz625ZQlxm7NtxhIDVW9I/FB3vMwTeQRpLO+Zux1ay+4ja5KyGqR4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pierre.co;
	spf=pass smtp.mailfrom=pierre.co;
	dkim=pass header.d=pierre.co header.i=@pierre.co header.a=rsa-sha256 header.s=google header.b=hh9pctks;
	arc=none smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EB9606A31A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 08:27:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76EB9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pierre.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pierre.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pierre.co header.i=@pierre.co header.a=rsa-sha256 header.s=google header.b=hh9pctks
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8ab432273c5so17664057b3.3
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 01:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pierre.co; s=google; t=1793262427; x=1793867227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=66NSA4fy6fZVNq09DZO5ASEU79fb+2eFe1w97/7TwfI=;
        b=hh9pctks8hK4n1YP4jD7yaL8NhzzwNN7OHh7Pd5VrhRhpuyuaLSug0dwz3a5bLzbRv
         FrUj2/ngHQ6wrfVDpd9wVFMsn7rjVbJHIsPMzv5wsg5NHPq9j405UcYoORb20xDRScKh
         cmMzPbSZ1o2HQb39zOhhzv/AphTHPNbz7NkGJMmH55xP43LjNC3xTxt5QJr5eEjfoiel
         q5eQqlsfsdLctmF7TGpfWLjo30fWxxwliDZZZ97JOZV++lgkLciaLFrGCggTxxTzEQJl
         RVpvhcaZ9MwG5G5r2pGj9dTrf23LuBgnHEI6TC5wctDsW6ib0tSrIeVpOrb2O6+fo1k8
         1p6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793262427; x=1793867227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=66NSA4fy6fZVNq09DZO5ASEU79fb+2eFe1w97/7TwfI=;
        b=O6NFA/98KzoFS0EpqWoQpS7SNstTUcOE31fMATatiug3K/QOWja26MwKwWVPdmY2vB
         RPrgBIfSN9bT1O9Bpo/PNDvYQ3/CqITeg7ikYANtNeogcA7gPJEztig0/fXJ3TwY3uMJ
         KgU84+muisOS6EJ03n/8oZ/x/G/GREsX2RthD+TtW++Z94UAPJWr5I0DNZ12C8MszKQ5
         B/s4ixYWAL3onZA9J6v2xPR9qwtwCjisDuhCotZYcHqszpeVZO65754nBCxHr6cXFkxO
         2cGcc2P1BbIi1O2FRipKKeEWG7B+IOpjr93MWv4T3/FjGzbB7Y3VXR83G3TxnfFGpf1c
         NU5A==
X-Gm-Message-State: AFq9FYLKKd5nYXHm2ByktyJVliEPFoYBdzaKask6ODTx6adWY3wIWVos
	ZQyhw7Txa21MhUyL/Q4h+ZLbM4K4AZW5sjDgnZGoQ1QIeFXInLCOhA4pt/zEua8MDrtTnj54tPG
	cTLbbQxs=
X-Gm-Gg: AYBFou2+AMQvBE1WmEXJDijyqH0RZbH5jI8nt8EC0YwrQXb+MVjCce4NZ8QazXTlz0g
	LL7VX0P4PYsCldjmuL3bKDUp38ZvNl4/b7qQAwyiwsqbQMOMj0VkCCWZqhDBrvKo2ZOOynKm8ef
	38waPHXHbPynBssc71E/AZFdCq+DRImtWwUGfz0tr5DORAjjviquV1pN1ouPACleQU1pgq0ZTNS
	EhA+hwcAMJihEWpcB2pXBPgwjhNdJugzg5RdqLgYeKwZXDkZRUspLDrDQWOGOsLpKWCq5bRwkDl
	pAQI10eTf0toa2wiGT54i5agG29Np4PO/L1MQPYhI2QzXneGBjtBPiGrCflIbOpVDVxaOipuCxN
	TcDIb0eyc16yJLAH2+WqtdYFVpiamRqEUtLGIA4aOMmbbf5fCFy2LLtR4SN5wZ3D/RlMDko9wkx
	vk7p/upODAXNfknpSw/SFIuR1bw2uhlVLBGhxwsl3M8BN2bOhdWBN9hOU6A+u/cw6FqisBz3V3G
	GLInhNqeR9vBtKXvvRIkJK0qOC1ubGkJGnCR+Bek+9++x4cElMSLjQ7MpnpHbmS5UQnHX7Edne0
	lm6hN12ilweZax8bA+pp5A9htZfZvhCGL/peGzCgPWKU0AUjf6X8xTkvdkSu
X-Received: by 2002:a05:690c:560f:10b0:8b0:f116:122c with SMTP id 00721157ae682-8b1b5bbd1dcmr32017907b3.8.1793262427307;
        Thu, 29 Oct 2026 01:27:07 -0700 (PDT)
Received: from Mac.tailb692b4.ts.net ([2600:1700:2f70:7f50:1127:83bf:c1e4:d2b5])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b19e5a1cc8sm41413837b3.23.2026.10.29.01.26.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 01:26:58 -0700 (PDT)
From: Pia Park <pia@pierre.co>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v3] midx-write: skip writes with no object entries
Date: Thu, 29 Oct 2026 01:26:17 -0700
Message-ID: <97eca05600afc5828e3f27c6fcfd3f7872ca326b.1793260625.git.pia@pierre.co>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <eef33827000cf106544174ed000129c2989af1cd.1788851232.git.pia@pierre.co>
References: <eef33827000cf106544174ed000129c2989af1cd.1788851232.git.pia@pierre.co>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A MIDX write can find packs without finding any objects, either because
the packs are empty or because an incremental write finds only objects
already indexed by an earlier layer. The existing early exit checks only
the number of packs, so these cases publish a zero-object MIDX without a
reverse index.

Empty MIDXs were already published by 662148c435 (midx: write object
offsets, 2018-07-12); the failure mode appeared in 27afc272c4 (midx:
implement writing incremental MIDX bitmaps, 2025-03-20), when
incremental bitmap writes began loading reverse indexes from prior
layers.

Reproducible on master as of b8242b093d (The 23rd batch, 2026-09-07),
starting with a non-incremental write:

    git init --bare --object-format=sha1 empty.git &&
    (
        cd empty.git &&
        git pack-objects objects/pack/pack </dev/null &&
        git multi-pack-index write &&
        git multi-pack-index write --incremental --bitmap
    )

The first write succeeds but publishes an empty MIDX, which also fails
verification with "the midx contains no oid". The second write exits
with status 255, reporting "could not load reverse index for MIDX".
Starting with an incremental write has the same problem.

When the computed entry list is empty, return success through the
existing cleanup path instead of publishing an empty MIDX. Apply this
to both non-incremental and incremental writes. The check follows
pack/drop validation and precedes lock acquisition and temporary file
creation, leaving existing MIDX files untouched. Preserve the existing
error when there are no pack files to index.

Empty-object writes already return success, including when --bitmap
emits a warning. Preserve that exit status, but omit the warning and
empty MIDX.

Test empty packs in a bare repository, empty incremental layers, and
packs containing only objects indexed by an earlier layer. Check that
writes succeed without creating a MIDX or changing an existing chain.
Update the existing bitmap test to expect no MIDX.

Signed-off-by: Pia Park <pia@pierre.co>
---
The implementation is unchanged from v2. I held off on the preparatory
patch to return success when no packs are present because it raises
the question of what to do with an existing MIDX, discussed below.

Changes since v2:

* Simplify the tests as Taylor suggested: drop directory listings,
  output checks, and subsequent writes already covered elsewhere.
* Rename the initial-layer test to make its empty pack explicit, and
  distinguish the intermediate-layer tests from it.
* Add cleanup for the bare repository created by the new t5319 test.
* Update the commit message's description of the tests.

The initial-layer test does contain a pack: "git pack-objects" with
empty input writes a pack containing zero objects.

There is also a related question about existing MIDX files. With a
non-incremental --stdin-packs write selecting an empty pack, this patch
returns success and preserves the old MIDX. If its packs were deleted,
verification still reports those missing packs. I reproduced this on
the patched build. An empty --stdin-packs list also preserves the old
MIDX, but continues to report the existing no-pack-files error.

If we make the no-packs case return success too, should an empty
non-incremental replacement remove the existing MIDX and its associated
files? That cleanup question also applies to the empty-pack case above.
Incremental writes would still need to preserve their existing chain.
I've left both the no-packs status change and removal of existing MIDX
files out of this version; would you prefer to address them separately?

All 885 tests across the eight MIDX, bitmap, and repack scripts pass,
along with test-lint and whitespace checks.

 midx-write.c                            |  5 +--
 t/t5319-multi-pack-index.sh             | 15 +++++++
 t/t5326-multi-pack-bitmaps.sh           |  9 ++---
 t/t5334-incremental-multi-pack-index.sh | 52 +++++++++++++++++++++++++
 4 files changed, 72 insertions(+), 9 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index 8537102254..3038bbfad2 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1617,9 +1617,8 @@ static int write_midx_internal(struct write_midx_opts *opts)
 	}
 
 	if (!ctx.entries_nr) {
-		if (opts->flags & MIDX_WRITE_BITMAP)
-			warning(_("refusing to write multi-pack .bitmap without any objects"));
-		opts->flags &= ~(MIDX_WRITE_REV_INDEX | MIDX_WRITE_BITMAP);
+		result = 0;
+		goto cleanup;
 	}
 
 	if (ctx.incremental) {
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 68143cb5b7..3d65fafe62 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -54,6 +54,21 @@ test_expect_success "don't write midx with no packs" '
 	test_path_is_missing pack/multi-pack-index
 '
 
+test_expect_success 'skip non-incremental MIDX with no objects' '
+	test_when_finished "rm -rf empty.git" &&
+	git init --bare empty.git &&
+	(
+		cd empty.git &&
+		git pack-objects objects/pack/pack </dev/null &&
+
+		for opt in "" --bitmap
+		do
+			git multi-pack-index write $opt &&
+			test_path_is_missing objects/pack/multi-pack-index || return 1
+		done
+	)
+'
+
 test_expect_success SHA1 'warn if a midx contains no oid' '
 	cp "$TEST_DIRECTORY"/t5319/no-objects.midx $objdir/pack/multi-pack-index &&
 	test_must_fail git multi-pack-index verify &&
diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index 86beab1dae..854b59d641 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -305,7 +305,7 @@ test_midx_bitmap_cases () {
 		)
 	'
 
-	test_expect_success 'no .bitmap is written without any objects' '
+	test_expect_success 'no MIDX or .bitmap is written without any objects' '
 		rm -fr repo &&
 		git init repo &&
 		test_when_finished "rm -fr repo" &&
@@ -319,12 +319,9 @@ test_midx_bitmap_cases () {
 			EOF
 
 			git multi-pack-index write --bitmap --stdin-packs \
-				<packs 2>err &&
+				<packs &&
 
-			test_grep "bitmap without any objects" err &&
-
-			test_path_is_file $midx &&
-			test_path_is_missing $midx-$(midx_checksum $objdir).bitmap
+			test_path_is_missing $midx
 		)
 	'
 
diff --git a/t/t5334-incremental-multi-pack-index.sh b/t/t5334-incremental-multi-pack-index.sh
index f0b82b5f65..25b7be92ff 100755
--- a/t/t5334-incremental-multi-pack-index.sh
+++ b/t/t5334-incremental-multi-pack-index.sh
@@ -195,4 +195,56 @@ test_expect_success 'non-incremental write with existing incremental chain' '
 	)
 '
 
+test_expect_success 'skip initial MIDX layer with empty pack' '
+	git init empty &&
+	(
+		cd empty &&
+		git config maintenance.auto false &&
+		git pack-objects $packdir/pack </dev/null &&
+
+		for bitmap in --bitmap --no-bitmap
+		do
+			git multi-pack-index write --incremental "$bitmap" &&
+			test_dir_is_empty "$midxdir" || return 1
+		done
+	)
+'
+
+test_expect_success 'skip intermediate MIDX layer with empty pack' '
+	git init empty-pack &&
+	(
+		cd empty-pack &&
+		git config maintenance.auto false &&
+		write_midx_layer &&
+
+		git pack-objects $packdir/pack </dev/null &&
+		cp "$midx_chain" chain.expect &&
+
+		for bitmap in --bitmap --no-bitmap
+		do
+			git multi-pack-index write --incremental "$bitmap" &&
+			test_cmp chain.expect "$midx_chain" || return 1
+		done
+	)
+'
+
+test_expect_success 'skip intermediate MIDX layer with duplicate pack' '
+	git init duplicate-pack &&
+	(
+		cd duplicate-pack &&
+		git config maintenance.auto false &&
+		write_midx_layer &&
+
+		git rev-parse HEAD^{tree} >in &&
+		git pack-objects $packdir/pack <in &&
+		cp "$midx_chain" chain.expect &&
+
+		for bitmap in --bitmap --no-bitmap
+		do
+			git multi-pack-index write --incremental "$bitmap" &&
+			test_cmp chain.expect "$midx_chain" || return 1
+		done
+	)
+'
+
 test_done

base-commit: b8242b093d9e941a34460d715e3ce616a34ac3fe
-- 
2.55.0

