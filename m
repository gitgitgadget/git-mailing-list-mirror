Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C09C433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 18:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EE0261175
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 18:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243491AbhJGSJ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 14:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243497AbhJGSJU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 14:09:20 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91269C061570
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 11:07:25 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v25so21639391wra.2
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 11:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=j/cukJAKoXC2kxxXM0RpMl8EnB5E+BYeVCu/VMXZXjk=;
        b=YOVLUmaVc4ugM/YiGIzS4nbOo7pzt211AEp8yVZBZzbbUG0HQXtY5e/eS4X0v+auXT
         GOuoluKTFr98UF3nYSxCgnWKUeUE/6304+9j/yI3BRo9dhmuXoEkOK1x45GC++TJLFfa
         h8qbIxd8xuY2jO+QgTNjcatH4EawYEVTvXqDJ29UPq1rVYbvjgSsLoc4j9AiRoYYQjpt
         3MmY8I5/93zsDozBtPXq6bRaVvrNg4V3qyxeDl1dKU6/6Njm/m895ITPhul6cTT8A0TC
         iEKVv9pqHvt39S5F/k81EbAdmSGcAdeJwvdMm/7GaIwoY1zqyHUuqN/aOtsnYvuojyg9
         LxaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=j/cukJAKoXC2kxxXM0RpMl8EnB5E+BYeVCu/VMXZXjk=;
        b=qBdb6ZKAsCzVa50nj3wpuX8RdvHjaiQYc6M9CHBd1xAlScq0nwCf50qRVvl75P9Szy
         u8gU+AWLIVPzQafBlcQ0MzWKTU71kZkhtMKiqz3q9UHDzKy/ULl57DBCucdDuaW5Y6LZ
         2M+dfUAq9PqUuVhseAJBwJxvCWZxCOgsEgPJgEzXpQ/+rJL7BSFesrNgAFM6T7uTd/D3
         ZL046e7teyZtnrL4GahAMNYXIwSmmZ9gqy5doaJhEHu2uAWK5MYFs2s1/RdgGf96g6Zn
         B6LpMPdbYbqvNfpezwFLFTttvRw1RlEyh/xO0SKnkMkVsyQd4seYNl45zm2MMnY3ZHO5
         kdeA==
X-Gm-Message-State: AOAM5331dvKtLJtRtwBiD/00DzwdZRynCiOD6+HgsFoiiSNQMCFH62iH
        XfUm/BOwMfu7TbV4uBdhUI9IxGIXors=
X-Google-Smtp-Source: ABdhPJxemOdmLlnbKai8xGkxfArGcpzw1x7n7X1UfMQ7ibaI/xowKSo+2bz4R2DOBAMC8/EZDYzQbQ==
X-Received: by 2002:a1c:a5cd:: with SMTP id o196mr6488284wme.96.1633630044134;
        Thu, 07 Oct 2021 11:07:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s24sm93792wmh.34.2021.10.07.11.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 11:07:22 -0700 (PDT)
Message-Id: <pull.1053.v3.git.1633630041829.gitgitgadget@gmail.com>
In-Reply-To: <pull.1053.v2.git.1633600244854.gitgitgadget@gmail.com>
References: <pull.1053.v2.git.1633600244854.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Oct 2021 18:07:21 +0000
Subject: [PATCH v3] sparse index: fix use-after-free bug in
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
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
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
and Derrick Stolee for their help analyzing the problem.

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
    
    Changes since V2
    
     * Fixed the spelling of Stolee's name (sorry Stolee)
     * Added "-q" to the test to prevent a failure on Microsoft's fork[1]
    
    [1]
    https://lore.kernel.org/git/ebbe8616-0863-812b-e112-103680f7298b@gmail.com/
    
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1053%2Fphillipwood%2Fwip%2Fsparse-index-fix-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1053/phillipwood/wip/sparse-index-fix-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1053

Range-diff vs v2:

 1:  4ee972fee2e ! 1:  b3dbe02fcc3 sparse index: fix use-after-free bug in cache_tree_verify()
     @@ Commit message
          results in a use-after-free bug. Instead restart the verification if a
          sparse index is converted to a full index. This bug is triggered by a
          call to reset_head() in "git rebase --apply". Thanks to René Scharfe
     -    and Derick Stolee for their help analyzing the problem.
     +    and Derrick Stolee for their help analyzing the problem.
      
          ==74345==ERROR: AddressSanitizer: heap-use-after-free on address 0x606000001b20 at pc 0x557cbe82d3a2 bp 0x7ffdfee08090 sp 0x7ffdfee08080
          READ of size 4 at 0x606000001b20 thread T0
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'checkout and rese
       	init_repos &&
       
      -	for OPERATION in "merge -m merge" cherry-pick rebase
     -+	for OPERATION in "merge -m merge" cherry-pick "rebase --apply" "rebase --merge"
     ++	for OPERATION in "merge -m merge" cherry-pick "rebase --apply -q" "rebase --merge"
       	do
       		test_all_match git checkout -B temp update-deep &&
       		test_all_match git $OPERATION update-folder1 &&


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
index 886e78715fe..80c77bb432e 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -484,7 +484,7 @@ test_expect_success 'checkout and reset (mixed) [sparse]' '
 test_expect_success 'merge, cherry-pick, and rebase' '
 	init_repos &&
 
-	for OPERATION in "merge -m merge" cherry-pick rebase
+	for OPERATION in "merge -m merge" cherry-pick "rebase --apply -q" "rebase --merge"
 	do
 		test_all_match git checkout -B temp update-deep &&
 		test_all_match git $OPERATION update-folder1 &&

base-commit: cefe983a320c03d7843ac78e73bd513a27806845
-- 
gitgitgadget
