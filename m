Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AEA204F80
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 23:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742252430; cv=none; b=hGuzV13IrO3LbmLGcKKBzj918HM+7skmRX9H71HjYbdEBkRhA36ZaAWAldt4Vo+g3t6cJG+RsPRJ8Lq1rKDCClJKHmhb6REwRdyqiIwML2bYksNFx1yRdjtWmj5fTRpSAt6LiS97NSImlCXe8JHCgHbFqHbzWIG0iwRVCNZVjPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742252430; c=relaxed/simple;
	bh=28VXWY3SMzWU/0pd146WHNXLrh7IynzXWysJfFj8lZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5MGER9M8g0un3GxGjFLlD9nlgD8hAgOgLKK6+9OY6RNOsUa7DMR/bCwwVUDFOBRQotmHIdcaQCoOpp4L3a1VtdoKwXqHoxbZmdoScU2yNxng5NFf0SWuDBgH1ob4eel4+R8QP2pfTD9E/uORJdHxfRvJhMy3ZxH5ibrJnx3nV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=UMW734dC; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="UMW734dC"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c5675dec99so548216285a.0
        for <git@vger.kernel.org>; Mon, 17 Mar 2025 16:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742252427; x=1742857227; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D14CWGS87GWsH4eZ7PAOHfxNDssTh4b/MuV9m1hgmKk=;
        b=UMW734dCtQIF83bpWMJ4foE21DDoldPBMgmJ7YLJImkqWo2+W7nPC51G6uPEpLfNps
         25651ZuYdTnO+TjDPKEF5xP+dP+q8Up61RjSFv85pOpXOS0OERhrNEW3zezcb0oPUTvH
         tZAsp/VcL15ZQHCAE6a/aGgfB5jIMEV7H4bMWiu3Lgle8hfnO0HH/eSD2Gu8RlusAe1x
         Cpj3b9KWZR97Uh0fUy3ngfKSQls/Ne+WVKVxMBGbNDEKGHH6IxChHr497RylTCynoKHr
         Mo+HC50mqSElKeuRtiSq76FpJBy66F77o2xZHjWfG6ZiIDv7PRpxDP+XWUuPoREP8+W7
         X1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742252427; x=1742857227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D14CWGS87GWsH4eZ7PAOHfxNDssTh4b/MuV9m1hgmKk=;
        b=O7TX/5E5oNhZchskY0yX5Wa59C4hFMB4tGIwNs/YJsSu3tbTeDIk0DG+KHSIXBMB4O
         xaUWiX6uUQQAlojJJZDGJW1OoJqDLwH/g+FXXKyMvsOcqrVYP5hIZiU2EOUjIFJgeum2
         uf5UOuQTgs5uckyFzP/0FNfMv3TtW8L2z1DKNmztAq4oPsnd3Ml487d6UtzVOZX0ONO9
         ltokpeo1LY7bBPf0OTroGFdhzvBqpFT46iZJtD+CPCxhU0NxZwfhFSpC4DKJGkfDUw0l
         AkwCKvBiitMdxKXcTkzXZhe5yfK+RDVbH4FoevkW/GYrpR3gTbhtQhbNwr45ttHaPejq
         xUMQ==
X-Gm-Message-State: AOJu0YxHhiCr0Jmm2z92evDRn0FCOevMm8eeiTrAFTWmywQ7jJy6fGMB
	rJsIGaTKesC1TJuv2qDMve7ygWA14IX9byb4YauHAAnmUaP10ZT2lwJiqPfXEcZ7FXGeWj2XhCu
	ewnk=
X-Gm-Gg: ASbGncvBlwGeYLNUxWOIYcEqPDU/mR8VUaMClmRMQXG4gWnNpaN0VcxLHAUZcbTWd0Q
	dCIucThzHnuhc6CM9qRjWEhizMyW24B219QwKbn5Sefbu7u0f6iFr2E5iWMped59/OlYD8EpQFa
	JBZ0DloGAJSRPl3J2NNnTaJZkFaS4nn59gF3pfw805+kPO0YdwgdegVuhoTmTZvjY1a9Nna8OLq
	07A39PamZSaw7gp6qbEMUiTjunQ9i9hzpY0iiD+QTxyGYm14g5w+UxP30Xe2cVXw6Byivw4as08
	NUqoGNpOgZDgqzVyDclLINXIIVUZEQe0mevOjmAiRacL03miNiq7Nw3l00bechdfkrjzEqNQ3KN
	uqkCf/EfX2WplF9Ha
X-Google-Smtp-Source: AGHT+IHYLLX0HDwzk8yZGp8uqDu1IYKELDQRp3CUbVFXqhcJ/8dE/j3oAy9Azif574GeCb6EzWfoKA==
X-Received: by 2002:a05:620a:1a8d:b0:7c5:6410:3a6 with SMTP id af79cd13be357-7c57c80f093mr2033018985a.27.1742252426920;
        Mon, 17 Mar 2025 16:00:26 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573d6fcf4sm641759685a.75.2025.03.17.16.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 16:00:26 -0700 (PDT)
Date: Mon, 17 Mar 2025 19:00:25 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH 4/5] repack: avoid combining cruft packs with
 `--max-cruft-size`
Message-ID: <7941997e332828f0005acf97f925efc1e7251a33.1742252411.git.me@ttaylorr.com>
References: <cover.1742252411.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1742252411.git.me@ttaylorr.com>

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
2.49.0.rc0.6.g7f120c35e9

