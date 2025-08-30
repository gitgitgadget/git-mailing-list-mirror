Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50232441B8
	for <git@vger.kernel.org>; Sat, 30 Aug 2025 21:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756589014; cv=none; b=Lez08251Pm/X5cbClTBkbR3tYJJntop9Wx8mwU7vBb3CMUf+8xvZqz7qXbZ3ykS8yE1mIZuiCtSfF9714H8eMgGsZa7t4789If65TRShmkoFvrxXM7Mnhhso5ppqwUei7RoUvbcxRFYVy9Q5RzW5WB/iaIYOg/1epE/lF9EH3a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756589014; c=relaxed/simple;
	bh=GG5IuBWmdsEXRipfC5+/rodcOziicIznKokAFjacaD8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JVMjD2edNDEqtzEV4RqJLeLYjsN38oyWiIYXuptNsZbi/e4ksbgIb9KXejSrgxKCCDySyNUyo+mhOBLS4QPTIT/dq7cQlDkQJUGO/ZGNXLoKxPM3ewxyBF1lSAg/wfFRxljFjkJzkelr4H/ts8poobtAhRFE/141l6YE5YPh05M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7i5P2N9; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7i5P2N9"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b310f0449bso11389111cf.2
        for <git@vger.kernel.org>; Sat, 30 Aug 2025 14:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756589011; x=1757193811; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85LlYTbhtDvt39WSHiofncoxI6MxNrlwL8j4cQMBoAU=;
        b=D7i5P2N9o1S3TWr64317TI6IjHXsYqMqQsWXEgPacLEU29/oXGteFrkozngWvqy/KA
         OUce1tmkndVL2vRU8Hg2F554hV3sL9mlOR39omkpZBo5DrlzgUO1pFRta+r6m0lsSce8
         yDCorE3WY6Dp1gzDIw3MC7OMt8tPejhshXEcdKLg+FOsgi9vTZr0YUmdeG1N/vbGm9lL
         8XJBeLx9qVEh4fxYJHcI0f0/eH6XX3u4Uno8qThg3JB9kGHqr1zNHGFIsjpmpWBnLNR/
         QsKld8WkbZTIQ9pLVbtkRLpcwEpiQxRnSfjzwHHZaYf1twBtfiZkCAJXIE+nYsA6Ek9D
         hr2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756589011; x=1757193811;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=85LlYTbhtDvt39WSHiofncoxI6MxNrlwL8j4cQMBoAU=;
        b=OcDPMhUDUTRksIP+O1yCohegbcBGzQZgGbVvfLOUDAjcECA9IH+wCZixDKCXsZdv7e
         iJ7Gwj8/kH5Vj9IGnVC8U3ySSgyMXZBQmSB+KUyzAlIDE2cvPQIVrGkwgTMLzNXqYcBQ
         BoaBg3G9I3HjSSumKAAYNWPUqpgPxqlc1HukK7M9Z5NsRVt0BkKMbYcfcImFx9l27MDs
         YDtyhWEK0kyrO1uvG4EWxwAWnadMyG/b5JGBk2aOsDOsnNsZdUEKfdvT9sTr8MKglRJf
         6+GPEkYGvakdRfEVkU5tN0CXl27T8M6ivz/tt4cuUBIB3X3/2XOwG92TN3u5HiMnZGQl
         5mAg==
X-Gm-Message-State: AOJu0YwkQ+N9rIENR4MnJGJXEWha+g+IoIDT15uVBXULN3sAUIgNKWAc
	0mpHlr+N0eEHnIpQOvH2J11rHX9CW5t9bz6lwnDGPqp3JoK1Yp+AMH/nOEsf0AzZ
X-Gm-Gg: ASbGnct9cMZwGq1bitPItHtEq65ODgbbsk1AUMAH2UrIF/X8YVMl7jH9jtRefOXI5bD
	4SkjSuTSdSV0l81RwQxN9ANflip8AkvkCx/sd4SqtcBNFKPxxPXETPeqaE2jdAm7NsUps12bN5K
	tXCRkucGMCz/mkhnHETdJ3c0nwnfSkBt6qvT6kElv0JyXqOYi5oTuu6JKOEZZ40AJniS5C9lXDF
	nUS3rK/3bBkH4nPBkuO6MQ0p3NWTGKYXUn0lvCri4kJ4ihEH8xea3YU+xynTPbBlsu6WEivWwCq
	9DDQcpiuGj6WrMmdn3h1C8DGbxqznDhdu9GAmYlraxespGB6KEzByuSG7BYAha/SxvQVm5YWBRy
	9Hdi4dM5MbIy0pd4SrbLTehJDPGVO5paZ+zOA
X-Google-Smtp-Source: AGHT+IHUmc+5z9KmaYgsJSPlc2mLel2DiUSYia3PuXNwUrmyEVd1vDpvZdFErSI0Z82eoUaoIplnXA==
X-Received: by 2002:a05:6214:2262:b0:70f:a04f:233b with SMTP id 6a1803df08f44-70fac88dbaamr34607366d6.32.1756589011072;
        Sat, 30 Aug 2025 14:23:31 -0700 (PDT)
Received: from [127.0.0.1] ([145.132.103.19])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70fb25c86f8sm11540516d6.6.2025.08.30.14.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 14:23:30 -0700 (PDT)
Message-Id: <e02a444315acbc638a3d31279c10a936f0adb7b4.1756589007.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1965.v2.git.1756589007.gitgitgadget@gmail.com>
References: <pull.1965.git.1756402795.gitgitgadget@gmail.com>
	<pull.1965.v2.git.1756589007.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 30 Aug 2025 21:23:22 +0000
Subject: [PATCH v2 1/6] midx-write: only load initialized packs
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
could not get a failure in most --stress runs.

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

This failure stack trace is disconnected from the real fix because the bad
pointers are accessed later when closing the packfiles from the context.

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
 midx-write.c                | 46 +++++++++++++++----------------------
 t/t5319-multi-pack-index.sh | 17 ++++++++++++++
 2 files changed, 36 insertions(+), 27 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index a0aceab5e0..070a7f61f4 100644
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
 
@@ -929,30 +928,11 @@ static int fill_packs_from_midx(struct write_midx_context *ctx,
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
-			}
+			if (prepare_midx_pack(ctx->repo, m,
+					      m->num_packs_in_base + i))
+				return error(_("could not load pack"));
 
+			ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
 			fill_pack_info(&ctx->info[ctx->nr++], m->packs[i],
 				       m->pack_names[i],
 				       m->num_packs_in_base + i);
@@ -1123,8 +1103,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 			ctx.num_multi_pack_indexes_before++;
 			m = m->base_midx;
 		}
-	} else if (ctx.m && fill_packs_from_midx(&ctx, preferred_pack_name,
-						 flags) < 0) {
+	} else if (ctx.m && fill_packs_from_midx(&ctx)) {
 		goto cleanup;
 	}
 
@@ -1186,6 +1165,13 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 		struct packed_git *oldest = ctx.info[ctx.preferred_pack_idx].p;
 		ctx.preferred_pack_idx = 0;
 
+		/*
+		 * Attempt opening the pack index to populate num_objects.
+		 * Ignore failiures as they can be expected and are not
+		 * fatal during this selection time.
+		 */
+		open_pack_index(oldest);
+
 		if (packs_to_drop && packs_to_drop->nr)
 			BUG("cannot write a MIDX bitmap during expiration");
 
@@ -1200,6 +1186,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 
 			if (!oldest->num_objects || p->mtime < oldest->mtime) {
 				oldest = p;
+				open_pack_index(oldest);
 				ctx.preferred_pack_idx = i;
 			}
 		}
@@ -1223,6 +1210,11 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 
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

