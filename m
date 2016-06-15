From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Mar 2014, #08; Mon, 31)
Date: Mon, 31 Mar 2014 17:29:03 -0700
Message-ID: <xmqqppl128q8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 01 02:29:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUmZq-0004B1-2W
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 02:29:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbaDAA3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 20:29:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64807 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751098AbaDAA3K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 20:29:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DFD8F7959A;
	Mon, 31 Mar 2014 20:29:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=0
	d+yzryHEB4LcvyHuN9Fyn8/b0Y=; b=Ylhj7wuyTVq0GfzYLfEhKva/PrIO+a5yt
	AFFrduekzaG5CTsY3dVQUDX1md/E7yLbrphbsGrrTiwQoHH2qFHDezgLwzJMouT8
	eFFa9csBnGZR4n7O6xYrU+618dd3ii91ehCyI1Jlbj24HffWge9faPPgUiWkBSAj
	A+VG5LIFuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=UJS
	lRqJbI/mjLeKewk64jUSfvoXCsOUdMIphKFb5FzO1vjXV0c4TVcYO67/BQdWqd84
	5qc2C+jnhMW9P+CCH1Lqh0JWEA/UuFRwp4XBQIfKmt6YbH9/ROoSHIHpsJOAEieL
	ZpKafvtOZo3rysIgXjOomE5glY9iv94/ZZHozxfg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CBC7979599;
	Mon, 31 Mar 2014 20:29:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D08AB7958C;
	Mon, 31 Mar 2014 20:29:05 -0400 (EDT)
X-master-at: 25d1ac0e59f4471c3b124a0c19cad9f9511a26ad
X-next-at: 875d83ee45ac54ebd34015807b9d6c3817e4b249
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A2009608-B934-11E3-8E41-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245569>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

More topics merged to 'master', some of which are fallouts from GSoC
microprojects, some are updates to docs.  C/C++ funcname pattern
update is now in.

I haven't reverted the merge of that "submodule update" topic yet; I
should do that soonish.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* an/branch-config-message (2014-03-24) 1 commit
  (merged to 'next' on 2014-03-26 at 26f9741)
 + branch.c: install_branch_config: simplify if chain


* ca/doc-config-third-party (2014-03-21) 1 commit
  (merged to 'next' on 2014-03-25 at 731e011)
 + config.txt: third-party tools may and do use their own variables


* dp/makefile-charset-lib-doc (2014-03-23) 1 commit
  (merged to 'next' on 2014-03-25 at b32e3ad)
 + Makefile: describe CHARSET_LIB better


* dt/tests-with-env-not-subshell (2014-03-19) 1 commit
  (merged to 'next' on 2014-03-25 at 19fe25f)
 + tests: use "env" to run commands with temporary env-var settings
 (this branch is used by jk/tests-cleanup.)


* dw/doc-status-no-longer-shows-pound-prefix (2014-03-21) 1 commit
  (merged to 'next' on 2014-03-25 at 2683eb6)
 + doc: status, remove leftover statement about '#' prefix


* hs/simplify-bit-setting-in-fsck-tree (2014-03-20) 1 commit
  (merged to 'next' on 2014-03-25 at 08efd68)
 + fsck: use bitwise-or assignment operator to set flag


* ib/rev-parse-parseopt-argh (2014-03-23) 2 commits
  (merged to 'next' on 2014-03-25 at d9083ed)
 + t1502: protect runs of SPs used in the indentation
 + rev-parse --parseopt: option argument name hints
 (this branch is used by jc/rev-parse-argh-dashed-multi-words.)

 Teaches the "rev-parse --parseopt" mechanism used by scripted
 Porcelains to parse command line options and give help text how to
 supply argv-help (the placeholder string for an option parameter,
 e.g. "key-id" in "--gpg-sign=<key-id>").


* jk/tests-cleanup (2014-03-21) 12 commits
  (merged to 'next' on 2014-03-26 at 4a72b49)
 + t0001: drop subshells just for "cd"
 + t0001: drop useless subshells
 + t0001: use test_must_fail
 + t0001: use test_config_global
 + t0001: use test_path_is_*
 + t0001: make symlink reinit test more careful
 + t: prefer "git config --file" to GIT_CONFIG
 + t: prefer "git config --file" to GIT_CONFIG with test_must_fail
 + t: stop using GIT_CONFIG to cross repo boundaries
 + t: drop useless sane_unset GIT_* calls
 + t/test-lib: drop redundant unset of GIT_CONFIG
 + t/Makefile: stop setting GIT_CONFIG
 (this branch uses dt/tests-with-env-not-subshell.)


* js/userdiff-cc (2014-03-21) 10 commits
  (merged to 'next' on 2014-03-25 at 8c0e585)
 + userdiff: have 'cpp' hunk header pattern catch more C++ anchor points
 + t4018: test cases showing that the cpp pattern misses many anchor points
 + t4018: test cases for the built-in cpp pattern
 + t4018: reduce test files for pattern compilation tests
 + t4018: convert custom pattern test to the new infrastructure
 + t4018: convert java pattern test to the new infrastructure
 + t4018: convert perl pattern tests to the new infrastructure
 + t4018: an infrastructure to test hunk headers
 + userdiff: support unsigned and long long suffixes of integer constants
 + userdiff: support C++ ->* and .* operators in the word regexp

 Improves the pattern to match the hunk-header for C/C++.


* mm/status-porcelain-format-i18n-fix (2014-03-26) 1 commit
  (merged to 'next' on 2014-03-26 at 41680fc)
 + status: disable translation when --porcelain is used


* mr/msvc-link-with-lcurl (2014-03-27) 1 commit
  (merged to 'next' on 2014-03-28 at 3281dab)
 + MSVC: allow linking with the cURL library


* wt/doc-submodule-name-path-confusion-1 (2014-03-27) 1 commit
  (merged to 'next' on 2014-03-28 at 225f241)
 + doc: submodule.* config are keyed by submodule names


* wt/doc-submodule-name-path-confusion-2 (2014-03-27) 1 commit
  (merged to 'next' on 2014-03-28 at ec5bcf3)
 + doc: submodule.*.branch config is keyed by name

--------------------------------------------------
[New Topics]

* cb/aix (2014-03-31) 2 commits
 - tests: don't rely on strerror text when testing rmdir failure
 - dir.c: make git_fnmatch() not inline

 Will merge to 'next'.


* jc/fix-diff-no-index-diff-opt-parse (2014-03-31) 1 commit
 - diff-no-index: correctly diagnose error return from diff_opt_parse()

 "diff --no-index -Mq a b" fell into an infinite loop.

 Will merge to 'next'.


* mr/opt-set-ptr (2014-03-31) 3 commits
 - parse-options: remove unused OPT_SET_PTR
 - parse-options: add cast to correct pointer type to OPT_SET_PTR
 - MSVC: fix t0040-parse-options crash

 OPT_SET_PTR() implementation was broken on IL32P64 platforms.

 We may just want directly to go to the endgame of removing
 OPT_SET_PTR macro, which nobody seems to use.


* mt/patch-id-stable (2014-03-31) 3 commits
 - patch-id-test: test --stable and --unstable flags
 - patch-id: document new behaviour
 - patch-id: make it stable against hunk reordering

 Introduce a new way to compute patch-id for a patch that is not
 affected by the order of the paths that appear in the input.


* jl/nor-or-nand-and (2014-03-31) 4 commits
 - code and test: fix misuses of "nor"
 - comments: fix misuses of "nor"
 - contrib: fix misuses of "nor"
 - Documentation: fix misuses of "nor"

 Eradicate mistaken use of "nor" (that is, essentially "nor" used
 not in "neither A nor B" ;-)) from in-code comments, command output
 strings, and documentations.


* mh/ref-transaction (2014-03-31) 27 commits
 - ref_transaction_commit(): work with transaction->updates in place
 - struct ref_update: add type field
 - struct ref_update: add a lock member
 - ref_transaction_commit(): simplify expressions
 - struct ref_update: store refname as a FLEX_ARRAY
 - struct ref_update: rename field "ref_name" to "refname"
 - refs: remove API function update_refs()
 - update-ref --stdin: reimplement using reference transactions
 - refs: add a concept of a reference transaction
 - update-ref --stdin: harmonize error messages
 - update-ref --stdin: improve the error message for unexpected EOF
 - t1400: test one breakage at a time
 - update-ref --stdin -z: deprecate interpreting the empty string as zeros
 - update-ref.c: extract a new function, parse_next_sha1()
 - t1400: test that stdin -z update treats empty <newvalue> as zeros
 - update-ref --stdin: simplify error messages for missing oldvalues
 - update-ref --stdin: make error messages more consistent
 - update-ref --stdin: improve error messages for invalid values
 - update-ref.c: extract a new function, parse_refname()
 - parse_cmd_verify(): copy old_sha1 instead of evaluating <oldvalue> twice
 - update-ref --stdin: read the whole input at once
 - update_refs(): tighten constness
 - refs.h: rename the action_on_err constants
 - t1400: add some more tests involving quoted arguments
 - parse_arg(): really test that argument is properly terminated
 - t1400: provide more usual input to the command
 - t1400: fix test name and expected result of one test

 Update "update-ref --stdin [-z]" and then introduce a transactional
 support for (multi-)reference updates.

 I think the earlier part should be merged to 'next' soonish in
 order to keep the topic that is still in flux reasonably short.  I
 haven't read the "transaction" part carefully yet.


--------------------------------------------------
[Stalled]

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

 RFC.  This latest round clashes with the kb/fast-hashmap topic in
 'master'.


* sz/mingw-index-pack-threaded (2014-03-19) 1 commit
 - Enable index-pack threading in msysgit.

 Still under discussion among Windows folks.  A failure report
 exists ($gmane/245170).


* bc/blame-crlf-test (2014-02-18) 1 commit
 - blame: add a failing test for a CRLF issue.

 I have a feeling that a fix for this should be fairly isolated and
 trivial (it should be just the matter of paying attention to the
 crlf settings when synthesizing the fake commit)---perhaps somebody
 can squash in a fix to this?


* jk/makefile (2014-02-05) 16 commits
 - FIXUP
 - move LESS/LV pager environment to Makefile
 - Makefile: teach scripts to include make variables
 - FIXUP
 - Makefile: auto-build C strings from make variables
 - Makefile: drop *_SQ variables
 - FIXUP
 - Makefile: add c-quote helper function
 - Makefile: introduce sq function for shell-quoting
 - Makefile: always create files via make-var
 - Makefile: store GIT-* sentinel files in MAKE/
 - Makefile: prefer printf to echo for GIT-*
 - Makefile: use tempfile/mv strategy for GIT-*
 - Makefile: introduce make-var helper function
 - Makefile: fix git-instaweb dependency on gitweb
 - Makefile: drop USE_GETTEXT_SCHEME from GIT-CFLAGS

 Simplify the Makefile rules and macros that exist primarily for
 quoting purposes, and make it easier to robustly express the
 dependency rules.

 Expecting a reroll.


* kb/fast-hashmap-pack-struct (2014-02-24) 1 commit
 - hashmap.h: make sure map entries are tightly packed

 Will discard.


* po/everyday-doc (2014-01-27) 1 commit
 - Make 'git help everyday' work

 This may make the said command to emit something, but the source is
 not meant to be formatted into a manual pages to begin with, and
 also its contents are a bit stale.  It may be a good first step in
 the right direction, but needs more work to at least get the
 mark-up right before public consumption.

 Will hold.


* jk/branch-at-publish-rebased (2014-01-17) 5 commits
 - t1507 (rev-parse-upstream): fix typo in test title
 - implement @{publish} shorthand
 - branch_get: provide per-branch pushremote pointers
 - branch_get: return early on error
 - sha1_name: refactor upstream_mark

 Give an easier access to the tracking branches from "other" side in
 a triangular workflow by introducing B@{publish} that works in a
 similar way to how B@{upstream} does.

 Meant to be used as a basis for whatever Ram wants to build on.

 Will hold.


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

 Expecting a reroll.


* jc/graph-post-root-gap (2013-12-30) 3 commits
 - WIP: document what we want at the end
 - graph: remove unused code a bit
 - graph: stuff the current commit into graph->columns[]

 This was primarily a RFH ($gmane/239580).


* hv/submodule-ignore-fix (2013-12-06) 4 commits
 - disable complete ignorance of submodules for index <-> HEAD diff
 - always show committed submodules in summary after commit
 - teach add -f option for ignored submodules
 - fix 'git add' to skip submodules configured as ignored

 Teach "git add" to be consistent with "git status" when changes to
 submodules are set to be ignored, to avoid surprises after checking
 with "git status" to see there isn't any change to be further added
 and then see that "git add ." adds changes to them.

 I think a reroll is coming, so this may need to be replaced, but I
 needed some practice with heavy conflict resolution.  It conflicts
 with two changes to "git add" that have been scheduled for Git 2.0
 quite badly, and I think I got the resolution right this time.

 Waiting for a reroll.


* np/pack-v4 (2013-09-18) 90 commits
 . packv4-parse.c: add tree offset caching
 . t1050: replace one instance of show-index with verify-pack
 . index-pack, pack-objects: allow creating .idx v2 with .pack v4
 . unpack-objects: decode v4 trees
 . unpack-objects: allow to save processed bytes to a buffer
 - ...

 Nico and Duy advancing the eternal vaporware pack-v4.  This is here
 primarily for wider distribution of the preview edition.

 Temporarily ejected from 'pu', to try out jk/pack-bitmap, which
 this topic conflicts with.


* tg/perf-lib-test-perf-cleanup (2013-09-19) 2 commits
 - perf-lib: add test_perf_cleanup target
 - perf-lib: split starting the test from the execution

 Add test_perf_cleanup shell function to the perf suite, that allows
 the script writers to define a test with a clean-up action.

 Will hold.


* jc/format-patch (2013-04-22) 2 commits
 - format-patch: --inline-single
 - format-patch: rename "no_inline" field

 A new option to send a single patch to the standard output to be
 appended at the bottom of a message.  I personally have no need for
 this, but it was easy enough to cobble together.  Tests, docs and
 stripping out more MIMEy stuff are left as exercises to interested
 parties.


* jc/show-branch (2014-03-24) 5 commits
 - show-branch: use commit slab to represent bitflags of arbitrary width
 - show-branch.c: remove "all_mask"
 - show-branch.c: abstract out "flags" operation
 - show-branch.c: lift all_mask/all_revs to a global static
 - show-branch.c: update comment style

 Waiting for the final step to lift the hard-limit before sending it out.

--------------------------------------------------
[Cooking]

* jc/apply-ignore-whitespace (2014-03-26) 1 commit
 - apply --ignore-space-change: lines with and without leading whitespaces do not match

 An RFC.  "--ignore-space-change" option of "git apply" ignored the
 spaces at the beginning of line too aggressively, which is
 inconsistent with the option of the same name "diff" and "git diff"
 have.

 Will hold.


* jc/rev-parse-argh-dashed-multi-words (2014-03-24) 3 commits
  (merged to 'next' on 2014-03-31 at 1c48649)
 + parse-options: make sure argh string does not have SP or _
 + update-index: teach --cacheinfo a new syntax "mode,sha1,path"
 + parse-options: multi-word argh should use dash to separate words

 Make sure that the help text given to describe the "<param>" part
 of the "git cmd --option=<param>" does not contain SP or _,
 e.g. "--gpg-sign=<key-id>" option for "git commit" is not spelled
 as "--gpg-sign=<key id>".

 Will merge to 'master'.


* jk/commit-dates-parsing-fix (2014-03-26) 1 commit
 - t4212: loosen far-in-future test for AIX

 I think we agreed that a simpler test would be a better way
 forward.


* mr/msvc-link-with-invalidcontinue (2014-03-28) 1 commit
  (merged to 'next' on 2014-03-31 at 051a29e)
 + MSVC: link in invalidcontinue.obj for better POSIX compatibility

 Will merge to 'master'.


* ep/shell-command-substitution (2014-03-25) 2 commits
  (merged to 'next' on 2014-03-28 at 99a512a)
 + git-am.sh: use the $(...) construct for command substitution
 + check-builtins.sh: use the $(...) construct for command substitution

 Will merge to 'master'.


* rs/pickaxe-i (2014-03-24) 10 commits
  (merged to 'next' on 2014-03-25 at 3b6f21f)
 + pickaxe: simplify kwset loop in contains()
 + pickaxe: call strlen only when necessary in diffcore_pickaxe_count()
 + pickaxe: move pickaxe() after pickaxe_match()
 + pickaxe: merge diffcore_pickaxe_grep() and diffcore_pickaxe_count() into diffcore_pickaxe()
 + pickaxe: honor -i when used with -S and --pickaxe-regex
 + t4209: use helper functions to test --author
 + t4209: use helper functions to test --grep
 + t4209: factor out helper function test_log_icase()
 + t4209: factor out helper function test_log()
 + t4209: set up expectations up front

 Allow the options -i/--regexp-ignore-case, --pickaxe-regex, and -S
 to be used together and work as expected to perform a pickaxe
 search using case-insensitive regular expression matching.

 Will merge to 'master'.


* as/grep-fullname-config (2014-03-20) 1 commit
  (merged to 'next' on 2014-03-28 at 810a076)
 + grep: add grep.fullName config variable

 Add a configuration variable to force --full-name to be default for
 "git grep".

 This may cause regressions on scripted users that do not expect
 this new behaviour.

 Will hold.


* nd/gc-aggressive (2014-03-31) 2 commits
 - environment.c: fix constness for odb_pack_keep()
 - gc --aggressive: make --depth configurable

 Allow tweaking the maximum length of the delta-chain produced by
 "gc --aggressive".

 Will merge to 'next'.


* ap/remote-hg-skip-null-bookmarks (2014-03-25) 1 commit
  (merged to 'next' on 2014-03-25 at a8cd922)
 + remote-hg: do not fail on invalid bookmarks

 Will merge to 'master'.


* cn/fetch-prune-overlapping-destination (2014-03-26) 2 commits
  (merged to 'next' on 2014-03-28 at 954513a)
 + fetch: handle overlaping refspecs on --prune
 + fetch: add a failing test for prunning with overlapping refspecs

 Protect refs in a hierarchy that can come from more than one remote
 hierarcies from incorrect removal by "git fetch --prune".

 Since I didn't get any responses to my earlier "Comments?", I ended
 up reading it myself again and found a small leak, whose fix has
 been squashed in to the tip commit.

 Will merge to 'master'.


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

 What is the doneness of this thing?  I remember reading it through
 once and sent review comments on earlier parts, but have there been
 a lot of discussions on this topic?


* ks/tree-diff-nway (2014-03-27) 19 commits
 - combine-diff: speed it up, by using multiparent diff tree-walker directly
 - tree-diff: rework diff_tree() to generate diffs for multiparent cases as well
 - Portable alloca for Git
  (merged to 'next' on 2014-03-31 at 16a7bd4)
 + tree-diff: reuse base str(buf) memory on sub-tree recursion
 + tree-diff: no need to call "full" diff_tree_sha1 from show_path()
 + tree-diff: rework diff_tree interface to be sha1 based
 + tree-diff: diff_tree() should now be static
 + tree-diff: remove special-case diff-emitting code for empty-tree cases
  (merged to 'next' on 2014-03-25 at cfcbdac)
 + tree-diff: simplify tree_entry_pathcmp
 + tree-diff: show_path prototype is not needed anymore
 + tree-diff: rename compare_tree_entry -> tree_entry_pathcmp
 + tree-diff: move all action-taking code out of compare_tree_entry()
 + tree-diff: don't assume compare_tree_entry() returns -1,0,1
  (merged to 'next' on 2014-03-21 at d872679)
 + tree-diff: consolidate code for emitting diffs and recursion in one place
 + tree-diff: show_tree() is not needed
 + tree-diff: no need to pass match to skip_uninteresting()
 + tree-diff: no need to manually verify that there is no mode change for a path
 + combine-diff: move changed-paths scanning logic into its own function
 + combine-diff: move show_log_first logic/action out of paths scanning

 Instead of running N pair-wise diff-trees when inspecting a
 N-parent merge, find the set of paths that were touched by walking
 N+1 trees in parallel.  These set of paths can then be turned into
 N pair-wise diff-tree results to be processed through rename
 detections and such.  And N=2 case nicely degenerates to the usual
 2-way diff-tree, which is very nice.

 The preparatory steps are all in 'next'.  The real fun part should
 follow soonish (hopefully).


* nd/log-show-linear-break (2014-03-25) 2 commits
  (merged to 'next' on 2014-03-28 at ea4a8db)
 + log: add --show-linear-break to help see non-linear history
 + object.h: centralize object flag allocation

 Attempts to show where a single-strand-of-pearls break in "git log"
 output.

 Will merge to 'master'.


* cc/interpret-trailers (2014-03-26) 12 commits
 - trailers: add documentation for 'git interpret-trailers'
 - trailer: add tests for commands in config file
 - trailer: execute command from 'trailer.<name>.command'
 - trailer: add tests for "git interpret-trailers"
 - trailer: add interpret-trailers command
 - trailer: put all the processing together and print
 - trailer: parse trailers from stdin
 - trailer: process command line trailer arguments
 - trailer: read and process config information
 - Move lower case functions into wrapper.c
 - trailer: process trailers from stdin and arguments
 - trailers: add data structures and basic functions

 A new filter to programatically edit the tail end of the commit log
 messages.
