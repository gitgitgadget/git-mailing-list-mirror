Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1624C46444
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 15:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722958685; cv=none; b=J5eEOWf8+K62q7I2k/kSBMPxcXcOuyjA2c8Gx6QAmjsYeF44upOeHpIt8YhQIXped68TFfeXlis8Qqqe23d5JULHETjrX+4AleT92Eczuoom87A7jXMCnT1O+Fb6aNGUx82x9ejZMLECU8GKPw06/2txOMdxAEEOJcFgDddfciI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722958685; c=relaxed/simple;
	bh=AkkcNlUEyIY/IM7OggFsbSOBe5Zn4MGKI3vQhpx6lUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RbCeFbxOmhj2Py3YVUCBTlh8MZREyFkOPm+zqJg2jDKvm8LPDzjD8A+cNrhHDC0s4T+s3FDAAzo8EnfTG+NOweTD+xRffZX0YKC3CjyU3L2x6ug9vEJvb3GViVv830GzR+3Zim9z3nb6+G5AuFqhI10ghN+L3Xhjh/uT3KTmM3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=rl4f2N45; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="rl4f2N45"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-651da7c1531so5986227b3.0
        for <git@vger.kernel.org>; Tue, 06 Aug 2024 08:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722958683; x=1723563483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+/am1NonnBXhLzCaIUQTlPIkaTQnuwqyi2QfqD+JGZs=;
        b=rl4f2N45rMWERtzOQd0iHG72xOKdq0x4UkzGnBaq1q41R6nc45fd4p48SfBLZe8Lpp
         GaZo1vpsdDrNDPRcJ/mkBLEoPQmarSqgzHDCKvt/JXh8v4e/pc9Us/uqcBcdHGFbaqKE
         JePjxkeUcd45GPc8liw0R78m/7F+NUpOk73zyT0jbDsiY5K0S7TWXnU+43GA0Sqhtj1e
         jnjy2tQemnQ/grigFybTBbUgwaKHcidtf2LfuwNFUhQpssKbAf136pFKISKinKfIb1z4
         ZIMWE1/eOSW2bRMlTVI4BD7GJ4G64LRaZZNj5lvVknQ/BfbF+Xm0zRbSsCkbenDEz2O8
         f/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722958683; x=1723563483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/am1NonnBXhLzCaIUQTlPIkaTQnuwqyi2QfqD+JGZs=;
        b=XMdLKrh/xPJ99vFBpeio3WFDRZ8rLs+QQv3uFbaHb86ANi28tbBrx/GTQZB2Fr6qXP
         sUfvOTOFjzT/Flvg3COC9oGJM0BxypK5PuAPa2oPtmYowxub9h+Bao9zUsib++HYR4Lz
         0JADgooxpA4bkFfzbR/6fnhjTl9aWxYWIdSSfAZzB5Okia6uRplS4j/bPZQTk+U60pW1
         Pj4TBv2hD6PpDfyNrq/7CmQSIo0ReR2mpKZTCFy2Iki3rMhRTIac/L9/g+2ozSpIH/D6
         R7SzNK48LzHfLXW5AeZVLw+q1e/hLeOkWa1LK+Duo8oW7OxtNDVqXIrXC5BEMacWCGXl
         C16w==
X-Gm-Message-State: AOJu0YwXZm3MbF053Mc+5+EtRGTt3j79VmGykqVd4UgMoVZb3Qd/uj8A
	Y5WlmSsLTj2/xksJw91cUs34pPYy4uU8gFNCZyx32/tpcT2J1QnzCfJNum6WxYYQmwavvfRW/5k
	O
X-Google-Smtp-Source: AGHT+IHBIain+h1ILlczGWyexwiOrvVpxnSMT0aRX0EY+uGB2MTRNeq/SmN0pQsq2WYfcdC4re2lBA==
X-Received: by 2002:a0d:c803:0:b0:672:b4dd:eb41 with SMTP id 00721157ae682-6896077655bmr162257347b3.15.1722958682818;
        Tue, 06 Aug 2024 08:38:02 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-690b5f3fd19sm9642247b3.91.2024.08.06.08.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 08:38:02 -0700 (PDT)
Date: Tue, 6 Aug 2024 11:38:01 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 17/19] t: retire 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP'
Message-ID: <3b268f91bf3ec74cee5fc3ceaab19d700e30233e.1722958596.git.me@ttaylorr.com>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1722958595.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1722958595.git.me@ttaylorr.com>

Two years ago, commit ff1e653c8e2 (midx: respect
'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP', 2021-08-31) introduced a new
environment variable which caused the test suite to write MIDX bitmaps
after any 'git repack' invocation.

At the time, this was done to help flush out any bugs with MIDX bitmaps
that weren't explicitly covered in the t5326-multi-pack-bitmap.sh
script.

Two years later, that flag has served us well and is no longer providing
meaningful coverage, as the script in t5326 has matured substantially
and covers many more interesting cases than it did back when ff1e653c8e2
was originally written.

Remove the 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP' environment variable
as it is no longer serving a useful purpose. More importantly, removing
this variable clears the way for us to introduce a new one to help
similarly flush out bugs related to incremental MIDX chains.

Because these incremental MIDX chains are (for now) incompatible with
MIDX bitmaps, we cannot have both.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c                  | 12 ++----------
 ci/run-build-and-tests.sh         |  1 -
 midx.h                            |  2 --
 t/README                          |  4 ----
 t/t0410-partial-clone.sh          |  2 --
 t/t5310-pack-bitmaps.sh           |  4 ----
 t/t5319-multi-pack-index.sh       |  3 +--
 t/t5326-multi-pack-bitmaps.sh     |  3 +--
 t/t5327-multi-pack-bitmaps-rev.sh |  5 ++---
 t/t7700-repack.sh                 | 21 +++++++--------------
 10 files changed, 13 insertions(+), 44 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index f0317fa94a..8499bf0e12 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -1217,10 +1217,6 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		if (!write_midx &&
 		    (!(pack_everything & ALL_INTO_ONE) || !is_bare_repository()))
 			write_bitmaps = 0;
-	} else if (write_bitmaps &&
-		   git_env_bool(GIT_TEST_MULTI_PACK_INDEX, 0) &&
-		   git_env_bool(GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP, 0)) {
-		write_bitmaps = 0;
 	}
 	if (pack_kept_objects < 0)
 		pack_kept_objects = write_bitmaps > 0 && !write_midx;
@@ -1518,12 +1514,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (run_update_server_info)
 		update_server_info(0);
 
-	if (git_env_bool(GIT_TEST_MULTI_PACK_INDEX, 0)) {
-		unsigned flags = 0;
-		if (git_env_bool(GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP, 0))
-			flags |= MIDX_WRITE_BITMAP | MIDX_WRITE_REV_INDEX;
-		write_midx_file(get_object_directory(), NULL, NULL, flags);
-	}
+	if (git_env_bool(GIT_TEST_MULTI_PACK_INDEX, 0))
+		write_midx_file(get_object_directory(), NULL, NULL, 0);
 
 cleanup:
 	string_list_clear(&names, 1);
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 98dda42045..e6fd68630c 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -25,7 +25,6 @@ linux-TEST-vars)
 	export GIT_TEST_COMMIT_GRAPH=1
 	export GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1
 	export GIT_TEST_MULTI_PACK_INDEX=1
-	export GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=1
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
 	export GIT_TEST_NO_WRITE_REV_INDEX=1
 	export GIT_TEST_CHECKOUT_WORKERS=2
diff --git a/midx.h b/midx.h
index 9d30935589..3714cad2cc 100644
--- a/midx.h
+++ b/midx.h
@@ -29,8 +29,6 @@ struct bitmapped_pack;
 #define MIDX_LARGE_OFFSET_NEEDED 0x80000000
 
 #define GIT_TEST_MULTI_PACK_INDEX "GIT_TEST_MULTI_PACK_INDEX"
-#define GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP \
-	"GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP"
 
 struct multi_pack_index {
 	struct multi_pack_index *next;
diff --git a/t/README b/t/README
index 724ee58195..3cee0c05e2 100644
--- a/t/README
+++ b/t/README
@@ -445,10 +445,6 @@ GIT_TEST_MULTI_PACK_INDEX=<boolean>, when true, forces the multi-pack-
 index to be written after every 'git repack' command, and overrides the
 'core.multiPackIndex' setting to true.
 
-GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=<boolean>, when true, sets the
-'--bitmap' option on all invocations of 'git multi-pack-index write',
-and ignores pack-objects' '--write-bitmap-index'.
-
 GIT_TEST_SIDEBAND_ALL=<boolean>, when true, overrides the
 'uploadpack.allowSidebandAll' setting to true, and when false, forces
 fetch-pack to not request sideband-all (even if the server advertises
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 2c30c86e7b..34bdb3ab1f 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -5,8 +5,6 @@ test_description='partial clone'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
-# missing promisor objects cause repacks which write bitmaps to fail
-GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0
 # When enabled, some commands will write commit-graphs. This causes fsck
 # to fail when delete_object() is called because fsck will attempt to
 # verify the out-of-sync commit graph.
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index d7fd71360e..a6de7c5764 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -5,10 +5,6 @@ test_description='exercise basic bitmap functionality'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-bitmap.sh
 
-# t5310 deals only with single-pack bitmaps, so don't write MIDX bitmaps in
-# their place.
-GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0
-
 # Likewise, allow individual tests to control whether or not they use
 # the boundary-based traversal.
 sane_unset GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index ace5ac3b61..8c54fc0655 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -600,8 +600,7 @@ test_expect_success 'repack preserves multi-pack-index when creating packs' '
 compare_results_with_midx "after repack"
 
 test_expect_success 'multi-pack-index and pack-bitmap' '
-	GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0 \
-		git -c repack.writeBitmaps=true repack -ad &&
+	git -c repack.writeBitmaps=true repack -ad &&
 	git multi-pack-index write &&
 	git rev-list --test-bitmap HEAD
 '
diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index 916da389b6..1cb3e3ff08 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -4,10 +4,9 @@ test_description='exercise basic multi-pack bitmap functionality'
 . ./test-lib.sh
 . "${TEST_DIRECTORY}/lib-bitmap.sh"
 
-# We'll be writing our own midx and bitmaps, so avoid getting confused by the
+# We'll be writing our own MIDX, so avoid getting confused by the
 # automatic ones.
 GIT_TEST_MULTI_PACK_INDEX=0
-GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0
 
 # This test exercise multi-pack bitmap functionality where the object order is
 # stored and read from a special chunk within the MIDX, so use the default
diff --git a/t/t5327-multi-pack-bitmaps-rev.sh b/t/t5327-multi-pack-bitmaps-rev.sh
index e65e311cd7..23db949c20 100755
--- a/t/t5327-multi-pack-bitmaps-rev.sh
+++ b/t/t5327-multi-pack-bitmaps-rev.sh
@@ -5,10 +5,9 @@ test_description='exercise basic multi-pack bitmap functionality (.rev files)'
 . ./test-lib.sh
 . "${TEST_DIRECTORY}/lib-bitmap.sh"
 
-# We'll be writing our own midx and bitmaps, so avoid getting confused by the
-# automatic ones.
+# We'll be writing our own MIDX, so avoid getting confused by the automatic
+# ones.
 GIT_TEST_MULTI_PACK_INDEX=0
-GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0
 
 # Unlike t5326, this test exercise multi-pack bitmap functionality where the
 # object order is stored in a separate .rev file.
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 127efe99f8..8f34f05087 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -70,14 +70,13 @@ test_expect_success 'objects in packs marked .keep are not repacked' '
 
 test_expect_success 'writing bitmaps via command-line can duplicate .keep objects' '
 	# build on $oid, $packid, and .keep state from previous
-	GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0 git repack -Adbl &&
+	git repack -Adbl &&
 	test_has_duplicate_object true
 '
 
 test_expect_success 'writing bitmaps via config can duplicate .keep objects' '
 	# build on $oid, $packid, and .keep state from previous
-	GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0 \
-		git -c repack.writebitmaps=true repack -Adl &&
+	git -c repack.writebitmaps=true repack -Adl &&
 	test_has_duplicate_object true
 '
 
@@ -284,8 +283,7 @@ test_expect_success 'repacking fails when missing .pack actually means missing o
 test_expect_success 'bitmaps are created by default in bare repos' '
 	git clone --bare .git bare.git &&
 	rm -f bare.git/objects/pack/*.bitmap &&
-	GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0 \
-		git -C bare.git repack -ad &&
+	git -C bare.git repack -ad &&
 	bitmap=$(ls bare.git/objects/pack/*.bitmap) &&
 	test_path_is_file "$bitmap"
 '
@@ -296,8 +294,7 @@ test_expect_success 'incremental repack does not complain' '
 '
 
 test_expect_success 'bitmaps can be disabled on bare repos' '
-	GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0 \
-		git -c repack.writeBitmaps=false -C bare.git repack -ad &&
+	git -c repack.writeBitmaps=false -C bare.git repack -ad &&
 	bitmap=$(ls bare.git/objects/pack/*.bitmap || :) &&
 	test -z "$bitmap"
 '
@@ -308,8 +305,7 @@ test_expect_success 'no bitmaps created if .keep files present' '
 	keep=${pack%.pack}.keep &&
 	test_when_finished "rm -f \"\$keep\"" &&
 	>"$keep" &&
-	GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0 \
-		git -C bare.git repack -ad 2>stderr &&
+	git -C bare.git repack -ad 2>stderr &&
 	test_must_be_empty stderr &&
 	find bare.git/objects/pack/ -type f -name "*.bitmap" >actual &&
 	test_must_be_empty actual
@@ -320,8 +316,7 @@ test_expect_success 'auto-bitmaps do not complain if unavailable' '
 	blob=$(test-tool genrandom big $((1024*1024)) |
 	       git -C bare.git hash-object -w --stdin) &&
 	git -C bare.git update-ref refs/tags/big $blob &&
-	GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0 \
-		git -C bare.git repack -ad 2>stderr &&
+	git -C bare.git repack -ad 2>stderr &&
 	test_must_be_empty stderr &&
 	find bare.git/objects/pack -type f -name "*.bitmap" >actual &&
 	test_must_be_empty actual
@@ -342,9 +337,7 @@ test_expect_success 'repacking with a filter works' '
 '
 
 test_expect_success '--filter fails with --write-bitmap-index' '
-	test_must_fail \
-		env GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0 \
-		git -C bare.git repack -a -d --write-bitmap-index --filter=blob:none
+	test_must_fail git -C bare.git repack -a -d --write-bitmap-index --filter=blob:none
 '
 
 test_expect_success 'repacking with two filters works' '
-- 
2.46.0.46.g406f326d27.dirty

