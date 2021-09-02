Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E7AC433EF
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 22:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3036B6054F
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 22:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347818AbhIBWtr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 18:49:47 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54987 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347794AbhIBWtq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 18:49:46 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2655A159917;
        Thu,  2 Sep 2021 18:48:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=TatRVeCOCJAE1y+DGFALwaV9/
        BtS04jEpRtO7b/eDqs=; b=mQ+gQ+oF2OLze+HKCTBNaDA6bXovpPU4GgzL1RsFh
        JIjIQ4GcpJzszt22IBt6XbJ2BDO2qWcRvFHCY4SyYhu24F6v6NvxQWkzDrrkPPZH
        No62YEoA7/pyhvsz2HFvVauY6Imwt20V6/CWSOXRSzqyH+3kmN89etPn3RaxMAU3
        Ig=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1D7AB159916;
        Thu,  2 Sep 2021 18:48:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 404DB159915;
        Thu,  2 Sep 2021 18:48:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Sep 2021, #01; Thu, 2)
X-master-at: 6c40894d2466d4e7fddc047a05116aa9d14712ee
X-next-at: 3052b894382a0debd2b7c8345f86f70277b76a3e
Date:   Thu, 02 Sep 2021 15:48:42 -0700
Message-ID: <xmqq35qmiofp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: ED25E816-0C3F-11EC-99EB-9BA3EF469F85-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking in my tree.  Commits
prefixed with '+' are in 'next' (being in 'next' is a sign that a
topic is stable enough to be used and are candidate to be in a
future release).  Commits prefixed with '-' are only in 'seen',
which means nothing more than that I have found them of interest for
some reason (like "it may have hard-to-resolve conflicts with
another topic already in flight" or "this may turn out to be
useful").  Do not read too much into a topic being in (or not in)
'seen'.  The ones marked with '.' do not appear in any of the
integration branches, but I am still holding onto them.

Copies of the source code to Git live in many repositories, and the
following is a list of the ones I push into or their mirrors.  Some
repositories have only a subset of branches.

With maint, master, next, seen, todo:

	git://git.kernel.org/pub/scm/git/git.git/
	git://repo.or.cz/alt-git.git/
	https://kernel.googlesource.com/pub/scm/git/git/
	https://github.com/git/git/
	https://gitlab.com/git-vcs/git/

With all the integration branches and topics broken out:

	https://github.com/gitster/git/

Even though the preformatted documentation in HTML and man format
are not sources, they are published in these repositories for
convenience (replace "htmldocs" with "manpages" for the manual
pages):

	git://git.kernel.org/pub/scm/git/git-htmldocs.git/
	https://github.com/gitster/git-htmldocs.git/

Release tarballs are available at:

	https://www.kernel.org/pub/software/scm/git/

--------------------------------------------------
[New Topics]

* ms/customizable-ident-expansion (2021-09-01) 1 commit
 - keyword expansion: make "$Id$" string configurable

 Instead of "$Id$", user-specified string (like $FreeBSD$) can be
 used as an in-blob placeholder for keyword expansion.


* pb/test-use-user-env (2021-09-01) 3 commits
 - test-lib-functions: optionally keep HOME and TERM in 'debug'
 - test-lib-functions: optionally keep HOME, TERM and SHELL in 'test_paus=
e'
 - test-lib-functions: use 'TEST_SHELL_PATH' in 'test_pause'

 Teach test_pause and test_debug to allow using the HOME and TERM
 environment variables the user usually uses.

 Will merge to 'next'?


* js/retire-preserve-merges (2021-09-01) 7 commits
 - tests: stop testing `git rebase --preserve-merges`
 - remote: warn about unhandled branch.<name>.rebase values
 - t5520: do not use `pull.rebase=3Dpreserve`
 - rebase: drop the internal `rebase--interactive` command
 - git-svn: drop support for `--preserve-merges`
 - rebase: drop support for `--preserve-merges`
 - pull: remove support for `--rebase=3Dpreserve`

 The "--preserve-merges" option of "git rebase" has been removed.

 Will merge to 'next'?


* cb/remote-ndebug-fix (2021-09-02) 1 commit
 - remote: avoid -Wunused-but-set-variable in gcc with -DNDEBUG

 Build fix.

 Will merge to 'next'.


* mr/bisect-in-c-4 (2021-09-02) 6 commits
 - bisect--helper: retire `--bisect-next-check` subcommand
 - bisect--helper: reimplement `bisect_run` shell
 - bisect--helper: reimplement `bisect_visualize()`shell function in C
 - run-command: make `exists_in_PATH()` non-static
 - t6030-bisect-porcelain: add test for bisect visualize
 - t6030-bisect-porcelain: add tests to control bisect run exit cases

 Rewrite of "git bisect" in C continues.

--------------------------------------------------
[Stalled]

* gh/gitweb-branch-sort (2021-06-10) 1 commit
 - gitweb: use HEAD as secondary sort key in git_get_heads_list()

 Tie-break branches that point at the same object in the list of
 branches on GitWeb to show the one pointed at by HEAD early.

 Waiting for reviews.


* es/superproject-aware-submodules (2021-08-19) 5 commits
 - fixup! introduce submodule.superprojectGitDir record
 - submodule: record superproject gitdir during 'update'
 - submodule: record superproject gitdir during absorbgitdirs
 - introduce submodule.superprojectGitDir record
 - t7400-submodule-basic: modernize inspect() helper

 A configuration variable in a submodule points at the location of
 the superproject it is bound to (RFC).

 Looking good.


* en/zdiff3 (2021-06-15) 2 commits
 - update documentation for new zdiff3 conflictStyle
 - xdiff: implement a zealous diff3, or "zdiff3"

 "Zealous diff3" style of merge conflict presentation has been added.

 Expecting a reroll.
 cf. <CABPp-BE7-E03+x38EK-=3DAE5mwwdST+d50hiiud2eY2Nsf3rM5g@mail.gmail.co=
m>


* ao/p4-avoid-decoding (2021-04-12) 2 commits
 - git-p4: do not decode data from perforce by default
 - git-p4: avoid decoding more data from perforce

 "git p4" in Python-2 days used to accept a lot more kinds of data
 from Perforce server as uninterrupted byte sequence, but after
 switching to Python-3, too many things are expected to be in UTF-8,
 which broke traditional use cases.

 Waiting for reviews.


* tv/p4-fallback-encoding (2021-04-30) 1 commit
 - git-p4: git-p4.fallbackEncoding to specify non UTF-8 charset

 "git p4" learns the fallbackEncoding configuration variable to
 safely accept changeset descriptions that aren't written in UTF-8.

 Waiting for reviews.


* ab/fsck-unexpected-type (2021-07-12) 21 commits
 - fsck: report invalid object type-path combinations
 - fsck: report invalid types recorded in objects
 - object-store.h: move read_loose_object() below 'struct object_info'
 - fsck: don't hard die on invalid object types
 - object-file.c: return -2 on "header too long" in unpack_loose_header()
 - object-file.c: return -1, not "status" from unpack_loose_header()
 - object-file.c: guard against future bugs in loose_object_info()
 - object-file.c: stop dying in parse_loose_header()
 - object-file.c: split up ternary in parse_loose_header()
 - object-file.c: simplify unpack_loose_short_header()
 - object-file.c: add missing braces to loose_object_info()
 - object-file.c: make parse_loose_header_extended() public
 - object-file.c: don't set "typep" when returning non-zero
 - cache.h: move object functions to object-store.h
 - cat-file tests: test for current --allow-unknown-type behavior
 - cat-file tests: add corrupt loose object test
 - rev-list tests: test for behavior with invalid object types
 - cat-file tests: test that --allow-unknown-type isn't on by default
 - cat-file tests: test for missing object with -t and -s
 - fsck tests: add test for fsck-ing an unknown type
 - fsck tests: refactor one test to use a sub-repo

 "git fsck" has been taught to report mismatch between expected and
 actual types of an object better.

 Needs review.

--------------------------------------------------
[Cooking]

* tb/add-objects-in-unpacked-packs-simplify (2021-08-29) 3 commits
  (merged to 'next' on 2021-09-01 at 66b0f8564d)
 + builtin/pack-objects.c: remove duplicate hash lookup
 + builtin/pack-objects.c: simplify add_objects_in_unpacked_packs()
 + object-store.h: teach for_each_packed_object to ignore kept packs

 Code simplification with reduced memory usage.

 Will merge to 'master'.


* es/walken-tutorial-fix (2021-08-30) 1 commit
  (merged to 'next' on 2021-09-01 at 73719bee8a)
 + doc: fix syntax error and the format of printf

 Typofix.

 Will merge to 'master'.


* jh/sparse-index-resize-fix (2021-08-30) 1 commit
  (merged to 'next' on 2021-09-01 at 5ee2615670)
 + sparse-index: copy dir_hash in ensure_full_index()

 The sparse-index support can corrupt the index structure by storing
 a stale and/or uninitialized data, which has been corrected.

 Will merge to 'master'.


* mh/send-email-reset-in-reply-to (2021-08-30) 1 commit
 - send-email: avoid incorrect header propagation

 Even when running "git send-email" without its own threaded
 discussion support, a threading related header in one message is
 carried over to the subsequent message to result in an unwanted
 threading, which has been corrected.

 Will merge to 'next'.


* rs/more-fspathcmp (2021-08-30) 1 commit
  (merged to 'next' on 2021-09-01 at 3052b89438)
 + merge-recursive: use fspathcmp() in path_hashmap_cmp()

 Code simplification.

 Will merge to 'master'.


* sg/set-ceiling-during-tests (2021-08-30) 1 commit
  (merged to 'next' on 2021-09-01 at 5378ce3817)
 + test-lib: set GIT_CEILING_DIRECTORIES to protect the surrounding repos=
itory

 Buggy tests could damage repositories outside the throw-away test
 area we created.  We now by default export GIT_CEILING_DIRECTORIES
 to limit the damage from such a stray test.

 Will merge to 'master'.


* ab/gc-log-rephrase (2021-09-02) 1 commit
 - gc: remove trailing dot from "gc.log" line

 A pathname in an advice message has been made cut-and-paste ready.

 Will merge to 'next'.


* ab/mailmap-leakfix (2021-08-31) 1 commit
 - mailmap.c: fix a memory leak in free_mailap_{info,entry}()

 Leakfix.

 Will merge to 'next'.


* ba/object-info (2021-08-31) 1 commit
 - protocol-caps.c: fix memory leak in send_info()

 Leakfix.

 Will merge to 'next'.


* en/remerge-diff (2021-08-31) 7 commits
 - doc/diff-options: explain the new --remerge-diff option
 - show, log: provide a --remerge-diff capability
 - tmp-objdir: new API for creating and removing primary object dirs
 - merge-ort: capture and print ll-merge warnings in our preferred fashio=
n
 - ll-merge: add API for capturing warnings in a strbuf instead of stderr
 - merge-ort: add ability to record conflict messages in a file
 - merge-ort: mark a few more conflict messages as omittable

 A new presentation for two-parent merge "--remerge-diff" can be
 used to show the difference between mechanical (and possibly
 conflicted) merge results and the recorded resolution.


* sg/test-split-index-fix (2021-08-31) 7 commits
 - read-cache: fix GIT_TEST_SPLIT_INDEX
 - tests: disable GIT_TEST_SPLIT_INDEX for sparse index tests
 - read-cache: look for shared index files next to the index, too
 - t1600-index: disable GIT_TEST_SPLIT_INDEX
 - t1600-index: don't run git commands upstream of a pipe
 - t1600-index: remove unnecessary redirection
 - Merge branch 'ds/sparse-index-ignored-files' into sg/test-split-index-=
fix
 (this branch uses ds/sparse-index-ignored-files.)

 Test updates.


* tk/fast-export-anonymized-tag-fix (2021-08-31) 1 commit
 - fast-export: fix anonymized tag using original length

 The output from "git fast-export", when its anonymization feature
 is in use, showed an annotated tag incorrectly.

 Will merge to 'next'.


* uk/userdiff-php-enum (2021-08-31) 1 commit
 - userdiff: support enum keyword in PHP hunk header

 Update the userdiff pattern for PHP.

 Will merge to 'next'.


* ab/commit-graph-usage (2021-08-30) 7 commits
 - commit-graph: show "unexpected subcommand" error
 - commit-graph: show usage on "commit-graph [write|verify] garbage"
 - commit-graph: early exit to "usage" on !argc
 - multi-pack-index: refactor "goto usage" pattern
 - commit-graph: use parse_options_concat()
 - commit-graph: remove redundant handling of -h
 - commit-graph: define common usage with a macro

 Fixes on usage message from "git commit-graph".

 Will merge to 'next'.


* ab/ls-remote-packet-trace (2021-08-24) 1 commit
  (merged to 'next' on 2021-08-30 at fec2e5a7eb)
 + ls-remote: set packet_trace_identity(<name>)

 Debugging aid fix.

 Will merge to 'master'.


* ab/rebase-fatal-fatal-fix (2021-08-24) 1 commit
  (merged to 'next' on 2021-08-30 at 256e1cbc9e)
 + rebase: emit one "fatal" in "fatal: fatal: <error>"

 Error message fix.

 Will merge to 'master'.


* ab/refs-errno-cleanup (2021-08-25) 4 commits
 - refs: make errno output explicit for refs_resolve_ref_unsafe
 - refs: explicitly return failure_errno from parse_loose_ref_contents
 - branch tests: test for errno propagating on failing read
 - refs: add failure_errno to refs_read_raw_ref() signature
 (this branch is used by hn/reftable; uses ab/refs-files-cleanup and hn/r=
efs-errno-cleanup.)

 The "remainder" of hn/refs-errno-cleanup topic.


* ab/retire-advice-config (2021-08-25) 4 commits
 - advice: move advice.graftFileDeprecated squashing to commit.[ch]
 - advice: remove use of global advice_add_embedded_repo
 - advice: remove read uses of most global `advice_` variables
 - advice: add enum variants for missing advice variables

 Code clean up to migrate callers from older advice_config[] based
 API to newer advice_if_enabled() and advice_enabled() API.

 Will merge to 'next'.


* dd/diff-files-unmerged-fix (2021-08-25) 1 commit
  (merged to 'next' on 2021-08-30 at 63a1bdddfc)
 + diff-lib: ignore paths that are outside $cwd if --relative asked

 "git diff --relative" segfaulted and/or produced incorrect result
 when there are unmerged paths.

 Will merge to 'master'.


* dd/t6300-wo-gpg-fix (2021-08-25) 2 commits
  (merged to 'next' on 2021-08-30 at 59f5669dd6)
 + t6300: check for cat-file exit status code
 + t6300: don't run cat-file on non-existent object

 Test fix.

 Will merge to 'master'.


* ga/send-email-sendmail-cmd (2021-08-24) 1 commit
  (merged to 'next' on 2021-08-30 at 1bb659c66c)
 + t9001: PATH must not use Windows-style paths

 Test fix.

 Will merge to 'master'.


* jb/midx-revindex-fix (2021-08-23) 1 commit
 - multi-pack-index: fix *.rev cleanups with --object-dir

 An implementation in "multi-pack-index write" that takes object
 directory inconsistently used that and the object store of the
 default repository, causing segfaults and possibly corrupting
 repositories.

 On hold.
 cf. <xmqqo89jbf49.fsf@gitster.g>


* jk/t5323-no-pack-test-fix (2021-08-25) 1 commit
  (merged to 'next' on 2021-08-30 at 2892635eaf)
 + t5323: drop mentions of "master"

 Test fix.

 Will merge to 'master'.


* js/maintenance-launchctl-fix (2021-08-24) 2 commits
  (merged to 'next' on 2021-08-30 at 12a5da47e7)
 + maintenance: skip bootout/bootstrap when plist is registered
 + maintenance: create `launchctl` configuration using a lock file

 "git maintenance" scheduler fix for macOS.

 Will merge to 'master'.


* jv/pkt-line-batch (2021-09-01) 2 commits
 - upload-pack: use stdio in send_ref callbacks
 - pkt-line: add stdio packet write functions

 Reduce number of write(2) system calls while sending the
 ref advertisement.

 Will merge to 'next'?


* me/t5582-cleanup (2021-08-24) 1 commit
  (merged to 'next' on 2021-08-30 at e92258e72c)
 + t5582: remove spurious 'cd "$D"' line

 Test fix.

 Will merge to 'master'.


* mh/credential-leakfix (2021-08-25) 1 commit
  (merged to 'next' on 2021-08-30 at be9e67bddc)
 + credential: fix leak in credential_apply_config()

 Leak fix.

 Will merge to 'master'.


* mt/quiet-with-delayed-checkout (2021-08-26) 1 commit
  (merged to 'next' on 2021-08-30 at d243498893)
 + checkout: make delayed checkout respect --quiet and --no-progress

 The delayed checkout code path in "git checkout" etc. were chatty
 even when --quiet and/or --no-progress options were given.

 Will merge to 'master'.


* ps/fetch-omit-formatting-under-quiet (2021-08-30) 1 commit
  (merged to 'next' on 2021-09-01 at 2440a8a2aa)
 + fetch: skip formatting updated refs with `--quiet`

 "git fetch --quiet" optimization to avoid useless computation of
 info that will never be displayed.

 Will merge to 'master'.


* ps/ls-refs-strbuf-optim (2021-08-25) 1 commit
  (merged to 'next' on 2021-08-30 at e4cbc7243a)
 + ls-refs: reuse buffer when sending refs

 Micro-optimization for the wire protocol driver.

 Will merge to 'master'.


* rs/branch-allow-deleting-dangling (2021-08-27) 1 commit
  (merged to 'next' on 2021-08-30 at 35b9d158e8)
 + branch: allow deleting dangling branches with --force

 "git branch -D <branch>" used to refuse to remove a broken branch
 ref that points at a missing commit, which has been corrected.

 Will merge to 'master'.


* rs/git-mmap-uses-malloc (2021-08-24) 1 commit
  (merged to 'next' on 2021-08-30 at 6339c8e657)
 + compat: let git_mmap use malloc(3) directly

 mmap() imitation used to call xmalloc() that dies upon malloc()
 failure, which has been corrected to just return an error to the
 caller to be handled.

 Will merge to 'master'.


* rs/xopen-reports-open-failures (2021-08-25) 2 commits
  (merged to 'next' on 2021-08-30 at a8588775c8)
 + use xopen() to handle fatal open(2) failures
 + xopen: explicitly report creation failures

 Error diagnostics improvement.

 Will merge to 'master'.


* sg/column-nl (2021-08-26) 1 commit
  (merged to 'next' on 2021-08-30 at a3cb0f4745)
 + column: fix parsing of the '--nl' option

 The parser for the "--nl" option of "git column" has been
 corrected.

 Will merge to 'master'.


* ab/unbundle-progress (2021-08-27) 5 commits
 - bundle: show progress on "unbundle"
 - index-pack: add --progress-title option
 - bundle API: change "flags" to be "extra_index_pack_args"
 - strvec: add a strvec_pushvec()
 - bundle API: start writing API documentation

 Add progress display to "git bundle unbundle".

 Expecting a reroll.
 cf. <87tuj7xhqo.fsf@evledraar.gmail.com>


* jk/log-warn-on-bogus-encoding (2021-08-27) 2 commits
 - docs: use "character encoding" to refer to commit-object encoding
 - logmsg_reencode(): warn when iconv() fails


* rs/archive-use-object-id (2021-08-27) 1 commit
 - archive: convert queue_directory to struct object_id


* rs/show-branch-simplify (2021-08-27) 1 commit
 - show-branch: simplify rev_is_head()


* lh/systemd-timers (2021-08-27) 3 commits
 - maintenance: add support for systemd timers on Linux
 - maintenance: `git maintenance run` learned `--scheduler=3D<scheduler>`
 - cache.h: Introduce a generic "xdg_config_home_for(=E2=80=A6)" function

 "git maintenance" scheduler learned to use systemd timers as a
 possible backend.


* ps/fetch-optim (2021-09-01) 7 commits
 - fetch: avoid second connectivity check if we already have all objects
 - fetch: merge fetching and consuming refs
 - fetch: refactor fetch refs to be more extendable
 - fetch-pack: optimize loading of refs via commit graph
 - connected: refactor iterator to return next object ID directly
 - fetch: avoid unpacking headers in object existence check
 - fetch: speed up lookup of want refs via commit-graph

 Optimize code that handles large number of refs in the "git fetch"
 code path.


* sg/make-fix-ar-invocation (2021-08-19) 1 commit
  (merged to 'next' on 2021-08-24 at 9a3df9ec56)
 + Makefile: remove archives before manipulating them with 'ar'

 Build fix.

 Will merge to 'master'.


* ti/tcsh-completion-regression-fix (2021-08-18) 1 commit
  (merged to 'next' on 2021-08-24 at 8fa66cf037)
 + completion: tcsh: Fix regression by drop of wrapper functions

 Update to the command line completion (in contrib/) for tcsh.

 Will merge to 'master'.


* fc/completion-updates (2021-08-18) 4 commits
  (merged to 'next' on 2021-08-24 at 593cd75c64)
 + completion: bash: add correct suffix in variables
 + completion: bash: fix for multiple dash commands
 + completion: bash: fix for suboptions with value
 + completion: bash: fix prefix detection in branch.*

 Command line completion updates.

 Will merge to 'master'.


* ar/submodule-run-update-procedure (2021-08-24) 1 commit
 - submodule--helper: run update procedures from C

 Reimplementation of parts of "git submodule" in C continues.


* cb/ci-use-upload-artifacts-v1 (2021-08-15) 1 commit
  (merged to 'next' on 2021-08-24 at afdbb7ee8d)
 + ci: use upload-artifacts v1 for dockerized jobs

 Use upload-artifacts v1 (instead of v2) for 32-bit linux, as the
 new version has a blocker bug for that architecture.

 Will merge to 'master'.


* pw/rebase-skip-final-fix (2021-08-13) 3 commits
  (merged to 'next' on 2021-08-24 at 73ec41e9dd)
 + rebase --continue: remove .git/MERGE_MSG
 + rebase --apply: restore some tests
 + t3403: fix commit authorship

 Checking out all the paths from HEAD during the last conflicted
 step in "git rebase" and continuing would cause the step to be
 skipped (which is expected), but leaves MERGE_MSG file behind in
 $GIT_DIR and confuses the next "git commit", which has been
 corrected.

 Will merge to 'master'.


* ab/help-autocorrect-prompt (2021-08-14) 1 commit
 - help.c: help.autocorrect=3Dprompt waits for user action

 The logic for auto-correction of misspelt subcommands learned to go
 interactive when the help.autocorrect configuration variable is set
 to true.


* pw/rebase-r-fixes (2021-08-23) 4 commits
  (merged to 'next' on 2021-08-24 at 81c6aff70a)
 + rebase -r: fix merge -c with a merge strategy
 + rebase -r: don't write .git/MERGE_MSG when fast-forwarding
 + rebase -i: add another reword test
 + rebase -r: make 'merge -c' behave like reword

 Various bugs in "git rebase -r" have been fixed.

 Will merge to 'master'.


* zh/cherry-pick-advice (2021-08-23) 1 commit
  (merged to 'next' on 2021-09-01 at 6ff491cc09)
 + cherry-pick: use better advice message

 The advice message that "git cherry-pick" gives when it asks
 conflicted replay of a commit to be resolved by the end user has
 been updated.

 Will merge to 'master'.


* es/config-based-hooks (2021-08-19) 7 commits
 - hook: allow out-of-repo 'git hook' invocations
 - hook: include hooks from the config
 - hook: allow running non-native hooks
 - hook: introduce "git hook list"
 - hook: allow parallel hook execution
 - hook: run a list of hooks instead
 - Merge branch 'ab/config-based-hooks-base' into es/config-based-hooks
 (this branch uses ab/config-based-hooks-base.)

 Revamp the hooks subsystem to allow multiple of them to trigger
 upon the same event and control via the configuration variables.

 Expecting a reroll
 but ab/config-based-hooks-base needs to be in a better shape first.
 cf. <87v93wflm0.fsf@evledraar.gmail.com>
 cf. <87tuj7xhqo.fsf@evledraar.gmail.com>


* mk/clone-recurse-submodules (2021-08-30) 1 commit
 - clone: set submodule.recurse=3Dtrue if submodule.stickyRecursiveClone =
enabled

 After "git clone --recurse-submodules", all submodules are cloned
 but they are not by default recursed into by other commands.  With
 submodule.stickyRecursiveClone configuration set, submodule.recurse
 configuration is set to true in a repository created by "clone"
 with "--recurse-submodules" option.

 Will merge to 'next'.


* jk/commit-edit-fixup-fix (2021-08-15) 1 commit
  (merged to 'next' on 2021-08-24 at 0c625438c3)
 + commit: restore --edit when combined with --fixup

 "git commit --fixup" now works with "--edit" again, after it was
 broken in v2.32.

 Will merge to 'master'.


* ka/want-ref-in-namespace (2021-09-01) 3 commits
  (merged to 'next' on 2021-09-01 at a1075a92a9)
 + docs: clarify the interaction of transfer.hideRefs and namespaces
 + upload-pack.c: treat want-ref relative to namespace
 + t5730: introduce fetch command helper

 "git upload-pack" which runs on the other side of "git fetch"
 forgot to take the ref namespaces into account when handling
 want-ref requests.

 Will merge to 'master'.


* cb/ci-build-pedantic (2021-08-11) 1 commit
 - ci: run a pedantic build as part of the GitHub workflow

 CI update.

 Expecting a reroll.


* ds/sparse-index-ignored-files (2021-08-10) 9 commits
 - sparse-checkout: clear tracked sparse dirs
 - sparse-index: add SPARSE_INDEX_IGNORE_CONFIG flag
 - attr: be careful about sparse directories
 - sparse-checkout: create helper methods
 - unpack-trees: fix nested sparse-dir search
 - sparse-index: silently return when cache tree fails
 - sparse-index: silently return when not using cone-mode patterns
 - t7519: rewrite sparse index test
 - Merge branch 'ds/add-with-sparse-index' into ds/sparse-index-ignored-f=
iles
 (this branch is used by sg/test-split-index-fix.)

 In cone mode, the sparse-index codepath learned to remove ignored
 files (like build artifacts) outside the sparse cone, allowing the
 entire directory outside the sparse cone to be removed, which is
 especially useful when the sparse patterns change.


* js/advise-when-skipping-cherry-picked (2021-08-30) 1 commit
  (merged to 'next' on 2021-09-01 at bc883fce56)
 + sequencer: advise if skipping cherry-picked commit

 "git rebase" by default skips changes that are equivalent to
 commits that are already in the history the branch is rebased onto;
 give messages when this happens to let the users be aware of
 skipped commits, and also teach them how to tell "rebase" to keep
 duplicated changes.

 Will merge to 'master'.


* jt/grep-wo-submodule-odb-as-alternate (2021-08-13) 8 commits
 - t7814: show lack of alternate ODB-adding
 - submodule-config: pass repo upon blob config read
 - grep: add repository to OID grep sources
 - grep: allocate subrepos on heap
 - grep: read submodule entry with explicit repo
 - grep: typesafe versions of grep_source_init
 - grep: use submodule-ODB-as-alternate lazy-addition
 - submodule: lazily add submodule ODBs as alternates

 The code to make "git grep" recurse into submodules has been
 updated to migrate away from the "add submodule's object store as
 an alternate object store" mechanism (which is suboptimal).


* ps/connectivity-optim (2021-08-09) 5 commits
  (merged to 'next' on 2021-08-24 at 94a7a04ca4)
 + revision: avoid hitting packfiles when commits are in commit-graph
 + commit-graph: split out function to search commit position
 + revision: stop retrieving reference twice
 + connected: do not sort input revisions
 + revision: separate walk and unsorted flags

 The revision traversal API has been optimized by taking advantage
 of the commit-graph, when available, to determine if a commit is
 reachable from any of the existing refs.

 Will merge to 'master'.


* ar/submodule-add-more (2021-08-10) 10 commits
 - submodule--helper: rename compute_submodule_clone_url()
 - submodule--helper: remove resolve-relative-url subcommand
 - submodule--helper: remove add-config subcommand
 - submodule--helper: remove add-clone subcommand
 - submodule--helper: convert the bulk of cmd_add() to C
 - dir: libify and export helper functions from clone.c
 - submodule--helper: remove repeated code in sync_submodule()
 - submodule--helper: refactor resolve_relative_url() helper
 - submodule--helper: add options for compute_submodule_clone_url()
 - Merge branch 'ar/submodule-add-config' into ar/submodule-add
 (this branch uses ar/submodule-add-config.)

 More parts of "git submoudle add" has been rewritten in C.


* cb/makefile-apple-clang (2021-08-06) 3 commits
  (merged to 'next' on 2021-08-30 at 9fe8f1a9b3)
 + build: catch clang that identifies itself as "$VENDOR clang"
 + build: clang version may not be followed by extra words
 + build: update detect-compiler for newer Xcode version

 Build update.

 Will merge to 'master'.


* ab/lib-subtest (2021-08-05) 11 commits
 - test-lib tests: assert 1 exit code, not non-zero
 - test-lib tests: refactor common part of check_sub_test_lib_test*()
 - test-lib tests: avoid subshell for "test_cmp" for readability
 - test-lib tests: assert no copy/pasted mock test code
 - test-lib tests: get rid of copy/pasted mock test code
 - test-lib tests: don't provide a description for the sub-tests
 - test-lib tests: stop using a subshell in write_sub_test_lib_test()
 - test-lib tests: split up "write and run" into two functions
 - test-lib tests: move "run_sub_test" to a new lib-subtest.sh
 - Merge branch 'ps/t0000-output-directory-fix' into ab/lib-subtest
 - Merge branch 'jk/t0000-subtests-fix' into ab/lib-subtest

 Updates to the tests in t0000 to test the test framework.


* ab/only-single-progress-at-once (2021-07-23) 8 commits
 - progress.c: add & assert a "global_progress" variable
 - pack-bitmap-write.c: add a missing stop_progress()
 - progress.c: add temporary variable from progress struct
 - progress.c: stop eagerly fflush(stderr) when not a terminal
 - progress.c: call progress_interval() from progress_test_force_update()
 - progress.c: move signal handler functions lower
 - progress.c tests: test some invalid usage
 - progress.c tests: make start/stop verbs on stdin

 Further tweaks on progress API.

 On hold.
 cf. <20210901050406.GB76263@szeder.dev>


* ab/progress-users-adjust-counters (2021-08-25) 2 commits
 - entry: show finer-grained counter in "Filtering content" progress line
 - commit-graph: fix bogus counter in "Scanning merged commits" progress =
line

 The code to show progress indicator in a few codepaths did not
 cover between 0-100%, which has been corrected.

 Will merge to 'next'?


* ar/submodule-add-config (2021-08-10) 1 commit
 - submodule--helper: introduce add-config subcommand
 (this branch is used by ar/submodule-add-more.)

 Large part of "git submodule add" gets rewritten in C.


* dt/submodule-diff-fixes (2021-08-31) 3 commits
 - diff --submodule=3Ddiff: don't print failure message twice
 - diff --submodule=3Ddiff: do not fail on ever-initialied deleted submod=
ules
 - t4060: remove unused variable

 "git diff --submodule=3Ddiff" showed failure from run_command() when
 trying to run diff inside a submodule, when the user manually
 removes the submodule directory.

 Will merge to 'next'?
 cf. <20210812001332.715876-1-dturner@twosigma.com>


* fs/ssh-signing (2021-08-29) 9 commits
 - ssh signing: test that gpg fails for unknown keys
 - ssh signing: tests for logs, tags & push certs
 - ssh signing: duplicate t7510 tests for commits
 - ssh signing: verify signatures using ssh-keygen
 - ssh signing: provide a textual signing_key_id
 - ssh signing: retrieve a default key from ssh-agent
 - ssh signing: add ssh key format and signing code
 - ssh signing: add test prereqs
 - ssh signing: preliminary refactoring and clean-up

 Use ssh public crypto for object and push-cert signing.

 Will merge to 'next'.


* cf/fetch-set-upstream-while-detached (2021-07-06) 1 commit
 - fetch: fix segfault on --set-upstream while on a detached HEAD

 "git fetch --set-upstream" while on detached HEAD segfaulted
 instead of noticing that such an operation did not make sense.

 Expecting a reroll.
 cf. <xmqqsg0ri5mq.fsf@gitster.g>


* ab/make-tags-cleanup (2021-08-05) 5 commits
 - Makefile: normalize clobbering & xargs for tags targets
 - Makefile: remove "cscope.out", not "cscope*" in cscope.out target
 - Makefile: don't use "FORCE" for tags targets
 - Makefile: add QUIET_GEN to "cscope" target
 - Makefile: move ".PHONY: cscope" near its target

 Build clean-up for "make tags" and friends.

 Will merge to 'next'?


* tb/multi-pack-bitmaps (2021-09-01) 27 commits
 - p5326: perf tests for MIDX bitmaps
 - p5310: extract full and partial bitmap tests
 - midx: respect 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP'
 - t7700: update to work with MIDX bitmap test knob
 - t5319: don't write MIDX bitmaps in t5319
 - t5310: disable GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP
 - t0410: disable GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP
 - t5326: test multi-pack bitmap behavior
 - t/helper/test-read-midx.c: add --checksum mode
 - t5310: move some tests to lib-bitmap.sh
 - pack-bitmap: write multi-pack bitmaps
 - pack-bitmap: read multi-pack bitmaps
 - pack-bitmap.c: avoid redundant calls to try_partial_reuse
 - pack-bitmap.c: introduce 'bitmap_is_preferred_refname()'
 - pack-bitmap.c: introduce 'nth_bitmap_object_oid()'
 - pack-bitmap.c: introduce 'bitmap_num_objects()'
 - midx: avoid opening multiple MIDXs when writing
 - midx: close linked MIDXs, avoid leaking memory
 - midx: infer preferred pack when not given one
 - midx: reject empty `--preferred-pack`'s
 - midx: clear auxiliary .rev after replacing the MIDX
 - midx: fix `*.rev` cleanups with `--object-dir`
 - midx: disallow running outside of a repository
 - Documentation: describe MIDX-based bitmaps
 - pack-bitmap-write.c: free existing bitmaps
 - pack-bitmap-write.c: gracefully fail to write non-closed bitmaps
 - pack-bitmap.c: harden 'test_bitmap_walk()' to check type bitmaps

 The reachability bitmap file used to be generated only for a single
 pack, but now we've learned to generate bitmaps for history that
 span across multiple packfiles.

 Will merge to 'next'?


* ab/config-based-hooks-base (2021-08-03) 36 commits
 - hooks: fix a TOCTOU in "did we run a hook?" heuristic
 - receive-pack: convert receive hooks to hook.h
 - post-update: use hook.h library
 - receive-pack: convert 'update' hook to hook.h
 - hooks: allow callers to capture output
 - run-command: allow capturing of collated output
 - reference-transaction: use hook.h to run hooks
 - hook tests: use a modern style for "pre-push" tests
 - hook tests: test for exact "pre-push" hook input
 - transport: convert pre-push hook to hook.h
 - hook: convert 'post-rewrite' hook in sequencer.c to hook.h
 - hook: provide stdin by string_list or callback
 - run-command: add stdin callback for parallelization
 - am: convert 'post-rewrite' hook to hook.h
 - hook: support passing stdin to hooks
 - run-command: allow stdin for run_processes_parallel
 - run-command: remove old run_hook_{le,ve}() hook API
 - receive-pack: convert push-to-checkout hook to hook.h
 - read-cache: convert post-index-change to use hook.h
 - commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
 - git-p4: use 'git hook' to run hooks
 - send-email: use 'git hook run' for 'sendemail-validate'
 - git hook run: add an --ignore-missing flag
 - merge: convert post-merge to use hook.h
 - hooks: convert 'post-checkout' hook to hook library
 - am: convert applypatch to use hook.h
 - rebase: convert pre-rebase to use hook.h
 - gc: use hook library for pre-auto-gc hook
 - hook: add 'run' subcommand
 - hook-list.h: add a generated list of hooks, like config-list.h
 - hook.c users: use "hook_exists()" insted of "find_hook()"
 - hook.c: add a hook_exists() wrapper and use it in bugreport.c
 - hook.[ch]: move find_hook() to this new library
 - Makefile: remove an out-of-date comment
 - Makefile: stop hardcoding {command,config}-list.h
 - Makefile: mark "check" target as .PHONY
 (this branch is used by es/config-based-hooks.)

 Restructuring of (a subset of) Emily's config-based-hooks series,
 to demonstrate that a series can be presented as a more logical and
 focused progression.

 Waiting for reviews.


* ab/serve-cleanup (2021-08-05) 10 commits
 - upload-pack: document and rename --advertise-refs
 - serve.[ch]: remove "serve_options", split up --advertise-refs code
 - {upload,receive}-pack tests: add --advertise-refs tests
 - serve.c: move version line to advertise_capabilities()
 - serve: move transfer.advertiseSID check into session_id_advertise()
 - serve.[ch]: don't pass "struct strvec *keys" to commands
 - serve: use designated initializers
 - transport: use designated initializers
 - transport: rename "fetch" in transport_vtable to "fetch_refs"
 - serve: mark has_capability() as static

 Code clean-up around "git serve".

 Will merge to 'next'?


* ab/test-tool-cache-cleanup (2021-08-24) 4 commits
 - read-cache perf: add a perf test for refresh_index()
 - test-tool: migrate read-cache-again to parse_options()
 - test-tool: migrate read-cache-perf to parse_options()
 - test-tool: split up test-tool read-cache

 Test code shuffling.

 Will discard.
 cf. <87tuj7xhqo.fsf@evledraar.gmail.com>


* ab/pack-objects-stdin (2021-07-09) 5 commits
 - pack-objects.c: make use of REV_INFO_STDIN_LINE_PROCESS
 - pack-objects.c: do stdin parsing via revision.c's API
 - revision.[ch]: add a "handle_stdin_line" API
 - revision.h: refactor "disable_stdin" and "read_from_stdin"
 - upload-pack: run is_repository_shallow() before setup_revisions()

 Introduce handle_stdin_line callback to revision API and uses it.

 Waiting for reviews.


* pw/diff-color-moved-fix (2021-08-05) 13 commits
 - diff: drop unused options parameter from cmp_in_block_with_wsd()
 - diff --color-moved: intern strings
 - diff: use designated initializers for emitted_diff_symbol
 - diff --color-moved-ws=3Dallow-indentation-change: improve hash lookups
 - diff --color-moved: stop clearing potential moved blocks
 - diff --color-moved: shrink potential moved blocks as we go
 - diff --color-moved: unify moved block growth functions
 - diff --color-moved: call comparison function directly
 - diff --color-moved-ws=3Dallow-indentation-change: simplify and optimiz=
e
 - diff: simplify allow-indentation-change delta calculation
 - diff --color-moved: avoid false short line matches and bad zerba color=
ing
 - diff --color-moved=3Dzebra: fix alternate coloring
 - diff --color-moved: add perf tests

 Originally merged to 'next' on 2021-08-05

 Long-overdue correctness and performance update to "diff
 --color-moved" feature.

 Eject for reroll.
 cf. <8bec1a6d-5052-50c3-4100-e6348289d581@gmail.com>


* hn/reftable (2021-08-26) 29 commits
 - SQUASH??? https://github.com/git/git/runs/3439941236?check_suite_focus=
=3Dtrue#step:5:700
 - reftable: fixup for new base topic 3/3
 - reftable: fixup for new base topic 2/3
 - reftable: fixup for new base topic 1/3
 - t1404: annotate test cases with REFFILES
 - t1401,t2011: parameterize HEAD.lock for REFFILES
 - t1301: document what needs to be done for reftable
 - Add "test-tool dump-reftable" command.
 - git-prompt: prepare for reftable refs backend
 - refs: RFC: Reftable support for git-core
 - reftable: add dump utility
 - reftable: implement stack, a mutable database of reftable files.
 - reftable: implement refname validation
 - reftable: add merged table view
 - reftable: add a heap-based priority queue for reftable records
 - reftable: reftable file level tests
 - reftable: read reftable files
 - reftable: generic interface to tables
 - reftable: write reftable files
 - reftable: a generic binary tree implementation
 - reftable: reading/writing blocks
 - Provide zlib's uncompress2 from compat/zlib-compat.c
 - reftable: (de)serialization for the polymorphic record type.
 - reftable: add blocksource, an abstraction for random access reads
 - reftable: utility functions
 - reftable: add error related functionality
 - reftable: RFC: add LICENSE
 - init-db: set the_repository->hash_algo early on
 - hash.h: provide constants for the hash IDs
 (this branch uses ab/refs-errno-cleanup, ab/refs-files-cleanup and hn/re=
fs-errno-cleanup.)

 The "reftable" backend for the refs API.


* ab/refs-files-cleanup (2021-08-25) 13 commits
 - refs/files: remove unused "errno !=3D ENOTDIR" condition
 - refs/files: remove unused "errno =3D=3D EISDIR" code
 - refs/files: remove unused "oid" in lock_ref_oid_basic()
 - refs API: remove OID argument to reflog_expire()
 - reflog expire: don't lock reflogs using previously seen OID
 - refs/files: add a comment about refs_reflog_exists() call
 - refs: make repo_dwim_log() accept a NULL oid
 - refs/debug: re-indent argument list for "prepare"
 - refs/files: remove unused "skip" in lock_raw_ref() too
 - refs/files: remove unused "extras/skip" in lock_ref_oid_basic()
 - refs: drop unused "flags" parameter to lock_ref_oid_basic()
 - refs/files: remove unused REF_DELETING in lock_ref_oid_basic()
 - refs/packet: add missing BUG() invocations to reflog callbacks
 (this branch is used by ab/refs-errno-cleanup, hn/refs-errno-cleanup and=
 hn/reftable.)

 Continued work on top of the hn/refs-errno-cleanup topic.


* hn/refs-errno-cleanup (2021-08-25) 4 commits
 - refs: make errno output explicit for read_raw_ref_fn
 - refs/files-backend: stop setting errno from lock_ref_oid_basic
 - refs: remove EINVAL errno output from specification of read_raw_ref_fn
 - refs file backend: move raceproof_create_file() here
 (this branch is used by ab/refs-errno-cleanup and hn/reftable; uses ab/r=
efs-files-cleanup.)

 Futz with the way 'errno' is relied on in the refs API to carry the
 failure modes up the callchain.


* jh/builtin-fsmonitor (2021-08-26) 36 commits
 - SQUASH??? https://github.com/git/git/runs/3438543601?check_suite_focus=
=3Dtrue#step:5:136
 - BANDAID: sparse fixes
 - t7527: test FS event reporing on MacOS WRT case and Unicode
 - fsmonitor: handle shortname for .git
 - t7527: test status with untracked-cache and fsmonitor--daemon
 - fsmonitor: force update index after large responses
 - fsmonitor: enhance existing comments
 - fsmonitor--daemon: use a cookie file to sync with file system
 - fsmonitor--daemon: periodically truncate list of modified files
 - t7527: create test for fsmonitor--daemon
 - t/perf/p7519: add fsmonitor--daemon test cases
 - t/perf: avoid copying builtin fsmonitor files into test repo
 - t/perf/p7519: speed up test using "test-tool touch"
 - t/helper/test-touch: add helper to touch a series of files
 - fsmonitor--daemon: implement handle_client callback
 - fsmonitor-fs-listen-macos: implement FSEvent listener on MacOS
 - fsmonitor-fs-listen-macos: add macos header files for FSEvent
 - fsmonitor-fs-listen-win32: implement FSMonitor backend on Windows
 - fsmonitor--daemon: create token-based changed path cache
 - fsmonitor--daemon: define token-ids
 - fsmonitor--daemon: add pathname classification
 - fsmonitor: do not try to operate on bare repos
 - fsmonitor--daemon: implement 'start' command
 - fsmonitor--daemon: implement 'run' command
 - fsmonitor-fs-listen-macos: stub in backend for MacOS
 - fsmonitor-fs-listen-win32: stub in backend for Windows
 - t/helper/fsmonitor-client: create IPC client to talk to FSMonitor Daem=
on
 - fsmonitor--daemon: implement 'stop' and 'status' commands
 - fsmonitor--daemon: add a built-in fsmonitor daemon
 - fsmonitor: use IPC to query the builtin FSMonitor daemon
 - fsmonitor: config settings are repository-specific
 - help: include fsmonitor--daemon feature flag in version info
 - fsmonitor-ipc: create client routines for git-fsmonitor--daemon
 - fsmonitor--daemon: update fsmonitor documentation
 - fsmonitor--daemon: man page
 - simple-ipc: preparations for supporting binary messages.

 An attempt to write and ship with a watchman equivalent tailored
 for our use.

 Expecting a reroll post 2.33 release.

--------------------------------------------------
[Discarded]

* zh/cherry-pick-help-is-only-for-sequencer (2021-08-03) 2 commits
 . cherry-pick: use better advice message
 . cherry-pick: fix bug when used with GIT_CHERRY_PICK_HELP

 Originally merged to 'next' on 2021-08-04

 "git cherry-pick" loses its state file when a stray
 GIT_CHERRY_PICK_HELP environment is present, which has been
 corrected.

 Reverted out of 'next' at 1f62d2e1 on 2021-08-11


* jk/refs-files-cleanup-cleanup (2021-08-19) 1 commit
 . refs: drop unused "flags" parameter to lock_ref_oid_basic()

 Code cleanup.

 Obsoleted by updated ab/refs-files-cleanup


* ow/clone-bare-origin (2021-08-03) 1 commit
 - clone: Allow combining --bare and --origin

 "git clone" did not like to take "--bare" and "--origin=3DX" at the
 same time; loosen the restriction.

 cf. <20210802174944.53745-1-oystwa@gmail.com>


* jc/trivial-threeway-binary-merge (2021-07-28) 1 commit
 - ll-merge: teach ll_binary_merge() a trivial three-way merge

 The built-in merge driver for binary files learned to resolve
 trivial three-way merges (e.g. apply change, which turns A into B,
 to content A) by itself, which would help "git apply --3way" used
 when there is no need to use "--3way".

 Will discard.
 Replace with a trivial-merge logic in apply.c::try_treeway() or
 apply.c::three_way_merge().


* np/blame-ignore-revs-file-may-be-optional (2021-08-09) 1 commit
 - blame: add config `blame.ignoreRevsFileIsOptional`

 When the file named by blame.ignoreRevsFile configuration variable
 does not exist, it causes "git blame" to die.  Sometimes, it is
 useful if the files named by configuration variables can be made
 optional (it would allow ~/.gitconfig to give a filename, and make
 it effective only in repositories that have a file with that name).

 This uses an extra variable that marks that the variable is
 optional.  Yet another alternative is being discussed to define
 syntax for "optional" filename values, so that the same mechanism
 can be used for not just blame.ignoreRevsFile but other filenames.

 Queued just as a reminder of the theme.
