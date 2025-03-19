Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E097221F16
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 22:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742424779; cv=none; b=a9DOH57Gz4F8OwpA1ayzgGusM1XAC4Ogs9jDVuF789kVJKEJVIEibkyVXIAWjVlxhWfBCv871+a+VSCt1jlSsCaz7RM/WSu4N5e3vWUCtU0h0Np/kBrIx/btxA4AHtGucT3UIgRtIwHXVlXQM5/ATaV672AQjdu3OKs8Y8BHy10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742424779; c=relaxed/simple;
	bh=1FRAxN/JPTq0di3fx3dGlCEE8mrAN47c6Q9ippxG6x8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M711nLsnCpnsULQF48c4ou79//qL8PVPxpcJDUgy8fTCdqOxRCOKmyX86kDvHlzCm+bAwbe0VvrqEmA23PTjD9QMhgD7ITZgH3qqQlPrFJQxVHngioiKAj7MZGVQ6fFetFhRsv02Xm35nkSM1hKNSpfi9bUzxjHqsgdzhaAFaDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=2WtHIB2Y; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="2WtHIB2Y"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c3bf231660so29627685a.0
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 15:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742424776; x=1743029576; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xynV+fPJaMlXu7n2AQVwSzn2g5j7MJeIHIFu/pT3ZX4=;
        b=2WtHIB2YxMOMSLAZDOlKGtP/jnWBH4XUJke1L4CvB+SnYuG664wSeBPKK8LJIMbIp3
         TlKrCokYUJQYZjar2CaojsgKVMhtjn6CuPNdxbzfs9sBm5nXnRcOsRzcPk0b/2xDtWF8
         aMknc+Qdxt0XUBjE8MXJPYUHi7mvBspAByDK0U+2KQmSeyCejtdDmqI17BBkzmBXDw/w
         D2Opf2OYS97Yk1kLR1szUo0RQNFMoWjbWW0kLlq5jT4mT2JxTkQIujouP+7mF6uNOMNF
         u/hO3XQE8vuKn92vYjhmAZn7CWGKFctd7QNgNWKd5/JDu0wUz7dGlKzRj12d7NOmJ6vP
         yjcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742424776; x=1743029576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xynV+fPJaMlXu7n2AQVwSzn2g5j7MJeIHIFu/pT3ZX4=;
        b=PsB7p+5MRhfIVT3HTCuq9XNQtfI9cuFRKme27MJA93KfD9JDx9wXTvUb5ZYxhLO2GC
         RfyHMg8KTUW6FxsZTAKnYzio49F++Ht27JqV5CQjJjHj5s4bHojJUPfQXSQRCg0X16L+
         Zrh3uODVEbvJbj8uBkvl5G+4zmJPXb+XalcY+JDdUutPevOUPjDZIMxB03U833JWpynT
         HIjauADdfJT5evWOf6supkkUsIShYpQnKhlq3ARJqAIu2DdySQqhgoupoxdJ68gVCVVp
         cQp+zKIinFkjYfsb3KcqnaZozeeLRGSyKIr+BsIbqamFlFlsLK/dTDkLgxXp8nw6qk3i
         uoPA==
X-Gm-Message-State: AOJu0Yzw2x5WAR1Q4FOnqrUsdkaWBvsfmMJiGErncxqqkMXVYkeXeNKp
	aOHz5BTAEraAhXrbCL0O3bPiSyOMnKHFVnagumZiEFum+cX0o43SQUF0iUb/x95b/36UwFKc99d
	sTj8=
X-Gm-Gg: ASbGnctvBOvFH6hnSFwf8TH+sAB/xw8FUuOrCshzVd+kiUkcKZ//mk8zXQ6H5dNpTdp
	g7Sb3MZgscbWqPxkVRrMqPDS9XK4uBXkG73qmc5kXbNRZTyneGhpkwO0Lzz6AtC9J8p9YEwPju3
	ZU2QoUK3c8AA+hCRthIrDuStl8HU9UlfSN5FQr4TlizTwhJscC8TXARiGl6O0pBmojxBRevLJRv
	pXm8bLX8ZXtIGxd7LcTRKeNvq8bx1A4tJGznZIQ55Q44i5LvTwkibeC0c5DORoJKX0vNN8v+Ll3
	IzINpQ1ZGW/sj80Hmmfmd2E6FgVQYHTdEPcRdMatuKOOJNeNI73FXOOdwRE0GblRdAmNVcGjNb8
	VkDWQ9rlM2QsSB4Mh
X-Google-Smtp-Source: AGHT+IHIeUlc3ZFxfK1Y7EkthqRYFE6bZxrtax5O+ZNnpLlJRSL5TUsID50LKDpqRsvMOvdqLumG1g==
X-Received: by 2002:a05:620a:4593:b0:7c5:5d4b:e63c with SMTP id af79cd13be357-7c5a84ae82cmr761183585a.47.1742424776020;
        Wed, 19 Mar 2025 15:52:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573c4db57sm920934985a.8.2025.03.19.15.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 15:52:55 -0700 (PDT)
Date: Wed, 19 Mar 2025 18:52:54 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 4/5] repack: avoid combining cruft packs with
 `--max-cruft-size`
Message-ID: <7941997e332828f0005acf97f925efc1e7251a33.1742424671.git.me@ttaylorr.com>
References: <cover.1742252411.git.me@ttaylorr.com>
 <cover.1742424671.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1742424671.git.me@ttaylorr.com>

In 37dc6d8104 (builtin/repack.c: implement support for
`--max-cruft-size`, 2023-10-02), we exposed new functionality that
allowed repositories to specify the behavior of when we should combine
multiple cruft packs together.

This feature was designed to ensure that we never repacked cruft packs
which were larger than the given threshold in order to provide tighter
I/O bounds for repositories that have many unreachable objects. In
essence, specifying '--max-cruft-size=N' instructed 'repack' to
aggregate cruft packs together (in order of ascending size) until the
combine size grows past 'N', and then make a new cruft pack whose
contents includes the packs we rolled up.

But this isn't quite how it works in practice. Suppose for example that
we have two cruft packs which are each 100MiB in size. One might expect
specifying "--max-cruft-size=200M" would combine these two packs
together, and then avoid repacking them until a pruning GC takes place.
In reality, 'repack' would try and aggregate these together, but writing
a pack that is strictly smaller than 200 MiB (since pack-objects'
"--max-pack-size" provides a strict bound for packs containing more than
one object).

So instead we'll write out a pack that is, say, 199 MiB in size, and
then another 1 MiB pack containing the balance. If we later repack the
repository without adding any new unreachable objects, we'll repeat the
same exercise again, making the same 199 MiB and 1 MiB packs each time.

This happens because of a poor choice to bolt the '--max-cruft-size'
functionality onto pack-objects' '--max-pack-size', forcing us to
generate packs which are always smaller than the provided threshold and
thus subject to repacking.

The following commit will introduce a new flag that implements something
similar to the behavior above. Let's prepare for that by making repack's
'--max-cruft-size' flag behave as an cruft pack-specific override for
'--max-pack-size'.

Do so by temporarily repurposing the 'collapse_small_cruft_packs()'
function to instead generate a cruft pack using the same instructions as
if we didn't specify any maximum pack size. The calling code looks
something like:

    if (args->max_pack_size && !cruft_expiration) {
        collapse_small_cruft_packs(in, args->max_pack_size, existing);
    } else {
        for_each_string_list_item(item, &existing->non_kept_packs)
            fprintf(in, "-%s.pack\n", item->string);
        for_each_string_list_item(item, &existing->cruft_packs)
            fprintf(in, "-%s.pack\n", item->string);
    }

This patch makes collapse_small_cruft_packs() behave identically to the
'else' arm of the conditional above. This repurposing of
'collapse_small_cruft_packs()' is intentional, since it will set us up
nicely to introduce the new behavior in the following commit.

Naturally, there is some test fallout in the test which exercises the
old meaning of '--max-cruft-size'. Mark that test as failing for now to
be dealt with in the following commit. Likewise, add a new test which
explicitly tests the behavior of '--max-cruft-size' to place a hard
limit on the size of any generated cruft pack(s).

Note that this is a breaking change, as it alters the user-visible
behavior of '--max-cruft-size'. But I'm OK changing this behavior in
this instance, since the behavior wasn't accurate to begin with.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-repack.adoc | 12 ++------
 builtin/repack.c              | 50 ++++++---------------------------
 t/t5329-pack-objects-cruft.sh | 52 +++++++++++++++++++++++++++++++++++
 t/t7704-repack-cruft.sh       |  8 ++----
 4 files changed, 67 insertions(+), 55 deletions(-)

diff --git a/Documentation/git-repack.adoc b/Documentation/git-repack.adoc
index 5852a5c973..11db43b1c5 100644
--- a/Documentation/git-repack.adoc
+++ b/Documentation/git-repack.adoc
@@ -77,15 +77,9 @@ to the new separate pack will be written.
 	Only useful with `--cruft -d`.
 
 --max-cruft-size=<n>::
-	Repack cruft objects into packs as large as `<n>` bytes before
-	creating new packs. As long as there are enough cruft packs
-	smaller than `<n>`, repacking will cause a new cruft pack to
-	be created containing objects from any combined cruft packs,
-	along with any new unreachable objects. Cruft packs larger than
-	`<n>` will not be modified. When the new cruft pack is larger
-	than `<n>` bytes, it will be split into multiple packs, all of
-	which are guaranteed to be at most `<n>` bytes in size. Only
-	useful with `--cruft -d`.
+	Overrides `--max-pack-size` for cruft packs. Inherits the value of
+	`--max-pack-size` (if any) by default. See the documentation for
+	`--max-pack-size` for more details.
 
 --expire-to=<dir>::
 	Write a cruft pack containing pruned objects (if any) to the
diff --git a/builtin/repack.c b/builtin/repack.c
index 75e3752353..9658f6b354 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -1022,28 +1022,19 @@ static int write_filtered_pack(const struct pack_objects_args *args,
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
-static void collapse_small_cruft_packs(FILE *in, size_t max_size,
+static void collapse_small_cruft_packs(FILE *in, size_t max_size UNUSED,
 				       struct existing_packs *existing)
 {
-	struct packed_git **existing_cruft, *p;
+	struct packed_git *p;
 	struct strbuf buf = STRBUF_INIT;
-	size_t total_size = 0;
-	size_t existing_cruft_nr = 0;
 	size_t i;
 
-	ALLOC_ARRAY(existing_cruft, existing->cruft_packs.nr);
+	/*
+	 * Squelch a -Wunused-function warning while we rationalize
+	 * the behavior of --max-cruft-size. This function will become
+	 * used again in a future commit.
+	 */
+	(void)retain_cruft_pack;
 
 	for (p = get_all_packs(the_repository); p; p = p->next) {
 		if (!(p->is_cruft && p->pack_local))
@@ -1056,29 +1047,7 @@ static void collapse_small_cruft_packs(FILE *in, size_t max_size,
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
-			fprintf(in, "-%s\n", pack_basename(p));
-		} else {
-			retain_cruft_pack(existing, p);
-			fprintf(in, "%s\n", pack_basename(p));
-		}
+		fprintf(in, "-%s.pack\n", buf.buf);
 	}
 
 	for (i = 0; i < existing->non_kept_packs.nr; i++)
@@ -1086,7 +1055,6 @@ static void collapse_small_cruft_packs(FILE *in, size_t max_size,
 			existing->non_kept_packs.items[i].string);
 
 	strbuf_release(&buf);
-	free(existing_cruft);
 }
 
 static int write_cruft_pack(const struct pack_objects_args *args,
diff --git a/t/t5329-pack-objects-cruft.sh b/t/t5329-pack-objects-cruft.sh
index 60dac8312d..25ddda5cf3 100755
--- a/t/t5329-pack-objects-cruft.sh
+++ b/t/t5329-pack-objects-cruft.sh
@@ -695,4 +695,56 @@ test_expect_success 'additional cruft blobs via gc.recentObjectsHook' '
 	)
 '
 
+test_expect_success 'split cruft packs with --max-cruft-size' '
+	repo=cruft-with--max-cruft-size &&
+	test_when_finished "rm -fr $repo" &&
+
+	git init "$repo" &&
+
+	(
+		cd "$repo" &&
+
+		git config core.compression 0 &&
+
+		sz=$((1024 * 1024)) && # 1MiB
+		test-tool genrandom foo $sz >foo &&
+		test-tool genrandom bar $sz >bar &&
+		foo="$(git hash-object -w -t blob foo)" &&
+		bar="$(git hash-object -w -t blob bar)" &&
+
+		to=$packdir/pack &&
+		# Pack together foo and bar into a single 2MiB pack.
+		pack="$(git pack-objects $to <<-EOF
+		$foo
+		$bar
+		EOF
+		)" &&
+
+		# Then generate a cruft pack containing foo and bar.
+		#
+		# Generate the pack with --max-pack-size equal to the
+		# size of one object, forcing us to write two cruft
+		# packs.
+		git pack-objects --cruft --max-pack-size=$sz $to <<-EOF &&
+		-pack-$pack.pack
+		EOF
+
+		ls $packdir/pack-*.mtimes >crufts &&
+		test_line_count = 2 crufts &&
+
+		for cruft in $(cat crufts)
+		do
+			test-tool pack-mtimes "$(basename "$cruft")" || return 1
+		done >actual.raw &&
+
+		cut -d" " -f1 <actual.raw | sort >actual &&
+		sort >expect <<-EOF &&
+		$foo
+		$bar
+		EOF
+
+		test_cmp expect actual
+	)
+'
+
 test_done
diff --git a/t/t7704-repack-cruft.sh b/t/t7704-repack-cruft.sh
index 3fd5aa6089..6debad368d 100755
--- a/t/t7704-repack-cruft.sh
+++ b/t/t7704-repack-cruft.sh
@@ -194,7 +194,7 @@ test_expect_success '--max-cruft-size combines existing packs when not too large
 	)
 '
 
-test_expect_success '--max-cruft-size combines smaller packs first' '
+test_expect_failure '--max-cruft-size combines smaller packs first' '
 	git init max-cruft-size-consume-small &&
 	(
 		cd max-cruft-size-consume-small &&
@@ -354,13 +354,11 @@ test_expect_success 'multi-cruft with freshened objects (previously cruft)' '
 		done >actual.raw &&
 		sort actual.raw >actual &&
 
-		# Among the set of all cruft packs, we should see both
-		# mtimes for object $foo and $bar, as well as the
+		# Among the set of all cruft packs, we should see the
+		# new mtimes for object $foo and $bar, as well as the
 		# single new copy of $baz.
 		sort >expect <<-EOF &&
-		$foo $(cat foo.old)
 		$foo $(cat foo.new)
-		$bar $(cat bar.old)
 		$bar $(cat bar.new)
 		$baz $(cat baz.old)
 		$quux $(cat quux.new)
-- 
2.49.0.4.ge59cf92f8d

