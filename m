Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E4120E021
	for <git@vger.kernel.org>; Thu, 17 Apr 2025 21:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744924345; cv=none; b=joBBAoq2CU+HP+Uh1d6CyPWRW4EKvv2+2aUSp48GtzL+K4vUDLX35EunWZ6kdQ3RzQ/e1g9H3yHP2wEjDTINKkRDs2Burgp11C25aCClJ2h+oSurCBgBY5AAR9jOL79aKn9ueN2nEodcxoDThZWGOYcuQ+3DZl4JErBZuHiOcvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744924345; c=relaxed/simple;
	bh=fj8vU7FR9F/qZtClnWRn7JepXSWYwf3YLmTuAoScBuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UpmVXktjykhZEmk+Okqlkx7SGD4+7/jAlx+e109z3fwm/Gun5p8KwfBYIVFMFJ5vHCA4F4aiqTLJlWdyqt2OFR8l2/1jLdAdxBi6aGzIG7WO3+TBHUeeEo4Fjxn7IEc50ay3iyUHjxnUPKUpZkhOVYOjlwMGAhHUrd/spNDRUU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=fLht5hdG; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="fLht5hdG"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c5b2472969so122367985a.1
        for <git@vger.kernel.org>; Thu, 17 Apr 2025 14:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1744924341; x=1745529141; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2phTotV+oShzmiwAUvA5ur83GsRNUF6Cts+dq3LavQ=;
        b=fLht5hdGWdX6SYpn2RgTaQW9C1Us9q9wfUQr0wZbKCKxx/H07EL/CTeaCF0Zjw6Ta8
         GUxD2qmXg36rR1YN/hqzrZCf2/IoIEE7ElPVMBjpc7ba8A7QflrmwbIH1bHPMUdhr/HH
         QKsHNNvfpxkSHCyVwn6A6g4JSBHALJxl9IyP4gbEujwxBjg3EZxUVKAXRpC6aqSZ2Z0d
         K+vsegPzM4otlT1NtEKlcA/MbaIlRxQTmpWCmk8jPSQ4CsTvjiOplHFbNaQL2q9rt9SY
         lTD4pUEQU7cnQUMbPua/GV3OnoY2eHjKRe/FPNYFWkaljMfjEOszcJojNEyNffPrUyj2
         lFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744924341; x=1745529141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z2phTotV+oShzmiwAUvA5ur83GsRNUF6Cts+dq3LavQ=;
        b=rdDjGxMm9tChZfXfx3rRE/ohSUrP1I+q6ZeN3tBdjDKl1pv8k6f27BoByJaMU7MqGY
         d4+wEZ7Kt0QuEIM3vV0QNMvA1A8joVkPfJNbQHhIsOhro2POINlFGdmVyIsphc6Sxcf2
         fOQNIs95lyBPEgNkuJZaXZV5C8OMcBDxNXc9RPtR6axdCMnGHo2Wpvp59E+sxoAzU+wN
         aO3Y0TrkcLqlKg2sR6Iju6hVpY33hQxdmiDqI5LjzLpxDGQ7mgzNdtvaHklh6NjDsaUo
         IFOvtMmqEtDsiTNSzrKyrzBynkXfjEngG6kA9PpTyIKYHhQqJaR+whp5dd2o33SO54SO
         AZfA==
X-Gm-Message-State: AOJu0YwRLCDZeX8GEUmM8NKEDj6pEKMh+YgIpYDTxPygwkPB1/yS4bcm
	bREUssXgNL94zvzyVYcFlhsA9BsOs4EIjdMPV2TXOJdGYprJ4lMzPLiFjOWj33ORetq8nc78z/c
	3kKU=
X-Gm-Gg: ASbGncs2dfwbUnT5Wmj5017j8j3St+npEoW4BSVFXL5n1ZXIelwlcj89CO601wFyx19
	7RENgzZ3yE4aHfNA3+B4N0mP2p/WhvAo4D24wo1WgrDThn5JgpN77T8qULLR/YFSHDyfBVJg9Hd
	Hw9G5gngSkkdU5ZILhsYcUKgVxA3szxfxbyjC81JSBdlrc4Z+o16Ur7H3cq36s7c/c5BVOu4XA3
	721bEjvq0eVCZEQnP+mA/lyYiQeyobXEpz5npb9mWEMb5B0dmIn2Dz426YSy32bEpBZvFFS47ap
	TNT1ywwqwLSgR8CJ4L0FasnMZT4vZOe6YYT9s8mWoHqshHDcNLmWIg/0f6qTO0DHVLAJbVl07uk
	03DRgLbX2mEDs
X-Google-Smtp-Source: AGHT+IGsKepdrQq6qUhQ6FQ//IrDiZa4vY/dU46ggS4IZIspfTvoTP4NoOeyTZjPMkeGW4w/oFfg8A==
X-Received: by 2002:a05:620a:bc4:b0:7c5:562d:ccf8 with SMTP id af79cd13be357-7c927f76f3cmr68662385a.8.1744924341493;
        Thu, 17 Apr 2025 14:12:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c925b75c8dsm32806185a.111.2025.04.17.14.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 14:12:21 -0700 (PDT)
Date: Thu, 17 Apr 2025 17:12:20 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/4] t/perf: avoid testing bitmaps without lookup table
Message-ID: <8cc5952e594b78ffb2ba4bcaabd62a8e5b8fe72a.1744924321.git.me@ttaylorr.com>
References: <cover.1744924321.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1744924321.git.me@ttaylorr.com>

In a previous commit, the setting which controls whether or not the
pack- and MIDX-bitmap machinery writes a lookup table,
'pack.writeBitmapLookupTable' was enabled by default.

As a result, we can clean up many of our bitmap-related performance
tests. Many of the relevant performance tests look something like:

    test_it () {
      test_expect_success 'setup pack.writeBitmapLookupTable' '
        git config pack.writeBitmapLookupTable '"$1"'
      '

      # ...
    }

    test_it true
    test_it false

, where the two invocations of 'test_it' run the tests with and without
bitmap lookup tables enabled.

But now that lookup tables are enabled by default and have proven to be
a performance win, let's avoid benchmarking what is now an uncommon and
non-default scenario.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/perf/p5310-pack-bitmaps.sh         |  47 +++++-------
 t/perf/p5311-pack-bitmaps-fetch.sh   |  76 +++++++++----------
 t/perf/p5326-multi-pack-bitmaps.sh   | 107 ++++++++++++---------------
 t/perf/p5333-pseudo-merge-bitmaps.sh |   1 -
 4 files changed, 102 insertions(+), 129 deletions(-)

diff --git a/t/perf/p5310-pack-bitmaps.sh b/t/perf/p5310-pack-bitmaps.sh
index b1399f1007..52f9fca14b 100755
--- a/t/perf/p5310-pack-bitmaps.sh
+++ b/t/perf/p5310-pack-bitmaps.sh
@@ -4,37 +4,28 @@ test_description='Tests pack performance using bitmaps'
 . ./perf-lib.sh
 . "${TEST_DIRECTORY}/perf/lib-bitmap.sh"
 
-test_lookup_pack_bitmap () {
-	test_expect_success 'start the test from scratch' '
-		rm -rf * .git
-	'
+test_expect_success 'start the test from scratch' '
+	rm -rf * .git
+'
 
-	test_perf_large_repo
+test_perf_large_repo
 
-	# note that we do everything through config,
-	# since we want to be able to compare bitmap-aware
-	# git versus non-bitmap git
-	#
-	# We intentionally use the deprecated pack.writebitmaps
-	# config so that we can test against older versions of git.
-	test_expect_success 'setup bitmap config' '
-		git config pack.writebitmaps true
-	'
+# note that we do everything through config,
+# since we want to be able to compare bitmap-aware
+# git versus non-bitmap git
+#
+# We intentionally use the deprecated pack.writebitmaps
+# config so that we can test against older versions of git.
+test_expect_success 'setup bitmap config' '
+	git config pack.writebitmaps true
+'
 
-	# we need to create the tag up front such that it is covered by the repack and
-	# thus by generated bitmaps.
-	test_expect_success 'create tags' '
-		git tag --message="tag pointing to HEAD" perf-tag HEAD
-	'
+# we need to create the tag up front such that it is covered by the repack and
+# thus by generated bitmaps.
+test_expect_success 'create tags' '
+	git tag --message="tag pointing to HEAD" perf-tag HEAD
+'
 
-	test_perf "enable lookup table: $1" '
-		git config pack.writeBitmapLookupTable '"$1"'
-	'
-
-	test_pack_bitmap
-}
-
-test_lookup_pack_bitmap false
-test_lookup_pack_bitmap true
+test_pack_bitmap
 
 test_done
diff --git a/t/perf/p5311-pack-bitmaps-fetch.sh b/t/perf/p5311-pack-bitmaps-fetch.sh
index 047efb995d..75b05a600e 100755
--- a/t/perf/p5311-pack-bitmaps-fetch.sh
+++ b/t/perf/p5311-pack-bitmaps-fetch.sh
@@ -3,52 +3,46 @@
 test_description='performance of fetches from bitmapped packs'
 . ./perf-lib.sh
 
-test_fetch_bitmaps () {
-	test_expect_success 'setup test directory' '
-		rm -fr * .git
-	'
-
-	test_perf_default_repo
+test_expect_success 'setup test directory' '
+	rm -fr * .git
+'
 
-	test_expect_success 'create bitmapped server repo' '
-		git config pack.writebitmaps true &&
-		git config pack.writeBitmapLookupTable '"$1"' &&
-		git repack -ad
-	'
+test_perf_default_repo
 
-	# simulate a fetch from a repository that last fetched N days ago, for
-	# various values of N. We do so by following the first-parent chain,
-	# and assume the first entry in the chain that is N days older than the current
-	# HEAD is where the HEAD would have been then.
-	for days in 1 2 4 8 16 32 64 128; do
-		title=$(printf '%10s' "($days days)")
-		test_expect_success "setup revs from $days days ago" '
-			now=$(git log -1 --format=%ct HEAD) &&
-			then=$(($now - ($days * 86400))) &&
-			tip=$(git rev-list -1 --first-parent --until=$then HEAD) &&
-			{
-				echo HEAD &&
-				echo ^$tip
-			} >revs
-		'
+test_expect_success 'create bitmapped server repo' '
+	git config pack.writebitmaps true &&
+	git repack -ad
+'
 
-		test_perf "server $title (lookup=$1)" '
-			git pack-objects --stdout --revs \
-					--thin --delta-base-offset \
-					<revs >tmp.pack
-		'
+# simulate a fetch from a repository that last fetched N days ago, for
+# various values of N. We do so by following the first-parent chain,
+# and assume the first entry in the chain that is N days older than the current
+# HEAD is where the HEAD would have been then.
+for days in 1 2 4 8 16 32 64 128; do
+	title=$(printf '%10s' "($days days)")
+	test_expect_success "setup revs from $days days ago" '
+		now=$(git log -1 --format=%ct HEAD) &&
+		then=$(($now - ($days * 86400))) &&
+		tip=$(git rev-list -1 --first-parent --until=$then HEAD) &&
+		{
+			echo HEAD &&
+			echo ^$tip
+		} >revs
+	'
 
-		test_size "size   $title" '
-			test_file_size tmp.pack
-		'
+	test_perf "server $title" '
+		git pack-objects --stdout --revs \
+				--thin --delta-base-offset \
+				<revs >tmp.pack
+	'
 
-		test_perf "client $title (lookup=$1)" '
-			git index-pack --stdin --fix-thin <tmp.pack
-		'
-	done
-}
+	test_size "size   $title" '
+		test_file_size tmp.pack
+	'
 
-test_fetch_bitmaps true
-test_fetch_bitmaps false
+	test_perf "client $title" '
+		git index-pack --stdin --fix-thin <tmp.pack
+	'
+done
 
 test_done
diff --git a/t/perf/p5326-multi-pack-bitmaps.sh b/t/perf/p5326-multi-pack-bitmaps.sh
index d082e6cacb..9f32582dec 100755
--- a/t/perf/p5326-multi-pack-bitmaps.sh
+++ b/t/perf/p5326-multi-pack-bitmaps.sh
@@ -4,64 +4,53 @@ test_description='Tests performance using midx bitmaps'
 . ./perf-lib.sh
 . "${TEST_DIRECTORY}/perf/lib-bitmap.sh"
 
-test_bitmap () {
-	local enabled="$1"
-
-	test_expect_success "remove existing repo (lookup=$enabled)" '
-		rm -fr * .git
-	'
-
-	test_perf_large_repo
-
-	# we need to create the tag up front such that it is covered by the repack and
-	# thus by generated bitmaps.
-	test_expect_success 'create tags' '
-		git tag --message="tag pointing to HEAD" perf-tag HEAD
-	'
-
-	test_expect_success "use lookup table: $enabled" '
-		git config pack.writeBitmapLookupTable '"$enabled"'
-	'
-
-	test_expect_success "start with bitmapped pack (lookup=$enabled)" '
-		git repack -adb
-	'
-
-	test_perf "setup multi-pack index (lookup=$enabled)" '
-		git multi-pack-index write --bitmap
-	'
-
-	test_expect_success "drop pack bitmap (lookup=$enabled)" '
-		rm -f .git/objects/pack/pack-*.bitmap
-	'
-
-	test_full_bitmap
-
-	test_expect_success "create partial bitmap state (lookup=$enabled)" '
-		# pick a commit to represent the repo tip in the past
-		cutoff=$(git rev-list HEAD~100 -1) &&
-		orig_tip=$(git rev-parse HEAD) &&
-
-		# now pretend we have just one tip
-		rm -rf .git/logs .git/refs/* .git/packed-refs &&
-		git update-ref HEAD $cutoff &&
-
-		# and then repack, which will leave us with a nice
-		# big bitmap pack of the "old" history, and all of
-		# the new history will be loose, as if it had been pushed
-		# up incrementally and exploded via unpack-objects
-		git repack -Ad &&
-		git multi-pack-index write --bitmap &&
-
-		# and now restore our original tip, as if the pushes
-		# had happened
-		git update-ref HEAD $orig_tip
-	'
-
-	test_partial_bitmap
-}
-
-test_bitmap false
-test_bitmap true
+test_expect_success "remove existing repo" '
+	rm -fr * .git
+'
+
+test_perf_large_repo
+
+# we need to create the tag up front such that it is covered by the repack and
+# thus by generated bitmaps.
+test_expect_success 'create tags' '
+	git tag --message="tag pointing to HEAD" perf-tag HEAD
+'
+
+test_expect_success "start with bitmapped pack" '
+	git repack -adb
+'
+
+test_perf "setup multi-pack index" '
+	git multi-pack-index write --bitmap
+'
+
+test_expect_success "drop pack bitmap" '
+	rm -f .git/objects/pack/pack-*.bitmap
+'
+
+test_full_bitmap
+
+test_expect_success "create partial bitmap state" '
+	# pick a commit to represent the repo tip in the past
+	cutoff=$(git rev-list HEAD~100 -1) &&
+	orig_tip=$(git rev-parse HEAD) &&
+
+	# now pretend we have just one tip
+	rm -rf .git/logs .git/refs/* .git/packed-refs &&
+	git update-ref HEAD $cutoff &&
+
+	# and then repack, which will leave us with a nice
+	# big bitmap pack of the "old" history, and all of
+	# the new history will be loose, as if it had been pushed
+	# up incrementally and exploded via unpack-objects
+	git repack -Ad &&
+	git multi-pack-index write --bitmap &&
+
+	# and now restore our original tip, as if the pushes
+	# had happened
+	git update-ref HEAD $orig_tip
+'
+
+test_partial_bitmap
 
 test_done
diff --git a/t/perf/p5333-pseudo-merge-bitmaps.sh b/t/perf/p5333-pseudo-merge-bitmaps.sh
index 2e8b1d2635..91b1c06745 100755
--- a/t/perf/p5333-pseudo-merge-bitmaps.sh
+++ b/t/perf/p5333-pseudo-merge-bitmaps.sh
@@ -11,7 +11,6 @@ test_expect_success 'setup' '
 		-c bitmapPseudoMerge.all.threshold=now \
 		-c bitmapPseudoMerge.all.stableThreshold=never \
 		-c bitmapPseudoMerge.all.maxMerges=64 \
-		-c pack.writeBitmapLookupTable=true \
 		repack -adb
 '
 
-- 
2.49.0.226.g0e6cae136d

