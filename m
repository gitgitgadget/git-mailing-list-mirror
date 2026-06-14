Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100C12E2850
	for <git@vger.kernel.org>; Sun, 14 Jun 2026 18:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781463569; cv=none; b=bW5tIwXuvMrInLq3sU9I/JklCC4N64/XGqOmJzm0NLtbBejoMSeFzEGXDvJ2SqY7Lm8j6NM4HdXS6rOMWVQD/OMYSF3xA9Td3ZP2CAlqA8kp9sLY4tdcZE0XnCqNuDa9KRJ380NRAvJiYuy2e76aDabvidCQ/M1bKyojKfiR6io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781463569; c=relaxed/simple;
	bh=tduQLb9MXHPBuqEcPToQDNib+ulxLqh+LQd9IgHNX/0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QjE3k8m8Sem+cP4m49atTlNhfpPcVUKQXQwf+4A9QxfW3yk5Cnuit8fI3Od2S/MJlm+oiXBrvsqfwePc+8etNAD4OGVh75YaGeiNSUn1Y7GTHoqBFCX18Is8e1lJ6QciKgpuEKvNAljxRuX1BMbKR1Ee0shT0rdexa9ODz9+svg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBCHkhw7; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBCHkhw7"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3078e0dcd67so2810683eec.0
        for <git@vger.kernel.org>; Sun, 14 Jun 2026 11:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781463566; x=1782068366; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7KCq9jgzVX6qbbuxBc+UMjR2TFI8BgQTtecCtDivkY=;
        b=JBCHkhw7Rpv3oLUAuQuSm+fdoDzREjp0O0/KcUk/IwaYePHxce21q4MG3T7Yo88vok
         6yxnCm/YwDWcUKK6X/bAP2beBOr07Wc2YHGAj90fiDq1ohCs1J+hR4aIN7caWcs0jSR5
         lcpS71r2saSZX1YLzfOYixsDg20KiuAxMFbDNGmjhXtoHTqYQpT0u8gsBjZQV4RHveN8
         NpypPoLHShp02hL12QKs5y0LWmCzTkD5piY7exGTEENWhbEv7hVYapujqEF/YTSAwuqz
         4q81QjJTs8FYZM6sk9utv77pLPfvD1DsahoK75sNDTBcOTpLJMOeHRJV5Ya5PK1MgJsb
         HPIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781463566; x=1782068366;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G7KCq9jgzVX6qbbuxBc+UMjR2TFI8BgQTtecCtDivkY=;
        b=rd8YKLlB9hsaSqoSOLaJDgioU/1f5DQvU+hv6a9b5OpUamMcCzthf/D8v5016MPRo+
         MH3ixdynhrtl2pqUhwkPyYz/EMqqjoJ7ykTzpfmMq9kx6a8fi7Hsvc5oY34h6+vOwU3Y
         j773yJ6QU8n/ZRHOmIR30LpTehdAbW8KivKo+sPssQinCOAmcZ+7+HbZmkX/VfL3iGIz
         MfWz0ZQMM/G1TleHbkCwoCIOwiiUNEjIkq/o+hqLrDm8cl2IXoMyyYFslcxA87M8067y
         3bnzm+7Lz1Ev0BdkxB6qhHtrMXkJKNTCUfBsASvJatzp5c9LLqGF5FllKR5cv1WuZDrG
         4dXw==
X-Gm-Message-State: AOJu0YxM1EMrj2o2Ccwou21rLMMBk50zlVarF5jyUjfITtshkW1erZig
	Oj5Nh+USRcXtydJFlIPpOzkZm4jczDgOD4OUjq0nHa3tbZeC5qzV7WN1jGGDHg==
X-Gm-Gg: Acq92OFWmqro34OONgHtJuxVdWO1OMAwZUbHh1jSZLxfkmxpkWdoWiPJSml+DcyEM04
	EMpAqJC+he28cS543KSOicvFn2BNoolBL2ddP+FZ5zSjDT//V9IAgkyNiEXhxHcHzX8l1GXvxBE
	l4WEYgRzms+3tig0p52/dfHjnKxfzk7HhMhryGcmC/ptxmf8JNUeJ23zZcnImntkbFhIMXH7fZw
	cSGsKJ4lqSIhsgbzH5asVxOVaqEafua1OnFVPI0BuyiCkc3TKP3KciJ5bzQ34ks8GmsVpml7pMq
	SZHGln0wq14NOlGfLMqKCAUij4MA1TULKN2/funERS4QE4NRpFYNonf+zpPWnjLbllKDexYsYdw
	OLLJdKZKN+zX2fgiLBPjCBb4iVRXcFz0SdZZC9Hae63pPEJkOcZR9IfpBnV5Zi57uW9XG6IpKTh
	G3vYWjKETc85akZzqoYsbZryL/
X-Received: by 2002:a05:7301:169a:b0:304:cc9c:35ae with SMTP id 5a478bee46e88-3093532e192mr4075745eec.4.1781463565636;
        Sun, 14 Jun 2026 11:59:25 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.53.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081eb8d3c9sm11682257eec.26.2026.06.14.11.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 11:59:25 -0700 (PDT)
Message-Id: <pull.2120.v4.git.1781463564.gitgitgadget@gmail.com>
In-Reply-To: <pull.2120.v3.git.1780087700.gitgitgadget@gmail.com>
References: <pull.2120.v3.git.1780087700.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 14 Jun 2026 18:59:17 +0000
Subject: [PATCH v4 0/6] [RFC] diff: add diff.<driver>.process for external hunk providers
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

 * Patch 1: xdiff plumbing for externally supplied hunks.
 * Patch 2: diff.<driver>.process config key.
 * Patch 3: refactor subprocess API to separate process lifecycle from
   hashmap management, since the diff process stores its subprocess on the
   userdiff driver rather than in a hashmap.
 * Patch 4: the main feature.
 * Patch 5: bypass knobs (--no-ext-diff, format-patch).
 * Patch 6: blame integration so the tool can declare commits as having no
   changes.

Changes since v3:

 * Replaced Python test backend with C test-tool helper (thanks to Johannes
   Schindelin).
 * Added test coverage cases for deleted file, malformed hunk line, and
   missing capability.
 * Fixed potential overflow in synchronization invariant check by counting
   from changed[] arrays instead of accumulating.
 * Accept start=0 with count=0 in the hunk protocol, matching what git diff
   itself emits for empty file sides.
 * Warn on external hunk validation failure with specific reasons (range
   exceeded, overlap, sync mismatch) to help tool authors debug their
   implementations.
 * Test backend follows the same convention (start=0 when count=0 for empty
   file sides).

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
 Documentation/gitattributes.adoc         | 143 ++++++
 Makefile                                 |   2 +
 blame.c                                  |  40 +-
 builtin/log.c                            |   7 +
 diff-process.c                           | 297 ++++++++++++
 diff-process.h                           |  39 ++
 diff.c                                   |  29 +-
 diff.h                                   |   5 +
 meson.build                              |   1 +
 sub-process.c                            |  28 +-
 sub-process.h                            |   9 +-
 t/helper/meson.build                     |   1 +
 t/helper/test-diff-process-backend.c     | 299 ++++++++++++
 t/helper/test-tool.c                     |   1 +
 t/helper/test-tool.h                     |   1 +
 t/meson.build                            |   1 +
 t/t4080-diff-process.sh                  | 553 +++++++++++++++++++++++
 userdiff.c                               |   7 +
 userdiff.h                               |   5 +
 xdiff-interface.c                        |   7 +-
 xdiff/xdiff.h                            |  14 +
 xdiff/xdiffi.c                           | 123 ++++-
 xdiff/xprepare.c                         |  10 +
 xdiff/xprepare.h                         |   1 +
 27 files changed, 1614 insertions(+), 21 deletions(-)
 create mode 100644 diff-process.c
 create mode 100644 diff-process.h
 create mode 100644 t/helper/test-diff-process-backend.c
 create mode 100755 t/t4080-diff-process.sh


base-commit: ea97ad8d017de0c9037451a78008a0fd60abea0c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2120%2Fmmontalbo%2Fmm%2Fstructural-diff-backend-clean-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2120/mmontalbo/mm/structural-diff-backend-clean-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/2120

Range-diff vs v3:

 1:  13eb201d63 ! 1:  03f261dfe2 xdiff: support external hunks via xpparam_t
     @@ xdiff/xdiff.h: typedef struct s_mmbuffer {
       
      +/*
      + * Hunk descriptor for externally computed diffs.
     -+ * Line numbers are 1-based, matching unified diff convention.
     ++ * Line numbers are 1-based; a start of 0 is accepted when
     ++ * count is 0 (empty file side, matching git diff output).
      + */
      +struct xdl_hunk {
      +	long old_start, old_count;
     @@ xdiff/xdiffi.c: static void xdl_mark_ignorable_regex(xdchange_t *xscr, const xdf
      +{
      +	size_t i;
      +	long j, prev_old_end = 0, prev_new_end = 0;
     -+	long total_old = 0, total_new = 0;
     ++	long changed_old = 0, changed_new = 0;
      +
      +	/*
      +	 * xdl_prepare_env() may dirty changed[] via xdl_cleanup_records().
     @@ xdiff/xdiffi.c: static void xdl_mark_ignorable_regex(xdchange_t *xscr, const xdf
      +	for (i = 0; i < nr_hunks; i++) {
      +		struct xdl_hunk *h = &hunks[i];
      +
     -+		if (h->old_count < 0 || h->new_count < 0)
     ++		if (h->old_count < 0 || h->new_count < 0) {
     ++			warning("diff process hunk %"PRIuMAX": "
     ++				"negative count (old=%ld, new=%ld)",
     ++				(uintmax_t)(i + 1),
     ++				h->old_count, h->new_count);
      +			return -1;
     -+		if (h->old_start < 1 || h->new_start < 1)
     ++		}
     ++		if (h->old_start < 1 || h->new_start < 1) {
     ++			warning("diff process hunk %"PRIuMAX": "
     ++				"start must be >= 1 (old=%ld, new=%ld)",
     ++				(uintmax_t)(i + 1),
     ++				h->old_start, h->new_start);
      +			return -1;
     ++		}
      +
      +		/*
      +		 * Range must fit: start + count - 1 <= nrec,
     @@ xdiff/xdiffi.c: static void xdl_mark_ignorable_regex(xdchange_t *xscr, const xdf
      +		 * start > nrec + 1 and allows start == nrec + 1
      +		 * (the position after the last line).
      +		 */
     -+		if (h->old_count > (long)xe->xdf1.nrec - h->old_start + 1)
     ++		if (h->old_count > (long)xe->xdf1.nrec - h->old_start + 1) {
     ++			warning("diff process hunk %"PRIuMAX": "
     ++				"old range %ld+%ld exceeds %lu lines",
     ++				(uintmax_t)(i + 1),
     ++				h->old_start, h->old_count,
     ++				(unsigned long)xe->xdf1.nrec);
      +			return -1;
     -+		if (h->new_count > (long)xe->xdf2.nrec - h->new_start + 1)
     ++		}
     ++		if (h->new_count > (long)xe->xdf2.nrec - h->new_start + 1) {
     ++			warning("diff process hunk %"PRIuMAX": "
     ++				"new range %ld+%ld exceeds %lu lines",
     ++				(uintmax_t)(i + 1),
     ++				h->new_start, h->new_count,
     ++				(unsigned long)xe->xdf2.nrec);
      +			return -1;
     ++		}
      +
      +		/* Ordering: no overlap with previous hunk (adjacent is OK) */
      +		if (h->old_start < prev_old_end ||
     -+		    h->new_start < prev_new_end)
     ++		    h->new_start < prev_new_end) {
     ++			warning("diff process hunk %"PRIuMAX": "
     ++				"overlaps with previous hunk",
     ++				(uintmax_t)(i + 1));
      +			return -1;
     ++		}
      +
      +		for (j = 0; j < h->old_count; j++)
      +			xe->xdf1.changed[h->old_start - 1 + j] = true;
     @@ xdiff/xdiffi.c: static void xdl_mark_ignorable_regex(xdchange_t *xscr, const xdf
      +
      +		prev_old_end = h->old_start + h->old_count;
      +		prev_new_end = h->new_start + h->new_count;
     -+		total_old += h->old_count;
     -+		total_new += h->new_count;
      +	}
      +
      +	/*
      +	 * Synchronization invariant: unchanged line counts must match.
      +	 * Otherwise xdl_build_script() would walk off one array.
     ++	 *
     ++	 * Count changed lines from the arrays rather than accumulating
     ++	 * during the loop to avoid any overflow in the summation.
      +	 */
     -+	if ((long)xe->xdf1.nrec - total_old !=
     -+	    (long)xe->xdf2.nrec - total_new)
     ++	for (j = 0; j < (long)xe->xdf1.nrec; j++)
     ++		if (xe->xdf1.changed[j])
     ++			changed_old++;
     ++	for (j = 0; j < (long)xe->xdf2.nrec; j++)
     ++		if (xe->xdf2.changed[j])
     ++			changed_new++;
     ++	if ((long)xe->xdf1.nrec - changed_old !=
     ++	    (long)xe->xdf2.nrec - changed_new) {
     ++		warning("diff process: unchanged line count mismatch "
     ++			"(old: %ld unchanged, new: %ld unchanged)",
     ++			(long)xe->xdf1.nrec - changed_old,
     ++			(long)xe->xdf2.nrec - changed_new);
      +		return -1;
     ++	}
      +
      +	return 0;
      +}
 2:  58f4763c63 = 2:  30617ee17b userdiff: add diff.<driver>.process config
 3:  d6c833dd42 ! 3:  459e485e6d sub-process: separate process lifecycle from hashmap management
     @@ Commit message
          and subprocess_stop() become thin wrappers that add hashmap
          operations on top.
      
     -    No functional change for existing callers.
     -
          Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
      
       ## sub-process.c ##
     @@ sub-process.c: void subprocess_stop(struct hashmap *hashmap, struct subprocess_e
       	kill(entry->process.pid, SIGTERM);
       	finish_command(&entry->process);
      +}
     -+
     + 
      +void subprocess_stop(struct hashmap *hashmap, struct subprocess_entry *entry)
      +{
      +	if (!entry)
      +		return;
     - 
     ++
      +	subprocess_stop_command(entry);
       	hashmap_remove(hashmap, &entry->ent, NULL);
       }
     @@ sub-process.c: int subprocess_start(struct hashmap *hashmap, struct subprocess_e
      +	int err;
      +
      +	err = subprocess_start_command(entry, cmd, startfn);
     -+	if (err) {
     ++	if (err)
      +		return err;
     -+	}
      +
      +	hashmap_entry_init(&entry->ent, strhash(cmd));
       	hashmap_add(hashmap, &entry->ent);
 4:  d044fa0ee5 ! 4:  10b3980f59 diff: add long-running diff process via diff.<driver>.process
     @@ Commit message
          textconv-transformed content.  The tool controls which lines
          are marked as changed while the display shows the file content.
          Patch output features (word diff, function context, color) work
     -    normally; summary formats like --stat use their own diff path
     -    and are not affected.
     +    normally; --stat uses its own diff codepath and never consults
     +    the diff process.
      
          The handshake negotiates version=1 and capability=hunks.  Per-file
          requests send command=hunks, pathname, and both file contents as
     @@ Commit message
          "hunks populated" from "files equivalent" from "not applicable"
          from "tool failure."
      
     +    Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
          Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
      
       ## Documentation/config/diff.adoc ##
     @@ Documentation/gitattributes.adoc: NOTE: If `diff.<name>.command` is defined for
      +at line 3 in the old file were replaced by 4 lines starting at
      +line 3 in the new file.  An `<old_count>` of 0 means no lines were
      +removed (pure insertion); a `<new_count>` of 0 means no lines were
     -+added (pure deletion).
     ++added (pure deletion).  A start value of 0 is accepted when
     ++the corresponding count is 0 (e.g., `hunk 0 0 1 5` for a newly
     ++added file), matching what `git diff` itself emits for empty
     ++file sides.
      +
      +Lines are delimited by newlines.  A file `"foo\nbar\n"` and a
      +file `"foo\nbar"` both have 2 lines.
     @@ Documentation/gitattributes.adoc: NOTE: If `diff.<name>.command` is defined for
      +packet:          git< 0000
      +-----------------------
      +
     -+If the tool returns invalid hunks (out of bounds, overlapping), Git
     -+silently falls back to the builtin diff algorithm.
     ++If the tool returns invalid hunks (out of bounds, overlapping, or
     ++mismatched unchanged line counts), Git warns and falls back to the
     ++builtin diff algorithm.
      +
      +In case the tool cannot or does not want to process the content,
      +it is expected to respond with an "error" status.  Git warns and
     @@ Documentation/gitattributes.adoc: NOTE: If `diff.<name>.command` is defined for
       
      
       ## Makefile ##
     +@@ Makefile: TEST_BUILTINS_OBJS += test-csprng.o
     + TEST_BUILTINS_OBJS += test-date.o
     + TEST_BUILTINS_OBJS += test-delete-gpgsig.o
     + TEST_BUILTINS_OBJS += test-delta.o
     ++TEST_BUILTINS_OBJS += test-diff-process-backend.o
     + TEST_BUILTINS_OBJS += test-dir-iterator.o
     + TEST_BUILTINS_OBJS += test-drop-caches.o
     + TEST_BUILTINS_OBJS += test-dump-cache-tree.o
      @@ Makefile: LIB_OBJS += diff-delta.o
       LIB_OBJS += diff-merges.o
       LIB_OBJS += diff-lib.o
     @@ diff-process.c (new)
      +	if (errno || end == line || *end != '\0')
      +		return -1;
      +
     ++	/*
     ++	 * git diff emits start=0 when count=0 (empty file side).
     ++	 * Normalize to 1-based so downstream validation can assume start >= 1.
     ++	 */
     ++	if (!hunk->old_count && !hunk->old_start)
     ++		hunk->old_start = 1;
     ++	if (!hunk->new_count && !hunk->new_start)
     ++		hunk->new_start = 1;
     ++
      +	return 0;
      +}
      +
     @@ meson.build: libgit_sources = [
         'diffcore-break.c',
         'diffcore-delta.c',
      
     - ## t/.gitattributes ##
     -@@ t/.gitattributes: t[0-9][0-9][0-9][0-9]/* -whitespace
     - /t8005/*.txt eol=lf
     - /t9*/*.dump eol=lf
     - /t0040*.sh whitespace=-indent-with-non-tab
     -+/t4080-diff-process.sh whitespace=-indent-with-non-tab
     + ## t/helper/meson.build ##
     +@@ t/helper/meson.build: test_tool_sources = [
     +   'test-date.c',
     +   'test-delete-gpgsig.c',
     +   'test-delta.c',
     ++  'test-diff-process-backend.c',
     +   'test-dir-iterator.c',
     +   'test-drop-caches.c',
     +   'test-dump-cache-tree.c',
     +
     + ## t/helper/test-diff-process-backend.c (new) ##
     +@@
     ++/*
     ++ * Test backend for the long-running diff process protocol
     ++ * (see diff-process.c and Documentation/gitattributes.adoc).
     ++ *
     ++ * Usage: test-tool diff-process-backend --mode=<mode> [--log=<path>]
     ++ *
     ++ * Implements the server side of the pkt-line handshake and a per-file
     ++ * response loop.  The --mode= switch selects the response shape
     ++ * (success, error, abort, crash, malformed hunks).
     ++ *
     ++ * Per-file request from Git:
     ++ *
     ++ *   packet:          git> command=hunks
     ++ *   packet:          git> pathname=<path>
     ++ *   packet:          git> 0000
     ++ *   packet:          git> OLD_CONTENT
     ++ *   packet:          git> 0000
     ++ *   packet:          git> NEW_CONTENT
     ++ *   packet:          git> 0000
     ++ *
     ++ * Response varies by --mode (default: whole-file):
     ++ *
     ++ *   whole-file   packet: git< hunk 1 <old_lines> 1 <new_lines>
     ++ *   fixed-hunk   packet: git< hunk 5 2 5 2
     ++ *   no-hunks     (no hunk packets)
     ++ *   bad-hunk     packet: git< hunk 999 1 999 1
     ++ *   bad-parse    packet: git< garbage not a hunk
     ++ *   bad-sync     packet: git< hunk 1 2 1 1
     ++ *   overlap      packet: git< hunk 1 5 1 5
     ++ *                packet: git< hunk 3 2 3 2
     ++ *   no-cap       (omits capability=hunks during handshake)
     ++ *   error        (status=error instead of status=success)
     ++ *   abort        (status=abort instead of status=success)
     ++ *   crash        exit(1) before sending any response
     ++ *
     ++ * All non-error/abort modes end with:
     ++ *
     ++ *   packet:          git< 0000
     ++ *   packet:          git< status=success
     ++ *   packet:          git< 0000
     ++ *
     ++ * Each request is logged to --log as:
     ++ *
     ++ *   command=<cmd> pathname=<path> old=<first line> new=<first line>
     ++ */
     ++
     ++#include "test-tool.h"
     ++#include "pkt-line.h"
     ++#include "parse-options.h"
     ++#include "strbuf.h"
     ++
     ++static FILE *logfile;
     ++
     ++enum mode {
     ++	MODE_WHOLE_FILE,
     ++	MODE_FIXED_HUNK,
     ++	MODE_NO_HUNKS,
     ++	MODE_BAD_HUNK,
     ++	MODE_BAD_PARSE,
     ++	MODE_BAD_SYNC,
     ++	MODE_OVERLAP,
     ++	MODE_NO_CAP,
     ++	MODE_ERROR,
     ++	MODE_ABORT,
     ++	MODE_CRASH,
     ++};
     ++
     ++static enum mode parse_mode(const char *s)
     ++{
     ++	if (!strcmp(s, "whole-file"))
     ++		return MODE_WHOLE_FILE;
     ++	if (!strcmp(s, "fixed-hunk"))
     ++		return MODE_FIXED_HUNK;
     ++	if (!strcmp(s, "no-hunks"))
     ++		return MODE_NO_HUNKS;
     ++	if (!strcmp(s, "bad-hunk"))
     ++		return MODE_BAD_HUNK;
     ++	if (!strcmp(s, "bad-parse"))
     ++		return MODE_BAD_PARSE;
     ++	if (!strcmp(s, "bad-sync"))
     ++		return MODE_BAD_SYNC;
     ++	if (!strcmp(s, "overlap"))
     ++		return MODE_OVERLAP;
     ++	if (!strcmp(s, "no-cap"))
     ++		return MODE_NO_CAP;
     ++	if (!strcmp(s, "error"))
     ++		return MODE_ERROR;
     ++	if (!strcmp(s, "abort"))
     ++		return MODE_ABORT;
     ++	if (!strcmp(s, "crash"))
     ++		return MODE_CRASH;
     ++	die("unknown --mode=%s", s);
     ++}
     ++
     ++/*
     ++ * Read "key=value" packets up to a flush, capturing "command" and
     ++ * "pathname".  Returns 1 if a request was read, 0 on EOF.
     ++ *
     ++ * The first packet uses the gentle variant so that a clean shutdown
     ++ * by Git (EOF) does not produce a spurious "the remote end hung up
     ++ * unexpectedly" on stderr.  Subsequent packets use the non-gentle
     ++ * variant: once inside a request, truncation is a protocol violation
     ++ * and dying loudly is the correct response.
     ++ */
     ++static int read_request_header(char **command, char **pathname)
     ++{
     ++	int first = 1;
     ++	char *line;
     ++
     ++	*command = *pathname = NULL;
     ++	for (;;) {
     ++		const char *value;
     ++
     ++		if (first) {
     ++			if (packet_read_line_gently(0, NULL, &line) < 0)
     ++				return 0;
     ++			first = 0;
     ++		} else {
     ++			line = packet_read_line(0, NULL);
     ++		}
     ++		if (!line)
     ++			break;
     ++		if (skip_prefix(line, "command=", &value))
     ++			*command = xstrdup(value);
     ++		else if (skip_prefix(line, "pathname=", &value))
     ++			*pathname = xstrdup(value);
     ++	}
     ++	return 1;
     ++}
     ++
     ++static size_t count_lines(const struct strbuf *buf)
     ++{
     ++	size_t lines = 0;
     ++
     ++	for (size_t i = 0; i < buf->len; i++)
     ++		if (buf->buf[i] == '\n')
     ++			lines++;
     ++
     ++	return lines + (buf->len > 0 && buf->buf[buf->len - 1] != '\n');
     ++}
     ++
     ++static void send_status(const char *status)
     ++{
     ++	packet_flush(1);
     ++	packet_write_fmt(1, "%s\n", status);
     ++	packet_flush(1);
     ++}
     ++
     ++static void respond(enum mode mode,
     ++		    const struct strbuf *old_buf,
     ++		    const struct strbuf *new_buf)
     ++{
     ++	switch (mode) {
     ++	case MODE_ERROR:
     ++		send_status("status=error");
     ++		return;
     ++	case MODE_ABORT:
     ++		send_status("status=abort");
     ++		return;
     ++	case MODE_CRASH:
     ++		exit(1);
     ++	case MODE_FIXED_HUNK:
     ++		packet_write_fmt(1, "hunk 5 2 5 2\n");
     ++		break;
     ++	case MODE_BAD_HUNK:
     ++		packet_write_fmt(1, "hunk 999 1 999 1\n");
     ++		break;
     ++	case MODE_BAD_PARSE:
     ++		packet_write_fmt(1, "garbage not a hunk\n");
     ++		break;
     ++	case MODE_BAD_SYNC:
     ++		packet_write_fmt(1, "hunk 1 2 1 1\n");
     ++		break;
     ++	case MODE_OVERLAP:
     ++		packet_write_fmt(1, "hunk 1 5 1 5\n");
     ++		packet_write_fmt(1, "hunk 3 2 3 2\n");
     ++		break;
     ++	case MODE_NO_HUNKS:
     ++		break;
     ++	case MODE_NO_CAP:
     ++	case MODE_WHOLE_FILE: {
     ++		size_t old_lines = count_lines(old_buf);
     ++		size_t new_lines = count_lines(new_buf);
     ++		/*
     ++		 * Match git diff output: start=0 when count=0
     ++		 * (empty file side), 1 otherwise.
     ++		 */
     ++		packet_write_fmt(1, "hunk %"PRIuMAX" %"PRIuMAX
     ++				 " %"PRIuMAX" %"PRIuMAX"\n",
     ++				 (uintmax_t)(old_lines ? 1 : 0),
     ++				 (uintmax_t)old_lines,
     ++				 (uintmax_t)(new_lines ? 1 : 0),
     ++				 (uintmax_t)new_lines);
     ++		break;
     ++	}
     ++	}
     ++	send_status("status=success");
     ++}
     ++
     ++static void command_loop(enum mode mode)
     ++{
     ++	for (;;) {
     ++		char *command = NULL, *pathname = NULL;
     ++		struct strbuf obuf = STRBUF_INIT;
     ++		struct strbuf nbuf = STRBUF_INIT;
     ++
     ++		if (!read_request_header(&command, &pathname))
     ++			break; /* EOF: Git closed its end */
     ++
     ++		read_packetized_to_strbuf(0, &obuf, 0);
     ++		read_packetized_to_strbuf(0, &nbuf, 0);
     ++
     ++		if (logfile) {
     ++			fprintf(logfile,
     ++				"command=%s pathname=%s old=%.*s new=%.*s\n",
     ++				command ? command : "(none)",
     ++				pathname ? pathname : "(none)",
     ++				(int)(strchrnul(obuf.buf, '\n') - obuf.buf),
     ++				obuf.buf,
     ++				(int)(strchrnul(nbuf.buf, '\n') - nbuf.buf),
     ++				nbuf.buf);
     ++			fflush(logfile);
     ++		}
     ++
     ++		respond(mode, &obuf, &nbuf);
     ++
     ++		free(command);
     ++		free(pathname);
     ++		strbuf_release(&obuf);
     ++		strbuf_release(&nbuf);
     ++	}
     ++}
     ++
     ++static void handshake(enum mode mode)
     ++{
     ++	char *line;
     ++
     ++	line = packet_read_line(0, NULL);
     ++	if (!line || strcmp(line, "git-diff-client"))
     ++		die("bad welcome: '%s'", line ? line : "(eof)");
     ++	line = packet_read_line(0, NULL);
     ++	if (!line || strcmp(line, "version=1"))
     ++		die("bad version: '%s'", line ? line : "(eof)");
     ++	if (packet_read_line(0, NULL))
     ++		die("expected flush after version");
     ++
     ++	packet_write_fmt(1, "git-diff-server\n");
     ++	packet_write_fmt(1, "version=1\n");
     ++	packet_flush(1);
     ++
     ++	/* Drain capabilities advertised by Git */
     ++	while ((line = packet_read_line(0, NULL)))
     ++		; /* drain */
     ++
     ++	/* Respond with our capabilities (or none for no-cap mode) */
     ++	if (mode != MODE_NO_CAP)
     ++		packet_write_fmt(1, "capability=hunks\n");
     ++	packet_flush(1);
     ++}
     ++
     ++static const char *const usage_str[] = {
     ++	"test-tool diff-process-backend --mode=<mode> [--log=<path>]",
     ++	NULL
     ++};
     ++
     ++int cmd__diff_process_backend(int argc, const char **argv)
     ++{
     ++	const char *mode_str = NULL, *log_path = NULL;
     ++	enum mode mode = MODE_WHOLE_FILE;
     ++	struct option options[] = {
     ++		OPT_STRING(0, "mode", &mode_str, "mode",
     ++			   "response shape: whole-file (default), fixed-hunk,"
     ++			   " no-hunks, bad-hunk, bad-sync, overlap, error,"
     ++			   " abort, crash"),
     ++		OPT_STRING(0, "log", &log_path, "path",
     ++			   "append per-request summary to this file"),
     ++		OPT_END()
     ++	};
     ++
     ++	argc = parse_options(argc, argv, NULL, options, usage_str, 0);
     ++	if (argc)
     ++		usage_with_options(usage_str, options);
     ++
     ++	if (mode_str)
     ++		mode = parse_mode(mode_str);
     ++
     ++	if (log_path) {
     ++		logfile = fopen(log_path, "a");
     ++		if (!logfile)
     ++			die_errno("failed to open log '%s'", log_path);
     ++	}
     ++
     ++	handshake(mode);
     ++	command_loop(mode);
     ++
     ++	if (logfile && fclose(logfile))
     ++		die_errno("error closing log");
     ++	return 0;
     ++}
     +
     + ## t/helper/test-tool.c ##
     +@@ t/helper/test-tool.c: static struct test_cmd cmds[] = {
     + 	{ "date", cmd__date },
     + 	{ "delete-gpgsig", cmd__delete_gpgsig },
     + 	{ "delta", cmd__delta },
     ++	{ "diff-process-backend", cmd__diff_process_backend },
     + 	{ "dir-iterator", cmd__dir_iterator },
     + 	{ "drop-caches", cmd__drop_caches },
     + 	{ "dump-cache-tree", cmd__dump_cache_tree },
     +
     + ## t/helper/test-tool.h ##
     +@@ t/helper/test-tool.h: int cmd__csprng(int argc, const char **argv);
     + int cmd__date(int argc, const char **argv);
     + int cmd__delta(int argc, const char **argv);
     + int cmd__delete_gpgsig(int argc, const char **argv);
     ++int cmd__diff_process_backend(int argc, const char **argv);
     + int cmd__dir_iterator(int argc, const char **argv);
     + int cmd__drop_caches(int argc, const char **argv);
     + int cmd__dump_cache_tree(int argc, const char **argv);
      
       ## t/meson.build ##
      @@ t/meson.build: integration_tests = [
     @@ t/t4080-diff-process.sh (new)
      +
      +. ./test-lib.sh
      +
     -+if test_have_prereq PYTHON
     -+then
     -+	PYTHON_PATH=$(command -v python3) || PYTHON_PATH=$(command -v python)
     -+fi
     ++# See t/helper/test-diff-process-backend.c for the backend implementation
     ++# and available --mode= options.
      +
     -+#
     -+# A single parametric diff process.
     -+# Usage: diff-process-backend --mode=<mode> [--log=<path>]
     -+#
     -+# Modes:
     -+#   whole-file  - report all lines as changed (default)
     -+#   fixed-hunk  - always report hunk 5 2 5 2
     -+#   bad-hunk    - report out-of-bounds hunk 999 1 999 1
     -+#   bad-sync    - report hunk with mismatched unchanged totals
     -+#   overlap     - report two overlapping hunks
     -+#   no-hunks   - return no hunks (files considered equivalent)
     -+#   error       - return status=error for every request
     -+#   abort       - return status=abort for every request
     -+#   crash       - read one request then exit without responding
     -+#
     -+setup_backend () {
     -+	cat >"$TRASH_DIRECTORY/diff-process-backend.py" <<-\PYEOF
     -+	import sys, os
     -+
     -+	def read_pkt():
     -+	    hdr = sys.stdin.buffer.read(4)
     -+	    if len(hdr) < 4: return None
     -+	    length = int(hdr, 16)
     -+	    if length == 0: return ""
     -+	    data = sys.stdin.buffer.read(length - 4)
     -+	    return data.decode().rstrip("\n")
     -+
     -+	def write_pkt(line):
     -+	    data = (line + "\n").encode()
     -+	    sys.stdout.buffer.write(f"{len(data)+4:04x}".encode() + data)
     -+	    sys.stdout.buffer.flush()
     -+
     -+	def write_flush():
     -+	    sys.stdout.buffer.write(b"0000")
     -+	    sys.stdout.buffer.flush()
     -+
     -+	def read_content():
     -+	    chunks = []
     -+	    while True:
     -+	        hdr = sys.stdin.buffer.read(4)
     -+	        if len(hdr) < 4: break
     -+	        length = int(hdr, 16)
     -+	        if length == 0: break
     -+	        chunks.append(sys.stdin.buffer.read(length - 4))
     -+	    return b"".join(chunks)
     -+
     -+	mode = "whole-file"
     -+	logfile = None
     -+	for arg in sys.argv[1:]:
     -+	    if arg.startswith("--mode="):
     -+	        mode = arg[7:]
     -+	    elif arg.startswith("--log="):
     -+	        logfile = open(arg[6:], "a")
     -+
     -+	def log(msg):
     -+	    if logfile:
     -+	        logfile.write(msg + "\n")
     -+	        logfile.flush()
     -+
     -+	# Handshake
     -+	assert read_pkt() == "git-diff-client"
     -+	assert read_pkt() == "version=1"
     -+	read_pkt()
     -+	write_pkt("git-diff-server")
     -+	write_pkt("version=1")
     -+	write_flush()
     -+	while True:
     -+	    p = read_pkt()
     -+	    if p == "": break
     -+	write_pkt("capability=hunks")
     -+	write_flush()
     -+
     -+	log("ready")
     -+
     -+	while True:
     -+	    cmd = None
     -+	    pathname = None
     -+	    while True:
     -+	        p = read_pkt()
     -+	        if p is None: sys.exit(0)
     -+	        if p == "": break
     -+	        if p.startswith("command="): cmd = p.split("=",1)[1]
     -+	        if p.startswith("pathname="): pathname = p.split("=",1)[1]
     -+	    if cmd is None: sys.exit(0)
     -+	    old = read_content()
     -+	    new = read_content()
     -+	    old_first = old.split(b"\n")[0].decode(errors="replace") if old else ""
     -+	    new_first = new.split(b"\n")[0].decode(errors="replace") if new else ""
     -+	    log(f"command={cmd} pathname={pathname} old={old_first} new={new_first}")
     -+
     -+	    if mode == "error":
     -+	        write_flush()
     -+	        write_pkt("status=error")
     -+	        write_flush()
     -+	        continue
     -+
     -+	    if mode == "abort":
     -+	        write_flush()
     -+	        write_pkt("status=abort")
     -+	        write_flush()
     -+	        continue
     -+
     -+	    if mode == "crash":
     -+	        sys.exit(1)
     -+
     -+	    if cmd == "hunks":
     -+	        if mode == "fixed-hunk":
     -+	            write_pkt("hunk 5 2 5 2")
     -+	        elif mode == "bad-hunk":
     -+	            write_pkt("hunk 999 1 999 1")
     -+	        elif mode == "bad-sync":
     -+	            write_pkt("hunk 1 2 1 1")
     -+	        elif mode == "overlap":
     -+	            write_pkt("hunk 1 5 1 5")
     -+	            write_pkt("hunk 3 2 3 2")
     -+	        elif mode == "no-hunks":
     -+	            pass
     -+	        else:
     -+	            ol = old.count(b"\n")
     -+	            nl = new.count(b"\n")
     -+	            write_pkt(f"hunk 1 {ol} 1 {nl}")
     -+	        write_flush()
     -+	        write_pkt("status=success")
     -+	        write_flush()
     -+	    else:
     -+	        write_flush()
     -+	        write_pkt("status=error")
     -+	        write_flush()
     -+	PYEOF
     -+	write_script diff-process-backend <<-SHEOF
     -+	exec "$PYTHON_PATH" "$TRASH_DIRECTORY/diff-process-backend.py" "\$@"
     -+	SHEOF
     -+}
     -+
     -+BACKEND="./diff-process-backend"
     ++BACKEND="test-tool diff-process-backend"
      +
     -+test_expect_success PYTHON 'setup' '
     -+	setup_backend &&
     ++test_expect_success 'setup' '
      +	echo "*.c diff=cdiff" >.gitattributes &&
      +	git add .gitattributes &&
      +
     @@ t/t4080-diff-process.sh (new)
      +	git add worddiff.c &&
      +
      +	# newfile.c: single-line function, value changes 42 -> 99.
     -+	# Used by: new file, --exit-code, multiple drivers.
     ++	# Used by: modified file, --exit-code, multiple drivers.
      +	cat >newfile.c <<-\EOF &&
      +	int new_func(void) { return 42; }
      +	EOF
     @@ t/t4080-diff-process.sh (new)
      +# Core behavior: the tool controls which lines are marked as changed.
      +#
      +
     -+test_expect_success PYTHON 'diff process hunk boundaries affect output' '
     ++test_expect_success 'diff process hunk boundaries affect output' '
      +	# The file has changes at lines 5-6 and 9-10, but fixed-hunk
      +	# only reports lines 5-6 as changed.  Lines 9-10 should not
      +	# appear as changed in the output.
     @@ t/t4080-diff-process.sh (new)
      +	test_grep ! "^+NEW10" actual
      +'
      +
     -+test_expect_success PYTHON 'diff process works with new file' '
     -+	rm -f backend.log &&
     ++test_expect_success 'diff process works with modified file' '
     ++	test_when_finished "rm -f backend.log" &&
      +	git -c diff.cdiff.process="$BACKEND --log=backend.log" \
      +		diff -- newfile.c >actual 2>stderr &&
      +	test_grep "return 99" actual &&
     @@ t/t4080-diff-process.sh (new)
      +	test_must_be_empty stderr
      +'
      +
     -+test_expect_success PYTHON 'diff process works with added file (empty old side)' '
     ++test_expect_success 'diff process works with added file (empty old side)' '
      +	cat >added.c <<-\EOF &&
      +	int added(void) { return 1; }
      +	EOF
      +	git add added.c &&
      +
     -+	rm -f backend.log &&
     ++	test_when_finished "rm -f backend.log" &&
      +	git -c diff.cdiff.process="$BACKEND --log=backend.log" \
      +		diff --cached -- added.c >actual 2>stderr &&
      +	test_grep "added" actual &&
     @@ t/t4080-diff-process.sh (new)
      +	test_must_be_empty stderr
      +'
      +
     -+test_expect_success PYTHON 'diff process skipped for binary files' '
     ++test_expect_success 'diff process works with deleted file (empty new side)' '
     ++	git add added.c &&
     ++	git commit -m "commit added.c" &&
     ++	git rm added.c &&
     ++
     ++	test_when_finished "rm -f backend.log" &&
     ++	git -c diff.cdiff.process="$BACKEND --log=backend.log" \
     ++		diff --cached -- added.c >actual 2>stderr &&
     ++	test_grep "deleted file" actual &&
     ++	test_grep "pathname=added.c" backend.log &&
     ++	test_must_be_empty stderr
     ++'
     ++
     ++test_expect_success 'diff process skipped for binary files' '
      +	printf "\\0binary" >binary.c &&
      +	git add binary.c &&
      +	git commit -m "add binary" &&
      +	printf "\\0changed" >binary.c &&
      +
     -+	rm -f backend.log &&
     ++	test_when_finished "rm -f backend.log" &&
      +	git -c diff.cdiff.process="$BACKEND --log=backend.log" \
      +		diff -- binary.c >actual &&
      +	test_grep "Binary files" actual &&
      +	test_path_is_missing backend.log
      +'
      +
     -+test_expect_success PYTHON 'diff process not consulted for unmatched driver' '
     ++test_expect_success 'diff process not consulted for unmatched driver' '
      +	echo "not tracked by cdiff" >unmatched.txt &&
      +	git add unmatched.txt &&
      +	git commit -m "add unmatched.txt" &&
      +
      +	echo "modified" >unmatched.txt &&
      +
     -+	rm -f backend.log &&
     ++	test_when_finished "rm -f backend.log" &&
      +	git -c diff.cdiff.process="$BACKEND --log=backend.log" \
      +		diff -- unmatched.txt >actual &&
      +	test_grep "modified" actual &&
      +	test_path_is_missing backend.log
      +'
      +
     -+test_expect_success PYTHON 'multiple drivers use separate processes' '
     ++test_expect_success 'multiple drivers use separate processes' '
      +	echo "*.h diff=hdiff" >>.gitattributes &&
      +	git add .gitattributes &&
      +
     @@ t/t4080-diff-process.sh (new)
      +	int header(void) { return 2; }
      +	EOF
      +
     -+	rm -f backend-c.log backend-h.log &&
     ++	test_when_finished "rm -f backend-c.log backend-h.log" &&
      +	git -c diff.cdiff.process="$BACKEND --log=backend-c.log" \
      +	    -c diff.hdiff.process="$BACKEND --log=backend-h.log" \
      +		diff -- newfile.c multi.h >actual 2>stderr &&
     @@ t/t4080-diff-process.sh (new)
      +	test_must_be_empty stderr
      +'
      +
     -+test_expect_success PYTHON 'diff process works alongside textconv' '
     ++test_expect_success 'diff process works alongside textconv' '
      +	write_script uppercase-filter <<-\EOF &&
      +	tr "a-z" "A-Z" <"$1"
      +	EOF
     @@ t/t4080-diff-process.sh (new)
      +	goodbye world
      +	EOF
      +
     -+	rm -f backend.log &&
     ++	test_when_finished "rm -f backend.log" &&
      +	git -c diff.cdiff.textconv="./uppercase-filter" \
      +	    -c diff.cdiff.process="$BACKEND --log=backend.log" \
      +		diff -- textconv.c >actual 2>stderr &&
     @@ t/t4080-diff-process.sh (new)
      +# Downstream features: word diff, log, equivalent files, exit code.
      +#
      +
     -+test_expect_success PYTHON 'diff process with --word-diff' '
     -+	rm -f backend.log &&
     ++test_expect_success 'diff process with --word-diff' '
     ++	test_when_finished "rm -f backend.log" &&
      +	git -c diff.cdiff.process="$BACKEND --log=backend.log" \
      +		diff --word-diff worddiff.c >actual 2>stderr &&
      +	test_grep "\[-1;-\]" actual &&
     @@ t/t4080-diff-process.sh (new)
      +	test_must_be_empty stderr
      +'
      +
     -+test_expect_success PYTHON 'diff process works with git log -p' '
     ++test_expect_success 'diff process works with git log -p' '
      +	# With no-hunks mode, the tool says the files are equivalent,
      +	# so log -p should show the commit but no diff content.
     -+	rm -f backend.log &&
     ++	test_when_finished "rm -f backend.log" &&
      +	git -c diff.cdiff.process="$BACKEND --mode=no-hunks --log=backend.log" \
      +		log -1 -p -- logtest.c >actual 2>stderr &&
      +	test_grep "change logtest.c" actual &&
     @@ t/t4080-diff-process.sh (new)
      +	test_must_be_empty stderr
      +'
      +
     -+test_expect_success PYTHON 'diff process no hunks suppresses diff output' '
     ++test_expect_success 'diff process no hunks suppresses diff output' '
      +	cat >nohunks.c <<-\EOF &&
      +	int zero(void) { return 0; }
      +	EOF
     @@ t/t4080-diff-process.sh (new)
      +	test_must_be_empty actual
      +'
      +
     -+test_expect_success PYTHON 'diff process no hunks with --exit-code returns success' '
     ++test_expect_success 'diff process no hunks with --exit-code returns success' '
      +	git -c diff.cdiff.process="$BACKEND --mode=no-hunks" \
      +		diff --exit-code nohunks.c
      +'
      +
     -+test_expect_success PYTHON 'diff process with --exit-code and hunks returns failure' '
     ++test_expect_success 'diff process with --exit-code and hunks returns failure' '
      +	test_expect_code 1 git -c diff.cdiff.process="$BACKEND" \
      +		diff --exit-code newfile.c
      +'
     @@ t/t4080-diff-process.sh (new)
      +# Bypass mechanisms: flags and commands that skip the diff process.
      +#
      +
     -+test_expect_success PYTHON 'diff process bypassed by --diff-algorithm' '
     -+	rm -f backend.log &&
     ++test_expect_success 'diff process bypassed by --diff-algorithm' '
     ++	test_when_finished "rm -f backend.log" &&
      +	git -c diff.cdiff.process="$BACKEND --log=backend.log" \
      +		diff --diff-algorithm=patience worddiff.c >actual &&
      +	test_grep "return 999" actual &&
      +	test_path_is_missing backend.log
      +'
      +
     -+test_expect_success PYTHON 'diff process not used by --stat' '
     -+	rm -f backend.log &&
     ++test_expect_success 'diff process not used by --stat' '
     ++	test_when_finished "rm -f backend.log" &&
      +	git -c diff.cdiff.process="$BACKEND --log=backend.log" \
      +		diff --stat worddiff.c >actual &&
      +	test_grep "worddiff.c" actual &&
     @@ t/t4080-diff-process.sh (new)
      +# Error handling and fallback.
      +#
      +
     -+test_expect_success PYTHON 'diff process fallback on tool error status' '
     -+	rm -f backend.log &&
     ++test_expect_success 'diff process fallback on tool error status' '
     ++	test_when_finished "rm -f backend.log" &&
      +	git -c diff.cdiff.process="$BACKEND --mode=error --log=backend.log" \
      +		diff boundary.c >actual 2>stderr &&
      +	# Fallback produces the full builtin diff (both change regions).
     @@ t/t4080-diff-process.sh (new)
      +	test_grep "diff process.*failed" stderr
      +'
      +
     -+test_expect_success PYTHON 'diff process error keeps tool available for next file' '
     -+	rm -f backend.log &&
     ++test_expect_success 'diff process error keeps tool available for next file' '
     ++	test_when_finished "rm -f backend.log" &&
      +	git -c diff.cdiff.process="$BACKEND --mode=error --log=backend.log" \
      +		diff -- one.c two.c >actual 2>stderr &&
      +	# Unlike abort, error keeps the tool available: both files
     @@ t/t4080-diff-process.sh (new)
      +	test_grep "pathname=one.c" backend.log &&
      +	test_grep "pathname=two.c" backend.log &&
      +	test_grep "return 10" actual &&
     -+	test_grep "return 20" actual
     ++	test_grep "return 20" actual &&
     ++	test_grep "diff process.*failed" stderr
      +'
      +
     -+test_expect_success PYTHON 'diff process abort disables for session' '
     -+	rm -f backend.log &&
     ++test_expect_success 'diff process abort disables for session' '
     ++	test_when_finished "rm -f backend.log" &&
      +	git -c diff.cdiff.process="$BACKEND --mode=abort --log=backend.log" \
     -+		diff -- one.c two.c >actual &&
     ++		diff -- one.c two.c >actual 2>stderr &&
      +	# Both files should still produce diff output via fallback.
      +	test_grep "return 10" actual &&
      +	test_grep "return 20" actual &&
      +	# The tool aborts on the first file and git clears its
      +	# capability.  The second file never contacts the tool.
      +	test_grep "pathname=one.c" backend.log &&
     -+	test_grep ! "pathname=two.c" backend.log
     ++	test_grep ! "pathname=two.c" backend.log &&
     ++	test_must_be_empty stderr
      +'
      +
     -+test_expect_success PYTHON 'diff process fallback on tool crash' '
     ++test_expect_success 'diff process fallback on tool crash' '
      +	git -c diff.cdiff.process="$BACKEND --mode=crash" \
      +		diff boundary.c >actual 2>stderr &&
      +	test_grep "^-OLD5" actual &&
     @@ t/t4080-diff-process.sh (new)
      +	test_grep "diff process.*failed" stderr
      +'
      +
     -+test_expect_success PYTHON 'diff process startup failure only warns once' '
     ++test_expect_success 'diff process startup failure only warns once' '
      +	git -c diff.cdiff.process="/nonexistent/tool" \
      +		diff -- one.c two.c >actual 2>stderr &&
      +	# Both files produce diff output via fallback.
     @@ t/t4080-diff-process.sh (new)
      +	test_line_count = 1 warnings
      +'
      +
     -+test_expect_success PYTHON 'diff process fallback on bad hunks' '
     ++
     ++test_expect_success 'diff process fallback on bad hunks' '
      +	git -c diff.cdiff.process="$BACKEND --mode=bad-hunk" \
      +		diff boundary.c >actual 2>stderr &&
      +	test_grep "^-OLD5" actual &&
      +	test_grep "^+NEW5" actual &&
      +	test_grep "^-OLD9" actual &&
      +	test_grep "^+NEW9" actual &&
     -+	# Invalid hunks are caught by xdiff validation, not the
     -+	# protocol layer, so no warning is emitted.
     -+	test_must_be_empty stderr
     ++	test_grep "exceeds.*lines" stderr
      +'
      +
     -+test_expect_success PYTHON 'diff process fallback on mismatched unchanged totals' '
     ++test_expect_success 'diff process fallback on mismatched unchanged totals' '
      +	cat >synctest.c <<-\EOF &&
      +	line1
      +	line2
     @@ t/t4080-diff-process.sh (new)
      +	# The synchronization invariant fails and git falls back.
      +	git -c diff.cdiff.process="$BACKEND --mode=bad-sync" \
      +		diff synctest.c >actual 2>stderr &&
     -+	test_grep "changed" actual
     ++	test_grep "changed" actual &&
     ++	test_grep "unchanged line count mismatch" stderr
      +'
      +
     -+test_expect_success PYTHON 'diff process fallback on overlapping hunks' '
     ++test_expect_success 'diff process fallback on overlapping hunks' '
      +	# boundary.c has 10 lines, so both hunks are in bounds
      +	# but they overlap at lines 3-5, triggering the ordering check.
      +	git -c diff.cdiff.process="$BACKEND --mode=overlap" \
      +		diff boundary.c >actual 2>stderr &&
     -+	test_grep "NEW5" actual
     ++	test_grep "NEW5" actual &&
     ++	test_grep "overlaps with previous" stderr
     ++'
     ++
     ++test_expect_success 'diff process fallback on malformed hunk line' '
     ++	git -c diff.cdiff.process="$BACKEND --mode=bad-parse" \
     ++		diff boundary.c >actual 2>stderr &&
     ++	test_grep "^-OLD5" actual &&
     ++	test_grep "^+NEW5" actual
     ++'
     ++
     ++test_expect_success 'diff process skipped when tool omits capability' '
     ++	git -c diff.cdiff.process="$BACKEND --mode=no-cap" \
     ++		diff boundary.c >actual 2>stderr &&
     ++	test_grep "^-OLD5" actual &&
     ++	test_grep "^+NEW5" actual &&
     ++	test_must_be_empty stderr
      +'
      +
      +test_done
 5:  f4fd9aa682 ! 5:  6ec6716ea4 diff: bypass diff process with --no-ext-diff and in format-patch
     @@ Commit message
          external tool.
      
          Document that --diff-algorithm also bypasses the diff process,
     -    since it sets ignore_driver_algorithm which diff_process_fill_hunks
     -    already checks.
     +    since it forces the builtin algorithm.
      
          Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
      
     @@ diff.h: struct diff_flags {
       	/**
      
       ## t/t4080-diff-process.sh ##
     -@@ t/t4080-diff-process.sh: test_expect_success PYTHON 'diff process bypassed by --diff-algorithm' '
     +@@ t/t4080-diff-process.sh: test_expect_success 'diff process bypassed by --diff-algorithm' '
       	test_path_is_missing backend.log
       '
       
     -+test_expect_success PYTHON 'diff process bypassed by --no-ext-diff' '
     -+	rm -f backend.log &&
     ++test_expect_success 'diff process bypassed by --no-ext-diff' '
     ++	test_when_finished "rm -f backend.log" &&
      +	git -c diff.cdiff.process="$BACKEND --log=backend.log" \
      +		diff --no-ext-diff worddiff.c >actual &&
      +	test_grep "return 999" actual &&
      +	test_path_is_missing backend.log
      +'
      +
     -+test_expect_success PYTHON 'diff process not used by format-patch' '
     -+	rm -f backend.log &&
     ++test_expect_success 'diff process not used by format-patch' '
     ++	test_when_finished "rm -f backend.log" &&
      +	git -c diff.cdiff.process="$BACKEND --log=backend.log" \
      +		format-patch -1 --stdout -- logtest.c >actual &&
      +	test_grep "return 2" actual &&
      +	test_path_is_missing backend.log
      +'
      +
     - test_expect_success PYTHON 'diff process not used by --stat' '
     - 	rm -f backend.log &&
     + test_expect_success 'diff process not used by --stat' '
     + 	test_when_finished "rm -f backend.log" &&
       	git -c diff.cdiff.process="$BACKEND --log=backend.log" \
 6:  370e766978 ! 6:  3dadafa1bc blame: consult diff process for no-hunk detection
     @@ Commit message
          The consultation happens at the pass_blame_to_parent() callsite
          using diff_process_fill_hunks(), matching how builtin_diff() in
          diff.c uses the same function.  A new diff_hunks_xpp() variant
     -    accepts a pre-populated xpparam_t for this callsite, while the
     -    existing diff_hunks() retains its original signature and behavior.
     -    The copy-detection callsite is unaffected since it does not use
     -    the diff process.
     +    accepts a pre-populated xpparam_t so callers can pass external
     +    hunks, while the existing diff_hunks() retains its original
     +    signature and behavior.  The copy-detection callsite is
     +    unaffected since it does not use the diff process.
      
          The subprocess is long-running (one startup cost amortized
          across the blame traversal), but each commit in the file's
     @@ blame.c: static void pass_blame_to_parent(struct blame_scoreboard *sb,
       		    parent, target, 0);
      
       ## t/t4080-diff-process.sh ##
     -@@ t/t4080-diff-process.sh: test_expect_success PYTHON 'diff process fallback on overlapping hunks' '
     - 	test_grep "NEW5" actual
     +@@ t/t4080-diff-process.sh: test_expect_success 'diff process skipped when tool omits capability' '
     + 	test_must_be_empty stderr
       '
       
      +#
      +# Blame integration.
      +#
      +
     -+test_expect_success PYTHON 'blame uses tool-provided hunks' '
     ++test_expect_success 'blame uses tool-provided hunks' '
      +	cat >blame-hunk.c <<-\EOF &&
      +	line1
      +	line2
     @@ t/t4080-diff-process.sh: test_expect_success PYTHON 'diff process fallback on ov
      +	test_grep "$CHANGE" line6
      +'
      +
     -+test_expect_success PYTHON 'blame skips commits with no hunks from diff process' '
     ++test_expect_success 'blame skips commits with no hunks from diff process' '
      +	cat >blame.c <<-\EOF &&
     -+	int main(void)
     -+	{
     -+	    return 0;
     ++	int main(void) {
     ++	return 0;
      +	}
      +	EOF
      +	git add blame.c &&
     @@ t/t4080-diff-process.sh: test_expect_success PYTHON 'diff process fallback on ov
      +	cat >blame.c <<-\EOF &&
      +	int main(void)
      +	{
     -+	        return 0;
     ++	return 0;
      +	}
      +	EOF
      +	git add blame.c &&
     @@ t/t4080-diff-process.sh: test_expect_success PYTHON 'diff process fallback on ov
      +	test_grep "$ORIG_COMMIT" with
      +'
      +
     -+test_expect_success PYTHON 'blame --no-ext-diff bypasses diff process' '
     -+	rm -f backend.log &&
     ++test_expect_success 'blame --no-ext-diff bypasses diff process' '
     ++	test_when_finished "rm -f backend.log" &&
      +	git -c diff.cdiff.process="$BACKEND --mode=no-hunks --log=backend.log" \
      +		blame --no-ext-diff blame.c >actual &&
      +	# Without the process, blame attributes the reformat commit normally.
     @@ t/t4080-diff-process.sh: test_expect_success PYTHON 'diff process fallback on ov
      +	test_path_is_missing backend.log
      +'
      +
     -+test_expect_success PYTHON 'blame --no-ext-diff uses builtin hunks' '
     ++test_expect_success 'blame --no-ext-diff uses builtin hunks' '
      +	# fixed-hunk mode would narrow blame to lines 5-6, but
      +	# --no-ext-diff should bypass it and use the builtin diff.
     -+	rm -f backend.log &&
     ++	test_when_finished "rm -f backend.log" &&
      +	git -c diff.cdiff.process="$BACKEND --mode=fixed-hunk --log=backend.log" \
      +		blame --no-ext-diff blame-hunk.c >actual &&
      +	# Builtin diff attributes lines 9-10 to the change commit.

-- 
gitgitgadget
