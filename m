Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BBFC433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 09:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DA41611C1
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 09:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240473AbhJGJwz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 05:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240764AbhJGJwk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 05:52:40 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD8EC061755
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 02:50:47 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k7so17101176wrd.13
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 02:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=NK296F4J9I9zhEHzno+0ymQStxidNXyeIQaAd09iw34=;
        b=Pmwz5zv7kAWUoJg60SW8QhZ4nKLzAdJquOWyiD/W5YqhQa4UNdE/bWFPijrtlGXolK
         lymNJAiKuMS/uhoA5HmnDnX2eGxHa+gfo2QzV3hrZqGM7VHn1jxgHRjsxB7imEID8Aji
         r/XqoYO9ulwTOD8MWZiVuLiRaRP4pr1sioMhtc2ZNVx7Xp6KfbIGDrOjeJf0plsso7m1
         nWG4LTg3ksn2F8apR9GaDO90PqEh0/eNpu3/l8zJYCAyT202I0SVYX38y8KrgtLcUwMp
         nr9UR+qCBTG0OFzzMg+nj68Pe4EGrVrb0A+e8zbY74qxqZ3vAXXcmLug7HsNVSYgzTuC
         ZbHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=NK296F4J9I9zhEHzno+0ymQStxidNXyeIQaAd09iw34=;
        b=7w+kLDd7bNhzfitRROK2bxutnGdKM6CLv7f1eH7YLHXrQPbPJRIGmjGN8wBHXcPLaw
         UWRU54tSWw91NWYvE5/rQJnLQSYdy0gITXz6GiIxC9fYRl/+USp3hF9CDuDXw/P5QEpO
         OJ8z18Js0iuQWK9kzDH4hAlnXclvIL/9AmkdKsRkeQC0is7Lf3/BRPcDqo3Kg7alGcLX
         nmnVsClQC6+ZHmPlm8LtM7CEUHngp6jGkl4pUsJ7uWWuL/C+HQhGu42UYM8HGeVGTv70
         le5xW8TjoMGL1vaMGHuyHworbRACn8xt5qnZa8dJllEuW1eSWvzK8zGfOJh7UhpKzuhE
         XY+w==
X-Gm-Message-State: AOAM531EDPmV/AWfUZ/ZxEZWi+JcH1SVRdaQ5/T9ifEh06MYdPH5J/6c
        K7oYkRygU1tbv1MTOsaKuoS0oooTMJU=
X-Google-Smtp-Source: ABdhPJxzWOPGNgZa6Ag9XLIgob4O1PywK+PIffnoEGoBMHBF6sQqKfmZ/ke6BQUNHhtG358DnpySng==
X-Received: by 2002:a1c:f00a:: with SMTP id a10mr3521485wmb.112.1633600245751;
        Thu, 07 Oct 2021 02:50:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k26sm11314525wms.39.2021.10.07.02.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 02:50:45 -0700 (PDT)
Message-Id: <pull.1053.v2.git.1633600244854.gitgitgadget@gmail.com>
In-Reply-To: <pull.1053.git.1633512591608.gitgitgadget@gmail.com>
References: <pull.1053.git.1633512591608.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Oct 2021 09:50:44 +0000
Subject: [PATCH v2] sparse index: fix use-after-free bug in
 cache_tree_verify()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

In a sparse index it is possible for the tree that is being verified
to be freed while it is being verified. This happens when the index is
sparse but the cache tree is not and index_name_pos() looks up a path
from the cache tree that is a descendant of a sparse index entry. That
triggers a call to ensure_full_index() which frees the cache tree that
is being verified.  Carrying on trying to verify the tree after this
results in a use-after-free bug. Instead restart the verification if a
sparse index is converted to a full index. This bug is triggered by a
call to reset_head() in "git rebase --apply". Thanks to René Scharfe
and Derick Stolee for their help analyzing the problem.

==74345==ERROR: AddressSanitizer: heap-use-after-free on address 0x606000001b20 at pc 0x557cbe82d3a2 bp 0x7ffdfee08090 sp 0x7ffdfee08080
READ of size 4 at 0x606000001b20 thread T0
    #0 0x557cbe82d3a1 in verify_one /home/phil/src/git/cache-tree.c:863
    #1 0x557cbe82ca9d in verify_one /home/phil/src/git/cache-tree.c:840
    #2 0x557cbe82ca9d in verify_one /home/phil/src/git/cache-tree.c:840
    #3 0x557cbe82ca9d in verify_one /home/phil/src/git/cache-tree.c:840
    #4 0x557cbe830a2b in cache_tree_verify /home/phil/src/git/cache-tree.c:910
    #5 0x557cbea53741 in write_locked_index /home/phil/src/git/read-cache.c:3250
    #6 0x557cbeab7fdd in reset_head /home/phil/src/git/reset.c:87
    #7 0x557cbe72147f in cmd_rebase builtin/rebase.c:2074
    #8 0x557cbe5bd151 in run_builtin /home/phil/src/git/git.c:461
    #9 0x557cbe5bd151 in handle_builtin /home/phil/src/git/git.c:714
    #10 0x557cbe5c0503 in run_argv /home/phil/src/git/git.c:781
    #11 0x557cbe5c0503 in cmd_main /home/phil/src/git/git.c:912
    #12 0x557cbe5bad28 in main /home/phil/src/git/common-main.c:52
    #13 0x7fdd4b82eb24 in __libc_start_main (/usr/lib/libc.so.6+0x27b24)
    #14 0x557cbe5bcb8d in _start (/home/phil/src/git/git+0x1b9b8d)

0x606000001b20 is located 0 bytes inside of 56-byte region [0x606000001b20,0x606000001b58)
freed by thread T0 here:
    #0 0x7fdd4bacff19 in __interceptor_free /build/gcc/src/gcc/libsanitizer/asan/asan_malloc_linux.cpp:127
    #1 0x557cbe82af60 in cache_tree_free /home/phil/src/git/cache-tree.c:35
    #2 0x557cbe82aee5 in cache_tree_free /home/phil/src/git/cache-tree.c:31
    #3 0x557cbe82aee5 in cache_tree_free /home/phil/src/git/cache-tree.c:31
    #4 0x557cbe82aee5 in cache_tree_free /home/phil/src/git/cache-tree.c:31
    #5 0x557cbeb2557a in ensure_full_index /home/phil/src/git/sparse-index.c:310
    #6 0x557cbea45c4a in index_name_stage_pos /home/phil/src/git/read-cache.c:588
    #7 0x557cbe82ce37 in verify_one /home/phil/src/git/cache-tree.c:850
    #8 0x557cbe82ca9d in verify_one /home/phil/src/git/cache-tree.c:840
    #9 0x557cbe82ca9d in verify_one /home/phil/src/git/cache-tree.c:840
    #10 0x557cbe82ca9d in verify_one /home/phil/src/git/cache-tree.c:840
    #11 0x557cbe830a2b in cache_tree_verify /home/phil/src/git/cache-tree.c:910
    #12 0x557cbea53741 in write_locked_index /home/phil/src/git/read-cache.c:3250
    #13 0x557cbeab7fdd in reset_head /home/phil/src/git/reset.c:87
    #14 0x557cbe72147f in cmd_rebase builtin/rebase.c:2074
    #15 0x557cbe5bd151 in run_builtin /home/phil/src/git/git.c:461
    #16 0x557cbe5bd151 in handle_builtin /home/phil/src/git/git.c:714
    #17 0x557cbe5c0503 in run_argv /home/phil/src/git/git.c:781
    #18 0x557cbe5c0503 in cmd_main /home/phil/src/git/git.c:912
    #19 0x557cbe5bad28 in main /home/phil/src/git/common-main.c:52
    #20 0x7fdd4b82eb24 in __libc_start_main (/usr/lib/libc.so.6+0x27b24)

previously allocated by thread T0 here:
    #0 0x7fdd4bad0459 in __interceptor_calloc /build/gcc/src/gcc/libsanitizer/asan/asan_malloc_linux.cpp:154
    #1 0x557cbebc1807 in xcalloc /home/phil/src/git/wrapper.c:140
    #2 0x557cbe82b7d8 in cache_tree /home/phil/src/git/cache-tree.c:17
    #3 0x557cbe82b7d8 in prime_cache_tree_rec /home/phil/src/git/cache-tree.c:763
    #4 0x557cbe82b837 in prime_cache_tree_rec /home/phil/src/git/cache-tree.c:764
    #5 0x557cbe82b837 in prime_cache_tree_rec /home/phil/src/git/cache-tree.c:764
    #6 0x557cbe8304e1 in prime_cache_tree /home/phil/src/git/cache-tree.c:779
    #7 0x557cbeab7fa7 in reset_head /home/phil/src/git/reset.c:85
    #8 0x557cbe72147f in cmd_rebase builtin/rebase.c:2074
    #9 0x557cbe5bd151 in run_builtin /home/phil/src/git/git.c:461
    #10 0x557cbe5bd151 in handle_builtin /home/phil/src/git/git.c:714
    #11 0x557cbe5c0503 in run_argv /home/phil/src/git/git.c:781
    #12 0x557cbe5c0503 in cmd_main /home/phil/src/git/git.c:912
    #13 0x557cbe5bad28 in main /home/phil/src/git/common-main.c:52
    #14 0x7fdd4b82eb24 in __libc_start_main (/usr/lib/libc.so.6+0x27b24)

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
    [RFC] sparse index: fix use-after-free bug in cache_tree_verify()
    
    Thanks for the feedback and help, here are the changes from the RFC
    
     * Updated commit message and comments to make it clear this is
       triggered by a sparse index with a full cache tree based on Stolee's
       explanation.
     * Added a comment and BUG() suggested by Junio
    
    RFC cover letter In a sparse index it is possible for the tree that is
    being verified to be freed while it is being verified. This is an RFC as
    I'm not familiar with the cache tree code. I'm confused as to why this
    bug is triggered by the sequence
    
    unpack_trees()
    prime_cache_tree()
    write_locked_index()
    
    
    but not
    
    unpack_trees()
    write_locked_index()
    
    
    as unpack_trees() appears to update the cache tree with
    
    if (!cache_tree_fully_valid(o->result.cache_tree))
                cache_tree_update(&o->result,
                          WRITE_TREE_SILENT |
                          WRITE_TREE_REPAIR);
    
    
    and I don't understand why the cache tree from prime_cache_tree()
    results in different behavior. It concerns me that this fix is hiding
    another bug.
    
    Best Wishes
    
    Phillip

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1053%2Fphillipwood%2Fwip%2Fsparse-index-fix-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1053/phillipwood/wip/sparse-index-fix-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1053

Range-diff vs v1:

 1:  358b7afb653 ! 1:  4ee972fee2e [RFC] sparse index: fix use-after-free bug in cache_tree_verify()
     @@ Metadata
      Author: Phillip Wood <phillip.wood@dunelm.org.uk>
      
       ## Commit message ##
     -    [RFC] sparse index: fix use-after-free bug in cache_tree_verify()
     +    sparse index: fix use-after-free bug in cache_tree_verify()
      
          In a sparse index it is possible for the tree that is being verified
     -    to be freed while it is being verified. This happens when
     -    index_name_pos() looks up a entry that is missing from the index and
     -    that would be a descendant of a sparse entry. That triggers a call to
     -    ensure_full_index() which frees the cache tree that is being verified.
     -    Carrying on trying to verify the tree after this results in a
     -    use-after-free bug. Instead restart the verification if a sparse index
     -    is converted to a full index. This bug is triggered by a call to
     -    reset_head() in "git rebase --apply". Thanks to René Scharfe for his
     -    help analyzing the problem.
     +    to be freed while it is being verified. This happens when the index is
     +    sparse but the cache tree is not and index_name_pos() looks up a path
     +    from the cache tree that is a descendant of a sparse index entry. That
     +    triggers a call to ensure_full_index() which frees the cache tree that
     +    is being verified.  Carrying on trying to verify the tree after this
     +    results in a use-after-free bug. Instead restart the verification if a
     +    sparse index is converted to a full index. This bug is triggered by a
     +    call to reset_head() in "git rebase --apply". Thanks to René Scharfe
     +    and Derick Stolee for their help analyzing the problem.
      
          ==74345==ERROR: AddressSanitizer: heap-use-after-free on address 0x606000001b20 at pc 0x557cbe82d3a2 bp 0x7ffdfee08090 sp 0x7ffdfee08080
          READ of size 4 at 0x606000001b20 thread T0
     @@ cache-tree.c: static void verify_one_sparse(struct repository *r,
      -		       struct index_state *istate,
      -		       struct cache_tree *it,
      -		       struct strbuf *path)
     ++/*
     ++ * Returns:
     ++ *  0 - Verification completed.
     ++ *  1 - Restart verification - a call to ensure_full_index() freed the cache
     ++ *      tree that is being verified and verification needs to be restarted from
     ++ *      the new toplevel cache tree.
     ++ */
      +static int verify_one(struct repository *r,
      +		      struct index_state *istate,
      +		      struct cache_tree *it,
     @@ cache-tree.c: static void verify_one(struct repository *r,
       
       	if (path->len) {
      +		/*
     -+		 * If the index is sparse index_name_pos() may trigger
     -+		 * ensure_full_index() which will free the tree that is being
     -+		 * verified.
     ++		 * If the index is sparse and the cache tree is not
     ++		 * index_name_pos() may trigger ensure_full_index() which will
     ++		 * free the tree that is being verified.
      +		 */
      +		int is_sparse = istate->sparse_index;
       		pos = index_name_pos(istate, path->buf, path->len);
     @@ cache-tree.c: void cache_tree_verify(struct repository *r, struct index_state *i
      -	verify_one(r, istate, istate->cache_tree, &path);
      +	if (verify_one(r, istate, istate->cache_tree, &path)) {
      +		strbuf_reset(&path);
     -+		verify_one(r, istate, istate->cache_tree, &path);
     ++		if (verify_one(r, istate, istate->cache_tree, &path))
     ++			BUG("ensure_full_index() called twice while verifying cache tree");
      +	}
       	strbuf_release(&path);
       }


 cache-tree.c                             | 37 +++++++++++++++++++-----
 t/t1092-sparse-checkout-compatibility.sh |  2 +-
 2 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 90919f9e345..8044e21bcf3 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -826,10 +826,17 @@ static void verify_one_sparse(struct repository *r,
 		    path->buf);
 }
 
-static void verify_one(struct repository *r,
-		       struct index_state *istate,
-		       struct cache_tree *it,
-		       struct strbuf *path)
+/*
+ * Returns:
+ *  0 - Verification completed.
+ *  1 - Restart verification - a call to ensure_full_index() freed the cache
+ *      tree that is being verified and verification needs to be restarted from
+ *      the new toplevel cache tree.
+ */
+static int verify_one(struct repository *r,
+		      struct index_state *istate,
+		      struct cache_tree *it,
+		      struct strbuf *path)
 {
 	int i, pos, len = path->len;
 	struct strbuf tree_buf = STRBUF_INIT;
@@ -837,21 +844,30 @@ static void verify_one(struct repository *r,
 
 	for (i = 0; i < it->subtree_nr; i++) {
 		strbuf_addf(path, "%s/", it->down[i]->name);
-		verify_one(r, istate, it->down[i]->cache_tree, path);
+		if (verify_one(r, istate, it->down[i]->cache_tree, path))
+			return 1;
 		strbuf_setlen(path, len);
 	}
 
 	if (it->entry_count < 0 ||
 	    /* no verification on tests (t7003) that replace trees */
 	    lookup_replace_object(r, &it->oid) != &it->oid)
-		return;
+		return 0;
 
 	if (path->len) {
+		/*
+		 * If the index is sparse and the cache tree is not
+		 * index_name_pos() may trigger ensure_full_index() which will
+		 * free the tree that is being verified.
+		 */
+		int is_sparse = istate->sparse_index;
 		pos = index_name_pos(istate, path->buf, path->len);
+		if (is_sparse && !istate->sparse_index)
+			return 1;
 
 		if (pos >= 0) {
 			verify_one_sparse(r, istate, it, path, pos);
-			return;
+			return 0;
 		}
 
 		pos = -pos - 1;
@@ -899,6 +915,7 @@ static void verify_one(struct repository *r,
 		    oid_to_hex(&new_oid), oid_to_hex(&it->oid));
 	strbuf_setlen(path, len);
 	strbuf_release(&tree_buf);
+	return 0;
 }
 
 void cache_tree_verify(struct repository *r, struct index_state *istate)
@@ -907,6 +924,10 @@ void cache_tree_verify(struct repository *r, struct index_state *istate)
 
 	if (!istate->cache_tree)
 		return;
-	verify_one(r, istate, istate->cache_tree, &path);
+	if (verify_one(r, istate, istate->cache_tree, &path)) {
+		strbuf_reset(&path);
+		if (verify_one(r, istate, istate->cache_tree, &path))
+			BUG("ensure_full_index() called twice while verifying cache tree");
+	}
 	strbuf_release(&path);
 }
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 886e78715fe..85d5279b33c 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -484,7 +484,7 @@ test_expect_success 'checkout and reset (mixed) [sparse]' '
 test_expect_success 'merge, cherry-pick, and rebase' '
 	init_repos &&
 
-	for OPERATION in "merge -m merge" cherry-pick rebase
+	for OPERATION in "merge -m merge" cherry-pick "rebase --apply" "rebase --merge"
 	do
 		test_all_match git checkout -B temp update-deep &&
 		test_all_match git $OPERATION update-folder1 &&

base-commit: cefe983a320c03d7843ac78e73bd513a27806845
-- 
gitgitgadget
