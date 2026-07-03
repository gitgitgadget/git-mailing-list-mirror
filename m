Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF543254B8
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 04:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783054485; cv=none; b=dFXEvWuKNdL960hGbXx3XlsjLmapURyOYmOnezl4+bexagJT6eg9JmgbeWuECBYs2ALO68ac1I4Ulh9LmF++dh98BkNDkqD6hlY3M1ICwJ48h8wwte42V9jFTlx44Fmt83RhLnNLWr1x5lN2hkTNss7Zvpz9a7VHxhgioy/wpEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783054485; c=relaxed/simple;
	bh=xCENxBiaC4cjtL7YwgRVL/ftm0voVjtnMKxRouqfMu0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=q5n8avUwCrVLfxJoMt42L4XhzPjGLmE8nzBug7iDPxP3G79nJCW87gl4TxZl4J9Ac96b3r6RMVhxCjffDAGkhB5s4aNszOsECWH7gcWcNvA06nfbmjc/5h9xUe9UMEFv+lOaNQUnP5ZpA7r5mJB1laF7ge9obI8f837na+bRELY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0BVDGDA; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0BVDGDA"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8f2509d6becso1384856d6.2
        for <git@vger.kernel.org>; Thu, 02 Jul 2026 21:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783054469; x=1783659269; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpaJDrRXD1d9Ub2Sz1aRl6otLw1TwVhpWQyNqlDrfWo=;
        b=Q0BVDGDAvpg+3eIkhl2h+HGzjymD4tTZjCKNeI9vbkDWGgpJce2GmbrEpvzFNt6igK
         Yd1yQfe+3U9bcA2jUy/NDvCEQQu/UQxwoHiv3GRCtuxIznUNs4wyQdugSCvJGpxg/mqH
         0FOK+SWtERylTqWxDMTky/vW6kaEomj5mXVDt+jc4dxzzligm9KB1qLYtHvUlxq9g6dh
         okqGtpRIqdzeWZjj2ikccyrACbENJgmIlj23lWNOmEA498gBM7OO1IldE00E+yrr9rJV
         XMOZOCoMLfl551a3qo66C7nlGr9stqp+5WyjebkCMPoikhOXu9oNXPyIoGMwt2egluiu
         ZkrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783054469; x=1783659269;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fpaJDrRXD1d9Ub2Sz1aRl6otLw1TwVhpWQyNqlDrfWo=;
        b=C/4KTiIrSzq51bJ/eOob5ePykRtHsDvwFknVvvMUHi64z7dWLGuYa8Cyep5pimdhS3
         RGJqUl+BUllWIkEWoXPtoI0j/X6MVyn6gxXUUMGzK09udSnBJVdbHYfE3YUwayalAdDp
         f+4ObV8ijoaGLPrEQS8xnkx6To+x7gaofCt/DqJNYEDmyxvyUn7L7oGyzJb6MrN6O8eY
         JCNd+gZFzFafp7BvKxmrc5TJsD/D9IuRUN3rvcCixXIchRw54uaJh1uVP9qWpl9kLSrZ
         GRX0Sc91N8kuemegoJpwNC9GYvDtArJRpkJcxRBwjU+DFBsafsaDuC/T5ibiRBG+j/Wr
         lSBw==
X-Gm-Message-State: AOJu0YzjIHyCiTy0i2+JeQsMevfO/WbVFIcRXeJBA/4496E+WWPCg0WO
	jpTMKik2CQ+nZ0etdm3aBEVO8kGz1Sfa7VPCQ7NYfrI68zMllcJLEuqMunQBJw==
X-Gm-Gg: AfdE7cnCC1ONOEU+ca1SSBpr+DZ5+zV+XRmE8269sPrgiAPwCd9X+qKXjEDU0blWR3x
	8+XPDtwOqKesixFKzgy2y3CpA/D3CG1JIV6nxJr5jFDPYKMEEIFhEIpfR2ex/r4rqNYS+Mc+Cw1
	6SdMHJnzi8v3zEgTkc8xgZaelk0BuYFfYnZgyNVtdSakPdJaK4S9hN9YfeiJk0RHQhm5Z8KE+9M
	Jc3l8vS4ICnAZ9l9WgTzjg9hxWGC80iHzlFhSojrFsqYq2MxpQGrvrMaSK5dQX4kAjDwV+wSX0O
	zcOruAEPeNsZCh+w1UFLjvAZhF/acphMD2jnUGmKMhKRKo5xlKTRE6FLNoLBnM/Lg1D+KPJlACb
	LDWbxu9Fvx3uZUyqo+2gaBxWdSG1kUZJvm46XWhnueu80rJtURuq+sqPUTaKdnMh6fJcbLOHPKB
	2DdGdJj4r3SIBFgTk=
X-Received: by 2002:a05:6214:e6a:b0:8ef:db4:d84a with SMTP id 6a1803df08f44-8f3c301f0damr130046386d6.0.1783054468491;
        Thu, 02 Jul 2026 21:54:28 -0700 (PDT)
Received: from [127.0.0.1] ([48.217.251.96])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f471814324sm45543676d6.28.2026.07.02.21.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 21:54:27 -0700 (PDT)
Message-Id: <pull.2135.v3.git.1783054466.gitgitgadget@gmail.com>
In-Reply-To: <pull.2135.v2.git.1781323575.gitgitgadget@gmail.com>
References: <pull.2135.v2.git.1781323575.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 03 Jul 2026 04:54:19 +0000
Subject: [PATCH v3 0/6] t: add greplint.pl and convert grep to test_grep
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
    SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
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

Changes since v2:

 * t3420-rebase-autostash: dropped the change to the '! grep dirty file3'
   line under 'rebase --quit'. As SZEDER pointed out, file3 never exists in
   the conflicted state, so that grep was passing only because it could not
   open the file. SZEDER's fix (sg/t3420-do-not-grep-in-missing-file, now in
   'next') replaces the line with 'test_path_is_missing file3', which is the
   right check; this series simply leaves that line to his fix.

 * Audited the remaining '# lint-ok' annotations for the same "grep a file
   that never exists with correctly running Git" gotcha, as Junio suggested.
   The rule the audit applies: 'grep' becomes 'test_grep' only where its
   exit code is the assertion; grep that produces data (a filter) or that
   reads a file whose presence is conditional stays a plain 'grep', because
   test_grep BUGs on a missing file.
   
   * t5537 (.git/shallow): the file is still present after the repack (the
     client stays shallow), so the assertion is converted to 'test_grep !'
     like any other; the "may not exist" note was wrong.
   
   * t1400 (.git/packed-refs): the file exists only with the files backend.
     Guarded the packed-refs check with a REFFILES prerequisite; the
     backend-agnostic 'git show-ref' check that follows still runs under
     every backend.
   
   * t7450 (squatting-clone/d/a/git~2): kept as '! grep' with an improved '#
     lint-ok'. 'git~2' is the NTFS 8.3 short name of a planted '..git' decoy
     and only exists when 8.3 short-name generation is enabled. Verified on
     a Windows VM: with 8.3 disabled (the modern default) the short name is
     absent, the '! grep' correctly tolerates it, and a plain test_grep
     would BUG. So this one deliberately stays a missing-file-tolerant grep.
   
   * t5326 and t5702 remain annotated: these are genuine data filters (grep
     produces data that is redirected/captured, not an assertion).

 * Rebased onto master. The only conflict was a one-line codespell typo fix
   that upstream applied to chainlint.pl in the meantime; it now lives in
   the extracted lib-shell-parser.pl.

Known limitation / follow-up:

Assertions like grep pattern file >/dev/null and grep pattern <file are not
converted because greplint.pl treats any redirect as a filter, so it does
not flag them. The former could be converted, but test_grep prints the
matching line on success just as grep does, so the >/dev/null would have to
be kept or dropped as a judgment call. The latter requires turning the <file
redirect into a positional file argument, since test_grep reads a named file
rather than stdin. Both are left as bare grep. A follow-up series can
address these once a convention is established.

Michael Montalbo (6):
  t/README: document test_grep helper
  t: fix grep assertions missing file arguments
  t: extract chainlint's parser into shared module
  t: fix Lexer line count for $() inside double-quoted strings
  t: convert grep assertions to test_grep
  t: add greplint to detect bare grep assertions

 t/.gitattributes                              |   2 +
 t/Makefile                                    |  29 +-
 t/README                                      |  26 +
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
 t/t1400-update-ref.sh                         | 173 +++---
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
 t/t3420-rebase-autostash.sh                   |  24 +-
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
 t/t7450-bad-git-dotfiles.sh                   |  18 +-
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
 385 files changed, 3783 insertions(+), 3328 deletions(-)
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


base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2135%2Fmmontalbo%2Fmm%2Ftest-grep-docs-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2135/mmontalbo/mm/test-grep-docs-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2135

Range-diff vs v2:

 1:  5959cab258 ! 1:  ec6b478c4c t/README: document test_grep helper
     @@ t/README: see test-lib-functions.sh for the full list and their options.
      +   or inside a command substitution (e.g. '$(grep -c ...)'), plain
      +   'grep' is the right choice because the exit code is not the
      +   assertion itself.
     ++
     ++   test_grep requires <file> to exist and will BUG otherwise.
     ++   When a file's presence is conditional (a backend-specific
     ++   file, or a path that only exists on some platforms, such as
     ++   an NTFS 8.3 short name), keep a plain guarded 'grep' instead.
      +
        - test_path_is_file <path>
          test_path_is_dir <path>
 2:  f3e8e19e6e = 2:  7a837b77cd t: fix grep assertions missing file arguments
 3:  460461b5fe ! 3:  5894ca1724 t: extract chainlint's parser into shared module
     @@ t/chainlint.pl: my $jobs = -1;
      -#
      -# In other languages, `1+2` would typically be scanned as three tokens
      -# (`1`, `+`, and `2`), but in shell it is a single token. However, the similar
     --# `1 + 2`, which embeds whitepace, is scanned as three token in shell, as well.
     +-# `1 + 2`, which embeds whitespace, is scanned as three token in shell, as well.
      -# In shell, several characters with special meaning lose that meaning when not
      -# surrounded by whitespace. For instance, the negation operator `!` is special
      -# when standing alone surrounded by whitespace; whereas in `foo!uucp` it is
     @@ t/lib-shell-parser.pl (new)
      +#
      +# In other languages, `1+2` would typically be scanned as three tokens
      +# (`1`, `+`, and `2`), but in shell it is a single token. However, the similar
     -+# `1 + 2`, which embeds whitepace, is scanned as three token in shell, as well.
     ++# `1 + 2`, which embeds whitespace, is scanned as three token in shell, as well.
      +# In shell, several characters with special meaning lose that meaning when not
      +# surrounded by whitespace. For instance, the negation operator `!` is special
      +# when standing alone surrounded by whitespace; whereas in `foo!uucp` it is
 4:  c1b86748d1 = 4:  416c95fee5 t: fix Lexer line count for $() inside double-quoted strings
 5:  3a589ef738 ! 5:  7518445733 t: convert grep assertions to test_grep
     @@ Commit message
          Existing '! test_grep' calls are rewritten to 'test_grep !' so
          that the diagnostic output is preserved on failure.
      
     +    test_grep requires the file it reads to exist, so '! grep'
     +    assertions that inspect a file whose presence is conditional need
     +    care.  In t5537 the '.git/shallow' file is still present after the
     +    repack (the client remains shallow), so the assertion is
     +    converted like any other.  In t1400 the '.git/packed-refs' file
     +    exists only with the files backend, so its check is guarded with a
     +    REFFILES prerequisite; the backend-agnostic 'git show-ref' check
     +    that follows still runs under every backend.  In t7450 'git~2' is
     +    the NTFS 8.3 short name of a decoy '..git' file and only exists
     +    when 8.3 short-name generation is enabled; that '! grep' tolerates
     +    the missing file on purpose, so it is left as-is with a
     +    "# lint-ok" annotation rather than converted (a plain test_grep
     +    would BUG when the short name is absent).
     +
          The conversion was generated using a grep-assertion linter
          (greplint.pl, added in the following commit) to identify bare
     -    grep calls at command position.  To reproduce:
     +    grep calls at command position.  To reproduce, from the t/
     +    directory:
      
     -        # Step 1: mark bare greps that should not be converted
     -        sed -i '/! grep "$m" \.git\/packed-refs/s/$/ # lint-ok: file may not exist (reftable)/' \
     -            t/t1400-update-ref.sh
     -        sed -i '/! grep dirty file3 &&/{/lint-ok/!s/$/ # lint-ok: file may not exist after --quit/}' \
     -            t/t3420-rebase-autostash.sh
     +        # Step 1: annotate the two data-filter greps (grep produces
     +        # data, not a verdict) so the linter skips them.
              sed -i '/grep -vf before commits\.raw/s/$/ # lint-ok: data filter/' \
     -            t/t5326-multi-pack-bitmaps.sh
     -        sed -i '/! grep $d shallow-client\/\.git\/shallow/s/$/ # lint-ok: file may not exist after repack/' \
     -            t/t5537-fetch-shallow.sh
     +            t5326-multi-pack-bitmaps.sh
              sed -i '/grep -E "^\[0-9a-f\].*|| :/s/$/ # lint-ok: data filter/' \
     -            t/t5702-protocol-v2.sh
     -        sed -i '/! grep gitdir squatting-clone/s/$/ # lint-ok: file may not exist after failed clone/' \
     -            t/t7450-bad-git-dotfiles.sh
     +            t5702-protocol-v2.sh
     +
     +        # Step 1b: two '! grep' assertions need more than a mechanical
     +        # conversion; handle them by hand before the linter-driven steps
     +        # below so it leaves them alone.
     +        #
     +        # t1400: '.git/packed-refs' is absent under reftable, so guard the
     +        # check with REFFILES (a plain test_grep would BUG on the missing
     +        # file):
     +        #
     +        #      git update-ref -d HEAD $B &&
     +        #  -   ! grep "$m" .git/packed-refs &&
     +        #  +   if test_have_prereq REFFILES
     +        #  +   then
     +        #  +           test_grep ! "$m" .git/packed-refs
     +        #  +   fi &&
     +        #      test_must_fail git show-ref --verify -q $m
     +        #
     +        # t7450: git~2 is an NTFS 8.3 short name that exists only when
     +        # short-name generation is enabled, so this stays a missing-file-
     +        # tolerant '! grep'; add a comment plus "# lint-ok" so the linter
     +        # skips it.
      
              # Step 2: reorder pre-existing '! test_grep' to 'test_grep !'
              # (must come before steps 3-4 so greplint does not see them)
     -        sed -i 's/! test_grep/test_grep !/' t/t0031-lockfile-pid.sh
     -        sed -i 's/! test_grep/test_grep !/' t/t5300-pack-object.sh
     -        sed -i 's/! test_grep/test_grep !/' t/t5319-multi-pack-index.sh
     +        sed -i 's/! test_grep/test_grep !/' t0031-lockfile-pid.sh
     +        sed -i 's/! test_grep/test_grep !/' t5300-pack-object.sh
     +        sed -i 's/! test_grep/test_grep !/' t5319-multi-pack-index.sh
      
              # Step 3: convert '! grep' -> 'test_grep !'
     -        perl t/greplint.pl t/*.sh 2>&1 | cut -d: -f1,2 |
     +        perl greplint.pl *.sh 2>&1 | cut -d: -f1,2 |
              while IFS=: read f l; do
                  sed -i "${l}s/! *grep/test_grep !/" "$f"
              done
      
              # Step 4: convert remaining 'grep' -> 'test_grep'
     -        perl t/greplint.pl t/*.sh 2>&1 | cut -d: -f1,2 |
     +        perl greplint.pl *.sh 2>&1 | cut -d: -f1,2 |
              while IFS=: read f l; do
                  sed -i "${l}s/grep/test_grep/" "$f"
              done
     @@ t/t1400-update-ref.sh: test_expect_success "move $m (by HEAD)" '
       	test_when_finished "git update-ref -d $m" &&
       	git update-ref -d HEAD $B &&
      -	! grep "$m" .git/packed-refs &&
     -+	! grep "$m" .git/packed-refs && # lint-ok: file may not exist (reftable)
     ++	if test_have_prereq REFFILES
     ++	then
     ++		test_grep ! "$m" .git/packed-refs
     ++	fi &&
       	test_must_fail git show-ref --verify -q $m
       '
       
     @@ t/t3420-rebase-autostash.sh: testrebase () {
       		git checkout feature-branch
       	'
       
     -@@ t/t3420-rebase-autostash.sh: testrebase () {
     - 		git rebase --quit &&
     - 		test_when_finished git stash drop &&
     - 		test_path_is_missing $dotest/autostash &&
     --		! grep dirty file3 &&
     -+		! grep dirty file3 && # lint-ok: file may not exist after --quit
     - 		git stash show -p >actual &&
     - 		test_cmp expect actual &&
     - 		git reset --hard &&
      @@ t/t3420-rebase-autostash.sh: testrebase () {
       		git rebase$type unrelated-onto-branch >actual 2>&1 &&
       		test_path_is_missing $dotest &&
     @@ t/t4211-line-log.sh: test_expect_success '-L with -G filters to diff-text matche
      +	test_grep "F2 + 2" actual
       '
       
     - test_done
     + test_expect_success '-L with --diff-filter=M excludes root commit' '
      
       ## t/t4216-log-bloom.sh ##
      @@ t/t4216-log-bloom.sh: test_expect_success 'persist filter settings' '
     @@ t/t5537-fetch-shallow.sh: test_expect_success '.git/shallow is edited by repack'
       	git -C shallow-client repack -adfl &&
       	test_must_fail git -C shallow-client rev-parse --verify $d^0 &&
      -	! grep $d shallow-client/.git/shallow &&
     -+	! grep $d shallow-client/.git/shallow && # lint-ok: file may not exist after repack
     ++	test_grep ! $d shallow-client/.git/shallow &&
       
       	git -C shallow-server branch branch-orig $d &&
       	git -C shallow-client fetch --prune --depth=2 \
     @@ t/t7450-bad-git-dotfiles.sh: test_expect_success WINDOWS 'prevent git~1 squattin
       			clone --recurse-submodules squatting squatting-clone 2>err &&
       		test_grep -e "directory not empty" -e "not an empty directory" err &&
      -		! grep gitdir squatting-clone/d/a/git~2
     -+		! grep gitdir squatting-clone/d/a/git~2 # lint-ok: file may not exist after failed clone
     ++		# git~2 is the 8.3 short name of the ..git decoy, present
     ++		# only when 8.3 name generation is on; a missing git~2 is
     ++		# fine because the "directory not empty" check above is the
     ++		# real assertion.
     ++		! grep gitdir squatting-clone/d/a/git~2 # lint-ok: 8.3 short name git~2 may not exist
       	fi
       '
       
 6:  e5ecb37401 = 6:  3b12a959fd t: add greplint to detect bare grep assertions

-- 
gitgitgadget
