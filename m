From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Apr 2016, #01; Fri, 1)
Date: Fri, 01 Apr 2016 15:47:15 -0700
Message-ID: <xmqq1t6pgd58.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 02 00:47:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1am7qg-0005D0-45
	for gcvg-git-2@plane.gmane.org; Sat, 02 Apr 2016 00:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754472AbcDAWrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 18:47:20 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:54927 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754131AbcDAWrS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 18:47:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1C40A4FC3F;
	Fri,  1 Apr 2016 18:47:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=T
	LQmbacYbjoLiIBXIxZ/8AeAeEc=; b=aYxyOpiDEJhE2RTARpnrF+IC5m2fh19XU
	BOfDOBNATl6jQ/OYNjFiM1wU8YVZj0ckAAlLykwsbS8G1l/6sqSw2tjcuyHjGotD
	fwld4p6jlu6G0xsDZQGB7pxwASZRceF+WFau+w9sSh6BBGabvRAF/YywWXNkxz6h
	iNxf3ItNog=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=dN1
	ZmY2LSRuDh00WWBh1hzvyaZwgXSFu+VfGnJgrF2qyYJAPvEovwuybVEkBeDXgQGe
	nZWQy48uAlPxDrRrvMg8f+els8O1YC2T8Gm1OHuv8SGzgqa4ArLUzgAMfmyvYuBT
	XgyTRoyMFpG0JHL+pYxX2ymHgFySr6ZXfpkvhg+A=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 13BD44FC3E;
	Fri,  1 Apr 2016 18:47:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3302E4FC3D;
	Fri,  1 Apr 2016 18:47:16 -0400 (EDT)
X-master-at: 90f7b16b3adc78d4bbabbd426fb69aa78c714f71
X-next-at: 9d4de1f0cb995171390ad99185bae1b0cbc1de70
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AEC0BEFA-F85B-11E5-9F61-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290588>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

There are quite a few topics that have been cooking in 'next' during
the pre-2.8 freeze period that are ready to be merged to 'master';
the first batch will be merged early next week, and then the tip of
'next' will be rebuilt on top sometime mid next week.  Let's start
looking at new shiny toys after all that happens.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* jn/mergetools-examdiff (2016-03-28) 2 commits
 - mergetools: add support for ExamDiff
 - mergetools: create mergetool_find_win32_cmd() helper function for winmerge

 "git mergetools" learned to drive ExamDiff.

 Waiting for an Ack by the area expert.


* kn/for-each-tag-branch (2016-03-30) 1 commit
 - for-each-ref: fix description of '--contains' in manpage

 Docfix.

 Will merge to 'next'.


* kn/ref-filter-branch-list (2016-03-30) 16 commits
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

 Will be rerolled.


* oa/doc-diff-check (2016-03-29) 1 commit
 - Documentation: git diff --check detects conflict markers

 Docfix.

 Will merge to 'next'.


* rz/worktree-no-checkout (2016-03-29) 1 commit
 - worktree: add: introduce --checkout option

 "git worktree add" can be given "--no-checkout" option to only
 create an empty worktree without checking out the files.

 Will merge to 'next'.


* sb/misc-cleanups (2016-04-01) 4 commits
 - credential-cache, send_request: close fd when done
 - bundle: don't leak an fd in case of early return
 - abbrev_sha1_in_line: don't leak memory
 - notes: don't leak memory in git_config_get_notes_strategy

 Assorted minor clean-ups.

 Will merge to 'next'.


* sb/submodule-helper-clone-regression-fix (2016-04-01) 6 commits
 - submodule--helper, module_clone: catch fprintf failure
 - submodule--helper: do not borrow absolute_path() result for too long
 - submodule--helper, module_clone: always operate on absolute paths
 - submodule--helper clone: create the submodule path just once
 - submodule--helper: fix potential NULL-dereference
 - recursive submodules: test for relative paths

 A partial rewrite of "git submodule" in the 2.7 timeframe changed
 the way the gitdir: pointer in the submodules point at the real
 repository location to use absolute paths by accident.  This has
 been corrected.

 Any further comments?  Otherwise will merge to 'next'.


* sb/submodule-path-misc-bugs (2016-03-30) 6 commits
 - t7407: make expectation as clear as possible
 - submodule update: test recursive path reporting from subdirectory
 - submodule update: align reporting path for custom command execution
 - submodule status: correct path handling in recursive submodules
 - submodule update --init: correct path handling in recursive submodules
 - submodule foreach: correct path display in recursive submodules

 "git submodule" reports the paths of submodules the command
 recurses into, but this was incorrect when the command was not run
 from the root level of the superproject.

 Any further comments?  Otherwise will merge to 'next'.


* sg/diff-multiple-identical-renames (2016-03-30) 1 commit
 - diffcore: fix iteration order of identical files during rename detection

 "git diff -M" used to work better when two originally identical
 files A and B got renamed to X/A and X/B by pairing A to X/A and B
 to X/B, but this was broken in 2.0 timeframe.

 Will merge to 'next'.


* sk/send-pack-all-fix (2016-03-31) 1 commit
 - git-send-pack: fix --all option when used with directory

 "git send-pack --all <there>" was broken when its command line
 option parsing was written in 2.6 timeframe.

 Will merge to 'next'.


* ss/msvc (2016-03-30) 2 commits
 - MSVC: use shipped headers instead of fallback definitions
 - MSVC: vsnprintf in Visual Studio 2015 doesn't need SNPRINTF_SIZE_CORR any more

 Will merge to 'next'.


* xy/format-patch-base (2016-03-31) 4 commits
 - format-patch: introduce format.base configuration
 - format-patch: introduce --base=auto option
 - format-patch: add '--base' option to record base tree info
 - patch-ids: make commit_patch_id() a public helper function

 "git format-patch" learned a new "--base" option to record what
 (public, well-known) commit the original series was built on in
 its output.

 Will be rerolled.
 ($gmane/290365)


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


* tb/safe-crlf-output-fix (2016-04-01) 7 commits
 - convert.c: more safer crlf handling with text attribute
 - correct blame for files commited with CRLF
 - convert: unify the "auto" handling of CRLF
 - t0027: test cases for combined attributes
 - convert: allow core.autocrlf=input and core.eol=crlf
 - convert.c: stream and early out
 - read-cache: factor out get_sha1_from_index() helper

 The "safe CRLF" facility disables line-end conversion from CRLF to
 LF when checking in if the blob registered to the index already
 contains CR, but some codepaths like "git blame" did not know this,
 and instead assumed that only the configuration and attribute
 settings determined how the data from the working tree is converted.

 Comments sent.
 ($gmane/290548)


--------------------------------------------------
[Stalled]

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

* ak/use-hashmap-iter-first-in-submodule-config (2016-03-23) 1 commit
 - submodule-config: use hashmap_iter_first()

 Minor code cleanup.

 Will merge to 'next'.


* ky/branch-d-worktree (2016-03-29) 1 commit
 - branch -d: refuse deleting a branch which is currently checked out

 When "git worktree" feature is in use, "git branch -d" allowed
 deletion of a branch that is checked out in another worktree

 Will merge to 'next'.


* ky/branch-m-worktree (2016-03-28) 2 commits
 - branch -m: update all per-worktree HEADs
 - refs: add a new function set_worktree_head_symref

 When "git worktree" feature is in use, "git branch -m" renamed a
 branch that is checked out in another worktree without adjusting
 the HEAD symbolic ref for the worktree.

 Needs review by "refs" area experts.


* nd/apply-doc (2016-03-24) 2 commits
 - git-apply.txt: mention the behavior inside a subdir
 - git-apply.txt: remove a space

 Will merge to 'next'.


* nd/apply-report-skip (2016-03-24) 1 commit
 - apply: report patch skipping in verbose mode

 "git apply -v" learned to report paths in the patch that were
 skipped via --include/--exclude mechanism or being outside the
 current working directory.

 Will merge to 'next'.


* pb/opt-cmdmode-doc (2016-03-25) 1 commit
 - api-parse-options.txt: document OPT_CMDMODE()

 Minor API documentation update.


* rt/completion-help (2016-03-24) 2 commits
 - completion: add 'revisions' and 'everyday' to 'git help'
 - completion: add option '--guides' to 'git help'

 Shell completion (in contrib/) updates.

 Will merge to 'next'.


* rt/rebase-i-shorten-stop-report (2016-03-28) 1 commit
 - rebase-i: print an abbreviated hash when stop for editing

 The commit object name reported when "rebase -i" stops has been
 shortened.

 Will merge to 'next'.


* jk/check-repository-format (2016-03-11) 10 commits
 - verify_repository_format: mark messages for translation
 - setup: drop repository_format_version global
 - setup: unify repository version callbacks
 - init: use setup.c's repo version verification
 - setup: refactor repo format reading and verification
 - config: drop git_config_early
 - check_repository_format_gently: stop using git_config_early
 - lazily load core.sharedrepository
 - wrap shared_repository global in get/set accessors
 - setup: document check_repository_format()

 The repository set-up sequence has been streamlined (the biggest
 change is that there is no longer git_config_early()), so that we
 do not attempt to look into refs/* when we know we do not have a
 Git repository.

 Will merge to 'next'.


* mj/pull-rebase-autostash (2016-03-29) 7 commits
 - t5520: test --[no-]autostash with pull.rebase=true
 - t5520: modify tests to reduce common code
 - t5520: use test_i18ngrep instead of test_cmp
 - t5520: explicitly unset rebase.autostash
 - t5520: use consistent capitalization in test titles
  (merged to 'next' on 2016-03-23 at ebf1afa)
 + pull --rebase: add --[no-]autostash flag
 + git-pull.c: introduce git_pull_config()

 "git pull --rebase" learned "--[no-]autostash" option, so that
 the rebase.autostash configuration variable set to true can be
 overridden from the command line.

 Will merge to 'next'.


* pb/commit-verbose-config (2016-03-14) 1 commit
 - commit: add a commit.verbose config variable
 (this branch uses pb/t7502-drop-dup.)

 "git commit" learned to pay attention to "commit.verbose"
 configuration variable and act as if "--verbose" option was
 given from the command line.

 Will merge to 'next'.


* pb/t7502-drop-dup (2016-03-11) 1 commit
  (merged to 'next' on 2016-03-15 at 037c877)
 + t/t7502 : drop duplicate test
 (this branch is used by pb/commit-verbose-config.)

 Code clean-up.

 Will merge to 'master' after 2.8 final.


* ss/commit-squash-msg (2016-03-21) 1 commit
  (merged to 'next' on 2016-03-23 at 0b72631)
 + commit: do not lose SQUASH_MSG contents

 When "git merge --squash" stopped due to conflict, the concluding
 "git commit" failed to read in the SQUASH_MSG that shows the log
 messages from all the squashed commits.

 Will merge to 'master' after 2.8 final.


* ls/p4-map-user (2016-03-15) 1 commit
  (merged to 'next' on 2016-03-23 at 9e0a4f5)
 + git-p4: map a P4 user to Git author name and email address

 Will merge to 'master' after 2.8 final.


* jc/merge-refuse-new-root (2016-03-23) 1 commit
  (merged to 'next' on 2016-03-23 at d7da4cf)
 + merge: refuse to create too cool a merge by default

 "git merge" used to allow merging two branches that have no common
 base by default, which led to a brand new history of an existing
 project created and then get pulled by an unsuspecting maintainer,
 which allowed an unnecessary parallel history merged into the
 existing project.  The command has been taught not to allow this by
 default, with an escape hatch "--allow-unrelated-histories" option
 to be used in a rare event that merges histories of two projects
 that started their lives independently.

 Will merge to 'master' after 2.8 final.


* jk/credential-cache-comment-exit (2016-03-18) 1 commit
  (merged to 'next' on 2016-03-23 at d2b8cc7)
 + credential-cache--daemon: clarify "exit" action semantics

 Will merge to 'master' after 2.8 final.


* jk/send-email-rtrim-mailrc-alias (2016-03-18) 1 commit
  (merged to 'next' on 2016-03-23 at 74f1f44)
 + send-email: ignore trailing whitespace in mailrc alias file

 Will merge to 'master' after 2.8 final.


* jk/test-httpd-config-nosystem (2016-03-18) 1 commit
  (merged to 'next' on 2016-03-23 at 245263b)
 + t/lib-httpd: pass through GIT_CONFIG_NOSYSTEM env

 Will merge to 'master' after 2.8 final.


* lt/pretty-expand-tabs (2016-03-30) 3 commits
 - pretty: allow tweaking tabwidth in --expand-tabs
 - pretty: enable --expand-tabs by default for selected pretty formats
 - pretty: expand tabs in indented logs to make things line up properly

 Needs tests.


* sb/clone-shallow-passthru (2016-03-23) 3 commits
 - clone: add t5614 to test cloning submodules with shallowness involved
 - submodule clone: pass along `local` option
 - clone: add `--shallow-submodules` flag
 (this branch uses sb/submodule-parallel-update; is tangled with sb/submodule-init.)

 "git clone" learned "--shallow-submodules" option.

 Needs review.


* sb/clone-t57-t56 (2016-03-16) 1 commit
  (merged to 'next' on 2016-03-23 at 5df850d)
 + clone tests: rename t57* => t56*

 Rename bunch of tests on "git clone" for better organization.

 Will merge to 'master' after 2.8 final.


* sb/rebase-x (2016-03-18) 2 commits
  (merged to 'next' on 2016-03-23 at ef8861b)
 + t3404: cleanup double empty lines between tests
 + rebase: decouple --exec from --interactive

 "git rebase -x" can be used without passing "-i" option.

 Will merge to 'master' after 2.8 final.


* cc/apply (2016-04-01) 4 commits
 - builtin/apply: free patch when parse_chunk() fails
 - builtin/apply: handle parse_binary() failure
  (merged to 'next' on 2016-03-24 at 70623f2)
 + apply: remove unused call to free() in gitdiff_{old,new}name()
 + builtin/apply: get rid of useless 'name' variable

 Code clean-up.

 Will merge to 'next'.


* dt/index-helper (2016-03-23) 18 commits
 - SQUASH - minimum compilation fix
 - read-cache: config for waiting for index-helper
 - index-helper: optionally automatically run
 - index-helper: autorun mode
 - index-helper: don't run if already running
 - index-helper: kill mode
 - unpack-trees: preserve index extensions
 - update-index: enable/disable watchman support
 - index-helper: use watchman to avoid refreshing index with lstat()
 - Add watchman support to reduce index refresh cost
 - read-cache: invalidate untracked cache data when reading WAMA
 - read-cache: add watchman 'WAMA' extension
 - index-helper: add --detach
 - daemonize(): set a flag before exiting the main process
 - index-helper: add --strict
 - index-helper: new daemon for caching index and related stuff
 - read-cache: allow to keep mmap'd memory after reading
 - read-cache.c: fix constness of verify_hdr()


* jv/merge-nothing-into-void (2016-03-23) 1 commit
  (merged to 'next' on 2016-03-23 at 40b905d)
 + merge: fix NULL pointer dereference when merging nothing into void

 "git merge FETCH_HEAD" dereferenced NULL pointer when merging
 nothing into an unborn history (which is arguably unusual usage,
 which perhaps was the reason why nobody noticed it).

 Will merge to 'master' after 2.8 final.


* la/tag-force-signing-annotated-tags (2016-03-22) 1 commit
  (merged to 'next' on 2016-03-24 at 424da3f)
 + tag: add the option to force signing of annotated tags

 "git tag" can create an annotated tag without explicitly given an
 "-a" (or "-s") option (i.e. when a tag message is given).  A new
 configuration variable, tag.forceSignAnnotated, can be used to tell
 the command to create signed tag in such a situation.

 Will merge to 'master' after 2.8 final.


* cc/doc-recommend-performance-trace-to-file (2016-03-07) 1 commit
  (merged to 'next' on 2016-03-23 at 086b9f2)
 + Documentation: talk about pager in api-trace.txt

 Will merge to 'master' after 2.8 final.


* da/mergetool-delete-delete-conflict (2016-03-10) 2 commits
  (merged to 'next' on 2016-03-15 at 281a81a)
 + mergetool: honor tempfile configuration when resolving delete conflicts
 + mergetool: support delete/delete conflicts

 "git mergetool" did not work well with conflicts that both sides
 deleted.

 Will merge to 'master' after 2.8 final.


* es/test-gpg-tags (2016-03-06) 4 commits
  (merged to 'next' on 2016-03-15 at 617119f)
 + t6302: skip only signed tags rather than all tests when GPG is missing
 + t6302: also test annotated in addition to signed tags
 + t6302: normalize names and descriptions of signed tags
 + lib-gpg: drop unnecessary "missing GPG" warning

 A test for tags has been restructured so that more parts of it can
 easily be run on a platform without a working GnuPG.

 Will merge to 'master' after 2.8 final.


* jk/getwholeline-getdelim-empty (2016-03-05) 1 commit
  (merged to 'next' on 2016-03-15 at e70d4bd)
 + strbuf_getwholeline: NUL-terminate getdelim buffer on error

 strbuf_getwholeline() did not NUL-terminate the buffer on certain
 corner cases in its error codepath.

 Will merge to 'master' after 2.8 final.


* jk/startup-info (2016-03-07) 6 commits
  (merged to 'next' on 2016-03-15 at eb95e5f)
 + use setup_git_directory() in test-* programs
 + grep: turn off gitlink detection for --no-index
 + mailmap: do not resolve blobs in a non-repository
 + remote: don't resolve HEAD in non-repository
 + setup: set startup_info->have_repository more reliably
 + setup: make startup_info available everywhere

 The startup_info data, which records if we are working inside a
 repository (among other things), are now uniformly available to Git
 subcommand implementations, and Git avoids attempting to touch
 references when we are not in a repository.

 Will merge to 'master' after 2.8 final.


* rj/xdiff-prepare-plug-leak-on-error-codepath (2016-03-04) 2 commits
  (merged to 'next' on 2016-03-15 at f72755e)
 + xdiff/xprepare: fix a memory leak
 + xdiff/xprepare: use the XDF_DIFF_ALG() macro to access flag bits

 A small memory leak in an error codepath has been plugged in xdiff
 code.

 Will merge to 'master' after 2.8 final.


* jc/index-pack (2016-03-03) 2 commits
  (merged to 'next' on 2016-03-15 at 42efaa7)
 + index-pack: add a helper function to derive .idx/.keep filename
 + Merge branch 'jc/maint-index-pack-keep' into jc/index-pack
 (this branch is used by jc/bundle; uses jc/maint-index-pack-keep; is tangled with jc/index-pack-clone-bundle.)

 Code clean-up.

 Will merge to 'master' after 2.8 final.


* jc/maint-index-pack-keep (2016-03-03) 1 commit
  (merged to 'next' on 2016-03-04 at bc1d37a)
 + index-pack: correct --keep[=<msg>]
 (this branch is used by jc/bundle, jc/index-pack and jc/index-pack-clone-bundle.)

 "git index-pack --keep[=<msg>] pack-$name.pack" simply did not work.

 Will merge to 'master' after 2.8 final.


* mm/readme-markdown (2016-04-01) 2 commits
 - git.spec: use README.md, not README
  (merged to 'next' on 2016-03-01 at 81f3858)
 + README.md: don't take 'commandname' literally

 The top-level README file has been updated to be more appropriate
 for the sign on the front door to welcome new acquaintances to Git
 by toning down inside jokes and making it into MarkDown.

 Will merge to 'next'.


* gf/fetch-pack-direct-object-fetch (2016-03-05) 2 commits
  (merged to 'next' on 2016-03-06 at 5628860)
 + fetch-pack: update the documentation for "<refs>..." arguments
  (merged to 'next' on 2016-03-04 at 49199e0)
 + fetch-pack: fix object_id of exact sha1

 Fetching of history by naming a commit object name directly didn't
 work across remote-curl transport.

 Will merge to 'master' after 2.8 final.


* jk/add-i-highlight (2016-02-28) 1 commit
  (merged to 'next' on 2016-03-04 at 4ac3aa1)
 + add--interactive: allow custom diff highlighting programs

 Will merge to 'master' after 2.8 final.


* jk/config-get-urlmatch (2016-02-28) 3 commits
  (merged to 'next' on 2016-03-04 at feeb192)
 + Documentation/git-config: fix --get-all description
 + Documentation/git-config: use bulleted list for exit codes
 + config: fail if --get-urlmatch finds no value

 "git config --get-urlmatch", unlike other variants of the "git
 config --get" family, did not signal error with its exit status
 when there was no matching configuration.

 Will merge to 'master' after 2.8 final.


* jk/rev-parse-local-env-vars (2016-02-29) 2 commits
  (merged to 'next' on 2016-03-04 at a0300d5)
 + rev-parse: let some options run outside repository
 + t1515: add tests for rev-parse out-of-repo helpers

 The "--local-env-vars" and "--resolve-git-dir" options of "git
 rev-parse" failed to work outside a repository when the command's
 option parsing was rewritten in 1.8.5 era.

 Will merge to 'master' after 2.8 final.


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


* mm/lockfile-error-message (2016-03-01) 2 commits
  (merged to 'next' on 2016-03-04 at 04ed7e6)
 + lockfile: improve error message when lockfile exists
 + lockfile: mark strings for translation

 Will merge to 'master' after 2.8 final.


* ss/exc-flag-is-a-collection-of-bits (2016-03-01) 1 commit
  (merged to 'next' on 2016-03-04 at 5ea48c7)
 + dir: store EXC_FLAG_* values in unsigned integers

 Will merge to 'master' after 2.8 final.


* jc/bundle (2016-03-03) 6 commits
 - index-pack: --clone-bundle option
 - Merge branch 'jc/index-pack' into jc/bundle
 - bundle v3: the beginning
 - bundle: keep a copy of bundle file name in the in-core bundle header
 - bundle: plug resource leak
 - bundle doc: 'verify' is not about verifying the bundle
 (this branch uses jc/index-pack and jc/maint-index-pack-keep; is tangled with jc/index-pack-clone-bundle.)

 The beginning of "split bundle", which could be one of the
 ingredients to allow "git clone" traffic off of the core server
 network to CDN.


* ss/receive-pack-parse-options (2016-03-01) 1 commit
  (merged to 'next' on 2016-03-04 at c577ea7)
 + builtin/receive-pack.c: use parse_options API

 The command line argument parser for "receive-pack" has been
 rewritten to use parse-options.

 Will merge to 'master' after 2.8 final.


* jk/credential-clear-config (2016-02-26) 1 commit
  (merged to 'next' on 2016-03-04 at f7b26b7)
 + credential: let empty credential specs reset helper list

 The credential.helper configuration variable is cumulative and
 there is no good way to override it from the command line.  As
 a special case, giving an empty string as its value now serves
 as the signal to clear the values specified in various files.

 Will merge to 'master' after 2.8 final.


* jk/submodule-c-credential (2016-03-23) 7 commits
  (merged to 'next' on 2016-03-23 at 952367a)
 + git_config_push_parameter: handle empty GIT_CONFIG_PARAMETERS
  (merged to 'next' on 2016-03-15 at 81df5b1)
 + git: submodule honor -c credential.* from command line
 + quote: implement sq_quotef()
 + submodule: fix segmentation fault in submodule--helper clone
 + submodule: fix submodule--helper clone usage
 + submodule: check argc count for git submodule--helper clone
 + submodule: don't pass empty string arguments to submodule--helper clone

 "git -c credential.<var>=<value> submodule" can now be used to
 propagate configuration variables related to credential helper
 down to the submodules.

 Will merge to 'master' after 2.8 final.


* nd/shallow-deepen (2016-02-23) 25 commits
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


* mm/diff-renames-default (2016-02-25) 5 commits
  (merged to 'next' on 2016-02-25 at 947c399)
 + diff: activate diff.renames by default
 + log: introduce init_log_defaults()
 + t: add tests for diff.renames (true/false/unset)
 + t4001-diff-rename: wrap file creations in a test
 + Documentation/diff-config: fix description of diff.renames

 The end-user facing Porcelain level commands like "diff" and "log"
 now enables the rename detection by default.

 Will merge to 'master' after 2.8 final.


* mp/upload-pack-use-embedded-args (2016-02-25) 1 commit
  (merged to 'next' on 2016-02-26 at f0a54e5)
 + upload-pack: use argv_array for pack_objects

 The embedded args argv-array in the child process is used to build
 the command line to run pack-objects instead of using a separate
 array of strings.

 Will merge to 'master' after 2.8 final.


* sb/submodule-init (2016-03-15) 2 commits
 . submodule: port init from shell to C
 . submodule: port resolve_relative_url from shell to C
 (this branch uses sb/submodule-parallel-update; is tangled with sb/clone-shallow-passthru.)

 Update of "git submodule" to move pieces of logic to C continues.

 Needs review.
 ($gmane/288824)


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


* sb/submodule-parallel-update (2016-03-01) 10 commits
  (merged to 'next' on 2016-03-15 at a8bf6c5)
 + clone: allow an explicit argument for parallel submodule clones
 + submodule update: expose parallelism to the user
 + submodule helper: remove double 'fatal: ' prefix
 + git submodule update: have a dedicated helper for cloning
 + run_processes_parallel: rename parameters for the callbacks
 + run_processes_parallel: treat output of children as byte array
 + submodule update: direct error message to stderr
 + fetching submodules: respect `submodule.fetchJobs` config option
 + submodule-config: drop check against NULL
 + submodule-config: keep update strategy around
 (this branch is used by sb/clone-shallow-passthru and sb/submodule-init.)

 A major part of "git submodule update" has been ported to C to take
 advantage of the recently added framework to run download tasks in
 parallel.

 Will merge to 'master' after 2.8 final.


* dt/refs-backend-lmdb (2016-02-25) 45 commits
 . SQUASH??? Minimum compilation band-aid
 . tests: add ref-storage argument
 . refs: tests for lmdb backend
 . refs: add LMDB refs storage backend
 . refs: break out resolve_ref_unsafe_submodule
 . config: read ref storage config on startup
 . refs: register ref storage backends
 . svn: learn ref-storage argument
 . clone: allow ref storage backend to be set for clone
 . refs: check submodules' ref storage config
 . init: allow alternate ref strorage to be set for new repos
 . refs: always handle non-normal refs in files backend
 . refs: resolve symbolic refs first
 . refs: on symref reflog expire, lock symref not referrent
 . refs: don't dereference on rename
 . refs: allow log-only updates
 . refs: move duplicate check to common code
 . refs: make lock generic
 . refs: handle non-normal ref renames
 . refs: add method to rename refs
 . refs: add methods to init refs db
 . refs: add method for delete_refs
 . refs: add method for initial ref transaction commit
 . refs: add methods for reflog
 . refs: add do_for_each_per_worktree_ref
 . refs: reduce the visibility of do_for_each_ref()
 . refs: add method for do_for_each_ref
 . refs: add methods for misc ref operations
 . refs: add a backend method structure with transaction functions
 . refs: move resolve_ref_unsafe into common code
 . files-backend: break out ref reading
 . refs: move for_each_*ref* functions into common code
 . refs: move head_ref{,_submodule} to the common code
 . Merge branch 'sb/submodule-parallel-update' into dt/refs-backend-lmdb
 . clone: allow an explicit argument for parallel submodule clones
 . submodule update: expose parallelism to the user
 . git submodule update: have a dedicated helper for cloning
 . run_processes_parallel: correctly terminate callbacks with an LF
 . run_processes_parallel: rename parameters for the callbacks
 . run-command: expose default_{start_failure, task_finished}
 . run_processes_parallel: treat output of children as byte array
 . submodule update: direct error message to stderr
 . fetching submodules: respect `submodule.fetchJobs` config option
 . submodule-config: drop check against NULL
 . submodule-config: keep update strategy around

 A reroll exists, but it seems that will further be rerolled.


* ad/cygwin-wants-rename (2015-08-07) 1 commit
 - config.mak.uname: Cygwin needs OBJECT_CREATION_USES_RENAMES

 Will hold.
 ($gmane/275680).


* jc/rerere-multi (2016-03-28) 11 commits
 - rerere: adjust 'forget' to multi-variant world order
 - rerere: split code to call ll_merge() further
 - rerere: move code related to "forget" together
 - rerere: gc and clear
 - rerere: do use multiple variants
 - t4200: rerere a merge with two identical conflicts
 - rerere: allow multiple variants to exist
 - rerere: delay the recording of preimage
 - rerere: handle leftover rr-cache/$ID directory and postimage files
 - rerere: scan $GIT_DIR/rr-cache/$ID when instantiating a rerere_id
 - rerere: split conflict ID further

 "git rerere" can encounter two or more files with the same conflict
 signature that have to be resolved in different ways, but there was
 no way to record these separate resolutions.

 Need to send out the final round of review as this should be now complete.


* jc/merge-drop-old-syntax (2015-04-29) 1 commit
 - merge: drop 'git merge <message> HEAD <commit>' syntax

 Stop supporting "git merge <message> HEAD <commit>" syntax that has
 been deprecated since October 2007.  It has been reported that
 git-gui still uses the deprecated syntax, which needs to be fixed
 before this final step can proceed.
 ($gmane/282594)
