Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F08AC001DB
	for <git@archiver.kernel.org>; Fri,  4 Aug 2023 19:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjHDTbJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Aug 2023 15:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjHDTbF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2023 15:31:05 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F57CE7;
        Fri,  4 Aug 2023 12:31:01 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3D1E71A57CD;
        Fri,  4 Aug 2023 15:31:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=CLQJ2c8Dmf6rj39yJWm2bYPGZ
        ZXo5nWAeDjlC3qWGSc=; b=UufUxW+3eVT45GPyl13Ib7yg5iQD0JJMrNZmEnATs
        9Adiu6AvzMl5sDdbMPX0Yc8XsAxBya9DHZYJpsa17nuE8Jmh7suDn9qlN3e2Zocd
        YIwPvxx0W4IFJ1y+IAlu1S+JVVWCd6+iaYmBGVJBdpHDZ/GAh3KY6QjmX4PDVbm3
        xs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1BF401A57CB;
        Fri,  4 Aug 2023 15:31:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3F1191A57CA;
        Fri,  4 Aug 2023 15:30:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.42.0-rc0
Date:   Fri, 04 Aug 2023 12:30:58 -0700
Message-ID: <xmqq5y5uli4t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 70A0BB68-32FD-11EE-AD17-307A8E0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

An early preview release Git v2.42.0-rc0 is now available for
testing at the usual places.  It is comprised of 401 non-merge
commits since v2.41.0, contributed by 59 people, 13 of which are
new faces [*].

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/testing/

The following public repositories all have a copy of the
'v2.42.0-rc0' tag and the 'master' branch that the tag points at:

  url =3D https://git.kernel.org/pub/scm/git/git
  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://github.com/gitster/git

New contributors whose contributions weren't in v2.41.0 are as follows.
Welcome to the Git development community!

  Andreas Herrmann, Greg Alexander, Han Young, Jacob Abel, Jan
  Kl=C3=B6tzke, Jim Pryor, Johan Ruokangas, Josh Sref, Josip Sokcevic,
  Petar Vutov, Premek Vysoky, Tribo Dar, and Vinayak Dev.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  , Alejandro R. Sede=C3=B1o, Alex Henrie, Beat Bolli, brian
  m. carlson, Calvin Wan, Christian Couder, D. Ben Knoble, Derrick
  Stolee, Elijah Newren, Eric Sunshine, Glen Choo, Hariom Verma,
  Jacob Keller, Jaydeep Das, Jeff King, Johannes Schindelin,
  John Cai, Jonathan Nieder, Jonathan Tan, Junio C Hamano, Kousik
  Sanagavarapu, Kristoffer Haugsbakk, Linus Arver, Martin =C3=85gren,
  Matthew Hughes, M Hickford, Michael Haggerty, Mike Hommey,
  Nsengiyumva Wilberforce, Patrick Steinhardt, Philippe Blain,
  Phillip Wood, Randall S. Becker, Ren=C3=A9 Scharfe, Rub=C3=A9n Justo,
  Sean Allred, Shuqi Liang, SZEDER G=C3=A1bor, Taylor Blau, Teng Long,
  Todd Zullinger, Toon Claes, Torsten B=C3=B6gershausen, Victoria Dye,
  and ZheNing Hu.

[*] We are counting not just the authorship contribution but issue
    reporting, mentoring, helping and reviewing that are recorded in
    the commit trailers.

----------------------------------------------------------------

Git v2.42 Release Notes (draft)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

UI, Workflows & Features

 * "git pack-refs" learns "--include" and "--exclude" to tweak the ref
   hierarchy to be packed using pattern matching.

 * 'git worktree add' learned how to create a worktree based on an
   orphaned branch with `--orphan`.

 * "git pack-objects" learned to invoke a new hook program that
   enumerates extra objects to be used as anchoring points to keep
   otherwise unreachable objects in cruft packs.

 * Add more "git var" for toolsmiths to learn various locations Git is
   configured with either via the configuration or hardcoded defaults.

 * 'git notes append' was taught '--separator' to specify string to inser=
t
   between paragraphs.

 * The "git for-each-ref" family of commands learned placeholders
   related to GPG signature verification.

 * "git diff --no-index" learned to read from named pipes as if they
   were regular files, to allow "git diff <(process) <(substitution)"
   some shells support.

 * Help newbies by suggesting that there are cases where force-pushing
   is a valid and sensible thing to update a branch at a remote
   repository, rather than reconciling with merge/rebase.

 * "git blame --contents=3Dfile" has been taught to work in a bare
   repository.

 * "git branch -f X" to repoint the branch X said that X was "checked
   out" in another worktree, even when branch X was not and instead
   being bisected or rebased.  The message was reworded to say the
   branch was "in use".


Performance, Internal Implementation, Development Support etc.

 * "git diff-tree" has been taught to take advantage of the
   sparse-index feature.

 * Clang's sanitizer implementation seems to work better than GCC's.
   (merge d88d727143 jk/ci-use-clang-for-sanitizer-jobs later to maint).

 * The object traversal using reachability bitmap done by
   "pack-object" has been tweaked to take advantage of the fact that
   using "boundary" commits as representative of all the uninteresting
   ones can save quite a lot of object enumeration.

 * discover_git_directory() no longer touches the_repository.

 * "git worktree" learned to work better with sparse index feature.

 * When the external merge driver is killed by a signal, its output
   should not be trusted as a resolution with conflicts that is
   proposed by the driver, but the code did.

 * The set-up code for the get_revision() API now allows feeding
   options like --all and --not in the --stdin mode.

 * Move functions that are not about pure string manipulation out of
   strbuf.[ch]

 * "imap-send" codepaths got cleaned up to get rid of unused
   parameters.

 * Enumerating refs in the packed-refs file, while excluding refs that
   match certain patterns, has been optimized.

 * Mark-up unused parameters in the code so that we can eventually
   enable -Wunused-parameter by default.

 * Instead of inventing a custom counter variables for debugging,
   use existing trace2 facility in the fsync customization codepath.

 * "git branch --list --format=3D<format>" and friends are taught
   a new "%(describe)" placeholder.

 * Clarify how to choose the starting point for a new topic in
   developer guidance document.

 * The implementation of "get_sha1_hex()" that reads a hexadecimal
   string that spells a full object name has been extended to cope
   with any hash function used in the repository, but the "sha1" in
   its name survived.  Rename it to get_hash_hex(), a name that is
   more consistent within its friends like get_hash_hex_algop().

 * Command line parser fix, and a small parse-options API update.


Fixes since v2.41
-----------------

 * "git tag" learned to leave the "$GIT_DIR/TAG_EDITMSG" file when the
   command failed, so that the user can salvage what they typed.
   (merge 08c12ec1d0 kh/keep-tag-editmsg-upon-failure later to maint).

 * The "-s" (silent, squelch) option of the "diff" family of commands
   did not interact with other options that specify the output format
   well.  This has been cleaned up so that it will clear all the
   formatting options given before.
   (merge 9d484b92ed jc/diff-s-with-other-options later to maint).

 * Update documentation regarding Coccinelle patches.
   (merge 3bd0097cfc gc/doc-cocci-updates later to maint).

 * Some atoms that can be used in "--format=3D<format>" for "git ls-tree"
   were not supported by "git ls-files", even though they were relevant
   in the context of the latter.
   (merge 4d28c4f75f zh/ls-files-format-atoms later to maint).

 * Document more pseudo-refs and teach the command line completion
   machinery to complete AUTO_MERGE.
   (merge 982ff3a649 pb/complete-and-document-auto-merge-and-friends late=
r to maint).

 * "git submodule" code trusted the data coming from the config (and
   the in-tree .gitmodules file) too much without validating, leading
   to NULL dereference if the user mucks with a repository (e.g.
   submodule.<name>.url is removed).  This has been corrected.
   (merge fbc806acd1 tb/submodule-null-deref-fix later to maint).

 * The value of config.worktree is per-repository, but has been kept
   in a singleton global variable per process. This has been OK as
   most Git operations interacted with a single repository at a time,
   but not right for operations like recursive "grep" that want to
   access multiple repositories from a single process without forking.

   The global variable has been eliminated and made into a member in
   the per-repository data structure.
   (merge 3867f6d650 vd/worktree-config-is-per-repository later to maint)=
.

 * "git [-c log.follow=3Dtrue] log [--follow] ':(glob)f**'" used to barf.
   (merge 8260bc5902 jk/log-follow-with-non-literal-pathspec later to mai=
nt).

 * Introduce a mechanism to disable replace refs globally and per
   repository.
   (merge 9c7d1b057f ds/disable-replace-refs later to maint).

 * "git cat-file --batch" and friends learned "-Z" that uses NUL
   delimiter for both input and output.
   (merge f79e18849b ps/cat-file-null-output later to maint).

 * The reimplemented "git add -i" did not honor color.ui configuration.
   (merge 6f74648cea ds/add-i-color-configuration-fix later to maint).

 * Compilation fix for platforms without D_TYPE in struct dirent.
   (merge 03bf92b9bf as/dtype-compilation-fix later to maint).

 * Suggest to refrain from using hex literals that are non-portable
   when writing printf(1) format strings.
   (merge f0b68f0546 jt/doc-use-octal-with-printf later to maint).

 * Simplify error message when run-command fails to start a command.
   (merge 6d224ac286 rs/run-command-exec-error-on-noent later to maint).

 * Gracefully deal with a stale MIDX file that lists a packfile that
   no longer exists.
   (merge 06f3867865 tb/open-midx-bitmap-fallback later to maint).

 * Even when diff.ignoreSubmodules tells us to ignore submodule
   changes, "git commit" with an index that already records changes to
   submodules should include the submodule changes in the resulting
   commit, but it did not.
   (merge 5768478edc js/defeat-ignore-submodules-config-with-explicit-add=
ition later to maint).

 * When "git commit --trailer=3D..." invokes the interpret-trailers
   machinery, it knows what it feeds to interpret-trailers is a full
   log message without any patch, but failed to express that by
   passing the "--no-divider" option, which has been corrected.
   (merge be3d654343 jk/commit-use-no-divider-with-interpret-trailers lat=
er to maint).

 * Avoid breakage of "git pack-objects --cruft" due to inconsistency
   between the way the code enumerates packfiles in the repository.
   (merge 73320e49ad tb/collect-pack-filenames-fix later to maint).

 * We create .pack and then .idx, we consider only packfiles that have
   .idx usable (those with only .pack are not ready yet), so we should
   remove .idx before removing .pack for consistency.
   (merge 0dd1324a73 ds/remove-idx-before-pack later to maint).

 * Partially revert a sanity check that the rest of the config code
   was not ready, to avoid triggering it in a corner case.
   (merge a53f43f900 gc/config-partial-submodule-kvi-fix later to maint).

 * "git apply" punts when it is fed too large a patch input; the error
   message it gives when it happens has been clarified.
   (merge 42612e18d2 pw/apply-too-large later to maint).

 * During a cherry-pick or revert session that works on multiple
   commits, "git status" did not give correct information, which has
   been corrected.
   (merge a096a889f4 jk/cherry-pick-revert-status later to maint).

 * A few places failed to differentiate the case where the index is
   truly empty (nothing added) and we haven't yet read from the
   on-disk index file, which have been corrected.
   (merge 2ee045eea1 js/empty-index-fixes later to maint).

 * "git bugreport" tests did not test what it wanted to test, which
   has been corrected.
   (merge 1aa92b8500 ma/t0091-fixup later to maint).

 * Code snippets in a tutorial document no longer compiled after
   recent header shuffling, which have been corrected.
   (merge bbd7c7b7c0 vd/adjust-mfow-doc-to-updated-headers later to maint=
).

 * "git ls-files '(attr:X)D/'" that triggers the common prefix
   optimization codepath failed to read from "D/.gitattributes",
   which has been corrected.
   (merge f4a8fde057 jc/pathspec-match-with-common-prefix later to maint)=
.

 * "git fsck --no-progress" still spewed noise from the commit-graph
   subsystem, which has been corrected.
   (merge 9281cd07f0 tb/fsck-no-progress later to maint).

 * Various offset computation in the code that accesses the packfiles
   and other data in the object layer has been hardened against
   arithmetic overflow, especially on 32-bit systems.
   (merge 9a25cad7e0 tb/object-access-overflow-protection later to maint)=
.

 * Names of MinGW header files are spelled in mixed case in some
   source files, but the build host can be using case sensitive
   filesystem with header files with their name spelled in all
   lowercase.
   (merge 4a53d0d0bc mh/mingw-case-sensitive-build later to maint).

 * Update message mark-up for i18n in "git bundle".
   (merge bbb6acd998 dk/bundle-i18n-more later to maint).

 * "git tag --list --points-at X" showed tags that directly refers to
   object X, but did not list a tag that points at such a tag, which
   has been corrected.

 * "./configure --with-expat=3Dno" did not work as a way to refuse use
   of the expat library on a system with the library installed, which
   has been corrected.
   (merge fb8f7269c2 ah/autoconf-fixes later to maint).

 * When the user edits "rebase -i" todo file so that it starts with a
   "fixup", which would make it invalid, the command truncated the
   rest of the file before giving an error and returning the control
   back to the user.  Stop truncating to make it easier to correct
   such a malformed todo file.
   (merge 9645a087c2 ah/sequencer-rewrite-todo-fix later to maint).

 * Rewrite the description of giving a custom command to the
   submodule.<name>.update configuration variable.
   (merge 7cebc5bd78 pv/doc-submodule-update-settings later to maint).

 * Other code cleanup, docfix, build fix, etc.
   (merge 51f9d2e563 sa/doc-ls-remote later to maint).
   (merge c6d26a9dda jk/format-patch-message-id-unleak later to maint).
   (merge f7e063f326 ps/fetch-cleanups later to maint).
   (merge e4cf013468 tl/quote-problematic-arg-for-clarity later to maint)=
.
   (merge 20025fdfc7 tz/test-ssh-verifytime-fix later to maint).
   (merge e48a21df65 tz/test-fix-pthreads-prereq later to maint).
   (merge 68b51172e3 mh/commit-reach-get-reachable-plug-leak later to mai=
nt).
   (merge aeee1408ce kh/use-default-notes-doc later to maint).
   (merge 3b8724bce6 jc/test-modernization later to maint).
   (merge 447a3b7331 jc/test-modernization-2 later to maint).
   (merge d57fa7fc73 la/doc-interpret-trailers later to maint).
   (merge 548afb0d9a la/docs-typofixes later to maint).
   (merge 3744ffcbcd rs/doc-ls-tree-hex-literal later to maint).
   (merge 6c26da8404 mh/credential-erase-improvements later to maint).
   (merge 78e56cff69 tz/lib-gpg-prereq-fix later to maint).
   (merge 80d32e84b5 rj/leakfixes later to maint).
   (merge 0a868031ed pb/complete-diff-options later to maint).
   (merge d4f28279ad jc/doc-hash-object-types later to maint).
   (merge 1876a5ae15 ks/t4205-test-describe-with-abbrev-fix later to main=
t).
   (merge 6e6a529b57 jk/fsck-indices-in-worktrees later to maint).
   (merge 3e81b896f7 rs/packet-length-simplify later to maint).
   (merge 4c9cb51fe7 mh/doc-credential-helpers later to maint).
   (merge 3437f549dd jr/gitignore-doc-example-markup later to maint).
   (merge 947ebd62a0 jc/am-parseopt-fix later to maint).
   (merge e12cb98e1e jc/branch-parseopt-fix later to maint).
   (merge d6f598e443 jc/gitignore-doc-pattern-markup later to maint).
   (merge a2dad4868b jc/transport-parseopt-fix later to maint).
   (merge 68cbb20e73 jc/parse-options-show-branch later to maint).
   (merge 3821eb6c3d jc/parse-options-reset later to maint).
   (merge c48af99a3e bb/trace2-comment-fix later to maint).
   (merge c95ae3ff9c rs/describe-parseopt-fix later to maint).
   (merge 36f76d2a25 rs/pack-objects-parseopt-fix later to maint).
   (merge 30c8c55cbf jc/tree-walk-drop-base-offset later to maint).

----------------------------------------------------------------

Changes since v2.41.0 are as follows:

Alejandro R. Sede=C3=B1o (1):
      statinfo.h: move DTYPE defines from dir.h

Alex Henrie (4):
      wt-status: don't show divergence advice when committing
      remote: don't imply that integration is always required before push=
ing
      push: don't imply that integration is always required before pushin=
g
      sequencer: finish parsing the todo list despite an invalid first li=
ne

Andreas Herrmann (3):
      configure.ac: don't overwrite NO_EXPAT option
      configure.ac: don't overwrite NO_CURL option
      configure.ac: always save NO_ICONV to config.status

Beat Bolli (2):
      trace2: fix a comment
      wrapper: use trace2 counters to collect fsync stats

Calvin Wan (13):
      strbuf: clarify API boundary
      strbuf: clarify dependency
      abspath: move related functions to abspath
      credential-store: move related functions to credential-store file
      object-name: move related functions to object-name
      path: move related function to path
      strbuf: remove global variable
      git-compat-util: move strbuf.c funcs to its header
      git-compat-util: move wrapper.c funcs to its header
      sane-ctype.h: create header for sane-ctype macros
      kwset: move translation table from ctype
      treewide: remove unnecessary includes for wrapper.h
      git-compat-util: move alloc macros to git-compat-util.h

D. Ben Knoble (2):
      i18n: mark more bundle.c strings for translation
      t4002: fix "diff can read from stdin" syntax

Derrick Stolee (7):
      add: check color.ui for interactive add
      add: test use of brackets when color is disabled
      repository: create disable_replace_refs()
      replace-objects: create wrapper around setting
      repository: create read_replace_refs setting
      packfile: delete .idx files before .pack files
      builtin/repack.c: only repack `.pack`s that exist

Elijah Newren (28):
      init-db: document existing bug with core.bare in template config
      init-db: remove unnecessary global variable
      init-db, clone: change unnecessary global into passed parameter
      setup: adopt shared init-db & clone code
      read-cache: move shared commit and ls-files code
      add: modify add_files_to_cache() to avoid globals
      read-cache: move shared add/checkout/commit code
      statinfo: move stat_{data,validity} functions from cache/read-cache
      run-command.h: move declarations for run-command.c from cache.h
      name-hash.h: move declarations for name-hash.c from cache.h
      sparse-index.h: move declarations for sparse-index.c from cache.h
      preload-index.h: move declarations for preload-index.c from elsewhe=
re
      diff.h: move declaration for global in diff.c from cache.h
      merge.h: move declarations for merge.c from cache.h
      repository.h: move declaration of the_index from cache.h
      read-cache*.h: move declarations for read-cache.c functions from ca=
che.h
      cache.h: remove this no-longer-used header
      log-tree: replace include of revision.h with simple forward declara=
tion
      repository: remove unnecessary include of path.h
      diff.h: remove unnecessary include of oidset.h
      list-objects-filter-options.h: remove unneccessary include
      builtin.h: remove unneccessary includes
      git-compat-util.h: remove unneccessary include of wildmatch.h
      merge-ll: rename from ll-merge
      khash: name the structs that khash declares
      object-store-ll.h: split this header out of object-store.h
      hash-ll, hashmap: move oidhash() to hash-ll
      fsmonitor-ll.h: split this header out of fsmonitor.h

Eric Sunshine (1):
      fsck: avoid misleading variable name

Glen Choo (15):
      cocci: add headings to and reword README
      cocci: codify authoring and reviewing practices
      setup.c: don't setup in discover_git_directory()
      config: don't BUG when both kvi and source are set
      config: inline git_color_default_config
      urlmatch.h: use config_fn_t type
      config: add ctx arg to config_fn_t
      config.c: pass ctx in configsets
      config: pass ctx with config files
      config.c: pass ctx with CLI config
      trace2: plumb config kvi
      config: pass kvi to die_bad_number()
      config.c: remove config_reader from configsets
      config: add kvi.path, use it to evaluate includes
      config: pass source to config_parser_event_fn_t

Han Young (1):
      blame: allow --contents to work with bare repo

Jacob Abel (11):
      worktree add: include -B in usage docs
      t2400: cleanup created worktree in test
      t2400: refactor "worktree add" opt exclusion tests
      t2400: add tests to verify --quiet
      worktree add: add --orphan flag
      worktree add: introduce "try --orphan" hint
      worktree add: extend DWIM to infer --orphan
      worktree add: emit warn when there is a bad HEAD
      t2400: drop no-op `--sq` from rev-parse call
      builtin/worktree.c: convert tab in advice to space
      t2400: rewrite regex to avoid unintentional PCRE

Jacob Keller (1):
      fix cherry-pick/revert status when doing multiple commits

Jan Kl=C3=B6tzke (1):
      ref-filter: handle nested tags in --points-at option

Jeff King (36):
      format-patch: free rev.message_id when exiting
      format-patch: free elements of rev.ref_message_ids list
      pathspec: factor out magic-to-name function
      diff: factor out --follow pathspec check
      diff: detect pathspec magic not supported by --follow
      ci: use clang for ASan/UBSan checks
      ci: run ASan/UBSan in a single job
      ci: drop linux-clang job
      commit: pass --no-divider to interpret-trailers
      http: handle both "h2" and "h2h3" in curl info lines
      var: mark unused parameters in git_var callbacks
      imap-send: use server conf argument in setup_curl()
      imap-send: drop unused parameter from imap_cmd_cb callback
      imap-send: drop unused fields from imap_cmd_cb
      refs.c: rename `ref_filter`
      ref-filter.h: provide `REF_FILTER_INIT`
      ref-filter: clear reachable list pointers after freeing
      ref-filter: add `ref_filter_clear()`
      ref-filter.c: parameterize match functions over patterns
      test-ref-store: drop unimplemented reflog-expire command
      do_for_each_ref_helper(): mark unused repository parameter
      http: mark unused parameters in curl callbacks
      http-push: mark unused parameter in xml callback
      am: mark unused keep_cr parameters
      count-objects: mark unused parameter in alternates callback
      revisions: drop unused "opt" parameter in "tweak" callbacks
      fsck: mark unused parameters in various fsck callbacks
      merge-tree: mark unused parameter in traverse callback
      replace: mark unused parameter in ref callback
      replace: mark unused parameter in each_mergetag_fn callback
      rev-parse: mark unused parameter in for_each_abbrev callback
      tag: mark unused parameters in each_tag_name_fn callbacks
      t/helper: mark unused callback void data parameters
      ref-filter: avoid parsing tagged objects in match_points_at()
      ref-filter: avoid parsing non-tags in match_points_at()
      ref-filter: simplify return type of match_points_at

Johan Ruokangas (1):
      gitignore.txt: use backticks instead of double quotes

Johannes Schindelin (3):
      do_read_index(): always mark index as initialized unless erroring o=
ut
      split-index: accept that a base index can be empty
      commit -a -m: allow the top-level tree to become empty again

John Cai (34):
      docs: clarify git-pack-refs --all will pack all refs
      pack-refs: teach --exclude option to exclude refs from being packed
      pack-refs: teach pack-refs --include option
      t0000-basic: modernize test format
      t0030-stripspace: modernize test format
      t3210-pack-refs: modernize test format
      t1001-read-tree-m-2way: modernize test format
      t1002-read-tree-m-u-2way: modernize test format
      t1006-cat-file: modernize test format
      t3500-cherry: modernize test format
      t3700-add: modernize test format
      t3903-stash: modernize test format
      t4002-diff-basic: modernize test format
      t4003-diff-rename-1: modernize test format
      t4004-diff-rename-symlink: modernize test format
      t4202-log: modernize test format
      t4206-log-follow-harder-copies: modernize test format
      t5300-pack-object: modernize test format
      t5301-sliding-window: modernize test format
      t5303-pack-corruption-resilience: modernize test format
      t5306-pack-nobase: modernize test format
      t6050-replace: modernize test format
      t7101-reset-empty-subdirs: modernize test format
      t7110-reset-merge: modernize test format
      t7111-reset-table: modernize test format
      t7201-co: modernize test format
      t7508-status: modernize test format
      t7600-merge: modernize test format
      t7700-repack: modernize test format
      t9100-git-svn-basic: modernize test format
      t9104-git-svn-follow-parent: modernize test format
      t9200-git-cvsexportcommit: modernize test format
      t9400-git-cvsserver-server: modernize test format
      docs: add git hash-object -t option's possible values

Jonathan Tan (1):
      CodingGuidelines: use octal escapes, not hex

Josip Sokcevic (1):
      diff-lib: honor override_submodule_config flag bit

Junio C Hamano (44):
      diff: fix interaction between the "-s" option and other options
      show-branch doc: say <ref>, not <reference>
      Start the 2.42 cycle
      The second batch for 2.42
      The third batch
      ll-merge: killing the external merge driver aborts the merge
      The fourth batch
      t6406: skip "external merge driver getting killed by a signal" test=
 on Windows
      The fifth batch
      The sixth batch
      The seventh batch
      The eighth batch
      t6135: attr magic with path pattern
      tree-walk: lose base_offset that is never used in tree_entry_intere=
sting
      tree-walk: drop unused base_offset from do_match()
      The ninth batch
      dir: match "attr" pathspec magic with correct paths
      The tenth batch
      The eleventh batch
      The twelfth batch
      gitignore.txt: mark up explanation of patterns consistently
      am: simplify parsing of "--[no-]keep-cr"
      branch: reject "--no-all" and "--no-remotes" early
      parse-options: introduce OPT_IPVERSION()
      fetch: reject --no-ipv[46]
      show-branch: --no-sparse should give dense output
      short help: allow multi-line opthelp
      remote: simplify "remote add --tags" help text
      short help: allow a gap smaller than USAGE_GAP
      show-branch: reject --[no-](topo|date)-order
      reset: reject --no-(mixed|soft|hard|merge|keep) option
      The thirteenth batch
      branch: update the message to refuse touching a branch in-use
      hex: retire get_sha1_hex()
      The fourteenth batch
      SubmittingPatches: choice of base for fixing an older maintenance t=
rack
      The fifteenth batch
      SubmittingPatches: explain why 'next' and above are inappropriate b=
ase
      SubmittingPatches: use of older maintenance tracks is an exception
      The sixteenth batch
      MyFirstContribution: refrain from self-iterating too much
      The seventeenth batch
      The eighteenth batch
      Git 2.42-rc0

Kousik Sanagavarapu (5):
      t/lib-gpg: introduce new prereq GPG2
      ref-filter: add new "signature" atom
      t4205: correctly test %(describe:abbrev=3D...)
      ref-filter: add multiple-option parsing functions
      ref-filter: add new "describe" atom

Kristoffer Haugsbakk (5):
      doc: tag: document `TAG_EDITMSG`
      t/t7004-tag: add regression test for successful tag creation
      tag: keep the message file in case ref transaction fails
      notes: update documentation for `use_default_notes`
      notes: move the documentation to the struct

Linus Arver (15):
      docs: typofixes
      doc: trailer: fix grammar
      doc: trailer: swap verb order
      doc: trailer: drop "commit message part" phrasing
      doc: trailer: examples: avoid the word "message" by itself
      doc: trailer: remove redundant phrasing
      doc: trailer: use angle brackets for <token> and <value>
      doc: trailer.<token>.command: emphasize deprecation
      doc: trailer: mention 'key' in DESCRIPTION
      doc: trailer: add more examples in DESCRIPTION
      SubmittingPatches: reword awkward phrasing
      SubmittingPatches: discuss subsystems separately from git.git
      SubmittingPatches: de-emphasize branches as starting points
      SubmittingPatches: emphasize need to communicate non-default starti=
ng points
      SubmittingPatches: simplify guidance for choosing a starting point

M Hickford (3):
      credential: avoid erasing distinct password
      credential: erase all matching credentials
      doc: gitcredentials: link to helper list

Martin =C3=85gren (1):
      t0091-bugreport.sh: actually verify some content of report

Mike Hommey (2):
      commit-reach: fix memory leak in get_reachable_subset()
      mingw: use lowercase includes for some Windows headers

Patrick Steinhardt (17):
      fetch: drop unused DISPLAY_FORMAT_UNKNOWN enum value
      fetch: drop unneeded NULL-check for `remote_ref`
      fetch: pass through `fetch_config` directly
      fetch: use `fetch_config` to store "fetch.prune" value
      fetch: use `fetch_config` to store "fetch.pruneTags" value
      fetch: use `fetch_config` to store "fetch.showForcedUpdates" value
      fetch: use `fetch_config` to store "fetch.recurseSubmodules" value
      fetch: use `fetch_config` to store "fetch.parallel" value
      fetch: use `fetch_config` to store "submodule.fetchJobs" value
      t1006: don't strip timestamps from expected results
      t1006: modernize test style to use `test_cmp`
      strbuf: provide CRLF-aware helper to read until a specified delimit=
er
      cat-file: simplify reading from standard input
      cat-file: add option '-Z' that delimits input and output with NUL
      revision: reorder `read_revisions_from_stdin()`
      revision: small readability improvement for reading from stdin
      revision: handle pseudo-opts in `--stdin` mode

Petar Vutov (1):
      doc: highlight that .gitmodules does not support !command

Philippe Blain (30):
      revisions.txt: use description list for special refs
      revisions.txt: document more special refs
      completion: complete REVERT_HEAD and BISECT_HEAD
      git-merge.txt: modernize word choice in "True merge" section
      Documentation: document AUTO_MERGE
      completion: complete AUTO_MERGE
      completion: add comments describing __git_diff_* globals
      completion: complete --break-rewrites
      completion: complete --cc
      completion: complete --combined-all-paths
      completion: complete --compact-summary
      completion: complete --default-prefix
      completion: complete --find-copies
      completion: complete --find-object
      completion: complete --find-renames
      completion: complete --function-context
      completion: complete --ignore-matching-lines
      completion: complete --irreversible-delete
      completion: complete --ita-invisible-in-index and --ita-visible-in-=
index
      completion: complete --line-prefix
      completion: complete --no-relative
      completion: complete --no-stat
      completion: complete --output
      completion: complete --output-indicator-{context,new,old}
      completion: complete --unified
      completion: complete --ws-error-highlight
      completion: move --pickaxe-{all,regex} to __git_diff_common_options
      completion: complete --diff-merges, its options and --no-diff-merge=
s
      completion: complete --remerge-diff
      diff.c: mention completion above add_diff_options

Phillip Wood (5):
      apply: improve error messages when reading patch
      diff --no-index: refuse to compare stdin to a directory
      diff --no-index: die on error reading stdin
      t4054: test diff --no-index with stdin
      diff --no-index: support reading from named pipes

Ren=C3=A9 Scharfe (18):
      t1800: loosen matching of error message for bad shebang
      run-command: report exec error even on ENOENT
      ls-tree: fix documentation of %x format placeholder
      pretty: factor out expand_separator()
      strbuf: factor out strbuf_expand_step()
      replace strbuf_expand_dict_cb() with strbuf_expand_step()
      replace strbuf_expand() with strbuf_expand_step()
      strbuf: simplify strbuf_expand_literal_cb()
      ls-tree: simplify prefix handling
      pretty: avoid double negative in format_commit_item()
      pkt-line: add size parameter to packet_length()
      pretty: use strchr(3) in userformat_find_requirements()
      t6300: fix setup with GPGSSH but without GPG
      strbuf: use skip_prefix() in strbuf_addftime()
      ls-tree: fix --no-full-name
      describe: fix --no-exact-match
      pack-objects: fix --no-keep-true-parents
      pack-objects: fix --no-quiet

Rub=C3=A9n Justo (11):
      config: fix a leak in git_config_copy_or_rename_section_in_file
      remote: fix a leak in query_matches_negative_refspec
      branch: fix a leak in dwim_and_setup_tracking
      branch: fix a leak in inherit_tracking
      branch: fix a leak in check_tracking_branch
      branch: fix a leak in setup_tracking
      rev-parse: fix a leak with --abbrev-ref
      branch: fix a leak in setup_tracking
      branch: fix a leak in cmd_branch
      config: fix a leak in git_config_copy_or_rename_section_in_file
      tests: mark as passing with SANITIZE=3Dleak

Sean Allred (5):
      show-ref doc: update for internal consistency
      ls-remote doc: remove redundant --tags example
      ls-remote doc: show peeled tags in examples
      ls-remote doc: explain what each example does
      ls-remote doc: document the output format

Shuqi Liang (2):
      diff-tree: integrate with sparse index
      worktree: integrate with sparse-index

Taylor Blau (48):
      object: add object_array initializer helper function
      pack-bitmap.c: extract `fill_in_bitmap()`
      pack-bitmap.c: use commit boundary during bitmap traversal
      builtin/submodule--helper.c: handle missing submodule URLs
      builtin/repack.c: only collect fully-formed packs
      reachable.c: extract `obj_is_recent()`
      gc: introduce `gc.recentObjectsHook`
      pack-bitmap.c: gracefully degrade on failure to load MIDX'd pack
      t7701: make annotated tag unreachable
      fsck: suppress commit-graph output with `--no-progress`
      fsck: suppress MIDX output with `--no-progress`
      commit-graph.c: extract `verify_one_commit_graph()`
      commit-graph.c: iteratively verify commit-graph chains
      commit-graph.c: pass progress to `verify_one_commit_graph()`
      commit-graph.c: avoid duplicated progress output during `verify`
      builtin/for-each-ref.c: add `--exclude` option
      refs: plumb `exclude_patterns` argument throughout
      refs/packed-backend.c: refactor `find_reference_location()`
      refs/packed-backend.c: implement jump lists to avoid excluded patte=
rn(s)
      refs/packed-backend.c: add trace2 counters for jump list
      revision.h: store hidden refs in a `strvec`
      refs.h: let `for_each_namespaced_ref()` take excluded patterns
      refs.h: implement `hidden_refs_to_excludes()`
      builtin/receive-pack.c: avoid enumerating hidden references
      upload-pack.c: avoid enumerating hidden refs where possible
      ls-refs.c: avoid enumerating hidden refs where possible
      builtin/repack.c: avoid dir traversal in `collect_pack_filenames()`
      packfile.c: prevent overflow in `nth_packed_object_id()`
      packfile.c: prevent overflow in `load_idx()`
      packfile.c: use checked arithmetic in `nth_packed_object_offset()`
      midx.c: use `size_t`'s for fanout nr and alloc
      midx.c: prevent overflow in `nth_midxed_object_oid()`
      midx.c: prevent overflow in `nth_midxed_offset()`
      midx.c: store `nr`, `alloc` variables as `size_t`'s
      midx.c: prevent overflow in `write_midx_internal()`
      midx.c: prevent overflow in `fill_included_packs_batch()`
      pack-bitmap.c: ensure that eindex lookups don't overflow
      commit-graph.c: prevent overflow in `write_commit_graph_file()`
      commit-graph.c: prevent overflow in add_graph_to_chain()
      commit-graph.c: prevent overflow in `load_oid_from_graph()`
      commit-graph.c: prevent overflow in `fill_commit_graph_info()`
      commit-graph.c: prevent overflow in `fill_commit_in_graph()`
      commit-graph.c: prevent overflow in `load_tree_for_commit()`
      commit-graph.c: prevent overflow in `split_graph_merge_strategy()`
      commit-graph.c: prevent overflow in `merge_commit_graph()`
      commit-graph.c: prevent overflow in `write_commit_graph()`
      commit-graph.c: prevent overflow in `verify_commit_graph()`
      Documentation/RelNotes/2.42.0.txt: typofix

Teng Long (8):
      surround %s with quotes when failed to lookup commit
      notes.c: cleanup 'strbuf_grow' call in 'append_edit'
      notes.c: use designated initializers for clarity
      t3321: add test cases about the notes stripspace behavior
      notes.c: introduce '--separator=3D<paragraph-break>' option
      notes.c: append separator instead of insert by pos
      notes.c: introduce "--[no-]stripspace" option
      notes: introduce "--no-separator" option

Todd Zullinger (3):
      trace2 tests: fix PTHREADS prereq
      t/lib-gpg: fix ssh-keygen -Y check-novalidate with openssh-9.0
      t/lib-gpg: require GPGSSH for GPGSSH_VERIFYTIME prereq

Victoria Dye (3):
      config: use gitdir to get worktree config
      config: pass 'repo' directly to 'config_with_options()'
      repository: move 'repository_format_worktree_config' to repo scope

Vinayak Dev (1):
      docs: add necessary headers to Documentation/MFOW.txt

ZheNing Hu (1):
      ls-files: align format atoms with ls-tree

brian m. carlson (7):
      t: add a function to check executable bit
      var: add support for listing the shell
      var: format variable structure with C99 initializers
      var: adjust memory allocation for strings
      attr: expose and rename accessor functions
      var: add attributes files locations
      var: add config file locations

