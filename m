From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Nov 2010, #01; Tue, 9)
Date: Tue, 09 Nov 2010 11:53:19 -0800
Message-ID: <7vbp5ymfyo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 09 20:53:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFuG7-0001oM-VR
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 20:53:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754039Ab0KITx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 14:53:28 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35132 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753325Ab0KITx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 14:53:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 40C5839DE;
	Tue,  9 Nov 2010 14:53:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=kKUx
	7Sc4RHuv0H4DlhQfKwWJ0c8=; b=ImwUXMuCQDZpsKloERy7dVFcssJdnycgQ3ek
	O5I+xvClnilcO/GrvDxp4ikIMAg2sW7e/VkMPXlkRDsEK8ZcibuDNxMPQAyWsPBf
	GoYBdLaokyf2Z7153tmnO7xbCaba8eCwYC8gs3Q1GrHgZW2pcp1ewJjyPjHMLqiV
	0ZNBs/w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=FZB
	CBChNeSSzW8JRsb6KaGuAuqXcsEu4Ng6u3avdjYq5IqWY/Y3KAb7RSG9nifhXess
	I5o5ueFMQlZuwiEhhh45o0BaRuQwZpJD9/CGmWLivFfBbHAcz4aOXJ8xIgIAXLrz
	II5JkeMhKInwKizNFE63sWmsyFXv0hY+d2e5Q1zY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 247DF39DD;
	Tue,  9 Nov 2010 14:53:28 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 641FD39DC; Tue,  9 Nov 2010
 14:53:25 -0500 (EST)
X-master-at: 6f10c4103dc7506623f89520ad03517b40788259
X-next-at: d103166d7e9f1756878c3a913d6ffded69ea2f51
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0554EE18-EC3B-11DF-A037-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161068>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the integration branches, but I am
still holding onto them.

--------------------------------------------------
[New Topics]

* dk/maint-blame-el (2010-05-25) 1 commit
  (merged to 'next' on 2010-11-05 at 8456c66)
 + git-blame.el: Add (require 'format-spec)

* ef/mingw-daemon (2010-11-04) 16 commits
 - daemon: opt-out on features that require posix
 - daemon: make --inetd and --detach incompatible
 - daemon: use socklen_t
 - mingw: use poll-emulation from gnulib
 - mingw: import poll-emulation from gnulib
 - daemon: get remote host address from root-process
 - Improve the mingw getaddrinfo stub to handle more use cases
 - daemon: use full buffered mode for stderr
 - daemon: use run-command api for async serving
 - mingw: add kill emulation
 - mingw: support waitpid with pid > 0 and WNOHANG
 - mingw: use real pid
 - inet_ntop: fix a couple of old-style decls
 - compat: add inet_pton and inet_ntop prototypes
 - mingw: implement syslog
 - mingw: add network-wrappers for daemon

Will merge to 'next'.

* jc/abbrev-guard (2010-10-28) 1 commit
 - core.abbrevguard: Ensure short object names stay unique a bit longer

* jc/emfile (2010-10-28) 2 commits
 - A loose object is not corrupt if it cannot be read due to EMFILE
 - read_sha1_file(): report correct name of packfile with a corrupt object
 (this branch is used by sp/emfile.)

Will merge to 'next'.

* sp/emfile (2010-11-01) 2 commits
 - Work around EMFILE when there are too many pack files
 - Use git_open_noatime when accessing pack data
 (this branch uses jc/emfile.)

Will merge to 'next', but might want to restructure the API a bit.

* jh/gitweb-caching (2010-11-01) 4 commits
 - gitweb: Minimal testing of gitweb caching
 - gitweb: File based caching layer (from git.kernel.org)
 - gitweb: add output buffering and associated functions
 - gitweb: Prepare for splitting gitweb
 (this branch uses jn/gitweb-test.)

* jk/maint-apply-no-binary (2010-10-18) 1 commit
  (merged to 'next' on 2010-11-05 at 8b7543a)
 + apply: don't segfault on binary files with missing data

* jl/add-p-reverse-message (2010-10-27) 1 commit
 - Correct help blurb in checkout -p and friends

Looked Ok; will merge to 'next' soonish.

* jl/clone-recurse-sm-synonym (2010-11-04) 1 commit
 - clone: Add the --recurse-submodules option as alias for --recursive

Looked Ok; will merge to 'next' soonish.

* jl/maint-pull-tags-doc (2010-11-03) 1 commit
  (merged to 'next' on 2010-11-05 at 861d16a)
 + pull: Remove --tags option from manpage

* jn/cherry-pick-refresh-index (2010-10-31) 1 commit
 - cherry-pick/revert: transparently refresh index

Looked Ok; will merge to 'next' soonish.

* jn/parse-options-extra (2010-10-24) 4 commits
 - update-index: migrate to parse-options API
 - setup: save prefix (original cwd relative to toplevel) in startup_info
 - parse-options: make resuming easier after PARSE_OPT_STOP_AT_NON_OPTION
 - parse-options: allow git commands to invent new option types

Looked Ok; will merge to 'next' soonish.

* kb/maint-submodule-savearg (2010-11-02) 2 commits
  (merged to 'next' on 2010-11-05 at 10e1aeb)
 + submodule: only preserve flags across recursive status/update invocations
 + submodule: preserve all arguments exactly when recursing

* md/interix (2010-10-27) 2 commits
 - Interix: add configure checks
 - add support for the SUA layer (interix; windows)

Looked Ok, in the sense that I do not think it will negatively affect
other platforms.  Will merge to 'next' soonish.

* mm/phrase-remote-tracking (2010-11-02) 10 commits
 - git-branch.txt: mention --set-upstream as a way to change upstream configuration
 - user-manual: remote-tracking can be checked out, with detached HEAD
 - user-manual.txt: explain better the remote(-tracking) branch terms
 - Change incorrect "remote branch" to "remote tracking branch" in C code
 - Change incorrect uses of "remote branch" meaning "remote-tracking"
 - Change "tracking branch" to "remote-tracking branch"
 - everyday.txt: change "tracking branch" to "remote-tracking branch"
 - Change remote tracking to remote-tracking in non-trivial places
 - Replace "remote tracking" with "remote-tracking"
 - Better "Changed but not updated" message in git-status

Is everybody happy with this round?  I'd prefer to merge it to 'next' or
even 'master' and have further polishing be done, if necessary, in-tree.

* nd/setup (2010-11-08) 44 commits
 - t1020-subdirectory: test alias expansion in a subdirectory
 - Remove all logic from get_git_work_tree()
 - setup: rework setup_explicit_git_dir()
 - setup: clean up setup_discovered_git_dir()
 - setup: clean up setup_bare_git_dir()
 - setup: limit get_git_work_tree()'s to explicit setup case only
 - Use git_config_early() instead of git_config() during repo setup
 - Add git_config_early()
 - rev-parse: prints --git-dir relative to user's cwd
 - git-rev-parse.txt: clarify --git-dir
 - t1510: setup case #31
 - t1510: setup case #30
 - t1510: setup case #29
 - t1510: setup case #28
 - t1510: setup case #27
 - t1510: setup case #26
 - t1510: setup case #25
 - t1510: setup case #24
 - t1510: setup case #23
 - t1510: setup case #22
 - t1510: setup case #21
 - t1510: setup case #20
 - t1510: setup case #19
 - t1510: setup case #18
 - t1510: setup case #17
 - t1510: setup case #16
 - t1510: setup case #15
 - t1510: setup case #14
 - t1510: setup case #13
 - t1510: setup case #12
 - t1510: setup case #11
 - t1510: setup case #10
 - t1510: setup case #9
 - t1510: setup case #8
 - t1510: setup case #7
 - t1510: setup case #6
 - t1510: setup case #5
 - t1510: setup case #4
 - t1510: setup case #3
 - t1510: setup case #2
 - t1510: setup case #1
 - t1510: setup case #0
 - Add t1510 and basic rules that run repo setup
 - builtins: print setup info if repo is found

* rr/needs-clean-work-tree (2010-10-19) 1 commit
 - Porcelain scripts: Rewrite cryptic "needs update" error message

Looked Ok, will merge to 'next' soonish.

* sn/diff-doc (2010-11-04) 3 commits
 - docs: clarify git diff modes of operation
 - diff,difftool: Don't use the {0,2} notation in usage strings
 - CodingGuidelines: Add a section on writing documentation

* tr/config-doc (2010-10-24) 2 commits
 . Documentation: complete config list from other manpages
 . Documentation: Move variables from config.txt to separate file

This unfortunately heavily conflicts with patches in flight...

* kb/maint-rebase-autosquash (2010-11-04) 2 commits
 - rebase: teach --autosquash to match on sha1 in addition to message
 - rebase: better rearranging of fixup!/squash! lines with --autosquash

* kb/maint-status-cquote (2010-11-08) 1 commit
 - status: Quote paths with spaces in short format

* mg/maint-tag-rfc1991 (2010-11-06) 5 commits
 - tag: recognize rfc1991 signatures
 - tag: factor out sig detection for tag display
 - tag: factor out sig detection for body edits
 - verify-tag: factor out signature detection
 - t/t7004-tag: test handling of rfc1991 signatures

--------------------------------------------------
[Graduated to "master"]

* aw/git-p4-deletion (2010-10-22) 1 commit
  (merged to 'next' on 2010-10-26 at 5847c40)
 + Fix handling of git-p4 on deleted files

--------------------------------------------------
[Stalled]

* nd/index-doc (2010-09-06) 1 commit
 - doc: technical details about the index file format

Half-written but it is a good start.  I may need to give some help in
describing more recent index extensions.

* cb/ignored-paths-are-precious (2010-08-21) 1 commit
 - checkout/merge: optionally fail operation when ignored files need to be overwritten

This needs tests; also we know of longstanding bugs in related area that
needs to be addressed---they do not have to be part of this series but
their reproduction recipe would belong to the test script for this topic.

It would hurt users to make the new feature on by default, especially the
ones with subdirectories that come and go.

* jk/tag-contains (2010-07-05) 4 commits
 - Why is "git tag --contains" so slow?
 - default core.clockskew variable to one day
 - limit "contains" traversals based on commit timestamp
 - tag: speed up --contains calculation

The idea of the bottom one is probably Ok, except that the use of object
flags needs to be rethought, or at least the helper needs to be moved to
builtin/tag.c to make it clear that it should not be used outside the
current usage context.

--------------------------------------------------
[Cooking]

* ao/send-email-irt (2010-10-19) 1 commit
  (merged to 'next' on 2010-11-08 at d103166)
 + t9001: send-email interation with --in-reply-to and --chain-reply-to

* bg/maint-gitweb-test-lib (2010-10-20) 1 commit
  (merged to 'next' on 2010-11-05 at 0ead869)
 + t/gitweb-lib: Don't pass constant to decode_utf8

* cm/diff-check-at-eol (2010-10-10) 1 commit
 - diff --check: correct line numbers of new blank lines at EOF

Looked Ok; will merge to 'next' soonish.

* fc/apply-p2-get-header-name (2010-10-21) 2 commits
 - test: git-apply -p2 rename/chmod only
 - Fix git-apply with -p greater than 1

Looked Ok; will merge to 'next' soonish.

* jk/add-e-doc (2010-10-21) 1 commit
  (merged to 'next' on 2010-11-05 at 389fee7)
 + docs: give more hints about how "add -e" works

* jk/diff-CBM (2010-10-21) 1 commit
  (merged to 'next' on 2010-11-05 at 9d1ec14)
 + diff: report bogus input to -C/-M/-B

* jk/missing-config (2010-10-21) 1 commit
  (merged to 'next' on 2010-11-05 at 31fda69)
 + config: treat non-existent config files as empty

* jn/fast-import-fix (2010-10-20) 4 commits
 - fast-import: do not clear notes in do_change_note_fanout()
 - t9300 (fast-import): another test for the "replace root" feature
 - fast-import: tighten M 040000 syntax
 - fast-import: filemodify after M 040000 <tree> "" crashes

Looked Ok; will merge to 'next' soonish.

* jn/git-cmd-h-bypass-setup (2010-10-22) 7 commits
 - update-index -h: show usage even with corrupt index
 - merge -h: show usage even with corrupt index
 - ls-files -h: show usage even with corrupt index
 - gc -h: show usage even with broken configuration
 - commit/status -h: show usage even with broken configuration
 - checkout-index -h: show usage even in an invalid repository
 - branch -h: show usage even in an invalid repository
 (this branch uses en/and-cascade-tests.)

* kb/blame-author-email (2010-10-15) 1 commit
 - blame: Add option to show author email instead of name

Looked Ok; will merge to 'next' soonish.

* kb/maint-diff-ws-check (2010-10-20) 2 commits
  (merged to 'next' on 2010-11-05 at 861b5ac)
 + diff: handle lines containing only whitespace and tabs better
 + test-lib: extend test_decode_color to handle more color codes

* mg/make-prove (2010-10-14) 1 commit
  (merged to 'next' on 2010-11-05 at ec4f806)
 + test: allow running the tests under "prove"

* np/diff-in-corrupt-repository (2010-10-22) 1 commit
 - diff: don't presume empty file when corresponding object is missing

Looked Ok; will merge to 'next' soonish.

* np/pack-broken-boundary (2010-10-22) 1 commit
 - make pack-objects a bit more resilient to repo corruption

Looked Ok; will merge to 'next' soonish.

* tr/maint-git-repack-tmpfile (2010-10-19) 1 commit
  (merged to 'next' on 2010-11-05 at 80ad03a)
 + repack: place temporary packs under .git/objects/pack/

* tr/maint-merge-file-subdir (2010-10-17) 2 commits
  (merged to 'next' on 2010-11-05 at a2873a4)
 + merge-file: correctly find files when called in subdir
 + prefix_filename(): safely handle the case where pfx_len=0

* yd/dir-rename (2010-10-29) 5 commits
 - Allow hiding renames of individual files involved in a directory rename.
 - Unified diff output format for bulk moves.
 - Add testcases for the --detect-bulk-moves diffcore flag.
 - Raw diff output format for bulk moves.
 - Introduce bulk-move detection in diffcore.

* cb/diff-fname-optim (2010-09-26) 3 commits
  (merged to 'next' on 2010-11-05 at b3b09f3)
 + diff: avoid repeated scanning while looking for funcname
 + do not search functions for patch ID
 + add rebase patch id tests

* en/merge-recursive (2010-10-21) 39 commits
  (merged to 'next' on 2010-11-05 at 16902eb)
 + merge-recursive:make_room_for_directories - work around dumb compilers
 + merge-recursive: Remove redundant path clearing for D/F conflicts
 + merge-recursive: Make room for directories in D/F conflicts
 + handle_delete_modify(): Check whether D/F conflicts are still present
 + merge_content(): Check whether D/F conflicts are still present
 + conflict_rename_rename_1to2(): Fix checks for presence of D/F conflicts
 + conflict_rename_delete(): Check whether D/F conflicts are still present
 + merge-recursive: Delay modify/delete conflicts if D/F conflict present
 + merge-recursive: Delay content merging for renames
 + merge-recursive: Delay handling of rename/delete conflicts
 + merge-recursive: Move handling of double rename of one file to other file
 + merge-recursive: Move handling of double rename of one file to two
 + merge-recursive: Avoid doubly merging rename/add conflict contents
 + merge-recursive: Update merge_content() call signature
 + merge-recursive: Update conflict_rename_rename_1to2() call signature
 + merge-recursive: Structure process_df_entry() to handle more cases
 + merge-recursive: Have process_entry() skip D/F or rename entries
 + merge-recursive: New function to assist resolving renames in-core only
 + merge-recursive: New data structures for deferring of D/F conflicts
 + merge-recursive: Move process_entry's content merging into a function
 + merge-recursive: Move delete/modify handling into dedicated function
 + merge-recursive: Move rename/delete handling into dedicated function
 + merge-recursive: Nuke rename/directory conflict detection
 + merge-recursive: Rename conflict_rename_rename*() for clarity
 + merge-recursive: Small code clarification -- variable name and comments
 + t6036: Add testcase for undetected conflict
 + t6036: Add a second testcase similar to the first but with content changes
 + t6036: Test index and worktree state, not just that merge fails
 + t6020: Add a testcase for modify/delete + directory/file conflict
 + t6020: Modernize style a bit
 + t6022: Add tests for rename/rename combined with D/F conflicts
 + t6022: Add paired rename+D/F conflict: (two/file, one/file) -> (one, two)
 + t6022: Add tests with both rename source & dest involved in D/F conflicts
 + t6022: Add tests for reversing order of merges when D/F conflicts present
 + t6022: Add test combinations of {content conflict?, D/F conflict remains?}
 + t6032: Add a test checking for excessive output from merge
 + merge-recursive: Restructure showing how to chain more process_* functions
 + t3030: Add a testcase for resolvable rename/add conflict with symlinks
 + Merge branch 'en/rename-d-f' into en/merge-recursive
 (this branch uses en/rename-d-f.)

* il/remote-fd-ext (2010-10-12) 3 commits
  (merged to 'next' on 2010-11-05 at 7413413)
 + git-remote-ext
 + git-remote-fd
 + Add bidirectional_transfer_loop()

* jn/gitweb-test (2010-09-26) 4 commits
  (merged to 'next' on 2010-11-05 at 90b3adf)
 + gitweb/Makefile: Include gitweb/config.mak
 + gitweb/Makefile: Add 'test' and 'test-installed' targets
 + t/gitweb-lib.sh: Add support for GITWEB_TEST_INSTALLED
 + gitweb: Move call to evaluate_git_version after evaluate_gitweb_config
 (this branch is used by jh/gitweb-caching.)

* ak/apply-non-git-epoch (2010-09-29) 1 commit
 - apply: Recognize epoch timestamps with : in the timezone

Looked Ok; will merge to 'next' soonish.

* ak/submodule-sync (2010-10-08) 1 commit
  (merged to 'next' on 2010-11-05 at 5a2f940)
 + submodule sync: Update "submodule.<name>.url" for empty directories

* cb/leading-path-removal (2010-10-09) 5 commits
  (merged to 'next' on 2010-11-05 at 55ea322)
 + do not overwrite files in leading path
 + lstat_cache: optionally return match_len
 + add function check_ok_to_remove()
 + t7607: add leading-path tests
 + t7607: use test-lib functions and check MERGE_HEAD

* jh/notes-merge (2010-10-29) 25 commits
 - portability fix for c8af1a3b2f
 - notes-merge series: fixup minor style issues
 - Provide 'git merge --abort' as a synonym to 'git reset --merge'
 - cmd_merge(): Parse options before checking MERGE_HEAD
 - Provide 'git notes get-ref' to easily retrieve current notes ref
 - git notes merge: Add testcases for merging notes trees at different fanouts
 - git notes merge: Add another auto-resolving strategy: "cat_sort_uniq"
 - git notes merge: --commit should fail if underlying notes ref has moved
 - git notes merge: List conflicting notes in notes merge commit message
 - git notes merge: Manual conflict resolution, part 2/2
 - git notes merge: Manual conflict resolution, part 1/2
 - Documentation: Preliminary docs on 'git notes merge'
 - git notes merge: Add automatic conflict resolvers (ours, theirs, union)
 - git notes merge: Handle real, non-conflicting notes merges
 - builtin/notes.c: Refactor creation of notes commits.
 - git notes merge: Initial implementation handling trivial merges only
 - builtin/notes.c: Split notes ref DWIMmery into a separate function
 - notes.c: Use two newlines (instead of one) when concatenating notes
 - (trivial) t3303: Indent with tabs instead of spaces for consistency
 - notes.h/c: Propagate combine_notes_fn return value to add_note() and beyond
 - notes.h/c: Allow combine_notes functions to remove notes
 - notes.c: Reorder functions in preparation for next commit
 - notes.h: Make default_notes_ref() available in notes API
 - (trivial) notes.h: Minor documentation fixes to copy_notes()
 - notes.c: Hexify SHA1 in die() message from init_notes()

Still in flux?

* jk/maint-rev-list-nul (2010-10-07) 1 commit
  (merged to 'next' on 2010-11-05 at 406cba1)
 + rev-list: handle %x00 NUL in user format

* jk/push-progress (2010-10-17) 8 commits
  (merged to 'next' on 2010-11-05 at 9207c6d)
 + push: pass --progress down to git-pack-objects
 + t5523-push-upstream: test progress messages
 + t5523-push-upstream: add function to ensure fresh upstream repo
 + test_terminal: ensure redirections work reliably
 + test_terminal: catch use without TTY prerequisite
 + test-lib: allow test code to check the list of declared prerequisites
 + tests: test terminal output to both stdout and stderr
 + tests: factor out terminal handling from t7006

* jm/mailmap (2010-10-19) 3 commits
  (merged to 'next' on 2010-11-05 at ef1e754)
 + t4203: do not let "git shortlog" DWIM based on tty
 + t4203 (mailmap): stop hardcoding commit ids and dates
 + mailmap: fix use of freed memory

* jn/send-pack-error (2010-10-16) 1 commit
  (merged to 'next' on 2010-11-05 at ef559d4)
 + send-pack: avoid redundant "pack-objects died with strange error"

* kb/completion-checkout (2010-10-12) 1 commit
  (merged to 'next' on 2010-11-05 at 6836d70)
 + completion: Support the DWIM mode for git checkout

* pn/commit-autosquash (2010-11-02) 6 commits
 - add tests of commit --squash
 - commit: --squash option for use with rebase --autosquash
 - add tests of commit --fixup
 - commit: --fixup option for use with rebase --autosquash
 - pretty.c: teach format_commit_message() to reencode the output
 - commit: helper methods to reduce redundant blocks of code

* sg/bisect (2010-10-10) 3 commits
  (merged to 'next' on 2010-11-05 at 4a8b88d)
 + bisect: check for mandatory argument of 'bisect replay'
 + bisect: improve error msg of 'bisect reset' when original HEAD is deleted
 + bisect: improve error message of 'bisect log' while not bisecting

* sg/completion (2010-10-11) 4 commits
  (merged to 'next' on 2010-11-05 at 4967932)
 + bash: support pretty format aliases
 + bash: support more 'git notes' subcommands and their options
 + bash: not all 'git bisect' subcommands make sense when not bisecting
 + bash: offer refs for 'git bisect start'

* jj/icase-directory (2010-10-03) 8 commits
 - Support case folding in git fast-import when core.ignorecase=true
 - Support case folding for git add when core.ignorecase=true
 - Add case insensitivity support when using git ls-files
 - Add case insensitivity support for directories when using git status
 - Case insensitivity support for .gitignore via core.ignorecase
 - Add string comparison functions that respect the ignore_case variable.
 - Makefile & configure: add a NO_FNMATCH_CASEFOLD flag
 - Makefile & configure: add a NO_FNMATCH flag

* en/and-cascade-tests (2010-10-03) 13 commits
 - Introduce sane_unset and use it to ensure proper && chaining
 - t7800 (difftool): add missing &&
 - t7601 (merge-pull-config): add missing &&
 - t7001 (mv): add missing &&
 - t6016 (rev-list-graph-simplify-history): add missing &&
 - t5602 (clone-remote-exec): add missing &&
 - t4026 (color): remove unneeded and unchained command
 - t4019 (diff-wserror): add lots of missing &&
 - t4202 (log): Replace '<git-command> || :' with test_might_fail
 - t4002 (diff-basic): use test_might_fail for commands that might fail
 - t100[12] (read-tree-m-2way, read_tree_m_u_2way): add missing &&
 - t4017 (diff-retval): replace manual exit code check with test_expect_code
 - test-lib: make test_expect_code a test command
 (this branch is used by jn/git-cmd-h-bypass-setup.)

* jk/no-textconv-symlink (2010-09-21) 1 commit
  (merged to 'next' on 2010-11-05 at 0a99e75)
 + diff: don't use pathname-based diff drivers for symlinks
 (this branch is used by ks/no-textconv-symlink.)

* ks/no-textconv-symlink (2010-09-29) 3 commits
  (merged to 'next' on 2010-11-05 at 32f0580)
 + blame,cat-file --textconv: Don't assume mode is ``S_IFREF | 0664''
 + blame,cat-file: Demonstrate --textconv is wrongly running converter on symlinks
 + blame,cat-file: Prepare --textconv tests for correctly-failing conversion program
 (this branch uses jk/no-textconv-symlink.)

* nd/struct-pathspec (2010-09-20) 5 commits
 - ce_path_match: drop prefix matching in favor of match_pathspec
 - Convert ce_path_match() to use struct pathspec
 - tree_entry_interesting: turn to match_pathspec if wildcard is present
 - pathspec: add tree_recursive_diff parameter
 - pathspec: mark wildcard pathspecs from the beginning
 (this branch uses en/object-list-with-pathspec.)

This is related to something I have long been wanting to see happen.  Will
give it another look and merge to 'next'.

* en/object-list-with-pathspec (2010-09-20) 8 commits
 - Add testcases showing how pathspecs are handled with rev-list --objects
 - Make rev-list --objects work together with pathspecs
 - Move tree_entry_interesting() to tree-walk.c and export it
 - tree_entry_interesting(): remove dependency on struct diff_options
 - Convert struct diff_options to use struct pathspec
 - pathspec: cache string length when initializing pathspec
 - diff-no-index: use diff_tree_setup_paths()
 - Add struct pathspec
 (this branch is used by nd/struct-pathspec.)

* tc/smart-http-post-redirect (2010-09-25) 1 commit
 - smart-http: Don't change POST to GET when following redirect

Will merge to 'next' to see what happens.

* en/rename-d-f (2010-09-08) 2 commits
 + merge-recursive: D/F conflicts where was_a_dir/file -> was_a_dir
 + t3509: Add rename + D/F conflict testcase that recursive strategy fails
 (this branch is used by en/merge-recursive.)

* jl/fetch-submodule-recursive (2010-09-19) 4 commits
 - fetch: Get submodule paths from index and not from .gitmodules
 - fetch: Fix a bug swallowing the output of recursive submodule fetching
 - Submodules: Add the new "fetch" config option for fetch and pull
 - fetch/pull: Recursively fetch populated submodules

* tr/merge-unborn-clobber (2010-08-22) 1 commit
 - Exhibit merge bug that clobbers index&WT

* ab/i18n (2010-10-07) 161 commits
 - po/de.po: complete German translation
 - po/sv.po: add Swedish translation
 - gettextize: git-bisect bisect_next_check "You need to" message
 - gettextize: git-bisect [Y/n] messages
 - gettextize: git-bisect bisect_replay + $1 messages
 - gettextize: git-bisect bisect_reset + $1 messages
 - gettextize: git-bisect bisect_run + $@ messages
 - gettextize: git-bisect die + eval_gettext messages
 - gettextize: git-bisect die + gettext messages
 - gettextize: git-bisect echo + eval_gettext message
 - gettextize: git-bisect echo + gettext messages
 - gettextize: git-bisect gettext + echo message
 - gettextize: git-bisect add git-sh-i18n
 - gettextize: git-stash drop_stash say/die messages
 - gettextize: git-stash "unknown option" message
 - gettextize: git-stash die + eval_gettext $1 messages
 - gettextize: git-stash die + eval_gettext $* messages
 - gettextize: git-stash die + eval_gettext messages
 - gettextize: git-stash die + gettext messages
 - gettextize: git-stash say + gettext messages
 - gettextize: git-stash echo + gettext message
 - gettextize: git-stash add git-sh-i18n
 - gettextize: git-submodule "blob" and "submodule" messages
 - gettextize: git-submodule "path not initialized" message
 - gettextize: git-submodule "[...] path is ignored" message
 - gettextize: git-submodule "Entering [...]" message
 - gettextize: git-submodule $errmsg messages
 - gettextize: git-submodule "Submodule change[...]" messages
 - gettextize: git-submodule "cached cannot be used" message
 - gettextize: git-submodule $update_module say + die messages
 - gettextize: git-submodule die + eval_gettext messages
 - gettextize: git-submodule say + eval_gettext messages
 - gettextize: git-submodule echo + eval_gettext messages
 - gettextize: git-submodule add git-sh-i18n
 - gettextize: git-pull "rebase against" / "merge with" messages
 - gettextize: git-pull "[...] not currently on a branch" message
 - gettextize: git-pull "You asked to pull" message
 - gettextize: git-pull split up "no candidate" message
 - gettextize: git-pull eval_gettext + warning message
 - gettextize: git-pull eval_gettext + die message
 - gettextize: git-pull die messages
 - gettextize: git-pull add git-sh-i18n
 - gettext docs: add "Testing marked strings" section to po/README
 - gettext docs: the Git::I18N Perl interface
 - gettext docs: the git-sh-i18n.sh Shell interface
 - gettext docs: the gettext.h C interface
 - gettext docs: add "Marking strings for translation" section in po/README
 - gettext docs: add a "Testing your changes" section to po/README
 - po/pl.po: add Polish translation
 - po/hi.po: add Hindi Translation
 - po/en_GB.po: add British English translation
 - po/de.po: add German translation
 - Makefile: only add gettext tests on XGETTEXT_INCLUDE_TESTS=YesPlease
 - gettext docs: add po/README file documenting Git's gettext
 - gettextize: git-am printf(1) message to eval_gettext
 - gettextize: git-am core say messages
 - gettextize: git-am "Apply?" message
 - gettextize: git-am clean_abort messages
 - gettextize: git-am cannot_fallback messages
 - gettextize: git-am die messages
 - gettextize: git-am eval_gettext messages
 - gettextize: git-am multi-line getttext $msg; echo
 - gettextize: git-am one-line gettext $msg; echo
 - gettextize: git-am add git-sh-i18n
 - gettext tests: add GETTEXT_POISON tests for shell scripts
 - gettext tests: add GETTEXT_POISON support for shell scripts
 - Makefile: MSGFMT="msgfmt --check" under GNU_GETTEXT
 - Makefile: add GNU_GETTEXT, set when we expect GNU gettext
 - gettextize: git-shortlog basic messages
 - gettextize: git-revert split up "could not revert/apply" message
 - gettextize: git-revert literal "me" messages
 - gettextize: git-revert "Your local changes" message
 - gettextize: git-revert basic messages
 - gettextize: git-notes "Refusing to %s notes in %s" message
 - gettextize: git-notes GIT_NOTES_REWRITE_MODE error message
 - gettextize: git-notes basic commands
 - gettextize: git-gc "Auto packing the repository" message
 - gettextize: git-gc basic messages
 - gettextize: git-describe basic messages
 - gettextize: git-clean clean.requireForce messages
 - gettextize: git-clean basic messages
 - gettextize: git-bundle basic messages
 - gettextize: git-archive basic messages
 - gettextize: git-status "renamed: " message
 - gettextize: git-status "Initial commit" message
 - gettextize: git-status "Changes to be committed" message
 - gettextize: git-status shortstatus messages
 - gettextize: git-status "nothing to commit" messages
 - gettextize: git-status basic messages
 - gettextize: git-push "prevent you from losing" message
 - gettextize: git-push basic messages
 - gettextize: git-tag tag_template message
 - gettextize: git-tag basic messages
 - gettextize: git-reset "Unstaged changes after reset" message
 - gettextize: git-reset reset_type_names messages
 - gettextize: git-reset basic messages
 - gettextize: git-rm basic messages
 - gettextize: git-mv "bad" messages
 - gettextize: git-mv basic messages
 - gettextize: git-merge "Wonderful" message
 - gettextize: git-merge "You have not concluded your merge" messages
 - gettextize: git-merge "Updating %s..%s" message
 - gettextize: git-merge basic messages
 - gettextize: git-log "--OPT does not make sense" messages
 - gettextize: git-log basic messages
 - gettextize: git-grep "--open-files-in-pager" message
 - gettextize: git-grep basic messages
 - gettextize: git-fetch split up "(non-fast-forward)" message
 - gettextize: git-fetch update_local_ref messages
 - gettextize: git-fetch formatting messages
 - gettextize: git-fetch basic messages
 - gettextize: git-diff basic messages
 - gettextize: git-commit advice messages
 - gettextize: git-commit "enter the commit message" message
 - gettextize: git-commit print_summary messages
 - gettextize: git-commit formatting messages
 - gettextize: git-commit "middle of a merge" message
 - gettextize: git-commit basic messages
 - gettextize: git-checkout "Switched to a .. branch" message
 - gettextize: git-checkout "HEAD is now at" message
 - gettextize: git-checkout describe_detached_head messages
 - gettextize: git-checkout: our/their version message
 - gettextize: git-checkout basic messages
 - gettextize: git-branch "(no branch)" message
 - gettextize: git-branch "git branch -v" messages
 - gettextize: git-branch "Deleted branch [...]" message
 - gettextize: git-branch "remote branch '%s' not found" message
 - gettextize: git-branch basic messages
 - gettextize: git-add refresh_index message
 - gettextize: git-add "remove '%s'" message
 - gettextize: git-add "pathspec [...] did not match" message
 - gettextize: git-add "Use -f if you really want" message
 - gettextize: git-add "no files added" message
 - gettextize: git-add basic messages
 - gettextize: git-clone "Cloning into" message
 - gettextize: git-clone basic messages
 - gettext tests: test message re-encoding under C
 - po/is.po: add Icelandic translation
 - gettext tests: mark a test message as not needing translation
 - gettext tests: test re-encoding with a UTF-8 msgid under Shell
 - gettext tests: test message re-encoding under Shell
 - gettext tests: add detection for is_IS.ISO-8859-1 locale
 - gettext tests: test if $VERSION exists before using it
 - gettextize: git-init "Initialized [...] repository" message
 - gettextize: git-init basic messages
 - gettext tests: skip lib-gettext.sh tests under GETTEXT_POISON
 - gettext tests: add GETTEXT_POISON=YesPlease Makefile parameter
 - gettext.c: use libcharset.h instead of langinfo.h when available
 - gettext.c: work around us not using setlocale(LC_CTYPE, "")
 - builtin.h: Include gettext.h
 - Makefile: use variables and shorter lines for xgettext
 - Makefile: tell xgettext(1) that our source is in UTF-8
 - Makefile: provide a --msgid-bugs-address to xgettext(1)
 - Makefile: A variable for options used by xgettext(1) calls
 - gettext tests: locate i18n lib&data correctly under --valgrind
 - gettext: setlocale(LC_CTYPE, "") breaks Git's C function assumptions
 - gettext tests: rename test to work around GNU gettext bug
 - gettext: add infrastructure for translating Git with gettext
 - builtin: use builtin.h for all builtin commands
 - tests: use test_cmp instead of piping to diff(1)
 - t7004-tag.sh: re-arrange git tag comment for clarity

Will merge to 'next' to see what happens; it is getting ridiculously
painful to keep re-resolving the conflicts with other topics in flight,
even with the help with rerere.
