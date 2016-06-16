From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Apr 2016, #06; Thu, 21)
Date: Thu, 21 Apr 2016 15:20:39 -0700
Message-ID: <xmqqy486r4co.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 00:20:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atMxt-00053m-Ps
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 00:20:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872AbcDUWUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 18:20:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60143 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751594AbcDUWUo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 18:20:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7754314A40;
	Thu, 21 Apr 2016 18:20:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=4
	xHP2NGoCNV2Clo58jV/yrq8kU8=; b=SQL6FwaThUcgGf0TSS4+K1HZ3EuYRg4Rl
	6qfRfjr5MZuQ/we7szdv94chpPXRWgdFb4xKGZQnrwzXpmfelgRPzJBc4tqi8c6j
	yjtS3+Uw3Ab6P1JiEBorQU/uFLgWGaaFlWCFt8Nz/Xzi5NlKZpcjwHd8GOEoGoLo
	ZyNBK82Sa8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Rcq
	MrqmQ9+OTMy/tptkaPYDthav8q2zcEhfpCYP2H6fhzbAkYVwhhYJXApr4m2redNK
	4312VPW+mrUjtjQC7zgoPJ1vya627Om02z95f2B9utnHR7L7AEaIFFf72sR8BeZE
	cEa2KbzEEkaE8Vl4U3NZKihrbgNnQ8nV/Mt8boi0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6E61814A3F;
	Thu, 21 Apr 2016 18:20:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 94B5F14A3E;
	Thu, 21 Apr 2016 18:20:40 -0400 (EDT)
X-master-at: e6ac6e1f7d54584c2b03f073b5f329a37f4a9561
X-next-at: 1352ede9d7e10ec5ebc541fb841397c8b165343a
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 47F6B85A-080F-11E6-9C82-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292156>

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
[New Topics]

* jd/p4-jobs-in-commit (2016-04-19) 2 commits
 - git-p4: add P4 jobs to git commit message
 - git-p4: clean-up code style in tests

 "git p4" learned to record P4 jobs in Git commit that imports from
 the history in Perforce.

 Will merge to 'next'.


* js/replace-edit-use-editor-configuration (2016-04-20) 1 commit
 - replace --edit: respect core.editor

 "git replace -e" did not honour "core.editor" configuration.

 Will merge to 'next'.


* ls/p4-lfs (2016-04-19) 2 commits
 - git-p4: fix Git LFS pointer parsing
 - travis-ci: update Git-LFS and P4 to the latest version

 Recent update to Git LFS broke "git p4" by changing the output from
 its "lfs pointer" subcommand.


* sb/mv-submodule-fix (2016-04-19) 1 commit
 - mv: allow moving nested submodules

 "git mv old new" did not adjust the path for a submodule that lives
 as a subdirectory inside old/ directory correctly.

 Will merge to 'next'.


* tb/convert-eol-autocrlf (2016-04-19) 4 commits
 - convert.c: ident + core.autocrlf didn't work
 - t0027: test cases for combined attributes
 - convert: allow core.autocrlf=input and core.eol=crlf
 - t0027: avoid false "unchanged" due to lstat() matching after a change

 Setting core.autocrlf to 'input' and core.eol to 'crlf' used to be
 rejected, but because the code gives precedence to core.autcrlf,
 there is no need to, hence we no longer reject the combination.

 Will merge to 'next'.


* bc/object-id (2016-04-19) 6 commits
 - match-trees: convert several leaf functions to use struct object_id
 - tree-walk: convert tree_entry_extract() to use struct object_id
 - struct name_entry: use struct object_id instead of unsigned char sha1[20]
 - match-trees: convert shift_tree() and shift_tree_by() to use object_id
 - test-match-trees: convert to use struct object_id
 - sha1-name: introduce a get_oid() function

 Will be rerolled.
 ($gmane/291950)


* ep/http-curl-trace (2016-04-20) 3 commits
 - git.txt: document the new GIT_TRACE_CURL environment variable
 - imap-send.c: introduce the GIT_TRACE_CURL enviroment variable
 - http.c: implement the GIT_TRACE_CURL environment variable

 HTTP transport gained an option to produce more detailed debugging
 trace.

 Still under discussion.
 ($gmane/292074)


* nd/worktree-various-heads (2016-04-20) 13 commits
 - branch: do not rename a branch under bisect or rebase
 - worktree.c: test if branch being bisected in another worktree
 - wt-status.c: split bisect detection out of wt_status_get_state()
 - worktree.c: test if branch being rebased in another worktree
 - worktree.c: avoid referencing to worktrees[i] multiple times
 - wt-status.c: make wt_status_check_rebase() work on any worktree
 - SQUASH???
 - wt-status.c: split rebase detection out of wt_status_get_state()
 - path.c: refactor and add worktree_git_path()
 - worktree.c: mark current worktree
 - worktree.c: make find_shared_symref() return struct worktree *
 - worktree.c: store "id" instead of "git_dir"
 - path.c: add git_common_path() and strbuf_git_common_path()

 The experimental "multiple worktree" feature gains more safety to
 forbid operations on a branch that is checked out or being actively
 worked on elsewhere, by noticing that e.g. it is being rebased.

 Being reviewed.
 ($gmane/292050)


* bw/rebase-merge-entire-branch (2016-04-20) 1 commit
 - git-rebase--merge: don't include absent parent as a base

 "git rebase -m" could be asked to rebase an entire branch starting
 from the root, but failed by assuming that there always is a parent
 commit to the first commit on the branch.

 Will merge to 'next'.


* jk/push-client-deadlock-fix (2016-04-20) 5 commits
 - t5504: drop sigpipe=ok from push tests
 - fetch-pack: isolate sigpipe in demuxer thread
 - send-pack: isolate sigpipe in demuxer thread
 - run-command: teach async threads to ignore SIGPIPE
 - send-pack: close demux pipe before finishing async process

 "git push" from a corrupt repository that attempts to push a large
 number of refs deadlocked waiting for a rejection from the
 receiving end that will never come.

 Will merge to 'next'.


* jc/merge-refuse-new-root (2016-04-21) 2 commits
 - pull: pass --allow-unrelated-histories to "git merge"
 - t3033: avoid 'ambiguous refs' warning

 "git pull" has been taught to pass --allow-unrelated-histories
 option to underlying "git merge".

 Will merge to 'next'.
 

--------------------------------------------------
[Stalled]

* ar/diff-args-osx-precompose (2016-04-05) 1 commit
 - diff: run arguments through precompose_argv

 Many commands normalize command line arguments from NFD to NFC
 variant of UTF-8 on OSX, but commands in the "diff" family did
 not, causing "git diff $path" to complain that no such path is
 known to Git.  They have been taught to do the normalization.

 Will be rerolled?
 ($gmane/290724)


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

* pb/commit-verbose-config (2016-04-19) 6 commits
 - commit: add a commit.verbose config variable
 - t7507-commit-verbose: improve test coverage by testing number of diffs
 - parse-options.c: make OPTION_COUNTUP respect "unspecified" values
 - t0040-parse-options: improve test coverage
 - test-parse-options: print quiet as integer
 - t0040-test-parse-options.sh: fix style issues

 "git commit" learned to pay attention to "commit.verbose"
 configuration variable and act as if "--verbose" option was
 given from the command line.

 Is this going to be rerolled?
 ($gmane/291382)


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


* jk/diff-compact-heuristic (2016-04-19) 2 commits
 - xdiff: implement empty line chunk heuristic
 - xdiff: add recs_match helper function

 Patch output from "git diff" and friends has been tweaked to be
 more readable by using a blank line as a strong hint that the
 contents before and after it belong to a logically separate unit.

 Will merge to 'next'.


* nd/test-helpers (2016-04-15) 2 commits
 - test helpers: move test-* to t/helper/ subdirectory
 - Makefile: clean *.o files we create

 Sources to many test helper binaries (and the generated helpers)
 have been moved to t/helper/ subdirectory to reduce clutter at the
 top level of the tree.

 Will merge to 'next'.


* sb/submodule-init (2016-04-16) 4 commits
 - submodule: port init from shell to C
 - submodule: port resolve_relative_url from shell to C
 - Merge branch 'sb/submodule-path-misc-bugs' into sb/submodule-init
 - Merge branch 'sb/submodule-helper-clone-regression-fix' into sb/submodule-init
 (this branch uses sb/submodule-helper-clone-regression-fix and sb/submodule-path-misc-bugs.)

 Update of "git submodule" to move pieces of logic to C continues.

 Will merge to 'next'.


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


* va/i18n-misc-updates (2016-04-19) 9 commits
 - i18n: builtin/pull.c: split strings marked for translation
 - i18n: builtin/pull.c: mark placeholders for translation
 - i18n: git-parse-remote.sh: mark strings for translation
 - i18n: branch: move comment for translators
 - i18n: branch: unmark string for translation
 - i18n: builtin/rm.c: remove a comma ',' from string
 - i18n: unpack-trees: mark strings for translation
 - i18n: builtin/branch.c: mark option for translation
 - i18n: index-pack: use plural string instead of normal one

 Mark several messages for translation.

 Comments?  They looked all sensible to me.


* jc/drop-git-spec-in (2016-04-06) 1 commit
 - Makefile: stop pretending to support rpmbuild

 As nobody maintains our in-tree git.spec.in and distros use their
 own spec file, we stopped pretending that we support "make rpm".

 Will merge to 'next'.


* ew/send-email-readable-message-id (2016-04-06) 1 commit
  (merged to 'next' on 2016-04-13 at 422959a)
 + send-email: more meaningful Message-ID

 "git send-email" now uses a more readable timestamps when
 formulating a message ID.

 Will merge to 'master'.


* st/verify-tag (2016-04-19) 6 commits
 - tag -v: verfy directly rather than exec-ing verify-tag
 - verify-tag: move tag verification code to tag.c
 - verify-tag: prepare verify_tag for libification
 - verify-tag: update variable name and type
 - t7030: test verifying multiple tags
 - builtin/verify-tag.c: ignore SIGPIPE in gpg-interface

 Unify internal logic between "git tag -v" and "git verify-tag"
 commands by making one directly call into the other.

 Will merge to 'next'.


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
  (merged to 'next' on 2016-04-19 at 1352ede)
 + config.mak.uname: Cygwin needs OBJECT_CREATION_USES_RENAMES

 On Cygwin, object creation uses the "create a temporary and then
 rename it to the final name" pattern, not "create a temporary,
 hardlink it to the final name and then unlink the temporary"
 pattern.

 This is necessary to use Git on Windows shared directories, and is
 already enabled for the MinGW and plain Windows builds.  It also
 has been used in Cygwin packaged versions of Git for quite a while.
 See http://thread.gmane.org/gmane.comp.version-control.git/291853

 Will merge to 'master'.
 ($gmane/275680, $gmane/291853).


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
