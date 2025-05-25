Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E025E6FC5
	for <git@vger.kernel.org>; Sun, 25 May 2025 02:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748138771; cv=none; b=praU5BA6r+24l06exTMKFCyVFw8xDeg7f/QsHg9pcb86m+UZnpKSokTrAjIU9zmPlWocIhSCQSeUpw7kBzE+rJyjfbiCqS7olrf3ztng4SX60m9scdiugHdYKezTBKdlquUrkE8ErRk0IAurPKlhUgwnEljAcNG0je+LJPaKwio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748138771; c=relaxed/simple;
	bh=1nyrgTj0RJYo4xCSuw0Zzuxf0HLnO30pPm2gE1cb7rQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=unI0HOftIsaKuxAUr9DUrIfPb2Uwk388MyhFsbwuWkQK6PU07rMayB5qOmWwu3xThpW/JyjAClc15yZ+vg2U0ilX4JGV4ADxBmVNwwvfo3eirtRPIlQsNtOsyKTvhAF7t48VKXT5UmsbR40BN9hb9b3av6jTflrvuIIp40+LYRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PBoBBJV8; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBoBBJV8"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a365a6804eso651977f8f.3
        for <git@vger.kernel.org>; Sat, 24 May 2025 19:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748138767; x=1748743567; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4RTt5Rw94eQw7NMFQTxg/Ndmnz2XoHS0Zw4sEz1OjQc=;
        b=PBoBBJV87b3zl1HcPhbP1uFElWaPqpW7PSnKWQqbx4i9WS/wphGI4rNPXd13zrSDH/
         4uUzLsKbZArnshTFvc3ftsZ9dwEq34iF25TZJqUdBt4Cg13l8GLaA7bEqc4e/p+c6Afx
         OPHHCCbEMSIAu/o7zttxE5jJShuYQG39edGSNCeOCahmHUDPjX6UPlzPvIiu2bQsNLdD
         o9xeEIhpu7IXerE5aYqodyvR5qNYnn4hUUak70AIGWevrM2z+vugT3FOl3g5YakQ7CQm
         3vKbLWfNSs9cyxSY/kWRjRyIYb49A6DokShm2gzcz9x43319zSjcdb64lns2ibjvrqva
         NW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748138767; x=1748743567;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4RTt5Rw94eQw7NMFQTxg/Ndmnz2XoHS0Zw4sEz1OjQc=;
        b=a89bu84QkLFbE3isfq/Cep8XPwPZyVq3DS9HgUxybr1AHvQengqXA7tnzKp6SnoR7Z
         Gl6aOqQqtcgy3lC6Q28bE4fKlAq++6p8HLJjhAz/IGD9cCuvIsusn34QUhF9QE9ZDJCB
         Ei4MDfOvQKLB91NRlV0qejCxZwRygHcRpB5yGM/cSFuNVn/FmxQNYyoEIdFgbrF9XMIU
         Cjr/MiaGm+TdSyAXkmjq3Wp2LhTGcxFHkX2q+p7Nb2cCukPz6z/f13LRx5sjpLREtHXv
         AaNFNJYB1qI5Sg5+sb4XKG4GU+G1Ppga1yfMaUPH7JODCUqe8+RJnVM5GyR1uZuAq3f0
         bwPw==
X-Gm-Message-State: AOJu0Ywr6kFD9hPTXr/CQ1KEVmXK3jUxBTiRx7epGR3S73WK09Elffbh
	n6kuUV9fpFFbvpWb8dcGNYjDit4yS1zetrb8lEPmwACP1zYWRVAhlDEFaAcwdw==
X-Gm-Gg: ASbGncubgFkNtzyP8ZJBMOJHdTsy85ZUio8QOQxhYq8yEgKjWwO8hk3UUho8LwC/Icd
	njiecdJZHZeVzzsVbLtBAQbujQvIuRLeWeDweg7aI2l0IIk6QUoyxaq/dXaQ4tFC8VzUiUAvqSF
	KVEVdNChU6W5roELchm3J9k5Uo4uR9h+Qmk2QU/qMBUzjSvzO0cAXdVEb7bQmVkr9zqFCf4826z
	c78cAZpA3G5qMfa9zv1TzUmb9rDBBTbPW5VXSVPwo4MizL2YwCejjpeKm5jkncxATAxsPbI/nhM
	GaR9b1EgOwYuCuGfOhEaX31nPpHeNL+pDPNFhN4xbWCHP7eDBUs5
X-Google-Smtp-Source: AGHT+IEI1V/hhenIGEx4UhbFaZhnWDyrTbdIAN60eeXdXKYQdurwfhcPI2zDvxP70Jqz0bfRJw2OAg==
X-Received: by 2002:a05:6000:4313:b0:3a3:6cf9:9b65 with SMTP id ffacd0b85a97d-3a4cb44f709mr3658298f8f.20.1748138766426;
        Sat, 24 May 2025 19:06:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4d15523a9sm1727402f8f.72.2025.05.24.19.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 May 2025 19:06:05 -0700 (PDT)
Message-Id: <pull.1962.v3.git.git.1748138764.gitgitgadget@gmail.com>
In-Reply-To: <pull.1962.v2.git.git.1747732991.gitgitgadget@gmail.com>
References: <pull.1962.v2.git.git.1747732991.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 25 May 2025 02:06:02 +0000
Subject: [PATCH v3 0/2] pack-bitmap: fix memory leak if load_bitmap_entries_v1 failed
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
    Taylor Blau <me@ttaylorr.com>,
    Lidong Yan <502024330056@smail.nju.edu.cn>

In pack-bitmap.c:load_bitmap_entries_v1, the function read_bitmap_1
allocates a bitmap and reads index data into it. However, if any of the
validation checks following the allocation fail, the allocated bitmap is not
freed, resulting in a memory leak. To avoid this, the validation checks
should be performed before the bitmap is allocated.

Lidong Yan (1):
  pack-bitmap: add load corrupt bitmap test

Taylor Blau (1):
  pack-bitmap: fix memory leak if `load_bitmap_entries_v1` failed

 pack-bitmap.c           | 94 +++++++++++++++++++++++++++++++----------
 pack-bitmap.h           |  1 +
 t/helper/test-bitmap.c  |  8 ++++
 t/t5310-pack-bitmaps.sh | 27 ++++++++++++
 4 files changed, 107 insertions(+), 23 deletions(-)


base-commit: 845c48a16a7f7b2c44d8cb137b16a4a1f0140229
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1962%2Fbrandb97%2Ffix-pack-bitmap-leak-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1962/brandb97/fix-pack-bitmap-leak-v3
Pull-Request: https://github.com/git/git/pull/1962

Range-diff vs v2:

 1:  130c3dc5dcd < -:  ----------- pack-bitmap: fix memory leak if `load_bitmap_entries_v1` failed
 2:  b515c278a8f = 1:  cf87aad7c99 pack-bitmap: fix memory leak if `load_bitmap_entries_v1` failed
 3:  5be22d563af ! 2:  f5371d7daa9 pack-bitmap: add loading corrupt bitmap_index test
     @@ Metadata
      Author: Lidong Yan <502024330056@smail.nju.edu.cn>
      
       ## Commit message ##
     -    pack-bitmap: add loading corrupt bitmap_index test
     +    pack-bitmap: add load corrupt bitmap test
      
     -    This patch add "load corrupt bitmap" test case in t5310-pack-bitmaps.sh.
     +    This patch add test_bitmap_list_commits_offset() in patch-bitmap.c,
     +    a new test helper command `test-tool bitmap list-commits-offset`,
     +    and a `load corrupt bitmap` test case in t5310.
      
     -    This test case intentionally corrupt the "xor_offset" field of the first
     -    entry. To find position of first entry in *.bitmap, we need to skip 4
     -    ewah_bitmaps before entries. And I add a function `skip_ewah_bitmap()`
     -    to do this.
     +    The `load corrupt bitmap` test case intentionally corrupt the
     +    "xor_offset" field of the first entry. And the newly added helper
     +    can help to find position of "xor_offset" in bitmap file.
      
          Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
      
     - ## t/t5310-pack-bitmaps.sh ##
     -@@ t/t5310-pack-bitmaps.sh: has_any () {
     - 	grep -Ff "$1" "$2"
     + ## pack-bitmap.c ##
     +@@ pack-bitmap.c: struct stored_bitmap {
     + 	int flags;
     + };
     + 
     ++struct stored_bitmap_tag_pos {
     ++	struct stored_bitmap stored;
     ++	size_t map_pos;
     ++};
     ++
     + /*
     +  * The active bitmap index for a repository. By design, repositories only have
     +  * a single bitmap index available (the index for the biggest packfile in
     +@@ pack-bitmap.c: static int existing_bitmaps_hits_nr;
     + static int existing_bitmaps_misses_nr;
     + static int roots_with_bitmaps_nr;
     + static int roots_without_bitmaps_nr;
     ++static int tag_pos_on_bitmap;
     + 
     + static struct ewah_bitmap *lookup_stored_bitmap(struct stored_bitmap *st)
     + {
     +@@ pack-bitmap.c: static struct stored_bitmap *store_bitmap(struct bitmap_index *index,
     + 					  struct ewah_bitmap *root,
     + 					  const struct object_id *oid,
     + 					  struct stored_bitmap *xor_with,
     +-					  int flags)
     ++					  int flags, size_t map_pos)
     + {
     + 	struct stored_bitmap *stored;
     ++	struct stored_bitmap_tag_pos *tagged;
     + 	khiter_t hash_pos;
     + 	int ret;
     + 
     +-	stored = xmalloc(sizeof(struct stored_bitmap));
     ++	tagged = xmalloc(tag_pos_on_bitmap ? sizeof(struct stored_bitmap_tag_pos) :
     ++					     sizeof(struct stored_bitmap));
     ++	stored = &tagged->stored;
     ++	if (tag_pos_on_bitmap)
     ++		tagged->map_pos = map_pos;
     + 	stored->root = root;
     + 	stored->xor = xor_with;
     + 	stored->flags = flags;
     +@@ pack-bitmap.c: static int load_bitmap_entries_v1(struct bitmap_index *index)
     + 		struct stored_bitmap *xor_bitmap = NULL;
     + 		uint32_t commit_idx_pos;
     + 		struct object_id oid;
     ++		size_t entry_map_pos;
     + 
     + 		if (index->map_size - index->map_pos < 6)
     + 			return error(_("corrupt ewah bitmap: truncated header for entry %d"), i);
     + 
     ++		entry_map_pos = index->map_pos;
     + 		commit_idx_pos = read_be32(index->map, &index->map_pos);
     + 		xor_offset = read_u8(index->map, &index->map_pos);
     + 		flags = read_u8(index->map, &index->map_pos);
     +@@ pack-bitmap.c: static int load_bitmap_entries_v1(struct bitmap_index *index)
     + 		if (!bitmap)
     + 			return -1;
     + 
     +-		recent_bitmaps[i % MAX_XOR_OFFSET] = store_bitmap(
     +-			index, bitmap, &oid, xor_bitmap, flags);
     ++		recent_bitmaps[i % MAX_XOR_OFFSET] =
     ++			store_bitmap(index, bitmap, &oid, xor_bitmap, flags,
     ++				     entry_map_pos);
     + 	}
     + 
     + 	return 0;
     +@@ pack-bitmap.c: static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_
     + 	int xor_flags;
     + 	khiter_t hash_pos;
     + 	struct bitmap_lookup_table_xor_item *xor_item;
     ++	size_t entry_map_pos;
     + 
     + 	if (is_corrupt)
     + 		return NULL;
     +@@ pack-bitmap.c: static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_
     + 			goto corrupt;
     + 		}
     + 
     ++		entry_map_pos = bitmap_git->map_pos;
     + 		bitmap_git->map_pos += sizeof(uint32_t) + sizeof(uint8_t);
     + 		xor_flags = read_u8(bitmap_git->map, &bitmap_git->map_pos);
     + 		bitmap = read_bitmap_1(bitmap_git);
     +@@ pack-bitmap.c: static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_
     + 		if (!bitmap)
     + 			goto corrupt;
     + 
     +-		xor_bitmap = store_bitmap(bitmap_git, bitmap, &xor_item->oid, xor_bitmap, xor_flags);
     ++		xor_bitmap = store_bitmap(bitmap_git, bitmap, &xor_item->oid,
     ++					  xor_bitmap, xor_flags, entry_map_pos);
     + 		xor_items_nr--;
     + 	}
     + 
     +@@ pack-bitmap.c: static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_
     + 	 * Instead, we can skip ahead and immediately read the flags and
     + 	 * ewah bitmap.
     + 	 */
     ++	entry_map_pos = bitmap_git->map_pos;
     + 	bitmap_git->map_pos += sizeof(uint32_t) + sizeof(uint8_t);
     + 	flags = read_u8(bitmap_git->map, &bitmap_git->map_pos);
     + 	bitmap = read_bitmap_1(bitmap_git);
     +@@ pack-bitmap.c: static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_
     + 	if (!bitmap)
     + 		goto corrupt;
     + 
     +-	return store_bitmap(bitmap_git, bitmap, oid, xor_bitmap, flags);
     ++	return store_bitmap(bitmap_git, bitmap, oid, xor_bitmap, flags,
     ++			    entry_map_pos);
     + 
     + corrupt:
     + 	free(xor_items);
     +@@ pack-bitmap.c: int test_bitmap_commits(struct repository *r)
     + 	return 0;
       }
       
     -+skip_ewah_bitmap() {
     -+	local bitmap="$1" &&
     -+	local offset="$2" &&
     -+	local size= &&
     ++int test_bitmap_commits_offset(struct repository *r)
     ++{
     ++	struct object_id oid;
     ++	struct stored_bitmap_tag_pos *tagged;
     ++	struct bitmap_index *bitmap_git;
     ++	size_t commit_idx_pos_map_pos, xor_offset_map_pos, flag_map_pos,
     ++		ewah_bitmap_map_pos;
     ++
     ++	tag_pos_on_bitmap = 1;
     ++	bitmap_git = prepare_bitmap_git(r);
     ++	if (!bitmap_git)
     ++		die(_("failed to load bitmap indexes"));
      +
     -+	offset=$(($offset + 4)) &&
     -+	size=0x$(od -An -v -t x1 -j $offset -N 4 $bitmap | tr -d ' \n') &&
     -+	size=$(($size * 8)) &&
     -+	offset=$(($offset + 4 + $size + 4)) &&
     -+	echo $offset
     ++	/*
     ++	 * As this function is only used to print bitmap selected
     ++	 * commits, we don't have to read the commit table.
     ++	 */
     ++	if (bitmap_git->table_lookup) {
     ++		if (load_bitmap_entries_v1(bitmap_git) < 0)
     ++			die(_("failed to load bitmap indexes"));
     ++	}
     ++
     ++	kh_foreach (bitmap_git->bitmaps, oid, tagged, {
     ++		commit_idx_pos_map_pos = tagged->map_pos;
     ++		xor_offset_map_pos = tagged->map_pos + sizeof(uint32_t);
     ++		flag_map_pos = xor_offset_map_pos + sizeof(uint8_t);
     ++		ewah_bitmap_map_pos = flag_map_pos + sizeof(uint8_t);
     ++
     ++		printf_ln("%s %"PRIuMAX" %"PRIuMAX" %"PRIuMAX" %"PRIuMAX,
     ++			  oid_to_hex(&oid),
     ++			  (uintmax_t)commit_idx_pos_map_pos,
     ++			  (uintmax_t)xor_offset_map_pos,
     ++			  (uintmax_t)flag_map_pos,
     ++			  (uintmax_t)ewah_bitmap_map_pos);
     ++	})
     ++		;
     ++
     ++	free_bitmap_index(bitmap_git);
     ++
     ++	return 0;
     ++}
     ++
     + int test_bitmap_hashes(struct repository *r)
     + {
     + 	struct bitmap_index *bitmap_git = prepare_bitmap_git(r);
     +
     + ## pack-bitmap.h ##
     +@@ pack-bitmap.h: void traverse_bitmap_commit_list(struct bitmap_index *,
     + 				 show_reachable_fn show_reachable);
     + void test_bitmap_walk(struct rev_info *revs);
     + int test_bitmap_commits(struct repository *r);
     ++int test_bitmap_commits_offset(struct repository *r);
     + int test_bitmap_hashes(struct repository *r);
     + int test_bitmap_pseudo_merges(struct repository *r);
     + int test_bitmap_pseudo_merge_commits(struct repository *r, uint32_t n);
     +
     + ## t/helper/test-bitmap.c ##
     +@@ t/helper/test-bitmap.c: static int bitmap_list_commits(void)
     + 	return test_bitmap_commits(the_repository);
     + }
     + 
     ++static int bitmap_list_commits_offset(void)
     ++{
     ++	return test_bitmap_commits_offset(the_repository);
      +}
      +
     - # Since name-hash values are stored in the .bitmap files, add a test
     - # that checks that the name-hash calculations are stable across versions.
     - # Not exhaustive, but these hashing algorithms would be hard to change
     + static int bitmap_dump_hashes(void)
     + {
     + 	return test_bitmap_hashes(the_repository);
     +@@ t/helper/test-bitmap.c: int cmd__bitmap(int argc, const char **argv)
     + 
     + 	if (argc == 2 && !strcmp(argv[1], "list-commits"))
     + 		return bitmap_list_commits();
     ++	if (argc == 2 && !strcmp(argv[1], "list-commits-offset"))
     ++		return bitmap_list_commits_offset();
     + 	if (argc == 2 && !strcmp(argv[1], "dump-hashes"))
     + 		return bitmap_dump_hashes();
     + 	if (argc == 2 && !strcmp(argv[1], "dump-pseudo-merges"))
     +@@ t/helper/test-bitmap.c: int cmd__bitmap(int argc, const char **argv)
     + 		return bitmap_dump_pseudo_merge_objects(atoi(argv[2]));
     + 
     + 	usage("\ttest-tool bitmap list-commits\n"
     ++	      "\ttest-tool bitmap list-commits-offset\n"
     + 	      "\ttest-tool bitmap dump-hashes\n"
     + 	      "\ttest-tool bitmap dump-pseudo-merges\n"
     + 	      "\ttest-tool bitmap dump-pseudo-merge-commits <n>\n"
     +
     + ## t/t5310-pack-bitmaps.sh ##
      @@ t/t5310-pack-bitmaps.sh: test_bitmap_cases () {
       			grep "ignoring extra bitmap" trace2.txt
       		)
       	'
      +
     -+	# A `.bitmap` file has the following structure:
     -+	# | Header | Commits | Trees | Blobs | Tags | Entries... |
     -+	#
     -+	# - The header is 32 bytes long when using SHA-1.
     -+	# - Commits, Trees, Blobs, and Tags are all stored as EWAH bitmaps.
     -+	#
     -+	# This test intentionally corrupts the `xor_offset` field of the first entry
     -+	# to verify robustness against malformed bitmap data.
      +	test_expect_success 'load corrupt bitmap' '
      +		rm -fr repo &&
      +		git init repo &&
     @@ t/t5310-pack-bitmaps.sh: test_bitmap_cases () {
      +
      +			git repack -adb &&
      +			bitmap="$(ls .git/objects/pack/pack-*.bitmap)" &&
     -+			chmod +w "$bitmap" &&
     -+
     -+			hdr_sz=$((12 + $(test_oid rawsz))) &&
     -+			offset=$(skip_ewah_bitmap $bitmap $hdr_sz) &&
     -+			offset=$(skip_ewah_bitmap $bitmap $offset) &&
     -+			offset=$(skip_ewah_bitmap $bitmap $offset) &&
     -+			offset=$(skip_ewah_bitmap $bitmap $offset) &&
     -+			offset=$((offset + 4)) &&
     ++			chmod +w $bitmap &&
      +
     ++			read oid commit_off xor_off flag_off ewah_off <<-EOF &&
     ++				$(test-tool bitmap list-commits-offset | head -n 1)
     ++			EOF
      +			printf '\161' |
     -+				dd of=$bitmap count=1 bs=1 conv=notrunc seek=$offset &&
     ++				dd of=$bitmap count=1 bs=1 conv=notrunc seek=$xor_off &&
     ++
      +
      +			git rev-list --count HEAD > expect &&
      +			git rev-list --use-bitmap-index --count HEAD > actual &&

-- 
gitgitgadget
