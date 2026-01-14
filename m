Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C55346E71
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 19:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768420517; cv=none; b=ZKaEguiaTSPLV2pbIgMHJa+IV7imSOcPGBsSCRzcUrHtnUA7SyPhZDpWR/bntvnnNU4UivOAu8lk5GUtoZY2nCpTrYgicyS62o4JmqpAmmvdCXppvTyNCZXzY7ZXbJr/CTrB/9Khy3ATmh5ZwYqEEyT6KAVvAF94KS0vCHdkk2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768420517; c=relaxed/simple;
	bh=V44LUQxj5Zw7PjY2NBDrreFhAVFejcYp6lWw3vWRkNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mzXzLlx149Mu6FL7l6M61LKDK/Ruqo03a0aIFYOVGJu8HwEf7FjQynEwlKX43PGaX2V2aEP/VW0++TeEWtwvNz+V/YYZft8lVnnq782cDcLI5pbVKKCTS3r41LSkM7skwk3nZFnOw1dcHYbGLXk/inNwKimL3su60x1/+Jio7gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=HUxz1F5x; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="HUxz1F5x"
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-78c66bdf675so1255037b3.2
        for <git@vger.kernel.org>; Wed, 14 Jan 2026 11:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1768420515; x=1769025315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UFxDGAmLfp2Cngozna92dk1FPFVyWFJPIoNJTwsaqMc=;
        b=HUxz1F5xGyI4UZea9FDhuCbEB/eXqgdOOhvAvTMjr3eMaOZ8Oi0NvC2ltZ4ZdQO7/1
         9ZF7t1aasd3Z1ZulwPtOxGvhEd+udhamSRl+sPAovV7pRzX8qyC24DJLCwbEouefcA3T
         Q5A1WUMmaZ5IFrCQFnqM4IA7FLRjh94NUyvmTKbWlc2Mn5llS6yx0fXtIdA3YuZ9euCP
         MtY2S5PgGHqBy66QK0lB8zO1KcVwNl1lyqtv+iSo7plITl7/xlclw1JnvjD/SVph9A2L
         hydh1pYXQFfSF7zVL2L24xUJ6GrnO5icsqOULkbOGvll0NJH64psuBbht8GCHqBRk5VW
         uhYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768420515; x=1769025315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UFxDGAmLfp2Cngozna92dk1FPFVyWFJPIoNJTwsaqMc=;
        b=fSZMjA+/1OBDY/XwpN7a5hAPlnna2PGRSqn8Sov7fI9L997CX0UimQqy1t4uZ5Iu53
         MzJqla6xvbFL4c5L1pTzNQ/R3yvScfrUFLIxEBhSJh2k9iDsBE709diQxTT2N9iwtC5s
         xqAvGWSiDvpjrXLaa/z7glEu3Wd6OtlEIlHzkSnDNs7hWHmG6g5qZge9Z+Lpm6pEdVz5
         dXNO1GERbjHxbZlKNqLCbHqvO0fzrpOViIvC2TgPE7g94gIasD1f9uPM+Ok9Yk4t316K
         dMJ2L8w1Nk826aHJPurn9TMV/kbjzDBg410iufmp/nlYLfJUYKH5zHM/pH1YS3jV+ZAz
         p8EA==
X-Gm-Message-State: AOJu0Yzet6ws6UAUFO7zuqB9NXa4YSoJ1x0+YLYT+VvOtOkGCrrGk97T
	XU4aAzltpgwLM4Q+xCru9++gK3QUW5JA23NInEcEJ+5zGjLMU/IlYuEAFpe90XDl8KeqgysMwcv
	sz0kwd4eRvpZV
X-Gm-Gg: AY/fxX7dnC1Q42sRnmkmCF2bkej8MDEDgilkh8L33Nme4fFxKefMUPjirZFS+aWYQph
	Fq6hw7LKL9oZgOO9eXfIVILRVC6LKlo3nZ1JHUltmdcLDsP3+sjKnpzvo5Xh75GsBo4Q3Lczw4J
	nRci8K7jF/L22JOv4CChp7Gxm9uxsTwbQtxJUllpF1g7SgqQ6+Om/fcVfGFZNIeNySEYPoWQfs4
	YI7+NRcViuLjUGBXvAB+99SnLl3z05FVgB94Kisa4286XUXhc0BG2U9mUUbwNzD8sh2HMs+8N2j
	eiV8O4n5jJvMb1tFELQyI7kFbUqlURrr0H205m9KlqMmpbpsFnjP/CxjCwK/vwXc8T8eaYjlwB5
	O6kHakK0IkM5WFOZj4XOPwBmc5a0oSwdbHtQv9dljnC7TtUjGBTlOSwDa4kGcKmPK83EPR4M/zT
	9tEDJ6NfvE1famFTzQS7G+62M+C5+yMjAH4EnvvSl9GkT/rlFcwMKvMG3k7xM6WaZ1HJSvLV10K
	EdC0U4VtMSOp23YrQ==
X-Received: by 2002:a05:690e:1c1c:b0:645:443d:10a8 with SMTP id 956f58d0204a3-64901b1a5b0mr2954812d50.75.1768420514765;
        Wed, 14 Jan 2026 11:55:14 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d7f81bdsm10897098d50.1.2026.01.14.11.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 11:55:14 -0800 (PST)
Date: Wed, 14 Jan 2026 14:55:13 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 18/18] midx: enable reachability bitmaps during MIDX
 compaction
Message-ID: <b599f1ad4b0e0c9be5f027417bf343b52aed6e84.1768420450.git.me@ttaylorr.com>
References: <cover.1765053054.git.me@ttaylorr.com>
 <cover.1768420450.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1768420450.git.me@ttaylorr.com>

Enable callers to generate reachability bitmaps when performing MIDX
layer compaction by combining all existing bitmaps from the compacted
layers.

Note that because of the object/pack ordering described by the previous
commit, the pseudo-pack order for the compacted MIDX is the same as
concatenating the individual pseudo-pack orderings for each layer in the
compaction range.

As a result, the only non-test or documentation change necessary is to
treat all objects as non-preferred during compaction so as not to
disturb the object ordering.

In the future, we may want to adjust which commit(s) receive
reachability bitmaps when compacting multiple .bitmap files into one, or
even generate new bitmaps (e.g., if the references have moved
significantly since the .bitmap was generated). This commit only
implements combining all existing bitmaps in range together in order to
demonstrate and lay the groundwork for more exotic strategies.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-multi-pack-index.adoc |   5 +-
 builtin/multi-pack-index.c              |   4 +-
 midx-write.c                            |   2 +-
 t/t5335-compact-multi-pack-index.sh     | 122 +++++++++++++++++++++++-
 4 files changed, 128 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-multi-pack-index.adoc b/Documentation/git-multi-pack-index.adoc
index 883a0529741..61256830141 100644
--- a/Documentation/git-multi-pack-index.adoc
+++ b/Documentation/git-multi-pack-index.adoc
@@ -13,7 +13,7 @@ SYNOPSIS
 		         [--[no-]bitmap] [--[no-]incremental] [--[no-]stdin-packs]
 		         [--refs-snapshot=<path>]
 'git multi-pack-index' [<options>] compact [--[no-]incremental]
-		         <from> <to>
+		         [--[no-]bitmap] <from> <to>
 'git multi-pack-index' [<options>] verify
 'git multi-pack-index' [<options>] expire
 'git multi-pack-index' [<options>] repack [--batch-size=<size>]
@@ -94,6 +94,9 @@ compact::
 	--incremental::
 		Write the result to a MIDX chain instead of writing a
 		stand-alone MIDX.
+
+	--[no-]bitmap::
+		Control whether or not a multi-pack bitmap is written.
 --
 
 verify::
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 043ee8c478a..2f24c113c8f 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -19,7 +19,7 @@
 
 #define BUILTIN_MIDX_COMPACT_USAGE \
 	N_("git multi-pack-index [<options>] compact [--[no-]incremental]\n" \
-	   "  <from> <to>")
+	   "  [--[no-]bitmap] <from> <to>")
 
 #define BUILTIN_MIDX_VERIFY_USAGE \
 	N_("git multi-pack-index [<options>] verify")
@@ -216,6 +216,8 @@ static int cmd_multi_pack_index_compact(int argc, const char **argv,
 
 	struct option *options;
 	static struct option builtin_multi_pack_index_compact_options[] = {
+		OPT_BIT(0, "bitmap", &opts.flags, N_("write multi-pack bitmap"),
+			MIDX_WRITE_BITMAP | MIDX_WRITE_REV_INDEX),
 		OPT_BIT(0, "incremental", &opts.flags,
 			N_("write a new incremental MIDX"), MIDX_WRITE_INCREMENTAL),
 		OPT_END(),
diff --git a/midx-write.c b/midx-write.c
index afa077a09cc..4c52843db9b 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -669,7 +669,7 @@ static uint32_t *midx_pack_order(struct write_midx_context *ctx)
 		struct pack_midx_entry *e = &ctx->entries[i];
 		data[i].nr = i;
 		data[i].pack = midx_pack_perm(ctx, e->pack_int_id);
-		if (!e->preferred)
+		if (!e->preferred || ctx->compact)
 			data[i].pack |= (1U << 31);
 		data[i].offset = e->offset;
 	}
diff --git a/t/t5335-compact-multi-pack-index.sh b/t/t5335-compact-multi-pack-index.sh
index 797ae05c3bd..40f3844282f 100755
--- a/t/t5335-compact-multi-pack-index.sh
+++ b/t/t5335-compact-multi-pack-index.sh
@@ -67,7 +67,7 @@ test_expect_success 'MIDX compaction with lex-ordered pack names' '
 		write_packs A B C D E &&
 		test_line_count = 5 $midx_chain &&
 
-		git multi-pack-index compact --incremental \
+		git multi-pack-index compact --incremental --bitmap \
 			"$(nth_line 2 "$midx_chain")" \
 			"$(nth_line 4 "$midx_chain")" &&
 		test_line_count = 3 $midx_chain &&
@@ -90,7 +90,7 @@ test_expect_success 'MIDX compaction with non-lex-ordered pack names' '
 		write_packs D C A B E &&
 		test_line_count = 5 $midx_chain &&
 
-		git multi-pack-index compact --incremental \
+		git multi-pack-index compact --incremental --bitmap \
 			"$(nth_line 2 "$midx_chain")" \
 			"$(nth_line 4 "$midx_chain")" &&
 		test_line_count = 3 $midx_chain &&
@@ -172,4 +172,122 @@ test_expect_success 'MIDX compaction with midx.version=1' '
 	)
 '
 
+midx_objs_by_pack () {
+	awk '/\.pack$/ { split($3, a, "-"); print a[2], $1 }' | sort
+}
+
+tag_objs_from_pack () {
+	objs="$(git rev-list --objects --no-object-names "$2")" &&
+	printf "$1 %s\n" $objs | sort
+}
+
+test_expect_success 'MIDX compaction preserves pack object selection' '
+	git init midx-compact-preserve-selection &&
+	(
+		cd midx-compact-preserve-selection &&
+
+		git config maintenance.auto false &&
+
+		test_commit A &&
+		test_commit B &&
+
+		# Create two packs, one containing just the objects from
+		# A, and another containing all objects from the
+		# repository.
+		p1="$(echo A | git pack-objects --revs --delta-base-offset \
+			$packdir/pack-1)" &&
+		p0="$(echo B | git pack-objects --revs --delta-base-offset \
+			$packdir/pack-0)" &&
+
+		echo "pack-1-$p1.idx" | git multi-pack-index write \
+			--incremental --bitmap --stdin-packs &&
+		echo "pack-0-$p0.idx" | git multi-pack-index write \
+			--incremental --bitmap --stdin-packs &&
+
+		write_packs C &&
+
+		git multi-pack-index compact --incremental --bitmap \
+			"$(nth_line 1 "$midx_chain")" \
+			"$(nth_line 2 "$midx_chain")" &&
+
+
+		test-tool read-midx --show-objects $objdir \
+			"$(nth_line 1 "$midx_chain")" >AB.info &&
+		test-tool read-midx --show-objects $objdir \
+			"$(nth_line 2 "$midx_chain")" >C.info &&
+
+		midx_objs_by_pack <AB.info >AB.actual &&
+		midx_objs_by_pack <C.info >C.actual &&
+
+		{
+			tag_objs_from_pack 1 A &&
+			tag_objs_from_pack 0 A..B
+		} | sort >AB.expect &&
+		tag_objs_from_pack C B..C >C.expect &&
+
+		test_cmp AB.expect AB.actual &&
+		test_cmp C.expect C.actual
+	)
+'
+
+test_expect_success 'MIDX compaction with bitmaps' '
+	git init midx-compact-with-bitmaps &&
+	(
+		cd midx-compact-with-bitmaps &&
+
+		git config maintenance.auto false &&
+
+		write_packs foo bar baz quux woot &&
+
+		test-tool read-midx --bitmap $objdir >bitmap.expect &&
+		git multi-pack-index compact --incremental --bitmap \
+			"$(nth_line 2 "$midx_chain")" \
+			"$(nth_line 4 "$midx_chain")" &&
+		test-tool read-midx --bitmap $objdir >bitmap.actual &&
+
+		test_cmp bitmap.expect bitmap.actual &&
+
+		true
+	)
+'
+
+test_expect_success 'MIDX compaction with bitmaps (non-trivial)' '
+	git init midx-compact-with-bitmaps-non-trivial &&
+	(
+		cd midx-compact-with-bitmaps-non-trivial &&
+
+		git config maintenance.auto false &&
+
+		git branch -m main &&
+
+		#               D(4)
+		#              /
+		# A(1) --- B(2) --- C(3) --- G(7)
+		#              \
+		#               E(5) --- F(6)
+		write_packs A B C &&
+		git checkout -b side &&
+		write_packs D &&
+		git checkout -b other B &&
+		write_packs E F &&
+		git checkout main &&
+		write_packs G &&
+
+		# Compact layers 2-4, leaving us with:
+		#
+		#  [A, [B, C, D], E, F, G]
+		git multi-pack-index compact --incremental --bitmap \
+			"$(nth_line 2 "$midx_chain")" \
+			"$(nth_line 4 "$midx_chain")" &&
+
+		# Then compact the top two layers, condensing the above
+		# such that the new 4th layer contains F and G.
+		#
+		#  [A, [B, C, D], E, [F, G]]
+		git multi-pack-index compact --incremental --bitmap \
+			"$(nth_line 4 "$midx_chain")" \
+			"$(nth_line 5 "$midx_chain")"
+	)
+'
+
 test_done
-- 
2.52.0.457.gb599f1ad4b0
