Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7DD2A1CA
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 03:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730775914; cv=none; b=uC44lh/eV86RKXrdV68/5MNvVinccJZiP5hG1eN75EBH6rWN38icWJvw154RuB9idfZQGLXJIT6Fvtzb02S7d2wsCXUYhIIQMA0dQddGn46KVz7FJMwoV5lxy0qVGK2oecjy/ie1IovdRu+8XTycKGZ53rQtSoNpUnBij030zmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730775914; c=relaxed/simple;
	bh=JAC64bItlZEKzCsqWby76IFAf9GP4iqHEzejDC8CUug=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=QBZ+2ShJQg9mzCgZEeuEhTMqutRD5gx5O1AROiz7dfYcOR5Ss48uUeFa6b/hziZcW0J3saeD7shFMPn0SEO2170Oy0hf2EDFYjo8w/4nQoe74tPfQ3xDNebIjpxV91INrzsT6gxSBIWuAHbVgCG+Mz8bhC5CCvV+1dkDBktx/ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8PgVHJX; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8PgVHJX"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37ed3bd6114so2826248f8f.2
        for <git@vger.kernel.org>; Mon, 04 Nov 2024 19:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730775910; x=1731380710; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xvjbC2db88Hml1RQscKDLgzo95dGfz6t6mVpd9pB2jU=;
        b=M8PgVHJXft52wOqjFSIrnXc4G4F37z4gcH4tPWUYBo9DYHgrKzJuoYw4oLPIszRDhO
         Ft3xashWhdE5KflEu+kpBptODVa3F0CpblwYwCQ2yCh1xk9sH3Yb1yX+fu/FpqDVIeUV
         oU2uBCtFtCEi+gW2K5W+pFpiGZvkaVP47lVUQklLRhJeNQJEAcs7vwOSy1mqsgXGcZn/
         VzXROCAurSgq/A2w6qNdRfrwIRnzkfFL5BbABZEvtPHGjYn1k9soqkdrKuSwUwXhef42
         9GI+Lp3I0WJnDO9V9Ku+B1V33uE/077ZhLIxRNfxlFBOeLEKEb6EJNzruPX+T0flJUz4
         meFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730775910; x=1731380710;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xvjbC2db88Hml1RQscKDLgzo95dGfz6t6mVpd9pB2jU=;
        b=H36aa4PGK1VhfAvP64gQ1KgRyCc0llhs+qmhE+Xv7xrJLIcxGHAPrWqom2z61C+orB
         wCl75KT7faEEubebOSkv1UvcLKyWaJPtdDNW0el91dcGRHUTG5d9wNiU4yxFUTdN4Xhw
         azuxT/tB3anre3yVv2MKcjl9W20mu++DziZMsNXQiSim0nuofyIF7NuIeCcr5R/2Nf/G
         AqUfIVmNJw+WLlpsPDvQ49IuDzPXu8gmdD3OfoMVmQwjQsjqJQTSAOPCf9P29oj+CKUu
         ygbmRi0RTH4fZ9Ar4rpcVz9hWTjDJ5pZL9ssuKjFEY8L35qleAeeNqpoFpy0RvCxoQeL
         Yrnw==
X-Gm-Message-State: AOJu0Yw6mXTYHVRsMsLE7VEdi/5c1yevlvksbj52SuLol45JfKUMmG/e
	EwY/KEWgWBugYce/EqCoUs+gV8C5fmNu62rtPm95dSc9cqlqJK4aDFo/jg==
X-Google-Smtp-Source: AGHT+IFgYCZguOhqacUQ6h2X37hk0vgc5im+0sKJMAhLGHbmCBklsnPwOYvWKaAjxSBCPvtIwEOlzA==
X-Received: by 2002:a5d:64c5:0:b0:37d:5429:9004 with SMTP id ffacd0b85a97d-381c7a3a52amr9355013f8f.3.1730775909665;
        Mon, 04 Nov 2024 19:05:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c116b181sm14618507f8f.107.2024.11.04.19.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 19:05:09 -0800 (PST)
Message-Id: <pull.1823.git.1730775907.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 05 Nov 2024 03:05:00 +0000
Subject: [PATCH 0/7] pack-objects: Create an alternative name hash algorithm (recreated)
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

This is a recreation of the topic in [1] that was closed. (I force-pushed my
branch and GitHub won't let me reopen the PR for GitGitGadget to create this
as v3.)

[1]
https://lore.kernel.org/git/pull.1785.v2.git.1726692381.gitgitgadget@gmail.com/

I've been focused recently on understanding and mitigating the growth of a
few internal repositories. Some of these are growing much larger than
expected for the number of contributors, and there are multiple aspects to
why this growth is so large.

This is part of the RFC I submitted [2] involving the path-walk API, though
this doesn't use the path-walk API directly. In full repack cases, it seems
that the --full-name-hash option gets nearly as good compression as the
--path-walk option introduced in that series. I continue to work on that
feature as well, so we can review it after this series is complete.

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


Since there has been some interest in these repacking results since [3] was
published, I'll say that "Repo D" is the one mentioned in that post. The
--path-walk repack further improves the results to under 4GB.

[3]
https://www.jonathancreamer.com/how-we-shrunk-our-git-repo-size-by-94-percent/

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
   full-name-hash is marked as incompatible with bitmaps for now. (In this
   version, the 'git pack-objects' process will not fail but will prefer the
   standard name hash algorithm.)

 * The --path-walk option is likely incompatible with the delta-islands
   feature without significant work, so this suggests that the
   --full-name-hash is a better long-term solution for servers. This would
   still require the .bitmap modifications to make it work, but it's a
   smaller leap to get there.

Thanks, -Stolee


UPDATES SINCE PREVIOUS VERSION
==============================

This is recreated after pursuing the path-walk API with 'git pack-objects
--path-walk' [4] and also cutting the series into fewer patches and only
including the path-walk API in [5].

[4]
https://lore.kernel.org/git/pull.1813.v2.git.1729431810.gitgitgadget@gmail.com/

[5]
https://lore.kernel.org/git/pull.1818.git.1730356023.gitgitgadget@gmail.com/

This re-roll has these changes:

 * The performance script is updated to include a simulation of a depth-1
   shallow clone.

 * The performance numbers in the commit messages are updated with the
   latest results and include more example repositories.

 * Small style nits, especially around whitespace.

 * To prevent the --full-name-hash option from having compatibility issues
   with .bitmap files, the previous version would cause the 'git
   pack-objects' process to fail. Now, the process succeeds, but the
   --full-name-hash option is disabled with a warning.

 * These patches are rebased on a recent copy of 'master' and thus there are
   some new tests that need adjustment to work with
   GIT_TEST_FULL_NAME_HASH=1. They all care about an exact match with stderr
   and the warning to disable --full-name-hash causes a mismatch.

Here is the range-diff since the previous version:

1:  9c8f8f35f34 ! 1:  812257e197c pack-objects: add --full-name-hash option
    @@ Commit message
         Future changes could include making --full-name-hash implied by a config
         value or even implied by default during a full repack.
     
    +    It is important to point out that the name hash value is stored in the
    +    .bitmap file format, so we must disable the --full-name-hash option when
    +    bitmaps are being read or written. Later, the bitmap format could be
    +    updated to be aware of the name hash version so deltas can be quickly
    +    computed across the bitmapped/not-bitmapped boundary.
    +
         Signed-off-by: Derrick Stolee <stolee@gmail.com>
     
      ## Documentation/git-pack-objects.txt ##
    @@ builtin/pack-objects.c: static void add_cruft_object_entry(const struct object_i
      					    0, name && no_try_delta(name),
      					    pack, offset);
      	}
    -@@ builtin/pack-objects.c: int cmd_pack_objects(int argc, const char **argv, const char *prefix)
    +@@ builtin/pack-objects.c: int cmd_pack_objects(int argc,
      		OPT_STRING_LIST(0, "uri-protocol", &uri_protocols,
      				N_("protocol"),
      				N_("exclude any configured uploadpack.blobpackfileuri with this protocol")),
    @@ builtin/pack-objects.c: int cmd_pack_objects(int argc, const char **argv, const
      		OPT_END(),
      	};
      
    -@@ builtin/pack-objects.c: int cmd_pack_objects(int argc, const char **argv, const char *prefix)
    +@@ builtin/pack-objects.c: int cmd_pack_objects(int argc,
      	if (pack_to_stdout || !rev_list_all)
      		write_bitmap_index = 0;
      
    -+	if (write_bitmap_index && use_full_name_hash)
    -+		die(_("currently, the --full-name-hash option is incompatible with --write-bitmap-index"));
    ++	if (write_bitmap_index && use_full_name_hash) {
    ++		warning(_("currently, the --full-name-hash option is incompatible with --write-bitmap-index"));
    ++		use_full_name_hash = 0;
    ++	}
     +
      	if (use_delta_islands)
      		strvec_push(&rp, "--topo-order");
    @@ builtin/repack.c: static void prepare_pack_objects(struct child_process *cmd,
      	if (args->local)
      		strvec_push(&cmd->args,  "--local");
      	if (args->quiet)
    -@@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix)
    +@@ builtin/repack.c: int cmd_repack(int argc,
      				N_("pass --no-reuse-delta to git-pack-objects")),
      		OPT_BOOL('F', NULL, &po_args.no_reuse_object,
      				N_("pass --no-reuse-object to git-pack-objects")),
    @@ t/t5300-pack-object.sh: do
     +# TODO: Make these compatible in the future and replace this test with the
     +# expected behavior when both are specified.
     +test_expect_success '--full-name-hash and --write-bitmap-index are incompatible' '
    -+	test_must_fail git pack-objects base --all \
    -+		--full-name-hash --write-bitmap-index 2>err &&
    -+	grep incompatible err &&
    ++	git pack-objects base --all --full-name-hash --write-bitmap-index 2>err &&
    ++	test_grep incompatible err &&
     +
     +	# --stdout option silently removes --write-bitmap-index
    -+	git pack-objects --stdout --all --full-name-hash --write-bitmap-index >out
    ++	git pack-objects --stdout --all --full-name-hash --write-bitmap-index >out 2>err &&
    ++	! test_grep incompatible err
     +'
     +
      test_done
2:  612dbd1951b ! 2:  93395c93347 repack: test --full-name-hash option
    @@ Metadata
     Author: Derrick Stolee <stolee@gmail.com>
     
      ## Commit message ##
    -    repack: test --full-name-hash option
    +    repack: add --full-name-hash option
     
         The new '--full-name-hash' option for 'git repack' is a simple
         pass-through to the underlying 'git pack-objects' subcommand. However,
    @@ t/test-lib-functions.sh: test_subcommand () {
      	fi
      }
      
    -+
     +# Check that the given subcommand was run with the given set of
     +# arguments in order (but with possible extra arguments).
     +#
3:  e173de67b6a ! 3:  259734e0bce pack-objects: add GIT_TEST_FULL_NAME_HASH
    @@ Commit message
         now, do the minimal change to make the test work by disabling the test
         variable.
     
    +    Third, there are some tests that compare the exact output of a 'git
    +    pack-objects' process when using bitmaps. The warning that disables the
    +    --full-name-hash option causes these tests to fail. Disable the
    +    environment variable to get around this issue.
    +
         Signed-off-by: Derrick Stolee <stolee@gmail.com>
     
      ## builtin/pack-objects.c ##
    @@ builtin/pack-objects.c: struct configured_exclusion {
      
      static inline uint32_t pack_name_hash_fn(const char *name)
      {
    -@@ builtin/pack-objects.c: int cmd_pack_objects(int argc, const char **argv, const char *prefix)
    +@@ builtin/pack-objects.c: int cmd_pack_objects(int argc,
      	if (pack_to_stdout || !rev_list_all)
      		write_bitmap_index = 0;
      
    --	if (write_bitmap_index && use_full_name_hash)
    -+	if (write_bitmap_index && use_full_name_hash > 0)
    - 		die(_("currently, the --full-name-hash option is incompatible with --write-bitmap-index"));
    +-	if (write_bitmap_index && use_full_name_hash) {
     +	if (use_full_name_hash < 0)
     +		use_full_name_hash = git_env_bool("GIT_TEST_FULL_NAME_HASH", 0);
    - 
    - 	if (use_delta_islands)
    - 		strvec_push(&rp, "--topo-order");
    ++
    ++	if (write_bitmap_index && use_full_name_hash > 0) {
    + 		warning(_("currently, the --full-name-hash option is incompatible with --write-bitmap-index"));
    + 		use_full_name_hash = 0;
    + 	}
     
      ## ci/run-build-and-tests.sh ##
     @@ ci/run-build-and-tests.sh: linux-TEST-vars)
    @@ t/README: a test and then fails then the whole test run will abort. This can hel
      ------------
      
     
    + ## t/t5310-pack-bitmaps.sh ##
    +@@ t/t5310-pack-bitmaps.sh: test_bitmap_cases () {
    + 			cat >expect <<-\EOF &&
    + 			error: missing value for '\''pack.preferbitmaptips'\''
    + 			EOF
    ++
    ++			# Disable --full-name-hash test due to stderr comparison.
    ++			GIT_TEST_FULL_NAME_HASH=0 \
    + 			git repack -adb 2>actual &&
    + 			test_cmp expect actual
    + 		)
    +
    + ## t/t5333-pseudo-merge-bitmaps.sh ##
    +@@ t/t5333-pseudo-merge-bitmaps.sh: test_expect_success 'bitmapPseudoMerge.stableThreshold creates stable groups' '
    + '
    + 
    + test_expect_success 'out of order thresholds are rejected' '
    ++	# Disable this option to avoid stderr message
    ++	GIT_TEST_FULL_NAME_HASH=0 &&
    ++	export GIT_TEST_FULL_NAME_HASH &&
    ++
    + 	test_must_fail git \
    + 		-c bitmapPseudoMerge.test.pattern="refs/*" \
    + 		-c bitmapPseudoMerge.test.threshold=1.month.ago \
    +
      ## t/t5510-fetch.sh ##
     @@ t/t5510-fetch.sh: test_expect_success 'all boundary commits are excluded' '
      	test_tick &&
    @@ t/t6020-bundle-misc.sh: test_expect_success 'create bundle with --since option'
      		--since "Thu Apr 7 15:27:00 2005 -0700" \
      		--all &&
      
    +
    + ## t/t7406-submodule-update.sh ##
    +@@ t/t7406-submodule-update.sh: test_expect_success 'submodule update --quiet passes quietness to fetch with a s
    + 	) &&
    + 	git clone super4 super5 &&
    + 	(cd super5 &&
    ++	 # This test var can mess with the stderr output checked in this test.
    ++	 GIT_TEST_FULL_NAME_HASH=0 \
    + 	 git submodule update --quiet --init --depth=1 submodule3 >out 2>err &&
    + 	 test_must_be_empty out &&
    + 	 test_must_be_empty err
    +
    + ## t/t7700-repack.sh ##
    +@@ t/t7700-repack.sh: test_expect_success 'no bitmaps created if .keep files present' '
    + 	keep=${pack%.pack}.keep &&
    + 	test_when_finished "rm -f \"\$keep\"" &&
    + 	>"$keep" &&
    ++
    ++	# Disable --full-name-hash test due to stderr comparison.
    ++	GIT_TEST_FULL_NAME_HASH=0 \
    + 	git -C bare.git repack -ad 2>stderr &&
    + 	test_must_be_empty stderr &&
    + 	find bare.git/objects/pack/ -type f -name "*.bitmap" >actual &&
    +@@ t/t7700-repack.sh: test_expect_success 'auto-bitmaps do not complain if unavailable' '
    + 	blob=$(test-tool genrandom big $((1024*1024)) |
    + 	       git -C bare.git hash-object -w --stdin) &&
    + 	git -C bare.git update-ref refs/tags/big $blob &&
    ++
    ++	# Disable --full-name-hash test due to stderr comparison.
    ++	GIT_TEST_FULL_NAME_HASH=0 \
    + 	git -C bare.git repack -ad 2>stderr &&
    + 	test_must_be_empty stderr &&
    + 	find bare.git/objects/pack -type f -name "*.bitmap" >actual &&
4:  543382b2702 = 4:  65784f85bce git-repack: update usage to match docs
5:  4d2381a19c4 ! 5:  c14ef6879e4 p5313: add size comparison test
    @@ Commit message
     
         Checked out at the parent of [2], I see the following statistics:
     
    -    Test                                           this tree
    -    ------------------------------------------------------------------
    -    5313.2: thin pack                              0.02(0.01+0.01)
    -    5313.3: thin pack size                                    1.1K
    -    5313.4: thin pack with --full-name-hash        0.02(0.01+0.00)
    -    5313.5: thin pack size with --full-name-hash              3.0K
    -    5313.6: big pack                               1.65(3.35+0.24)
    -    5313.7: big pack size                                    58.0M
    -    5313.8: big pack with --full-name-hash         1.53(2.52+0.18)
    -    5313.9: big pack size with --full-name-hash              57.6M
    -    5313.10: repack                                176.52(706.60+3.53)
    -    5313.11: repack size                                    446.7K
    -    5313.12: repack with --full-name-hash          37.47(134.18+3.06)
    -    5313.13: repack size with --full-name-hash              183.1K
    -
    -    Note that this demonstrates a 3x size _increase_ in the case that
    -    simulates a small "git push". The size change is neutral on the case of
    -    pushing the difference between HEAD and HEAD~1000.
    -
    -    However, the full repack case is both faster and more efficient.
    +    Test                                               HEAD
    +    ---------------------------------------------------------------------
    +    5313.2: thin pack                                  0.37(0.43+0.02)
    +    5313.3: thin pack size                                        1.2M
    +    5313.4: thin pack with --full-name-hash            0.06(0.09+0.02)
    +    5313.5: thin pack size with --full-name-hash                 20.4K
    +    5313.6: big pack                                   2.01(7.73+0.23)
    +    5313.7: big pack size                                        20.3M
    +    5313.8: big pack with --full-name-hash             1.32(2.77+0.27)
    +    5313.9: big pack size with --full-name-hash                  19.9M
    +    5313.10: shallow fetch pack                        1.40(3.01+0.08)
    +    5313.11: shallow pack size                                   34.4M
    +    5313.12: shallow pack with --full-name-hash        1.08(1.25+0.14)
    +    5313.13: shallow pack size with --full-name-hash             35.4M
    +    5313.14: repack                                    90.70(672.88+2.46)
    +    5313.15: repack size                                        439.6M
    +    5313.16: repack with --full-name-hash              18.53(123.41+2.53)
    +    5313.17: repack size with --full-name-hash                  169.7M
    +
    +    In this case, we see positive behaviors such as a significant shrink in
    +    the size of the thin pack and full repack. The big pack is slightly
    +    smaller with --full-name-hash than without. The shallow pack is slightly
    +    larger with --full-name-hash.
    +
    +    In the case of the Git repository, these numbers show some of the issues
    +    with this approach:
    +
    +    Test                                               HEAD
    +    --------------------------------------------------------------------
    +    5313.2: thin pack                                  0.00(0.00+0.00)
    +    5313.3: thin pack size                                         589
    +    5313.4: thin pack with --full-name-hash            0.00(0.00+0.00)
    +    5313.5: thin pack size with --full-name-hash                 14.9K
    +    5313.6: big pack                                   2.07(3.57+0.17)
    +    5313.7: big pack size                                        17.6M
    +    5313.8: big pack with --full-name-hash             2.00(3.07+0.19)
    +    5313.9: big pack size with --full-name-hash                  17.9M
    +    5313.10: shallow fetch pack                        1.41(2.23+0.06)
    +    5313.11: shallow pack size                                   12.1M
    +    5313.12: shallow pack with --full-name-hash        1.22(1.66+0.04)
    +    5313.13: shallow pack size with --full-name-hash             12.4M
    +    5313.14: repack                                    15.75(89.29+1.54)
    +    5313.15: repack size                                        126.4M
    +    5313.16: repack with --full-name-hash              15.56(89.78+1.32)
    +    5313.17: repack size with --full-name-hash                  126.0M
    +
    +    The thin pack that simulates a push is much worse with --full-name-hash
    +    in this case. The name hash values are doing a lot to assist with delta
    +    bases, it seems. The big pack and shallow clone cases are slightly worse
    +    with the --full-name-hash option. Only the full repack gains some
    +    benefits in size.
    +
    +    The results are similar with the nodejs/node repo:
    +
    +    Test                                               HEAD
    +    ---------------------------------------------------------------------
    +    5313.2: thin pack                                  0.01(0.01+0.00)
    +    5313.3: thin pack size                                        1.6K
    +    5313.4: thin pack with --full-name-hash            0.01(0.00+0.00)
    +    5313.5: thin pack size with --full-name-hash                  3.1K
    +    5313.6: big pack                                   4.26(8.03+0.24)
    +    5313.7: big pack size                                        56.0M
    +    5313.8: big pack with --full-name-hash             4.16(6.55+0.22)
    +    5313.9: big pack size with --full-name-hash                  56.2M
    +    5313.10: shallow fetch pack                        7.67(11.80+0.29)
    +    5313.11: shallow pack size                                  104.6M
    +    5313.12: shallow pack with --full-name-hash        7.52(9.65+0.23)
    +    5313.13: shallow pack size with --full-name-hash            105.9M
    +    5313.14: repack                                    71.22(317.61+3.95)
    +    5313.15: repack size                                        739.9M
    +    5313.16: repack with --full-name-hash              48.85(267.02+3.72)
    +    5313.17: repack size with --full-name-hash                  793.5M
    +
    +    The Linux kernel repository was the initial target of the default name
    +    hash value, and its naming conventions are practically build to take the
    +    most advantage of the default name hash values:
    +
    +    Test                                               HEAD
    +    -------------------------------------------------------------------------
    +    5313.2: thin pack                                  0.15(0.01+0.03)
    +    5313.3: thin pack size                                        4.6K
    +    5313.4: thin pack with --full-name-hash            0.03(0.02+0.01)
    +    5313.5: thin pack size with --full-name-hash                  6.8K
    +    5313.6: big pack                                   18.51(33.74+0.95)
    +    5313.7: big pack size                                       201.1M
    +    5313.8: big pack with --full-name-hash             16.01(29.81+0.88)
    +    5313.9: big pack size with --full-name-hash                 202.1M
    +    5313.10: shallow fetch pack                        11.49(17.61+0.54)
    +    5313.11: shallow pack size                                  269.2M
    +    5313.12: shallow pack with --full-name-hash        11.24(15.25+0.56)
    +    5313.13: shallow pack size with --full-name-hash            269.8M
    +    5313.14: repack                                    1001.25(2271.06+38.86)
    +    5313.15: repack size                                          2.5G
    +    5313.16: repack with --full-name-hash              625.75(1941.96+36.09)
    +    5313.17: repack size with --full-name-hash                    2.6G
    +
    +    Finally, an internal Javascript repo of moderate size shows significant
    +    gains when repacking with --full-name-hash due to it having many name
    +    hash collisions. However, it's worth noting that only the full repack
    +    case has enough improvement to be worth it. But the improvements are
    +    significant: 6.4 GB to 862 MB.
    +
    +    Test                                               HEAD
    +    --------------------------------------------------------------------------
    +    5313.2: thin pack                                  0.03(0.02+0.00)
    +    5313.3: thin pack size                                        1.2K
    +    5313.4: thin pack with --full-name-hash            0.03(0.03+0.00)
    +    5313.5: thin pack size with --full-name-hash                  2.6K
    +    5313.6: big pack                                   2.20(3.23+0.30)
    +    5313.7: big pack size                                       130.7M
    +    5313.8: big pack with --full-name-hash             2.33(3.17+0.34)
    +    5313.9: big pack size with --full-name-hash                 131.0M
    +    5313.10: shallow fetch pack                        3.56(6.02+0.32)
    +    5313.11: shallow pack size                                   44.5M
    +    5313.12: shallow pack with --full-name-hash        2.94(3.94+0.32)
    +    5313.13: shallow pack size with --full-name-hash             45.3M
    +    5313.14: repack                                    2435.22(12523.11+23.53)
    +    5313.15: repack size                                          6.4G
    +    5313.16: repack with --full-name-hash              473.25(1805.11+17.22)
    +    5313.17: repack size with --full-name-hash                  861.9M
    +
    +    These tests demonstrate that it is important to be careful about which
    +    cases are best for using the --full-name-hash option.
     
         Signed-off-by: Derrick Stolee <stolee@gmail.com>
     
    @@ t/perf/p5313-pack-objects.sh (new)
     +	^$(git rev-parse HEAD~1)
     +	EOF
     +
    -+	cat >in-big <<-EOF
    ++	cat >in-big <<-EOF &&
     +	$(git rev-parse HEAD)
     +	^$(git rev-parse HEAD~1000)
     +	EOF
    ++
    ++	cat >in-shallow <<-EOF
    ++	$(git rev-parse HEAD)
    ++	--shallow $(git rev-parse HEAD)
    ++	EOF
     +'
     +
     +test_perf 'thin pack' '
    @@ t/perf/p5313-pack-objects.sh (new)
     +	test_file_size out
     +'
     +
    ++test_perf 'shallow fetch pack' '
    ++	git pack-objects --stdout --revs --sparse --shallow <in-shallow >out
    ++'
    ++
    ++test_size 'shallow pack size' '
    ++	test_file_size out
    ++'
    ++
    ++test_perf 'shallow pack with --full-name-hash' '
    ++	git pack-objects --stdout --revs --sparse --shallow --full-name-hash <in-shallow >out
    ++'
    ++
    ++test_size 'shallow pack size with --full-name-hash' '
    ++	test_file_size out
    ++'
    ++
     +test_perf 'repack' '
     +	git repack -adf
     +'
-:  ----------- > 6:  b8a055cb196 pack-objects: disable --full-name-hash when shallow
6:  80ba362f256 = 7:  ab341dd0e58 test-tool: add helper for name-hash values


Derrick Stolee (7):
  pack-objects: add --full-name-hash option
  repack: add --full-name-hash option
  pack-objects: add GIT_TEST_FULL_NAME_HASH
  git-repack: update usage to match docs
  p5313: add size comparison test
  pack-objects: disable --full-name-hash when shallow
  test-tool: add helper for name-hash values

 Documentation/git-pack-objects.txt |  3 +-
 Documentation/git-repack.txt       |  4 +-
 Makefile                           |  1 +
 builtin/pack-objects.c             | 34 +++++++++--
 builtin/repack.c                   |  9 ++-
 ci/run-build-and-tests.sh          |  1 +
 pack-objects.h                     | 21 +++++++
 t/README                           |  4 ++
 t/helper/test-name-hash.c          | 24 ++++++++
 t/helper/test-tool.c               |  1 +
 t/helper/test-tool.h               |  1 +
 t/perf/p5313-pack-objects.sh       | 95 ++++++++++++++++++++++++++++++
 t/perf/p5314-name-hash.sh          | 41 +++++++++++++
 t/t0450/txt-help-mismatches        |  1 -
 t/t5300-pack-object.sh             | 15 +++++
 t/t5310-pack-bitmaps.sh            | 29 +++++++++
 t/t5333-pseudo-merge-bitmaps.sh    |  4 ++
 t/t5510-fetch.sh                   |  7 ++-
 t/t5616-partial-clone.sh           | 26 +++++++-
 t/t6020-bundle-misc.sh             |  6 +-
 t/t7406-submodule-update.sh        |  2 +
 t/t7700-repack.sh                  | 13 ++++
 t/test-lib-functions.sh            | 26 ++++++++
 23 files changed, 355 insertions(+), 13 deletions(-)
 create mode 100644 t/helper/test-name-hash.c
 create mode 100755 t/perf/p5313-pack-objects.sh
 create mode 100755 t/perf/p5314-name-hash.sh


base-commit: 8f8d6eee531b3fa1a8ef14f169b0cb5035f7a772
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1823%2Fderrickstolee%2Ffull-name-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1823/derrickstolee/full-name-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1823
-- 
gitgitgadget
