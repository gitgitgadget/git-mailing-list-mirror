Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C786B20B1E1
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 18:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740680972; cv=none; b=SL4m0CHI72QUuPYDWd8mOZ/0avB9Z5OsziErbxp69Oum6g37++FTZMob11os1zbTgAzdQ9iMKt6AX9Eilu86hCcAYutUYCAaGHTDY8atd7FRsRw9aABwFExae3NPjtfJad+mA4gW+Qyr6Dh1MLHuEe2dh9pyk81LJYHKSsB8qhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740680972; c=relaxed/simple;
	bh=d4sabs5Ks2PUi+jFHExXZm9STW9zUGZSscwdIFNmBKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kq607Vz6e9OVAxOSSpq6NgjvM927hF1Cdt4qQtC3Ts2m3ka18Rf5C1BqgAnHkINPtIuQ4Ke64/9q4J0lonLT4yCdw5zPuVB0m+PLlzeecbuWPkqxDY+nu7at+4I0EIHeIBLsTiNpmoKbfF4v9B3wAoofsjaW31yD+5F7uCxYS9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ALpAxsw0; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ALpAxsw0"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6f88509dad2so12592037b3.3
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 10:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1740680969; x=1741285769; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LGaep0boiJCzl2bzVSWQZ6g+4TUx8NLYM8XPL8alPAw=;
        b=ALpAxsw0s3bsoVJK4k9FxX1sv6zDRgYeNwCmG474mBxeIg15sHQklqs8X5pAZwN+EF
         8DLeXlWyC/P4n1WZAXAX8T1lZYltLW4Oy4XF3hGHVxmNsrQvpxftXAotv0yyW8PcaOdH
         tW3Qpv8Bwy/wvc8ecvN4Ds41Gr08WHMZ18mvYTaQuTEReyL8kQk4UfEQT/67m7quyFc2
         EUmhzXze8aX84EUgWHUDrCslzel43rDPH1ElJ1oVCzMBQmyT6FkPvToi9NRNJl3FrvKv
         Hn0FnWUmOPlqMXgel55cFEtaPdmn5TgqcpDaX2KKgHlbBAIJbl4q+BrJLqUt5pOXEGS4
         TXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740680969; x=1741285769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGaep0boiJCzl2bzVSWQZ6g+4TUx8NLYM8XPL8alPAw=;
        b=U05JciZfsOZVSMrX3nwPlntWc4G2f1ccR40TZdVsvozvNVH9sUDhYabvfAIHEAM8ic
         9D3UrY1wRGuf5ASm33aJltywKLu0900lstMoyfFZTeEV4yOR+XtgBuZSYyEe8tXp/v1A
         9gC4DCJ19YlLvUpedfIqK+gj/84FAXlCg+l+Vc+zqfB8XwXHpxAllwbKfDZx5NkwBIei
         JjHazu4Eu0CrpgOlTQJHKg925iN9gZ+ShhqoPl46OYNLWiHFdTMoO/j9UaLF54GA34Rq
         hFg0ToTANQIrpMVLTUBwnjVa1rgBD4NCgDc259xzSqpyFq9H7TAb0dQSx/ATIKaCgp35
         0XZQ==
X-Gm-Message-State: AOJu0YzLmdeYWNtsoygiJymjGM5eJREGLaexZocPog1LcZ8M17VomDKO
	iHlltZICPI1U+K6PHtY9KyqGozcrFJD3tmZAXxz27nGwMTe+rYMEA5K7ARxEputtZgkyfchwx+G
	D
X-Gm-Gg: ASbGncsxAT5EdITCMi1ydgwrskhS8z+ivk7UnJoWsPdc15ce8h8GW3d1iS3DehU/ZYE
	+9w0GAzM2RI1/KolaDYp93SAbnIQDc65qPXBnpyGUtLDgBYeojk2Vv21OArAy19DRvPIRORSIoN
	6iFHndbuLUiTZn4LFxN/E+Zzn3TSwwTxKLStKbuZ9tu3YHh9Z8V/V0tYWtRwQngBtr13N1fhZOm
	Pnc5i9vq7ZkA09D2lCu4JW1zl36UE+JjggljVsMJ8bCzvzXEios5zD9wnNzAyB8FaAOqDl2Iq8j
	sONZvtM0wxUbbpxkA4c2GlegoZ/bxU2DyF9DXQ/AE/sAn9Cd/mb6FOoFAAJMgWmGGHAOoYJzGw=
	=
X-Google-Smtp-Source: AGHT+IGVbHjDJIttRmNWGG9XKcAqSoFlhk3k96Wr8Qce4C3suryLzMp/x5XrPxmZrf7tVymfVHBRhQ==
X-Received: by 2002:a05:690c:7006:b0:6f9:e45d:8a32 with SMTP id 00721157ae682-6fd4a12e1afmr6861827b3.23.1740680969593;
        Thu, 27 Feb 2025 10:29:29 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6fd3cb7e1f9sm3894007b3.88.2025.02.27.10.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 10:29:29 -0800 (PST)
Date: Thu, 27 Feb 2025 13:29:28 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH 1/2] builtin/repack.c: simplify cruft pack aggregation
Message-ID: <8564f98259727225391edcb5ab3b47dd53f00e48.1740680964.git.me@ttaylorr.com>
References: <cover.1740680964.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1740680964.git.me@ttaylorr.com>

In 37dc6d8104 (builtin/repack.c: implement support for
`--max-cruft-size`, 2023-10-02), 'git repack' built on support for
multiple cruft packs in Git by instructing 'git pack-objects --cruft'
how to aggregate smaller cruft packs up to the provided threshold.

The implementation in 37dc6d8104 worked something like the following
pseudo-code:

    total_size = 0;

    for (p in cruft packs) {
      if (p->pack_size + total_size < max_size) {
        total_size += p->pack_size;
        collapse(p)
      } else {
        retain(p);
      }
    }

The original idea behind this approach was that smaller cruft packs
would get combined together until the sum of their sizes was no larger
than the given max pack size.

There is a much simpler way to achieve this, however, which is to simply
combine *all* cruft packs which are smaller than the threshold,
regardless of what their sum is. With '--max-pack-size', 'pack-objects'
will split out the resulting pack into individual pack(s) if necessary
to ensure that the written pack(s) are each no larger than the provided
threshold.

This yields a slight behavior change, which is reflected in the removed
test. Previous to this change, we would aggregate smaller cruft packs
first, whereas now we will opportunistically combine as many cruft packs
as possible. As as result, that test is no longer relevant, and can be
deleted.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c        | 38 ++-----------------------------------
 t/t7704-repack-cruft.sh | 42 -----------------------------------------
 2 files changed, 2 insertions(+), 78 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 75e3752353a..4d83d40f39f 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -1022,29 +1022,13 @@ static int write_filtered_pack(const struct pack_objects_args *args,
 	return finish_pack_objects_cmd(&cmd, names, local);
 }
 
-static int existing_cruft_pack_cmp(const void *va, const void *vb)
-{
-	struct packed_git *a = *(struct packed_git **)va;
-	struct packed_git *b = *(struct packed_git **)vb;
-
-	if (a->pack_size < b->pack_size)
-		return -1;
-	if (a->pack_size > b->pack_size)
-		return 1;
-	return 0;
-}
-
 static void collapse_small_cruft_packs(FILE *in, size_t max_size,
 				       struct existing_packs *existing)
 {
-	struct packed_git **existing_cruft, *p;
+	struct packed_git *p;
 	struct strbuf buf = STRBUF_INIT;
-	size_t total_size = 0;
-	size_t existing_cruft_nr = 0;
 	size_t i;
 
-	ALLOC_ARRAY(existing_cruft, existing->cruft_packs.nr);
-
 	for (p = get_all_packs(the_repository); p; p = p->next) {
 		if (!(p->is_cruft && p->pack_local))
 			continue;
@@ -1056,24 +1040,7 @@ static void collapse_small_cruft_packs(FILE *in, size_t max_size,
 		if (!string_list_has_string(&existing->cruft_packs, buf.buf))
 			continue;
 
-		if (existing_cruft_nr >= existing->cruft_packs.nr)
-			BUG("too many cruft packs (found %"PRIuMAX", but knew "
-			    "of %"PRIuMAX")",
-			    (uintmax_t)existing_cruft_nr + 1,
-			    (uintmax_t)existing->cruft_packs.nr);
-		existing_cruft[existing_cruft_nr++] = p;
-	}
-
-	QSORT(existing_cruft, existing_cruft_nr, existing_cruft_pack_cmp);
-
-	for (i = 0; i < existing_cruft_nr; i++) {
-		size_t proposed;
-
-		p = existing_cruft[i];
-		proposed = st_add(total_size, p->pack_size);
-
-		if (proposed <= max_size) {
-			total_size = proposed;
+		if (p->pack_size < max_size) {
 			fprintf(in, "-%s\n", pack_basename(p));
 		} else {
 			retain_cruft_pack(existing, p);
@@ -1086,7 +1053,6 @@ static void collapse_small_cruft_packs(FILE *in, size_t max_size,
 			existing->non_kept_packs.items[i].string);
 
 	strbuf_release(&buf);
-	free(existing_cruft);
 }
 
 static int write_cruft_pack(const struct pack_objects_args *args,
diff --git a/t/t7704-repack-cruft.sh b/t/t7704-repack-cruft.sh
index 959e6e26488..5a76b541ddd 100755
--- a/t/t7704-repack-cruft.sh
+++ b/t/t7704-repack-cruft.sh
@@ -194,48 +194,6 @@ test_expect_success '--max-cruft-size combines existing packs when below thresho
 	)
 '
 
-test_expect_success '--max-cruft-size combines smaller packs first' '
-	git init max-cruft-size-consume-small &&
-	(
-		cd max-cruft-size-consume-small &&
-
-		test_commit base &&
-		git repack -ad &&
-
-		cruft_foo="$(generate_cruft_pack foo 524288)" &&    # 0.5 MiB
-		cruft_bar="$(generate_cruft_pack bar 524288)" &&    # 0.5 MiB
-		cruft_baz="$(generate_cruft_pack baz 1048576)" &&   # 1.0 MiB
-		cruft_quux="$(generate_cruft_pack quux 1572864)" && # 1.5 MiB
-
-		test-tool pack-mtimes "$(basename $cruft_foo)" >expect.raw &&
-		test-tool pack-mtimes "$(basename $cruft_bar)" >>expect.raw &&
-		sort expect.raw >expect.objects &&
-
-		# repacking with `--max-cruft-size=2M` should combine
-		# both 0.5 MiB packs together, instead of, say, one of
-		# the 0.5 MiB packs with the 1.0 MiB pack
-		ls $packdir/pack-*.mtimes | sort >cruft.before &&
-		git repack -d --cruft --max-cruft-size=2M &&
-		ls $packdir/pack-*.mtimes | sort >cruft.after &&
-
-		comm -13 cruft.before cruft.after >cruft.new &&
-		comm -23 cruft.before cruft.after >cruft.removed &&
-
-		test_line_count = 1 cruft.new &&
-		test_line_count = 2 cruft.removed &&
-
-		# the two smaller packs should be rolled up first
-		printf "%s\n" $cruft_foo $cruft_bar | sort >expect.removed &&
-		test_cmp expect.removed cruft.removed &&
-
-		# ...and contain the set of objects rolled up
-		test-tool pack-mtimes "$(basename $(cat cruft.new))" >actual.raw &&
-		sort actual.raw >actual.objects &&
-
-		test_cmp expect.objects actual.objects
-	)
-'
-
 test_expect_success 'setup --max-cruft-size with freshened objects' '
 	git init max-cruft-size-freshen &&
 	(
-- 
2.49.0.rc0.2.gc0c926adde2

