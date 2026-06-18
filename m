Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB3F321F5F
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 18:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781806597; cv=none; b=cOQuGMtNKouYAXs2HEajlhTdKkXTa9VJ8vThTnx1xF9zva0nB4G8MvgwVCVN2tNsUpuUJI2yJVywbQwCObZJDY321yewgs+zW45ViS+QwTCioREnK7vYkAcn+fopz8slyytmtnjY5YqBD8QGvKE3WzbkbFX6LK3fqaX8iu2nkfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781806597; c=relaxed/simple;
	bh=RymIbmBPokZDF1T4BvA5bpegjB1yNRwWIGtML7zb0h8=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=G7D6C21VxqfLqnff02N7Id50dJh17MXfj2FdMlseh+X388/uVgJsEfU3OO22aWsYAc8OBHnk+j3BC3qB69YlrUnSvZhjCoqf3wND1tTrVHboQTClPZe4p5oWcdZT2ZQcW7aVAjo97TeXVfEP48XGtKHQRX2EL9mvmU2VbZ7oC4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bSuCdMjy; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSuCdMjy"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-915d17e2721so185661585a.3
        for <git@vger.kernel.org>; Thu, 18 Jun 2026 11:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781806595; x=1782411395; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ciq42Jz44m0TU9U9AkYtrXJXjvx1jvAWQAC7LsueuJc=;
        b=bSuCdMjymILyIAcD3ADsl970iuTHmSt6Mu+50djE1cVEe6Jo9bPwzFxOygir8stAHn
         YPBV31JOO3ilshRsrEcmuXXUabZVXtrNQWmx8fAC5fXgBN2AOYSdfraYu+db+3QNLH2Q
         1dApaLE7zP/YqTmsJbF3K9nutrz7LrnOtImdllWuz8whZLXQ7IL6g71hqRnUBLbN11RT
         VHITHSM5e/hAzwH8YfIe1rpSUBtGusqwEnO5N0AGoSKMP6GB9jFPILcraBj+5vM8fFFg
         H5B0KAtuEvkYvoc4mj3SWgnn7v8vbAC6jaUdqf8nfaRzw4o+kG8VORQ53CNrl/CPgo+g
         UOOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781806595; x=1782411395;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ciq42Jz44m0TU9U9AkYtrXJXjvx1jvAWQAC7LsueuJc=;
        b=Gcna5Mmj4YJgySPeh2V7V2V+U/qYqXuPQGgSlc6gHopxiABNkqxcIvFyTclxxQNl+5
         hlubDu2ETr3PzbthTbckN8sD1INBYIu49vFnUj6bCXokz7s5EnOfM42Mb32NfFt6RuTn
         tTi0uM2PsPp9cOH77LKCorApgijVjwNk2AK0RLiYsnVfhUVfddXsXKsMCBOp0uS1cKTy
         ggAI/1QmLpU03LCVCShwZyNRv4W/hKEej8M9P200feC1EgVlYIYEeJAeOwx1b8DjZDNk
         lobRocLx1ZgG+GhQ0uJplBrHF40MX+Rhjrhai6fgweJ4cNs3lw6yjHxlj+/WSLjf2Yz4
         hiHQ==
X-Gm-Message-State: AOJu0YyMnjZnz2pnL6zkqb91re/djMqtuzdtxAD/0eKtQ4k6oIAgkGfw
	aCaaomEXFBi1TCeDFMawKkrTJv5Zm1YVvOxUl1BpeL+OkRhkTnfAX3QmfK0gVQ==
X-Gm-Gg: AfdE7clp733Hu+KboBeVCFKpXBu6k8WjIWfHqaxzzpETZ+xqTNt9cUBRoOMn3kvHH3A
	WhER5qdTgzqDbzxx35OBJVqaqPpka5LzKH+XUP0e9nZYtA8SLYacJXqcw0yqPXcaKh314fQVVuB
	TieBTPPykVo42S12BdliLKOBng1D+6zpmUKceTJmArR/3lFvvSngqkECx6Ds/d10jVlg1ajMSOw
	UVjllURRVttnTNBIAzbfMOCbBDgx83ukJ3eLNv3lMsU1alcbhVZxopM3+he6WHROw3F3SzT4An+
	Nd1ralwQLKqXBEvYMQxuxRLmfIRNf34/QD2gQQQpwj6ppa9VdYGStX2xtff31hlGxBgqEX82Oey
	khP7Z9Y+cy5GOFgv79OYuEyt/iNlG4U/bkCyAwEixirS5VFSZZq+RAZcVNuQA0dDCJUAX0N4VPQ
	7xtJrPY8d4Rv/4vw==
X-Received: by 2002:a05:620a:43aa:b0:914:9ecb:9adb with SMTP id af79cd13be357-92092a3d365mr5728585a.50.1781806594903;
        Thu, 18 Jun 2026 11:16:34 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.177.0])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619ed8c83sm2087123885a.5.2026.06.18.11.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 11:16:34 -0700 (PDT)
Message-Id: <pull.2152.git.1781806593.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Jun 2026 18:16:25 +0000
Subject: [PATCH 0/7] line-log: range-scope stat, check, and -G under -L
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

This series extends git log -L so that more of its diff output and commit
selection honor the tracked line ranges: the diff stat formats and --check
are supported with range-scoped results, and the -G pickaxe is scoped to the
tracked range.

It builds on top of the mm/line-log-cleanup topic [1], which integrated -L
with the standard log output pipeline and taught it the non-patch formats
--raw, --name-only, --name-status, and --summary.

With these patches the following also honor the tracked range:

 * --stat, --numstat, --shortstat: counts cover only the lines inside the
   tracked range, not the whole file.

 * --check: whitespace errors are reported only for added lines inside the
   tracked range, with the correct file line numbers.

 * -G: a commit is selected only when the pattern appears on an
   added/removed line inside the tracked range, rather than anywhere in the
   file.

The --dirstat format is deliberately rejected. Its default mode reports each
directory's share of the total churn as a percentage, computed from
whole-file byte damage (via diffcore_count_changes(), outside the line-based
pipeline that -L scopes), so bare --dirstat cannot honor the tracked range.
The --dirstat=lines mode could: it aggregates the same per-file line counts
as --numstat, which -L already scopes. But supporting only that sub-mode
while bare --dirstat still errors is a confusing split, so the whole format
is left to a follow-up; --numstat already gives the exact range-scoped
per-file counts.

-S is left matching the whole file. Unlike -G, it counts needle occurrences
per blob rather than grepping the diff, so scoping it to a range needs a
different approach; that is left to a follow-up. Patch 7, which scopes -G,
also updates the -L documentation to note the -S/-G distinction, so the
whole-file behavior of -S is not mistaken for the range-scoped behavior
around it.

Patches 1-3 are independent of the new formats: they fix two bugs in the
existing -L patch output (a leaked deletion and an off-by-one hunk header),
bring its hunk headers in line with git diff's format, and clarify the
line-range filter mm/line-log-cleanup added, whose names obscured its model
(cryptic lno_ cursors conflating the pre/post-image and 0/1-based axes, a
flat hunk-state struct, and a one-letter state pointer (s)). The two bugs
may be a hint that the model could use clarification, so patch 1 renames and
groups the filter state and patch 2 documents the model, before the fixes
that read against it. Patches 4-7 then build the new formats on top:

 * Patch 1: rename and group the filter for clarity. Spell the cryptic names
   out to the file's own forms: the line-number cursors to
   lno_in_preimage/lno_in_postimage (as in struct emit_callback) and the
   range index to idx_in_postimage, while the hunk geometry stays old/new
   (the xdiff_emit_hunk_fn convention) and moves into a sub-struct. Name the
   filter pointer (filter) and rename the struct to line_range_filter and
   the flush helper to flush_range_hunk. No behavior change.

 * Patch 2: simplify the filter by classifying removals as they arrive,
   dropping the pending_rm buffer and a latent flush_range_hunk() bug that
   leaked deletions just past the range. Make the buffered lines the hunk's
   single source of truth: flush_range_hunk() derives the counts from them
   rather than tracking them per line, dropping three more fields. Document
   the model with a block comment and worked example, and add
   begin_range_hunk() as the counterpart to flush_range_hunk(). (This
   simplification was submitted by itself previously [2] but did not
   advance, so it is re-included here.)

 * Patch 3: stop hand-rolling the synthetic hunk header and emit it through
   xdiff's own formatter via a new xdiff_emit_hunk_header() helper. The
   hand-rolled code put a count-0 side's begin one too high (the convention
   is the line before the change); routing through xdl_emit_hunk_hdr() fixes
   that by construction and, as a side effect, makes -L headers match git
   diff exactly, including its omission of a count of 1. Regenerate the two
   affected fixtures.

 * Patch 4: extract a line_range_filter_diff() helper that folds the
   filter's two preconditions into one place: inflate ctxlen to the largest
   range span so every change within a range lands in a single xdiff hunk,
   and clear XDL_EMIT_NO_HUNK_HDR so the hunk headers the filter reads are
   always emitted (its position tracking relies on both). It then runs an
   initialized filter through xdiff, flushes the final range hunk, and
   releases it; use it in builtin_diff(). The stat, check, and -G patches
   that reuse it inherit both.

 * Patch 5: reuse the filter in builtin_diffstat() for the stat formats,
   extend the -L output-format allowlist, and reject --dirstat.

 * Patch 6: reuse the filter in builtin_checkdiff() and extend the allowlist
   for --check. The separate blank-at-eof pass scans the whole file, so
   scope its report to the tracked ranges too.

 * Patch 7: scope -G to the tracked range. Expose the filter as
   diff_emit_line_ranges() and grep only the tracked range's lines,
   threading the filepair's line_ranges through the pickaxe callback. -S is
   left whole-file, and the -L documentation is updated to note that -G is
   range-scoped while -S still matches the whole file.

[1]
https://lore.kernel.org/git/pull.2094.v3.git.1780001267.gitgitgadget@gmail.com/
[2]
https://lore.kernel.org/git/pull.2099.git.1777230630020.gitgitgadget@gmail.com/

Michael Montalbo (7):
  diff: rename and group the line-range filter for clarity
  diff: simplify the line-range filter by classifying removals
    immediately
  diff: emit -L hunk headers via xdiff's formatter
  diff: extract a line-range diff helper for reuse
  line-log: support diff stat formats with -L
  diff: support --check with -L line ranges
  diffcore-pickaxe: scope -G to the -L tracked range

 Documentation/line-range-options.adoc    |  17 +-
 diff.c                                   | 491 ++++++++++++++---------
 diffcore-pickaxe.c                       |  37 +-
 revision.c                               |   6 +-
 t/t4211-line-log.sh                      | 439 +++++++++++++++++++-
 t/t4211/sha1/expect.no-assertion-error   |   2 +-
 t/t4211/sha1/expect.vanishes-early       |   6 +-
 t/t4211/sha256/expect.no-assertion-error |   2 +-
 t/t4211/sha256/expect.vanishes-early     |   6 +-
 xdiff-interface.c                        |  19 +
 xdiff-interface.h                        |  28 ++
 11 files changed, 826 insertions(+), 227 deletions(-)


base-commit: ea97ad8d017de0c9037451a78008a0fd60abea0c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2152%2Fmmontalbo%2Fmm%2Fline-log-stat-formats-followup-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2152/mmontalbo/mm/line-log-stat-formats-followup-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2152
-- 
gitgitgadget
