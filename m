Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DC845027
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 20:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726692389; cv=none; b=OuobimwfzmFQpxjTy+tvsBduKaP+hT7UtowrZ+u720wZsKv+HH0rFrXa9+kFlECTS61YEGdviJ6hpD5LnKvQhudc2aLirzeOUvINrHa4Kkjy6lAneQPcww0XdDDI+28IDz4ZhMvBx4UdsqZr7z8q/JEVi3OqM/FCL68A1fL2Ocs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726692389; c=relaxed/simple;
	bh=6RhvjRtF/V+tZR9ZRjmZXKMqvSvQpQnYgLxSZqAMwY0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gLl9G+1tS/QgUMZW+AcIewfkjB3XplcZ1Cq1Jz8/ugH004XpsGgPbL1SPIR/u8R9GH/22ZbZw9Yavh5UPx0/4UKWlRScH3pC4JU0u7mkmxt5dIl8Iwyxy1I5zi6NDnx1dKS/tx1h5DZwA9qpr3tyLW1Y41yaEFs2GajYm4tEJLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4UJEBLu; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4UJEBLu"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c251ba0d1cso167123a12.3
        for <git@vger.kernel.org>; Wed, 18 Sep 2024 13:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726692384; x=1727297184; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4vlzVjvEQxioHPRBrgVqdPDVI71vKHDQ6ZXJrvLFck=;
        b=J4UJEBLuLXcrs+m+7KaAvULbSFFiqrbB+b4OnPLONUt4kE0fjN5kVVIwUQeafERw/h
         hew0HYc7yfM4UWF6+g9N5FDvv0PKwOk4fYh3/ZB0wXmHzGgOhQHqEM1LTMYKY+OwQj9K
         6f4plkjXH1OZ9vfFe+2oypmbMuXTuy6ao2s21NZp1TEImS7V/yLe1Ibs/eO/VXpmVD0e
         ZLzMkP7s3L8sG9dMLly5w1Y/EzZaEqmGVEk3Pi8WNQXc0E6YsrBbu3Q8mXq/AoQfSmPq
         CSS8cDNLsoPQz4ahH+CQpsg61VMIY5p3aPO2GAnffcBKxrFC6cKWLjEJV4qX7dV55iXB
         O6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726692384; x=1727297184;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N4vlzVjvEQxioHPRBrgVqdPDVI71vKHDQ6ZXJrvLFck=;
        b=e7cl5LB41NT7hVCrkIKB9LqOdShGtCzhcVKYY8kR6appnWv7jrm/w5mSbntABESPDa
         Hf2pflX286ns0mM1Zhcb864FlI5XEIbvMCzBKo6I4alNAPoEIupEHlTHxhYIT8K2sgBJ
         lg6ZGZ5LRLsFMntDnmCqLgfO2NbiZN4jrNhDyO5tOBoX4zrsGiZ50DUtgoT3tv0uEGr6
         4RHX7Z8ttI0re9bwu1UiWxkFVswvDwhRwxs1xVHXtM/5+8GxjWavOBt/2ulROY4WxGRq
         vpTC+7ihBA1rDyPUPUdqGlrp3GUKzjzsd5pCcsfo+vuAKCtFFZbG6xBg+PF2p2Hwc3Rg
         JXwQ==
X-Gm-Message-State: AOJu0YwYpjhIDKcq0NbhlzUNWFzqp1k18J5n5hchiBbcvskSwhWRzcig
	ZJh5DQsIn0EFC6cVTaGQhHFns+9Nwmf9fUnD678tj+9dguj3Maemp2psQg==
X-Google-Smtp-Source: AGHT+IH/TxB+0qOaZj0nkZi3mR5kEC+360jLrKrzMGYaeMY6T1MPDXAM1GbwWIRjoYprcRe7xXzTlQ==
X-Received: by 2002:a05:6402:1e8f:b0:5be:fa68:a239 with SMTP id 4fb4d7f45d1cf-5c413e11822mr22955407a12.13.1726692383813;
        Wed, 18 Sep 2024 13:46:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb535eesm5299129a12.29.2024.09.18.13.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 13:46:23 -0700 (PDT)
Message-Id: <pull.1785.v2.git.1726692381.gitgitgadget@gmail.com>
In-Reply-To: <pull.1785.git.1725890210.gitgitgadget@gmail.com>
References: <pull.1785.git.1725890210.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Sep 2024 20:46:15 +0000
Subject: [PATCH v2 0/6] pack-objects: create new name-hash algorithm
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
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    Derrick Stolee <stolee@gmail.com>

I've been focused recently on understanding and mitigating the growth of a
few internal repositories. Some of these are growing much larger than
expected for the number of contributors, and there are multiple aspects to
why this growth is so large.

This is part of the RFC I submitted [1] [2] involving the path-walk API,
though this doesn't use the path-walk API directly. In full repack cases, it
seems that the --full-name-hash option gets nearly as good compression as
the --path-walk option introduced in that series. I continue to work on that
feature as well, so we can review it after this series is complete.

[1] https://github.com/gitgitgadget/git/pull/1786

[2]
https://lore.kernel.org/git/pull.1786.git.1725935335.gitgitgadget@gmail.com/

The main issue plaguing these repositories is that deltas are not being
computed against objects that appear at the same path. While the size of
these files at tip is one aspect of growth that would prevent this issue,
the changes to these files are reasonable and should result in good delta
compression. However, Git is not discovering the connections across
different versions of the same file.

One way to find some improvement in these repositories is to increase the
window size, which was an initial indicator that the delta compression could
be improved, but was not a clear indicator. After some digging (and
prototyping some analysis tools) the main discovery was that the current
name-hash algorithm only considers the last 16 characters in the path name
and has some naturally-occurring collisions within that scope.

This series introduces a new name-hash algorithm, but does not replace the
existing one. There are cases, such as packing a single snapshot of a
repository, where the existing algorithm outperforms the new one.

However, my findings show that when a repository has many versions of files
at the same path (and especially when there are many name-hash collisions)
then there are significant gains to be made using the new algorithm.

(This table is updated in v2 with even more private examples that were found
while communicating findings internally.)

| Repo     | Standard Repack | With --full-name-hash |
|----------|-----------------|-----------------------|
| fluentui |         438 MB  |               168 MB  |
| Repo B   |       6,255 MB  |               829 MB  |
| Repo C   |      37,737 MB  |             7,125 MB  |
| Repo D   |     130,049 MB  |             6,190 MB  |
| Repo E   |     100,957 MB  |            22,979 MB  |
| Repo F   |       8,308 MB  |               746 MB  |
| Repo G   |       4,329 MB  |             3,643 MB  |


I include Repo G here as an example where the improvement is less drastic,
since this repo does not demonstrate a very high rate of name-hash
collisions; the collisions that exist seem to be in paths that are not
changed very often. Thus, the standard name-hash algorithm is nearly as
effective in these full repacks.

The main change in this series is in patch 1, which adds the algorithm and
the option to 'git pack-objects' and 'git repack'. The remaining patches are
focused on creating more evidence around the value of the new name-hash
algorithm and its effects on the packfiles created with it.

I will also try to make clear that I've been focused on client-side
performance and size concerns. Based on discussions in v1, it appears that
the following is true:

 * This feature is completely orthogonal to delta islands.
 * Changing the name-hash function can lead to compatibility issues with
   .bitmap files, as they store a name-hash value. Without augmenting the
   data structure to indicate which name-hash value was used at write time,
   the full-name-hash values should not be stored in the .bitmap files or
   used when reading .bitmap files and other objects. Thus, the
   full-name-hash is marked as incompatible with bitmaps for now.
 * The --path-walk option from the RFC ([1] and [2]) is likely incompatible
   with the delta-islands feature without significant work, so this suggests
   that the --full-name-hash is a better long-term solution for servers.
   This would still require the .bitmap modifications to make it work, but
   it's a smaller leap to get there.

Thanks, -Stolee


UPDATES IN V2
=============

Thank you for all of the discussion on v1. Here are the things I've learned
and how they have changed this patch series:

 * The test-tool name-hash helper change collides with the removal of
   test-tool oid-array, so I have rebased this series onto the latest master
   branch.
 * I learned (thanks, Taylor and Peff) that the .bitmap files store
   name-hash values. This means that the --full-name-hash option risks
   having different name-hash functions across bitmap reads and dynamic
   computations from the object walk. For this reason, the option is now
   made explicit to not work with bitmap walks. This could be corrected in
   the future with a modification to the .bitmap data structure to store a
   "name-hash version" value. This behavior is confirmed with a test.
 * A new test explicitly tests that git repack --full-name-hash passes the
   option to git pack-objects. This uses a new helper method,
   test_subcommand_flex that is more flexible than the existing
   test_subcommand.
 * To get more testing across different cases, add a new
   GIT_TEST_FULL_NAME_HASH environment variable. I point out which tests
   need modification when this is enabled.
 * The size-comparison tests were not portable with their use of du.
   Instead, use wc -c for the single pack-file that remains after a git
   repack -adf ... command.
 * The final patch still updates the test-tool name-hash helper, which was
   previously only used by a performance test. Now, use that test in a
   regular test to help guarantee that the functions do not change over
   time. This is directly related to the fact that these values can be
   stored in the .bitmap files and we need stable hash functions to keep
   compatibility with files written by previous versions of Git.

Other things that have happened include investigations into ways to adapt
the full-name hash to improve upon the name-hash. I did some experimenting
with increasing the size of 'struct object_entry' by using a 64-bit hash
value (name-hash, then full-name-hash) for a single-pass compression or two
32-bit hash values for a two-pass compression process. I include my WIP
branch at [3] to show what I tried, though the single-pass option did not
present any improvements and the two-pass option seems to be broken to the
point that the compression is substantially worse. (I'll try to elaborate on
this in a reply to this cover letter.)

[3]
https://github.com/derrickstolee/git/compare/full-name...derrickstolee:git:full-name-wip

Derrick Stolee (6):
  pack-objects: add --full-name-hash option
  repack: test --full-name-hash option
  pack-objects: add GIT_TEST_FULL_NAME_HASH
  git-repack: update usage to match docs
  p5313: add size comparison test
  test-tool: add helper for name-hash values

 Documentation/git-pack-objects.txt |  3 +-
 Documentation/git-repack.txt       |  4 +-
 Makefile                           |  1 +
 builtin/pack-objects.c             | 25 ++++++++---
 builtin/repack.c                   |  9 +++-
 ci/run-build-and-tests.sh          |  1 +
 pack-objects.h                     | 21 +++++++++
 t/README                           |  4 ++
 t/helper/test-name-hash.c          | 23 ++++++++++
 t/helper/test-tool.c               |  1 +
 t/helper/test-tool.h               |  1 +
 t/perf/p5313-pack-objects.sh       | 71 ++++++++++++++++++++++++++++++
 t/perf/p5314-name-hash.sh          | 41 +++++++++++++++++
 t/t0450/txt-help-mismatches        |  1 -
 t/t5300-pack-object.sh             | 15 +++++++
 t/t5310-pack-bitmaps.sh            | 26 +++++++++++
 t/t5510-fetch.sh                   |  7 ++-
 t/t5616-partial-clone.sh           | 26 ++++++++++-
 t/t6020-bundle-misc.sh             |  6 ++-
 t/t7700-repack.sh                  |  7 +++
 t/test-lib-functions.sh            | 27 ++++++++++++
 21 files changed, 307 insertions(+), 13 deletions(-)
 create mode 100644 t/helper/test-name-hash.c
 create mode 100755 t/perf/p5313-pack-objects.sh
 create mode 100755 t/perf/p5314-name-hash.sh


base-commit: 3fb745257b30a643ee78c9a7c52ab107c82e4745
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1785%2Fderrickstolee%2Ffull-name-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1785/derrickstolee/full-name-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1785

Range-diff vs v1:

 1:  ff30f774ca8 ! 1:  5f52e261765 pack-objects: add --full-name-hash option
     @@ builtin/pack-objects.c: int cmd_pack_objects(int argc, const char **argv, const
       		OPT_END(),
       	};
       
     +@@ builtin/pack-objects.c: int cmd_pack_objects(int argc, const char **argv, const char *prefix)
     + 	if (pack_to_stdout || !rev_list_all)
     + 		write_bitmap_index = 0;
     + 
     ++	if (write_bitmap_index && use_full_name_hash)
     ++		die(_("currently, the --full-name-hash option is incompatible with --write-bitmap-index"));
     ++
     + 	if (use_delta_islands)
     + 		strvec_push(&rp, "--topo-order");
     + 
      
       ## builtin/repack.c ##
      @@ builtin/repack.c: struct pack_objects_args {
     @@ pack-objects.h: static inline uint32_t pack_name_hash(const char *name)
      +		return 0;
      +
      +	/*
     -+	 * Just do the dumbest thing possible: add random multiples of a
     -+	 * large prime number with a binary shift. Goal is not cryptographic,
     -+	 * but generally uniformly distributed.
     ++	 * Do the simplest thing that will resemble pseduo-randomness: add
     ++	 * random multiples of a large prime number with a binary shift.
     ++	 * The goal is not to be cryptographic, but to be generally
     ++	 * uniformly distributed.
      +	 */
      +	while ((c = *name++) != 0) {
      +		hash += c * bigp;
     @@ pack-objects.h: static inline uint32_t pack_name_hash(const char *name)
       static inline enum object_type oe_type(const struct object_entry *e)
       {
       	return e->type_valid ? e->type_ : OBJ_BAD;
     +
     + ## t/t5300-pack-object.sh ##
     +@@ t/t5300-pack-object.sh: do
     + 	'
     + done
     + 
     ++# The following test is not necessarily a permanent choice, but since we do not
     ++# have a "name hash version" bit in the .bitmap file format, we cannot write the
     ++# full-name hash values into the .bitmap file without risking breakage later.
     ++#
     ++# TODO: Make these compatible in the future and replace this test with the
     ++# expected behavior when both are specified.
     ++test_expect_success '--full-name-hash and --write-bitmap-index are incompatible' '
     ++	test_must_fail git pack-objects base --all \
     ++		--full-name-hash --write-bitmap-index 2>err &&
     ++	grep incompatible err &&
     ++
     ++	# --stdout option silently removes --write-bitmap-index
     ++	git pack-objects --stdout --all --full-name-hash --write-bitmap-index >out
     ++'
     ++
     + test_done
 -:  ----------- > 2:  48b87cccedb repack: test --full-name-hash option
 -:  ----------- > 3:  48b3876a102 pack-objects: add GIT_TEST_FULL_NAME_HASH
 2:  eb0aa5f4e94 = 4:  c5827126120 git-repack: update usage to match docs
 3:  ed3ea4281a9 ! 5:  999b1d09424 p5313: add size comparison test
     @@ t/perf/p5313-pack-objects.sh (new)
      +'
      +
      +test_size 'repack size' '
     -+	du -a .git/objects/pack | sort -nr | awk "{ print \$1; }" | head -n 1
     ++	wc -c <.git/objects/pack/pack-*.pack
      +'
      +
      +test_perf 'repack with --full-name-hash' '
     @@ t/perf/p5313-pack-objects.sh (new)
      +'
      +
      +test_size 'repack size with --full-name-hash' '
     -+	du -a .git/objects/pack | sort -nr | awk "{ print \$1; }" | head -n 1
     ++	wc -c <.git/objects/pack/pack-*.pack
      +'
      +
      +test_done
 4:  5bcbcce6665 ! 6:  7e47fc8cb53 p5314: add a size test for name-hash collisions
     @@ Metadata
      Author: Derrick Stolee <dstolee@microsoft.com>
      
       ## Commit message ##
     -    p5314: add a size test for name-hash collisions
     +    test-tool: add helper for name-hash values
      
          Add a new test-tool helper, name-hash, to output the value of the
          name-hash algorithms for the input list of strings, one per line.
      
     +    Since the name-hash values can be stored in the .bitmap files, it is
     +    important that these hash functions do not change across Git versions.
     +    Add a simple test to t5310-pack-bitmaps.sh to provide some testing of
     +    the current values. Due to how these functions are implemented, it would
     +    be difficult to change them without disturbing these values.
     +
          Create a performance test that uses test_size to demonstrate how
          collisions occur for these hash algorithms. This test helps inform
          someone as to the behavior of the name-hash algorithms for their repo
     @@ Makefile: TEST_BUILTINS_OBJS += test-lazy-init-name-hash.o
       TEST_BUILTINS_OBJS += test-mergesort.o
       TEST_BUILTINS_OBJS += test-mktemp.o
      +TEST_BUILTINS_OBJS += test-name-hash.o
     - TEST_BUILTINS_OBJS += test-oid-array.o
       TEST_BUILTINS_OBJS += test-online-cpus.o
       TEST_BUILTINS_OBJS += test-pack-mtimes.o
     + TEST_BUILTINS_OBJS += test-parse-options.o
      
       ## t/helper/test-name-hash.c (new) ##
      @@
     @@ t/helper/test-tool.c: static struct test_cmd cmds[] = {
       	{ "mergesort", cmd__mergesort },
       	{ "mktemp", cmd__mktemp },
      +	{ "name-hash", cmd__name_hash },
     - 	{ "oid-array", cmd__oid_array },
       	{ "online-cpus", cmd__online_cpus },
       	{ "pack-mtimes", cmd__pack_mtimes },
     + 	{ "parse-options", cmd__parse_options },
      
       ## t/helper/test-tool.h ##
      @@ t/helper/test-tool.h: int cmd__lazy_init_name_hash(int argc, const char **argv);
     @@ t/perf/p5314-name-hash.sh (new)
      +'
      +
      +test_done
     +
     + ## t/t5310-pack-bitmaps.sh ##
     +@@ t/t5310-pack-bitmaps.sh: has_any () {
     + 	grep -Ff "$1" "$2"
     + }
     + 
     ++# Since name-hash values are stored in the .bitmap files, add a test
     ++# that checks that the name-hash calculations are stable across versions.
     ++# Not exhaustive, but these hashing algorithms would be hard to change
     ++# without causing deviations here.
     ++test_expect_success 'name-hash value stability' '
     ++	cat >names <<-\EOF &&
     ++	first
     ++	second
     ++	third
     ++	one-long-enough-for-collisions
     ++	two-long-enough-for-collisions
     ++	EOF
     ++
     ++	test-tool name-hash <names >out &&
     ++
     ++	cat >expect <<-\EOF &&
     ++	2582249472	3109209818	first
     ++	2289942528	3781118409	second
     ++	2300837888	3028707182	third
     ++	2544516325	3241327563	one-long-enough-for-collisions
     ++	2544516325	4207880830	two-long-enough-for-collisions
     ++	EOF
     ++
     ++	test_cmp expect out
     ++'
     ++
     + test_bitmap_cases () {
     + 	writeLookupTable=false
     + 	for i in "$@"

-- 
gitgitgadget
