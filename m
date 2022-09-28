Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCFCC6FA82
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 07:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbiI1HkA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 03:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbiI1Hj0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 03:39:26 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36D3112641
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 00:37:19 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id i203-20020a1c3bd4000000b003b3df9a5ecbso619464wma.1
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 00:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=gccyVjD1Z0dM7h10jEoIJH/5YYP0NWBkacor6R91m8c=;
        b=HbDgo+iboGjfIAJlUPpy10iVVtpYGmq5Vswl5Wp37zCyReR6RbCE8Urm5+Cz3EbcyM
         zEay0AqopszajYntDYAnBlFH/9FpwgXhd7M4XuRjpwDKdAFe9qyO/qk5O2zwN14Ojy8T
         OkuvD6IS5PBvbCbTdVtPuwt+yltJh/4Txy3n2/UYO412j5eEs7NDImVUZWjdNvhahBF9
         ZkHUK+2kEJpDnKyYboEh47kJYUqcadYsLBQxuapwuh+oK6l+wSM7ypmhe5a+G8Yhcwja
         uB/kuG0vDdzomsX9ejLaPvhRIw15shxJkW6hDKF46jj/pp8KKQ7CAwqVmXo+lnjk5ICo
         57kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=gccyVjD1Z0dM7h10jEoIJH/5YYP0NWBkacor6R91m8c=;
        b=E48NPBA0xJOyDKcz5AhX5D/J8cdD/stNEwe2hT7jeBj60gtaa2wD5+A9a4E1jGQBtm
         WkgkI/qAw5/vmQejIbgbOTKcde+puiUKHuF4sJ8FRXdlol88KhwooR6vKQjrDXOQ/+oI
         LHfd5Z49baBtlKaaxsbKrYUujHHROIo0uOqlA+ohE4UAMi3OI80acBqH+x5IGLo/1KwA
         VS4UUNETPxpJiOQR3YdNMGNjSTiIffUyiAtU/lOCV1rb6CddsrITW0zKfpweDDEaX6Lz
         jCkZHllJk0tbXty729EkDD+KDJNBJG2NsrbVWcnJoN6QVjt7bTh4pOEyzOuhtFOx5rWK
         5idw==
X-Gm-Message-State: ACrzQf0iCFV9ag5/sET8JmZ63ErYSVQaj3pM+0fefxVZjXstnJGoml/y
        L81xz8Plr6BjSiYhgOTVSG6tFfVVOVE=
X-Google-Smtp-Source: AMsMyM5j3Q9kz/lCch3DlHT7R6ynoJiLrHG56sztH9M1Fsat997orjv25H4kZ3I1682bqcr1uyeR7g==
X-Received: by 2002:a1c:ed11:0:b0:3b4:d3e1:bec with SMTP id l17-20020a1ced11000000b003b4d3e10becmr5615459wmh.196.1664350163244;
        Wed, 28 Sep 2022 00:29:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o21-20020a05600c4fd500b003a5537bb2besm975968wmq.25.2022.09.28.00.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 00:29:22 -0700 (PDT)
Message-Id: <pull.1362.v5.git.1664350162.gitgitgadget@gmail.com>
In-Reply-To: <pull.1362.v4.git.1664229348.gitgitgadget@gmail.com>
References: <pull.1362.v4.git.1664229348.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 28 Sep 2022 07:29:20 +0000
Subject: [PATCH v5 0/2] merge-tree: fix segmentation fault in read-only repositories
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Turns out that the segmentation fault reported by Taylor
[https://lore.kernel.org/git/YyopQD+LvPucnz3w@nand.local/] happened while
testing merge-ort in a read-only repository, and that the upstream version
of git merge-tree is as affected as GitHub's internal version.

Changes since v4:

 * Corrected the commit message that claimed that the second patch was not
   fixing a real bug but just avoided unnecessary work. As pointed out by
   Elijah, there are scenarios where this second patch fixes a very real
   bug.
 * Added Elijah's "Reviewed-by" footer.

Changes since v3:

 * I now consistently use the pattern int ret = 0; ... if (...) ret = -1.
 * I added a commit to properly propagate write failures through the
   handle_content_merge() call path, even if it is not really critical (it
   just fails sooner, but the merge would have failed just the same without
   this patch).

Changes since v2:

 * Completely changed the approach by no longer touching
   builtin/merge-tree.c but instead fixing the underlying merge-ort layer:
   we no longer ignore the return value of write_tree() and
   write_object_file().

Changes since v1:

 * Using the SANITY prereq now
 * If the merge was aborted due to a write error, exit with a non-zero code
   even if the (potentially partial) merge is clean
 * The test case now also verifies that the git merge-tree command fails in
   a read-only repository even if the merge would have succeeded

Johannes Schindelin (2):
  merge-ort: fix segmentation fault in read-only repositories
  merge-ort: return early when failing to write a blob

 merge-ort.c                      | 94 ++++++++++++++++++++------------
 t/t4301-merge-tree-write-tree.sh |  9 +++
 2 files changed, 69 insertions(+), 34 deletions(-)


base-commit: dda7228a83e2e9ff584bf6adbf55910565b41e14
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1362%2Fdscho%2Fmerge-tree-in-read-only-repos-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1362/dscho/merge-tree-in-read-only-repos-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1362

Range-diff vs v4:

 1:  ab6df092eba ! 1:  63be9f9f717 merge-ort: fix segmentation fault in read-only repositories
     @@ Commit message
          Let's stop ignoring the return value of `write_object_file()` and
          `write_tree()` and set `clean = -1` in the error case.
      
     +    Reviewed-by: Elijah Newren <newren@gmail.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## merge-ort.c ##
 2:  087207ae0b0 ! 2:  bfc71a2d8ad merge-ort: return early when failing to write a blob
     @@ Commit message
          that already exists in the database). And this can fail, too, but we
          ignore that write failure so far.
      
     -    Since we will always write out a new tree object in addition to the blob
     -    (and if the blob did not exist in the database yet, we can be certain
     -    that the tree object did not exist yet), the merge will _still_ fail at
     -    that point, but it does unnecessary work by continuing after the blob
     -    could not be written.
     -
          Let's pay close attention and error out early if the blob could not be
          written. This reduces the error output of t4301.25 ("merge-ort fails
          gracefully in a read-only repository") from:
     @@ Commit message
                  error: error: Unable to add numbers to database
                  fatal: failure to merge
      
     +    This is _not_ just a cosmetic change: Even though one might assume that
     +    the operation would have failed anyway at the point when the new tree
     +    object is written (and the corresponding tree object _will_ be new if it
     +    contains a blob that is new), but that is not so: As pointed out by
     +    Elijah Newren, when Git has previously been allowed to add loose objects
     +    via `sudo` calls, it is very possible that the blob object cannot be
     +    written (because the corresponding `.git/objects/??/` directory may be
     +    owned by `root`) but the tree object can be written (because the
     +    corresponding objects directory is owned by the current user). This
     +    would result in a corrupt repository because it is missing the blob
     +    object, and with this here patch we prevent that.
     +
          Note: This patch adjusts two variable declarations from `unsigned` to
          `int` because their purpose is to hold the return value of
          `handle_content_merge()`, which is of type `int`. The existing users of
          those variables are only interested whether that variable is zero or
          non-zero, therefore this type change does not affect the existing code.
      
     +    Reviewed-by: Elijah Newren <newren@gmail.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## merge-ort.c ##

-- 
gitgitgadget
