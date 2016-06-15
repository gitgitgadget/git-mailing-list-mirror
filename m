From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Nov 2014, #02; Tue, 11)
Date: Tue, 11 Nov 2014 15:09:37 -0800
Message-ID: <xmqqa93x5o7i.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 12 00:09:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoKZI-0003ul-Sm
	for gcvg-git-2@plane.gmane.org; Wed, 12 Nov 2014 00:09:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752538AbaKKXJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2014 18:09:44 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57800 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752532AbaKKXJl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2014 18:09:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C9791DEE5;
	Tue, 11 Nov 2014 18:09:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=9
	WdGZPw6/W93PNybGiGDhX3r8ZA=; b=MAGzgtznQA1bWUcC6nzBCVlud3Wlr5gk+
	aeILEobXhAuW8IgcgJiqIrurnMWmVmtmB22QhX8U72detlztG7oM7OdBSS4SfH32
	Ph8rHaa0dE66xhvookXSpnb/iPzDr0pbnEm1AgVY8qstHRAnWkYzJgVxv/HAiXI4
	HDGjHELLrQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Oin
	f/5Vvd1MFYiPyyuY3TljinxNitSVX4RKE7VzWrFz9+x2JtLsFkFycho7kqOcBAmc
	I7yMss6smnhfD6NMlqHyS5WeDCn4qByYw7qj/ZdU5ZkmPhc+MnkL7c7bi8xCP9BT
	NW2XkPM8R0yrIZGblSVAxkyoct3Alnkcsue9QV+w=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 225D01DEE4;
	Tue, 11 Nov 2014 18:09:39 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4AC171DEE3;
	Tue, 11 Nov 2014 18:09:38 -0500 (EST)
X-master-at: f6f61cbbad0611e03b712cc354f1665b5d7b087e
X-next-at: 02acac17c0ca601887f1b25ebca898b47d71c009
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CF44301A-69F7-11E4-B4F9-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* jk/fetch-reflog-df-conflict (2014-11-04) 2 commits
  (merged to 'next' on 2014-11-05 at b0476c9)
 + ignore stale directories when checking reflog existence
 + fetch: load all default config at startup

 Corner-case bugfixes for "git fetch" around reflog handling.


* jk/cache-tree-protect-from-broken-libgit2 (2014-10-30) 1 commit
  (merged to 'next' on 2014-11-03 at 6ebd88d)
 + cache-tree: avoid infinite loop on zero-entry tree

 Corner-case bugfixes when using a corrupt index file.


* js/diff-highlight-avoid-sigpipe (2014-11-04) 1 commit
  (merged to 'next' on 2014-11-05 at b0fadd3)
 + diff-highlight: exit when a pipe is broken


* nd/gitignore-trailing-whitespace (2014-11-04) 1 commit
  (merged to 'next' on 2014-11-05 at e7f43d6)
 + gitignore.txt: fix spelling of "backslash"


* rs/use-child-process-init-more (2014-10-30) 4 commits
  (merged to 'next' on 2014-11-03 at a82d885)
 + bundle: split out ref writing from bundle_create
 + bundle: split out a helper function to compute and write prerequisites
 + bundle: split out a helper function to create pack data
 + use child_process_init() to initialize struct child_process variables


* tm/line-log-first-parent (2014-11-04) 1 commit
  (merged to 'next' on 2014-11-05 at 8a6f650)
 + line-log: fix crash when --first-parent is used

 "git log --first-parent -L..." used to crash.

--------------------------------------------------
[New Topics]

* jk/fetch-reflog-df-conflict (2014-11-10) 1 commit
  (merged to 'next' on 2014-11-11 at 88c1491)
 + t1410: fix breakage on case-insensitive filesystems

 Will merge to 'master'.


* br/imap-send-verbosity (2014-11-05) 1 commit
 - imap-send: use parse options API to determine verbosity
 (this branch is used by br/imap-send-via-libcurl.)

 Will merge to 'next' and cook throughout the remainder of the cycle.


* br/imap-send-via-libcurl (2014-11-10) 1 commit
 - git-imap-send: use libcurl for implementation
 (this branch uses br/imap-send-verbosity.)

 Will merge to 'next' and cook throughout the remainder of the cycle.


* jc/doc-commit-only (2014-11-07) 1 commit
 - Documentation/git-commit: clarify that --only/--include records the working tree contents


* cc/interpret-trailers (2014-11-10) 2 commits
 - trailer: display a trailer without its trailing newline
 - trailer: ignore comment lines inside the trailers
 (this branch is used by cc/interpret-trailers-more.)


* cc/interpret-trailers-more (2014-11-10) 4 commits
 - trailer: add test with an old style conflict block
 - trailer: reuse ignore_non_trailer() to ignore conflict lines
 - commit: make ignore_non_trailer() non static
 - Merge branch 'jc/conflict-hint' into cc/interpret-trailers-more
 (this branch uses cc/interpret-trailers and jc/conflict-hint.)


* js/push-to-update (2014-11-10) 2 commits
 - receive-pack: add two more options for receive.denyCurrentBranch
 - finish_command(): clean stale environment pointer


* rs/env-array-in-child-process (2014-11-10) 1 commit
 - use args member of struct child_process


* tq/git-ssh-command (2014-11-10) 1 commit
 - git_connect: set ssh shell command in GIT_SSH_COMMAND

--------------------------------------------------
[Stalled]

* je/quiltimport-no-fuzz (2014-10-21) 2 commits
 - git-quiltimport: flip the default not to allow fuzz
 - git-quiltimport.sh: allow declining fuzz with --exact option

 "quiltimport" drove "git apply" always with -C1 option to reduce
 context of the patch in order to give more chance to somewhat stale
 patches to apply.  Add an "--exact" option to disable, and also
 "-C$n" option to customize this behaviour.  The top patch
 optionally flips the default to "--exact".

 Waiting for an Ack.


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


* tr/remerge-diff (2014-11-10) 9 commits
 - t4213: avoid "|" in sed regexp
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


* hv/submodule-config (2014-11-11) 4 commits
 - do not die on error of parsing fetchrecursesubmodules option
 - use new config API for worktree configurations of submodules
 - extract functions for submodule config set and lookup
 - implement submodule config cache for lookup of submodule names

 Kicked back to 'pu' per request ($gmane/255610).


* jk/pack-bitmap (2014-08-04) 1 commit
 - pack-bitmap: do not use gcc packed attribute

 Hold, waiting for Karsten's replacement.


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

* ms/submodule-update-config-doc (2014-11-03) 1 commit
 - submodule: clarify documentation for update subcommand


* nd/lockfile-absolute (2014-11-03) 1 commit
  (merged to 'next' on 2014-11-06 at 68722a9)
 + lockfile.c: store absolute path

 The lockfile API can get confused which file to clean up when the
 process moved the $cwd after creating a lockfile.

 Will cook in 'next' throughout the remainder of the cycle.


* jh/empty-notes (2014-11-10) 9 commits
 - t3301: modernize
 - notes: empty notes should be shown by 'git log'
 - builtin/notes: add --allow-empty, to allow storing empty notes
 - builtin/notes: split create_note() to clarify add vs. remove logic
 - builtin/notes: simplify early exit code in add()
 - builtin/notes: refactor note file path into struct note_data
 - builtin/notes: improve naming
 - t3301: verify that 'git notes' removes empty notes by default
 - builtin/notes: fix premature failure when trying to add the empty blob

 A request to store an empty note via "git notes" meant to remove
 note from the object but with --allow-empty we will store a (surprise!)
 note that is empty.  In the longer run, we might want to deprecate
 the somewhat unintuitive "emptying means deletion" behaviour.


* jc/merge-bases (2014-10-30) 2 commits
  (merged to 'next' on 2014-11-06 at 491e576)
 + get_merge_bases(): always clean-up object flags
 + bisect: clean flags after checking merge bases

 Will cook in 'next' throughout the remainder of the cycle.


* jc/strbuf-add-lines-avoid-sp-ht-sequence (2014-10-27) 1 commit
  (merged to 'next' on 2014-10-29 at 9167582)
 + strbuf_add_commented_lines(): avoid SP-HT sequence in commented lines

 The commented output used to blindly add a SP before the payload
 line, resulting in "# \t<indented text>\n" when the payload began
 with a HT.  Instead, produce "#\t<indented text>\n".

 Will cook in 'next' throughout the remainder of the cycle.


* nd/untracked-cache (2014-10-27) 19 commits
 - t7063: tests for untracked cache
 - update-index: test the system before enabling untracked cache
 - update-index: manually enable or disable untracked cache
 - status: enable untracked cache
 - untracked cache: mark index dirty if untracked cache is updated
 - untracked cache: print stats with $GIT_TRACE_UNTRACKED_STATS
 - untracked cache: avoid racy timestamps
 - read-cache.c: split racy stat test to a separate function
 - untracked cache: invalidate at index addition or removal
 - untracked cache: load from UNTR index extension
 - untracked cache: save to an index extension
 - untracked cache: don't open non-existent .gitignore
 - untracked cache: mark what dirs should be recursed/saved
 - untracked cache: record/validate dir mtime and reuse cached output
 - untracked cache: make a wrapper around {open,read,close}dir()
 - untracked cache: invalidate dirs recursively if .gitignore changes
 - untracked cache: initial untracked cache validation
 - untracked cache: record .gitignore information and dir hierarchy
 - dir.c: optionally compute sha-1 of a .gitignore file


* zk/grep-color-words (2014-10-27) 2 commits
  (merged to 'next' on 2014-10-28 at 4d0457c)
 + Revert "grep: fix match highlighting for combined patterns with context lines"
  (merged to 'next' on 2014-10-24 at 2d2f8f8)
 + grep: fix match highlighting for combined patterns with context lines

 rs/grep-color-words topic solves it in a different way.

 Will discard.


* jc/conflict-hint (2014-10-28) 4 commits
  (merged to 'next' on 2014-10-29 at 693250f)
 + merge & sequencer: turn "Conflicts:" hint into a comment
 + builtin/commit.c: extract ignore_non_trailer() helper function
 + merge & sequencer: unify codepaths that write "Conflicts:" hint
 + builtin/merge.c: drop a parameter that is never used
 (this branch is used by cc/interpret-trailers-more.)

 Unlike all the other hints given in the commit log editor, the list
 of conflicted paths were appended at the end without commented out.

 Will cook in 'next' throughout the remainder of the cycle.


* jc/diff-b-m (2014-10-23) 1 commit
  (merged to 'next' on 2014-10-28 at 4daedb1)
 + diff -B -M: fix output for "copy and then rewrite" case

 Fix long-standing bug in "diff -B -M" output.

 Will cook in 'next' throughout the remainder of the cycle.


* rs/ref-transaction-reflog (2014-11-03) 15 commits
 - refs.c: allow deleting refs with a broken sha1
 - refs.c: remove lock_any_ref_for_update
 - refs.c: make unlock_ref/close_ref/commit_ref static
 - refs.c: rename log_ref_setup to create_reflog
 - reflog.c: use a reflog transaction when writing during expire
 - refs.c: allow multiple reflog updates during a single transaction
 - refs.c: only write reflog update if msg is non-NULL
 - refs.c: add a flag to allow reflog updates to truncate the log
 - refs.c: add a transaction function to append a reflog entry
 - copy.c: make copy_fd preserve meaningful errno
 - refs.c: add a function to append a reflog entry to a fd
 - refs.c: add a new update_type field to ref_update
 - refs.c: rename the transaction functions
 - refs.c: make ref_transaction_delete a wrapper for ref_transaction_update
 - refs.c make ref_transaction_create a wrapper to ref_transaction_update
 (this branch is used by rs/ref-transaction-rename and rs/ref-transaction-send-pack.)

 Reviews and comments?


* rs/ref-transaction-rename (2014-11-07) 16 commits
 - refs.c: add an err argument to pack_refs
 - refs.c: make lock_packed_refs take an err argument
 - refs.c: make add_packed_ref return an error instead of calling die
 - refs.c: replace the onerr argument in update_ref with a strbuf err
 - refs.c: make the *_packed_refs functions static
 - refs.c: make repack_without_refs static
 - remote.c: use a transaction for deleting refs
 - refs.c: write updates to packed refs when a transaction has more than one ref
 - refs.c: move reflog updates into its own function
 - refs.c: rollback the lockfile before we die() in repack_without_refs
 - refs.c: update rename_ref to use a transaction
 - refs.c: add transaction support for renaming a reflog
 - refs.c: use a stringlist for repack_without_refs
 - refs.c: use packed refs when deleting refs during a transaction
 - refs.c: return error instead of dying when locking fails during transaction
 - refs.c: allow passing raw git_committer_info as email to _update_reflog
 (this branch is used by rs/ref-transaction-send-pack; uses rs/ref-transaction-reflog.)

 Reviews and comments?


* rs/ref-transaction-send-pack (2014-11-07) 7 commits
 - refs.c: add an err argument to create_symref
 - refs.c: add an err argument to create_reflog
 - t5543-atomic-push.sh: add basic tests for atomic pushes
 - push.c: add an --atomic-push argument
 - receive-pack.c: use a single transaction when atomic-push is negotiated
 - send-pack.c: add an --atomic-push command line argument
 - receive-pack.c: add protocol support to negotiate atomic-push
 (this branch uses rs/ref-transaction-reflog and rs/ref-transaction-rename.)

 Reviews and comments?


* jc/checkout-local-track-report (2014-10-14) 1 commit
  (merged to 'next' on 2014-10-21 at f636a00)
 + checkout: report upstream correctly even with loosely defined branch.*.merge

 The report from "git checkout" on a branch that builds on another
 local branch by setting its branch.*.merge to branch name (not a
 full refname) incorrectly said that the upstream is gone.

 Will cook in 'next' throughout the remainder of the cycle.


* jc/clone-borrow (2014-10-15) 1 commit
  (merged to 'next' on 2014-10-21 at b76ea34)
 + clone: --dissociate option to mark that reference is only temporary

 Allow "git clone --reference" to be used more safely.

 Will cook in 'next' throughout the remainder of the cycle.

--------------------------------------------------
[Discarded]

* jt/timer-settime (2014-08-29) 6 commits
 . use timer_settime() for new platforms
 . autoconf: check for timer_settime()
 . autoconf: check for struct itimerspec
 . autoconf: check for struct sigevent
 . autoconf: check for struct timespec
 . autoconf: check for timer_t

 Was wanting for a reroll.
