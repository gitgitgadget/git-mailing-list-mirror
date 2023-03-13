Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52828C6FD19
	for <git@archiver.kernel.org>; Mon, 13 Mar 2023 17:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjCMRs4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Mar 2023 13:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjCMRsx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2023 13:48:53 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0167203A;
        Mon, 13 Mar 2023 10:48:42 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id p6so13898058plf.0;
        Mon, 13 Mar 2023 10:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678729721;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7BIxA02pW5SMb4juCGikyl5TFH9aaVqFlGCvY4pcDTQ=;
        b=EhHT3mOGPmV0RKx6Mbn+zohpFMlLdguTFBdMn8EDmfOyCSOe2iwSH1yCP7+mofrMCP
         egNcbXgX8VhFYZA2COp8kIxAJb5SzScHE7cG0Z/yut6aup6Ymsy1VHwvWg6UYXPI48Fw
         /K9nWoz7UUY2+sBQPogs5v2nuiaGg9rq2HX0dYhtF0dMBFC+n2V4KYPrm6nee0dLuiX3
         Q328tZtKxfeNUD/dQsFismfL2HSLNm1O6cWsKXLLCoGkacHUHlA0A6hsIsbzfwhXdTne
         QvSo6IhxUmNOtg5oVaEAawL/a00ZRRdnfAU3BMfJywTAPr4U+tv93gOD1hyGJ5r42GRz
         64KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678729721;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7BIxA02pW5SMb4juCGikyl5TFH9aaVqFlGCvY4pcDTQ=;
        b=2ntOi+bG3ctR3TvhBQMB6TPW7tmXu+V7Aw6cPqG5zEQ+udJelU29fIpSN7oY/febDT
         AEsVqDqYlYdSi1cuI/4E16S9NOC6eT+EPCiEkRF1OEsFDSq4JxNAzDeOaxRcHrtyxvNs
         6f8Y/5YasmOdJVk09vjQae9LBWABkWpnPuAS0yzo0WKQGzdKU63LdJ8E4A76ldtksW3t
         Kdjdhc9CM3t2uUvCk3n1gr3Zq1/K4gL5FjiugsLNB+XDFzPlU2xv1NRmwqajmlmjlbEE
         KXmbSkaOXvluKrRIyV3CxfHoeA/k3OEWz4zpH0/Um2hH/PRmKGzuva0SzpYm/+Ecfp5H
         zx5Q==
X-Gm-Message-State: AO0yUKX27tk5BAShHWIM2h5PiFYk1FQ2HHkgqaGzJmIai14qTJW6ZAZv
        WKb3HXlRi413H0LL0b3HwrTiashlzSQ=
X-Google-Smtp-Source: AK7set9bug8NwcupL1x04chOA6FsQhHKzFpTzN/Rs376dWlf6/01m0vVtBSbe4Kt4Rw6jWqhNxorpQ==
X-Received: by 2002:a17:90b:613:b0:23c:ffe0:ccf9 with SMTP id gb19-20020a17090b061300b0023cffe0ccf9mr4285165pjb.39.1678729721091;
        Mon, 13 Mar 2023 10:48:41 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id f4-20020a17090a4a8400b0023d0290afbdsm183582pjh.4.2023.03.13.10.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 10:48:40 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.40.0
Date:   Mon, 13 Mar 2023 10:48:40 -0700
Message-ID: <xmqqjzzkv8xz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The latest feature release Git v2.40.0 is now available at the
usual places.  It is comprised of 472 non-merge commits since
v2.39.0, contributed by 88 people, 30 of which are new faces [*].

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.40.0'
tag and the 'master' branch that the tag points at:

  url = https://git.kernel.org/pub/scm/git/git
  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

New contributors whose contributions weren't in v2.39.0 are as follows.
Welcome to the Git development community!

  Adam Szkoda, Alison Winters, Ashutosh Pandey, Carl Baldwin,
  Daniël Haazen, Drew Noakes, Eric Sesterhenn, Gwyneth Morgan,
  Harshil-Jani, Hubert Jasudowicz, idriss fekir, Kostya Farber,
  Marco Nenciarini, Markus Vervier, Matheus Tavares Bernardino,
  Mathias Krause, Pat LaVarre, Peter Grayson, Rudy Rigot, Seija,
  Seija Kijin, Simon Gerber, Thierry Reding, toon@iotcl.com, Wes
  Lord, Yukai Chou, Yutaro Ohno, yvvdwf, Zhang Yi, and 孟子易.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  Ævar Arnfjörð Bjarmason, Alexander Shopov, Andrei Rybak, Bagas
  Sanjaya, Calvin Wan, Carlo Marcelo Arenas Belón, Christian
  Couder, Chris. Webster, Derrick Stolee, Đoàn Trần Công
  Danh, Elijah Newren, Emily Shaffer, Emir SARI, Eric Sunshine,
  Eric Wong, Erik Cervin Edin, Fangyi Zhou, Glen Choo, Jean-Noël
  Avila, Jeff Hostetler, Jeff King, Jiang Xin, Joern Schneeweisz,
  Johannes Schindelin, Johannes Sixt, John Cai, Jonathan Tan,
  Jordi Mas, Junio C Hamano, Karthik Nayak, Kevin Willford, Kyle
  Meyer, Kyle Zhao, Lars Kellogg-Stedman, Martin Ågren, Matthias
  Aßhauer, Matthias Rüster, M Hickford, Patrick Steinhardt,
  Peter Krefting, Philip Oakley, Philippe Blain, Phillip Wood,
  Ralf Thielow, Randall S. Becker, René Scharfe, Rubén Justo,
  Sean Allred, Siddharth Asthana, Sven Strickroth, SZEDER Gábor,
  Taylor Blau, Teng Long, Torsten Bögershausen, William Sprent,
  Yoichi Nakayama, ZheNing Hu, and 依云.

[*] We are counting not just the authorship contribution but issue
    reporting, mentoring, helping and reviewing that are recorded in
    the commit trailers.

----------------------------------------------------------------

Git v2.40 Release Notes
=======================

UI, Workflows & Features

 * "merge-tree" learns a new `--merge-base` option.

 * "git jump" (in contrib/) learned to present the "quickfix list" to
   its standard output (instead of letting it consumed by the editor
   it invokes), and learned to also drive emacs/emacsclient.

 * "git var UNKNOWN_VARIABLE" and "git var VARIABLE" with the variable
   given an empty value used to behave identically.  Now the latter
   just gives an empty output, while the former still gives an error
   message.

 * Introduce a case insensitive mode to the Bash completion helpers.

 * The advice message given by "git status" when it takes long time to
   enumerate untracked paths has been updated.

 * Just like "git var GIT_EDITOR" abstracts the complex logic to
   choose which editor gets used behind it, "git var" now give support
   to GIT_SEQUENCE_EDITOR.

 * "git format-patch" learned to honor format.mboxrd even when sending
   patches to the standard output stream,

 * 'cat-file' gains mailmap support for its '--batch-check' and '-s'
   options.

 * Conditionally skip the pre-applypatch and applypatch-msg hooks when
   applying patches with 'git am'.

 * Introduce an optional configuration to allow the trailing hash that
   protects the index file from bit flipping.

 * "git check-attr" learned to take an optional tree-ish to read the
   .gitattributes file from.

 * "scalar" learned to give progress bar.

 * "grep -P" learned to use Unicode Character Property to grok
   character classes when processing \b and \w etc.

 * "git rebase" often ignored incompatible options instead of
   complaining, which has been corrected.

 * "scalar" warns but continues when its periodic maintenance
   feature cannot be enabled.

 * The bundle-URI subsystem adds support for creation-token heuristics
   to help incremental fetches.

 * Userdiff regexp update for Java language.

 * "git fetch --jobs=0" used to hit a BUG(), which has been corrected
   to use the available CPUs.

 * An invalid label or ref in the "rebase -i" todo file used to
   trigger an runtime error. SUch an error is now diagnosed while the
   todo file is parsed.

 * The "diff" drivers specified by the "diff" attribute attached to
   paths can now specify which algorithm (e.g. histogram) to use.

 * "git range-diff" learned --abbrev=<num> option.

 * "git archive HEAD^{tree}" records the paths with the current
   timestamp in the archive, making it harder to obtain a stable
   output.  The command learned the --mtime option to specify an
   arbitrary timestamp (e.g. --mtime="@0 +0000" for the epoch).

 * The credential subsystem learned that a password may have an
   explicit expiration.

 * The format.attach configuration variable lacked a way to override a
   value defined in a lower-priority configuration file (e.g. the
   system one) by redefining it in a higher-priority configuration
   file.  Now, setting format.attach to an empty string means show the
   patch inline in the e-mail message, without using MIME attachment.

   This is a backward incompatible change.


Performance, Internal Implementation, Development Support etc.

 * `git bisect` becomes a builtin.

 * The pack-bitmap machinery is taught to log the paths of redundant
   bitmap(s) to trace2 instead of stderr.

 * Use the SHA1DC implementation on macOS, just like other platforms,
   by default.

 * Even in a repository with promisor remote, it is useless to
   attempt to lazily attempt fetching an object that is expected to be
   commit, because no "filter" mode omits commit objects.  Take
   advantage of this assumption to fail fast on errors.

 * Stop using "git --super-prefix" and narrow the scope of its use to
   the submodule--helper.

 * Stop running win+VS build by default.

 * CI updates.  We probably want a clean-up to move the long shell
   script embedded in yaml file into a separate file, but that can
   come later.

 * Use `git diff --no-index` as a test_cmp on Windows.

   We'd probably need to revisit "do we really want to, and have to,
   lose CRLF vs LF?" later, at which time we may be able to further
   clean this up by replacing "git diff --no-index" with "diff -u".

 * Avoid unnecessary builds in CI, with settings configured in
   ci-config.

 * Plug leaks in sequencer subsystem and its users.

 * In-tree .gitattributes update to match the way we recommend our
   users to mark a file as text.
   (merge 1f34e0cd3d po/attributes-text later to maint).

 * Finally retire the scripted "git add -p/-i" implementation and have
   everybody use the one reimplemented in C.


Fixes since v2.39
-----------------

 * Various leak fixes.

 * Fix a bug where `pack-objects` would not respect multiple `--filter`
   arguments when invoked directly.
   (merge d4f7036887 rs/multi-filter-args later to maint).

 * Make fsmonitor more robust to avoid the flakiness seen in t7527.
   (merge 6692d45477 jh/t7527-unflake-by-forcing-cookie later to maint).

 * Stop using deprecated macOS API in fsmonitor.
   (merge b0226007f0 jh/fsmonitor-darwin-modernize later to maint).

 * Redefining system functions for a few functions did not follow our
   usual "implement git_foo() and #define foo(args) git_foo(args)"
   pattern, which has broken build for some folks.

 * The way the diff machinery prepares the options array for the
   parse_options API has been refactored to avoid resource leaks.
   (merge 189e97bc4b rs/diff-parseopts later to maint).

 * Correct pthread API usage.
   (merge 786e67611d sx/pthread-error-check-fix later to maint).

 * The code to auto-correct a misspelt subcommand unnecessarily called
   into git_default_config() from the early config codepath, which was
   a no-no.  This has bee corrected.
   (merge 0918d08887 sg/help-autocorrect-config-fix later to maint).

 * "git http-fetch" (which is rarely used) forgot to identify itself
   in the trace2 output.
   (merge 7abb43cbc8 jt/http-fetch-trace2-report-name later to maint).

 * The output from "git diff --stat" on an unmerged path lost the
   terminating LF in Git 2.39, which has been corrected.
   (merge 209d9cb011 pg/diff-stat-unmerged-regression-fix later to maint).

 * "git pull -v --recurse-submodules" attempted to pass "-v" down to
   underlying "git submodule update", which did not understand the
   request and barfed, which has been corrected.
   (merge 6f65f84766 ss/pull-v-recurse-fix later to maint).

 * When given a pattern that matches an empty string at the end of a
   line, the code to parse the "git diff" line-ranges fell into an
   infinite loop, which has been corrected.

 * Fix the sequence to fsync $GIT_DIR/packed-refs file that forgot to
   flush its output to the disk..

 * Fix to a small regression in 2.38 days.

 * "git diff --relative" did not mix well with "git diff --ext-diff",
   which has been corrected.

 * The logic to see if we are using the "cone" mode by checking the
   sparsity patterns has been tightened to avoid mistaking a pattern
   that names a single file as specifying a cone.

 * Deal with a few deprecation warning from cURL library.

 * Doc update for environment variables set when hooks are invoked.

 * Document ORIG_HEAD a bit more.

 * "git ls-tree --format='%(path) %(path)' $tree $path" showed the
   path three times, which has been corrected.

 * Remove "git env--helper" and demote it to a test-tool subcommand.
   (merge 4a1baacd46 ab/test-env-helper later to maint).

 * Newer regex library macOS stopped enabling GNU-like enhanced BRE,
   where '\(A\|B\)' works as alternation, unless explicitly asked with
   the REG_ENHANCED flag.  "git grep" now can be compiled to do so, to
   retain the old behaviour.

 * Pthread emulation on Win32 leaked thread handle when a thread is
   joined.
   (merge 238a9dfe86 sk/win32-close-handle-upon-pthread-join later to maint).

 * "git send-email -v 3" used to be expanded to "git send-email
   --validate 3" when the user meant to pass them down to
   "format-patch", which has been corrected.
   (merge 8774aa56ad km/send-email-with-v-reroll-count later to maint).

 * Document that "branch -f <branch>" disables only the safety to
   avoid recreating an existing branch.

 * "git fetch <group>", when "<group>" of remotes lists the same
   remote twice, unnecessarily failed when parallel fetching was
   enabled, which has been corrected.
   (merge 06a668cb90 cw/fetch-remote-group-with-duplication later to maint).

 * Clarify how "checkout -b/-B" and "git branch [-f]" are similar but
   different in the documentation.

 * "git hash-object" now checks that the resulting object is well
   formed with the same code as "git fsck".
   (merge 8e4309038f jk/hash-object-fsck later to maint).

 * Improve the error message given when private key is not loaded in
   the ssh agent in the codepath to sign with an ssh key.
   (merge dce7b31126 as/ssh-signing-improve-key-missing-error later to maint).

 * Adjust "git request-pull" to strip embedded signature from signed
   tags to notice non-PGP signatures.
   (merge a9cad02538 gm/request-pull-with-non-pgp-signed-tags later to maint).

 * Remove support for MSys, which now lags way behind MSys2.
   (merge 2987407f3c hj/remove-msys-support later to maint).

 * Fix use of CreateThread() API call made early in the windows
   start-up code.
   (merge 592bcab61b sk/winansi-createthread-fix later to maint).

 * "git pack-objects" learned to release delta-island bitmap data when
   it is done using it, saving peak heap memory usage.
   (merge 647982bb71 ew/free-island-marks later to maint).

 * In an environment where dynamically generated code is prohibited to
   run (e.g. SELinux), failure to JIT pcre patterns is expected.  Fall
   back to interpreted execution in such a case.
   (merge 50b6ad55b0 cb/grep-fallback-failing-jit later to maint).

 * "git name-rev" heuristics update.
   (merge b2182a8730 en/name-rev-make-taggerdate-much-less-important later to maint).

 * Remove more remaining uses of macros that relies on the_index
   singleton instance without explicitly spelling it out.

 * Remove unnecessary explicit sizing of strbuf.
   (merge 93ea118bed rs/cache-tree-strbuf-growth-fix later to maint).

 * Doc update.
   (merge d9ec3b0dc0 jk/doc-ls-remote-matching later to maint).

 * Error messages given upon a signature verification failure used to
   discard the errors from underlying gpg program, which has been
   corrected.
   (merge ad6b320756 js/gpg-errors later to maint).

 * Update --date=default documentation.
   (merge 9deef088ae rd/doc-default-date-format later to maint).

 * A test helper had a single write(2) of 256kB, which was too big for
   some platforms (e.g. NonStop), which has been corrected by using
   xwrite() wrapper appropriately.
   (merge 58eab6ff13 jc/genzeros-avoid-raw-write later to maint).

 * sscanf(3) used in "git symbolic-ref --short" implementation found
   to be not working reliably on macOS in UTF-8 locales.  Rewrite the
   code to avoid sscanf() altogether to work it around.
   (merge 613bef56b8 jk/shorten-unambiguous-ref-wo-sscanf later to maint).

 * Various fix-ups on HTTP tests.
   (merge 8f2146dbf1 jk/http-test-fixes later to maint).

 * Fixes to code that parses the todo file used in "rebase -i".
   (merge 666b6e1135 pw/rebase-i-parse-fix later to maint).

 * Test library clean-up.
   (merge c600a91c94 ar/test-lib-remove-stale-comment later to maint).

 * Other code cleanup, docfix, build fix, etc.
   (merge 4eb1ccecd4 dh/mingw-ownership-check-typofix later to maint).
   (merge f95526419b ar/typofix-gitattributes-doc later to maint).
   (merge 27875aeec9 km/doc-branch-start-point later to maint).
   (merge 35c194dc57 es/t1509-root-fixes later to maint).
   (merge 7b341645e3 pw/ci-print-failure-name-fix later to maint).
   (merge bcb71d45bf jx/t1301-updates later to maint).
   (merge ebdc46c242 jc/doc-diff-patch.txt later to maint).
   (merge a87a20cbb4 ar/test-cleanup later to maint).
   (merge f5156f1885 ar/bisect-doc-update later to maint).
   (merge fca2d86c97 jk/interop-error later to maint).
   (merge cf4936ed74 tl/ls-tree-code-clean-up later to maint).
   (merge dcb47e52b0 en/t6426-todo-cleanup later to maint).
   (merge 5b8db44bdd jc/format-patch-v-unleak later to maint).
   (merge 590b636737 jk/hash-object-literally-fd-leak later to maint).
   (merge 5458ba0a4d tb/t0003-invoke-dd-more-portably later to maint).
   (merge 70661d288b ar/markup-em-dash later to maint).
   (merge e750951e74 en/ls-files-doc-update later to maint).
   (merge 4f542975d1 mh/doc-credential-cache-only-in-core later to maint).
   (merge 3a2ebaebc7 gc/index-format-doc later to maint).
   (merge b08edf709d jk/httpd-test-updates later to maint).
   (merge d85e9448dd wl/new-command-doc later to maint).
   (merge d912a603ed kf/t5000-modernise later to maint).
   (merge e65b868d07 rs/size-t-fixes later to maint).
   (merge 3eb1e1ca9a ab/config-h-remove-unused later to maint).
   (merge d390e08076 cw/doc-pushurl-vs-url later to maint).
   (merge 567342fc77 rs/ctype-test later to maint).
   (merge d35d8f2e7a ap/t2015-style-update later to maint).

----------------------------------------------------------------

Changes since v2.39.0 are as follows:

Adam Szkoda (1):
      ssh signing: better error message when key not in agent

Alexander Shopov (1):
      l10n: bg.po: Updated Bulgarian translation (5490t)

Alison Winters (2):
      completion: add optional ignore-case when matching refs
      completion: add case-insensitive match of pseudorefs

Andrei Rybak (12):
      gitattributes.txt: fix typo in "comma separated"
      *: fix typos which duplicate a word
      git-bisect-lk2009: update java code conventions link
      git-bisect-lk2009: update nist report link
      t6003: uncomment test '--max-age=c3, --topo-order'
      t6422: drop commented out code
      t7527: use test_when_finished in 'case insensitive+preserving'
      Documentation: render dash correctly
      userdiff: support Java type parameters
      userdiff: support Java record types
      userdiff: support Java sealed classes
      test-lib: drop comment about test_description

Ashutosh Pandey (1):
      t2015-checkout-unborn.sh: changes the style for cd

Bagas Sanjaya (1):
      l10n: po-id for 2.40 (round 1)

Calvin Wan (2):
      fetch: fix duplicate remote parallel fetch bug
      Documentation: clarify multiple pushurls vs urls

Carlo Marcelo Arenas Belón (2):
      test-lib: add prerequisite for 64-bit platforms
      grep: correctly identify utf-8 characters with \{b,w} in -P

Chris. Webster (3):
      ci (check-whitespace): suggest fixes for errors
      ci (check-whitespace): add links to job output
      ci (check-whitespace): move to actions/checkout@v3

Daniël Haazen (1):
      mingw: fix typo in an error message from ownership check

Derrick Stolee (25):
      transport: rename got_remote_heads
      bundle-uri: serve bundle.* keys from config
      strbuf: introduce strbuf_strip_file_from_path()
      bundle-uri: allow relative URLs in bundle lists
      bundle-uri: download bundles from an advertised list
      clone: unbundle the advertised bundles
      hashfile: allow skipping the hash function
      read-cache: add index.skipHash config option
      test-lib-functions: add helper for trailing hash
      features: feature.manyFiles implies fast index writes
      t1600: fix racy index.skipHash test
      t: allow 'scalar' in test_must_fail
      t921*: test scalar behavior starting maintenance
      scalar: only warn when background maintenance fails
      bundle: test unbundling with incomplete history
      bundle: verify using check_connected()
      t5558: add tests for creationToken heuristic
      bundle-uri: parse bundle.heuristic=creationToken
      bundle-uri: parse bundle.<id>.creationToken values
      bundle-uri: download in creationToken order
      clone: set fetch.bundleURI if appropriate
      bundle-uri: drop bundle.flag from design doc
      fetch: fetch from an external bundle URI
      bundle-uri: store fetch.bundleCreationToken
      bundle-uri: test missing bundles with heuristic

Elijah Newren (16):
      ls-files: add missing documentation for --resolve-undo option
      ls-files: clarify descriptions of file selection options
      ls-files: clarify descriptions of status tags for -t
      ls-files: guide folks to --exclude-standard over other --exclude* options
      t6426: fix TODO about making test more comprehensive
      rebase: mark --update-refs as requiring the merge backend
      rebase: flag --apply and --merge as incompatible
      rebase: remove --allow-empty-message from incompatible opts
      rebase: fix docs about incompatibilities with --root
      rebase: fix incompatiblity checks for --[no-]reapply-cherry-picks
      rebase: add coverage of other incompatible options
      rebase: clarify the OPT_CMDMODE incompatibilities
      rebase: fix formatting of rebase --reapply-cherry-picks option in docs
      rebase: put rebase_options initialization in single place
      rebase: provide better error message for apply options vs. merge config
      name-rev: fix names by dropping taggerdate workaround

Emily Shaffer (4):
      run-command: allow stdin for run_processes_parallel
      hook API: support passing stdin to hooks, convert am's 'post-rewrite'
      sequencer: use the new hook API for the simpler "post-rewrite" call
      hook: support a --to-stdin=<path> option

Emir SARI (1):
      l10n: tr: Update Turkish translations for v.2.40.0

Eric Sunshine (4):
      t1509: fix failing "root work tree" test due to owner-check
      t1509: make "setup" test more robust
      t1509: facilitate repeated script invocations
      githooks: discuss Git operations in foreign repositories

Eric Wong (2):
      format-patch: support format.mboxrd with --stdout
      delta-islands: free island_marks and bitmaps

Fangyi Zhou (1):
      l10n: zh_CN v2.40.0 round 1

Glen Choo (2):
      read-tree + fetch tests: test failing "--super-prefix" interaction
      docs: document zero bits in index "mode"

Gwyneth Morgan (2):
      request-pull: filter out SSH/X.509 tag signatures
      signature-format.txt: note SSH and X.509 signature delimiters

Harshil-Jani (2):
      mingw: remove duplicate `USE_NED_ALLOCATOR` directive
      mingw: remove msysGit/MSYS1 support

Jean-Noël Avila (3):
      l10n: fr: fix some typos
      l10n: fr: v2.40.0 rnd 1
      l10n: fr: v2.40.0 rnd 2

Jeff Hostetler (2):
      fsmonitor: fix race seen in t7527
      fsmonitor: eliminate call to deprecated FSEventStream function

Jeff King (74):
      git-jump: move valid-mode check earlier
      pack-bitmap.c: break out of the bitmap loop early if not tracing
      pack-bitmap.c: trace bitmap ignore logs when midx-bitmap is found
      git-compat-util: avoid redefining system function names
      git-compat-util: undefine system names before redeclaring them
      server_supports_v2(): use a separate function for die_on_error
      ls-refs: use repository parameter to iterate refs
      blob: drop unused parts of parse_blob_buffer()
      list-objects: drop process_gitlink() function
      ws: drop unused parameter from ws_blank_line()
      xdiff: drop unused parameter in def_ff()
      xdiff: mark unused parameter in xdl_call_hunk_func()
      diff: mark unused parameters in callbacks
      list-objects-filter: mark unused parameters in virtual functions
      userdiff: mark unused parameter in internal callback
      ref-filter: reject arguments to %(HEAD)
      ref-filter: factor out "%(foo) does not take arguments" errors
      ref-filter: factor out "unrecognized %(foo) arg" errors
      ref-filter: truncate atom names in error messages
      ref-filter: convert email atom parser to use err_bad_arg()
      test-bundle-uri: drop unused variables
      diff: use filespec path to set up tempfiles for ext-diff
      diff: clean up external-diff argv setup
      diff: drop "name" parameter from prepare_temp_file()
      convert trivial uses of strncmp() to starts_with()
      convert trivial uses of strncmp() to skip_prefix()
      object-file: inline calls to read_object()
      streaming: inline call to read_object_file_extended()
      read_object_file_extended(): drop lookup_replace option
      repo_read_object_file(): stop wrapping read_object_file_extended()
      packfile: inline custom read_object()
      object-file: fix indent-with-space
      t/interop: report which vanilla git command failed
      http-push: prefer CURLOPT_UPLOAD to CURLOPT_PUT
      http: prefer CURLOPT_SEEKFUNCTION to CURLOPT_IOCTLFUNCTION
      http: support CURLOPT_PROTOCOLS_STR
      t1007: modernize malformed object tests
      t1006: stop using 0-padded timestamps
      t7030: stop using invalid tag name
      t: use hash-object --literally when created malformed objects
      fsck: provide a function to fsck buffer without object struct
      hash-object: use fsck for object checks
      hash-object: fix descriptor leak with --literally
      fsck: do not assume NUL-termination of buffers
      t/lib-httpd: bump required apache version to 2.2
      t/lib-httpd: bump required apache version to 2.4
      t/lib-httpd: drop SSLMutex config
      t/lib-httpd: increase ssl key size to 2048 bits
      http-push: prefer CURLOPT_UPLOAD to CURLOPT_PUT
      http: prefer CURLOPT_SEEKFUNCTION to CURLOPT_IOCTLFUNCTION
      http: support CURLOPT_PROTOCOLS_STR
      doc/ls-remote: cosmetic cleanups for examples
      doc/ls-remote: clarify pattern format
      shorten_unambiguous_ref(): avoid integer truncation
      shorten_unambiguous_ref(): use NUM_REV_PARSE_RULES constant
      shorten_unambiguous_ref(): avoid sscanf()
      add basic http proxy tests
      t0066: drop setup of "dir5"
      t5541: run "used receive-pack service" test earlier
      t5541: stop marking "used receive-pack service" test as v0 only
      t5541: simplify and move "no empty path components" test
      t5551: drop redundant grep for Accept-Language
      t5551: lower-case headers in expected curl trace
      t5551: handle HTTP/2 when checking curl trace
      t5551: stop forcing clone to run with v0 protocol
      t5551: handle v2 protocol when checking curl trace
      t5551: handle v2 protocol in upload-pack service test
      t5551: simplify expected cookie file
      t5551: handle v2 protocol in cookie test
      t5551: drop curl trace lines without headers
      t/lib-httpd: respect $HTTPD_PROTO in expect_askpass()
      t/lib-httpd: enable HTTP/2 "h2" protocol, not just h2c
      t5559: fix test failures with LIB_HTTPD_SSL
      t5559: make SSL/TLS the default

Jiang Xin (3):
      t1301: fix wrong template dir for git-init
      t1301: use test_when_finished for cleanup
      t1301: do not change $CWD in "shared=all" test case

Johannes Schindelin (24):
      bisect--helper: handle states directly
      Turn `git bisect` into a full built-in
      t0021: use Windows-friendly `pwd`
      tests(mingw): avoid very slow `mingw_test_cmp`
      ci: only run win+VS build & tests in Git for Windows' fork
      bisect--helper: simplify exit code computation
      bisect: verify that a bogus option won't try to start a bisection
      bisect run: fix the error message
      bisect: remove Cogito-related code
      bisect: no longer try to clean up left-over `.git/head-name` files
      fsck: document the new `gitattributes` message IDs
      attr: adjust a mismatched data type
      attr: adjust a mismatched data type
      Git 2.31.7
      Git 2.32.6
      Git 2.33.7
      Git 2.34.7
      Git 2.35.7
      Git 2.36.5
      Git 2.37.6
      Git 2.38.4
      Git 2.39.2
      t7510: add a test case that does not need gpg
      gpg: do show gpg's error message upon failure

Johannes Sixt (1):
      t3920: don't ignore errors of more than one command with `|| true`

John Cai (4):
      docs: link generating patch sections
      attr: fix instructions on how to check attrs
      diff: consolidate diff algorithm option parsing
      diff: teach diff to read algorithm from diff driver

Jonathan Tan (5):
      http-fetch: invoke trace2_cmd_name()
      object-file: remove OBJECT_INFO_IGNORE_LOOSE
      object-file: refactor map_loose_object_1()
      object-file: emit corruption errors when detected
      commit: don't lazy-fetch commits

Jordi Mas (1):
      l10n: Update Catalan translation

Junio C Hamano (43):
      Git 2.30.7
      Git 2.31.6
      Git 2.32.5
      Git 2.33.6
      Git 2.34.6
      Git 2.35.6
      Git 2.36.4
      Git 2.37.5
      Git 2.38.3
      Git 2.39.1
      Start the 2.40 cycle
      The first batch for 2.40
      The second batch
      The third batch
      The fourth batch
      The fifth batch
      The sixth batch
      format-patch: unleak "-v <num>"
      The seventh batch
      branch: document `-f` and linked worktree behaviour
      checkout: document -b/-B to highlight the differences from "git branch"
      The eighth batch
      The ninth batch
      The tenth batch
      The eleventh batch
      The twelfth batch
      The thirteenth batch
      Git 2.30.8
      The fourteenth batch
      The fifteenth batch
      Prepare for 2.39.3 just in case
      The sixteenth batch
      rev-list: clarify git-log default date format
      test-genzeros: avoid raw write(2)
      format.attach: allow empty value to disable multi-part messages
      The seventeenth batch
      Git 2.40-rc0
      A few more topics post 2.40-rc0
      A bit more before 2.40-rc1
      A bit more before 2.40-rc1
      Git 2.40-rc1
      Git 2.40-rc2
      Git 2.40

Karthik Nayak (2):
      t0003: move setup for `--all` into new block
      attr: add flag `--source` to work with tree-ish

Kostya Farber (1):
      t5000: modernise archive and :(glob) test

Kyle Meyer (2):
      send-email: relay '-v N' to format-patch
      doc/git-branch: fix --force description typo

Kyle Zhao (3):
      merge-tree.c: add --merge-base=<commit> option
      merge-tree.c: allow specifying the merge-base when --stdin is passed
      docs: fix description of the `--merge-base` option

Lars Kellogg-Stedman (1):
      line-range: fix infinite loop bug with '$' regex

M Hickford (2):
      Documentation: clarify that cache forgets credentials if the system restarts
      credential: new attribute password_expiry_utc

Martin Ågren (1):
      git-cat-file.txt: fix list continuations rendering literally

Mathias Krause (1):
      grep: fall back to interpreter if JIT memory allocation fails

Matthias Aßhauer (1):
      fetch: choose a sensible default with --jobs=0 again

Patrick Steinhardt (28):
      attr: fix overflow when upserting attribute with overly long name
      attr: fix out-of-bounds read with huge attribute names
      attr: fix integer overflow when parsing huge attribute names
      attr: fix out-of-bounds write when parsing huge number of attributes
      attr: fix out-of-bounds read with unreasonable amount of patterns
      attr: fix integer overflow with more than INT_MAX macros
      attr: harden allocation against integer overflows
      attr: fix silently splitting up lines longer than 2048 bytes
      attr: ignore attribute lines exceeding 2048 bytes
      attr: ignore overly large gitattributes files
      pretty: fix out-of-bounds write caused by integer overflow
      pretty: fix out-of-bounds read when left-flushing with stealing
      pretty: fix out-of-bounds read when parsing invalid padding format
      pretty: fix adding linefeed when placeholder is not expanded
      pretty: fix integer overflow in wrapping format
      utf8: fix truncated string lengths in `utf8_strnwidth()`
      utf8: fix returning negative string width
      utf8: fix overflow when returning string width
      utf8: fix checking for glyph width in `strbuf_utf8_replace()`
      utf8: refactor `strbuf_utf8_replace` to not rely on preallocated buffer
      pretty: restrict input lengths for padding and wrapping formats
      fsck: refactor `fsck_blob()` to allow for more checks
      fsck: pull out function to check a set of blobs
      fsck: move checks for gitattributes
      fsck: implement checks for gitattributes
      refs: fix corruption by not correctly syncing packed-refs to disk
      apply: fix writing behind newly created symbolic links
      delta-islands: fix segfault when freeing island marks

Peter Grayson (1):
      diff: fix regression with --stat and unmerged file

Peter Krefting (1):
      l10n: sv.po: Update Swedish translation (5490t0f0u)

Philip Oakley (6):
      doc: pretty-formats: separate parameters from placeholders
      doc: pretty-formats: delineate `%<|(` parameter values
      doc: pretty-formats document negative column alignments
      doc: pretty-formats describe use of ellipsis in truncation
      doc: pretty-formats note wide char limitations, and add tests
      .gitattributes: include `text` attribute for eol attributes

Philippe Blain (6):
      git-cherry-pick.txt: do not use 'ORIG_HEAD' in example
      git-reset.txt: mention 'ORIG_HEAD' in the Description
      git-merge.txt: mention 'ORIG_HEAD' in the Description
      revisions.txt: be explicit about commands writing 'ORIG_HEAD'
      git-rebase.txt: add a note about 'ORIG_HEAD' being overwritten
      branch: improve advice when --recurse-submodules fails

Phillip Wood (5):
      ci(github): restore "print test failures" step name
      rebase: cleanup "--exec" option handling
      rebase -i: check labels and refs when parsing todo list
      rebase -i: match whole word in is_command()
      rebase -i: fix parsing of "fixup -C<commit>"

Ralf Thielow (1):
      l10n: update German translation

René Scharfe (31):
      t5317: stop losing return codes of git ls-files
      t5317: demonstrate failure to handle multiple --filter options
      pack-objects: fix handling of multiple --filter options
      pack-objects: simplify --filter handling
      list-objects-filter: remove OPT_PARSE_LIST_OBJECTS_FILTER_INIT()
      t4205: don't exit test script on failure
      diff: factor out add_diff_options()
      diff: use add_diff_options() in diff_opt_parse()
      diff: remove parseopts member from struct diff_options
      list-objects-filter: plug pattern_list leak
      t3920: support CR-eating grep
      reflog: clear leftovers in reflog_expiry_cleanup()
      commit: skip already cleared parents in clear_commit_marks_1()
      am: don't pass strvec to apply_parse_options()
      object-file: inline write_buffer()
      use enhanced basic regular expressions on macOS
      mingw: make argv2 in try_shell_exec() non-const
      factor out BARF_UNLESS_COPYABLE
      do full type check in BARF_UNLESS_COPYABLE
      add DUP_ARRAY
      use DUP_ARRAY
      ls-tree: fix expansion of repeated %(path)
      ls-tree: remove dead store and strbuf for quote_c_style()
      read-cache: use size_t for {base,df}_name_compare()
      pack-objects: use strcspn(3) in name_cmp_len()
      cache-tree: fix strbuf growth in prime_cache_tree_rec()
      test-ctype: test isascii
      test-ctype: test islower and isupper
      test-ctype: test iscntrl, ispunct, isxdigit and isprint
      archive: add --mtime
      range-diff: avoid compiler warning when char is unsigned

Rubén Justo (1):
      branch: force-copy a branch to itself via @{-1} is a no-op

Rudy Rigot (1):
      status: modernize git-status "slow untracked files" advice

SZEDER Gábor (1):
      tests: make 'test_oid' print trailing newline

Sean Allred (3):
      var: do not print usage() with a correct invocation
      var: allow GIT_EDITOR to return null
      var: add GIT_SEQUENCE_EDITOR variable

Seija (1):
      maintenance: compare output of pthread functions for inequality with 0

Seija Kijin (6):
      git: remove duplicate includes
      win32: use _endthreadex to terminate threads, not ExitThread
      win32: prepare pthread.c for change by formatting
      win32: close handles of threads that have been joined
      merge: break out of all_strategy loop when strategy is found
      compat/winansi: check for errors of CreateThread() correctly

Siddharth Asthana (2):
      cat-file: add mailmap support to -s option
      cat-file: add mailmap support to --batch-check option

Simon Gerber (1):
      help.c: fix autocorrect in work tree for bare repository

Sven Strickroth (1):
      submodule: accept -v for the update command

Taylor Blau (5):
      ci: avoid unnecessary builds
      t5619: demonstrate clone_local() with ambiguous transport
      clone: delay picking a transport until after get_repo_path()
      dir-iterator: prevent top-level symlinks without FOLLOW_SYMLINKS
      dir-iterator: drop unused `DIR_ITERATOR_FOLLOW_SYMLINKS`

Teng Long (5):
      pack-bitmap.c: remove unnecessary "open_pack_index()" calls
      pack-bitmap.c: avoid exposing absolute paths
      ls-tree: cleanup the redundant SPACE
      t3104: remove shift code in 'test_ls_tree_format'
      range-diff: let '--abbrev' option takes effect

Thierry Reding (1):
      am: allow passing --no-verify flag

Torsten Bögershausen (1):
      t0003: call dd with portable blocksize

Wes Lord (1):
      new-command.txt: update reference to builtin docs

William Sprent (1):
      dir: check for single file cone patterns

Yoichi Nakayama (2):
      git-jump: add an optional argument '--stdout'
      git-jump: invoke emacs/emacsclient

Yukai Chou (1):
      doc: fix non-existent config name

Yutaro Ohno (1):
      doc: add "git switch -c" as another option on detached HEAD

Zhang Yi (1):
      t9700: modernize test scripts

ZheNing Hu (1):
      scalar: show progress if stderr refers to a terminal

idriss fekir (1):
      trace.c, git.c: remove unnecessary parameter to trace_repo_setup()

Ævar Arnfjörð Bjarmason (90):
      bisect tests: test for v2.30.0 "bisect run" regressions
      bisect: refactor bisect_run() to match CodingGuidelines
      bisect test: test exit codes on bad usage
      bisect--helper: emit usage for "git bisect"
      bisect; remove unused "git-bisect.sh" and ".gitignore" entry
      tests: mark tests as passing with SANITIZE=leak
      {reset,merge}: call discard_index() before returning
      commit: discard partial cache before (re-)reading it
      read-cache.c: clear and free "sparse_checkout_patterns"
      dir.c: free "ident" and "exclude_per_dir" in "struct untracked_cache"
      built-ins & libs & helpers: add/move destructors, fix leaks
      unpack-file: fix ancient leak in create_temp_file()
      revision API: call graph_clear() in release_revisions()
      ls-files: fix a --with-tree memory leak
      sequencer.c: fix "opts->strategy" leak in read_strategy_opts()
      connected.c: free the "struct packed_git"
      rebase: don't leak on "--abort"
      cherry-pick: free "struct replay_opts" members
      revert: fix parse_options_concat() leak
      built-ins: use free() not UNLEAK() if trivial, rm dead code
      t5314: check exit code of "git"
      t7600: don't ignore "rev-parse" exit code in helper
      t4023: fix ignored exit codes of git
      Makefile: use sha1collisiondetection by default on OSX and Darwin
      bundle: don't segfault on "git bundle <subcmd>"
      protocol v2: add server-side "bundle-uri" skeleton
      t: create test harness for 'bundle-uri' command
      clone: request the 'bundle-uri' command when available
      bundle-uri client: add boolean transfer.bundleURI setting
      bundle-uri client: add helper for testing server
      submodule absorbgitdirs tests: add missing "Migrating git..." tests
      submodule.c & submodule--helper: pass along "super_prefix" param
      submodule--helper: don't use global --super-prefix in "absorbgitdirs"
      submodule--helper: convert "foreach" to its own "--super-prefix"
      submodule--helper: convert "sync" to its own "--super-prefix"
      submodule--helper: convert "status" to its own "--super-prefix"
      submodule--helper: convert "{update,clone}" to their own "--super-prefix"
      read-tree: add "--super-prefix" option, eliminate global
      builtin/bundle.c: remove superfluous "newargc" variable
      bundle <cmd>: have usage_msg_opt() note the missing "<file>"
      builtin/difftool.c: { 0 }-initialize rather than using memset()
      sparse-index.c: expand_to_path() can assume non-NULL "istate"
      sparse-index API: BUG() out on NULL ensure_full_index()
      read-cache.c: refactor set_new_index_sparsity() for subsequent commit
      bisect--helper: make the order consistently `argc, argv`
      ls-tree: don't use "show_tree_data" for "fast" callbacks
      ls-tree: use a "struct options"
      ls-tree: fold "show_tree_data" into "cb" struct
      ls-tree: make "line_termination" less generic
      env-helper: move this built-in to "test-tool env-helper"
      cache API: add a "INDEX_STATE_INIT" macro/function, add release_index()
      treewide: always have a valid "index_state.repo" member
      add: remove "add.interactive.useBuiltin" & Perl "git add--interactive"
      add API: remove run_add_interactive() wrapper function
      docs & comments: replace mentions of "git-add--interactive.perl"
      tests: mark tests as passing with SANITIZE=leak
      bundle.c: don't leak the "args" in the "struct child_process"
      commit-graph: use free_commit_graph() instead of UNLEAK()
      clone: use free() instead of UNLEAK()
      various: add missing clear_pathspec(), fix leaks
      name-rev: don't xstrdup() an already dup'd string
      repack: fix leaks on error with "goto cleanup"
      worktree: fix a trivial leak in prune_worktrees()
      http-backend.c: fix "dir" and "cmd_arg" leaks in cmd_main()
      http-backend.c: fix cmd_main() memory leak, refactor reg{exec,free}()
      commit-graph: fix a parse_options_concat() leak
      show-branch: free() allocated "head" before return
      builtin/merge.c: use fixed strings, not "strbuf", fix leak
      builtin/merge.c: free "&buf" on "Your local changes..." error
      grep.c: refactor free_grep_patterns()
      grep API: plug memory leaks by freeing "header_list"
      receive-pack: release the linked "struct command *" list
      push: refactor refspec_append_mapped() for subsequent leak-fix
      push: free_refs() the "local_refs" in set_refspecs()
      rebase: use "cleanup" pattern in do_interactive_rebase()
      sequencer.c: split up sequencer_remove_state()
      sequencer API users: fix get_replay_opts() leaks
      builtin/revert.c: move free-ing of "revs" to replay_opts_release()
      builtin/rebase.c: fix "options.onto_name" leak
      sequencer.c: always free() the "msgbuf" in do_pick_commit()
      builtin/rebase.c: free() "options.strategy_opts"
      commit.c: free() revs.commit in get_fork_point()
      config.h: remove unused git_configset_add_parameters()
      run-command.c: remove dead assignment in while-loop
      builtin/rm.c: use narrower "USE_THE_INDEX_VARIABLE"
      cocci & cache.h: fully apply "active_nr" part of index-compatibility
      cocci & cache.h: apply pending "index_cache_pos" rule
      cocci & cache-tree.h: migrate "write_cache_as_tree" to "*_index_*"
      cache-tree API: remove redundant update_main_cache_tree()
      cocci & cache.h: remove "USE_THE_INDEX_COMPATIBILITY_MACROS"

Đoàn Trần Công Danh (6):
      bisect: fix output regressions in v2.30.0
      bisect run: keep some of the post-v2.30.0 output
      bisect-run: verify_good: account for non-negative exit status
      bisect--helper: identify as bisect when report error
      bisect--helper: log: allow arbitrary number of arguments
      date.c: allow ISO 8601 reduced precision times

