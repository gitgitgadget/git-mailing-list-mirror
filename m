From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jun 2014, #02; Fri, 6)
Date: Fri, 06 Jun 2014 15:42:02 -0700
Message-ID: <xmqqfvjhpsn9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 00:42:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wt2q0-0000LR-55
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jun 2014 00:42:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752240AbaFFWmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 18:42:12 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50835 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751635AbaFFWmI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 18:42:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1FF391CD68;
	Fri,  6 Jun 2014 18:42:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=3
	Gnxbwc9tUYwZ+CymzX44161QtE=; b=mxjA6IdIGXJn2YISj7RbUrhtYGScCALfw
	VFLw8YQetomckIRCod/+/voAfnVB0byfBud0Cf5Gf34Vo5S0Z8xeCNnwPFBAX/d4
	XeEqQaFd3uTbepbu+MW2JdDEjnkdadNWEfcbXc8DTxLQCxPksyix8UxHR/ZtKoa/
	/w/lf7yrZk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=xyX
	6WeFnnyMB92XZ1GRPOolc88x17DvfRQZvBRlVdIzCOOTFMU8jyl8BabCy0zp/iK6
	PuD3SAVTzPTSdsIwtDYDWLH/nZyHsaM6Ksr9C2SyW2RuD3JRRIEQzczrEmMzH2KU
	3gZbk80Owdv0FSXCNMwcO0jwOdDNlRCiCM/PsYfw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 169AA1CD66;
	Fri,  6 Jun 2014 18:42:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E36C01CD61;
	Fri,  6 Jun 2014 18:42:03 -0400 (EDT)
X-master-at: 0953113bb5687f42bcdfc3d20dd3a125784ad383
X-next-at: 41885497b0c577b31af733b8c4b05bcded1912bd
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C7EA6198-EDCB-11E3-8220-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251015>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

The second batch of topics, all of which have been cooking for quite
a while on the 'next' branch, have been merged to 'master'.

I am aware of a handful of multi-patch topics sent to the list the
past week that have not been picked up, and I won't be picking them
up yet, before we have a chance to first have some topics that have
been cooking in 'next' during the previous cycle merged to 'master'
and then rewind the tip of 'next'.  At that point, I may have to ask
for them to be rebased on top of the updated 'master' to reduce
conflicts.  Thanks for your patience.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* bc/blame-crlf-test (2014-05-08) 1 commit
  (merged to 'next' on 2014-05-14 at b819505)
 + blame: correctly handle files regardless of autocrlf

 If a file contained CRLF line endings in a repository with
 core.autocrlf=input, then blame always marked lines as "Not
 Committed Yet", even if they were unmodified.


* da/imap-send-use-credential-helper (2014-04-29) 1 commit
  (merged to 'next' on 2014-05-12 at b0698a5)
 + imap-send: use git-credential

 "git imap-send" learned to ask the credential helper for
 authentication material.


* dk/blame-reorg (2014-04-28) 1 commit
  (merged to 'next' on 2014-05-14 at 354a0e3)
 + blame: large-scale performance rewrite

 "git blame" has been optimized greatly by reorganising the data
 structure that is used to keep track of the work to be done, thanks
 to David Karstrup <dak@gnu.org>.


* dk/raise-core-deltabasecachelimit (2014-05-06) 1 commit
  (merged to 'next' on 2014-05-12 at 97ec92a)
 + Bump core.deltaBaseCacheLimit to 96m

 The `core.deltabasecachelimit` used to default to 16 MiB, but this
 proved to be too small, and has been bumped to 96 MiB.


* dt/merge-recursive-case-insensitive (2014-05-08) 2 commits
  (merged to 'next' on 2014-05-12 at 820d524)
 + mv: allow renaming to fix case on case insensitive filesystems
 + merge-recursive.c: fix case-changing merge bug

 On a case insensitive filesystem, merge-recursive incorrectly
 deleted the file that is to be renamed to a name that is the same
 except for case differences.


* ep/shell-assign-and-export-vars (2014-05-23) 2 commits
  (merged to 'next' on 2014-05-23 at 7699c0e)
 + scripts: more "export VAR=VALUE" fixes
 + scripts: "export VAR=VALUE" construct is not portable


* fc/status-printf-squelch-format-zero-length-warnings (2014-05-07) 1 commit
  (merged to 'next' on 2014-05-12 at 6b04e23)
 + silence a bunch of format-zero-length warnings


* jc/coding-guidelines (2014-05-20) 9 commits
  (merged to 'next' on 2014-05-23 at bb351fc)
 + CodingGuidelines: avoid "test <cond> -a/-o <cond>"
  (merged to 'next' on 2014-05-12 at e1fcf62)
 + CodingGuidelines: on splitting a long line
 + CodingGuidelines: on comparison
 + CodingGuidelines: do not call the conditional statement "if()"
 + CodingGuidelines: give an example for shell function preamble
 + CodingGuidelines: give an example for control statements
 + CodingGuidelines: give an example for redirection
 + CodingGuidelines: give an example for case/esac statement
 + CodingGuidelines: once it is in, it is not worth the code churn

 Some people need these things spelled out, unable to follow advices
 given by others when they fail to imitate the surrounding existing
 code.


* jd/subtree (2014-05-13) 6 commits
  (merged to 'next' on 2014-05-14 at 977db74)
 + contrib/subtree: allow adding an annotated tag
  (merged to 'next' on 2014-05-07 at 81b375d)
 + contrib/subtree/Makefile: clean up rule for "clean"
 + contrib/subtree/Makefile: clean up rules to generate documentation
 + contrib/subtree/Makefile: s/libexecdir/gitexecdir/
 + contrib/subtree/Makefile: use GIT-VERSION-FILE
 + contrib/subtree/Makefile: scrap unused $(gitdir)

 Clean-up build procedure of subtree in contrib/.


* je/pager-do-not-recurse (2014-04-28) 1 commit
  (merged to 'next' on 2014-05-12 at 32de470)
 + pager: do allow spawning pager recursively

 We used to unconditionally disable the pager in the pager process
 we spawn to feed out output, but that prevented people who want to
 run "less" within "less" from doing so.


* jj/command-line-adjective (2014-05-21) 1 commit
  (merged to 'next' on 2014-05-23 at fe136c8)
 + Documentation: use "command-line" when used as a compound adjective, and fix other minor grammatical issues


* jk/commit-C-pick-empty (2014-04-28) 1 commit
  (merged to 'next' on 2014-05-12 at c187e1e)
 + commit: do not complain of empty messages from -C

 "git commit --allow-empty-message -C $commit" did not work when the
 commit did not have any log message.


* jk/grep-tell-run-command-to-cd-when-running-pager (2014-05-07) 1 commit
  (merged to 'next' on 2014-05-12 at 065cb22)
 + grep: use run-command's "dir" option for --open-files-in-pager


* jk/index-pack-report-missing (2014-05-12) 1 commit
  (merged to 'next' on 2014-05-14 at 72d40e1)
 + index-pack: distinguish missing objects from type errors


* jk/squelch-compiler-warning-from-funny-error-macro (2014-05-06) 2 commits
  (merged to 'next' on 2014-05-12 at d9daf8d)
 + let clang use the constant-return error() macro
 + inline constant return from error() function


* jk/utf8-switch-between-nfd-and-nfc (2014-04-29) 1 commit
  (merged to 'next' on 2014-05-12 at 948823c)
 + t3910: show failure of core.precomposeunicode with decomposed filenames

 Document a known breakage with a test.


* jn/contrib-remove-diffall (2014-05-09) 1 commit
  (merged to 'next' on 2014-05-12 at 416009e)
 + contrib: remove git-diffall

 Spring cleaning of contrib/.


* jn/contrib-remove-vim (2014-05-09) 1 commit
  (merged to 'next' on 2014-05-12 at 9e727c8)
 + contrib: remove vim support instructions

 Spring cleaning of contrib/.


* jn/test-lint-unmoor (2014-05-23) 1 commit
  (merged to 'next' on 2014-05-23 at aa997bc)
 + test-lint: find unportable sed, echo, test, and export usage after &&


* mc/git-p4-prepare-p4-only (2014-05-27) 1 commit
  (merged to 'next' on 2014-05-27 at 71572fe)
 + git-p4: Do not include diff in spec file when just preparing p4


* mk/show-s-no-extra-blank-line-for-merges (2014-05-15) 1 commit
  (merged to 'next' on 2014-05-21 at 3b98b35)
 + git-show: fix 'git show -s' to not add extra terminator after merge commit

 "git show -s" (i.e. show log message only) used to incorrectly emit
 an extra blank line after a merge commit.


* mm/pager-less-sans-S (2014-05-07) 1 commit
  (merged to 'next' on 2014-05-07 at 66ce999)
 + pager: remove 'S' from $LESS by default

 Since the very beginning of Git, we gave the LESS environment a
 default value "FRSX" when we spawn "less" as the pager.  "S" (chop
 long lines instead of wrapping) has been removed from this default
 set of options, because it is more or less a personal taste thing,
 as opposed to others that have good justifications (i.e. "R" is
 very much justified because many kinds of output we produce are
 colored and "FX" is justified because output we produce is often
 shorter than a page).


* mt/rebase-i-keep-empty-test (2014-05-19) 1 commit
  (merged to 'next' on 2014-05-21 at d87d266)
 + rebase --keep-empty -i: add test


* nd/status-auto-comment-char (2014-05-19) 2 commits
  (merged to 'next' on 2014-05-21 at f762e62)
 + commit: allow core.commentChar=auto for character auto selection
 + config: be strict on core.commentChar

 The `core.commentChar` configuration variable is used to specify a
 custom comment character other than the default "#" to be used in
 the commit log editor.  This can be set to `auto` to attempt to
 choose a different character that does not conflict with what
 already starts a line in the message being edited for cases like
 "git commit --amend".


* rs/reflog-exists (2014-05-08) 2 commits
  (merged to 'next' on 2014-05-12 at 24a1d01)
 + checkout.c: use ref_exists instead of file_exist
 + refs.c: add new functions reflog_exists and delete_reflog


* sk/spawn-less-case-insensitively-from-grep-O-i (2014-05-15) 1 commit
  (merged to 'next' on 2014-05-21 at eb28305)
 + git grep -O -i: if the pager is 'less', pass the '-I' option

 "git grep -O" to show the lines that hit in the pager did not work
 well with case insensitive search.  We now spawn "less" with its
 "-I" option when it is used as the pager (which is the default).


* sk/submodules-absolute-path-on-windows (2014-05-08) 1 commit
  (merged to 'next' on 2014-05-14 at 83a05d9)
 + Revert "submodules: fix ambiguous absolute paths under Windows"


* ss/howto-manage-trunk (2014-05-28) 1 commit
  (merged to 'next' on 2014-05-28 at 5318336)
 + How to keep a project's canonical history correct.


* tb/unicode-6.3-zero-width (2014-05-12) 2 commits
  (merged to 'next' on 2014-05-14 at 08e0171)
 + utf8: make it easier to auto-update git_wcwidth()
 + utf8.c: use a table for double_width

 Update the logic to compute the display width needed for utf8
 strings and allow us to more easily maintain the tables used in
 that logic.

 We may want to let the users choose if codepoints with ambiguous
 widths are treated as a double or single width in a follow-up patch.


* tg/tag-state-tag-name-in-editor-hints (2014-05-07) 1 commit
  (merged to 'next' on 2014-05-12 at 0b7db32)
 + builtin/tag.c: show tag name to hint in the message editor

 "git tag" when editing the tag message shows the name of the tag
 being edited as a comment in the editor.


* tl/relax-in-poll-emulation (2014-04-29) 1 commit
  (merged to 'next' on 2014-05-12 at 9369b08)
 + compat/poll: sleep 1 millisecond to avoid busy wait


* wg/svn-fe-style-fixes (2014-05-12) 1 commit
  (merged to 'next' on 2014-05-12 at 88c0e0d)
 + svn-fe: conform to pep8


* wk/doc-clarify-upstream (2014-05-13) 1 commit
  (merged to 'next' on 2014-05-14 at 6c8fb52)
 + Documentation: mention config sources for @{upstream}

--------------------------------------------------
[New Topics]

* jc/rev-parse-argh-dashed-multi-words (2014-06-04) 1 commit
  (merged to 'next' on 2014-06-06 at 8b04440)
 + update-index: fix segfault with missing --cacheinfo argument

 "update-index --cacheinfo" in 2.0 crashes on a malformed command line.

 Will merge to 'master'.


* sk/test-cmp-bin (2014-06-04) 1 commit
  (merged to 'next' on 2014-06-06 at 112ae4b)
 + t5000, t5003: do not use test_cmp to compare binary files

 Will merge to 'master'.


* dt/refs-check-refname-component-optim (2014-06-05) 1 commit
  (merged to 'next' on 2014-06-06 at e85fb57)
 + refs.c: optimize check_refname_component()

 Will merge to 'master'.


* jm/dedup-test-config (2014-06-05) 1 commit
  (merged to 'next' on 2014-06-06 at 443f096)
 + t/t7810-grep.sh: remove duplicate test_config()

 Will merge to 'master'.

--------------------------------------------------
[Stalled]

* nd/multiple-work-trees (2014-03-25) 28 commits
 - count-objects: report unused files in $GIT_DIR/repos/...
 - gc: support prune --repos
 - gc: style change -- no SP before closing bracket
 - prune: strategies for linked checkouts
 - checkout: detach if the branch is already checked out elsewhere
 - checkout: clean up half-prepared directories in --to mode
 - checkout: support checking out into a new working directory
 - use new wrapper write_file() for simple file writing
 - wrapper.c: wrapper to open a file, fprintf then close
 - setup.c: support multi-checkout repo setup
 - setup.c: detect $GIT_COMMON_DIR check_repository_format_gently()
 - setup.c: convert check_repository_format_gently to use strbuf
 - setup.c: detect $GIT_COMMON_DIR in is_git_directory()
 - setup.c: convert is_git_directory() to use strbuf
 - git-stash: avoid hardcoding $GIT_DIR/logs/....
 - *.sh: avoid hardcoding $GIT_DIR/hooks/...
 - git-sh-setup.sh: use rev-parse --git-path to get $GIT_DIR/objects
 - $GIT_COMMON_DIR: a new environment variable
 - commit: use SEQ_DIR instead of hardcoding "sequencer"
 - fast-import: use git_path() for accessing .git dir instead of get_git_dir()
 - reflog: avoid constructing .lock path with git_path
 - *.sh: respect $GIT_INDEX_FILE
 - git_path(): be aware of file relocation in $GIT_DIR
 - path.c: group git_path(), git_pathdup() and strbuf_git_path() together
 - path.c: rename vsnpath() to do_git_path()
 - git_snpath(): retire and replace with strbuf_git_path()
 - path.c: make get_pathname() call sites return const char *
 - path.c: make get_pathname() return strbuf instead of static buffer

 A replacement for contrib/workdir/git-new-workdir that does not
 rely on symbolic links and make sharing of objects and refs safer
 by making the borrowee and borrowers aware of each other.


* mh/lockfile (2014-04-15) 25 commits
 - trim_last_path_elm(): replace last_path_elm()
 - resolve_symlink(): take a strbuf parameter
 - resolve_symlink(): use a strbuf for internal scratch space
 - change lock_file::filename into a strbuf
 - commit_lock_file(): use a strbuf to manage temporary space
 - try_merge_strategy(): use a statically-allocated lock_file object
 - try_merge_strategy(): remove redundant lock_file allocation
 - struct lock_file: declare some fields volatile
 - lockfile: avoid transitory invalid states
 - commit_lock_file(): die() if called for unlocked lockfile object
 - commit_lock_file(): inline temporary variable
 - remove_lock_file(): call rollback_lock_file()
 - lock_file(): exit early if lockfile cannot be opened
 - write_packed_entry_fn(): convert cb_data into a (const int *)
 - prepare_index(): declare return value to be (const char *)
 - delete_ref_loose(): don't muck around in the lock_file's filename
 - cache.h: define constants LOCK_SUFFIX and LOCK_SUFFIX_LEN
 - lockfile.c: document the various states of lock_file objects
 - lock_file(): always add lock_file object to lock_file_list
 - hold_lock_file_for_append(): release lock on errors
 - lockfile: unlock file if lockfile permissions cannot be adjusted
 - rollback_lock_file(): set fd to -1
 - rollback_lock_file(): do not clear filename redundantly
 - api-lockfile: expand the documentation
 - unable_to_lock_die(): rename function from unable_to_lock_index_die()

 Refactor and fix corner-case bugs in the lockfile API, all looked
 sensible.

 Expecting a reroll.


* bg/rebase-off-of-previous-branch (2014-04-16) 1 commit
 - git-rebase: print name of rev when using shorthand

 Teach "git rebase -" to report the concrete name of the branch
 (i.e. the previous one).

 But it stops short and does not do the same for "git rebase @{-1}".
 Expecting a reroll.


* tr/merge-recursive-index-only (2014-02-05) 3 commits
 - merge-recursive: -Xindex-only to leave worktree unchanged
 - merge-recursive: internal flag to avoid touching the worktree
 - merge-recursive: remove dead conditional in update_stages()
 (this branch is used by tr/remerge-diff.)

 Will hold.


* tr/remerge-diff (2014-02-26) 5 commits
 . log --remerge-diff: show what the conflict resolution changed
 . name-hash: allow dir hashing even when !ignore_case
 . merge-recursive: allow storing conflict hunks in index
 . revision: fold all merge diff variants into an enum merge_diff_mode
 . combine-diff: do not pass revs->dense_combined_merges redundantly
 (this branch uses tr/merge-recursive-index-only.)

 "log -p" output learns a new way to let users inspect a merge
 commit by showing the differences between the automerged result
 with conflicts the person who recorded the merge would have seen
 and the final conflict resolution that was recorded in the merge.

 Needs to be rebased, now kb/fast-hashmap topic is in.


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


* po/everyday-doc (2014-01-27) 1 commit
 - Make 'git help everyday' work

 This may make the said command to emit something, but the source is
 not meant to be formatted into a manual pages to begin with, and
 also its contents are a bit stale.  It may be a good first step in
 the right direction, but needs more work to at least get the
 mark-up right before public consumption.

 Will hold.


* jk/branch-at-publish-rebased (2014-01-17) 5 commits
 . t1507 (rev-parse-upstream): fix typo in test title
 . implement @{publish} shorthand
 . branch_get: provide per-branch pushremote pointers
 . branch_get: return early on error
 . sha1_name: refactor upstream_mark

 Give an easier access to the tracking branches from "other" side in
 a triangular workflow by introducing B@{publish} that works in a
 similar way to how B@{upstream} does.

 Meant to be used as a basis for whatever Ram wants to build on.

 Ejected from 'pu' to unclutter.


* fc/publish-vs-upstream (2014-04-21) 8 commits
 . sha1_name: add support for @{publish} marks
 . sha1_name: simplify track finding
 . sha1_name: cleanup interpret_branch_name()
 . branch: display publish branch
 . push: add --set-publish option
 . branch: add --set-publish-to option
 . Add concept of 'publish' branch
 . t5516 (fetch-push): fix test restoration

 Add branch@{publish}; it seems that this is somewhat different from
 Ram and Peff started working on.  At least the tip needs to be
 rerolled not to squat on @{p} which @{push} and possibly @{pull}
 may want to share.

 Ejected from 'pu' to unclutter.


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


* jl/submodule-recursive-checkout (2013-12-26) 5 commits
 - Teach checkout to recursively checkout submodules
 - submodule: teach unpack_trees() to update submodules
 - submodule: teach unpack_trees() to repopulate submodules
 - submodule: teach unpack_trees() to remove submodule contents
 - submodule: prepare for recursive checkout of submodules

 An RFCv2 exists ($gmane/241455) with sizable review comments.
 Expecting a reroll.


* jc/graph-post-root-gap (2013-12-30) 3 commits
 - WIP: document what we want at the end
 - graph: remove unused code a bit
 - graph: stuff the current commit into graph->columns[]

 This was primarily a RFH ($gmane/239580).


* np/pack-v4 (2013-09-18) 90 commits
 . packv4-parse.c: add tree offset caching
 . t1050: replace one instance of show-index with verify-pack
 . index-pack, pack-objects: allow creating .idx v2 with .pack v4
 . unpack-objects: decode v4 trees
 . unpack-objects: allow to save processed bytes to a buffer
 - ...

 Nico and Duy advancing the eternal vaporware pack-v4.  This is here
 primarily for wider distribution of the preview edition.

 Needs to be rebased, now the pack-bitmap series is in.


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

* jl/status-added-submodule-is-never-ignored (2014-04-07) 2 commits
  (merged to 'next' on 2014-06-06 at a2d0105)
 + commit -m: commit staged submodules regardless of ignore config
 + status/commit: show staged submodules regardless of ignore config

 submodule.*.ignore and diff.ignoresubmodules are used to ignore all
 submodule changes in "diff" output, but it can be confusing to
 apply these configuration values to status and commit.

 This is a backward-incompatible change, but should be so in a good
 way (aka bugfix).

 Will merge to 'master'.


* jl/git-gui-show-added-submodule-changes (2014-04-15) 1 commit
 - git-gui: show staged submodules regardless of ignore config

 Tentatively queued what I expect to receive via Pat Thoyts.


* jl/gitk-show-added-submodule-changes (2014-04-15) 3 commits
 - gitk: show staged submodules regardless of ignore config
 - gitk: Merge branch 'new' of https://github.com/vnwildman/gitk
 - l10n: Init Vietnamese translation

 Tentatively queued what I expect to receive via Paul Mackerras.


* bg/xcalloc-nmemb-then-size (2014-05-27) 12 commits
  (merged to 'next' on 2014-06-06 at 7058fe5)
 + transport-helper.c: rearrange xcalloc arguments
 + remote.c: rearrange xcalloc arguments
 + reflog-walk.c: rearrange xcalloc arguments
 + pack-revindex.c: rearrange xcalloc arguments
 + notes.c: rearrange xcalloc arguments
 + imap-send.c: rearrange xcalloc arguments
 + http-push.c: rearrange xcalloc arguments
 + diff.c: rearrange xcalloc arguments
 + config.c: rearrange xcalloc arguments
 + commit.c: rearrange xcalloc arguments
 + builtin/remote.c: rearrange xcalloc arguments
 + builtin/ls-remote.c: rearrange xcalloc arguments

 Like calloc(3), xcalloc() takes nmemb and then size.

 Will merge to 'master'.


* jk/complete-merge-pull (2014-05-27) 2 commits
  (merged to 'next' on 2014-06-06 at f88b8e3)
 + completion: add missing options for git-merge
 + completion: add a note that merge options are shared

 The completion code did not know about quite a few options that are
 common between "git merge" and "git pull", and a couple of options
 unique to "git merge".

 Will merge to 'master'.


* jl/remote-rm-prune (2014-05-27) 3 commits
  (merged to 'next' on 2014-06-06 at d3bde27)
 + remote prune: optimize "dangling symref" check/warning
 + remote: repack packed-refs once when deleting multiple refs
 + remote rm: delete remote configuration as the last

 "git remote rm" and "git remote prune" can involve removing many
 refs at once, which is not a very efficient thing to do when very
 many refs exist in the packed-refs file.

 Will merge to 'master'.


* jm/instaweb-apache-24 (2014-05-27) 1 commit
  (merged to 'next' on 2014-06-06 at ab6e494)
 + git-instaweb: add support for Apache 2.4

 Will merge to 'master'.


* jm/t9138-style-fix (2014-05-27) 1 commit
  (merged to 'next' on 2014-06-06 at 552098b)
 + t9138-git-svn-authors-prog.sh fixups

 Will merge to 'master'.


* nd/daemonize-gc (2014-05-27) 1 commit
  (merged to 'next' on 2014-06-06 at 638c6ca)
 + gc --auto: do not lock refs in the background

 "git gc --auto" was recently changed to run in the background to
 give control back early to the end-user sitting in front of the
 terminal, but it forgot that housekeeping involving reflogs should
 be done without other processes competing for accesses to the refs.

 Will merge to 'master'.


* ow/config-mailmap-pathname (2014-05-27) 1 commit
  (merged to 'next' on 2014-06-06 at a686803)
 + config: respect '~' and '~user' in mailmap.file

 mailmap.file configuration names a pathname, hence should honor
 ~/path and ~user/path as its value.

 Will merge to 'master'.


* rh/prompt-tests (2014-06-05) 11 commits
 - t9904: new __git_ps1 tests for Zsh
 - test-lib: make it possible to override how test code is eval'd
 - lib-prompt-tests.sh: add variable for string that encodes percent in PS1
 - lib-prompt-tests.sh: put all tests inside a function
 - t9903: move prompt tests to a new lib-prompt-tests.sh file
 - t9903: move PS1 color code variable definitions to lib-bash.sh
 - t9903: include "Bash" in test names via new $shellname var
 - t9903: run pc mode tests again with PS1 expansion disabled
 - t9903: move test name prefix to a separate variable
 - t9903: put the Bash pc mode prompt test cases in a function
 - t9903: remove Zsh test from the suite of Bash prompt tests

 Maybe a reroll to limit the damage to test_eval_ is coming?


* jm/doc-wording-tweaks (2014-05-28) 1 commit
  (merged to 'next' on 2014-06-06 at 4dca23e)
 + Documentation: wording fixes in the user manual and glossary

 Will merge to 'master'.


* jn/gitweb-utf8-in-links (2014-05-27) 1 commit
 - gitweb: Harden UTF-8 handling in generated links

 $gmane/250758?


* mn/sideband-no-ansi (2014-06-02) 1 commit
  (merged to 'next' on 2014-06-06 at f61fc73)
 + sideband.c: do not use ANSI control sequence on non-terminal

 Will merge to 'master'.


* jc/fetch-push-refmap (2014-06-05) 9 commits
 - fetch: allow explicit --refmap to override configuration
 - fetch doc: add a section on configured remote-tracking branches
 - fetch doc: remove "short-cut" section
 - fetch doc: update refspec format description
 - fetch doc: on pulling multiple refspecs
 - fetch doc: remove notes on outdated "mixed layout"
 - fetch doc: update note on '+' in front of the refspec
 - fetch doc: move FETCH_HEAD material lower and add an example
 - fetch doc: update introductory part for clarity

 Will merge to 'next'.


* jc/shortlog-ref-exclude (2014-06-04) 1 commit
  (merged to 'next' on 2014-06-06 at a358cbe)
 + shortlog: allow --exclude=<glob> to be passed

 Will merge to 'master'.


* lt/log-auto-decorate (2014-05-30) 1 commit
  (merged to 'next' on 2014-06-06 at d451fc1)
 + git log: support "auto" decorations

 Will merge to 'master'.


* lt/request-pull (2014-06-02) 1 commit
  (merged to 'next' on 2014-06-06 at ad4d79d)
 + fix brown paper bag breakage in t5150-request-pull.sh

 Will merge to 'master'.


* na/no-http-test-in-the-middle (2014-05-30) 1 commit
  (merged to 'next' on 2014-06-06 at e195615)
 + t5538: move http push tests out to t5542

 Will merge to 'master'.


* pb/trim-trailing-spaces (2014-06-02) 1 commit
  (merged to 'next' on 2014-06-06 at 741efc2)
 + dir.c:trim_trailing_spaces(): fix for " \ " sequence

 Fix an error in parsing of .gitignore files that use a trailing
 "\ " to mark pathnames that end with a SP.

 Will merge to 'master'.


* rs/mailinfo-header-cmp (2014-06-02) 1 commit
  (merged to 'next' on 2014-06-06 at 5e856f4)
 + mailinfo: use strcmp() for string comparison

 Avoid running over the end of header string while parsing an
 incoming e-mail message to extract the patch.

 Will merge to 'master'.


* rs/pack-objects-no-unnecessary-realloc (2014-06-02) 1 commit
  (merged to 'next' on 2014-06-06 at a39f7ad)
 + pack-objects: use free()+xcalloc() instead of xrealloc()+memset()

 Avoid unnecessary copy of previous contents when extending the
 hashtable used in pack-objects.

 Will merge to 'master'.


* ss/userdiff-update-csharp-java (2014-06-02) 2 commits
 - userdiff: support Java try keyword
 - userdiff: support C# async methods and correct C# keywords


* jk/error-resolve-conflict-advice (2014-06-03) 2 commits
  (merged to 'next' on 2014-06-06 at f2e7bbf)
 + error_resolve_conflict: drop quotations around operation
 + error_resolve_conflict: rewrap advice message

 Will merge to 'master'.


* rs/read-ref-at (2014-06-03) 1 commit
  (merged to 'next' on 2014-06-06 at 30f9896)
 + refs.c: change read_ref_at to use the reflog iterators

 Will merge to 'master'.


* sh/enable-preloadindex (2014-06-03) 1 commit
  (merged to 'next' on 2014-06-06 at 0f0d7da)
 + environment.c: enable core.preloadindex by default

 Will merge to 'master'.


* ta/string-list-init (2014-06-06) 1 commit
  (merged to 'next' on 2014-06-06 at f0f2abc)
 + string-list: spell all values out that are given to a string_list initializer

 Will merge to 'master'.


* jk/daemon-tolower (2014-05-23) 1 commit
  (merged to 'next' on 2014-05-23 at 23c796d)
 + daemon/config: factor out duplicate xstrdup_tolower

 Will merge to 'master'.


* jk/strbuf-tolower (2014-05-23) 1 commit
  (merged to 'next' on 2014-05-23 at b172137)
 + strbuf: add strbuf_tolower function

 Will merge to 'master'.


* jk/http-errors (2014-05-27) 8 commits
  (merged to 'next' on 2014-06-06 at 1004dae)
 + http: default text charset to iso-8859-1
 + remote-curl: reencode http error messages
 + strbuf: add strbuf_reencode helper
 + http: optionally extract charset parameter from content-type
 + http: extract type/subtype portion of content-type
 + t5550: test display of remote http error messages
 + t/lib-httpd: use write_script to copy CGI scripts
 + test-lib: preserve GIT_CURL_VERBOSE from the environment

 Propagate the error messages from the webserver better to the
 client coming over the HTTP transport.

 Will merge to 'master'.


* jm/format-patch-mail-sig (2014-05-27) 2 commits
  (merged to 'next' on 2014-06-06 at 0c8d703)
 + format-patch: add "--signature-file=<file>" option
 + format-patch: make newline after signature conditional

 Will merge to 'master'.


* sk/wincred (2014-05-14) 2 commits
  (merged to 'next' on 2014-05-21 at a3b9ca3)
 + wincred: avoid overwriting configured variables
 + wincred: add install target

 Will merge to 'master'.


* as/pretty-truncate (2014-05-21) 5 commits
  (merged to 'next' on 2014-05-23 at 94d4c51)
 + pretty.c: format string with truncate respects logOutputEncoding
 + t4205, t6006: add tests that fail with i18n.logOutputEncoding set
 + t4205 (log-pretty-format): use `tformat` rather than `format`
 + t4041, t4205, t6006, t7102: don't hardcode tested encoding value
 + t4205 (log-pretty-formats): don't hardcode SHA-1 in expected outputs

 Will merge to 'master'.


* cc/replace-graft (2014-06-05) 4 commits
 - contrib: add convert-grafts-to-replace-refs.sh
 - Documentation: replace: add --graft option
 - replace: add test for --graft
 - replace: add --graft option
 (this branch uses cc/replace-edit.)


* jk/argv-array-for-child-process (2014-05-15) 7 commits
  (merged to 'next' on 2014-05-21 at 5b2fa64)
 + argv-array: drop "detach" code
 + get_importer: use run-command's internal argv_array
 + get_exporter: use argv_array
 + get_helper: use run-command's internal argv_array
 + git_connect: use argv_array
 + run_column_filter: use argv_array
 + run-command: store an optional argv_array

 Will merge to 'master'.


* jk/diff-files-assume-unchanged (2014-05-15) 1 commit
  (merged to 'next' on 2014-05-21 at 142d2c8)
 + run_diff_files: do not look at uninitialized stat data

 Will merge to 'master'.


* jk/report-fail-to-read-objects-better (2014-05-15) 1 commit
  (merged to 'next' on 2014-05-21 at 77c89fe)
 + open_sha1_file: report "most interesting" errno

 Will merge to 'master'.


* rr/rebase-autostash-fix (2014-05-20) 2 commits
  (merged to 'next' on 2014-05-21 at ca4aa40)
 + rebase -i: test "Nothing to do" case with autostash
 + rebase -i: handle "Nothing to do" case with autostash

 Will merge to 'master'.


* sk/windows-unc-path (2014-05-20) 1 commit
  (merged to 'next' on 2014-05-21 at d1f1350)
 + Windows: Allow using UNC path for git repository

 Will merge to 'master'.


* jk/diff-follow-must-take-one-pathspec (2014-05-20) 1 commit
  (merged to 'next' on 2014-05-23 at 4653133)
 + move "--follow needs one pathspec" rule to diff_setup_done

 Will merge to 'master'.


* ab/add-interactive-show-diff-func-name (2014-05-12) 2 commits
 - SQUASH??? git-add--interactive: Preserve diff heading when splitting hunks
 - git-add--interactive: Preserve diff heading when splitting hunks

 Waiting for a reroll.


* jk/do-not-run-httpd-tests-as-root (2014-05-12) 1 commit
  (merged to 'next' on 2014-05-21 at 676392b)
 + t/lib-httpd: require SANITY prereq

 Will merge to 'master'.


* cb/byte-order (2014-05-30) 3 commits
  (merged to 'next' on 2014-05-30 at 857617e)
 + compat/bswap.h: fix endianness detection
  (merged to 'next' on 2014-05-07 at f55c040)
 + compat/bswap.h: restore preference __BIG_ENDIAN over BIG_ENDIAN
 + compat/bswap.h: detect endianness on more platforms that don't use BYTE_ORDER

 Compatibility enhancement for Solaris.

 Will merge to 'master'.


* cc/replace-edit (2014-05-19) 10 commits
  (merged to 'next' on 2014-05-19 at fcdd83f)
 + Documentation: replace: describe new --edit option
 + replace: add --edit to usage string
 + replace: add tests for --edit
 + replace: die early if replace ref already exists
 + replace: refactor checking ref validity
 + replace: make sure --edit results in a different object
  (merged to 'next' on 2014-05-12 at 71449bf)
 + replace: add --edit option
 + replace: factor object resolution out of replace_object
 + replace: use OPT_CMDMODE to handle modes
 + replace: refactor command-mode determination
 (this branch is used by cc/replace-graft.)

 "git replace" learns a new "--edit" option.

 Will merge to 'master'.


* mt/send-email-cover-to-cc (2014-06-04) 3 commits
  (merged to 'next' on 2014-06-06 at 583f5fc)
 + t9001: avoid non-portable '\n' with sed
  (merged to 'next' on 2014-05-12 at b696006)
 + test/send-email: to-cover, cc-cover tests
 + git-send-email: two new options: to-cover, cc-cover

 Will merge to 'master'.


* nd/split-index (2014-06-02) 34 commits
 - fixup! read-cache: new API write_locked_index instead of write_index/write_cache
 - SQUASH???
 - t1700: new tests for split-index mode
 - t2104: make sure split index mode is off for the version test
 - read-cache: force split index mode with GIT_TEST_SPLIT_INDEX
 - read-tree: note about dropping split-index mode or index version
 - read-tree: force split-index mode off on --index-output
 - rev-parse: add --shared-index-path to get shared index path
 - update-index --split-index: do not split if $GIT_DIR is read only
 - update-index: new options to enable/disable split index mode
 - split-index: strip pathname of on-disk replaced entries
 - split-index: do not invalidate cache-tree at read time
 - split-index: the reading part
 - split-index: the writing part
 - read-cache: mark updated entries for split index
 - read-cache: save deleted entries in split index
 - read-cache: mark new entries for split index
 - read-cache: split-index mode
 - read-cache: save index SHA-1 after reading
 - entry.c: update cache_changed if refresh_cache is set in checkout_entry()
 - cache-tree: mark istate->cache_changed on prime_cache_tree()
 - cache-tree: mark istate->cache_changed on cache tree update
 - cache-tree: mark istate->cache_changed on cache tree invalidation
 - unpack-trees: be specific what part of the index has changed
 - resolve-undo: be specific what part of the index has changed
 - update-index: be specific what part of the index has changed
 - read-cache: be specific what part of the index has changed
 - read-cache: be strict about "changed" in remove_marked_cache_entries()
 - read-cache: store in-memory flags in the first 12 bits of ce_flags
 - read-cache: relocate and unexport commit_locked_index()
 - read-cache: new API write_locked_index instead of write_index/write_cache
 - sequencer: do not update/refresh index if the lock cannot be held
 - ewah: delete unused ewah_read_mmap_native declaration
 - ewah: fix constness of ewah_read_mmap

 The tip two remind us the need for a minor reroll.  If I find time
 I could try to squash them myself, but it is low priority for me.


* ib/test-selectively-run (2014-06-06) 4 commits
  (merged to 'next' on 2014-06-06 at d894205)
 + t0000-*.sh: fix the GIT_SKIP_TESTS sub-tests
 + test-lib: '--run' to run only specific tests
 + test-lib: tests skipped by GIT_SKIP_TESTS say so
 + test-lib: document short options in t/README

 Allow specifying only certain individual test pieces to be run
 using a range notation (e.g. "t1234-test.sh --run='1-4 6 8 9-'").

 Will merge to 'master'.


* fc/remote-helper-refmap (2014-04-21) 8 commits
  (merged to 'next' on 2014-04-22 at fb5a4c2)
 + transport-helper: remove unnecessary strbuf resets
 + transport-helper: add support to delete branches
 + fast-export: add support to delete refs
 + fast-import: add support to delete refs
 + transport-helper: add support to push symbolic refs
 + transport-helper: add support for old:new refspec
 + fast-export: add new --refspec option
 + fast-export: improve argument parsing

 Allow remote-helper/fast-import based transport to rename the refs
 while transferring the history.


* jh/submodule-tests (2014-04-17) 1 commit
 - t7410: 210 tests for various 'git submodule update' scenarios

 What's the status of this one?


* mt/patch-id-stable (2014-05-06) 6 commits
  (merged to 'next' on 2014-05-07 at 6ade68e)
 + test doc: test_write_lines does not split its arguments
  (merged to 'next' on 2014-05-02 at cfa251b)
 + t4204-patch-id.sh: default is now stable
 + patch-id: change default to stable
  (merged to 'next' on 2014-05-02 at b69326a)
 + patch-id-test: test stable and unstable behaviour
 + test: add test_write_lines helper
 + patch-id: make it stable against hunk reordering

 Introduce a new way to compute patch-id for a patch that is not
 affected by the order of the paths that appear in the input.

 Will merge to 'master'.


* cc/interpret-trailers (2014-05-28) 11 commits
 - Documentation: add documentation for 'git interpret-trailers'
 - trailer: add tests for commands in config file
 - trailer: execute command from 'trailer.<name>.command'
 - trailer: add tests for "git interpret-trailers"
 - trailer: add interpret-trailers command
 - trailer: put all the processing together and print
 - trailer: parse trailers from file or stdin
 - trailer: process command line trailer arguments
 - trailer: read and process config information
 - trailer: process trailers from input message and arguments
 - trailer: add data structures and basic functions

 A new filter to programatically edit the tail end of the commit log
 messages.
