From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Sep 2010, #01; Wed, 1)
Date: Wed, 01 Sep 2010 12:51:25 -0700
Message-ID: <7vaao15jk2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 01 21:51:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqtLb-0001Zs-Ct
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 21:51:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755627Ab0IATvg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Sep 2010 15:51:36 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46393 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755387Ab0IATve convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Sep 2010 15:51:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D7A8CD2B27;
	Wed,  1 Sep 2010 15:51:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=0Jd+b57Z+4bmlrhsgukVozMTZ
	D8=; b=IsOMtC5p8d+ZXXk47DgRQh2GbCwcLELnpvKc9AhTqfJm/ap8qRPyBHzgp
	I3+Qm1TGsdsj5q858o41JC5yYmdS41TN+NYPjjXGo9DMvO1jguwG9c+KAr6y61fq
	uHoqoblOgYH8xbUwCwiaESuAHsDXRpi7YafdPXhQJ7TouqxaJw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=Dk2gjO9dbqeXT7p2ksX
	aB7xlNAEXWXqpiPpidiXdORn7nOGFfuE+pgrXYsMvm9Mb9i9wwSDYy85s2vhglYL
	+STwULCZqYBk8reHXaBwx5K21QtloU+n8OZaxqqJCmH+158UxFed9YaKAy40ghD6
	KgAK0hgk/HHmKkrmTdNktiXc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F3C3D2B26;
	Wed,  1 Sep 2010 15:51:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DAC54D2B1D; Wed,  1 Sep
 2010 15:51:27 -0400 (EDT)
X-master-at: 7e42332e476a6f47ccc5a62cc8b93bcb4d758f7c
X-next-at: a0aa1d989c889829c2f1571f9c7760a8b2fda6b9
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 50CDB696-B602-11DF-B00C-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155073>

Here are the topics that have been cooking.  Commits prefixed with '-' =
are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the integration branches, but I=
 am
still holding onto them.

As I didn't want to worry about the early parts of ab/i18n topic, which
was accidentally merged to 'next' due to my lazyness (another topic,
ab/test, seemed to be ready for the upcoming release, but a patch to th=
at
topic had interaction with ab/i18n, which made ab/test unmergeable to
'master' without dragging 'ab/i18n'), I reverted ab/i18n topic from 'ne=
xt'
and merged a rebuilt ab/test topic to 'next'.  The i18n topic is merged
to 'pu'.

I am hoping to tag -rc0 for the 1.7.3 release this weekend.

--------------------------------------------------
[Graduated to "master"]

* ab/maint-reset-mixed-w-pathspec-advice (2010-08-15) 1 commit
  (merged to 'next' on 2010-08-21 at b09ee46)
 + reset: suggest what to do upon "git reset --mixed <paths>"

* cb/binary-patch-id (2010-08-15) 1 commit
  (merged to 'next' on 2010-08-21 at ff38c3e)
 + hash binary sha1 into patch id

* cc/revert (2010-07-21) 5 commits
  (merged to 'next' on 2010-08-14 at a910d5a)
 + t3508: add check_head_differs_from() helper function and use it
 + revert: improve success message by adding abbreviated commit sha1
 + revert: don't print "Finished one cherry-pick." if commit failed
 + revert: refactor commit code into a new run_git_commit() function
 + revert: report success when using option --strategy
 (this branch is used by jn/cherry-revert-message-clean-up.)

* da/fix-submodule-sync-superproject-config (2010-08-18) 1 commit
  (merged to 'next' on 2010-08-21 at e96772a)
 + submodule sync: Update "submodule.<name>.url"

* dj/fetch-tagopt (2010-08-11) 1 commit
  (merged to 'next' on 2010-08-21 at 737dfec)
 + fetch: allow command line --tags to override config

* en/d-f-conflict-fix (2010-08-20) 12 commits
  (merged to 'next' on 2010-08-20 at af7f2b0)
 + merge-recursive: Avoid excessive output for and reprocessing of rena=
mes
  (merged to 'next' on 2010-08-18 at 6be0f13)
 + merge-recursive: Fix multiple file rename across D/F conflict
 + t6031: Add a testcase covering multiple renames across a D/F conflic=
t
 + merge-recursive: Fix typo
  (merged to 'next' on 2010-08-14 at 1c9b0f5)
 + Mark tests that use symlinks as needing SYMLINKS prerequisite
  (merged to 'next' on 2010-08-03 at 7f78604)
 + t/t6035-merge-dir-to-symlink.sh: Remove TODO on passing test
 + fast-import: Improve robustness when D->F changes provided in wrong =
order
 + fast-export: Fix output order of D/F changes
 + merge_recursive: Fix renames across paths below D/F conflicts
 + merge-recursive: Fix D/F conflicts
 + Add a rename + D/F conflict testcase
 + Add additional testcases for D/F conflicts

* en/fast-export-fix (2010-07-17) 2 commits
  (merged to 'next' on 2010-08-18 at 9fdaf27)
 + fast-export: Add a --full-tree option
 + fast-export: Fix dropping of files with --import-marks and path limi=
ting

* hv/autosquash-config (2010-07-14) 1 commit
  (merged to 'next' on 2010-08-18 at 03a8eec)
 + add configuration variable for --autosquash option of interactive re=
base

* jn/cherry-revert-message-clean-up (2010-08-18) 5 commits
  (merged to 'next' on 2010-08-21 at 09b123c)
 + tests: fix syntax error in "Use advise() for hints" test
 + cherry-pick/revert: Use advise() for hints
 + cherry-pick/revert: Use error() for failure message
 + Introduce advise() to print hints
 + Eliminate =E2=80=9CFinished cherry-pick/revert=E2=80=9D message
 (this branch uses cc/revert.)

* jn/maint-setup-fix (2010-07-24) 11 commits
  (merged to 'next' on 2010-08-18 at ded5f4d)
 + setup: split off a function to handle ordinary .git directories
 + Revert "rehabilitate 'git index-pack' inside the object store"
 + setup: do not forget working dir from subdir of gitdir
 + t4111 (apply): refresh index before applying patches to it
 + setup: split off get_device_or_die helper
 + setup: split off a function to handle hitting ceiling in repo search
 + setup: split off code to handle stumbling upon a repository
 + setup: split off a function to checks working dir for .git file
 + setup: split off $GIT_DIR-set case from setup_git_directory_gently
 + tests: try git apply from subdir of toplevel
 + t1501 (rev-parse): clarify
 (this branch is used by jn/paginate-fix.)

* jn/paginate-fix (2010-08-16) 14 commits
  (merged to 'next' on 2010-08-18 at bb04a13)
 + t7006 (pager): add missing TTY prerequisites
 + merge-file: run setup_git_directory_gently() sooner
 + var: run setup_git_directory_gently() sooner
 + ls-remote: run setup_git_directory_gently() sooner
 + index-pack: run setup_git_directory_gently() sooner
 + Merge branch 'jn/maint-setup-fix' (early part) into jn/paginate-fix
 + config: run setup_git_directory_gently() sooner
 + bundle: run setup_git_directory_gently() sooner
 + apply: run setup_git_directory_gently() sooner
 + grep: run setup_git_directory_gently() sooner
 + shortlog: run setup_git_directory_gently() sooner
 + git wrapper: allow setup_git_directory_gently() be called earlier
 + setup: remember whether repository was found
 + git wrapper: introduce startup_info struct
 (this branch uses jn/maint-setup-fix.)

* jn/svn-fe (2010-08-19) 17 commits
  (merged to 'next' on 2010-08-19 at b1a242a)
 + t/t9010-svn-fe.sh: add an +x bit to this test
  (merged to 'next' on 2010-08-18 at 24ab19e)
 + t9010 (svn-fe): avoid symlinks in test
 + t9010 (svn-fe): use Unix-style path in URI
 + vcs-svn: Avoid %z in format string
 + vcs-svn: Rename dirent pool to build on Windows
 + compat: add strtok_r()
 + treap: style fix
 + vcs-svn: remove build artifacts on "make clean"
 + svn-fe manual: Clarify warning about deltas in dump files
 + Update svn-fe manual
 + SVN dump parser
 + Infrastructure to write revisions in fast-export format
 + Add stream helper library
 + Add string-specific memory pool
 + Add treap implementation
 + Add memory pool library
 + Introduce vcs-svn lib

* np/maint-huge-delta-generation (2010-08-21) 1 commit
  (merged to 'next' on 2010-08-21 at 5af7003)
 + fix >4GiB source delta assertion failure

* sg/rerere-gc-old-still-used (2010-07-13) 2 commits
  (merged to 'next' on 2010-08-18 at 8bc4635)
 + rerere: fix overeager gc
 + mingw_utime(): handle NULL times parameter

* tr/maint-no-unquote-plus (2010-07-24) 1 commit
  (merged to 'next' on 2010-08-18 at b811248)
 + Do not unquote + into ' ' in URLs

I think this one is safe in the context of git (namely smart-http
interface).

--------------------------------------------------
[New Topics]

* ch/filter-branch-deprecate-remap-to-ancestor (2010-08-27) 1 commit
 - filter-branch: retire --remap-to-ancestor

* ch/maint-cannot-create-bundle-error (2010-08-27) 1 commit
 - bundle: detect if bundle file cannot be created

* rr/format-patch-count-without-merges (2010-08-28) 2 commits
 - format-patch: Don't go over merge commits
 - t4014-format-patch: Call test_tick before committing

* ab/test-2 (2010-08-30) 51 commits
  (merged to 'next' on 2010-08-31 at 9d56f47)
 + tests: factor HOME=3D$(pwd) in test-lib.sh
 + test-lib: use subshell instead of cd $new && .. && cd $old
 + tests: simplify "missing PREREQ" message
 + t/t0000-basic.sh: Run the passing TODO test inside its own test-lib
 + test-lib: Allow overriding of TEST_DIRECTORY
 + test-lib: Use "$GIT_BUILD_DIR" instead of "$TEST_DIRECTORY"/../
 + test-lib: Use $TEST_DIRECTORY or $GIT_BUILD_DIR instead of $(pwd) an=
d ../
 + test: Introduce $GIT_BUILD_DIR
  (merged to 'next' on 2010-08-18 at f88bdb1)
 + cvs tests: do not touch test CVS repositories shipped with source
 + t/t9602-cvsimport-branches-tags.sh: Add a PERL prerequisite
 + t/t9601-cvsimport-vendor-branch.sh: Add a PERL prerequisite
 + t/t7105-reset-patch.sh: Add a PERL prerequisite
 + t/t9001-send-email.sh: convert setup code to tests
 + t/t9001-send-email.sh: change from skip_all=3D* to prereq skip
 + t/t9001-send-email.sh: Remove needless PROG=3D* assignment
 + t/t9600-cvsimport.sh: change from skip_all=3D* to prereq skip
 + lib-patch-mode tests: change from skip_all=3D* to prereq skip
 + t/t3701-add-interactive.sh: change from skip_all=3D* to prereq skip
 + tests: Move FILEMODE prerequisite to lib-prereq-FILEMODE.sh
 + t/Makefile: Create test-results dir for smoke target
 + git-notes: Run partial expensive test everywhere
 + t/t3300-funny-names: change from skip_all=3D* to prereq skip
 + t/t3902-quoted: change from skip_all=3D* to prereq skip
 + t/t4016-diff-quote: change from skip_all=3D* to prereq skip
 + t/t5503-tagfollow: change from skip_all=3D* to prereq skip
 + t/t7005-editor: change from skip_all=3D* to prereq skip
 + t/t5705-clone-2gb: change from skip_all=3D* to prereq skip
 + t/t1304-default-acl: change from skip_all=3D* to prereq skip
 + t/README: Update "Skipping tests" to align with best practices
 + t/t7800-difftool.sh: Skip with prereq on no PERL
 + t/t5800-remote-helpers.sh: Skip with prereq on python <2.4
 + t/t4004-diff-rename-symlink.sh: use three-arg <prereq>
 + tests: implicitly skip SYMLINKS tests using <prereq>
 + Makefile: make gcov invocation configurable
 + t/README: Add a note about the dangers of coverage chasing
 + t/README: A new section about test coverage
 + Makefile: Add cover_db_html target
 + Makefile: Add cover_db target
 + Makefile: Split out the untested functions target
 + Makefile: Include subdirectories in "make cover" reports
 + gitignore: Ignore files generated by "make coverage"
 + t/README: Add SMOKE_{COMMENT,TAGS}=3D to smoke_report target
 + t/Makefile: Can't include GIT-BUILD-OPTIONS, it's a .sh
 + t/README: Document the Smoke testing
 + tests: Infrastructure for Git smoke testing
 + test-lib: Multi-prereq support only checked the last prereq
 + tests: A SANITY test prereq for testing if we're root
 + t/README: Document the predefined test prerequisites
 + test-lib: Print missing prerequisites in test output
 + test-lib: Add support for multiple test prerequisites
 + test-lib: Don't write test-results when HARNESS_ACTIVE
 (this branch is used by ab/test.)

As I'd like to have this in the upcoming release, the tip of old ab/tes=
t
topic has been rebuilt without the merge from ab/i18n topic.

* as/daemon-multi-listen (2010-08-29) 2 commits
 - daemon: allow more than one host address given via --listen
 - daemon: add helper function setup_named_sock()

I think the idea is sound.  It came a bit late in the cycle for the nex=
t
release and probably needs a bit more polish.

* jc/pickaxe-grep (2010-08-31) 4 commits
 - diff/log -G<pattern>: tests
 - git log/diff: add -G<regexp> that greps in the patch text
 - diff: pass the entire diff-options to diffcore_pickaxe()
 - gitdiffcore doc: update pickaxe description

This is a re-roll of "grepping inside the log -p output" which is a
feature that is often asked for when people hear about -S option.

* jh/error-removing-missing-note (2010-08-31) 1 commit
 - notes: Don't create (empty) commit when removing non-existing notes

Should be Ok to merge to 'next'; then will merge to 'master' shortly.

* jk/test-must-fail-missing (2010-08-31) 4 commits
 - tests: make test_might_fail fail on missing commands
 - tests: make test_might_fail more verbose
 - tests: make test_must_fail fail on missing commands
 - tests: make test_must_fail more verbose

Should be Ok to merge to 'next'; then will merge to 'master' shortly.

* jl/fetch-submodule-recursive (2010-08-30) 2 commits
 - Submodules: Add the new "fetch" config option for fetch and pull
 - fetch/pull: Recursively fetch populated submodules

I think the idea is sound and hopefully the end result will help the he=
avy
users of subprojects.  It came a bit late in the cycle for the next
release, though.

* kf/askpass-config (2010-08-30) 3 commits
 - Extend documentation of core.askpass and GIT_ASKPASS.
 - Allow core.askpass to override SSH_ASKPASS.
 - Add a new option 'core.askpass'.

Should be Ok to merge to 'next'; then will merge to 'master' shortly.

* tf/churn (2010-09-01) 2 commits
 - help.c: Pull cmd_version out of this file.
 - builtin.h: Move two functions definitions to help.h.

I don't like churning-for-the-sake-of-churning like these patches that
does not solve real problems and instead adds potential new ones.

At this point, adding the dashed-form "git-version" to the filesystem i=
s
going backwards.  These files are only to help people who have old scri=
pts
from pre 1.6.0 days with "PATH=3D$(git --exec-path):$PATH" with their
environment.

We should instead try to not adding them (which would probably need twe=
ak
in the command list generation code in "git help"), as nobody from pre
1.6.0 era would have called "git-version" binary.

* jc/builtin-binsearch (2010-08-05) 2 commits
 . git.c: binary search in the built-in command list
 . git.c: sort the list of built-in command names

* jc/tag-contains (2010-09-01) 1 commit
 . tag --contains: refactoring WIP

--------------------------------------------------
[Stalled]

* jj/icase-directory (2010-08-16) 6 commits
  (merged to 'next' on 2010-08-26 at 9d8e1bc)
 + Support case folding in git fast-import when core.ignorecase=3Dtrue
 + Support case folding for git add when core.ignorecase=3Dtrue
 + Add case insensitivity support when using git ls-files
 + Add case insensitivity support for directories when using git status
 + Case insensitivity support for .gitignore via core.ignorecase
 + Add string comparison functions that respect the ignore_case variabl=
e.

Depends on GNU FNM_CASEFOLD.

* by/line-log (2010-08-11) 17 commits
  (merged to 'next' on 2010-08-26 at a160ff1)
 + Document line history browser
 + Add tests for line history browser
 + Add --full-line-diff option
 + Add --graph prefix before line history output
 + Add parent rewriting to line history browser
 + Make graph_next_line external to other part of git
 + Make rewrite_parents public to other part of git
 + Hook line history into cmd_log, ensuring a topo-ordered walk
 + Print the line log
 + map/take range to the parent of commits
 + Add range clone functions
 + Export three functions from diff.c
 + Parse the -L options
 + Refactor parse_loc
 + Add the basic data structure for line level history
 + parse-options: add two helper functions
 + parse-options: enhance STOP_AT_NON_OPTION

There is a reported crash with valgrind trace.  Bo seems to be looking
into it.

* il/rfc-remote-fd-ext (2010-08-26) 7 commits
 - remote-ext/fd style fixup
 - Fix build on Windows
 - Simplify send_git_request()
 - Rewrite bidirectional traffic loop
 - gitignore: Ignore the new /git-remote-{ext,fd} helpers
 - New remote helper: git-remote-ext
 - New remote helper git-remote-fd

Needs a bit of usage illustration (this does not seem to come with any
documentation nor tests).

* en/object-list-with-pathspec (2010-08-26) 2 commits
 - Make rev-list --objects work together with pathspecs
 - Add testcases showing how pathspecs are ignored with rev-list --obje=
cts

Heard that this is still broken?

* zl/mailinfo-recode-patch (2010-06-14) 2 commits
 - add --recode-patch option to git-am
 - add --recode-patch option to git-mailinfo

I recall there was another round of re-roll planned for this one.

* jk/tag-contains (2010-07-05) 4 commits
 - Why is "git tag --contains" so slow?
 - default core.clockskew variable to one day
 - limit "contains" traversals based on commit timestamp
 - tag: speed up --contains calculation

The idea of the bottom one is probably Ok, except that the use of objec=
t
flags needs to be rethought, or at least the helper needs to be moved t=
o
builtin/tag.c to make it clear that it should not be used outside the
current usage context.

--------------------------------------------------
[Cooking]

* mg/doc-bundle (2010-08-23) 3 commits
  (merged to 'next' on 2010-08-23 at 2251a51)
 + git-bundle.txt: Clarify rev-list-args restrictions
 + git-bundle.txt: whitespace cleanup
 + git-bundle.txt: Cleanup

Will merge to 'master' shortly.

* bc/maint-fetch-url-only (2010-08-25) 2 commits
 - builtin/fetch.c: ignore merge config when not fetching from branch's=
 remote
 - t/t5510: demonstrate failure to fetch when current branch has merge =
ref

Should be Ok to merge to 'next'; then will merge to 'master' shortly.

* jc/maint-doc-em-dash (2010-08-23) 1 commit
  (merged to 'next' on 2010-08-24 at 2e4d30b)
 + Work around em-dash handling in newer AsciiDoc

Will merge to 'master' shortly.

* jf/merge-ignore-ws (2010-08-26) 4 commits
 - merge-recursive: options to ignore whitespace changes
 - merge-recursive --patience
 - ll-merge: replace flag argument with options struct
 - merge-recursive: expose merge options for builtin merge
 (this branch uses eb/double-convert-before-merge, jn/merge-renormalize=
 and jn/merge-renormalize.)

I think the idea is sound.  It came a bit late in the cycle for the nex=
t
release, though.

* jk/maint-pass-c-config-in-env (2010-08-24) 2 commits
 - do not pass "git -c foo=3Dbar" params to transport helpers
 - pass "git -c foo=3Dbar" params through environment

Should be Ok to merge to 'next'; then will merge to 'master' shortly.

* jl/submodule-ignore-diff (2010-08-28) 3 commits
  (merged to 'next' on 2010-08-31 at 4f21f92)
 + checkout: Use submodule.*.ignore settings from .git/config and .gitm=
odules
 + checkout: Add test for diff.ignoreSubmodules
  (merged to 'next' on 2010-08-26 at af1c819)
 + checkout: respect diff.ignoreSubmodules setting

I think the idea is sound.  It came a bit late in the cycle for the nex=
t
release, though.

* js/maint-reflog-beyond-horizon (2010-09-01) 4 commits
  (merged to 'next' on 2010-08-31 at d700755)
 + t1503: fix broken test_must_fail calls
  (merged to 'next' on 2010-08-26 at 4281562)
 + rev-parse: tests git rev-parse --verify master@{n}, for various n
 + sha1_name.c: use warning in preference to fprintf(stderr
 + rev-parse: exit with non-zero status if ref@{n} is not valid.

* rr/fmt-merge-msg (2010-08-27) 5 commits
 - t6200-fmt-merge-msg: Exercise '--log' to configure shortlog length
 - t6200-fmt-merge-msg: Exercise 'merge.log' to configure shortlog leng=
th
 - merge: Make 'merge.log' an integer or boolean option
 - merge: Make '--log' an integer option for number of shortlog entries
 - fmt_merge_msg: Change fmt_merge_msg API to accept shortlog_len
 (this branch uses jn/update-contrib-example-merge.)

I think the idea is sound.  It came a bit late in the cycle for the nex=
t
release, though.

* tr/merge-unborn-clobber (2010-08-22) 1 commit
 - Exhibit merge bug that clobbers index&WT

* en/tree-walk-optim (2010-08-26) 4 commits
 - diff_tree(): Skip skip_uninteresting() when all remaining paths inte=
resting
 - tree_entry_interesting(): Make return value more specific
 - tree-walk: Correct bitrotted comment about tree_entry()
 - Document pre-condition for tree_entry_interesting

I think the idea is sound.  For a patch that touches fairly core part o=
f
the system, it came a bit late in the cycle, though.

* jn/maint-doc-user-manual-html-doctype (2010-08-21) 2 commits
  (merged to 'next' on 2010-08-26 at e9084af)
 + docs: fix Makefile dependency for user manual
 + Documentation: set a !DOCTYPE for user manual

Will merge to 'master' shortly.

* cb/maint-mergetool-no-tty (2010-08-20) 1 commit
  (merged to 'next' on 2010-08-26 at b14989a)
 + mergetool: Remove explicit references to /dev/tty

Will merge to 'master' shortly.

* jn/doc-backslash (2010-08-20) 17 commits
  (merged to 'next' on 2010-08-23 at 8c364b2)
 + Documentation: remove stray backslash in show-branch discussion
 + Documentation: remove stray backslashes from "Fighting regressions" =
article
 + Documentation: do not convert ... operator to ellipses
 + Documentation: avoid stray backslash in user manual
 + Documentation: avoid stray backslashes in core tutorial
 + Documentation: remove stray backslashes in rev-parse manual
 + Documentation: remove backslash before ~ in fast-import manual
 + Documentation: remove stray backslash from "git bundle" manual
 + Documentation/technical: avoid stray backslash in parse-options API =
docs
 + Documentation: remove backslashes in manpage synopses
 + Documentation: clarify quoting in gitignore docs
 + Documentation: clarify quoting in "git rm" example
 + Documentation: add missing quotes to "git grep" examples
 + Documentation: clarify quoting in "git add" example
 + Documentation: unbreak regex in show-ref manual
 + Documentation: quoting trouble in "git rm" discussion
 + Documentation: tweak description of log.date

Will merge to 'master' shortly.

* nd/clone-depth-zero (2010-08-23) 1 commit
  (merged to 'next' on 2010-08-26 at b4491c3)
 + clone: warn users --depth is ignored in local clones

Will merge to 'master' shortly.

* cb/ignored-paths-are-precious (2010-08-21) 1 commit
 - checkout/merge: optionally fail operation when ignored files need to=
 be overwritten

I fixed up a trivial error in the configuration parser (which didn't
return immediately after parsing), and while at it flipped the default=20
value of the configuration and the command line option to false.

This probably needs tests; also we know of longstanding bugs in related
area that needs to be addressed---they do not have to be part of this
series but their reproduction recipe would belong to the test script fo=
r
this topic.

It may hurt users to make the new feature on by default, especially the
ones with subdirectories that come and go.  For a patch that changes a
long established semantics, it came a bit late in the cycle, so it will
have to wait until the next release.

* jn/apply-filename-with-sp (2010-08-18) 3 commits
  (merged to 'next' on 2010-08-26 at 4f60840)
 + apply: handle traditional patches with space in filename
 + tests: exercise "git apply" with weird filenames
 + apply: split quoted filename handling into new function

Will merge to 'master' shortly.

* jn/merge-custom-no-trivial (2010-08-23) 3 commits
  (merged to 'next' on 2010-08-24 at d9e5b2d)
 + t7606: Avoid using head as a file name
  (merged to 'next' on 2010-08-21 at 674498b)
 + merge: let custom strategies intervene in trivial merges
 + t7606 (merge-theirs): modernize style

Will merge to 'master' shortly.

* po/etc-gitattributes (2010-09-01) 1 commit
 - Add global and system-wide gitattributes

I think the idea is sound.  For a patch that touches fairly core part o=
f
the system, it came a bit late in the cycle, though.

* ab/compat-regex (2010-08-26) 9 commits
  (merged to 'next' on 2010-08-26 at c5cc9d2)
 + Fix compat/regex ANSIfication on MinGW
  (merged to 'next' on 2010-08-22 at 40bce7c)
 + autoconf: regex library detection typofix
  (merged to 'next' on 2010-08-21 at 632d60f)
 + autoconf: don't use platform regex if it lacks REG_STARTEND
 + t/t7008-grep-binary.sh: un-TODO a test that needs REG_STARTEND
 + compat/regex: get rid of old-style definition
 + compat/regex: define out variables only used under RE_ENABLE_I18N
 + Change regerror() declaration from K&R style to ANSI C (C89)
 + compat/regex: get the gawk regex engine to compile within git
 + compat/regex: use the regex engine from gawk for compat

Will merge to 'master' shortly.

* jn/update-contrib-example-merge (2010-08-17) 24 commits
  (merged to 'next' on 2010-08-21 at 41b5c4d)
 + merge script: learn --[no-]rerere-autoupdate
 + merge script: notice @{-1} shorthand
 + merge script: handle --no-ff --no-commit correctly
 + merge script: --ff-only to disallow true merge
 + merge script: handle many-way octopus
 + merge script: handle -m --log correctly
 + merge script: forbid merge -s index
 + merge script: allow custom strategies
 + merge script: merge -X<option>
 + merge script: improve log message subject
 + merge script: refuse to merge during merge
 + merge script: tweak unmerged files message to match builtin
 + merge script: --squash, --ff from unborn branch are errors
 + fmt-merge-msg -m to override merge title
 + merge-base --independent to print reduced parent list in a merge
 + merge-base --octopus to mimic show-branch --merge-base
 + Documentation: add a SEE ALSO section for merge-base
 + t6200 (fmt-merge-msg): style nitpicks
 + t6010 (merge-base): modernize style
 + t7600 (merge): test merge from branch yet to be born
 + t7600 (merge): check reflog entry
 + t7600 (merge): do not launch gitk for --debug
 + t7600 (merge): modernize style
 + merge: do not mistake (ancestor of) tag for branch
 (this branch is used by rr/fmt-merge-msg.)

Will merge to 'master' shortly.

* jn/merge-renormalize (2010-08-05) 12 commits
  (merged to 'next' on 2010-08-18 at d9aa77b)
 + merge-recursive --renormalize
 + rerere: never renormalize
 + rerere: migrate to parse-options API
 + t4200 (rerere): modernize style
 + ll-merge: let caller decide whether to renormalize
 + ll-merge: make flag easier to populate
 + Documentation/technical: document ll_merge
 + merge-trees: let caller decide whether to renormalize
 + merge-trees: push choice to renormalize away from low level
 + t6038 (merge.renormalize): check that it can be turned off
 + t6038 (merge.renormalize): try checkout -m and cherry-pick
 + t6038 (merge.renormalize): style nitpicks
 (this branch is used by jf/merge-ignore-ws and jf/merge-ignore-ws; use=
s eb/double-convert-before-merge.)

Will merge to 'master' shortly.

* eb/double-convert-before-merge (2010-07-02) 3 commits
 + Don't expand CRLFs when normalizing text during merge
 + Try normalizing files to avoid delete/modify conflicts when merging
 + Avoid conflicts when merging branches with mixed normalization
 (this branch is used by jf/merge-ignore-ws and jn/merge-renormalize.)

* js/detached-stash (2010-09-01) 10 commits
  (merged to 'next' on 2010-08-31 at 7d20c13)
 + t3903: fix broken test_must_fail calls
  (merged to 'next' on 2010-08-26 at 7180a87)
 + detached-stash: update Documentation
 + detached-stash: tests of git stash with stash-like arguments
 + detached-stash: simplify git stash show
 + detached-stash: simplify git stash branch
 + detached-stash: refactor git stash pop implementation
 + detached-stash: simplify stash_drop
 + detached-stash: simplify stash_apply
 + detached-stash: work around git rev-parse failure to detect bad log =
refs
 + detached-stash: introduce parse_flags_and_revs function

Will merge to 'master' shortly.

* gb/shell-ext (2010-08-27) 6 commits
  (merged to 'next' on 2010-08-27 at e1ef3c1)
 + shell: Display errors from improperly-formatted command lines
 + Merge branch 'gb/split-cmdline-errmsg' into gb/shell-ext
  (merged to 'next' on 2010-08-24 at 49ea7b8)
 + shell: Rewrite documentation and improve error message
 + Add sample commands for git-shell
 + Add interactive mode to git-shell for user-friendliness
 + Allow creation of arbitrary git-shell commands

I am not very happy about adding these backdoors to git-shell, which is
primarily a security mechanism, and obviously security and backdoor do =
not
mix well.

* ab/i18n (2010-08-31) 23 commits
 - gettext: Make NO_GETTEXT=3DYesPlease the default in releases
 - gettext tests: test message re-encoding under C
 - po/pl.po: add Polish translation
 - po/is.po: add Icelandic translation
 - po/is.po: msgmerge and add Language: header
 - gettext tests: mark a test message as not needing translation
 - gettext tests: test re-encoding with a UTF-8 msgid under Shell
 - gettext tests: test message re-encoding under Shell
 - gettext tests: add detection for is_IS.ISO-8859-1 locale
 - gettext tests: update test/is.po to match t/t0200/test.c
 - gettext tests: test if $VERSION exists before using it
 - gettext.c: work around us not using setlocale(LC_CTYPE, "")
 - gettext: localize the main git-init message
 - gettext: make the simple parts of git-init localizable
 - builtin.h: Include gettext.h
 - Makefile: use variables and shorter lines for xgettext
 - Makefile: tell xgettext(1) that our source is in UTF-8
 - Makefile: provide a --msgid-bugs-address to xgettext(1)
 - Makefile: A variable for options used by xgettext(1) calls
 - tests: locate i18n lib&data correctly under --valgrind
 - gettext: setlocale(LC_CTYPE, "") breaks Git's C function assumptions
 - tests: rename test to work around GNU gettext bug
 - Add infrastructure for translating Git with gettext
 (this branch is used by ab/test.)

Kicked back to 'pu' to give it a bit more time to experiment with a
Porcelain command or a two, and an opportunity for a fresh restart if
necessary in the next cycle.

--------------------------------------------------
[Ejected]

* jc/log-grep (2010-08-23) 1 commit
 . git log: add -G<regexp> that greps in the patch text

* ab/test (2010-08-30) 8 commits
 . tests: factor HOME=3D$(pwd) in test-lib.sh
 . test-lib: use subshell instead of cd $new && .. && cd $old
 . tests: simplify "missing PREREQ" message
 . t/t0000-basic.sh: Run the passing TODO test inside its own test-lib
 . test-lib: Allow overriding of TEST_DIRECTORY
 . test-lib: Use "$GIT_BUILD_DIR" instead of "$TEST_DIRECTORY"/../
 . test-lib: Use $TEST_DIRECTORY or $GIT_BUILD_DIR instead of $(pwd) an=
d ../
 . Merge branch 'ab/i18n' into ab/test-1
 (this branch uses ab/i18n and ab/test-2.)

Rebuilt as 'ab/test-2'.
