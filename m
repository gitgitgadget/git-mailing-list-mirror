Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B18D20450
	for <e@80x24.org>; Wed,  1 Nov 2017 05:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751237AbdKAFn2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 01:43:28 -0400
Received: from pb-sasl-trial3.pobox.com ([64.147.108.87]:54205 "EHLO
        pb-sasl-trial3.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750808AbdKAFnZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 01:43:25 -0400
Received: from pb-sasl-trial3.pobox.com (localhost.local [127.0.0.1])
        by pb-sasl-trial3.pobox.com (Postfix) with ESMTP id 6FB34282D1;
        Wed,  1 Nov 2017 01:43:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=R
        h+y3vacqQ5pTzGkzYaGP+UZ0Es=; b=B7JSa1VdQ018GYcShiZb4FBTQ2H5UhmpQ
        qM6QZ2KHSh7jx97AbtA/RyijfpGLlB3GYvVIk/ccIkEO8ChaSMmmaKXGhi48A5Je
        dJGbnInczV9W4WO61pwT6sePzvLJuQqE1DC2ah7cHnvAlX7lwen5KBDKqCat+qD0
        U0opu1L4u8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=NrQ
        JHQCMifVTTlDlgaC+byojmUawpzZFt6p+hUFe1FcOwRlAKFfQlYYy019bbsogHNh
        CrAzMD3adreWmUrH4NKjpvyqYi1rMcnY4XczwkbJ+6I6H9bxB2LpmfRF25nWdtIX
        0VkiIilBeVuRKLFkmuSBqMbm4AY1OGKtZi+3VBZ4=
Received: from pb-smtp2.nyi.icgroup.com (pb-smtp2.pobox.com [10.90.30.54])
        by pb-sasl-trial3.pobox.com (Postfix) with ESMTP id 481EF282D0;
        Wed,  1 Nov 2017 01:43:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 59EC298CE3;
        Wed,  1 Nov 2017 01:43:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Nov 2017, #01; Wed, 1)
X-master-at: cb5918aa0d50f50e83787f65c2ddc3dcb10159fe
X-next-at: fe51978a306f83b42a353408675befa0e5938b43
Date:   Wed, 01 Nov 2017 14:43:19 +0900
Message-ID: <xmqqvaiutuyw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 915A3C18-BEC7-11E7-88D7-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

Git 2.15 final was tagged.  I may not have fully caught up with the
list traffic and there may be topics that should have been scooped
up but lost in the noise, but I think the tree is in a better shape
than yesterday ;-)  We'll see if there is any brown paper bag bugs
by waiting til the end of the week.

And then we'll start the new cycle by rewinding the top of 'next'
and also marking topics that are marked as "will cook in 'next'" as
"will merge to 'master'" around the weekend.  The first to graduate
will be the ex/deprecate-empty-pathspec-as-match-all topic.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* ad/5580-unc-tests-on-cygwin (2017-11-01) 1 commit
 - t5580: add Cygwin support

 UNC paths are also relevant in Cygwin builds and they are now
 tested just like Mingw builds.

 Will merge to 'next'.


* ao/merge-verbosity-getenv-just-once (2017-11-01) 1 commit
 - merge-recursive: check GIT_MERGE_VERBOSITY only once

 Code cleanup.

 Will merge to 'next'.


* bp/read-index-from-skip-verification (2017-11-01) 1 commit
 - read_index_from(): speed index loading by skiping verification of the entry order

 Drop (perhaps overly cautious) sanity check before using the index
 read from the filesystem at runtime.

 Will merge to 'next'.


* cn/diff-indent-no-longer-is-experimental (2017-11-01) 2 commits
 - SQUASH???
 - diff: --indent-heuristic is no longer experimental

 Doc update.

 Will merge to 'next' after squashing the fixup.


* jk/rebase-i-exec-gitdir-fix (2017-11-01) 1 commit
 - sequencer: pass absolute GIT_DIR to exec commands

 A recent regression in "git rebase -i" that broke execution of git
 commands from subdirectories via "exec" insn has been fixed.

 Ack from Dscho would be nice.


* mh/test-local-canary (2017-10-31) 1 commit
 - t0000: check whether the shell supports the "local" keyword

 We try to see if somebody runs our test suite with a shell that
 does not support "local" like bash/dash does.

 Will merge to 'next'.


* rs/hex-to-bytes-cleanup (2017-11-01) 3 commits
 - sha1_file: use hex_to_bytes()
 - http-push: use hex_to_bytes()
 - notes: move hex_to_bytes() to hex.c and export it

 Code cleanup.

 Will merge to 'next'.


* rs/sequencer-rewrite-file-cleanup (2017-11-01) 2 commits
 - sequencer: use O_TRUNC to truncate files
 - sequencer: factor out rewrite_file()

 Code cleanup.

 Will merge to 'next'.


* sb/describe-blob (2017-11-01) 7 commits
 - t6120: fix typo in test name
 - builtin/describe.c: describe a blob
 - builtin/describe.c: factor out describe_commit
 - builtin/describe.c: print debug statements earlier
 - builtin/describe.c: rename `oid` to avoid variable shadowing
 - revision.h: introduce blob/tree walking in order of the commits
 - list-objects.c: factor out traverse_trees_and_blobs

 "git describe" was taught to dig trees deeper to find a
 <commit-ish>:<path> that refers to a given blob object.


* tb/add-renormalize (2017-10-31) 1 commit
 - add: introduce "--renormalize"

 "git add --renormalize ." is a new and safer way to record the fact
 that you are correcting the end-of-line convention and other
 "convert_to_git()" glitches in the in-repository data.


* ab/mediawiki-name-truncation (2017-11-01) 1 commit
 - remote-mediawiki: limit filenames to legal

 The remote-helper for talking to MediaWiki has been updated to
 truncate an overlong pagename so that ".mw" suffix can still be
 added.

 Will merge to 'next'.


* ab/mediawiki-namespace (2017-11-01) 7 commits
 - remote-mediawiki: show progress while fetching namespaces
 - remote-mediawiki: process namespaces in order
 - remote-mediawiki: support fetching from (Main) namespace
 - remote-mediawiki: skip virtual namespaces
 - remote-mediawiki: show known namespace choices on failure
 - remote-mediawiki: allow fetching namespaces with spaces
 - remote-mediawiki: add namespace support

 The remote-helper for talking to MediaWiki has been updated to
 work with mediawiki namespaces.

 Will merge to 'next'.


* js/mingw-full-version-in-resources (2017-11-01) 1 commit
 - mingw: include the full version information in the resources

 MinGW updates.

 Will merge to 'next'.

* js/mingw-redirection (2017-11-01) 3 commits
 - mingw: document the experimental standard handle redirection
 - mingw: special-case GIT_REDIRECT_STDERR=2>&1
 - mingw: add experimental feature to redirect standard handles

 MinGW updates.


* js/wincred-empty-cred (2017-11-01) 2 commits
 - wincred: handle empty username/password correctly
 - t0302: check helper can handle empty credentials

 MinGW updates.

--------------------------------------------------
[Stalled]

* mk/use-size-t-in-zlib (2017-08-10) 1 commit
 . zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".

 Needs resurrecting by making sure the fix is good and still applies
 (or adjusted to today's codebase).


* mg/status-in-progress-info (2017-05-10) 2 commits
 - status --short --inprogress: spell it as --in-progress
 - status: show in-progress info for short status

 "git status" learns an option to report various operations
 (e.g. "merging") that the user is in the middle of.

 cf. <xmqqmvakcdqw.fsf@gitster.mtv.corp.google.com>


* nd/worktree-move (2017-04-20) 6 commits
 - worktree remove: new command
 - worktree move: refuse to move worktrees with submodules
 - worktree move: accept destination as directory
 - worktree move: new command
 - worktree.c: add update_worktree_location()
 - worktree.c: add validate_worktree()

 "git worktree" learned move and remove subcommands.

 Expecting a reroll.
 cf. <20170420101024.7593-1-pclouds@gmail.com>
 cf. <20170421145916.mknekgqzhxffu7di@sigill.intra.peff.net>
 cf. <d0e81b1e-5869-299e-f462-4d43dc997bd1@ramsayjones.plus.com>

--------------------------------------------------
[Cooking]

* bw/diff-opt-impl-to-bitfields (2017-11-01) 8 commits
 - diff: make struct diff_flags members lowercase
 - diff: remove DIFF_OPT_CLR macro
 - diff: remove DIFF_OPT_SET macro
 - diff: remove DIFF_OPT_TST macro
 - diff: remove touched flags
 - diff: add flag to indicate textconv was set via cmdline
 - diff: convert flags to be stored in bitfields
 - add, reset: use DIFF_OPT_SET macro to set a diff flag

 A single-word "unsigned flags" in the diff options is being split
 into a structure with many bitfields.


* mh/tidy-ref-update-flags (2017-10-28) 8 commits
 - refs: rename constant `REF_ISPRUNING` to `REF_IS_PRUNING`
 - refs: rename constant `REF_NODEREF` to `REF_NO_DEREF`
 - refs: tidy up and adjust visibility of the `ref_update` flags
 - ref_transaction_add_update(): remove a check
 - ref_transaction_update(): die on disallowed flags
 - prune_ref(): call `ref_transaction_add_update()` directly
 - files_transaction_prepare(): don't leak flags to packed transaction
 - Merge branch 'bc/object-id' into base
 (this branch uses bc/object-id.)

 Code clean-up in refs API implementation.


* ao/diff-populate-filespec-lstat-errorpath-fix (2017-10-29) 1 commit
 - diff: fix lstat() error handling in diff_populate_filespec()

 After an error from lstat(), diff_populate_filespec() function
 sometimes still went ahead and used invalid data in struct stat,
 which has been fixed.


* av/fsmonitor (2017-11-01) 4 commits
 - fsmonitor: delay updating state until after split index is merged
 - fsmonitor: document GIT_TRACE_FSMONITOR
 - fsmonitor: don't bother pretty-printing JSON from watchman
 - fsmonitor: set the PWD to the top of the working tree
 (this branch uses bp/fsmonitor.)

 Various fixes to bp/fsmonitor topic.

 Will merge to 'next'.


* bc/submitting-patches-in-asciidoc (2017-10-30) 2 commits
 - Documentation: convert SubmittingPatches to AsciiDoc
 - Documentation: enable compat-mode for Asciidoctor

 The SubmittingPatches document has been converted to produce an
 HTML version via AsciiDoc/Asciidoctor.


* pb/bisect-helper-2 (2017-10-28) 8 commits
 - t6030: make various test to pass GETTEXT_POISON tests
 - bisect--helper: `bisect_start` shell function partially in C
 - bisect--helper: `get_terms` & `bisect_terms` shell function in C
 - bisect--helper: `bisect_next_check` shell function in C
 - bisect--helper: `check_and_set_terms` shell function in C
 - wrapper: move is_empty_file() and rename it as is_empty_or_missing_file()
 - bisect--helper: `bisect_write` shell function in C
 - bisect--helper: `bisect_reset` shell function in C
 (this branch uses pb/bisect-helper.)


* js/submodule-in-excluded (2017-10-26) 1 commit
  (merged to 'next' on 2017-10-26 at 2a262e6a0b)
 + status: do not get confused by submodules in excluded directories

 "git status --ignored -u" did not stop at a working tree of a
 separate project that is embedded in an ignored directory and
 listed files in that other project, instead of just showing the
 directory itself as ignored.

 Will cook in 'next'.


* tb/complete-checkout (2017-10-25) 1 commit
  (merged to 'next' on 2017-10-26 at beeaf5b00c)
 + completion: add remaining flags to checkout

 Command line completion (in contrib/) update.

 Will cook in 'next'.


* jc/ignore-cr-at-eol (2017-10-27) 2 commits
 - diff: --ignore-cr-at-eol
 - xdiff: reassign xpparm_t.flags bits

 The "diff" family of commands learned to ignore differences in
 carriage return at the end of line.

 Just a lunch-time hack.
 Lacks tests, docs and proper log message.


* sb/diff-color-moved-use-xdl-recmatch (2017-10-26) 2 commits
  (merged to 'next' on 2017-10-26 at 6711f24498)
 + diff.c: get rid of duplicate implementation
 + xdiff-interface: export comparing and hashing strings
 (this branch uses jk/diff-color-moved-fix.)

 Instead of using custom line comparison and hashing functions to
 implement "moved lines" coloring in the diff output, use the pair
 of these functions from lower-layer xdiff/ code.

 Will cook in 'next'.


* jh/dir-add-exclude-from-blob (2017-10-27) 1 commit
 - dir: allow exclusions from blob in addition to file

 The code to read exclusion list from a blob, which is used when the
 .gitignore file is outside a sparse checkout area, has been
 refactored so that other codepath can later use it to do the same
 outside the context of "sparse checkout".


* mh/avoid-rewriting-packed-refs (2017-10-30) 2 commits
 - files-backend: don't rewrite the `packed-refs` file unnecessarily
 - t1409: check that `packed-refs` is not rewritten unnecessarily

 Recent update to the refs infrastructure implementation started
 rewriting packed-refs file more often than before; this has been
 optimized again for most trivial cases.


* cc/git-packet-pm (2017-10-31) 7 commits
 - fixup! Git/Packet.pm: extract parts of t0021/rot13-filter.pl for reuse
 - Git/Packet.pm: extract parts of t0021/rot13-filter.pl for reuse
 - t0021/rot13-filter: add capability functions
 - t0021/rot13-filter: add packet_initialize()
 - t0021/rot13-filter: improve error message
 - t0021/rot13-filter: improve 'if .. elsif .. else' style
 - t0021/rot13-filter: refactor packet reading functions

 Parts of a test to drive the long-running content filter interface
 has been split into its own module, hopefully to eventually become
 reusable.

 Expecting a reroll.
 The original unfortunately is quite broken in error detection
 cases to make the result sub-par as a standalone module before it
 gets fixed.


* jk/diff-color-moved-fix (2017-10-21) 5 commits
  (merged to 'next' on 2017-10-26 at eb580e4c8c)
 + diff: handle NULs in get_string_hash()
 + diff: fix whitespace-skipping with --color-moved
 + t4015: test the output of "diff --color-moved -b"
 + t4015: check "negative" case for "-w --color-moved"
 + t4015: refactor --color-moved whitespace test
 (this branch is used by sb/diff-color-moved-use-xdl-recmatch.)

 The experimental "color moved lines differently in diff output"
 feature was buggy around "ignore whitespace changes" edges, whihch
 has been corrected.

 Will cook in 'next'.
 Most of the fixes to the incorrectly implemented custom helpers
 will go away with sb/diff-color-moved-use-xdl-recmatch topic.


* jk/misc-resolve-ref-unsafe-fixes (2017-10-21) 4 commits
  (merged to 'next' on 2017-10-26 at c327b2ec2f)
 + worktree: handle broken symrefs in find_shared_symref()
 + log: handle broken HEAD in decoration check
 + remote: handle broken symrefs
 + test-ref-store: avoid passing NULL to printf

 Some codepaths did not check for errors when asking what branch the
 HEAD points at, which have been fixed.

 Will cook in 'next'.


* ao/check-resolve-ref-unsafe-result (2017-10-21) 1 commit
  (merged to 'next' on 2017-10-26 at 84302ab59a)
 + commit: check result of resolve_ref_unsafe

 "git commit", after making a commit, did not check for errors when
 asking on what branch it made the commit, which has been correted.

 Will cook in 'next'.


* jm/status-ignored-files-list (2017-10-31) 4 commits
  (merged to 'next' on 2017-11-01 at fe51978a30)
 + status: test ignored modes
 + status: document options to show matching ignored files
 + status: report matching ignored and normal untracked
 + status: add option to show ignored files differently

 The set of paths output from "git status --ignored" was tied
 closely with its "--untracked=<mode>" option, but now it can be
 controlled more flexibly.  Most notably, a directory that is
 ignored because it is listed to be ignored in the ignore/exclude
 mechanism can be handled differently from a directory that ends up
 to be ignored only because all files in it are ignored.

 Will cook in 'next'.


* mp/push-pushoption-config (2017-10-24) 1 commit
  (merged to 'next' on 2017-10-26 at 2c72164d12)
 + builtin/push.c: add push.pushOption config

 The "--push-option=<string>" option to "git push" now defaults to a
 list of strings configured via push.pushOption variable.

 Will cook in 'next'.


* gc/gitweb-filetest-acl (2017-10-24) 1 commit
  (merged to 'next' on 2017-10-26 at 5b490f53bf)
 + gitweb: use filetest to allow ACLs

 "gitweb" checks if a directory is searchable with Perl's "-x"
 operator, which can be enhanced by using "filetest 'access'"
 pragma, which now we do.

 Will cook in 'next'.


* jn/ssh-wrappers (2017-10-30) 6 commits
 - fixup! ssh: 'auto' variant to select between 'ssh' and 'simple'
 - ssh: 'simple' variant does not support --port
 - ssh: 'simple' variant does not support -4/-6
 - ssh: 'auto' variant to select between 'ssh' and 'simple'
 - connect: split ssh command line options into separate function
 - connect: split git:// setup into a separate function
 (this branch uses bw/protocol-v1.)

 The ssh-variant 'simple' introduced earlier broke existing
 installations by not passing --port/-4/-6 and not diagnosing an
 attempt to pass these as an error.  Instead, default to
 automatically detect how compatible the GIT_SSH/GIT_SSH_COMMAND is
 to OpenSSH convention and then error out an invocation to make it
 easier to diagnose connection errors.

 Expecting a reroll.
 cf. <20171025163243.xmm7szrkwgblpgcc@aiede.mtv.corp.google.com>


* tg/deprecate-stash-save (2017-10-27) 3 commits
  (merged to 'next' on 2017-10-27 at 73b1edb73b)
 + stash: remove now superfluos help for "stash push"
 + stash: mark "git stash save" deprecated in the man page
 + stash: replace "git stash save" with "git stash push" in the documentation

 "git stash save" has been deprecated in favour of "git stash push".

 Will cook in 'next'.


* jc/check-ref-format-oor (2017-10-18) 3 commits
  (merged to 'next' on 2017-10-18 at 8b17566c80)
 + check-ref-format doc: --branch validates and expands <branch>
 + check-ref-format --branch: strip refs/heads/ using skip_prefix
 + check-ref-format --branch: do not expand @{...} outside repository

 "git check-ref-format --branch @{-1}" bit a "BUG()" when run
 outside a repository for obvious reasons; clarify the documentation
 and make sure we do not even try to expand the at-mark magic in
 such a case, but still call the validation logic for branch names.

 Will cook in 'next'.


* kd/auto-col-with-pager-fix (2017-10-24) 2 commits
  (merged to 'next' on 2017-10-24 at ef3ff0f14b)
 + column: do not include pager.c
  (merged to 'next' on 2017-10-18 at fe89ff7e83)
 + column: show auto columns when pager is active

 "auto" as a value for the columnar output configuration ought to
 judge "is the output consumed by humans?" with the same criteria as
 "auto" for coloured output configuration, i.e. either the standard
 output stream is going to tty, or a pager is in use.  We forgot the
 latter, which has been fixed.

 Will cook in 'next'.


* jc/t5601-copy-workaround (2017-10-17) 1 commit
  (merged to 'next' on 2017-10-18 at ea1e133968)
 + t5601: rm the target file of cp that could still be executing

 A (possibly flakey) test fix.

 Will cook in 'next'.


* jc/branch-name-sanity (2017-10-14) 3 commits
  (merged to 'next' on 2017-10-16 at 174646d1c3)
 + branch: forbid refs/heads/HEAD
 + branch: split validate_new_branchname() into two
 + branch: streamline "attr_only" handling in validate_new_branchname()

 "git branch" and "git checkout -b" are now forbidden from creating
 a branch whose name is "HEAD".

 Will cook in 'next'.


* jk/revision-pruning-optim (2017-10-14) 1 commit
  (merged to 'next' on 2017-10-16 at 2662baa21d)
 + revision: quit pruning diff more quickly when possible

 Pathspec-limited revision traversal was taught not to keep finding
 unneeded differences once it knows two trees are different inside
 given pathspec.

 Will cook in 'next'.


* wk/pull-signoff (2017-10-13) 1 commit
  (merged to 'next' on 2017-10-16 at 5e48f349d9)
 + pull: pass --signoff/--no-signoff to "git merge"

 "git pull" has been taught to accept "--[no-]signoff" option and
 pass it down to "git merge".

 Will cook in 'next'.


* dm/run-command-ignored-hook-advise (2017-10-10) 1 commit
  (merged to 'next' on 2017-10-10 at 0827814922)
 + run-command: add hint when a hook is ignored

 A hook script that is set unexecutable is simply ignored.  Git
 notifies when such a file is ignored, unless the message is
 squelched via advice.ignoredHook configuration.

 Will cook in 'next'.


* hv/fetch-moved-submodules-on-demand (2017-10-17) 3 commits
  (merged to 'next' on 2017-10-26 at c446ea3e9a)
 + submodule: simplify decision tree whether to or not to fetch
 + implement fetching of moved submodules
 + fetch: add test to make sure we stay backwards compatible

 "git fetch --recurse-submodules" now knows that submodules can be
 moved around in the superproject in addition to getting updated,
 and finds the ones that need to be fetched accordingly.

 Will cook in 'next'.


* js/for-each-ref-remote-name-and-ref (2017-10-11) 3 commits
 - for-each-ref: test :remotename and :remoteref
 - for-each-ref: let upstream/push optionally report the remote ref name
 - for-each-ref: let upstream/push optionally report the remote name

 The "--format=..." option "git for-each-ref" takes learned to show
 the name of the 'remote' repository and the ref at the remote side
 that is affected for 'upstream' and 'push' via "%(push:remotename)"
 and friends.

 Needs a bit more work on the documentation part.


* pb/bisect-helper (2017-10-06) 6 commits
  (merged to 'next' on 2017-10-13 at ffc9aefe63)
 + bisect--helper: `is_expected_rev` & `check_expected_revs` shell function in C
 + t6030: explicitly test for bisection cleanup
 + bisect--helper: `bisect_clean_state` shell function in C
 + bisect--helper: `write_terms` shell function in C
 + bisect--helper: rewrite `check_term_format` shell function in C
 + bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
 (this branch is used by pb/bisect-helper-2.)

 An early part of piece-by-piece rewrite of "git bisect".

 Will cook in 'next'.


* bc/object-id (2017-10-16) 25 commits
  (merged to 'next' on 2017-10-18 at ef8aa2698d)
 + refs/files-backend: convert static functions to object_id
 + refs: convert read_raw_ref backends to struct object_id
 + refs: convert peel_object to struct object_id
 + refs: convert resolve_ref_unsafe to struct object_id
 + worktree: convert struct worktree to object_id
 + refs: convert resolve_gitlink_ref to struct object_id
 + Convert remaining callers of resolve_gitlink_ref to object_id
 + sha1_file: convert index_path and index_fd to struct object_id
 + refs: convert reflog_expire parameter to struct object_id
 + refs: convert read_ref_at to struct object_id
 + refs: convert peel_ref to struct object_id
 + builtin/pack-objects: convert to struct object_id
 + pack-bitmap: convert traverse_bitmap_commit_list to object_id
 + refs: convert dwim_log to struct object_id
 + builtin/reflog: convert remaining unsigned char uses to object_id
 + refs: convert dwim_ref and expand_ref to struct object_id
 + refs: convert read_ref and read_ref_full to object_id
 + refs: convert resolve_refdup and refs_resolve_refdup to struct object_id
 + Convert check_connected to use struct object_id
 + refs: update ref transactions to use struct object_id
 + refs: prevent accidental NULL dereference in write_pseudoref
 + refs: convert update_ref and refs_update_ref to use struct object_id
 + refs: convert delete_ref and refs_delete_ref to struct object_id
 + refs/files-backend: convert struct ref_to_prune to object_id
 + walker: convert to struct object_id
 (this branch is used by mh/tidy-ref-update-flags.)

 Conversion from uchar[20] to struct object_id continues.

 Will cook in 'next'.


* jc/no-cmd-as-subroutine (2017-10-11) 2 commits
  (merged to 'next' on 2017-10-16 at 5f4ee919ac)
 + merge-ours: do not use cmd_*() as a subroutine
 + describe: do not use cmd_*() as a subroutine

 Calling cmd_foo() as if it is a general purpose helper function is
 a no-no.  Correct two instances of such to set an example.

 Will cook in 'next'.


* jc/merge-symlink-ours-theirs (2017-09-26) 1 commit
 - merge: teach -Xours/-Xtheirs to symbolic link merge

 "git merge -Xours/-Xtheirs" learned to use our/their version when
 resolving a conflicting updates to a symbolic link.

 Needs review.


* jt/partial-clone-lazy-fetch (2017-10-02) 18 commits
 - fetch-pack: restore save_commit_buffer after use
 - unpack-trees: batch fetching of missing blobs
 - clone: configure blobmaxbytes in created repos
 - clone: support excluding large blobs
 - fetch: support excluding large blobs
 - fetch: refactor calculation of remote list
 - fetch-pack: support excluding large blobs
 - pack-objects: support --blob-max-bytes
 - pack-objects: rename want_.* to ignore_.*
 - gc: do not repack promisor packfiles
 - rev-list: support termination at promisor objects
 - sha1_file: support lazily fetching missing objects
 - introduce fetch-object: fetch one promisor object
 - index-pack: refactor writing of .keep files
 - fsck: support promisor objects as CLI argument
 - fsck: support referenced promisor objects
 - fsck: support refs pointing to promisor objects
 - fsck: introduce partialclone extension

 A journey for "git clone" and "git fetch" to become "lazier" by
 depending more on its remote repository---this is the beginning of
 it.

 Expecting a reroll.
 cf. <CAGf8dgLu-TeK8KbHv-U+18O+L2TxKcGv5vFFHy38J6a_YXRfew@mail.gmail.com>


* ma/lockfile-fixes (2017-10-07) 12 commits
  (merged to 'next' on 2017-10-16 at 19fae5c138)
 + read_cache: roll back lock in `update_index_if_able()`
 + read-cache: leave lock in right state in `write_locked_index()`
 + read-cache: drop explicit `CLOSE_LOCK`-flag
 + cache.h: document `write_locked_index()`
 + apply: remove `newfd` from `struct apply_state`
 + apply: move lockfile into `apply_state`
 + cache-tree: simplify locking logic
 + checkout-index: simplify locking logic
 + tempfile: fix documentation on `delete_tempfile()`
 + lockfile: fix documentation on `close_lock_file_gently()`
 + treewide: prefer lockfiles on the stack
 + sha1_file: do not leak `lock_file`

 An earlier update made it possible to use an on-stack in-core
 lockfile structure (as opposed to having to deliberately leak an
 on-heap one).  Many codepaths have been updated to take advantage
 of this new facility.

 Will cook in 'next'.


* ot/mru-on-list (2017-10-01) 1 commit
  (merged to 'next' on 2017-10-07 at e6ad4a16a2)
 + mru: use double-linked list from list.h

 The first step to getting rid of mru API and using the
 doubly-linked list API directly instead.

 Will cook in 'next'.


* jm/svn-pushmergeinfo-fix (2017-09-17) 1 commit
 - git-svn: fix svn.pushmergeinfo handling of svn+ssh usernames.

 "git svn dcommit" did not take into account the fact that a
 svn+ssh:// URL with a username@ (typically used for pushing) refers
 to the same SVN repository without the username@ and failed when
 svn.pushmergeinfo option is set.

 Needs a test, perhaps as a follow-up patch.


* mg/merge-base-fork-point (2017-09-17) 3 commits
 - merge-base: find fork-point outside partial reflog
 - merge-base: return fork-point outside reflog
 - t6010: test actual test output

 "merge-base --fork-point $branch $commit" is used to guess on which
 commit among the commits that were once at the tip of the $branch the
 $commit was built on top of, and it learns these historical tips from
 the reflog of the $branch.  When the true fork-point is lost due to
 pruning of old reflog entries, the command does not give any output,
 because it has no way to guess correctly and does not want to mislead
 the user with a wrong guess.

 The command has been updated to give the best but not known to be
 correct guess, based on a hope that a merge-base between $commit and a
 virtual merge across all the reflog entries that still are available
 for $branch may still be a closer to the true fork-point than the
 merge-base between $commit and the current tip of the $branch.

 This may have to be offered by an additional option, to allow the
 users that are prepared to see a potentially incorrect guess to opt
 into the feature, without affecting the current callers that may not
 be prepared to accept a guess that is not known to be correct.

 What's the doneness of this one?


* ds/find-unique-abbrev-optim (2017-10-13) 4 commits
  (merged to 'next' on 2017-10-16 at 7f4479ac52)
 + sha1_name: minimize OID comparisons during disambiguation
 + sha1_name: parse less while finding common prefix
 + sha1_name: unroll len loop in find_unique_abbrev_r()
 + p4211-line-log.sh: add log --online --raw --parents perf test

 Optimize the code to find shortest unique prefix of object names.

 Will cook in 'next'.


* cc/perf-run-config (2017-09-24) 9 commits
 - perf: store subsection results in "test-results/$GIT_PERF_SUBSECTION/"
 - perf/run: show name of rev being built
 - perf/run: add run_subsection()
 - perf/run: update get_var_from_env_or_config() for subsections
 - perf/run: add get_subsections()
 - perf/run: add calls to get_var_from_env_or_config()
 - perf/run: add GIT_PERF_DIRS_OR_REVS
 - perf/run: add get_var_from_env_or_config()
 - perf/run: add '--config' option to the 'run' script

 Needs review.


* bp/fsmonitor (2017-10-05) 15 commits
  (merged to 'next' on 2017-10-05 at 964a029d13)
 + fsmonitor: preserve utf8 filenames in fsmonitor-watchman log
 + fsmonitor: read entirety of watchman output
 + fsmonitor: MINGW support for watchman integration
  (merged to 'next' on 2017-10-02 at cf0c67979c)
 + fsmonitor: add a performance test
 + fsmonitor: add a sample integration script for Watchman
 + fsmonitor: add test cases for fsmonitor extension
 + split-index: disable the fsmonitor extension when running the split index test
 + fsmonitor: add a test tool to dump the index extension
 + update-index: add fsmonitor support to update-index
 + ls-files: Add support in ls-files to display the fsmonitor valid bit
 + fsmonitor: add documentation for the fsmonitor extension.
 + fsmonitor: teach git to optionally utilize a file system monitor to speed up detecting new or changed files.
 + update-index: add a new --force-write-index option
 + preload-index: add override to enable testing preload-index
 + bswap: add 64 bit endianness helper get_be64
 (this branch is used by av/fsmonitor.)

 We learned to talk to watchman to speed up "git status" and other
 operations that need to see which paths have been modified.

 Will cook in 'next'.


* bw/protocol-v1 (2017-10-17) 11 commits
  (merged to 'next' on 2017-10-18 at 835fe09e50)
 + Documentation: document Extra Parameters
 + ssh: introduce a 'simple' ssh variant
 + i5700: add interop test for protocol transition
 + http: tell server that the client understands v1
 + connect: tell server that the client understands v1
 + connect: teach client to recognize v1 server response
 + upload-pack, receive-pack: introduce protocol version 1
 + daemon: recognize hidden request arguments
 + protocol: introduce protocol extension mechanisms
 + pkt-line: add packet_write function
 + connect: in ref advertisement, shallows are last
 (this branch is used by jn/ssh-wrappers.)

 A new mechanism to upgrade the wire protocol in place is proposed
 and demonstrated that it works with the older versions of Git
 without harming them.

 Will cook in 'next'.


* pc/submodule-helper (2017-10-07) 3 commits
  (merged to 'next' on 2017-10-16 at 2b38de12cc)
 + submodule: port submodule subcommand 'status' from shell to C
 + submodule--helper: introduce for_each_listed_submodule()
 + submodule--helper: introduce get_submodule_displaypath()

 GSoC.
 Will cook in 'next'.


* bc/hash-algo (2017-10-30) 4 commits
 - Switch empty tree and blob lookups to use hash abstraction
 - Integrate hash algorithm support with repo setup
 - Add structure representing hash algorithm
 - setup: expose enumerated repo info

 An infrastructure to define what hash function is used in Git is
 introduced, and an effort to plumb that throughout various
 codepaths has been started.

 cf. <20171028181239.59458-1-sandals@crustytoothpaste.net>


* jk/drop-ancient-curl (2017-08-09) 5 commits
 - http: #error on too-old curl
 - curl: remove ifdef'd code never used with curl >=7.19.4
 - http: drop support for curl < 7.19.4
 - http: drop support for curl < 7.16.0
 - http: drop support for curl < 7.11.1

 Some code in http.c that has bitrot is being removed.

 Will be rerolled after tc/curl-with-backports stabilizes.


* sb/submodule-recursive-checkout-detach-head (2017-07-28) 2 commits
  (merged to 'next' on 2017-10-26 at 30994b4c76)
 + Documentation/checkout: clarify submodule HEADs to be detached
 + recursive submodules: detach HEAD from new state

 "git checkout --recursive" may overwrite and rewind the history of
 the branch that happens to be checked out in submodule
 repositories, which might not be desirable.  Detach the HEAD but
 still allow the recursive checkout to succeed in such a case.

 Undecided.
 This needs justification in a larger picture; it is unclear why
 this is better than rejecting recursive checkout, for example.


* ex/deprecate-empty-pathspec-as-match-all (2017-06-23) 2 commits
  (merged to 'next' on 2017-08-14 at 24db08a6e8)
 + pathspec: die on empty strings as pathspec
 + t0027: do not use an empty string as a pathspec element

 The final step to make an empty string as a pathspec element
 illegal.  We started this by first deprecating and warning a
 pathspec that has such an element in 2.11 (Nov 2016).

 Hopefully we can merge this down to the 'master' by the end of the
 year?  A deprecation warning period that is about 1 year does not
 sound too bad.

 Will cook in 'next'.
 As the draft RelNotes says, let's merge this to 'master' after
 this release cycle.

--------------------------------------------------
[Discarded]

* jk/ui-color-always-to-auto-maint (2017-10-13) 2 commits
  (merged to 'next' on 2017-10-13 at bb16e1edc8)
 + color: document that "git -c color.*=always" is a bit special
 + color: downgrade "always" to "auto" only for on-disk configuration

 It turns out that "git -c color.ui=always cmd" is relied on by many
 third-party tools as a way to force coloured output no matter what
 the end-user configuration is, and a recent attempt to downgrade
 'always' to 'auto' to fix the regression to "git add -p" broke it.

 This has been reverted from 'next'.
