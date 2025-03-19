Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96008221DBA
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 22:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742424782; cv=none; b=F6G3c80hmg9pUK/7YXHgQUo1i8SaaaSNilO2Qq833XypHJkA8WW1qoUggVRH31frMt3Ps31JzKuzSsIwpILqOXn2ZMEJACZNIY3X4/XMawI/fE/I1DcseQt1dUVzolxmdgYDs6BmYjvhwuMQ57QTlTCGmoh61K4vN1TJFq6Tv9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742424782; c=relaxed/simple;
	bh=oncs16QJNVjxqFC8yqb1LGD57A6EfAaK+dw0P5bqdiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onw3loj45EDpc89dKM8KHmhoUqDTSvsNDb335kY4dTu0GZUvmVQlERSm9u7/1oLEpfni/bzGcHA3B4jX/qn4txpVuvsuhSdBBTIgXgxjHkmwhMTSsjy9SjccUhLoHQO2W/8XvO0Q2FPDYJ36eEoHGhAbPY5fFT+uJReeYpdLmP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=wxNRfJsu; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="wxNRfJsu"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c08fc20194so40960685a.2
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 15:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742424779; x=1743029579; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0SxAoQyp+NsqsirMIQg/eDXxSEKM4dYidALpDkFfYwA=;
        b=wxNRfJsu67DD7GOCzyUgKcn+dAVoQaJkVzTQ9kKPQJpD70zV9+ECps0oGPTqGo70fU
         N7ALuesPhfubT4jVJPRPAG+5LTU5UqAShDxEPV5GiZ+Az35OaQIJaMmaHNVvER7DxMvI
         lm8iv/1o/ZcM6ki7jiH11qipKbpxg4WygeVMOIc44K5D7PkNEozNAUNLmg9T9vC5AXD8
         D0OU8yqG9b93A0h/g1E0UM0RsOMz1ZVhdD3MfpxYl9AAQsyYrEHVxHlEGFTh2KUiB2na
         PSEtyQ5D5KwywViLEuj4Na501C9ol0jnAAgYF/6UdYDgYzKVq1BqbGPuJXM9D2xUoo60
         2FLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742424779; x=1743029579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0SxAoQyp+NsqsirMIQg/eDXxSEKM4dYidALpDkFfYwA=;
        b=gmFHEgPrf4YcadDo035uMW2SxjT1mrX7Swocs8hg/8+/Fmi3yPGHbuXnkA69kQSjOC
         gw1ZyImCA9JkMgGQnR0NSKq2xvejnolW1ZjBCMgb3zPrbml1POFXCpEHj1eKCBK3iQvH
         ltLpuk1s9w+f1KT+BR+e8xiYC3TDFUvjO0B/R+SFd+Y+DXQqK5XrX69oLC1DmEJMBc8i
         7uoychmjSxMUWZFIF+VGSxrq+c79CZUWqf/rqaVc75k4/UenY5ECPl9ZWJROz//gckC0
         sxQMVB7vpsID5VkwfT5tU9UIuHZ5q9J48x32qVjpEMuV8KvMFXsmO/w4cstwSIGSXTs2
         /1RQ==
X-Gm-Message-State: AOJu0Yyz5k8mylCCDHIdEM+FhphqPKAPzMsSbWoSPfJHe+ZLAamjKgM/
	/lDjTae9q8VlLrussaZ7Ezx6Gpd7Yie/0I4zeocm0QLiW3Bzvg2NdlJ/8xbriwpWaTmPRS/htg6
	ATuo=
X-Gm-Gg: ASbGncv7vDhCYU8Y2QwoJGmvommFwTsA522qxHIJ53WbczRlxi1Af2GPlaa2710MtLb
	/KrJ4X6PEP638WAsZV2fiuyU8H6OSlQA0TnuEvEiF6z/blsqYIbwKZVbyy65g1G8j08S6Y0XVQx
	FckzHSP9+u0dd61mcCm6ygrJNPwumckgg0oOnmfLsqKifmFG0Qz1OPiVKFScdIIWjbPRM3KT/y8
	YRg2gvpvI40y3MjGoTFU7cBeB20cmbZskA7HnhK28nzNCGKASD5HUiDLfr8CXip5LHifGsLS/QM
	RbxsYZSZxSg0J161JLpP+UKu7Fcp7HAkE3fkMowkG5YSrVcDpkz3QoEz41jwbKHXzljTsxC2oZM
	vSQdeoO/50aVExjVO
X-Google-Smtp-Source: AGHT+IGz60a32bMTk67nOJ/J/TXpPpKnO8C7Wt/w9EOl8rgwn1rA4o0kvVOVI6OyqNi7+Ag8LdYB2w==
X-Received: by 2002:a05:620a:2616:b0:7c5:5cd6:5cea with SMTP id af79cd13be357-7c5a83969aamr672406985a.15.1742424779373;
        Wed, 19 Mar 2025 15:52:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573da455dsm911621985a.115.2025.03.19.15.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 15:52:59 -0700 (PDT)
Date: Wed, 19 Mar 2025 18:52:58 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 5/5] repack: begin combining cruft packs with
 `--combine-cruft-below-size`
Message-ID: <dee780a2aaebc1055c2fb009325c3d8eb09421cf.1742424671.git.me@ttaylorr.com>
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

The previous commit changed the behavior of repack's '--max-cruft-size'
to specify a cruft pack-specific override for '--max-pack-size'.

Introduce a new flag, '--combine-cruft-below-size' which is a
replacement for the old behavior of '--max-cruft-size'. This new flag
does explicitly what it says: it combines together cruft packs which are
smaller than a given threshold, and leaves alone ones which are
larger.

This accomplishes the original intent of '--max-cruft-size', which was
to avoid repacking cruft packs larger than the given threshold.

The new behavior is slightly different. Instead of building up small
packs together until the threshold is met, '--combine-cruft-below-size'
packs up *all* cruft packs smaller than the threshold. This means that
we may make a pack much larger than the given threshold (e.g., if you
aggregate 5 packs which are each 99 MiB in size with a threshold of 100
MiB).

But that's OK: the point isn't to restrict the size of the cruft packs
we generate, it's to avoid working with ones that have already grown too
large. If repositories still want to limit the size of the generated
cruft pack(s), they may use '--max-cruft-size'.

There's some minor test fallout as a result of the slight differences in
behavior between the old meaning of '--max-cruft-size' and the behavior
of '--combine-cruft-below-size'. In the test which is now called
"--combine-cruft-below-size combines packs", we need to use the new flag
over the old one to exercise that test's intended behavior. The
remainder of the changes there are to improve the clarity of the
comments.

Suggested-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-repack.adoc |  9 +++++++++
 builtin/repack.c              | 38 +++++++++++++++++++++++------------
 t/t7704-repack-cruft.sh       | 22 +++++++++++---------
 3 files changed, 47 insertions(+), 22 deletions(-)

diff --git a/Documentation/git-repack.adoc b/Documentation/git-repack.adoc
index 11db43b1c5..e1cd75eebe 100644
--- a/Documentation/git-repack.adoc
+++ b/Documentation/git-repack.adoc
@@ -81,6 +81,15 @@ to the new separate pack will be written.
 	`--max-pack-size` (if any) by default. See the documentation for
 	`--max-pack-size` for more details.
 
+--combine-cruft-below-size=<n>::
+	When generating cruft packs without pruning, only repack
+	existing cruft packs whose size is strictly less than `<n>`,
+	where `<n>` represents a number of bytes, which can optionally
+	be suffixed with "k", "m", or "g". Cruft packs whose size is
+	greater than or equal to `<n>` are left as-is and not repacked.
+	Useful when you want to avoid repacking large cruft pack(s) in
+	repositories that have many and/or large unreachable objects.
+
 --expire-to=<dir>::
 	Write a cruft pack containing pruned objects (if any) to the
 	directory `<dir>`. This option is useful for keeping a copy of
diff --git a/builtin/repack.c b/builtin/repack.c
index 9658f6b354..f3330ade7b 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -1022,20 +1022,13 @@ static int write_filtered_pack(const struct pack_objects_args *args,
 	return finish_pack_objects_cmd(&cmd, names, local);
 }
 
-static void collapse_small_cruft_packs(FILE *in, size_t max_size UNUSED,
-				       struct existing_packs *existing)
+static void combine_small_cruft_packs(FILE *in, size_t combine_cruft_below_size,
+				      struct existing_packs *existing)
 {
 	struct packed_git *p;
 	struct strbuf buf = STRBUF_INIT;
 	size_t i;
 
-	/*
-	 * Squelch a -Wunused-function warning while we rationalize
-	 * the behavior of --max-cruft-size. This function will become
-	 * used again in a future commit.
-	 */
-	(void)retain_cruft_pack;
-
 	for (p = get_all_packs(the_repository); p; p = p->next) {
 		if (!(p->is_cruft && p->pack_local))
 			continue;
@@ -1047,7 +1040,12 @@ static void collapse_small_cruft_packs(FILE *in, size_t max_size UNUSED,
 		if (!string_list_has_string(&existing->cruft_packs, buf.buf))
 			continue;
 
-		fprintf(in, "-%s.pack\n", buf.buf);
+		if (p->pack_size < combine_cruft_below_size) {
+			fprintf(in, "-%s\n", pack_basename(p));
+		} else {
+			retain_cruft_pack(existing, p);
+			fprintf(in, "%s\n", pack_basename(p));
+		}
 	}
 
 	for (i = 0; i < existing->non_kept_packs.nr; i++)
@@ -1061,6 +1059,7 @@ static int write_cruft_pack(const struct pack_objects_args *args,
 			    const char *destination,
 			    const char *pack_prefix,
 			    const char *cruft_expiration,
+			    unsigned long combine_cruft_below_size,
 			    struct string_list *names,
 			    struct existing_packs *existing)
 {
@@ -1103,8 +1102,9 @@ static int write_cruft_pack(const struct pack_objects_args *args,
 	in = xfdopen(cmd.in, "w");
 	for_each_string_list_item(item, names)
 		fprintf(in, "%s-%s.pack\n", pack_prefix, item->string);
-	if (args->max_pack_size && !cruft_expiration) {
-		collapse_small_cruft_packs(in, args->max_pack_size, existing);
+	if (combine_cruft_below_size && !cruft_expiration) {
+		combine_small_cruft_packs(in, combine_cruft_below_size,
+					  existing);
 	} else {
 		for_each_string_list_item(item, &existing->non_kept_packs)
 			fprintf(in, "-%s.pack\n", item->string);
@@ -1158,6 +1158,7 @@ int cmd_repack(int argc,
 	const char *opt_window_memory = NULL;
 	const char *opt_depth = NULL;
 	const char *opt_threads = NULL;
+	unsigned long combine_cruft_below_size = 0ul;
 
 	struct option builtin_repack_options[] = {
 		OPT_BIT('a', NULL, &pack_everything,
@@ -1170,6 +1171,9 @@ int cmd_repack(int argc,
 				   PACK_CRUFT),
 		OPT_STRING(0, "cruft-expiration", &cruft_expiration, N_("approxidate"),
 				N_("with --cruft, expire objects older than this")),
+		OPT_MAGNITUDE(0, "combine-cruft-below-size",
+			      &combine_cruft_below_size,
+			      N_("with --cruft, only repack cruft packs smaller than this")),
 		OPT_MAGNITUDE(0, "max-cruft-size", &cruft_po_args.max_pack_size,
 				N_("with --cruft, limit the size of new cruft packs")),
 		OPT_BOOL('d', NULL, &delete_redundant,
@@ -1413,7 +1417,8 @@ int cmd_repack(int argc,
 		cruft_po_args.quiet = po_args.quiet;
 
 		ret = write_cruft_pack(&cruft_po_args, packtmp, pack_prefix,
-				       cruft_expiration, &names,
+				       cruft_expiration,
+				       combine_cruft_below_size, &names,
 				       &existing);
 		if (ret)
 			goto cleanup;
@@ -1440,10 +1445,17 @@ int cmd_repack(int argc,
 			 * generate an empty pack (since every object not in the
 			 * cruft pack generated above will have an mtime older
 			 * than the expiration).
+			 *
+			 * Pretend we don't have a `--combine-cruft-below-size`
+			 * argument, since we're not selectively combining
+			 * anything based on size to generate the limbo cruft
+			 * pack, but rather removing all cruft packs from the
+			 * main repository regardless of size.
 			 */
 			ret = write_cruft_pack(&cruft_po_args, expire_to,
 					       pack_prefix,
 					       NULL,
+					       0ul,
 					       &names,
 					       &existing);
 			if (ret)
diff --git a/t/t7704-repack-cruft.sh b/t/t7704-repack-cruft.sh
index 6debad368d..8aebfb45f5 100755
--- a/t/t7704-repack-cruft.sh
+++ b/t/t7704-repack-cruft.sh
@@ -194,10 +194,13 @@ test_expect_success '--max-cruft-size combines existing packs when not too large
 	)
 '
 
-test_expect_failure '--max-cruft-size combines smaller packs first' '
-	git init max-cruft-size-consume-small &&
+test_expect_success '--combine-cruft-below-size combines packs' '
+	repo=combine-cruft-below-size &&
+	test_when_finished "rm -fr $repo" &&
+
+	git init "$repo" &&
 	(
-		cd max-cruft-size-consume-small &&
+		cd "$repo" &&
 
 		test_commit base &&
 		git repack -ad &&
@@ -211,11 +214,11 @@ test_expect_failure '--max-cruft-size combines smaller packs first' '
 		test-tool pack-mtimes "$(basename $cruft_bar)" >>expect.raw &&
 		sort expect.raw >expect.objects &&
 
-		# repacking with `--max-cruft-size=2M` should combine
-		# both 0.5 MiB packs together, instead of, say, one of
-		# the 0.5 MiB packs with the 1.0 MiB pack
+		# Repacking with `--combine-cruft-below-size=1M`
+		# should combine both 0.5 MiB packs together, but
+		# ignore the two packs which are >= 1.0 MiB.
 		ls $packdir/pack-*.mtimes | sort >cruft.before &&
-		git repack -d --cruft --max-cruft-size=2M &&
+		git repack -d --cruft --combine-cruft-below-size=1M &&
 		ls $packdir/pack-*.mtimes | sort >cruft.after &&
 
 		comm -13 cruft.before cruft.after >cruft.new &&
@@ -224,11 +227,12 @@ test_expect_failure '--max-cruft-size combines smaller packs first' '
 		test_line_count = 1 cruft.new &&
 		test_line_count = 2 cruft.removed &&
 
-		# the two smaller packs should be rolled up first
+		# The two packs smaller than 1.0MiB should be repacked
+		# together.
 		printf "%s\n" $cruft_foo $cruft_bar | sort >expect.removed &&
 		test_cmp expect.removed cruft.removed &&
 
-		# ...and contain the set of objects rolled up
+		# ...and contain the set of objects rolled up.
 		test-tool pack-mtimes "$(basename $(cat cruft.new))" >actual.raw &&
 		sort actual.raw >actual.objects &&
 
-- 
2.49.0.4.ge59cf92f8d
