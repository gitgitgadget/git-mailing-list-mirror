Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3421CFBC
	for <git@vger.kernel.org>; Wed, 14 May 2025 00:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747182293; cv=none; b=qRJ+/vB4bInH4zb1EoqUYDMp35kXlcbUDfeD2WJ+wOFu9yqfc96hZjj3Xbw2dO/m59U6R52cViQxNkFgZHwcpVpl9qX2Gl2p2Fb3zOqKagaWfTEIOYy7lWqH/nbsOPqwWp6O9tgbCD3T74nWOrmaztg7IC5Wot20KRPOw0ZQi/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747182293; c=relaxed/simple;
	bh=78InPCyBI+M3q1zS74+Y5H3/+eL9uRnASZBdQCti9VI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uCbapT8fC2xtaZcNTMFxzZsdRBuB0RMgLY78PLuf7A8b1khFumvVorj3NcTbsM6OqnvPSM/0T/30JRCrmQPopuuwzYz2AZv12TUHJzn345KEFts4OiuVcDkR9XPF5R7l6LzctZjujVSIQKRY6qBGSOXp6oWCGmbmxbRF6XV3jxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJQU75VB; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJQU75VB"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a0b9625662so5094276f8f.3
        for <git@vger.kernel.org>; Tue, 13 May 2025 17:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747182290; x=1747787090; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wIsqXQaolsKsXBUzv5VyZwvmFoUxRu5pHJ+jebH7XQk=;
        b=LJQU75VBI7zugVaXaZvxcICD+SRIHoz5wKj20UTd5mQQmxeiyDnlyr+6aEBBP9RM50
         zYWWagGT6FwPyeClMbEy7ag28S1XmaF9LJoqf+md+G8ufWrMTRZE7YS4Lw3bz4Ag4u2a
         MiG4lTaYBYP+3CDlIRXPuPOMUw3uDTjbtFpL77ThkJ1/gPbPa1anPU89g5STkm4tH993
         gcPYm7eiQEatfj/FWvVtd16TLoPI9HckIxu2TUlfeDK2TaFMqukNjrVyLvfk1BdqvbYu
         IgGuvnoRW81wkk85ClNPVByMBVIGQVI3kOPv+VRQt3Bj4AvnGWMA+NmgF/xpghAcoePh
         cDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747182290; x=1747787090;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wIsqXQaolsKsXBUzv5VyZwvmFoUxRu5pHJ+jebH7XQk=;
        b=vCEtNfJdURZl2vbROsg+lJu9ySFYmz9xZwxcB9/DEQ6y2fDSy7Z6qP7YvzxGEDrzh1
         Jviuj8f/JGY2p/rVQcJkZZjVdvAfFXGGgKmALelEB9sP3/Y1X23xKRQDUh3oC89Xcyf8
         10gYvl9C/2P8RaCRdznZJb76FvyDTWLes0S6dIHX2x8MyMAHEBTiXPU1nEYsbSoNy3ef
         LYyP+uaGxkDKSCwlaR9fickA1hR3B5sABd6y0/u27+lXDVqWCRUW3C0NlJWu7trpNrKC
         oNip7BvFcMXc0f2dnrESKFmGm93GPy+hEkDnw8NiSUyM4yjL25vmKdTj6gCzlAEGC5ka
         xP3w==
X-Gm-Message-State: AOJu0Yz8EyKT0p1hdB5x4vtZT4m1i/uuHWci+RnA0Lq+pJ1UeXkblXLJ
	4HdVdETZPi4SJ8U+eo+2B1xzSteHm4UwMR3dOEdkN7jj5TzYuYJFVALecg==
X-Gm-Gg: ASbGncsG8PbCGeCmgRo0zb4gBTVTpJEhkwlKL4Uc/FjbtMS7xTqPxg1r99Bq0uDyFGj
	cHIe/iJGLtJQPM6Z7d3rT353xMwlEmxBaGyn7DgnXFjQRmmxVYGrEQDUeUphAC9R02WKHT+gd03
	IyRAdEuElkYH2iGt6wXB5+nKSqeeQ9Zj3lkI6zOH8P5r7iwAFeufB/ifbRSLRdXXBE8zAOaKDVJ
	Ur5ZS98pHzUYJpo9NgXffu1oaTSD62b+KtjhZSPHZq6vBn/cdcxSjd37MNzzz/OO5fUzwQFL5ZF
	5U7XPaauj7TyFb7WyGd7/vH1WNWZ5BUP/QrGM1jgH1LTflQUOPsczgVKMeCID6o=
X-Google-Smtp-Source: AGHT+IFZUehg7zTn/iJGBy/ImATnYQFKeiFiuHbysItFu6LjXRkYwXuXQL6WymXNq5B5EAocPUl4hg==
X-Received: by 2002:a05:6000:250a:b0:39c:cc7:3c97 with SMTP id ffacd0b85a97d-3a349966528mr844962f8f.50.1747182290007;
        Tue, 13 May 2025 17:24:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a4c599sm18169795f8f.94.2025.05.13.17.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 17:24:49 -0700 (PDT)
Message-Id: <pull.1920.v3.git.1747182287.gitgitgadget@gmail.com>
In-Reply-To: <pull.1920.v2.git.1747093322.gitgitgadget@gmail.com>
References: <pull.1920.v2.git.1747093322.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 14 May 2025 00:24:45 +0000
Subject: [PATCH v3 0/2] merge-tree: add new --dry-run option
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
    Elijah Newren <newren@gmail.com>

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
  merge-tree: add a new --dry-run flag

 Documentation/git-merge-tree.adoc |  6 +++++
 builtin/merge-tree.c              | 22 ++++++++++++++++++
 merge-ort.c                       | 38 +++++++++++++++++++++++++------
 merge-ort.h                       |  1 +
 t/t4301-merge-tree-write-tree.sh  | 38 +++++++++++++++++++++++++++++++
 5 files changed, 98 insertions(+), 7 deletions(-)


base-commit: 6c0bd1fc70efaf053abe4e57c976afdc72d15377
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1920%2Fnewren%2Fmergeability-only-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1920/newren/mergeability-only-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1920

Range-diff vs v2:

 1:  4757c4810d3 = 1:  4757c4810d3 merge-ort: add a new mergeability_only option
 2:  1d18ab7feb8 ! 2:  f11824317a8 merge-tree: add a new --dry-run flag
     @@ Documentation/git-merge-tree.adoc: OPTIONS
       	default is to include these messages if there are merge
       	conflicts, and to omit them otherwise.
       
     -+--mergeability-only::
     ++--dry-run::
      +	Disable all output from the program.  Useful when you are only
      +	interested in the exit status.  Allows merge-tree to exit
     -+	early on the first conflict it finds, and allows it to avoid
     -+	writing most objects created by merges.
     ++	early when it finds a conflict, and allows it to avoid writing
     ++	most objects created by merges.
      +
       --allow-unrelated-histories::
       	merge-tree will by default error out if the two branches specified
     @@ builtin/merge-tree.c: int cmd_merge_tree(int argc,
      +	if (dry_run && o.show_messages == -1)
      +		o.show_messages = 0;
      +	o.merge_options.mergeability_only = dry_run;
     -+	die_for_incompatible_opt2(dry_run, "--mergeability-only",
     ++	die_for_incompatible_opt2(dry_run, "--dry-run",
      +				  o.show_messages, "--messages");
     -+	die_for_incompatible_opt2(dry_run, "--mergeability-only",
     ++	die_for_incompatible_opt2(dry_run, "--dry-run",
      +				  o.name_only, "--name-only");
     -+	die_for_incompatible_opt2(dry_run, "--mergeability-only",
     ++	die_for_incompatible_opt2(dry_run, "--dry-run",
      +				  o.use_stdin, "--stdin");
     -+	die_for_incompatible_opt2(dry_run, "--mergeability-only",
     ++	die_for_incompatible_opt2(dry_run, "--dry-run",
      +				  !line_termination, "-z");
      +
       	if (xopts.nr && o.mode == MODE_TRIVIAL)

-- 
gitgitgadget
