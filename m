Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AD118C178
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 21:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721250772; cv=none; b=eCa62DC/SiGNPx/D7NN4uQHS+lNL4ldBllvB//ZJ2bjnAngFURA9GJ1tfYmylBGoCbVDcCyFCrQQlRPOwonwZkzpav8d6zab/sPB40kXONhZPHMLftLwYnbUy6fITA5Snxxn7yQYH2K3C4Z7m0OSh48HnGifaCyRdTiPR0PgMyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721250772; c=relaxed/simple;
	bh=PyJMXNw+HWvHfMQ8GqPb1y4cQH+UCtGp1h5WxqX8reA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mg70Y29xbGKNFYWUcT0+Id6uyj7hKQztZ7HZ/O21djYhXVyLWS3St2U/OBl4yoQ6hqwbbuktGfn7cxFSoGzCAgajDo9ohbZPis75DifZB/TT/K5IkUd25AT3rnxruNKQxdUGS5Y11GreY1FDbUTUacg0f55UdHlEpAe3bCeUQ6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=EqActHdq; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="EqActHdq"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-663dd13c0bbso704587b3.1
        for <git@vger.kernel.org>; Wed, 17 Jul 2024 14:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1721250769; x=1721855569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3ief6IM70Lb0TN4FVSp89G1ouPFUedSKUZwo7zsBmG4=;
        b=EqActHdqSQCHd0E28WurEJmk1mwC0+uEcv0pabt9ysI2q/+JbjldiIkXMP/fhPAwFf
         Kp9Mpg/zChjvGV1PqI4LPKnzUOx8li4p0pNRx4lzwxe525uhns1/sBYfgXr1+XeyEkaG
         s6v3ii2HPnCHdhUP6CnTFtRDDL8dAps2vyQKgu6MP1b9t+XV2rFSQqlZPQfZHtP609a0
         zb2Q53k3cZcwrVd8D52pltNFjWYa2D5ELb/o7u8egmOQiX4wKDEsNQnqjny2WBJGo9ou
         Kb8Sx0PfbvonQWDnV0ONGuhQSf2Wxc6K17euQKXO/LTBFyzljNqNRyEWvuJbqQTOc3fS
         71Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721250769; x=1721855569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ief6IM70Lb0TN4FVSp89G1ouPFUedSKUZwo7zsBmG4=;
        b=OjkgOO1WVII+xnBKBOQ+vsF7SDI0b9f4TDECLQF2JMhjXSo+bTl/dUk/+IP/1V1s+9
         uppaUe04JXpzHc1UfN99ykL8Xa0Yd7/wZBhC4ISFxZ7uiUJlr19/YgUvhqr8N5mHmOyZ
         qmWIlGHopS3mYsJvKroelJaENhCZswewLuSPHvNMwgJWU6QkQa02K+DI9Ol/OS58WJy3
         ZmSa5/eYfb1UGTrYpFB/WXbS2OKNgY4bO91CcOnF0kEiEf3flQeUvcHQFzPdUSbGcpWJ
         NbWGPlQCrYkBZ2H8sPqFtrRKX3Zc2/vs5d3x6LAyeto95Se4Fcgt1lhveHAcQn1pRt+1
         B16w==
X-Gm-Message-State: AOJu0YzOLaO7elyzIy5m0BGX54PiDSLdwcJwlc+oC/BaH/kwFmOtAoPa
	lZFoZnsoci3P0rxAFvPhn9jr0daHxdKRPPYoy0I9leHYQwrHpmSJwciS5ARU0Wn8/47ItC3hoCa
	t
X-Google-Smtp-Source: AGHT+IEA5+5QIre+DiyiCT9GKQ/17DE2yyoYlaQ750LKiPK1l460qqRSFh8U9XwNKj/WsoPhz6aLZA==
X-Received: by 2002:a05:6902:2081:b0:e02:6e1e:209b with SMTP id 3f1490d57ef6-e05ed797701mr3828756276.38.1721250769230;
        Wed, 17 Jul 2024 14:12:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e05feb6554asm82293276.54.2024.07.17.14.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 14:12:48 -0700 (PDT)
Date: Wed, 17 Jul 2024 17:12:47 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 17/19] t: retire 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP'
Message-ID: <23912425bf7c0106ed388f7712e7bb822572fe5d.1721250704.git.me@ttaylorr.com>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1721250704.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1721250704.git.me@ttaylorr.com>

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
index d9e0e07506..e8a11926e4 100644
--- a/t/README
+++ b/t/README
@@ -469,10 +469,6 @@ GIT_TEST_MULTI_PACK_INDEX=<boolean>, when true, forces the multi-pack-
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
index 10d2a6bf92..6e9ee23398 100755
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
2.46.0.rc0.94.g9b2aff57b3

