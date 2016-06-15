From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Aug 2010, #03; Sun, 15)
Date: Sun, 15 Aug 2010 01:54:56 -0700
Message-ID: <7vaaoogsrj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 15 17:29:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Okf9d-0000th-Cv
	for gcvg-git-2@lo.gmane.org; Sun, 15 Aug 2010 17:29:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756726Ab0HOP3n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Aug 2010 11:29:43 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59476 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753107Ab0HOP3g convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Aug 2010 11:29:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 297BCCDC31;
	Sun, 15 Aug 2010 04:55:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=/6dqDsQ8e2eDWkrPK5y5af959
	eg=; b=s9mANEofjFv2b8v1QB3ixwLcaB0CYenpBp86tIIeoYn8qRs2fbLT63bCW
	H98EmvMQiou4APKujfR+AuOuE/SUqmyUhD4MeFmXVOeib0eMW8MuLS0d9uaK1tLF
	Hq+I4nHB15YLWTlpe/LSOTyYQQY9GKzxBF+GtxXiZgGlHabzzk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=PJ9sD5GzvNuSq3gTqpF
	BpoJaRFQHSmGQkZWTN4AAdVO2B6kIargdEplY4/gFXMbRcNlzdmemeVTuM18s5/P
	smZ2r+nz5tbk3QQRgsBl/omPjuJqUFMePt6y/ErwnUJYsjJpRuKb8sNBsxIQHjqT
	RKK+yNc8xYZWRfWNV7fg3Npk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 148E0CDC30;
	Sun, 15 Aug 2010 04:55:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 907F9CDC0B; Sun, 15 Aug
 2010 04:54:58 -0400 (EDT)
X-master-at: 3d045897585c4b1ca0dce6bb5a33331f1b48c2bf
X-next-at: f2a27ee4a32784537ae739b7c6668eec567dd60c
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D517E8F6-A84A-11DF-A43E-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153601>

Here are the topics that have been cooking.  Commits prefixed with '-' =
are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the integration branches, but I=
 am
still holding onto them.

--------------------------------------------------
[New Topics]

* ab/perl-install (2010-08-03) 1 commit
  (merged to 'next' on 2010-08-14 at f2a27ee)
 + perl/Makefile: Unset INSTALL_BASE when making perl.mak

* ab/test (2010-08-14) 6 commits
 - t/Makefile: Create test-results dir for smoke target
 - Merge branch 'ab/test-no-skip'
 - Merge branch 'ab/test-coverage'
 - Merge branch 'ab/test-smoke'
 - Merge branch 'ab/test-prereq'
 - Merge branch 'ab/omit-aggregate-test-result-under-tap-harness'
 (this branch uses ab/omit-aggregate-test-result-under-tap-harness, ab/=
test-coverage, ab/test-no-skip, ab/test-prereq and ab/test-smoke.)

All the test-related topics seem to be almost ready for 'next', so I ma=
de
a single aggregate of them in preparation for merging (there is one fix=
-up
already still on 'pu', which is good).

* jc/maint-follow-rename-fix (2010-08-13) 2 commits
  (merged to 'next' on 2010-08-14 at 16706d6)
 + diff --follow: do call diffcore_std() as necessary
 + diff --follow: do not waste cycles while recursing

* dj/fetch-tagopt (2010-08-11) 1 commit
 - fetch: allow command line --tags to override config

* po/userdiff-csharp (2010-08-11) 1 commit
 - Userdiff patterns for C#

--------------------------------------------------
[Graduated to "master"]

* bc/use-more-hardlinks-in-install (2010-07-23) 2 commits
  (merged to 'next' on 2010-08-11 at 59dd30e)
 + Makefile: make hard/symbolic links for non-builtins too
 + Makefile: link builtins residing in bin directory to main git binary=
 too

* jc/sha1-name-find-fix (2010-08-02) 1 commit
  (merged to 'next' on 2010-08-11 at 51106a5)
 + sha1_name.c: fix parsing of ":/token" syntax

* jn/doc-pull (2010-08-02) 1 commit
  (merged to 'next' on 2010-08-11 at a223479)
 + Documentation: flesh out =E2=80=9Cgit pull=E2=80=9D description

* jn/maint-gitweb-dynconf (2010-07-30) 1 commit
  (merged to 'next' on 2010-08-11 at a94ce85)
 + gitweb: allow configurations that change with each request

* jn/parse-date-basic (2010-07-15) 1 commit
  (merged to 'next' on 2010-08-11 at ca9fef0)
 + Export parse_date_basic() to convert a date string to timestamp
 (this branch is used by rr/svn-export.)

* sp/fix-smart-http-deadlock-on-error (2010-08-06) 1 commit
  (merged to 'next' on 2010-08-11 at 0a6369e)
 + smart-http: Don't deadlock on server failure

Will merge to 'maint' later.

* tr/rfc-reset-doc (2010-07-18) 5 commits
  (merged to 'next' on 2010-08-11 at 8e7c8d1)
 + Documentation/reset: move "undo permanently" example behind "make to=
pic"
 + Documentation/reset: reorder examples to match description
 + Documentation/reset: promote 'examples' one section up
 + Documentation/reset: separate options by mode
 + Documentation/git-reset: reorder modes for soft-mixed-hard progressi=
on

--------------------------------------------------
[Stalled]

* zl/mailinfo-recode-patch (2010-06-14) 2 commits
 - add --recode-patch option to git-am
 - add --recode-patch option to git-mailinfo

I recall there was another round of re-roll planned for this one.

* jk/tag-contains (2010-07-05) 4 commits
 - Why is "git tag --contains" so slow?
 - default core.clockskew variable to one day
 - limit "contains" traversals based on commit timestamp
 - tag: speed up --contains calculation

* jn/commit-no-change-wo-status (2010-08-11) 10 commits
 . t6040 (branch tracking): check =E2=80=9Cstatus=E2=80=9D instead of =E2=
=80=9Ccommit=E2=80=9D
 . commit: suppress status summary when no changes staged
 . commit --dry-run: give advice on empty amend
 . commit: give empty-commit avoidance code its own function
 . t7508 (status): modernize style
 . commit: split off the piece that writes status
 . commit: split commit -s handling into its own function
 . commit: split off a function to fetch the default log message
 . wt-status: split off a function for printing submodule summary
 . wt-status: split wt_status_print into digestible pieces

There seemed to be some doubts on removal of the "no changes" line?

--------------------------------------------------
[Cooking]

* jn/paginate-fix (2010-08-05) 13 commits
 - merge-file: run setup_git_directory_gently() sooner
 - var: run setup_git_directory_gently() sooner
 - ls-remote: run setup_git_directory_gently() sooner
 - index-pack: run setup_git_directory_gently() sooner
 - Merge branch 'jn/maint-setup-fix' (early part) into HEAD
 - config: run setup_git_directory_gently() sooner
 - bundle: run setup_git_directory_gently() sooner
 - apply: run setup_git_directory_gently() sooner
 - grep: run setup_git_directory_gently() sooner
 - shortlog: run setup_git_directory_gently() sooner
 - git wrapper: allow setup_git_directory_gently() be called earlier
 - setup: remember whether repository was found
 - git wrapper: introduce startup_info struct
 (this branch uses jn/maint-setup-fix.)

Merging this to 'pu' seems to break some tests...

* jn/merge-renormalize (2010-08-05) 12 commits
 - merge-recursive --renormalize
 - rerere: never renormalize
 - rerere: migrate to parse-options API
 - t4200 (rerere): modernize style
 - ll-merge: let caller decide whether to renormalize
 - ll-merge: make flag easier to populate
 - Documentation/technical: document ll_merge
 - merge-trees: let caller decide whether to renormalize
 - merge-trees: push choice to renormalize away from low level
 - t6038 (merge.renormalize): check that it can be turned off
 - t6038 (merge.renormalize): try checkout -m and cherry-pick
 - t6038 (merge.renormalize): style nitpicks
 (this branch uses eb/double-convert-before-merge.)

There were heavy merge conflicts in t4200; I tried to be careful when
merging this, but extra sets of eyeballs from parties involved (Jonatha=
n
and Szeder) would always be a good idea.

* ab/omit-aggregate-test-result-under-tap-harness (2010-08-11) 1 commit
 - test-lib: Don't write test-results when HARNESS_ACTIVE
 (this branch is used by ab/test.)

* ab/test-prereq (2010-08-11) 5 commits
 - test-lib: Multi-prereq support only checked the last prereq
 - tests: A SANITY test prereq for testing if we're root
 - t/README: Document the predefined test prerequisites
 - test-lib: Print missing prerequisites in test output
 - test-lib: Add support for multiple test prerequisites
 (this branch is used by ab/test.)

* ab/test-smoke (2010-08-08) 4 commits
 - t/README: Add SMOKE_{COMMENT,TAGS}=3D to smoke_report target
 - t/Makefile: Can't include GIT-BUILD-OPTIONS, it's a .sh
 - t/README: Document the Smoke testing
 - tests: Infrastructure for Git smoke testing
 (this branch is used by ab/test.)

* by/line-log (2010-08-11) 17 commits
 - Document line history browser
 - Add tests for line history browser
 - Add --full-line-diff option
 - Add --graph prefix before line history output
 - Add parent rewriting to line history browser
 - Make graph_next_line external to other part of git
 - Make rewrite_parents public to other part of git
 - Hook line history into cmd_log, ensuring a topo-ordered walk
 - Print the line log
 - map/take range to the parent of commits
 - Add range clone functions
 - Export three functions from diff.c
 - Parse the -L options
 - Refactor parse_loc
 - Add the basic data structure for line level history
 - parse-options: add two helper functions
 - parse-options: enhance STOP_AT_NON_OPTION

* dg/local-mod-error-messages (2010-08-11) 5 commits
  (merged to 'next' on 2010-08-14 at e684ca8)
 + t7609: test merge and checkout error messages
 + unpack_trees: group error messages by type
 + merge-recursive: distinguish "removed" and "overwritten" messages
 + merge-recursive: porcelain messages for checkout
 + Turn unpack_trees_options.msgs into an array + enum

* en/rebase-against-rebase-fix (2010-08-12) 2 commits
  (merged to 'next' on 2010-08-14 at 1dea7b9)
 + pull --rebase: Avoid spurious conflicts and reapplying unnecessary p=
atches
 + t5520-pull: Add testcases showing spurious conflicts from git pull -=
-rebase

* gb/split-cmdline-errmsg (2010-08-07) 1 commit
  (merged to 'next' on 2010-08-14 at 41146ff)
 + split_cmdline: Allow caller to access error string

* jl/submodule-ignore-diff (2010-08-06) 4 commits
  (merged to 'next' on 2010-08-12 at ffe84bb)
 + Add tests for the diff.ignoreSubmodules config option
 + Add the 'diff.ignoreSubmodules' config setting
 + Submodules: Use "ignore" settings from .gitmodules too for diff and =
status
 + Submodules: Add the new "ignore" config option for diff and status

* jn/maint-plug-leak (2010-08-09) 3 commits
  (merged to 'next' on 2010-08-14 at ec2ba20)
 + write-tree: Avoid leak when index refers to an invalid object
 + read-tree: stop leaking tree objects
 + core: Stop leaking ondisk_cache_entrys

* jn/svn-fe (2010-08-13) 16 commits
 - t9010 (svn-fe): avoid symlinks in test
 - t9010 (svn-fe): use Unix-style path in URI
 - vcs-svn: Avoid %z in format string
 - vcs-svn: Rename dirent pool to build on Windows
 - compat: add strtok_r()
 - treap: style fix
 - vcs-svn: remove build artifacts on "make clean"
 - svn-fe manual: Clarify warning about deltas in dump files
 - Update svn-fe manual
 - SVN dump parser
 - Infrastructure to write revisions in fast-export format
 - Add stream helper library
 - Add string-specific memory pool
 - Add treap implementation
 - Add memory pool library
 - Introduce vcs-svn lib

Added patches to port to Windows.

* js/detached-stash (2010-08-10) 9 commits
 - Documentation: git stash branch now tolerates non-stash references.
 - t3903-stash.sh: tests of git stash with stash-like arguments
 - stash: teach git stash show to always tolerate stash-like arguments.
 - stash: teach git stash branch to tolerate stash-like arguments
 - stash: teach git stash drop to fail early if the specified revision =
is not a stash reference
 - stash: teach git stash pop to fail early if the argument is not a st=
ash ref
 - stash: introduce is_stash_ref and assert_stash_ref functions.
 - stash: extract stash-like check into its own function
 - stash: refactor - create pop_stash function

Sent out comments...

* mm/rebase-i-exec (2010-08-13) 4 commits
  (merged to 'next' on 2010-08-14 at 17620dc)
 + git-rebase--interactive.sh: use printf instead of echo to print comm=
it message
 + git-rebase--interactive.sh: rework skip_unnecessary_picks
  (merged to 'next' on 2010-08-12 at 377e3f0)
 + test-lib: user-friendly alternatives to test [-d|-f|-e]
 + rebase -i: add exec command to launch a shell command

* so/http-user-agent (2010-08-11) 1 commit
  (merged to 'next' on 2010-08-12 at 86cc5c4)
 + Allow HTTP user agent string to be modified.

* sr/local-config (2010-08-03) 1 commit
  (merged to 'next' on 2010-08-12 at 431f7af)
 + config: add --local option

* ab/test-coverage (2010-07-26) 8 commits
 - Makefile: make gcov invocation configurable
 - t/README: Add a note about the dangers of coverage chasing
 - t/README: A new section about test coverage
 - Makefile: Add cover_db_html target
 - Makefile: Add cover_db target
 - Makefile: Split out the untested functions target
 - Makefile: Include subdirectories in "make cover" reports
 - gitignore: Ignore files generated by "make coverage"
 (this branch is used by ab/test.)

* ab/test-no-skip (2010-08-10) 13 commits
 - git-notes: Run partial expensive test everywhere
 - t/t3300-funny-names: change from skip_all=3D* to prereq skip
 - t/t3902-quoted: change from skip_all=3D* to prereq skip
 - t/t4016-diff-quote: change from skip_all=3D* to prereq skip
 - t/t5503-tagfollow: change from skip_all=3D* to prereq skip
 - t/t7005-editor: change from skip_all=3D* to prereq skip
 - t/t5705-clone-2gb: change from skip_all=3D* to prereq skip
 - t/t1304-default-acl: change from skip_all=3D* to prereq skip
 - t/README: Update "Skipping tests" to align with best practices
 - t/t7800-difftool.sh: Skip with prereq on no PERL
 - t/t5800-remote-helpers.sh: Skip with prereq on python <2.4
 - t/t4004-diff-rename-symlink.sh: use three-arg <prereq>
 - tests: implicitly skip SYMLINKS tests using <prereq>
 (this branch is used by ab/test.)

* cc/find-commit-subject (2010-07-22) 6 commits
  (merged to 'next' on 2010-08-12 at ce38436)
 + blame: use find_commit_subject() instead of custom code
 + merge-recursive: use find_commit_subject() instead of custom code
 + bisect: use find_commit_subject() instead of custom code
 + revert: rename variables related to subject in get_message()
 + revert: refactor code to find commit subject in find_commit_subject(=
)
 + revert: fix off by one read when searching the end of a commit subje=
ct

* gb/shell-ext (2010-07-28) 3 commits
 - Add sample commands for git-shell
 - Add interactive mode to git-shell for user-friendliness
 - Allow creation of arbitrary git-shell commands

Replaced the first one with the version that uses getenv("HOME")

* jc/log-grep (2010-07-19) 1 commit
 - git log: add -G<regexp> that greps in the patch text

This is broken, but haven't found any time to revisit it yet.

* jh/clean-exclude (2010-07-20) 2 commits
  (merged to 'next' on 2010-08-12 at 9a63fd4)
 + Add test for git clean -e.
 + Add -e/--exclude to git-clean.

* jh/use-test-must-fail (2010-07-20) 1 commit
  (merged to 'next' on 2010-08-12 at 16d4e11)
 + Convert "! git" to "test_must_fail git"

* jn/apply-filename-with-sp (2010-07-23) 4 commits
 - apply: Handle traditional patches with space in filename
 - t4135 (apply): use expand instead of pr for portability
 - tests: Test how well "git apply" copes with weird filenames
 - apply: Split quoted filename handling into new function

prereq?

* jn/fix-abbrev (2010-07-27) 3 commits
  (merged to 'next' on 2010-08-12 at 2cf70df)
 + examples/commit: use --abbrev for commit summary
 + checkout, commit: remove confusing assignments to rev.abbrev
 + archive: abbreviate substituted commit ids again

* jn/maint-setup-fix (2010-07-24) 11 commits
 - setup: split off a function to handle ordinary .git directories
 - Revert "rehabilitate 'git index-pack' inside the object store"
 - setup: do not forget working dir from subdir of gitdir
 - t4111 (apply): refresh index before applying patches to it
 - setup: split off get_device_or_die helper
 - setup: split off a function to handle hitting ceiling in repo search
 - setup: split off code to handle stumbling upon a repository
 - setup: split off a function to checks working dir for .git file
 - setup: split off $GIT_DIR-set case from setup_git_directory_gently
 - tests: try git apply from subdir of toplevel
 - t1501 (rev-parse): clarify
 (this branch is used by jn/paginate-fix.)

* jn/rebase-rename-am (2008-11-10) 5 commits
  (merged to 'next' on 2010-08-12 at a6d25c4)
 + rebase: protect against diff.renames configuration
 + t3400 (rebase): whitespace cleanup
 + Teach "apply --index-info" to handle rename patches
 + t4150 (am): futureproof against failing tests
 + t4150 (am): style fix

* ml/rebase-x-strategy (2010-07-29) 1 commit
  (merged to 'next' on 2010-08-12 at 0aa2fdb)
 + rebase: support -X to pass through strategy options

* mm/shortopt-detached (2010-08-05) 5 commits
  (merged to 'next' on 2010-08-12 at 35ceb98)
 + log: parse separate option for --glob
 + log: parse separate options like git log --grep foo
 + diff: parse separate options --stat-width n, --stat-name-width n
 + diff: split off a function for --stat-* option parsing
 + diff: parse separate options like -S foo

* nd/fix-sparse-checkout (2010-07-31) 5 commits
  (merged to 'next' on 2010-08-12 at 4f7a3b9)
 + unpack-trees: mark new entries skip-worktree appropriately
 + unpack-trees: do not check for conflict entries too early
 + unpack-trees: let read-tree -u remove index entries outside sparse a=
rea
 + unpack-trees: only clear CE_UPDATE|CE_REMOVE when skip-worktree is a=
lways set
 + t1011 (sparse checkout): style nitpicks

* tr/maint-no-unquote-plus (2010-07-24) 1 commit
 - Do not unquote + into ' ' in URLs

* tr/xsize-bits (2010-07-28) 1 commit
  (merged to 'next' on 2010-08-11 at bcc0271)
 + xsize_t: check whether we lose bits

* vs/doc-spell (2010-07-20) 1 commit
  (merged to 'next' on 2010-08-12 at 3fbd06c)
 + Documentation: spelling fixes

* ab/report-corrupt-object-with-type (2010-06-10) 1 commit
  (merged to 'next' on 2010-08-12 at 8a9e1d0)
 + sha1_file: Show the the type and path to corrupt objects

* cc/revert (2010-07-21) 5 commits
  (merged to 'next' on 2010-08-14 at a910d5a)
 + t3508: add check_head_differs_from() helper function and use it
 + revert: improve success message by adding abbreviated commit sha1
 + revert: don't print "Finished one cherry-pick." if commit failed
 + revert: refactor commit code into a new run_git_commit() function
 + revert: report success when using option --strategy

* en/fast-export-fix (2010-07-17) 2 commits
 - fast-export: Add a --full-tree option
 - fast-export: Fix dropping of files with --import-marks and path limi=
ting

* kf/post-receive-sample-hook (2010-07-16) 1 commit
  (merged to 'next' on 2010-08-12 at 9b7e3c9)
 + post-receive-email: optional message line count limit

I do not particularly like the idea of counting number of lines in a sh=
ell
loop but this is an opt-in feature to a contrib/ item so it should be o=
k.

* hv/autosquash-config (2010-07-14) 1 commit
 - add configuration variable for --autosquash option of interactive re=
base

* jh/graph-next-line (2010-07-13) 2 commits
  (merged to 'next' on 2010-08-11 at 333f9df)
 + Enable custom schemes for column colors in the graph API
 + Make graph_next_line() available in the graph.h API

* ar/string-list-foreach (2010-07-03) 2 commits
  (merged to 'next' on 2010-08-11 at 993dc02)
 + Convert the users of for_each_string_list to for_each_string_list_it=
em macro
 + Add a for_each_string_list_item macro
 (this branch is used by tf/string-list-init.)

* il/rfc-remote-fd-ext (2010-08-14) 6 commits
 - Fix build on Windows
 - Simplify send_git_request()
 - Rewrite bidirectional traffic loop
 - gitignore: Ignore the new /git-remote-{ext,fd} helpers
 - New remote helper: git-remote-ext
 - New remote helper git-remote-fd

* hv/submodule-find-ff-merge (2010-07-07) 3 commits
  (merged to 'next' on 2010-08-11 at 6900d2c)
 + Implement automatic fast-forward merge for submodules
 + setup_revisions(): Allow walking history in a submodule
 + Teach ref iteration module about submodules

* jn/fast-import-subtree (2010-06-30) 1 commit
  (merged to 'next' on 2010-08-11 at 5e19de0)
 + Teach fast-import to import subtrees named by tree id

* sg/rerere-gc-old-still-used (2010-07-13) 2 commits
 - rerere: fix overeager gc
 - mingw_utime(): handle NULL times parameter

* tf/string-list-init (2010-07-04) 1 commit
  (merged to 'next' on 2010-08-14 at 193b4db)
 + string_list: Add STRING_LIST_INIT macro and make use of it.
 (this branch uses ar/string-list-foreach.)

* en/d-f-conflict-fix (2010-08-12) 8 commits
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

* ab/i18n (2010-07-25) 4 commits
 - tests: locate i18n lib&data correctly under --valgrind
 - gettext: setlocale(LC_CTYPE, "") breaks Git's C function assumptions
 - tests: rename test to work around GNU gettext bug
 - Add infrastructure for translating Git with gettext

* tc/checkout-B (2010-08-10) 4 commits
  (merged to 'next' on 2010-08-11 at 5433b51)
 + builtin/checkout: handle -B from detached HEAD correctly
 + builtin/checkout: learn -B
 + builtin/checkout: reword hint for -b
 + add tests for checkout -b

* eb/double-convert-before-merge (2010-07-02) 3 commits
 - Don't expand CRLFs when normalizing text during merge
 - Try normalizing files to avoid delete/modify conflicts when merging
 - Avoid conflicts when merging branches with mixed normalization
 (this branch is used by jn/merge-renormalize.)
