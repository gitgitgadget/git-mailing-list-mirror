From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Oct 2014, #05; Mon, 20)
Date: Mon, 20 Oct 2014 14:41:11 -0700
Message-ID: <xmqqtx2y1kso.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Wong <normalperson@yhbt.net>,
	Paul Mackerras <paulus@samba.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 20 23:41:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgKiD-0001td-W5
	for gcvg-git-2@plane.gmane.org; Mon, 20 Oct 2014 23:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753136AbaJTVlx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2014 17:41:53 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62501 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753651AbaJTVlO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2014 17:41:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3176F1799A;
	Mon, 20 Oct 2014 17:41:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=t
	Plm84rhjYjIVyLqkOfSLmzflV0=; b=oqzTmfZAWfx4bZo5j0NiVgPsW17jXanHl
	TPsmJatzgzBzGvBsswI17m4VtMFO/xn8yUGI0pvSSjyumt4ar2vMoQZrGkuXQbJs
	gSk5FwY+lTPkc+SyTx1KEV1cL6YfK1xFJm/Ca4MNrZpVZoV5TsPuIMcbfa2KZ8lK
	9R0PI/E43U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=mWWkAgsjJWXQvI4s2X942y0jLHkay4gI1eQwyMJXgrDi/zJmxWDK3aB5
	hyeDKPFrrt4dZESqVLjSCv+670qQPVb5AI+wc/WaP4dNQECR19NNDBzunNU6n88E
	i4pSh8NRQ5C3qQqHpOh8vN1E6E/K3XfVvg4n5MlNy1vBCJee3yE=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 27FB517999;
	Mon, 20 Oct 2014 17:41:13 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5C77017998;
	Mon, 20 Oct 2014 17:41:12 -0400 (EDT)
X-master-at: 13da0fc092b8cf082eda2f16971c75903aa5aefc
X-next-at: 72aedf1b35ff671435dd29c2b62e2b2250805689
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CF9A101E-58A1-11E4-B0C5-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

According to tinyurl.com/gitCal, the feature freeze for this cycle
is scheduled to happen at the end of this month.  What's in the
'next' branch as of today gives us a more or less complete picture,
I would think.  I'd like to ask area maintainers of git-svn, gitk
and git-gui to please prepare to wrap up the accumulated changes for
this cycle and throw a pull request to me.  Thanks.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* bc/asciidoc (2014-10-13) 2 commits
  (merged to 'next' on 2014-10-14 at d9ff206)
 + Documentation: fix mismatched delimiters in git-imap-send
 + Documentation: adjust document title underlining
 (this branch is used by bc/asciidoctor.)

 Formatting nitpicks to help a (pickier) reimplementation of
 AsciiDoc to grok our documentation.


* cc/interpret-trailers (2014-10-13) 11 commits
  (merged to 'next' on 2014-10-17 at ee4519c)
 + Documentation: add documentation for 'git interpret-trailers'
 + trailer: add tests for commands in config file
 + trailer: execute command from 'trailer.<name>.command'
 + trailer: add tests for "git interpret-trailers"
 + trailer: add interpret-trailers command
 + trailer: put all the processing together and print
 + trailer: parse trailers from file or stdin
 + trailer: process command line trailer arguments
 + trailer: read and process config information
 + trailer: process trailers from input message and arguments
 + trailer: add data structures and basic functions

 A new filter to programatically edit the tail end of the commit log
 messages.


* jk/test-shell-trace (2014-10-13) 3 commits
  (merged to 'next' on 2014-10-14 at 9118506)
 + test-lib.sh: support -x option for shell-tracing
 + t5304: use helper to report failure of "test foo = bar"
 + t5304: use test_path_is_* instead of "test -f"
 (this branch is used by jk/prune-mtime.)

 Test scripts were taught to notice "-x" option to show shell trace,
 as if the tests were run under "sh -x".


* jn/parse-config-slot (2014-10-14) 2 commits
  (merged to 'next' on 2014-10-14 at 7f0a3ad)
 + color_parse: do not mention variable name in error message
 + pass config slots as pointers instead of offsets

 Code cleanup.


* rm/gitweb-start-form (2014-10-16) 1 commit
  (merged to 'next' on 2014-10-17 at 7ca427f)
 + gitweb: use start_form, not startform that was removed in CGI.pm 4.04


* rs/receive-pack-argv-leak-fix (2014-10-13) 1 commit
  (merged to 'next' on 2014-10-14 at e64654d)
 + receive-pack: plug minor memory leak in unpack()


* ss/contrib-subtree-contacts (2014-10-15) 2 commits
  (merged to 'next' on 2014-10-17 at 4b3a1d9)
 + contacts: add a Makefile to generate docs and install
 + subtree: add an install-html target


* ta/config-set (2014-10-13) 1 commit
  (merged to 'next' on 2014-10-14 at ed660e4)
 + t1308: fix broken here document in test script

--------------------------------------------------
[New Topics]

* jk/pack-objects-no-bitmap-when-splitting (2014-10-19) 1 commit
 - pack-objects: turn off bitmaps when we split packs

 Splitting pack-objects output into multiple packs is incompatible
 with the use of reachability bitmap.

 Will merge to 'next'.


* po/doc-status-markup (2014-10-19) 1 commit
 - doc: fix 'git status --help' character quoting

 Update documentation mark-up.

 Will merge to 'next'.


* rs/run-command-env-array (2014-10-19) 2 commits
 - use env_array member of struct child_process
 - run-command: add env_array, an optional argv_array for env

 Add managed "env" array to child_process to clarify the lifetime
 rules.

 Will merge to 'next'.


* tb/core-filemode-doc (2014-10-19) 1 commit
 - core.filemode may need manual action

 Doc update.

 Will merge to 'next'.


* wk/t1304-wo-USER (2014-10-19) 1 commit
 - t1304: Set LOGNAME even if USER is unset or null

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* je/quiltimport-no-fuzz (2014-09-26) 2 commits
 - git-quiltimport: flip the default not to allow fuzz
 - git-quiltimport.sh: allow declining fuzz with --exact option

 "quiltimport" drove "git apply" always with -C1 option to reduce
 context of the patch in order to give more chance to somewhat stale
 patches to apply.  Add an "--exact" option to disable, and also
 "-C$n" option to customize this behaviour.  The top patch
 optionally flips the default to "--exact".

 Waiting for an Ack.


* tr/remerge-diff (2014-09-08) 8 commits
 - log --remerge-diff: show what the conflict resolution changed
 - name-hash: allow dir hashing even when !ignore_case
 - merge-recursive: allow storing conflict hunks in index
 - merge_diff_mode: fold all merge diff variants into an enum
 - combine-diff: do not pass revs->dense_combined_merges redundantly
 - merge-recursive: -Xindex-only to leave worktree unchanged
 - merge-recursive: internal flag to avoid touching the worktree
 - merge-recursive: remove dead conditional in update_stages()

 "log -p" output learns a new way to let users inspect a merge
 commit by showing the differences between the automerged result
 with conflicts the person who recorded the merge would have seen
 and the final conflict resolution that was recorded in the merge.

 Waiting for a reroll ($gmane/256591).


* hv/submodule-config (2014-06-30) 4 commits
 - do not die on error of parsing fetchrecursesubmodules option
 - use new config API for worktree configurations of submodules
 - extract functions for submodule config set and lookup
 - implement submodule config cache for lookup of submodule names

 Kicked back to 'pu' per request ($gmane/255610).


* jt/timer-settime (2014-08-29) 6 commits
 - use timer_settime() for new platforms
 - autoconf: check for timer_settime()
 - autoconf: check for struct itimerspec
 - autoconf: check for struct sigevent
 - autoconf: check for struct timespec
 - autoconf: check for timer_t

 Reviewed, discussed and wanting for a reroll.


* jk/pack-bitmap (2014-08-04) 1 commit
 - pack-bitmap: do not use gcc packed attribute

 Hold, waiting for Karsten's replacement.


* jk/tag-contains (2014-06-30) 8 commits
 . perf: add tests for tag --contains
 . tag: use commit_contains
 . commit: provide a fast multi-tip contains function
 . string-list: add pos to iterator callback
 . add functions for memory-efficient bitmaps
 . paint_down_to_common: use prio_queue
 . tag: factor out decision to stream tags
 . tag: allow --sort with -n

 Expecting a reroll.


* ab/add-interactive-show-diff-func-name (2014-05-12) 2 commits
 - SQUASH??? git-add--interactive: Preserve diff heading when splitting hunks
 - git-add--interactive: Preserve diff heading when splitting hunks

 Waiting for a reroll.


* jn/gitweb-utf8-in-links (2014-05-27) 1 commit
 - gitweb: Harden UTF-8 handling in generated links

 $gmane/250758?


* ss/userdiff-update-csharp-java (2014-06-02) 2 commits
 - userdiff: support Java try keyword
 - userdiff: support C# async methods and correct C# keywords

 Reviews sent; waiting for a response.


* bg/rebase-off-of-previous-branch (2014-04-16) 1 commit
 - git-rebase: print name of rev when using shorthand

 Teach "git rebase -" to report the concrete name of the branch
 (i.e. the previous one).

 But it stops short and does not do the same for "git rebase @{-1}".
 Expecting a reroll.


* jk/makefile (2014-02-05) 16 commits
 . FIXUP
 . move LESS/LV pager environment to Makefile
 . Makefile: teach scripts to include make variables
 . FIXUP
 . Makefile: auto-build C strings from make variables
 . Makefile: drop *_SQ variables
 . FIXUP
 . Makefile: add c-quote helper function
 . Makefile: introduce sq function for shell-quoting
 . Makefile: always create files via make-var
 . Makefile: store GIT-* sentinel files in MAKE/
 . Makefile: prefer printf to echo for GIT-*
 . Makefile: use tempfile/mv strategy for GIT-*
 . Makefile: introduce make-var helper function
 . Makefile: fix git-instaweb dependency on gitweb
 . Makefile: drop USE_GETTEXT_SCHEME from GIT-CFLAGS

 Simplify the Makefile rules and macros that exist primarily for
 quoting purposes, and make it easier to robustly express the
 dependency rules.

 Expecting a reroll.


* rb/merge-prepare-commit-msg-hook (2014-01-10) 4 commits
 - merge: drop unused arg from abort_commit method signature
 - merge: make prepare_to_commit responsible for write_merge_state
 - t7505: ensure cleanup after hook blocks merge
 - t7505: add missing &&

 Expose more merge states (e.g. $GIT_DIR/MERGE_MODE) to hooks that
 run during "git merge".  The log message stresses too much on one
 hook, prepare-commit-msg, but it would equally apply to other hooks
 like post-merge, I think.

 Waiting for a reroll.


* jc/graph-post-root-gap (2013-12-30) 3 commits
 - WIP: document what we want at the end
 - graph: remove unused code a bit
 - graph: stuff the current commit into graph->columns[]

 This was primarily a RFH ($gmane/239580).


* tg/perf-lib-test-perf-cleanup (2013-09-19) 2 commits
 - perf-lib: add test_perf_cleanup target
 - perf-lib: split starting the test from the execution

 Add test_perf_cleanup shell function to the perf suite, that allows
 the script writers to define a test with a clean-up action.

 Will hold.


* jc/show-branch (2014-03-24) 5 commits
 - show-branch: use commit slab to represent bitflags of arbitrary width
 - show-branch.c: remove "all_mask"
 - show-branch.c: abstract out "flags" operation
 - show-branch.c: lift all_mask/all_revs to a global static
 - show-branch.c: update comment style

 Waiting for the final step to lift the hard-limit before sending it out.

--------------------------------------------------
[Cooking]

* eb/no-pthreads (2014-10-19) 3 commits
 - Handle atexit list internaly for unthreaded builds
 - pack-objects: set number of threads before checking and warning
 - index-pack: fix compilation with NO_PTHREADS

 Allow us build with NO_PTHREADS=NoThanks compilation option.  The
 last change (not queued) needs a bit more explanation in its log
 message.

 Will merge to 'next'.


* da/mergetool-temporary-directory (2014-10-16) 2 commits
  (merged to 'next' on 2014-10-17 at 261e74e)
 + t7610-mergetool: add test cases for mergetool.writeToTemp
 + mergetool: add an option for writing to a temporary directory
 (this branch uses da/mergetool-temporary-filename and da/mergetool-tests; is tangled with da/mergetool-tool-help.)

 Allow a temporary directory specified to be used while running "git
 mergetool" backend.

 Will merge to 'master'.


* da/mergetool-tests (2014-10-16) 4 commits
  (merged to 'next' on 2014-10-17 at 239fefe)
 + test-lib-functions: adjust style to match CodingGuidelines
 + t7610-mergetool: use test_config to isolate tests
 + t7610-mergetool: add missing && and remove commented-out code
 + t7610-mergetool: use tabs instead of a mix of tabs and spaces
 (this branch is used by da/mergetool-temporary-directory and da/mergetool-temporary-filename; is tangled with da/mergetool-tool-help.)

 The clean-up of this test script was long overdue and is a very
 welcome change.

 Will merge to 'master'.


* bc/asciidoctor (2014-10-15) 2 commits
  (merged to 'next' on 2014-10-17 at 12ce2e2)
 + Documentation: implement linkgit macro for Asciidoctor
 + Documentation: move some AsciiDoc parameters into variables

 Add machinery to alternatively use AsciiDoctor to format our
 documentation.

 Brian seems to have a bit more tweaks; will wait for them before
 moving this topic forward.


* da/mergetool-meld (2014-10-16) 1 commit
  (merged to 'next' on 2014-10-17 at 00ee553)
 + mergetools/meld: make usage of `--output` configurable and more robust

 Newer versions of 'meld' breaks the auto-detection we use to see if
 they are new enough to support the `--output` option.

 Will merge to 'master'.


* jk/prune-mtime (2014-10-19) 28 commits
  (merged to 'next' on 2014-10-20 at fdd7ff6)
 + drop add_object_array_with_mode
 + revision: remove definition of unused 'add_object' function
 + pack-objects: double-check options before discarding objects
 + repack: pack objects mentioned by the index
 + pack-objects: use argv_array
 + reachable: use revision machinery's --indexed-objects code
 + rev-list: add --indexed-objects option
 + rev-list: document --reflog option
 + t5516: test pushing a tag of an otherwise unreferenced blob
 + traverse_commit_list: support pending blobs/trees with paths
 + make add_object_array_with_context interface more sane
 + write_sha1_file: freshen existing objects
 + pack-objects: match prune logic for discarding objects
 + pack-objects: refactor unpack-unreachable expiration check
 + prune: keep objects reachable from recent objects
 + sha1_file: add for_each iterators for loose and packed objects
 + count-objects: use for_each_loose_file_in_objdir
 + count-objects: do not use xsize_t when counting object size
 + prune-packed: use for_each_loose_file_in_objdir
 + reachable: mark index blobs as SEEN
 + prune: factor out loose-object directory traversal
 + reachable: reuse revision.c "add all reflogs" code
 + reachable: use traverse_commit_list instead of custom walk
 + clean up name allocation in prepare_revision_walk
 + object_array: add a "clear" function
 + object_array: factor out slopbuf-freeing logic
 + isxdigit: cast input to unsigned char
 + foreach_alt_odb: propagate return value from callback

 Tighten the logic to decide that an unreachable cruft is
 sufficiently old by covering corner cases such as an ancient object
 becoming reachable and then going unreachable again, in which case
 its retention period should be prolonged.

 Will merge to 'master'.


* rs/ref-transaction (2014-10-15) 25 commits
  (merged to 'next' on 2014-10-17 at 1390624)
 + ref_transaction_commit: bail out on failure to remove a ref
 + lockfile: remove unable_to_lock_error
 + refs.c: do not permit err == NULL
 + remote rm/prune: print a message when writing packed-refs fails
 + for-each-ref: skip and warn about broken ref names
 + refs.c: allow listing and deleting badly named refs
 + test: put tests for handling of bad ref names in one place
 + packed-ref cache: forbid dot-components in refnames
 + branch -d: simplify by using RESOLVE_REF_READING
 + branch -d: avoid repeated symref resolution
 + reflog test: test interaction with detached HEAD
 + refs.c: change resolve_ref_unsafe reading argument to be a flags field
 + refs.c: make write_ref_sha1 static
 + fetch.c: change s_update_ref to use a ref transaction
 + refs.c: ref_transaction_commit: distinguish name conflicts from other errors
 + refs.c: pass a list of names to skip to is_refname_available
 + refs.c: call lock_ref_sha1_basic directly from commit
 + refs.c: refuse to lock badly named refs in lock_ref_sha1_basic
 + rename_ref: don't ask read_ref_full where the ref came from
 + refs.c: pass the ref log message to _create/delete/update instead of _commit
 + refs.c: add an err argument to delete_ref_loose
 + wrapper.c: add a new function unlink_or_msg
 + refs.c: lock_ref_sha1_basic is used for all refs
 + wrapper.c: remove/unlink_or_warn: simplify, treat ENOENT as success
 + mv test: recreate mod/ directory instead of relying on stale copy

 The API to update refs have been restructured to allow introducing
 a true transactional updates later.  We would even allow storing
 refs in backends other than the traditional filesystem-based one.

 Will merge to 'master'.


* da/mergetool-tool-help (2014-10-15) 8 commits
  (merged to 'next' on 2014-10-17 at 854654c)
 + difftool: don't assume that default sh is sane
 + mergetool: don't require a work tree for --tool-help
 + git-sh-setup: move GIT_DIR initialization into a function
 + mergetool: use more conservative temporary filenames
 + test-lib-functions: adjust style to match CodingGuidelines
 + t7610-mergetool: prefer test_config over git config
 + t7610-mergetool: add missing && and remove commented-out code
 + t7610-mergetool: use tabs instead of a mix of tabs and spaces
 (this branch is tangled with da/mergetool-temporary-directory, da/mergetool-temporary-filename and da/mergetool-tests.)

 Allow "git mergetool --help" to run outside a Git repository.

 Will merge to 'master'.


* jc/checkout-local-track-report (2014-10-14) 1 commit
 - checkout: report upstream correctly even with loosely defined branch.*.merge

 The report from "git checkout" on a branch that builds on another
 local branch by setting its branch.*.merge to branch name (not a
 full refname) incorrectly said that the upstream is gone.

 Will merge to 'next'.


* jc/clone-borrow (2014-10-15) 1 commit
 - clone: --dissociate option to mark that reference is only temporary

 Allow "git clone --reference" to be used more safely.


* js/completion-hide-not-a-repo (2014-10-14) 1 commit
  (merged to 'next' on 2014-10-17 at 466de3c)
 + completion: silence "fatal: Not a git repository" error

 Some internal error messages leaked out of the bash completion when
 typing "git cmd <TAB>" and the machinery tried to complete
 refnames.

 Will merge to 'master'.


* da/mergetool-temporary-filename (2014-10-16) 1 commit
  (merged to 'next' on 2014-10-17 at 3fb95b5)
 + mergetool: use more conservative temporary filenames
 (this branch is used by da/mergetool-temporary-directory; uses da/mergetool-tests; is tangled with da/mergetool-tool-help.)

 Tweak the names of the three throw-away files "git mergetool" comes
 up with to feed the merge tool backend, so that a file with a
 single dot in its name in the original (e.g. "hello.c") will have
 only one dot in these variants (e.g. "hello_BASE_4321.c").

 Will merge to 'master'.


* jc/push-cert-hmac-optim (2014-09-25) 2 commits
 - receive-pack: truncate hmac early and convert only necessary bytes
 - sha1_to_hex: split out "hex-format n bytes" helper and use it

 This is "we could do this if we wanted to", not "we measured and it
 improves performance critical codepath".

 Will perhaps drop.


* nd/multiple-work-trees (2014-09-27) 32 commits
 . t2025: add a test to make sure grafts is working from a linked checkout
 . checkout: don't require a work tree when checking out into a new one
 . git_path(): keep "info/sparse-checkout" per work-tree
 . count-objects: report unused files in $GIT_DIR/worktrees/...
 . gc: support prune --worktrees
 . gc: factor out gc.pruneexpire parsing code
 . gc: style change -- no SP before closing parenthesis
 . checkout: clean up half-prepared directories in --to mode
 . checkout: reject if the branch is already checked out elsewhere
 . prune: strategies for linked checkouts
 . checkout: support checking out into a new working directory
 . use new wrapper write_file() for simple file writing
 . wrapper.c: wrapper to open a file, fprintf then close
 . setup.c: support multi-checkout repo setup
 . setup.c: detect $GIT_COMMON_DIR check_repository_format_gently()
 . setup.c: convert check_repository_format_gently to use strbuf
 . setup.c: detect $GIT_COMMON_DIR in is_git_directory()
 . setup.c: convert is_git_directory() to use strbuf
 . git-stash: avoid hardcoding $GIT_DIR/logs/....
 . *.sh: avoid hardcoding $GIT_DIR/hooks/...
 . git-sh-setup.sh: use rev-parse --git-path to get $GIT_DIR/objects
 . $GIT_COMMON_DIR: a new environment variable
 . commit: use SEQ_DIR instead of hardcoding "sequencer"
 . fast-import: use git_path() for accessing .git dir instead of get_git_dir()
 . reflog: avoid constructing .lock path with git_path
 . *.sh: respect $GIT_INDEX_FILE
 . git_path(): be aware of file relocation in $GIT_DIR
 . path.c: group git_path(), git_pathdup() and strbuf_git_path() together
 . path.c: rename vsnpath() to do_git_path()
 . git_snpath(): retire and replace with strbuf_git_path()
 . path.c: make get_pathname() call sites return const char *
 . path.c: make get_pathname() return strbuf instead of static buffer

 A replacement for contrib/workdir/git-new-workdir that does not
 rely on symbolic links and make sharing of objects and refs safer
 by making the borrowee and borrowers aware of each other.

 A few tests need some tweaks for MinGW ($gmane/{257756,257757}).
 Conflicts with rs/ref-transaction so ejected for now, waiting for a
 reroll.


* mt/patch-id-stable (2014-06-10) 1 commit
 - patch-id: change default to stable

 Teaches "git patch-id" to compute the patch ID that does not change
 when the files in a single patch is reordered. As this new algorithm
 is backward incompatible, the last bit to flip it to be the default
 is left out of 'master' for now.

 Nobody seems to be jumping up & down requesting this last step,
 which makes the result somewhat backward incompatible.
 Will perhaps drop.

--------------------------------------------------
[Discarded]

* rr/mergetool-temporary-filename-tweak (2014-08-21) 1 commit
 . Allow the user to change the temporary file name for mergetool

 Needed rerolling (new paragraph in doc seems to be in a wrong place)
 for quite some time but without any activity.


* cb/mergetool-difftool (2014-07-21) 2 commits
 . difftool: don't assume that default sh is sane
 . mergetool: don't require a work tree for --tool-help

 Rerolled as da/mergetool-tool-help topic.


* rh/prompt-tests (2014-06-05) 11 commits
 . t9904: new __git_ps1 tests for Zsh
 . test-lib: make it possible to override how test code is eval'd
 . lib-prompt-tests.sh: add variable for string that encodes percent in PS1
 . lib-prompt-tests.sh: put all tests inside a function
 . t9903: move prompt tests to a new lib-prompt-tests.sh file
 . t9903: move PS1 color code variable definitions to lib-bash.sh
 . t9903: include "Bash" in test names via new $shellname var
 . t9903: run pc mode tests again with PS1 expansion disabled
 . t9903: move test name prefix to a separate variable
 . t9903: put the Bash pc mode prompt test cases in a function
 . t9903: remove Zsh test from the suite of Bash prompt tests

 Was expecting a reroll to limit the damage to test_eval_; also
 reported to be broken with older zsh that are still in the field
 ($gmane/251231).
