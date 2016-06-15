From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Dec 2012, #07; Wed, 26)
Date: Wed, 26 Dec 2012 14:59:50 -0800
Message-ID: <7vpq1wmnbt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 27 00:00:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TnzxP-0004xr-8n
	for gcvg-git-2@plane.gmane.org; Thu, 27 Dec 2012 00:00:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355Ab2LZW74 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 17:59:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64810 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751142Ab2LZW7y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2012 17:59:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ACAD7A231;
	Wed, 26 Dec 2012 17:59:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=R
	MyKFSoFvinYQEjX4k12fZRpOHI=; b=pEQqZn/SG2AxCnJM9zknK8EDEOgyLxIwS
	Cl0aNId0myA4uo3D56HwgENhmwHAq8ImAsIgzV68qEnLa73cFHg8GeTBhZy6/nSd
	Rut5L0eU3+ySaeVJ/sXDwPZDFcq8trXhxEVgT6M+NENg7hF0q1RK5zdNvaUc+hGV
	gpQQ2La9bI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=eoA
	q6X6nvYl8H2HP6z/krlwIEM+wuOE4y6AIEiNRSTAxCmeBj6MRhgqPyNNvEhvfO2Q
	PFVC6DPSBJY77pdAkBXJ5Nr512jGSoVJzJgoCbeOIu/fea+Z9z3LCqWU1kVIm/tK
	tcshrj+C7CQfOfH+Q2fGQzEDSbUyDtt+R4EXYlFY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 98A0EA230;
	Wed, 26 Dec 2012 17:59:53 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0F526A22D; Wed, 26 Dec 2012
 17:59:51 -0500 (EST)
X-master-at: 86c3e6ed515d5e3bfca1d515c607db55ba032d71
X-next-at: 3b93f37cbe43cae3e38334ca5dd4acf52ee3bfde
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F4DFA69C-4FAF-11E2-9B6E-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212161>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

The final release for this cycle will happen sometime next week,
hopefully.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* jc/format-patch-reroll (2012-12-22) 7 commits
 - format-patch: add --reroll-count=$N option
 - get_patch_filename(): split into two functions
 - get_patch_filename(): drop "just-numbers" hack
 - get_patch_filename(): simplify function signature
 - builtin/log.c: stop using global patch_suffix
 - builtin/log.c: drop redundant "numbered_files" parameter from make_cover_letter()
 - builtin/log.c: drop unused "numbered" parameter from make_cover_letter()

 Teach "format-patch" to prefix v4- to its output files for the
 fourth iteration of a patch series, to make it easier for the
 submitter to keep separate copies for iterations.

 Needs tests and documentation updates.


* ms/subtree-fixlets (2012-12-22) 2 commits
  (merged to 'next' on 2012-12-26 at 1cb26eb)
 + git-subtree: fix typo in manpage
 + git-subtree: ignore git-subtree executable

 Will cook in 'next'.


* mz/pick-unborn (2012-12-23) 2 commits
 - learn to pick/revert into unborn branch
 - tests: move test_cmp_rev to test-lib-functions

 Will merge to 'next'.


* nd/retire-fnmatch (2012-12-22) 8 commits
 - wildmatch: advance faster in <asterisk> + <literal> patterns
 - wildmatch: make a special case for "*/" with FNM_PATHNAME
 - Makefile: add USE_WILDMATCH to use wildmatch as fnmatch
 - test-wildmatch: add "perf" command to compare wildmatch and fnmatch
 - wildmatch: support "no FNM_PATHNAME" mode
 - wildmatch: make dowild() take arbitrary flags
 - wildmatch: rename constants and update prototype
 - compat/fnmatch: respect NO_FNMATCH* even on glibc
 (this branch uses nd/wildmatch.)

 Replace our use of fnmatch(3) with a more feature-rich wildmatch.


* jc/test-cvs-no-init-in-existing-dir (2012-12-24) 1 commit
  (merged to 'next' on 2012-12-26 at 3b93f37)
 + t9200: let "cvs init" create the test repository

 Will cook in 'next'.


* os/gitweb-highlight-uncaptured (2012-12-26) 1 commit
 - gitweb: fix error when highlight is enabled

 Will merge to 'next'.


* so/prompt-command (2012-12-26) 1 commit
  (merged to 'next' on 2012-12-26 at 27c5683)
 + make __git_ps1 accept a third parameter in pcmode

 Gives the same degree of customizability to the new prompt command
 mode users as the command substitution mode has.

 Will fast-track to 'master' before 1.8.1 final.

--------------------------------------------------
[Stalled]

* jc/doc-maintainer (2012-11-27) 1 commit
 - update "howto maintain git"

 An early draft that is still incomplete.


* fc/remote-bzr (2012-12-13) 10 commits
 - (fixup) test-bzr.sh: fix multi-line string assignment
 - remote-bzr: detect local repositories
 - remote-bzr: add support for older versions of bzr
 - remote-bzr: add support to push special modes
 - remote-bzr: add support for fecthing special modes
 - remote-bzr: add simple tests
 - remote-bzr: update working tree upon pushing
 - remote-bzr: add support for remote repositories
 - remote-bzr: add support for pushing
 - Add new remote-bzr transport helper

 New remote helper for bzr (v3).  With minor fixes, this may be ready
 for 'next'.


* mo/cvs-server-updates (2012-12-09) 18 commits
 - t9402: Use TABs for indentation
 - t9402: Rename check.cvsCount and check.list
 - t9402: Simplify git ls-tree
 - t9402: Add missing &&; Code style
 - t9402: No space after IO-redirection
 - t9402: Dont use test_must_fail cvs
 - t9402: improve check_end_tree() and check_end_full_tree()
 - t9402: sed -i is not portable
 - cvsserver Documentation: new cvs ... -r support
 - cvsserver: add t9402 to test branch and tag refs
 - cvsserver: support -r and sticky tags for most operations
 - cvsserver: Add version awareness to argsfromdir
 - cvsserver: generalize getmeta() to recognize commit refs
 - cvsserver: implement req_Sticky and related utilities
 - cvsserver: add misc commit lookup, file meta data, and file listing functions
 - cvsserver: define a tag name character escape mechanism
 - cvsserver: cleanup extra slashes in filename arguments
 - cvsserver: factor out git-log parsing logic

 Needs review by folks interested in cvsserver.


* as/check-ignore (2012-11-08) 14 commits
 - t0007: fix tests on Windows
 - Documentation/check-ignore: we show the deciding match, not the first
 - Add git-check-ignore sub-command
 - dir.c: provide free_directory() for reclaiming dir_struct memory
 - pathspec.c: move reusable code from builtin/add.c
 - dir.c: refactor treat_gitlinks()
 - dir.c: keep track of where patterns came from
 - dir.c: refactor is_path_excluded()
 - dir.c: refactor is_excluded()
 - dir.c: refactor is_excluded_from_list()
 - dir.c: rename excluded() to is_excluded()
 - dir.c: rename excluded_from_list() to is_excluded_from_list()
 - dir.c: rename path_excluded() to is_path_excluded()
 - dir.c: rename cryptic 'which' variable to more consistent name

 Duy helped to reroll this.

 Expecting a re-roll.


* aw/rebase-am-failure-detection (2012-10-11) 1 commit
 - rebase: Handle cases where format-patch fails

 I am unhappy a bit about the possible performance implications of
 having to store the output in a temporary file only for a rare case
 of format-patch aborting.


* jk/lua-hackery (2012-10-07) 6 commits
 - pretty: fix up one-off format_commit_message calls
 - Minimum compilation fixup
 - Makefile: make "lua" a bit more configurable
 - add a "lua" pretty format
 - add basic lua infrastructure
 - pretty: make some commit-parsing helpers more public

 Interesting exercise. When we do this for real, we probably would want
 to wrap a commit to make it more like an "object" with methods like
 "parents", etc.


* fc/remote-testgit-feature-done (2012-10-29) 1 commit
 - remote-testgit: properly check for errors

 Needs review and Ack (or Nack) from people involved in the remote
 helper interface for this to move forward.


* rc/maint-complete-git-p4 (2012-09-24) 1 commit
  (merged to 'next' on 2012-10-29 at af52cef)
 + Teach git-completion about git p4

 Comment from Pete will need to be addressed in a follow-up patch.


* jc/maint-name-rev (2012-09-17) 7 commits
 - describe --contains: use "name-rev --algorithm=weight"
 - name-rev --algorithm=weight: tests and documentation
 - name-rev --algorithm=weight: cache the computed weight in notes
 - name-rev --algorithm=weight: trivial optimization
 - name-rev: --algorithm option
 - name_rev: clarify the logic to assign a new tip-name to a commit
 - name-rev: lose unnecessary typedef

 "git name-rev" names the given revision based on a ref that can be
 reached in the smallest number of steps from the rev, but that is
 not useful when the caller wants to know which tag is the oldest one
 that contains the rev.  This teaches a new mode to the command that
 uses the oldest ref among those which contain the rev.

 I am not sure if this is worth it; for one thing, even with the help
 from notes-cache, it seems to make the "describe --contains" even
 slower. Also the command will be unusably slow for a user who does
 not have a write access (hence unable to create or update the
 notes-cache).

 Stalled mostly due to lack of responses.


* jc/xprm-generation (2012-09-14) 1 commit
 - test-generation: compute generation numbers and clock skews

 A toy to analyze how bad the clock skews are in histories of real
 world projects.

 Stalled mostly due to lack of responses.


* jc/blame-no-follow (2012-09-21) 2 commits
 - blame: pay attention to --no-follow
 - diff: accept --no-follow option

 Teaches "--no-follow" option to "git blame" to disable its
 whole-file rename detection.

 Stalled mostly due to lack of responses.


* jc/doc-default-format (2012-11-26) 2 commits
 - [SQAUSH] allow "cd Doc* && make DEFAULT_DOC_TARGET=..."
 - Allow generating a non-default set of documentation

 Need to address the installation half if this is to be any useful.


* jc/add-delete-default (2012-08-13) 1 commit
 - git add: notice removal of tracked paths by default

 "git add dir/" updated modified files and added new files, but does
 not notice removed files, which may be "Huh?" to some users.  They
 can of course use "git add -A dir/", but why should they?

 Resurrected from graveyard, as I thought it was a worthwhile thing
 to do in the longer term.

 Waiting for comments.


* mb/remote-default-nn-origin (2012-07-11) 6 commits
 - Teach get_default_remote to respect remote.default.
 - Test that plain "git fetch" uses remote.default when on a detached HEAD.
 - Teach clone to set remote.default.
 - Teach "git remote" about remote.default.
 - Teach remote.c about the remote.default configuration setting.
 - Rename remote.c's default_remote_name static variables.

 When the user does not specify what remote to interact with, we
 often attempt to use 'origin'.  This can now be customized via a
 configuration variable.

 Expecting a re-roll.

 "The first remote becomes the default" bit is better done as a
 separate step.

--------------------------------------------------
[Cooking]

* jc/merge-blobs (2012-12-26) 5 commits
 - merge-tree: fix d/f conflicts
 - merge-tree: add comments to clarify what these functions are doing
 - merge-tree: lose unused "resolve_directories"
 - merge-tree: lose unused "flags" from merge_list
 - Which merge_file() function do you mean?

 A beginning of a new merge strategy based on the disused merge-tree
 proof-of-concept code.


* mk/maint-graph-infinity-loop (2012-09-25) 1 commit
  (merged to 'next' on 2012-12-26 at 2ff59ab)
 + graph.c: infinite loop in git whatchanged --graph -m

 The --graph code fell into infinite loop when asked to do what the
 code did not expect ;-)


* jc/mkstemp-more-careful-error-reporting (2012-12-18) 1 commit
  (merged to 'next' on 2012-12-22 at 18cdaf0)
 + xmkstemp(): avoid showing truncated template more carefully

 An earlier patch to save original arguments to mkstemp() away and
 use it to report what filename we failed to create incorrectly used
 the buffer munged by failing mkstemp().


* jc/maint-test-portability (2012-12-19) 3 commits
  (merged to 'next' on 2012-12-22 at daeed53)
 + t4014: fix arguments to grep
 + t9502: do not assume GNU tar
 + t0200: "locale" may not exist
 (this branch is used by jc/test-portability.)

 Minor test fixes noticed while running our tests on OpenBSD 5.2,
 applicable to 'maint'.


* jc/test-portability (2012-12-19) 3 commits
  (merged to 'next' on 2012-12-22 at 123041b)
 + t9020: use configured Python to run the test helper
 + t3600: Avoid "cp -a", which is a GNUism
 + Merge branch 'jc/maint-test-portability' into 'jc/test-portability'
 (this branch uses jc/maint-test-portability.)

 The remainder of jc/maint-test-portability, applicable to 'master'.


* jc/maint-fnmatch-old-style-definition (2012-12-19) 1 commit
  (merged to 'next' on 2012-12-22 at 540df2c)
 + compat/fnmatch: update old-style definition to ANSI

 Update old-style function definition "int foo(bar) int bar; {}"
 to "int foo(int bar) {}".


* jk/pathspec-literal (2012-12-19) 1 commit
  (merged to 'next' on 2012-12-22 at c794bd6)
 + add global --literal-pathspecs option

 Allow scripts to feed literal paths to commands that take
 pathspecs, by disabling wildcard globbing.


* da/p4merge-mktemp (2012-12-21) 1 commit
  (merged to 'next' on 2012-12-26 at bb680a9)
 + mergetools/p4merge: Honor $TMPDIR for the /dev/null placeholder

 Create an empty file in $TMPDIR instead of using an empty file in
 the local directory.


* er/python-version-requirements (2012-12-25) 1 commit
 - Python scripts: check minimum compatible version after auditing

 Expecting a reroll.


* mb/gitweb-highlight-link-target (2012-12-20) 1 commit
 - Highlight the link target line in Gitweb using CSS

 Expecting a reroll.


* mz/oneway-merge-wo-u-no-lstat (2012-12-20) 1 commit
  (merged to 'next' on 2012-12-22 at 87bd30e)
 + oneway_merge(): only lstat() when told to update worktree

 Optimize "read-tree -m <tree-ish>" without "-u".


* jk/repack-ref-racefix (2012-12-21) 1 commit
  (merged to 'next' on 2012-12-22 at 03e1ca9)
 + refs: do not use cached refs in repack_without_ref

 Race-fix for pack-refs running in parallel to ref creation.


* rb/http-cert-cred-no-username-prompt (2012-12-21) 1 commit
  (merged to 'next' on 2012-12-22 at 9fc28ed)
 + http.c: Avoid username prompt for certifcate credentials

 It is wrong to ask for username if the authentication is done by
 certificate identity.


* wk/submodule-update-remote (2012-12-19) 3 commits
  (merged to 'next' on 2012-12-22 at 7ddf897)
 + submodule add: If --branch is given, record it in .gitmodules
 + submodule update: add --remote for submodule's upstream changes
 + submodule: add get_submodule_config helper funtion

 The beginning of 'integrate with the tip of the remote branch, not
 the commit recorded in the superproject gitlink' support.


* cc/no-gitk-build-dependency (2012-12-18) 3 commits
  (merged to 'next' on 2012-12-22 at da7b2cf)
 + Makefile: replace "echo 1>..." with "echo >..."
 + Makefile: detect when PYTHON_PATH changes
 + Makefile: remove tracking of TCLTK_PATH

 Remove leftover bits from an earlier change to move gitk in its own
 subdirectory.  Reimplementing the dependency tracking rules needs
 to be done in gitk history separately.


* jc/format-color-auto (2012-12-17) 2 commits
  (merged to 'next' on 2012-12-18 at 5aaac94)
 + log --format: teach %C(auto,black) to respect color config
 + t6006: clean up whitespace

 Introduce "log --format=%C(auto,blue)Foo%C(auto,reset)" that does
 not color its output when writing to a non-terminal.

 Will cook in 'next'.


* ss/svn-prompt (2012-12-17) 3 commits
  (merged to 'next' on 2012-12-26 at 1012ae2)
 + git-svn, perl/Git.pm: extend and use Git->prompt method for querying users
 + perl/Git.pm: Honor SSH_ASKPASS as fallback if GIT_ASKPASS is not set
 + git-svn, perl/Git.pm: add central method for prompting passwords

 Tweak the way "git svn" asks for password to be in line with the
 rest of the system, so that the same SSH/GIT_ASKPASS can be used.


* zk/clean-report-failure (2012-12-17) 1 commit
 - git-clean: Display more accurate delete messages

 "git clean" states what it is going to remove and then goes on to
 remove it, but sometimes it only discovers things that cannot be
 removed after recursing into a directory, which makes the output
 confusing and even wrong.

 Expecting a reroll.


* mp/complete-paths (2012-12-21) 1 commit
 - git-completion.bash: add support for path completion

 The completion script used to let the default completer to suggest
 pathnames, which gave too many irrelevant choices (e.g. "git add"
 would not want to add an unmodified path).  Teach it to use a more
 git-aware logic to enumerate only relevant ones.

 Waiting for area-experts' review.


* ja/directory-attrs (2012-12-17) 1 commit
  (merged to 'next' on 2012-12-17 at ced8e73)
 + Add directory pattern matching to attributes

 The attribute mechanism didn't allow limiting attributes to be
 applied to only a single directory itself with "path/" like the
 exclude mechanism does.

 Will cook in 'next'.


* jk/mailmap-from-blob (2012-12-13) 5 commits
  (merged to 'next' on 2012-12-17 at 14b7cdc)
 + mailmap: default mailmap.blob in bare repositories
 + mailmap: fix some documentation loose-ends for mailmap.blob
 + mailmap: clean up read_mailmap error handling
 + mailmap: support reading mailmap from blobs
 + mailmap: refactor mailmap parsing for non-file sources

 Allow us to read, and default to read, mailmap files from the tip
 of the history in bare repositories.  This will help running tools
 like shortlog in server settings.

 Will cook in 'next'.


* dm/port (2012-12-19) 4 commits
  (merged to 'next' on 2012-12-22 at 8adc198)
 + git-compat-util.h: do not #include <sys/param.h> by default
 + Generalize the inclusion of strings.h
 + Detect when the passwd struct is missing pw_gecos
 + Support builds when sys/param.h is missing
 (this branch is used by mk/qnx.)

 Add a few more knobs for new platform ports can tweak.


* jk/complete-commit-c (2012-12-15) 1 commit
  (merged to 'next' on 2012-12-18 at 75b5f21)
 + completion: complete refs for "git commit -c"

 Complete "git commmit -c foo<TAB>" into a refname that begins with
 "foo".

 Will cook in 'next'.


* jk/error-const-return (2012-12-15) 2 commits
  (merged to 'next' on 2012-12-22 at bf2b1cd)
 + silence some -Wuninitialized false positives
 + make error()'s constant return value more visible

 Help compilers' flow analysis by making it more explicit that
 error() always returns -1, to reduce false "variable used
 uninitialized" warnings.  Looks somewhat ugly but not too much.


* mk/qnx (2012-12-19) 2 commits
  (merged to 'next' on 2012-12-22 at 0473197)
 + Port to QNX
 + Make lock local to fetch_pack
 (this branch uses dm/port.)

 Port to QNX; we may want to rebase this on top of dm/port topic as
 it also wants to use the HAVE_STRINGS_H mechanism it introduces.


* as/test-tweaks (2012-12-20) 7 commits
  (merged to 'next' on 2012-12-22 at 7312c6c)
 + tests: paint unexpectedly fixed known breakages in bold red
 + tests: test the test framework more thoroughly
 + tests: refactor mechanics of testing in a sub test-lib
 + tests: change info messages from yellow/brown to cyan
 + tests: paint skipped tests in blue
 + tests: paint known breakages in yellow
 + tests: test number comes first in 'not ok $count - $message'

 Various minor tweaks to the test framework to paint its output
 lines in colors that match what they mean better.


* sp/shortlog-missing-lf (2012-12-11) 2 commits
  (merged to 'next' on 2012-12-11 at 64b8429)
 + strbuf_add_wrapped*(): Remove unused return value
 + shortlog: fix wrapping lines of wraplen

 When a line to be wrapped has a solid run of non space characters
 whose length exactly is the wrap width, "git shortlog -w" failed to
 add a newline after such a line.

 Will cook in 'next'.


* ap/log-mailmap (2012-12-26) 9 commits
 - log: add log.mailmap configuration option
 - log: grep author/committer using mailmap
 - test: Add test for --use-mailmap option
 - log: Add --use-mailmap option
 - pretty: Use mailmap to display username and email
 - mailmap: Add mailmap structure to rev_info and pp
 - mailmap: Simplify map_user() interface
 - mailmap: Remove buffer length limit in map_user
 - Use split_ident_line to parse author and committer

 Clean up various codepaths around mailmap and teach the "log"
 machinery to use it.

 I think this is almost ready for 'next' with minor fix-ups to avoid
 unnecessary copying.


* jc/fetch-ignore-symref (2012-12-11) 1 commit
  (merged to 'next' on 2012-12-17 at 370e2c8)
 + fetch: ignore wildcarded refspecs that update local symbolic refs

 Avoid false error from an attempt to update local symbolic ref via
 fetch.

 Will cook in 'next'.


* md/gitweb-sort-by-age (2012-12-11) 1 commit
  (merged to 'next' on 2012-12-13 at 9f39410)
 + gitweb: Sort projects with undefined ages last

 Gitweb showed repositories without any commit at the top in its
 age-sorted view, in which the users are interested in looking at
 active projects; sorting them at the bottom makes it more useful.

 Will cook in 'next'.


* ss/nedmalloc-compilation (2012-12-11) 1 commit
  (merged to 'next' on 2012-12-13 at c1f0d7f)
 + nedmalloc: Fix a compile warning (exposed as error) with GCC 4.7.2

 Will cook in 'next'.


* jc/maint-fbsd-sh-ifs-workaround (2012-12-10) 1 commit
  (merged to 'next' on 2012-12-11 at 6659fdc)
 + sh-setup: work around "unset IFS" bug in some shells

 Will cook in 'next'.


* jc/same-encoding (2012-12-10) 1 commit
  (merged to 'next' on 2012-12-17 at 86b41c7)
 + format_commit_message(): simplify calls to logmsg_reencode()

 Finishing touches to the series to unify "Do we need to reencode
 between these two encodings?" logic.

 Will cook in 'next'.


* nd/invalidate-i-t-a-cache-tree (2012-12-15) 4 commits
  (merged to 'next' on 2012-12-18 at 33e4488)
 + cache-tree: invalidate i-t-a paths after generating trees
 + cache-tree: fix writing cache-tree when CE_REMOVE is present
 + cache-tree: replace "for" loops in update_one with "while" loops
 + cache-tree: remove dead i-t-a code in verify_cache()

 Writing out a tree object when you still have intent-to-add entries
 in the index left an incorrect cache-tree data there.

 Will cook in 'next'.


* jl/submodule-deinit (2012-12-04) 1 commit
  (merged to 'next' on 2012-12-07 at ea772f0)
 + submodule: add 'deinit' command

 There was no Porcelain way to say "I no longer am interested in
 this submodule", once you express your interest in a submodule with
 "submodule init".  "submodule deinit" is the way to do so.

 Will cook in 'next'.


* pf/editor-ignore-sigint (2012-12-02) 5 commits
  (merged to 'next' on 2012-12-07 at 6b04419)
 + launch_editor: propagate signals from editor to git
 + run-command: do not warn about child death from terminal
 + launch_editor: ignore terminal signals while editor has control
 + launch_editor: refactor to use start/finish_command
 + run-command: drop silent_exec_failure arg from wait_or_whine

 Avoid confusing cases where the user hits Ctrl-C while in the editor
 session, not realizing git will receive the signal. Since most editors
 will take over the terminal and will block SIGINT, this is not likely
 to confuse anyone.

 Will cook in 'next'.


* bc/append-signed-off-by (2012-11-26) 11 commits
 - Unify appending signoff in format-patch, commit and sequencer
 - format-patch: update append_signoff prototype
 - format-patch: stricter S-o-b detection
 - t4014: more tests about appending s-o-b lines
 - sequencer.c: teach append_signoff to avoid adding a duplicate newline
 - sequencer.c: teach append_signoff how to detect duplicate s-o-b
 - sequencer.c: always separate "(cherry picked from" from commit body
 - sequencer.c: recognize "(cherry picked from ..." as part of s-o-b footer
 - t/t3511: add some tests of 'cherry-pick -s' functionality
 - t/test-lib-functions.sh: allow to specify the tag name to test_commit
 - sequencer.c: remove broken support for rfc2822 continuation in footer

 Expecting a re-roll after a review.


* mh/unify-xml-in-imap-send-and-http-push (2012-12-02) 8 commits
  (merged to 'next' on 2012-12-03 at d677090)
 + wrap_in_html(): process message in bulk rather than line-by-line
 + wrap_in_html(): use strbuf_addstr_xml_quoted()
 + imap-send: change msg_data from storing (ptr, len) to storing strbuf
 + imap-send: correctly report errors reading from stdin
 + imap-send: store all_msgs as a strbuf
 + lf_to_crlf(): NUL-terminate msg_data::data
 + xml_entities(): use function strbuf_addstr_xml_quoted()
 + Add new function strbuf_add_xml_quoted()

 Update imap-send to reuse xml quoting code from http-push codepath,
 clean up some code, and fix a small bug.

 Will cook in 'next'.


* jk/fsck-dot-in-trees (2012-11-28) 2 commits
  (merged to 'next' on 2012-11-28 at 519dabc)
 + fsck: warn about ".git" in trees
 + fsck: warn about '.' and '..' in trees

 Will cook in 'next'.


* mh/pthreads-autoconf (2012-11-27) 1 commit
  (merged to 'next' on 2012-11-28 at 780600e)
 + configure.ac: fix pthreads detection on Mac OS X

 Will cook in 'next'.


* jn/warn-on-inaccessible-loosen (2012-10-14) 4 commits
  (merged to 'next' on 2012-11-28 at 43d51c2)
 + config: exit on error accessing any config file
 + doc: advertise GIT_CONFIG_NOSYSTEM
 + config: treat user and xdg config permission problems as errors
 + config, gitignore: failure to access with ENOTDIR is ok

 An RFC to deal with a situation where .config/git is a file and we
 notice .config/git/config is not readable due to ENOTDIR, not
 ENOENT.

 Will cook in 'next'.


* mh/ceiling (2012-10-29) 8 commits
  (merged to 'next' on 2012-11-26 at d1ce76a)
 + string_list_longest_prefix(): remove function
 + setup_git_directory_gently_1(): resolve symlinks in ceiling paths
 + longest_ancestor_length(): require prefix list entries to be normalized
 + longest_ancestor_length(): take a string_list argument for prefixes
 + longest_ancestor_length(): use string_list_split()
 + Introduce new function real_path_if_valid()
 + real_path_internal(): add comment explaining use of cwd
 + Introduce new static function real_path_internal()

 Elements of GIT_CEILING_DIRECTORIES list may not match the real
 pathname we obtain from getcwd(), leading the GIT_DIR discovery
 logic to escape the ceilings the user thought to have specified.

 Resurrected from Stalled; the earlier performance fear was
 unwarranted.

 Will cook in 'next'.


* fc/fast-export-fixes (2012-12-03) 15 commits
  (merged to 'next' on 2012-12-03 at f9df523)
 + fast-export: make sure updated refs get updated
 + fast-export: don't handle uninteresting refs
 + fast-export: fix comparison in tests
 + fast-export: trivial cleanup
 + remote-testgit: implement the "done" feature manually
 + remote-testgit: report success after an import
 + remote-testgit: exercise more features
 + remote-testgit: cleanup tests
 + remote-testgit: remove irrelevant test
 + remote-testgit: remove non-local functionality
 + Add new simplified git-remote-testgit
 + Rename git-remote-testgit to git-remote-testpy
 + remote-helpers: fix failure message
 + remote-testgit: fix direction of marks
 + fast-export: avoid importing blob marks

 Will cook in 'next'.


* jc/apply-trailing-blank-removal (2012-10-12) 1 commit
  (merged to 'next' on 2012-11-26 at 3af69e7)
 + apply.c:update_pre_post_images(): the preimage can be truncated

 Fix to update_pre_post_images() that did not take into account the
 possibility that whitespace fix could shrink the preimage and
 change the number of lines in it.

 Will cook in 'next'.


* nd/pathspec-wildcard (2012-11-26) 4 commits
  (merged to 'next' on 2012-12-03 at eca0fcb)
 + tree_entry_interesting: do basedir compare on wildcard patterns when possible
 + pathspec: apply "*.c" optimization from exclude
 + pathspec: do exact comparison on the leading non-wildcard part
 + pathspec: save the non-wildcard length part

 Will cook in 'next'.


* nd/wildmatch (2012-12-15) 15 commits
  (merged to 'next' on 2012-12-15 at c734714)
 + t3070: Disable some failing fnmatch tests
  (merged to 'next' on 2012-11-21 at 151288f)
 + test-wildmatch: avoid Windows path mangling
  (merged to 'next' on 2012-10-25 at 510e8df)
 + Support "**" wildcard in .gitignore and .gitattributes
 + wildmatch: make /**/ match zero or more directories
 + wildmatch: adjust "**" behavior
 + wildmatch: fix case-insensitive matching
 + wildmatch: remove static variable force_lower_case
 + wildmatch: make wildmatch's return value compatible with fnmatch
 + t3070: disable unreliable fnmatch tests
 + Integrate wildmatch to git
 + wildmatch: follow Git's coding convention
 + wildmatch: remove unnecessary functions
 + Import wildmatch from rsync
 + ctype: support iscntrl, ispunct, isxdigit and isprint
 + ctype: make sane_ctype[] const array
 (this branch is used by nd/retire-fnmatch.)

 Allows pathname patterns in .gitignore and .gitattributes files
 with double-asterisks "foo/**/bar" to match any number of directory
 hierarchies.

 I suspect that this needs to be plugged to pathspec matching code;
 otherwise "git log -- 'Docum*/**/*.txt'" would not show the log for
 commits that touch Documentation/git.txt, which would be confusing
 to the users.

 Will cook in 'next'.


* cr/push-force-tag-update (2012-12-03) 10 commits
  (merged to 'next' on 2012-12-04 at af2e3a9)
 + push: allow already-exists advice to be disabled
 + push: rename config variable for more general use
 + push: cleanup push rules comment
 + push: clarify rejection of update to non-commit-ish
 + push: require force for annotated tags
 + push: require force for refs under refs/tags/
 + push: flag updates that require force
 + push: keep track of "update" state separately
 + push: add advice for rejected tag reference
 + push: return reject reasons as a bitset

 Require "-f" for push to update a tag, even if it is a fast-forward.

 Will cook in 'next'.

--------------------------------------------------
[Discarded]

* jc/unpack-file-in-tmpdir (2012-12-19) 1 commit
 . unpack-file: allow output to be in $TMPDIR

 Throw-away "how about this" to teach unpack-file to use $TMPDIR to
 store its output.

 Discarded, as da/p4merge-mktemp was rewritten not to require mktemp.


* rj/maint-cygwin-say-color (2012-12-15) 1 commit
 . tests: Allow customization of how say_color() prints

 Even though I do not think of a cleaner way to do this, I am not
 happy with the way how $GIT_TEST_PRINT and $GIT_TEST_PRINT_LN are
 interpolated into the command line with token splitting at $IFS.

 Discarded, per discussion with the author.
