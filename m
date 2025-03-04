Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C03524EAB5
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 21:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741124125; cv=none; b=P4D3VzBazb7ZJIIOMipCQRIy2h/K56nlAyn959ZDb7SuegxWy0jHYh5fUsI0Pp0u66ot3fUe+w5BlnLNw4+Zq6FHWunUuo8BhQZ7PG0NH80aJ64exvUAV6PkDdBXgP143BONBwNLRDvODRC0rY4+tCaTR+IjTWHaXbpBPnpoFxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741124125; c=relaxed/simple;
	bh=6h+PnqEnxJCoJ0+S62U4kFL44f5iWaJySfalzcp51TE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDTNPGcPx+oJWQg/Cy7TG8RfLm75goX8oA0tw2SpjzTjS+D9c9TAZT9ZBKOLsusZckqL/zV5TNCr1Vhbff66zKMuA67FfgJ+YvjfZobPHEpeCg1XT7Qc+SvLIziBWfmtgv5XItRl3ikVMqn8GXFysQEUdDOw8JEk0Tfc7SYMN08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=gek6yXaQ; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="gek6yXaQ"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6fd2587d059so37631457b3.3
        for <git@vger.kernel.org>; Tue, 04 Mar 2025 13:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741124122; x=1741728922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=goO+U+C3TVjKWYlo2LegdcUGd7zP3yMxXm/oYZ2qndQ=;
        b=gek6yXaQJwatcrPkdgq46jsYtjYpc8RWcS27YPCoRlSeEv0z/Jt6jmvuYPxHg3AHsZ
         mY6M+ek1LAKUueoiT1lfgYGbq32tDRd0WUSUFjX6wn3/h2fyUO+APr3sFPG5hOr3bkl9
         mo04WkZsn2cA2coAEmVoNn/5gPOAZXf27vCW0WNJRDNWFuW/mE8/yu7tjZaHt5EGnXey
         I1KFEwvyGyrs2sSzd4I6Qo1RGwnv4MqaL5Jc+s6vJ72KepBkds3n6cTWO1Rhq4d4AzKl
         bVAUK8y6D2gu1P99wl4FNskQOiZhkZ9Q4v/rb9OgpCpWguHP3d/5hTjghxuXOtRldZVd
         gtFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741124122; x=1741728922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=goO+U+C3TVjKWYlo2LegdcUGd7zP3yMxXm/oYZ2qndQ=;
        b=H5e3IiTN5Q5U1iDs+KT8fm85GPWoeDRBg5hwrcdFyY9GZ7cJ1BtCExps7JJUsQigIA
         KFw0275v7PhXzTZY0BISTuGW8BwD1LxbWBcj3ez6+vX+srIlPyMCizYJfwqHY9k5usgT
         TaoDF1LkTrTbg07mGJpBPdVeEzkKY1t8/w76Grhzf0PLZySKDBsAh4Fs3JTFiwJifOWz
         NWthAggm0eJwzyTMLBEh1yxGf6viPFOhxH/soW79MnOfetbFWybnplbEremjXoJ5JD2i
         c4soaEoZ1xGz+cKV2dcZ0uh6BkzSXoUOTzL2F94eTKnE3BKH1ZxdI4k6AHtaQnHNN36i
         WSyg==
X-Gm-Message-State: AOJu0YwdWkOaEKMIfEWifMo+F5FYLerR2UXvJyi2Vpgg+5L8tzsWjS8D
	msOL7D5xPOFOhW0SLgosHHnTuaN3rhnJtv1R1KIXcNw9hxZSvVNP9r/2rndT31Tk6sm2G4FXh5e
	3
X-Gm-Gg: ASbGncsmWR50j9eC3Q4GFDgaxizZ1L5TEj/3bhhQlAD0bNi4LdEqAEF+by5ehvJcjxN
	mzbQx4VLMdTo8NZXDyE58hHFxcSMpEr5LlYXSd4PjF7SN1sAqsVsj0oxll9QY71Tb5mieCM+FeR
	MPPAtdtvz6pUue2oDPmDPmf+kd48bhNGnbbuQzi6JgmoZwovMrTiP7N0+AQZ9ZS267SiRkg+MNU
	RN50t8PthUo0MIro+fz9iKgXPTXMv6aL/SBWStu7HsE4KqKGI4XH03wIv4sPJYMbzluCkFr1tRF
	owenHu7UtWAS1B5Bw549vFEW4j/TqXaHOjy5DmABSgEZBbjqlhMpXsLUrLzpSJeZnF13ZiIk5vm
	kWowf8lepx5QE7k9m
X-Google-Smtp-Source: AGHT+IGswmAuT9GuWRuOZKUxeN61XGNecVV0RBpZ61aTCPcMZ/zk9koSs73Lj9IN4fk2FLTnJrr+0g==
X-Received: by 2002:a05:690c:64c1:b0:6f9:45de:408f with SMTP id 00721157ae682-6fda30f8de1mr14402637b3.35.1741124122129;
        Tue, 04 Mar 2025 13:35:22 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6fd3ca0eb78sm26427087b3.12.2025.03.04.13.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 13:35:21 -0800 (PST)
Date: Tue, 4 Mar 2025 16:35:20 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 1/2] builtin/repack.c: simplify cruft pack aggregation
Message-ID: <63ea9d4d00ee3a54071f1bf585b7cf95227cca9b.1741124117.git.me@ttaylorr.com>
References: <cover.1740680964.git.me@ttaylorr.com>
 <cover.1741124116.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1741124116.git.me@ttaylorr.com>

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

There is a much simpler way to combine cruft packs, however, which is to
simply combine *all* cruft packs which are smaller than the threshold,
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
2.49.0.rc0.57.gdb91954e186.dirty

