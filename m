Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E33288D6
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 00:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741652514; cv=none; b=CMlwGiC8hg8JZUZXFePhO/NValKkqGyZUVrWz2jB6Xy/zzseUiIniyrpav3wGdNADLDQaCpf21Z9MZ+s0Rlh0hmxVP4JebQiYq9eetn6R46QW+g54D22TYkw9n2MVLtnoo8VbatURm3GOSmoAon4U2G3IqwtJKe4ODZKs3enuTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741652514; c=relaxed/simple;
	bh=Cvk9LBejBWXghx1DchRZZ1gkUlA17n1638CK5gzGvbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbwl9v1Ud77MwHFwnCHxMGjw+kG322Uxi5j+wjUi/GywgQ/IM6NtTpU3LQK8dV/UEGAShK4QYsj1juAcrgLMmSoI1v8vh8IPC2WyimZXFvGveTWijd9HjUl2v81SNGKbSAuY7istc1q6b+RN/Y61jZHwOl2s/91WuBj7Fsk5JXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ysVJ8QKA; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ysVJ8QKA"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6f7031ea11cso49825417b3.2
        for <git@vger.kernel.org>; Mon, 10 Mar 2025 17:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741652511; x=1742257311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M0A6TwSB8q37TO6SUmVJ+KoQphhFdebNEcHWSqPs7Mc=;
        b=ysVJ8QKAMknh4hK6exkUFYD8uCKjihJukIGOuDzxZNoY2FcY722ZC7o6o3fRfuGNtj
         +h/ddmcXGzQkpzUrQEcF9kW9Pg7pvd6j0wnRd51d4BoJ3Onea837ySUFCg7lclBK8yHj
         LeGmOn1C5WyOaT/BBfi1LkA3Zb6zeFRgQwpRM5JOddEsYc6zJNN+Y8TxailfStfS8WId
         GnX3H/57wEtNtiLTWBCXMaB+7Hi21daB/Hk0qBF5yXA6rH9KpfG2rIFI0lZXkD/aKrxP
         /9cKOa+RiSX4zS3tnIcf9zHIFF9rh+fq46JikcZOREGEM7p56GQNNfoKv/O38uBC6aod
         czJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741652511; x=1742257311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0A6TwSB8q37TO6SUmVJ+KoQphhFdebNEcHWSqPs7Mc=;
        b=jQ/gC77Q9Vmn3isgW5FcePxxfpNHq3lp+tdAWg2xvKgEwXxbrf6E+s5Vtn8psU5HFJ
         p2kzo8rKJ2Of+t/0KwHH1VzkFsiI9PkH3x4YSQGLlmeEZSwxiVuvmtFsflVCkP3GhVim
         ZtjjccsHCfqP1gQPyXEeD9FWH6iihFnjUxKuLX4rLaTw/1rGmFN8mkj2UWucNWL7uPh+
         RE4XipTl25LrOBGUo0AiCg6fPZ80USXIqwgXRqXcKlWVy2guXPZE4SD/7Ef5sLVLJTct
         d2Hbxa2qAhatGzNdo9bxmdYMDjaOYb/n5kAJ4bcn0Q//8b6vD0BM4TaDoo89A27o/qsy
         kbeA==
X-Gm-Message-State: AOJu0Yx0PXxafEHMjop3MONwxrmNbqsIj1ynRsNiRnGr6KU3Qph3kuRd
	DqxPzfO8JYrU/wvWdPkJu1suC3diqA11oL96TZNDOuhxupaq8GOjzFXD4YeLfhgfhRMkR5yUDIQ
	YX/s=
X-Gm-Gg: ASbGnctsDdyymuG4vb+oQDHxeK8Nz2Nc5n5+Jxu9sBe8rkGKy+1qwoeAewJsNpZBSoy
	X1yy9US8KWCeDL7T60AnuAI/UTb3u1Q+4fVZLbRIoVKKpS5reKXoSbriqCB2BPWMp1wVwUXzSLv
	JNbmYVUm05/r7s4t1S6OtwhqflyL4f0KgAooZbGQCnzpFdEScTs+Ky6tErJy+X2KyqT6geqHbs7
	V1sIBcDSoFxRjGVuXJdnlRisxASVn832NKCts4CsJNfWGea2eI3eicsoZEZRHgcd89upLvq9LNM
	fLyE7cbV103q8lb0/ndMyOqEtk3PWlKK0JWsiEQSv8vBd4YS4LHiLbiPKzzjT8QBfRzhr9JGVfi
	k/FtB/QMmC7HcxJ0v
X-Google-Smtp-Source: AGHT+IEa02vtHRHop1m8KIE/BD5DdLnjgw9iW4jYGCLHv2ylQqg9ox9SOz+U4wNZluEzkBDMHBHB1A==
X-Received: by 2002:a05:690c:690d:b0:6fb:33e1:2e66 with SMTP id 00721157ae682-6febf2c8ab4mr230204287b3.14.1741652511045;
        Mon, 10 Mar 2025 17:21:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6feb2a8aa70sm23708037b3.61.2025.03.10.17.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 17:21:50 -0700 (PDT)
Date: Mon, 10 Mar 2025 20:21:49 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 5/6] builtin/repack.c: simplify cruft pack aggregation
Message-ID: <12ddea7603e305e8a7af5c05dbe021add834f2fc.1741648467.git.me@ttaylorr.com>
References: <cover.1740680964.git.me@ttaylorr.com>
 <cover.1741648467.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1741648467.git.me@ttaylorr.com>

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
to ensure that the written pack(s) are each at most one object larger
than the provided threshold.

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
index 75e3752353..4d83d40f39 100644
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
index 88c6ce2913..fb52bb36a2 100755
--- a/t/t7704-repack-cruft.sh
+++ b/t/t7704-repack-cruft.sh
@@ -174,48 +174,6 @@ test_expect_success '--max-cruft-size combines existing packs when below thresho
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
2.49.0.rc2.6.g9a1eecd400

