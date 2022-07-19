Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C1BC433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 15:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238978AbiGSP0M (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 11:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238776AbiGSP0L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 11:26:11 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0358B47B9F
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 08:26:10 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id v67-20020a1cac46000000b003a1888b9d36so12214482wme.0
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 08:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=s26XgT78t8dvVXlYeuOcsk/cEfqrRystrfLhfH1m7x0=;
        b=PySEKtDRo6E2ZKv3nQTFbnIjsA9BDqTDuCCD/xyG9cetvxkdoNmFu+76444rZx0L8v
         G4XpnFnqjvjpzS8YaPoRHd4DoTx9BwLc2nuKyDoqTP978bJelD6gr8FZBM7f2bPU1Kp0
         yPkf7qAjzav6+9Z2prIDq2WOXiP7Tw7FFMz00sodzHQ8OJzM+7y7RFvWXKSE8qY3oU1j
         sMgkZ6mG4S/kBVvPxy/2Iwk12+sq9VRVNm/QjDs8GwWzw3m55NEsfb/UCn0tfLMtNOCb
         pksaANUjTLtrp3YyCEk4FLv9R9Jjwzp8Vhw9CNFYivKRdYR4V198yQnOQgQ+y7V9oB2G
         u1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=s26XgT78t8dvVXlYeuOcsk/cEfqrRystrfLhfH1m7x0=;
        b=teOA/e2BmaFp2CIBHxUop1qQqQ4+dk1y574BhUXkqznbTqAwo+sl3QUVGJF13++6v3
         5c6PiMYbIFXwDUSwbSmsvT2AgnSJPAsejzlslyyI1w2JQZpsSjW3pZuFIZ0UfdFgZWKj
         /eDUoJQMOrHZ2GmTwMKAHjAIsYE45GU1UzbT9WyztkeD1v8oTtEd+L4uZ0YYBSExYZI3
         1zzyKgj1G8NzEc+/Xq92BsRTk9Yrk6R0l6tJRz9dc1fMGvtEPhYdnNDgPuGxvzyykrSE
         5pMGPF+KEtz6zPclO67SS2Bca2Bf/QnkSgQYkviWcxLxcu//uSAAlaKA6CGk5/6W6k/s
         yeCw==
X-Gm-Message-State: AJIora+gVKj4bdEq9Toc6P8H4cyy2VQIGb6fRwKT3U+w4iSiEBzWiMdp
        yaApRX78iRD0bodlFAcAYVabrFc5Kbs=
X-Google-Smtp-Source: AGRyM1uW9nz9MrP6ESFu/NpbzJaEcT7jqRunDwY/jGmxOSBdQzpHb2Je6xPcYoDTKh52Vr4b62JeoA==
X-Received: by 2002:a05:600c:148:b0:3a3:2753:e551 with SMTP id w8-20020a05600c014800b003a32753e551mr1091956wmm.131.1658244367941;
        Tue, 19 Jul 2022 08:26:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j9-20020a05600c190900b003a2fde6ef62sm21001169wmq.7.2022.07.19.08.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 08:26:07 -0700 (PDT)
Message-Id: <pull.1292.v2.git.1658244366.gitgitgadget@gmail.com>
In-Reply-To: <pull.1292.git.1658176565751.gitgitgadget@gmail.com>
References: <pull.1292.git.1658176565751.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Jul 2022 15:26:03 +0000
Subject: [PATCH v2 0/3] midx: reduce memory pressure while writing bitmaps
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        chakrabortyabhradeep79@gmail.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We noticed an instance where writing multi-pack-index bitmaps was taking a
lot of memory. This small change can reduce the memory pressure slightly
(~25%), but more will be needed to significantly reduce the memory pressure.
Such a change would require updating the bitmap writing code to use on-disk
data structures instead. This is particularly tricky when the
multi-pack-index has not been fully written, because we don't want a point
in time where the object store has a new multi-pack-index without a
reachability bitmap.


Updates in v2
=============

To reduce confusion on the lifetime of 'ctx.entries', some refactoring
patches are inserted to first extract the use of 'ctx' out of
write_midx_bitmap() and into write_midx_internal(). This makes the
FREE_AND_NULL() stand out more clearly.

Thanks, -Stolee

Derrick Stolee (3):
  pack-bitmap-write: use const for hashes
  midx: extract bitmap write setup
  midx: reduce memory pressure while writing bitmaps

 midx.c              | 69 +++++++++++++++++++++++++++++----------------
 pack-bitmap-write.c |  2 +-
 pack-bitmap.h       |  2 +-
 3 files changed, 47 insertions(+), 26 deletions(-)


base-commit: 9dd64cb4d310986dd7b8ca7fff92f9b61e0bd21a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1292%2Fderrickstolee%2Fbitmap-memory-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1292/derrickstolee/bitmap-memory-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1292

Range-diff vs v1:

 -:  ----------- > 1:  a09fdbb8f3e pack-bitmap-write: use const for hashes
 1:  9104bc55795 ! 2:  4dfb7ae5112 midx:  reduce memory pressure while writing bitmaps
     @@ Metadata
      Author: Derrick Stolee <derrickstolee@github.com>
      
       ## Commit message ##
     -    midx:  reduce memory pressure while writing bitmaps
     +    midx: extract bitmap write setup
      
     -    We noticed that some 'git multi-pack-index write --bitmap' processes
     -    were running with very high memory. It turns out that a lot of this
     -    memory is required to store a list of every object in the written
     -    multi-pack-index, with a second copy that has additional information
     -    used for the bitmap writing logic.
     +    The write_midx_bitmap() method is a long method that does a lot of
     +    steps. It requires the write_midx_context struct for use in
     +    prepare_midx_packing_data() and find_commits_for_midx_bitmap(), but
     +    after that only needs the pack_order array.
      
     -    Using 'valgrind --tool=massif' before this change, the following chart
     -    shows how memory load increased and was maintained throughout the
     -    process:
     -
     -        GB
     -    4.102^                                                             ::
     -         |              @  @::@@::@@::::::::@::::::@@:#:::::::::::::@@:: :
     -         |         :::::@@:@: @ ::@ ::: ::::@: ::: @@:#:::::: :: : :@ :: :
     -         |      :::: :: @@:@: @ ::@ ::: ::::@: ::: @@:#:::::: :: : :@ :: :
     -         |    :::: : :: @@:@: @ ::@ ::: ::::@: ::: @@:#:::::: :: : :@ :: :
     -         |    : :: : :: @@:@: @ ::@ ::: ::::@: ::: @@:#:::::: :: : :@ :: :
     -         |    : :: : :: @@:@: @ ::@ ::: ::::@: ::: @@:#:::::: :: : :@ :: :
     -         |   :: :: : :: @@:@: @ ::@ ::: ::::@: ::: @@:#:::::: :: : :@ :: :
     -         |   :: :: : :: @@:@: @ ::@ ::: ::::@: ::: @@:#:::::: :: : :@ :: :
     -         |   :: :: : :: @@:@: @ ::@ ::: ::::@: ::: @@:#:::::: :: : :@ :: :
     -         |   :: :: : :: @@:@: @ ::@ ::: ::::@: ::: @@:#:::::: :: : :@ :: :
     -         |   :: :: : :: @@:@: @ ::@ ::: ::::@: ::: @@:#:::::: :: : :@ :: :
     -         |   :: :: : :: @@:@: @ ::@ ::: ::::@: ::: @@:#:::::: :: : :@ :: :
     -         |   :: :: : :: @@:@: @ ::@ ::: ::::@: ::: @@:#:::::: :: : :@ :: :
     -         | @ :: :: : :: @@:@: @ ::@ ::: ::::@: ::: @@:#:::::: :: : :@ :: :
     -         | @ :: :: : :: @@:@: @ ::@ ::: ::::@: ::: @@:#:::::: :: : :@ :: :
     -         | @::: :: : :: @@:@: @ ::@ ::: ::::@: ::: @@:#:::::: :: : :@ :: :
     -         | @::: :: : :: @@:@: @ ::@ ::: ::::@: ::: @@:#:::::: :: : :@ :: :
     -         | @::: :: : :: @@:@: @ ::@ ::: ::::@: ::: @@:#:::::: :: : :@ :: :
     -         | @::: :: : :: @@:@: @ ::@ ::: ::::@: ::: @@:#:::::: :: : :@ :: :
     -       0 +--------------------------------------------------------------->
     -
     -    It turns out that the 'struct write_midx_context' data is persisting
     -    through the life of the process, including the 'entries' array. This
     -    array is used last inside find_commits_for_midx_bitmap() within
     -    write_midx_bitmap(). If we free (and nullify) the array at that point,
     -    we can free a decent chunk of memory before the bitmap logic adds more
     -    to the memory footprint.
     -
     -    Here is the massif memory load chart after this change:
     -
     -        GB
     -    3.111^      #
     -         |      #                              :::::::::::@::::::::::::::@
     -         |      #        ::::::::::::::::::::::::: : :: : @:: ::::: :: ::@
     -         |     @#  :::::::::::: :::: :: : :::::::: : :: : @:: ::::: :: ::@
     -         |     @#::: ::: :::::: :::: :: : :::::::: : :: : @:: ::::: :: ::@
     -         |     @#::: ::: :::::: :::: :: : :::::::: : :: : @:: ::::: :: ::@
     -         |     @#::: ::: :::::: :::: :: : :::::::: : :: : @:: ::::: :: ::@
     -         |     @#::: ::: :::::: :::: :: : :::::::: : :: : @:: ::::: :: ::@
     -         |     @#::: ::: :::::: :::: :: : :::::::: : :: : @:: ::::: :: ::@
     -         |     @#::: ::: :::::: :::: :: : :::::::: : :: : @:: ::::: :: ::@
     -         |     @#::: ::: :::::: :::: :: : :::::::: : :: : @:: ::::: :: ::@
     -         |     @#::: ::: :::::: :::: :: : :::::::: : :: : @:: ::::: :: ::@
     -         |     @#::: ::: :::::: :::: :: : :::::::: : :: : @:: ::::: :: ::@
     -         |     @#::: ::: :::::: :::: :: : :::::::: : :: : @:: ::::: :: ::@
     -         |     @#::: ::: :::::: :::: :: : :::::::: : :: : @:: ::::: :: ::@
     -         |     @#::: ::: :::::: :::: :: : :::::::: : :: : @:: ::::: :: ::@
     -         |  :::@#::: ::: :::::: :::: :: : :::::::: : :: : @:: ::::: :: ::@
     -         |  :: @#::: ::: :::::: :::: :: : :::::::: : :: : @:: ::::: :: ::@
     -         |  :: @#::: ::: :::::: :::: :: : :::::::: : :: : @:: ::::: :: ::@
     -         |  :: @#::: ::: :::::: :::: :: : :::::::: : :: : @:: ::::: :: ::@
     -       0 +--------------------------------------------------------------->
     -
     -    It is unfortunate that the lifetime of the 'entries' array is less
     -    clear. To make this simpler, I added a few things to try and prevent an
     -    accidental reference:
     -
     -     1. Using FREE_AND_NULL() we will at least get a segfault from reading a
     -        NULL pointer instead of a use-after-free.
     -
     -     2. 'entries_nr' is also set to zero to make any loop that would iterate
     -        over the entries be trivial.
     -
     -     3. Set the 'ctx' pointer to NULL within write_midx_bitmap() so it does
     -        not get another reference later. This requires adding a local copy
     -        of 'pack_order' giving us a reference that we can use later in the
     -        method.
     -
     -     4. Add significant comments in write_midx_bitmap() and
     -        write_midx_internal() to add warnings for future authors who might
     -        accidentally add references to this cleared memory.
     +    This is a messy, but completely non-functional refactoring. The code is
     +    only being moved around to reduce visibility of the write_midx_context
     +    during the longest part of computing reachability bitmaps.
      
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
       ## midx.c ##
     -@@ midx.c: static int write_midx_bitmap(char *midx_name, unsigned char *midx_hash,
     - 	struct commit **commits = NULL;
     - 	uint32_t i, commits_nr;
     - 	uint16_t options = 0;
     -+	uint32_t *pack_order;
     - 	char *bitmap_name = xstrfmt("%s-%s.bitmap", midx_name, hash_to_hex(midx_hash));
     - 	int ret;
     +@@ midx.c: static struct commit **find_commits_for_midx_bitmap(uint32_t *indexed_commits_nr
     + 	return cb.commits;
     + }
       
     -@@ midx.c: static int write_midx_bitmap(char *midx_name, unsigned char *midx_hash,
     +-static int write_midx_bitmap(char *midx_name, unsigned char *midx_hash,
     +-			     struct write_midx_context *ctx,
     ++static int write_midx_bitmap(const char *midx_name,
     ++			     const unsigned char *midx_hash,
     ++			     struct packing_data *pdata,
     ++			     struct commit **commits,
     ++			     uint32_t commits_nr,
     ++			     uint32_t *pack_order,
     + 			     const char *refs_snapshot,
     + 			     unsigned flags)
     + {
     +-	struct packing_data pdata;
     +-	struct pack_idx_entry **index;
     +-	struct commit **commits = NULL;
     +-	uint32_t i, commits_nr;
     ++	int ret, i;
     + 	uint16_t options = 0;
     +-	char *bitmap_name = xstrfmt("%s-%s.bitmap", midx_name, hash_to_hex(midx_hash));
     +-	int ret;
     +-
     +-	if (!ctx->entries_nr)
     +-		BUG("cannot write a bitmap without any objects");
     ++	struct pack_idx_entry **index;
     ++	char *bitmap_name = xstrfmt("%s-%s.bitmap", midx_name,
     ++					hash_to_hex(midx_hash));
       
     - 	commits = find_commits_for_midx_bitmap(&commits_nr, refs_snapshot, ctx);
     + 	if (flags & MIDX_WRITE_BITMAP_HASH_CACHE)
     + 		options |= BITMAP_OPT_HASH_CACHE;
       
     -+	/*
     -+	 * Remove the ctx.entries to reduce memory pressure.
     -+	 * Nullify 'ctx' to help avoid adding new references to ctx->entries.
     -+	 */
     -+	FREE_AND_NULL(ctx->entries);
     -+	ctx->entries_nr = 0;
     -+	pack_order = ctx->pack_order;
     -+	ctx = NULL;
     -+
     +-	prepare_midx_packing_data(&pdata, ctx);
     +-
     +-	commits = find_commits_for_midx_bitmap(&commits_nr, refs_snapshot, ctx);
     +-
       	/*
       	 * Build the MIDX-order index based on pdata.objects (which is already
       	 * in MIDX order; c.f., 'midx_pack_order_cmp()' for the definition of
     + 	 * this order).
     + 	 */
     +-	ALLOC_ARRAY(index, pdata.nr_objects);
     +-	for (i = 0; i < pdata.nr_objects; i++)
     +-		index[i] = &pdata.objects[i].idx;
     ++	ALLOC_ARRAY(index, pdata->nr_objects);
     ++	for (i = 0; i < pdata->nr_objects; i++)
     ++		index[i] = &pdata->objects[i].idx;
     + 
     + 	bitmap_writer_show_progress(flags & MIDX_PROGRESS);
     +-	bitmap_writer_build_type_index(&pdata, index, pdata.nr_objects);
     ++	bitmap_writer_build_type_index(pdata, index, pdata->nr_objects);
     + 
     + 	/*
     + 	 * bitmap_writer_finish expects objects in lex order, but pack_order
      @@ midx.c: static int write_midx_bitmap(char *midx_name, unsigned char *midx_hash,
     + 	 * happens between bitmap_writer_build_type_index() and
       	 * bitmap_writer_finish().
       	 */
     - 	for (i = 0; i < pdata.nr_objects; i++)
     +-	for (i = 0; i < pdata.nr_objects; i++)
      -		index[ctx->pack_order[i]] = &pdata.objects[i].idx;
     -+		index[pack_order[i]] = &pdata.objects[i].idx;
     ++	for (i = 0; i < pdata->nr_objects; i++)
     ++		index[pack_order[i]] = &pdata->objects[i].idx;
       
       	bitmap_writer_select_commits(commits, commits_nr, -1);
     - 	ret = bitmap_writer_build(&pdata);
     +-	ret = bitmap_writer_build(&pdata);
     ++	ret = bitmap_writer_build(pdata);
     + 	if (ret < 0)
     + 		goto cleanup;
     + 
     + 	bitmap_writer_set_checksum(midx_hash);
     +-	bitmap_writer_finish(index, pdata.nr_objects, bitmap_name, options);
     ++	bitmap_writer_finish(index, pdata->nr_objects, bitmap_name, options);
     + 
     + cleanup:
     + 	free(index);
      @@ midx.c: static int write_midx_internal(const char *object_dir,
       	if (flags & MIDX_WRITE_REV_INDEX &&
       	    git_env_bool("GIT_TEST_MIDX_WRITE_REV", 0))
       		write_midx_reverse_index(midx_name.buf, midx_hash, &ctx);
      +
     -+	/*
     -+	 * Writing the bitmap must be last, as it will free ctx.entries
     -+	 * to reduce memory pressure during the bitmap write.
     -+	 */
       	if (flags & MIDX_WRITE_BITMAP) {
     - 		if (write_midx_bitmap(midx_name.buf, midx_hash, &ctx,
     +-		if (write_midx_bitmap(midx_name.buf, midx_hash, &ctx,
     ++		struct packing_data pdata;
     ++		struct commit **commits;
     ++		uint32_t commits_nr;
     ++
     ++		if (!ctx.entries_nr)
     ++			BUG("cannot write a bitmap without any objects");
     ++
     ++		prepare_midx_packing_data(&pdata, &ctx);
     ++
     ++		commits = find_commits_for_midx_bitmap(&commits_nr, refs_snapshot, &ctx);
     ++
     ++		if (write_midx_bitmap(midx_name.buf, midx_hash, &pdata,
     ++				      commits, commits_nr, ctx.pack_order,
       				      refs_snapshot, flags) < 0) {
     + 			error(_("could not write multi-pack bitmap"));
     + 			result = 1;
 -:  ----------- > 3:  98e72f71b6b midx: reduce memory pressure while writing bitmaps

-- 
gitgitgadget
