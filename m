Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDABC28D13
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 02:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239107AbiHWCm0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 22:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235382AbiHWCmZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 22:42:25 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C2E5C365
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 19:42:24 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id bs25so15360415wrb.2
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 19:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=pmFRzbA0NlZCsGxLik/AdNdLi8tXD7l+DhF2cUvn+9s=;
        b=eDRv0zOcMIyxwbF52cpirPpfI0la+3UrqWgC2in6n1TU4n5snp5tSO6Rl7A96hVreJ
         Tv6eKBWlPtxPtdkeurmVzZp4hHcbt4gB6rUwR6o0F/jKCcwyGZbpNnoLbrfHV5CcE+83
         a1REpteoAX2xA/6iHqXEk/cPk1wYm39j/hj9U9EKfnwpcl1PgpzFTVGFAEIl7PVGd8Xa
         90ieWo9/L0QQeZbu/6T34rldm3pR+Qd8TJrLpLIbQq7a8pEid6O/K8Vjtw+uT37L3aGU
         VwP2rN26thrBUZPGGQdhQF+LKl3zC6gEOSZBSp6EWlS0HcdtEjfTCNQeDToEUx6hCnUX
         RpZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=pmFRzbA0NlZCsGxLik/AdNdLi8tXD7l+DhF2cUvn+9s=;
        b=erwSP8AKBr+/K3DdZp0OODlqFYrtf0T6D67K5m3UltlBBmwLQfm/nhKx7hllyvXx4z
         7I/tWmWZSbvVcMHfKVz11tsrcRQQLL7jxD9PnTjikLDwI8c7TcyGnClv2N6wb7vBEHco
         VDOEkyei5ckf0kaIyhvNhgGSsRfKNwEWsWAqlNajdYp7kF2FenG9e8PYMvRsBmzMyabr
         5yQZdRcrJ7hpOMk6pXml53g3fnuARUe9aphPrN/yhmPpbbMA0924kcbplblEquZn6ySZ
         d4BzwwuoAuMFwET7VOuBWT7v1SExmys9ajbeST1i9RMltiuTPTJemKplHb//cS+oA6NU
         FyBQ==
X-Gm-Message-State: ACgBeo2qJbPo23vegXpq48RO6ZeI5IBVcbseQ8d97/j/3zwrT2ls7vrC
        59slCo6GmBqAW+/AqW+JT1LctKXRw3w=
X-Google-Smtp-Source: AA6agR7MA3arRFwfD+H5dQjoYHKmtAB07AZ/ThFqJ6qHEYKFQNWSIn+0Ouvj7q2dMK+sr7H9swAiQw==
X-Received: by 2002:adf:f905:0:b0:224:f876:c001 with SMTP id b5-20020adff905000000b00224f876c001mr11726309wrr.201.1661222543101;
        Mon, 22 Aug 2022 19:42:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c1d9000b003a5fcae64d4sm16765762wms.29.2022.08.22.19.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 19:42:22 -0700 (PDT)
Message-Id: <pull.1331.v2.git.1661222541.gitgitgadget@gmail.com>
In-Reply-To: <pull.1331.git.1661056709.gitgitgadget@gmail.com>
References: <pull.1331.git.1661056709.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Aug 2022 02:42:18 +0000
Subject: [PATCH v2 0/3] Miscellaneous merge fixes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While working on other things, I noticed a few miscellaneous issues in
builtin/merge.c. Here's a few small fixes to address them.

Elijah Newren (3):
  merge: only apply autostash when appropriate
  merge: cleanup confusing logic for handling successful merges
  merge: small code readability improvement

 builtin/merge.c  | 25 +++++++++++++++----------
 t/t7600-merge.sh |  9 +++++++++
 2 files changed, 24 insertions(+), 10 deletions(-)


base-commit: 9bf691b78cf906751e65d65ba0c6ffdcd9a5a12c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1331%2Fnewren%2Fmisc-merge-fixes-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1331/newren/misc-merge-fixes-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1331

Range-diff vs v1:

 1:  92840bf6378 ! 1:  610b8d089db merge: only apply autostash when appropriate
     @@ t/t7600-merge.sh: test_expect_success 'merge --squash c3 with c7' '
       	test_cmp expect actual
       '
       
     -+test_expect_success 'merge --squash --autostash conflict does not attempt to play autostash' '
     ++test_expect_success 'merge --squash --autostash conflict does not attempt to apply autostash' '
      +	git reset --hard c3 &&
      +	>unrelated &&
      +	git add unrelated &&
 2:  5657a05e763 ! 2:  9817d4b19bc merge: avoid searching for strategies with fewer than 0 conflicts
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    merge: avoid searching for strategies with fewer than 0 conflicts
     +    merge: cleanup confusing logic for handling successful merges
      
     -    builtin/merge.c has a loop over the specified strategies, where if
     -    they all fail with conflicts, it picks the one with the least number
     -    of conflicts.
     +    builtin/merge.c has a loop over the specified strategies, where if they
     +    all fail with conflicts, it picks the one with the least number of
     +    conflicts.
      
          In the codepath that finds a successful merge, if an automatic commit
          was wanted, the code breaks out of the above loop, which makes sense.
          However, if the user requested there be no automatic commit, the loop
     -    would continue looking for a "better" strategy.  Since it had just
     -    found a strategy with 0 conflicts though, and it is not possible to
     -    have fewer than 0 conflicts, the continuing search is guaranteed to be
     -    futile.
     +    would continue.  That seems weird; --no-commit should not affect the
     +    choice of merge strategy, but the code as written makes one think it
     +    does.  However, since the loop itself embeds "!merge_was_ok" as a
     +    condition on continuing to loop, it actually would also exit early if
     +    --no-commit was specified, it just exited from a different location.
      
     -    While searching additional strategies won't cause problems other than
     -    wasting energy, it is wasteful.  Avoid searching for other strategies
     -    with fewer than 0 conflicts.
     +    Restructure the code slightly to make it clear that the loop will
     +    immediately exit whenever we find a merge strategy that is successful.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## builtin/merge.c ##
     +@@ builtin/merge.c: int cmd_merge(int argc, const char **argv, const char *prefix)
     + 	if (save_state(&stash))
     + 		oidclr(&stash);
     + 
     +-	for (i = 0; !merge_was_ok && i < use_strategies_nr; i++) {
     ++	for (i = 0; i < use_strategies_nr; i++) {
     + 		int ret, cnt;
     + 		if (i) {
     + 			printf(_("Rewinding the tree to pristine...\n"));
      @@ builtin/merge.c: int cmd_merge(int argc, const char **argv, const char *prefix)
       		 */
       		if (ret < 2) {
       			if (!ret) {
      -				if (option_commit) {
     -+				if (option_commit)
     - 					/* Automerge succeeded. */
     - 					automerge_was_ok = 1;
     +-					/* Automerge succeeded. */
     +-					automerge_was_ok = 1;
      -					break;
      -				}
     --				merge_was_ok = 1;
     -+				else
     -+					/* Merge good, but let user commit */
     -+					merge_was_ok = 1;
      +				/*
      +				 * This strategy worked; no point in trying
      +				 * another.
      +				 */
     -+				best_strategy = wt_strategy;
     + 				merge_was_ok = 1;
     ++				best_strategy = use_strategies[i]->name;
      +				break;
       			}
       			cnt = (use_strategies_nr > 1) ? evaluate_result() : 0;
       			if (best_cnt <= 0 || cnt <= best_cnt) {
     +@@ builtin/merge.c: int cmd_merge(int argc, const char **argv, const char *prefix)
     + 	 * If we have a resulting tree, that means the strategy module
     + 	 * auto resolved the merge cleanly.
     + 	 */
     +-	if (automerge_was_ok) {
     ++	if (merge_was_ok && option_commit) {
     ++		automerge_was_ok = 1;
     + 		ret = finish_automerge(head_commit, head_subsumed,
     + 				       common, remoteheads,
     + 				       &result_tree, wt_strategy);
 -:  ----------- > 3:  88173eba0b9 merge: small code readability improvement

-- 
gitgitgadget
