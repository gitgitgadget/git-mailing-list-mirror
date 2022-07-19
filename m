Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67473C433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 15:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239310AbiGSP0h (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 11:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238263AbiGSP0W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 11:26:22 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36104E879
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 08:26:13 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id r1-20020a05600c35c100b003a326685e7cso676168wmq.1
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 08:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tD3JE1An8MKdjZpK024W+LQGEwJuZTKrnjqH91Cqw5Y=;
        b=X+822jOPtkLLQXDwFNQ/WQ+vUI3BloJC4x67ECXNGfqL9WAxVqAc4jjeDTJdDDJDMz
         hTN39SXqDfJgarq2AEzGrAr+5+pyDKvZ+K4zr7cv2YuQ47S9mSj0CVtsbETxZ2wUMh7a
         q7jxKVenSmUIqbpzpEMPjowUj3VR81UGMipnKy6Cxw1bUPMioNtaXNXRhf7z74lXXL7D
         /+mbIE/thiU9hOF2prr3Q33MdKGiNmBqSzaLBBAUcMB7T714h//uk14zX5foOOXaxOaZ
         0Kkrojt/I7ANm7efeQvn0RMRTYZ+v+jEpIlH4t+cSJagPre4ZOucOPQYjCAPfnwFv1Jb
         Mnaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tD3JE1An8MKdjZpK024W+LQGEwJuZTKrnjqH91Cqw5Y=;
        b=JgFqzAKbmhF2rVx9bSV4yglj5hcj7lOGKSIvKSD9tE3F13vxrbrP7zKfk7RoF/+QPL
         MPmIIF0bsZHyVemAjc8rlSXDoYDNxLTGMpdOHRK+/Y7mJkzkLEsOwQagfc2TyVYG2n+T
         v6OsEwPiaIct/wspzc52ow8Q1a6/xuZ34HWqCsDrVTzTp9sGtauzr+TIXsL+u9y1bZNY
         R0GkkqlH3a+fu4bT0yVr6HDEYUu7rQk0OcKNIcLDh3XBM+cRd3WsxhJ0pk0DEYNQbuVL
         0FioThaNe+l19/vqMpD/W/swyzuWqtqPho//h1NbGgmqcY216VS82cglI92oui799Zs+
         Ke7g==
X-Gm-Message-State: AJIora+KPiDDIusc4nBhjgT9kmcszTj5+19n+Oh3G3Y91vLMh1UqocEz
        h14+kZWB006F36VhGoUNie/lcOo/jH8=
X-Google-Smtp-Source: AGRyM1sgv2radMGEA5wqw8rwdoEgz35CaVrZ1MFiQEfKEN3mlkm2fweABBupYgfhtBpqihEQod75Uw==
X-Received: by 2002:a05:600c:2d09:b0:3a3:1062:ce61 with SMTP id x9-20020a05600c2d0900b003a31062ce61mr18038860wmf.138.1658244371834;
        Tue, 19 Jul 2022 08:26:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d16-20020a05600c049000b0039c96b97359sm18478899wme.37.2022.07.19.08.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 08:26:11 -0700 (PDT)
Message-Id: <98e72f71b6bec6f5c2df4139ca3df37d97ddcf54.1658244366.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1292.v2.git.1658244366.gitgitgadget@gmail.com>
References: <pull.1292.git.1658176565751.gitgitgadget@gmail.com>
        <pull.1292.v2.git.1658244366.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Jul 2022 15:26:06 +0000
Subject: [PATCH v2 3/3] midx: reduce memory pressure while writing bitmaps
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        chakrabortyabhradeep79@gmail.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

We noticed that some 'git multi-pack-index write --bitmap' processes
were running with very high memory. It turns out that a lot of this
memory is required to store a list of every object in the written
multi-pack-index, with a second copy that has additional information
used for the bitmap writing logic.

Using 'valgrind --tool=massif' before this change, the following chart
shows how memory load increased and was maintained throughout the
process:

    GB
4.102^                                                             ::
     |              @  @::@@::@@::::::::@::::::@@:#:::::::::::::@@:: :
     |         :::::@@:@: @ ::@ ::: ::::@: ::: @@:#:::::: :: : :@ :: :
     |      :::: :: @@:@: @ ::@ ::: ::::@: ::: @@:#:::::: :: : :@ :: :
     |    :::: : :: @@:@: @ ::@ ::: ::::@: ::: @@:#:::::: :: : :@ :: :
     |    : :: : :: @@:@: @ ::@ ::: ::::@: ::: @@:#:::::: :: : :@ :: :
     |    : :: : :: @@:@: @ ::@ ::: ::::@: ::: @@:#:::::: :: : :@ :: :
     |   :: :: : :: @@:@: @ ::@ ::: ::::@: ::: @@:#:::::: :: : :@ :: :
     |   :: :: : :: @@:@: @ ::@ ::: ::::@: ::: @@:#:::::: :: : :@ :: :
     |   :: :: : :: @@:@: @ ::@ ::: ::::@: ::: @@:#:::::: :: : :@ :: :
     |   :: :: : :: @@:@: @ ::@ ::: ::::@: ::: @@:#:::::: :: : :@ :: :
     |   :: :: : :: @@:@: @ ::@ ::: ::::@: ::: @@:#:::::: :: : :@ :: :
     |   :: :: : :: @@:@: @ ::@ ::: ::::@: ::: @@:#:::::: :: : :@ :: :
     |   :: :: : :: @@:@: @ ::@ ::: ::::@: ::: @@:#:::::: :: : :@ :: :
     | @ :: :: : :: @@:@: @ ::@ ::: ::::@: ::: @@:#:::::: :: : :@ :: :
     | @ :: :: : :: @@:@: @ ::@ ::: ::::@: ::: @@:#:::::: :: : :@ :: :
     | @::: :: : :: @@:@: @ ::@ ::: ::::@: ::: @@:#:::::: :: : :@ :: :
     | @::: :: : :: @@:@: @ ::@ ::: ::::@: ::: @@:#:::::: :: : :@ :: :
     | @::: :: : :: @@:@: @ ::@ ::: ::::@: ::: @@:#:::::: :: : :@ :: :
     | @::: :: : :: @@:@: @ ::@ ::: ::::@: ::: @@:#:::::: :: : :@ :: :
   0 +--------------------------------------------------------------->

It turns out that the 'struct write_midx_context' data is persisting
through the life of the process, including the 'entries' array. This
array is used last inside find_commits_for_midx_bitmap() within
write_midx_bitmap(). If we free (and nullify) the array at that point,
we can free a decent chunk of memory before the bitmap logic adds more
to the memory footprint.

Here is the massif memory load chart after this change:

    GB
3.111^      #
     |      #                              :::::::::::@::::::::::::::@
     |      #        ::::::::::::::::::::::::: : :: : @:: ::::: :: ::@
     |     @#  :::::::::::: :::: :: : :::::::: : :: : @:: ::::: :: ::@
     |     @#::: ::: :::::: :::: :: : :::::::: : :: : @:: ::::: :: ::@
     |     @#::: ::: :::::: :::: :: : :::::::: : :: : @:: ::::: :: ::@
     |     @#::: ::: :::::: :::: :: : :::::::: : :: : @:: ::::: :: ::@
     |     @#::: ::: :::::: :::: :: : :::::::: : :: : @:: ::::: :: ::@
     |     @#::: ::: :::::: :::: :: : :::::::: : :: : @:: ::::: :: ::@
     |     @#::: ::: :::::: :::: :: : :::::::: : :: : @:: ::::: :: ::@
     |     @#::: ::: :::::: :::: :: : :::::::: : :: : @:: ::::: :: ::@
     |     @#::: ::: :::::: :::: :: : :::::::: : :: : @:: ::::: :: ::@
     |     @#::: ::: :::::: :::: :: : :::::::: : :: : @:: ::::: :: ::@
     |     @#::: ::: :::::: :::: :: : :::::::: : :: : @:: ::::: :: ::@
     |     @#::: ::: :::::: :::: :: : :::::::: : :: : @:: ::::: :: ::@
     |     @#::: ::: :::::: :::: :: : :::::::: : :: : @:: ::::: :: ::@
     |  :::@#::: ::: :::::: :::: :: : :::::::: : :: : @:: ::::: :: ::@
     |  :: @#::: ::: :::::: :::: :: : :::::::: : :: : @:: ::::: :: ::@
     |  :: @#::: ::: :::::: :::: :: : :::::::: : :: : @:: ::::: :: ::@
     |  :: @#::: ::: :::::: :::: :: : :::::::: : :: : @:: ::::: :: ::@
   0 +--------------------------------------------------------------->

The previous change introduced a refactoring of write_midx_bitmap() to
make it more clear how much of the 'struct write_midx_context' instance
is needed at different parts of the process. In addition, the following
defensive programming measures were put in place:

 1. Using FREE_AND_NULL() we will at least get a segfault from reading a
    NULL pointer instead of a use-after-free.

 2. 'entries_nr' is also set to zero to make any loop that would iterate
    over the entries be trivial.

 3. Add significant comments in write_midx_internal() to add warnings
    for future authors who might accidentally add references to this
    cleared memory.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 midx.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/midx.c b/midx.c
index e2dd808b35d..772ab7d2944 100644
--- a/midx.c
+++ b/midx.c
@@ -1451,6 +1451,15 @@ static int write_midx_internal(const char *object_dir,
 
 		commits = find_commits_for_midx_bitmap(&commits_nr, refs_snapshot, &ctx);
 
+		/*
+		 * The previous steps translated the information from
+		 * 'entries' into information suitable for constructing
+		 * bitmaps. We no longer need that array, so clear it to
+		 * reduce memory pressure.
+		 */
+		FREE_AND_NULL(ctx.entries);
+		ctx.entries_nr = 0;
+
 		if (write_midx_bitmap(midx_name.buf, midx_hash, &pdata,
 				      commits, commits_nr, ctx.pack_order,
 				      refs_snapshot, flags) < 0) {
@@ -1459,6 +1468,10 @@ static int write_midx_internal(const char *object_dir,
 			goto cleanup;
 		}
 	}
+	/*
+	 * NOTE: Do not use ctx.entries beyond this point, since it might
+	 * have been freed in the previous if block.
+	 */
 
 	if (ctx.m)
 		close_object_store(the_repository->objects);
-- 
gitgitgadget
