Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AD819474
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 08:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708677272; cv=none; b=f6IAkmPBK/j/k8kDGMwGwVQmUQC6eeQrvXB4YyFiTnkS81Y1VlSje69XcQJ6IQ7kCvTp1RARiVVxRe/IU0DmNGqyv7WD3ESeTYQsiucvSHiuuSULCy4/8QX8eunOeI5NRjX/DtW2wFRr562tuXKhaWRNpWgUh9PGScZ3+Zm+OFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708677272; c=relaxed/simple;
	bh=4aNEnAaqPRNWt8+9DNbLkhJTVJWA67rbRzZESNBrgGg=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=X5+ha3+xtPCQN7uZZjeWr5SRQ6fRMnz2oZeZ6JxFP4rJuuegV8D1OVuymNL2RssOqkawTLKLOlzdB5jD3MT9uWvm1VDGK6fZtq0x1m4U/eII1XfII62b7jAVxLrt0+FQtAVT2fhI0krEo4zNVkqTBWUGX9SnvChsmFide6zzyoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZaPdEAGm; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZaPdEAGm"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4128d787765so4033315e9.0
        for <git@vger.kernel.org>; Fri, 23 Feb 2024 00:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708677268; x=1709282068; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bYGTUlB/gCIIZYbvj7AyOaK8YzaamWYRixmDSuqV9UQ=;
        b=ZaPdEAGmfooJ+iGydmONmEZbFV/VPVbYYzJ6V4EsVpJn5Ki+930sE3984mwc4JZx7j
         TsZT4YFKJ6sMXrn7nPwADpxRYmLTesHA47hapeLk+OcwGZhKFMDCOcanPQiK6A4z9orZ
         W5f4SnZQs+gCXVkpiCrRtcCDxPUaf5p2/Sm509kwecGu2eGNl+Z7N5N0r26IFEhnTbaU
         B0NUHs4WQHtG83Jc54Rn7e9HPk47aqHvBXbJuaTCOk8ypuCP1gj7SFycRVQe3+dffb3U
         6kS6Aa3lm8UHf9P84uMFKWbyB0M4aXT2M+VH3X/6d381uAbuU5yZo82NEcj1Foiev0Zp
         eQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708677268; x=1709282068;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bYGTUlB/gCIIZYbvj7AyOaK8YzaamWYRixmDSuqV9UQ=;
        b=xH+LymYGCcFR8aZJD+3YNkSHCa0O0b9rPCPazzQGvx6txsr5OrgexmDtHuPiErQeze
         us9TpnqGgOd3wLXZDLk92nmYNvBTbB5F+mE2aaGDXL4P5zTX4MZalKq1vx8mX2+hW1UY
         3pToUe7QJglnlUekuQ/Q8sAiYvLD9vBIagoNivnpHVDGd359hT+g8Ps7qT6h+mTvf4bU
         lz9w2WLrsioGKxkAVvsq6aOYIJoxeBli/ePJw+PrEGSMch+5FwSTDIQVK40HA80nswrm
         yJJW2S7z2WKD2koqZpe0EhY7u9h8UrOU+VYEofBxWwsxMbxOS2bowor0+0J1oqBorpaw
         qbhg==
X-Gm-Message-State: AOJu0Yx346TYjWUXIvZieD4hhOJ4hyaINaohWgxgQrCqn+mdBKhZtCgk
	RLm4vUYXLAmZKlVAWrv8DE2szYILpz4p+SUz+vR/6GlupUlRujQN2Sf/Fd9h
X-Google-Smtp-Source: AGHT+IHvxtgVW47d0axqJt4GITCeP6wB2XKMesD3rUKNfYRdVkqoYGsLZhe8m5sIPab1W0Xxkr6FnA==
X-Received: by 2002:a05:600c:1d20:b0:412:9569:6791 with SMTP id l32-20020a05600c1d2000b0041295696791mr403488wms.21.1708677267645;
        Fri, 23 Feb 2024 00:34:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m4-20020a05600c4f4400b004128d6ddad3sm1538558wmq.0.2024.02.23.00.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 00:34:27 -0800 (PST)
Message-ID: <pull.1651.v4.git.1708677266.gitgitgadget@gmail.com>
In-Reply-To: <pull.1651.v3.git.1708612605.gitgitgadget@gmail.com>
References: <pull.1651.v3.git.1708612605.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 Feb 2024 08:34:19 +0000
Subject: [PATCH v4 0/6] merge-tree: handle missing objects correctly
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
    Eric Sunshine <sunshine@sunshineco.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

I recently looked into issues where git merge-tree calls returned bogus data
(in one instance returning an empty tree for non-empty merge parents). By
the time I had a look at the corresponding repository, the issue was no
longer reproducible, but a closer look at the code combined with some manual
experimenting turned up the fact that missing tree objects aren't handled as
errors by git merge-tree.

While at it, I added a commit on top that tries to catch all remaining
unchecked parse_tree() calls.

This patch series is based on 5f43cf5b2e4 (merge-tree: accept 3 trees as
arguments, 2024-01-28) (the original tip commit of js/merge-tree-3-trees)
because I introduced three unchecked parse_tree() calls in that topic.

Changes since v3:

 * Aligned the translated error messages with pre-existing ones (sorry, I
   forgot to make that change in v2!).
 * Added a new commit at the end to mark the one error message for
   translation which I had imitated, after making it consistent with the
   remaining "unable to read tree" error messages.

Changes since v2:

 * Fixed the new "missing tree object" test case in t4301 that succeeded for
   the wrong reason.
 * Adjusted the new "missing blob object" test case to avoid succeeding for
   the wrong reason.
 * Simplified the "missing blob object" test case.

Changes since v1:

 * Simplified the test case, avoiding a subshell and a pipe in the process.
 * Added a patch to remove a superfluous subtree->object.parsed guard around
   a parse_tree(subtree) call.

Johannes Schindelin (6):
  merge-tree: fail with a non-zero exit code on missing tree objects
  merge-ort: do check `parse_tree()`'s return value
  t4301: verify that merge-tree fails on missing blob objects
  Always check `parse_tree*()`'s return value
  cache-tree: avoid an unnecessary check
  fill_tree_descriptor(): mark error message for translation

 builtin/checkout.c               | 19 ++++++++++++++++---
 builtin/clone.c                  |  3 ++-
 builtin/commit.c                 |  3 ++-
 builtin/merge-tree.c             |  6 ++++++
 builtin/read-tree.c              |  3 ++-
 builtin/reset.c                  |  4 ++++
 cache-tree.c                     |  4 ++--
 merge-ort.c                      | 16 +++++++++++-----
 merge-recursive.c                |  3 ++-
 merge.c                          |  5 ++++-
 reset.c                          |  5 +++++
 sequencer.c                      |  4 ++++
 t/t4301-merge-tree-write-tree.sh | 27 +++++++++++++++++++++++++++
 t/t6030-bisect-porcelain.sh      |  2 +-
 tree-walk.c                      |  2 +-
 15 files changed, 89 insertions(+), 17 deletions(-)


base-commit: 5f43cf5b2e4b68386d3774bce880b0f74d801635
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1651%2Fdscho%2Fmerge-tree-and-missing-objects-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1651/dscho/merge-tree-and-missing-objects-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1651

Range-diff vs v3:

 1:  11b9cd8c5da = 1:  11b9cd8c5da merge-tree: fail with a non-zero exit code on missing tree objects
 2:  f01f4eb011b = 2:  f01f4eb011b merge-ort: do check `parse_tree()`'s return value
 3:  e82fdf7fbcb = 3:  e82fdf7fbcb t4301: verify that merge-tree fails on missing blob objects
 4:  9e4dc94ef03 ! 4:  5942c27f439 Always check `parse_tree*()`'s return value
     @@ builtin/checkout.c: static int merge_working_tree(const struct checkout_opts *op
       		new_tree = repo_get_commit_tree(the_repository,
       						new_branch_info->commit);
      +		if (!new_tree)
     -+			return error(_("unable to read tree %s"),
     ++			return error(_("unable to read tree (%s)"),
      +				     oid_to_hex(&new_branch_info->commit->object.oid));
      +	}
       	if (opts->discard_changes) {
     @@ builtin/checkout.c: static void setup_new_branch_info_and_source_tree(
       		/* not a commit */
       		*source_tree = parse_tree_indirect(rev);
      +		if (!*source_tree)
     -+			die(_("unable to read tree %s"), oid_to_hex(rev));
     ++			die(_("unable to read tree (%s)"), oid_to_hex(rev));
       	} else {
       		parse_commit_or_die(new_branch_info->commit);
       		*source_tree = repo_get_commit_tree(the_repository,
       						    new_branch_info->commit);
      +		if (!*source_tree)
     -+			die(_("unable to read tree %s"),
     ++			die(_("unable to read tree (%s)"),
      +			    oid_to_hex(&new_branch_info->commit->object.oid));
       	}
       }
     @@ builtin/merge-tree.c: static int real_merge(struct merge_tree_options *o,
       			die(_("could not parse as tree '%s'"), merge_base);
       		base_tree = parse_tree_indirect(&base_oid);
      +		if (!base_tree)
     -+			die(_("unable to read tree %s"), oid_to_hex(&base_oid));
     ++			die(_("unable to read tree (%s)"), oid_to_hex(&base_oid));
       		if (repo_get_oid_treeish(the_repository, branch1, &head_oid))
       			die(_("could not parse as tree '%s'"), branch1);
       		parent1_tree = parse_tree_indirect(&head_oid);
      +		if (!parent1_tree)
     -+			die(_("unable to read tree %s"), oid_to_hex(&head_oid));
     ++			die(_("unable to read tree (%s)"), oid_to_hex(&head_oid));
       		if (repo_get_oid_treeish(the_repository, branch2, &merge_oid))
       			die(_("could not parse as tree '%s'"), branch2);
       		parent2_tree = parse_tree_indirect(&merge_oid);
      +		if (!parent2_tree)
     -+			die(_("unable to read tree %s"), oid_to_hex(&merge_oid));
     ++			die(_("unable to read tree (%s)"), oid_to_hex(&merge_oid));
       
       		opt.ancestor = merge_base;
       		merge_incore_nonrecursive(&opt, base_tree, parent1_tree, parent2_tree, &result);
     @@ builtin/reset.c: static int reset_index(const char *ref, const struct object_id
       	if (reset_type == MIXED || reset_type == HARD) {
       		tree = parse_tree_indirect(oid);
      +		if (!tree) {
     -+			error(_("unable to read tree %s"), oid_to_hex(oid));
     ++			error(_("unable to read tree (%s)"), oid_to_hex(oid));
      +			goto out;
      +		}
       		prime_cache_tree(the_repository, the_repository->index, tree);
     @@ merge-ort.c: static void merge_ort_nonrecursive_internal(struct merge_options *o
       	if (result->clean >= 0) {
       		result->tree = parse_tree_indirect(&working_tree_oid);
      +		if (!result->tree)
     -+			die(_("unable to read tree %s"),
     ++			die(_("unable to read tree (%s)"),
      +			    oid_to_hex(&working_tree_oid));
       		/* existence of conflicted entries implies unclean */
       		result->clean &= strmap_empty(&opt->priv->conflicted);
     @@ reset.c: int reset_head(struct repository *r, const struct reset_head_opts *opts
       
       	tree = parse_tree_indirect(oid);
      +	if (!tree) {
     -+		ret = error(_("unable to read tree %s"), oid_to_hex(oid));
     ++		ret = error(_("unable to read tree (%s)"), oid_to_hex(oid));
      +		goto leave_reset_head;
      +	}
      +
     @@ sequencer.c: static int do_recursive_merge(struct repository *r,
       
       	head_tree = parse_tree_indirect(head);
      +	if (!head_tree)
     -+		return error(_("unable to read tree %s"), oid_to_hex(head));
     ++		return error(_("unable to read tree (%s)"), oid_to_hex(head));
       	next_tree = next ? repo_get_commit_tree(r, next) : empty_tree(r);
       	base_tree = base ? repo_get_commit_tree(r, base) : empty_tree(r);
       
     @@ sequencer.c: static int do_reset(struct repository *r,
       
       	tree = parse_tree_indirect(&oid);
      +	if (!tree)
     -+		return error(_("unable to read tree %s"), oid_to_hex(&oid));
     ++		return error(_("unable to read tree (%s)"), oid_to_hex(&oid));
       	prime_cache_tree(r, r->index, tree);
       
       	if (write_locked_index(r->index, &lock, COMMIT_LOCK) < 0)
 5:  91dc4ccd04e = 5:  7e5e84a4e7c cache-tree: avoid an unnecessary check
 -:  ----------- > 6:  ee2fcee5a10 fill_tree_descriptor(): mark error message for translation

-- 
gitgitgadget
