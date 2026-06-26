Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBDA35675B
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 19:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782500570; cv=none; b=R65vz8mDB6hsyqczDW5Y1gW1ZwNnfb1kjkMMH8MPCeAFS45A7nFE53XELKn5U3s6gpYrPegS4gUB/zro3nmPZU46dtJz0Ao+Drvvwdd4exAx00mGWOJSq77SinV0BFTQ7YKrl0p2gcFJK6L98Uo2Wjm2nUvUvDMBkxodStNEK9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782500570; c=relaxed/simple;
	bh=U8/ehwmT/qRN57bQLkphmES6Rokiq50DHBt6gIbIVg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMD8LMFqipVtgEjiu1lS27mzaRJDcXyhyqG0q2UumNeJ9eW0+OiUkypDahLmndEnFmYRzXZsgzS2DXdEYITQZetL6ZR4Mbe6VZO8ljXHyYyQLHk7QLS5vn6+swi6lGHxHaHphYSteMxwTuwVzfQqbtFuHWs/+EL+0mA0fRat9qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=GUxIcc0L; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="GUxIcc0L"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6647bc8f900so1662126d50.0
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 12:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1782500566; x=1783105366; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=muiyKQ8BqzOvzpBR1ZJ5pRvOganLkwT0GNnMKTomC5g=;
        b=GUxIcc0LsOWCR5W169944zRUnpA1CNW6CmQ4f3pyyW5lUhMdUJIus6jMbz6Gak2ZZr
         uhIvf1QnxspkTYxWHgtWiyFaDAttarFuLYjh3Xz4hAZbPgm0gIDEAwlZhHpiwccqDG7c
         DaoT9eLpvoHoiUHrFF7PfPHBbEOFSmWgy2ErE0/803+NkGcfMfqNy54yVjKONtH60HlN
         Q3wdzPQFdCKyuouXWY0zw1TmT7lJUb4X4UN8mCeq0eCFAekhun+RNMBVYMOhlCIsvlWS
         YsQi591PWmkq3QvPu/nJSgoDE1Lz80kh0VKPSrq378NVCB0fLbOetJ1auVAjuN0fodZj
         Qwhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782500566; x=1783105366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=muiyKQ8BqzOvzpBR1ZJ5pRvOganLkwT0GNnMKTomC5g=;
        b=i9kZv/ZB4wQOXz/YeYOZBimS80v065FWTbrD4rRzFx58PSk8gbpW3GiKh9EphSqG/f
         d4350Z4xuj66EBsUe5AObBtV3sdKcRH5p0++WCrg3JWNxJOJbna3GRPEM3KIeRHozq/3
         2LR3W3DkO2sN8iU6Baui154tg1flffFUkk+6+4v3bQoxhWNU5hssjWoHnkhtjly9Pvbz
         epXBjcNzvL6dNmuhjIR+89QtXjO39tkfJ//m1iyUxzseG6A1Vtsza350fdBWj8pyZs2M
         s40im8OCXhIqhH3NDOgz+n9Z8jMrytmSsKmX12ySuw6Q5p+shwKvYveb37rRhxfBMppI
         pvFQ==
X-Gm-Message-State: AOJu0YxMIL04ErgmmpU495ZA0aVenZHTNcp0KTjn3YE/ZSyFpKQ8B4Wb
	h5noIFcisQEPpKQrpeksvuvDuyutofyz12kMU4G3R3BMPfq3xNodyjkgoYnxrVYFILuDAGCZx24
	/JchJpqMl4w==
X-Gm-Gg: AfdE7cmADC2XaGATb+vfJNP7Ozg0avPcRAqHJclJeg7Lnm28NJh4rgKKf8ovIfiw+3D
	dKTOyKYRNK+SdsqQh74K9/w4J50IjGFA2GwW9t4RLwvnCQ95D7o4W33nxnPSZoRDLQXZBHzAO7e
	POojgMQz1Vz6NCIJRZ7E4R0T6C70t1Y8PybxWrx3DO9iHtV67+vh73qKjSdDQ4dmaFpzxwFfNaG
	ajx5plHHCdAyLjZ8ofN1RB9aBf4s7RXIYQk2RbtZzgN3gjojOmUKfWctaY3Bqv3+w3rnPPuNtyU
	N3YOjjf8NSDld4vFDJsRbH2sHluZCyilHbQ6ltZgBd7Fs8ZiM6fQ+605bINzigsjUnAs1MdUoM8
	DEgTACitJCIOhg2BoTEeYfqY/CtrCDo3QCZjVLdqsg2aPF81hxTa5umhjHYmT1OkyYo4XgdiHxv
	bag0rI9YzfPFElxGTbqlR3oRc69SU1g1WiBKIHe4CF5UJKMTAeTvhA12Mc4Exon1e3F8u7ajLgQ
	n788KzYUbDBN+ffX5U+UnovoBsgUoTWDxExc3yDc/klEf0xaQCIltgaqxHQIwzcMDXO2h3JH9/4
	WqEqVw==
X-Received: by 2002:a05:690c:3682:b0:80c:85b6:765d with SMTP id 00721157ae682-80c85b6a14fmr16520827b3.66.1782500565697;
        Fri, 26 Jun 2026 12:02:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8025f9d8c57sm86692957b3.31.2026.06.26.12.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 12:02:44 -0700 (PDT)
Date: Fri, 26 Jun 2026 15:02:43 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [RFC PATCH 10/10] repack: support combining '--geometric' with
 '--cruft'
Message-ID: <488ccd62aab9a059f82643a6ca46cd78f5b83a7e.1782500507.git.me@ttaylorr.com>
References: <cover.1782500507.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1782500507.git.me@ttaylorr.com>

Teach 'git repack' to accept '--geometric' and '--cruft' together. When
both are given, the geometric repack rolls up non-cruft packs as usual,
and a separate cruft pack is written to collect unreachable objects.

Previously, '--cruft' implied `ALL_INTO_ONE`, which is fundamentally
incompatible with geometric repacking. Relax this so that '--cruft' only
implies `ALL_INTO_ONE` when '--geometric' is not also given.

When combining the two modes:

 - Use the new '--stdin-packs=follow-reachable' mode so that only
   reachable objects from the rolled-up packs (and any reachable loose
   objects) appear in the geometric pack. Unreachable objects are left
   for the cruft writer to collect.

 - Plumb our `pack_geometry` into `write_cruft_pack()`, so that the
   latter can tell 'pack-objects' which non-kept packs are below the
   split (excluded, so their unreachable objects are candidates for the
   cruft pack) versus above the split (included, so they are treated as
   reachable).

 - Handle promisor packs in the cruft writer's geometry path, since
   promisor packs have their own split point.

 - Use the refs snapshot (when available) so that pack-objects and the
   MIDX bitmap writer see the same set of reference tips.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-repack.adoc |  11 ++
 builtin/repack.c              |  23 +++-
 repack-cruft.c                |  23 +++-
 repack.h                      |   3 +-
 t/t7704-repack-cruft.sh       | 251 ++++++++++++++++++++++++++++++++++
 5 files changed, 300 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-repack.adoc b/Documentation/git-repack.adoc
index 72c42015e23..e9df7713278 100644
--- a/Documentation/git-repack.adoc
+++ b/Documentation/git-repack.adoc
@@ -70,6 +70,11 @@ to the new separate pack will be written.
 	are packed into a separate cruft pack. Unreachable objects can
 	be pruned using the normal expiry rules with the next `git gc`
 	invocation (see linkgit:git-gc[1]). Incompatible with `-k`.
++
+When combined with `--geometric`, `--cruft` does not imply `-a`. Instead,
+the geometric repack rolls up packs as usual, and a separate cruft pack is
+written to collect unreachable objects. Only reachable objects from the
+rolled-up packs are included in the resulting geometric pack.
 
 --cruft-expiration=<approxidate>::
 	Expire unreachable objects older than `<approxidate>`
@@ -245,6 +250,12 @@ progression.
 Loose objects are implicitly included in this "roll-up", without respect to
 their reachability. This is subject to change in the future.
 +
+When combined with `--cruft`, only reachable objects from rolled-up packs
+are included in the geometric pack, along with any reachable loose objects.
+Unreachable objects (both from rolled-up packs and loose) are collected
+into a separate cruft pack. Existing cruft packs are retained. See
+`--cruft` above for details.
++
 When writing a multi-pack bitmap, `git repack` selects the largest resulting
 pack as the preferred pack for object selection by the MIDX (see
 linkgit:git-multi-pack-index[1]).
diff --git a/builtin/repack.c b/builtin/repack.c
index dfb6fed231d..165cfff75cd 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -260,7 +260,7 @@ int cmd_repack(int argc,
 				  keep_unreachable, "-k/--keep-unreachable",
 				  pack_everything & PACK_CRUFT, "--cruft");
 
-	if (pack_everything & PACK_CRUFT)
+	if (pack_everything & PACK_CRUFT && !geometry.split_factor)
 		pack_everything |= ALL_INTO_ONE;
 
 	if (write_bitmaps < 0) {
@@ -296,7 +296,8 @@ int cmd_repack(int argc,
 		die(_("invalid value for %s: %d"), "--midx-new-layer-threshold",
 		    config_ctx.midx_new_layer_threshold);
 
-	if (write_midx != REPACK_WRITE_MIDX_NONE && write_bitmaps) {
+	if ((write_midx != REPACK_WRITE_MIDX_NONE && write_bitmaps) ||
+	    (geometry.split_factor && (pack_everything & PACK_CRUFT))) {
 		struct strbuf path = STRBUF_INIT;
 
 		strbuf_addf(&path, "%s/%s_XXXXXX",
@@ -317,7 +318,7 @@ int cmd_repack(int argc,
 	existing_packs_collect(&existing, &keep_pack_list);
 
 	if (geometry.split_factor) {
-		if (pack_everything)
+		if (pack_everything & ~PACK_CRUFT)
 			die(_("options '%s' and '%s' cannot be used together"), "--geometric", "-A/-a");
 		if (write_midx == REPACK_WRITE_MIDX_INCREMENTAL) {
 			geometry.midx_layer_threshold = config_ctx.midx_new_layer_threshold;
@@ -393,10 +394,16 @@ int cmd_repack(int argc,
 		pack_geometry_repack_promisors(repo, &po_args, &geometry,
 					       &names, packtmp);
 
-		if (midx_must_contain_cruft)
+		if (pack_everything & PACK_CRUFT) {
+			strvec_push(&cmd.args, "--stdin-packs=follow-reachable");
+			if (refs_snapshot)
+				strvec_pushf(&cmd.args, "--refs-snapshot=%s",
+					     get_tempfile_path(refs_snapshot));
+		} else if (midx_must_contain_cruft)
 			strvec_push(&cmd.args, "--stdin-packs");
 		else
 			strvec_push(&cmd.args, "--stdin-packs=follow");
+
 		strvec_push(&cmd.args, "--unpacked");
 	} else {
 		strvec_push(&cmd.args, "--unpacked");
@@ -431,7 +438,8 @@ int cmd_repack(int argc,
 			const char *basename = pack_basename(geometry.pack[i]);
 			char marker = '^';
 
-			if (!midx_must_contain_cruft &&
+			if ((pack_everything & PACK_CRUFT ||
+			     !midx_must_contain_cruft) &&
 			    !string_list_has_string(&existing.midx_packs,
 						    basename)) {
 				/*
@@ -505,7 +513,8 @@ int cmd_repack(int argc,
 
 		ret = write_cruft_pack(&opts, cruft_expiration,
 				       combine_cruft_below_size, &names,
-				       &existing);
+				       &existing,
+				       geometry.split_factor ? &geometry : NULL);
 		if (ret)
 			goto cleanup;
 
@@ -540,7 +549,7 @@ int cmd_repack(int argc,
 			 */
 			opts.destination = expire_to;
 			ret = write_cruft_pack(&opts, NULL, 0ul, &names,
-					       &existing);
+					       &existing, NULL);
 			if (ret)
 				goto cleanup;
 		}
diff --git a/repack-cruft.c b/repack-cruft.c
index 6a040e98017..6c553bbb0b5 100644
--- a/repack-cruft.c
+++ b/repack-cruft.c
@@ -36,7 +36,8 @@ int write_cruft_pack(const struct write_pack_opts *opts,
 		     const char *cruft_expiration,
 		     unsigned long combine_cruft_below_size,
 		     struct string_list *names,
-		     struct existing_packs *existing)
+		     struct existing_packs *existing,
+		     struct pack_geometry *geometry)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	struct string_list_item *item;
@@ -81,8 +82,24 @@ int write_cruft_pack(const struct write_pack_opts *opts,
 	else
 		for_each_string_list_item(item, &existing->cruft_packs)
 			fprintf(in, "-%s.pack\n", item->string);
-	for_each_string_list_item(item, &existing->non_kept_packs)
-		fprintf(in, "-%s.pack\n", item->string);
+	if (geometry) {
+		uint32_t j;
+		for (j = 0; j < geometry->split; j++)
+			fprintf(in, "-%s\n",
+				pack_basename(geometry->pack[j]));
+		for (; j < geometry->pack_nr; j++)
+			fprintf(in, "%s\n",
+				pack_basename(geometry->pack[j]));
+		for (j = 0; j < geometry->promisor_split; j++)
+			fprintf(in, "-%s\n",
+				pack_basename(geometry->promisor_pack[j]));
+		for (; j < geometry->promisor_pack_nr; j++)
+			fprintf(in, "%s\n",
+				pack_basename(geometry->promisor_pack[j]));
+	} else {
+		for_each_string_list_item(item, &existing->non_kept_packs)
+			fprintf(in, "-%s.pack\n", item->string);
+	}
 	for_each_string_list_item(item, &existing->kept_packs)
 		fprintf(in, "%s.pack\n", item->string);
 	fclose(in);
diff --git a/repack.h b/repack.h
index 4295829cea0..872a503fbd1 100644
--- a/repack.h
+++ b/repack.h
@@ -169,6 +169,7 @@ int write_cruft_pack(const struct write_pack_opts *opts,
 		     const char *cruft_expiration,
 		     unsigned long combine_cruft_below_size,
 		     struct string_list *names,
-		     struct existing_packs *existing);
+		     struct existing_packs *existing,
+		     struct pack_geometry *geometry);
 
 #endif /* REPACK_H */
diff --git a/t/t7704-repack-cruft.sh b/t/t7704-repack-cruft.sh
index 9e03b04315d..5e2b776e7ba 100755
--- a/t/t7704-repack-cruft.sh
+++ b/t/t7704-repack-cruft.sh
@@ -891,4 +891,255 @@ test_expect_success 'repack rescues once-cruft objects above geometric split' '
 	git repack --geometric=2 -d --write-midx --write-bitmap-index
 '
 
+test_expect_success 'repack --geometric --cruft combines packs and writes cruft' '
+	git init geometric-cruft-basic &&
+	(
+		cd geometric-cruft-basic &&
+
+		test_commit A &&
+		test_commit B &&
+
+		B="$(git rev-parse B)" &&
+
+		git reset --hard $B^ &&
+		git tag -d B &&
+		git reflog expire --all --expire=all &&
+
+		# Initial state: one non-cruft pack, one cruft pack.
+		git repack -d --cruft &&
+
+		ls $packdir/pack-*.mtimes >cruft.before &&
+		test_line_count = 1 cruft.before &&
+
+		test_commit C &&
+		git repack &&
+
+		# At this point we have three packs:
+		#   - the non-cruft pack from A
+		#   - the cruft pack from B
+		#   - a new non-cruft pack from C
+		#
+		# The two non-cruft packs are not in a geometric
+		# progression, so they should be rolled up.
+		git repack -d --geometric=2 --cruft &&
+
+		# The old cruft pack for B is retained, since the
+		# geometric repack does not touch cruft packs.
+		ls $packdir/pack-*.mtimes >cruft.after &&
+		test_line_count = 1 cruft.after &&
+
+		# Ensure that all reachable objects are present.
+		git fsck
+	)
+'
+
+test_expect_success 'repack --geometric --cruft writes new cruft for loose unreachable' '
+	git init geometric-cruft-new-cruft &&
+	(
+		cd geometric-cruft-new-cruft &&
+
+		git config set maintenance.auto false &&
+
+		test_commit A &&
+		git repack &&
+
+		test_commit B &&
+		git repack &&
+
+		# Create an unreachable commit whose objects are
+		# still loose (never packed).
+		test_commit C &&
+		C="$(git rev-parse C)" &&
+		git reset --hard $C^ &&
+		git tag -d C &&
+		git reflog expire --all --expire=all &&
+
+		# At this point we have two non-cruft packs of
+		# similar size that are not in geometric progression,
+		# and loose unreachable objects from commit C.
+		ls $packdir/pack-*.idx >packs.before &&
+		test_line_count = 2 packs.before &&
+
+		# Geometric+cruft repack should roll up the two
+		# non-cruft packs and write a new cruft pack for C
+		# (whose objects are loose and unreachable).
+		git repack -d --geometric=2 --cruft &&
+
+		ls $packdir/pack-*.mtimes >cruft.after &&
+		test_line_count = 1 cruft.after &&
+
+		git fsck
+	)
+'
+
+test_expect_success 'repack --geometric --cruft -d deletes rolled-up packs' '
+	git init geometric-cruft-delete &&
+	(
+		cd geometric-cruft-delete &&
+
+		test_commit A &&
+		git repack -d &&
+
+		test_commit B &&
+		git repack -d &&
+
+		ls $packdir/pack-*.idx >before &&
+
+		git repack -d --geometric=2 --cruft &&
+
+		# Two packs should have been rolled into one. No cruft
+		# pack is written because there are no unreachable objects.
+		ls $packdir/pack-*.idx >after &&
+		test_line_count = 1 after &&
+
+		# The rolled-up packs should be gone.
+		! test_cmp before after
+	)
+'
+
+test_expect_success 'repack --geometric --cruft collects loose unreachable objects' '
+	git init geometric-cruft-loose &&
+	(
+		cd geometric-cruft-loose &&
+
+		test_commit A &&
+		git repack -d &&
+
+		test_commit B &&
+		git repack &&
+
+		# Create a loose unreachable object by making it
+		# orphaned (not in any pack).
+		loose="$(echo "cruft object" | git hash-object -w --stdin)" &&
+
+		# We have two non-cruft packs and a loose unreachable
+		# object. The geometric+cruft repack should roll up
+		# the packs AND write a cruft pack for the loose
+		# unreachable object.
+		git repack -d --geometric=2 --cruft &&
+
+		ls $packdir/pack-*.mtimes >cruft.packs &&
+		test_line_count = 1 cruft.packs &&
+
+		git fsck
+	)
+'
+
+test_expect_success 'repack --geometric --cruft accumulates cruft packs' '
+	git init geometric-cruft-accumulate &&
+	(
+		cd geometric-cruft-accumulate &&
+
+		git config set maintenance.auto false &&
+
+		test_commit A &&
+		git repack &&
+
+		# First round: create unreachable objects and do a
+		# geometric+cruft repack.
+		unreachable_1="$(echo "cruft 1" | git hash-object -w --stdin)" &&
+		git repack -d --geometric=2 --cruft &&
+
+		ls $packdir/pack-*.mtimes >cruft.1 &&
+		test_line_count = 1 cruft.1 &&
+
+		test_commit B &&
+		git repack &&
+
+		# Second round: create more unreachable objects and
+		# repack again. The old cruft pack should be retained
+		# and a new one written.
+		unreachable_2="$(echo "cruft 2" | git hash-object -w --stdin)" &&
+		git repack -d --geometric=2 --cruft &&
+
+		ls $packdir/pack-*.mtimes >cruft.2 &&
+		test_line_count = 2 cruft.2 &&
+
+		git fsck
+	)
+'
+
+test_expect_success 'repack --geometric --cruft --combine-cruft-below-size' '
+	git init geometric-cruft-combine &&
+	(
+		cd geometric-cruft-combine &&
+
+		git config set maintenance.auto false &&
+
+		test_commit A &&
+		git repack &&
+
+		# Create a small cruft pack.
+		unreachable_1="$(echo "cruft 1" | git hash-object -w --stdin)" &&
+		git repack -d --geometric=2 --cruft &&
+
+		ls $packdir/pack-*.mtimes >cruft.before &&
+		test_line_count = 1 cruft.before &&
+
+		test_commit B &&
+		git repack &&
+
+		# Create another small cruft pack.
+		unreachable_2="$(echo "cruft 2" | git hash-object -w --stdin)" &&
+		git repack -d --geometric=2 --cruft &&
+
+		ls $packdir/pack-*.mtimes >cruft.mid &&
+		test_line_count = 2 cruft.mid &&
+
+		test_commit C &&
+		git repack &&
+
+		# With --combine-cruft-below-size, the two small cruft
+		# packs should be combined into one.
+		unreachable_3="$(echo "cruft 3" | git hash-object -w --stdin)" &&
+		git repack -d --geometric=2 --cruft \
+			--combine-cruft-below-size=10M &&
+
+		ls $packdir/pack-*.mtimes >cruft.after &&
+		test_line_count = 1 cruft.after &&
+
+		git fsck
+	)
+'
+
+test_expect_success 'repack --geometric --cruft --expire-to' '
+	git init geometric-cruft-expire-to &&
+	(
+		cd geometric-cruft-expire-to &&
+
+		git config set maintenance.auto false &&
+
+		test_commit A &&
+		git repack &&
+
+		test_commit B &&
+		git repack &&
+
+		# Create unreachable objects and record them.
+		test_commit C &&
+		C="$(git rev-parse C)" &&
+		git rev-list --objects --no-object-names B..C >unreachable.raw &&
+		sort unreachable.raw >unreachable.want &&
+
+		git reset --hard $C^ &&
+		git tag -d C &&
+		git reflog expire --all --expire=all &&
+
+		git init --bare expired.git &&
+		git repack -d --geometric=2 --cruft \
+			--cruft-expiration=now \
+			--expire-to="expired.git/objects/pack/pack" &&
+
+		# The expired objects should appear in the
+		# expire-to location.
+		expired="$(ls expired.git/objects/pack/pack-*.idx)" &&
+		test_path_is_file "${expired%.idx}.mtimes" &&
+		git show-index <"$expired" >expired.raw &&
+		cut -d" " -f2 expired.raw | sort >expired.objects &&
+		test_cmp unreachable.want expired.objects &&
+
+		git fsck
+	)
+'
+
 test_done
-- 
2.55.0.rc2.10.g29e31820dce
