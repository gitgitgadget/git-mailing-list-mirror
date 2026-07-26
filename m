Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C866F3033D6
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 18:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785091893; cv=none; b=iP1yySsSVUN97Hh1m4byej/gENhLGvP/JJ+cYwKNvcQtGxU3MdSwWAVCTBSRISudieUCqPebFOzTAkITxJFv+/wt479MsQHWODodfpp1JI16DNkBqYF1+958Q+qojFcXrJptUxn69QP1XdDFI0MZLSu64B2nQ+CX+QXLOUQH4j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785091893; c=relaxed/simple;
	bh=XlB2RSu/qDTJo+Rztf/8AByv1E1xFf4uLi95qECy/yI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HZjVz3uyXwhmQ0Y2DVP8rtHsqUWUqEmW2OR54TDVpiSsrExwwKg2i/HZPCp8mh9nUF665qQfQ/9yh4AihJNGwUgpBnUrg+x8fFfgaNUPJm0ME563gSV+x186TU1DXjp5AWVwUPpUEKDg4Wa47D2a0htQJifeRGF21QDgoIgVc9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2m2nmrj; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2m2nmrj"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38e347638adso1825434a91.0
        for <git@vger.kernel.org>; Sun, 26 Jul 2026 11:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785091891; x=1785696691; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=j9CY769A2saZdWi21qltvoqXn4+KMZ7OcRFcA9IuhPU=;
        b=U2m2nmrjAuhia84uIssSjB516enQVC0VA225Q9Ov4Oafb5Zpv2nbppaWzE0usvtszd
         QIT5x1Apv1CZFTC74XJkK8cqpBglhNcYJaNvj9zbXFe2L3+MbV7LITvdjMWJJDso9XPJ
         /zoHPrEeRP5qnloJIUSBPVUk9YKLbt4+xMhHgFu4+rDx2Ad/hp+GTYSO4hEFd1JeOXsO
         s26hsO1lunVHDYSF6X/wGCp8keJ24PU1hS3tPs/JrU3QBZykOAvkTuiBI7PvbyQovtMZ
         NjtPlXMGTXujPR23i7mQeqnWPsycQI3Q9+h4uAxma48LPme6owrPZP9K2tj+mZxLGmOc
         feZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785091891; x=1785696691;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j9CY769A2saZdWi21qltvoqXn4+KMZ7OcRFcA9IuhPU=;
        b=dz9DeVBQU7LaDAGvt7B1Nejs7bZ/7UkWScwVOu0vD4CzuAv/QDK6ZfV1sCvohNM/dB
         qoIk8DP7KAgPCx/ivubYc5hTXUKUN3acnmZPfDx+rIB12k1UVXoxhKDOpzEwSOZ+HA1Y
         J/NpUBaLgk5Jux/wGjvOKVTAl2oaEpooriCiGOlpry2Vq57Q5vPi7ApVJuLv5htFWlWu
         k8TrODFIBiVaV3rxpxc7gWiTwfS1Gcgf2hC+fiShkP+gbVYQsOXK7V8oQpQpKarIlvEp
         hn9AaPiQVggBwjvt7kzspCtF0HA9DZohWOQbueccnLWwqFSSlV4oSZD9D4UoUIXf6TVN
         oeBg==
X-Gm-Message-State: AOJu0Yz6HAmdfG0yI4EVXzzu1Q2WM1B/EjJVG7hrZlZaiJLdMevq4imi
	hl/4y+8UwZhlzEfGLZJ3LsecFX1cCT8EsuFF+kAwuWnkSqZfkniCHBWjiHUnzw==
X-Gm-Gg: AR+sD10M3oa8wHD+/A3qJUtvW3zNDJDqrC2KE0ghcQfIT0g9bQB8oCQ25PxS6XJws13
	f11lFkogl1nZUCfioaH8Hhmeiq4XxzkYSd8/xMrzrUlGRMnTYa8P9tMCwyfxXjznf8ISAx2XJ8M
	ykmO4nXkvPXOMRGNvx1Vi+vlRfbtJ13XFaHCBIijpqa0C3kSSA96JljkkuYqGt33kVbbSTPdOZh
	tPtB0qdWx0fu+bGyqFD+7v5rw5Ile1QxYllYgeumvV3tE16mVVx49lE7ClwaxCVOJKiMqf02wke
	l/AetG+82q41TA+gUWyzx0z13rgQehYtC6yMRi0M+zNFsZQf76ft1MV1Sk6Bmdj2x+k/eprjq4v
	NiO9s3faJsxsHljf26tmtSbHWT/cFYb7EV4sYEMihzxGEwzjRX4SDmZjNW5A4EzwBkOYSLDHLiz
	6Uacod
X-Received: by 2002:a17:90b:5826:b0:387:df8f:1406 with SMTP id 98e67ed59e1d1-38f2978b8cfmr5224483a91.39.1785091891065;
        Sun, 26 Jul 2026 11:51:31 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.229.50])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc548f5dsm27068613eec.17.2026.07.26.11.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 11:51:30 -0700 (PDT)
Message-Id: <pull.2120.v6.git.1785091889.gitgitgadget@gmail.com>
In-Reply-To: <pull.2120.v5.git.1784149323.gitgitgadget@gmail.com>
References: <pull.2120.v5.git.1784149323.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 26 Jul 2026 18:51:19 +0000
Subject: [PATCH v6 0/9] [RFC] diff: add diff.<driver>.process for external hunk providers
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
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Michael Montalbo <mmontalbo@gmail.com>

Language-aware diff tools (e.g., Difftastic) and format-specific analyzers
can produce better line matching than Git's builtin diff algorithm, but
diff.<driver>.command replaces Git's diff output with the program's own
output, so display features like word diff, function context, and color
cannot operate on it; and because the program is consulted only for that
patch output, blame, --stat, and git log -L fall back to Git's builtin line
matching and cannot benefit from the tool at all.

This series adds diff.<driver>.process, a long-running subprocess protocol
that lets an external tool control which lines Git considers changed while
Git handles all output formatting. The protocol follows
filter.<driver>.process: pkt-line over stdin/stdout, capability negotiation,
one process per Git invocation.

The tool receives both file versions and returns changed regions (line
ranges in the old and new file). Git validates and feeds them into the xdiff
pipeline in place of the builtin diff algorithm. When the tool returns no
hunks, Git treats the files as having no changes, which propagates through
patch output, the --stat summary, blame, and git log -L. The request also
carries the two blobs' object names (old-oid/new-oid) so a tool can cache
its analysis keyed on the pair.

 * Patch 1: document how an external diff driver (diff.<driver>.command)
   relates to the rest of Git's diff features, so the contrast with the new
   process driver is clear.
 * Patch 2: xdiff plumbing for externally supplied hunks.
 * Patch 3: diff.<driver>.process config key.
 * Patch 4: refactor subprocess API to separate process lifecycle from
   hashmap management, since the diff process stores its subprocess on the
   userdiff driver rather than in a hashmap.
 * Patch 5: the main feature, including the old-oid/new-oid request metadata
   for blob-pair caching.
 * Patch 6: bypass knobs (--no-ext-diff, format-patch).
 * Patch 7: blame integration so the tool can declare commits as having no
   changes; introduces the shared xdi_diff_process() consult-then-diff
   helper that blame and git log -L both use.
 * Patch 8: --stat/--numstat/--shortstat consult the tool, so the summary
   agrees with the patch output.
 * Patch 9: git log -L range tracking consults the tool, so a reformat-only
   commit is dropped from the log rather than shown with an empty diff.

A "Which features consult the diff process" section in gitattributes(5) lays
out, per feature, why each does or does not consult the process (patch
output, blame, summary formats, and the -L line-range view do; pickaxe -G,
patch-id, merge, range-diff, --check, and --raw do not, with reasons).
Combined diffs (--cc) remain on the builtin algorithm and are noted as
future work.

Changes since v5:

 * Changed series to be based on top of the in-flight
   mm/line-log-limited-ops:
   
   https://lore.kernel.org/git/pull.2152.v2.git.1782581342.gitgitgadget@gmail.com/

 * builtin_diffstat() now routes the process's hunks through that topic's -L
   line-range filter, so "git log -L --stat" scopes the tool's changed-line
   counts to the tracked range (patch 8, with a new t4080 test).

Michael Montalbo (9):
  gitattributes: document how external diff drivers relate to diff
    features
  xdiff: support external hunks via xpparam_t
  userdiff: add diff.<driver>.process config
  sub-process: separate process lifecycle from hashmap management
  diff: add long-running diff process via diff.<driver>.process
  diff: bypass diff process with --no-ext-diff and in format-patch
  blame: consult diff process for no-hunk detection
  diff: consult diff process for --stat counts
  line-log: consult diff process for range tracking

 Documentation/config/diff.adoc           |   5 +
 Documentation/diff-algorithm-option.adoc |   3 +
 Documentation/diff-options.adoc          |   4 +-
 Documentation/gitattributes.adoc         | 274 +++++++
 Makefile                                 |   2 +
 blame.c                                  |  24 +-
 builtin/log.c                            |   7 +
 diff-process.c                           | 529 ++++++++++++
 diff-process.h                           |  75 ++
 diff.c                                   |  84 +-
 diff.h                                   |   6 +
 line-log.c                               |  33 +-
 meson.build                              |   1 +
 sub-process.c                            |  28 +-
 sub-process.h                            |   9 +-
 t/helper/meson.build                     |   1 +
 t/helper/test-diff-process-backend.c     | 381 +++++++++
 t/helper/test-tool.c                     |   1 +
 t/helper/test-tool.h                     |   1 +
 t/meson.build                            |   1 +
 t/t4080-diff-process.sh                  | 996 +++++++++++++++++++++++
 userdiff.c                               |   7 +
 userdiff.h                               |   5 +
 xdiff-interface.c                        |   7 +-
 xdiff/xdiff.h                            |  16 +
 xdiff/xdiffi.c                           |  84 +-
 xdiff/xprepare.c                         |  10 +
 xdiff/xprepare.h                         |   1 +
 28 files changed, 2566 insertions(+), 29 deletions(-)
 create mode 100644 diff-process.c
 create mode 100644 diff-process.h
 create mode 100644 t/helper/test-diff-process-backend.c
 create mode 100755 t/t4080-diff-process.sh


base-commit: f67c51df064d2b64b257bd8c17d757cc0ce1b7fc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2120%2Fmmontalbo%2Fmm%2Fstructural-diff-backend-clean-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2120/mmontalbo/mm/structural-diff-backend-clean-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/2120

Range-diff vs v5:

  1:  0fd994a3d3 =  1:  b4a1ff4dea gitattributes: document how external diff drivers relate to diff features
  2:  2004502549 =  2:  ed2db0ac59 xdiff: support external hunks via xpparam_t
  3:  926cf01af6 =  3:  115e31d806 userdiff: add diff.<driver>.process config
  4:  363d459ff6 =  4:  850c7cbcf5 sub-process: separate process lifecycle from hashmap management
  5:  d003bc1f15 =  5:  4526809b7f diff: add long-running diff process via diff.<driver>.process
  6:  b2e80f014e =  6:  4795743ab9 diff: bypass diff process with --no-ext-diff and in format-patch
  7:  cf5bb8984a =  7:  00573a88a9 blame: consult diff process for no-hunk detection
  8:  c1d02d0e15 !  8:  7e3ba56967 diff: consult diff process for --stat counts
     @@ Commit message
          Otherwise the tool's hunks, or the builtin fallback, feed the counts
          through the shared xpparam_t.
      
     +    Under -L, route the surviving hunks through the same line-range filter
     +    builtin_diffstat() already uses for a tracked range, so a
     +    process-provided diff is scoped to that range: "git log -L<range>
     +    --stat" counts the tool's changed lines within the range rather than
     +    the builtin line diff's.
     +
          Like the builtin summary path, builtin_diffstat() does not apply
          textconv, so the process is consulted on the raw blob content here,
          unlike builtin_diff() which sends textconv'd content.  This keeps
     @@ Commit message
          Add tests covering counts from the tool's hunks (--numstat,
          --shortstat), an equivalent file producing no stat line, --stat
          --exit-code, the raw non-textconv content the tool receives, a
     -    multi-file mix of equivalent and changed files, and a mode-only
     -    change.
     +    multi-file mix of equivalent and changed files, a mode-only change,
     +    and a range-scoped --stat under "git log -L" that reflects the tool's
     +    hunks.
      
          Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
      
     @@ diff.c: static void builtin_diffstat(const char *name_a, const char *name_b,
       		xecfg.ctxlen = o->context;
       		xecfg.interhunkctxlen = o->interhunkcontext;
       		xecfg.flags = XDL_EMIT_NO_HUNK_HDR;
     --		if (xdi_diff_outf(&mf1, &mf2, NULL,
     +-
     +-		if (p->line_ranges) {
     +-			struct line_range_filter lr_filter;
     +-
     +-			line_range_filter_init(&lr_filter, p->line_ranges,
     +-					       diffstat_consume, diffstat);
     +-
     +-			if (line_range_filter_diff(&lr_filter, &mf1, &mf2,
     +-						   &xpp, &xecfg))
      +		/*
      +		 * Consult the diff process so --stat reflects the
      +		 * tool's view of which lines changed rather than the
     @@ diff.c: static void builtin_diffstat(const char *name_a, const char *name_b,
      +		 * xdiff entirely, leaving added and deleted at zero so
      +		 * the file is pruned below, just as builtin_diff() emits
      +		 * no patch for an equivalent file.
     ++		 *
     ++		 * Under -L, feed the tool's hunks through the same
     ++		 * line-range filter the builtin stat uses, so a
     ++		 * process-provided diff is scoped to the tracked range.
      +		 */
      +		if (diff_process_fill_hunks(o, name_a, &mf1, &mf2,
      +					    one->oid_valid ? &one->oid : NULL,
      +					    two->oid_valid ? &two->oid : NULL,
      +					    &xpp)
     -+		    != DIFF_PROCESS_EQUIVALENT &&
     -+		    xdi_diff_outf(&mf1, &mf2, NULL,
     - 				  diffstat_consume, diffstat, &xpp, &xecfg))
     - 			die("unable to generate diffstat for %s", one->path);
     ++		    != DIFF_PROCESS_EQUIVALENT) {
     ++			if (p->line_ranges) {
     ++				struct line_range_filter lr_filter;
     ++
     ++				line_range_filter_init(&lr_filter, p->line_ranges,
     ++						       diffstat_consume, diffstat);
     ++
     ++				if (line_range_filter_diff(&lr_filter, &mf1, &mf2,
     ++							   &xpp, &xecfg))
     ++					die("unable to generate diffstat for %s",
     ++					    one->path);
     ++			} else if (xdi_diff_outf(&mf1, &mf2, NULL, diffstat_consume,
     ++						 diffstat, &xpp, &xecfg))
     + 				die("unable to generate diffstat for %s",
     + 				    one->path);
     +-		} else if (xdi_diff_outf(&mf1, &mf2, NULL,
     +-				  diffstat_consume, diffstat, &xpp, &xecfg))
     +-			die("unable to generate diffstat for %s", one->path);
     ++		}
      +		free(xpp.external_hunks);
       
       		if (DIFF_FILE_VALID(one) && DIFF_FILE_VALID(two)) {
     @@ t/t4080-diff-process.sh: test_expect_success 'diff process with --exit-code and
      +	test_grep "2 deletions" actual
      +'
      +
     ++test_expect_success 'diff process scopes --stat to the tracked range under log -L' '
     ++	test_when_finished "rm -f backend.log" &&
     ++	cat >rangestat.c <<-\EOF &&
     ++	line1
     ++	line2
     ++	line3
     ++	line4
     ++	OLD5
     ++	OLD6
     ++	line7
     ++	line8
     ++	OLD9
     ++	OLD10
     ++	EOF
     ++	git add rangestat.c &&
     ++	git commit -m "add rangestat.c" &&
     ++
     ++	cat >rangestat.c <<-\EOF &&
     ++	line1
     ++	line2
     ++	line3
     ++	line4
     ++	NEW5
     ++	NEW6
     ++	line7
     ++	line8
     ++	NEW9
     ++	NEW10
     ++	EOF
     ++	git add rangestat.c &&
     ++	git commit -m "change rangestat.c" &&
     ++
     ++	# The file changes at lines 5-6 and 9-10, but fixed-hunk reports
     ++	# only 5-6.  The builtin line diff counts both regions (4/4); the
     ++	# tool hunks flow through the same line-range filter the stat uses,
     ++	# so the range-scoped stat reflects the tool view instead (2/2).
     ++	git log --no-ext-diff -L1,10:rangestat.c --oneline --stat >builtin &&
     ++	test_grep "4 insertions(+), 4 deletions(-)" builtin &&
     ++
     ++	git -c diff.cdiff.process="$BACKEND --mode=fixed-hunk --log=backend.log" \
     ++		log -L1,10:rangestat.c --oneline --stat >actual &&
     ++	test_grep "2 insertions(+), 2 deletions(-)" actual &&
     ++	test_grep ! "4 insertions" actual &&
     ++	test_grep "command=hunks pathname=rangestat.c" backend.log
     ++'
     ++
      +test_expect_success 'diff process equivalent file makes --stat --exit-code succeed' '
      +	# The tool reports worddiff.c equivalent, so --exit-code reports
      +	# no change (0); the builtin diff would report a change (1).
  9:  c3c17ba8fc =  9:  ffa6954d67 line-log: consult diff process for range tracking

-- 
gitgitgadget
