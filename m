Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD753AA9D4
	for <git@vger.kernel.org>; Fri, 29 May 2026 20:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780087708; cv=none; b=LlI3ROAi2wPLjxmN1LErPc+RF03LcBzPwzZvyWfma99hp19+Tvqy0ovabICg4V4k61GsKSuP1OVxDZdYxVPrNua0aEoX9wqqlJ2J3ic9sT1+pUA7LWn1ngGK2Z5Zl5pihzEr5xjnAr7G1ayqlCjuExNLRlIxPpzfgsb1AS4Cyuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780087708; c=relaxed/simple;
	bh=+ZwFEgvuPrKRHpMrtimSBQttImYZD3j77N6AOYKuoMY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=boraPjMRMwrsMap72hdvr25j3vwsBtEdrAwpTh4LfnPoq8/2hZyL2mm7bm9sDuNrsw3haRU+d8Ve2EzrJkKWm3Ezfo3//TzfMb20BGG+aQHRR8MpJfLDtzepYPE0MpkAWEO4HV9EKDuz1efvBQJTZIc0QVvIpnglvMFnDGQpshA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbbxwkcc; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbbxwkcc"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-304ffa40c5dso436588eec.1
        for <git@vger.kernel.org>; Fri, 29 May 2026 13:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780087703; x=1780692503; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+A7nRfQ3z+dxdxfKasGqCH8/k8HHrKVN3mP03b/wNaE=;
        b=hbbxwkcc0gkWTB1IcFDg1h5I3ndttS9A1uJpiUiLv2QWrOYviHS3AXJ6SsN+vcixDz
         D7k7+1yxC6skD/yD+z5FyHzYmKfsyB8Pcrd6wjZmLCZ51J1s/vc1M+XdUVUDPKcUDZZx
         nlhsuIu1/cBxgLdWWS1MAWmgZpLNIqkQGlWeBPab915b3bqX6o25IPa48g2eSzS/3yzl
         nF590a96VK3g7RDFzS9mcYeAimUjdaiB6KWRmZK7ml3VYJ/jcO68hBQrrjRHrKSLy5aP
         5mzHSJzLZ3v1KsLW3TGv/bOpnb+SLWbEafpM46jjobp1Lgu7Z3rR+ngPxomLzdWbjI7f
         2Dgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780087703; x=1780692503;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+A7nRfQ3z+dxdxfKasGqCH8/k8HHrKVN3mP03b/wNaE=;
        b=rn05c6KNAOmBGqAwBrRJ9jA0DhyodK3u7ktH7kyshkDWjwordRWk/UFAh3oWwWn2Pn
         lB5I4/GJUyg345jIBTCHasTBK5qK7iyfZRJiMdSlqhYnXdh5X8yHkDBGCZa3csknn48a
         4Hg93KeLF3CPW2pL1WdUeLxFR6tOGbyz0vTueuy41T2aNCQhuy5SMbGTYvvGk8J0PYRo
         TuLyHmw/y+MBiu4hN8v8aA7uRoEudor0wGK7xpWOOThL49v6gqQhwvKCr6fBe05p2WKM
         7H4zR9IAdbFswIfp59E3K8AyOriyzkJ041Xyq72oe4MYsHPozacxDjCrAEjTt1CIvYid
         w2xw==
X-Gm-Message-State: AOJu0Yw+81AejnpYwNLHwls/tfPgjGLV/L1OnXE4H2neyM/9Vy4uFTvy
	2d5cD8YNHIC+MgdekwTAdyHUObejWAofYCpxyV/0Ci69ADZFw/hgdRtNeN2YAQ==
X-Gm-Gg: Acq92OE7Lx6foxmyK9n3KvnDfGZ4X08B//ZwY4SZnK47jaWQPbjIhQfyYF4/khPwkX1
	PInc4EYtxOcEBlvHnrla2AlG7aCn4wSNgVj0lKrTKD6bvqGzs2F0UX8n5UOc0+yGFEYGk/Fg7Ue
	3NRAJAlatVgVl1ICT0GLCh8tBZV2xmuFGf5G8BZ6W63CKBkATWCh0pVmFNwqNui4UqqLvM4byi7
	jdKIwQxgB6FP5T+OXzOC3+2D+gS0vqy6+yP2eSZHE2QxZmX+/06lLxjcxtxkl8K5sitTSLwHFbq
	F43lN9Jf12sJjhhQ+u+t85iwpkt+zjOWYNLQVOvR4dWDX5GNKJfqVG8w0YYg3C/wn5V8PmT+Lnk
	4ZK5pOQvpYqTHe24Aerr3sipaV09bT+p9akcd/jIfbgWDmbY9KjgXXVQs/CM82nTWA+pBcibZsy
	WhG/kqUzEs3Ii3nJ+pSlPgU8jcIQLoyPI5VCfQMg==
X-Received: by 2002:a05:7300:e58b:b0:304:5bee:f59d with SMTP id 5a478bee46e88-304fa666331mr714531eec.29.1780087702268;
        Fri, 29 May 2026 13:48:22 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.227.194])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ee0dd8e1sm2835376eec.21.2026.05.29.13.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 13:48:21 -0700 (PDT)
Message-Id: <pull.2120.v3.git.1780087700.gitgitgadget@gmail.com>
In-Reply-To: <pull.2120.v2.git.1779733799.gitgitgadget@gmail.com>
References: <pull.2120.v2.git.1779733799.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 29 May 2026 20:48:13 +0000
Subject: [PATCH v3 0/6] [RFC] diff: add diff.<driver>.process for external hunk providers
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
Cc: Michael Montalbo <mmontalbo@gmail.com>

Language-aware diff tools (e.g., Difftastic) and format-specific analyzers
can produce better line matching than Git's builtin diff algorithm, but
diff.<driver>.command replaces Git's output entirely, losing downstream
features like word diff, function context, color, and blame.

This series adds diff.<driver>.process, a long-running subprocess protocol
that lets an external tool control which lines Git considers changed while
Git handles all output formatting. The protocol follows
filter.<driver>.process: pkt-line over stdin/stdout, capability negotiation,
one process per Git invocation.

The tool receives both file versions and returns changed regions (line
ranges in the old and new file). Git validates and feeds them into the xdiff
pipeline in place of the builtin diff algorithm. When the tool returns no
hunks, Git treats the files as having no changes.

The first two patches add xdiff plumbing for externally supplied hunks and
the diff.<driver>.process config key. Patch 3 refactors the subprocess API
to separate process lifecycle from hashmap management, since the diff
process stores its subprocess on the userdiff driver rather than in a
hashmap. The main feature lands in patch 4. Patch 5 wires up bypass knobs
(--no-ext-diff, format-patch). Patch 6 integrates with blame so the tool can
declare commits as having no changes.

Changes since v2:

 * Extracted subprocess_start_command() from subprocess_start() so the diff
   process can reuse the startup machinery without a hashmap (new patch 3).
 * Subprocess stored on userdiff_driver, no global variables.
 * Differentiated error handling: tool failure warns (with tool name), "not
   configured" is silent, abort is voluntary.
 * Single public entry point: diff_process_fill_hunks() handles driver
   lookup, flag checks, subprocess management, and error reporting for both
   diff.c and blame.c.
 * Rewrote gitattributes protocol section to match filter process convention
   with packet diagrams and fully specified hunk format.
 * Split bypass knobs (--no-ext-diff, format-patch) into a separate commit.
 * SIGPIPE protection, stricter input validation, const correctness.
 * Changed "zero hunks" to "no hunks" throughout.

Michael Montalbo (6):
  xdiff: support external hunks via xpparam_t
  userdiff: add diff.<driver>.process config
  sub-process: separate process lifecycle from hashmap management
  diff: add long-running diff process via diff.<driver>.process
  diff: bypass diff process with --no-ext-diff and in format-patch
  blame: consult diff process for no-hunk detection

 Documentation/config/diff.adoc           |   5 +
 Documentation/diff-algorithm-option.adoc |   3 +
 Documentation/diff-options.adoc          |   4 +-
 Documentation/gitattributes.adoc         | 139 +++++
 Makefile                                 |   1 +
 blame.c                                  |  40 +-
 builtin/log.c                            |   7 +
 diff-process.c                           | 288 ++++++++++
 diff-process.h                           |  39 ++
 diff.c                                   |  29 +-
 diff.h                                   |   5 +
 meson.build                              |   1 +
 sub-process.c                            |  29 +-
 sub-process.h                            |   9 +-
 t/.gitattributes                         |   1 +
 t/meson.build                            |   1 +
 t/t4080-diff-process.sh                  | 660 +++++++++++++++++++++++
 userdiff.c                               |   7 +
 userdiff.h                               |   5 +
 xdiff-interface.c                        |   7 +-
 xdiff/xdiff.h                            |  13 +
 xdiff/xdiffi.c                           |  85 ++-
 xdiff/xprepare.c                         |  10 +
 xdiff/xprepare.h                         |   1 +
 24 files changed, 1368 insertions(+), 21 deletions(-)
 create mode 100644 diff-process.c
 create mode 100644 diff-process.h
 create mode 100755 t/t4080-diff-process.sh


base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2120%2Fmmontalbo%2Fmm%2Fstructural-diff-backend-clean-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2120/mmontalbo/mm/structural-diff-backend-clean-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2120

Range-diff vs v2:

 1:  f887a7e2ba ! 1:  13eb201d63 xdiff: support external hunks via xpparam_t
     @@ Commit message
          numbers, overlapping or out-of-order hunks, negative counts, and
          violations of the synchronization invariant (unchanged line counts
          must match between files).  On validation failure, fall back to
     -    the builtin diff algorithm.
     +    the builtin diff algorithm; this re-runs xdl_prepare_env() since
     +    the first call may have dirtied the changed[] arrays.
      
          Skip trim_common_tail() in xdi_diff() when external hunks are
          present, since external hunks reference line numbers in the
     @@ xdiff/xdiff.h: typedef struct s_xpparam {
       	char **anchors;
       	size_t anchors_nr;
      +
     -+	/* Externally computed hunks: bypass the diff algorithm. */
     -+	const struct xdl_hunk *external_hunks;
     ++	/* Externally computed hunks: bypass the diff algorithm.  Owned by caller. */
     ++	struct xdl_hunk *external_hunks;
      +	size_t external_hunks_nr;
       } xpparam_t;
       
     @@ xdiff/xdiffi.c: static void xdl_mark_ignorable_regex(xdchange_t *xscr, const xdf
      + * Returns 0 on success, -1 on validation failure.
      + */
      +static int xdl_populate_hunks_from_external(xdfenv_t *xe,
     -+					    const struct xdl_hunk *hunks,
     ++					    struct xdl_hunk *hunks,
      +					    size_t nr_hunks)
      +{
      +	size_t i;
      +	long j, prev_old_end = 0, prev_new_end = 0;
      +	long total_old = 0, total_new = 0;
      +
     ++	/*
     ++	 * xdl_prepare_env() may dirty changed[] via xdl_cleanup_records().
     ++	 * Clear them so only the external hunks are marked.
     ++	 */
      +	xdl_clear_changed(&xe->xdf1);
      +	xdl_clear_changed(&xe->xdf2);
      +
      +	for (i = 0; i < nr_hunks; i++) {
     -+		const struct xdl_hunk *h = &hunks[i];
     ++		struct xdl_hunk *h = &hunks[i];
      +
      +		if (h->old_count < 0 || h->new_count < 0)
      +			return -1;
     -+
     -+		/* Bounds check (1-based line numbers) */
     -+		if (h->old_count > 0 &&
     -+		    (h->old_start < 1 ||
     -+		     h->old_start + h->old_count - 1 > (long)xe->xdf1.nrec))
     -+			return -1;
     -+		if (h->new_count > 0 &&
     -+		    (h->new_start < 1 ||
     -+		     h->new_start + h->new_count - 1 > (long)xe->xdf2.nrec))
     ++		if (h->old_start < 1 || h->new_start < 1)
      +			return -1;
      +
     -+		/* Zero-count hunks: start must still be in [1, nrec+1] */
     -+		if (h->old_count == 0 &&
     -+		    (h->old_start < 1 || h->old_start > (long)xe->xdf1.nrec + 1))
     ++		/*
     ++		 * Range must fit: start + count - 1 <= nrec,
     ++		 * rewritten to avoid overflow.  Same for both sides.
     ++		 *
     ++		 * When count is 0 (pure insert/delete) the check
     ++		 * reduces to 0 > nrec - start + 1, which rejects
     ++		 * start > nrec + 1 and allows start == nrec + 1
     ++		 * (the position after the last line).
     ++		 */
     ++		if (h->old_count > (long)xe->xdf1.nrec - h->old_start + 1)
      +			return -1;
     -+		if (h->new_count == 0 &&
     -+		    (h->new_start < 1 || h->new_start > (long)xe->xdf2.nrec + 1))
     ++		if (h->new_count > (long)xe->xdf2.nrec - h->new_start + 1)
      +			return -1;
      +
     -+		/* Ordering: no overlap with previous hunk */
     ++		/* Ordering: no overlap with previous hunk (adjacent is OK) */
      +		if (h->old_start < prev_old_end ||
      +		    h->new_start < prev_new_end)
      +			return -1;
     @@ xdiff/xdiffi.c: static void xdl_mark_ignorable_regex(xdchange_t *xscr, const xdf
      -	}
      +
      +diff_done:
     -+
       	if (xdl_change_compact(&xe.xdf1, &xe.xdf2, xpp->flags) < 0 ||
       	    xdl_change_compact(&xe.xdf2, &xe.xdf1, xpp->flags) < 0 ||
       	    xdl_build_script(&xe, &xscr) < 0) {
 2:  de6d85f9d7 ! 2:  58f4763c63 userdiff: add diff.<driver>.process config
     @@ Metadata
       ## Commit message ##
          userdiff: add diff.<driver>.process config
      
     -    Add a new per-driver configuration key that specifies the command
     -    for a long-running diff process.
     -
     -    The name follows filter.<driver>.process: a long-running subprocess
     -    that stays alive across files within a single git invocation.
     +    Add the process field to struct userdiff_driver and teach the
     +    config parser to populate it from diff.<driver>.process.
      
          Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
      
 -:  ---------- > 3:  d6c833dd42 sub-process: separate process lifecycle from hashmap management
 3:  c25647c6e5 ! 4:  d044fa0ee5 diff: add long-running diff process via diff.<driver>.process
     @@ Commit message
                  process = /path/to/diff-tool
      
          The tool provides custom line-matching: it receives file pairs
     -    and returns hunks that reference original line numbers.  Unlike
     -    textconv, which transforms the displayed content, the diff
     -    output shows the actual file while the tool controls which
     -    lines are marked as changed.
     +    and returns hunks that reference line numbers in the content.
     +    When textconv is also configured, the tool receives the
     +    textconv-transformed content.  The tool controls which lines
     +    are marked as changed while the display shows the file content.
     +    Patch output features (word diff, function context, color) work
     +    normally; summary formats like --stat use their own diff path
     +    and are not affected.
      
          The handshake negotiates version=1 and capability=hunks.  Per-file
          requests send command=hunks, pathname, and both file contents as
          packetized data.  The tool responds with hunk lines and a status
     -    packet.  On error, git falls back to the builtin diff algorithm
     -    with a warning.
     +    packet (success, error, or abort).  On error, Git warns and falls
     +    back to the builtin diff algorithm for that file.  On abort, Git
     +    silently falls back for the current file and stops sending further
     +    requests to the tool for the remainder of the session.
      
     -    Zero hunks with status=success means the tool considers the
     -    files equivalent.  Git skips diff output for that file.
     +    When the tool returns no hunks followed by status=success, Git
     +    treats the file as having no changes and produces no diff output.
     +    This also means --exit-code reports no changes for that file.
     +
     +    The subprocess is stored on the userdiff_driver struct and
     +    launched on first use.  If the process fails to start, the
     +    handshake fails, or a communication error occurs mid-stream,
     +    the failure is cached on the driver to avoid retrying and
     +    re-warning on every subsequent file.
     +
     +    diff_process_fill_hunks() is the sole public entry point.  It
     +    handles driver lookup, flag checks, subprocess management, and
     +    error reporting, returning an enum that lets callers distinguish
     +    "hunks populated" from "files equivalent" from "not applicable"
     +    from "tool failure."
      
          Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
      
     @@ Documentation/config/diff.adoc: endif::git-diff[]
       	conversion outputs.  See linkgit:gitattributes[5] for details.
       
      +`diff.<driver>.process`::
     -+	The command to run as a long-running diff process.
     -+	The tool communicates via the pkt-line protocol and returns
     -+	hunks that are fed into Git's diff and blame pipelines.
     -+	If the tool returns zero hunks, the file is treated as
     -+	unchanged for both diff output and blame attribution.
     ++	The command to run as a long-running diff process that
     ++	provides hunks to Git's diff pipeline.
      +	See linkgit:gitattributes[5] for details.
      +
       `diff.indentHeuristic`::
     @@ Documentation/gitattributes.adoc: NOTE: If `diff.<name>.command` is defined for
       algorithm is not passed to the external diff driver.
       
      +Using an external diff process
     -+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
     -+
     -+An external tool can provide content-aware line matching by
     -+setting `diff.<name>.process` to the command that runs
     -+the tool.  The tool is a long-running process that communicates via
     -+the pkt-line protocol (described in
     ++^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
     ++
     ++If `diff.<name>.process` is defined, Git sends the old and new file
     ++content to an external tool and receives back a list of changed
     ++regions (pairs of line ranges in the old and new file).  Git uses
     ++these instead of its builtin diff algorithm, but still controls
     ++all output formatting, so features like word diff, function context,
     ++color, and blame work normally.  This is achieved by using the
     ++long-running process protocol (described in
      +Documentation/technical/long-running-process-protocol.adoc).
     ++Unlike `diff.<name>.command`, which replaces Git's output entirely,
     ++the diff process feeds results back into the standard pipeline.
     ++
     ++First, in `.gitattributes`, assign the `diff` attribute for paths.
      +
      +------------------------
      +*.c diff=cdiff
      +------------------------
      +
     ++Then, define a "diff.<name>.process" configuration to specify
     ++the diff process command.
     ++
      +----------------------------------------------------------------
      +[diff "cdiff"]
      +  process = /path/to/diff-process-tool
      +----------------------------------------------------------------
      +
     -+The tool receives file pairs and returns hunk descriptors indicating
     -+which lines changed.  Git feeds these hunks into its standard diff
     -+pipeline, so all output features (word diff, function context,
     -+color) work normally.
     -+
     -+If the tool fails or returns an error, Git silently falls back to
     -+the builtin diff algorithm.  If the tool returns invalid hunks
     -+(out of bounds, overlapping), Git also falls back silently.
     -+
     -+The handshake negotiates `version=1` and `capability=hunks`.
     -+Per-file requests send `command=hunks` and `pathname=<path>`,
     -+followed by the old and new file content as packetized data.
     -+The tool responds with lines of the form
     -+`hunk <old_start> <old_count> <new_start> <new_count>`
     -+(1-based line numbers), a flush packet, and `status=success`.
     -+
     -+If the tool returns zero hunks with `status=success`, Git treats
     -+the file as having no changes and produces no diff output.
     -+
     -+Tools should ignore unknown keys in the per-file request to
     -+remain forward-compatible.
     ++When Git encounters the first file that needs to be diffed, it starts
     ++the process and performs the handshake.  In the handshake, the welcome
     ++message sent by Git is "git-diff-client", only version 1 is supported,
     ++and the supported capability is "hunks" (the changed regions
     ++described below).
     ++
     ++For each file, Git sends a list of "key=value" pairs terminated with
     ++a flush packet, followed by the old and new file content as packetized
     ++data, each terminated with a flush packet.  The pathname is relative
     ++to the repository root.  When `diff.<name>.textconv` is also set,
     ++the tool receives the textconv-transformed content rather than the
     ++raw blob.  Git does not send binary files to the diff process.
     ++
     ++-----------------------
     ++packet:          git> command=hunks
     ++packet:          git> pathname=path/file.c
     ++packet:          git> 0000
     ++packet:          git> OLD_CONTENT
     ++packet:          git> 0000
     ++packet:          git> NEW_CONTENT
     ++packet:          git> 0000
     ++-----------------------
     ++
     ++The tool is expected to respond with zero or more hunk lines,
     ++a flush packet, and a status packet terminated with a flush packet.
     ++Each hunk line has the form:
     ++
     ++  `hunk <old_start> <old_count> <new_start> <new_count>`
     ++
     ++where `<old_start>` and `<old_count>` identify a range of lines in
     ++the old file, and `<new_start>` and `<new_count>` identify the
     ++replacement range in the new file.  Start values are 1-based and
     ++counts are non-negative.  Ranges must not extend beyond the end of
     ++the file.  For example, `hunk 3 2 3 4` means that 2 lines starting
     ++at line 3 in the old file were replaced by 4 lines starting at
     ++line 3 in the new file.  An `<old_count>` of 0 means no lines were
     ++removed (pure insertion); a `<new_count>` of 0 means no lines were
     ++added (pure deletion).
     ++
     ++Lines are delimited by newlines.  A file `"foo\nbar\n"` and a
     ++file `"foo\nbar"` both have 2 lines.
     ++
     ++Hunks must be listed in order and must not overlap.  Any line
     ++not covered by a hunk is treated as unchanged, so the total
     ++number of unchanged lines must be the same on both sides.
     ++For example, if the old file has 10 lines and the hunks cover
     ++4 of them (`old_count` values summing to 4), then 6 old lines
     ++are unchanged.  The new file must also have exactly 6 lines
     ++not covered by hunks, so the `new_count` values must sum to
     ++`new_file_lines - 6`.
     ++
     ++-----------------------
     ++packet:          git< hunk 1 3 1 5
     ++packet:          git< hunk 10 2 12 2
     ++packet:          git< 0000
     ++packet:          git< status=success
     ++packet:          git< 0000
     ++-----------------------
     ++
     ++If the tool responds with hunks and "success", Git marks those lines
     ++as changed and feeds them into the standard diff pipeline.  Patch
     ++output features (word diff, function context, color) work normally.
     ++Note that `--stat` and other summary formats use their own diff path
     ++and are not affected by the diff process.
     ++
     ++If no hunk lines precede the flush, followed by "success", Git
     ++treats the files as having no changes: `git diff` produces no output
     ++and `git blame` skips the commit, attributing lines to earlier commits.
     ++
     ++-----------------------
     ++packet:          git< 0000
     ++packet:          git< status=success
     ++packet:          git< 0000
     ++-----------------------
     ++
     ++If the tool returns invalid hunks (out of bounds, overlapping), Git
     ++silently falls back to the builtin diff algorithm.
     ++
     ++In case the tool cannot or does not want to process the content,
     ++it is expected to respond with an "error" status.  Git warns and
     ++falls back to the builtin diff algorithm for this file.  The tool
     ++remains available for subsequent files.
     ++
     ++-----------------------
     ++packet:          git< 0000
     ++packet:          git< status=error
     ++packet:          git< 0000
     ++-----------------------
     ++
     ++In case the tool cannot or does not want to process the content as
     ++well as any future content for the lifetime of the Git process, it
     ++is expected to respond with an "abort" status.  Git silently falls
     ++back to the builtin diff algorithm for this file and does not send
     ++further requests to the tool.
     ++
     ++-----------------------
     ++packet:          git< 0000
     ++packet:          git< status=abort
     ++packet:          git< 0000
     ++-----------------------
     ++
     ++If the tool dies during the communication or does not adhere to the
     ++protocol then Git will stop the process and fall back to the builtin
     ++diff algorithm.  Git warns once and does not restart the process for
     ++subsequent files.
     ++
     ++Tools should ignore unknown keys in the per-file request to remain
     ++forward-compatible.  Future versions of Git may send additional
     ++`command=` values; tools that receive an unrecognized command should
     ++respond with `status=error` rather than terminating.
      +
       Defining a custom hunk-header
       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
     @@ diff-process.c (new)
      +/*
      + * Diff process backend: communicates with a long-running external
      + * tool via the pkt-line protocol to obtain custom line-matching
     -+ * results.  Unlike textconv, which transforms the displayed content,
     -+ * hunks from a diff process reference original line numbers and
     -+ * the display shows the actual file content.
     ++ * results.  The tool controls which lines are marked as changed
     ++ * while the display shows the file content (after any textconv
     ++ * transformation, if configured).
      + *
      + * Protocol: pkt-line over stdin/stdout, following the pattern of
      + * the long-running filter process protocol (see convert.c).
     @@ diff-process.c (new)
      + *   tool< ... / flush
      + *   tool< status=success / flush
      + *
     -+ * Zero hunks with status=success means the tool considers the
     -+ * files equivalent.  Git will skip the diff for that file.
     ++ * When the tool returns no hunks with status=success, it considers
     ++ * the files equivalent.  Git will skip the diff for that file.
      + */
      +
      +#include "git-compat-util.h"
      +#include "diff-process.h"
     ++#include "diff.h"
     ++#include "gettext.h"
     ++#include "repository.h"
     ++#include "sigchain.h"
      +#include "userdiff.h"
      +#include "sub-process.h"
      +#include "pkt-line.h"
     @@ diff-process.c (new)
      +	unsigned int supported_capabilities;
      +};
      +
     -+static int subprocess_map_initialized;
     -+static struct hashmap subprocess_map;
     -+
      +static int start_diff_process_fn(struct subprocess_entry *subprocess)
      +{
      +	static int versions[] = { 1, 0 };
     @@ diff-process.c (new)
      +		{ NULL, 0 }
      +	};
      +	struct diff_subprocess *entry =
     -+		(struct diff_subprocess *)subprocess;
     ++		container_of(subprocess, struct diff_subprocess, subprocess);
      +
     -+	/* Uses dying pkt-line variant, same as convert.c filters. */
      +	return subprocess_handshake(subprocess, "git-diff",
      +				    versions, NULL,
      +				    capabilities,
      +				    &entry->supported_capabilities);
      +}
      +
     -+static struct diff_subprocess *find_or_start_process(const char *cmd)
     ++static struct diff_subprocess *get_or_launch_process(
     ++		struct userdiff_driver *drv)
      +{
      +	struct diff_subprocess *entry;
      +
     -+	if (!subprocess_map_initialized) {
     -+		subprocess_map_initialized = 1;
     -+		hashmap_init(&subprocess_map, cmd2process_cmp, NULL, 0);
     -+	}
     -+
     -+	entry = (struct diff_subprocess *)
     -+		subprocess_find_entry(&subprocess_map, cmd);
     -+	if (entry)
     -+		return entry;
     ++	if (drv->diff_subprocess)
     ++		return drv->diff_subprocess;
      +
      +	entry = xcalloc(1, sizeof(*entry));
     -+	if (subprocess_start(&subprocess_map, &entry->subprocess,
     -+			     cmd, start_diff_process_fn)) {
     ++	if (subprocess_start_command(&entry->subprocess, drv->process,
     ++				     start_diff_process_fn)) {
      +		free(entry);
     ++		drv->diff_process_failed = 1;
      +		return NULL;
      +	}
      +
     ++	drv->diff_subprocess = entry;
      +	return entry;
      +}
      +
      +static int send_file_content(int fd, const char *buf, long size)
      +{
     -+	int ret;
     ++	int ret = 0;
      +
     ++	if (size < 0)
     ++		return -1;
      +	if (size > 0)
      +		ret = write_packetized_from_buf_no_flush(buf, size, fd);
     -+	else
     -+		ret = 0;
      +	if (ret)
      +		return ret;
      +	return packet_flush_gently(fd);
     @@ diff-process.c (new)
      +{
      +	char *end;
      +
     -+	/* Format: "hunk <old_start> <old_count> <new_start> <new_count>" */
     ++	/*
     ++	 * Format: "hunk <old_start> <old_count> <new_start> <new_count>"
     ++	 * All numbers must be non-negative decimal with no leading
     ++	 * whitespace or sign characters.
     ++	 */
      +	if (!skip_prefix(line, "hunk ", &line))
      +		return -1;
      +
     ++	if (!isdigit(*line))
     ++		return -1;
     ++	errno = 0;
      +	hunk->old_start = strtol(line, &end, 10);
     -+	if (end == line || *end != ' ')
     ++	if (errno || end == line || *end++ != ' ')
      +		return -1;
      +	line = end;
      +
     ++	if (!isdigit(*line))
     ++		return -1;
     ++	errno = 0;
      +	hunk->old_count = strtol(line, &end, 10);
     -+	if (end == line || *end != ' ')
     ++	if (errno || end == line || *end++ != ' ')
      +		return -1;
      +	line = end;
      +
     ++	if (!isdigit(*line))
     ++		return -1;
     ++	errno = 0;
      +	hunk->new_start = strtol(line, &end, 10);
     -+	if (end == line || *end != ' ')
     ++	if (errno || end == line || *end++ != ' ')
      +		return -1;
      +	line = end;
      +
     ++	if (!isdigit(*line))
     ++		return -1;
     ++	errno = 0;
      +	hunk->new_count = strtol(line, &end, 10);
     -+	if (end == line || *end != '\0')
     ++	if (errno || end == line || *end != '\0')
      +		return -1;
      +
      +	return 0;
      +}
      +
     -+int diff_process_get_hunks(struct userdiff_driver *drv,
     -+			   const char *path,
     -+			   const char *old_buf, long old_size,
     -+			   const char *new_buf, long new_size,
     -+			   struct xdl_hunk **hunks_out,
     -+			   size_t *nr_hunks_out)
     ++static enum diff_process_result get_hunks(
     ++		struct userdiff_driver *drv,
     ++		const char *path,
     ++		const char *old_buf, long old_size,
     ++		const char *new_buf, long new_size,
     ++		struct xdl_hunk **hunks_out,
     ++		size_t *nr_hunks_out)
      +{
      +	struct diff_subprocess *backend;
      +	struct child_process *process;
     @@ diff-process.c (new)
      +	int len;
      +	char *line;
      +
     -+	if (!drv || !drv->process)
     -+		return -1;
     -+
     -+	backend = find_or_start_process(drv->process);
     ++	backend = get_or_launch_process(drv);
      +	if (!backend)
     -+		return -1;
     ++		return DIFF_PROCESS_ERROR;
      +
      +	if (!(backend->supported_capabilities & CAP_HUNKS))
     -+		return -1;
     ++		return DIFF_PROCESS_SKIP;
      +
      +	process = subprocess_get_child_process(&backend->subprocess);
      +	fd_in = process->in;
      +	fd_out = process->out;
      +
     ++	sigchain_push(SIGPIPE, SIG_IGN);
     ++
      +	/* Send request */
      +	if (packet_write_fmt_gently(fd_in, "command=hunks\n") ||
      +	    packet_write_fmt_gently(fd_in, "pathname=%s\n", path) ||
      +	    packet_flush_gently(fd_in))
     -+		goto error;
     ++		goto comm_error;
      +
      +	/* Send old file content */
      +	if (send_file_content(fd_in, old_buf, old_size))
     -+		goto error;
     ++		goto comm_error;
      +
      +	/* Send new file content */
      +	if (send_file_content(fd_in, new_buf, new_size))
     -+		goto error;
     ++		goto comm_error;
      +
      +	/* Read hunks until flush packet */
      +	while ((len = packet_read_line_gently(fd_out, NULL, &line)) >= 0 &&
      +	       line) {
      +		if (parse_hunk_line(line, &hunk) < 0)
     -+			goto error;
     ++			goto comm_error;
      +		ALLOC_GROW(hunks, nr_hunks + 1, alloc_hunks);
      +		hunks[nr_hunks++] = hunk;
      +	}
      +	if (len < 0)
     -+		goto error;
     ++		goto comm_error;
      +
      +	/* Read status */
      +	if (subprocess_read_status(fd_out, &status))
     -+		goto error;
     ++		goto comm_error;
     ++
     ++	if (!strcmp(status.buf, "success")) {
     ++		*hunks_out = hunks;
     ++		*nr_hunks_out = nr_hunks;
     ++		strbuf_release(&status);
     ++		sigchain_pop(SIGPIPE);
     ++		return DIFF_PROCESS_OK;
     ++	}
      +
     -+	if (strcmp(status.buf, "success")) {
     -+		if (!strcmp(status.buf, "abort"))
     -+			backend->supported_capabilities &= ~CAP_HUNKS;
     -+		goto error;
     ++	if (!strcmp(status.buf, "abort")) {
     ++		/*
     ++		 * The tool voluntarily withdrew: stop sending requests
     ++		 * but do not warn (this is not a failure).
     ++		 */
     ++		backend->supported_capabilities &= ~CAP_HUNKS;
     ++		free(hunks);
     ++		strbuf_release(&status);
     ++		sigchain_pop(SIGPIPE);
     ++		return DIFF_PROCESS_SKIP;
      +	}
      +
     -+	*hunks_out = hunks;
     -+	*nr_hunks_out = nr_hunks;
     ++	/* status=error or unknown status */
     ++	free(hunks);
      +	strbuf_release(&status);
     -+	return 0;
     -+
     -+error:
     ++	sigchain_pop(SIGPIPE);
     ++	return DIFF_PROCESS_ERROR;
     ++
     ++comm_error:
     ++	/*
     ++	 * Communication failure (broken pipe, malformed response).
     ++	 * Tear down the process and mark as failed so we do not
     ++	 * retry on every subsequent file.
     ++	 */
     ++	drv->diff_process_failed = 1;
     ++	drv->diff_subprocess = NULL;
     ++	subprocess_stop_command(&backend->subprocess);
     ++	free(backend);
      +	free(hunks);
      +	strbuf_release(&status);
     -+	return -1;
     ++	sigchain_pop(SIGPIPE);
     ++	return DIFF_PROCESS_ERROR;
     ++}
     ++
     ++enum diff_process_result diff_process_fill_hunks(
     ++		struct diff_options *diffopt,
     ++		const char *path,
     ++		const mmfile_t *file_a,
     ++		const mmfile_t *file_b,
     ++		xpparam_t *xpp)
     ++{
     ++	struct userdiff_driver *drv;
     ++	struct xdl_hunk *ext_hunks = NULL;
     ++	size_t nr = 0;
     ++	enum diff_process_result res;
     ++
     ++	if (!diffopt || !path)
     ++		return DIFF_PROCESS_SKIP;
     ++	if (diffopt->flags.no_diff_process || diffopt->ignore_driver_algorithm)
     ++		return DIFF_PROCESS_SKIP;
     ++
     ++	drv = userdiff_find_by_path(diffopt->repo->index, path);
     ++	if (!drv || !drv->process)
     ++		return DIFF_PROCESS_SKIP;
     ++	if (drv->diff_process_failed)
     ++		return DIFF_PROCESS_SKIP;
     ++
     ++	res = get_hunks(drv, path,
     ++			file_a->ptr, file_a->size,
     ++			file_b->ptr, file_b->size,
     ++			&ext_hunks, &nr);
     ++	if (res == DIFF_PROCESS_OK) {
     ++		if (!nr) {
     ++			free(ext_hunks);
     ++			return DIFF_PROCESS_EQUIVALENT;
     ++		}
     ++		xpp->external_hunks = ext_hunks;
     ++		xpp->external_hunks_nr = nr;
     ++		return DIFF_PROCESS_OK;
     ++	}
     ++	if (res == DIFF_PROCESS_ERROR) {
     ++		warning(_("diff process '%s' failed for '%s',"
     ++			  " falling back to builtin diff"),
     ++			drv->process, path);
     ++		return DIFF_PROCESS_ERROR;
     ++	}
     ++	return DIFF_PROCESS_SKIP;
      +}
      
       ## diff-process.h (new) ##
     @@ diff-process.h (new)
      +#ifndef DIFF_PROCESS_H
      +#define DIFF_PROCESS_H
      +
     -+struct userdiff_driver;
     -+struct xdl_hunk;
     ++#include "xdiff/xdiff.h"
     ++
     ++struct diff_options;
     ++
     ++enum diff_process_result {
     ++	DIFF_PROCESS_ERROR = -1, /* tool failure: warned, fell back */
     ++	DIFF_PROCESS_OK = 0,     /* hunks populated in xpp */
     ++	DIFF_PROCESS_SKIP,       /* no process configured: use builtin */
     ++	DIFF_PROCESS_EQUIVALENT, /* tool says files are equivalent */
     ++};
      +
      +/*
     -+ * Query a diff process for hunks describing the changes
     -+ * between old_buf and new_buf.
     ++ * Consult the diff process configured for 'path' and populate
     ++ * xpp->external_hunks with the returned hunks.
      + *
     -+ * The backend is a long-running subprocess configured via
     -+ * diff.<driver>.process.  It receives file content via
     -+ * pkt-line and returns hunks with 1-based line numbers.
     ++ * Handles driver lookup, flag checks (--no-ext-diff,
     ++ * --diff-algorithm), subprocess management, and error reporting.
      + *
     -+ * On success, sets *hunks_out and *nr_hunks_out to a newly allocated
     -+ * array (caller must free) and returns 0.
     ++ * Returns DIFF_PROCESS_OK when hunks are populated in xpp.
     ++ * The caller owns xpp->external_hunks and must free() it.
      + *
     -+ * On failure, returns -1.  The caller should fall back to the
     -+ * builtin diff algorithm.
     ++ * Returns DIFF_PROCESS_EQUIVALENT when the tool returns no hunks
     ++ * (files are considered identical); caller should skip diff/blame.
     ++ * Returns DIFF_PROCESS_SKIP when no process applies; caller
     ++ * should use the builtin diff algorithm.
     ++ * Returns DIFF_PROCESS_ERROR on tool failure (already warned);
     ++ * caller should fall back to the builtin diff algorithm.
      + */
     -+int diff_process_get_hunks(struct userdiff_driver *drv,
     -+			   const char *path,
     -+			   const char *old_buf, long old_size,
     -+			   const char *new_buf, long new_size,
     -+			   struct xdl_hunk **hunks_out,
     -+			   size_t *nr_hunks_out);
     ++enum diff_process_result diff_process_fill_hunks(
     ++		struct diff_options *diffopt,
     ++		const char *path,
     ++		const mmfile_t *file_a,
     ++		const mmfile_t *file_b,
     ++		xpparam_t *xpp);
      +
      +#endif /* DIFF_PROCESS_H */
      
     @@ diff.c
       #include "submodule.h"
       #include "hashmap.h"
       #include "mem-pool.h"
     -@@ diff.c: static void builtin_diff(const char *name_a,
     - 		xpparam_t xpp;
     - 		xdemitconf_t xecfg;
     - 		struct emit_callback ecbdata;
     -+		struct xdl_hunk *ext_hunks = NULL;
     - 		unsigned ws_rule;
     - 		const struct userdiff_funcname *pe;
     - 
      @@ diff.c: static void builtin_diff(const char *name_a,
       		xpp.ignore_regex_nr = o->ignore_regex_nr;
       		xpp.anchors = o->anchors;
       		xpp.anchors_nr = o->anchors_nr;
      +
     -+		if (!o->ignore_driver_algorithm &&
     -+		    one->driver && one->driver->process) {
     -+			size_t ext_hunks_nr = 0;
     -+			if (!diff_process_get_hunks(
     -+				    one->driver, name_a,
     -+				    mf1.ptr, mf1.size,
     -+				    mf2.ptr, mf2.size,
     -+				    &ext_hunks, &ext_hunks_nr)) {
     -+				if (!ext_hunks_nr)
     -+					goto free_ab_and_return;
     -+				xpp.external_hunks = ext_hunks;
     -+				xpp.external_hunks_nr = ext_hunks_nr;
     -+			} else {
     -+				warning(_("diff process failed for '%s',"
     -+					  " falling back to builtin diff"),
     -+					name_a);
     -+			}
     ++		if (diff_process_fill_hunks(o, name_a,
     ++					    &mf1, &mf2, &xpp)
     ++		    == DIFF_PROCESS_EQUIVALENT) {
     ++			if (textconv_one)
     ++				free(mf1.ptr);
     ++			if (textconv_two)
     ++				free(mf2.ptr);
     ++			goto free_ab_and_return;
      +		}
      +
       		xecfg.ctxlen = o->context;
     @@ diff.c: static void builtin_diff(const char *name_a,
       		} else if (xdi_diff_outf(&mf1, &mf2, NULL, fn_out_consume,
       					 &ecbdata, &xpp, &xecfg))
       			die("unable to generate diff for %s", one->path);
     -+		free(ext_hunks);
     ++		free(xpp.external_hunks);
       		if (o->word_diff)
       			free_diff_words_data(&ecbdata);
       		if (textconv_one)
      
     + ## diff.h ##
     +@@ diff.h: struct diff_flags {
     + 	 */
     + 	unsigned allow_external;
     + 
     ++	/** Disables diff.<driver>.process. */
     ++	unsigned no_diff_process;
     ++
     + 	/**
     + 	 * For communication between the calling program and the options parser;
     + 	 * tell the calling program to signal the presence of difference using
     +
     + ## meson.build ##
     +@@ meson.build: libgit_sources = [
     +   'diff-merges.c',
     +   'diff-lib.c',
     +   'diff-no-index.c',
     ++  'diff-process.c',
     +   'diff.c',
     +   'diffcore-break.c',
     +   'diffcore-delta.c',
     +
       ## t/.gitattributes ##
      @@ t/.gitattributes: t[0-9][0-9][0-9][0-9]/* -whitespace
       /t8005/*.txt eol=lf
     @@ t/.gitattributes: t[0-9][0-9][0-9][0-9]/* -whitespace
       /t0040*.sh whitespace=-indent-with-non-tab
      +/t4080-diff-process.sh whitespace=-indent-with-non-tab
      
     + ## t/meson.build ##
     +@@ t/meson.build: integration_tests = [
     +   't4072-diff-max-depth.sh',
     +   't4073-diff-stat-name-width.sh',
     +   't4074-diff-shifted-matched-group.sh',
     ++  't4080-diff-process.sh',
     +   't4100-apply-stat.sh',
     +   't4101-apply-nonl.sh',
     +   't4102-apply-rename.sh',
     +
       ## t/t4080-diff-process.sh (new) ##
      @@
      +#!/bin/sh
     @@ t/t4080-diff-process.sh (new)
      +#   whole-file  - report all lines as changed (default)
      +#   fixed-hunk  - always report hunk 5 2 5 2
      +#   bad-hunk    - report out-of-bounds hunk 999 1 999 1
     -+#   zero-hunk   - return zero hunks (files considered equivalent)
     ++#   bad-sync    - report hunk with mismatched unchanged totals
     ++#   overlap     - report two overlapping hunks
     ++#   no-hunks   - return no hunks (files considered equivalent)
      +#   error       - return status=error for every request
      +#   abort       - return status=abort for every request
      +#   crash       - read one request then exit without responding
     @@ t/t4080-diff-process.sh (new)
      +	    if cmd is None: sys.exit(0)
      +	    old = read_content()
      +	    new = read_content()
     -+	    log(f"command={cmd} pathname={pathname}")
     ++	    old_first = old.split(b"\n")[0].decode(errors="replace") if old else ""
     ++	    new_first = new.split(b"\n")[0].decode(errors="replace") if new else ""
     ++	    log(f"command={cmd} pathname={pathname} old={old_first} new={new_first}")
      +
      +	    if mode == "error":
      +	        write_flush()
     @@ t/t4080-diff-process.sh (new)
      +	            write_pkt("hunk 5 2 5 2")
      +	        elif mode == "bad-hunk":
      +	            write_pkt("hunk 999 1 999 1")
     -+	        elif mode == "zero-hunk":
     ++	        elif mode == "bad-sync":
     ++	            write_pkt("hunk 1 2 1 1")
     ++	        elif mode == "overlap":
     ++	            write_pkt("hunk 1 5 1 5")
     ++	            write_pkt("hunk 3 2 3 2")
     ++	        elif mode == "no-hunks":
      +	            pass
      +	        else:
     -+	            ol = len(old.split(b"\n"))
     -+	            nl = len(new.split(b"\n"))
     ++	            ol = old.count(b"\n")
     ++	            nl = new.count(b"\n")
      +	            write_pkt(f"hunk 1 {ol} 1 {nl}")
      +	        write_flush()
      +	        write_pkt("status=success")
     @@ t/t4080-diff-process.sh (new)
      +	setup_backend &&
      +	echo "*.c diff=cdiff" >.gitattributes &&
      +	git add .gitattributes &&
     -+	git commit -m "initial"
     -+'
      +
     -+test_expect_success PYTHON 'diff process hunk boundaries affect output' '
     ++	# boundary.c: 10 lines, changes at 5-6 and 9-10.
     ++	# Used by: hunk boundaries, error fallback, crash, bad hunks, overlap.
      +	cat >boundary.c <<-\EOF &&
      +	line1
      +	line2
     @@ t/t4080-diff-process.sh (new)
      +	OLD10
      +	EOF
      +	git add boundary.c &&
     -+	git commit -m "add boundary.c" &&
      +
     ++	# worddiff.c: single-line function, value changes 1 -> 999.
     ++	# Used by: word-diff, --diff-algorithm, --no-ext-diff, --stat.
     ++	cat >worddiff.c <<-\EOF &&
     ++	int value(void) { return 1; }
     ++	EOF
     ++	git add worddiff.c &&
     ++
     ++	# newfile.c: single-line function, value changes 42 -> 99.
     ++	# Used by: new file, --exit-code, multiple drivers.
     ++	cat >newfile.c <<-\EOF &&
     ++	int new_func(void) { return 42; }
     ++	EOF
     ++	git add newfile.c &&
     ++
     ++	# logtest.c: single-line function for log/format-patch tests.
     ++	# Needs two commits so log -1 has a diff.
     ++	cat >logtest.c <<-\EOF &&
     ++	int logfunc(void) { return 1; }
     ++	EOF
     ++	git add logtest.c &&
     ++
     ++	# two.c/one.c: two-file pair for error/abort/startup-failure tests.
     ++	cat >one.c <<-\EOF &&
     ++	int first(void) { return 1; }
     ++	EOF
     ++	cat >two.c <<-\EOF &&
     ++	int second(void) { return 2; }
     ++	EOF
     ++	git add one.c two.c &&
     ++
     ++	git commit -m "initial" &&
     ++
     ++	# Second commit for logtest.c (so log -1 has something to show).
     ++	cat >logtest.c <<-\EOF &&
     ++	int logfunc(void) { return 2; }
     ++	EOF
     ++	git add logtest.c &&
     ++	git commit -m "change logtest.c" &&
     ++
     ++	# Working tree modifications (not committed).
      +	cat >boundary.c <<-\EOF &&
      +	line1
      +	line2
     @@ t/t4080-diff-process.sh (new)
      +	NEW10
      +	EOF
      +
     ++	cat >worddiff.c <<-\EOF &&
     ++	int value(void) { return 999; }
     ++	EOF
     ++
     ++	cat >newfile.c <<-\EOF &&
     ++	int new_func(void) { return 99; }
     ++	EOF
     ++
     ++	cat >one.c <<-\EOF &&
     ++	int first(void) { return 10; }
     ++	EOF
     ++
     ++	cat >two.c <<-\EOF
     ++	int second(void) { return 20; }
     ++	EOF
     ++'
     ++
     ++#
     ++# Core behavior: the tool controls which lines are marked as changed.
     ++#
     ++
     ++test_expect_success PYTHON 'diff process hunk boundaries affect output' '
      +	# The file has changes at lines 5-6 and 9-10, but fixed-hunk
      +	# only reports lines 5-6 as changed.  Lines 9-10 should not
      +	# appear as changed in the output.
     @@ t/t4080-diff-process.sh (new)
      +	test_grep "^-OLD6" actual &&
      +	test_grep "^+NEW5" actual &&
      +	test_grep "^+NEW6" actual &&
     -+	! test_grep "^-OLD9" actual &&
     -+	! test_grep "^-OLD10" actual &&
     -+	! test_grep "^+NEW9" actual &&
     -+	! test_grep "^+NEW10" actual
     ++	test_grep ! "^-OLD9" actual &&
     ++	test_grep ! "^-OLD10" actual &&
     ++	test_grep ! "^+NEW9" actual &&
     ++	test_grep ! "^+NEW10" actual
      +'
      +
     -+test_expect_success PYTHON 'diff process fallback on tool error status' '
     ++test_expect_success PYTHON 'diff process works with new file' '
      +	rm -f backend.log &&
     -+	git -c diff.cdiff.process="$BACKEND --mode=error --log=backend.log" \
     -+		diff boundary.c >actual &&
     -+	# Fallback produces the full builtin diff (both change regions).
     -+	test_grep "^-OLD5" actual &&
     -+	test_grep "^+NEW5" actual &&
     -+	test_grep "^-OLD9" actual &&
     -+	test_grep "^+NEW9" actual &&
     -+	# Tool was contacted (it replied with error, not crash).
     -+	test_grep "command=hunks pathname=boundary.c" backend.log
     ++	git -c diff.cdiff.process="$BACKEND --log=backend.log" \
     ++		diff -- newfile.c >actual 2>stderr &&
     ++	test_grep "return 99" actual &&
     ++	test_grep "pathname=newfile.c" backend.log &&
     ++	test_must_be_empty stderr
      +'
      +
     -+test_expect_success PYTHON 'diff process fallback on bad hunks' '
     -+	git -c diff.cdiff.process="$BACKEND --mode=bad-hunk" \
     -+		diff boundary.c >actual &&
     -+	test_grep "^-OLD5" actual &&
     -+	test_grep "^+NEW5" actual &&
     -+	test_grep "^-OLD9" actual &&
     -+	test_grep "^+NEW9" actual
     ++test_expect_success PYTHON 'diff process works with added file (empty old side)' '
     ++	cat >added.c <<-\EOF &&
     ++	int added(void) { return 1; }
     ++	EOF
     ++	git add added.c &&
     ++
     ++	rm -f backend.log &&
     ++	git -c diff.cdiff.process="$BACKEND --log=backend.log" \
     ++		diff --cached -- added.c >actual 2>stderr &&
     ++	test_grep "added" actual &&
     ++	test_grep "pathname=added.c" backend.log &&
     ++	test_must_be_empty stderr
      +'
      +
     -+test_expect_success PYTHON 'diff process fallback on tool crash' '
     -+	git -c diff.cdiff.process="$BACKEND --mode=crash" \
     -+		diff boundary.c >actual &&
     -+	test_grep "^-OLD5" actual &&
     -+	test_grep "^+NEW5" actual &&
     -+	test_grep "^-OLD9" actual &&
     -+	test_grep "^+NEW9" actual
     ++test_expect_success PYTHON 'diff process skipped for binary files' '
     ++	printf "\\0binary" >binary.c &&
     ++	git add binary.c &&
     ++	git commit -m "add binary" &&
     ++	printf "\\0changed" >binary.c &&
     ++
     ++	rm -f backend.log &&
     ++	git -c diff.cdiff.process="$BACKEND --log=backend.log" \
     ++		diff -- binary.c >actual &&
     ++	test_grep "Binary files" actual &&
     ++	test_path_is_missing backend.log
      +'
      +
     -+test_expect_success PYTHON 'diff process abort disables for session' '
     -+	cat >abort1.c <<-\EOF &&
     -+	int first(void) { return 1; }
     -+	EOF
     -+	cat >abort2.c <<-\EOF &&
     -+	int second(void) { return 2; }
     -+	EOF
     -+	git add abort1.c abort2.c &&
     -+	git commit -m "add abort files" &&
     ++test_expect_success PYTHON 'diff process not consulted for unmatched driver' '
     ++	echo "not tracked by cdiff" >unmatched.txt &&
     ++	git add unmatched.txt &&
     ++	git commit -m "add unmatched.txt" &&
      +
     -+	cat >abort1.c <<-\EOF &&
     -+	int first(void) { return 10; }
     -+	EOF
     -+	cat >abort2.c <<-\EOF &&
     -+	int second(void) { return 20; }
     -+	EOF
     ++	echo "modified" >unmatched.txt &&
      +
      +	rm -f backend.log &&
     -+	git -c diff.cdiff.process="$BACKEND --mode=abort --log=backend.log" \
     -+		diff -- abort1.c abort2.c >actual &&
     -+	# Both files should still produce diff output via fallback.
     -+	test_grep "return 10" actual &&
     -+	test_grep "return 20" actual &&
     -+	# The tool aborts on the first file and git clears its
     -+	# capability.  The second file never contacts the tool,
     -+	# so the log should have exactly one entry, not two.
     -+	test_grep "command=hunks" backend.log >matches &&
     -+	test_line_count = 1 matches
     ++	git -c diff.cdiff.process="$BACKEND --log=backend.log" \
     ++		diff -- unmatched.txt >actual &&
     ++	test_grep "modified" actual &&
     ++	test_path_is_missing backend.log
      +'
      +
     -+test_expect_success PYTHON 'diff process handles multiple files' '
     -+	cat >multi1.c <<-\EOF &&
     -+	int one(void) { return 1; }
     ++test_expect_success PYTHON 'multiple drivers use separate processes' '
     ++	echo "*.h diff=hdiff" >>.gitattributes &&
     ++	git add .gitattributes &&
     ++
     ++	cat >multi.h <<-\EOF &&
     ++	int header(void) { return 1; }
      +	EOF
     -+	cat >multi2.c <<-\EOF &&
     -+	int two(void) { return 2; }
     ++	git add multi.h &&
     ++	git commit -m "add multi.h" &&
     ++
     ++	cat >multi.h <<-\EOF &&
     ++	int header(void) { return 2; }
      +	EOF
     -+	git add multi1.c multi2.c &&
     -+	git commit -m "add multi files" &&
      +
     -+	cat >multi1.c <<-\EOF &&
     -+	int one(void) { return 10; }
     ++	rm -f backend-c.log backend-h.log &&
     ++	git -c diff.cdiff.process="$BACKEND --log=backend-c.log" \
     ++	    -c diff.hdiff.process="$BACKEND --log=backend-h.log" \
     ++		diff -- newfile.c multi.h >actual 2>stderr &&
     ++	test_grep "pathname=newfile.c" backend-c.log &&
     ++	test_grep "pathname=multi.h" backend-h.log &&
     ++	test_must_be_empty stderr
     ++'
     ++
     ++test_expect_success PYTHON 'diff process works alongside textconv' '
     ++	write_script uppercase-filter <<-\EOF &&
     ++	tr "a-z" "A-Z" <"$1"
      +	EOF
     -+	cat >multi2.c <<-\EOF &&
     -+	int two(void) { return 20; }
     ++
     ++	cat >textconv.c <<-\EOF &&
     ++	hello world
     ++	EOF
     ++	git add textconv.c &&
     ++	git commit -m "add textconv.c" &&
     ++
     ++	cat >textconv.c <<-\EOF &&
     ++	goodbye world
      +	EOF
      +
      +	rm -f backend.log &&
     -+	git -c diff.cdiff.process="$BACKEND --log=backend.log" \
     -+		diff -- multi1.c multi2.c >actual &&
     -+	test_grep "return 10" actual &&
     -+	test_grep "return 20" actual &&
     -+	test_grep "pathname=multi1.c" backend.log &&
     -+	test_grep "pathname=multi2.c" backend.log
     ++	git -c diff.cdiff.textconv="./uppercase-filter" \
     ++	    -c diff.cdiff.process="$BACKEND --log=backend.log" \
     ++		diff -- textconv.c >actual 2>stderr &&
     ++	# The diff process receives textconv-transformed (uppercase) content.
     ++	test_grep "pathname=textconv.c" backend.log &&
     ++	test_grep "old=HELLO WORLD" backend.log &&
     ++	test_grep "new=GOODBYE WORLD" backend.log &&
     ++	test_must_be_empty stderr
      +'
      +
     ++#
     ++# Downstream features: word diff, log, equivalent files, exit code.
     ++#
     ++
      +test_expect_success PYTHON 'diff process with --word-diff' '
     -+	cat >worddiff.c <<-\EOF &&
     -+	int value(void) { return 1; }
     ++	rm -f backend.log &&
     ++	git -c diff.cdiff.process="$BACKEND --log=backend.log" \
     ++		diff --word-diff worddiff.c >actual 2>stderr &&
     ++	test_grep "\[-1;-\]" actual &&
     ++	test_grep "{+999;+}" actual &&
     ++	test_grep "pathname=worddiff.c" backend.log &&
     ++	test_must_be_empty stderr
     ++'
     ++
     ++test_expect_success PYTHON 'diff process works with git log -p' '
     ++	# With no-hunks mode, the tool says the files are equivalent,
     ++	# so log -p should show the commit but no diff content.
     ++	rm -f backend.log &&
     ++	git -c diff.cdiff.process="$BACKEND --mode=no-hunks --log=backend.log" \
     ++		log -1 -p -- logtest.c >actual 2>stderr &&
     ++	test_grep "change logtest.c" actual &&
     ++	test_grep ! "return 2" actual &&
     ++	test_grep "command=hunks pathname=logtest.c" backend.log &&
     ++	test_must_be_empty stderr
     ++'
     ++
     ++test_expect_success PYTHON 'diff process no hunks suppresses diff output' '
     ++	cat >nohunks.c <<-\EOF &&
     ++	int zero(void) { return 0; }
      +	EOF
     -+	git add worddiff.c &&
     -+	git commit -m "add worddiff.c" &&
     ++	git add nohunks.c &&
     ++	git commit -m "add nohunks.c" &&
      +
     -+	cat >worddiff.c <<-\EOF &&
     -+	int value(void) { return 999; }
     ++	cat >nohunks.c <<-\EOF &&
     ++	int zero(void) { return 999; }
      +	EOF
      +
     -+	git -c diff.cdiff.process="$BACKEND" \
     -+		diff --word-diff worddiff.c >actual &&
     -+	test_grep "\[-1;-\]" actual &&
     -+	test_grep "{+999;+}" actual
     ++	git -c diff.cdiff.process="$BACKEND --mode=no-hunks" \
     ++		diff nohunks.c >actual &&
     ++	test_must_be_empty actual
     ++'
     ++
     ++test_expect_success PYTHON 'diff process no hunks with --exit-code returns success' '
     ++	git -c diff.cdiff.process="$BACKEND --mode=no-hunks" \
     ++		diff --exit-code nohunks.c
     ++'
     ++
     ++test_expect_success PYTHON 'diff process with --exit-code and hunks returns failure' '
     ++	test_expect_code 1 git -c diff.cdiff.process="$BACKEND" \
     ++		diff --exit-code newfile.c
      +'
      +
     ++#
     ++# Bypass mechanisms: flags and commands that skip the diff process.
     ++#
     ++
      +test_expect_success PYTHON 'diff process bypassed by --diff-algorithm' '
      +	rm -f backend.log &&
      +	git -c diff.cdiff.process="$BACKEND --log=backend.log" \
     @@ t/t4080-diff-process.sh (new)
      +	test_path_is_missing backend.log
      +'
      +
     -+test_expect_success PYTHON 'diff process works with git log -p' '
     -+	cat >logtest.c <<-\EOF &&
     -+	int logfunc(void) { return 1; }
     -+	EOF
     -+	git add logtest.c &&
     -+	git commit -m "add logtest.c" &&
     ++test_expect_success PYTHON 'diff process not used by --stat' '
     ++	rm -f backend.log &&
     ++	git -c diff.cdiff.process="$BACKEND --log=backend.log" \
     ++		diff --stat worddiff.c >actual &&
     ++	test_grep "worddiff.c" actual &&
     ++	test_path_is_missing backend.log
     ++'
      +
     -+	cat >logtest.c <<-\EOF &&
     -+	int logfunc(void) { return 2; }
     -+	EOF
     -+	git add logtest.c &&
     -+	git commit -m "change logtest.c" &&
     ++#
     ++# Error handling and fallback.
     ++#
      +
     ++test_expect_success PYTHON 'diff process fallback on tool error status' '
      +	rm -f backend.log &&
     -+	git -c diff.cdiff.process="$BACKEND --log=backend.log" \
     -+		log -1 -p -- logtest.c >actual &&
     -+	test_grep "return 2" actual &&
     -+	test_grep "command=hunks pathname=logtest.c" backend.log
     ++	git -c diff.cdiff.process="$BACKEND --mode=error --log=backend.log" \
     ++		diff boundary.c >actual 2>stderr &&
     ++	# Fallback produces the full builtin diff (both change regions).
     ++	test_grep "^-OLD5" actual &&
     ++	test_grep "^+NEW5" actual &&
     ++	test_grep "^-OLD9" actual &&
     ++	test_grep "^+NEW9" actual &&
     ++	# Tool was contacted (it replied with error, not crash).
     ++	test_grep "command=hunks pathname=boundary.c" backend.log &&
     ++	test_grep "diff process.*failed" stderr
      +'
      +
     -+test_expect_success PYTHON 'diff process zero hunks suppresses diff output' '
     -+	cat >zerohunk.c <<-\EOF &&
     -+	int zero(void) { return 0; }
     ++test_expect_success PYTHON 'diff process error keeps tool available for next file' '
     ++	rm -f backend.log &&
     ++	git -c diff.cdiff.process="$BACKEND --mode=error --log=backend.log" \
     ++		diff -- one.c two.c >actual 2>stderr &&
     ++	# Unlike abort, error keeps the tool available: both files
     ++	# are sent to the tool (and both fall back).
     ++	test_grep "pathname=one.c" backend.log &&
     ++	test_grep "pathname=two.c" backend.log &&
     ++	test_grep "return 10" actual &&
     ++	test_grep "return 20" actual
     ++'
     ++
     ++test_expect_success PYTHON 'diff process abort disables for session' '
     ++	rm -f backend.log &&
     ++	git -c diff.cdiff.process="$BACKEND --mode=abort --log=backend.log" \
     ++		diff -- one.c two.c >actual &&
     ++	# Both files should still produce diff output via fallback.
     ++	test_grep "return 10" actual &&
     ++	test_grep "return 20" actual &&
     ++	# The tool aborts on the first file and git clears its
     ++	# capability.  The second file never contacts the tool.
     ++	test_grep "pathname=one.c" backend.log &&
     ++	test_grep ! "pathname=two.c" backend.log
     ++'
     ++
     ++test_expect_success PYTHON 'diff process fallback on tool crash' '
     ++	git -c diff.cdiff.process="$BACKEND --mode=crash" \
     ++		diff boundary.c >actual 2>stderr &&
     ++	test_grep "^-OLD5" actual &&
     ++	test_grep "^+NEW5" actual &&
     ++	test_grep "^-OLD9" actual &&
     ++	test_grep "^+NEW9" actual &&
     ++	# Crash is a communication failure, so a warning is emitted.
     ++	test_grep "diff process.*failed" stderr
     ++'
     ++
     ++test_expect_success PYTHON 'diff process startup failure only warns once' '
     ++	git -c diff.cdiff.process="/nonexistent/tool" \
     ++		diff -- one.c two.c >actual 2>stderr &&
     ++	# Both files produce diff output via fallback.
     ++	test_grep "return 10" actual &&
     ++	test_grep "return 20" actual &&
     ++	# Sentinel prevents repeated warnings: only one, not one per file.
     ++	test_grep "diff process.*failed" stderr >warnings &&
     ++	test_line_count = 1 warnings
     ++'
     ++
     ++test_expect_success PYTHON 'diff process fallback on bad hunks' '
     ++	git -c diff.cdiff.process="$BACKEND --mode=bad-hunk" \
     ++		diff boundary.c >actual 2>stderr &&
     ++	test_grep "^-OLD5" actual &&
     ++	test_grep "^+NEW5" actual &&
     ++	test_grep "^-OLD9" actual &&
     ++	test_grep "^+NEW9" actual &&
     ++	# Invalid hunks are caught by xdiff validation, not the
     ++	# protocol layer, so no warning is emitted.
     ++	test_must_be_empty stderr
     ++'
     ++
     ++test_expect_success PYTHON 'diff process fallback on mismatched unchanged totals' '
     ++	cat >synctest.c <<-\EOF &&
     ++	line1
     ++	line2
     ++	line3
      +	EOF
     -+	git add zerohunk.c &&
     -+	git commit -m "add zerohunk.c" &&
     ++	git add synctest.c &&
     ++	git commit -m "add synctest.c" &&
      +
     -+	cat >zerohunk.c <<-\EOF &&
     -+	int zero(void) { return 999; }
     ++	cat >synctest.c <<-\EOF &&
     ++	line1
     ++	changed
     ++	line3
      +	EOF
      +
     -+	git -c diff.cdiff.process="$BACKEND --mode=zero-hunk" \
     -+		diff zerohunk.c >actual &&
     -+	test_must_be_empty actual
     ++	# bad-sync reports hunk 1 2 1 1: marks 2 old lines and 1 new
     ++	# line as changed, leaving 1 unchanged old vs 2 unchanged new.
     ++	# The synchronization invariant fails and git falls back.
     ++	git -c diff.cdiff.process="$BACKEND --mode=bad-sync" \
     ++		diff synctest.c >actual 2>stderr &&
     ++	test_grep "changed" actual
     ++'
     ++
     ++test_expect_success PYTHON 'diff process fallback on overlapping hunks' '
     ++	# boundary.c has 10 lines, so both hunks are in bounds
     ++	# but they overlap at lines 3-5, triggering the ordering check.
     ++	git -c diff.cdiff.process="$BACKEND --mode=overlap" \
     ++		diff boundary.c >actual 2>stderr &&
     ++	test_grep "NEW5" actual
      +'
      +
      +test_done
     +
     + ## userdiff.h ##
     +@@
     + 
     + #include "notes-cache.h"
     + 
     ++struct diff_subprocess;
     + struct index_state;
     + struct repository;
     + 
     +@@ userdiff.h: struct userdiff_driver {
     + 	int textconv_want_cache;
     + 	const char *process;
     + 	char *process_owned;
     ++	struct diff_subprocess *diff_subprocess;
     ++	unsigned diff_process_failed : 1;
     + };
     + enum userdiff_driver_type {
     + 	USERDIFF_DRIVER_TYPE_BUILTIN = 1<<0,
 -:  ---------- > 5:  f4fd9aa682 diff: bypass diff process with --no-ext-diff and in format-patch
 4:  39ff53acef ! 6:  370e766978 blame: consult diff process for zero-hunk detection
     @@ Metadata
      Author: Michael Montalbo <mmontalbo@gmail.com>
      
       ## Commit message ##
     -    blame: consult diff process for zero-hunk detection
     +    blame: consult diff process for no-hunk detection
      
          When a diff process is configured via diff.<driver>.process,
          consult it during blame's per-commit diffing.  If the process
     -    returns zero hunks for a commit's changes to a file, treat the
     +    returns no hunks for a commit's changes to a file, treat the
          commit as having no changes, causing blame to attribute lines
          to earlier commits.
      
     +    The consultation happens at the pass_blame_to_parent() callsite
     +    using diff_process_fill_hunks(), matching how builtin_diff() in
     +    diff.c uses the same function.  A new diff_hunks_xpp() variant
     +    accepts a pre-populated xpparam_t for this callsite, while the
     +    existing diff_hunks() retains its original signature and behavior.
     +    The copy-detection callsite is unaffected since it does not use
     +    the diff process.
     +
          The subprocess is long-running (one startup cost amortized
          across the blame traversal), but each commit in the file's
          history incurs a round-trip to the tool.
      
          Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
      
     - ## Documentation/gitattributes.adoc ##
     -@@ Documentation/gitattributes.adoc: The tool responds with lines of the form
     - 
     - If the tool returns zero hunks with `status=success`, Git treats
     - the file as having no changes and produces no diff output.
     -+`git blame` also consults the diff process and skips commits
     -+where it reports zero hunks, attributing lines to earlier commits
     -+instead.
     - 
     - Tools should ignore unknown keys in the per-file request to
     - remain forward-compatible.
     -
       ## blame.c ##
      @@
       #include "tag.h"
       #include "trace2.h"
       #include "blame.h"
      +#include "diff-process.h"
     -+#include "userdiff.h"
     ++#include "xdiff-interface.h"
       #include "alloc.h"
       #include "commit-slab.h"
       #include "bloom.h"
      @@ blame.c: static struct commit *fake_working_tree_commit(struct repository *r,
       
       
     - static int diff_hunks(mmfile_t *file_a, mmfile_t *file_b,
     + 
     +-static int diff_hunks(mmfile_t *file_a, mmfile_t *file_b,
      -		      xdl_emit_hunk_consume_func_t hunk_func, void *cb_data, int xdl_opts)
     -+		      xdl_emit_hunk_consume_func_t hunk_func, void *cb_data,
     -+		      int xdl_opts, struct index_state *istate,
     -+		      const char *path)
     ++static int diff_hunks_xpp(mmfile_t *file_a, mmfile_t *file_b,
     ++			  xdl_emit_hunk_consume_func_t hunk_func,
     ++			  void *cb_data, xpparam_t *xpp)
       {
     - 	xpparam_t xpp = {0};
     +-	xpparam_t xpp = {0};
       	xdemitconf_t xecfg = {0};
       	xdemitcb_t ecb = {NULL};
     -+	struct xdl_hunk *ext_hunks = NULL;
     -+	int ret;
       
     - 	xpp.flags = xdl_opts;
     +-	xpp.flags = xdl_opts;
       	xecfg.hunk_func = hunk_func;
       	ecb.priv = cb_data;
      -	return xdi_diff(file_a, file_b, &xpp, &xecfg, &ecb);
     ++	return xdi_diff(file_a, file_b, xpp, &xecfg, &ecb);
     ++}
      +
     -+	if (path && istate) {
     -+		struct userdiff_driver *drv;
     -+		drv = userdiff_find_by_path(istate, path);
     -+		if (drv && drv->process) {
     -+			size_t nr = 0;
     -+			if (!diff_process_get_hunks(drv, path,
     -+						    file_a->ptr, file_a->size,
     -+						    file_b->ptr, file_b->size,
     -+						    &ext_hunks, &nr)) {
     -+				if (!nr) {
     -+					/*
     -+					 * Zero hunks: the diff process
     -+					 * considers these files equivalent.
     -+					 * Skip so blame looks past this
     -+					 * commit.
     -+					 */
     -+					return 0;
     -+				}
     -+				xpp.external_hunks = ext_hunks;
     -+				xpp.external_hunks_nr = nr;
     -+			}
     -+		}
     -+	}
     ++static int diff_hunks(mmfile_t *file_a, mmfile_t *file_b,
     ++		      xdl_emit_hunk_consume_func_t hunk_func, void *cb_data, int xdl_opts)
     ++{
     ++	xpparam_t xpp = {0};
      +
     -+	ret = xdi_diff(file_a, file_b, &xpp, &xecfg, &ecb);
     -+	free(ext_hunks);
     -+	return ret;
     ++	xpp.flags = xdl_opts;
     ++	return diff_hunks_xpp(file_a, file_b, hunk_func, cb_data, &xpp);
       }
       
       static const char *get_next_line(const char *start, const char *end)
     +@@ blame.c: static void pass_blame_to_parent(struct blame_scoreboard *sb,
     + 				 struct blame_origin *parent, int ignore_diffs)
     + {
     + 	mmfile_t file_p, file_o;
     ++	xpparam_t xpp = {0};
     + 	struct blame_chunk_cb_data d;
     + 	struct blame_entry *newdest = NULL;
     + 
      @@ blame.c: static void pass_blame_to_parent(struct blame_scoreboard *sb,
       			 &sb->num_read_blob, ignore_diffs);
       	sb->num_get_patch++;
       
      -	if (diff_hunks(&file_p, &file_o, blame_chunk_cb, &d, sb->xdl_opts))
     -+	if (diff_hunks(&file_p, &file_o, blame_chunk_cb, &d, sb->xdl_opts,
     -+		       sb->revs->diffopt.repo->index, target->path))
     - 		die("unable to generate diff (%s -> %s)",
     - 		    oid_to_hex(&parent->commit->object.oid),
     - 		    oid_to_hex(&target->commit->object.oid));
     -@@ blame.c: static void find_copy_in_blob(struct blame_scoreboard *sb,
     - 	 * file_p partially may match that image.
     - 	 */
     - 	memset(split, 0, sizeof(struct blame_entry [3]));
     --	if (diff_hunks(file_p, &file_o, handle_split_cb, &d, sb->xdl_opts))
     -+	if (diff_hunks(file_p, &file_o, handle_split_cb, &d, sb->xdl_opts,
     -+		       NULL, NULL))
     - 		die("unable to generate diff (%s)",
     - 		    oid_to_hex(&parent->commit->object.oid));
     - 	/* remainder, if any, all match the preimage */
     +-		die("unable to generate diff (%s -> %s)",
     +-		    oid_to_hex(&parent->commit->object.oid),
     +-		    oid_to_hex(&target->commit->object.oid));
     ++	xpp.flags = sb->xdl_opts;
     ++	/*
     ++	 * If the diff process considers the files equivalent,
     ++	 * skip the diff so blame looks past this commit.
     ++	 */
     ++	if (diff_process_fill_hunks(&sb->revs->diffopt, target->path,
     ++				    &file_p, &file_o, &xpp)
     ++	    != DIFF_PROCESS_EQUIVALENT) {
     ++		if (diff_hunks_xpp(&file_p, &file_o, blame_chunk_cb,
     ++				   &d, &xpp))
     ++			die("unable to generate diff (%s -> %s)",
     ++			    oid_to_hex(&parent->commit->object.oid),
     ++			    oid_to_hex(&target->commit->object.oid));
     ++	}
     ++	free(xpp.external_hunks);
     + 	/* The rest are the same as the parent */
     + 	blame_chunk(&d.dstq, &d.srcq, INT_MAX, d.offset, INT_MAX, 0,
     + 		    parent, target, 0);
      
       ## t/t4080-diff-process.sh ##
     -@@ t/t4080-diff-process.sh: test_expect_success PYTHON 'diff process zero hunks suppresses diff output' '
     - 	test_must_be_empty actual
     +@@ t/t4080-diff-process.sh: test_expect_success PYTHON 'diff process fallback on overlapping hunks' '
     + 	test_grep "NEW5" actual
       '
       
     -+test_expect_success PYTHON 'blame skips commits with zero hunks from diff process' '
     ++#
     ++# Blame integration.
     ++#
     ++
     ++test_expect_success PYTHON 'blame uses tool-provided hunks' '
     ++	cat >blame-hunk.c <<-\EOF &&
     ++	line1
     ++	line2
     ++	line3
     ++	line4
     ++	original5
     ++	original6
     ++	line7
     ++	line8
     ++	line9
     ++	line10
     ++	EOF
     ++	git add blame-hunk.c &&
     ++	git commit -m "add blame-hunk.c" &&
     ++	ORIG=$(git rev-parse --short HEAD) &&
     ++
     ++	cat >blame-hunk.c <<-\EOF &&
     ++	line1
     ++	line2
     ++	line3
     ++	line4
     ++	changed5
     ++	changed6
     ++	line7
     ++	line8
     ++	changed9
     ++	changed10
     ++	EOF
     ++	git add blame-hunk.c &&
     ++	git commit -m "change blame-hunk.c" &&
     ++	CHANGE=$(git rev-parse --short HEAD) &&
     ++
     ++	# With fixed-hunk mode the tool reports only lines 5-6 as changed,
     ++	# so blame should attribute lines 9-10 to the original commit
     ++	# even though the builtin diff would show them as changed.
     ++	git -c diff.cdiff.process="$BACKEND --mode=fixed-hunk" \
     ++		blame blame-hunk.c >actual &&
     ++	sed -n "9p" actual >line9 &&
     ++	sed -n "10p" actual >line10 &&
     ++	test_grep "$ORIG" line9 &&
     ++	test_grep "$ORIG" line10 &&
     ++	sed -n "5p" actual >line5 &&
     ++	sed -n "6p" actual >line6 &&
     ++	test_grep "$CHANGE" line5 &&
     ++	test_grep "$CHANGE" line6
     ++'
     ++
     ++test_expect_success PYTHON 'blame skips commits with no hunks from diff process' '
      +	cat >blame.c <<-\EOF &&
      +	int main(void)
      +	{
     @@ t/t4080-diff-process.sh: test_expect_success PYTHON 'diff process zero hunks sup
      +	EOF
      +	git add blame.c &&
      +	git commit -m "add blame.c" &&
     ++	ORIG_COMMIT=$(git rev-parse --short HEAD) &&
      +
      +	cat >blame.c <<-\EOF &&
      +	int main(void)
     @@ t/t4080-diff-process.sh: test_expect_success PYTHON 'diff process zero hunks sup
      +	git commit -m "reformat blame.c" &&
      +	BLAME_COMMIT=$(git rev-parse --short HEAD) &&
      +
     -+	# Without zero-hunk mode, blame attributes the change.
     ++	# Without no-hunks mode, blame attributes the change.
      +	git blame blame.c >without &&
      +	test_grep "$BLAME_COMMIT" without &&
      +
     -+	# With zero-hunk mode, the process considers the files equivalent
     -+	# and blame skips the reformat commit.
     -+	git -c diff.cdiff.process="$BACKEND --mode=zero-hunk" \
     ++	# With no-hunks mode, the process considers the files equivalent
     ++	# and blame skips the reformat commit, attributing to the original.
     ++	git -c diff.cdiff.process="$BACKEND --mode=no-hunks" \
      +		blame blame.c >with &&
     -+	! test_grep "$BLAME_COMMIT" with
     ++	test_grep ! "$BLAME_COMMIT" with &&
     ++	test_grep "$ORIG_COMMIT" with
      +'
      +
     ++test_expect_success PYTHON 'blame --no-ext-diff bypasses diff process' '
     ++	rm -f backend.log &&
     ++	git -c diff.cdiff.process="$BACKEND --mode=no-hunks --log=backend.log" \
     ++		blame --no-ext-diff blame.c >actual &&
     ++	# Without the process, blame attributes the reformat commit normally.
     ++	test_grep "$BLAME_COMMIT" actual &&
     ++	test_path_is_missing backend.log
     ++'
     ++
     ++test_expect_success PYTHON 'blame --no-ext-diff uses builtin hunks' '
     ++	# fixed-hunk mode would narrow blame to lines 5-6, but
     ++	# --no-ext-diff should bypass it and use the builtin diff.
     ++	rm -f backend.log &&
     ++	git -c diff.cdiff.process="$BACKEND --mode=fixed-hunk --log=backend.log" \
     ++		blame --no-ext-diff blame-hunk.c >actual &&
     ++	# Builtin diff attributes lines 9-10 to the change commit.
     ++	sed -n "9p" actual >line9 &&
     ++	test_grep "$CHANGE" line9 &&
     ++	test_path_is_missing backend.log
     ++'
      +
       test_done

-- 
gitgitgadget
