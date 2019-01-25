Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5ACBE1F453
	for <e@80x24.org>; Fri, 25 Jan 2019 23:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbfAYXuI (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 18:50:08 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41307 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfAYXuI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 18:50:08 -0500
Received: by mail-pl1-f196.google.com with SMTP id u6so5246254plm.8
        for <git@vger.kernel.org>; Fri, 25 Jan 2019 15:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BdATayqlgViQAm4wSsrg2dA3QvyAoWBI9kDknK44nMA=;
        b=mdLrSRBFf86lezANB2t7aqimBkNzwQoRvSVDzwwBr2/ke37Ug1b/4Dvlwg6ovAur2l
         2F7ftw3P0WzELOx74DERPuI263GXm3UISC3ZIjpondR/xNY+VeDR+5ncPNFgzKyD/c3Z
         8PhJzWl78j9Dd1QRhNzPzRdJdJZ6wgU14Mmbl3leARunOeda0SHeUo8dZDswbxeB9VNQ
         bsuvpJNWeQpNAMabD+WJuKqYvTMiAwWJOmVvHyWgEAMDyo6gBXotHcmzgCN2VBeNNenL
         GqDzouD2zT1GN29HD/GeuyT90p1nMsF25zULVZwz3vRVhVLGUfWYsdF7nPDX4BK+icTs
         jkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=BdATayqlgViQAm4wSsrg2dA3QvyAoWBI9kDknK44nMA=;
        b=p7DL4Zu2SiyeM56Kt8laUZcBN0AHebliv8qsaynjFQle4sY/dboo9kTCZlsNa5RNxT
         SYbSy2rTnoJahdg1bJkFSzRAu2a18SLP/VEk1wExgV1rEij3rB8W3qXJqqgnHDn4Tr9C
         hqj9+g1wI1chbpH3i8EOV9pUMDhxv50n1or2J4650NN/h3gWhgPIjXZtLqZlqjXIBuhK
         7R/W7ypLoNfbLemYOqIsiat1imO8Ehp9qKwxGPg8rRbuwANbGu33teBHSo1Sa/uZUBPp
         CKNXdUj8574H0hBDEBRMzAwxTd0lx16ZJkMtFt4CtGJ3oTa1LUISynMlztas76VqiGqp
         1Clw==
X-Gm-Message-State: AJcUukf+s17qFnlaMAKf3R2M+LqgO1gxgp3iKc3sdFv3XRXOz7+mGVr3
        1gPi7qa4ofqEWHuP3DdNyBM9aw==
X-Google-Smtp-Source: ALg8bN4H0xeGSMfYhJObGFBrs3TRgswacPuB/4du6SjKXi2LKruMW1WuIcyVwM6lCX171T2WpDjdMA==
X-Received: by 2002:a17:902:7201:: with SMTP id ba1mr12968515plb.105.1548460206568;
        Fri, 25 Jan 2019 15:50:06 -0800 (PST)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id m85sm41573290pfj.171.2019.01.25.15.50.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 15:50:05 -0800 (PST)
Date:   Fri, 25 Jan 2019 15:49:26 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        jrnieder@gmail.com, avarab@gmail.com, jonathantanmy@google.com,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 00/10] Create 'expire' and 'repack' verbs for
 git-multi-pack-index
Message-ID: <20190125234926.GD72177@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        jrnieder@gmail.com, avarab@gmail.com, jonathantanmy@google.com,
        Junio C Hamano <gitster@pobox.com>
References: <pull.92.v3.git.gitgitgadget@gmail.com>
 <pull.92.v4.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.92.v4.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.01.24 13:51, Derrick Stolee via GitGitGadget wrote:
> The multi-pack-index provides a fast way to find an object among a large
> list of pack-files. It stores a single pack-reference for each object id, so
> duplicate objects are ignored. Among a list of pack-files storing the same
> object, the most-recently modified one is used.
> 
> Create new subcommands for the multi-pack-index builtin.
> 
>  * 'git multi-pack-index expire': If we have a pack-file indexed by the
>    multi-pack-index, but all objects in that pack are duplicated in
>    more-recently modified packs, then delete that pack (and any others like
>    it). Delete the reference to that pack in the multi-pack-index.
>    
>    
>  * 'git multi-pack-index repack --batch-size=': Starting from the oldest
>    pack-files covered by the multi-pack-index, find those whose on-disk size
>    is below the batch size until we have a collection of packs whose sizes
>    add up to the batch size. Create a new pack containing all objects that
>    the multi-pack-index references to those packs.
>    
>    
> 
> This allows us to create a new pattern for repacking objects: run 'repack'.
> After enough time has passed that all Git commands that started before the
> last 'repack' are finished, run 'expire' again. This approach has some
> advantages over the existing "repack everything" model:
> 
>  1. Incremental. We can repack a small batch of objects at a time, instead
>     of repacking all reachable objects. We can also limit ourselves to the
>     objects that do not appear in newer pack-files.
>     
>     
>  2. Highly Available. By adding a new pack-file (and not deleting the old
>     pack-files) we do not interrupt concurrent Git commands, and do not
>     suffer performance degradation. By expiring only pack-files that have no
>     referenced objects, we know that Git commands that are doing normal
>     object lookups* will not be interrupted.
>     
>     
>  3. Note: if someone concurrently runs a Git command that uses
>     get_all_packs(), then that command could try to read the pack-files and
>     pack-indexes that we are deleting during an expire command. Such
>     commands are usually related to object maintenance (i.e. fsck, gc,
>     pack-objects) or are related to less-often-used features (i.e.
>     fast-import, http-backend, server-info).
>     
>     
> 
> We plan to use this approach in VFS for Git to do background maintenance of
> the "shared object cache" which is a Git alternate directory filled with
> packfiles containing commits and trees. We currently download pack-files on
> an hourly basis to keep up-to-date with the central server. The cache
> servers supply packs on an hourly and daily basis, so most of the hourly
> packs become useless after a new daily pack is downloaded. The 'expire'
> command would clear out most of those packs, but many will still remain with
> fewer than 100 objects remaining. The 'repack' command (with a batch size of
> 1-3gb, probably) can condense the remaining packs in commands that run for
> 1-3 min at a time. Since the daily packs range from 100-250mb, we will also
> combine and condense those packs.
> 
> Updates in V2:
> 
>  * Added a method, unlink_pack_path() to remove packfiles, but with the
>    additional check for a .keep file. This borrows logic from 
>    builtin/repack.c.
>    
>    
>  * Modified documentation and commit messages to replace 'verb' with
>    'subcommand'. Simplified the documentation. (I left 'verbs' in the title
>    of the cover letter for consistency.)
>    
>    
> 
> Updates in V3:
> 
>  * There was a bug in the expire logic when simultaneously removing packs
>    and adding uncovered packs, specifically around the pack permutation.
>    This was hard to see during review because I was using the 'pack_perm'
>    array for multiple purposes. First, I was reducing its length, and then I
>    was adding to it and resorting. In V3, I significantly overhauled the
>    logic here, which required some extra commits before implementing
>    'expire'. The final commit includes a test that would cover this case.
> 
> Updates in V4:
> 
>  * More 'verb' and 'command' instances replaced with 'subcommand'. I grepped
>    the patch to check these should be fixed everywhere.
>    
>    
>  * Update the tests to check .keep files (in last patch).
>    
>    
>  * Modify the tests to show the terminating condition of --batch-size when
>    there are three packs that fit under the size, but the first two are
>    large enough to stop adding packs. This required rearranging the packs
>    slightly to get different sizes than we had before. Also, I added 'touch
>    -t' to set the modified times so we can fix the order in which the packs
>    are selected.
>    
>    
>  * Added a comment about the purpose of pack_perm.
>    
>    
> 
> Thanks, -Stolee
> 
> Derrick Stolee (10):
>   repack: refactor pack deletion for future use
>   Docs: rearrange subcommands for multi-pack-index
>   multi-pack-index: prepare for 'expire' subcommand
>   midx: simplify computation of pack name lengths
>   midx: refactor permutation logic and pack sorting
>   multi-pack-index: implement 'expire' subcommand
>   multi-pack-index: prepare 'repack' subcommand
>   midx: implement midx_repack()
>   multi-pack-index: test expire while adding packs
>   midx: add test that 'expire' respects .keep files
> 
>  Documentation/git-multi-pack-index.txt |  26 +-
>  builtin/multi-pack-index.c             |  14 +-
>  builtin/repack.c                       |  14 +-
>  midx.c                                 | 399 ++++++++++++++++++-------
>  midx.h                                 |   2 +
>  packfile.c                             |  28 ++
>  packfile.h                             |   7 +
>  t/t5319-multi-pack-index.sh            | 165 ++++++++++
>  8 files changed, 536 insertions(+), 119 deletions(-)
> 
> 
> base-commit: 26aa9fc81d4c7f6c3b456a29da0b7ec72e5c6595
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-92%2Fderrickstolee%2Fmidx-expire%2Fupstream-v4
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-92/derrickstolee/midx-expire/upstream-v4
> Pull-Request: https://github.com/gitgitgadget/git/pull/92
> 
> Range-diff vs v3:
> 
>   1:  62b393b816 =  1:  62b393b816 repack: refactor pack deletion for future use
>   2:  7886785904 =  2:  7886785904 Docs: rearrange subcommands for multi-pack-index
>   3:  f06382b4ae !  3:  628ca46036 multi-pack-index: prepare for 'expire' subcommand
>      @@ -16,7 +16,9 @@
>           Add a test that verifies the 'expire' subcommand is correctly wired,
>           but will still be valid when the verb is implemented. Specifically,
>           create a set of packs that should all have referenced objects and
>      -    should not be removed during an 'expire' operation.
>      +    should not be removed during an 'expire' operation. The packs are
>      +    created carefully to ensure they have a specific order when sorted
>      +    by size. This will be important in a later test.
>       
>           Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>       
>      @@ -95,6 +97,8 @@
>       +	(
>       +		cd dup &&
>       +		git init &&
>      ++		test-tool genrandom "data" 4096 >large_file.txt &&
>      ++		git update-index --add large_file.txt &&
>       +		for i in $(test_seq 1 20)
>       +		do
>       +			test_commit $i
>      @@ -104,24 +108,24 @@
>       +		git branch C HEAD~13 &&
>       +		git branch D HEAD~16 &&
>       +		git branch E HEAD~18 &&
>      -+		git pack-objects --revs .git/objects/pack/pack-E <<-EOF &&
>      -+		refs/heads/E
>      ++		git pack-objects --revs .git/objects/pack/pack-A <<-EOF &&
>      ++		refs/heads/A
>      ++		^refs/heads/B
>       +		EOF
>      -+		git pack-objects --revs .git/objects/pack/pack-D <<-EOF &&
>      -+		refs/heads/D
>      -+		^refs/heads/E
>      ++		git pack-objects --revs .git/objects/pack/pack-B <<-EOF &&
>      ++		refs/heads/B
>      ++		^refs/heads/C
>       +		EOF
>       +		git pack-objects --revs .git/objects/pack/pack-C <<-EOF &&
>       +		refs/heads/C
>       +		^refs/heads/D
>       +		EOF
>      -+		git pack-objects --revs .git/objects/pack/pack-B <<-EOF &&
>      -+		refs/heads/B
>      -+		^refs/heads/C
>      ++		git pack-objects --revs .git/objects/pack/pack-D <<-EOF &&
>      ++		refs/heads/D
>      ++		^refs/heads/E
>       +		EOF
>      -+		git pack-objects --revs .git/objects/pack/pack-A <<-EOF &&
>      -+		refs/heads/A
>      -+		^refs/heads/B
>      ++		git pack-objects --revs .git/objects/pack/pack-E <<-EOF &&
>      ++		refs/heads/E
>       +		EOF
>       +		git multi-pack-index write
>       +	)
>   4:  2a763990ae !  4:  d55c1d7ee7 midx: simplify computation of pack name lengths
>      @@ -12,7 +12,7 @@
>           dir not already covered by the multi-pack-index.
>       
>           In anticipation of this becoming more complicated with the 'expire'
>      -    command, simplify the computation by centralizing it to a single
>      +    subcommand, simplify the computation by centralizing it to a single
>           loop before writing the file.
>       
>           Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>   5:  a0d4cc6cb3 !  5:  3950743b96 midx: refactor permutation logic and pack sorting
>      @@ -282,6 +282,12 @@
>        
>       +	QSORT(packs.info, packs.nr, pack_info_compare);
>       +
>      ++	/*
>      ++	 * pack_perm stores a permutation between pack-int-ids from the
>      ++	 * previous multi-pack-index to the new one we are writing:
>      ++	 *
>      ++	 * pack_perm[old_id] = new_id
>      ++	 */
>       +	ALLOC_ARRAY(pack_perm, packs.nr);
>       +	for (i = 0; i < packs.nr; i++) {
>       +		pack_perm[packs.info[i].orig_pack_int_id] = i;
>   6:  4dbff40e7a !  6:  6691d97902 multi-pack-index: implement 'expire' verb
>      @@ -1,8 +1,8 @@
>       Author: Derrick Stolee <dstolee@microsoft.com>
>       
>      -    multi-pack-index: implement 'expire' verb
>      +    multi-pack-index: implement 'expire' subcommand
>       
>      -    The 'git multi-pack-index expire' command looks at the existing
>      +    The 'git multi-pack-index expire' subcommand looks at the existing
>           mult-pack-index, counts the number of objects referenced in each
>           pack-file, deletes the pack-fils with no referenced objects, and
>           rewrites the multi-pack-index to no longer reference those packs.
>      @@ -18,7 +18,7 @@
>       
>           Test that a new pack-file that covers the contents of two other
>           pack-files leads to those pack-files being deleted during the
>      -    expire command. Be sure to read the multi-pack-index to ensure
>      +    expire subcommand. Be sure to read the multi-pack-index to ensure
>           it no longer references those packs.
>       
>           Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>      @@ -161,6 +161,11 @@
>       +		}
>       +	}
>       +
>      + 	/*
>      + 	 * pack_perm stores a permutation between pack-int-ids from the
>      + 	 * previous multi-pack-index to the new one we are writing:
>      +@@
>      + 	 */
>        	ALLOC_ARRAY(pack_perm, packs.nr);
>        	for (i = 0; i < packs.nr; i++) {
>       -		pack_perm[packs.info[i].orig_pack_int_id] = i;
>      @@ -273,7 +278,9 @@
>       +		test_cmp expect actual &&
>       +		ls .git/objects/pack/ | grep idx >expect-idx &&
>       +		test-tool read-midx .git/objects | grep idx >actual-midx &&
>      -+		test_cmp expect-idx actual-midx
>      ++		test_cmp expect-idx actual-midx &&
>      ++		git multi-pack-index verify &&
>      ++		git fsck
>       +	)
>       +'
>       +
>   7:  b39f90ad09 !  7:  f5a8ff21dd multi-pack-index: prepare 'repack' subcommand
>      @@ -11,7 +11,7 @@
>           operation does not interrupt concurrent git commands.
>       
>           Introduce a 'repack' subcommand to 'git multi-pack-index' that
>      -    takes a '--batch-size' option. The verb will inspect the
>      +    takes a '--batch-size' option. The subcommand will inspect the
>           multi-pack-index for referenced pack-files whose size is smaller
>           than the batch size, until collecting a list of pack-files whose
>           sizes sum to larger than the batch size. Then, a new pack-file
>      @@ -26,6 +26,11 @@
>           we specify a small batch size, we will guarantee that future
>           implementations do not change the list of pack-files.
>       
>      +    In addition, we hard-code the modified times of the packs in
>      +    the pack directory to ensure the list of packs sorted by modified
>      +    time matches the order if sorted by size (ascending). This will
>      +    be important in a future test.
>      +
>           Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>       
>        diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
>      @@ -36,15 +41,15 @@
>        	afterward to remove all references to these pack-files.
>        
>       +repack::
>      -+	Collect a batch of pack-files whose size are all at most the
>      -+	size given by --batch-size, but whose sizes sum to larger
>      -+	than --batch-size. The batch is selected by greedily adding
>      -+	small pack-files starting with the oldest pack-files that fit
>      -+	the size. Create a new pack-file containing the objects the
>      -+	multi-pack-index indexes into those pack-files, and rewrite
>      -+	the multi-pack-index to contain that pack-file. A later run
>      -+	of 'git multi-pack-index expire' will delete the pack-files
>      -+	that were part of this batch.
>      ++	Create a new pack-file containing objects in small pack-files
>      ++	referenced by the multi-pack-index. Select the pack-files by
>      ++	examining packs from oldest-to-newest, adding a pack if its
>      ++	size is below the batch size. Stop adding packs when the sum
>      ++	of sizes of the added packs is above the batch size. If the
>      ++	total size does not reach the batch size, then do nothing.
>      ++	Rewrite the multi-pack-index to reference the new pack-file.
>      ++	A later run of 'git multi-pack-index expire' will delete the
>      ++	pack-files that were part of this batch.
>       +
>        
>        EXAMPLES
>      @@ -84,11 +89,18 @@
>       +	if (!strcmp(argv[0], "repack"))
>       +		return midx_repack(opts.object_dir, (size_t)opts.batch_size);
>       +	if (opts.batch_size)
>      -+		die(_("--batch-size option is only for 'repack' verb"));
>      ++		die(_("--batch-size option is only for 'repack' subcommand"));
>       +
>        	if (!strcmp(argv[0], "write"))
>        		return write_midx_file(opts.object_dir);
>        	if (!strcmp(argv[0], "verify"))
>      +@@
>      + 	if (!strcmp(argv[0], "expire"))
>      + 		return expire_midx_packs(opts.object_dir);
>      + 
>      +-	die(_("unrecognized verb: %s"), argv[0]);
>      ++	die(_("unrecognized subcommand: %s"), argv[0]);
>      + }
>       
>        diff --git a/midx.c b/midx.c
>        --- a/midx.c
>      @@ -125,6 +137,12 @@
>       +test_expect_success 'repack with minimum size does not alter existing packs' '
>       +	(
>       +		cd dup &&
>      ++		rm -rf .git/objects/pack &&
>      ++		mv .git/objects/pack-backup .git/objects/pack &&
>      ++		touch -m -t 201901010000 .git/objects/pack/pack-D* &&
>      ++		touch -m -t 201901010001 .git/objects/pack/pack-C* &&
>      ++		touch -m -t 201901010002 .git/objects/pack/pack-B* &&
>      ++		touch -m -t 201901010003 .git/objects/pack/pack-A* &&
>       +		ls .git/objects/pack >expect &&
>       +		MINSIZE=$(ls -l .git/objects/pack/*pack | awk "{print \$5;}" | sort -n | head -n 1) &&
>       +		git multi-pack-index repack --batch-size=$MINSIZE &&
>   8:  a4c2d5a8e1 !  8:  ba1a1c7bbb midx: implement midx_repack()
>      @@ -149,6 +149,16 @@
>        diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
>        --- a/t/t5319-multi-pack-index.sh
>        +++ b/t/t5319-multi-pack-index.sh
>      +@@
>      + 		git pack-objects --revs .git/objects/pack/pack-E <<-EOF &&
>      + 		refs/heads/E
>      + 		EOF
>      +-		git multi-pack-index write
>      ++		git multi-pack-index write &&
>      ++		cp -r .git/objects/pack .git/objects/pack-backup
>      + 	)
>      + '
>      + 
>       @@
>        	)
>        '
>      @@ -156,25 +166,28 @@
>       +test_expect_success 'repack creates a new pack' '
>       +	(
>       +		cd dup &&
>      -+		SECOND_SMALLEST_SIZE=$(ls -l .git/objects/pack/*pack | awk "{print \$5;}" | sort -n | head -n 2 | tail -n 1) &&
>      -+		BATCH_SIZE=$(($SECOND_SMALLEST_SIZE + 1)) &&
>      -+		git multi-pack-index repack --batch-size=$BATCH_SIZE &&
>       +		ls .git/objects/pack/*idx >idx-list &&
>       +		test_line_count = 5 idx-list &&
>      ++		THIRD_SMALLEST_SIZE=$(ls -l .git/objects/pack/*pack | awk "{print \$5;}" | sort -n | head -n 3 | tail -n 1) &&
>      ++		BATCH_SIZE=$(($THIRD_SMALLEST_SIZE + 1)) &&
>      ++		git multi-pack-index repack --batch-size=$BATCH_SIZE &&
>      ++		ls .git/objects/pack/*idx >idx-list &&
>      ++		test_line_count = 6 idx-list &&
>       +		test-tool read-midx .git/objects | grep idx >midx-list &&
>      -+		test_line_count = 5 midx-list
>      ++		test_line_count = 6 midx-list
>       +	)
>       +'
>       +
>       +test_expect_success 'expire removes repacked packs' '
>       +	(
>       +		cd dup &&
>      -+		ls -S .git/objects/pack/*pack | head -n 3 >expect &&
>      ++		ls -al .git/objects/pack/*pack &&
>      ++		ls -S .git/objects/pack/*pack | head -n 4 >expect &&
>       +		git multi-pack-index expire &&
>       +		ls -S .git/objects/pack/*pack >actual &&
>       +		test_cmp expect actual &&
>       +		test-tool read-midx .git/objects | grep idx >midx-list &&
>      -+		test_line_count = 3 midx-list
>      ++		test_line_count = 4 midx-list
>       +	)
>       +'
>       +
>   9:  b97fb35ba9 =  9:  b1c6892417 multi-pack-index: test expire while adding packs
>   -:  ---------- > 10:  481b08890f midx: add test that 'expire' respects .keep files
> 
> -- 
> gitgitgadget

With the exception of the broken test in patch 7, and some minor style
diffs, this all looks good to me.
