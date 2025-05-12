Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73E679D2
	for <git@vger.kernel.org>; Mon, 12 May 2025 23:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747093328; cv=none; b=ciEZdnKH/uQZGGIWF48X7bdwp2J5N0k5kWLPnpM3/rM/XyMfc3B2udSHgtf8lzg5XRafMevqAYitm/DOfQNee/6MhhjMlf1T/iR5cx/J2oCwNZBcb/C9XERQHSYhkfqT6HxZ1nTG1qWy2st1oQF+oWZ5Z3/fCHQf55H9Kcp9VxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747093328; c=relaxed/simple;
	bh=bzJXsZY6k4JKsZyRwTBB6CnhwJEEk7shP7XKNrwzIK8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fntbuModpZ9V6ojb8ijiSRyKzieZIsP3bIhvwv7j3+MDi46sgbu+vMEZeebIRwr9Zk8e0haZvnCsfhpkyKj2JikmvDCu8HsksV+OBghw0HQ+3O6ztJaKW9AfWxeFM+ATs4lR1aH4i9v9VGZ2dYVGfWPSygkFtDUpQhTmP2NvJ9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSqLMlsM; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSqLMlsM"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso33656805e9.2
        for <git@vger.kernel.org>; Mon, 12 May 2025 16:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747093324; x=1747698124; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ri8Htqb1tcJ0/b9/FTKDyYxMmpgTgWvNj899rkIoQE=;
        b=aSqLMlsM6k+juwgzzJz46Ebd8NdoN5FXG7PbBZlHPBHNgmIQOt1hysQYUDsVp8wOST
         pnIajge1+RD7+1M0sWWg6xBB32ICzP7ajKiU+I2ryUk9vcXip7mEKIOf3SmzVkjZCqgu
         kzIzEDSgdSEL9unyq8boqdfvZ4gf8z2eTVzFGupn6N6D6+d5M4SAUI9mhdOFs2zDbpNU
         ECRgVRooyGKYLnzNaYOJZCUuu13KuAfSMctZi9110obUrBinBmazS0ICGOOk8833uDVh
         AJXY+joTaDKrJ/8nRyVCwYDG9GspoqrikVsrhHG/E/8QPS6AX5Wzi11XGfMFlIQ241gf
         KHzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747093324; x=1747698124;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ri8Htqb1tcJ0/b9/FTKDyYxMmpgTgWvNj899rkIoQE=;
        b=Aflic+xzVzmtK1X+zd5fjmu67inzoFU3emxPcRBR3+XHx4djtBtFs5azoNIyeyBGy3
         ShCV8Zis11RX+znuagw7zD9ZyywX24QzlEWnm38nQLp7OYZMQQqS3DOinXGL6yfPbYBW
         DW+DgiOj/cZAwDdOdtChERJ9/JQaH9RQvmETPsQw1nnsNQyJ15muOdvzg1TolHMyY+Nc
         MZMWqUFQGKezlSSVM6Qu1XXvg4Rf2dDQKGno/NGISVeEGiUtDfOvVJ+y4wXFhi4bZ9wK
         4T3z/Y0f+m5kGtfdb6/iPVaD1xrF08x1suC8zanWA5jDaH06fM1eQLqfiFyECt+Ok8gs
         r7Iw==
X-Gm-Message-State: AOJu0YwGKf3uEPlzyIghYczf5l5Kwl8t7/NG7nlLCbYquA2XVKHPa3sV
	5GHytp0euoOLcYYXXRlTeoRjtaAJaquWCrVKU/iexwLfAruw8JQWAdbNfA==
X-Gm-Gg: ASbGnctdQsAGg3fWxxrGUBraR2DgTBpGRnFSE2V4sHy/Nh2Hg+yX3Ic3FHxB8Ct8Uj6
	pQoQib55lxXuZQclCaNnjZtpDXsO7q3e8RelQERPsVD4S4YWaElj6yF80Dptsqj39KL1GxEx9+Q
	I1XMUtm5xnyzP0h9Vl8SQkDJFALV3fVZte8et+frWuWeht0fY5Rb1Xzx9kZNePFVQeFdP0bnO0f
	gbAut7bM/HIJMWnqvzDdsYOgId9j7edRzb3E1hsuA2ICt85DHNVgeZIe6yWXmWoy9fKIj5+k0lD
	WFmHgK2lSWZi0uovlFZZQKuZLCtKiHadTTb9fYlZf9CcGfFT4yHK
X-Google-Smtp-Source: AGHT+IGbHlYuanRtUYPHH1vd1mTIhUV2R7kkB9M4fZ58IpnUS1WbxOzRYRffK/n9SbUJ23gdbYwvKg==
X-Received: by 2002:a05:600c:8211:b0:43b:c0fa:f9dd with SMTP id 5b1f17b1804b1-442d6dd22edmr106116285e9.25.1747093324042;
        Mon, 12 May 2025 16:42:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d5cf5d6bsm148693645e9.1.2025.05.12.16.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 16:42:03 -0700 (PDT)
Message-Id: <pull.1920.v2.git.1747093322.gitgitgadget@gmail.com>
In-Reply-To: <pull.1920.git.1746914561.gitgitgadget@gmail.com>
References: <pull.1920.git.1746914561.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 12 May 2025 23:42:00 +0000
Subject: [PATCH v2 0/2] merge-tree: add new --dry-run option
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

Changes since v1:

 * Renamed --mergeability-only flag to --dry-run, as per suggestion from
   Junio
 * added some commit message clarifications

This adds a new flag, --dry-run, to git merge-tree, which suppresses all
output and leaves only the exit status (reflecting successful merge or
conflict). This is useful for Git Forges in cases where they are only
interested in whether two branches can be merged, without needing the actual
merge result or conflict details.

The advantage of the flag is two fold:

 * The merge machinery can exit once it detects a conflict, instead of
   continuing to compute merge result information
 * The merge machinery can avoid writing merged blobs and trees to the
   object store when in the outer layer of the merging process (more details
   in the first commit message).

Elijah Newren (2):
  merge-ort: add a new mergeability_only option
  merge-tree: add a new --dry-run flag

 Documentation/git-merge-tree.adoc |  6 +++++
 builtin/merge-tree.c              | 22 ++++++++++++++++++
 merge-ort.c                       | 38 +++++++++++++++++++++++++------
 merge-ort.h                       |  1 +
 t/t4301-merge-tree-write-tree.sh  | 38 +++++++++++++++++++++++++++++++
 5 files changed, 98 insertions(+), 7 deletions(-)


base-commit: 6c0bd1fc70efaf053abe4e57c976afdc72d15377
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1920%2Fnewren%2Fmergeability-only-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1920/newren/mergeability-only-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1920

Range-diff vs v1:

 1:  09292804cff ! 1:  4757c4810d3 merge-ort: add a new mergeability_only option
     @@ Commit message
          Git Forges may be interested in whether two branches can be merged while
          not being interested in what the resulting merge tree is nor which files
          conflicted.  For such cases, add a new mergeability_only option.  This
     -    option allows the merge machinery to, in the outer layer of the merge:
     -      * exit upon first conflict
     -      * avoid writing merged blobs/trees to the object store
     +    option allows the merge machinery to, in the "outer layer" of the merge:
     +      * exit upon first[-ish] conflict
     +      * avoid (not prevent) writing merged blobs/trees to the object store
     +
     +    I have a number of qualifiers there, so let me explain each:
     +
     +    "outer layer":
      
          Note that since the recursive merge of merge bases (corresponding to
     -    call_depth > 0) can conflict without the outer final merge (corresponding
     -    to call_depth == 0) conflicting, we can't short-circuit nor avoid
     -    writing merges blobs/trees to the object store during those inner
     -    merges.
     +    call_depth > 0) can conflict without the outer final merge
     +    (corresponding to call_depth == 0) conflicting, we can't short-circuit
     +    nor avoid writing merged blobs/trees to the object store during those
     +    inner merges.
     +
     +    "first-ish conflict":
     +
     +    The current patch only exits early from process_entries() on the first
     +    conflict it detects, but conflicts could have been detected in a
     +    previous function call, namely detect_and_process_renames().  However:
     +      * conflicts detected by detect_and_process_renames() are quite rare
     +        conflict types
     +      * the detection would still come after regular rename detection
     +        (which is the expensive part of detect_and_process_renames()), so
     +        it is not saving us much in computation time given that
     +        process_entries() directly follows detect_and_process_renames()
     +      * [this overlaps with the next bullet point] process_entries() is the
     +        place where virtually all object writing occurs (object writing is
     +        sometimes more of a concern for Forges than computation time), so
     +        exiting early here isn't saving us much in object writes either
     +      * the code changes needed to handle an earlier exit are slightly
     +        more invasive in detect_and_process_renames() than for
     +        process_entries().
     +    Given the rareness of the even earlier conflicts, the limited savings
     +    we'd get from exiting even earlier, and in an attempt to keep this
     +    patch simpler, we don't guarantee that we actually exit on the first
     +    conflict detected.  We can always revisit this decision later if we
     +    decide that a further micro-optimization to exit slightly earlier in
     +    rare cases is worthwhile.
     +
     +    "avoid (not prevent) writing objects":
      
     -    There is a further potential micro-optimization here.  rename/rename
     -    conflicts have the potential for nested conflicts even without recursive
     -    merges; because of that, handle_content_merge() can be called multiple
     -    times and is done via different paths.  Currently, we only exit early in
     -    process_entries(), which is where the final handle_content_merge() is
     -    invoked.  Since rename/rename conflicts have an additional earlier
     -    handle_content_merge() call that can be invoked from
     -    detect_and_process_renames() (via process_renames()), we could
     -    potentially exit earlier at that call point.  However, rename/rename
     -    conflicts are exceptionally rare, and feeding the extra logic through
     -    didn't seem worth it.  (And, if we don't exit early at that point, then
     -    any resulting blobs need to be written to the store so that subsequent
     -    handle_content_merge() calls trying to use the blob don't throw
     -    exceptions.)
     +    The detect_and_process_renames() call can also write objects to the
     +    object store, when rename/rename conflicts involve one (or more) files
     +    that have also been modified on both sides.  Because of this alternate
     +    call path leading to handle_content_merges(), our "early exit" does not
     +    prevent writing objects entirely, even within the "outer layer"
     +    (i.e. even within call_depth == 0).  I figure that's fine though, since
     +    we're already writing objects for the inner merges (i.e. for call_depth
     +    > 0), which are likely going to represent vastly more objects than files
     +    involved in rename/rename+modify/modify cases in the outer merge, on
     +    average.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
 2:  0b32c80d286 ! 2:  1d18ab7feb8 merge-tree: add a new --mergeability-only flag
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    merge-tree: add a new --mergeability-only flag
     +    merge-tree: add a new --dry-run flag
      
          Git Forges may be interested in whether two branches can be merged while
          not being interested in what the resulting merge tree is nor which files
     -    conflicted.  For such cases, add a new --mergeability-only flag which
     +    conflicted.  For such cases, add a new --dry-run flag which
          will make use of the new mergeability_only flag added to merge-ort in
          the previous commit.  This option allows the merge machinery to, in the
          outer layer of the merge:
     -          * exit upon first conflict
     -          * avoid writing merged blobs/trees to the object store
     +        * exit early when a conflict is detected
     +        * avoid writing (most) merged blobs/trees to the object store
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ builtin/merge-tree.c: int cmd_merge_tree(int argc,
       	int original_argc;
       	const char *merge_base = NULL;
       	int ret;
     -+	int mergeability_only = 0;
     ++	int dry_run = 0;
       
       	const char * const merge_tree_usage[] = {
       		N_("git merge-tree [--write-tree] [<options>] <branch1> <branch2>"),
     @@ builtin/merge-tree.c: int cmd_merge_tree(int argc,
       			    N_("do a trivial merge only"), MODE_TRIVIAL),
       		OPT_BOOL(0, "messages", &o.show_messages,
       			 N_("also show informational/conflict messages")),
     -+		OPT_BOOL_F(0, "mergeability-only",
     -+			   &mergeability_only,
     ++		OPT_BOOL_F(0, "dry-run",
     ++			   &dry_run,
      +			   N_("suppress all output; only exit status wanted"),
      +			   PARSE_OPT_NONEG),
       		OPT_SET_INT('z', NULL, &line_termination,
     @@ builtin/merge-tree.c: int cmd_merge_tree(int argc,
       	argc = parse_options(argc, argv, prefix, mt_options,
       			     merge_tree_usage, PARSE_OPT_STOP_AT_NON_OPTION);
       
     -+	if (mergeability_only && o.show_messages == -1)
     ++	if (dry_run && o.show_messages == -1)
      +		o.show_messages = 0;
     -+	o.merge_options.mergeability_only = mergeability_only;
     -+	die_for_incompatible_opt2(mergeability_only, "--mergeability-only",
     ++	o.merge_options.mergeability_only = dry_run;
     ++	die_for_incompatible_opt2(dry_run, "--mergeability-only",
      +				  o.show_messages, "--messages");
     -+	die_for_incompatible_opt2(mergeability_only, "--mergeability-only",
     ++	die_for_incompatible_opt2(dry_run, "--mergeability-only",
      +				  o.name_only, "--name-only");
     -+	die_for_incompatible_opt2(mergeability_only, "--mergeability-only",
     ++	die_for_incompatible_opt2(dry_run, "--mergeability-only",
      +				  o.use_stdin, "--stdin");
     -+	die_for_incompatible_opt2(mergeability_only, "--mergeability-only",
     ++	die_for_incompatible_opt2(dry_run, "--mergeability-only",
      +				  !line_termination, "-z");
      +
       	if (xopts.nr && o.mode == MODE_TRIVIAL)
     @@ t/t4301-merge-tree-write-tree.sh: test_expect_success setup '
       	git commit -m first-commit
       '
       
     -+test_expect_success '--mergeability-only on clean merge' '
     ++test_expect_success '--dry-run on clean merge' '
      +	# Get rid of loose objects to start with
      +	git gc &&
      +	echo "0 objects, 0 kilobytes" >expect &&
     @@ t/t4301-merge-tree-write-tree.sh: test_expect_success setup '
      +	test_cmp expect actual &&
      +
      +	# Ensure merge is successful (exit code of 0)
     -+	git merge-tree --write-tree --mergeability-only side1 side3 >output &&
     ++	git merge-tree --write-tree --dry-run side1 side3 >output &&
      +
      +	# Ensure there is no output
      +	test_must_be_empty output &&
     @@ t/t4301-merge-tree-write-tree.sh: test_expect_success 'Failed merge without rena
       	grep "CONFLICT (modify/delete): numbers deleted" out
       '
       
     -+test_expect_success  '--mergeability-only on conflicted merge' '
     ++test_expect_success  '--dry-run on conflicted merge' '
      +	# Get rid of loose objects to start with
      +	git gc &&
      +	echo "0 objects, 0 kilobytes" >expect &&
     @@ t/t4301-merge-tree-write-tree.sh: test_expect_success 'Failed merge without rena
      +	test_cmp expect actual &&
      +
      +	# Ensure merge has conflict
     -+	test_expect_code 1 git merge-tree --write-tree --mergeability-only side1 side2 >output &&
     ++	test_expect_code 1 git merge-tree --write-tree --dry-run side1 side2 >output &&
      +
      +	# Ensure there is no output
      +	test_must_be_empty output &&

-- 
gitgitgadget
