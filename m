Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3FB2459DD
	for <git@vger.kernel.org>; Thu, 28 May 2026 20:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780001271; cv=none; b=sKa2RIww39BXlrOBWasccFEw4z8ECCXy00ES25TsCBNLGrrIzTdoEelBhBA4jQ1uiSCJUuTpq8Fm4psEuEs76HtqQo2Hiweuvj2w/F0lQXOSMLd1ZILQadpYVVni1O0TzSOQElFH3Kaiq75MqEUllQ0xmbJCx9WVTSoyZnnSYD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780001271; c=relaxed/simple;
	bh=E097n59kmjeXknWjYsAf9qrLCq6tCuDpf8l43wS7BsY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=FEE6YK5YTCCofur0Yr83skhJ8U+my1aqOM05rMefvDoJxO3iC5gZS2RossdpFwE3c7NjUr/WCMqXAhslJFws2TfOySv5kB3BHYxgP1BFHyIEzV0OXnsLkbDQo7rESVeI8hu9oKyDef2rTOEv/4Q8djlyYUMsD+qnld+PEkdmLaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fsCN0h8G; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fsCN0h8G"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-902deb2412fso1477327385a.3
        for <git@vger.kernel.org>; Thu, 28 May 2026 13:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780001269; x=1780606069; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDomFfSn4hiqMg3VDGevOEQwmBr5/sapzanLgeJlBvs=;
        b=fsCN0h8GggUn6PRQincJ7lYhvJ0skDsBTMTkTWJ5tmpLRSGHusP3iMbm9Il+cJ9hOR
         yxBp13pZxpIDCHEfTVH7FL8tqOeVS7JKtDLxn46QRe6XlGFvbuQNaHWi47WouHDGK2f2
         YW++Oj3kzbP3PETkbb44llyO0uR+0nhIcW8OlVwSqO0e0wtj51T5ofEsYu11fEj2LXCY
         8dc+go7wIz8SVbswarK1IM2dvx8+VvO39hJpT2+I0x+jhRaMnWEV9EIej3adpHl2Z0dU
         E/Dw02HTsz5/yphm0WFgyEw/3XEhFNx+I/Kme9rWw28Kv6wvytIfTqZs3afLHhPv291O
         Gaew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780001269; x=1780606069;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eDomFfSn4hiqMg3VDGevOEQwmBr5/sapzanLgeJlBvs=;
        b=J6S/N5oh0uZpJbal757zODk+fqGPjwMfg3cxIKRpikApu5WCQNSZvAEcvBC8eN4Wbu
         zzMaXW6wpxe/09uG0ZQOAmPllFCUAnYybTPeijkRp+gLCsZnp6TDU0Y+0xOAiKjsQsYI
         KNkRMF7px/ccQAU66wHFMR1N3TblS9dXWc313MNlywGy9j6KT6R3xAkvqwfjSU+zOdZ6
         w0uYYfV2H6TZWZEqbhSGZuR+Xh5RoJnkgJjYYk2H2CdX5BAba0n/lUXaeBAckwAUQaJ2
         aagIxC4dvACyo/O/pi3fA2Vt4kicjW3NVBqJNIogdBmNVq/clCtniA5RtWeFPVbiUtiT
         fOmQ==
X-Gm-Message-State: AOJu0YxfiKvg/oTpEwju8us8LbC8GqHJ/mhnPUWyXmZZbtvjV+Cm2JIa
	7jE5qSs56QCjN0oexCGTBlhpBHa+PxrksG9oJOA6JIidxO5mUWSdUNWz9QOV/w==
X-Gm-Gg: Acq92OGeaNRedWS3i/HPLF2SAritrvm1b+8pt7k9tMBg3dfvJm2wfO8LB9gMxqsJ9Io
	kcjghf/+RnAauIgUALIDV8cmZYzCK4U5dvMTmnmjiZkr6Kl0ukH0EH9UKP72tAjR5mfBhuoQHV1
	NkSHrGPA0lrGKPqRQNZgtbsmJEBOsT6dNBXr70g6undLSvRyV+dc3xOAI9qhd2299r3QYQvsbVd
	hrBe2SGN/NjMaWQLXU9b8cTj2XbzpTWF6a0iaILvKmYxUDTSbbbkdw8o3XvDFUBToBghoepgPFq
	arpiBwn8ZdR+XdXDZSqgbTn27xcUE1dxTleZ0lSjrhXhpAM/pdj2F1XrM1JOrcqAvX+9PUFos1c
	ZwBDk+W6+1hp67krmQcNh7S47Zq6nBHKtQtmpufuYN3XiXkpv7h+57aT6IgA1LDOHM5yL2jjp6d
	LH+bVIwhK9v6bpUp9xRrQD7FJpglPL2MDtlvs=
X-Received: by 2002:a05:620a:2590:b0:911:ed:d285 with SMTP id af79cd13be357-9152cf94f12mr104678385a.62.1780001268400;
        Thu, 28 May 2026 13:47:48 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.87.177])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f881d91csm933144685a.44.2026.05.28.13.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 13:47:47 -0700 (PDT)
Message-Id: <pull.2094.v3.git.1780001267.gitgitgadget@gmail.com>
In-Reply-To: <pull.2094.v2.git.1779738059.gitgitgadget@gmail.com>
References: <pull.2094.v2.git.1779738059.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 28 May 2026 20:47:43 +0000
Subject: [PATCH v3 0/3] line-log: integrate -L with the standard log output pipeline
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

Changes since v2:

 * Switch "! test_grep" to "test_grep !" in tests.

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
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2094%2Fmmontalbo%2Fmm%2Fline-log-use-log-tree-diff-flush-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2094/mmontalbo/mm/line-log-use-log-tree-diff-flush-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2094

Range-diff vs v2:

 1:  9633eb62c6 = 1:  9633eb62c6 revision: move -L setup before output_format-to-diff derivation
 2:  7acfc5376e = 2:  7acfc5376e line-log: integrate -L output with the standard log-tree pipeline
 3:  10a3d8dde2 ! 3:  ae0b7f3ca8 line-log: allow non-patch diff formats with -L
     @@ t/t4211-line-log.sh: test_expect_success '-p shows the default patch output' '
      +test_expect_success '--raw shows mode, oid, status and path' '
      +	git log -L1,24:b.c --raw --format= >actual &&
      +	test_grep "^:100644 100644 [0-9a-f]\{7\} [0-9a-f]\{7\} M	b.c$" actual &&
     -+	! test_grep "^diff --git" actual &&
     -+	! test_grep "^@@" actual
     ++	test_grep ! "^diff --git" actual &&
     ++	test_grep ! "^@@" actual
      +'
      +
      +test_expect_success '--name-only shows path' '
      +	git log -L1,24:b.c --name-only --format= >actual &&
      +	test_grep "^b.c$" actual &&
     -+	! test_grep "^diff --git" actual &&
     -+	! test_grep "^@@" actual
     ++	test_grep ! "^diff --git" actual &&
     ++	test_grep ! "^@@" actual
      +'
      +
      +test_expect_success '--name-status shows status and path' '
      +	git log -L1,24:b.c --name-status --format= >actual &&
      +	test_grep "^M	b.c$" actual &&
     -+	! test_grep "^diff --git" actual &&
     -+	! test_grep "^@@" actual
     ++	test_grep ! "^diff --git" actual &&
     ++	test_grep ! "^@@" actual
      +'
      +
      +test_expect_success '--stat is not yet supported with -L' '

-- 
gitgitgadget
