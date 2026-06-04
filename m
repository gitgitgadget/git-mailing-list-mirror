Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A9537BE74
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 07:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780559163; cv=none; b=DFpYPDVXuT4D48mT8hSxIfx2GErtuXQw/FOr+lyXLfjMqMY01tdCQBkNOn6w6S5GHCJ1QJUyS4YfyuX7gwBMwIWrBmzgjerzVepl/U665aU31/xjQ2LS80vxtqbEtrSOUFJiF6p868x3tccnouMu2AQDqwhL+bsPu8qMRFsssBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780559163; c=relaxed/simple;
	bh=r/HK9kKCOVNOv4biU+VxVW/JhBw0HryS+vIfjtKZqt8=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=B4/3gqN1sTs7qfjeUI10R64k04byQE9B3yUJm0FIXhsvYPgHz3DONE7M51hWviFMDpKx0/RcfAjZOx+c1pZZ6NDHo/pRiCaeQZMtMS9Rc/in0WFLDOo9DgIVDvTH3/94IryfQ6yCBjYZUw7yuOvM9eSPAOZIv4xsfJNC2aeoiBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o2sxqRqk; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o2sxqRqk"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-91578122305so79171785a.0
        for <git@vger.kernel.org>; Thu, 04 Jun 2026 00:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780559160; x=1781163960; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=x7oGdrd1misltBr84msCkSLV0ODe3R3b+VmQdXMfDvE=;
        b=o2sxqRqk0gpkkEiXyuoZtrixWbqFqoFV+L8bvbVUCs9BYYYX8cu3aBkQWX+jY88PCX
         Fn/DjoeVBsH8MFrFSO1VQZn6xcVFx1urwznpchidPmKBq9juayiBBv44HejZedU78IR2
         tvGJ4arw6vwPX0WpDMDuP2cmJsDhCM7S75OVVHz7iS2lUt9YEm3gtKqzvfFDj3rLwcOi
         U+z+jYhJ540RaOgCea03kAHSi9EWMBBrRAESvm84lJO2iF6ggdSpeCh45/PY/iQKOA0K
         5RwFKS0oSFTLrZjho1UjOOwQ/+WcZMOLAYWIaPNAi40enXaib/DQtu4V0tbh58jQo8nD
         nw6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780559160; x=1781163960;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7oGdrd1misltBr84msCkSLV0ODe3R3b+VmQdXMfDvE=;
        b=NKmoekMs45NlY1c6MJJWZLPD0bIEMVWM1y3QcwSzCP1XNonQwVHKroIDHCF6Sq786K
         /o/pEcBh7NsRnGhUXg2+m9NO4c8HciwzkhM+IOGbJXnjNVW9EwLtpY65mj/epoieJKPF
         sFs8IscjhcPP+b30WfBtUgBeRd2E9XGEB7oRq34g0pCBuIascyHzYDkaOes0Baq+bbv0
         GB7pDgPez8ECDT6R5793VcW2BhuGBjQIRfHCShGt7+quy/ad2ywL01oj/bCzYkohFHSB
         nrU47zecqveOzntKqk2KhfOtLZcPgGrbN8DooYmSYvArnPCP2vBsPGapy5rTesD4Lmh7
         xEpg==
X-Gm-Message-State: AOJu0Yy/6bPIrEacunTjBm6VEdoegT6KlIiQmyJp4OBTrk2aiqGCiYZG
	c45ypg5MkXZtbi37U2Gn60eSmiyeVsvqUCtS9w89x4hjBPeXz9DpWMCr6xZaXg==
X-Gm-Gg: Acq92OFkcRhlLOQh13NdWQ04IbNk29dmZ4KE1vldRTK45cazz+eS3+ErrABuT1AvGjk
	1Ip6qDrhn5c5oMbhTKa78QlGlQ/9slWwlYxs48PpFibk6wkU8yG8iZzRolN2BO9VhRD2SduL3I9
	BwMrFFWdpgV+UOe4UvU2QU8tqlqvKa1pYPV2sNNcnBrDMy7q2uVJT4fEytsi/mAFS5SK2DPK9mm
	CshVHM5msRn5Cru3JLQup9oPbQwIH+buFnz2Zt9SO5tXphk/Dpu5lPRw2ug106Og4zdxiu7Ldq2
	FBnHoLoD+VVEvZHHng9wQAvAWcnDkwPguo80M5WGQUpRdM0fES5EXD8fUTqhftr98VEoNQACJ3w
	hZx0PNTg2P4kF0cmH66AN+8SB4s+Be3ZKpC4Rxzh+DGUujPSMtumtOZEKOHIOD4VCjxkRkmc6QB
	ZubKyIhQupvgFVG7CGeFq8W8RiXbWuBz3HK8a3
X-Received: by 2002:a05:620a:1a14:b0:8cf:e0fe:f217 with SMTP id af79cd13be357-9158a6b3406mr1087977185a.20.1780559160238;
        Thu, 04 Jun 2026 00:46:00 -0700 (PDT)
Received: from [127.0.0.1] ([52.188.86.145])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a3e0d55sm513249985a.43.2026.06.04.00.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 00:45:59 -0700 (PDT)
Message-Id: <pull.2135.git.1780559158.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 04 Jun 2026 07:45:52 +0000
Subject: [PATCH 0/6] t: add lint-style.pl and convert grep to test_grep
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

The test suite has a test_grep wrapper that prints file contents on
assertion failure, making debugging easier. Many tests still use bare 'grep'
for assertions, which silently swallows context on failure.

This series adds a lint tool (lint-style.pl) to mechanically detect and
convert these, then applies it across the test suite.

The tool reuses the shared shell parser (t/lib-shell-parser.pl) rather than
reimplementing shell parsing. This gives us proper handling of heredocs,
$(...), pipes, quoting, case patterns, and control flow structures for free.
The only new parsing logic is the grep assertion classifier, which works on
the already-parsed token stream.

The classifier distinguishes grep used as an assertion (checking exit status
against PATTERN + FILE) from grep used as a filter (pipes, redirects, $(),
control flow conditions). Only assertions are converted. Greps at assertion
level with no file argument are flagged as likely bugs; three pre-existing
instances were found and fixed in patch 5.

The --fix mode converts mechanically: 'grep' becomes 'test_grep', '! grep'
becomes 'test_grep !'.

Structure:

1/6 t/README: document test_grep helper 2/6 t: extract chainlint's parser
into shared module 3/6 t: fix Lexer line count for $() inside double-quoted
strings 4/6 t: add lint-style.pl with test_grep negation rule 5/6 t: fix
grep assertions missing file arguments 6/6 t: lint and convert grep
assertions to test_grep

Patch 2 extracts chainlint.pl's Lexer, ShellParser, and ScriptParser into
t/lib-shell-parser.pl. ScriptParser's check_test() becomes a no-op in the
module; chainlint.pl defines ChainlintParser (a ScriptParser subclass that
runs TestParser for &&-chain detection), and lint-style.pl defines
LintParser (a ScriptParser subclass that runs grep lint rules).

Patch 3 fixes a pre-existing bug in scan_dqstring where the post-loop
newline counter re-counted newlines that were already counted during
recursive $() parsing. The fix counts newlines inline as non-special
characters are consumed, removing the catch-all counter entirely. chainlint
is unaffected (it uses byte offsets), but lint-style.pl needs accurate token
line numbers to locate and fix specific lines in the original file.

Patch 4 introduces the lint-style.pl framework (LintParser subclass,
Makefile targets, fixture infrastructure) with a small, complete rule (!
test_grep -> test_grep !) so reviewers can see the machinery in action
before the bulk conversion.

Patch 5 fixes three test bugs where grep assertions were missing their file
arguments, causing them to pass vacuously (all three pass with the corrected
arguments). These were independently discovered by the missing-file
detection rule introduced in patch 6.

Patch 6 adds the main rule, its fixtures, and the mechanical conversion of
~2800 assertions across ~340 files, including sourced test fragments in
t/t5411/ and heredoc test bodies in t/t5564/.

To verify the conversion (patch 6 adds both the rule and the mechanical
conversion in the same commit, so apply the full series and re-run --fix to
confirm it produces no further changes):

git checkout && perl t/lint-style.pl --fix t/t*.sh t/test-lib*.sh t/lib-.sh
t/-tests.sh t/perf/.sh t/t5411/.sh

As an independent completeness check:

grep -rn '^\s*!\sgrep\s' t/t*.sh t/lib-.sh t/-tests.sh
t/test-lib*.sh t/perf/*.sh | grep -v test_grep | grep -v lint-ok | grep -v
'#.*grep'

Future rules:

The framework is designed to make adding new rules cheap. Each rule is a
function that receives parsed commands and the token stream. The harness
handles tokenization, line mapping, --fix, and fixture testing. Three
natural follow-ups:

 * 'test_must_fail grep': test_must_fail distinguishes expected failures
   from crashes (signals), which only makes sense for git commands. Using it
   with grep or test_grep should be '! grep' or 'test_grep !' instead.

 * '! git cmd': should use test_must_fail, which distinguishes controlled
   failures from crashes. The README explicitly documents this as a "don't".

 * 'test -f' / 'test -d' / 'test -e': should use test_path_is_file,
   test_path_is_dir, test_path_exists. The helpers print the actual
   directory listing on failure; bare 'test' just says "failed".

Known limitations:

 * One grep in t/t1400 asserts against .git/packed-refs which does not exist
   on the reftable backend; suppressed with '# lint-ok'.

 * One grep in t/t7450 checks a path inside a clone that may have failed
   (MINGW-only test); the file may not exist, so test_grep's existence check
   would trip; suppressed with '# lint-ok'.

 * Two greps in t/t3901 inside case branches that inherit piped stdin from
   two lines above are suppressed with '# lint-ok'.

 * One grep in t/t6437 uses glob expansion (grep -q content *) which breaks
   test_grep's file check; suppressed with '# lint-ok'.

 * One grep in t/t7527 captures $? for later use rather than asserting
   inline; suppressed with '# lint-ok'.

Michael Montalbo (6):
  t/README: document test_grep helper
  t: extract chainlint's parser into shared module
  t: fix Lexer line count for $() inside double-quoted strings
  t: add lint-style.pl with test_grep negation rule
  t: fix grep assertions missing file arguments
  t: lint and convert grep assertions to test_grep

 t/.gitattributes                             |   2 +
 t/Makefile                                   |  37 +-
 t/README                                     |  21 +
 t/chainlint.pl                               | 521 +-----------------
 t/check-shell-parser.pl                      |  58 +++
 t/for-each-ref-tests.sh                      |  12 +-
 t/lib-bitmap.sh                              |  12 +-
 t/lib-bundle-uri-protocol.sh                 |  26 +-
 t/lib-httpd.sh                               |   2 +-
 t/lib-shell-parser.pl                        | 522 +++++++++++++++++++
 t/lint-style.pl                              | 425 +++++++++++++++
 t/lint-style/grep-assert.expect              |  13 +
 t/lint-style/grep-assert.test                |  24 +
 t/lint-style/grep-fix.expect                 |  16 +
 t/lint-style/grep-fix.test                   |  16 +
 t/lint-style/grep-missing-file.expect        |   4 +
 t/lint-style/grep-missing-file.test          |   6 +
 t/lint-style/grep-negated.expect             |   5 +
 t/lint-style/grep-negated.test               |   9 +
 t/lint-style/grep-not-assert.expect          |   0
 t/lint-style/grep-not-assert.test            |  43 ++
 t/lint-style/heredoc.expect                  |   3 +
 t/lint-style/heredoc.test                    |  14 +
 t/lint-style/test-grep-negation-fix.expect   |   4 +
 t/lint-style/test-grep-negation-fix.test     |   4 +
 t/lint-style/test-grep-negation.expect       |   3 +
 t/lint-style/test-grep-negation.test         |   4 +
 t/pack-refs-tests.sh                         |   2 +-
 t/show-ref-exists-tests.sh                   |   2 +-
 t/t0000-basic.sh                             |  16 +-
 t/t0001-init.sh                              |  18 +-
 t/t0008-ignores.sh                           |   8 +-
 t/t0009-git-dir-validation.sh                |   6 +-
 t/t0012-help.sh                              |   4 +-
 t/t0013-sha1dc.sh                            |   2 +-
 t/t0017-env-helper.sh                        |   4 +-
 t/t0021-conversion.sh                        |  18 +-
 t/t0029-core-unsetenvvars.sh                 |   4 +-
 t/t0030-stripspace.sh                        |   4 +-
 t/t0031-lockfile-pid.sh                      |   2 +-
 t/t0040-parse-options.sh                     |  52 +-
 t/t0041-usage.sh                             |   2 +-
 t/t0052-simple-ipc.sh                        |  10 +-
 t/t0061-run-command.sh                       |   2 +-
 t/t0066-dir-iterator.sh                      |   2 +-
 t/t0068-for-each-repo.sh                     |  16 +-
 t/t0070-fundamental.sh                       |   6 +-
 t/t0081-find-pack.sh                         |  12 +-
 t/t0091-bugreport.sh                         |  18 +-
 t/t0092-diagnose.sh                          |  12 +-
 t/t0100-previous.sh                          |   2 +-
 t/t0200-gettext-basic.sh                     |  14 +-
 t/t0203-gettext-setlocale-sanity.sh          |   4 +-
 t/t0204-gettext-reencode-sanity.sh           |   8 +-
 t/t0210-trace2-normal.sh                     |   6 +-
 t/t0211-trace2-perf.sh                       |  80 +--
 t/t0212-trace2-event.sh                      |   8 +-
 t/t0300-credentials.sh                       |   4 +-
 t/t0410-partial-clone.sh                     |  82 +--
 t/t0450-txt-doc-vs-help.sh                   |   2 +-
 t/t0500-progress-display.sh                  |  18 +-
 t/t0610-reftable-basics.sh                   |   8 +-
 t/t1004-read-tree-m-u-wf.sh                  |   8 +-
 t/t1006-cat-file.sh                          |  18 +-
 t/t1007-hash-object.sh                       |   8 +-
 t/t1011-read-tree-sparse-checkout.sh         |  10 +-
 t/t1050-large.sh                             |   6 +-
 t/t1091-sparse-checkout-builtin.sh           |  24 +-
 t/t1092-sparse-checkout-compatibility.sh     |  44 +-
 t/t1300-config.sh                            |  16 +-
 t/t1305-config-include.sh                    |   2 +-
 t/t1308-config-set.sh                        |   6 +-
 t/t1400-update-ref.sh                        | 170 +++---
 t/t1403-show-ref.sh                          |  18 +-
 t/t1410-reflog.sh                            |   4 +-
 t/t1415-worktree-refs.sh                     |   4 +-
 t/t1430-bad-ref-name.sh                      |  56 +-
 t/t1450-fsck.sh                              |  12 +-
 t/t1451-fsck-buffer.sh                       |   6 +-
 t/t1460-refs-migrate.sh                      |   2 +-
 t/t1500-rev-parse.sh                         |   6 +-
 t/t1502-rev-parse-parseopt.sh                |   2 +-
 t/t1503-rev-parse-verify.sh                  |  10 +-
 t/t1510-repo-setup.sh                        |  10 +-
 t/t1512-rev-parse-disambiguation.sh          |   4 +-
 t/t1515-rev-parse-outside-repo.sh            |   2 +-
 t/t1800-hook.sh                              |  18 +-
 t/t2004-checkout-cache-temp.sh               |   4 +-
 t/t2019-checkout-ambiguous-ref.sh            |   4 +-
 t/t2024-checkout-dwim.sh                     |   8 +-
 t/t2030-unresolve-info.sh                    |   6 +-
 t/t2060-switch.sh                            |   6 +-
 t/t2070-restore.sh                           |   2 +-
 t/t2080-parallel-checkout-basics.sh          |  14 +-
 t/t2081-parallel-checkout-collisions.sh      |  24 +-
 t/t2082-parallel-checkout-attributes.sh      |  12 +-
 t/t2103-update-index-ignore-missing.sh       |   6 +-
 t/t2200-add-update.sh                        |   2 +-
 t/t2203-add-intent.sh                        |   6 +-
 t/t2400-worktree-add.sh                      |  24 +-
 t/t2402-worktree-list.sh                     |  16 +-
 t/t2403-worktree-move.sh                     |   6 +-
 t/t2405-worktree-submodule.sh                |   6 +-
 t/t2407-worktree-heads.sh                    |  26 +-
 t/t2500-untracked-overwriting.sh             |   8 +-
 t/t2501-cwd-empty.sh                         |   4 +-
 t/t3001-ls-files-others-exclude.sh           |   6 +-
 t/t3007-ls-files-recurse-submodules.sh       |   6 +-
 t/t3200-branch.sh                            |  12 +-
 t/t3202-show-branch.sh                       |  10 +-
 t/t3203-branch-output.sh                     |   4 +-
 t/t3206-range-diff.sh                        |  78 +--
 t/t3207-branch-submodule.sh                  |   4 +-
 t/t3301-notes.sh                             |  32 +-
 t/t3310-notes-merge-manual-resolve.sh        |  16 +-
 t/t3320-notes-merge-worktrees.sh             |   2 +-
 t/t3400-rebase.sh                            |  16 +-
 t/t3402-rebase-merge.sh                      |  16 +-
 t/t3404-rebase-interactive.sh                |  72 +--
 t/t3406-rebase-message.sh                    |   6 +-
 t/t3415-rebase-autosquash.sh                 |  10 +-
 t/t3416-rebase-onto-threedots.sh             |   4 +-
 t/t3418-rebase-continue.sh                   |  10 +-
 t/t3420-rebase-autostash.sh                  |  25 +-
 t/t3422-rebase-incompatible-options.sh       |   4 +-
 t/t3429-rebase-edit-todo.sh                  |   2 +-
 t/t3430-rebase-merges.sh                     |  32 +-
 t/t3500-cherry.sh                            |   4 +-
 t/t3501-revert-cherry-pick.sh                |   6 +-
 t/t3504-cherry-pick-rerere.sh                |   6 +-
 t/t3510-cherry-pick-sequence.sh              |  24 +-
 t/t3602-rm-sparse-checkout.sh                |   4 +-
 t/t3705-add-sparse-checkout.sh               |  10 +-
 t/t3800-mktag.sh                             |   4 +-
 t/t3901-i18n-patch.sh                        |  20 +-
 t/t3903-stash.sh                             |  28 +-
 t/t3904-stash-patch.sh                       |   4 +-
 t/t3908-stash-in-worktree.sh                 |   2 +-
 t/t4000-diff-format.sh                       |   2 +-
 t/t4001-diff-rename.sh                       |   4 +-
 t/t4011-diff-symlink.sh                      |   2 +-
 t/t4013-diff-various.sh                      |   2 +-
 t/t4014-format-patch.sh                      | 344 ++++++------
 t/t4015-diff-whitespace.sh                   |  16 +-
 t/t4017-diff-retval.sh                       |   2 +-
 t/t4018-diff-funcname.sh                     |   2 +-
 t/t4019-diff-wserror.sh                      |   8 +-
 t/t4020-diff-external.sh                     |  18 +-
 t/t4021-format-patch-numbered.sh             |   4 +-
 t/t4022-diff-rewrite.sh                      |  14 +-
 t/t4028-format-patch-mime-headers.sh         |   6 +-
 t/t4031-diff-rewrite-binary.sh               |  18 +-
 t/t4033-diff-patience.sh                     |   2 +-
 t/t4036-format-patch-signer-mime.sh          |   6 +-
 t/t4038-diff-combined.sh                     |   6 +-
 t/t4051-diff-function-context.sh             |  38 +-
 t/t4053-diff-no-index.sh                     |   4 +-
 t/t4063-diff-blobs.sh                        |   2 +-
 t/t4065-diff-anchored.sh                     |  26 +-
 t/t4067-diff-partial-clone.sh                |  12 +-
 t/t4073-diff-stat-name-width.sh              |  24 +-
 t/t4103-apply-binary.sh                      |   2 +-
 t/t4120-apply-popt.sh                        |   2 +-
 t/t4124-apply-ws-rule.sh                     |  10 +-
 t/t4128-apply-root.sh                        |   2 +-
 t/t4140-apply-ita.sh                         |   4 +-
 t/t4141-apply-too-large.sh                   |   2 +-
 t/t4150-am.sh                                |  48 +-
 t/t4200-rerere.sh                            |   6 +-
 t/t4201-shortlog.sh                          |   2 +-
 t/t4202-log.sh                               |  84 +--
 t/t4204-patch-id.sh                          |   2 +-
 t/t4205-log-pretty-formats.sh                |   2 +-
 t/t4209-log-pickaxe.sh                       |  10 +-
 t/t4211-line-log.sh                          |  72 +--
 t/t4216-log-bloom.sh                         |  18 +-
 t/t4252-am-options.sh                        |  22 +-
 t/t4254-am-corrupt.sh                        |   6 +-
 t/t4258-am-quoted-cr.sh                      |   2 +-
 t/t4301-merge-tree-write-tree.sh             |  18 +-
 t/t5000-tar-tree.sh                          |  10 +-
 t/t5004-archive-corner-cases.sh              |   2 +-
 t/t5100-mailinfo.sh                          |   2 +-
 t/t5150-request-pull.sh                      |  18 +-
 t/t5300-pack-object.sh                       |  22 +-
 t/t5302-pack-index.sh                        |   6 +-
 t/t5304-prune.sh                             |   8 +-
 t/t5310-pack-bitmaps.sh                      |  14 +-
 t/t5317-pack-objects-filter-objects.sh       |  12 +-
 t/t5318-commit-graph.sh                      |   8 +-
 t/t5319-multi-pack-index.sh                  |  16 +-
 t/t5324-split-commit-graph.sh                |  10 +-
 t/t5325-reverse-index.sh                     |   2 +-
 t/t5326-multi-pack-bitmaps.sh                |  28 +-
 t/t5328-commit-graph-64bit-time.sh           |   2 +-
 t/t5329-pack-objects-cruft.sh                |   8 +-
 t/t5334-incremental-multi-pack-index.sh      |   2 +-
 t/t5335-compact-multi-pack-index.sh          |   4 +-
 t/t5351-unpack-large-objects.sh              |   2 +-
 t/t5402-post-merge-hook.sh                   |   4 +-
 t/t5403-post-checkout-hook.sh                |   2 +-
 t/t5404-tracking-branches.sh                 |   2 +-
 t/t5406-remote-rejects.sh                    |   2 +-
 t/t5407-post-rewrite-hook.sh                 |   8 +-
 t/t5409-colorize-remote-messages.sh          |  36 +-
 t/t5411/test-0013-bad-protocol.sh            |  14 +-
 t/t5411/test-0014-bad-protocol--porcelain.sh |  14 +-
 t/t5500-fetch-pack.sh                        |  38 +-
 t/t5504-fetch-receive-strict.sh              |  14 +-
 t/t5505-remote.sh                            |  20 +-
 t/t5510-fetch.sh                             |  10 +-
 t/t5512-ls-remote.sh                         |   8 +-
 t/t5514-fetch-multiple.sh                    |   2 +-
 t/t5516-fetch-push.sh                        |  20 +-
 t/t5520-pull.sh                              |   4 +-
 t/t5524-pull-msg.sh                          |   6 +-
 t/t5526-fetch-submodules.sh                  |  16 +-
 t/t5529-push-errors.sh                       |   4 +-
 t/t5530-upload-pack-error.sh                 |  18 +-
 t/t5531-deep-submodule-push.sh               |   2 +-
 t/t5532-fetch-proxy.sh                       |   2 +-
 t/t5533-push-cas.sh                          |  12 +-
 t/t5534-push-signed.sh                       |  22 +-
 t/t5537-fetch-shallow.sh                     |   2 +-
 t/t5538-push-shallow.sh                      |   2 +-
 t/t5539-fetch-http-shallow.sh                |   4 +-
 t/t5541-http-push-smart.sh                   |  32 +-
 t/t5544-pack-objects-hook.sh                 |  12 +-
 t/t5550-http-fetch-dumb.sh                   |   4 +-
 t/t5551-http-fetch-smart.sh                  |  46 +-
 t/t5552-skipping-fetch-negotiator.sh         |   6 +-
 t/t5554-noop-fetch-negotiator.sh             |   4 +-
 t/t5557-http-get.sh                          |   2 +-
 t/t5558-clone-bundle-uri.sh                  |  38 +-
 t/t5562-http-backend-content-length.sh       |   2 +-
 t/t5564-http-proxy.sh                        |  10 +-
 t/t5581-http-curl-verbose.sh                 |   2 +-
 t/t5583-push-branches.sh                     |   8 +-
 t/t5601-clone.sh                             |  28 +-
 t/t5604-clone-reference.sh                   |   8 +-
 t/t5605-clone-local.sh                       |   2 +-
 t/t5606-clone-options.sh                     |   6 +-
 t/t5612-clone-refspec.sh                     |   2 +-
 t/t5616-partial-clone.sh                     |  60 +--
 t/t5619-clone-local-ambiguous-transport.sh   |   2 +-
 t/t5620-backfill.sh                          |  12 +-
 t/t5700-protocol-v1.sh                       |  46 +-
 t/t5701-git-serve.sh                         |  14 +-
 t/t5702-protocol-v2.sh                       | 152 +++---
 t/t5703-upload-pack-ref-in-want.sh           |  22 +-
 t/t5705-session-id-in-capabilities.sh        |  12 +-
 t/t5750-bundle-uri-parse.sh                  |   8 +-
 t/t5801-remote-helpers.sh                    |   4 +-
 t/t5810-proto-disable-local.sh               |   2 +-
 t/t5813-proto-disable-ssh.sh                 |   4 +-
 t/t6000-rev-list-misc.sh                     |  26 +-
 t/t6005-rev-list-count.sh                    |   8 +-
 t/t6006-rev-list-format.sh                   |   4 +-
 t/t6009-rev-list-parent.sh                   |   4 +-
 t/t6020-bundle-misc.sh                       |  12 +-
 t/t6022-rev-list-missing.sh                  |   4 +-
 t/t6030-bisect-porcelain.sh                  | 150 +++---
 t/t6040-tracking-info.sh                     |   2 +-
 t/t6112-rev-list-filters-objects.sh          |  24 +-
 t/t6115-rev-list-du.sh                       |   4 +-
 t/t6120-describe.sh                          |  14 +-
 t/t6200-fmt-merge-msg.sh                     |  82 +--
 t/t6402-merge-rename.sh                      |   4 +-
 t/t6403-merge-file.sh                        |   6 +-
 t/t6404-recursive-merge.sh                   |   2 +-
 t/t6406-merge-attr.sh                        |  20 +-
 t/t6417-merge-ours-theirs.sh                 |  30 +-
 t/t6418-merge-text-auto.sh                   |   2 +-
 t/t6422-merge-rename-corner-cases.sh         |   8 +-
 t/t6423-merge-rename-directories.sh          |  72 +--
 t/t6424-merge-unrelated-index-changes.sh     |   6 +-
 t/t6427-diff3-conflict-markers.sh            |  10 +-
 t/t6432-merge-recursive-space-options.sh     |   4 +-
 t/t6436-merge-overwrite.sh                   |   6 +-
 t/t6437-submodule-merge.sh                   |  12 +-
 t/t6500-gc.sh                                |   8 +-
 t/t6600-test-reach.sh                        |   4 +-
 t/t7001-mv.sh                                |  16 +-
 t/t7002-mv-sparse-checkout.sh                |  38 +-
 t/t7003-filter-branch.sh                     |  16 +-
 t/t7004-tag.sh                               |   2 +-
 t/t7006-pager.sh                             |  16 +-
 t/t7012-skip-worktree-writing.sh             |   6 +-
 t/t7030-verify-tag.sh                        |  52 +-
 t/t7031-verify-tag-signed-ssh.sh             |  46 +-
 t/t7102-reset.sh                             |   2 +-
 t/t7110-reset-merge.sh                       |  40 +-
 t/t7201-co.sh                                |   6 +-
 t/t7300-clean.sh                             |   2 +-
 t/t7301-clean-interactive.sh                 |   2 +-
 t/t7400-submodule-basic.sh                   |  32 +-
 t/t7402-submodule-rebase.sh                  |   2 +-
 t/t7406-submodule-update.sh                  |  26 +-
 t/t7416-submodule-dash-url.sh                |  20 +-
 t/t7417-submodule-path-url.sh                |   2 +-
 t/t7450-bad-git-dotfiles.sh                  |  14 +-
 t/t7501-commit-basic-functionality.sh        |  14 +-
 t/t7502-commit-porcelain.sh                  |   2 +-
 t/t7507-commit-verbose.sh                    |   6 +-
 t/t7508-status.sh                            |   6 +-
 t/t7510-signed-commit.sh                     |  68 +--
 t/t7516-commit-races.sh                      |   4 +-
 t/t7519-status-fsmonitor.sh                  |  14 +-
 t/t7527-builtin-fsmonitor.sh                 |  84 +--
 t/t7528-signed-commit-ssh.sh                 |  68 +--
 t/t7600-merge.sh                             |  10 +-
 t/t7603-merge-reduce-heads.sh                |  20 +-
 t/t7606-merge-custom.sh                      |   2 +-
 t/t7607-merge-state.sh                       |   4 +-
 t/t7610-mergetool.sh                         |  18 +-
 t/t7700-repack.sh                            |  14 +-
 t/t7703-repack-geometric.sh                  |   4 +-
 t/t7704-repack-cruft.sh                      |  12 +-
 t/t7800-difftool.sh                          |  26 +-
 t/t7810-grep.sh                              |  22 +-
 t/t7814-grep-recurse-submodules.sh           |   2 +-
 t/t7900-maintenance.sh                       |  36 +-
 t/t8008-blame-formats.sh                     |   2 +-
 t/t8010-cat-file-filters.sh                  |   2 +-
 t/t8012-blame-colors.sh                      |   2 +-
 t/t9001-send-email.sh                        | 190 +++----
 t/t9003-help-autocorrect.sh                  |   6 +-
 t/t9106-git-svn-commit-diff-clobber.sh       |   2 +-
 t/t9107-git-svn-migrate.sh                   |  30 +-
 t/t9110-git-svn-use-svm-props.sh             |  20 +-
 t/t9111-git-svn-use-svnsync-props.sh         |  18 +-
 t/t9114-git-svn-dcommit-merge.sh             |   6 +-
 t/t9116-git-svn-log.sh                       |   8 +-
 t/t9117-git-svn-init-clone.sh                |  12 +-
 t/t9119-git-svn-info.sh                      |  16 +-
 t/t9122-git-svn-author.sh                    |   8 +-
 t/t9130-git-svn-authors-file.sh              |   8 +-
 t/t9138-git-svn-authors-prog.sh              |  14 +-
 t/t9140-git-svn-reset.sh                     |   4 +-
 t/t9153-git-svn-rewrite-uuid.sh              |   4 +-
 t/t9200-git-cvsexportcommit.sh               |   2 +-
 t/t9210-scalar.sh                            |  34 +-
 t/t9211-scalar-clone.sh                      |  16 +-
 t/t9300-fast-import.sh                       |  10 +-
 t/t9350-fast-export.sh                       |  54 +-
 t/t9351-fast-export-anonymize.sh             |  36 +-
 t/t9400-git-cvsserver-server.sh              |   4 +-
 t/t9501-gitweb-standalone-http-status.sh     |  58 +--
 t/t9502-gitweb-standalone-parse-output.sh    |  38 +-
 t/t9800-git-p4-basic.sh                      |  10 +-
 t/t9801-git-p4-branch.sh                     |  48 +-
 t/t9806-git-p4-options.sh                    |  10 +-
 t/t9807-git-p4-submit.sh                     |   2 +-
 t/t9810-git-p4-rcs.sh                        |   8 +-
 t/t9813-git-p4-preserve-users.sh             |   8 +-
 t/t9814-git-p4-rename.sh                     |   8 +-
 t/t9827-git-p4-change-filetype.sh            |   4 +-
 t/t9832-unshelve.sh                          |   6 +-
 t/t9833-errors.sh                            |   4 +-
 t/t9835-git-p4-metadata-encoding-python2.sh  |  36 +-
 t/t9836-git-p4-metadata-encoding-python3.sh  |  38 +-
 t/t9850-shell.sh                             |   2 +-
 t/t9902-completion.sh                        |  26 +-
 363 files changed, 4067 insertions(+), 3334 deletions(-)
 create mode 100644 t/check-shell-parser.pl
 create mode 100644 t/lib-shell-parser.pl
 create mode 100755 t/lint-style.pl
 create mode 100644 t/lint-style/grep-assert.expect
 create mode 100644 t/lint-style/grep-assert.test
 create mode 100644 t/lint-style/grep-fix.expect
 create mode 100644 t/lint-style/grep-fix.test
 create mode 100644 t/lint-style/grep-missing-file.expect
 create mode 100644 t/lint-style/grep-missing-file.test
 create mode 100644 t/lint-style/grep-negated.expect
 create mode 100644 t/lint-style/grep-negated.test
 create mode 100644 t/lint-style/grep-not-assert.expect
 create mode 100644 t/lint-style/grep-not-assert.test
 create mode 100644 t/lint-style/heredoc.expect
 create mode 100644 t/lint-style/heredoc.test
 create mode 100644 t/lint-style/test-grep-negation-fix.expect
 create mode 100644 t/lint-style/test-grep-negation-fix.test
 create mode 100644 t/lint-style/test-grep-negation.expect
 create mode 100644 t/lint-style/test-grep-negation.test


base-commit: 9ac3f193c05c2237e2b14ebaa1149e9fc8a1abe0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2135%2Fmmontalbo%2Fmm%2Ftest-grep-docs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2135/mmontalbo/mm/test-grep-docs-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2135
-- 
gitgitgadget
