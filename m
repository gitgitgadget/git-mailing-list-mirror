Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791E52905
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 02:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741834007; cv=none; b=ppBSVN157h7BaXRqd192MzQNa8pT2YpzJr1xS71alAS9VtOUdxx3j3NUSzh1iT9F7C0ODFVNCqh9DWtYE9P2CkvlYTahRJgoGNudnQz1/yEdoyPFlQIOS8RMkpH68Ia52xM0odDn5cvQnV0fkZkh0SlqpX4WKyDAVHY1a3xK/EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741834007; c=relaxed/simple;
	bh=Y+okoKubTmhp3B/V2XQbxTxo2nHD5VOCib1rUDEg0QE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nTKCnZm7iImDkknx1BYvGq1tT9mVwcQb703GQ1COopTV1avymyuHQlGMBYQb6gPkwnqLGFkS2NsFjKZlZXL8kRRecXvjsp66egXzHlawXaoDmxkz8Z4VmMdq6ktxnVVDzkLq4zyZ0fkUymGNw2dI9beIgxR++hVIbxL77UyAU3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CO6lRZfD; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CO6lRZfD"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e5b572e45cso778812a12.0
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 19:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741834003; x=1742438803; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xExVeX/PWLTm1++np3r4njwu42EjyFTFrtuwp1la/Xw=;
        b=CO6lRZfDkKidV6+dZg1QkRBTjJYm6kxgIYL/gOycyAmZzVveBudH69l2NCaH4N3BsF
         /Pv5PegkSpE4nEdX8b7ZLDnqDSx9dvE3aPemr7+49fGs8C1CqiISiXUmNeFI2briqh6l
         mLHfJTE/egQswdPs1PCsnCfG5SwCVb0LXF+fVESWHCht25fKQc8yGYM2pHgLv8X7CXyq
         GoDZItunRnc5RqJARAPkl2VjoQtRlnjs+CMxoOI1dO9tAehOJwJv4vXq4UoNAmH77cC+
         pLj/VLuwOX/mPJ399IvclmW7Dikc2wK6e5EFS6c1n5vCwTLxo4lctr2LKAEEsFEC4eoL
         dzsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741834003; x=1742438803;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xExVeX/PWLTm1++np3r4njwu42EjyFTFrtuwp1la/Xw=;
        b=bAsr+Nva4NzyXUTY4V3gmSpOZH/wGRc3URSeujueSgBkvI6ljKi+4wY6v7u5bHlEHU
         Fw/9sfICQAzoB2YJ8XMdXFyWqd6OqEho19QcV3LfLaYwNzJVLSgQo0MWeERbbojIu7rp
         k7PHl9SfdR72evv+pfL7M/o7WeJpggee+DfvL15z3sAWjW7IIKatOiP7kqJ+P7oSRcpB
         kdAg3GLYYOFAjE+iqkf3fa6Vet/5WK9/T8VKAKSsQDWHn/w0krFO1Wdp6qP8H8fGQOF2
         VUgOzOfKG4XnS2XVk/CdTD65+F9SEsl5EXyGvgKJWDXnTO4Lnv5na/CLddBJCaXHd3TX
         ZI6w==
X-Gm-Message-State: AOJu0YyFtCu322Eb7xR6DKgzvVIP11+EN/wxEZ7stSMC2kYjEsjE6ocV
	iriDeOv+d6Kv0H65V0iE96nYQhoIgKlGymKml3bH3iqchK+hGSGXF2Dwkg==
X-Gm-Gg: ASbGncvrOHYyFE41+YIL8GHc1G3SJENwluobCo31VAoFkRJSoygvQfB7V0a/fdt6slE
	tGTFUXVDh4bUkOQ8I44IBgrsnecJwsjCVsN4Nk3asAk6DeZXH1pxCB15DZpAMNMS+ifJIIBqqcv
	ONFqJOl7agDnPnd6+gmsout+MzVJP/9CMjrQi66IQ23wq/K4HihxB2Cbiue+eV/lWi05dMk5CW0
	lXnjwiU5ujwf8aQa45CX+FjmYIPA3T0ORwFVJeS1DWGV0LWibIsFAhiHc5p/Gb20HBlkBoc9oBB
	DE9Nvc2Ya032GRtrNlDsiR1DgJ6GH1k/i1uhGXMctSOePQ==
X-Google-Smtp-Source: AGHT+IG6NSACxe6Tia/5m6FrncN8Bw9TmA7QLwTed4pIrAyVzU2EwzazxYU5vKMr3gNUGZnvZwxdGQ==
X-Received: by 2002:a05:6402:3594:b0:5e6:4ac8:c361 with SMTP id 4fb4d7f45d1cf-5e64ac8c790mr24594210a12.28.1741834003076;
        Wed, 12 Mar 2025 19:46:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e81692e534sm205697a12.1.2025.03.12.19.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 19:46:42 -0700 (PDT)
Message-Id: <pull.1875.v2.git.1741834001.gitgitgadget@gmail.com>
In-Reply-To: <pull.1875.git.1741362522.gitgitgadget@gmail.com>
References: <pull.1875.git.1741362522.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 13 Mar 2025 02:46:35 +0000
Subject: [PATCH v2 0/6] Small new merge-ort features, prepping for deletion of merge-recursive.[ch]
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Taylor Blau <me@ttaylorr.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

I've got 19 patches covering the work needed to prep for and allow us to
delete merge-recursive.[ch], and remap 'recursive' to 'ort', including some
clean-up along the way. I've tried to divide it up into some smaller patch
series.

These 6 patches are the first of those series. Breakdown:

 * The first 3 patches provide small new features to allow us to convert
   later callers
 * Patches 4-5 document and fix a bug with directory rename detection being
   turned off (since git am always turned off directory rename detection,
   this is a prerequisite for converting git am)
 * Patch 6 converts git am from using merge_recursive_generic() to use the
   new merge_ort_generic().

Changes since v1:

 * Patch 1: Added an explanation in the commit message about the one
   difference between merge_recursive_generic() and merge_ort_generic() --
   the label for the ancestor commit
 * Patch 2: Linked the relevant discussion in the commit message, fixed a
   style issue, and added a testcase
 * Patch 3: Since the opt->verbosity stuff was an unwanted carryover (due to
   being partially public API), move the tweak to the merge-ort-wrappers to
   avoid promoting it
 * Added 3 more patches, so folks can see one of the callers of
   merge_ort_generic().

Elijah Newren (5):
  merge-ort: add new merge_ort_generic() function
  merge-ort: allow rename detection to be disabled
  merge-ort: support having merge verbosity be set to 0
  merge-ort: fix merge.directoryRenames=false
  am: switch from merge_recursive_generic() to merge_ort_generic()

Johannes Schindelin (1):
  t3650: document bug when directory renames are turned off

 Documentation/merge-strategies.adoc | 12 ++---
 builtin/am.c                        |  5 +-
 merge-ort-wrappers.c                | 72 ++++++++++++++++++++++++++++-
 merge-ort-wrappers.h                | 12 +++++
 merge-ort.c                         | 53 ++++++++++++++++++---
 merge-ort.h                         |  5 ++
 t/t3650-replay-basics.sh            | 22 +++++++++
 t/t4151-am-abort.sh                 |  2 +-
 t/t4255-am-submodule.sh             |  1 -
 t/t4301-merge-tree-write-tree.sh    |  6 +++
 t/t6427-diff3-conflict-markers.sh   |  2 +-
 11 files changed, 172 insertions(+), 20 deletions(-)


base-commit: a36e024e989f4d35f35987a60e3af8022cac3420
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1875%2Fnewren%2Fendit-new-features-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1875/newren/endit-new-features-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1875

Range-diff vs v1:

 1:  9f73e54224d ! 1:  c2f2e3e0cd6 merge-ort: add new merge_ort_generic() function
     @@ Commit message
          equivalent for the final entry point, so we can switch callers to
          use it and remove merge-recursive.[ch].
      
     +    While porting it over, finally fix the issue with the label for the
     +    ancestor (used when merge.conflictStyle=diff3 as a conflict label).
     +    merge-recursive.c has traditionally not allowed callers to set that
     +    label, but I have found that problematic for years.
     +
     +    (Side note: This function was initially part of the merge-ort rewrite,
     +    but reviewers questioned the ancestor label funnyness which I was
     +    never really happy with anyway.  It resulted in me jettisoning it and
     +    hoping at the time that I would eventually be able to force the existing
     +    callers to use some other API.  That worked with `git stash`, as per
     +    874cf2a60444 (stash: apply stash using 'merge_ort_nonrecursive()',
     +    2022-05-10), but this API is the most reasonable one for `git am` and
     +    `git merge-recursive`, if we can just allow them some freedom over the
     +    ancestor label.)
     +
     +    The merge_recursive_generic() function did not know whether it was being
     +    invoked by `git stash`, `git merge-recursive`, or `git am`, and the
     +    choice of meaningful ancestor label, when there is a unique ancestor,
     +    varies for these different callers:
     +
     +      * git am: ancestor is a constructed "fake ancestor" that user knows
     +                nothing about and has no access to.  (And is different than
     +                the normal thing we mean by a "virtual merge base" which is
     +                the merging of merge bases.)
     +      * git merge-recursive: ancestor might be a tree, but at least it
     +                             was one specified by the user (if they invoked
     +                             merge-recursive directly)
     +      * git stash: ancestor was the commit serving as the stash base
     +
     +    Thus, using a label like "constructed merge base" (as
     +    merge_recursive_generic() does) presupposes that `git am` is the only
     +    caller; it is incorrect for other callers.  This label has thrown me off
     +    more than once.  Allow the caller to override when there is a unique
     +    merge base.
     +
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## merge-ort-wrappers.c ##
 2:  4292b22723f ! 2:  f401a8e0967 merge-ort: allow rename detection to be disabled
     @@ Commit message
          longer with the option disabled seems unlikely to help surface such
          issues at this point.  Also, there has been at least one request to
          allow rename detection to be disabled for behavioral rather than
     -    performance reasons, so let's start heeding the config and command line
     -    settings.
     +    performance reasons (see the thread including
     +    https://lore.kernel.org/git/CABPp-BG-Nx6SCxxkGXn_Fwd2wseifMFND8eddvWxiZVZk0zRaA@mail.gmail.com/
     +    ), so let's start heeding the config and command line settings.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ merge-ort.c: static int detect_and_process_renames(struct merge_options *opt)
       
       	if (!possible_renames(renames))
       		goto cleanup;
     -+	if (opt->detect_renames == 0) {
     ++	if (!opt->detect_renames) {
      +		renames->redo_after_renames = 0;
      +		renames->cached_pairs_valid_side = 0;
      +		goto cleanup;
     @@ merge-ort.c: static int detect_and_process_renames(struct merge_options *opt)
       
       	trace2_region_enter("merge", "regular renames", opt->repo);
       	detection_run |= detect_regular_renames(opt, MERGE_SIDE1);
     +
     + ## t/t4301-merge-tree-write-tree.sh ##
     +@@ t/t4301-merge-tree-write-tree.sh: test_expect_success 'Clean merge' '
     + 	test_cmp expect actual
     + '
     + 
     ++# Repeat the previous test, but turn off rename detection
     ++test_expect_success 'Failed merge without rename detection' '
     ++	test_must_fail git -c diff.renames=false merge-tree --write-tree side1 side3 >out &&
     ++	grep "CONFLICT (modify/delete): numbers deleted" out
     ++'
     ++
     + test_expect_success 'Content merge and a few conflicts' '
     + 	git checkout side1^0 &&
     + 	test_must_fail git merge side2 &&
 3:  c2a2be336e0 < -:  ----------- merge-ort: support having merge verbosity be set to 0
 -:  ----------- > 3:  a508b0a0fe2 merge-ort: support having merge verbosity be set to 0
 -:  ----------- > 4:  fefda4add11 t3650: document bug when directory renames are turned off
 -:  ----------- > 5:  b25225c3cab merge-ort: fix merge.directoryRenames=false
 -:  ----------- > 6:  3f4b74eb3b9 am: switch from merge_recursive_generic() to merge_ort_generic()

-- 
gitgitgadget
