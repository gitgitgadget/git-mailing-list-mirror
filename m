Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395913EAC7A
	for <git@vger.kernel.org>; Mon, 25 May 2026 18:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779733804; cv=none; b=YgA/Y46Gt/kRNbtXrO7vAZa9q0+WKGXUaTBqi7JzR3RpDD5I9YgDs3EYGArbg7U/lTQCusS1fAQMwfPtT5uGQLboxypTxKxn2Qy1SuFaoKlLBE+i1OwtTuw0i1B8GeVvH18tTgPeU3tnpGfjEdwC8uC/uorJD7LJVI+ty6OZOCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779733804; c=relaxed/simple;
	bh=nEMqbwaF5sYtvs9qPRJCx3iYy29GYFSLeL4h4BLXFcg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Hip1uoFHr+/V8vj+fQFkqvlJznKopsJqxagGDNIBVY7gEaFocAfjddEvTcbq2CoE221YrGeN6zAVWTtOEuYXfQ1vaxdGUMsPQWAcYHvIFYOGoA7HnnTtucpNUjQMbF4Lwf7eAc8iY2sB2b9u/6f/cVwzCXKXrrbF1HesPwoNavo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kd+fKs7z; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kd+fKs7z"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-516d634956fso39856071cf.2
        for <git@vger.kernel.org>; Mon, 25 May 2026 11:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779733801; x=1780338601; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oykUz/Xb3ARpRlxEXPqDEER88k4Xju6XapuPVndktz0=;
        b=kd+fKs7z84KvyKjL0Wmwscl+DLwFugNBglXGgbyiGDiqZzOxdHrKn4ck0uJk9q6x/2
         4fCyATFlms622FnoZ7B4yFq/uBZbuPOgBNBO97ODUTXrC21UbrlBePuKXw3WpjwwCRm3
         tuSjfl0HpHjaTdb7BRzFq2XiY5MPRLzwlkje3PSJ02LaDryS1ICHJEDT1Pg6khX3uNUc
         ysV7/WdIQWRpsUx28CZ1R108sz18zAbZ9jwgVNbDL9ExinFO1noZo3d4ewkrYBy2ZL0M
         JHpoKUMI17dVQFojCjQLajJ60o+XGQflFquZaH9snGnZa524I9uYXCfIgWevnu10xlnI
         eIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779733801; x=1780338601;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oykUz/Xb3ARpRlxEXPqDEER88k4Xju6XapuPVndktz0=;
        b=CqMoBndvc8//3eKw46WIettGXeRL3xdWKeoyi0N9PvTKUAzeNH1H3/W2VAwQOwHQbp
         0+e0eCOjtx9GJSkWRQjn80vaHGDLt2IexHKmL51ZPGmlzzMzPiGun7asXRBLw9EFzS+H
         R5HyHhdetjs04Bqq/X6/paEUD1aBwYxq7pZDRuBdC1191bFqeT6NmL+ieLcYfyXROCc7
         1q0+f7Qgg+BKucG8H+e1Spt5+F55mGYFiacU5K5hYunZ3m0PNphzK+4viQSeCBCrn8Il
         bkRiAm5LlbKCgW3pBgP94cGH4pgFWly+323+Q2tDa1cBgl5ia9D/GhPpI6WFGaf3uBaE
         goJQ==
X-Gm-Message-State: AOJu0YxjfeEf4Gzm6LJWrLL8ED7CkFkl/c8LIxl+dDHbdQZmruMm2PJX
	dHX/1HChOF7Ge5cz0KwB8g3n6DnJ6snAhN47OCVZwW8Ukd/7ap3XZ+oqErSJNLjC
X-Gm-Gg: Acq92OGQ+91IXeWqNwRL0QOl3n2mBzCHhgLsFc1k7G0KJgOo7LFCd2XZwk5eeGTElNQ
	Kqq6LNcsbtWL2oW8Yk7M1uTdN1njggMIHB9WFIWlZ1x6An8WIl/ukZmYAFHXh/TH25fC3Ru2KCO
	aJz8FNiCZXpmwLICN1lhrdG03Bi1vRXi+TGZxArqpshE2gVl/72vnZxdcF049z80GojBjSQmLZt
	r1ly/6KBYkzvGczR5UTLkGSWAijuhma0mWaQCBarOcT6DgXHPCHo4yyM5DRmw1QR2+kPKhqvoUt
	Be9nD/6FdO/IZxE83FMVMjmiWgn1CEBXFGKkAIljyCvKUsPIgWauFWxQbgYKwsGjDN0iGnNd3/z
	IFUSCR2FoZWHqqzDR00fi4XUDGgZhRpYvnNYYssrCaWzT2eEq6Oip4Mu9kG9r+QaAjt3RFi+BWO
	L/v7BHdMKEttp2YLEx/eENiYlbRVOF78y6k5eDlw==
X-Received: by 2002:a05:622a:250a:b0:516:d73d:2a34 with SMTP id d75a77b69052e-516d73d2da4mr222871881cf.5.1779733800905;
        Mon, 25 May 2026 11:30:00 -0700 (PDT)
Received: from [127.0.0.1] ([48.217.180.136])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8d07bdbsm95915211cf.27.2026.05.25.11.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 11:30:00 -0700 (PDT)
Message-Id: <pull.2120.v2.git.1779733799.gitgitgadget@gmail.com>
In-Reply-To: <pull.2120.git.1779415884.gitgitgadget@gmail.com>
References: <pull.2120.git.1779415884.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 25 May 2026 18:29:54 +0000
Subject: [PATCH v2 0/4] [RFC] diff: add diff.<driver>.process for external hunk providers
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

This series adds diff.<driver>.process, a long-running subprocess protocol
that lets external tools provide hunks into git's diff and blame pipelines.

diff.<driver>.process opens the door to integrating content-aware logic that
don't exist inside git: structural diff tools, format-aware analyzers, and
other tools that understand the semantics of the content being tracked.
Where diff.<driver>.command replaces the diff pipeline entirely,
diff.<driver>.process feeds hunks into it, so all downstream features (word
diff, function context, color-moved, stat, blame) work normally.

The protocol follows filter.<driver>.process: pkt-line over stdin/stdout,
capability negotiation, one tool invocation per git command. The tool
receives file pairs and returns hunk descriptors that git feeds into the
standard xdiff pipeline.

Zero hunks with status=success means the tool considers the files
equivalent. git diff shows no output for the file, and git blame skips the
commit, attributing lines to earlier commits.

On error or tool crash, git falls back silently to the builtin diff
algorithm. The feature is opt-in via diff.<driver>.process and
.gitattributes; unconfigured files are unaffected.

The blame integration calls the diff process for each commit in the file's
history. The subprocess is long-running (one startup amortized across the
traversal), but per-commit round-trips add latency. A natural follow-up
would be a capability that sends blob OIDs instead of content, allowing
tools that can read the object store directly to avoid the cost of
serializing and deserializing blob content over the pipe for each file pair.

Changes since v1:

 * Dropped the built-in diff-process-normalize tool since it obscured the
   main use case for the RFC and update series messaging accordingly.
 * Encapsulated changed[] memory layout behind xdl_clear_changed() helper in
   xprepare.c.
 * Restructured the external hunks path in xdl_diff() to fall through to the
   regular diff algorithm on validation failure instead of duplicating diff
   logic on fallback then returning.
 * Changed subprocess error reporting from trace to warning.
 * Fixed whitespace issues in the test's embedded Python.
 * Changed instances of grep to test_grep in tests.

Michael Montalbo (4):
  xdiff: support external hunks via xpparam_t
  userdiff: add diff.<driver>.process config
  diff: add long-running diff process via diff.<driver>.process
  blame: consult diff process for zero-hunk detection

 Documentation/config/diff.adoc   |   8 +
 Documentation/gitattributes.adoc |  43 ++++
 Makefile                         |   1 +
 blame.c                          |  43 +++-
 diff-process.c                   | 206 +++++++++++++++++
 diff-process.h                   |  28 +++
 diff.c                           |  23 ++
 t/.gitattributes                 |   1 +
 t/t4080-diff-process.sh          | 370 +++++++++++++++++++++++++++++++
 userdiff.c                       |   7 +
 userdiff.h                       |   2 +
 xdiff-interface.c                |   7 +-
 xdiff/xdiff.h                    |  13 ++
 xdiff/xdiffi.c                   |  84 ++++++-
 xdiff/xprepare.c                 |  10 +
 xdiff/xprepare.h                 |   1 +
 16 files changed, 840 insertions(+), 7 deletions(-)
 create mode 100644 diff-process.c
 create mode 100644 diff-process.h
 create mode 100755 t/t4080-diff-process.sh


base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2120%2Fmmontalbo%2Fmm%2Fstructural-diff-backend-clean-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2120/mmontalbo/mm/structural-diff-backend-clean-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2120

Range-diff vs v1:

 1:  8c0ea0bc07 ! 1:  f887a7e2ba xdiff: support external hunks via xpparam_t
     @@ xdiff/xdiffi.c: static void xdl_mark_ignorable_regex(xdchange_t *xscr, const xdf
      +	long j, prev_old_end = 0, prev_new_end = 0;
      +	long total_old = 0, total_new = 0;
      +
     -+	/*
     -+	 * Clear changed[] arrays.  xdl_prepare_env() may have dirtied
     -+	 * them via xdl_cleanup_records().  The allocation is nrec + 2
     -+	 * elements; changed points one past the start (see xprepare.c).
     -+	 */
     -+	memset(xe->xdf1.changed - 1, 0,
     -+	       (xe->xdf1.nrec + 2) * sizeof(bool));
     -+	memset(xe->xdf2.changed - 1, 0,
     -+	       (xe->xdf2.nrec + 2) * sizeof(bool));
     ++	xdl_clear_changed(&xe->xdf1);
     ++	xdl_clear_changed(&xe->xdf2);
      +
      +	for (i = 0; i < nr_hunks; i++) {
      +		const struct xdl_hunk *h = &hunks[i];
     @@ xdiff/xdiffi.c: static void xdl_mark_ignorable_regex(xdchange_t *xscr, const xdf
      +		/* Bounds check (1-based line numbers) */
      +		if (h->old_count > 0 &&
      +		    (h->old_start < 1 ||
     -+		     h->old_start + h->old_count - 1 > xe->xdf1.nrec))
     ++		     h->old_start + h->old_count - 1 > (long)xe->xdf1.nrec))
      +			return -1;
      +		if (h->new_count > 0 &&
      +		    (h->new_start < 1 ||
     -+		     h->new_start + h->new_count - 1 > xe->xdf2.nrec))
     ++		     h->new_start + h->new_count - 1 > (long)xe->xdf2.nrec))
      +			return -1;
      +
      +		/* Zero-count hunks: start must still be in [1, nrec+1] */
      +		if (h->old_count == 0 &&
     -+		    (h->old_start < 1 || h->old_start > xe->xdf1.nrec + 1))
     ++		    (h->old_start < 1 || h->old_start > (long)xe->xdf1.nrec + 1))
      +			return -1;
      +		if (h->new_count == 0 &&
     -+		    (h->new_start < 1 || h->new_start > xe->xdf2.nrec + 1))
     ++		    (h->new_start < 1 || h->new_start > (long)xe->xdf2.nrec + 1))
      +			return -1;
      +
      +		/* Ordering: no overlap with previous hunk */
     @@ xdiff/xdiffi.c: static void xdl_mark_ignorable_regex(xdchange_t *xscr, const xdf
       	emit_func_t ef = xecfg->hunk_func ? xdl_call_hunk_func : xdl_emit_diff;
       
      -	if (xdl_do_diff(mf1, mf2, xpp, &xe) < 0) {
     --
     --		return -1;
      +	if (xpp->external_hunks) {
      +		if (xdl_prepare_env(mf1, mf2, xpp, &xe) < 0)
      +			return -1;
      +		if (xdl_populate_hunks_from_external(&xe,
      +						     xpp->external_hunks,
     -+						     xpp->external_hunks_nr) < 0) {
     -+			/*
     -+			 * Invalid external hunks; fall back to the
     -+			 * builtin diff algorithm.  Re-runs
     -+			 * xdl_prepare_env() via xdl_do_diff().
     -+			 */
     -+			xdl_free_env(&xe);
     -+			if (xdl_do_diff(mf1, mf2, xpp, &xe) < 0)
     -+				return -1;
     -+		}
     -+	} else {
     -+		if (xdl_do_diff(mf1, mf2, xpp, &xe) < 0)
     -+			return -1;
     - 	}
     ++						     xpp->external_hunks_nr) == 0)
     ++			goto diff_done;
     ++		xdl_free_env(&xe);
     ++	}
     + 
     ++	if (xdl_do_diff(mf1, mf2, xpp, &xe) < 0)
     + 		return -1;
     +-	}
     ++
     ++diff_done:
      +
       	if (xdl_change_compact(&xe.xdf1, &xe.xdf2, xpp->flags) < 0 ||
       	    xdl_change_compact(&xe.xdf2, &xe.xdf1, xpp->flags) < 0 ||
       	    xdl_build_script(&xe, &xscr) < 0) {
     +
     + ## xdiff/xprepare.c ##
     +@@ xdiff/xprepare.c: int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
     + 
     + 	return 0;
     + }
     ++
     ++/*
     ++ * Reset the changed[] array so that no lines are marked as changed.
     ++ * Also clears the sentinel slots at changed[-1] and changed[nrec]
     ++ * that xdl_change_compact() relies on during backward scans.
     ++ */
     ++void xdl_clear_changed(xdfile_t *xdf)
     ++{
     ++	memset(xdf->changed - 1, 0, (xdf->nrec + 2) * sizeof(bool));
     ++}
     +
     + ## xdiff/xprepare.h ##
     +@@
     + int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
     + 		    xdfenv_t *xe);
     + void xdl_free_env(xdfenv_t *xe);
     ++void xdl_clear_changed(xdfile_t *xdf);
     + 
     + 
     + 
 2:  3bc127c800 = 2:  de6d85f9d7 userdiff: add diff.<driver>.process config
 3:  f9976fc6aa ! 3:  c25647c6e5 diff: add long-running diff process via diff.<driver>.process
     @@ Commit message
              [diff "cdiff"]
                  process = /path/to/diff-tool
      
     -    The tool receives file pairs and returns hunks describing which
     -    lines changed.  Git feeds these hunks into the standard xdiff
     -    pipeline, so all output features (word diff, function context,
     -    color) work normally.
     +    The tool provides custom line-matching: it receives file pairs
     +    and returns hunks that reference original line numbers.  Unlike
     +    textconv, which transforms the displayed content, the diff
     +    output shows the actual file while the tool controls which
     +    lines are marked as changed.
      
          The handshake negotiates version=1 and capability=hunks.  Per-file
          requests send command=hunks, pathname, and both file contents as
          packetized data.  The tool responds with hunk lines and a status
     -    packet.  On error, git falls back to the builtin diff algorithm.
     +    packet.  On error, git falls back to the builtin diff algorithm
     +    with a warning.
      
     -    Zero hunks with status=success means the tool considers the files
     -    equivalent.  Git skips diff output for that file entirely.
     +    Zero hunks with status=success means the tool considers the
     +    files equivalent.  Git skips diff output for that file.
      
          Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
      
     @@ Documentation/gitattributes.adoc: NOTE: If `diff.<name>.command` is defined for
      +An external tool can provide content-aware line matching by
      +setting `diff.<name>.process` to the command that runs
      +the tool.  The tool is a long-running process that communicates via
     -+the pkt-line protocol (see
     -+linkgit:gitprotocol-long-running-process[5]).
     ++the pkt-line protocol (described in
     ++Documentation/technical/long-running-process-protocol.adoc).
      +
      +------------------------
      +*.c diff=cdiff
     @@ diff-process.c (new)
      @@
      +/*
      + * Diff process backend: communicates with a long-running external
     -+ * tool via the pkt-line protocol to obtain content-aware hunks.
     ++ * tool via the pkt-line protocol to obtain custom line-matching
     ++ * results.  Unlike textconv, which transforms the displayed content,
     ++ * hunks from a diff process reference original line numbers and
     ++ * the display shows the actual file content.
      + *
      + * Protocol: pkt-line over stdin/stdout, following the pattern of
      + * the long-running filter process protocol (see convert.c).
     @@ diff.c
       #include "userdiff.h"
      +#include "diff-process.h"
       #include "submodule.h"
     -+#include "trace2.h"
       #include "hashmap.h"
       #include "mem-pool.h"
     - #include "merge-ll.h"
      @@ diff.c: static void builtin_diff(const char *name_a,
       		xpparam_t xpp;
       		xdemitconf_t xecfg;
     @@ diff.c: static void builtin_diff(const char *name_a,
      +				xpp.external_hunks = ext_hunks;
      +				xpp.external_hunks_nr = ext_hunks_nr;
      +			} else {
     -+				trace2_data_string("diff",
     -+						   o->repo,
     -+						   "diff-process-fallback",
     -+						   name_a);
     ++				warning(_("diff process failed for '%s',"
     ++					  " falling back to builtin diff"),
     ++					name_a);
      +			}
      +		}
      +
     @@ diff.c: static void builtin_diff(const char *name_a,
       			free_diff_words_data(&ecbdata);
       		if (textconv_one)
      
     + ## t/.gitattributes ##
     +@@ t/.gitattributes: t[0-9][0-9][0-9][0-9]/* -whitespace
     + /t8005/*.txt eol=lf
     + /t9*/*.dump eol=lf
     + /t0040*.sh whitespace=-indent-with-non-tab
     ++/t4080-diff-process.sh whitespace=-indent-with-non-tab
     +
       ## t/t4080-diff-process.sh (new) ##
      @@
      +#!/bin/sh
     @@ t/t4080-diff-process.sh (new)
      +	# appear as changed in the output.
      +	git -c diff.cdiff.process="$BACKEND --mode=fixed-hunk" \
      +		diff boundary.c >actual &&
     -+	grep "^-OLD5" actual &&
     -+	grep "^-OLD6" actual &&
     -+	grep "^+NEW5" actual &&
     -+	grep "^+NEW6" actual &&
     -+	! grep "^-OLD9" actual &&
     -+	! grep "^-OLD10" actual &&
     -+	! grep "^+NEW9" actual &&
     -+	! grep "^+NEW10" actual
     ++	test_grep "^-OLD5" actual &&
     ++	test_grep "^-OLD6" actual &&
     ++	test_grep "^+NEW5" actual &&
     ++	test_grep "^+NEW6" actual &&
     ++	! test_grep "^-OLD9" actual &&
     ++	! test_grep "^-OLD10" actual &&
     ++	! test_grep "^+NEW9" actual &&
     ++	! test_grep "^+NEW10" actual
      +'
      +
      +test_expect_success PYTHON 'diff process fallback on tool error status' '
     @@ t/t4080-diff-process.sh (new)
      +	git -c diff.cdiff.process="$BACKEND --mode=error --log=backend.log" \
      +		diff boundary.c >actual &&
      +	# Fallback produces the full builtin diff (both change regions).
     -+	grep "^-OLD5" actual &&
     -+	grep "^+NEW5" actual &&
     -+	grep "^-OLD9" actual &&
     -+	grep "^+NEW9" actual &&
     ++	test_grep "^-OLD5" actual &&
     ++	test_grep "^+NEW5" actual &&
     ++	test_grep "^-OLD9" actual &&
     ++	test_grep "^+NEW9" actual &&
      +	# Tool was contacted (it replied with error, not crash).
     -+	grep "command=hunks pathname=boundary.c" backend.log
     ++	test_grep "command=hunks pathname=boundary.c" backend.log
      +'
      +
      +test_expect_success PYTHON 'diff process fallback on bad hunks' '
      +	git -c diff.cdiff.process="$BACKEND --mode=bad-hunk" \
      +		diff boundary.c >actual &&
     -+	grep "^-OLD5" actual &&
     -+	grep "^+NEW5" actual &&
     -+	grep "^-OLD9" actual &&
     -+	grep "^+NEW9" actual
     ++	test_grep "^-OLD5" actual &&
     ++	test_grep "^+NEW5" actual &&
     ++	test_grep "^-OLD9" actual &&
     ++	test_grep "^+NEW9" actual
      +'
      +
      +test_expect_success PYTHON 'diff process fallback on tool crash' '
      +	git -c diff.cdiff.process="$BACKEND --mode=crash" \
      +		diff boundary.c >actual &&
     -+	grep "^-OLD5" actual &&
     -+	grep "^+NEW5" actual &&
     -+	grep "^-OLD9" actual &&
     -+	grep "^+NEW9" actual
     ++	test_grep "^-OLD5" actual &&
     ++	test_grep "^+NEW5" actual &&
     ++	test_grep "^-OLD9" actual &&
     ++	test_grep "^+NEW9" actual
      +'
      +
      +test_expect_success PYTHON 'diff process abort disables for session' '
     @@ t/t4080-diff-process.sh (new)
      +	git -c diff.cdiff.process="$BACKEND --mode=abort --log=backend.log" \
      +		diff -- abort1.c abort2.c >actual &&
      +	# Both files should still produce diff output via fallback.
     -+	grep "return 10" actual &&
     -+	grep "return 20" actual &&
     ++	test_grep "return 10" actual &&
     ++	test_grep "return 20" actual &&
      +	# The tool aborts on the first file and git clears its
      +	# capability.  The second file never contacts the tool,
      +	# so the log should have exactly one entry, not two.
     -+	grep "command=hunks" backend.log >matches &&
     ++	test_grep "command=hunks" backend.log >matches &&
      +	test_line_count = 1 matches
      +'
      +
     @@ t/t4080-diff-process.sh (new)
      +	rm -f backend.log &&
      +	git -c diff.cdiff.process="$BACKEND --log=backend.log" \
      +		diff -- multi1.c multi2.c >actual &&
     -+	grep "return 10" actual &&
     -+	grep "return 20" actual &&
     -+	grep "pathname=multi1.c" backend.log &&
     -+	grep "pathname=multi2.c" backend.log
     ++	test_grep "return 10" actual &&
     ++	test_grep "return 20" actual &&
     ++	test_grep "pathname=multi1.c" backend.log &&
     ++	test_grep "pathname=multi2.c" backend.log
      +'
      +
      +test_expect_success PYTHON 'diff process with --word-diff' '
     @@ t/t4080-diff-process.sh (new)
      +
      +	git -c diff.cdiff.process="$BACKEND" \
      +		diff --word-diff worddiff.c >actual &&
     -+	grep "\[-1;-\]" actual &&
     -+	grep "{+999;+}" actual
     ++	test_grep "\[-1;-\]" actual &&
     ++	test_grep "{+999;+}" actual
      +'
      +
      +test_expect_success PYTHON 'diff process bypassed by --diff-algorithm' '
      +	rm -f backend.log &&
      +	git -c diff.cdiff.process="$BACKEND --log=backend.log" \
      +		diff --diff-algorithm=patience worddiff.c >actual &&
     -+	grep "return 999" actual &&
     ++	test_grep "return 999" actual &&
      +	test_path_is_missing backend.log
      +'
      +
     @@ t/t4080-diff-process.sh (new)
      +	rm -f backend.log &&
      +	git -c diff.cdiff.process="$BACKEND --log=backend.log" \
      +		log -1 -p -- logtest.c >actual &&
     -+	grep "return 2" actual &&
     -+	grep "command=hunks pathname=logtest.c" backend.log
     ++	test_grep "return 2" actual &&
     ++	test_grep "command=hunks pathname=logtest.c" backend.log
      +'
      +
      +test_expect_success PYTHON 'diff process zero hunks suppresses diff output' '
 4:  4e6ea6d518 ! 4:  39ff53acef blame: consult diff process for zero-hunk detection
     @@ t/t4080-diff-process.sh: test_expect_success PYTHON 'diff process zero hunks sup
      +
      +	# Without zero-hunk mode, blame attributes the change.
      +	git blame blame.c >without &&
     -+	grep "$BLAME_COMMIT" without &&
     ++	test_grep "$BLAME_COMMIT" without &&
      +
      +	# With zero-hunk mode, the process considers the files equivalent
      +	# and blame skips the reformat commit.
      +	git -c diff.cdiff.process="$BACKEND --mode=zero-hunk" \
      +		blame blame.c >with &&
     -+	! grep "$BLAME_COMMIT" with
     ++	! test_grep "$BLAME_COMMIT" with
      +'
      +
      +
 5:  8c7359b8a1 < -:  ---------- diff-process-normalize: add built-in whitespace normalizer

-- 
gitgitgadget
