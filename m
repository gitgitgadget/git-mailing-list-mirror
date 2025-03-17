Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F197205AC2
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 23:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742252433; cv=none; b=aiCHqAO5tad0V2bcdxzmv3NZYjT/EGx2h/iRqruoqt9a12traKwDR8xH33cn0cMKwq1pAOgfNe94MurNeAGppjegrSVKasXG5VBcNYiMAWCOpCUHhBipER1T1gM9+bXqp6Hfhp4brmbh3Dw/RRr9J3bMfMOl1FcdLoMmGyvdLpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742252433; c=relaxed/simple;
	bh=KBf/0OcdRkDRxvreY2JmLVY3K/QSuqE1VHjOKYJV1DQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FY48dWeUrfylzPIcD1pV9IfjKT1qBzzDPLzWXnXSBtJnYOWjJgc8vDTY7RVODJQX7TOf+ybN8rAhhcRQmZAbySVoUaznJ8H1u8YyvgH2Z1Q7HdFiXFxfOYqHtgQbQndPvcXAbHL0g0oa9Jf8vZyiRRB7t2IxVhW5U8CY9yhUqBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Ad/xCeiZ; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Ad/xCeiZ"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6eaf1b6ce9aso37519196d6.2
        for <git@vger.kernel.org>; Mon, 17 Mar 2025 16:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742252430; x=1742857230; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v2u4leih2MyhNfvd/YPXw0KSe+aYUm91j040RvPk4Po=;
        b=Ad/xCeiZYUihvjvi4zB5ZiWSK8cxKGIU+hNN1+Eavpkif0QQOewWT15EQFnzwvJN+/
         v/SnktIJ9sYJiCbAOKfmq0WzKJ4uzrqMSOvnjwxFcFod40Srdb3l6ikQvCDxZKeJlqXv
         qKnbgCBcfR718y1a+d+Vxoyc+zdmay2m4pr8lwg8LuS+e322ZehY8qlTGTbnZ/Gux0FL
         uN9dE1aoJMBhLDeKu+MklmNqWk45boQA+56wq/7ujgytMwSSRFFL4NG3AFmgmzBXV06P
         qFBwg/iPNb/PNq5TByNA1GpmG2Qv8YmMcnkXAId1wX2IxVSn2/XhdAsFd46FCXcd4ghH
         RgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742252430; x=1742857230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v2u4leih2MyhNfvd/YPXw0KSe+aYUm91j040RvPk4Po=;
        b=G78qme3Ju6jwgVfu3gKOH+amBBPUx6uvh/s8qezORqQpYhhDlj/v7lVFa4+YsGgckX
         4bcUSdm06MFm4E+kkyqvvuZ86CYOojDE1ZEbU0VqvQi6f9EUvkUuBB0jv8YFkgw1vo0N
         nK9LgG1ghQ3CIqByaGBRW1gIf+G3NfrsaJ/VhCKAa95kOHcrfhhsiF+ElSfdeH2j0PWO
         fxN7VrdIKlsyZiWODqpIsUBZ3kDnRoq/uxY1yvj3Vlrot3j6V1VZel4TnPtpDw4trTdR
         8T2sbN84A4/JZstdQU45URafblZisMA3iNOAwYJGLUKIwSAlIz275l6blk6ecKkvFJeU
         kagQ==
X-Gm-Message-State: AOJu0YzAxHWdHKRPsJA9uiEhukGJIK1+pNO1gxfLZB83vQT2SzEsuYxe
	HJ2gRTFyzRb9VVADV31H+wBG99EveghuQlFyL44/CfOlCLtAX19TlDfEkTUOQLNBUxpJXYQFniX
	w3SY=
X-Gm-Gg: ASbGnct/KO9k5lnVoJGsy7IIsJDtQv+OJU+LPpkemH2UxuYjkRs2MRekJOjGtsA5eTw
	q+MRxSn74v+cyB6FeeuklIoK+AfPC0QmplS8zHMta/OlWWQcx5EPhs4pYHBMJGvV2AEDL+vadi5
	a3lfh3tHIQ60SO6wq4IEaEfz4PQIU8zJtu3lZDe1opeZYZ2WeguETVCdO0z9dgRzNeUS2zy/ZSc
	ivN3nBMgj8CcH7cx2Cv1xHtV61lPAgdSeb87nG9BYdq9rvMya/t7SrUhyY78lW5kSZ8i7aSfaR6
	Su0njuEF+XjKim0795E2GPN2CHSlKVBYLWu195Zk5pmAS50+u5j5XnTXAl7ktUae2UwvQgYiAUa
	0g48SDda55CnQOxAr8Msx+F0VZy4=
X-Google-Smtp-Source: AGHT+IHWktikGnVxD9sbPg6XSn2VeNOv44QU4Q2cGS0PF0DDbwekibh24nc/YVBbLdas0IjNlDPokA==
X-Received: by 2002:a05:620a:31a5:b0:7c5:4348:1847 with SMTP id af79cd13be357-7c59b1bbb89mr179552785a.19.1742252430063;
        Mon, 17 Mar 2025 16:00:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573c73273sm641963185a.27.2025.03.17.16.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 16:00:29 -0700 (PDT)
Date: Mon, 17 Mar 2025 19:00:28 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH 5/5] repack: begin combining cruft packs with
 `--combine-cruft-below-size`
Message-ID: <7f120c35e95dcf41282c87dc2d1b2640ecdc5d84.1742252411.git.me@ttaylorr.com>
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

The previous commit changed the behavior of repack's '--max-cruft-size'
to specify a cruft pack-specific override for '--max-pack-size'.

Introduce a new flag, '--combine-cruft-below-size' which is a
replacement for the old behavior of '--max-cruft-size'. This new flag
does explicitly what it says: it combines together cruft packs which are
smaller than a given threshold, and prohibits repacking ones which are
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
cruft pack(s), they may use '--max-cruft-size' instead.

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
 Documentation/git-repack.adoc |  8 ++++++++
 builtin/repack.c              | 38 +++++++++++++++++++++++------------
 t/t7704-repack-cruft.sh       | 22 +++++++++++---------
 3 files changed, 46 insertions(+), 22 deletions(-)

diff --git a/Documentation/git-repack.adoc b/Documentation/git-repack.adoc
index 11db43b1c5..8e6d61aa2f 100644
--- a/Documentation/git-repack.adoc
+++ b/Documentation/git-repack.adoc
@@ -81,6 +81,14 @@ to the new separate pack will be written.
 	`--max-pack-size` (if any) by default. See the documentation for
 	`--max-pack-size` for more details.
 
+--combine-cruft-below-size=<n>::
+	When generating cruft packs without pruning, only repack
+	existing cruft packs whose size is strictly less than `<n>`.
+	Cruft packs whose size is greater than or equal to `<n>` are
+	left as-is and not repacked. Useful when you want to avoid
+	repacking large cruft pack(s) in repositories that have many
+	and/or large unreachable objects.
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
2.49.0.rc0.6.g7f120c35e9
