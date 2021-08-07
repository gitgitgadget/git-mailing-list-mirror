Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0DBC4338F
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 00:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB74061040
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 00:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhHGAHq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 20:07:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62550 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhHGAHo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 20:07:44 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A1A40D69B8;
        Fri,  6 Aug 2021 20:07:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=Ad+yub6+H8QJhGjT9vw0stwx7
        LTkJqAmu706w1MFZT8=; b=PM+ktqoGHegc1SCrp7d5QBmO4u3aFd2GiHEn8stmQ
        wcX7EctC151/SDMZMQdDoEfCFqXhRwYAULcrjm8q9X/aW4Upf9e/BcyFkju72aK9
        OfEBDzAq9ckQOr3ocVVy5JWOPKGeMM1ucGuAv0z+6n8UqTdg2g07l/x0JdoojxST
        S0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 84947D69B6;
        Fri,  6 Aug 2021 20:07:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CCC3FD69B4;
        Fri,  6 Aug 2021 20:07:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.33.0-rc1
Date:   Fri, 06 Aug 2021 17:07:23 -0700
Message-ID: <xmqq5ywigls4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 72461C6A-F713-11EB-BC2B-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A release candidate Git v2.33.0-rc1 is now available for testing at
the usual places.  It is comprised of 396 non-merge commits since
v2.32.0, contributed by 63 people, 19 of which are new faces [*].

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/testing/

The following public repositories all have a copy of the
'v2.33.0-rc1' tag and the 'master' branch that the tag points at:

  url =3D https://git.kernel.org/pub/scm/git/git
  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://github.com/gitster/git

New contributors whose contributions weren't in v2.32.0 are as follows.
Welcome to the Git development community!

  Anders H=C3=B6ckersten, Andrew Berry, Andy AO, Beshr Kayali,
  dorgon.chang, edef, Fabian Stelzer, Fabian Wermelinger, Gregory
  Anders, Greg Pflaum, Hu Jialun, Jason Hatton, Julian Verdurmen,
  Matthew Hughes, Michael Schindler, Reuven Y, Stephen Manz,
  Tao Klerks, and Teng Long.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason, Alex Henrie, Anders Kaseorg,
  Andrei Rybak, Andrzej Hunt, Atharva Raykar, Bagas Sanjaya,
  brian m. carlson, Carlo Marcelo Arenas Bel=C3=B3n, Christian Couder,
  Dennis Ameling, Denton Liu, Derrick Stolee, =C4=90o=C3=A0n Tr=E1=BA=A7n=
 C=C3=B4ng
  Danh, Elijah Newren, Emily Shaffer, Eric Sunshine, Eric Wong,
  Felipe Contreras, Han-Wen Nienhuys, Jean-No=C3=ABl Avila, Jeff King,
  Jiang Xin, Johannes Schindelin, Jonathan Nieder, Jonathan Tan,
  Josh Steadmon, Junio C Hamano, Kaartic Sivaraam, Martin =C3=85gren,
  Matheus Tavares, Matthew Rogers, Matthias A=C3=9Fhauer, Nicolas
  Pitre, Patrick Steinhardt, Philippe Blain, Ren=C3=A9 Scharfe,
  Sergey Organov, Shourya Shukla, Taylor Blau, Thomas B=C3=A9tous,
  Thomas Braun, Wolfgang M=C3=BCller, and ZheNing Hu.

[*] We are counting not just the authorship contribution but issue
    reporting, mentoring, helping and reviewing that are recorded in
    the commit trailers.

----------------------------------------------------------------

Git 2.33 Release Notes (draft)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Backward compatibility notes
----------------------------

 * The "-m" option in "git log -m" that does not specify which format,
   if any, of diff is desired did not have any visible effect; it now
   implies some form of diff (by default "--patch") is produced.

   You can disable the diff output with "git log -m --no-patch", but
   then there probably isn't much point in passing "-m" in the first
   place ;-).


Updates since Git 2.32
----------------------

UI, Workflows & Features

 * "git send-email" learned the "--sendmail-cmd" command line option
   and the "sendemail.sendmailCmd" configuration variable, which is a
   more sensible approach than the current way of repurposing the
   "smtp-server" that is meant to name the server to instead name the
   command to talk to the server.

 * The "-m" option in "git log -m" that does not specify which format,
   if any, of diff is desired did not have any visible effect; it now
   implies some form of diff (by default "--patch") is produced.

 * The userdiff pattern for C# learned the token "record".

 * "git rev-list" learns to omit the "commit <object-name>" header
   lines from the output with the `--no-commit-header` option.

 * "git worktree add --lock" learned to record why the worktree is
   locked with a custom message.


Performance, Internal Implementation, Development Support etc.

 * The code to handle the "--format" option in "for-each-ref" and
   friends made too many string comparisons on %(atom)s used in the
   format string, which has been corrected by converting them into
   enum when the format string is parsed.

 * Use the hashfile API in the codepath that writes the index file to
   reduce code duplication.

 * Repeated rename detections in a sequence of mergy operations have
   been optimized out for the 'ort' merge strategy.

 * Preliminary clean-up of tests before the main reftable changes
   hits the codebase.

 * The backend for "diff -G/-S" has been updated to use pcre2 engine
   when available.

 * Use ".DELETE_ON_ERROR" pseudo target to simplify our Makefile.

 * Code cleanup around struct_type_init() functions.

 * "git send-email" optimization.

 * GitHub Actions / CI update.
   (merge 0dc787a9f2 js/ci-windows-update later to maint).

 * Object accesses in repositories with many alternate object store
   have been optimized.

 * "git log" has been optimized not to waste cycles to load ref
   decoration data that may not be needed.

 * Many "printf"-like helper functions we have have been annotated
   with __attribute__() to catch placeholder/parameter mismatches.

 * Tests that cover protocol bits have been updated and helpers
   used there have been consolidated.

 * The CI gained a new job to run "make sparse" check.

 * "git status" codepath learned to work with sparsely populated index
   without hydrating it fully.

 * A guideline for gender neutral documentation has been added.

 * Documentation on "git diff -l<n>" and diff.renameLimit have been
   updated, and the defaults for these limits have been raised.

 * The completion support used to offer alternate spelling of options
   that exist only for compatibility, which has been corrected.

 * "TEST_OUTPUT_DIRECTORY=3Dthere make test" failed to work, which has
   been corrected.

 * "git bundle" gained more test coverage.

 * "git read-tree" had a codepath where blobs are fetched one-by-one
   from the promisor remote, which has been corrected to fetch in bulk.

 * Rewrite of "git submodule" in C continues.

 * "git checkout" and "git commit" learn to work without unnecessarily
   expanding sparse indexes.


Fixes since v2.32
-----------------

 * We historically rejected a very short string as an author name
   while accepting a patch e-mail, which has been loosened.
   (merge 72ee47ceeb ef/mailinfo-short-name later to maint).

 * The parallel checkout codepath did not initialize object ID field
   used to talk to the worker processes in a futureproof way.

 * Rewrite code that triggers undefined behaviour warning.
   (merge aafa5df0df jn/size-t-casted-to-off-t-fix later to maint).

 * The description of "fast-forward" in the glossary has been updated.
   (merge e22f2daed0 ry/clarify-fast-forward-in-glossary later to maint).

 * Recent "git clone" left a temporary directory behind when the
   transport layer returned an failure.
   (merge 6aacb7d861 jk/clone-clean-upon-transport-error later to maint).

 * "git fetch" over protocol v2 left its side of the socket open after
   it finished speaking, which unnecessarily wasted the resource on
   the other side.
   (merge ae1a7eefff jk/fetch-pack-v2-half-close-early later to maint).

 * The command line completion (in contrib/) learned that "git diff"
   takes the "--anchored" option.
   (merge d1e7c2cac9 tb/complete-diff-anchored later to maint).

 * "git-svn" tests assumed that "locale -a", which is used to pick an
   available UTF-8 locale, is available everywhere.  A knob has been
   introduced to allow testers to specify a suitable locale to use.
   (merge 482c962de4 dd/svn-test-wo-locale-a later to maint).

 * Update "git subtree" to work better on Windows.
   (merge 77f37de39f js/subtree-on-windows-fix later to maint).

 * Remove multimail from contrib/
   (merge f74d11471f js/no-more-multimail later to maint).

 * Make the codebase MSAN clean.
   (merge 4dbc55e87d ah/uninitialized-reads-fix later to maint).

 * Work around inefficient glob substitution in older versions of bash
   by rewriting parts of a test.
   (merge eb87c6f559 jx/t6020-with-older-bash later to maint).

 * Avoid duplicated work while building reachability bitmaps.
   (merge aa9ad6fee5 jk/bitmap-tree-optim later to maint).

 * We broke "GIT_SKIP_TESTS=3Dt?000" to skip certain tests in recent
   update, which got fixed.

 * The side-band demultiplexer that is used to display progress output
   from the remote end did not clear the line properly when the end of
   line hits at a packet boundary, which has been corrected.

 * Some test scripts assumed that readlink(1) was universally
   installed and available, which is not the case.
   (merge 7c0afdf23c jk/test-without-readlink-1 later to maint).

 * Recent update to completion script (in contrib/) broke those who
   use the __git_complete helper to define completion to their custom
   command.
   (merge cea232194d fw/complete-cmd-idx-fix later to maint).

 * Output from some of our tests were affected by the width of the
   terminal that they were run in, which has been corrected by
   exporting a fixed value in the COLUMNS environment.
   (merge c49a177bec ab/fix-columns-to-80-during-tests later to maint).

 * On Windows, mergetool has been taught to find kdiff3.exe just like
   it finds winmerge.exe.
   (merge 47eb4c6890 ms/mergetools-kdiff3-on-windows later to maint).

 * When we cannot figure out how wide the terminal is, we use a
   fallback value of 80 ourselves (which cannot be avoided), but when
   we run the pager, we export it in COLUMNS, which forces the pager
   to use the hardcoded value, even when the pager is perfectly
   capable to figure it out itself.  Stop exporting COLUMNS when we
   fall back on the hardcoded default value for our own use.
   (merge 9b6e2c8b98 js/stop-exporting-bogus-columns later to maint).

 * "git cat-file --batch-all-objects"" misbehaved when "--batch" is in
   use and did not ask for certain object traits.
   (merge ee02ac6164 zh/cat-file-batch-fix later to maint).

 * Some code and doc clarification around "git push".

 * The "union" conflict resultion variant misbehaved when used with
   binary merge driver.
   (merge 382b601acd jk/union-merge-binary later to maint).

 * Prevent "git p4" from failing to submit changes to binary file.
   (merge 54662d5958 dc/p4-binary-submit-fix later to maint).

 * "git grep --and -e foo" ought to have been diagnosed as an error
   but instead segfaulted, which has been corrected.
   (merge fe7fe62d8d rs/grep-parser-fix later to maint).

 * The merge code had funny interactions between content based rename
   detection and directory rename detection.
   (merge 3585d0ea23 en/merge-dir-rename-corner-case-fix later to maint).

 * When rebuilding the multi-pack index file reusing an existing one,
   we used to blindly trust the existing file and ended up carrying
   corrupted data into the updated file, which has been corrected.
   (merge f89ecf7988 tb/midx-use-checksum later to maint).

 * Update the location of system-side configuration file on Windows.
   (merge e355307692 js/gfw-system-config-loc-fix later to maint).

 * Code recently added to support common ancestry negotiation during
   "git push" did not sanity check its arguments carefully enough.
   (merge eff40457a4 ab/fetch-negotiate-segv-fix later to maint).

 * Update the documentation not to assume users are of certain gender
   and adds to guidelines to do so.
   (merge 46a237f42f ds/gender-neutral-doc later to maint).

 * "git commit --allow-empty-message" won't abort the operation upon
   an empty message, but the hint shown in the editor said otherwise.
   (merge 6f70f00b4f hj/commit-allow-empty-message later to maint).

 * The code that gives an error message in "git multi-pack-index" when
   no subcommand is given tried to print a NULL pointer as a strong,
   which has been corrected.
   (merge 88617d11f9 tb/reverse-midx later to maint).

 * CI update.
   (merge a066a90db6 js/ci-check-whitespace-updates later to maint).

 * Documentation fix for "git pull --rebase=3Dno".
   (merge d3236becec fc/pull-no-rebase-merges-theirs-into-ours later to m=
aint).

 * A race between repacking and using pack bitmaps has been corrected.
   (merge dc1daacdcc jk/check-pack-valid-before-opening-bitmap later to m=
aint).

 * The local changes stashed by "git merge --autostash" were lost when
   the merge failed in certain ways, which has been corrected.

 * Windows rmdir() equivalent behaves differently from POSIX ones in
   that when used on a symbolic link that points at a directory, the
   target directory gets removed, which has been corrected.
   (merge 3e7d4888e5 tb/mingw-rmdir-symlink-to-directory later to maint).

 * Other code cleanup, docfix, build fix, etc.
   (merge bfe35a6165 ah/doc-describe later to maint).
   (merge f302c1e4aa jc/clarify-revision-range later to maint).
   (merge 3127ff90ea tl/fix-packfile-uri-doc later to maint).
   (merge a84216c684 jk/doc-color-pager later to maint).
   (merge 4e0a64a713 ab/trace2-squelch-gcc-warning later to maint).
   (merge 225f7fa847 ps/rev-list-object-type-filter later to maint).
   (merge 5317dfeaed dd/honor-users-tar-in-tests later to maint).
   (merge ace6d8e3d6 tk/partial-clone-repack-doc later to maint).
   (merge 7ba68e0cf1 js/trace2-discard-event-docfix later to maint).
   (merge 8603c419d3 fc/doc-default-to-upstream-config later to maint).
   (merge 1d72b604ef jk/revision-squelch-gcc-warning later to maint).
   (merge abcb66c614 ar/typofix later to maint).
   (merge 9853830787 ah/graph-typofix later to maint).
   (merge aac578492d ab/config-hooks-path-testfix later to maint).
   (merge 98c7656a18 ar/more-typofix later to maint).
   (merge 6fb9195f6c jk/doc-max-pack-size later to maint).
   (merge 4184cbd635 ar/mailinfo-memcmp-to-skip-prefix later to maint).
   (merge 91d2347033 ar/doc-libera-chat-in-my-first-contrib later to main=
t).
   (merge 338abb0f04 ab/cmd-foo-should-return later to maint).
   (merge 546096a5cb ab/xdiff-bug-cleanup later to maint).
   (merge b7b793d1e7 ab/progress-cleanup later to maint).
   (merge d94f9b8e90 ba/object-info later to maint).
   (merge 52ff891c03 ar/test-code-cleanup later to maint).
   (merge a0538e5c8b dd/document-log-decorate-default later to maint).
   (merge ce24797d38 mr/cmake later to maint).
   (merge 9eb542f2ee ab/pre-auto-gc-hook-test later to maint).
   (merge 9fffc38583 bk/doc-commit-typofix later to maint).
   (merge 1cf823d8f0 ks/submodule-cleanup later to maint).
   (merge ebbf5d2b70 js/config-mak-windows-pcre-fix later to maint).
   (merge 617480d75b hn/refs-iterator-peel-returns-boolean later to maint=
).
   (merge 6a24cc71ed ar/submodule-helper-include-cleanup later to maint).
   (merge 5632e838f8 rs/khash-alloc-cleanup later to maint).
   (merge b1d87fbaf1 jk/typofix later to maint).
   (merge e04170697a ab/gitignore-discovery-doc later to maint).
   (merge 8232a0ff48 dl/packet-read-response-end-fix later to maint).
   (merge eb448631fb dl/diff-merge-base later to maint).
   (merge c510928a25 hn/refs-debug-empty-prefix later to maint).
   (merge ddcb189d9d tb/bitmap-type-filter-comment-fix later to maint).
   (merge 878b399734 pb/submodule-recurse-doc later to maint).
   (merge 734283855f jk/config-env-doc later to maint).
   (merge 482e1488a9 ab/getcwd-test later to maint).
   (merge f0b922473e ar/doc-markup-fix later to maint).

----------------------------------------------------------------

Changes since v2.32.0 are as follows:

Alex Henrie (6):
      merge: don't translate literal commands
      stash: don't translate literal commands
      submodule: use the imperative mood to describe the --files option
      fetch: improve grammar of "shallow roots" message
      setup: split "extensions found" messages into singular and plural
      graph: improve grammar of "invalid color" error message

Anders H=C3=B6ckersten (1):
      describe-doc: clarify default length of abbreviation

Andrei Rybak (8):
      t: fix whitespace around &&
      mailinfo: use starts_with() when checking scissors
      *: fix typos which duplicate a word
      blame: correct name of config option in docs
      t: fix typos in test messages
      git-worktree.txt: fix typo in example path
      help: convert git_cmd to page in one place
      Documentation: render special characters correctly

Andrew Berry (1):
      docs: .gitignore parsing is to the top of the repo

Andrzej Hunt (15):
      bulk-checkin: make buffer reuse more obvious and safer
      split-index: use oideq instead of memcmp to compare object_id's
      builtin/checkout--worker: zero-initialise struct to avoid MSAN comp=
laints
      fmt-merge-msg: free newly allocated temporary strings when done
      environment: move strbuf into block to plug leak
      builtin/submodule--helper: release unused strbuf to avoid leak
      builtin/for-each-repo: remove unnecessary argv copy to plug leak
      diffcore-rename: move old_dir/new_dir definition to plug leak
      ref-filter: also free head for ATOM_HEAD to avoid leak
      read-cache: call diff_setup_done to avoid leak
      convert: release strbuf to avoid leak
      builtin/mv: free or UNLEAK multiple pointers at end of cmd_mv
      builtin/merge: free found_ref when done
      builtin/rebase: fix options.strategy memory lifecycle
      reset: clear_unpack_trees_porcelain to plug leak

Atharva Raykar (6):
      MyFirstContribution: link #git-devel to Libera Chat
      submodule--helper: remove redundant include
      t7400: test failure to add submodule in tracked path
      submodule: prefix die messages with 'fatal'
      submodule--helper: refactor module_clone()
      submodule--helper: introduce add-clone subcommand

Bagas Sanjaya (1):
      diff: --pickaxe-all typofix

Beshr Kayali (1):
      Documentation: fix typo in the --patch option of the commit command

Carlo Marcelo Arenas Bel=C3=B3n (2):
      config.mak.uname: PCRE1 cleanup
      t7508: avoid non POSIX BRE

Dennis Ameling (2):
      cmake(windows): set correct path to the system Git config
      ci (vs-build): build with NO_GETTEXT

Denton Liu (2):
      pkt-line: replace "stateless separator" with "response end"
      git-diff: fix missing --merge-base docs

Derrick Stolee (28):
      hashfile: use write_in_full()
      csum-file.h: increase hashfile buffer size
      read-cache: use hashfile instead of git_hash_ctx
      read-cache: delete unused hashing methods
      *: fix typos
      sparse-index: skip indexes with unmerged entries
      sparse-index: include EXTENDED flag when expanding
      t1092: replace incorrect 'echo' with 'cat'
      t1092: expand repository data shape
      t1092: add tests for status/add and sparse files
      unpack-trees: preserve cache_bottom
      unpack-trees: compare sparse directories correctly
      unpack-trees: rename unpack_nondirectories()
      unpack-trees: unpack sparse directory entries
      dir.c: accept a directory as part of cone-mode patterns
      diff-lib: handle index diffs with sparse dirs
      status: skip sparse-checkout percentage with sparse-index
      status: use sparse-index throughout
      wt-status: expand added sparse directory entries
      fsmonitor: integrate with sparse index
      t1092: document bad sparse-checkout behavior
      p2000: add 'git checkout -' test and decrease depth
      p2000: compress repo names
      commit: integrate with sparse-index
      sparse-index: recompute cache-tree
      checkout: stop expanding sparse indexes
      t1092: document bad 'git checkout' behavior
      unpack-trees: resolve sparse-directory/file conflicts

Elijah Newren (36):
      t6423: rename file within directory that other side renamed
      Documentation/technical: describe remembering renames optimization
      fast-rebase: change assert() to BUG()
      fast-rebase: write conflict state to working tree, index, and HEAD
      t6429: testcases for remembering renames
      merge-ort: add data structures for in-memory caching of rename dete=
ction
      merge-ort: populate caches of rename detection results
      merge-ort: add code to check for whether cached renames can be reus=
ed
      merge-ort: avoid accidental API mis-use
      merge-ort: preserve cached renames for the appropriate side
      merge-ort: add helper functions for using cached renames
      merge-ort: handle interactions of caching and rename/rename(1to1) c=
ases
      merge-ort, diffcore-rename: employ cached renames when possible
      merge-ort: replace string_list_df_name_compare with faster alternat=
ive
      diffcore-rename: avoid unnecessary strdup'ing in break_idx
      Fix various issues found in comments
      merge-ort: miscellaneous touch-ups
      promisor-remote: output trace2 statistics for number of objects fet=
ched
      t6421: add tests checking for excessive object downloads during mer=
ge
      diffcore-rename: allow different missing_object_cb functions
      diffcore-rename: use a different prefetch for basename comparisons
      merge-ort: add prefetching for content merges
      t6423: test directory renames causing rename-to-self
      merge-ort: ensure we consult df_conflict and path_conflicts
      merge-recursive: handle rename-to-self case
      diff: correct warning message when renameLimit exceeded
      doc: clarify documentation for rename/copy limits
      diffcore-rename: treat a rename_limit of 0 as unlimited
      rename: bump limit defaults yet again
      merge-ort: resolve paths early when we have sufficient information
      merge-ort: add some more explanations in collect_merge_info_callbac=
k()
      merge-ort: add data structures for allowable trivial directory reso=
lves
      merge-ort: add a handle_deferred_entries() helper function
      merge-ort: defer recursing into directories when merge base is matc=
hed
      merge-ort: avoid recursing into directories when we don't need to
      merge-ort: restart merge with cached renames to reduce process entr=
y cost

Eric Wong (6):
      xmmap: inform Linux users of tuning knobs on ENOMEM
      speed up alt_odb_usable() with many alternates
      avoid strlen via strbuf_addstr in link_alt_odb_entry
      make object_directory.loose_objects_subdir_seen a bitmap
      oidcpy_with_padding: constify `src' arg
      oidtree: a crit-bit tree for odb_loose_cache

Fabian Wermelinger (1):
      completion: bash: fix late declaration of __git_cmd_idx

Felipe Contreras (33):
      doc: refactor common asciidoc dependencies
      doc: improve asciidoc dependencies
      doc: remove unnecessary rm instances
      doc: simplify Makefile using .DELETE_ON_ERROR
      doc: avoid using rm directly
      push: rename !triangular to same_remote
      push: hedge code of default=3Dsimple
      push: copy code to setup_push_simple()
      push: reorganize setup_push_simple()
      push: simplify setup_push_simple()
      push: remove unused code in setup_push_upstream()
      doc: push: explain default=3Dsimple correctly
      push: create new get_upstream_ref() helper
      push: return immediately in trivial switch case
      push: split switch cases
      push: factor out null branch check
      push: only get the branch when needed
      push: make setup_push_* return the dst
      push: trivial simplifications
      push: get rid of all the setup_push_* functions
      push: factor out the typical case
      push: remove redundant check
      push: remove trivial function
      push: only check same_remote when needed
      push: don't get a full remote object
      doc: merge: mention default of defaulttoupstream
      doc: avoid using the gender of other people
      comments: avoid using the gender of our users
      pull: cleanup autostash check
      pull: trivial cleanup
      pull: trivial whitespace style fix
      doc: pull: fix rebase=3Dfalse documentation
      test: fix for COLUMNS and bash 5

Gregory Anders (1):
      git-send-email: add option to specify sendmail command

Han-Wen Nienhuys (26):
      refs: make explicit that ref_iterator_peel returns boolean
      t4202: split testcase for invalid HEAD symref and HEAD hash
      t/helper/ref-store: initialize oid in resolve-ref
      t9300: check ref existence using test-helper rather than a file sys=
tem check
      t5601: read HEAD using rev-parse
      t1401: use tar to snapshot and restore repo state
      t1401-symbolic-ref: avoid direct filesystem access
      t1413: use tar to save and restore entire .git directory
      t1301: fix typo in error message
      t5000: reformat indentation to the latest fashion
      t5000: inspect HEAD using git-rev-parse
      t7003: use rev-parse rather than FS inspection
      t5304: restyle: trim empty lines, drop ':' before >
      t5304: use "reflog expire --all" to clear the reflog
      test-lib: provide test prereq REFFILES
      t1407: require REFFILES for for_each_reflog test
      t1414: mark corruption test with REFFILES
      t2017: mark --orphan/logAllRefUpdates=3Dfalse test as REFFILES
      t1404: mark tests that muck with .git directly as REFFILES.
      t7900: stop checking for loose refs
      t7003: check reflog existence only for REFFILES
      t4202: mark bogus head hash test with REFFILES
      t1415: set REFFILES for test specific to storage format
      t1415: avoid direct filesystem access for writing refs
      t7509: avoid direct file access for writing CHERRY_PICK_HEAD
      refs/debug: quote prefix

Hu Jialun (2):
      commit: reorganise commit hint strings
      commit: remove irrelavent prompt on `--allow-empty-message`

Jean-No=C3=ABl Avila (1):
      help: fix small typo in error message

Jeff King (27):
      clone: clean up directory after transport_fetch_refs() failure
      fetch-pack: signal v2 server that we are done making requests
      doc: explain the use of color.pager
      doc: warn people against --max-pack-size
      ll_binary_merge(): handle XDL_MERGE_FAVOR_UNION
      ll_union_merge(): pass name labels to ll_xdl_merge()
      ll_union_merge(): rename path_unused parameter
      add_pending_object_with_path(): work around "gcc -O3" complaint
      bitmaps: don't recurse into trees already in the bitmap
      t: use portable wrapper for readlink(1)
      pretty.h: update and expand docstring for userformat_find_requireme=
nts()
      log: avoid loading decorations for userformats that don't need it
      object.h: expand docstring for lookup_unknown_object()
      object.h: add lookup_object_by_type() function
      load_ref_decorations(): avoid parsing non-tag objects
      add_ref_decoration(): rename s/type/deco_type/
      test-lib: avoid accidental globbing in match_pattern_list()
      doc/rev-list-options: fix duplicate word typo
      load_ref_decorations(): fix decoration with tags
      t0000: clear GIT_SKIP_TESTS before running sub-tests
      doc/git-config: explain --file instead of referring to GIT_CONFIG
      doc/git-config: clarify GIT_CONFIG environment variable
      doc/git-config: simplify "override" advice for FILES section
      pack-bitmap: check pack validity when opening bitmap
      submodule: drop unused sm_name parameter from show_fetch_remotes()
      ci: run "apt-get update" before "apt-get install"
      ci/install-dependencies: handle "sparse" job package installs

Jiang Xin (5):
      t6020: fix incompatible parameter expansion
      sideband: don't lose clear-to-eol at packet boundary
      test: compare raw output, not mangle tabs and spaces
      test: refactor to use "test_commit" to create commits
      test: refactor to use "get_abbrev_oid" to get abbrev oid

Johannes Schindelin (15):
      multimail: stop shipping a copy
      subtree: fix the GIT_EXEC_PATH sanity check to work on Windows
      subtree: fix assumption about the directory separator
      pager: avoid setting COLUMNS when we're guessing its value
      mingw: move Git for Windows' system config where users expect it
      config: normalize the path of the system gitconfig
      ci: use the new GitHub Action to download git-sdk-64-minimal
      ci (vs-build): use `cmd` to copy the DLLs, not `powershell`
      ci: upgrade to using actions/{up,down}load-artifacts v2
      ci (windows): transfer also the Git-tracked files to the test jobs
      artifacts-tar: respect NO_GETTEXT
      ci: accelerate the checkout
      ci: run `make sparse` as part of the GitHub workflow
      ci(check-whitespace): stop requiring a read/write token
      ci(check-whitespace): restrict to the intended commits

Jonathan Nieder (1):
      xsize_t: avoid implementation defined behavior when len < 0

Jonathan Tan (7):
      repository: move global r_f_p_c to repo struct
      promisor-remote: support per-repository config
      submodule: refrain from filtering GIT_CONFIG_COUNT
      run-command: refactor subprocess env preparation
      promisor-remote: teach lazy-fetch in any repo
      unpack-trees: refactor prefetching code
      cache-tree: prefetch in partial clone read-tree

Josh Steadmon (1):
      docs: fix api-trace2 doc for "too_many_files" event

Julian Verdurmen (1):
      userdiff: add support for C# record types

Junio C Hamano (12):
      revisions(7): clarify that most commands take a single revision ran=
ge
      The first batch post Git 2.32
      The second batch
      The third batch
      The fourth batch
      CodingGuidelines: recommend gender-neutral description
      The fifth batch
      The sixth batch
      The seventh batch
      Git 2.33-rc0
      The eighth batch
      Git 2.33-rc1

Kaartic Sivaraam (1):
      submodule: remove unnecessary `prefix` based option logic

Matheus Tavares (1):
      parallel-checkout: send the new object_id algo field to the workers

Matthew Rogers (3):
      cmake: add knob to disable vcpkg
      cmake: create compile_commands.json by default
      cmake: add warning for ignored MSGFMT_EXE

Michael Schindler (1):
      mergetools/kdiff3: make kdiff3 work on Windows too

Patrick Steinhardt (2):
      perf: fix when running with TEST_OUTPUT_DIRECTORY
      t0000: fix test if run with TEST_OUTPUT_DIRECTORY

Philippe Blain (6):
      parse-options: don't complete option aliases by default
      doc: clarify description of 'submodule.recurse'
      merge: add missing word "strategy" to a message
      Documentation: define 'MERGE_AUTOSTASH'
      merge: apply autostash if fast-forward fails
      merge: apply autostash if merge strategy fails

Ren=C3=A9 Scharfe (3):
      grep: report missing left operand of --and
      khash: clarify that allocations never fail
      use fspathhash() everywhere

Reuven Y (1):
      docs: improve fast-forward in glossary content

Sergey Organov (10):
      t4013: test that "-m" alone has no effect in "git log"
      t4013: test "git log -m --raw"
      t4013: test "git log -m --stat"
      t4013: test "git diff-tree -m"
      t4013: test "git diff-index -m"
      diff-merges: move specific diff-index "-m" handling to diff-index
      git-svn: stop passing "-m" to "git rev-list"
      stash list: stop passing "-m" to "git log"
      diff-merges: rename "combined_imply_patch" to "merges_imply_patch"
      diff-merges: let "-m" imply "-p"

Stephen Manz (3):
      t2400: clean up '"add" worktree with lock' test
      worktree: mark lock strings with `_()` for translation
      worktree: teach `add` to accept --reason <string> with --lock

Tao Klerks (1):
      Remove warning that repack only works on non-promisor packfiles

Taylor Blau (6):
      csum-file: introduce checksum_valid()
      commit-graph: rewrite to use checksum_valid()
      midx: don't reuse corrupt MIDXs when writing
      midx: report checksum mismatches during 'verify'
      multi-pack-index: fix potential segfault without sub-command
      pack-bitmap: clarify comment in filter_bitmap_exclude_type()

Teng Long (1):
      packfile-uri.txt: fix blobPackfileUri description

Thomas Braun (1):
      completion: add --anchored to diff's options

Thomas B=C3=A9tous (1):
      mingw: align symlinks-related rmdir() behavior with Linux

Wolfgang M=C3=BCller (1):
      rev-parse: mark die() messages for translation

ZheNing Hu (4):
      ref-filter: add objectsize to used_atom
      ref-filter: introduce enum atom_type
      cat-file: handle trivial --batch format with --batch-all-objects
      cat-file: merge two block into one

brian m. carlson (1):
      rev-list: add option for --pretty=3Dformat without header

dorgon.chang (1):
      git-p4: fix failed submit by skip non-text data files

edef (1):
      mailinfo: don't discard names under 3 characters

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (93):
      test-lib: bring $remove_trash out of retirement
      test-lib tests: remove dead GIT_TEST_FRAMEWORK_SELFTEST variable
      test-lib-functions: reword "test_commit --append" docs
      test-lib-functions: document test_commit --no-tag
      test-lib functions: add an --annotated option to "test_commit"
      describe tests: convert setup to use test_commit
      test-lib functions: add --printf option to test_commit
      submodule tests: use symbolic-ref --short to discover branch name
      test-lib: reformat argument list in test_create_repo()
      test-lib: do not show advice about init.defaultBranch under --verbo=
se
      test-lib: split up and deprecate test_create_repo()
      grep/pcre2 tests: reword comments referring to kwset
      pickaxe tests: refactor to use test_commit --append --printf
      pickaxe tests: add test for diffgrep_consume() internals
      pickaxe tests: add test for "log -S" not being a regex
      pickaxe tests: test for -G, -S and --find-object incompatibility
      pickaxe tests: add missing test for --no-pickaxe-regex being an err=
or
      pickaxe: die when -G and --pickaxe-regex are combined
      pickaxe: die when --find-object and --pickaxe-all are combined
      diff.h: move pickaxe fields together again
      pickaxe/style: consolidate declarations and assignments
      perf: add performance test for pickaxe
      pickaxe: refactor function selection in diffcore-pickaxe()
      pickaxe: assert that we must have a needle under -G or -S
      pickaxe -S: support content with NULs under --pickaxe-regex
      pickaxe: rename variables in has_changes() for brevity
      pickaxe -S: slightly optimize contains()
      xdiff-interface: prepare for allowing early return
      xdiff-interface: allow early return from xdiff_emit_line_fn
      pickaxe -G: terminate early on matching lines
      pickaxe -G: don't special-case create/delete
      xdiff users: use designated initializers for out_line
      xdiff-interface: replace discard_hunk_line() with a flag
      describe tests: improve test for --work-tree & --dirty
      describe tests: refactor away from glob matching
      describe tests: don't rely on err.actual from "check_describe"
      describe tests: fix nested "test_expect_success" call
      describe tests: support -C in "check_describe"
      trace2: refactor to avoid gcc warning under -O3
      send-email tests: support GIT_TEST_PERL_FATAL_WARNINGS=3Dtrue
      send-email tests: test for boolean variables without a value
      send-email: remove non-working support for "sendemail.smtpssl"
      send-email: refactor sendemail.smtpencryption config parsing
      send-email: copy "config_regxp" into git-send-email.perl
      send-email: lazily load config for a big speedup
      send-email: lazily shell out to "git var"
      send-email: use function syntax instead of barewords
      send-email: get rid of indirect object syntax
      send-email: lazily load modules for a big speedup
      perl: lazily load some common Git.pm setup code
      send-email: move trivial config handling to Perl
      perl: nano-optimize by replacing Cwd::cwd() with Cwd::getcwd()
      protocol-caps.h: add newline at end of file
      read-cache.c: don't guard calls to progress.c API
      xdiff: use BUG(...), not xdl_bug(...)
      builtins + test helpers: use return instead of exit() in cmd_*
      mktag tests: parse out options in helper
      mktag tests: invert --no-strict test
      show-branch tests: rename the one "show-branch" test file
      show-branch tests: modernize test code
      pre-commit hook tests: don't leave "actual" nonexisting on failure
      gc tests: add a test for the "pre-auto-gc" hook
      mktag tests: test hash-object --literally and unreachable fsck
      mktag tests: test update-ref and reachable fsck
      mktag tests: test for-each-ref
      mktag tests: test fast-export
      show-branch: don't <COLOR></RESET> for space characters
      show-branch tests: add missing tests
      Makefile: add and use the ".DELETE_ON_ERROR" flag
      test-lib.sh: set COLUMNS=3D80 for --verbose repeatability
      send-pack.c: move "no refs in common" abort earlier
      fetch: document the --negotiate-only option
      *.h: move some *_INIT to designated initializers
      *.c *_init(): define in terms of corresponding *_INIT macro
      dir.[ch]: replace dir_init() with DIR_INIT
      string-list.[ch]: add a string_list_init_{nodup,dup}()
      string-list.h users: change to use *_{nodup,dup}()
      bundle cmd: stop leaking memory from parse_options_cmd_bundle()
      bundle.c: use a temporary variable for OIDs and names
      bundle: remove "ref_list" in favor of string-list.c API
      imap-send.c: use less verbose strbuf_fread() idiom
      fetch: fix segfault in --negotiate-only without --negotiation-tip=3D=
*
      *.c static functions: don't forward-declare __attribute__
      sequencer.c: move static function to avoid forward decl
      *.c static functions: add missing __attribute__((format))
      *.h: add a few missing __attribute__((format))
      advice.h: add missing __attribute__((format)) & fix usage
      test-lib-functions: use test-tool for [de]packetize()
      SubmittingPatches: move discussion of Signed-off-by above "send"
      SubmittingPatches: replace discussion of Travis with GitHub Actions
      bundle tests: use ">file" not ": >file"
      bundle tests: use test_cmp instead of grep
      t0001: fix broken not-quite getcwd(3) test in bed67874e2

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh (6):
      t: use configured TAR instead of tar
      doc/log: correct default for --decorate
      t: use user-specified utf-8 locale for testing svn
      test-lib-functions: introduce test_stdout_line_count
      t6400: preserve git ls-files exit status code
      t6402: preserve git exit status code

