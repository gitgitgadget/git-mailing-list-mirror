Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21C2C433F5
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 15:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236235AbiCQP5H (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 11:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236221AbiCQP46 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 11:56:58 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7109E20D888
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 08:55:41 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id h15so7971603wrc.6
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 08:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2FnwdX9SpRwtn7oGLMH3rTs7BJuoxTOqR7g2hWaZGMU=;
        b=FHvj9W4VT6HzQwo4iB0ppPCdllH+8XaNA6lFnBAosk2NtAqy9gtTMJMelZlDk4r3kB
         8YenOFwC7M9aRPavpOw9qc2TqjfBNr7zssmtsZ+3RbxjXCBeu7/gX82ejUsdt+uDnuBs
         aaLoykqJXOHSP+X9hBmwtu1vp0OFM248phz9Lng7Ed36IHLjYlJ4f+QPXXiOOt63nMfQ
         q+3wwjuTelso8ud48J0fD5DnIoYH/fQ+874qfELPnr9k1pHh2nmw66joc3GFukzRGJOc
         cwrdLYQAUHjvrMDIsz2gg0taOky5Y3oCj1jnO6a0PCD+d8a9xDzYNDsM4a9XPcWIb1gb
         NVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2FnwdX9SpRwtn7oGLMH3rTs7BJuoxTOqR7g2hWaZGMU=;
        b=GH0xe+VHXrNEd6bikNaR1b07xIf6cjAN+CXa5Hjjo4V5VI9i6+0DXLy0ATDxM8aW6K
         t0NvceR40zWD7KIDyxx9c/IEEF3E+UZ96mBuEKSAnXGAAF4hr+R16F01JstPqRS869lJ
         UYrbanC4GomqGV9IA8d+k/6os8t0vo6Yw0PWCJu96mKlYDmWwfJfU/QXAHOgg57oJdkf
         Pwv+ZbCGYJh9ySuynNjz3MDnVrUuuAWyHvCOMgJwBCpfTcdtvvhcyzdOSwiB2owrSIPe
         wUbBcMaBFOnvpvdSbsR8HJKmYALBP3+rN+lLFdZTfRIMV6Z4MVjuikv4Q5lDCT9ITqob
         oqeg==
X-Gm-Message-State: AOAM532XtN5L6TmzY8PgqyvLmiWRx/vHF0bEVX33uVjyTA6i/zSmIc0p
        XS2/I6wZVltt/liH0fsxhxgUbnIR/BI=
X-Google-Smtp-Source: ABdhPJwxtYLNalgPYh1Ib4VAMjJUyHu/TNEDfrl2eEuJAKHdqk8ZSHimCxtCEYT1WI4DB0KZYqaJAw==
X-Received: by 2002:adf:d08f:0:b0:1f0:7eaa:e541 with SMTP id y15-20020adfd08f000000b001f07eaae541mr4616599wrh.372.1647532539696;
        Thu, 17 Mar 2022 08:55:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 2-20020a1c1902000000b00380d3873d6asm4714559wmz.43.2022.03.17.08.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 08:55:39 -0700 (PDT)
Message-Id: <cf8dc50c300a08f54d0cf69c82d4d979922a8143.1647532536.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1179.v2.git.1647532536.gitgitgadget@gmail.com>
References: <pull.1179.git.1647461522.gitgitgadget@gmail.com>
        <pull.1179.v2.git.1647532536.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Mar 2022 15:55:35 +0000
Subject: [PATCH v2 2/3] unpack-trees: increment cache_bottom for sparse
 directories
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, gitster@pobox.com, newren@gmail.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Correct tracking of the 'cache_bottom' for cases where sparse directories
are present in the index.

BACKGROUND
----------
The 'unpack_trees_options.cache_bottom' is a variable that tracks the
in-progress "bottom" of the cache as 'unpack_trees()' iterates through the
contents of the index. Most importantly, this value informs the sequential
return values of 'next_cache_entry()' which, in the "diff cache" usage of
'unpack_callback()', are either unpacked as-is or are passed into the diff
machinery.

The 'cache_bottom' is intended to track the position of the first entry in
the index that has not yet been diffed or unpacked. It is advanced in two
main ways: either it is incremented when an index entry is marked as "used"
(in 'mark_ce_used()'), indicating that it was unpacked or diffed, or when a
directory is unpacked, in which case it is increased by an amount equaling
the number of index entries inside that tree.

In 17a1bb570b (unpack-trees: preserve cache_bottom, 2021-07-14), it was
identified that sparse directories posed a problem to the above
'cache_bottom' advancement logic - because a sparse directory was both an
index entry that could be "used" and a directory that can be unpacked, the
'cache_bottom' would be incremented too many times. To solve this problem,
the 'mark_ce_used()' advancement of 'cache_bottom' was skipped for sparse
directories.

INCORRECT CACHE_BOTTOM TRACKING
-------------------------------
Skipping the 'cache_bottom' advancement for sparse directories in
'mark_ce_used()' breaks down in two cases:

1. When the 'unpack_trees()' operation is *not* a "cache diff" (because the
   directory contents-based incrementing of 'cache_bottom' does not happen).
2. When a cache diff is performed with a pathspec (because
   'unpack_index_entry()' will unpack a sparse directory not matched by the
   pathspec without performing the directory contents-based increment).

The former luckily does not appear to affect 'git' behavior, likely because
'cache_bottom' is largely unused (non-"cache diff" 'unpack_trees()' uses
'find_index_entry()' - rather than 'next_cache_entry()' - to find the index
entries to unpack).

The latter, however, causes 'cache_bottom' to "lag behind" its intended
position by an amount equal to the number of sparse directories unpacked so
far with 'unpack_index_entry()'. If a repository is structured such that any
sparse directories are ordered lexicographically *after* any
pathspec-matching directories, though, this issue won't present any adverse
behavior.

This was the case with the 't1092-sparse-checkout-compatibility.sh' tests
before the addition of the 'before/' sparse directory (ordered *before* the
in-cone 'deep/' directory), therefore sidestepping the issue. Once the
'before/' directory was added, though, 'cache_bottom' began to lag behind
its intended position, causing 'next_cache_entry()' to return index entries
it had already processed and, ultimately, an incorrect diff.

CORRECTING CACHE_BOTTOM
-----------------------
The problems observed in 't1092' come from 'cache_bottom' lagging behind in
cases where the cache tree-based advancement doesn't occur. To solve this,
then, the fix in 17a1bb570b is "reversed"; rather than skipping
'cache_bottom' advancement in 'mark_ce_used()', we skip the directory
contents-based advancement for sparse directories. Now, every index entry
can be accounted for in 'cache_bottom':

* if you're working with a single index entry, 'cache_bottom' is incremented
  in 'mark_ce_used()'
* if you're working with a directory that contains index entries (but is not
  one itself), 'cache_bottom' is incremented by the number of entries in
  that directory.

Finally, change the 'test_expect_failure' tests in 't1092' failing due to
this bug back to 'test_expect_success'.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 t/t1092-sparse-checkout-compatibility.sh |  6 +++---
 unpack-trees.c                           | 16 ++++++++--------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index dcd7061fb3b..236ab530284 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -340,7 +340,7 @@ test_expect_success 'deep changes during checkout' '
 	test_all_match git checkout base
 '
 
-test_expect_failure 'add outside sparse cone' '
+test_expect_success 'add outside sparse cone' '
 	init_repos &&
 
 	run_on_sparse mkdir folder1 &&
@@ -382,7 +382,7 @@ test_expect_success 'commit including unstaged changes' '
 	test_all_match git status --porcelain=v2
 '
 
-test_expect_failure 'status/add: outside sparse cone' '
+test_expect_success 'status/add: outside sparse cone' '
 	init_repos &&
 
 	# folder1 is at HEAD, but outside the sparse cone
@@ -593,7 +593,7 @@ test_expect_success 'checkout and reset (keep)' '
 	test_all_match test_must_fail git reset --keep deepest
 '
 
-test_expect_failure 'reset with pathspecs inside sparse definition' '
+test_expect_success 'reset with pathspecs inside sparse definition' '
 	init_repos &&
 
 	write_script edit-contents <<-\EOF &&
diff --git a/unpack-trees.c b/unpack-trees.c
index 2763a029a17..b82c1a9705e 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -595,13 +595,6 @@ static void mark_ce_used(struct cache_entry *ce, struct unpack_trees_options *o)
 {
 	ce->ce_flags |= CE_UNPACKED;
 
-	/*
-	 * If this is a sparse directory, don't advance cache_bottom.
-	 * That will be advanced later using the cache-tree data.
-	 */
-	if (S_ISSPARSEDIR(ce->ce_mode))
-		return;
-
 	if (o->cache_bottom < o->src_index->cache_nr &&
 	    o->src_index->cache[o->cache_bottom] == ce) {
 		int bottom = o->cache_bottom;
@@ -1478,7 +1471,14 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 			 * it does not do any look-ahead, so this is safe.
 			 */
 			if (matches) {
-				o->cache_bottom += matches;
+				/*
+				 * Only increment the cache_bottom if the
+				 * directory isn't a sparse directory index
+				 * entry (if it is, it was already incremented)
+				 * in 'mark_ce_used()'
+				 */
+				if (!src[0] || !S_ISSPARSEDIR(src[0]->ce_mode))
+					o->cache_bottom += matches;
 				return mask;
 			}
 		}
-- 
gitgitgadget

