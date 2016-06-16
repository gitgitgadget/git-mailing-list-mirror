From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Apr 2016, #05; Mon, 18)
Date: Mon, 18 Apr 2016 15:48:24 -0700
Message-ID: <xmqq1t624jpj.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 00:48:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asHy5-0006fs-PE
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 00:48:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902AbcDRWsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2016 18:48:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58968 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751464AbcDRWs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2016 18:48:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 870C515E0D;
	Mon, 18 Apr 2016 18:48:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=B
	2rBhx+HcT8ruCvfMsaYDX85Msc=; b=lKRKpH8a84snCO/EBpkaz/Fj8bbETH0aT
	gacAOQ5qa5tyhtTbWPEwCENczxb+dBqLfRG6vNDoSbDdLbBanQhwl1kFY7Wr917M
	zCBLC/F6Wiudia46kzOGrLq6XAAsEiUQfaZYGb+e+daGivYVzFV6iUcRI9HIfKSM
	we2AUtPMug=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=fV7
	jbA0dorMs0xzhBw1YSp9z9+6uE/DQoFhPui224k05S9/deO4lD38uU+J4FmEvgdp
	sFFXXAly1fr8Kh+JxaROf4AQmmi25a8VnLLviqxfT25uAUBhNjPfRRMcv5ESGtcd
	XYlS9UVY3ML7kJlgzaFxoGsPYl7kq8otxXSFvEOg=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7D1E415E0C;
	Mon, 18 Apr 2016 18:48:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 997A815E0B;
	Mon, 18 Apr 2016 18:48:25 -0400 (EDT)
X-master-at: e6ac6e1f7d54584c2b03f073b5f329a37f4a9561
X-next-at: c82888d429ec9129c13a7b821f0fb8d1c6d77bff
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A9272B50-05B7-11E6-8C6F-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291834>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

The 'master' branch now has the fifth batch of topics of this cycle.

There are a handful of topics that are stuck; they are marked as
"Needs review", "Needs an Ack", etc. in the following list.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ak/use-hashmap-iter-first-in-submodule-config (2016-03-23) 1 commit
  (merged to 'next' on 2016-04-06 at 2aab890)
 + submodule-config: use hashmap_iter_first()

 Minor code cleanup.


* cc/apply (2016-04-01) 4 commits
  (merged to 'next' on 2016-04-06 at 2e23c44)
 + builtin/apply: free patch when parse_chunk() fails
 + builtin/apply: handle parse_binary() failure
 + apply: remove unused call to free() in gitdiff_{old,new}name()
 + builtin/apply: get rid of useless 'name' variable

 Minor code clean-up.


* ep/trace-doc-sample-fix (2016-04-05) 1 commit
  (merged to 'next' on 2016-04-06 at 0df7357)
 + api-trace.txt: fix typo

 Fix a typo in an example in the trace API documentation.


* es/format-patch-doc-hide-no-patch (2016-04-04) 1 commit
  (merged to 'next' on 2016-04-06 at 25d79bb)
 + git-format-patch.txt: don't show -s as shorthand for multiple options

 "git format-patch --help" showed `-s` and `--no-patch` as if these
 are valid options to the command.  We already hide `--patch` option
 from the documentation, because format-patch is about showing the
 diff, and the documentation now hides these options as well.


* jc/makefile-redirection-stderr (2016-04-05) 1 commit
  (merged to 'next' on 2016-04-06 at e3f2ded)
 + Makefile: fix misdirected redirections

 A minor fix in the Makefile.


* jk/branch-shortening-funny-symrefs (2016-04-04) 1 commit
  (merged to 'next' on 2016-04-06 at 1a3f8be)
 + branch: fix shortening of non-remote symrefs

 A change back in version 2.7 to "git branch" broke display of a
 symbolic ref in a non-standard place in the refs/ hierarchy (we
 expect symbolic refs to appear in refs/remotes/*/HEAD to point at
 the primary branch the remote has, and as .git/HEAD to point at the
 branch we locally checked out).

 Will merge down to maint-2.7.


* jk/check-repository-format (2016-03-11) 10 commits
  (merged to 'next' on 2016-04-06 at a0dada0)
 + verify_repository_format: mark messages for translation
 + setup: drop repository_format_version global
 + setup: unify repository version callbacks
 + init: use setup.c's repo version verification
 + setup: refactor repo format reading and verification
 + config: drop git_config_early
 + check_repository_format_gently: stop using git_config_early
 + lazily load core.sharedrepository
 + wrap shared_repository global in get/set accessors
 + setup: document check_repository_format()
 (this branch is used by dt/pre-refs-backend.)

 The repository set-up sequence has been streamlined (the biggest
 change is that there is no longer git_config_early()), so that we
 do not attempt to look into refs/* when we know we do not have a
 Git repository.


* jn/mergetools-examdiff (2016-04-04) 2 commits
  (merged to 'next' on 2016-04-06 at 819e858)
 + mergetools: add support for ExamDiff
 + mergetools: create mergetool_find_win32_cmd() helper function for winmerge

 "git mergetools" learned to drive ExamDiff.


* js/mingw-tests-2.8 (2016-04-04) 1 commit
  (merged to 'next' on 2016-04-06 at f85a013)
 + Windows: shorten code by re-using convert_slashes()

 Code clean-up.


* kn/for-each-tag-branch (2016-03-30) 1 commit
  (merged to 'next' on 2016-04-06 at 4595ad3)
 + for-each-ref: fix description of '--contains' in manpage

 A minor documentation update.


* ky/branch-d-worktree (2016-03-29) 1 commit
  (merged to 'next' on 2016-04-06 at 00f9bff)
 + branch -d: refuse deleting a branch which is currently checked out

 When "git worktree" feature is in use, "git branch -d" allowed
 deletion of a branch that is checked out in another worktree


* ky/branch-m-worktree (2016-04-08) 3 commits
  (merged to 'next' on 2016-04-08 at b673b5e)
 + set_worktree_head_symref(): fix error message
  (merged to 'next' on 2016-04-06 at e7b285c)
 + branch -m: update all per-worktree HEADs
 + refs: add a new function set_worktree_head_symref

 When "git worktree" feature is in use, "git branch -m" renamed a
 branch that is checked out in another worktree without adjusting
 the HEAD symbolic ref for the worktree.


* lt/pretty-expand-tabs (2016-04-04) 4 commits
  (merged to 'next' on 2016-04-06 at 186ac2a)
 + pretty: test --expand-tabs
 + pretty: allow tweaking tabwidth in --expand-tabs
 + pretty: enable --expand-tabs by default for selected pretty formats
 + pretty: expand tabs in indented logs to make things line up properly

 When "git log" shows the log message indented by 4-spaces, the
 remainder of a line after a HT does not align in the way the author
 originally intended.  The command now expands tabs by default in
 such a case, and allows the users to override it with a new option,
 '--no-expand-tabs'.


* mg/complete-cherry-mark-to-log (2016-04-05) 1 commit
  (merged to 'next' on 2016-04-06 at 3002be6)
 + completion: complete --cherry-mark for git log

 The completion scripts (in contrib/) did not include the
 "--cherry-mark" option when completing "git log <HT>".


* mj/pull-rebase-autostash (2016-04-04) 9 commits
  (merged to 'next' on 2016-04-06 at b4e4f31)
 + t5520: test --[no-]autostash with pull.rebase=true
 + t5520: reduce commom lines of code
 + t5520: factor out common "failing autostash" code
 + t5520: factor out common "successful autostash" code
 + t5520: use better test to check stderr output
 + t5520: ensure consistent test conditions
 + t5520: use consistent capitalization in test titles
 + pull --rebase: add --[no-]autostash flag
 + git-pull.c: introduce git_pull_config()

 "git pull --rebase" learned "--[no-]autostash" option, so that
 the rebase.autostash configuration variable set to true can be
 overridden from the command line.


* rt/completion-help (2016-03-24) 2 commits
  (merged to 'next' on 2016-04-06 at 8c3ee08)
 + completion: add 'revisions' and 'everyday' to 'git help'
 + completion: add option '--guides' to 'git help'

 Shell completion (in contrib/) updates.


* rt/rebase-i-shorten-stop-report (2016-03-28) 1 commit
  (merged to 'next' on 2016-04-06 at 7a766b7)
 + rebase-i: print an abbreviated hash when stop for editing

 The commit object name reported when "rebase -i" stops has been
 shortened.


* rz/worktree-no-checkout (2016-03-29) 1 commit
  (merged to 'next' on 2016-04-06 at e725216)
 + worktree: add: introduce --checkout option

 "git worktree add" can be given "--no-checkout" option to only
 create an empty worktree without checking out the files.


* sb/misc-cleanups (2016-04-01) 4 commits
  (merged to 'next' on 2016-04-06 at 4e63691)
 + credential-cache, send_request: close fd when done
 + bundle: don't leak an fd in case of early return
 + abbrev_sha1_in_line: don't leak memory
 + notes: don't leak memory in git_config_get_notes_strategy

 Assorted minor clean-ups.


* sg/diff-multiple-identical-renames (2016-03-30) 1 commit
  (merged to 'next' on 2016-04-06 at ac19e48)
 + diffcore: fix iteration order of identical files during rename detection

 "git diff -M" used to work better when two originally identical
 files A and B got renamed to X/A and X/B by pairing A to X/A and B
 to X/B, but this was broken in the 2.0 timeframe.


* sk/send-pack-all-fix (2016-03-31) 1 commit
  (merged to 'next' on 2016-04-06 at 31e1e1b)
 + git-send-pack: fix --all option when used with directory

 "git send-pack --all <there>" was broken when its command line
 option parsing was written in the 2.6 timeframe.


* tb/blame-force-read-cache-to-workaround-safe-crlf (2016-04-05) 1 commit
  (merged to 'next' on 2016-04-06 at 263bba8)
 + correct blame for files commited with CRLF

 When running "git blame $path" with unnormalized data in the index
 for the path, the data in the working tree was blamed, even though
 "git add" would not have changed what is already in the index, due
 to "safe crlf" that disables the line-end conversion.  It has been
 corrected.

--------------------------------------------------
[New Topics]

* en/merge-fixes (2016-04-12) 2 commits
 - merge-recursive: do not check working copy when creating a virtual merge base
 - merge-recursive: remove duplicate code

 "merge-recursive" strategy incorrectly checked if a path that is
 involved in its internal merge exists in the working tree.

 Will merge to 'next'.


* en/merge-octopus-fix (2016-04-12) 2 commits
  (merged to 'next' on 2016-04-13 at 600b479)
 + merge-octopus: abort if index does not match HEAD
 + t6044: new merge testcases for when index doesn't match HEAD

 "merge-octopus" strategy did not ensure that the index is clean
 when merge begins.

 Will merge to 'master'.


* en/merge-trivial-fix (2016-04-12) 2 commits
  (merged to 'next' on 2016-04-13 at fb3ea86)
 + builtin/merge.c: fix a bug with trivial merges
 + t7605: add a testcase demonstrating a bug with trivial merges

 When "git merge" notices that the merge can be resolved purely at
 the tree level (without having to merge blobs) and the resulting
 tree happens to already exist in the object store, it forgot to
 update the index, which lead to an inconsistent state for later
 operations.

 Will merge to 'master'.


* jc/fsck-nul-in-commit (2016-04-14) 2 commits
 - fsck: detect and warn a commit with embedded NUL
 - fsck_commit_buffer(): do not special case the last validation

 "git fsck" learned to catch NUL byte in a commit object as
 potential error and warn.


* jc/ll-merge-internal (2016-04-14) 2 commits
 - ll-merge: use a longer conflict marker for internal merge
 - ll-merge: fix typo in comment

 RFC.


* jk/diff-compact-heuristic (2016-04-18) 2 commits
 - xdiff: implement empty line chunk heuristic
 - xdiff: add recs_match helper function


* nd/test-helpers (2016-04-15) 2 commits
 - test helpers: move test-* to t/helper/ subdirectory
 - Makefile: clean *.o files we create

 Sources to many test helper binaries (and the generated helpers)
 have been moved to t/helper/ subdirectory to reduce clutter at the
 top level of the tree.

--------------------------------------------------
[Stalled]

* tb/safe-crlf-output-fix (2016-04-01) 7 commits
 . convert.c: more safer crlf handling with text attribute
 . correct blame for files commited with CRLF
 . convert: unify the "auto" handling of CRLF
 . t0027: test cases for combined attributes
 . convert: allow core.autocrlf=input and core.eol=crlf
 . convert.c: stream and early out
 . read-cache: factor out get_sha1_from_index() helper

 The "safe CRLF" facility disables line-end conversion from CRLF to
 LF when checking in if the blob registered to the index already
 contains CR, but some codepaths like "git blame" did not know this,
 and instead assumed that only the configuration and attribute
 settings determined how the data from the working tree is converted.

 Will be rerolled.
 ($gmane/290637)


* da/user-useconfigonly (2016-04-01) 2 commits
 - ident: give "please tell me" message upon useConfigOnly error
 - ident: check for useConfigOnly before auto-detection of name/email

 The "user.useConfigOnly" configuration variable makes it an error
 if users do not explicitly set user.name and user.email.  However,
 its check was not done early enough and allowed another error to
 trigger, reporting that the default value we guessed from the
 system setting was unusable.  This was a suboptimal end-user
 experience as we want the users to set user.name/user.email without
 relying on the auto-detection at all.

 Waiting for Acks.
 ($gmane/290340)


* sg/completion-updates (2016-02-28) 21 commits
 - completion: cache the path to the repository
 - completion: extract repository discovery from __gitdir()
 - completion: don't guard git executions with __gitdir()
 - completion: consolidate silencing errors from git commands
 - completion: don't use __gitdir() for git commands
 - completion: respect 'git -C <path>'
 - completion: fix completion after 'git -C <path>'
 - completion: don't offer commands when 'git --opt' needs an argument
 - rev-parse: add '--absolute-git-dir' option
 - completion: list short refs from a remote given as a URL
 - completion: don't list 'HEAD' when trying refs completion outside of a repo
 - completion: list refs from remote when remote's name matches a directory
 - completion: respect 'git --git-dir=<path>' when listing remote refs
 - completion: fix most spots not respecting 'git --git-dir=<path>'
 - completion: ensure that the repository path given on the command line exists
 - completion tests: add tests for the __git_refs() helper function
 - completion tests: check __gitdir()'s output in the error cases
 - completion tests: consolidate getting path of current working directory
 - completion tests: make the $cur variable local to the test helper functions
 - completion tests: don't add test cruft to the test repository
 - completion: improve __git_refs()'s in-code documentation

 Will be rerolled.
 ($gmane/287839)


* az/p4-bare-no-rebase (2016-02-19) 1 commit
 - git-p4.py: Don't try to rebase on submit from bare repository

 "git p4 submit" attempts to do a rebase, which would fail if done
 in a bare repository.  Not doing this rebase would paper over the
 failure, which is what this patch does, but it is unclear what the
 side effect of not rebasing is.

 Needs a better explanation.


* ss/commit-dry-run-resolve-merge-to-no-op (2016-02-17) 1 commit
 - wt-status.c: set commitable bit if there is a meaningful merge.

 "git commit --dry-run" reported "No, no, you cannot commit." in one
 case where "git commit" would have allowed you to commit, and this
 improves it a little bit ("git commit --dry-run --short" still does
 not give you the correct answer, for example).


* nd/icase (2016-02-15) 12 commits
 - grep.c: reuse "icase" variable
 - diffcore-pickaxe: support case insensitive match on non-ascii
 - diffcore-pickaxe: "share" regex error handling code
 - grep/pcre: support utf-8
 - gettext: add is_utf8_locale()
 - grep/pcre: prepare locale-dependent tables for icase matching
 - grep/icase: avoid kwsset when -F is specified
 - grep/icase: avoid kwsset on literal non-ascii strings
 - test-regex: expose full regcomp() to the command line
 - test-regex: isolate the bug test code
 - grep: break down an "if" stmt in preparation for next changes
 - grep: allow -F -i combination

 "git grep -i" has been taught to fold case in non-ascii locales.

 Needs review.
 ($gmane/286137)


* ec/annotate-deleted (2015-11-20) 1 commit
 - annotate: skip checking working tree if a revision is provided

 Usability fix for annotate-specific "<file> <rev>" syntax with deleted
 files.

 Waiting for review.


* dg/subtree-rebase-test (2016-01-19) 1 commit
 - contrib/subtree: Add a test for subtree rebase that loses commits

 Reviewed up to v5.
 Will be rerolled.
 ($gmane/284426)


* js/am-3-merge-recursive-direct (2015-10-12) 2 commits
 - am: make a direct call to merge_recursive
 - merge_recursive_options: introduce the "gently" flag

 The merge_recursive_generic() function has been made a bit safer to
 call from inside a process.  "git am -3" was taught to make a direct
 call to the function when falling back to three-way merge.

 Being able to make a direct call would be good in general, but as a
 performance thing, the change needs to be backed up by numbers.

 Needs review.

 I haven't gone through the "gently" change with fine toothed comb;
 I can see that the change avoids calling die(), but I haven't made
 sure that the program states (e.g. what's in the in-core index) are
 adjusted sensibly when it returns to the caller instead of dying,
 or the codepaths that used to die() are free of resource leaks.
 The original code certainly did not care the program states at the
 point of dying exactly because it knew it is going to exit, but now
 they have to care, and they need to be audited.


* dk/gc-more-wo-pack (2016-01-13) 4 commits
 - gc: clean garbage .bitmap files from pack dir
 - t5304: ensure non-garbage files are not deleted
 - t5304: test .bitmap garbage files
 - prepare_packed_git(): find more garbage

 Follow-on to dk/gc-idx-wo-pack topic, to clean up stale
 .bitmap and .keep files.

 Waiting for a reroll.
 ($gmane/284368).


* jc/diff-b-m (2015-02-23) 5 commits
 . WIPWIP
 . WIP: diff-b-m
 - diffcore-rename: allow easier debugging
 - diffcore-rename.c: add locate_rename_src()
 - diffcore-break: allow debugging

 "git diff -B -M" produced incorrect patch when the postimage of a
 completely rewritten file is similar to the preimage of a removed
 file; such a resulting file must not be expressed as a rename from
 other place.

 The fix in this patch is broken, unfortunately.
 Will discard.

--------------------------------------------------
[Cooking]

* sb/submodule-init (2016-04-16) 4 commits
 - submodule: port init from shell to C
 - submodule: port resolve_relative_url from shell to C
 - Merge branch 'sb/submodule-path-misc-bugs' into sb/submodule-init
 - Merge branch 'sb/submodule-helper-clone-regression-fix' into sb/submodule-init
 (this branch uses sb/submodule-helper-clone-regression-fix and sb/submodule-path-misc-bugs.)

 Update of "git submodule" to move pieces of logic to C continues.


* nd/shallow-deepen (2016-04-13) 26 commits
 - fetch, upload-pack: --deepen=N extends shallow boundary by N commits
 - upload-pack: add get_reachable_list()
 - upload-pack: split check_unreachable() in two, prep for get_reachable_list()
 - t5500, t5539: tests for shallow depth excluding a ref
 - clone: define shallow clone boundary with --shallow-exclude
 - fetch: define shallow boundary with --shallow-exclude
 - upload-pack: support define shallow boundary by excluding revisions
 - refs: add expand_ref()
 - t5500, t5539: tests for shallow depth since a specific date
 - clone: define shallow clone boundary based on time with --shallow-since
 - fetch: define shallow boundary with --shallow-since
 - upload-pack: add deepen-since to cut shallow repos based on time
 - shallow.c: implement a generic shallow boundary finder based on rev-list
 - fetch-pack: use a separate flag for fetch in deepening mode
 - fetch-pack.c: mark strings for translating
 - fetch-pack: use a common function for verbose printing
 - fetch-pack: use skip_prefix() instead of starts_with()
 - upload-pack: move rev-list code out of check_non_tip()
 - upload-pack: tighten number parsing at "deepen" lines
 - upload-pack: use skip_prefix() instead of starts_with()
 - upload-pack: move "unshallow" sending code out of deepen()
 - upload-pack: remove unused variable "backup"
 - upload-pack: move "shallow" sending code out of deepen()
 - upload-pack: move shallow deepen code out of receive_needs()
 - transport-helper.c: refactor set_helper_option()
 - remote-curl.c: convert fetch_git() to use argv_array

 The existing "git fetch --depth=<n>" option was hard to use
 correctly when making the history of an existing shallow clone
 deeper.  A new option, "--deepen=<n>", has been added to make this
 easier to use.  "git clone" also learned "--shallow-since=<date>"
 and "--shallow-exclude=<tag>" options to make it easier to specify
 "I am interested only in the recent N months worth of history" and
 "Give me only the history since that version".

 Needs review.


* sb/clone-shallow-passthru (2016-04-13) 3 commits
 - clone: add t5614 to test cloning submodules with shallowness involved
 - clone: add `--shallow-submodules` flag
 - submodule clone: pass along `local` option

 "git clone" learned "--shallow-submodules" option.

 Needs review.


* ad/commit-have-m-option (2016-04-07) 2 commits
  (merged to 'next' on 2016-04-13 at 74088c2)
 + commit: do not ignore an empty message given by -m ''
 + commit: --amend -m '' silently fails to wipe message

 "git commit" misbehaved in a few minor ways when an empty message
 is given via -m '', all of which has been corrected.

 Will merge to 'master'.


* jc/xstrfmt-null-with-prec-0 (2016-04-07) 1 commit
  (merged to 'next' on 2016-04-13 at 2457462)
 + setup.c: do not feed NULL to "%.*s" even with precision 0

 Will merge to 'master'.


* dt/pre-refs-backend (2016-04-10) 24 commits
  (merged to 'next' on 2016-04-13 at 0a8f9dd)
 + refs: on symref reflog expire, lock symref not referrent
 + refs: move resolve_ref_unsafe into common code
 + show_head_ref(): check the result of resolve_ref_namespace()
 + check_aliased_update(): check that dst_name is non-NULL
 + checkout_paths(): remove unneeded flag variable
 + cmd_merge(): remove unneeded flag variable
 + fsck_head_link(): remove unneeded flag variable
 + read_raw_ref(): change flags parameter to unsigned int
 + files-backend: inline resolve_ref_1() into resolve_ref_unsafe()
 + read_raw_ref(): manage own scratch space
 + files-backend: break out ref reading
 + resolve_ref_1(): eliminate local variable "bad_name"
 + resolve_ref_1(): reorder code
 + resolve_ref_1(): eliminate local variable
 + resolve_ref_unsafe(): ensure flags is always set
 + resolve_ref_unsafe(): use for loop to count up to MAXDEPTH
 + resolve_missing_loose_ref(): simplify semantics
 + t1430: improve test coverage of deletion of badly-named refs
 + t1430: test for-each-ref in the presence of badly-named refs
 + t1430: don't rely on symbolic-ref for creating broken symrefs
 + t1430: clean up broken refs/tags/shadow
 + t1430: test the output and error of some commands more carefully
 + refs: move for_each_*ref* functions into common code
 + refs: move head_ref{,_submodule} to the common code

 Code restructuring around the "refs" area to prepare for pluggable
 refs backends.

 Will merge to 'master'.


* ky/imap-send (2016-04-13) 2 commits
  (merged to 'next' on 2016-04-13 at 52cf493)
 + imap-send: fix CRAM-MD5 response calculation
 + imap-send: check for NOLOGIN capability only when using LOGIN command

 Support for CRAM-MD5 authentication method in "git imap-send" did
 not work well.

 Will merge to 'master'.


* ky/imap-send-openssl-1.1.0 (2016-04-08) 4 commits
  (merged to 'next' on 2016-04-13 at 49d2643)
 + configure: remove checking for HMAC_CTX_cleanup
 + imap-send: avoid deprecated TLSv1_method()
 + imap-send: check NULL return of SSL_CTX_new()
 + imap-send: use HMAC() function provided by OpenSSL

 Upcoming OpenSSL 1.1.0 will break compilation b updating a few APIs
 we use in imap-send, which has been adjusted for the change.

 Will merge to 'master'.


* jc/http-socks5h (2016-04-10) 1 commit
  (merged to 'next' on 2016-04-13 at eb27afc)
 + http: differentiate socks5:// and socks5h://

 The socks5:// proxy support added back in 2.6.4 days was not aware
 that socks5h:// proxies behave differently.

 Will merge to 'master'.


* jc/send-email-skip-backup (2016-04-12) 1 commit
 - send-email: detect and offer to skip backup files

 A careless invocation of "git send-email directory/" after editing
 0001-change.patch with an editor often ends up sending both
 0001-change.patch and its backup file, 0001-change.patch~, causing
 embarrassment and a minor confusion.  Detect such an input and
 offer to skip the backup files when sending the patches out.

 Needs review.


* jk/do-not-printf-NULL (2016-04-10) 3 commits
  (merged to 'next' on 2016-04-13 at 60912e3)
 + git_config_set_multivar_in_file: handle "unset" errors
 + git_config_set_multivar_in_file: all non-zero returns are errors
 + config: lower-case first word of error strings

 "git config" had a codepath that tried to pass a NULL to
 printf("%s"), which nobody seems to have noticed.

 Will merge to 'master'.


* jk/use-write-script-more (2016-04-12) 3 commits
  (merged to 'next' on 2016-04-13 at d6718bf)
 + t3404: use write_script
 + t1020: do not overuse printf and use write_script
 + t5532: use write_script

 Code clean-up.

 Will merge to 'master'.


* nf/mergetool-prompt (2016-04-12) 2 commits
 - SQUASH???
 - difftool/mergetool: make the form of yes/no questions consistent

 UI consistency improvements.


* va/i18n-misc-updates (2016-04-13) 6 commits
 - i18n: branch: move comment for translators
 - i18n: branch: unmark string for translation
 - i18n: builtin/rm.c: remove a comma ',' from string
 - i18n: unpack-trees: mark strings for translation
 - i18n: builtin/branch.c: mark option for translation
 - i18n: index-pack: use plural string instead of normal one

 Mark several messages for translation.


* jc/drop-git-spec-in (2016-04-06) 1 commit
 - Makefile: stop pretending to support rpmbuild

 As nobody maintains our in-tree git.spec.in and distros use their
 own spec file, we stopped pretending that we support "make rpm".

 Comments?


* ar/diff-args-osx-precompose (2016-04-05) 1 commit
 - diff: run arguments through precompose_argv

 Many commands normalize command line arguments from NFD to NFC
 variant of UTF-8 on OSX, but commands in the "diff" family did
 not, causing "git diff $path" to complain that no such path is
 known to Git.  They have been taught to do the normalization.

 Will be rerolled?
 ($gmane/290724)


* ew/send-email-readable-message-id (2016-04-06) 1 commit
  (merged to 'next' on 2016-04-13 at 422959a)
 + send-email: more meaningful Message-ID

 "git send-email" now uses a more readable timestamps when
 formulating a message ID.

 Will merge to 'master'.


* st/verify-tag (2016-04-18) 6 commits
 - tag -v: verfy directly rather than exec-ing verify-tag
 - verify-tag: move verification code to tag.c
 - verify-tag: add sha1 argument to verify_tag()
 - verify-tag: change variable name for readability
 - t7030: test verifying multiple tags
 - builtin/verify-tag.c: ignore SIGPIPE in gpg-interface

 Saw review comments on this v6.
 Expecting a reroll.


* ew/send-email-drop-data-dumper (2016-04-06) 1 commit
  (merged to 'next' on 2016-04-13 at 180266c)
 + send-email: do not load Data::Dumper

 Code clean-up.

 Will merge to 'master'.


* kn/ref-filter-branch-list (2016-04-12) 16 commits
 . branch: implement '--format' option
 . branch: use ref-filter printing APIs
 . branch, tag: use porcelain output
 . ref-filter: allow porcelain to translate messages in the output
 . ref-filter: add support for %(refname:dir) and %(refname:base)
 . ref-filter: introduce refname_atom_parser()
 . ref-filter: introduce symref_atom_parser()
 . ref-filter: make "%(symref)" atom work with the ':short' modifier
 . ref-filter: add support for %(upstream:track,nobracket)
 . ref-filter: make %(upstream:track) prints "[gone]" for invalid upstreams
 . ref-filter: introduce format_ref_array_item()
 . ref-filter: move get_head_description() from branch.c
 . ref-filter: modify "%(objectname:short)" to take length
 . ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
 . ref-filter: include reference to 'used_atom' within 'atom_value'
 . ref-filter: implement %(if), %(then), and %(else) atoms

 The code to list branches in "git branch" has been consolidated
 with the more generic ref-filter API.

 Rerolled but seems to lack jk/branch-shortening-funny-symrefs aka
 $gmane/291295 yet.


* sb/submodule-helper-clone-regression-fix (2016-04-01) 6 commits
  (merged to 'next' on 2016-04-13 at c6584bb)
 + submodule--helper, module_clone: catch fprintf failure
 + submodule--helper: do not borrow absolute_path() result for too long
 + submodule--helper, module_clone: always operate on absolute paths
 + submodule--helper clone: create the submodule path just once
 + submodule--helper: fix potential NULL-dereference
 + recursive submodules: test for relative paths
 (this branch is used by sb/submodule-init.)

 A partial rewrite of "git submodule" in the 2.7 timeframe changed
 the way the gitdir: pointer in the submodules point at the real
 repository location to use absolute paths by accident.  This has
 been corrected.

 Will merge to 'master'.


* sb/submodule-path-misc-bugs (2016-03-30) 6 commits
  (merged to 'next' on 2016-04-18 at 9daa5ce)
 + t7407: make expectation as clear as possible
 + submodule update: test recursive path reporting from subdirectory
 + submodule update: align reporting path for custom command execution
 + submodule status: correct path handling in recursive submodules
 + submodule update --init: correct path handling in recursive submodules
 + submodule foreach: correct path display in recursive submodules
 (this branch is used by sb/submodule-init.)

 "git submodule" reports the paths of submodules the command
 recurses into, but this was incorrect when the command was not run
 from the root level of the superproject.

 Will merge to 'master'.


* xy/format-patch-base (2016-04-12) 4 commits
 - format-patch: introduce format.base configuration
 - format-patch: introduce --base=auto option
 - format-patch: add '--base' option to record base tree info
 - patch-ids: make commit_patch_id() a public helper function

 "git format-patch" learned a new "--base" option to record what
 (public, well-known) commit the original series was built on in
 its output.

 Review comments sent.
 ($gmane/291198)


* pb/commit-verbose-config (2016-04-12) 6 commits
 . commit: add a commit.verbose config variable
 . t7507-commit-verbose: improve test coverage by testing number of diffs
 . parse-options.c: make OPTION_COUNTUP respect "unspecified" values
 . t0040-parse-options: improve test coverage
 . test-parse-options: print quiet as integer
 . t0040-test-parse-options.sh: fix style issues

 "git commit" learned to pay attention to "commit.verbose"
 configuration variable and act as if "--verbose" option was
 given from the command line.
 


* dt/index-helper (2016-04-14) 16 commits
 - read-cache: config for waiting for index-helper
 - index-helper: optionally automatically run
 - index-helper: autorun mode
 - index-helper: don't run if already running
 - index-helper: kill mode
 - unpack-trees: preserve index extensions
 - update-index: enable/disable watchman support
 - index-helper: use watchman to avoid refreshing index with lstat()
 - index-helper: add watchman support to reduce index refresh cost
 - read-cache: add watchman 'WAMA' extension
 - index-helper: add --detach
 - daemonize(): set a flag before exiting the main process
 - index-helper: add --strict
 - index-helper: new daemon for caching index and related stuff
 - read-cache: allow to keep mmap'd memory after reading
 - read-cache.c: fix constness of verify_hdr()

 Needs review.


* jc/bundle (2016-03-03) 6 commits
 - index-pack: --clone-bundle option
 - Merge branch 'jc/index-pack' into jc/bundle
 - bundle v3: the beginning
 - bundle: keep a copy of bundle file name in the in-core bundle header
 - bundle: plug resource leak
 - bundle doc: 'verify' is not about verifying the bundle

 The beginning of "split bundle", which could be one of the
 ingredients to allow "git clone" traffic off of the core server
 network to CDN.


* ad/cygwin-wants-rename (2015-08-07) 1 commit
 - config.mak.uname: Cygwin needs OBJECT_CREATION_USES_RENAMES

 Will hold.
 ($gmane/275680).


* jc/rerere-multi (2016-04-06) 11 commits
  (merged to 'next' on 2016-04-13 at 3db2753)
 + rerere: adjust 'forget' to multi-variant world order
 + rerere: split code to call ll_merge() further
 + rerere: move code related to "forget" together
 + rerere: gc and clear
 + rerere: do use multiple variants
 + t4200: rerere a merge with two identical conflicts
 + rerere: allow multiple variants to exist
 + rerere: delay the recording of preimage
 + rerere: handle leftover rr-cache/$ID directory and postimage files
 + rerere: scan $GIT_DIR/rr-cache/$ID when instantiating a rerere_id
 + rerere: split conflict ID further

 "git rerere" can encounter two or more files with the same conflict
 signature that have to be resolved in different ways, but there was
 no way to record these separate resolutions.

 Will merge to 'master'.


* jc/merge-drop-old-syntax (2015-04-29) 1 commit
 - merge: drop 'git merge <message> HEAD <commit>' syntax

 Stop supporting "git merge <message> HEAD <commit>" syntax that has
 been deprecated since October 2007, and issues a deprecation
 warning message since v2.5.0.

 It has been reported that git-gui still uses the deprecated syntax,
 which needs to be fixed before this final step can proceed.
 ($gmane/282594)
