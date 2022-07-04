Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89443C433EF
	for <git@archiver.kernel.org>; Mon,  4 Jul 2022 08:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbiGDIqi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jul 2022 04:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbiGDIqa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jul 2022 04:46:30 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF43FBC1E
        for <git@vger.kernel.org>; Mon,  4 Jul 2022 01:46:26 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v16so968372wrd.13
        for <git@vger.kernel.org>; Mon, 04 Jul 2022 01:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wPSmqj3nq6C97mbn+4fhal6CV4TJrLSy3VZOO2w6vic=;
        b=Mo7RkZl/9rETLTOxkDvYbJ73euEmHVGBUFx1UfwivcJz30SafDQ3O6+P93s8SCEcAb
         4BD2q1MWdPpHJX0x2/Xut8PQNhfnscDdIsEBXAaUTesGKphzjyaPq3u/IbWYCZ2YnMYg
         bGqpjvUNNsL+zZlPK/3NvEcibdni/X4PLVIUO+yY2tigOz7IatX9hqCby1odknaIGwr2
         DWeZTB/u+h89a2D5UNghOWdD66I3u50wfyqbLANhzhVINohAJscwT4q4fHNg8TIkkAYF
         Nb+fI6gFgwfEMgC8WxHezf79MO36Yz7fE2yUWEvelSlxaaYkPBYCVpx1zTShFEdhpMcf
         DGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wPSmqj3nq6C97mbn+4fhal6CV4TJrLSy3VZOO2w6vic=;
        b=bVvuXDn1TozcwkqnsE5nzG72U8cGq/QOzVM9/yeea43LYVknGct60lj6tgG54pClCx
         BDdw/GZ2bIxdhWI80kSo0TfhuAdfiPWzO3IarG8/S/rATaZ6olLALHWctSsQ+usMZHew
         z6fzC7/mqhQVkxH+hJ8TcvG0J2v5CQL3ecXKKEcI9AGYlN8X7m23m9Y5JDjjdusXaQ1f
         gCW9lq/kYeBC8BBxxmTNxDBR3x948XKIu8SoTcc+gwXsRdgbHK0oNFg/71nkvztZUfOj
         vTMVa4GlIr6vJlha+acuBXm37fM0Ctq0uNvVBlx9Wel4wZeym1AEewwnjhKU8vc849PA
         ipOw==
X-Gm-Message-State: AJIora869+i99NNUOW0MAgeOnT0NRHWssA4WI1WFMYiA+0tmMHWNbu4V
        AkXNcGSh6VJ7ZvBgh2qjn/bV/SCkpnw=
X-Google-Smtp-Source: AGRyM1vaZtE1f5v6wjalnnHKDLTwBL7Ki40RuAVkgK/QiqZwQqQVh34bM1xA/zOKimKTRXLeebp9AQ==
X-Received: by 2002:adf:ecc6:0:b0:21a:3dca:4dd7 with SMTP id s6-20020adfecc6000000b0021a3dca4dd7mr25370946wro.366.1656924384294;
        Mon, 04 Jul 2022 01:46:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z18-20020a05600c0a1200b0039c45fc58c4sm18974887wmp.21.2022.07.04.01.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 01:46:23 -0700 (PDT)
Message-Id: <3dc40cc7f735401b6f4f7c307bfd18fede051609.1656924376.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1266.v3.git.1656924376.gitgitgadget@gmail.com>
References: <pull.1266.v2.git.1656249017.gitgitgadget@gmail.com>
        <pull.1266.v3.git.1656924376.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 Jul 2022 08:46:13 +0000
Subject: [PATCH v3 3/6] pack-bitmap-write: learn pack.writeBitmapLookupTable
 and add tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>

Teach Git to provide a way for users to enable/disable bitmap lookup
table extension by providing a config option named 'writeBitmapLookupTable'.
Default is false.

Also add test to verify writting of lookup table.

Mentored-by: Taylor Blau <me@ttaylorr.com>
Co-Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Co-Authored-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
---
 Documentation/config/pack.txt     |   7 +
 builtin/multi-pack-index.c        |   7 +
 builtin/pack-objects.c            |   8 +
 midx.c                            |   3 +
 midx.h                            |   1 +
 t/t5310-pack-bitmaps.sh           | 792 ++++++++++++++++--------------
 t/t5311-pack-bitmaps-shallow.sh   |  53 +-
 t/t5326-multi-pack-bitmaps.sh     | 421 +++++++++-------
 t/t5327-multi-pack-bitmaps-rev.sh |   9 +
 9 files changed, 720 insertions(+), 581 deletions(-)

diff --git a/Documentation/config/pack.txt b/Documentation/config/pack.txt
index ad7f73a1ead..b955ca572ec 100644
--- a/Documentation/config/pack.txt
+++ b/Documentation/config/pack.txt
@@ -164,6 +164,13 @@ When writing a multi-pack reachability bitmap, no new namehashes are
 computed; instead, any namehashes stored in an existing bitmap are
 permuted into their appropriate location when writing a new bitmap.
 
+pack.writeBitmapLookupTable::
+	When true, Git will include a "lookup table" section in the
+	bitmap index (if one is written). This table is used to defer
+	loading individual bitmaps as late as possible. This can be
+	beneficial in repositories that have relatively large bitmap
+	indexes. Defaults to false.
+
 pack.writeReverseIndex::
 	When true, git will write a corresponding .rev file (see:
 	link:../technical/pack-format.html[Documentation/technical/pack-format.txt])
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 5edbb7fe86e..55402b46f41 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -87,6 +87,13 @@ static int git_multi_pack_index_write_config(const char *var, const char *value,
 			opts.flags &= ~MIDX_WRITE_BITMAP_HASH_CACHE;
 	}
 
+	if (!strcmp(var, "pack.writebitmaplookuptable")) {
+		if (git_config_bool(var, value))
+			opts.flags |= MIDX_WRITE_BITMAP_LOOKUP_TABLE;
+		else
+			opts.flags &= ~MIDX_WRITE_BITMAP_LOOKUP_TABLE;
+	}
+
 	/*
 	 * We should never make a fall-back call to 'git_default_config', since
 	 * this was already called in 'cmd_multi_pack_index()'.
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 39e28cfcafc..46e26774963 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3148,6 +3148,14 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 		else
 			write_bitmap_options &= ~BITMAP_OPT_HASH_CACHE;
 	}
+
+	if (!strcmp(k, "pack.writebitmaplookuptable")) {
+		if (git_config_bool(k, v))
+			write_bitmap_options |= BITMAP_OPT_LOOKUP_TABLE;
+		else
+			write_bitmap_options &= ~BITMAP_OPT_LOOKUP_TABLE;
+	}
+
 	if (!strcmp(k, "pack.usebitmaps")) {
 		use_bitmap_index_default = git_config_bool(k, v);
 		return 0;
diff --git a/midx.c b/midx.c
index 5f0dd386b02..9c26d04bfde 100644
--- a/midx.c
+++ b/midx.c
@@ -1072,6 +1072,9 @@ static int write_midx_bitmap(char *midx_name, unsigned char *midx_hash,
 	if (flags & MIDX_WRITE_BITMAP_HASH_CACHE)
 		options |= BITMAP_OPT_HASH_CACHE;
 
+	if (flags & MIDX_WRITE_BITMAP_LOOKUP_TABLE)
+		options |= BITMAP_OPT_LOOKUP_TABLE;
+
 	prepare_midx_packing_data(&pdata, ctx);
 
 	commits = find_commits_for_midx_bitmap(&commits_nr, refs_snapshot, ctx);
diff --git a/midx.h b/midx.h
index 22e8e53288e..5578cd7b835 100644
--- a/midx.h
+++ b/midx.h
@@ -47,6 +47,7 @@ struct multi_pack_index {
 #define MIDX_WRITE_REV_INDEX (1 << 1)
 #define MIDX_WRITE_BITMAP (1 << 2)
 #define MIDX_WRITE_BITMAP_HASH_CACHE (1 << 3)
+#define MIDX_WRITE_BITMAP_LOOKUP_TABLE (1 << 4)
 
 const unsigned char *get_midx_checksum(struct multi_pack_index *m);
 void get_midx_filename(struct strbuf *out, const char *object_dir);
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index f775fc1ce69..c0607172827 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -26,22 +26,413 @@ has_any () {
 	grep -Ff "$1" "$2"
 }
 
-setup_bitmap_history
-
-test_expect_success 'setup writing bitmaps during repack' '
-	git config repack.writeBitmaps true
-'
-
-test_expect_success 'full repack creates bitmaps' '
-	GIT_TRACE2_EVENT="$(pwd)/trace" \
+test_bitmap_cases () {
+	writeLookupTable=false
+	for i in "$@"
+	do
+		case "$i" in
+		"pack.writeBitmapLookupTable") writeLookupTable=true;;
+		esac
+	done
+
+	test_expect_success 'setup test repository' '
+		rm -fr * .git &&
+		git init &&
+		git config pack.writeBitmapLookupTable '"$writeLookupTable"'
+	'
+	setup_bitmap_history
+
+	test_expect_success 'setup writing bitmaps during repack' '
+		git config repack.writeBitmaps true
+	'
+
+	test_expect_success 'full repack creates bitmaps' '
+		GIT_TRACE2_EVENT="$(pwd)/trace" \
+			git repack -ad &&
+		ls .git/objects/pack/ | grep bitmap >output &&
+		test_line_count = 1 output &&
+		grep "\"key\":\"num_selected_commits\",\"value\":\"106\"" trace &&
+		grep "\"key\":\"num_maximal_commits\",\"value\":\"107\"" trace
+	'
+
+	basic_bitmap_tests
+
+	test_expect_success 'pack-objects respects --local (non-local loose)' '
+		git init --bare alt.git &&
+		echo $(pwd)/alt.git/objects >.git/objects/info/alternates &&
+		echo content1 >file1 &&
+		# non-local loose object which is not present in bitmapped pack
+		altblob=$(GIT_DIR=alt.git git hash-object -w file1) &&
+		# non-local loose object which is also present in bitmapped pack
+		git cat-file blob $blob | GIT_DIR=alt.git git hash-object -w --stdin &&
+		git add file1 &&
+		test_tick &&
+		git commit -m commit_file1 &&
+		echo HEAD | git pack-objects --local --stdout --revs >1.pack &&
+		git index-pack 1.pack &&
+		list_packed_objects 1.idx >1.objects &&
+		printf "%s\n" "$altblob" "$blob" >nonlocal-loose &&
+		! has_any nonlocal-loose 1.objects
+	'
+
+	test_expect_success 'pack-objects respects --honor-pack-keep (local non-bitmapped pack)' '
+		echo content2 >file2 &&
+		blob2=$(git hash-object -w file2) &&
+		git add file2 &&
+		test_tick &&
+		git commit -m commit_file2 &&
+		printf "%s\n" "$blob2" "$bitmaptip" >keepobjects &&
+		pack2=$(git pack-objects pack2 <keepobjects) &&
+		mv pack2-$pack2.* .git/objects/pack/ &&
+		>.git/objects/pack/pack2-$pack2.keep &&
+		rm $(objpath $blob2) &&
+		echo HEAD | git pack-objects --honor-pack-keep --stdout --revs >2a.pack &&
+		git index-pack 2a.pack &&
+		list_packed_objects 2a.idx >2a.objects &&
+		! has_any keepobjects 2a.objects
+	'
+
+	test_expect_success 'pack-objects respects --local (non-local pack)' '
+		mv .git/objects/pack/pack2-$pack2.* alt.git/objects/pack/ &&
+		echo HEAD | git pack-objects --local --stdout --revs >2b.pack &&
+		git index-pack 2b.pack &&
+		list_packed_objects 2b.idx >2b.objects &&
+		! has_any keepobjects 2b.objects
+	'
+
+	test_expect_success 'pack-objects respects --honor-pack-keep (local bitmapped pack)' '
+		ls .git/objects/pack/ | grep bitmap >output &&
+		test_line_count = 1 output &&
+		packbitmap=$(basename $(cat output) .bitmap) &&
+		list_packed_objects .git/objects/pack/$packbitmap.idx >packbitmap.objects &&
+		test_when_finished "rm -f .git/objects/pack/$packbitmap.keep" &&
+		>.git/objects/pack/$packbitmap.keep &&
+		echo HEAD | git pack-objects --honor-pack-keep --stdout --revs >3a.pack &&
+		git index-pack 3a.pack &&
+		list_packed_objects 3a.idx >3a.objects &&
+		! has_any packbitmap.objects 3a.objects
+	'
+
+	test_expect_success 'pack-objects respects --local (non-local bitmapped pack)' '
+		mv .git/objects/pack/$packbitmap.* alt.git/objects/pack/ &&
+		rm -f .git/objects/pack/multi-pack-index &&
+		test_when_finished "mv alt.git/objects/pack/$packbitmap.* .git/objects/pack/" &&
+		echo HEAD | git pack-objects --local --stdout --revs >3b.pack &&
+		git index-pack 3b.pack &&
+		list_packed_objects 3b.idx >3b.objects &&
+		! has_any packbitmap.objects 3b.objects
+	'
+
+	test_expect_success 'pack-objects to file can use bitmap' '
+		# make sure we still have 1 bitmap index from previous tests
+		ls .git/objects/pack/ | grep bitmap >output &&
+		test_line_count = 1 output &&
+		# verify equivalent packs are generated with/without using bitmap index
+		packasha1=$(git pack-objects --no-use-bitmap-index --all packa </dev/null) &&
+		packbsha1=$(git pack-objects --use-bitmap-index --all packb </dev/null) &&
+		list_packed_objects packa-$packasha1.idx >packa.objects &&
+		list_packed_objects packb-$packbsha1.idx >packb.objects &&
+		test_cmp packa.objects packb.objects
+	'
+
+	test_expect_success 'full repack, reusing previous bitmaps' '
 		git repack -ad &&
-	ls .git/objects/pack/ | grep bitmap >output &&
-	test_line_count = 1 output &&
-	grep "\"key\":\"num_selected_commits\",\"value\":\"106\"" trace &&
-	grep "\"key\":\"num_maximal_commits\",\"value\":\"107\"" trace
-'
+		ls .git/objects/pack/ | grep bitmap >output &&
+		test_line_count = 1 output
+	'
+
+	test_expect_success 'fetch (full bitmap)' '
+		git --git-dir=clone.git fetch origin second:second &&
+		git rev-parse HEAD >expect &&
+		git --git-dir=clone.git rev-parse HEAD >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success 'create objects for missing-HAVE tests' '
+		blob=$(echo "missing have" | git hash-object -w --stdin) &&
+		tree=$(printf "100644 blob $blob\tfile\n" | git mktree) &&
+		parent=$(echo parent | git commit-tree $tree) &&
+		commit=$(echo commit | git commit-tree $tree -p $parent) &&
+		cat >revs <<-EOF
+		HEAD
+		^HEAD^
+		^$commit
+		EOF
+	'
+
+	test_expect_success 'pack-objects respects --incremental' '
+		cat >revs2 <<-EOF &&
+		HEAD
+		$commit
+		EOF
+		git pack-objects --incremental --stdout --revs <revs2 >4.pack &&
+		git index-pack 4.pack &&
+		list_packed_objects 4.idx >4.objects &&
+		test_line_count = 4 4.objects &&
+		git rev-list --objects $commit >revlist &&
+		cut -d" " -f1 revlist |sort >objects &&
+		test_cmp 4.objects objects
+	'
+
+	test_expect_success 'pack with missing blob' '
+		rm $(objpath $blob) &&
+		git pack-objects --stdout --revs <revs >/dev/null
+	'
+
+	test_expect_success 'pack with missing tree' '
+		rm $(objpath $tree) &&
+		git pack-objects --stdout --revs <revs >/dev/null
+	'
+
+	test_expect_success 'pack with missing parent' '
+		rm $(objpath $parent) &&
+		git pack-objects --stdout --revs <revs >/dev/null
+	'
+
+	test_expect_success JGIT,SHA1 'we can read jgit bitmaps' '
+		git clone --bare . compat-jgit.git &&
+		(
+			cd compat-jgit.git &&
+			rm -f objects/pack/*.bitmap &&
+			jgit gc &&
+			git rev-list --test-bitmap HEAD
+		)
+	'
+
+	test_expect_success JGIT,SHA1 'jgit can read our bitmaps' '
+		git clone --bare . compat-us.git &&
+		(
+			cd compat-us.git &&
+			git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
+			git repack -adb &&
+			# jgit gc will barf if it does not like our bitmaps
+			jgit gc
+		)
+	'
+
+	test_expect_success 'splitting packs does not generate bogus bitmaps' '
+		test-tool genrandom foo $((1024 * 1024)) >rand &&
+		git add rand &&
+		git commit -m "commit with big file" &&
+		git -c pack.packSizeLimit=500k repack -adb &&
+		git init --bare no-bitmaps.git &&
+		git -C no-bitmaps.git fetch .. HEAD
+	'
+
+	test_expect_success 'set up reusable pack' '
+		rm -f .git/objects/pack/*.keep &&
+		git repack -adb &&
+		reusable_pack () {
+			git for-each-ref --format="%(objectname)" |
+			git pack-objects --delta-base-offset --revs --stdout "$@"
+		}
+	'
+
+	test_expect_success 'pack reuse respects --honor-pack-keep' '
+		test_when_finished "rm -f .git/objects/pack/*.keep" &&
+		for i in .git/objects/pack/*.pack
+		do
+			>${i%.pack}.keep || return 1
+		done &&
+		reusable_pack --honor-pack-keep >empty.pack &&
+		git index-pack empty.pack &&
+		git show-index <empty.idx >actual &&
+		test_must_be_empty actual
+	'
+
+	test_expect_success 'pack reuse respects --local' '
+		mv .git/objects/pack/* alt.git/objects/pack/ &&
+		test_when_finished "mv alt.git/objects/pack/* .git/objects/pack/" &&
+		reusable_pack --local >empty.pack &&
+		git index-pack empty.pack &&
+		git show-index <empty.idx >actual &&
+		test_must_be_empty actual
+	'
+
+	test_expect_success 'pack reuse respects --incremental' '
+		reusable_pack --incremental >empty.pack &&
+		git index-pack empty.pack &&
+		git show-index <empty.idx >actual &&
+		test_must_be_empty actual
+	'
+
+	test_expect_success 'truncated bitmap fails gracefully (ewah)' '
+		test_config pack.writebitmaphashcache false &&
+		git repack -ad &&
+		git rev-list --use-bitmap-index --count --all >expect &&
+		bitmap=$(ls .git/objects/pack/*.bitmap) &&
+		test_when_finished "rm -f $bitmap" &&
+		test_copy_bytes 256 <$bitmap >$bitmap.tmp &&
+		mv -f $bitmap.tmp $bitmap &&
+		git rev-list --use-bitmap-index --count --all >actual 2>stderr &&
+		test_cmp expect actual &&
+		test_i18ngrep corrupt.ewah.bitmap stderr
+	'
+
+	test_expect_success 'truncated bitmap fails gracefully (cache)' '
+		git repack -ad &&
+		git rev-list --use-bitmap-index --count --all >expect &&
+		bitmap=$(ls .git/objects/pack/*.bitmap) &&
+		test_when_finished "rm -f $bitmap" &&
+		test_copy_bytes 512 <$bitmap >$bitmap.tmp &&
+		mv -f $bitmap.tmp $bitmap &&
+		git rev-list --use-bitmap-index --count --all >actual 2>stderr &&
+		test_cmp expect actual &&
+		test_i18ngrep corrupted.bitmap.index stderr
+	'
+
+	# Create a state of history with these properties:
+	#
+	#  - refs that allow a client to fetch some new history, while sharing some old
+	#    history with the server; we use branches delta-reuse-old and
+	#    delta-reuse-new here
+	#
+	#  - the new history contains an object that is stored on the server as a delta
+	#    against a base that is in the old history
+	#
+	#  - the base object is not immediately reachable from the tip of the old
+	#    history; finding it would involve digging down through history we know the
+	#    other side has
+	#
+	# This should result in a state where fetching from old->new would not
+	# traditionally reuse the on-disk delta (because we'd have to dig to realize
+	# that the client has it), but we will do so if bitmaps can tell us cheaply
+	# that the other side has it.
+	test_expect_success 'set up thin delta-reuse parent' '
+		# This first commit contains the buried base object.
+		test-tool genrandom delta 16384 >file &&
+		git add file &&
+		git commit -m "delta base" &&
+		base=$(git rev-parse --verify HEAD:file) &&
+
+		# These intermediate commits bury the base back in history.
+		# This becomes the "old" state.
+		for i in 1 2 3 4 5
+		do
+			echo $i >file &&
+			git commit -am "intermediate $i" || return 1
+		done &&
+		git branch delta-reuse-old &&
+
+		# And now our new history has a delta against the buried base. Note
+		# that this must be smaller than the original file, since pack-objects
+		# prefers to create deltas from smaller objects to larger.
+		test-tool genrandom delta 16300 >file &&
+		git commit -am "delta result" &&
+		delta=$(git rev-parse --verify HEAD:file) &&
+		git branch delta-reuse-new &&
+
+		# Repack with bitmaps and double check that we have the expected delta
+		# relationship.
+		git repack -adb &&
+		have_delta $delta $base
+	'
+
+	# Now we can sanity-check the non-bitmap behavior (that the server is not able
+	# to reuse the delta). This isn't strictly something we care about, so this
+	# test could be scrapped in the future. But it makes sure that the next test is
+	# actually triggering the feature we want.
+	#
+	# Note that our tools for working with on-the-wire "thin" packs are limited. So
+	# we actually perform the fetch, retain the resulting pack, and inspect the
+	# result.
+	test_expect_success 'fetch without bitmaps ignores delta against old base' '
+		test_config pack.usebitmaps false &&
+		test_when_finished "rm -rf client.git" &&
+		git init --bare client.git &&
+		(
+			cd client.git &&
+			git config transfer.unpackLimit 1 &&
+			git fetch .. delta-reuse-old:delta-reuse-old &&
+			git fetch .. delta-reuse-new:delta-reuse-new &&
+			have_delta $delta $ZERO_OID
+		)
+	'
+
+	# And do the same for the bitmap case, where we do expect to find the delta.
+	test_expect_success 'fetch with bitmaps can reuse old base' '
+		test_config pack.usebitmaps true &&
+		test_when_finished "rm -rf client.git" &&
+		git init --bare client.git &&
+		(
+			cd client.git &&
+			git config transfer.unpackLimit 1 &&
+			git fetch .. delta-reuse-old:delta-reuse-old &&
+			git fetch .. delta-reuse-new:delta-reuse-new &&
+			have_delta $delta $base
+		)
+	'
+
+	test_expect_success 'pack.preferBitmapTips' '
+		git init repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+			git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
+
+			# create enough commits that not all are receive bitmap
+			# coverage even if they are all at the tip of some reference.
+			test_commit_bulk --message="%s" 103 &&
+
+			git rev-list HEAD >commits.raw &&
+			sort <commits.raw >commits &&
+
+			git log --format="create refs/tags/%s %H" HEAD >refs &&
+			git update-ref --stdin <refs &&
+
+			git repack -adb &&
+			test-tool bitmap list-commits | sort >bitmaps &&
+
+			# remember which commits did not receive bitmaps
+			comm -13 bitmaps commits >before &&
+			test_file_not_empty before &&
+
+			# mark the commits which did not receive bitmaps as preferred,
+			# and generate the bitmap again
+			perl -pe "s{^}{create refs/tags/include/$. }" <before |
+				git update-ref --stdin &&
+			git -c pack.preferBitmapTips=refs/tags/include repack -adb &&
+
+			# finally, check that the commit(s) without bitmap coverage
+			# are not the same ones as before
+			test-tool bitmap list-commits | sort >bitmaps &&
+			comm -13 bitmaps commits >after &&
+
+			! test_cmp before after
+		)
+	'
+
+	test_expect_success 'complains about multiple pack bitmaps' '
+		rm -fr repo &&
+		git init repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+			git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
+
+			test_commit base &&
+
+			git repack -adb &&
+			bitmap="$(ls .git/objects/pack/pack-*.bitmap)" &&
+			mv "$bitmap" "$bitmap.bak" &&
+
+			test_commit other &&
+			git repack -ab &&
+
+			mv "$bitmap.bak" "$bitmap" &&
+
+			find .git/objects/pack -type f -name "*.pack" >packs &&
+			find .git/objects/pack -type f -name "*.bitmap" >bitmaps &&
+			test_line_count = 2 packs &&
+			test_line_count = 2 bitmaps &&
+
+			git rev-list --use-bitmap-index HEAD 2>err &&
+			grep "ignoring extra bitmap file" err
+		)
+	'
+}
 
-basic_bitmap_tests
+test_bitmap_cases
 
 test_expect_success 'incremental repack fails when bitmaps are requested' '
 	test_commit more-1 &&
@@ -54,375 +445,12 @@ test_expect_success 'incremental repack can disable bitmaps' '
 	git repack -d --no-write-bitmap-index
 '
 
-test_expect_success 'pack-objects respects --local (non-local loose)' '
-	git init --bare alt.git &&
-	echo $(pwd)/alt.git/objects >.git/objects/info/alternates &&
-	echo content1 >file1 &&
-	# non-local loose object which is not present in bitmapped pack
-	altblob=$(GIT_DIR=alt.git git hash-object -w file1) &&
-	# non-local loose object which is also present in bitmapped pack
-	git cat-file blob $blob | GIT_DIR=alt.git git hash-object -w --stdin &&
-	git add file1 &&
-	test_tick &&
-	git commit -m commit_file1 &&
-	echo HEAD | git pack-objects --local --stdout --revs >1.pack &&
-	git index-pack 1.pack &&
-	list_packed_objects 1.idx >1.objects &&
-	printf "%s\n" "$altblob" "$blob" >nonlocal-loose &&
-	! has_any nonlocal-loose 1.objects
-'
-
-test_expect_success 'pack-objects respects --honor-pack-keep (local non-bitmapped pack)' '
-	echo content2 >file2 &&
-	blob2=$(git hash-object -w file2) &&
-	git add file2 &&
-	test_tick &&
-	git commit -m commit_file2 &&
-	printf "%s\n" "$blob2" "$bitmaptip" >keepobjects &&
-	pack2=$(git pack-objects pack2 <keepobjects) &&
-	mv pack2-$pack2.* .git/objects/pack/ &&
-	>.git/objects/pack/pack2-$pack2.keep &&
-	rm $(objpath $blob2) &&
-	echo HEAD | git pack-objects --honor-pack-keep --stdout --revs >2a.pack &&
-	git index-pack 2a.pack &&
-	list_packed_objects 2a.idx >2a.objects &&
-	! has_any keepobjects 2a.objects
-'
-
-test_expect_success 'pack-objects respects --local (non-local pack)' '
-	mv .git/objects/pack/pack2-$pack2.* alt.git/objects/pack/ &&
-	echo HEAD | git pack-objects --local --stdout --revs >2b.pack &&
-	git index-pack 2b.pack &&
-	list_packed_objects 2b.idx >2b.objects &&
-	! has_any keepobjects 2b.objects
-'
-
-test_expect_success 'pack-objects respects --honor-pack-keep (local bitmapped pack)' '
-	ls .git/objects/pack/ | grep bitmap >output &&
-	test_line_count = 1 output &&
-	packbitmap=$(basename $(cat output) .bitmap) &&
-	list_packed_objects .git/objects/pack/$packbitmap.idx >packbitmap.objects &&
-	test_when_finished "rm -f .git/objects/pack/$packbitmap.keep" &&
-	>.git/objects/pack/$packbitmap.keep &&
-	echo HEAD | git pack-objects --honor-pack-keep --stdout --revs >3a.pack &&
-	git index-pack 3a.pack &&
-	list_packed_objects 3a.idx >3a.objects &&
-	! has_any packbitmap.objects 3a.objects
-'
-
-test_expect_success 'pack-objects respects --local (non-local bitmapped pack)' '
-	mv .git/objects/pack/$packbitmap.* alt.git/objects/pack/ &&
-	rm -f .git/objects/pack/multi-pack-index &&
-	test_when_finished "mv alt.git/objects/pack/$packbitmap.* .git/objects/pack/" &&
-	echo HEAD | git pack-objects --local --stdout --revs >3b.pack &&
-	git index-pack 3b.pack &&
-	list_packed_objects 3b.idx >3b.objects &&
-	! has_any packbitmap.objects 3b.objects
-'
-
-test_expect_success 'pack-objects to file can use bitmap' '
-	# make sure we still have 1 bitmap index from previous tests
-	ls .git/objects/pack/ | grep bitmap >output &&
-	test_line_count = 1 output &&
-	# verify equivalent packs are generated with/without using bitmap index
-	packasha1=$(git pack-objects --no-use-bitmap-index --all packa </dev/null) &&
-	packbsha1=$(git pack-objects --use-bitmap-index --all packb </dev/null) &&
-	list_packed_objects packa-$packasha1.idx >packa.objects &&
-	list_packed_objects packb-$packbsha1.idx >packb.objects &&
-	test_cmp packa.objects packb.objects
-'
-
-test_expect_success 'full repack, reusing previous bitmaps' '
-	git repack -ad &&
-	ls .git/objects/pack/ | grep bitmap >output &&
-	test_line_count = 1 output
-'
-
-test_expect_success 'fetch (full bitmap)' '
-	git --git-dir=clone.git fetch origin second:second &&
-	git rev-parse HEAD >expect &&
-	git --git-dir=clone.git rev-parse HEAD >actual &&
-	test_cmp expect actual
-'
-
-test_expect_success 'create objects for missing-HAVE tests' '
-	blob=$(echo "missing have" | git hash-object -w --stdin) &&
-	tree=$(printf "100644 blob $blob\tfile\n" | git mktree) &&
-	parent=$(echo parent | git commit-tree $tree) &&
-	commit=$(echo commit | git commit-tree $tree -p $parent) &&
-	cat >revs <<-EOF
-	HEAD
-	^HEAD^
-	^$commit
-	EOF
-'
-
-test_expect_success 'pack-objects respects --incremental' '
-	cat >revs2 <<-EOF &&
-	HEAD
-	$commit
-	EOF
-	git pack-objects --incremental --stdout --revs <revs2 >4.pack &&
-	git index-pack 4.pack &&
-	list_packed_objects 4.idx >4.objects &&
-	test_line_count = 4 4.objects &&
-	git rev-list --objects $commit >revlist &&
-	cut -d" " -f1 revlist |sort >objects &&
-	test_cmp 4.objects objects
-'
-
-test_expect_success 'pack with missing blob' '
-	rm $(objpath $blob) &&
-	git pack-objects --stdout --revs <revs >/dev/null
-'
+test_bitmap_cases "pack.writeBitmapLookupTable"
 
-test_expect_success 'pack with missing tree' '
-	rm $(objpath $tree) &&
-	git pack-objects --stdout --revs <revs >/dev/null
-'
-
-test_expect_success 'pack with missing parent' '
-	rm $(objpath $parent) &&
-	git pack-objects --stdout --revs <revs >/dev/null
-'
-
-test_expect_success JGIT,SHA1 'we can read jgit bitmaps' '
-	git clone --bare . compat-jgit.git &&
-	(
-		cd compat-jgit.git &&
-		rm -f objects/pack/*.bitmap &&
-		jgit gc &&
-		git rev-list --test-bitmap HEAD
-	)
-'
-
-test_expect_success JGIT,SHA1 'jgit can read our bitmaps' '
-	git clone --bare . compat-us.git &&
-	(
-		cd compat-us.git &&
-		git repack -adb &&
-		# jgit gc will barf if it does not like our bitmaps
-		jgit gc
-	)
-'
-
-test_expect_success 'splitting packs does not generate bogus bitmaps' '
-	test-tool genrandom foo $((1024 * 1024)) >rand &&
-	git add rand &&
-	git commit -m "commit with big file" &&
-	git -c pack.packSizeLimit=500k repack -adb &&
-	git init --bare no-bitmaps.git &&
-	git -C no-bitmaps.git fetch .. HEAD
-'
-
-test_expect_success 'set up reusable pack' '
-	rm -f .git/objects/pack/*.keep &&
-	git repack -adb &&
-	reusable_pack () {
-		git for-each-ref --format="%(objectname)" |
-		git pack-objects --delta-base-offset --revs --stdout "$@"
-	}
-'
-
-test_expect_success 'pack reuse respects --honor-pack-keep' '
-	test_when_finished "rm -f .git/objects/pack/*.keep" &&
-	for i in .git/objects/pack/*.pack
-	do
-		>${i%.pack}.keep || return 1
-	done &&
-	reusable_pack --honor-pack-keep >empty.pack &&
-	git index-pack empty.pack &&
-	git show-index <empty.idx >actual &&
-	test_must_be_empty actual
-'
-
-test_expect_success 'pack reuse respects --local' '
-	mv .git/objects/pack/* alt.git/objects/pack/ &&
-	test_when_finished "mv alt.git/objects/pack/* .git/objects/pack/" &&
-	reusable_pack --local >empty.pack &&
-	git index-pack empty.pack &&
-	git show-index <empty.idx >actual &&
-	test_must_be_empty actual
-'
-
-test_expect_success 'pack reuse respects --incremental' '
-	reusable_pack --incremental >empty.pack &&
-	git index-pack empty.pack &&
-	git show-index <empty.idx >actual &&
-	test_must_be_empty actual
-'
-
-test_expect_success 'truncated bitmap fails gracefully (ewah)' '
-	test_config pack.writebitmaphashcache false &&
-	git repack -ad &&
-	git rev-list --use-bitmap-index --count --all >expect &&
-	bitmap=$(ls .git/objects/pack/*.bitmap) &&
-	test_when_finished "rm -f $bitmap" &&
-	test_copy_bytes 256 <$bitmap >$bitmap.tmp &&
-	mv -f $bitmap.tmp $bitmap &&
-	git rev-list --use-bitmap-index --count --all >actual 2>stderr &&
-	test_cmp expect actual &&
-	test_i18ngrep corrupt.ewah.bitmap stderr
-'
-
-test_expect_success 'truncated bitmap fails gracefully (cache)' '
-	git repack -ad &&
-	git rev-list --use-bitmap-index --count --all >expect &&
-	bitmap=$(ls .git/objects/pack/*.bitmap) &&
-	test_when_finished "rm -f $bitmap" &&
-	test_copy_bytes 512 <$bitmap >$bitmap.tmp &&
-	mv -f $bitmap.tmp $bitmap &&
-	git rev-list --use-bitmap-index --count --all >actual 2>stderr &&
-	test_cmp expect actual &&
-	test_i18ngrep corrupted.bitmap.index stderr
-'
-
-# Create a state of history with these properties:
-#
-#  - refs that allow a client to fetch some new history, while sharing some old
-#    history with the server; we use branches delta-reuse-old and
-#    delta-reuse-new here
-#
-#  - the new history contains an object that is stored on the server as a delta
-#    against a base that is in the old history
-#
-#  - the base object is not immediately reachable from the tip of the old
-#    history; finding it would involve digging down through history we know the
-#    other side has
-#
-# This should result in a state where fetching from old->new would not
-# traditionally reuse the on-disk delta (because we'd have to dig to realize
-# that the client has it), but we will do so if bitmaps can tell us cheaply
-# that the other side has it.
-test_expect_success 'set up thin delta-reuse parent' '
-	# This first commit contains the buried base object.
-	test-tool genrandom delta 16384 >file &&
-	git add file &&
-	git commit -m "delta base" &&
-	base=$(git rev-parse --verify HEAD:file) &&
-
-	# These intermediate commits bury the base back in history.
-	# This becomes the "old" state.
-	for i in 1 2 3 4 5
-	do
-		echo $i >file &&
-		git commit -am "intermediate $i" || return 1
-	done &&
-	git branch delta-reuse-old &&
-
-	# And now our new history has a delta against the buried base. Note
-	# that this must be smaller than the original file, since pack-objects
-	# prefers to create deltas from smaller objects to larger.
-	test-tool genrandom delta 16300 >file &&
-	git commit -am "delta result" &&
-	delta=$(git rev-parse --verify HEAD:file) &&
-	git branch delta-reuse-new &&
-
-	# Repack with bitmaps and double check that we have the expected delta
-	# relationship.
-	git repack -adb &&
-	have_delta $delta $base
-'
-
-# Now we can sanity-check the non-bitmap behavior (that the server is not able
-# to reuse the delta). This isn't strictly something we care about, so this
-# test could be scrapped in the future. But it makes sure that the next test is
-# actually triggering the feature we want.
-#
-# Note that our tools for working with on-the-wire "thin" packs are limited. So
-# we actually perform the fetch, retain the resulting pack, and inspect the
-# result.
-test_expect_success 'fetch without bitmaps ignores delta against old base' '
-	test_config pack.usebitmaps false &&
-	test_when_finished "rm -rf client.git" &&
-	git init --bare client.git &&
-	(
-		cd client.git &&
-		git config transfer.unpackLimit 1 &&
-		git fetch .. delta-reuse-old:delta-reuse-old &&
-		git fetch .. delta-reuse-new:delta-reuse-new &&
-		have_delta $delta $ZERO_OID
-	)
-'
-
-# And do the same for the bitmap case, where we do expect to find the delta.
-test_expect_success 'fetch with bitmaps can reuse old base' '
-	test_config pack.usebitmaps true &&
-	test_when_finished "rm -rf client.git" &&
-	git init --bare client.git &&
-	(
-		cd client.git &&
-		git config transfer.unpackLimit 1 &&
-		git fetch .. delta-reuse-old:delta-reuse-old &&
-		git fetch .. delta-reuse-new:delta-reuse-new &&
-		have_delta $delta $base
-	)
-'
-
-test_expect_success 'pack.preferBitmapTips' '
-	git init repo &&
-	test_when_finished "rm -fr repo" &&
-	(
-		cd repo &&
-
-		# create enough commits that not all are receive bitmap
-		# coverage even if they are all at the tip of some reference.
-		test_commit_bulk --message="%s" 103 &&
-
-		git rev-list HEAD >commits.raw &&
-		sort <commits.raw >commits &&
-
-		git log --format="create refs/tags/%s %H" HEAD >refs &&
-		git update-ref --stdin <refs &&
-
-		git repack -adb &&
-		test-tool bitmap list-commits | sort >bitmaps &&
-
-		# remember which commits did not receive bitmaps
-		comm -13 bitmaps commits >before &&
-		test_file_not_empty before &&
-
-		# mark the commits which did not receive bitmaps as preferred,
-		# and generate the bitmap again
-		perl -pe "s{^}{create refs/tags/include/$. }" <before |
-			git update-ref --stdin &&
-		git -c pack.preferBitmapTips=refs/tags/include repack -adb &&
-
-		# finally, check that the commit(s) without bitmap coverage
-		# are not the same ones as before
-		test-tool bitmap list-commits | sort >bitmaps &&
-		comm -13 bitmaps commits >after &&
-
-		! test_cmp before after
-	)
-'
-
-test_expect_success 'complains about multiple pack bitmaps' '
-	rm -fr repo &&
-	git init repo &&
-	test_when_finished "rm -fr repo" &&
-	(
-		cd repo &&
-
-		test_commit base &&
-
-		git repack -adb &&
-		bitmap="$(ls .git/objects/pack/pack-*.bitmap)" &&
-		mv "$bitmap" "$bitmap.bak" &&
-
-		test_commit other &&
-		git repack -ab &&
-
-		mv "$bitmap.bak" "$bitmap" &&
-
-		find .git/objects/pack -type f -name "*.pack" >packs &&
-		find .git/objects/pack -type f -name "*.bitmap" >bitmaps &&
-		test_line_count = 2 packs &&
-		test_line_count = 2 bitmaps &&
-
-		git rev-list --use-bitmap-index HEAD 2>err &&
-		grep "ignoring extra bitmap file" err
-	)
+test_expect_success 'verify writing bitmap lookup table when enabled' '
+	GIT_TRACE2_EVENT="$(pwd)/trace2" \
+		git repack -ad &&
+	grep "\"label\":\"writing_lookup_table\"" trace2
 '
 
 test_done
diff --git a/t/t5311-pack-bitmaps-shallow.sh b/t/t5311-pack-bitmaps-shallow.sh
index 872a95df338..f74c6a2da47 100755
--- a/t/t5311-pack-bitmaps-shallow.sh
+++ b/t/t5311-pack-bitmaps-shallow.sh
@@ -17,23 +17,40 @@ test_description='check bitmap operation with shallow repositories'
 # the tree for A. But in a shallow one, we've grafted away
 # A, and fetching A to B requires that the other side send
 # us the tree for file=1.
-test_expect_success 'setup shallow repo' '
-	echo 1 >file &&
-	git add file &&
-	git commit -m orig &&
-	echo 2 >file &&
-	git commit -a -m update &&
-	git clone --no-local --bare --depth=1 . shallow.git &&
-	echo 1 >file &&
-	git commit -a -m repeat
-'
-
-test_expect_success 'turn on bitmaps in the parent' '
-	git repack -adb
-'
-
-test_expect_success 'shallow fetch from bitmapped repo' '
-	(cd shallow.git && git fetch)
-'
+test_shallow_bitmaps () {
+	writeLookupTable=false
+
+	for i in "$@"
+	do
+		case $i in
+		"pack.writeBitmapLookupTable") writeLookupTable=true;;
+		esac
+	done
+
+	test_expect_success 'setup shallow repo' '
+		rm -rf * .git &&
+		git init &&
+		git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
+		echo 1 >file &&
+		git add file &&
+		git commit -m orig &&
+		echo 2 >file &&
+		git commit -a -m update &&
+		git clone --no-local --bare --depth=1 . shallow.git &&
+		echo 1 >file &&
+		git commit -a -m repeat
+	'
+
+	test_expect_success 'turn on bitmaps in the parent' '
+		git repack -adb
+	'
+
+	test_expect_success 'shallow fetch from bitmapped repo' '
+		(cd shallow.git && git fetch)
+	'
+}
+
+test_shallow_bitmaps
+
 
 test_done
diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index 4fe57414c13..3b206adcee6 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -15,17 +15,24 @@ GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0
 sane_unset GIT_TEST_MIDX_WRITE_REV
 sane_unset GIT_TEST_MIDX_READ_RIDX
 
-midx_bitmap_core
-
 bitmap_reuse_tests() {
 	from=$1
 	to=$2
+	writeLookupTable=false
+
+	for i in $3-${$#}
+	do
+		case $i in
+		"pack.writeBitmapLookupTable") writeLookupTable=true;;
+		esac
+	done
 
 	test_expect_success "setup pack reuse tests ($from -> $to)" '
 		rm -fr repo &&
 		git init repo &&
 		(
 			cd repo &&
+			git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
 			test_commit_bulk 16 &&
 			git tag old-tip &&
 
@@ -43,6 +50,7 @@ bitmap_reuse_tests() {
 	test_expect_success "build bitmap from existing ($from -> $to)" '
 		(
 			cd repo &&
+			git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
 			test_commit_bulk --id=further 16 &&
 			git tag new-tip &&
 
@@ -59,6 +67,7 @@ bitmap_reuse_tests() {
 	test_expect_success "verify resulting bitmaps ($from -> $to)" '
 		(
 			cd repo &&
+			git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
 			git for-each-ref &&
 			git rev-list --test-bitmap refs/tags/old-tip &&
 			git rev-list --test-bitmap refs/tags/new-tip
@@ -66,244 +75,294 @@ bitmap_reuse_tests() {
 	'
 }
 
-bitmap_reuse_tests 'pack' 'MIDX'
-bitmap_reuse_tests 'MIDX' 'pack'
-bitmap_reuse_tests 'MIDX' 'MIDX'
+test_midx_bitmap_cases () {
+	writeLookupTable=false
+	writeBitmapLookupTable=
+
+	for i in "$@"
+	do
+		case $i in
+		"pack.writeBitmapLookupTable")
+			writeLookupTable=true
+			writeBitmapLookupTable="$i"
+			;;
+		esac
+	done
+
+	test_expect_success 'setup test_repository' '
+		rm -rf * .git &&
+		git init &&
+		git config pack.writeBitmapLookupTable '"$writeLookupTable"'
+	'
 
-test_expect_success 'missing object closure fails gracefully' '
-	rm -fr repo &&
-	git init repo &&
-	test_when_finished "rm -fr repo" &&
-	(
-		cd repo &&
+	midx_bitmap_core
 
-		test_commit loose &&
-		test_commit packed &&
+	bitmap_reuse_tests 'pack' 'MIDX' "$writeBitmapLookupTable"
+	bitmap_reuse_tests 'MIDX' 'pack' "$writeBitmapLookupTable"
+	bitmap_reuse_tests 'MIDX' 'MIDX' "$writeBitmapLookupTable"
 
-		# Do not pass "--revs"; we want a pack without the "loose"
-		# commit.
-		git pack-objects $objdir/pack/pack <<-EOF &&
-		$(git rev-parse packed)
-		EOF
+	test_expect_success 'missing object closure fails gracefully' '
+		rm -fr repo &&
+		git init repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+			git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
 
-		test_must_fail git multi-pack-index write --bitmap 2>err &&
-		grep "doesn.t have full closure" err &&
-		test_path_is_missing $midx
-	)
-'
+			test_commit loose &&
+			test_commit packed &&
 
-midx_bitmap_partial_tests
+			# Do not pass "--revs"; we want a pack without the "loose"
+			# commit.
+			git pack-objects $objdir/pack/pack <<-EOF &&
+			$(git rev-parse packed)
+			EOF
 
-test_expect_success 'removing a MIDX clears stale bitmaps' '
-	rm -fr repo &&
-	git init repo &&
-	test_when_finished "rm -fr repo" &&
-	(
-		cd repo &&
-		test_commit base &&
-		git repack &&
-		git multi-pack-index write --bitmap &&
+			test_must_fail git multi-pack-index write --bitmap 2>err &&
+			grep "doesn.t have full closure" err &&
+			test_path_is_missing $midx
+		)
+	'
 
-		# Write a MIDX and bitmap; remove the MIDX but leave the bitmap.
-		stale_bitmap=$midx-$(midx_checksum $objdir).bitmap &&
-		rm $midx &&
+	midx_bitmap_partial_tests
 
-		# Then write a new MIDX.
-		test_commit new &&
-		git repack &&
-		git multi-pack-index write --bitmap &&
+	test_expect_success 'removing a MIDX clears stale bitmaps' '
+		rm -fr repo &&
+		git init repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+			git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
+			test_commit base &&
+			git repack &&
+			git multi-pack-index write --bitmap &&
+
+			# Write a MIDX and bitmap; remove the MIDX but leave the bitmap.
+			stale_bitmap=$midx-$(midx_checksum $objdir).bitmap &&
+			rm $midx &&
+
+			# Then write a new MIDX.
+			test_commit new &&
+			git repack &&
+			git multi-pack-index write --bitmap &&
+
+			test_path_is_file $midx &&
+			test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
+			test_path_is_missing $stale_bitmap
+		)
+	'
 
-		test_path_is_file $midx &&
-		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
-		test_path_is_missing $stale_bitmap
-	)
-'
+	test_expect_success 'pack.preferBitmapTips' '
+		git init repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+			git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
 
-test_expect_success 'pack.preferBitmapTips' '
-	git init repo &&
-	test_when_finished "rm -fr repo" &&
-	(
-		cd repo &&
+			test_commit_bulk --message="%s" 103 &&
 
-		test_commit_bulk --message="%s" 103 &&
+			git log --format="%H" >commits.raw &&
+			sort <commits.raw >commits &&
 
-		git log --format="%H" >commits.raw &&
-		sort <commits.raw >commits &&
+			git log --format="create refs/tags/%s %H" HEAD >refs &&
+			git update-ref --stdin <refs &&
 
-		git log --format="create refs/tags/%s %H" HEAD >refs &&
-		git update-ref --stdin <refs &&
+			git multi-pack-index write --bitmap &&
+			test_path_is_file $midx &&
+			test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
 
-		git multi-pack-index write --bitmap &&
-		test_path_is_file $midx &&
-		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
+			test-tool bitmap list-commits | sort >bitmaps &&
+			comm -13 bitmaps commits >before &&
+			test_line_count = 1 before &&
 
-		test-tool bitmap list-commits | sort >bitmaps &&
-		comm -13 bitmaps commits >before &&
-		test_line_count = 1 before &&
+			perl -ne "printf(\"create refs/tags/include/%d \", $.); print" \
+				<before | git update-ref --stdin &&
 
-		perl -ne "printf(\"create refs/tags/include/%d \", $.); print" \
-			<before | git update-ref --stdin &&
+			rm -fr $midx-$(midx_checksum $objdir).bitmap &&
+			rm -fr $midx &&
 
-		rm -fr $midx-$(midx_checksum $objdir).bitmap &&
-		rm -fr $midx &&
+			git -c pack.preferBitmapTips=refs/tags/include \
+				multi-pack-index write --bitmap &&
+			test-tool bitmap list-commits | sort >bitmaps &&
+			comm -13 bitmaps commits >after &&
 
-		git -c pack.preferBitmapTips=refs/tags/include \
-			multi-pack-index write --bitmap &&
-		test-tool bitmap list-commits | sort >bitmaps &&
-		comm -13 bitmaps commits >after &&
+			! test_cmp before after
+		)
+	'
 
-		! test_cmp before after
-	)
-'
+	test_expect_success 'writing a bitmap with --refs-snapshot' '
+		git init repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+			git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
 
-test_expect_success 'writing a bitmap with --refs-snapshot' '
-	git init repo &&
-	test_when_finished "rm -fr repo" &&
-	(
-		cd repo &&
+			test_commit one &&
+			test_commit two &&
 
-		test_commit one &&
-		test_commit two &&
+			git rev-parse one >snapshot &&
 
-		git rev-parse one >snapshot &&
+			git repack -ad &&
 
-		git repack -ad &&
+			# First, write a MIDX which see both refs/tags/one and
+			# refs/tags/two (causing both of those commits to receive
+			# bitmaps).
+			git multi-pack-index write --bitmap &&
 
-		# First, write a MIDX which see both refs/tags/one and
-		# refs/tags/two (causing both of those commits to receive
-		# bitmaps).
-		git multi-pack-index write --bitmap &&
+			test_path_is_file $midx &&
+			test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
 
-		test_path_is_file $midx &&
-		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
+			test-tool bitmap list-commits | sort >bitmaps &&
+			grep "$(git rev-parse one)" bitmaps &&
+			grep "$(git rev-parse two)" bitmaps &&
 
-		test-tool bitmap list-commits | sort >bitmaps &&
-		grep "$(git rev-parse one)" bitmaps &&
-		grep "$(git rev-parse two)" bitmaps &&
+			rm -fr $midx-$(midx_checksum $objdir).bitmap &&
+			rm -fr $midx &&
 
-		rm -fr $midx-$(midx_checksum $objdir).bitmap &&
-		rm -fr $midx &&
+			# Then again, but with a refs snapshot which only sees
+			# refs/tags/one.
+			git multi-pack-index write --bitmap --refs-snapshot=snapshot &&
 
-		# Then again, but with a refs snapshot which only sees
-		# refs/tags/one.
-		git multi-pack-index write --bitmap --refs-snapshot=snapshot &&
+			test_path_is_file $midx &&
+			test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
 
-		test_path_is_file $midx &&
-		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
+			test-tool bitmap list-commits | sort >bitmaps &&
+			grep "$(git rev-parse one)" bitmaps &&
+			! grep "$(git rev-parse two)" bitmaps
+		)
+	'
 
-		test-tool bitmap list-commits | sort >bitmaps &&
-		grep "$(git rev-parse one)" bitmaps &&
-		! grep "$(git rev-parse two)" bitmaps
-	)
-'
+	test_expect_success 'write a bitmap with --refs-snapshot (preferred tips)' '
+		git init repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+			git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
 
-test_expect_success 'write a bitmap with --refs-snapshot (preferred tips)' '
-	git init repo &&
-	test_when_finished "rm -fr repo" &&
-	(
-		cd repo &&
+			test_commit_bulk --message="%s" 103 &&
 
-		test_commit_bulk --message="%s" 103 &&
+			git log --format="%H" >commits.raw &&
+			sort <commits.raw >commits &&
 
-		git log --format="%H" >commits.raw &&
-		sort <commits.raw >commits &&
+			git log --format="create refs/tags/%s %H" HEAD >refs &&
+			git update-ref --stdin <refs &&
 
-		git log --format="create refs/tags/%s %H" HEAD >refs &&
-		git update-ref --stdin <refs &&
+			git multi-pack-index write --bitmap &&
+			test_path_is_file $midx &&
+			test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
 
-		git multi-pack-index write --bitmap &&
-		test_path_is_file $midx &&
-		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
+			test-tool bitmap list-commits | sort >bitmaps &&
+			comm -13 bitmaps commits >before &&
+			test_line_count = 1 before &&
 
-		test-tool bitmap list-commits | sort >bitmaps &&
-		comm -13 bitmaps commits >before &&
-		test_line_count = 1 before &&
+			(
+				grep -vf before commits.raw &&
+				# mark missing commits as preferred
+				sed "s/^/+/" before
+			) >snapshot &&
 
+			rm -fr $midx-$(midx_checksum $objdir).bitmap &&
+			rm -fr $midx &&
+
+			git multi-pack-index write --bitmap --refs-snapshot=snapshot &&
+			test-tool bitmap list-commits | sort >bitmaps &&
+			comm -13 bitmaps commits >after &&
+
+			! test_cmp before after
+		)
+	'
+
+	test_expect_success 'hash-cache values are propagated from pack bitmaps' '
+		rm -fr repo &&
+		git init repo &&
+		test_when_finished "rm -fr repo" &&
 		(
-			grep -vf before commits.raw &&
-			# mark missing commits as preferred
-			sed "s/^/+/" before
-		) >snapshot &&
+			cd repo &&
+			git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
 
-		rm -fr $midx-$(midx_checksum $objdir).bitmap &&
-		rm -fr $midx &&
+			test_commit base &&
+			test_commit base2 &&
+			git repack -adb &&
 
-		git multi-pack-index write --bitmap --refs-snapshot=snapshot &&
-		test-tool bitmap list-commits | sort >bitmaps &&
-		comm -13 bitmaps commits >after &&
+			test-tool bitmap dump-hashes >pack.raw &&
+			test_file_not_empty pack.raw &&
+			sort pack.raw >pack.hashes &&
 
-		! test_cmp before after
-	)
-'
+			test_commit new &&
+			git repack &&
+			git multi-pack-index write --bitmap &&
 
-test_expect_success 'hash-cache values are propagated from pack bitmaps' '
-	rm -fr repo &&
-	git init repo &&
-	test_when_finished "rm -fr repo" &&
-	(
-		cd repo &&
+			test-tool bitmap dump-hashes >midx.raw &&
+			sort midx.raw >midx.hashes &&
 
-		test_commit base &&
-		test_commit base2 &&
-		git repack -adb &&
+			# ensure that every namehash in the pack bitmap can be found in
+			# the midx bitmap (i.e., that there are no oid-namehash pairs
+			# unique to the pack bitmap).
+			comm -23 pack.hashes midx.hashes >dropped.hashes &&
+			test_must_be_empty dropped.hashes
+		)
+	'
 
-		test-tool bitmap dump-hashes >pack.raw &&
-		test_file_not_empty pack.raw &&
-		sort pack.raw >pack.hashes &&
+	test_expect_success 'no .bitmap is written without any objects' '
+		rm -fr repo &&
+		git init repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+			git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
 
-		test_commit new &&
-		git repack &&
-		git multi-pack-index write --bitmap &&
+			empty="$(git pack-objects $objdir/pack/pack </dev/null)" &&
+			cat >packs <<-EOF &&
+			pack-$empty.idx
+			EOF
 
-		test-tool bitmap dump-hashes >midx.raw &&
-		sort midx.raw >midx.hashes &&
+			git multi-pack-index write --bitmap --stdin-packs \
+				<packs 2>err &&
 
-		# ensure that every namehash in the pack bitmap can be found in
-		# the midx bitmap (i.e., that there are no oid-namehash pairs
-		# unique to the pack bitmap).
-		comm -23 pack.hashes midx.hashes >dropped.hashes &&
-		test_must_be_empty dropped.hashes
-	)
-'
+			grep "bitmap without any objects" err &&
 
-test_expect_success 'no .bitmap is written without any objects' '
-	rm -fr repo &&
-	git init repo &&
-	test_when_finished "rm -fr repo" &&
-	(
-		cd repo &&
+			test_path_is_file $midx &&
+			test_path_is_missing $midx-$(midx_checksum $objdir).bitmap
+		)
+	'
+
+	test_expect_success 'graceful fallback when missing reverse index' '
+		rm -fr repo &&
+		git init repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+			git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
 
-		empty="$(git pack-objects $objdir/pack/pack </dev/null)" &&
-		cat >packs <<-EOF &&
-		pack-$empty.idx
-		EOF
+			test_commit base &&
 
-		git multi-pack-index write --bitmap --stdin-packs \
-			<packs 2>err &&
+			# write a pack and MIDX bitmap containing base
+			git repack -adb &&
+			git multi-pack-index write --bitmap &&
 
-		grep "bitmap without any objects" err &&
+			GIT_TEST_MIDX_READ_RIDX=0 \
+				git rev-list --use-bitmap-index HEAD 2>err &&
+			! grep "ignoring extra bitmap file" err
+		)
+	'
+}
 
-		test_path_is_file $midx &&
-		test_path_is_missing $midx-$(midx_checksum $objdir).bitmap
-	)
-'
+test_midx_bitmap_cases
+
+test_midx_bitmap_cases "pack.writeBitmapLookupTable"
 
-test_expect_success 'graceful fallback when missing reverse index' '
+test_expect_success 'multi-pack-index write writes lookup table if enabled' '
 	rm -fr repo &&
 	git init repo &&
 	test_when_finished "rm -fr repo" &&
 	(
 		cd repo &&
-
 		test_commit base &&
-
-		# write a pack and MIDX bitmap containing base
-		git repack -adb &&
-		git multi-pack-index write --bitmap &&
-
-		GIT_TEST_MIDX_READ_RIDX=0 \
-			git rev-list --use-bitmap-index HEAD 2>err &&
-		! grep "ignoring extra bitmap file" err
+		git config pack.writeBitmapLookupTable true &&
+		git repack -ad &&
+		GIT_TRACE2_EVENT="$(pwd)/trace" \
+			git multi-pack-index write --bitmap &&
+		grep "\"label\":\"writing_lookup_table\"" trace
 	)
 '
 
diff --git a/t/t5327-multi-pack-bitmaps-rev.sh b/t/t5327-multi-pack-bitmaps-rev.sh
index d30ba632c87..d01c61c0c7e 100755
--- a/t/t5327-multi-pack-bitmaps-rev.sh
+++ b/t/t5327-multi-pack-bitmaps-rev.sh
@@ -20,4 +20,13 @@ export GIT_TEST_MIDX_READ_RIDX
 midx_bitmap_core rev
 midx_bitmap_partial_tests rev
 
+test_expect_success 'reinitialize the repository with lookup table enabled' '
+    rm -fr * .git &&
+    git init &&
+    git config pack.writeBitmapLookupTable true
+'
+
+midx_bitmap_core rev
+midx_bitmap_partial_tests rev
+
 test_done
-- 
gitgitgadget

