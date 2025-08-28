Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3256338F2E
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 17:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756402801; cv=none; b=e1ytF0WzyGaPyzXnW/O4i6GjA9TXEZkwPj1Oi90O3WjzABabTcN5g3bTfU2LGGQtdbcbH9Q4hGobaSwCuIbp85XG9SA4XfNYUHtOpUwU3BpIHtyW4DEe9Fv4AAgcQnof9xlnJ8VY5U+cWkfsKRv7AyUb7ucUvddQiI2BHypR9NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756402801; c=relaxed/simple;
	bh=sWE7BrYY9gwl6Yy46q2mzWCvetaqsER3vKWy/qhvPdY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dUupGku7iouX6ZWnUevELrCvD4ilbkCahlI9JoXgVhxJBGJrTRn7Lz4JKVe2+tWP9mcLHGttdaSXGpYRpR25s2bF1KGemQG9Z33mEhQRx1oBUTrcrhjp3iBgQygSn5LPQpXE31VEeseuGuxWRDqtRhwBbcx4BSu+ZxZsuOrBQSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lG8but8N; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lG8but8N"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-70deaa19d3cso11452936d6.3
        for <git@vger.kernel.org>; Thu, 28 Aug 2025 10:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756402798; x=1757007598; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLmAhT8pFpThP5VRWy+plIRRWqJFBeFDRa8R0iazxxo=;
        b=lG8but8NTDDyeT3rqM0xp7OOAbZv2ihQJWF+ob4/ySAcvI8hhRkBiPqsF5xFs7dOpn
         dofj7ZodQIhz7JmJW173LzYbThh5t1V+1FzNPC0TRfCVJ8N4+ySazcTxGDL69XOSZln7
         /TypOrb0wHytylPwK/bLcOP5PrKkLfJJpGDfs5NTnpNaU5CepwHkOY4AQY5P9R7WgyJM
         QrA9K0bCqFcbS+sXL0Ow21xlsQp760Jf4nFPL3UbWaWkMJvQ0HEJOVQpBuD4Jzd0qDwU
         wSt9u1mD8G+BHqNSBu2kYFw+c2lHspTKXagaKQ5WJjOfTQWgEdUBo1PM0v+BJgQ8bBDT
         ZW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756402798; x=1757007598;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aLmAhT8pFpThP5VRWy+plIRRWqJFBeFDRa8R0iazxxo=;
        b=njG676qUAUA9lOV/TbjhUtAIQFMehZVeLWf8M0WZmwtFJgoNtF5m0OVD6R2a6eDUu1
         diMC7gdhqNLC5w+AwCWazbjVE8ACsmFiJgnlBsu8VGkvsAacGyhY5cuSlf5O+XH/3H3G
         cf9wcxAhH3ZdX68NdI0bjUKVbnVjgTLyLC6G/xAwMKwwbbhTTHIN4YKvryELdi4JlrhU
         KA/yK0a11E072o/ic/HxnQZMK2VKLjndN7+o+GuSFaAT2xI9IV3UxbjCL6W7/cZWPCHR
         mcX3/QRFjYgc1bUBHxGH4Gxu1E6ige2RTIMANDNUqSqUWSD4uwgE2XQK/ArVGkSdj6va
         Ux1w==
X-Gm-Message-State: AOJu0YxMUvCVWEVdEssEbLVdzetxV60rbm2d85zM3EjhnZJVMIpTzfIT
	FeVL9BLyv5C64tmzDKkxy0bg5QfzMLcITh1I4XHK0p+XgqLUTMMp+QGrrgOpk+56
X-Gm-Gg: ASbGncsAYQ5QDdtL0mVc2MgoaHjiXjugv22UjaCJ5MK+vEOeKsyM9mIGvYlh+diCaUb
	+fag8noC5FtdH48PE4BIGLzLyEyIULMeziiw4qlBk5UugsxA29zBUWwXehoUKoseU8kgmwimuJi
	SEFltix2mp76/AJn8lPSzbsuUuOl5l9YfcJX++1BlG+52nT6bVfr12o4X/pCviBgvknqMQCk8zQ
	qOBt7t6FZZX4IcRmiiYklFYwp1VmgScsPzI0mlOyCWzrjcjta560Gk51kj+5RZYFEzx1/2CPARz
	SdXlxEh4FABRoouPAFYDtphN9rd+nWqUUyi6Lfr+tuwHx5NUBXsIBg4qnRXRxXaW1hBoTfAlhSQ
	FSRX2toORwTTpDvxicFY6jWnw
X-Google-Smtp-Source: AGHT+IF33SRS5UhzEzT80woLzdMpYjjK/mmvH9NDBoTjFEhU1YNOpY8k4ciR7YBJgmm0nKvp5WAk6g==
X-Received: by 2002:ad4:5de6:0:b0:707:5d28:2b80 with SMTP id 6a1803df08f44-70d970a46d7mr302003096d6.7.1756402798082;
        Thu, 28 Aug 2025 10:39:58 -0700 (PDT)
Received: from [127.0.0.1] ([57.154.244.34])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70e002ac99bsm1795106d6.49.2025.08.28.10.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 10:39:57 -0700 (PDT)
Message-Id: <4a4b35c69413ff18f87930dd15335f018ec71910.1756402795.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1965.git.1756402795.gitgitgadget@gmail.com>
References: <pull.1965.git.1756402795.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 28 Aug 2025 17:39:51 +0000
Subject: [PATCH 1/5] midx-write: only load initialized packs
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
Cc: gitster@pobox.com,
    me@ttaylorr.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The fill_packs_from_midx() method was refactored in fcb2205b77 (midx:
implement support for writing incremental MIDX chains, 2024-08-06) to
allow for preferred packfiles and incremental multi-pack-indexes.
However, this led to some conditions that can cause improperly
initialized memory in the context's list of packfiles.

The conditions caring about the preferred pack name or the incremental
flag are currently necessary to load a packfile. But the context is
still being populated with pack_info structs based on the packfile array
for the existing multi-pack-index even if prepare_midx_pack() isn't
called.

Add a new test that breaks under --stress when compiled with
SANITIZE=address. The chosen number of 100 packfiles was selected to get
the --stress output to fail about 50% of the time, while 50 packfiles
could not get a failure in most --stress runs. This test has a very
minor check at the end confirming only one packfile remaining. The
failing nature of this test actually relies on auto-GC cleaning up some
packfiles during the creation of the commits, as tests setting gc.auto
to zero make the packfile count match the number of added commits but
also avoids hitting the memory issue.

The test case is marked as EXPENSIVE not only because of the number of
packfiles it creates, but because some CI environments were reporting
errors during the test that I could not reproduce, specifically around
being unable to open the packfiles or their pack-indexes.

When it fails under SANITIZE=address, it provides the following error:

AddressSanitizer:DEADLYSIGNAL
=================================================================
==3263517==ERROR: AddressSanitizer: SEGV on unknown address 0x000000000027
==3263517==The signal is caused by a READ memory access.
==3263517==Hint: address points to the zero page.
    #0 0x562d5d82d1fb in close_pack_windows packfile.c:299
    #1 0x562d5d82d3ab in close_pack packfile.c:354
    #2 0x562d5d7bfdb4 in write_midx_internal midx-write.c:1490
    #3 0x562d5d7c7aec in midx_repack midx-write.c:1795
    #4 0x562d5d46fff6 in cmd_multi_pack_index builtin/multi-pack-index.c:305
    ...

This failure stack trace is disconnected from the real fix because it
the bad pointers are accessed later when closing the packfiles from the
context.

There are a few different aspects to this fix that are worth noting:

 1. We return to the previous behavior of fill_packs_from_midx to not
    rely on the incremental flag or existence of a preferred pack.

 2. The behavior to scan all layers of an incremental midx is kept, so
    this is not a full revert of the change.

 3. We skip allocating more room in the pack_info array if the pack
    fails prepare_midx_pack().

 4. The method has always returned 0 for success and 1 for failure, but
    the condition checking for error added a check for a negative result
    for failure, so that is now updated.

 5. The call to open_pack_index() is removed, but this is needed later
    in the case of a preferred pack. That call is moved to immediately
    before its result is needed (checking for the object count).

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 midx-write.c                | 38 ++++++++++++-------------------------
 t/t5319-multi-pack-index.sh | 17 +++++++++++++++++
 2 files changed, 29 insertions(+), 26 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index a0aceab5e0..d8f9679868 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -920,8 +920,7 @@ static struct multi_pack_index *lookup_multi_pack_index(struct repository *r,
 	return get_multi_pack_index(source);
 }
 
-static int fill_packs_from_midx(struct write_midx_context *ctx,
-				const char *preferred_pack_name, uint32_t flags)
+static int fill_packs_from_midx(struct write_midx_context *ctx)
 {
 	struct multi_pack_index *m;
 
@@ -929,30 +928,13 @@ static int fill_packs_from_midx(struct write_midx_context *ctx,
 		uint32_t i;
 
 		for (i = 0; i < m->num_packs; i++) {
-			ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
-
-			/*
-			 * If generating a reverse index, need to have
-			 * packed_git's loaded to compare their
-			 * mtimes and object count.
-			 *
-			 * If a preferred pack is specified, need to
-			 * have packed_git's loaded to ensure the chosen
-			 * preferred pack has a non-zero object count.
-			 */
-			if (flags & MIDX_WRITE_REV_INDEX ||
-			    preferred_pack_name) {
-				if (prepare_midx_pack(ctx->repo, m,
-						      m->num_packs_in_base + i)) {
-					error(_("could not load pack"));
-					return 1;
-				}
-
-				if (open_pack_index(m->packs[i]))
-					die(_("could not open index for %s"),
-					    m->packs[i]->pack_name);
+			if (prepare_midx_pack(ctx->repo, m,
+					      m->num_packs_in_base + i)) {
+				error(_("could not load pack"));
+				return 1;
 			}
 
+			ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
 			fill_pack_info(&ctx->info[ctx->nr++], m->packs[i],
 				       m->pack_names[i],
 				       m->num_packs_in_base + i);
@@ -1123,8 +1105,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 			ctx.num_multi_pack_indexes_before++;
 			m = m->base_midx;
 		}
-	} else if (ctx.m && fill_packs_from_midx(&ctx, preferred_pack_name,
-						 flags) < 0) {
+	} else if (ctx.m && fill_packs_from_midx(&ctx)) {
 		goto cleanup;
 	}
 
@@ -1223,6 +1204,11 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 
 	if (ctx.preferred_pack_idx > -1) {
 		struct packed_git *preferred = ctx.info[ctx.preferred_pack_idx].p;
+
+		if (open_pack_index(preferred))
+			die(_("failed to open preferred pack %s"),
+			    ctx.info[ctx.preferred_pack_idx].pack_name);
+
 		if (!preferred->num_objects) {
 			error(_("cannot select preferred pack %s with no objects"),
 			      preferred->pack_name);
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index bd75dea950..49705c62a2 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -989,6 +989,23 @@ test_expect_success 'repack --batch-size=0 repacks everything' '
 	)
 '
 
+test_expect_success EXPENSIVE 'repack/expire with many packs' '
+	cp -r dup many &&
+	(
+		cd many &&
+
+		for i in $(test_seq 1 100)
+		do
+			test_commit extra$i &&
+			git maintenance run --task=loose-objects || return 1
+		done &&
+
+		git multi-pack-index write &&
+		git multi-pack-index repack &&
+		git multi-pack-index expire
+	)
+'
+
 test_expect_success 'repack --batch-size=<large> repacks everything' '
 	(
 		cd dup2 &&
-- 
gitgitgadget

