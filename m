Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECC9331A41
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 04:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783054581; cv=none; b=E/IGmO4hSkJq6GQw01wCE7hudd6hI0GbiINkvgBUJz8VHoDJb+qbQDPTVlzKS/wx2hjkw+BePDf3RbHdxquKxcWy2asIQOeZP/J3r8v5MxC7S4C/Q0L2E4i5/4YNwykxgcrzKG7B2m+ZKEgdgrgpw4OF3kU0hkcrYXrYGJiQcHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783054581; c=relaxed/simple;
	bh=AsgJKPka2yRWcPU7I8/Cx+OpOgN/fyoKLRMpYxOWKjg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HMK7IKsmwrxz5tIBoFyGaFq44OJ8QqAPI66uZDTPtAFmotg+GT3cJ3lhHbqAfk8KuHsxP6xRVpFB5p3AAeO87KKkgSvzQpOt/3DESRw1kw0JM6ljBth+pJmMHfCq4n8F/fRT+ckQz7yaVKDBOjIsUffIgvwI7Zp6SDLCAQeQ8Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clQKE2NL; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clQKE2NL"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c2a818fc4so1362991cf.2
        for <git@vger.kernel.org>; Thu, 02 Jul 2026 21:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783054481; x=1783659281; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=enTjQ7RyV33PfjFBll8srT885K3x+G+q3UEvtf0Y5NY=;
        b=clQKE2NL4F+fLi5tCwospOrJ5ivniXU5+xbBCD0TcJrTw1ETM8ePtiaz5d147lv4n0
         TYpEhq2PCDbCzewptnhnOZ0/PKiV0AWdAqLYN3pK9Ifgs0LqekoXVvzjo0aSJ6dh/wK6
         8uTA6X6MEPxrfJGIuGqOFXpO51u7K9WzowhiYAPEEG0VSZ8smhjn7SbJAqu1AopWg1/q
         7vz36gUBSdfaLhJ4RMLeDm2EH5ekCtLlvMTu/gj4LmVTn+51IwS/DvXDtG+6m5W55L3t
         hADRGyILo1po0E+93mGaWLqQCWhmej1kiD0MQ3542CZLGLyTUCzRN6w7bU2iKhTa93Xi
         Ohiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783054481; x=1783659281;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=enTjQ7RyV33PfjFBll8srT885K3x+G+q3UEvtf0Y5NY=;
        b=F/NI7fX38s/wNNNqJw0YqgoyCOIXITuIuvAx4wQi4kej4cXzdQ/B5AM4yKt+J2RA4k
         dF6TaZdqcspNdsvHBXPc5MKzscO53SHZQKzKFLT53L8jtLtZLvVIvlo5/sxSpyk+Ay7F
         cMFbXvdQBSO4G0NUdWVCd8dJJU9OWvGFabUDYycCSbiHqQbz9BREZq9enHgrGkkWS9tg
         XAOATO3YN2HR5fvKwiY3dmL1yKEDgNjkCckhREV756cSssnXY5+M39nv+XYr/S8M7/da
         SwsA8N3snR7wWP95lvnRlFj8s1Tth/9yCEF7e3PkmR0jCeWVnksT1aGPWaPnJLeGMUxP
         uFmw==
X-Gm-Message-State: AOJu0YybiE3hW8S1HGd2g9+EL3DWCmX0wKi4ffhXA2+Qbs0JYe0vHQGX
	cYwOKsT7ZQbS5IF/LmtzTSQVrvAhebG0SG3UqUShJ6uYcOIMWgZseaR77s+/gw==
X-Gm-Gg: AfdE7clvyExkAw5eAc7AzXZQjivPxQT52SK1CVraZl8CCl3Uo/ZkMaRs3QMKtW2OmK/
	1jDf5vW/J45n8hbT6mtCws4K0ISFte2v+DM51pDLQQT2ujfnDl4LCEBm+gjAyABDY1q2F0omYw5
	BmV0t+pGoqCLc5rsBGj8dAoq1li1EIDil1QtQbthJOjU9ZqlwNTTzE86/0aIa4dF/Dl4HiadiCk
	e+VSZuoL8vRQcgXQptCIfbnyP7odv2g/hYA6wL+07hf+hM605LIePlxkcAhIeIk47gzgwBGYvzT
	Pz6h7DiyqvGcarNYkzv5seYdB9T6ec36bk3K70HeHN5D8wsuaMmX3JybLUpNjji8R1FqB0QL3I8
	TTHjjfW34kR77GvhDCjq5enELuilFPmhTWL8RD/4H8afccHHuZFYhzgaeEdchQcXJbSGbSwkMtb
	Y4Zfel0LsRGZ40YwQ=
X-Received: by 2002:a05:622a:2309:b0:51c:1ff:2515 with SMTP id d75a77b69052e-51c26b49877mr110666831cf.65.1783054478228;
        Thu, 02 Jul 2026 21:54:38 -0700 (PDT)
Received: from [127.0.0.1] ([48.217.251.96])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41decc5csm6636251cf.26.2026.07.02.21.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 21:54:36 -0700 (PDT)
Message-Id: <751844573398cf21eea3af85f63c7ed2900b31e8.1783054466.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2135.v3.git.1783054466.gitgitgadget@gmail.com>
References: <pull.2135.v2.git.1781323575.gitgitgadget@gmail.com>
	<pull.2135.v3.git.1783054466.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 03 Jul 2026 04:54:24 +0000
Subject: [PATCH v3 5/6] t: convert grep assertions to test_grep
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
    Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

Replace bare grep with test_grep in test assertions across the
suite, including sourced test helpers (lib-*.sh, *-tests.sh).
test_grep prints the contents of the file being searched on
failure, making debugging easier than a bare grep which fails
silently.

Only assertion-style greps are converted: grep used as a filter
in pipelines, command substitutions, conditionals, or with
redirected I/O is left as-is with a "# lint-ok" annotation.
Existing '! test_grep' calls are rewritten to 'test_grep !' so
that the diagnostic output is preserved on failure.

test_grep requires the file it reads to exist, so '! grep'
assertions that inspect a file whose presence is conditional need
care.  In t5537 the '.git/shallow' file is still present after the
repack (the client remains shallow), so the assertion is
converted like any other.  In t1400 the '.git/packed-refs' file
exists only with the files backend, so its check is guarded with a
REFFILES prerequisite; the backend-agnostic 'git show-ref' check
that follows still runs under every backend.  In t7450 'git~2' is
the NTFS 8.3 short name of a decoy '..git' file and only exists
when 8.3 short-name generation is enabled; that '! grep' tolerates
the missing file on purpose, so it is left as-is with a
"# lint-ok" annotation rather than converted (a plain test_grep
would BUG when the short name is absent).

The conversion was generated using a grep-assertion linter
(greplint.pl, added in the following commit) to identify bare
grep calls at command position.  To reproduce, from the t/
directory:

    # Step 1: annotate the two data-filter greps (grep produces
    # data, not a verdict) so the linter skips them.
    sed -i '/grep -vf before commits\.raw/s/$/ # lint-ok: data filter/' \
        t5326-multi-pack-bitmaps.sh
    sed -i '/grep -E "^\[0-9a-f\].*|| :/s/$/ # lint-ok: data filter/' \
        t5702-protocol-v2.sh

    # Step 1b: two '! grep' assertions need more than a mechanical
    # conversion; handle them by hand before the linter-driven steps
    # below so it leaves them alone.
    #
    # t1400: '.git/packed-refs' is absent under reftable, so guard the
    # check with REFFILES (a plain test_grep would BUG on the missing
    # file):
    #
    #      git update-ref -d HEAD $B &&
    #  -   ! grep "$m" .git/packed-refs &&
    #  +   if test_have_prereq REFFILES
    #  +   then
    #  +           test_grep ! "$m" .git/packed-refs
    #  +   fi &&
    #      test_must_fail git show-ref --verify -q $m
    #
    # t7450: git~2 is an NTFS 8.3 short name that exists only when
    # short-name generation is enabled, so this stays a missing-file-
    # tolerant '! grep'; add a comment plus "# lint-ok" so the linter
    # skips it.

    # Step 2: reorder pre-existing '! test_grep' to 'test_grep !'
    # (must come before steps 3-4 so greplint does not see them)
    sed -i 's/! test_grep/test_grep !/' t0031-lockfile-pid.sh
    sed -i 's/! test_grep/test_grep !/' t5300-pack-object.sh
    sed -i 's/! test_grep/test_grep !/' t5319-multi-pack-index.sh

    # Step 3: convert '! grep' -> 'test_grep !'
    perl greplint.pl *.sh 2>&1 | cut -d: -f1,2 |
    while IFS=: read f l; do
        sed -i "${l}s/! *grep/test_grep !/" "$f"
    done

    # Step 4: convert remaining 'grep' -> 'test_grep'
    perl greplint.pl *.sh 2>&1 | cut -d: -f1,2 |
    while IFS=: read f l; do
        sed -i "${l}s/grep/test_grep/" "$f"
    done

To verify, run: make -C t test-greplint

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 t/for-each-ref-tests.sh                     |  12 +-
 t/lib-bitmap.sh                             |  12 +-
 t/lib-bundle-uri-protocol.sh                |  26 +-
 t/lib-httpd.sh                              |   2 +-
 t/pack-refs-tests.sh                        |   2 +-
 t/show-ref-exists-tests.sh                  |   2 +-
 t/t0000-basic.sh                            |  16 +-
 t/t0001-init.sh                             |  18 +-
 t/t0008-ignores.sh                          |   8 +-
 t/t0009-git-dir-validation.sh               |   6 +-
 t/t0012-help.sh                             |   4 +-
 t/t0013-sha1dc.sh                           |   2 +-
 t/t0017-env-helper.sh                       |   4 +-
 t/t0021-conversion.sh                       |  18 +-
 t/t0029-core-unsetenvvars.sh                |   4 +-
 t/t0030-stripspace.sh                       |   4 +-
 t/t0031-lockfile-pid.sh                     |   2 +-
 t/t0040-parse-options.sh                    |  52 +--
 t/t0041-usage.sh                            |   2 +-
 t/t0052-simple-ipc.sh                       |  10 +-
 t/t0061-run-command.sh                      |   2 +-
 t/t0066-dir-iterator.sh                     |   2 +-
 t/t0068-for-each-repo.sh                    |  16 +-
 t/t0070-fundamental.sh                      |   6 +-
 t/t0081-find-pack.sh                        |  12 +-
 t/t0091-bugreport.sh                        |  18 +-
 t/t0092-diagnose.sh                         |  12 +-
 t/t0100-previous.sh                         |   2 +-
 t/t0200-gettext-basic.sh                    |  14 +-
 t/t0203-gettext-setlocale-sanity.sh         |   4 +-
 t/t0204-gettext-reencode-sanity.sh          |   8 +-
 t/t0210-trace2-normal.sh                    |   6 +-
 t/t0211-trace2-perf.sh                      |  80 ++---
 t/t0212-trace2-event.sh                     |   8 +-
 t/t0300-credentials.sh                      |   4 +-
 t/t0410-partial-clone.sh                    |  82 ++---
 t/t0450-txt-doc-vs-help.sh                  |   2 +-
 t/t0500-progress-display.sh                 |  18 +-
 t/t0610-reftable-basics.sh                  |   8 +-
 t/t1004-read-tree-m-u-wf.sh                 |   8 +-
 t/t1006-cat-file.sh                         |  18 +-
 t/t1007-hash-object.sh                      |   8 +-
 t/t1011-read-tree-sparse-checkout.sh        |  10 +-
 t/t1050-large.sh                            |   6 +-
 t/t1091-sparse-checkout-builtin.sh          |  24 +-
 t/t1092-sparse-checkout-compatibility.sh    |  44 +--
 t/t1300-config.sh                           |  16 +-
 t/t1305-config-include.sh                   |   2 +-
 t/t1308-config-set.sh                       |   6 +-
 t/t1400-update-ref.sh                       | 173 +++++-----
 t/t1403-show-ref.sh                         |  18 +-
 t/t1410-reflog.sh                           |   4 +-
 t/t1415-worktree-refs.sh                    |   4 +-
 t/t1430-bad-ref-name.sh                     |  56 ++--
 t/t1450-fsck.sh                             |  12 +-
 t/t1451-fsck-buffer.sh                      |   6 +-
 t/t1460-refs-migrate.sh                     |   2 +-
 t/t1500-rev-parse.sh                        |   6 +-
 t/t1502-rev-parse-parseopt.sh               |   2 +-
 t/t1503-rev-parse-verify.sh                 |  10 +-
 t/t1510-repo-setup.sh                       |  10 +-
 t/t1512-rev-parse-disambiguation.sh         |   4 +-
 t/t1515-rev-parse-outside-repo.sh           |   2 +-
 t/t1800-hook.sh                             |  18 +-
 t/t2004-checkout-cache-temp.sh              |   4 +-
 t/t2019-checkout-ambiguous-ref.sh           |   4 +-
 t/t2024-checkout-dwim.sh                    |   8 +-
 t/t2030-unresolve-info.sh                   |   6 +-
 t/t2060-switch.sh                           |   6 +-
 t/t2070-restore.sh                          |   2 +-
 t/t2080-parallel-checkout-basics.sh         |  14 +-
 t/t2081-parallel-checkout-collisions.sh     |  24 +-
 t/t2082-parallel-checkout-attributes.sh     |  12 +-
 t/t2103-update-index-ignore-missing.sh      |   6 +-
 t/t2200-add-update.sh                       |   2 +-
 t/t2203-add-intent.sh                       |   6 +-
 t/t2400-worktree-add.sh                     |  24 +-
 t/t2402-worktree-list.sh                    |  16 +-
 t/t2403-worktree-move.sh                    |   6 +-
 t/t2405-worktree-submodule.sh               |   6 +-
 t/t2407-worktree-heads.sh                   |  26 +-
 t/t2500-untracked-overwriting.sh            |   8 +-
 t/t2501-cwd-empty.sh                        |   4 +-
 t/t3001-ls-files-others-exclude.sh          |   6 +-
 t/t3007-ls-files-recurse-submodules.sh      |   6 +-
 t/t3200-branch.sh                           |  12 +-
 t/t3202-show-branch.sh                      |  10 +-
 t/t3203-branch-output.sh                    |   4 +-
 t/t3206-range-diff.sh                       |  78 ++---
 t/t3207-branch-submodule.sh                 |   4 +-
 t/t3301-notes.sh                            |  32 +-
 t/t3310-notes-merge-manual-resolve.sh       |  16 +-
 t/t3320-notes-merge-worktrees.sh            |   2 +-
 t/t3400-rebase.sh                           |  16 +-
 t/t3402-rebase-merge.sh                     |  16 +-
 t/t3404-rebase-interactive.sh               |  72 ++--
 t/t3406-rebase-message.sh                   |   6 +-
 t/t3415-rebase-autosquash.sh                |  10 +-
 t/t3416-rebase-onto-threedots.sh            |   4 +-
 t/t3418-rebase-continue.sh                  |  10 +-
 t/t3420-rebase-autostash.sh                 |  24 +-
 t/t3422-rebase-incompatible-options.sh      |   4 +-
 t/t3429-rebase-edit-todo.sh                 |   2 +-
 t/t3430-rebase-merges.sh                    |  32 +-
 t/t3500-cherry.sh                           |   4 +-
 t/t3501-revert-cherry-pick.sh               |   6 +-
 t/t3504-cherry-pick-rerere.sh               |   6 +-
 t/t3510-cherry-pick-sequence.sh             |  24 +-
 t/t3602-rm-sparse-checkout.sh               |   4 +-
 t/t3705-add-sparse-checkout.sh              |  10 +-
 t/t3800-mktag.sh                            |   4 +-
 t/t3901-i18n-patch.sh                       |  16 +-
 t/t3903-stash.sh                            |  28 +-
 t/t3904-stash-patch.sh                      |   4 +-
 t/t3908-stash-in-worktree.sh                |   2 +-
 t/t4000-diff-format.sh                      |   2 +-
 t/t4001-diff-rename.sh                      |   4 +-
 t/t4011-diff-symlink.sh                     |   2 +-
 t/t4013-diff-various.sh                     |   2 +-
 t/t4014-format-patch.sh                     | 344 ++++++++++----------
 t/t4015-diff-whitespace.sh                  |  16 +-
 t/t4017-diff-retval.sh                      |   2 +-
 t/t4018-diff-funcname.sh                    |   2 +-
 t/t4019-diff-wserror.sh                     |   8 +-
 t/t4020-diff-external.sh                    |  18 +-
 t/t4021-format-patch-numbered.sh            |   4 +-
 t/t4022-diff-rewrite.sh                     |  14 +-
 t/t4028-format-patch-mime-headers.sh        |   6 +-
 t/t4031-diff-rewrite-binary.sh              |  18 +-
 t/t4033-diff-patience.sh                    |   2 +-
 t/t4036-format-patch-signer-mime.sh         |   6 +-
 t/t4038-diff-combined.sh                    |   6 +-
 t/t4051-diff-function-context.sh            |  38 +--
 t/t4053-diff-no-index.sh                    |   4 +-
 t/t4063-diff-blobs.sh                       |   2 +-
 t/t4065-diff-anchored.sh                    |  26 +-
 t/t4067-diff-partial-clone.sh               |  12 +-
 t/t4073-diff-stat-name-width.sh             |  24 +-
 t/t4103-apply-binary.sh                     |   2 +-
 t/t4120-apply-popt.sh                       |   2 +-
 t/t4124-apply-ws-rule.sh                    |  10 +-
 t/t4128-apply-root.sh                       |   2 +-
 t/t4140-apply-ita.sh                        |   4 +-
 t/t4141-apply-too-large.sh                  |   2 +-
 t/t4150-am.sh                               |  48 +--
 t/t4200-rerere.sh                           |   6 +-
 t/t4201-shortlog.sh                         |   2 +-
 t/t4202-log.sh                              |  84 ++---
 t/t4204-patch-id.sh                         |   2 +-
 t/t4205-log-pretty-formats.sh               |   2 +-
 t/t4209-log-pickaxe.sh                      |  10 +-
 t/t4211-line-log.sh                         |  72 ++--
 t/t4216-log-bloom.sh                        |  18 +-
 t/t4252-am-options.sh                       |  22 +-
 t/t4254-am-corrupt.sh                       |   6 +-
 t/t4258-am-quoted-cr.sh                     |   2 +-
 t/t4301-merge-tree-write-tree.sh            |  18 +-
 t/t5000-tar-tree.sh                         |  10 +-
 t/t5004-archive-corner-cases.sh             |   2 +-
 t/t5100-mailinfo.sh                         |   2 +-
 t/t5150-request-pull.sh                     |  18 +-
 t/t5300-pack-object.sh                      |  22 +-
 t/t5302-pack-index.sh                       |   6 +-
 t/t5304-prune.sh                            |   8 +-
 t/t5310-pack-bitmaps.sh                     |  14 +-
 t/t5317-pack-objects-filter-objects.sh      |  12 +-
 t/t5318-commit-graph.sh                     |   8 +-
 t/t5319-multi-pack-index.sh                 |  16 +-
 t/t5324-split-commit-graph.sh               |  10 +-
 t/t5325-reverse-index.sh                    |   2 +-
 t/t5326-multi-pack-bitmaps.sh               |  28 +-
 t/t5328-commit-graph-64bit-time.sh          |   2 +-
 t/t5329-pack-objects-cruft.sh               |   8 +-
 t/t5334-incremental-multi-pack-index.sh     |   2 +-
 t/t5335-compact-multi-pack-index.sh         |   4 +-
 t/t5351-unpack-large-objects.sh             |   2 +-
 t/t5402-post-merge-hook.sh                  |   4 +-
 t/t5403-post-checkout-hook.sh               |   2 +-
 t/t5404-tracking-branches.sh                |   2 +-
 t/t5406-remote-rejects.sh                   |   2 +-
 t/t5407-post-rewrite-hook.sh                |   8 +-
 t/t5409-colorize-remote-messages.sh         |  36 +-
 t/t5500-fetch-pack.sh                       |  38 +--
 t/t5504-fetch-receive-strict.sh             |  14 +-
 t/t5505-remote.sh                           |  20 +-
 t/t5510-fetch.sh                            |  10 +-
 t/t5512-ls-remote.sh                        |   8 +-
 t/t5514-fetch-multiple.sh                   |   2 +-
 t/t5516-fetch-push.sh                       |  20 +-
 t/t5520-pull.sh                             |   4 +-
 t/t5524-pull-msg.sh                         |   6 +-
 t/t5526-fetch-submodules.sh                 |  16 +-
 t/t5529-push-errors.sh                      |   4 +-
 t/t5530-upload-pack-error.sh                |  18 +-
 t/t5531-deep-submodule-push.sh              |   2 +-
 t/t5532-fetch-proxy.sh                      |   2 +-
 t/t5533-push-cas.sh                         |  12 +-
 t/t5534-push-signed.sh                      |  22 +-
 t/t5537-fetch-shallow.sh                    |   2 +-
 t/t5538-push-shallow.sh                     |   2 +-
 t/t5539-fetch-http-shallow.sh               |   4 +-
 t/t5541-http-push-smart.sh                  |  32 +-
 t/t5544-pack-objects-hook.sh                |  12 +-
 t/t5550-http-fetch-dumb.sh                  |   4 +-
 t/t5551-http-fetch-smart.sh                 |  46 +--
 t/t5552-skipping-fetch-negotiator.sh        |   6 +-
 t/t5554-noop-fetch-negotiator.sh            |   4 +-
 t/t5557-http-get.sh                         |   2 +-
 t/t5558-clone-bundle-uri.sh                 |  38 +--
 t/t5562-http-backend-content-length.sh      |   2 +-
 t/t5564-http-proxy.sh                       |  10 +-
 t/t5581-http-curl-verbose.sh                |   2 +-
 t/t5583-push-branches.sh                    |   8 +-
 t/t5601-clone.sh                            |  28 +-
 t/t5604-clone-reference.sh                  |   8 +-
 t/t5605-clone-local.sh                      |   2 +-
 t/t5606-clone-options.sh                    |   6 +-
 t/t5612-clone-refspec.sh                    |   2 +-
 t/t5616-partial-clone.sh                    |  60 ++--
 t/t5619-clone-local-ambiguous-transport.sh  |   2 +-
 t/t5620-backfill.sh                         |  12 +-
 t/t5700-protocol-v1.sh                      |  46 +--
 t/t5701-git-serve.sh                        |  14 +-
 t/t5702-protocol-v2.sh                      | 154 ++++-----
 t/t5703-upload-pack-ref-in-want.sh          |  22 +-
 t/t5705-session-id-in-capabilities.sh       |  12 +-
 t/t5750-bundle-uri-parse.sh                 |   8 +-
 t/t5801-remote-helpers.sh                   |   4 +-
 t/t5810-proto-disable-local.sh              |   2 +-
 t/t5813-proto-disable-ssh.sh                |   4 +-
 t/t6000-rev-list-misc.sh                    |  26 +-
 t/t6005-rev-list-count.sh                   |   8 +-
 t/t6006-rev-list-format.sh                  |   4 +-
 t/t6009-rev-list-parent.sh                  |   4 +-
 t/t6020-bundle-misc.sh                      |  12 +-
 t/t6022-rev-list-missing.sh                 |   4 +-
 t/t6030-bisect-porcelain.sh                 | 150 ++++-----
 t/t6040-tracking-info.sh                    |   2 +-
 t/t6112-rev-list-filters-objects.sh         |  24 +-
 t/t6115-rev-list-du.sh                      |   4 +-
 t/t6120-describe.sh                         |  14 +-
 t/t6200-fmt-merge-msg.sh                    |  82 ++---
 t/t6402-merge-rename.sh                     |   4 +-
 t/t6403-merge-file.sh                       |   6 +-
 t/t6404-recursive-merge.sh                  |   2 +-
 t/t6406-merge-attr.sh                       |  20 +-
 t/t6417-merge-ours-theirs.sh                |  30 +-
 t/t6418-merge-text-auto.sh                  |   2 +-
 t/t6422-merge-rename-corner-cases.sh        |   8 +-
 t/t6423-merge-rename-directories.sh         |  72 ++--
 t/t6424-merge-unrelated-index-changes.sh    |   6 +-
 t/t6427-diff3-conflict-markers.sh           |  10 +-
 t/t6432-merge-recursive-space-options.sh    |   4 +-
 t/t6436-merge-overwrite.sh                  |   6 +-
 t/t6437-submodule-merge.sh                  |  10 +-
 t/t6500-gc.sh                               |   8 +-
 t/t6600-test-reach.sh                       |   4 +-
 t/t7001-mv.sh                               |  16 +-
 t/t7002-mv-sparse-checkout.sh               |  38 +--
 t/t7003-filter-branch.sh                    |  16 +-
 t/t7004-tag.sh                              |   2 +-
 t/t7006-pager.sh                            |  16 +-
 t/t7012-skip-worktree-writing.sh            |   6 +-
 t/t7030-verify-tag.sh                       |  52 +--
 t/t7031-verify-tag-signed-ssh.sh            |  46 +--
 t/t7102-reset.sh                            |   2 +-
 t/t7110-reset-merge.sh                      |  40 +--
 t/t7201-co.sh                               |   6 +-
 t/t7300-clean.sh                            |   2 +-
 t/t7301-clean-interactive.sh                |   2 +-
 t/t7400-submodule-basic.sh                  |  32 +-
 t/t7402-submodule-rebase.sh                 |   2 +-
 t/t7406-submodule-update.sh                 |  26 +-
 t/t7416-submodule-dash-url.sh               |  20 +-
 t/t7417-submodule-path-url.sh               |   2 +-
 t/t7450-bad-git-dotfiles.sh                 |  18 +-
 t/t7501-commit-basic-functionality.sh       |  16 +-
 t/t7502-commit-porcelain.sh                 |   2 +-
 t/t7507-commit-verbose.sh                   |   6 +-
 t/t7508-status.sh                           |   6 +-
 t/t7510-signed-commit.sh                    |  68 ++--
 t/t7516-commit-races.sh                     |   4 +-
 t/t7519-status-fsmonitor.sh                 |  14 +-
 t/t7527-builtin-fsmonitor.sh                |  82 ++---
 t/t7528-signed-commit-ssh.sh                |  68 ++--
 t/t7600-merge.sh                            |  10 +-
 t/t7603-merge-reduce-heads.sh               |  20 +-
 t/t7606-merge-custom.sh                     |   2 +-
 t/t7607-merge-state.sh                      |   4 +-
 t/t7610-mergetool.sh                        |  18 +-
 t/t7700-repack.sh                           |  14 +-
 t/t7703-repack-geometric.sh                 |   4 +-
 t/t7704-repack-cruft.sh                     |  12 +-
 t/t7800-difftool.sh                         |  26 +-
 t/t7810-grep.sh                             |  22 +-
 t/t7814-grep-recurse-submodules.sh          |   2 +-
 t/t7900-maintenance.sh                      |  34 +-
 t/t8008-blame-formats.sh                    |   2 +-
 t/t8010-cat-file-filters.sh                 |   2 +-
 t/t8012-blame-colors.sh                     |   2 +-
 t/t9001-send-email.sh                       | 190 +++++------
 t/t9003-help-autocorrect.sh                 |   6 +-
 t/t9106-git-svn-commit-diff-clobber.sh      |   2 +-
 t/t9107-git-svn-migrate.sh                  |  30 +-
 t/t9110-git-svn-use-svm-props.sh            |  20 +-
 t/t9111-git-svn-use-svnsync-props.sh        |  18 +-
 t/t9114-git-svn-dcommit-merge.sh            |   6 +-
 t/t9116-git-svn-log.sh                      |   8 +-
 t/t9117-git-svn-init-clone.sh               |  12 +-
 t/t9119-git-svn-info.sh                     |  16 +-
 t/t9122-git-svn-author.sh                   |   8 +-
 t/t9130-git-svn-authors-file.sh             |   8 +-
 t/t9138-git-svn-authors-prog.sh             |  14 +-
 t/t9140-git-svn-reset.sh                    |   4 +-
 t/t9153-git-svn-rewrite-uuid.sh             |   4 +-
 t/t9200-git-cvsexportcommit.sh              |   2 +-
 t/t9210-scalar.sh                           |  34 +-
 t/t9211-scalar-clone.sh                     |  16 +-
 t/t9300-fast-import.sh                      |  10 +-
 t/t9350-fast-export.sh                      |  54 +--
 t/t9351-fast-export-anonymize.sh            |  36 +-
 t/t9400-git-cvsserver-server.sh             |   4 +-
 t/t9501-gitweb-standalone-http-status.sh    |  58 ++--
 t/t9502-gitweb-standalone-parse-output.sh   |  38 +--
 t/t9800-git-p4-basic.sh                     |  10 +-
 t/t9801-git-p4-branch.sh                    |  48 +--
 t/t9806-git-p4-options.sh                   |  10 +-
 t/t9807-git-p4-submit.sh                    |   2 +-
 t/t9810-git-p4-rcs.sh                       |   8 +-
 t/t9813-git-p4-preserve-users.sh            |   8 +-
 t/t9814-git-p4-rename.sh                    |   8 +-
 t/t9827-git-p4-change-filetype.sh           |   4 +-
 t/t9832-unshelve.sh                         |   6 +-
 t/t9833-errors.sh                           |   4 +-
 t/t9835-git-p4-metadata-encoding-python2.sh |  36 +-
 t/t9836-git-p4-metadata-encoding-python3.sh |  38 +--
 t/t9850-shell.sh                            |   2 +-
 t/t9902-completion.sh                       |  26 +-
 338 files changed, 2813 insertions(+), 2806 deletions(-)

diff --git a/t/for-each-ref-tests.sh b/t/for-each-ref-tests.sh
index bd2d45c971..6b359d940e 100644
--- a/t/for-each-ref-tests.sh
+++ b/t/for-each-ref-tests.sh
@@ -523,7 +523,7 @@ test_expect_success 'Verify descending sort' '
 
 test_expect_success 'Give help even with invalid sort atoms' '
 	test_expect_code 129 ${git_for_each_ref} --sort=bogus -h >actual 2>&1 &&
-	grep "^usage: ${git_for_each_ref}" actual
+	test_grep "^usage: ${git_for_each_ref}" actual
 '
 
 cat >expected <<\EOF
@@ -622,7 +622,7 @@ test_expect_success 'Quoting style: tcl' '
 for i in "--perl --shell" "-s --python" "--python --tcl" "--tcl --perl"; do
 	test_expect_success "more than one quoting style: $i" "
 		test_must_fail ${git_for_each_ref} $i 2>err &&
-		grep '^error: more than one quoting style' err
+		test_grep '^error: more than one quoting style' err
 	"
 done
 
@@ -1892,7 +1892,7 @@ test_expect_success "${git_for_each_ref} --stdin: fails if extra args" '
 	>in &&
 	test_must_fail ${git_for_each_ref} --format="%(refname)" \
 		--stdin refs/heads/extra <in 2>err &&
-	grep "unknown arguments supplied with --stdin" err
+	test_grep "unknown arguments supplied with --stdin" err
 '
 
 test_expect_success "${git_for_each_ref} --stdin: matches" '
@@ -1955,11 +1955,11 @@ test_expect_success "${git_for_each_ref} with nested tags" '
 
 test_expect_success 'is-base atom with non-commits' '
 	${git_for_each_ref} --format="%(is-base:HEAD) %(refname)" >out 2>err &&
-	grep "(HEAD) refs/heads/main" out &&
+	test_grep "(HEAD) refs/heads/main" out &&
 
 	test_line_count = 2 err &&
-	grep "error: object .* is a commit, not a blob" err &&
-	grep "error: bad tag pointer to" err
+	test_grep "error: object .* is a commit, not a blob" err &&
+	test_grep "error: bad tag pointer to" err
 '
 
 GRADE_FORMAT="%(signature:grade)%0a%(signature:key)%0a%(signature:signer)%0a%(signature:fingerprint)%0a%(signature:primarykeyfingerprint)"
diff --git a/t/lib-bitmap.sh b/t/lib-bitmap.sh
index 62aa6744a6..2de6646128 100644
--- a/t/lib-bitmap.sh
+++ b/t/lib-bitmap.sh
@@ -173,7 +173,7 @@ rev_list_tests_head () {
 
 	test_expect_success "bitmap --objects handles non-commit objects ($state, $branch)" '
 		git rev-list --objects --use-bitmap-index $branch tagged-blob >actual &&
-		grep $blob actual
+		test_grep $blob actual
 	'
 }
 
@@ -242,16 +242,16 @@ basic_bitmap_tests () {
 		GIT_PROGRESS_DELAY=0 \
 			git pack-objects --all --stdout --progress \
 			</dev/null >/dev/null 2>stderr &&
-		grep "Enumerating objects: $count, done" stderr &&
-		grep "pack-reused $count" stderr &&
+		test_grep "Enumerating objects: $count, done" stderr &&
+		test_grep "pack-reused $count" stderr &&
 
 		# now the same but with one non-reused object
 		git commit --allow-empty -m "an extra commit object" &&
 		GIT_PROGRESS_DELAY=0 \
 			git pack-objects --all --stdout --progress \
 			</dev/null >/dev/null 2>stderr &&
-		grep "Enumerating objects: $((count+1)), done" stderr &&
-		grep "pack-reused $count" stderr
+		test_grep "Enumerating objects: $((count+1)), done" stderr &&
+		test_grep "pack-reused $count" stderr
 	'
 }
 
@@ -283,7 +283,7 @@ test_rev_exists () {
 		then
 			test_path_is_file $midx-$(midx_checksum $objdir).rev
 		fi &&
-		grep "\"category\":\"load_midx_revindex\",\"key\":\"source\",\"value\":\"$kind\"" event.trace
+		test_grep "\"category\":\"load_midx_revindex\",\"key\":\"source\",\"value\":\"$kind\"" event.trace
 	'
 }
 
diff --git a/t/lib-bundle-uri-protocol.sh b/t/lib-bundle-uri-protocol.sh
index de09b6b02e..ecf3284297 100644
--- a/t/lib-bundle-uri-protocol.sh
+++ b/t/lib-bundle-uri-protocol.sh
@@ -63,9 +63,9 @@ test_expect_success "connect with $BUNDLE_URI_PROTOCOL:// using protocol v2: no
 		>actual 2>err &&
 
 	# Server responded using protocol v2
-	grep "< version 2" log &&
+	test_grep "< version 2" log &&
 
-	! grep bundle-uri log
+	test_grep ! bundle-uri log
 '
 
 test_expect_success "connect with $BUNDLE_URI_PROTOCOL:// using protocol v2: have bundle-uri" '
@@ -78,10 +78,10 @@ test_expect_success "connect with $BUNDLE_URI_PROTOCOL:// using protocol v2: hav
 		>actual 2>err &&
 
 	# Server responded using protocol v2
-	grep "< version 2" log &&
+	test_grep "< version 2" log &&
 
 	# Server advertised bundle-uri capability
-	grep "< bundle-uri" log
+	test_grep "< bundle-uri" log
 '
 
 test_expect_success "clone with $BUNDLE_URI_PROTOCOL:// using protocol v2: request bundle-uris" '
@@ -95,13 +95,13 @@ test_expect_success "clone with $BUNDLE_URI_PROTOCOL:// using protocol v2: reque
 		>actual 2>err &&
 
 	# Server responded using protocol v2
-	grep "< version 2" log &&
+	test_grep "< version 2" log &&
 
 	# Server advertised bundle-uri capability
-	grep "< bundle-uri" log &&
+	test_grep "< bundle-uri" log &&
 
 	# Client did not issue bundle-uri command
-	! grep "> command=bundle-uri" log &&
+	test_grep ! "> command=bundle-uri" log &&
 
 	GIT_TRACE_PACKET="$PWD/log" \
 	git \
@@ -111,13 +111,13 @@ test_expect_success "clone with $BUNDLE_URI_PROTOCOL:// using protocol v2: reque
 		>actual 2>err &&
 
 	# Server responded using protocol v2
-	grep "< version 2" log &&
+	test_grep "< version 2" log &&
 
 	# Server advertised bundle-uri capability
-	grep "< bundle-uri" log &&
+	test_grep "< bundle-uri" log &&
 
 	# Client issued bundle-uri command
-	grep "> command=bundle-uri" log &&
+	test_grep "> command=bundle-uri" log &&
 
 	GIT_TRACE_PACKET="$PWD/log3" \
 	git \
@@ -128,13 +128,13 @@ test_expect_success "clone with $BUNDLE_URI_PROTOCOL:// using protocol v2: reque
 		>actual 2>err &&
 
 	# Server responded using protocol v2
-	grep "< version 2" log3 &&
+	test_grep "< version 2" log3 &&
 
 	# Server advertised bundle-uri capability
-	grep "< bundle-uri" log3 &&
+	test_grep "< bundle-uri" log3 &&
 
 	# Client did not issue bundle-uri command (--bundle-uri override)
-	! grep "> command=bundle-uri" log3
+	test_grep ! "> command=bundle-uri" log3
 '
 
 # The remaining tests will all assume transfer.bundleURI=true
diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index fc646447d5..a216e5376f 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -275,7 +275,7 @@ test_http_push_nonff () {
 	'
 
 	test_expect_success 'non-fast-forward push show ref status' '
-		grep "^ ! \[rejected\][ ]*$BRANCH -> $BRANCH (non-fast-forward)$" output
+		test_grep "^ ! \[rejected\][ ]*$BRANCH -> $BRANCH (non-fast-forward)$" output
 	'
 
 	test_expect_success 'non-fast-forward push shows help message' '
diff --git a/t/pack-refs-tests.sh b/t/pack-refs-tests.sh
index d76b087b09..a800177446 100644
--- a/t/pack-refs-tests.sh
+++ b/t/pack-refs-tests.sh
@@ -195,7 +195,7 @@ test_expect_success 'delete ref while another dangling packed ref' '
 test_expect_success 'pack ref directly below refs/' '
 	git update-ref refs/top HEAD &&
 	git ${pack_refs} --all --prune &&
-	grep refs/top .git/packed-refs &&
+	test_grep refs/top .git/packed-refs &&
 	test_path_is_missing .git/refs/top
 '
 
diff --git a/t/show-ref-exists-tests.sh b/t/show-ref-exists-tests.sh
index 36e8e9df33..1351f690eb 100644
--- a/t/show-ref-exists-tests.sh
+++ b/t/show-ref-exists-tests.sh
@@ -19,7 +19,7 @@ test_expect_success '--exists with missing reference' '
 
 test_expect_success '--exists does not use DWIM' '
 	test_expect_code 2 ${git_show_ref_exists} $GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME 2>err &&
-	grep "reference does not exist" err
+	test_grep "reference does not exist" err
 '
 
 test_expect_success '--exists with HEAD' '
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 2b63e1c86c..7bd1f4e7b7 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -743,7 +743,7 @@ test_expect_success 'subtest: lazy prereqs do not turn off tracing' '
 	test_done
 	EOF
 
-	grep "echo trace" lazy-prereq-and-tracing/err
+	test_grep "echo trace" lazy-prereq-and-tracing/err
 '
 
 test_expect_success 'subtest: tests clean up after themselves' '
@@ -815,7 +815,7 @@ test_expect_success 'subtest: test_atexit is run' '
 
 test_expect_success 'test_oid provides sane info by default' '
 	test_oid zero >actual &&
-	grep "^00*\$" actual &&
+	test_grep "^00*\$" actual &&
 	rawsz="$(test_oid rawsz)" &&
 	hexsz="$(test_oid hexsz)" &&
 	# +1 accounts for the trailing newline
@@ -827,7 +827,7 @@ test_expect_success 'test_oid can look up data for SHA-1' '
 	test_when_finished "test_detect_hash" &&
 	test_set_hash sha1 &&
 	test_oid zero >actual &&
-	grep "^00*\$" actual &&
+	test_grep "^00*\$" actual &&
 	rawsz="$(test_oid rawsz)" &&
 	hexsz="$(test_oid hexsz)" &&
 	test $(wc -c <actual) -eq 41 &&
@@ -839,7 +839,7 @@ test_expect_success 'test_oid can look up data for SHA-256' '
 	test_when_finished "test_detect_hash" &&
 	test_set_hash sha256 &&
 	test_oid zero >actual &&
-	grep "^00*\$" actual &&
+	test_grep "^00*\$" actual &&
 	rawsz="$(test_oid rawsz)" &&
 	hexsz="$(test_oid hexsz)" &&
 	test $(wc -c <actual) -eq 65 &&
@@ -884,11 +884,11 @@ test_expect_success 'test_bool_env' '
 		# test script, hence the redirection of fd 7, and aborts
 		# with "exit 1", hence the subshell.
 		! ( test_bool_env envvar true ) 7>err &&
-		grep "error: test_bool_env requires bool values" err &&
+		test_grep "error: test_bool_env requires bool values" err &&
 
 		envvar=true &&
 		! ( test_bool_env envvar invalid ) 7>err &&
-		grep "error: test_bool_env requires bool values" err
+		test_grep "error: test_bool_env requires bool values" err
 	)
 '
 
@@ -1242,12 +1242,12 @@ test_expect_success 'test_must_fail on a failing git command with env' '
 
 test_expect_success 'test_must_fail rejects a non-git command' '
 	! test_must_fail grep ^$ notafile 2>err &&
-	grep -F "test_must_fail: only '"'"'git'"'"' is allowed" err
+	test_grep -F "test_must_fail: only '"'"'git'"'"' is allowed" err
 '
 
 test_expect_success 'test_must_fail rejects a non-git command with env' '
 	! test_must_fail env var1=a var2=b grep ^$ notafile 2>err &&
-	grep -F "test_must_fail: only '"'"'git'"'"' is allowed" err
+	test_grep -F "test_must_fail: only '"'"'git'"'"' is allowed" err
 '
 
 test_done
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index e89feca544..5cf2e5a35a 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -278,9 +278,9 @@ test_expect_success POSIXPERM 'init creates a new deep directory (umask vs. shar
 		git init --bare --shared=0660 newdir/a/b/c &&
 		test_path_is_dir newdir/a/b/c/refs &&
 		ls -ld newdir/a newdir/a/b > lsab.out &&
-		! grep -v "^drwxrw[sx]r-x" lsab.out &&
+		test_grep ! -v "^drwxrw[sx]r-x" lsab.out &&
 		ls -ld newdir/a/b/c > lsc.out &&
-		! grep -v "^drwxrw[sx]---" lsc.out
+		test_grep ! -v "^drwxrw[sx]---" lsc.out
 	)
 '
 
@@ -619,7 +619,7 @@ test_expect_success DEFAULT_REPO_FORMAT 'extensions.refStorage is not allowed wi
 	git init refstorage &&
 	git -C refstorage config extensions.refStorage files &&
 	test_must_fail git -C refstorage rev-parse 2>err &&
-	grep "repo version is 0, but v1-only extension found" err
+	test_grep "repo version is 0, but v1-only extension found" err
 '
 
 test_expect_success DEFAULT_REPO_FORMAT 'extensions.refStorage with files backend' '
@@ -637,7 +637,7 @@ test_expect_success DEFAULT_REPO_FORMAT 'extensions.refStorage with unknown back
 	git -C refstorage config core.repositoryformatversion 1 &&
 	git -C refstorage config extensions.refStorage garbage &&
 	test_must_fail git -C refstorage rev-parse 2>err &&
-	grep "invalid value for ${SQ}extensions.refstorage${SQ}: ${SQ}garbage${SQ}" err
+	test_grep "invalid value for ${SQ}extensions.refstorage${SQ}: ${SQ}garbage${SQ}" err
 '
 
 test_expect_success 'init with GIT_DEFAULT_REF_FORMAT=garbage' '
@@ -848,8 +848,8 @@ test_expect_success MINGW 'redirect std handles' '
 		GIT_REDIRECT_STDOUT=output.txt \
 		GIT_REDIRECT_STDERR="2>&1" \
 		git rev-parse --git-dir --verify refs/invalid &&
-	grep "^\\.git\$" output.txt &&
-	grep "Needed a single revision" output.txt
+	test_grep "^\\.git\$" output.txt &&
+	test_grep "Needed a single revision" output.txt
 '
 
 test_expect_success '--initial-branch' '
@@ -862,14 +862,14 @@ test_expect_success '--initial-branch' '
 	git init --initial-branch=ignore initial-branch-option 2>err &&
 	test_grep "ignored --initial-branch" err &&
 	git -C initial-branch-option symbolic-ref HEAD >actual &&
-	grep hello actual
+	test_grep hello actual
 '
 
 test_expect_success 'overridden default initial branch name (config)' '
 	test_config_global init.defaultBranch nmb &&
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= git init initial-branch-config &&
 	git -C initial-branch-config symbolic-ref HEAD >actual &&
-	grep nmb actual
+	test_grep nmb actual
 '
 
 test_expect_success 'advice on unconfigured init.defaultBranch' '
@@ -907,7 +907,7 @@ test_expect_success 'overridden default main branch name (env)' '
 	test_config_global init.defaultBranch nmb &&
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=env git init main-branch-env &&
 	git -C main-branch-env symbolic-ref HEAD >actual &&
-	grep env actual
+	test_grep env actual
 '
 
 test_expect_success 'invalid default branch name' '
diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index d77a179bdd..ed95faf327 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -790,8 +790,8 @@ test_expect_success 'existing file and directory' '
 	>one &&
 	mkdir top-level-dir &&
 	git check-ignore one top-level-dir >actual &&
-	grep one actual &&
-	grep top-level-dir actual
+	test_grep one actual &&
+	test_grep top-level-dir actual
 '
 
 test_expect_success 'existing directory and file' '
@@ -800,8 +800,8 @@ test_expect_success 'existing directory and file' '
 	>one &&
 	mkdir top-level-dir &&
 	git check-ignore top-level-dir one >actual &&
-	grep one actual &&
-	grep top-level-dir actual
+	test_grep one actual &&
+	test_grep top-level-dir actual
 '
 
 test_expect_success 'exact prefix matching (with root)' '
diff --git a/t/t0009-git-dir-validation.sh b/t/t0009-git-dir-validation.sh
index 33d21ed9ea..4cba478e50 100755
--- a/t/t0009-git-dir-validation.sh
+++ b/t/t0009-git-dir-validation.sh
@@ -35,7 +35,7 @@ test_expect_success PIPE 'setup: .git as a FIFO (named pipe) is rejected' '
 		cd parent/fifo-trap &&
 		mkfifo .git &&
 		test_must_fail git rev-parse --git-dir 2>stderr &&
-		grep "not a regular file" stderr
+		test_grep "not a regular file" stderr
 	)
 '
 
@@ -47,7 +47,7 @@ test_expect_success SYMLINKS,PIPE 'setup: .git as a symlink to a FIFO is rejecte
 		mkfifo target-fifo &&
 		ln -s target-fifo .git &&
 		test_must_fail git rev-parse --git-dir 2>stderr &&
-		grep "not a regular file" stderr
+		test_grep "not a regular file" stderr
 	)
 '
 
@@ -58,7 +58,7 @@ test_expect_success 'setup: .git with garbage content is rejected' '
 		cd parent/garbage-trap &&
 		echo "garbage" >.git &&
 		test_must_fail git rev-parse --git-dir 2>stderr &&
-		grep "invalid gitfile format" stderr
+		test_grep "invalid gitfile format" stderr
 	)
 '
 
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index c33501bdcd..48d128ad04 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -131,8 +131,8 @@ test_expect_success 'git help succeeds without git.html' '
 
 test_expect_success 'git help --user-interfaces' '
 	git help --user-interfaces >help.output &&
-	grep "^   attributes   " help.output &&
-	grep "^   mailmap   " help.output
+	test_grep "^   attributes   " help.output &&
+	test_grep "^   mailmap   " help.output
 '
 
 test_expect_success 'git help -c' '
diff --git a/t/t0013-sha1dc.sh b/t/t0013-sha1dc.sh
index ce3d81227a..3ea3169d92 100755
--- a/t/t0013-sha1dc.sh
+++ b/t/t0013-sha1dc.sh
@@ -16,7 +16,7 @@ fi
 test_expect_success 'test-sha1 detects shattered pdf' '
 	test_must_fail test-tool sha1 <"$TEST_DATA/shattered-1.pdf" 2>err &&
 	test_grep collision err &&
-	grep 38762cf7f55934b34d179ae6a4c80cadccbb7f0a err
+	test_grep 38762cf7f55934b34d179ae6a4c80cadccbb7f0a err
 '
 
 test_done
diff --git a/t/t0017-env-helper.sh b/t/t0017-env-helper.sh
index 32fe848179..da02bce0ef 100755
--- a/t/t0017-env-helper.sh
+++ b/t/t0017-env-helper.sh
@@ -88,7 +88,7 @@ test_expect_success 'test-tool env-helper reads config thanks to trace2' '
 	test_must_fail \
 		env HOME="$(pwd)/home" \
 		git config -l 2>err &&
-	grep "exceeded maximum include depth" err &&
+	test_grep "exceeded maximum include depth" err &&
 
 	# This validates that the assumption that we attempt to
 	# read the configuration and fail very early in the start-up
@@ -100,7 +100,7 @@ test_expect_success 'test-tool env-helper reads config thanks to trace2' '
 		test-tool -C no-such-directory \
 		env-helper --type=bool --default=0 \
 		--exit-code GIT_TEST_ENV_HELPER 2>err &&
-	grep "exceeded maximum include depth" err
+	test_grep "exceeded maximum include depth" err
 '
 
 test_done
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 033b00a364..4f29d088f3 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -731,7 +731,7 @@ test_expect_success 'process filter should restart after unexpected write failur
 		rm -f debug.log &&
 		git checkout --quiet --no-progress . 2>git-stderr.log &&
 
-		grep "smudge write error" git-stderr.log &&
+		test_grep "smudge write error" git-stderr.log &&
 		test_grep "error: external filter" git-stderr.log &&
 
 		cat >expected.log <<-EOF &&
@@ -853,7 +853,7 @@ test_expect_success 'invalid process filter must fail (and not hang!)' '
 
 		cp "$TEST_ROOT/test.o" test.r &&
 		test_must_fail git add . 2>git-stderr.log &&
-		grep "expected git-filter-server" git-stderr.log
+		test_grep "expected git-filter-server" git-stderr.log
 	)
 '
 
@@ -970,7 +970,7 @@ test_expect_success 'missing file in delayed checkout' '
 
 	rm -rf repo-cloned &&
 	test_must_fail git clone repo repo-cloned 2>git-stderr.log &&
-	grep "error: .missing-delay\.a. was not filtered properly" git-stderr.log
+	test_grep "error: .missing-delay\.a. was not filtered properly" git-stderr.log
 '
 
 test_expect_success 'invalid file in delayed checkout' '
@@ -991,7 +991,7 @@ test_expect_success 'invalid file in delayed checkout' '
 
 	rm -rf repo-cloned &&
 	test_must_fail git clone repo repo-cloned 2>git-stderr.log &&
-	grep "error: external filter .* signaled that .unfiltered. is now available although it has not been delayed earlier" git-stderr.log
+	test_grep "error: external filter .* signaled that .unfiltered. is now available although it has not been delayed earlier" git-stderr.log
 '
 
 for mode in 'case' 'utf-8'
@@ -1032,7 +1032,7 @@ do
 
 		git clone $mode-collision $mode-collision-cloned &&
 		# Make sure z was really delayed
-		grep "IN: smudge $dir/z .* \\[DELAYED\\]" $mode-collision-cloned/delayed.log &&
+		test_grep "IN: smudge $dir/z .* \\[DELAYED\\]" $mode-collision-cloned/delayed.log &&
 
 		# Should not create $dir/z at $symlink/z
 		test_path_is_missing $mode-collision/target-dir/z
@@ -1070,7 +1070,7 @@ test_expect_success SYMLINKS,CASE_INSENSITIVE_FS \
 		git commit -m super &&
 
 		git checkout --recurse-submodules . &&
-		grep "IN: smudge A/B/y .* \\[DELAYED\\]" delayed.log &&
+		test_grep "IN: smudge A/B/y .* \\[DELAYED\\]" delayed.log &&
 		test_path_is_missing target-dir/y
 	)
 '
@@ -1161,9 +1161,9 @@ test_expect_success 'delayed checkout correctly reports the number of updated en
 
 		rm *.a &&
 		git checkout . 2>err &&
-		grep "IN: smudge test-delay10.a .* \\[DELAYED\\]" delayed.log &&
-		grep "IN: smudge test-delay11.a .* \\[DELAYED\\]" delayed.log &&
-		grep "Updated 2 paths from the index" err
+		test_grep "IN: smudge test-delay10.a .* \\[DELAYED\\]" delayed.log &&
+		test_grep "IN: smudge test-delay11.a .* \\[DELAYED\\]" delayed.log &&
+		test_grep "Updated 2 paths from the index" err
 	)
 '
 
diff --git a/t/t0029-core-unsetenvvars.sh b/t/t0029-core-unsetenvvars.sh
index baa1b7e85b..975620b389 100755
--- a/t/t0029-core-unsetenvvars.sh
+++ b/t/t0029-core-unsetenvvars.sh
@@ -20,10 +20,10 @@ test_expect_success 'core.unsetenvvars works' '
 	HOBBES=Calvin &&
 	export HOBBES &&
 	git commit --allow-empty -m with 2>err &&
-	grep Calvin err &&
+	test_grep Calvin err &&
 	git -c core.unsetenvvars=FINDUS,HOBBES,CALVIN \
 		commit --allow-empty -m without 2>err &&
-	! grep Calvin err
+	test_grep ! Calvin err
 '
 
 test_done
diff --git a/t/t0030-stripspace.sh b/t/t0030-stripspace.sh
index 43155f6bd8..d6e2f63c59 100755
--- a/t/t0030-stripspace.sh
+++ b/t/t0030-stripspace.sh
@@ -407,12 +407,12 @@ test_expect_success 'strip comments with changed comment string' '
 
 test_expect_success 'newline as commentchar is forbidden' '
 	test_must_fail git -c core.commentChar="$LF" stripspace -s 2>err &&
-	grep "core.commentchar cannot contain newline" err
+	test_grep "core.commentchar cannot contain newline" err
 '
 
 test_expect_success 'empty commentchar is forbidden' '
 	test_must_fail git -c core.commentchar= stripspace -s 2>err &&
-	grep "core.commentchar must have at least one character" err
+	test_grep "core.commentchar must have at least one character" err
 '
 
 test_expect_success '-c with single line' '
diff --git a/t/t0031-lockfile-pid.sh b/t/t0031-lockfile-pid.sh
index 8ef87addf5..e9e2f04049 100755
--- a/t/t0031-lockfile-pid.sh
+++ b/t/t0031-lockfile-pid.sh
@@ -29,7 +29,7 @@ test_expect_success 'PID info not shown by default' '
 		test_must_fail git add . 2>err &&
 		# Should not crash, just show normal error without PID
 		test_grep "Unable to create" err &&
-		! test_grep "is held by process" err
+		test_grep ! "is held by process" err
 	)
 '
 
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index ca55ea8228..a8348a851c 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -324,13 +324,13 @@ test_expect_success 'non ambiguous option (after two options it abbreviates)' '
 
 test_expect_success 'Alias options do not contribute to abbreviation' '
 	test-tool parse-options --alias-source 123 >output &&
-	grep "^string: 123" output &&
+	test_grep "^string: 123" output &&
 	test-tool parse-options --alias-target 123 >output &&
-	grep "^string: 123" output &&
+	test_grep "^string: 123" output &&
 	test_must_fail test-tool parse-options --alias &&
 	GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
 	test-tool parse-options --alias 123 >output &&
-	grep "^string: 123" output
+	test_grep "^string: 123" output
 '
 
 cat >typo.err <<\EOF
@@ -582,16 +582,16 @@ test_expect_success 'KEEP_UNKNOWN_OPT works' '
 
 test_expect_success 'NO_INTERNAL_HELP works for -h' '
 	test_expect_code 129 test-tool parse-options-flags --no-internal-help cmd -h 2>err &&
-	grep "^error: unknown switch \`h$SQ" err &&
-	grep "^usage: " err
+	test_grep "^error: unknown switch \`h$SQ" err &&
+	test_grep "^usage: " err
 '
 
 for help_opt in help help-all
 do
 	test_expect_success "NO_INTERNAL_HELP works for --$help_opt" "
 		test_expect_code 129 test-tool parse-options-flags --no-internal-help cmd --$help_opt 2>err &&
-		grep '^error: unknown option \`'$help_opt\' err &&
-		grep '^usage: ' err
+		test_grep '^error: unknown option \`'$help_opt\' err &&
+		test_grep '^usage: ' err
 	"
 done
 
@@ -608,38 +608,38 @@ test_expect_success 'KEEP_UNKNOWN_OPT | NO_INTERNAL_HELP works' '
 
 test_expect_success 'subcommand - no subcommand shows error and usage' '
 	test_expect_code 129 test-tool parse-subcommand cmd 2>err &&
-	grep "^error: need a subcommand" err &&
-	grep ^usage: err
+	test_grep "^error: need a subcommand" err &&
+	test_grep ^usage: err
 '
 
 test_expect_success 'subcommand - subcommand after -- shows error and usage' '
 	test_expect_code 129 test-tool parse-subcommand cmd -- subcmd-one 2>err &&
-	grep "^error: need a subcommand" err &&
-	grep ^usage: err
+	test_grep "^error: need a subcommand" err &&
+	test_grep ^usage: err
 '
 
 test_expect_success 'subcommand - subcommand after --end-of-options shows error and usage' '
 	test_expect_code 129 test-tool parse-subcommand cmd --end-of-options subcmd-one 2>err &&
-	grep "^error: need a subcommand" err &&
-	grep ^usage: err
+	test_grep "^error: need a subcommand" err &&
+	test_grep ^usage: err
 '
 
 test_expect_success 'subcommand - unknown subcommand shows error and usage' '
 	test_expect_code 129 test-tool parse-subcommand cmd nope 2>err &&
-	grep "^error: unknown subcommand: \`nope$SQ" err &&
-	grep ^usage: err
+	test_grep "^error: unknown subcommand: \`nope$SQ" err &&
+	test_grep ^usage: err
 '
 
 test_expect_success 'subcommand - subcommands cannot be abbreviated' '
 	test_expect_code 129 test-tool parse-subcommand cmd subcmd-o 2>err &&
-	grep "^error: unknown subcommand: \`subcmd-o$SQ$" err &&
-	grep ^usage: err
+	test_grep "^error: unknown subcommand: \`subcmd-o$SQ$" err &&
+	test_grep ^usage: err
 '
 
 test_expect_success 'subcommand - no negated subcommands' '
 	test_expect_code 129 test-tool parse-subcommand cmd no-subcmd-one 2>err &&
-	grep "^error: unknown subcommand: \`no-subcmd-one$SQ" err &&
-	grep ^usage: err
+	test_grep "^error: unknown subcommand: \`no-subcmd-one$SQ" err &&
+	test_grep ^usage: err
 '
 
 test_expect_success 'subcommand - simple' '
@@ -709,8 +709,8 @@ test_expect_success 'subcommand - SUBCOMMAND_OPTIONAL + subcommand not given + u
 
 test_expect_success 'subcommand - SUBCOMMAND_OPTIONAL + subcommand not given + unknown option' '
 	test_expect_code 129 test-tool parse-subcommand --subcommand-optional cmd --subcommand-opt 2>err &&
-	grep "^error: unknown option" err &&
-	grep ^usage: err
+	test_grep "^error: unknown option" err &&
+	test_grep ^usage: err
 '
 
 test_expect_success 'subcommand - SUBCOMMAND_OPTIONAL | KEEP_UNKNOWN_OPT + subcommand not given + unknown option' '
@@ -778,28 +778,28 @@ test_expect_success 'subcommand - completion helper' '
 
 test_expect_success 'subcommands are incompatible with STOP_AT_NON_OPTION' '
 	test_must_fail test-tool parse-subcommand --stop-at-non-option cmd subcmd-one 2>err &&
-	grep ^BUG err
+	test_grep ^BUG err
 '
 
 test_expect_success 'subcommands are incompatible with KEEP_UNKNOWN_OPT unless in combination with SUBCOMMAND_OPTIONAL' '
 	test_must_fail test-tool parse-subcommand --keep-unknown-opt cmd subcmd-two 2>err &&
-	grep ^BUG err
+	test_grep ^BUG err
 '
 
 test_expect_success 'subcommands are incompatible with KEEP_DASHDASH unless in combination with SUBCOMMAND_OPTIONAL' '
 	test_must_fail test-tool parse-subcommand --keep-dashdash cmd subcmd-two 2>err &&
-	grep ^BUG err
+	test_grep ^BUG err
 '
 
 test_expect_success 'negative unsigned' '
 	test_must_fail test-tool parse-options --unsigned -1 >out 2>err &&
-	grep "non-negative integer" err &&
+	test_grep "non-negative integer" err &&
 	test_must_be_empty out
 '
 
 test_expect_success 'unsigned with units but no numbers' '
 	test_must_fail test-tool parse-options --unsigned m >out 2>err &&
-	grep "non-negative integer" err &&
+	test_grep "non-negative integer" err &&
 	test_must_be_empty out
 '
 
diff --git a/t/t0041-usage.sh b/t/t0041-usage.sh
index a0f6f134c7..51af7cc030 100755
--- a/t/t0041-usage.sh
+++ b/t/t0041-usage.sh
@@ -13,7 +13,7 @@ test_expect_success 'setup ' '
 
 test_expect_success 'tag --contains <existent_tag>' '
 	git tag --contains "v1.0" >actual 2>actual.err &&
-	grep "v1.0" actual &&
+	test_grep "v1.0" actual &&
 	test_line_count = 0 actual.err
 '
 
diff --git a/t/t0052-simple-ipc.sh b/t/t0052-simple-ipc.sh
index ff98be31a5..14cea84920 100755
--- a/t/t0052-simple-ipc.sh
+++ b/t/t0052-simple-ipc.sh
@@ -33,19 +33,19 @@ test_expect_success 'servers cannot share the same path' '
 test_expect_success 'big response' '
 	test-tool simple-ipc send --token=big >actual &&
 	test_line_count -ge 10000 actual &&
-	grep -q "big: [0]*9999\$" actual
+	test_grep -q "big: [0]*9999\$" actual
 '
 
 test_expect_success 'chunk response' '
 	test-tool simple-ipc send --token=chunk >actual &&
 	test_line_count -ge 10000 actual &&
-	grep -q "big: [0]*9999\$" actual
+	test_grep -q "big: [0]*9999\$" actual
 '
 
 test_expect_success 'slow response' '
 	test-tool simple-ipc send --token=slow >actual &&
 	test_line_count -ge 100 actual &&
-	grep -q "big: [0]*99\$" actual
+	test_grep -q "big: [0]*99\$" actual
 '
 
 # Send an IPC with n=100,000 bytes of ballast.  This should be large enough
@@ -54,7 +54,7 @@ test_expect_success 'slow response' '
 #
 test_expect_success 'sendbytes' '
 	test-tool simple-ipc sendbytes --bytecount=100000 --byte=A >actual &&
-	grep "sent:A00100000 rcvd:A00100000" actual
+	test_grep "sent:A00100000 rcvd:A00100000" actual
 '
 
 # Start a series of <threads> client threads that each make <batchsize>
@@ -93,7 +93,7 @@ test_expect_success 'stress test threads' '
 		--batchsize=13 \
 		>actual &&
 	test_line_count = 92 actual &&
-	grep "good 91" actual &&
+	test_grep "good 91" actual &&
 	grep "sent:A" <actual >actual_a &&
 	cat >expect_a <<-EOF &&
 		sent:A00000019 rcvd:A00000019
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 60cfe65979..dc9d77b0e1 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -97,7 +97,7 @@ test_expect_success POSIXPERM 'run_command reports EACCES' '
 	chmod -x hello.sh &&
 	test_must_fail test-tool run-command run-command ./hello.sh 2>err &&
 
-	grep "fatal: cannot exec.*hello.sh" err
+	test_grep "fatal: cannot exec.*hello.sh" err
 '
 
 test_expect_success POSIXPERM,SANITY 'unreadable directory in PATH' '
diff --git a/t/t0066-dir-iterator.sh b/t/t0066-dir-iterator.sh
index df3e9f5fa5..9fbb41bac5 100755
--- a/t/t0066-dir-iterator.sh
+++ b/t/t0066-dir-iterator.sh
@@ -127,7 +127,7 @@ test_expect_success SYMLINKS 'dir-iterator should not follow symlinks by default
 test_expect_success SYMLINKS 'dir-iterator does not resolve top-level symlinks' '
 	test_must_fail test-tool dir-iterator ./dir5 >out &&
 
-	grep "ENOTDIR" out
+	test_grep "ENOTDIR" out
 '
 
 test_done
diff --git a/t/t0068-for-each-repo.sh b/t/t0068-for-each-repo.sh
index 80b163ea99..55b37d895a 100755
--- a/t/t0068-for-each-repo.sh
+++ b/t/t0068-for-each-repo.sh
@@ -21,23 +21,23 @@ test_expect_success 'run based on configured value' '
 
 	git for-each-repo --config=run.key commit --allow-empty -m "ran" &&
 	git -C one log -1 --pretty=format:%s >message &&
-	grep ran message &&
+	test_grep ran message &&
 	git -C two log -1 --pretty=format:%s >message &&
-	! grep ran message &&
+	test_grep ! ran message &&
 	git -C three log -1 --pretty=format:%s >message &&
-	grep ran message &&
+	test_grep ran message &&
 	git -C ~/four log -1 --pretty=format:%s >message &&
-	grep ran message &&
+	test_grep ran message &&
 
 	git for-each-repo --config=run.key -- commit --allow-empty -m "ran again" &&
 	git -C one log -1 --pretty=format:%s >message &&
-	grep again message &&
+	test_grep again message &&
 	git -C two log -1 --pretty=format:%s >message &&
-	! grep again message &&
+	test_grep ! again message &&
 	git -C three log -1 --pretty=format:%s >message &&
-	grep again message &&
+	test_grep again message &&
 	git -C ~/four log -1 --pretty=format:%s >message &&
-	grep again message &&
+	test_grep again message &&
 
 	git -C three for-each-repo --config=run.key -- \
 		commit --allow-empty -m "ran from worktree" &&
diff --git a/t/t0070-fundamental.sh b/t/t0070-fundamental.sh
index 6b9dcf984b..8f573c2a0e 100755
--- a/t/t0070-fundamental.sh
+++ b/t/t0070-fundamental.sh
@@ -10,7 +10,7 @@ Verify wrappers and compatibility functions.
 
 test_expect_success 'mktemp to nonexistent directory prints filename' '
 	test_must_fail test-tool mktemp doesnotexist/testXXXXXX 2>err &&
-	grep "doesnotexist/test" err
+	test_grep "doesnotexist/test" err
 '
 
 test_expect_success POSIXPERM,SANITY 'mktemp to unwritable directory prints filename' '
@@ -18,7 +18,7 @@ test_expect_success POSIXPERM,SANITY 'mktemp to unwritable directory prints file
 	test_when_finished "chmod +w cannotwrite" &&
 	chmod -w cannotwrite &&
 	test_must_fail test-tool mktemp cannotwrite/testXXXXXX 2>err &&
-	grep "cannotwrite/test" err
+	test_grep "cannotwrite/test" err
 '
 
 test_expect_success 'git_mkstemps_mode does not fail if fd 0 is not open' '
@@ -33,7 +33,7 @@ test_expect_success 'check for a bug in the regex routines' '
 test_expect_success 'incomplete sideband messages are reassembled' '
 	test-tool pkt-line send-split-sideband >split-sideband &&
 	test-tool pkt-line receive-sideband <split-sideband 2>err &&
-	grep "Hello, world" err
+	test_grep "Hello, world" err
 '
 
 test_expect_success 'eof on sideband message is reported' '
diff --git a/t/t0081-find-pack.sh b/t/t0081-find-pack.sh
index 26f017422d..ff9d56fbf1 100755
--- a/t/t0081-find-pack.sh
+++ b/t/t0081-find-pack.sh
@@ -52,17 +52,17 @@ test_expect_success 'add more packfiles' '
 
 	# HEAD^{tree} is in 2 packfiles
 	test-tool find-pack HEAD^{tree} >head_tree_packs &&
-	grep "$head_commit_pack" head_tree_packs &&
-	grep mypackname1 head_tree_packs &&
-	! grep mypackname2 head_tree_packs &&
+	test_grep "$head_commit_pack" head_tree_packs &&
+	test_grep mypackname1 head_tree_packs &&
+	test_grep ! mypackname2 head_tree_packs &&
 	test-tool find-pack --check-count 2 HEAD^{tree} &&
 	! test-tool find-pack --check-count 1 HEAD^{tree} &&
 
 	# HEAD:five.t is also in 2 packfiles
 	test-tool find-pack HEAD:five.t >five_packs &&
-	grep "$head_commit_pack" five_packs &&
-	! grep mypackname1 five_packs &&
-	grep mypackname2 five_packs &&
+	test_grep "$head_commit_pack" five_packs &&
+	test_grep ! mypackname1 five_packs &&
+	test_grep mypackname2 five_packs &&
 	test-tool find-pack -c 2 HEAD:five.t &&
 	! test-tool find-pack --check-count=0 HEAD:five.t
 '
diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
index e38ca7a901..81ed41742c 100755
--- a/t/t0091-bugreport.sh
+++ b/t/t0091-bugreport.sh
@@ -40,15 +40,15 @@ test_expect_success 'sanity check "System Info" section' '
 
 	# The beginning should match "git version --build-options" verbatim,
 	# but rather than checking bit-for-bit equality, just test some basics.
-	grep "git version " system &&
-	grep "shell-path: ." system &&
+	test_grep "git version " system &&
+	test_grep "shell-path: ." system &&
 
 	# After the version, there should be some more info.
 	# This is bound to differ from environment to environment,
 	# so we just do some rather high-level checks.
-	grep "uname: ." system &&
-	grep "compiler info: ." system &&
-	grep "zlib." system
+	test_grep "uname: ." system &&
+	test_grep "compiler info: ." system &&
+	test_grep "zlib." system
 '
 
 test_expect_success 'dies if file with same name as report already exists' '
@@ -112,7 +112,7 @@ test_expect_success UNZIP '--diagnose creates diagnostics zip archive' '
 	git bugreport --diagnose -o report -s test >out &&
 
 	zip_path=report/git-diagnostics-test.zip &&
-	grep "Available space" out &&
+	test_grep "Available space" out &&
 	test_path_is_file "$zip_path" &&
 
 	# Check zipped archive content
@@ -120,10 +120,10 @@ test_expect_success UNZIP '--diagnose creates diagnostics zip archive' '
 	test_file_not_empty out &&
 
 	"$GIT_UNZIP" -p "$zip_path" packs-local.txt >out &&
-	grep ".git/objects" out &&
+	test_grep ".git/objects" out &&
 
 	"$GIT_UNZIP" -p "$zip_path" objects-local.txt >out &&
-	grep "^Total: [0-9][0-9]*" out &&
+	test_grep "^Total: [0-9][0-9]*" out &&
 
 	# Should not include .git directory contents by default
 	! "$GIT_UNZIP" -l "$zip_path" | grep ".git/"
@@ -136,7 +136,7 @@ test_expect_success UNZIP '--diagnose=stats excludes .git dir contents' '
 
 	# Includes pack quantity/size info
 	"$GIT_UNZIP" -p "$zip_path" packs-local.txt >out &&
-	grep ".git/objects" out &&
+	test_grep ".git/objects" out &&
 
 	# Does not include .git directory contents
 	! "$GIT_UNZIP" -l "$zip_path" | grep ".git/"
diff --git a/t/t0092-diagnose.sh b/t/t0092-diagnose.sh
index 6cabd6e67b..0bc2b1ed5c 100755
--- a/t/t0092-diagnose.sh
+++ b/t/t0092-diagnose.sh
@@ -8,7 +8,7 @@ test_expect_success UNZIP 'creates diagnostics zip archive' '
 	test_when_finished rm -rf report &&
 
 	git diagnose -o report -s test >out &&
-	grep "Available space" out &&
+	test_grep "Available space" out &&
 
 	zip_path=report/git-diagnostics-test.zip &&
 	test_path_is_file "$zip_path" &&
@@ -18,10 +18,10 @@ test_expect_success UNZIP 'creates diagnostics zip archive' '
 	test_file_not_empty out &&
 
 	"$GIT_UNZIP" -p "$zip_path" packs-local.txt >out &&
-	grep ".git/objects" out &&
+	test_grep ".git/objects" out &&
 
 	"$GIT_UNZIP" -p "$zip_path" objects-local.txt >out &&
-	grep "^Total: [0-9][0-9]*" out &&
+	test_grep "^Total: [0-9][0-9]*" out &&
 
 	# Should not include .git directory contents by default
 	! "$GIT_UNZIP" -l "$zip_path" | grep ".git/"
@@ -34,7 +34,7 @@ test_expect_success UNZIP 'counts loose objects' '
 	git diagnose -o test-count -s 1 >out &&
 	zip_path=test-count/git-diagnostics-1.zip &&
 	"$GIT_UNZIP" -p "$zip_path" objects-local.txt >out &&
-	grep "^Total: [1-9][0-9]* loose objects" out
+	test_grep "^Total: [1-9][0-9]* loose objects" out
 '
 
 test_expect_success UNZIP '--mode=stats excludes .git dir contents' '
@@ -45,7 +45,7 @@ test_expect_success UNZIP '--mode=stats excludes .git dir contents' '
 	# Includes pack quantity/size info
 	zip_path=report/git-diagnostics-test.zip &&
 	"$GIT_UNZIP" -p "$zip_path" packs-local.txt >out &&
-	grep ".git/objects" out &&
+	test_grep ".git/objects" out &&
 
 	# Does not include .git directory contents
 	! "$GIT_UNZIP" -l "$zip_path" | grep ".git/"
@@ -59,7 +59,7 @@ test_expect_success UNZIP '--mode=all includes .git dir contents' '
 	# Includes pack quantity/size info
 	zip_path=report/git-diagnostics-test.zip &&
 	"$GIT_UNZIP" -p "$zip_path" packs-local.txt >out &&
-	grep ".git/objects" out &&
+	test_grep ".git/objects" out &&
 
 	# Includes .git directory contents
 	"$GIT_UNZIP" -l "$zip_path" | grep ".git/" &&
diff --git a/t/t0100-previous.sh b/t/t0100-previous.sh
index dd5d9b4e5e..87a9995ea4 100755
--- a/t/t0100-previous.sh
+++ b/t/t0100-previous.sh
@@ -50,7 +50,7 @@ test_expect_success 'merge @{-1}~1' '
 	git checkout main &&
 	git merge @{-1}~1 &&
 	git cat-file commit HEAD >actual &&
-	grep "Merge branch '\''other'\''" actual
+	test_grep "Merge branch '\''other'\''" actual
 '
 
 test_expect_success 'merge @{-100} before checking out that many branches yet' '
diff --git a/t/t0200-gettext-basic.sh b/t/t0200-gettext-basic.sh
index 8853d8afb9..8db26c1ada 100755
--- a/t/t0200-gettext-basic.sh
+++ b/t/t0200-gettext-basic.sh
@@ -16,7 +16,7 @@ test_expect_success 'sanity: $TEXTDOMAIN is git' '
 '
 
 test_expect_success 'xgettext sanity: Perl _() strings are not extracted' '
-    ! grep "A Perl string xgettext will not get" "$GIT_PO_PATH"/is.po
+    test_grep ! "A Perl string xgettext will not get" "$GIT_PO_PATH"/is.po
 '
 
 test_expect_success 'xgettext sanity: Comment extraction with --add-comments' '
@@ -26,8 +26,8 @@ test_expect_success 'xgettext sanity: Comment extraction with --add-comments' '
 '
 
 test_expect_success 'xgettext sanity: Comment extraction with --add-comments stops at statements' '
-    ! grep "This is a phony" "$GIT_PO_PATH"/is.po &&
-    ! grep "the above comment" "$GIT_PO_PATH"/is.po
+    test_grep ! "This is a phony" "$GIT_PO_PATH"/is.po &&
+    test_grep ! "the above comment" "$GIT_PO_PATH"/is.po
 '
 
 test_expect_success GETTEXT 'sanity: $TEXTDOMAINDIR exists without NO_GETTEXT=YesPlease' '
@@ -44,10 +44,10 @@ test_expect_success GETTEXT 'sanity: Icelandic locale was compiled' '
 test_expect_success GETTEXT_LOCALE 'sanity: gettext("") metadata is OK' '
     # Return value may be non-zero
     LANGUAGE=is LC_ALL="$is_IS_locale" gettext "" >zero-expect &&
-    grep "Project-Id-Version: Git" zero-expect &&
-    grep "Git Mailing List <git@vger.kernel.org>" zero-expect &&
-    grep "Content-Type: text/plain; charset=UTF-8" zero-expect &&
-    grep "Content-Transfer-Encoding: 8bit" zero-expect
+    test_grep "Project-Id-Version: Git" zero-expect &&
+    test_grep "Git Mailing List <git@vger.kernel.org>" zero-expect &&
+    test_grep "Content-Type: text/plain; charset=UTF-8" zero-expect &&
+    test_grep "Content-Transfer-Encoding: 8bit" zero-expect
 '
 
 test_expect_success GETTEXT_LOCALE 'sanity: gettext(unknown) is passed through' '
diff --git a/t/t0203-gettext-setlocale-sanity.sh b/t/t0203-gettext-setlocale-sanity.sh
index 0ce1f22eff..670082bf09 100755
--- a/t/t0203-gettext-setlocale-sanity.sh
+++ b/t/t0203-gettext-setlocale-sanity.sh
@@ -12,7 +12,7 @@ test_expect_success 'git show a ISO-8859-1 commit under C locale' '
 	test_commit "iso-c-commit" iso-under-c &&
 	git show >out 2>err &&
 	test_must_be_empty err &&
-	grep -q "iso-c-commit" out
+	test_grep -q "iso-c-commit" out
 '
 
 test_expect_success GETTEXT_LOCALE 'git show a ISO-8859-1 commit under a UTF-8 locale' '
@@ -20,7 +20,7 @@ test_expect_success GETTEXT_LOCALE 'git show a ISO-8859-1 commit under a UTF-8 l
 	test_commit "iso-utf8-commit" iso-under-utf8 &&
 	LANGUAGE=is LC_ALL="$is_IS_locale" git show >out 2>err &&
 	test_must_be_empty err &&
-	grep -q "iso-utf8-commit" out
+	test_grep -q "iso-utf8-commit" out
 '
 
 test_done
diff --git a/t/t0204-gettext-reencode-sanity.sh b/t/t0204-gettext-reencode-sanity.sh
index 28d92bb9b7..48ccddaf7d 100755
--- a/t/t0204-gettext-reencode-sanity.sh
+++ b/t/t0204-gettext-reencode-sanity.sh
@@ -66,22 +66,22 @@ test_expect_success GETTEXT_LOCALE 'gettext: Fetching a UTF-8 msgid -> UTF-8' '
 # eyes.
 test_expect_success GETTEXT_ISO_LOCALE 'gettext: Fetching a UTF-8 msgid -> ISO-8859-1' '
     LANGUAGE=is LC_ALL="$is_IS_iso_locale" gettext "TEST: ‘single’ and “double” quotes" >actual &&
-    grep "einfaldar" actual &&
-    grep "$(echo tvöfaldar | iconv -f UTF-8 -t ISO8859-1)" actual
+    test_grep "einfaldar" actual &&
+    test_grep "$(echo tvöfaldar | iconv -f UTF-8 -t ISO8859-1)" actual
 '
 
 test_expect_success GETTEXT_LOCALE 'gettext.c: git init UTF-8 -> UTF-8' '
     printf "Bjó til tóma Git lind" >expect &&
     LANGUAGE=is LC_ALL="$is_IS_locale" git init repo >actual &&
     test_when_finished "rm -rf repo" &&
-    grep "^$(cat expect) " actual
+    test_grep "^$(cat expect) " actual
 '
 
 test_expect_success GETTEXT_ISO_LOCALE 'gettext.c: git init UTF-8 -> ISO-8859-1' '
     printf "Bjó til tóma Git lind" >expect &&
     LANGUAGE=is LC_ALL="$is_IS_iso_locale" git init repo >actual &&
     test_when_finished "rm -rf repo" &&
-    grep "^$(iconv -f UTF-8 -t ISO8859-1 <expect) " actual
+    test_grep "^$(iconv -f UTF-8 -t ISO8859-1 <expect) " actual
 '
 
 test_done
diff --git a/t/t0210-trace2-normal.sh b/t/t0210-trace2-normal.sh
index 7e1e7af862..beed2b27a5 100755
--- a/t/t0210-trace2-normal.sh
+++ b/t/t0210-trace2-normal.sh
@@ -333,12 +333,12 @@ test_expect_success 'unsafe URLs are redacted by default' '
 
 	GIT_TRACE2="$(pwd)/trace.normal" \
 		git clone https://user:pwd@example.com/ clone &&
-	! grep user:pwd trace.normal &&
+	test_grep ! user:pwd trace.normal &&
 
 	GIT_TRACE2_REDACT=0 GIT_TRACE2="$(pwd)/unredacted.normal" \
 		git clone https://user:pwd@example.com/ clone2 &&
-	grep "start .* clone https://user:pwd@example.com" unredacted.normal &&
-	grep "remote.origin.url=https://user:pwd@example.com" unredacted.normal
+	test_grep "start .* clone https://user:pwd@example.com" unredacted.normal &&
+	test_grep "remote.origin.url=https://user:pwd@example.com" unredacted.normal
 '
 
 test_done
diff --git a/t/t0211-trace2-perf.sh b/t/t0211-trace2-perf.sh
index 760cf69087..665c8b3669 100755
--- a/t/t0211-trace2-perf.sh
+++ b/t/t0211-trace2-perf.sh
@@ -283,13 +283,13 @@ test_expect_success 'unsafe URLs are redacted by default' '
 
 	GIT_TRACE2_PERF="$(pwd)/trace.perf" \
 		git clone https://user:pwd@example.com/ clone &&
-	! grep user:pwd trace.perf &&
+	test_grep ! user:pwd trace.perf &&
 
 	GIT_TRACE2_REDACT=0 GIT_TRACE2_PERF="$(pwd)/unredacted.perf" \
 		git clone https://user:pwd@example.com/ clone2 &&
 	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <unredacted.perf >actual &&
-	grep "d0|main|start|.* clone https://user:pwd@example.com" actual &&
-	grep "d0|main|def_param|.*|remote.origin.url:https://user:pwd@example.com" actual
+	test_grep "d0|main|start|.* clone https://user:pwd@example.com" actual &&
+	test_grep "d0|main|def_param|.*|remote.origin.url:https://user:pwd@example.com" actual
 '
 
 # Confirm that the requested command produces a "cmd_name" and a
@@ -358,13 +358,13 @@ test_expect_success LIBCURL \
 
 	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <prop.perf >actual &&
 
-	grep "d0|main|cmd_name|.*|_run_dashed_" actual &&
-	grep "d0|main|def_param|.*|cfg.prop.foo:red" actual &&
-	grep "d0|main|def_param|.*|ENV_PROP_FOO:blue" actual &&
+	test_grep "d0|main|cmd_name|.*|_run_dashed_" actual &&
+	test_grep "d0|main|def_param|.*|cfg.prop.foo:red" actual &&
+	test_grep "d0|main|def_param|.*|ENV_PROP_FOO:blue" actual &&
 
-	grep "d1|main|cmd_name|.*|remote-curl" actual &&
-	grep "d1|main|def_param|.*|cfg.prop.foo:red" actual &&
-	grep "d1|main|def_param|.*|ENV_PROP_FOO:blue" actual
+	test_grep "d1|main|cmd_name|.*|remote-curl" actual &&
+	test_grep "d1|main|def_param|.*|cfg.prop.foo:red" actual &&
+	test_grep "d1|main|def_param|.*|ENV_PROP_FOO:blue" actual
 '
 
 # Similarly, `git-http-fetch` is not built from git.c so do a
@@ -389,13 +389,13 @@ test_expect_success LIBCURL \
 
 	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <prop.perf >actual &&
 
-	grep "d0|main|cmd_name|.*|_run_dashed_" actual &&
-	grep "d0|main|def_param|.*|cfg.prop.foo:red" actual &&
-	grep "d0|main|def_param|.*|ENV_PROP_FOO:blue" actual &&
+	test_grep "d0|main|cmd_name|.*|_run_dashed_" actual &&
+	test_grep "d0|main|def_param|.*|cfg.prop.foo:red" actual &&
+	test_grep "d0|main|def_param|.*|ENV_PROP_FOO:blue" actual &&
 
-	grep "d1|main|cmd_name|.*|http-fetch" actual &&
-	grep "d1|main|def_param|.*|cfg.prop.foo:red" actual &&
-	grep "d1|main|def_param|.*|ENV_PROP_FOO:blue" actual
+	test_grep "d1|main|cmd_name|.*|http-fetch" actual &&
+	test_grep "d1|main|def_param|.*|cfg.prop.foo:red" actual &&
+	test_grep "d1|main|def_param|.*|ENV_PROP_FOO:blue" actual
 '
 
 # Historically, alias expansion explicitly emitted the def_param
@@ -421,22 +421,22 @@ test_expect_success 'expect def_params during git alias expansion' '
 	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <prop.perf >actual &&
 
 	# "git xxx" is first mapped to "git-xxx" and the child will fail.
-	grep "d0|main|cmd_name|.*|_run_dashed_ (_run_dashed_)" actual &&
+	test_grep "d0|main|cmd_name|.*|_run_dashed_ (_run_dashed_)" actual &&
 
 	# We unpeel that and substitute "version" into "xxx" (giving
 	# "git version") and update the cmd_name event.
-	grep "d0|main|cmd_name|.*|_run_git_alias_ (_run_dashed_/_run_git_alias_)" actual &&
+	test_grep "d0|main|cmd_name|.*|_run_git_alias_ (_run_dashed_/_run_git_alias_)" actual &&
 
 	# These def_param events could be associated with either of the
 	# above cmd_name events.  It does not matter.
-	grep "d0|main|def_param|.*|cfg.prop.foo:red" actual &&
-	grep "d0|main|def_param|.*|ENV_PROP_FOO:blue" actual &&
+	test_grep "d0|main|def_param|.*|cfg.prop.foo:red" actual &&
+	test_grep "d0|main|def_param|.*|ENV_PROP_FOO:blue" actual &&
 
 	# The "git version" child sees a different cmd_name hierarchy.
 	# Also test the def_param (only for completeness).
-	grep "d1|main|cmd_name|.*|version (_run_dashed_/_run_git_alias_/version)" actual &&
-	grep "d1|main|def_param|.*|cfg.prop.foo:red" actual &&
-	grep "d1|main|def_param|.*|ENV_PROP_FOO:blue" actual
+	test_grep "d1|main|cmd_name|.*|version (_run_dashed_/_run_git_alias_/version)" actual &&
+	test_grep "d1|main|def_param|.*|cfg.prop.foo:red" actual &&
+	test_grep "d1|main|def_param|.*|ENV_PROP_FOO:blue" actual
 '
 
 test_expect_success 'expect def_params during shell alias expansion' '
@@ -456,25 +456,25 @@ test_expect_success 'expect def_params during shell alias expansion' '
 	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <prop.perf >actual &&
 
 	# "git xxx" is first mapped to "git-xxx" and the child will fail.
-	grep "d0|main|cmd_name|.*|_run_dashed_ (_run_dashed_)" actual &&
+	test_grep "d0|main|cmd_name|.*|_run_dashed_ (_run_dashed_)" actual &&
 
 	# We unpeel that and substitute "git version" for "git xxx" (as a
 	# shell command.  Another cmd_name event is emitted as we unpeel.
-	grep "d0|main|cmd_name|.*|_run_shell_alias_ (_run_dashed_/_run_shell_alias_)" actual &&
+	test_grep "d0|main|cmd_name|.*|_run_shell_alias_ (_run_dashed_/_run_shell_alias_)" actual &&
 
 	# These def_param events could be associated with either of the
 	# above cmd_name events.  It does not matter.
-	grep "d0|main|def_param|.*|cfg.prop.foo:red" actual &&
-	grep "d0|main|def_param|.*|ENV_PROP_FOO:blue" actual &&
+	test_grep "d0|main|def_param|.*|cfg.prop.foo:red" actual &&
+	test_grep "d0|main|def_param|.*|ENV_PROP_FOO:blue" actual &&
 
 	# We get the following only because we used a git command for the
 	# shell command. In general, it could have been a shell script and
 	# we would see nothing.
 	#
 	# The child knows the cmd_name hierarchy so it includes it.
-	grep "d1|main|cmd_name|.*|version (_run_dashed_/_run_shell_alias_/version)" actual &&
-	grep "d1|main|def_param|.*|cfg.prop.foo:red" actual &&
-	grep "d1|main|def_param|.*|ENV_PROP_FOO:blue" actual
+	test_grep "d1|main|cmd_name|.*|version (_run_dashed_/_run_shell_alias_/version)" actual &&
+	test_grep "d1|main|def_param|.*|cfg.prop.foo:red" actual &&
+	test_grep "d1|main|def_param|.*|ENV_PROP_FOO:blue" actual
 '
 
 test_expect_success 'expect def_params during nested git alias expansion' '
@@ -496,33 +496,33 @@ test_expect_success 'expect def_params during nested git alias expansion' '
 
 	# "git xxx" is first mapped to "git-xxx" and try to spawn "git-xxx"
 	# and the child will fail.
-	grep "d0|main|cmd_name|.*|_run_dashed_ (_run_dashed_)" actual &&
-	grep "d0|main|child_start|.*|.* class:dashed argv:\[git-xxx\]" actual &&
+	test_grep "d0|main|cmd_name|.*|_run_dashed_ (_run_dashed_)" actual &&
+	test_grep "d0|main|child_start|.*|.* class:dashed argv:\[git-xxx\]" actual &&
 
 	# We unpeel that and substitute "yyy" into "xxx" (giving "git yyy")
 	# and spawn "git-yyy" and the child will fail.
-	grep "d0|main|alias|.*|alias:xxx argv:\[yyy\]" actual &&
-	grep "d0|main|cmd_name|.*|_run_dashed_ (_run_dashed_/_run_dashed_)" actual &&
-	grep "d0|main|child_start|.*|.* class:dashed argv:\[git-yyy\]" actual &&
+	test_grep "d0|main|alias|.*|alias:xxx argv:\[yyy\]" actual &&
+	test_grep "d0|main|cmd_name|.*|_run_dashed_ (_run_dashed_/_run_dashed_)" actual &&
+	test_grep "d0|main|child_start|.*|.* class:dashed argv:\[git-yyy\]" actual &&
 
 	# We unpeel that and substitute "version" into "xxx" (giving
 	# "git version") and update the cmd_name event.
-	grep "d0|main|alias|.*|alias:yyy argv:\[version\]" actual &&
-	grep "d0|main|cmd_name|.*|_run_git_alias_ (_run_dashed_/_run_dashed_/_run_git_alias_)" actual &&
+	test_grep "d0|main|alias|.*|alias:yyy argv:\[version\]" actual &&
+	test_grep "d0|main|cmd_name|.*|_run_git_alias_ (_run_dashed_/_run_dashed_/_run_git_alias_)" actual &&
 
 	# These def_param events could be associated with any of the
 	# above cmd_name events.  It does not matter.
 	grep "d0|main|def_param|.*|cfg.prop.foo:red" actual >actual.matches &&
-	grep "d0|main|def_param|.*|ENV_PROP_FOO:blue" actual &&
+	test_grep "d0|main|def_param|.*|ENV_PROP_FOO:blue" actual &&
 
 	# However, we do not want them repeated each time we unpeel.
 	test_line_count = 1 actual.matches &&
 
 	# The "git version" child sees a different cmd_name hierarchy.
 	# Also test the def_param (only for completeness).
-	grep "d1|main|cmd_name|.*|version (_run_dashed_/_run_dashed_/_run_git_alias_/version)" actual &&
-	grep "d1|main|def_param|.*|cfg.prop.foo:red" actual &&
-	grep "d1|main|def_param|.*|ENV_PROP_FOO:blue" actual
+	test_grep "d1|main|cmd_name|.*|version (_run_dashed_/_run_dashed_/_run_git_alias_/version)" actual &&
+	test_grep "d1|main|def_param|.*|cfg.prop.foo:red" actual &&
+	test_grep "d1|main|def_param|.*|ENV_PROP_FOO:blue" actual
 '
 
 test_done
diff --git a/t/t0212-trace2-event.sh b/t/t0212-trace2-event.sh
index 1211db9f46..f5358a1dd4 100755
--- a/t/t0212-trace2-event.sh
+++ b/t/t0212-trace2-event.sh
@@ -332,7 +332,7 @@ test_expect_success 'unsafe URLs are redacted by default in cmd_start events' '
 
 	GIT_TRACE2_EVENT="$(pwd)/trace.event" \
 		test-tool trace2 300redact_start git clone https://user:pwd@example.com/ clone2 &&
-	! grep user:pwd trace.event
+	test_grep ! user:pwd trace.event
 '
 
 test_expect_success 'unsafe URLs are redacted by default in child_start events' '
@@ -341,7 +341,7 @@ test_expect_success 'unsafe URLs are redacted by default in child_start events'
 
 	GIT_TRACE2_EVENT="$(pwd)/trace.event" \
 		test-tool trace2 301redact_child_start git clone https://user:pwd@example.com/ clone2 &&
-	! grep user:pwd trace.event
+	test_grep ! user:pwd trace.event
 '
 
 test_expect_success 'unsafe URLs are redacted by default in exec events' '
@@ -350,7 +350,7 @@ test_expect_success 'unsafe URLs are redacted by default in exec events' '
 
 	GIT_TRACE2_EVENT="$(pwd)/trace.event" \
 		test-tool trace2 302redact_exec git clone https://user:pwd@example.com/ clone2 &&
-	! grep user:pwd trace.event
+	test_grep ! user:pwd trace.event
 '
 
 test_expect_success 'unsafe URLs are redacted by default in def_param events' '
@@ -359,7 +359,7 @@ test_expect_success 'unsafe URLs are redacted by default in def_param events' '
 
 	GIT_TRACE2_EVENT="$(pwd)/trace.event" \
 		test-tool trace2 303redact_def_param url https://user:pwd@example.com/ &&
-	! grep user:pwd trace.event
+	test_grep ! user:pwd trace.event
 '
 
 test_done
diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index 64ead1571a..ea11cdb4dc 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -1014,7 +1014,7 @@ test_expect_success 'credential config with partial URLs' '
 	do
 		git -c credential.$partial.helper=yep \
 			credential fill <stdin >stdout &&
-		grep yep stdout ||
+		test_grep yep stdout ||
 		return 1
 	done &&
 
@@ -1030,7 +1030,7 @@ test_expect_success 'credential config with partial URLs' '
 	do
 		git -c credential.$partial.helper=yep \
 			credential fill <stdin >stdout &&
-		! grep yep stdout ||
+		test_grep ! yep stdout ||
 		return 1
 	done &&
 
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index dff442da20..dba4246100 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -206,7 +206,7 @@ test_expect_success 'fetching of missing objects' '
 	git -C repo cat-file -p "$HASH" 2>err &&
 
 	# Ensure that no spurious FETCH_HEAD messages are written
-	! grep FETCH_HEAD err &&
+	test_grep ! FETCH_HEAD err &&
 
 	# Ensure that the .promisor file is written, and check that its
 	# associated packfile contains the object
@@ -214,7 +214,7 @@ test_expect_success 'fetching of missing objects' '
 	test_line_count = 1 promisorlist &&
 	IDX=$(sed "s/promisor$/idx/" promisorlist) &&
 	git verify-pack --verbose "$IDX" >out &&
-	grep "$HASH" out
+	test_grep "$HASH" out
 '
 
 test_expect_success 'fetching of a promised object that promisor remote no longer has' '
@@ -228,7 +228,7 @@ test_expect_success 'fetching of a promised object that promisor remote no longe
 
 	rm -rf unreliable-server/.git/objects/* &&
 	test_must_fail git -C unreliable-client checkout HEAD 2>err &&
-	grep "could not fetch.*from promisor remote" err
+	test_grep "could not fetch.*from promisor remote" err
 '
 
 test_expect_success 'fetching of missing objects works with ref-in-want enabled' '
@@ -240,7 +240,7 @@ test_expect_success 'fetching of missing objects works with ref-in-want enabled'
 	rm -rf repo/.git/objects/* &&
 	rm -f trace &&
 	GIT_TRACE_PACKET="$(pwd)/trace" git -C repo cat-file -p "$HASH" &&
-	grep "fetch< fetch=.*ref-in-want" trace
+	test_grep "fetch< fetch=.*ref-in-want" trace
 '
 
 test_expect_success 'fetching from another promisor remote' '
@@ -263,7 +263,7 @@ test_expect_success 'fetching from another promisor remote' '
 	test_line_count = 1 promisorlist &&
 	IDX=$(sed "s/promisor$/idx/" promisorlist) &&
 	git verify-pack --verbose "$IDX" >out &&
-	grep "$HASH2" out
+	test_grep "$HASH2" out
 '
 
 test_expect_success 'fetching with --filter configures a promisor remote' '
@@ -286,7 +286,7 @@ test_expect_success 'fetching with --filter configures a promisor remote' '
 	test_line_count = 1 promisorlist &&
 	IDX=$(sed "s/promisor$/idx/" promisorlist) &&
 	git verify-pack --verbose "$IDX" >out &&
-	grep "$HASH3" out
+	test_grep "$HASH3" out
 '
 
 test_expect_success 'fetching of missing blobs works' '
@@ -327,8 +327,8 @@ test_expect_success 'fetching of missing trees does not fetch blobs' '
 
 	# Ensure that the tree, but not the blob, is fetched
 	git -C repo rev-list --objects --missing=print $(cat treehash) >objects &&
-	grep "^$(cat treehash)" objects &&
-	grep "^[?]$(cat blobhash)" objects
+	test_grep "^$(cat treehash)" objects &&
+	test_grep "^[?]$(cat blobhash)" objects
 '
 
 test_expect_success 'rev-list stops traversal at missing and promised commit' '
@@ -343,8 +343,8 @@ test_expect_success 'rev-list stops traversal at missing and promised commit' '
 	git -C repo config core.repositoryformatversion 1 &&
 	git -C repo config extensions.partialclone "arbitrary string" &&
 	git -C repo rev-list --exclude-promisor-objects --objects bar >out &&
-	grep $(git -C repo rev-parse bar) out &&
-	! grep $FOO out
+	test_grep $(git -C repo rev-parse bar) out &&
+	test_grep ! $FOO out
 '
 
 test_expect_success 'missing tree objects with --missing=allow-promisor and --exclude-promisor-objects' '
@@ -413,10 +413,10 @@ test_expect_success 'rev-list stops traversal at missing and promised tree' '
 	git -C repo config core.repositoryformatversion 1 &&
 	git -C repo config extensions.partialclone "arbitrary string" &&
 	git -C repo rev-list --exclude-promisor-objects --objects HEAD >out &&
-	grep $(git -C repo rev-parse foo) out &&
-	! grep $TREE out &&
-	grep $(git -C repo rev-parse HEAD) out &&
-	! grep $TREE2 out
+	test_grep $(git -C repo rev-parse foo) out &&
+	test_grep ! $TREE out &&
+	test_grep $(git -C repo rev-parse HEAD) out &&
+	test_grep ! $TREE2 out
 '
 
 test_expect_success 'rev-list stops traversal at missing and promised blob' '
@@ -432,8 +432,8 @@ test_expect_success 'rev-list stops traversal at missing and promised blob' '
 	git -C repo config core.repositoryformatversion 1 &&
 	git -C repo config extensions.partialclone "arbitrary string" &&
 	git -C repo rev-list --exclude-promisor-objects --objects HEAD >out &&
-	grep $(git -C repo rev-parse HEAD) out &&
-	! grep $BLOB out
+	test_grep $(git -C repo rev-parse HEAD) out &&
+	test_grep ! $BLOB out
 '
 
 test_expect_success 'rev-list stops traversal at promisor commit, tree, and blob' '
@@ -451,10 +451,10 @@ test_expect_success 'rev-list stops traversal at promisor commit, tree, and blob
 	git -C repo config core.repositoryformatversion 1 &&
 	git -C repo config extensions.partialclone "arbitrary string" &&
 	git -C repo rev-list --exclude-promisor-objects --objects HEAD >out &&
-	! grep $COMMIT out &&
-	! grep $TREE out &&
-	! grep $BLOB out &&
-	grep $(git -C repo rev-parse bar) out  # sanity check that some walking was done
+	test_grep ! $COMMIT out &&
+	test_grep ! $TREE out &&
+	test_grep ! $BLOB out &&
+	test_grep $(git -C repo rev-parse bar) out  # sanity check that some walking was done
 '
 
 test_expect_success 'rev-list dies for missing objects on cmd line' '
@@ -523,10 +523,10 @@ test_expect_success 'gc repacks promisor objects separately from non-promisor ob
 	test_line_count = 1 promisorlist &&
 	PROMISOR_PACKFILE=$(sed "s/.promisor/.pack/" <promisorlist) &&
 	git verify-pack $PROMISOR_PACKFILE -v >out &&
-	grep "$TREE_ONE" out &&
-	grep "$TREE_TWO" out &&
-	! grep "$(git -C repo rev-parse one)" out &&
-	! grep "$(git -C repo rev-parse two)" out &&
+	test_grep "$TREE_ONE" out &&
+	test_grep "$TREE_TWO" out &&
+	test_grep ! "$(git -C repo rev-parse one)" out &&
+	test_grep ! "$(git -C repo rev-parse two)" out &&
 
 	# Remove the promisor packfile and associated files
 	rm $(sed "s/.promisor//" <promisorlist).* &&
@@ -536,10 +536,10 @@ test_expect_success 'gc repacks promisor objects separately from non-promisor ob
 	ls repo/.git/objects/pack/pack-*.pack >packlist &&
 	test_line_count = 1 packlist &&
 	git verify-pack repo/.git/objects/pack/pack-*.pack -v >out &&
-	grep "$(git -C repo rev-parse one)" out &&
-	grep "$(git -C repo rev-parse two)" out &&
-	! grep "$TREE_ONE" out &&
-	! grep "$TREE_TWO" out
+	test_grep "$(git -C repo rev-parse one)" out &&
+	test_grep "$(git -C repo rev-parse two)" out &&
+	test_grep ! "$TREE_ONE" out &&
+	test_grep ! "$TREE_TWO" out
 '
 
 test_expect_success 'gc does not repack promisor objects if there are none' '
@@ -616,8 +616,8 @@ test_expect_success 'gc stops traversal when a missing but promised object is re
 	ls repo/.git/objects/pack/pack-*.pack >packlist &&
 	test_line_count = 1 packlist &&
 	git verify-pack repo/.git/objects/pack/pack-*.pack -v >out &&
-	grep "$(git -C repo rev-parse HEAD)" out &&
-	! grep "$TREE_HASH" out
+	test_grep "$(git -C repo rev-parse HEAD)" out &&
+	test_grep ! "$TREE_HASH" out
 '
 
 test_expect_success 'do not fetch when checking existence of tree we construct ourselves' '
@@ -647,10 +647,10 @@ test_expect_success 'exact rename does not need to fetch the blob lazily' '
 
 	git clone --filter=blob:none --bare "file://$(pwd)/repo" partial.git &&
 	git -C partial.git rev-list --objects --missing=print HEAD >out &&
-	grep "[?]$FILE_HASH" out &&
+	test_grep "[?]$FILE_HASH" out &&
 	git -C partial.git log --follow -- new-file.txt &&
 	git -C partial.git rev-list --objects --missing=print HEAD >out &&
-	grep "[?]$FILE_HASH" out
+	test_grep "[?]$FILE_HASH" out
 '
 
 test_expect_success 'lazy-fetch when accessing object not in the_repository' '
@@ -665,7 +665,7 @@ test_expect_success 'lazy-fetch when accessing object not in the_repository' '
 
 	# Sanity check that the file is missing
 	git -C partial.git rev-list --objects --missing=print HEAD >out &&
-	grep "[?]$FILE_HASH" out &&
+	test_grep "[?]$FILE_HASH" out &&
 
 	# The no-lazy-fetch mechanism prevents Git from fetching
 	test_must_fail env GIT_NO_LAZY_FETCH=1 \
@@ -680,7 +680,7 @@ test_expect_success 'lazy-fetch when accessing object not in the_repository' '
 
 	# Sanity check that the file is still missing
 	git -C partial.git rev-list --objects --missing=print HEAD >out &&
-	grep "[?]$FILE_HASH" out &&
+	test_grep "[?]$FILE_HASH" out &&
 
 	git -C full cat-file -s "$FILE_HASH" >expect &&
 	test-tool partial-clone object-info partial.git "$FILE_HASH" >actual &&
@@ -688,7 +688,7 @@ test_expect_success 'lazy-fetch when accessing object not in the_repository' '
 
 	# Sanity check that the file is now present
 	git -C partial.git rev-list --objects --missing=print HEAD >out &&
-	! grep "[?]$FILE_HASH" out
+	test_grep ! "[?]$FILE_HASH" out
 '
 
 test_expect_success 'push should not fetch new commit objects' '
@@ -705,9 +705,9 @@ test_expect_success 'push should not fetch new commit objects' '
 	COMMIT=$(git -C server rev-parse server2) &&
 
 	test_must_fail git -C client push 2>err &&
-	grep "fetch first" err &&
+	test_grep "fetch first" err &&
 	git -C client rev-list --objects --missing=print "$COMMIT" >objects &&
-	grep "^[?]$COMMIT" objects
+	test_grep "^[?]$COMMIT" objects
 '
 
 test_expect_success 'setup for promisor.quiet tests' '
@@ -750,7 +750,7 @@ test_expect_success TTY 'promisor.quiet=false shows progress messages' '
 	test_terminal git -C repo cat-file -p foo:foo.t 2>err &&
 
 	# Ensure that progress messages are written
-	grep "Receiving objects" err
+	test_grep "Receiving objects" err
 '
 
 test_expect_success TTY 'promisor.quiet=true does not show progress messages' '
@@ -761,7 +761,7 @@ test_expect_success TTY 'promisor.quiet=true does not show progress messages' '
 	test_terminal git -C repo cat-file -p foo:foo.t 2>err &&
 
 	# Ensure that no progress messages are written
-	! grep "Receiving objects" err
+	test_grep ! "Receiving objects" err
 '
 
 test_expect_success TTY 'promisor.quiet=unconfigured shows progress messages' '
@@ -771,7 +771,7 @@ test_expect_success TTY 'promisor.quiet=unconfigured shows progress messages' '
 	test_terminal git -C repo cat-file -p foo:foo.t 2>err &&
 
 	# Ensure that progress messages are written
-	grep "Receiving objects" err
+	test_grep "Receiving objects" err
 '
 
 test_expect_success 'promisor.quiet from submodule repo is honored' '
@@ -819,7 +819,7 @@ test_expect_success 'fetching of missing objects from an HTTP server' '
 	test_line_count = 1 promisorlist &&
 	IDX=$(sed "s/promisor$/idx/" promisorlist) &&
 	git verify-pack --verbose "$IDX" >out &&
-	grep "$HASH" out
+	test_grep "$HASH" out
 '
 
 # DO NOT add non-httpd-specific tests here, because the last part of this
diff --git a/t/t0450-txt-doc-vs-help.sh b/t/t0450-txt-doc-vs-help.sh
index 822b0d55a5..e7ba967223 100755
--- a/t/t0450-txt-doc-vs-help.sh
+++ b/t/t0450-txt-doc-vs-help.sh
@@ -87,7 +87,7 @@ do
 	# -h output assertions
 	test_expect_success "$builtin -h output has no \t" '
 		h2s="$(help_to_synopsis "$builtin")" &&
-		! grep "$HT" "$h2s"
+		test_grep ! "$HT" "$h2s"
 	'
 
 	test_expect_success "$builtin -h output has dashed labels" '
diff --git a/t/t0500-progress-display.sh b/t/t0500-progress-display.sh
index d1a498a216..fe2232cce0 100755
--- a/t/t0500-progress-display.sh
+++ b/t/t0500-progress-display.sh
@@ -320,8 +320,8 @@ test_expect_success 'progress generates traces' '
 
 	# t0212/parse_events.perl intentionally omits regions and data.
 	test_region progress "Working hard" trace.event &&
-	grep "\"key\":\"total_objects\",\"value\":\"40\"" trace.event &&
-	grep "\"key\":\"total_bytes\",\"value\":\"409600\"" trace.event
+	test_grep "\"key\":\"total_objects\",\"value\":\"40\"" trace.event &&
+	test_grep "\"key\":\"total_bytes\",\"value\":\"409600\"" trace.event
 '
 
 test_expect_success 'progress generates traces: stop / start' '
@@ -344,8 +344,8 @@ test_expect_success 'progress generates traces: start without stop' '
 	LSAN_OPTIONS=detect_leaks=0 \
 	test-tool progress \
 		<in 2>stderr &&
-	grep region_enter.*progress trace-start.event &&
-	! grep region_leave.*progress trace-start.event
+	test_grep region_enter.*progress trace-start.event &&
+	test_grep ! region_leave.*progress trace-start.event
 '
 
 test_expect_success 'progress generates traces: stop without start' '
@@ -355,8 +355,8 @@ test_expect_success 'progress generates traces: stop without start' '
 
 	GIT_TRACE2_EVENT="$PWD/trace-stop.event" test-tool progress \
 		<in 2>stderr &&
-	! grep region_enter.*progress trace-stop.event &&
-	! grep region_leave.*progress trace-stop.event
+	test_grep ! region_enter.*progress trace-stop.event &&
+	test_grep ! region_leave.*progress trace-stop.event
 '
 
 test_expect_success 'progress generates traces: start with active progress bar (no stops)' '
@@ -369,9 +369,9 @@ test_expect_success 'progress generates traces: start with active progress bar (
 	LSAN_OPTIONS=detect_leaks=0 \
 	test-tool progress \
 		<in 2>stderr &&
-	grep region_enter.*progress.*One trace-2start.event &&
-	grep region_enter.*progress.*Two trace-2start.event &&
-	! grep region_leave trace-2start.event
+	test_grep region_enter.*progress.*One trace-2start.event &&
+	test_grep region_enter.*progress.*Two trace-2start.event &&
+	test_grep ! region_leave trace-2start.event
 '
 
 test_done
diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index e19e036898..2f4c5e2a1b 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -776,11 +776,11 @@ test_expect_success 'reflog: can delete separate reflog entries' '
 		test_commit file3 &&
 		test_commit file4 &&
 		git reflog >actual &&
-		grep file3 actual &&
+		test_grep file3 actual &&
 
 		git reflog delete HEAD@{1} &&
 		git reflog >actual &&
-		! grep file3 actual
+		test_grep ! file3 actual
 	)
 '
 
@@ -902,8 +902,8 @@ test_expect_success 'reflog: garbage collection deletes reflog entries' '
 		done &&
 		git reflog refs/heads/main >actual &&
 		test_line_count = 10 actual &&
-		grep "commit (initial): number 1" actual &&
-		grep "commit: number 10" actual &&
+		test_grep "commit (initial): number 1" actual &&
+		test_grep "commit: number 10" actual &&
 
 		git gc &&
 		git reflog refs/heads/main >actual &&
diff --git a/t/t1004-read-tree-m-u-wf.sh b/t/t1004-read-tree-m-u-wf.sh
index 11bf10424f..70ba3eea4d 100755
--- a/t/t1004-read-tree-m-u-wf.sh
+++ b/t/t1004-read-tree-m-u-wf.sh
@@ -142,8 +142,8 @@ test_expect_success '3-way not overwriting local changes (our side)' '
 
 	echo >>file1 "local changes" &&
 	read_tree_u_must_succeed -m -u branch-point side-a side-b &&
-	grep "new line to be kept" file1 &&
-	grep "local changes" file1
+	test_grep "new line to be kept" file1 &&
+	test_grep "local changes" file1
 
 '
 
@@ -156,8 +156,8 @@ test_expect_success '3-way not overwriting local changes (their side)' '
 
 	echo >>file2 "local changes" &&
 	read_tree_u_must_fail -m -u branch-point side-a side-b &&
-	! grep "new line to be kept" file2 &&
-	grep "local changes" file2
+	test_grep ! "new line to be kept" file2 &&
+	test_grep "local changes" file2
 
 '
 
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 8e2c52652c..762c77c351 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -696,8 +696,8 @@ test_expect_success '%(deltabase) reports packed delta bases' '
 	git repack -ad &&
 	git cat-file --batch-check="%(deltabase)" <blobs >actual &&
 	{
-		grep "$(git rev-parse HEAD:foo)" actual ||
-		grep "$(git rev-parse HEAD:foo-plus)" actual
+		test_grep "$(git rev-parse HEAD:foo)" actual ||
+		test_grep "$(git rev-parse HEAD:foo-plus)" actual
 	}
 '
 
@@ -826,7 +826,7 @@ test_expect_success 'cat-file -t and -s on corrupt loose object' '
 		# Swap the two to corrupt the repository
 		mv -f "$other_path" "$empty_path" &&
 		test_must_fail git fsck 2>err.fsck &&
-		grep "hash-path mismatch" err.fsck &&
+		test_grep "hash-path mismatch" err.fsck &&
 
 		# confirm that cat-file is reading the new swapped-in
 		# blob...
@@ -1318,37 +1318,37 @@ test_expect_success 'cat-file --batch-all-objects --batch-check ignores replace'
 test_expect_success 'batch-command empty command' '
 	echo "" >cmd &&
 	test_expect_code 128 git cat-file --batch-command <cmd 2>err &&
-	grep "^fatal:.*empty command in input.*" err
+	test_grep "^fatal:.*empty command in input.*" err
 '
 
 test_expect_success 'batch-command whitespace before command' '
 	echo " info deadbeef" >cmd &&
 	test_expect_code 128 git cat-file --batch-command <cmd 2>err &&
-	grep "^fatal:.*whitespace before command.*" err
+	test_grep "^fatal:.*whitespace before command.*" err
 '
 
 test_expect_success 'batch-command unknown command' '
 	echo unknown_command >cmd &&
 	test_expect_code 128 git cat-file --batch-command <cmd 2>err &&
-	grep "^fatal:.*unknown command.*" err
+	test_grep "^fatal:.*unknown command.*" err
 '
 
 test_expect_success 'batch-command missing arguments' '
 	echo "info" >cmd &&
 	test_expect_code 128 git cat-file --batch-command <cmd 2>err &&
-	grep "^fatal:.*info requires arguments.*" err
+	test_grep "^fatal:.*info requires arguments.*" err
 '
 
 test_expect_success 'batch-command flush with arguments' '
 	echo "flush arg" >cmd &&
 	test_expect_code 128 git cat-file --batch-command --buffer <cmd 2>err &&
-	grep "^fatal:.*flush takes no arguments.*" err
+	test_grep "^fatal:.*flush takes no arguments.*" err
 '
 
 test_expect_success 'batch-command flush without --buffer' '
 	echo "flush" >cmd &&
 	test_expect_code 128 git cat-file --batch-command <cmd 2>err &&
-	grep "^fatal:.*flush is only for --buffer mode.*" err
+	test_grep "^fatal:.*flush is only for --buffer mode.*" err
 '
 
 perl_script='
diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index de076293b6..4782a6246a 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -202,7 +202,7 @@ done
 test_expect_success 'too-short tree' '
 	echo abc >malformed-tree &&
 	test_must_fail git hash-object -t tree malformed-tree 2>err &&
-	grep "too-short tree object" err
+	test_grep "too-short tree object" err
 '
 
 test_expect_success PERL_TEST_HELPERS 'malformed mode in tree' '
@@ -210,7 +210,7 @@ test_expect_success PERL_TEST_HELPERS 'malformed mode in tree' '
 	bin_oid=$(echo $hex_oid | hex2oct) &&
 	printf "9100644 \0$bin_oid" >tree-with-malformed-mode &&
 	test_must_fail git hash-object -t tree tree-with-malformed-mode 2>err &&
-	grep "malformed mode in tree entry" err
+	test_grep "malformed mode in tree entry" err
 '
 
 test_expect_success PERL_TEST_HELPERS 'empty filename in tree' '
@@ -218,7 +218,7 @@ test_expect_success PERL_TEST_HELPERS 'empty filename in tree' '
 	bin_oid=$(echo $hex_oid | hex2oct) &&
 	printf "100644 \0$bin_oid" >tree-with-empty-filename &&
 	test_must_fail git hash-object -t tree tree-with-empty-filename 2>err &&
-	grep "empty filename in tree entry" err
+	test_grep "empty filename in tree entry" err
 '
 
 test_expect_success PERL_TEST_HELPERS 'duplicate filename in tree' '
@@ -229,7 +229,7 @@ test_expect_success PERL_TEST_HELPERS 'duplicate filename in tree' '
 		printf "100644 file\0$bin_oid"
 	} >tree-with-duplicate-filename &&
 	test_must_fail git hash-object -t tree tree-with-duplicate-filename 2>err &&
-	grep "duplicateEntries" err
+	test_grep "duplicateEntries" err
 '
 
 test_expect_success 'corrupt commit' '
diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-sparse-checkout.sh
index 742f0fa909..93244ee134 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -196,7 +196,7 @@ test_expect_success 'read-tree will not throw away dirty changes, non-sparse' '
 	echo dirty >init.t &&
 	read_tree_u_must_fail -m -u HEAD^ &&
 	test_path_is_file init.t &&
-	grep -q dirty init.t
+	test_grep -q dirty init.t
 '
 
 test_expect_success 'read-tree will not throw away dirty changes, sparse' '
@@ -207,7 +207,7 @@ test_expect_success 'read-tree will not throw away dirty changes, sparse' '
 	echo sub/added >.git/info/sparse-checkout &&
 	read_tree_u_must_fail -m -u HEAD^ &&
 	test_path_is_file init.t &&
-	grep -q dirty init.t
+	test_grep -q dirty init.t
 '
 
 test_expect_success 'read-tree updates worktree, dirty case' '
@@ -215,7 +215,7 @@ test_expect_success 'read-tree updates worktree, dirty case' '
 	git checkout -f top &&
 	echo dirty >init.t &&
 	read_tree_u_must_fail -m -u HEAD^ &&
-	grep -q dirty init.t &&
+	test_grep -q dirty init.t &&
 	rm init.t
 '
 
@@ -224,7 +224,7 @@ test_expect_success 'read-tree removes worktree, dirty case' '
 	git checkout -f top &&
 	echo dirty >added &&
 	read_tree_u_must_succeed -m -u HEAD^ &&
-	grep -q dirty added
+	test_grep -q dirty added
 '
 
 test_expect_success 'read-tree adds to worktree, absent case' '
@@ -240,7 +240,7 @@ test_expect_success 'read-tree adds to worktree, dirty case' '
 	mkdir sub &&
 	echo dirty >sub/added &&
 	read_tree_u_must_succeed -u -m HEAD^ &&
-	grep -q dirty sub/added
+	test_grep -q dirty sub/added
 '
 
 test_expect_success 'index removal and worktree narrowing at the same time' '
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index 7d40d08521..d295c265c7 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -8,7 +8,7 @@ test_description='adding and checking out large blobs'
 test_expect_success 'core.bigFileThreshold must be non-negative' '
 	: >input &&
 	test_must_fail git -c core.bigFileThreshold=-1 hash-object input >out 2>err &&
-	grep "bad numeric config value" err &&
+	test_grep "bad numeric config value" err &&
 	test_must_be_empty out
 '
 
@@ -148,12 +148,12 @@ test_expect_success 'diff --stat' '
 
 test_expect_success 'diff' '
 	git diff HEAD^ HEAD >actual &&
-	grep "Binary files.*differ" actual
+	test_grep "Binary files.*differ" actual
 '
 
 test_expect_success 'diff --cached' '
 	git diff --cached HEAD^ >actual &&
-	grep "Binary files.*differ" actual
+	test_grep "Binary files.*differ" actual
 '
 
 test_expect_success 'hash-object' '
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index cd0aed9975..74b1761e0c 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -129,7 +129,7 @@ test_expect_success 'switching to cone mode with non-cone mode patterns' '
 		git sparse-checkout add dir &&
 		git config --worktree core.sparseCheckoutCone true &&
 		test_must_fail git sparse-checkout add dir 2>err &&
-		grep "existing sparse-checkout patterns do not use cone mode" err
+		test_grep "existing sparse-checkout patterns do not use cone mode" err
 	)
 '
 
@@ -803,7 +803,7 @@ test_expect_success 'cone mode clears ignored subdirectories' '
 	# When an untracked file is in the way, all untracked files
 	# (even ignored files) are preserved.
 	git -C repo sparse-checkout set folder1 2>err &&
-	grep "contains untracked files" err &&
+	test_grep "contains untracked files" err &&
 	test_path_is_file repo/deep/deeper2/ignored.o &&
 	test_path_is_file repo/deep/deeper2/untracked &&
 
@@ -882,8 +882,8 @@ test_expect_success 'malformed cone-mode patterns' '
 	# of using the cone-mode translation to a set of directories.
 	git -C repo sparse-checkout list >actual 2>err &&
 	test_cmp repo/.git/info/sparse-checkout actual &&
-	grep "warning: your sparse-checkout file may have issues: pattern .* is repeated" err &&
-	grep "warning: disabling cone pattern matching" err
+	test_grep "warning: your sparse-checkout file may have issues: pattern .* is repeated" err &&
+	test_grep "warning: disabling cone pattern matching" err
 '
 
 test_expect_success 'set from subdir pays attention to prefix' '
@@ -917,34 +917,34 @@ test_expect_success 'set from subdir in non-cone mode throws an error' '
 	git -C repo sparse-checkout disable &&
 	test_must_fail git -C repo/deep sparse-checkout set --no-cone deeper2 ../folder1 2>error &&
 
-	grep "run from the toplevel directory in non-cone mode" error
+	test_grep "run from the toplevel directory in non-cone mode" error
 '
 
 test_expect_success 'set from subdir in non-cone mode throws an error' '
 	git -C repo sparse-checkout set --no-cone deep/deeper2 &&
 	test_must_fail git -C repo/deep sparse-checkout add deeper1/deepest ../folder1 2>error &&
 
-	grep "run from the toplevel directory in non-cone mode" error
+	test_grep "run from the toplevel directory in non-cone mode" error
 '
 
 test_expect_success 'by default, cone mode will error out when passed files' '
 	git -C repo sparse-checkout reapply --cone &&
 	test_must_fail git -C repo sparse-checkout add .gitignore 2>error &&
 
-	grep ".gitignore.*is not a directory" error
+	test_grep ".gitignore.*is not a directory" error
 '
 
 test_expect_success 'error on mistyped command line options' '
 	test_must_fail git -C repo sparse-checkout add --sikp-checks .gitignore 2>error &&
 
-	grep "unknown option.*sikp-checks" error
+	test_grep "unknown option.*sikp-checks" error
 '
 
 test_expect_success 'by default, non-cone mode will warn on individual files' '
 	git -C repo sparse-checkout reapply --no-cone &&
 	git -C repo sparse-checkout add .gitignore 2>warning &&
 
-	grep "pass a leading slash before paths.*if you want a single file" warning
+	test_grep "pass a leading slash before paths.*if you want a single file" warning
 '
 
 test_expect_success 'setup bare repo' '
@@ -1108,11 +1108,11 @@ test_expect_success 'clean' '
 	touch repo/folder1/extra/inside/file &&
 
 	test_must_fail git -C repo sparse-checkout clean 2>err &&
-	grep "refusing to clean" err &&
+	test_grep "refusing to clean" err &&
 
 	git -C repo config clean.requireForce true &&
 	test_must_fail git -C repo sparse-checkout clean 2>err &&
-	grep "refusing to clean" err &&
+	test_grep "refusing to clean" err &&
 
 	cat >expect <<-\EOF &&
 	Would remove deep/deeper2/
@@ -1255,7 +1255,7 @@ test_expect_success 'sparse-checkout operations with merge conflicts' '
 		test_must_fail git merge -m "will-conflict" right &&
 
 		test_must_fail git sparse-checkout clean -f 2>err &&
-		grep "failed to convert index to a sparse index" err &&
+		test_grep "failed to convert index to a sparse index" err &&
 
 		echo merged >folder1/even/more/dirs/file &&
 		git add --sparse folder1 &&
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 8186da5c88..9814431cd7 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -454,10 +454,10 @@ test_expect_success 'add outside sparse cone' '
 	run_on_sparse ../edit-contents folder1/a &&
 	run_on_sparse ../edit-contents folder1/newfile &&
 	test_sparse_match test_must_fail git add folder1/a &&
-	grep "Disable or modify the sparsity rules" sparse-checkout-err &&
+	test_grep "Disable or modify the sparsity rules" sparse-checkout-err &&
 	test_sparse_unstaged folder1/a &&
 	test_sparse_match test_must_fail git add folder1/newfile &&
-	grep "Disable or modify the sparsity rules" sparse-checkout-err &&
+	test_grep "Disable or modify the sparsity rules" sparse-checkout-err &&
 	test_sparse_unstaged folder1/newfile
 '
 
@@ -509,13 +509,13 @@ test_expect_success 'status/add: outside sparse cone' '
 
 	# Adding the path outside of the sparse-checkout cone should fail.
 	test_sparse_match test_must_fail git add folder1/a &&
-	grep "Disable or modify the sparsity rules" sparse-checkout-err &&
+	test_grep "Disable or modify the sparsity rules" sparse-checkout-err &&
 	test_sparse_unstaged folder1/a &&
 	test_all_match git add --refresh folder1/a &&
 	test_must_be_empty sparse-checkout-err &&
 	test_sparse_unstaged folder1/a &&
 	test_sparse_match test_must_fail git add folder1/new &&
-	grep "Disable or modify the sparsity rules" sparse-checkout-err &&
+	test_grep "Disable or modify the sparsity rules" sparse-checkout-err &&
 	test_sparse_unstaged folder1/new &&
 	test_sparse_match git add --sparse folder1/a &&
 	test_sparse_match git add --sparse folder1/new &&
@@ -661,8 +661,8 @@ test_expect_success 'checkout and reset (mixed)' '
 	# in sparse-checkout or sparse-index.
 	git -C full-checkout reset update-folder1 >full-checkout-out &&
 	test_sparse_match git reset update-folder1 &&
-	grep "M	folder1/a" full-checkout-out &&
-	! grep "M	folder1/a" sparse-checkout-out &&
+	test_grep "M	folder1/a" full-checkout-out &&
+	test_grep ! "M	folder1/a" sparse-checkout-out &&
 	run_on_sparse test_path_is_missing folder1
 '
 
@@ -880,8 +880,8 @@ test_expect_success 'update-index with directories' '
 	# update-index will exit silently when provided with a directory name
 	# containing a trailing slash
 	test_all_match git update-index deep/ folder1/ &&
-	grep "Ignoring path deep/" sparse-checkout-err &&
-	grep "Ignoring path folder1/" sparse-checkout-err &&
+	test_grep "Ignoring path deep/" sparse-checkout-err &&
+	test_grep "Ignoring path folder1/" sparse-checkout-err &&
 
 	# When update-index is given a directory name WITHOUT a trailing slash, it will
 	# behave in different ways depending on the status of the directory on disk:
@@ -1067,7 +1067,7 @@ test_expect_success 'merge with conflict outside cone' '
 
 	# 2. Add the file with conflict markers
 	test_sparse_match test_must_fail git add folder1/a &&
-	grep "Disable or modify the sparsity rules" sparse-checkout-err &&
+	test_grep "Disable or modify the sparsity rules" sparse-checkout-err &&
 	test_sparse_unstaged folder1/a &&
 	test_all_match git add --sparse folder1/a &&
 	test_all_match git status --porcelain=v2 &&
@@ -1076,7 +1076,7 @@ test_expect_success 'merge with conflict outside cone' '
 	#    accept conflict markers as resolved content.
 	run_on_all mv folder2/a folder2/z &&
 	test_sparse_match test_must_fail git add folder2 &&
-	grep "Disable or modify the sparsity rules" sparse-checkout-err &&
+	test_grep "Disable or modify the sparsity rules" sparse-checkout-err &&
 	test_sparse_unstaged folder2/z &&
 	test_all_match git add --sparse folder2 &&
 	test_all_match git status --porcelain=v2 &&
@@ -1107,7 +1107,7 @@ test_expect_success 'cherry-pick/rebase with conflict outside cone' '
 		# SKIP_WORKTREE bit from the index entry for folder1/a, we should
 		# warn that this is a problematic add.
 		test_sparse_match test_must_fail git add folder1/a &&
-		grep "Disable or modify the sparsity rules" sparse-checkout-err &&
+		test_grep "Disable or modify the sparsity rules" sparse-checkout-err &&
 		test_sparse_unstaged folder1/a &&
 		test_all_match git add --sparse folder1/a &&
 		test_all_match git status --porcelain=v2 &&
@@ -1119,7 +1119,7 @@ test_expect_success 'cherry-pick/rebase with conflict outside cone' '
 		# existing index entry with the SKIP_WORKTREE bit cleared.
 		run_on_all mv folder2/a folder2/z &&
 		test_sparse_match test_must_fail git add folder2 &&
-		grep "Disable or modify the sparsity rules" sparse-checkout-err &&
+		test_grep "Disable or modify the sparsity rules" sparse-checkout-err &&
 		test_sparse_unstaged folder2/z &&
 		test_all_match git add --sparse folder2 &&
 		test_all_match git status --porcelain=v2 &&
@@ -1266,7 +1266,7 @@ test_expect_success 'checkout-index with folders' '
 	run_on_all test_must_fail git checkout-index -f -- folder1/ &&
 	test_cmp full-checkout-err sparse-checkout-err &&
 	! test_cmp full-checkout-err sparse-index-err &&
-	grep "is a sparse directory" sparse-index-err
+	test_grep "is a sparse directory" sparse-index-err
 '
 
 test_expect_success 'checkout-index --all' '
@@ -1374,8 +1374,8 @@ test_expect_success 'submodule handling' '
 	# having a submodule prevents "modules" from collapse
 	test_sparse_match git sparse-checkout set deep/deeper1 &&
 	git -C sparse-index ls-files --sparse --stage >cache &&
-	grep "100644 .*	modules/a" cache &&
-	grep "160000 $(git -C initial-repo rev-parse HEAD) 0	modules/sub" cache
+	test_grep "100644 .*	modules/a" cache &&
+	test_grep "160000 $(git -C initial-repo rev-parse HEAD) 0	modules/sub" cache
 '
 
 test_expect_success 'git apply functionality' '
@@ -1392,7 +1392,7 @@ test_expect_success 'git apply functionality' '
 
 	# Apply a patch to a file outside the sparse definition
 	test_sparse_match test_must_fail git apply ../patch-outside &&
-	grep "No such file or directory" sparse-checkout-err &&
+	test_grep "No such file or directory" sparse-checkout-err &&
 
 	# But it works with --index and --cached
 	test_all_match git apply --index --stat ../patch-outside &&
@@ -2013,9 +2013,9 @@ test_expect_success 'mv directory from out-of-cone to in-cone' '
 	test_all_match git status --porcelain=v2 &&
 	test_sparse_match git ls-files -t &&
 	git -C sparse-checkout ls-files -t >actual &&
-	grep -e "H deep/folder1/0/0/0" actual &&
-	grep -e "H deep/folder1/0/1" actual &&
-	grep -e "H deep/folder1/a" actual &&
+	test_grep -e "H deep/folder1/0/0/0" actual &&
+	test_grep -e "H deep/folder1/0/1" actual &&
+	test_grep -e "H deep/folder1/a" actual &&
 
 	test_all_match git reset --hard &&
 
@@ -2025,8 +2025,8 @@ test_expect_success 'mv directory from out-of-cone to in-cone' '
 	test_sparse_match git status --porcelain=v2 &&
 	test_sparse_match git ls-files -t &&
 	git -C sparse-checkout ls-files -t >actual &&
-	grep -e "H deep/0/0/0" actual &&
-	grep -e "H deep/0/1" actual
+	test_grep -e "H deep/0/0/0" actual &&
+	test_grep -e "H deep/0/1" actual
 '
 
 test_expect_success 'rm pathspec inside sparse definition' '
@@ -2517,7 +2517,7 @@ test_expect_success 'advice.sparseIndexExpanded' '
 	mkdir -p sparse-index/deep/deeper2/deepest &&
 	touch sparse-index/deep/deeper2/deepest/bogus &&
 	git -C sparse-index status 2>err &&
-	grep "The sparse index is expanding to a full index" err &&
+	test_grep "The sparse index is expanding to a full index" err &&
 
 	git -C sparse-index sparse-checkout disable 2>err &&
 	test_line_count = 0 err
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 87ca11a127..b99f782d5d 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -856,7 +856,7 @@ test_expect_success 'renaming a section with an overly-long line' '
 		printf "[a] g = h\\n"
 	} >y &&
 	test_must_fail git config ${mode_prefix}rename-section -f y a xyz 2>err &&
-	grep "refusing to work with overly long line in .y. on line 2" err
+	test_grep "refusing to work with overly long line in .y. on line 2" err
 '
 
 cat >> .git/config << EOF
@@ -1671,9 +1671,9 @@ test_expect_success 'git --config-env=key=envvar support' '
 
 test_expect_success 'git --config-env with missing value' '
 	test_must_fail env ENVVAR=value git --config-env 2>error &&
-	grep "no config key given for --config-env" error &&
+	test_grep "no config key given for --config-env" error &&
 	test_must_fail env ENVVAR=value git --config-env config core.name 2>error &&
-	grep "invalid config format: config" error
+	test_grep "invalid config format: config" error
 '
 
 test_expect_success 'git --config-env fails with invalid parameters' '
@@ -2104,7 +2104,7 @@ test_expect_success '--unset last key removes section (except if commented)' '
 	key = true
 	EOF
 	git config ${mode_unset} two.key &&
-	! grep two .git/config &&
+	test_grep ! two .git/config &&
 
 	q_to_tab >.git/config <<-\EOF &&
 	[one]
@@ -2124,7 +2124,7 @@ test_expect_success '--unset last key removes section (except if commented)' '
 	Qkey = true
 	EOF
 	git config ${mode_unset} two.key &&
-	grep two .git/config &&
+	test_grep two .git/config &&
 
 	q_to_tab >.git/config <<-\EOF &&
 	[one]
@@ -2655,7 +2655,7 @@ test_expect_success '--type rejects unknown specifiers' '
 
 test_expect_success '--type=int requires at least one digit' '
 	test_must_fail git config --type int --default m some.key >out 2>error &&
-	grep "bad numeric config value" error &&
+	test_grep "bad numeric config value" error &&
 	test_must_be_empty out
 '
 
@@ -2967,12 +2967,12 @@ test_expect_success 'includeIf.hasconfig:remote.*.url forbids remote url in such
 
 	# test with any Git command
 	test_must_fail git -C hasremoteurlTest status 2>err &&
-	grep "fatal: remote URLs cannot be configured in file directly or indirectly included by includeIf.hasconfig:remote.*.url" err
+	test_grep "fatal: remote URLs cannot be configured in file directly or indirectly included by includeIf.hasconfig:remote.*.url" err
 '
 
 test_expect_success 'negated mode causes failure' '
 	test_must_fail git config --no-get 2>err &&
-	grep "unknown option \`no-get${SQ}" err
+	test_grep "unknown option \`no-get${SQ}" err
 '
 
 test_expect_success 'specifying multiple modes causes failure' '
diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index f3892578e4..f6115269f9 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -353,7 +353,7 @@ test_expect_success 'include cycles are detected' '
 	git -C cycle --git-dir=. config include.path cycle &&
 	git config -f cycle/cycle include.path config &&
 	test_must_fail git -C cycle --git-dir=. config --get-all test.value 2>stderr &&
-	grep "exceeded maximum include depth" stderr
+	test_grep "exceeded maximum include depth" stderr
 '
 
 test_expect_success 'onbranch with unborn branch' '
diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index e0e49053f0..de95161a83 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -180,7 +180,7 @@ test_expect_success 'find integer if value is non parse-able' '
 
 test_expect_success 'non parse-able integer value during iteration' '
 	check_config expect_code 128 git_config_int lamb.head 2>result &&
-	grep "fatal: bad numeric config value .* in file \.git/config" result
+	test_grep "fatal: bad numeric config value .* in file \.git/config" result
 '
 
 test_expect_success 'find bool value for the entered key' '
@@ -302,7 +302,7 @@ test_expect_success 'proper error on directory "files"' '
 	echo "Error (-1) reading configuration file a-directory." >expect &&
 	mkdir a-directory &&
 	test_expect_code 2 test-tool config configset_get_value foo.bar a-directory 2>output &&
-	grep "^warning:" output &&
+	test_grep "^warning:" output &&
 	grep "^Error" output >actual &&
 	test_cmp expect actual
 '
@@ -312,7 +312,7 @@ test_expect_success POSIXPERM,SANITY 'proper error on non-accessible files' '
 	test_when_finished "chmod +r .git/config" &&
 	echo "Error (-1) reading configuration file .git/config." >expect &&
 	test_expect_code 2 test-tool config configset_get_value foo.bar .git/config 2>output &&
-	grep "^warning:" output &&
+	test_grep "^warning:" output &&
 	grep "^Error" output >actual &&
 	test_cmp expect actual
 '
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index f059d63e38..c3b02ae1d2 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -92,7 +92,7 @@ test_expect_success "deleting current branch adds message to HEAD's log" '
 	git update-ref -m delete-$m -d $m &&
 	test_must_fail git show-ref --verify -q $m &&
 	test-tool ref-store main for-each-reflog-ent HEAD >actual &&
-	grep "delete-$m$" actual
+	test_grep "delete-$m$" actual
 '
 
 test_expect_success "deleting by HEAD adds message to HEAD's log" '
@@ -102,7 +102,7 @@ test_expect_success "deleting by HEAD adds message to HEAD's log" '
 	git update-ref -m delete-by-head -d HEAD &&
 	test_must_fail git show-ref --verify -q $m &&
 	test-tool ref-store main for-each-reflog-ent HEAD >actual &&
-	grep "delete-by-head$" actual
+	test_grep "delete-by-head$" actual
 '
 
 test_expect_success 'update-ref does not create reflogs by default' '
@@ -192,7 +192,10 @@ test_expect_success "move $m (by HEAD)" '
 test_expect_success "delete $m (by HEAD) should remove both packed and loose $m" '
 	test_when_finished "git update-ref -d $m" &&
 	git update-ref -d HEAD $B &&
-	! grep "$m" .git/packed-refs &&
+	if test_have_prereq REFFILES
+	then
+		test_grep ! "$m" .git/packed-refs
+	fi &&
 	test_must_fail git show-ref --verify -q $m
 '
 
@@ -575,103 +578,103 @@ test_expect_success 'stdin works with no input' '
 test_expect_success 'stdin fails on empty line' '
 	echo "" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: empty command in input" err
+	test_grep "fatal: empty command in input" err
 '
 
 test_expect_success 'stdin fails on only whitespace' '
 	echo " " >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: whitespace before command:  " err
+	test_grep "fatal: whitespace before command:  " err
 '
 
 test_expect_success 'stdin fails on leading whitespace' '
 	echo " create $a $m" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: whitespace before command:  create $a $m" err
+	test_grep "fatal: whitespace before command:  create $a $m" err
 '
 
 test_expect_success 'stdin fails on unknown command' '
 	echo "unknown $a" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: unknown command: unknown $a" err
+	test_grep "fatal: unknown command: unknown $a" err
 '
 
 test_expect_success 'stdin fails on unbalanced quotes' '
 	echo "create $a \"main" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: badly quoted argument: \\\"main" err
+	test_grep "fatal: badly quoted argument: \\\"main" err
 '
 
 test_expect_success 'stdin fails on invalid escape' '
 	echo "create $a \"ma\zn\"" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: badly quoted argument: \\\"ma\\\\zn\\\"" err
+	test_grep "fatal: badly quoted argument: \\\"ma\\\\zn\\\"" err
 '
 
 test_expect_success 'stdin fails on junk after quoted argument' '
 	echo "create \"$a\"main" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: unexpected character after quoted argument: \\\"$a\\\"main" err
+	test_grep "fatal: unexpected character after quoted argument: \\\"$a\\\"main" err
 '
 
 test_expect_success 'stdin fails create with no ref' '
 	echo "create " >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: create: missing <ref>" err
+	test_grep "fatal: create: missing <ref>" err
 '
 
 test_expect_success 'stdin fails create with no new value' '
 	echo "create $a" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: create $a: missing <new-oid>" err
+	test_grep "fatal: create $a: missing <new-oid>" err
 '
 
 test_expect_success 'stdin fails create with too many arguments' '
 	echo "create $a $m $m" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: create $a: extra input:  $m" err
+	test_grep "fatal: create $a: extra input:  $m" err
 '
 
 test_expect_success 'stdin fails update with no ref' '
 	echo "update " >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: update: missing <ref>" err
+	test_grep "fatal: update: missing <ref>" err
 '
 
 test_expect_success 'stdin fails update with no new value' '
 	echo "update $a" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: update $a: missing <new-oid>" err
+	test_grep "fatal: update $a: missing <new-oid>" err
 '
 
 test_expect_success 'stdin fails update with too many arguments' '
 	echo "update $a $m $m $m" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: update $a: extra input:  $m" err
+	test_grep "fatal: update $a: extra input:  $m" err
 '
 
 test_expect_success 'stdin fails delete with no ref' '
 	echo "delete " >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: delete: missing <ref>" err
+	test_grep "fatal: delete: missing <ref>" err
 '
 
 test_expect_success 'stdin fails delete with too many arguments' '
 	echo "delete $a $m $m" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: delete $a: extra input:  $m" err
+	test_grep "fatal: delete $a: extra input:  $m" err
 '
 
 test_expect_success 'stdin fails verify with too many arguments' '
 	echo "verify $a $m $m" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: verify $a: extra input:  $m" err
+	test_grep "fatal: verify $a: extra input:  $m" err
 '
 
 test_expect_success 'stdin fails option with unknown name' '
 	echo "option unknown" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: option unknown: unknown" err
+	test_grep "fatal: option unknown: unknown" err
 '
 
 test_expect_success 'stdin fails with duplicate refs' '
@@ -759,28 +762,28 @@ test_expect_success 'stdin create ref works with path with space to blob' '
 test_expect_success 'stdin update ref fails with wrong old value' '
 	echo "update $c $m $m~1" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: cannot lock ref '"'"'$c'"'"'" err &&
+	test_grep "fatal: cannot lock ref '"'"'$c'"'"'" err &&
 	test_must_fail git rev-parse --verify -q $c
 '
 
 test_expect_success 'stdin update ref fails with bad old value' '
 	echo "update $c $m does-not-exist" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: update $c: invalid <old-oid>: does-not-exist" err &&
+	test_grep "fatal: update $c: invalid <old-oid>: does-not-exist" err &&
 	test_must_fail git rev-parse --verify -q $c
 '
 
 test_expect_success 'stdin create ref fails with bad new value' '
 	echo "create $c does-not-exist" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: create $c: invalid <new-oid>: does-not-exist" err &&
+	test_grep "fatal: create $c: invalid <new-oid>: does-not-exist" err &&
 	test_must_fail git rev-parse --verify -q $c
 '
 
 test_expect_success 'stdin create ref fails with zero new value' '
 	echo "create $c " >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: create $c: zero <new-oid>" err &&
+	test_grep "fatal: create $c: zero <new-oid>" err &&
 	test_must_fail git rev-parse --verify -q $c
 '
 
@@ -795,7 +798,7 @@ test_expect_success 'stdin update ref works with right old value' '
 test_expect_success 'stdin delete ref fails with wrong old value' '
 	echo "delete $a $m~1" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: cannot lock ref '"'"'$a'"'"'" err &&
+	test_grep "fatal: cannot lock ref '"'"'$a'"'"'" err &&
 	git rev-parse $m >expect &&
 	git rev-parse $a >actual &&
 	test_cmp expect actual
@@ -804,7 +807,7 @@ test_expect_success 'stdin delete ref fails with wrong old value' '
 test_expect_success 'stdin delete ref fails with zero old value' '
 	echo "delete $a " >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: delete $a: zero <old-oid>" err &&
+	test_grep "fatal: delete $a: zero <old-oid>" err &&
 	git rev-parse $m >expect &&
 	git rev-parse $a >actual &&
 	test_cmp expect actual
@@ -965,7 +968,7 @@ test_expect_success 'stdin update refs fails with wrong old value' '
 	update $c  ''
 	EOF
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: cannot lock ref '"'"'$c'"'"'" err &&
+	test_grep "fatal: cannot lock ref '"'"'$c'"'"'" err &&
 	git rev-parse $m >expect &&
 	git rev-parse $a >actual &&
 	test_cmp expect actual &&
@@ -998,123 +1001,123 @@ test_expect_success 'stdin -z works on empty input' '
 test_expect_success 'stdin -z fails on empty line' '
 	echo "" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: whitespace before command: " err
+	test_grep "fatal: whitespace before command: " err
 '
 
 test_expect_success 'stdin -z fails on empty command' '
 	printf $F "" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: empty command in input" err
+	test_grep "fatal: empty command in input" err
 '
 
 test_expect_success 'stdin -z fails on only whitespace' '
 	printf $F " " >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: whitespace before command:  " err
+	test_grep "fatal: whitespace before command:  " err
 '
 
 test_expect_success 'stdin -z fails on leading whitespace' '
 	printf $F " create $a" "$m" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: whitespace before command:  create $a" err
+	test_grep "fatal: whitespace before command:  create $a" err
 '
 
 test_expect_success 'stdin -z fails on unknown command' '
 	printf $F "unknown $a" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: unknown command: unknown $a" err
+	test_grep "fatal: unknown command: unknown $a" err
 '
 
 test_expect_success 'stdin -z fails create with no ref' '
 	printf $F "create " >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: create: missing <ref>" err
+	test_grep "fatal: create: missing <ref>" err
 '
 
 test_expect_success 'stdin -z fails create with no new value' '
 	printf $F "create $a" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: create $a: unexpected end of input when reading <new-oid>" err
+	test_grep "fatal: create $a: unexpected end of input when reading <new-oid>" err
 '
 
 test_expect_success 'stdin -z fails create with too many arguments' '
 	printf $F "create $a" "$m" "$m" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: unknown command: $m" err
+	test_grep "fatal: unknown command: $m" err
 '
 
 test_expect_success 'stdin -z fails update with no ref' '
 	printf $F "update " >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: update: missing <ref>" err
+	test_grep "fatal: update: missing <ref>" err
 '
 
 test_expect_success 'stdin -z fails update with too few args' '
 	printf $F "update $a" "$m" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: update $a: unexpected end of input when reading <old-oid>" err
+	test_grep "fatal: update $a: unexpected end of input when reading <old-oid>" err
 '
 
 test_expect_success 'stdin -z emits warning with empty new value' '
 	git update-ref $a $m &&
 	printf $F "update $a" "" "" >stdin &&
 	git update-ref -z --stdin <stdin 2>err &&
-	grep "warning: update $a: missing <new-oid>, treating as zero" err &&
+	test_grep "warning: update $a: missing <new-oid>, treating as zero" err &&
 	test_must_fail git rev-parse --verify -q $a
 '
 
 test_expect_success 'stdin -z fails update with no new value' '
 	printf $F "update $a" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: update $a: unexpected end of input when reading <new-oid>" err
+	test_grep "fatal: update $a: unexpected end of input when reading <new-oid>" err
 '
 
 test_expect_success 'stdin -z fails update with no old value' '
 	printf $F "update $a" "$m" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: update $a: unexpected end of input when reading <old-oid>" err
+	test_grep "fatal: update $a: unexpected end of input when reading <old-oid>" err
 '
 
 test_expect_success 'stdin -z fails update with too many arguments' '
 	printf $F "update $a" "$m" "$m" "$m" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: unknown command: $m" err
+	test_grep "fatal: unknown command: $m" err
 '
 
 test_expect_success 'stdin -z fails delete with no ref' '
 	printf $F "delete " >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: delete: missing <ref>" err
+	test_grep "fatal: delete: missing <ref>" err
 '
 
 test_expect_success 'stdin -z fails delete with no old value' '
 	printf $F "delete $a" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: delete $a: unexpected end of input when reading <old-oid>" err
+	test_grep "fatal: delete $a: unexpected end of input when reading <old-oid>" err
 '
 
 test_expect_success 'stdin -z fails delete with too many arguments' '
 	printf $F "delete $a" "$m" "$m" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: unknown command: $m" err
+	test_grep "fatal: unknown command: $m" err
 '
 
 test_expect_success 'stdin -z fails verify with too many arguments' '
 	printf $F "verify $a" "$m" "$m" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: unknown command: $m" err
+	test_grep "fatal: unknown command: $m" err
 '
 
 test_expect_success 'stdin -z fails verify with no old value' '
 	printf $F "verify $a" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: verify $a: unexpected end of input when reading <old-oid>" err
+	test_grep "fatal: verify $a: unexpected end of input when reading <old-oid>" err
 '
 
 test_expect_success 'stdin -z fails option with unknown name' '
 	printf $F "option unknown" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: option unknown: unknown" err
+	test_grep "fatal: option unknown: unknown" err
 '
 
 test_expect_success 'stdin -z fails with duplicate refs' '
@@ -1160,14 +1163,14 @@ test_expect_success 'stdin -z create ref works with path with space to blob' '
 test_expect_success 'stdin -z update ref fails with wrong old value' '
 	printf $F "update $c" "$m" "$m~1" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: cannot lock ref '"'"'$c'"'"'" err &&
+	test_grep "fatal: cannot lock ref '"'"'$c'"'"'" err &&
 	test_must_fail git rev-parse --verify -q $c
 '
 
 test_expect_success 'stdin -z update ref fails with bad old value' '
 	printf $F "update $c" "$m" "does-not-exist" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: update $c: invalid <old-oid>: does-not-exist" err &&
+	test_grep "fatal: update $c: invalid <old-oid>: does-not-exist" err &&
 	test_must_fail git rev-parse --verify -q $c
 '
 
@@ -1176,7 +1179,7 @@ test_expect_success 'stdin -z create ref fails when ref exists' '
 	git rev-parse "$c" >expect &&
 	printf $F "create $c" "$m~1" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: cannot lock ref '"'"'$c'"'"'" err &&
+	test_grep "fatal: cannot lock ref '"'"'$c'"'"'" err &&
 	git rev-parse "$c" >actual &&
 	test_cmp expect actual
 '
@@ -1185,28 +1188,28 @@ test_expect_success 'stdin -z create ref fails with bad new value' '
 	git update-ref -d "$c" &&
 	printf $F "create $c" "does-not-exist" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: create $c: invalid <new-oid>: does-not-exist" err &&
+	test_grep "fatal: create $c: invalid <new-oid>: does-not-exist" err &&
 	test_must_fail git rev-parse --verify -q $c
 '
 
 test_expect_success 'stdin -z create ref fails with empty new value' '
 	printf $F "create $c" "" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: create $c: missing <new-oid>" err &&
+	test_grep "fatal: create $c: missing <new-oid>" err &&
 	test_must_fail git rev-parse --verify -q $c
 '
 
 test_expect_success 'stdin -z create ref fails with non commit object' '
 	printf $F "create $c" "$(test_oid 001)" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: trying to write ref ${SQ}$c${SQ} with nonexistent object" err &&
+	test_grep "fatal: trying to write ref ${SQ}$c${SQ} with nonexistent object" err &&
 	test_must_fail git rev-parse --verify -q $c
 '
 
 test_expect_success 'stdin -z update ref fails with non commit object' '
 	printf $F "update $b" "$(test_oid 001)" "" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: trying to write ref ${SQ}$b${SQ} with nonexistent object" err &&
+	test_grep "fatal: trying to write ref ${SQ}$b${SQ} with nonexistent object" err &&
 	test_must_fail git rev-parse --verify -q $c
 '
 
@@ -1221,7 +1224,7 @@ test_expect_success 'stdin -z update ref works with right old value' '
 test_expect_success 'stdin -z delete ref fails with wrong old value' '
 	printf $F "delete $a" "$m~1" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: cannot lock ref '"'"'$a'"'"'" err &&
+	test_grep "fatal: cannot lock ref '"'"'$a'"'"'" err &&
 	git rev-parse $m >expect &&
 	git rev-parse $a >actual &&
 	test_cmp expect actual
@@ -1230,7 +1233,7 @@ test_expect_success 'stdin -z delete ref fails with wrong old value' '
 test_expect_success 'stdin -z delete ref fails with zero old value' '
 	printf $F "delete $a" "$Z" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: delete $a: zero <old-oid>" err &&
+	test_grep "fatal: delete $a: zero <old-oid>" err &&
 	git rev-parse $m >expect &&
 	git rev-parse $a >actual &&
 	test_cmp expect actual
@@ -1336,7 +1339,7 @@ test_expect_success 'stdin -z update refs fails with wrong old value' '
 	git update-ref $c $m &&
 	printf $F "update $a" "$m" "$m" "update $b" "$m" "$m" "update $c" "$m" "$Z" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: cannot lock ref '"'"'$c'"'"'" err &&
+	test_grep "fatal: cannot lock ref '"'"'$c'"'"'" err &&
 	git rev-parse $m >expect &&
 	git rev-parse $a >actual &&
 	test_cmp expect actual &&
@@ -1415,13 +1418,13 @@ test_expect_success 'handle per-worktree refs in refs/bisect' '
 		cd worktree &&
 		git commit --allow-empty -m "test commit"  &&
 		git for-each-ref >for-each-ref.out &&
-		! grep refs/bisect for-each-ref.out &&
+		test_grep ! refs/bisect for-each-ref.out &&
 		git update-ref refs/bisect/something HEAD &&
 		git rev-parse refs/bisect/something >../worktree-head &&
 		git for-each-ref | grep refs/bisect/something
 	) &&
 	git show-ref >actual &&
-	! grep 'refs/bisect' actual &&
+	test_grep ! 'refs/bisect' actual &&
 	test_must_fail git rev-parse refs/bisect/something &&
 	git update-ref refs/bisect/something HEAD &&
 	git rev-parse refs/bisect/something >main-head &&
@@ -1477,7 +1480,7 @@ test_expect_success 'transaction exits on multiple aborts' '
 	test_must_fail git update-ref --stdin <stdin >actual 2>err &&
 	printf "%s: ok\n" abort >expect &&
 	test_cmp expect actual &&
-	grep "fatal: transaction is closed" err
+	test_grep "fatal: transaction is closed" err
 '
 
 test_expect_success 'transaction exits on start after prepare' '
@@ -1488,7 +1491,7 @@ test_expect_success 'transaction exits on start after prepare' '
 	test_must_fail git update-ref --stdin <stdin 2>err >actual &&
 	printf "%s: ok\n" prepare >expect &&
 	test_cmp expect actual &&
-	grep "fatal: prepared transactions can only be closed" err
+	test_grep "fatal: prepared transactions can only be closed" err
 '
 
 test_expect_success 'transaction handles empty abort with missing prepare' '
@@ -1649,7 +1652,7 @@ test_expect_success PIPE 'transaction flushes status updates' '
 
 	# This must now fail given that we have locked the ref.
 	test_must_fail git update-ref refs/heads/flush $B 2>stderr &&
-	grep "fatal: update_ref failed for ref ${SQ}refs/heads/flush${SQ}: cannot lock ref" stderr &&
+	test_grep "fatal: update_ref failed for ref ${SQ}refs/heads/flush${SQ}: cannot lock ref" stderr &&
 
 	echo commit >&9 &&
 	echo "commit: ok" >expected &&
@@ -1675,7 +1678,7 @@ do
 		git symbolic-ref refs/heads/symref $a &&
 		format_command $type "symref-verify refs/heads/symref" "$a" >stdin &&
 		test_must_fail git update-ref --stdin $type <stdin 2>err &&
-		grep "fatal: symref-verify: cannot operate with deref mode" err
+		test_grep "fatal: symref-verify: cannot operate with deref mode" err
 	'
 
 	test_expect_success "stdin $type symref-verify fails with too many arguments" '
@@ -1683,9 +1686,9 @@ do
 		test_must_fail git update-ref --stdin $type --no-deref <stdin 2>err  &&
 		if test "$type" = "-z"
 		then
-			grep "fatal: unknown command: $a" err
+			test_grep "fatal: unknown command: $a" err
 		else
-			grep "fatal: symref-verify refs/heads/symref: extra input:  $a" err
+			test_grep "fatal: symref-verify refs/heads/symref: extra input:  $a" err
 		fi
 	'
 
@@ -1718,7 +1721,7 @@ do
 		test-tool ref-store main for-each-reflog-ent refs/heads/symref >before &&
 		format_command $type "symref-verify refs/heads/missing" "refs/heads/unknown" >stdin &&
 		test_must_fail git update-ref --stdin $type --no-deref <stdin 2>err &&
-		grep "fatal: cannot lock ref ${SQ}refs/heads/missing${SQ}: unable to resolve reference ${SQ}refs/heads/missing${SQ}" err &&
+		test_grep "fatal: cannot lock ref ${SQ}refs/heads/missing${SQ}: unable to resolve reference ${SQ}refs/heads/missing${SQ}" err &&
 		test_must_fail git rev-parse --verify -q refs/heads/missing &&
 		test-tool ref-store main for-each-reflog-ent refs/heads/symref >after &&
 		test_cmp before after
@@ -1744,13 +1747,13 @@ do
 		git symbolic-ref refs/heads/symref $a &&
 		format_command $type "symref-delete refs/heads/symref" "$a" >stdin &&
 		test_must_fail git update-ref --stdin $type <stdin 2>err &&
-		grep "fatal: symref-delete: cannot operate with deref mode" err
+		test_grep "fatal: symref-delete: cannot operate with deref mode" err
 	'
 
 	test_expect_success "stdin $type symref-delete fails with no ref" '
 		format_command $type "symref-delete " >stdin &&
 		test_must_fail git update-ref --stdin $type --no-deref <stdin 2>err &&
-		grep "fatal: symref-delete: missing <ref>" err
+		test_grep "fatal: symref-delete: missing <ref>" err
 	'
 
 	test_expect_success "stdin $type symref-delete fails deleting regular ref" '
@@ -1758,7 +1761,7 @@ do
 		git update-ref refs/heads/regularref $a &&
 		format_command $type "symref-delete refs/heads/regularref" "$a" >stdin &&
 		test_must_fail git update-ref --stdin $type --no-deref <stdin 2>err &&
-		grep "fatal: cannot lock ref ${SQ}refs/heads/regularref${SQ}: expected symref with target ${SQ}$a${SQ}: but is a regular ref" err
+		test_grep "fatal: cannot lock ref ${SQ}refs/heads/regularref${SQ}: expected symref with target ${SQ}$a${SQ}: but is a regular ref" err
 	'
 
 	test_expect_success "stdin $type symref-delete fails with too many arguments" '
@@ -1766,16 +1769,16 @@ do
 		test_must_fail git update-ref --stdin $type --no-deref <stdin 2>err &&
 		if test "$type" = "-z"
 		then
-			grep "fatal: unknown command: $a" err
+			test_grep "fatal: unknown command: $a" err
 		else
-			grep "fatal: symref-delete refs/heads/symref: extra input:  $a" err
+			test_grep "fatal: symref-delete refs/heads/symref: extra input:  $a" err
 		fi
 	'
 
 	test_expect_success "stdin $type symref-delete fails with wrong old value" '
 		format_command $type "symref-delete refs/heads/symref" "$m" >stdin &&
 		test_must_fail git update-ref --stdin $type --no-deref <stdin 2>err &&
-		grep "fatal: verifying symref target: ${SQ}refs/heads/symref${SQ}: is at $a but expected refs/heads/main" err &&
+		test_grep "fatal: verifying symref target: ${SQ}refs/heads/symref${SQ}: is at $a but expected refs/heads/main" err &&
 		git symbolic-ref refs/heads/symref >expect &&
 		echo $a >actual &&
 		test_cmp expect actual
@@ -1813,9 +1816,9 @@ do
 		test_must_fail git update-ref --stdin $type --no-deref <stdin 2>err &&
 		if test "$type" = "-z"
 		then
-			grep "fatal: unknown command: $a" err
+			test_grep "fatal: unknown command: $a" err
 		else
-			grep "fatal: symref-create refs/heads/symref: extra input:  $a" err
+			test_grep "fatal: symref-create refs/heads/symref: extra input:  $a" err
 		fi
 	'
 
@@ -1878,16 +1881,16 @@ do
 		test_must_fail git update-ref --stdin $type --no-deref <stdin 2>err &&
 		if test "$type" = "-z"
 		then
-			grep "fatal: unknown command: $a" err
+			test_grep "fatal: unknown command: $a" err
 		else
-			grep "fatal: symref-update refs/heads/symref: extra input:  $a" err
+			test_grep "fatal: symref-update refs/heads/symref: extra input:  $a" err
 		fi
 	'
 
 	test_expect_success "stdin $type symref-update fails with wrong old value argument" '
 		format_command $type "symref-update refs/heads/symref" "$a" "foo" "$a" "$a" >stdin &&
 		test_must_fail git update-ref --stdin $type --no-deref <stdin 2>err &&
-		grep "fatal: symref-update refs/heads/symref: invalid arg ${SQ}foo${SQ} for old value" err
+		test_grep "fatal: symref-update refs/heads/symref: invalid arg ${SQ}foo${SQ} for old value" err
 	'
 
 	test_expect_success "stdin $type symref-update creates with zero old value" '
@@ -1923,7 +1926,7 @@ do
 		git symbolic-ref refs/heads/symref $a &&
 		format_command $type "symref-update refs/heads/symref" "$m" "ref" "$b" >stdin &&
 		test_must_fail git update-ref --stdin $type --no-deref <stdin 2>err &&
-		grep "fatal: verifying symref target: ${SQ}refs/heads/symref${SQ}: is at $a but expected $b" err &&
+		test_grep "fatal: verifying symref target: ${SQ}refs/heads/symref${SQ}: is at $a but expected $b" err &&
 		test_must_fail git rev-parse --verify -q $c
 	'
 
@@ -1998,7 +2001,7 @@ do
 		git symbolic-ref --no-recurse refs/heads/symref >actual &&
 		test_cmp expect actual &&
 		test-tool ref-store main for-each-reflog-ent refs/heads/symref >actual &&
-		grep "$Z $(git rev-parse $a)" actual
+		test_grep "$Z $(git rev-parse $a)" actual
 	'
 
 	test_expect_success "stdin $type symref-update regular ref to symref with correct old-oid" '
@@ -2010,7 +2013,7 @@ do
 		git symbolic-ref --no-recurse refs/heads/regularref >actual &&
 		test_cmp expect actual &&
 		test-tool ref-store main for-each-reflog-ent refs/heads/regularref >actual &&
-		grep "$(git rev-parse $a) $(git rev-parse $a)" actual
+		test_grep "$(git rev-parse $a) $(git rev-parse $a)" actual
 	'
 
 	test_expect_success "stdin $type symref-update regular ref to symref fails with wrong old-oid" '
@@ -2018,7 +2021,7 @@ do
 		git update-ref --no-deref refs/heads/regularref $a &&
 		format_command $type "symref-update refs/heads/regularref" "$a" "oid" "$(git rev-parse refs/heads/target2)" >stdin &&
 		test_must_fail git update-ref --stdin $type <stdin 2>err &&
-		grep "fatal: cannot lock ref ${SQ}refs/heads/regularref${SQ}: is at $(git rev-parse $a) but expected $(git rev-parse refs/heads/target2)" err &&
+		test_grep "fatal: cannot lock ref ${SQ}refs/heads/regularref${SQ}: is at $(git rev-parse $a) but expected $(git rev-parse refs/heads/target2)" err &&
 		echo $(git rev-parse $a) >expect &&
 		git rev-parse refs/heads/regularref >actual &&
 		test_cmp expect actual
@@ -2029,7 +2032,7 @@ do
 		git update-ref --no-deref refs/heads/regularref $a &&
 		format_command $type "symref-update refs/heads/regularref" "$a" "oid" "not-a-ref-oid" >stdin &&
 		test_must_fail git update-ref --stdin $type <stdin 2>err &&
-		grep "fatal: symref-update refs/heads/regularref: invalid oid: not-a-ref-oid" err &&
+		test_grep "fatal: symref-update refs/heads/regularref: invalid oid: not-a-ref-oid" err &&
 		echo $(git rev-parse $a) >expect &&
 		git rev-parse refs/heads/regularref >actual &&
 		test_cmp expect actual
@@ -2040,7 +2043,7 @@ do
 		git symbolic-ref refs/heads/symref refs/heads/target2 &&
 		format_command $type "symref-update refs/heads/symref" "$a" "oid" "$Z" >stdin &&
 		test_must_fail git update-ref --stdin $type <stdin 2>err &&
-		grep "fatal: cannot lock ref ${SQ}refs/heads/symref${SQ}: reference already exists" err &&
+		test_grep "fatal: cannot lock ref ${SQ}refs/heads/symref${SQ}: reference already exists" err &&
 		echo refs/heads/target2 >expect &&
 		git symbolic-ref refs/heads/symref >actual &&
 		test_cmp expect actual
@@ -2060,7 +2063,7 @@ do
 		git symbolic-ref --no-recurse refs/heads/symref >actual &&
 		test_cmp expect actual &&
 		test-tool ref-store main for-each-reflog-ent refs/heads/symref >actual &&
-		grep "$(git rev-parse $a) $(git rev-parse $a)" actual
+		test_grep "$(git rev-parse $a) $(git rev-parse $a)" actual
 	'
 
 	test_expect_success "stdin $type symref-update regular ref to symref" '
@@ -2072,7 +2075,7 @@ do
 		git symbolic-ref --no-recurse refs/heads/regularref >actual &&
 		test_cmp expect actual &&
 		test-tool ref-store main for-each-reflog-ent refs/heads/regularref >actual &&
-		grep "$(git rev-parse $a) $(git rev-parse $a)" actual
+		test_grep "$(git rev-parse $a) $(git rev-parse $a)" actual
 	'
 
 	test_expect_success "stdin $type batch-updates" '
diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
index 36c903ca19..7ce5af4ab8 100755
--- a/t/t1403-show-ref.sh
+++ b/t/t1403-show-ref.sh
@@ -213,19 +213,19 @@ test_expect_success 'show-ref --verify with dangling ref' '
 
 test_expect_success 'show-ref sub-modes are mutually exclusive' '
 	test_must_fail git show-ref --verify --exclude-existing 2>err &&
-	grep "verify" err &&
-	grep "exclude-existing" err &&
-	grep "cannot be used together" err &&
+	test_grep "verify" err &&
+	test_grep "exclude-existing" err &&
+	test_grep "cannot be used together" err &&
 
 	test_must_fail git show-ref --verify --exists 2>err &&
-	grep "verify" err &&
-	grep "exists" err &&
-	grep "cannot be used together" err &&
+	test_grep "verify" err &&
+	test_grep "exists" err &&
+	test_grep "cannot be used together" err &&
 
 	test_must_fail git show-ref --exclude-existing --exists 2>err &&
-	grep "exclude-existing" err &&
-	grep "exists" err &&
-	grep "cannot be used together" err
+	test_grep "exclude-existing" err &&
+	test_grep "exists" err &&
+	test_grep "cannot be used together" err
 '
 
 test_done
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index ce71f9a30a..81de1d40eb 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -108,12 +108,12 @@ test_expect_success setup '
 
 test_expect_success 'correct usage on sub-command -h' '
 	test_expect_code 129 git reflog expire -h >err &&
-	grep "git reflog expire" err
+	test_grep "git reflog expire" err
 '
 
 test_expect_success 'correct usage on "git reflog show -h"' '
 	test_expect_code 129 git reflog show -h >err &&
-	grep -F "git reflog [show]" err
+	test_grep -F "git reflog [show]" err
 '
 
 test_expect_success 'pass through -- to sub-command' '
diff --git a/t/t1415-worktree-refs.sh b/t/t1415-worktree-refs.sh
index 51d79bae83..6b2ad04aef 100755
--- a/t/t1415-worktree-refs.sh
+++ b/t/t1415-worktree-refs.sh
@@ -32,7 +32,7 @@ test_expect_success 'ambiguous main-worktree/HEAD' '
 	test_when_finished git update-ref -d refs/heads/main-worktree/HEAD &&
 	git update-ref refs/heads/main-worktree/HEAD $(git rev-parse HEAD) &&
 	git rev-parse main-worktree/HEAD 2>warn &&
-	grep "main-worktree/HEAD.*ambiguous" warn
+	test_grep "main-worktree/HEAD.*ambiguous" warn
 '
 
 test_expect_success 'resolve worktrees/xx/HEAD' '
@@ -45,7 +45,7 @@ test_expect_success 'ambiguous worktrees/xx/HEAD' '
 	git update-ref refs/heads/worktrees/wt1/HEAD $(git rev-parse HEAD) &&
 	test_when_finished git update-ref -d refs/heads/worktrees/wt1/HEAD &&
 	git rev-parse worktrees/wt1/HEAD 2>warn &&
-	grep "worktrees/wt1/HEAD.*ambiguous" warn
+	test_grep "worktrees/wt1/HEAD.*ambiguous" warn
 '
 
 test_expect_success 'reflog of main-worktree/HEAD' '
diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
index 3ab65f72cd..1ed4c7d2c2 100755
--- a/t/t1430-bad-ref-name.sh
+++ b/t/t1430-bad-ref-name.sh
@@ -47,7 +47,7 @@ test_expect_success 'git branch shows badly named ref as warning' '
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
 	git branch >output 2>error &&
 	test_grep -e "ignoring ref with broken name refs/heads/broken\.\.\.ref" error &&
-	! grep -e "broken\.\.\.ref" output
+	test_grep ! -e "broken\.\.\.ref" output
 '
 
 test_expect_success 'branch -d can delete badly named ref' '
@@ -55,8 +55,8 @@ test_expect_success 'branch -d can delete badly named ref' '
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
 	git branch -d broken...ref &&
 	git branch >output 2>error &&
-	! grep -e "broken\.\.\.ref" error &&
-	! grep -e "broken\.\.\.ref" output
+	test_grep ! -e "broken\.\.\.ref" error &&
+	test_grep ! -e "broken\.\.\.ref" output
 '
 
 test_expect_success 'branch -D can delete badly named ref' '
@@ -64,8 +64,8 @@ test_expect_success 'branch -D can delete badly named ref' '
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
 	git branch -D broken...ref &&
 	git branch >output 2>error &&
-	! grep -e "broken\.\.\.ref" error &&
-	! grep -e "broken\.\.\.ref" output
+	test_grep ! -e "broken\.\.\.ref" error &&
+	test_grep ! -e "broken\.\.\.ref" output
 '
 
 test_expect_success 'branch -D cannot delete non-ref in .git dir' '
@@ -93,8 +93,8 @@ test_expect_success 'git branch cannot create a badly named ref' '
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
 	test_must_fail git branch broken...ref &&
 	git branch >output 2>error &&
-	! grep -e "broken\.\.\.ref" error &&
-	! grep -e "broken\.\.\.ref" output
+	test_grep ! -e "broken\.\.\.ref" error &&
+	test_grep ! -e "broken\.\.\.ref" output
 '
 
 test_expect_success 'branch -m cannot rename to a bad ref name' '
@@ -104,8 +104,8 @@ test_expect_success 'branch -m cannot rename to a bad ref name' '
 	test_must_fail git branch -m goodref broken...ref &&
 	test_cmp_rev main goodref &&
 	git branch >output 2>error &&
-	! grep -e "broken\.\.\.ref" error &&
-	! grep -e "broken\.\.\.ref" output
+	test_grep ! -e "broken\.\.\.ref" error &&
+	test_grep ! -e "broken\.\.\.ref" output
 '
 
 test_expect_failure 'branch -m can rename from a bad ref name' '
@@ -115,16 +115,16 @@ test_expect_failure 'branch -m can rename from a bad ref name' '
 	git branch -m broken...ref renamed &&
 	test_cmp_rev main renamed &&
 	git branch >output 2>error &&
-	! grep -e "broken\.\.\.ref" error &&
-	! grep -e "broken\.\.\.ref" output
+	test_grep ! -e "broken\.\.\.ref" error &&
+	test_grep ! -e "broken\.\.\.ref" output
 '
 
 test_expect_success 'push cannot create a badly named ref' '
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
 	test_must_fail git push "file://$(pwd)" HEAD:refs/heads/broken...ref &&
 	git branch >output 2>error &&
-	! grep -e "broken\.\.\.ref" error &&
-	! grep -e "broken\.\.\.ref" output
+	test_grep ! -e "broken\.\.\.ref" error &&
+	test_grep ! -e "broken\.\.\.ref" output
 '
 
 test_expect_failure 'push --mirror can delete badly named ref' '
@@ -144,8 +144,8 @@ test_expect_failure 'push --mirror can delete badly named ref' '
 	) &&
 	git -C src push --mirror "file://$top/dest" &&
 	git -C dest branch >output 2>error &&
-	! grep -e "broken\.\.\.ref" error &&
-	! grep -e "broken\.\.\.ref" output
+	test_grep ! -e "broken\.\.\.ref" error &&
+	test_grep ! -e "broken\.\.\.ref" output
 '
 
 test_expect_success 'rev-parse skips symref pointing to broken name' '
@@ -168,9 +168,9 @@ test_expect_success 'for-each-ref emits warnings for broken names' '
 	test-tool ref-store main create-symref refs/heads/broken...symref refs/heads/main &&
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...symref" &&
 	git for-each-ref >output 2>error &&
-	! grep -e "broken\.\.\.ref" output &&
-	! grep -e "badname" output &&
-	! grep -e "broken\.\.\.symref" output &&
+	test_grep ! -e "broken\.\.\.ref" output &&
+	test_grep ! -e "badname" output &&
+	test_grep ! -e "broken\.\.\.symref" output &&
 	test_grep "ignoring ref with broken name refs/heads/broken\.\.\.ref" error &&
 	test_grep ! "ignoring broken ref refs/heads/badname" error &&
 	test_grep "ignoring ref with broken name refs/heads/broken\.\.\.symref" error
@@ -183,8 +183,8 @@ test_expect_success 'update-ref -d can delete broken name' '
 	test_must_be_empty output &&
 	test_must_be_empty error &&
 	git branch >output 2>error &&
-	! grep -e "broken\.\.\.ref" error &&
-	! grep -e "broken\.\.\.ref" output
+	test_grep ! -e "broken\.\.\.ref" error &&
+	test_grep ! -e "broken\.\.\.ref" output
 '
 
 test_expect_success 'branch -d can delete broken name' '
@@ -194,8 +194,8 @@ test_expect_success 'branch -d can delete broken name' '
 	test_grep "Deleted branch broken...ref (was broken)" output &&
 	test_must_be_empty error &&
 	git branch >output 2>error &&
-	! grep -e "broken\.\.\.ref" error &&
-	! grep -e "broken\.\.\.ref" output
+	test_grep ! -e "broken\.\.\.ref" error &&
+	test_grep ! -e "broken\.\.\.ref" output
 '
 
 test_expect_success 'update-ref --no-deref -d can delete symref to broken name' '
@@ -313,37 +313,37 @@ test_expect_success 'update-ref -d cannot delete absolute path' '
 test_expect_success 'update-ref --stdin fails create with bad ref name' '
 	echo "create ~a refs/heads/main" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: invalid ref format: ~a" err
+	test_grep "fatal: invalid ref format: ~a" err
 '
 
 test_expect_success 'update-ref --stdin fails update with bad ref name' '
 	echo "update ~a refs/heads/main" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: invalid ref format: ~a" err
+	test_grep "fatal: invalid ref format: ~a" err
 '
 
 test_expect_success 'update-ref --stdin fails delete with bad ref name' '
 	echo "delete ~a refs/heads/main" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: invalid ref format: ~a" err
+	test_grep "fatal: invalid ref format: ~a" err
 '
 
 test_expect_success 'update-ref --stdin -z fails create with bad ref name' '
 	printf "%s\0" "create ~a " refs/heads/main >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: invalid ref format: ~a " err
+	test_grep "fatal: invalid ref format: ~a " err
 '
 
 test_expect_success 'update-ref --stdin -z fails update with bad ref name' '
 	printf "%s\0" "update ~a" refs/heads/main "" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: invalid ref format: ~a" err
+	test_grep "fatal: invalid ref format: ~a" err
 '
 
 test_expect_success 'update-ref --stdin -z fails delete with bad ref name' '
 	printf "%s\0" "delete ~a" refs/heads/main >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: invalid ref format: ~a" err
+	test_grep "fatal: invalid ref format: ~a" err
 '
 
 test_expect_success 'branch rejects HEAD as a branch name' '
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 54e81c2636..47d460a699 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -68,7 +68,7 @@ test_expect_success 'object with hash mismatch' '
 		git update-ref refs/heads/bogus $cmt &&
 
 		test_must_fail git fsck 2>out &&
-		grep "$oldoid: hash-path mismatch, found at: .*$new" out
+		test_grep "$oldoid: hash-path mismatch, found at: .*$new" out
 	)
 '
 
@@ -172,7 +172,7 @@ test_expect_success 'commit with multiple signatures is okay' '
 	test_when_finished "git update-ref -d refs/heads/bogus" &&
 	git fsck 2>out &&
 	cat out &&
-	! grep "commit $new" out
+	test_grep ! "commit $new" out
 '
 
 test_expect_success 'email without @ is okay' '
@@ -183,7 +183,7 @@ test_expect_success 'email without @ is okay' '
 	git update-ref refs/heads/bogus "$new" &&
 	test_when_finished "git update-ref -d refs/heads/bogus" &&
 	git fsck 2>out &&
-	! grep "commit $new" out
+	test_grep ! "commit $new" out
 '
 
 test_expect_success 'email with embedded > is not okay' '
@@ -626,7 +626,7 @@ test_expect_success 'fsck notices excessively large tree entry name' '
 		cd large-name &&
 		test_commit a-long-name &&
 		git -c fsck.largePathname=warn:10 fsck 2>out &&
-		grep "warning.*large pathname" out
+		test_grep "warning.*large pathname" out
 	)
 '
 
@@ -849,7 +849,7 @@ test_expect_success 'fsck errors in packed objects' '
 	test_must_fail git fsck 2>out &&
 	test_grep "error in commit $one.* - bad name" out &&
 	test_grep "error in commit $two.* - bad name" out &&
-	! grep corrupt out
+	test_grep ! corrupt out
 '
 
 test_expect_success 'fsck handles multiple packfiles with big blobs' '
@@ -1027,7 +1027,7 @@ test_expect_success 'bogus head does not fallback to all heads' '
 	test_when_finished "git rm --cached foo" &&
 	remove_object $blob &&
 	test_must_fail git fsck $ZERO_OID >out 2>&1 &&
-	! grep $blob out
+	test_grep ! $blob out
 '
 
 # Corrupt the checksum on the index.
diff --git a/t/t1451-fsck-buffer.sh b/t/t1451-fsck-buffer.sh
index 3a3d33f405..14151eabbd 100755
--- a/t/t1451-fsck-buffer.sh
+++ b/t/t1451-fsck-buffer.sh
@@ -46,7 +46,7 @@ check () {
 			echo "$content"
 		} >input &&
 		test_must_fail git hash-object -t "$type" input 2>err &&
-		grep "$fsck" err
+		test_grep "$fsck" err
 	'
 }
 
@@ -125,7 +125,7 @@ ident_checks tag tagger
 test_expect_success 'truncated tree (short hash)' '
 	printf "100644 foo\0\1\1\1\1" >input &&
 	test_must_fail git hash-object -t tree input 2>err &&
-	grep badTree err
+	test_grep badTree err
 '
 
 test_expect_success 'truncated tree (missing nul)' '
@@ -135,7 +135,7 @@ test_expect_success 'truncated tree (missing nul)' '
 	# parser does not walk past the end of the buffer).
 	printf "100644 a long filename, or a hash with missing nul?" >input &&
 	test_must_fail git hash-object -t tree input 2>err &&
-	grep badTree err
+	test_grep badTree err
 '
 
 test_done
diff --git a/t/t1460-refs-migrate.sh b/t/t1460-refs-migrate.sh
index 5246468024..8f42697143 100755
--- a/t/t1460-refs-migrate.sh
+++ b/t/t1460-refs-migrate.sh
@@ -212,7 +212,7 @@ do
 			test_commit -C repo initial &&
 			git -C repo refs migrate --dry-run \
 				--ref-format=$to_format >output &&
-			grep "Finished dry-run migration of refs" output &&
+			test_grep "Finished dry-run migration of refs" output &&
 			test_path_is_dir repo/.git/ref_migration.* &&
 			echo $from_format >expect &&
 			git -C repo rev-parse --show-ref-format >actual &&
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 38067d95f7..4174ca40c3 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -204,7 +204,7 @@ test_expect_success 'rev-parse --show-object-format in repo' '
 	git rev-parse --show-object-format=output >actual &&
 	test_cmp expect actual &&
 	test_must_fail git rev-parse --show-object-format=squeamish-ossifrage 2>err &&
-	grep "unknown mode for --show-object-format: squeamish-ossifrage" err
+	test_grep "unknown mode for --show-object-format: squeamish-ossifrage" err
 '
 
 
@@ -228,7 +228,7 @@ test_expect_success RUST 'rev-parse --show-object-format in repo with compat mod
 		git rev-parse --show-object-format=compat >actual &&
 		test_cmp expect actual &&
 		test_must_fail git rev-parse --show-object-format=squeamish-ossifrage 2>err &&
-		grep "unknown mode for --show-object-format: squeamish-ossifrage" err
+		test_grep "unknown mode for --show-object-format: squeamish-ossifrage" err
 	) &&
 	mkdir repo2 &&
 	(
@@ -254,7 +254,7 @@ test_expect_success 'rev-parse --show-ref-format with invalid storage' '
 		cd repo &&
 		git config extensions.refstorage broken &&
 		test_must_fail git rev-parse --show-ref-format 2>err &&
-		grep "error: invalid value for ${SQ}extensions.refstorage${SQ}: ${SQ}broken${SQ}" err
+		test_grep "error: invalid value for ${SQ}extensions.refstorage${SQ}: ${SQ}broken${SQ}" err
 	)
 '
 
diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
index 3962f1d288..2cab204376 100755
--- a/t/t1502-rev-parse-parseopt.sh
+++ b/t/t1502-rev-parse-parseopt.sh
@@ -331,7 +331,7 @@ test_expect_success 'ambiguous: --no matches both --noble and --no-noble' '
 	EOF
 	test_expect_code 129 env GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
 	git rev-parse --parseopt -- <spec 2>err --no &&
-	grep "error: ambiguous option: no (could be --noble or --no-noble)" err
+	test_grep "error: ambiguous option: no (could be --noble or --no-noble)" err
 '
 
 test_done
diff --git a/t/t1503-rev-parse-verify.sh b/t/t1503-rev-parse-verify.sh
index 75a708f9ba..87638a4a2c 100755
--- a/t/t1503-rev-parse-verify.sh
+++ b/t/t1503-rev-parse-verify.sh
@@ -62,15 +62,15 @@ test_expect_success 'works with one good rev' '
 
 test_expect_success 'fails with any bad rev or many good revs' '
 	test_must_fail git rev-parse --verify 2>error &&
-	grep "single revision" error &&
+	test_grep "single revision" error &&
 	test_must_fail git rev-parse --verify foo 2>error &&
-	grep "single revision" error &&
+	test_grep "single revision" error &&
 	test_must_fail git rev-parse --verify HEAD bar 2>error &&
-	grep "single revision" error &&
+	test_grep "single revision" error &&
 	test_must_fail git rev-parse --verify baz HEAD 2>error &&
-	grep "single revision" error &&
+	test_grep "single revision" error &&
 	test_must_fail git rev-parse --verify $HASH2 HEAD 2>error &&
-	grep "single revision" error
+	test_grep "single revision" error
 '
 
 test_expect_success 'fails silently when using -q' '
diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index bbfe05b8e4..d330b8df47 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -604,7 +604,7 @@ test_expect_success '#20b/c: core.worktree and core.bare conflict' '
 		cd 20b/.git &&
 		test_must_fail git status >/dev/null
 	) 2>message &&
-	grep "core.bare and core.worktree" message
+	test_grep "core.bare and core.worktree" message
 '
 
 test_expect_success '#20d: core.worktree and core.bare OK when working tree not needed' '
@@ -721,8 +721,8 @@ test_expect_success '#22.2: core.worktree and core.bare conflict' '
 		export GIT_DIR &&
 		test_must_fail git status 2>result
 	) &&
-	grep "core.bare and core.worktree" 22/.git/result &&
-	grep "core.bare and core.worktree" 22/result
+	test_grep "core.bare and core.worktree" 22/.git/result &&
+	test_grep "core.bare and core.worktree" 22/result
 '
 
 # Case #23: GIT_DIR + GIT_WORK_TREE(+core.worktree) suppresses bareness.
@@ -767,7 +767,7 @@ test_expect_success '#28: core.worktree and core.bare conflict (gitfile case)' '
 		cd 28 &&
 		test_must_fail git status
 	) 2>message &&
-	grep "core.bare and core.worktree" message
+	test_grep "core.bare and core.worktree" message
 '
 
 # Case #29: GIT_WORK_TREE(+core.worktree) overrides core.bare (gitfile case).
@@ -791,7 +791,7 @@ test_expect_success '#30: core.worktree and core.bare conflict (gitfile version)
 		cd 30 &&
 		test_must_fail env GIT_DIR=.git git status 2>result
 	) &&
-	grep "core.bare and core.worktree" 30/result
+	test_grep "core.bare and core.worktree" 30/result
 '
 
 # Case #31: GIT_DIR + GIT_WORK_TREE(+core.worktree) suppresses
diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index 1a380a4184..0e6b42ec78 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -378,7 +378,7 @@ test_expect_success 'ambiguous 40-hex ref' '
 	VAL=$(git commit-tree $TREE </dev/null) &&
 	git update-ref refs/heads/$REF $VAL &&
 	test $(git rev-parse $REF 2>err) = $REF &&
-	grep "refname.*${REF}.*ambiguous" err
+	test_grep "refname.*${REF}.*ambiguous" err
 '
 
 test_expect_success 'ambiguous short sha1 ref' '
@@ -387,7 +387,7 @@ test_expect_success 'ambiguous short sha1 ref' '
 	VAL=$(git commit-tree $TREE </dev/null) &&
 	git update-ref refs/heads/$REF $VAL &&
 	test $(git rev-parse $REF 2>err) = $VAL &&
-	grep "refname.*${REF}.*ambiguous" err
+	test_grep "refname.*${REF}.*ambiguous" err
 '
 
 test_expect_success 'ambiguity errors are not repeated (raw)' '
diff --git a/t/t1515-rev-parse-outside-repo.sh b/t/t1515-rev-parse-outside-repo.sh
index 75e89c4b6e..2cb3c7cc9c 100755
--- a/t/t1515-rev-parse-outside-repo.sh
+++ b/t/t1515-rev-parse-outside-repo.sh
@@ -32,7 +32,7 @@ test_expect_success 'rev-parse --local-env-vars' '
 	git rev-parse --local-env-vars >actual &&
 	# we do not want to depend on the complete list here,
 	# so just look for something plausible
-	grep ^GIT_DIR actual
+	test_grep ^GIT_DIR actual
 '
 
 test_expect_success 'rev-parse --resolve-git-dir' '
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 0132e772e4..9aae3ff074 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -79,7 +79,7 @@ test_expect_success 'git hook usage' '
 	test_expect_code 129 git hook run --unknown 2>err &&
 	test_expect_code 129 git hook list &&
 	test_expect_code 129 git hook list -h &&
-	grep "unknown option" err
+	test_grep "unknown option" err
 '
 
 test_expect_success 'git hook list: unknown hook name is rejected' '
@@ -361,9 +361,9 @@ test_expect_success 'hook can be configured for multiple events' '
 
 	# 'ghi' should be included in both 'pre-commit' and 'test-hook'
 	git hook list pre-commit >actual &&
-	grep "ghi" actual &&
+	test_grep "ghi" actual &&
 	git hook list --allow-unknown-hook-name test-hook >actual &&
-	grep "ghi" actual
+	test_grep "ghi" actual
 '
 
 test_expect_success 'git hook list shows hooks from the hookdir' '
@@ -569,7 +569,7 @@ test_expect_success 'git hook run a hook with a bad shebang' '
 	# TODO: We should emit the same (or at least a more similar)
 	# error on MINGW (essentially Git for Windows) and all other
 	# platforms.. See the OS-specific code in start_command()
-	grep -E "^(error|fatal): cannot (exec|spawn) .*bad-hooks/test-hook" err
+	test_grep -E "^(error|fatal): cannot (exec|spawn) .*bad-hooks/test-hook" err
 '
 
 test_expect_success 'stdin to hooks' '
@@ -826,8 +826,8 @@ test_expect_success 'git hook run -j2 warns for hooks not marked parallel=true'
 	# neither hook has parallel=true
 
 	git hook run --allow-unknown-hook-name -j2 test-hook >out 2>err &&
-	grep "hook .hook-1. is not marked as parallel=true" err &&
-	grep "hook .hook-2. is not marked as parallel=true" err
+	test_grep "hook .hook-1. is not marked as parallel=true" err &&
+	test_grep "hook .hook-2. is not marked as parallel=true" err
 '
 
 test_expect_success 'hook.jobs=1 config runs hooks in series' '
@@ -1068,7 +1068,7 @@ test_expect_success 'hook.jobs=-1 resolves to online_cpus()' '
 	cpus=$(test-tool online-cpus) &&
 	GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
 		git hook run --allow-unknown-hook-name test-hook >out 2>err &&
-	grep "\"region_enter\".*\"hook\".*\"test-hook\".*\"max:$cpus\"" trace.txt
+	test_grep "\"region_enter\".*\"hook\".*\"test-hook\".*\"max:$cpus\"" trace.txt
 '
 
 test_expect_success 'hook.<event>.jobs=-1 resolves to online_cpus()' '
@@ -1081,7 +1081,7 @@ test_expect_success 'hook.<event>.jobs=-1 resolves to online_cpus()' '
 	cpus=$(test-tool online-cpus) &&
 	GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
 		git hook run --allow-unknown-hook-name test-hook >out 2>err &&
-	grep "\"region_enter\".*\"hook\".*\"test-hook\".*\"max:$cpus\"" trace.txt
+	test_grep "\"region_enter\".*\"hook\".*\"test-hook\".*\"max:$cpus\"" trace.txt
 '
 
 test_expect_success 'git hook run -j-1 resolves to online_cpus()' '
@@ -1092,7 +1092,7 @@ test_expect_success 'git hook run -j-1 resolves to online_cpus()' '
 	cpus=$(test-tool online-cpus) &&
 	GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
 		git hook run --allow-unknown-hook-name -j-1 test-hook >out 2>err &&
-	grep "\"region_enter\".*\"hook\".*\"test-hook\".*\"max:$cpus\"" trace.txt
+	test_grep "\"region_enter\".*\"hook\".*\"test-hook\".*\"max:$cpus\"" trace.txt
 '
 
 test_expect_success 'hook.jobs rejects values less than -1' '
diff --git a/t/t2004-checkout-cache-temp.sh b/t/t2004-checkout-cache-temp.sh
index 0afe0ff7ca..db06c321ed 100755
--- a/t/t2004-checkout-cache-temp.sh
+++ b/t/t2004-checkout-cache-temp.sh
@@ -132,8 +132,8 @@ test_expect_success 'overriding --stage=all resets implied --temp' '
 test_expect_success '--stage=all --no-temp is rejected' '
 	rm -f path* .merge_* actual &&
 	test_must_fail git checkout-index --stage=all --no-temp -- path1 2>err &&
-	grep -v "already exists" err &&
-	grep "options .--stage=all. and .--no-temp. cannot be used together" err
+	test_grep -v "already exists" err &&
+	test_grep "options .--stage=all. and .--no-temp. cannot be used together" err
 '
 
 test_expect_success 'checkout some stages/one file to temporary files' '
diff --git a/t/t2019-checkout-ambiguous-ref.sh b/t/t2019-checkout-ambiguous-ref.sh
index 1fcef4be95..0ac35798c2 100755
--- a/t/t2019-checkout-ambiguous-ref.sh
+++ b/t/t2019-checkout-ambiguous-ref.sh
@@ -19,7 +19,7 @@ test_expect_success 'checkout ambiguous ref succeeds' '
 '
 
 test_expect_success 'checkout produces ambiguity warning' '
-	grep "warning.*ambiguous" stderr
+	test_grep "warning.*ambiguous" stderr
 '
 
 test_expect_success 'checkout chooses branch over tag' '
@@ -41,7 +41,7 @@ test_expect_success 'checkout vague ref succeeds' '
 '
 
 test_expect_success VAGUENESS_SUCCESS 'checkout produces ambiguity warning' '
-	grep "warning.*ambiguous" stderr
+	test_grep "warning.*ambiguous" stderr
 '
 
 test_expect_success VAGUENESS_SUCCESS 'checkout chooses branch over tag' '
diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
index a3b1449ef1..752e7f0e61 100755
--- a/t/t2024-checkout-dwim.sh
+++ b/t/t2024-checkout-dwim.sh
@@ -311,7 +311,7 @@ test_expect_success 'loosely defined local base branch is reported correctly' '
 	git checkout loose >actual.raw 2>&1 &&
 	sed -e "s/loose/BRANCHNAME/g" <actual.raw >actual &&
 	status_uno_is_clean &&
-	grep BRANCHNAME actual &&
+	test_grep BRANCHNAME actual &&
 
 	test_cmp expect actual
 '
@@ -324,7 +324,7 @@ test_expect_success 'reject when arg could be part of dwim branch' '
 	echo bar >dwim-arg &&
 	test_must_fail git checkout dwim-arg &&
 	test_must_fail git rev-parse refs/heads/dwim-arg -- &&
-	grep bar dwim-arg
+	test_grep bar dwim-arg
 '
 
 test_expect_success 'disambiguate dwim branch and checkout path (1)' '
@@ -334,7 +334,7 @@ test_expect_success 'disambiguate dwim branch and checkout path (1)' '
 	echo bar >dwim-arg1 &&
 	git checkout -- dwim-arg1 &&
 	test_must_fail git rev-parse refs/heads/dwim-arg1 -- &&
-	grep foo dwim-arg1
+	test_grep foo dwim-arg1
 '
 
 test_expect_success 'disambiguate dwim branch and checkout path (2)' '
@@ -344,7 +344,7 @@ test_expect_success 'disambiguate dwim branch and checkout path (2)' '
 	echo bar >dwim-arg2 &&
 	git checkout dwim-arg2 -- &&
 	git rev-parse refs/heads/dwim-arg2 -- &&
-	grep bar dwim-arg2
+	test_grep bar dwim-arg2
 '
 
 test_done
diff --git a/t/t2030-unresolve-info.sh b/t/t2030-unresolve-info.sh
index be3fcdde07..9af24b1204 100755
--- a/t/t2030-unresolve-info.sh
+++ b/t/t2030-unresolve-info.sh
@@ -122,7 +122,7 @@ test_expect_success 'add records checkout -m undoes' '
 	check_resolve_undo removed &&
 	echo the index and the work tree is unmerged again &&
 	git diff >actual &&
-	grep "^++<<<<<<<" actual
+	test_grep "^++<<<<<<<" actual
 '
 
 test_expect_success 'unmerge with plumbing' '
@@ -173,7 +173,7 @@ test_expect_success 'rerere and rerere forget' '
 	test -f .git/rr-cache/$rerere_id/postimage &&
 	git checkout -m fi/le &&
 	echo resurrect the conflict &&
-	grep "^=======" fi/le &&
+	test_grep "^=======" fi/le &&
 	echo reresolve the conflict &&
 	git rerere &&
 	test "z$(cat fi/le)" = zdifferent &&
@@ -199,7 +199,7 @@ test_expect_success 'rerere and rerere forget (subdirectory)' '
 	test -f .git/rr-cache/$rerere_id/postimage &&
 	(cd fi && git checkout -m le) &&
 	echo resurrect the conflict &&
-	grep "^=======" fi/le &&
+	test_grep "^=======" fi/le &&
 	echo reresolve the conflict &&
 	(cd fi && git rerere) &&
 	test "z$(cat fi/le)" = zdifferent &&
diff --git a/t/t2060-switch.sh b/t/t2060-switch.sh
index c91c4db936..cec2fe6876 100755
--- a/t/t2060-switch.sh
+++ b/t/t2060-switch.sh
@@ -34,13 +34,13 @@ test_expect_success 'switch and detach' '
 
 test_expect_success 'suggestion to detach' '
 	test_must_fail git switch main^{commit} 2>stderr &&
-	grep "try again with the --detach option" stderr
+	test_grep "try again with the --detach option" stderr
 '
 
 test_expect_success 'suggestion to detach is suppressed with advice.suggestDetachingHead=false' '
 	test_config advice.suggestDetachingHead false &&
 	test_must_fail git switch main^{commit} 2>stderr &&
-	! grep "try again with the --detach option" stderr
+	test_grep ! "try again with the --detach option" stderr
 '
 
 test_expect_success 'switch and detach current branch' '
@@ -76,7 +76,7 @@ test_expect_success 'new orphan branch from empty' '
 	git switch --orphan new-orphan &&
 	test_commit orphan &&
 	git cat-file commit refs/heads/new-orphan >commit &&
-	! grep ^parent commit &&
+	test_grep ! ^parent commit &&
 	git ls-files >tracked-files &&
 	echo orphan.t >expected &&
 	test_cmp expected tracked-files
diff --git a/t/t2070-restore.sh b/t/t2070-restore.sh
index 16d6348b69..2c222fb934 100755
--- a/t/t2070-restore.sh
+++ b/t/t2070-restore.sh
@@ -216,7 +216,7 @@ test_expect_success 'restore with merge options are incompatible with certain op
 		"--staged --worktree --conflict=zdiff3"
 	do
 		test_must_fail git restore $opts . 2>err &&
-		grep "cannot be used" err || return
+		test_grep "cannot be used" err || return
 	done
 '
 
diff --git a/t/t2080-parallel-checkout-basics.sh b/t/t2080-parallel-checkout-basics.sh
index 5ffe1a41e2..88a6ec1826 100755
--- a/t/t2080-parallel-checkout-basics.sh
+++ b/t/t2080-parallel-checkout-basics.sh
@@ -200,13 +200,13 @@ test_expect_success 'parallel checkout respects --[no]-force' '
 		# We expect 0 workers because there is nothing to be done
 		test_checkout_workers 0 git checkout HEAD &&
 		test_path_is_file D &&
-		grep changed D &&
-		grep changed F.t &&
+		test_grep changed D &&
+		test_grep changed F.t &&
 
 		test_checkout_workers 2 git checkout --force HEAD &&
 		test_path_is_dir D &&
-		grep D/F D/F.t &&
-		grep F F.t
+		test_grep D/F D/F.t &&
+		test_grep F F.t
 	)
 '
 
@@ -224,8 +224,8 @@ test_expect_success SYMLINKS 'parallel checkout checks for symlinks in leading d
 
 		test_checkout_workers 2 git checkout --force HEAD &&
 		! test -h D &&
-		grep D/A D/A.t &&
-		grep D/B D/B.t
+		test_grep D/A D/A.t &&
+		test_grep D/B D/B.t
 	)
 '
 
@@ -268,7 +268,7 @@ test_expect_success '"git checkout ." report should not include failed entries'
 		#  - missing-delay.a: the delay filter will drop this path
 		#  - parallel-*.a: the blob will be missing
 		#
-		grep "Updated 3 paths from the index" err &&
+		test_grep "Updated 3 paths from the index" err &&
 		test_stdout_line_count = 3 ls *.b &&
 		! ls *.a
 	)
diff --git a/t/t2081-parallel-checkout-collisions.sh b/t/t2081-parallel-checkout-collisions.sh
index f6fcfc0c1e..db45f5f30f 100755
--- a/t/t2081-parallel-checkout-collisions.sh
+++ b/t/t2081-parallel-checkout-collisions.sh
@@ -78,8 +78,8 @@ test_expect_success CASE_INSENSITIVE_FS 'worker detects dirname collision' '
 
 	# Check that it used the right number of workers and detected the collisions
 	test_workers_in_event_trace 2 trace &&
-	grep "category.:.pcheckout.,.key.:.collision/dirname.,.value.:.A/B.}" trace &&
-	grep "category.:.pcheckout.,.key.:.collision/dirname.,.value.:.A/C.}" trace
+	test_grep "category.:.pcheckout.,.key.:.collision/dirname.,.value.:.A/B.}" trace &&
+	test_grep "category.:.pcheckout.,.key.:.collision/dirname.,.value.:.A/C.}" trace
 '
 
 test_expect_success SYMLINKS,CASE_INSENSITIVE_FS 'do not follow symlinks colliding with leading dir' '
@@ -115,11 +115,11 @@ test_expect_success CASE_INSENSITIVE_FS 'collision report on clone (w/ racy file
 	set_checkout_config 2 0 &&
 	test_checkout_workers 2 git clone . clone-repo 2>stderr &&
 
-	grep FILE_X stderr &&
-	grep FILE_x stderr &&
-	grep file_X stderr &&
-	grep file_x stderr &&
-	grep "the following paths have collided" stderr
+	test_grep FILE_X stderr &&
+	test_grep FILE_x stderr &&
+	test_grep file_X stderr &&
+	test_grep file_x stderr &&
+	test_grep "the following paths have collided" stderr
 '
 
 # This test ensures that the collision report code is correctly looking for
@@ -148,11 +148,11 @@ test_expect_success CASE_INSENSITIVE_FS,!MINGW,!CYGWIN \
 	test_checkout_workers 2 \
 		git -c core.ignoreCase=false clone . clone-repo 2>stderr &&
 
-	grep FILE_X stderr &&
-	grep FILE_x stderr &&
-	grep file_X stderr &&
-	grep file_x stderr &&
-	grep "the following paths have collided" stderr &&
+	test_grep FILE_X stderr &&
+	test_grep FILE_x stderr &&
+	test_grep file_X stderr &&
+	test_grep file_x stderr &&
+	test_grep "the following paths have collided" stderr &&
 
 	# Check that only "file_x" was filtered
 	echo file_x >expected.log &&
diff --git a/t/t2082-parallel-checkout-attributes.sh b/t/t2082-parallel-checkout-attributes.sh
index 79fb11f139..1f43c2a267 100755
--- a/t/t2082-parallel-checkout-attributes.sh
+++ b/t/t2082-parallel-checkout-attributes.sh
@@ -28,8 +28,8 @@ test_expect_success 'parallel-checkout with ident' '
 		rm A B &&
 		test_checkout_workers 2 git reset --hard &&
 		hexsz=$(test_oid hexsz) &&
-		grep -E "\\\$Id: [0-9a-f]{$hexsz} \\\$" A &&
-		grep "\\\$Id\\\$" B
+		test_grep -E "\\\$Id: [0-9a-f]{$hexsz} \\\$" A &&
+		test_grep "\\\$Id\\\$" B
 	)
 '
 
@@ -175,15 +175,15 @@ test_expect_success 'parallel-checkout and delayed checkout' '
 	verify_checkout delayed &&
 
 	# Check that the *.d files got to the delay queue and were filtered
-	grep "smudge W.d .* \[DELAYED\]" delayed.log &&
-	grep "smudge X.d .* \[DELAYED\]" delayed.log &&
+	test_grep "smudge W.d .* \[DELAYED\]" delayed.log &&
+	test_grep "smudge X.d .* \[DELAYED\]" delayed.log &&
 	test_cmp delayed/W.d original &&
 	test_cmp delayed/X.d original &&
 
 	# Check that the parallel-eligible entries went to the right queue and
 	# were not filtered
-	! grep "smudge Y .* \[DELAYED\]" delayed.log &&
-	! grep "smudge Z .* \[DELAYED\]" delayed.log &&
+	test_grep ! "smudge Y .* \[DELAYED\]" delayed.log &&
+	test_grep ! "smudge Z .* \[DELAYED\]" delayed.log &&
 	test_cmp delayed/Y original &&
 	test_cmp delayed/Z original
 '
diff --git a/t/t2103-update-index-ignore-missing.sh b/t/t2103-update-index-ignore-missing.sh
index 6938ecca86..fbfc86b1fa 100755
--- a/t/t2103-update-index-ignore-missing.sh
+++ b/t/t2103-update-index-ignore-missing.sh
@@ -63,9 +63,9 @@ test_expect_success '--unmerged --refresh' '
 	git update-index --unmerged --refresh &&
 	echo 2 >two &&
 	test_must_fail git update-index --unmerged --refresh >actual &&
-	grep two actual &&
-	! grep one actual &&
-	! grep three actual
+	test_grep two actual &&
+	test_grep ! one actual &&
+	test_grep ! three actual
 '
 
 test_expect_success '--ignore-submodules --refresh (1)' '
diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index 0a96655cfe..bb019d7a7c 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -241,7 +241,7 @@ test_expect_success 'add -u avoids rename pairing on unmerged paths' '
 test_expect_success '"add -u non-existent" should fail' '
 	test_must_fail git add -u non-existent &&
 	git ls-files >actual &&
-	! grep "non-existent" actual
+	test_grep ! "non-existent" actual
 '
 
 test_expect_success '"commit -a" implies "add -u" if index becomes empty' '
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 44c1936e4d..69fef7e646 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -57,7 +57,7 @@ test_expect_success 'intent to add does not clobber existing paths' '
 	git add -N file elif &&
 	empty=$(git hash-object --stdin </dev/null) &&
 	git ls-files -s >actual &&
-	! grep "$empty" actual
+	test_grep ! "$empty" actual
 '
 
 test_expect_success 'i-t-a entry is simply ignored' '
@@ -124,7 +124,7 @@ test_expect_success 'cache-tree does not ignore dir that has i-t-a entries' '
 		git add -N 2/1 &&
 		git commit -m committed &&
 		git ls-tree -r HEAD >actual &&
-		grep 2/2 actual
+		test_grep 2/2 actual
 	)
 '
 
@@ -312,7 +312,7 @@ test_expect_success 'apply --intent-to-add' '
 	echo new >new-ita &&
 	git add -N new-ita &&
 	git diff >expected &&
-	grep "new file" expected &&
+	test_grep "new file" expected &&
 	git reset --hard &&
 	git apply --intent-to-add expected &&
 	git diff >actual &&
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 58b4445cc4..87b926728a 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -122,7 +122,7 @@ test_expect_success 'die the same branch is already checked out' '
 	(
 		cd here &&
 		test_must_fail git checkout newmain 2>actual &&
-		grep "already used by worktree at" actual
+		test_grep "already used by worktree at" actual
 	)
 '
 
@@ -139,7 +139,7 @@ test_expect_success 'refuse to reset a branch in use elsewhere' '
 		git rev-parse --verify refs/heads/newmain >new.branch &&
 		git rev-parse --verify HEAD >new.head &&
 
-		grep "already used by worktree at" error &&
+		test_grep "already used by worktree at" error &&
 		test_cmp old.branch new.branch &&
 		test_cmp old.head new.head &&
 
@@ -328,7 +328,7 @@ test_wt_add_excl () {
 	local opts="$*" &&
 	test_expect_success "'worktree add' with '$opts' has mutually exclusive options" '
 		test_must_fail git worktree add $opts 2>actual &&
-		grep -E "fatal:( options)? .* cannot be used together" actual
+		test_grep -E "fatal:( options)? .* cannot be used together" actual
 	'
 }
 
@@ -436,13 +436,13 @@ test_wt_add_orphan_hint () {
 		(cd repo && test_commit commit) &&
 		git -C repo switch --orphan noref &&
 		test_must_fail git -C repo worktree add $opts foobar/ 2>actual &&
-		! grep "error: unknown switch" actual &&
-		grep "hint: If you meant to create a worktree containing a new unborn branch" actual &&
+		test_grep ! "error: unknown switch" actual &&
+		test_grep "hint: If you meant to create a worktree containing a new unborn branch" actual &&
 		if [ $use_branch -eq 1 ]
 		then
-			grep -E "^hint: +git worktree add --orphan -b [^ ]+ [^ ]+$" actual
+			test_grep -E "^hint: +git worktree add --orphan -b [^ ]+ [^ ]+$" actual
 		else
-			grep -E "^hint: +git worktree add --orphan [^ ]+$" actual
+			test_grep -E "^hint: +git worktree add --orphan [^ ]+$" actual
 		fi
 
 	'
@@ -457,8 +457,8 @@ test_expect_success "'worktree add' doesn't show orphan hint in bad/orphan HEAD
 	git init repo &&
 	(cd repo && test_commit commit) &&
 	test_must_fail git -C repo worktree add --quiet foobar_branch foobar/ 2>actual &&
-	! grep "error: unknown switch" actual &&
-	! grep "hint: If you meant to create a worktree containing a new unborn branch" actual
+	test_grep ! "error: unknown switch" actual &&
+	test_grep ! "hint: If you meant to create a worktree containing a new unborn branch" actual
 '
 
 test_expect_success 'local clone from linked checkout' '
@@ -469,7 +469,7 @@ test_expect_success 'local clone from linked checkout' '
 test_expect_success 'local clone --shared from linked checkout' '
 	git -C bare worktree add --detach ../baretree &&
 	git clone --local --shared baretree bare-clone &&
-	grep /bare/ bare-clone/.git/objects/info/alternates
+	test_grep /bare/ bare-clone/.git/objects/info/alternates
 '
 
 test_expect_success '"add" worktree with --no-checkout' '
@@ -491,7 +491,7 @@ test_expect_success 'put a worktree under rebase' '
 		set_fake_editor &&
 		FAKE_LINES="edit 1" git rebase -i HEAD^ &&
 		git worktree list >actual &&
-		grep "under-rebase.*detached HEAD" actual
+		test_grep "under-rebase.*detached HEAD" actual
 	)
 '
 
@@ -533,7 +533,7 @@ test_expect_success 'checkout a branch under bisect' '
 		git bisect bad &&
 		git bisect good HEAD~2 &&
 		git worktree list >actual &&
-		grep "under-bisect.*detached HEAD" actual &&
+		test_grep "under-bisect.*detached HEAD" actual &&
 		test_must_fail git worktree add new-bisect under-bisect &&
 		test_path_is_missing new-bisect
 	)
diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
index 93f92e854a..eeaf800d74 100755
--- a/t/t2402-worktree-list.sh
+++ b/t/t2402-worktree-list.sh
@@ -101,8 +101,8 @@ test_expect_success '"list" all worktrees with locked annotation' '
 	git worktree lock locked &&
 	test_when_finished "git worktree unlock locked" &&
 	git worktree list >out &&
-	grep "/locked  *[0-9a-f].* locked$" out &&
-	! grep "/unlocked  *[0-9a-f].* locked$" out
+	test_grep "/locked  *[0-9a-f].* locked$" out &&
+	test_grep ! "/unlocked  *[0-9a-f].* locked$" out
 '
 
 test_expect_success '"list" all worktrees --porcelain with locked' '
@@ -143,8 +143,8 @@ test_expect_success '"list" all worktrees with prunable annotation' '
 	git worktree add --detach unprunable &&
 	rm -rf prunable &&
 	git worktree list >out &&
-	grep "/prunable  *[0-9a-f].* prunable$" out &&
-	! grep "/unprunable  *[0-9a-f].* prunable$" out
+	test_grep "/prunable  *[0-9a-f].* prunable$" out &&
+	test_grep ! "/unprunable  *[0-9a-f].* prunable$" out
 '
 
 test_expect_success '"list" all worktrees --porcelain with prunable' '
@@ -162,8 +162,8 @@ test_expect_success '"list" all worktrees with prunable consistent with "prune"'
 	git worktree add --detach unprunable &&
 	rm -rf prunable &&
 	git worktree list >out &&
-	grep "/prunable  *[0-9a-f].* prunable$" out &&
-	! grep "/unprunable  *[0-9a-f].* unprunable$" out &&
+	test_grep "/prunable  *[0-9a-f].* prunable$" out &&
+	test_grep ! "/unprunable  *[0-9a-f].* unprunable$" out &&
 	git worktree prune --verbose 2>out &&
 	test_grep "^Removing worktrees/prunable" out &&
 	test_grep ! "^Removing worktrees/unprunable" out
@@ -184,7 +184,7 @@ test_expect_success '"list" all worktrees --verbose with locked' '
 	echo "$(git -C locked2 rev-parse --show-toplevel) $(git rev-parse --short HEAD) (detached HEAD)" >expect &&
 	printf "\tlocked: with reason\n" >>expect &&
 	git worktree list --verbose >out &&
-	grep "/locked1  *[0-9a-f].* locked$" out &&
+	test_grep "/locked1  *[0-9a-f].* locked$" out &&
 	sed -n "s/  */ /g;/\/locked2  *[0-9a-f].*$/,/locked: .*$/p" <out >actual &&
 	test_cmp actual expect
 '
@@ -266,7 +266,7 @@ test_expect_success 'broken main worktree still at the top' '
 		test_cmp ../expected actual &&
 		git worktree list >out &&
 		head -n 1 out >actual.2 &&
-		grep -F "(error)" actual.2
+		test_grep -F "(error)" actual.2
 	)
 '
 
diff --git a/t/t2403-worktree-move.sh b/t/t2403-worktree-move.sh
index 0bb33e8b1b..69768c1207 100755
--- a/t/t2403-worktree-move.sh
+++ b/t/t2403-worktree-move.sh
@@ -75,8 +75,8 @@ test_expect_success 'move worktree' '
 	git worktree move source destination &&
 	test_path_is_missing source &&
 	git worktree list --porcelain >out &&
-	grep "^worktree.*/destination$" out &&
-	! grep "^worktree.*/source$" out &&
+	test_grep "^worktree.*/destination$" out &&
+	test_grep ! "^worktree.*/source$" out &&
 	git -C destination log --format=%s >actual2 &&
 	echo init >expected2 &&
 	test_cmp expected2 actual2
@@ -92,7 +92,7 @@ test_expect_success 'move worktree to another dir' '
 	test_when_finished "git worktree move some-dir/destination destination" &&
 	test_path_is_missing destination &&
 	git worktree list --porcelain >out &&
-	grep "^worktree.*/some-dir/destination$" out &&
+	test_grep "^worktree.*/some-dir/destination$" out &&
 	git -C some-dir/destination log --format=%s >actual2 &&
 	echo init >expected2 &&
 	test_cmp expected2 actual2
diff --git a/t/t2405-worktree-submodule.sh b/t/t2405-worktree-submodule.sh
index 11018f37c7..f5c94d490b 100755
--- a/t/t2405-worktree-submodule.sh
+++ b/t/t2405-worktree-submodule.sh
@@ -36,7 +36,7 @@ test_expect_success 'add superproject worktree' '
 
 test_expect_failure 'submodule is checked out just after worktree add' '
 	git -C worktree diff --submodule main"^!" >out &&
-	grep "file1 updated" out
+	test_grep "file1 updated" out
 '
 
 test_expect_success 'add superproject worktree and initialize submodules' '
@@ -46,7 +46,7 @@ test_expect_success 'add superproject worktree and initialize submodules' '
 
 test_expect_success 'submodule is checked out just after submodule update in linked worktree' '
 	git -C worktree-submodule-update diff --submodule main"^!" >out &&
-	grep "file1 updated" out
+	test_grep "file1 updated" out
 '
 
 test_expect_success 'add superproject worktree and manually add submodule worktree' '
@@ -56,7 +56,7 @@ test_expect_success 'add superproject worktree and manually add submodule worktr
 
 test_expect_success 'submodule is checked out after manually adding submodule worktree' '
 	git -C linked_submodule diff --submodule main"^!" >out &&
-	grep "file1 updated" out
+	test_grep "file1 updated" out
 '
 
 test_expect_success 'checkout --recurse-submodules uses $GIT_DIR for submodules in a linked worktree' '
diff --git a/t/t2407-worktree-heads.sh b/t/t2407-worktree-heads.sh
index 57c201869f..a6d7e0f83b 100755
--- a/t/t2407-worktree-heads.sh
+++ b/t/t2407-worktree-heads.sh
@@ -41,10 +41,10 @@ test_expect_success 'refuse to overwrite: checked out in worktree' '
 	for i in 1 2 3 4
 	do
 		test_must_fail git branch -f wt-$i HEAD 2>err &&
-		grep "cannot force update the branch" err &&
+		test_grep "cannot force update the branch" err &&
 
 		test_must_fail git branch -D wt-$i 2>err &&
-		grep "cannot delete branch" err || return 1
+		test_grep "cannot delete branch" err || return 1
 	done
 '
 
@@ -57,7 +57,7 @@ test_expect_success 'refuse to overwrite: worktree in bisect' '
 	git -C wt-4 bisect good wt-1 &&
 
 	test_must_fail git branch -f wt-4 HEAD 2>err &&
-	grep "cannot force update the branch '\''wt-4'\'' used by worktree at.*wt-4" err
+	test_grep "cannot force update the branch '\''wt-4'\'' used by worktree at.*wt-4" err
 '
 
 test_expect_success 'refuse to overwrite: worktree in rebase (apply)' '
@@ -67,7 +67,7 @@ test_expect_success 'refuse to overwrite: worktree in rebase (apply)' '
 	test_must_fail git -C wt-2 rebase --apply conflict-2 &&
 
 	test_must_fail git branch -f wt-2 HEAD 2>err &&
-	grep "cannot force update the branch '\''wt-2'\'' used by worktree at.*wt-2" err
+	test_grep "cannot force update the branch '\''wt-2'\'' used by worktree at.*wt-2" err
 '
 
 test_expect_success 'refuse to overwrite: worktree in rebase (merge)' '
@@ -77,7 +77,7 @@ test_expect_success 'refuse to overwrite: worktree in rebase (merge)' '
 	test_must_fail git -C wt-2 rebase conflict-2 &&
 
 	test_must_fail git branch -f wt-2 HEAD 2>err &&
-	grep "cannot force update the branch '\''wt-2'\'' used by worktree at.*wt-2" err
+	test_grep "cannot force update the branch '\''wt-2'\'' used by worktree at.*wt-2" err
 '
 
 test_expect_success 'refuse to overwrite: worktree in rebase with --update-refs' '
@@ -89,19 +89,19 @@ test_expect_success 'refuse to overwrite: worktree in rebase with --update-refs'
 	for i in 3 4
 	do
 		test_must_fail git branch -f can-be-updated HEAD 2>err &&
-		grep "cannot force update the branch '\''can-be-updated'\'' used by worktree at.*wt-3" err ||
+		test_grep "cannot force update the branch '\''can-be-updated'\'' used by worktree at.*wt-3" err ||
 			return 1
 	done
 '
 
 test_expect_success 'refuse to fetch over ref: checked out' '
 	test_must_fail git fetch server +refs/heads/wt-3:refs/heads/wt-3 2>err &&
-	grep "refusing to fetch into branch '\''refs/heads/wt-3'\''" err &&
+	test_grep "refusing to fetch into branch '\''refs/heads/wt-3'\''" err &&
 
 	# General fetch into refs/heads/ will fail on first ref,
 	# so use a generic error message check.
 	test_must_fail git fetch server +refs/heads/*:refs/heads/* 2>err &&
-	grep "refusing to fetch into branch" err
+	test_grep "refusing to fetch into branch" err
 '
 
 test_expect_success 'refuse to fetch over ref: worktree in bisect' '
@@ -113,7 +113,7 @@ test_expect_success 'refuse to fetch over ref: worktree in bisect' '
 	git -C wt-4 bisect good wt-1 &&
 
 	test_must_fail git fetch server +refs/heads/wt-4:refs/heads/wt-4 2>err &&
-	grep "refusing to fetch into branch" err
+	test_grep "refusing to fetch into branch" err
 '
 
 test_expect_success 'refuse to fetch over ref: worktree in rebase' '
@@ -123,7 +123,7 @@ test_expect_success 'refuse to fetch over ref: worktree in rebase' '
 	test_must_fail git -C wt-3 rebase conflict-3 &&
 
 	test_must_fail git fetch server +refs/heads/wt-3:refs/heads/wt-3 2>err &&
-	grep "refusing to fetch into branch" err
+	test_grep "refusing to fetch into branch" err
 '
 
 test_expect_success 'refuse to overwrite when in error states' '
@@ -149,7 +149,7 @@ test_expect_success 'refuse to overwrite when in error states' '
 	for i in 1 2
 	do
 		test_must_fail git branch -f fake-$i HEAD 2>err &&
-		grep "cannot force update the branch '\''fake-$i'\'' used by worktree at" err ||
+		test_grep "cannot force update the branch '\''fake-$i'\'' used by worktree at" err ||
 			return 1
 	done
 '
@@ -161,13 +161,13 @@ test_expect_success 'refuse to overwrite during rebase with --update-refs' '
 	(
 		set_cat_todo_editor &&
 		test_must_fail git rebase -i --update-refs HEAD~3 >todo &&
-		! grep "update-refs" todo
+		test_grep ! "update-refs" todo
 	) &&
 	git branch -f allow-update HEAD~2 &&
 	(
 		set_cat_todo_editor &&
 		test_must_fail git rebase -i --update-refs HEAD~3 >todo &&
-		grep "update-ref refs/heads/allow-update" todo
+		test_grep "update-ref refs/heads/allow-update" todo
 	)
 '
 
diff --git a/t/t2500-untracked-overwriting.sh b/t/t2500-untracked-overwriting.sh
index 5c0bf4d21f..8e84f29e8d 100755
--- a/t/t2500-untracked-overwriting.sh
+++ b/t/t2500-untracked-overwriting.sh
@@ -51,7 +51,7 @@ test_expect_success 'reset --merge will preserve untracked files/dirs' '
 
 		test_must_fail git reset --merge work 2>error &&
 		test_cmp expect foo.t/file &&
-		grep "Updating .foo.t. would lose untracked files" error
+		test_grep "Updating .foo.t. would lose untracked files" error
 	)
 '
 
@@ -66,7 +66,7 @@ test_expect_success 'reset --keep will preserve untracked files/dirs' '
 
 		test_must_fail git reset --merge work 2>error &&
 		test_cmp expect foo.t/file &&
-		grep "Updating.*foo.t.*would lose untracked files" error
+		test_grep "Updating.*foo.t.*would lose untracked files" error
 	)
 '
 
@@ -214,7 +214,7 @@ test_expect_success 'git am --abort and untracked dir vs. unmerged file' '
 
 		test_must_fail git am --abort 2>errors &&
 		test_path_is_dir filler &&
-		grep "Updating .filler. would lose untracked files in it" errors
+		test_grep "Updating .filler. would lose untracked files in it" errors
 	)
 '
 
@@ -237,7 +237,7 @@ test_expect_success 'git am --skip and untracked dir vs deleted file' '
 		# Change our mind about resolutions, just skip this patch
 		test_must_fail git am --skip 2>errors &&
 		test_path_is_dir newfile &&
-		grep "Updating .newfile. would lose untracked files in it" errors
+		test_grep "Updating .newfile. would lose untracked files in it" errors
 	)
 '
 
diff --git a/t/t2501-cwd-empty.sh b/t/t2501-cwd-empty.sh
index be9140bbaa..eb6451d71d 100755
--- a/t/t2501-cwd-empty.sh
+++ b/t/t2501-cwd-empty.sh
@@ -114,7 +114,7 @@ test_expect_success 'merge fails if cwd needs to be removed; recursive friendly'
 	) &&
 
 	test_path_is_dir dirORfile &&
-	grep "Refusing to remove the current working directory" error
+	test_grep "Refusing to remove the current working directory" error
 '
 
 test_expect_success 'merge fails if cwd needs to be removed' '
@@ -179,7 +179,7 @@ test_incidental_untracked_dir_removal () {
 test_expect_success 'clean does not remove cwd incidentally' '
 	test_incidental_untracked_dir_removal \
 		git -C .. clean -fd -e warnings . >warnings &&
-	grep "Refusing to remove current working directory" warnings
+	test_grep "Refusing to remove current working directory" warnings
 '
 
 test_expect_success 'stash does not remove cwd incidentally' '
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-others-exclude.sh
index 202fb8d9ea..29a0a25b30 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -161,21 +161,21 @@ test_expect_success 'trailing slash in exclude forces directory match (1)' '
 
 	>two &&
 	git ls-files --others --exclude=two/ >output &&
-	grep "^two" output
+	test_grep "^two" output
 
 '
 
 test_expect_success 'trailing slash in exclude forces directory match (2)' '
 
 	git ls-files --others --exclude=one/a.1/ >output &&
-	grep "^one/a.1" output
+	test_grep "^one/a.1" output
 
 '
 
 test_expect_success 'negated exclude matches can override previous ones' '
 
 	git ls-files --others --exclude="a.*" --exclude="!a.1" >output &&
-	grep "^a.1" output
+	test_grep "^a.1" output
 '
 
 test_expect_success 'excluded directory overrides content patterns' '
diff --git a/t/t3007-ls-files-recurse-submodules.sh b/t/t3007-ls-files-recurse-submodules.sh
index 61771eec83..218964edab 100755
--- a/t/t3007-ls-files-recurse-submodules.sh
+++ b/t/t3007-ls-files-recurse-submodules.sh
@@ -302,7 +302,7 @@ test_expect_success '--recurse-submodules does not support --error-unmatch' '
 test_expect_success '--recurse-submodules parses submodule repo config' '
 	test_config -C submodule index.sparse "invalid non-boolean value" &&
 	test_must_fail git ls-files --recurse-submodules 2>err &&
-	grep "bad boolean config value" err
+	test_grep "bad boolean config value" err
 '
 
 test_expect_success '--recurse-submodules parses submodule worktree config' '
@@ -310,7 +310,7 @@ test_expect_success '--recurse-submodules parses submodule worktree config' '
 	test_config -C submodule --worktree index.sparse "invalid non-boolean value" &&
 
 	test_must_fail git ls-files --recurse-submodules 2>err &&
-	grep "bad boolean config value" err
+	test_grep "bad boolean config value" err
 '
 
 test_expect_success '--recurse-submodules submodules ignore super project worktreeConfig extension' '
@@ -329,7 +329,7 @@ test_expect_success '--recurse-submodules submodules ignore super project worktr
 	# With extensions.worktreeConfig disabled in the submodule, the invalid
 	# worktree config is not picked up.
 	git ls-files --recurse-submodules 2>err &&
-	! grep "bad boolean config value" err
+	test_grep ! "bad boolean config value" err
 '
 
 test_incompatible_with_recurse_submodules () {
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index e7829c2c4b..bd839998b1 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -204,7 +204,7 @@ test_expect_success 'git branch -M baz bam should succeed when baz is checked ou
 
 test_expect_success 'git branch -M baz bam should add entries to HEAD reflog' '
 	git reflog show HEAD >actual &&
-	grep "HEAD@{0}: Branch: renamed refs/heads/baz to refs/heads/bam" actual
+	test_grep "HEAD@{0}: Branch: renamed refs/heads/baz to refs/heads/bam" actual
 '
 
 test_expect_success 'git branch -M should leave orphaned HEAD alone' '
@@ -339,7 +339,7 @@ test_expect_success 'git branch -d on orphan HEAD (unmerged)' '
 	test_when_finished "git branch -D to-delete" &&
 	git branch to-delete main &&
 	test_must_fail git branch -d to-delete 2>err &&
-	grep "not fully merged" err
+	test_grep "not fully merged" err
 '
 
 test_expect_success 'git branch -d on orphan HEAD (unmerged, graph)' '
@@ -350,7 +350,7 @@ test_expect_success 'git branch -d on orphan HEAD (unmerged, graph)' '
 	test_when_finished "rm -rf .git/objects/commit-graph*" &&
 	git commit-graph write --reachable &&
 	test_must_fail git branch -d to-delete 2>err &&
-	grep "not fully merged" err
+	test_grep "not fully merged" err
 '
 
 test_expect_success 'git branch -v -d t should work' '
@@ -712,7 +712,7 @@ test_expect_success 'git branch -C c1 c2 should succeed when c1 is checked out'
 test_expect_success 'git branch -C c1 c2 should never touch HEAD' '
 	msg="Branch: copied refs/heads/c1 to refs/heads/c2" &&
 	git reflog HEAD >actual &&
-	! grep "$msg$" actual
+	test_grep ! "$msg$" actual
 '
 
 test_expect_success 'git branch -C main should work when main is checked out' '
@@ -930,7 +930,7 @@ test_expect_success 'deleting currently checked out branch fails' '
 	git worktree add -b my7 my7 &&
 	test_must_fail git -C my7 branch -d my7 &&
 	test_must_fail git branch -d my7 2>actual &&
-	grep "^error: cannot delete branch .my7. used by worktree at " actual &&
+	test_grep "^error: cannot delete branch .my7. used by worktree at " actual &&
 	rm -r my7 &&
 	git worktree prune
 '
@@ -941,7 +941,7 @@ test_expect_success 'deleting in-use branch fails' '
 	git -C my7 bisect start HEAD HEAD~2 &&
 	test_must_fail git -C my7 branch -d my7 &&
 	test_must_fail git branch -d my7 2>actual &&
-	grep "^error: cannot delete branch .my7. used by worktree at " actual &&
+	test_grep "^error: cannot delete branch .my7. used by worktree at " actual &&
 	rm -r my7 &&
 	git worktree prune
 '
diff --git a/t/t3202-show-branch.sh b/t/t3202-show-branch.sh
index a1139f79e2..f402334936 100755
--- a/t/t3202-show-branch.sh
+++ b/t/t3202-show-branch.sh
@@ -123,13 +123,13 @@ test_expect_success 'show-branch --sparse' '
 	git commit --allow-empty -m "another" &&
 
 	git show-branch --sparse >out &&
-	grep "merge 1 and 10 to make A" out &&
+	test_grep "merge 1 and 10 to make A" out &&
 
 	git show-branch >out &&
-	! grep "merge 1 and 10 to make A" out &&
+	test_grep ! "merge 1 and 10 to make A" out &&
 
 	git show-branch --no-sparse >out &&
-	! grep "merge 1 and 10 to make A" out
+	test_grep ! "merge 1 and 10 to make A" out
 '
 
 test_expect_success 'setup show branch --list' '
@@ -189,7 +189,7 @@ while read combo
 do
 	test_expect_success "show-branch $combo (should fail)" '
 		test_must_fail git show-branch $combo 2>error &&
-		grep -e "cannot be used together" -e "usage:" error
+		test_grep -e "cannot be used together" -e "usage:" error
 	'
 done <<\EOF
 --all --reflog
@@ -203,7 +203,7 @@ for opt in topo-order date-order reflog
 do
 	test_expect_success "show-branch --no-$opt (should fail)" '
 		test_must_fail git show-branch --no-$opt 2>err &&
-		grep "unknown option .no-$opt." err
+		test_grep "unknown option .no-$opt." err
 	'
 done
 
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index a6bd88a58d..7c44186341 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -64,7 +64,7 @@ test_expect_success 'git branch -r shows remote branches' '
 
 test_expect_success 'git branch --no-remotes is rejected' '
 	test_must_fail git branch --no-remotes 2>err &&
-	grep "unknown option .no-remotes." err
+	test_grep "unknown option .no-remotes." err
 '
 
 cat >expect <<'EOF'
@@ -85,7 +85,7 @@ test_expect_success 'git branch -a shows local and remote branches' '
 
 test_expect_success 'git branch --no-all is rejected' '
 	test_must_fail git branch --no-all 2>err &&
-	grep "unknown option .no-all." err
+	test_grep "unknown option .no-all." err
 '
 
 cat >expect <<'EOF'
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 1e812df806..ef92704de3 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -538,10 +538,10 @@ do
 			main..unmodified >actual &&
 		test_line_count = 5 actual &&
 		test_grep "^Range-diff:$" 0000-* &&
-		grep "= 1: .* s/5/A" 0000-* &&
-		grep "= 2: .* s/4/A" 0000-* &&
-		grep "= 3: .* s/11/B" 0000-* &&
-		grep "= 4: .* s/12/B" 0000-*
+		test_grep "= 1: .* s/5/A" 0000-* &&
+		test_grep "= 2: .* s/4/A" 0000-* &&
+		test_grep "= 3: .* s/11/B" 0000-* &&
+		test_grep "= 4: .* s/12/B" 0000-*
 	'
 done
 
@@ -564,7 +564,7 @@ test_expect_success 'format-patch --range-diff as commentary' '
 	git format-patch --range-diff=HEAD~1 HEAD~1 >actual &&
 	test_line_count = 1 actual &&
 	test_grep "^Range-diff:$" 0001-* &&
-	grep "> 1: .* new message" 0001-*
+	test_grep "> 1: .* new message" 0001-*
 '
 
 test_expect_success 'format-patch --range-diff reroll-count with a non-integer' '
@@ -572,7 +572,7 @@ test_expect_success 'format-patch --range-diff reroll-count with a non-integer'
 	git format-patch --range-diff=HEAD~1 -v2.9 HEAD~1 >actual &&
 	test_line_count = 1 actual &&
 	test_grep "^Range-diff:$" v2.9-0001-* &&
-	grep "> 1: .* new message" v2.9-0001-*
+	test_grep "> 1: .* new message" v2.9-0001-*
 '
 
 test_expect_success 'format-patch --range-diff reroll-count with a integer' '
@@ -580,7 +580,7 @@ test_expect_success 'format-patch --range-diff reroll-count with a integer' '
 	git format-patch --range-diff=HEAD~1 -v2 HEAD~1 >actual &&
 	test_line_count = 1 actual &&
 	test_grep "^Range-diff ..* v1:$" v2-0001-* &&
-	grep "> 1: .* new message" v2-0001-*
+	test_grep "> 1: .* new message" v2-0001-*
 '
 
 test_expect_success 'format-patch --range-diff with v0' '
@@ -588,7 +588,7 @@ test_expect_success 'format-patch --range-diff with v0' '
 	git format-patch --range-diff=HEAD~1 -v0 HEAD~1 >actual &&
 	test_line_count = 1 actual &&
 	test_grep "^Range-diff:$" v0-0001-* &&
-	grep "> 1: .* new message" v0-0001-*
+	test_grep "> 1: .* new message" v0-0001-*
 '
 
 test_expect_success 'range-diff overrides diff.noprefix internally' '
@@ -686,8 +686,8 @@ test_expect_success 'range-diff with --notes=custom does not show default notes'
 	git notes --ref=custom add -m "unmodified note" unmodified &&
 	git range-diff --notes=custom main..topic main..unmodified \
 		>actual &&
-	! grep "## Notes ##" actual &&
-	grep "## Notes (custom) ##" actual
+	test_grep ! "## Notes ##" actual &&
+	test_grep "## Notes (custom) ##" actual
 '
 
 test_expect_success 'format-patch --range-diff does not compare notes by default' '
@@ -699,12 +699,12 @@ test_expect_success 'format-patch --range-diff does not compare notes by default
 		main..unmodified >actual &&
 	test_line_count = 5 actual &&
 	test_grep "^Range-diff:$" 0000-* &&
-	grep "= 1: .* s/5/A" 0000-* &&
-	grep "= 2: .* s/4/A" 0000-* &&
-	grep "= 3: .* s/11/B" 0000-* &&
-	grep "= 4: .* s/12/B" 0000-* &&
-	! grep "Notes" 0000-* &&
-	! grep "note" 0000-*
+	test_grep "= 1: .* s/5/A" 0000-* &&
+	test_grep "= 2: .* s/4/A" 0000-* &&
+	test_grep "= 3: .* s/11/B" 0000-* &&
+	test_grep "= 4: .* s/12/B" 0000-* &&
+	test_grep ! "Notes" 0000-* &&
+	test_grep ! "note" 0000-*
 '
 
 test_expect_success 'format-patch --notes=custom --range-diff --cover-letter only compares custom notes' '
@@ -717,8 +717,8 @@ test_expect_success 'format-patch --notes=custom --range-diff --cover-letter onl
 	test_when_finished "rm -f 000?-*" &&
 	git format-patch --notes=custom --cover-letter --range-diff=$prev \
 		main..unmodified >actual &&
-	grep "## Notes (custom) ##" 0000-* &&
-	! grep "## Notes ##" 0000-*
+	test_grep "## Notes (custom) ##" 0000-* &&
+	test_grep ! "## Notes ##" 0000-*
 '
 
 # --range-diff on a single commit requires --no-cover-letter
@@ -744,12 +744,12 @@ test_expect_success 'format-patch --range-diff with --no-notes' '
 		main..unmodified >actual &&
 	test_line_count = 5 actual &&
 	test_grep "^Range-diff:$" 0000-* &&
-	grep "= 1: .* s/5/A" 0000-* &&
-	grep "= 2: .* s/4/A" 0000-* &&
-	grep "= 3: .* s/11/B" 0000-* &&
-	grep "= 4: .* s/12/B" 0000-* &&
-	! grep "Notes" 0000-* &&
-	! grep "note" 0000-*
+	test_grep "= 1: .* s/5/A" 0000-* &&
+	test_grep "= 2: .* s/4/A" 0000-* &&
+	test_grep "= 3: .* s/11/B" 0000-* &&
+	test_grep "= 4: .* s/12/B" 0000-* &&
+	test_grep ! "Notes" 0000-* &&
+	test_grep ! "note" 0000-*
 '
 
 test_expect_success 'format-patch --range-diff with --notes' '
@@ -761,10 +761,10 @@ test_expect_success 'format-patch --range-diff with --notes' '
 		main..unmodified >actual &&
 	test_line_count = 5 actual &&
 	test_grep "^Range-diff:$" 0000-* &&
-	grep "= 1: .* s/5/A" 0000-* &&
-	grep "= 2: .* s/4/A" 0000-* &&
-	grep "= 3: .* s/11/B" 0000-* &&
-	grep "! 4: .* s/12/B" 0000-* &&
+	test_grep "= 1: .* s/5/A" 0000-* &&
+	test_grep "= 2: .* s/4/A" 0000-* &&
+	test_grep "= 3: .* s/11/B" 0000-* &&
+	test_grep "! 4: .* s/12/B" 0000-* &&
 	sed s/Z/\ /g >expect <<-EOF &&
 	    @@ Commit message
 	    Z
@@ -790,10 +790,10 @@ test_expect_success 'format-patch --range-diff with format.notes config' '
 		main..unmodified >actual &&
 	test_line_count = 5 actual &&
 	test_grep "^Range-diff:$" 0000-* &&
-	grep "= 1: .* s/5/A" 0000-* &&
-	grep "= 2: .* s/4/A" 0000-* &&
-	grep "= 3: .* s/11/B" 0000-* &&
-	grep "! 4: .* s/12/B" 0000-* &&
+	test_grep "= 1: .* s/5/A" 0000-* &&
+	test_grep "= 2: .* s/4/A" 0000-* &&
+	test_grep "= 3: .* s/11/B" 0000-* &&
+	test_grep "! 4: .* s/12/B" 0000-* &&
 	sed s/Z/\ /g >expect <<-EOF &&
 	    @@ Commit message
 	    Z
@@ -821,10 +821,10 @@ test_expect_success 'format-patch --range-diff with multiple notes' '
 		main..unmodified >actual &&
 	test_line_count = 5 actual &&
 	test_grep "^Range-diff:$" 0000-* &&
-	grep "= 1: .* s/5/A" 0000-* &&
-	grep "= 2: .* s/4/A" 0000-* &&
-	grep "= 3: .* s/11/B" 0000-* &&
-	grep "! 4: .* s/12/B" 0000-* &&
+	test_grep "= 1: .* s/5/A" 0000-* &&
+	test_grep "= 2: .* s/4/A" 0000-* &&
+	test_grep "= 3: .* s/11/B" 0000-* &&
+	test_grep "! 4: .* s/12/B" 0000-* &&
 	sed s/Z/\ /g >expect <<-EOF &&
 	    @@ Commit message
 	    Z
@@ -866,9 +866,9 @@ test_expect_success 'ranges with pathspecs' '
 	topic_oid=$(git rev-parse --short topic) &&
 	mode_change_oid=$(git rev-parse --short mode-only-change^) &&
 	file_change_oid=$(git rev-parse --short mode-only-change) &&
-	grep "$mode_change_oid" actual &&
-	! grep "$file_change_oid" actual &&
-	! grep "$topic_oid" actual
+	test_grep "$mode_change_oid" actual &&
+	test_grep ! "$file_change_oid" actual &&
+	test_grep ! "$topic_oid" actual
 '
 
 test_expect_success 'submodule changes are shown irrespective of diff.submodule' '
diff --git a/t/t3207-branch-submodule.sh b/t/t3207-branch-submodule.sh
index fe72b24716..4afb2d3198 100755
--- a/t/t3207-branch-submodule.sh
+++ b/t/t3207-branch-submodule.sh
@@ -136,7 +136,7 @@ test_expect_success 'should not create any branches if branch is not valid for a
 		git -C sub branch branch-a &&
 		test_must_fail git branch --recurse-submodules branch-a 2>actual &&
 		test_no_branch . branch-a &&
-		grep "submodule .sub.: fatal: a branch named .branch-a. already exists" actual
+		test_grep "submodule .sub.: fatal: a branch named .branch-a. already exists" actual
 	)
 '
 
@@ -251,7 +251,7 @@ test_expect_success 'should get fatal error upon branch creation when submodule
 		git branch --recurse-submodules branch-a origin/branch-a &&
 		# This should fail because super-clone does not have sub2 .git/modules
 		test_must_fail git branch --recurse-submodules branch-b origin/branch-b 2>actual &&
-		grep "fatal: submodule .sub2.: unable to find submodule" actual &&
+		test_grep "fatal: submodule .sub2.: unable to find submodule" actual &&
 		test_no_branch . branch-b &&
 		test_no_branch sub branch-b &&
 		# User can fix themselves by initializing the submodule
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index d6c50460d0..18a6000171 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -164,7 +164,7 @@ test_expect_success 'show notes' '
 		${indent}b1
 	EOF
 	git cat-file commit HEAD >commits &&
-	! grep b1 commits &&
+	test_grep ! b1 commits &&
 	git log -1 >actual &&
 	test_cmp expect actual
 '
@@ -248,17 +248,17 @@ test_expect_success 'git log --show-notes' '
 
 test_expect_success 'git log --no-notes' '
 	git log -1 --no-notes >actual &&
-	! grep xyzzy actual
+	test_grep ! xyzzy actual
 '
 
 test_expect_success 'git format-patch does not show notes' '
 	git format-patch -1 --stdout >actual &&
-	! grep xyzzy actual
+	test_grep ! xyzzy actual
 '
 
 test_expect_success 'git format-patch --show-notes does show notes' '
 	git format-patch --show-notes -1 --stdout >actual &&
-	grep xyzzy actual
+	test_grep xyzzy actual
 '
 
 for pretty in \
@@ -281,36 +281,36 @@ test_expect_success 'setup alternate notes ref' '
 
 test_expect_success 'git log --notes shows default notes' '
 	git log -1 --notes >actual &&
-	grep xyzzy actual &&
-	! grep alternate actual
+	test_grep xyzzy actual &&
+	test_grep ! alternate actual
 '
 
 test_expect_success 'git log --notes=X shows only X' '
 	git log -1 --notes=alternate >actual &&
-	! grep xyzzy actual &&
-	grep alternate actual
+	test_grep ! xyzzy actual &&
+	test_grep alternate actual
 '
 
 test_expect_success 'git log --notes --notes=X shows both' '
 	git log -1 --notes --notes=alternate >actual &&
-	grep xyzzy actual &&
-	grep alternate actual
+	test_grep xyzzy actual &&
+	test_grep alternate actual
 '
 
 test_expect_success 'git log --no-notes resets default state' '
 	git log -1 --notes --notes=alternate \
 		--no-notes --notes=alternate \
 		>actual &&
-	! grep xyzzy actual &&
-	grep alternate actual
+	test_grep ! xyzzy actual &&
+	test_grep alternate actual
 '
 
 test_expect_success 'git log --no-notes resets ref list' '
 	git log -1 --notes --notes=alternate \
 		--no-notes --notes \
 		>actual &&
-	grep xyzzy actual &&
-	! grep alternate actual
+	test_grep xyzzy actual &&
+	test_grep ! alternate actual
 '
 
 test_expect_success 'show -m notes' '
@@ -543,7 +543,7 @@ test_expect_success 'list notes with "git notes"' '
 
 test_expect_success '"git notes" without subcommand does not take arguments' '
 	test_expect_code 129 git notes HEAD^^ 2>err &&
-	grep "^error: unknown subcommand" err
+	test_grep "^error: unknown subcommand" err
 '
 
 test_expect_success 'list specific note with "git notes list <object>"' '
@@ -1464,7 +1464,7 @@ test_expect_success 'GIT_NOTES_REWRITE_REF overrides config' '
 	GIT_NOTES_REWRITE_REF=refs/notes/commits \
 		git notes copy --for-rewrite=foo <copy &&
 	git log -1 >actual &&
-	grep "replacement note 3" actual
+	test_grep "replacement note 3" actual
 '
 
 test_expect_success 'git notes copy diagnoses too many or too few arguments' '
diff --git a/t/t3310-notes-merge-manual-resolve.sh b/t/t3310-notes-merge-manual-resolve.sh
index 0bb366fdb8..1d61c997ff 100755
--- a/t/t3310-notes-merge-manual-resolve.sh
+++ b/t/t3310-notes-merge-manual-resolve.sh
@@ -382,12 +382,12 @@ EOF
 	test_cmp pre_merge_z actual &&
 	# Merge commit mentions the notes refs merged
 	git log -1 --format=%B refs/notes/m > merge_commit_msg &&
-	grep -q refs/notes/m merge_commit_msg &&
-	grep -q refs/notes/z merge_commit_msg &&
+	test_grep -q refs/notes/m merge_commit_msg &&
+	test_grep -q refs/notes/z merge_commit_msg &&
 	# Merge commit mentions conflicting notes
-	grep -q "Conflicts" merge_commit_msg &&
+	test_grep -q "Conflicts" merge_commit_msg &&
 	( for sha1 in $(cat expect_conflicts); do
-		grep -q "$sha1" merge_commit_msg ||
+		test_grep -q "$sha1" merge_commit_msg ||
 		exit 1
 	done ) &&
 	# Verify contents of merge result
@@ -512,12 +512,12 @@ EOF
 	test_cmp pre_merge_z actual &&
 	# Merge commit mentions the notes refs merged
 	git log -1 --format=%B refs/notes/m > merge_commit_msg &&
-	grep -q refs/notes/m merge_commit_msg &&
-	grep -q refs/notes/z merge_commit_msg &&
+	test_grep -q refs/notes/m merge_commit_msg &&
+	test_grep -q refs/notes/z merge_commit_msg &&
 	# Merge commit mentions conflicting notes
-	grep -q "Conflicts" merge_commit_msg &&
+	test_grep -q "Conflicts" merge_commit_msg &&
 	( for sha1 in $(cat expect_conflicts); do
-		grep -q "$sha1" merge_commit_msg ||
+		test_grep -q "$sha1" merge_commit_msg ||
 		exit 1
 	done ) &&
 	# Verify contents of merge result
diff --git a/t/t3320-notes-merge-worktrees.sh b/t/t3320-notes-merge-worktrees.sh
index 96243b7222..9a2c3ac3f7 100755
--- a/t/t3320-notes-merge-worktrees.sh
+++ b/t/t3320-notes-merge-worktrees.sh
@@ -67,7 +67,7 @@ test_expect_success 'merge z into x while mid-merge on y succeeds' '
 		git config core.notesRef refs/notes/x &&
 		test_must_fail git notes merge z >out 2>&1 &&
 		test_grep "Automatic notes merge failed" out &&
-		grep -v "A notes merge into refs/notes/x is already in-progress in" out
+		test_grep -v "A notes merge into refs/notes/x is already in-progress in" out
 	) &&
 	echo "refs/notes/x" >expect &&
 	git -C worktree2 symbolic-ref NOTES_MERGE_REF >actual &&
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index c0c00fbb7b..e62e07b894 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -287,16 +287,16 @@ test_expect_success 'rebase commit with an ancient timestamp' '
 	git commit --date="@34567 +0600" -m "Old three" &&
 
 	git cat-file commit HEAD^^ >actual &&
-	grep "author .* 12345 +0400$" actual &&
+	test_grep "author .* 12345 +0400$" actual &&
 	git cat-file commit HEAD^ >actual &&
-	grep "author .* 23456 +0500$" actual &&
+	test_grep "author .* 23456 +0500$" actual &&
 	git cat-file commit HEAD >actual &&
-	grep "author .* 34567 +0600$" actual &&
+	test_grep "author .* 34567 +0600$" actual &&
 
 	git rebase --onto HEAD^^ HEAD^ &&
 
 	git cat-file commit HEAD >actual &&
-	grep "author .* 34567 +0600$" actual
+	test_grep "author .* 34567 +0600$" actual
 '
 
 test_expect_success 'rebase with "From " line in commit message' '
@@ -333,7 +333,7 @@ test_expect_success 'rebase --apply and --show-current-patch' '
 		git tag two &&
 		test_must_fail git rebase --apply -f --onto init HEAD^ &&
 		GIT_TRACE=1 git rebase --show-current-patch >/dev/null 2>stderr &&
-		grep "show.*$(git rev-parse two)" stderr
+		test_grep "show.*$(git rev-parse two)" stderr
 	)
 '
 
@@ -364,12 +364,12 @@ test_expect_success 'rebase --apply and .gitattributes' '
 
 		git checkout test &&
 		git rebase main &&
-		grep "smudged" a.txt &&
+		test_grep "smudged" a.txt &&
 
 		git checkout removal &&
 		git reset --hard &&
 		git rebase main &&
-		grep "clean" a.txt
+		test_grep "clean" a.txt
 	)
 '
 
@@ -386,7 +386,7 @@ test_expect_success 'rebase--merge.sh and --show-current-patch' '
 		test_must_fail git rebase --merge --onto init HEAD^ &&
 		git rebase --show-current-patch >actual.patch &&
 		GIT_TRACE=1 git rebase --show-current-patch >/dev/null 2>stderr &&
-		grep "show.*REBASE_HEAD" stderr &&
+		test_grep "show.*REBASE_HEAD" stderr &&
 		test "$(git rev-parse REBASE_HEAD)" = "$(git rev-parse two)"
 	)
 '
diff --git a/t/t3402-rebase-merge.sh b/t/t3402-rebase-merge.sh
index 761de63b6b..41ebcdec9f 100755
--- a/t/t3402-rebase-merge.sh
+++ b/t/t3402-rebase-merge.sh
@@ -84,8 +84,8 @@ test_expect_success 'rebase -Xtheirs' '
 	echo "AB $T" >> original &&
 	git commit -mconflicting original &&
 	git rebase -Xtheirs main &&
-	grep AB original &&
-	! grep 11 original
+	test_grep AB original &&
+	test_grep ! 11 original
 '
 
 test_expect_success 'rebase -Xtheirs from orphan' '
@@ -93,8 +93,8 @@ test_expect_success 'rebase -Xtheirs from orphan' '
 	echo "AB $T" >> original &&
 	git commit -morphan-conflicting original &&
 	git rebase -Xtheirs main &&
-	grep AB original &&
-	! grep 11 original
+	test_grep AB original &&
+	test_grep ! 11 original
 '
 
 test_expect_success 'merge and rebase should match' '
@@ -210,15 +210,15 @@ test_expect_success '--reapply-cherry-picks refrains from reading unneeded blobs
 	git -C client rev-list --objects --all --missing=print >missing_list &&
 	MERGE_BASE_BLOB=$(git -C server rev-parse main^^:file.txt) &&
 	ADD_11_BLOB=$(git -C server rev-parse main^:file.txt) &&
-	grep "[?]$MERGE_BASE_BLOB" missing_list &&
-	grep "[?]$ADD_11_BLOB" missing_list &&
+	test_grep "[?]$MERGE_BASE_BLOB" missing_list &&
+	test_grep "[?]$ADD_11_BLOB" missing_list &&
 
 	git -C client rebase --merge --reapply-cherry-picks origin/main &&
 
 	# The blob from the merge base had to be fetched, but not "add 11"
 	git -C client rev-list --objects --all --missing=print >missing_list &&
-	! grep "[?]$MERGE_BASE_BLOB" missing_list &&
-	grep "[?]$ADD_11_BLOB" missing_list
+	test_grep ! "[?]$MERGE_BASE_BLOB" missing_list &&
+	test_grep "[?]$ADD_11_BLOB" missing_list
 '
 
 test_done
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 58b3bb0c27..e64816770a 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -144,7 +144,7 @@ test_expect_success 'rebase -i sets work tree properly' '
 	mkdir subdir &&
 	git rebase -x "(cd subdir && git rev-parse --show-toplevel)" HEAD^ \
 		>actual &&
-	! grep "/subdir$" actual
+	test_grep ! "/subdir$" actual
 '
 
 test_expect_success 'rebase -i with the exec command checks tree cleanness' '
@@ -196,7 +196,7 @@ test_expect_success 'rebase -i with exec of inexistent command' '
 		test_must_fail env FAKE_LINES="exec_this-command-does-not-exist 1" \
 			git rebase -i HEAD^ >actual 2>&1
 	) &&
-	! grep "Maybe git-rebase is broken" actual
+	test_grep ! "Maybe git-rebase is broken" actual
 '
 
 test_expect_success 'implicit interactive rebase does not invoke sequence editor' '
@@ -293,7 +293,7 @@ test_expect_success 'stop on conflicting pick' '
 
 test_expect_success 'show conflicted patch' '
 	GIT_TRACE=1 git rebase --show-current-patch >/dev/null 2>stderr &&
-	grep "show.*REBASE_HEAD" stderr &&
+	test_grep "show.*REBASE_HEAD" stderr &&
 	# the original stopped-sha1 is abbreviated
 	stopped_sha1="$(git rev-parse $(cat ".git/rebase-merge/stopped-sha"))" &&
 	test "$(git rev-parse REBASE_HEAD)" = "$stopped_sha1"
@@ -326,7 +326,7 @@ test_expect_success 'retain authorship' '
 	git tag twerp &&
 	git rebase -i --onto primary HEAD^ &&
 	git show HEAD >actual &&
-	grep "^Author: Twerp Snog" actual
+	test_grep "^Author: Twerp Snog" actual
 '
 
 test_expect_success 'retain authorship w/ conflicts' '
@@ -348,7 +348,7 @@ test_expect_success 'retain authorship w/ conflicts' '
 	git rebase --continue &&
 	test_cmp_rev conflict-a^0 HEAD^ &&
 	git show >out &&
-	grep AttributeMe out
+	test_grep AttributeMe out
 '
 
 test_expect_success 'squash' '
@@ -368,7 +368,7 @@ test_expect_success 'squash' '
 
 test_expect_success 'retain authorship when squashing' '
 	git show HEAD >actual &&
-	grep "^Author: Twerp Snog" actual
+	test_grep "^Author: Twerp Snog" actual
 '
 
 test_expect_success '--continue tries to commit' '
@@ -383,7 +383,7 @@ test_expect_success '--continue tries to commit' '
 	) &&
 	test_cmp_rev HEAD^ new-branch1 &&
 	git show HEAD >actual &&
-	grep chouette actual
+	test_grep chouette actual
 '
 
 test_expect_success 'verbose flag is heeded, even after --continue' '
@@ -393,7 +393,7 @@ test_expect_success 'verbose flag is heeded, even after --continue' '
 	echo resolved > file1 &&
 	git add file1 &&
 	git rebase --continue > output &&
-	grep "^ file1 | 2 +-$" output
+	test_grep "^ file1 | 2 +-$" output
 '
 
 test_expect_success 'multi-squash only fires up editor once' '
@@ -422,7 +422,7 @@ test_expect_success 'multi-fixup does not fire up editor' '
 	) &&
 	test $base = $(git rev-parse HEAD^) &&
 	git show >output &&
-	! grep NEVER output &&
+	test_grep ! NEVER output &&
 	git checkout @{-1} &&
 	git branch -D multi-fixup
 '
@@ -487,9 +487,9 @@ test_expect_success 'squash and fixup generate correct log messages' '
 	git cat-file commit HEAD | sed -e 1,/^\$/d > actual-squash-fixup &&
 	test_cmp expect-squash-fixup actual-squash-fixup &&
 	git cat-file commit HEAD@{2} >actual &&
-	grep "^# This is a combination of 3 commits\." actual &&
+	test_grep "^# This is a combination of 3 commits\." actual &&
 	git cat-file commit HEAD@{3} >actual &&
-	grep "^# This is a combination of 2 commits\." actual  &&
+	test_grep "^# This is a combination of 2 commits\." actual  &&
 	git checkout @{-1} &&
 	git branch -D squash-fixup
 '
@@ -593,7 +593,7 @@ test_expect_success '--continue tries to commit, even for "edit"' '
 	) &&
 	test edited = $(git show HEAD:file7) &&
 	git show HEAD >actual &&
-	grep chouette actual &&
+	test_grep chouette actual &&
 	test $parent = $(git rev-parse HEAD^)
 '
 
@@ -779,22 +779,22 @@ test_expect_success 'reword' '
 		FAKE_LINES="1 2 3 reword 4" FAKE_COMMIT_MESSAGE="E changed" \
 			git rebase -i A &&
 		git show HEAD >actual &&
-		grep "E changed" actual &&
+		test_grep "E changed" actual &&
 		test $(git rev-parse primary) != $(git rev-parse HEAD) &&
 		test_cmp_rev primary^ HEAD^ &&
 		FAKE_LINES="1 2 reword 3 4" FAKE_COMMIT_MESSAGE="D changed" \
 			git rebase -i A &&
 		git show HEAD^ >actual &&
-		grep "D changed" actual &&
+		test_grep "D changed" actual &&
 		FAKE_LINES="reword 1 2 3 4" FAKE_COMMIT_MESSAGE="B changed" \
 			git rebase -i A &&
 		git show HEAD~3 >actual &&
-		grep "B changed" actual &&
+		test_grep "B changed" actual &&
 		FAKE_LINES="1 r 2 pick 3 p 4" FAKE_COMMIT_MESSAGE="C changed" \
 			git rebase -i A
 	) &&
 	git show HEAD~2 >actual &&
-	grep "C changed" actual
+	test_grep "C changed" actual
 '
 
 test_expect_success 'reword fast-forwarded empty commit' '
@@ -1043,9 +1043,9 @@ test_expect_success 'rebase -i --root retain root commit author and message' '
 		FAKE_LINES="2" git rebase -i --root
 	) &&
 	git cat-file commit HEAD >output &&
-	grep -q "^author Twerp Snog" output &&
+	test_grep -q "^author Twerp Snog" output &&
 	git cat-file commit HEAD >actual &&
-	grep -q "^different author$" actual
+	test_grep -q "^different author$" actual
 '
 
 test_expect_success 'rebase -i --root temporary sentinel commit' '
@@ -1055,7 +1055,7 @@ test_expect_success 'rebase -i --root temporary sentinel commit' '
 		test_must_fail env FAKE_LINES="2" git rebase -i --root
 	) &&
 	git cat-file commit HEAD >actual &&
-	grep "^tree $EMPTY_TREE" actual &&
+	test_grep "^tree $EMPTY_TREE" actual &&
 	git rebase --abort
 '
 
@@ -1079,7 +1079,7 @@ test_expect_success 'rebase -i --root reword original root commit' '
 			git rebase -i --root
 	) &&
 	git show HEAD^ >actual &&
-	grep "A changed" actual &&
+	test_grep "A changed" actual &&
 	test -z "$(git show -s --format=%p HEAD^)"
 '
 
@@ -1092,7 +1092,7 @@ test_expect_success 'rebase -i --root reword new root commit' '
 		git rebase -i --root
 	) &&
 	git show HEAD^ >actual &&
-	grep "C changed" actual &&
+	test_grep "C changed" actual &&
 	test -z "$(git show -s --format=%p HEAD^)"
 '
 
@@ -1315,11 +1315,11 @@ test_expect_success 'short commit ID collide' '
 		FAKE_COMMIT_MESSAGE="collide2 $(test_oid t3404_collider)" \
 		FAKE_LINES="reword 1 break 2" git rebase -i HEAD~2 &&
 		test $colliding_id = "$(git rev-parse HEAD | cut -c 1-4)" &&
-		grep "^pick $colliding_id " \
+		test_grep "^pick $colliding_id " \
 			.git/rebase-merge/git-rebase-todo.tmp &&
-		grep -E "^pick [0-9a-f]{$hexsz}" \
+		test_grep -E "^pick [0-9a-f]{$hexsz}" \
 			.git/rebase-merge/git-rebase-todo &&
-		grep -E "^pick [0-9a-f]{$hexsz}" \
+		test_grep -E "^pick [0-9a-f]{$hexsz}" \
 			.git/rebase-merge/git-rebase-todo.backup &&
 		git rebase --continue
 	) &&
@@ -1371,7 +1371,7 @@ test_expect_success 'rebase -i commits that overwrite untracked files (pick)' '
 	echo changed >file1 &&
 	git add file1 &&
 	test_must_fail git rebase --continue 2>err &&
-	grep "error: you have staged changes in your working tree" err &&
+	test_grep "error: you have staged changes in your working tree" err &&
 	git reset --hard HEAD &&
 	git rebase --continue &&
 	test_cmp_rev HEAD D &&
@@ -1398,7 +1398,7 @@ test_expect_success 'rebase -i commits that overwrite untracked files (squash)'
 	echo changed >file1 &&
 	git add file1 &&
 	test_must_fail git rebase --continue 2>err &&
-	grep "error: you have staged changes in your working tree" err &&
+	test_grep "error: you have staged changes in your working tree" err &&
 	git reset --hard HEAD &&
 	git rebase --continue &&
 	test $(git cat-file commit HEAD | sed -ne \$p) = I &&
@@ -1423,7 +1423,7 @@ test_expect_success 'rebase -i commits that overwrite untracked files (no ff)' '
 	echo changed >file1 &&
 	git add file1 &&
 	test_must_fail git rebase --continue 2>err &&
-	grep "error: you have staged changes in your working tree" err &&
+	test_grep "error: you have staged changes in your working tree" err &&
 	git reset --hard HEAD &&
 	git rebase --continue &&
 	test $(git cat-file commit HEAD | sed -ne \$p) = I
@@ -1709,15 +1709,15 @@ test_expect_success 'the first command cannot be a fixup' '
 		set_replace_editor orig &&
 		test_must_fail git rebase -i A 2>actual
 	) &&
-	grep "cannot .fixup. without a previous commit" actual &&
-	grep "You can fix this with .git rebase --edit-todo.." actual &&
+	test_grep "cannot .fixup. without a previous commit" actual &&
+	test_grep "You can fix this with .git rebase --edit-todo.." actual &&
 	# verify that the todo list has not been truncated
 	grep -v "^#" .git/rebase-merge/git-rebase-todo >actual &&
 	test_cmp orig actual &&
 
 	test_must_fail git rebase --edit-todo 2>actual &&
-	grep "cannot .fixup. without a previous commit" actual &&
-	grep "You can fix this with .git rebase --edit-todo.." actual &&
+	test_grep "cannot .fixup. without a previous commit" actual &&
+	test_grep "You can fix this with .git rebase --edit-todo.." actual &&
 	# verify that the todo list has not been truncated
 	grep -v "^#" .git/rebase-merge/git-rebase-todo >actual &&
 	test_cmp orig actual
@@ -2252,7 +2252,7 @@ test_expect_success '--update-refs: check failed ref update' '
 	git update-ref refs/heads/second third &&
 
 	test_must_fail git rebase --continue 2>err &&
-	grep "update_ref failed for ref '\''refs/heads/second'\''" err &&
+	test_grep "update_ref failed for ref '\''refs/heads/second'\''" err &&
 
 	q_to_tab >expect <<-\EOF &&
 	Updated the following refs with --update-refs:
@@ -2283,10 +2283,10 @@ test_expect_success 'bad labels and refs rejected when parsing todo list' '
 		set_replace_editor todo &&
 		test_must_fail git rebase -i HEAD 2>err
 	) &&
-	grep "'\''#'\'' is not a valid label" err &&
-	grep "'\'':invalid'\'' is not a valid label" err &&
-	grep "'\'':bad'\'' is not a valid refname" err &&
-	grep "update-ref requires a fully qualified refname e.g. refs/heads/topic" \
+	test_grep "'\''#'\'' is not a valid label" err &&
+	test_grep "'\'':invalid'\'' is not a valid label" err &&
+	test_grep "'\'':bad'\'' is not a valid refname" err &&
+	test_grep "update-ref requires a fully qualified refname e.g. refs/heads/topic" \
 		err &&
 	test_path_is_missing execed
 '
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index bc51a9d3a7..7b61188e1f 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -62,21 +62,21 @@ test_expect_success 'rebase fast-forward to main' '
 test_expect_success 'rebase --stat' '
 	git reset --hard start &&
 	git rebase --stat main >diffstat.txt &&
-	grep "^ fileX |  *1 +$" diffstat.txt
+	test_grep "^ fileX |  *1 +$" diffstat.txt
 '
 
 test_expect_success 'rebase w/config rebase.stat' '
 	git reset --hard start &&
 	git config rebase.stat true &&
 	git rebase main >diffstat.txt &&
-	grep "^ fileX |  *1 +$" diffstat.txt
+	test_grep "^ fileX |  *1 +$" diffstat.txt
 '
 
 test_expect_success 'rebase -n overrides config rebase.stat config' '
 	git reset --hard start &&
 	git config rebase.stat true &&
 	git rebase -n main >diffstat.txt &&
-	! grep "^ fileX |  *1 +$" diffstat.txt
+	test_grep ! "^ fileX |  *1 +$" diffstat.txt
 '
 
 test_expect_success 'rebase --onto outputs the invalid ref' '
diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index 5033411a43..07a5a11678 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -223,7 +223,7 @@ test_expect_success 'auto squash that matches a sha1' '
 	git cat-file blob HEAD^:file1 >actual &&
 	test_cmp expect actual &&
 	git cat-file commit HEAD^ >commit &&
-	! grep "squash" commit &&
+	test_grep ! "squash" commit &&
 	grep "^extra para" commit >actual &&
 	test_line_count = 1 actual
 '
@@ -245,7 +245,7 @@ test_expect_success 'auto squash that matches longer sha1' '
 	git cat-file blob HEAD^:file1 >actual &&
 	test_cmp expect actual &&
 	git cat-file commit HEAD^ >commit &&
-	! grep "squash" commit &&
+	test_grep ! "squash" commit &&
 	grep "^extra para" commit >actual &&
 	test_line_count = 1 actual
 '
@@ -377,7 +377,7 @@ test_expect_success 'autosquash with custom inst format' '
 	git cat-file blob HEAD^:file1 >actual &&
 	test_cmp expect actual &&
 	git cat-file commit HEAD^ >commit &&
-	! grep "squash" commit &&
+	test_grep ! "squash" commit &&
 	grep first commit >actual &&
 	test_line_count = 3 actual
 '
@@ -424,7 +424,7 @@ test_expect_success 'autosquash with multiple empty patches' '
 		set_backup_editor &&
 		GIT_USE_REBASE_HELPER=false \
 		git rebase -i --force-rebase --autosquash HEAD~4 &&
-		grep empty2 .git/backup-git-rebase-todo
+		test_grep empty2 .git/backup-git-rebase-todo
 	)
 '
 
@@ -467,7 +467,7 @@ test_expect_success 'abort last squash' '
 	git commit --allow-empty --amend -m edited-first &&
 	git rebase --skip &&
 	git show >actual &&
-	! grep first actual
+	test_grep ! first actual
 '
 
 test_expect_success 'fixup a fixup' '
diff --git a/t/t3416-rebase-onto-threedots.sh b/t/t3416-rebase-onto-threedots.sh
index ea501f2b42..e7f725b8d0 100755
--- a/t/t3416-rebase-onto-threedots.sh
+++ b/t/t3416-rebase-onto-threedots.sh
@@ -107,7 +107,7 @@ test_expect_success 'rebase --onto main...side requires a single merge-base' '
 	git reset --hard K &&
 
 	test_must_fail git rebase -i --onto main...side J 2>err &&
-	grep "need exactly one merge base" err
+	test_grep "need exactly one merge base" err
 '
 
 test_expect_success 'rebase --keep-base --onto incompatible' '
@@ -196,7 +196,7 @@ test_expect_success 'rebase --keep-base requires a single merge base' '
 	git reset --hard K &&
 
 	test_must_fail git rebase -i --keep-base main 2>err &&
-	grep "need exactly one merge base with branch" err
+	test_grep "need exactly one merge base with branch" err
 '
 
 test_expect_success 'rebase --keep-base keeps cherry picks' '
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index f9b8999db5..03e0714864 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -289,18 +289,18 @@ test_expect_success 'patch file is removed before break command' '
 test_expect_success '--reschedule-failed-exec' '
 	test_when_finished "git rebase --abort" &&
 	test_must_fail git rebase -x false --reschedule-failed-exec HEAD^ &&
-	grep "^exec false" .git/rebase-merge/git-rebase-todo &&
+	test_grep "^exec false" .git/rebase-merge/git-rebase-todo &&
 	git rebase --abort &&
 	test_must_fail git -c rebase.rescheduleFailedExec=true \
 		rebase -x false HEAD^ 2>err &&
-	grep "^exec false" .git/rebase-merge/git-rebase-todo &&
+	test_grep "^exec false" .git/rebase-merge/git-rebase-todo &&
 	test_grep "has been rescheduled" err
 '
 
 test_expect_success 'rebase.rescheduleFailedExec only affects `rebase -i`' '
 	test_config rebase.rescheduleFailedExec true &&
 	test_must_fail git rebase -x false HEAD^ &&
-	grep "^exec false" .git/rebase-merge/git-rebase-todo &&
+	test_grep "^exec false" .git/rebase-merge/git-rebase-todo &&
 	git rebase --abort &&
 	git rebase HEAD^
 '
@@ -310,7 +310,7 @@ test_expect_success 'rebase.rescheduleFailedExec=true & --no-reschedule-failed-e
 	test_config rebase.rescheduleFailedExec true &&
 	test_must_fail git rebase -x false --no-reschedule-failed-exec HEAD~2 &&
 	test_must_fail git rebase --continue 2>err &&
-	! grep "has been rescheduled" err
+	test_grep ! "has been rescheduled" err
 '
 
 test_expect_success 'new rebase.rescheduleFailedExec=true setting in an ongoing rebase is ignored' '
@@ -318,7 +318,7 @@ test_expect_success 'new rebase.rescheduleFailedExec=true setting in an ongoing
 	test_must_fail git rebase -x false HEAD~2 &&
 	test_config rebase.rescheduleFailedExec true &&
 	test_must_fail git rebase --continue 2>err &&
-	! grep "has been rescheduled" err
+	test_grep ! "has been rescheduled" err
 '
 
 test_expect_success 'there is no --no-reschedule-failed-exec in an ongoing rebase' '
diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index f0bbc476ff..ecc9d036ca 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -141,8 +141,8 @@ testrebase () {
 		git checkout -b rebased-feature-branch feature-branch &&
 		echo dirty >>file3 &&
 		git rebase$type unrelated-onto-branch >actual 2>&1 &&
-		grep unrelated file4 &&
-		grep dirty file3 &&
+		test_grep unrelated file4 &&
+		test_grep dirty file3 &&
 		git checkout feature-branch
 	'
 
@@ -165,8 +165,8 @@ testrebase () {
 		echo dirty >>file3 &&
 		git add file3 &&
 		git rebase$type unrelated-onto-branch &&
-		grep unrelated file4 &&
-		grep dirty file3 &&
+		test_grep unrelated file4 &&
+		test_grep dirty file3 &&
 		git checkout feature-branch
 	'
 
@@ -197,7 +197,7 @@ testrebase () {
 		git add file2 &&
 		git rebase --continue &&
 		test_path_is_missing $dotest/autostash &&
-		grep dirty file3 &&
+		test_grep dirty file3 &&
 		git checkout feature-branch
 	'
 
@@ -212,7 +212,7 @@ testrebase () {
 		test_path_is_missing file3 &&
 		git rebase --skip &&
 		test_path_is_missing $dotest/autostash &&
-		grep dirty file3 &&
+		test_grep dirty file3 &&
 		git checkout feature-branch
 	'
 
@@ -227,7 +227,7 @@ testrebase () {
 		test_path_is_missing file3 &&
 		git rebase --abort &&
 		test_path_is_missing $dotest/autostash &&
-		grep dirty file3 &&
+		test_grep dirty file3 &&
 		git checkout feature-branch
 	'
 
@@ -260,11 +260,11 @@ testrebase () {
 		git rebase$type unrelated-onto-branch >actual 2>&1 &&
 		test_path_is_missing $dotest &&
 		git reset --hard &&
-		grep unrelated file4 &&
-		! grep dirty file4 &&
+		test_grep unrelated file4 &&
+		test_grep ! dirty file4 &&
 		git checkout feature-branch &&
 		git stash pop &&
-		grep dirty file4
+		test_grep dirty file4
 	'
 
 	test_expect_success "rebase$type: check output with conflicting stash" '
@@ -286,7 +286,7 @@ test_expect_success "rebase: fast-forward rebase" '
 	test_when_finished git branch -D behind-feature-branch &&
 	echo dirty >>file1 &&
 	git rebase feature-branch &&
-	grep dirty file1 &&
+	test_grep dirty file1 &&
 	git checkout feature-branch
 '
 
@@ -297,7 +297,7 @@ test_expect_success "rebase: noop rebase" '
 	test_when_finished git branch -D same-feature-branch &&
 	echo dirty >>file1 &&
 	git rebase feature-branch &&
-	grep dirty file1 &&
+	test_grep dirty file1 &&
 	git checkout feature-branch
 '
 
diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
index b9408f9ba1..d6830b82e0 100755
--- a/t/t3422-rebase-incompatible-options.sh
+++ b/t/t3422-rebase-incompatible-options.sh
@@ -102,13 +102,13 @@ test_rebase_am_only () {
 	test_expect_success "$opt incompatible with rebase.rebaseMerges" "
 		git checkout B^0 &&
 		test_must_fail git -c rebase.rebaseMerges=true rebase $opt A 2>err &&
-		grep -e --no-rebase-merges err
+		test_grep -e --no-rebase-merges err
 	"
 
 	test_expect_success "$opt incompatible with rebase.updateRefs" "
 		git checkout B^0 &&
 		test_must_fail git -c rebase.updateRefs=true rebase $opt A 2>err &&
-		grep -e --no-update-refs err
+		test_grep -e --no-update-refs err
 	"
 
 	test_expect_success "$opt okay with overridden rebase.rebaseMerges" "
diff --git a/t/t3429-rebase-edit-todo.sh b/t/t3429-rebase-edit-todo.sh
index abd66f3602..28e4bdd0d9 100755
--- a/t/t3429-rebase-edit-todo.sh
+++ b/t/t3429-rebase-edit-todo.sh
@@ -19,7 +19,7 @@ test_expect_success 'rebase exec modifies rebase-todo' '
 
 test_expect_success 'rebase exec with an empty list does not exec anything' '
 	git rebase HEAD -x "true" 2>output &&
-	! grep "Executing: true" output
+	test_grep ! "Executing: true" output
 '
 
 test_expect_success 'loose object cache vs re-reading todo list' '
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index 84b2d0e664..9bd61c58b3 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -161,7 +161,7 @@ test_expect_success '`reset` rejects trees' '
 	test_when_finished "test_might_fail git rebase --abort" &&
 	test_must_fail env GIT_SEQUENCE_EDITOR="echo reset A^{tree} >" \
 		git rebase -i B C >out 2>err &&
-	grep "object .* is a tree" err &&
+	test_grep "object .* is a tree" err &&
 	test_must_be_empty out
 '
 
@@ -170,7 +170,7 @@ test_expect_success '`reset` only looks for labels under refs/rewritten/' '
 	git branch refs/rewritten/my-label A &&
 	test_must_fail env GIT_SEQUENCE_EDITOR="echo reset my-label >" \
 		git rebase -i B C >out 2>err &&
-	grep "could not resolve ${SQ}my-label${SQ}" err &&
+	test_grep "could not resolve ${SQ}my-label${SQ}" err &&
 	test_must_be_empty out
 '
 
@@ -185,18 +185,18 @@ test_expect_success 'failed `merge -C` writes patch (may be rescheduled, too)' '
 	test_tick &&
 	test_must_fail git rebase -ir HEAD &&
 	test_cmp_rev REBASE_HEAD H^0 &&
-	grep "^merge -C .* G$" .git/rebase-merge/done &&
-	grep "^merge -C .* G$" .git/rebase-merge/git-rebase-todo &&
+	test_grep "^merge -C .* G$" .git/rebase-merge/done &&
+	test_grep "^merge -C .* G$" .git/rebase-merge/git-rebase-todo &&
 	test_path_is_missing .git/rebase-merge/patch &&
 	echo changed >file1 &&
 	git add file1 &&
 	test_must_fail git rebase --continue 2>err &&
-	grep "error: you have staged changes in your working tree" err &&
+	test_grep "error: you have staged changes in your working tree" err &&
 
 	: fail because of merge conflict &&
 	git reset --hard conflicting-G &&
 	test_must_fail git rebase --continue &&
-	! grep "^merge -C .* G$" .git/rebase-merge/git-rebase-todo &&
+	test_grep ! "^merge -C .* G$" .git/rebase-merge/git-rebase-todo &&
 	test_path_is_file .git/rebase-merge/patch
 '
 
@@ -208,8 +208,8 @@ test_expect_success 'failed `merge <branch>` does not crash' '
 	test_config sequence.editor \""$PWD"/replace-editor.sh\" &&
 	test_tick &&
 	test_must_fail git rebase -ir HEAD &&
-	! grep "^merge G$" .git/rebase-merge/git-rebase-todo &&
-	grep "^Merge branch ${SQ}G${SQ}$" .git/rebase-merge/message
+	test_grep ! "^merge G$" .git/rebase-merge/git-rebase-todo &&
+	test_grep "^Merge branch ${SQ}G${SQ}$" .git/rebase-merge/message
 '
 
 test_expect_success 'merge -c commits before rewording and reloads todo-list' '
@@ -481,8 +481,8 @@ test_expect_success 'labels that are object IDs are rewritten' '
 	test_config sequence.editor \""$PWD"/replace-editor.sh\" &&
 	test_tick &&
 	git rebase -i -r A &&
-	grep "^label $third-" .git/ORIGINAL-TODO &&
-	! grep "^label $third$" .git/ORIGINAL-TODO
+	test_grep "^label $third-" .git/ORIGINAL-TODO &&
+	test_grep ! "^label $third$" .git/ORIGINAL-TODO
 '
 
 test_expect_success 'octopus merges' '
@@ -533,9 +533,9 @@ test_expect_success 'with --autosquash and --exec' '
 	EOF
 	test_tick &&
 	git rebase -ir --autosquash --exec ./show.sh A >actual &&
-	grep "B: +Booh" actual &&
-	grep "E: +Booh" actual &&
-	grep "G: +G" actual
+	test_grep "B: +Booh" actual &&
+	test_grep "E: +Booh" actual &&
+	test_grep "G: +G" actual
 '
 
 test_expect_success '--continue after resolving conflicts after a merge' '
@@ -546,7 +546,7 @@ test_expect_success '--continue after resolving conflicts after a merge' '
 	git checkout -b conflicts-in-merge H &&
 	test_commit H2 H2.t conflicts H2-conflict &&
 	test_must_fail git rebase -r already-has-g &&
-	grep conflicts H2.t &&
+	test_grep conflicts H2.t &&
 	echo resolved >H2.t &&
 	git add -u &&
 	git rebase --continue &&
@@ -616,9 +616,9 @@ test_expect_success 'truncate label names' '
 
 	done="$(git rev-parse --git-path rebase-merge/done)" &&
 	git -c rebase.maxLabelLength=14 rebase --rebase-merges -x "cp \"$done\" out" --root &&
-	grep "label 0123456789-我$" out &&
+	test_grep "label 0123456789-我$" out &&
 	git -c rebase.maxLabelLength=13 rebase --rebase-merges -x "cp \"$done\" out" --root &&
-	grep "label 0123456789-$" out
+	test_grep "label 0123456789-$" out
 '
 
 test_expect_success 'reword fast-forwarded empty merge commit' '
diff --git a/t/t3500-cherry.sh b/t/t3500-cherry.sh
index 3e66827d76..03655c8a48 100755
--- a/t/t3500-cherry.sh
+++ b/t/t3500-cherry.sh
@@ -100,8 +100,8 @@ test_expect_success 'cherry in partial clone does bulk prefetch' '
 		GIT_TRACE2_EVENT="$(pwd)/trace2.output" git cherry upstream-with-space feature-without-space >actual &&
 		test_cmp ../expect actual &&
 
-		! grep "child_start.*fetch.negotiationAlgorithm" trace2.output &&
-		! grep "\"key\":\"fetch_count\"" trace2.output
+		test_grep ! "child_start.*fetch.negotiationAlgorithm" trace2.output &&
+		test_grep ! "\"key\":\"fetch_count\"" trace2.output
 	)
 '
 
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index 8025a28cfd..939e7a16a6 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -67,7 +67,7 @@ test_expect_success 'cherry-pick after renaming branch' '
 	git checkout rename2 &&
 	git cherry-pick added &&
 	test_cmp_rev rename2 HEAD^ &&
-	grep "Add extra line at the end" opos &&
+	test_grep "Add extra line at the end" opos &&
 	git reflog -1 | grep cherry-pick
 
 '
@@ -162,7 +162,7 @@ test_expect_success 'cherry-pick works with dirty renamed file' '
 	echo modified >renamed &&
 	git cherry-pick refs/heads/unrelated &&
 	test $(git rev-parse :0:renamed) = $(git rev-parse HEAD~2:to-rename.t) &&
-	grep -q "^modified$" renamed
+	test_grep -q "^modified$" renamed
 '
 
 test_expect_success 'advice from failed revert' '
@@ -253,7 +253,7 @@ test_expect_success 'identification of reverted commit (revert.reference)' '
 test_expect_success 'cherry-pick is unaware of --reference (for now)' '
 	test_when_finished "git reset --hard" &&
 	test_must_fail git cherry-pick --reference HEAD 2>actual &&
-	grep "^usage: git cherry-pick" actual
+	test_grep "^usage: git cherry-pick" actual
 '
 
 test_done
diff --git a/t/t3504-cherry-pick-rerere.sh b/t/t3504-cherry-pick-rerere.sh
index 18aeba161c..462973fa91 100755
--- a/t/t3504-cherry-pick-rerere.sh
+++ b/t/t3504-cherry-pick-rerere.sh
@@ -98,9 +98,9 @@ test_expect_success 'cherry-pick --rerere-autoupdate more than once' '
 test_expect_success 'cherry-pick conflict without rerere' '
 	test_config rerere.enabled false &&
 	test_must_fail git cherry-pick foo-main &&
-	grep ===== foo &&
-	grep foo-dev foo &&
-	grep foo-main foo
+	test_grep ===== foo &&
+	test_grep foo-dev foo &&
+	test_grep foo-main foo
 '
 
 test_done
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 66ff9db270..5777dff496 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -580,10 +580,10 @@ test_expect_success '--continue respects opts' '
 	git cat-file commit HEAD~1 >picked_msg &&
 	git cat-file commit HEAD~2 >unrelatedpick_msg &&
 	git cat-file commit HEAD~3 >initial_msg &&
-	! grep "cherry picked from" initial_msg &&
-	grep "cherry picked from" unrelatedpick_msg &&
-	grep "cherry picked from" picked_msg &&
-	grep "cherry picked from" anotherpick_msg
+	test_grep ! "cherry picked from" initial_msg &&
+	test_grep "cherry picked from" unrelatedpick_msg &&
+	test_grep "cherry picked from" picked_msg &&
+	test_grep "cherry picked from" anotherpick_msg
 '
 
 test_expect_success '--continue of single-pick respects -x' '
@@ -594,7 +594,7 @@ test_expect_success '--continue of single-pick respects -x' '
 	git cherry-pick --continue &&
 	test_path_is_missing .git/sequencer &&
 	git cat-file commit HEAD >msg &&
-	grep "cherry picked from" msg
+	test_grep "cherry picked from" msg
 '
 
 test_expect_success '--continue respects -x in first commit in multi-pick' '
@@ -606,7 +606,7 @@ test_expect_success '--continue respects -x in first commit in multi-pick' '
 	test_path_is_missing .git/sequencer &&
 	git cat-file commit HEAD^ >msg &&
 	picked=$(git rev-parse --verify picked) &&
-	grep "cherry picked from.*$picked" msg
+	test_grep "cherry picked from.*$picked" msg
 '
 
 test_expect_failure '--signoff is automatically propagated to resolved conflict' '
@@ -621,10 +621,10 @@ test_expect_failure '--signoff is automatically propagated to resolved conflict'
 	git cat-file commit HEAD~1 >picked_msg &&
 	git cat-file commit HEAD~2 >unrelatedpick_msg &&
 	git cat-file commit HEAD~3 >initial_msg &&
-	! grep "Signed-off-by:" initial_msg &&
-	grep "Signed-off-by:" unrelatedpick_msg &&
-	! grep "Signed-off-by:" picked_msg &&
-	grep "Signed-off-by:" anotherpick_msg
+	test_grep ! "Signed-off-by:" initial_msg &&
+	test_grep "Signed-off-by:" unrelatedpick_msg &&
+	test_grep ! "Signed-off-by:" picked_msg &&
+	test_grep "Signed-off-by:" anotherpick_msg
 '
 
 test_expect_failure '--signoff dropped for implicit commit of resolution, multi-pick case' '
@@ -637,7 +637,7 @@ test_expect_failure '--signoff dropped for implicit commit of resolution, multi-
 	git diff --exit-code HEAD &&
 	test_cmp_rev initial HEAD^^ &&
 	git cat-file commit HEAD^ >msg &&
-	! grep Signed-off-by: msg
+	test_grep ! Signed-off-by: msg
 '
 
 test_expect_failure 'sign-off needs to be reaffirmed after conflict resolution, single-pick case' '
@@ -650,7 +650,7 @@ test_expect_failure 'sign-off needs to be reaffirmed after conflict resolution,
 	git diff --exit-code HEAD &&
 	test_cmp_rev initial HEAD^ &&
 	git cat-file commit HEAD >msg &&
-	! grep Signed-off-by: msg
+	test_grep ! Signed-off-by: msg
 '
 
 test_expect_success 'malformed instruction sheet 1' '
diff --git a/t/t3602-rm-sparse-checkout.sh b/t/t3602-rm-sparse-checkout.sh
index 02c7acd617..252df28bbf 100755
--- a/t/t3602-rm-sparse-checkout.sh
+++ b/t/t3602-rm-sparse-checkout.sh
@@ -79,8 +79,8 @@ test_expect_success 'do not advice about sparse entries when they do not match t
 	git reset --hard &&
 	git sparse-checkout set a &&
 	test_must_fail git rm nonexistent 2>stderr &&
-	grep "fatal: pathspec .nonexistent. did not match any files" stderr &&
-	! grep -F -f sparse_error_header stderr
+	test_grep "fatal: pathspec .nonexistent. did not match any files" stderr &&
+	test_grep ! -F -f sparse_error_header stderr
 '
 
 test_expect_success 'do not warn about sparse entries when pathspec matches dense entries' '
diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
index 53a4782267..64ad7a2949 100755
--- a/t/t3705-add-sparse-checkout.sh
+++ b/t/t3705-add-sparse-checkout.sh
@@ -149,8 +149,8 @@ test_expect_success 'git add --dry-run --ignore-missing warn on sparse path' '
 test_expect_success 'do not advice about sparse entries when they do not match the pathspec' '
 	setup_sparse_entry &&
 	test_must_fail git add nonexistent 2>stderr &&
-	grep "fatal: pathspec .nonexistent. did not match any files" stderr &&
-	! grep -F -f sparse_error_header stderr
+	test_grep "fatal: pathspec .nonexistent. did not match any files" stderr &&
+	test_grep ! -F -f sparse_error_header stderr
 '
 
 test_expect_success 'do not warn when pathspec matches dense entries' '
@@ -184,19 +184,19 @@ test_expect_success 'git add fails outside of sparse-checkout definition' '
 	git -c core.autocrlf=input add --sparse sparse_entry 2>stderr &&
 	test_must_be_empty stderr &&
 	git ls-files --stage >actual &&
-	grep "^100644 .*sparse_entry\$" actual &&
+	test_grep "^100644 .*sparse_entry\$" actual &&
 
 	git add --sparse --chmod=+x sparse_entry 2>stderr &&
 	test_must_be_empty stderr &&
 	git ls-files --stage >actual &&
-	grep "^100755 .*sparse_entry\$" actual &&
+	test_grep "^100755 .*sparse_entry\$" actual &&
 
 	git reset &&
 
 	# This will print a message over stderr on Windows.
 	git add --sparse --renormalize sparse_entry &&
 	git status --porcelain >actual &&
-	grep "^M  sparse_entry\$" actual
+	test_grep "^M  sparse_entry\$" actual
 '
 
 test_expect_success 'add obeys advice.updateSparsePath' '
diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index e3cf0ffbe5..d3ddf076c4 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -535,9 +535,9 @@ test_expect_success 'invalid header entry config & fsck' '
 
 	git fsck &&
 	git -c fsck.extraHeaderEntry=warn fsck 2>err &&
-	grep "warning .*extraHeaderEntry:" err &&
+	test_grep "warning .*extraHeaderEntry:" err &&
 	test_must_fail git -c fsck.extraHeaderEntry=error 2>err fsck &&
-	grep "error .* extraHeaderEntry:" err
+	test_grep "error .* extraHeaderEntry:" err
 '
 
 cat >tag.sig <<EOF
diff --git a/t/t3901-i18n-patch.sh b/t/t3901-i18n-patch.sh
index ef7d7e1edc..b2f9301f49 100755
--- a/t/t3901-i18n-patch.sh
+++ b/t/t3901-i18n-patch.sh
@@ -81,10 +81,10 @@ test_expect_success 'format-patch output (ISO-8859-1)' '
 
 	git format-patch --stdout main..HEAD^ >out-l1 &&
 	git format-patch --stdout HEAD^ >out-l2 &&
-	grep "^Content-Type: text/plain; charset=ISO8859-1" out-l1 &&
-	grep "^From: =?ISO8859-1?q?=C1=E9=ED=20=F3=FA?=" out-l1 &&
-	grep "^Content-Type: text/plain; charset=ISO8859-1" out-l2 &&
-	grep "^From: =?ISO8859-1?q?=C1=E9=ED=20=F3=FA?=" out-l2
+	test_grep "^Content-Type: text/plain; charset=ISO8859-1" out-l1 &&
+	test_grep "^From: =?ISO8859-1?q?=C1=E9=ED=20=F3=FA?=" out-l1 &&
+	test_grep "^Content-Type: text/plain; charset=ISO8859-1" out-l2 &&
+	test_grep "^From: =?ISO8859-1?q?=C1=E9=ED=20=F3=FA?=" out-l2
 '
 
 test_expect_success 'format-patch output (UTF-8)' '
@@ -92,10 +92,10 @@ test_expect_success 'format-patch output (UTF-8)' '
 
 	git format-patch --stdout main..HEAD^ >out-u1 &&
 	git format-patch --stdout HEAD^ >out-u2 &&
-	grep "^Content-Type: text/plain; charset=UTF-8" out-u1 &&
-	grep "^From: =?UTF-8?q?=C3=81=C3=A9=C3=AD=20=C3=B3=C3=BA?=" out-u1 &&
-	grep "^Content-Type: text/plain; charset=UTF-8" out-u2 &&
-	grep "^From: =?UTF-8?q?=C3=81=C3=A9=C3=AD=20=C3=B3=C3=BA?=" out-u2
+	test_grep "^Content-Type: text/plain; charset=UTF-8" out-u1 &&
+	test_grep "^From: =?UTF-8?q?=C3=81=C3=A9=C3=AD=20=C3=B3=C3=BA?=" out-u1 &&
+	test_grep "^Content-Type: text/plain; charset=UTF-8" out-u2 &&
+	test_grep "^From: =?UTF-8?q?=C3=81=C3=A9=C3=AD=20=C3=B3=C3=BA?=" out-u2
 '
 
 test_expect_success 'rebase (U/U)' '
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index ecc35aae82..53328b8475 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -20,21 +20,21 @@ test_expect_success 'setup' '
 
 test_expect_success 'usage on cmd and subcommand invalid option' '
 	test_expect_code 129 git stash --invalid-option 2>usage &&
-	grep "or: git stash" usage &&
+	test_grep "or: git stash" usage &&
 
 	test_expect_code 129 git stash push --invalid-option 2>usage &&
-	! grep "or: git stash" usage
+	test_grep ! "or: git stash" usage
 '
 
 test_expect_success 'usage on main command -h emits a summary of subcommands' '
 	test_expect_code 129 git stash -h >usage &&
-	grep -F "usage: git stash list" usage &&
-	grep -F "or: git stash show" usage
+	test_grep -F "usage: git stash list" usage &&
+	test_grep -F "or: git stash show" usage
 '
 
 test_expect_success 'usage for subcommands should emit subcommand usage' '
 	test_expect_code 129 git stash push -h >usage &&
-	grep -F "usage: git stash [push" usage
+	test_grep -F "usage: git stash [push" usage
 '
 
 diff_cmp () {
@@ -965,7 +965,7 @@ test_expect_success 'store updates stash ref and reflog' '
 	test $(git rev-parse stash) = $STASH_ID &&
 	git reflog --format=%H stash| grep $STASH_ID &&
 	git stash pop &&
-	grep quux bazzy
+	test_grep quux bazzy
 '
 
 test_expect_success 'handle stash specification with spaces' '
@@ -977,7 +977,7 @@ test_expect_success 'handle stash specification with spaces' '
 	echo cow >file &&
 	git stash &&
 	git stash apply "stash@{$stamp}" &&
-	grep pig file
+	test_grep pig file
 '
 
 test_expect_success 'setup stash with index and worktree changes' '
@@ -1500,9 +1500,9 @@ test_expect_success 'stash export can accept specified stashes' '
 
 test_expect_success 'stash export rejects invalid arguments' '
 	test_must_fail git stash export --print --to-ref refs/heads/invalid 2>err &&
-	grep "exactly one of --print and --to-ref is required" err &&
+	test_grep "exactly one of --print and --to-ref is required" err &&
 	test_must_fail git stash export 2>err2 &&
-	grep "exactly one of --print and --to-ref is required" err2
+	test_grep "exactly one of --print and --to-ref is required" err2
 '
 
 test_expect_success 'stash can import and export zero stashes' '
@@ -1519,7 +1519,7 @@ test_expect_success 'stash rejects invalid attempts to import commits' '
 	git stash import foo &&
 	test_must_fail git stash import HEAD 2>output &&
 	oid=$(git rev-parse HEAD) &&
-	grep "$oid is not a valid exported stash commit" output &&
+	test_grep "$oid is not a valid exported stash commit" output &&
 	test_cmp_rev stash@{0} t-stash0 &&
 
 	git checkout --orphan orphan &&
@@ -1527,7 +1527,7 @@ test_expect_success 'stash rejects invalid attempts to import commits' '
 	git update-ref refs/heads/orphan "$(cat fake-commit)" &&
 	oid=$(git rev-parse HEAD) &&
 	test_must_fail git stash import orphan 2>output &&
-	grep "found stash commit $oid without expected prefix" output &&
+	test_grep "found stash commit $oid without expected prefix" output &&
 	test_cmp_rev stash@{0} t-stash0 &&
 
 	git checkout --orphan orphan2 &&
@@ -1535,7 +1535,7 @@ test_expect_success 'stash rejects invalid attempts to import commits' '
 	git update-ref refs/heads/orphan2 "$(cat fake-commit)" &&
 	oid=$(git rev-parse HEAD) &&
 	test_must_fail git stash import orphan2 2>output &&
-	grep "found root commit $oid with invalid data" output &&
+	test_grep "found root commit $oid with invalid data" output &&
 	test_cmp_rev stash@{0} t-stash0
 '
 
@@ -1741,7 +1741,7 @@ test_expect_success 'submodules does not affect the branch recorded in stash mes
 		git stash push -m "custom stash for work_branch" &&
 
 		git stash list >../actual_stash_list.txt &&
-		grep "On work_branch: custom stash for work_branch" ../actual_stash_list.txt
+		test_grep "On work_branch: custom stash for work_branch" ../actual_stash_list.txt
 	)
 '
 
@@ -1751,7 +1751,7 @@ test_expect_success SANITIZE_LEAK 'stash show handles -- without leaking' '
 
 test_expect_success 'controlled error return on unrecognized option' '
 	test_expect_code 129 git stash show -p --invalid 2>usage &&
-	grep -e "^usage: git stash show" usage
+	test_grep -e "^usage: git stash show" usage
 '
 
 test_expect_success 'stash.index=true implies --index' '
diff --git a/t/t3904-stash-patch.sh b/t/t3904-stash-patch.sh
index 90a4ff2c10..adc45c7073 100755
--- a/t/t3904-stash-patch.sh
+++ b/t/t3904-stash-patch.sh
@@ -103,8 +103,8 @@ test_expect_success 'stash -p with split hunk' '
 	printf "%s\n" s n y q |
 	git stash -p 2>error &&
 	test_must_be_empty error &&
-	grep "added line 1" test &&
-	! grep "added line 2" test
+	test_grep "added line 1" test &&
+	test_grep ! "added line 2" test
 '
 
 test_expect_success 'stash -p not confused by GIT_PAGER_IN_USE' '
diff --git a/t/t3908-stash-in-worktree.sh b/t/t3908-stash-in-worktree.sh
index 2b2b366ef9..e7ae838bb2 100755
--- a/t/t3908-stash-in-worktree.sh
+++ b/t/t3908-stash-in-worktree.sh
@@ -21,7 +21,7 @@ test_expect_success 'apply in subdirectory' '
 		git stash &&
 		git stash apply >out
 	) &&
-	grep "\.\.\/initial\.t" wt/subdir/out
+	test_grep "\.\.\/initial\.t" wt/subdir/out
 '
 
 test_done
diff --git a/t/t4000-diff-format.sh b/t/t4000-diff-format.sh
index 32b14e3a71..74dec7d34a 100755
--- a/t/t4000-diff-format.sh
+++ b/t/t4000-diff-format.sh
@@ -84,7 +84,7 @@ test_expect_success 'git diff-files --no-patch --patch shows the patch' '
 
 test_expect_success 'git diff-files --no-patch --patch-with-raw shows the patch and raw data' '
 	git diff-files --no-patch --patch-with-raw >actual &&
-	grep -q "^:100644 100755 .* $ZERO_OID M	path0\$" actual &&
+	test_grep -q "^:100644 100755 .* $ZERO_OID M	path0\$" actual &&
 	tail -n +4 actual >actual-patch &&
 	compare_diff_patch expected actual-patch
 '
diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
index 4f520d600d..ad474100af 100755
--- a/t/t4001-diff-rename.sh
+++ b/t/t4001-diff-rename.sh
@@ -189,7 +189,7 @@ test_expect_success 'setup for many rename source candidates' '
 	M	path1
 	EOF
 	test_cmp expect actual.munged &&
-	grep warning actual.err
+	test_grep warning actual.err
 '
 
 test_expect_success 'rename pretty print with nothing in common' '
@@ -258,7 +258,7 @@ test_expect_success 'diff-tree -l0 defaults to a big rename limit, not zero' '
 
 	git diff-tree -M -l0 HEAD HEAD^ >actual &&
 	# Verify that a rename from myotherfile to myfile was detected
-	grep "myotherfile.*myfile" actual
+	test_grep "myotherfile.*myfile" actual
 '
 
 test_expect_success 'basename similarity vs best similarity' '
diff --git a/t/t4011-diff-symlink.sh b/t/t4011-diff-symlink.sh
index ac837b6c9e..4103bd6989 100755
--- a/t/t4011-diff-symlink.sh
+++ b/t/t4011-diff-symlink.sh
@@ -140,7 +140,7 @@ test_expect_success SYMLINKS 'diff symlinks with non-existing targets' '
 	ln -s narf pinky &&
 	ln -s take\ over brain &&
 	test_must_fail git diff --no-index pinky brain >output 2>output.err &&
-	grep narf output &&
+	test_grep narf output &&
 	test_must_be_empty output.err
 '
 
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index d35695f5b0..b7a382c881 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -778,7 +778,7 @@ test_expect_success 'diff.{src,dst}Prefix ignored with --default-prefix' '
 test_expect_success 'diff --no-renames cannot be abbreviated' '
 	test_expect_code 129 git diff --no-rename >actual 2>error &&
 	test_must_be_empty actual &&
-	grep "invalid option: --no-rename" error
+	test_grep "invalid option: --no-rename" error
 '
 
 test_done
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 0b89d127b5..4afcd85779 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -119,17 +119,17 @@ test_expect_success 'format-patch --ignore-if-in-upstream result applies' '
 
 test_expect_success 'commit did not screw up the log message' '
 	git cat-file commit side >actual &&
-	grep "^Side .* with .* backslash-n" actual
+	test_grep "^Side .* with .* backslash-n" actual
 '
 
 test_expect_success 'format-patch did not screw up the log message' '
-	grep "^Subject: .*Side changes #3 with .* backslash-n" patch0 &&
-	grep "^Subject: .*Side changes #3 with .* backslash-n" patch1
+	test_grep "^Subject: .*Side changes #3 with .* backslash-n" patch0 &&
+	test_grep "^Subject: .*Side changes #3 with .* backslash-n" patch1
 '
 
 test_expect_success 'replay did not screw up the log message' '
 	git cat-file commit rebuild-1 >actual &&
-	grep "^Side .* with .* backslash-n" actual
+	test_grep "^Side .* with .* backslash-n" actual
 '
 
 test_expect_success 'format-patch empty commit' '
@@ -145,8 +145,8 @@ test_expect_success 'extra headers' '
 " &&
 	git format-patch --stdout main..side >patch2 &&
 	sed -e "/^\$/q" patch2 >hdrs2 &&
-	grep "^To: R E Cipient <rcipient@example.com>\$" hdrs2 &&
-	grep "^Cc: S E Cipient <scipient@example.com>\$" hdrs2
+	test_grep "^To: R E Cipient <rcipient@example.com>\$" hdrs2 &&
+	test_grep "^Cc: S E Cipient <scipient@example.com>\$" hdrs2
 '
 
 test_expect_success 'extra headers without newlines' '
@@ -154,8 +154,8 @@ test_expect_success 'extra headers without newlines' '
 	git config --add format.headers "Cc: S E Cipient <scipient@example.com>" &&
 	git format-patch --stdout main..side >patch3 &&
 	sed -e "/^\$/q" patch3 >hdrs3 &&
-	grep "^To: R E Cipient <rcipient@example.com>\$" hdrs3 &&
-	grep "^Cc: S E Cipient <scipient@example.com>\$" hdrs3
+	test_grep "^To: R E Cipient <rcipient@example.com>\$" hdrs3 &&
+	test_grep "^Cc: S E Cipient <scipient@example.com>\$" hdrs3
 '
 
 test_expect_success 'extra headers with multiple To:s' '
@@ -163,79 +163,79 @@ test_expect_success 'extra headers with multiple To:s' '
 	git config --add format.headers "To: S E Cipient <scipient@example.com>" &&
 	git format-patch --stdout main..side >patch4 &&
 	sed -e "/^\$/q" patch4 >hdrs4 &&
-	grep "^To: R E Cipient <rcipient@example.com>,\$" hdrs4 &&
-	grep "^ *S E Cipient <scipient@example.com>\$" hdrs4
+	test_grep "^To: R E Cipient <rcipient@example.com>,\$" hdrs4 &&
+	test_grep "^ *S E Cipient <scipient@example.com>\$" hdrs4
 '
 
 test_expect_success 'additional command line cc (ascii)' '
 	git config --replace-all format.headers "Cc: R E Cipient <rcipient@example.com>" &&
 	git format-patch --cc="S E Cipient <scipient@example.com>" --stdout main..side >patch5 &&
 	sed -e "/^\$/q" patch5 >hdrs5 &&
-	grep "^Cc: R E Cipient <rcipient@example.com>,\$" hdrs5 &&
-	grep "^ *S E Cipient <scipient@example.com>\$" hdrs5
+	test_grep "^Cc: R E Cipient <rcipient@example.com>,\$" hdrs5 &&
+	test_grep "^ *S E Cipient <scipient@example.com>\$" hdrs5
 '
 
 test_expect_failure 'additional command line cc (rfc822)' '
 	git config --replace-all format.headers "Cc: R E Cipient <rcipient@example.com>" &&
 	git format-patch --cc="S. E. Cipient <scipient@example.com>" --stdout main..side >patch5 &&
 	sed -e "/^\$/q" patch5 >hdrs5 &&
-	grep "^Cc: R E Cipient <rcipient@example.com>,\$" hdrs5 &&
-	grep "^ *\"S. E. Cipient\" <scipient@example.com>\$" hdrs5
+	test_grep "^Cc: R E Cipient <rcipient@example.com>,\$" hdrs5 &&
+	test_grep "^ *\"S. E. Cipient\" <scipient@example.com>\$" hdrs5
 '
 
 test_expect_success 'command line headers' '
 	git config --unset-all format.headers &&
 	git format-patch --add-header="Cc: R E Cipient <rcipient@example.com>" --stdout main..side >patch6 &&
 	sed -e "/^\$/q" patch6 >hdrs6 &&
-	grep "^Cc: R E Cipient <rcipient@example.com>\$" hdrs6
+	test_grep "^Cc: R E Cipient <rcipient@example.com>\$" hdrs6
 '
 
 test_expect_success 'configuration headers and command line headers' '
 	git config --replace-all format.headers "Cc: R E Cipient <rcipient@example.com>" &&
 	git format-patch --add-header="Cc: S E Cipient <scipient@example.com>" --stdout main..side >patch7 &&
 	sed -e "/^\$/q" patch7 >hdrs7 &&
-	grep "^Cc: R E Cipient <rcipient@example.com>,\$" hdrs7 &&
-	grep "^ *S E Cipient <scipient@example.com>\$" hdrs7
+	test_grep "^Cc: R E Cipient <rcipient@example.com>,\$" hdrs7 &&
+	test_grep "^ *S E Cipient <scipient@example.com>\$" hdrs7
 '
 
 test_expect_success 'command line To: header (ascii)' '
 	git config --unset-all format.headers &&
 	git format-patch --to="R E Cipient <rcipient@example.com>" --stdout main..side >patch8 &&
 	sed -e "/^\$/q" patch8 >hdrs8 &&
-	grep "^To: R E Cipient <rcipient@example.com>\$" hdrs8
+	test_grep "^To: R E Cipient <rcipient@example.com>\$" hdrs8
 '
 
 test_expect_failure 'command line To: header (rfc822)' '
 	git format-patch --to="R. E. Cipient <rcipient@example.com>" --stdout main..side >patch8 &&
 	sed -e "/^\$/q" patch8 >hdrs8 &&
-	grep "^To: \"R. E. Cipient\" <rcipient@example.com>\$" hdrs8
+	test_grep "^To: \"R. E. Cipient\" <rcipient@example.com>\$" hdrs8
 '
 
 test_expect_failure 'command line To: header (rfc2047)' '
 	git format-patch --to="R Ä Cipient <rcipient@example.com>" --stdout main..side >patch8 &&
 	sed -e "/^\$/q" patch8 >hdrs8 &&
-	grep "^To: =?UTF-8?q?R=20=C3=84=20Cipient?= <rcipient@example.com>\$" hdrs8
+	test_grep "^To: =?UTF-8?q?R=20=C3=84=20Cipient?= <rcipient@example.com>\$" hdrs8
 '
 
 test_expect_success 'configuration To: header (ascii)' '
 	git config format.to "R E Cipient <rcipient@example.com>" &&
 	git format-patch --stdout main..side >patch9 &&
 	sed -e "/^\$/q" patch9 >hdrs9 &&
-	grep "^To: R E Cipient <rcipient@example.com>\$" hdrs9
+	test_grep "^To: R E Cipient <rcipient@example.com>\$" hdrs9
 '
 
 test_expect_failure 'configuration To: header (rfc822)' '
 	git config format.to "R. E. Cipient <rcipient@example.com>" &&
 	git format-patch --stdout main..side >patch9 &&
 	sed -e "/^\$/q" patch9 >hdrs9 &&
-	grep "^To: \"R. E. Cipient\" <rcipient@example.com>\$" hdrs9
+	test_grep "^To: \"R. E. Cipient\" <rcipient@example.com>\$" hdrs9
 '
 
 test_expect_failure 'configuration To: header (rfc2047)' '
 	git config format.to "R Ä Cipient <rcipient@example.com>" &&
 	git format-patch --stdout main..side >patch9 &&
 	sed -e "/^\$/q" patch9 >hdrs9 &&
-	grep "^To: =?UTF-8?q?R=20=C3=84=20Cipient?= <rcipient@example.com>\$" hdrs9
+	test_grep "^To: =?UTF-8?q?R=20=C3=84=20Cipient?= <rcipient@example.com>\$" hdrs9
 '
 
 # check_patch <patch>: Verify that <patch> looks like a half-sane
@@ -250,35 +250,35 @@ test_expect_success 'format.from=false' '
 	git -c format.from=false format-patch --stdout main..side >patch &&
 	sed -e "/^\$/q" patch >hdrs &&
 	check_patch patch &&
-	! grep "^From: C O Mitter <committer@example.com>\$" hdrs
+	test_grep ! "^From: C O Mitter <committer@example.com>\$" hdrs
 '
 
 test_expect_success 'format.from=true' '
 	git -c format.from=true format-patch --stdout main..side >patch &&
 	sed -e "/^\$/q" patch >hdrs &&
 	check_patch hdrs &&
-	grep "^From: C O Mitter <committer@example.com>\$" hdrs
+	test_grep "^From: C O Mitter <committer@example.com>\$" hdrs
 '
 
 test_expect_success 'format.from with address' '
 	git -c format.from="F R Om <from@example.com>" format-patch --stdout main..side >patch &&
 	sed -e "/^\$/q" patch >hdrs &&
 	check_patch hdrs &&
-	grep "^From: F R Om <from@example.com>\$" hdrs
+	test_grep "^From: F R Om <from@example.com>\$" hdrs
 '
 
 test_expect_success '--no-from overrides format.from' '
 	git -c format.from="F R Om <from@example.com>" format-patch --no-from --stdout main..side >patch &&
 	sed -e "/^\$/q" patch >hdrs &&
 	check_patch hdrs &&
-	! grep "^From: F R Om <from@example.com>\$" hdrs
+	test_grep ! "^From: F R Om <from@example.com>\$" hdrs
 '
 
 test_expect_success '--from overrides format.from' '
 	git -c format.from="F R Om <from@example.com>" format-patch --from --stdout main..side >patch &&
 	sed -e "/^\$/q" patch >hdrs &&
 	check_patch hdrs &&
-	! grep "^From: F R Om <from@example.com>\$" hdrs
+	test_grep ! "^From: F R Om <from@example.com>\$" hdrs
 '
 
 test_expect_success '--no-to overrides config.to' '
@@ -287,7 +287,7 @@ test_expect_success '--no-to overrides config.to' '
 	git format-patch --no-to --stdout main..side >patch10 &&
 	sed -e "/^\$/q" patch10 >hdrs10 &&
 	check_patch hdrs10 &&
-	! grep "^To: R E Cipient <rcipient@example.com>\$" hdrs10
+	test_grep ! "^To: R E Cipient <rcipient@example.com>\$" hdrs10
 '
 
 test_expect_success '--no-to and --to replaces config.to' '
@@ -297,8 +297,8 @@ test_expect_success '--no-to and --to replaces config.to' '
 		--stdout main..side >patch11 &&
 	sed -e "/^\$/q" patch11 >hdrs11 &&
 	check_patch hdrs11 &&
-	! grep "^To: Someone <someone@out.there>\$" hdrs11 &&
-	grep "^To: Someone Else <else@out.there>\$" hdrs11
+	test_grep ! "^To: Someone <someone@out.there>\$" hdrs11 &&
+	test_grep "^To: Someone Else <else@out.there>\$" hdrs11
 '
 
 test_expect_success '--no-cc overrides config.cc' '
@@ -307,7 +307,7 @@ test_expect_success '--no-cc overrides config.cc' '
 	git format-patch --no-cc --stdout main..side >patch12 &&
 	sed -e "/^\$/q" patch12 >hdrs12 &&
 	check_patch hdrs12 &&
-	! grep "^Cc: C E Cipient <rcipient@example.com>\$" hdrs12
+	test_grep ! "^Cc: C E Cipient <rcipient@example.com>\$" hdrs12
 '
 
 test_expect_success '--no-add-header overrides config.headers' '
@@ -316,7 +316,7 @@ test_expect_success '--no-add-header overrides config.headers' '
 	git format-patch --no-add-header --stdout main..side >patch13 &&
 	sed -e "/^\$/q" patch13 >hdrs13 &&
 	check_patch hdrs13 &&
-	! grep "^Header1: B E Cipient <rcipient@example.com>\$" hdrs13
+	test_grep ! "^Header1: B E Cipient <rcipient@example.com>\$" hdrs13
 '
 
 test_expect_success 'multiple files' '
@@ -508,41 +508,41 @@ test_expect_success 'cover letter config commitlistformat not set' '
 test_expect_success 'reroll count' '
 	rm -fr patches &&
 	git format-patch -o patches --cover-letter --reroll-count 4 main..side >list &&
-	! grep -v "^patches/v4-000[0-3]-" list &&
+	test_grep ! -v "^patches/v4-000[0-3]-" list &&
 	sed -n -e "/^Subject: /p" $(cat list) >subjects &&
-	! grep -v "^Subject: \[PATCH v4 [0-3]/3\] " subjects
+	test_grep ! -v "^Subject: \[PATCH v4 [0-3]/3\] " subjects
 '
 
 test_expect_success 'reroll count (-v)' '
 	rm -fr patches &&
 	git format-patch -o patches --cover-letter -v4 main..side >list &&
-	! grep -v "^patches/v4-000[0-3]-" list &&
+	test_grep ! -v "^patches/v4-000[0-3]-" list &&
 	sed -n -e "/^Subject: /p" $(cat list) >subjects &&
-	! grep -v "^Subject: \[PATCH v4 [0-3]/3\] " subjects
+	test_grep ! -v "^Subject: \[PATCH v4 [0-3]/3\] " subjects
 '
 
 test_expect_success 'reroll count (-v) with a fractional number' '
 	rm -fr patches &&
 	git format-patch -o patches --cover-letter -v4.4 main..side >list &&
-	! grep -v "^patches/v4.4-000[0-3]-" list &&
+	test_grep ! -v "^patches/v4.4-000[0-3]-" list &&
 	sed -n -e "/^Subject: /p" $(cat list) >subjects &&
-	! grep -v "^Subject: \[PATCH v4.4 [0-3]/3\] " subjects
+	test_grep ! -v "^Subject: \[PATCH v4.4 [0-3]/3\] " subjects
 '
 
 test_expect_success 'reroll (-v) count with a non number' '
 	rm -fr patches &&
 	git format-patch -o patches --cover-letter -v4rev2 main..side >list &&
-	! grep -v "^patches/v4rev2-000[0-3]-" list &&
+	test_grep ! -v "^patches/v4rev2-000[0-3]-" list &&
 	sed -n -e "/^Subject: /p" $(cat list) >subjects &&
-	! grep -v "^Subject: \[PATCH v4rev2 [0-3]/3\] " subjects
+	test_grep ! -v "^Subject: \[PATCH v4rev2 [0-3]/3\] " subjects
 '
 
 test_expect_success 'reroll (-v) count with a non-pathname character' '
 	rm -fr patches &&
 	git format-patch -o patches --cover-letter -v4---..././../--1/.2//  main..side >list &&
-	! grep -v "patches/v4-\.-\.-\.-1-\.2-000[0-3]-" list &&
+	test_grep ! -v "patches/v4-\.-\.-\.-1-\.2-000[0-3]-" list &&
 	sed -n -e "/^Subject: /p" $(cat list) >subjects &&
-	! grep -v "^Subject: \[PATCH v4---\.\.\./\./\.\./--1/\.2// [0-3]/3\] " subjects
+	test_grep ! -v "^Subject: \[PATCH v4---\.\.\./\./\.\./--1/\.2// [0-3]/3\] " subjects
 '
 
 check_threading () {
@@ -813,9 +813,9 @@ test_expect_success 'cover-letter inherits diff options' '
 	git commit -m foo &&
 	git format-patch --no-renames --cover-letter -1 &&
 	check_patch 0000-cover-letter.patch &&
-	! grep "file => foo .* 0 *\$" 0000-cover-letter.patch &&
+	test_grep ! "file => foo .* 0 *\$" 0000-cover-letter.patch &&
 	git format-patch --cover-letter -1 -M &&
-	grep "file => foo .* 0 *\$" 0000-cover-letter.patch
+	test_grep "file => foo .* 0 *\$" 0000-cover-letter.patch
 '
 
 cat >expect <<EOF
@@ -924,13 +924,13 @@ test_expect_success 'format-patch from a subdirectory (3)' '
 
 test_expect_success 'format-patch --in-reply-to' '
 	git format-patch -1 --stdout --in-reply-to "baz@foo.bar" >patch8 &&
-	grep "^In-Reply-To: <baz@foo.bar>" patch8 &&
-	grep "^References: <baz@foo.bar>" patch8
+	test_grep "^In-Reply-To: <baz@foo.bar>" patch8 &&
+	test_grep "^References: <baz@foo.bar>" patch8
 '
 
 test_expect_success 'format-patch --signoff' '
 	git format-patch -1 --signoff --stdout >out &&
-	grep "^Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" out
+	test_grep "^Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" out
 '
 
 test_expect_success 'format-patch --notes --signoff' '
@@ -949,27 +949,27 @@ test_expect_success 'format-patch notes output control' '
 	git notes add -m "notes config message" HEAD &&
 
 	git format-patch -1 --stdout >out &&
-	! grep "notes config message" out &&
+	test_grep ! "notes config message" out &&
 	git format-patch -1 --stdout --notes >out &&
-	grep "notes config message" out &&
+	test_grep "notes config message" out &&
 	git format-patch -1 --stdout --no-notes >out &&
-	! grep "notes config message" out &&
+	test_grep ! "notes config message" out &&
 	git format-patch -1 --stdout --notes --no-notes >out &&
-	! grep "notes config message" out &&
+	test_grep ! "notes config message" out &&
 	git format-patch -1 --stdout --no-notes --notes >out &&
-	grep "notes config message" out &&
+	test_grep "notes config message" out &&
 
 	test_config format.notes true &&
 	git format-patch -1 --stdout >out &&
-	grep "notes config message" out &&
+	test_grep "notes config message" out &&
 	git format-patch -1 --stdout --notes >out &&
-	grep "notes config message" out &&
+	test_grep "notes config message" out &&
 	git format-patch -1 --stdout --no-notes >out &&
-	! grep "notes config message" out &&
+	test_grep ! "notes config message" out &&
 	git format-patch -1 --stdout --notes --no-notes >out &&
-	! grep "notes config message" out &&
+	test_grep ! "notes config message" out &&
 	git format-patch -1 --stdout --no-notes --notes >out &&
-	grep "notes config message" out
+	test_grep "notes config message" out
 '
 
 test_expect_success 'format-patch with multiple notes refs' '
@@ -979,39 +979,39 @@ test_expect_success 'format-patch with multiple notes refs' '
 	git notes --ref note2 add -m "this is note 2" HEAD &&
 
 	git format-patch -1 --stdout >out &&
-	! grep "this is note 1" out &&
-	! grep "this is note 2" out &&
+	test_grep ! "this is note 1" out &&
+	test_grep ! "this is note 2" out &&
 	git format-patch -1 --stdout --notes=note1 >out &&
-	grep "this is note 1" out &&
-	! grep "this is note 2" out &&
+	test_grep "this is note 1" out &&
+	test_grep ! "this is note 2" out &&
 	git format-patch -1 --stdout --notes=note2 >out &&
-	! grep "this is note 1" out &&
-	grep "this is note 2" out &&
+	test_grep ! "this is note 1" out &&
+	test_grep "this is note 2" out &&
 	git format-patch -1 --stdout --notes=note1 --notes=note2 >out &&
-	grep "this is note 1" out &&
-	grep "this is note 2" out &&
+	test_grep "this is note 1" out &&
+	test_grep "this is note 2" out &&
 
 	test_config format.notes note1 &&
 	git format-patch -1 --stdout >out &&
-	grep "this is note 1" out &&
-	! grep "this is note 2" out &&
+	test_grep "this is note 1" out &&
+	test_grep ! "this is note 2" out &&
 	git format-patch -1 --stdout --no-notes >out &&
-	! grep "this is note 1" out &&
-	! grep "this is note 2" out &&
+	test_grep ! "this is note 1" out &&
+	test_grep ! "this is note 2" out &&
 	git format-patch -1 --stdout --notes=note2 >out &&
-	grep "this is note 1" out &&
-	grep "this is note 2" out &&
+	test_grep "this is note 1" out &&
+	test_grep "this is note 2" out &&
 	git format-patch -1 --stdout --no-notes --notes=note2 >out &&
-	! grep "this is note 1" out &&
-	grep "this is note 2" out &&
+	test_grep ! "this is note 1" out &&
+	test_grep "this is note 2" out &&
 
 	git config --add format.notes note2 &&
 	git format-patch -1 --stdout >out &&
-	grep "this is note 1" out &&
-	grep "this is note 2" out &&
+	test_grep "this is note 1" out &&
+	test_grep "this is note 2" out &&
 	git format-patch -1 --stdout --no-notes >out &&
-	! grep "this is note 1" out &&
-	! grep "this is note 2" out
+	test_grep ! "this is note 1" out &&
+	test_grep ! "this is note 2" out
 '
 
 test_expect_success 'format-patch with multiple notes refs in config' '
@@ -1024,26 +1024,26 @@ test_expect_success 'format-patch with multiple notes refs in config' '
 
 	git config format.notes note1 &&
 	git format-patch -1 --stdout >out &&
-	grep "this is note 1" out &&
-	! grep "this is note 2" out &&
+	test_grep "this is note 1" out &&
+	test_grep ! "this is note 2" out &&
 	git config format.notes note2 &&
 	git format-patch -1 --stdout >out &&
-	! grep "this is note 1" out &&
-	grep "this is note 2" out &&
+	test_grep ! "this is note 1" out &&
+	test_grep "this is note 2" out &&
 	git config --add format.notes note1 &&
 	git format-patch -1 --stdout >out &&
-	grep "this is note 1" out &&
-	grep "this is note 2" out &&
+	test_grep "this is note 1" out &&
+	test_grep "this is note 2" out &&
 
 	git config --replace-all format.notes note1 &&
 	git config --add format.notes false &&
 	git format-patch -1 --stdout >out &&
-	! grep "this is note 1" out &&
-	! grep "this is note 2" out &&
+	test_grep ! "this is note 1" out &&
+	test_grep ! "this is note 2" out &&
 	git config --add format.notes note2 &&
 	git format-patch -1 --stdout >out &&
-	! grep "this is note 1" out &&
-	grep "this is note 2" out
+	test_grep ! "this is note 1" out &&
+	test_grep "this is note 2" out
 '
 
 echo "fatal: --name-only does not make sense" >expect.name-only
@@ -1095,7 +1095,7 @@ test_expect_success 'format-patch -- <path>' '
 
 	git format-patch main..pathspec -- file_a >output &&
 	test_cmp expect output &&
-	! grep file_b *.patch
+	test_grep ! file_b *.patch
 '
 
 test_expect_success 'format-patch --ignore-if-in-upstream HEAD' '
@@ -1129,14 +1129,14 @@ test_expect_success 'format-patch --signature' '
 test_expect_success 'format-patch with format.signature config' '
 	git config format.signature "config sig" &&
 	git format-patch --stdout -1 >output &&
-	grep "config sig" output
+	test_grep "config sig" output
 '
 
 test_expect_success 'format-patch --signature overrides format.signature' '
 	git config format.signature "config sig" &&
 	git format-patch --stdout --signature="overrides" -1 >output &&
-	! grep "config sig" output &&
-	grep "overrides" output
+	test_grep ! "config sig" output &&
+	test_grep "overrides" output
 '
 
 test_expect_success 'format-patch --no-signature ignores format.signature' '
@@ -1144,9 +1144,9 @@ test_expect_success 'format-patch --no-signature ignores format.signature' '
 	git format-patch --stdout --signature="my sig" --no-signature \
 		-1 >output &&
 	check_patch output &&
-	! grep "config sig" output &&
-	! grep "my sig" output &&
-	! grep "^-- \$" output
+	test_grep ! "config sig" output &&
+	test_grep ! "my sig" output &&
+	test_grep ! "^-- \$" output
 '
 
 test_expect_success 'format-patch --signature --cover-letter' '
@@ -1161,20 +1161,20 @@ test_expect_success 'format.signature="" suppresses signatures' '
 	git config format.signature "" &&
 	git format-patch --stdout -1 >output &&
 	check_patch output &&
-	! grep "^-- \$" output
+	test_grep ! "^-- \$" output
 '
 
 test_expect_success 'format-patch --no-signature suppresses signatures' '
 	git config --unset-all format.signature &&
 	git format-patch --stdout --no-signature -1 >output &&
 	check_patch output &&
-	! grep "^-- \$" output
+	test_grep ! "^-- \$" output
 '
 
 test_expect_success 'format-patch --signature="" suppresses signatures' '
 	git format-patch --stdout --signature="" -1 >output &&
 	check_patch output &&
-	! grep "^-- \$" output
+	test_grep ! "^-- \$" output
 '
 
 test_expect_success 'prepare mail-signature input' '
@@ -1213,7 +1213,7 @@ test_expect_success '--no-signature suppresses format.signaturefile ' '
 	test_config format.signaturefile mail-signature &&
 	git format-patch --stdout --no-signature -1 >output &&
 	check_patch output &&
-	! grep "^-- \$" output
+	test_grep ! "^-- \$" output
 '
 
 test_expect_success '--signature-file overrides format.signaturefile' '
@@ -1235,7 +1235,7 @@ test_expect_success '--signature overrides format.signaturefile' '
 	test_config format.signaturefile mail-signature &&
 	git format-patch --stdout --signature="my sig" -1 >output &&
 	check_patch output &&
-	grep "my sig" output
+	test_grep "my sig" output
 '
 
 test_expect_success TTY 'format-patch --stdout paginates' '
@@ -2001,10 +2001,10 @@ body" &&
 	test_config format.coverFromDescription default &&
 	git checkout rebuild-1 &&
 	git format-patch --stdout --cover-letter main >actual &&
-	grep "^Subject: \[PATCH 0/2\] \*\*\* SUBJECT HERE \*\*\*$" actual &&
-	! grep "^\*\*\* BLURB HERE \*\*\*$" actual &&
-	grep "^config subject$" actual &&
-	grep "^body$" actual
+	test_grep "^Subject: \[PATCH 0/2\] \*\*\* SUBJECT HERE \*\*\*$" actual &&
+	test_grep ! "^\*\*\* BLURB HERE \*\*\*$" actual &&
+	test_grep "^config subject$" actual &&
+	test_grep "^body$" actual
 '
 
 test_expect_success 'cover letter with --cover-from-description default' '
@@ -2013,10 +2013,10 @@ test_expect_success 'cover letter with --cover-from-description default' '
 body" &&
 	git checkout rebuild-1 &&
 	git format-patch --stdout --cover-letter --cover-from-description default main >actual &&
-	grep "^Subject: \[PATCH 0/2\] \*\*\* SUBJECT HERE \*\*\*$" actual &&
-	! grep "^\*\*\* BLURB HERE \*\*\*$" actual &&
-	grep "^config subject$" actual &&
-	grep "^body$" actual
+	test_grep "^Subject: \[PATCH 0/2\] \*\*\* SUBJECT HERE \*\*\*$" actual &&
+	test_grep ! "^\*\*\* BLURB HERE \*\*\*$" actual &&
+	test_grep "^config subject$" actual &&
+	test_grep "^body$" actual
 '
 
 test_expect_success 'cover letter with format.coverFromDescription = none' '
@@ -2026,10 +2026,10 @@ body" &&
 	test_config format.coverFromDescription none &&
 	git checkout rebuild-1 &&
 	git format-patch --stdout --cover-letter main >actual &&
-	grep "^Subject: \[PATCH 0/2\] \*\*\* SUBJECT HERE \*\*\*$" actual &&
-	grep "^\*\*\* BLURB HERE \*\*\*$" actual &&
-	! grep "^config subject$" actual &&
-	! grep "^body$" actual
+	test_grep "^Subject: \[PATCH 0/2\] \*\*\* SUBJECT HERE \*\*\*$" actual &&
+	test_grep "^\*\*\* BLURB HERE \*\*\*$" actual &&
+	test_grep ! "^config subject$" actual &&
+	test_grep ! "^body$" actual
 '
 
 test_expect_success 'cover letter with --cover-from-description none' '
@@ -2038,10 +2038,10 @@ test_expect_success 'cover letter with --cover-from-description none' '
 body" &&
 	git checkout rebuild-1 &&
 	git format-patch --stdout --cover-letter --cover-from-description none main >actual &&
-	grep "^Subject: \[PATCH 0/2\] \*\*\* SUBJECT HERE \*\*\*$" actual &&
-	grep "^\*\*\* BLURB HERE \*\*\*$" actual &&
-	! grep "^config subject$" actual &&
-	! grep "^body$" actual
+	test_grep "^Subject: \[PATCH 0/2\] \*\*\* SUBJECT HERE \*\*\*$" actual &&
+	test_grep "^\*\*\* BLURB HERE \*\*\*$" actual &&
+	test_grep ! "^config subject$" actual &&
+	test_grep ! "^body$" actual
 '
 
 test_expect_success 'cover letter with format.coverFromDescription = message' '
@@ -2051,10 +2051,10 @@ body" &&
 	test_config format.coverFromDescription message &&
 	git checkout rebuild-1 &&
 	git format-patch --stdout --cover-letter main >actual &&
-	grep "^Subject: \[PATCH 0/2\] \*\*\* SUBJECT HERE \*\*\*$" actual &&
-	! grep "^\*\*\* BLURB HERE \*\*\*$" actual &&
-	grep "^config subject$" actual &&
-	grep "^body$" actual
+	test_grep "^Subject: \[PATCH 0/2\] \*\*\* SUBJECT HERE \*\*\*$" actual &&
+	test_grep ! "^\*\*\* BLURB HERE \*\*\*$" actual &&
+	test_grep "^config subject$" actual &&
+	test_grep "^body$" actual
 '
 
 test_expect_success 'cover letter with --cover-from-description message' '
@@ -2063,10 +2063,10 @@ test_expect_success 'cover letter with --cover-from-description message' '
 body" &&
 	git checkout rebuild-1 &&
 	git format-patch --stdout --cover-letter --cover-from-description message main >actual &&
-	grep "^Subject: \[PATCH 0/2\] \*\*\* SUBJECT HERE \*\*\*$" actual &&
-	! grep "^\*\*\* BLURB HERE \*\*\*$" actual &&
-	grep "^config subject$" actual &&
-	grep "^body$" actual
+	test_grep "^Subject: \[PATCH 0/2\] \*\*\* SUBJECT HERE \*\*\*$" actual &&
+	test_grep ! "^\*\*\* BLURB HERE \*\*\*$" actual &&
+	test_grep "^config subject$" actual &&
+	test_grep "^body$" actual
 '
 
 test_expect_success 'cover letter with format.coverFromDescription = subject' '
@@ -2076,10 +2076,10 @@ body" &&
 	test_config format.coverFromDescription subject &&
 	git checkout rebuild-1 &&
 	git format-patch --stdout --cover-letter main >actual &&
-	grep "^Subject: \[PATCH 0/2\] config subject$" actual &&
-	! grep "^\*\*\* BLURB HERE \*\*\*$" actual &&
-	! grep "^config subject$" actual &&
-	grep "^body$" actual
+	test_grep "^Subject: \[PATCH 0/2\] config subject$" actual &&
+	test_grep ! "^\*\*\* BLURB HERE \*\*\*$" actual &&
+	test_grep ! "^config subject$" actual &&
+	test_grep "^body$" actual
 '
 
 test_expect_success 'cover letter with --cover-from-description subject' '
@@ -2088,10 +2088,10 @@ test_expect_success 'cover letter with --cover-from-description subject' '
 body" &&
 	git checkout rebuild-1 &&
 	git format-patch --stdout --cover-letter --cover-from-description subject main >actual &&
-	grep "^Subject: \[PATCH 0/2\] config subject$" actual &&
-	! grep "^\*\*\* BLURB HERE \*\*\*$" actual &&
-	! grep "^config subject$" actual &&
-	grep "^body$" actual
+	test_grep "^Subject: \[PATCH 0/2\] config subject$" actual &&
+	test_grep ! "^\*\*\* BLURB HERE \*\*\*$" actual &&
+	test_grep ! "^config subject$" actual &&
+	test_grep "^body$" actual
 '
 
 test_expect_success 'cover letter with --cover-from-description subject (UTF-8 subject line)' '
@@ -2100,8 +2100,8 @@ test_expect_success 'cover letter with --cover-from-description subject (UTF-8 s
 body" &&
 	git checkout rebuild-1 &&
 	git format-patch --stdout --cover-letter --cover-from-description subject --encode-email-headers main >actual &&
-	grep "^Subject: \[PATCH 0/2\] =?UTF-8?q?Caf=C3=A9=3F?=$" actual &&
-	! grep "Café" actual
+	test_grep "^Subject: \[PATCH 0/2\] =?UTF-8?q?Caf=C3=A9=3F?=$" actual &&
+	test_grep ! "Café" actual
 '
 
 test_expect_success 'cover letter with format.coverFromDescription = auto (short subject line)' '
@@ -2111,10 +2111,10 @@ body" &&
 	test_config format.coverFromDescription auto &&
 	git checkout rebuild-1 &&
 	git format-patch --stdout --cover-letter main >actual &&
-	grep "^Subject: \[PATCH 0/2\] config subject$" actual &&
-	! grep "^\*\*\* BLURB HERE \*\*\*$" actual &&
-	! grep "^config subject$" actual &&
-	grep "^body$" actual
+	test_grep "^Subject: \[PATCH 0/2\] config subject$" actual &&
+	test_grep ! "^\*\*\* BLURB HERE \*\*\*$" actual &&
+	test_grep ! "^config subject$" actual &&
+	test_grep "^body$" actual
 '
 
 test_expect_success 'cover letter with --cover-from-description auto (short subject line)' '
@@ -2123,10 +2123,10 @@ test_expect_success 'cover letter with --cover-from-description auto (short subj
 body" &&
 	git checkout rebuild-1 &&
 	git format-patch --stdout --cover-letter --cover-from-description auto main >actual &&
-	grep "^Subject: \[PATCH 0/2\] config subject$" actual &&
-	! grep "^\*\*\* BLURB HERE \*\*\*$" actual &&
-	! grep "^config subject$" actual &&
-	grep "^body$" actual
+	test_grep "^Subject: \[PATCH 0/2\] config subject$" actual &&
+	test_grep ! "^\*\*\* BLURB HERE \*\*\*$" actual &&
+	test_grep ! "^config subject$" actual &&
+	test_grep "^body$" actual
 '
 
 test_expect_success 'cover letter with format.coverFromDescription = auto (long subject line)' '
@@ -2136,10 +2136,10 @@ body" &&
 	test_config format.coverFromDescription auto &&
 	git checkout rebuild-1 &&
 	git format-patch --stdout --cover-letter main >actual &&
-	grep "^Subject: \[PATCH 0/2\] \*\*\* SUBJECT HERE \*\*\*$" actual &&
-	! grep "^\*\*\* BLURB HERE \*\*\*$" actual &&
-	grep "^this is a really long first line and it is over 100 characters long which is the threshold for long subjects$" actual &&
-	grep "^body$" actual
+	test_grep "^Subject: \[PATCH 0/2\] \*\*\* SUBJECT HERE \*\*\*$" actual &&
+	test_grep ! "^\*\*\* BLURB HERE \*\*\*$" actual &&
+	test_grep "^this is a really long first line and it is over 100 characters long which is the threshold for long subjects$" actual &&
+	test_grep "^body$" actual
 '
 
 test_expect_success 'cover letter with --cover-from-description auto (long subject line)' '
@@ -2148,10 +2148,10 @@ test_expect_success 'cover letter with --cover-from-description auto (long subje
 body" &&
 	git checkout rebuild-1 &&
 	git format-patch --stdout --cover-letter --cover-from-description auto main >actual &&
-	grep "^Subject: \[PATCH 0/2\] \*\*\* SUBJECT HERE \*\*\*$" actual &&
-	! grep "^\*\*\* BLURB HERE \*\*\*$" actual &&
-	grep "^this is a really long first line and it is over 100 characters long which is the threshold for long subjects$" actual &&
-	grep "^body$" actual
+	test_grep "^Subject: \[PATCH 0/2\] \*\*\* SUBJECT HERE \*\*\*$" actual &&
+	test_grep ! "^\*\*\* BLURB HERE \*\*\*$" actual &&
+	test_grep "^this is a really long first line and it is over 100 characters long which is the threshold for long subjects$" actual &&
+	test_grep "^body$" actual
 '
 
 test_expect_success 'cover letter with command-line --cover-from-description overrides config' '
@@ -2161,52 +2161,52 @@ body" &&
 	test_config format.coverFromDescription none &&
 	git checkout rebuild-1 &&
 	git format-patch --stdout --cover-letter --cover-from-description subject main >actual &&
-	grep "^Subject: \[PATCH 0/2\] config subject$" actual &&
-	! grep "^\*\*\* BLURB HERE \*\*\*$" actual &&
-	! grep "^config subject$" actual &&
-	grep "^body$" actual
+	test_grep "^Subject: \[PATCH 0/2\] config subject$" actual &&
+	test_grep ! "^\*\*\* BLURB HERE \*\*\*$" actual &&
+	test_grep ! "^config subject$" actual &&
+	test_grep "^body$" actual
 '
 
 test_expect_success 'cover letter using branch description (1)' '
 	git checkout rebuild-1 &&
 	test_config branch.rebuild-1.description hello &&
 	git format-patch --stdout --cover-letter main >actual &&
-	grep hello actual
+	test_grep hello actual
 '
 
 test_expect_success 'cover letter using branch description (2)' '
 	git checkout rebuild-1 &&
 	test_config branch.rebuild-1.description hello &&
 	git format-patch --stdout --cover-letter rebuild-1~2..rebuild-1 >actual &&
-	grep hello actual
+	test_grep hello actual
 '
 
 test_expect_success 'cover letter using branch description (3)' '
 	git checkout rebuild-1 &&
 	test_config branch.rebuild-1.description hello &&
 	git format-patch --stdout --cover-letter ^main rebuild-1 >actual &&
-	grep hello actual
+	test_grep hello actual
 '
 
 test_expect_success 'cover letter using branch description (4)' '
 	git checkout rebuild-1 &&
 	test_config branch.rebuild-1.description hello &&
 	git format-patch --stdout --cover-letter main.. >actual &&
-	grep hello actual
+	test_grep hello actual
 '
 
 test_expect_success 'cover letter using branch description (5)' '
 	git checkout rebuild-1 &&
 	test_config branch.rebuild-1.description hello &&
 	git format-patch --stdout --cover-letter -2 HEAD >actual &&
-	grep hello actual
+	test_grep hello actual
 '
 
 test_expect_success 'cover letter using branch description (6)' '
 	git checkout rebuild-1 &&
 	test_config branch.rebuild-1.description hello &&
 	git format-patch --stdout --cover-letter -2 >actual &&
-	grep hello actual
+	test_grep hello actual
 '
 
 test_expect_success 'cover letter with --description-file' '
@@ -2219,8 +2219,8 @@ test_expect_success 'cover letter with --description-file' '
 	git checkout rebuild-1 &&
 	git format-patch --stdout --cover-letter --cover-from-description auto \
 		--description-file description.txt main >actual &&
-	grep "^Subject: \[PATCH 0/2\] subject from file$" actual &&
-	grep "^body from file$" actual
+	test_grep "^Subject: \[PATCH 0/2\] subject from file$" actual &&
+	test_grep "^body from file$" actual
 '
 
 test_expect_success 'cover letter with nothing' '
@@ -2467,7 +2467,7 @@ test_expect_success 'format-patch errors out when history involves criss-cross'
 test_expect_success 'format-patch format.useAutoBase whenAble history involves criss-cross' '
 	test_config format.useAutoBase whenAble &&
 	git format-patch -1 >patch &&
-	! grep "^base-commit:" patch
+	test_grep ! "^base-commit:" patch
 '
 
 test_expect_success 'format-patch format.useAutoBase option' '
@@ -2502,13 +2502,13 @@ test_expect_success 'format-patch --base overrides format.useAutoBase' '
 test_expect_success 'format-patch --no-base overrides format.useAutoBase' '
 	test_config format.useAutoBase true &&
 	git format-patch --stdout --no-base -1 >patch &&
-	! grep "^base-commit:" patch
+	test_grep ! "^base-commit:" patch
 '
 
 test_expect_success 'format-patch --no-base overrides format.useAutoBase whenAble' '
 	test_config format.useAutoBase whenAble &&
 	git format-patch --stdout --no-base -1 >patch &&
-	! grep "^base-commit:" patch
+	test_grep ! "^base-commit:" patch
 '
 
 test_expect_success 'format-patch --base with --attach' '
@@ -2521,7 +2521,7 @@ test_expect_success 'format-patch --base with --attach' '
 test_expect_success 'format-patch --attach cover-letter only is non-multipart' '
 	test_when_finished "rm -fr patches" &&
 	git format-patch -o patches --cover-letter --attach=mimemime --base=HEAD~ -1 &&
-	! grep -E "^--+mimemime" patches/0000*.patch &&
+	test_grep ! -E "^--+mimemime" patches/0000*.patch &&
 	grep -E "^--+mimemime$" patches/0001*.patch >output &&
 	test_line_count = 2 output &&
 	grep -E "^--+mimemime--$" patches/0001*.patch >output &&
@@ -2533,7 +2533,7 @@ test_expect_success 'format-patch with format.attach' '
 	separator=attachment-separator &&
 	test_config format.attach "$separator" &&
 	filename=$(git format-patch -o patches -1) &&
-	grep "^Content-Type: multipart/.*$separator" "$filename"
+	test_grep "^Content-Type: multipart/.*$separator" "$filename"
 '
 
 test_expect_success 'format-patch with format.attach=disabled' '
@@ -2543,7 +2543,7 @@ test_expect_success 'format-patch with format.attach=disabled' '
 	test_config format.attach "" &&
 	filename=$(git format-patch -o patches -1) &&
 	# The output should not even declare content type for text/plain.
-	! grep "^Content-Type: multipart/" "$filename"
+	test_grep ! "^Content-Type: multipart/" "$filename"
 '
 
 test_expect_success '-c format.mboxrd format-patch' '
@@ -2674,23 +2674,23 @@ test_expect_success 'interdiff: explicit --no-cover-letter defeats implied --cov
 
 test_expect_success 'format-patch does not respect diff.noprefix' '
 	git -c diff.noprefix format-patch -1 --stdout >actual &&
-	grep "^--- a/blorp" actual
+	test_grep "^--- a/blorp" actual
 '
 
 test_expect_success 'format-patch respects format.noprefix' '
 	git -c format.noprefix format-patch -1 --stdout >actual &&
-	grep "^--- blorp" actual
+	test_grep "^--- blorp" actual
 '
 
 test_expect_success 'format.noprefix=false' '
 	git -c format.noprefix=false format-patch -1 --stdout >actual &&
-	grep "^--- a/blorp" actual
+	test_grep "^--- a/blorp" actual
 '
 
 test_expect_success 'format-patch --default-prefix overrides format.noprefix' '
 	git -c format.noprefix \
 		format-patch -1 --default-prefix --stdout >actual &&
-	grep "^--- a/blorp" actual
+	test_grep "^--- a/blorp" actual
 '
 
 test_expect_success 'errors on format.noprefix which is not boolean' '
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index b691d29479..6e7ba8abf6 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -638,14 +638,14 @@ test_expect_success 'check mixed spaces and tabs in indent' '
 	# This is indented with SP HT SP.
 	echo " 	 foo();" >x &&
 	test_must_fail git diff --check >check &&
-	grep "space before tab in indent" check
+	test_grep "space before tab in indent" check
 '
 
 test_expect_success 'check mixed tabs and spaces in indent' '
 	# This is indented with HT SP HT.
 	echo "	 	foo();" >x &&
 	test_must_fail git diff --check >check &&
-	grep "space before tab in indent" check
+	test_grep "space before tab in indent" check
 '
 
 test_expect_success 'check with no whitespace errors' '
@@ -891,14 +891,14 @@ test_expect_success 'line numbers in --check output are correct' '
 	echo "" >x &&
 	echo "foo(); " >>x &&
 	test_must_fail git diff --check >check &&
-	grep "x:2:" check
+	test_grep "x:2:" check
 '
 
 test_expect_success 'checkdiff detects new trailing blank lines (1)' '
 	echo "foo();" >x &&
 	echo "" >>x &&
 	test_must_fail git diff --check >check &&
-	grep "new blank line" check
+	test_grep "new blank line" check
 '
 
 test_expect_success 'checkdiff detects new trailing blank lines (2)' '
@@ -906,7 +906,7 @@ test_expect_success 'checkdiff detects new trailing blank lines (2)' '
 	git add x &&
 	test_write_lines a "" "" "" "" >x &&
 	test_must_fail git diff --check >check &&
-	grep "new blank line" check
+	test_grep "new blank line" check
 '
 
 test_expect_success 'checkdiff allows new blank lines' '
@@ -1018,7 +1018,7 @@ test_expect_success 'combined diff with autocrlf conversion' '
 
 	git diff >actual.raw &&
 	sed -e "1,/^@@@/d" actual.raw >actual &&
-	! grep "^-" actual
+	test_grep ! "^-" actual
 
 '
 
@@ -2166,8 +2166,8 @@ test_expect_success 'move detection with submodules' '
 
 	# no move detection as the moved line is across repository boundaries.
 	test_decode_color <actual >decoded_actual &&
-	! grep BGREEN decoded_actual &&
-	! grep BRED decoded_actual &&
+	test_grep ! BGREEN decoded_actual &&
+	test_grep ! BRED decoded_actual &&
 
 	# nor did we mess with it another way
 	git diff --submodule=diff --color >expect.raw &&
diff --git a/t/t4017-diff-retval.sh b/t/t4017-diff-retval.sh
index c2863c99b7..5ec6f5c612 100755
--- a/t/t4017-diff-retval.sh
+++ b/t/t4017-diff-retval.sh
@@ -139,7 +139,7 @@ test_expect_success 'check honors conflict marker length' '
 
 test_expect_success 'option errors are not confused by --exit-code' '
 	test_must_fail git diff --exit-code --nonsense 2>err &&
-	grep '^usage:' err
+	test_grep '^usage:' err
 '
 
 for option in --exit-code --quiet
diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index e026fac1f4..b538b715f5 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -115,7 +115,7 @@ for i in $(git ls-files)
 do
 	test_expect_success "hunk header: $i" "
 		git diff -U1 $i >actual &&
-		grep '@@ .* @@.*RIGHT' actual
+		test_grep '@@ .* @@.*RIGHT' actual
 	"
 done
 
diff --git a/t/t4019-diff-wserror.sh b/t/t4019-diff-wserror.sh
index 4001dacee3..939ec8a0b4 100755
--- a/t/t4019-diff-wserror.sh
+++ b/t/t4019-diff-wserror.sh
@@ -251,8 +251,8 @@ test_expect_success 'trailing empty lines (1)' '
 
 	rm -f .gitattributes &&
 	test_must_fail git diff --check >output &&
-	grep "new blank line at" output &&
-	grep "trailing whitespace" output
+	test_grep "new blank line at" output &&
+	test_grep "trailing whitespace" output
 
 '
 
@@ -280,8 +280,8 @@ test_expect_success 'do not color trailing cr in context' '
 	git add G &&
 	echo BBBQ | tr Q "\015" >>G &&
 	git diff --color G | tr "\015" Q >output &&
-	grep "BBB.*${blue_grep}Q" output &&
-	grep "AAA.*\[mQ" output
+	test_grep "BBB.*${blue_grep}Q" output &&
+	test_grep "AAA.*\[mQ" output
 
 '
 
diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
index 7ec5854f74..93d37230c6 100755
--- a/t/t4020-diff-external.sh
+++ b/t/t4020-diff-external.sh
@@ -34,13 +34,13 @@ test_expect_success 'GIT_EXTERNAL_DIFF environment' '
 
 test_expect_success 'GIT_EXTERNAL_DIFF environment should apply only to diff' '
 	GIT_EXTERNAL_DIFF=echo git log -p -1 HEAD >out &&
-	grep "^diff --git a/file b/file" out
+	test_grep "^diff --git a/file b/file" out
 
 '
 
 test_expect_success 'GIT_EXTERNAL_DIFF environment and --no-ext-diff' '
 	GIT_EXTERNAL_DIFF=echo git diff --no-ext-diff >out &&
-	grep "^diff --git a/file b/file" out
+	test_grep "^diff --git a/file b/file" out
 
 '
 
@@ -86,13 +86,13 @@ test_expect_success 'diff.external' '
 test_expect_success 'diff.external should apply only to diff' '
 	test_config diff.external echo &&
 	git log -p -1 HEAD >out &&
-	grep "^diff --git a/file b/file" out
+	test_grep "^diff --git a/file b/file" out
 '
 
 test_expect_success 'diff.external and --no-ext-diff' '
 	test_config diff.external echo &&
 	git diff --no-ext-diff >out &&
-	grep "^diff --git a/file b/file" out
+	test_grep "^diff --git a/file b/file" out
 '
 
 test_expect_success 'diff attribute' '
@@ -113,13 +113,13 @@ test_expect_success 'diff attribute' '
 
 test_expect_success 'diff attribute should apply only to diff' '
 	git log -p -1 HEAD >out &&
-	grep "^diff --git a/file b/file" out
+	test_grep "^diff --git a/file b/file" out
 
 '
 
 test_expect_success 'diff attribute and --no-ext-diff' '
 	git diff --no-ext-diff >out &&
-	grep "^diff --git a/file b/file" out
+	test_grep "^diff --git a/file b/file" out
 
 '
 
@@ -140,13 +140,13 @@ test_expect_success 'diff attribute' '
 
 test_expect_success 'diff attribute should apply only to diff' '
 	git log -p -1 HEAD >out &&
-	grep "^diff --git a/file b/file" out
+	test_grep "^diff --git a/file b/file" out
 
 '
 
 test_expect_success 'diff attribute and --no-ext-diff' '
 	git diff --no-ext-diff >out &&
-	grep "^diff --git a/file b/file" out
+	test_grep "^diff --git a/file b/file" out
 
 '
 
@@ -178,7 +178,7 @@ test_expect_success 'attributes trump GIT_EXTERNAL_DIFF and diff.external' '
 test_expect_success 'no diff with -diff' '
 	echo >.gitattributes "file -diff" &&
 	git diff >out &&
-	grep Binary out
+	test_grep Binary out
 '
 
 check_external_diff () {
diff --git a/t/t4021-format-patch-numbered.sh b/t/t4021-format-patch-numbered.sh
index 9be65fd444..204851f061 100755
--- a/t/t4021-format-patch-numbered.sh
+++ b/t/t4021-format-patch-numbered.sh
@@ -94,7 +94,7 @@ test_expect_success 'format.numbered && --no-numbered' '
 test_expect_success 'format.numbered && --keep-subject' '
 
 	git format-patch --keep-subject --stdout HEAD^ >patch4a &&
-	grep "^Subject: Third" patch4a
+	test_grep "^Subject: Third" patch4a
 
 '
 
@@ -123,7 +123,7 @@ test_expect_success 'format.numbered = auto && --no-numbered' '
 test_expect_success '--start-number && --numbered' '
 
 	git format-patch --start-number 3 --numbered --stdout HEAD~1 > patch8 &&
-	grep "^Subject: \[PATCH 3/3\]" patch8
+	test_grep "^Subject: \[PATCH 3/3\]" patch8
 '
 
 test_expect_success 'single patch with cover-letter defaults to numbers' '
diff --git a/t/t4022-diff-rewrite.sh b/t/t4022-diff-rewrite.sh
index 6fed993ea0..b5c1b6868f 100755
--- a/t/t4022-diff-rewrite.sh
+++ b/t/t4022-diff-rewrite.sh
@@ -58,13 +58,13 @@ test_expect_success 'suppress deletion diff with -D' '
 test_expect_success 'show deletion diff with -B' '
 
 	git diff -B -- test >actual &&
-	grep "Linus Torvalds" actual
+	test_grep "Linus Torvalds" actual
 '
 
 test_expect_success 'suppress deletion diff with -B -D' '
 
 	git diff -B -D -- test >actual &&
-	grep -v "Linus Torvalds" actual
+	test_grep -v "Linus Torvalds" actual
 '
 
 test_expect_success 'prepare a file that ends with an incomplete line' '
@@ -82,19 +82,19 @@ test_expect_success 'rewrite the middle 90% of sequence file and terminate with
 
 test_expect_success 'confirm that sequence file is considered a rewrite' '
 	git diff -B seq >res &&
-	grep "dissimilarity index" res
+	test_grep "dissimilarity index" res
 '
 
 test_expect_success 'no newline at eof is on its own line without -B' '
 	git diff seq >res &&
-	grep "^\\\\ " res &&
-	! grep "^..*\\\\ " res
+	test_grep "^\\\\ " res &&
+	test_grep ! "^..*\\\\ " res
 '
 
 test_expect_success 'no newline at eof is on its own line with -B' '
 	git diff -B seq >res &&
-	grep "^\\\\ " res &&
-	! grep "^..*\\\\ " res
+	test_grep "^\\\\ " res &&
+	test_grep ! "^..*\\\\ " res
 '
 
 test_done
diff --git a/t/t4028-format-patch-mime-headers.sh b/t/t4028-format-patch-mime-headers.sh
index a06a747926..39344cf761 100755
--- a/t/t4028-format-patch-mime-headers.sh
+++ b/t/t4028-format-patch-mime-headers.sh
@@ -17,15 +17,15 @@ test_expect_success 'create commit with utf-8 body' '
 test_expect_success 'patch has mime headers' '
 	rm -f 0001-two.patch &&
 	git format-patch HEAD^ &&
-	grep -i "content-type: text/plain; charset=utf-8" 0001-two.patch
+	test_grep -i "content-type: text/plain; charset=utf-8" 0001-two.patch
 '
 
 test_expect_success 'patch has mime and extra headers' '
 	rm -f 0001-two.patch &&
 	git config format.headers "x-foo: bar" &&
 	git format-patch HEAD^ &&
-	grep -i "x-foo: bar" 0001-two.patch &&
-	grep -i "content-type: text/plain; charset=utf-8" 0001-two.patch
+	test_grep -i "x-foo: bar" 0001-two.patch &&
+	test_grep -i "content-type: text/plain; charset=utf-8" 0001-two.patch
 '
 
 test_done
diff --git a/t/t4031-diff-rewrite-binary.sh b/t/t4031-diff-rewrite-binary.sh
index 15e012ccc7..5b31ca02fe 100755
--- a/t/t4031-diff-rewrite-binary.sh
+++ b/t/t4031-diff-rewrite-binary.sh
@@ -29,32 +29,32 @@ test_expect_success 'create binary file with changes' '
 
 test_expect_success 'vanilla diff is binary' '
 	git diff >diff &&
-	grep "Binary files a/file and b/file differ" diff
+	test_grep "Binary files a/file and b/file differ" diff
 '
 
 test_expect_success 'rewrite diff is binary' '
 	git diff -B >diff &&
-	grep "dissimilarity index" diff &&
-	grep "Binary files a/file and b/file differ" diff
+	test_grep "dissimilarity index" diff &&
+	test_grep "Binary files a/file and b/file differ" diff
 '
 
 test_expect_success 'rewrite diff can show binary patch' '
 	git diff -B --binary >diff &&
-	grep "dissimilarity index" diff &&
-	grep "GIT binary patch" diff
+	test_grep "dissimilarity index" diff &&
+	test_grep "GIT binary patch" diff
 '
 
 test_expect_success 'rewrite diff --numstat shows binary changes' '
 	git diff -B --numstat --summary >diff &&
-	grep -e "-	-	" diff &&
-	grep " rewrite file" diff
+	test_grep -e "-	-	" diff &&
+	test_grep " rewrite file" diff
 '
 
 test_expect_success 'diff --stat counts binary rewrite as 0 lines' '
 	git diff -B --stat --summary >diff &&
-	grep "Bin" diff &&
+	test_grep "Bin" diff &&
 	test_grep "0 insertions.*0 deletions" diff &&
-	grep " rewrite file" diff
+	test_grep " rewrite file" diff
 '
 
 test_expect_success 'setup textconv' '
diff --git a/t/t4033-diff-patience.sh b/t/t4033-diff-patience.sh
index 113304dc59..8002c0f434 100755
--- a/t/t4033-diff-patience.sh
+++ b/t/t4033-diff-patience.sh
@@ -10,7 +10,7 @@ test_expect_success '--ignore-space-at-eol with a single appended character' '
 	printf "a\nbX\nc\n" >post &&
 	test_must_fail git diff --no-index \
 		--patience --ignore-space-at-eol pre post >diff &&
-	grep "^+.*X" diff
+	test_grep "^+.*X" diff
 '
 
 test_diff_frobnitz "patience"
diff --git a/t/t4036-format-patch-signer-mime.sh b/t/t4036-format-patch-signer-mime.sh
index 98d9713d8b..f57d3dc9fb 100755
--- a/t/t4036-format-patch-signer-mime.sh
+++ b/t/t4036-format-patch-signer-mime.sh
@@ -19,14 +19,14 @@ test_expect_success setup '
 test_expect_success 'format normally' '
 
 	git format-patch --stdout -1 >output &&
-	! grep Content-Type output
+	test_grep ! Content-Type output
 
 '
 
 test_expect_success 'format with signoff without funny signer name' '
 
 	git format-patch -s --stdout -1 >output &&
-	! grep Content-Type output
+	test_grep ! Content-Type output
 
 '
 
@@ -34,7 +34,7 @@ test_expect_success 'format with non ASCII signer name' '
 
 	GIT_COMMITTER_NAME="はまの ふにおう" \
 	git format-patch -s --stdout -1 >output &&
-	grep Content-Type output
+	test_grep Content-Type output
 
 '
 
diff --git a/t/t4038-diff-combined.sh b/t/t4038-diff-combined.sh
index 2ce26e585c..e11b711388 100755
--- a/t/t4038-diff-combined.sh
+++ b/t/t4038-diff-combined.sh
@@ -100,7 +100,7 @@ test_expect_success 'diagnose truncated file' '
 	git add file &&
 	git commit --amend -C HEAD &&
 	git show >out &&
-	grep "diff --cc file" out
+	test_grep "diff --cc file" out
 '
 
 test_expect_success 'setup for --cc --raw' '
@@ -118,13 +118,13 @@ test_expect_success 'check --cc --raw with four trees' '
 	four_trees=$(echo "$trees" | sed -e 4q) &&
 	git diff --cc --raw $four_trees $base_tree >out &&
 	# Check for four leading colons in the output:
-	grep "^::::[^:]" out
+	test_grep "^::::[^:]" out
 '
 
 test_expect_success 'check --cc --raw with forty trees' '
 	git diff --cc --raw $trees $base_tree >out &&
 	# Check for forty leading colons in the output:
-	grep "^::::::::::::::::::::::::::::::::::::::::[^:]" out
+	test_grep "^::::::::::::::::::::::::::::::::::::::::[^:]" out
 '
 
 test_expect_success 'setup combined ignore spaces' '
diff --git a/t/t4051-diff-function-context.sh b/t/t4051-diff-function-context.sh
index 4838a1df8b..117eaede8a 100755
--- a/t/t4051-diff-function-context.sh
+++ b/t/t4051-diff-function-context.sh
@@ -86,15 +86,15 @@ test_expect_success 'setup' '
 check_diff changed_hello 'changed function'
 
 test_expect_success ' context includes comment' '
-	grep "^ .*Hello comment" changed_hello.diff
+	test_grep "^ .*Hello comment" changed_hello.diff
 '
 
 test_expect_success ' context includes begin' '
-	grep "^ .*Begin of hello" changed_hello.diff
+	test_grep "^ .*Begin of hello" changed_hello.diff
 '
 
 test_expect_success ' context includes end' '
-	grep "^ .*End of hello" changed_hello.diff
+	test_grep "^ .*End of hello" changed_hello.diff
 '
 
 test_expect_success ' context does not include other functions' '
@@ -112,11 +112,11 @@ test_expect_success ' context does not include trailing empty lines' '
 check_diff changed_includes 'changed includes'
 
 test_expect_success ' context includes begin' '
-	grep "^ .*Begin.h" changed_includes.diff
+	test_grep "^ .*Begin.h" changed_includes.diff
 '
 
 test_expect_success ' context includes end' '
-	grep "^ .*End.h" changed_includes.diff
+	test_grep "^ .*End.h" changed_includes.diff
 '
 
 test_expect_success ' context does not include other functions' '
@@ -130,11 +130,11 @@ test_expect_success ' context does not include trailing empty lines' '
 check_diff appended 'appended function'
 
 test_expect_success ' context includes begin' '
-	grep "^[+].*Begin of first part" appended.diff
+	test_grep "^[+].*Begin of first part" appended.diff
 '
 
 test_expect_success ' context includes end' '
-	grep "^[+].*End of first part" appended.diff
+	test_grep "^[+].*End of first part" appended.diff
 '
 
 test_expect_success ' context does not include other functions' '
@@ -144,11 +144,11 @@ test_expect_success ' context does not include other functions' '
 check_diff extended 'appended function part'
 
 test_expect_success ' context includes begin' '
-	grep "^ .*Begin of first part" extended.diff
+	test_grep "^ .*Begin of first part" extended.diff
 '
 
 test_expect_success ' context includes end' '
-	grep "^[+].*End of second part" extended.diff
+	test_grep "^[+].*End of second part" extended.diff
 '
 
 test_expect_success ' context does not include other functions' '
@@ -162,11 +162,11 @@ test_expect_success ' context does not include preceding empty lines' '
 check_diff long_common_tail 'change with long common tail and no context' -U0
 
 test_expect_success ' context includes begin' '
-	grep "^ .*Begin of first part" long_common_tail.diff
+	test_grep "^ .*Begin of first part" long_common_tail.diff
 '
 
 test_expect_success ' context includes end' '
-	grep "^ .*End of second part" long_common_tail.diff
+	test_grep "^ .*End of second part" long_common_tail.diff
 '
 
 test_expect_success ' context does not include other functions' '
@@ -180,13 +180,13 @@ test_expect_success ' context does not include preceding empty lines' '
 check_diff changed_hello_appended 'changed function plus appended function'
 
 test_expect_success ' context includes begin' '
-	grep "^ .*Begin of hello" changed_hello_appended.diff &&
-	grep "^[+].*Begin of first part" changed_hello_appended.diff
+	test_grep "^ .*Begin of hello" changed_hello_appended.diff &&
+	test_grep "^[+].*Begin of first part" changed_hello_appended.diff
 '
 
 test_expect_success ' context includes end' '
-	grep "^ .*End of hello" changed_hello_appended.diff &&
-	grep "^[+].*End of first part" changed_hello_appended.diff
+	test_grep "^ .*End of hello" changed_hello_appended.diff &&
+	test_grep "^[+].*End of first part" changed_hello_appended.diff
 '
 
 test_expect_success ' context does not include other functions' '
@@ -196,13 +196,13 @@ test_expect_success ' context does not include other functions' '
 check_diff changed_hello_dummy 'changed two consecutive functions'
 
 test_expect_success ' context includes begin' '
-	grep "^ .*Begin of hello" changed_hello_dummy.diff &&
-	grep "^ .*Begin of dummy" changed_hello_dummy.diff
+	test_grep "^ .*Begin of hello" changed_hello_dummy.diff &&
+	test_grep "^ .*Begin of dummy" changed_hello_dummy.diff
 '
 
 test_expect_success ' context includes end' '
-	grep "^ .*End of hello" changed_hello_dummy.diff &&
-	grep "^ .*End of dummy" changed_hello_dummy.diff
+	test_grep "^ .*End of hello" changed_hello_dummy.diff &&
+	test_grep "^ .*End of dummy" changed_hello_dummy.diff
 '
 
 test_expect_success ' overlapping hunks are merged' '
diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
index 15076dfe0d..8e0394cf5a 100755
--- a/t/t4053-diff-no-index.sh
+++ b/t/t4053-diff-no-index.sh
@@ -283,14 +283,14 @@ test_expect_success "diff --no-index -R treats '-' as stdin" '
 
 test_expect_success 'diff --no-index refuses to diff stdin and a directory' '
 	test_must_fail git diff --no-index -- - a </dev/null 2>err &&
-	grep "fatal: cannot compare stdin to a directory" err
+	test_grep "fatal: cannot compare stdin to a directory" err
 '
 
 test_expect_success PIPE 'diff --no-index refuses to diff a named pipe and a directory' '
 	test_when_finished "rm -f pipe" &&
 	mkfifo pipe &&
 	test_must_fail git diff --no-index -- pipe a 2>err &&
-	grep "fatal: cannot compare a named pipe to a directory" err
+	test_grep "fatal: cannot compare a named pipe to a directory" err
 '
 
 test_expect_success PIPE,SYMLINKS 'diff --no-index reads from pipes' '
diff --git a/t/t4063-diff-blobs.sh b/t/t4063-diff-blobs.sh
index 50fdb5ea52..1318cceb19 100755
--- a/t/t4063-diff-blobs.sh
+++ b/t/t4063-diff-blobs.sh
@@ -47,7 +47,7 @@ test_expect_success 'sha1 diff uses arguments as paths' '
 	check_paths $sha1_one $sha1_two
 '
 test_expect_success 'sha1 diff has no mode change' '
-	! grep mode diff
+	test_grep ! mode diff
 '
 
 test_expect_success 'diff by tree:path (run)' '
diff --git a/t/t4065-diff-anchored.sh b/t/t4065-diff-anchored.sh
index b3f510f040..9f06ac65be 100755
--- a/t/t4065-diff-anchored.sh
+++ b/t/t4065-diff-anchored.sh
@@ -10,11 +10,11 @@ test_expect_success '--anchored' '
 
 	# normally, c is moved to produce the smallest diff
 	test_expect_code 1 git diff --no-index pre post >diff &&
-	grep "^+c" diff &&
+	test_grep "^+c" diff &&
 
 	# with anchor, a is moved
 	test_expect_code 1 git diff --no-index --anchored=c pre post >diff &&
-	grep "^+a" diff
+	test_grep "^+a" diff
 '
 
 test_expect_success '--anchored multiple' '
@@ -23,13 +23,13 @@ test_expect_success '--anchored multiple' '
 
 	# with 1 anchor, c is not moved, but f is moved
 	test_expect_code 1 git diff --no-index --anchored=c pre post >diff &&
-	grep "^+a" diff && # a is moved instead of c
-	grep "^+f" diff &&
+	test_grep "^+a" diff && # a is moved instead of c
+	test_grep "^+f" diff &&
 
 	# with 2 anchors, c and f are not moved
 	test_expect_code 1 git diff --no-index --anchored=c --anchored=f pre post >diff &&
-	grep "^+a" diff &&
-	grep "^+d" diff # d is moved instead of f
+	test_grep "^+a" diff &&
+	test_grep "^+d" diff # d is moved instead of f
 '
 
 test_expect_success '--anchored with nonexistent line has no effect' '
@@ -37,7 +37,7 @@ test_expect_success '--anchored with nonexistent line has no effect' '
 	printf "c\na\nb\n" >post &&
 
 	test_expect_code 1 git diff --no-index --anchored=x pre post >diff &&
-	grep "^+c" diff
+	test_grep "^+c" diff
 '
 
 test_expect_success '--anchored with non-unique line has no effect' '
@@ -45,7 +45,7 @@ test_expect_success '--anchored with non-unique line has no effect' '
 	printf "c\na\nb\nc\nd\ne\n" >post &&
 
 	test_expect_code 1 git diff --no-index --anchored=c pre post >diff &&
-	grep "^+c" diff
+	test_grep "^+c" diff
 '
 
 test_expect_success 'diff still produced with impossible multiple --anchored' '
@@ -66,16 +66,16 @@ test_expect_success 'later algorithm arguments override earlier ones' '
 	printf "c\na\nb\n" >post &&
 
 	test_expect_code 1 git diff --no-index --patience --anchored=c pre post >diff &&
-	grep "^+a" diff &&
+	test_grep "^+a" diff &&
 
 	test_expect_code 1 git diff --no-index --anchored=c --patience pre post >diff &&
-	grep "^+c" diff &&
+	test_grep "^+c" diff &&
 
 	test_expect_code 1 git diff --no-index --histogram --anchored=c pre post >diff &&
-	grep "^+a" diff &&
+	test_grep "^+a" diff &&
 
 	test_expect_code 1 git diff --no-index --anchored=c --histogram pre post >diff &&
-	grep "^+c" diff
+	test_grep "^+c" diff
 '
 
 test_expect_success '--anchored works with other commands like "git show"' '
@@ -88,7 +88,7 @@ test_expect_success '--anchored works with other commands like "git show"' '
 
 	# with anchor, a is moved
 	git show --patience --anchored=c >diff &&
-	grep "^+a" diff
+	test_grep "^+a" diff
 '
 
 test_done
diff --git a/t/t4067-diff-partial-clone.sh b/t/t4067-diff-partial-clone.sh
index a9dec84c30..f510d8dedc 100755
--- a/t/t4067-diff-partial-clone.sh
+++ b/t/t4067-diff-partial-clone.sh
@@ -70,9 +70,9 @@ test_expect_success 'diff skips same-OID blobs' '
 
 	# Ensure that only a and another-a are fetched.
 	GIT_TRACE_PACKET="$(pwd)/trace" git -C client diff HEAD^ HEAD &&
-	grep "want $(cat hash-old-a)" trace &&
-	grep "want $(cat hash-new-a)" trace &&
-	! grep "want $(cat hash-b)" trace
+	test_grep "want $(cat hash-old-a)" trace &&
+	test_grep "want $(cat hash-new-a)" trace &&
+	test_grep ! "want $(cat hash-b)" trace
 '
 
 test_expect_success 'when fetching missing objects, diff skips GITLINKs' '
@@ -103,8 +103,8 @@ test_expect_success 'when fetching missing objects, diff skips GITLINKs' '
 	# Ensure that a and another-a are fetched, and check (by successful
 	# execution of the diff) that no invalid OIDs are sent.
 	GIT_TRACE_PACKET="$(pwd)/trace" git -C client diff HEAD^ HEAD &&
-	grep "want $(cat hash-old-a)" trace &&
-	grep "want $(cat hash-new-a)" trace
+	test_grep "want $(cat hash-old-a)" trace &&
+	test_grep "want $(cat hash-new-a)" trace
 '
 
 test_expect_success 'diff with rename detection batches blobs' '
@@ -127,7 +127,7 @@ test_expect_success 'diff with rename detection batches blobs' '
 	# Ensure that there is exactly 1 negotiation by checking that there is
 	# only 1 "done" line sent. ("done" marks the end of negotiation.)
 	GIT_TRACE_PACKET="$(pwd)/trace" git -C client diff --raw -M HEAD^ HEAD >out &&
-	grep ":100644 100644.*R[0-9][0-9][0-9].*b.*c" out &&
+	test_grep ":100644 100644.*R[0-9][0-9][0-9].*b.*c" out &&
 	grep "fetch> done" trace >done_lines &&
 	test_line_count = 1 done_lines
 '
diff --git a/t/t4073-diff-stat-name-width.sh b/t/t4073-diff-stat-name-width.sh
index ec5d3c3c1f..2412420645 100755
--- a/t/t4073-diff-stat-name-width.sh
+++ b/t/t4073-diff-stat-name-width.sh
@@ -21,41 +21,41 @@ test_expect_success 'setup' '
 
 test_expect_success 'test name-width long enough for filepath' '
 	git diff HEAD~1 HEAD --stat --stat-name-width=12 >out &&
-	grep "d你好/f再见 |" out &&
+	test_grep "d你好/f再见 |" out &&
 	git diff HEAD~1 HEAD --stat --stat-name-width=11 >out &&
-	grep "d你好/f再见 |" out
+	test_grep "d你好/f再见 |" out
 '
 
 test_expect_success 'test name-width not long enough for dir name' '
 	git diff HEAD~1 HEAD --stat --stat-name-width=10 >out &&
-	grep ".../f再见  |" out &&
+	test_grep ".../f再见  |" out &&
 	git diff HEAD~1 HEAD --stat --stat-name-width=9 >out &&
-	grep ".../f再见 |" out
+	test_grep ".../f再见 |" out
 '
 
 test_expect_success 'test name-width not long enough for slash' '
 	git diff HEAD~1 HEAD --stat --stat-name-width=8 >out &&
-	grep "...f再见 |" out
+	test_grep "...f再见 |" out
 '
 
 test_expect_success 'test name-width not long enough for file name' '
 	git diff HEAD~1 HEAD --stat --stat-name-width=7 >out &&
-	grep "...再见 |" out &&
+	test_grep "...再见 |" out &&
 	git diff HEAD~1 HEAD --stat --stat-name-width=6 >out &&
-	grep "...见  |" out &&
+	test_grep "...见  |" out &&
 	git diff HEAD~1 HEAD --stat --stat-name-width=5 >out &&
-	grep "...见 |" out &&
+	test_grep "...见 |" out &&
 	git diff HEAD~1 HEAD --stat --stat-name-width=4 >out &&
-	grep "...  |" out
+	test_grep "...  |" out
 '
 
 test_expect_success 'test name-width minimum length' '
 	git diff HEAD~1 HEAD --stat --stat-name-width=3 >out &&
-	grep "... |" out &&
+	test_grep "... |" out &&
 	git diff HEAD~1 HEAD --stat --stat-name-width=2 >out &&
-	grep "... |" out &&
+	test_grep "... |" out &&
 	git diff HEAD~1 HEAD --stat --stat-name-width=1 >out &&
-	grep "... |" out
+	test_grep "... |" out
 '
 
 test_done
diff --git a/t/t4103-apply-binary.sh b/t/t4103-apply-binary.sh
index f2d41e06bc..bdd4ccf9e3 100755
--- a/t/t4103-apply-binary.sh
+++ b/t/t4103-apply-binary.sh
@@ -181,7 +181,7 @@ test_expect_success PERL_TEST_HELPERS 'reject truncated binary diff' '
 	do_reset &&
 	test_must_fail git apply patch.trunc 2>err &&
 	line=$(awk "END { print NR + 1 }" patch.trunc) &&
-	grep "error: corrupt binary patch at patch.trunc:$line: " err
+	test_grep "error: corrupt binary patch at patch.trunc:$line: " err
 '
 
 test_expect_success 'reject unrecognized binary diff' '
diff --git a/t/t4120-apply-popt.sh b/t/t4120-apply-popt.sh
index c960fdf622..c7801aec2c 100755
--- a/t/t4120-apply-popt.sh
+++ b/t/t4120-apply-popt.sh
@@ -18,7 +18,7 @@ test_expect_success setup '
 	git mv sub süb &&
 	echo B >süb/file1 &&
 	git diff >patch.escaped &&
-	grep "[\]" patch.escaped &&
+	test_grep "[\]" patch.escaped &&
 	rm süb/file1 &&
 	rmdir süb
 '
diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index 205d86d05e..4c487fb576 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -222,8 +222,8 @@ test_expect_success 'trailing whitespace & no newline at the end of file' '
 	>target &&
 	create_patch >patch-file &&
 	git apply --whitespace=fix patch-file &&
-	grep "newline$" target &&
-	grep "^$" target
+	test_grep "newline$" target &&
+	test_grep "^$" target
 '
 
 test_expect_success 'blank at EOF with --whitespace=fix (1)' '
@@ -287,7 +287,7 @@ test_expect_success 'blank at EOF with --whitespace=warn' '
 	git checkout one &&
 	git apply --whitespace=warn patch 2>error &&
 	test_cmp expect one &&
-	grep "new blank line at EOF" error
+	test_grep "new blank line at EOF" error
 '
 
 test_expect_success 'blank at EOF with --whitespace=error' '
@@ -300,7 +300,7 @@ test_expect_success 'blank at EOF with --whitespace=error' '
 	git checkout one &&
 	test_must_fail git apply --whitespace=error patch 2>error &&
 	test_cmp expect one &&
-	grep "new blank line at EOF" error
+	test_grep "new blank line at EOF" error
 '
 
 test_expect_success 'blank but not empty at EOF' '
@@ -313,7 +313,7 @@ test_expect_success 'blank but not empty at EOF' '
 	git checkout one &&
 	git apply --whitespace=warn patch 2>error &&
 	test_cmp expect one &&
-	grep "new blank line at EOF" error
+	test_grep "new blank line at EOF" error
 '
 
 test_expect_success 'applying beyond EOF requires one non-blank context line' '
diff --git a/t/t4128-apply-root.sh b/t/t4128-apply-root.sh
index 5eba15fa66..c772faea62 100755
--- a/t/t4128-apply-root.sh
+++ b/t/t4128-apply-root.sh
@@ -138,7 +138,7 @@ test_expect_success 'apply --directory (delete file)' '
 	git add some/sub/dir/delfile &&
 	git apply --directory=some/sub/dir/ --index patch &&
 	git ls-files >out &&
-	! grep delfile out
+	test_grep ! delfile out
 '
 
 cat > patch << 'EOF'
diff --git a/t/t4140-apply-ita.sh b/t/t4140-apply-ita.sh
index 0b11a8aef4..49ebb51564 100755
--- a/t/t4140-apply-ita.sh
+++ b/t/t4140-apply-ita.sh
@@ -14,11 +14,11 @@ test_expect_success setup '
 	cat blueprint >test-file &&
 	git add -N test-file &&
 	git diff >creation-patch &&
-	grep "new file mode 100644" creation-patch &&
+	test_grep "new file mode 100644" creation-patch &&
 
 	rm -f test-file &&
 	git diff >deletion-patch &&
-	grep "deleted file mode 100644" deletion-patch &&
+	test_grep "deleted file mode 100644" deletion-patch &&
 
 	git rm -f test-file &&
 	test_write_lines 6 >>committed-file &&
diff --git a/t/t4141-apply-too-large.sh b/t/t4141-apply-too-large.sh
index eac6f7e151..b114a7adf7 100755
--- a/t/t4141-apply-too-large.sh
+++ b/t/t4141-apply-too-large.sh
@@ -16,7 +16,7 @@ test_expect_success EXPENSIVE 'git apply rejects patches that are too large' '
 		EOF
 		test-tool genzeros
 	} | test_copy_bytes $sz | test_must_fail git apply 2>err &&
-	grep "patch too large" err
+	test_grep "patch too large" err
 '
 
 test_done
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 699a81ab5c..61c3ce9018 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -580,7 +580,7 @@ test_expect_success 'am --keep really keeps the subject' '
 	git am --keep patch4 &&
 	test_path_is_missing .git/rebase-apply &&
 	git cat-file commit HEAD >actual &&
-	grep "Re: Re: Re: \[PATCH 1/5 v2\] \[foo\] third" actual
+	test_grep "Re: Re: Re: \[PATCH 1/5 v2\] \[foo\] third" actual
 '
 
 test_expect_success 'am --keep-non-patch really keeps the non-patch part' '
@@ -590,7 +590,7 @@ test_expect_success 'am --keep-non-patch really keeps the non-patch part' '
 	git am --keep-non-patch patch4 &&
 	test_path_is_missing .git/rebase-apply &&
 	git cat-file commit HEAD >actual &&
-	grep "^\[foo\] third" actual
+	test_grep "^\[foo\] third" actual
 '
 
 test_expect_success 'setup am -3' '
@@ -642,7 +642,7 @@ test_expect_success 'am with config am.threeWay overridden by --no-3way' '
 '
 
 test_expect_success 'am can rename a file' '
-	grep "^rename from" rename.patch &&
+	test_grep "^rename from" rename.patch &&
 	rm -fr .git/rebase-apply &&
 	git reset --hard &&
 	git checkout lorem^0 &&
@@ -653,7 +653,7 @@ test_expect_success 'am can rename a file' '
 '
 
 test_expect_success 'am -3 can rename a file' '
-	grep "^rename from" rename.patch &&
+	test_grep "^rename from" rename.patch &&
 	rm -fr .git/rebase-apply &&
 	git reset --hard &&
 	git checkout lorem^0 &&
@@ -664,7 +664,7 @@ test_expect_success 'am -3 can rename a file' '
 '
 
 test_expect_success 'am -3 can rename a file after falling back to 3-way merge' '
-	grep "^rename from" rename-add.patch &&
+	test_grep "^rename from" rename-add.patch &&
 	rm -fr .git/rebase-apply &&
 	git reset --hard &&
 	git checkout lorem^0 &&
@@ -884,7 +884,7 @@ test_expect_success 'am --ignore-date' '
 	git am --ignore-date patch1 &&
 	git cat-file commit HEAD | sed -e "/^\$/q" >head1 &&
 	sed -ne "/^author /s/.*> //p" head1 >at &&
-	grep "+0000" at
+	test_grep "+0000" at
 '
 
 test_expect_success 'am into an unborn branch' '
@@ -1066,7 +1066,7 @@ test_expect_success 'am --patch-format=mboxrd handles mboxrd' '
 	INPUT_END
 	git commit -F msg &&
 	git -c format.mboxrd format-patch --stdout -1 >mboxrd1 &&
-	grep "^>From could trip up a loose mbox parser" mboxrd1 &&
+	test_grep "^>From could trip up a loose mbox parser" mboxrd1 &&
 	git checkout -f first &&
 	git am --patch-format=mboxrd mboxrd1 &&
 	git cat-file commit HEAD | tail -n4 >out &&
@@ -1144,21 +1144,21 @@ test_expect_success 'am and .gitattibutes' '
 		git format-patch --stdout main..HEAD >patches &&
 		git reset --hard main &&
 		git am patches &&
-		grep "smudged" a.txt &&
+		test_grep "smudged" a.txt &&
 
 		git checkout removal &&
 		git reset --hard &&
 		git format-patch --stdout main..HEAD >patches &&
 		git reset --hard main &&
 		git am patches &&
-		grep "clean" a.txt &&
+		test_grep "clean" a.txt &&
 
 		git checkout conflict &&
 		git reset --hard &&
 		git format-patch --stdout main..HEAD >patches &&
 		git reset --hard fourth &&
 		test_must_fail git am -3 patches &&
-		grep "<<<<<<<<<<" a.txt
+		test_grep "<<<<<<<<<<" a.txt
 	)
 '
 
@@ -1196,13 +1196,13 @@ test_expect_success 'invalid when passing the --empty option alone' '
 test_expect_success 'a message without a patch is an error (default)' '
 	test_when_finished "git am --abort || :" &&
 	test_must_fail git am empty-commit.patch >err &&
-	grep "Patch is empty" err
+	test_grep "Patch is empty" err
 '
 
 test_expect_success 'a message without a patch is an error where an explicit "--empty=stop" is given' '
 	test_when_finished "git am --abort || :" &&
 	test_must_fail git am --empty=stop empty-commit.patch >err &&
-	grep "Patch is empty." err
+	test_grep "Patch is empty." err
 '
 
 test_expect_success 'a message without a patch will be skipped when "--empty=drop" is given' '
@@ -1210,7 +1210,7 @@ test_expect_success 'a message without a patch will be skipped when "--empty=dro
 	git rev-parse empty-commit^ >expected &&
 	git rev-parse HEAD >actual &&
 	test_cmp expected actual &&
-	grep "Skipping: empty commit" output
+	test_grep "Skipping: empty commit" output
 '
 
 test_expect_success 'record as an empty commit when meeting e-mail message that lacks a patch' '
@@ -1218,15 +1218,15 @@ test_expect_success 'record as an empty commit when meeting e-mail message that
 	test_path_is_missing .git/rebase-apply &&
 	git show empty-commit --format="%B" >expected &&
 	git show HEAD --format="%B" >actual &&
-	grep -f actual expected &&
-	grep "Creating an empty commit: empty commit" output
+	test_grep -f actual expected &&
+	test_grep "Creating an empty commit: empty commit" output
 '
 
 test_expect_success 'skip an empty patch in the middle of an am session' '
 	git checkout empty-commit^ &&
 	test_must_fail git am empty-commit.patch >out 2>err &&
-	grep "Patch is empty." out &&
-	grep "To record the empty patch as an empty commit, run \"git am --allow-empty\"." err &&
+	test_grep "Patch is empty." out &&
+	test_grep "To record the empty patch as an empty commit, run \"git am --allow-empty\"." err &&
 	git am --skip &&
 	test_path_is_missing .git/rebase-apply &&
 	git rev-parse empty-commit^ >expected &&
@@ -1237,14 +1237,14 @@ test_expect_success 'skip an empty patch in the middle of an am session' '
 test_expect_success 'record an empty patch as an empty commit in the middle of an am session' '
 	git checkout empty-commit^ &&
 	test_must_fail git am empty-commit.patch >out 2>err &&
-	grep "Patch is empty." out &&
-	grep "To record the empty patch as an empty commit, run \"git am --allow-empty\"." err &&
+	test_grep "Patch is empty." out &&
+	test_grep "To record the empty patch as an empty commit, run \"git am --allow-empty\"." err &&
 	git am --allow-empty >output &&
-	grep "No changes - recorded it as an empty commit." output &&
+	test_grep "No changes - recorded it as an empty commit." output &&
 	test_path_is_missing .git/rebase-apply &&
 	git show empty-commit --format="%B" >expected &&
 	git show HEAD --format="%B" >actual &&
-	grep -f actual expected
+	test_grep -f actual expected
 '
 
 test_expect_success 'create an non-empty commit when the index IS changed though "--allow-empty" is given' '
@@ -1255,7 +1255,7 @@ test_expect_success 'create an non-empty commit when the index IS changed though
 	git am --allow-empty &&
 	git show empty-commit --format="%B" >expected &&
 	git show HEAD --format="%B" >actual &&
-	grep -f actual expected &&
+	test_grep -f actual expected &&
 	git diff HEAD^..HEAD --name-only
 '
 
@@ -1264,7 +1264,7 @@ test_expect_success 'cannot create empty commits when there is a clean index due
 	git rev-parse HEAD >expected &&
 	test_must_fail git am seq.patch &&
 	test_must_fail git am --allow-empty >err &&
-	! grep "To record the empty patch as an empty commit, run \"git am --allow-empty\"." err &&
+	test_grep ! "To record the empty patch as an empty commit, run \"git am --allow-empty\"." err &&
 	git rev-parse HEAD >actual &&
 	test_cmp actual expected
 '
@@ -1274,7 +1274,7 @@ test_expect_success 'cannot create empty commits when there is unmerged index du
 	git rev-parse HEAD >expected &&
 	test_must_fail git am -3 seq.patch &&
 	test_must_fail git am --allow-empty >err &&
-	! grep "To record the empty patch as an empty commit, run \"git am --allow-empty\"." err &&
+	test_grep ! "To record the empty patch as an empty commit, run \"git am --allow-empty\"." err &&
 	git rev-parse HEAD >actual &&
 	test_cmp actual expected
 '
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 1717f407c8..5466fb78bc 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -83,7 +83,7 @@ test_expect_success 'activate rerere, old style (conflicting merge)' '
 
 	sha1=$(sed "s/	.*//" .git/MERGE_RR) &&
 	rr=.git/rr-cache/$sha1 &&
-	grep "^=======\$" $rr/preimage &&
+	test_grep "^=======\$" $rr/preimage &&
 	test_path_is_missing $rr/postimage &&
 	test_path_is_missing $rr/thisimage
 '
@@ -96,7 +96,7 @@ test_expect_success 'rerere.enabled works, too' '
 
 	sha1=$(sed "s/	.*//" .git/MERGE_RR) &&
 	rr=.git/rr-cache/$sha1 &&
-	grep ^=======$ $rr/preimage
+	test_grep ^=======$ $rr/preimage
 '
 
 test_expect_success 'set up rr-cache' '
@@ -177,7 +177,7 @@ test_expect_success 'first postimage wins' '
 
 	test_must_fail git merge first &&
 	# rerere kicked in
-	! grep "^=======\$" a1 &&
+	test_grep ! "^=======\$" a1 &&
 	test_cmp expect a1
 '
 
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 9f41d56d9a..023fbff546 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -267,7 +267,7 @@ test_expect_success 'shortlog --group=<format> DWIM' '
 
 test_expect_success 'shortlog bogus --group' '
 	test_must_fail git shortlog --group=bogus HEAD 2>err &&
-	grep "unknown group type" err
+	test_grep "unknown group type" err
 '
 
 test_expect_success 'trailer idents are split' '
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 75edb0eb38..06552a6271 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -668,12 +668,12 @@ test_expect_success 'log --graph with merge with log.graphColors' '
 
 test_expect_success 'log --raw --graph -m with merge' '
 	git log --raw --graph --oneline -m main | head -n 500 >actual &&
-	grep "initial" actual
+	test_grep "initial" actual
 '
 
 test_expect_success 'diff-tree --graph' '
 	git diff-tree --graph main^ | head -n 500 >actual &&
-	grep "one" actual
+	test_grep "one" actual
 '
 
 cat > expect <<\EOF
@@ -1082,13 +1082,13 @@ test_expect_success 'decorate-refs and simplify-by-decoration without output' '
 test_expect_success 'decorate-refs-exclude HEAD' '
 	git log --decorate=full --oneline \
 		--decorate-refs-exclude="HEAD" >actual &&
-	! grep HEAD actual
+	test_grep ! HEAD actual
 '
 
 test_expect_success 'decorate-refs focus from default' '
 	git log --decorate=full --oneline \
 		--decorate-refs="refs/heads" >actual &&
-	! grep HEAD actual
+	test_grep ! HEAD actual
 '
 
 test_expect_success '--clear-decorations overrides defaults' '
@@ -2095,45 +2095,45 @@ test_expect_success GPGSSH 'log ssh key fingerprint' '
 
 test_expect_success GPG 'log --graph --show-signature' '
 	git log --graph --show-signature -n1 signed >actual &&
-	grep "^| gpg: Signature made" actual &&
-	grep "^| gpg: Good signature" actual
+	test_grep "^| gpg: Signature made" actual &&
+	test_grep "^| gpg: Good signature" actual
 '
 
 test_expect_success GPGSM 'log --graph --show-signature x509' '
 	git log --graph --show-signature -n1 signed-x509 >actual &&
-	grep "^| gpgsm: Signature made" actual &&
-	grep "^| gpgsm: Good signature" actual
+	test_grep "^| gpgsm: Signature made" actual &&
+	test_grep "^| gpgsm: Good signature" actual
 '
 
 test_expect_success GPGSSH 'log --graph --show-signature ssh' '
 	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
 	git log --graph --show-signature -n1 signed-ssh >actual &&
-	grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+	test_grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
 '
 
 test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'log shows failure on expired signature key' '
 	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
 	git log --graph --show-signature -n1 expired-signed >actual &&
-	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+	test_grep ! "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
 '
 
 test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'log shows failure on not yet valid signature key' '
 	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
 	git log --graph --show-signature -n1 notyetvalid-signed >actual &&
-	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+	test_grep ! "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
 '
 
 test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'log show success with commit date and key validity matching' '
 	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
 	git log --graph --show-signature -n1 timeboxedvalid-signed >actual &&
-	grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
-	! grep "${GPGSSH_BAD_SIGNATURE}" actual
+	test_grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
+	test_grep ! "${GPGSSH_BAD_SIGNATURE}" actual
 '
 
 test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'log shows failure with commit date outside of key validity' '
 	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
 	git log --graph --show-signature -n1 timeboxedinvalid-signed >actual &&
-	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+	test_grep ! "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
 '
 
 test_expect_success GPG 'log --graph --show-signature for merged tag' '
@@ -2150,9 +2150,9 @@ test_expect_success GPG 'log --graph --show-signature for merged tag' '
 	git checkout plain &&
 	git merge --no-ff -m msg signed_tag &&
 	git log --graph --show-signature -n1 plain >actual &&
-	grep "^|\\\  merged tag" actual &&
-	grep "^| | gpg: Signature made" actual &&
-	grep "^| | gpg: Good signature" actual
+	test_grep "^|\\\  merged tag" actual &&
+	test_grep "^| | gpg: Signature made" actual &&
+	test_grep "^| | gpg: Good signature" actual
 '
 
 test_expect_success GPG 'log --graph --show-signature for merged tag in shallow clone' '
@@ -2172,7 +2172,7 @@ test_expect_success GPG 'log --graph --show-signature for merged tag in shallow
 	git clone --depth 1 --no-local . shallow &&
 	test_when_finished "rm -rf shallow" &&
 	git -C shallow log --graph --show-signature -n1 plain-shallow >actual &&
-	grep "tag signed_tag_shallow names a non-parent $hash" actual
+	test_grep "tag signed_tag_shallow names a non-parent $hash" actual
 '
 
 test_expect_success GPG 'log --graph --show-signature for merged tag with missing key' '
@@ -2189,9 +2189,9 @@ test_expect_success GPG 'log --graph --show-signature for merged tag with missin
 	git checkout plain-nokey &&
 	git merge --no-ff -m msg signed_tag_nokey &&
 	GNUPGHOME=. git log --graph --show-signature -n1 plain-nokey >actual &&
-	grep "^|\\\  merged tag" actual &&
-	grep "^| | gpg: Signature made" actual &&
-	grep -E "^| | gpg: Can'"'"'t check signature: (public key not found|No public key)" actual
+	test_grep "^|\\\  merged tag" actual &&
+	test_grep "^| | gpg: Signature made" actual &&
+	test_grep -E "^| | gpg: Can'"'"'t check signature: (public key not found|No public key)" actual
 '
 
 test_expect_success GPG 'log --graph --show-signature for merged tag with bad signature' '
@@ -2211,9 +2211,9 @@ test_expect_success GPG 'log --graph --show-signature for merged tag with bad si
 	git checkout plain-bad &&
 	git merge --no-ff -m msg "$(cat forged.tag)" &&
 	git log --graph --show-signature -n1 plain-bad >actual &&
-	grep "^|\\\  merged tag" actual &&
-	grep "^| | gpg: Signature made" actual &&
-	grep "^| | gpg: BAD signature from" actual
+	test_grep "^|\\\  merged tag" actual &&
+	test_grep "^| | gpg: Signature made" actual &&
+	test_grep "^| | gpg: BAD signature from" actual
 '
 
 test_expect_success GPG 'log --show-signature for merged tag with GPG failure' '
@@ -2232,9 +2232,9 @@ test_expect_success GPG 'log --show-signature for merged tag with GPG failure' '
 	if ! test_have_prereq VALGRIND
 	then
 		TMPDIR="$(pwd)/bogus" git log --show-signature -n1 plain-fail >actual &&
-		grep "^merged tag" actual &&
-		grep "^No signature" actual &&
-		! grep "^gpg: Signature made" actual
+		test_grep "^merged tag" actual &&
+		test_grep "^No signature" actual &&
+		test_grep ! "^gpg: Signature made" actual
 	fi
 '
 
@@ -2254,9 +2254,9 @@ test_expect_success GPGSM 'log --graph --show-signature for merged tag x509' '
 	git checkout plain-x509 &&
 	git merge --no-ff -m msg signed_tag_x509 &&
 	git log --graph --show-signature -n1 plain-x509 >actual &&
-	grep "^|\\\  merged tag" actual &&
-	grep "^| | gpgsm: Signature made" actual &&
-	grep "^| | gpgsm: Good signature" actual
+	test_grep "^|\\\  merged tag" actual &&
+	test_grep "^| | gpgsm: Signature made" actual &&
+	test_grep "^| | gpgsm: Good signature" actual
 '
 
 test_expect_success GPGSM 'log --graph --show-signature for merged tag x509 missing key' '
@@ -2275,8 +2275,8 @@ test_expect_success GPGSM 'log --graph --show-signature for merged tag x509 miss
 	git checkout plain-x509-nokey &&
 	git merge --no-ff -m msg signed_tag_x509_nokey &&
 	GNUPGHOME=. git log --graph --show-signature -n1 plain-x509-nokey >actual &&
-	grep "^|\\\  merged tag" actual &&
-	grep -e "^| | gpgsm: certificate not found" \
+	test_grep "^|\\\  merged tag" actual &&
+	test_grep -e "^| | gpgsm: certificate not found" \
 	     -e "^| | gpgsm: failed to find the certificate: Not found" actual
 '
 
@@ -2299,35 +2299,35 @@ test_expect_success GPGSM 'log --graph --show-signature for merged tag x509 bad
 	git checkout plain-x509-bad &&
 	git merge --no-ff -m msg "$(cat forged.tag)" &&
 	git log --graph --show-signature -n1 plain-x509-bad >actual &&
-	grep "^|\\\  merged tag" actual &&
-	grep "^| | gpgsm: Signature made" actual &&
-	grep "^| | gpgsm: invalid signature" actual
+	test_grep "^|\\\  merged tag" actual &&
+	test_grep "^| | gpgsm: Signature made" actual &&
+	test_grep "^| | gpgsm: invalid signature" actual
 '
 
 
 test_expect_success GPG '--no-show-signature overrides --show-signature' '
 	git log -1 --show-signature --no-show-signature signed >actual &&
-	! grep "^gpg:" actual
+	test_grep ! "^gpg:" actual
 '
 
 test_expect_success GPG 'log.showsignature=true behaves like --show-signature' '
 	test_config log.showsignature true &&
 	git log -1 signed >actual &&
-	grep "gpg: Signature made" actual &&
-	grep "gpg: Good signature" actual
+	test_grep "gpg: Signature made" actual &&
+	test_grep "gpg: Good signature" actual
 '
 
 test_expect_success GPG '--no-show-signature overrides log.showsignature=true' '
 	test_config log.showsignature true &&
 	git log -1 --no-show-signature signed >actual &&
-	! grep "^gpg:" actual
+	test_grep ! "^gpg:" actual
 '
 
 test_expect_success GPG '--show-signature overrides log.showsignature=false' '
 	test_config log.showsignature false &&
 	git log -1 --show-signature signed >actual &&
-	grep "gpg: Signature made" actual &&
-	grep "gpg: Good signature" actual
+	test_grep "gpg: Signature made" actual &&
+	test_grep "gpg: Good signature" actual
 '
 
 test_expect_success 'log --graph --no-walk is forbidden' '
@@ -2423,7 +2423,7 @@ test_expect_success 'log --decorate does not include things outside filter' '
 	git log --decorate=full --oneline >actual &&
 
 	# None of the refs are visible:
-	! grep /fake actual
+	test_grep ! /fake actual
 '
 
 test_expect_success 'log --end-of-options' '
diff --git a/t/t4204-patch-id.sh b/t/t4204-patch-id.sh
index 605faea0c7..90e661fe98 100755
--- a/t/t4204-patch-id.sh
+++ b/t/t4204-patch-id.sh
@@ -44,7 +44,7 @@ test_expect_success 'setup' '
 test_expect_success 'patch-id output is well-formed' '
 	git log -p -1 >log.output &&
 	git patch-id <log.output >output &&
-	grep "^$OID_REGEX $(git rev-parse HEAD)$" output
+	test_grep "^$OID_REGEX $(git rev-parse HEAD)$" output
 '
 
 #calculate patch id. Make sure output is not empty.
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 3865f6abc7..4be5c51489 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -535,7 +535,7 @@ test_expect_success 'strbuf_utf8_replace() not producing NUL' '
 	git log --color --pretty="tformat:%<(10,trunc)%s%>>(10,ltrunc)%C(auto)%d" |
 		test_decode_color |
 		nul_to_q >actual &&
-	! grep Q actual
+	test_grep ! Q actual
 '
 
 # --date=[XXX] and corresponding %a[X] %c[X] format equivalency
diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
index 0e2f80a268..802597efc7 100755
--- a/t/t4209-log-pickaxe.sh
+++ b/t/t4209-log-pickaxe.sh
@@ -64,21 +64,21 @@ test_expect_success 'usage' '
 	test_grep "switch.*requires a value" err &&
 
 	test_expect_code 128 git log -Gregex -Sstring 2>err &&
-	grep "cannot be used together" err &&
+	test_grep "cannot be used together" err &&
 
 	test_expect_code 128 git log -Gregex --find-object=HEAD 2>err &&
-	grep "cannot be used together" err &&
+	test_grep "cannot be used together" err &&
 
 	test_expect_code 128 git log -Sstring --find-object=HEAD 2>err &&
-	grep "cannot be used together" err &&
+	test_grep "cannot be used together" err &&
 
 	test_expect_code 128 git log --pickaxe-all --find-object=HEAD 2>err &&
-	grep "cannot be used together" err
+	test_grep "cannot be used together" err
 '
 
 test_expect_success 'usage: --pickaxe-regex' '
 	test_expect_code 128 git log -Gregex --pickaxe-regex 2>err &&
-	grep "cannot be used together" err
+	test_grep "cannot be used together" err
 '
 
 test_expect_success 'usage: --no-pickaxe-regex' '
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index ca4eb7bbc7..e61ef9b211 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -393,14 +393,14 @@ test_expect_success '-L diff output includes index and new file mode' '
 	git log -L:func2:file.c --format= >actual &&
 
 	# Output should contain index headers (not present in old code path)
-	grep "^index $head_blob_old\.\.$head_blob_new 100644" actual &&
+	test_grep "^index $head_blob_old\.\.$head_blob_new 100644" actual &&
 
 	# Root commit should show new file mode and null index
-	grep "^new file mode 100644" actual &&
-	grep "^index $null_blob\.\.$root_blob$" actual &&
+	test_grep "^new file mode 100644" actual &&
+	test_grep "^index $null_blob\.\.$root_blob$" actual &&
 
 	# Hunk headers should include funcname context
-	grep "^@@ .* @@ int func1()" actual
+	test_grep "^@@ .* @@ int func1()" actual
 '
 
 test_expect_success '-L with --word-diff' '
@@ -431,15 +431,15 @@ test_expect_success '-L with --word-diff' '
 
 test_expect_success '-L with --no-prefix' '
 	git log -L:func2:file.c --no-prefix --format= >actual &&
-	grep "^diff --git file.c file.c" actual &&
-	grep "^--- file.c" actual &&
-	! grep "^--- a/" actual
+	test_grep "^diff --git file.c file.c" actual &&
+	test_grep "^--- file.c" actual &&
+	test_grep ! "^--- a/" actual
 '
 
 test_expect_success '-L with --full-index' '
 	git log -L:func2:file.c --full-index --format= >actual &&
-	grep "^index $head_blob_old_full\.\.$head_blob_new_full 100644" actual &&
-	grep "^index $null_blob_full\.\.$root_blob_full$" actual
+	test_grep "^index $head_blob_old_full\.\.$head_blob_new_full 100644" actual &&
+	test_grep "^index $null_blob_full\.\.$root_blob_full$" actual
 '
 
 test_expect_success 'setup -L with whitespace change' '
@@ -548,29 +548,29 @@ test_expect_success '-L with --word-diff-regex' '
 	git log -L:func2:file.c --word-diff \
 		--word-diff-regex="[a-zA-Z0-9_]+" --format= >actual &&
 	# Word-diff markers must be present
-	grep "{+" actual &&
-	grep "+}" actual &&
+	test_grep "{+" actual &&
+	test_grep "+}" actual &&
 	# No line-level +/- markers (word-diff replaces them);
 	# exclude --- header lines from the check
-	! grep "^+[^+]" actual &&
-	! grep "^-[^-]" actual
+	test_grep ! "^+[^+]" actual &&
+	test_grep ! "^-[^-]" actual
 '
 
 test_expect_success '-L with --src-prefix and --dst-prefix' '
 	git checkout parent-oids &&
 	git log -L:func2:file.c --src-prefix=old/ --dst-prefix=new/ \
 		--format= >actual &&
-	grep "^diff --git old/file.c new/file.c" actual &&
-	grep "^--- old/file.c" actual &&
-	grep "^+++ new/file.c" actual &&
-	! grep "^--- a/" actual
+	test_grep "^diff --git old/file.c new/file.c" actual &&
+	test_grep "^--- old/file.c" actual &&
+	test_grep "^+++ new/file.c" actual &&
+	test_grep ! "^--- a/" actual
 '
 
 test_expect_success '-L with --abbrev' '
 	git checkout parent-oids &&
 	git log -L:func2:file.c --abbrev=4 --format= -1 >actual &&
 	# 4-char abbreviated hashes on index line
-	grep "^index [0-9a-f]\{4\}\.\.[0-9a-f]\{4\}" actual
+	test_grep "^index [0-9a-f]\{4\}\.\.[0-9a-f]\{4\}" actual
 '
 
 test_expect_success '-L with -b suppresses whitespace-only diff' '
@@ -586,24 +586,24 @@ test_expect_success '-L with --output-indicator-*' '
 	git log -L:func2:file.c --output-indicator-new=">" \
 		--output-indicator-old="<" --output-indicator-context="|" \
 		--format= -1 >actual &&
-	grep "^>" actual &&
-	grep "^<" actual &&
-	grep "^|" actual &&
+	test_grep "^>" actual &&
+	test_grep "^<" actual &&
+	test_grep "^|" actual &&
 	# No standard +/-/space content markers; exclude ---/+++ headers
-	! grep "^+[^+]" actual &&
-	! grep "^-[^-]" actual &&
-	! grep "^ " actual
+	test_grep ! "^+[^+]" actual &&
+	test_grep ! "^-[^-]" actual &&
+	test_grep ! "^ " actual
 '
 
 test_expect_success '-L with -R reverses diff' '
 	git checkout parent-oids &&
 	git log -L:func2:file.c -R --format= -1 >actual &&
-	grep "^diff --git b/file.c a/file.c" actual &&
-	grep "^--- b/file.c" actual &&
-	grep "^+++ a/file.c" actual &&
+	test_grep "^diff --git b/file.c a/file.c" actual &&
+	test_grep "^--- b/file.c" actual &&
+	test_grep "^+++ a/file.c" actual &&
 	# The modification added "F2 + 2", so reversed it is removed
-	grep "^-.*F2 + 2" actual &&
-	grep "^+.*return F2;" actual
+	test_grep "^-.*F2 + 2" actual &&
+	test_grep "^+.*return F2;" actual
 '
 
 test_expect_success 'setup for color-moved test' '
@@ -629,8 +629,8 @@ test_expect_success '-L with --color-moved' '
 		--color=always --format= -1 >actual.raw &&
 	test_decode_color <actual.raw >actual &&
 	# Old moved lines: bold magenta; new moved lines: bold cyan
-	grep "BOLD;MAGENTA" actual &&
-	grep "BOLD;CYAN" actual
+	test_grep "BOLD;MAGENTA" actual &&
+	test_grep "BOLD;CYAN" actual
 '
 
 test_expect_success 'setup for no-newline-at-eof tests' '
@@ -650,14 +650,14 @@ test_expect_success 'setup for no-newline-at-eof tests' '
 # newline, the "\ No newline at end of file" marker should appear.
 test_expect_success '-L no-newline-at-eof appears in tracked range' '
 	git log -L:bot:noeol.c --format= -1 HEAD~1 >actual &&
-	grep "No newline at end of file" actual
+	test_grep "No newline at end of file" actual
 '
 
 # When tracking a function that ends before the no-newline content,
 # the marker should not appear in the output.
 test_expect_success '-L no-newline-at-eof suppressed outside range' '
 	git log -L:top:noeol.c --format= >actual &&
-	! grep "No newline at end of file" actual
+	test_grep ! "No newline at end of file" actual
 '
 
 # When a commit removes a no-newline last line and replaces it with
@@ -665,7 +665,7 @@ test_expect_success '-L no-newline-at-eof suppressed outside range' '
 # old side of the diff).
 test_expect_success '-L no-newline-at-eof marker with deleted line' '
 	git log -L:bot:noeol.c --format= -1 >actual &&
-	grep "No newline at end of file" actual
+	test_grep "No newline at end of file" actual
 '
 
 test_expect_success 'setup for range boundary deletion test' '
@@ -725,7 +725,7 @@ test_expect_success '-L with -S filters to string-count changes' '
 	# combined with the -L range walk, this selects commits that
 	# both touch func2 and change the count of "F2 + 2" in the file.
 	test $(grep -c "^diff --git" actual) = 1 &&
-	grep "F2 + 2" actual
+	test_grep "F2 + 2" actual
 '
 
 test_expect_success '-L with -G filters to diff-text matches' '
@@ -735,7 +735,7 @@ test_expect_success '-L with -G filters to diff-text matches' '
 	# combined with -L, this selects commits that both touch func2
 	# and have "F2 + 2" in their diff.
 	test $(grep -c "^diff --git" actual) = 1 &&
-	grep "F2 + 2" actual
+	test_grep "F2 + 2" actual
 '
 
 test_expect_success '-L with --diff-filter=M excludes root commit' '
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 16bc39c359..ad2686669d 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -224,10 +224,10 @@ test_expect_success 'persist filter settings' '
 		GIT_TEST_BLOOM_SETTINGS_NUM_HASHES=9 \
 		GIT_TEST_BLOOM_SETTINGS_BITS_PER_ENTRY=15 \
 		git commit-graph write --reachable --changed-paths &&
-	grep "{\"hash_version\":1,\"num_hashes\":9,\"bits_per_entry\":15,\"max_changed_paths\":512" trace2.txt &&
+	test_grep "{\"hash_version\":1,\"num_hashes\":9,\"bits_per_entry\":15,\"max_changed_paths\":512" trace2.txt &&
 	GIT_TRACE2_EVENT="$(pwd)/trace2-auto.txt" \
 		git commit-graph write --reachable --changed-paths &&
-	grep "{\"hash_version\":1,\"num_hashes\":9,\"bits_per_entry\":15,\"max_changed_paths\":512" trace2-auto.txt
+	test_grep "{\"hash_version\":1,\"num_hashes\":9,\"bits_per_entry\":15,\"max_changed_paths\":512" trace2-auto.txt
 '
 
 test_max_changed_paths () {
@@ -494,7 +494,7 @@ test_expect_success 'ensure Bloom filters with incompatible settings are ignored
 		>expect 2>err &&
 	git -C $repo log --oneline --no-decorate -- file >actual 2>err &&
 	test_cmp expect actual &&
-	grep "disabling Bloom filters for commit-graph layer .$layer." err
+	test_grep "disabling Bloom filters for commit-graph layer .$layer." err
 '
 
 test_expect_success 'merge graph layers with incompatible Bloom settings' '
@@ -503,8 +503,8 @@ test_expect_success 'merge graph layers with incompatible Bloom settings' '
 	>trace2.txt &&
 	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
 		git -C $repo commit-graph write --reachable --changed-paths 2>err &&
-	grep "disabling Bloom filters for commit-graph layer .$layer." err &&
-	grep "{\"hash_version\":1,\"num_hashes\":7,\"bits_per_entry\":10,\"max_changed_paths\":512" trace2.txt &&
+	test_grep "disabling Bloom filters for commit-graph layer .$layer." err &&
+	test_grep "{\"hash_version\":1,\"num_hashes\":7,\"bits_per_entry\":10,\"max_changed_paths\":512" trace2.txt &&
 
 	test_path_is_file $repo/$graph &&
 	test_dir_is_empty $repo/$graphdir &&
@@ -516,7 +516,7 @@ test_expect_success 'merge graph layers with incompatible Bloom settings' '
 		git -C $repo log --oneline --no-decorate -- file >actual 2>err &&
 
 	test_cmp expect actual &&
-	grep "statistics:{\"filter_not_present\":0," trace.perf &&
+	test_grep "statistics:{\"filter_not_present\":0," trace.perf &&
 	test_must_be_empty err
 '
 
@@ -554,8 +554,8 @@ test_expect_success 'ensure Bloom filter with incompatible versions are ignored'
 	>trace2.txt &&
 	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
 		git -C $repo -c commitGraph.changedPathsVersion=2 commit-graph write --reachable --changed-paths 2>err &&
-	grep "disabling Bloom filters for commit-graph layer .$layer." err &&
-	grep "{\"hash_version\":2,\"num_hashes\":7,\"bits_per_entry\":10,\"max_changed_paths\":512" trace2.txt
+	test_grep "disabling Bloom filters for commit-graph layer .$layer." err &&
+	test_grep "{\"hash_version\":2,\"num_hashes\":7,\"bits_per_entry\":10,\"max_changed_paths\":512" trace2.txt
 '
 
 get_first_changed_path_filter () {
@@ -755,7 +755,7 @@ test_expect_success PERL_TEST_HELPERS 'Bloom reader notices too-small data chunk
 test_expect_success PERL_TEST_HELPERS 'Bloom reader notices out-of-bounds filter offsets' '
 	check_corrupt_graph BIDX 12 FFFFFFFF &&
 	# use grep to avoid depending on exact chunk size
-	grep "warning: ignoring out-of-range offset (4294967295) for changed-path filter at pos 3 of .git/objects/info/commit-graph" err
+	test_grep "warning: ignoring out-of-range offset (4294967295) for changed-path filter at pos 3 of .git/objects/info/commit-graph" err
 '
 
 test_expect_success PERL_TEST_HELPERS 'Bloom reader notices too-small index chunk' '
diff --git a/t/t4252-am-options.sh b/t/t4252-am-options.sh
index bda8822b3d..c36c7e9017 100755
--- a/t/t4252-am-options.sh
+++ b/t/t4252-am-options.sh
@@ -20,8 +20,8 @@ test_expect_success 'interrupted am --whitespace=fix' '
 	git reset --hard initial &&
 	test_must_fail git am --whitespace=fix "$tm"/am-test-1-? &&
 	git am --skip &&
-	grep 3 file-1 &&
-	grep "^Six$" file-2
+	test_grep 3 file-1 &&
+	test_grep "^Six$" file-2
 '
 
 test_expect_success 'interrupted am -C1' '
@@ -29,8 +29,8 @@ test_expect_success 'interrupted am -C1' '
 	git reset --hard initial &&
 	test_must_fail git am -C1 "$tm"/am-test-2-? &&
 	git am --skip &&
-	grep 3 file-1 &&
-	grep "^Three$" file-2
+	test_grep 3 file-1 &&
+	test_grep "^Three$" file-2
 '
 
 test_expect_success 'interrupted am -p2' '
@@ -38,8 +38,8 @@ test_expect_success 'interrupted am -p2' '
 	git reset --hard initial &&
 	test_must_fail git am -p2 "$tm"/am-test-3-? &&
 	git am --skip &&
-	grep 3 file-1 &&
-	grep "^Three$" file-2
+	test_grep 3 file-1 &&
+	test_grep "^Three$" file-2
 '
 
 test_expect_success 'interrupted am -C1 -p2' '
@@ -47,8 +47,8 @@ test_expect_success 'interrupted am -C1 -p2' '
 	git reset --hard initial &&
 	test_must_fail git am -p2 -C1 "$tm"/am-test-4-? &&
 	git am --skip &&
-	grep 3 file-1 &&
-	grep "^Three$" file-2
+	test_grep 3 file-1 &&
+	test_grep "^Three$" file-2
 '
 
 test_expect_success 'interrupted am --directory="frotz nitfol"' '
@@ -56,7 +56,7 @@ test_expect_success 'interrupted am --directory="frotz nitfol"' '
 	git reset --hard initial &&
 	test_must_fail git am --directory="frotz nitfol" "$tm"/am-test-5-? &&
 	git am --skip &&
-	grep One "frotz nitfol/file-5"
+	test_grep One "frotz nitfol/file-5"
 '
 
 test_expect_success 'apply to a funny path' '
@@ -71,9 +71,9 @@ test_expect_success 'am --reject' '
 	rm -rf .git/rebase-apply &&
 	git reset --hard initial &&
 	test_must_fail git am --reject "$tm"/am-test-6-1 &&
-	grep "@@ -1,3 +1,3 @@" file-2.rej &&
+	test_grep "@@ -1,3 +1,3 @@" file-2.rej &&
 	test_must_fail git diff-files --exit-code --quiet file-2 &&
-	grep "[-]-reject" .git/rebase-apply/apply-opt
+	test_grep "[-]-reject" .git/rebase-apply/apply-opt
 '
 
 test_done
diff --git a/t/t4254-am-corrupt.sh b/t/t4254-am-corrupt.sh
index 96ddf3c53a..f68b5d3127 100755
--- a/t/t4254-am-corrupt.sh
+++ b/t/t4254-am-corrupt.sh
@@ -73,16 +73,16 @@ test_expect_success "NUL in commit message's body" '
 	test_when_finished "git am --abort" &&
 	make_mbox_with_nul body >body.patch &&
 	test_must_fail git am body.patch 2>err &&
-	grep "a NUL byte in commit log message not allowed" err
+	test_grep "a NUL byte in commit log message not allowed" err
 '
 
 test_expect_success "NUL in commit message's header" "
 	test_when_finished 'git am --abort' &&
 	make_mbox_with_nul subject >subject.patch &&
 	test_must_fail git mailinfo msg patch <subject.patch 2>err &&
-	grep \"a NUL byte in 'Subject' is not allowed\" err &&
+	test_grep \"a NUL byte in 'Subject' is not allowed\" err &&
 	test_must_fail git am subject.patch 2>err &&
-	grep \"a NUL byte in 'Subject' is not allowed\" err
+	test_grep \"a NUL byte in 'Subject' is not allowed\" err
 "
 
 test_done
diff --git a/t/t4258-am-quoted-cr.sh b/t/t4258-am-quoted-cr.sh
index 201915b45a..50e81b9330 100755
--- a/t/t4258-am-quoted-cr.sh
+++ b/t/t4258-am-quoted-cr.sh
@@ -16,7 +16,7 @@ test_expect_success 'setup' '
 test_expect_success 'am warn if quoted-cr is found' '
 	git reset --hard one &&
 	test_must_fail git am "$DATA/mbox" 2>err &&
-	grep "quoted CRLF detected" err
+	test_grep "quoted CRLF detected" err
 '
 
 test_expect_success 'am --quoted-cr=strip' '
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index 6e117ee93c..b2684911d1 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -88,7 +88,7 @@ test_expect_success 'Clean merge' '
 # Repeat the previous test, but turn off rename detection
 test_expect_success 'Failed merge without rename detection' '
 	test_must_fail git -c diff.renames=false merge-tree --write-tree side1 side3 >out &&
-	grep "CONFLICT (modify/delete): numbers deleted" out
+	test_grep "CONFLICT (modify/delete): numbers deleted" out
 '
 
 test_expect_success  '--quiet on conflicted merge' '
@@ -161,13 +161,13 @@ test_expect_success 'Barf on misspelled option, with exit code other than 0 or 1
 	# Mis-spell with single "s" instead of double "s"
 	test_expect_code 129 git merge-tree --write-tree --mesages FOOBAR side1 side2 2>expect &&
 
-	grep "error: unknown option.*mesages" expect
+	test_grep "error: unknown option.*mesages" expect
 '
 
 test_expect_success 'Barf on too many arguments' '
 	test_expect_code 129 git merge-tree --write-tree side1 side2 invalid 2>expect &&
 
-	grep "^usage: git merge-tree" expect
+	test_grep "^usage: git merge-tree" expect
 '
 
 anonymize_hash() {
@@ -352,7 +352,7 @@ test_expect_success 'rename/add handling' '
 		#
 		hash=$(tr "\0" "\n" <out | head -n 3 | grep 3.bar | cut -f 2 -d " ") &&
 		git rev-list --objects --all >all_blobs &&
-		! grep $hash all_blobs &&
+		test_grep ! $hash all_blobs &&
 
 		#
 		# Second, check anonymized hash output against expectation
@@ -419,7 +419,7 @@ test_expect_success SYMLINKS 'rename/add, where add is a mode conflict' '
 		#
 		hash=$(tr "\0" "\n" <out | head -n 3 | grep 3.bar | cut -f 2 -d " ") &&
 		git rev-list --objects --all >all_blobs &&
-		! grep $hash all_blobs &&
+		test_grep ! $hash all_blobs &&
 
 		#
 		# Second, check anonymized hash output against expectation
@@ -670,8 +670,8 @@ test_expect_success 'mod6: chains of rename/rename(1to2) and add/add via collidi
 		hash1=$(tr "\0" "\n" <out | head | grep 2.four | cut -f 2 -d " ") &&
 		hash2=$(tr "\0" "\n" <out | head | grep 3.two | cut -f 2 -d " ") &&
 		git rev-list --objects --all >all_blobs &&
-		! grep $hash1 all_blobs &&
-		! grep $hash2 all_blobs &&
+		test_grep ! $hash1 all_blobs &&
+		test_grep ! $hash2 all_blobs &&
 
 		#
 		# Now compare anonymized hash output with expectation
@@ -857,7 +857,7 @@ test_expect_success 'NUL terminated conflicted file "lines"' '
 test_expect_success 'error out by default for unrelated histories' '
 	test_expect_code 128 git merge-tree --write-tree side1 unrelated 2>error &&
 
-	grep "refusing to merge unrelated histories" error
+	test_grep "refusing to merge unrelated histories" error
 '
 
 test_expect_success 'can override merge of unrelated histories' '
@@ -924,7 +924,7 @@ test_expect_success '--stdin with both a successful and a conflicted merge' '
 test_expect_success '--merge-base is incompatible with --stdin' '
 	test_must_fail git merge-tree --merge-base=side1 --stdin 2>expect &&
 
-	grep "^fatal: .*merge-base.*stdin.* cannot be used together" expect
+	test_grep "^fatal: .*merge-base.*stdin.* cannot be used together" expect
 '
 
 # specify merge-base as parent of branch2
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index a8c28533dc..3ad600c793 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -323,14 +323,14 @@ test_expect_success 'setup tar filters' '
 
 test_expect_success 'archive --list mentions user filter' '
 	git archive --list >output &&
-	grep "^tar\.foo\$" output &&
-	grep "^bar\$" output
+	test_grep "^tar\.foo\$" output &&
+	test_grep "^bar\$" output
 '
 
 test_expect_success 'archive --list shows only enabled remote filters' '
 	git archive --list --remote=. >output &&
-	! grep "^tar\.foo\$" output &&
-	grep "^bar\$" output
+	test_grep ! "^tar\.foo\$" output &&
+	test_grep "^bar\$" output
 '
 
 test_expect_success 'invoke tar filter by format' '
@@ -440,7 +440,7 @@ test_expect_success 'catch non-matching pathspec' '
 
 test_expect_success 'reject paths outside the current directory' '
 	test_must_fail git -C a/bin archive HEAD .. >/dev/null 2>err &&
-	grep "outside the current directory" err
+	test_grep "outside the current directory" err
 '
 
 test_expect_success 'allow pathspecs that resolve to the current directory' '
diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-cases.sh
index df513a4269..768b0ff85d 100755
--- a/t/t5004-archive-corner-cases.sh
+++ b/t/t5004-archive-corner-cases.sh
@@ -205,7 +205,7 @@ test_expect_success EXPENSIVE,LONG_IS_64BIT,UNZIP,UNZIP_ZIP64_SUPPORT,ZIPINFO \
 
 	"$GIT_UNZIP" -t big.zip &&
 	"$ZIPINFO" big.zip >big.lst &&
-	grep $size big.lst
+	test_grep $size big.lst
 '
 
 build_tree() {
diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index e57e1ae739..e01078abe7 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -265,7 +265,7 @@ test_expect_success 'mailinfo warn CR in base64 encoded email' '
 	check_quoted_cr_mail quoted-cr/0001 &&
 	test_must_be_empty quoted-cr/0001.err &&
 	check_quoted_cr_mail quoted-cr/0002 &&
-	grep "quoted CRLF detected" quoted-cr/0002.err &&
+	test_grep "quoted CRLF detected" quoted-cr/0002.err &&
 	check_quoted_cr_mail quoted-cr/0001 --quoted-cr=nowarn &&
 	test_must_be_empty quoted-cr/0001.err &&
 	check_quoted_cr_mail quoted-cr/0002 --quoted-cr=nowarn &&
diff --git a/t/t5150-request-pull.sh b/t/t5150-request-pull.sh
index 270ce6ea48..67c5dc7e85 100755
--- a/t/t5150-request-pull.sh
+++ b/t/t5150-request-pull.sh
@@ -130,8 +130,8 @@ test_expect_success 'pull request when forgot to push' '
 		test_must_fail git request-pull initial "$downstream_url" \
 			2>../err
 	) &&
-	grep "No match for commit .*" err &&
-	grep "Are you sure you pushed" err
+	test_grep "No match for commit .*" err &&
+	test_grep "Are you sure you pushed" err
 
 '
 
@@ -230,7 +230,7 @@ test_expect_success 'pull request format' '
 		cd local &&
 		git request-pull initial "$downstream_url" full
 	) >request &&
-	grep " tags/full\$" request
+	test_grep " tags/full\$" request
 '
 
 test_expect_success 'request-pull ignores OPTIONS_KEEPDASHDASH poison' '
@@ -260,8 +260,8 @@ test_expect_success 'request-pull quotes regex metacharacters properly' '
 		test_must_fail git request-pull initial "$downstream_url" tags/v2.0 \
 			2>../err
 	) &&
-	grep "No match for commit .*" err &&
-	grep "Are you sure you pushed" err
+	test_grep "No match for commit .*" err &&
+	test_grep "Are you sure you pushed" err
 
 '
 
@@ -277,8 +277,8 @@ test_expect_success 'pull request with mismatched object' '
 		test_must_fail git request-pull initial "$downstream_url" tags/full \
 			2>../err
 	) &&
-	grep "points to a different object" err &&
-	grep "Are you sure you pushed" err
+	test_grep "points to a different object" err &&
+	test_grep "Are you sure you pushed" err
 
 '
 
@@ -295,8 +295,8 @@ test_expect_success 'pull request with stale object' '
 		test_must_fail git request-pull initial "$downstream_url" tags/full \
 			2>../err
 	) &&
-	grep "points to a different object" err &&
-	grep "Are you sure you pushed" err
+	test_grep "points to a different object" err &&
+	test_grep "Are you sure you pushed" err
 
 '
 
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 73445782e7..9dabb3615a 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -548,18 +548,18 @@ test_expect_success !PTHREADS,!FAIL_PREREQS \
 	test_must_fail git index-pack --threads=2 2>err &&
 	grep ^warning: err >warnings &&
 	test_line_count = 1 warnings &&
-	grep -F "no threads support, ignoring --threads=2" err &&
+	test_grep -F "no threads support, ignoring --threads=2" err &&
 
 	test_must_fail git -c pack.threads=2 index-pack 2>err &&
 	grep ^warning: err >warnings &&
 	test_line_count = 1 warnings &&
-	grep -F "no threads support, ignoring pack.threads" err &&
+	test_grep -F "no threads support, ignoring pack.threads" err &&
 
 	test_must_fail git -c pack.threads=2 index-pack --threads=4 2>err &&
 	grep ^warning: err >warnings &&
 	test_line_count = 2 warnings &&
-	grep -F "no threads support, ignoring --threads=4" err &&
-	grep -F "no threads support, ignoring pack.threads" err
+	test_grep -F "no threads support, ignoring --threads=4" err &&
+	test_grep -F "no threads support, ignoring pack.threads" err
 '
 
 test_expect_success !PTHREADS,!FAIL_PREREQS \
@@ -567,18 +567,18 @@ test_expect_success !PTHREADS,!FAIL_PREREQS \
 	git pack-objects --threads=2 --stdout --all </dev/null >/dev/null 2>err &&
 	grep ^warning: err >warnings &&
 	test_line_count = 1 warnings &&
-	grep -F "no threads support, ignoring --threads" err &&
+	test_grep -F "no threads support, ignoring --threads" err &&
 
 	git -c pack.threads=2 pack-objects --stdout --all </dev/null >/dev/null 2>err &&
 	grep ^warning: err >warnings &&
 	test_line_count = 1 warnings &&
-	grep -F "no threads support, ignoring pack.threads" err &&
+	test_grep -F "no threads support, ignoring pack.threads" err &&
 
 	git -c pack.threads=2 pack-objects --threads=4 --stdout --all </dev/null >/dev/null 2>err &&
 	grep ^warning: err >warnings &&
 	test_line_count = 2 warnings &&
-	grep -F "no threads support, ignoring --threads" err &&
-	grep -F "no threads support, ignoring pack.threads" err
+	test_grep -F "no threads support, ignoring --threads" err &&
+	test_grep -F "no threads support, ignoring pack.threads" err
 '
 
 test_expect_success 'pack-objects in too-many-packs mode' '
@@ -720,14 +720,14 @@ test_expect_success '--name-hash-version=2 and --write-bitmap-index are incompat
 
 	# --stdout option silently removes --write-bitmap-index
 	git pack-objects --stdout --all --name-hash-version=2 --write-bitmap-index >out 2>err &&
-	! test_grep "currently, --write-bitmap-index requires --name-hash-version=1" err
+	test_grep ! "currently, --write-bitmap-index requires --name-hash-version=1" err
 '
 
 test_expect_success '--path-walk pack everything' '
 	git -C server rev-parse HEAD >in &&
 	GIT_PROGRESS_DELAY=0 git -C server pack-objects \
 		--stdout --revs --path-walk --progress <in >out.pack 2>err &&
-	grep "Compressing objects by path" err &&
+	test_grep "Compressing objects by path" err &&
 	git -C server index-pack --stdin <out.pack
 '
 
@@ -738,7 +738,7 @@ test_expect_success '--path-walk thin pack' '
 	EOF
 	GIT_PROGRESS_DELAY=0 git -C server pack-objects \
 		--thin --stdout --revs --path-walk --progress <in >out.pack 2>err &&
-	grep "Compressing objects by path" err &&
+	test_grep "Compressing objects by path" err &&
 	git -C server index-pack --fix-thin --stdin <out.pack
 '
 
diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index 9697448cb2..735de1023e 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -270,12 +270,12 @@ EOF
 	thirtyeight=${tag#??} &&
 	rm -f .git/objects/${tag%$thirtyeight}/$thirtyeight &&
 	git index-pack --strict tag-test-${pack1}.pack 2>err &&
-	grep "^warning:.* expected .tagger. line" err
+	test_grep "^warning:.* expected .tagger. line" err
 '
 
 test_expect_success 'index-pack --fsck-objects also warns upon missing tagger in tag' '
 	git index-pack --fsck-objects tag-test-${pack1}.pack 2>err &&
-	grep "^warning:.* expected .tagger. line" err
+	test_grep "^warning:.* expected .tagger. line" err
 '
 
 test_expect_success 'index-pack -v --stdin produces progress for both phases' '
@@ -290,7 +290,7 @@ test_expect_success 'too-large packs report the breach' '
 	sz="$(test_file_size pack-$pack.pack)" &&
 	test "$sz" -gt 20 &&
 	test_must_fail git index-pack --max-input-size=20 pack-$pack.pack 2>err &&
-	grep "maximum allowed size (20 bytes)" err
+	test_grep "maximum allowed size (20 bytes)" err
 '
 
 # git-index-pack(1) uses the default hash algorithm outside of the repository,
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index 2be7cd30de..db8e389c2c 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -120,7 +120,7 @@ test_expect_success 'prune: prune former HEAD after checking out branch' '
 	git checkout --quiet main &&
 	git reflog expire --all &&
 	git prune -v >prune_actual &&
-	grep "$head_oid" prune_actual
+	test_grep "$head_oid" prune_actual
 '
 
 test_expect_success 'prune: do not prune heads listed as an argument' '
@@ -214,7 +214,7 @@ test_expect_success 'garbage report in count-objects -v' '
 	>.git/objects/pack/fake2.keep &&
 	>.git/objects/pack/fake3.idx &&
 	git count-objects -v 2>stderr &&
-	grep "index file .git/objects/pack/fake.idx is too small" stderr &&
+	test_grep "index file .git/objects/pack/fake.idx is too small" stderr &&
 	grep "^warning:" stderr | sort >actual &&
 	cat >expected <<\EOF &&
 warning: garbage found: .git/objects/pack/fake.bar
@@ -252,8 +252,8 @@ test_expect_success 'prune .git/shallow' '
 	oid=$(echo hi|git commit-tree HEAD^{tree}) &&
 	echo $oid >.git/shallow &&
 	git prune --dry-run >out &&
-	grep $oid .git/shallow &&
-	grep $oid out &&
+	test_grep $oid .git/shallow &&
+	test_grep $oid out &&
 	git prune &&
 	test_path_is_missing .git/shallow
 '
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index efeb71593b..33ccb579c5 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -81,8 +81,8 @@ test_bitmap_cases () {
 			git repack -ad &&
 		ls .git/objects/pack/ | grep bitmap >output &&
 		test_line_count = 1 output &&
-		grep "\"key\":\"num_selected_commits\",\"value\":\"106\"" trace &&
-		grep "\"key\":\"num_maximal_commits\",\"value\":\"107\"" trace
+		test_grep "\"key\":\"num_selected_commits\",\"value\":\"106\"" trace &&
+		test_grep "\"key\":\"num_maximal_commits\",\"value\":\"107\"" trace
 	'
 
 	basic_bitmap_tests
@@ -532,8 +532,8 @@ test_bitmap_cases () {
 			test_line_count = 2 bitmaps &&
 
 			GIT_TRACE2_EVENT=$(pwd)/trace2.txt git rev-list --use-bitmap-index HEAD &&
-			grep "opened bitmap" trace2.txt &&
-			grep "ignoring extra bitmap" trace2.txt
+			test_grep "opened bitmap" trace2.txt &&
+			test_grep "ignoring extra bitmap" trace2.txt
 		)
 	'
 
@@ -598,7 +598,7 @@ test_expect_success 'boundary-based traversal is used when requested' '
 	do
 		eval "GIT_TRACE2_EVENT=1 $argv rev-list --objects \
 			--use-bitmap-index second..other 2>perf" &&
-		grep "\"region_enter\".*\"label\":\"haves/boundary\"" perf ||
+		test_grep "\"region_enter\".*\"label\":\"haves/boundary\"" perf ||
 			return 1
 	done &&
 
@@ -610,7 +610,7 @@ test_expect_success 'boundary-based traversal is used when requested' '
 	do
 		eval "GIT_TRACE2_EVENT=1 $argv rev-list --objects \
 			--use-bitmap-index second..other 2>perf" &&
-		grep "\"region_enter\".*\"label\":\"haves/classic\"" perf ||
+		test_grep "\"region_enter\".*\"label\":\"haves/classic\"" perf ||
 			return 1
 	done
 '
@@ -632,7 +632,7 @@ test_bitmap_cases "pack.writeBitmapLookupTable"
 test_expect_success 'verify writing bitmap lookup table when enabled' '
 	GIT_TRACE2_EVENT="$(pwd)/trace2" \
 		git repack -ad &&
-	grep "\"label\":\"writing_lookup_table\"" trace2
+	test_grep "\"label\":\"writing_lookup_table\"" trace2
 '
 
 test_expect_success 'truncated bitmap fails gracefully (lookup table)' '
diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-objects-filter-objects.sh
index dddb79ba62..2948a7cd2a 100755
--- a/t/t5317-pack-objects-filter-objects.sh
+++ b/t/t5317-pack-objects-filter-objects.sh
@@ -49,7 +49,7 @@ test_expect_success 'verify blob:none packfile has no blobs' '
 	git -C r1 index-pack ../filter.pack &&
 
 	git -C r1 verify-pack -v ../filter.pack >verify_result &&
-	! grep blob verify_result
+	test_grep ! blob verify_result
 '
 
 test_expect_success 'verify blob:none packfile without --stdout' '
@@ -57,7 +57,7 @@ test_expect_success 'verify blob:none packfile without --stdout' '
 	HEAD
 	EOF
 	git -C r1 verify-pack -v "mypackname-$(cat packhash).pack" >verify_result &&
-	! grep blob verify_result
+	test_grep ! blob verify_result
 '
 
 test_expect_success 'verify normal and blob:none packfiles have same commits/trees' '
@@ -85,7 +85,7 @@ test_expect_success 'get an error for missing tree object' '
 	test_must_fail git -C r5 pack-objects --revs --stdout 2>bad_tree <<-EOF &&
 	HEAD
 	EOF
-	grep "bad tree object" bad_tree
+	test_grep "bad tree object" bad_tree
 '
 
 test_expect_success 'setup for tests of tree:0' '
@@ -101,7 +101,7 @@ test_expect_success 'verify tree:0 packfile has no blobs or trees' '
 	EOF
 	git -C r1 index-pack ../commitsonly.pack &&
 	git -C r1 verify-pack -v ../commitsonly.pack >objs &&
-	! grep -E "tree|blob" objs
+	test_grep ! -E "tree|blob" objs
 '
 
 test_expect_success 'grab tree directly when using tree:0' '
@@ -156,7 +156,7 @@ test_expect_success 'verify blob:limit=500 omits all blobs' '
 	git -C r2 index-pack ../filter.pack &&
 
 	git -C r2 verify-pack -v ../filter.pack >verify_result &&
-	! grep blob verify_result
+	test_grep ! blob verify_result
 '
 
 test_expect_success 'verify blob:limit=1000' '
@@ -166,7 +166,7 @@ test_expect_success 'verify blob:limit=1000' '
 	git -C r2 index-pack ../filter.pack &&
 
 	git -C r2 verify-pack -v ../filter.pack >verify_result &&
-	! grep blob verify_result
+	test_grep ! blob verify_result
 '
 
 test_expect_success 'verify blob:limit=1001' '
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 1c40f904f8..6cecfbeaa1 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -14,7 +14,7 @@ test_expect_success 'usage' '
 
 test_expect_success 'usage shown without sub-command' '
 	test_expect_code 129 git commit-graph 2>err &&
-	grep usage: err
+	test_grep usage: err
 '
 
 test_expect_success 'usage shown with an error on unknown sub-command' '
@@ -679,12 +679,12 @@ test_expect_success 'git fsck (checks commit-graph when config unset)' '
 
 test_expect_success 'git fsck shows commit-graph output with --progress' '
 	git -C "$TRASH_DIRECTORY/full" fsck --progress 2>err &&
-	grep "Verifying commits in commit graph" err
+	test_grep "Verifying commits in commit graph" err
 '
 
 test_expect_success 'git fsck suppresses commit-graph output with --no-progress' '
 	git -C "$TRASH_DIRECTORY/full" fsck --no-progress 2>err &&
-	! grep "Verifying commits in commit graph" err
+	test_grep ! "Verifying commits in commit graph" err
 '
 
 test_expect_success 'setup non-the_repository tests' '
@@ -962,7 +962,7 @@ test_expect_success 'stale commit cannot be parsed when traversing graph' '
 		git rev-parse HEAD~2 &&
 		# ... but fail when we are paranoid.
 		test_must_fail env GIT_COMMIT_GRAPH_PARANOIA=true git rev-parse HEAD~2 2>error &&
-		grep "error: commit $oid exists in commit-graph but not in the object database" error
+		test_grep "error: commit $oid exists in commit-graph but not in the object database" error
 	)
 '
 
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index fa0d4046f7..68143cb5b7 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -130,7 +130,7 @@ test_expect_success 'corrupt idx reports errors' '
 	test_copy_bytes 1064 <backup-$idx >$objdir/pack/$idx &&
 
 	git -c core.multiPackIndex=true rev-list --objects --all 2>err &&
-	grep "index unavailable" err
+	test_grep "index unavailable" err
 '
 
 test_expect_success 'add more objects' '
@@ -326,7 +326,7 @@ test_expect_success 'preferred packs must be non-empty' '
 
 		test_must_fail git multi-pack-index write \
 			--preferred-pack=pack-$empty.pack 2>err &&
-		grep "with no objects" err
+		test_grep "with no objects" err
 	)
 '
 
@@ -548,14 +548,14 @@ test_expect_success 'git-fsck incorrect offset' '
 
 test_expect_success 'git fsck shows MIDX output with --progress' '
 	git fsck --progress 2>err &&
-	grep "Verifying OID order in multi-pack-index" err &&
-	grep "Verifying object offsets" err
+	test_grep "Verifying OID order in multi-pack-index" err &&
+	test_grep "Verifying object offsets" err
 '
 
 test_expect_success 'git fsck suppresses MIDX output with --no-progress' '
 	git fsck --no-progress 2>err &&
-	! grep "Verifying OID order in multi-pack-index" err &&
-	! grep "Verifying object offsets" err
+	test_grep ! "Verifying OID order in multi-pack-index" err &&
+	test_grep ! "Verifying object offsets" err
 '
 
 test_expect_success 'corrupt MIDX is not reused' '
@@ -1175,12 +1175,12 @@ test_expect_success 'load reverse index when missing .idx, .pack' '
 
 test_expect_success 'usage shown without sub-command' '
 	test_expect_code 129 git multi-pack-index 2>err &&
-	! test_grep "unrecognized subcommand" err
+	test_grep ! "unrecognized subcommand" err
 '
 
 test_expect_success 'complains when run outside of a repository' '
 	nongit test_must_fail git multi-pack-index write 2>err &&
-	grep "not a git repository" err
+	test_grep "not a git repository" err
 '
 
 test_expect_success 'repack with delta islands' '
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 49a057cc2e..89c0c4f901 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -297,7 +297,7 @@ test_expect_success 'verify notices chain slice which is bogus (base)' '
 		echo "garbage" >$base_file &&
 		test_must_fail git commit-graph verify 2>test_err &&
 		grep -v "^+" test_err >err &&
-		grep "commit-graph file is too small" err
+		test_grep "commit-graph file is too small" err
 	)
 '
 
@@ -310,7 +310,7 @@ test_expect_success 'verify notices chain slice which is bogus (tip)' '
 		echo "garbage" >$tip_file &&
 		test_must_fail git commit-graph verify 2>test_err &&
 		grep -v "^+" test_err >err &&
-		grep "commit-graph file is too small" err
+		test_grep "commit-graph file is too small" err
 	)
 '
 
@@ -379,7 +379,7 @@ test_expect_success 'verify notices too-short chain file' '
 		echo "garbage" >$graphdir/commit-graph-chain &&
 		test_must_fail git commit-graph verify 2>test_err &&
 		grep -v "^+" test_err >err &&
-		grep "commit-graph chain file too small" err
+		test_grep "commit-graph chain file too small" err
 	)
 '
 
@@ -410,7 +410,7 @@ test_expect_success PERL_TEST_HELPERS 'reader bounds-checks base-graph chunk' '
 		git -c core.commitGraph=false log >expect.out &&
 		git -c core.commitGraph=true log >out 2>err &&
 		test_cmp expect.out out &&
-		grep "commit-graph base graphs chunk is too small" err
+		test_grep "commit-graph base graphs chunk is too small" err
 	)
 '
 
@@ -421,7 +421,7 @@ test_expect_success 'add octopus merge' '
 	git commit-graph write --reachable --split &&
 	git commit-graph verify --progress 2>err &&
 	test_line_count = 1 err &&
-	grep "Verifying commits in commit graph: 100% (18/18)" err &&
+	test_grep "Verifying commits in commit graph: 100% (18/18)" err &&
 	test_grep ! warning err &&
 	test_line_count = 3 $graphdir/commit-graph-chain
 '
diff --git a/t/t5325-reverse-index.sh b/t/t5325-reverse-index.sh
index 285c8b4a49..5493791938 100755
--- a/t/t5325-reverse-index.sh
+++ b/t/t5325-reverse-index.sh
@@ -65,7 +65,7 @@ test_expect_success 'index-pack can verify reverse indexes' '
 
 	test_must_fail git index-pack --rev-index --verify \
 		$packdir/pack-$pack.pack 2>err &&
-	grep "validation error" err
+	test_grep "validation error" err
 '
 
 test_expect_success 'index-pack infers reverse index name with -o' '
diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index 62bd973d92..86beab1dae 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -121,7 +121,7 @@ test_midx_bitmap_cases () {
 			EOF
 
 			test_must_fail git multi-pack-index write --bitmap 2>err &&
-			grep "doesn.t have full closure" err &&
+			test_grep "doesn.t have full closure" err &&
 			test_path_is_missing $midx
 		)
 	'
@@ -215,8 +215,8 @@ test_midx_bitmap_cases () {
 			test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
 
 			test-tool bitmap list-commits | sort >bitmaps &&
-			grep "$(git rev-parse one)" bitmaps &&
-			grep "$(git rev-parse two)" bitmaps &&
+			test_grep "$(git rev-parse one)" bitmaps &&
+			test_grep "$(git rev-parse two)" bitmaps &&
 
 			rm -fr $midx-$(midx_checksum $objdir).bitmap &&
 			rm -fr $midx &&
@@ -229,8 +229,8 @@ test_midx_bitmap_cases () {
 			test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
 
 			test-tool bitmap list-commits | sort >bitmaps &&
-			grep "$(git rev-parse one)" bitmaps &&
-			! grep "$(git rev-parse two)" bitmaps
+			test_grep "$(git rev-parse one)" bitmaps &&
+			test_grep ! "$(git rev-parse two)" bitmaps
 		)
 	'
 
@@ -258,7 +258,7 @@ test_midx_bitmap_cases () {
 			test_line_count = 1 before &&
 
 			(
-				grep -vf before commits.raw &&
+				grep -vf before commits.raw && # lint-ok: data filter
 				# mark missing commits as preferred
 				sed "s/^/+/" before
 			) >snapshot &&
@@ -321,7 +321,7 @@ test_midx_bitmap_cases () {
 			git multi-pack-index write --bitmap --stdin-packs \
 				<packs 2>err &&
 
-			grep "bitmap without any objects" err &&
+			test_grep "bitmap without any objects" err &&
 
 			test_path_is_file $midx &&
 			test_path_is_missing $midx-$(midx_checksum $objdir).bitmap
@@ -344,7 +344,7 @@ test_midx_bitmap_cases () {
 
 			GIT_TEST_MIDX_READ_RIDX=0 \
 				git rev-list --use-bitmap-index HEAD 2>err &&
-			! grep "ignoring extra bitmap file" err
+			test_grep ! "ignoring extra bitmap file" err
 		)
 	'
 }
@@ -364,7 +364,7 @@ test_expect_success 'multi-pack-index write writes lookup table if enabled' '
 		git repack -ad &&
 		GIT_TRACE2_EVENT="$(pwd)/trace" \
 			git multi-pack-index write --bitmap &&
-		grep "\"label\":\"writing_lookup_table\"" trace
+		test_grep "\"label\":\"writing_lookup_table\"" trace
 	)
 '
 
@@ -432,7 +432,7 @@ test_expect_success 'tagged commits are selected for bitmapping' '
 
 		git rev-parse HEAD >want &&
 		test-tool bitmap list-commits >actual &&
-		grep $(cat want) actual
+		test_grep $(cat want) actual
 	)
 '
 
@@ -488,17 +488,17 @@ test_expect_success 'git fsck correctly identifies good and bad bitmaps' '
 
 	corrupt_file "$packbitmap" &&
 	test_must_fail git fsck 2>err &&
-	grep "bitmap file '\''$packbitmap'\'' has invalid checksum" err &&
+	test_grep "bitmap file '\''$packbitmap'\'' has invalid checksum" err &&
 
 	cp "$packbitmap.bak" "$packbitmap" &&
 	corrupt_file "$midxbitmap" &&
 	test_must_fail git fsck 2>err &&
-	grep "bitmap file '\''$midxbitmap'\'' has invalid checksum" err &&
+	test_grep "bitmap file '\''$midxbitmap'\'' has invalid checksum" err &&
 
 	corrupt_file "$packbitmap" &&
 	test_must_fail git fsck 2>err &&
-	grep "bitmap file '\''$midxbitmap'\'' has invalid checksum" err &&
-	grep "bitmap file '\''$packbitmap'\'' has invalid checksum" err
+	test_grep "bitmap file '\''$midxbitmap'\'' has invalid checksum" err &&
+	test_grep "bitmap file '\''$packbitmap'\'' has invalid checksum" err
 '
 
 test_expect_success 'corrupt MIDX with bitmap causes fallback' '
diff --git a/t/t5328-commit-graph-64bit-time.sh b/t/t5328-commit-graph-64bit-time.sh
index bc651b69de..0919417605 100755
--- a/t/t5328-commit-graph-64bit-time.sh
+++ b/t/t5328-commit-graph-64bit-time.sh
@@ -89,7 +89,7 @@ test_expect_success PERL_TEST_HELPERS 'reader notices out-of-bounds generation o
 	git commit-graph write --reachable &&
 	corrupt_chunk_file $graph GDO2 clear &&
 	test_must_fail git log 2>err &&
-	grep "commit-graph overflow generation data is too small" err
+	test_grep "commit-graph overflow generation data is too small" err
 '
 
 test_done
diff --git a/t/t5329-pack-objects-cruft.sh b/t/t5329-pack-objects-cruft.sh
index 25ddda5cf3..12cda06373 100755
--- a/t/t5329-pack-objects-cruft.sh
+++ b/t/t5329-pack-objects-cruft.sh
@@ -468,8 +468,8 @@ test_expect_success 'cruft --local drops unreachable objects' '
 
 		test-tool pack-mtimes "$(basename $(ls $packdir/pack-*.mtimes))" \
 		       >objects &&
-		! grep $object objects &&
-		grep $cruft objects
+		test_grep ! $object objects &&
+		test_grep $cruft objects
 	)
 '
 
@@ -515,7 +515,7 @@ test_expect_success 'cruft objects are freshend via loose' '
 
 		test_path_is_missing "$loose" &&
 		test-tool pack-mtimes "$(basename "$(ls $packdir/pack-*.mtimes)")" >cruft &&
-		grep "$blob" cruft &&
+		test_grep "$blob" cruft &&
 
 		# write the same object again
 		git hash-object -w -t blob contents &&
@@ -657,7 +657,7 @@ test_expect_success 'multi-valued gc.recentObjectsHook' '
 		# ensure that a dirty exit halts cruft pack generation
 		git config --add gc.recentObjectsHook ./extra-tips.c &&
 		test_must_fail git repack --cruft --cruft-expiration=now -d 2>err &&
-		grep "unable to enumerate additional recent objects" err &&
+		test_grep "unable to enumerate additional recent objects" err &&
 
 		# and that the existing cruft pack is left alone
 		test_path_is_file "$mtimes"
diff --git a/t/t5334-incremental-multi-pack-index.sh b/t/t5334-incremental-multi-pack-index.sh
index 68a103d13d..f0b82b5f65 100755
--- a/t/t5334-incremental-multi-pack-index.sh
+++ b/t/t5334-incremental-multi-pack-index.sh
@@ -29,7 +29,7 @@ test_expect_success 'convert non-incremental MIDX to incremental' '
 	test_path_is_missing $packdir/multi-pack-index &&
 	test_path_is_file $midx_chain &&
 	test_line_count = 2 $midx_chain &&
-	grep $old_hash $midx_chain
+	test_grep $old_hash $midx_chain
 '
 
 compare_results_with_midx 'incremental MIDX'
diff --git a/t/t5335-compact-multi-pack-index.sh b/t/t5335-compact-multi-pack-index.sh
index ec1dafe89f..0f75ef2ccc 100755
--- a/t/t5335-compact-multi-pack-index.sh
+++ b/t/t5335-compact-multi-pack-index.sh
@@ -321,8 +321,8 @@ test_expect_success 'MIDX compaction with --no-write-chain-file' '
 		} >$midx_chain &&
 
 		test-tool read-midx $objdir $layer >midx.data &&
-		grep "^pack-B-.*\.idx" midx.data &&
-		grep "^pack-C-.*\.idx" midx.data
+		test_grep "^pack-B-.*\.idx" midx.data &&
+		test_grep "^pack-C-.*\.idx" midx.data
 
 	)
 '
diff --git a/t/t5351-unpack-large-objects.sh b/t/t5351-unpack-large-objects.sh
index d76eb4be93..7f621c5331 100755
--- a/t/t5351-unpack-large-objects.sh
+++ b/t/t5351-unpack-large-objects.sh
@@ -32,7 +32,7 @@ test_expect_success 'set memory limitation to 1MB' '
 test_expect_success 'unpack-objects failed under memory limitation' '
 	prepare_dest 2m &&
 	test_must_fail git -C dest.git unpack-objects <pack-$PACK.pack 2>err &&
-	grep "fatal: attempting to allocate" err
+	test_grep "fatal: attempting to allocate" err
 '
 
 test_expect_success 'unpack-objects works with memory limitation in dry-run mode' '
diff --git a/t/t5402-post-merge-hook.sh b/t/t5402-post-merge-hook.sh
index 915af2de95..c77aa56421 100755
--- a/t/t5402-post-merge-hook.sh
+++ b/t/t5402-post-merge-hook.sh
@@ -46,7 +46,7 @@ test_expect_success 'post-merge runs as expected ' '
 '
 
 test_expect_success 'post-merge from normal merge receives the right argument ' '
-	grep 0 clone1/.git/post-merge.args
+	test_grep 0 clone1/.git/post-merge.args
 '
 
 test_expect_success 'post-merge from squash merge runs as expected ' '
@@ -55,7 +55,7 @@ test_expect_success 'post-merge from squash merge runs as expected ' '
 '
 
 test_expect_success 'post-merge from squash merge receives the right argument ' '
-	grep 1 clone2/.git/post-merge.args
+	test_grep 1 clone2/.git/post-merge.args
 '
 
 test_done
diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
index cb0300b2d2..39009ce327 100755
--- a/t/t5403-post-checkout-hook.sh
+++ b/t/t5403-post-checkout-hook.sh
@@ -100,7 +100,7 @@ test_rebase () {
 		echo untracked >three.t &&
 		test_when_finished "rm three.t" &&
 		test_must_fail git rebase $args HEAD rebase-fast-forward 2>err &&
-		grep "untracked working tree files would be overwritten by checkout" err &&
+		test_grep "untracked working tree files would be overwritten by checkout" err &&
 		test_path_is_missing .git/post-checkout.args
 
 '
diff --git a/t/t5404-tracking-branches.sh b/t/t5404-tracking-branches.sh
index cc07889667..a1661d34f2 100755
--- a/t/t5404-tracking-branches.sh
+++ b/t/t5404-tracking-branches.sh
@@ -59,7 +59,7 @@ test_expect_success 'deleted branches have their tracking branches removed' '
 test_expect_success 'already deleted tracking branches ignored' '
 	git branch -d -r origin/b3 &&
 	git push origin :b3 >output 2>&1 &&
-	! grep "^error: " output
+	test_grep ! "^error: " output
 '
 
 test_done
diff --git a/t/t5406-remote-rejects.sh b/t/t5406-remote-rejects.sh
index dcbeb42082..bb293b7010 100755
--- a/t/t5406-remote-rejects.sh
+++ b/t/t5406-remote-rejects.sh
@@ -19,6 +19,6 @@ test_expect_success 'setup' '
 
 test_expect_success 'push reports error' 'test_must_fail git push 2>stderr'
 
-test_expect_success 'individual ref reports error' 'grep rejected stderr'
+test_expect_success 'individual ref reports error' 'test_grep rejected stderr'
 
 test_done
diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
index ad7f8c6f00..ed9896e27a 100755
--- a/t/t5407-post-rewrite-hook.sh
+++ b/t/t5407-post-rewrite-hook.sh
@@ -195,19 +195,19 @@ test_expect_success 'git rebase with failed pick' '
 		set_replace_editor todo &&
 		test_must_fail git rebase -i D D 2>err
 	) &&
-	grep "would be overwritten" err &&
+	test_grep "would be overwritten" err &&
 	rm bar &&
 
 	test_must_fail git rebase --continue 2>err &&
-	grep "would be overwritten" err &&
+	test_grep "would be overwritten" err &&
 	rm G &&
 
 	test_must_fail git rebase --continue 2>err &&
-	grep "would be overwritten" err &&
+	test_grep "would be overwritten" err &&
 	rm H &&
 
 	test_must_fail git rebase --continue 2>err &&
-	grep "would be overwritten" err &&
+	test_grep "would be overwritten" err &&
 	rm I &&
 
 	git rebase --continue &&
diff --git a/t/t5409-colorize-remote-messages.sh b/t/t5409-colorize-remote-messages.sh
index 3010913bb1..5da8b0ad64 100755
--- a/t/t5409-colorize-remote-messages.sh
+++ b/t/t5409-colorize-remote-messages.sh
@@ -32,70 +32,70 @@ test_expect_success 'setup' '
 test_expect_success 'keywords' '
 	git --git-dir child/.git -c color.remote=always push -f origin HEAD:refs/heads/keywords 2>output &&
 	test_decode_color <output >decoded &&
-	grep "<BOLD;RED>error<RESET>: error" decoded &&
-	grep "<YELLOW>hint<RESET>:" decoded &&
-	grep "<BOLD;GREEN>success<RESET>:" decoded &&
-	grep "<BOLD;GREEN>SUCCESS<RESET>" decoded &&
-	grep "<BOLD;YELLOW>warning<RESET>:" decoded
+	test_grep "<BOLD;RED>error<RESET>: error" decoded &&
+	test_grep "<YELLOW>hint<RESET>:" decoded &&
+	test_grep "<BOLD;GREEN>success<RESET>:" decoded &&
+	test_grep "<BOLD;GREEN>SUCCESS<RESET>" decoded &&
+	test_grep "<BOLD;YELLOW>warning<RESET>:" decoded
 '
 
 test_expect_success 'whole words at line start' '
 	git --git-dir child/.git -c color.remote=always push -f origin HEAD:refs/heads/whole-words 2>output &&
 	test_decode_color <output >decoded &&
-	grep "<YELLOW>hint<RESET>:" decoded &&
-	grep "hinting: not highlighted" decoded &&
-	grep "prefixerror: error" decoded
+	test_grep "<YELLOW>hint<RESET>:" decoded &&
+	test_grep "hinting: not highlighted" decoded &&
+	test_grep "prefixerror: error" decoded
 '
 
 test_expect_success 'short line' '
 	git -C child -c color.remote=always push -f origin HEAD:short-line 2>output &&
 	test_decode_color <output >decoded &&
-	grep "remote: Err" decoded
+	test_grep "remote: Err" decoded
 '
 
 test_expect_success 'case-insensitive' '
 	git --git-dir child/.git -c color.remote=always push -f origin HEAD:refs/heads/case-insensitive 2>output &&
 	test_decode_color <output >decoded &&
-	grep "<BOLD;RED>error<RESET>: error" decoded &&
-	grep "<BOLD;RED>ERROR<RESET>: also highlighted" decoded
+	test_grep "<BOLD;RED>error<RESET>: error" decoded &&
+	test_grep "<BOLD;RED>ERROR<RESET>: also highlighted" decoded
 '
 
 test_expect_success 'leading space' '
 	git --git-dir child/.git -c color.remote=always push -f origin HEAD:refs/heads/leading-space 2>output &&
 	test_decode_color <output >decoded &&
-	grep "  <BOLD;RED>error<RESET>: leading space" decoded
+	test_grep "  <BOLD;RED>error<RESET>: leading space" decoded
 '
 
 test_expect_success 'spaces only' '
 	git -C child -c color.remote=always push -f origin HEAD:only-space 2>output &&
 	test_decode_color <output >decoded &&
-	grep "remote:     " decoded
+	test_grep "remote:     " decoded
 '
 
 test_expect_success 'no coloring for redirected output' '
 	git --git-dir child/.git push -f origin HEAD:refs/heads/redirected-output 2>output &&
 	test_decode_color <output >decoded &&
-	grep "error: error" decoded
+	test_grep "error: error" decoded
 '
 
 test_expect_success 'push with customized color' '
 	git --git-dir child/.git -c color.remote=always -c color.remote.error=blue push -f origin HEAD:refs/heads/customized-color 2>output &&
 	test_decode_color <output >decoded &&
-	grep "<BLUE>error<RESET>:" decoded &&
-	grep "<BOLD;GREEN>success<RESET>:" decoded
+	test_grep "<BLUE>error<RESET>:" decoded &&
+	test_grep "<BOLD;GREEN>success<RESET>:" decoded
 '
 
 
 test_expect_success 'error in customized color' '
 	git --git-dir child/.git -c color.remote=always -c color.remote.error=i-am-not-a-color push -f origin HEAD:refs/heads/error-customized-color 2>output &&
 	test_decode_color <output >decoded &&
-	grep "<BOLD;GREEN>success<RESET>:" decoded
+	test_grep "<BOLD;GREEN>success<RESET>:" decoded
 '
 
 test_expect_success 'fallback to color.ui' '
 	git --git-dir child/.git -c color.ui=always push -f origin HEAD:refs/heads/fallback-color-ui 2>output &&
 	test_decode_color <output >decoded &&
-	grep "<BOLD;RED>error<RESET>: error" decoded
+	test_grep "<BOLD;RED>error<RESET>: error" decoded
 '
 
 test_expect_success 'disallow (color) control sequences in sideband' '
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 649a615ec9..6c1edf2117 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -135,15 +135,15 @@ test_expect_success 'single given branch clone' '
 	GIT_TRACE2_EVENT="$(pwd)/branch-a/trace2_event" \
 		git clone --single-branch --branch A "file://$(pwd)/." branch-a &&
 	test_must_fail git --git-dir=branch-a/.git rev-parse origin/B &&
-	grep \"fetch-info\".*\"haves\":0 branch-a/trace2_event &&
-	grep \"fetch-info\".*\"wants\":1 branch-a/trace2_event
+	test_grep \"fetch-info\".*\"haves\":0 branch-a/trace2_event &&
+	test_grep \"fetch-info\".*\"wants\":1 branch-a/trace2_event
 '
 
 test_expect_success 'clone shallow depth 1' '
 	GIT_TRACE2_EVENT="$(pwd)/shallow0/trace2_event" \
 		git clone --no-single-branch --depth 1 "file://$(pwd)/." shallow0 &&
 	test "$(git --git-dir=shallow0/.git rev-list --count HEAD)" = 1 &&
-	grep \"fetch-info\".*\"depth\":1 shallow0/trace2_event
+	test_grep \"fetch-info\".*\"depth\":1 shallow0/trace2_event
 '
 
 test_expect_success 'clone shallow depth 1 with fsck' '
@@ -167,7 +167,7 @@ test_expect_success 'clone shallow object count' '
 		cd shallow &&
 		git count-objects -v
 	) > count.shallow &&
-	grep "^in-pack: 12" count.shallow
+	test_grep "^in-pack: 12" count.shallow
 '
 
 test_expect_success 'clone shallow object count (part 2)' '
@@ -230,7 +230,7 @@ test_expect_success 'clone shallow object count' '
 		cd shallow &&
 		git count-objects -v
 	) > count.shallow &&
-	grep "^count: 6" count.shallow
+	test_grep "^count: 6" count.shallow
 '
 
 test_expect_success 'add two more (part 2)' '
@@ -243,8 +243,8 @@ test_expect_success 'deepening pull in shallow repo' '
 		cd shallow &&
 		GIT_TRACE2_EVENT="$(pwd)/trace2_event" \
 			git pull --depth 4 .. B &&
-		grep \"fetch-info\".*\"depth\":4 trace2_event &&
-		grep \"fetch-info\".*\"shallows\":2 trace2_event
+		test_grep \"fetch-info\".*\"depth\":4 trace2_event &&
+		test_grep \"fetch-info\".*\"shallows\":2 trace2_event
 	)
 '
 
@@ -253,7 +253,7 @@ test_expect_success 'clone shallow object count' '
 		cd shallow &&
 		git count-objects -v
 	) > count.shallow &&
-	grep "^count: 12" count.shallow
+	test_grep "^count: 12" count.shallow
 '
 
 test_expect_success 'deepening fetch in shallow repo' '
@@ -268,7 +268,7 @@ test_expect_success 'clone shallow object count' '
 		cd shallow &&
 		git count-objects -v
 	) > count.shallow &&
-	grep "^count: 18" count.shallow
+	test_grep "^count: 18" count.shallow
 '
 
 test_expect_success 'pull in shallow repo with missing merge base' '
@@ -298,7 +298,7 @@ test_expect_success 'clone shallow object count' '
 		git prune &&
 		git count-objects -v
 	) > count.shallow &&
-	grep "^count: 54" count.shallow
+	test_grep "^count: 54" count.shallow
 '
 
 test_expect_success 'fetch --no-shallow on full repo' '
@@ -319,8 +319,8 @@ test_expect_success 'turn shallow to complete repository' '
 			git fetch --unshallow &&
 		! test -f .git/shallow &&
 		git fsck --full &&
-		grep \"fetch-info\".*\"shallows\":2 trace2_event &&
-		grep \"fetch-info\".*\"depth\":2147483647 trace2_event
+		test_grep \"fetch-info\".*\"shallows\":2 trace2_event &&
+		test_grep \"fetch-info\".*\"depth\":2147483647 trace2_event
 	)
 '
 
@@ -333,7 +333,7 @@ test_expect_success 'clone shallow object count' '
 		cd shallow2 &&
 		git count-objects -v
 	) > count.shallow2 &&
-	grep "^in-pack: 3" count.shallow2
+	test_grep "^in-pack: 3" count.shallow2
 '
 
 test_expect_success 'clone shallow with --branch' '
@@ -446,7 +446,7 @@ test_expect_success 'in_vain reset upon ACK' '
 	# and should reset in_vain. This allows negotiation to continue until
 	# the client reports that first_anotherbranch_commit is common.
 	GIT_TRACE2_EVENT="$(pwd)/trace2" git -C myclient fetch --progress origin main 2>log &&
-	grep \"key\":\"total_rounds\",\"value\":\"6\" trace2 &&
+	test_grep \"key\":\"total_rounds\",\"value\":\"6\" trace2 &&
 	test_grep "Total 3 " log
 '
 
@@ -852,7 +852,7 @@ test_expect_success 'fetch shallow since ...' '
 	two
 	EOF
 	test_cmp expected actual &&
-	grep \"fetch-info\".*\"deepen-since\":true shallow11/trace2_event
+	test_grep \"fetch-info\".*\"deepen-since\":true shallow11/trace2_event
 '
 
 test_expect_success 'clone shallow since selects no commits' '
@@ -935,7 +935,7 @@ test_expect_success 'fetch exclude tag one as revision' '
 	test_when_finished rm -f rev err &&
 	git -C shallow-exclude rev-parse one >rev &&
 	test_must_fail git -C shallow12 fetch --shallow-exclude $(cat rev) origin 2>err &&
-	grep "deepen-not is not a ref:" err
+	test_grep "deepen-not is not a ref:" err
 '
 
 test_expect_success 'fetching deepen' '
@@ -1059,9 +1059,9 @@ test_expect_success 'filtering by size' '
 	commit=$(git -C server rev-parse HEAD) &&
 	blob=$(git hash-object server/one.t) &&
 	git -C client rev-list --objects --missing=allow-any "$commit" >oids &&
-	! grep "$blob" oids &&
+	test_grep ! "$blob" oids &&
 
-	grep \"fetch-info\".*\"filter\":\"blob:limit\" client/trace2_event
+	test_grep \"fetch-info\".*\"filter\":\"blob:limit\" client/trace2_event
 '
 
 test_expect_success 'filtering by size has no effect if support for it is not advertised' '
@@ -1076,7 +1076,7 @@ test_expect_success 'filtering by size has no effect if support for it is not ad
 	commit=$(git -C server rev-parse HEAD) &&
 	blob=$(git hash-object server/one.t) &&
 	git -C client rev-list --objects --missing=allow-any "$commit" >oids &&
-	grep "$blob" oids &&
+	test_grep "$blob" oids &&
 
 	test_grep "filtering not recognized by server" err
 '
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 438250c75e..75b2b87999 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -298,13 +298,13 @@ test_expect_success 'push with receive.fsck.missingEmail=warn' '
 	git --git-dir=dst/.git config \
 		receive.fsck.missingEmail warn &&
 	git push --porcelain dst bogus >act 2>&1 &&
-	grep "missingEmail" act &&
+	test_grep "missingEmail" act &&
 	test_grep "skipping unknown msg id.*whatever" act &&
 	git --git-dir=dst/.git branch -D bogus &&
 	git --git-dir=dst/.git config --add \
 		receive.fsck.missingEmail ignore &&
 	git push --porcelain dst bogus >act 2>&1 &&
-	! grep "missingEmail" act
+	test_grep ! "missingEmail" act
 '
 
 test_expect_success 'fetch with fetch.fsck.missingEmail=warn' '
@@ -326,7 +326,7 @@ test_expect_success 'fetch with fetch.fsck.missingEmail=warn' '
 	git --git-dir=dst/.git config \
 		fetch.fsck.missingEmail warn &&
 	git --git-dir=dst/.git fetch "file://$(pwd)" $refspec >act 2>&1 &&
-	grep "missingEmail" act &&
+	test_grep "missingEmail" act &&
 	test_grep "Skipping unknown msg id.*whatever" act &&
 	rm -rf dst &&
 	git init dst &&
@@ -334,7 +334,7 @@ test_expect_success 'fetch with fetch.fsck.missingEmail=warn' '
 	git --git-dir=dst/.git config \
 		fetch.fsck.missingEmail ignore &&
 	git --git-dir=dst/.git fetch "file://$(pwd)" $refspec >act 2>&1 &&
-	! grep "missingEmail" act
+	test_grep ! "missingEmail" act
 '
 
 test_expect_success \
@@ -345,7 +345,7 @@ test_expect_success \
 	git --git-dir=dst/.git config \
 		receive.fsck.unterminatedheader warn &&
 	test_must_fail git push --porcelain dst HEAD >act 2>&1 &&
-	grep "Cannot demote unterminatedheader" act
+	test_grep "Cannot demote unterminatedheader" act
 '
 
 test_expect_success \
@@ -356,7 +356,7 @@ test_expect_success \
 	git --git-dir=dst/.git config \
 		fetch.fsck.unterminatedheader warn &&
 	test_must_fail git --git-dir=dst/.git fetch "file://$(pwd)" HEAD &&
-	grep "Cannot demote unterminatedheader" act
+	test_grep "Cannot demote unterminatedheader" act
 '
 
 test_expect_success PERL_TEST_HELPERS 'badFilemode is not a strict error' '
@@ -373,7 +373,7 @@ test_expect_success PERL_TEST_HELPERS 'badFilemode is not a strict error' '
 	git -C dst.git config transfer.fsckObjects true &&
 
 	git -C badmode.git push ../dst.git $tree:refs/tags/tree 2>err &&
-	grep "$tree: badFilemode" err
+	test_grep "$tree: badFilemode" err
 '
 
 test_done
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index e592c0bcde..6f5e86dede 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -91,28 +91,28 @@ test_expect_success 'filters for promisor remotes are listed by git remote -v' '
 	test_when_finished "rm -rf pc" &&
 	git clone --filter=blob:none "file://$(pwd)/srv.bare" pc &&
 	git -C pc remote -v >out &&
-	grep "srv.bare (fetch) \[blob:none\]" out &&
+	test_grep "srv.bare (fetch) \[blob:none\]" out &&
 
 	git -C pc config remote.origin.partialCloneFilter object:type=commit &&
 	git -C pc remote -v >out &&
-	grep "srv.bare (fetch) \[object:type=commit\]" out
+	test_grep "srv.bare (fetch) \[object:type=commit\]" out
 '
 
 test_expect_success 'filters should not be listed for non promisor remotes (remote -v)' '
 	test_when_finished "rm -rf pc" &&
 	git clone one pc &&
 	git -C pc remote -v >out &&
-	! grep "(fetch) \[.*\]" out
+	test_grep ! "(fetch) \[.*\]" out
 '
 
 test_expect_success 'filters are listed by git remote -v only' '
 	test_when_finished "rm -rf pc" &&
 	git clone --filter=blob:none "file://$(pwd)/srv.bare" pc &&
 	git -C pc remote >out &&
-	! grep "\[blob:none\]" out &&
+	test_grep ! "\[blob:none\]" out &&
 
 	git -C pc remote show >out &&
-	! grep "\[blob:none\]" out
+	test_grep ! "\[blob:none\]" out
 '
 
 test_expect_success 'check remote-tracking' '
@@ -261,7 +261,7 @@ test_expect_success 'without subcommand accepts -v' '
 
 test_expect_success 'without subcommand does not take arguments' '
 	test_expect_code 129 git -C test remote origin 2>err &&
-	grep "^error: unknown subcommand:" err
+	test_grep "^error: unknown subcommand:" err
 '
 
 cat >test/expect <<EOF
@@ -798,7 +798,7 @@ test_expect_success 'add --no-tags' '
 		cd add-no-tags &&
 		git init &&
 		git remote add -f --no-tags origin ../one &&
-		grep tagOpt .git/config &&
+		test_grep tagOpt .git/config &&
 		git tag -l some-tag >../test/output &&
 		git tag -l foobar-tag >../test/output &&
 		git config remote.origin.tagopt >>../test/output
@@ -972,7 +972,7 @@ test_expect_success 'rename a remote' '
 		GIT_TRACE2_EVENT=$(pwd)/trace \
 			git remote rename --progress origin upstream &&
 		test_region progress "Renaming remote references" trace &&
-		grep "pushRemote" .git/config &&
+		test_grep "pushRemote" .git/config &&
 		test -z "$(git for-each-ref refs/remotes/origin)" &&
 		test "$(git symbolic-ref refs/remotes/upstream/HEAD)" = "refs/remotes/upstream/main" &&
 		test "$(git rev-parse upstream/main)" = "$(git rev-parse main)" &&
@@ -989,7 +989,7 @@ test_expect_success 'rename a remote renames repo remote.pushDefault' '
 		cd four.1 &&
 		git config remote.pushDefault origin &&
 		git remote rename origin upstream &&
-		grep pushDefault .git/config &&
+		test_grep pushDefault .git/config &&
 		test "$(git config --local remote.pushDefault)" = "upstream"
 	)
 '
@@ -1198,7 +1198,7 @@ test_expect_success 'remote prune to cause a dangling symref' '
 		cd eight &&
 		git branch -a
 	) 2>err &&
-	! grep "points nowhere" err &&
+	test_grep ! "points nowhere" err &&
 	(
 		cd eight &&
 		test_must_fail git branch nomore origin
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index eca9a973b5..a0bbbce0f7 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -750,7 +750,7 @@ test_expect_success 'fetch from GIT URL with a non-applying branch.<name>.merge
 # the strange name is: a\!'b
 test_expect_success 'quoting of a strangely named repo' '
 	test_must_fail git fetch "a\\!'\''b" > result 2>&1 &&
-	grep "fatal: '\''a\\\\!'\''b'\''" result
+	test_grep "fatal: '\''a\\\\!'\''b'\''" result
 '
 
 test_expect_success 'bundle should record HEAD correctly' '
@@ -904,14 +904,14 @@ test_expect_success 'fetch --dry-run does not touch FETCH_HEAD, but still prints
 	rm -f .git/FETCH_HEAD err &&
 	git fetch --dry-run . 2>err &&
 	! test -f .git/FETCH_HEAD &&
-	grep FETCH_HEAD err
+	test_grep FETCH_HEAD err
 '
 
 test_expect_success '--no-write-fetch-head does not touch FETCH_HEAD, and does not print what would be written' '
 	rm -f .git/FETCH_HEAD err &&
 	git fetch --no-write-fetch-head . 2>err &&
 	! test -f .git/FETCH_HEAD &&
-	! grep FETCH_HEAD err
+	test_grep ! FETCH_HEAD err
 '
 
 test_expect_success '--write-fetch-head gets defeated by --dry-run' '
@@ -1329,7 +1329,7 @@ test_expect_success 'fetching with auto-gc does not lock up' '
 		git config maintenance.strategy gc &&
 		GIT_ASK_YESNO="$TRASH_DIRECTORY/askyesno" git fetch --verbose >fetch.out 2>&1 &&
 		test_grep "Auto packing the repository" fetch.out &&
-		! grep "Should I try again" fetch.out
+		test_grep ! "Should I try again" fetch.out
 	)
 '
 
@@ -1338,7 +1338,7 @@ do
 	test_expect_success "$section.hideRefs affects connectivity check" '
 		GIT_TRACE="$PWD"/trace git -c $section.hideRefs=refs -c \
 			$section.hideRefs="!refs/tags/" fetch &&
-		grep "git rev-list .*--exclude-hidden=fetch" trace
+		test_grep "git rev-list .*--exclude-hidden=fetch" trace
 	'
 done
 
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 5930f55186..fe44f39871 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -245,8 +245,8 @@ do
 		git config --add $configsection.hiderefs "!refs/tags/magic" &&
 		git config --add $configsection.hiderefs refs/tags/magic/one &&
 		git ls-remote . >actual &&
-		grep refs/tags/magic/two actual &&
-		! grep refs/tags/magic/one actual
+		test_grep refs/tags/magic/two actual &&
+		test_grep ! refs/tags/magic/one actual
 	'
 
 done
@@ -255,13 +255,13 @@ test_expect_success 'overrides work between mixed transfer/upload-pack hideRefs'
 	test_config uploadpack.hiderefs refs/tags &&
 	test_config transfer.hiderefs "!refs/tags/magic" &&
 	git ls-remote . >actual &&
-	grep refs/tags/magic actual
+	test_grep refs/tags/magic actual
 '
 
 test_expect_success 'protocol v2 supports hiderefs' '
 	test_config uploadpack.hiderefs refs/tags &&
 	git -c protocol.version=2 ls-remote . >actual &&
-	! grep refs/tags actual
+	test_grep ! refs/tags actual
 '
 
 test_expect_success 'ls-remote --symref' '
diff --git a/t/t5514-fetch-multiple.sh b/t/t5514-fetch-multiple.sh
index 523aff6268..5d79472c39 100755
--- a/t/t5514-fetch-multiple.sh
+++ b/t/t5514-fetch-multiple.sh
@@ -217,7 +217,7 @@ test_expect_success 'parallel' '
 
 	test_must_fail env GIT_TRACE="$PWD/trace" \
 		git fetch --jobs=2 --multiple one two 2>err &&
-	grep "preparing to run up to 2 tasks" trace &&
+	test_grep "preparing to run up to 2 tasks" trace &&
 	test_grep "could not fetch .one.*128" err &&
 	test_grep "could not fetch .two.*128" err
 '
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 1b986349a8..f3b3efc47f 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -124,7 +124,7 @@ do
 	do
 		test_expect_success "reject 'git $cmd --no-$opt'" '
 			test_must_fail git $cmd --no-$opt 2>err &&
-			grep "unknown option .no-$opt" err
+			test_grep "unknown option .no-$opt" err
 		'
 	done
 done
@@ -212,7 +212,7 @@ test_expect_success 'push with negotiation' '
 	GIT_TRACE2_EVENT="$(pwd)/event" \
 		git -c protocol.version=2 -c push.negotiate=1 \
 		push testrepo refs/heads/main:refs/remotes/origin/main &&
-	grep \"key\":\"total_rounds\",\"value\":\"1\" event &&
+	test_grep \"key\":\"total_rounds\",\"value\":\"1\" event &&
 	grep_wrote 2 event # 1 commit, 1 tree
 '
 
@@ -250,8 +250,8 @@ test_expect_success 'push with negotiation does not attempt to fetch submodules'
 	GIT_TRACE2_EVENT="$(pwd)/event"  git -c submodule.recurse=true \
 		-c protocol.version=2 -c push.negotiate=1 \
 		push testrepo refs/heads/main:refs/remotes/origin/main 2>err &&
-	grep \"key\":\"total_rounds\",\"value\":\"1\" event &&
-	! grep "Fetching submodule" err
+	test_grep \"key\":\"total_rounds\",\"value\":\"1\" event &&
+	test_grep ! "Fetching submodule" err
 '
 
 test_expect_success 'push with negotiation and remote.<name>.negotiationInclude' '
@@ -637,7 +637,7 @@ test_expect_success 'push rejects empty branch name entries' '
 	test_config branch.main.remote one &&
 	test_config branch.main.merge refs/heads/main &&
 	test_must_fail git push 2>err &&
-	grep "bad config variable .branch\.\." err
+	test_grep "bad config variable .branch\.\." err
 '
 
 test_expect_success 'push ignores "branch." config without subsection' '
@@ -923,7 +923,7 @@ test_expect_success 'warn on push to HEAD of non-bare repository' '
 		git config receive.denyCurrentBranch warn
 	) &&
 	git push testrepo main 2>stderr &&
-	grep "warning: updating the current branch" stderr
+	test_grep "warning: updating the current branch" stderr
 '
 
 test_expect_success 'deny push to HEAD of non-bare repository' '
@@ -945,7 +945,7 @@ test_expect_success 'allow push to HEAD of bare repository (bare)' '
 		git config core.bare true
 	) &&
 	git push testrepo main 2>stderr &&
-	! grep "warning: updating the current branch" stderr
+	test_grep ! "warning: updating the current branch" stderr
 '
 
 test_expect_success 'allow push to HEAD of non-bare repository (config)' '
@@ -956,7 +956,7 @@ test_expect_success 'allow push to HEAD of non-bare repository (config)' '
 		git config receive.denyCurrentBranch false
 	) &&
 	git push testrepo main 2>stderr &&
-	! grep "warning: updating the current branch" stderr
+	test_grep ! "warning: updating the current branch" stderr
 '
 
 test_expect_success !WITH_BREAKING_CHANGES 'fetch with branches' '
@@ -1068,7 +1068,7 @@ test_expect_success 'push into aliased refs (inconsistent)' '
 		git commit -a -m child2 &&
 		git branch bar &&
 		test_must_fail git push ../child1 foo bar 2>stderr &&
-		grep "refusing inconsistent update" stderr
+		test_grep "refusing inconsistent update" stderr
 	)
 '
 
@@ -1161,7 +1161,7 @@ test_expect_success 'push --porcelain' '
 test_expect_success 'push --porcelain bad url' '
 	mk_empty testrepo &&
 	test_must_fail git push >.git/bar --porcelain asdfasdfasd refs/heads/main:refs/remotes/origin/main &&
-	! grep -q Done .git/bar
+	test_grep ! -q Done .git/bar
 '
 
 test_expect_success 'push --porcelain rejected' '
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 0e0019347e..27f38ab3c8 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -356,8 +356,8 @@ test_expect_success '--rebase with rebase.autostash succeeds on ff' '
 	echo "dirty" >>dst/file &&
 	test_config -C dst rebase.autostash true &&
 	git -C dst pull --rebase >actual 2>&1 &&
-	grep -q "Fast-forward" actual &&
-	grep -q "Applied autostash." actual
+	test_grep -q "Fast-forward" actual &&
+	test_grep -q "Applied autostash." actual
 '
 
 test_expect_success '--rebase with conflicts shows advice' '
diff --git a/t/t5524-pull-msg.sh b/t/t5524-pull-msg.sh
index b2be3605f5..493156a2b8 100755
--- a/t/t5524-pull-msg.sh
+++ b/t/t5524-pull-msg.sh
@@ -31,7 +31,7 @@ test_expect_success pull '
 	git pull --no-rebase --log &&
 	git log -2 &&
 	git cat-file commit HEAD >result &&
-	grep Dollar result
+	test_grep Dollar result
 )
 '
 
@@ -44,8 +44,8 @@ test_expect_success '--log=1 limits shortlog length' '
 	git pull --no-rebase --log=1 &&
 	git log -3 &&
 	git cat-file commit HEAD >result &&
-	grep Dollar result &&
-	! grep "second commit" result
+	test_grep Dollar result &&
+	test_grep ! "second commit" result
 )
 '
 
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 1242ee9185..7b3b7359da 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -199,7 +199,7 @@ test_expect_success "fetch --recurse-submodules -j2 has the same output behaviou
 	) &&
 	test_must_be_empty actual.out &&
 	verify_fetch_result actual.err &&
-	grep "2 tasks" trace.out
+	test_grep "2 tasks" trace.out
 '
 
 test_expect_success "fetch alone only fetches superproject" '
@@ -723,25 +723,25 @@ test_expect_success 'fetching submodules respects parallel settings' '
 	(
 		cd downstream &&
 		GIT_TRACE=$(pwd)/trace.out git fetch &&
-		grep "1 tasks" trace.out &&
+		test_grep "1 tasks" trace.out &&
 		>trace.out &&
 
 		GIT_TRACE=$(pwd)/trace.out git fetch --jobs 7 &&
-		grep "7 tasks" trace.out &&
+		test_grep "7 tasks" trace.out &&
 		>trace.out &&
 
 		git config submodule.fetchJobs 8 &&
 		GIT_TRACE=$(pwd)/trace.out git fetch &&
-		grep "8 tasks" trace.out &&
+		test_grep "8 tasks" trace.out &&
 		>trace.out &&
 
 		GIT_TRACE=$(pwd)/trace.out git fetch --jobs 9 &&
-		grep "9 tasks" trace.out &&
+		test_grep "9 tasks" trace.out &&
 		>trace.out &&
 
 		GIT_TRACE=$(pwd)/trace.out git -c submodule.fetchJobs=0 fetch &&
-		grep "preparing to run up to [0-9]* tasks" trace.out &&
-		! grep "up to 0 tasks" trace.out &&
+		test_grep "preparing to run up to [0-9]* tasks" trace.out &&
+		test_grep ! "up to 0 tasks" trace.out &&
 		>trace.out
 	)
 '
@@ -1259,7 +1259,7 @@ test_expect_success "fetch --all with --no-recurse-submodules only fetches super
 		git config submodule.recurse true &&
 		git fetch --all --no-recurse-submodules 2>../fetch-log
 	) &&
-	! grep "Fetching submodule" fetch-log
+	test_grep ! "Fetching submodule" fetch-log
 '
 
 test_done
diff --git a/t/t5529-push-errors.sh b/t/t5529-push-errors.sh
index 80b06a0cd2..35b1f212a8 100755
--- a/t/t5529-push-errors.sh
+++ b/t/t5529-push-errors.sh
@@ -44,14 +44,14 @@ test_expect_success 'detect missing sha1 expressions early' '
 # 'builtin/push.c:set_refspecs()' and we want to test that regression.
 test_expect_success 'detect empty remote with existing local ref' '
 	test_must_fail git push "" main 2> stderr &&
-	grep "fatal: bad repository ${SQ}${SQ}" stderr
+	test_grep "fatal: bad repository ${SQ}${SQ}" stderr
 '
 
 # While similar to the previous test, here we want to ensure that
 # even targeted refspecs are handled.
 test_expect_success 'detect empty remote with targeted refspec' '
 	test_must_fail git push "" HEAD:refs/heads/main 2> stderr &&
-	grep "fatal: bad repository ${SQ}${SQ}" stderr
+	test_grep "fatal: bad repository ${SQ}${SQ}" stderr
 '
 
 test_expect_success 'detect ambiguous refs early' '
diff --git a/t/t5530-upload-pack-error.sh b/t/t5530-upload-pack-error.sh
index d40292cfb7..25d409fc94 100755
--- a/t/t5530-upload-pack-error.sh
+++ b/t/t5530-upload-pack-error.sh
@@ -44,16 +44,16 @@ test_expect_success 'upload-pack fails due to error in rev-list' '
 		$(($hexsz + 10)) $(git rev-parse HEAD) \
 		$(($hexsz + 12)) $(git rev-parse HEAD^) >input &&
 	test_must_fail git upload-pack . <input >/dev/null 2>output.err &&
-	grep "bad tree object" output.err
+	test_grep "bad tree object" output.err
 '
 
 test_expect_success 'upload-pack fails due to bad want (no object)' '
 	printf "%04xwant %s multi_ack_detailed\n00000009done\n0000" \
 		$(($hexsz + 29)) $(test_oid deadbeef) >input &&
 	test_must_fail git upload-pack . <input >output 2>output.err &&
-	grep "not our ref" output.err &&
-	grep "ERR" output &&
-	! grep multi_ack_detailed output.err
+	test_grep "not our ref" output.err &&
+	test_grep "ERR" output &&
+	test_grep ! multi_ack_detailed output.err
 '
 
 test_expect_success 'upload-pack fails due to bad want (not tip)' '
@@ -61,17 +61,17 @@ test_expect_success 'upload-pack fails due to bad want (not tip)' '
 	printf "%04xwant %s multi_ack_detailed\n00000009done\n0000" \
 		$(($hexsz + 29)) "$oid" >input &&
 	test_must_fail git upload-pack . <input >output 2>output.err &&
-	grep "not our ref" output.err &&
-	grep "ERR" output &&
-	! grep multi_ack_detailed output.err
+	test_grep "not our ref" output.err &&
+	test_grep "ERR" output &&
+	test_grep ! multi_ack_detailed output.err
 '
 
 test_expect_success 'upload-pack fails due to error in pack-objects enumeration' '
 	printf "%04xwant %s\n00000009done\n0000" \
 		$((hexsz + 10)) $(git rev-parse HEAD) >input &&
 	test_must_fail git upload-pack . <input >/dev/null 2>output.err &&
-	grep "bad tree object" output.err &&
-	grep "pack-objects died" output.err
+	test_grep "bad tree object" output.err &&
+	test_grep "pack-objects died" output.err
 '
 
 test_expect_success 'upload-pack tolerates EOF just after stateless client wants' '
diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
index 05debd1134..7d239dd31f 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -559,7 +559,7 @@ test_expect_success 'push with push.recurseSubmodules=only on superproject and t
 	test_must_fail git -C upstream rev-parse refs/heads/downstream-branch &&
 	git -C upstream/sub rev-parse refs/heads/downstream-branch &&
 	git -C upstream/sub/deepsub rev-parse refs/heads/downstream-branch &&
-	grep "recursing into submodule with push.recurseSubmodules=only; using on-demand instead" err
+	test_grep "recursing into submodule with push.recurseSubmodules=only; using on-demand instead" err
 '
 
 test_expect_success 'push propagating the remotes name to a submodule' '
diff --git a/t/t5532-fetch-proxy.sh b/t/t5532-fetch-proxy.sh
index 95d0f33b29..ccbca7c2f2 100755
--- a/t/t5532-fetch-proxy.sh
+++ b/t/t5532-fetch-proxy.sh
@@ -52,7 +52,7 @@ test_expect_success 'fetch through proxy works' '
 
 test_expect_success 'funny hostnames are rejected before running proxy' '
 	test_must_fail git fetch git://-remote/repo.git 2>stderr &&
-	! grep "proxying for" stderr
+	test_grep ! "proxying for" stderr
 '
 
 test_done
diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
index cba26a872d..2e14aecaa2 100755
--- a/t/t5533-push-cas.sh
+++ b/t/t5533-push-cas.sh
@@ -69,7 +69,7 @@ test_expect_success 'push to update (protected)' '
 		cd dst &&
 		test_commit D &&
 		test_must_fail git push --force-with-lease=main:main origin main 2>err &&
-		grep "stale info" err
+		test_grep "stale info" err
 	) &&
 	git ls-remote . refs/heads/main >expect &&
 	git ls-remote src refs/heads/main >actual &&
@@ -82,7 +82,7 @@ test_expect_success 'push to update (protected, forced)' '
 		cd dst &&
 		test_commit D &&
 		git push --force --force-with-lease=main:main origin main 2>err &&
-		grep "forced update" err
+		test_grep "forced update" err
 	) &&
 	git ls-remote dst refs/heads/main >expect &&
 	git ls-remote src refs/heads/main >actual &&
@@ -147,7 +147,7 @@ test_expect_success 'push to update (allowed, tracking)' '
 		cd dst &&
 		test_commit D &&
 		git push --force-with-lease=main origin main 2>err &&
-		! grep "forced update" err
+		test_grep ! "forced update" err
 	) &&
 	git ls-remote dst refs/heads/main >expect &&
 	git ls-remote src refs/heads/main >actual &&
@@ -161,7 +161,7 @@ test_expect_success 'push to update (allowed even though no-ff)' '
 		git reset --hard HEAD^ &&
 		test_commit D &&
 		git push --force-with-lease=main origin main 2>err &&
-		grep "forced update" err
+		test_grep "forced update" err
 	) &&
 	git ls-remote dst refs/heads/main >expect &&
 	git ls-remote src refs/heads/main >actual &&
@@ -194,7 +194,7 @@ test_expect_success 'push to delete (allowed)' '
 	(
 		cd dst &&
 		git push --force-with-lease=main origin :main 2>err &&
-		grep deleted err
+		test_grep deleted err
 	) &&
 	git ls-remote src refs/heads/main >actual &&
 	test_must_be_empty actual
@@ -350,7 +350,7 @@ test_expect_success '"--force-if-includes" should be disabled for --force-with-l
 		remote_head="$(git rev-parse refs/remotes/origin/main)" &&
 		git fetch --all &&
 		test_must_fail git push --force-if-includes --force-with-lease="main:$remote_head" 2>err &&
-		grep "stale info" err
+		test_grep "stale info" err
 	) &&
 	git ls-remote dst refs/heads/main >actual.main &&
 	test_cmp expect.main actual.main
diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
index 2a782214ee..21f0262cbd 100755
--- a/t/t5534-push-signed.sh
+++ b/t/t5534-push-signed.sh
@@ -126,8 +126,8 @@ test_expect_success GPG 'signed push sends push certificate' '
 	noop=$(git rev-parse noop) &&
 	ff=$(git rev-parse ff) &&
 	noff=$(git rev-parse noff) &&
-	grep "$noop $ff refs/heads/ff" dst/push-cert &&
-	grep "$noop $noff refs/heads/noff" dst/push-cert &&
+	test_grep "$noop $ff refs/heads/ff" dst/push-cert &&
+	test_grep "$noop $noff refs/heads/noff" dst/push-cert &&
 	test_cmp expect dst/push-cert-status
 '
 
@@ -172,8 +172,8 @@ test_expect_success GPGSSH 'ssh signed push sends push certificate' '
 	noop=$(git rev-parse noop) &&
 	ff=$(git rev-parse ff) &&
 	noff=$(git rev-parse noff) &&
-	grep "$noop $ff refs/heads/ff" dst/push-cert &&
-	grep "$noop $noff refs/heads/noff" dst/push-cert &&
+	test_grep "$noop $ff refs/heads/ff" dst/push-cert &&
+	test_grep "$noop $noff refs/heads/noff" dst/push-cert &&
 	test_cmp expect dst/push-cert-status
 '
 
@@ -211,7 +211,7 @@ test_expect_success GPG 'inconsistent push options in signed push not allowed' '
 	git -C dst config receive.advertisepushoptions 1 &&
 	git receive-pack dst <push.tweak >out &&
 	git -C dst rev-parse ff &&
-	grep "inconsistent push options" out
+	test_grep "inconsistent push options" out
 '
 
 test_expect_success GPG 'fail without key and heed user.signingkey' '
@@ -257,8 +257,8 @@ test_expect_success GPG 'fail without key and heed user.signingkey' '
 	noop=$(git rev-parse noop) &&
 	ff=$(git rev-parse ff) &&
 	noff=$(git rev-parse noff) &&
-	grep "$noop $ff refs/heads/ff" dst/push-cert &&
-	grep "$noop $noff refs/heads/noff" dst/push-cert &&
+	test_grep "$noop $ff refs/heads/ff" dst/push-cert &&
+	test_grep "$noop $noff refs/heads/noff" dst/push-cert &&
 	test_cmp expect dst/push-cert-status
 '
 
@@ -309,8 +309,8 @@ test_expect_success GPGSM 'fail without key and heed user.signingkey x509' '
 	noop=$(git rev-parse noop) &&
 	ff=$(git rev-parse ff) &&
 	noff=$(git rev-parse noff) &&
-	grep "$noop $ff refs/heads/ff" dst/push-cert &&
-	grep "$noop $noff refs/heads/noff" dst/push-cert &&
+	test_grep "$noop $ff refs/heads/ff" dst/push-cert &&
+	test_grep "$noop $noff refs/heads/noff" dst/push-cert &&
 	test_cmp expect dst/push-cert-status
 '
 
@@ -362,8 +362,8 @@ test_expect_success GPGSSH 'fail without key and heed user.signingkey ssh' '
 	noop=$(git rev-parse noop) &&
 	ff=$(git rev-parse ff) &&
 	noff=$(git rev-parse noff) &&
-	grep "$noop $ff refs/heads/ff" dst/push-cert &&
-	grep "$noop $noff refs/heads/noff" dst/push-cert &&
+	test_grep "$noop $ff refs/heads/ff" dst/push-cert &&
+	test_grep "$noop $noff refs/heads/noff" dst/push-cert &&
 	test_cmp expect dst/push-cert-status
 '
 
diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index 9982dd2aa6..f323ceebd2 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -244,7 +244,7 @@ test_expect_success '.git/shallow is edited by repack' '
 		origin "+refs/heads/*:refs/remotes/origin/*" &&
 	git -C shallow-client repack -adfl &&
 	test_must_fail git -C shallow-client rev-parse --verify $d^0 &&
-	! grep $d shallow-client/.git/shallow &&
+	test_grep ! $d shallow-client/.git/shallow &&
 
 	git -C shallow-server branch branch-orig $d &&
 	git -C shallow-client fetch --prune --depth=2 \
diff --git a/t/t5538-push-shallow.sh b/t/t5538-push-shallow.sh
index dc0e972943..afab456b32 100755
--- a/t/t5538-push-shallow.sh
+++ b/t/t5538-push-shallow.sh
@@ -65,7 +65,7 @@ test_expect_success 'push from shallow clone, with grafted roots' '
 	(
 	cd shallow2 &&
 	test_must_fail git push ../.git +main:refs/remotes/shallow2/main 2>err &&
-	grep "shallow2/main.*shallow update not allowed" err
+	test_grep "shallow2/main.*shallow update not allowed" err
 	) &&
 	test_must_fail git rev-parse shallow2/main &&
 	git fsck
diff --git a/t/t5539-fetch-http-shallow.sh b/t/t5539-fetch-http-shallow.sh
index 3ea75d34ca..44e6f609df 100755
--- a/t/t5539-fetch-http-shallow.sh
+++ b/t/t5539-fetch-http-shallow.sh
@@ -76,8 +76,8 @@ test_expect_success 'no shallow lines after receiving ACK ready' '
 		# might be able to run this test in all protocol versions.
 		GIT_TRACE_PACKET="$TRASH_DIRECTORY/trace" GIT_TEST_PROTOCOL_VERSION=0 \
 			git fetch --depth=2 &&
-		grep "fetch-pack< ACK .* ready" ../trace &&
-		! grep "fetch-pack> done" ../trace
+		test_grep "fetch-pack< ACK .* ready" ../trace &&
+		test_grep ! "fetch-pack> done" ../trace
 	)
 '
 
diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index 538b603f03..8c34833027 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -56,8 +56,8 @@ test_expect_success 'push to remote repository (standard)' '
 	git commit -m path2 &&
 	HEAD=$(git rev-parse --verify HEAD) &&
 	GIT_TRACE_CURL=true git push -v -v 2>err &&
-	! grep "Expect: 100-continue" err &&
-	grep "POST git-receive-pack ([0-9]* bytes)" err &&
+	test_grep ! "Expect: 100-continue" err &&
+	test_grep "POST git-receive-pack ([0-9]* bytes)" err &&
 	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
 	 test $HEAD = $(git rev-parse --verify HEAD))
 '
@@ -84,7 +84,7 @@ test_expect_success 'push to remote repository (standard) with sending Accept-La
 	git commit -m path_lang &&
 	HEAD=$(git rev-parse --verify HEAD) &&
 	GIT_TRACE_CURL=true LANGUAGE="ko_KR.UTF-8" git push -v -v 2>err &&
-	! grep "Expect: 100-continue" err &&
+	test_grep ! "Expect: 100-continue" err &&
 
 	grep "=> Send header: Accept-Language:" err >err.language &&
 	test_cmp exp err.language
@@ -148,8 +148,8 @@ test_expect_success 'push fails for non-fast-forward refs unmatched by remote he
 	test_must_fail git push -v origin +main main:niam >output 2>&1'
 
 test_expect_success 'push fails for non-fast-forward refs unmatched by remote helper: remote output' '
-	grep "^ + [a-f0-9]*\.\.\.[a-f0-9]* *main -> main (forced update)$" output &&
-	grep "^ ! \[rejected\] *main -> niam (non-fast-forward)$" output
+	test_grep "^ + [a-f0-9]*\.\.\.[a-f0-9]* *main -> main (forced update)$" output &&
+	test_grep "^ ! \[rejected\] *main -> niam (non-fast-forward)$" output
 '
 
 test_expect_success 'push fails for non-fast-forward refs unmatched by remote helper: our output' '
@@ -163,7 +163,7 @@ test_expect_success 'push (chunked)' '
 	HEAD=$(git rev-parse --verify HEAD) &&
 	test_config http.postbuffer 4 &&
 	git push -v -v origin $BRANCH 2>err &&
-	grep "POST git-receive-pack (chunked)" err &&
+	test_grep "POST git-receive-pack (chunked)" err &&
 	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
 	 test $HEAD = $(git rev-parse --verify HEAD))
 '
@@ -215,15 +215,15 @@ test_expect_success 'push --atomic also prevents branch creation, reports collat
 	test_cmp expected actual &&
 
 	# the failed refs should be indicated to the user
-	grep "^ ! .*rejected.* main -> main" output &&
+	test_grep "^ ! .*rejected.* main -> main" output &&
 
 	# the collateral failure refs should be indicated to the user
-	grep "^ ! .*rejected.* atomic -> atomic .*atomic push failed" output &&
-	grep "^ ! .*rejected.* collateral -> collateral .*atomic push failed" output &&
+	test_grep "^ ! .*rejected.* atomic -> atomic .*atomic push failed" output &&
+	test_grep "^ ! .*rejected.* collateral -> collateral .*atomic push failed" output &&
 
 	# never report what we do not push
-	! grep "^ ! .*rejected.* atomic1 " output &&
-	! grep "^ ! .*rejected.* other " output
+	test_grep ! "^ ! .*rejected.* atomic1 " output &&
+	test_grep ! "^ ! .*rejected.* other " output
 '
 
 test_expect_success 'push --atomic fails on server-side errors' '
@@ -247,10 +247,10 @@ test_expect_success 'push --atomic fails on server-side errors' '
 	test_must_fail git -C "$d" show-ref --verify refs/heads/other &&
 
 	# the failed refs should be indicated to the user
-	grep "^ ! .*rejected.* other -> other .*atomic transaction failed" output &&
+	test_grep "^ ! .*rejected.* other -> other .*atomic transaction failed" output &&
 
 	# the collateral failure refs should be indicated to the user
-	grep "^ ! .*rejected.* atomic -> atomic .*atomic transaction failed" output
+	test_grep "^ ! .*rejected.* atomic -> atomic .*atomic transaction failed" output
 '
 
 test_expect_success 'push --all can push to empty repo' '
@@ -442,7 +442,7 @@ test_expect_success 'push status output scrubs password' '
 		"$HTTPD_URL_USER_PASS/smart/test_repo.git" \
 		+HEAD:scrub >status &&
 	# should have been scrubbed down to vanilla URL
-	grep "^To $HTTPD_URL/smart/test_repo.git" status
+	test_grep "^To $HTTPD_URL/smart/test_repo.git" status
 '
 
 test_expect_success 'clone/fetch scrubs password from reflogs' '
@@ -456,8 +456,8 @@ test_expect_success 'clone/fetch scrubs password from reflogs' '
 		+main:main &&
 	# should have been scrubbed down to vanilla URL
 	git log -g main >reflog &&
-	grep "$HTTPD_URL" reflog &&
-	! grep "$HTTPD_URL_USER_PASS" reflog
+	test_grep "$HTTPD_URL" reflog &&
+	test_grep ! "$HTTPD_URL_USER_PASS" reflog
 '
 
 test_expect_success 'Non-ASCII branch name can be used with --force-with-lease' '
diff --git a/t/t5544-pack-objects-hook.sh b/t/t5544-pack-objects-hook.sh
index 89147a052e..908d3b8ebe 100755
--- a/t/t5544-pack-objects-hook.sh
+++ b/t/t5544-pack-objects-hook.sh
@@ -27,7 +27,7 @@ test_expect_success 'hook runs via global config' '
 	clear_hook_results &&
 	test_config_global uploadpack.packObjectsHook ./hook &&
 	git clone --no-local . dst.git 2>stderr &&
-	grep "hook running" stderr
+	test_grep "hook running" stderr
 '
 
 test_expect_success 'hook outputs are sane' '
@@ -38,7 +38,7 @@ test_expect_success 'hook outputs are sane' '
 	# the full argument list or the exact pack contents, as it would make
 	# the test brittle. So just sanity check that we could replay
 	# the packing procedure.
-	grep "^git" .git/hook.args &&
+	test_grep "^git" .git/hook.args &&
 	$(cat .git/hook.args) <.git/hook.stdin >replay
 '
 
@@ -47,14 +47,14 @@ test_expect_success 'hook runs from -c config' '
 	git clone --no-local \
 	  -u "git -c uploadpack.packObjectsHook=./hook upload-pack" \
 	  . dst.git 2>stderr &&
-	grep "hook running" stderr
+	test_grep "hook running" stderr
 '
 
 test_expect_success 'hook does not run from repo config' '
 	clear_hook_results &&
 	test_config uploadpack.packObjectsHook "./hook" &&
 	git clone --no-local . dst.git 2>stderr &&
-	! grep "hook running" stderr &&
+	test_grep ! "hook running" stderr &&
 	test_path_is_missing .git/hook.args &&
 	test_path_is_missing .git/hook.stdin &&
 	test_path_is_missing .git/hook.stdout &&
@@ -62,7 +62,7 @@ test_expect_success 'hook does not run from repo config' '
 	# check that global config is used instead
 	test_config_global uploadpack.packObjectsHook ./hook &&
 	git clone --no-local . dst2.git 2>stderr &&
-	grep "hook running" stderr
+	test_grep "hook running" stderr
 '
 
 test_expect_success 'hook works with partial clone' '
@@ -72,7 +72,7 @@ test_expect_success 'hook works with partial clone' '
 	git clone --bare --no-local --filter=blob:none . dst.git &&
 	git -C dst.git rev-list --objects --missing=allow-any --no-object-names --all >objects &&
 	git -C dst.git cat-file --batch-check="%(objecttype)" <objects >types &&
-	! grep blob types
+	test_grep ! blob types
 '
 
 test_done
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index b0080bf204..f00eeae48f 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -124,7 +124,7 @@ test_expect_success 'netrc authorized but forbidden credentials (fail on 403)' '
 	set_netrc 127.0.0.1 forbidden-user@host pass@host &&
 	test_must_fail git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-netrc-403 2>err &&
 	expect_askpass none &&
-	grep "The requested URL returned error: 403" err
+	test_grep "The requested URL returned error: 403" err
 '
 
 test_expect_success 'http auth can use user/pass in URL' '
@@ -280,7 +280,7 @@ test_expect_success 'http-fetch --packfile' '
 		--index-pack-arg=--keep \
 		"$HTTPD_URL"/dumb/repo_pack.git/$p >out &&
 
-	grep -E "^keep.[0-9a-f]{16,}$" out &&
+	test_grep -E "^keep.[0-9a-f]{16,}$" out &&
 	cut -c6- out >packhash &&
 
 	# Ensure that the expected files are generated
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index dcff0bc7d4..805bec025c 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -164,8 +164,8 @@ test_expect_success 'fetch changes via http' '
 
 test_expect_success 'used upload-pack service' '
 	strip_access_log >log &&
-	grep "GET  /smart/repo.git/info/refs?service=git-upload-pack HTTP/[0-9.]* 200" log &&
-	grep "POST /smart/repo.git/git-upload-pack HTTP/[0-9.]* 200" log
+	test_grep "GET  /smart/repo.git/info/refs?service=git-upload-pack HTTP/[0-9.]* 200" log &&
+	test_grep "POST /smart/repo.git/git-upload-pack HTTP/[0-9.]* 200" log
 '
 
 test_expect_success 'follow redirects (301)' '
@@ -264,8 +264,8 @@ test_expect_success 'GIT_TRACE_CURL redacts auth details' '
 
 	# Ensure that there is no "Basic" followed by a base64 string, but that
 	# the auth details are redacted
-	! grep -i "Authorization: Basic [0-9a-zA-Z+/]" trace &&
-	grep -i "Authorization: Basic <redacted>" trace
+	test_grep ! -i "Authorization: Basic [0-9a-zA-Z+/]" trace &&
+	test_grep -i "Authorization: Basic <redacted>" trace
 '
 
 test_expect_success 'GIT_CURL_VERBOSE redacts auth details' '
@@ -276,8 +276,8 @@ test_expect_success 'GIT_CURL_VERBOSE redacts auth details' '
 
 	# Ensure that there is no "Basic" followed by a base64 string, but that
 	# the auth details are redacted
-	! grep -i "Authorization: Basic [0-9a-zA-Z+/]" trace &&
-	grep -i "Authorization: Basic <redacted>" trace
+	test_grep ! -i "Authorization: Basic [0-9a-zA-Z+/]" trace &&
+	test_grep -i "Authorization: Basic <redacted>" trace
 '
 
 test_expect_success 'GIT_TRACE_CURL does not redact auth details if GIT_TRACE_REDACT=0' '
@@ -287,7 +287,7 @@ test_expect_success 'GIT_TRACE_CURL does not redact auth details if GIT_TRACE_RE
 		git clone --bare "$HTTPD_URL/auth/smart/repo.git" redact-auth &&
 	expect_askpass both user%40host &&
 
-	grep -i "Authorization: Basic [0-9a-zA-Z+/]" trace
+	test_grep -i "Authorization: Basic [0-9a-zA-Z+/]" trace
 '
 
 test_expect_success 'disable dumb http on server' '
@@ -419,7 +419,7 @@ test_expect_success 'large fetch-pack requests can be sent using chunked encodin
 		clone --bare "$HTTPD_URL/smart/repo.git" split.git 2>err &&
 	{
 		test_have_prereq HTTP2 ||
-		grep "^=> Send header: Transfer-Encoding: chunked" err
+		test_grep "^=> Send header: Transfer-Encoding: chunked" err
 	}
 '
 
@@ -554,10 +554,10 @@ test_expect_success 'cookies are redacted by default' '
 	GIT_TRACE_CURL=true \
 		git -c "http.cookieFile=$(pwd)/cookies" clone \
 		$HTTPD_URL/smart/repo.git clone 2>err &&
-	grep -i "Cookie:.*Foo=<redacted>" err &&
-	grep -i "Cookie:.*Bar=<redacted>" err &&
-	! grep -i "Cookie:.*Foo=1" err &&
-	! grep -i "Cookie:.*Bar=2" err
+	test_grep -i "Cookie:.*Foo=<redacted>" err &&
+	test_grep -i "Cookie:.*Bar=<redacted>" err &&
+	test_grep ! -i "Cookie:.*Foo=1" err &&
+	test_grep ! -i "Cookie:.*Bar=2" err
 '
 
 test_expect_success 'empty values of cookies are also redacted' '
@@ -566,7 +566,7 @@ test_expect_success 'empty values of cookies are also redacted' '
 	GIT_TRACE_CURL=true \
 		git -c "http.cookieFile=$(pwd)/cookies" clone \
 		$HTTPD_URL/smart/repo.git clone 2>err &&
-	grep -i "Cookie:.*Foo=<redacted>" err
+	test_grep -i "Cookie:.*Foo=<redacted>" err
 '
 
 test_expect_success 'GIT_TRACE_REDACT=0 disables cookie redaction' '
@@ -576,20 +576,20 @@ test_expect_success 'GIT_TRACE_REDACT=0 disables cookie redaction' '
 	GIT_TRACE_REDACT=0 GIT_TRACE_CURL=true \
 		git -c "http.cookieFile=$(pwd)/cookies" clone \
 		$HTTPD_URL/smart/repo.git clone 2>err &&
-	grep -i "Cookie:.*Foo=1" err &&
-	grep -i "Cookie:.*Bar=2" err
+	test_grep -i "Cookie:.*Foo=1" err &&
+	test_grep -i "Cookie:.*Bar=2" err
 '
 
 test_expect_success 'GIT_TRACE_CURL_NO_DATA prevents data from being traced' '
 	rm -rf clone &&
 	GIT_TRACE_CURL=true \
 		git clone $HTTPD_URL/smart/repo.git clone 2>err &&
-	grep "=> Send data" err &&
+	test_grep "=> Send data" err &&
 
 	rm -rf clone &&
 	GIT_TRACE_CURL=true GIT_TRACE_CURL_NO_DATA=1 \
 		git clone $HTTPD_URL/smart/repo.git clone 2>err &&
-	! grep "=> Send data" err
+	test_grep ! "=> Send data" err
 '
 
 test_expect_success 'server-side error detected' '
@@ -644,7 +644,7 @@ test_expect_success 'client falls back from v2 to v0 to match server' '
 	git clone $HTTPD_URL/smart_v0/repo.git repo-v0 &&
 	# check for v0; there the HEAD symref is communicated in the capability
 	# line; v2 uses a different syntax on each ref advertisement line
-	grep symref=HEAD:refs/heads/ trace
+	test_grep symref=HEAD:refs/heads/ trace
 '
 
 test_expect_success 'create empty http-accessible SHA-256 repository' '
@@ -692,7 +692,7 @@ test_expect_success 'clone warns or fails when using username:password' '
 
 	git -c transfer.credentialsInUrl=allow \
 		clone $url_userpass attempt1 2>err &&
-	! grep "$message" err &&
+	test_grep ! "$message" err &&
 
 	git -c transfer.credentialsInUrl=warn \
 		clone $url_userpass attempt2 2>err &&
@@ -721,12 +721,12 @@ test_expect_success 'clone does not detect username:password when it is https://
 	esac &&
 
 	git -c transfer.credentialsInUrl=warn clone $url_user attempt1 2>err &&
-	! grep "uses plaintext credentials" err
+	test_grep ! "uses plaintext credentials" err
 '
 
 test_expect_success 'fetch warns or fails when using username:password' '
 	git -c transfer.credentialsInUrl=allow fetch $url_userpass 2>err &&
-	! grep "$message" err &&
+	test_grep ! "$message" err &&
 
 	git -c transfer.credentialsInUrl=warn fetch $url_userpass 2>err &&
 	grep "warning: $message" err >warnings &&
@@ -746,7 +746,7 @@ test_expect_success 'fetch warns or fails when using username:password' '
 
 test_expect_success 'push warns or fails when using username:password' '
 	git -c transfer.credentialsInUrl=allow push $url_userpass 2>err &&
-	! grep "$message" err &&
+	test_grep ! "$message" err &&
 
 	git -c transfer.credentialsInUrl=warn push $url_userpass 2>err &&
 	grep "warning: $message" err >warnings &&
@@ -763,7 +763,7 @@ test_expect_success 'no empty path components' '
 	git clone $HTTPD_URL/smart/repo.git/ clone-with-slash &&
 
 	strip_access_log >log &&
-	! grep "//" log
+	test_grep ! "//" log
 '
 
 test_expect_success 'tag following always works over v0 http' '
diff --git a/t/t5552-skipping-fetch-negotiator.sh b/t/t5552-skipping-fetch-negotiator.sh
index eeddb85b1d..96e224168e 100755
--- a/t/t5552-skipping-fetch-negotiator.sh
+++ b/t/t5552-skipping-fetch-negotiator.sh
@@ -201,7 +201,7 @@ test_expect_success 'do not send "have" with ancestors of commits that server AC
 		export GIT_TEST_PROTOCOL_VERSION &&
 		trace_fetch client "$(pwd)/server" to_fetch
 	) &&
-	grep "  fetch" trace &&
+	test_grep "  fetch" trace &&
 
 	# fetch-pack sends 2 requests each containing 16 "have" lines before
 	# processing the first response. In these 2 requests, 4 commits from
@@ -211,8 +211,8 @@ test_expect_success 'do not send "have" with ancestors of commits that server AC
 
 	# While fetch-pack is processing the first response, it should read that
 	# the server ACKs b1.c19 and b1.c17.
-	grep "fetch< ACK $(git -C client rev-parse b1.c19) common" trace &&
-	grep "fetch< ACK $(git -C client rev-parse b1.c17) common" trace &&
+	test_grep "fetch< ACK $(git -C client rev-parse b1.c19) common" trace &&
+	test_grep "fetch< ACK $(git -C client rev-parse b1.c17) common" trace &&
 
 	# fetch-pack should thus not send any more commits in the b1 branch, but
 	# should still send the others (in this test, just check b2).
diff --git a/t/t5554-noop-fetch-negotiator.sh b/t/t5554-noop-fetch-negotiator.sh
index 17e73b606d..d50ffe55b6 100755
--- a/t/t5554-noop-fetch-negotiator.sh
+++ b/t/t5554-noop-fetch-negotiator.sh
@@ -16,8 +16,8 @@ test_expect_success 'noop negotiator does not emit any "have"' '
 	test_config -C client fetch.negotiationalgorithm noop &&
 	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch "$(pwd)/server" &&
 
-	! grep "fetch> have" trace &&
-	grep "fetch> done" trace
+	test_grep ! "fetch> have" trace &&
+	test_grep "fetch> done" trace
 '
 
 test_done
diff --git a/t/t5557-http-get.sh b/t/t5557-http-get.sh
index 67fcc23f11..e8ffe3f8e9 100755
--- a/t/t5557-http-get.sh
+++ b/t/t5557-http-get.sh
@@ -18,7 +18,7 @@ test_expect_success 'get by URL: 404' '
 
 	test_must_fail git remote-http $url <input 2>err &&
 	test_path_is_missing file1 &&
-	grep "failed to download file at URL" err
+	test_grep "failed to download file at URL" err
 '
 
 test_expect_success 'get by URL: 200' '
diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index 7a0943bd36..0d5be0d56e 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -8,14 +8,14 @@ test_description='test fetching bundles with --bundle-uri'
 test_expect_success 'fail to clone from non-existent file' '
 	test_when_finished rm -rf test &&
 	git clone --bundle-uri="$(pwd)/does-not-exist" . test 2>err &&
-	grep "failed to download bundle from URI" err
+	test_grep "failed to download bundle from URI" err
 '
 
 test_expect_success 'fail to clone from non-bundle file' '
 	test_when_finished rm -rf test &&
 	echo bogus >bogus &&
 	git clone --bundle-uri="$(pwd)/bogus" . test 2>err &&
-	grep "is not a bundle" err
+	test_grep "is not a bundle" err
 '
 
 test_expect_success 'create bundle' '
@@ -197,7 +197,7 @@ test_expect_success 'clone bundle list (file, no heuristic)' '
 
 	git clone --bundle-uri="file://$(pwd)/bundle-list" \
 		clone-from clone-list-file 2>err &&
-	! grep "Repository lacks these prerequisite commits" err &&
+	test_grep ! "Repository lacks these prerequisite commits" err &&
 
 	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
 	git -C clone-list-file cat-file --batch-check <oids &&
@@ -242,9 +242,9 @@ test_expect_success 'clone bundle list (file, all mode, some failures)' '
 	GIT_TRACE2_PERF=1 \
 	git clone --bundle-uri="file://$(pwd)/bundle-list" \
 		clone-from clone-all-some 2>err &&
-	! grep "Repository lacks these prerequisite commits" err &&
-	! grep "fatal" err &&
-	grep "warning: failed to download bundle from URI" err &&
+	test_grep ! "Repository lacks these prerequisite commits" err &&
+	test_grep ! "fatal" err &&
+	test_grep "warning: failed to download bundle from URI" err &&
 
 	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
 	git -C clone-all-some cat-file --batch-check <oids &&
@@ -275,15 +275,15 @@ test_expect_success 'clone bundle list (file, all mode, all failures)' '
 
 	git clone --bundle-uri="file://$(pwd)/bundle-list" \
 		clone-from clone-all-fail 2>err &&
-	! grep "Repository lacks these prerequisite commits" err &&
-	! grep "fatal" err &&
-	grep "warning: failed to download bundle from URI" err &&
+	test_grep ! "Repository lacks these prerequisite commits" err &&
+	test_grep ! "fatal" err &&
+	test_grep "warning: failed to download bundle from URI" err &&
 
 	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
 	git -C clone-all-fail cat-file --batch-check <oids &&
 
 	git -C clone-all-fail for-each-ref --format="%(refname)" >refs &&
-	! grep "refs/bundles/heads/" refs
+	test_grep ! "refs/bundles/heads/" refs
 '
 
 test_expect_success 'clone bundle list (file, any mode)' '
@@ -306,7 +306,7 @@ test_expect_success 'clone bundle list (file, any mode)' '
 
 	git clone --bundle-uri="file://$(pwd)/bundle-list" \
 		clone-from clone-any-file 2>err &&
-	! grep "Repository lacks these prerequisite commits" err &&
+	test_grep ! "Repository lacks these prerequisite commits" err &&
 
 	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
 	git -C clone-any-file cat-file --batch-check <oids &&
@@ -336,14 +336,14 @@ test_expect_success 'clone bundle list (file, any mode, all failures)' '
 
 	git clone --bundle-uri="file://$(pwd)/bundle-list" \
 		clone-from clone-any-fail 2>err &&
-	! grep "fatal" err &&
-	grep "warning: failed to download bundle from URI" err &&
+	test_grep ! "fatal" err &&
+	test_grep "warning: failed to download bundle from URI" err &&
 
 	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
 	git -C clone-any-fail cat-file --batch-check <oids &&
 
 	git -C clone-any-fail for-each-ref --format="%(refname)" >refs &&
-	! grep "refs/bundles/heads/" refs
+	test_grep ! "refs/bundles/heads/" refs
 '
 
 test_expect_success 'negotiation: bundle with part of wanted commits' '
@@ -477,14 +477,14 @@ start_httpd
 test_expect_success 'fail to fetch from non-existent HTTP URL' '
 	test_when_finished rm -rf test &&
 	git clone --bundle-uri="$HTTPD_URL/does-not-exist" . test 2>err &&
-	grep "failed to download bundle from URI" err
+	test_grep "failed to download bundle from URI" err
 '
 
 test_expect_success 'fail to fetch from non-bundle HTTP URL' '
 	test_when_finished rm -rf test &&
 	echo bogus >"$HTTPD_DOCUMENT_ROOT_PATH/bogus" &&
 	git clone --bundle-uri="$HTTPD_URL/bogus" . test 2>err &&
-	grep "is not a bundle" err
+	test_grep "is not a bundle" err
 '
 
 test_expect_success 'clone HTTP bundle' '
@@ -536,7 +536,7 @@ test_expect_success 'clone bundle list (HTTP, no heuristic)' '
 	GIT_TRACE2_EVENT="$(pwd)/trace-clone.txt" \
 		git clone --bundle-uri="$HTTPD_URL/bundle-list" \
 		clone-from clone-list-http  2>err &&
-	! grep "Repository lacks these prerequisite commits" err &&
+	test_grep ! "Repository lacks these prerequisite commits" err &&
 
 	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
 	git -C clone-list-http cat-file --batch-check <oids &&
@@ -576,8 +576,8 @@ test_expect_success 'clone bundle list (HTTP, any mode)' '
 
 	git clone --bundle-uri="$HTTPD_URL/bundle-list" \
 		clone-from clone-any-http 2>err &&
-	! grep "fatal" err &&
-	grep "warning: failed to download bundle from URI" err &&
+	test_grep ! "fatal" err &&
+	test_grep "warning: failed to download bundle from URI" err &&
 
 	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
 	git -C clone-any-http cat-file --batch-check <oids &&
diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backend-content-length.sh
index b6ee06f5c8..59c6a50dd2 100755
--- a/t/t5562-http-backend-content-length.sh
+++ b/t/t5562-http-backend-content-length.sh
@@ -163,7 +163,7 @@ test_expect_success 'CONTENT_LENGTH overflow ssite_t' '
 		REQUEST_METHOD=POST \
 		CONTENT_LENGTH="$NOT_FIT_IN_SSIZE" \
 		git http-backend </dev/null >/dev/null 2>err &&
-	grep "fatal:.*CONTENT_LENGTH" err
+	test_grep "fatal:.*CONTENT_LENGTH" err
 '
 
 test_expect_success 'empty CONTENT_LENGTH' '
diff --git a/t/t5564-http-proxy.sh b/t/t5564-http-proxy.sh
index 817cd1f984..866e2b4e93 100755
--- a/t/t5564-http-proxy.sh
+++ b/t/t5564-http-proxy.sh
@@ -20,14 +20,14 @@ setup_askpass_helper
 test_expect_success 'proxy requires password' '
 	test_config_global http.proxy $HTTPD_DEST &&
 	test_must_fail git clone $HTTPD_URL/smart/repo.git 2>err &&
-	grep "error.*407" err
+	test_grep "error.*407" err
 '
 
 test_expect_success 'clone through proxy with auth' '
 	test_when_finished "rm -rf clone" &&
 	test_config_global http.proxy http://proxuser:proxpass@$HTTPD_DEST &&
 	GIT_TRACE_CURL=$PWD/trace git clone $HTTPD_URL/smart/repo.git clone &&
-	grep -i "Proxy-Authorization: Basic <redacted>" trace
+	test_grep -i "Proxy-Authorization: Basic <redacted>" trace
 '
 
 test_expect_success 'clone can prompt for proxy password' '
@@ -82,7 +82,7 @@ test_expect_success SOCKS_PROXY 'clone via Unix socket' '
 			GIT_TRACE_CURL=$PWD/trace \
 			GIT_TRACE_CURL_COMPONENTS=socks \
 			git clone "$HTTPD_URL/smart/repo.git" clone 2>err &&
-			grep -i "SOCKS4 request granted" trace
+			test_grep -i "SOCKS4 request granted" trace
 		} ||
 		old_libcurl_error err
 	}
@@ -90,14 +90,14 @@ test_expect_success SOCKS_PROXY 'clone via Unix socket' '
 
 test_expect_success 'Unix socket requires socks*:' - <<\EOT
 	! git clone -c http.proxy=localhost/path https://example.com/repo.git 2>err && {
-		grep -Fx "fatal: Invalid proxy URL 'localhost/path': only SOCKS proxies support paths" err ||
+		test_grep -Fx "fatal: Invalid proxy URL 'localhost/path': only SOCKS proxies support paths" err ||
 		old_libcurl_error err
 	}
 EOT
 
 test_expect_success 'Unix socket requires localhost' - <<\EOT
 	! git clone -c http.proxy=socks4://127.0.0.1/path https://example.com/repo.git 2>err && {
-		grep -Fx "fatal: Invalid proxy URL 'socks4://127.0.0.1/path': host must be localhost if a path is present" err ||
+		test_grep -Fx "fatal: Invalid proxy URL 'socks4://127.0.0.1/path': host must be localhost if a path is present" err ||
 		old_libcurl_error err
 	}
 EOT
diff --git a/t/t5581-http-curl-verbose.sh b/t/t5581-http-curl-verbose.sh
index cded79c16b..6788cf8171 100755
--- a/t/t5581-http-curl-verbose.sh
+++ b/t/t5581-http-curl-verbose.sh
@@ -23,7 +23,7 @@ test_expect_success 'failure in git-upload-pack is shown' '
 	test_might_fail env GIT_CURL_VERBOSE=1 \
 		git clone "$HTTPD_URL/error_git_upload_pack/smart/repo.git" \
 		2>curl_log &&
-	grep "<= Recv header: HTTP/1.1 500 Intentional Breakage" curl_log
+	test_grep "<= Recv header: HTTP/1.1 500 Intentional Breakage" curl_log
 '
 
 test_done
diff --git a/t/t5583-push-branches.sh b/t/t5583-push-branches.sh
index e7e1b6dab6..1ccfaee75a 100755
--- a/t/t5583-push-branches.sh
+++ b/t/t5583-push-branches.sh
@@ -60,21 +60,21 @@ test_expect_success '--all or --branches can not be combined with refspecs' '
 	test_must_fail git push remote-1 --all main >actual.all 2>&1 &&
 	test_must_fail git push remote-1 --branches main >actual.branches 2>&1 &&
 	test_cmp actual.all actual.branches &&
-	grep "be combined with refspecs" actual.all
+	test_grep "be combined with refspecs" actual.all
 '
 
 test_expect_success '--all or --branches can not be combined with --mirror' '
 	test_must_fail git push remote-1 --all --mirror >actual.all 2>&1 &&
 	test_must_fail git push remote-1 --branches --mirror >actual.branches 2>&1 &&
 	test_cmp actual.all actual.branches &&
-	grep "cannot be used together" actual.all
+	test_grep "cannot be used together" actual.all
 '
 
 test_expect_success '--all or --branches can not be combined with --tags' '
 	test_must_fail git push remote-1 --all --tags >actual.all 2>&1 &&
 	test_must_fail git push remote-1 --branches --tags >actual.branches 2>&1 &&
 	test_cmp actual.all actual.branches &&
-	grep "cannot be used together" actual.all
+	test_grep "cannot be used together" actual.all
 '
 
 
@@ -82,7 +82,7 @@ test_expect_success '--all or --branches can not be combined with --delete' '
 	test_must_fail git push remote-1 --all --delete >actual.all 2>&1 &&
 	test_must_fail git push remote-1 --branches --delete >actual.branches 2>&1 &&
 	test_cmp actual.all actual.branches &&
-	grep "cannot be used together" actual.all
+	test_grep "cannot be used together" actual.all
 '
 
 test_expect_success '--all or --branches combines with --follow-tags have same behavior' '
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 3dd229c186..b6167582a1 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -159,8 +159,8 @@ test_expect_success 'clone --mirror does not repeat tags' '
 	git clone --mirror src mirror2 &&
 	(cd mirror2 &&
 	 git show-ref 2> clone.err > clone.out) &&
-	! grep Duplicate mirror2/clone.err &&
-	grep some-tag mirror2/clone.out
+	test_grep ! Duplicate mirror2/clone.err &&
+	test_grep some-tag mirror2/clone.out
 
 '
 
@@ -224,12 +224,12 @@ test_expect_success 'clone a void' '
 		cd src-0 && git init
 	) &&
 	git clone "file://$(pwd)/src-0" target-6 2>err-6 &&
-	! grep "fatal:" err-6 &&
+	test_grep ! "fatal:" err-6 &&
 	(
 		cd src-0 && test_commit A
 	) &&
 	git clone "file://$(pwd)/src-0" target-7 2>err-7 &&
-	! grep "fatal:" err-7 &&
+	test_grep ! "fatal:" err-7 &&
 	# There is no reason to insist they are bit-for-bit
 	# identical, but this test should suffice for now.
 	test_cmp target-6/.git/config target-7/.git/config
@@ -298,22 +298,22 @@ test_expect_success 'clone separate gitdir where target already exists' '
 	rm -rf dst &&
 	echo foo=bar >>realgitdir/config &&
 	test_must_fail git clone --separate-git-dir realgitdir src dst &&
-	grep foo=bar realgitdir/config
+	test_grep foo=bar realgitdir/config
 '
 
 test_expect_success 'clone --reference from original' '
 	git clone --shared --bare src src-1 &&
 	git clone --bare src src-2 &&
 	git clone --reference=src-2 --bare src-1 target-8 &&
-	grep /src-2/ target-8/objects/info/alternates
+	test_grep /src-2/ target-8/objects/info/alternates
 '
 
 test_expect_success 'clone with more than one --reference' '
 	git clone --bare src src-3 &&
 	git clone --bare src src-4 &&
 	git clone --reference=src-3 --reference=src-4 src target-9 &&
-	grep /src-3/ target-9/.git/objects/info/alternates &&
-	grep /src-4/ target-9/.git/objects/info/alternates
+	test_grep /src-3/ target-9/.git/objects/info/alternates &&
+	test_grep /src-4/ target-9/.git/objects/info/alternates
 '
 
 test_expect_success 'clone from original with relative alternate' '
@@ -321,7 +321,7 @@ test_expect_success 'clone from original with relative alternate' '
 	git clone --bare src nest/src-5 &&
 	echo ../../../src/.git/objects >nest/src-5/objects/info/alternates &&
 	git clone --bare nest/src-5 target-10 &&
-	grep /src/\\.git/objects target-10/objects/info/alternates
+	test_grep /src/\\.git/objects target-10/objects/info/alternates
 '
 
 test_expect_success 'clone checking out a tag' '
@@ -663,8 +663,8 @@ test_expect_success PERL_TEST_HELPERS 'clone on case-insensitive fs' '
 '
 
 test_expect_success PERL_TEST_HELPERS,CASE_INSENSITIVE_FS 'colliding file detection' '
-	grep X icasefs/warning &&
-	grep x icasefs/warning &&
+	test_grep X icasefs/warning &&
+	test_grep x icasefs/warning &&
 	test_grep "the following paths have collided" icasefs/warning
 '
 
@@ -857,7 +857,7 @@ test_expect_success 'auto-discover bundle URI from HTTP clone' '
 	cat >pattern <<-EOF &&
 	"event":"child_start".*"argv":\["git-remote-https","$HTTPD_URL/everything.bundle"\]
 	EOF
-	grep -f pattern trace.txt
+	test_grep -f pattern trace.txt
 '
 
 test_expect_success 'auto-discover multiple bundles from HTTP clone' '
@@ -888,11 +888,11 @@ test_expect_success 'auto-discover multiple bundles from HTTP clone' '
 	cat >pattern <<-EOF &&
 	"event":"child_start".*"argv":\["git-remote-https","$HTTPD_URL/everything.bundle"\]
 	EOF
-	grep -f pattern trace.txt &&
+	test_grep -f pattern trace.txt &&
 	cat >pattern <<-EOF &&
 	"event":"child_start".*"argv":\["git-remote-https","$HTTPD_URL/new.bundle"\]
 	EOF
-	grep -f pattern trace.txt
+	test_grep -f pattern trace.txt
 '
 
 test_expect_success 'auto-discover multiple bundles from HTTP clone: creationToken heuristic' '
diff --git a/t/t5604-clone-reference.sh b/t/t5604-clone-reference.sh
index c232ab8c15..39a0c318df 100755
--- a/t/t5604-clone-reference.sh
+++ b/t/t5604-clone-reference.sh
@@ -65,7 +65,7 @@ test_expect_success 'cloning with reference (no -l -s)' '
 
 test_expect_success 'fetched no objects' '
 	test -s "$U.D" &&
-	! grep " want" "$U.D"
+	test_grep ! " want" "$U.D"
 '
 
 test_expect_success 'existence of info/alternates' '
@@ -157,9 +157,9 @@ test_expect_success 'fetch with incomplete alternates' '
 	) &&
 	main_object=$(git -C A rev-parse --verify refs/heads/main) &&
 	test -s "$U.K" &&
-	! grep " want $main_object" "$U.K" &&
+	test_grep ! " want $main_object" "$U.K" &&
 	tag_object=$(git -C A rev-parse --verify refs/tags/foo) &&
-	! grep " want $tag_object" "$U.K"
+	test_grep ! " want $tag_object" "$U.K"
 '
 
 test_expect_success 'clone using repo with gitfile as a reference' '
@@ -357,7 +357,7 @@ test_expect_success SYMLINKS 'clone repo with symlinked objects directory' '
 	test_must_fail git clone --local malicious clone 2>err &&
 
 	test_path_is_missing clone &&
-	grep "is a symlink, refusing to clone with --local" err
+	test_grep "is a symlink, refusing to clone with --local" err
 '
 
 test_expect_success 'dissociate from repo with commit graph' '
diff --git a/t/t5605-clone-local.sh b/t/t5605-clone-local.sh
index 2397f8fa61..156362f145 100755
--- a/t/t5605-clone-local.sh
+++ b/t/t5605-clone-local.sh
@@ -172,7 +172,7 @@ test_expect_success REFFILES 'local clone from repo with corrupt refs fails grac
 	echo a >corrupt/.git/refs/heads/topic &&
 
 	test_must_fail git clone corrupt working 2>err &&
-	grep "has neither a valid OID nor a target" err
+	test_grep "has neither a valid OID nor a target" err
 '
 
 test_done
diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index 8a15237736..1b48da496b 100755
--- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -63,7 +63,7 @@ test_expect_success 'disallows --bundle-uri with shallow options' '
 	for option in --depth=1 --shallow-since=01-01-2000 --shallow-exclude=HEAD
 	do
 		test_must_fail git clone --bundle-uri=bundle $option from to 2>err &&
-		grep "bundle-uri.* cannot be used together" err || return 1
+		test_grep "bundle-uri.* cannot be used together" err || return 1
 	done
 '
 
@@ -147,7 +147,7 @@ test_expect_success 'prefers --origin over -c config' '
 test_expect_success 'redirected clone does not show progress' '
 
 	git clone "file://$(pwd)/parent" clone-redirected >out 2>err &&
-	! grep % err &&
+	test_grep ! % err &&
 	test_grep ! "Checking connectivity" err
 
 '
@@ -156,7 +156,7 @@ test_expect_success 'redirected clone -v does show progress' '
 
 	git clone --progress "file://$(pwd)/parent" clone-redirected-progress \
 		>out 2>err &&
-	grep % err
+	test_grep % err
 
 '
 
diff --git a/t/t5612-clone-refspec.sh b/t/t5612-clone-refspec.sh
index 3126cfd7e9..dd1fe0abb4 100755
--- a/t/t5612-clone-refspec.sh
+++ b/t/t5612-clone-refspec.sh
@@ -97,7 +97,7 @@ test_expect_success 'by default no tags will be kept updated' '
 test_expect_success 'clone with --no-tags' '
 	(
 		cd dir_all_no_tags &&
-		grep tagOpt .git/config &&
+		test_grep tagOpt .git/config &&
 		git fetch &&
 		git for-each-ref refs/tags >../actual
 	) &&
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 1c2805acca..ddbf2b72c6 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -60,8 +60,8 @@ test_expect_success 'verify that .promisor file contains refs fetched' '
 	ls pc1/.git/objects/pack/pack-*.promisor >promisorlist &&
 	test_line_count = 1 promisorlist &&
 	git -C srv.bare rev-parse --verify HEAD >headhash &&
-	grep "$(cat headhash) HEAD" $(cat promisorlist) &&
-	grep "$(cat headhash) refs/heads/main" $(cat promisorlist)
+	test_grep "$(cat headhash) HEAD" $(cat promisorlist) &&
+	test_grep "$(cat headhash) refs/heads/main" $(cat promisorlist)
 '
 
 # checkout main to force dynamic object fetch of blobs at HEAD.
@@ -230,8 +230,8 @@ test_expect_success 'fetch --refetch triggers repacking' '
 	GIT_TRACE2_EVENT="$PWD/trace1.event" \
 	git -C pc1 fetch --refetch origin &&
 	test_subcommand git maintenance run --auto --no-quiet --no-detach <trace1.event &&
-	grep \"param\":\"gc.autopacklimit\",\"value\":\"1\" trace1.event &&
-	grep \"param\":\"maintenance.incremental-repack.auto\",\"value\":\"-1\" trace1.event &&
+	test_grep \"param\":\"gc.autopacklimit\",\"value\":\"1\" trace1.event &&
+	test_grep \"param\":\"maintenance.incremental-repack.auto\",\"value\":\"-1\" trace1.event &&
 
 	GIT_TRACE2_EVENT="$PWD/trace2.event" \
 	git -c protocol.version=0 \
@@ -239,8 +239,8 @@ test_expect_success 'fetch --refetch triggers repacking' '
 		-c maintenance.incremental-repack.auto=1234 \
 		-C pc1 fetch --refetch origin &&
 	test_subcommand git maintenance run --auto --no-quiet --no-detach <trace2.event &&
-	grep \"param\":\"gc.autopacklimit\",\"value\":\"0\" trace2.event &&
-	grep \"param\":\"maintenance.incremental-repack.auto\",\"value\":\"-1\" trace2.event &&
+	test_grep \"param\":\"gc.autopacklimit\",\"value\":\"0\" trace2.event &&
+	test_grep \"param\":\"maintenance.incremental-repack.auto\",\"value\":\"-1\" trace2.event &&
 
 	GIT_TRACE2_EVENT="$PWD/trace3.event" \
 	git -c protocol.version=0 \
@@ -248,8 +248,8 @@ test_expect_success 'fetch --refetch triggers repacking' '
 		-c maintenance.incremental-repack.auto=0 \
 		-C pc1 fetch --refetch origin &&
 	test_subcommand git maintenance run --auto --no-quiet --no-detach <trace3.event &&
-	grep \"param\":\"gc.autopacklimit\",\"value\":\"1\" trace3.event &&
-	grep \"param\":\"maintenance.incremental-repack.auto\",\"value\":\"0\" trace3.event
+	test_grep \"param\":\"gc.autopacklimit\",\"value\":\"1\" trace3.event &&
+	test_grep \"param\":\"maintenance.incremental-repack.auto\",\"value\":\"0\" trace3.event
 '
 
 test_expect_success 'partial clone with transfer.fsckobjects=1 works with submodules' '
@@ -284,7 +284,7 @@ test_expect_success 'partial clone with transfer.fsckobjects=1 uses index-pack -
 
 	GIT_TRACE="$(pwd)/trace" git -c transfer.fsckobjects=1 \
 		clone --filter="blob:none" "file://$(pwd)/src" dst &&
-	grep "git index-pack.*--fsck-objects" trace
+	test_grep "git index-pack.*--fsck-objects" trace
 '
 
 test_expect_success 'use fsck before and after manually fetching a missing subtree' '
@@ -312,7 +312,7 @@ test_expect_success 'use fsck before and after manually fetching a missing subtr
 
 	# Auto-fetch a tree with cat-file.
 	git -C dst cat-file -p $SUBTREE >tree_contents &&
-	grep file.txt tree_contents &&
+	test_grep file.txt tree_contents &&
 
 	# fsck still works after an auto-fetch of a tree.
 	git -C dst fsck &&
@@ -333,14 +333,14 @@ test_expect_success 'implicitly construct combine: filter with repeated flags' '
 	GIT_TRACE=$(pwd)/trace git clone --bare \
 		--filter=blob:none --filter=tree:1 \
 		"file://$(pwd)/srv.bare" pc2 &&
-	grep "trace:.* git pack-objects .*--filter=combine:blob:none+tree:1" \
+	test_grep "trace:.* git pack-objects .*--filter=combine:blob:none+tree:1" \
 		trace &&
 	git -C pc2 rev-list --objects --missing=allow-any HEAD >objects &&
 
 	# We should have gotten some root trees.
-	grep " $" objects &&
+	test_grep " $" objects &&
 	# Should not have gotten any non-root trees or blobs.
-	! grep " ." objects &&
+	test_grep ! " ." objects &&
 
 	xargs -n 1 git -C pc2 cat-file -t <objects >types &&
 	sort -u types >unique_types.actual &&
@@ -409,7 +409,7 @@ test_expect_success 'partial clone fetches blobs pointed to by refs even if norm
 	git -C src tag myblob "$BLOB" &&
 
 	git clone --filter="blob:none" "file://$(pwd)/src" dst 2>err &&
-	! grep "does not point to a valid object" err &&
+	test_grep ! "does not point to a valid object" err &&
 	git -C dst fsck
 '
 
@@ -424,10 +424,10 @@ test_expect_success 'fetch what is specified on CLI even if already promised' '
 
 	git clone --bare --filter=blob:none "file://$(pwd)/src" dst.git &&
 	git -C dst.git rev-list --objects --quiet --missing=print HEAD >missing_before &&
-	grep "?$(cat blob)" missing_before &&
+	test_grep "?$(cat blob)" missing_before &&
 	git -C dst.git fetch origin $(cat blob) &&
 	git -C dst.git rev-list --objects --quiet --missing=print HEAD >missing_after &&
-	! grep "?$(cat blob)" missing_after
+	test_grep ! "?$(cat blob)" missing_after
 '
 
 test_expect_success 'setup src repo for sparse filter' '
@@ -449,8 +449,8 @@ test_expect_success 'partial clone with sparse filter succeeds' '
 	(
 		cd dst.git &&
 		git rev-list --objects --missing=print HEAD >out &&
-		grep "^$(git rev-parse HEAD:one.t)" out &&
-		grep "^?$(git rev-parse HEAD:two.t)" out
+		test_grep "^$(git rev-parse HEAD:one.t)" out &&
+		test_grep "^?$(git rev-parse HEAD:two.t)" out
 	)
 '
 
@@ -521,7 +521,7 @@ test_expect_success 'fetch lazy-fetches only to resolve deltas' '
 	# Verify the assumption that the client needed to fetch the delta base
 	# to resolve the delta.
 	git -C server rev-parse HEAD~1^{tree} >hash &&
-	grep "want $(cat hash)" trace
+	test_grep "want $(cat hash)" trace
 '
 
 test_expect_success 'fetch lazy-fetches only to resolve deltas, protocol v2' '
@@ -538,12 +538,12 @@ test_expect_success 'fetch lazy-fetches only to resolve deltas, protocol v2' '
 		fetch "file://$(pwd)/server" main &&
 
 	# Verify that protocol version 2 was used.
-	grep "fetch< version 2" trace &&
+	test_grep "fetch< version 2" trace &&
 
 	# Verify the assumption that the client needed to fetch the delta base
 	# to resolve the delta.
 	git -C server rev-parse HEAD~1^{tree} >hash &&
-	grep "want $(cat hash)" trace
+	test_grep "want $(cat hash)" trace
 '
 
 test_expect_success 'fetch does not lazy-fetch missing targets of its refs' '
@@ -563,7 +563,7 @@ test_expect_success 'fetch does not lazy-fetch missing targets of its refs' '
 		--no-tags --recurse-submodules=no \
 		origin refs/tags/bar &&
 	FOO_HASH=$(git -C server rev-parse foo) &&
-	! grep "want $FOO_HASH" trace
+	test_grep ! "want $FOO_HASH" trace
 '
 
 # The following two tests must be in this order. It is important that
@@ -621,7 +621,7 @@ test_expect_success 'fetch from a partial clone, protocol v0' '
 	test_config -C client protocol.version 0 &&
 	test_commit -C client bar &&
 	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch "file://$(pwd)/server" &&
-	! grep "version 2" trace
+	test_grep ! "version 2" trace
 '
 
 test_expect_success 'fetch from a partial clone, protocol v2' '
@@ -640,7 +640,7 @@ test_expect_success 'fetch from a partial clone, protocol v2' '
 	test_config -C client protocol.version 2 &&
 	test_commit -C client bar &&
 	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch "file://$(pwd)/server" &&
-	grep "version 2" trace
+	test_grep "version 2" trace
 '
 
 test_expect_success 'repack does not loosen promisor objects' '
@@ -648,7 +648,7 @@ test_expect_success 'repack does not loosen promisor objects' '
 	git clone --bare --filter=blob:none "file://$(pwd)/srv.bare" client &&
 	test_when_finished "rm -rf client trace" &&
 	GIT_TRACE2_PERF="$(pwd)/trace" git -C client repack -A -d &&
-	grep "loosen_unused_packed_objects/loosened:0" trace
+	test_grep "loosen_unused_packed_objects/loosened:0" trace
 '
 
 test_expect_success 'lazy-fetch in submodule succeeds' '
@@ -824,7 +824,7 @@ test_expect_success 'when partial cloning, tolerate server not sending target of
 	# Exercise to make sure it works.
 	git -c protocol.version=2 clone \
 		--filter=blob:none $HTTPD_URL/one_time_script/server repo 2> err &&
-	! grep "missing object referenced by" err &&
+	test_grep ! "missing object referenced by" err &&
 
 	# Ensure that the one-time-script script was used.
 	! test -e "$HTTPD_ROOT_PATH/one-time-script"
@@ -881,13 +881,13 @@ test_expect_success PERL_TEST_HELPERS 'tolerate server sending REF_DELTA against
 	# by any 3 nybbles, then the OID of the delta base.
 	printf "f.,..%s" $(intersperse "," <deltabase_missing) >want &&
 	hex_unpack <thin.pack | intersperse "," >have &&
-	grep $(cat want) have &&
+	test_grep $(cat want) have &&
 
 	# Ensure that the pack contains one delta against HEAD^:have.txt,
 	# similar to the above.
 	printf "f.,..%s" $(intersperse "," <deltabase_have) >want &&
 	hex_unpack <thin.pack | intersperse "," >have &&
-	grep $(cat want) have &&
+	test_grep $(cat want) have &&
 
 	replace_packfile thin.pack &&
 
@@ -901,8 +901,8 @@ test_expect_success PERL_TEST_HELPERS 'tolerate server sending REF_DELTA against
 
 	# Ensure that the missing delta base was directly fetched, but not the
 	# one that the client has.
-	grep "want $(cat deltabase_missing)" trace &&
-	! grep "want $(cat deltabase_have)" trace &&
+	test_grep "want $(cat deltabase_missing)" trace &&
+	test_grep ! "want $(cat deltabase_have)" trace &&
 
 	# Ensure that the one-time-script script was used.
 	! test -e "$HTTPD_ROOT_PATH/one-time-script"
diff --git a/t/t5619-clone-local-ambiguous-transport.sh b/t/t5619-clone-local-ambiguous-transport.sh
index cce62bf78d..e4218e5c7f 100755
--- a/t/t5619-clone-local-ambiguous-transport.sh
+++ b/t/t5619-clone-local-ambiguous-transport.sh
@@ -64,7 +64,7 @@ test_expect_success 'ambiguous transport does not lead to arbitrary file-inclusi
 	#
 	# This works for now, and if we ever fix the URL detection, it
 	# is OK to change this to detect the transport error.
-	grep "protocol .* is not supported" err
+	test_grep "protocol .* is not supported" err
 '
 
 test_done
diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
index d2ea68e065..7462280470 100755
--- a/t/t5620-backfill.sh
+++ b/t/t5620-backfill.sh
@@ -144,7 +144,7 @@ test_expect_success 'do partial clone 2, backfill min batch size' '
 test_expect_success 'backfill --sparse without sparse-checkout fails' '
 	git init not-sparse &&
 	test_must_fail git -C not-sparse backfill --sparse 2>err &&
-	grep "problem loading sparse-checkout" err
+	test_grep "problem loading sparse-checkout" err
 '
 
 test_expect_success 'backfill --sparse' '
@@ -422,7 +422,7 @@ test_expect_success 'backfill range with include-edges enables fetch-free git-lo
 		-C backfill-log log -p HEAD~2..HEAD >log-output &&
 
 	# No promisor fetches should have been needed.
-	! grep "fetch_count" log-trace
+	test_grep ! "fetch_count" log-trace
 '
 
 test_expect_success 'backfill range without include edges causes on-demand fetches in git-log' '
@@ -439,7 +439,7 @@ test_expect_success 'backfill range without include edges causes on-demand fetch
 	GIT_TRACE2_EVENT="$(pwd)/log-no-bdy-trace" git \
 		-C backfill-log-no-bdy log -p HEAD~2..HEAD >log-output &&
 
-	grep "fetch_count" log-no-bdy-trace
+	test_grep "fetch_count" log-no-bdy-trace
 '
 
 test_expect_success 'backfill range enables fetch-free replay' '
@@ -470,7 +470,7 @@ test_expect_success 'backfill range enables fetch-free replay' '
 	GIT_TRACE2_EVENT="$(pwd)/replay-trace" git -C replay-dest.git \
 		replay --onto main topic~1..topic >replay-out &&
 
-	! grep "fetch_count" replay-trace
+	test_grep ! "fetch_count" replay-trace
 '
 
 test_expect_success 'backfill enables fetch-free merge' '
@@ -501,7 +501,7 @@ test_expect_success 'backfill enables fetch-free merge' '
 	GIT_TRACE2_EVENT="$(pwd)/merge-trace" git -C merge-dest \
 		merge origin/side -m "test merge" &&
 
-	! grep "fetch_count" merge-trace
+	test_grep ! "fetch_count" merge-trace
 '
 
 . "$TEST_DIRECTORY"/lib-httpd.sh
@@ -530,7 +530,7 @@ test_expect_success 'backfilling over HTTP succeeds' '
 	awk "{print \$1;}" <rev-list-out >oids &&
 	GIT_TRACE2_EVENT="$(pwd)/walk-trace" git -C backfill-http \
 		cat-file --batch-check <oids >batch-out &&
-	! grep missing batch-out
+	test_grep ! missing batch-out
 '
 
 # DO NOT add non-httpd-specific tests here, because the last part of this
diff --git a/t/t5700-protocol-v1.sh b/t/t5700-protocol-v1.sh
index a73b4d4ff6..ffeb01afae 100755
--- a/t/t5700-protocol-v1.sh
+++ b/t/t5700-protocol-v1.sh
@@ -33,9 +33,9 @@ test_expect_success 'clone with git:// using protocol v1' '
 	test_cmp expect actual &&
 
 	# Client requested to use protocol v1
-	grep "clone> .*\\\0\\\0version=1\\\0$" log &&
+	test_grep "clone> .*\\\0\\\0version=1\\\0$" log &&
 	# Server responded using protocol v1
-	grep "clone< version 1" log
+	test_grep "clone< version 1" log
 '
 
 test_expect_success 'fetch with git:// using protocol v1' '
@@ -49,9 +49,9 @@ test_expect_success 'fetch with git:// using protocol v1' '
 	test_cmp expect actual &&
 
 	# Client requested to use protocol v1
-	grep "fetch> .*\\\0\\\0version=1\\\0$" log &&
+	test_grep "fetch> .*\\\0\\\0version=1\\\0$" log &&
 	# Server responded using protocol v1
-	grep "fetch< version 1" log
+	test_grep "fetch< version 1" log
 '
 
 test_expect_success 'pull with git:// using protocol v1' '
@@ -63,9 +63,9 @@ test_expect_success 'pull with git:// using protocol v1' '
 	test_cmp expect actual &&
 
 	# Client requested to use protocol v1
-	grep "fetch> .*\\\0\\\0version=1\\\0$" log &&
+	test_grep "fetch> .*\\\0\\\0version=1\\\0$" log &&
 	# Server responded using protocol v1
-	grep "fetch< version 1" log
+	test_grep "fetch< version 1" log
 '
 
 test_expect_success 'push with git:// using protocol v1' '
@@ -81,9 +81,9 @@ test_expect_success 'push with git:// using protocol v1' '
 	test_cmp expect actual &&
 
 	# Client requested to use protocol v1
-	grep "push> .*\\\0\\\0version=1\\\0$" log &&
+	test_grep "push> .*\\\0\\\0version=1\\\0$" log &&
 	# Server responded using protocol v1
-	grep "push< version 1" log
+	test_grep "push< version 1" log
 '
 
 stop_git_daemon
@@ -104,7 +104,7 @@ test_expect_success 'clone with file:// using protocol v1' '
 	test_cmp expect actual &&
 
 	# Server responded using protocol v1
-	grep "clone< version 1" log
+	test_grep "clone< version 1" log
 '
 
 test_expect_success 'fetch with file:// using protocol v1' '
@@ -118,7 +118,7 @@ test_expect_success 'fetch with file:// using protocol v1' '
 	test_cmp expect actual &&
 
 	# Server responded using protocol v1
-	grep "fetch< version 1" log
+	test_grep "fetch< version 1" log
 '
 
 test_expect_success 'pull with file:// using protocol v1' '
@@ -130,7 +130,7 @@ test_expect_success 'pull with file:// using protocol v1' '
 	test_cmp expect actual &&
 
 	# Server responded using protocol v1
-	grep "fetch< version 1" log
+	test_grep "fetch< version 1" log
 '
 
 test_expect_success 'push with file:// using protocol v1' '
@@ -146,7 +146,7 @@ test_expect_success 'push with file:// using protocol v1' '
 	test_cmp expect actual &&
 
 	# Server responded using protocol v1
-	grep "push< version 1" log
+	test_grep "push< version 1" log
 '
 
 test_expect_success 'cloning branchless tagless but not refless remote' '
@@ -196,7 +196,7 @@ test_expect_success 'clone with ssh:// using protocol v1' '
 	test_cmp expect actual &&
 
 	# Server responded using protocol v1
-	grep "clone< version 1" log
+	test_grep "clone< version 1" log
 '
 
 test_expect_success 'fetch with ssh:// using protocol v1' '
@@ -211,7 +211,7 @@ test_expect_success 'fetch with ssh:// using protocol v1' '
 	test_cmp expect actual &&
 
 	# Server responded using protocol v1
-	grep "fetch< version 1" log
+	test_grep "fetch< version 1" log
 '
 
 test_expect_success 'pull with ssh:// using protocol v1' '
@@ -224,7 +224,7 @@ test_expect_success 'pull with ssh:// using protocol v1' '
 	test_cmp expect actual &&
 
 	# Server responded using protocol v1
-	grep "fetch< version 1" log
+	test_grep "fetch< version 1" log
 '
 
 test_expect_success 'push with ssh:// using protocol v1' '
@@ -241,7 +241,7 @@ test_expect_success 'push with ssh:// using protocol v1' '
 	test_cmp expect actual &&
 
 	# Server responded using protocol v1
-	grep "push< version 1" log
+	test_grep "push< version 1" log
 '
 
 test_expect_success 'clone propagates object-format from empty repo' '
@@ -277,9 +277,9 @@ test_expect_success 'clone with http:// using protocol v1' '
 	test_cmp expect actual &&
 
 	# Client requested to use protocol v1
-	grep "Git-Protocol: version=1" log &&
+	test_grep "Git-Protocol: version=1" log &&
 	# Server responded using protocol v1
-	grep "git< version 1" log
+	test_grep "git< version 1" log
 '
 
 test_expect_success 'clone with http:// using protocol v1 with empty SHA-256 repo' '
@@ -291,9 +291,9 @@ test_expect_success 'clone with http:// using protocol v1 with empty SHA-256 rep
 	test_cmp expect actual &&
 
 	# Client requested to use protocol v1
-	grep "Git-Protocol: version=1" log &&
+	test_grep "Git-Protocol: version=1" log &&
 	# Server responded using protocol v1
-	grep "git< version 1" log
+	test_grep "git< version 1" log
 '
 
 test_expect_success 'fetch with http:// using protocol v1' '
@@ -307,7 +307,7 @@ test_expect_success 'fetch with http:// using protocol v1' '
 	test_cmp expect actual &&
 
 	# Server responded using protocol v1
-	grep "git< version 1" log
+	test_grep "git< version 1" log
 '
 
 test_expect_success 'pull with http:// using protocol v1' '
@@ -319,7 +319,7 @@ test_expect_success 'pull with http:// using protocol v1' '
 	test_cmp expect actual &&
 
 	# Server responded using protocol v1
-	grep "git< version 1" log
+	test_grep "git< version 1" log
 '
 
 test_expect_success 'push with http:// using protocol v1' '
@@ -335,7 +335,7 @@ test_expect_success 'push with http:// using protocol v1' '
 	test_cmp expect actual &&
 
 	# Server responded using protocol v1
-	grep "git< version 1" log
+	test_grep "git< version 1" log
 '
 
 # DO NOT add non-httpd-specific tests here, because the last part of this
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index d4c28bae39..108eb30945 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -97,7 +97,7 @@ test_expect_success 'request capability as command' '
 	0000
 	EOF
 	test_must_fail test-tool serve-v2 --stateless-rpc 2>err <in &&
-	grep invalid.command.*agent err
+	test_grep invalid.command.*agent err
 '
 
 test_expect_success 'request command as capability' '
@@ -108,7 +108,7 @@ test_expect_success 'request command as capability' '
 	0000
 	EOF
 	test_must_fail test-tool serve-v2 --stateless-rpc 2>err <in &&
-	grep unknown.capability err
+	test_grep unknown.capability err
 '
 
 test_expect_success 'requested command is command=value' '
@@ -118,7 +118,7 @@ test_expect_success 'requested command is command=value' '
 	0000
 	EOF
 	test_must_fail test-tool serve-v2 --stateless-rpc 2>err <in &&
-	grep invalid.command.*ls-refs=whatever err
+	test_grep invalid.command.*ls-refs=whatever err
 '
 
 test_expect_success 'wrong object-format' '
@@ -175,7 +175,7 @@ test_expect_success 'ls-refs complains about unknown options' '
 	EOF
 
 	test_must_fail test-tool serve-v2 --stateless-rpc 2>err <in &&
-	grep unexpected.line.*no-such-arg err
+	test_grep unexpected.line.*no-such-arg err
 '
 
 test_expect_success 'basic ref-prefixes' '
@@ -334,7 +334,7 @@ test_expect_success 'unexpected lines are not allowed in fetch request' '
 		cd server &&
 		test_must_fail test-tool serve-v2 --stateless-rpc
 	) <in >/dev/null 2>err &&
-	grep "unexpected line: .this-is-not-a-command." err
+	test_grep "unexpected line: .this-is-not-a-command." err
 '
 
 # Test the basics of object-info
@@ -410,7 +410,7 @@ test_expect_success 'object-info missing from capabilities when disabled' '
 		--advertise-capabilities >out &&
 	test-tool pkt-line unpack <out >actual &&
 
-	! grep object.info actual
+	test_grep ! object.info actual
 '
 
 test_expect_success 'object-info commands rejected when disabled' '
@@ -421,7 +421,7 @@ test_expect_success 'object-info commands rejected when disabled' '
 	EOF
 
 	test_must_fail test-tool serve-v2 --stateless-rpc <in 2>err &&
-	grep invalid.command err
+	test_grep invalid.command err
 '
 
 test_done
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 9f6cf4142d..74a2b7730b 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -27,9 +27,9 @@ test_expect_success 'list refs with git:// using protocol v2' '
 		ls-remote --symref "$GIT_DAEMON_URL/parent" >actual &&
 
 	# Client requested to use protocol v2
-	grep "ls-remote> .*\\\0\\\0version=2\\\0$" log &&
+	test_grep "ls-remote> .*\\\0\\\0version=2\\\0$" log &&
 	# Server responded using protocol v2
-	grep "ls-remote< version 2" log &&
+	test_grep "ls-remote< version 2" log &&
 
 	git ls-remote --symref "$GIT_DAEMON_URL/parent" >expect &&
 	test_cmp expect actual
@@ -59,9 +59,9 @@ test_expect_success 'clone with git:// using protocol v2' '
 	test_cmp expect actual &&
 
 	# Client requested to use protocol v2
-	grep "clone> .*\\\0\\\0version=2\\\0$" log &&
+	test_grep "clone> .*\\\0\\\0version=2\\\0$" log &&
 	# Server responded using protocol v2
-	grep "clone< version 2" log
+	test_grep "clone< version 2" log
 '
 
 test_expect_success 'fetch with git:// using protocol v2' '
@@ -77,9 +77,9 @@ test_expect_success 'fetch with git:// using protocol v2' '
 	test_cmp expect actual &&
 
 	# Client requested to use protocol v2
-	grep "fetch> .*\\\0\\\0version=2\\\0$" log &&
+	test_grep "fetch> .*\\\0\\\0version=2\\\0$" log &&
 	# Server responded using protocol v2
-	grep "fetch< version 2" log
+	test_grep "fetch< version 2" log
 '
 
 test_expect_success 'fetch by hash without tag following with protocol v2 does not list refs' '
@@ -91,8 +91,8 @@ test_expect_success 'fetch by hash without tag following with protocol v2 does n
 	GIT_TRACE_PACKET="$(pwd)/log" git -C daemon_child -c protocol.version=2 \
 		fetch --no-tags origin $(cat two_a_hash) &&
 
-	grep "fetch< version 2" log &&
-	! grep "fetch> command=ls-refs" log
+	test_grep "fetch< version 2" log &&
+	test_grep ! "fetch> command=ls-refs" log
 '
 
 test_expect_success 'pull with git:// using protocol v2' '
@@ -106,9 +106,9 @@ test_expect_success 'pull with git:// using protocol v2' '
 	test_cmp expect actual &&
 
 	# Client requested to use protocol v2
-	grep "fetch> .*\\\0\\\0version=2\\\0$" log &&
+	test_grep "fetch> .*\\\0\\\0version=2\\\0$" log &&
 	# Server responded using protocol v2
-	grep "fetch< version 2" log
+	test_grep "fetch< version 2" log
 '
 
 test_expect_success 'push with git:// and a config of v2 does not request v2' '
@@ -130,9 +130,9 @@ test_expect_success 'push with git:// and a config of v2 does not request v2' '
 	test_cmp expect actual &&
 
 	# Client requested to use protocol v2
-	! grep "push> .*\\\0\\\0version=2\\\0$" log &&
+	test_grep ! "push> .*\\\0\\\0version=2\\\0$" log &&
 	# Server responded using protocol v2
-	! grep "push< version 2" log
+	test_grep ! "push< version 2" log
 '
 
 stop_git_daemon
@@ -151,7 +151,7 @@ test_expect_success 'list refs with file:// using protocol v2' '
 		ls-remote --symref "file://$(pwd)/file_parent" >actual &&
 
 	# Server responded using protocol v2
-	grep "ls-remote< version 2" log &&
+	test_grep "ls-remote< version 2" log &&
 
 	git ls-remote --symref "file://$(pwd)/file_parent" >expect &&
 	test_cmp expect actual
@@ -181,8 +181,8 @@ test_expect_success 'server-options are sent when using ls-remote' '
 	EOF
 
 	test_cmp expect actual &&
-	grep "server-option=hello" log &&
-	grep "server-option=world" log
+	test_grep "server-option=hello" log &&
+	test_grep "server-option=world" log
 '
 
 test_expect_success 'server-options from configuration are used by ls-remote' '
@@ -241,12 +241,12 @@ test_expect_success 'clone with file:// using protocol v2' '
 	test_cmp expect actual &&
 
 	# Server responded using protocol v2
-	grep "clone< version 2" log &&
+	test_grep "clone< version 2" log &&
 
 	# Client sent ref-prefixes to filter the ref-advertisement
-	grep "ref-prefix HEAD" log &&
-	grep "ref-prefix refs/heads/" log &&
-	grep "ref-prefix refs/tags/" log
+	test_grep "ref-prefix HEAD" log &&
+	test_grep "ref-prefix refs/heads/" log &&
+	test_grep "ref-prefix refs/tags/" log
 '
 
 test_expect_success 'clone of empty repo propagates name of default branch' '
@@ -311,7 +311,7 @@ test_expect_success 'clone propagates unborn HEAD from non-empty repo' '
 	echo "refs/heads/mydefaultbranch" >expect &&
 	git -C file_unborn_child symbolic-ref HEAD >actual &&
 	test_cmp expect actual &&
-	grep "warning: remote HEAD refers to nonexistent ref" stderr
+	test_grep "warning: remote HEAD refers to nonexistent ref" stderr
 '
 
 test_expect_success 'clone propagates object-format from empty repo' '
@@ -343,7 +343,7 @@ test_expect_success 'bare clone propagates unborn HEAD from non-empty repo' '
 	echo "refs/heads/mydefaultbranch" >expect &&
 	git -C file_unborn_child.git symbolic-ref HEAD >actual &&
 	test_cmp expect actual &&
-	! grep "warning:" stderr
+	test_grep ! "warning:" stderr
 '
 
 test_expect_success 'defaulted HEAD uses remote branch if available' '
@@ -366,7 +366,7 @@ test_expect_success 'defaulted HEAD uses remote branch if available' '
 	git -C file_unborn_child symbolic-ref HEAD >actual &&
 	test_cmp expect actual &&
 	test_path_is_file file_unborn_child/stuff.t &&
-	! grep "warning:" stderr
+	test_grep ! "warning:" stderr
 '
 
 test_expect_success 'fetch with file:// using protocol v2' '
@@ -382,7 +382,7 @@ test_expect_success 'fetch with file:// using protocol v2' '
 	test_cmp expect actual &&
 
 	# Server responded using protocol v2
-	grep "fetch< version 2" log
+	test_grep "fetch< version 2" log
 '
 
 test_expect_success 'ref advertisement is filtered during fetch using protocol v2' '
@@ -398,8 +398,8 @@ test_expect_success 'ref advertisement is filtered during fetch using protocol v
 	git -C file_parent log -1 --format=%s >expect &&
 	test_cmp expect actual &&
 
-	grep "refs/heads/main" log &&
-	! grep "refs/heads/unwanted-branch" log
+	test_grep "refs/heads/main" log &&
+	test_grep ! "refs/heads/unwanted-branch" log
 '
 
 test_expect_success 'server-options are sent when fetching' '
@@ -414,8 +414,8 @@ test_expect_success 'server-options are sent when fetching' '
 	git -C file_parent log -1 --format=%s >expect &&
 	test_cmp expect actual &&
 
-	grep "server-option=hello" log &&
-	grep "server-option=world" log
+	test_grep "server-option=hello" log &&
+	test_grep "server-option=world" log
 '
 
 test_expect_success 'server-options are sent when fetch multiple remotes' '
@@ -485,8 +485,8 @@ test_expect_success 'server-options are sent when cloning' '
 		clone --server-option=hello --server-option=world \
 		"file://$(pwd)/file_parent" myclone &&
 
-	grep "server-option=hello" log &&
-	grep "server-option=world" log
+	test_grep "server-option=hello" log &&
+	test_grep "server-option=world" log
 '
 
 test_expect_success 'server-options from configuration are used by git-clone' '
@@ -578,12 +578,12 @@ test_expect_success 'setup filter tests' '
 test_expect_success 'partial clone' '
 	GIT_TRACE_PACKET="$(pwd)/trace" git -c protocol.version=2 \
 		clone --filter=blob:none "file://$(pwd)/server" client &&
-	grep "version 2" trace &&
+	test_grep "version 2" trace &&
 
 	# Ensure that the old version of the file is missing
 	git -C client rev-list --quiet --objects --missing=print main \
 		>observed.oids &&
-	grep "$(git -C server rev-parse message1:a.txt)" observed.oids &&
+	test_grep "$(git -C server rev-parse message1:a.txt)" observed.oids &&
 
 	# Ensure that client passes fsck
 	git -C client fsck
@@ -593,11 +593,11 @@ test_expect_success 'dynamically fetch missing object' '
 	rm "$(pwd)/trace" &&
 	GIT_TRACE_PACKET="$(pwd)/trace" git -C client -c protocol.version=2 \
 		cat-file -p $(git -C server rev-parse message1:a.txt) &&
-	grep "version 2" trace
+	test_grep "version 2" trace
 '
 
 test_expect_success 'when dynamically fetching missing object, do not list refs' '
-	! grep "git> command=ls-refs" trace
+	test_grep ! "git> command=ls-refs" trace
 '
 
 test_expect_success 'partial fetch' '
@@ -607,12 +607,12 @@ test_expect_success 'partial fetch' '
 
 	GIT_TRACE_PACKET="$(pwd)/trace" git -C client -c protocol.version=2 \
 		fetch --filter=blob:none "$SERVER" main:refs/heads/other &&
-	grep "version 2" trace &&
+	test_grep "version 2" trace &&
 
 	# Ensure that the old version of the file is missing
 	git -C client rev-list --quiet --objects --missing=print other \
 		>observed.oids &&
-	grep "$(git -C server rev-parse message1:a.txt)" observed.oids &&
+	test_grep "$(git -C server rev-parse message1:a.txt)" observed.oids &&
 
 	# Ensure that client passes fsck
 	git -C client fsck
@@ -625,14 +625,14 @@ test_expect_success 'do not advertise filter if not configured to do so' '
 	git -C server config uploadpack.allowfilter 1 &&
 	GIT_TRACE_PACKET="$(pwd)/trace" git -c protocol.version=2 \
 		ls-remote "$SERVER" &&
-	grep "fetch=.*filter" trace &&
+	test_grep "fetch=.*filter" trace &&
 
 	rm "$(pwd)/trace" &&
 	git -C server config uploadpack.allowfilter 0 &&
 	GIT_TRACE_PACKET="$(pwd)/trace" git -c protocol.version=2 \
 		ls-remote "$SERVER" &&
 	grep "fetch=" trace >fetch_capabilities &&
-	! grep filter fetch_capabilities
+	test_grep ! filter fetch_capabilities
 '
 
 test_expect_success 'partial clone warns if filter is not advertised' '
@@ -658,7 +658,7 @@ test_expect_success 'even with handcrafted request, filter does not work if not
 
 	test_must_fail test-tool -C server serve-v2 --stateless-rpc \
 		<in >/dev/null 2>err &&
-	grep "unexpected line: .filter blob:none." err &&
+	test_grep "unexpected line: .filter blob:none." err &&
 
 	# Exercise to ensure that if advertised, filter works
 	git -C server config uploadpack.allowfilter 1 &&
@@ -675,8 +675,8 @@ test_expect_success 'default refspec is used to filter ref when fetching' '
 	git -C file_parent log -1 --format=%s three >expect &&
 	test_cmp expect actual &&
 
-	grep "ref-prefix refs/heads/" log &&
-	grep "ref-prefix refs/tags/" log
+	test_grep "ref-prefix refs/heads/" log &&
+	test_grep "ref-prefix refs/tags/" log
 '
 
 test_expect_success 'set up parent for prefix tests' '
@@ -750,9 +750,9 @@ test_expect_success 'fetch supports various ways of have lines' '
 		"$(git -C server rev-parse fetch-by-sha1)" &&
 
 	# Ensure that the appropriate prefixes are sent (using a sample)
-	grep "fetch> ref-prefix dwim" trace &&
-	grep "fetch> ref-prefix refs/heads/dwim" trace &&
-	grep "fetch> ref-prefix refs/tags/prefix" trace &&
+	test_grep "fetch> ref-prefix dwim" trace &&
+	test_grep "fetch> ref-prefix refs/heads/dwim" trace &&
+	test_grep "fetch> ref-prefix refs/tags/prefix" trace &&
 
 	# Ensure that the correct objects are returned
 	git -C client cat-file -e $(git -C server rev-parse dwim) &&
@@ -779,9 +779,9 @@ test_expect_success 'fetch supports include-tag and tag following' '
 	GIT_TRACE_PACKET="$(pwd)/trace" git -C client -c protocol.version=2 \
 		fetch "$(pwd)/server" to_fetch:to_fetch &&
 
-	grep "fetch> ref-prefix to_fetch" trace &&
-	grep "fetch> ref-prefix refs/tags/" trace &&
-	grep "fetch> include-tag" trace &&
+	test_grep "fetch> ref-prefix to_fetch" trace &&
+	test_grep "fetch> ref-prefix refs/tags/" trace &&
+	test_grep "fetch> include-tag" trace &&
 
 	git -C client cat-file -e $(git -C client rev-parse annotated_tag)
 '
@@ -805,7 +805,7 @@ test_expect_success 'upload-pack respects client shallows' '
 	GIT_TRACE_PACKET="$(pwd)/trace" git -C client -c protocol.version=2 \
 		fetch origin newbranch &&
 	# Ensure that protocol v2 is used
-	grep "fetch< version 2" trace
+	test_grep "fetch< version 2" trace
 '
 
 test_expect_success 'ensure that multiple fetches in same process from a shallow repo works' '
@@ -823,7 +823,7 @@ test_expect_success 'ensure that multiple fetches in same process from a shallow
 	GIT_TRACE_PACKET="$(pwd)/trace" git -C client -c protocol.version=2 \
 		fetch --shallow-exclude one origin &&
 	# Ensure that protocol v2 is used
-	grep "fetch< version 2" trace
+	test_grep "fetch< version 2" trace
 '
 
 test_expect_success 'deepen-relative' '
@@ -844,7 +844,7 @@ test_expect_success 'deepen-relative' '
 	GIT_TRACE_PACKET="$(pwd)/trace" git -C client -c protocol.version=2 \
 		fetch --deepen=1 origin &&
 	# Ensure that protocol v2 is used
-	grep "fetch< version 2" trace &&
+	test_grep "fetch< version 2" trace &&
 
 	git -C client log --pretty=tformat:%s origin/main >actual &&
 	cat >expected <<-\EOF &&
@@ -909,7 +909,7 @@ test_expect_success 'file:// --negotiate-only' '
 		--negotiation-tip=$(git -C client rev-parse HEAD) \
 		origin >out &&
 	COMMON=$(git -C "$SERVER" rev-parse two) &&
-	grep "$COMMON" out
+	test_grep "$COMMON" out
 '
 
 test_expect_success 'file:// --negotiate-only with protocol v0' '
@@ -932,7 +932,7 @@ test_expect_success 'push with custom path does not request v2' '
 		--receive-pack="env >../env.trace; git-receive-pack" \
 		origin HEAD:refs/heads/custom-push-test &&
 	test_path_is_file env.trace &&
-	! grep ^GIT_PROTOCOL env.trace
+	test_grep ! ^GIT_PROTOCOL env.trace
 '
 
 test_expect_success 'fetch with custom path does request v2' '
@@ -940,7 +940,7 @@ test_expect_success 'fetch with custom path does request v2' '
 	git -C client fetch \
 		--upload-pack="env >../env.trace; git-upload-pack" \
 		origin HEAD &&
-	grep ^GIT_PROTOCOL=version=2 env.trace
+	test_grep ^GIT_PROTOCOL=version=2 env.trace
 '
 
 test_expect_success 'archive with custom path does not request v2' '
@@ -950,7 +950,7 @@ test_expect_success 'archive with custom path does not request v2' '
 		--remote=origin \
 		HEAD >/dev/null &&
 	test_path_is_file env.trace &&
-	! grep ^GIT_PROTOCOL env.trace
+	test_grep ! ^GIT_PROTOCOL env.trace
 '
 
 test_expect_success 'reject client packfile-uris if not advertised' '
@@ -994,11 +994,11 @@ test_expect_success 'clone with http:// using protocol v2' '
 	test_cmp expect actual &&
 
 	# Client requested to use protocol v2
-	grep "Git-Protocol: version=2" log &&
+	test_grep "Git-Protocol: version=2" log &&
 	# Server responded using protocol v2
-	grep "git< version 2" log &&
+	test_grep "git< version 2" log &&
 	# Verify that the chunked encoding sending codepath is NOT exercised
-	! grep "Send header: Transfer-Encoding: chunked" log
+	test_grep ! "Send header: Transfer-Encoding: chunked" log
 '
 
 test_expect_success 'clone repository with http:// using protocol v2 with incomplete pktline length' '
@@ -1011,9 +1011,9 @@ test_expect_success 'clone repository with http:// using protocol v2 with incomp
 		clone "$HTTPD_URL/smart/incomplete_length" incomplete_length_child 2>err &&
 
 	# Client requested to use protocol v2
-	grep "Git-Protocol: version=2" log &&
+	test_grep "Git-Protocol: version=2" log &&
 	# Server responded using protocol v2
-	grep "git< version 2" log &&
+	test_grep "git< version 2" log &&
 	# Client reported appropriate failure
 	test_grep "bytes of length header were received" err
 '
@@ -1028,9 +1028,9 @@ test_expect_success 'clone repository with http:// using protocol v2 with incomp
 		clone "$HTTPD_URL/smart/incomplete_body" incomplete_body_child 2>err &&
 
 	# Client requested to use protocol v2
-	grep "Git-Protocol: version=2" log &&
+	test_grep "Git-Protocol: version=2" log &&
 	# Server responded using protocol v2
-	grep "git< version 2" log &&
+	test_grep "git< version 2" log &&
 	# Client reported appropriate failure
 	test_grep "bytes of body are still expected" err
 '
@@ -1043,9 +1043,9 @@ test_expect_success 'clone with http:// using protocol v2 and invalid parameters
 		clone --shallow-since=20151012 "$HTTPD_URL/smart/http_parent" http_child_invalid &&
 
 	# Client requested to use protocol v2
-	grep "Git-Protocol: version=2" log &&
+	test_grep "Git-Protocol: version=2" log &&
 	# Server responded using protocol v2
-	grep "git< version 2" log
+	test_grep "git< version 2" log
 '
 
 test_expect_success 'clone big repository with http:// using protocol v2' '
@@ -1070,11 +1070,11 @@ test_expect_success 'clone big repository with http:// using protocol v2' '
 		clone "$HTTPD_URL/smart/big" big_child &&
 
 	# Client requested to use protocol v2
-	grep "Git-Protocol: version=2" log &&
+	test_grep "Git-Protocol: version=2" log &&
 	# Server responded using protocol v2
-	grep "git< version 2" log &&
+	test_grep "git< version 2" log &&
 	# Verify that the chunked encoding sending codepath is exercised
-	grep "Send header: Transfer-Encoding: chunked" log
+	test_grep "Send header: Transfer-Encoding: chunked" log
 '
 
 test_expect_success 'fetch with http:// using protocol v2' '
@@ -1090,7 +1090,7 @@ test_expect_success 'fetch with http:// using protocol v2' '
 	test_cmp expect actual &&
 
 	# Server responded using protocol v2
-	grep "git< version 2" log
+	test_grep "git< version 2" log
 '
 
 test_expect_success 'fetch with http:// by hash without tag following with protocol v2 does not list refs' '
@@ -1102,8 +1102,8 @@ test_expect_success 'fetch with http:// by hash without tag following with proto
 	GIT_TRACE_PACKET="$(pwd)/log" git -C http_child -c protocol.version=2 \
 		fetch --no-tags origin $(cat two_a_hash) &&
 
-	grep "fetch< version 2" log &&
-	! grep "fetch> command=ls-refs" log
+	test_grep "fetch< version 2" log &&
+	test_grep ! "fetch> command=ls-refs" log
 '
 
 test_expect_success 'fetch from namespaced repo respects namespaces' '
@@ -1120,7 +1120,7 @@ test_expect_success 'fetch from namespaced repo respects namespaces' '
 		refs/heads/main:refs/heads/theirs &&
 
 	# Server responded using protocol v2
-	grep "fetch< version 2" log &&
+	test_grep "fetch< version 2" log &&
 
 	git -C "$HTTPD_DOCUMENT_ROOT_PATH/nsrepo" rev-parse one >expect &&
 	git -C http_child rev-parse theirs >actual &&
@@ -1157,9 +1157,9 @@ test_expect_success 'push with http:// and a config of v2 does not request v2' '
 	test_cmp expect actual &&
 
 	# Client did not request to use protocol v2
-	! grep "Git-Protocol: version=2" log &&
+	test_grep ! "Git-Protocol: version=2" log &&
 	# Server did not respond using protocol v2
-	! grep "git< version 2" log
+	test_grep ! "git< version 2" log
 '
 
 test_expect_success 'when server sends "ready", expect DELIM' '
@@ -1207,8 +1207,8 @@ test_expect_success 'when server does not send "ready", expect FLUSH' '
 	test_must_fail env GIT_TRACE_PACKET="$(pwd)/log" git -C http_child \
 		-c protocol.version=2 \
 		fetch "$HTTPD_URL/one_time_script/http_parent" 2> err &&
-	grep "fetch< .*acknowledgments" log &&
-	! grep "fetch< .*ready" log &&
+	test_grep "fetch< .*acknowledgments" log &&
+	test_grep ! "fetch< .*ready" log &&
 	test_grep "expected no other sections to be sent after no .ready." err
 '
 
@@ -1247,7 +1247,7 @@ test_expect_success 'part of packfile response provided as URI' '
 	do
 		git verify-pack --object-format=$(test_oid algo) --verbose $idx >out &&
 		{
-			grep -E "^[0-9a-f]{16,} " out || :
+			grep -E "^[0-9a-f]{16,} " out || : # lint-ok: data filter
 		} >out.objectlist &&
 		if test_line_count = 1 out.objectlist
 		then
@@ -1446,7 +1446,7 @@ test_expect_success 'packfile-uri path redacted in trace' '
 		-c fetch.uriprotocols=http,https \
 		clone "$HTTPD_URL/smart/http_parent" http_child &&
 
-	grep -F "clone< \\1$(cat packh) $HTTPD_URL/<redacted>" log
+	test_grep -F "clone< \\1$(cat packh) $HTTPD_URL/<redacted>" log
 '
 
 test_expect_success 'packfile-uri path not redacted in trace when GIT_TRACE_REDACT=0' '
@@ -1472,7 +1472,7 @@ test_expect_success 'packfile-uri path not redacted in trace when GIT_TRACE_REDA
 		-c fetch.uriprotocols=http,https \
 		clone "$HTTPD_URL/smart/http_parent" http_child &&
 
-	grep -F "clone< \\1$(cat packh) $HTTPD_URL/dumb/mypack-$(cat packh).pack" log
+	test_grep -F "clone< \\1$(cat packh) $HTTPD_URL/dumb/mypack-$(cat packh).pack" log
 '
 
 test_expect_success 'http:// --negotiate-only' '
@@ -1487,7 +1487,7 @@ test_expect_success 'http:// --negotiate-only' '
 		--negotiation-tip=$(git -C client rev-parse HEAD) \
 		origin >out &&
 	COMMON=$(git -C "$SERVER" rev-parse two) &&
-	grep "$COMMON" out
+	test_grep "$COMMON" out
 '
 
 test_expect_success 'http:// --negotiate-only without wait-for-done support' '
diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index 249137b467..330d049b2c 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -101,7 +101,7 @@ test_expect_success 'invalid want-ref line' '
 
 	test-tool pkt-line pack <pkt >in &&
 	test_must_fail test-tool serve-v2 --stateless-rpc 2>out <in &&
-	grep "unknown ref" out
+	test_grep "unknown ref" out
 '
 
 test_expect_success 'basic want-ref' '
@@ -235,11 +235,11 @@ test_expect_success 'fetching with exact OID' '
 		git -C local fetch origin \
 		"$oid":refs/heads/actual &&
 
-	grep \"key\":\"total_rounds\",\"value\":\"2\" trace2 &&
+	test_grep \"key\":\"total_rounds\",\"value\":\"2\" trace2 &&
 	git -C "$REPO" rev-parse "d" >expected &&
 	git -C local rev-parse refs/heads/actual >actual &&
 	test_cmp expected actual &&
-	grep "want $oid" log
+	test_grep "want $oid" log
 '
 
 test_expect_success 'fetching multiple refs' '
@@ -252,8 +252,8 @@ test_expect_success 'fetching multiple refs' '
 	git -C "$REPO" rev-parse "main" "baz" >expected &&
 	git -C local rev-parse refs/remotes/origin/main refs/remotes/origin/baz >actual &&
 	test_cmp expected actual &&
-	grep "want-ref refs/heads/main" log &&
-	grep "want-ref refs/heads/baz" log
+	test_grep "want-ref refs/heads/main" log &&
+	test_grep "want-ref refs/heads/baz" log
 '
 
 test_expect_success 'fetching ref and exact OID' '
@@ -268,8 +268,8 @@ test_expect_success 'fetching ref and exact OID' '
 	git -C "$REPO" rev-parse "main" "b" >expected &&
 	git -C local rev-parse refs/remotes/origin/main refs/heads/actual >actual &&
 	test_cmp expected actual &&
-	grep "want $oid" log &&
-	grep "want-ref refs/heads/main" log
+	test_grep "want $oid" log &&
+	test_grep "want-ref refs/heads/main" log
 '
 
 test_expect_success 'fetching with wildcard that does not match any refs' '
@@ -291,8 +291,8 @@ test_expect_success 'fetching with wildcard that matches multiple refs' '
 	git -C "$REPO" rev-parse "o/foo" "o/bar" >expected &&
 	git -C local rev-parse "o/foo" "o/bar" >actual &&
 	test_cmp expected actual &&
-	grep "want-ref refs/heads/o/foo" log &&
-	grep "want-ref refs/heads/o/bar" log
+	test_grep "want-ref refs/heads/o/foo" log &&
+	test_grep "want-ref refs/heads/o/bar" log
 '
 
 REPO="$(pwd)/repo-ns"
@@ -345,7 +345,7 @@ test_expect_success 'with namespace: want-ref outside namespace is unknown' '
 
 	test_must_fail env GIT_NAMESPACE=ns \
 		test-tool -C "$REPO" serve-v2 --stateless-rpc >out <in &&
-	grep "unknown ref" out
+	test_grep "unknown ref" out
 '
 
 # Cross-check refs/heads/ns-no indeed exists
@@ -381,7 +381,7 @@ test_expect_success 'with namespace: hideRefs is matched, relative to namespace'
 
 	test_must_fail env GIT_NAMESPACE=ns \
 		test-tool -C "$REPO" serve-v2 --stateless-rpc >out <in &&
-	grep "unknown ref" out
+	test_grep "unknown ref" out
 '
 
 # Cross-check refs/heads/hidden indeed exists
diff --git a/t/t5705-session-id-in-capabilities.sh b/t/t5705-session-id-in-capabilities.sh
index ed38c76c29..ef0db57d1f 100755
--- a/t/t5705-session-id-in-capabilities.sh
+++ b/t/t5705-session-id-in-capabilities.sh
@@ -55,8 +55,8 @@ do
 		git -c protocol.version=$PROTO -C local fetch \
 			--upload-pack "GIT_TRACE2_EVENT=\"$(pwd)/tr2-server-events\" git-upload-pack" \
 			origin &&
-		grep \"key\":\"server-sid\" tr2-client-events &&
-		grep \"key\":\"client-sid\" tr2-server-events
+		test_grep \"key\":\"server-sid\" tr2-client-events &&
+		test_grep \"key\":\"client-sid\" tr2-server-events
 	'
 
 	test_expect_success "session IDs advertised (push v${PROTO})" '
@@ -68,8 +68,8 @@ do
 		git -c protocol.version=$PROTO -C local push \
 			--receive-pack "GIT_TRACE2_EVENT=\"$(pwd)/tr2-server-events\" git-receive-pack" \
 			origin HEAD:new-branch &&
-		grep \"key\":\"server-sid\" tr2-client-events &&
-		grep \"key\":\"client-sid\" tr2-server-events
+		test_grep \"key\":\"server-sid\" tr2-client-events &&
+		test_grep \"key\":\"client-sid\" tr2-server-events
 	'
 
 	test_expect_success "client & server log negotiated version (v${PROTO})" '
@@ -79,8 +79,8 @@ do
 		git -c protocol.version=$PROTO -C local fetch \
 			--upload-pack "GIT_TRACE2_EVENT=\"$(pwd)/tr2-server-events\" git-upload-pack" \
 			origin &&
-		grep \"key\":\"negotiated-version\",\"value\":\"$PROTO\" tr2-client-events &&
-		grep \"key\":\"negotiated-version\",\"value\":\"$PROTO\" tr2-server-events
+		test_grep \"key\":\"negotiated-version\",\"value\":\"$PROTO\" tr2-client-events &&
+		test_grep \"key\":\"negotiated-version\",\"value\":\"$PROTO\" tr2-server-events
 	'
 done
 
diff --git a/t/t5750-bundle-uri-parse.sh b/t/t5750-bundle-uri-parse.sh
index 294f9d9c64..70ae94c4d0 100755
--- a/t/t5750-bundle-uri-parse.sh
+++ b/t/t5750-bundle-uri-parse.sh
@@ -78,7 +78,7 @@ test_expect_success 'bundle_uri_parse_line(): relative URIs and parent paths' '
 	# now until the interface for relative_url() allows for reporting
 	# an error instead of die()ing.
 	test_must_fail test-tool bundle-uri parse-key-values in >actual 2>err &&
-	grep "fatal: cannot strip one component off url" err
+	test_grep "fatal: cannot strip one component off url" err
 '
 
 test_expect_success 'bundle_uri_parse_line() parsing edge cases: empty key or value' '
@@ -283,7 +283,7 @@ test_expect_success 'parse config format edge cases: creationToken heuristic' '
 	EOF
 
 	test-tool bundle-uri parse-config expect >actual 2>err &&
-	grep "could not parse bundle list key creationToken with value '\''bogus'\''" err
+	test_grep "could not parse bundle list key creationToken with value '\''bogus'\''" err
 '
 
 test_expect_success 'parse config format: bundle with missing uri' '
@@ -296,7 +296,7 @@ test_expect_success 'parse config format: bundle with missing uri' '
 	EOF
 
 	test_must_fail test-tool bundle-uri parse-config input 2>err &&
-	grep "bundle '\''missing-uri'\'' has no uri" err
+	test_grep "bundle '\''missing-uri'\'' has no uri" err
 '
 
 test_expect_success 'parse config format: bundle with url instead of uri' '
@@ -309,7 +309,7 @@ test_expect_success 'parse config format: bundle with url instead of uri' '
 	EOF
 
 	test_must_fail test-tool bundle-uri parse-config input 2>err &&
-	grep "bundle '\''typo'\'' has no uri" err
+	test_grep "bundle '\''typo'\'' has no uri" err
 '
 
 test_done
diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index d21877150e..5fafc857b8 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -306,7 +306,7 @@ test_expect_success 'push messages' '
 	echo new >>file &&
 	git commit -a -m new &&
 	git push origin new_branch 2> msg &&
-	! grep "\[new branch\]" msg
+	test_grep ! "\[new branch\]" msg
 	)
 '
 
@@ -352,7 +352,7 @@ test_expect_success 'totally broken helper reports failure message' '
 	test_must_fail \
 		env PATH="$PWD:$PATH" \
 		git clone broken://example.com/foo.git 2>stderr &&
-	grep aborted stderr
+	test_grep aborted stderr
 '
 
 test_done
diff --git a/t/t5810-proto-disable-local.sh b/t/t5810-proto-disable-local.sh
index 96a2c46e7a..cb3b13f8d3 100755
--- a/t/t5810-proto-disable-local.sh
+++ b/t/t5810-proto-disable-local.sh
@@ -28,7 +28,7 @@ test_expect_success 'setup repo with dash' '
 test_expect_success 'repo names starting with dash are rejected' '
 	rm -f trace.out &&
 	test_must_fail env GIT_TRACE="$PWD/trace.out" git fetch -- -repo.git &&
-	! grep upload-pack trace.out
+	test_grep ! upload-pack trace.out
 '
 
 test_expect_success 'full paths still work' '
diff --git a/t/t5813-proto-disable-ssh.sh b/t/t5813-proto-disable-ssh.sh
index 045e2fe6ce..1800d27f89 100755
--- a/t/t5813-proto-disable-ssh.sh
+++ b/t/t5813-proto-disable-ssh.sh
@@ -24,7 +24,7 @@ test_proto "git+ssh://" ssh "git+ssh://remote$PWD/remote/repo.git"
 # simply confirm from its output that it did not run at all.
 test_expect_success 'hostnames starting with dash are rejected' '
 	test_must_fail git clone ssh://-remote/repo.git dash-host 2>stderr &&
-	! grep ^ssh: stderr
+	test_grep ! ^ssh: stderr
 '
 
 test_expect_success 'setup repo with dash' '
@@ -34,7 +34,7 @@ test_expect_success 'setup repo with dash' '
 
 test_expect_success 'repo names starting with dash are rejected' '
 	test_must_fail git clone remote:-repo.git dash-path 2>stderr &&
-	! grep ^ssh: stderr
+	test_grep ! ^ssh: stderr
 '
 
 test_expect_success 'full paths still work' '
diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
index a95ba576fa..ce968f685e 100755
--- a/t/t6000-rev-list-misc.sh
+++ b/t/t6000-rev-list-misc.sh
@@ -17,8 +17,8 @@ test_expect_success setup '
 
 test_expect_success 'rev-list --objects heeds pathspecs' '
 	git rev-list --objects HEAD -- wanted_file >output &&
-	grep wanted_file output &&
-	! grep unwanted_file output
+	test_grep wanted_file output &&
+	test_grep ! unwanted_file output
 '
 
 test_expect_success 'rev-list --objects with pathspecs and deeper paths' '
@@ -29,11 +29,11 @@ test_expect_success 'rev-list --objects with pathspecs and deeper paths' '
 	git commit -m two &&
 
 	git rev-list --objects HEAD -- foo >output &&
-	grep foo/file output &&
+	test_grep foo/file output &&
 
 	git rev-list --objects HEAD -- foo/file >output &&
-	grep foo/file output &&
-	! grep unwanted_file output
+	test_grep foo/file output &&
+	test_grep ! unwanted_file output
 '
 
 test_expect_success 'rev-list --objects with pathspecs and copied files' '
@@ -49,28 +49,28 @@ test_expect_success 'rev-list --objects with pathspecs and copied files' '
 
 	ONE=$(git rev-parse HEAD:one) &&
 	git rev-list --objects HEAD two >output &&
-	grep "$ONE two/three" output &&
-	! grep one output
+	test_grep "$ONE two/three" output &&
+	test_grep ! one output
 '
 
 test_expect_success 'rev-list --objects --no-object-names has no space/names' '
 	git rev-list --objects --no-object-names HEAD >output &&
-	! grep wanted_file output &&
-	! grep unwanted_file output &&
-	! grep " " output
+	test_grep ! wanted_file output &&
+	test_grep ! unwanted_file output &&
+	test_grep ! " " output
 '
 
 test_expect_success 'rev-list --objects --no-object-names works with cat-file' '
 	git rev-list --objects --no-object-names --all >list-output &&
 	git cat-file --batch-check <list-output >cat-output &&
-	! grep missing cat-output
+	test_grep ! missing cat-output
 '
 
 test_expect_success '--no-object-names and --object-names are last-one-wins' '
 	git rev-list --objects --no-object-names --object-names --all >output &&
-	grep wanted_file output &&
+	test_grep wanted_file output &&
 	git rev-list --objects --object-names --no-object-names --all >output &&
-	! grep wanted_file output
+	test_grep ! wanted_file output
 '
 
 test_expect_success 'rev-list A..B and rev-list ^A B are the same' '
diff --git a/t/t6005-rev-list-count.sh b/t/t6005-rev-list-count.sh
index 6cde997e13..0bef5838df 100755
--- a/t/t6005-rev-list-count.sh
+++ b/t/t6005-rev-list-count.sh
@@ -18,7 +18,7 @@ test_expect_success 'no options' '
 
 test_expect_success '--max-count' '
 	test_must_fail git rev-list --max-count=1q HEAD 2>error &&
-	grep "not an integer" error &&
+	test_grep "not an integer" error &&
 
 	test_stdout_line_count = 0 git rev-list HEAD --max-count=0 &&
 	test_stdout_line_count = 3 git rev-list HEAD --max-count=3 &&
@@ -29,10 +29,10 @@ test_expect_success '--max-count' '
 
 test_expect_success '--max-count all forms' '
 	test_must_fail git rev-list -1q HEAD 2>error &&
-	grep "not an integer" error &&
+	test_grep "not an integer" error &&
 	test_must_fail git rev-list --1 HEAD &&
 	test_must_fail git rev-list -n 1q HEAD 2>error &&
-	grep "not an integer" error &&
+	test_grep "not an integer" error &&
 
 	test_stdout_line_count = 1 git rev-list HEAD --max-count=1 &&
 	test_stdout_line_count = 1 git rev-list HEAD -1 &&
@@ -43,7 +43,7 @@ test_expect_success '--max-count all forms' '
 
 test_expect_success '--skip' '
 	test_must_fail git rev-list --skip 1q HEAD 2>error &&
-	grep "not an integer" error &&
+	test_grep "not an integer" error &&
 
 	test_stdout_line_count = 5 git rev-list HEAD --skip=0 &&
 	test_stdout_line_count = 2 git rev-list HEAD --skip=3 &&
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index 581984467d..d2648e1619 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -537,7 +537,7 @@ test_expect_success 'del LF before empty (1)' '
 test_expect_success 'del LF before empty (2)' '
 	git show -s --pretty=format:"%s%n%-b%nThanks%n" HEAD >actual &&
 	test_line_count = 6 actual &&
-	grep "^$" actual
+	test_grep "^$" actual
 '
 
 test_expect_success 'add LF before non-empty (1)' '
@@ -548,7 +548,7 @@ test_expect_success 'add LF before non-empty (1)' '
 test_expect_success 'add LF before non-empty (2)' '
 	git show -s --pretty=format:"%s%+b%nThanks%n" HEAD >actual &&
 	test_line_count = 6 actual &&
-	grep "^$" actual
+	test_grep "^$" actual
 '
 
 test_expect_success 'add SP before non-empty (1)' '
diff --git a/t/t6009-rev-list-parent.sh b/t/t6009-rev-list-parent.sh
index 9c9a8459af..fd6ee2eff8 100755
--- a/t/t6009-rev-list-parent.sh
+++ b/t/t6009-rev-list-parent.sh
@@ -64,10 +64,10 @@ test_expect_success 'setup roots, merges and octopuses' '
 
 test_expect_success 'parse --max-parents & --min-parents' '
 	test_must_fail git rev-list --max-parents=1q HEAD 2>error &&
-	grep "not an integer" error &&
+	test_grep "not an integer" error &&
 
 	test_must_fail git rev-list --min-parents=1q HEAD 2>error &&
-	grep "not an integer" error &&
+	test_grep "not an integer" error &&
 
 	git rev-list --max-parents=1 --min-parents=1 HEAD &&
 	git rev-list --max-parents=-1 --min-parents=-1 HEAD
diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index 500c81b8a1..939d4214f4 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -612,7 +612,7 @@ test_expect_success 'cloning from filtered bundle has useful error' '
 		--all \
 		--filter=blob:none &&
 	test_must_fail git clone --bare partial.bdl partial 2>err &&
-	grep "cannot clone from filtered bundle" err
+	test_grep "cannot clone from filtered bundle" err
 '
 
 test_expect_success 'verify catches unreachable, broken prerequisites' '
@@ -644,13 +644,13 @@ test_expect_success 'verify catches unreachable, broken prerequisites' '
 		# Verify should fail
 		test_must_fail git bundle verify \
 			../clone-from/tip.bundle 2>err &&
-		grep "some prerequisite commits .* are not connected" err &&
+		test_grep "some prerequisite commits .* are not connected" err &&
 		test_line_count = 1 err &&
 
 		# Unbundling should fail
 		test_must_fail git bundle unbundle \
 			../clone-from/tip.bundle 2>err &&
-		grep "some prerequisite commits .* are not connected" err &&
+		test_grep "some prerequisite commits .* are not connected" err &&
 		test_line_count = 1 err
 	)
 '
@@ -658,7 +658,7 @@ test_expect_success 'verify catches unreachable, broken prerequisites' '
 test_expect_success 'bundle progress includes write phase' '
 	GIT_PROGRESS_DELAY=0 \
 		git bundle create --progress out.bundle --all 2>err &&
-	grep 'Writing' err
+	test_grep 'Writing' err
 '
 
 test_expect_success TTY 'create --quiet disables all bundle progress' '
@@ -670,7 +670,7 @@ test_expect_success TTY 'create --quiet disables all bundle progress' '
 test_expect_success 'bundle progress with --no-quiet' '
 	GIT_PROGRESS_DELAY=0 \
 		git bundle create --no-quiet out.bundle --all 2>err &&
-	grep "%" err
+	test_grep "%" err
 '
 
 test_expect_success 'create bundle with duplicate refnames' '
@@ -730,7 +730,7 @@ test_expect_success 'read bundle over stdin' '
 	git bundle create some.bundle HEAD &&
 
 	git bundle verify - <some.bundle 2>err &&
-	grep "<stdin> is okay" err &&
+	test_grep "<stdin> is okay" err &&
 
 	git bundle list-heads some.bundle >expect &&
 	git bundle list-heads - <some.bundle >actual &&
diff --git a/t/t6022-rev-list-missing.sh b/t/t6022-rev-list-missing.sh
index 08e92dd002..1e472a45af 100755
--- a/t/t6022-rev-list-missing.sh
+++ b/t/t6022-rev-list-missing.sh
@@ -68,7 +68,7 @@ do
 			allow-any)
 				;;
 			print)
-				grep ?$oid actual.raw &&
+				test_grep ?$oid actual.raw &&
 				echo ?$oid >>expect.raw
 				;;
 			esac &&
@@ -132,7 +132,7 @@ do
 				allow-any)
 					;;
 				print)
-					grep ?$oid actual.raw &&
+					test_grep ?$oid actual.raw &&
 					echo ?$oid >>expect.raw
 					;;
 				esac &&
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 081116220a..338df4f886 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -118,8 +118,8 @@ test_expect_success 'bisect fails if given any junk instead of revs' '
 test_expect_success 'bisect start without -- takes unknown arg as pathspec' '
 	git bisect reset &&
 	git bisect start foo bar &&
-	grep foo ".git/BISECT_NAMES" &&
-	grep bar ".git/BISECT_NAMES"
+	test_grep foo ".git/BISECT_NAMES" &&
+	test_grep bar ".git/BISECT_NAMES"
 '
 
 test_expect_success 'bisect reset: back in a branch checked out also elsewhere' '
@@ -258,7 +258,7 @@ test_expect_success 'bisect skip: successful result' '
 	git bisect start $HASH4 $HASH1 &&
 	git bisect skip &&
 	git bisect bad > my_bisect_log.txt &&
-	grep "$HASH2 is the first '\''bad'\'' commit" my_bisect_log.txt
+	test_grep "$HASH2 is the first '\''bad'\'' commit" my_bisect_log.txt
 '
 
 # $HASH1 is good, $HASH4 is bad, we skip $HASH3 and $HASH2
@@ -269,11 +269,11 @@ test_expect_success 'bisect skip: cannot tell between 3 commits' '
 	git bisect start $HASH4 $HASH1 &&
 	git bisect skip &&
 	test_expect_code 2 git bisect skip >my_bisect_log.txt &&
-	grep "first '\''bad'\'' commit could be any of" my_bisect_log.txt &&
-	! grep $HASH1 my_bisect_log.txt &&
-	grep $HASH2 my_bisect_log.txt &&
-	grep $HASH3 my_bisect_log.txt &&
-	grep $HASH4 my_bisect_log.txt
+	test_grep "first '\''bad'\'' commit could be any of" my_bisect_log.txt &&
+	test_grep ! $HASH1 my_bisect_log.txt &&
+	test_grep $HASH2 my_bisect_log.txt &&
+	test_grep $HASH3 my_bisect_log.txt &&
+	test_grep $HASH4 my_bisect_log.txt
 '
 
 # $HASH1 is good, $HASH4 is bad, we skip $HASH3
@@ -285,11 +285,11 @@ test_expect_success 'bisect skip: cannot tell between 2 commits' '
 	git bisect start $HASH4 $HASH1 &&
 	git bisect skip &&
 	test_expect_code 2 git bisect good >my_bisect_log.txt &&
-	grep "first '\''bad'\'' commit could be any of" my_bisect_log.txt &&
-	! grep $HASH1 my_bisect_log.txt &&
-	! grep $HASH2 my_bisect_log.txt &&
-	grep $HASH3 my_bisect_log.txt &&
-	grep $HASH4 my_bisect_log.txt
+	test_grep "first '\''bad'\'' commit could be any of" my_bisect_log.txt &&
+	test_grep ! $HASH1 my_bisect_log.txt &&
+	test_grep ! $HASH2 my_bisect_log.txt &&
+	test_grep $HASH3 my_bisect_log.txt &&
+	test_grep $HASH4 my_bisect_log.txt
 '
 
 # $HASH1 is good, $HASH4 is both skipped and bad, we skip $HASH3
@@ -304,11 +304,11 @@ test_expect_success 'bisect skip: with commit both bad and skipped' '
 	git bisect good $HASH1 &&
 	git bisect skip &&
 	test_expect_code 2 git bisect good >my_bisect_log.txt &&
-	grep "first '\''bad'\'' commit could be any of" my_bisect_log.txt &&
-	! grep $HASH1 my_bisect_log.txt &&
-	! grep $HASH2 my_bisect_log.txt &&
-	grep $HASH3 my_bisect_log.txt &&
-	grep $HASH4 my_bisect_log.txt
+	test_grep "first '\''bad'\'' commit could be any of" my_bisect_log.txt &&
+	test_grep ! $HASH1 my_bisect_log.txt &&
+	test_grep ! $HASH2 my_bisect_log.txt &&
+	test_grep $HASH3 my_bisect_log.txt &&
+	test_grep $HASH4 my_bisect_log.txt
 '
 
 test_bisect_run_args () {
@@ -439,7 +439,7 @@ test_expect_success '"git bisect run" simple case' '
 	git bisect good $HASH1 &&
 	git bisect bad $HASH4 &&
 	git bisect run ./test_script.sh >my_bisect_log.txt &&
-	grep "$HASH3 is the first '\''bad'\'' commit" my_bisect_log.txt &&
+	test_grep "$HASH3 is the first '\''bad'\'' commit" my_bisect_log.txt &&
 	git bisect reset
 '
 
@@ -449,7 +449,7 @@ test_expect_success '"git bisect run" simple case' '
 	git bisect good $HASH1 &&
 	git bisect bad $HASH4 &&
 	git bisect run printf "%s %s\n" reset --bisect-skip >my_bisect_log.txt &&
-	grep -e "reset --bisect-skip" my_bisect_log.txt &&
+	test_grep -e "reset --bisect-skip" my_bisect_log.txt &&
 	git bisect reset
 '
 
@@ -461,7 +461,7 @@ test_expect_success '"git bisect run" with more complex "git bisect start"' '
 	EOF
 	git bisect start $HASH4 $HASH1 &&
 	git bisect run ./test_script.sh >my_bisect_log.txt &&
-	grep "$HASH4 is the first '\''bad'\'' commit" my_bisect_log.txt &&
+	test_grep "$HASH4 is the first '\''bad'\'' commit" my_bisect_log.txt &&
 	git bisect reset
 '
 
@@ -474,7 +474,7 @@ test_expect_success 'bisect run accepts exit code 126 as bad' '
 	git bisect good $HASH1 &&
 	git bisect bad $HASH4 &&
 	git bisect run ./test_script.sh >my_bisect_log.txt &&
-	grep "$HASH3 is the first '\''bad'\'' commit" my_bisect_log.txt
+	test_grep "$HASH3 is the first '\''bad'\'' commit" my_bisect_log.txt
 '
 
 test_expect_success POSIXPERM 'bisect run fails with non-executable test script' '
@@ -485,7 +485,7 @@ test_expect_success POSIXPERM 'bisect run fails with non-executable test script'
 	git bisect good $HASH1 &&
 	git bisect bad $HASH4 &&
 	test_must_fail git bisect run ./not-executable.sh >my_bisect_log.txt &&
-	! grep "is the first '\''bad'\'' commit" my_bisect_log.txt
+	test_grep ! "is the first '\''bad'\'' commit" my_bisect_log.txt
 '
 
 test_expect_success 'bisect run accepts exit code 127 as bad' '
@@ -497,7 +497,7 @@ test_expect_success 'bisect run accepts exit code 127 as bad' '
 	git bisect good $HASH1 &&
 	git bisect bad $HASH4 &&
 	git bisect run ./test_script.sh >my_bisect_log.txt &&
-	grep "$HASH3 is the first '\''bad'\'' commit" my_bisect_log.txt
+	test_grep "$HASH3 is the first '\''bad'\'' commit" my_bisect_log.txt
 '
 
 test_expect_success 'bisect run fails with missing test script' '
@@ -507,7 +507,7 @@ test_expect_success 'bisect run fails with missing test script' '
 	git bisect good $HASH1 &&
 	git bisect bad $HASH4 &&
 	test_must_fail git bisect run ./does-not-exist.sh >my_bisect_log.txt &&
-	! grep "is the first '\''bad'\'' commit" my_bisect_log.txt
+	test_grep ! "is the first '\''bad'\'' commit" my_bisect_log.txt
 '
 
 # $HASH1 is good, $HASH5 is bad, we skip $HASH3
@@ -520,14 +520,14 @@ test_expect_success 'bisect skip: add line and then a new test' '
 	git bisect start $HASH5 $HASH1 &&
 	git bisect skip &&
 	git bisect good > my_bisect_log.txt &&
-	grep "$HASH5 is the first '\''bad'\'' commit" my_bisect_log.txt &&
+	test_grep "$HASH5 is the first '\''bad'\'' commit" my_bisect_log.txt &&
 	git bisect log > log_to_replay.txt &&
 	git bisect reset
 '
 
 test_expect_success 'bisect skip and bisect replay' '
 	git bisect replay log_to_replay.txt > my_bisect_log.txt &&
-	grep "$HASH5 is the first '\''bad'\'' commit" my_bisect_log.txt &&
+	test_grep "$HASH5 is the first '\''bad'\'' commit" my_bisect_log.txt &&
 	git bisect reset
 '
 
@@ -541,11 +541,11 @@ test_expect_success 'bisect run & skip: cannot tell between 2' '
 	EOF
 	git bisect start $HASH6 $HASH1 &&
 	test_expect_code 2 git bisect run ./test_script.sh >my_bisect_log.txt &&
-	grep "first '\''bad'\'' commit could be any of" my_bisect_log.txt &&
-	! grep $HASH3 my_bisect_log.txt &&
-	! grep $HASH6 my_bisect_log.txt &&
-	grep $HASH4 my_bisect_log.txt &&
-	grep $HASH5 my_bisect_log.txt
+	test_grep "first '\''bad'\'' commit could be any of" my_bisect_log.txt &&
+	test_grep ! $HASH3 my_bisect_log.txt &&
+	test_grep ! $HASH6 my_bisect_log.txt &&
+	test_grep $HASH4 my_bisect_log.txt &&
+	test_grep $HASH5 my_bisect_log.txt
 '
 
 HASH7=
@@ -560,7 +560,7 @@ test_expect_success 'bisect run & skip: find first bad' '
 	EOF
 	git bisect start $HASH7 $HASH1 &&
 	git bisect run ./test_script.sh >my_bisect_log.txt &&
-	grep "$HASH6 is the first '\''bad'\'' commit" my_bisect_log.txt
+	test_grep "$HASH6 is the first '\''bad'\'' commit" my_bisect_log.txt
 '
 
 test_expect_success 'bisect skip only one range' '
@@ -569,7 +569,7 @@ test_expect_success 'bisect skip only one range' '
 	git bisect skip $HASH1..$HASH5 &&
 	test "$HASH6" = "$(git rev-parse --verify HEAD)" &&
 	test_must_fail git bisect bad > my_bisect_log.txt &&
-	grep "first '\''bad'\'' commit could be any of" my_bisect_log.txt
+	test_grep "first '\''bad'\'' commit could be any of" my_bisect_log.txt
 '
 
 test_expect_success 'bisect skip many ranges' '
@@ -578,7 +578,7 @@ test_expect_success 'bisect skip many ranges' '
 	git bisect skip $HASH2 $HASH2.. ..$HASH5 &&
 	test "$HASH6" = "$(git rev-parse --verify HEAD)" &&
 	test_must_fail git bisect bad > my_bisect_log.txt &&
-	grep "first '\''bad'\'' commit could be any of" my_bisect_log.txt
+	test_grep "first '\''bad'\'' commit could be any of" my_bisect_log.txt
 '
 
 test_expect_success 'bisect starting with a detached HEAD' '
@@ -610,7 +610,7 @@ test_expect_success 'bisect does not create a "bisect" branch' '
 	rev_hash6=$(git rev-parse --verify HEAD) &&
 	test "$rev_hash6" = "$HASH6" &&
 	git bisect good > my_bisect_log.txt &&
-	grep "$HASH7 is the first '\''bad'\'' commit" my_bisect_log.txt &&
+	test_grep "$HASH7 is the first '\''bad'\'' commit" my_bisect_log.txt &&
 	git bisect reset &&
 	rev_hash6=$(git rev-parse --verify bisect) &&
 	test "$rev_hash6" = "$HASH6" &&
@@ -637,26 +637,26 @@ test_expect_success 'side branch creation' '
 test_expect_success 'good merge base when good and bad are siblings' '
 	git bisect start "$HASH7" "$SIDE_HASH7" > my_bisect_log.txt &&
 	test_grep "merge base must be tested" my_bisect_log.txt &&
-	grep $HASH4 my_bisect_log.txt &&
+	test_grep $HASH4 my_bisect_log.txt &&
 	git bisect good > my_bisect_log.txt &&
-	! grep "merge base must be tested" my_bisect_log.txt &&
-	grep $HASH6 my_bisect_log.txt &&
+	test_grep ! "merge base must be tested" my_bisect_log.txt &&
+	test_grep $HASH6 my_bisect_log.txt &&
 	git bisect reset
 '
 test_expect_success 'skipped merge base when good and bad are siblings' '
 	git bisect start "$SIDE_HASH7" "$HASH7" > my_bisect_log.txt &&
 	test_grep "merge base must be tested" my_bisect_log.txt &&
-	grep $HASH4 my_bisect_log.txt &&
+	test_grep $HASH4 my_bisect_log.txt &&
 	git bisect skip > my_bisect_log.txt 2>&1 &&
-	grep "warning" my_bisect_log.txt &&
-	grep $SIDE_HASH6 my_bisect_log.txt &&
+	test_grep "warning" my_bisect_log.txt &&
+	test_grep $SIDE_HASH6 my_bisect_log.txt &&
 	git bisect reset
 '
 
 test_expect_success 'bad merge base when good and bad are siblings' '
 	git bisect start "$HASH7" HEAD > my_bisect_log.txt &&
 	test_grep "merge base must be tested" my_bisect_log.txt &&
-	grep $HASH4 my_bisect_log.txt &&
+	test_grep $HASH4 my_bisect_log.txt &&
 	test_must_fail git bisect bad > my_bisect_log.txt 2>&1 &&
 	test_grep "merge base $HASH4 is bad" my_bisect_log.txt &&
 	test_grep "fixed between $HASH4 and \[$SIDE_HASH7\]" my_bisect_log.txt &&
@@ -686,8 +686,8 @@ test_expect_success 'many merge bases creation' '
 	B_HASH=$(git rev-parse --verify HEAD) &&
 	git merge-base --all "$A_HASH" "$B_HASH" > merge_bases.txt &&
 	test_line_count = 2 merge_bases.txt &&
-	grep "$HASH5" merge_bases.txt &&
-	grep "$SIDE_HASH5" merge_bases.txt
+	test_grep "$HASH5" merge_bases.txt &&
+	test_grep "$SIDE_HASH5" merge_bases.txt
 '
 
 # We want to automatically find the merge that
@@ -703,7 +703,7 @@ test_expect_success '"git bisect run --first-parent" simple case' '
 	git bisect good $HASH4 &&
 	git bisect bad $B_HASH &&
 	git bisect run ./test_script.sh >my_bisect_log.txt &&
-	grep "$B_HASH is the first '\''bad'\'' commit" my_bisect_log.txt &&
+	test_grep "$B_HASH is the first '\''bad'\'' commit" my_bisect_log.txt &&
 	git bisect reset &&
 	test_path_is_missing .git/BISECT_FIRST_PARENT
 '
@@ -715,11 +715,11 @@ test_expect_success 'good merge bases when good and bad are siblings' '
 	test_grep "merge base must be tested" my_bisect_log2.txt &&
 	{
 		{
-			grep "$SIDE_HASH5" my_bisect_log.txt &&
-			grep "$HASH5" my_bisect_log2.txt
+			test_grep "$SIDE_HASH5" my_bisect_log.txt &&
+			test_grep "$HASH5" my_bisect_log2.txt
 		} || {
-			grep "$SIDE_HASH5" my_bisect_log2.txt &&
-			grep "$HASH5" my_bisect_log.txt
+			test_grep "$SIDE_HASH5" my_bisect_log2.txt &&
+			test_grep "$HASH5" my_bisect_log.txt
 		}
 	} &&
 	git bisect reset
@@ -728,7 +728,7 @@ test_expect_success 'good merge bases when good and bad are siblings' '
 test_expect_success 'optimized merge base checks' '
 	git bisect start "$HASH7" "$SIDE_HASH7" > my_bisect_log.txt &&
 	test_grep "merge base must be tested" my_bisect_log.txt &&
-	grep "$HASH4" my_bisect_log.txt &&
+	test_grep "$HASH4" my_bisect_log.txt &&
 	git bisect good > my_bisect_log2.txt &&
 	test -f ".git/BISECT_ANCESTORS_OK" &&
 	test "$HASH6" = $(git rev-parse --verify HEAD) &&
@@ -777,7 +777,7 @@ test_expect_success 'restricting bisection on one dir' '
 	para1=$(git rev-parse --verify HEAD) &&
 	test "$para1" = "$PARA_HASH1" &&
 	git bisect bad > my_bisect_log.txt &&
-	grep "$PARA_HASH1 is the first '\''bad'\'' commit" my_bisect_log.txt
+	test_grep "$PARA_HASH1 is the first '\''bad'\'' commit" my_bisect_log.txt
 '
 
 test_expect_success 'restricting bisection on one dir and a file' '
@@ -795,7 +795,7 @@ test_expect_success 'restricting bisection on one dir and a file' '
 	para1=$(git rev-parse --verify HEAD) &&
 	test "$para1" = "$PARA_HASH1" &&
 	git bisect good > my_bisect_log.txt &&
-	grep "$PARA_HASH4 is the first '\''bad'\'' commit" my_bisect_log.txt
+	test_grep "$PARA_HASH4 is the first '\''bad'\'' commit" my_bisect_log.txt
 '
 
 test_expect_success 'skipping away from skipped commit' '
@@ -826,7 +826,7 @@ test_expect_success 'test bisection on bare repo - --no-checkout specified' '
 			"test \$(git rev-list BISECT_HEAD ^$HASH2 --max-count=1 | wc -l) = 0" \
 			>../nocheckout.log
 	) &&
-	grep "$HASH3 is the first '\''bad'\'' commit" nocheckout.log
+	test_grep "$HASH3 is the first '\''bad'\'' commit" nocheckout.log
 '
 
 
@@ -841,7 +841,7 @@ test_expect_success 'test bisection on bare repo - --no-checkout defaulted' '
 			"test \$(git rev-list BISECT_HEAD ^$HASH2 --max-count=1 | wc -l) = 0" \
 			>../defaulted.log
 	) &&
-	grep "$HASH3 is the first '\''bad'\'' commit" defaulted.log
+	test_grep "$HASH3 is the first '\''bad'\'' commit" defaulted.log
 '
 
 #
@@ -1031,21 +1031,21 @@ test_expect_success 'bisect start with one new and old' '
 	git bisect new $HASH4 &&
 	git bisect new &&
 	git bisect new >bisect_result &&
-	grep "$HASH2 is the first '\''new'\'' commit" bisect_result &&
+	test_grep "$HASH2 is the first '\''new'\'' commit" bisect_result &&
 	git bisect log >log_to_replay.txt &&
 	git bisect reset
 '
 
 test_expect_success 'bisect replay with old and new' '
 	git bisect replay log_to_replay.txt >bisect_result &&
-	grep "$HASH2 is the first '\''new'\'' commit" bisect_result &&
+	test_grep "$HASH2 is the first '\''new'\'' commit" bisect_result &&
 	git bisect reset
 '
 
 test_expect_success 'bisect replay with CRLF log' '
 	append_cr <log_to_replay.txt >log_to_replay_crlf.txt &&
 	git bisect replay log_to_replay_crlf.txt >bisect_result_crlf &&
-	grep "$HASH2 is the first '\''new'\'' commit" bisect_result_crlf &&
+	test_grep "$HASH2 is the first '\''new'\'' commit" bisect_result_crlf &&
 	git bisect reset
 '
 
@@ -1092,16 +1092,16 @@ test_expect_success 'bisect start with one term1 and term2' '
 test_expect_success 'bogus command does not start bisect' '
 	git bisect reset &&
 	test_must_fail git bisect --bisect-terms 1 2 2>out &&
-	! grep "You need to start" out &&
+	test_grep ! "You need to start" out &&
 	test_must_fail git bisect --bisect-terms 2>out &&
-	! grep "You need to start" out &&
-	grep "git bisect.*visualize" out &&
+	test_grep ! "You need to start" out &&
+	test_grep "git bisect.*visualize" out &&
 	git bisect reset
 '
 
 test_expect_success 'bisect replay with term1 and term2' '
 	git bisect replay log_to_replay.txt >bisect_result &&
-	grep "$HASH2 is the first '\''term1'\'' commit" bisect_result &&
+	test_grep "$HASH2 is the first '\''term1'\'' commit" bisect_result &&
 	git bisect reset
 '
 
@@ -1120,7 +1120,7 @@ test_expect_success 'bisect start term1 term2' '
 	git bisect start --term-new term1 --term-old term2 $HASH4 $HASH1 &&
 	git bisect term1 &&
 	git bisect term1 >bisect_result &&
-	grep "$HASH2 is the first '\''term1'\'' commit" bisect_result &&
+	test_grep "$HASH2 is the first '\''term1'\'' commit" bisect_result &&
 	git bisect log >log_to_replay.txt &&
 	git bisect reset
 '
@@ -1212,7 +1212,7 @@ test_expect_success 'bisect handles annotated tags' '
 	git bisect good tag-one &&
 	git bisect bad tag-two >output &&
 	bad=$(git rev-parse --verify tag-two^{commit}) &&
-	grep "$bad is the first '\''bad'\'' commit" output
+	test_grep "$bad is the first '\''bad'\'' commit" output
 '
 
 test_expect_success 'bisect run fails with exit code equals or greater than 128' '
@@ -1236,29 +1236,29 @@ test_expect_success 'bisect visualize with a filename with dash and space' '
 test_expect_success 'bisect state output with multiple good commits' '
 	git bisect reset &&
 	git bisect start >output &&
-	grep "waiting for both '\''good'\'' and '\''bad'\'' commits" output &&
+	test_grep "waiting for both '\''good'\'' and '\''bad'\'' commits" output &&
 	git bisect log >output &&
-	grep "waiting for both '\''good'\'' and '\''bad'\'' commits" output &&
+	test_grep "waiting for both '\''good'\'' and '\''bad'\'' commits" output &&
 	git bisect good "$HASH1" >output &&
-	grep "waiting for '\''bad'\'' commit, 1 '\''good'\'' commit known" output &&
+	test_grep "waiting for '\''bad'\'' commit, 1 '\''good'\'' commit known" output &&
 	git bisect log >output &&
-	grep "waiting for '\''bad'\'' commit, 1 '\''good'\'' commit known" output &&
+	test_grep "waiting for '\''bad'\'' commit, 1 '\''good'\'' commit known" output &&
 	git bisect good "$HASH2" >output &&
-	grep "waiting for '\''bad'\'' commit, 2 '\''good'\'' commits known" output &&
+	test_grep "waiting for '\''bad'\'' commit, 2 '\''good'\'' commits known" output &&
 	git bisect log >output &&
-	grep "waiting for '\''bad'\'' commit, 2 '\''good'\'' commits known" output
+	test_grep "waiting for '\''bad'\'' commit, 2 '\''good'\'' commits known" output
 '
 
 test_expect_success 'bisect state output with bad commit' '
 	git bisect reset &&
 	git bisect start >output &&
-	grep "waiting for both '\''good'\'' and '\''bad'\'' commits" output &&
+	test_grep "waiting for both '\''good'\'' and '\''bad'\'' commits" output &&
 	git bisect log >output &&
-	grep "waiting for both '\''good'\'' and '\''bad'\'' commits" output &&
+	test_grep "waiting for both '\''good'\'' and '\''bad'\'' commits" output &&
 	git bisect bad "$HASH4" >output &&
-	grep -F "waiting for '\''good'\'' commit(s), '\''bad'\'' commit known" output &&
+	test_grep -F "waiting for '\''good'\'' commit(s), '\''bad'\'' commit known" output &&
 	git bisect log >output &&
-	grep -F "waiting for '\''good'\'' commit(s), '\''bad'\'' commit known" output
+	test_grep -F "waiting for '\''good'\'' commit(s), '\''bad'\'' commit known" output
 '
 
 test_expect_success 'verify correct error message' '
@@ -1268,7 +1268,7 @@ test_expect_success 'verify correct error message' '
 	rm .git/BISECT*
 	EOF
 	test_must_fail git bisect run ./test_script.sh 2>error &&
-	grep "git bisect good.*exited with error code" error
+	test_grep "git bisect good.*exited with error code" error
 '
 
 test_done
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 0242b5bf7a..ddedce5442 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -275,7 +275,7 @@ test_expect_success '--set-upstream-to does not change branch' '
 	git branch --set-upstream-to main from-topic_2 &&
 	git config branch.from-main.merge > actual &&
 	git rev-parse from-topic_2 >actual2 &&
-	grep -q "^refs/heads/main$" actual &&
+	test_grep -q "^refs/heads/main$" actual &&
 	cmp expect2 actual2
 '
 
diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
index e0a825bccf..a1c244c32d 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -45,8 +45,8 @@ test_expect_success 'specify blob explicitly prevents filtering' '
 		 awk -f print_2.awk) &&
 
 	git -C r1 rev-list --objects --filter=blob:none HEAD $file_3 >observed &&
-	grep "$file_3" observed &&
-	! grep "$file_4" observed
+	test_grep "$file_3" observed &&
+	test_grep ! "$file_4" observed
 '
 
 test_expect_success 'verify emitted+omitted == all' '
@@ -324,7 +324,7 @@ test_expect_success 'rev-list W/ --missing=print and --missing=allow-any for tre
 
 	git -C r3.b rev-list --missing=allow-any --objects HEAD \
 		>objs 2>rev_list_err &&
-	! grep $TREE objs &&
+	test_grep ! $TREE objs &&
 	test_must_be_empty rev_list_err
 '
 
@@ -353,7 +353,7 @@ test_expect_success 'verify skipping tree iteration when not collecting omits' '
 	test_line_count = 2 actual &&
 
 	# Make sure no other trees were considered besides the root.
-	! grep "Skipping contents of tree [^.]" filter_trace &&
+	test_grep ! "Skipping contents of tree [^.]" filter_trace &&
 
 	# Try this again with "combine:". If both sub-filters are skipping
 	# trees, the composite filter should also skip trees. This is not
@@ -539,7 +539,7 @@ test_expect_success 'combine:... with more than two sub-filters' '
 		HEAD >actual &&
 
 	test_cmp expect actual &&
-	grep "Add to combine filter-spec: sparse:oid=main:p%3bat%25ter%2bn" \
+	test_grep "Add to combine filter-spec: sparse:oid=main:p%3bat%25ter%2bn" \
 		trace1 &&
 
 	# Repeat the above test, but this time, the characters to encode are in
@@ -551,7 +551,7 @@ test_expect_success 'combine:... with more than two sub-filters' '
 		HEAD >actual &&
 
 	test_cmp expect actual &&
-	grep "Add to combine filter-spec: sparse:oid=main:%5e%7epattern" \
+	test_grep "Add to combine filter-spec: sparse:oid=main:%5e%7epattern" \
 		trace2
 '
 
@@ -623,9 +623,9 @@ test_expect_success 'verify collecting omits in combined: filter' '
 	omitted_2=$(echo a     | git hash-object --stdin) &&
 	omitted_3=$(echo abcde | git hash-object --stdin) &&
 
-	grep "~$omitted_1" actual &&
-	grep "~$omitted_2" actual &&
-	grep "~$omitted_3" actual &&
+	test_grep "~$omitted_1" actual &&
+	test_grep "~$omitted_2" actual &&
+	test_grep "~$omitted_3" actual &&
 	test_line_count = 3 actual
 '
 
@@ -654,7 +654,7 @@ test_expect_success 'tree:<depth> which filters out blob but given as arg' '
 	blob_hash=$(git -C r4 rev-parse HEAD:subdir/bar) &&
 
 	git -C r4 rev-list --objects --filter=tree:1 HEAD $blob_hash >actual &&
-	grep ^$blob_hash actual
+	test_grep ^$blob_hash actual
 '
 
 # Delete some loose objects and use rev-list, but WITHOUT any filtering.
@@ -693,8 +693,8 @@ test_expect_success 'expand blob limit in protocol' '
 	git -C r2 config --local uploadpack.allowfilter 1 &&
 	GIT_TRACE_PACKET="$(pwd)/trace" git -c protocol.version=2 clone \
 		--filter=blob:limit=1k "file://$(pwd)/r2" limit &&
-	! grep "blob:limit=1k" trace &&
-	grep "blob:limit=1024" trace
+	test_grep ! "blob:limit=1k" trace &&
+	test_grep "blob:limit=1024" trace
 '
 
 test_expect_success EXPENSIVE 'large sparse filter file ignored' '
diff --git a/t/t6115-rev-list-du.sh b/t/t6115-rev-list-du.sh
index 04c577dad6..b9650b80a4 100755
--- a/t/t6115-rev-list-du.sh
+++ b/t/t6115-rev-list-du.sh
@@ -61,13 +61,13 @@ check_du --all --objects --unpacked
 test_expect_success 'rev-list --disk-usage=human' '
 	git rev-list --objects HEAD --disk-usage=human >actual &&
 	disk_usage_slow --objects HEAD >actual_size &&
-	grep "$(cat actual_size) bytes" actual
+	test_grep "$(cat actual_size) bytes" actual
 '
 
 test_expect_success 'rev-list --disk-usage=human with bitmaps' '
 	git rev-list --objects HEAD --use-bitmap-index --disk-usage=human >actual &&
 	disk_usage_slow --objects HEAD >actual_size &&
-	grep "$(cat actual_size) bytes" actual
+	test_grep "$(cat actual_size) bytes" actual
 '
 
 test_expect_success 'rev-list use --disk-usage unproperly' '
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 4d72033e39..7a7c46658a 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -128,7 +128,7 @@ test_expect_success 'renaming tag A to Q locally produces a warning' "
 	warning: tag 'Q' is externally known as 'A'
 	EOF
 	test_cmp expected err &&
-	grep -E '^A-8-g[0-9a-f]+$' out
+	test_grep -E '^A-8-g[0-9a-f]+$' out
 "
 
 test_expect_success 'misnamed annotated tag forces long output' '
@@ -160,7 +160,7 @@ check_describe A-8-gHASH HEAD
 test_expect_success 'describe works from outside repo using --git-dir' '
 	git clone --bare "$TRASH_DIRECTORY" "$TRASH_DIRECTORY/bare" &&
 	git --git-dir "$TRASH_DIRECTORY/bare" describe >out &&
-	grep -E "^A-8-g[0-9a-f]+$" out
+	test_grep -E "^A-8-g[0-9a-f]+$" out
 '
 
 check_describe "A-8-gHASH" --dirty
@@ -170,7 +170,7 @@ test_expect_success 'describe --dirty with --work-tree' '
 		cd "$TEST_DIRECTORY" &&
 		git --git-dir "$TRASH_DIRECTORY/.git" --work-tree "$TRASH_DIRECTORY" describe --dirty >"$TRASH_DIRECTORY/out"
 	) &&
-	grep -E "^A-8-g[0-9a-f]+$" out
+	test_grep -E "^A-8-g[0-9a-f]+$" out
 '
 
 test_expect_success 'set-up dirty work tree' '
@@ -183,7 +183,7 @@ test_expect_success 'describe --dirty with --work-tree (dirty)' '
 		cd "$TEST_DIRECTORY" &&
 		git --git-dir "$TRASH_DIRECTORY/.git" --work-tree "$TRASH_DIRECTORY" describe --dirty >"$TRASH_DIRECTORY/out"
 	) &&
-	grep -E "^A-8-g[0-9a-f]+-dirty$" out &&
+	test_grep -E "^A-8-g[0-9a-f]+-dirty$" out &&
 	test_cmp expected out
 '
 
@@ -193,7 +193,7 @@ test_expect_success 'describe --dirty=.mod with --work-tree (dirty)' '
 		cd "$TEST_DIRECTORY" &&
 		git --git-dir "$TRASH_DIRECTORY/.git" --work-tree "$TRASH_DIRECTORY" describe --dirty=.mod >"$TRASH_DIRECTORY/out"
 	) &&
-	grep -E "^A-8-g[0-9a-f]+.mod$" out &&
+	test_grep -E "^A-8-g[0-9a-f]+.mod$" out &&
 	test_cmp expected out
 '
 
@@ -399,7 +399,7 @@ test_expect_success 'describe chokes on severely broken submodules' '
 
 test_expect_success 'describe ignoring a broken submodule' '
 	git describe --broken >out &&
-	grep broken out
+	test_grep broken out
 '
 
 test_expect_success 'describe with --work-tree ignoring a broken submodule' '
@@ -408,7 +408,7 @@ test_expect_success 'describe with --work-tree ignoring a broken submodule' '
 		git --git-dir "$TRASH_DIRECTORY/.git" --work-tree "$TRASH_DIRECTORY" describe --broken >"$TRASH_DIRECTORY/out"
 	) &&
 	test_when_finished "mv .git/modules/sub_moved .git/modules/sub1" &&
-	grep broken out
+	test_grep broken out
 '
 
 test_expect_success 'describe a blob at a directly tagged commit' '
diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index 011e5df1e6..79fe1f20b4 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -125,20 +125,20 @@ test_expect_success GPG 'message for merging local tag signed by good key' '
 	git checkout main &&
 	git fetch . signed-good-tag &&
 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
-	grep "^Merge tag ${apos}signed-good-tag${apos}" actual &&
-	grep "^signed-tag-msg" actual &&
-	grep "^# gpg: Signature made" actual &&
-	grep "^# gpg: Good signature from" actual
+	test_grep "^Merge tag ${apos}signed-good-tag${apos}" actual &&
+	test_grep "^signed-tag-msg" actual &&
+	test_grep "^# gpg: Signature made" actual &&
+	test_grep "^# gpg: Good signature from" actual
 '
 
 test_expect_success GPG 'message for merging local tag signed by unknown key' '
 	git checkout main &&
 	git fetch . signed-good-tag &&
 	GNUPGHOME=. git fmt-merge-msg <.git/FETCH_HEAD >actual &&
-	grep "^Merge tag ${apos}signed-good-tag${apos}" actual &&
-	grep "^signed-tag-msg" actual &&
-	grep "^# gpg: Signature made" actual &&
-	grep -E "^# gpg: Can${apos}t check signature: (public key not found|No public key)" actual
+	test_grep "^Merge tag ${apos}signed-good-tag${apos}" actual &&
+	test_grep "^signed-tag-msg" actual &&
+	test_grep "^# gpg: Signature made" actual &&
+	test_grep -E "^# gpg: Can${apos}t check signature: (public key not found|No public key)" actual
 '
 
 test_expect_success GPGSSH 'message for merging local tag signed by good ssh key' '
@@ -146,10 +146,10 @@ test_expect_success GPGSSH 'message for merging local tag signed by good ssh key
 	git checkout main &&
 	git fetch . signed-good-ssh-tag &&
 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
-	grep "^Merge tag ${apos}signed-good-ssh-tag${apos}" actual &&
-	grep "^signed-ssh-tag-msg" actual &&
-	grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
-	! grep "${GPGSSH_BAD_SIGNATURE}" actual
+	test_grep "^Merge tag ${apos}signed-good-ssh-tag${apos}" actual &&
+	test_grep "^signed-ssh-tag-msg" actual &&
+	test_grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
+	test_grep ! "${GPGSSH_BAD_SIGNATURE}" actual
 '
 
 test_expect_success GPGSSH 'message for merging local tag signed by unknown ssh key' '
@@ -157,11 +157,11 @@ test_expect_success GPGSSH 'message for merging local tag signed by unknown ssh
 	git checkout main &&
 	git fetch . signed-untrusted-ssh-tag &&
 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
-	grep "^Merge tag ${apos}signed-untrusted-ssh-tag${apos}" actual &&
-	grep "^signed-ssh-tag-msg-untrusted" actual &&
-	grep "${GPGSSH_GOOD_SIGNATURE_UNTRUSTED}" actual &&
-	! grep "${GPGSSH_BAD_SIGNATURE}" actual &&
-	grep "${GPGSSH_KEY_NOT_TRUSTED}" actual
+	test_grep "^Merge tag ${apos}signed-untrusted-ssh-tag${apos}" actual &&
+	test_grep "^signed-ssh-tag-msg-untrusted" actual &&
+	test_grep "${GPGSSH_GOOD_SIGNATURE_UNTRUSTED}" actual &&
+	test_grep ! "${GPGSSH_BAD_SIGNATURE}" actual &&
+	test_grep "${GPGSSH_KEY_NOT_TRUSTED}" actual
 '
 
 test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'message for merging local tag signed by expired ssh key' '
@@ -169,9 +169,9 @@ test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'message for merging local tag sign
 	git checkout main &&
 	git fetch . expired-signed &&
 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
-	grep "^Merge tag ${apos}expired-signed${apos}" actual &&
-	grep "^expired-signed" actual &&
-	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+	test_grep "^Merge tag ${apos}expired-signed${apos}" actual &&
+	test_grep "^expired-signed" actual &&
+	test_grep ! "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
 '
 
 test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'message for merging local tag signed by not yet valid ssh key' '
@@ -179,9 +179,9 @@ test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'message for merging local tag sign
 	git checkout main &&
 	git fetch . notyetvalid-signed &&
 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
-	grep "^Merge tag ${apos}notyetvalid-signed${apos}" actual &&
-	grep "^notyetvalid-signed" actual &&
-	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+	test_grep "^Merge tag ${apos}notyetvalid-signed${apos}" actual &&
+	test_grep "^notyetvalid-signed" actual &&
+	test_grep ! "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
 '
 
 test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'message for merging local tag signed by valid timeboxed ssh key' '
@@ -189,10 +189,10 @@ test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'message for merging local tag sign
 	git checkout main &&
 	git fetch . timeboxedvalid-signed &&
 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
-	grep "^Merge tag ${apos}timeboxedvalid-signed${apos}" actual &&
-	grep "^timeboxedvalid-signed" actual &&
-	grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
-	! grep "${GPGSSH_BAD_SIGNATURE}" actual
+	test_grep "^Merge tag ${apos}timeboxedvalid-signed${apos}" actual &&
+	test_grep "^timeboxedvalid-signed" actual &&
+	test_grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
+	test_grep ! "${GPGSSH_BAD_SIGNATURE}" actual
 '
 
 test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'message for merging local tag signed by invalid timeboxed ssh key' '
@@ -200,9 +200,9 @@ test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'message for merging local tag sign
 	git checkout main &&
 	git fetch . timeboxedinvalid-signed &&
 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
-	grep "^Merge tag ${apos}timeboxedinvalid-signed${apos}" actual &&
-	grep "^timeboxedinvalid-signed" actual &&
-	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+	test_grep "^Merge tag ${apos}timeboxedinvalid-signed${apos}" actual &&
+	test_grep "^timeboxedinvalid-signed" actual &&
+	test_grep ! "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
 '
 
 test_expect_success 'message for merging external branch' '
@@ -651,21 +651,21 @@ test_expect_success 'merge --into-name=<name>' '
 	git show -s --format="%s" >full.0 &&
 	head -n1 full.0 >actual &&
 	# expect that HEAD is shown as-is
-	grep -e "Merge branch .side. into HEAD$" actual &&
+	test_grep -e "Merge branch .side. into HEAD$" actual &&
 
 	git reset --hard main &&
 	git merge --no-ff --into-name=main side &&
 	git show -s --format="%s" >full.1 &&
 	head -n1 full.1 >actual &&
 	# expect that we pretend to be merging to main, that is suppressed
-	grep -e "Merge branch .side.$" actual &&
+	test_grep -e "Merge branch .side.$" actual &&
 
 	git checkout -b throwaway main &&
 	git merge --no-ff --into-name=main side &&
 	git show -s --format="%s" >full.2 &&
 	head -n1 full.2 >actual &&
 	# expect that we pretend to be merging to main, that is suppressed
-	grep -e "Merge branch .side.$" actual
+	test_grep -e "Merge branch .side.$" actual
 '
 
 test_expect_success 'merge.suppressDest configuration' '
@@ -677,28 +677,28 @@ test_expect_success 'merge.suppressDest configuration' '
 
 	git -c merge.suppressDest="" fmt-merge-msg <.git/FETCH_HEAD >full.1 &&
 	head -n1 full.1 >actual &&
-	grep -e "Merge branch .side. into main" actual &&
+	test_grep -e "Merge branch .side. into main" actual &&
 
 	git -c merge.suppressDest="mast" fmt-merge-msg <.git/FETCH_HEAD >full.2 &&
 	head -n1 full.2 >actual &&
-	grep -e "Merge branch .side. into main$" actual &&
+	test_grep -e "Merge branch .side. into main$" actual &&
 
 	git -c merge.suppressDest="ma?*[rn]" fmt-merge-msg <.git/FETCH_HEAD >full.3 &&
 	head -n1 full.3 >actual &&
-	grep -e "Merge branch .side." actual &&
-	! grep -e " into main$" actual &&
+	test_grep -e "Merge branch .side." actual &&
+	test_grep ! -e " into main$" actual &&
 
 	git checkout --detach HEAD &&
 	git -c merge.suppressDest="main" fmt-merge-msg <.git/FETCH_HEAD >full.4 &&
 	head -n1 full.4 >actual &&
-	grep -e "Merge branch .side. into HEAD$" actual &&
+	test_grep -e "Merge branch .side. into HEAD$" actual &&
 
 	git -c merge.suppressDest="main" fmt-merge-msg \
 		--into-name=main <.git/FETCH_HEAD >full.5 &&
 	head -n1 full.5 >actual &&
-	grep -e "Merge branch .side." actual &&
-	! grep -e " into main$" actual &&
-	! grep -e " into HEAD$" actual
+	test_grep -e "Merge branch .side." actual &&
+	test_grep ! -e " into main$" actual &&
+	test_grep ! -e " into HEAD$" actual
 '
 
 test_done
diff --git a/t/t6402-merge-rename.sh b/t/t6402-merge-rename.sh
index ff00b74e9c..fb1595ae53 100755
--- a/t/t6402-merge-rename.sh
+++ b/t/t6402-merge-rename.sh
@@ -332,7 +332,7 @@ test_expect_success 'Same as previous, but merged other way' '
 	git checkout -q dir-in-way^0 &&
 	test_must_fail git merge --strategy=recursive renamed-file-has-no-conflicts >output 2>errors &&
 
-	! grep "error: refusing to lose untracked file at" errors &&
+	test_grep ! "error: refusing to lose untracked file at" errors &&
 	test_grep "CONFLICT (modify/delete): dir/file-in-the-way" output &&
 	test_grep "Auto-merging dir" output &&
 	test_grep "moving it to dir~renamed-file-has-no-conflicts instead" output &&
@@ -883,7 +883,7 @@ test_expect_success 'setup spurious "refusing to lose untracked" message' '
 test_expect_success 'no spurious "refusing to lose untracked" message' '
 	git checkout main^0 &&
 	test_must_fail git merge rename^0 2>errors.txt &&
-	! grep "refusing to lose untracked file" errors.txt
+	test_grep ! "refusing to lose untracked file" errors.txt
 '
 
 test_expect_success 'do not follow renames for empty files' '
diff --git a/t/t6403-merge-file.sh b/t/t6403-merge-file.sh
index 801284cf8f..dcc5c2ac99 100755
--- a/t/t6403-merge-file.sh
+++ b/t/t6403-merge-file.sh
@@ -356,7 +356,7 @@ test_expect_success "expected conflict markers" '
 test_expect_success 'binary files cannot be merged' '
 	test_must_fail git merge-file -p \
 		orig.txt "$TEST_DIRECTORY"/test-binary-1.png new1.txt 2> merge.err &&
-	grep "Cannot merge binary files" merge.err
+	test_grep "Cannot merge binary files" merge.err
 '
 
 test_expect_success 'binary files cannot be merged with --object-id' '
@@ -364,7 +364,7 @@ test_expect_success 'binary files cannot be merged with --object-id' '
 	git add orig.txt new1.txt test-binary-1.png &&
 	test_must_fail git merge-file --object-id \
 		:orig.txt :test-binary-1.png :new1.txt 2> merge.err &&
-	grep "Cannot merge binary files" merge.err
+	test_grep "Cannot merge binary files" merge.err
 '
 
 test_expect_success 'MERGE_ZEALOUS simplifies non-conflicts' '
@@ -539,7 +539,7 @@ test_expect_success 'conflict sections match existing line endings' '
 test_expect_success '--object-id fails without repository' '
 	empty="$(test_oid empty_blob)" &&
 	nongit test_must_fail git merge-file --object-id $empty $empty $empty 2>err &&
-	grep "not a git repository" err
+	test_grep "not a git repository" err
 '
 
 test_expect_success 'run in a linked worktree with --object-id' '
diff --git a/t/t6404-recursive-merge.sh b/t/t6404-recursive-merge.sh
index 346f3608b9..ce420fe1ac 100755
--- a/t/t6404-recursive-merge.sh
+++ b/t/t6404-recursive-merge.sh
@@ -109,7 +109,7 @@ test_expect_success 'refuse to merge binary files' '
 	git add binary-file &&
 	git commit -m binary2 &&
 	test_must_fail git merge F >merge_output &&
-	grep "Cannot merge binary files: binary-file (HEAD vs. F)" merge_output
+	test_grep "Cannot merge binary files: binary-file (HEAD vs. F)" merge_output
 '
 
 test_expect_success 'mark rename/delete as unmerged' '
diff --git a/t/t6406-merge-attr.sh b/t/t6406-merge-attr.sh
index 8f6fbef002..7f49c5908a 100755
--- a/t/t6406-merge-attr.sh
+++ b/t/t6406-merge-attr.sh
@@ -97,11 +97,11 @@ test_expect_success 'check merge result in index' '
 test_expect_success 'check merge result in working tree' '
 
 	git cat-file -p HEAD:binary >binary-orig &&
-	grep "<<<<<<<" text &&
+	test_grep "<<<<<<<" text &&
 	cmp binary-orig binary &&
-	! grep "<<<<<<<" union &&
-	grep Main union &&
-	grep Side union
+	test_grep ! "<<<<<<<" union &&
+	test_grep Main union &&
+	test_grep Side union
 
 '
 
@@ -112,9 +112,9 @@ test_expect_success 'retry the merge with longer context' '
 		s/ .*$//
 		p
 	}" >actual text &&
-	grep ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" actual &&
-	grep "================================" actual &&
-	grep "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<" actual
+	test_grep ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" actual &&
+	test_grep "================================" actual &&
+	test_grep "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<" actual
 '
 
 test_expect_success 'invalid conflict-marker-size 3a' '
@@ -193,7 +193,7 @@ test_expect_success !WINDOWS 'custom merge driver that is killed with a signal'
 	>./please-abort &&
 	echo "* merge=custom" >.gitattributes &&
 	test_expect_code 2 git merge main 2>err &&
-	grep "^error: failed to execute internal merge" err &&
+	test_grep "^error: failed to execute internal merge" err &&
 	git ls-files -u >output &&
 	git diff --name-only HEAD >>output &&
 	test_must_be_empty output
@@ -260,7 +260,7 @@ test_expect_success 'binary files with union attribute' '
 	git commit -am two &&
 
 	test_must_fail git merge bin-main >output &&
-	grep -i "warning.*cannot merge.*HEAD vs. bin-main" output
+	test_grep -i "warning.*cannot merge.*HEAD vs. bin-main" output
 '
 
 test_expect_success !WINDOWS 'custom merge driver that is killed with a signal on recursive merge' '
@@ -297,7 +297,7 @@ test_expect_success !WINDOWS 'custom merge driver that is killed with a signal o
 	>./please-abort &&
 	echo "* merge=custom" >.gitattributes &&
 	test_expect_code 2 git merge recursive-a 2>err &&
-	grep "error: failed to execute internal merge" err &&
+	test_grep "error: failed to execute internal merge" err &&
 	git ls-files -u >output &&
 	git diff --name-only HEAD >>output &&
 	test_must_be_empty output
diff --git a/t/t6417-merge-ours-theirs.sh b/t/t6417-merge-ours-theirs.sh
index 62d1406119..9486251399 100755
--- a/t/t6417-merge-ours-theirs.sh
+++ b/t/t6417-merge-ours-theirs.sh
@@ -26,31 +26,31 @@ test_expect_success setup '
 test_expect_success 'plain recursive - should conflict' '
 	git reset --hard main &&
 	test_must_fail git merge -s recursive side &&
-	grep nine file &&
-	grep nueve file &&
-	! grep 9 file &&
-	grep one file &&
-	! grep 1 file
+	test_grep nine file &&
+	test_grep nueve file &&
+	test_grep ! 9 file &&
+	test_grep one file &&
+	test_grep ! 1 file
 '
 
 test_expect_success 'recursive favouring theirs' '
 	git reset --hard main &&
 	git merge -s recursive -Xtheirs side &&
-	! grep nine file &&
-	grep nueve file &&
-	! grep 9 file &&
-	grep one file &&
-	! grep 1 file
+	test_grep ! nine file &&
+	test_grep nueve file &&
+	test_grep ! 9 file &&
+	test_grep one file &&
+	test_grep ! 1 file
 '
 
 test_expect_success 'recursive favouring ours' '
 	git reset --hard main &&
 	git merge -s recursive -X ours side &&
-	grep nine file &&
-	! grep nueve file &&
-	! grep 9 file &&
-	grep one file &&
-	! grep 1 file
+	test_grep nine file &&
+	test_grep ! nueve file &&
+	test_grep ! 9 file &&
+	test_grep one file &&
+	test_grep ! 1 file
 '
 
 test_expect_success 'binary file with -Xours/-Xtheirs' '
diff --git a/t/t6418-merge-text-auto.sh b/t/t6418-merge-text-auto.sh
index 41288a60ce..c86a1bedd5 100755
--- a/t/t6418-merge-text-auto.sh
+++ b/t/t6418-merge-text-auto.sh
@@ -226,7 +226,7 @@ test_expect_success 'rename/delete vs. renormalization' '
 		git checkout rename^0 &&
 		test_must_fail git -c merge.renormalize=true merge nuke >out &&
 
-		grep "rename/delete" out
+		test_grep "rename/delete" out
 	)
 '
 
diff --git a/t/t6422-merge-rename-corner-cases.sh b/t/t6422-merge-rename-corner-cases.sh
index e18d5a227d..d1f1de14e7 100755
--- a/t/t6422-merge-rename-corner-cases.sh
+++ b/t/t6422-merge-rename-corner-cases.sh
@@ -916,8 +916,8 @@ test_expect_success 'rad-check: rename/add/delete conflict' '
 		# bar should have two-way merged contents of the different
 		# versions of bar; check that content from both sides is
 		# present.
-		grep original bar &&
-		grep different bar
+		test_grep original bar &&
+		test_grep different bar
 	)
 '
 
@@ -991,8 +991,8 @@ test_expect_success 'rrdd-check: rename/rename(2to1)/delete/delete conflict' '
 		# baz should have two-way merged contents of the original
 		# contents of foo and bar; check that content from both sides
 		# is present.
-		grep foo baz &&
-		grep bar baz
+		test_grep foo baz &&
+		test_grep bar baz
 	)
 '
 
diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index 53535a8ebf..24d4c5447b 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -1113,7 +1113,7 @@ test_expect_success '5c: Transitive rename would cause rename/rename/rename/add/
 		test_cmp expect actual &&
 		test_path_is_missing x/d &&
 		test_path_is_file y/d &&
-		grep -q "<<<<" y/d  # conflict markers should be present
+		test_grep -q "<<<<" y/d  # conflict markers should be present
 	)
 '
 
@@ -2841,10 +2841,10 @@ test_expect_success '9e: N-to-1 whammo' '
 
 		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out &&
 		grep "CONFLICT (implicit dir rename): Cannot map more than one path to combined/yo" out >error_line &&
-		grep -q dir1/yo error_line &&
-		grep -q dir2/yo error_line &&
-		grep -q dir3/yo error_line &&
-		grep -q dirN/yo error_line &&
+		test_grep -q dir1/yo error_line &&
+		test_grep -q dir2/yo error_line &&
+		test_grep -q dir3/yo error_line &&
+		test_grep -q dirN/yo error_line &&
 
 		git ls-files -s >out &&
 		test_line_count = 16 out &&
@@ -3578,7 +3578,7 @@ test_expect_success '11b: Avoid losing dirty file involved in directory rename'
 		test_path_is_missing .git/MERGE_HEAD &&
 		test_grep "error: Your local changes to the following files would be overwritten by merge" err &&
 
-		grep -q stuff z/c &&
+		test_grep -q stuff z/c &&
 		test_seq 1 10 >expected &&
 		echo stuff >>expected &&
 		test_cmp expected z/c
@@ -3636,7 +3636,7 @@ test_expect_success '11c: Avoid losing not-uptodate with rename + D/F conflict'
 		test_path_is_missing .git/MERGE_HEAD &&
 		test_grep "error: Your local changes to the following files would be overwritten by merge" err &&
 
-		grep -q stuff y/c &&
+		test_grep -q stuff y/c &&
 		test_seq 1 10 >expected &&
 		echo stuff >>expected &&
 		test_cmp expected y/c &&
@@ -3705,7 +3705,7 @@ test_expect_success '11d: Avoid losing not-uptodate with rename + D/F conflict'
 		test_path_is_missing .git/MERGE_HEAD &&
 		test_grep "error: Your local changes to the following files would be overwritten by merge" err &&
 
-		grep -q stuff z/c &&
+		test_grep -q stuff z/c &&
 		test_seq 1 10 >expected &&
 		echo stuff >>expected &&
 		test_cmp expected z/c
@@ -4779,7 +4779,7 @@ test_expect_success '12i: Directory rename causes rename-to-self' '
 
 		test_must_fail git -c merge.directoryRenames=conflict merge -s recursive B^0 >out &&
 
-		grep "CONFLICT (implicit dir rename).*source/bar in the way" out &&
+		test_grep "CONFLICT (implicit dir rename).*source/bar in the way" out &&
 		test_path_is_missing source/bar &&
 		test_path_is_file source/subdir/bar &&
 		test_path_is_file source/baz &&
@@ -4920,7 +4920,7 @@ test_expect_success '12j: Directory rename to root causes rename-to-self' '
 		# error about there being a file in the way.
 
 		test_must_fail git -c merge.directoryRenames=conflict merge -s recursive B^0 >out &&
-		grep "CONFLICT (implicit dir rename).*bar in the way" out &&
+		test_grep "CONFLICT (implicit dir rename).*bar in the way" out &&
 
 		test_path_is_missing bar &&
 		test_path_is_file subdir/bar &&
@@ -4999,7 +4999,7 @@ test_expect_success '12k: Directory rename with sibling causes rename-to-self' '
 		# error about there being a file in the way.
 
 		test_must_fail git -c merge.directoryRenames=conflict merge -s recursive B^0 >out &&
-		grep "CONFLICT (implicit dir rename).*dirA/bar in the way" out &&
+		test_grep "CONFLICT (implicit dir rename).*dirA/bar in the way" out &&
 
 		test_path_is_missing dirA/bar &&
 		test_path_is_file dirB/bar &&
@@ -5402,7 +5402,7 @@ test_expect_success '12o: Directory rename hits other rename source; file still
 		test_stdout_line_count = 1 git ls-files -s B/stuff &&
 		test_stdout_line_count = 1 git ls-files -s D/file2 &&
 
-		grep "CONFLICT (implicit dir rename).*Existing file/dir at A/file1 in the way" out &&
+		test_grep "CONFLICT (implicit dir rename).*Existing file/dir at A/file1 in the way" out &&
 		test_stdout_line_count = 1 git ls-files -s C/file1
 	)
 '
@@ -5489,7 +5489,7 @@ test_expect_success '12p: Directory rename hits other rename source; file still
 		test_stdout_line_count = 1 git ls-files -s B/stuff &&
 		test_stdout_line_count = 1 git ls-files -s D/file2 &&
 
-		grep "CONFLICT (implicit dir rename).*Existing file/dir at A/file1 in the way" out &&
+		test_grep "CONFLICT (implicit dir rename).*Existing file/dir at A/file1 in the way" out &&
 		test_stdout_line_count = 1 git ls-files -s C/file1
 	)
 '
@@ -5570,8 +5570,8 @@ test_expect_success '12q: Directory rename hits other rename source; file remove
 
 		test_must_fail git -c merge.directoryRenames=conflict merge -s recursive B^0 >out &&
 
-		grep "CONFLICT (rename/delete).*A/file1.*D/file2" out &&
-		grep "CONFLICT (implicit dir rename).*Existing file/dir at A/file1 in the way" out &&
+		test_grep "CONFLICT (rename/delete).*A/file1.*D/file2" out &&
+		test_grep "CONFLICT (implicit dir rename).*Existing file/dir at A/file1 in the way" out &&
 
 		test_stdout_line_count = 6 git ls-files -s &&
 		test_stdout_line_count = 1 git ls-files -s A/other &&
@@ -5586,7 +5586,7 @@ test_expect_success '12q: Directory rename hits other rename source; file remove
 		# the dir rename of C/file1 -> A/file1 would mean modifying
 		# the code so that renames do not adjust both their source
 		# and target paths in all cases.
-		! grep "CONFLICT (file location)" out &&
+		test_grep ! "CONFLICT (file location)" out &&
 		test_stdout_line_count = 1 git ls-files -s C/file1
 	)
 '
@@ -5652,8 +5652,8 @@ test_expect_success '13a(conflict): messages for newly added files' '
 		test_grep CONFLICT..file.location.*z/d.added.in.B^0.*y/d out &&
 
 		git ls-files >paths &&
-		! grep z/ paths &&
-		grep "y/[de]" paths &&
+		test_grep ! z/ paths &&
+		test_grep "y/[de]" paths &&
 
 		test_path_is_missing z/d &&
 		test_path_is_file    y/d &&
@@ -5676,8 +5676,8 @@ test_expect_success '13a(info): messages for newly added files' '
 		test_grep Path.updated:.*z/d.added.in.B^0.*y/d out &&
 
 		git ls-files >paths &&
-		! grep z/ paths &&
-		grep "y/[de]" paths &&
+		test_grep ! z/ paths &&
+		test_grep "y/[de]" paths &&
 
 		test_path_is_missing z/d &&
 		test_path_is_file    y/d &&
@@ -5742,8 +5742,8 @@ test_expect_success '13b(conflict): messages for transitive rename with conflict
 		test_grep CONFLICT..file.location.*x/d.renamed.to.z/d.*moved.to.y/d out &&
 
 		git ls-files >paths &&
-		! grep z/ paths &&
-		grep "y/d" paths &&
+		test_grep ! z/ paths &&
+		test_grep "y/d" paths &&
 
 		test_path_is_missing z/d &&
 		test_path_is_file    y/d
@@ -5764,8 +5764,8 @@ test_expect_success '13b(info): messages for transitive rename with conflicted c
 		test_grep Path.updated:.*x/d.renamed.to.z/d.in.B^0.*moving.it.to.y/d out &&
 
 		git ls-files >paths &&
-		! grep z/ paths &&
-		grep "y/d" paths &&
+		test_grep ! z/ paths &&
+		test_grep "y/d" paths &&
 
 		test_path_is_missing z/d &&
 		test_path_is_file    y/d
@@ -5827,8 +5827,8 @@ test_expect_success '13c(conflict): messages for rename/rename(1to1) via transit
 		test_grep CONFLICT..file.location.*x/d.renamed.to.z/d.*moved.to.y/d out &&
 
 		git ls-files >paths &&
-		! grep z/ paths &&
-		grep "y/d" paths &&
+		test_grep ! z/ paths &&
+		test_grep "y/d" paths &&
 
 		test_path_is_missing z/d &&
 		test_path_is_file    y/d
@@ -5848,8 +5848,8 @@ test_expect_success '13c(info): messages for rename/rename(1to1) via transitive
 		test_grep Path.updated:.*x/d.renamed.to.z/d.in.B^0.*moving.it.to.y/d out &&
 
 		git ls-files >paths &&
-		! grep z/ paths &&
-		grep "y/d" paths &&
+		test_grep ! z/ paths &&
+		test_grep "y/d" paths &&
 
 		test_path_is_missing z/d &&
 		test_path_is_file    y/d
@@ -5917,9 +5917,9 @@ test_expect_success '13d(conflict): messages for rename/rename(1to1) via dual tr
 		test_grep CONFLICT..file.location.*a/y.renamed.to.c/y.*moved.to.d/y out &&
 
 		git ls-files >paths &&
-		! grep b/ paths &&
-		! grep c/ paths &&
-		grep "d/y" paths &&
+		test_grep ! b/ paths &&
+		test_grep ! c/ paths &&
+		test_grep "d/y" paths &&
 
 		test_path_is_missing b/y &&
 		test_path_is_missing c/y &&
@@ -5941,9 +5941,9 @@ test_expect_success '13d(info): messages for rename/rename(1to1) via dual transi
 		test_grep Path.updated.*a/y.renamed.to.c/y.*moving.it.to.d/y out &&
 
 		git ls-files >paths &&
-		! grep b/ paths &&
-		! grep c/ paths &&
-		grep "d/y" paths &&
+		test_grep ! b/ paths &&
+		test_grep ! c/ paths &&
+		test_grep "d/y" paths &&
 
 		test_path_is_missing b/y &&
 		test_path_is_missing c/y &&
@@ -6058,8 +6058,8 @@ test_expect_success '13e: directory rename detection in recursive case' '
 		test_must_be_empty err &&
 
 		git ls-files >paths &&
-		! grep a/x paths &&
-		grep b/x paths
+		test_grep ! a/x paths &&
+		test_grep b/x paths
 	)
 '
 
diff --git a/t/t6424-merge-unrelated-index-changes.sh b/t/t6424-merge-unrelated-index-changes.sh
index ddc7524f6c..12e58bc335 100755
--- a/t/t6424-merge-unrelated-index-changes.sh
+++ b/t/t6424-merge-unrelated-index-changes.sh
@@ -298,9 +298,9 @@ test_expect_success 'with multiple strategies, recursive or ort failure do not e
 
 	test_must_fail git merge -s ort -s octopus C^0 >output 2>&1 &&
 
-	grep "Trying merge strategy ort..." output &&
-	grep "Trying merge strategy octopus..." output &&
-	grep "No merge strategy handled the merge." output &&
+	test_grep "Trying merge strategy ort..." output &&
+	test_grep "Trying merge strategy octopus..." output &&
+	test_grep "No merge strategy handled the merge." output &&
 
 	# Changes to "a" should remain staged
 	git rev-parse :a >actual &&
diff --git a/t/t6427-diff3-conflict-markers.sh b/t/t6427-diff3-conflict-markers.sh
index 57569c4f4b..818550bc95 100755
--- a/t/t6427-diff3-conflict-markers.sh
+++ b/t/t6427-diff3-conflict-markers.sh
@@ -39,7 +39,7 @@ test_expect_success 'check no merge base' '
 
 		test_must_fail git -c merge.conflictstyle=diff3 merge --allow-unrelated-histories -s recursive R^0 &&
 
-		grep "|||||| empty tree" content
+		test_grep "|||||| empty tree" content
 	)
 '
 
@@ -97,7 +97,7 @@ test_expect_success 'check unique merge base' '
 
 		test_must_fail git -c merge.conflictstyle=diff3 merge -s recursive R^0 &&
 
-		grep "|||||| $MAIN:content" renamed
+		test_grep "|||||| $MAIN:content" renamed
 	)
 '
 
@@ -185,7 +185,7 @@ test_expect_success 'check multiple merge bases' '
 
 		test_must_fail git -c merge.conflictstyle=diff3 merge -s recursive R^0 &&
 
-		grep "|||||| merged common ancestors:content" renamed
+		test_grep "|||||| merged common ancestors:content" renamed
 	)
 '
 
@@ -198,7 +198,7 @@ test_expect_success 'rebase --merge describes parent of commit being picked' '
 		git checkout -b side HEAD^ &&
 		test_commit side file &&
 		test_must_fail git -c merge.conflictstyle=diff3 rebase --merge main &&
-		grep "||||||| parent of" file
+		test_grep "||||||| parent of" file
 	)
 '
 
@@ -207,7 +207,7 @@ test_expect_success 'rebase --apply describes fake ancestor base' '
 		cd rebase &&
 		git rebase --abort &&
 		test_must_fail git -c merge.conflictstyle=diff3 rebase --apply main &&
-		grep "||||||| constructed fake ancestor" file
+		test_grep "||||||| constructed fake ancestor" file
 	)
 '
 
diff --git a/t/t6432-merge-recursive-space-options.sh b/t/t6432-merge-recursive-space-options.sh
index db4b77e63d..110b48cb67 100755
--- a/t/t6432-merge-recursive-space-options.sh
+++ b/t/t6432-merge-recursive-space-options.sh
@@ -109,7 +109,7 @@ test_expect_success 'naive merge fails' '
 	git read-tree --reset -u HEAD &&
 	test_must_fail git merge-recursive HEAD^ -- HEAD remote &&
 	test_must_fail git update-index --refresh &&
-	grep "<<<<<<" text.txt
+	test_grep "<<<<<<" text.txt
 '
 
 test_expect_success '--ignore-space-change makes merge succeed' '
@@ -123,7 +123,7 @@ test_expect_success 'naive cherry-pick fails' '
 	git read-tree --reset -u HEAD &&
 	test_must_fail git cherry-pick remote &&
 	test_must_fail git update-index --refresh &&
-	grep "<<<<<<" text.txt
+	test_grep "<<<<<<" text.txt
 '
 
 test_expect_success '-Xignore-space-change makes cherry-pick succeed' '
diff --git a/t/t6436-merge-overwrite.sh b/t/t6436-merge-overwrite.sh
index 70b5d2d694..5e39a15fac 100755
--- a/t/t6436-merge-overwrite.sh
+++ b/t/t6436-merge-overwrite.sh
@@ -189,10 +189,10 @@ test_expect_success 'set up unborn branch and content' '
 
 test_expect_success 'will not clobber WT/index when merging into unborn' '
 	git merge main &&
-	grep foo tracked-file &&
+	test_grep foo tracked-file &&
 	git show :tracked-file >expect &&
-	grep foo expect &&
-	grep bar untracked-file
+	test_grep foo expect &&
+	test_grep bar untracked-file
 '
 
 test_done
diff --git a/t/t6437-submodule-merge.sh b/t/t6437-submodule-merge.sh
index a564758f52..107e13afbc 100755
--- a/t/t6437-submodule-merge.sh
+++ b/t/t6437-submodule-merge.sh
@@ -111,7 +111,7 @@ test_expect_success 'merging should conflict for non fast-forward' '
 	 git checkout -b test-nonforward-a b &&
 	 test_must_fail git merge c 2>actual &&
 	 sub_expect="go to submodule (sub), and either merge commit $(git -C sub rev-parse --short sub-c)" &&
-	 grep "$sub_expect" actual
+	 test_grep "$sub_expect" actual
 	 )
 '
 
@@ -148,7 +148,7 @@ test_expect_success 'merging should conflict for non fast-forward (resolution ex
 	  git rev-parse --short sub-d > ../expect) &&
 	  test_must_fail git merge c >actual 2>sub-actual &&
 	  sub_expect="go to submodule (sub), and either merge commit $(git -C sub rev-parse --short sub-c)" &&
-	  grep "$sub_expect" sub-actual &&
+	  test_grep "$sub_expect" sub-actual &&
 	 grep $(cat expect) actual > /dev/null &&
 	 git reset --hard)
 '
@@ -164,7 +164,7 @@ test_expect_success 'merging should fail for ambiguous common parent' '
 	 ) &&
 	test_must_fail git merge c >actual 2>sub-actual &&
 	sub_expect="go to submodule (sub), and either merge commit $(git -C sub rev-parse --short sub-c)" &&
-	grep "$sub_expect" sub-actual &&
+	test_grep "$sub_expect" sub-actual &&
 	grep $(cat expect1) actual > /dev/null &&
 	grep $(cat expect2) actual > /dev/null &&
 	git reset --hard)
@@ -207,7 +207,7 @@ test_expect_success 'merging should fail for changes that are backwards' '
 	git checkout -b test-backward e &&
 	test_must_fail git merge f 2>actual &&
 	sub_expect="go to submodule (sub), and either merge commit $(git -C sub rev-parse --short sub-d)" &&
-	grep "$sub_expect" actual
+	test_grep "$sub_expect" actual
 	)
 '
 
@@ -513,7 +513,7 @@ test_expect_success 'merging should fail with no merge base' '
 	git commit -m "b" &&
 	test_must_fail git merge a 2>actual &&
 	sub_expect="go to submodule (sub), and either merge commit $(git -C sub rev-parse --short HEAD^1)" &&
-	grep "$sub_expect" actual
+	test_grep "$sub_expect" actual
 	)
 '
 
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index ea9aaad470..3ee4b18d88 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -176,15 +176,15 @@ test_expect_success 'gc.reflogExpire{Unreachable,}=never skips "expire" via "gc"
 
 	# Check that git-pack-refs is run as a sanity check (done via
 	# gc_before_repack()) but that git-expire is not.
-	grep -E "^trace: (built-in|exec|run_command): git pack-refs --" trace.out &&
-	! grep -E "^trace: (built-in|exec|run_command): git reflog expire --" trace.out
+	test_grep -E "^trace: (built-in|exec|run_command): git pack-refs --" trace.out &&
+	test_grep ! -E "^trace: (built-in|exec|run_command): git reflog expire --" trace.out
 '
 
 test_expect_success 'one of gc.reflogExpire{Unreachable,}=never does not skip "expire" via "gc"' '
 	>trace.out &&
 	test_config gc.reflogExpire never &&
 	GIT_TRACE=$(pwd)/trace.out git gc &&
-	grep -E "^trace: (built-in|exec|run_command): git reflog expire --" trace.out
+	test_grep -E "^trace: (built-in|exec|run_command): git reflog expire --" trace.out
 '
 
 test_expect_success 'gc.repackFilter launches repack with a filter' '
@@ -196,7 +196,7 @@ test_expect_success 'gc.repackFilter launches repack with a filter' '
 	GIT_TRACE=$(pwd)/trace.out git -C bare.git -c gc.repackFilter=blob:none \
 		-c repack.writeBitmaps=false -c gc.cruftPacks=false gc &&
 	test_stdout_line_count = 2 ls bare.git/objects/pack/*.pack &&
-	grep -E "^trace: (built-in|exec|run_command): git repack .* --filter=blob:none ?.*" trace.out
+	test_grep -E "^trace: (built-in|exec|run_command): git repack .* --filter=blob:none ?.*" trace.out
 '
 
 test_expect_success 'gc.repackFilterTo store filtered out objects' '
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index b5b314e570..ee46d66b84 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -958,13 +958,13 @@ test_expect_success 'merge-base without --all is one of --all results' '
 	git merge-base --all commit-5-7 commit-4-8 commit-6-6 commit-8-3 >all &&
 	git merge-base commit-5-7 commit-4-8 commit-6-6 commit-8-3 >single &&
 	test_line_count = 1 single &&
-	grep -F -f single all &&
+	test_grep -F -f single all &&
 
 	cp commit-graph-half .git/objects/info/commit-graph &&
 	git merge-base --all commit-5-7 commit-4-8 commit-6-6 commit-8-3 >all &&
 	git merge-base commit-5-7 commit-4-8 commit-6-6 commit-8-3 >single &&
 	test_line_count = 1 single &&
-	grep -F -f single all
+	test_grep -F -f single all
 '
 
 test_done
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 920479e925..7cf4aa5ba1 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -46,7 +46,7 @@ test_expect_success 'commiting the change' '
 
 test_expect_success 'checking the commit' '
 	git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
-	grep "^R100..*path0/COPYING..*path1/COPYING" actual
+	test_grep "^R100..*path0/COPYING..*path1/COPYING" actual
 '
 
 test_expect_success 'moving the file back into subdirectory' '
@@ -60,7 +60,7 @@ test_expect_success 'commiting the change' '
 
 test_expect_success 'checking the commit' '
 	git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
-	grep "^R100..*path1/COPYING..*path0/COPYING" actual
+	test_grep "^R100..*path1/COPYING..*path0/COPYING" actual
 '
 
 test_expect_success 'mv --dry-run does not move file' '
@@ -147,8 +147,8 @@ test_expect_success 'commiting the change' '
 
 test_expect_success 'checking the commit' '
 	git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
-	grep "^R100..*path0/COPYING..*path2/COPYING" actual &&
-	grep "^R100..*path0/README..*path2/README" actual
+	test_grep "^R100..*path0/COPYING..*path2/COPYING" actual &&
+	test_grep "^R100..*path0/README..*path2/README" actual
 '
 
 test_expect_success 'succeed when source is a prefix of destination' '
@@ -165,8 +165,8 @@ test_expect_success 'commiting the change' '
 
 test_expect_success 'checking the commit' '
 	git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
-	grep "^R100..*path2/COPYING..*path1/path2/COPYING" actual &&
-	grep "^R100..*path2/README..*path1/path2/README" actual
+	test_grep "^R100..*path2/COPYING..*path1/path2/COPYING" actual &&
+	test_grep "^R100..*path2/README..*path1/path2/README" actual
 '
 
 test_expect_success 'do not move directory over existing directory' '
@@ -200,7 +200,7 @@ test_expect_success "Michael Cassar's test case" '
 
 	T=$(git write-tree) &&
 	git ls-tree -r $T >out &&
-	grep partA/outline.txt out
+	test_grep partA/outline.txt out
 '
 
 rm -fr papers partA path?
@@ -504,7 +504,7 @@ test_expect_success 'mv -k does not accidentally destroy submodules' '
 	mkdir dummy dest &&
 	git mv -k dummy sub dest &&
 	git status --porcelain >actual &&
-	grep "^R  sub -> dest/sub" actual &&
+	test_grep "^R  sub -> dest/sub" actual &&
 	git reset --hard &&
 	git checkout .
 '
diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
index 4d3f221224..9c0e82ba31 100755
--- a/t/t7002-mv-sparse-checkout.sh
+++ b/t/t7002-mv-sparse-checkout.sh
@@ -319,8 +319,8 @@ test_expect_success 'move clean path from in-cone to out-of-cone' '
 	test_path_is_missing sub/d &&
 	test_path_is_missing folder1/d &&
 	git ls-files -t >actual &&
-	! grep "^H sub/d\$" actual &&
-	grep "S folder1/d" actual
+	test_grep ! "^H sub/d\$" actual &&
+	test_grep "S folder1/d" actual
 '
 
 test_expect_success 'move clean path from in-cone to out-of-cone overwrite' '
@@ -346,8 +346,8 @@ test_expect_success 'move clean path from in-cone to out-of-cone overwrite' '
 	test_path_is_missing sub/file1 &&
 	test_path_is_missing folder1/file1 &&
 	git ls-files -t >actual &&
-	! grep "H sub/file1" actual &&
-	grep "S folder1/file1" actual &&
+	test_grep ! "H sub/file1" actual &&
+	test_grep "S folder1/file1" actual &&
 
 	# compare file content before move and after move
 	echo "sub/file1 overwrite" >expect &&
@@ -382,8 +382,8 @@ test_expect_success 'move clean path from in-cone to out-of-cone file overwrite'
 	test_path_is_missing sub/file1 &&
 	test_path_is_missing folder1/file1 &&
 	git ls-files -t >actual &&
-	! grep "H sub/file1" actual &&
-	grep "S folder1/file1" actual &&
+	test_grep ! "H sub/file1" actual &&
+	test_grep "S folder1/file1" actual &&
 
 	# compare file content before move and after move
 	echo "sub/file1 overwrite" >expect &&
@@ -421,9 +421,9 @@ test_expect_success 'move directory with one of the files overwrite' '
 	test_path_is_missing sub/dir/e &&
 	test_path_is_missing folder1/file1 &&
 	git ls-files -t >actual &&
-	! grep "H sub/dir/file1" actual &&
-	! grep "H sub/dir/e" actual &&
-	grep "S folder1/dir/file1" actual &&
+	test_grep ! "H sub/dir/file1" actual &&
+	test_grep ! "H sub/dir/e" actual &&
+	test_grep "S folder1/dir/file1" actual &&
 
 	# compare file content before move and after move
 	echo test >expect &&
@@ -452,8 +452,8 @@ test_expect_success 'move dirty path from in-cone to out-of-cone' '
 	test_path_is_missing sub/d &&
 	test_path_is_file folder1/d &&
 	git ls-files -t >actual &&
-	! grep "^H sub/d\$" actual &&
-	grep "H folder1/d" actual
+	test_grep ! "^H sub/d\$" actual &&
+	test_grep "H folder1/d" actual
 '
 
 test_expect_success 'move dir from in-cone to out-of-cone' '
@@ -473,8 +473,8 @@ test_expect_success 'move dir from in-cone to out-of-cone' '
 	test_path_is_missing sub/dir &&
 	test_path_is_missing folder1 &&
 	git ls-files -t >actual &&
-	! grep "H sub/dir/e" actual &&
-	grep "S folder1/dir/e" actual
+	test_grep ! "H sub/dir/e" actual &&
+	test_grep "S folder1/dir/e" actual
 '
 
 test_expect_success 'move partially-dirty dir from in-cone to out-of-cone' '
@@ -506,12 +506,12 @@ test_expect_success 'move partially-dirty dir from in-cone to out-of-cone' '
 	test_path_is_file folder1/dir/e2 &&
 	test_path_is_file folder1/dir/e3 &&
 	git ls-files -t >actual &&
-	! grep "H sub/dir/e" actual &&
-	! grep "H sub/dir/e2" actual &&
-	! grep "H sub/dir/e3" actual &&
-	grep "S folder1/dir/e" actual &&
-	grep "H folder1/dir/e2" actual &&
-	grep "H folder1/dir/e3" actual
+	test_grep ! "H sub/dir/e" actual &&
+	test_grep ! "H sub/dir/e2" actual &&
+	test_grep ! "H sub/dir/e3" actual &&
+	test_grep "S folder1/dir/e" actual &&
+	test_grep "H folder1/dir/e2" actual &&
+	test_grep "H folder1/dir/e3" actual
 '
 
 test_done
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index c475769858..86011e7b1f 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -49,7 +49,7 @@ test_expect_success 'result is really identical' '
 test_expect_success 'rewrite bare repository identically' '
 	(git config core.bare true && cd .git &&
 	 git filter-branch branch > filter-output 2>&1 &&
-	! grep fatal filter-output)
+	test_grep ! fatal filter-output)
 '
 git config core.bare false
 test_expect_success 'result is really identical' '
@@ -65,7 +65,7 @@ test_expect_success 'correct GIT_DIR while using -d' '
 	git filter-branch -d "$TRASHDIR/dfoo" \
 		--index-filter "cp \"$TRASHDIR\"/dfoo/backup-refs \"$TRASHDIR\"" \
 	) &&
-	grep drepo "$TRASHDIR/backup-refs"
+	test_grep drepo "$TRASHDIR/backup-refs"
 '
 
 test_expect_success 'tree-filter works with -d' '
@@ -503,7 +503,7 @@ test_expect_success 'rewrite repository including refs that point at non-commit
 	git tag -a -m "tag to a tree" treetag $new_tree &&
 	git reset --hard HEAD &&
 	git filter-branch -f -- --all >filter-output 2>&1 &&
-	! grep fatal filter-output
+	test_grep ! fatal filter-output
 '
 
 test_expect_success 'filter-branch handles ref deletion' '
@@ -512,7 +512,7 @@ test_expect_success 'filter-branch handles ref deletion' '
 	git tag empty &&
 	git branch to-delete &&
 	git filter-branch -f --prune-empty to-delete >out 2>&1 &&
-	grep "to-delete.*was deleted" out &&
+	test_grep "to-delete.*was deleted" out &&
 	test_must_fail git rev-parse --verify to-delete
 '
 
@@ -523,8 +523,8 @@ test_expect_success 'filter-branch handles ref rewrite' '
 	git filter-branch -f \
 		--index-filter "git rm --ignore-unmatch --cached to-drop.t" \
 		 rewrite >out 2>&1 &&
-	grep "rewrite.*was rewritten" out &&
-	! grep -i warning out &&
+	test_grep "rewrite.*was rewritten" out &&
+	test_grep ! -i warning out &&
 	git diff-tree empty rewrite
 '
 
@@ -532,8 +532,8 @@ test_expect_success 'filter-branch handles ancestor rewrite' '
 	test_commit to-exclude &&
 	git branch ancestor &&
 	git filter-branch -f ancestor -- :^to-exclude.t >out 2>&1 &&
-	grep "ancestor.*was rewritten" out &&
-	! grep -i warning out &&
+	test_grep "ancestor.*was rewritten" out &&
+	test_grep ! -i warning out &&
 	git diff-tree HEAD^ ancestor
 '
 
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index d918005dd9..2ad30040df 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -937,7 +937,7 @@ test_expect_success 'git tag --format with ahead-behind' '
 	test_cmp expect actual.focus &&
 
 	# Error reported for tags that point to non-commits.
-	grep "error: object [0-9a-f]* is a blob, not a commit" err
+	test_grep "error: object [0-9a-f]* is a blob, not a commit" err
 '
 
 # trying to verify annotated non-signed tags:
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 9717e825f0..75ca7a25da 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -45,8 +45,8 @@ test_expect_success TTY 'LESS and LV envvars are set for pagination' '
 
 		test_terminal git log
 	) &&
-	grep ^LESS= pager-env.out &&
-	grep ^LV= pager-env.out
+	test_grep ^LESS= pager-env.out &&
+	test_grep ^LV= pager-env.out
 '
 
 test_expect_success !MINGW,TTY 'LESS and LV envvars set by git-sh-setup' '
@@ -58,8 +58,8 @@ test_expect_success !MINGW,TTY 'LESS and LV envvars set by git-sh-setup' '
 		export PATH &&
 		test_terminal sh -c ". git-sh-setup && git_pager"
 	) &&
-	grep ^LESS= pager-env.out &&
-	grep ^LV= pager-env.out
+	test_grep ^LESS= pager-env.out &&
+	test_grep ^LV= pager-env.out
 '
 
 test_expect_success TTY 'some commands do not use a pager' '
@@ -685,7 +685,7 @@ test_expect_success TTY 'git returns SIGPIPE on early pager exit' '
 
 	grep child_exit trace.normal >child-exits &&
 	test_line_count = 1 child-exits &&
-	grep " code:0 " child-exits &&
+	test_grep " code:0 " child-exits &&
 	test_path_is_file pager-used
 '
 
@@ -706,7 +706,7 @@ test_expect_success TTY 'git returns SIGPIPE on early pager non-zero exit' '
 
 	grep child_exit trace.normal >child-exits &&
 	test_line_count = 1 child-exits &&
-	grep " code:1 " child-exits &&
+	test_grep " code:1 " child-exits &&
 	test_path_is_file pager-used
 '
 
@@ -721,7 +721,7 @@ test_expect_success TTY 'git discards pager non-zero exit without SIGPIPE' '
 
 	grep child_exit trace.normal >child-exits &&
 	test_line_count = 1 child-exits &&
-	grep " code:1 " child-exits &&
+	test_grep " code:1 " child-exits &&
 	test_path_is_file pager-used
 '
 
@@ -749,7 +749,7 @@ test_expect_success TTY 'git returns SIGPIPE on propagated signals from pager' '
 
 	grep child_exit trace.normal >child-exits &&
 	test_line_count = 1 child-exits &&
-	grep " code:143 " child-exits &&
+	test_grep " code:143 " child-exits &&
 	test_path_is_file pager-used
 '
 
diff --git a/t/t7012-skip-worktree-writing.sh b/t/t7012-skip-worktree-writing.sh
index cd5c20fe51..526cc4ec83 100755
--- a/t/t7012-skip-worktree-writing.sh
+++ b/t/t7012-skip-worktree-writing.sh
@@ -30,7 +30,7 @@ test_expect_success 'read-tree updates worktree, dirty case' '
 	git update-index --skip-worktree init.t &&
 	echo dirty >> init.t &&
 	test_must_fail git read-tree -m -u HEAD^ &&
-	grep -q dirty init.t &&
+	test_grep -q dirty init.t &&
 	test "$(git ls-files -t init.t)" = "S init.t" &&
 	git update-index --no-skip-worktree init.t
 '
@@ -48,7 +48,7 @@ test_expect_success 'read-tree removes worktree, dirty case' '
 	git update-index --skip-worktree added &&
 	echo dirty >> added &&
 	test_must_fail git read-tree -m -u HEAD^ &&
-	grep -q dirty added &&
+	test_grep -q dirty added &&
 	test "$(git ls-files -t added)" = "S added" &&
 	git update-index --no-skip-worktree added
 '
@@ -173,7 +173,7 @@ test_expect_success 'stash restore in sparse checkout' '
 		echo in the way >modified &&
 		test_must_fail git stash apply 2>error&&
 
-		grep "changes.*would be overwritten by merge" error &&
+		test_grep "changes.*would be overwritten by merge" error &&
 
 		echo in the way >expect &&
 		test_cmp expect modified &&
diff --git a/t/t7030-verify-tag.sh b/t/t7030-verify-tag.sh
index 2c147072c1..b35f8ed1c0 100755
--- a/t/t7030-verify-tag.sh
+++ b/t/t7030-verify-tag.sh
@@ -63,8 +63,8 @@ test_expect_success GPG 'verify and show signatures' '
 		for tag in initial second merge fourth-signed sixth-signed seventh-signed
 		do
 			git verify-tag $tag 2>actual &&
-			grep "Good signature from" actual &&
-			! grep "BAD signature from" actual &&
+			test_grep "Good signature from" actual &&
+			test_grep ! "BAD signature from" actual &&
 			echo $tag OK || exit 1
 		done
 	) &&
@@ -72,8 +72,8 @@ test_expect_success GPG 'verify and show signatures' '
 		for tag in fourth-unsigned fifth-unsigned sixth-unsigned
 		do
 			test_must_fail git verify-tag $tag 2>actual &&
-			! grep "Good signature from" actual &&
-			! grep "BAD signature from" actual &&
+			test_grep ! "Good signature from" actual &&
+			test_grep ! "BAD signature from" actual &&
 			echo $tag OK || exit 1
 		done
 	) &&
@@ -81,9 +81,9 @@ test_expect_success GPG 'verify and show signatures' '
 		for tag in eighth-signed-alt
 		do
 			git verify-tag $tag 2>actual &&
-			grep "Good signature from" actual &&
-			! grep "BAD signature from" actual &&
-			grep "not certified" actual &&
+			test_grep "Good signature from" actual &&
+			test_grep ! "BAD signature from" actual &&
+			test_grep "not certified" actual &&
 			echo $tag OK || exit 1
 		done
 	)
@@ -91,32 +91,32 @@ test_expect_success GPG 'verify and show signatures' '
 
 test_expect_success GPGSM 'verify and show signatures x509' '
 	git verify-tag ninth-signed-x509 2>actual &&
-	grep "Good signature from" actual &&
-	! grep "BAD signature from" actual &&
+	test_grep "Good signature from" actual &&
+	test_grep ! "BAD signature from" actual &&
 	echo ninth-signed-x509 OK
 '
 
 test_expect_success GPGSM 'verify and show signatures x509 with low minTrustLevel' '
 	test_config gpg.minTrustLevel undefined &&
 	git verify-tag ninth-signed-x509 2>actual &&
-	grep "Good signature from" actual &&
-	! grep "BAD signature from" actual &&
+	test_grep "Good signature from" actual &&
+	test_grep ! "BAD signature from" actual &&
 	echo ninth-signed-x509 OK
 '
 
 test_expect_success GPGSM 'verify and show signatures x509 with matching minTrustLevel' '
 	test_config gpg.minTrustLevel fully &&
 	git verify-tag ninth-signed-x509 2>actual &&
-	grep "Good signature from" actual &&
-	! grep "BAD signature from" actual &&
+	test_grep "Good signature from" actual &&
+	test_grep ! "BAD signature from" actual &&
 	echo ninth-signed-x509 OK
 '
 
 test_expect_success GPGSM 'verify and show signatures x509 with high minTrustLevel' '
 	test_config gpg.minTrustLevel ultimate &&
 	test_must_fail git verify-tag ninth-signed-x509 2>actual &&
-	grep "Good signature from" actual &&
-	! grep "BAD signature from" actual &&
+	test_grep "Good signature from" actual &&
+	test_grep ! "BAD signature from" actual &&
 	echo ninth-signed-x509 OK
 '
 
@@ -125,8 +125,8 @@ test_expect_success GPG 'detect fudged signature' '
 	sed -e "/^tag / s/seventh/7th-forged/" raw >forged1 &&
 	git hash-object -w -t tag forged1 >forged1.tag &&
 	test_must_fail git verify-tag $(cat forged1.tag) 2>actual1 &&
-	grep "BAD signature from" actual1 &&
-	! grep "Good signature from" actual1
+	test_grep "BAD signature from" actual1 &&
+	test_grep ! "Good signature from" actual1
 '
 
 test_expect_success GPG 'verify signatures with --raw' '
@@ -134,8 +134,8 @@ test_expect_success GPG 'verify signatures with --raw' '
 		for tag in initial second merge fourth-signed sixth-signed seventh-signed
 		do
 			git verify-tag --raw $tag 2>actual &&
-			grep "GOODSIG" actual &&
-			! grep "BADSIG" actual &&
+			test_grep "GOODSIG" actual &&
+			test_grep ! "BADSIG" actual &&
 			echo $tag OK || exit 1
 		done
 	) &&
@@ -143,8 +143,8 @@ test_expect_success GPG 'verify signatures with --raw' '
 		for tag in fourth-unsigned fifth-unsigned sixth-unsigned
 		do
 			test_must_fail git verify-tag --raw $tag 2>actual &&
-			! grep "GOODSIG" actual &&
-			! grep "BADSIG" actual &&
+			test_grep ! "GOODSIG" actual &&
+			test_grep ! "BADSIG" actual &&
 			echo $tag OK || exit 1
 		done
 	) &&
@@ -152,9 +152,9 @@ test_expect_success GPG 'verify signatures with --raw' '
 		for tag in eighth-signed-alt
 		do
 			git verify-tag --raw $tag 2>actual &&
-			grep "GOODSIG" actual &&
-			! grep "BADSIG" actual &&
-			grep "TRUST_UNDEFINED" actual &&
+			test_grep "GOODSIG" actual &&
+			test_grep ! "BADSIG" actual &&
+			test_grep "TRUST_UNDEFINED" actual &&
 			echo $tag OK || exit 1
 		done
 	)
@@ -162,8 +162,8 @@ test_expect_success GPG 'verify signatures with --raw' '
 
 test_expect_success GPGSM 'verify signatures with --raw x509' '
 	git verify-tag --raw ninth-signed-x509 2>actual &&
-	grep "GOODSIG" actual &&
-	! grep "BADSIG" actual &&
+	test_grep "GOODSIG" actual &&
+	test_grep ! "BADSIG" actual &&
 	echo ninth-signed-x509 OK
 '
 
diff --git a/t/t7031-verify-tag-signed-ssh.sh b/t/t7031-verify-tag-signed-ssh.sh
index 80359d48f7..3000beb7c0 100755
--- a/t/t7031-verify-tag-signed-ssh.sh
+++ b/t/t7031-verify-tag-signed-ssh.sh
@@ -71,8 +71,8 @@ test_expect_success GPGSSH 'verify and show ssh signatures' '
 		for tag in initial second merge fourth-signed sixth-signed seventh-signed
 		do
 			git verify-tag $tag 2>actual &&
-			grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
-			! grep "${GPGSSH_BAD_SIGNATURE}" actual &&
+			test_grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
+			test_grep ! "${GPGSSH_BAD_SIGNATURE}" actual &&
 			echo $tag OK || exit 1
 		done
 	) &&
@@ -80,8 +80,8 @@ test_expect_success GPGSSH 'verify and show ssh signatures' '
 		for tag in fourth-unsigned fifth-unsigned sixth-unsigned
 		do
 			test_must_fail git verify-tag $tag 2>actual &&
-			! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
-			! grep "${GPGSSH_BAD_SIGNATURE}" actual &&
+			test_grep ! "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
+			test_grep ! "${GPGSSH_BAD_SIGNATURE}" actual &&
 			echo $tag OK || exit 1
 		done
 	) &&
@@ -89,9 +89,9 @@ test_expect_success GPGSSH 'verify and show ssh signatures' '
 		for tag in eighth-signed-alt
 		do
 			test_must_fail git verify-tag $tag 2>actual &&
-			grep "${GPGSSH_GOOD_SIGNATURE_UNTRUSTED}" actual &&
-			! grep "${GPGSSH_BAD_SIGNATURE}" actual &&
-			grep "${GPGSSH_KEY_NOT_TRUSTED}" actual &&
+			test_grep "${GPGSSH_GOOD_SIGNATURE_UNTRUSTED}" actual &&
+			test_grep ! "${GPGSSH_BAD_SIGNATURE}" actual &&
+			test_grep "${GPGSSH_KEY_NOT_TRUSTED}" actual &&
 			echo $tag OK || exit 1
 		done
 	)
@@ -100,26 +100,26 @@ test_expect_success GPGSSH 'verify and show ssh signatures' '
 test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'verify-tag exits failure on expired signature key' '
 	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
 	test_must_fail git verify-tag expired-signed 2>actual &&
-	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+	test_grep ! "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
 '
 
 test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'verify-tag exits failure on not yet valid signature key' '
 	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
 	test_must_fail git verify-tag notyetvalid-signed 2>actual &&
-	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+	test_grep ! "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
 '
 
 test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'verify-tag succeeds with tag date and key validity matching' '
 	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
 	git verify-tag timeboxedvalid-signed 2>actual &&
-	grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
-	! grep "${GPGSSH_BAD_SIGNATURE}" actual
+	test_grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
+	test_grep ! "${GPGSSH_BAD_SIGNATURE}" actual
 '
 
 test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'verify-tag fails with tag date outside of key validity' '
 	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
 	test_must_fail git verify-tag timeboxedinvalid-signed 2>actual &&
-	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+	test_grep ! "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
 '
 
 test_expect_success GPGSSH 'detect fudged ssh signature' '
@@ -128,9 +128,9 @@ test_expect_success GPGSSH 'detect fudged ssh signature' '
 	sed -e "/^tag / s/seventh/7th-forged/" raw >forged1 &&
 	git hash-object -w -t tag forged1 >forged1.tag &&
 	test_must_fail git verify-tag $(cat forged1.tag) 2>actual1 &&
-	grep "${GPGSSH_BAD_SIGNATURE}" actual1 &&
-	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual1 &&
-	! grep "${GPGSSH_GOOD_SIGNATURE_UNTRUSTED}" actual1
+	test_grep "${GPGSSH_BAD_SIGNATURE}" actual1 &&
+	test_grep ! "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual1 &&
+	test_grep ! "${GPGSSH_GOOD_SIGNATURE_UNTRUSTED}" actual1
 '
 
 test_expect_success GPGSSH 'verify ssh signatures with --raw' '
@@ -139,8 +139,8 @@ test_expect_success GPGSSH 'verify ssh signatures with --raw' '
 		for tag in initial second merge fourth-signed sixth-signed seventh-signed
 		do
 			git verify-tag --raw $tag 2>actual &&
-			grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
-			! grep "${GPGSSH_BAD_SIGNATURE}" actual &&
+			test_grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
+			test_grep ! "${GPGSSH_BAD_SIGNATURE}" actual &&
 			echo $tag OK || exit 1
 		done
 	) &&
@@ -148,8 +148,8 @@ test_expect_success GPGSSH 'verify ssh signatures with --raw' '
 		for tag in fourth-unsigned fifth-unsigned sixth-unsigned
 		do
 			test_must_fail git verify-tag --raw $tag 2>actual &&
-			! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
-			! grep "${GPGSSH_BAD_SIGNATURE}" actual &&
+			test_grep ! "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
+			test_grep ! "${GPGSSH_BAD_SIGNATURE}" actual &&
 			echo $tag OK || exit 1
 		done
 	) &&
@@ -157,8 +157,8 @@ test_expect_success GPGSSH 'verify ssh signatures with --raw' '
 		for tag in eighth-signed-alt
 		do
 			test_must_fail git verify-tag --raw $tag 2>actual &&
-			grep "${GPGSSH_GOOD_SIGNATURE_UNTRUSTED}" actual &&
-			! grep "${GPGSSH_BAD_SIGNATURE}" actual &&
+			test_grep "${GPGSSH_GOOD_SIGNATURE_UNTRUSTED}" actual &&
+			test_grep ! "${GPGSSH_BAD_SIGNATURE}" actual &&
 			echo $tag OK || exit 1
 		done
 	)
@@ -167,8 +167,8 @@ test_expect_success GPGSSH 'verify ssh signatures with --raw' '
 test_expect_success GPGSSH 'verify signatures with --raw ssh' '
 	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
 	git verify-tag --raw sixth-signed 2>actual &&
-	grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
-	! grep "${GPGSSH_BAD_SIGNATURE}" actual &&
+	test_grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
+	test_grep ! "${GPGSSH_BAD_SIGNATURE}" actual &&
 	echo sixth-signed OK
 '
 
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 0503a64d3f..298272cb13 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -87,7 +87,7 @@ do
 	test_expect_success "no 'git reset --no-$opt'" '
 		test_when_finished "rm -f err" &&
 		test_must_fail git reset --no-$opt 2>err &&
-		grep "error: unknown option .no-$opt." err
+		test_grep "error: unknown option .no-$opt." err
 	'
 done
 
diff --git a/t/t7110-reset-merge.sh b/t/t7110-reset-merge.sh
index 9a335071af..a241ecfc0b 100755
--- a/t/t7110-reset-merge.sh
+++ b/t/t7110-reset-merge.sh
@@ -29,16 +29,16 @@ test_expect_success setup '
 # file2:     C       D     D    D     --merge  C       D     D
 test_expect_success 'reset --merge is ok with changes in file it does not touch' '
 	git reset --merge HEAD^ &&
-	! grep 4 file1 &&
-	grep 4 file2 &&
+	test_grep ! 4 file1 &&
+	test_grep 4 file2 &&
 	test "$(git rev-parse HEAD)" = "$(git rev-parse initial)" &&
 	test -z "$(git diff --cached)"
 '
 
 test_expect_success 'reset --merge is ok when switching back' '
 	git reset --merge second &&
-	grep 4 file1 &&
-	grep 4 file2 &&
+	test_grep 4 file1 &&
+	test_grep 4 file2 &&
 	test "$(git rev-parse HEAD)" = "$(git rev-parse second)" &&
 	test -z "$(git diff --cached)"
 '
@@ -53,16 +53,16 @@ test_expect_success 'reset --keep is ok with changes in file it does not touch'
 	git reset --hard second &&
 	cat file1 >file2 &&
 	git reset --keep HEAD^ &&
-	! grep 4 file1 &&
-	grep 4 file2 &&
+	test_grep ! 4 file1 &&
+	test_grep 4 file2 &&
 	test "$(git rev-parse HEAD)" = "$(git rev-parse initial)" &&
 	test -z "$(git diff --cached)"
 '
 
 test_expect_success 'reset --keep is ok when switching back' '
 	git reset --keep second &&
-	grep 4 file1 &&
-	grep 4 file2 &&
+	test_grep 4 file1 &&
+	test_grep 4 file2 &&
 	test "$(git rev-parse HEAD)" = "$(git rev-parse second)" &&
 	test -z "$(git diff --cached)"
 '
@@ -79,9 +79,9 @@ test_expect_success 'reset --merge discards changes added to index (1)' '
 	echo "line 5" >> file1 &&
 	git add file1 &&
 	git reset --merge HEAD^ &&
-	! grep 4 file1 &&
-	! grep 5 file1 &&
-	grep 4 file2 &&
+	test_grep ! 4 file1 &&
+	test_grep ! 5 file1 &&
+	test_grep 4 file2 &&
 	test "$(git rev-parse HEAD)" = "$(git rev-parse initial)" &&
 	test -z "$(git diff --cached)"
 '
@@ -91,9 +91,9 @@ test_expect_success 'reset --merge is ok again when switching back (1)' '
 	echo "line 5" >> file2 &&
 	git add file2 &&
 	git reset --merge second &&
-	! grep 4 file2 &&
-	! grep 5 file1 &&
-	grep 4 file1 &&
+	test_grep ! 4 file2 &&
+	test_grep ! 5 file1 &&
+	test_grep 4 file1 &&
 	test "$(git rev-parse HEAD)" = "$(git rev-parse second)" &&
 	test -z "$(git diff --cached)"
 '
@@ -121,7 +121,7 @@ test_expect_success 'reset --merge discards changes added to index (2)' '
 	echo "line 4" >> file2 &&
 	git add file2 &&
 	git reset --merge HEAD^ &&
-	! grep 4 file2 &&
+	test_grep ! 4 file2 &&
 	test "$(git rev-parse HEAD)" = "$(git rev-parse initial)" &&
 	test -z "$(git diff)" &&
 	test -z "$(git diff --cached)"
@@ -130,8 +130,8 @@ test_expect_success 'reset --merge discards changes added to index (2)' '
 test_expect_success 'reset --merge is ok again when switching back (2)' '
 	git reset --hard initial &&
 	git reset --merge second &&
-	! grep 4 file2 &&
-	grep 4 file1 &&
+	test_grep ! 4 file2 &&
+	test_grep 4 file1 &&
 	test "$(git rev-parse HEAD)" = "$(git rev-parse second)" &&
 	test -z "$(git diff --cached)"
 '
@@ -147,15 +147,15 @@ test_expect_success 'reset --keep keeps changes it does not touch' '
 	echo "line 4" >> file2 &&
 	git add file2 &&
 	git reset --keep HEAD^ &&
-	grep 4 file2 &&
+	test_grep 4 file2 &&
 	test "$(git rev-parse HEAD)" = "$(git rev-parse initial)" &&
 	test -z "$(git diff --cached)"
 '
 
 test_expect_success 'reset --keep keeps changes when switching back' '
 	git reset --keep second &&
-	grep 4 file2 &&
-	grep 4 file1 &&
+	test_grep 4 file2 &&
+	test_grep 4 file1 &&
 	test "$(git rev-parse HEAD)" = "$(git rev-parse second)" &&
 	test -z "$(git diff --cached)"
 '
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 7613b1d2a4..0ddd1ad7aa 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -318,7 +318,7 @@ test_expect_success 'checkout to detach HEAD' '
 	git checkout -f renamer &&
 	git clean -f &&
 	git checkout renamer^ 2>messages &&
-	grep "HEAD is now at $rev" messages &&
+	test_grep "HEAD is now at $rev" messages &&
 	test_line_count -gt 1 messages &&
 	H=$(git rev-parse --verify HEAD) &&
 	M=$(git show-ref -s --verify refs/heads/main) &&
@@ -794,7 +794,7 @@ test_expect_success 'switch out of non-branch' '
 	git checkout main^0 &&
 	echo modified >one &&
 	test_must_fail git checkout renamer 2>error.log &&
-	! grep "^Previous HEAD" error.log
+	test_grep ! "^Previous HEAD" error.log
 '
 
 (
@@ -844,7 +844,7 @@ test_expect_success 'custom merge driver with checkout -m' '
 	(
 		for t in filfre-common left right
 		do
-			grep $t arm || exit 1
+			test_grep $t arm || exit 1
 		done
 	) &&
 
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 00d4070156..13ad3eec77 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -793,7 +793,7 @@ test_expect_success 'traverse into directories that may have ignored entries' '
 
 		git clean -fX modules/foobar >../output &&
 
-		grep Removing ../output &&
+		test_grep Removing ../output &&
 
 		test_path_is_missing modules/foobar/src/generated/code.c &&
 		test_path_is_file modules/foobar/Makefile
diff --git a/t/t7301-clean-interactive.sh b/t/t7301-clean-interactive.sh
index f743e5b8f4..de59ba3724 100755
--- a/t/t7301-clean-interactive.sh
+++ b/t/t7301-clean-interactive.sh
@@ -479,7 +479,7 @@ test_expect_success TTY 'git clean -i paints the header in HEADER color' '
 	test_decode_color |
 	head -n 1 >header &&
 	# not i18ngrep
-	grep "^<BOLD>" header
+	test_grep "^<BOLD>" header
 '
 
 test_done
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 65fcfae93a..eefdecb0bd 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -20,13 +20,13 @@ test_expect_success 'setup - enable local submodules' '
 
 test_expect_success 'submodule usage: -h' '
 	git submodule -h >out 2>err &&
-	grep "^usage: git submodule" out &&
+	test_grep "^usage: git submodule" out &&
 	test_must_be_empty err
 '
 
 test_expect_success 'submodule usage: --recursive' '
 	test_expect_code 1 git submodule --recursive >out 2>err &&
-	grep "^usage: git submodule" err &&
+	test_grep "^usage: git submodule" err &&
 	test_must_be_empty out
 '
 
@@ -214,14 +214,14 @@ test_expect_success 'setup parent and one repository' '
 test_expect_success 'redirected submodule add does not show progress' '
 	git -C addtest submodule add "file://$submodurl/parent" submod-redirected \
 		2>err &&
-	! grep % err &&
+	test_grep ! % err &&
 	test_grep ! "Checking connectivity" err
 '
 
 test_expect_success 'redirected submodule add --progress does show progress' '
 	git -C addtest submodule add --progress "file://$submodurl/parent" \
 		submod-redirected-progress 2>err && \
-	grep % err
+	test_grep % err
 '
 
 test_expect_success 'submodule add to .gitignored path fails' '
@@ -506,7 +506,7 @@ test_expect_success 'setup - fetch commit name from submodule' '
 
 test_expect_success 'status should initially be "missing"' '
 	git submodule status >lines &&
-	grep "^-$rev1" lines
+	test_grep "^-$rev1" lines
 '
 
 test_expect_success 'init should register submodule url in .git/config' '
@@ -524,7 +524,7 @@ test_expect_success 'status should still be "missing" after initializing' '
 	mkdir init &&
 	git submodule status >lines &&
 	rm -fr init &&
-	grep "^-$rev1" lines
+	test_grep "^-$rev1" lines
 '
 
 test_failure_with_unknown_submodule () {
@@ -584,7 +584,7 @@ test_expect_success 'update should work when path is an empty dir' '
 
 test_expect_success 'status should be "up-to-date" after update' '
 	git submodule status >list &&
-	grep "^ $rev1" list
+	test_grep "^ $rev1" list
 '
 
 test_expect_success 'status "up-to-date" from subdirectory' '
@@ -593,8 +593,8 @@ test_expect_success 'status "up-to-date" from subdirectory' '
 		cd sub &&
 		git submodule status >../list
 	) &&
-	grep "^ $rev1" list &&
-	grep "\\.\\./init" list
+	test_grep "^ $rev1" list &&
+	test_grep "\\.\\./init" list
 '
 
 test_expect_success 'status "up-to-date" from subdirectory with path' '
@@ -603,8 +603,8 @@ test_expect_success 'status "up-to-date" from subdirectory with path' '
 		cd sub &&
 		git submodule status ../init >../list
 	) &&
-	grep "^ $rev1" list &&
-	grep "\\.\\./init" list
+	test_grep "^ $rev1" list &&
+	test_grep "\\.\\./init" list
 '
 
 test_expect_success 'status should be "modified" after submodule commit' '
@@ -619,7 +619,7 @@ test_expect_success 'status should be "modified" after submodule commit' '
 	test -n "$rev2" &&
 	git submodule status >list &&
 
-	grep "^+$rev2" list
+	test_grep "^+$rev2" list
 '
 
 test_expect_success '"submodule --cached" command forms should be identical' '
@@ -634,12 +634,12 @@ test_expect_success '"submodule --cached" command forms should be identical' '
 
 test_expect_success 'the --cached sha1 should be rev1' '
 	git submodule --cached status >list &&
-	grep "^+$rev1" list
+	test_grep "^+$rev1" list
 '
 
 test_expect_success 'git diff should report the SHA1 of the new submodule commit' '
 	git diff >diff &&
-	grep "^+Subproject commit $rev2" diff
+	test_grep "^+Subproject commit $rev2" diff
 '
 
 test_expect_success 'update should checkout rev1' '
@@ -654,7 +654,7 @@ test_expect_success 'update should checkout rev1' '
 
 test_expect_success 'status should be "up-to-date" after update' '
 	git submodule status >list &&
-	grep "^ $rev1" list
+	test_grep "^ $rev1" list
 '
 
 test_expect_success 'checkout superproject with subproject already present' '
@@ -1407,7 +1407,7 @@ test_expect_success 'update submodules without url set in .gitconfig' '
 	done &&
 
 	test_must_fail git -C multisuper_clone submodule update 2>err &&
-	grep "cannot clone submodule .sub[0-3]. without a URL" err
+	test_grep "cannot clone submodule .sub[0-3]. without a URL" err
 '
 
 test_expect_success 'clone --recurse-submodules with a pathspec works' '
diff --git a/t/t7402-submodule-rebase.sh b/t/t7402-submodule-rebase.sh
index 06cee3432f..872eb2d3ab 100755
--- a/t/t7402-submodule-rebase.sh
+++ b/t/t7402-submodule-rebase.sh
@@ -125,7 +125,7 @@ test_expect_success 'rebasing submodule that should conflict' '
 	) >expect &&
 	test_cmp expect actual &&
 	sub_expect="go to submodule (submodule), and either merge commit $(git -C submodule rev-parse --short HEAD^0)" &&
-	grep "$sub_expect" actual_output
+	test_grep "$sub_expect" actual_output
 '
 
 test_done
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 6abb00876a..9554720152 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -627,10 +627,10 @@ test_expect_success 'submodule update - update=none in .git/config' '
 	  compare_head
 	 ) &&
 	 git diff --name-only >out &&
-	 grep ^submodule$ out &&
+	 test_grep ^submodule$ out &&
 	 git submodule update &&
 	 git diff --name-only >out &&
-	 grep ^submodule$ out &&
+	 test_grep ^submodule$ out &&
 	 (cd submodule &&
 	  compare_head
 	 ) &&
@@ -647,10 +647,10 @@ test_expect_success 'submodule update - update=none in .git/config but --checkou
 	  compare_head
 	 ) &&
 	 git diff --name-only >out &&
-	 grep ^submodule$ out &&
+	 test_grep ^submodule$ out &&
 	 git submodule update --checkout &&
 	 git diff --name-only >out &&
-	 ! grep ^submodule$ out &&
+	 test_grep ! ^submodule$ out &&
 	 (cd submodule &&
 	  ! compare_head
 	 ) &&
@@ -679,10 +679,10 @@ test_expect_success 'submodule update with pathspec warns against uninitialized
 		git submodule init submodule &&
 
 		git submodule update submodule 2>err &&
-		! grep "Submodule path .* not initialized" err &&
+		test_grep ! "Submodule path .* not initialized" err &&
 
 		git submodule update rebasing 2>err &&
-		grep "Submodule path .rebasing. not initialized" err &&
+		test_grep "Submodule path .rebasing. not initialized" err &&
 
 		test_path_exists submodule/.git &&
 		test_path_is_missing rebasing/.git
@@ -699,7 +699,7 @@ test_expect_success 'submodule update without pathspec updates only initialized
 		git submodule update 2>err &&
 		test_path_exists submodule/.git &&
 		test_path_is_missing rebasing/.git &&
-		! grep "Submodule path .* not initialized" err
+		test_grep ! "Submodule path .* not initialized" err
 	)
 
 '
@@ -1046,12 +1046,12 @@ test_expect_success 'submodule update --recursive drops module name before recur
 test_expect_success 'submodule update can be run in parallel' '
 	(cd super2 &&
 	 GIT_TRACE=$(pwd)/trace.out git submodule update --jobs 7 &&
-	 grep "7 tasks" trace.out &&
+	 test_grep "7 tasks" trace.out &&
 	 git config submodule.fetchJobs 8 &&
 	 GIT_TRACE=$(pwd)/trace.out git submodule update &&
-	 grep "8 tasks" trace.out &&
+	 test_grep "8 tasks" trace.out &&
 	 GIT_TRACE=$(pwd)/trace.out git submodule update --jobs 9 &&
-	 grep "9 tasks" trace.out
+	 test_grep "9 tasks" trace.out
 	)
 '
 
@@ -1066,14 +1066,14 @@ test_expect_success 'submodule update honors fetch jobs config from .gitmodules'
 test_expect_success 'git clone passes the parallel jobs config on to submodules' '
 	test_when_finished "rm -rf super4" &&
 	GIT_TRACE=$(pwd)/trace.out git clone --recurse-submodules --jobs 7 . super4 &&
-	grep "7 tasks" trace.out &&
+	test_grep "7 tasks" trace.out &&
 	rm -rf super4 &&
 	git config --global submodule.fetchJobs 8 &&
 	GIT_TRACE=$(pwd)/trace.out git clone --recurse-submodules . super4 &&
-	grep "8 tasks" trace.out &&
+	test_grep "8 tasks" trace.out &&
 	rm -rf super4 &&
 	GIT_TRACE=$(pwd)/trace.out git clone --recurse-submodules --jobs 9 . super4 &&
-	grep "9 tasks" trace.out &&
+	test_grep "9 tasks" trace.out &&
 	rm -rf super4
 '
 
diff --git a/t/t7416-submodule-dash-url.sh b/t/t7416-submodule-dash-url.sh
index 3d944a00e0..9f4af88ed5 100755
--- a/t/t7416-submodule-dash-url.sh
+++ b/t/t7416-submodule-dash-url.sh
@@ -49,7 +49,7 @@ test_expect_success 'fsck rejects unprotected dash' '
 	git init --bare dst &&
 	git -C dst config transfer.fsckObjects true &&
 	test_must_fail git push dst HEAD 2>err &&
-	grep gitmodulesUrl err
+	test_grep gitmodulesUrl err
 '
 
 test_expect_success 'trailing backslash is handled correctly' '
@@ -79,7 +79,7 @@ test_expect_success 'fsck rejects missing URL scheme' '
 	git init --bare dst &&
 	git -C dst config transfer.fsckObjects true &&
 	test_must_fail git push dst HEAD 2>err &&
-	grep gitmodulesUrl err
+	test_grep gitmodulesUrl err
 '
 
 test_expect_success 'fsck rejects relative URL resolving to missing scheme' '
@@ -95,7 +95,7 @@ test_expect_success 'fsck rejects relative URL resolving to missing scheme' '
 	git init --bare dst &&
 	git -C dst config transfer.fsckObjects true &&
 	test_must_fail git push dst HEAD 2>err &&
-	grep gitmodulesUrl err
+	test_grep gitmodulesUrl err
 '
 
 test_expect_success 'fsck rejects empty URL scheme' '
@@ -111,7 +111,7 @@ test_expect_success 'fsck rejects empty URL scheme' '
 	git init --bare dst &&
 	git -C dst config transfer.fsckObjects true &&
 	test_must_fail git push dst HEAD 2>err &&
-	grep gitmodulesUrl err
+	test_grep gitmodulesUrl err
 '
 
 test_expect_success 'fsck rejects relative URL resolving to empty scheme' '
@@ -127,7 +127,7 @@ test_expect_success 'fsck rejects relative URL resolving to empty scheme' '
 	git init --bare dst &&
 	git -C dst config transfer.fsckObjects true &&
 	test_must_fail git push dst HEAD 2>err &&
-	grep gitmodulesUrl err
+	test_grep gitmodulesUrl err
 '
 
 test_expect_success 'fsck rejects empty hostname' '
@@ -143,7 +143,7 @@ test_expect_success 'fsck rejects empty hostname' '
 	git init --bare dst &&
 	git -C dst config transfer.fsckObjects true &&
 	test_must_fail git push dst HEAD 2>err &&
-	grep gitmodulesUrl err
+	test_grep gitmodulesUrl err
 '
 
 test_expect_success 'fsck rejects relative url that produced empty hostname' '
@@ -159,7 +159,7 @@ test_expect_success 'fsck rejects relative url that produced empty hostname' '
 	git init --bare dst &&
 	git -C dst config transfer.fsckObjects true &&
 	test_must_fail git push dst HEAD 2>err &&
-	grep gitmodulesUrl err
+	test_grep gitmodulesUrl err
 '
 
 test_expect_success 'fsck permits embedded newline with unrecognized scheme' '
@@ -189,7 +189,7 @@ test_expect_success 'fsck rejects embedded newline in url' '
 	git init --bare dst &&
 	git -C dst config transfer.fsckObjects true &&
 	test_must_fail git push dst HEAD 2>err &&
-	grep gitmodulesUrl err
+	test_grep gitmodulesUrl err
 '
 
 test_expect_success 'fsck rejects embedded newline in relative url' '
@@ -204,7 +204,7 @@ test_expect_success 'fsck rejects embedded newline in relative url' '
 	git init --bare dst &&
 	git -C dst config transfer.fsckObjects true &&
 	test_must_fail git push dst HEAD 2>err &&
-	grep gitmodulesUrl err
+	test_grep gitmodulesUrl err
 '
 
 test_expect_success 'fsck rejects embedded newline in git url' '
@@ -219,7 +219,7 @@ test_expect_success 'fsck rejects embedded newline in git url' '
 	git init --bare dst &&
 	git -C dst config transfer.fsckObjects true &&
 	test_must_fail git push dst HEAD 2>err &&
-	grep gitmodulesUrl err
+	test_grep gitmodulesUrl err
 '
 
 test_done
diff --git a/t/t7417-submodule-path-url.sh b/t/t7417-submodule-path-url.sh
index 5e3051da8b..7a6f61585b 100755
--- a/t/t7417-submodule-path-url.sh
+++ b/t/t7417-submodule-path-url.sh
@@ -29,7 +29,7 @@ test_expect_success 'fsck rejects unprotected dash' '
 	git init --bare dst &&
 	git -C dst config transfer.fsckObjects true &&
 	test_must_fail git push dst HEAD 2>err &&
-	grep gitmodulesPath err
+	test_grep gitmodulesPath err
 '
 
 test_expect_success MINGW 'submodule paths disallows trailing spaces' '
diff --git a/t/t7450-bad-git-dotfiles.sh b/t/t7450-bad-git-dotfiles.sh
index 8cc86522b2..15ebfab199 100755
--- a/t/t7450-bad-git-dotfiles.sh
+++ b/t/t7450-bad-git-dotfiles.sh
@@ -109,7 +109,7 @@ test_expect_success 'add other submodule' '
 
 test_expect_success 'clone evil superproject' '
 	git clone --recurse-submodules . victim >output 2>&1 &&
-	! grep "RUNNING POST CHECKOUT" output
+	test_grep ! "RUNNING POST CHECKOUT" output
 '
 
 test_expect_success 'fsck detects evil superproject' '
@@ -167,7 +167,7 @@ test_expect_success 'index-pack --strict works for non-repo pack' '
 	test_must_fail git -C dst.git index-pack --strict odd.pack 2>output &&
 	# Make sure we fail due to bad gitmodules content, not because we
 	# could not read the blob in the first place.
-	grep gitmodulesName output
+	test_grep gitmodulesName output
 '
 
 check_dotx_symlink () {
@@ -216,7 +216,7 @@ check_dotx_symlink () {
 			# Check not only that we fail, but that it is due to the
 			# symlink detector
 			$fsck_must_fail git fsck 2>output &&
-			grep "$fsck_prefix.*tree $tree: ${name}Symlink" output
+			test_grep "$fsck_prefix.*tree $tree: ${name}Symlink" output
 		)
 	'
 
@@ -228,7 +228,7 @@ check_dotx_symlink () {
 				    -c core.protectntfs \
 				    -c core.protecthfs \
 				    read-tree $tree 2>err &&
-			grep "invalid path.*$name" err &&
+			test_grep "invalid path.*$name" err &&
 			git -C $dir ls-files -s >out &&
 			test_must_be_empty out
 		'
@@ -317,7 +317,11 @@ test_expect_success WINDOWS 'prevent git~1 squatting on Windows' '
 		test_must_fail git -c core.protectNTFS=false \
 			clone --recurse-submodules squatting squatting-clone 2>err &&
 		test_grep -e "directory not empty" -e "not an empty directory" err &&
-		! grep gitdir squatting-clone/d/a/git~2
+		# git~2 is the 8.3 short name of the ..git decoy, present
+		# only when 8.3 name generation is on; a missing git~2 is
+		# fine because the "directory not empty" check above is the
+		# real assertion.
+		! grep gitdir squatting-clone/d/a/git~2 # lint-ok: 8.3 short name git~2 may not exist
 	fi
 '
 
@@ -350,7 +354,7 @@ test_expect_success 'git dirs of sibling submodules must not be nested' '
 test_expect_success 'submodule git dir nesting detection must work with parallel cloning' '
 	test_must_fail git clone --recurse-submodules --jobs=2 nested clone_parallel 2>err &&
 	cat err &&
-	grep -E "(already exists|is inside git dir|not a git repository)" err &&
+	test_grep -E "(already exists|is inside git dir|not a git repository)" err &&
 	{
 		test_path_is_missing .git/modules/hippo/HEAD ||
 		test_path_is_missing .git/modules/hippo/hooks/HEAD
@@ -370,7 +374,7 @@ test_expect_success 'checkout -f --recurse-submodules must not use a nested gitd
 	) &&
 	test_must_fail git -C nested_checkout checkout -f --recurse-submodules HEAD 2>err &&
 	cat err &&
-	grep "is inside git dir" err &&
+	test_grep "is inside git dir" err &&
 	test_path_is_missing nested_checkout/thing2/.git
 '
 
diff --git a/t/t7501-commit-basic-functionality.sh b/t/t7501-commit-basic-functionality.sh
index a37509f004..7794babe46 100755
--- a/t/t7501-commit-basic-functionality.sh
+++ b/t/t7501-commit-basic-functionality.sh
@@ -342,12 +342,12 @@ test_expect_success 'overriding author from command line' '
 	echo gak >file &&
 	git commit -m author \
 		--author "Rubber Duck <rduck@convoy.org>" -a >output 2>&1 &&
-	grep Rubber.Duck output
+	test_grep Rubber.Duck output
 '
 
 test_expect_success 'interactive add' '
 	echo 7 | test_must_fail git commit --interactive >out &&
-	grep "What now" out
+	test_grep "What now" out
 '
 
 test_expect_success "commit --interactive doesn't change index if editor aborts" '
@@ -376,13 +376,13 @@ test_expect_success 'editor not invoked if -F is given' '
 
 	EDITOR=./editor git commit -a -F msg &&
 	git show -s --pretty=format:%s >subject &&
-	grep -q good subject &&
+	test_grep -q good subject &&
 
 	echo quack >file &&
 	echo Another good message. |
 	EDITOR=./editor git commit -a -F - &&
 	git show -s --pretty=format:%s >subject &&
-	grep -q good subject
+	test_grep -q good subject
 '
 
 test_expect_success 'partial commit that involves removal (1)' '
@@ -471,7 +471,7 @@ test_expect_success 'amend does not add signoff if it already exists' '
 
 test_expect_success 'commit mentions forced date in output' '
 	git commit --amend --date=2010-01-02T03:04:05 >output &&
-	grep "Date: *Sat Jan 2 03:04:05 2010" output
+	test_grep "Date: *Sat Jan 2 03:04:05 2010" output
 '
 
 test_expect_success 'commit complains about completely bogus dates' '
@@ -660,9 +660,9 @@ test_expect_success 'git commit <file> with dirty index' '
 	git add chz &&
 	git commit elif -m "tacocat is a palindrome" &&
 	git show --stat >stat &&
-	grep elif stat &&
+	test_grep elif stat &&
 	git diff --cached >diff &&
-	grep chz diff
+	test_grep chz diff
 '
 
 test_expect_success 'same tree (single parent)' '
@@ -676,7 +676,7 @@ test_expect_success 'same tree (single parent) --allow-empty' '
 
 	git commit --allow-empty -m "forced empty" &&
 	git cat-file commit HEAD >commit &&
-	grep forced commit
+	test_grep forced commit
 
 '
 
diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
index 05f6da4ad9..62e3970e3f 100755
--- a/t/t7502-commit-porcelain.sh
+++ b/t/t7502-commit-porcelain.sh
@@ -529,7 +529,7 @@ test_expect_success 'verbose respects diff config' '
 
 	test_config diff.noprefix true &&
 	git status -v >actual &&
-	grep "diff --git negative negative" actual
+	test_grep "diff --git negative negative" actual
 '
 
 mesg_with_comment_and_newlines='
diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
index acdb6b1455..8e9d8ff3ae 100755
--- a/t/t7507-commit-verbose.sh
+++ b/t/t7507-commit-verbose.sh
@@ -106,13 +106,13 @@ test_expect_success 'verbose diff is stripped with multi-byte comment char' '
 		export GIT_EDITOR &&
 		test_must_fail git -c core.commentchar="foo>" commit -a -v >out 2>err
 	) &&
-	grep "^foo> " out &&
+	test_grep "^foo> " out &&
 	test_grep "Aborting commit due to empty commit message." err
 '
 
 test_expect_success 'status does not verbose without --verbose' '
 	git status >actual &&
-	! grep "^diff --git" actual
+	test_grep ! "^diff --git" actual
 '
 
 test_expect_success 'setup -v -v' '
@@ -163,7 +163,7 @@ done
 
 test_expect_success "status ignores commit.verbose=true" '
 	git -c commit.verbose=true status >actual &&
-	! grep "^diff --git" actual
+	test_grep ! "^diff --git" actual
 '
 
 test_done
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index c2057bc94c..c37ffbe444 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -863,7 +863,7 @@ test_expect_success 'status -s without relative paths' '
 	test_cmp expect output &&
 
 	git status -s --ignored >output &&
-	grep "^!! \"expect with spaces\"$" output &&
+	test_grep "^!! \"expect with spaces\"$" output &&
 	grep -v "^!! " output >output-wo-ignored &&
 	test_cmp expect output-wo-ignored
 '
@@ -908,7 +908,7 @@ test_expect_success 'status shows detached HEAD properly after checking out non-
 	git clone upstream downstream &&
 	git -C downstream checkout @{u} &&
 	git -C downstream status >actual &&
-	grep -E "HEAD detached at [0-9a-f]+" actual
+	test_grep -E "HEAD detached at [0-9a-f]+" actual
 '
 
 test_expect_success 'setup status submodule summary' '
@@ -1127,7 +1127,7 @@ test_expect_success POSIXPERM,SANITY 'status succeeds in a read-only repository'
 		# make dir1/tracked stat-dirty
 		>dir1/tracked1 && mv -f dir1/tracked1 dir1/tracked &&
 		git status -s >output &&
-		! grep dir1/tracked output &&
+		test_grep ! dir1/tracked output &&
 		# make sure "status" succeeded without writing index out
 		git diff-files | grep dir1/tracked
 	)
diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index aa9108da54..67c104a0f3 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -89,8 +89,8 @@ test_expect_success GPG 'verify and show signatures' '
 		do
 			git verify-commit $commit &&
 			git show --pretty=short --show-signature $commit >actual &&
-			grep "Good signature from" actual &&
-			! grep "BAD signature from" actual &&
+			test_grep "Good signature from" actual &&
+			test_grep ! "BAD signature from" actual &&
 			echo $commit OK || exit 1
 		done
 	) &&
@@ -100,8 +100,8 @@ test_expect_success GPG 'verify and show signatures' '
 		do
 			test_must_fail git verify-commit $commit &&
 			git show --pretty=short --show-signature $commit >actual &&
-			! grep "Good signature from" actual &&
-			! grep "BAD signature from" actual &&
+			test_grep ! "Good signature from" actual &&
+			test_grep ! "BAD signature from" actual &&
 			echo $commit OK || exit 1
 		done
 	) &&
@@ -109,9 +109,9 @@ test_expect_success GPG 'verify and show signatures' '
 		for commit in eighth-signed-alt twelfth-signed-alt
 		do
 			git show --pretty=short --show-signature $commit >actual &&
-			grep "Good signature from" actual &&
-			! grep "BAD signature from" actual &&
-			grep "not certified" actual &&
+			test_grep "Good signature from" actual &&
+			test_grep ! "BAD signature from" actual &&
+			test_grep "not certified" actual &&
 			echo $commit OK || exit 1
 		done
 	)
@@ -119,16 +119,16 @@ test_expect_success GPG 'verify and show signatures' '
 
 test_expect_success GPG 'verify-commit exits failure on unknown signature' '
 	test_must_fail env GNUPGHOME="$GNUPGHOME_NOT_USED" git verify-commit initial 2>actual &&
-	! grep "Good signature from" actual &&
-	! grep "BAD signature from" actual &&
-	grep -q -F -e "No public key" -e "public key not found" actual
+	test_grep ! "Good signature from" actual &&
+	test_grep ! "BAD signature from" actual &&
+	test_grep -q -F -e "No public key" -e "public key not found" actual
 '
 
 test_expect_success GPG 'verify-commit exits success on untrusted signature' '
 	git verify-commit eighth-signed-alt 2>actual &&
-	grep "Good signature from" actual &&
-	! grep "BAD signature from" actual &&
-	grep "not certified" actual
+	test_grep "Good signature from" actual &&
+	test_grep ! "BAD signature from" actual &&
+	test_grep "not certified" actual
 '
 
 test_expect_success GPG 'verify-commit exits success with matching minTrustLevel' '
@@ -151,8 +151,8 @@ test_expect_success GPG 'verify signatures with --raw' '
 		for commit in initial second merge fourth-signed fifth-signed sixth-signed seventh-signed
 		do
 			git verify-commit --raw $commit 2>actual &&
-			grep "GOODSIG" actual &&
-			! grep "BADSIG" actual &&
+			test_grep "GOODSIG" actual &&
+			test_grep ! "BADSIG" actual &&
 			echo $commit OK || exit 1
 		done
 	) &&
@@ -160,8 +160,8 @@ test_expect_success GPG 'verify signatures with --raw' '
 		for commit in merge^2 fourth-unsigned sixth-unsigned seventh-unsigned
 		do
 			test_must_fail git verify-commit --raw $commit 2>actual &&
-			! grep "GOODSIG" actual &&
-			! grep "BADSIG" actual &&
+			test_grep ! "GOODSIG" actual &&
+			test_grep ! "BADSIG" actual &&
 			echo $commit OK || exit 1
 		done
 	) &&
@@ -169,9 +169,9 @@ test_expect_success GPG 'verify signatures with --raw' '
 		for commit in eighth-signed-alt
 		do
 			git verify-commit --raw $commit 2>actual &&
-			grep "GOODSIG" actual &&
-			! grep "BADSIG" actual &&
-			grep "TRUST_UNDEFINED" actual &&
+			test_grep "GOODSIG" actual &&
+			test_grep ! "BADSIG" actual &&
+			test_grep "TRUST_UNDEFINED" actual &&
 			echo $commit OK || exit 1
 		done
 	)
@@ -179,7 +179,7 @@ test_expect_success GPG 'verify signatures with --raw' '
 
 test_expect_success GPG 'proper header is used for hash algorithm' '
 	git cat-file commit fourth-signed >output &&
-	grep "^$(test_oid header) -----BEGIN PGP SIGNATURE-----" output
+	test_grep "^$(test_oid header) -----BEGIN PGP SIGNATURE-----" output
 '
 
 test_expect_success GPG 'show signed commit with signature' '
@@ -201,8 +201,8 @@ test_expect_success GPG 'detect fudged signature' '
 	git hash-object -w -t commit forged1 >forged1.commit &&
 	test_must_fail git verify-commit $(cat forged1.commit) &&
 	git show --pretty=short --show-signature $(cat forged1.commit) >actual1 &&
-	grep "BAD signature from" actual1 &&
-	! grep "Good signature from" actual1
+	test_grep "BAD signature from" actual1 &&
+	test_grep ! "Good signature from" actual1
 '
 
 test_expect_success GPG 'detect fudged signature with NUL' '
@@ -212,8 +212,8 @@ test_expect_success GPG 'detect fudged signature with NUL' '
 	git hash-object --literally -w -t commit forged2 >forged2.commit &&
 	test_must_fail git verify-commit $(cat forged2.commit) &&
 	git show --pretty=short --show-signature $(cat forged2.commit) >actual2 &&
-	grep "BAD signature from" actual2 &&
-	! grep "Good signature from" actual2
+	test_grep "BAD signature from" actual2 &&
+	test_grep ! "Good signature from" actual2
 '
 
 test_expect_success GPG 'amending already signed commit' '
@@ -221,8 +221,8 @@ test_expect_success GPG 'amending already signed commit' '
 	git commit --amend -S --no-edit &&
 	git verify-commit HEAD &&
 	git show -s --show-signature HEAD >actual &&
-	grep "Good signature from" actual &&
-	! grep "BAD signature from" actual
+	test_grep "Good signature from" actual &&
+	test_grep ! "BAD signature from" actual
 '
 
 test_expect_success GPG2 'bare signature' '
@@ -326,8 +326,8 @@ test_expect_success GPG 'show lack of signature with custom format' '
 test_expect_success GPG 'log.showsignature behaves like --show-signature' '
 	test_config log.showsignature true &&
 	git show initial >actual &&
-	grep "gpg: Signature made" actual &&
-	grep "gpg: Good signature" actual
+	test_grep "gpg: Signature made" actual &&
+	test_grep "gpg: Good signature" actual
 '
 
 test_expect_success GPG 'check config gpg.format values' '
@@ -349,8 +349,8 @@ test_expect_success GPG 'detect fudged commit with double signature' '
 	git hash-object -w -t commit double-commit >double-commit.commit &&
 	test_must_fail git verify-commit $(cat double-commit.commit) &&
 	git show --pretty=short --show-signature $(cat double-commit.commit) >double-actual &&
-	grep "BAD signature from" double-actual &&
-	grep "Good signature from" double-actual
+	test_grep "BAD signature from" double-actual &&
+	test_grep "Good signature from" double-actual
 '
 
 test_expect_success GPG 'show double signature with custom format' '
@@ -404,8 +404,8 @@ test_expect_success GPG 'verify-commit verifies multiply signed commits' '
 	head=$(git hash-object -t commit -w commit) &&
 	git reset --hard $head &&
 	git verify-commit $head 2>actual &&
-	grep "Good signature from" actual &&
-	! grep "BAD signature from" actual
+	test_grep "Good signature from" actual &&
+	test_grep ! "BAD signature from" actual
 '
 
 test_expect_success 'custom `gpg.program`' '
@@ -449,7 +449,7 @@ test_expect_success 'custom `gpg.program`' '
 
 	test_must_fail env LET_GPG_PROGRAM_FAIL=1 \
 	git commit -S --allow-empty -m must-fail 2>err &&
-	grep zOMG err &&
+	test_grep zOMG err &&
 
 	# `gpg.program` starts with `~`, the path should be interpreted to be relative to `$HOME`
 	test_config gpg.program "~/fake-gpg" &&
diff --git a/t/t7516-commit-races.sh b/t/t7516-commit-races.sh
index de7c4ca790..29669f64ae 100755
--- a/t/t7516-commit-races.sh
+++ b/t/t7516-commit-races.sh
@@ -10,7 +10,7 @@ test_expect_success 'race to create orphan commit' '
 	EOF
 	test_must_fail env EDITOR=./hare-editor git commit --allow-empty -m tortoise -e &&
 	git show -s --pretty=format:%s >subject &&
-	grep hare subject &&
+	test_grep hare subject &&
 	git show -s --pretty=format:%P >out &&
 	test_must_be_empty out
 '
@@ -24,7 +24,7 @@ test_expect_success 'race to create non-orphan commit' '
 	git rev-parse HEAD >base &&
 	test_must_fail env EDITOR=./airplane-editor git commit --allow-empty -m ship -e &&
 	git show -s --pretty=format:%s >subject &&
-	grep airplane subject &&
+	test_grep airplane subject &&
 	git rev-parse HEAD^ >parent &&
 	test_cmp base parent
 '
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index 7ee69ecdd4..93973ed25a 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -63,19 +63,19 @@ test_expect_success 'incompatible bare repo' '
 	test_must_fail \
 		git -C ./bare-clone -c core.fsmonitor=foo \
 			update-index --fsmonitor 2>actual &&
-	grep "bare repository .* is incompatible with fsmonitor" actual &&
+	test_grep "bare repository .* is incompatible with fsmonitor" actual &&
 
 	test_must_fail \
 		git -C ./bare-clone -c core.fsmonitor=true \
 			update-index --fsmonitor 2>actual &&
-	grep "bare repository .* is incompatible with fsmonitor" actual
+	test_grep "bare repository .* is incompatible with fsmonitor" actual
 '
 
 test_expect_success FSMONITOR_DAEMON 'run fsmonitor-daemon in bare repo' '
 	test_when_finished "rm -rf ./bare-clone actual" &&
 	git init --bare bare-clone &&
 	test_must_fail git -C ./bare-clone fsmonitor--daemon run 2>actual &&
-	grep "bare repository .* is incompatible with fsmonitor" actual
+	test_grep "bare repository .* is incompatible with fsmonitor" actual
 '
 
 test_expect_success MINGW,FSMONITOR_DAEMON 'run fsmonitor-daemon in virtual repo' '
@@ -84,7 +84,7 @@ test_expect_success MINGW,FSMONITOR_DAEMON 'run fsmonitor-daemon in virtual repo
 	test_must_fail git -C ./fake-virtual-clone \
 			   -c core.virtualfilesystem=true \
 			   fsmonitor--daemon run 2>actual &&
-	grep "virtual repository .* is incompatible with fsmonitor" actual
+	test_grep "virtual repository .* is incompatible with fsmonitor" actual
 '
 
 test_expect_success 'setup' '
@@ -111,21 +111,21 @@ test_expect_success 'setup' '
 # test that the fsmonitor extension is off by default
 test_expect_success 'fsmonitor extension is off by default' '
 	test-tool dump-fsmonitor >actual &&
-	grep "^no fsmonitor" actual
+	test_grep "^no fsmonitor" actual
 '
 
 # test that "update-index --fsmonitor" adds the fsmonitor extension
 test_expect_success 'update-index --fsmonitor" adds the fsmonitor extension' '
 	git update-index --fsmonitor &&
 	test-tool dump-fsmonitor >actual &&
-	grep "^fsmonitor last update" actual
+	test_grep "^fsmonitor last update" actual
 '
 
 # test that "update-index --no-fsmonitor" removes the fsmonitor extension
 test_expect_success 'update-index --no-fsmonitor" removes the fsmonitor extension' '
 	git update-index --no-fsmonitor &&
 	test-tool dump-fsmonitor >actual &&
-	grep "^no fsmonitor" actual
+	test_grep "^no fsmonitor" actual
 '
 
 cat >expect <<EOF &&
diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index d881e27466..86195770e9 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -158,7 +158,7 @@ test_expect_success 'implicit daemon start' '
 	GIT_TRACE2_EVENT="$PWD/.git/trace" \
 		test-tool -C test_implicit fsmonitor-client query --token 0 >actual &&
 	nul_to_q <actual >actual.filtered &&
-	grep "builtin:" actual.filtered &&
+	test_grep "builtin:" actual.filtered &&
 
 	# confirm that a daemon was started in the background.
 	#
@@ -312,7 +312,7 @@ test_expect_success 'cannot start multiple daemons' '
 	start_daemon -C test_multiple &&
 
 	test_must_fail git -C test_multiple fsmonitor--daemon start 2>actual &&
-	grep "fsmonitor--daemon is already running" actual &&
+	test_grep "fsmonitor--daemon is already running" actual &&
 
 	git -C test_multiple fsmonitor--daemon stop &&
 	test_must_fail git -C test_multiple fsmonitor--daemon status
@@ -622,7 +622,7 @@ test_expect_success 'flush cached data' '
 	test-tool -C test_flush fsmonitor-client query --token "builtin:test_00000001:0" >actual_1 &&
 	nul_to_q <actual_1 >actual_q1 &&
 
-	grep "file_1" actual_q1 &&
+	test_grep "file_1" actual_q1 &&
 
 	# Force a flush.  This will change the <token_id>, reset the <seq_nr>, and
 	# flush the file data.  Then create some events and ensure that the file
@@ -630,19 +630,19 @@ test_expect_success 'flush cached data' '
 
 	test-tool -C test_flush fsmonitor-client flush >flush_0 &&
 	nul_to_q <flush_0 >flush_q0 &&
-	grep "^builtin:test_00000002:0Q/Q$" flush_q0 &&
+	test_grep "^builtin:test_00000002:0Q/Q$" flush_q0 &&
 
 	test-tool -C test_flush fsmonitor-client query --token "builtin:test_00000002:0" >actual_2 &&
 	nul_to_q <actual_2 >actual_q2 &&
 
-	grep "^builtin:test_00000002:0Q$" actual_q2 &&
+	test_grep "^builtin:test_00000002:0Q$" actual_q2 &&
 
 	>test_flush/file_3 &&
 
 	test-tool -C test_flush fsmonitor-client query --token "builtin:test_00000002:0" >actual_3 &&
 	nul_to_q <actual_3 >actual_q3 &&
 
-	grep "file_3" actual_q3
+	test_grep "file_3" actual_q3
 '
 
 # The next few test cases create repos where the .git directory is NOT
@@ -815,7 +815,7 @@ do
 
 		start_daemon -C "$u" &&
 		git -C "$u" status >actual &&
-		grep "new file:   file1" actual
+		test_grep "new file:   file1" actual
 	'
 done
 
@@ -1069,9 +1069,9 @@ test_expect_success CASE_INSENSITIVE_FS 'case insensitive+preserving' '
 	# directories and files that we touched.  We may or may not get a
 	# trailing slash on modified directories.
 	#
-	grep -E "^event: abc/?$"       ./insensitive.trace &&
-	grep -E "^event: abc/def/?$"   ./insensitive.trace &&
-	grep -E "^event: abc/def/xyz$" ./insensitive.trace
+	test_grep -E "^event: abc/?$"       ./insensitive.trace &&
+	test_grep -E "^event: abc/def/?$"   ./insensitive.trace &&
+	test_grep -E "^event: abc/def/xyz$" ./insensitive.trace
 '
 
 # The variable "unicode_debug" is defined in the following library
@@ -1113,20 +1113,20 @@ test_expect_success !UNICODE_COMPOSITION_SENSITIVE 'Unicode nfc/nfd' '
 	then
 		# We should have seen NFC event from OS.
 		# We should not have synthesized an NFD event.
-		grep -E    "^event: nfc/c_${utf8_nfc}/?$" ./unicode.trace &&
-		grep -E -v "^event: nfc/c_${utf8_nfd}/?$" ./unicode.trace
+		test_grep -E    "^event: nfc/c_${utf8_nfc}/?$" ./unicode.trace &&
+		test_grep -E -v "^event: nfc/c_${utf8_nfd}/?$" ./unicode.trace
 	else
 		# We should have seen NFD event from OS.
 		# We should have synthesized an NFC event.
-		grep -E "^event: nfc/c_${utf8_nfd}/?$" ./unicode.trace &&
-		grep -E "^event: nfc/c_${utf8_nfc}/?$" ./unicode.trace
+		test_grep -E "^event: nfc/c_${utf8_nfd}/?$" ./unicode.trace &&
+		test_grep -E "^event: nfc/c_${utf8_nfc}/?$" ./unicode.trace
 	fi &&
 
 	# We assume UNICODE_NFD_PRESERVED.
 	# We should have seen explicit NFD from OS.
 	# We should have synthesized an NFC event.
-	grep -E "^event: nfd/d_${utf8_nfd}/?$" ./unicode.trace &&
-	grep -E "^event: nfd/d_${utf8_nfc}/?$" ./unicode.trace
+	test_grep -E "^event: nfd/d_${utf8_nfd}/?$" ./unicode.trace &&
+	test_grep -E "^event: nfd/d_${utf8_nfc}/?$" ./unicode.trace
 '
 
 test_expect_success 'split-index and FSMonitor work well together' '
@@ -1240,21 +1240,21 @@ test_expect_success CASE_INSENSITIVE_FS 'fsmonitor subdir case wrong on disk' '
 		<"$PWD/subdir_case_wrong.log" \
 		>"$PWD/subdir_case_wrong.log1" &&
 
-	grep -q "AAA.*pos 0" "$PWD/subdir_case_wrong.log1" &&
-	grep -q "zzz.*pos 6" "$PWD/subdir_case_wrong.log1" &&
+	test_grep -q "AAA.*pos 0" "$PWD/subdir_case_wrong.log1" &&
+	test_grep -q "zzz.*pos 6" "$PWD/subdir_case_wrong.log1" &&
 
-	grep -q "dir1/DIR2/dir3/file3.*pos -3" "$PWD/subdir_case_wrong.log1" &&
+	test_grep -q "dir1/DIR2/dir3/file3.*pos -3" "$PWD/subdir_case_wrong.log1" &&
 
 	# Verify that we get a mapping event to correct the case.
-	grep -q "MAP:.*dir1/DIR2/dir3/file3.*dir1/dir2/dir3/file3" \
+	test_grep -q "MAP:.*dir1/DIR2/dir3/file3.*dir1/dir2/dir3/file3" \
 		"$PWD/subdir_case_wrong.log1" &&
 
 	# The refresh-callbacks should have caused "git status" to clear
 	# the CE_FSMONITOR_VALID bit on each of those files and caused
 	# the worktree scan to visit them and mark them as modified.
-	grep -q " M AAA" "$PWD/subdir_case_wrong.out" &&
-	grep -q " M zzz" "$PWD/subdir_case_wrong.out" &&
-	grep -q " M dir1/dir2/dir3/file3" "$PWD/subdir_case_wrong.out"
+	test_grep -q " M AAA" "$PWD/subdir_case_wrong.out" &&
+	test_grep -q " M zzz" "$PWD/subdir_case_wrong.out" &&
+	test_grep -q " M dir1/dir2/dir3/file3" "$PWD/subdir_case_wrong.out"
 '
 
 test_expect_success CASE_INSENSITIVE_FS 'fsmonitor file case wrong on disk' '
@@ -1327,10 +1327,10 @@ test_expect_success CASE_INSENSITIVE_FS 'fsmonitor file case wrong on disk' '
 	GIT_TRACE_FSMONITOR="$PWD/file_case_wrong-try1.log" \
 		git -C file_case_wrong status --short \
 			>"$PWD/file_case_wrong-try1.out" &&
-	grep -q "fsmonitor_refresh_callback.*FILE-3-A.*pos -3" "$PWD/file_case_wrong-try1.log" &&
-	grep -q "fsmonitor_refresh_callback.*file-3-a.*pos 4"  "$PWD/file_case_wrong-try1.log" &&
-	grep -q "fsmonitor_refresh_callback.*FILE-4-A.*pos 6"  "$PWD/file_case_wrong-try1.log" &&
-	grep -q "fsmonitor_refresh_callback.*file-4-a.*pos -9" "$PWD/file_case_wrong-try1.log" &&
+	test_grep -q "fsmonitor_refresh_callback.*FILE-3-A.*pos -3" "$PWD/file_case_wrong-try1.log" &&
+	test_grep -q "fsmonitor_refresh_callback.*file-3-a.*pos 4"  "$PWD/file_case_wrong-try1.log" &&
+	test_grep -q "fsmonitor_refresh_callback.*FILE-4-A.*pos 6"  "$PWD/file_case_wrong-try1.log" &&
+	test_grep -q "fsmonitor_refresh_callback.*file-4-a.*pos -9" "$PWD/file_case_wrong-try1.log" &&
 
 	# FSM refresh will have invalidated the FSM bit and cause a regular
 	# (real) scan of these tracked files, so they should have "H" status.
@@ -1338,8 +1338,8 @@ test_expect_success CASE_INSENSITIVE_FS 'fsmonitor file case wrong on disk' '
 	# command).)
 
 	git -C file_case_wrong ls-files -f >"$PWD/file_case_wrong-lsf1.out" &&
-	grep -q "H dir1/dir2/dir3/file-3-a" "$PWD/file_case_wrong-lsf1.out" &&
-	grep -q "H dir1/dir2/dir4/FILE-4-A" "$PWD/file_case_wrong-lsf1.out" &&
+	test_grep -q "H dir1/dir2/dir3/file-3-a" "$PWD/file_case_wrong-lsf1.out" &&
+	test_grep -q "H dir1/dir2/dir4/FILE-4-A" "$PWD/file_case_wrong-lsf1.out" &&
 
 
 	# Try the status again. We assume that the above status command
@@ -1348,17 +1348,17 @@ test_expect_success CASE_INSENSITIVE_FS 'fsmonitor file case wrong on disk' '
 	GIT_TRACE_FSMONITOR="$PWD/file_case_wrong-try2.log" \
 		git -C file_case_wrong status --short \
 			>"$PWD/file_case_wrong-try2.out" &&
-	! grep -q "fsmonitor_refresh_callback.*FILE-3-A.*pos" "$PWD/file_case_wrong-try2.log" &&
-	! grep -q "fsmonitor_refresh_callback.*file-3-a.*pos" "$PWD/file_case_wrong-try2.log" &&
-	! grep -q "fsmonitor_refresh_callback.*FILE-4-A.*pos" "$PWD/file_case_wrong-try2.log" &&
-	! grep -q "fsmonitor_refresh_callback.*file-4-a.*pos" "$PWD/file_case_wrong-try2.log" &&
+	test_grep ! -q "fsmonitor_refresh_callback.*FILE-3-A.*pos" "$PWD/file_case_wrong-try2.log" &&
+	test_grep ! -q "fsmonitor_refresh_callback.*file-3-a.*pos" "$PWD/file_case_wrong-try2.log" &&
+	test_grep ! -q "fsmonitor_refresh_callback.*FILE-4-A.*pos" "$PWD/file_case_wrong-try2.log" &&
+	test_grep ! -q "fsmonitor_refresh_callback.*file-4-a.*pos" "$PWD/file_case_wrong-try2.log" &&
 
 	# FSM refresh saw nothing, so it will mark all files as valid,
 	# so they should now have "h" status.
 
 	git -C file_case_wrong ls-files -f >"$PWD/file_case_wrong-lsf2.out" &&
-	grep -q "h dir1/dir2/dir3/file-3-a" "$PWD/file_case_wrong-lsf2.out" &&
-	grep -q "h dir1/dir2/dir4/FILE-4-A" "$PWD/file_case_wrong-lsf2.out" &&
+	test_grep -q "h dir1/dir2/dir3/file-3-a" "$PWD/file_case_wrong-lsf2.out" &&
+	test_grep -q "h dir1/dir2/dir4/FILE-4-A" "$PWD/file_case_wrong-lsf2.out" &&
 
 
 	# We now have files with clean content, but with case-incorrect
@@ -1373,20 +1373,20 @@ test_expect_success CASE_INSENSITIVE_FS 'fsmonitor file case wrong on disk' '
 			>"$PWD/file_case_wrong-try3.out" &&
 
 	# Verify that we get a mapping event to correct the case.
-	grep -q "fsmonitor_refresh_callback MAP:.*dir1/dir2/dir3/FILE-3-A.*dir1/dir2/dir3/file-3-a" \
+	test_grep -q "fsmonitor_refresh_callback MAP:.*dir1/dir2/dir3/FILE-3-A.*dir1/dir2/dir3/file-3-a" \
 		"$PWD/file_case_wrong-try3.log" &&
-	grep -q "fsmonitor_refresh_callback MAP:.*dir1/dir2/dir4/file-4-a.*dir1/dir2/dir4/FILE-4-A" \
+	test_grep -q "fsmonitor_refresh_callback MAP:.*dir1/dir2/dir4/file-4-a.*dir1/dir2/dir4/FILE-4-A" \
 		"$PWD/file_case_wrong-try3.log" &&
 
 	# FSEvents are in observed case.
-	grep -q "fsmonitor_refresh_callback.*FILE-3-A.*pos -3" "$PWD/file_case_wrong-try3.log" &&
-	grep -q "fsmonitor_refresh_callback.*file-4-a.*pos -9" "$PWD/file_case_wrong-try3.log" &&
+	test_grep -q "fsmonitor_refresh_callback.*FILE-3-A.*pos -3" "$PWD/file_case_wrong-try3.log" &&
+	test_grep -q "fsmonitor_refresh_callback.*file-4-a.*pos -9" "$PWD/file_case_wrong-try3.log" &&
 
 	# The refresh-callbacks should have caused "git status" to clear
 	# the CE_FSMONITOR_VALID bit on each of those files and caused
 	# the worktree scan to visit them and mark them as modified.
-	grep -q " M dir1/dir2/dir3/file-3-a" "$PWD/file_case_wrong-try3.out" &&
-	grep -q " M dir1/dir2/dir4/FILE-4-A" "$PWD/file_case_wrong-try3.out"
+	test_grep -q " M dir1/dir2/dir3/file-3-a" "$PWD/file_case_wrong-try3.out" &&
+	test_grep -q " M dir1/dir2/dir4/FILE-4-A" "$PWD/file_case_wrong-try3.out"
 '
 
 test_done
diff --git a/t/t7528-signed-commit-ssh.sh b/t/t7528-signed-commit-ssh.sh
index b50306b9b3..44396460e6 100755
--- a/t/t7528-signed-commit-ssh.sh
+++ b/t/t7528-signed-commit-ssh.sh
@@ -133,8 +133,8 @@ test_expect_success GPGSSH 'verify and show signatures' '
 		do
 			git verify-commit $commit &&
 			git show --pretty=short --show-signature $commit >actual &&
-			grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
-			! grep "${GPGSSH_BAD_SIGNATURE}" actual &&
+			test_grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
+			test_grep ! "${GPGSSH_BAD_SIGNATURE}" actual &&
 			echo $commit OK || exit 1
 		done
 	) &&
@@ -144,8 +144,8 @@ test_expect_success GPGSSH 'verify and show signatures' '
 		do
 			test_must_fail git verify-commit $commit &&
 			git show --pretty=short --show-signature $commit >actual &&
-			! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
-			! grep "${GPGSSH_BAD_SIGNATURE}" actual &&
+			test_grep ! "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
+			test_grep ! "${GPGSSH_BAD_SIGNATURE}" actual &&
 			echo $commit OK || exit 1
 		done
 	) &&
@@ -153,9 +153,9 @@ test_expect_success GPGSSH 'verify and show signatures' '
 		for commit in eighth-signed-alt twelfth-signed-alt
 		do
 			git show --pretty=short --show-signature $commit >actual &&
-			grep "${GPGSSH_GOOD_SIGNATURE_UNTRUSTED}" actual &&
-			! grep "${GPGSSH_BAD_SIGNATURE}" actual &&
-			grep "${GPGSSH_KEY_NOT_TRUSTED}" actual &&
+			test_grep "${GPGSSH_GOOD_SIGNATURE_UNTRUSTED}" actual &&
+			test_grep ! "${GPGSSH_BAD_SIGNATURE}" actual &&
+			test_grep "${GPGSSH_KEY_NOT_TRUSTED}" actual &&
 			echo $commit OK || exit 1
 		done
 	)
@@ -164,34 +164,34 @@ test_expect_success GPGSSH 'verify and show signatures' '
 test_expect_success GPGSSH 'verify-commit exits failure on untrusted signature' '
 	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
 	test_must_fail git verify-commit eighth-signed-alt 2>actual &&
-	grep "${GPGSSH_GOOD_SIGNATURE_UNTRUSTED}" actual &&
-	! grep "${GPGSSH_BAD_SIGNATURE}" actual &&
-	grep "${GPGSSH_KEY_NOT_TRUSTED}" actual
+	test_grep "${GPGSSH_GOOD_SIGNATURE_UNTRUSTED}" actual &&
+	test_grep ! "${GPGSSH_BAD_SIGNATURE}" actual &&
+	test_grep "${GPGSSH_KEY_NOT_TRUSTED}" actual
 '
 
 test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'verify-commit exits failure on expired signature key' '
 	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
 	test_must_fail git verify-commit expired-signed 2>actual &&
-	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+	test_grep ! "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
 '
 
 test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'verify-commit exits failure on not yet valid signature key' '
 	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
 	test_must_fail git verify-commit notyetvalid-signed 2>actual &&
-	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+	test_grep ! "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
 '
 
 test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'verify-commit succeeds with commit date and key validity matching' '
 	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
 	git verify-commit timeboxedvalid-signed 2>actual &&
-	grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
-	! grep "${GPGSSH_BAD_SIGNATURE}" actual
+	test_grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
+	test_grep ! "${GPGSSH_BAD_SIGNATURE}" actual
 '
 
 test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'verify-commit exits failure with commit date outside of key validity' '
 	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
 	test_must_fail git verify-commit timeboxedinvalid-signed 2>actual &&
-	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+	test_grep ! "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
 '
 
 test_expect_success GPGSSH 'verify-commit exits success with matching minTrustLevel' '
@@ -217,8 +217,8 @@ test_expect_success GPGSSH 'verify signatures with --raw' '
 		for commit in initial second merge fourth-signed fifth-signed sixth-signed seventh-signed
 		do
 			git verify-commit --raw $commit 2>actual &&
-			grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
-			! grep "${GPGSSH_BAD_SIGNATURE}" actual &&
+			test_grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
+			test_grep ! "${GPGSSH_BAD_SIGNATURE}" actual &&
 			echo $commit OK || exit 1
 		done
 	) &&
@@ -226,8 +226,8 @@ test_expect_success GPGSSH 'verify signatures with --raw' '
 		for commit in merge^2 fourth-unsigned sixth-unsigned seventh-unsigned
 		do
 			test_must_fail git verify-commit --raw $commit 2>actual &&
-			! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
-			! grep "${GPGSSH_BAD_SIGNATURE}" actual &&
+			test_grep ! "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
+			test_grep ! "${GPGSSH_BAD_SIGNATURE}" actual &&
 			echo $commit OK || exit 1
 		done
 	) &&
@@ -235,8 +235,8 @@ test_expect_success GPGSSH 'verify signatures with --raw' '
 		for commit in eighth-signed-alt
 		do
 			test_must_fail git verify-commit --raw $commit 2>actual &&
-			grep "${GPGSSH_GOOD_SIGNATURE_UNTRUSTED}" actual &&
-			! grep "${GPGSSH_BAD_SIGNATURE}" actual &&
+			test_grep "${GPGSSH_GOOD_SIGNATURE_UNTRUSTED}" actual &&
+			test_grep ! "${GPGSSH_BAD_SIGNATURE}" actual &&
 			echo $commit OK || exit 1
 		done
 	)
@@ -244,7 +244,7 @@ test_expect_success GPGSSH 'verify signatures with --raw' '
 
 test_expect_success GPGSSH 'proper header is used for hash algorithm' '
 	git cat-file commit fourth-signed >output &&
-	grep "^$(test_oid header) -----BEGIN SSH SIGNATURE-----" output
+	test_grep "^$(test_oid header) -----BEGIN SSH SIGNATURE-----" output
 '
 
 test_expect_success GPGSSH 'show signed commit with signature' '
@@ -268,9 +268,9 @@ test_expect_success GPGSSH 'detect fudged signature' '
 	git hash-object -w -t commit forged1 >forged1.commit &&
 	test_must_fail git verify-commit $(cat forged1.commit) &&
 	git show --pretty=short --show-signature $(cat forged1.commit) >actual1 &&
-	grep "${GPGSSH_BAD_SIGNATURE}" actual1 &&
-	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual1 &&
-	! grep "${GPGSSH_GOOD_SIGNATURE_UNTRUSTED}" actual1
+	test_grep "${GPGSSH_BAD_SIGNATURE}" actual1 &&
+	test_grep ! "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual1 &&
+	test_grep ! "${GPGSSH_GOOD_SIGNATURE_UNTRUSTED}" actual1
 '
 
 test_expect_success GPGSSH 'detect fudged signature with NUL' '
@@ -281,8 +281,8 @@ test_expect_success GPGSSH 'detect fudged signature with NUL' '
 	git hash-object --literally -w -t commit forged2 >forged2.commit &&
 	test_must_fail git verify-commit $(cat forged2.commit) &&
 	git show --pretty=short --show-signature $(cat forged2.commit) >actual2 &&
-	grep "${GPGSSH_BAD_SIGNATURE}" actual2 &&
-	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual2
+	test_grep "${GPGSSH_BAD_SIGNATURE}" actual2 &&
+	test_grep ! "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual2
 '
 
 test_expect_success GPGSSH 'amending already signed commit' '
@@ -293,8 +293,8 @@ test_expect_success GPGSSH 'amending already signed commit' '
 	git commit --amend -S --no-edit &&
 	git verify-commit HEAD &&
 	git show -s --show-signature HEAD >actual &&
-	grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
-	! grep "${GPGSSH_BAD_SIGNATURE}" actual
+	test_grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
+	test_grep ! "${GPGSSH_BAD_SIGNATURE}" actual
 '
 
 test_expect_success GPGSSH 'show good signature with custom format' '
@@ -386,7 +386,7 @@ test_expect_success GPGSSH 'log.showsignature behaves like --show-signature' '
 	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
 	test_config log.showsignature true &&
 	git show initial >actual &&
-	grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+	test_grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
 '
 
 test_expect_success GPGSSH 'check config gpg.format values' '
@@ -410,8 +410,8 @@ test_expect_failure GPGSSH 'detect fudged commit with double signature (TODO)' '
 	git hash-object -w -t commit double-commit >double-commit.commit &&
 	test_must_fail git verify-commit $(cat double-commit.commit) &&
 	git show --pretty=short --show-signature $(cat double-commit.commit) >double-actual &&
-	grep "BAD signature from" double-actual &&
-	grep "Good signature from" double-actual
+	test_grep "BAD signature from" double-actual &&
+	test_grep "Good signature from" double-actual
 '
 
 test_expect_failure GPGSSH 'show double signature with custom format (TODO)' '
@@ -463,8 +463,8 @@ test_expect_failure GPGSSH 'verify-commit verifies multiply signed commits (TODO
 	head=$(git hash-object -t commit -w commit) &&
 	git reset --hard $head &&
 	git verify-commit $head 2>actual &&
-	grep "Good signature from" actual &&
-	! grep "BAD signature from" actual
+	test_grep "Good signature from" actual &&
+	test_grep ! "BAD signature from" actual
 '
 
 test_done
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index f877d9a433..a9c3c3920d 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -342,8 +342,8 @@ test_expect_success 'merge --squash --autostash conflict does not attempt to app
 	>unrelated &&
 	git add unrelated &&
 	test_must_fail git merge --squash c7 --autostash >out 2>err &&
-	! grep "Applying autostash resulted in conflicts." err &&
-	grep "When finished, apply stashed changes with \`git stash pop\`" out
+	test_grep ! "Applying autostash resulted in conflicts." err &&
+	test_grep "When finished, apply stashed changes with \`git stash pop\`" out
 '
 
 test_expect_success 'merge c3 with c7 with commit.cleanup = scissors' '
@@ -990,7 +990,7 @@ test_expect_success 'merge --no-ff --edit' '
 	EDITOR=./editor git merge --no-ff --edit c1 &&
 	verify_parents $c0 $c1 &&
 	git cat-file commit HEAD >raw &&
-	grep "work done on the side branch" raw &&
+	test_grep "work done on the side branch" raw &&
 	sed "1,/^$/d" >actual raw &&
 	test_cmp expected actual
 '
@@ -1157,13 +1157,13 @@ test_expect_success 'merge suggests matching remote refname' '
 	git pack-refs --all --prune &&
 
 	test_must_fail git merge not-local 2>stderr &&
-	grep origin/not-local stderr
+	test_grep origin/not-local stderr
 '
 
 test_expect_success 'suggested names are not ambiguous' '
 	git update-ref refs/heads/origin/not-local HEAD &&
 	test_must_fail git merge not-local 2>stderr &&
-	grep remotes/origin/not-local stderr
+	test_grep remotes/origin/not-local stderr
 '
 
 test_done
diff --git a/t/t7603-merge-reduce-heads.sh b/t/t7603-merge-reduce-heads.sh
index 1f8c3b7ccb..92007dc501 100755
--- a/t/t7603-merge-reduce-heads.sh
+++ b/t/t7603-merge-reduce-heads.sh
@@ -59,11 +59,11 @@ test_expect_success 'merge c1 with c2, c3, c4, c5' '
 	test_path_is_file c4.c &&
 	test_path_is_file c5.c &&
 	git show --format=%s -s >actual &&
-	! grep c1 actual &&
-	grep c2 actual &&
-	grep c3 actual &&
-	! grep c4 actual &&
-	grep c5 actual
+	test_grep ! c1 actual &&
+	test_grep c2 actual &&
+	test_grep c3 actual &&
+	test_grep ! c4 actual &&
+	test_grep c5 actual
 '
 
 test_expect_success 'pull c2, c3, c4, c5 into c1' '
@@ -82,11 +82,11 @@ test_expect_success 'pull c2, c3, c4, c5 into c1' '
 	test_path_is_file c4.c &&
 	test_path_is_file c5.c &&
 	git show --format=%s -s >actual &&
-	! grep c1 actual &&
-	grep c2 actual &&
-	grep c3 actual &&
-	! grep c4 actual &&
-	grep c5 actual
+	test_grep ! c1 actual &&
+	test_grep c2 actual &&
+	test_grep c3 actual &&
+	test_grep ! c4 actual &&
+	test_grep c5 actual
 '
 
 test_expect_success 'setup' '
diff --git a/t/t7606-merge-custom.sh b/t/t7606-merge-custom.sh
index 81fb7c474c..0ae2f59b1d 100755
--- a/t/t7606-merge-custom.sh
+++ b/t/t7606-merge-custom.sh
@@ -60,7 +60,7 @@ test_expect_success 'merge c2 with a custom strategy' '
 	test_cmp second-parent.expected second-parent &&
 	test_cmp tree.expected tree &&
 	test -f c0.c &&
-	grep c1c1 c1.c &&
+	test_grep c1c1 c1.c &&
 	test -f c2.c
 '
 
diff --git a/t/t7607-merge-state.sh b/t/t7607-merge-state.sh
index 89a62ac53b..bfe782d89e 100755
--- a/t/t7607-merge-state.sh
+++ b/t/t7607-merge-state.sh
@@ -20,8 +20,8 @@ test_expect_success 'Ensure we restore original state if no merge strategy handl
 	# just hit conflicts, it completely fails and says that it cannot
 	# handle this type of merge.
 	test_expect_code 2 git merge branch2 branch3 >output 2>&1 &&
-	grep "fatal: merge program failed" output &&
-	grep "Should not be doing an octopus" output &&
+	test_grep "fatal: merge program failed" output &&
+	test_grep "Should not be doing an octopus" output &&
 
 	# Make sure we did not leave stray changes around when no appropriate
 	# merge strategy was found
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 957f8e20ba..0128b14452 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -738,7 +738,7 @@ test_expect_success 'filenames seen by tools start with ./' '
 	test_config mergetool.myecho.trustExitCode true &&
 	test_must_fail git merge main &&
 	git mergetool --no-prompt --tool myecho -- both >actual &&
-	grep ^\./both_LOCAL_ actual
+	test_grep ^\./both_LOCAL_ actual
 '
 
 test_lazy_prereq MKTEMP '
@@ -755,8 +755,8 @@ test_expect_success MKTEMP 'temporary filenames are used with mergetool.writeToT
 	test_config mergetool.myecho.trustExitCode true &&
 	test_must_fail git merge main &&
 	git mergetool --no-prompt --tool myecho -- both >actual &&
-	! grep ^\./both_LOCAL_ actual &&
-	grep /both_LOCAL_ actual
+	test_grep ! ^\./both_LOCAL_ actual &&
+	test_grep /both_LOCAL_ actual
 '
 
 test_expect_success 'diff.orderFile configuration is honored' '
@@ -816,12 +816,12 @@ test_expect_success 'mergetool -Oorder-file is honored' '
 test_expect_success 'mergetool --tool-help shows recognized tools' '
 	# Check a few known tools are correctly shown
 	git mergetool --tool-help >mergetools &&
-	grep vimdiff mergetools &&
-	grep vimdiff3 mergetools &&
-	grep gvimdiff2 mergetools &&
-	grep araxis mergetools &&
-	grep xxdiff mergetools &&
-	grep meld mergetools
+	test_grep vimdiff mergetools &&
+	test_grep vimdiff3 mergetools &&
+	test_grep gvimdiff2 mergetools &&
+	test_grep araxis mergetools &&
+	test_grep xxdiff mergetools &&
+	test_grep meld mergetools
 '
 
 test_expect_success 'mergetool hideResolved' '
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index c6ff3aed30..f0a390e3c6 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -177,7 +177,7 @@ test_expect_success 'packed unreachable obs in alternate ODB are not loosened' '
 	rm -f .git/objects/pack/* &&
 	mv pack-* .git/objects/pack/ &&
 	git verify-pack -v -- .git/objects/pack/*.idx >packlist &&
-	! grep "^$coid " packlist &&
+	test_grep ! "^$coid " packlist &&
 	echo >.git/objects/info/alternates &&
 	test_must_fail git show $coid
 '
@@ -194,7 +194,7 @@ test_expect_success 'local packed unreachable obs that exist in alternate ODB ar
 	rm -f .git/objects/pack/* &&
 	mv pack-* .git/objects/pack/ &&
 	git verify-pack -v -- .git/objects/pack/*.idx >packlist &&
-	! grep "^$coid " packlist &&
+	test_grep ! "^$coid " packlist &&
 	echo >.git/objects/info/alternates &&
 	test_must_fail git show $coid
 '
@@ -226,8 +226,8 @@ test_expect_success 'repack --keep-pack' '
 		test_line_count = 4 old-counts &&
 		git repack -a -d --keep-pack $P1 --keep-pack $P4 &&
 		ls .git/objects/pack/*.pack >new-counts &&
-		grep -q $P1 new-counts &&
-		grep -q $P4 new-counts &&
+		test_grep -q $P1 new-counts &&
+		test_grep -q $P4 new-counts &&
 		test_line_count = 3 new-counts &&
 		git fsck &&
 
@@ -276,7 +276,7 @@ test_expect_success 'repacking fails when missing .pack actually means missing o
 
 		test_must_fail git fsck &&
 		test_must_fail env GIT_COMMIT_GRAPH_PARANOIA=true git repack --cruft -d 2>err &&
-		grep "bad object" err &&
+		test_grep "bad object" err &&
 
 		# Before failing, the repack did not modify the
 		# pack directory.
@@ -460,8 +460,8 @@ test_expect_success '--filter works with --pack-kept-objects and .keep packs' '
 
 		# Object bar is in both the old .keep pack and the new
 		# pack that contained the filtered out objects
-		grep "$bar_pack" bar_pack_1 &&
-		grep "$foo_pack_1" bar_pack_1 &&
+		test_grep "$bar_pack" bar_pack_1 &&
+		test_grep "$foo_pack_1" bar_pack_1 &&
 		test "$foo_pack_1" != "$head_pack_1"
 	)
 '
diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
index 04d5d8fc33..f3a0650cfe 100755
--- a/t/t7703-repack-geometric.sh
+++ b/t/t7703-repack-geometric.sh
@@ -112,7 +112,7 @@ test_expect_success '--geometric with small-pack rollup' '
 		find $objdir/pack -name "*.pack" | sort >after &&
 		test_line_count = 3 after &&
 		comm -3 small before | tr -d "\t" >large &&
-		grep -qFf large after
+		test_grep -qFf large after
 	)
 '
 
@@ -210,7 +210,7 @@ test_expect_success '--geometric ignores --keep-pack packs' '
 
 		# Packs should not have changed (only one non-kept pack, no
 		# loose objects), but $midx should now exist.
-		grep "Nothing new to pack" out &&
+		test_grep "Nothing new to pack" out &&
 		test_path_is_file $midx &&
 
 		test_cmp packs.before packs.after &&
diff --git a/t/t7704-repack-cruft.sh b/t/t7704-repack-cruft.sh
index 9e03b04315..b342e82447 100755
--- a/t/t7704-repack-cruft.sh
+++ b/t/t7704-repack-cruft.sh
@@ -166,9 +166,9 @@ test_expect_success '--max-cruft-size creates new packs when too large' '
 		test-tool pack-mtimes $(basename "$cruft_foo") >foo.objects &&
 		test-tool pack-mtimes $(basename "$cruft_bar") >bar.objects &&
 
-		grep "^$foo" foo.objects &&
+		test_grep "^$foo" foo.objects &&
 		test_line_count = 1 foo.objects &&
-		grep "^$bar" bar.objects &&
+		test_grep "^$bar" bar.objects &&
 		test_line_count = 1 bar.objects
 	)
 '
@@ -188,8 +188,8 @@ test_expect_success '--max-cruft-size combines existing packs when not too large
 		cruft=$(ls $packdir/pack-*.mtimes) &&
 		test-tool pack-mtimes $(basename "$cruft") >cruft.objects &&
 
-		grep "^$foo" cruft.objects &&
-		grep "^$bar" cruft.objects &&
+		test_grep "^$foo" cruft.objects &&
+		test_grep "^$bar" cruft.objects &&
 		test_line_count = 2 cruft.objects
 	)
 '
@@ -693,7 +693,7 @@ test_expect_success 'cruft repack respects repack.cruftWindow' '
 		git -c pack.window=1 -c repack.cruftWindow=2 repack \
 		       --cruft --window=3 &&
 
-		grep "pack-objects.*--window=2.*--cruft" event.trace
+		test_grep "pack-objects.*--window=2.*--cruft" event.trace
 	)
 '
 
@@ -708,7 +708,7 @@ test_expect_success 'cruft repack respects --window by default' '
 		GIT_TRACE2_EVENT=$(pwd)/event.trace \
 		git -c pack.window=2 repack --cruft --window=3 &&
 
-		grep "pack-objects.*--window=3.*--cruft" event.trace
+		test_grep "pack-objects.*--window=3.*--cruft" event.trace
 	)
 '
 
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 8a91ff3603..02e47f466a 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -431,32 +431,32 @@ test_expect_success 'setup with 2 files different' '
 test_expect_success 'say no to the first file' '
 	(echo n && echo) >input &&
 	git difftool -x cat branch <input >output &&
-	grep m2 output &&
-	grep br2 output &&
-	! grep main output &&
-	! grep branch output
+	test_grep m2 output &&
+	test_grep br2 output &&
+	test_grep ! main output &&
+	test_grep ! branch output
 '
 
 test_expect_success 'say no to the second file' '
 	(echo && echo n) >input &&
 	git difftool -x cat branch <input >output &&
-	grep main output &&
-	grep branch output &&
-	! grep m2 output &&
-	! grep br2 output
+	test_grep main output &&
+	test_grep branch output &&
+	test_grep ! m2 output &&
+	test_grep ! br2 output
 '
 
 test_expect_success 'ending prompt input with EOF' '
 	git difftool -x cat branch </dev/null >output &&
-	! grep main output &&
-	! grep branch output &&
-	! grep m2 output &&
-	! grep br2 output
+	test_grep ! main output &&
+	test_grep ! branch output &&
+	test_grep ! m2 output &&
+	test_grep ! br2 output
 '
 
 test_expect_success 'difftool --tool-help' '
 	git difftool --tool-help >output &&
-	grep tool output
+	test_grep tool output
 '
 
 test_expect_success 'setup change in subdirectory' '
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index d61c4a4d73..ac7ea9cf8d 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -1101,19 +1101,19 @@ test_expect_success 'grep -W with userdiff' '
 '
 
 test_expect_success ' includes preceding comment' '
-	grep "# Say hello" function-context-userdiff-actual
+	test_grep "# Say hello" function-context-userdiff-actual
 '
 
 test_expect_success ' includes function line' '
-	grep "=function hello" function-context-userdiff-actual
+	test_grep "=function hello" function-context-userdiff-actual
 '
 
 test_expect_success ' includes matching line' '
-	grep ":  echo" function-context-userdiff-actual
+	test_grep ":  echo" function-context-userdiff-actual
 '
 
 test_expect_success ' includes last line of the function' '
-	grep "} # hello" function-context-userdiff-actual
+	test_grep "} # hello" function-context-userdiff-actual
 '
 
 for threads in $(test_seq 0 10)
@@ -1137,16 +1137,16 @@ test_expect_success !PTHREADS,!FAIL_PREREQS \
 	git grep --threads=2 Hello hello_world 2>err &&
 	grep ^warning: err >warnings &&
 	test_line_count = 1 warnings &&
-	grep -F "no threads support, ignoring --threads" err &&
+	test_grep -F "no threads support, ignoring --threads" err &&
 	git -c grep.threads=2 grep Hello hello_world 2>err &&
 	grep ^warning: err >warnings &&
 	test_line_count = 1 warnings &&
-	grep -F "no threads support, ignoring grep.threads" err &&
+	test_grep -F "no threads support, ignoring grep.threads" err &&
 	git -c grep.threads=2 grep --threads=4 Hello hello_world 2>err &&
 	grep ^warning: err >warnings &&
 	test_line_count = 2 warnings &&
-	grep -F "no threads support, ignoring --threads" err &&
-	grep -F "no threads support, ignoring grep.threads" err &&
+	test_grep -F "no threads support, ignoring --threads" err &&
+	test_grep -F "no threads support, ignoring grep.threads" err &&
 	git -c grep.threads=0 grep --threads=0 Hello hello_world 2>err &&
 	test_line_count = 0 err
 '
@@ -1267,21 +1267,21 @@ test_expect_success 'no repository with path outside $cwd' '
 		export GIT_CEILING_DIRECTORIES &&
 		cd non/git &&
 		test_expect_code 128 git grep --no-index search .. 2>error &&
-		grep "is outside the directory tree" error
+		test_grep "is outside the directory tree" error
 	) &&
 	(
 		GIT_CEILING_DIRECTORIES="$(pwd)/non" &&
 		export GIT_CEILING_DIRECTORIES &&
 		cd non/git &&
 		test_expect_code 128 git grep --no-index search ../tig 2>error &&
-		grep "is outside the directory tree" error
+		test_grep "is outside the directory tree" error
 	) &&
 	(
 		GIT_CEILING_DIRECTORIES="$(pwd)/non" &&
 		export GIT_CEILING_DIRECTORIES &&
 		cd non/git &&
 		test_expect_code 128 git grep --no-index search ../non 2>error &&
-		grep "no such path in the working tree" error
+		test_grep "no such path in the working tree" error
 	)
 '
 
diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index 167fe66150..e1cf53dc9e 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -590,7 +590,7 @@ test_expect_success 'grep partially-cloned submodule' '
 			--recurse-submodules HEAD^ >actual &&
 		test_cmp expect actual &&
 		# Verify that we actually fetched data from the promisor remote:
-		grep \"category\":\"promisor\",\"key\":\"fetch_count\",\"value\":\"1\" trace2.log
+		test_grep \"category\":\"promisor\",\"key\":\"fetch_count\",\"value\":\"1\" trace2.log
 	)
 '
 
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index d7f82e1bec..8ccaac8b50 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -305,7 +305,7 @@ test_expect_success 'prefetch multiple remotes' '
 	test_cmp_rev refs/remotes/remote2/two refs/prefetch/remotes/remote2/two &&
 
 	git log --oneline --decorate --all >log &&
-	! grep "prefetch" log &&
+	test_grep ! "prefetch" log &&
 
 	test_when_finished git config --unset remote.remote1.skipFetchAll &&
 	git config remote.remote1.skipFetchAll true &&
@@ -395,15 +395,15 @@ test_expect_success 'maintenance.loose-objects.batchSize' '
 
 	GIT_PROGRESS_DELAY=0 \
 	git -C loose-batch maintenance run --no-quiet --task=loose-objects 2>err &&
-	grep "Enumerating objects: 50, done." err &&
+	test_grep "Enumerating objects: 50, done." err &&
 
 	GIT_PROGRESS_DELAY=0 \
 	git -C loose-batch maintenance run --no-quiet --task=loose-objects 2>err &&
-	grep "Enumerating objects: 50, done." err &&
+	test_grep "Enumerating objects: 50, done." err &&
 
 	GIT_PROGRESS_DELAY=0 \
 	git -C loose-batch maintenance run --no-quiet --task=loose-objects 2>err &&
-	grep "Enumerating objects: 2, done." err &&
+	test_grep "Enumerating objects: 2, done." err &&
 
 	GIT_PROGRESS_DELAY=0 \
 	git -C loose-batch maintenance run --no-quiet --task=loose-objects 2>err &&
@@ -1067,7 +1067,7 @@ test_expect_success 'register and unregister' '
 	test_when_finished git config --global --unset-all maintenance.repo &&
 
 	test_must_fail git maintenance unregister 2>err &&
-	grep "is not registered" err &&
+	test_grep "is not registered" err &&
 	git maintenance unregister --force &&
 
 	git config --global --add maintenance.repo /existing1 &&
@@ -1101,11 +1101,11 @@ test_expect_success 'register and unregister' '
 	test_cmp before actual &&
 
 	test_must_fail git maintenance unregister 2>err &&
-	grep "is not registered" err &&
+	test_grep "is not registered" err &&
 	git maintenance unregister --force &&
 
 	test_must_fail git maintenance unregister --config-file ./other 2>err &&
-	grep "is not registered" err &&
+	test_grep "is not registered" err &&
 	git maintenance unregister --config-file ./other --force
 '
 
@@ -1194,9 +1194,9 @@ test_expect_success 'start from empty cron table' '
 	# start registers the repo
 	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&
 
-	grep "for-each-repo --keep-going --config=maintenance.repo maintenance run --schedule=daily" cron.txt &&
-	grep "for-each-repo --keep-going --config=maintenance.repo maintenance run --schedule=hourly" cron.txt &&
-	grep "for-each-repo --keep-going --config=maintenance.repo maintenance run --schedule=weekly" cron.txt
+	test_grep "for-each-repo --keep-going --config=maintenance.repo maintenance run --schedule=daily" cron.txt &&
+	test_grep "for-each-repo --keep-going --config=maintenance.repo maintenance run --schedule=hourly" cron.txt &&
+	test_grep "for-each-repo --keep-going --config=maintenance.repo maintenance run --schedule=weekly" cron.txt
 '
 
 test_expect_success 'stop from existing schedule' '
@@ -1213,7 +1213,7 @@ test_expect_success 'stop from existing schedule' '
 test_expect_success 'start preserves existing schedule' '
 	echo "Important information!" >cron.txt &&
 	GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab cron.txt" git maintenance start --scheduler=crontab &&
-	grep "Important information!" cron.txt
+	test_grep "Important information!" cron.txt
 '
 
 test_expect_success 'magic markers are correct' '
@@ -1228,8 +1228,8 @@ test_expect_success 'magic markers are correct' '
 test_expect_success 'stop preserves surrounding schedule' '
 	echo "Crucial information!" >>cron.txt &&
 	GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab cron.txt" git maintenance stop &&
-	grep "Important information!" cron.txt &&
-	grep "Crucial information!" cron.txt
+	test_grep "Important information!" cron.txt &&
+	test_grep "Crucial information!" cron.txt
 '
 
 test_expect_success 'start and stop macOS maintenance' '
@@ -1259,7 +1259,7 @@ test_expect_success 'start and stop macOS maintenance' '
 	do
 		PLIST="$pfx/Library/LaunchAgents/org.git-scm.git.$frequency.plist" &&
 		test_xmllint "$PLIST" &&
-		grep schedule=$frequency "$PLIST" &&
+		test_grep schedule=$frequency "$PLIST" &&
 		echo "bootout gui/[UID] $PLIST" >>expect &&
 		echo "bootstrap gui/[UID] $PLIST" >>expect || return 1
 	done &&
@@ -1316,7 +1316,7 @@ test_expect_success 'start and stop Windows maintenance' '
 
 	for frequency in hourly daily weekly
 	do
-		grep "/create /tn Git Maintenance ($frequency) /f /xml" args &&
+		test_grep "/create /tn Git Maintenance ($frequency) /f /xml" args &&
 		file=$(ls .git/schedule_${frequency}*.xml) &&
 		test_xmllint "$file" || return 1
 	done &&
@@ -1355,8 +1355,8 @@ test_expect_success 'start and stop Linux/systemd maintenance' '
 	test_systemd_analyze_verify "systemd/user/git-maintenance@daily.service" &&
 	test_systemd_analyze_verify "systemd/user/git-maintenance@weekly.service" &&
 
-	grep "core.askPass=true" "systemd/user/git-maintenance@.service" &&
-	grep "credential.interactive=false" "systemd/user/git-maintenance@.service" &&
+	test_grep "core.askPass=true" "systemd/user/git-maintenance@.service" &&
+	test_grep "credential.interactive=false" "systemd/user/git-maintenance@.service" &&
 
 	printf -- "--user enable --now git-maintenance@%s.timer\n" hourly daily weekly >expect &&
 	test_cmp expect args &&
diff --git a/t/t8008-blame-formats.sh b/t/t8008-blame-formats.sh
index c12a4196d6..016a837f14 100755
--- a/t/t8008-blame-formats.sh
+++ b/t/t8008-blame-formats.sh
@@ -103,7 +103,7 @@ test_expect_success '--porcelain detects first non-blank line as subject' '
 			"committer C <c@d.e> 123456789 +0000" |
 		git hash-object -w -t commit --stdin) &&
 		git blame --porcelain $commit -- single-file >output &&
-		grep "^summary oneline$" output
+		test_grep "^summary oneline$" output
 	)
 '
 
diff --git a/t/t8010-cat-file-filters.sh b/t/t8010-cat-file-filters.sh
index b3be2aa387..a4afb33c3e 100755
--- a/t/t8010-cat-file-filters.sh
+++ b/t/t8010-cat-file-filters.sh
@@ -49,7 +49,7 @@ test_expect_success '--path=<path> complains without --textconv/--filters' '
 	sha1=$(git rev-parse -q --verify HEAD:world.txt) &&
 	test_must_fail git cat-file --path=hello.txt blob $sha1 >actual 2>err &&
 	test_must_be_empty actual &&
-	grep "path.*needs.*filters" err
+	test_grep "path.*needs.*filters" err
 '
 
 test_expect_success '--textconv/--filters complain without path' '
diff --git a/t/t8012-blame-colors.sh b/t/t8012-blame-colors.sh
index 5562eba436..d2653b3c31 100755
--- a/t/t8012-blame-colors.sh
+++ b/t/t8012-blame-colors.sh
@@ -66,7 +66,7 @@ test_expect_success 'blame color by age: new code is different' '
 
 	grep "<CYAN>" <actual >colored &&
 	test_line_count = 1 colored &&
-	grep qfunc colored
+	test_grep qfunc colored
 '
 
 test_done
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index e7ab645a3d..e9d814a34a 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -348,9 +348,9 @@ test_expect_success $PREREQ 'Prompting works' '
 		--smtp-server="$(pwd)/fake.sendmail" \
 		$patches \
 		2>errors &&
-		grep "^From: A U Thor <author@example.com>\$" msgtxt1 &&
-		grep "^To: to@example.com\$" msgtxt1 &&
-		grep "^In-Reply-To: <my-message-id@example.com>" msgtxt1
+		test_grep "^From: A U Thor <author@example.com>\$" msgtxt1 &&
+		test_grep "^To: to@example.com\$" msgtxt1 &&
+		test_grep "^In-Reply-To: <my-message-id@example.com>" msgtxt1
 '
 
 test_expect_success $PREREQ,AUTOIDENT 'implicit ident is allowed' '
@@ -403,7 +403,7 @@ test_expect_success $PREREQ 'tocmd works' '
 		--smtp-server="$(pwd)/fake.sendmail" \
 		tocmd.patch \
 		&&
-	grep "^To: tocmd@example.com" msgtxt1
+	test_grep "^To: tocmd@example.com" msgtxt1
 '
 
 test_expect_success $PREREQ 'cccmd works' '
@@ -417,7 +417,7 @@ test_expect_success $PREREQ 'cccmd works' '
 		--smtp-server="$(pwd)/fake.sendmail" \
 		cccmd.patch \
 		&&
-	grep "^	cccmd@example.com" msgtxt1
+	test_grep "^	cccmd@example.com" msgtxt1
 '
 
 test_expect_success $PREREQ 'headercmd works' '
@@ -431,7 +431,7 @@ test_expect_success $PREREQ 'headercmd works' '
 		--smtp-server="$(pwd)/fake.sendmail" \
 		headercmd.patch \
 		&&
-	grep "^X-Debbugs-CC: dummy@example.com" msgtxt1
+	test_grep "^X-Debbugs-CC: dummy@example.com" msgtxt1
 '
 
 test_expect_success $PREREQ '--no-header-cmd works' '
@@ -446,7 +446,7 @@ test_expect_success $PREREQ '--no-header-cmd works' '
 		--smtp-server="$(pwd)/fake.sendmail" \
 		headercmd.patch \
 		&&
-	! grep "^X-Debbugs-CC: dummy@example.com" msgtxt1
+	test_grep ! "^X-Debbugs-CC: dummy@example.com" msgtxt1
 '
 
 test_expect_success $PREREQ 'multiline fields are correctly unfolded' '
@@ -464,7 +464,7 @@ FoldedField: This is a tale
 		--header-cmd=./headercmd-multiline \
 		--smtp-server="$(pwd)/fake.sendmail" \
 		headercmd.patch &&
-	grep "^FoldedField: This is a tale best told using multiple lines.$" msgtxt1
+	test_grep "^FoldedField: This is a tale best told using multiple lines.$" msgtxt1
 '
 
 # Blank lines in the middle of the output of a command are invalid.
@@ -521,7 +521,7 @@ test_expect_success $PREREQ 'Author From: in message body' '
 		--smtp-server="$(pwd)/fake.sendmail" \
 		$patches &&
 	sed "1,/^\$/d" <msgtxt1 >msgbody1 &&
-	grep "From: A <author@example.com>" msgbody1
+	test_grep "From: A <author@example.com>" msgbody1
 '
 
 test_expect_success $PREREQ 'Author From: not in message body' '
@@ -532,7 +532,7 @@ test_expect_success $PREREQ 'Author From: not in message body' '
 		--smtp-server="$(pwd)/fake.sendmail" \
 		$patches &&
 	sed "1,/^\$/d" <msgtxt1 >msgbody1 &&
-	! grep "From: A <author@example.com>" msgbody1
+	test_grep ! "From: A <author@example.com>" msgbody1
 '
 
 test_expect_success $PREREQ 'allow long lines with --no-validate' '
@@ -553,7 +553,7 @@ test_expect_success $PREREQ 'short lines with auto encoding are 8bit' '
 		--smtp-server="$(pwd)/fake.sendmail" \
 		--transfer-encoding=auto \
 		$patches &&
-	grep "Content-Transfer-Encoding: 8bit" msgtxt1
+	test_grep "Content-Transfer-Encoding: 8bit" msgtxt1
 '
 
 test_expect_success $PREREQ 'long lines with auto encoding are quoted-printable' '
@@ -565,7 +565,7 @@ test_expect_success $PREREQ 'long lines with auto encoding are quoted-printable'
 		--transfer-encoding=auto \
 		--no-validate \
 		longline.patch &&
-	grep "Content-Transfer-Encoding: quoted-printable" msgtxt1
+	test_grep "Content-Transfer-Encoding: quoted-printable" msgtxt1
 '
 
 test_expect_success $PREREQ 'carriage returns with auto encoding are quoted-printable' '
@@ -579,7 +579,7 @@ test_expect_success $PREREQ 'carriage returns with auto encoding are quoted-prin
 		--transfer-encoding=auto \
 		--no-validate \
 		cr.patch &&
-	grep "Content-Transfer-Encoding: quoted-printable" msgtxt1
+	test_grep "Content-Transfer-Encoding: quoted-printable" msgtxt1
 '
 
 for enc in auto quoted-printable base64
@@ -705,7 +705,7 @@ do
 			--smtp-server="$(pwd)/fake.sendmail" \
 			--transfer-encoding=$enc \
 			$patches &&
-		grep "Content-Transfer-Encoding: $enc" msgtxt1
+		test_grep "Content-Transfer-Encoding: $enc" msgtxt1
 	'
 done
 
@@ -718,7 +718,7 @@ test_expect_success $PREREQ 'Invalid In-Reply-To' '
 		--smtp-server="$(pwd)/fake.sendmail" \
 		$patches \
 		2>errors &&
-	! grep "^In-Reply-To: < *>" msgtxt1
+	test_grep ! "^In-Reply-To: < *>" msgtxt1
 '
 
 test_expect_success $PREREQ 'Valid In-Reply-To when prompting' '
@@ -729,7 +729,7 @@ test_expect_success $PREREQ 'Valid In-Reply-To when prompting' '
 	) | GIT_SEND_EMAIL_NOTTY=1 git send-email \
 		--smtp-server="$(pwd)/fake.sendmail" \
 		$patches 2>errors &&
-	! grep "^In-Reply-To: < *>" msgtxt1
+	test_grep ! "^In-Reply-To: < *>" msgtxt1
 '
 
 test_expect_success $PREREQ 'In-Reply-To without --chain-reply-to' '
@@ -792,8 +792,8 @@ test_expect_success $PREREQ 'fake editor dies with error' '
 		--to=nobody@example.com \
 		--smtp-server="$(pwd)/fake.sendmail" \
 		$patches 2>err &&
-	grep "I am about to error" err &&
-	grep "the editor exited uncleanly, aborting everything" err
+	test_grep "I am about to error" err &&
+	test_grep "the editor exited uncleanly, aborting everything" err
 '
 
 test_expect_success $PREREQ 'setup fake editor' '
@@ -814,11 +814,11 @@ test_expect_success $PREREQ '--compose works' '
 '
 
 test_expect_success $PREREQ 'first message is compose text' '
-	grep "^fake edit" msgtxt1
+	test_grep "^fake edit" msgtxt1
 '
 
 test_expect_success $PREREQ 'second message is patch' '
-	grep "Subject:.*Second" msgtxt2
+	test_grep "Subject:.*Second" msgtxt2
 '
 
 test_expect_success $PREREQ 'setup expect' "
@@ -1237,8 +1237,8 @@ test_expect_success $PREREQ '--compose adds MIME for utf8 body' '
 		--to=nobody@example.com \
 		--smtp-server="$(pwd)/fake.sendmail" \
 		$patches &&
-	grep "^utf8 body" msgtxt1 &&
-	grep "^Content-Type: text/plain; charset=UTF-8" msgtxt1
+	test_grep "^utf8 body" msgtxt1 &&
+	test_grep "^Content-Type: text/plain; charset=UTF-8" msgtxt1
 '
 
 test_expect_success $PREREQ '--compose respects user mime type' '
@@ -1260,9 +1260,9 @@ test_expect_success $PREREQ '--compose respects user mime type' '
 		--to=nobody@example.com \
 		--smtp-server="$(pwd)/fake.sendmail" \
 		$patches &&
-	grep "^utf8 body" msgtxt1 &&
-	grep "^Content-Type: text/plain; charset=iso-8859-1" msgtxt1 &&
-	! grep "^Content-Type: text/plain; charset=UTF-8" msgtxt1
+	test_grep "^utf8 body" msgtxt1 &&
+	test_grep "^Content-Type: text/plain; charset=iso-8859-1" msgtxt1 &&
+	test_grep ! "^Content-Type: text/plain; charset=UTF-8" msgtxt1
 '
 
 test_expect_success $PREREQ '--compose adds MIME for utf8 subject' '
@@ -1274,8 +1274,8 @@ test_expect_success $PREREQ '--compose adds MIME for utf8 subject' '
 		--to=nobody@example.com \
 		--smtp-server="$(pwd)/fake.sendmail" \
 		$patches &&
-	grep "^fake edit" msgtxt1 &&
-	grep "^Subject: =?UTF-8?q?utf8-s=C3=BCbj=C3=ABct?=" msgtxt1
+	test_grep "^fake edit" msgtxt1 &&
+	test_grep "^Subject: =?UTF-8?q?utf8-s=C3=BCbj=C3=ABct?=" msgtxt1
 '
 
 test_expect_success $PREREQ 'utf8 author is correctly passed on' '
@@ -1288,7 +1288,7 @@ test_expect_success $PREREQ 'utf8 author is correctly passed on' '
 		--to=nobody@example.com \
 		--smtp-server="$(pwd)/fake.sendmail" \
 		funny_name.patch &&
-	grep "^From: Füñný Nâmé <odd_?=mail@example.com>" msgtxt1
+	test_grep "^From: Füñný Nâmé <odd_?=mail@example.com>" msgtxt1
 '
 
 test_expect_success $PREREQ 'utf8 sender is not duplicated' '
@@ -1361,8 +1361,8 @@ test_expect_success $PREREQ 'sendemail.composeencoding works' '
 		--to=nobody@example.com \
 		--smtp-server="$(pwd)/fake.sendmail" \
 		$patches &&
-	grep "^utf8 body" msgtxt1 &&
-	grep "^Content-Type: text/plain; charset=iso-8859-1" msgtxt1
+	test_grep "^utf8 body" msgtxt1 &&
+	test_grep "^Content-Type: text/plain; charset=iso-8859-1" msgtxt1
 '
 
 test_expect_success $PREREQ '--compose-encoding works' '
@@ -1378,8 +1378,8 @@ test_expect_success $PREREQ '--compose-encoding works' '
 		--to=nobody@example.com \
 		--smtp-server="$(pwd)/fake.sendmail" \
 		$patches &&
-	grep "^utf8 body" msgtxt1 &&
-	grep "^Content-Type: text/plain; charset=iso-8859-1" msgtxt1
+	test_grep "^utf8 body" msgtxt1 &&
+	test_grep "^Content-Type: text/plain; charset=iso-8859-1" msgtxt1
 '
 
 test_expect_success $PREREQ '--compose-encoding overrides sendemail.composeencoding' '
@@ -1396,8 +1396,8 @@ test_expect_success $PREREQ '--compose-encoding overrides sendemail.composeencod
 		--to=nobody@example.com \
 		--smtp-server="$(pwd)/fake.sendmail" \
 		$patches &&
-	grep "^utf8 body" msgtxt1 &&
-	grep "^Content-Type: text/plain; charset=iso-8859-2" msgtxt1
+	test_grep "^utf8 body" msgtxt1 &&
+	test_grep "^Content-Type: text/plain; charset=iso-8859-2" msgtxt1
 '
 
 test_expect_success $PREREQ '--compose-encoding adds correct MIME for subject' '
@@ -1410,8 +1410,8 @@ test_expect_success $PREREQ '--compose-encoding adds correct MIME for subject' '
 		--to=nobody@example.com \
 		--smtp-server="$(pwd)/fake.sendmail" \
 		$patches &&
-	grep "^fake edit" msgtxt1 &&
-	grep "^Subject: =?iso-8859-2?q?utf8-s=C3=BCbj=C3=ABct?=" msgtxt1
+	test_grep "^fake edit" msgtxt1 &&
+	test_grep "^Subject: =?iso-8859-2?q?utf8-s=C3=BCbj=C3=ABct?=" msgtxt1
 '
 
 test_expect_success $PREREQ 'detects ambiguous reference/file conflict' '
@@ -1419,7 +1419,7 @@ test_expect_success $PREREQ 'detects ambiguous reference/file conflict' '
 	git add main &&
 	git commit -m"add main" &&
 	test_must_fail git send-email --dry-run main 2>errors &&
-	grep disambiguate errors
+	test_grep disambiguate errors
 '
 
 test_expect_success $PREREQ 'feed two files' '
@@ -1443,7 +1443,7 @@ test_expect_success $PREREQ 'in-reply-to but no threading' '
 		--in-reply-to="<in-reply-id@example.com>" \
 		--no-thread \
 		$patches >out &&
-	grep "In-Reply-To: <in-reply-id@example.com>" out
+	test_grep "In-Reply-To: <in-reply-id@example.com>" out
 '
 
 test_expect_success $PREREQ 'no in-reply-to and no threading' '
@@ -1453,7 +1453,7 @@ test_expect_success $PREREQ 'no in-reply-to and no threading' '
 		--to=nobody@example.com \
 		--no-thread \
 		$patches >stdout &&
-	! grep "In-Reply-To: " stdout
+	test_grep ! "In-Reply-To: " stdout
 '
 
 test_expect_success $PREREQ 'threading but no chain-reply-to' '
@@ -1464,7 +1464,7 @@ test_expect_success $PREREQ 'threading but no chain-reply-to' '
 		--thread \
 		--no-chain-reply-to \
 		$patches $patches >stdout &&
-	grep "In-Reply-To: " stdout
+	test_grep "In-Reply-To: " stdout
 '
 
 test_expect_success $PREREQ 'override in-reply-to if no threading' '
@@ -1475,7 +1475,7 @@ test_expect_success $PREREQ 'override in-reply-to if no threading' '
 		--no-thread \
 		--in-reply-to="override" \
 		$threaded_patches >stdout &&
-	grep "In-Reply-To: <override>" stdout
+	test_grep "In-Reply-To: <override>" stdout
 '
 
 test_expect_success $PREREQ 'sendemail.to works' '
@@ -1484,7 +1484,7 @@ test_expect_success $PREREQ 'sendemail.to works' '
 		--dry-run \
 		--from="Example <nobody@example.com>" \
 		$patches >stdout &&
-	grep "To: Somebody <somebody@ex.com>" stdout
+	test_grep "To: Somebody <somebody@ex.com>" stdout
 '
 
 test_expect_success $PREREQ 'setup sendemail.identity' '
@@ -1498,7 +1498,7 @@ test_expect_success $PREREQ 'sendemail.identity: reads the correct identity conf
 		--dry-run \
 		--from="nobody@example.com" \
 		$patches >stdout &&
-	grep "To: cloud@example.com" stdout
+	test_grep "To: cloud@example.com" stdout
 '
 
 test_expect_success $PREREQ 'sendemail.identity: identity overrides sendemail.identity' '
@@ -1507,7 +1507,7 @@ test_expect_success $PREREQ 'sendemail.identity: identity overrides sendemail.id
 		--dry-run \
 		--from="nobody@example.com" \
 		$patches >stdout &&
-	grep "To: isp@example.com" stdout
+	test_grep "To: isp@example.com" stdout
 '
 
 test_expect_success $PREREQ 'sendemail.identity: --no-identity clears previous identity' '
@@ -1516,7 +1516,7 @@ test_expect_success $PREREQ 'sendemail.identity: --no-identity clears previous i
 		--dry-run \
 		--from="nobody@example.com" \
 		$patches >stdout &&
-	grep "To: default@example.com" stdout
+	test_grep "To: default@example.com" stdout
 '
 
 test_expect_success $PREREQ 'sendemail.identity: bool identity variable existence overrides' '
@@ -1527,8 +1527,8 @@ test_expect_success $PREREQ 'sendemail.identity: bool identity variable existenc
 		--dry-run \
 		--from="nobody@example.com" \
 		$patches >stdout &&
-	grep "To: cloud@example.com" stdout &&
-	! grep "X-Mailer" stdout
+	test_grep "To: cloud@example.com" stdout &&
+	test_grep ! "X-Mailer" stdout
 '
 
 test_expect_success $PREREQ 'sendemail.identity: bool variable fallback' '
@@ -1538,8 +1538,8 @@ test_expect_success $PREREQ 'sendemail.identity: bool variable fallback' '
 		--dry-run \
 		--from="nobody@example.com" \
 		$patches >stdout &&
-	grep "To: cloud@example.com" stdout &&
-	! grep "X-Mailer" stdout
+	test_grep "To: cloud@example.com" stdout &&
+	test_grep ! "X-Mailer" stdout
 '
 
 test_expect_success $PREREQ 'sendemail.identity: bool variable without a value' '
@@ -1548,8 +1548,8 @@ test_expect_success $PREREQ 'sendemail.identity: bool variable without a value'
 		--dry-run \
 		--from="nobody@example.com" \
 		$patches >stdout &&
-	grep "To: default@example.com" stdout &&
-	grep "X-Mailer" stdout
+	test_grep "To: default@example.com" stdout &&
+	test_grep "X-Mailer" stdout
 '
 
 test_expect_success $PREREQ '--no-to overrides sendemail.to' '
@@ -1559,8 +1559,8 @@ test_expect_success $PREREQ '--no-to overrides sendemail.to' '
 		--no-to \
 		--to=nobody@example.com \
 		$patches >stdout &&
-	grep "To: nobody@example.com" stdout &&
-	! grep "To: Somebody <somebody@ex.com>" stdout
+	test_grep "To: nobody@example.com" stdout &&
+	test_grep ! "To: Somebody <somebody@ex.com>" stdout
 '
 
 test_expect_success $PREREQ 'sendemail.cc works' '
@@ -1570,7 +1570,7 @@ test_expect_success $PREREQ 'sendemail.cc works' '
 		--from="Example <nobody@example.com>" \
 		--to=nobody@example.com \
 		$patches >stdout &&
-	grep "Cc: Somebody <somebody@ex.com>" stdout
+	test_grep "Cc: Somebody <somebody@ex.com>" stdout
 '
 
 test_expect_success $PREREQ '--no-cc overrides sendemail.cc' '
@@ -1581,8 +1581,8 @@ test_expect_success $PREREQ '--no-cc overrides sendemail.cc' '
 		--cc=bodies@example.com \
 		--to=nobody@example.com \
 		$patches >stdout &&
-	grep "Cc: bodies@example.com" stdout &&
-	! grep "Cc: Somebody <somebody@ex.com>" stdout
+	test_grep "Cc: bodies@example.com" stdout &&
+	test_grep ! "Cc: Somebody <somebody@ex.com>" stdout
 '
 
 test_expect_success $PREREQ 'sendemail.bcc works' '
@@ -1593,7 +1593,7 @@ test_expect_success $PREREQ 'sendemail.bcc works' '
 		--to=nobody@example.com \
 		--smtp-server relay.example.com \
 		$patches >stdout &&
-	grep "RCPT TO:<other@ex.com>" stdout
+	test_grep "RCPT TO:<other@ex.com>" stdout
 '
 
 test_expect_success $PREREQ '--no-bcc overrides sendemail.bcc' '
@@ -1605,8 +1605,8 @@ test_expect_success $PREREQ '--no-bcc overrides sendemail.bcc' '
 		--to=nobody@example.com \
 		--smtp-server relay.example.com \
 		$patches >stdout &&
-	grep "RCPT TO:<bodies@example.com>" stdout &&
-	! grep "RCPT TO:<other@ex.com>" stdout
+	test_grep "RCPT TO:<bodies@example.com>" stdout &&
+	test_grep ! "RCPT TO:<other@ex.com>" stdout
 '
 
 test_expect_success $PREREQ 'patches To headers are used by default' '
@@ -1617,7 +1617,7 @@ test_expect_success $PREREQ 'patches To headers are used by default' '
 		--from="Example <nobody@example.com>" \
 		--smtp-server relay.example.com \
 		$patch >stdout &&
-	grep "RCPT TO:<bodies@example.com>" stdout
+	test_grep "RCPT TO:<bodies@example.com>" stdout
 '
 
 test_expect_success $PREREQ 'patches To headers are appended to' '
@@ -1629,8 +1629,8 @@ test_expect_success $PREREQ 'patches To headers are appended to' '
 		--to=nobody@example.com \
 		--smtp-server relay.example.com \
 		$patch >stdout &&
-	grep "RCPT TO:<bodies@example.com>" stdout &&
-	grep "RCPT TO:<nobody@example.com>" stdout
+	test_grep "RCPT TO:<bodies@example.com>" stdout &&
+	test_grep "RCPT TO:<nobody@example.com>" stdout
 '
 
 test_expect_success $PREREQ 'To headers from files reset each patch' '
@@ -1691,9 +1691,9 @@ test_expect_success $PREREQ 'asks about and fixes 8bit encodings' '
 	git send-email --from=author@example.com --to=nobody@example.com \
 			--smtp-server="$(pwd)/fake.sendmail" \
 			email-using-8bit >stdout &&
-	grep "do not declare a Content-Transfer-Encoding" stdout &&
-	grep email-using-8bit stdout &&
-	grep "Declare which 8bit encoding to use" stdout &&
+	test_grep "do not declare a Content-Transfer-Encoding" stdout &&
+	test_grep email-using-8bit stdout &&
+	test_grep "Declare which 8bit encoding to use" stdout &&
 	grep -E "Content|MIME" msgtxt1 >actual &&
 	test_cmp content-type-decl actual
 '
@@ -1790,7 +1790,7 @@ test_expect_success $PREREQ '--transfer-encoding overrides sendemail.transferEnc
 		--smtp-server="$(pwd)/fake.sendmail" \
 		email-using-8bit \
 		2>errors >out &&
-	grep "cannot send message as 7bit" errors &&
+	test_grep "cannot send message as 7bit" errors &&
 	test -z "$(ls msgtxt*)"
 '
 
@@ -1801,7 +1801,7 @@ test_expect_success $PREREQ 'sendemail.transferEncoding via config' '
 		--smtp-server="$(pwd)/fake.sendmail" \
 		email-using-8bit \
 		2>errors >out &&
-	grep "cannot send message as 7bit" errors &&
+	test_grep "cannot send message as 7bit" errors &&
 	test -z "$(ls msgtxt*)"
 '
 
@@ -1812,7 +1812,7 @@ test_expect_success $PREREQ 'sendemail.transferEncoding via cli' '
 		--smtp-server="$(pwd)/fake.sendmail" \
 		email-using-8bit \
 		2>errors >out &&
-	grep "cannot send message as 7bit" errors &&
+	test_grep "cannot send message as 7bit" errors &&
 	test -z "$(ls msgtxt*)"
 '
 
@@ -1939,7 +1939,7 @@ test_expect_success $PREREQ 'refusing to send cover letter template' '
 		outdir/0000-*.patch \
 		outdir/0001-*.patch \
 		2>errors >out &&
-	grep "SUBJECT HERE" errors &&
+	test_grep "SUBJECT HERE" errors &&
 	test -z "$(ls msgtxt*)"
 '
 
@@ -1956,7 +1956,7 @@ test_expect_success $PREREQ '--force sends cover letter template anyway' '
 		outdir/0000-*.patch \
 		outdir/0001-*.patch \
 		2>errors >out &&
-	! grep "SUBJECT HERE" errors &&
+	test_grep ! "SUBJECT HERE" errors &&
 	test -n "$(ls msgtxt*)"
 '
 
@@ -2016,8 +2016,8 @@ test_expect_success $PREREQ 'escaped quotes in sendemail.aliasfiletype=mutt' '
 		--smtp-server="$(pwd)/fake.sendmail" \
 		outdir/0001-*.patch \
 		2>errors >out &&
-	grep "^!somebody@example\.org!$" commandline1 &&
-	grep -F "To: \"Dot U. Sir\" <somebody@example.org>" out
+	test_grep "^!somebody@example\.org!$" commandline1 &&
+	test_grep -F "To: \"Dot U. Sir\" <somebody@example.org>" out
 '
 
 test_expect_success $PREREQ 'sendemail.aliasfiletype=mailrc' '
@@ -2031,7 +2031,7 @@ test_expect_success $PREREQ 'sendemail.aliasfiletype=mailrc' '
 		--smtp-server="$(pwd)/fake.sendmail" \
 		outdir/0001-*.patch \
 		2>errors >out &&
-	grep "^!somebody@example\.org!$" commandline1
+	test_grep "^!somebody@example\.org!$" commandline1
 '
 
 test_expect_success $PREREQ 'sendemail.aliasesfile=~/.mailrc' '
@@ -2045,7 +2045,7 @@ test_expect_success $PREREQ 'sendemail.aliasesfile=~/.mailrc' '
 		--smtp-server="$(pwd)/fake.sendmail" \
 		outdir/0001-*.patch \
 		2>errors >out &&
-	grep "^!someone@example\.org!$" commandline1
+	test_grep "^!someone@example\.org!$" commandline1
 '
 
 test_dump_aliases () {
@@ -2264,7 +2264,7 @@ test_sendmail_aliases () {
 			2>errors >out &&
 		for i in $expect
 		do
-			grep "^!$i!$" commandline1 || return 1
+			test_grep "^!$i!$" commandline1 || return 1
 		done
 	'
 }
@@ -2328,7 +2328,7 @@ test_expect_success $PREREQ 'alias support in To header' '
 		--smtp-server="$(pwd)/fake.sendmail" \
 		aliased.patch \
 		2>errors >out &&
-	grep "^!someone@example\.org!$" commandline1
+	test_grep "^!someone@example\.org!$" commandline1
 '
 
 test_expect_success $PREREQ 'alias support in Cc header' '
@@ -2342,7 +2342,7 @@ test_expect_success $PREREQ 'alias support in Cc header' '
 		--smtp-server="$(pwd)/fake.sendmail" \
 		aliased.patch \
 		2>errors >out &&
-	grep "^!someone@example\.org!$" commandline1
+	test_grep "^!someone@example\.org!$" commandline1
 '
 
 test_expect_success $PREREQ 'tocmd works with aliases' '
@@ -2358,7 +2358,7 @@ test_expect_success $PREREQ 'tocmd works with aliases' '
 		--smtp-server="$(pwd)/fake.sendmail" \
 		tocmd.patch \
 		2>errors >out &&
-	grep "^!someone@example\.org!$" commandline1
+	test_grep "^!someone@example\.org!$" commandline1
 '
 
 test_expect_success $PREREQ 'cccmd works with aliases' '
@@ -2374,7 +2374,7 @@ test_expect_success $PREREQ 'cccmd works with aliases' '
 		--smtp-server="$(pwd)/fake.sendmail" \
 		cccmd.patch \
 		2>errors >out &&
-	grep "^!someone@example\.org!$" commandline1
+	test_grep "^!someone@example\.org!$" commandline1
 '
 
 do_xmailer_test () {
@@ -2511,7 +2511,7 @@ test_expect_success $PREREQ 'mailmap support with --to' '
 		--mailmap \
 		a.patch \
 		2>errors >out &&
-	grep "^!someone@example\.com!$" commandline1
+	test_grep "^!someone@example\.com!$" commandline1
 '
 
 test_expect_success $PREREQ 'sendemail.mailmap configuration' '
@@ -2528,7 +2528,7 @@ test_expect_success $PREREQ 'sendemail.mailmap configuration' '
 		--to=someone@example.org \
 		a.patch \
 		2>errors >out &&
-	grep "^!someone@example\.com!$" commandline1
+	test_grep "^!someone@example\.com!$" commandline1
 '
 
 test_expect_success $PREREQ 'sendemail.mailmap.file configuration' '
@@ -2545,7 +2545,7 @@ test_expect_success $PREREQ 'sendemail.mailmap.file configuration' '
 		--to=someone@example.org \
 		a.patch \
 		2>errors >out &&
-	grep "^!someone@example\.com!$" commandline1
+	test_grep "^!someone@example\.com!$" commandline1
 '
 
 test_expect_success $PREREQ 'sendemail.mailmap identity overrides configuration' '
@@ -2564,7 +2564,7 @@ test_expect_success $PREREQ 'sendemail.mailmap identity overrides configuration'
 		--to=someone@example.org \
 		a.patch \
 		2>errors >out &&
-	grep "^!someone@example\.com!$" commandline1
+	test_grep "^!someone@example\.com!$" commandline1
 '
 
 test_expect_success $PREREQ '--no-mailmap overrides configuration' '
@@ -2584,7 +2584,7 @@ test_expect_success $PREREQ '--no-mailmap overrides configuration' '
 		--no-mailmap \
 		a.patch \
 		2>errors >out &&
-	grep "^!someone@example\.org!$" commandline1
+	test_grep "^!someone@example\.org!$" commandline1
 '
 
 test_expect_success $PREREQ 'mailmap support in To header' '
@@ -2600,7 +2600,7 @@ test_expect_success $PREREQ 'mailmap support in To header' '
 		--mailmap \
 		a.patch \
 		2>errors >out &&
-	grep "^!someone@example\.com!$" commandline1
+	test_grep "^!someone@example\.com!$" commandline1
 '
 
 test_expect_success $PREREQ 'mailmap support in Cc header' '
@@ -2616,7 +2616,7 @@ test_expect_success $PREREQ 'mailmap support in Cc header' '
 		--mailmap \
 		a.patch \
 		2>errors >out &&
-	grep "^!someone@example\.com!$" commandline1
+	test_grep "^!someone@example\.com!$" commandline1
 '
 
 test_expect_success $PREREQ 'test using command name with --sendmail-cmd' '
@@ -2676,9 +2676,9 @@ test_expect_success $PREREQ 'patch reply headers correct with --no-thread' '
 		--to=nobody@example.com \
 		--smtp-server="$(pwd)/fake.sendmail" \
 		has-reply.patch no-reply.patch &&
-	grep "In-Reply-To: <replied.to@example.com>" msgtxt1 &&
-	grep "References: <replied.to@example.com>" msgtxt1 &&
-	! grep replied.to@example.com msgtxt2
+	test_grep "In-Reply-To: <replied.to@example.com>" msgtxt1 &&
+	test_grep "References: <replied.to@example.com>" msgtxt1 &&
+	test_grep ! replied.to@example.com msgtxt2
 '
 
 test_expect_success $PREREQ 'cmdline in-reply-to used with --no-thread' '
@@ -2689,10 +2689,10 @@ test_expect_success $PREREQ 'cmdline in-reply-to used with --no-thread' '
 		--to=nobody@example.com \
 		--smtp-server="$(pwd)/fake.sendmail" \
 		has-reply.patch no-reply.patch &&
-	grep "In-Reply-To: <cmdline.reply@example.com>" msgtxt1 &&
-	grep "References: <cmdline.reply@example.com>" msgtxt1 &&
-	grep "In-Reply-To: <cmdline.reply@example.com>" msgtxt2 &&
-	grep "References: <cmdline.reply@example.com>" msgtxt2
+	test_grep "In-Reply-To: <cmdline.reply@example.com>" msgtxt1 &&
+	test_grep "References: <cmdline.reply@example.com>" msgtxt1 &&
+	test_grep "In-Reply-To: <cmdline.reply@example.com>" msgtxt2 &&
+	test_grep "References: <cmdline.reply@example.com>" msgtxt2
 '
 
 test_expect_success $PREREQ 'invoke hook' '
@@ -2775,7 +2775,7 @@ test_expect_success $PREREQ 'test that send-email works outside a repo' '
 test_expect_success $PREREQ 'send-email relays -v 3 to format-patch' '
 	test_when_finished "rm -f out" &&
 	git send-email --dry-run -v 3 -1 >out &&
-	grep "PATCH v3" out
+	test_grep "PATCH v3" out
 '
 
 test_expect_success $PREREQ 'test that sendmail config is rejected' '
@@ -2819,7 +2819,7 @@ test_expect_success $PREREQ '--compose handles lowercase headers' '
 		--to=nobody@example.com \
 		--smtp-server="$(pwd)/fake.sendmail" \
 		HEAD^ &&
-	grep "From: edited-from@example.com" msgtxt1
+	test_grep "From: edited-from@example.com" msgtxt1
 '
 
 test_expect_success $PREREQ '--compose handles to headers' '
diff --git a/t/t9003-help-autocorrect.sh b/t/t9003-help-autocorrect.sh
index 8da318d2b5..87b438fcac 100755
--- a/t/t9003-help-autocorrect.sh
+++ b/t/t9003-help-autocorrect.sh
@@ -34,10 +34,10 @@ do
 		git config help.autocorrect $show &&
 
 		test_must_fail git lfg 2>actual &&
-		grep "^	lgf" actual &&
+		test_grep "^	lgf" actual &&
 
 		test_must_fail git distimdist 2>actual &&
-		grep "^	distimdistim" actual
+		test_grep "^	distimdistim" actual
 	'
 done
 
@@ -60,7 +60,7 @@ test_expect_success 'autocorrect can be declined altogether' '
 	git config help.autocorrect never &&
 
 	test_must_fail git lfg 2>actual &&
-	grep "is not a git command" actual &&
+	test_grep "is not a git command" actual &&
 	test_line_count = 1 actual
 '
 
diff --git a/t/t9106-git-svn-commit-diff-clobber.sh b/t/t9106-git-svn-commit-diff-clobber.sh
index bca496c40e..376100fd7a 100755
--- a/t/t9106-git-svn-commit-diff-clobber.sh
+++ b/t/t9106-git-svn-commit-diff-clobber.sh
@@ -94,7 +94,7 @@ test_expect_success 'multiple dcommit from git svn will not clobber svn' "
 
 test_expect_success 'check that rebase really failed' '
 	git status >output &&
-	grep currently.rebasing output
+	test_grep currently.rebasing output
 '
 
 test_expect_success 'resolve, continue the rebase and dcommit' "
diff --git a/t/t9107-git-svn-migrate.sh b/t/t9107-git-svn-migrate.sh
index aa908bbc2f..6d7d2aa491 100755
--- a/t/t9107-git-svn-migrate.sh
+++ b/t/t9107-git-svn-migrate.sh
@@ -46,7 +46,7 @@ test_expect_success 'initialize old-style (v0) git svn layout' '
 test_expect_success 'initialize a multi-repository repo' '
 	git svn init "$svnrepo" -T trunk -t tags -b branches &&
 	git config --get-all svn-remote.svn.fetch > fetch.out &&
-	grep "^trunk:refs/remotes/origin/trunk$" fetch.out &&
+	test_grep "^trunk:refs/remotes/origin/trunk$" fetch.out &&
 	test -n "$(git config --get svn-remote.svn.branches \
 		    "^branches/\*:refs/remotes/origin/\*$")" &&
 	test -n "$(git config --get svn-remote.svn.tags \
@@ -63,13 +63,13 @@ test_expect_success 'initialize a multi-repository repo' '
 			$i:refs/remotes/origin/$i || return 1
 	done &&
 	git config --get-all svn-remote.svn.fetch > fetch.out &&
-	grep "^trunk:refs/remotes/origin/trunk$" fetch.out &&
-	grep "^branches/a:refs/remotes/origin/a$" fetch.out &&
-	grep "^branches/b:refs/remotes/origin/b$" fetch.out &&
-	grep "^tags/0\.1:refs/remotes/origin/tags/0\.1$" fetch.out &&
-	grep "^tags/0\.2:refs/remotes/origin/tags/0\.2$" fetch.out &&
-	grep "^tags/0\.3:refs/remotes/origin/tags/0\.3$" fetch.out &&
-	grep "^:refs/remotes/git-svn" fetch.out
+	test_grep "^trunk:refs/remotes/origin/trunk$" fetch.out &&
+	test_grep "^branches/a:refs/remotes/origin/a$" fetch.out &&
+	test_grep "^branches/b:refs/remotes/origin/b$" fetch.out &&
+	test_grep "^tags/0\.1:refs/remotes/origin/tags/0\.1$" fetch.out &&
+	test_grep "^tags/0\.2:refs/remotes/origin/tags/0\.2$" fetch.out &&
+	test_grep "^tags/0\.3:refs/remotes/origin/tags/0\.3$" fetch.out &&
+	test_grep "^:refs/remotes/git-svn" fetch.out
 	'
 
 # refs should all be different, but the trees should all be the same:
@@ -109,13 +109,13 @@ test_expect_success 'migrate --minimize on old inited layout' '
 	git svn migrate --minimize &&
 	test -z "$(git config -l | grep "^svn-remote\.git-svn\.")" &&
 	git config --get-all svn-remote.svn.fetch > fetch.out &&
-	grep "^trunk:refs/remotes/origin/trunk$" fetch.out &&
-	grep "^branches/a:refs/remotes/origin/a$" fetch.out &&
-	grep "^branches/b:refs/remotes/origin/b$" fetch.out &&
-	grep "^tags/0\.1:refs/remotes/origin/tags/0\.1$" fetch.out &&
-	grep "^tags/0\.2:refs/remotes/origin/tags/0\.2$" fetch.out &&
-	grep "^tags/0\.3:refs/remotes/origin/tags/0\.3$" fetch.out &&
-	grep "^:refs/remotes/git-svn" fetch.out
+	test_grep "^trunk:refs/remotes/origin/trunk$" fetch.out &&
+	test_grep "^branches/a:refs/remotes/origin/a$" fetch.out &&
+	test_grep "^branches/b:refs/remotes/origin/b$" fetch.out &&
+	test_grep "^tags/0\.1:refs/remotes/origin/tags/0\.1$" fetch.out &&
+	test_grep "^tags/0\.2:refs/remotes/origin/tags/0\.2$" fetch.out &&
+	test_grep "^tags/0\.3:refs/remotes/origin/tags/0\.3$" fetch.out &&
+	test_grep "^:refs/remotes/git-svn" fetch.out
 	'
 
 test_expect_success  ".rev_db auto-converted to .rev_map.UUID" '
diff --git a/t/t9110-git-svn-use-svm-props.sh b/t/t9110-git-svn-use-svm-props.sh
index ad37d980c9..9dc4a31a44 100755
--- a/t/t9110-git-svn-use-svm-props.sh
+++ b/t/t9110-git-svn-use-svm-props.sh
@@ -22,36 +22,36 @@ uuid=161ce429-a9dd-4828-af4a-52023f968c89
 bar_url=http://mayonaise/svnrepo/bar
 test_expect_success 'verify metadata for /bar' "
 	git cat-file commit refs/remotes/bar >actual &&
-	grep '^git-svn-id: $bar_url@12 $uuid$' actual &&
+	test_grep '^git-svn-id: $bar_url@12 $uuid$' actual &&
 	git cat-file commit refs/remotes/bar~1 >actual &&
-	grep '^git-svn-id: $bar_url@11 $uuid$' actual &&
+	test_grep '^git-svn-id: $bar_url@11 $uuid$' actual &&
 	git cat-file commit refs/remotes/bar~2 >actual &&
-	grep '^git-svn-id: $bar_url@10 $uuid$' actual &&
+	test_grep '^git-svn-id: $bar_url@10 $uuid$' actual &&
 	git cat-file commit refs/remotes/bar~3 >actual &&
-	grep '^git-svn-id: $bar_url@9 $uuid$' actual &&
+	test_grep '^git-svn-id: $bar_url@9 $uuid$' actual &&
 	git cat-file commit refs/remotes/bar~4 >actual &&
-	grep '^git-svn-id: $bar_url@6 $uuid$' actual &&
+	test_grep '^git-svn-id: $bar_url@6 $uuid$' actual &&
 	git cat-file commit refs/remotes/bar~5 >actual &&
-	grep '^git-svn-id: $bar_url@1 $uuid$' actual
+	test_grep '^git-svn-id: $bar_url@1 $uuid$' actual
 	"
 
 e_url=http://mayonaise/svnrepo/dir/a/b/c/d/e
 test_expect_success 'verify metadata for /dir/a/b/c/d/e' "
 	git cat-file commit refs/remotes/e >actual &&
-	grep '^git-svn-id: $e_url@1 $uuid$' actual
+	test_grep '^git-svn-id: $e_url@1 $uuid$' actual
 	"
 
 dir_url=http://mayonaise/svnrepo/dir
 test_expect_success 'verify metadata for /dir' "
 	git cat-file commit refs/remotes/dir >actual &&
-	grep '^git-svn-id: $dir_url@2 $uuid$' actual &&
+	test_grep '^git-svn-id: $dir_url@2 $uuid$' actual &&
 	git cat-file commit refs/remotes/dir~1 >actual &&
-	grep '^git-svn-id: $dir_url@1 $uuid$' actual
+	test_grep '^git-svn-id: $dir_url@1 $uuid$' actual
 	"
 
 test_expect_success 'find commit based on SVN revision number' "
 	git svn find-rev r12 >actual &&
-	grep $(git rev-parse HEAD) actual
+	test_grep $(git rev-parse HEAD) actual
         "
 
 test_expect_success 'empty rebase' "
diff --git a/t/t9111-git-svn-use-svnsync-props.sh b/t/t9111-git-svn-use-svnsync-props.sh
index 6c93073551..e45d81bfc4 100755
--- a/t/t9111-git-svn-use-svnsync-props.sh
+++ b/t/t9111-git-svn-use-svnsync-props.sh
@@ -21,31 +21,31 @@ uuid=161ce429-a9dd-4828-af4a-52023f968c89
 bar_url=http://mayonaise/svnrepo/bar
 test_expect_success 'verify metadata for /bar' "
 	git cat-file commit refs/remotes/bar >actual &&
-	grep '^git-svn-id: $bar_url@12 $uuid$' actual &&
+	test_grep '^git-svn-id: $bar_url@12 $uuid$' actual &&
 	git cat-file commit refs/remotes/bar~1 >actual &&
-	grep '^git-svn-id: $bar_url@11 $uuid$' actual &&
+	test_grep '^git-svn-id: $bar_url@11 $uuid$' actual &&
 	git cat-file commit refs/remotes/bar~2 >actual &&
-	grep '^git-svn-id: $bar_url@10 $uuid$' actual &&
+	test_grep '^git-svn-id: $bar_url@10 $uuid$' actual &&
 	git cat-file commit refs/remotes/bar~3 >actual &&
-	grep '^git-svn-id: $bar_url@9 $uuid$' actual &&
+	test_grep '^git-svn-id: $bar_url@9 $uuid$' actual &&
 	git cat-file commit refs/remotes/bar~4 >actual &&
-	grep '^git-svn-id: $bar_url@6 $uuid$' actual &&
+	test_grep '^git-svn-id: $bar_url@6 $uuid$' actual &&
 	git cat-file commit refs/remotes/bar~5 >actual &&
-	grep '^git-svn-id: $bar_url@1 $uuid$' actual
+	test_grep '^git-svn-id: $bar_url@1 $uuid$' actual
 	"
 
 e_url=http://mayonaise/svnrepo/dir/a/b/c/d/e
 test_expect_success 'verify metadata for /dir/a/b/c/d/e' "
 	git cat-file commit refs/remotes/e >actual &&
-	grep '^git-svn-id: $e_url@1 $uuid$' actual
+	test_grep '^git-svn-id: $e_url@1 $uuid$' actual
 	"
 
 dir_url=http://mayonaise/svnrepo/dir
 test_expect_success 'verify metadata for /dir' "
 	git cat-file commit refs/remotes/dir >actual &&
-	grep '^git-svn-id: $dir_url@2 $uuid$' actual &&
+	test_grep '^git-svn-id: $dir_url@2 $uuid$' actual &&
 	git cat-file commit refs/remotes/dir~1 >actual &&
-	grep '^git-svn-id: $dir_url@1 $uuid$' actual
+	test_grep '^git-svn-id: $dir_url@1 $uuid$' actual
 	"
 
 test_done
diff --git a/t/t9114-git-svn-dcommit-merge.sh b/t/t9114-git-svn-dcommit-merge.sh
index e06538b1c8..2240b58d4d 100755
--- a/t/t9114-git-svn-dcommit-merge.sh
+++ b/t/t9114-git-svn-dcommit-merge.sh
@@ -69,7 +69,7 @@ test_expect_success 'verify pre-merge ancestry' "
 	test x\$(git rev-parse --verify refs/heads/svn^2) = \
 	     x\$(git rev-parse --verify refs/heads/merge) &&
 	git cat-file commit refs/heads/svn^ >actual &&
-	grep '^friend$' actual
+	test_grep '^friend$' actual
 	"
 
 test_expect_success 'git svn dcommit merges' "
@@ -84,12 +84,12 @@ test_expect_success 'verify post-merge ancestry' "
 	test x\$(git rev-parse --verify refs/heads/svn^2) = \
 	     x\$(git rev-parse --verify refs/heads/merge) &&
 	git cat-file commit refs/heads/svn^ >actual &&
-	grep '^friend$' actual
+	test_grep '^friend$' actual
 	"
 
 test_expect_success 'verify merge commit message' "
 	git rev-list --pretty=raw -1 refs/heads/svn >actual &&
-	grep \"    Merge branch 'merge' into svn\" actual
+	test_grep \"    Merge branch 'merge' into svn\" actual
 	"
 
 test_done
diff --git a/t/t9116-git-svn-log.sh b/t/t9116-git-svn-log.sh
index d74d7b2de6..b2e1248651 100755
--- a/t/t9116-git-svn-log.sh
+++ b/t/t9116-git-svn-log.sh
@@ -45,17 +45,17 @@ test_expect_success 'setup repository and import' '
 test_expect_success 'run log' "
 	git reset --hard origin/a &&
 	git svn log -r2 origin/trunk >out &&
-	grep ^r2 out &&
+	test_grep ^r2 out &&
 	git svn log -r4 origin/trunk >out &&
-	grep ^r4 out &&
+	test_grep ^r4 out &&
 	git svn log -r3 >out &&
-	grep ^r3 out
+	test_grep ^r3 out
 	"
 
 test_expect_success 'run log against a from trunk' "
 	git reset --hard origin/trunk &&
 	git svn log -r3 origin/a >out &&
-	grep ^r3 out
+	test_grep ^r3 out
 	"
 
 printf 'r1 \nr2 \nr4 \n' > expected-range-r1-r2-r4
diff --git a/t/t9117-git-svn-init-clone.sh b/t/t9117-git-svn-init-clone.sh
index 3b038c338f..b2815b6894 100755
--- a/t/t9117-git-svn-init-clone.sh
+++ b/t/t9117-git-svn-init-clone.sh
@@ -49,7 +49,7 @@ test_expect_success 'clone to target directory with --stdlayout' '
 test_expect_success 'init without -s/-T/-b/-t does not warn' '
 	test ! -d trunk &&
 	git svn init "$svnrepo"/project/trunk trunk 2>warning &&
-	! grep -q prefix warning &&
+	test_grep ! -q prefix warning &&
 	rm -rf trunk &&
 	rm -f warning
 	'
@@ -57,7 +57,7 @@ test_expect_success 'init without -s/-T/-b/-t does not warn' '
 test_expect_success 'clone without -s/-T/-b/-t does not warn' '
 	test ! -d trunk &&
 	git svn clone "$svnrepo"/project/trunk 2>warning &&
-	! grep -q prefix warning &&
+	test_grep ! -q prefix warning &&
 	rm -rf trunk &&
 	rm -f warning
 	'
@@ -80,7 +80,7 @@ EOF
 test_expect_success 'init with -s/-T/-b/-t assumes --prefix=origin/' '
 	test ! -d project &&
 	git svn init -s "$svnrepo"/project project 2>warning &&
-	! grep -q prefix warning &&
+	test_grep ! -q prefix warning &&
 	test_svn_configured_prefix "origin/" &&
 	rm -rf project &&
 	rm -f warning
@@ -89,7 +89,7 @@ test_expect_success 'init with -s/-T/-b/-t assumes --prefix=origin/' '
 test_expect_success 'clone with -s/-T/-b/-t assumes --prefix=origin/' '
 	test ! -d project &&
 	git svn clone -s "$svnrepo"/project 2>warning &&
-	! grep -q prefix warning &&
+	test_grep ! -q prefix warning &&
 	test_svn_configured_prefix "origin/" &&
 	rm -rf project &&
 	rm -f warning
@@ -98,7 +98,7 @@ test_expect_success 'clone with -s/-T/-b/-t assumes --prefix=origin/' '
 test_expect_success 'init with -s/-T/-b/-t and --prefix "" still works' '
 	test ! -d project &&
 	git svn init -s "$svnrepo"/project project --prefix "" 2>warning &&
-	! grep -q prefix warning &&
+	test_grep ! -q prefix warning &&
 	test_svn_configured_prefix "" &&
 	rm -rf project &&
 	rm -f warning
@@ -107,7 +107,7 @@ test_expect_success 'init with -s/-T/-b/-t and --prefix "" still works' '
 test_expect_success 'clone with -s/-T/-b/-t and --prefix "" still works' '
 	test ! -d project &&
 	git svn clone -s "$svnrepo"/project --prefix "" 2>warning &&
-	! grep -q prefix warning &&
+	test_grep ! -q prefix warning &&
 	test_svn_configured_prefix "" &&
 	rm -rf project &&
 	rm -f warning
diff --git a/t/t9119-git-svn-info.sh b/t/t9119-git-svn-info.sh
index 088d1c57a8..0dbb2e4a97 100755
--- a/t/t9119-git-svn-info.sh
+++ b/t/t9119-git-svn-info.sh
@@ -333,27 +333,27 @@ test_expect_success 'info unknown-file' "
 	echo two > gitwc/unknown-file &&
 	(cd gitwc && test_must_fail git svn info unknown-file) \
 		 2> actual.info-unknown-file &&
-	grep unknown-file actual.info-unknown-file
+	test_grep unknown-file actual.info-unknown-file
 	"
 
 test_expect_success 'info --url unknown-file' '
 	echo two > gitwc/unknown-file &&
 	(cd gitwc && test_must_fail git svn info --url unknown-file) \
 		 2> actual.info-url-unknown-file &&
-	grep unknown-file actual.info-url-unknown-file
+	test_grep unknown-file actual.info-url-unknown-file
 	'
 
 test_expect_success 'info unknown-directory' "
 	mkdir gitwc/unknown-directory svnwc/unknown-directory &&
 	(cd gitwc && test_must_fail git svn info unknown-directory) \
 		 2> actual.info-unknown-directory &&
-	grep unknown-directory actual.info-unknown-directory
+	test_grep unknown-directory actual.info-unknown-directory
 	"
 
 test_expect_success 'info --url unknown-directory' '
 	(cd gitwc && test_must_fail git svn info --url unknown-directory) \
 		 2> actual.info-url-unknown-directory &&
-	grep unknown-directory actual.info-url-unknown-directory
+	test_grep unknown-directory actual.info-url-unknown-directory
 	'
 
 test_expect_success 'info unknown-symlink-file' "
@@ -363,13 +363,13 @@ test_expect_success 'info unknown-symlink-file' "
 	) &&
 	(cd gitwc && test_must_fail git svn info unknown-symlink-file) \
 		 2> actual.info-unknown-symlink-file &&
-	grep unknown-symlink-file actual.info-unknown-symlink-file
+	test_grep unknown-symlink-file actual.info-unknown-symlink-file
 	"
 
 test_expect_success 'info --url unknown-symlink-file' '
 	(cd gitwc && test_must_fail git svn info --url unknown-symlink-file) \
 		 2> actual.info-url-unknown-symlink-file &&
-	grep unknown-symlink-file actual.info-url-unknown-symlink-file
+	test_grep unknown-symlink-file actual.info-url-unknown-symlink-file
 	'
 
 test_expect_success 'info unknown-symlink-directory' "
@@ -379,13 +379,13 @@ test_expect_success 'info unknown-symlink-directory' "
 	) &&
 	(cd gitwc && test_must_fail git svn info unknown-symlink-directory) \
 		 2> actual.info-unknown-symlink-directory &&
-	grep unknown-symlink-directory actual.info-unknown-symlink-directory
+	test_grep unknown-symlink-directory actual.info-unknown-symlink-directory
 	"
 
 test_expect_success 'info --url unknown-symlink-directory' '
 	(cd gitwc && test_must_fail git svn info --url unknown-symlink-directory) \
 		 2> actual.info-url-unknown-symlink-directory &&
-	grep unknown-symlink-directory actual.info-url-unknown-symlink-directory
+	test_grep unknown-symlink-directory actual.info-url-unknown-symlink-directory
 	'
 
 test_done
diff --git a/t/t9122-git-svn-author.sh b/t/t9122-git-svn-author.sh
index 0fc289ae0f..21401ad2b1 100755
--- a/t/t9122-git-svn-author.sh
+++ b/t/t9122-git-svn-author.sh
@@ -57,15 +57,15 @@ test_expect_success 'interact with it via git svn' '
 	test "z$myself" = "z$unaffected" &&
 
 	# Make sure lack of --add-author-from did not add cruft
-	! grep "^    From: A U Thor " actual.2 &&
+	test_grep ! "^    From: A U Thor " actual.2 &&
 
 	# Make sure --add-author-from added cruft
-	grep "^    From: A U Thor " actual.3 &&
-	grep "^    From: A U Thor " actual.4 &&
+	test_grep "^    From: A U Thor " actual.3 &&
+	test_grep "^    From: A U Thor " actual.4 &&
 
 	# Make sure --add-author-from with --use-log-author affected
 	# the authorship information
-	grep "^Author: A U Thor " actual.4 &&
+	test_grep "^Author: A U Thor " actual.4 &&
 
 	# Make sure there are no commit messages with excess blank lines
 	test $(grep "^ " actual.2 | wc -l) = 3 &&
diff --git a/t/t9130-git-svn-authors-file.sh b/t/t9130-git-svn-authors-file.sh
index 90325db909..67a4d889fd 100755
--- a/t/t9130-git-svn-authors-file.sh
+++ b/t/t9130-git-svn-authors-file.sh
@@ -29,9 +29,9 @@ test_expect_success 'imported 2 revisions successfully' '
 		git rev-list refs/remotes/git-svn >actual &&
 		test_line_count = 2 actual &&
 		git rev-list -1 --pretty=raw refs/remotes/git-svn >actual &&
-		grep "^author BBBBBBB BBBBBBB <bb@example\.com> " actual &&
+		test_grep "^author BBBBBBB BBBBBBB <bb@example\.com> " actual &&
 		git rev-list -1 --pretty=raw refs/remotes/git-svn~1 >actual &&
-		grep "^author AAAAAAA AAAAAAA <aa@example\.com> " actual
+		test_grep "^author AAAAAAA AAAAAAA <aa@example\.com> " actual
 	)
 	'
 
@@ -47,9 +47,9 @@ test_expect_success 'continues to import once authors have been added' '
 		git rev-list refs/remotes/git-svn >actual &&
 		test_line_count = 4 actual &&
 		git rev-list -1 --pretty=raw refs/remotes/git-svn >actual &&
-		grep "^author DDDDDDD DDDDDDD <dd@example\.com> " actual &&
+		test_grep "^author DDDDDDD DDDDDDD <dd@example\.com> " actual &&
 		git rev-list -1 --pretty=raw refs/remotes/git-svn~1 >actual &&
-		grep "^author CCCCCCC CCCCCCC <cc@example\.com> " actual
+		test_grep "^author CCCCCCC CCCCCCC <cc@example\.com> " actual
 	)
 	'
 
diff --git a/t/t9138-git-svn-authors-prog.sh b/t/t9138-git-svn-authors-prog.sh
index 5bb38cb23a..5fdf324111 100755
--- a/t/t9138-git-svn-authors-prog.sh
+++ b/t/t9138-git-svn-authors-prog.sh
@@ -48,15 +48,15 @@ test_expect_success 'authors-prog ran correctly' '
 	(
 		cd x &&
 		git rev-list -1 --pretty=raw refs/remotes/git-svn~1 >actual &&
-		grep "^author ee-foo <ee-foo@example\.com> " actual &&
+		test_grep "^author ee-foo <ee-foo@example\.com> " actual &&
 		git rev-list -1 --pretty=raw refs/remotes/git-svn~2 >actual &&
-		grep "^author dd <dd@sub\.example\.com> " actual &&
+		test_grep "^author dd <dd@sub\.example\.com> " actual &&
 		git rev-list -1 --pretty=raw refs/remotes/git-svn~3 >actual &&
-		grep "^author cc <cc@sub\.example\.com> " actual &&
+		test_grep "^author cc <cc@sub\.example\.com> " actual &&
 		git rev-list -1 --pretty=raw refs/remotes/git-svn~4 >actual &&
-		grep "^author bb <bb@example\.com> " actual &&
+		test_grep "^author bb <bb@example\.com> " actual &&
 		git rev-list -1 --pretty=raw refs/remotes/git-svn~5 >actual &&
-		grep "^author aa <aa@example\.com> " actual
+		test_grep "^author aa <aa@example\.com> " actual
 	)
 '
 
@@ -64,7 +64,7 @@ test_expect_success 'authors-file overrode authors-prog' '
 	(
 		cd x &&
 		git rev-list -1 --pretty=raw refs/remotes/git-svn >actual &&
-		grep "^author FFFFFFF FFFFFFF <fFf@other\.example\.com> " actual
+		test_grep "^author FFFFFFF FFFFFFF <fFf@other\.example\.com> " actual
 	)
 '
 
@@ -99,7 +99,7 @@ test_expect_success 'authors-prog handled special characters in username' '
 		cd x &&
 		git svn --authors-prog=../svn-authors-prog fetch &&
 		git rev-list -1 --pretty=raw refs/remotes/git-svn >actual &&
-		grep "^author xyz; touch evil <xyz; touch evil@example\.com> " actual &&
+		test_grep "^author xyz; touch evil <xyz; touch evil@example\.com> " actual &&
 		! test -f evil
 	)
 '
diff --git a/t/t9140-git-svn-reset.sh b/t/t9140-git-svn-reset.sh
index a420b2a87a..c70a3b36a4 100755
--- a/t/t9140-git-svn-reset.sh
+++ b/t/t9140-git-svn-reset.sh
@@ -43,7 +43,7 @@ test_expect_success 'fetch fails on modified hidden file' '
 	  git svn find-rev refs/remotes/git-svn > ../expect &&
 	  test_must_fail git svn fetch 2> ../errors &&
 	  git svn find-rev refs/remotes/git-svn > ../expect2 ) &&
-	grep "not found in commit" errors &&
+	test_grep "not found in commit" errors &&
 	test_cmp expect expect2
 '
 
@@ -59,7 +59,7 @@ test_expect_success 'refetch succeeds not ignoring any files' '
 	( cd g &&
 	  git svn fetch &&
 	  git svn rebase &&
-	  grep "mod hidden" hid/hid.txt
+	  test_grep "mod hidden" hid/hid.txt
 	)
 '
 
diff --git a/t/t9153-git-svn-rewrite-uuid.sh b/t/t9153-git-svn-rewrite-uuid.sh
index 8cb2b5c69c..2387c7d4f2 100755
--- a/t/t9153-git-svn-rewrite-uuid.sh
+++ b/t/t9153-git-svn-rewrite-uuid.sh
@@ -17,9 +17,9 @@ test_expect_success 'load svn repo' "
 
 test_expect_success 'verify uuid' "
 	git cat-file commit refs/remotes/git-svn~0 >actual &&
-	grep '^git-svn-id: .*@2 $uuid$' actual &&
+	test_grep '^git-svn-id: .*@2 $uuid$' actual &&
 	git cat-file commit refs/remotes/git-svn~1 >actual &&
-	grep '^git-svn-id: .*@1 $uuid$' actual
+	test_grep '^git-svn-id: .*@1 $uuid$' actual
 	"
 
 test_done
diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
index 581cf3d28f..8e0272df20 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -336,7 +336,7 @@ test_expect_success 'use the same checkout for Git and CVS' '
 	 echo Hello >> " space" &&
 	 git commit -m "Another change" " space" &&
 	 git cvsexportcommit -W -p -u -c HEAD &&
-	 grep Hello " space" &&
+	 test_grep Hello " space" &&
 	 git diff-files)
 
 '
diff --git a/t/t9210-scalar.sh b/t/t9210-scalar.sh
index f2a6df77ce..c8463d0ac4 100755
--- a/t/t9210-scalar.sh
+++ b/t/t9210-scalar.sh
@@ -21,13 +21,13 @@ test_expect_success 'scalar invoked on enlistment root' '
 		# Register
 		scalar register ${enlistment_root} &&
 		scalar list >out &&
-		grep "$(pwd)/${enlistment_root}/src\$" out &&
+		test_grep "$(pwd)/${enlistment_root}/src\$" out &&
 
 		# Delete (including enlistment root)
 		scalar delete $enlistment_root &&
 		test_path_is_missing $enlistment_root &&
 		scalar list >out &&
-		! grep "^$(pwd)/${enlistment_root}/src\$" out || return 1
+		test_grep ! "^$(pwd)/${enlistment_root}/src\$" out || return 1
 	done
 '
 
@@ -41,13 +41,13 @@ test_expect_success 'scalar invoked on enlistment src repo' '
 		# Register
 		scalar register ${enlistment_root}/src &&
 		scalar list >out &&
-		grep "$(pwd)/${enlistment_root}/src\$" out &&
+		test_grep "$(pwd)/${enlistment_root}/src\$" out &&
 
 		# Delete (will not include enlistment root)
 		scalar delete ${enlistment_root}/src &&
 		test_path_is_dir $enlistment_root &&
 		scalar list >out &&
-		! grep "^$(pwd)/${enlistment_root}/src\$" out || return 1
+		test_grep ! "^$(pwd)/${enlistment_root}/src\$" out || return 1
 	done
 '
 
@@ -61,13 +61,13 @@ test_expect_success 'scalar invoked when enlistment root and repo are the same'
 		# Register
 		scalar register ${enlistment_root} &&
 		scalar list >out &&
-		grep "$(pwd)/${enlistment_root}\$" out &&
+		test_grep "$(pwd)/${enlistment_root}\$" out &&
 
 		# Delete (will not include enlistment root)
 		scalar delete ${enlistment_root} &&
 		test_path_is_missing $enlistment_root &&
 		scalar list >out &&
-		! grep "^$(pwd)/${enlistment_root}\$" out &&
+		test_grep ! "^$(pwd)/${enlistment_root}\$" out &&
 
 		# Make sure we did not accidentally delete the trash dir
 		test_path_is_dir "$TRASH_DIRECTORY" || return 1
@@ -81,7 +81,7 @@ test_expect_success 'scalar repo search respects GIT_CEILING_DIRECTORIES' '
 	mkdir -p test/src/deep &&
 	GIT_CEILING_DIRECTORIES="$(pwd)/test/src" &&
 	! scalar register test/src/deep 2>err &&
-	grep "not a git repository" err
+	test_grep "not a git repository" err
 '
 
 test_expect_success 'scalar enlistments need a worktree' '
@@ -89,11 +89,11 @@ test_expect_success 'scalar enlistments need a worktree' '
 
 	git init --bare bare/src &&
 	! scalar register bare/src 2>err &&
-	grep "Scalar enlistments require a worktree" err &&
+	test_grep "Scalar enlistments require a worktree" err &&
 
 	git init test/src &&
 	! scalar register test/src/.git 2>err &&
-	grep "Scalar enlistments require a worktree" err
+	test_grep "Scalar enlistments require a worktree" err
 '
 
 test_expect_success FSMONITOR_DAEMON 'scalar register starts fsmon daemon' '
@@ -108,7 +108,7 @@ test_expect_success 'scalar register warns when background maintenance fails' '
 	git init register-repo &&
 	GIT_TEST_MAINT_SCHEDULER="crontab:false,launchctl:false,schtasks:false" \
 		scalar register register-repo 2>err &&
-	grep "could not toggle maintenance" err
+	test_grep "could not toggle maintenance" err
 '
 
 test_expect_success 'scalar unregister' '
@@ -117,13 +117,13 @@ test_expect_success 'scalar unregister' '
 	git config --get --global --fixed-value \
 		maintenance.repo "$(pwd)/vanish/src" &&
 	scalar list >scalar.repos &&
-	grep -F "$(pwd)/vanish/src" scalar.repos &&
+	test_grep -F "$(pwd)/vanish/src" scalar.repos &&
 	rm -rf vanish/src/.git &&
 	scalar unregister vanish &&
 	test_must_fail git config --get --global --fixed-value \
 		maintenance.repo "$(pwd)/vanish/src" &&
 	scalar list >scalar.repos &&
-	! grep -F "$(pwd)/vanish/src" scalar.repos &&
+	test_grep ! -F "$(pwd)/vanish/src" scalar.repos &&
 
 	# scalar unregister should be idempotent
 	scalar unregister vanish
@@ -278,7 +278,7 @@ test_expect_success '`reconfigure -a` removes stale config entries' '
 	git init stale/src &&
 	scalar register stale &&
 	scalar list >scalar.repos &&
-	grep stale scalar.repos &&
+	test_grep stale scalar.repos &&
 
 	grep -v stale scalar.repos >expect &&
 
@@ -307,7 +307,7 @@ test_expect_success 'scalar supports -c/-C' '
 
 test_expect_success '`scalar [...] <dir>` errors out when dir is missing' '
 	! scalar run config cloned 2>err &&
-	grep "cloned. does not exist" err
+	test_grep "cloned. does not exist" err
 '
 
 SQ="'"
@@ -318,7 +318,7 @@ test_expect_success UNZIP 'scalar diagnose' '
 	echo "$(pwd)/.git/objects/" >>cloned/src/.git/objects/info/alternates &&
 	test_commit -C cloned/src loose &&
 	scalar diagnose cloned >out 2>err &&
-	grep "Available space" out &&
+	test_grep "Available space" out &&
 	sed -n "s/.*$SQ\\(.*\\.zip\\)$SQ.*/\\1/p" <err >zip_path &&
 	zip_path=$(cat zip_path) &&
 	test -n "$zip_path" &&
@@ -328,9 +328,9 @@ test_expect_success UNZIP 'scalar diagnose' '
 	"$GIT_UNZIP" -p "$zip_path" diagnostics.log >out &&
 	test_file_not_empty out &&
 	"$GIT_UNZIP" -p "$zip_path" packs-local.txt >out &&
-	grep "$(pwd)/.git/objects" out &&
+	test_grep "$(pwd)/.git/objects" out &&
 	"$GIT_UNZIP" -p "$zip_path" objects-local.txt >out &&
-	grep "^Total: [1-9]" out
+	test_grep "^Total: [1-9]" out
 '
 
 test_done
diff --git a/t/t9211-scalar-clone.sh b/t/t9211-scalar-clone.sh
index 2043f48a1a..002d6ecdc1 100755
--- a/t/t9211-scalar-clone.sh
+++ b/t/t9211-scalar-clone.sh
@@ -86,7 +86,7 @@ test_expect_success 'fall back on full clone if partial unsupported' '
 	test_config -C to-clone uploadpack.allowanysha1inwant false &&
 
 	scalar clone "file://$(pwd)/to-clone" $enlistment 2>err &&
-	grep "filtering not recognized by server, ignoring" err &&
+	test_grep "filtering not recognized by server, ignoring" err &&
 
 	(
 		cd $enlistment/src &&
@@ -133,7 +133,7 @@ test_expect_success '--single-branch clones HEAD only' '
 		cd $enlistment/src &&
 		git for-each-ref refs/remotes/origin >out &&
 		test_line_count = 2 out &&
-		grep "refs/remotes/origin/base" out
+		test_grep "refs/remotes/origin/base" out
 	) &&
 
 	cleanup_clone $enlistment
@@ -147,8 +147,8 @@ test_expect_success '--no-single-branch clones all branches' '
 		cd $enlistment/src &&
 		git for-each-ref refs/remotes/origin >out &&
 		test_line_count = 3 out &&
-		grep "refs/remotes/origin/base" out &&
-		grep "refs/remotes/origin/parallel" out
+		test_grep "refs/remotes/origin/base" out &&
+		test_grep "refs/remotes/origin/parallel" out
 	) &&
 
 	cleanup_clone $enlistment
@@ -174,15 +174,15 @@ test_expect_success 'progress without tty' '
 	test_config -C to-clone uploadpack.allowanysha1inwant true &&
 
 	GIT_PROGRESS_DELAY=0 scalar clone "file://$(pwd)/to-clone" "$enlistment" 2>stderr &&
-	! grep "Enumerating objects" stderr &&
-	! grep "Updating files" stderr &&
+	test_grep ! "Enumerating objects" stderr &&
+	test_grep ! "Updating files" stderr &&
 	cleanup_clone $enlistment
 '
 
 test_expect_success 'scalar clone warns when background maintenance fails' '
 	GIT_TEST_MAINT_SCHEDULER="crontab:false,launchctl:false,schtasks:false" \
 		scalar clone "file://$(pwd)/to-clone" maint-fail 2>err &&
-	grep "could not toggle maintenance" err
+	test_grep "could not toggle maintenance" err
 '
 
 test_expect_success 'scalar clone --no-maintenance' '
@@ -190,7 +190,7 @@ test_expect_success 'scalar clone --no-maintenance' '
 	GIT_TRACE2_EVENT="$(pwd)/no-maint.event" \
 	GIT_TRACE2_EVENT_DEPTH=100 \
 		scalar clone --no-maintenance "file://$(pwd)/to-clone" no-maint 2>err &&
-	! grep "could not toggle maintenance" err &&
+	test_grep ! "could not toggle maintenance" err &&
 	test_subcommand ! git maintenance unregister --force <no-maint.event
 '
 
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 479437760b..fe6c2617ac 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -436,7 +436,7 @@ test_expect_success 'B: accept invalid timezone with raw-permissive' '
 	git init invalid-timezone &&
 	git -C invalid-timezone fast-import --date-format=raw-permissive <input &&
 	git -C invalid-timezone cat-file -p invalid-timezone >out &&
-	grep "1234567890 [+]051800" out
+	test_grep "1234567890 [+]051800" out
 '
 
 test_expect_success 'B: accept and fixup committer with no name' '
@@ -2326,7 +2326,7 @@ test_expect_success 'R: export-marks feature results in a marks file being creat
 	EOF
 
 	git fast-import --allow-unsafe-features <input &&
-	grep :1 git.marks
+	test_grep :1 git.marks
 '
 
 test_expect_success 'R: export-marks options can be overridden by commandline options' '
@@ -2340,7 +2340,7 @@ test_expect_success 'R: export-marks options can be overridden by commandline op
 	EOF
 	git fast-import --allow-unsafe-features \
 			--export-marks=cmdline-sub/other.marks <input &&
-	grep :1 cmdline-sub/other.marks &&
+	test_grep :1 cmdline-sub/other.marks &&
 	test_path_is_missing feature-sub
 '
 
@@ -3816,9 +3816,9 @@ test_expect_success 'X: replace ref that becomes useless is removed' '
 		sed -e s/othername/somename/ tmp >tmp2 &&
 		git fast-import --force <tmp2 2>msgs &&
 
-		grep "dropping.*since it would point to itself" msgs &&
+		test_grep "dropping.*since it would point to itself" msgs &&
 		git show-ref >refs &&
-		! grep refs/replace refs
+		test_grep ! refs/replace refs
 	)
 '
 
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 784d68b6e5..a487476ad4 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -139,9 +139,9 @@ test_expect_success ICONV 'reencoding iso-8859-7' '
 	test $(($(test_oid hexsz) + 181)) -eq "$(git -C new cat-file -s i18n)" &&
 	# ...and for the expected translation of bytes.
 	git -C new cat-file commit i18n >actual &&
-	grep $(printf "\317\200") actual &&
+	test_grep $(printf "\317\200") actual &&
 	# Also make sure the commit does not have the "encoding" header
-	! grep ^encoding actual
+	test_grep ! ^encoding actual
 '
 
 test_expect_success 'aborting on iso-8859-7' '
@@ -170,9 +170,9 @@ test_expect_success 'preserving iso-8859-7' '
 	test $(($(test_oid hexsz) + 200)) -eq "$(git -C new cat-file -s i18n-no-recoding)" &&
 	# ...as well as the expected byte.
 	git -C new cat-file commit i18n-no-recoding >actual &&
-	grep $(printf "\360") actual &&
+	test_grep $(printf "\360") actual &&
 	# Also make sure the commit has the "encoding" header
-	grep ^encoding actual
+	test_grep ^encoding actual
 '
 
 test_expect_success 'encoding preserved if reencoding fails' '
@@ -186,13 +186,13 @@ test_expect_success 'encoding preserved if reencoding fails' '
 	git -C new cat-file commit i18n-invalid >actual &&
 
 	# Make sure the commit still has the encoding header
-	grep ^encoding actual &&
+	test_grep ^encoding actual &&
 	# Verify that the commit has the expected size; i.e.
 	# that no bytes were re-encoded to a different encoding.
 	test $(($(test_oid hexsz) + 212)) -eq "$(git -C new cat-file -s i18n-invalid)" &&
 	# ...and check for the original special bytes
-	grep $(printf "\360") actual &&
-	grep $(printf "\377") actual
+	test_grep $(printf "\360") actual &&
+	test_grep $(printf "\377") actual
 '
 
 test_expect_success 'import/export-marks' '
@@ -244,14 +244,14 @@ test_expect_success 'signed-tags=abort' '
 test_expect_success 'signed-tags=verbatim' '
 
 	git fast-export --signed-tags=verbatim sign-your-name > output &&
-	grep PGP output
+	test_grep PGP output
 
 '
 
 test_expect_success 'signed-tags=warn-verbatim' '
 
 	git fast-export --signed-tags=warn-verbatim sign-your-name >output 2>err &&
-	grep PGP output &&
+	test_grep PGP output &&
 	test -s err
 
 '
@@ -261,7 +261,7 @@ test_expect_success 'signed-tags=warn-verbatim' '
 test_expect_success 'signed-tags=warn' '
 
 	git fast-export --signed-tags=warn sign-your-name >output 2>err &&
-	grep PGP output &&
+	test_grep PGP output &&
 	test -s err
 
 '
@@ -269,13 +269,13 @@ test_expect_success 'signed-tags=warn' '
 test_expect_success 'signed-tags=strip' '
 
 	git fast-export --signed-tags=strip sign-your-name > output &&
-	! grep PGP output
+	test_grep ! PGP output
 
 '
 
 test_expect_success 'signed-tags=warn-strip' '
 	git fast-export --signed-tags=warn-strip sign-your-name >output 2>err &&
-	! grep PGP output &&
+	test_grep ! PGP output &&
 	test -s err
 '
 
@@ -345,7 +345,7 @@ test_expect_success GPG 'signed-commits=verbatim' '
 
 	git fast-export --signed-commits=verbatim --reencode=no commit-signing >output &&
 	test_grep -E "^gpgsig $GIT_DEFAULT_HASH openpgp" output &&
-	grep "encoding ISO-8859-1" output &&
+	test_grep "encoding ISO-8859-1" output &&
 	git -C new fast-import <output &&
 	STRIPPED=$(git -C new rev-parse --verify refs/heads/commit-signing) &&
 	test $COMMIT_SIGNING = $STRIPPED
@@ -356,7 +356,7 @@ test_expect_success GPG 'signed-commits=warn-verbatim' '
 
 	git fast-export --signed-commits=warn-verbatim --reencode=no commit-signing >output 2>err &&
 	test_grep -E "^gpgsig $GIT_DEFAULT_HASH openpgp" output &&
-	grep "encoding ISO-8859-1" output &&
+	test_grep "encoding ISO-8859-1" output &&
 	test -s err &&
 	git -C new fast-import <output &&
 	STRIPPED=$(git -C new rev-parse --verify refs/heads/commit-signing) &&
@@ -367,8 +367,8 @@ test_expect_success GPG 'signed-commits=warn-verbatim' '
 test_expect_success GPG 'signed-commits=strip' '
 
 	git fast-export --signed-commits=strip --reencode=no commit-signing >output &&
-	! grep ^gpgsig output &&
-	grep "^encoding ISO-8859-1" output &&
+	test_grep ! ^gpgsig output &&
+	test_grep "^encoding ISO-8859-1" output &&
 	sed "s/commit-signing/commit-strip-signing/" output | git -C new fast-import &&
 	STRIPPED=$(git -C new rev-parse --verify refs/heads/commit-strip-signing) &&
 	test $COMMIT_SIGNING != $STRIPPED
@@ -378,8 +378,8 @@ test_expect_success GPG 'signed-commits=strip' '
 test_expect_success GPG 'signed-commits=warn-strip' '
 
 	git fast-export --signed-commits=warn-strip --reencode=no commit-signing >output 2>err &&
-	! grep ^gpgsig output &&
-	grep "^encoding ISO-8859-1" output &&
+	test_grep ! ^gpgsig output &&
+	test_grep "^encoding ISO-8859-1" output &&
 	test -s err &&
 	sed "s/commit-signing/commit-strip-signing/" output | git -C new fast-import &&
 	STRIPPED=$(git -C new rev-parse --verify refs/heads/commit-strip-signing) &&
@@ -406,7 +406,7 @@ test_expect_success GPGSM 'round-trip X.509 signed commit' '
 	test_grep -E "^gpgsig $GIT_DEFAULT_HASH x509" output &&
 	git -C new fast-import <output &&
 	git -C new cat-file commit refs/heads/x509-signing >actual &&
-	grep "^gpgsig" actual &&
+	test_grep "^gpgsig" actual &&
 	IMPORTED=$(git -C new rev-parse refs/heads/x509-signing) &&
 	test $X509_COMMIT = $IMPORTED
 
@@ -431,7 +431,7 @@ test_expect_success GPGSSH 'round-trip SSH signed commit' '
 	test_grep -E "^gpgsig $GIT_DEFAULT_HASH ssh" output &&
 	git -C new fast-import <output &&
 	git -C new cat-file commit refs/heads/ssh-signing >actual &&
-	grep "^gpgsig" actual &&
+	test_grep "^gpgsig" actual &&
 	IMPORTED=$(git -C new rev-parse refs/heads/ssh-signing) &&
 	test $SSH_COMMIT = $IMPORTED
 
@@ -520,7 +520,7 @@ test_expect_success 'fast-export -C -C | fast-import' '
 	mkdir new &&
 	git --git-dir=new/.git init &&
 	git fast-export -C -C --signed-tags=strip --all > output &&
-	grep "^C file2 file4\$" output &&
+	test_grep "^C file2 file4\$" output &&
 	git -C new fast-import <output &&
 	test $ENTRY = $(git -C new rev-parse --verify refs/heads/copy)
 
@@ -548,11 +548,11 @@ test_expect_success 'cope with tagger-less tags' '
 	ANNOTATED_TAG_COUNT=$((ANNOTATED_TAG_COUNT + 1)) &&
 	git fast-export -C -C --signed-tags=strip --all > output &&
 	test $(grep -c "^tag " output) = $ANNOTATED_TAG_COUNT &&
-	! grep "Unspecified Tagger" output &&
+	test_grep ! "Unspecified Tagger" output &&
 	git fast-export -C -C --signed-tags=strip --all \
 		--fake-missing-tagger > output &&
 	test $(grep -c "^tag " output) = $ANNOTATED_TAG_COUNT &&
-	grep "Unspecified Tagger" output
+	test_grep "Unspecified Tagger" output
 
 '
 
@@ -628,7 +628,7 @@ test_expect_success 'rewrite tag predating pathspecs to nothing' '
 		test_commit bar &&
 
 		git fast-export --tag-of-filtered-object=rewrite --all -- bar.t >output &&
-		grep from.$ZERO_OID output
+		test_grep from.$ZERO_OID output
 	)
 '
 
@@ -670,7 +670,7 @@ test_expect_success 'path limiting with import-marks does not lose unmodified fi
 	test_tick &&
 	git commit -mnext file &&
 	git fast-export --import-marks=marks simple -- file file0 >actual &&
-	grep file0 actual
+	test_grep file0 actual
 '
 
 test_expect_success 'path limiting works' '
@@ -753,7 +753,7 @@ test_expect_success 'handling tags of blobs' '
 test_expect_success 'handling nested tags' '
 	git tag -a -m "This is a nested tag" nested muss &&
 	git fast-export --mark-tags nested >output &&
-	grep "^from $ZERO_OID$" output &&
+	test_grep "^from $ZERO_OID$" output &&
 	grep "^tag nested$" output >tag_lines &&
 	test_line_count = 2 tag_lines
 '
@@ -926,7 +926,7 @@ test_expect_success 'merge commit gets exported with --import-marks' '
 
 		echo ":1 $(git rev-parse HEAD^^)" >marks &&
 		git fast-export --import-marks=marks main >out &&
-		grep Yeah out
+		test_grep Yeah out
 	)
 '
 
diff --git a/t/t9351-fast-export-anonymize.sh b/t/t9351-fast-export-anonymize.sh
index 156a647484..ed784a56b0 100755
--- a/t/t9351-fast-export-anonymize.sh
+++ b/t/t9351-fast-export-anonymize.sh
@@ -33,44 +33,44 @@ test_expect_success 'export anonymized stream' '
 
 # this also covers commit messages
 test_expect_success 'stream omits path names' '
-	! grep base stream &&
-	! grep foo stream &&
-	! grep subdir stream &&
-	! grep bar stream &&
-	! grep xyzzy stream
+	test_grep ! base stream &&
+	test_grep ! foo stream &&
+	test_grep ! subdir stream &&
+	test_grep ! bar stream &&
+	test_grep ! xyzzy stream
 '
 
 test_expect_success 'stream contains user-specified names' '
-	grep retain-me stream &&
-	! grep should-not-appear stream &&
-	grep custom-name stream
+	test_grep retain-me stream &&
+	test_grep ! should-not-appear stream &&
+	test_grep custom-name stream
 '
 
 test_expect_success 'stream omits gitlink oids' '
 	# avoid relying on the whole oid to remain hash-agnostic; this is
 	# plenty to be unique within our test case
-	! grep a000000000000000000 stream
+	test_grep ! a000000000000000000 stream
 '
 
 test_expect_success 'stream retains other as refname' '
-	grep other stream
+	test_grep other stream
 '
 
 test_expect_success 'stream omits other refnames' '
-	! grep main stream &&
-	! grep mytag stream &&
-	! grep longtag stream
+	test_grep ! main stream &&
+	test_grep ! mytag stream &&
+	test_grep ! longtag stream
 '
 
 test_expect_success 'stream omits identities' '
-	! grep "$GIT_COMMITTER_NAME" stream &&
-	! grep "$GIT_COMMITTER_EMAIL" stream &&
-	! grep "$GIT_AUTHOR_NAME" stream &&
-	! grep "$GIT_AUTHOR_EMAIL" stream
+	test_grep ! "$GIT_COMMITTER_NAME" stream &&
+	test_grep ! "$GIT_COMMITTER_EMAIL" stream &&
+	test_grep ! "$GIT_AUTHOR_NAME" stream &&
+	test_grep ! "$GIT_AUTHOR_EMAIL" stream
 '
 
 test_expect_success 'stream omits tag message' '
-	! grep "annotated tag" stream
+	test_grep ! "annotated tag" stream
 '
 
 # NOTE: we chdir to the new, anonymized repository
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 4b45398bab..b2379e4671 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -254,7 +254,7 @@ test_expect_success 'gitcvs.enabled = false' \
    else
      true
    fi &&
-   grep "GITCVS emulation disabled" cvs.log &&
+   test_grep "GITCVS emulation disabled" cvs.log &&
    test ! -d cvswork2'
 
 rm -fr cvswork2
@@ -276,7 +276,7 @@ test_expect_success 'gitcvs.ext.enabled = false' '
 	else
 		true
 	fi &&
-	grep "GITCVS emulation disabled" cvs.log &&
+	test_grep "GITCVS emulation disabled" cvs.log &&
 	test ! -d cvswork2
 '
 
diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501-gitweb-standalone-http-status.sh
index 32814e75df..1093fda6cb 100755
--- a/t/t9501-gitweb-standalone-http-status.sh
+++ b/t/t9501-gitweb-standalone-http-status.sh
@@ -37,13 +37,13 @@ EOF
 test_expect_success \
     'snapshots: tgz only default format enabled' \
     'gitweb_run "p=.git;a=snapshot;h=HEAD;sf=tgz" &&
-    grep "Status: 200 OK" gitweb.output &&
+    test_grep "Status: 200 OK" gitweb.output &&
     gitweb_run "p=.git;a=snapshot;h=HEAD;sf=tbz2" &&
-    grep "403 - Unsupported snapshot format" gitweb.output &&
+    test_grep "403 - Unsupported snapshot format" gitweb.output &&
     gitweb_run "p=.git;a=snapshot;h=HEAD;sf=txz" &&
-    grep "403 - Snapshot format not allowed" gitweb.output &&
+    test_grep "403 - Snapshot format not allowed" gitweb.output &&
     gitweb_run "p=.git;a=snapshot;h=HEAD;sf=zip" &&
-    grep "403 - Unsupported snapshot format" gitweb.output'
+    test_grep "403 - Unsupported snapshot format" gitweb.output'
 
 
 cat >>gitweb_config.perl <<\EOF
@@ -53,13 +53,13 @@ EOF
 test_expect_success \
     'snapshots: all enabled in default, use default disabled value' \
     'gitweb_run "p=.git;a=snapshot;h=HEAD;sf=tgz" &&
-    grep "Status: 200 OK" gitweb.output &&
+    test_grep "Status: 200 OK" gitweb.output &&
     gitweb_run "p=.git;a=snapshot;h=HEAD;sf=tbz2" &&
-    grep "Status: 200 OK" gitweb.output &&
+    test_grep "Status: 200 OK" gitweb.output &&
     gitweb_run "p=.git;a=snapshot;h=HEAD;sf=txz" &&
-    grep "403 - Snapshot format not allowed" gitweb.output &&
+    test_grep "403 - Snapshot format not allowed" gitweb.output &&
     gitweb_run "p=.git;a=snapshot;h=HEAD;sf=zip" &&
-    grep "Status: 200 OK" gitweb.output'
+    test_grep "Status: 200 OK" gitweb.output'
 
 
 cat >>gitweb_config.perl <<\EOF
@@ -69,7 +69,7 @@ EOF
 test_expect_success \
     'snapshots: zip explicitly disabled' \
     'gitweb_run "p=.git;a=snapshot;h=HEAD;sf=zip" &&
-    grep "403 - Snapshot format not allowed" gitweb.output'
+    test_grep "403 - Snapshot format not allowed" gitweb.output'
 test_debug 'cat gitweb.output'
 
 
@@ -80,7 +80,7 @@ EOF
 test_expect_success \
     'snapshots: tgz explicitly enabled' \
     'gitweb_run "p=.git;a=snapshot;h=HEAD;sf=tgz" &&
-    grep "Status: 200 OK" gitweb.output'
+    test_grep "Status: 200 OK" gitweb.output'
 test_debug 'cat gitweb.headers'
 
 
@@ -89,13 +89,13 @@ test_debug 'cat gitweb.headers'
 
 test_expect_success 'snapshots: good tree-ish id' '
 	gitweb_run "p=.git;a=snapshot;h=main;sf=tgz" &&
-	grep "Status: 200 OK" gitweb.output
+	test_grep "Status: 200 OK" gitweb.output
 '
 test_debug 'cat gitweb.headers'
 
 test_expect_success 'snapshots: bad tree-ish id' '
 	gitweb_run "p=.git;a=snapshot;h=frizzumFrazzum;sf=tgz" &&
-	grep "404 - Object does not exist" gitweb.output
+	test_grep "404 - Object does not exist" gitweb.output
 '
 test_debug 'cat gitweb.output'
 
@@ -105,20 +105,20 @@ test_expect_success 'snapshots: bad tree-ish id (tagged object)' '
 	test_tick && git commit -m "Object to be tagged" &&
 	git tag tagged-object $(git hash-object tag-object) &&
 	gitweb_run "p=.git;a=snapshot;h=tagged-object;sf=tgz" &&
-	grep "400 - Object is not a tree-ish" gitweb.output
+	test_grep "400 - Object is not a tree-ish" gitweb.output
 '
 test_debug 'cat gitweb.output'
 
 test_expect_success 'snapshots: good object id' '
 	ID=$(git rev-parse --verify HEAD) &&
 	gitweb_run "p=.git;a=snapshot;h=$ID;sf=tgz" &&
-	grep "Status: 200 OK" gitweb.output
+	test_grep "Status: 200 OK" gitweb.output
 '
 test_debug 'cat gitweb.headers'
 
 test_expect_success 'snapshots: bad object id' '
 	gitweb_run "p=.git;a=snapshot;h=abcdef01234;sf=tgz" &&
-	grep "404 - Object does not exist" gitweb.output
+	test_grep "404 - Object does not exist" gitweb.output
 '
 test_debug 'cat gitweb.output'
 
@@ -127,8 +127,8 @@ test_debug 'cat gitweb.output'
 
 test_expect_success DATE_PARSER 'modification: feed last-modified' '
 	gitweb_run "p=.git;a=atom;h=main" &&
-	grep "Status: 200 OK" gitweb.headers &&
-	grep "Last-modified: Thu, 7 Apr 2005 22:14:13 +0000" gitweb.headers
+	test_grep "Status: 200 OK" gitweb.headers &&
+	test_grep "Last-modified: Thu, 7 Apr 2005 22:14:13 +0000" gitweb.headers
 '
 test_debug 'cat gitweb.headers'
 
@@ -137,7 +137,7 @@ test_expect_success DATE_PARSER 'modification: feed if-modified-since (modified)
 	export HTTP_IF_MODIFIED_SINCE &&
 	test_when_finished "unset HTTP_IF_MODIFIED_SINCE" &&
 	gitweb_run "p=.git;a=atom;h=main" &&
-	grep "Status: 200 OK" gitweb.headers
+	test_grep "Status: 200 OK" gitweb.headers
 '
 test_debug 'cat gitweb.headers'
 
@@ -146,14 +146,14 @@ test_expect_success DATE_PARSER 'modification: feed if-modified-since (unmodifie
 	export HTTP_IF_MODIFIED_SINCE &&
 	test_when_finished "unset HTTP_IF_MODIFIED_SINCE" &&
 	gitweb_run "p=.git;a=atom;h=main" &&
-	grep "Status: 304 Not Modified" gitweb.headers
+	test_grep "Status: 304 Not Modified" gitweb.headers
 '
 test_debug 'cat gitweb.headers'
 
 test_expect_success DATE_PARSER 'modification: snapshot last-modified' '
 	gitweb_run "p=.git;a=snapshot;h=main;sf=tgz" &&
-	grep "Status: 200 OK" gitweb.headers &&
-	grep "Last-modified: Thu, 7 Apr 2005 22:14:13 +0000" gitweb.headers
+	test_grep "Status: 200 OK" gitweb.headers &&
+	test_grep "Last-modified: Thu, 7 Apr 2005 22:14:13 +0000" gitweb.headers
 '
 test_debug 'cat gitweb.headers'
 
@@ -162,7 +162,7 @@ test_expect_success DATE_PARSER 'modification: snapshot if-modified-since (modif
 	export HTTP_IF_MODIFIED_SINCE &&
 	test_when_finished "unset HTTP_IF_MODIFIED_SINCE" &&
 	gitweb_run "p=.git;a=snapshot;h=main;sf=tgz" &&
-	grep "Status: 200 OK" gitweb.headers
+	test_grep "Status: 200 OK" gitweb.headers
 '
 test_debug 'cat gitweb.headers'
 
@@ -171,7 +171,7 @@ test_expect_success DATE_PARSER 'modification: snapshot if-modified-since (unmod
 	export HTTP_IF_MODIFIED_SINCE &&
 	test_when_finished "unset HTTP_IF_MODIFIED_SINCE" &&
 	gitweb_run "p=.git;a=snapshot;h=main;sf=tgz" &&
-	grep "Status: 304 Not Modified" gitweb.headers
+	test_grep "Status: 304 Not Modified" gitweb.headers
 '
 test_debug 'cat gitweb.headers'
 
@@ -181,8 +181,8 @@ test_expect_success DATE_PARSER 'modification: tree snapshot' '
 	export HTTP_IF_MODIFIED_SINCE &&
 	test_when_finished "unset HTTP_IF_MODIFIED_SINCE" &&
 	gitweb_run "p=.git;a=snapshot;h=$ID;sf=tgz" &&
-	grep "Status: 200 OK" gitweb.headers &&
-	! grep -i "last-modified" gitweb.headers
+	test_grep "Status: 200 OK" gitweb.headers &&
+	test_grep ! -i "last-modified" gitweb.headers
 '
 test_debug 'cat gitweb.headers'
 
@@ -196,8 +196,8 @@ EOF
 
 test_expect_success 'load checking: load too high (default action)' '
 	gitweb_run "p=.git" &&
-	grep "Status: 503 Service Unavailable" gitweb.headers &&
-	grep "503 - The load average on the server is too high" gitweb.body
+	test_grep "Status: 503 Service Unavailable" gitweb.headers &&
+	test_grep "503 - The load average on the server is too high" gitweb.body
 '
 test_debug 'cat gitweb.headers'
 
@@ -212,8 +212,8 @@ EOF
 
 test_expect_success 'invalid arguments: invalid regexp (in project search)' '
 	gitweb_run "a=project_list;s=*\.git;sr=1" &&
-	grep "Status: 400" gitweb.headers &&
-	grep "400 - Invalid.*regexp" gitweb.body
+	test_grep "Status: 400" gitweb.headers &&
+	test_grep "400 - Invalid.*regexp" gitweb.body
 '
 test_debug 'cat gitweb.headers'
 
diff --git a/t/t9502-gitweb-standalone-parse-output.sh b/t/t9502-gitweb-standalone-parse-output.sh
index 81d5625557..9587ce212a 100755
--- a/t/t9502-gitweb-standalone-parse-output.sh
+++ b/t/t9502-gitweb-standalone-parse-output.sh
@@ -111,7 +111,7 @@ test_debug 'cat gitweb.headers && cat file_list'
 
 test_expect_success 'snapshot: hierarchical branch name (xx/test)' '
 	gitweb_run "p=.git;a=snapshot;h=xx/test;sf=tar" &&
-	! grep "filename=.*/" gitweb.headers
+	test_grep ! "filename=.*/" gitweb.headers
 '
 test_debug 'cat gitweb.headers'
 
@@ -139,13 +139,13 @@ test_expect_success 'forks: setup' '
 
 test_expect_success 'forks: not skipped unless "forks" feature enabled' '
 	gitweb_run "a=project_list" &&
-	grep -q ">\\.git<"               gitweb.body &&
-	grep -q ">foo\\.git<"            gitweb.body &&
-	grep -q ">foo_baz\\.git<"        gitweb.body &&
-	grep -q ">foo\\.bar\\.git<"      gitweb.body &&
-	grep -q ">foo_baz\\.git<"        gitweb.body &&
-	grep -q ">foo/foo-forked\\.git<" gitweb.body &&
-	grep -q ">fork of .*<"           gitweb.body
+	test_grep -q ">\\.git<"               gitweb.body &&
+	test_grep -q ">foo\\.git<"            gitweb.body &&
+	test_grep -q ">foo_baz\\.git<"        gitweb.body &&
+	test_grep -q ">foo\\.bar\\.git<"      gitweb.body &&
+	test_grep -q ">foo_baz\\.git<"        gitweb.body &&
+	test_grep -q ">foo/foo-forked\\.git<" gitweb.body &&
+	test_grep -q ">fork of .*<"           gitweb.body
 '
 
 test_expect_success 'enable forks feature' '
@@ -156,25 +156,25 @@ test_expect_success 'enable forks feature' '
 
 test_expect_success 'forks: forks skipped if "forks" feature enabled' '
 	gitweb_run "a=project_list" &&
-	grep -q ">\\.git<"               gitweb.body &&
-	grep -q ">foo\\.git<"            gitweb.body &&
-	grep -q ">foo_baz\\.git<"        gitweb.body &&
-	grep -q ">foo\\.bar\\.git<"      gitweb.body &&
-	grep -q ">foo_baz\\.git<"        gitweb.body &&
-	grep -v ">foo/foo-forked\\.git<" gitweb.body &&
-	grep -v ">fork of .*<"           gitweb.body
+	test_grep -q ">\\.git<"               gitweb.body &&
+	test_grep -q ">foo\\.git<"            gitweb.body &&
+	test_grep -q ">foo_baz\\.git<"        gitweb.body &&
+	test_grep -q ">foo\\.bar\\.git<"      gitweb.body &&
+	test_grep -q ">foo_baz\\.git<"        gitweb.body &&
+	test_grep -v ">foo/foo-forked\\.git<" gitweb.body &&
+	test_grep -v ">fork of .*<"           gitweb.body
 '
 
 test_expect_success 'forks: "forks" action for forked repository' '
 	gitweb_run "p=foo.git;a=forks" &&
-	grep -q ">foo/foo-forked\\.git<" gitweb.body &&
-	grep -q ">fork of foo<"          gitweb.body
+	test_grep -q ">foo/foo-forked\\.git<" gitweb.body &&
+	test_grep -q ">fork of foo<"          gitweb.body
 '
 
 test_expect_success 'forks: can access forked repository' '
 	gitweb_run "p=foo/foo-forked.git;a=summary" &&
-	grep -q "200 OK"        gitweb.headers &&
-	grep -q ">fork of foo<" gitweb.body
+	test_grep -q "200 OK"        gitweb.headers &&
+	test_grep -q ">fork of foo<" gitweb.body
 '
 
 test_expect_success 'forks: project_index lists all projects (incl. forks)' '
diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
index 0816763e46..140a3a7f24 100755
--- a/t/t9800-git-p4-basic.sh
+++ b/t/t9800-git-p4-basic.sh
@@ -35,7 +35,7 @@ test_expect_success 'basic git p4 clone' '
 
 test_expect_success 'depot typo error' '
 	test_must_fail git p4 clone --dest="$git" /depot 2>errs &&
-	grep "Depot paths must start with" errs
+	test_grep "Depot paths must start with" errs
 '
 
 test_expect_success 'git p4 clone @all' '
@@ -356,7 +356,7 @@ test_expect_success 'unresolvable host in P4PORT should display error' '
 		P4PORT=nosuchhost:65537 &&
 		export P4PORT &&
 		test_expect_code 1 git p4 sync >out 2>err &&
-		grep "connect to nosuchhost" err
+		test_grep "connect to nosuchhost" err
 	)
 '
 
@@ -374,7 +374,7 @@ test_expect_success 'run hook p4-pre-submit before submit' '
 		git commit -m "add hello.txt" &&
 		git config git-p4.skipSubmitEdit true &&
 		git p4 submit --dry-run >out &&
-		grep "Would apply" out
+		test_grep "Would apply" out
 	) &&
 	test_hook -C "$git" p4-pre-submit <<-\EOF &&
 	exit 0
@@ -382,7 +382,7 @@ test_expect_success 'run hook p4-pre-submit before submit' '
 	(
 		cd "$git" &&
 		git p4 submit --dry-run >out &&
-		grep "Would apply" out
+		test_grep "Would apply" out
 	) &&
 	test_hook -C "$git" --clobber p4-pre-submit <<-\EOF &&
 	exit 1
@@ -390,7 +390,7 @@ test_expect_success 'run hook p4-pre-submit before submit' '
 	(
 		cd "$git" &&
 		test_must_fail git p4 submit --dry-run >errs 2>&1 &&
-		! grep "Would apply" errs
+		test_grep ! "Would apply" errs
 	)
 '
 
diff --git a/t/t9801-git-p4-branch.sh b/t/t9801-git-p4-branch.sh
index c598011635..9912b48151 100755
--- a/t/t9801-git-p4-branch.sh
+++ b/t/t9801-git-p4-branch.sh
@@ -216,17 +216,17 @@ test_expect_success 'git p4 clone simple branches' '
 		test_path_is_file file1 &&
 		test_path_is_file file2 &&
 		test_path_is_file file3 &&
-		grep update file2 &&
+		test_grep update file2 &&
 		git reset --hard p4/depot/branch2 &&
 		test_path_is_file file1 &&
 		test_path_is_file file2 &&
 		test ! -f file3 &&
-		! grep update file2 &&
+		test_grep ! update file2 &&
 		git reset --hard p4/depot/branch3 &&
 		test_path_is_file file1 &&
 		test_path_is_file file2 &&
 		test_path_is_file file3 &&
-		grep update file2 &&
+		test_grep update file2 &&
 		cd "$cli" &&
 		cd branch1 &&
 		p4 edit file2 &&
@@ -235,7 +235,7 @@ test_expect_success 'git p4 clone simple branches' '
 		cd "$git" &&
 		git reset --hard p4/depot/branch1 &&
 		git p4 rebase &&
-		grep file2_ file2
+		test_grep file2_ file2
 	)
 '
 
@@ -292,29 +292,29 @@ test_expect_success 'git p4 clone complex branches' '
 		test_path_is_file file1 &&
 		test_path_is_file file2 &&
 		test_path_is_file file3 &&
-		grep update file2 &&
+		test_grep update file2 &&
 		git reset --hard p4/depot/branch2 &&
 		test_path_is_file file1 &&
 		test_path_is_file file2 &&
 		test_path_is_missing file3 &&
-		! grep update file2 &&
+		test_grep ! update file2 &&
 		git reset --hard p4/depot/branch3 &&
 		test_path_is_file file1 &&
 		test_path_is_file file2 &&
 		test_path_is_file file3 &&
-		grep update file2 &&
+		test_grep update file2 &&
 		git reset --hard p4/depot/branch4 &&
 		git diff-tree --quiet HEAD &&
 		test_path_is_file file1 &&
 		test_path_is_file file2 &&
 		test_path_is_missing file3 &&
-		! grep update file2 &&
+		test_grep ! update file2 &&
 		git reset --hard p4/depot/branch5 &&
 		git diff-tree --quiet HEAD &&
 		test_path_is_file file1 &&
 		test_path_is_file file2 &&
 		test_path_is_file file3 &&
-		! grep update file2 &&
+		test_grep ! update file2 &&
 		test_must_fail git show-ref --verify refs/git-p4-tmp
 	)
 '
@@ -346,27 +346,27 @@ test_expect_success 'git p4 sync changes to two branches in the same changelist'
 		test_path_is_file file1 &&
 		test_path_is_file file2 &&
 		test_path_is_file file3 &&
-		grep update file2 &&
+		test_grep update file2 &&
 		git reset --hard p4/depot/branch2 &&
 		test_path_is_file file1 &&
 		test_path_is_file file2 &&
 		test_path_is_missing file3 &&
-		! grep update file2 &&
+		test_grep ! update file2 &&
 		git reset --hard p4/depot/branch3 &&
 		test_path_is_file file1 &&
 		test_path_is_file file2 &&
 		test_path_is_missing file3 &&
-		grep update file2 &&
+		test_grep update file2 &&
 		git reset --hard p4/depot/branch4 &&
 		test_path_is_file file1 &&
 		test_path_is_file file2 &&
 		test_path_is_file file3 &&
-		! grep update file2 &&
+		test_grep ! update file2 &&
 		git reset --hard p4/depot/branch5 &&
 		test_path_is_file file1 &&
 		test_path_is_file file2 &&
 		test_path_is_file file3 &&
-		! grep update file2 &&
+		test_grep ! update file2 &&
 		test_must_fail git show-ref --verify refs/git-p4-tmp
 	)
 '
@@ -398,27 +398,27 @@ test_expect_failure 'git p4 clone file subset branch' '
 		test_path_is_file file1 &&
 		test_path_is_file file2 &&
 		test_path_is_file file3 &&
-		grep update file2 &&
+		test_grep update file2 &&
 		git reset --hard p4/depot/branch2 &&
 		test_path_is_file file1 &&
 		test_path_is_file file2 &&
 		test_path_is_missing file3 &&
-		! grep update file2 &&
+		test_grep ! update file2 &&
 		git reset --hard p4/depot/branch3 &&
 		test_path_is_file file1 &&
 		test_path_is_file file2 &&
 		test_path_is_missing file3 &&
-		grep update file2 &&
+		test_grep update file2 &&
 		git reset --hard p4/depot/branch4 &&
 		test_path_is_file file1 &&
 		test_path_is_file file2 &&
 		test_path_is_file file3 &&
-		! grep update file2 &&
+		test_grep ! update file2 &&
 		git reset --hard p4/depot/branch5 &&
 		test_path_is_file file1 &&
 		test_path_is_file file2 &&
 		test_path_is_file file3 &&
-		! grep update file2 &&
+		test_grep ! update file2 &&
 		git reset --hard p4/depot/branch6 &&
 		test_path_is_file file1 &&
 		test_path_is_missing file2 &&
@@ -622,19 +622,19 @@ test_expect_success 'git p4 clone simple branches with base folder on server sid
 		test_path_is_file file2 &&
 		test_path_is_file file3 &&
 		test_path_is_file sub_file1 &&
-		grep update file2 &&
+		test_grep update file2 &&
 		git reset --hard p4/depot/branch2 &&
 		test_path_is_file file1 &&
 		test_path_is_file file2 &&
 		test ! -f file3 &&
 		test_path_is_file sub_file1 &&
-		! grep update file2 &&
+		test_grep ! update file2 &&
 		git reset --hard p4/depot/branch3 &&
 		test_path_is_file file1 &&
 		test_path_is_file file2 &&
 		test_path_is_file file3 &&
 		test_path_is_file sub_file1 &&
-		grep update file2 &&
+		test_grep update file2 &&
 		cd "$cli" &&
 		cd branch1 &&
 		p4 edit file2 &&
@@ -643,7 +643,7 @@ test_expect_success 'git p4 clone simple branches with base folder on server sid
 		cd "$git" &&
 		git reset --hard p4/depot/branch1 &&
 		git p4 rebase &&
-		grep file2_ file2
+		test_grep file2_ file2
 	)
 '
 
@@ -661,7 +661,7 @@ test_expect_success 'Update a file in git side and submit to P4 using client vie
 		cd "$cli" &&
 		p4 sync ... &&
 		cd branch1 &&
-		grep "client spec" file1
+		test_grep "client spec" file1
 	)
 '
 
diff --git a/t/t9806-git-p4-options.sh b/t/t9806-git-p4-options.sh
index c26d297433..dce710ea56 100755
--- a/t/t9806-git-p4-options.sh
+++ b/t/t9806-git-p4-options.sh
@@ -49,7 +49,7 @@ test_expect_success 'sync when no master branch prints a nice error' '
 	(
 		cd "$git" &&
 		test_must_fail git p4 sync 2>err &&
-		grep "Error: no branch refs/remotes/p4/master" err
+		test_grep "Error: no branch refs/remotes/p4/master" err
 	)
 '
 
@@ -85,9 +85,9 @@ test_expect_success 'sync when two branches but no master should noop' '
 		git p4 sync --branch=refs/remotes/p4/b2 //depot@2 &&
 		git p4 sync &&
 		git show -s --format=%s refs/remotes/p4/b1 >show &&
-		grep "Initial import" show &&
+		test_grep "Initial import" show &&
 		git show -s --format=%s refs/remotes/p4/b2 >show &&
-		grep "Initial import" show
+		test_grep "Initial import" show
 	)
 '
 
@@ -100,9 +100,9 @@ test_expect_success 'sync --branch updates specific branch, no detection' '
 		git p4 sync --branch=b2 //depot@2 &&
 		git p4 sync --branch=b2 &&
 		git show -s --format=%s refs/remotes/p4/b1 >show &&
-		grep "Initial import" show &&
+		test_grep "Initial import" show &&
 		git show -s --format=%s refs/remotes/p4/b2 >show &&
-		grep "change 3" show
+		test_grep "change 3" show
 	)
 '
 
diff --git a/t/t9807-git-p4-submit.sh b/t/t9807-git-p4-submit.sh
index 6ae7ced51b..adbdf9323a 100755
--- a/t/t9807-git-p4-submit.sh
+++ b/t/t9807-git-p4-submit.sh
@@ -542,7 +542,7 @@ test_expect_success 'submit --update-shelve' '
 		cd "$cli" &&
 		change=$(last_shelve) &&
 		p4 unshelve -c $change -s $change &&
-		grep -q updated-line shelf.t &&
+		test_grep -q updated-line shelf.t &&
 		p4 describe -S $change | grep added-file.t &&
 		test_path_is_missing shelved-change-1.t &&
 		p4 revert ...
diff --git a/t/t9810-git-p4-rcs.sh b/t/t9810-git-p4-rcs.sh
index 5fe83315ec..70355a32a3 100755
--- a/t/t9810-git-p4-rcs.sh
+++ b/t/t9810-git-p4-rcs.sh
@@ -299,12 +299,12 @@ test_expect_success 'cope with rcs keyword file deletion' '
 		echo "\$Revision\$" >kwdelfile.c &&
 		p4 add -t ktext kwdelfile.c &&
 		p4 submit -d "Add file to be deleted" &&
-		grep 1 kwdelfile.c
+		test_grep 1 kwdelfile.c
 	) &&
 	git p4 clone --dest="$git" //depot &&
 	(
 		cd "$git" &&
-		grep Revision kwdelfile.c &&
+		test_grep Revision kwdelfile.c &&
 		git rm -f kwdelfile.c &&
 		git commit -m "Delete a file containing RCS keywords" &&
 		git config git-p4.skipSubmitEdit true &&
@@ -336,7 +336,7 @@ test_expect_success 'Add keywords in git which match the default p4 values' '
 		cd "$cli" &&
 		p4 sync &&
 		test -f kwfile1.c &&
-		grep "NewKW.*Revision.*[0-9]" kwfile1.c
+		test_grep "NewKW.*Revision.*[0-9]" kwfile1.c
 
 	)
 '
@@ -359,7 +359,7 @@ test_expect_failure 'Add keywords in git which do not match the default p4 value
 	(
 		cd "$cli" &&
 		p4 sync &&
-		grep "NewKW2.*Revision.*[0-9]" kwfile1.c
+		test_grep "NewKW2.*Revision.*[0-9]" kwfile1.c
 
 	)
 '
diff --git a/t/t9813-git-p4-preserve-users.sh b/t/t9813-git-p4-preserve-users.sh
index fd018c87a8..838ddd324c 100755
--- a/t/t9813-git-p4-preserve-users.sh
+++ b/t/t9813-git-p4-preserve-users.sh
@@ -119,20 +119,20 @@ test_expect_success 'not preserving user with mixed authorship' '
 		P4EDITOR=cat P4USER=alice P4PASSWD=secret &&
 		export P4EDITOR P4USER P4PASSWD &&
 		git p4 commit >actual &&
-		grep "git author derek@example.com does not match" actual &&
+		test_grep "git author derek@example.com does not match" actual &&
 
 		make_change_by_user usernamefile3 Charlie charlie@example.com &&
 		git p4 commit >actual &&
-		grep "git author charlie@example.com does not match" actual &&
+		test_grep "git author charlie@example.com does not match" actual &&
 
 		make_change_by_user usernamefile3 alice alice@example.com &&
 		git p4 commit >actual &&
-		! grep "git author.*does not match" actual &&
+		test_grep ! "git author.*does not match" actual &&
 
 		git config git-p4.skipUserNameCheck true &&
 		make_change_by_user usernamefile3 Charlie charlie@example.com &&
 		git p4 commit >actual &&
-		! grep "git author.*does not match" actual &&
+		test_grep ! "git author.*does not match" actual &&
 
 		p4_check_commit_author usernamefile3 alice
 	)
diff --git a/t/t9814-git-p4-rename.sh b/t/t9814-git-p4-rename.sh
index 2a9838f37f..6c5ecb9bea 100755
--- a/t/t9814-git-p4-rename.sh
+++ b/t/t9814-git-p4-rename.sh
@@ -66,7 +66,7 @@ test_expect_success 'detect renames' '
 		git diff-tree -r -M HEAD &&
 		git p4 submit &&
 		p4 filelog //depot/file4 >filelog &&
-		! grep " from //depot" filelog &&
+		test_grep ! " from //depot" filelog &&
 
 		git mv file4 file5 &&
 		git commit -a -m "Rename file4 to file5" &&
@@ -74,7 +74,7 @@ test_expect_success 'detect renames' '
 		git config git-p4.detectRenames true &&
 		git p4 submit &&
 		p4 filelog //depot/file5 >filelog &&
-		grep " from //depot/file4" filelog &&
+		test_grep " from //depot/file4" filelog &&
 
 		git mv file5 file6 &&
 		echo update >>file6 &&
@@ -86,7 +86,7 @@ test_expect_success 'detect renames' '
 		git config git-p4.detectRenames $(($level + 2)) &&
 		git p4 submit &&
 		p4 filelog //depot/file6 >filelog &&
-		! grep " from //depot" filelog &&
+		test_grep ! " from //depot" filelog &&
 
 		git mv file6 file7 &&
 		echo update >>file7 &&
@@ -98,7 +98,7 @@ test_expect_success 'detect renames' '
 		git config git-p4.detectRenames $(($level - 2)) &&
 		git p4 submit &&
 		p4 filelog //depot/file7 >filelog &&
-		grep " from //depot/file6" filelog
+		test_grep " from //depot/file6" filelog
 	)
 '
 
diff --git a/t/t9827-git-p4-change-filetype.sh b/t/t9827-git-p4-change-filetype.sh
index d3670bd7a2..9a8231a788 100755
--- a/t/t9827-git-p4-change-filetype.sh
+++ b/t/t9827-git-p4-change-filetype.sh
@@ -36,7 +36,7 @@ test_expect_success SYMLINKS 'change file to symbolic link' '
 		git commit -m "symlink file1 to file2" &&
 		git p4 submit &&
 		p4 filelog -m 1 //depot/file2 >filelog &&
-		grep "(symlink)" filelog
+		test_grep "(symlink)" filelog
 	)
 '
 
@@ -55,7 +55,7 @@ test_expect_success SYMLINKS 'change symbolic link to file' '
 		git commit -m "re-write file2" &&
 		git p4 submit &&
 		p4 filelog -m 1 //depot/file2 >filelog &&
-		grep "(text)" filelog
+		test_grep "(text)" filelog
 	)
 '
 
diff --git a/t/t9832-unshelve.sh b/t/t9832-unshelve.sh
index 6b3cb0414a..f85a60a184 100755
--- a/t/t9832-unshelve.sh
+++ b/t/t9832-unshelve.sh
@@ -69,7 +69,7 @@ EOF
 		change=$(last_shelved_change) &&
 		git p4 unshelve $change &&
 		git show refs/remotes/p4-unshelved/$change >actual &&
-		grep -q "Further description" actual &&
+		test_grep -q "Further description" actual &&
 		git cherry-pick refs/remotes/p4-unshelved/$change &&
 		test_path_is_file file2 &&
 		test_cmp file1 "$cli"/file1 &&
@@ -141,7 +141,7 @@ test_expect_success 'create shelved changelist based on p4 change ahead of p4/ma
 		shelve_one_file //depot/file1 &&
 		change=$(last_shelved_change) &&
 		p4 describe -S $change >out.txt &&
-		grep -q "Change to be unshelved" out.txt
+		test_grep -q "Change to be unshelved" out.txt
 	)
 '
 
@@ -152,7 +152,7 @@ test_expect_success 'try to unshelve the change' '
 		change=$(last_shelved_change) &&
 		cd "$git" &&
 		git p4 unshelve $change >out.txt &&
-		grep -q "unshelved changelist $change" out.txt
+		test_grep -q "unshelved changelist $change" out.txt
 	)
 '
 
diff --git a/t/t9833-errors.sh b/t/t9833-errors.sh
index e22369ccdf..b312669ef2 100755
--- a/t/t9833-errors.sh
+++ b/t/t9833-errors.sh
@@ -29,7 +29,7 @@ test_expect_success 'error handling' '
 		P4PASSWD=badpassword &&
 		export P4PASSWD &&
 		test_must_fail git p4 clone //depot/foo 2>errmsg &&
-		grep -q "failure accessing depot.*P4PASSWD" errmsg
+		test_grep -q "failure accessing depot.*P4PASSWD" errmsg
 	)
 '
 
@@ -41,7 +41,7 @@ test_expect_success 'ticket logged out' '
 		test_commit "ticket-auth-check" &&
 		p4 logout &&
 		test_must_fail git p4 submit 2>errmsg &&
-		grep -q "failure accessing depot" errmsg
+		test_grep -q "failure accessing depot" errmsg
 	)
 '
 
diff --git a/t/t9835-git-p4-metadata-encoding-python2.sh b/t/t9835-git-p4-metadata-encoding-python2.sh
index b969c7e0d5..7eb0c8ecd1 100755
--- a/t/t9835-git-p4-metadata-encoding-python2.sh
+++ b/t/t9835-git-p4-metadata-encoding-python2.sh
@@ -84,7 +84,7 @@ test_expect_success 'clone non-utf8 repo with strict encoding' '
 	test_when_finished cleanup_git &&
 	test_when_finished remove_user_cache &&
 	test_must_fail git -c git-p4.metadataDecodingStrategy=strict p4-python2 clone --dest="$git" //depot@all 2>err &&
-	grep "Decoding perforce metadata failed!" err
+	test_grep "Decoding perforce metadata failed!" err
 '
 
 test_expect_success 'check utf-8 contents with passthrough strategy' '
@@ -94,8 +94,8 @@ test_expect_success 'check utf-8 contents with passthrough strategy' '
 	(
 		cd "$git" &&
 		git log >actual &&
-		grep "some utf-8 tǣxt" actual &&
-		grep "ǣuthor" actual
+		test_grep "some utf-8 tǣxt" actual &&
+		test_grep "ǣuthor" actual
 	)
 '
 
@@ -107,9 +107,9 @@ test_expect_success 'check latin-1 contents corrupted in git with passthrough st
 		cd "$git" &&
 		git log >actual &&
 		badly_encoded_in_git=$(echo "some latin-1 tæxt" | iconv -f utf8 -t latin1) &&
-		grep "$badly_encoded_in_git" actual &&
+		test_grep "$badly_encoded_in_git" actual &&
 		bad_author_in_git="$(echo æuthor | iconv -f utf8 -t latin1)" &&
-		grep "$bad_author_in_git" actual
+		test_grep "$bad_author_in_git" actual
 	)
 '
 
@@ -120,8 +120,8 @@ test_expect_success 'check utf-8 contents with fallback strategy' '
 	(
 		cd "$git" &&
 		git log >actual &&
-		grep "some utf-8 tǣxt" actual &&
-		grep "ǣuthor" actual
+		test_grep "some utf-8 tǣxt" actual &&
+		test_grep "ǣuthor" actual
 	)
 '
 
@@ -132,8 +132,8 @@ test_expect_success 'check latin-1 contents with fallback strategy' '
 	(
 		cd "$git" &&
 		git log >actual &&
-		grep "some latin-1 tæxt" actual &&
-		grep "æuthor" actual
+		test_grep "some latin-1 tæxt" actual &&
+		test_grep "æuthor" actual
 	)
 '
 
@@ -144,8 +144,8 @@ test_expect_success 'check cp-1252 contents with fallback strategy' '
 	(
 		cd "$git" &&
 		git log >actual &&
-		grep "sœme cp-1252 tæxt" actual &&
-		grep "æuthœr" actual
+		test_grep "sœme cp-1252 tæxt" actual &&
+		test_grep "æuthœr" actual
 	)
 '
 
@@ -156,8 +156,8 @@ test_expect_success 'check cp850 contents parsed with correct fallback' '
 	(
 		cd "$git" &&
 		git log >actual &&
-		grep "hÅs some cp850 text" actual &&
-		grep "Åuthor" actual
+		test_grep "hÅs some cp850 text" actual &&
+		test_grep "Åuthor" actual
 	)
 '
 
@@ -168,8 +168,8 @@ test_expect_success 'check cp850-only contents escaped when cp1252 is fallback'
 	(
 		cd "$git" &&
 		git log >actual &&
-		grep "h%8Fs some cp850 text" actual &&
-		grep "%8Futhor" actual
+		test_grep "h%8Fs some cp850 text" actual &&
+		test_grep "%8Futhor" actual
 	)
 '
 
@@ -191,8 +191,8 @@ test_expect_success 'check cp-1252 contents on later sync after clone with fallb
 		git p4-python2 sync --branch=master &&
 
 		git log p4/master >actual &&
-		grep "sœme more cp-1252 tæxt" actual &&
-		grep "æuthœr" actual
+		test_grep "sœme more cp-1252 tæxt" actual &&
+		test_grep "æuthœr" actual
 	)
 '
 
@@ -208,7 +208,7 @@ test_expect_success 'passthrough (latin-1 contents corrupted in git) is the defa
 		cd "$git" &&
 		git log >actual &&
 		badly_encoded_in_git=$(echo "some latin-1 tæxt" | iconv -f utf8 -t latin1) &&
-		grep "$badly_encoded_in_git" actual
+		test_grep "$badly_encoded_in_git" actual
 	)
 '
 
diff --git a/t/t9836-git-p4-metadata-encoding-python3.sh b/t/t9836-git-p4-metadata-encoding-python3.sh
index da6669bf71..16118495cd 100755
--- a/t/t9836-git-p4-metadata-encoding-python3.sh
+++ b/t/t9836-git-p4-metadata-encoding-python3.sh
@@ -84,7 +84,7 @@ test_expect_success 'clone non-utf8 repo with strict encoding' '
 	test_when_finished cleanup_git &&
 	test_when_finished remove_user_cache &&
 	test_must_fail git -c git-p4.metadataDecodingStrategy=strict p4-python3 clone --dest="$git" //depot@all 2>err &&
-	grep "Decoding perforce metadata failed!" err
+	test_grep "Decoding perforce metadata failed!" err
 '
 
 test_expect_success 'check utf-8 contents with passthrough strategy' '
@@ -94,8 +94,8 @@ test_expect_success 'check utf-8 contents with passthrough strategy' '
 	(
 		cd "$git" &&
 		git log >actual &&
-		grep "some utf-8 tǣxt" actual &&
-		grep "ǣuthor" actual
+		test_grep "some utf-8 tǣxt" actual &&
+		test_grep "ǣuthor" actual
 	)
 '
 
@@ -107,9 +107,9 @@ test_expect_success 'check latin-1 contents corrupted in git with passthrough st
 		cd "$git" &&
 		git log >actual &&
 		badly_encoded_in_git=$(echo "some latin-1 tæxt" | iconv -f utf8 -t latin1) &&
-		grep "$badly_encoded_in_git" actual &&
+		test_grep "$badly_encoded_in_git" actual &&
 		bad_author_in_git="$(echo æuthor | iconv -f utf8 -t latin1)" &&
-		grep "$bad_author_in_git" actual
+		test_grep "$bad_author_in_git" actual
 	)
 '
 
@@ -120,8 +120,8 @@ test_expect_success 'check utf-8 contents with fallback strategy' '
 	(
 		cd "$git" &&
 		git log >actual &&
-		grep "some utf-8 tǣxt" actual &&
-		grep "ǣuthor" actual
+		test_grep "some utf-8 tǣxt" actual &&
+		test_grep "ǣuthor" actual
 	)
 '
 
@@ -132,8 +132,8 @@ test_expect_success 'check latin-1 contents with fallback strategy' '
 	(
 		cd "$git" &&
 		git log >actual &&
-		grep "some latin-1 tæxt" actual &&
-		grep "æuthor" actual
+		test_grep "some latin-1 tæxt" actual &&
+		test_grep "æuthor" actual
 	)
 '
 
@@ -144,8 +144,8 @@ test_expect_success 'check cp-1252 contents with fallback strategy' '
 	(
 		cd "$git" &&
 		git log >actual &&
-		grep "sœme cp-1252 tæxt" actual &&
-		grep "æuthœr" actual
+		test_grep "sœme cp-1252 tæxt" actual &&
+		test_grep "æuthœr" actual
 	)
 '
 
@@ -156,8 +156,8 @@ test_expect_success 'check cp850 contents parsed with correct fallback' '
 	(
 		cd "$git" &&
 		git log >actual &&
-		grep "hÅs some cp850 text" actual &&
-		grep "Åuthor" actual
+		test_grep "hÅs some cp850 text" actual &&
+		test_grep "Åuthor" actual
 	)
 '
 
@@ -168,8 +168,8 @@ test_expect_success 'check cp850-only contents escaped when cp1252 is fallback'
 	(
 		cd "$git" &&
 		git log >actual &&
-		grep "h%8Fs some cp850 text" actual &&
-		grep "%8Futhor" actual
+		test_grep "h%8Fs some cp850 text" actual &&
+		test_grep "%8Futhor" actual
 	)
 '
 
@@ -191,8 +191,8 @@ test_expect_success 'check cp-1252 contents on later sync after clone with fallb
 		git p4-python3 sync --branch=master &&
 
 		git log p4/master >actual &&
-		grep "sœme more cp-1252 tæxt" actual &&
-		grep "æuthœr" actual
+		test_grep "sœme more cp-1252 tæxt" actual &&
+		test_grep "æuthœr" actual
 	)
 '
 
@@ -208,8 +208,8 @@ test_expect_success 'fallback (both utf-8 and cp-1252 contents handled) is the d
 	(
 		cd "$git" &&
 		git log >actual &&
-		grep "sœme cp-1252 tæxt" actual &&
-		grep "æuthœr" actual
+		test_grep "sœme cp-1252 tæxt" actual &&
+		test_grep "æuthœr" actual
 	)
 '
 
diff --git a/t/t9850-shell.sh b/t/t9850-shell.sh
index 21c3af48bd..27cc49bbd1 100755
--- a/t/t9850-shell.sh
+++ b/t/t9850-shell.sh
@@ -32,7 +32,7 @@ test_expect_success 'shell allows interactive command' '
 test_expect_success 'shell complains of overlong commands' '
 	test-tool genzeros | tr "\000" "a" |
 	test_must_fail git shell 2>err &&
-	grep "too long" err
+	test_grep "too long" err
 '
 
 test_done
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 55dc9eabfc..9ae3c48ebd 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1381,7 +1381,7 @@ test_expect_success '__git_complete_worktree_paths' '
 	test_when_finished "git worktree remove other_wt" &&
 	git worktree add --orphan other_wt &&
 	run_completion "git worktree remove " &&
-	grep other_wt out
+	test_grep other_wt out
 '
 
 test_expect_success '__git_complete_worktree_paths - not a git repository' '
@@ -1397,7 +1397,7 @@ test_expect_success '__git_complete_worktree_paths with -C' '
 	test_when_finished "git -C otherrepo worktree remove otherrepo_wt" &&
 	git -C otherrepo worktree add --orphan otherrepo_wt &&
 	run_completion "git -C otherrepo worktree remove " &&
-	grep otherrepo_wt out
+	test_grep otherrepo_wt out
 '
 
 test_expect_success 'git switch - with no options, complete local branches and unique remote branch names for DWIM logic' '
@@ -2554,14 +2554,14 @@ test_expect_success '__git_pretty_aliases' '
 test_expect_success 'basic' '
 	run_completion "git " &&
 	# built-in
-	grep -q "^add \$" out &&
+	test_grep -q "^add \$" out &&
 	# script
-	grep -q "^rebase \$" out &&
+	test_grep -q "^rebase \$" out &&
 	# plumbing
-	! grep -q "^ls-files \$" out &&
+	test_grep ! -q "^ls-files \$" out &&
 
 	run_completion "git r" &&
-	! grep -q -v "^r" out
+	test_grep ! -q -v "^r" out
 '
 
 test_expect_success 'double dash "git" itself' '
@@ -2656,7 +2656,7 @@ test_expect_success 'git --help completion' '
 test_expect_success 'completion.commands removes multiple commands' '
 	test_config completion.commands "-cherry -mergetool" &&
 	git --list-cmds=list-mainporcelain,list-complete,config >out &&
-	! grep -E "^(cherry|mergetool)$" out
+	test_grep ! -E "^(cherry|mergetool)$" out
 '
 
 test_expect_success 'setup for integration tests' '
@@ -3179,8 +3179,8 @@ test_expect_success 'plumbing commands are excluded without GIT_COMPLETION_SHOW_
 
 		# Just mainporcelain, not plumbing commands
 		run_completion "git c" &&
-		grep checkout out &&
-		! grep cat-file out
+		test_grep checkout out &&
+		test_grep ! cat-file out
 	)
 '
 
@@ -3193,13 +3193,13 @@ test_expect_success 'all commands are shown with GIT_COMPLETION_SHOW_ALL_COMMAND
 
 		# Both mainporcelain and plumbing commands
 		run_completion "git c" &&
-		grep checkout out &&
-		grep cat-file out &&
+		test_grep checkout out &&
+		test_grep cat-file out &&
 
 		# Check "gitk", a "main" command, but not a built-in + more plumbing
 		run_completion "git g" &&
-		grep gitk out &&
-		grep get-tar-commit-id out
+		test_grep gitk out &&
+		test_grep get-tar-commit-id out
 	)
 '
 
-- 
gitgitgadget

