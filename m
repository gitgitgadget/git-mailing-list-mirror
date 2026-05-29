Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BE330AD10
	for <git@vger.kernel.org>; Fri, 29 May 2026 20:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780085250; cv=none; b=Jtlfut4UuZwas3kSVRjn+epeGANbdUPK/IFXFkI5DEqPhEcB6r9p7cimUWU0Q8Fddlu7KHIyh1VHIngmjidn6mi+KEOtTgSd+4OHnMCdfK0fPxKuNhJ3mPKRIfVSuS6WppS3shgfGz0JSlgyXiK+kGvIcY/ycX/7AvcFhR1vd4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780085250; c=relaxed/simple;
	bh=0keYnFlePIjcyaz2p5BnqGSkTIXJ54W+rQrvzhmkZLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ccENZd4UBdoj5w7HP94odhKipLf2jExWREo90RJQUIjtUWhBuVxjTUcpnjyZL1K4BBZWX/3xdfZOfkNsDIBBt/CySlfDLPqA+xX4mD92yp/sjpmEDMsuPV+SQFh4XG4BWe3p+nu3+OB8rFos8sBvpJteV+avtwNtoBKrpNji0/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=S5LrbqdW; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="S5LrbqdW"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7b4ee3a88e1so139978507b3.1
        for <git@vger.kernel.org>; Fri, 29 May 2026 13:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1780085248; x=1780690048; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a5wyP4LVW4e0Pkfhggi/e4AYrX4P6UvmwnJACr5Y+2M=;
        b=S5LrbqdW9cyoOrKuXuA+M/LCfiKx37i5AQGh8ZdVySf3W2YC7y9C/iVgJOR39rVbp3
         7ZJuhIbz1E16ZNhluG4Q2Zt5m1ahlNKxuFa2JxFig+0gorpR4sIwGjqkprTO0q7TZZ2k
         Ni7R7rr++CqRutZP2nW4v4cWMPEEXm3NoUX7xE5mGZa4piEA3yU60HUITegsPZenuCmK
         f+nAueMZ95wqYSs5+gW46nb2g0JVAWfMn6Kmj9oaL0kX6NkzE+7LPqC3mDKoTP3WjN6W
         MKSCtkxrufv0uHu2Hu8cls+gY7Hld4iZwbX9S30TfQQqzlEeppNfCJRLXSDichZGe/XA
         cX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780085248; x=1780690048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5wyP4LVW4e0Pkfhggi/e4AYrX4P6UvmwnJACr5Y+2M=;
        b=m5YbmRYfIePuUPcWKeeyEGtjd/cIbaVrA0qEdBW8nsV/LJUOLrtZVtATAr7wPTwngm
         3nULm6czSqCaxQanrj2Mm0kVHOjEz5VSGLB+YtX4is0f9oFprz6onre4Uu0BAlW8+OYX
         pHddL6veehZur8XYBoQ8i3InNyrXFAqwokyGgkrg971NugGNMobGQI8jEA5peEVSAiuA
         CJL8iSha61gqRsGneUdj36weuG+WoSXBIvdwYs38mskVgkrtxKc6sLPGXIi8Dm/expiX
         oDZeHNxGGEbsWgHTPykz00oPk5dvYmqkqBsKq1Pees/U9ZPbiNxAvCvC+Uc7ebBamYFc
         +Hfg==
X-Gm-Message-State: AOJu0YxkfdnCByHV1DaG0rvT8kkUjJ6HmHRFmiiVP3S3yjJT1F6MnQGx
	hhMgtRsHR0jrQ4SgrhbjFb7WUt2vIRhbc2zhLr8JaDaZ1i09/nfsOrajHaC1w3EaR2hms4RM3JA
	czAK996c=
X-Gm-Gg: Acq92OFF6/juJXbCIji7jX9H4siZg6LqzRu/NBhlci9qhTMvZGB9H29qYODnGDyuQW2
	PO/wRm4cgK1BnUhSSLeUvFu0pnG53eigpWMm1Oe/djVOQBbAMyl1FYtRSSnJ5AMkCSOu5bN2w/E
	SGXHyR4j3S7P59F9s71gC/0u2SGTUL3mSkGylPFq62P0raMvvJAXBYIRnGOgwJxq4+i+NdV6Vy8
	t5iLnnjiIRmoBA/SSPYQscjqQ35ClGJUmjNnUfOLAqseSQquS5rysCxqRdPaFMS2Tqdml9YcLFk
	78lCBd49TmWY56kybdZDRT/5R2twxgLtAnj+j0YbhnVeEzg4ROV6tQUXLP7Dd+wIhl7RiQBKnnN
	i7VxDKv0+YXQQh/PP9wC33T+Hl2h2OkRHrgb7kYp1+FNiNhzZP6kO5vGkbKXvFLV8Uxr68oOdoA
	xCDIXzpkwhLOU9tWzkK0vgfZ7i9crXY3xdzFPQZcldT4yaB4o9uJDSbj1UvZEIeo/imV15Ev12J
	yk3JLV5l/atjuHnaqwh6GxnWqZovBUDqghvrbT/kqUk/AHkQjLAiQQ2GNL1ljkVu2BRQCFvPOup
	k7UrCyLOrnsFjcITZ7MYoNKy51s=
X-Received: by 2002:a05:690c:7246:b0:7a6:1df5:c99e with SMTP id 00721157ae682-7e05d8ce921mr8921217b3.30.1780085247586;
        Fri, 29 May 2026 13:07:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7de689e6c03sm9989607b3.22.2026.05.29.13.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 13:07:27 -0700 (PDT)
Date: Fri, 29 May 2026 16:07:26 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/3] pack-objects: support bitmaps and delta-islands with
 `--path-walk`
Message-ID: <ahnx/oBWe9yyBZFg@nand.local>
References: <cover.1779923907.git.me@ttaylorr.com>
 <a708e23d-e0c2-48c9-86e9-1227f12edd53@gmail.com>
 <22a7e32f-f645-4f00-bc5b-6b4309e483c2@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <22a7e32f-f645-4f00-bc5b-6b4309e483c2@gmail.com>

On Fri, May 29, 2026 at 01:26:33PM -0400, Derrick Stolee wrote:
> On 5/28/26 11:28 AM, Derrick Stolee wrote:
> > On 5/27/26 7:18 PM, Taylor Blau wrote:
>
> > Do you have any end-to-end performance data to demonstrate that these
> > changes are effective at scale? Are we still producing packfiles with the
> > pack-file compression and now with .bitmap files? How does this impact
> > the performance of a clone or fetch when using a bitmap index at read
> > time?
>
> Here's my attempt to use our existing performance tests to analyze the
> impact of this series.
>
> Running p5311 against the base of this topic and this topic with
> GIT_TEST_PACK_PATH_WALK=1, I get this output:

Yikes. That's not great, but see below for what I think is going on.

(As an aside, we can focus in on either lookup=true or lookup=false,
since these are just controlling whether or not the bitmap lookup table
is written. On a repository as small as git.git, this shouldn't make a
huge difference either way. I have a separate series to make this the
default and to clean up the t/perf suite accordingly, but haven't sent
it to the list yet.)

> Test                                     HEAD~3    HEAD
> -----------------------------------------------------------------
> [...]

I think this is either the primary reason why you're not seeing an
improvement here, or at least related to it...

> Do you have a good feeling for why the path-walk feature doesn't
> make a huge change in these test scenarios?

I think the problem is that we're relying on the TEST_ variable to tell
pack-objects to generate a pack using --path-walk, but treat it as a
fallback.

I suspect that since p5311 invokes repack *without* the '--path-walk'
option, we end up in this case within cmd_pack_objects():

	if (path_walk < 0) {
		if (use_bitmap_index > 0 ||
		    !use_internal_rev_list)
			path_walk = 0;
		else if (the_repository->gitdir &&
			 the_repository->settings.pack_use_path_walk)
			path_walk = 1;
		else
			path_walk = git_env_bool("GIT_TEST_PACK_PATH_WALK", 0);
	}

, where `path_walk` is *not* set, but `use_bitmap_index` is since p5311
set the 'pack.writeBitmaps' configuration (as a separate aside, this
should really prefer the non-deprecated 'repack.writeBitmaps' variant).

So in that case, we fall back to `path_walk = 0`, and don't even bother
reading the `GIT_TEST_PACK_PATH_WALK` variable.

If I modify the perf test like so:

--- 8< ---
diff --git a/t/perf/p5311-pack-bitmaps-fetch.sh b/t/perf/p5311-pack-bitmaps-fetch.sh
index 047efb995d6..1c9c99216e3 100755
--- a/t/perf/p5311-pack-bitmaps-fetch.sh
+++ b/t/perf/p5311-pack-bitmaps-fetch.sh
@@ -13,7 +13,7 @@ test_fetch_bitmaps () {
 	test_expect_success 'create bitmapped server repo' '
 		git config pack.writebitmaps true &&
 		git config pack.writeBitmapLookupTable '"$1"' &&
-		git repack -ad
+		git repack -ad --path-walk
 	'

 	# simulate a fetch from a repository that last fetched N days ago, for
--- >8 ---

, then I can get significantly improved results when running without the
GIT_TEST_PACK_PATH_WALK variablle (here I'm truncating the
'lookup=false' case, which performs nearly identically):

    Test                                       HEAD~3            HEAD
    ------------------------------------------------------------------------------------
    5311.4: server   (1 days) (lookup=true)    2.57(2.52+0.04)   0.03(0.02+0.00) -98.8%
    5311.5: size     (1 days)                           153.4K            153.4K +0.0%
    5311.6: client   (1 days) (lookup=true)    0.00(0.01+0.00)   0.00(0.01+0.00) =
    5311.8: server   (2 days) (lookup=true)    2.60(2.55+0.04)   0.02(0.02+0.00) -99.2%
    5311.9: size     (2 days)                           153.4K            153.4K +0.0%
    5311.10: client   (2 days) (lookup=true)   0.00(0.01+0.00)   0.00(0.01+0.00) =
    5311.12: server   (4 days) (lookup=true)   2.60(2.54+0.05)   0.03(0.03+0.00) -98.8%
    5311.13: size     (4 days)                          209.0K            209.0K +0.0%
    5311.14: client   (4 days) (lookup=true)   0.01(0.02+0.00)   0.01(0.01+0.00) +0.0%
    5311.16: server   (8 days) (lookup=true)   2.58(2.53+0.04)   0.03(0.03+0.00) -98.8%
    5311.17: size     (8 days)                          209.0K            209.0K +0.0%
    5311.18: client   (8 days) (lookup=true)   0.01(0.01+0.00)   0.01(0.02+0.00) +0.0%
    5311.20: server  (16 days) (lookup=true)   2.58(2.52+0.05)   0.03(0.03+0.00) -98.8%
    5311.21: size    (16 days)                          209.0K            209.0K +0.0%
    5311.22: client  (16 days) (lookup=true)   0.01(0.02+0.00)   0.01(0.01+0.00) +0.0%
    5311.24: server  (32 days) (lookup=true)   2.61(2.58+0.03)   0.03(0.02+0.01) -98.9%
    5311.25: size    (32 days)                          212.9K            212.9K +0.0%
    5311.26: client  (32 days) (lookup=true)   0.01(0.02+0.00)   0.02(0.02+0.00) +100.0%
    5311.28: server  (64 days) (lookup=true)   2.72(2.79+0.06)   0.19(0.30+0.03) -93.0%
    5311.29: size    (64 days)                            4.5M              4.5M -0.0%
    5311.30: client  (64 days) (lookup=true)   0.49(0.58+0.02)   0.48(0.56+0.04) -2.0%
    5311.32: server (128 days) (lookup=true)   2.90(3.21+0.09)   0.35(0.70+0.04) -87.9%
    5311.33: size   (128 days)                            9.4M              9.5M +0.4%
    5311.34: client (128 days) (lookup=true)   0.98(1.27+0.08)   0.98(1.33+0.06) +0.0%

My reading here is that we get significantly smaller packs (i.e. all
'test_size' tests drop from HEAD~3 to HEAD) in the same amount of time
(i.e. that all 'test_perf' tests are roughly flat).

That lines up with my expectation here, which is that even though we're
using bitmaps at read time, that's effectively seeding the verbatim pack
reuse over a significantly smaller pack, producing a much smaller output
pack as a result.

As to whether we should modify the perf suite to test this, naturally I
think we should. Likely that looks like modifying p5313 to re-run
`test_all_with_args` with '--use-bitmap-index' after repacking with
--path-walk and generating bitmaps like so (untested):

--- 8< ---
diff --git a/t/perf/p5313-pack-objects.sh b/t/perf/p5313-pack-objects.sh
index 46a6cd32d24..663717982b1 100755
--- a/t/perf/p5313-pack-objects.sh
+++ b/t/perf/p5313-pack-objects.sh
@@ -22,6 +22,21 @@ test_expect_success 'create rev input' '
 	EOF
 '

+test_repack_with_args () {
+	args="$@"
+	export args
+
+	test_perf "repack with $args" '
+		git repack -adf $args
+	'
+
+	test_size "repack size with $args" '
+		gitdir=$(git rev-parse --git-dir) &&
+		pack=$(ls $gitdir/objects/pack/pack-*.pack) &&
+		test_file_size "$pack"
+	'
+}
+
 test_all_with_args () {
 	parameter=$1
 	export parameter
@@ -52,23 +67,22 @@ test_all_with_args () {
 	test_size "shallow pack size with $parameter" '
 		test_file_size out
 	'
-
-	test_perf "repack with $parameter" '
-		git repack -adf $parameter
-	'
-
-	test_size "repack size with $parameter" '
-		gitdir=$(git rev-parse --git-dir) &&
-		pack=$(ls $gitdir/objects/pack/pack-*.pack) &&
-		test_file_size "$pack"
-	'
 }

 for version in 1 2
 do
-	test_all_with_args --name-hash-version=$version
+	arg="--name-hash-version=$version" &&
+
+	test_all_with_args "$arg" &&
+	test_repack_with_args "$arg" || return 1
 done

 test_all_with_args --path-walk
+test_repack_with_args --path-walk
+
+# inverted order here: we want to test using reachability bitmaps on a
+# pack written with --path-walk
+test_repack_with_args --path-walk --write-bitmap-index
+test_all_with_args --use-bitmap-index

 test_done
--- >8 ---

I don't have a strong opinion on whether or not we should include that
in this series or elsewhere.

Thanks,
Taylor
