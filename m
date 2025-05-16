Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03D622688B
	for <git@vger.kernel.org>; Fri, 16 May 2025 20:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747425864; cv=none; b=tq8Bkk2pl9XPuL9y7qP00bdHEAMx6E2MRkl9wjx516bygw9l5xfuB+w9/UTev4WbYI2PJ2Y6I037Td9crMpsOukLy6PdPh73Pw8YkWwLXSN6OXDf+UNmTpozYZJtFZxNtrLsubBBpMASmUKAW81JJNetlQeLdslu4IgjRUS2oKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747425864; c=relaxed/simple;
	bh=kmPDt3IAZIaXAth5LmQs4j70Oske5x7Mz9eb2STh2BY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=WSDz4XzsXEEaR3CnCpMnkmwZsJk8BwhSY8jl8Dsw+MIj8InvvE86W0iJXTMRMBxYmXVjhZ+YcH4kcQYHYcs8K7b9dh9GXY102Zj45pgrBJ2Tctx7m4oMu4lBaYChxld5UITAFSd4hUU2eLl3FC802v4j2hKEtW4hX+IXh0eO+X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwJmp+km; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwJmp+km"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43ede096d73so17709915e9.2
        for <git@vger.kernel.org>; Fri, 16 May 2025 13:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747425860; x=1748030660; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FvdMkBDLZPQOqfDX/TxYh+HP67wvjVnJmVudbg5ZMtE=;
        b=KwJmp+km8JjSPV9CFPforhvlE049UVTG9EMsYgeujw/HN3515Z0j/cc+NnVuXbZgA5
         ptCmsCv8MM2yT6UvPgy86G74cQwqp8+tOx11dsw6LZBmYnwcEIdH7BeQavu0WWxw/qD3
         M43oB98TvsmBPskzTdAn3IQF8lEZ+QggKl1jgoZ1kWhXLdlwrG3gAQuLuZ+5kmeXqnng
         E43CM9IxJ8i+KtkTUTdyiSHydJZ6E/oM4BSqY8BmCKgFXwwsE8SOAeXn4RUKifNgwdf7
         bnzhADiRDNsnwimsCv/3pHhinBwZgvqdotTfJTTsBzqPoM6kkGqSl6XJWDBHkPvNrP7N
         qsQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747425860; x=1748030660;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FvdMkBDLZPQOqfDX/TxYh+HP67wvjVnJmVudbg5ZMtE=;
        b=Qe0GKxZBL3QeBe5sdoOjHQlKfiiTVbIKrcVhUu+bhZ+Lw9X9gFQDhjPDsymQNsHfgi
         UCUGU7AS5jp+6IBry5sdpnmtPlJK5Fvk9HD8yVnWCsKxgU4ToNLICdwE1rIZHYbvuFBB
         UrrKmQf7fagm4nANoIaAC9EjevhulZ5IfgFXjX7buiptFbWVTJimN+At7OTdjcpHdoNn
         qc8Nfb9gehvy7SY75+WesHH4NyeeWHqfi6Ijd/BskaL0O9N8H94iQDu5pnbiUVP9zKP0
         fI55qW1Rnwqu5KfScrOsRNncchFXsSbJpwy0gYWmVbqlnoN2FTUnFP2BBbg6tFyOlQlV
         yNvQ==
X-Gm-Message-State: AOJu0YwzCy2/i/Fkp/mePhf8qG7Yp//dljwgANZqLeP0axRHoDjggAVT
	/HyASTomD7iOCHMT+ETZ2hRdHWSCq6RmSiyYqN6Rm3HdYSUbHIBiRCGtEBq4Zg==
X-Gm-Gg: ASbGncsIUL3fUGgZ9+guvNPOMubu3N24StPyTvr4Onr43AlGIXfDTw4U4IcWWQm/cbc
	+uvLWJf3p1PBv6iKYix5nG+EZ1Mp1c4TqS4cisjMwguhj9pTtSrV/JNPLN99DfTrUzvhbc/6KIc
	KxiKATJtJCMMKsoy2hrUgJiMEJ9AiIJqPVqf0LmMOZ5pB9HQPDFialMaN3QFdYvckzAbvP3HbRl
	ZuL5nEW1A3r3SeHhjLoQMDI2ZBpJXBI2AhKSPwhiK7L9tPOSzSAbvzNHgncN4bYW7vkvbcBhZYQ
	5o45/njkib6DlzGrgA3xXvFGpJ004a0qY3w/fi9HgticQPOInXHc
X-Google-Smtp-Source: AGHT+IE7ElgFbv9tkjWxMH07+EO8U1sm3uOKj8L2prn1SDRJcd5GH3+BH2JD+Fdfh3TLtBAAl0GEYQ==
X-Received: by 2002:a05:600c:64cc:b0:43d:82c:2b11 with SMTP id 5b1f17b1804b1-442fd664f7dmr43574425e9.23.1747425860114;
        Fri, 16 May 2025 13:04:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442fd515130sm43628935e9.18.2025.05.16.13.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 13:04:19 -0700 (PDT)
Message-Id: <pull.1920.v4.git.1747425858.gitgitgadget@gmail.com>
In-Reply-To: <pull.1920.v3.git.1747182287.gitgitgadget@gmail.com>
References: <pull.1920.v3.git.1747182287.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 16 May 2025 20:04:16 +0000
Subject: [PATCH v4 0/2] merge-tree: add new --quiet option
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
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Elijah Newren <newren@gmail.com>

Changes since v3:

 * Renamed --dry-run -> --quiet . Any further naming suggestions?

Changes since v2:

 * Converted locations missed in v1 in changing --mergeability-only ->
   --dry-run

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
  merge-tree: add a new --quiet flag

 Documentation/git-merge-tree.adoc |  6 +++++
 builtin/merge-tree.c              | 18 +++++++++++++++
 merge-ort.c                       | 38 +++++++++++++++++++++++++------
 merge-ort.h                       |  1 +
 t/t4301-merge-tree-write-tree.sh  | 38 +++++++++++++++++++++++++++++++
 5 files changed, 94 insertions(+), 7 deletions(-)


base-commit: 6c0bd1fc70efaf053abe4e57c976afdc72d15377
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1920%2Fnewren%2Fmergeability-only-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1920/newren/mergeability-only-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1920

Range-diff vs v3:

 1:  4757c4810d3 = 1:  4757c4810d3 merge-ort: add a new mergeability_only option
 2:  f11824317a8 ! 2:  7c40d3c9216 merge-tree: add a new --dry-run flag
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    merge-tree: add a new --dry-run flag
     +    merge-tree: add a new --quiet flag
      
          Git Forges may be interested in whether two branches can be merged while
          not being interested in what the resulting merge tree is nor which files
     -    conflicted.  For such cases, add a new --dry-run flag which
     +    conflicted.  For such cases, add a new --quiet flag which
          will make use of the new mergeability_only flag added to merge-ort in
          the previous commit.  This option allows the merge machinery to, in the
          outer layer of the merge:
     @@ Documentation/git-merge-tree.adoc: OPTIONS
       	default is to include these messages if there are merge
       	conflicts, and to omit them otherwise.
       
     -+--dry-run::
     ++--quiet::
      +	Disable all output from the program.  Useful when you are only
      +	interested in the exit status.  Allows merge-tree to exit
      +	early when it finds a conflict, and allows it to avoid writing
     @@ builtin/merge-tree.c: int cmd_merge_tree(int argc,
       	int original_argc;
       	const char *merge_base = NULL;
       	int ret;
     -+	int dry_run = 0;
     ++	int quiet = 0;
       
       	const char * const merge_tree_usage[] = {
       		N_("git merge-tree [--write-tree] [<options>] <branch1> <branch2>"),
     @@ builtin/merge-tree.c: int cmd_merge_tree(int argc,
       			    N_("do a trivial merge only"), MODE_TRIVIAL),
       		OPT_BOOL(0, "messages", &o.show_messages,
       			 N_("also show informational/conflict messages")),
     -+		OPT_BOOL_F(0, "dry-run",
     -+			   &dry_run,
     ++		OPT_BOOL_F(0, "quiet",
     ++			   &quiet,
      +			   N_("suppress all output; only exit status wanted"),
      +			   PARSE_OPT_NONEG),
       		OPT_SET_INT('z', NULL, &line_termination,
     @@ builtin/merge-tree.c: int cmd_merge_tree(int argc,
       	argc = parse_options(argc, argv, prefix, mt_options,
       			     merge_tree_usage, PARSE_OPT_STOP_AT_NON_OPTION);
       
     -+	if (dry_run && o.show_messages == -1)
     ++	if (quiet && o.show_messages == -1)
      +		o.show_messages = 0;
     -+	o.merge_options.mergeability_only = dry_run;
     -+	die_for_incompatible_opt2(dry_run, "--dry-run",
     -+				  o.show_messages, "--messages");
     -+	die_for_incompatible_opt2(dry_run, "--dry-run",
     -+				  o.name_only, "--name-only");
     -+	die_for_incompatible_opt2(dry_run, "--dry-run",
     -+				  o.use_stdin, "--stdin");
     -+	die_for_incompatible_opt2(dry_run, "--dry-run",
     -+				  !line_termination, "-z");
     ++	o.merge_options.mergeability_only = quiet;
     ++	die_for_incompatible_opt2(quiet, "--quiet", o.show_messages, "--messages");
     ++	die_for_incompatible_opt2(quiet, "--quiet", o.name_only, "--name-only");
     ++	die_for_incompatible_opt2(quiet, "--quiet", o.use_stdin, "--stdin");
     ++	die_for_incompatible_opt2(quiet, "--quiet", !line_termination, "-z");
      +
       	if (xopts.nr && o.mode == MODE_TRIVIAL)
       		die(_("--trivial-merge is incompatible with all other options"));
     @@ t/t4301-merge-tree-write-tree.sh: test_expect_success setup '
       	git commit -m first-commit
       '
       
     -+test_expect_success '--dry-run on clean merge' '
     ++test_expect_success '--quiet on clean merge' '
      +	# Get rid of loose objects to start with
      +	git gc &&
      +	echo "0 objects, 0 kilobytes" >expect &&
     @@ t/t4301-merge-tree-write-tree.sh: test_expect_success setup '
      +	test_cmp expect actual &&
      +
      +	# Ensure merge is successful (exit code of 0)
     -+	git merge-tree --write-tree --dry-run side1 side3 >output &&
     ++	git merge-tree --write-tree --quiet side1 side3 >output &&
      +
      +	# Ensure there is no output
      +	test_must_be_empty output &&
     @@ t/t4301-merge-tree-write-tree.sh: test_expect_success 'Failed merge without rena
       	grep "CONFLICT (modify/delete): numbers deleted" out
       '
       
     -+test_expect_success  '--dry-run on conflicted merge' '
     ++test_expect_success  '--quiet on conflicted merge' '
      +	# Get rid of loose objects to start with
      +	git gc &&
      +	echo "0 objects, 0 kilobytes" >expect &&
     @@ t/t4301-merge-tree-write-tree.sh: test_expect_success 'Failed merge without rena
      +	test_cmp expect actual &&
      +
      +	# Ensure merge has conflict
     -+	test_expect_code 1 git merge-tree --write-tree --dry-run side1 side2 >output &&
     ++	test_expect_code 1 git merge-tree --write-tree --quiet side1 side2 >output &&
      +
      +	# Ensure there is no output
      +	test_must_be_empty output &&

-- 
gitgitgadget
