Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB3B14E2F2
	for <git@vger.kernel.org>; Sat, 13 Jun 2026 04:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781323587; cv=none; b=UzgxIdMs2wwt3Q2NXngGvuU3vqnzgE/QtW93SmJY8LoWj/zG7QKgL7XfziOyE7u5wDiJF2WXJivJa07Ymo9TsMCLSFOc7SsEgCA1yj+ZiwxPAZKzLt6FO88PXDutKEM5D0BiPkwutC17f4Lj8vLuTauUrSfOGd4Me+QYDR2n9I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781323587; c=relaxed/simple;
	bh=Iy1kYXuoP8M632JFsxtg7zuxnyNW6o1B+DaiuvStTb8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gm4+RvUKBXSvJc13cUlXxvcbTqAOqFvqwS2b23gW/nswjAD8baEWsdeAPghN/HtVIn0/ipzLBD4AWsLo08n8wMq+gZrP1Q058e6XVjZpr1bVj6hQL5IOx4i/wGFE5J6m9rMrgM0LrnScVEWEPi7gtAqgeQRXu51QbHRwTHgBz0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DBA768cz; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBA768cz"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-304e83724bfso2525485eec.0
        for <git@vger.kernel.org>; Fri, 12 Jun 2026 21:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781323580; x=1781928380; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RHE8k9Q18kypy7c/meL7FVO8p/nNI3W7bcob2tSt0qc=;
        b=DBA768czpSSwsZqXrEyIn7WlNpuEe5SOalPtDyqL70cthO+7Ia27LWjFLIbB8z0fdl
         FcZOhbe0gkt8j+rxeLp39eA/+rU5n8tMEm+0mGOmhZeqn5Y+U6Pqi/r5K1e9tU6C5KaX
         VMst91ubPnD5NyILBEOA2bJFM+fOelSAjl1SW7lmMxMNAbxylMp4sDS6nTInSoPl+Kzo
         OUWNNWYAlAp0aajkTVPBUT5eeJAa27e/2gFzS6VJou05kpajr1jkjEJei3vK0qVclCU4
         7qSS1qOqLpI3Zedk2p7+1MgzrJPLTHeYQi9wMVkcOnpXfhNX/qUcr6CZP1W1eNEHA504
         3FDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781323580; x=1781928380;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RHE8k9Q18kypy7c/meL7FVO8p/nNI3W7bcob2tSt0qc=;
        b=U1l2x6ynMGIzyWKvungk0VNewEQ7U6eOuCmWyCBoGgVk92dq9VZ8lJRhhXb5f2BUeh
         kxX7q5KgKGCPbqhWCuuCuCbHWKM6kiz9lFlbYYXYS7KkySjwK7rOiwWdN2X1ogCw+sdT
         ISHqpwd0t9UPqYgVJlOW5563HaxbOIYQ4Tsv011YFlwyyCKdX6itqrJXS7qDLc/qxVNk
         ertWPiO2JSi/DWQGXPRCBp7cg7d8fBamx64RIyrlNtrM26Cd05FZyKgSf9NzFo+58ZZD
         FKYq59HYd2cA6VV4Zj9HFHn0xkP6hlrNwaU1oN6F6hRUgi4DlQjrVeLXZI/PR6CY+61H
         LWYg==
X-Gm-Message-State: AOJu0YxS6h8vzRgCzeExjcncn2ROQQAw6aHw1TWomDF5PR1BFNsKjpNZ
	iddcyxrENk+WP1E0oR2krtHpNcfi2y2oM700tEsVmvjQc9BRcfGgKVK4SxqLYg==
X-Gm-Gg: Acq92OELuv3Wtty3IrF6JzmkYbM3jlIyx4nZbk8AAtAMh1UKHmAtZtN4bGI97DrXHlH
	lKF57l2lOJW+6NOVVMbpqPUV0be6aJSAXSrq8POQA6NcnBe+/xynN/1yrGvGhwDTVYRY7SHV0E0
	yPCh8Cjw0KLzFuJ8/twioTyEC1z4+yw7TE6L/So4QO+HmfmLw/VyxwXesEhvXaQ9eGZlj2s+rUi
	tL0VCc757CF/JPTor1zCD6EWk7yOQ5hmcysT82MuLti0ugNwDLQiQLSPh+9S4jV87cHd5tJKlAA
	yklnBTRoAP6r4cu2uORPzv83OQSQO56CQUyC1PZN8AceXqPpKsJB0Grkplwl3uXaAHoOfABuLLr
	8ixRmnF0bhlo3FXHzjZA19F3CPQiA+Dr12+XRUex/TFGKLsivdpUcgV1PHd5Jf7/bRbOrT2Sl7L
	rwp+qF6XLxMBwMuV7Qzhf1AaL4
X-Received: by 2002:a05:7300:8181:b0:304:cefc:5fd7 with SMTP id 5a478bee46e88-308200c58e0mr3255012eec.32.1781323578278;
        Fri, 12 Jun 2026 21:06:18 -0700 (PDT)
Received: from [127.0.0.1] ([40.65.56.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081ddaf69asm6539066eec.0.2026.06.12.21.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 21:06:17 -0700 (PDT)
Message-Id: <pull.2135.v2.git.1781323575.gitgitgadget@gmail.com>
In-Reply-To: <pull.2135.git.1780559158.gitgitgadget@gmail.com>
References: <pull.2135.git.1780559158.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 13 Jun 2026 04:06:09 +0000
Subject: [PATCH v2 0/6] t: add greplint.pl and convert grep to test_grep
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
    Eric Sunshine <sunshine@sunshineco.com>,
    Michael Montalbo <mmontalbo@gmail.com>

test_grep is a wrapper around grep for test assertions that prints the file
contents on failure for easier debugging. Bare grep fails silently, making
it hard to diagnose what went wrong.

This series converts existing bare grep assertions to test_grep and adds
greplint.pl to prevent new ones from being introduced.

Patch 1 documents test_grep in t/README.

Patch 2 fixes three greps missing file arguments (t2402, t7507, t7700). They
were reading empty stdin and passing vacuously.

Patch 3 extracts chainlint's Lexer, ShellParser, and ScriptParser into a
shared module (lib-shell-parser.pl) so greplint.pl can reuse the same
tokenizer. No functional change to chainlint.

Patch 4 fixes a latent line-counting bug in scan_dqstring where newlines
from $() bodies inside double-quoted strings were counted twice. This does
not affect chainlint (which uses byte offsets) but matters for greplint.pl's
line-number reporting.

Patch 5 converts existing assertion greps to test_grep, including sourced
test helpers. Greps used as data filters or on files that may not exist are
left unconverted with lint-ok annotations.

Patch 6 adds greplint.pl with test fixtures (modeled on chainlint/) and
wires it into the Makefile as test-greplint and check-greplint.

Changes since v1:

 * Dropped lint-style.pl and the --fix mode concept. Replaced with
   greplint.pl, which more closely follows chainlint's conventions, and
   reuses its parser logic via a shared module.

 * A regex approach to grep linting was prototyped in an attempt to reduce
   the number of patches in the series, but this approach produced false
   positives from grep inside heredoc bodies (e.g. write_script) and
   cross-line pipelines where the pipe or redirect is on a different line
   from the grep. The shared module's Lexer already collapses these into
   single tokens, giving zero false positives with less code than the regex
   heuristics would need, which is why it was retained in the current
   version.

 * Reverted incorrect conversions where grep was used as a data filter
   inside redirected compound commands, not as a test assertion.

Known limitation / follow-up:

 * Assertions like grep pattern file >/dev/null and grep pattern <file are
   not converted because greplint.pl treats any redirect as a filter. The
   former is ambiguous because >/dev/null becomes dead code under test_grep
   (which already suppresses matching-line output). The latter requires
   removing the redirect and passing the file as a positional argument,
   since test_grep does not support stdin redirects. Both are left as bare
   grep. A follow-up series can address these once a convention is
   established.

Michael Montalbo (6):
  t/README: document test_grep helper
  t: fix grep assertions missing file arguments
  t: extract chainlint's parser into shared module
  t: fix Lexer line count for $() inside double-quoted strings
  t: convert grep assertions to test_grep
  t: add greplint to detect bare grep assertions

 t/.gitattributes                              |   2 +
 t/Makefile                                    |  29 +-
 t/README                                      |  21 +
 t/chainlint.pl                                | 529 +----------------
 t/for-each-ref-tests.sh                       |  12 +-
 t/greplint-cat.pl                             |  27 +
 t/greplint.pl                                 | 241 ++++++++
 t/greplint/bare-grep-after-and.expect         |   1 +
 t/greplint/bare-grep-after-and.test           |   4 +
 t/greplint/bare-grep-after-semicolon.expect   |   1 +
 t/greplint/bare-grep-after-semicolon.test     |   4 +
 t/greplint/bare-grep-compound-body.expect     |   3 +
 t/greplint/bare-grep-compound-body.test       |  17 +
 t/greplint/bare-grep-count-mode.expect        |   1 +
 t/greplint/bare-grep-count-mode.test          |   3 +
 t/greplint/bare-grep-explicit-pattern.expect  |   1 +
 t/greplint/bare-grep-explicit-pattern.test    |   3 +
 t/greplint/bare-grep-flags.expect             |   1 +
 t/greplint/bare-grep-flags.test               |   3 +
 t/greplint/bare-grep-lint-ok.expect           |   0
 t/greplint/bare-grep-lint-ok.test             |   4 +
 t/greplint/bare-grep-negated.expect           |   1 +
 t/greplint/bare-grep-negated.test             |   3 +
 t/greplint/bare-grep-pattern-file.expect      |   1 +
 t/greplint/bare-grep-pattern-file.test        |   3 +
 t/greplint/bare-grep-simple.expect            |   1 +
 t/greplint/bare-grep-simple.test              |   3 +
 t/greplint/bare-grep-subshell.expect          |   1 +
 t/greplint/bare-grep-subshell.test            |   5 +
 .../dqstring-continuation-offset.expect       |   1 +
 t/greplint/dqstring-continuation-offset.test  |  11 +
 t/greplint/filter-command-substitution.expect |   0
 t/greplint/filter-command-substitution.test   |   3 +
 t/greplint/filter-pipe-input.expect           |   0
 t/greplint/filter-pipe-input.test             |   3 +
 t/greplint/filter-pipe-output.expect          |   0
 t/greplint/filter-pipe-output.test            |   3 +
 t/greplint/filter-redirect-output.expect      |   0
 t/greplint/filter-redirect-output.test        |   3 +
 t/greplint/filter-stdin-redirect.expect       |   0
 t/greplint/filter-stdin-redirect.test         |   3 +
 t/greplint/grep-as-argument.expect            |   0
 t/greplint/grep-as-argument.test              |   3 +
 t/greplint/grep-as-value.expect               |   0
 t/greplint/grep-as-value.test                 |   6 +
 t/greplint/wrong-negation.expect              |   1 +
 t/greplint/wrong-negation.test                |   3 +
 t/lib-bitmap.sh                               |  12 +-
 t/lib-bundle-uri-protocol.sh                  |  26 +-
 t/lib-httpd.sh                                |   2 +-
 t/lib-shell-parser.pl                         | 534 ++++++++++++++++++
 t/pack-refs-tests.sh                          |   2 +-
 t/show-ref-exists-tests.sh                    |   2 +-
 t/t0000-basic.sh                              |  16 +-
 t/t0001-init.sh                               |  18 +-
 t/t0008-ignores.sh                            |   8 +-
 t/t0009-git-dir-validation.sh                 |   6 +-
 t/t0012-help.sh                               |   4 +-
 t/t0013-sha1dc.sh                             |   2 +-
 t/t0017-env-helper.sh                         |   4 +-
 t/t0021-conversion.sh                         |  18 +-
 t/t0029-core-unsetenvvars.sh                  |   4 +-
 t/t0030-stripspace.sh                         |   4 +-
 t/t0031-lockfile-pid.sh                       |   2 +-
 t/t0040-parse-options.sh                      |  52 +-
 t/t0041-usage.sh                              |   2 +-
 t/t0052-simple-ipc.sh                         |  10 +-
 t/t0061-run-command.sh                        |   2 +-
 t/t0066-dir-iterator.sh                       |   2 +-
 t/t0068-for-each-repo.sh                      |  16 +-
 t/t0070-fundamental.sh                        |   6 +-
 t/t0081-find-pack.sh                          |  12 +-
 t/t0091-bugreport.sh                          |  18 +-
 t/t0092-diagnose.sh                           |  12 +-
 t/t0100-previous.sh                           |   2 +-
 t/t0200-gettext-basic.sh                      |  14 +-
 t/t0203-gettext-setlocale-sanity.sh           |   4 +-
 t/t0204-gettext-reencode-sanity.sh            |   8 +-
 t/t0210-trace2-normal.sh                      |   6 +-
 t/t0211-trace2-perf.sh                        |  80 +--
 t/t0212-trace2-event.sh                       |   8 +-
 t/t0300-credentials.sh                        |   4 +-
 t/t0410-partial-clone.sh                      |  82 +--
 t/t0450-txt-doc-vs-help.sh                    |   2 +-
 t/t0500-progress-display.sh                   |  18 +-
 t/t0610-reftable-basics.sh                    |   8 +-
 t/t1004-read-tree-m-u-wf.sh                   |   8 +-
 t/t1006-cat-file.sh                           |  18 +-
 t/t1007-hash-object.sh                        |   8 +-
 t/t1011-read-tree-sparse-checkout.sh          |  10 +-
 t/t1050-large.sh                              |   6 +-
 t/t1091-sparse-checkout-builtin.sh            |  24 +-
 t/t1092-sparse-checkout-compatibility.sh      |  44 +-
 t/t1300-config.sh                             |  16 +-
 t/t1305-config-include.sh                     |   2 +-
 t/t1308-config-set.sh                         |   6 +-
 t/t1400-update-ref.sh                         | 170 +++---
 t/t1403-show-ref.sh                           |  18 +-
 t/t1410-reflog.sh                             |   4 +-
 t/t1415-worktree-refs.sh                      |   4 +-
 t/t1430-bad-ref-name.sh                       |  56 +-
 t/t1450-fsck.sh                               |  12 +-
 t/t1451-fsck-buffer.sh                        |   6 +-
 t/t1460-refs-migrate.sh                       |   2 +-
 t/t1500-rev-parse.sh                          |   6 +-
 t/t1502-rev-parse-parseopt.sh                 |   2 +-
 t/t1503-rev-parse-verify.sh                   |  10 +-
 t/t1510-repo-setup.sh                         |  10 +-
 t/t1512-rev-parse-disambiguation.sh           |   4 +-
 t/t1515-rev-parse-outside-repo.sh             |   2 +-
 t/t1800-hook.sh                               |  18 +-
 t/t2004-checkout-cache-temp.sh                |   4 +-
 t/t2019-checkout-ambiguous-ref.sh             |   4 +-
 t/t2024-checkout-dwim.sh                      |   8 +-
 t/t2030-unresolve-info.sh                     |   6 +-
 t/t2060-switch.sh                             |   6 +-
 t/t2070-restore.sh                            |   2 +-
 t/t2080-parallel-checkout-basics.sh           |  14 +-
 t/t2081-parallel-checkout-collisions.sh       |  24 +-
 t/t2082-parallel-checkout-attributes.sh       |  12 +-
 t/t2103-update-index-ignore-missing.sh        |   6 +-
 t/t2200-add-update.sh                         |   2 +-
 t/t2203-add-intent.sh                         |   6 +-
 t/t2400-worktree-add.sh                       |  24 +-
 t/t2402-worktree-list.sh                      |  16 +-
 t/t2403-worktree-move.sh                      |   6 +-
 t/t2405-worktree-submodule.sh                 |   6 +-
 t/t2407-worktree-heads.sh                     |  26 +-
 t/t2500-untracked-overwriting.sh              |   8 +-
 t/t2501-cwd-empty.sh                          |   4 +-
 t/t3001-ls-files-others-exclude.sh            |   6 +-
 t/t3007-ls-files-recurse-submodules.sh        |   6 +-
 t/t3200-branch.sh                             |  12 +-
 t/t3202-show-branch.sh                        |  10 +-
 t/t3203-branch-output.sh                      |   4 +-
 t/t3206-range-diff.sh                         |  78 +--
 t/t3207-branch-submodule.sh                   |   4 +-
 t/t3301-notes.sh                              |  32 +-
 t/t3310-notes-merge-manual-resolve.sh         |  16 +-
 t/t3320-notes-merge-worktrees.sh              |   2 +-
 t/t3400-rebase.sh                             |  16 +-
 t/t3402-rebase-merge.sh                       |  16 +-
 t/t3404-rebase-interactive.sh                 |  72 +--
 t/t3406-rebase-message.sh                     |   6 +-
 t/t3415-rebase-autosquash.sh                  |  10 +-
 t/t3416-rebase-onto-threedots.sh              |   4 +-
 t/t3418-rebase-continue.sh                    |  10 +-
 t/t3420-rebase-autostash.sh                   |  26 +-
 t/t3422-rebase-incompatible-options.sh        |   4 +-
 t/t3429-rebase-edit-todo.sh                   |   2 +-
 t/t3430-rebase-merges.sh                      |  32 +-
 t/t3500-cherry.sh                             |   4 +-
 t/t3501-revert-cherry-pick.sh                 |   6 +-
 t/t3504-cherry-pick-rerere.sh                 |   6 +-
 t/t3510-cherry-pick-sequence.sh               |  24 +-
 t/t3602-rm-sparse-checkout.sh                 |   4 +-
 t/t3705-add-sparse-checkout.sh                |  10 +-
 t/t3800-mktag.sh                              |   4 +-
 t/t3901-i18n-patch.sh                         |  16 +-
 t/t3903-stash.sh                              |  28 +-
 t/t3904-stash-patch.sh                        |   4 +-
 t/t3908-stash-in-worktree.sh                  |   2 +-
 t/t4000-diff-format.sh                        |   2 +-
 t/t4001-diff-rename.sh                        |   4 +-
 t/t4011-diff-symlink.sh                       |   2 +-
 t/t4013-diff-various.sh                       |   2 +-
 t/t4014-format-patch.sh                       | 344 +++++------
 t/t4015-diff-whitespace.sh                    |  16 +-
 t/t4017-diff-retval.sh                        |   2 +-
 t/t4018-diff-funcname.sh                      |   2 +-
 t/t4019-diff-wserror.sh                       |   8 +-
 t/t4020-diff-external.sh                      |  18 +-
 t/t4021-format-patch-numbered.sh              |   4 +-
 t/t4022-diff-rewrite.sh                       |  14 +-
 t/t4028-format-patch-mime-headers.sh          |   6 +-
 t/t4031-diff-rewrite-binary.sh                |  18 +-
 t/t4033-diff-patience.sh                      |   2 +-
 t/t4036-format-patch-signer-mime.sh           |   6 +-
 t/t4038-diff-combined.sh                      |   6 +-
 t/t4051-diff-function-context.sh              |  38 +-
 t/t4053-diff-no-index.sh                      |   4 +-
 t/t4063-diff-blobs.sh                         |   2 +-
 t/t4065-diff-anchored.sh                      |  26 +-
 t/t4067-diff-partial-clone.sh                 |  12 +-
 t/t4073-diff-stat-name-width.sh               |  24 +-
 t/t4103-apply-binary.sh                       |   2 +-
 t/t4120-apply-popt.sh                         |   2 +-
 t/t4124-apply-ws-rule.sh                      |  10 +-
 t/t4128-apply-root.sh                         |   2 +-
 t/t4140-apply-ita.sh                          |   4 +-
 t/t4141-apply-too-large.sh                    |   2 +-
 t/t4150-am.sh                                 |  48 +-
 t/t4200-rerere.sh                             |   6 +-
 t/t4201-shortlog.sh                           |   2 +-
 t/t4202-log.sh                                |  84 +--
 t/t4204-patch-id.sh                           |   2 +-
 t/t4205-log-pretty-formats.sh                 |   2 +-
 t/t4209-log-pickaxe.sh                        |  10 +-
 t/t4211-line-log.sh                           |  72 +--
 t/t4216-log-bloom.sh                          |  18 +-
 t/t4252-am-options.sh                         |  22 +-
 t/t4254-am-corrupt.sh                         |   6 +-
 t/t4258-am-quoted-cr.sh                       |   2 +-
 t/t4301-merge-tree-write-tree.sh              |  18 +-
 t/t5000-tar-tree.sh                           |  10 +-
 t/t5004-archive-corner-cases.sh               |   2 +-
 t/t5100-mailinfo.sh                           |   2 +-
 t/t5150-request-pull.sh                       |  18 +-
 t/t5300-pack-object.sh                        |  22 +-
 t/t5302-pack-index.sh                         |   6 +-
 t/t5304-prune.sh                              |   8 +-
 t/t5310-pack-bitmaps.sh                       |  14 +-
 t/t5317-pack-objects-filter-objects.sh        |  12 +-
 t/t5318-commit-graph.sh                       |   8 +-
 t/t5319-multi-pack-index.sh                   |  16 +-
 t/t5324-split-commit-graph.sh                 |  10 +-
 t/t5325-reverse-index.sh                      |   2 +-
 t/t5326-multi-pack-bitmaps.sh                 |  28 +-
 t/t5328-commit-graph-64bit-time.sh            |   2 +-
 t/t5329-pack-objects-cruft.sh                 |   8 +-
 t/t5334-incremental-multi-pack-index.sh       |   2 +-
 t/t5335-compact-multi-pack-index.sh           |   4 +-
 t/t5351-unpack-large-objects.sh               |   2 +-
 t/t5402-post-merge-hook.sh                    |   4 +-
 t/t5403-post-checkout-hook.sh                 |   2 +-
 t/t5404-tracking-branches.sh                  |   2 +-
 t/t5406-remote-rejects.sh                     |   2 +-
 t/t5407-post-rewrite-hook.sh                  |   8 +-
 t/t5409-colorize-remote-messages.sh           |  36 +-
 t/t5500-fetch-pack.sh                         |  38 +-
 t/t5504-fetch-receive-strict.sh               |  14 +-
 t/t5505-remote.sh                             |  20 +-
 t/t5510-fetch.sh                              |  10 +-
 t/t5512-ls-remote.sh                          |   8 +-
 t/t5514-fetch-multiple.sh                     |   2 +-
 t/t5516-fetch-push.sh                         |  20 +-
 t/t5520-pull.sh                               |   4 +-
 t/t5524-pull-msg.sh                           |   6 +-
 t/t5526-fetch-submodules.sh                   |  16 +-
 t/t5529-push-errors.sh                        |   4 +-
 t/t5530-upload-pack-error.sh                  |  18 +-
 t/t5531-deep-submodule-push.sh                |   2 +-
 t/t5532-fetch-proxy.sh                        |   2 +-
 t/t5533-push-cas.sh                           |  12 +-
 t/t5534-push-signed.sh                        |  22 +-
 t/t5537-fetch-shallow.sh                      |   2 +-
 t/t5538-push-shallow.sh                       |   2 +-
 t/t5539-fetch-http-shallow.sh                 |   4 +-
 t/t5541-http-push-smart.sh                    |  32 +-
 t/t5544-pack-objects-hook.sh                  |  12 +-
 t/t5550-http-fetch-dumb.sh                    |   4 +-
 t/t5551-http-fetch-smart.sh                   |  46 +-
 t/t5552-skipping-fetch-negotiator.sh          |   6 +-
 t/t5554-noop-fetch-negotiator.sh              |   4 +-
 t/t5557-http-get.sh                           |   2 +-
 t/t5558-clone-bundle-uri.sh                   |  38 +-
 t/t5562-http-backend-content-length.sh        |   2 +-
 t/t5564-http-proxy.sh                         |  10 +-
 t/t5581-http-curl-verbose.sh                  |   2 +-
 t/t5583-push-branches.sh                      |   8 +-
 t/t5601-clone.sh                              |  28 +-
 t/t5604-clone-reference.sh                    |   8 +-
 t/t5605-clone-local.sh                        |   2 +-
 t/t5606-clone-options.sh                      |   6 +-
 t/t5612-clone-refspec.sh                      |   2 +-
 t/t5616-partial-clone.sh                      |  60 +-
 t/t5619-clone-local-ambiguous-transport.sh    |   2 +-
 t/t5620-backfill.sh                           |  12 +-
 t/t5700-protocol-v1.sh                        |  46 +-
 t/t5701-git-serve.sh                          |  14 +-
 t/t5702-protocol-v2.sh                        | 154 ++---
 t/t5703-upload-pack-ref-in-want.sh            |  22 +-
 t/t5705-session-id-in-capabilities.sh         |  12 +-
 t/t5750-bundle-uri-parse.sh                   |   8 +-
 t/t5801-remote-helpers.sh                     |   4 +-
 t/t5810-proto-disable-local.sh                |   2 +-
 t/t5813-proto-disable-ssh.sh                  |   4 +-
 t/t6000-rev-list-misc.sh                      |  26 +-
 t/t6005-rev-list-count.sh                     |   8 +-
 t/t6006-rev-list-format.sh                    |   4 +-
 t/t6009-rev-list-parent.sh                    |   4 +-
 t/t6020-bundle-misc.sh                        |  12 +-
 t/t6022-rev-list-missing.sh                   |   4 +-
 t/t6030-bisect-porcelain.sh                   | 150 ++---
 t/t6040-tracking-info.sh                      |   2 +-
 t/t6112-rev-list-filters-objects.sh           |  24 +-
 t/t6115-rev-list-du.sh                        |   4 +-
 t/t6120-describe.sh                           |  14 +-
 t/t6200-fmt-merge-msg.sh                      |  82 +--
 t/t6402-merge-rename.sh                       |   4 +-
 t/t6403-merge-file.sh                         |   6 +-
 t/t6404-recursive-merge.sh                    |   2 +-
 t/t6406-merge-attr.sh                         |  20 +-
 t/t6417-merge-ours-theirs.sh                  |  30 +-
 t/t6418-merge-text-auto.sh                    |   2 +-
 t/t6422-merge-rename-corner-cases.sh          |   8 +-
 t/t6423-merge-rename-directories.sh           |  72 +--
 t/t6424-merge-unrelated-index-changes.sh      |   6 +-
 t/t6427-diff3-conflict-markers.sh             |  10 +-
 t/t6432-merge-recursive-space-options.sh      |   4 +-
 t/t6436-merge-overwrite.sh                    |   6 +-
 t/t6437-submodule-merge.sh                    |  10 +-
 t/t6500-gc.sh                                 |   8 +-
 t/t6600-test-reach.sh                         |   4 +-
 t/t7001-mv.sh                                 |  16 +-
 t/t7002-mv-sparse-checkout.sh                 |  38 +-
 t/t7003-filter-branch.sh                      |  16 +-
 t/t7004-tag.sh                                |   2 +-
 t/t7006-pager.sh                              |  16 +-
 t/t7012-skip-worktree-writing.sh              |   6 +-
 t/t7030-verify-tag.sh                         |  52 +-
 t/t7031-verify-tag-signed-ssh.sh              |  46 +-
 t/t7102-reset.sh                              |   2 +-
 t/t7110-reset-merge.sh                        |  40 +-
 t/t7201-co.sh                                 |   6 +-
 t/t7300-clean.sh                              |   2 +-
 t/t7301-clean-interactive.sh                  |   2 +-
 t/t7400-submodule-basic.sh                    |  32 +-
 t/t7402-submodule-rebase.sh                   |   2 +-
 t/t7406-submodule-update.sh                   |  26 +-
 t/t7416-submodule-dash-url.sh                 |  20 +-
 t/t7417-submodule-path-url.sh                 |   2 +-
 t/t7450-bad-git-dotfiles.sh                   |  14 +-
 t/t7501-commit-basic-functionality.sh         |  16 +-
 t/t7502-commit-porcelain.sh                   |   2 +-
 t/t7507-commit-verbose.sh                     |   6 +-
 t/t7508-status.sh                             |   6 +-
 t/t7510-signed-commit.sh                      |  68 +--
 t/t7516-commit-races.sh                       |   4 +-
 t/t7519-status-fsmonitor.sh                   |  14 +-
 t/t7527-builtin-fsmonitor.sh                  |  82 +--
 t/t7528-signed-commit-ssh.sh                  |  68 +--
 t/t7600-merge.sh                              |  10 +-
 t/t7603-merge-reduce-heads.sh                 |  20 +-
 t/t7606-merge-custom.sh                       |   2 +-
 t/t7607-merge-state.sh                        |   4 +-
 t/t7610-mergetool.sh                          |  18 +-
 t/t7700-repack.sh                             |  14 +-
 t/t7703-repack-geometric.sh                   |   4 +-
 t/t7704-repack-cruft.sh                       |  12 +-
 t/t7800-difftool.sh                           |  26 +-
 t/t7810-grep.sh                               |  22 +-
 t/t7814-grep-recurse-submodules.sh            |   2 +-
 t/t7900-maintenance.sh                        |  34 +-
 t/t8008-blame-formats.sh                      |   2 +-
 t/t8010-cat-file-filters.sh                   |   2 +-
 t/t8012-blame-colors.sh                       |   2 +-
 t/t9001-send-email.sh                         | 190 +++----
 t/t9003-help-autocorrect.sh                   |   6 +-
 t/t9106-git-svn-commit-diff-clobber.sh        |   2 +-
 t/t9107-git-svn-migrate.sh                    |  30 +-
 t/t9110-git-svn-use-svm-props.sh              |  20 +-
 t/t9111-git-svn-use-svnsync-props.sh          |  18 +-
 t/t9114-git-svn-dcommit-merge.sh              |   6 +-
 t/t9116-git-svn-log.sh                        |   8 +-
 t/t9117-git-svn-init-clone.sh                 |  12 +-
 t/t9119-git-svn-info.sh                       |  16 +-
 t/t9122-git-svn-author.sh                     |   8 +-
 t/t9130-git-svn-authors-file.sh               |   8 +-
 t/t9138-git-svn-authors-prog.sh               |  14 +-
 t/t9140-git-svn-reset.sh                      |   4 +-
 t/t9153-git-svn-rewrite-uuid.sh               |   4 +-
 t/t9200-git-cvsexportcommit.sh                |   2 +-
 t/t9210-scalar.sh                             |  34 +-
 t/t9211-scalar-clone.sh                       |  16 +-
 t/t9300-fast-import.sh                        |  10 +-
 t/t9350-fast-export.sh                        |  54 +-
 t/t9351-fast-export-anonymize.sh              |  36 +-
 t/t9400-git-cvsserver-server.sh               |   4 +-
 t/t9501-gitweb-standalone-http-status.sh      |  58 +-
 t/t9502-gitweb-standalone-parse-output.sh     |  38 +-
 t/t9800-git-p4-basic.sh                       |  10 +-
 t/t9801-git-p4-branch.sh                      |  48 +-
 t/t9806-git-p4-options.sh                     |  10 +-
 t/t9807-git-p4-submit.sh                      |   2 +-
 t/t9810-git-p4-rcs.sh                         |   8 +-
 t/t9813-git-p4-preserve-users.sh              |   8 +-
 t/t9814-git-p4-rename.sh                      |   8 +-
 t/t9827-git-p4-change-filetype.sh             |   4 +-
 t/t9832-unshelve.sh                           |   6 +-
 t/t9833-errors.sh                             |   4 +-
 t/t9835-git-p4-metadata-encoding-python2.sh   |  36 +-
 t/t9836-git-p4-metadata-encoding-python3.sh   |  38 +-
 t/t9850-shell.sh                              |   2 +-
 t/t9902-completion.sh                         |  26 +-
 385 files changed, 3772 insertions(+), 3329 deletions(-)
 create mode 100644 t/greplint-cat.pl
 create mode 100644 t/greplint.pl
 create mode 100644 t/greplint/bare-grep-after-and.expect
 create mode 100644 t/greplint/bare-grep-after-and.test
 create mode 100644 t/greplint/bare-grep-after-semicolon.expect
 create mode 100644 t/greplint/bare-grep-after-semicolon.test
 create mode 100644 t/greplint/bare-grep-compound-body.expect
 create mode 100644 t/greplint/bare-grep-compound-body.test
 create mode 100644 t/greplint/bare-grep-count-mode.expect
 create mode 100644 t/greplint/bare-grep-count-mode.test
 create mode 100644 t/greplint/bare-grep-explicit-pattern.expect
 create mode 100644 t/greplint/bare-grep-explicit-pattern.test
 create mode 100644 t/greplint/bare-grep-flags.expect
 create mode 100644 t/greplint/bare-grep-flags.test
 create mode 100644 t/greplint/bare-grep-lint-ok.expect
 create mode 100644 t/greplint/bare-grep-lint-ok.test
 create mode 100644 t/greplint/bare-grep-negated.expect
 create mode 100644 t/greplint/bare-grep-negated.test
 create mode 100644 t/greplint/bare-grep-pattern-file.expect
 create mode 100644 t/greplint/bare-grep-pattern-file.test
 create mode 100644 t/greplint/bare-grep-simple.expect
 create mode 100644 t/greplint/bare-grep-simple.test
 create mode 100644 t/greplint/bare-grep-subshell.expect
 create mode 100644 t/greplint/bare-grep-subshell.test
 create mode 100644 t/greplint/dqstring-continuation-offset.expect
 create mode 100644 t/greplint/dqstring-continuation-offset.test
 create mode 100644 t/greplint/filter-command-substitution.expect
 create mode 100644 t/greplint/filter-command-substitution.test
 create mode 100644 t/greplint/filter-pipe-input.expect
 create mode 100644 t/greplint/filter-pipe-input.test
 create mode 100644 t/greplint/filter-pipe-output.expect
 create mode 100644 t/greplint/filter-pipe-output.test
 create mode 100644 t/greplint/filter-redirect-output.expect
 create mode 100644 t/greplint/filter-redirect-output.test
 create mode 100644 t/greplint/filter-stdin-redirect.expect
 create mode 100644 t/greplint/filter-stdin-redirect.test
 create mode 100644 t/greplint/grep-as-argument.expect
 create mode 100644 t/greplint/grep-as-argument.test
 create mode 100644 t/greplint/grep-as-value.expect
 create mode 100644 t/greplint/grep-as-value.test
 create mode 100644 t/greplint/wrong-negation.expect
 create mode 100644 t/greplint/wrong-negation.test
 create mode 100644 t/lib-shell-parser.pl


base-commit: 1ff279f3404a482a83fb04c7457e41ab26884aea
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2135%2Fmmontalbo%2Fmm%2Ftest-grep-docs-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2135/mmontalbo/mm/test-grep-docs-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2135

Range-diff vs v1:

 1:  43402040bf = 1:  5959cab258 t/README: document test_grep helper
 5:  c0db9fdb5b = 2:  f3e8e19e6e t: fix grep assertions missing file arguments
 2:  a1069efa8f ! 3:  460461b5fe t: extract chainlint's parser into shared module
     @@ Metadata
       ## Commit message ##
          t: extract chainlint's parser into shared module
      
     -    Move the Lexer, ShellParser, and ScriptParser packages from
     -    chainlint.pl into t/lib-shell-parser.pl so they can be reused by
     -    other tools.  ScriptParser's check_test() is a no-op in the shared
     -    module; callers subclass ScriptParser and override it.
     +    Move chainlint.pl's Lexer, ShellParser, and ScriptParser into a
     +    shared module (lib-shell-parser.pl) so other lint tools can reuse
     +    the same shell parsing infrastructure.  A subsequent commit adds
     +    greplint.pl, which needs the same tokenizer to correctly identify
     +    command boundaries.
      
     -    chainlint.pl defines TestParser (&&-chain detection) and
     -    ChainlintParser (a ScriptParser subclass whose check_test runs
     -    TestParser and formats the results).  The shared module is loaded
     -    via do() for portability with minimal Perl installations.
     +    ScriptParser's check_test() becomes a no-op in the shared module.
     +    chainlint.pl defines ChainlintParser (extending ScriptParser)
     +    with the &&-chain check_test() implementation.
      
     -    A subsequent commit introduces lint-style.pl which needs the same
     -    shell parser to properly tokenize test scripts.  Sharing the parser
     -    avoids reimplementing heredoc handling, $(...) nesting, pipe
     -    tracking, quoting, and test body extraction.
     +    No functional change: chainlint produces the same output and
     +    check-chainlint self-tests pass.
      
          Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
      
     @@ t/chainlint.pl: my $jobs = -1;
      -	return @tokens;
      -}
      +use File::Basename;
     -+my $_lib = dirname($0) . "/lib-shell-parser.pl";
     -+$_lib = "./$_lib" unless $_lib =~ m{^/};
     -+do $_lib or die "failed to load $_lib: $@$!\n";
     ++do(dirname($0) . "/lib-shell-parser.pl")
     ++	or die "$0: failed to load lib-shell-parser.pl: $@$!\n";
       
       # TestParser is a subclass of ShellParser which, beyond parsing shell script
       # code, is also imbued with semantic knowledge of test construction, and checks
      @@ t/chainlint.pl: DONE:
     + # the tests themselves or in behaviors being exercised by the tests. As such,
     + # TestParser is only called upon to parse test bodies, not the top-level
       # scripts in which the tests are defined.
     ++
       package TestParser;
       
      -use base 'ShellParser';
     @@ t/chainlint.pl: DONE:
      -# at the top-level of test scripts but also within compound commands such as
      -# loops and function definitions.
      -package ScriptParser;
     -+# ChainlintParser is a subclass of ScriptParser which checks each test
     -+# body for broken &&-chains via TestParser, then formats and collects
     -+# the results.
     -+package ChainlintParser;
     - 
     +-
      -use base 'ShellParser';
     -+our @ISA = ('ScriptParser');
     - 
     - sub new {
     - 	my $class = shift @_;
     -@@ t/chainlint.pl: sub new {
     - 	return $self;
     - }
     +-
     +-sub new {
     +-	my $class = shift @_;
     +-	my $self = $class->SUPER::new(@_);
     +-	$self->{ntests} = 0;
     +-	$self->{nerrs} = 0;
     +-	return $self;
     +-}
     ++# ChainlintParser extends ScriptParser with &&-chain checking
     ++package ChainlintParser;
       
      -# extract the raw content of a token, which may be a single string or a
      -# composition of multiple strings and non-string character runs; for instance,
     @@ t/chainlint.pl: sub new {
      -	}
      -	return $s
      -}
     --
     ++our @ISA = ('ScriptParser');
     + 
       sub format_problem {
       	local $_ = shift;
     - 	/^AMP$/ && return "missing '&&'";
      @@ t/chainlint.pl: sub format_problem {
       
       sub check_test {
     @@ t/chainlint.pl: sub check_test {
      -}
      -
       # main contains high-level functionality for processing command-line switches,
     - # feeding input test scripts to ScriptParser, and reporting results.
     +-# feeding input test scripts to ScriptParser, and reporting results.
     ++# feeding input test scripts to ChainlintParser, and reporting results.
       package main;
     + 
     + my $getnow = sub { return time(); };
      @@ t/chainlint.pl: sub check_script {
       		}
       		my $s = do { local $/; <$fh> };
     @@ t/chainlint.pl: sub check_script {
      
       ## t/lib-shell-parser.pl (new) ##
      @@
     ++# Copyright (c) 2021-2022 Eric Sunshine <sunshine@sunshineco.com>
     ++#
     ++# Shared shell script parser for test lint tools. Provides Lexer,
     ++# ShellParser, and ScriptParser. Subclass ScriptParser and override
     ++# check_test() to implement lint checks.
     ++
      +use strict;
      +use warnings;
      +
     -+# Copyright (c) 2021-2022 Eric Sunshine <sunshine@sunshineco.com>
     -+#
      +# Lexer tokenizes POSIX shell scripts. It is roughly modeled after section 2.3
      +# "Token Recognition" of POSIX chapter 2 "Shell Command Language". Although
      +# similar to lexical analyzers for other languages, this one differs in a few
     @@ t/lib-shell-parser.pl (new)
      +# ShellParser parses POSIX shell scripts (with minor extensions for Bash). It
      +# is a recursive descent parser very roughly modeled after section 2.10 "Shell
      +# Grammar" of POSIX chapter 2 "Shell Command Language".
     ++
      +package ShellParser;
      +
      +sub new {
     @@ t/lib-shell-parser.pl (new)
      +}
      +
      +# ScriptParser is a subclass of ShellParser which identifies individual test
     -+# definitions within test scripts and calls check_test() for each test body
     -+# found.  Callers subclass ScriptParser and override check_test() to
     -+# implement specific checks (e.g. chainlint checks &&-chains, lint-style
     -+# checks grep usage).
     ++# definitions within test scripts and passes each test body to check_test().
     ++# ScriptParser detects test definitions not only at the top-level of test
     ++# scripts but also within compound commands such as loops and function
     ++# definitions.
     ++
      +package ScriptParser;
      +
      +our @ISA = ('ShellParser');
      +
     ++sub new {
     ++	my $class = shift @_;
     ++	my $self = $class->SUPER::new(@_);
     ++	$self->{ntests} = 0;
     ++	$self->{nerrs} = 0;
     ++	return $self;
     ++}
     ++
      +# extract the raw content of a token, which may be a single string or a
      +# composition of multiple strings and non-string character runs; for instance,
      +# `"test body"` unwraps to `test body`; `word"a b"42'c d'` to `worda b42c d`
     @@ t/lib-shell-parser.pl (new)
      +}
      +
      +sub check_test {
     -+	# no-op; subclasses override to implement specific checks
     ++	# no-op; subclass and override to implement lint checks
      +}
      +
      +sub parse_cmd {
 3:  93c2b29683 ! 4:  c1b86748d1 t: fix Lexer line count for $() inside double-quoted strings
     @@ Commit message
      
          scan_dqstring's post-loop newline counter re-counts newlines that
          were already counted during recursive parsing of $() bodies.  This
     -    happens because scan_dollar's returned text can contain newlines
     -    (from token text of multi-line strings and from \n command separator
     -    tokens), and the catch-all counter at the end of scan_dqstring
     -    counts all of them again.
     +    happens because scan_dollar returns text containing newlines (from
     +    multi-line command substitutions), and the catch-all counter at the
     +    end of scan_dqstring counts all of them again.
      
          Fix this by counting newlines inline as non-special characters are
          consumed, and removing the post-loop catch-all.  Each newline is
          now counted exactly once: literal newlines at the inline match,
     -    line splices at the \<newline> handler, and $() newlines by
     +    line splices at the backslash handler, and $() newlines by
          scan_token during the recursive parse.
      
     -    This does not affect chainlint's output because chainlint annotates
     -    the original body text using byte offsets, not token line numbers.
     -    It does matter for tools like lint-style.pl (introduced in a
     -    subsequent commit) that use token line numbers to locate and fix
     -    specific lines in the original file.
     -
     -    Add check-shell-parser.pl to verify that the Lexer reports correct
     -    line numbers after multi-line $() in double-quoted strings.
     +    This is a latent bug: any consumer that relies on token line
     +    numbers rather than byte offsets would get incorrect results for
     +    tokens following a multi-line $() inside a double-quoted string.
     +    chainlint is not affected because it annotates the original body
     +    text using byte offsets, not token line numbers.
      
          Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
      
     - ## t/Makefile ##
     -@@ t/Makefile: check-meson:
     - test-lint: test-lint-duplicates test-lint-executable \
     - 	test-lint-filenames
     - ifneq ($(PERL_PATH),)
     --test-lint: test-lint-shell-syntax
     -+test-lint: test-lint-shell-syntax check-shell-parser
     - else
     - GIT_TEST_CHAIN_LINT = 0
     - endif
     -@@ t/Makefile: test-lint-executable:
     - test-lint-shell-syntax:
     - 	@'$(PERL_PATH_SQ)' check-non-portable-shell.pl $(T) $(THELPERS) $(TPERF)
     - 
     -+check-shell-parser:
     -+	@'$(PERL_PATH_SQ)' check-shell-parser.pl
     - test-lint-filenames:
     - 	@# We do *not* pass a glob to ls-files but use grep instead, to catch
     - 	@# non-ASCII characters (which are quoted within double-quotes)
     -@@ t/Makefile: perf:
     - 	$(MAKE) -C perf/ all
     - 
     - .PHONY: pre-clean $(T) aggregate-results clean valgrind perf \
     --	check-chainlint clean-chainlint test-chainlint $(UNIT_TESTS)
     -+	check-chainlint clean-chainlint test-chainlint \
     -+	check-shell-parser $(UNIT_TESTS)
     - 
     - .PHONY: libgit-sys-test libgit-rs-test
     - libgit-sys-test:
     -
     - ## t/check-shell-parser.pl (new) ##
     -@@
     -+#!/usr/bin/perl
     -+
     -+# Tests for the shared shell parser (lib-shell-parser.pl).
     -+
     -+use strict;
     -+use warnings;
     -+use File::Basename;
     -+
     -+my $_lib = dirname($0) . "/lib-shell-parser.pl";
     -+$_lib = "./$_lib" unless $_lib =~ m{^/};
     -+do $_lib or die "$0: failed to load $_lib: $@$!\n";
     -+
     -+my $rc = 0;
     -+
     -+sub check {
     -+	my ($desc, $body, $want_token, $want_line) = @_;
     -+	my $parser = ShellParser->new(\$body);
     -+	my @tokens = $parser->parse();
     -+	for my $t (reverse @tokens) {
     -+		next unless $t->[0] eq $want_token && defined $t->[3];
     -+		if ($t->[3] != $want_line) {
     -+			print STDERR "FAIL: $desc: " .
     -+				"'$want_token' at line $t->[3], " .
     -+				"expected line $want_line\n";
     -+			$rc = 1;
     -+		}
     -+		return;
     -+	}
     -+	print STDERR "FAIL: $desc: token '$want_token' not found\n";
     -+	$rc = 1;
     -+}
     -+
     -+# Multi-line $() inside a dq-string: MARKER should be at line 3.
     -+check('dq-string with multi-line $()', <<'BODY', 'MARKER', 3);
     -+	x="$(echo one
     -+	echo two)" &&
     -+	MARKER here
     -+BODY
     -+
     -+# Two multi-line $() substitutions: verifies drift does not accumulate.
     -+# MARKER should be at line 5.
     -+check('two dq-string $()', <<'BODY', 'MARKER', 5);
     -+	x="$(echo a
     -+	b)" &&
     -+	y="$(echo c
     -+	d)" &&
     -+	MARKER here
     -+BODY
     -+
     -+# $() outside a dq-string: no double-counting either way.
     -+# MARKER should be at line 3.
     -+check('bare $() spanning lines', <<'BODY', 'MARKER', 3);
     -+	x=$(echo one
     -+	echo two) &&
     -+	MARKER here
     -+BODY
     -+
     -+exit $rc;
     -
       ## t/lib-shell-parser.pl ##
      @@ t/lib-shell-parser.pl: sub scan_dqstring {
       	my $b = $self->{buff};
     @@ t/lib-shell-parser.pl: sub scan_dqstring {
       	while (1) {
      -		# slurp up non-special characters
      -		$s .= $1 if $$b =~ /\G([^"\$\\]+)/gc;
     -+		# slurp up non-special characters; count newlines
     -+		# inline so we don't need a catch-all counter that
     -+		# would miscount newlines from recursive $() parsing
     ++		# Slurp non-special characters; count newlines here because
     ++		# newlines inside $() are already counted by the recursive parse.
      +		if ($$b =~ /\G([^"\$\\]+)/gc) {
     -+			my $chunk = $1;
     -+			$self->{lineno} += () = $chunk =~ /\n/sg;
     -+			$s .= $chunk;
     ++			$s .= $1;
     ++			$self->{lineno} += $1 =~ tr/\n//;
      +		}
       		# handle special characters
       		last unless $$b =~ /\G(.)/sgc;
 6:  1527293f1c ! 5:  3a589ef738 t: lint and convert grep assertions to test_grep
     @@ Metadata
      Author: Michael Montalbo <mmontalbo@gmail.com>
      
       ## Commit message ##
     -    t: lint and convert grep assertions to test_grep
     -
     -    Extend lint-style.pl with a rule that detects bare 'grep' used as a
     -    test assertion and converts it to test_grep.  test_grep prints the
     -    file contents on failure, making test debugging significantly easier.
     -
     -    parse_commands() is extended to split at shell structural tokens
     -    ({, }, (, ), |) and keywords (if, then, for, etc.), and each
     -    command gains a token_pos index so that rules can scan backward and
     -    forward in the token stream for context.
     -
     -    Three new functions implement the grep-assertion rule:
     -
     -     - is_filter_context() scans the surrounding tokens for pipes,
     -       control-flow keywords (if/elif/while/until), for-in value
     -       lists, and brace groups with output redirects.
     -
     -     - is_grep_assertion() classifies a grep command: convertible
     -       assertion (pattern and file present), filter (not an assertion),
     -       or missing file argument (flagged as a likely bug).
     -
     -     - check_bare_grep() ties them together and calls
     -       report_violation() with the appropriate fix.
     -
     -    The --fix mode handles:
     -     - Replacing 'grep' with 'test_grep'
     -     - Moving negation from '! grep' to 'test_grep !'
     -     - Stripping the -q flag (test_grep inherently checks match status)
     -
     -    Five files require '# lint-ok' annotations for intentional grep
     -    usage that cannot be mechanically converted: t1400 (packed-refs
     -    may not exist on reftable), t3901 (piped stdin via case block),
     -    t6437 (glob argument breaks test_grep's test -f check), t7450
     -    (file may not exist after failed MINGW clone), and t7527 ($?
     -    capture on the next line).
     -
     -    The test-lint-style scope is extended to include sourced test
     -    fragments in subdirectories (t5411/*.sh and similar) via a new
     -    TSOURCED variable.
     -
     -    Run '--fix' to convert all ~2800 grep assertions across ~340 files
     -    in the test suite.  test-lib-functions.sh and lib-rebase.sh are
     -    excluded from linting since they implement test infrastructure
     -    rather than test assertions.
     +    t: convert grep assertions to test_grep
     +
     +    Replace bare grep with test_grep in test assertions across the
     +    suite, including sourced test helpers (lib-*.sh, *-tests.sh).
     +    test_grep prints the contents of the file being searched on
     +    failure, making debugging easier than a bare grep which fails
     +    silently.
     +
     +    Only assertion-style greps are converted: grep used as a filter
     +    in pipelines, command substitutions, conditionals, or with
     +    redirected I/O is left as-is with a "# lint-ok" annotation.
     +    Existing '! test_grep' calls are rewritten to 'test_grep !' so
     +    that the diagnostic output is preserved on failure.
     +
     +    The conversion was generated using a grep-assertion linter
     +    (greplint.pl, added in the following commit) to identify bare
     +    grep calls at command position.  To reproduce:
     +
     +        # Step 1: mark bare greps that should not be converted
     +        sed -i '/! grep "$m" \.git\/packed-refs/s/$/ # lint-ok: file may not exist (reftable)/' \
     +            t/t1400-update-ref.sh
     +        sed -i '/! grep dirty file3 &&/{/lint-ok/!s/$/ # lint-ok: file may not exist after --quit/}' \
     +            t/t3420-rebase-autostash.sh
     +        sed -i '/grep -vf before commits\.raw/s/$/ # lint-ok: data filter/' \
     +            t/t5326-multi-pack-bitmaps.sh
     +        sed -i '/! grep $d shallow-client\/\.git\/shallow/s/$/ # lint-ok: file may not exist after repack/' \
     +            t/t5537-fetch-shallow.sh
     +        sed -i '/grep -E "^\[0-9a-f\].*|| :/s/$/ # lint-ok: data filter/' \
     +            t/t5702-protocol-v2.sh
     +        sed -i '/! grep gitdir squatting-clone/s/$/ # lint-ok: file may not exist after failed clone/' \
     +            t/t7450-bad-git-dotfiles.sh
     +
     +        # Step 2: reorder pre-existing '! test_grep' to 'test_grep !'
     +        # (must come before steps 3-4 so greplint does not see them)
     +        sed -i 's/! test_grep/test_grep !/' t/t0031-lockfile-pid.sh
     +        sed -i 's/! test_grep/test_grep !/' t/t5300-pack-object.sh
     +        sed -i 's/! test_grep/test_grep !/' t/t5319-multi-pack-index.sh
     +
     +        # Step 3: convert '! grep' -> 'test_grep !'
     +        perl t/greplint.pl t/*.sh 2>&1 | cut -d: -f1,2 |
     +        while IFS=: read f l; do
     +            sed -i "${l}s/! *grep/test_grep !/" "$f"
     +        done
     +
     +        # Step 4: convert remaining 'grep' -> 'test_grep'
     +        perl t/greplint.pl t/*.sh 2>&1 | cut -d: -f1,2 |
     +        while IFS=: read f l; do
     +            sed -i "${l}s/grep/test_grep/" "$f"
     +        done
     +
     +    To verify, run: make -C t test-greplint
      
          Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
      
     - ## t/Makefile ##
     -@@ t/Makefile: test-lint-shell-syntax:
     - check-shell-parser:
     - 	@'$(PERL_PATH_SQ)' check-shell-parser.pl
     - 
     -+TSOURCED = $(sort $(wildcard t[0-9]*/*.sh))
     -+
     - test-lint-style:
     --	@'$(PERL_PATH_SQ)' lint-style.pl $(T) $(THELPERS) $(TPERF)
     -+	@'$(PERL_PATH_SQ)' lint-style.pl $(T) $(THELPERS) $(TPERF) $(TSOURCED)
     - 
     - check-lint-style:
     - 	@rc=0; for t in $(LINT_STYLE_TESTS); do \
     -
       ## t/for-each-ref-tests.sh ##
      @@ t/for-each-ref-tests.sh: test_expect_success 'Verify descending sort' '
       
     @@ t/lib-httpd.sh: test_http_push_nonff () {
       
       	test_expect_success 'non-fast-forward push shows help message' '
      
     - ## t/lint-style.pl ##
     -@@
     - # Detection uses parsed tokens from the shared shell parser for
     - # correct handling of heredocs, $(...), pipes, and quoting.
     - # Fixes modify the original file text to preserve formatting.
     -+#
     -+# Architecture: the harness (LintParser, parse_commands) tokenizes
     -+# test bodies and splits them into commands.  Rules are independent
     -+# functions that examine each command and its surrounding token
     -+# context to decide if there is a violation.
     - 
     - use strict;
     - use warnings;
     -@@ t/lint-style.pl: do $_lib or die "$0: failed to load $_lib: $@$!\n";
     - # on each test body.  Per-file state (file name, raw lines, dirty
     - # flag) is stored on the instance before calling parse().
     - #
     --# Subroutines defined below (parse_commands, check_test_grep_negation,
     --# etc.) are in package main and called with the main:: prefix.
     --# File-scoped lexicals ($fix_mode, $has_fixable, etc.) are visible
     --# across packages since 'package' does not introduce a new scope.
     -+# Subroutines defined below are in package main and called with
     -+# the main:: prefix.  File-scoped lexicals ($fix_mode, etc.) are
     -+# visible across packages since 'package' does not introduce a
     -+# new scope.
     - package LintParser;
     - our @ISA = ('ScriptParser');
     - 
     -@@ t/lint-style.pl: package main;
     - my $exit_code = 0;
     - my $has_fixable = 0;
     - 
     -+my %skip_file = map { $_ => 1 }
     -+	grep { m{(?:test-lib-functions|lib-rebase)\.sh$} } @ARGV;
     -+
     - sub err {
     - 	my ($file, $lineno, $line, $msg, %opts) = @_;
     - 	$line =~ s/^\s+//;
     -@@ t/lint-style.pl: sub err {
     - 	$exit_code = 1 unless $fix_mode && $opts{fixable};
     - }
     - 
     --# Report a lint violation found by a rule.  In --fix mode, apply
     --# the regex substitution on the raw line and report success.
     --# Otherwise just report.  Returns 1 if the line was modified.
     -+# Report a lint violation.  In --fix mode, apply the regex
     -+# substitution on the raw line.  Returns 1 if modified.
     - sub report_violation {
     - 	my ($file, $cmd, $line_ref, $match, $fix, $from) = @_;
     - 	my $lineno = $cmd->{lineno};
     -@@ t/lint-style.pl: sub report_violation {
     - 	return 0;
     - }
     - 
     -+# --- Harness: tokenize and split into commands ---
     -+#
     - # Split a token stream into commands at &&, ||, ;;, and \n.
     -+# Each command is {tokens => [...], lineno => N, token_pos => I}
     -+# where token_pos is the index in @all_tokens where the command's
     -+# first token appeared (so rules can look backward for context).
     - sub parse_commands {
     --	my ($content) = @_;
     --	my $parser = ShellParser->new(\$content);
     --	my @all_tokens = $parser->parse();
     --
     -+	my ($all_tokens) = @_;
     - 	my @commands;
     - 	my @current;
     - 	my $lineno = 1;
     -+	my $first_pos = 0;
     -+
     -+	my %shell_keyword;
     -+	@shell_keyword{qw(if then else elif fi for do done
     -+			   while until case in esac)} = ();
     - 
     --	for (my $ti = 0; $ti < @all_tokens; $ti++) {
     --		my $text = $all_tokens[$ti]->[0];
     -+	for (my $ti = 0; $ti < @$all_tokens; $ti++) {
     -+		my $text = $all_tokens->[$ti]->[0];
     - 		if ($text =~ /^(?:&&|\|\||;;|\n)$/) {
     -+			# Command separators: flush current command
     -+			if (@current) {
     -+				push @commands, {
     -+					tokens    => [@current],
     -+					lineno    => $lineno,
     -+					token_pos => $first_pos,
     -+				};
     -+				@current = ();
     -+			}
     -+		} elsif ($text =~ /^[{}()|]$/ || exists $shell_keyword{$text}) {
     -+			# Shell structural tokens and keywords:
     -+			# flush current command (these are boundaries,
     -+			# not part of the command's arguments)
     - 			if (@current) {
     - 				push @commands, {
     --					tokens => [@current],
     --					lineno => $lineno,
     -+					tokens    => [@current],
     -+					lineno    => $lineno,
     -+					token_pos => $first_pos,
     - 				};
     - 				@current = ();
     - 			}
     - 		} else {
     --			$lineno = $all_tokens[$ti]->[3]
     --				if !@current && defined $all_tokens[$ti]->[3];
     -+			if (!@current) {
     -+				# Record line number of the first token
     -+				$lineno = $all_tokens->[$ti]->[3]
     -+					if defined $all_tokens->[$ti]->[3];
     -+				$first_pos = $ti;
     -+			}
     - 			push @current, $text;
     - 		}
     - 	}
     - 	if (@current) {
     - 		push @commands, {
     --			tokens => [@current],
     --			lineno => $lineno,
     -+			tokens    => [@current],
     -+			lineno    => $lineno,
     -+			token_pos => $first_pos,
     - 		};
     - 	}
     - 	return @commands;
     - }
     - 
     - # --- Rule: '! test_grep' should be 'test_grep !' ---
     --# Shell-level negation suppresses test_grep's diagnostic output
     --# on failure.  Built-in negation preserves it.
     - sub check_test_grep_negation {
     --	my ($cmd, $file, $line_ref) = @_;
     -+	my ($cmd, $file, $line_ref, $all_tokens) = @_;
     - 	my @tokens = @{$cmd->{tokens}};
     - 	return unless @tokens >= 2 && $tokens[0] eq '!' && $tokens[1] eq 'test_grep';
     - 
     -@@ t/lint-style.pl: sub check_test_grep_negation {
     - 		qr/!\s*test_grep/, 'test_grep !', '! test_grep');
     - }
     - 
     --# Map parsed commands back to raw file lines for --fix.
     --# Detection uses parsed tokens (correct handling of quoting,
     --# heredocs, pipes) but fixes must modify the original text
     --# to preserve formatting.
     -+# --- Rule: bare 'grep' should be 'test_grep' ---
     -+
     -+# Check if this command is in a filter context by looking at
     -+# the surrounding tokens in the stream.  This is grep-rule
     -+# specific: it knows what contexts make a grep not an assertion.
     -+sub is_filter_context {
     -+	my ($all_tokens, $cmd) = @_;
     -+	my $pos = $cmd->{token_pos};
     -+
     -+	# Scan backward to the previous command separator.
     -+	# If we find '|', this command is part of a pipeline.
     -+	# If we find if/elif/while/until, it's a condition.
     -+	for (my $j = $pos - 1; $j >= 0; $j--) {
     -+		my $t = $all_tokens->[$j]->[0];
     -+		# Stop at command separators (but not \n after |)
     -+		last if $t =~ /^(?:&&|\|\||;;)$/;
     -+		if ($t eq "\n") {
     -+			# \n after | is a line continuation, keep scanning
     -+			next if $j > 0 && $all_tokens->[$j - 1]->[0] eq '|';
     -+			last;
     -+		}
     -+		return 1 if $t eq '|';
     -+		return 1 if $t =~ /^(?:if|elif|while|until)$/;
     -+		# for ... in ITEMS ... do: if we're between 'in' and 'do',
     -+		# we're in a value list, not a command
     -+		return 1 if $t eq 'in';
     -+	}
     -+
     -+	# Forward: pipe after command
     -+	for (my $j = $pos + @{$cmd->{tokens}}; $j < @$all_tokens; $j++) {
     -+		my $t = $all_tokens->[$j]->[0];
     -+		last if $t =~ /^(?:&&|\|\||;;|\n)$/;
     -+		return 1 if $t eq '|';
     -+	}
     -+
     -+	# { cmd; } >output
     -+	return 1 if is_in_redirected_brace($all_tokens, $pos);
     -+
     -+	return 0;
     -+}
     -+
     -+# Check if position $pos is inside a brace group whose output is
     -+# redirected: { grep ...; } >file.  Scan backward for the enclosing
     -+# '{', then forward for the matching '}', and check what follows it.
     -+sub is_in_redirected_brace {
     -+	my ($all_tokens, $pos) = @_;
     -+	my $brace_depth = 0;
     -+	for (my $j = $pos - 1; $j >= 0; $j--) {
     -+		my $t = $all_tokens->[$j]->[0];
     -+		$brace_depth++ if $t eq '}';
     -+		if ($t eq '{') {
     -+			return 0 if $brace_depth > 0;
     -+			$brace_depth--;
     -+			# Found our enclosing '{'. Find matching '}'
     -+			my $depth = 1;
     -+			for (my $k = $j + 1; $k < @$all_tokens; $k++) {
     -+				$depth++ if $all_tokens->[$k]->[0] eq '{';
     -+				$depth-- if $all_tokens->[$k]->[0] eq '}';
     -+				if ($depth == 0) {
     -+					my $after = $k + 1 < @$all_tokens ?
     -+						$all_tokens->[$k + 1]->[0] : '';
     -+					return $after =~ /^>{1,2}/;
     -+				}
     -+			}
     -+			return 0;
     -+		}
     -+	}
     -+	return 0;
     -+}
     -+
     -+# Classify a grep command: assertion, filter, or bug.
     -+#
     -+# Returns:
     -+#   1  assertion (PATTERN + FILE), can be converted to test_grep
     -+#   0  not a grep, or grep used as a filter
     -+#  -1  likely bug (e.g., missing file argument)
     -+sub is_grep_assertion {
     -+	my ($cmd, $all_tokens) = @_;
     -+	my @tokens = @{$cmd->{tokens}};
     -+
     -+	# Find grep, possibly after "!"
     -+	my $i = 0;
     -+	$i++ if $tokens[0] eq '!';
     -+	return 0 unless defined $tokens[$i] && $tokens[$i] eq 'grep';
     -+	return 0 if grep { $_ eq 'test_grep' } @tokens;
     -+
     -+	# Check surrounding context (pipes, control flow, brace redirects)
     -+	return 0 if is_filter_context($all_tokens, $cmd);
     -+
     -+	$i++;  # skip 'grep'
     -+
     -+	# Check grep's own flags and arguments
     -+	my @positional;
     -+	my $has_pattern_flag = 0;
     -+	my $end_of_flags = 0;
     -+	while ($i < @tokens) {
     -+		my $tok = $tokens[$i];
     -+		if ($tok eq '|' || $tok eq '<') {
     -+			return 0;
     -+		}
     -+		if ($tok =~ /^>{1,2}$/) {
     -+			# Stdout redirect means filter (grep ... >out).
     -+			# Stderr redirect (2>err) is fine: skip the fd
     -+			# and the target, and keep classifying.
     -+			my $prev = $i > 0 ? $tokens[$i - 1] : '';
     -+			return 0 unless $prev =~ /^\d+$/ && $prev >= 2;
     -+			pop @positional if @positional && $positional[-1] eq $prev;
     -+			$i += 2;
     -+			next;
     -+		}
     -+		if (!$end_of_flags && $tok =~ /^-\w*[clLrR]/) {
     -+			return 0;
     -+		}
     -+		if (!$end_of_flags && $tok eq '--') {
     -+			$end_of_flags = 1;
     -+		} elsif (!$end_of_flags && $tok =~ /^-\w*[ef]$/) {
     -+			$has_pattern_flag = 1;
     -+			$i++;
     -+		} elsif (!$end_of_flags && $tok =~ /^-/) {
     -+			# skip other flags
     -+		} else {
     -+			push @positional, $tok;
     -+		}
     -+		$i++;
     -+	}
     -+
     -+	my $need = $has_pattern_flag ? 1 : 2;
     -+	return 0 if !@positional && !$has_pattern_flag;
     -+	return -1 if @positional < $need;
     -+	return 0 if $positional[-1] =~ /^-/;
     -+	return 1;
     -+}
     -+
     -+sub check_bare_grep {
     -+	my ($cmd, $file, $line_ref, $all_tokens) = @_;
     -+	my @tokens = @{$cmd->{tokens}};
     -+
     -+	my $result = is_grep_assertion($cmd, $all_tokens);
     -+	return unless $result;
     -+
     -+	if ($result == -1) {
     -+		err $file, $cmd->{lineno}, join(' ', @tokens),
     -+			"grep assertion appears to be missing a file argument";
     -+		return 0;
     -+	}
     -+
     -+	# Determine negation and -q flag
     -+	my $negated = $tokens[0] eq '!';
     -+	my $has_q = 0;
     -+	my ($pre_q, $post_q) = ('', '');
     -+	for my $tok (@tokens) {
     -+		if ($tok =~ /^-(\w*)q(\w*)$/) {
     -+			$has_q = 1;
     -+			($pre_q, $post_q) = ($1, $2);
     -+			last;
     -+		}
     -+		last if $tok !~ /^-/ && $tok ne '!' && $tok ne 'grep';
     -+	}
     -+
     -+	# Build the replacement
     -+	my $fix = "test_grep";
     -+	$fix .= " !" if $negated;
     -+	if ($has_q) {
     -+		my $rest = "$pre_q$post_q";
     -+		$fix .= " -$rest" if $rest;
     -+	}
     -+
     -+	# Build the match pattern
     -+	my $neg_match = $negated ? '!\s*' : '\b';
     -+	my $neg_from  = $negated ? '! '   : '';
     -+	my ($match, $from);
     -+	if ($has_q) {
     -+		$match = qr/${neg_match}grep\s+-\w*q\w*/;
     -+		$from  = "${neg_from}grep -${pre_q}q${post_q}";
     -+	} else {
     -+		$match = qr/${neg_match}grep\b/;
     -+		$from  = "${neg_from}grep";
     -+	}
     -+
     -+	return report_violation($file, $cmd, $line_ref,
     -+		$match, $fix, $from);
     -+}
     -+
     -+# --- Harness: LintParser.check_test ---
     -+#
     -+# Called by ScriptParser::parse_cmd for each test_expect_success
     -+# or test_expect_failure block.  Extracts the body, tokenizes it,
     -+# splits into commands, and runs each rule.
     - package LintParser;
     - 
     - sub check_test {
     --	# Called by ScriptParser::parse_cmd for each test_expect_success
     --	# or test_expect_failure block.
     - 	my $self = shift @_;
     - 	my $title = ScriptParser::unwrap(shift @_);
     - 
     -@@ t/lint-style.pl: sub check_test {
     - 	}
     - 	return unless $body;
     - 
     -+	# Tokenize the body once; commands and rules share the stream
     -+	my $parser = ShellParser->new(\$body);
     -+	my @all_tokens = $parser->parse();
     -+	my @commands = main::parse_commands(\@all_tokens);
     -+
     - 	# Map each command back to its file line number.
     - 	# $lineno_base is where the body starts in the file;
     - 	# $cmd->{lineno} is relative to the body (starting at 1).
     - 	my $raw_lines = $self->{raw_lines};
     --	for my $cmd (main::parse_commands($body)) {
     -+	for my $cmd (@commands) {
     - 		my $ln = ($cmd->{lineno} || 0) + $lineno_base - 1;
     - 		$cmd->{lineno} = $ln;
     - 		next unless $ln >= 1 && $ln <= @$raw_lines;
     - 		next if $raw_lines->[$ln - 1] =~ /#.*lint-ok/;
     - 
     --		if (main::check_test_grep_negation($cmd, $self->{file}, \$raw_lines->[$ln - 1])) {
     --			$self->{dirty} = 1;
     --		}
     -+		my $line_ref = \$raw_lines->[$ln - 1];
     -+		# Stop after the first fix: later rules should not
     -+		# re-match against already-modified text.
     -+		my $modified = 0;
     -+		$modified ||= main::check_test_grep_negation(
     -+			$cmd, $self->{file}, $line_ref, \@all_tokens);
     -+		$modified ||= main::check_bare_grep(
     -+			$cmd, $self->{file}, $line_ref, \@all_tokens);
     -+		$self->{dirty} = 1 if $modified;
     - 	}
     - }
     - 
     - package main;
     - 
     - for my $file (@ARGV) {
     -+	next if $skip_file{$file};
     - 	# :unix:crlf strips \r on Windows (same as chainlint.pl)
     - 	open(my $fh, '<:unix:crlf', $file) or die "$0: $file: $!\n";
     - 	my @raw_lines = <$fh>;
     -
     - ## t/lint-style/grep-assert.expect (new) ##
     -@@
     -+lint-style/grep-assert.test:2: error: replace 'grep' with 'test_grep': grep "pattern" actual
     -+lint-style/grep-assert.test:3: error: replace 'grep' with 'test_grep': grep -E "extended" actual
     -+lint-style/grep-assert.test:4: error: replace 'grep' with 'test_grep': grep -e "explicit" actual
     -+lint-style/grep-assert.test:5: error: replace 'grep' with 'test_grep': grep -f patterns.txt actual
     -+lint-style/grep-assert.test:6: error: replace 'grep' with 'test_grep': grep -Fe "fixed-explicit" actual
     -+lint-style/grep-assert.test:7: error: replace 'grep' with 'test_grep': grep "^-looks-like-flag" actual
     -+lint-style/grep-assert.test:8: error: replace 'grep' with 'test_grep': grep -v "inverted" actual
     -+lint-style/grep-assert.test:9: error: replace 'grep' with 'test_grep': grep -- "-e" actual
     -+lint-style/grep-assert.test:10: error: replace 'grep' with 'test_grep': grep "with-stderr-redirect" actual 2 > err
     -+lint-style/grep-assert.test:12: error: replace 'grep' with 'test_grep': grep "after-or" actual
     -+lint-style/grep-assert.test:17: error: replace 'grep' with 'test_grep': grep "after-pipe" actual
     -+lint-style/grep-assert.test:22: error: replace 'grep' with 'test_grep': grep "inside-case" actual
     -+hint: run with --fix to apply the suggested replacements.
     -
     - ## t/lint-style/grep-assert.test (new) ##
     -@@
     -+test_expect_success 'grep assertions' '
     -+	grep "pattern" actual &&
     -+	grep -E "extended" actual &&
     -+	grep -e "explicit" actual &&
     -+	grep -f patterns.txt actual &&
     -+	grep -Fe "fixed-explicit" actual &&
     -+	grep "^-looks-like-flag" actual &&
     -+	grep -v "inverted" actual &&
     -+	grep -- "-e" actual &&
     -+	grep "with-stderr-redirect" actual 2>err &&
     -+	cmd ||
     -+	grep "after-or" actual
     -+'
     -+
     -+test_expect_success 'pipe only suppresses first command' '
     -+	cmd |
     -+	grep "piped" && grep "after-pipe" actual
     -+'
     -+
     -+test_expect_success 'case pattern does not hide assertion' '
     -+	case foo in
     -+	*) grep "inside-case" actual ;;
     -+	esac
     -+'
     -
     - ## t/lint-style/grep-fix.expect (new) ##
     -@@
     -+test_expect_success 'all fixable forms' '
     -+	test_grep "pattern" actual &&
     -+	test_grep -E "extended" actual &&
     -+	test_grep "quiet" actual &&
     -+	test_grep -F "combined" actual &&
     -+	test_grep -i "quiet-insensitive" actual &&
     -+	test_grep ! "negated" actual &&
     -+	test_grep ! "neg-quiet" actual &&
     -+	test_grep ! "shell-neg" actual &&
     -+	test_grep -e "explicit" actual &&
     -+	test_grep -Fe "fixed-explicit" actual &&
     -+	test_grep -f patterns.txt actual &&
     -+	test_grep -- "-e" actual &&
     -+	test_grep "continuation" \
     -+		actual
     -+'
     -
     - ## t/lint-style/grep-fix.test (new) ##
     -@@
     -+test_expect_success 'all fixable forms' '
     -+	grep "pattern" actual &&
     -+	grep -E "extended" actual &&
     -+	grep -q "quiet" actual &&
     -+	grep -qF "combined" actual &&
     -+	grep -qi "quiet-insensitive" actual &&
     -+	! grep "negated" actual &&
     -+	! grep -q "neg-quiet" actual &&
     -+	! test_grep "shell-neg" actual &&
     -+	grep -e "explicit" actual &&
     -+	grep -Fe "fixed-explicit" actual &&
     -+	grep -f patterns.txt actual &&
     -+	grep -- "-e" actual &&
     -+	grep "continuation" \
     -+		actual
     -+'
     -
     - ## t/lint-style/grep-missing-file.expect (new) ##
     -@@
     -+lint-style/grep-missing-file.test:2: error: grep assertion appears to be missing a file argument: grep "pattern"
     -+lint-style/grep-missing-file.test:3: error: grep assertion appears to be missing a file argument: ! grep "negated"
     -+lint-style/grep-missing-file.test:4: error: grep assertion appears to be missing a file argument: grep -e "pattern-flag-no-file"
     -+lint-style/grep-missing-file.test:5: error: grep assertion appears to be missing a file argument: grep -f patterns.txt
     -
     - ## t/lint-style/grep-missing-file.test (new) ##
     -@@
     -+test_expect_success 'grep missing file argument' '
     -+	grep "pattern" &&
     -+	! grep "negated" &&
     -+	grep -e "pattern-flag-no-file" &&
     -+	grep -f patterns.txt
     -+'
     -
     - ## t/lint-style/grep-negated.expect (new) ##
     -@@
     -+lint-style/grep-negated.test:2: error: replace '! grep' with 'test_grep !': ! grep "pattern" actual
     -+lint-style/grep-negated.test:3: error: replace '! grep' with 'test_grep !': ! grep -i "insensitive" actual
     -+lint-style/grep-negated.test:7: error: replace '! grep -q' with 'test_grep !': ! grep -q "pattern" actual
     -+lint-style/grep-negated.test:8: error: replace '! grep -qF' with 'test_grep ! -F': ! grep -qF "combined" actual
     -+hint: run with --fix to apply the suggested replacements.
     -
     - ## t/lint-style/grep-negated.test (new) ##
     -@@
     -+test_expect_success 'negated grep' '
     -+	! grep "pattern" actual &&
     -+	! grep -i "insensitive" actual
     -+'
     -+
     -+test_expect_success 'negated grep -q' '
     -+	! grep -q "pattern" actual &&
     -+	! grep -qF "combined" actual
     -+'
     -
     - ## t/lint-style/grep-not-assert.expect (new) ##
     -
     - ## t/lint-style/grep-not-assert.test (new) ##
     -@@
     -+test_expect_success 'grep used as filter (not assertion)' '
     -+	grep "pattern" file | wc -l &&
     -+	grep "pattern" file >output &&
     -+	grep "pattern" file 1>output &&
     -+	grep -c "count" file &&
     -+	grep -ci "count-insensitive" file &&
     -+	grep -l "list" file &&
     -+	grep -rl "recursive-list" dir &&
     -+	grep -L "list-without" file1 file2 &&
     -+	result=$(grep "pattern" file) &&
     -+	result=$(echo $(grep "nested-subshell" file)) &&
     -+	grep "pattern" <stdin &&
     -+	grep "pattern" file && # lint-ok
     -+	cmd | grep "pattern-only" &&
     -+	cmd |
     -+	grep "cross-line-pipe" &&
     -+	grep -r "recursive" dir
     -+'
     -+
     -+test_expect_success 'grep in control flow (not assertion)' '
     -+	if grep "condition" file
     -+	then
     -+		echo yes
     -+	elif grep "other-condition" file
     -+	then
     -+		echo no
     -+	fi
     -+'
     -+
     -+test_expect_success 'grep in brace group with redirect' '
     -+	{ grep "captured" out; } >result
     -+'
     -+
     -+test_expect_success 'grep in for-in value list' '
     -+	for cmd in grep sed awk; do
     -+		echo "$cmd"
     -+	done
     -+'
     -+
     -+test_expect_success 'grep in subshell' '
     -+	(cd sub && grep "pattern" file >output) &&
     -+	(cmd | grep "piped-in-subshell")
     -+'
     -
       ## t/pack-refs-tests.sh ##
      @@ t/pack-refs-tests.sh: test_expect_success 'delete ref while another dangling packed ref' '
       test_expect_success 'pack ref directly below refs/' '
     @@ t/t0030-stripspace.sh: test_expect_success 'strip comments with changed comment
       
       test_expect_success '-c with single line' '
      
     + ## t/t0031-lockfile-pid.sh ##
     +@@ t/t0031-lockfile-pid.sh: test_expect_success 'PID info not shown by default' '
     + 		test_must_fail git add . 2>err &&
     + 		# Should not crash, just show normal error without PID
     + 		test_grep "Unable to create" err &&
     +-		! test_grep "is held by process" err
     ++		test_grep ! "is held by process" err
     + 	)
     + '
     + 
     +
       ## t/t0040-parse-options.sh ##
      @@ t/t0040-parse-options.sh: test_expect_success 'non ambiguous option (after two options it abbreviates)' '
       
     @@ t/t0052-simple-ipc.sh: test_expect_success 'servers cannot share the same path'
       	test-tool simple-ipc send --token=big >actual &&
       	test_line_count -ge 10000 actual &&
      -	grep -q "big: [0]*9999\$" actual
     -+	test_grep "big: [0]*9999\$" actual
     ++	test_grep -q "big: [0]*9999\$" actual
       '
       
       test_expect_success 'chunk response' '
       	test-tool simple-ipc send --token=chunk >actual &&
       	test_line_count -ge 10000 actual &&
      -	grep -q "big: [0]*9999\$" actual
     -+	test_grep "big: [0]*9999\$" actual
     ++	test_grep -q "big: [0]*9999\$" actual
       '
       
       test_expect_success 'slow response' '
       	test-tool simple-ipc send --token=slow >actual &&
       	test_line_count -ge 100 actual &&
      -	grep -q "big: [0]*99\$" actual
     -+	test_grep "big: [0]*99\$" actual
     ++	test_grep -q "big: [0]*99\$" actual
       '
       
       # Send an IPC with n=100,000 bytes of ballast.  This should be large enough
     @@ t/t0203-gettext-setlocale-sanity.sh: test_expect_success 'git show a ISO-8859-1
       	git show >out 2>err &&
       	test_must_be_empty err &&
      -	grep -q "iso-c-commit" out
     -+	test_grep "iso-c-commit" out
     ++	test_grep -q "iso-c-commit" out
       '
       
       test_expect_success GETTEXT_LOCALE 'git show a ISO-8859-1 commit under a UTF-8 locale' '
     @@ t/t0203-gettext-setlocale-sanity.sh: test_expect_success GETTEXT_LOCALE 'git sho
       	LANGUAGE=is LC_ALL="$is_IS_locale" git show >out 2>err &&
       	test_must_be_empty err &&
      -	grep -q "iso-utf8-commit" out
     -+	test_grep "iso-utf8-commit" out
     ++	test_grep -q "iso-utf8-commit" out
       '
       
       test_done
     @@ t/t0410-partial-clone.sh: test_expect_success TTY 'promisor.quiet=unconfigured s
      +	test_grep "Receiving objects" err
       '
       
     - . "$TEST_DIRECTORY"/lib-httpd.sh
     + test_expect_success 'promisor.quiet from submodule repo is honored' '
      @@ t/t0410-partial-clone.sh: test_expect_success 'fetching of missing objects from an HTTP server' '
       	test_line_count = 1 promisorlist &&
       	IDX=$(sed "s/promisor$/idx/" promisorlist) &&
     @@ t/t1011-read-tree-sparse-checkout.sh: test_expect_success 'read-tree will not th
       	read_tree_u_must_fail -m -u HEAD^ &&
       	test_path_is_file init.t &&
      -	grep -q dirty init.t
     -+	test_grep dirty init.t
     ++	test_grep -q dirty init.t
       '
       
       test_expect_success 'read-tree will not throw away dirty changes, sparse' '
     @@ t/t1011-read-tree-sparse-checkout.sh: test_expect_success 'read-tree will not th
       	read_tree_u_must_fail -m -u HEAD^ &&
       	test_path_is_file init.t &&
      -	grep -q dirty init.t
     -+	test_grep dirty init.t
     ++	test_grep -q dirty init.t
       '
       
       test_expect_success 'read-tree updates worktree, dirty case' '
     @@ t/t1011-read-tree-sparse-checkout.sh: test_expect_success 'read-tree updates wor
       	echo dirty >init.t &&
       	read_tree_u_must_fail -m -u HEAD^ &&
      -	grep -q dirty init.t &&
     -+	test_grep dirty init.t &&
     ++	test_grep -q dirty init.t &&
       	rm init.t
       '
       
     @@ t/t1011-read-tree-sparse-checkout.sh: test_expect_success 'read-tree removes wor
       	echo dirty >added &&
       	read_tree_u_must_succeed -m -u HEAD^ &&
      -	grep -q dirty added
     -+	test_grep dirty added
     ++	test_grep -q dirty added
       '
       
       test_expect_success 'read-tree adds to worktree, absent case' '
     @@ t/t1011-read-tree-sparse-checkout.sh: test_expect_success 'read-tree adds to wor
       	echo dirty >sub/added &&
       	read_tree_u_must_succeed -u -m HEAD^ &&
      -	grep -q dirty sub/added
     -+	test_grep dirty sub/added
     ++	test_grep -q dirty sub/added
       '
       
       test_expect_success 'index removal and worktree narrowing at the same time' '
     @@ t/t3310-notes-merge-manual-resolve.sh: EOF
       	git log -1 --format=%B refs/notes/m > merge_commit_msg &&
      -	grep -q refs/notes/m merge_commit_msg &&
      -	grep -q refs/notes/z merge_commit_msg &&
     -+	test_grep refs/notes/m merge_commit_msg &&
     -+	test_grep refs/notes/z merge_commit_msg &&
     ++	test_grep -q refs/notes/m merge_commit_msg &&
     ++	test_grep -q refs/notes/z merge_commit_msg &&
       	# Merge commit mentions conflicting notes
      -	grep -q "Conflicts" merge_commit_msg &&
     -+	test_grep "Conflicts" merge_commit_msg &&
     ++	test_grep -q "Conflicts" merge_commit_msg &&
       	( for sha1 in $(cat expect_conflicts); do
      -		grep -q "$sha1" merge_commit_msg ||
     -+		test_grep "$sha1" merge_commit_msg ||
     ++		test_grep -q "$sha1" merge_commit_msg ||
       		exit 1
       	done ) &&
       	# Verify contents of merge result
     @@ t/t3310-notes-merge-manual-resolve.sh: EOF
       	git log -1 --format=%B refs/notes/m > merge_commit_msg &&
      -	grep -q refs/notes/m merge_commit_msg &&
      -	grep -q refs/notes/z merge_commit_msg &&
     -+	test_grep refs/notes/m merge_commit_msg &&
     -+	test_grep refs/notes/z merge_commit_msg &&
     ++	test_grep -q refs/notes/m merge_commit_msg &&
     ++	test_grep -q refs/notes/z merge_commit_msg &&
       	# Merge commit mentions conflicting notes
      -	grep -q "Conflicts" merge_commit_msg &&
     -+	test_grep "Conflicts" merge_commit_msg &&
     ++	test_grep -q "Conflicts" merge_commit_msg &&
       	( for sha1 in $(cat expect_conflicts); do
      -		grep -q "$sha1" merge_commit_msg ||
     -+		test_grep "$sha1" merge_commit_msg ||
     ++		test_grep -q "$sha1" merge_commit_msg ||
       		exit 1
       	done ) &&
       	# Verify contents of merge result
     @@ t/t3404-rebase-interactive.sh: test_expect_success 'rebase -i --root retain root
       	) &&
       	git cat-file commit HEAD >output &&
      -	grep -q "^author Twerp Snog" output &&
     -+	test_grep "^author Twerp Snog" output &&
     ++	test_grep -q "^author Twerp Snog" output &&
       	git cat-file commit HEAD >actual &&
      -	grep -q "^different author$" actual
     -+	test_grep "^different author$" actual
     ++	test_grep -q "^different author$" actual
       '
       
       test_expect_success 'rebase -i --root temporary sentinel commit' '
     @@ t/t3420-rebase-autostash.sh: testrebase () {
       		test_when_finished git stash drop &&
       		test_path_is_missing $dotest/autostash &&
      -		! grep dirty file3 &&
     ++		! grep dirty file3 && # lint-ok: file may not exist after --quit
       		git stash show -p >actual &&
       		test_cmp expect actual &&
       		git reset --hard &&
     @@ t/t3501-revert-cherry-pick.sh: test_expect_success 'cherry-pick works with dirty
       	git cherry-pick refs/heads/unrelated &&
       	test $(git rev-parse :0:renamed) = $(git rev-parse HEAD~2:to-rename.t) &&
      -	grep -q "^modified$" renamed
     -+	test_grep "^modified$" renamed
     ++	test_grep -q "^modified$" renamed
       '
       
       test_expect_success 'advice from failed revert' '
     @@ t/t3800-mktag.sh: test_expect_success 'invalid header entry config & fsck' '
       cat >tag.sig <<EOF
      
       ## t/t3901-i18n-patch.sh ##
     -@@ t/t3901-i18n-patch.sh: check_encoding () {
     - 		git cat-file commit HEAD~$j |
     - 		case "$header" in
     - 		8859)
     --			grep "^encoding ISO8859-1" ;;
     -+			grep "^encoding ISO8859-1" ;; # lint-ok: piped stdin via case
     - 		*)
     --			ret=0; grep "^encoding ISO8859-1" || ret=$?
     -+			ret=0; grep "^encoding ISO8859-1" || ret=$? # lint-ok: piped stdin via case
     - 			test "$ret" != 0 ;;
     - 		esac || return 1
     - 		j=$i
      @@ t/t3901-i18n-patch.sh: test_expect_success 'format-patch output (ISO-8859-1)' '
       
       	git format-patch --stdout main..HEAD^ >out-l1 &&
     @@ t/t4000-diff-format.sh: test_expect_success 'git diff-files --no-patch --patch s
       test_expect_success 'git diff-files --no-patch --patch-with-raw shows the patch and raw data' '
       	git diff-files --no-patch --patch-with-raw >actual &&
      -	grep -q "^:100644 100755 .* $ZERO_OID M	path0\$" actual &&
     -+	test_grep "^:100644 100755 .* $ZERO_OID M	path0\$" actual &&
     ++	test_grep -q "^:100644 100755 .* $ZERO_OID M	path0\$" actual &&
       	tail -n +4 actual >actual-patch &&
       	compare_diff_patch expected actual-patch
       '
     @@ t/t5300-pack-object.sh: test_expect_success !PTHREADS,!FAIL_PREREQS \
       '
       
       test_expect_success 'pack-objects in too-many-packs mode' '
     -@@ t/t5300-pack-object.sh: test_expect_success '--path-walk pack everything' '
     +@@ t/t5300-pack-object.sh: test_expect_success '--name-hash-version=2 and --write-bitmap-index are incompat
     + 
     + 	# --stdout option silently removes --write-bitmap-index
     + 	git pack-objects --stdout --all --name-hash-version=2 --write-bitmap-index >out 2>err &&
     +-	! test_grep "currently, --write-bitmap-index requires --name-hash-version=1" err
     ++	test_grep ! "currently, --write-bitmap-index requires --name-hash-version=1" err
     + '
     + 
     + test_expect_success '--path-walk pack everything' '
       	git -C server rev-parse HEAD >in &&
       	GIT_PROGRESS_DELAY=0 git -C server pack-objects \
       		--stdout --revs --path-walk --progress <in >out.pack 2>err &&
     @@ t/t5319-multi-pack-index.sh: test_expect_success 'git-fsck incorrect offset' '
       '
       
       test_expect_success 'corrupt MIDX is not reused' '
     -@@ t/t5319-multi-pack-index.sh: test_expect_success 'usage shown without sub-command' '
     +@@ t/t5319-multi-pack-index.sh: test_expect_success 'load reverse index when missing .idx, .pack' '
     + 
     + test_expect_success 'usage shown without sub-command' '
     + 	test_expect_code 129 git multi-pack-index 2>err &&
     +-	! test_grep "unrecognized subcommand" err
     ++	test_grep ! "unrecognized subcommand" err
     + '
       
       test_expect_success 'complains when run outside of a repository' '
       	nongit test_must_fail git multi-pack-index write 2>err &&
     @@ t/t5326-multi-pack-bitmaps.sh: test_midx_bitmap_cases () {
       
       			(
      -				grep -vf before commits.raw &&
     -+				test_grep -vf before commits.raw &&
     ++				grep -vf before commits.raw && # lint-ok: data filter
       				# mark missing commits as preferred
       				sed "s/^/+/" before
       			) >snapshot &&
     @@ t/t5409-colorize-remote-messages.sh: test_expect_success 'setup' '
       
       test_expect_success 'disallow (color) control sequences in sideband' '
      
     - ## t/t5411/test-0013-bad-protocol.sh ##
     -@@ t/t5411/test-0013-bad-protocol.sh: test_expect_success "proc-receive: bad protocol (hook --die-read-version, $PROTO
     - 	 ! [remote rejected] HEAD -> refs/for/main/topic (fail to run proc-receive hook)
     - 	EOF
     - 	test_cmp expect actual &&
     --	grep "remote: fatal: die with the --die-read-version option" out-$test_count &&
     --	grep "remote: error: fail to negotiate version with proc-receive hook" out-$test_count &&
     -+	test_grep "remote: fatal: die with the --die-read-version option" out-$test_count &&
     -+	test_grep "remote: error: fail to negotiate version with proc-receive hook" out-$test_count &&
     - 
     - 	test_cmp_refs -C "$upstream" <<-\EOF
     - 	<COMMIT-A> refs/heads/main
     -@@ t/t5411/test-0013-bad-protocol.sh: test_expect_success "proc-receive: bad protocol (hook --die-write-version, $PROT
     - 	 ! [remote rejected] HEAD -> refs/for/main/topic (fail to run proc-receive hook)
     - 	EOF
     - 	test_cmp expect actual &&
     --	grep "remote: fatal: die with the --die-write-version option" out-$test_count &&
     --	grep "remote: error: fail to negotiate version with proc-receive hook" out-$test_count &&
     -+	test_grep "remote: fatal: die with the --die-write-version option" out-$test_count &&
     -+	test_grep "remote: error: fail to negotiate version with proc-receive hook" out-$test_count &&
     - 
     - 	test_cmp_refs -C "$upstream" <<-EOF
     - 	<COMMIT-A> refs/heads/main
     -@@ t/t5411/test-0013-bad-protocol.sh: test_expect_success "proc-receive: bad protocol (hook --die-read-commands, $PROT
     - 	 ! [remote rejected] HEAD -> refs/for/main/topic (fail to run proc-receive hook)
     - 	EOF
     - 	test_cmp expect actual &&
     --	grep "remote: fatal: die with the --die-read-commands option" out-$test_count &&
     -+	test_grep "remote: fatal: die with the --die-read-commands option" out-$test_count &&
     - 
     - 	test_cmp_refs -C "$upstream" <<-EOF
     - 	<COMMIT-A> refs/heads/main
     -@@ t/t5411/test-0013-bad-protocol.sh: test_expect_success "proc-receive: bad protocol (hook --die-read-push-options, $
     - 	 ! [remote rejected] HEAD -> refs/for/main/topic (fail to run proc-receive hook)
     - 	EOF
     - 	test_cmp expect actual &&
     --	grep "remote: fatal: die with the --die-read-push-options option" out-$test_count &&
     -+	test_grep "remote: fatal: die with the --die-read-push-options option" out-$test_count &&
     - 
     - 	test_cmp_refs -C "$upstream" <<-EOF
     - 	<COMMIT-A> refs/heads/main
     -@@ t/t5411/test-0013-bad-protocol.sh: test_expect_success "proc-receive: bad protocol (hook --die-write-report, $PROTO
     - 	 ! [remote rejected] HEAD -> refs/for/main/topic (fail to run proc-receive hook)
     - 	EOF
     - 	test_cmp expect actual &&
     --	grep "remote: fatal: die with the --die-write-report option" out-$test_count &&
     -+	test_grep "remote: fatal: die with the --die-write-report option" out-$test_count &&
     - 
     - 	test_cmp_refs -C "$upstream" <<-EOF
     - 	<COMMIT-A> refs/heads/main
     -
     - ## t/t5411/test-0014-bad-protocol--porcelain.sh ##
     -@@ t/t5411/test-0014-bad-protocol--porcelain.sh: test_expect_success "proc-receive: bad protocol (hook --die-read-version, $PROTO
     - 	Done
     - 	EOF
     - 	test_cmp expect actual &&
     --	grep "remote: fatal: die with the --die-read-version option" out-$test_count &&
     --	grep "remote: error: fail to negotiate version with proc-receive hook" out-$test_count &&
     -+	test_grep "remote: fatal: die with the --die-read-version option" out-$test_count &&
     -+	test_grep "remote: error: fail to negotiate version with proc-receive hook" out-$test_count &&
     - 
     - 	test_cmp_refs -C "$upstream" <<-EOF
     - 	<COMMIT-A> refs/heads/main
     -@@ t/t5411/test-0014-bad-protocol--porcelain.sh: test_expect_success "proc-receive: bad protocol (hook --die-write-version, $PROT
     - 	Done
     - 	EOF
     - 	test_cmp expect actual &&
     --	grep "remote: fatal: die with the --die-write-version option" out-$test_count &&
     --	grep "remote: error: fail to negotiate version with proc-receive hook" out-$test_count &&
     -+	test_grep "remote: fatal: die with the --die-write-version option" out-$test_count &&
     -+	test_grep "remote: error: fail to negotiate version with proc-receive hook" out-$test_count &&
     - 
     - 	test_cmp_refs -C "$upstream" <<-EOF
     - 	<COMMIT-A> refs/heads/main
     -@@ t/t5411/test-0014-bad-protocol--porcelain.sh: test_expect_success "proc-receive: bad protocol (hook --die-read-commands, $PROT
     - 	Done
     - 	EOF
     - 	test_cmp expect actual &&
     --	grep "remote: fatal: die with the --die-read-commands option" out-$test_count &&
     -+	test_grep "remote: fatal: die with the --die-read-commands option" out-$test_count &&
     - 
     - 	test_cmp_refs -C "$upstream" <<-EOF
     - 	<COMMIT-A> refs/heads/main
     -@@ t/t5411/test-0014-bad-protocol--porcelain.sh: test_expect_success "proc-receive: bad protocol (hook --die-read-push-options, $
     - 	Done
     - 	EOF
     - 	test_cmp expect actual &&
     --	grep "remote: fatal: die with the --die-read-push-options option" out-$test_count &&
     -+	test_grep "remote: fatal: die with the --die-read-push-options option" out-$test_count &&
     - 
     - 	test_cmp_refs -C "$upstream" <<-EOF
     - 	<COMMIT-A> refs/heads/main
     -@@ t/t5411/test-0014-bad-protocol--porcelain.sh: test_expect_success "proc-receive: bad protocol (hook --die-write-report, $PROTO
     - 	Done
     - 	EOF
     - 	test_cmp expect actual &&
     --	grep "remote: fatal: die with the --die-write-report option" out-$test_count &&
     -+	test_grep "remote: fatal: die with the --die-write-report option" out-$test_count &&
     - 
     - 	test_cmp_refs -C "$upstream" <<-EOF
     - 	<COMMIT-A> refs/heads/main
     -
       ## t/t5500-fetch-pack.sh ##
      @@ t/t5500-fetch-pack.sh: test_expect_success 'single given branch clone' '
       	GIT_TRACE2_EVENT="$(pwd)/branch-a/trace2_event" \
     @@ t/t5516-fetch-push.sh: test_expect_success 'push --porcelain' '
       	mk_empty testrepo &&
       	test_must_fail git push >.git/bar --porcelain asdfasdfasd refs/heads/main:refs/remotes/origin/main &&
      -	! grep -q Done .git/bar
     -+	test_grep ! Done .git/bar
     ++	test_grep ! -q Done .git/bar
       '
       
       test_expect_success 'push --porcelain rejected' '
     @@ t/t5520-pull.sh: test_expect_success '--rebase with rebase.autostash succeeds on
       	git -C dst pull --rebase >actual 2>&1 &&
      -	grep -q "Fast-forward" actual &&
      -	grep -q "Applied autostash." actual
     -+	test_grep "Fast-forward" actual &&
     -+	test_grep "Applied autostash." actual
     ++	test_grep -q "Fast-forward" actual &&
     ++	test_grep -q "Applied autostash." actual
       '
       
       test_expect_success '--rebase with conflicts shows advice' '
     @@ t/t5537-fetch-shallow.sh: test_expect_success '.git/shallow is edited by repack'
       	git -C shallow-client repack -adfl &&
       	test_must_fail git -C shallow-client rev-parse --verify $d^0 &&
      -	! grep $d shallow-client/.git/shallow &&
     -+	test_grep ! $d shallow-client/.git/shallow &&
     ++	! grep $d shallow-client/.git/shallow && # lint-ok: file may not exist after repack
       
       	git -C shallow-server branch branch-orig $d &&
       	git -C shallow-client fetch --prune --depth=2 \
     @@ t/t5702-protocol-v2.sh: test_expect_success 'when server does not send "ready",
       	test_grep "expected no other sections to be sent after no .ready." err
       '
       
     +@@ t/t5702-protocol-v2.sh: test_expect_success 'part of packfile response provided as URI' '
     + 	do
     + 		git verify-pack --object-format=$(test_oid algo) --verbose $idx >out &&
     + 		{
     +-			grep -E "^[0-9a-f]{16,} " out || :
     ++			grep -E "^[0-9a-f]{16,} " out || : # lint-ok: data filter
     + 		} >out.objectlist &&
     + 		if test_line_count = 1 out.objectlist
     + 		then
      @@ t/t5702-protocol-v2.sh: test_expect_success 'packfile-uri path redacted in trace' '
       		-c fetch.uriprotocols=http,https \
       		clone "$HTTPD_URL/smart/http_parent" http_child &&
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to does not change
       	git config branch.from-main.merge > actual &&
       	git rev-parse from-topic_2 >actual2 &&
      -	grep -q "^refs/heads/main$" actual &&
     -+	test_grep "^refs/heads/main$" actual &&
     ++	test_grep -q "^refs/heads/main$" actual &&
       	cmp expect2 actual2
       '
       
     @@ t/t6423-merge-rename-directories.sh: test_expect_success '5c: Transitive rename
       		test_path_is_missing x/d &&
       		test_path_is_file y/d &&
      -		grep -q "<<<<" y/d  # conflict markers should be present
     -+		test_grep "<<<<" y/d  # conflict markers should be present
     ++		test_grep -q "<<<<" y/d  # conflict markers should be present
       	)
       '
       
     @@ t/t6423-merge-rename-directories.sh: test_expect_success '9e: N-to-1 whammo' '
      -		grep -q dir2/yo error_line &&
      -		grep -q dir3/yo error_line &&
      -		grep -q dirN/yo error_line &&
     -+		test_grep dir1/yo error_line &&
     -+		test_grep dir2/yo error_line &&
     -+		test_grep dir3/yo error_line &&
     -+		test_grep dirN/yo error_line &&
     ++		test_grep -q dir1/yo error_line &&
     ++		test_grep -q dir2/yo error_line &&
     ++		test_grep -q dir3/yo error_line &&
     ++		test_grep -q dirN/yo error_line &&
       
       		git ls-files -s >out &&
       		test_line_count = 16 out &&
     @@ t/t6423-merge-rename-directories.sh: test_expect_success '11b: Avoid losing dirt
       		test_grep "error: Your local changes to the following files would be overwritten by merge" err &&
       
      -		grep -q stuff z/c &&
     -+		test_grep stuff z/c &&
     ++		test_grep -q stuff z/c &&
       		test_seq 1 10 >expected &&
       		echo stuff >>expected &&
       		test_cmp expected z/c
     @@ t/t6423-merge-rename-directories.sh: test_expect_success '11c: Avoid losing not-
       		test_grep "error: Your local changes to the following files would be overwritten by merge" err &&
       
      -		grep -q stuff y/c &&
     -+		test_grep stuff y/c &&
     ++		test_grep -q stuff y/c &&
       		test_seq 1 10 >expected &&
       		echo stuff >>expected &&
       		test_cmp expected y/c &&
     @@ t/t6423-merge-rename-directories.sh: test_expect_success '11d: Avoid losing not-
       		test_grep "error: Your local changes to the following files would be overwritten by merge" err &&
       
      -		grep -q stuff z/c &&
     -+		test_grep stuff z/c &&
     ++		test_grep -q stuff z/c &&
       		test_seq 1 10 >expected &&
       		echo stuff >>expected &&
       		test_cmp expected z/c
     @@ t/t6437-submodule-merge.sh: test_expect_success 'merging should fail for changes
       	)
       '
       
     -@@ t/t6437-submodule-merge.sh: test_expect_success 'file/submodule conflict' '
     - 		# directory, though, so just grep for its content in all
     - 		# files, and ignore "grep: path: Is a directory" message
     - 		echo Checking if contents from B:path showed up anywhere &&
     --		grep -q content * 2>/dev/null
     -+		grep -q content * 2>/dev/null # lint-ok: glob arg breaks test_grep
     - 	)
     - '
     - 
      @@ t/t6437-submodule-merge.sh: test_expect_success 'merging should fail with no merge base' '
       	git commit -m "b" &&
       	test_must_fail git merge a 2>actual &&
     @@ t/t7012-skip-worktree-writing.sh: test_expect_success 'read-tree updates worktre
       	echo dirty >> init.t &&
       	test_must_fail git read-tree -m -u HEAD^ &&
      -	grep -q dirty init.t &&
     -+	test_grep dirty init.t &&
     ++	test_grep -q dirty init.t &&
       	test "$(git ls-files -t init.t)" = "S init.t" &&
       	git update-index --no-skip-worktree init.t
       '
     @@ t/t7012-skip-worktree-writing.sh: test_expect_success 'read-tree removes worktre
       	echo dirty >> added &&
       	test_must_fail git read-tree -m -u HEAD^ &&
      -	grep -q dirty added &&
     -+	test_grep dirty added &&
     ++	test_grep -q dirty added &&
       	test "$(git ls-files -t added)" = "S added" &&
       	git update-index --no-skip-worktree added
       '
     @@ t/t7450-bad-git-dotfiles.sh: test_expect_success WINDOWS 'prevent git~1 squattin
       			clone --recurse-submodules squatting squatting-clone 2>err &&
       		test_grep -e "directory not empty" -e "not an empty directory" err &&
      -		! grep gitdir squatting-clone/d/a/git~2
     -+		! grep gitdir squatting-clone/d/a/git~2 # lint-ok: file may not exist
     ++		! grep gitdir squatting-clone/d/a/git~2 # lint-ok: file may not exist after failed clone
       	fi
       '
       
     @@ t/t7501-commit-basic-functionality.sh: test_expect_success 'editor not invoked i
       	EDITOR=./editor git commit -a -F msg &&
       	git show -s --pretty=format:%s >subject &&
      -	grep -q good subject &&
     -+	test_grep good subject &&
     ++	test_grep -q good subject &&
       
       	echo quack >file &&
       	echo Another good message. |
       	EDITOR=./editor git commit -a -F - &&
       	git show -s --pretty=format:%s >subject &&
      -	grep -q good subject
     -+	test_grep good subject
     ++	test_grep -q good subject
       '
       
       test_expect_success 'partial commit that involves removal (1)' '
     @@ t/t7501-commit-basic-functionality.sh: test_expect_success 'amend does not add s
       
       test_expect_success 'commit complains about completely bogus dates' '
      @@ t/t7501-commit-basic-functionality.sh: test_expect_success 'git commit <file> with dirty index' '
     + 	git add chz &&
     + 	git commit elif -m "tacocat is a palindrome" &&
       	git show --stat >stat &&
     - 	grep elif stat &&
     +-	grep elif stat &&
     ++	test_grep elif stat &&
       	git diff --cached >diff &&
      -	grep chz diff
      +	test_grep chz diff
     @@ t/t7510-signed-commit.sh: test_expect_success GPG 'verify and show signatures' '
      -	grep -q -F -e "No public key" -e "public key not found" actual
      +	test_grep ! "Good signature from" actual &&
      +	test_grep ! "BAD signature from" actual &&
     -+	test_grep -F -e "No public key" -e "public key not found" actual
     ++	test_grep -q -F -e "No public key" -e "public key not found" actual
       '
       
       test_expect_success GPG 'verify-commit exits success on untrusted signature' '
     @@ t/t7519-status-fsmonitor.sh: test_expect_success 'setup' '
       cat >expect <<EOF &&
      
       ## t/t7527-builtin-fsmonitor.sh ##
     -@@ t/t7527-builtin-fsmonitor.sh: verify_fsmonitor_works () {
     - 			--token 0 >/dev/null 2>&1
     - 	maybe_timeout 5 \
     - 		git -C test_fsmonitor_smoke fsmonitor--daemon stop 2>/dev/null
     --	! grep -q "cookie_wait timed out" "$PWD/smoke.trace" 2>/dev/null
     -+	! grep -q "cookie_wait timed out" "$PWD/smoke.trace" 2>/dev/null # lint-ok: $? capture
     - 	ret=$?
     - 	rm -rf test_fsmonitor_smoke smoke.trace
     - 	return $ret
      @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'implicit daemon start' '
       	GIT_TRACE2_EVENT="$PWD/.git/trace" \
       		test-tool -C test_implicit fsmonitor-client query --token 0 >actual &&
     @@ t/t7527-builtin-fsmonitor.sh: test_expect_success CASE_INSENSITIVE_FS 'fsmonitor
       
      -	grep -q "AAA.*pos 0" "$PWD/subdir_case_wrong.log1" &&
      -	grep -q "zzz.*pos 6" "$PWD/subdir_case_wrong.log1" &&
     -+	test_grep "AAA.*pos 0" "$PWD/subdir_case_wrong.log1" &&
     -+	test_grep "zzz.*pos 6" "$PWD/subdir_case_wrong.log1" &&
     ++	test_grep -q "AAA.*pos 0" "$PWD/subdir_case_wrong.log1" &&
     ++	test_grep -q "zzz.*pos 6" "$PWD/subdir_case_wrong.log1" &&
       
      -	grep -q "dir1/DIR2/dir3/file3.*pos -3" "$PWD/subdir_case_wrong.log1" &&
     -+	test_grep "dir1/DIR2/dir3/file3.*pos -3" "$PWD/subdir_case_wrong.log1" &&
     ++	test_grep -q "dir1/DIR2/dir3/file3.*pos -3" "$PWD/subdir_case_wrong.log1" &&
       
       	# Verify that we get a mapping event to correct the case.
      -	grep -q "MAP:.*dir1/DIR2/dir3/file3.*dir1/dir2/dir3/file3" \
     -+	test_grep "MAP:.*dir1/DIR2/dir3/file3.*dir1/dir2/dir3/file3" \
     ++	test_grep -q "MAP:.*dir1/DIR2/dir3/file3.*dir1/dir2/dir3/file3" \
       		"$PWD/subdir_case_wrong.log1" &&
       
       	# The refresh-callbacks should have caused "git status" to clear
     @@ t/t7527-builtin-fsmonitor.sh: test_expect_success CASE_INSENSITIVE_FS 'fsmonitor
      -	grep -q " M AAA" "$PWD/subdir_case_wrong.out" &&
      -	grep -q " M zzz" "$PWD/subdir_case_wrong.out" &&
      -	grep -q " M dir1/dir2/dir3/file3" "$PWD/subdir_case_wrong.out"
     -+	test_grep " M AAA" "$PWD/subdir_case_wrong.out" &&
     -+	test_grep " M zzz" "$PWD/subdir_case_wrong.out" &&
     -+	test_grep " M dir1/dir2/dir3/file3" "$PWD/subdir_case_wrong.out"
     ++	test_grep -q " M AAA" "$PWD/subdir_case_wrong.out" &&
     ++	test_grep -q " M zzz" "$PWD/subdir_case_wrong.out" &&
     ++	test_grep -q " M dir1/dir2/dir3/file3" "$PWD/subdir_case_wrong.out"
       '
       
       test_expect_success CASE_INSENSITIVE_FS 'fsmonitor file case wrong on disk' '
     @@ t/t7527-builtin-fsmonitor.sh: test_expect_success CASE_INSENSITIVE_FS 'fsmonitor
      -	grep -q "fsmonitor_refresh_callback.*file-3-a.*pos 4"  "$PWD/file_case_wrong-try1.log" &&
      -	grep -q "fsmonitor_refresh_callback.*FILE-4-A.*pos 6"  "$PWD/file_case_wrong-try1.log" &&
      -	grep -q "fsmonitor_refresh_callback.*file-4-a.*pos -9" "$PWD/file_case_wrong-try1.log" &&
     -+	test_grep "fsmonitor_refresh_callback.*FILE-3-A.*pos -3" "$PWD/file_case_wrong-try1.log" &&
     -+	test_grep "fsmonitor_refresh_callback.*file-3-a.*pos 4"  "$PWD/file_case_wrong-try1.log" &&
     -+	test_grep "fsmonitor_refresh_callback.*FILE-4-A.*pos 6"  "$PWD/file_case_wrong-try1.log" &&
     -+	test_grep "fsmonitor_refresh_callback.*file-4-a.*pos -9" "$PWD/file_case_wrong-try1.log" &&
     ++	test_grep -q "fsmonitor_refresh_callback.*FILE-3-A.*pos -3" "$PWD/file_case_wrong-try1.log" &&
     ++	test_grep -q "fsmonitor_refresh_callback.*file-3-a.*pos 4"  "$PWD/file_case_wrong-try1.log" &&
     ++	test_grep -q "fsmonitor_refresh_callback.*FILE-4-A.*pos 6"  "$PWD/file_case_wrong-try1.log" &&
     ++	test_grep -q "fsmonitor_refresh_callback.*file-4-a.*pos -9" "$PWD/file_case_wrong-try1.log" &&
       
       	# FSM refresh will have invalidated the FSM bit and cause a regular
       	# (real) scan of these tracked files, so they should have "H" status.
     @@ t/t7527-builtin-fsmonitor.sh: test_expect_success CASE_INSENSITIVE_FS 'fsmonitor
       	git -C file_case_wrong ls-files -f >"$PWD/file_case_wrong-lsf1.out" &&
      -	grep -q "H dir1/dir2/dir3/file-3-a" "$PWD/file_case_wrong-lsf1.out" &&
      -	grep -q "H dir1/dir2/dir4/FILE-4-A" "$PWD/file_case_wrong-lsf1.out" &&
     -+	test_grep "H dir1/dir2/dir3/file-3-a" "$PWD/file_case_wrong-lsf1.out" &&
     -+	test_grep "H dir1/dir2/dir4/FILE-4-A" "$PWD/file_case_wrong-lsf1.out" &&
     ++	test_grep -q "H dir1/dir2/dir3/file-3-a" "$PWD/file_case_wrong-lsf1.out" &&
     ++	test_grep -q "H dir1/dir2/dir4/FILE-4-A" "$PWD/file_case_wrong-lsf1.out" &&
       
       
       	# Try the status again. We assume that the above status command
     @@ t/t7527-builtin-fsmonitor.sh: test_expect_success CASE_INSENSITIVE_FS 'fsmonitor
      -	! grep -q "fsmonitor_refresh_callback.*file-3-a.*pos" "$PWD/file_case_wrong-try2.log" &&
      -	! grep -q "fsmonitor_refresh_callback.*FILE-4-A.*pos" "$PWD/file_case_wrong-try2.log" &&
      -	! grep -q "fsmonitor_refresh_callback.*file-4-a.*pos" "$PWD/file_case_wrong-try2.log" &&
     -+	test_grep ! "fsmonitor_refresh_callback.*FILE-3-A.*pos" "$PWD/file_case_wrong-try2.log" &&
     -+	test_grep ! "fsmonitor_refresh_callback.*file-3-a.*pos" "$PWD/file_case_wrong-try2.log" &&
     -+	test_grep ! "fsmonitor_refresh_callback.*FILE-4-A.*pos" "$PWD/file_case_wrong-try2.log" &&
     -+	test_grep ! "fsmonitor_refresh_callback.*file-4-a.*pos" "$PWD/file_case_wrong-try2.log" &&
     ++	test_grep ! -q "fsmonitor_refresh_callback.*FILE-3-A.*pos" "$PWD/file_case_wrong-try2.log" &&
     ++	test_grep ! -q "fsmonitor_refresh_callback.*file-3-a.*pos" "$PWD/file_case_wrong-try2.log" &&
     ++	test_grep ! -q "fsmonitor_refresh_callback.*FILE-4-A.*pos" "$PWD/file_case_wrong-try2.log" &&
     ++	test_grep ! -q "fsmonitor_refresh_callback.*file-4-a.*pos" "$PWD/file_case_wrong-try2.log" &&
       
       	# FSM refresh saw nothing, so it will mark all files as valid,
       	# so they should now have "h" status.
     @@ t/t7527-builtin-fsmonitor.sh: test_expect_success CASE_INSENSITIVE_FS 'fsmonitor
       	git -C file_case_wrong ls-files -f >"$PWD/file_case_wrong-lsf2.out" &&
      -	grep -q "h dir1/dir2/dir3/file-3-a" "$PWD/file_case_wrong-lsf2.out" &&
      -	grep -q "h dir1/dir2/dir4/FILE-4-A" "$PWD/file_case_wrong-lsf2.out" &&
     -+	test_grep "h dir1/dir2/dir3/file-3-a" "$PWD/file_case_wrong-lsf2.out" &&
     -+	test_grep "h dir1/dir2/dir4/FILE-4-A" "$PWD/file_case_wrong-lsf2.out" &&
     ++	test_grep -q "h dir1/dir2/dir3/file-3-a" "$PWD/file_case_wrong-lsf2.out" &&
     ++	test_grep -q "h dir1/dir2/dir4/FILE-4-A" "$PWD/file_case_wrong-lsf2.out" &&
       
       
       	# We now have files with clean content, but with case-incorrect
     @@ t/t7527-builtin-fsmonitor.sh: test_expect_success CASE_INSENSITIVE_FS 'fsmonitor
       
       	# Verify that we get a mapping event to correct the case.
      -	grep -q "fsmonitor_refresh_callback MAP:.*dir1/dir2/dir3/FILE-3-A.*dir1/dir2/dir3/file-3-a" \
     -+	test_grep "fsmonitor_refresh_callback MAP:.*dir1/dir2/dir3/FILE-3-A.*dir1/dir2/dir3/file-3-a" \
     ++	test_grep -q "fsmonitor_refresh_callback MAP:.*dir1/dir2/dir3/FILE-3-A.*dir1/dir2/dir3/file-3-a" \
       		"$PWD/file_case_wrong-try3.log" &&
      -	grep -q "fsmonitor_refresh_callback MAP:.*dir1/dir2/dir4/file-4-a.*dir1/dir2/dir4/FILE-4-A" \
     -+	test_grep "fsmonitor_refresh_callback MAP:.*dir1/dir2/dir4/file-4-a.*dir1/dir2/dir4/FILE-4-A" \
     ++	test_grep -q "fsmonitor_refresh_callback MAP:.*dir1/dir2/dir4/file-4-a.*dir1/dir2/dir4/FILE-4-A" \
       		"$PWD/file_case_wrong-try3.log" &&
       
       	# FSEvents are in observed case.
      -	grep -q "fsmonitor_refresh_callback.*FILE-3-A.*pos -3" "$PWD/file_case_wrong-try3.log" &&
      -	grep -q "fsmonitor_refresh_callback.*file-4-a.*pos -9" "$PWD/file_case_wrong-try3.log" &&
     -+	test_grep "fsmonitor_refresh_callback.*FILE-3-A.*pos -3" "$PWD/file_case_wrong-try3.log" &&
     -+	test_grep "fsmonitor_refresh_callback.*file-4-a.*pos -9" "$PWD/file_case_wrong-try3.log" &&
     ++	test_grep -q "fsmonitor_refresh_callback.*FILE-3-A.*pos -3" "$PWD/file_case_wrong-try3.log" &&
     ++	test_grep -q "fsmonitor_refresh_callback.*file-4-a.*pos -9" "$PWD/file_case_wrong-try3.log" &&
       
       	# The refresh-callbacks should have caused "git status" to clear
       	# the CE_FSMONITOR_VALID bit on each of those files and caused
       	# the worktree scan to visit them and mark them as modified.
      -	grep -q " M dir1/dir2/dir3/file-3-a" "$PWD/file_case_wrong-try3.out" &&
      -	grep -q " M dir1/dir2/dir4/FILE-4-A" "$PWD/file_case_wrong-try3.out"
     -+	test_grep " M dir1/dir2/dir3/file-3-a" "$PWD/file_case_wrong-try3.out" &&
     -+	test_grep " M dir1/dir2/dir4/FILE-4-A" "$PWD/file_case_wrong-try3.out"
     ++	test_grep -q " M dir1/dir2/dir3/file-3-a" "$PWD/file_case_wrong-try3.out" &&
     ++	test_grep -q " M dir1/dir2/dir4/FILE-4-A" "$PWD/file_case_wrong-try3.out"
       '
       
       test_done
     @@ t/t7700-repack.sh: test_expect_success 'repack --keep-pack' '
       		ls .git/objects/pack/*.pack >new-counts &&
      -		grep -q $P1 new-counts &&
      -		grep -q $P4 new-counts &&
     -+		test_grep $P1 new-counts &&
     -+		test_grep $P4 new-counts &&
     ++		test_grep -q $P1 new-counts &&
     ++		test_grep -q $P4 new-counts &&
       		test_line_count = 3 new-counts &&
       		git fsck &&
       
     @@ t/t7703-repack-geometric.sh: test_expect_success '--geometric with small-pack ro
       		test_line_count = 3 after &&
       		comm -3 small before | tr -d "\t" >large &&
      -		grep -qFf large after
     -+		test_grep -Ff large after
     ++		test_grep -qFf large after
       	)
       '
       
     @@ t/t9117-git-svn-init-clone.sh: test_expect_success 'clone to target directory wi
       	test ! -d trunk &&
       	git svn init "$svnrepo"/project/trunk trunk 2>warning &&
      -	! grep -q prefix warning &&
     -+	test_grep ! prefix warning &&
     ++	test_grep ! -q prefix warning &&
       	rm -rf trunk &&
       	rm -f warning
       	'
     @@ t/t9117-git-svn-init-clone.sh: test_expect_success 'init without -s/-T/-b/-t doe
       	test ! -d trunk &&
       	git svn clone "$svnrepo"/project/trunk 2>warning &&
      -	! grep -q prefix warning &&
     -+	test_grep ! prefix warning &&
     ++	test_grep ! -q prefix warning &&
       	rm -rf trunk &&
       	rm -f warning
       	'
     @@ t/t9117-git-svn-init-clone.sh: EOF
       	test ! -d project &&
       	git svn init -s "$svnrepo"/project project 2>warning &&
      -	! grep -q prefix warning &&
     -+	test_grep ! prefix warning &&
     ++	test_grep ! -q prefix warning &&
       	test_svn_configured_prefix "origin/" &&
       	rm -rf project &&
       	rm -f warning
     @@ t/t9117-git-svn-init-clone.sh: test_expect_success 'init with -s/-T/-b/-t assume
       	test ! -d project &&
       	git svn clone -s "$svnrepo"/project 2>warning &&
      -	! grep -q prefix warning &&
     -+	test_grep ! prefix warning &&
     ++	test_grep ! -q prefix warning &&
       	test_svn_configured_prefix "origin/" &&
       	rm -rf project &&
       	rm -f warning
     @@ t/t9117-git-svn-init-clone.sh: test_expect_success 'clone with -s/-T/-b/-t assum
       	test ! -d project &&
       	git svn init -s "$svnrepo"/project project --prefix "" 2>warning &&
      -	! grep -q prefix warning &&
     -+	test_grep ! prefix warning &&
     ++	test_grep ! -q prefix warning &&
       	test_svn_configured_prefix "" &&
       	rm -rf project &&
       	rm -f warning
     @@ t/t9117-git-svn-init-clone.sh: test_expect_success 'init with -s/-T/-b/-t and --
       	test ! -d project &&
       	git svn clone -s "$svnrepo"/project --prefix "" 2>warning &&
      -	! grep -q prefix warning &&
     -+	test_grep ! prefix warning &&
     ++	test_grep ! -q prefix warning &&
       	test_svn_configured_prefix "" &&
       	rm -rf project &&
       	rm -f warning
     @@ t/t9502-gitweb-standalone-parse-output.sh: test_expect_success 'forks: setup' '
      -	grep -q ">foo_baz\\.git<"        gitweb.body &&
      -	grep -q ">foo/foo-forked\\.git<" gitweb.body &&
      -	grep -q ">fork of .*<"           gitweb.body
     -+	test_grep ">\\.git<"               gitweb.body &&
     -+	test_grep ">foo\\.git<"            gitweb.body &&
     -+	test_grep ">foo_baz\\.git<"        gitweb.body &&
     -+	test_grep ">foo\\.bar\\.git<"      gitweb.body &&
     -+	test_grep ">foo_baz\\.git<"        gitweb.body &&
     -+	test_grep ">foo/foo-forked\\.git<" gitweb.body &&
     -+	test_grep ">fork of .*<"           gitweb.body
     ++	test_grep -q ">\\.git<"               gitweb.body &&
     ++	test_grep -q ">foo\\.git<"            gitweb.body &&
     ++	test_grep -q ">foo_baz\\.git<"        gitweb.body &&
     ++	test_grep -q ">foo\\.bar\\.git<"      gitweb.body &&
     ++	test_grep -q ">foo_baz\\.git<"        gitweb.body &&
     ++	test_grep -q ">foo/foo-forked\\.git<" gitweb.body &&
     ++	test_grep -q ">fork of .*<"           gitweb.body
       '
       
       test_expect_success 'enable forks feature' '
     @@ t/t9502-gitweb-standalone-parse-output.sh: test_expect_success 'enable forks fea
      -	grep -q ">foo_baz\\.git<"        gitweb.body &&
      -	grep -v ">foo/foo-forked\\.git<" gitweb.body &&
      -	grep -v ">fork of .*<"           gitweb.body
     -+	test_grep ">\\.git<"               gitweb.body &&
     -+	test_grep ">foo\\.git<"            gitweb.body &&
     -+	test_grep ">foo_baz\\.git<"        gitweb.body &&
     -+	test_grep ">foo\\.bar\\.git<"      gitweb.body &&
     -+	test_grep ">foo_baz\\.git<"        gitweb.body &&
     ++	test_grep -q ">\\.git<"               gitweb.body &&
     ++	test_grep -q ">foo\\.git<"            gitweb.body &&
     ++	test_grep -q ">foo_baz\\.git<"        gitweb.body &&
     ++	test_grep -q ">foo\\.bar\\.git<"      gitweb.body &&
     ++	test_grep -q ">foo_baz\\.git<"        gitweb.body &&
      +	test_grep -v ">foo/foo-forked\\.git<" gitweb.body &&
      +	test_grep -v ">fork of .*<"           gitweb.body
       '
     @@ t/t9502-gitweb-standalone-parse-output.sh: test_expect_success 'enable forks fea
       	gitweb_run "p=foo.git;a=forks" &&
      -	grep -q ">foo/foo-forked\\.git<" gitweb.body &&
      -	grep -q ">fork of foo<"          gitweb.body
     -+	test_grep ">foo/foo-forked\\.git<" gitweb.body &&
     -+	test_grep ">fork of foo<"          gitweb.body
     ++	test_grep -q ">foo/foo-forked\\.git<" gitweb.body &&
     ++	test_grep -q ">fork of foo<"          gitweb.body
       '
       
       test_expect_success 'forks: can access forked repository' '
       	gitweb_run "p=foo/foo-forked.git;a=summary" &&
      -	grep -q "200 OK"        gitweb.headers &&
      -	grep -q ">fork of foo<" gitweb.body
     -+	test_grep "200 OK"        gitweb.headers &&
     -+	test_grep ">fork of foo<" gitweb.body
     ++	test_grep -q "200 OK"        gitweb.headers &&
     ++	test_grep -q ">fork of foo<" gitweb.body
       '
       
       test_expect_success 'forks: project_index lists all projects (incl. forks)' '
     @@ t/t9807-git-p4-submit.sh: test_expect_success 'submit --update-shelve' '
       		change=$(last_shelve) &&
       		p4 unshelve -c $change -s $change &&
      -		grep -q updated-line shelf.t &&
     -+		test_grep updated-line shelf.t &&
     ++		test_grep -q updated-line shelf.t &&
       		p4 describe -S $change | grep added-file.t &&
       		test_path_is_missing shelved-change-1.t &&
       		p4 revert ...
     @@ t/t9832-unshelve.sh: EOF
       		git p4 unshelve $change &&
       		git show refs/remotes/p4-unshelved/$change >actual &&
      -		grep -q "Further description" actual &&
     -+		test_grep "Further description" actual &&
     ++		test_grep -q "Further description" actual &&
       		git cherry-pick refs/remotes/p4-unshelved/$change &&
       		test_path_is_file file2 &&
       		test_cmp file1 "$cli"/file1 &&
     @@ t/t9832-unshelve.sh: test_expect_success 'create shelved changelist based on p4
       		change=$(last_shelved_change) &&
       		p4 describe -S $change >out.txt &&
      -		grep -q "Change to be unshelved" out.txt
     -+		test_grep "Change to be unshelved" out.txt
     ++		test_grep -q "Change to be unshelved" out.txt
       	)
       '
       
     @@ t/t9832-unshelve.sh: test_expect_success 'try to unshelve the change' '
       		cd "$git" &&
       		git p4 unshelve $change >out.txt &&
      -		grep -q "unshelved changelist $change" out.txt
     -+		test_grep "unshelved changelist $change" out.txt
     ++		test_grep -q "unshelved changelist $change" out.txt
       	)
       '
       
     @@ t/t9833-errors.sh: test_expect_success 'error handling' '
       		export P4PASSWD &&
       		test_must_fail git p4 clone //depot/foo 2>errmsg &&
      -		grep -q "failure accessing depot.*P4PASSWD" errmsg
     -+		test_grep "failure accessing depot.*P4PASSWD" errmsg
     ++		test_grep -q "failure accessing depot.*P4PASSWD" errmsg
       	)
       '
       
     @@ t/t9833-errors.sh: test_expect_success 'ticket logged out' '
       		p4 logout &&
       		test_must_fail git p4 submit 2>errmsg &&
      -		grep -q "failure accessing depot" errmsg
     -+		test_grep "failure accessing depot" errmsg
     ++		test_grep -q "failure accessing depot" errmsg
       	)
       '
       
     @@ t/t9902-completion.sh: test_expect_success '__git_pretty_aliases' '
       	run_completion "git " &&
       	# built-in
      -	grep -q "^add \$" out &&
     -+	test_grep "^add \$" out &&
     ++	test_grep -q "^add \$" out &&
       	# script
      -	grep -q "^rebase \$" out &&
     -+	test_grep "^rebase \$" out &&
     ++	test_grep -q "^rebase \$" out &&
       	# plumbing
      -	! grep -q "^ls-files \$" out &&
     -+	test_grep ! "^ls-files \$" out &&
     ++	test_grep ! -q "^ls-files \$" out &&
       
       	run_completion "git r" &&
      -	! grep -q -v "^r" out
     -+	test_grep ! -v "^r" out
     ++	test_grep ! -q -v "^r" out
       '
       
       test_expect_success 'double dash "git" itself' '
 4:  c1b90101ef ! 6:  e5ecb37401 t: add lint-style.pl with test_grep negation rule
     @@ Metadata
      Author: Michael Montalbo <mmontalbo@gmail.com>
      
       ## Commit message ##
     -    t: add lint-style.pl with test_grep negation rule
     +    t: add greplint to detect bare grep assertions
      
     -    Add a mechanical lint checker for test scripts, similar in spirit to
     -    check-non-portable-shell.pl but focused on test conventions rather
     -    than portability.
     +    Without a lint guard, bare grep assertions will creep back into
     +    tests over time, defeating the previous commit's conversion.
      
     -    The tool defines LintParser, a subclass of ScriptParser (from the
     -    shared lib-shell-parser.pl module).  ScriptParser's
     -    parse_cmd() finds test_expect_success blocks and calls check_test()
     -    for each body; LintParser overrides check_test() to run lint rules
     -    on the parsed commands.  A "# lint-ok" comment suppresses all
     -    checks for intentional style violations.
     +    Add greplint.pl to catch bare 'grep' used as a test assertion
     +    (where 'test_grep' should be used) and '! test_grep' (where
     +    'test_grep !' should be used).
      
     -    The first rule detects '! test_grep' and replaces it with
     -    'test_grep !'.  Shell-level negation suppresses the diagnostic
     -    output that test_grep prints on failure; the built-in negation
     -    preserves it.
     +    greplint.pl reuses the shared shell parser from lib-shell-parser.pl
     +    to tokenize test bodies.  The Lexer collapses heredocs, command
     +    substitutions, and quoted strings into single tokens, so 'grep'
     +    appearing inside these contexts is not flagged.  A flat walk over
     +    the token stream tracks command position and pipeline state to
     +    distinguish assertion greps from filter greps.
      
     -    Three violations inside test bodies are converted via --fix.  One
     -    additional violation in a helper function outside test_expect_success
     -    (t7900's test_geometric_repack_needed) is converted manually, since
     -    the parser only processes test bodies.
     +    For double-quoted test bodies, a source-line walk counts
     +    backslash-continuation lines that the Lexer consumes without
     +    emitting into the body text, adjusting the reported line number
     +    accordingly.
     +
     +    Add test fixtures in greplint/ (modeled on chainlint/) covering
     +    detection of bare grep assertions, correct skipping of filters,
     +    pipelines, redirects, command substitutions, and lint-ok annotations.
     +
     +    Wire into the Makefile as:
     +      - test-greplint: runs greplint.pl on $(T) $(THELPERS) $(TPERF)
     +      - check-greplint: runs greplint.pl on fixtures, diffs against expected
     +      - clean-greplint: removes temp dir
     +
     +    Add eol=lf entries in t/.gitattributes for greplint fixtures,
     +    matching chainlint, so that check-greplint passes on Windows
     +    where core.autocrlf would otherwise cause CRLF mismatches
     +    between expected and actual output.
      
          Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
      
     @@ t/.gitattributes
      @@
       t[0-9][0-9][0-9][0-9]/* -whitespace
       /chainlint/*.expect eol=lf -whitespace
     -+/lint-style/*.expect eol=lf -whitespace
     -+/lint-style/*.test eol=lf -whitespace
     ++/greplint/*.expect eol=lf -whitespace
     ++/greplint/*.test eol=lf -whitespace
       /t0110/url-* binary
       /t3206/* eol=lf
       /t3900/*.txt eol=lf
      
       ## t/Makefile ##
     -@@ t/Makefile: TPERF = $(sort $(wildcard perf/p[0-9][0-9][0-9][0-9]-*.sh))
     +@@ t/Makefile: TEST_LINT ?= test-lint
     + ifdef TEST_OUTPUT_DIRECTORY
     + TEST_RESULTS_DIRECTORY = $(TEST_OUTPUT_DIRECTORY)/test-results
     + CHAINLINTTMP = $(TEST_OUTPUT_DIRECTORY)/chainlinttmp
     ++GREPLINTTMP = $(TEST_OUTPUT_DIRECTORY)/greplinttmp
     + else
     + TEST_RESULTS_DIRECTORY = test-results
     + CHAINLINTTMP = chainlinttmp
     ++GREPLINTTMP = greplinttmp
     + endif
     + 
     + # Shell quote;
     +@@ t/Makefile: TEST_SHELL_PATH_SQ = $(subst ','\'',$(TEST_SHELL_PATH))
     + PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
     + TEST_RESULTS_DIRECTORY_SQ = $(subst ','\'',$(TEST_RESULTS_DIRECTORY))
     + CHAINLINTTMP_SQ = $(subst ','\'',$(CHAINLINTTMP))
     ++GREPLINTTMP_SQ = $(subst ','\'',$(GREPLINTTMP))
     + 
     + T = $(sort $(wildcard t[0-9][0-9][0-9][0-9]-*.sh))
     + THELPERS = $(sort $(filter-out $(T),$(wildcard *.sh)))
     +@@ t/Makefile: TLIBS = $(sort $(wildcard lib-*.sh)) annotate-tests.sh
     + TPERF = $(sort $(wildcard perf/p[0-9][0-9][0-9][0-9]-*.sh))
       TINTEROP = $(sort $(wildcard interop/i[0-9][0-9][0-9][0-9]-*.sh))
       CHAINLINTTESTS = $(sort $(patsubst chainlint/%.test,%,$(wildcard chainlint/*.test)))
     ++GREPLINTTESTS = $(sort $(patsubst greplint/%.test,%,$(wildcard greplint/*.test)))
       CHAINLINT = '$(PERL_PATH_SQ)' chainlint.pl
     -+LINT_STYLE_TESTS = $(sort $(wildcard lint-style/*.test))
       UNIT_TEST_SOURCES = $(wildcard unit-tests/t-*.c)
       UNIT_TEST_PROGRAMS = $(patsubst unit-tests/%.c,unit-tests/bin/%$(X),$(UNIT_TEST_SOURCES))
     - UNIT_TEST_PROGRAMS += unit-tests/bin/unit-tests$(X)
     +@@ t/Makefile: test: pre-clean check-meson $(TEST_LINT)
     + 	$(CHAINLINTSUPPRESS) $(MAKE) aggregate-results-and-cleanup
     + 
     + ifneq ($(PERL_PATH),)
     +-test: check-chainlint
     +-prove: check-chainlint
     ++test: check-chainlint check-greplint
     ++prove: check-chainlint check-greplint
     + endif
     + 
     + failed:
     +@@ t/Makefile: unit-tests-test-tool:
     + pre-clean:
     + 	$(RM) -r '$(TEST_RESULTS_DIRECTORY_SQ)'
     + 
     +-clean-except-prove-cache: clean-chainlint
     ++clean-except-prove-cache: clean-chainlint clean-greplint
     + 	$(RM) -r 'trash directory'.*
     + 	$(RM) -r valgrind/bin
     + 
     +@@ t/Makefile: check-chainlint:
     + 	{ $(CHAINLINT) --emit-all '$(CHAINLINTTMP_SQ)'/tests >'$(CHAINLINTTMP_SQ)'/actual || true; } && \
     + 	diff -u '$(CHAINLINTTMP_SQ)'/expect '$(CHAINLINTTMP_SQ)'/actual
     + 
     ++clean-greplint:
     ++	$(RM) -r '$(GREPLINTTMP_SQ)'
     ++
     ++check-greplint:
     ++	@mkdir -p '$(GREPLINTTMP_SQ)' && \
     ++	'$(PERL_PATH_SQ)' greplint-cat.pl '$(GREPLINTTMP_SQ)' $(GREPLINTTESTS) && \
     ++	{ '$(PERL_PATH_SQ)' greplint.pl \
     ++		$(patsubst %,greplint/%.test,$(GREPLINTTESTS)) \
     ++		>'$(GREPLINTTMP_SQ)'/actual 2>&1 || true; } && \
     ++	diff -u '$(GREPLINTTMP_SQ)'/expect '$(GREPLINTTMP_SQ)'/actual
     ++
     + check-meson:
     + 	@# awk acts up when trying to match single quotes, so we use \047 instead.
     + 	@mkdir -p mesontmp && \
      @@ t/Makefile: check-meson:
       test-lint: test-lint-duplicates test-lint-executable \
       	test-lint-filenames
       ifneq ($(PERL_PATH),)
     --test-lint: test-lint-shell-syntax check-shell-parser
     -+test-lint: test-lint-shell-syntax test-lint-style check-lint-style check-shell-parser
     +-test-lint: test-lint-shell-syntax
     ++test-lint: test-lint-shell-syntax test-greplint
       else
       GIT_TEST_CHAIN_LINT = 0
       endif
     -@@ t/Makefile: test-lint-shell-syntax:
     +@@ t/Makefile: test-lint-executable:
     + test-lint-shell-syntax:
     + 	@'$(PERL_PATH_SQ)' check-non-portable-shell.pl $(T) $(THELPERS) $(TPERF)
       
     - check-shell-parser:
     - 	@'$(PERL_PATH_SQ)' check-shell-parser.pl
     -+
     -+test-lint-style:
     -+	@'$(PERL_PATH_SQ)' lint-style.pl $(T) $(THELPERS) $(TPERF)
     -+
     -+check-lint-style:
     -+	@rc=0; for t in $(LINT_STYLE_TESTS); do \
     -+		base=$${t%.test}; \
     -+		case $$base in \
     -+		*-fix) \
     -+			cp "$$t" "$$t.tmp" && \
     -+			'$(PERL_PATH_SQ)' lint-style.pl --fix "$$t.tmp" >/dev/null 2>&1; \
     -+			fix_rc=$$?; \
     -+			if test $$fix_rc != 0; then \
     -+				echo "FAIL: $$t (--fix exit code $$fix_rc)"; rc=1; \
     -+			elif ! diff -u "$$base.expect" "$$t.tmp"; then \
     -+				echo "FAIL: $$t (--fix output)"; rc=1; \
     -+			fi; \
     -+			rm -f "$$t.tmp" ;; \
     -+		*) \
     -+			if ! '$(PERL_PATH_SQ)' lint-style.pl "$$t" 2>&1 | \
     -+				diff -u "$$base.expect" -; then \
     -+				echo "FAIL: $$t"; rc=1; \
     -+			fi ;; \
     -+		esac; \
     -+	done; test $$rc = 0
     ++test-greplint:
     ++	@'$(PERL_PATH_SQ)' greplint.pl $(T) $(THELPERS) $(TPERF)
      +
       test-lint-filenames:
       	@# We do *not* pass a glob to ls-files but use grep instead, to catch
       	@# non-ASCII characters (which are quoted within double-quotes)
      @@ t/Makefile: perf:
     + 	$(MAKE) -C perf/ all
       
       .PHONY: pre-clean $(T) aggregate-results clean valgrind perf \
     - 	check-chainlint clean-chainlint test-chainlint \
     --	check-shell-parser $(UNIT_TESTS)
     -+	check-shell-parser \
     -+	check-lint-style test-lint-style $(UNIT_TESTS)
     +-	check-chainlint clean-chainlint test-chainlint $(UNIT_TESTS)
     ++	check-chainlint clean-chainlint test-chainlint \
     ++	check-greplint clean-greplint test-greplint $(UNIT_TESTS)
       
       .PHONY: libgit-sys-test libgit-rs-test
       libgit-sys-test:
      
     - ## t/lint-style.pl (new) ##
     + ## t/greplint-cat.pl (new) ##
      @@
     -+#!/usr/bin/perl
     -+
     -+# Check test scripts for style violations that can be detected
     -+# mechanically, such as using bare 'grep' where test_grep should
     -+# be used.  Use --fix to automatically apply suggested replacements.
     -+#
     -+# Detection uses parsed tokens from the shared shell parser for
     -+# correct handling of heredocs, $(...), pipes, and quoting.
     -+# Fixes modify the original file text to preserve formatting.
     ++#!/usr/bin/env perl
      +
      +use strict;
      +use warnings;
     -+use File::Basename;
     -+# Force LF output so check-lint-style's diff against the
     -+# pre-committed .expect files works on Windows.
     -+binmode(STDOUT, ':unix');
     -+binmode(STDERR, ':unix');
      +
     -+my $fix_mode = 0;
     -+if (@ARGV && $ARGV[0] eq '--fix') {
     -+	$fix_mode = 1;
     -+	shift @ARGV;
     ++# Assemble expected output for check-greplint target.
     ++# Usage: greplint-cat.pl <outdir> <test-name> ...
     ++#
     ++# For each <test-name>, reads greplint/<test-name>.expect and
     ++# prepends "greplint/<test-name>.test:" to every non-empty line,
     ++# matching the output format of greplint.pl.  Writes combined
     ++# expected output to <outdir>/expect.
     ++
     ++my $outdir = shift;
     ++open(my $expect, '>', "$outdir/expect")
     ++	or die "unable to open $outdir/expect: $!";
     ++
     ++for my $name (@ARGV) {
     ++	open(my $fh, '<', "greplint/$name.expect")
     ++		or die "unable to open greplint/$name.expect: $!";
     ++	while (<$fh>) {
     ++		print $expect "greplint/$name.test:$_";
     ++	}
     ++	close $fh;
      +}
      +
     -+# Load the shared shell parser (Lexer, ShellParser, ScriptParser).
     -+my $_lib = dirname($0) . "/lib-shell-parser.pl";
     -+$_lib = "./$_lib" unless $_lib =~ m{^/};
     -+do $_lib or die "$0: failed to load $_lib: $@$!\n";
     ++close $expect;
     +
     + ## t/greplint.pl (new) ##
     +@@
     ++#!/usr/bin/env perl
      +
     -+# LintParser is a subclass of ScriptParser which runs lint rules
     -+# on each test body.  Per-file state (file name, raw lines, dirty
     -+# flag) is stored on the instance before calling parse().
     ++# Detect bare 'grep' used as a test assertion where 'test_grep'
     ++# should be used, and '! test_grep' where 'test_grep !' should
     ++# be used.
      +#
     -+# Subroutines defined below (parse_commands, check_test_grep_negation,
     -+# etc.) are in package main and called with the main:: prefix.
     -+# File-scoped lexicals ($fix_mode, $has_fixable, etc.) are visible
     -+# across packages since 'package' does not introduce a new scope.
     -+package LintParser;
     -+our @ISA = ('ScriptParser');
     ++# The shared shell parser tokenizes test bodies so that 'grep'
     ++# inside heredocs, command substitutions like $(grep ...), and
     ++# quoted strings is collapsed into a single token and never seen
     ++# by our check.  A line-oriented approach would need to track
     ++# heredoc delimiters, nested $() depth, and cross-line pipe
     ++# state to avoid false positives on patterns like:
     ++#
     ++#   write_script foo.sh <<-\EOF
     ++#   grep pattern file    # data, not an assertion
     ++#   EOF
     ++#
     ++# The Lexer already handles these.
      +
     -+package main;
     ++use warnings;
     ++use strict;
     ++use File::Basename;
     ++do(dirname($0) . "/lib-shell-parser.pl")
     ++	or die "$0: failed to load lib-shell-parser.pl: $@$!\n";
      +
      +my $exit_code = 0;
     -+my $has_fixable = 0;
      +
     -+sub err {
     -+	my ($file, $lineno, $line, $msg, %opts) = @_;
     -+	$line =~ s/^\s+//;
     -+	$line =~ s/\s+$//;
     -+	$line =~ s/\s+/ /g;
     -+	my $prefix = ($fix_mode && $opts{fixable}) ? 'fixed' : 'error';
     -+	print "$file:$lineno: $prefix: $msg: $line\n";
     -+	$exit_code = 1 unless $fix_mode && $opts{fixable};
     -+}
     ++# GrepLintParser inherits ScriptParser's ability to find
     ++# test_expect_success/failure blocks and call check_test()
     ++# on each body.  We override check_test() to walk the token
     ++# stream looking for bare grep assertions.
     ++package GrepLintParser;
      +
     -+# Report a lint violation found by a rule.  In --fix mode, apply
     -+# the regex substitution on the raw line and report success.
     -+# Otherwise just report.  Returns 1 if the line was modified.
     -+sub report_violation {
     -+	my ($file, $cmd, $line_ref, $match, $fix, $from) = @_;
     -+	my $lineno = $cmd->{lineno};
     -+	my $display = join(' ', @{$cmd->{tokens}});
     -+	$has_fixable++;  # count for the "--fix" hint
     -+	if ($fix_mode) {
     -+		if ($$line_ref =~ s/$match/$fix/) {
     -+			err $file, $lineno, $display,
     -+				"replace '$from' with '$fix'",
     -+				fixable => 1;
     -+			return 1;
     -+		}
     -+		err $file, $lineno, $display,
     -+			"replace '$from' with '$fix' (could not auto-fix)";
     -+	} else {
     -+		err $file, $lineno, $display,
     -+			"replace '$from' with '$fix'";
     ++our @ISA = ('ScriptParser');
     ++
     ++# After these tokens, the next token is a command word.
     ++# For example, in 'echo foo && grep bar file', the 'grep'
     ++# after '&&' is at command position and should be flagged.
     ++my %cmd_start = map { $_ => 1 } qw(&& || ; ;; do then else elif), "\n", '{', '(';
     ++
     ++# Tokens indicating grep's output is piped or redirected.
     ++my %filter_op = map { $_ => 1 } qw(| > >> <);
     ++
     ++# A token is at "command word" position if the shell would
     ++# interpret it as a program name rather than an argument.
     ++# Only 'grep' at command position is an assertion we should
     ++# flag; 'grep' as an argument ('test_must_fail grep') or
     ++# value ('for cmd in grep sed') is not.
     ++sub is_command_word {
     ++	my ($tokens, $pos) = @_;
     ++	return 1 if $pos == 0;
     ++	for (my $j = $pos - 1; $j >= 0; $j--) {
     ++		my $t = $tokens->[$j]->[0];
     ++		# After a separator or pipe, a new command starts.
     ++		return 1 if $cmd_start{$t} || $t eq '|';
     ++		# After '}' or ')', what follows is a separator or
     ++		# redirect on the compound command, not a new command.
     ++		return 0 if $t eq '}' || $t eq ')';
     ++		# '!' is a prefix that does not consume command
     ++		# position; keep scanning to find what precedes it.
     ++		next if $t eq '!';
     ++		# Any other word means we are past the command word.
     ++		return 0;
      +	}
     -+	return 0;
     ++	return 1;
      +}
      +
     -+# Split a token stream into commands at &&, ||, ;;, and \n.
     -+sub parse_commands {
     -+	my ($content) = @_;
     -+	my $parser = ShellParser->new(\$content);
     -+	my @all_tokens = $parser->parse();
     ++# Some bare greps are intentional (e.g. file may not exist,
     ++# data filter).  A '# lint-ok' annotation on the source line
     ++# suppresses the warning.
     ++sub lint_ok {
     ++	my ($raw_lines, $ln) = @_;
     ++	if ($ln < 1 || $ln > @$raw_lines) {
     ++		warn "lint_ok: line number $ln out of range (1.." .
     ++		    scalar(@$raw_lines) . ")\n";
     ++		return 0;
     ++	}
     ++	return $raw_lines->[$ln - 1] =~ /lint-ok/;
     ++}
      +
     -+	my @commands;
     -+	my @current;
     -+	my $lineno = 1;
     ++# Grep is a filter (not an assertion) if it receives piped
     ++# input or sends its output to a pipe or redirect.  Check
     ++# both directions from grep's position in the token stream.
     ++sub is_filter {
     ++	my ($tokens, $pos) = @_;
     ++	# Backward: is grep receiving piped input?
     ++	# Newlines don't break pipes ('cmd |\n grep' is one
     ++	# pipeline), so skip past them.
     ++	for (my $j = $pos - 1; $j >= 0; $j--) {
     ++		my $t = $tokens->[$j]->[0];
     ++		return 1 if $t eq '|';
     ++		next if $t eq "\n";
     ++		last if $cmd_start{$t} || $t eq '}' || $t eq ')';
     ++	}
     ++	# Forward: is grep piping or redirecting output?
     ++	# Unlike the backward scan, we do not skip newlines here:
     ++	# a bare newline is a command boundary, and redirects or
     ++	# pipes must appear on the same line as grep (or after a
     ++	# line continuation, which the Lexer consumes).
     ++	for (my $j = $pos + 1; $j < @$tokens; $j++) {
     ++		my $t = $tokens->[$j]->[0];
     ++		return 0 if $cmd_start{$t};
     ++		return 1 if $filter_op{$t};
     ++	}
     ++	return 0;
     ++}
      +
     -+	for (my $ti = 0; $ti < @all_tokens; $ti++) {
     -+		my $text = $all_tokens[$ti]->[0];
     -+		if ($text =~ /^(?:&&|\|\||;;|\n)$/) {
     -+			if (@current) {
     -+				push @commands, {
     -+					tokens => [@current],
     -+					lineno => $lineno,
     -+				};
     -+				@current = ();
     -+			}
     ++# Map a body-relative line number to a file line number.
     ++# For double-quoted bodies, backslash-continuation lines
     ++# (\<newline>) are consumed by the Lexer without appearing
     ++# in the body text, so the inner parser sees fewer lines
     ++# than the source file has.  We walk the source lines to
     ++# count continuations and adjust accordingly.
     ++sub body_to_file_line {
     ++	my ($body_lineno, $body_token, $raw_lines, $body_start) = @_;
     ++	my $body_text = $body_token->[0];
     ++	my $body_end_line = $body_token->[4];
     ++	unless ($body_start && $body_start >= 1) {
     ++		warn "body_start is not a positive integer\n";
     ++		return $body_lineno;
     ++	}
     ++	my $file_lineno = $body_lineno + $body_start - 1;
     ++	# Only double-quoted bodies have line splices.
     ++	return $file_lineno unless $body_text =~ /^"/;
     ++	my $adj = 0;
     ++	my $lines_seen = 0;
     ++	unless ($body_end_line && $body_end_line >= $body_start) {
     ++		warn "body_end_line is not set for double-quoted body\n";
     ++		return $file_lineno;
     ++	}
     ++	my $end = $body_end_line;
     ++	if ($end > @$raw_lines) {
     ++		warn "body_end_line ($end) exceeds file length (" .
     ++		    scalar(@$raw_lines) . ")\n";
     ++		return $file_lineno;
     ++	}
     ++	my $src_ln = $body_start;
     ++	while ($src_ln <= $end && $lines_seen < $body_lineno) {
     ++		my $line = $raw_lines->[$src_ln - 1];
     ++		# Odd trailing backslashes = continuation (\<nl>).
     ++		# Even = escaped backslashes (\\), not a continuation.
     ++		if ($line =~ /(\\*)$/ && length($1) % 2 == 1) {
     ++			$adj++;
      +		} else {
     -+			$lineno = $all_tokens[$ti]->[3]
     -+				if !@current && defined $all_tokens[$ti]->[3];
     -+			push @current, $text;
     ++			$lines_seen++;
      +		}
     ++		$src_ln++;
      +	}
     -+	if (@current) {
     -+		push @commands, {
     -+			tokens => [@current],
     -+			lineno => $lineno,
     -+		};
     ++	if ($lines_seen < $body_lineno) {
     ++		warn "body_lineno ($body_lineno) not found within body range " .
     ++		    "($body_start..$end)\n";
      +	}
     -+	return @commands;
     ++	return $file_lineno + $adj;
      +}
      +
     -+# --- Rule: '! test_grep' should be 'test_grep !' ---
     -+# Shell-level negation suppresses test_grep's diagnostic output
     -+# on failure.  Built-in negation preserves it.
     -+sub check_test_grep_negation {
     -+	my ($cmd, $file, $line_ref) = @_;
     -+	my @tokens = @{$cmd->{tokens}};
     -+	return unless @tokens >= 2 && $tokens[0] eq '!' && $tokens[1] eq 'test_grep';
     -+
     -+	return report_violation($file, $cmd, $line_ref,
     -+		qr/!\s*test_grep/, 'test_grep !', '! test_grep');
     -+}
     -+
     -+# Map parsed commands back to raw file lines for --fix.
     -+# Detection uses parsed tokens (correct handling of quoting,
     -+# heredocs, pipes) but fixes must modify the original text
     -+# to preserve formatting.
     -+package LintParser;
     -+
     ++# ScriptParser calls this for each test body found in the script.
      +sub check_test {
     -+	# Called by ScriptParser::parse_cmd for each test_expect_success
     -+	# or test_expect_failure block.
      +	my $self = shift @_;
      +	my $title = ScriptParser::unwrap(shift @_);
     -+
     -+	# Two test body formats:
     -+	#   Quoted:  test_expect_success 'title' '..body..'
     -+	#   Heredoc: test_expect_success 'title' - <<\EOF
     -+	#              ..body..
     -+	#            EOF
     -+	# For quoted, the body token is the quoted string.
     -+	# For heredoc, the body token is '-' and the actual
     -+	# code arrives as the next argument from the Lexer.
      +	my $body_token = shift @_;
     -+	my $lineno_base = $body_token->[3] || 1;
     ++	my $body_start = $body_token->[3];
      +	my $body = ScriptParser::unwrap($body_token);
     -+
     ++	# Handle heredoc-style test bodies:
     ++	#   test_expect_success 'title' - <<\EOF
     ++	#   grep pattern file
     ++	#   EOF
     ++	# The '-' signals that the body follows as a heredoc.
      +	if ($body eq '-') {
      +		my $herebody = shift @_;
      +		if ($herebody) {
      +			$body = $herebody->{content};
     -+			$lineno_base = $herebody->{start_line} || 1;
     ++			$body_start = $herebody->{start_line};
      +		}
      +	}
      +	return unless $body;
      +
     -+	# Map each command back to its file line number.
     -+	# $lineno_base is where the body starts in the file;
     -+	# $cmd->{lineno} is relative to the body (starting at 1).
      +	my $raw_lines = $self->{raw_lines};
     -+	for my $cmd (main::parse_commands($body)) {
     -+		my $ln = ($cmd->{lineno} || 0) + $lineno_base - 1;
     -+		$cmd->{lineno} = $ln;
     -+		next unless $ln >= 1 && $ln <= @$raw_lines;
     -+		next if $raw_lines->[$ln - 1] =~ /#.*lint-ok/;
      +
     -+		if (main::check_test_grep_negation($cmd, $self->{file}, \$raw_lines->[$ln - 1])) {
     -+			$self->{dirty} = 1;
     ++	# The outer parser gives us the body as an opaque string.
     ++	# Parse it to get individual tokens with command boundaries.
     ++	my $parser = ShellParser->new(\$body);
     ++	my @tokens = $parser->parse();
     ++
     ++	my $file = $self->{file};
     ++
     ++	for (my $i = 0; $i < @tokens; $i++) {
     ++		my $text = $tokens[$i]->[0];
     ++		next unless is_command_word(\@tokens, $i);
     ++
     ++		my $token_lineno = $tokens[$i]->[3];
     ++		unless (defined($token_lineno) && $token_lineno >= 1) {
     ++			warn "token has no line number\n";
     ++			next;
     ++		}
     ++		my $file_lineno = body_to_file_line(
     ++			$token_lineno,
     ++			$body_token, $raw_lines, $body_start);
     ++
     ++		# '!' negates the exit code without consuming command
     ++		# position.  '! test_grep' is an anti-pattern because
     ++		# test_grep only prints diagnostics on grep failure,
     ++		# and '!' inverts after that decision is already made.
     ++		if ($text eq '!') {
     ++			if ($i + 1 < @tokens &&
     ++			    $tokens[$i + 1]->[0] eq 'test_grep' &&
     ++			    !lint_ok($raw_lines, $file_lineno)) {
     ++				print "$file:$file_lineno: error: ",
     ++				    'use "test_grep !" instead of ',
     ++				    '"! test_grep"', "\n";
     ++				$exit_code = 1;
     ++			}
     ++			next;
     ++		}
     ++
     ++		# Bare grep as a command (not a filter) is a test
     ++		# assertion that should use test_grep for better
     ++		# failure diagnostics.
     ++		if ($text eq 'grep' &&
     ++		    !is_filter(\@tokens, $i) &&
     ++		    !lint_ok($raw_lines, $file_lineno)) {
     ++			print "$file:$file_lineno: error: ",
     ++			    "bare grep outside pipeline ",
     ++			    "(use test_grep)\n";
     ++			$exit_code = 1;
      +		}
      +	}
      +}
     @@ t/lint-style.pl (new)
      +package main;
      +
      +for my $file (@ARGV) {
     -+	# :unix:crlf strips \r on Windows (same as chainlint.pl)
      +	open(my $fh, '<:unix:crlf', $file) or die "$0: $file: $!\n";
      +	my @raw_lines = <$fh>;
      +	close $fh;
     -+
     -+	my $parser = LintParser->new(\join('', @raw_lines));
     ++	my $s = join('', @raw_lines);
     ++	my $parser = GrepLintParser->new(\$s);
      +	$parser->{file} = $file;
      +	$parser->{raw_lines} = \@raw_lines;
     -+	$parser->{dirty} = 0;
      +	$parser->parse();
     -+
     -+	if ($fix_mode && $parser->{dirty}) {
     -+		open(my $out, '>', $file) or die "$0: $file: $!\n";
     -+		print $out @{$parser->{raw_lines}};
     -+		close $out;
     -+	}
     -+}
     -+
     -+if ($has_fixable && !$fix_mode) {
     -+	print "hint: run with --fix to apply the suggested replacements.\n";
      +}
      +exit $exit_code;
      
     - ## t/lint-style/heredoc.expect (new) ##
     + ## t/greplint/bare-grep-after-and.expect (new) ##
      @@
     -+lint-style/heredoc.test:8: error: replace '! test_grep' with 'test_grep !': ! test_grep "after-heredoc-is-caught" actual
     -+lint-style/heredoc.test:13: error: replace '! test_grep' with 'test_grep !': ! test_grep "not-inside-sed-heredoc" actual
     -+hint: run with --fix to apply the suggested replacements.
     ++3: error: bare grep outside pipeline (use test_grep)
      
     - ## t/lint-style/heredoc.test (new) ##
     + ## t/greplint/bare-grep-after-and.test (new) ##
      @@
     -+test_expect_success 'greps inside heredocs are skipped' '
     -+	cat <<-EOF &&
     -+	grep "inside-strip-tabs" file
     -+	EOF
     -+	cat <<-\EOF &&
     -+	grep "inside-no-expand" file
     -+	EOF
     -+	! test_grep "after-heredoc-is-caught" actual
     ++test_expect_success 'grep after && is flagged' '
     ++	cmd &&
     ++	grep pattern file
      +'
     -+
     -+test_expect_success 'sed with << does not start a heredoc' '
     -+	sed "s/<< foo/bar/" file &&
     -+	! test_grep "not-inside-sed-heredoc" actual
     +
     + ## t/greplint/bare-grep-after-semicolon.expect (new) ##
     +@@
     ++3: error: bare grep outside pipeline (use test_grep)
     +
     + ## t/greplint/bare-grep-after-semicolon.test (new) ##
     +@@
     ++test_expect_success 'grep after semicolon is flagged' '
     ++	echo hello;
     ++	grep pattern file
      +'
      
     - ## t/lint-style/test-grep-negation-fix.expect (new) ##
     + ## t/greplint/bare-grep-compound-body.expect (new) ##
      @@
     -+test_expect_success 'negated test_grep' '
     -+	test_grep ! "pattern" actual &&
     -+	test_grep ! -i "insensitive" actual
     ++4: error: bare grep outside pipeline (use test_grep)
     ++8: error: bare grep outside pipeline (use test_grep)
     ++15: error: bare grep outside pipeline (use test_grep)
     +
     + ## t/greplint/bare-grep-compound-body.test (new) ##
     +@@
     ++test_expect_success 'grep after then/do/else is flagged' '
     ++	if true
     ++	then
     ++		grep pattern file
     ++	fi &&
     ++	while true
     ++	do
     ++		grep pattern file &&
     ++		break
     ++	done &&
     ++	if true
     ++	then
     ++		echo yes
     ++	else
     ++		grep pattern file
     ++	fi
      +'
      
     - ## t/lint-style/test-grep-negation-fix.test (new) ##
     + ## t/greplint/bare-grep-count-mode.expect (new) ##
     +@@
     ++2: error: bare grep outside pipeline (use test_grep)
     +
     + ## t/greplint/bare-grep-count-mode.test (new) ##
      @@
     -+test_expect_success 'negated test_grep' '
     -+	! test_grep "pattern" actual &&
     -+	! test_grep -i "insensitive" actual
     ++test_expect_success 'grep -c is flagged (not special-cased)' '
     ++	grep -c pattern file
      +'
      
     - ## t/lint-style/test-grep-negation.expect (new) ##
     + ## t/greplint/bare-grep-explicit-pattern.expect (new) ##
      @@
     -+lint-style/test-grep-negation.test:2: error: replace '! test_grep' with 'test_grep !': ! test_grep "pattern" actual
     -+lint-style/test-grep-negation.test:3: error: replace '! test_grep' with 'test_grep !': ! test_grep -i "insensitive" actual
     -+hint: run with --fix to apply the suggested replacements.
     ++2: error: bare grep outside pipeline (use test_grep)
      
     - ## t/lint-style/test-grep-negation.test (new) ##
     + ## t/greplint/bare-grep-explicit-pattern.test (new) ##
      @@
     -+test_expect_success 'negated test_grep' '
     -+	! test_grep "pattern" actual &&
     -+	! test_grep -i "insensitive" actual
     ++test_expect_success 'grep -e is flagged' '
     ++	grep -e pattern file
      +'
      
     - ## t/t0031-lockfile-pid.sh ##
     -@@ t/t0031-lockfile-pid.sh: test_expect_success 'PID info not shown by default' '
     - 		test_must_fail git add . 2>err &&
     - 		# Should not crash, just show normal error without PID
     - 		test_grep "Unable to create" err &&
     --		! test_grep "is held by process" err
     -+		test_grep ! "is held by process" err
     - 	)
     - '
     - 
     + ## t/greplint/bare-grep-flags.expect (new) ##
     +@@
     ++2: error: bare grep outside pipeline (use test_grep)
      
     - ## t/t5300-pack-object.sh ##
     -@@ t/t5300-pack-object.sh: test_expect_success '--name-hash-version=2 and --write-bitmap-index are incompat
     - 
     - 	# --stdout option silently removes --write-bitmap-index
     - 	git pack-objects --stdout --all --name-hash-version=2 --write-bitmap-index >out 2>err &&
     --	! test_grep "currently, --write-bitmap-index requires --name-hash-version=1" err
     -+	test_grep ! "currently, --write-bitmap-index requires --name-hash-version=1" err
     - '
     - 
     - test_expect_success '--path-walk pack everything' '
     + ## t/greplint/bare-grep-flags.test (new) ##
     +@@
     ++test_expect_success 'grep -E is flagged' '
     ++	grep -E "pat+ern" file
     ++'
      
     - ## t/t5319-multi-pack-index.sh ##
     -@@ t/t5319-multi-pack-index.sh: test_expect_success 'load reverse index when missing .idx, .pack' '
     - 
     - test_expect_success 'usage shown without sub-command' '
     - 	test_expect_code 129 git multi-pack-index 2>err &&
     --	! test_grep "unrecognized subcommand" err
     -+	test_grep ! "unrecognized subcommand" err
     - '
     - 
     - test_expect_success 'complains when run outside of a repository' '
     -
     - ## t/t7900-maintenance.sh ##
     -@@ t/t7900-maintenance.sh: test_geometric_repack_needed () {
     - 	true)
     - 		test_grep "\[\"git\",\"repack\"," trace2.txt;;
     - 	false)
     --		! test_grep "\[\"git\",\"repack\"," trace2.txt;;
     -+		test_grep ! "\[\"git\",\"repack\"," trace2.txt;;
     - 	*)
     - 		BUG "invalid parameter: $NEEDED";;
     - 	esac
     + ## t/greplint/bare-grep-lint-ok.expect (new) ##
     +
     + ## t/greplint/bare-grep-lint-ok.test (new) ##
     +@@
     ++test_expect_success 'grep with lint-ok annotation is not flagged' '
     ++	grep pattern file && # lint-ok
     ++	echo done
     ++'
     +
     + ## t/greplint/bare-grep-negated.expect (new) ##
     +@@
     ++2: error: bare grep outside pipeline (use test_grep)
     +
     + ## t/greplint/bare-grep-negated.test (new) ##
     +@@
     ++test_expect_success 'negated grep is flagged' '
     ++	! grep pattern file
     ++'
     +
     + ## t/greplint/bare-grep-pattern-file.expect (new) ##
     +@@
     ++2: error: bare grep outside pipeline (use test_grep)
     +
     + ## t/greplint/bare-grep-pattern-file.test (new) ##
     +@@
     ++test_expect_success 'grep -f is flagged' '
     ++	grep -f patterns.txt file
     ++'
     +
     + ## t/greplint/bare-grep-simple.expect (new) ##
     +@@
     ++2: error: bare grep outside pipeline (use test_grep)
     +
     + ## t/greplint/bare-grep-simple.test (new) ##
     +@@
     ++test_expect_success 'bare grep is flagged' '
     ++	grep pattern file
     ++'
     +
     + ## t/greplint/bare-grep-subshell.expect (new) ##
     +@@
     ++3: error: bare grep outside pipeline (use test_grep)
     +
     + ## t/greplint/bare-grep-subshell.test (new) ##
     +@@
     ++test_expect_success 'grep in subshell is flagged' '
     ++	(
     ++		grep pattern file
     ++	)
     ++'
     +
     + ## t/greplint/dqstring-continuation-offset.expect (new) ##
     +@@
     ++10: error: bare grep outside pipeline (use test_grep)
     +
     + ## t/greplint/dqstring-continuation-offset.test (new) ##
     +@@
     ++# Double-quoted test bodies with backslash-continuation lines:
     ++# the splice adjustment in check_test compensates for \<newline>
     ++# lines that the lexer consumes without emitting into the body
     ++# text, so the reported line number matches the source.
     ++test_expect_success 'dqstring continuation offset' "
     ++	x=\$(echo \
     ++		hello) &&
     ++	y=\$(echo \
     ++		world) &&
     ++	grep pattern file
     ++"
     +
     + ## t/greplint/filter-command-substitution.expect (new) ##
     +
     + ## t/greplint/filter-command-substitution.test (new) ##
     +@@
     ++test_expect_success 'grep in command substitution is not flagged' '
     ++	x=$(grep pattern file)
     ++'
     +
     + ## t/greplint/filter-pipe-input.expect (new) ##
     +
     + ## t/greplint/filter-pipe-input.test (new) ##
     +@@
     ++test_expect_success 'grep receiving pipe input is not flagged' '
     ++	cmd | grep pattern
     ++'
     +
     + ## t/greplint/filter-pipe-output.expect (new) ##
     +
     + ## t/greplint/filter-pipe-output.test (new) ##
     +@@
     ++test_expect_success 'grep piping to another command is not flagged' '
     ++	grep pattern file | wc -l
     ++'
     +
     + ## t/greplint/filter-redirect-output.expect (new) ##
     +
     + ## t/greplint/filter-redirect-output.test (new) ##
     +@@
     ++test_expect_success 'grep with output redirect is not flagged' '
     ++	grep pattern file >output
     ++'
     +
     + ## t/greplint/filter-stdin-redirect.expect (new) ##
     +
     + ## t/greplint/filter-stdin-redirect.test (new) ##
     +@@
     ++test_expect_success 'grep reading from stdin redirect is not flagged' '
     ++	grep pattern <input
     ++'
     +
     + ## t/greplint/grep-as-argument.expect (new) ##
     +
     + ## t/greplint/grep-as-argument.test (new) ##
     +@@
     ++test_expect_success 'grep as argument to another command is not flagged' '
     ++	test_must_fail grep pattern file
     ++'
     +
     + ## t/greplint/grep-as-value.expect (new) ##
     +
     + ## t/greplint/grep-as-value.test (new) ##
     +@@
     ++test_expect_success 'grep as value in for-loop is not flagged' '
     ++	for cmd in grep sed awk
     ++	do
     ++		echo $cmd
     ++	done
     ++'
     +
     + ## t/greplint/wrong-negation.expect (new) ##
     +@@
     ++2: error: use "test_grep !" instead of "! test_grep"
     +
     + ## t/greplint/wrong-negation.test (new) ##
     +@@
     ++test_expect_success 'wrong negation of test_grep is flagged' '
     ++	! test_grep pattern file
     ++'

-- 
gitgitgadget
