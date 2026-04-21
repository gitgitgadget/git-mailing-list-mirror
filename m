Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AFF3242BE
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 20:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776801717; cv=none; b=Aiwow/ZMcQrMb2hr8eBHuhgNXXL5DRX3NbIGve1GzhZpt8wD4B2y2JtBUOe7mpVb4tZV8yG7sxbLm9UQGffhUfPKjyKku6K9xh4bFmMZTJWDUV9rXiJ5prFpCqFaQHRgHqrilsuviynHDf3kKSYWMLWARqAeuVHGnKNiTq9Xjgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776801717; c=relaxed/simple;
	bh=rO4hGpfyGpH5cvYh9PZwA6MCHHN/2QxXwOxXqTnXolA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+cFEdEcS70S3JUbhdT7nY9J7SJK0AngBmJGFO0zOQXOyNeeEhwx1sy6SFeRDrR7nHNsxwoWDIzDElUh4mFE52zW3Ap+Pg/MlizUBPx+OB3AkN23eBmqy3BLbITTkpN1+pbe9rQkrCClz/AExP5Pj585APd9x32rofUm0qaQ3aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=EjxsrA9S; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="EjxsrA9S"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-41c4d660b19so1235932fac.1
        for <git@vger.kernel.org>; Tue, 21 Apr 2026 13:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1776801714; x=1777406514; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ubNlds0jZ74tinBRNX/9BkZQGeDO86wwWluc4oyqF9E=;
        b=EjxsrA9SmUx2o6KXBrnkeFMk5VUxui+leGGQ+1Na86sA+0f6K3zQS1EoJ+fk7waWB0
         B9WhX/R2geGhbcI7hhKUGrcF59C72PE6dqMGk6/nqhsF0nvv3IheETM32czo9LrK8H70
         K7c3JeWf2VGohJn3In+t2j6sk3apCgg/FTl4/yK7WPHikoE8zFfe/nX59IhhugscqgmI
         CxxXeW5qkNoKx0dlKGe6XIILTOJoJzLOAxgyfZrIbWGUxV+2b+j3fL9by3I/IlP+VPC2
         OD8WZRM6kuk3t7TLQgtcAbwo9TQQ+K29q3AVmWEszhJIqFUIQwFHMBSM6YOqsHlT/AbN
         BdEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776801714; x=1777406514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ubNlds0jZ74tinBRNX/9BkZQGeDO86wwWluc4oyqF9E=;
        b=el9ZGvRPAFbUBbocosSPjkIN09CQ0+aRXtMlrGungMygpXYIIs3EEgTLgYeiW7mgpm
         r6FIIKjIqrfC8xDLbTLvekFtiICtEL+N5/f+QGidpko2Gp2YzEF+ub+b+SJ90ZdOMz4o
         /plggwdfLbJCcmI+hiPO2pr7CI9l0ubQYFVL3KvqtBK3duapVmZNy9jP4WpiXEYsTysr
         mNTFWnz/Ip5F6gvKOHTKUWRtszMw6qA59kUPM7sUdcpIqJ+FLMqB/dk65TawY/Mil8Wh
         YfDrIaIwlfjOGhmo3nQwK8EoFAl3x56QQzlBIfSQTZFtRzSbdJVDKqPZ37NBeIYi8cpN
         MyXQ==
X-Gm-Message-State: AOJu0YxGTy55Td+HJaaiJU4o/xO5U65laLFMmu62uTlgQ2wagrgaL4hZ
	0yv2a9k4LGfQxdmNthdjOvOMVoBTQwWeBAMtb9dfXzMZJEk6ALCfEUVtBDSViPaksFJX3tWhMQj
	m091kUNM=
X-Gm-Gg: AeBDietz+lA6v2kuLMcFu/G58h+q7YggG5myzLKk+SlQlXTNZK12NA5jZqtmuJYDWI2
	Wckldb3GoXgoUBZ7tUpNSCvrjxLtBChGNV8oqIr4gJvh63i2OsbQ6vo5C5/7bcNdtKCKazoryT1
	vWLQHsyraQINk865HlSZum8oquNBMCeMlCYmP+BUZIED4uCehrHmOuGARy3tV8acnTnYEzLc7Ty
	jWvZzHJ8A1eMZy9wdgPbxADNNEs17xRWK6bTd30sYZBS5xUmI38Ev32ujFSTaSh748yNTOPYbyB
	jVCWKWRv+Cj7l9Jfvrdc/ieMEwjrzL+hxw4pSyG2RErVc0kpVpxDgU+mEfVSSOAWyx6DlM6BmV2
	NjnAFCB/f9Gbrx7AsEk8LPfE9JrrnZKOysOqywJwGYMFNZ4uUSGMWNjs9Bt36uh5bjcwvj6eFA9
	xFEAMviFZ59HvOSTo7B8j+3LlOXJXOm+junR+aVdk5bfWRnD7cQBGzQ9nOKihyNL6QL/TAtdJV7
	GX4896CaJW/KCah90OOy7Q1ioMfyLBqlqPLQ1ityesiA5o2rkLZBu7tiWyeoSh+M5/6odT32X+o
	F8xeNkyyf98k3+ctG6s3YoijzC4=
X-Received: by 2002:a05:6871:e40f:b0:428:6d0d:e61b with SMTP id 586e51a60fabf-42abf2543admr12367709fac.8.1776801714262;
        Tue, 21 Apr 2026 13:01:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42fbe8a0bcbsm427813fac.2.2026.04.21.13.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 13:01:53 -0700 (PDT)
Date: Tue, 21 Apr 2026 16:01:52 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 0/9] pack-bitmap: fix various pseudo-merge bugs
Message-ID: <cover.1776801694.git.me@ttaylorr.com>
References: <cover.1776124588.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1776124588.git.me@ttaylorr.com>

[Note to the maintainer: this series has been rebased onto the current
tip of master, which is 94f057755b7 (Git 2.54, 2026-04-19) at the time
of writing.]

This is a small reroll of my series to fix several bugs in the
pseudo-merge bitmap implementation. The main changes since last time
are:

 - Fixed a use-after-realloc bug in the test helper introduced in the
   first commit.

 - Swapped the order of initializing and cleaning up repositories in the
   new test scripts.

 - Updated bitmapPseudoMerge.<name>.sampleRate's documentation to
   describe the range as (0,1], and added a new commit fixing a broken
   example in gitpacking(7).

As usual, a range-diff is included below for convenience. The original
cover letter is as follows:

========================================================================

This series fixes several bugs in the pseudo-merge bitmap implementation
that caused the pseudo-merge application path to be effectively broken
during fill-in traversal.

Peff noticed that this code path was never triggered by the existing
test suite, and investigating that observation uncovered a handful of
bugs, some compounding.

The first two patches introduce test infrastructure: a 'bitmap write'
test helper that gives tests precise control over which commits receive
individual bitmaps, and a set of "test_expect_failure" tests
demonstrating each bug.

The next four patches fix the bugs in the per-commit pseudo-merge
lookup:

  - The pseudo-merge commit lookup table was sorted by OID rather than
    by bit position, causing the reader's binary search to fail.

  - The binary search in pseudo_merge_at() had its lo/hi updates
    swapped.

  - The extended pseudo-merge lookup path had three compounding bugs: a
    wrong entry-size calculation in the writer, a misinterpretation of
    extended table entries in the reader, and a silently-swallowed error
    check.

The final two patches fix issues in pseudo-merge group selection:

  - find_pseudo_merge_group_for_ref() did not parse commits before
    inspecting their dates, so all candidates had date == 0 and were
    unconditionally placed in the "stable" bucket.

  - The config validation for bitmapPseudoMerge.*.sampleRate accepted 0,
    which leads to a division by zero once the date classification is
    fixed and the unstable code path is exercised.

There is also a small fix for a regex leak when the pattern key is
overridden in config.

Thanks in advance for your review!

Taylor Blau (9):
  t/helper: add 'test-tool bitmap write' subcommand
  t5333: demonstrate various pseudo-merge bugs
  pack-bitmap-write: sort pseudo-merge commit lookup table in pack order
  pack-bitmap: fix inverted binary search in `pseudo_merge_at()`
  pack-bitmap: fix pseudo-merge lookup for shared commits
  pack-bitmap: parse commits in `find_pseudo_merge_group_for_ref()`
  pack-bitmap: reject pseudo-merge "sampleRate" of 0
  Documentation: fix broken `sampleRate` in gitpacking(7)
  pack-bitmap: prevent pattern leak on pseudo-merge re-assignment

 Documentation/config/bitmap-pseudo-merge.adoc |   4 +-
 Documentation/gitpacking.adoc                 |   4 +-
 pack-bitmap-write.c                           |  23 +-
 pseudo-merge.c                                |  19 +-
 t/helper/test-bitmap.c                        | 113 ++++++++-
 t/t5310-pack-bitmaps.sh                       |  24 ++
 t/t5333-pseudo-merge-bitmaps.sh               | 231 ++++++++++++++++++
 7 files changed, 404 insertions(+), 14 deletions(-)

Range-diff against v1:
 1:  d5ef6b959fd !  1:  c0df35f8ebd t/helper: add 'test-tool bitmap write' subcommand
    @@ t/helper/test-bitmap.c: static int bitmap_dump_pseudo_merge_objects(uint32_t n)
      	return test_bitmap_pseudo_merge_objects(the_repository, n);
      }
      
    -+struct bitmap_writer_data {
    -+	struct packing_data packed;
    -+	struct pack_idx_entry **index;
    -+	uint32_t nr;
    -+};
    -+
     +static int add_packed_object(const struct object_id *oid,
     +			     struct packed_git *pack,
     +			     uint32_t pos,
     +			     void *_data)
     +{
    -+	struct bitmap_writer_data *data = _data;
    ++	struct packing_data *packed = _data;
     +	struct object_entry *entry;
     +	struct object_info oi = OBJECT_INFO_INIT;
     +	enum object_type type;
     +
     +	oi.typep = &type;
     +
    -+	entry = packlist_alloc(&data->packed, oid);
    ++	entry = packlist_alloc(packed, oid);
     +	entry->idx.offset = nth_packed_object_offset(pack, pos);
     +	if (packed_object_info(pack, entry->idx.offset, &oi) < 0)
     +		die("could not get type of object %s",
     +		    oid_to_hex(oid));
     +	oe_set_type(entry, type);
    -+	oe_set_in_pack(&data->packed, entry, pack);
    -+	data->index[data->nr++] = &entry->idx;
    ++	oe_set_in_pack(packed, entry, pack);
     +
     +	return 0;
     +}
    @@ t/helper/test-bitmap.c: static int bitmap_dump_pseudo_merge_objects(uint32_t n)
     +static int bitmap_write(const char *basename)
     +{
     +	struct packed_git *p = NULL;
    -+	struct bitmap_writer_data data = { 0 };
    ++	struct packing_data packed = { 0 };
     +	struct bitmap_writer writer;
    ++	struct pack_idx_entry **index;
     +	struct strbuf buf = STRBUF_INIT;
    ++	uint32_t i;
     +
     +	prepare_repo_settings(the_repository);
     +	repo_for_each_pack(the_repository, p) {
    @@ t/helper/test-bitmap.c: static int bitmap_dump_pseudo_merge_objects(uint32_t n)
     +	if (open_pack_index(p))
     +		die("cannot open pack index for '%s'", p->pack_name);
     +
    -+	prepare_packing_data(the_repository, &data.packed);
    -+	ALLOC_ARRAY(data.index, p->num_objects);
    ++	prepare_packing_data(the_repository, &packed);
     +
    -+	for_each_object_in_pack(p, add_packed_object, &data,
    ++	for_each_object_in_pack(p, add_packed_object, &packed,
     +				ODB_FOR_EACH_OBJECT_PACK_ORDER);
     +
    -+	bitmap_writer_init(&writer, the_repository, &data.packed, NULL);
    -+	bitmap_writer_build_type_index(&writer, data.index);
    ++	/*
    ++	 * Build the index array now that data.packed.objects[] is
    ++	 * fully allocated (packlist_alloc() may have reallocated it
    ++	 * during the loop above).
    ++	 */
    ++	ALLOC_ARRAY(index, p->num_objects);
    ++	for (i = 0; i < p->num_objects; i++)
    ++		index[i] = &packed.objects[i].idx;
    ++
    ++	bitmap_writer_init(&writer, the_repository, &packed, NULL);
    ++	bitmap_writer_build_type_index(&writer, index);
     +
     +	while (strbuf_getline_lf(&buf, stdin) != EOF) {
     +		struct object_id oid;
    @@ t/helper/test-bitmap.c: static int bitmap_dump_pseudo_merge_objects(uint32_t n)
     +		if (!c || repo_parse_commit(the_repository, c))
     +			die("could not parse commit %s", buf.buf);
     +
    -+		bitmap_writer_push_commit(&writer, c, false);
    ++		bitmap_writer_push_commit(&writer, c, 0);
     +	}
     +
     +	select_pseudo_merges(&writer);
    @@ t/helper/test-bitmap.c: static int bitmap_dump_pseudo_merge_objects(uint32_t n)
     +
     +	bitmap_writer_set_checksum(&writer, p->hash);
     +
    -+	QSORT(data.index, p->num_objects, idx_oid_cmp);
    ++	QSORT(index, p->num_objects, idx_oid_cmp);
     +
     +	strbuf_reset(&buf);
     +	strbuf_addstr(&buf, p->pack_name);
     +	strbuf_strip_suffix(&buf, ".pack");
     +	strbuf_addstr(&buf, ".bitmap");
    -+	bitmap_writer_finish(&writer, data.index, buf.buf, 0);
    ++	bitmap_writer_finish(&writer, index, buf.buf, 0);
     +
     +	bitmap_writer_free(&writer);
     +	strbuf_release(&buf);
    -+	free(data.index);
    -+	clear_packing_data(&data.packed);
    ++	free(index);
    ++	clear_packing_data(&packed);
     +
     +	return 0;
     +}
    @@ t/t5310-pack-bitmaps.sh: test_expect_success 'truncated bitmap fails gracefully
      	test_grep corrupted.bitmap.index stderr
      '
      
    -+test_expect_success 'test-tool bitmap write' '
    -+	git init bitmap-write-helper &&
    ++test_expect_success 'test-tool bitmap write determines bitmap selection' '
     +	test_when_finished "rm -fr bitmap-write-helper" &&
    ++	git init bitmap-write-helper &&
     +	(
     +		cd bitmap-write-helper &&
     +
    @@ t/t5310-pack-bitmaps.sh: test_expect_success 'truncated bitmap fails gracefully
     +
     +		pack="$(ls .git/objects/pack/pack-*.pack)" &&
     +
    -+		git rev-parse HEAD >commits &&
    -+		test-tool bitmap write "$(basename $pack)" <commits &&
    ++		git rev-parse HEAD >in &&
    ++		test-tool bitmap write "$(basename $pack)" <in &&
     +
    -+		test-tool bitmap list-commits | sort >actual &&
    -+		sort commits >expect &&
    -+		test_cmp expect actual &&
    ++		test-tool bitmap list-commits >bitmaps.raw &&
    ++		sort bitmaps.raw >bitmaps &&
    ++		test_cmp in bitmaps &&
     +
     +		git rev-list --count --objects --use-bitmap-index HEAD >actual &&
     +		git rev-list --count --objects HEAD >expect &&
 2:  f4899b668e2 !  2:  11de3343726 t5333: demonstrate various pseudo-merge bugs
    @@ t/t5333-pseudo-merge-bitmaps.sh: test_expect_success 'use pseudo-merge in bounda
      '
      
     +test_expect_failure 'apply pseudo-merges during fill-in traversal' '
    -+	git init pseudo-merge-fill-in-traversal &&
     +	test_when_finished "rm -fr pseudo-merge-fill-in-traversal" &&
    ++	git init pseudo-merge-fill-in-traversal &&
     +	(
     +		cd pseudo-merge-fill-in-traversal &&
     +
    @@ t/t5333-pseudo-merge-bitmaps.sh: test_expect_success 'use pseudo-merge in bounda
     +'
     +
     +test_expect_failure 'apply pseudo-merges from multiple groups during fill-in' '
    -+	git init pseudo-merge-fill-in-multi &&
     +	test_when_finished "rm -fr pseudo-merge-fill-in-multi" &&
    ++	git init pseudo-merge-fill-in-multi &&
     +	(
     +		cd pseudo-merge-fill-in-multi &&
     +
    @@ t/t5333-pseudo-merge-bitmaps.sh: test_expect_success 'use pseudo-merge in bounda
     +'
     +
     +test_expect_failure 'pseudo-merge commits are correctly classified by date' '
    -+	git init pseudo-merge-date-classification &&
     +	test_when_finished "rm -fr pseudo-merge-date-classification" &&
    ++	git init pseudo-merge-date-classification &&
     +	(
     +		cd pseudo-merge-date-classification &&
     +
    @@ t/t5333-pseudo-merge-bitmaps.sh: test_expect_success 'use pseudo-merge in bounda
     +'
     +
     +test_expect_success 'sampleRate=0 does not cause division by zero' '
    -+	git init pseudo-merge-sample-rate-zero &&
     +	test_when_finished "rm -fr pseudo-merge-sample-rate-zero" &&
    ++	git init pseudo-merge-sample-rate-zero &&
     +	(
     +		cd pseudo-merge-sample-rate-zero &&
     +
 3:  1f5835e8c62 !  3:  8d908ab415e pack-bitmap-write: sort pseudo-merge commit lookup table in pack order
    @@ t/t5333-pseudo-merge-bitmaps.sh: test_expect_success 'use pseudo-merge in bounda
      
     -test_expect_failure 'apply pseudo-merges during fill-in traversal' '
     +test_expect_success 'apply pseudo-merges during fill-in traversal' '
    - 	git init pseudo-merge-fill-in-traversal &&
      	test_when_finished "rm -fr pseudo-merge-fill-in-traversal" &&
    + 	git init pseudo-merge-fill-in-traversal &&
      	(
 4:  af9f651269d !  4:  07f70a07c20 pack-bitmap: fix inverted binary search in `pseudo_merge_at()`
    @@ t/t5333-pseudo-merge-bitmaps.sh: test_expect_success 'apply pseudo-merges during
      
     -test_expect_failure 'apply pseudo-merges from multiple groups during fill-in' '
     +test_expect_success 'apply pseudo-merges from multiple groups during fill-in' '
    - 	git init pseudo-merge-fill-in-multi &&
      	test_when_finished "rm -fr pseudo-merge-fill-in-multi" &&
    + 	git init pseudo-merge-fill-in-multi &&
    ++	git init pseudo-merge-fill-in-multi &&
      	(
    + 		cd pseudo-merge-fill-in-multi &&
    + 
 5:  01f1d6f08c6 =  5:  3ed0b39843f pack-bitmap: fix pseudo-merge lookup for shared commits
 6:  6d74c0a177a !  6:  95f847211f3 pack-bitmap: parse commits in `find_pseudo_merge_group_for_ref()`
    @@ t/t5333-pseudo-merge-bitmaps.sh: test_expect_success 'apply pseudo-merges with o
      
     -test_expect_failure 'pseudo-merge commits are correctly classified by date' '
     +test_expect_success 'pseudo-merge commits are correctly classified by date' '
    - 	git init pseudo-merge-date-classification &&
      	test_when_finished "rm -fr pseudo-merge-date-classification" &&
    + 	git init pseudo-merge-date-classification &&
      	(
      		cd pseudo-merge-date-classification &&
      
    @@ t/t5333-pseudo-merge-bitmaps.sh: test_expect_failure 'pseudo-merge commits are c
      
     -test_expect_success 'sampleRate=0 does not cause division by zero' '
     +test_expect_failure 'sampleRate=0 does not cause division by zero' '
    - 	git init pseudo-merge-sample-rate-zero &&
      	test_when_finished "rm -fr pseudo-merge-sample-rate-zero" &&
    + 	git init pseudo-merge-sample-rate-zero &&
      	(
 7:  1b0f7295c21 !  7:  f8a01cfb893 pack-bitmap: reject pseudo-merge "sampleRate" of 0
    @@ Commit message
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
    + ## Documentation/config/bitmap-pseudo-merge.adoc ##
    +@@ Documentation/config/bitmap-pseudo-merge.adoc: will be updated more often than a reference pointing at an old commit.
    + bitmapPseudoMerge.<name>.sampleRate::
    + 	Determines the proportion of non-bitmapped commits (among
    + 	reference tips) which are selected for inclusion in an
    +-	unstable pseudo-merge bitmap. Must be between `0` and `1`
    +-	(inclusive). The default is `1`.
    ++	unstable pseudo-merge bitmap. Must be greater than `0` and
    ++	less than or equal to `1`. The default is `1`.
    + 
    + bitmapPseudoMerge.<name>.threshold::
    + 	Determines the minimum age of non-bitmapped commits (among
    +
      ## pseudo-merge.c ##
     @@ pseudo-merge.c: static int pseudo_merge_config(const char *var, const char *value,
      		}
    @@ t/t5333-pseudo-merge-bitmaps.sh: test_expect_success 'pseudo-merge commits are c
      
     -test_expect_failure 'sampleRate=0 does not cause division by zero' '
     +test_expect_success 'sampleRate=0 does not cause division by zero' '
    - 	git init pseudo-merge-sample-rate-zero &&
      	test_when_finished "rm -fr pseudo-merge-sample-rate-zero" &&
    + 	git init pseudo-merge-sample-rate-zero &&
      	(
 -:  ----------- >  8:  c37156502c0 Documentation: fix broken `sampleRate` in gitpacking(7)
 8:  8f4e0170952 =  9:  b905fd5d0ae pack-bitmap: prevent pattern leak on pseudo-merge re-assignment

base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
-- 
2.54.0.9.gb905fd5d0ae
