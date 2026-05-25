Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1766C18050
	for <git@vger.kernel.org>; Mon, 25 May 2026 19:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779738063; cv=none; b=uw1SR9LDRQMxNGTjrM8cizmrLOJQk2Mpqe+e5kLY+kjr9+dapemR5VHxHY3sCLpASU02uhqx+COqc/jGg7MlP+h4p4+FdgVpS9bf/9axu5NqkVh/JCQ1jFILpHIVbo2XRNlBEzpAHAp07HzoDwRbst6kQHojVJ0rQwPiPfgeRUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779738063; c=relaxed/simple;
	bh=TjuW6GawjgPQ1GCYlBCYNxgLh8bme4pys4qhv4rhAeI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=t9OKbKRhORMKNKlleTCSQIpQoBBkOFMWLO4CupXM1QMX02uoEa/D8fIh9iJK7wByIkQtLfxnHKHO9p9v1FINjWKVD1fRW2Z93/WX9Wut/3U7lRhzWpbFfTvaP+CxhqFJT6DcYvy3ky11Mcl5mY1TvCDJ9g2mn+EnEA087Qwkces=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCfa34Om; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCfa34Om"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7e61d3fb1c6so1016496a34.3
        for <git@vger.kernel.org>; Mon, 25 May 2026 12:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779738061; x=1780342861; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hWlrFquXVFN/ug5pHfjPFO0u1+ELckYAe0xcXC6LWcs=;
        b=MCfa34OmqdqKx4MJE1KzorhtIQ2ftkxjw2NmEton4tiIHeJ96n6M5/hoVDoZX48pN8
         UwAlEobAbi5Xowc2+GbOe24/lUgkA7a8hcbrMAFKBzt69BFA1TznFfCfDwprfIHiVEt5
         6yu7nZK6Y3tmObPbt18gyEGTh97psaluGcAEuUu8En2EhBPVML2Kd61y3Ak1KVaQloHI
         T4R/Txqjfpkny9fb/MRgHaiLwZPwXWaeSSZryEVrUtFNBIkUk25wxgGGxhBTC13UDrbv
         WcLynzvQKM/POWSMPiI/u5lM9detIuqleQIlrVK3wb3w9bnkcJzEeMlY5t7Uxsi7lnzU
         wvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779738061; x=1780342861;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hWlrFquXVFN/ug5pHfjPFO0u1+ELckYAe0xcXC6LWcs=;
        b=UUmIr5Z2SUYumbZ/iCJnT5lPWkKsD5uBkVC/93Ml8vwSUEObo9/N5/XQUeIqA1Cyi1
         ppOalx4oRiVthvNlxKoWOxbKazgxXAt+a9oZUY6pj9miunlZsAv4faQKX7wPndPp4UaS
         Z1dacxlya13o1rfUxcmHKc8G85WHqZ2ktG5tEYHiXjXTSUN+ECu9dbhKfy9pbYCn056o
         TnqzCnhlu9KmgJwOPGQRsoTGTrGP3Z/c40lMRNYzmG9hA+M2woOAVmsOza0Ji5lMXpYY
         Hjp7KlRgLKxHvDWDa6CFsC8myvOe21PUFrvvCCTHFeSR76pfjVUrrWPv2FP2QhLtfXU7
         h2KQ==
X-Gm-Message-State: AOJu0YxC6HSKk4RNSAx/YlMW5jlpQgt9h/v57/4vnf0H3Kn9+wg47tKY
	4tTx9S2FQLxidFiJr1Y8Vn9WEpJ5JOi2gjJ3BlOSqOJj6p4RmXMbl2rnuh/olg==
X-Gm-Gg: Acq92OGrWZZex9dzw16peXWERZ4ScCfhFWBqk2zWTVyL2hQmsi+nIl1DWRLoY0JJNQQ
	gF7xa81BznzWuB/MjDyFKpl6D4pMg0Qa8kgiZUSsM4u2tMv8UDUbUtoPnMbwE6RGy3QS/AsU/9a
	GNSECinZefUXdbxsule/zqrhHYVLqT9e4Ci1qvqIsHyr6GG1LswC7gxohBrgQJZ8vdXPT+vLdjE
	pZHUrBCY/kYa99obhP76u3UaQ3TGMvrc5WdZcZmjsa+DjLN5IJSFCfFMYe+DQRUIYM2nm159NpT
	TSJUBMCDncEk5rsDmSvpx7xxt3g1c2ZGj3a+Ta6oEzejJEPA7SFiSfDxeO3r5SF+IA+OOqPujfL
	Iz0lzVEkA/Jf+G3V+r9+Su8MFq77YkkAiEMKvL4GtpsRyhSHij7Rq7rSVY7XlduyJdB7HmjVx8p
	vRZBABhM4hYR/fLlCxKv8kI6e45BM=
X-Received: by 2002:a05:6830:6417:b0:7dc:3db6:eef with SMTP id 46e09a7af769-7e5fee6713cmr8743048a34.2.1779738060902;
        Mon, 25 May 2026 12:41:00 -0700 (PDT)
Received: from [127.0.0.1] ([172.212.164.19])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e60667af4csm7838631a34.27.2026.05.25.12.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 12:41:00 -0700 (PDT)
Message-Id: <pull.2094.v2.git.1779738059.gitgitgadget@gmail.com>
In-Reply-To: <pull.2094.git.1777349126.gitgitgadget@gmail.com>
References: <pull.2094.git.1777349126.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 25 May 2026 19:40:55 +0000
Subject: [PATCH v2 0/3] line-log: integrate -L with the standard log output pipeline
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

Since its introduction, git log -L has short-circuited from
log_tree_commit() into its own output function, bypassing log_tree_diff()
and log_tree_diff_flush(). This skips no_free save/restore,
always_show_header, diff_free() cleanup, and means that pickaxe (-S, -G,
--find-object) and --diff-filter cannot suppress commits whose pairs are all
filtered out, because show_log() runs before diffcore_std().

This series restructures the flow so that -L goes through the same
log_tree_diff() -> log_tree_diff_flush() path as normal single-parent and
merge diffs, then uses that to enable several non-patch diff formats.

Patch 1: revision: move -L setup before output_format-to-diff derivation

Preparatory reorder in setup_revisions(). The -L block sets a default
DIFF_FORMAT_PATCH when no format is requested; move it before the derivation
of revs->diff from output_format so the default is visible to that check. No
behavior change on its own.

Patch 2: line-log: integrate -L output with the standard log-tree pipeline

Rename line_log_print() to line_log_queue_pairs(), stripping it down to only
queue pre-computed filepairs. log_tree_diff_flush() handles show_log(),
diffcore_std(), and diff_flush(). This fixes pickaxe and --diff-filter
suppression, and aligns the commit/diff separator with the rest of log
output. Rejects --full-diff, which is not yet supported when filepairs are
pre-computed.

Patch 3: line-log: allow non-patch diff formats with -L

Expand the allowlist to accept --raw, --name-only, --name-status, and
--summary. These only read filepair metadata already set by the line-log
machinery. Diff stat formats (--stat, --numstat, --shortstat, --dirstat)
remain blocked because they call compute_diffstat() on full blob content and
would show whole-file statistics rather than range-scoped ones.

Changes since v1:

 * Patch 2: use !opt->loginfo return convention in log_tree_diff() to match
   the existing single-parent and merge codepaths, instead of returning
   log_tree_diff_flush() directly.
 * Patch 2: reword the early-return removal to explicitly tie it to the
   pipeline change.
 * Patch 2: soften --full-diff rejection to "not yet supported".
 * Patches 2-3: use test_grep consistently in new tests.
 * Patch 2: replace sed | grep pipe with sed > file && test_grep for proper
   exit status handling.

Michael Montalbo (3):
  revision: move -L setup before output_format-to-diff derivation
  line-log: integrate -L output with the standard log-tree pipeline
  line-log: allow non-patch diff formats with -L

 Documentation/line-range-options.adoc         |  10 +-
 line-log.c                                    |  30 ++----
 line-log.h                                    |   2 +-
 log-tree.c                                    |  10 +-
 revision.c                                    |  24 +++--
 t/t4211-line-log.sh                           | 100 +++++++++++++++---
 t/t4211/sha1/expect.parallel-change-f-to-main |   1 -
 .../sha256/expect.parallel-change-f-to-main   |   1 -
 8 files changed, 121 insertions(+), 57 deletions(-)


base-commit: 9f223ef1c026d91c7ac68cc0211bde255dda6199
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2094%2Fmmontalbo%2Fmm%2Fline-log-use-log-tree-diff-flush-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2094/mmontalbo/mm/line-log-use-log-tree-diff-flush-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2094

Range-diff vs v1:

 1:  9633eb62c6 = 1:  9633eb62c6 revision: move -L setup before output_format-to-diff derivation
 2:  2d9e0ca015 ! 2:  7acfc5376e line-log: integrate -L output with the standard log-tree pipeline
     @@ Commit message
             log_tree_diff_flush(), mirroring the diff_tree_oid() + flush
             pattern used by the single-parent and merge codepaths.
      
     -     - Remove the early return in log_tree_commit() that bypassed
     -       no_free save/restore, always_show_header, and diff_free().
     +     - Remove the early return in log_tree_commit() that is no longer
     +       needed now that -L output flows through log_tree_diff() and
     +       log_tree_diff_flush(); this restores no_free save/restore,
     +       always_show_header, and diff_free() cleanup.
      
          Because show_log() is now deferred until after diffcore_std() inside
          log_tree_diff_flush(), pickaxe (-S, -G, --find-object) and
     @@ Commit message
          log_tree_diff_flush() only emits one for verbose headers.  This
          matches the rest of log output.
      
     -    Also reject --full-diff, which is meaningless with -L: the filepairs
     -    are pre-computed during the history walk and scoped to tracked paths,
     -    so there is no tree diff to widen.
     +    Also reject --full-diff, which is not yet supported with -L: the
     +    filepairs are pre-computed during the history walk and scoped to
     +    tracked line ranges, so there is currently no full-tree diff to
     +    fall back to for display.
      
          Update tests accordingly.
      
     @@ log-tree.c: static int log_tree_diff(struct rev_info *opt, struct commit *commit
       
      +	if (opt->line_level_traverse) {
      +		line_log_queue_pairs(opt, commit);
     -+		return log_tree_diff_flush(opt);
     ++		log_tree_diff_flush(opt);
     ++		return !opt->loginfo;
      +	}
      +
       	parse_commit_or_die(commit);
     @@ log-tree.c: int log_tree_commit(struct rev_info *opt, struct commit *commit)
      
       ## revision.c ##
      @@ revision.c: int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
     + 		die(_("the option '%s' requires '%s'"), "--grep-reflog", "--walk-reflogs");
     + 
       	if (revs->line_level_traverse &&
     - 	    (revs->diffopt.output_format & ~(DIFF_FORMAT_PATCH | DIFF_FORMAT_NO_OUTPUT)))
     - 		die(_("-L does not yet support diff formats besides -p and -s"));
     -+	if (revs->line_level_traverse && revs->full_diff)
     -+		die(_("-L is not compatible with --full-diff"));
     +-	    (revs->diffopt.output_format & ~(DIFF_FORMAT_PATCH | DIFF_FORMAT_NO_OUTPUT)))
     +-		die(_("-L does not yet support diff formats besides -p and -s"));
     ++	    (revs->full_diff ||
     ++	     (revs->diffopt.output_format &
     ++	      ~(DIFF_FORMAT_PATCH | DIFF_FORMAT_NO_OUTPUT))))
     ++		die(_("-L does not yet support the requested diff format"));
       
       	if (revs->expand_tabs_in_log < 0)
       		revs->expand_tabs_in_log = revs->expand_tabs_in_log_default;
     @@ t/t4211-line-log.sh: test_expect_success '-L with -G filters to diff-text matche
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success '--full-diff is not supported with -L' '
     ++test_expect_success '--full-diff is not yet supported with -L' '
      +	test_must_fail git log -L1,24:b.c --full-diff 2>err &&
     -+	test_grep "not compatible with --full-diff" err
     ++	test_grep "does not yet support" err
      +'
      +
      +test_expect_success '-L --oneline has no extra blank line before diff' '
      +	git checkout parent-oids &&
      +	git log --oneline -L:func2:file.c -1 >actual &&
      +	# Oneline header on line 1, diff starts immediately on line 2
     -+	sed -n 2p actual | grep "^diff --git"
     ++	sed -n 2p actual >line2 &&
     ++	test_grep "^diff --git" line2
      +'
      +
       test_done
 3:  06c24b416f ! 3:  10a3d8dde2 line-log: allow non-patch diff formats with -L
     @@ Documentation/line-range-options.adoc
      
       ## revision.c ##
      @@ revision.c: int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
     - 		die(_("the option '%s' requires '%s'"), "--grep-reflog", "--walk-reflogs");
     - 
       	if (revs->line_level_traverse &&
     --	    (revs->diffopt.output_format & ~(DIFF_FORMAT_PATCH | DIFF_FORMAT_NO_OUTPUT)))
     --		die(_("-L does not yet support diff formats besides -p and -s"));
     -+	    (revs->diffopt.output_format &
     -+	     ~(DIFF_FORMAT_PATCH | DIFF_FORMAT_NO_OUTPUT |
     -+	       DIFF_FORMAT_RAW | DIFF_FORMAT_NAME |
     -+	       DIFF_FORMAT_NAME_STATUS | DIFF_FORMAT_SUMMARY)))
     -+		die(_("-L does not yet support the requested diff format"));
     - 	if (revs->line_level_traverse && revs->full_diff)
     - 		die(_("-L is not compatible with --full-diff"));
     + 	    (revs->full_diff ||
     + 	     (revs->diffopt.output_format &
     +-	      ~(DIFF_FORMAT_PATCH | DIFF_FORMAT_NO_OUTPUT))))
     ++	      ~(DIFF_FORMAT_PATCH | DIFF_FORMAT_NO_OUTPUT |
     ++		DIFF_FORMAT_RAW | DIFF_FORMAT_NAME |
     ++		DIFF_FORMAT_NAME_STATUS | DIFF_FORMAT_SUMMARY))))
     + 		die(_("-L does not yet support the requested diff format"));
       
     + 	if (revs->expand_tabs_in_log < 0)
      
       ## t/t4211-line-log.sh ##
      @@ t/t4211-line-log.sh: test_expect_success '-p shows the default patch output' '
     @@ t/t4211-line-log.sh: test_expect_success '-p shows the default patch output' '
      -	test_must_fail git log -L1,24:b.c --raw
      +test_expect_success '--raw shows mode, oid, status and path' '
      +	git log -L1,24:b.c --raw --format= >actual &&
     -+	grep "^:100644 100644 [0-9a-f]\{7\} [0-9a-f]\{7\} M	b.c$" actual &&
     -+	! grep "^diff --git" actual &&
     -+	! grep "^@@" actual
     ++	test_grep "^:100644 100644 [0-9a-f]\{7\} [0-9a-f]\{7\} M	b.c$" actual &&
     ++	! test_grep "^diff --git" actual &&
     ++	! test_grep "^@@" actual
      +'
      +
      +test_expect_success '--name-only shows path' '
      +	git log -L1,24:b.c --name-only --format= >actual &&
     -+	grep "^b.c$" actual &&
     -+	! grep "^diff --git" actual &&
     -+	! grep "^@@" actual
     ++	test_grep "^b.c$" actual &&
     ++	! test_grep "^diff --git" actual &&
     ++	! test_grep "^@@" actual
      +'
      +
      +test_expect_success '--name-status shows status and path' '
      +	git log -L1,24:b.c --name-status --format= >actual &&
     -+	grep "^M	b.c$" actual &&
     -+	! grep "^diff --git" actual &&
     -+	! grep "^@@" actual
     ++	test_grep "^M	b.c$" actual &&
     ++	! test_grep "^diff --git" actual &&
     ++	! test_grep "^@@" actual
      +'
      +
      +test_expect_success '--stat is not yet supported with -L' '
     @@ t/t4211-line-log.sh: test_expect_success '-p shows the default patch output' '
       
       test_expect_success 'setup for checking fancy rename following' '
      @@ t/t4211-line-log.sh: test_expect_success '-L --oneline has no extra blank line before diff' '
     - 	sed -n 2p actual | grep "^diff --git"
     + 	test_grep "^diff --git" line2
       '
       
      +test_expect_success '--summary shows new file on root commit' '
      +	git checkout parent-oids &&
      +	git log -L:func2:file.c --summary --format= >actual &&
     -+	grep "create mode 100644 file.c" actual
     ++	test_grep "create mode 100644 file.c" actual
      +'
      +
       test_done

-- 
gitgitgadget
